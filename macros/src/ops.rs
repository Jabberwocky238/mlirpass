//! `#[ops]`: arithmetic written as arithmetic builds ops.

use proc_macro2::TokenStream as Tokens;
use quote::{format_ident, quote};
use syn::parse::{Parse, ParseStream};
use syn::{Expr, Ident, ItemFn, Token};

/// `#[ops(b, fmf = expr)]`'s arguments.
pub struct OpsArgs {
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
pub struct OpsRewrite {
    b: Expr,
    fmf: Option<Expr>,
    next: usize,
}

impl OpsRewrite {
    pub fn new(b: Expr, fmf: Option<Expr>) -> Self {
        OpsRewrite { b, fmf, next: 0 }
    }

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
                    BinOp::Shl(_) => ("shl", false),
                    BinOp::Shr(_) => ("shr", false),
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
            Expr::Unary(u) if matches!(u.op, UnOp::Neg(_)) && matches!(&*u.expr, Expr::Lit(l) if matches!(l.lit, syn::Lit::Int(_))) => Expr::Unary(u),
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
                // A call on the builder: its arguments are evaluated first, in order (they
                // may build ops through it too).
                let on_builder = { let r = &m.receiver; quote!(#r) }.to_string() == { let b = &self.b; quote!(#b) }.to_string();
                *m.receiver = self.expr(*m.receiver, pre);
                m.args = m.args.into_iter().map(|a| if on_builder { self.operand(a, pre) } else { self.expr(a, pre) }).collect();
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

    pub fn block(&mut self, b: &mut syn::Block) {
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

impl OpsArgs {
    /// See the crate docs.
    pub fn expand(attr: Tokens, item: Tokens) -> syn::Result<Tokens> {
        let args: OpsArgs = syn::parse2(attr)?;
        let mut f: ItemFn = syn::parse2(item)?;
        OpsRewrite::new(args.b, args.fmf).block(&mut f.block);
        Ok(quote!(#f))
    }
}
