"builtin.module"() ({
  "func.func"() <{function_type = (tensor<i32>) -> tensor<i32>, sym_name = "while_test"}> ({
  ^bb0(%arg0: tensor<i32>):
    %0 = "scf.while"(%arg0) ({
    ^bb0(%arg2: tensor<i32>):
      %3 = "tosa.const"() <{values = dense<3> : tensor<i32>}> : () -> tensor<i32>
      %4 = "tosa.greater_equal"(%3, %arg2) : (tensor<i32>, tensor<i32>) -> tensor<i1>
      %5 = "tensor.extract"(%4) : (tensor<i1>) -> i1
      "scf.condition"(%5, %arg2) : (i1, tensor<i32>) -> ()
    }, {
    ^bb0(%arg1: tensor<i32>):
      %1 = "tosa.const"() <{values = dense<1> : tensor<i32>}> : () -> tensor<i32>
      %2 = "tosa.add"(%arg1, %1) : (tensor<i32>, tensor<i32>) -> tensor<i32>
      "scf.yield"(%2) : (tensor<i32>) -> ()
    }) : (tensor<i32>) -> tensor<i32>
    "func.return"(%0) : (tensor<i32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>, tensor<f32>, tensor<i1>) -> tensor<f32>, sym_name = "if_test"}> ({
  ^bb0(%arg0: tensor<f32>, %arg1: tensor<f32>, %arg2: tensor<i1>):
    %0 = "tensor.extract"(%arg2) : (tensor<i1>) -> i1
    %1 = "scf.if"(%0) ({
      "scf.yield"(%arg0) : (tensor<f32>) -> ()
    }, {
      "scf.yield"(%arg1) : (tensor<f32>) -> ()
    }) : (i1) -> tensor<f32>
    "func.return"(%1) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x7x5xi32>, tensor<3x6xi32>, tensor<3x6x5xi32>) -> tensor<3x7x5xi32>, sym_name = "scatter_test"}> ({
  ^bb0(%arg0: tensor<3x7x5xi32>, %arg1: tensor<3x6xi32>, %arg2: tensor<3x6x5xi32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 3 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 6 : index}> : () -> index
    %4 = "arith.constant"() <{value = 2 : index}> : () -> index
    %5 = "arith.constant"() <{value = 5 : index}> : () -> index
    %6 = "arith.constant"() <{value = 0 : index}> : () -> index
    %7 = "arith.constant"() <{value = 1 : index}> : () -> index
    %8 = "scf.for"(%6, %1, %7, %arg0) ({
    ^bb0(%arg3: index, %arg4: tensor<3x7x5xi32>):
      %9 = "scf.for"(%6, %3, %7, %arg4) ({
      ^bb0(%arg5: index, %arg6: tensor<3x7x5xi32>):
        %10 = "tensor.extract"(%arg1, %arg3, %arg5) : (tensor<3x6xi32>, index, index) -> i32
        %11 = "arith.index_cast"(%10) : (i32) -> index
        %12 = "tensor.extract_slice"(%arg2, %arg3, %arg5, %6, %7, %7, %5, %7, %7, %7) <{operandSegmentSizes = array<i32: 1, 3, 3, 3>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (tensor<3x6x5xi32>, index, index, index, index, index, index, index, index, index) -> tensor<?x?x?xi32>
        %13 = "tensor.insert_slice"(%12, %arg6, %arg3, %11, %6, %7, %7, %5, %7, %7, %7) <{operandSegmentSizes = array<i32: 1, 1, 3, 3, 3>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (tensor<?x?x?xi32>, tensor<3x7x5xi32>, index, index, index, index, index, index, index, index, index) -> tensor<3x7x5xi32>
        "scf.yield"(%13) : (tensor<3x7x5xi32>) -> ()
      }) : (index, index, index, tensor<3x7x5xi32>) -> tensor<3x7x5xi32>
      "scf.yield"(%9) : (tensor<3x7x5xi32>) -> ()
    }) : (index, index, index, tensor<3x7x5xi32>) -> tensor<3x7x5xi32>
    "func.return"(%8) : (tensor<3x7x5xi32>) -> ()
  }) : () -> ()
}) : () -> ()

