//! ⭐ Random MLIR that is valid by construction, in custom form.
//!
//! ```text
//! module    funcs, each calling only the ones before it
//! func      typed arguments, a block of random ops, a return of the result types
//! op        arith (constants, int / float binaries, compares, select, casts), math,
//!           scf.if / scf.for with results (nested up to `depth`), memref.alloca / load /
//!           store, func.call
//! ```
//!
//! An operand is any value of its type visible at that point (defined earlier in the block or
//! an enclosing one), else a fresh constant: dominance holds without ever being checked.

use core::fmt::{self, Write};

use crate::rng::Rng;

/// The scalar types values get.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Ty {
    I1,
    I8,
    I16,
    I32,
    I64,
    Index,
    F32,
    F64,
}

impl Ty {
    const ALL: [Ty; 8] = [Ty::I1, Ty::I8, Ty::I16, Ty::I32, Ty::I64, Ty::Index, Ty::F32, Ty::F64];
    const INTS: [Ty; 5] = [Ty::I1, Ty::I8, Ty::I16, Ty::I32, Ty::I64];

    fn float(self) -> bool {
        matches!(self, Ty::F32 | Ty::F64)
    }

    /// An integer of a fixed width (not `index`).
    fn int(self) -> bool {
        Ty::INTS.contains(&self)
    }

    fn width(self) -> u32 {
        match self {
            Ty::I1 => 1,
            Ty::I8 => 8,
            Ty::I16 => 16,
            Ty::I32 | Ty::F32 => 32,
            Ty::I64 | Ty::F64 | Ty::Index => 64,
        }
    }
}

impl fmt::Display for Ty {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.write_str(match self {
            Ty::I1 => "i1",
            Ty::I8 => "i8",
            Ty::I16 => "i16",
            Ty::I32 => "i32",
            Ty::I64 => "i64",
            Ty::Index => "index",
            Ty::F32 => "f32",
            Ty::F64 => "f64",
        })
    }
}

/// `t1, t2` as a type list.
struct Tys<'t>(&'t [Ty]);

impl fmt::Display for Tys<'_> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        self.0.iter().enumerate().try_for_each(|(i, t)| write!(f, "{}{t}", if i > 0 { ", " } else { "" }))
    }
}

/// How big and how deep a module gets.
#[derive(Debug, Clone, Copy)]
pub struct Shape {
    pub funcs: usize,
    /// Ops per block, at most.
    pub ops: usize,
    /// Nesting of scf regions, at most.
    pub depth: usize,
}

impl Default for Shape {
    fn default() -> Self {
        Self { funcs: 3, ops: 12, depth: 2 }
    }
}

/// A value in scope.
#[derive(Debug, Clone)]
struct Val {
    name: String,
    ty: Ty,
}

/// What a block (and the blocks around it) can use.
#[derive(Default)]
struct Frame {
    vals: Vec<Val>,
    /// `memref<4xT>` allocas: name and element type.
    mems: Vec<Val>,
}

/// A function's signature, for calls.
struct Sig {
    name: String,
    args: Vec<Ty>,
    results: Vec<Ty>,
}

/// Op kinds, each with how often it is picked.
macro_rules! kinds {
    ($($k:ident = $w:literal),* $(,)?) => {
        #[derive(Debug, Clone, Copy)]
        enum Kind { $($k),* }

        impl Kind {
            const ALL: &'static [Kind] = &[$(Kind::$k),*];
            const WEIGHTS: &'static [u32] = &[$($w),*];
        }
    };
}

kinds! { Const = 3, IntBin = 8, FloatBin = 5, Cmp = 4, Select = 2, Cast = 5, Math = 2, If = 2, For = 2, Mem = 2, Call = 1 }

