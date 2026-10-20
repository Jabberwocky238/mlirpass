//! `#[lowering(..)]`: a method of a `#[patterns]` impl as one of its patterns.

use quote::{format_ident, quote};
use syn::parse::{Parse, ParseStream};
use syn::{Expr, Ident, ImplItemFn, LitInt, LitStr, Token, Type};

use super::{PatternsArgs, Populate};

/// A method's `#[lowering("root", .., benefit = n, when = expr, untyped)]`.
pub struct LoweringArgs {
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

impl LoweringArgs {
    /// Adds method `m` to `out` (with the wrapper a typed one is called through).
    pub fn declare(&self, args: &PatternsArgs, m: &ImplItemFn, out: &mut Populate) -> syn::Result<()> {
        let typed = args.builder.is_some()
            && match m.sig.inputs.first() {
                Some(syn::FnArg::Typed(t)) => !matches!(&*t.pat, syn::Pat::Ident(i) if i.ident == "cr"),
                _ => false,
            };
        let f = if typed {
            let Some(builder) = &args.builder else {
                return Err(syn::Error::new_spanned(&m.sig, "a typed #[lowering] needs #[patterns(builder = ..)]"));
            };
            let name = &m.sig.ident;
            let w = format_ident!("__typed_{}", name);
            // Without a type converter, the op's own operands (an `OpRewritePattern`).
            let ops_src = if args.converter && !self.untyped {
                quote!(crate::ConversionRewriter::one_to_one(operands)?)
            } else {
                quote!({ let _ = operands; cr.rw.body[op].operands.clone() })
            };
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
            out.items.push(syn::parse_quote! {
                fn #w(cr: &mut crate::ConversionRewriter<'_, '_, '_>, op: crate::OpId, operands: &[alloc::vec::Vec<crate::ValueId>]) -> bool {
                    let run = |cr: &mut crate::ConversionRewriter<'_, '_, '_>| -> Option<bool> {
                        let __ops = #ops_src;
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
        let benefit = self.benefit.as_ref().map_or_else(|| quote!(1), |b| quote!(#b));
        let when = self.when.as_ref().map_or_else(|| quote!(true), |w| quote!(#w));
        for root in &self.roots {
            out.add(root, benefit.clone(), when.clone(), &f, args.options.is_some() && !self.plain, args.converter && !self.untyped);
        }
        Ok(())
    }
}
