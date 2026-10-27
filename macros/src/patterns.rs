//! `#[patterns]`: a pattern set's `populate`, from its `#[lowering]` methods and `#[map]` rows.

use proc_macro2::TokenStream as Tokens;
use quote::{format_ident, quote};
use syn::parse::{Parse, ParseStream};
use syn::{Expr, Ident, ImplItem, ItemImpl, LitStr, Token, Type};

mod lowering;
mod map;

use lowering::LoweringArgs;
use map::MapArgs;

/// `#[patterns(..)]`'s arguments: `converter`, `options = Type`, `extra = path`, and
/// `flag: Type` populate parameters.
pub struct PatternsArgs {
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

/// What the rows of a `#[patterns]` impl add to it: their generated items, the roots they
/// lower, and their statements of `populate`.
struct Populate {
    items: Vec<ImplItem>,
    roots: Vec<LitStr>,
    adds: Vec<Tokens>,
}

impl Populate {
    /// A row's pattern: `f` lowering `root`, added when `when` holds; `opts` when it takes
    /// the options, `typed` when it goes through the type converter.
    fn add(&mut self, root: &LitStr, benefit: Tokens, when: Tokens, f: &Ident, opts: bool, typed: bool) {
        if !self.roots.iter().any(|r| r.value() == root.value()) {
            self.roots.push(root.clone());
        }
        let make = if opts {
            quote!(crate::OptLowering { root: #root, opts, f: Self::#f })
        } else {
            quote!(crate::Lowering { root: #root, benefit: #benefit, f: Self::#f })
        };
        let add = if typed { quote!(patterns.add_with(tc, l)) } else { quote!(patterns.add(l)) };
        self.adds.push(quote! {
            if #when {
                let l = #make;
                #add;
            }
        });
    }
}

impl PatternsArgs {
    /// `#[patterns(..)]`: see the crate docs.
    pub fn expand(attr: Tokens, item: Tokens) -> syn::Result<Tokens> {
        let args: PatternsArgs = syn::parse2(attr)?;
        let mut imp: ItemImpl = syn::parse2(item)?;
        let mut maps = Vec::new();
        let mut kept = Vec::new();
        for a in core::mem::take(&mut imp.attrs) {
            if a.path().is_ident("map") {
                maps.push(a.parse_args::<MapArgs>()?);
            } else {
                kept.push(a);
            }
        }
        imp.attrs = kept;
        let mut out = Populate { items: Vec::new(), roots: Vec::new(), adds: Vec::new() };
        for it in imp.items.iter_mut() {
            let ImplItem::Fn(m) = it else { continue };
            let Some(pos) = m.attrs.iter().position(|a| a.path().is_ident("lowering")) else { continue };
            let l: LoweringArgs = m.attrs.remove(pos).parse_args()?;
            l.declare(&args, m, &mut out)?;
        }
        for (i, m) in maps.iter().enumerate() {
            m.declare(&args, i, &mut out);
        }
        let Populate { items, roots, adds } = out;
        imp.items.extend(items);
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
        Ok(quote!(#imp))
    }
}
