"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "non_uniform_iadd"}> ({
  ^bb0(%arg17: i32):
    %21 = "spirv.GroupNonUniformIAdd"(%arg17) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
    "spirv.ReturnValue"(%21) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> f32, sym_name = "non_uniform_fadd"}> ({
  ^bb0(%arg16: f32):
    %19 = "spirv.Constant"() <{value = 16 : i32}> : () -> i32
    %20 = "spirv.GroupNonUniformFAdd"(%arg16, %19) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<ClusteredReduce>}> : (f32, i32) -> f32
    "spirv.ReturnValue"(%20) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "non_uniform_imul"}> ({
  ^bb0(%arg15: i32):
    %17 = "spirv.Constant"() <{value = 16 : i32}> : () -> i32
    %18 = "spirv.GroupNonUniformIMul"(%arg15, %17) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<ClusteredReduce>}> : (i32, i32) -> i32
    "spirv.ReturnValue"(%18) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> f32, sym_name = "non_uniform_fmul"}> ({
  ^bb0(%arg14: f32):
    %16 = "spirv.GroupNonUniformFMul"(%arg14) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
    "spirv.ReturnValue"(%16) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "non_uniform_smin"}> ({
  ^bb0(%arg13: i32):
    %15 = "spirv.GroupNonUniformSMin"(%arg13) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
    "spirv.ReturnValue"(%15) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "non_uniform_umin"}> ({
  ^bb0(%arg12: i32):
    %14 = "spirv.GroupNonUniformUMin"(%arg12) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
    "spirv.ReturnValue"(%14) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> f32, sym_name = "non_uniform_fmin"}> ({
  ^bb0(%arg11: f32):
    %13 = "spirv.GroupNonUniformFMin"(%arg11) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
    "spirv.ReturnValue"(%13) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> f32, sym_name = "non_uniform_fmin_cluster"}> ({
  ^bb0(%arg10: f32):
    %11 = "spirv.Constant"() <{value = 16 : i32}> : () -> i32
    %12 = "spirv.GroupNonUniformFMin"(%arg10, %11) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<ClusteredReduce>}> : (f32, i32) -> f32
    "spirv.ReturnValue"(%12) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "non_uniform_smax"}> ({
  ^bb0(%arg9: i32):
    %10 = "spirv.GroupNonUniformSMax"(%arg9) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
    "spirv.ReturnValue"(%10) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "non_uniform_umax"}> ({
  ^bb0(%arg8: i32):
    %9 = "spirv.GroupNonUniformUMax"(%arg8) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
    "spirv.ReturnValue"(%9) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> f32, sym_name = "non_uniform_fmax"}> ({
  ^bb0(%arg7: f32):
    %8 = "spirv.GroupNonUniformFMax"(%arg7) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
    "spirv.ReturnValue"(%8) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "non_uniform_smax_cluster"}> ({
  ^bb0(%arg6: i32):
    %6 = "spirv.Constant"() <{value = 16 : i32}> : () -> i32
    %7 = "spirv.GroupNonUniformSMax"(%arg6, %6) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<ClusteredReduce>}> : (i32, i32) -> i32
    "spirv.ReturnValue"(%7) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "non_uniform_bitwise_and"}> ({
  ^bb0(%arg5: i32):
    %5 = "spirv.GroupNonUniformBitwiseAnd"(%arg5) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
    "spirv.ReturnValue"(%5) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "non_uniform_bitwise_or"}> ({
  ^bb0(%arg4: i32):
    %4 = "spirv.GroupNonUniformBitwiseOr"(%arg4) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
    "spirv.ReturnValue"(%4) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "non_uniform_bitwise_xor"}> ({
  ^bb0(%arg3: i32):
    %3 = "spirv.GroupNonUniformBitwiseXor"(%arg3) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
    "spirv.ReturnValue"(%3) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1) -> i1, sym_name = "non_uniform_logical_and"}> ({
  ^bb0(%arg2: i1):
    %2 = "spirv.GroupNonUniformLogicalAnd"(%arg2) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i1) -> i1
    "spirv.ReturnValue"(%2) : (i1) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1) -> i1, sym_name = "non_uniform_logical_or"}> ({
  ^bb0(%arg1: i1):
    %1 = "spirv.GroupNonUniformLogicalOr"(%arg1) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i1) -> i1
    "spirv.ReturnValue"(%1) : (i1) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1) -> i1, sym_name = "non_uniform_logical_xor"}> ({
  ^bb0(%arg0: i1):
    %0 = "spirv.GroupNonUniformLogicalXor"(%arg0) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i1) -> i1
    "spirv.ReturnValue"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

