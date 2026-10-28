"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.4, [Shader, Linkage, BFloat16TypeKHR], [SPV_KHR_bfloat16]>}> ({
  "spirv.SpecConstant"() <{default_value = true, sym_name = "condition_scalar"}> : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "select_bf16"}> ({
    %0 = "spirv.Constant"() <{value = 4.000000e+00 : bf16}> : () -> bf16
    %1 = "spirv.Constant"() <{value = 5.000000e+00 : bf16}> : () -> bf16
    %2 = "spirv.mlir.referenceof"() <{spec_const = @condition_scalar}> : () -> i1
    %3 = "spirv.Select"(%2, %0, %1) : (i1, bf16, bf16) -> bf16
    %4 = "spirv.Constant"() <{value = dense<[2.000000e+00, 3.000000e+00, 4.000000e+00, 5.000000e+00]> : vector<4xbf16>}> : () -> vector<4xbf16>
    %5 = "spirv.Constant"() <{value = dense<[6.000000e+00, 7.000000e+00, 8.000000e+00, 9.000000e+00]> : vector<4xbf16>}> : () -> vector<4xbf16>
    %6 = "spirv.Select"(%2, %4, %5) : (i1, vector<4xbf16>, vector<4xbf16>) -> vector<4xbf16>
    %7 = "spirv.Constant"() <{value = dense<true> : vector<4xi1>}> : () -> vector<4xi1>
    %8 = "spirv.Select"(%7, %4, %5) : (vector<4xi1>, vector<4xbf16>, vector<4xbf16>) -> vector<4xbf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

