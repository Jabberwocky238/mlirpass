# Benchmark: mlirpass 0.8.1 (mlirformat 0.6.2) vs `mlir-opt` 22.1.8

## 0.8.1: jemalloc, every CPU

mlirformat 0.6.2's `std` makes jemalloc the global allocator, so mlirpass (and its command line)
runs on it. Measured 2026-11-06, the machine of the setup below, again **not idle** (load average
16–19): mlirpass 0.8.1 (`dfaabf3`), threads on in both tools, all 16 CPUs, no pinning. Same seed 5
module and command lines as the sections below.

In process (`fuzz/`: `bench --seed 5 --reps 3`); "total Nt" is parse + run Nt + print, against
the threaded `mlir-opt` process:

| pipeline | parse | run Nt | print | **total Nt** | **`mlir-opt` Nt** | speed-up | same |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | :---: |
| `func.func(canonicalize)` | 110 | 90 | 10 | **210** | 1,783 | **8.48×** | yes |
| `func.func(cse)` | 109 | 18 | 57 | **185** | 1,978 | **10.71×** | yes |
| `func.func(canonicalize,cse)` | 112 | 93 | 11 | **216** | 1,819 | **8.44×** | yes |
| `sccp` | 128 | 398 | 110 | **636** | 5,299 | **8.34×** | yes |
| `func.func(loop-invariant-code-motion)` | 112 | 11 | 101 | **224** | 2,196 | **9.82×** | yes |
| `func.func(mem2reg)` | 134 | 9 | 117 | **259** | 2,282 | **8.80×** | yes |
| `convert-scf-to-cf` | 115 | 50 | 113 | **278** | 2,882 | **10.37×** | yes |
| `remove-dead-values` | 212 | 654 | 32 | **897** | crashes ¹ | — | — |
| the `-to-llvm` pipeline | 189 | 780 | 356 | **1,325** | 5,986 | **4.52×** | yes |

Process against process (best of 3, `--allow-unregistered-dialect -o /dev/null`, plus
`--mlir-print-op-generic` when generic text goes in; peak RSS from `/usr/bin/time -f %M`):

| pipeline | mlirpass | `mlir-opt` | **speed-up** | RSS mlirpass / `mlir-opt` |
| --- | ---: | ---: | ---: | ---: |
| `func.func(canonicalize)` | 430 | 1,780 | **4.14×** | 1,045 / 343 MB |
| `func.func(cse)` | 400 | 1,970 | **4.93×** | 943 / 361 MB |
| `func.func(canonicalize,cse)` | 430 | 1,790 | **4.16×** | 1,049 / 345 MB |
| `sccp` | 790 | 3,760 | **4.76×** | 1,249 / 1,067 MB |
| `func.func(loop-invariant-code-motion)` | 470 | 2,110 | **4.49×** | 1,014 / 377 MB |
| `func.func(mem2reg)` | 460 | 2,090 | **4.54×** | 1,019 / 380 MB |
| `convert-scf-to-cf` | 540 | 2,320 | **4.30×** | 1,366 / 439 MB |
| the `-to-llvm` pipeline | 1,160 | 5,690 | **4.91×** | 2,720 / 819 MB |
| custom in, `canonicalize,cse` | 500 | 1,420 | **2.84×** | 1,031 / 282 MB |
| custom in, the `-to-llvm` pipeline | 1,800 | 5,460 | **3.03×** | 2,621 / 762 MB |

No pipeline, seed 1's module (mlirformat's `BENCHMARK.md`): custom ⇒ custom 1,300 against 2,100 ms
(1.62×), custom ⇒ generic 980 / 2,440 (2.49×), generic ⇒ custom 1,490 / 2,840 (1.91×), generic ⇒
generic 520 / 3,000 (5.77×).

- **Every pipeline is 4.1–4.9× faster than threaded `mlir-opt` as a whole process** with generic
  text in (2.8–3.0× with custom text in), and 8.3–10.7× in process (the `-to-llvm` pipeline
  4.5×). Parsing on 16 threads is 110–130 ms where glibc took ~390.
