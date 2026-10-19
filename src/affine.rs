//! ⭐ Affine expressions and maps, as `AffineExpr.cpp`, `AffineMap.cpp`, the affine part of
//! `AffineParser.cpp` and `AsmPrinter.cpp`: built through the same simplifying constructors,
//! so that parsing, folding and printing land on the text `mlir-opt` prints.

use alloc::boxed::Box;
use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;
use core::fmt;

/// `AffineExprKind` of a binary expression.
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub enum Bin {
    Add,
    Mul,
    Mod,
    FloorDiv,
    CeilDiv,
}

/// An affine expression. Equality is structural, like MLIR's uniqued storage.
#[derive(Debug, Clone, PartialEq, Eq, PartialOrd, Ord)]
pub enum AffineExpr {
    Dim(u32),
    Sym(u32),
    Const(i64),
    Bin(Bin, Box<AffineExpr>, Box<AffineExpr>),
}

use AffineExpr::{Const, Dim, Sym};

fn floor_div(a: i64, b: i64) -> i64 {
    let q = a / b;
    if (a % b != 0) && ((a < 0) != (b < 0)) { q - 1 } else { q }
}

fn ceil_div(a: i64, b: i64) -> i64 {
    let q = a / b;
    if (a % b != 0) && ((a < 0) == (b < 0)) { q + 1 } else { q }
}

/// `mod`: the result has the divisor's sign... MLIR's `mod` is always non-negative for a
/// positive divisor.
fn modulo(a: i64, b: i64) -> i64 {
    let r = a % b;
    if r < 0 { r + b } else { r }
}

fn gcd(a: u64, b: u64) -> u64 {
    if b == 0 { a } else { gcd(b, a % b) }
}

/// `std::gcd` on unsigned values.
pub fn gcd_u64(a: u64, b: u64) -> u64 {
    gcd(a, b)
}

impl AffineExpr {
    fn raw(k: Bin, l: AffineExpr, r: AffineExpr) -> Self {
        AffineExpr::Bin(k, Box::new(l), Box::new(r))
    }

    pub fn as_const(&self) -> Option<i64> {
        if let Const(c) = self { Some(*c) } else { None }
    }

    fn bin(&self) -> Option<(Bin, &AffineExpr, &AffineExpr)> {
        match self {
            AffineExpr::Bin(k, l, r) => Some((*k, l, r)),
            _ => None,
        }
    }

    fn bin_of(&self, k: Bin) -> Option<(&AffineExpr, &AffineExpr)> {
        self.bin().filter(|b| b.0 == k).map(|b| (b.1, b.2))
    }

    pub fn is_symbolic_or_constant(&self) -> bool {
        match self {
            Const(_) | Sym(_) => true,
            Dim(_) => false,
            AffineExpr::Bin(_, l, r) => l.is_symbolic_or_constant() && r.is_symbolic_or_constant(),
        }
    }

    pub fn is_pure_affine(&self) -> bool {
        match self {
            Const(_) | Sym(_) | Dim(_) => true,
            AffineExpr::Bin(Bin::Add, l, r) => l.is_pure_affine() && r.is_pure_affine(),
            AffineExpr::Bin(Bin::Mul, l, r) => l.is_pure_affine() && r.is_pure_affine() && (l.as_const().is_some() || r.as_const().is_some()),
            AffineExpr::Bin(_, l, r) => l.is_pure_affine() && r.as_const().is_some(),
        }
    }

    pub fn largest_known_divisor(&self) -> i64 {
        match self {
            Dim(_) | Sym(_) => 1,
            Const(c) => c.abs(),
            AffineExpr::Bin(Bin::CeilDiv | Bin::FloorDiv, l, r) => match r.as_const() {
                Some(c) if c != 0 => {
                    let d = l.largest_known_divisor();
                    if d % c == 0 { (d / c).abs() } else { 1 }
                }
                _ => 1,
            },
            AffineExpr::Bin(Bin::Mul, l, r) => l.largest_known_divisor().wrapping_mul(r.largest_known_divisor()),
            AffineExpr::Bin(_, l, r) => gcd(l.largest_known_divisor() as u64, r.largest_known_divisor() as u64) as i64,
        }
    }

    pub fn is_function_of_dim(&self, d: u32) -> bool {
        match self {
            Dim(x) => *x == d,
            AffineExpr::Bin(_, l, r) => l.is_function_of_dim(d) || r.is_function_of_dim(d),
            _ => false,
        }
    }

    pub fn is_function_of_sym(&self, s: u32) -> bool {
        match self {
            Sym(x) => *x == s,
            AffineExpr::Bin(_, l, r) => l.is_function_of_sym(s) || r.is_function_of_sym(s),
            _ => false,
        }
    }

    /// `getAffineBinaryOpExpr`.
    pub fn binary(k: Bin, l: AffineExpr, r: AffineExpr) -> Self {
        match k {
            Bin::Add => l.add(r),
            Bin::Mul => l.mul(r),
            Bin::FloorDiv => l.floor_div(r),
            Bin::CeilDiv => l.ceil_div(r),
            Bin::Mod => l.modulo(r),
        }
    }