/// Int binaries (on `iN` and `index`), float binaries, unary math.
const INT_BIN: &[&str] = &[
    "addi", "subi", "muli", "divsi", "divui", "remsi", "remui", "ceildivsi", "floordivsi", "andi", "ori", "xori", "shli", "shrsi", "shrui", "maxsi", "minsi", "maxui", "minui",
];
const FLOAT_BIN: &[&str] = &["addf", "subf", "mulf", "divf", "remf", "maximumf", "minimumf", "maxnumf", "minnumf"];
const CMPI: &[&str] = &["eq", "ne", "slt", "sle", "sgt", "sge", "ult", "ule", "ugt", "uge"];
const CMPF: &[&str] = &["false", "oeq", "ogt", "oge", "olt", "ole", "one", "ord", "ueq", "ugt", "uge", "ult", "ule", "une", "uno", "true"];
const MATH_F: &[&str] = &["absf", "floor", "ceil", "round", "trunc"];
const MATH_I: &[&str] = &["absi", "ctpop", "ctlz", "cttz"];

/// ⭐ One module being written.
pub struct Gen<'r> {
    rng: &'r mut Rng,
    shape: Shape,
    out: String,
    indent: usize,
    next: u32,
    frames: Vec<Frame>,
    sigs: Vec<Sig>,
}

impl<'r> Gen<'r> {
    pub fn new(rng: &'r mut Rng, shape: Shape) -> Self {
        Self { rng, shape, out: String::new(), indent: 0, next: 0, frames: Vec::new(), sigs: Vec::new() }
    }

    /// ⭐ The module's text.
    pub fn module(mut self) -> String {
        for i in 0..self.shape.funcs {
            self.func(i);
        }
        self.out
    }

    fn line(&mut self, args: fmt::Arguments<'_>) {
        let _ = writeln!(self.out, "{:w$}{args}", "", w = self.indent);
    }

    fn fresh(&mut self) -> String {
        self.next += 1;
        format!("%v{}", self.next)
    }

    fn ty(&mut self) -> Ty {
        *self.rng.pick(&Ty::ALL)
    }

    fn tys(&mut self, max: usize) -> Vec<Ty> {
        (0..self.rng.range(0, max)).map(|_| self.ty()).collect()
    }

    fn define(&mut self, name: String, ty: Ty) -> String {
        self.frames.last_mut().expect("in a block").vals.push(Val { name: name.clone(), ty });
        name
    }

    /// A visible value of type `ty`, or a fresh constant.
    fn value(&mut self, ty: Ty) -> String {
        let seen: Vec<&Val> = self.frames.iter().flat_map(|f| &f.vals).filter(|v| v.ty == ty).collect();
        if seen.is_empty() || self.rng.chance(0.08) {
            return self.constant(ty);
        }
        seen[self.rng.below(seen.len())].name.clone()
    }

    /// A visible value whose type `want` accepts, with its type; a constant of `fallback` when none.
    fn value_where(&mut self, want: impl Fn(Ty) -> bool, fallback: Ty) -> (String, Ty) {
        let seen: Vec<(String, Ty)> = self.frames.iter().flat_map(|f| &f.vals).filter(|v| want(v.ty)).map(|v| (v.name.clone(), v.ty)).collect();
        match seen.len() {
            0 => (self.constant(fallback), fallback),
            n => seen[self.rng.below(n)].clone(),
        }
    }

    fn constant(&mut self, ty: Ty) -> String {
        let v = self.fresh();
        let lit = self.literal(ty);
        match ty {
            Ty::I1 => self.line(format_args!("{v} = arith.constant {lit}")),
            _ => self.line(format_args!("{v} = arith.constant {lit} : {ty}")),
        }
        self.define(v, ty)
    }

