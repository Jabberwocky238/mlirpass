# Benchmark: mlirpass 0.5.0 (mlirformat 0.5.5) vs `mlir-opt` 22.1.8

One big random module run through each pipeline, the same input in both tools. Measured three
ways: in process phase by phase, as a process against a process (with peak memory), and across
core counts and module sizes. Measured 2026-11-05.

## Setup

| | |
| --- | --- |
| mlirpass | `main` at `27f1c26` (0.5.0, on mlirformat 0.5.5), release build |
| `mlir-opt` | LLVM 22.1.8 from apt.llvm.org (`mlir-22-tools 1:22.1.8~++20260714014902+ca7933e47d3a`, = tag `llvmorg-22.1.8`): Release build, no assertions |
| machine | Intel Core Ultra 7 356H, 62 GB, Linux 7.0, glibc malloc, rustc 1.98.1. Hybrid CPU: CPUs 0–3 are P cores (4.7 GHz), 4–11 E cores (3.7 GHz), 12–15 LP E cores (3.3 GHz) |
| input | `mlirpass-fuzz gen --seed 5 --funcs 2000 --ops 40 --depth 2`, printed back by `mlir-opt`: generic 694,693 lines / 53.6 MB, custom 676,150 lines / 31.5 MB (arith, math, scf.if / for, memref, func.call) |

The three ways of measuring:

1. **In process, phase by phase** (`fuzz/`: `cargo run --release -- bench --seed 5 --reps 3`).
   Reading, running the pipeline and printing are timed separately. The run is timed on one
   thread (1t) and on the thread pool (Nt, 16 threads). `mlir-opt` runs as a process printing to
   `/dev/null`, with `--mlir-disable-threading` (1t) and without it (Nt). The threaded mlirpass
   output is checked against the serial one, and `same` says whether mlirpass's IR equals
   `mlir-opt`'s. Best of 3.
2. **Process against process** (best of 3, peak RSS from `/usr/bin/time -f %M`). Both command
   lines get the same flags: `--allow-unregistered-dialect --mlir-disable-threading -o /dev/null`,
   plus `--mlir-print-op-generic` when generic text goes in. Each process is pinned to one P core;
   up to four run at once, each on its own P core.
3. **Cores and sizes**: the same command lines with threads on, pinned to 1, 2, 4, 8 and 16 CPUs
   (`taskset -c 0`, `0-1`, `0-3`, `0-7`, `0-15`; from 8 up that includes E cores). Separately,
   the `bench` of (1) on modules of 250 to 8,000 functions.

## Results

All times are in ms.

### Phase by phase, in process

| pipeline | parse | run 1t | run Nt | print | **total Nt** | `mlir-opt` 1t | **`mlir-opt` Nt** | speed-up | same |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | :---: |
| `func.func(canonicalize)` | 677 | 880 | 265 | 61 | **1,003** | 2,098 | **1,713** | **1.71×** | yes |
| `func.func(cse)` | 712 | 163 | 175 | 410 | **1,297** | 2,286 | **1,894** | **1.46×** | yes |
| `func.func(canonicalize,cse)` | 676 | 933 | 268 | 61 | **1,005** | 2,129 | **1,747** | **1.74×** | yes |
| `sccp` | 707 | 1,873 | 1,874 | 736 | **3,317** | 3,974 | **3,681** | **1.11×** | yes |
| `func.func(loop-invariant-code-motion)` | 688 | 66 | 79 | 700 | **1,467** | 2,500 | **2,044** | **1.39×** | yes |
| `func.func(mem2reg)` | 684 | 28 | 41 | 685 | **1,410** | 2,326 | **2,047** | **1.45×** | yes |
| `convert-scf-to-cf` | 689 | 433 | 434 | 736 | **1,860** | 2,652 | **2,218** | **1.19×** | yes |
| `remove-dead-values` | 683 | 2,647 | 2,639 | 123 | **3,446** | 7,855 | 7,723 | — ¹ | — |
| `convert-scf-to-cf,convert-to-llvm,reconcile-unrealized-casts` | 670 | 3,379 | 3,325 | 1,268 | **5,262** | 6,285 | **5,490** | **1.04×** | yes |

"total Nt" is parse + run Nt + print. The `builtin.module(…)` wrapper is left out of the names.

¹ `mlir-opt` 22.1.8 segfaults on this module with `remove-dead-values`; its time is the time
until it crashes. This is an upstream bug (`fuzz/README.md`, verdict `extra`).

### Process against process, one thread

