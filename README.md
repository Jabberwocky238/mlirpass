# mlirpass

MLIR passes in Rust: mutable IR, pattern rewriting, dialect conversion, the pass manager, and the
upstream lowerings and transforms — on top of [mlirformat](https://github.com/Jabberwocky238/mlirformat),
which owns the syntax (MLIR text ⇄ IR ⇄ typed Rust ops).

MLIR behavior follows **MLIR 22.1.8** (llvm-project `llvmorg-22.1.8`): every pass is checked against
what `mlir-opt` 22.1.8 prints for the same input and pipeline.

## Status

`0.8.1`: 6717 of the 7333 fixture cases match `mlir-opt` 22.1.8 byte for byte
(`cargo test --test passes -- --nocapture` counts them per group), MLIR's own `Dialect/SPIRV`,
`Dialect/GPU` and `*ToSPIRV` tests included, and the three GPU vendors' lowerings: Intel
(`convert-xegpu-to-xevm`, `convert-vector-to-xegpu`, `convert-gpu-to-llvm-spv`,
`convert-math-to-xevm`, xevm ⇒ llvm), NVIDIA (`convert-gpu-to-nvvm`, `convert-nvgpu-to-nvvm`,
`convert-nvvm-to-llvm`) and AMD (`convert-gpu-to-rocdl`, `convert-amdgpu-to-rocdl`,
`convert-arith-to-amdgpu`, `convert-math-to-rocdl`, `convert-complex-to-rocdl-library-calls`). All 13 of MLIR's `Integration/GPU/Vulkan` tests
produce the numbers their checks expect, run on Vulkan (lavapipe) both as SPIR-V and as GLSL
(`cargo test --test vulkan`); with `VULKAN_ICD=/usr/share/vulkan/icd.d/intel_icd.json` they run on an Intel GPU
(checked on Panther Lake graphics), where a KHR cooperative matrix kernel lowered with the device's
own target env (`tests/support/vkinfo.c`) is checked against the host's product too.

| part | what it is | upstream |
|---|---|---|
| `ir` | arena IR with use-def chains (an op's operands, results, successors and regions inline up to four, `Ids`); `Module` ⇄ IR; printed straight from the IR (`Body::show`, read through mlirformat's `Source`); cloning (`Mapping`) | `mlir/IR` |
| `pass` | pass manager, `--pass-pipeline` syntax, the registry (`registry.gen.rs`), the `mlir-opt` command line (`Invocation`), the verifiers run after each pass, and `Exec` ([moremath](https://crates.io/crates/moremath)'s `ThreadMulti`, or any `Executor` — the kind mlirformat's `parse_in` / `print_in` take too): nested pipelines over isolated ops (functions) as parallel tasks | `mlir/Pass`, `OpToOpPassAdaptor`, `MlirOptMain` |
| `rewrite` | patterns, rewriter, greedy and walk drivers | `PatternMatch`, `GreedyPatternRewriteDriver`, `WalkPatternRewriteDriver` |
| `region` | region simplification (unreachable blocks, region DCE, block merging) and dominance | `RegionUtils`, `Dominance` |
| `conversion` | conversion target, type converter, dialect conversion, `#[convert]`s as patterns, the `DialectInterfaces` trait `convert-to-*` asks | `DialectConversion` |
| `interfaces` | op traits, op interfaces (`OpInterfaces`), `BranchOpInterface` / `RegionBranchOpInterface`, memory effects, symbols and symbol tables | `mlir/Interfaces`, `SymbolTable` |
| `layout` | `MemrefLayout` (strides, offset), `DataLayout` (type sizes, alignments, index bitwidth) | `BuiltinTypes`, `DataLayoutInterfaces` |
| `patterns` | ⭐ rule sets, one directory per source dialect: `<d>/canonicalize.rs` (its folds, constant materialization and canonicalization patterns, `<D>Canon`), `<d>/to_<target>.rs` (`scf/to_cf.rs`, `arith/to_llvm.rs`), and its own transforms' rules | `*Ops.cpp`, `mlir/lib/Conversion`, `Dialect/*/Transforms` |
| `passes` | ⭐ pipeline units, one directory per source dialect, one file per pass (`scf/convert_scf_to_cf.rs`, `linalg/linalg_fold_unit_extent_dims.rs`); `transforms/` the dialect-independent ones | `mlir/lib/Conversion`, `Dialect/*/Transforms`, `mlir/lib/Transforms` |
| `dialects` | each upstream dialect's `OpInterfaces`, one unit struct each (`ScfDialect`, ...) | `mlir/lib/Dialect/*/IR` |
| `targets` | the `Emit` trait, and what each backend below shares (type converters, `convert-to-*` interfaces, serializers) | `mlir-translate` |

Two kinds of cargo features, all on by default (`all-dialects`, `all-targets`), so a user builds
only what it runs (`default-features = false, features = ["std", "dialect.scf", "dialect.arith",
"target.llvm"]`):

- `dialect.<name>` (`dialect.scf`, `dialect.linalg`, ...): one dialect's op interfaces, folds,
  canonicalization patterns, its own transforms and its lowerings to other dialects
  (`dialects/<name>.rs`, `patterns/<name>/`, `passes/<name>/`). A dialect whose code uses another's
  turns that one on (`dialect.math` = `dialect.arith`). Without a dialect's feature its ops still
  parse and print (mlirformat knows them all); they are just opaque to folds and patterns.
- `target.<backend>`: a backend, below. Its rules and passes sit in `patterns/` / `passes/` like
  any other (`arith/to_llvm.rs` needs `dialect.arith` and `target.llvm`); `src/targets` keeps what
  they share.

| feature | what it is | upstream |
|---|---|---|
| `target.llvm` | the type converter, dialect → `llvm` (the CPU's `x86vector` / `amx` too: `convert-vector-to-llvm=enable-x86vector,enable-amx`); `dialect.llvm` (the llvm folds, the llvm memory-slot interfaces) | `mlir/lib/Conversion/*ToLLVM`, `Dialect/LLVMIR` |
| `target.emitc` | dialect → `emitc`: the EmitC type converter, `convert-to-emitc` | `mlir/lib/Conversion/*ToEmitC` |
| `target.spirv` | target env, type converter, `gpu` / `func` / `arith` / `cf` / `complex` / `index` / `math` / `memref` / `scf` / `tensor` / `vector` / `ub` → `spirv`, `spirv-lower-abi-attrs`, `spirv-update-vce`, the spirv dialect's own transforms (`spirv-canonicalize-gl`, `spirv-unify-aliased-resource`, `spirv-rewrite-inserts`, `spirv-promote-to-replicated-constants`, `spirv-webgpu-prepare`, `decorate-spirv-composite-type-layout`); `SpirvBinary` (the serializer) and `SpirvGlsl` (GLSL 4.50) emit | `mlir/lib/Conversion/*ToSPIRV`, `Target/SPIRV` |

Dialects: every dialect mlirformat describes parses and prints; those with a `dialect.*` feature
also fold, canonicalize and lower.

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

/// Conversion patterns: each `#[convert]` method goes into the generated `populate`.
#[patterns(converter, improved: bool)]
impl ComplexToLlvm {
    #[convert("complex.add", "complex.sub")]
    fn arith(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool { /* ... */ }

    #[convert("complex.div", when = improved)]
    fn div_improved(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool { /* ... */ }
}
```

Rows that differ only in their target are generated whole with `#[map]` on the same `impl`:

```rust
#[patterns(converter)]
#[map("arith.addf" => "llvm.fadd", fastmath, fp)]            // the one-to-one rewrite itself
#[map("arith.shli" => "emitc.bitwise_left_shift", via = Self::shift(true))] // a family template
impl ArithToLlvm { /* the special cases, as #[convert] methods */ }
```

Arithmetic is written as arithmetic: `#[ops(b, fmf = f)]` turns `+ - * / & | ^ << >>`, unary
`-` and float literals into ops built through `b`, in C++'s creation order; with
`#[patterns(builder = ctor)]` a `#[convert]` is declared by its signature (operands, attributes
read off the op, the replacement as the return value):

```rust
#[convert("complex.mul")]
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
patterns) and `flag: T` parameters; `#[convert]` takes the roots (`_`: any op), `benefit`, `when`, `untyped`
and `plain`.

Rewrite patterns (same-dialect rewrites: canonicalization, a transform's rules) are `#[rewrite]`
methods of a `#[patterns]` impl: each becomes a unit struct implementing `Pattern` (named after
the method in CamelCase, or `name = ".."`), with its root op (`_`: any op, for interface patterns
such as `EraseDeadLinalgOp`) and benefit; the generated `patterns(set)` adds them all in order,
and `populate` adds them as conversion patterns too:

```rust
#[patterns]
impl TensorCanon {
    /// `FoldFillWithTensorExtract`: an element of a fill is the fill value.
    #[rewrite("tensor.extract")]
    fn fold_fill_with_tensor_extract(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let Some(f) = rw.body.def_named(rw.body[op].operands[0], "linalg.fill") else { return false };
        let v = rw.body[f].operands[0];
        rw.replace_op(op, &[v]);
        true
    }
}
```

`mem2reg` / `sroa` ask the memory-slot interfaces (`src/passes/transforms/memslot.rs`) as traits a
dialect implements once for its ops by name: `Promotable` and `Destructurable`, on the unit
structs `LlvmSlots` and `MemrefSlots`.

Threads: a `Body` is arenas, one per function (`Seg`; ids are `(seg, index)`), so a function
moves to a thread and back without a copy (`Body::lend`). Reading (`Body::parse_in`), importing,
printing (`Body::show_in`), nested pipelines, the conversions to LLVM and `convert-scf-to-cf`
(`#[pass(.., local)]`: function by function, what goes into the module merged back in serial
order), `sccp` and `remove-dead-values` (their data-flow solved per function, exchanging each
callable's callers and returns round after round) all use the threads; the output is the serial
one, byte for byte.

Nested pipelines run in parallel: `PassManager::run_on(body, op, &ThreadMulti::default())` moves
each op of a nested pipeline that is `IsolatedFromAbove` (`llvm.func(...)`, `func.func(...)`) into
a body of its own and runs them as the pool's tasks; the result is the same as on one thread
(`-mlir-disable-threading`: `ThreadMulti::from(1)`, starting no thread). `run_on`, `Body::parse_in` and `Body::show_in`
take any moremath `Executor`: one pool reads, imports, runs and prints. The command line threads by default, as `mlir-opt`.

Nothing is global. Pipelines name passes through a `PassRegistry` (`Invocation::parse(&passes, args)`);
passes are registered by functions cascaded with `Passes::with`: `Passes::new().with(Passes::add_upstream).with(my_passes)`.
`Passes::add_upstream` (`Passes::upstream()` alone) registers every pass compiled in; it is
`src/registry.gen.rs`, generated by `scripts/registry.py` from the `#[pass]`es under `src/`, each under
the `cfg`s of the `mod`s leading to it (rerun it after adding a pass; `--check` fails when it is stale). A `Body`
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

## Fuzzing

`fuzz/` (a crate of its own) generates random valid IR and runs it through mlirpass and
`mlir-opt` 22.1.8 side by side, every non-exact case saved; it also times both on big modules
(`fuzz/README.md`).

## Performance

Against `mlir-opt` 22.1.8 on a 54 MB module (`BENCHMARK.md`), parse + passes + print on 16
threads against threaded `mlir-opt`: the `-to-llvm` pipeline 4.68×, sccp 4.18×, mem2reg 4.14×,
cse 4.09×, convert-scf-to-cf 3.85×, LICM 3.84×, canonicalize + cse 3.23×; as whole processes on
16 CPUs 2.1–3.0×, on one thread 0.96–1.44×. With jemalloc instead of glibc malloc, a process
runs canonicalize + cse 5.45× and the `-to-llvm` pipeline 4.77× faster than `mlir-opt`. Peak
memory is 2.1–2.9× `mlir-opt`'s (1.0× for sccp).

## License

MIT
