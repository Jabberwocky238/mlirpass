# Benchmark: mlirpass 0.3.5 vs `mlir-opt` 22.1.8

One big random module through each pipeline, timed in both tools on the same input.

## Setup

| | |
| --- | --- |
| mlirpass | 0.3.5 (mlirformat 0.4.8), `cargo run --release` in `fuzz/` |
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
| `func.func(canonicalize)` | 882 | 1,318 | 353 | 67 | **1,302** | 2,129 | **1,761** | yes |
| `func.func(cse)` | 905 | 350 | 225 | 481 | **1,611** | 2,325 | **2,024** | yes |
| `func.func(canonicalize,cse)` | 915 | 1,375 | 370 | 70 | **1,356** | 2,195 | **1,781** | yes |
| `sccp` | 915 | 39,339 | 40,199 | 834 | **41,948** | 4,324 | **3,983** | yes |
| `func.func(loop-invariant-code-motion)` | 914 | 194 | 217 | 824 | **1,955** | 2,614 | **2,164** | yes |
| `func.func(mem2reg)` | 908 | 65 | 82 | 947 | **1,938** | 2,407 | **2,123** | yes |
| `convert-scf-to-cf` | 901 | 672 | 670 | 1,072 | **2,643** | 2,755 | **2,329** | yes |
| `remove-dead-values` | 906 | 11,109 | 11,159 | 159 | **12,224** | 7,903 | **7,766** | ✗ ¹ |
| `convert-scf-to-cf,convert-to-llvm,reconcile-unrealized-casts` | 823 | 6,448 | 6,434 | 2,494 | **9,750** | 6,349 | **5,615** | yes |

(The `builtin.module(…)` wrapper is left out of the names.)

¹ `mlir-opt` 22.1.8 segfaults on this module with `remove-dead-values`, so there is nothing to
compare with. On the small modules of `fuzz diff` (seeds 0..100) it also fails, with
`null operand found` or an assertion. This is an upstream bug (see `fuzz/README.md`, verdict `extra`).

## Reading it

- **Faster than `mlir-opt`**: canonicalize (1.35×), cse (1.26×), canonicalize + cse (1.31×),
  LICM (1.11×), mem2reg (1.10×), counting the whole run (parse + passes + print) against threaded
  `mlir-opt`. canonicalize gains the most from threads: 3.7× on 16 cores, against 1.2× for `mlir-opt`.
- **About the same**: convert-scf-to-cf takes 2.6 s against 2.3 s.
- **Slower**:
  - **sccp was 10.5× slower in 0.3.5** (39 s against 4 s). The time was spent in the pass itself,
    which runs on the whole module and so gets nothing from threads. **0.4.0 is on par**: the
    same run takes 3.8 s against `mlir-opt`'s 3.8 s (parse 929, run 2,080 / 2,093, print 780 ms),
    same output.
  - The `-to-llvm` pipeline is 1.7× slower.
  - remove-dead-values cannot be compared: `mlir-opt`'s 7.8 s is the time until it crashes.
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
