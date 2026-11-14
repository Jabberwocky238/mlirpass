use proc_macro::TokenStream;
use syn::Error;

mod blocks;
mod ops;
mod pass;
mod patterns;

#[proc_macro_attribute]
pub fn pass(attr: TokenStream, item: TokenStream) -> TokenStream {
    pass::PassArgs::expand(attr.into(), item.into()).unwrap_or_else(Error::into_compile_error).into()
}

#[proc_macro_attribute]
pub fn patterns(attr: TokenStream, item: TokenStream) -> TokenStream {
    patterns::PatternsArgs::expand(attr.into(), item.into()).unwrap_or_else(Error::into_compile_error).into()
}

#[proc_macro_attribute]
pub fn ops(attr: TokenStream, item: TokenStream) -> TokenStream {
    ops::OpsArgs::expand(attr.into(), item.into()).unwrap_or_else(Error::into_compile_error).into()
}

#[proc_macro]
pub fn blocks(input: TokenStream) -> TokenStream {
    blocks::Blocks::expand(input.into()).unwrap_or_else(Error::into_compile_error).into()
}
