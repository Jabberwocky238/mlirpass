module {
  spirv.module Logical GLSL450 {
    spirv.func @umul_extended_i32(%arg0: i32, %arg1: i32) -> !spirv.struct<(i32, i32)> "None" {
      %cst65535_i32 = spirv.Constant 65535 : i32
      %cst16_i32 = spirv.Constant 16 : i32
      %0 = spirv.BitwiseAnd %arg0, %cst65535_i32 : i32
      %1 = spirv.ShiftRightLogical %arg0, %cst16_i32 : i32, i32
      %2 = spirv.BitwiseAnd %arg1, %cst65535_i32 : i32
      %3 = spirv.ShiftRightLogical %arg1, %cst16_i32 : i32, i32
      %4 = spirv.IMul %0, %2 : i32
      %5 = spirv.BitwiseAnd %4, %cst65535_i32 : i32
      %6 = spirv.ShiftRightLogical %4, %cst16_i32 : i32, i32
      %7 = spirv.IMul %0, %3 : i32
      %8 = spirv.IAdd %6, %7 : i32
      %9 = spirv.BitwiseAnd %8, %cst65535_i32 : i32
      %10 = spirv.ShiftRightLogical %8, %cst16_i32 : i32, i32
      %11 = spirv.IMul %1, %2 : i32
      %12 = spirv.IAdd %9, %11 : i32
      %13 = spirv.BitwiseAnd %12, %cst65535_i32 : i32
      %14 = spirv.ShiftRightLogical %12, %cst16_i32 : i32, i32
      %15 = spirv.IAdd %10, %14 : i32
      %16 = spirv.IMul %1, %3 : i32
      %17 = spirv.IAdd %15, %16 : i32
      %18 = spirv.BitwiseAnd %17, %cst65535_i32 : i32
      %19 = spirv.ShiftRightLogical %17, %cst16_i32 : i32, i32
      %20 = spirv.ShiftLeftLogical %13, %cst16_i32 : i32, i32
      %21 = spirv.BitwiseOr %5, %20 : i32
      %22 = spirv.ShiftLeftLogical %19, %cst16_i32 : i32, i32
      %23 = spirv.BitwiseOr %18, %22 : i32
      %24 = spirv.CompositeConstruct %21, %23 : (i32, i32) -> !spirv.struct<(i32, i32)>
      spirv.ReturnValue %24 : !spirv.struct<(i32, i32)>
    }
    spirv.func @umul_extended_vector_i32(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)> "None" {
      %cst_vec_3xi32 = spirv.Constant dense<65535> : vector<3xi32>
      %cst_vec_3xi32_0 = spirv.Constant dense<16> : vector<3xi32>
      %0 = spirv.BitwiseAnd %arg0, %cst_vec_3xi32 : vector<3xi32>
      %1 = spirv.ShiftRightLogical %arg0, %cst_vec_3xi32_0 : vector<3xi32>, vector<3xi32>
      %2 = spirv.BitwiseAnd %arg1, %cst_vec_3xi32 : vector<3xi32>
      %3 = spirv.ShiftRightLogical %arg1, %cst_vec_3xi32_0 : vector<3xi32>, vector<3xi32>
      %4 = spirv.IMul %0, %2 : vector<3xi32>
      %5 = spirv.BitwiseAnd %4, %cst_vec_3xi32 : vector<3xi32>
      %6 = spirv.ShiftRightLogical %4, %cst_vec_3xi32_0 : vector<3xi32>, vector<3xi32>
      %7 = spirv.IMul %0, %3 : vector<3xi32>
      %8 = spirv.IAdd %6, %7 : vector<3xi32>
      %9 = spirv.BitwiseAnd %8, %cst_vec_3xi32 : vector<3xi32>
      %10 = spirv.ShiftRightLogical %8, %cst_vec_3xi32_0 : vector<3xi32>, vector<3xi32>
      %11 = spirv.IMul %1, %2 : vector<3xi32>
      %12 = spirv.IAdd %9, %11 : vector<3xi32>
      %13 = spirv.BitwiseAnd %12, %cst_vec_3xi32 : vector<3xi32>
      %14 = spirv.ShiftRightLogical %12, %cst_vec_3xi32_0 : vector<3xi32>, vector<3xi32>
      %15 = spirv.IAdd %10, %14 : vector<3xi32>
      %16 = spirv.IMul %1, %3 : vector<3xi32>
      %17 = spirv.IAdd %15, %16 : vector<3xi32>
      %18 = spirv.BitwiseAnd %17, %cst_vec_3xi32 : vector<3xi32>
      %19 = spirv.ShiftRightLogical %17, %cst_vec_3xi32_0 : vector<3xi32>, vector<3xi32>
      %20 = spirv.ShiftLeftLogical %13, %cst_vec_3xi32_0 : vector<3xi32>, vector<3xi32>
      %21 = spirv.BitwiseOr %5, %20 : vector<3xi32>
      %22 = spirv.ShiftLeftLogical %19, %cst_vec_3xi32_0 : vector<3xi32>, vector<3xi32>
      %23 = spirv.BitwiseOr %18, %22 : vector<3xi32>
      %24 = spirv.CompositeConstruct %21, %23 : (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>
      spirv.ReturnValue %24 : !spirv.struct<(vector<3xi32>, vector<3xi32>)>
    }
    spirv.func @umul_extended_i16(%arg0: i16) -> !spirv.struct<(i16, i16)> "None" {
      %0 = spirv.UMulExtended %arg0, %arg0 : !spirv.struct<(i16, i16)>
      spirv.ReturnValue %0 : !spirv.struct<(i16, i16)>
    }
    spirv.func @smul_extended_i32(%arg0: i32, %arg1: i32) -> !spirv.struct<(i32, i32)> "None" {
      %cst65535_i32 = spirv.Constant 65535 : i32
      %cst16_i32 = spirv.Constant 16 : i32
      %0 = spirv.BitwiseAnd %arg0, %cst65535_i32 : i32
      %1 = spirv.ShiftRightLogical %arg0, %cst16_i32 : i32, i32
      %2 = spirv.ShiftRightArithmetic %arg0, %cst16_i32 : i32, i32
      %3 = spirv.ShiftRightLogical %2, %cst16_i32 : i32, i32
      %4 = spirv.BitwiseAnd %arg1, %cst65535_i32 : i32
      %5 = spirv.ShiftRightLogical %arg1, %cst16_i32 : i32, i32
      %6 = spirv.ShiftRightArithmetic %arg1, %cst16_i32 : i32, i32
      %7 = spirv.ShiftRightLogical %6, %cst16_i32 : i32, i32
      %8 = spirv.IMul %0, %4 : i32
      %9 = spirv.BitwiseAnd %8, %cst65535_i32 : i32
      %10 = spirv.ShiftRightLogical %8, %cst16_i32 : i32, i32
      %11 = spirv.IMul %0, %5 : i32
      %12 = spirv.IAdd %10, %11 : i32
      %13 = spirv.BitwiseAnd %12, %cst65535_i32 : i32
      %14 = spirv.ShiftRightLogical %12, %cst16_i32 : i32, i32
      %15 = spirv.IMul %0, %7 : i32
      %16 = spirv.IAdd %14, %15 : i32
      %17 = spirv.BitwiseAnd %16, %cst65535_i32 : i32
      %18 = spirv.ShiftRightLogical %16, %cst16_i32 : i32, i32
      %19 = spirv.IAdd %18, %15 : i32
      %20 = spirv.BitwiseAnd %19, %cst65535_i32 : i32
      %21 = spirv.IMul %1, %4 : i32
      %22 = spirv.IAdd %13, %21 : i32
      %23 = spirv.BitwiseAnd %22, %cst65535_i32 : i32
      %24 = spirv.ShiftRightLogical %22, %cst16_i32 : i32, i32
      %25 = spirv.IAdd %17, %24 : i32
      %26 = spirv.IMul %1, %5 : i32
      %27 = spirv.IAdd %25, %26 : i32
      %28 = spirv.BitwiseAnd %27, %cst65535_i32 : i32
      %29 = spirv.ShiftRightLogical %27, %cst16_i32 : i32, i32
      %30 = spirv.IAdd %20, %29 : i32
      %31 = spirv.IMul %1, %7 : i32
      %32 = spirv.IAdd %30, %31 : i32
      %33 = spirv.BitwiseAnd %32, %cst65535_i32 : i32
      %34 = spirv.IMul %3, %4 : i32
      %35 = spirv.IAdd %28, %34 : i32
      %36 = spirv.BitwiseAnd %35, %cst65535_i32 : i32
      %37 = spirv.ShiftRightLogical %35, %cst16_i32 : i32, i32
      %38 = spirv.IAdd %33, %37 : i32
      %39 = spirv.IMul %3, %5 : i32
      %40 = spirv.IAdd %38, %39 : i32
      %41 = spirv.BitwiseAnd %40, %cst65535_i32 : i32
      %42 = spirv.IAdd %41, %34 : i32
      %43 = spirv.BitwiseAnd %42, %cst65535_i32 : i32
      %44 = spirv.ShiftLeftLogical %23, %cst16_i32 : i32, i32
      %45 = spirv.BitwiseOr %9, %44 : i32
      %46 = spirv.ShiftLeftLogical %43, %cst16_i32 : i32, i32
      %47 = spirv.BitwiseOr %36, %46 : i32
      %48 = spirv.CompositeConstruct %45, %47 : (i32, i32) -> !spirv.struct<(i32, i32)>
      spirv.ReturnValue %48 : !spirv.struct<(i32, i32)>
    }
    spirv.func @smul_extended_vector_i32(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)> "None" {
      %cst_vec_3xi32 = spirv.Constant dense<65535> : vector<3xi32>
      %cst_vec_3xi32_0 = spirv.Constant dense<16> : vector<3xi32>
      %0 = spirv.BitwiseAnd %arg0, %cst_vec_3xi32 : vector<3xi32>
      %1 = spirv.ShiftRightLogical %arg0, %cst_vec_3xi32_0 : vector<3xi32>, vector<3xi32>
      %2 = spirv.ShiftRightArithmetic %arg0, %cst_vec_3xi32_0 : vector<3xi32>, vector<3xi32>
      %3 = spirv.ShiftRightLogical %2, %cst_vec_3xi32_0 : vector<3xi32>, vector<3xi32>
      %4 = spirv.BitwiseAnd %arg1, %cst_vec_3xi32 : vector<3xi32>
      %5 = spirv.ShiftRightLogical %arg1, %cst_vec_3xi32_0 : vector<3xi32>, vector<3xi32>
      %6 = spirv.ShiftRightArithmetic %arg1, %cst_vec_3xi32_0 : vector<3xi32>, vector<3xi32>
      %7 = spirv.ShiftRightLogical %6, %cst_vec_3xi32_0 : vector<3xi32>, vector<3xi32>
      %8 = spirv.IMul %0, %4 : vector<3xi32>
      %9 = spirv.BitwiseAnd %8, %cst_vec_3xi32 : vector<3xi32>
      %10 = spirv.ShiftRightLogical %8, %cst_vec_3xi32_0 : vector<3xi32>, vector<3xi32>
      %11 = spirv.IMul %0, %5 : vector<3xi32>
      %12 = spirv.IAdd %10, %11 : vector<3xi32>
      %13 = spirv.BitwiseAnd %12, %cst_vec_3xi32 : vector<3xi32>
      %14 = spirv.ShiftRightLogical %12, %cst_vec_3xi32_0 : vector<3xi32>, vector<3xi32>
      %15 = spirv.IMul %0, %7 : vector<3xi32>
      %16 = spirv.IAdd %14, %15 : vector<3xi32>
      %17 = spirv.BitwiseAnd %16, %cst_vec_3xi32 : vector<3xi32>
      %18 = spirv.ShiftRightLogical %16, %cst_vec_3xi32_0 : vector<3xi32>, vector<3xi32>
      %19 = spirv.IAdd %18, %15 : vector<3xi32>
      %20 = spirv.BitwiseAnd %19, %cst_vec_3xi32 : vector<3xi32>
      %21 = spirv.IMul %1, %4 : vector<3xi32>
      %22 = spirv.IAdd %13, %21 : vector<3xi32>
      %23 = spirv.BitwiseAnd %22, %cst_vec_3xi32 : vector<3xi32>
      %24 = spirv.ShiftRightLogical %22, %cst_vec_3xi32_0 : vector<3xi32>, vector<3xi32>
      %25 = spirv.IAdd %17, %24 : vector<3xi32>
      %26 = spirv.IMul %1, %5 : vector<3xi32>
      %27 = spirv.IAdd %25, %26 : vector<3xi32>
      %28 = spirv.BitwiseAnd %27, %cst_vec_3xi32 : vector<3xi32>
      %29 = spirv.ShiftRightLogical %27, %cst_vec_3xi32_0 : vector<3xi32>, vector<3xi32>
      %30 = spirv.IAdd %20, %29 : vector<3xi32>
      %31 = spirv.IMul %1, %7 : vector<3xi32>
      %32 = spirv.IAdd %30, %31 : vector<3xi32>
      %33 = spirv.BitwiseAnd %32, %cst_vec_3xi32 : vector<3xi32>
      %34 = spirv.IMul %3, %4 : vector<3xi32>
      %35 = spirv.IAdd %28, %34 : vector<3xi32>
      %36 = spirv.BitwiseAnd %35, %cst_vec_3xi32 : vector<3xi32>
      %37 = spirv.ShiftRightLogical %35, %cst_vec_3xi32_0 : vector<3xi32>, vector<3xi32>
      %38 = spirv.IAdd %33, %37 : vector<3xi32>
      %39 = spirv.IMul %3, %5 : vector<3xi32>
      %40 = spirv.IAdd %38, %39 : vector<3xi32>
      %41 = spirv.BitwiseAnd %40, %cst_vec_3xi32 : vector<3xi32>
      %42 = spirv.IAdd %41, %34 : vector<3xi32>
      %43 = spirv.BitwiseAnd %42, %cst_vec_3xi32 : vector<3xi32>
      %44 = spirv.ShiftLeftLogical %23, %cst_vec_3xi32_0 : vector<3xi32>, vector<3xi32>
      %45 = spirv.BitwiseOr %9, %44 : vector<3xi32>
      %46 = spirv.ShiftLeftLogical %43, %cst_vec_3xi32_0 : vector<3xi32>, vector<3xi32>
      %47 = spirv.BitwiseOr %36, %46 : vector<3xi32>
      %48 = spirv.CompositeConstruct %45, %47 : (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>
      spirv.ReturnValue %48 : !spirv.struct<(vector<3xi32>, vector<3xi32>)>
    }
    spirv.func @smul_extended_i16(%arg0: i16) -> !spirv.struct<(i16, i16)> "None" {
      %0 = spirv.SMulExtended %arg0, %arg0 : !spirv.struct<(i16, i16)>
      spirv.ReturnValue %0 : !spirv.struct<(i16, i16)>
    }
    spirv.func @iaddcarry_i32(%arg0: i32, %arg1: i32) -> !spirv.struct<(i32, i32)> "None" {
      %cst1_i32 = spirv.Constant 1 : i32
      %cst0_i32 = spirv.Constant 0 : i32
      %0 = spirv.IAdd %arg0, %arg1 : i32
      %1 = spirv.ULessThan %0, %arg0 : i32
      %2 = spirv.Select %1, %cst1_i32, %cst0_i32 : i1, i32
      %3 = spirv.CompositeConstruct %0, %2 : (i32, i32) -> !spirv.struct<(i32, i32)>
      spirv.ReturnValue %3 : !spirv.struct<(i32, i32)>
    }
    spirv.func @iaddcarry_vector_i32(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)> "None" {
      %cst_vec_3xi32 = spirv.Constant dense<1> : vector<3xi32>
      %cst_vec_3xi32_0 = spirv.Constant dense<0> : vector<3xi32>
      %0 = spirv.IAdd %arg0, %arg1 : vector<3xi32>
      %1 = spirv.ULessThan %0, %arg0 : vector<3xi32>
      %2 = spirv.Select %1, %cst_vec_3xi32, %cst_vec_3xi32_0 : vector<3xi1>, vector<3xi32>
      %3 = spirv.CompositeConstruct %0, %2 : (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>
      spirv.ReturnValue %3 : !spirv.struct<(vector<3xi32>, vector<3xi32>)>
    }
    spirv.func @iaddcarry_i16(%arg0: i16, %arg1: i16) -> !spirv.struct<(i16, i16)> "None" {
      %0 = spirv.IAddCarry %arg0, %arg1 : !spirv.struct<(i16, i16)>
      spirv.ReturnValue %0 : !spirv.struct<(i16, i16)>
    }
    spirv.func @is_inf_f32(%arg0: f32) -> i1 "None" {
      %false = spirv.Constant false
      spirv.ReturnValue %false : i1
    }
    spirv.func @is_inf_4xf32(%arg0: vector<4xf32>) -> vector<4xi1> "None" {
      %cst_vec_4xi1 = spirv.Constant dense<false> : vector<4xi1>
      spirv.ReturnValue %cst_vec_4xi1 : vector<4xi1>
    }
    spirv.func @is_nan_f32(%arg0: f32) -> i1 "None" {
      %false = spirv.Constant false
      spirv.ReturnValue %false : i1
    }
    spirv.func @is_nan_4xf32(%arg0: vector<4xf32>) -> vector<4xi1> "None" {
      %cst_vec_4xi1 = spirv.Constant dense<false> : vector<4xi1>
      spirv.ReturnValue %cst_vec_4xi1 : vector<4xi1>
    }
  }
}

