"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<i32>, sym_name = "const_test"}> ({
    %0 = "tosa.const"() <{values = dense<3> : tensor<i32>}> : () -> tensor<i32>
    "func.return"(%0) : (tensor<i32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, i8) -> i32, sym_name = "apply_scale_test_i32"}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i8):
    %0 = "tosa.apply_scale"(%arg0, %arg1, %arg2) <{rounding_mode = #tosa.rounding_mode<DOUBLE_ROUND>}> : (i32, i32, i8) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi32>, vector<4xi32>, vector<4xi8>) -> vector<4xi32>, sym_name = "apply_scale_test_vector"}> ({
  ^bb0(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi8>):
    %0 = "tosa.apply_scale"(%arg0, %arg1, %arg2) <{rounding_mode = #tosa.rounding_mode<DOUBLE_ROUND>}> : (vector<4xi32>, vector<4xi32>, vector<4xi8>) -> vector<4xi32>
    "func.return"(%0) : (vector<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i48, i32, i8) -> i32, sym_name = "apply_scale_test_i48"}> ({
  ^bb0(%arg0: i48, %arg1: i32, %arg2: i8):
    %0 = "tosa.apply_scale"(%arg0, %arg1, %arg2) <{rounding_mode = #tosa.rounding_mode<DOUBLE_ROUND>}> : (i48, i32, i8) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64, i32, i8) -> i32, sym_name = "apply_scale_test_i64"}> ({
  ^bb0(%arg0: i64, %arg1: i32, %arg2: i8):
    %0 = "tosa.apply_scale"(%arg0, %arg1, %arg2) <{rounding_mode = #tosa.rounding_mode<DOUBLE_ROUND>}> : (i64, i32, i8) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

