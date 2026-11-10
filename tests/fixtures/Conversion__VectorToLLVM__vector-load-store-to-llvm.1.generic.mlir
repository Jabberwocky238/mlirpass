"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> vector<8xf32>, sym_name = "load"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %8 = "llvm.load"(%7) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> vector<8xf32>
    "func.return"(%8) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> vector<[8]xf32>, sym_name = "load_scalable"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %8 = "llvm.load"(%7) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> vector<[8]xf32>
    "func.return"(%8) : (vector<[8]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> vector<8xf32>, sym_name = "load_nontemporal"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %8 = "llvm.load"(%7) <{alignment = 4 : i64, nontemporal, ordering = 0 : i64}> : (!llvm.ptr) -> vector<8xf32>
    "func.return"(%8) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> vector<[8]xf32>, sym_name = "load_nontemporal_scalable"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %8 = "llvm.load"(%7) <{alignment = 4 : i64, nontemporal, ordering = 0 : i64}> : (!llvm.ptr) -> vector<[8]xf32>
    "func.return"(%8) : (vector<[8]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xindex>, index, index) -> vector<8xindex>, sym_name = "load_index"}> ({
  ^bb0(%arg0: memref<200x100xindex>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xindex>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = i64, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %8 = "llvm.load"(%7) <{alignment = 8 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> vector<8xi64>
    %9 = "builtin.unrealized_conversion_cast"(%8) : (vector<8xi64>) -> vector<8xindex>
    "func.return"(%9) : (vector<8xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xindex>, index, index) -> vector<[8]xindex>, sym_name = "load_index_scalable"}> ({
  ^bb0(%arg0: memref<200x100xindex>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xindex>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = i64, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %8 = "llvm.load"(%7) <{alignment = 8 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> vector<[8]xi64>
    %9 = "builtin.unrealized_conversion_cast"(%8) : (vector<[8]xi64>) -> vector<[8]xindex>
    "func.return"(%9) : (vector<[8]xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> vector<f32>, sym_name = "load_0d"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %8 = "llvm.load"(%7) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> vector<1xf32>
    %9 = "builtin.unrealized_conversion_cast"(%8) : (vector<1xf32>) -> vector<f32>
    "func.return"(%9) : (vector<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> vector<8xf32>, sym_name = "load_with_alignment"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
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
    %6 = "llvm.mul"(%1, %5) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %7 = "llvm.add"(%6, %0) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %8 = "llvm.getelementptr"(%4, %7) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.store"(%3, %8) <{alignment = 4 : i64, ordering = 0 : i64}> : (vector<4xf32>, !llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> (), sym_name = "store_scalable"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "arith.constant"() <{value = dense<1.100000e+01> : vector<[4]xf32>}> : () -> vector<[4]xf32>
    %4 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %5 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %6 = "llvm.mul"(%1, %5) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %7 = "llvm.add"(%6, %0) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %8 = "llvm.getelementptr"(%4, %7) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.store"(%3, %8) <{alignment = 4 : i64, ordering = 0 : i64}> : (vector<[4]xf32>, !llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> (), sym_name = "store_nontemporal"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "arith.constant"() <{value = dense<1.100000e+01> : vector<4xf32>}> : () -> vector<4xf32>
    %4 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %5 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %6 = "llvm.mul"(%1, %5) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %7 = "llvm.add"(%6, %0) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %8 = "llvm.getelementptr"(%4, %7) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.store"(%3, %8) <{alignment = 4 : i64, nontemporal, ordering = 0 : i64}> : (vector<4xf32>, !llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> (), sym_name = "store_nontemporal_scalable"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "arith.constant"() <{value = dense<1.100000e+01> : vector<[4]xf32>}> : () -> vector<[4]xf32>
    %4 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %5 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %6 = "llvm.mul"(%1, %5) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %7 = "llvm.add"(%6, %0) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %8 = "llvm.getelementptr"(%4, %7) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.store"(%3, %8) <{alignment = 4 : i64, nontemporal, ordering = 0 : i64}> : (vector<[4]xf32>, !llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xindex>, index, index) -> (), sym_name = "store_index"}> ({
  ^bb0(%arg0: memref<200x100xindex>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xindex>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "arith.constant"() <{value = dense<11> : vector<4xindex>}> : () -> vector<4xindex>
    %4 = "builtin.unrealized_conversion_cast"(%3) : (vector<4xindex>) -> vector<4xi64>
    %5 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %6 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %7 = "llvm.mul"(%1, %6) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %8 = "llvm.add"(%7, %0) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %9 = "llvm.getelementptr"(%5, %8) <{elem_type = i64, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.store"(%4, %9) <{alignment = 8 : i64, ordering = 0 : i64}> : (vector<4xi64>, !llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xindex>, index, index) -> (), sym_name = "store_index_scalable"}> ({
  ^bb0(%arg0: memref<200x100xindex>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xindex>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "arith.constant"() <{value = dense<11> : vector<[4]xindex>}> : () -> vector<[4]xindex>
    %4 = "builtin.unrealized_conversion_cast"(%3) : (vector<[4]xindex>) -> vector<[4]xi64>
    %5 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %6 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %7 = "llvm.mul"(%1, %6) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %8 = "llvm.add"(%7, %0) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %9 = "llvm.getelementptr"(%5, %8) <{elem_type = i64, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.store"(%4, %9) <{alignment = 8 : i64, ordering = 0 : i64}> : (vector<[4]xi64>, !llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> (), sym_name = "store_0d"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "arith.constant"() <{value = dense<1.100000e+01> : vector<f32>}> : () -> vector<f32>
    %4 = "builtin.unrealized_conversion_cast"(%3) : (vector<f32>) -> vector<1xf32>
    %5 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %6 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %7 = "llvm.mul"(%1, %6) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %8 = "llvm.add"(%7, %0) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %9 = "llvm.getelementptr"(%5, %8) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.store"(%4, %9) <{alignment = 4 : i64, ordering = 0 : i64}> : (vector<1xf32>, !llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index, vector<4xf32>) -> (), sym_name = "store_with_alignment"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index, %arg3: vector<4xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.store"(%arg3, %7) <{alignment = 8 : i64, ordering = 0 : i64}> : (vector<4xf32>, !llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

