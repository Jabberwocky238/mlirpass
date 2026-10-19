module {
  spirv.func @tensor_extract_constant(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 "None" {
    %cst = spirv.Constant dense<[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]> : tensor<12xi32> : !spirv.array<12 x i32>
    %0 = spirv.Variable : !spirv.ptr<!spirv.array<12 x i32>, Function>
    spirv.Store "Function" %0, %cst : !spirv.array<12 x i32>
    %cst0_i32 = spirv.Constant 0 : i32
    %cst6_i32 = spirv.Constant 6 : i32
    %1 = spirv.IMul %arg0, %cst6_i32 : i32
    %cst3_i32 = spirv.Constant 3 : i32
    %2 = spirv.IMul %arg1, %cst3_i32 : i32
    %3 = spirv.IAdd %2, %1 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %4 = spirv.IAdd %arg2, %3 : i32
    %5 = spirv.AccessChain %0[%4] : !spirv.ptr<!spirv.array<12 x i32>, Function>, i32 -> !spirv.ptr<i32, Function>
    %6 = spirv.Load "Function" %5 : i32
    spirv.ReturnValue %6 : i32
  }
}

// -----
module {
  spirv.func @test_spirv_unsupported_type_index(%arg0: i32) "None" {
    %0 = builtin.unrealized_conversion_cast %arg0 : i32 to index
    %cst = spirv.Constant dense<[1, 2]> : tensor<2xi32> : !spirv.array<2 x i32>
    %1 = builtin.unrealized_conversion_cast %cst : !spirv.array<2 x i32> to tensor<2xindex>
    %extracted = tensor.extract %1[%0] : tensor<2xindex>
    spirv.Return
  }
  spirv.func @test_spirv_unsupported_type_i128(%arg0: i32) "None" {
    %0 = builtin.unrealized_conversion_cast %arg0 : i32 to index
    %cst = arith.constant dense<[1, 2]> : tensor<2xi128>
    %extracted = tensor.extract %cst[%0] : tensor<2xi128>
    spirv.Return
  }
}

// -----
module {
  spirv.func @tensor_0d() "None" {
    %cst1_i32 = spirv.Constant 1 : i32
    spirv.Return
  }
  spirv.func @tensor_1d() "None" {
    %cst = spirv.Constant dense<[1, 2, 3]> : tensor<3xi32> : !spirv.array<3 x i32>
    spirv.Return
  }
  spirv.func @tensor_2d() "None" {
    %cst = spirv.Constant dense<[1, 2, 3, 4, 5, 6]> : tensor<6xi32> : !spirv.array<6 x i32>
    spirv.Return
  }
  spirv.func @tensor_2d_empty() "None" {
    %cst = arith.constant dense<> : tensor<2x0xi32>
    spirv.Return
  }
  spirv.func @very_large_tensor() "None" {
    %cst = arith.constant dense<1> : tensor<4294967296xi32>
    spirv.Return
  }
}

