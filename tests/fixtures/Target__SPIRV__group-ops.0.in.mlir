"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.3, [Shader, Linkage, SubgroupBallotKHR, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], [SPV_KHR_storage_buffer_storage_class, SPV_KHR_shader_ballot, SPV_KHR_uniform_group_instructions]>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1) -> vector<4xi32>, sym_name = "subgroup_ballot"}> ({
  ^bb0(%arg14: i1):
    %12 = "spirv.KHR.SubgroupBallot"(%arg14) : (i1) -> vector<4xi32>
    "spirv.ReturnValue"(%12) : (vector<4xi32>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, i32) -> f32, sym_name = "group_broadcast_1"}> ({
  ^bb0(%arg12: f32, %arg13: i32):
    %11 = "spirv.GroupBroadcast"(%arg12, %arg13) <{execution_scope = #spirv.scope<Workgroup>}> : (f32, i32) -> f32
    "spirv.ReturnValue"(%11) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xi32>) -> f32, sym_name = "group_broadcast_2"}> ({
  ^bb0(%arg10: f32, %arg11: vector<3xi32>):
    %10 = "spirv.GroupBroadcast"(%arg10, %arg11) <{execution_scope = #spirv.scope<Workgroup>}> : (f32, vector<3xi32>) -> f32
    "spirv.ReturnValue"(%10) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_iadd"}> ({
  ^bb0(%arg9: i32):
    %9 = "spirv.GroupIAdd"(%arg9) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
    "spirv.ReturnValue"(%9) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> f32, sym_name = "group_fadd"}> ({
  ^bb0(%arg8: f32):
    %8 = "spirv.GroupFAdd"(%arg8) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
    "spirv.ReturnValue"(%8) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> f32, sym_name = "group_fmin"}> ({
  ^bb0(%arg7: f32):
    %7 = "spirv.GroupFMin"(%arg7) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
    "spirv.ReturnValue"(%7) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_umin"}> ({
  ^bb0(%arg6: i32):
    %6 = "spirv.GroupUMin"(%arg6) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
    "spirv.ReturnValue"(%6) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_smin"}> ({
  ^bb0(%arg5: i32):
    %5 = "spirv.GroupSMin"(%arg5) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
    "spirv.ReturnValue"(%5) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> f32, sym_name = "group_fmax"}> ({
  ^bb0(%arg4: f32):
    %4 = "spirv.GroupFMax"(%arg4) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
    "spirv.ReturnValue"(%4) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_umax"}> ({
  ^bb0(%arg3: i32):
    %3 = "spirv.GroupUMax"(%arg3) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
    "spirv.ReturnValue"(%3) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_smax"}> ({
  ^bb0(%arg2: i32):
    %2 = "spirv.GroupSMax"(%arg2) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
    "spirv.ReturnValue"(%2) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_imul"}> ({
  ^bb0(%arg1: i32):
    %1 = "spirv.KHR.GroupIMul"(%arg1) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
    "spirv.ReturnValue"(%1) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> f32, sym_name = "group_fmul"}> ({
  ^bb0(%arg0: f32):
    %0 = "spirv.KHR.GroupFMul"(%arg0) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
    "spirv.ReturnValue"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

