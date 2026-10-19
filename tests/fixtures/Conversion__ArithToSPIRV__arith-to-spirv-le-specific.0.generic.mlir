"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "constant_dense_resource"}> ({
    %0 = "spirv.Constant"() <{value = dense<[0.203224242, -0.254296064, -0.365104556, -0.469196141, 0.466041982]> : tensor<5xf32>}> : () -> !spirv.array<5 x f32>
    %1 = "spirv.Constant"() <{value = dense<[1, 2]> : vector<2xi32>}> : () -> vector<2xi32>
    %2 = "spirv.Constant"() <{value = dense<[0.35476172, 0.351080596, -0.0795008316, 0.366843373]> : tensor<4xf32>}> : () -> !spirv.array<4 x f32>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64], []>, #spirv.resource_limits<>>} : () -> ()

