use alloc::boxed::Box;
use alloc::rc::Rc;
use alloc::string::String;
use alloc::format;
use alloc::vec::Vec;

use mlirformat::Error;

use super::lex::{Punct, Tok, Token};
use mlirformat::glsl::{Interpolation, Precision};

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Scalar {
    Float,
    Int,
    Uint,
    Bool,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum SamplerDim {
    D2,
    D3,
    Cube,
    D2Array,
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct StructDef {
    pub name: String,
    pub members: Vec<(Ty, String)>,
}

impl StructDef {
    pub fn member(&self, name: &str) -> Option<(u32, &Ty)> {
        self.members.iter().position(|(_, n)| n == name).map(|k| (u32::try_from(k).unwrap_or(u32::MAX), &self.members[k].0))
    }
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Ty {
    Void,
    Scalar(Scalar),
    Vec(Scalar, u32),
    Mat(u32, u32),
    Sampler(Scalar, SamplerDim, bool),
    Array(Box<Ty>, u32),
    Struct(Rc<StructDef>),
}

impl Ty {
    pub const FLOAT: Ty = Ty::Scalar(Scalar::Float);
    pub const INT: Ty = Ty::Scalar(Scalar::Int);
    pub const BOOL: Ty = Ty::Scalar(Scalar::Bool);

    const SAMPLER: &'static str = "sampler";
    const SHADOW: &'static str = "Shadow";
    const DIMS: [(&'static str, SamplerDim); 4] = [("2DArray", SamplerDim::D2Array), ("2D", SamplerDim::D2), ("3D", SamplerDim::D3), ("Cube", SamplerDim::Cube)];

    fn sampler(name: &str) -> Option<Ty> {
        let (scalar, rest) = match name.as_bytes().first()? {
            b'i' => (Scalar::Int, &name[1..]),
            b'u' => (Scalar::Uint, &name[1..]),
            _ => (Scalar::Float, name),
        };
        let rest = rest.strip_prefix(Ty::SAMPLER)?;
        let (rest, shadow) = match rest.strip_suffix(Ty::SHADOW) {
            Some(r) => (r, true),
            None => (rest, false),
        };
        let dim = Ty::DIMS.iter().find(|(n, _)| *n == rest)?.1;
        let ok = !shadow || (scalar == Scalar::Float && dim != SamplerDim::D3);
        ok.then_some(Ty::Sampler(scalar, dim, shadow))
    }

    pub fn of(scalar: Scalar, lanes: u32) -> Ty {
        if lanes == 1 { Ty::Scalar(scalar) } else { Ty::Vec(scalar, lanes) }
    }

    pub fn scalar(&self) -> Option<Scalar> {
        match self {
            Ty::Scalar(s) | Ty::Vec(s, _) => Some(*s),
            Ty::Mat(..) => Some(Scalar::Float),
            _ => None,
        }
    }

    pub fn lanes(&self) -> u32 {
        match self {
            Ty::Vec(_, n) => *n,
            Ty::Mat(c, r) => c * r,
            _ => 1,
        }
    }

    fn named(name: &str) -> Option<Ty> {
        let vec = |prefix: &str, s: Scalar| name.strip_prefix(prefix).and_then(|n| n.parse::<u32>().ok()).filter(|n| (2..=4).contains(n)).map(|n| Ty::Vec(s, n));
        if let Some(t) = Ty::sampler(name) {
            return Some(t);
        }
        Some(match name {
            "void" => Ty::Void,
            "float" => Ty::FLOAT,
            "int" => Ty::INT,
            "uint" => Ty::Scalar(Scalar::Uint),
            "bool" => Ty::BOOL,
            _ => {
                if let Some(t) = vec("vec", Scalar::Float).or_else(|| vec("ivec", Scalar::Int)).or_else(|| vec("uvec", Scalar::Uint)).or_else(|| vec("bvec", Scalar::Bool)) {
                    return Some(t);
                }
                let dims = name.strip_prefix("mat")?;
                let (c, r) = match dims.split_once('x') {
                    Some((c, r)) => (c.parse().ok()?, r.parse().ok()?),
                    None => {
                        let n = dims.parse().ok()?;
                        (n, n)
                    }
                };
                if !(2..=4).contains(&c) || !(2..=4).contains(&r) {
                    return None;
                }
                Ty::Mat(c, r)
            }
        })
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum BinOp {
    Add,
    Sub,
    Mul,
    Div,
    Rem,
    Lt,
    Gt,
    Le,
    Ge,
    Eq,
    Ne,
    And,
    Or,
    Xor,
    BitAnd,
    BitOr,
    BitXor,
    Shl,
    Shr,
}

impl BinOp {
    fn infix(p: Punct) -> Option<(BinOp, u8)> {
        Some(match p {
            Punct::OrOr => (BinOp::Or, 1),
            Punct::XorXor => (BinOp::Xor, 2),
            Punct::AndAnd => (BinOp::And, 3),
            Punct::Pipe => (BinOp::BitOr, 4),
            Punct::Caret => (BinOp::BitXor, 5),
            Punct::Amp => (BinOp::BitAnd, 6),
            Punct::EqEq => (BinOp::Eq, 7),
            Punct::Ne => (BinOp::Ne, 7),
            Punct::Lt => (BinOp::Lt, 8),
            Punct::Gt => (BinOp::Gt, 8),
            Punct::Le => (BinOp::Le, 8),
            Punct::Ge => (BinOp::Ge, 8),
            Punct::Shl => (BinOp::Shl, 9),
            Punct::Shr => (BinOp::Shr, 9),
            Punct::Plus => (BinOp::Add, 10),
            Punct::Minus => (BinOp::Sub, 10),
            Punct::Star => (BinOp::Mul, 11),
            Punct::Slash => (BinOp::Div, 11),
            Punct::Percent => (BinOp::Rem, 11),
            _ => return None,
        })
    }

    fn compound(p: Punct) -> Option<Option<BinOp>> {
        Some(match p {
            Punct::Assign => None,
            Punct::AddAssign => Some(BinOp::Add),
            Punct::SubAssign => Some(BinOp::Sub),
            Punct::MulAssign => Some(BinOp::Mul),
            Punct::DivAssign => Some(BinOp::Div),
            Punct::ModAssign => Some(BinOp::Rem),
            Punct::ShlAssign => Some(BinOp::Shl),
            Punct::ShrAssign => Some(BinOp::Shr),
            Punct::AndAssign => Some(BinOp::BitAnd),
            Punct::XorAssign => Some(BinOp::BitXor),
            Punct::OrAssign => Some(BinOp::BitOr),
            _ => return None,
        })
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum UnOp {
    Neg,
    Plus,
    Not,
    BitNot,
}

#[derive(Debug, Clone, PartialEq)]
pub enum Expr<'s> {
    Float(f32),
    Int(u32, Scalar),
    Bool(bool),
    Var(&'s str, u32),
    Call(&'s str, Vec<Expr<'s>>, u32),
    Ctor(Ty, Vec<Expr<'s>>, u32),
    Field(Box<Expr<'s>>, &'s str, u32),
    Index(Box<Expr<'s>>, Box<Expr<'s>>),
    Unary(UnOp, Box<Expr<'s>>),
    Binary(BinOp, Box<Expr<'s>>, Box<Expr<'s>>),
    Assign(Option<BinOp>, Box<Expr<'s>>, Box<Expr<'s>>),
    Step { inc: bool, post: bool, target: Box<Expr<'s>> },
    Select(Box<Expr<'s>>, Box<Expr<'s>>, Box<Expr<'s>>),
    Comma(Box<Expr<'s>>, Box<Expr<'s>>),
    Length(Box<Expr<'s>>),
}

impl Expr<'_> {
    pub fn pure(&self) -> bool {
        match self {
            Expr::Float(_) | Expr::Int(..) | Expr::Bool(_) | Expr::Var(..) => true,
            Expr::Assign(..) | Expr::Step { .. } => false,
            Expr::Call(_, a, _) | Expr::Ctor(_, a, _) => a.iter().all(Expr::pure),
            Expr::Field(e, ..) | Expr::Unary(_, e) | Expr::Length(e) => e.pure(),
            Expr::Index(a, b) | Expr::Binary(_, a, b) | Expr::Comma(a, b) => a.pure() && b.pure(),
            Expr::Select(a, b, c) => a.pure() && b.pure() && c.pure(),
        }
    }
}

#[derive(Debug, Clone, PartialEq)]
pub struct Decl<'s> {
    pub ty: Ty,
    pub name: &'s str,
    pub init: Option<Expr<'s>>,
}

#[derive(Debug, Clone, PartialEq)]
pub enum Stmt<'s> {
    Decl(Vec<Decl<'s>>),
    Expr(Expr<'s>),
    If(Expr<'s>, Box<Stmt<'s>>, Option<Box<Stmt<'s>>>),
    For { init: Option<Box<Stmt<'s>>>, cond: Option<Expr<'s>>, step: Option<Expr<'s>>, body: Box<Stmt<'s>> },
    While(Expr<'s>, Box<Stmt<'s>>),
    DoWhile(Box<Stmt<'s>>, Expr<'s>),
    Block(Vec<Stmt<'s>>),
    Return(Option<Expr<'s>>, u32),
    Discard,
    Break(u32),
    Continue(u32),
}

impl Stmt<'_> {
    pub fn leaves_loop(&self) -> bool {
        match self {
            Stmt::Break(_) | Stmt::Continue(_) => true,
            Stmt::If(_, a, b) => a.leaves_loop() || b.as_ref().is_some_and(|b| b.leaves_loop()),
            Stmt::Block(b) => b.iter().any(Stmt::leaves_loop),
            _ => false,
        }
    }

    pub fn returns(&self) -> bool {
        match self {
            Stmt::Return(..) => true,
            Stmt::If(_, a, b) => a.returns() || b.as_ref().is_some_and(|b| b.returns()),
            Stmt::For { init, body, .. } => init.as_ref().is_some_and(|i| i.returns()) || body.returns(),
            Stmt::While(_, b) | Stmt::DoWhile(b, _) => b.returns(),
            Stmt::Block(b) => b.iter().any(Stmt::returns),
            _ => false,
        }
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum StorageQual {
    Varying,
    In,
    Out,
    Uniform,
    Const,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum BlockLayout {
    Std140,
    Shared,
    Packed,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub struct Qual {
    pub storage: Option<StorageQual>,
    pub location: Option<u32>,
    pub binding: Option<u32>,
    pub layout: Option<BlockLayout>,
    pub interpolation: Option<Interpolation>,
    pub centroid: bool,
    pub invariant: bool,
    pub precision: Option<Precision>,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum ParamQual {
    In,
    Out,
    InOut,
}

#[derive(Debug, Clone, PartialEq)]
pub struct Param<'s> {
    pub qual: ParamQual,
    pub ty: Ty,
    pub name: &'s str,
}

#[derive(Debug, Clone, PartialEq)]
pub enum Item<'s> {
    Global { qual: Qual, decl: Decl<'s> },
    Block { qual: Qual, name: &'s str, members: Vec<(Ty, &'s str)>, instance: Option<(&'s str, Option<u32>)> },
    Func { ret: Ty, name: &'s str, params: Vec<Param<'s>>, body: Option<Vec<Stmt<'s>>>, line: u32 },
    Invariant(&'s str),
}

pub struct Parser<'t, 's> {
    toks: &'t [Token<'s>],
    pos: usize,
    structs: Vec<Rc<StructDef>>,
}

impl<'t, 's> Parser<'t, 's> {
    const TERNARY_PREC: u8 = 0;
    const STRUCT: &'static str = "struct";

    pub fn new(toks: &'t [Token<'s>]) -> Self {
        Parser { toks, pos: 0, structs: Vec::new() }
    }

    fn line(&self) -> u32 {
        self.toks.get(self.pos).or_else(|| self.toks.last()).map_or(0, |t| t.line)
    }

    fn err<T>(&self, msg: &str) -> Result<T, Error> {
        Err(Error(format!("glsl:{}: {msg}", self.line())))
    }

    fn peek(&self) -> Option<Tok<'s>> {
        self.toks.get(self.pos).map(|t| t.tok)
    }

    fn peek_at(&self, k: usize) -> Option<Tok<'s>> {
        self.toks.get(self.pos + k).map(|t| t.tok)
    }

    fn next(&mut self) -> Option<Tok<'s>> {
        let t = self.peek();
        self.pos += usize::from(t.is_some());
        t
    }

    fn eat(&mut self, p: Punct) -> bool {
        let hit = self.peek() == Some(Tok::Punct(p));
        self.pos += usize::from(hit);
        hit
    }

    fn eat_word(&mut self, w: &str) -> bool {
        let hit = self.peek() == Some(Tok::Ident(w));
        self.pos += usize::from(hit);
        hit
    }

    fn expect(&mut self, p: Punct) -> Result<(), Error> {
        if self.eat(p) { Ok(()) } else { self.err(&format!("expected {p:?}, found {:?}", self.peek())) }
    }

    fn ident(&mut self) -> Result<&'s str, Error> {
        match self.next() {
            Some(Tok::Ident(x)) => Ok(x),
            t => self.err(&format!("expected a name, found {t:?}")),
        }
    }

    fn uint(&mut self) -> Result<u32, Error> {
        match self.next() {
            Some(Tok::Int(v, _)) => Ok(v),
            t => self.err(&format!("expected an integer, found {t:?}")),
        }
    }

    fn named(&self, name: &str) -> Option<Ty> {
        Ty::named(name).or_else(|| self.structs.iter().find(|d| d.name == name).map(|d| Ty::Struct(d.clone())))
    }

    fn ty_name(&self) -> Option<Ty> {
        match self.peek() {
            Some(Tok::Ident(x)) => self.named(x),
            _ => None,
        }
    }

    fn struct_def(&mut self) -> Result<Ty, Error> {
        if !self.eat_word(Parser::STRUCT) {
            return self.err("expected struct");
        }
        let name = self.ident()?;
        if self.named(name).is_some() {
            return self.err(&format!("{name} is already a type"));
        }
        self.expect(Punct::LBrace)?;
        let mut members = Vec::new();
        while !self.eat(Punct::RBrace) {
            while matches!(self.peek(), Some(Tok::Ident(w)) if Self::precision(w).is_some()) {
                self.pos += 1;
            }
            let ty = if self.peek() == Some(Tok::Ident(Parser::STRUCT)) { self.struct_def()? } else { self.ty()? };
            loop {
                let n = self.ident()?;
                members.push((self.array_suffix(ty.clone())?, String::from(n)));
                if !self.eat(Punct::Comma) {
                    break;
                }
            }
            self.expect(Punct::Semi)?;
        }
        if members.is_empty() {
            return self.err(&format!("struct {name} has no members"));
        }
        let def = Rc::new(StructDef { name: String::from(name), members });
        self.structs.push(def.clone());
        Ok(Ty::Struct(def))
    }

    fn precision(w: &str) -> Option<Precision> {
        match w {
            "lowp" => Some(Precision::Lowp),
            "mediump" => Some(Precision::Mediump),
            "highp" => Some(Precision::Highp),
            _ => None,
        }
    }

    fn layout(&mut self, q: &mut Qual) -> Result<(), Error> {
        self.expect(Punct::LParen)?;
        loop {
            let key = self.ident()?;
            match key {
                "location" | "binding" => {
                    self.expect(Punct::Assign)?;
                    let v = Some(self.uint()?);
                    if key == "location" { q.location = v } else { q.binding = v }
                }
                "std140" => q.layout = Some(BlockLayout::Std140),
                "shared" => q.layout = Some(BlockLayout::Shared),
                "packed" => q.layout = Some(BlockLayout::Packed),
                "row_major" => return self.err("row_major is not supported yet"),
                "column_major" => {}
                other => return self.err(&format!("unknown layout qualifier {other}")),
            }
            if !self.eat(Punct::Comma) {
                return self.expect(Punct::RParen);
            }
        }
    }

    fn qualifiers(&mut self) -> Result<Qual, Error> {
        let mut q = Qual::default();
        loop {
            let Some(Tok::Ident(w)) = self.peek() else { return Ok(q) };
            match w {
                "layout" => {
                    self.pos += 1;
                    self.layout(&mut q)?;
                    continue;
                }
                "in" | "attribute" => q.storage = Some(StorageQual::In),
                "varying" => q.storage = Some(StorageQual::Varying),
                "out" => q.storage = Some(StorageQual::Out),
                "uniform" => q.storage = Some(StorageQual::Uniform),
                "const" => q.storage = Some(StorageQual::Const),
                "flat" => q.interpolation = Some(Interpolation::Flat),
                "smooth" => q.interpolation = Some(Interpolation::Smooth),
                "centroid" => q.centroid = true,
                "invariant" => q.invariant = true,
                _ => match Self::precision(w) {
                    Some(p) => q.precision = Some(p),
                    None => return Ok(q),
                },
            }
            self.pos += 1;
        }
    }

    fn ty(&mut self) -> Result<Ty, Error> {
        let Some(t) = self.ty_name() else { return self.err(&format!("expected a type, found {:?}", self.peek())) };
        self.pos += 1;
        Ok(t)
    }

    fn array_suffix(&mut self, ty: Ty) -> Result<Ty, Error> {
        if !self.eat(Punct::LBracket) {
            return Ok(ty);
        }
        let n = self.uint()?;
        self.expect(Punct::RBracket)?;
        Ok(Ty::Array(Box::new(ty), n))
    }

    pub fn items(&mut self) -> Result<Vec<Item<'s>>, Error> {
        let mut out = Vec::new();
        while self.peek().is_some() {
            if self.eat(Punct::Semi) {
                continue;
            }
            if self.eat_word("precision") {
                self.next();
                self.ty()?;
                self.expect(Punct::Semi)?;
                continue;
            }
            if self.peek() == Some(Tok::Ident("invariant")) && matches!(self.peek_at(1), Some(Tok::Ident(x)) if self.named(x).is_none() && Self::precision(x).is_none() && !matches!(x, "out" | "varying")) {
                self.pos += 1;
                out.push(Item::Invariant(self.ident()?));
                self.expect(Punct::Semi)?;
                continue;
            }
            let line = self.line();
            let qual = self.qualifiers()?;
            if let (Some(StorageQual::Uniform), Some(Tok::Ident(name)), Some(Tok::Punct(Punct::LBrace))) = (qual.storage, self.peek(), self.peek_at(1)) {
                self.pos += 2;
                let mut members = Vec::new();
                while !self.eat(Punct::RBrace) {
                    let mq = self.qualifiers()?;
                    if mq.location.is_some() || mq.binding.is_some() {
                        return self.err("block members take no location or binding");
                    }
                    let ty = self.ty()?;
                    loop {
                        let n = self.ident()?;
                        members.push((self.array_suffix(ty.clone())?, n));
                        if !self.eat(Punct::Comma) {
                            break;
                        }
                    }
                    self.expect(Punct::Semi)?;
                }
                let instance = match self.peek() {
                    Some(Tok::Ident(x)) => {
                        self.pos += 1;
                        let n = if self.eat(Punct::LBracket) {
                            let n = self.uint()?;
                            self.expect(Punct::RBracket)?;
                            Some(n)
                        } else {
                            None
                        };
                        Some((x, n))
                    }
                    _ => None,
                };
                self.expect(Punct::Semi)?;
                out.push(Item::Block { qual, name, members, instance });
                continue;
            }
            let ty = if self.peek() == Some(Tok::Ident(Parser::STRUCT)) {
                let ty = self.struct_def()?;
                if self.eat(Punct::Semi) {
                    if qual != Qual::default() {
                        return self.err("qualifiers on a struct declaration without a variable");
                    }
                    continue;
                }
                ty
            } else {
                self.ty()?
            };
            let name = self.ident()?;
            if self.eat(Punct::LParen) {
                let mut params = Vec::new();
                if !(self.peek() == Some(Tok::Ident("void")) && self.peek_at(1) == Some(Tok::Punct(Punct::RParen)) && {
                    self.pos += 1;
                    true
                }) {
                    while self.peek() != Some(Tok::Punct(Punct::RParen)) {
                        let mut qual = ParamQual::In;
                        loop {
                            match self.peek() {
                                Some(Tok::Ident("in")) => qual = ParamQual::In,
                                Some(Tok::Ident("out")) => qual = ParamQual::Out,
                                Some(Tok::Ident("inout")) => qual = ParamQual::InOut,
                                Some(Tok::Ident("const")) => {}
                                Some(Tok::Ident(w)) if Self::precision(w).is_some() => {}
                                _ => break,
                            }
                            self.pos += 1;
                        }
                        let ty = self.ty()?;
                        let name = self.ident()?;
                        let ty = self.array_suffix(ty)?;
                        params.push(Param { qual, ty, name });
                        if !self.eat(Punct::Comma) {
                            break;
                        }
                    }
                }
                self.expect(Punct::RParen)?;
                let body = if self.eat(Punct::Semi) { None } else { Some(self.block()?) };
                out.push(Item::Func { ret: ty, name, params, body, line });
                continue;
            }
            let mut name = name;
            loop {
                let ty = self.array_suffix(ty.clone())?;
                let init = if self.eat(Punct::Assign) { Some(self.assignment()?) } else { None };
                out.push(Item::Global { qual, decl: Decl { ty, name, init } });
                if !self.eat(Punct::Comma) {
                    break;
                }
                name = self.ident()?;
            }
            self.expect(Punct::Semi)?;
        }
        Ok(out)
    }

    fn block(&mut self) -> Result<Vec<Stmt<'s>>, Error> {
        self.expect(Punct::LBrace)?;
        let mut out = Vec::new();
        while !self.eat(Punct::RBrace) {
            if self.peek().is_none() {
                return self.err("unterminated block");
            }
            out.push(self.stmt()?);
        }
        Ok(out)
    }

    fn starts_decl(&self) -> bool {
        match self.peek() {
            Some(Tok::Ident("const")) => true,
            Some(Tok::Ident(w)) if Self::precision(w).is_some() => true,
            Some(Tok::Ident(w)) => self.named(w).is_some() && matches!(self.peek_at(1), Some(Tok::Ident(_))),
            _ => false,
        }
    }

    fn decl(&mut self) -> Result<Vec<Decl<'s>>, Error> {
        loop {
            match self.peek() {
                Some(Tok::Ident("const")) => {}
                Some(Tok::Ident(w)) if Self::precision(w).is_some() => {}
                _ => break,
            }
            self.pos += 1;
        }
        let ty = self.ty()?;
        let mut out = Vec::new();
        loop {
            let name = self.ident()?;
            let ty = self.array_suffix(ty.clone())?;
            let init = if self.eat(Punct::Assign) { Some(self.assignment()?) } else { None };
            out.push(Decl { ty, name, init });
            if !self.eat(Punct::Comma) {
                return Ok(out);
            }
        }
    }

    fn stmt(&mut self) -> Result<Stmt<'s>, Error> {
        let line = self.line();
        let Some(t) = self.peek() else { return self.err("expected a statement") };
        Ok(match t {
            Tok::Punct(Punct::LBrace) => Stmt::Block(self.block()?),
            Tok::Punct(Punct::Semi) => {
                self.pos += 1;
                Stmt::Block(Vec::new())
            }
            Tok::Ident("if") => {
                self.pos += 1;
                self.expect(Punct::LParen)?;
                let c = self.expr()?;
                self.expect(Punct::RParen)?;
                let then = Box::new(self.stmt()?);
                let other = if self.eat_word("else") { Some(Box::new(self.stmt()?)) } else { None };
                Stmt::If(c, then, other)
            }
            Tok::Ident("for") => {
                self.pos += 1;
                self.expect(Punct::LParen)?;
                let init = if self.eat(Punct::Semi) {
                    None
                } else {
                    let s = if self.starts_decl() { Stmt::Decl(self.decl()?) } else { Stmt::Expr(self.expr()?) };
                    self.expect(Punct::Semi)?;
                    Some(Box::new(s))
                };
                let cond = if self.peek() == Some(Tok::Punct(Punct::Semi)) { None } else { Some(self.expr()?) };
                self.expect(Punct::Semi)?;
                let step = if self.peek() == Some(Tok::Punct(Punct::RParen)) { None } else { Some(self.expr()?) };
                self.expect(Punct::RParen)?;
                Stmt::For { init, cond, step, body: Box::new(self.stmt()?) }
            }
            Tok::Ident("while") => {
                self.pos += 1;
                self.expect(Punct::LParen)?;
                let c = self.expr()?;
                self.expect(Punct::RParen)?;
                Stmt::While(c, Box::new(self.stmt()?))
            }
            Tok::Ident("do") => {
                self.pos += 1;
                let body = Box::new(self.stmt()?);
                if !self.eat_word("while") {
                    return self.err("expected while");
                }
                self.expect(Punct::LParen)?;
                let c = self.expr()?;
                self.expect(Punct::RParen)?;
                self.expect(Punct::Semi)?;
                Stmt::DoWhile(body, c)
            }
            Tok::Ident(kw @ ("return" | "discard" | "break" | "continue")) => {
                self.pos += 1;
                let s = match kw {
                    "return" if self.peek() == Some(Tok::Punct(Punct::Semi)) => Stmt::Return(None, line),
                    "return" => Stmt::Return(Some(self.expr()?), line),
                    "discard" => Stmt::Discard,
                    "break" => Stmt::Break(line),
                    _ => Stmt::Continue(line),
                };
                self.expect(Punct::Semi)?;
                s
            }
            _ if self.starts_decl() => {
                let d = self.decl()?;
                self.expect(Punct::Semi)?;
                Stmt::Decl(d)
            }
            _ => {
                let e = self.expr()?;
                self.expect(Punct::Semi)?;
                Stmt::Expr(e)
            }
        })
    }

    pub fn expr(&mut self) -> Result<Expr<'s>, Error> {
        let mut e = self.assignment()?;
        while self.eat(Punct::Comma) {
            e = Expr::Comma(Box::new(e), Box::new(self.assignment()?));
        }
        Ok(e)
    }

    fn assignment(&mut self) -> Result<Expr<'s>, Error> {
        let lhs = self.ternary()?;
        if let Some(Tok::Punct(p)) = self.peek()
            && let Some(op) = BinOp::compound(p)
        {
            self.pos += 1;
            return Ok(Expr::Assign(op, Box::new(lhs), Box::new(self.assignment()?)));
        }
        Ok(lhs)
    }

    fn ternary(&mut self) -> Result<Expr<'s>, Error> {
        let c = self.binary(Self::TERNARY_PREC + 1)?;
        if !self.eat(Punct::Question) {
            return Ok(c);
        }
        let a = self.expr()?;
        self.expect(Punct::Colon)?;
        let b = self.assignment()?;
        Ok(Expr::Select(Box::new(c), Box::new(a), Box::new(b)))
    }

    fn binary(&mut self, min: u8) -> Result<Expr<'s>, Error> {
        let mut lhs = self.unary()?;
        while let Some(Tok::Punct(p)) = self.peek()
            && let Some((op, prec)) = BinOp::infix(p)
            && prec >= min
        {
            self.pos += 1;
            let rhs = self.binary(prec + 1)?;
            lhs = Expr::Binary(op, Box::new(lhs), Box::new(rhs));
        }
        Ok(lhs)
    }

    fn unary(&mut self) -> Result<Expr<'s>, Error> {
        let op = match self.peek() {
            Some(Tok::Punct(Punct::Minus)) => Some(UnOp::Neg),
            Some(Tok::Punct(Punct::Plus)) => Some(UnOp::Plus),
            Some(Tok::Punct(Punct::Bang)) => Some(UnOp::Not),
            Some(Tok::Punct(Punct::Tilde)) => Some(UnOp::BitNot),
            Some(Tok::Punct(p @ (Punct::Inc | Punct::Dec))) => {
                self.pos += 1;
                let target = Box::new(self.unary()?);
                return Ok(Expr::Step { inc: p == Punct::Inc, post: false, target });
            }
            _ => None,
        };
        if let Some(op) = op {
            self.pos += 1;
            return Ok(Expr::Unary(op, Box::new(self.unary()?)));
        }
        self.postfix()
    }

    fn args(&mut self) -> Result<Vec<Expr<'s>>, Error> {
        let mut args = Vec::new();
        if self.eat_word("void") {
            self.expect(Punct::RParen)?;
            return Ok(args);
        }
        if self.eat(Punct::RParen) {
            return Ok(args);
        }
        loop {
            args.push(self.assignment()?);
            if self.eat(Punct::RParen) {
                return Ok(args);
            }
            self.expect(Punct::Comma)?;
        }
    }

    fn postfix(&mut self) -> Result<Expr<'s>, Error> {
        let line = self.line();
        let mut e = match self.next() {
            Some(Tok::Float(v)) => Expr::Float(v),
            Some(Tok::Int(v, unsigned)) => Expr::Int(v, if unsigned { Scalar::Uint } else { Scalar::Int }),
            Some(Tok::Ident("true")) => Expr::Bool(true),
            Some(Tok::Ident("false")) => Expr::Bool(false),
            Some(Tok::Ident(x)) => match (self.named(x), self.peek()) {
                (Some(ty), Some(Tok::Punct(Punct::LParen))) => {
                    self.pos += 1;
                    Expr::Ctor(ty, self.args()?, line)
                }
                (Some(ty), Some(Tok::Punct(Punct::LBracket))) => {
                    let ty = self.array_suffix(ty)?;
                    self.expect(Punct::LParen)?;
                    Expr::Ctor(ty, self.args()?, line)
                }
                (_, Some(Tok::Punct(Punct::LParen))) => {
                    self.pos += 1;
                    Expr::Call(x, self.args()?, line)
                }
                _ => Expr::Var(x, line),
            },
            Some(Tok::Punct(Punct::LParen)) => {
                let e = self.expr()?;
                self.expect(Punct::RParen)?;
                e
            }
            t => return self.err(&format!("expected an expression, found {t:?}")),
        };
        loop {
            let line = self.line();
            e = match self.peek() {
                Some(Tok::Punct(Punct::Dot)) => {
                    self.pos += 1;
                    let f = self.ident()?;
                    if f == "length" && self.eat(Punct::LParen) {
                        self.expect(Punct::RParen)?;
                        Expr::Length(Box::new(e))
                    } else {
                        Expr::Field(Box::new(e), f, line)
                    }
                }
                Some(Tok::Punct(Punct::LBracket)) => {
                    self.pos += 1;
                    let i = self.expr()?;
                    self.expect(Punct::RBracket)?;
                    Expr::Index(Box::new(e), Box::new(i))
                }
                Some(Tok::Punct(p @ (Punct::Inc | Punct::Dec))) => {
                    self.pos += 1;
                    Expr::Step { inc: p == Punct::Inc, post: true, target: Box::new(e) }
                }
                _ => return Ok(e),
            };
        }
    }
}