    /// `orderCommutativeArgs`: dims before symbols, each by position.
    fn order(a: AffineExpr, b: AffineExpr) -> (AffineExpr, AffineExpr) {
        match (&a, &b) {
            (Sym(x), Sym(y)) | (Dim(x), Dim(y)) => {
                if x < y {
                    (a, b)
                } else {
                    (b, a)
                }
            }
            (Sym(_), Dim(_)) => (b, a),
            _ => (a, b),
        }
    }

    /// `operator+`.
    pub fn add(self, o: AffineExpr) -> Self {
        if let Some(s) = Self::simplify_add(&self, &o) {
            return s;
        }
        let (l, r) = Self::order(self, o);
        Self::raw(Bin::Add, l, r)
    }

    pub fn add_const(self, v: i64) -> Self {
        self.add(Const(v))
    }

    fn simplify_add(lhs: &AffineExpr, rhs: &AffineExpr) -> Option<AffineExpr> {
        let (lc, rc) = (lhs.as_const(), rhs.as_const());
        if let (Some(a), Some(b)) = (lc, rc) {
            return a.checked_add(b).map(Const);
        }
        if lc.is_some() || (lhs.is_symbolic_or_constant() && !rhs.is_symbolic_or_constant()) {
            return Some(rhs.clone().add(lhs.clone()));
        }
        if rc == Some(0) {
            return Some(lhs.clone());
        }
        let lbin = lhs.bin_of(Bin::Add);
        if let (Some((ll, lr)), Some(r)) = (lbin, rc)
            && let Some(lrc) = lr.as_const()
        {
            return Some(ll.clone().add_const(lrc + r));
        }
        let (c1, first) = match lhs.bin_of(Bin::Mul) {
            Some((l, r)) if r.as_const().is_some() => (r.as_const().expect("const"), l),
            _ => (1, lhs),
        };
        let rmul = rhs.bin_of(Bin::Mul);
        let (c2, second) = match rmul {
            Some((l, r)) if r.as_const().is_some() => (r.as_const().expect("const"), l),
            _ => (1, rhs),
        };
        if first == second {
            return Some(AffineExpr::binary(Bin::Mul, first.clone(), Const(c1 + c2)));
        }
        if let Some((ll, lr)) = lbin
            && let Some(lrc) = lr.as_const()
        {
            return Some(ll.clone().add(rhs.clone()).add(Const(lrc)));
        }
        let (_, rl, rr) = rhs.bin()?;
        // `expr - (expr floordiv c) * c` is `expr mod c`.
        if rr.as_const() == Some(-1)
            && let Some((lrl, lrr)) = rl.bin_of(Bin::Mul)
        {
            let (fl, fr) = lrl.bin_of(Bin::FloorDiv)?;
            if fr == lrr && lhs == fl {
                return Some(lhs.clone().modulo(lrr.clone()));
            }
        }
        let (llrhs, rlrhs) = rl.bin_of(Bin::FloorDiv)?;
        if !matches!(rhs.bin(), Some((Bin::Mul, ..))) {
            return None;
        }
        let positive = rlrhs.as_const().is_some_and(|c| c > 0);
        if positive && lhs == llrhs && *rlrhs == rr.clone().neg() {
            return Some(lhs.clone().modulo(rlrhs.clone()));
        }
        if let Some((ll, lr)) = lbin
            && let Some(s) = Self::simplify_add(lr, rhs)
        {
            return Some(ll.clone().add(s));
        }
        None
    }

    /// `operator*`.
    pub fn mul(self, o: AffineExpr) -> Self {
        if let Some(s) = Self::simplify_mul(&self, &o) {
            return s;
        }
        let (l, r) = Self::order(self, o);
        Self::raw(Bin::Mul, l, r)
    }

    pub fn mul_const(self, v: i64) -> Self {
        self.mul(Const(v))
    }

    fn simplify_mul(lhs: &AffineExpr, rhs: &AffineExpr) -> Option<AffineExpr> {
        let (lc, rc) = (lhs.as_const(), rhs.as_const());
        if let (Some(a), Some(b)) = (lc, rc) {
            return a.checked_mul(b).map(Const);
        }
        if !lhs.is_symbolic_or_constant() && !rhs.is_symbolic_or_constant() {
            return None;
        }
        if !rhs.is_symbolic_or_constant() || lc.is_some() {
            return Some(rhs.clone().mul(lhs.clone()));
        }
        match rc {
            Some(1) => return Some(lhs.clone()),
            Some(0) => return Some(Const(0)),
            _ => {}
        }
        if let Some((ll, lr)) = lhs.bin_of(Bin::Mul)
            && let Some(lrc) = lr.as_const()
        {
            if let Some(r) = rc {
                return Some(ll.clone().mul_const(lrc * r));
            }
            return Some(ll.clone().mul(rhs.clone()).mul(Const(lrc)));
        }
        None
    }

    /// Unary minus: `* -1`.
    pub fn neg(self) -> Self {
        self.mul(Const(-1))
    }

    pub fn sub(self, o: AffineExpr) -> Self {
        self.add(o.neg())
    }

    pub fn floor_div(self, o: AffineExpr) -> Self {
        if let Some(s) = Self::simplify_floor_div(&self, &o) {
            return s;
        }
        Self::raw(Bin::FloorDiv, self, o)
    }

