"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<spir_kernelcc>, function_type = !llvm.func<void (ptr<2>, ptr<2>, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "constant_load", visibility_ = 0 : i64}> ({
    ^bb0(%arg12: !llvm.ptr<2>, %arg13: !llvm.ptr<2>, %arg14: i32, %arg15: i32, %arg16: i32):
      %0 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<2>, ptr<2>, i32, array<1 x i32>, array<1 x i32>)>
      %1 = "llvm.insertvalue"(%0, %arg12) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<2>, ptr<2>, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr<2>) -> !llvm.struct<(ptr<2>, ptr<2>, i32, array<1 x i32>, array<1 x i32>)>
      %2 = "llvm.insertvalue"(%1, %arg13) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<2>, ptr<2>, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr<2>) -> !llvm.struct<(ptr<2>, ptr<2>, i32, array<1 x i32>, array<1 x i32>)>
      %3 = "llvm.insertvalue"(%2, %arg14) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<2>, ptr<2>, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr<2>, ptr<2>, i32, array<1 x i32>, array<1 x i32>)>
      %4 = "llvm.insertvalue"(%3, %arg15) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<2>, ptr<2>, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr<2>, ptr<2>, i32, array<1 x i32>, array<1 x i32>)>
      %5 = "llvm.insertvalue"(%4, %arg16) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<2>, ptr<2>, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr<2>, ptr<2>, i32, array<1 x i32>, array<1 x i32>)>
      %6 = "builtin.unrealized_conversion_cast"(%5) : (!llvm.struct<(ptr<2>, ptr<2>, i32, array<1 x i32>, array<1 x i32>)>) -> memref<16xf32, #gpu.address_space<constant>>
      %7 = "arith.constant"() <{value = 0 : index}> : () -> index
      %8 = "memref.load"(%6, %7) : (memref<16xf32, #gpu.address_space<constant>>, index) -> f32
      "llvm.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<void (ptr<1>, ptr<1>, i32, ptr<3>, ptr<3>, i32, ptr, ptr, i32, ptr<2>, ptr<2>, i32)>, linkage = #llvm.linkage<external>, sym_name = "all_address_spaces", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr<1>, %arg1: !llvm.ptr<1>, %arg2: i32, %arg3: !llvm.ptr<3>, %arg4: !llvm.ptr<3>, %arg5: i32, %arg6: !llvm.ptr, %arg7: !llvm.ptr, %arg8: i32, %arg9: !llvm.ptr<2>, %arg10: !llvm.ptr<2>, %arg11: i32):
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

