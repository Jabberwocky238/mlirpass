use alloc::collections::BTreeMap;
use alloc::format;
use alloc::vec::Vec;

use mlirformat::Error;

#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub enum Punct {
    LParen,
    RParen,
    LBracket,
    RBracket,
    LBrace,
    RBrace,
    Dot,
    Comma,
    Semi,
    Question,
    Colon,
    Plus,
    Minus,
    Star,
    Slash,
    Percent,
    Lt,
    Gt,
    Le,
    Ge,
    EqEq,
    Ne,
    AndAnd,
    OrOr,
    XorXor,
    Bang,
    Tilde,
    Amp,
    Pipe,
    Caret,
    Shl,
    Shr,
    Assign,
    AddAssign,
    SubAssign,
    MulAssign,
    DivAssign,
    ModAssign,
    ShlAssign,
    ShrAssign,
    AndAssign,
    XorAssign,
    OrAssign,
    Inc,
    Dec,
}

impl Punct {
    const TABLE: &'static [(&'static str, Punct)] = &[
        ("<<=", Punct::ShlAssign),
        (">>=", Punct::ShrAssign),
        ("<=", Punct::Le),
        (">=", Punct::Ge),
        ("==", Punct::EqEq),
        ("!=", Punct::Ne),
        ("&&", Punct::AndAnd),
        ("||", Punct::OrOr),
        ("^^", Punct::XorXor),
        ("<<", Punct::Shl),
        (">>", Punct::Shr),
        ("+=", Punct::AddAssign),
        ("-=", Punct::SubAssign),
        ("*=", Punct::MulAssign),
        ("/=", Punct::DivAssign),
        ("%=", Punct::ModAssign),
        ("&=", Punct::AndAssign),
        ("^=", Punct::XorAssign),
        ("|=", Punct::OrAssign),
        ("++", Punct::Inc),
        ("--", Punct::Dec),
        ("(", Punct::LParen),
        (")", Punct::RParen),
        ("[", Punct::LBracket),
        ("]", Punct::RBracket),
        ("{", Punct::LBrace),
        ("}", Punct::RBrace),
        (".", Punct::Dot),
        (",", Punct::Comma),
        (";", Punct::Semi),
        ("?", Punct::Question),
        (":", Punct::Colon),
        ("+", Punct::Plus),
        ("-", Punct::Minus),
        ("*", Punct::Star),
        ("/", Punct::Slash),
        ("%", Punct::Percent),
        ("<", Punct::Lt),
        (">", Punct::Gt),
        ("!", Punct::Bang),
        ("~", Punct::Tilde),
        ("&", Punct::Amp),
        ("|", Punct::Pipe),
        ("^", Punct::Caret),
        ("=", Punct::Assign),
    ];

    fn lead(s: &str) -> Option<(Punct, usize)> {
        Punct::TABLE.iter().find(|(t, _)| s.starts_with(t)).map(|&(t, p)| (p, t.len()))
    }
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub enum Tok<'s> {
    Ident(&'s str),
    Int(u32, bool),
    Float(f32),
    Punct(Punct),
}

#[derive(Debug, Clone, Copy)]
pub struct Token<'s> {
    pub tok: Tok<'s>,
    pub line: u32,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub struct Version {
    pub number: u32,
    pub es: bool,
}

impl Version {
    const DEFAULT: Version = Version { number: 100, es: true };
}

pub struct Lexed<'s> {
    pub tokens: Vec<Token<'s>>,
    pub version: Version,
}

#[derive(Clone, Copy)]
struct Frame {
    taking: bool,
    taken: bool,
    outer: bool,
}

struct Lexer<'s> {
    defines: BTreeMap<&'s str, Vec<Token<'s>>>,
    frames: Vec<Frame>,
    out: Vec<Token<'s>>,
    version: Option<Version>,
}

impl<'s> Lexer<'s> {
    const RADIX_HEX: u32 = 16;
    const RADIX_OCT: u32 = 8;
    const RADIX_DEC: u32 = 10;
    const MAX_EXPANSION: usize = 64;

    fn taking(&self) -> bool {
        self.frames.last().is_none_or(|f| f.taking)
    }

    fn err<T>(line: u32, msg: &str) -> Result<T, Error> {
        Err(Error(format!("glsl:{line}: {msg}")))
    }

