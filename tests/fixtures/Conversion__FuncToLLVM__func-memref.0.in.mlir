"builtin.module"() ({
  "func.func"() <{arg_attrs = [{llvm.noalias}, {llvm.noalias}], function_type = (memref<2xf32>, memref<2xf32>) -> (), sym_name = "check_noalias"}> ({
  ^bb0(%arg0: memref<2xf32>, %arg1: memref<2xf32>):
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0 * 20 + d1 + 1)>
#map1 = affine_map<(d0, d1)[s0] -> (d0 * s0 + d1 + 1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10x20xf32, #map>, memref<?x?xf32, #map1>, memref<10x?xf32, #map1>) -> (), sym_name = "check_strided_memref_arguments"}> ({
  ^bb0(%arg0: memref<10x20xf32, #map>, %arg1: memref<?x?xf32, #map1>, %arg2: memref<10x?xf32, #map1>):
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xindex>) -> memref<32xindex>, sym_name = "memref_index"}> ({
  ^bb0(%arg0: memref<32xindex>):
    "func.return"(%arg0) : (memref<32xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10x20xf32>, memref<?x?xf32>, memref<10x?xf32>) -> (), sym_name = "check_arguments"}> ({
  ^bb0(%arg0: memref<10x20xf32>, %arg1: memref<?x?xf32>, %arg2: memref<10x?xf32>):
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xi8>) -> memref<*xi8>, sym_name = "hoo", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<*xi8>) -> memref<*xi8>, sym_name = "check_unranked_memref_func_call"}> ({
  ^bb0(%arg0: memref<*xi8>):
    %0 = "func.call"(%arg0) <{callee = @hoo}> : (memref<*xi8>) -> memref<*xi8>
    "func.return"(%0) : (memref<*xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<42x!test.memref_element>, sym_name = "unsupported_memref_element_type", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<*x!test.memref_element>, sym_name = "unsupported_unranked_memref_element_type", sym_visibility = "private"}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> f32, sym_name = "goo", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> (), sym_name = "check_scalar_func_call"}> ({
  ^bb0(%arg0: f32):
    %0 = "func.call"(%arg0) <{callee = @goo}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, memref<64xi32, 201>, memref<64xi32, 201>) -> (memref<64xi32, 201>, memref<64xi32, 201>), sym_name = "loop_carried"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: memref<64xi32, 201>, %arg4: memref<64xi32, 201>):
    "cf.br"(%arg0, %arg3, %arg4)[^bb1] : (index, memref<64xi32, 201>, memref<64xi32, 201>) -> ()
  ^bb1(%0: index, %1: memref<64xi32, 201>, %2: memref<64xi32, 201>):  // 2 preds: ^bb0, ^bb2
    %3 = "arith.cmpi"(%0, %arg1) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%3)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %4 = "arith.addi"(%0, %arg2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%4, %2, %1)[^bb1] : (index, memref<64xi32, 201>, memref<64xi32, 201>) -> ()
  ^bb3:  // pred: ^bb1
    "func.return"(%1, %2) : (memref<64xi32, 201>, memref<64xi32, 201>) -> ()
  }) : () -> ()
}) : () -> ()

