//! Proc macros for mlirpass: passes and pattern sets are declared where they are written.
//!
//! - `#[pass("name", on = "op", extra = ["opt", ..])]` on a struct: its `mlir-opt` name, the op it
//!   is anchored on, and its options (fields marked `#[opt("key", default = expr)]`, read with
//!   `OptionValue`, or with `FromStr` when marked `from_str`); `check = path` validates the
//!   result (`fn(&Self) -> Result<(), Error>`). Generates `PassDecl` and `TryFrom<&Options>`;
//!   the struct implements `Run`, and is a `Pass` through it.
//! - The same on a `fn(body, op) -> Result<(), Error>`: a unit pass struct (the name in
//!   CamelCase, or `ty = Name`) whose `Run` is that body.
//! - `#[patterns(converter, flag: bool, ..)]` on an `impl` block: each method marked
//!   `#[lowering("root", .., benefit = n, when = expr, untyped)]` goes into a generated
//!   `populate(patterns, [tc,] [opts,] flags..)`, in declaration order. `options = Type`: the
//!   methods also take `opts` (`OptLowering`; `plain` opts one out); `extra = path` is called
//!   last with the same arguments, for patterns that are not methods.

use proc_macro::TokenStream;
use proc_macro2::{Span, TokenStream as Tokens};
use quote::{format_ident, quote};
use syn::parse::{Parse, ParseStream, Parser};
use syn::punctuated::Punctuated;
use syn::{Expr, Fields, Ident, ImplItem, Item, ItemFn, ItemImpl, ItemStruct, LitInt, LitStr, Token, Type, bracketed, parse_macro_input};

/// `#[pass(..)]`'s arguments.
struct PassArgs {
    name: LitStr,
    on: Option<LitStr>,
    extra: Vec<LitStr>,
    ty: Option<Ident>,
    check: Option<Expr>,
}

impl Parse for PassArgs {
    fn parse(input: ParseStream) -> syn::Result<Self> {
        let name: LitStr = input.parse()?;
        let mut args = PassArgs { name, on: None, extra: Vec::new(), ty: None, check: None };
        while input.parse::<Option<Token![,]>>()?.is_some() && !input.is_empty() {
            let key: Ident = input.parse()?;
            input.parse::<Token![=]>()?;
            match key.to_string().as_str() {
                "on" => args.on = Some(input.parse()?),
                "ty" => args.ty = Some(input.parse()?),
                "check" => args.check = Some(input.parse()?),
                "extra" => {
                    let content;
                    bracketed!(content in input);
                    args.extra = Punctuated::<LitStr, Token![,]>::parse_terminated(&content)?.into_iter().collect();
                }
                k => return Err(syn::Error::new(key.span(), format!("unknown #[pass] argument `{k}`"))),
            }
        }
        Ok(args)
    }
}

/// A field's `#[opt("key", default = expr, from_str)]`.
struct OptArgs {
    key: LitStr,
    default: Option<Expr>,
    from_str: bool,
}

impl Parse for OptArgs {
    fn parse(input: ParseStream) -> syn::Result<Self> {
        let key: LitStr = input.parse()?;
        let mut args = OptArgs { key, default: None, from_str: false };
        while input.parse::<Option<Token![,]>>()?.is_some() && !input.is_empty() {
            let k: Ident = input.parse()?;
            match k.to_string().as_str() {
                "default" => {
                    input.parse::<Token![=]>()?;
                    args.default = Some(input.parse()?);
                }
                "from_str" => args.from_str = true,
                o => return Err(syn::Error::new(k.span(), format!("unknown #[opt] argument `{o}`"))),
            }
        }
        Ok(args)
    }
}

/// `convert-scf-to-cf` ⇒ `ConvertScfToCf`.
fn camel(name: &str) -> Ident {
    let s: String = name.split(['-', '_']).map(|w| {
        let mut c = w.chars();
        c.next().map_or_else(String::new, |f| f.to_uppercase().chain(c).collect())
    }).collect();
    Ident::new(&s, Span::call_site())
}