    fn simplify_floor_div(lhs: &AffineExpr, rhs: &AffineExpr) -> Option<AffineExpr> {
        let r = rhs.as_const().filter(|c| *c != 0)?;
        if let Some(l) = lhs.as_const() {
            if l == i64::MIN && r == -1 {
                return None;
            }
            return Some(Const(floor_div(l, r)));
        }
        if r == 1 {
            return Some(lhs.clone());
        }
        if let Some((ll, lr)) = lhs.bin_of(Bin::Mul)
            && let Some(lrc) = lr.as_const()
            && lrc % r == 0
        {
            return Some(ll.clone().mul_const(lrc / r));
        }
        if let Some((ll, lr)) = lhs.bin_of(Bin::Add)
            && (ll.largest_known_divisor() % r == 0 || lr.largest_known_divisor() % r == 0)
        {
            return Some(ll.clone().floor_div(Const(r)).add(lr.clone().floor_div(Const(r))));
        }
        None
    }

    pub fn ceil_div(self, o: AffineExpr) -> Self {
        if let Some(s) = Self::simplify_ceil_div(&self, &o) {
            return s;
        }
        Self::raw(Bin::CeilDiv, self, o)
    }

    fn simplify_ceil_div(lhs: &AffineExpr, rhs: &AffineExpr) -> Option<AffineExpr> {
        let r = rhs.as_const().filter(|c| *c != 0)?;
        if let Some(l) = lhs.as_const() {
            if l == i64::MIN && r == -1 {
                return None;
            }
            return Some(Const(ceil_div(l, r)));
        }
        if r == 1 {
            return Some(lhs.clone());
        }
        if let Some((ll, lr)) = lhs.bin_of(Bin::Mul)
            && let Some(lrc) = lr.as_const()
            && lrc % r == 0
        {
            return Some(ll.clone().mul_const(lrc / r));
        }
        None
    }

    /// `operator%`.
    pub fn modulo(self, o: AffineExpr) -> Self {
        if let Some(s) = Self::simplify_mod(&self, &o) {
            return s;
        }
        Self::raw(Bin::Mod, self, o)
    }

    fn simplify_mod(lhs: &AffineExpr, rhs: &AffineExpr) -> Option<AffineExpr> {
        let r = rhs.as_const().filter(|c| *c >= 1)?;
        if let Some(l) = lhs.as_const() {
            return Some(Const(modulo(l, r)));
        }
        if lhs.largest_known_divisor() % r == 0 {
            return Some(Const(0));
        }
        if let Some((ll, lr)) = lhs.bin_of(Bin::Add) {
            if ll.largest_known_divisor() % r == 0 {
                return Some(lr.clone().modulo(Const(r)));
            }
            if lr.largest_known_divisor() % r == 0 {
                return Some(ll.clone().modulo(Const(r)));
            }
        }
        if let Some((ll, lr)) = lhs.bin_of(Bin::Mod)
            && let Some(i) = lr.as_const()
            && i >= 1
            && modulo(i, r) == 0
        {
            return Some(ll.clone().modulo(Const(r)));
        }
        None
    }

    /// `replaceDimsAndSymbols`: rebuilt (and so simplified) only where something changed.
    pub fn replace(&self, dims: &[AffineExpr], syms: &[AffineExpr]) -> AffineExpr {
        match self {
            Const(_) => self.clone(),
            Dim(d) => dims.get(*d as usize).cloned().unwrap_or_else(|| self.clone()),
            Sym(s) => syms.get(*s as usize).cloned().unwrap_or_else(|| self.clone()),
            AffineExpr::Bin(k, l, r) => {
                let (nl, nr) = (l.replace(dims, syms), r.replace(dims, syms));
                if nl == **l && nr == **r {
                    return self.clone();
                }
                AffineExpr::binary(*k, nl, nr)
            }
        }
    }

    pub fn walk(&self, f: &mut impl FnMut(&AffineExpr)) {
        if let AffineExpr::Bin(_, l, r) = self {
            l.walk(f);
            r.walk(f);
        }
        f(self);
    }

    /// `getAffineExprFromFlatForm`.
    pub fn from_flat(flat: &[i64], dims: u32, syms: u32, locals: &[AffineExpr]) -> AffineExpr {
        let mut e = Const(0);
        for j in 0..(dims + syms) as usize {
            if flat[j] == 0 {
                continue;
            }
            let id = if (j as u32) < dims { Dim(j as u32) } else { Sym(j as u32 - dims) };
            e = e.add(id.mul_const(flat[j]));
        }
        for j in (dims + syms) as usize..flat.len() - 1 {
            if flat[j] == 0 {
                continue;
            }
            e = e.add(locals[j - (dims + syms) as usize].clone().mul_const(flat[j]));
        }
        let c = *flat.last().expect("constant column");
        if c != 0 {
            e = e.add_const(c);
        }
        e
    }

