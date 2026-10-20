//! `#[pass]`: a pass's `mlir-opt` name, anchor and options.

use proc_macro2::{Span, TokenStream as Tokens};
use quote::quote;
use syn::parse::{Parse, ParseStream};
use syn::punctuated::Punctuated;
use syn::{Expr, Fields, Ident, Item, ItemFn, ItemStruct, LitStr, Token, bracketed};

/// `#[pass(..)]`'s arguments.
pub struct PassArgs {
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

impl PassArgs {
    /// `#[pass("name", on = "op", extra = [..])]` on a struct or a fn: see the crate docs.
    pub fn expand(attr: Tokens, item: Tokens) -> syn::Result<Tokens> {
        let args: PassArgs = syn::parse2(attr)?;
        match syn::parse2(item)? {
            Item::Struct(s) => args.on_struct(s),
            Item::Fn(f) => Ok(args.on_fn(f)),
            other => Err(syn::Error::new_spanned(other, "#[pass] goes on a struct or a fn")),
        }
    }

    /// The fn pass's struct: `ty`, or `convert-scf-to-cf` ⇒ `ConvertScfToCf`.
    fn ty(&self) -> Ident {
        self.ty.clone().unwrap_or_else(|| {
            let s: String = self.name.value().split(['-', '_']).map(|w| {
                let mut c = w.chars();
                c.next().map_or_else(String::new, |f| f.to_uppercase().chain(c).collect())
            }).collect();
            Ident::new(&s, Span::call_site())
        })
    }

    /// `PassDecl` for `ty`.
    fn decl(&self, ty: &Ident) -> Tokens {
        let name = &self.name;
        let on = match &self.on {
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

    fn on_struct(&self, mut s: ItemStruct) -> syn::Result<Tokens> {
        let ty = s.ident.clone();
        let name = &self.name;
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
                let o: OptArgs = f.attrs.remove(pos).parse_args()?;
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
        keys.extend(self.extra.iter().cloned());
        let build = if unit { quote!(Self) } else { quote!(Self { #(#inits),* }) };
        let check = self.check.as_ref().map(|c| quote!(#c(&made)?;));
        let d = self.decl(&ty);
        Ok(quote! {
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
        })
    }

    fn on_fn(&self, f: ItemFn) -> Tokens {
        let ty = self.ty();
        let name = &self.name;
        let keys = &self.extra;
        let (vis, sig, block, attrs) = (&f.vis, &f.sig, &f.block, &f.attrs);
        let inputs = &sig.inputs;
        let output = &sig.output;
        let generics = &sig.generics;
        let d = self.decl(&ty);
        let doc = format!("`{}`.", self.name.value());
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
}
