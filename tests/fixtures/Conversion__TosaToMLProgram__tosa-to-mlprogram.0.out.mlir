module {
  ml_program.global private mutable @var_x(dense<7.000000e+00> : tensor<1xf32>) : tensor<1xf32>
  func.func @test_stateful_ops(%arg0: tensor<1xf32>) -> tensor<1xf32> {
    ml_program.global_store @var_x = %arg0 : tensor<1xf32>
    %var_x = ml_program.global_load @var_x : tensor<1xf32>
    return %var_x : tensor<1xf32>
  }
}

// -----
module {
  ml_program.global private mutable @var_x : tensor<f32>
  func.func @test_stateful_ops(%arg0: tensor<f32>) -> tensor<f32> {
    ml_program.global_store @var_x = %arg0 : tensor<f32>
    %var_x = ml_program.global_load @var_x : tensor<f32>
    return %var_x : tensor<f32>
  }
}