    /// `getSemiAffineExprFromFlatForm`.
    fn from_flat_semi(flat: &[i64], dims: u32, syms: u32, locals: &[AffineExpr]) -> AffineExpr {
        let base = (dims + syms) as usize;
        let mut entries: Vec<((u32, i64), i64, AffineExpr)> = Vec::new();
        let mut offset_sym: i64 = 0;
        let mut offset_dim: i64 = -1;
        let top = i64::from(dims.max(syms));
        for j in dims as usize..base {
            if flat[j] == 0 {
                continue;
            }
            entries.push(((j as u32 - dims, top + offset_sym), flat[j], Sym(j as u32 - dims)));
            offset_sym += 1;
        }
        let mut added = vec![false; flat.len() - base - 1];
        for (i, e) in locals.iter().enumerate() {
            if flat[base + i] == 0 {
                continue;
            }
            let Some((_, lhs, rhs)) = e.bin() else { continue };
            let simple = |x: &AffineExpr| matches!(x, Dim(_) | Sym(_));
            if !(simple(lhs) && (simple(rhs) || rhs.as_const().is_some())) {
                continue;
            }
            let key = match (lhs, rhs) {
                (Dim(p), Const(_)) => {
                    let k = (*p, offset_dim);
                    offset_dim -= 1;
                    k
                }
                (Sym(p), Const(_)) | (Sym(p), Sym(_)) => {
                    let k = (*p, top + offset_sym);
                    offset_sym += 1;
                    k
                }
                (Dim(p), Sym(q)) => (*p, i64::from(*q)),
                _ => continue,
            };
            entries.push((key, flat[base + i], e.clone()));
            added[i] = true;
        }
        for j in 0..dims as usize {
            if flat[j] == 0 {
                continue;
            }
            entries.push(((j as u32, offset_dim), flat[j], Dim(j as u32)));
            offset_dim -= 1;
        }
        // `llvm::sort` of (unsigned, signed) pairs: the signed half compares as unsigned in
        // the pair's `unsigned` view the C++ sorts through.
        entries.sort_by(|a, b| a.0.0.cmp(&b.0.0).then((a.0.1 as i32 as u32).cmp(&(b.0.1 as i32 as u32))));
        let mut e = Const(0);
        for (_, c, x) in entries {
            e = e.add(x.mul_const(c));
        }
        for j in base..flat.len() - 1 {
            if flat[j] == 0 || added[j - base] {
                continue;
            }
            e = e.add(locals[j - base].clone().mul_const(flat[j]));
        }
        let c = *flat.last().expect("constant column");
        if c != 0 {
            e = e.add_const(c);
        }
        e
    }

    /// The flattened form `[dims, symbols, locals, constant]` and the number of locals.
    pub fn flatten(&self, dims: u32, syms: u32) -> Option<(Vec<i64>, usize)> {
        let mut fl = Flattener::new(dims, syms);
        fl.walk(self)?;
        let n = fl.locals.len();
        Some((fl.stack.pop()?, n))
    }

    /// `simplifyAffineExpr`.
    pub fn simplify(&self, dims: u32, syms: u32) -> AffineExpr {
        let expr = if self.is_pure_affine() { self.clone() } else { self.simplify_semi(dims, syms) };
        let mut fl = Flattener::new(dims, syms);
        if fl.walk(&expr).is_none() {
            return expr;
        }
        let flat = fl.stack.pop().expect("one result");
        if !expr.is_pure_affine() && expr == Self::from_flat(&flat, dims, syms, &fl.locals) {
            return expr;
        }
        if expr.is_pure_affine() { Self::from_flat(&flat, dims, syms, &fl.locals) } else { Self::from_flat_semi(&flat, dims, syms, &fl.locals) }
    }

    fn summands(&self, out: &mut Vec<AffineExpr>) {
        match self.bin_of(Bin::Add) {
            Some((l, r)) => {
                l.summands(out);
                r.summands(out);
            }
            None => out.push(self.clone()),
        }
    }

    fn negated(&self) -> Option<&AffineExpr> {
        let (l, r) = self.bin_of(Bin::Mul)?;
        if l.as_const() == Some(-1) {
            return Some(r);
        }
        (r.as_const() == Some(-1)).then_some(l)
    }

    fn mod_of_mod_subtraction(lhs: &AffineExpr, rhs: &AffineExpr, dims: u32, syms: u32) -> bool {
        let mut s = Vec::new();
        lhs.summands(&mut s);
        for i in 0..s.len() {
            let Some(inner) = s[i].negated() else { continue };
            let Some((ml, mr)) = inner.bin_of(Bin::Mod) else { continue };
            if mr != rhs {
                continue;
            }
            let mut diff = Const(0);
            for (j, x) in s.iter().enumerate() {
                if i != j {
                    diff = diff.add(x.clone());
                }
            }
            diff = diff.sub(ml.clone()).simplify(dims, syms);
            if diff == Const(0) {
                return true;
            }
        }
        false
    }

    fn can_divide_by_symbol(&self, pos: u32, op: Bin, from_mul: bool) -> bool {
        match self {
            Const(c) => *c == 0,
            Dim(_) => false,
            Sym(s) => *s == pos,
            AffineExpr::Bin(Bin::Add, l, r) => l.can_divide_by_symbol(pos, op, false) && r.can_divide_by_symbol(pos, op, false),
            AffineExpr::Bin(Bin::Mod, l, r) => l.can_divide_by_symbol(pos, Bin::Mod, false) && r.can_divide_by_symbol(pos, Bin::Mod, false),
            AffineExpr::Bin(Bin::Mul, l, r) => l.can_divide_by_symbol(pos, op, true) || r.can_divide_by_symbol(pos, op, true),
            AffineExpr::Bin(k, l, _) => *k == op && !from_mul && l.can_divide_by_symbol(pos, *k, false),
        }
    }

