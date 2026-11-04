//! `#[pass_set(PassA, PassB, ..)]`: a unit struct registering those passes.

use proc_macro2::TokenStream as Tokens;
use quote::quote;
use syn::parse::Parser;
use syn::punctuated::Punctuated;
use syn::{ItemStruct, Token, Type};

/// `#[pass_set(..)]` on a unit struct: it implements `PassSet`, registering the passes listed.
pub fn expand(attr: Tokens, item: Tokens) -> syn::Result<Tokens> {
    let passes = Punctuated::<Type, Token![,]>::parse_terminated.parse2(attr)?;
    let s: ItemStruct = syn::parse2(item)?;
    let name = &s.ident;
    let passes = passes.iter();
    Ok(quote! {
        #s

        impl crate::PassSet for #name {
            fn register(passes: &mut crate::Passes) {
                #(passes.register::<#passes>();)*
            }
        }
    })
}
