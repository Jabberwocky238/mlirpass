//! `blocks!`: a region's blocks, in their final order.

use proc_macro2::TokenStream as Tokens;
use quote::quote;
use syn::parse::{Parse, ParseStream};
use syn::{Expr, Ident, Token};

use crate::ops::OpsRewrite;

/// One block of `blocks!`: its name, its arguments, its statements.
struct BlockDecl {
    name: Ident,
    args: Vec<(Ident, Expr)>,
    body: syn::Block,
}

/// `blocks!(b; entry(..) {..} next(x: ty, ..) {..} ..)`.
pub struct Blocks {
    b: Expr,
    blocks: Vec<BlockDecl>,
}

impl Parse for Blocks {
    fn parse(input: ParseStream) -> syn::Result<Self> {
        let b: Expr = input.parse()?;
        input.parse::<Token![;]>()?;
        let mut blocks = Vec::new();
        while !input.is_empty() {
            let name: Ident = input.parse()?;
            let mut args = Vec::new();
            if input.peek(syn::token::Paren) {
                let content;
                syn::parenthesized!(content in input);
                while !content.is_empty() {
                    let a: Ident = content.parse()?;
                    content.parse::<Token![:]>()?;
                    args.push((a, content.parse()?));
                    if content.parse::<Option<Token![,]>>()?.is_none() {
                        break;
                    }
                }
            }
            blocks.push(BlockDecl { name, args, body: input.parse()? });
        }
        Ok(Blocks { b, blocks })
    }
}

impl Blocks {
    /// `blocks!(b; ..)`: see the crate docs.
    pub fn expand(input: Tokens) -> syn::Result<Tokens> {
        let Blocks { b, blocks } = syn::parse2(input)?;
        let mut make = Vec::new();
        let mut fill = Vec::new();
        let mut rw = OpsRewrite::new(b.clone(), None);
        for (i, d) in blocks.into_iter().enumerate() {
            let name = &d.name;
            if i == 0 {
                make.push(quote!(let #name = #b.at;));
            } else {
                let tys = d.args.iter().map(|(_, t)| t);
                make.push(quote!(let #name = #b.block(&[#(#tys),*]);));
            }
            for (k, (a, _)) in d.args.iter().enumerate() {
                make.push(quote!(let #a = #b.arg(#name, #k);));
            }
            let mut body = d.body;
            rw.block(&mut body);
            let stmts = &body.stmts;
            fill.push(quote! {
                #b.at = #name;
                #(#stmts)*
            });
        }
        Ok(quote!({ #(#make)* #(#fill)* }))
    }
}
