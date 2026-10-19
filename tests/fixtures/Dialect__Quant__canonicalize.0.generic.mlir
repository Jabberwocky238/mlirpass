"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xf32>) -> tensor<4xf32>, sym_name = "dcast_fold"}> ({
  ^bb0(%arg0: tensor<4xf32>):
    "func.return"(%arg0) : (tensor<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xi8>) -> tensor<4xf32>, sym_name = "dcast_no_fold_source"}> ({
  ^bb0(%arg0: tensor<4xi8>):
    %0 = "quant.scast"(%arg0) : (tensor<4xi8>) -> tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>
    %1 = "quant.dcast"(%0) : (tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>) -> tensor<4xf32>
    "func.return"(%1) : (tensor<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>) -> tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>, sym_name = "qcast_fold"}> ({
  ^bb0(%arg0: tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>):
    "func.return"(%arg0) : (tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xf32>) -> tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>, sym_name = "qcast_no_fold_source"}> ({
  ^bb0(%arg0: tensor<4xf32>):
    %0 = "arith.negf"(%arg0) <{fastmath = #arith.fastmath<none>}> : (tensor<4xf32>) -> tensor<4xf32>
    %1 = "quant.qcast"(%0) : (tensor<4xf32>) -> tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>
    "func.return"(%1) : (tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>) -> tensor<4x!quant.uniform<u8:f32, 3.000000e+00:128>>, sym_name = "qcast_no_fold_type"}> ({
  ^bb0(%arg0: tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>):
    %0 = "quant.dcast"(%arg0) : (tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>) -> tensor<4xf32>
    %1 = "quant.qcast"(%0) : (tensor<4xf32>) -> tensor<4x!quant.uniform<u8:f32, 3.000000e+00:128>>
    "func.return"(%1) : (tensor<4x!quant.uniform<u8:f32, 3.000000e+00:128>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>) -> tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>, sym_name = "scast_fold"}> ({
  ^bb0(%arg0: tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>):
    "func.return"(%arg0) : (tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xf32>) -> tensor<4xi8>, sym_name = "scast_no_fold_source"}> ({
  ^bb0(%arg0: tensor<4xf32>):
    %0 = "quant.qcast"(%arg0) : (tensor<4xf32>) -> tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>
    %1 = "quant.scast"(%0) : (tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>) -> tensor<4xi8>
    "func.return"(%1) : (tensor<4xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>) -> tensor<4x!quant.uniform<u8:f32, 3.000000e+00:128>>, sym_name = "scast_no_fold_type"}> ({
  ^bb0(%arg0: tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>):
    %0 = "quant.scast"(%arg0) : (tensor<4x!quant.uniform<u8:f32, 2.000000e+00:128>>) -> tensor<4xi8>
    %1 = "quant.scast"(%0) : (tensor<4xi8>) -> tensor<4x!quant.uniform<u8:f32, 3.000000e+00:128>>
    "func.return"(%1) : (tensor<4x!quant.uniform<u8:f32, 3.000000e+00:128>>) -> ()
  }) : () -> ()
}) : () -> ()

