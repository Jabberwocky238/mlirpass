"builtin.module"() ({
  "func.func"() <{function_type = (i1, tensor<?xf32>, tensor<?xf32>) -> tensor<?xf32>, sym_name = "if"}> ({
  ^bb0(%arg0: i1, %arg1: tensor<?xf32>, %arg2: tensor<?xf32>):
    %0 = "bufferization.to_buffer"(%arg2) : (tensor<?xf32>) -> memref<?xf32>
    %1 = "bufferization.to_buffer"(%arg1) : (tensor<?xf32>) -> memref<?xf32>
    %2 = "scf.if"(%arg0) ({
      "scf.yield"(%1) : (memref<?xf32>) -> ()
    }, {
      "scf.yield"(%0) : (memref<?xf32>) -> ()
    }) : (i1) -> memref<?xf32>
    %3 = "bufferization.to_tensor"(%2) : (memref<?xf32>) -> tensor<?xf32>
    "func.return"(%3) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>, index, index, index) -> tensor<f32>, sym_name = "for"}> ({
  ^bb0(%arg0: tensor<f32>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<f32>) -> memref<f32>
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    "memref.copy"(%0, %1) : (memref<f32>, memref<f32>) -> ()
    %2 = "scf.for"(%arg1, %arg2, %arg3, %1) ({
    ^bb0(%arg4: index, %arg5: memref<f32>):
      "scf.yield"(%arg5) : (memref<f32>) -> ()
    }) {some_attr} : (index, index, index, memref<f32>) -> memref<f32>
    %3 = "bufferization.to_tensor"(%2) : (memref<f32>) -> tensor<f32>
    "func.return"(%3) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, tensor<f32>) -> tensor<f32>, sym_name = "if_correct_recursive_legalization_behavior"}> ({
  ^bb0(%arg0: i1, %arg1: tensor<f32>):
    %0 = "scf.if"(%arg0) ({
      %4 = "test.munge_tensor"(%arg1) : (tensor<f32>) -> tensor<f32>
      %5 = "bufferization.to_buffer"(%4) : (tensor<f32>) -> memref<f32>
      "scf.yield"(%5) : (memref<f32>) -> ()
    }, {
      %2 = "test.munge_tensor"(%arg1) : (tensor<f32>) -> tensor<f32>
      %3 = "bufferization.to_buffer"(%2) : (tensor<f32>) -> memref<f32>
      "scf.yield"(%3) : (memref<f32>) -> ()
    }) : (i1) -> memref<f32>
    %1 = "bufferization.to_tensor"(%0) : (memref<f32>) -> tensor<f32>
    "func.return"(%1) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>, index) -> tensor<f32>, sym_name = "for_correct_recursive_legalization_behavior"}> ({
  ^bb0(%arg0: tensor<f32>, %arg1: index):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<f32>) -> memref<f32>
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    "memref.copy"(%0, %1) : (memref<f32>, memref<f32>) -> ()
    %2 = "scf.for"(%arg1, %arg1, %arg1, %1) ({
    ^bb0(%arg2: index, %arg3: memref<f32>):
      %4 = "bufferization.to_tensor"(%arg3) : (memref<f32>) -> tensor<f32>
      %5 = "test.munge_tensor"(%4) : (tensor<f32>) -> tensor<f32>
      %6 = "bufferization.to_buffer"(%5) : (tensor<f32>) -> memref<f32>
      "scf.yield"(%6) : (memref<f32>) -> ()
    }) : (index, index, index, memref<f32>) -> memref<f32>
    %3 = "bufferization.to_tensor"(%2) : (memref<f32>) -> tensor<f32>
    "func.return"(%3) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64, i64, tensor<f32>) -> (i64, tensor<f32>), sym_name = "bufferize_while"}> ({
  ^bb0(%arg0: i64, %arg1: i64, %arg2: tensor<f32>):
    %0 = "bufferization.to_buffer"(%arg2) : (tensor<f32>) -> memref<f32>
    %1 = "arith.constant"() <{value = 2 : i64}> : () -> i64
    %2 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    "memref.copy"(%0, %2) : (memref<f32>, memref<f32>) -> ()
    %3:3 = "scf.while"(%arg0, %2) ({
    ^bb0(%arg6: i64, %arg7: memref<f32>):
      %6 = "arith.cmpi"(%arg6, %arg1) <{predicate = 2 : i64}> : (i64, i64) -> i1
      "scf.condition"(%6, %arg6, %arg6, %arg7) : (i1, i64, i64, memref<f32>) -> ()
    }, {
    ^bb0(%arg3: i64, %arg4: i64, %arg5: memref<f32>):
      %5 = "arith.muli"(%arg4, %1) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      "scf.yield"(%5, %arg5) : (i64, memref<f32>) -> ()
    }) : (i64, memref<f32>) -> (i64, i64, memref<f32>)
    %4 = "bufferization.to_tensor"(%3#2) : (memref<f32>) -> tensor<f32>
    "func.return"(%3#1, %4) : (i64, tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

