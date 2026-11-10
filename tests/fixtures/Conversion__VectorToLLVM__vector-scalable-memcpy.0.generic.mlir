"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, index) -> (), sym_name = "vector_scalable_memcopy"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 4 : index}> : () -> index
    %4 = "llvm.intr.vscale"() : () -> i64
    %5 = "builtin.unrealized_conversion_cast"(%4) : (i64) -> index
    %6 = "arith.muli"(%5, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "scf.for"(%2, %arg2, %6) ({
    ^bb0(%arg3: index):
      %7 = "builtin.unrealized_conversion_cast"(%arg3) : (index) -> i64
      %8 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
      %9 = "llvm.getelementptr"(%8, %7) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
      %10 = "llvm.load"(%9) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> vector<[4]xf32>
      %11 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
      %12 = "llvm.getelementptr"(%11, %7) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
      "llvm.store"(%10, %12) <{alignment = 4 : i64, ordering = 0 : i64}> : (vector<[4]xf32>, !llvm.ptr) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

