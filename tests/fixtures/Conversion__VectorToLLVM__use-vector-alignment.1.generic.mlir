"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> vector<8xf32>, sym_name = "load"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %8 = "llvm.load"(%7) <{alignment = 32 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> vector<8xf32>
    "func.return"(%8) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> vector<8xf32>, sym_name = "load_with_alignment_attribute"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %8 = "llvm.load"(%7) <{alignment = 8 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> vector<8xf32>
    "func.return"(%8) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> (), sym_name = "store"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "arith.constant"() <{value = dense<1.100000e+01> : vector<4xf32>}> : () -> vector<4xf32>
    %4 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %5 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %6 = "llvm.mul"(%1, %5) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.add"(%6, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %8 = "llvm.getelementptr"(%4, %7) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.store"(%3, %8) <{alignment = 16 : i64, ordering = 0 : i64}> : (vector<4xf32>, !llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> (), sym_name = "store_with_alignment_attribute"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "arith.constant"() <{value = dense<1.100000e+01> : vector<4xf32>}> : () -> vector<4xf32>
    %4 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %5 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %6 = "llvm.mul"(%1, %5) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.add"(%6, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %8 = "llvm.getelementptr"(%4, %7) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.store"(%3, %8) <{alignment = 8 : i64, ordering = 0 : i64}> : (vector<4xf32>, !llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<16xi1>, vector<16xf32>) -> vector<16xf32>, sym_name = "masked_load"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i64
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %4 = "llvm.getelementptr"(%3, %2) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %5 = "llvm.intr.masked.load"(%4, %arg1, %arg2) <{alignment = 64 : i32}> : (!llvm.ptr, vector<16xi1>, vector<16xf32>) -> vector<16xf32>
    "func.return"(%5) : (vector<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<16xi1>, vector<16xf32>) -> vector<16xf32>, sym_name = "masked_load_with_alignment_attribute"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i64
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %4 = "llvm.getelementptr"(%3, %2) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %5 = "llvm.intr.masked.load"(%4, %arg1, %arg2) <{alignment = 8 : i32}> : (!llvm.ptr, vector<16xi1>, vector<16xf32>) -> vector<16xf32>
    "func.return"(%5) : (vector<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<16xi1>, vector<16xf32>) -> (), sym_name = "masked_store"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i64
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %4 = "llvm.getelementptr"(%3, %2) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.masked.store"(%arg2, %4, %arg1) <{alignment = 64 : i32}> : (vector<16xf32>, !llvm.ptr, vector<16xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<16xi1>, vector<16xf32>) -> (), sym_name = "masked_store_with_alignment_attribute"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i64
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %4 = "llvm.getelementptr"(%3, %2) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.masked.store"(%arg2, %4, %arg1) <{alignment = 8 : i32}> : (vector<16xf32>, !llvm.ptr, vector<16xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<3xi32>, vector<3xi1>, vector<3xf32>) -> (), sym_name = "scatter"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<3xi32>, %arg2: vector<3xi1>, %arg3: vector<3xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i64
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %4 = "llvm.getelementptr"(%3, %2) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %5 = "llvm.getelementptr"(%4, %arg1) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, vector<3xi32>) -> vector<3x!llvm.ptr>
    "llvm.intr.masked.scatter"(%arg3, %5, %arg2) <{alignment = 16 : i32}> : (vector<3xf32>, vector<3x!llvm.ptr>, vector<3xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<3xi32>, vector<3xi1>, vector<3xf32>) -> (), sym_name = "scatter_with_alignment_attribute"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<3xi32>, %arg2: vector<3xi1>, %arg3: vector<3xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i64
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %4 = "llvm.getelementptr"(%3, %2) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %5 = "llvm.getelementptr"(%4, %arg1) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, vector<3xi32>) -> vector<3x!llvm.ptr>
    "llvm.intr.masked.scatter"(%arg3, %5, %arg2) <{alignment = 8 : i32}> : (vector<3xf32>, vector<3x!llvm.ptr>, vector<3xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<3xi32>, vector<3xi1>, vector<3xf32>) -> vector<3xf32>, sym_name = "gather"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<3xi32>, %arg2: vector<3xi1>, %arg3: vector<3xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i64
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %4 = "llvm.getelementptr"(%3, %2) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %5 = "llvm.getelementptr"(%4, %arg1) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, vector<3xi32>) -> vector<3x!llvm.ptr>
    %6 = "llvm.intr.masked.gather"(%5, %arg2, %arg3) <{alignment = 16 : i32}> : (vector<3x!llvm.ptr>, vector<3xi1>, vector<3xf32>) -> vector<3xf32>
    "func.return"(%6) : (vector<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<3xi32>, vector<3xi1>, vector<3xf32>) -> vector<3xf32>, sym_name = "gather_with_alignment_attribute"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<3xi32>, %arg2: vector<3xi1>, %arg3: vector<3xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i64
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %4 = "llvm.getelementptr"(%3, %2) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %5 = "llvm.getelementptr"(%4, %arg1) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, vector<3xi32>) -> vector<3x!llvm.ptr>
    %6 = "llvm.intr.masked.gather"(%5, %arg2, %arg3) <{alignment = 8 : i32}> : (vector<3x!llvm.ptr>, vector<3xi1>, vector<3xf32>) -> vector<3xf32>
    "func.return"(%6) : (vector<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