| pipeline | mlirpass | `mlir-opt` | **speed-up** | mlirpass peak RSS | `mlir-opt` peak RSS | **memory** |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| `func.func(canonicalize)` | 1,991 | 2,142 | **1.08×** | 851 MB | 381 MB | 2.24× |
| `func.func(cse)` | 1,690 | 2,438 | **1.44×** | 883 MB | 398 MB | 2.22× |
| `func.func(canonicalize,cse)` | 1,989 | 2,135 | **1.07×** | 851 MB | 380 MB | 2.24× |
| `sccp` | 3,968 | 4,344 | **1.09×** | 1,008 MB | 1,104 MB | **0.91×** |
| `func.func(loop-invariant-code-motion)` | 1,749 | 2,492 | **1.42×** | 950 MB | 421 MB | 2.26× |
| `func.func(mem2reg)` | 1,826 | 2,488 | **1.36×** | 951 MB | 422 MB | 2.25× |
| `convert-scf-to-cf` | 2,274 | 2,639 | **1.16×** | 1,008 MB | 477 MB | 2.11× |
| `remove-dead-values` | 4,112 | crashes ¹ | — | 1,027 MB | — | — |
| `convert-scf-to-cf,convert-to-llvm,reconcile-unrealized-casts` | 6,200 | 6,361 | **1.03×** | 1,518 MB | 856 MB | 1.77× |
| custom in, `func.func(canonicalize,cse)` | 3,548 | 1,761 | **0.50×** | 932 MB | 300 MB | 3.11× |
| custom in, the `-to-llvm` pipeline | 6,921 | 6,169 | **0.89×** | 1,544 MB | 783 MB | 1.97× |
| custom in, `func.func(canonicalize,cse)`, jemalloc | 2,243 | 1,761 | **0.79×** | 982 MB | 300 MB | 3.27× |
| generic in, `func.func(canonicalize,cse)`, jemalloc | 1,772 | 2,135 | **1.21×** | 998 MB | 380 MB | 2.63× |

No pipeline, text in ⇒ text out (seed 1's module, as in mlirformat's `BENCHMARK.md`):

| job | mlirpass | `mlir-opt` | **speed-up** | mlirpass peak RSS | `mlir-opt` peak RSS |
| --- | ---: | ---: | ---: | ---: | ---: |
| custom in ⇒ custom out (31.9 MB) | 5,014 | 2,314 | **0.46×** | 989 MB | 355 MB |
| custom in ⇒ custom out, jemalloc | 2,485 | 2,314 | **0.93×** | 911 MB | 355 MB |
| custom in ⇒ generic out | 2,730 | 1,934 | **0.71×** | 1,045 MB | 341 MB |
| generic in ⇒ custom out (54.3 MB) | 4,092 | 2,856 | **0.70×** | 907 MB | 433 MB |
| generic in ⇒ custom out, jemalloc | 2,057 | 2,856 | **1.39×** | 928 MB | 433 MB |
| generic in ⇒ generic out | 1,677 | 2,459 | **1.47×** | 962 MB | 423 MB |
| fixtures, generic ⇒ custom (12,252 chunks) | 968 | 76,087 | **78.6×** | 66 MB | 166 MB |
| fixtures, custom ⇒ custom (the 6,087 chunks both read) | 479 | 10,738 | **22.4×** | 31 MB | 132 MB |
| empty file (start-up) | 17.6 | 17.0 | 0.97× | 13.6 MB | 96.2 MB |

### Cores

Wall time of the whole process, threads on, pinned to the first N CPUs:

| pipeline | tool | 1 | 2 | 4 | 8 | 16 |
| --- | --- | ---: | ---: | ---: | ---: | ---: |
| `func.func(canonicalize)` | mlirpass | 1,933 | 1,838 | 1,583 | 1,460 | **1,405** |
| | `mlir-opt` | 1,808 | 1,675 | 1,618 | 1,611 | 1,722 |
| `func.func(canonicalize,cse)` | mlirpass | 1,937 | 1,840 | 1,583 | 1,458 | **1,404** |
| | `mlir-opt` | 1,811 | 1,673 | 1,578 | 1,628 | 1,686 |
| `sccp` | mlirpass | 3,562 | 3,561 | 3,505 | 3,554 | 3,584 |
| | `mlir-opt` | 3,756 | 3,674 | 3,652 | 3,668 | 3,651 |
| the `-to-llvm` pipeline | mlirpass | 6,060 | 6,018 | 5,989 | 6,036 | 6,036 |
| | `mlir-opt` | 6,024 | 5,731 | 5,571 | 5,491 | **5,459** |

mlirpass's peak RSS for canonicalize goes from 851 MB on one CPU to 1,432 MB on two or more, when
functions are split off to run on the pool. `mlir-opt` stays at 345 MB.

### Module size

The in-process `bench` of the first table, total Nt against `mlir-opt` Nt:

