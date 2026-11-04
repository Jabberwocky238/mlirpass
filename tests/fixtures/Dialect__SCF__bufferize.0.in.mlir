"builtin.module"() ({
  "func.func"() <{function_type = (i1, tensor<?xf32>, tensor<?xf32>) -> tensor<?xf32>, sym_name = "if"}> ({
  ^bb0(%arg0: i1, %arg1: tensor<?xf32>, %arg2: tensor<?xf32>):
    %0 = "scf.if"(%arg0) ({
      "scf.yield"(%arg1) : (tensor<?xf32>) -> ()
    }, {
      "scf.yield"(%arg2) : (tensor<?xf32>) -> ()
    }) : (i1) -> tensor<?xf32>
    "func.return"(%0) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>, index, index, index) -> tensor<f32>, sym_name = "for"}> ({
  ^bb0(%arg0: tensor<f32>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "scf.for"(%arg1, %arg2, %arg3, %arg0) ({
    ^bb0(%arg4: index, %arg5: tensor<f32>):
      "scf.yield"(%arg5) : (tensor<f32>) -> ()
    }) {some_attr} : (index, index, index, tensor<f32>) -> tensor<f32>
    "func.return"(%0) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, tensor<f32>) -> tensor<f32>, sym_name = "if_correct_recursive_legalization_behavior"}> ({
  ^bb0(%arg0: i1, %arg1: tensor<f32>):
    %0 = "scf.if"(%arg0) ({
      %2 = "test.munge_tensor"(%arg1) : (tensor<f32>) -> tensor<f32>
      "scf.yield"(%2) : (tensor<f32>) -> ()
    }, {
      %1 = "test.munge_tensor"(%arg1) : (tensor<f32>) -> tensor<f32>
      "scf.yield"(%1) : (tensor<f32>) -> ()
    }) : (i1) -> tensor<f32>
    "func.return"(%0) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>, index) -> tensor<f32>, sym_name = "for_correct_recursive_legalization_behavior"}> ({
  ^bb0(%arg0: tensor<f32>, %arg1: index):
    %0 = "scf.for"(%arg1, %arg1, %arg1, %arg0) ({
    ^bb0(%arg2: index, %arg3: tensor<f32>):
      %1 = "test.munge_tensor"(%arg3) : (tensor<f32>) -> tensor<f32>
      "scf.yield"(%1) : (tensor<f32>) -> ()
    }) : (index, index, index, tensor<f32>) -> tensor<f32>
    "func.return"(%0) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64, i64, tensor<f32>) -> (i64, tensor<f32>), sym_name = "bufferize_while"}> ({
  ^bb0(%arg0: i64, %arg1: i64, %arg2: tensor<f32>):
    %0 = "arith.constant"() <{value = 2 : i64}> : () -> i64
    %1:3 = "scf.while"(%arg0, %arg2) ({
    ^bb0(%arg6: i64, %arg7: tensor<f32>):
      %3 = "arith.cmpi"(%arg6, %arg1) <{predicate = 2 : i64}> : (i64, i64) -> i1
      "scf.condition"(%3, %arg6, %arg6, %arg7) : (i1, i64, i64, tensor<f32>) -> ()
    }, {
    ^bb0(%arg3: i64, %arg4: i64, %arg5: tensor<f32>):
      %2 = "arith.muli"(%arg4, %0) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      "scf.yield"(%2, %arg5) : (i64, tensor<f32>) -> ()
    }) : (i64, tensor<f32>) -> (i64, i64, tensor<f32>)
    "func.return"(%1#1, %1#2) : (i64, tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

