"builtin.module"() ({
  "func.func"() <{function_type = (f32, vector<4xf32>) -> (), sym_name = "fpclassify"}> ({
  ^bb0(%arg2: f32, %arg3: vector<4xf32>):
    %2 = "spirv.IsFinite"(%arg2) : (f32) -> i1
    %3 = "spirv.IsFinite"(%arg3) : (vector<4xf32>) -> vector<4xi1>
    %4 = "spirv.IsNan"(%arg2) : (f32) -> i1
    %5 = "spirv.IsNan"(%arg3) : (vector<4xf32>) -> vector<4xi1>
    %6 = "spirv.IsInf"(%arg2) : (f32) -> i1
    %7 = "spirv.IsInf"(%arg3) : (vector<4xf32>) -> vector<4xi1>
    %8 = "spirv.IsNormal"(%arg2) : (f32) -> i1
    %9 = "spirv.IsNormal"(%arg3) : (vector<4xf32>) -> vector<4xi1>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, vector<4xi32>) -> (), sym_name = "ctpop"}> ({
  ^bb0(%arg0: i32, %arg1: vector<4xi32>):
    %0 = "spirv.BitCount"(%arg0) : (i32) -> i32
    %1 = "spirv.BitCount"(%arg1) : (vector<4xi32>) -> vector<4xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], []>, #spirv.resource_limits<>>} : () -> ()

