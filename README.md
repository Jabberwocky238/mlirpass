# mlirpass

MLIR passes in Rust: mutable IR, pattern rewriting, dialect conversion, the pass manager, and the
upstream lowerings and transforms — on top of [mlirformat](https://github.com/Jabberwocky238/mlirformat),
which owns the syntax (MLIR text ⇄ IR ⇄ typed Rust ops).

MLIR behavior follows **MLIR 22.1.8** (llvm-project `llvmorg-22.1.8`): every pass is checked against
what `mlir-opt` 22.1.8 prints for the same input and pipeline.

## Status

`0.3.0`: 4543 of the 5001 fixture cases match `mlir-opt` 22.1.8 byte for byte
(`cargo test --test passes -- --nocapture` counts them per group), MLIR's own `Dialect/SPIRV`,
`Dialect/GPU` and `*ToSPIRV` tests included. All 13 of MLIR's `Integration/GPU/Vulkan` tests
produce the numbers their checks expect, run on Vulkan (lavapipe) both as SPIR-V and as GLSL
(`cargo test --test vulkan`).

| part | what it is | upstream |
|---|---|---|
| `ir` | arena IR with use-def chains; `Module` ⇄ IR | `mlir/IR` |
| `pass` | pass manager, `--pass-pipeline` syntax, registry | `mlir/Pass` |
| `parallel` | `Executor` (`Serial`, `ThreadPool`): nested pipelines over isolated ops (functions) as parallel tasks | `OpToOpPassAdaptor`, `llvm::ThreadPool` |
| `rewrite`, `greedy` | patterns, rewriter, greedy driver | `PatternMatch`, `GreedyPatternRewriteDriver` |
| `canon` | folding (`Fold`) and each dialect's folds and canonicalization patterns | `Operation::fold`, `*Ops.cpp` |
| `conversion` | conversion target, type converter, dialect conversion, `#[lowering]`s as patterns, the `DialectInterfaces` trait `convert-to-*` asks | `DialectConversion` |
| `interfaces`, `branch`, `effects` | op traits, op interfaces, `BranchOpInterface` / `RegionBranchOpInterface`, memory effects | `mlir/Interfaces` |
| `layout` | `MemrefLayout` (strides, offset), `DataLayout` (type sizes, alignments, index bitwidth) | `BuiltinTypes`, `DataLayoutInterfaces` |
| `lower` | between dialects (no llvm, no emitc, no spirv) | `mlir/lib/Conversion` |
| `dialects` | each upstream dialect's `OpInterfaces`, one unit struct each (`ScfDialect`, ...) | `mlir/lib/Dialect/*/IR` |
| `transforms` | `canonicalize`, `cse`, `sccp`, `inline`, `symbol-dce`, `mem2reg`, `sroa`, ... (dialect-independent) | `mlir/lib/Transforms` |
| `emits` | the `Emit` trait, and the backends below | `mlir-translate` |

The backends live under `src/emits`, one cargo feature each (all on by default):

| feature | what it is | upstream |
|---|---|---|
| `llvm` | the type converter, dialect → `llvm`, the llvm folds, the llvm memory-slot interfaces | `mlir/lib/Conversion/*ToLLVM`, `Dialect/LLVMIR` |
| `emitc` | dialect → `emitc`: the EmitC type converter, `convert-to-emitc` | `mlir/lib/Conversion/*ToEmitC` |
| `spirv` | target env, type converter, `gpu` / `func` / `arith` / `cf` / `complex` / `index` / `math` / `memref` / `scf` / `tensor` / `vector` / `ub` → `spirv`, `spirv-lower-abi-attrs`, `spirv-update-vce`, the spirv dialect's own transforms (`spirv-canonicalize-gl`, `spirv-unify-aliased-resource`, `spirv-rewrite-inserts`, `spirv-promote-to-replicated-constants`, `spirv-webgpu-prepare`, `decorate-spirv-composite-type-layout`); `SpirvBinary` (the serializer) and `SpirvGlsl` (GLSL 4.50) emit | `mlir/lib/Conversion/*ToSPIRV`, `Target/SPIRV` |

Dialects: every dialect mlirformat describes.

## Declaring passes and lowerings

Passes and pattern sets are declared with the proc macros of `mlirpass-macros` (`macros/`),
re-exported by mlirpass (`use mlirpass::{pass, patterns, ops, blocks};`, inside the crate
`use crate::pass;`), not written out by hand:

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
op, options accepted but unused, and a validation hook; on a `fn` pass, `ty = Name` names the
generated struct (default: the name in CamelCase). `#[patterns]` takes `converter` (a type
converter index), `options = T` (methods also take the options), `extra = path` (non-method
patterns) and `flag: T` parameters; `#[lowering]` takes the roots, `benefit`, `when`, `untyped`
and `plain`.

Inside the crate, canonicalization patterns (`src/canon/*.rs`) are declared with the
`rewrites!` macro: one unit struct per pattern, its root op (`_`: any op, for interface
patterns such as `EraseDeadLinalgOp`), its benefit, and a body that matches and rewrites:

```rust
rewrites! {
    /// `FoldFillWithTensorExtract`: an element of a fill is the fill value.
    FoldFillWithTensorExtract("tensor.extract", 1) |rw, op| {
        let Some(f) = rw.body.def_named(rw.body[op].operands[0], "linalg.fill") else { return false };
        let v = rw.body[f].operands[0];
        rw.replace_op(op, &[v]);
        true
    }
}
```

`mem2reg` / `sroa` ask the memory-slot interfaces (`src/transforms/memslot.rs`) as traits a
dialect implements once for its ops by name: `Promotable` and `Destructurable`, on the unit
structs `LlvmSlots` and `MemrefSlots`.

Nested pipelines run in parallel: `PassManager::run_on(body, op, &ThreadPool::default())` moves
each op of a nested pipeline that is `IsolatedFromAbove` (`llvm.func(...)`, `func.func(...)`) into
a body of its own and runs them as the pool's tasks; the result is the same as with `Serial`
(`run`, `-mlir-disable-threading`). The command line threads by default, as `mlir-opt`.

Nothing is global. Pipelines name passes through a `PassRegistry` (`Invocation::parse(&passes, args)`);
each module declares its passes as a `PassSet` (`pass_set!(LlvmPasses: ConvertArithToLlvm, ...)`):
`Passes::new().with::<LlvmPasses>()` registers just those, `Passes::upstream()` every set. A `Body`
asks its `Ctx` what it knows of ops: mlirformat's `MlirOpt` (the loaded dialects, ODS's table) and
the `Interfaces` holding each dialect's `OpInterfaces` (what upstream computes in C++: effects,
speculatability, branch and region-branch successors, calls), so core names no dialect's op
(`Body::parse(Ctx::new(&opt, &Interfaces::upstream()), src)`). `convert-to-llvm` / `convert-to-emitc` ask the
`DialectInterfaces` they hold which dialects have an interface and what each adds.

## Fixtures

`tests/fixtures/` holds `mlir-opt` 22.1.8's own output for llvm-project's `mlir/test/Conversion`,
`mlir/test/Transforms` and the dialects' `canonicalize*.mlir`, `mem2reg*.mlir` and `sroa*.mlir`, one `RUN:` line each, so the tests
need no LLVM. Regenerate with a vanilla 22.1.8 build:

```sh
python3 scripts/fixtures.py --llvm $LLVM --mlir-opt $LLVM_BUILD/bin/mlir-opt
```

## License

MIT