    /// A literal of `ty`: edge values often, else anything in range.
    fn literal(&mut self, ty: Ty) -> String {
        match ty {
            Ty::I1 => String::from(if self.rng.chance(0.5) { "true" } else { "false" }),
            Ty::F32 | Ty::F64 => {
                let hex = if ty == Ty::F32 { ["0x7F800000", "0xFF800000", "0x7FC00000", "0x00000001"] } else { ["0x7FF0000000000000", "0xFFF0000000000000", "0x7FF8000000000000", "0x0000000000000001"] };
                match self.rng.below(8) {
                    0 => String::from(*self.rng.pick(&hex)),
                    1 => String::from(*self.rng.pick(&["0.000000e+00", "-0.000000e+00", "1.000000e+00", "-1.000000e+00", "5.000000e-01"])),
                    _ => {
                        let exp = self.rng.range(0, 24) as i32 - 12;
                        let mant = (self.rng.next() % 2_000_000) as f64 / 100_000.0 - 10.0;
                        // As MLIR prints one: a signed two-digit exponent (`1.500000e+00`).
                        let lit = format!("{:.6e}", mant * 10f64.powi(exp));
                        let (m, e) = lit.split_once('e').expect("{:e} has an exponent");
                        let e: i32 = e.parse().expect("an integer exponent");
                        format!("{m}e{}{:02}", if e < 0 { '-' } else { '+' }, e.abs())
                    }
                }
            }
            _ => {
                let w = ty.width();
                let (min, max) = (-(1i128 << (w - 1)), (1i128 << (w - 1)) - 1);
                let v = match self.rng.below(6) {
                    0 => *self.rng.pick(&[min, max, -1, 0, 1]),
                    1 => self.rng.range(0, 64) as i128,
                    _ => (self.rng.next() as i128 % (max - min + 1)) + min,
                };
                v.clamp(min, max).to_string()
            }
        }
    }

    fn func(&mut self, i: usize) {
        let (args, results) = (self.tys(4), self.tys(3));
        let name = format!("f{i}");
        let mut frame = Frame::default();
        let params: Vec<String> = args.iter().enumerate().map(|(k, t)| {
            frame.vals.push(Val { name: format!("%arg{k}"), ty: *t });
            format!("%arg{k}: {t}")
        }).collect();
        let ret = match results.len() {
            0 => String::new(),
            _ => format!(" -> ({})", Tys(&results)),
        };
        self.line(format_args!("func.func @{name}({}){ret} {{", params.join(", ")));
        self.indent += 2;
        self.frames.push(frame);
        self.block(0);
        let vals: Vec<String> = results.iter().map(|t| self.value(*t)).collect();
        match results.len() {
            0 => self.line(format_args!("return")),
            _ => self.line(format_args!("return {} : {}", vals.join(", "), Tys(&results))),
        }
        self.frames.pop();
        self.indent -= 2;
        self.line(format_args!("}}"));
        self.sigs.push(Sig { name, args, results });
    }

    fn block(&mut self, depth: usize) {
        for _ in 0..self.rng.range(1, self.shape.ops) {
            self.op(depth);
        }
    }

    fn op(&mut self, depth: usize) {
        match Kind::ALL[self.rng.weighted(Kind::WEIGHTS)] {
            Kind::Const => {
                let t = self.ty();
                self.constant(t);
            }
            Kind::IntBin => {
                let t = *self.rng.pick(&[Ty::I1, Ty::I8, Ty::I16, Ty::I32, Ty::I64, Ty::Index]);
                let op = *self.rng.pick(INT_BIN);
                let (a, b) = (self.value(t), self.value(t));
                let v = self.fresh();
                self.line(format_args!("{v} = arith.{op} {a}, {b} : {t}"));
                self.define(v, t);
            }
            Kind::FloatBin => {
                let t = *self.rng.pick(&[Ty::F32, Ty::F64]);
                let op = *self.rng.pick(FLOAT_BIN);
                let (a, b) = (self.value(t), self.value(t));
                let v = self.fresh();
                self.line(format_args!("{v} = arith.{op} {a}, {b} : {t}"));
                self.define(v, t);
            }
            Kind::Cmp => {
                let t = self.ty();
                let (op, pred) = if t.float() { ("cmpf", *self.rng.pick(CMPF)) } else { ("cmpi", *self.rng.pick(CMPI)) };
                let (a, b) = (self.value(t), self.value(t));
                let v = self.fresh();
                self.line(format_args!("{v} = arith.{op} {pred}, {a}, {b} : {t}"));
                self.define(v, Ty::I1);
            }
            Kind::Select => {
                let t = self.ty();
                let (c, a, b) = (self.value(Ty::I1), self.value(t), self.value(t));
                let v = self.fresh();
                self.line(format_args!("{v} = arith.select {c}, {a}, {b} : {t}"));
                self.define(v, t);
            }
            Kind::Cast => self.cast(),
            Kind::Math => {
                let (t, op) = if self.rng.chance(0.5) { (*self.rng.pick(&[Ty::F32, Ty::F64]), *self.rng.pick(MATH_F)) } else { (*self.rng.pick(&Ty::INTS[1..]), *self.rng.pick(MATH_I)) };
                let a = self.value(t);
                let v = self.fresh();
                self.line(format_args!("{v} = math.{op} {a} : {t}"));
                self.define(v, t);
            }
            Kind::If if depth < self.shape.depth => self.scf_if(depth),
            Kind::For if depth < self.shape.depth => self.scf_for(depth),
            Kind::Mem => self.mem(),
            Kind::Call if !self.sigs.is_empty() => self.call(),
            _ => {
                let t = self.ty();
                self.constant(t);
            }
        }
    }

