"builtin.module"() ({
  "memref.global"() <{alignment = 64 : i64, constant, initial_value = dense<0.000000e+00> : tensor<f32>, sym_name = "__constant_xf32", sym_visibility = "private", type = memref<f32>}> : () -> ()
  "func.func"() <{function_type = () -> tensor<f32>, sym_name = "different_before_after_args"}> ({
    %0 = "arith.constant"() <{value = true}> : () -> i1
    %1 = "memref.get_global"() <{name = @__constant_xf32}> : () -> memref<f32>
    %2 = "scf.while"(%0) ({
    ^bb0(%arg1: i1):
      %4 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
      "memref.copy"(%1, %4) : (memref<f32>, memref<f32>) -> ()
      "scf.condition"(%0, %4) : (i1, memref<f32>) -> ()
    }, {
    ^bb0(%arg0: memref<f32>):
      "scf.yield"(%0) : (i1) -> ()
    }) : (i1) -> memref<f32>
    %3 = "bufferization.to_tensor"(%2) : (memref<f32>) -> tensor<f32>
    "func.return"(%3) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

