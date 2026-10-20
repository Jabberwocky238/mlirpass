# mlirpass

MLIR passes in Rust: mutable IR, pattern rewriting, dialect conversion, the pass manager, and the
upstream lowerings and transforms — on top of [mlirformat](https://github.com/Jabberwocky238/mlirformat),
which owns the syntax (MLIR text ⇄ IR ⇄ typed Rust ops).

MLIR behavior follows **MLIR 22.1.8** (llvm-project `llvmorg-22.1.8`): every pass is checked against
what `mlir-opt` 22.1.8 prints for the same input and pipeline.

## Status

Skeleton. The layout below is the plan; each part lands with its fixtures counted.

| part | what it is | upstream |
|---|---|---|
| `ir` | arena IR with use-def chains; `Module` ⇄ IR | `mlir/IR` |
| `pass` | pass manager, `--pass-pipeline` syntax, registry | `mlir/Pass` |
| `rewrite` | patterns, rewriter, greedy driver, folding | `PatternMatch`, `GreedyPatternRewriteDriver` |
| `conversion` | conversion target, type converter, dialect conversion | `DialectConversion` |
| `lower` | dialect → `llvm`, → `spirv`, → `emitc`, and between dialects | `mlir/lib/Conversion` |
| `transforms` | `canonicalize`, `cse`, `sccp`, `inline`, `symbol-dce`, ... | `mlir/lib/Transforms` |

Dialects: every dialect mlirformat describes.

## Declaring passes and lowerings

Passes and pattern sets are declared with the proc macros of `mlirpass-macros` (`macros/`),
not written out by hand:

```rust
/// A pass with options: its fields are the `Passes.td` options.
#[pass("convert-complex-to-llvm")]
pub struct ConvertComplexToLlvm {
    #[opt("complex-range", default = ComplexRange::Basic, from_str)]
    range: ComplexRange,
}

impl Run for ConvertComplexToLlvm {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> { /* ... */ }
}

/// A pass without options: the fn is its `run`, the struct `Sccp` is generated.
#[pass("sccp")]
pub fn sccp<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> { /* ... */ }

/// Lowerings: each `#[lowering]` method goes into the generated `populate`.
#[patterns(converter, improved: bool)]
impl ComplexToLlvm {
    #[lowering("complex.add", "complex.sub")]
    fn arith(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool { /* ... */ }

    #[lowering("complex.div", when = improved)]
    fn div_improved(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool { /* ... */ }
}
```

Rows that differ only in their target are generated whole with `#[map]` on the same `impl`:

```rust
#[patterns(converter)]
#[map("arith.addf" => "llvm.fadd", fastmath, fp)]            // the one-to-one rewrite itself
#[map("arith.shli" => "emitc.bitwise_left_shift", via = Self::shift(true))] // a family template
impl ArithToLlvm { /* the special cases, as #[lowering] methods */ }
```

Arithmetic is written as arithmetic: `#[ops(b, fmf = f)]` turns `+ - * / & | ^ << >>`, unary
`-` and float literals into ops built through `b`, in C++'s creation order; with
`#[patterns(builder = ctor)]` a `#[lowering]` is declared by its signature (operands, attributes
read off the op, the replacement as the return value):

```rust
#[lowering("complex.mul")]
#[ops(b, fmf = fmf)]
fn mul(b: &mut Cx<'_, '_, '_, '_>, l: ValueId, r: ValueId, fmf: Fmf) -> ValueId {
    let (lr, li, rr, ri) = (b.re(l), b.im(l), b.re(r), b.im(r));
    let re = lr * rr - li * ri;
    let im = li * rr + lr * ri;
    b.create(re, im)
}
```

Control flow is written as its blocks, in their final order, with `blocks!`:

```rust
blocks!(f;
    entry(base: t.clone(), power: t.clone()) { f.cond_br(f.cmpi(EQ, power, zero), done, &[], body, &[]); }
    body { f.br(done, &[base * base]); }
    done(r: t.clone()) { f.ret(&[r]); }
);
```

`#[pass("name", on = "op", extra = [..], check = path)]` gives the `mlir-opt` name, the anchor
op, options accepted but unused, and a validation hook. `#[patterns]` takes `converter` (a type
converter index), `options = T` (methods also take the options), `extra = path` (non-method
patterns) and `flag: T` parameters; `#[lowering]` takes the roots, `benefit`, `when`, `untyped`
and `plain`.

Nothing is global. Pipelines name passes through a `PassRegistry` (`Passes::upstream()` registers
every pass: `Invocation::parse(&passes, args)`); a `Body` asks its context (`&dyn OpRegistry`,
mlirformat's) what it knows of ops; `convert-to-llvm` / `convert-to-emitc` ask the
`DialectInterfaces` they hold which dialects have an interface and what each adds.

## Fixtures

`tests/fixtures/` holds `mlir-opt` 22.1.8's own output for llvm-project's `mlir/test/Conversion`,
`mlir/test/Transforms` and the dialects' `canonicalize*.mlir`, one `RUN:` line each, so the tests
need no LLVM. Regenerate with a vanilla 22.1.8 build:

```sh
python3 scripts/fixtures.py --llvm $LLVM --mlir-opt $LLVM_BUILD/bin/mlir-opt
```

## License

MIT
