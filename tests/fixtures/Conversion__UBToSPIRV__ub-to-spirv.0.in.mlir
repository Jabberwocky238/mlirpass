"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "check_poison"}> ({
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> index
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> i16
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> f64
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64, Shader], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (), sym_name = "check_unrechable"}> ({
  ^bb0(%arg0: i1):
    "cf.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "ub.unreachable"() : () -> ()
  ^bb2:  // pred: ^bb0
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64, Shader], []>, #spirv.resource_limits<>>} : () -> ()

