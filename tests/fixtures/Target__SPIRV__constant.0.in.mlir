"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int64, Int16, Int8, Float64, Float16, BFloat16TypeKHR, Float8EXT, CooperativeMatrixKHR, Linkage], [SPV_KHR_vulkan_memory_model, SPV_KHR_cooperative_matrix, SPV_KHR_bfloat16, SPV_EXT_float8]>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "bool_const"}> ({
    %99 = "spirv.Constant"() <{value = true}> : () -> i1
    %100 = "spirv.Constant"() <{value = false}> : () -> i1
    %101 = "spirv.Variable"(%99) <{storage_class = #spirv.storage_class<Function>}> : (i1) -> !spirv.ptr<i1, Function>
    %102 = "spirv.Variable"(%100) <{storage_class = #spirv.storage_class<Function>}> : (i1) -> !spirv.ptr<i1, Function>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "i32_const"}> ({
    %94 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %95 = "spirv.Constant"() <{value = 10 : i32}> : () -> i32
    %96 = "spirv.Constant"() <{value = -5 : i32}> : () -> i32
    %97 = "spirv.IAdd"(%94, %95) : (i32, i32) -> i32
    %98 = "spirv.IAdd"(%96, %97) : (i32, i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "si32_const"}> ({
    %89 = "spirv.Constant"() <{value = 0 : si32}> : () -> si32
    %90 = "spirv.Constant"() <{value = 10 : si32}> : () -> si32
    %91 = "spirv.Constant"() <{value = -5 : si32}> : () -> si32
    %92 = "spirv.IAdd"(%89, %90) : (si32, si32) -> si32
    %93 = "spirv.IAdd"(%91, %92) : (si32, si32) -> si32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "ui32_const"}> ({
    %84 = "spirv.Constant"() <{value = 0 : ui32}> : () -> ui32
    %85 = "spirv.Constant"() <{value = 10 : ui32}> : () -> ui32
    %86 = "spirv.Constant"() <{value = 4294967291 : ui32}> : () -> ui32
    %87 = "spirv.IAdd"(%84, %85) : (ui32, ui32) -> ui32
    %88 = "spirv.IAdd"(%86, %87) : (ui32, ui32) -> ui32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "i64_const"}> ({
    %78 = "spirv.Constant"() <{value = 4294967296 : i64}> : () -> i64
    %79 = "spirv.Constant"() <{value = -4294967296 : i64}> : () -> i64
    %80 = "spirv.Constant"() <{value = 9223372036854775807 : i64}> : () -> i64
    %81 = "spirv.Constant"() <{value = -9223372036854775808 : i64}> : () -> i64
    %82 = "spirv.IAdd"(%78, %79) : (i64, i64) -> i64
    %83 = "spirv.IAdd"(%80, %81) : (i64, i64) -> i64
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "i16_const"}> ({
    %75 = "spirv.Constant"() <{value = -32768 : i16}> : () -> i16
    %76 = "spirv.Constant"() <{value = 32767 : i16}> : () -> i16
    %77 = "spirv.IAdd"(%75, %76) : (i16, i16) -> i16
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "i8_const"}> ({
    %64 = "spirv.Constant"() <{value = 0 : i8}> : () -> i8
    %65 = "spirv.Constant"() <{value = -1 : i8}> : () -> i8
    %66 = "spirv.Constant"() <{value = 0 : si8}> : () -> si8
    %67 = "spirv.Constant"() <{value = 127 : si8}> : () -> si8
    %68 = "spirv.Constant"() <{value = -128 : si8}> : () -> si8
    %69 = "spirv.Constant"() <{value = 0 : ui8}> : () -> ui8
    %70 = "spirv.Constant"() <{value = 255 : ui8}> : () -> ui8
    %71 = "spirv.IAdd"(%64, %65) : (i8, i8) -> i8
    %72 = "spirv.IAdd"(%66, %67) : (si8, si8) -> si8
    %73 = "spirv.IAdd"(%67, %68) : (si8, si8) -> si8
    %74 = "spirv.IAdd"(%69, %70) : (ui8, ui8) -> ui8
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "float_const"}> ({
    %55 = "spirv.Constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %56 = "spirv.Constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %57 = "spirv.Constant"() <{value = -0.000000e+00 : f32}> : () -> f32
    %58 = "spirv.Constant"() <{value = -1.000000e+00 : f32}> : () -> f32
    %59 = "spirv.Constant"() <{value = 7.500000e-01 : f32}> : () -> f32
    %60 = "spirv.Constant"() <{value = -2.500000e-01 : f32}> : () -> f32
    %61 = "spirv.FAdd"(%55, %56) : (f32, f32) -> f32
    %62 = "spirv.FAdd"(%57, %58) : (f32, f32) -> f32
    %63 = "spirv.FAdd"(%59, %60) : (f32, f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "double_const"}> ({
    %52 = "spirv.Constant"() <{value = 1.024000e+03 : f64}> : () -> f64
    %53 = "spirv.Constant"() <{value = -1.024000e+03 : f64}> : () -> f64
    %54 = "spirv.FAdd"(%52, %53) : (f64, f64) -> f64
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "half_const"}> ({
    %49 = "spirv.Constant"() <{value = 5.120000e+02 : f16}> : () -> f16
    %50 = "spirv.Constant"() <{value = -5.120000e+02 : f16}> : () -> f16
    %51 = "spirv.FAdd"(%49, %50) : (f16, f16) -> f16
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "bf16"}> ({
    %45 = "spirv.Constant"() <{value = 5.120000e+02 : bf16}> : () -> bf16
    %46 = "spirv.Constant"() <{value = -5.120000e+02 : bf16}> : () -> bf16
    %47 = "spirv.FConvert"(%45) : (bf16) -> f32
    %48 = "spirv.FConvert"(%46) : (bf16) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "f8E4M3FN"}> ({
    %41 = "spirv.Constant"() <{value = 1.280000e+02 : f8E4M3FN}> : () -> f8E4M3FN
    %42 = "spirv.Constant"() <{value = -1.280000e+02 : f8E4M3FN}> : () -> f8E4M3FN
    %43 = "spirv.FConvert"(%41) : (f8E4M3FN) -> f32
    %44 = "spirv.FConvert"(%42) : (f8E4M3FN) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "f8E5M2"}> ({
    %37 = "spirv.Constant"() <{value = 1.280000e+02 : f8E5M2}> : () -> f8E5M2
    %38 = "spirv.Constant"() <{value = -1.280000e+02 : f8E5M2}> : () -> f8E5M2
    %39 = "spirv.FConvert"(%37) : (f8E5M2) -> f32
    %40 = "spirv.FConvert"(%38) : (f8E5M2) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "bool_vector_const"}> ({
    %31 = "spirv.Constant"() <{value = dense<false> : vector<2xi1>}> : () -> vector<2xi1>
    %32 = "spirv.Constant"() <{value = dense<true> : vector<3xi1>}> : () -> vector<3xi1>
    %33 = "spirv.Constant"() <{value = dense<[false, true]> : vector<2xi1>}> : () -> vector<2xi1>
    %34 = "spirv.Variable"(%31) <{storage_class = #spirv.storage_class<Function>}> : (vector<2xi1>) -> !spirv.ptr<vector<2xi1>, Function>
    %35 = "spirv.Variable"(%32) <{storage_class = #spirv.storage_class<Function>}> : (vector<3xi1>) -> !spirv.ptr<vector<3xi1>, Function>
    %36 = "spirv.Variable"(%33) <{storage_class = #spirv.storage_class<Function>}> : (vector<2xi1>) -> !spirv.ptr<vector<2xi1>, Function>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "int_vector_const"}> ({
    %26 = "spirv.Constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
    %27 = "spirv.Constant"() <{value = dense<1> : vector<3xi32>}> : () -> vector<3xi32>
    %28 = "spirv.Constant"() <{value = dense<[2, -3, 4]> : vector<3xi32>}> : () -> vector<3xi32>
    %29 = "spirv.IAdd"(%26, %27) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    %30 = "spirv.IAdd"(%28, %29) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "fp_vector_const"}> ({
    %21 = "spirv.Constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %22 = "spirv.Constant"() <{value = dense<-1.500000e+01> : vector<4xf32>}> : () -> vector<4xf32>
    %23 = "spirv.Constant"() <{value = dense<[7.500000e-01, -2.500000e-01, 1.000000e+01, 4.200000e+01]> : vector<4xf32>}> : () -> vector<4xf32>
    %24 = "spirv.FAdd"(%21, %22) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %25 = "spirv.FAdd"(%23, %24) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<3 x ui64>, sym_name = "ui64_array_const"}> ({
    %20 = "spirv.Constant"() <{value = [5 : ui64, 6 : ui64, 7 : ui64]}> : () -> !spirv.array<3 x ui64>
    "spirv.ReturnValue"(%20) : (!spirv.array<3 x ui64>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<3 x si32>, sym_name = "si32_array_const"}> ({
    %19 = "spirv.Constant"() <{value = [5 : si32, 6 : si32, 7 : si32]}> : () -> !spirv.array<3 x si32>
    "spirv.ReturnValue"(%19) : (!spirv.array<3 x si32>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<2 x vector<2xf32>>, sym_name = "float_array_const"}> ({
    %18 = "spirv.Constant"() <{value = [dense<3.000000e+00> : vector<2xf32>, dense<[4.000000e+00, 5.000000e+00]> : vector<2xf32>]}> : () -> !spirv.array<2 x vector<2xf32>>
    "spirv.ReturnValue"(%18) : (!spirv.array<2 x vector<2xf32>>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "ignore_not_used_const"}> ({
    %17 = "spirv.Constant"() <{value = false}> : () -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> i32, sym_name = "materialize_const_at_each_use"}> ({
    %15 = "spirv.Constant"() <{value = 42 : i32}> : () -> i32
    %16 = "spirv.IAdd"(%15, %15) : (i32, i32) -> i32
    "spirv.ReturnValue"(%16) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> (), sym_name = "const_variable"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %10 = "spirv.IAdd"(%arg0, %arg1) : (i32, i32) -> i32
    %11 = "spirv.Constant"() <{value = 5 : i32}> : () -> i32
    %12 = "spirv.Variable"(%11) <{storage_class = #spirv.storage_class<Function>}> : (i32) -> !spirv.ptr<i32, Function>
    %13 = "spirv.Load"(%12) : (!spirv.ptr<i32, Function>) -> i32
    %14 = "spirv.IAdd"(%10, %13) : (i32, i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<2 x !spirv.array<2 x !spirv.array<3 x i32, stride=4>, stride=12>, stride=24>, sym_name = "multi_dimensions_const"}> ({
    %9 = "spirv.Constant"() <{value = dense<[[[1, 2, 3], [4, 5, 6]], [[7, 8, 9], [10, 11, 12]]]> : tensor<2x2x3xi32>}> : () -> !spirv.array<2 x !spirv.array<2 x !spirv.array<3 x i32, stride=4>, stride=12>, stride=24>
    "spirv.ReturnValue"(%9) : (!spirv.array<2 x !spirv.array<2 x !spirv.array<3 x i32, stride=4>, stride=12>, stride=24>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<2 x !spirv.array<2 x !spirv.array<3 x i32, stride=4>, stride=12>, stride=24>, sym_name = "multi_dimensions_splat_const"}> ({
    %8 = "spirv.Constant"() <{value = dense<1> : tensor<2x2x3xi32>}> : () -> !spirv.array<2 x !spirv.array<2 x !spirv.array<3 x i32, stride=4>, stride=12>, stride=24>
    "spirv.ReturnValue"(%8) : (!spirv.array<2 x !spirv.array<2 x !spirv.array<3 x i32, stride=4>, stride=12>, stride=24>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> i16, sym_name = "signless_int_const_bit_extension"}> ({
    %7 = "spirv.Constant"() <{value = -1 : i16}> : () -> i16
    "spirv.ReturnValue"(%7) : (i16) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> si16, sym_name = "signed_int_const_bit_extension"}> ({
    %6 = "spirv.Constant"() <{value = -1 : si16}> : () -> si16
    "spirv.ReturnValue"(%6) : (si16) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.coopmatrix<16x16xf32, Subgroup, MatrixAcc>, sym_name = "coop_matrix_const_zero_f32"}> ({
    %5 = "spirv.Constant"() <{value = dense<0.000000e+00> : !spirv.coopmatrix<16x16xf32, Subgroup, MatrixAcc>}> : () -> !spirv.coopmatrix<16x16xf32, Subgroup, MatrixAcc>
    "spirv.ReturnValue"(%5) : (!spirv.coopmatrix<16x16xf32, Subgroup, MatrixAcc>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.coopmatrix<16x16xf32, Subgroup, MatrixAcc>, sym_name = "coop_matrix_const_non_zero_f32"}> ({
    %4 = "spirv.Constant"() <{value = dense<4.200000e+00> : !spirv.coopmatrix<16x16xf32, Subgroup, MatrixAcc>}> : () -> !spirv.coopmatrix<16x16xf32, Subgroup, MatrixAcc>
    "spirv.ReturnValue"(%4) : (!spirv.coopmatrix<16x16xf32, Subgroup, MatrixAcc>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.coopmatrix<16x16xi8, Subgroup, MatrixAcc>, sym_name = "coop_matrix_const_zero_i8"}> ({
    %3 = "spirv.Constant"() <{value = dense<0> : !spirv.coopmatrix<16x16xi8, Subgroup, MatrixAcc>}> : () -> !spirv.coopmatrix<16x16xi8, Subgroup, MatrixAcc>
    "spirv.ReturnValue"(%3) : (!spirv.coopmatrix<16x16xi8, Subgroup, MatrixAcc>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.coopmatrix<16x16xi8, Subgroup, MatrixAcc>, sym_name = "coop_matrix_const_non_zero_i8"}> ({
    %2 = "spirv.Constant"() <{value = dense<4> : !spirv.coopmatrix<16x16xi8, Subgroup, MatrixAcc>}> : () -> !spirv.coopmatrix<16x16xi8, Subgroup, MatrixAcc>
    "spirv.ReturnValue"(%2) : (!spirv.coopmatrix<16x16xi8, Subgroup, MatrixAcc>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.struct<(i32, f32)>, sym_name = "struct_const"}> ({
    %1 = "spirv.Constant"() <{value = [1 : i32, 2.000000e+00 : f32]}> : () -> !spirv.struct<(i32, f32)>
    "spirv.ReturnValue"(%1) : (!spirv.struct<(i32, f32)>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.struct<(i32, !spirv.array<2 x i32>)>, sym_name = "struct_const_nested"}> ({
    %0 = "spirv.Constant"() <{value = [1 : i32, [2 : i32, 3 : i32]]}> : () -> !spirv.struct<(i32, !spirv.array<2 x i32>)>
    "spirv.ReturnValue"(%0) : (!spirv.struct<(i32, !spirv.array<2 x i32>)>) -> ()
  }) : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<GLCompute>, fn = @bool_const, interface = []}> : () -> ()
}) : () -> ()

