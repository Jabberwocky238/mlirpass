"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.mlir.global"() <{addr_space = 2 : i32, constant, global_type = !llvm.array<11 x i8>, linkage = #llvm.linkage<internal>, sym_name = "printfFormat_0", value = "Hello: %d\0A\00", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<i32 (ptr<2>, ...)>, linkage = #llvm.linkage<external>, sym_name = "_Z6printfPU3AS2Kcz", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "test_printf", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: i32):
      %0 = "llvm.mlir.addressof"() <{global_name = @printfFormat_0}> : () -> !llvm.ptr<2>
      %1 = "llvm.getelementptr"(%0) <{elem_type = !llvm.array<11 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr<2>) -> !llvm.ptr<2>
      %2 = "llvm.call"(%1, %arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z6printfPU3AS2Kcz, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, var_callee_type = !llvm.func<i32 (ptr<2>, ...)>}> : (!llvm.ptr<2>, i32) -> i32
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

