"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "check_poison"}> ({
    %0 = "spirv.Undef"() : () -> i32
    %1 = "spirv.Undef"() : () -> i16
    %2 = "spirv.Undef"() : () -> f64
    %3 = "spirv.Undef"() : () -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64, Shader], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (), sym_name = "check_unrechable"}> ({
  ^bb0(%arg0: i1):
    "cf.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "spirv.Unreachable"() : () -> ()
  ^bb2:  // pred: ^bb0
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64, Shader], []>, #spirv.resource_limits<>>} : () -> ()

