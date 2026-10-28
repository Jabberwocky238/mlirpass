# mlirpass-fuzz

Random valid MLIR, run through mlirpass and `mlir-opt` 22.1.8 side by side (对拍), and timed.
A crate of its own (outside the workspace, never published): `cargo run --release -- <command>`.

`mlir-opt` is `$MLIR_OPT`, else the one on `PATH`; it must be 22.1.8, as for the fixtures.

```sh
export MLIR_OPT=$LLVM_BUILD/bin/mlir-opt
cargo run --release -- gen --seed 7                      # one module
cargo run --release -- diff --seeds 0..1000              # every default pipeline, both tools
cargo run --release -- diff --seeds 0..100 -p 'builtin.module(func.func(sccp))' --funcs 40
cargo run --release -- bench --funcs 2000 -p 'builtin.module(func.func(canonicalize,cse))'
```

## Generator (`src/irgen.rs`)

Valid by construction: every operand is a value of its type already in scope (else a fresh
constant), so dominance and types hold without being checked. A module is `--funcs` functions,
each calling only those before it; a block has up to `--ops` ops, scf regions nest up to
`--depth`. The ops: arith constants (edge values often: `0`, `-1`, `INT_MIN`, `inf`, `nan`,
denormals), integer and float binaries, `cmpi` / `cmpf` with every predicate, `select`, the
casts (`ext*`, `trunc*`, `index_cast*`, `*tofp`, `fpto*`, `bitcast`), `math` unaries,
`scf.if` / `scf.for` with results and `iter_args`, `memref.alloca` / `load` / `store`,
`func.call`. The same seed is the same module on any machine.

## `diff`

Each seed's module goes to `mlir-opt` once with no pass, and what it prints back (generic,
literals spelled its way) is what both tools then read, as for the fixtures; `--raw yes` feeds
the text as generated instead, which also tests reading. Each pipeline then runs on both, and
both outputs are read back into a `Body` and printed generic, so only the IR is compared.
mlirpass runs serial and threaded, and the two must agree.

| verdict | meaning |
|---|---|
| exact | the same IR |
| mismatch | different IR (or threaded differs from serial) |
| error | mlirpass failed where mlir-opt did not |
| panic | mlirpass panicked (caught, with its message) |
| invalid | mlir-opt refused the input: a generator bug |
| extra | mlir-opt failed where mlirpass did not (an upstream bug, or mlirpass too lax) |

Every non-exact case is written to `out/<verdict>/<seed>-<pipeline>.mlir`, the module with the
command and the first differing line in a comment on top.

## `bench`

One big module (`--funcs 2000` by default) through each pipeline. mlirpass is timed in
process, phase by phase (parse, run on one thread, run on the pool, print); `mlir-opt` as a
process, with and without `--mlir-disable-threading`. Best of `--reps`; the threaded output is
checked against the serial one, and `same` says whether mlirpass's IR is mlir-opt's.