| functions | size | canonicalize,cse: mlirpass | `mlir-opt` | speed-up | `-to-llvm`: mlirpass | `mlir-opt` | speed-up |
| ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| 250 | 5.7 MB | 123 | 186 | 1.52× | 507 | 480 | 0.95× |
| 1,000 | 25.9 MB | 483 | 802 | 1.66× | 2,481 | 2,483 | 1.00× |
| 2,000 | 53.6 MB | 1,005 | 1,747 | 1.74× | 5,262 | 5,490 | 1.04× |
| 4,000 | 110.0 MB | 2,069 | crashes ² | — | 12,249 | 12,165 | 0.99× |
| 8,000 | 225.2 MB | 4,204 | crashes ² | — | 30,792 | 29,222 | 0.95× |

² `mlir-opt` segfaults (exit 139) running `func.func(canonicalize,cse)` on the 4,000- and
8,000-function modules. Its times until the crash were 4,617 and 8,106 ms.

### Coverage of the custom form

mlirpass reads 6,087 of the 12,250 custom-form fixture chunks (50 %). The other 6,163 hold an op
whose custom form mlirpass has not registered. Most belong to `tosa`, `llvm`, `vector`,
`transform`, `spirv`, `scf`, `gpu`, `test` and `sparse_tensor`. mlirformat itself reads them all;
the gap is in mlirpass's import. The generic form of every chunk is read.

## Reading it

- **With the passes, with threads, every comparable pipeline beats `mlir-opt`.** Counting
  parse + run + print in process against threaded `mlir-opt`: canonicalize 1.71×, cse 1.46×,
  canonicalize + cse 1.74×, LICM 1.39×, mem2reg 1.45×, scf-to-cf 1.19×, sccp 1.11×, `-to-llvm`
  1.04×. canonicalize gets 3.3–3.5× from the thread pool, `mlir-opt` 1.2×.
- **As one-thread processes, the passes win too, but by less**: 1.03–1.44×. Start-up, reading
  the file and dropping the IR are counted there, and a fresh process pays page faults on every
  page it touches.
- **Printing the custom form is the slow part**: custom in ⇒ custom out with no pipeline is
  0.46× `mlir-opt` with glibc and 0.93× with jemalloc, and the custom-in pipelines are slower than
  `mlir-opt`. Generic in ⇒ generic out is 1.47× faster.
- **glibc malloc costs up to 2×** on the custom form. mlirformat 0.5.5 allocates each list at its
  exact length, which fragments glibc's heap (mlirformat's `BENCHMARK.md`). The same binary
  under jemalloc runs custom ⇒ custom in 2,485 ms instead of 5,014, and generic ⇒ custom in
  2,057 instead of 4,092.
- **Memory**: mlirpass's peak is 1.8–2.3× `mlir-opt`'s on the passes (3.1× with custom input),
  except sccp, where it is 0.91×. Since 0.5.0, import takes the parsed module apart instead of
  copying it, and sizes the body's arenas up front. Together with mlirformat 0.5.5, that took a
  run's peak from 1.6–2.3 GB to 0.85–1.5 GB (History). Threads add about 0.6 GB.
- **More cores help canonicalize only**: 1,933 ⇒ 1,405 ms from 1 to 16 CPUs. sccp,
  `remove-dead-values` and the `-to-llvm` pipeline run module-wide, so they do not split by
  function. `mlir-opt` gains a little on `-to-llvm` (6,024 ⇒ 5,459 ms) and nothing on canonicalize.
- **Size**: canonicalize + cse stays 1.5–1.7× faster from 250 to 2,000 functions. The `-to-llvm`
  pipeline is within 5 % of `mlir-opt` at every size.

## History (seed 5 module, one-thread process)

| pipeline | before (0.5.0 on mlirformat 0.5.3) | now (on mlirformat 0.5.5) |
| --- | ---: | ---: |
| `func.func(canonicalize,cse)` | 2,512 ms, 1,604 MB | 1,989 ms, **851 MB** |
| `sccp` | 3,906 ms, 1,745 MB | 3,968 ms, **1,008 MB** |
| the `-to-llvm` pipeline | 6,563 ms, 2,314 MB | 6,200 ms, **1,518 MB** |
| custom in ⇒ custom out (seed 1) | 3,816 ms, 1,795 MB | 5,014 ms, **989 MB** |
| generic in ⇒ custom out (seed 1) | 3,426 ms, 1,672 MB | 4,092 ms, **907 MB** |

## Reproducing

```sh
cd fuzz
MLIR_OPT=/usr/lib/llvm-22/bin/mlir-opt cargo run --release -- bench --seed 5 --reps 3
cargo run --release -- gen --seed 5 --funcs 2000 --ops 40 --depth 2 > raw.mlir
mlir-opt --mlir-print-op-generic raw.mlir -o s5_generic.mlir
cd .. && taskset -c 0 /usr/bin/time -f %M target/release/mlirpass fuzz/s5_generic.mlir --mlir-print-op-generic \
  --pass-pipeline='builtin.module(func.func(canonicalize,cse))' --mlir-disable-threading -o /dev/null
```
