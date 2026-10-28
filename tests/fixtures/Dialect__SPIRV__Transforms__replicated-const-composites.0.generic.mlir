"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, ReplicatedCompositesEXT], [SPV_EXT_replicated_composites]>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> vector<3xi32>, sym_name = "splat_vector_of_i32"}> ({
      %35 = "spirv.EXT.ConstantCompositeReplicate"() <{value = 2 : i32}> : () -> vector<3xi32>
      "spirv.ReturnValue"(%35) : (vector<3xi32>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<3 x i32>, sym_name = "splat_array_of_i32"}> ({
      %34 = "spirv.EXT.ConstantCompositeReplicate"() <{value = 1 : i32}> : () -> !spirv.array<3 x i32>
      "spirv.ReturnValue"(%34) : (!spirv.array<3 x i32>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<2 x !spirv.array<3 x i32>>, sym_name = "splat_array_of_splat_array_of_i32"}> ({
      %33 = "spirv.EXT.ConstantCompositeReplicate"() <{value = 3 : i32}> : () -> !spirv.array<2 x !spirv.array<3 x i32>>
      "spirv.ReturnValue"(%33) : (!spirv.array<2 x !spirv.array<3 x i32>>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<2 x !spirv.array<3 x i32>>, sym_name = "splat_array_of_non_splat_array_of_i32"}> ({
      %32 = "spirv.EXT.ConstantCompositeReplicate"() <{value = [1 : i32, 2 : i32, 3 : i32]}> : () -> !spirv.array<2 x !spirv.array<3 x i32>>
      "spirv.ReturnValue"(%32) : (!spirv.array<2 x !spirv.array<3 x i32>>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<2 x vector<2xi32>>, sym_name = "splat_array_of_vectors_of_i32"}> ({
      %31 = "spirv.EXT.ConstantCompositeReplicate"() <{value = dense<[1, 2]> : vector<2xi32>}> : () -> !spirv.array<2 x vector<2xi32>>
      "spirv.ReturnValue"(%31) : (!spirv.array<2 x vector<2xi32>>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<2 x vector<2xi32>>, sym_name = "splat_array_of_splat_vectors_of_i32"}> ({
      %30 = "spirv.EXT.ConstantCompositeReplicate"() <{value = 2 : i32}> : () -> !spirv.array<2 x vector<2xi32>>
      "spirv.ReturnValue"(%30) : (!spirv.array<2 x vector<2xi32>>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<2 x !spirv.array<3 x i32>>, sym_name = "splat_tensor_of_i32"}> ({
      %29 = "spirv.EXT.ConstantCompositeReplicate"() <{value = 3 : i32}> : () -> !spirv.array<2 x !spirv.array<3 x i32>>
      "spirv.ReturnValue"(%29) : (!spirv.array<2 x !spirv.array<3 x i32>>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.arm.tensor<2x3xi32>, sym_name = "splat_arm_tensor_of_i32"}> ({
      %28 = "spirv.EXT.ConstantCompositeReplicate"() <{value = 2 : i32}> : () -> !spirv.arm.tensor<2x3xi32>
      "spirv.ReturnValue"(%28) : (!spirv.arm.tensor<2x3xi32>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<1 x !spirv.array<2 x vector<2xi32>>>, sym_name = "array_of_splat_array_of_non_splat_vectors_of_i32"}> ({
      %27 = "spirv.EXT.ConstantCompositeReplicate"() <{value = dense<[1, 2]> : vector<2xi32>}> : () -> !spirv.array<1 x !spirv.array<2 x vector<2xi32>>>
      "spirv.ReturnValue"(%27) : (!spirv.array<1 x !spirv.array<2 x vector<2xi32>>>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<1 x !spirv.array<2 x vector<1xi32>>>, sym_name = "array_of_one_splat_array_of_vector_of_one_i32"}> ({
      %26 = "spirv.EXT.ConstantCompositeReplicate"() <{value = dense<1> : vector<1xi32>}> : () -> !spirv.array<1 x !spirv.array<2 x vector<1xi32>>>
      "spirv.ReturnValue"(%26) : (!spirv.array<1 x !spirv.array<2 x vector<1xi32>>>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<2 x !spirv.array<1 x vector<1xi32>>>, sym_name = "splat_array_of_array_of_one_vector_of_one_i32"}> ({
      %25 = "spirv.EXT.ConstantCompositeReplicate"() <{value = dense<1> : vector<1xi32>}> : () -> !spirv.array<2 x !spirv.array<1 x vector<1xi32>>>
      "spirv.ReturnValue"(%25) : (!spirv.array<2 x !spirv.array<1 x vector<1xi32>>>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<1 x !spirv.array<1 x vector<2xi32>>>, sym_name = "array_of_one_array_of_one_splat_vector_of_i32"}> ({
      %24 = "spirv.EXT.ConstantCompositeReplicate"() <{value = 1 : i32}> : () -> !spirv.array<1 x !spirv.array<1 x vector<2xi32>>>
      "spirv.ReturnValue"(%24) : (!spirv.array<1 x !spirv.array<1 x vector<2xi32>>>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<2 x !spirv.array<2 x !spirv.array<3 x i32>>>, sym_name = "splat_array_of_splat_array_of_non_splat_array_of_i32"}> ({
      %23 = "spirv.EXT.ConstantCompositeReplicate"() <{value = [1 : i32, 2 : i32, 3 : i32]}> : () -> !spirv.array<2 x !spirv.array<2 x !spirv.array<3 x i32>>>
      "spirv.ReturnValue"(%23) : (!spirv.array<2 x !spirv.array<2 x !spirv.array<3 x i32>>>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> vector<3xf32>, sym_name = "splat_vector_of_f32"}> ({
      %22 = "spirv.EXT.ConstantCompositeReplicate"() <{value = 2.000000e+00 : f32}> : () -> vector<3xf32>
      "spirv.ReturnValue"(%22) : (vector<3xf32>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<3 x f32>, sym_name = "splat_array_of_f32"}> ({
      %21 = "spirv.EXT.ConstantCompositeReplicate"() <{value = 1.000000e+00 : f32}> : () -> !spirv.array<3 x f32>
      "spirv.ReturnValue"(%21) : (!spirv.array<3 x f32>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<2 x !spirv.array<3 x f32>>, sym_name = "splat_array_of_splat_array_of_f32"}> ({
      %20 = "spirv.EXT.ConstantCompositeReplicate"() <{value = 3.000000e+00 : f32}> : () -> !spirv.array<2 x !spirv.array<3 x f32>>
      "spirv.ReturnValue"(%20) : (!spirv.array<2 x !spirv.array<3 x f32>>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<2 x !spirv.array<3 x f32>>, sym_name = "splat_array_of_non_splat_array_of_f32"}> ({
      %19 = "spirv.EXT.ConstantCompositeReplicate"() <{value = [1.000000e+00 : f32, 2.000000e+00 : f32, 3.000000e+00 : f32]}> : () -> !spirv.array<2 x !spirv.array<3 x f32>>
      "spirv.ReturnValue"(%19) : (!spirv.array<2 x !spirv.array<3 x f32>>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<2 x vector<2xf32>>, sym_name = "splat_array_of_vectors_of_f32"}> ({
      %18 = "spirv.EXT.ConstantCompositeReplicate"() <{value = dense<[1.000000e+00, 2.000000e+00]> : vector<2xf32>}> : () -> !spirv.array<2 x vector<2xf32>>
      "spirv.ReturnValue"(%18) : (!spirv.array<2 x vector<2xf32>>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<2 x vector<2xf32>>, sym_name = "splat_array_of_splat_vectors_of_f32"}> ({
      %17 = "spirv.EXT.ConstantCompositeReplicate"() <{value = 2.000000e+00 : f32}> : () -> !spirv.array<2 x vector<2xf32>>
      "spirv.ReturnValue"(%17) : (!spirv.array<2 x vector<2xf32>>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<2 x !spirv.array<3 x f32>>, sym_name = "splat_tensor_of_f32"}> ({
      %16 = "spirv.EXT.ConstantCompositeReplicate"() <{value = 3.000000e+00 : f32}> : () -> !spirv.array<2 x !spirv.array<3 x f32>>
      "spirv.ReturnValue"(%16) : (!spirv.array<2 x !spirv.array<3 x f32>>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.arm.tensor<2x3xf32>, sym_name = "splat_arm_tensor_of_f32"}> ({
      %15 = "spirv.EXT.ConstantCompositeReplicate"() <{value = 2.000000e+00 : f32}> : () -> !spirv.arm.tensor<2x3xf32>
      "spirv.ReturnValue"(%15) : (!spirv.arm.tensor<2x3xf32>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<1 x !spirv.array<2 x vector<2xf32>>>, sym_name = "array_of_splat_array_of_non_splat_vectors_of_f32"}> ({
      %14 = "spirv.EXT.ConstantCompositeReplicate"() <{value = dense<[1.000000e+00, 2.000000e+00]> : vector<2xf32>}> : () -> !spirv.array<1 x !spirv.array<2 x vector<2xf32>>>
      "spirv.ReturnValue"(%14) : (!spirv.array<1 x !spirv.array<2 x vector<2xf32>>>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<1 x !spirv.array<2 x vector<1xf32>>>, sym_name = "array_of_one_splat_array_of_vector_of_one_f32"}> ({
      %13 = "spirv.EXT.ConstantCompositeReplicate"() <{value = dense<1.000000e+00> : vector<1xf32>}> : () -> !spirv.array<1 x !spirv.array<2 x vector<1xf32>>>
      "spirv.ReturnValue"(%13) : (!spirv.array<1 x !spirv.array<2 x vector<1xf32>>>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<2 x !spirv.array<1 x vector<1xf32>>>, sym_name = "splat_array_of_array_of_one_vector_of_one_f32"}> ({
      %12 = "spirv.EXT.ConstantCompositeReplicate"() <{value = dense<1.000000e+00> : vector<1xf32>}> : () -> !spirv.array<2 x !spirv.array<1 x vector<1xf32>>>
      "spirv.ReturnValue"(%12) : (!spirv.array<2 x !spirv.array<1 x vector<1xf32>>>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<1 x !spirv.array<1 x vector<2xf32>>>, sym_name = "array_of_one_array_of_one_splat_vector_of_f32"}> ({
      %11 = "spirv.EXT.ConstantCompositeReplicate"() <{value = 1.000000e+00 : f32}> : () -> !spirv.array<1 x !spirv.array<1 x vector<2xf32>>>
      "spirv.ReturnValue"(%11) : (!spirv.array<1 x !spirv.array<1 x vector<2xf32>>>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<2 x !spirv.array<2 x !spirv.array<3 x f32>>>, sym_name = "splat_array_of_splat_array_of_non_splat_array_of_f32"}> ({
      %10 = "spirv.EXT.ConstantCompositeReplicate"() <{value = [1.000000e+00 : f32, 2.000000e+00 : f32, 3.000000e+00 : f32]}> : () -> !spirv.array<2 x !spirv.array<2 x !spirv.array<3 x f32>>>
      "spirv.ReturnValue"(%10) : (!spirv.array<2 x !spirv.array<2 x !spirv.array<3 x f32>>>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<1 x i32>, sym_name = "array_of_one_i32"}> ({
      %9 = "spirv.Constant"() <{value = [1 : i32]}> : () -> !spirv.array<1 x i32>
      "spirv.ReturnValue"(%9) : (!spirv.array<1 x i32>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.arm.tensor<1xi32>, sym_name = "arm_tensor_of_one_i32"}> ({
      %8 = "spirv.Constant"() <{value = dense<1> : !spirv.arm.tensor<1xi32>}> : () -> !spirv.arm.tensor<1xi32>
      "spirv.ReturnValue"(%8) : (!spirv.arm.tensor<1xi32>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> vector<3xi32>, sym_name = "non_splat_vector_of_i32"}> ({
      %7 = "spirv.Constant"() <{value = dense<[0, 1, 2]> : vector<3xi32>}> : () -> vector<3xi32>
      "spirv.ReturnValue"(%7) : (vector<3xi32>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<2 x vector<2xi32>>, sym_name = "non_splat_array_of_vectors_of_i32"}> ({
      %6 = "spirv.Constant"() <{value = [dense<[1, 2]> : vector<2xi32>, dense<[1, 3]> : vector<2xi32>]}> : () -> !spirv.array<2 x vector<2xi32>>
      "spirv.ReturnValue"(%6) : (!spirv.array<2 x vector<2xi32>>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<1 x f32>, sym_name = "array_of_one_f32"}> ({
      %5 = "spirv.Constant"() <{value = [1.000000e+00 : f32]}> : () -> !spirv.array<1 x f32>
      "spirv.ReturnValue"(%5) : (!spirv.array<1 x f32>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.arm.tensor<1xf32>, sym_name = "arm_tensor_of_one_f32"}> ({
      %4 = "spirv.Constant"() <{value = dense<1.000000e+00> : !spirv.arm.tensor<1xf32>}> : () -> !spirv.arm.tensor<1xf32>
      "spirv.ReturnValue"(%4) : (!spirv.arm.tensor<1xf32>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> vector<3xf32>, sym_name = "non_splat_vector_of_f32"}> ({
      %3 = "spirv.Constant"() <{value = dense<[0.000000e+00, 1.000000e+00, 2.000000e+00]> : vector<3xf32>}> : () -> vector<3xf32>
      "spirv.ReturnValue"(%3) : (vector<3xf32>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<2 x vector<2xf32>>, sym_name = "non_splat_array_of_vectors_of_f32"}> ({
      %2 = "spirv.Constant"() <{value = [dense<[1.000000e+00, 2.000000e+00]> : vector<2xf32>, dense<[1.000000e+00, 3.000000e+00]> : vector<2xf32>]}> : () -> !spirv.array<2 x vector<2xf32>>
      "spirv.ReturnValue"(%2) : (!spirv.array<2 x vector<2xf32>>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<1 x !spirv.array<1 x vector<2xi32>>>, sym_name = "array_of_one_array_of_one_non_splat_vector_of_i32"}> ({
      %1 = "spirv.Constant"() <{value = [[dense<[1, 2]> : vector<2xi32>]]}> : () -> !spirv.array<1 x !spirv.array<1 x vector<2xi32>>>
      "spirv.ReturnValue"(%1) : (!spirv.array<1 x !spirv.array<1 x vector<2xi32>>>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> !spirv.array<1 x !spirv.array<1 x vector<1xi32>>>, sym_name = "array_of_one_array_of_one_vector_of_one_i32"}> ({
      %0 = "spirv.Constant"() <{value = [[dense<1> : vector<1xi32>]]}> : () -> !spirv.array<1 x !spirv.array<1 x vector<1xi32>>>
      "spirv.ReturnValue"(%0) : (!spirv.array<1 x !spirv.array<1 x vector<1xi32>>>) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, ReplicatedCompositesEXT], [SPV_EXT_replicated_composites]>}> ({
    "spirv.SpecConstant"() <{default_value = 1 : i32, sym_name = "sc_i32_1"}> : () -> ()
    "spirv.EXT.SpecConstantCompositeReplicate"() <{constituent = @sc_i32_1, sym_name = "scc_splat_array_of_i32", type = !spirv.array<3 x i32>}> : () -> ()
    "spirv.EXT.SpecConstantCompositeReplicate"() <{constituent = @sc_i32_1, sym_name = "scc_splat_struct_of_i32", type = !spirv.struct<(i32, i32, i32)>}> : () -> ()
    "spirv.EXT.SpecConstantCompositeReplicate"() <{constituent = @sc_i32_1, sym_name = "scc_splat_vector_of_i32", type = vector<3xi32>}> : () -> ()
    "spirv.EXT.SpecConstantCompositeReplicate"() <{constituent = @sc_i32_1, sym_name = "scc_splat_arm_tensor_of_i32", type = !spirv.arm.tensor<3xi32>}> : () -> ()
    "spirv.SpecConstant"() <{default_value = 1.000000e+00 : f32, sym_name = "sc_f32_1"}> : () -> ()
    "spirv.EXT.SpecConstantCompositeReplicate"() <{constituent = @sc_f32_1, sym_name = "scc_splat_array_of_f32", type = !spirv.array<3 x f32>}> : () -> ()
    "spirv.EXT.SpecConstantCompositeReplicate"() <{constituent = @sc_f32_1, sym_name = "scc_splat_struct_of_f32", type = !spirv.struct<(f32, f32, f32)>}> : () -> ()
    "spirv.EXT.SpecConstantCompositeReplicate"() <{constituent = @sc_f32_1, sym_name = "scc_splat_vector_of_f32", type = vector<3xf32>}> : () -> ()
    "spirv.EXT.SpecConstantCompositeReplicate"() <{constituent = @sc_f32_1, sym_name = "scc_splat_arm_tensor_of_f32", type = !spirv.arm.tensor<3xf32>}> : () -> ()
    "spirv.SpecConstant"() <{default_value = 2 : i32, sym_name = "sc_i32_2"}> : () -> ()
    "spirv.SpecConstantComposite"() <{constituents = [@sc_i32_1], sym_name = "scc_array_of_one_i32", type = !spirv.array<1 x i32>}> : () -> ()
    "spirv.SpecConstantComposite"() <{constituents = [@sc_i32_1], sym_name = "scc_arm_tensor_of_one_i32", type = !spirv.arm.tensor<1xi32>}> : () -> ()
    "spirv.SpecConstantComposite"() <{constituents = [@sc_i32_1, @sc_i32_1, @sc_i32_2], sym_name = "scc_non_splat_vector_of_i32", type = vector<3xi32>}> : () -> ()
    "spirv.SpecConstantComposite"() <{constituents = [@sc_i32_2, @sc_i32_1, @sc_i32_1], sym_name = "scc_non_splat_arm_tensor_of_i32", type = !spirv.arm.tensor<3xi32>}> : () -> ()
    "spirv.SpecConstant"() <{default_value = 2.000000e+00 : f32, sym_name = "sc_f32_2"}> : () -> ()
    "spirv.SpecConstantComposite"() <{constituents = [@sc_f32_1], sym_name = "scc_array_of_one_f32", type = !spirv.array<1 x f32>}> : () -> ()
    "spirv.SpecConstantComposite"() <{constituents = [@sc_f32_1], sym_name = "scc_arm_tensor_of_one_f32", type = !spirv.arm.tensor<1xf32>}> : () -> ()
    "spirv.SpecConstantComposite"() <{constituents = [@sc_f32_1, @sc_f32_1, @sc_f32_2], sym_name = "scc_non_splat_vector_of_f32", type = vector<3xf32>}> : () -> ()
    "spirv.SpecConstantComposite"() <{constituents = [@sc_f32_2, @sc_f32_1, @sc_f32_1], sym_name = "scc_non_splat_arm_tensor_of_f32", type = !spirv.arm.tensor<3xf32>}> : () -> ()
    "spirv.SpecConstantComposite"() <{constituents = [@sc_i32_1, @sc_i32_1, @sc_f32_1], sym_name = "scc_struct_of_i32_and_f32", type = !spirv.struct<(i32, i32, f32)>}> : () -> ()
  }) : () -> ()
}) : () -> ()

