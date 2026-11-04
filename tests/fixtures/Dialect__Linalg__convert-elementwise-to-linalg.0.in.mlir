"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>, tensor<f32>) -> tensor<f32>, sym_name = "addf_rank0"}> ({
  ^bb0(%arg0: tensor<f32>, %arg1: tensor<f32>):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (tensor<f32>, tensor<f32>) -> tensor<f32>
    "func.return"(%0) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, tensor<?xf32>) -> tensor<?xf32>, sym_name = "addf_rank1"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (tensor<?xf32>, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%0) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>) -> tensor<f32>, sym_name = "exp"}> ({
  ^bb0(%arg0: tensor<f32>):
    %0 = "math.exp"(%arg0) <{fastmath = #arith.fastmath<none>}> : (tensor<f32>) -> tensor<f32>
    "func.return"(%0) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<i1>, tensor<i32>, tensor<i32>) -> tensor<i32>, sym_name = "select"}> ({
  ^bb0(%arg0: tensor<i1>, %arg1: tensor<i32>, %arg2: tensor<i32>):
    %0 = "arith.select"(%arg0, %arg1, %arg2) : (tensor<i1>, tensor<i32>, tensor<i32>) -> tensor<i32>
    "func.return"(%0) : (tensor<i32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>, tensor<f32>) -> tensor<i1>, sym_name = "cmpf"}> ({
  ^bb0(%arg0: tensor<f32>, %arg1: tensor<f32>):
    %0 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (tensor<f32>, tensor<f32>) -> tensor<i1>
    "func.return"(%0) : (tensor<i1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x?x?x8x2x?xf32>, tensor<4x?x?x8x2x?xf32>) -> tensor<4x?x?x8x2x?xi1>, sym_name = "cmpf"}> ({
  ^bb0(%arg0: tensor<4x?x?x8x2x?xf32>, %arg1: tensor<4x?x?x8x2x?xf32>):
    %0 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (tensor<4x?x?x8x2x?xf32>, tensor<4x?x?x8x2x?xf32>) -> tensor<4x?x?x8x2x?xi1>
    "func.return"(%0) : (tensor<4x?x?x8x2x?xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, tensor<?x?xf32>) -> tensor<?x?xf32>, sym_name = "scalar_plus_tensor"}> ({
  ^bb0(%arg0: f32, %arg1: tensor<?x?xf32>):
    %0 = "test.elementwise_mappable"(%arg0, %arg1) : (f32, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%0) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, tensor<?x?xf32>, f32) -> tensor<?x?xf32>, sym_name = "scalar_tensor_scalar"}> ({
  ^bb0(%arg2: f32, %arg3: tensor<?x?xf32>, %arg4: f32):
    %1 = "test.elementwise_mappable"(%arg2, %arg3) : (f32, tensor<?x?xf32>) -> tensor<?x?xf32>
    %2 = "test.elementwise_mappable"(%arg4, %1) : (f32, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%2) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "negative_scalar_only_eltwise"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

