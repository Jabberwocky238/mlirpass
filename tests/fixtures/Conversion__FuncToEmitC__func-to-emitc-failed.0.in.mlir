"builtin.module"() ({
  "func.func"() <{function_type = (i4) -> i4, sym_name = "unsuppoted_emitc_type"}> ({
  ^bb0(%arg0: i4):
    "func.return"(%arg0) : (i4) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<1xi32>, sym_name = "return_rank1_alloc", sym_visibility = "private"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1xi32>
    "func.return"(%0) : (memref<1xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1xi32>) -> memref<1xi32>, sym_name = "return_rank1_arg", sym_visibility = "private"}> ({
  ^bb0(%arg0: memref<1xi32>):
    "func.return"(%arg0) : (memref<1xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x1xi32>) -> memref<1x1xi32>, sym_name = "return_rank2_arg", sym_visibility = "private"}> ({
  ^bb0(%arg0: memref<1x1xi32>):
    "func.return"(%arg0) : (memref<1x1xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2xi64>) -> memref<2xi64>, sym_name = "return_rank1_two_elements", sym_visibility = "private"}> ({
  ^bb0(%arg0: memref<2xi64>):
    "func.return"(%arg0) : (memref<2xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1xi32>) -> (memref<1xi32>, i32), sym_name = "return_multiple_values", sym_visibility = "private"}> ({
  ^bb0(%arg0: memref<1xi32>):
    %0 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    "func.return"(%arg0, %0) : (memref<1xi32>, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi32>) -> memref<?xi32>, sym_name = "return_dynamic_shape", sym_visibility = "private"}> ({
  ^bb0(%arg0: memref<?xi32>):
    "func.return"(%arg0) : (memref<?xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x1xi32, strided<[2, 1]>>) -> memref<1x1xi32, strided<[2, 1]>>, sym_name = "return_non_identity_layout", sym_visibility = "private"}> ({
  ^bb0(%arg0: memref<1x1xi32, strided<[2, 1]>>):
    "func.return"(%arg0) : (memref<1x1xi32, strided<[2, 1]>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xi32>) -> memref<*xi32>, sym_name = "return_unranked", sym_visibility = "private"}> ({
  ^bb0(%arg0: memref<*xi32>):
    "func.return"(%arg0) : (memref<*xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1xi64>) -> memref<1xi64>, sym_name = "public_function"}> ({
  ^bb0(%arg0: memref<1xi64>):
    "func.return"(%arg0) : (memref<1xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64) -> i64, sym_name = "callee", sym_visibility = "private"}> ({
  ^bb0(%arg2: i64):
    "func.return"(%arg2) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1xi64>, i64) -> memref<1xi64>, sym_name = "caller", sym_visibility = "private"}> ({
  ^bb0(%arg0: memref<1xi64>, %arg1: i64):
    %0 = "func.call"(%arg1) <{callee = @callee}> : (i64) -> i64
    "func.return"(%arg0) : (memref<1xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "emitc.func"() <{function_type = () -> (), sym_name = "return_i32_i32"}> ({
    "emitc.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "symbol_not_a_class"}> ({
  ^bb0(%arg0: i32):
    "func.return"(%arg0, %arg0) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "emitc.class"() <{class_type = 0 : i32, sym_name = "return_i32_i32"}> ({
    "emitc.field"() <{sym_name = "field0", type = i32}> : () -> ()
    "emitc.field"() <{sym_name = "field1", type = i32}> : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "class_not_a_struct"}> ({
  ^bb0(%arg0: i32):
    "func.return"(%arg0, %arg0) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "emitc.class"() <{class_type = 1 : i32, sym_name = "return_i32_i32"}> ({
    "emitc.func"() <{function_type = () -> (), sym_name = "method"}> ({
      "emitc.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "class_has_methods"}> ({
  ^bb0(%arg0: i32):
    "func.return"(%arg0, %arg0) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "emitc.class"() <{class_type = 1 : i32, sym_name = "return_i32_i32"}> ({
    "emitc.field"() <{sym_name = "field0", type = i32}> : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "class_wrong_field_count"}> ({
  ^bb0(%arg0: i32):
    "func.return"(%arg0, %arg0) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "emitc.class"() <{class_type = 1 : i32, sym_name = "return_i32_i32"}> ({
    "emitc.field"() <{sym_name = "a", type = i32}> : () -> ()
    "emitc.field"() <{sym_name = "b", type = i32}> : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "class_wrong_field_names"}> ({
  ^bb0(%arg0: i32):
    "func.return"(%arg0, %arg0) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "emitc.class"() <{class_type = 1 : i32, sym_name = "return_i32_i32"}> ({
    "emitc.field"() <{sym_name = "field0", type = i64}> : () -> ()
    "emitc.field"() <{sym_name = "field1", type = i32}> : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "class_wrong_field_types"}> ({
  ^bb0(%arg0: i32):
    "func.return"(%arg0, %arg0) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (i32, !emitc.array<10xi32>), sym_name = "multi_result_with_array", sym_visibility = "private"}> ({
  }) : () -> ()
}) : () -> ()