    fn words(line: &'s str, n: u32) -> Result<Vec<Token<'s>>, Error> {
        let mut out = Vec::new();
        let mut s = line;
        loop {
            s = s.trim_start();
            let Some(c) = s.chars().next() else { return Ok(out) };
            let (tok, len) = if c.is_ascii_alphabetic() || c == '_' {
                let len = s.find(|c: char| !(c.is_ascii_alphanumeric() || c == '_')).unwrap_or(s.len());
                (Tok::Ident(&s[..len]), len)
            } else if c.is_ascii_digit() || (c == '.' && s[1..].starts_with(|c: char| c.is_ascii_digit())) {
                Self::number(s, n)?
            } else if let Some((p, len)) = Punct::lead(s) {
                (Tok::Punct(p), len)
            } else {
                return Self::err(n, &format!("unexpected character {c:?}"));
            };
            out.push(Token { tok, line: n });
            s = &s[len..];
        }
    }

    fn number(s: &'s str, n: u32) -> Result<(Tok<'s>, usize), Error> {
        let bytes = s.as_bytes();
        if s.starts_with("0x") || s.starts_with("0X") {
            let len = 2 + s[2..].find(|c: char| !c.is_ascii_hexdigit()).unwrap_or(s.len() - 2);
            let unsigned = bytes.get(len).is_some_and(|c| matches!(c, b'u' | b'U'));
            let v = u32::from_str_radix(&s[2..len], Self::RADIX_HEX).or_else(|_| Self::err(n, "integer out of range"))?;
            return Ok((Tok::Int(v, unsigned), len + usize::from(unsigned)));
        }
        let digits = s.find(|c: char| !c.is_ascii_digit()).unwrap_or(s.len());
        let mut end = digits;
        let mut float = false;
        if bytes.get(end) == Some(&b'.') {
            float = true;
            end += 1;
            end += s[end..].find(|c: char| !c.is_ascii_digit()).unwrap_or(s.len() - end);
        }
        if matches!(bytes.get(end), Some(b'e' | b'E')) {
            let mut e = end + 1;
            if matches!(bytes.get(e), Some(b'+' | b'-')) {
                e += 1;
            }
            let exp = s[e..].find(|c: char| !c.is_ascii_digit()).unwrap_or(s.len() - e);
            if exp > 0 {
                float = true;
                end = e + exp;
            }
        }
        if float || matches!(bytes.get(end), Some(b'f' | b'F')) {
            let v: f32 = s[..end].parse().or_else(|_| Self::err(n, "bad float literal"))?;
            let suffix = usize::from(matches!(bytes.get(end), Some(b'f' | b'F')));
            return Ok((Tok::Float(v), end + suffix));
        }
        let unsigned = matches!(bytes.get(end), Some(b'u' | b'U'));
        let radix = if digits > 1 && s.starts_with('0') { Self::RADIX_OCT } else { Self::RADIX_DEC };
        let v = u32::from_str_radix(&s[..end], radix).or_else(|_| Self::err(n, "integer out of range"))?;
        Ok((Tok::Int(v, unsigned), end + usize::from(unsigned)))
    }

    fn defined(&self, t: &[Token<'s>], n: u32) -> Result<i64, Error> {
        let name = match t {
            [Token { tok: Tok::Punct(Punct::LParen), .. }, Token { tok: Tok::Ident(x), .. }, Token { tok: Tok::Punct(Punct::RParen), .. }] | [Token { tok: Tok::Ident(x), .. }] => *x,
            _ => return Self::err(n, "defined takes one name"),
        };
        Ok(i64::from(self.defines.contains_key(name)))
    }

    fn condition(&self, t: &[Token<'s>], n: u32) -> Result<bool, Error> {
        let mut alts = t.split(|x| x.tok == Tok::Punct(Punct::OrOr));
        alts.try_fold(false, |any, alt| {
            let all = alt.split(|x| x.tok == Tok::Punct(Punct::AndAnd)).try_fold(true, |all, term| Ok::<bool, Error>(all && self.term(term, n)? != 0))?;
            Ok(any || all)
        })
    }

    fn term(&self, t: &[Token<'s>], n: u32) -> Result<i64, Error> {
        match t {
            [Token { tok: Tok::Punct(Punct::Bang), .. }, rest @ ..] => Ok(i64::from(self.term(rest, n)? == 0)),
            [Token { tok: Tok::Ident("defined"), .. }, rest @ ..] => self.defined(rest, n),
            [Token { tok: Tok::Int(v, _), .. }] => Ok(i64::from(*v)),
            [Token { tok: Tok::Ident(x), .. }] => match self.defines.get(x).map(|b| &b[..]) {
                Some([Token { tok: Tok::Int(v, _), .. }]) => Ok(i64::from(*v)),
                _ => Ok(0),
            },
            [a, op, b] => {
                let (a, b) = (self.term(core::slice::from_ref(a), n)?, self.term(core::slice::from_ref(b), n)?);
                Ok(i64::from(match op.tok {
                    Tok::Punct(Punct::EqEq) => a == b,
                    Tok::Punct(Punct::Ne) => a != b,
                    Tok::Punct(Punct::Lt) => a < b,
                    Tok::Punct(Punct::Gt) => a > b,
                    Tok::Punct(Punct::Le) => a <= b,
                    Tok::Punct(Punct::Ge) => a >= b,
                    _ => return Self::err(n, "unsupported #if operator"),
                }))
            }
            _ => Self::err(n, "unsupported #if expression"),
        }
    }

    fn directive(&mut self, line: &'s str, n: u32) -> Result<(), Error> {
        let rest = line.trim_start().trim_start_matches('#').trim_start();
        let (name, args) = rest.split_once(|c: char| c.is_whitespace()).unwrap_or((rest, ""));
        let toks = Self::words(args, n)?;
        let taking = self.taking();
        match name {
            "ifdef" | "ifndef" => {
                let [Token { tok: Tok::Ident(x), .. }] = toks[..] else { return Self::err(n, "#ifdef takes one name") };
                let on = self.defines.contains_key(x) == (name == "ifdef");
                self.frames.push(Frame { taking: taking && on, taken: on, outer: taking });
            }
            "if" => {
                let on = taking && self.condition(&toks, n)?;
                self.frames.push(Frame { taking: on, taken: on, outer: taking });
            }
            "elif" => {
                let f = *self.frames.last().ok_or_else(|| Error(format!("glsl:{n}: #elif without #if")))?;
                let on = !f.taken && f.outer && self.condition(&toks, n)?;
                *self.frames.last_mut().unwrap_or_else(|| unreachable!()) = Frame { taking: on, taken: f.taken || on, outer: f.outer };
            }
            "else" => {
                let f = self.frames.last_mut().ok_or_else(|| Error(format!("glsl:{n}: #else without #if")))?;
                f.taking = f.outer && !f.taken;
                f.taken = true;
            }
            "endif" => {
                self.frames.pop().ok_or_else(|| Error(format!("glsl:{n}: #endif without #if")))?;
            }
            _ if !taking => {}
            "version" => {
                let version = match toks[..] {
                    [Token { tok: Tok::Int(v, _), .. }] => Version { number: v, es: v == Version::DEFAULT.number },
                    [Token { tok: Tok::Int(v, _), .. }, Token { tok: Tok::Ident("es"), .. }] => Version { number: v, es: true },
                    [Token { tok: Tok::Int(v, _), .. }, Token { tok: Tok::Ident(_), .. }] => Version { number: v, es: false },
                    _ => return Self::err(n, "bad #version"),
                };
                if self.version.replace(version).is_some() || !self.out.is_empty() {
                    return Self::err(n, "#version must come first");
                }
            }
            "define" => {
                let Some(Token { tok: Tok::Ident(x), .. }) = toks.first() else { return Self::err(n, "#define takes a name") };
                let body = &args.trim_start()[x.len()..];
                if body.starts_with('(') {
                    return Self::err(n, "function-like macros are not supported yet");
                }
                self.defines.insert(x, Self::words(body, n)?);
            }
            "undef" => {
                let [Token { tok: Tok::Ident(x), .. }] = toks[..] else { return Self::err(n, "#undef takes one name") };
                self.defines.remove(x);
            }
            "extension" | "pragma" | "line" | "" => {}
            "error" => return Self::err(n, &format!("#error {args}")),
            other => return Self::err(n, &format!("unknown directive #{other}")),
        }
        Ok(())
    }

    fn expand(&mut self, t: Token<'s>, depth: usize) -> Result<(), Error> {
        let body = match t.tok {
            Tok::Ident(x) => self.defines.get(x).cloned(),
            _ => None,
        };
        match body {
            Some(_) if depth > Self::MAX_EXPANSION => Self::err(t.line, "macro expansion too deep"),
            Some(body) => body.into_iter().try_for_each(|b| self.expand(Token { tok: b.tok, line: t.line }, depth + 1)),
            None => {
                self.out.push(t);
                Ok(())
            }
        }
    }

    fn strip(src: &str) -> Result<alloc::string::String, Error> {
        let mut out = alloc::string::String::with_capacity(src.len());
        let mut rest = src;
        while let Some(i) = rest.find('/') {
            out.push_str(&rest[..i]);
            let after = &rest[i..];
            if after.starts_with("//") {
                rest = after.find('\n').map_or("", |e| &after[e..]);
            } else if after.starts_with("/*") {
                let end = after.find("*/").ok_or_else(|| Error(alloc::string::String::from("glsl: unterminated comment")))?;
                out.extend(after[..end].chars().filter(|c| *c == '\n'));
                out.push(' ');
                rest = &after[end + 2..];
            } else {
                out.push('/');
                rest = &after[1..];
            }
        }
        out.push_str(rest);
        Ok(out.replace("\\\n", ""))
    }
}

impl<'s> Lexed<'s> {
    pub fn text(src: &str) -> Result<alloc::string::String, Error> {
        Lexer::strip(src)
    }

    pub fn read(text: &'s str) -> Result<Lexed<'s>, Error> {
        let mut lx = Lexer { defines: BTreeMap::new(), frames: Vec::new(), out: Vec::new(), version: None };
        lx.defines.insert("GL_ES", alloc::vec![Token { tok: Tok::Int(1, false), line: 0 }]);
        for (i, line) in text.lines().enumerate() {
            let n = u32::try_from(i + 1).unwrap_or(u32::MAX);
            if line.trim_start().starts_with('#') {
                lx.directive(line, n)?;
            } else if lx.taking() {
                for t in Lexer::words(line, n)? {
                    lx.expand(t, 0)?;
                }
            }
        }
        if !lx.frames.is_empty() {
            return Lexer::err(0, "unterminated #if");
        }
        Ok(Lexed { tokens: lx.out, version: lx.version.unwrap_or(Version::DEFAULT) })
    }
}
