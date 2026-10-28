module {
  func.func @const() {
    %true = spirv.Constant true
    %false = spirv.Constant false
    %cst42_i32 = spirv.Constant 42 : i32
    %cst-42_i32 = spirv.Constant -42 : i32
    %cst43_i64 = spirv.Constant 43 : i64
    %cst6_ui8 = spirv.Constant 6 : ui8
    %cst_f32 = spirv.Constant 5.000000e-01 : f32
    %cst_f64 = spirv.Constant 5.000000e-01 : f64
    %cst_vec_3xi32 = spirv.Constant dense<[1, 2, 3]> : vector<3xi32>
    %cst = spirv.Constant [dense<3.000000e+00> : vector<2xf32>] : !spirv.array<1 x vector<2xf32>>
    return
  }
}

// -----
module {
  spirv.module Logical GLSL450 {
    spirv.GlobalVariable @global_var : !spirv.ptr<f32, Input>
    spirv.func @addressof() "None" {
      %global_var_addr = spirv.mlir.addressof @global_var : !spirv.ptr<f32, Input>
      spirv.Return
    }
  }
}

