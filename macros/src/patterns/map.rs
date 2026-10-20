//! `#[map("from" => "to", ..)]`: a lowering generated whole.

use proc_macro2::TokenStream as Tokens;
use quote::{format_ident, quote};
use syn::parse::{Parse, ParseStream};
use syn::{Expr, Ident, LitInt, LitStr, Token};

use super::{PatternsArgs, Populate};

/// An impl's `#[map("from" => "to", flags.., benefit = n, when = expr, via = template)]`.
pub struct MapArgs {
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

    /// Adds row `i`'s lowering to `out`.
    pub fn declare(&self, args: &PatternsArgs, i: usize, out: &mut Populate) {
        let f = format_ident!("__map{}", i);
        let opts = args.options.is_some();
        let body = self.body(opts);
        let opt_param = args.options.as_ref().map(|t| quote!(opts: #t,));
        let doc = format!("`{}` ⇒ `{}`.", self.from.value(), self.to.value());
        out.items.push(syn::parse_quote! {
            #[doc = #doc]
            fn #f(cr: &mut crate::ConversionRewriter<'_, '_, '_>, op: crate::OpId, operands: &[alloc::vec::Vec<crate::ValueId>], #opt_param) -> bool {
                let _ = operands;
                #body
            }
        });
        let benefit = self.benefit.as_ref().map_or_else(|| quote!(1), |b| quote!(#b));
        let when = self.when.as_ref().map_or_else(|| quote!(true), |w| quote!(#w));
        out.add(&self.from, benefit, when, &f, opts, args.converter && !self.has("untyped"));
    }
}