    fn symbolic_divide(&self, pos: u32, op: Bin) -> Option<AffineExpr> {
        Some(match self {
            Const(c) => {
                if *c != 0 {
                    return None;
                }
                Const(0)
            }
            Dim(_) => return None,
            Sym(_) => Const(1),
            AffineExpr::Bin(Bin::Add, l, r) => AffineExpr::binary(Bin::Add, l.symbolic_divide(pos, op)?, r.symbolic_divide(pos, op)?),
            AffineExpr::Bin(Bin::Mod, l, r) => AffineExpr::binary(Bin::Mod, l.symbolic_divide(pos, Bin::Mod)?, r.symbolic_divide(pos, Bin::Mod)?),
            AffineExpr::Bin(Bin::Mul, l, r) => {
                if !l.can_divide_by_symbol(pos, op, false) {
                    (**l).clone().mul(r.symbolic_divide(pos, op)?)
                } else {
                    l.symbolic_divide(pos, op)?.mul((**r).clone())
                }
            }
            AffineExpr::Bin(k, l, r) => AffineExpr::binary(*k, l.symbolic_divide(pos, *k)?, (**r).clone()),
        })
    }

    /// `simplifySemiAffine`.
    fn simplify_semi(&self, dims: u32, syms: u32) -> AffineExpr {
        match self {
            Const(_) | Dim(_) | Sym(_) => self.clone(),
            AffineExpr::Bin(k @ (Bin::Add | Bin::Mul), l, r) => AffineExpr::binary(*k, l.simplify_semi(dims, syms), r.simplify_semi(dims, syms)),
            AffineExpr::Bin(k, l, r) => {
                let (sl, sr) = (l.simplify_semi(dims, syms), r.simplify_semi(dims, syms));
                if Self::mod_of_mod_subtraction(&sl, &sr, dims, syms) {
                    return Const(0);
                }
                let Sym(pos) = sr else { return AffineExpr::binary(*k, sl, sr) };
                if !l.can_divide_by_symbol(pos, *k, false) {
                    return AffineExpr::binary(*k, sl, sr);
                }
                if *k == Bin::Mod {
                    return Const(0);
                }
                sl.symbolic_divide(pos, *k).unwrap_or_else(|| AffineExpr::binary(*k, sl, sr))
            }
        }
    }
}

/// `SimpleAffineExprFlattener`: rows of `[dims, symbols, locals, constant]`.
struct Flattener {
    dims: u32,
    syms: u32,
    stack: Vec<Vec<i64>>,
    locals: Vec<AffineExpr>,
}

impl Flattener {
    fn new(dims: u32, syms: u32) -> Self {
        Self { dims, syms, stack: Vec::new(), locals: Vec::new() }
    }

    fn cols(&self) -> usize {
        (self.dims + self.syms) as usize + self.locals.len() + 1
    }

    fn local_start(&self) -> usize {
        (self.dims + self.syms) as usize
    }

    fn walk(&mut self, e: &AffineExpr) -> Option<()> {
        if let AffineExpr::Bin(_, l, r) = e {
            self.walk(l)?;
            self.walk(r)?;
        }
        self.visit(e)
    }

    fn row(&self) -> Vec<i64> {
        vec![0; self.cols()]
    }

    fn find_local(&self, e: &AffineExpr) -> Option<usize> {
        self.locals.iter().position(|l| l == e)
    }

    fn add_local(&mut self, e: AffineExpr) {
        let at = self.local_start() + self.locals.len();
        for r in &mut self.stack {
            r.insert(at, 0);
        }
        self.locals.push(e);
    }

    /// `addLocalVariableSemiAffine`: `lhs` becomes the local standing for `e`.
    fn semi_affine_local(&mut self, e: AffineExpr) {
        let loc = self.find_local(&e);
        if loc.is_none() {
            self.add_local(e);
        }
        let n = self.locals.len();
        let start = self.local_start();
        let lhs = self.stack.last_mut().expect("lhs");
        lhs.iter_mut().for_each(|x| *x = 0);
        lhs[start + loc.unwrap_or(n - 1)] = 1;
    }

    fn expr(&self, row: &[i64]) -> AffineExpr {
        AffineExpr::from_flat(row, self.dims, self.syms, &self.locals)
    }

