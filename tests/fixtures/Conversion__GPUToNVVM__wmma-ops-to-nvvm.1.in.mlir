"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = () -> !gpu.mma_matrix<16x16xf16, "AOp">, sym_name = "gpu_wmma_load_op"}> ({
      %0 = "memref.alloca"() <{alignment = 32 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf16, 3>
      %1 = "arith.constant"() <{value = 16 : index}> : () -> index
      %2 = "arith.constant"() <{value = 16 : index}> : () -> index
      %3 = "gpu.subgroup_mma_load_matrix"(%0, %1, %2) <{leadDimension = 32 : index, transpose}> : (memref<32x32xf16, 3>, index, index) -> !gpu.mma_matrix<16x16xf16, "AOp">
      "func.return"(%3) : (!gpu.mma_matrix<16x16xf16, "AOp">) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = () -> !gpu.mma_matrix<16x16xsi8, "AOp">, sym_name = "gpu_wmma_int8_load_op"}> ({
      %0 = "memref.alloca"() <{alignment = 32 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xi8, 3>
      %1 = "arith.constant"() <{value = 16 : index}> : () -> index
      %2 = "arith.constant"() <{value = 16 : index}> : () -> index
      %3 = "gpu.subgroup_mma_load_matrix"(%0, %1, %2) <{leadDimension = 32 : index, transpose}> : (memref<32x32xi8, 3>, index, index) -> !gpu.mma_matrix<16x16xsi8, "AOp">
      "func.return"(%3) : (!gpu.mma_matrix<16x16xsi8, "AOp">) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = () -> !gpu.mma_matrix<8x4xf64, "AOp">, sym_name = "gpu_wmma_f64_load_op"}> ({
      %0 = "memref.alloca"() <{alignment = 32 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf64, 3>
      %1 = "arith.constant"() <{value = 16 : index}> : () -> index
      %2 = "arith.constant"() <{value = 16 : index}> : () -> index
      %3 = "gpu.subgroup_mma_load_matrix"(%0, %1, %2) <{leadDimension = 32 : index}> : (memref<32x32xf64, 3>, index, index) -> !gpu.mma_matrix<8x4xf64, "AOp">
      "func.return"(%3) : (!gpu.mma_matrix<8x4xf64, "AOp">) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (!gpu.mma_matrix<16x16xf16, "COp">) -> (), sym_name = "gpu_wmma_store_op"}> ({
    ^bb0(%arg0: !gpu.mma_matrix<16x16xf16, "COp">):
      %0 = "memref.alloca"() <{alignment = 32 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf16, 3>
      %1 = "arith.constant"() <{value = 16 : index}> : () -> index
      %2 = "arith.constant"() <{value = 16 : index}> : () -> index
      "gpu.subgroup_mma_store_matrix"(%arg0, %0, %1, %2) <{leadDimension = 32 : index, transpose}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<32x32xf16, 3>, index, index) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (!gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">, sym_name = "gpu_wmma_mma_op"}> ({
    ^bb0(%arg0: !gpu.mma_matrix<16x16xf16, "AOp">, %arg1: !gpu.mma_matrix<16x16xf16, "BOp">, %arg2: !gpu.mma_matrix<16x16xf16, "COp">):
      %0 = "gpu.subgroup_mma_compute"(%arg0, %arg1, %arg2) <{a_transpose}> : (!gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      "func.return"(%0) : (!gpu.mma_matrix<16x16xf16, "COp">) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (!gpu.mma_matrix<32x16xsi8, "AOp">, !gpu.mma_matrix<16x8xsi8, "BOp">, !gpu.mma_matrix<32x8xi32, "COp">) -> !gpu.mma_matrix<32x8xi32, "COp">, sym_name = "gpu_wmma_mma_int8_op"}> ({
    ^bb0(%arg0: !gpu.mma_matrix<32x16xsi8, "AOp">, %arg1: !gpu.mma_matrix<16x8xsi8, "BOp">, %arg2: !gpu.mma_matrix<32x8xi32, "COp">):
      %0 = "gpu.subgroup_mma_compute"(%arg0, %arg1, %arg2) <{a_transpose}> : (!gpu.mma_matrix<32x16xsi8, "AOp">, !gpu.mma_matrix<16x8xsi8, "BOp">, !gpu.mma_matrix<32x8xi32, "COp">) -> !gpu.mma_matrix<32x8xi32, "COp">
      "func.return"(%0) : (!gpu.mma_matrix<32x8xi32, "COp">) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (memref<128x128xf16>, memref<128x128xf16>, memref<128x128xf16>) -> (), sym_name = "gpu_wmma_mma_loop_op"}> ({
    ^bb0(%arg0: memref<128x128xf16>, %arg1: memref<128x128xf16>, %arg2: memref<128x128xf16>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "arith.constant"() <{value = 128 : index}> : () -> index
      %2 = "arith.constant"() <{value = 32 : index}> : () -> index
      %3 = "gpu.subgroup_mma_load_matrix"(%arg2, %0, %0) <{leadDimension = 128 : index}> : (memref<128x128xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">
      "cf.br"(%0, %3)[^bb1] : (index, !gpu.mma_matrix<16x16xf16, "COp">) -> ()
    ^bb1(%4: index, %5: !gpu.mma_matrix<16x16xf16, "COp">):  // 2 preds: ^bb0, ^bb2
      %6 = "arith.cmpi"(%4, %1) <{predicate = 2 : i64}> : (index, index) -> i1
      "cf.cond_br"(%6)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      %7 = "gpu.subgroup_mma_load_matrix"(%arg0, %0, %4) <{leadDimension = 128 : index}> : (memref<128x128xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "AOp">
      %8 = "gpu.subgroup_mma_load_matrix"(%arg1, %4, %0) <{leadDimension = 128 : index}> : (memref<128x128xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "BOp">
      %9 = "gpu.subgroup_mma_compute"(%7, %8, %5) : (!gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      %10 = "arith.addi"(%4, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "cf.br"(%10, %9)[^bb1] : (index, !gpu.mma_matrix<16x16xf16, "COp">) -> ()
    ^bb3:  // pred: ^bb1
      "gpu.subgroup_mma_store_matrix"(%5, %arg2, %0, %0) <{leadDimension = 128 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<128x128xf16>, index, index) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = () -> !gpu.mma_matrix<16x16xf16, "COp">, sym_name = "gpu_wmma_constant_op"}> ({
      %0 = "arith.constant"() <{value = 1.000000e+00 : f16}> : () -> f16
      %1 = "gpu.subgroup_mma_constant_matrix"(%0) : (f16) -> !gpu.mma_matrix<16x16xf16, "COp">
      "func.return"(%1) : (!gpu.mma_matrix<16x16xf16, "COp">) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">, sym_name = "gpu_wmma_elementwise"}> ({
    ^bb0(%arg0: !gpu.mma_matrix<16x16xf16, "COp">, %arg1: !gpu.mma_matrix<16x16xf16, "COp">):
      %0 = "gpu.subgroup_mma_elementwise"(%arg0, %arg1) <{opType = #gpu<mma_element_wise addf>}> : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      %1 = "gpu.subgroup_mma_elementwise"(%0, %arg1) <{opType = #gpu<mma_element_wise maxf>}> : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      "func.return"(%1) : (!gpu.mma_matrix<16x16xf16, "COp">) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

