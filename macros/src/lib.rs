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
//! - `#[map("from" => "to", ..)]` on that `impl` block: a lowering generated whole. Without
//!   `via`, the one-to-one rewrite (`fastmath` / `overflow` attributes converted for llvm, `fp`
//!   failing on unsupported floats, `unconstrained` without a rounding mode, `scalar` not
//!   unrolling vectors); with `via = template(args..)`, a call of the family's template
//!   `template(cr, op, operands, "to", [opts,] args..)`. The impl also gets `ROOTS`.
//! - With `builder = ctor` on `#[patterns]`, a `#[lowering]` method whose first parameter is
//!   not `cr` is declared by its signature: it takes the builder `ctor(cr, op)`, the
//!   operands as `ValueId`s in order and anything else `FromOp` gives, and returns what
//!   replaces the op (`Replacement`).

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
    builder: Option<Expr>,
    params: Vec<(Ident, Type)>,
}

impl Parse for PatternsArgs {
    fn parse(input: ParseStream) -> syn::Result<Self> {
        let mut args = PatternsArgs { converter: false, options: None, extra: None, builder: None, params: Vec::new() };
        while !input.is_empty() {
            let id: Ident = input.parse()?;
            if input.parse::<Option<Token![:]>>()?.is_some() {
                args.params.push((id, input.parse()?));
            } else if input.parse::<Option<Token![=]>>()?.is_some() {
                match id.to_string().as_str() {
                    "options" => args.options = Some(input.parse()?),
                    "extra" => args.extra = Some(input.parse()?),
                    "builder" => args.builder = Some(input.parse()?),
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

/// An impl's `#[map("from" => "to", flags.., benefit = n, when = expr, via = template)]`.
struct MapArgs {
    from: LitStr,
    to: LitStr,
    flags: Vec<Ident>,
    benefit: Option<LitInt>,
    when: Option<Expr>,
    via: Option<Expr>,
}

impl Parse for MapArgs {
    fn parse(input: ParseStream) -> syn::Result<Self> {
        let from: LitStr = input.parse()?;
        input.parse::<Token![=>]>()?;
        let to: LitStr = input.parse()?;
        let mut args = MapArgs { from, to, flags: Vec::new(), benefit: None, when: None, via: None };
        while input.parse::<Option<Token![,]>>()?.is_some() && !input.is_empty() {
            let k: Ident = input.parse()?;
            if input.parse::<Option<Token![=]>>()?.is_none() {
                match k.to_string().as_str() {
                    "fastmath" | "overflow" | "fp" | "scalar" | "unconstrained" | "untyped" => args.flags.push(k),
                    o => return Err(syn::Error::new(k.span(), format!("unknown #[map] flag `{o}`"))),
                }
                continue;
            }
            match k.to_string().as_str() {
                "benefit" => args.benefit = Some(input.parse()?),
                "when" => args.when = Some(input.parse()?),
                "via" => args.via = Some(input.parse()?),
                o => return Err(syn::Error::new(k.span(), format!("unknown #[map] argument `{o}`"))),
            }
        }
        Ok(args)
    }
}

impl MapArgs {
    fn has(&self, f: &str) -> bool {
        self.flags.iter().any(|x| x == f)
    }

    /// The body of the lowering this row is: a call of its template, or the one-to-one
    /// rewrite itself.
    fn body(&self, opts: bool) -> Tokens {
        let to = &self.to;
        let o = opts.then(|| quote!(opts,));
        if let Some(via) = &self.via {
            return match via {
                Expr::Call(c) => {
                    let (f, a) = (&c.func, c.args.iter());
                    quote!(#f(cr, op, operands, #to, #o #(#a),*))
                }
                e => quote!(#e(cr, op, operands, #to, #o)),
            };
        }
        let unconstrained = self.has("unconstrained").then(|| quote! {
            if cr.rw.body[op].get("roundingmode").is_some() {
                return false;
            }
        });
        let fp = self.has("fp").then(|| quote! {
            if cr.unsupported_fp_op(op) {
                return false;
            }
        });
        let fastmath = self.has("fastmath").then(|| quote!(crate::ConversionRewriter::fastmath_to_llvm(&mut attrs);));
        let overflow = self.has("overflow").then(|| quote!(crate::ConversionRewriter::overflow_to_llvm(&mut attrs);));
        let rewrite = if self.has("scalar") { quote!(cr.one_to_one_rewrite(op, #to, &ops, &attrs)) } else { quote!(cr.vector_one_to_one(op, #to, &ops, &attrs)) };
        quote! {
            #unconstrained
            #fp
            let Some(ops) = crate::ConversionRewriter::one_to_one(operands) else { return false };
            #[allow(unused_mut)]
            let mut attrs = cr.all_attrs(op);
            #fastmath
            #overflow
            #rewrite
        }
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
    let mut maps = Vec::new();
    let mut kept = Vec::new();
    for a in core::mem::take(&mut imp.attrs) {
        if a.path().is_ident("map") {
            match a.parse_args::<MapArgs>() {
                Ok(m) => maps.push(m),
                Err(e) => return e.to_compile_error().into(),
            }
        } else {
            kept.push(a);
        }
    }
    imp.attrs = kept;
    let mut adds = Vec::new();
    let mut roots: Vec<LitStr> = Vec::new();
    let mut typed_fns: Vec<ImplItem> = Vec::new();
    for it in imp.items.iter_mut() {
        let ImplItem::Fn(m) = it else { continue };
        let Some(pos) = m.attrs.iter().position(|a| a.path().is_ident("lowering")) else { continue };
        let a = m.attrs.remove(pos);
        let l: LoweringArgs = match a.parse_args() {
            Ok(l) => l,
            Err(e) => return e.to_compile_error().into(),
        };
        let typed = args.builder.is_some()
            && match m.sig.inputs.first() {
                Some(syn::FnArg::Typed(t)) => !matches!(&*t.pat, syn::Pat::Ident(i) if i.ident == "cr"),
                _ => false,
            };
        let f = if typed {
            let Some(builder) = &args.builder else {
                return syn::Error::new_spanned(&m.sig, "a typed #[lowering] needs #[patterns(builder = ..)]").to_compile_error().into();
            };
            let name = &m.sig.ident;
            let w = format_ident!("__typed_{}", name);
            let mut n = 0usize;
            let mut fetch = Vec::new();
            let mut args_v = Vec::new();
            for (k, a) in m.sig.inputs.iter().enumerate().skip(1) {
                let syn::FnArg::Typed(t) = a else { continue };
                let v = format_ident!("__a{}", k);
                if matches!(&*t.ty, Type::Path(p) if p.path.is_ident("ValueId")) {
                    fetch.push(quote!(let #v = *__ops.get(#n)?;));
                    n += 1;
                } else {
                    let ty = &t.ty;
                    fetch.push(quote!(let #v = <#ty as crate::lower::FromOp>::from_op(cr, op);));
                }
                args_v.push(v);
            }
            typed_fns.push(syn::parse_quote! {
                fn #w(cr: &mut crate::ConversionRewriter<'_, '_, '_>, op: crate::OpId, operands: &[alloc::vec::Vec<crate::ValueId>]) -> bool {
                    let run = |cr: &mut crate::ConversionRewriter<'_, '_, '_>| -> Option<bool> {
                        let __ops = crate::ConversionRewriter::one_to_one(operands)?;
                        #(#fetch)*
                        let __r = {
                            let mut __b = #builder(cr, op);
                            Self::#name(&mut __b, #(#args_v),*)
                        };
                        Some(crate::lower::Replacement::replace(__r, cr, op))
                    };
                    run(cr).unwrap_or(false)
                }
            });
            w
        } else {
            m.sig.ident.clone()
        };
        let f = &f;
        let benefit = l.benefit.map_or_else(|| quote!(1), |b| quote!(#b));
        let add = if args.converter && !l.untyped { quote!(patterns.add_with(tc, l)) } else { quote!(patterns.add(l)) };
        let when = l.when.map_or_else(|| quote!(true), |w| quote!(#w));
        for root in &l.roots {
            if !roots.iter().any(|r| r.value() == root.value()) {
                roots.push(root.clone());
            }
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
    imp.items.extend(typed_fns);
    let opts_ty = args.options.clone();
    for (i, m) in maps.iter().enumerate() {
        let f = format_ident!("__map{}", i);
        let body = m.body(opts_ty.is_some());
        let opt_param = opts_ty.as_ref().map(|t| quote!(opts: #t,));
        let doc = format!("`{}` ⇒ `{}`.", m.from.value(), m.to.value());
        imp.items.push(syn::parse_quote! {
            #[doc = #doc]
            fn #f(cr: &mut crate::ConversionRewriter<'_, '_, '_>, op: crate::OpId, operands: &[alloc::vec::Vec<crate::ValueId>], #opt_param) -> bool {
                let _ = operands;
                #body
            }
        });
        let from = &m.from;
        if !roots.iter().any(|r| r.value() == from.value()) {
            roots.push(from.clone());
        }
        let benefit = m.benefit.as_ref().map_or_else(|| quote!(1), |b| quote!(#b));
        let when = m.when.as_ref().map_or_else(|| quote!(true), |w| quote!(#w));
        let make = if opts_ty.is_some() {
            quote!(crate::lower::OptLowering { root: #from, opts, f: Self::#f })
        } else {
            quote!(crate::lower::Lowering { root: #from, benefit: #benefit, f: Self::#f })
        };
        let add = if args.converter && !m.has("untyped") { quote!(patterns.add_with(tc, l)) } else { quote!(patterns.add(l)) };
        adds.push(quote! {
            if #when {
                let l = #make;
                #add;
            }
        });
    }
    imp.items.push(syn::parse_quote! {
        /// Every root the patterns above lower.
        pub const ROOTS: &'static [&'static str] = &[#(#roots),*];
    });
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

/// `#[ops(b, fmf = expr)]`'s arguments.
struct OpsArgs {
    b: Expr,
    fmf: Option<Expr>,
}

impl Parse for OpsArgs {
    fn parse(input: ParseStream) -> syn::Result<Self> {
        let b: Expr = input.parse()?;
        let mut args = OpsArgs { b, fmf: None };
        while input.parse::<Option<Token![,]>>()?.is_some() && !input.is_empty() {
            let k: Ident = input.parse()?;
            input.parse::<Token![=]>()?;
            match k.to_string().as_str() {
                "fmf" => args.fmf = Some(input.parse()?),
                o => return Err(syn::Error::new(k.span(), format!("unknown #[ops] argument `{o}`"))),
            }
        }
        Ok(args)
    }
}

/// The `#[ops]` rewrite: operators become op builders, each operand evaluated into a
/// temporary first, left to right, so ops are created in the order C++ argument evaluation
/// creates them.
struct OpsRewrite {
    b: Expr,
    fmf: Option<Expr>,
    next: usize,
}

impl OpsRewrite {
    fn temp(&mut self, e: Expr, pre: &mut Vec<syn::Stmt>) -> Expr {
        let t = format_ident!("__op{}", self.next);
        self.next += 1;
        pre.push(syn::parse_quote!(let #t = #e;));
        syn::parse_quote!(#t)
    }

    /// An operand: kept when it is a name, else evaluated into a temporary now.
    fn operand(&mut self, e: Expr, pre: &mut Vec<syn::Stmt>) -> Expr {
        let e = self.expr(e, pre);
        match &e {
            Expr::Path(_) => e,
            Expr::Lit(l) if !matches!(l.lit, syn::Lit::Float(_)) => e,
            _ => self.temp(e, pre),
        }
    }

    fn call(&mut self, method: &str, args: Vec<Expr>, fmf: bool, pre: &mut Vec<syn::Stmt>) -> Expr {
        let b = &self.b;
        let m = format_ident!("{}", method);
        let f = if fmf { self.fmf.as_ref().map(|f| quote!(, #f)) } else { None };
        let e: Expr = syn::parse_quote!(#b.#m(#(#args),* #f));
        self.temp(e, pre)
    }

    fn expr(&mut self, e: Expr, pre: &mut Vec<syn::Stmt>) -> Expr {
        use syn::{BinOp, UnOp};
        match e {
            Expr::Binary(bin) => {
                let (method, fmf) = match bin.op {
                    BinOp::Add(_) => ("add", true),
                    BinOp::Sub(_) => ("sub", true),
                    BinOp::Mul(_) => ("mul", true),
                    BinOp::Div(_) => ("div", true),
                    BinOp::Rem(_) => ("rem", true),
                    BinOp::BitAnd(_) => ("and", false),
                    BinOp::BitOr(_) => ("or", false),
                    BinOp::BitXor(_) => ("xor", false),
                    _ => {
                        let mut bin = bin;
                        *bin.left = self.expr(*bin.left, pre);
                        *bin.right = self.expr(*bin.right, pre);
                        return Expr::Binary(bin);
                    }
                };
                let l = self.operand(*bin.left, pre);
                let r = self.operand(*bin.right, pre);
                self.call(method, vec![l, r], fmf, pre)
            }
            Expr::Unary(u) if matches!(u.op, UnOp::Neg(_)) => {
                if let Expr::Lit(l) = &*u.expr
                    && matches!(l.lit, syn::Lit::Float(_))
                {
                    let lit = &l.lit;
                    return self.call("cst", vec![syn::parse_quote!(-#lit)], false, pre);
                }
                let x = self.operand(*u.expr, pre);
                self.call("neg", vec![x], true, pre)
            }
            Expr::Unary(mut u) => {
                *u.expr = self.expr(*u.expr, pre);
                Expr::Unary(u)
            }
            Expr::Lit(l) if matches!(l.lit, syn::Lit::Float(_)) => self.call("cst", vec![Expr::Lit(l)], false, pre),
            Expr::Paren(p) => self.expr(*p.expr, pre),
            Expr::Call(c) if matches!(&*c.func, Expr::Path(p) if p.path.is_ident("fm")) && c.args.len() == 2 => {
                let mut args = c.args.into_iter();
                let f = args.next().expect("fmf");
                let saved = self.fmf.replace(f);
                let v = self.expr(args.next().expect("expr"), pre);
                self.fmf = saved;
                v
            }
            Expr::Call(mut c) => {
                c.args = c.args.into_iter().map(|a| self.expr(a, pre)).collect();
                Expr::Call(c)
            }
            Expr::MethodCall(mut m) => {
                *m.receiver = self.expr(*m.receiver, pre);
                m.args = m.args.into_iter().map(|a| self.expr(a, pre)).collect();
                Expr::MethodCall(m)
            }
            Expr::Tuple(mut t) => {
                t.elems = t.elems.into_iter().map(|a| self.operand(a, pre)).collect();
                Expr::Tuple(t)
            }
            Expr::Array(mut t) => {
                t.elems = t.elems.into_iter().map(|a| self.operand(a, pre)).collect();
                Expr::Array(t)
            }
            Expr::Reference(mut r) => {
                *r.expr = self.expr(*r.expr, pre);
                Expr::Reference(r)
            }
            Expr::Assign(mut a) => {
                *a.right = self.expr(*a.right, pre);
                Expr::Assign(a)
            }
            Expr::Return(mut r) => {
                r.expr = r.expr.map(|x| Box::new(self.expr(*x, pre)));
                Expr::Return(r)
            }
            Expr::If(mut i) => {
                *i.cond = self.expr(*i.cond, pre);
                self.block(&mut i.then_branch);
                if let Some((_, e)) = &mut i.else_branch {
                    let inner = core::mem::replace(&mut **e, syn::parse_quote!(()));
                    **e = self.nested(inner);
                }
                Expr::If(i)
            }
            Expr::Block(mut bl) => {
                self.block(&mut bl.block);
                Expr::Block(bl)
            }
            Expr::Match(mut m) => {
                *m.expr = self.expr(*m.expr, pre);
                for arm in m.arms.iter_mut() {
                    let body = core::mem::replace(&mut *arm.body, syn::parse_quote!(()));
                    *arm.body = self.nested(body);
                }
                Expr::Match(m)
            }
            Expr::Closure(mut c) => {
                let body = core::mem::replace(&mut *c.body, syn::parse_quote!(()));
                *c.body = self.nested(body);
                Expr::Closure(c)
            }
            other => other,
        }
    }

    /// An expression evaluated in its own scope (a branch, an arm, a closure body).
    fn nested(&mut self, e: Expr) -> Expr {
        if let Expr::Block(mut b) = e {
            self.block(&mut b.block);
            return Expr::Block(b);
        }
        if let Expr::If(_) = e {
            let mut pre = Vec::new();
            return self.expr(e, &mut pre);
        }
        let mut pre = Vec::new();
        let v = self.expr(e, &mut pre);
        if pre.is_empty() {
            return v;
        }
        syn::parse_quote!({ #(#pre)* #v })
    }

    fn block(&mut self, b: &mut syn::Block) {
        let mut out = Vec::new();
        for s in core::mem::take(&mut b.stmts) {
            let mut pre = Vec::new();
            let s = match s {
                syn::Stmt::Local(mut l) => {
                    if let Some(init) = &mut l.init {
                        let e = core::mem::replace(&mut *init.expr, syn::parse_quote!(()));
                        *init.expr = self.expr(e, &mut pre);
                        if let Some((_, d)) = &mut init.diverge {
                            let e = core::mem::replace(&mut **d, syn::parse_quote!(()));
                            **d = self.nested(e);
                        }
                    }
                    syn::Stmt::Local(l)
                }
                syn::Stmt::Expr(e, semi) => syn::Stmt::Expr(self.expr(e, &mut pre), semi),
                other => other,
            };
            out.extend(pre);
            out.push(s);
        }
        b.stmts = out;
    }
}

/// `#[ops(b, fmf = f)]` on a fn: its arithmetic builds ops through `b` (see `OpsRewrite`):
/// `+ - * / %` call `b.add(l, r, f)`.., unary `-` `b.neg(x, f)`, `& | ^` `b.and(l, r)`..,
/// float literals `b.cst(x)`; `fm(g, expr)` builds `expr` with flags `g`. Code meant as plain
/// Rust goes in a macro call (`plain!(..)`), which is left alone.
#[proc_macro_attribute]
pub fn ops(attr: TokenStream, item: TokenStream) -> TokenStream {
    let args = parse_macro_input!(attr as OpsArgs);
    let mut f = parse_macro_input!(item as ItemFn);
    let mut rw = OpsRewrite { b: args.b, fmf: args.fmf, next: 0 };
    rw.block(&mut f.block);
    quote!(#f).into()
}
