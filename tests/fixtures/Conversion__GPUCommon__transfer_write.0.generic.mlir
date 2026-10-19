"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64, ptr, ptr, i64, i64, i64, i64, i64, vector<1xf32>)>, linkage = #llvm.linkage<external>, sym_name = "warp_extract", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: i64, %arg8: vector<1xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (i64) -> index
    %1 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %2 = "llvm.insertvalue"(%1, %arg1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.insertvalue"(%2, %arg2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %4 = "llvm.insertvalue"(%3, %arg3) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %5 = "llvm.insertvalue"(%4, %arg4) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %6 = "llvm.insertvalue"(%5, %arg6) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %7 = "llvm.insertvalue"(%6, %arg5) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %8 = "llvm.insertvalue"(%7, %arg7) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    "gpu.warp_execute_on_lane_0"(%0) <{warp_size = 32 : i64}> ({
      %10 = "llvm.extractvalue"(%8) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
      %11 = "llvm.mlir.constant"() <{value = 1024 : index}> : () -> i64
      %12 = "llvm.mul"(%9, %11) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %13 = "llvm.add"(%12, %9) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %14 = "llvm.getelementptr"(%10, %13) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
      "llvm.store"(%arg8, %14) <{alignment = 4 : i64, ordering = 0 : i64}> : (vector<1xf32>, !llvm.ptr) -> ()
      "gpu.yield"() : () -> ()
    }) : (index) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