- **Not yet explained**: `sccp` (run Nt 398 ms) and the `-to-llvm` pipeline (780 ms) are slower
  than 0.7.1 under jemalloc (285 and 374 ms, table below). Either 0.8.0's linked-list blocks or
  this load; not re-measured on an idle machine.
- **Memory**: the peak is 2.7–3.6× `mlir-opt`'s (1.2× for sccp); the `-to-llvm` pipeline peaks at
  2,720 MB (0.7.1: 2,244 under glibc, 2,304 under jemalloc).

The sections below are 0.7.1's (glibc unless a row says jemalloc).


One big random module run through each pipeline, the same input in both tools: in process phase
by phase, as a process against a process (with peak memory), across core counts and module
sizes. Measured 2026-11-06.

## Setup

| | |
| --- | --- |
| mlirpass | 0.7.1 (`758dade`, the code of `d08668f`; on mlirformat 0.6.0 and moremath 0.2.1), release build. 0.8.0 (a block's ops as a linked list with order keys) is not re-measured here |
| `mlir-opt` | LLVM 22.1.8 from apt.llvm.org (`mlir-22-tools 1:22.1.8~++20260714014902+ca7933e47d3a`, = tag `llvmorg-22.1.8`): Release build, no assertions |
| machine | Intel Core Ultra 7 356H, 62 GB, Linux 7.0, glibc malloc, rustc 1.98.1. Hybrid CPU: CPUs 0–3 are P cores (4.7 GHz), 4–11 E cores (3.7 GHz), 12–15 LP E cores (3.3 GHz) |
| load | **not idle**: other jobs (compilers) kept the load average at 8–22 throughout. Every time below is higher than on an idle machine, `mlir-opt`'s as much as mlirpass's; compare the two within a table rather than with other versions' tables |
| input | `mlirpass-fuzz gen --seed 5 --funcs 2000 --ops 40 --depth 2`, printed back by `mlir-opt`: generic 694,693 lines / 53.6 MB, custom 31.5 MB (arith, math, scf.if / for, memref, func.call) |

Threads: one moremath `ThreadMulti` (lock-free pool, calls nest) reads, imports, runs the passes
and prints. A body is one arena per function (`Seg`), so a function moves to a thread and back
without a copy; module-level passes (`sccp`, `remove-dead-values`, `convert-scf-to-cf`,
`convert-to-llvm`) run function by function, exchanging what crosses functions, and give the
serial output byte for byte.

1. **In process, phase by phase** (`fuzz/`: `cargo run --release -- bench --seed 5 --reps 3`):
   reading, running the pipeline and printing timed separately; the run on one thread (1t) and on
   the pool (Nt, 16 threads). `mlir-opt` runs as a process printing to `/dev/null`, with and
   without `--mlir-disable-threading`. The threaded mlirpass output is checked against the
   serial one; `same` says whether it equals `mlir-opt`'s.
2. **Process against process** (best of 3, peak RSS from `/usr/bin/time -f %M`): the same flags
   for both, `--allow-unregistered-dialect -o /dev/null` (plus `--mlir-print-op-generic` when
   generic text goes in): one thread pinned to one P core, or threads on all 16 CPUs.
3. **Cores and sizes**: those command lines pinned to 1, 2, 4, 8, 16 CPUs (from 8 up that
   includes E cores); the `bench` of (1) on modules of 250 to 8,000 functions.

## Results

All times are in ms.

### Phase by phase, in process

| pipeline | parse | run 1t | run Nt | print | **total Nt** | `mlir-opt` 1t | **`mlir-opt` Nt** | speed-up | same |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | :---: |
| `func.func(canonicalize)` | 411 | 995 | 135 | 15 | **561** | 2,166 | **1,784** | **3.18×** | yes |
| `func.func(cse)` | 399 | 185 | 25 | 60 | **484** | 2,336 | **1,979** | **4.09×** | yes |
| `func.func(canonicalize,cse)` | 401 | 1,028 | 135 | 15 | **551** | 2,188 | **1,780** | **3.23×** | yes |
| `sccp` | 405 | 1,333 | 402 | 97 | **904** | 4,155 | **3,778** | **4.18×** | yes |
| `func.func(loop-invariant-code-motion)` | 404 | 87 | 17 | 121 | **542** | 2,543 | **2,082** | **3.84×** | yes |
| `func.func(mem2reg)` | 395 | 37 | 11 | 97 | **502** | 2,344 | **2,079** | **4.14×** | yes |
| `convert-scf-to-cf` | 388 | 517 | 93 | 107 | **587** | 2,628 | **2,261** | **3.85×** | yes |
| `remove-dead-values` | 391 | 1,618 | 508 | 21 | **920** | 12,743 | 16,382 | — ¹ | — |
| `convert-scf-to-cf,convert-to-llvm,reconcile-unrealized-casts` | 381 | 3,781 | 547 | 252 | **1,179** | 6,236 | **5,515** | **4.68×** | yes |

"total Nt" is parse + run Nt + print. The `builtin.module(…)` wrapper is left out of the names.

¹ `mlir-opt` 22.1.8 segfaults on this module with `remove-dead-values`; its time is the time
until it crashes. mlirpass leaves dangling call operands on it (printed `%INVALID`): a known bug of
its own (`fuzz/README.md`).

### This release's hot spots: before, after, and with jemalloc

The same `bench` (total Nt in brackets: parse + run Nt + print, ms), the build before this
round's work (0.7.0 minus its hot-spot fixes), this one, and this one under jemalloc
(`LD_PRELOAD`). Found by sampling threaded runs per thread: what ran on the main thread alone.

| pipeline | before: run Nt (total) | now: run Nt (total) | now, jemalloc: run Nt (total) |
| --- | ---: | ---: | ---: |
| `func.func(canonicalize)` | 125 (530) | 127 (539) | 89 (**216**) |
| `func.func(cse)` | 29 (473) | 25 (476) | 18 (**188**) |
| `sccp` | 414 (888) | 392 (889) | 285 (**483**) |
| `convert-scf-to-cf` | 175 (668) | **95** (593) | 48 (**272**) |
| `remove-dead-values` | 894 (1,314) | **518** (928) | 379 (**512**) |
| the `-to-llvm` pipeline | 840 (1,487) | **547** (1,191) | 374 (**715**) |

- Verifying after each pass ran module-wide on one thread (54–76 ms per module pass): now over
  the module's ops in parallel (`Body::verify_in`); `-verify-each=false` turns it off.
- Lent functions' checkpoints were released on the main thread (77–114 ms per conversion): now on
  the threads.
- `remove-dead-values`' cleanup (its walk, the apply, the final canonicalization) was serial
  (~510 ms): now function by function.
- What is left is glibc malloc: parsing (import, mostly) takes 386–397 ms on 16 threads with
  glibc and 112–120 ms with jemalloc. Since 0.8.1 jemalloc is the global allocator.

### Process against process

| pipeline | mlirpass 1t | `mlir-opt` 1t | speed-up | mlirpass Nt | `mlir-opt` Nt | **speed-up Nt** | mlirpass RSS 1t / Nt | `mlir-opt` RSS |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| `func.func(canonicalize)` | 2,420 | 2,420 | 1.00× | 1,050 | 2,180 | **2.08×** | 914 / 1,018 MB | 379 MB |
| `func.func(cse)` | 1,830 | 2,630 | 1.44× | 880 | 2,650 | **3.01×** | 924 / 902 MB | 396 MB |
| `func.func(canonicalize,cse)` | 2,400 | 2,360 | 0.98× | 1,000 | 2,180 | **2.18×** | 914 / 1,018 MB | 379 MB |
| `sccp` | 3,400 | 4,090 | 1.20× | 1,260 | 3,730 | **2.96×** | 1,096 / 1,211 MB | 1,102 MB |
| `func.func(loop-invariant-code-motion)` | 1,830 | 2,450 | 1.34× | 750 | 2,040 | **2.72×** | 964 / 933 MB | 419 MB |
| `func.func(mem2reg)` | 1,760 | 2,260 | 1.28× | 750 | 2,029 | **2.71×** | 965 / 936 MB | 420 MB |
| `convert-scf-to-cf` | 2,290 | 2,610 | 1.14× | 930 | 2,200 | **2.37×** | 1,020 / 1,114 MB | 475 MB |
| `remove-dead-values` | 2,890 | crashes ¹ | — | 1,250 | crashes ¹ | — | 1,105 / 1,124 MB | — |
| the `-to-llvm` pipeline | 6,490 | 6,250 | 0.96× | 2,050 | 5,490 | **2.68×** | 1,741 / 2,244 MB | 855 MB |
| custom in, `canonicalize,cse` | 3,220 | 1,580 | 0.49× | 990 | 1,340 | **1.35×** | 1,000 / 1,102 MB | 298 MB |
| custom in, `canonicalize,cse`, jemalloc | 2,320 | 1,580 | 0.68× | 470 | 1,340 | **2.85×** | 892 / 1,015 MB | 298 MB |
| generic in, `canonicalize,cse`, jemalloc | 1,850 | 2,360 | 1.28× | 400 | 2,180 | **5.45×** | 898 / 1,021 MB | 379 MB |
| custom in, the `-to-llvm` pipeline | 7,300 | 6,060 | 0.83× | 2,880 | 5,280 | **1.83×** | 1,740 / 2,104 MB | 781 MB |
| custom in, the `-to-llvm` pipeline, jemalloc | 5,660 | 6,060 | 1.07× | 1,690 | 5,280 | **3.12×** | 1,884 / 2,141 MB | 781 MB |
| generic in, the `-to-llvm` pipeline, jemalloc | 5,270 | 6,250 | 1.19× | 1,150 | 5,490 | **4.77×** | 1,926 / 2,304 MB | 855 MB |

No pipeline, text in ⇒ text out (seed 1's module, as in mlirformat's `BENCHMARK.md`):

| job | mlirpass 1t | `mlir-opt` 1t | speed-up | mlirpass Nt | `mlir-opt` Nt | **speed-up Nt** | mlirpass RSS 1t / Nt | `mlir-opt` RSS |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| custom in ⇒ custom out (31.9 MB) | 4,550 | 2,090 | 0.46× | 2,210 | 1,940 | 0.88× | 1,033 / 984 MB | 353 MB |
| custom in ⇒ custom out, jemalloc | 2,590 | 2,090 | 0.81× | 1,270 | 1,940 | **1.53×** | 916 / 875 MB | 353 MB |
| custom in ⇒ generic out | 2,800 | 1,800 | 0.64× | 920 | 1,750 | **1.90×** | 1,065 / 1,037 MB | 337 MB |
| generic in ⇒ custom out (54.3 MB) | 3,980 | 2,610 | 0.66× | 2,050 | 2,350 | **1.15×** | 946 / 899 MB | 431 MB |
| generic in ⇒ generic out | 1,750 | 2,240 | 1.28× | 770 | 2,130 | **2.77×** | 978 / 950 MB | 421 MB |
| empty file (start-up) | 20 | 10 | — | | | | 15 MB | 95 MB |

### Cores

Wall time of the whole process, threads on, pinned to the first N CPUs (generic in and out):

| pipeline | tool | 1 | 2 | 4 | 8 | 16 |
| --- | --- | ---: | ---: | ---: | ---: | ---: |
| `func.func(canonicalize)` | mlirpass | 2,150 | 2,300 | 1,630 | 1,130 | **860** |
| | `mlir-opt` | 1,880 | 2,070 | 1,870 | 1,770 | 1,880 |
| `func.func(canonicalize,cse)` | mlirpass | 2,260 | 2,630 | 1,290 | 940 | **840** |
| | `mlir-opt` | 2,009 | 2,200 | 1,690 | 1,830 | 1,870 |
| `sccp` | mlirpass | 3,150 | 3,600 | 1,850 | 1,690 | **1,260** |
| | `mlir-opt` | 4,260 | 4,510 | 3,890 | 4,100 | 3,850 |
| `remove-dead-values` | mlirpass | 3,130 | 3,450 | 1,830 | 1,490 | **1,270** |
| | `mlir-opt` | 8,880 ¹ | 8,370 ¹ | 7,770 ¹ | 8,090 ¹ | 8,340 ¹ |
| the `-to-llvm` pipeline | mlirpass | 6,860 | 7,470 | 3,620 | 2,840 | **2,110** |
| | `mlir-opt` | 6,630 | 6,100 | 5,970 | 6,230 | 5,750 |

Two CPUs are slower than one here: CPU 1 was busy with the other jobs.

### Module size

The in-process `bench` of the first table, total Nt against `mlir-opt` Nt:

| functions | size | canonicalize,cse: mlirpass | `mlir-opt` | speed-up | `-to-llvm`: mlirpass | `mlir-opt` | speed-up |
| ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| 250 | 5.7 MB | 55 | 258 | 4.72× | 156 | 760 | 4.86× |
| 1,000 | 25.9 MB | 300 | 961 | 3.20× | 727 | 3,727 | 5.13× |
| 2,000 | 53.6 MB | 726 | 2,131 | 2.94× | 1,324 | 5,687 | 4.30× |
| 4,000 | 110.0 MB | 1,600 | crashes ² | — | 3,090 | 17,726 | 5.74× |
| 8,000 | 225.2 MB | 4,721 | crashes ² | — | 7,290 | 32,453 | 4.45× |

² `mlir-opt` crashes running `func.func(canonicalize,cse)` on the 4,000- and 8,000-function
modules (as in 0.5.0). The 4,000 and 8,000 rows are best of 1.

## Reading it

- **Every pipeline is 3–4.7× faster than threaded `mlir-opt`** counting parse + run + print in
  process, and 2.1–3.0× as whole processes. The module-level passes now split too: on 16 CPUs
  sccp takes 1,260 ms (`mlir-opt` 3,850), `remove-dead-values` 1,270 and the `-to-llvm` pipeline
  2,110 (`mlir-opt` 5,750); in 0.5.0 they did not gain from more CPUs at all.
- **On one thread mlirpass is on par**: 0.96–1.44× as processes. Ids are 8 bytes (seg and index)
  since 0.6.0, which costs the serial run some of 0.5.0's lead.
- **glibc malloc is now the largest cost left**: under jemalloc canonicalize,cse runs in 400 ms
  as a process on 16 CPUs (5.45× `mlir-opt`), the `-to-llvm` pipeline in 1,150 (4.77×). Parsing
  on 16 threads goes from ~390 to ~115 ms. Since 0.8.1 (mlirformat 0.6.2) jemalloc is the
  global allocator (first section).
- **The custom form is still slower than the generic one** to read and print, and slower than
  `mlir-opt` on one thread; on 16 threads custom in ⇒ custom out is 0.88× (1.53× with jemalloc).
- **Memory**: the peak is 2.1–2.9× `mlir-opt`'s (1.0× for sccp), and threads add little now
  (canonicalize 914 ⇒ 1,018 MB): functions are lent, not copied.

## History (seed 5 module, in process, total Nt, 16 threads)

| pipeline | 0.5.0 | 0.7.1 | |
| --- | ---: | ---: | ---: |
| `func.func(canonicalize)` | 1,003 | 561 | 1.8× |
| `func.func(cse)` | 1,297 | 484 | 2.7× |
| `func.func(canonicalize,cse)` | 1,005 | 551 | 1.8× |
| `sccp` | 3,317 | 904 | 3.7× |
| `func.func(loop-invariant-code-motion)` | 1,467 | 542 | 2.7× |
| `func.func(mem2reg)` | 1,410 | 502 | 2.8× |
| `convert-scf-to-cf` | 1,860 | 587 | 3.2× |
| `remove-dead-values` | 3,446 | 920 | 3.7× |
| the `-to-llvm` pipeline | 5,262 | 1,179 | 4.5× |

0.5.0 was measured on an idle machine, 0.7.1 on a busy one. What changed: one arena per function
(0.6.0), parsing, import and printing in parallel, the module-level passes function by function,
the data-flow solver off a worklist, verification and the cleanup of `remove-dead-values` in
parallel (0.7.x).

### Before 0.6.0 (one-thread process)

| pipeline | 0.5.0 on mlirformat 0.5.3 | 0.5.0 on mlirformat 0.5.5 |
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
# jemalloc
LD_PRELOAD=/lib/x86_64-linux-gnu/libjemalloc.so.2 target/release/mlirpass fuzz/s5_generic.mlir --mlir-print-op-generic \
  --pass-pipeline='builtin.module(func.func(canonicalize,cse))' -o /dev/null
```
