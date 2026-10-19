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

## Fixtures

`tests/fixtures/` holds `mlir-opt` 22.1.8's own output for llvm-project's `mlir/test/Conversion`,
`mlir/test/Transforms` and the dialects' `canonicalize*.mlir`, one `RUN:` line each, so the tests
need no LLVM. Regenerate with a vanilla 22.1.8 build:

```sh
python3 scripts/fixtures.py --llvm $LLVM --mlir-opt $LLVM_BUILD/bin/mlir-opt
```

## License

MIT
