# mlirpass

MLIR passes in Rust: mutable IR, pattern rewriting, dialect conversion, the pass manager, and the
upstream lowerings and transforms — on top of [mlirformat](https://github.com/Jabberwocky238/mlirformat),
which owns the syntax and the dialects (MLIR text ⇄ IR ⇄ typed Rust ops), and
[mlirbinary](https://github.com/Jabberwocky238/mlirbinary), which reads and writes the formats outside MLIR
(SPIR-V, MLIR bytecode, GLSL source). Both are required dependencies.

MLIR behavior follows **MLIR 23.1.5** (llvm-project `llvmorg-23.1.5`): every pass is checked against
what `mlir-opt` 23.1.5 prints for the same input and pipeline.

## Status

`0.11.0`: every fixture case of a ported pass matches `mlir-opt` 23.1.5 byte for byte (7616; the
other 671 of the 8287 run passes not ported yet; `cargo test --test passes -- --nocapture` counts
them per group), MLIR's own `Dialect/SPIRV`,
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
| `ir` | arena IR with use-def chains (an op's operands, results, successors and regions inline up to two, `Ids`); `Module` ⇄ IR; printed straight from the IR (`Body::show`, read through mlirformat's `Source`); cloning (`Mapping`) | `mlir/IR` |
| `pass` | pass manager, `--pass-pipeline` syntax, the registry (`registry.gen.rs`), the `mlir-opt` command line (`Invocation`), the verifiers run after each pass, and `Exec` ([moremath](https://crates.io/crates/moremath)'s `ThreadMulti`, or any `Executor` — the kind mlirformat's `parse_in` / `print_in` take too): nested pipelines over isolated ops (functions) as parallel tasks | `mlir/Pass`, `OpToOpPassAdaptor`, `MlirOptMain` |
| `rewrite` | patterns, rewriter, greedy and walk drivers | `PatternMatch`, `GreedyPatternRewriteDriver`, `WalkPatternRewriteDriver` |
| `region` | region simplification (unreachable blocks, region DCE, block merging) and dominance | `RegionUtils`, `Dominance` |
| `conversion` | conversion target, type converter, dialect conversion, `#[convert]`s as patterns, the `DialectInterfaces` trait `convert-to-*` asks | `DialectConversion` |
| `interfaces` | op traits, op interfaces (`OpInterfaces`), `BranchOpInterface` / `RegionBranchOpInterface`, memory effects, symbols and symbol tables | `mlir/Interfaces`, `SymbolTable` |
| `layout` | `MemrefLayout` (strides, offset), `DataLayout` (type sizes, alignments, index bitwidth) | `BuiltinTypes`, `DataLayoutInterfaces` |
| `patterns` | ⭐ rule sets, one directory per source dialect: `<d>/canonicalize.rs` (its folds, constant materialization and canonicalization patterns, `<D>Canon`), `<d>/to_<target>.rs` (`scf/to_cf.rs`, `arith/to_llvm.rs`), and its own transforms' rules | `*Ops.cpp`, `mlir/lib/Conversion`, `Dialect/*/Transforms` |
| `passes` | ⭐ pipeline units, one directory per source dialect, one file per pass (`scf/convert_scf_to_cf.rs`, `linalg/linalg_fold_unit_extent_dims.rs`); `transforms/` the dialect-independent ones | `mlir/lib/Conversion`, `Dialect/*/Transforms`, `mlir/lib/Transforms` |
| `dialects` | each upstream dialect's `OpInterfaces`, one unit struct each (`ScfDialect`, ...) | `mlir/lib/Dialect/*/IR` |
| `targets` | the `Emit` trait, and what each backend below shares (type converters, `convert-to-*` interfaces; binaries are mlirbinary's) | `mlir-translate` |

## Features

The default build has every upstream dialect and the three upstream backends (`all-dialects`,
`all-targets`); a user builds only what it runs (`default-features = false, features = ["std",
"dialect.scf", "dialect.arith", "target.llvm"]`):

- `dialect.<name>`: one dialect's op interfaces, folds, canonicalization patterns, its own
  transforms and its lowerings to other dialects (`dialects/<name>.rs`, `patterns/<name>/`,
  `passes/<name>/`). A dialect whose code uses another's turns that one on. Without a dialect's
  feature its ops still parse and print (mlirformat knows them all); they are just opaque to folds
  and patterns.
- `target.<backend>`: a backend. Its rules and passes sit in `patterns/` / `passes/` like any other
  (`arith/to_llvm.rs` needs `dialect.arith` and `target.llvm`); `src/targets` keeps what they share.
- The GPU instruction sets (`dialect.rdna2`, `dialect.agx`, `dialect.apple9`, `dialect.xe3`,
  `dialect.image`) and their `target.*`, and the GLSL source dialect (`dialect.glsl`), are in neither `all-*`. Their
  dialects are mlirformat's, their machine code and images are encoded by mlirbinary; mlirpass lowers to them.

A pass is listed under the feature that compiles it in, with the others it needs too
(`scripts/features.py` writes the table from `Cargo.toml` and `src/registry.gen.rs`):

<!-- features -->
| feature | default | what it is |
|---|---|---|
| `std` | yes | the standard library (without it the crate is `no_std` and needs `alloc`), threads (moremath's `ThreadMulti`, the default `Exec`), mlirformat's `std` |
| `cli` | yes | the `mlirpass` command line: `mlir-opt`'s, for the passes this crate has; turns on `std` |
| `all-dialects` | yes | every upstream `dialect.*` below (not the GPU instruction sets) |
| `all-targets` | yes | `target.llvm`, `target.emitc` and `target.spirv` |
| `dialect.acc` | yes | `acc`: its op interfaces, folds and patterns |
| `dialect.affine` | yes | `affine`: its op interfaces, folds and patterns; turns on `dialect.arith`; passes: `convert-affine-for-to-gpu`, `lower-affine` |
| `dialect.amdgpu` | yes | `amdgpu`: its op interfaces, folds and patterns; turns on `dialect.memref`; passes: `convert-amdgpu-to-rocdl` (with `target.llvm`), `convert-arith-to-amdgpu` (with `dialect.vector`, one of `target.emitc` / `target.llvm` / `target.spirv`) |
| `dialect.arith` | yes | `arith`: its op interfaces, folds and patterns; passes: `convert-arith-to-emitc` (with `target.emitc`), `convert-arith-to-llvm` (with `target.llvm`), `convert-arith-to-spirv` (with `target.spirv`) |
| `dialect.bufferization` | yes | `bufferization`: its op interfaces, folds and patterns; turns on `dialect.memref`; passes: `buffer-results-to-out-params`, `convert-bufferization-to-memref`, `drop-equivalent-buffer-results`, `one-shot-bufferize`, `promote-buffers-to-stack` |
| `dialect.cf` | yes | `cf`: its op interfaces, folds and patterns; passes: `convert-cf-to-llvm` (with `target.llvm`), `convert-cf-to-spirv` (with `target.spirv`), `lift-cf-to-scf` (with `dialect.scf`, `dialect.func`) |
| `dialect.complex` | yes | `complex`: its op interfaces, folds and patterns; turns on `dialect.arith`; passes: `convert-complex-to-libm`, `convert-complex-to-llvm` (with `target.llvm`), `convert-complex-to-rocdl-library-calls` (with `dialect.func`), `convert-complex-to-spirv` (with `target.spirv`), `convert-complex-to-standard` |
| `dialect.emitc` | yes | `emitc`: its op interfaces, folds and patterns |
| `dialect.func` | yes | `func`: its op interfaces, folds and patterns; passes: `convert-func-to-emitc` (with `target.emitc`), `convert-func-to-llvm` (with `target.llvm`), `convert-func-to-spirv` (with `target.spirv`) |
| `dialect.gpu` | yes | `gpu`: its op interfaces, folds and patterns; turns on `dialect.arith`, `dialect.memref`; passes: `convert-gpu-to-llvm-spv` (with `target.llvm`), `convert-gpu-to-nvvm` (with `target.llvm`, `dialect.nvvm`), `convert-gpu-to-rocdl` (with `target.llvm`, `dialect.amdgpu`, `dialect.math`), `convert-gpu-to-spirv` (with `target.spirv`, `dialect.func`, `dialect.scf`, `dialect.vector`), `gpu-kernel-outlining`, `gpu-launch-sink-index-computations`, `gpu-module-to-binary`, `xevm-attach-target` |
| `dialect.index` | yes | `index`: its op interfaces, folds and patterns; turns on `dialect.arith`; passes: `convert-index-to-llvm` (with `target.llvm`), `convert-index-to-spirv` (with `target.spirv`) |
| `dialect.linalg` | yes | `linalg`: its op interfaces, folds and patterns; turns on `dialect.arith`, `dialect.affine`, `dialect.memref`, `dialect.tensor`; passes: `convert-elementwise-to-linalg`, `convert-linalg-to-affine-loops`, `convert-linalg-to-loops`, `convert-linalg-to-parallel-loops`, `convert-tensor-to-linalg`, `convert-tensor-to-spirv` (with `target.spirv`, `dialect.func`), `linalg-fold-unit-extent-dims` |
| `dialect.llvm` | yes | `llvm`: its op interfaces, folds and patterns |
| `dialect.math` | yes | `math`: its op interfaces, folds and patterns; turns on `dialect.arith`, `dialect.vector`; passes: `convert-math-to-emitc` (with `target.emitc`), `convert-math-to-funcs`, `convert-math-to-libm`, `convert-math-to-llvm` (with `target.llvm`), `convert-math-to-rocdl` (with `target.llvm`), `convert-math-to-spirv` (with `target.spirv`), `convert-math-to-xevm` (with `target.llvm`) |
| `dialect.memref` | yes | `memref`: its op interfaces, folds and patterns; turns on `dialect.arith`, `dialect.affine`; passes: `convert-memref-to-emitc` (with `target.emitc`), `convert-memref-to-spirv` (with `target.spirv`), `expand-strided-metadata`, `finalize-memref-to-llvm` (with `target.llvm`), `fold-memref-alias-ops`, `map-memref-spirv-storage-class` (with `target.spirv`), `resolve-ranked-shaped-type-result-dims`, `resolve-shaped-type-result-dims` |
| `dialect.ml_program` | yes | `ml_program`: its op interfaces, folds and patterns |
| `dialect.mpi` | yes | `mpi`: its op interfaces, folds and patterns; turns on `dialect.arith` |
| `dialect.nvgpu` | yes | `nvgpu`: its op interfaces, folds and patterns; turns on `dialect.nvvm`, `dialect.memref`, `dialect.scf`, `dialect.arith`; passes: `convert-nvgpu-to-nvvm` (with `target.llvm`) |
| `dialect.nvvm` | yes | `nvvm`: its op interfaces, folds and patterns; passes: `convert-nvvm-to-llvm` (with `target.llvm`) |
| `dialect.omp` | yes | `omp`: its op interfaces, folds and patterns |
| `dialect.ptr` | yes | `ptr`: its op interfaces, folds and patterns |
| `dialect.quant` | yes | `quant`: its op interfaces, folds and patterns |
| `dialect.scf` | yes | `scf`: its op interfaces, folds and patterns; passes: `convert-parallel-loops-to-gpu` (with `dialect.gpu`), `convert-scf-to-cf`, `convert-scf-to-emitc` (with `target.emitc`), `convert-scf-to-spirv` (with `target.spirv`, `dialect.func`, `dialect.index`, `dialect.memref`), `gpu-map-parallel-loops` (with `dialect.gpu`) |
| `dialect.shape` | yes | `shape`: its op interfaces, folds and patterns; turns on `dialect.arith`; passes: `convert-shape-to-std` |
| `dialect.sparse_tensor` | yes | `sparse_tensor`: its op interfaces, folds and patterns |
| `dialect.spirv` | yes | `spirv`: its op interfaces, folds and patterns |
| `dialect.tensor` | yes | `tensor`: its op interfaces, folds and patterns; turns on `dialect.arith`, `dialect.affine` |
| `dialect.test` | yes | `test`: its op interfaces, folds and patterns |
| `dialect.tosa` | yes | `tosa`: its op interfaces, folds and patterns; passes: `tosa-to-arith`, `tosa-to-linalg`, `tosa-to-linalg-named`, `tosa-to-scf`, `tosa-to-tensor` |
| `dialect.ub` | yes | `ub`: its op interfaces, folds and patterns; passes: `convert-ub-to-llvm` (with `target.llvm`), `convert-ub-to-spirv` (with `target.spirv`) |
| `dialect.vector` | yes | `vector`: its op interfaces, folds and patterns; turns on `dialect.affine`, `dialect.arith`, `dialect.memref`, `dialect.ub`; passes: `convert-vector-to-llvm` (with `target.llvm`), `convert-vector-to-scf`, `convert-vector-to-spirv` (with `target.spirv`) |
| `dialect.x86` | yes | `x86`: its op interfaces, folds and patterns; turns on `dialect.memref` |
| `dialect.xegpu` | yes | `xegpu`: its op interfaces, folds and patterns; turns on `dialect.xevm`, `dialect.vector`, `dialect.memref`, `dialect.arith`, `dialect.index`, `dialect.scf`, `dialect.gpu`; passes: `convert-vector-to-xegpu`, `convert-xegpu-to-xevm` (with `target.llvm`) |
| `dialect.xevm` | yes | `xevm`: its op interfaces, folds and patterns; passes: `convert-xevm-to-llvm` (with `target.llvm`) |
| `dialect.agx` | no | Apple AGX (G13)'s instruction set and CDM command stream: the dialect is mlirformat's `agx`; building USC ops and ending streams are here (not an upstream dialect); turns on `dialect.image` |
| `dialect.apple9` | no | Apple9 (M3 / M4)'s instruction set: the dialect is mlirformat's `apple9` (not an upstream dialect) |
| `dialect.glsl` | no | GLSL (ES 1.00 / 3.00) shaders: the `glsl` dialect is mlirformat's (`glsl.shader`, its globals, loads / stores, constructors, built-in functions, derivatives, texture sampling, `discard`; the rest of a shader is `func` / `arith` / `math` / `vector` / `scf`, aggregates and samplers `!spirv.*` types), GLSL source is read by mlirbinary's `GlslFormat` (`GlslReader::read` puts a shader in a body); the passes lower it: `convert-glsl-to-spirv{client=opengl}` keeps what Mesa's GLSL compiler computes, checked pixel for pixel against the local OpenGL (`tests/gl.rs`) (not an upstream dialect); turns on `target.spirv`; passes: `convert-glsl-to-spirv` (with `dialect.math`, `dialect.scf`, `dialect.func`), `glsl-default-block` (with `dialect.math`, `dialect.scf`, `dialect.func`), `glsl-link` (with `dialect.math`, `dialect.scf`, `dialect.func`) |
| `dialect.image` | no | the images of the GPU instruction sets below: the dialect is mlirformat's `image`, written by mlirbinary's `ImageWriter`; the layout (`ImageLayout`) is here (not an upstream dialect) |
| `dialect.nir` | no | Mesa's NIR ALU opcodes (mlirformat's `nir` dialect, generated from Mesa 25.2.8's `nir_opcodes.py`) and the algebraic rules of Mesa's `nir_opt_algebraic` / `_before_ffma` / `_late` / `_distribute_src_mods`, written by `scripts/nir_algebraic.py` from `nir_opt_algebraic.py` as Mesa's own parser reads it (`NirRules`) (not an upstream dialect) |
| `dialect.rdna2` | no | AMD RDNA2's instruction set and PM4 command stream: the dialect is mlirformat's `rdna2`; building instruction ops and gathering registers into packets are here (not an upstream dialect); turns on `dialect.image` |
| `dialect.xe3` | no | Intel Xe3's EU instructions and genxml commands, state and registers: the dialect is mlirformat's `xe3` (not an upstream dialect); turns on `dialect.image` |
| `target.agx` | no | Apple AGX (G13) machine code without LLVM, CDM command streams; encoded by mlirbinary (checked there against Mesa); the CDM stream checked against Mesa asahi (`tests/agx.rs`); turns on `dialect.agx`, `target.gpu`; passes: `agx-end`, `agx-layout`, `agx-regalloc`, `agx-wait`, `convert-gpu-to-agx` |
| `target.apple9` | no | Apple9 (M3 / M4) compute kernels without LLVM, encoded by mlirbinary; checked by running on an M4 through Metal (`scripts/apple9_check.py`, `tests/apple9.rs`); turns on `dialect.apple9`, `target.gpu`; passes: `apple9-control`, `apple9-regalloc`, `apple9-wait`, `convert-gpu-to-apple9` |
| `target.emitc` | yes | dialect → `emitc`: the EmitC type converter; turns on `dialect.emitc`; passes: `convert-to-emitc` |
| `target.gpu` | no | what a GPU machine-code target needs, inside mlirpass or outside it: the `Target` / `GpuTarget` traits and `KernelCode`, kernels and stages, register allocation (`LinearScan`, `RegTarget`), `Draw`, the lane-by-lane lowering helpers of `ConversionRewriter`, the image dialect; turns on `dialect.image`, `dialect.spirv`, `dialect.gpu`, `dialect.arith`, `dialect.math`, `dialect.vector`, `dialect.func`, `dialect.scf`, `dialect.cf`; passes: `gpu-inline-calls` |
| `target.llvm` | yes | the type converter, dialect → `llvm` (the CPU dialect `x86` too: `convert-vector-to-llvm=enable-x86`), the llvm folds and memory-slot interfaces; turns on `dialect.llvm`; passes: `convert-to-llvm`, `llvm-request-c-wrappers`, `set-llvm-module-datalayout` |
| `target.rdna2` | no | AMD RDNA2 (gfx1036) machine code without LLVM: `gpu.func` kernels, register allocation, waits, PM4, the image's layout; encoded by mlirbinary (checked there against llvm-mc and Mesa); the IB checked against Mesa radv (`tests/rdna2.rs`); turns on `dialect.rdna2`, `target.gpu`; passes: `convert-gpu-to-rdna2`, `rdna2-layout`, `rdna2-pad`, `rdna2-pm4`, `rdna2-regalloc`, `rdna2-waitcnt` |
| `target.spirv` | yes | target env, type converter, dialect → `spirv`, the spirv dialect's own transforms; `SpirvBinary` (SPIR-V written and read through [mlirbinary](https://github.com/Jabberwocky238/mlirbinary), as `mlir-translate` does) and `SpirvGlsl` (mlirbinary's GLSL 4.50 writer) emit from a body; turns on `dialect.spirv`; passes: `convert-spirv-cf-to-cf` (or with `target.gpu` instead), `convert-spirv-entry-points` (or with `target.gpu` instead), `decorate-spirv-composite-type-layout`, `spirv-attach-target`, `spirv-canonicalize-gl`, `spirv-lower-abi-attrs`, `spirv-promote-to-replicated-constants`, `spirv-rewrite-inserts`, `spirv-unify-aliased-resource`, `spirv-update-vce`, `spirv-webgpu-prepare` |
| `target.x86_64` | no | x86-64 machine code without LLVM: each `llvm.func` (integers, `!llvm.ptr`, `f64`; arithmetic, compares, casts, memory, calls of symbols, branches) ⇒ System V code and the absolute addresses its calls need (`X86_64Emit`); first tier: a stack slot per value, no register allocation yet; run in-process (`tests/x86_64.rs`); turns on `dialect.llvm` |
| `target.xe3` | no | Intel Xe3 machine code without LLVM: `gpu.func` kernels and SPIR-V graphics shaders (vertex, fragment), register allocation, structured control flow, SWSB, the batch and the image's layout, a whole draw's image (`Xe3Draw`); encoded by mlirbinary (checked there against Mesa's gentool and genxml); kernels checked against acgpu's (`tests/xe3.rs`); turns on `dialect.xe3`, `target.gpu`; passes: `convert-gpu-to-xe3`, `xe3-branches`, `xe3-control`, `xe3-end`, `xe3-layout`, `xe3-pad`, `xe3-regalloc`, `xe3-swsb` |

Always compiled in, whatever the features: `canonicalize`, `cse`, `inline`, `loop-invariant-code-motion`, `mem2reg`, `reconcile-unrealized-casts`, `remove-dead-values`, `sccp`, `sroa`, `strip-debuginfo`, `symbol-dce`, `symbol-privatize`.
<!-- /features -->

GPU machine code (`target.rdna2` / `target.agx` / `target.apple9` / `target.xe3`): a GPU's own machine code, without LLVM (not in `all-targets`): `convert-gpu-to-<isa>` (upstream `gpu.func` kernels: arith / math / vector / scf, `gpu.block_id` / `thread_id` / `barrier`, flat 32-bit memory as `llvm.inttoptr` + `llvm.load` / `store` / `atomicrmw`), register allocation, waits; command streams (PM4, CDM, genxml batches), the image's layout; encoding by mlirbinary; `gpu-module-to-binary` encodes a module of kernels into a `#gpu.object`. AMD RDNA2 (gfx1036), Apple AGX (G13), Intel Xe3, Apple9 (M3 / M4, compute: workgroups of 32 (or 16, two a hardware workgroup), i32 and f32 arithmetic with correctly rounded division and square root, `scf.if` / `scf.for` / `scf.while` on the execution-mask stack, threadgroup memory (`!llvm.ptr<3>`) and `gpu.barrier`, `llvm.atomicrmw` / `llvm.cmpxchg` (memory and threadgroup memory), 3-D grids of workgroups (`gpu.grid_dim` from the parameter buffer); no Mesa model, checked by running on an M4 through Metal: `scripts/apple9_check.py`). The encoders (mlirbinary's) are checked there against llvm-mc, Mesa and the M4; here the lowering and the command streams (`tests/{rdna2,agx,apple9}.rs`). Intel Xe3 (Panther Lake) compute kernels and vertex / fragment shaders, and a whole draw's image (`Xe3Draw`), which [detour](https://github.com/0x00-Community/detour) runs. A GPU target outside mlirpass builds on `target.gpu` and registers its own passes with `Passes::with`.

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

`tests/fixtures/` holds `mlir-opt` 23.1.5's own output for llvm-project's `mlir/test/Conversion`,
`mlir/test/Transforms` and the dialects' `canonicalize*.mlir`, `mem2reg*.mlir` and `sroa*.mlir`, one `RUN:` line each, so the tests
need no LLVM. Regenerate with a vanilla 23.1.5 build:

```sh
python3 scripts/fixtures.py --llvm $LLVM --mlir-opt $LLVM_BUILD/bin/mlir-opt
```

## Fuzzing

`fuzz/` (a crate of its own) generates random valid IR and runs it through mlirpass and
`mlir-opt` 23.1.5 (`MLIR_OPT`) side by side, every non-exact case saved; it also times both on big modules
(`fuzz/README.md`).

## Performance

Measured with 0.8.1 against `mlir-opt` 22.1.8 on a 54 MB module (`BENCHMARK.md`), 16 CPUs, both threaded, jemalloc
(mlirformat's global allocator with `std` since 0.8.1): as whole processes every pipeline is
4.1–4.9× faster (canonicalize + cse 430 against 1,790 ms, the `-to-llvm` pipeline 1,160 against
5,690 ms; 2.8–3.0× with custom text in); parse + passes + print in process 8.3–10.7×, the
`-to-llvm` pipeline 4.5×. Peak memory is 2.7–3.6× `mlir-opt`'s (1.2× for sccp).

## License

MIT