    /// One of arith's casts, between types it accepts.
    fn cast(&mut self) {
        let (op, (a, from), to) = match self.rng.below(7) {
            0 => {
                let (a, from) = self.value_where(|t| t.int() && t.width() < 64, Ty::I8);
                let to = *self.rng.pick(&Ty::INTS.iter().copied().filter(|t| t.width() > from.width()).collect::<Vec<_>>());
                (*self.rng.pick(&["extsi", "extui"]), (a, from), to)
            }
            1 => {
                let (a, from) = self.value_where(|t| t.int() && t.width() > 1, Ty::I32);
                let to = *self.rng.pick(&Ty::INTS.iter().copied().filter(|t| t.width() < from.width()).collect::<Vec<_>>());
                ("trunci", (a, from), to)
            }
            2 => {
                let (a, from) = self.value_where(|t| t.int() || t == Ty::Index, Ty::Index);
                let to = if from == Ty::Index { *self.rng.pick(&Ty::INTS) } else { Ty::Index };
                (*self.rng.pick(&["index_cast", "index_castui"]), (a, from), to)
            }
            3 => {
                let (a, from) = self.value_where(Ty::int, Ty::I32);
                (*self.rng.pick(&["sitofp", "uitofp"]), (a, from), *self.rng.pick(&[Ty::F32, Ty::F64]))
            }
            4 => {
                let (a, from) = self.value_where(Ty::float, Ty::F32);
                (*self.rng.pick(&["fptosi", "fptoui"]), (a, from), *self.rng.pick(&Ty::INTS[1..]))
            }
            5 => {
                let (a, from) = self.value_where(Ty::float, Ty::F32);
                match from {
                    Ty::F32 => ("extf", (a, from), Ty::F64),
                    _ => ("truncf", (a, from), Ty::F32),
                }
            }
            _ => {
                let (a, from) = self.value_where(|t| matches!(t, Ty::I32 | Ty::I64 | Ty::F32 | Ty::F64), Ty::I32);
                let to = match from {
                    Ty::I32 => Ty::F32,
                    Ty::F32 => Ty::I32,
                    Ty::I64 => Ty::F64,
                    _ => Ty::I64,
                };
                ("bitcast", (a, from), to)
            }
        };
        let v = self.fresh();
        self.line(format_args!("{v} = arith.{op} {a} : {from} to {to}"));
        self.define(v, to);
    }

    /// The results of an op making `tys.len()` of them: their names, defined in the block.
    fn results(&mut self, tys: &[Ty]) -> (String, Vec<String>) {
        let v = self.fresh();
        let names: Vec<String> = match tys.len() {
            1 => vec![v.clone()],
            _ => (0..tys.len()).map(|k| format!("{v}#{k}")).collect(),
        };
        let lhs = match tys.len() {
            0 => String::new(),
            1 => format!("{v} = "),
            n => format!("{v}:{n} = "),
        };
        (lhs, names)
    }

    fn define_all(&mut self, names: Vec<String>, tys: &[Ty]) {
        for (n, t) in names.into_iter().zip(tys) {
            self.define(n, *t);
        }
    }