    fn visit(&mut self, e: &AffineExpr) -> Option<()> {
        match e {
            Dim(d) => {
                let mut r = self.row();
                r[*d as usize] = 1;
                self.stack.push(r);
            }
            Sym(s) => {
                let mut r = self.row();
                r[(self.dims + s) as usize] = 1;
                self.stack.push(r);
            }
            Const(c) => {
                let mut r = self.row();
                *r.last_mut().expect("constant") = *c;
                self.stack.push(r);
            }
            AffineExpr::Bin(Bin::Add, ..) => {
                let rhs = self.stack.pop()?;
                let lhs = self.stack.last_mut()?;
                lhs.iter_mut().zip(rhs).for_each(|(a, b)| *a += b);
            }
            AffineExpr::Bin(Bin::Mul, _, r) => {
                let rhs = self.stack.pop()?;
                if r.as_const().is_none() {
                    let lhs = self.stack.last()?.clone();
                    let prod = self.expr(&lhs).mul(self.expr(&rhs));
                    self.semi_affine_local(prod);
                    return Some(());
                }
                let c = *rhs.last()?;
                self.stack.last_mut()?.iter_mut().for_each(|x| *x *= c);
            }
            AffineExpr::Bin(Bin::Mod, _, r) => {
                let rhs = self.stack.pop()?;
                if r.as_const().is_none() {
                    let lhs = self.stack.last()?.clone();
                    let m = self.expr(&lhs).modulo(self.expr(&rhs));
                    self.semi_affine_local(m);
                    return Some(());
                }
                let c = *rhs.last()?;
                if c <= 0 {
                    return None;
                }
                let lhs = self.stack.last()?.clone();
                if lhs.iter().all(|x| x % c == 0) {
                    self.stack.last_mut()?.iter_mut().for_each(|x| *x = 0);
                    return Some(());
                }
                let mut g = c as u64;
                for x in &lhs {
                    g = gcd(g, x.unsigned_abs());
                }
                let dividend: Vec<i64> = lhs.iter().map(|x| x / g as i64).collect();
                let divisor = c / g as i64;
                let fd = self.expr(&dividend).floor_div(Const(divisor));
                match self.find_local(&fd) {
                    None => {
                        self.add_local(fd);
                        let at = self.local_start() + self.locals.len() - 1;
                        self.stack.last_mut()?[at] = -c;
                    }
                    Some(l) => {
                        let at = self.local_start() + l;
                        self.stack.last_mut()?[at] -= c;
                    }
                }
            }
            AffineExpr::Bin(k @ (Bin::FloorDiv | Bin::CeilDiv), _, r) => {
                let ceil = *k == Bin::CeilDiv;
                let rhs = self.stack.pop()?;
                if r.as_const().is_none() {
                    let lhs = self.stack.last()?.clone();
                    let (a, b) = (self.expr(&lhs), self.expr(&rhs));
                    let d = if ceil { a.ceil_div(b) } else { a.floor_div(b) };
                    self.semi_affine_local(d);
                    return Some(());
                }
                let c = *rhs.last()?;
                if c <= 0 {
                    return None;
                }
                let mut g = c.unsigned_abs();
                for x in self.stack.last()?.iter() {
                    g = gcd(g, x.unsigned_abs());
                }
                if g != 1 {
                    self.stack.last_mut()?.iter_mut().for_each(|x| *x /= g as i64);
                }
                let divisor = c / g as i64;
                if divisor == 1 {
                    return Some(());
                }
                let lhs = self.stack.last()?.clone();
                let a = self.expr(&lhs);
                let d = if ceil { a.ceil_div(Const(divisor)) } else { a.floor_div(Const(divisor)) };
                let loc = self.find_local(&d);
                if loc.is_none() {
                    self.add_local(d);
                }
                let n = self.locals.len();
                let start = self.local_start();
                let lhs = self.stack.last_mut()?;
                lhs.iter_mut().for_each(|x| *x = 0);
                lhs[start + loc.unwrap_or(n - 1)] = 1;
            }
        }
        Some(())
    }
}

/// `BindingStrength` of the printer.
#[derive(Clone, Copy, PartialEq)]
enum Strength {
    Weak,
    Strong,
}

impl AffineExpr {
    /// `printAffineExprInternal`.
    fn print(&self, f: &mut String, s: Strength) {
        let (k, l, r) = match self {
            Sym(p) => return f.push_str(&format!("s{p}")),
            Dim(p) => return f.push_str(&format!("d{p}")),
            Const(c) => return f.push_str(&format!("{c}")),
            AffineExpr::Bin(k, l, r) => (*k, &**l, &**r),
        };
        let open = |f: &mut String| {
            if s == Strength::Strong {
                f.push('(');
            }
        };
        let close = |f: &mut String| {
            if s == Strength::Strong {
                f.push(')');
            }
        };
        if k != Bin::Add {
            open(f);
            if k == Bin::Mul && r.as_const() == Some(-1) {
                f.push('-');
                l.print(f, Strength::Strong);
                return close(f);
            }
            l.print(f, Strength::Strong);
            f.push_str(match k {
                Bin::Mul => " * ",
                Bin::FloorDiv => " floordiv ",
                Bin::CeilDiv => " ceildiv ",
                _ => " mod ",
            });
            r.print(f, Strength::Strong);
            return close(f);
        }
        open(f);
        if let Some((rl, rr)) = r.bin_of(Bin::Mul)
            && let Some(c) = rr.as_const()
        {
            if c == -1 {
                l.print(f, Strength::Weak);
                f.push_str(" - ");
                rl.print(f, if matches!(rl, AffineExpr::Bin(Bin::Add, ..)) { Strength::Strong } else { Strength::Weak });
                return close(f);
            }
            if c < -1 {
                l.print(f, Strength::Weak);
                f.push_str(" - ");
                rl.print(f, Strength::Strong);
                f.push_str(&format!(" * {}", -c));
                return close(f);
            }
        }
        if let Some(c) = r.as_const()
            && c < 0
        {
            l.print(f, Strength::Weak);
            f.push_str(&format!(" - {}", -(c as i128)));
            return close(f);
        }
        l.print(f, Strength::Weak);
        f.push_str(" + ");
        r.print(f, Strength::Weak);
        close(f)
    }
}

impl fmt::Display for AffineExpr {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let mut s = String::new();
        self.print(&mut s, Strength::Weak);
        f.write_str(&s)
    }
}

