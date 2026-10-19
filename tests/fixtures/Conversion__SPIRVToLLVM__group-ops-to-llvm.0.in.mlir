"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_reduce_iadd"}> ({
  ^bb0(%arg24: i32):
    %24 = "spirv.GroupIAdd"(%arg24) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
    "spirv.ReturnValue"(%24) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> f32, sym_name = "group_reduce_fadd"}> ({
  ^bb0(%arg23: f32):
    %23 = "spirv.GroupFAdd"(%arg23) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
    "spirv.ReturnValue"(%23) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> f32, sym_name = "group_reduce_fmin"}> ({
  ^bb0(%arg22: f32):
    %22 = "spirv.GroupFMin"(%arg22) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
    "spirv.ReturnValue"(%22) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_reduce_umin"}> ({
  ^bb0(%arg21: i32):
    %21 = "spirv.GroupUMin"(%arg21) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
    "spirv.ReturnValue"(%21) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_reduce_smin"}> ({
  ^bb0(%arg20: i32):
    %20 = "spirv.GroupSMin"(%arg20) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
    "spirv.ReturnValue"(%20) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> f32, sym_name = "group_reduce_fmax"}> ({
  ^bb0(%arg19: f32):
    %19 = "spirv.GroupFMax"(%arg19) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
    "spirv.ReturnValue"(%19) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_reduce_umax"}> ({
  ^bb0(%arg18: i32):
    %18 = "spirv.GroupUMax"(%arg18) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
    "spirv.ReturnValue"(%18) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_reduce_smax"}> ({
  ^bb0(%arg17: i32):
    %17 = "spirv.GroupSMax"(%arg17) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
    "spirv.ReturnValue"(%17) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_inclusive_scan_iadd"}> ({
  ^bb0(%arg16: i32):
    %16 = "spirv.GroupIAdd"(%arg16) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<InclusiveScan>}> : (i32) -> i32
    "spirv.ReturnValue"(%16) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> f32, sym_name = "group_inclusive_scan_fadd"}> ({
  ^bb0(%arg15: f32):
    %15 = "spirv.GroupFAdd"(%arg15) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<InclusiveScan>}> : (f32) -> f32
    "spirv.ReturnValue"(%15) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> f32, sym_name = "group_inclusive_scan_fmin"}> ({
  ^bb0(%arg14: f32):
    %14 = "spirv.GroupFMin"(%arg14) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<InclusiveScan>}> : (f32) -> f32
    "spirv.ReturnValue"(%14) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_inclusive_scan_umin"}> ({
  ^bb0(%arg13: i32):
    %13 = "spirv.GroupUMin"(%arg13) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<InclusiveScan>}> : (i32) -> i32
    "spirv.ReturnValue"(%13) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_inclusive_scan_smin"}> ({
  ^bb0(%arg12: i32):
    %12 = "spirv.GroupSMin"(%arg12) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<InclusiveScan>}> : (i32) -> i32
    "spirv.ReturnValue"(%12) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> f32, sym_name = "group_inclusive_scan_fmax"}> ({
  ^bb0(%arg11: f32):
    %11 = "spirv.GroupFMax"(%arg11) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<InclusiveScan>}> : (f32) -> f32
    "spirv.ReturnValue"(%11) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_inclusive_scan_umax"}> ({
  ^bb0(%arg10: i32):
    %10 = "spirv.GroupUMax"(%arg10) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<InclusiveScan>}> : (i32) -> i32
    "spirv.ReturnValue"(%10) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_inclusive_scan_smax"}> ({
  ^bb0(%arg9: i32):
    %9 = "spirv.GroupSMax"(%arg9) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<ExclusiveScan>}> : (i32) -> i32
    "spirv.ReturnValue"(%9) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_exclusive_scan_iadd"}> ({
  ^bb0(%arg8: i32):
    %8 = "spirv.GroupIAdd"(%arg8) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<ExclusiveScan>}> : (i32) -> i32
    "spirv.ReturnValue"(%8) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> f32, sym_name = "group_exclusive_scan_fadd"}> ({
  ^bb0(%arg7: f32):
    %7 = "spirv.GroupFAdd"(%arg7) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<ExclusiveScan>}> : (f32) -> f32
    "spirv.ReturnValue"(%7) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> f32, sym_name = "group_exclusive_scan_fmin"}> ({
  ^bb0(%arg6: f32):
    %6 = "spirv.GroupFMin"(%arg6) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<ExclusiveScan>}> : (f32) -> f32
    "spirv.ReturnValue"(%6) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_exclusive_scan_umin"}> ({
  ^bb0(%arg5: i32):
    %5 = "spirv.GroupUMin"(%arg5) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<ExclusiveScan>}> : (i32) -> i32
    "spirv.ReturnValue"(%5) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_exclusive_scan_smin"}> ({
  ^bb0(%arg4: i32):
    %4 = "spirv.GroupSMin"(%arg4) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<ExclusiveScan>}> : (i32) -> i32
    "spirv.ReturnValue"(%4) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> f32, sym_name = "group_exclusive_scan_fmax"}> ({
  ^bb0(%arg3: f32):
    %3 = "spirv.GroupFMax"(%arg3) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<ExclusiveScan>}> : (f32) -> f32
    "spirv.ReturnValue"(%3) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_exclusive_scan_umax"}> ({
  ^bb0(%arg2: i32):
    %2 = "spirv.GroupUMax"(%arg2) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<ExclusiveScan>}> : (i32) -> i32
    "spirv.ReturnValue"(%2) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "group_exclusive_scan_smax"}> ({
  ^bb0(%arg1: i32):
    %1 = "spirv.GroupSMax"(%arg1) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<ExclusiveScan>}> : (i32) -> i32
    "spirv.ReturnValue"(%1) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "subgroup_exclusive_scan_smax"}> ({
  ^bb0(%arg0: i32):
    %0 = "spirv.GroupSMax"(%arg0) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<ExclusiveScan>}> : (i32) -> i32
    "spirv.ReturnValue"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