    /// A nested block: ops, then `scf.yield` of `tys` (bare when there are none).
    fn region(&mut self, depth: usize, frame: Frame, tys: &[Ty]) {
        self.indent += 2;
        self.frames.push(frame);
        self.block(depth + 1);
        if !tys.is_empty() {
            let vals: Vec<String> = tys.iter().map(|t| self.value(*t)).collect();
            self.line(format_args!("scf.yield {} : {}", vals.join(", "), Tys(tys)));
        }
        self.frames.pop();
        self.indent -= 2;
    }

    fn scf_if(&mut self, depth: usize) {
        let tys = self.tys(2);
        let c = self.value(Ty::I1);
        let (lhs, names) = self.results(&tys);
        let ret = if tys.is_empty() { String::new() } else { format!(" -> ({})", Tys(&tys)) };
        self.line(format_args!("{lhs}scf.if {c}{ret} {{"));
        self.region(depth, Frame::default(), &tys);
        if !tys.is_empty() || self.rng.chance(0.5) {
            self.line(format_args!("}} else {{"));
            self.region(depth, Frame::default(), &tys);
        }
        self.line(format_args!("}}"));
        self.define_all(names, &tys);
    }

    fn scf_for(&mut self, depth: usize) {
        let tys = self.tys(2);
        let (lb, ub) = (self.value(Ty::Index), self.value(Ty::Index));
        let step = self.fresh();
        let s = self.rng.range(1, 4);
        self.line(format_args!("{step} = arith.constant {s} : index"));
        let inits: Vec<String> = tys.iter().map(|t| self.value(*t)).collect();
        let (lhs, names) = self.results(&tys);
        let iv = self.fresh();
        let mut frame = Frame::default();
        frame.vals.push(Val { name: iv.clone(), ty: Ty::Index });
        let iters = match tys.len() {
            0 => String::new(),
            _ => {
                let pairs: Vec<String> = tys.iter().zip(&inits).map(|(t, init)| {
                    let a = self.fresh();
                    frame.vals.push(Val { name: a.clone(), ty: *t });
                    format!("{a} = {init}")
                }).collect();
                format!(" iter_args({}) -> ({})", pairs.join(", "), Tys(&tys))
            }
        };
        self.line(format_args!("{lhs}scf.for {iv} = {lb} to {ub} step {step}{iters} {{"));
        self.region(depth, frame, &tys);
        self.line(format_args!("}}"));
        self.define_all(names, &tys);
    }

    /// An alloca, or a load / store on one in scope (constant index in bounds).
    fn mem(&mut self) {
        let mems: Vec<Val> = self.frames.iter().flat_map(|f| f.mems.iter().cloned()).collect();
        if mems.is_empty() || self.rng.chance(0.2) {
            let t = *self.rng.pick(&Ty::ALL[1..]);
            let m = self.fresh();
            self.line(format_args!("{m} = memref.alloca() : memref<4x{t}>"));
            self.frames.last_mut().expect("in a block").mems.push(Val { name: m, ty: t });
            return;
        }
        let Val { name: m, ty: t } = self.rng.pick(&mems).clone();
        let i = self.fresh();
        let at = self.rng.below(4);
        self.line(format_args!("{i} = arith.constant {at} : index"));
        if self.rng.chance(0.5) {
            let v = self.value(t);
            self.line(format_args!("memref.store {v}, {m}[{i}] : memref<4x{t}>"));
        } else {
            let v = self.fresh();
            self.line(format_args!("{v} = memref.load {m}[{i}] : memref<4x{t}>"));
            self.define(v, t);
        }
    }

    fn call(&mut self) {
        let k = self.rng.below(self.sigs.len());
        let (name, args, results) = (self.sigs[k].name.clone(), self.sigs[k].args.clone(), self.sigs[k].results.clone());
        let ops: Vec<String> = args.iter().map(|t| self.value(*t)).collect();
        let (lhs, names) = self.results(&results);
        self.line(format_args!("{lhs}func.call @{name}({}) : ({}) -> ({})", ops.join(", "), Tys(&args), Tys(&results)));
        self.define_all(names, &results);
    }
}