/// An affine map: `(d0, ...)[s0, ...] -> (results)`.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct AffineMap {
    pub dims: u32,
    pub syms: u32,
    pub results: Vec<AffineExpr>,
}

impl fmt::Display for AffineMap {
    /// `printAffineMap`, without the `affine_map<...>` wrapper.
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let dims: Vec<String> = (0..self.dims).map(|i| format!("d{i}")).collect();
        write!(f, "({})", dims.join(", "))?;
        if self.syms != 0 {
            let syms: Vec<String> = (0..self.syms).map(|i| format!("s{i}")).collect();
            write!(f, "[{}]", syms.join(", "))?;
        }
        let results: Vec<String> = self.results.iter().map(|r| format!("{r}")).collect();
        write!(f, " -> ({})", results.join(", "))
    }
}

/// `IntegerSet`: `(dims)[syms] : (constraints)`, each `== 0` or `>= 0`.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct IntegerSet {
    pub dims: u32,
    pub syms: u32,
    pub constraints: Vec<(AffineExpr, bool)>,
}

impl fmt::Display for IntegerSet {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let dims: Vec<String> = (0..self.dims).map(|i| format!("d{i}")).collect();
        write!(f, "({})", dims.join(", "))?;
        if self.syms != 0 {
            let syms: Vec<String> = (0..self.syms).map(|i| format!("s{i}")).collect();
            write!(f, "[{}]", syms.join(", "))?;
        }
        let cs: Vec<String> = self.constraints.iter().map(|(e, eq)| format!("{e} {}", if *eq { "== 0" } else { ">= 0" })).collect();
        write!(f, " : ({})", cs.join(", "))
    }
}

// ---- parsing -------------------------------------------------------------------------------

/// `AffineParser` over the text of a map or set (without its `affine_map<`...`>`).
struct Parser<'s> {
    s: &'s [u8],
    at: usize,
    names: Vec<(String, AffineExpr)>,
}

impl<'s> Parser<'s> {
    fn ws(&mut self) {
        while self.at < self.s.len() && (self.s[self.at] as char).is_whitespace() {
            self.at += 1;
        }
    }

    fn peek(&mut self) -> Option<u8> {
        self.ws();
        self.s.get(self.at).copied()
    }

    fn eat(&mut self, c: u8) -> bool {
        if self.peek() == Some(c) {
            self.at += 1;
            true
        } else {
            false
        }
    }

    fn ident(&mut self) -> Option<String> {
        self.ws();
        let start = self.at;
        while self.at < self.s.len() && ((self.s[self.at] as char).is_ascii_alphanumeric() || matches!(self.s[self.at], b'_' | b'$' | b'.')) {
            self.at += 1;
        }
        (self.at > start).then(|| String::from_utf8_lossy(&self.s[start..self.at]).into_owned())
    }

    fn keyword(&mut self, k: &str) -> bool {
        self.ws();
        let save = self.at;
        if self.ident().as_deref() == Some(k) {
            return true;
        }
        self.at = save;
        false
    }

    fn id_list(&mut self, close: u8, sym: bool) -> Option<u32> {
        let mut n = 0;
        if self.eat(close) {
            return Some(0);
        }
        loop {
            let name = self.ident()?;
            let e = if sym { Sym(n) } else { Dim(n) };
            self.names.push((name, e));
            n += 1;
            if self.eat(close) {
                return Some(n);
            }
            if !self.eat(b',') {
                return None;
            }
        }
    }

    /// `(dims)[syms]`.
    fn header(&mut self) -> Option<(u32, u32)> {
        if !self.eat(b'(') {
            return None;
        }
        let dims = self.id_list(b')', false)?;
        let syms = if self.eat(b'[') { self.id_list(b']', true)? } else { 0 };
        Some((dims, syms))
    }

    fn high_op(&mut self) -> Option<Bin> {
        if self.eat(b'*') {
            return Some(Bin::Mul);
        }
        for (k, b) in [("floordiv", Bin::FloorDiv), ("ceildiv", Bin::CeilDiv), ("mod", Bin::Mod)] {
            if self.keyword(k) {
                return Some(b);
            }
        }
        None
    }

    fn low_op(&mut self) -> Option<bool> {
        if self.eat(b'+') {
            return Some(true);
        }
        if self.peek() == Some(b'-') && self.s.get(self.at + 1) != Some(&b'>') {
            self.at += 1;
            return Some(false);
        }
        None
    }

    fn operand(&mut self) -> Option<AffineExpr> {
        match self.peek()? {
            b'(' => {
                self.at += 1;
                let e = self.expr()?;
                self.eat(b')').then_some(e)
            }
            b'-' => {
                self.at += 1;
                Some(Const(-1).mul(self.operand()?))
            }
            c if c.is_ascii_digit() => {
                let start = self.at;
                while self.at < self.s.len() && self.s[self.at].is_ascii_digit() {
                    self.at += 1;
                }
                core::str::from_utf8(&self.s[start..self.at]).ok()?.parse::<i64>().ok().map(Const)
            }
            _ => {
                let name = self.ident()?;
                self.names.iter().find(|(n, _)| *n == name).map(|(_, e)| e.clone())
            }
        }
    }

