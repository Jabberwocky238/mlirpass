module {
  gpu.module @test_module {
    llvm.mlir.global internal constant @printfFormat_0("Hello: %d\0A\00") {addr_space = 2 : i32}
    llvm.func spir_funccc @_Z6printfPU3AS2Kcz(!llvm.ptr<2>, ...) -> i32
    llvm.func spir_funccc @test_printf(%arg0: i32) {
      %0 = llvm.mlir.addressof @printfFormat_0 : !llvm.ptr<2>
      %1 = llvm.getelementptr %0[0, 0] : (!llvm.ptr<2>) -> !llvm.ptr<2>, !llvm.array<11 x i8>
      %2 = llvm.call spir_funccc @_Z6printfPU3AS2Kcz(%1, %arg0) vararg(!llvm.func<i32 (ptr<2>, ...)>) : (!llvm.ptr<2>, i32) -> i32
      llvm.return
    }
  }
}

