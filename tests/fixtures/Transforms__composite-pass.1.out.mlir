[thread mlir-opt] begins (no breakpoint) Action `pass-execution` running `TestCompositePass` on Operation `builtin.module` (module {...})`
[thread mlir-opt] begins (no breakpoint) Action `pass-execution` running `mlir::detail::OpToOpPassAdaptor` on Operation `builtin.module` (module {...})`
[thread mlir-opt] begins (no breakpoint) Action `pass-execution` running `Canonicalizer` on Operation `func.func` (func.func @test() {...})`
[thread mlir-opt] begins (no breakpoint) Action GreedyPatternRewriteIteration(1) (Region #0 for op func.func @test() {...})`
[thread mlir-opt] completed `GreedyPatternRewriteIteration`
[thread mlir-opt] completed `pass-execution`
[thread mlir-opt] begins (no breakpoint) Action `pass-execution` running `CSE` on Operation `func.func` (func.func @test() {...})`
[thread mlir-opt] completed `pass-execution`
[thread mlir-opt] completed `pass-execution`
[thread mlir-opt] completed `pass-execution`
module {
  func.func @test() {
    return
  }
}

// -----
[thread mlir-opt] begins (no breakpoint) Action `pass-execution` running `TestCompositePass` on Operation `builtin.module` (module {...})`
[thread mlir-opt] begins (no breakpoint) Action `pass-execution` running `mlir::detail::OpToOpPassAdaptor` on Operation `builtin.module` (module {...})`
[thread mlir-opt] begins (no breakpoint) Action `pass-execution` running `Canonicalizer` on Operation `func.func` (func.func @test() {...})`
[thread mlir-opt] begins (no breakpoint) Action GreedyPatternRewriteIteration(1) (Region #0 for op func.func @test() {...})`
[thread mlir-opt] completed `GreedyPatternRewriteIteration`
[thread mlir-opt] begins (no breakpoint) Action GreedyPatternRewriteIteration(2) (Region #0 for op func.func @test() {...})`
[thread mlir-opt] completed `GreedyPatternRewriteIteration`
[thread mlir-opt] completed `pass-execution`
[thread mlir-opt] begins (no breakpoint) Action `pass-execution` running `CSE` on Operation `func.func` (func.func @test() {...})`
[thread mlir-opt] completed `pass-execution`
[thread mlir-opt] completed `pass-execution`
[thread mlir-opt] begins (no breakpoint) Action `pass-execution` running `mlir::detail::OpToOpPassAdaptor` on Operation `builtin.module` (module {...})`
[thread mlir-opt] begins (no breakpoint) Action `pass-execution` running `Canonicalizer` on Operation `func.func` (func.func @test() {...})`
[thread mlir-opt] begins (no breakpoint) Action GreedyPatternRewriteIteration(1) (Region #0 for op func.func @test() {...})`
[thread mlir-opt] completed `GreedyPatternRewriteIteration`
[thread mlir-opt] completed `pass-execution`
[thread mlir-opt] begins (no breakpoint) Action `pass-execution` running `CSE` on Operation `func.func` (func.func @test() {...})`
[thread mlir-opt] completed `pass-execution`
[thread mlir-opt] completed `pass-execution`
[thread mlir-opt] completed `pass-execution`
module {
  func.func @test() {
    return
  }
}

