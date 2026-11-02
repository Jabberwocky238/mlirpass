# Benchmark: mlirpass 0.4.1 vs `mlir-opt` 22.1.8

One big random module through each pipeline, timed in both tools on the same input.

## Setup

| | |
| --- | --- |
| mlirpass | 0.4.1 (mlirformat 0.5.1), `cargo run --release` in `fuzz/` |
| `mlir-opt` | LLVM 22.1.8 from apt.llvm.org (`mlir-22-tools 1:22.1.8~++20260714014902+ca7933e47d3a`, = tag `llvmorg-22.1.8`): Release build, no assertions |
| machine | Intel Core Ultra 7 356H, 16 cores (1 thread each), 62 GB, Linux 7.0, rustc 1.98.1 |
| input | `mlirpass-fuzz gen --seed 5 --funcs 2000 --ops 40 --depth 2` printed back generic by `mlir-opt`: 694,693 lines, 53.6 MB (arith, math, scf.if / for, memref, func.call) |

```sh
cd fuzz
MLIR_OPT=/usr/lib/llvm-22/bin/mlir-opt cargo run --release -- bench --seed 5 --reps 3
```

mlirpass is timed in process, phase by phase. `mlir-opt` runs as a process (startup is about 20 ms),
printing to `/dev/null`: once with `--mlir-disable-threading` (1t) and once with threads (Nt).
Each time is the best of 3. The threaded mlirpass output is checked against the serial one, and
`same` says whether mlirpass's IR equals `mlir-opt`'s.

## Results (ms)

| pipeline | parse | run 1t | run Nt | print | **total Nt** | **mlir-opt 1t** | **mlir-opt Nt** | same |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | :---: |
| `func.func(canonicalize)` | 846 | 941 | 287 | 36 | **1,169** | 2,165 | **1,758** | yes |
| `func.func(cse)` | 856 | 183 | 202 | 185 | **1,243** | 2,382 | **1,952** | yes |
| `func.func(canonicalize,cse)` | 858 | 1,011 | 300 | 36 | **1,194** | 2,185 | **1,793** | yes |
| `sccp` | 866 | 1,771 | 1,764 | 348 | **2,979** | 4,144 | **3,845** | yes |
| `func.func(loop-invariant-code-motion)` | 865 | 95 | 110 | 362 | **1,337** | 2,673 | **2,197** | yes |
| `func.func(mem2reg)` | 941 | 57 | 73 | 388 | **1,401** | 2,468 | **2,111** | yes |
| `convert-scf-to-cf` | 876 | 336 | 332 | 400 | **1,607** | 2,722 | **2,318** | yes |
| `remove-dead-values` | 873 | 2,607 | 2,643 | 63 | **3,579** | 7,968 | **7,686** | ✗ ¹ |
| `convert-scf-to-cf,convert-to-llvm,reconcile-unrealized-casts` | 857 | 3,187 | 3,215 | 711 | **4,782** | 6,314 | **5,604** | yes |

(The `builtin.module(…)` wrapper is left out of the names.)

¹ `mlir-opt` 22.1.8 segfaults on this module with `remove-dead-values` (its time is the time until
it crashes), so there is nothing to compare with. On the small modules of `fuzz diff` (seeds 0..100) it also fails, with
`null operand found` or an assertion. This is an upstream bug (see `fuzz/README.md`, verdict `extra`).

## Reading it

- **Every comparable pipeline is faster than `mlir-opt`**, counting the whole run (parse + passes +
  print) against threaded `mlir-opt`: canonicalize 1.50×, cse 1.57×, canonicalize + cse 1.50×,
  sccp 1.29×, LICM 1.64×, mem2reg 1.51×, convert-scf-to-cf 1.44×, and the `-to-llvm` pipeline
  1.17×. canonicalize gains the most from threads: 3.3× on 16 cores, against 1.2× for `mlir-opt`.
- **What 0.4.1 changed** (the `-to-llvm` pipeline: 9.75 s in 0.3.5, 7.58 s in 0.4.0, 4.78 s now):
  - Printing reads the IR in place: the printer asks the body for each op as it gets to it
    (mlirformat's `Source`), so no copy of the module is built for it and none is dropped after.
  - An op's operands, results, successors and regions, a block's arguments and a value's uses
    are held inline up to a few (`Ids`), not in a heap `Vec` each.
  - Dialect conversion rolls a failure back from its undo log, not from a copy of the whole body
    taken up front. The log keeps one save per entry touched.
  - Its state is kept in bitsets and arrays indexed by id, not in B-trees.
- **History**: sccp was 10.5× slower in 0.3.5 (39 s against 4 s) and remove-dead-values took
  11.1 s; both are dataflow passes, and 0.4.0's solver brought them to 3.7 s and 4.0 s.
- **Parsing a generic module takes about 0.9 s.** That is the floor under every row and the largest
  part of the cheap ones. On a module of the same shape (seed 1, 54.3 MB), `mlir-opt --mlir-timing`
  reports 1.7 s for its parser, which includes its verifier. mlirformat's own parse / print
  numbers are in mlirformat's `BENCHMARK.md`.
- Some passes get no gain, or a small loss, from threads (cse, LICM, mem2reg, scf-to-cf): the
  per-function work is smaller than the cost of splitting the module and grafting it back.
- With an assertion-enabled `mlir-opt` 22.1.8 (`LLVM_ENABLE_ASSERTIONS=ON`), canonicalize aborts
  on seeds 1–4, 7 and 8 (on seed 1: `Unexpected predicate!` at `ArithOps.cpp:2172`), so `same`
  cannot be checked there. Seeds 5 and 6 pass. This is why the run uses seed 5 and the apt.llvm.org
  release build.
