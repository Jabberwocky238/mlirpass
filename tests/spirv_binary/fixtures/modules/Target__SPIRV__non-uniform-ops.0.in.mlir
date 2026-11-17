"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.3, [Shader, Linkage, GroupNonUniformBallot, GroupNonUniformArithmetic, GroupNonUniformClustered, GroupNonUniformShuffle, GroupNonUniformShuffleRelative, GroupNonUniformVote, GroupNonUniformQuad], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1) -> vector<4xi32>, sym_name = "group_non_uniform_ballot"}> ({
  ^bb0(%arg26: i1):
    %25 = "spirv.GroupNonUniformBallot"(%arg26) <{execution_scope = #spirv.scope<Workgroup>}> : (i1) -> vector<4xi32>
    "spirv.ReturnValue"(%25) : (vector<4xi32>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> f32, sym_name = "group_non_uniform_broadcast"}> ({
  ^bb0(%arg25: f32):
    %23 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %24 = "spirv.GroupNonUniformBroadcast"(%arg25, %23) <{execution_scope = #spirv.scope<Subgroup>}> : (f32, i32) -> f32
    "spirv.ReturnValue"(%24) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> f32, sym_name = "group_non_uniform_broadcast_first"}> ({
  ^bb0(%arg24: f32):
    %22 = "spirv.GroupNonUniformBroadcastFirst"(%arg24) <{execution_scope = #spirv.scope<Subgroup>}> : (f32) -> f32
    "spirv.ReturnValue"(%22) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> i1, sym_name = "group_non_uniform_elect"}> ({
    %21 = "spirv.GroupNonUniformElect"() <{execution_scope = #spirv.scope<Workgroup>}> : () -> i1
    "spirv.ReturnValue"(%21) : (i1) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> f32, sym_name = "group_non_uniform_fadd_reduce"}> ({
  ^bb0(%arg23: f32):
    %20 = "spirv.GroupNonUniformFAdd"(%arg23) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
    "spirv.ReturnValue"(%20) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> f32, sym_name = "group_non_uniform_fmax_reduce"}> ({
  ^bb0(%arg22: f32):
    %19 = "spirv.GroupNonUniformFMax"(%arg22) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
    "spirv.ReturnValue"(%19) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> f32, sym_name = "group_non_uniform_fmin_reduce"}> ({
  ^bb0(%arg21: f32):
    %18 = "spirv.GroupNonUniformFMin"(%arg21) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
    "spirv.ReturnValue"(%18) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> f32, sym_name = "group_non_uniform_fmul_reduce"}> ({
  ^bb0(%arg20: f32):
    %17 = "spirv.GroupNonUniformFMul"(%arg20) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
    "spirv.ReturnValue"(%17) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_non_uniform_iadd_reduce"}> ({
  ^bb0(%arg19: i32):
    %16 = "spirv.GroupNonUniformIAdd"(%arg19) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
    "spirv.ReturnValue"(%16) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xi32>) -> vector<2xi32>, sym_name = "group_non_uniform_iadd_clustered_reduce"}> ({
  ^bb0(%arg18: vector<2xi32>):
    %14 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %15 = "spirv.GroupNonUniformIAdd"(%arg18, %14) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<ClusteredReduce>}> : (vector<2xi32>, i32) -> vector<2xi32>
    "spirv.ReturnValue"(%15) : (vector<2xi32>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_non_uniform_imul_reduce"}> ({
  ^bb0(%arg17: i32):
    %13 = "spirv.GroupNonUniformIMul"(%arg17) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
    "spirv.ReturnValue"(%13) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_non_uniform_smax_reduce"}> ({
  ^bb0(%arg16: i32):
    %12 = "spirv.GroupNonUniformSMax"(%arg16) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
    "spirv.ReturnValue"(%12) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_non_uniform_smin_reduce"}> ({
  ^bb0(%arg15: i32):
    %11 = "spirv.GroupNonUniformSMin"(%arg15) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
    "spirv.ReturnValue"(%11) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_non_uniform_umax_reduce"}> ({
  ^bb0(%arg14: i32):
    %10 = "spirv.GroupNonUniformUMax"(%arg14) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
    "spirv.ReturnValue"(%10) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_non_uniform_umin_reduce"}> ({
  ^bb0(%arg13: i32):
    %9 = "spirv.GroupNonUniformUMin"(%arg13) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
    "spirv.ReturnValue"(%9) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, i32) -> f32, sym_name = "group_non_uniform_shuffle"}> ({
  ^bb0(%arg11: f32, %arg12: i32):
    %8 = "spirv.GroupNonUniformShuffle"(%arg11, %arg12) <{execution_scope = #spirv.scope<Subgroup>}> : (f32, i32) -> f32
    "spirv.ReturnValue"(%8) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, i32) -> f32, sym_name = "group_non_uniform_shuffle_up"}> ({
  ^bb0(%arg9: f32, %arg10: i32):
    %7 = "spirv.GroupNonUniformShuffleUp"(%arg9, %arg10) <{execution_scope = #spirv.scope<Subgroup>}> : (f32, i32) -> f32
    "spirv.ReturnValue"(%7) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, i32) -> f32, sym_name = "group_non_uniform_shuffle_down"}> ({
  ^bb0(%arg7: f32, %arg8: i32):
    %6 = "spirv.GroupNonUniformShuffleDown"(%arg7, %arg8) <{execution_scope = #spirv.scope<Subgroup>}> : (f32, i32) -> f32
    "spirv.ReturnValue"(%6) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, i32) -> f32, sym_name = "group_non_uniform_shuffle_xor"}> ({
  ^bb0(%arg5: f32, %arg6: i32):
    %5 = "spirv.GroupNonUniformShuffleXor"(%arg5, %arg6) <{execution_scope = #spirv.scope<Subgroup>}> : (f32, i32) -> f32
    "spirv.ReturnValue"(%5) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1) -> i1, sym_name = "group_non_uniform_all"}> ({
  ^bb0(%arg4: i1):
    %4 = "spirv.GroupNonUniformAll"(%arg4) <{execution_scope = #spirv.scope<Subgroup>}> : (i1) -> i1
    "spirv.ReturnValue"(%4) : (i1) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1) -> i1, sym_name = "group_non_uniform_any"}> ({
  ^bb0(%arg3: i1):
    %3 = "spirv.GroupNonUniformAny"(%arg3) <{execution_scope = #spirv.scope<Subgroup>}> : (i1) -> i1
    "spirv.ReturnValue"(%3) : (i1) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi32>) -> i1, sym_name = "group_non_uniform_all_equal"}> ({
  ^bb0(%arg2: vector<4xi32>):
    %2 = "spirv.GroupNonUniformAllEqual"(%arg2) <{execution_scope = #spirv.scope<Subgroup>}> : (vector<4xi32>) -> i1
    "spirv.ReturnValue"(%2) : (i1) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xf32>) -> vector<4xf32>, sym_name = "group_non_uniform_quad_swap_vec"}> ({
  ^bb0(%arg1: vector<4xf32>):
    %1 = "spirv.GroupNonUniformQuadSwap"(%arg1) <{direction = #spirv.quad_swap_direction<Vertical>, execution_scope = #spirv.scope<Subgroup>}> : (vector<4xf32>) -> vector<4xf32>
    "spirv.ReturnValue"(%1) : (vector<4xf32>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> f32, sym_name = "group_non_uniform_quad_swap_scalar"}> ({
  ^bb0(%arg0: f32):
    %0 = "spirv.GroupNonUniformQuadSwap"(%arg0) <{direction = #spirv.quad_swap_direction<Horizontal>, execution_scope = #spirv.scope<Subgroup>}> : (f32) -> f32
    "spirv.ReturnValue"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

