"builtin.module"() ({
  "func.func"() <{function_type = (f32, vector<4xf32>) -> (), sym_name = "fpclassify"}> ({
  ^bb0(%arg2: f32, %arg3: vector<4xf32>):
    %2 = "math.isfinite"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f32) -> i1
    %3 = "math.isfinite"(%arg3) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xi1>
    %4 = "math.isnan"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f32) -> i1
    %5 = "math.isnan"(%arg3) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xi1>
    %6 = "math.isinf"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f32) -> i1
    %7 = "math.isinf"(%arg3) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xi1>
    %8 = "math.isnormal"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f32) -> i1
    %9 = "math.isnormal"(%arg3) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xi1>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, vector<4xi32>) -> (), sym_name = "ctpop"}> ({
  ^bb0(%arg0: i32, %arg1: vector<4xi32>):
    %0 = "math.ctpop"(%arg0) : (i32) -> i32
    %1 = "math.ctpop"(%arg1) : (vector<4xi32>) -> vector<4xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], []>, #spirv.resource_limits<>>} : () -> ()

