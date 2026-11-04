//! `#[pass_set(PassA, #[cfg(..)] PassB, ..)]`: a unit struct registering those passes, each
//! entry under its own attributes (a pass of a feature-gated module names its `cfg`).

use proc_macro2::TokenStream as Tokens;
use quote::quote;
use syn::parse::{Parse, ParseStream, Parser};
use syn::punctuated::Punctuated;
use syn::{Attribute, ItemStruct, Token, Type};

/// One entry: a pass type and the attributes it is registered under.
struct Entry {
    attrs: Vec<Attribute>,
    ty: Type,
}

impl Parse for Entry {
    fn parse(input: ParseStream) -> syn::Result<Self> {
        Ok(Entry { attrs: input.call(Attribute::parse_outer)?, ty: input.parse()? })
    }
}

/// `#[pass_set(..)]` on a unit struct: it implements `PassSet`, registering the passes listed.
pub fn expand(attr: Tokens, item: Tokens) -> syn::Result<Tokens> {
    let entries = Punctuated::<Entry, Token![,]>::parse_terminated.parse2(attr)?;
    let s: ItemStruct = syn::parse2(item)?;
    let name = &s.ident;
    let regs = entries.iter().map(|Entry { attrs, ty }| quote!(#(#attrs)* passes.register::<#ty>();));
    Ok(quote! {
        #s

        impl crate::PassSet for #name {
            fn register(passes: &mut crate::Passes) {
                #(#regs)*
            }
        }
    })
}
