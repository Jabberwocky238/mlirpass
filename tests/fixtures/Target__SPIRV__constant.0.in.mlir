"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int64, Int16, Int8, Float64, Float16, CooperativeMatrixKHR, TensorsARM, Linkage], [SPV_KHR_vulkan_memory_model, SPV_KHR_cooperative_matrix, SPV_ARM_tensors]>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "bool_const"}> ({
    %85 = "spirv.Constant"() <{value = true}> : () -> i1
    %86 = "spirv.Constant"() <{value = false}> : () -> i1
    %87 = "spirv.Variable"(%85) <{storage_class = #spirv.storage_class<Function>}> : (i1) -> !spirv.ptr<i1, Function>
    %88 = "spirv.Variable"(%86) <{storage_class = #spirv.storage_class<Function>}> : (i1) -> !spirv.ptr<i1, Function>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "i32_const"}> ({
    %80 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %81 = "spirv.Constant"() <{value = 10 : i32}> : () -> i32
    %82 = "spirv.Constant"() <{value = -5 : i32}> : () -> i32
    %83 = "spirv.IAdd"(%80, %81) : (i32, i32) -> i32
    %84 = "spirv.IAdd"(%82, %83) : (i32, i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "si32_const"}> ({
    %75 = "spirv.Constant"() <{value = 0 : si32}> : () -> si32
    %76 = "spirv.Constant"() <{value = 10 : si32}> : () -> si32
    %77 = "spirv.Constant"() <{value = -5 : si32}> : () -> si32
    %78 = "spirv.IAdd"(%75, %76) : (si32, si32) -> si32
    %79 = "spirv.IAdd"(%77, %78) : (si32, si32) -> si32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "ui32_const"}> ({
    %70 = "spirv.Constant"() <{value = 0 : ui32}> : () -> ui32
    %71 = "spirv.Constant"() <{value = 10 : ui32}> : () -> ui32
    %72 = "spirv.Constant"() <{value = 4294967291 : ui32}> : () -> ui32
    %73 = "spirv.IAdd"(%70, %71) : (ui32, ui32) -> ui32
    %74 = "spirv.IAdd"(%72, %73) : (ui32, ui32) -> ui32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "i64_const"}> ({
    %64 = "spirv.Constant"() <{value = 4294967296 : i64}> : () -> i64
    %65 = "spirv.Constant"() <{value = -4294967296 : i64}> : () -> i64
    %66 = "spirv.Constant"() <{value = 9223372036854775807 : i64}> : () -> i64
    %67 = "spirv.Constant"() <{value = -9223372036854775808 : i64}> : () -> i64
    %68 = "spirv.IAdd"(%64, %65) : (i64, i64) -> i64
    %69 = "spirv.IAdd"(%66, %67) : (i64, i64) -> i64
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "i16_const"}> ({
    %61 = "spirv.Constant"() <{value = -32768 : i16}> : () -> i16
    %62 = "spirv.Constant"() <{value = 32767 : i16}> : () -> i16
    %63 = "spirv.IAdd"(%61, %62) : (i16, i16) -> i16
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "i8_const"}> ({
    %50 = "spirv.Constant"() <{value = 0 : i8}> : () -> i8
    %51 = "spirv.Constant"() <{value = -1 : i8}> : () -> i8
    %52 = "spirv.Constant"() <{value = 0 : si8}> : () -> si8
    %53 = "spirv.Constant"() <{value = 127 : si8}> : () -> si8
    %54 = "spirv.Constant"() <{value = -128 : si8}> : () -> si8
    %55 = "spirv.Constant"() <{value = 0 : ui8}> : () -> ui8
    %56 = "spirv.Constant"() <{value = 255 : ui8}> : () -> ui8
    %57 = "spirv.IAdd"(%50, %51) : (i8, i8) -> i8
    %58 = "spirv.IAdd"(%52, %53) : (si8, si8) -> si8
    %59 = "spirv.IAdd"(%53, %54) : (si8, si8) -> si8
    %60 = "spirv.IAdd"(%55, %56) : (ui8, ui8) -> ui8
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "float_const"}> ({
    %41 = "spirv.Constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %42 = "spirv.Constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %43 = "spirv.Constant"() <{value = -0.000000e+00 : f32}> : () -> f32
    %44 = "spirv.Constant"() <{value = -1.000000e+00 : f32}> : () -> f32
    %45 = "spirv.Constant"() <{value = 7.500000e-01 : f32}> : () -> f32
    %46 = "spirv.Constant"() <{value = -2.500000e-01 : f32}> : () -> f32
    %47 = "spirv.FAdd"(%41, %42) : (f32, f32) -> f32
    %48 = "spirv.FAdd"(%43, %44) : (f32, f32) -> f32
    %49 = "spirv.FAdd"(%45, %46) : (f32, f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "double_const"}> ({
    %38 = "spirv.Constant"() <{value = 1.024000e+03 : f64}> : () -> f64
    %39 = "spirv.Constant"() <{value = -1.024000e+03 : f64}> : () -> f64
    %40 = "spirv.FAdd"(%38, %39) : (f64, f64) -> f64
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "half_const"}> ({
    %35 = "spirv.Constant"() <{value = 5.120000e+02 : f16}> : () -> f16
    %36 = "spirv.Constant"() <{value = -5.120000e+02 : f16}> : () -> f16
    %37 = "spirv.FAdd"(%35, %36) : (f16, f16) -> f16
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "bool_vector_const"}> ({
    %29 = "spirv.Constant"() <{value = dense<false> : vector<2xi1>}> : () -> vector<2xi1>
    %30 = "spirv.Constant"() <{value = dense<true> : vector<3xi1>}> : () -> vector<3xi1>
    %31 = "spirv.Constant"() <{value = dense<[false, true]> : vector<2xi1>}> : () -> vector<2xi1>
    %32 = "spirv.Variable"(%29) <{storage_class = #spirv.storage_class<Function>}> : (vector<2xi1>) -> !spirv.ptr<vector<2xi1>, Function>
    %33 = "spirv.Variable"(%30) <{storage_class = #spirv.storage_class<Function>}> : (vector<3xi1>) -> !spirv.ptr<vector<3xi1>, Function>
    %34 = "spirv.Variable"(%31) <{storage_class = #spirv.storage_class<Function>}> : (vector<2xi1>) -> !spirv.ptr<vector<2xi1>, Function>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "int_vector_const"}> ({
    %24 = "spirv.Constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
    %25 = "spirv.Constant"() <{value = dense<1> : vector<3xi32>}> : () -> vector<3xi32>
    %26 = "spirv.Constant"() <{value = dense<[2, -3, 4]> : vector<3xi32>}> : () -> vector<3xi32>
    %27 = "spirv.IAdd"(%24, %25) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    %28 = "spirv.IAdd"(%26, %27) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "fp_vector_const"}> ({
    %19 = "spirv.Constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %20 = "spirv.Constant"() <{value = dense<-1.500000e+01> : vector<4xf32>}> : () -> vector<4xf32>
    %21 = "spirv.Constant"() <{value = dense<[7.500000e-01, -2.500000e-01, 1.000000e+01, 4.200000e+01]> : vector<4xf32>}> : () -> vector<4xf32>
    %22 = "spirv.FAdd"(%19, %20) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %23 = "spirv.FAdd"(%21, %22) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<3 x ui64>, sym_name = "ui64_array_const"}> ({
    %18 = "spirv.Constant"() <{value = [5 : ui64, 6 : ui64, 7 : ui64]}> : () -> !spirv.array<3 x ui64>
    "spirv.ReturnValue"(%18) : (!spirv.array<3 x ui64>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<3 x si32>, sym_name = "si32_array_const"}> ({
    %17 = "spirv.Constant"() <{value = [5 : si32, 6 : si32, 7 : si32]}> : () -> !spirv.array<3 x si32>
    "spirv.ReturnValue"(%17) : (!spirv.array<3 x si32>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<2 x vector<2xf32>>, sym_name = "float_array_const"}> ({
    %16 = "spirv.Constant"() <{value = [dense<3.000000e+00> : vector<2xf32>, dense<[4.000000e+00, 5.000000e+00]> : vector<2xf32>]}> : () -> !spirv.array<2 x vector<2xf32>>
    "spirv.ReturnValue"(%16) : (!spirv.array<2 x vector<2xf32>>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "ignore_not_used_const"}> ({
    %15 = "spirv.Constant"() <{value = false}> : () -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> i32, sym_name = "materialize_const_at_each_use"}> ({
    %13 = "spirv.Constant"() <{value = 42 : i32}> : () -> i32
    %14 = "spirv.IAdd"(%13, %13) : (i32, i32) -> i32
    "spirv.ReturnValue"(%14) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> (), sym_name = "const_variable"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %8 = "spirv.IAdd"(%arg0, %arg1) : (i32, i32) -> i32
    %9 = "spirv.Constant"() <{value = 5 : i32}> : () -> i32
    %10 = "spirv.Variable"(%9) <{storage_class = #spirv.storage_class<Function>}> : (i32) -> !spirv.ptr<i32, Function>
    %11 = "spirv.Load"(%10) : (!spirv.ptr<i32, Function>) -> i32
    %12 = "spirv.IAdd"(%8, %11) : (i32, i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<2 x !spirv.array<2 x !spirv.array<3 x i32, stride=4>, stride=12>, stride=24>, sym_name = "multi_dimensions_const"}> ({
    %7 = "spirv.Constant"() <{value = dense<[[[1, 2, 3], [4, 5, 6]], [[7, 8, 9], [10, 11, 12]]]> : tensor<2x2x3xi32>}> : () -> !spirv.array<2 x !spirv.array<2 x !spirv.array<3 x i32, stride=4>, stride=12>, stride=24>
    "spirv.ReturnValue"(%7) : (!spirv.array<2 x !spirv.array<2 x !spirv.array<3 x i32, stride=4>, stride=12>, stride=24>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<2 x !spirv.array<2 x !spirv.array<3 x i32, stride=4>, stride=12>, stride=24>, sym_name = "multi_dimensions_splat_const"}> ({
    %6 = "spirv.Constant"() <{value = dense<1> : tensor<2x2x3xi32>}> : () -> !spirv.array<2 x !spirv.array<2 x !spirv.array<3 x i32, stride=4>, stride=12>, stride=24>
    "spirv.ReturnValue"(%6) : (!spirv.array<2 x !spirv.array<2 x !spirv.array<3 x i32, stride=4>, stride=12>, stride=24>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> i16, sym_name = "signless_int_const_bit_extension"}> ({
    %5 = "spirv.Constant"() <{value = -1 : i16}> : () -> i16
    "spirv.ReturnValue"(%5) : (i16) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> si16, sym_name = "signed_int_const_bit_extension"}> ({
    %4 = "spirv.Constant"() <{value = -1 : si16}> : () -> si16
    "spirv.ReturnValue"(%4) : (si16) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.coopmatrix<16x16xf32, Subgroup, MatrixAcc>, sym_name = "coop_matrix_const_zero_f32"}> ({
    %3 = "spirv.Constant"() <{value = dense<0.000000e+00> : !spirv.coopmatrix<16x16xf32, Subgroup, MatrixAcc>}> : () -> !spirv.coopmatrix<16x16xf32, Subgroup, MatrixAcc>
    "spirv.ReturnValue"(%3) : (!spirv.coopmatrix<16x16xf32, Subgroup, MatrixAcc>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.coopmatrix<16x16xf32, Subgroup, MatrixAcc>, sym_name = "coop_matrix_const_non_zero_f32"}> ({
    %2 = "spirv.Constant"() <{value = dense<4.200000e+00> : !spirv.coopmatrix<16x16xf32, Subgroup, MatrixAcc>}> : () -> !spirv.coopmatrix<16x16xf32, Subgroup, MatrixAcc>
    "spirv.ReturnValue"(%2) : (!spirv.coopmatrix<16x16xf32, Subgroup, MatrixAcc>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.coopmatrix<16x16xi8, Subgroup, MatrixAcc>, sym_name = "coop_matrix_const_zero_i8"}> ({
    %1 = "spirv.Constant"() <{value = dense<0> : !spirv.coopmatrix<16x16xi8, Subgroup, MatrixAcc>}> : () -> !spirv.coopmatrix<16x16xi8, Subgroup, MatrixAcc>
    "spirv.ReturnValue"(%1) : (!spirv.coopmatrix<16x16xi8, Subgroup, MatrixAcc>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.coopmatrix<16x16xi8, Subgroup, MatrixAcc>, sym_name = "coop_matrix_const_non_zero_i8"}> ({
    %0 = "spirv.Constant"() <{value = dense<4> : !spirv.coopmatrix<16x16xi8, Subgroup, MatrixAcc>}> : () -> !spirv.coopmatrix<16x16xi8, Subgroup, MatrixAcc>
    "spirv.ReturnValue"(%0) : (!spirv.coopmatrix<16x16xi8, Subgroup, MatrixAcc>) -> ()
  }) : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<GLCompute>, fn = @bool_const, interface = []}> : () -> ()
}) : () -> ()

