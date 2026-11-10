"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "dealloc_with_user_free", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64):
    %0 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "llvm.insertvalue"(%0, %arg0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = "llvm.insertvalue"(%1, %arg1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %3 = "llvm.insertvalue"(%2, %arg2) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %4 = "llvm.insertvalue"(%3, %arg3) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %5 = "llvm.insertvalue"(%4, %arg4) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %6 = "builtin.unrealized_conversion_cast"(%5) : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> memref<?xf32>
    %7 = "llvm.extractvalue"(%5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    "llvm.call"(%7) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "free", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
}) : () -> ()

