"builtin.module"() ({
  "ml_program.global"() <{is_mutable, sym_name = "global", sym_visibility = "private", type = tensor<i64>, value = dense<0> : tensor<i64>}> : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "global_load_store"}> ({
    %0 = "arith.constant"() <{value = 127 : i64}> : () -> i64
    %1 = "ml_program.global_load"() <{global = @global}> : () -> tensor<i64>
    %2 = "tensor.extract"(%1) : (tensor<i64>) -> i64
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %4 = "tensor.insert"(%3, %1) : (i64, tensor<i64>) -> tensor<i64>
    "ml_program.global_store"(%4) <{global = @global}> : (tensor<i64>) -> ()
    "func.return"(%3) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "ml_program.global"() <{is_mutable, sym_name = "global", sym_visibility = "private", type = tensor<i64>, value = dense<0> : tensor<i64>}> : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "raw_hazard"}> ({
    %0 = "arith.constant"() <{value = 127 : i64}> : () -> i64
    %1 = "ml_program.global_load"() <{global = @global}> : () -> tensor<i64>
    %2 = "ml_program.global_load"() <{global = @global}> : () -> tensor<i64>
    %3 = "tensor.insert"(%0, %1) : (i64, tensor<i64>) -> tensor<i64>
    %4 = "tensor.extract"(%2) : (tensor<i64>) -> i64
    "ml_program.global_store"(%3) <{global = @global}> : (tensor<i64>) -> ()
    "func.return"(%4) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "ml_program.global"() <{is_mutable, sym_name = "state_tensor", sym_visibility = "private", type = tensor<4x75xf32>, value = dense<0.000000e+00> : tensor<4x75xf32>}> : () -> ()
  "func.func"() <{function_type = () -> tensor<4x75xf32>, sym_name = "global_load_store_tensor"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "ml_program.global_load"() <{global = @state_tensor}> : () -> tensor<4x75xf32>
    %3 = "tensor.extract"(%2, %0, %0) : (tensor<4x75xf32>, index, index) -> f32
    %4 = "arith.addf"(%3, %1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %5 = "tensor.insert"(%4, %2, %0, %0) : (f32, tensor<4x75xf32>, index, index) -> tensor<4x75xf32>
    "ml_program.global_store"(%5) <{global = @state_tensor}> : (tensor<4x75xf32>) -> ()
    "func.return"(%5) : (tensor<4x75xf32>) -> ()
  }) : () -> ()
}) : () -> ()

