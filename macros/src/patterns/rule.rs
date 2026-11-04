//! `#[rewrite(..)]` / `#[convert(..)]`: a method of a `#[patterns]` impl as one of its rules.

use quote::{format_ident, quote};
use syn::parse::{Parse, ParseStream};
use syn::{Expr, Ident, ImplItemFn, LitInt, LitStr, Token, Type};

use super::{PatternsArgs, Populate};

/// A method's `#[rewrite("root", benefit = n, when = expr, name = "Name")]` (a rewrite
/// pattern: the greedy / walk drivers', and the conversion driver's through `Plain`) or
/// `#[convert("root", .., benefit = n, when = expr, untyped, plain)]` (a conversion pattern);
/// a root `_` matches any op (`MatchAnyOpTypeTag`).
pub struct RuleArgs {
    roots: Vec<LitStr>,
    benefit: Option<LitInt>,
    when: Option<Expr>,
    untyped: bool,
    plain: bool,
    name: Option<LitStr>,
    /// `#[convert]` (set by the caller from the attribute's name).
    pub convert: bool,
}

impl Parse for RuleArgs {
    fn parse(input: ParseStream) -> syn::Result<Self> {
        let mut args = RuleArgs { roots: Vec::new(), benefit: None, when: None, untyped: false, plain: false, name: None, convert: false };
        while !input.is_empty() {
            if input.peek(LitStr) {
                args.roots.push(input.parse()?);
            } else if input.peek(Token![_]) {
                let u: Token![_] = input.parse()?;
                args.roots.push(LitStr::new("_", u.span));
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
                    "name" => {
                        input.parse::<Token![=]>()?;
                        args.name = Some(input.parse()?);
                    }
                    "untyped" => args.untyped = true,
                    "plain" => args.plain = true,
                    o => return Err(syn::Error::new(k.span(), format!("unknown #[rewrite] / #[convert] argument `{o}`"))),
                }
            }
            if input.parse::<Option<Token![,]>>()?.is_none() {
                break;
            }
        }
        Ok(args)
    }
}

impl RuleArgs {
    /// Adds method `m` of `self_ty` to `out`.
    pub fn declare(&self, args: &PatternsArgs, self_ty: &Type, m: &ImplItemFn, out: &mut Populate) -> syn::Result<()> {
        if self.convert {
            return self.declare_convert(args, m, out);
        }
        let [root] = self.roots.as_slice() else {
            return Err(syn::Error::new_spanned(&m.sig, "a #[rewrite] has one root (`_`: any op)"));
        };
        let f = &m.sig.ident;
        let name = self.name.as_ref().map_or_else(|| Self::camel(&f.to_string()), LitStr::value);
        let s = Ident::new(&name, f.span());
        let docs: Vec<&syn::Attribute> = m.attrs.iter().filter(|a| a.path().is_ident("doc")).collect();
        let root_v = if root.value() == "_" { quote!(None) } else { quote!(Some(#root)) };
        let benefit = self.benefit.as_ref().map_or_else(|| quote!(1), |b| quote!(#b));
        out.beside.push(quote! {
            #(#docs)*
            pub struct #s;

            impl crate::Pattern for #s {
                fn name(&self) -> &str {
                    #name
                }

                fn root(&self) -> Option<&str> {
                    #root_v
                }

                fn benefit(&self) -> u16 {
                    #benefit
                }

                fn rewrite(&self, rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
                    <#self_ty>::#f(rw, op)
                }
            }
        });
        let when = self.when.as_ref().map_or_else(|| quote!(true), |w| quote!(#w));
        out.add_plain(Some(root), &s, when);
        Ok(())
    }

    /// `fold_fill_with_tensor_extract` ⇒ `FoldFillWithTensorExtract`.
    fn camel(snake: &str) -> String {
        snake.split('_').map(|w| {
            let mut c = w.chars();
            c.next().map_or_else(String::new, |f| f.to_uppercase().chain(c).collect())
        }).collect()
    }

    /// A `#[convert]` method (with the wrapper a typed one is called through).
    fn declare_convert(&self, args: &PatternsArgs, m: &ImplItemFn, out: &mut Populate) -> syn::Result<()> {
        let typed = args.builder.is_some()
            && match m.sig.inputs.first() {
                Some(syn::FnArg::Typed(t)) => !matches!(&*t.pat, syn::Pat::Ident(i) if i.ident == "cr"),
                _ => false,
            };
        let f = if typed {
            let Some(builder) = &args.builder else {
                return Err(syn::Error::new_spanned(&m.sig, "a typed #[convert] needs #[patterns(builder = ..)]"));
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
                    fetch.push(quote!(let #v = <#ty as crate::FromOp>::from_op(cr, op);));
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
                        Some(crate::Replacement::replace(__r, cr, op))
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