/// `PassDecl` for `ty`.
fn decl(ty: &Ident, args: &PassArgs) -> Tokens {
    let name = &args.name;
    let on = match &args.on {
        Some(o) => quote!(Some(#o)),
        None => quote!(None),
    };
    quote! {
        impl crate::PassDecl for #ty {
            const NAME: &'static str = #name;
            const ANCHOR: Option<&'static str> = #on;
        }
    }
}

/// `#[pass("name", on = "op", extra = [..])]`: see the crate docs.
#[proc_macro_attribute]
pub fn pass(attr: TokenStream, item: TokenStream) -> TokenStream {
    let args = parse_macro_input!(attr as PassArgs);
    match parse_macro_input!(item as Item) {
        Item::Struct(s) => pass_struct(&args, s),
        Item::Fn(f) => pass_fn(&args, f),
        other => syn::Error::new_spanned(other, "#[pass] goes on a struct or a fn").to_compile_error(),
    }
    .into()
}

fn pass_struct(args: &PassArgs, mut s: ItemStruct) -> Tokens {
    let ty = s.ident.clone();
    let name = &args.name;
    let mut keys: Vec<LitStr> = Vec::new();
    let mut inits = Vec::new();
    let unit = matches!(s.fields, Fields::Unit);
    if let Fields::Named(fields) = &mut s.fields {
        for f in fields.named.iter_mut() {
            let id = f.ident.clone().expect("named");
            let fty = &f.ty;
            let pos = f.attrs.iter().position(|a| a.path().is_ident("opt"));
            let Some(pos) = pos else {
                inits.push(quote!(#id: Default::default()));
                continue;
            };
            let a = f.attrs.remove(pos);
            let o: OptArgs = match a.parse_args() {
                Ok(o) => o,
                Err(e) => return e.to_compile_error(),
            };
            let key = &o.key;
            let default = o.default.as_ref().map_or_else(|| quote!(Default::default()), |d| quote!(#d));
            keys.push(key.clone());
            inits.push(if o.from_str {
                quote!(#id: o.value::<#fty>(#key, #default)?)
            } else {
                quote!(#id: <#fty as crate::OptionValue>::read(o, #key, #default)?)
            });
        }
    }
    keys.extend(args.extra.iter().cloned());
    let build = if unit { quote!(Self) } else { quote!(Self { #(#inits),* }) };
    let check = args.check.as_ref().map(|c| quote!(#c(&made)?;));
    let d = decl(&ty, args);
    quote! {
        #s
        #d
        impl TryFrom<&crate::Options<'_>> for #ty {
            type Error = mlirformat::Error;
            fn try_from(o: &crate::Options<'_>) -> Result<Self, mlirformat::Error> {
                o.only(#name, &[#(#keys),*])?;
                let made = #build;
                #check
                Ok(made)
            }
        }
    }
}

fn pass_fn(args: &PassArgs, f: ItemFn) -> Tokens {
    let ty = args.ty.clone().unwrap_or_else(|| camel(&args.name.value()));
    let name = &args.name;
    let keys = &args.extra;
    let (vis, sig, block, attrs) = (&f.vis, &f.sig, &f.block, &f.attrs);
    let inputs = &sig.inputs;
    let output = &sig.output;
    let generics = &sig.generics;
    let d = decl(&ty, args);
    let doc = format!("`{}`.", args.name.value());
    quote! {
        #[doc = #doc]
        #vis struct #ty;
        #d
        impl TryFrom<&crate::Options<'_>> for #ty {
            type Error = mlirformat::Error;
            fn try_from(o: &crate::Options<'_>) -> Result<Self, mlirformat::Error> {
                o.only(#name, &[#(#keys),*])?;
                Ok(Self)
            }
        }
        impl crate::Run for #ty {
            #(#attrs)*
            fn run #generics (&self, #inputs) #output #block
        }
    }
}

/// `#[patterns(..)]`'s arguments: `converter`, `options = Type`, `extra = path`, and
/// `flag: Type` populate parameters.
struct PatternsArgs {
    converter: bool,
    options: Option<Type>,
    extra: Option<Expr>,
    params: Vec<(Ident, Type)>,
}

impl Parse for PatternsArgs {
    fn parse(input: ParseStream) -> syn::Result<Self> {
        let mut args = PatternsArgs { converter: false, options: None, extra: None, params: Vec::new() };
        while !input.is_empty() {
            let id: Ident = input.parse()?;
            if input.parse::<Option<Token![:]>>()?.is_some() {
                args.params.push((id, input.parse()?));
            } else if input.parse::<Option<Token![=]>>()?.is_some() {
                match id.to_string().as_str() {
                    "options" => args.options = Some(input.parse()?),
                    "extra" => args.extra = Some(input.parse()?),
                    o => return Err(syn::Error::new(id.span(), format!("unknown #[patterns] argument `{o}`"))),
                }
            } else if id == "converter" {
                args.converter = true;
            } else {
                return Err(syn::Error::new(id.span(), format!("unknown #[patterns] argument `{id}`")));
            }
            if input.parse::<Option<Token![,]>>()?.is_none() {
                break;
            }
        }
        Ok(args)
    }
}

/// A method's `#[lowering("root", .., benefit = n, when = expr, untyped)]`.
struct LoweringArgs {
    roots: Vec<LitStr>,
    benefit: Option<LitInt>,
    when: Option<Expr>,
    untyped: bool,
    plain: bool,
}

impl Parse for LoweringArgs {
    fn parse(input: ParseStream) -> syn::Result<Self> {
        let mut args = LoweringArgs { roots: Vec::new(), benefit: None, when: None, untyped: false, plain: false };
        while !input.is_empty() {
            if input.peek(LitStr) {
                args.roots.push(input.parse()?);
            } else {
                let k: Ident = input.parse()?;
                match k.to_string().as_str() {
                    "benefit" => {
                        input.parse::<Token![=]>()?;
                        args.benefit = Some(input.parse()?);
                    }
                    "when" => {
                        input.parse::<Token![=]>()?;
                        args.when = Some(input.parse()?);
                    }
                    "untyped" => args.untyped = true,
                    "plain" => args.plain = true,
                    o => return Err(syn::Error::new(k.span(), format!("unknown #[lowering] argument `{o}`"))),
                }
            }
            if input.parse::<Option<Token![,]>>()?.is_none() {
                break;
            }
        }
        Ok(args)
    }
}

/// `#[patterns(..)]`: see the crate docs.
#[proc_macro_attribute]
pub fn patterns(attr: TokenStream, item: TokenStream) -> TokenStream {
    let args = match PatternsArgs::parse.parse(attr) {
        Ok(a) => a,
        Err(e) => return e.to_compile_error().into(),
    };
    let mut imp = parse_macro_input!(item as ItemImpl);
    let mut adds = Vec::new();
    for it in imp.items.iter_mut() {
        let ImplItem::Fn(m) = it else { continue };
        let Some(pos) = m.attrs.iter().position(|a| a.path().is_ident("lowering")) else { continue };
        let a = m.attrs.remove(pos);
        let l: LoweringArgs = match a.parse_args() {
            Ok(l) => l,
            Err(e) => return e.to_compile_error().into(),
        };
        let f = &m.sig.ident;
        let benefit = l.benefit.map_or_else(|| quote!(1), |b| quote!(#b));
        let add = if args.converter && !l.untyped { quote!(patterns.add_with(tc, l)) } else { quote!(patterns.add(l)) };
        let when = l.when.map_or_else(|| quote!(true), |w| quote!(#w));
        for root in &l.roots {
            let make = if args.options.is_some() && !l.plain {
                quote!(crate::lower::OptLowering { root: #root, opts, f: Self::#f })
            } else {
                quote!(crate::lower::Lowering { root: #root, benefit: #benefit, f: Self::#f })
            };
            adds.push(quote! {
                if #when {
                    let l = #make;
                    #add;
                }
            });
        }
    }
    let tc = args.converter.then(|| quote!(tc: usize,));
    let opts = args.options.as_ref().map(|t| quote!(opts: #t,));
    let names: Vec<&Ident> = args.params.iter().map(|p| &p.0).collect();
    let params: Vec<Tokens> = args.params.iter().map(|(n, t)| quote!(#n: #t)).collect();
    let extra = args.extra.as_ref().map(|e| {
        let tcv = args.converter.then(|| quote!(tc,));
        let ov = args.options.as_ref().map(|_| quote!(opts,));
        quote!(#e(patterns, #tcv #ov #(#names),*);)
    });
    let unused = [args.converter.then(|| quote!(let _ = tc;)), args.options.as_ref().map(|_| quote!(let _ = &opts;))];
    let populate = format_ident!("populate");
    imp.items.push(syn::parse_quote! {
        /// The patterns declared by `#[lowering]` above, in order.
        pub fn #populate<'p>(patterns: &mut crate::ConversionPatterns<'p>, #tc #opts #(#params),*) {
            #(#unused)*
            #(let _ = &#names;)*
            #(#adds)*
            #extra
        }
    });
    quote!(#imp).into()
}