    fn high(&mut self, llhs: Option<(AffineExpr, Bin)>) -> Option<AffineExpr> {
        let lhs = self.operand()?;
        if let Some(op) = self.high_op() {
            if let Some((l, lop)) = llhs {
                return self.high(Some((AffineExpr::binary(lop, l, lhs), op)));
            }
            return self.high(Some((lhs, op)));
        }
        Some(match llhs {
            Some((l, lop)) => AffineExpr::binary(lop, l, lhs),
            None => lhs,
        })
    }

    fn low(&mut self, llhs: Option<(AffineExpr, bool)>) -> Option<AffineExpr> {
        let combine = |l: AffineExpr, add: bool, r: AffineExpr| if add { l.add(r) } else { l.sub(r) };
        let lhs = self.operand()?;
        if let Some(op) = self.low_op() {
            return match llhs {
                Some((l, lop)) => self.low(Some((combine(l, lop, lhs), op))),
                None => self.low(Some((lhs, op))),
            };
        }
        if let Some(h) = self.high_op() {
            let high = self.high(Some((lhs, h)))?;
            let e = match llhs {
                Some((l, lop)) => combine(l, lop, high),
                None => high,
            };
            if let Some(next) = self.low_op() {
                return self.low(Some((e, next)));
            }
            return Some(e);
        }
        Some(match llhs {
            Some((l, lop)) => combine(l, lop, lhs),
            None => lhs,
        })
    }

    fn expr(&mut self) -> Option<AffineExpr> {
        self.low(None)
    }
}

impl AffineMap {
    /// Parses `(d0, ...)[s0, ...] -> (exprs)`, with or without the `<`...`>` around it.
    pub fn parse(text: &str) -> Option<Self> {
        let t = text.trim();
        let t = t.strip_prefix('<').and_then(|x| x.strip_suffix('>')).unwrap_or(t);
        let mut p = Parser { s: t.as_bytes(), at: 0, names: Vec::new() };
        let (dims, syms) = p.header()?;
        p.ws();
        if !(p.eat(b'-') && p.eat(b'>')) || !p.eat(b'(') {
            return None;
        }
        let mut results = Vec::new();
        if !p.eat(b')') {
            loop {
                results.push(p.expr()?);
                if p.eat(b')') {
                    break;
                }
                if !p.eat(b',') {
                    return None;
                }
            }
        }
        (p.peek().is_none()).then_some(Self { dims, syms, results })
    }

    pub fn identity(n: u32) -> Self {
        Self { dims: n, syms: 0, results: (0..n).map(Dim).collect() }
    }

    pub fn constant(c: i64) -> Self {
        Self { dims: 0, syms: 0, results: vec![Const(c)] }
    }

    pub fn is_identity(&self) -> bool {
        self.dims as usize == self.results.len() && self.results.iter().enumerate().all(|(i, r)| *r == Dim(i as u32))
    }

    /// The single constant result, if any.
    pub fn single_constant(&self) -> Option<i64> {
        match &self.results[..] {
            [r] => r.as_const(),
            _ => None,
        }
    }

    /// `simplifyAffineMap`.
    pub fn simplified(&self) -> Self {
        Self { results: self.results.iter().map(|r| r.simplify(self.dims, self.syms)).collect(), ..self.clone() }
    }

    /// `AffineMap::compose`: `self ∘ other` (other's results feed self's dims).
    pub fn compose(&self, other: &AffineMap) -> Self {
        let dims: Vec<AffineExpr> = other.results.iter().map(|r| r.replace(&[], &(0..other.syms).map(|s| Sym(s + self.syms)).collect::<Vec<_>>())).collect();
        let syms: Vec<AffineExpr> = (0..self.syms).map(Sym).collect();
        let results = self.results.iter().map(|r| r.replace(&dims, &syms)).collect();
        Self { dims: other.dims, syms: self.syms + other.syms, results }.simplified()
    }

    /// `replaceDimsAndSymbols`, with new dim and symbol counts.
    pub fn replace(&self, dims: &[AffineExpr], syms: &[AffineExpr], ndims: u32, nsyms: u32) -> Self {
        Self { dims: ndims, syms: nsyms, results: self.results.iter().map(|r| r.replace(dims, syms)).collect() }
    }

    /// Whether dim `d` appears in a result.
    pub fn uses_dim(&self, d: u32) -> bool {
        self.results.iter().any(|r| r.is_function_of_dim(d))
    }

    pub fn uses_sym(&self, s: u32) -> bool {
        self.results.iter().any(|r| r.is_function_of_sym(s))
    }
}

impl IntegerSet {
    pub fn parse(text: &str) -> Option<Self> {
        let t = text.trim();
        let t = t.strip_prefix('<').and_then(|x| x.strip_suffix('>')).unwrap_or(t);
        let mut p = Parser { s: t.as_bytes(), at: 0, names: Vec::new() };
        let (dims, syms) = p.header()?;
        if !p.eat(b':') || !p.eat(b'(') {
            return None;
        }
        let mut constraints = Vec::new();
        loop {
            let lhs = p.expr()?;
            let eq = if p.eat(b'=') && p.eat(b'=') {
                true
            } else if p.eat(b'>') && p.eat(b'=') {
                false
            } else {
                return None;
            };
            let rhs = p.expr()?;
            constraints.push((lhs.sub(rhs), eq));
            if p.eat(b')') {
                break;
            }
            if !p.eat(b',') {
                return None;
            }
        }
        Some(Self { dims, syms, constraints })
    }
}
