"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "test_dpp"}> ({
  ^bb0(%arg24: i32, %arg25: i32):
    %12 = "amdgpu.dpp"(%arg24, %arg25) <{bank_mask = 15 : i32, bound_ctrl = false, kind = #amdgpu<dpp_perm row_shl>, permArgument = 1 : i32, row_mask = 10 : i32}> : (i32, i32) -> i32
    "func.return"(%12) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "quad_dpp"}> ({
  ^bb0(%arg22: i32, %arg23: i32):
    %11 = "amdgpu.dpp"(%arg22, %arg23) <{bank_mask = 1 : i32, bound_ctrl = true, kind = #amdgpu<dpp_perm quad_perm>, permArgument = [1, 0, 1, 2], row_mask = 1 : i32}> : (i32, i32) -> i32
    "func.return"(%11) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "wave_shr_dpp"}> ({
  ^bb0(%arg20: i32, %arg21: i32):
    %10 = "amdgpu.dpp"(%arg20, %arg21) <{bank_mask = 1 : i32, bound_ctrl = true, kind = #amdgpu<dpp_perm wave_shr>, row_mask = 10 : i32}> : (i32, i32) -> i32
    "func.return"(%10) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "row_half_mirror_update_dpp"}> ({
  ^bb0(%arg18: i32, %arg19: i32):
    %9 = "amdgpu.dpp"(%arg18, %arg19) <{bank_mask = 1 : i32, bound_ctrl = false, kind = #amdgpu<dpp_perm row_half_mirror>, row_mask = 15 : i32}> : (i32, i32) -> i32
    "func.return"(%9) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "wave_rol_update_dpp"}> ({
  ^bb0(%arg16: i32, %arg17: i32):
    %8 = "amdgpu.dpp"(%arg16, %arg17) <{bank_mask = 1 : i32, bound_ctrl = false, kind = #amdgpu<dpp_perm wave_rol>, row_mask = 10 : i32}> : (i32, i32) -> i32
    "func.return"(%8) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "row_bcast_dpp_f32"}> ({
  ^bb0(%arg14: f32, %arg15: f32):
    %7 = "amdgpu.dpp"(%arg14, %arg15) <{bank_mask = 15 : i32, bound_ctrl = true, kind = #amdgpu<dpp_perm row_bcast_15>, row_mask = 15 : i32}> : (f32, f32) -> f32
    "func.return"(%7) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "test_dpp_f32"}> ({
  ^bb0(%arg12: f32, %arg13: f32):
    %6 = "amdgpu.dpp"(%arg12, %arg13) <{bank_mask = 4 : i32, bound_ctrl = true, kind = #amdgpu<dpp_perm row_mirror>, row_mask = 1 : i32}> : (f32, f32) -> f32
    "func.return"(%6) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "quad_perm_update_dpp_f32"}> ({
  ^bb0(%arg10: f32, %arg11: f32):
    %5 = "amdgpu.dpp"(%arg10, %arg11) <{bank_mask = 1 : i32, bound_ctrl = false, kind = #amdgpu<dpp_perm quad_perm>, permArgument = [0, 2, 1, 1], row_mask = 15 : i32}> : (f32, f32) -> f32
    "func.return"(%5) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64, i64) -> i64, sym_name = "quad_perm_dpp"}> ({
  ^bb0(%arg8: i64, %arg9: i64):
    %4 = "amdgpu.dpp"(%arg8, %arg9) <{bank_mask = 15 : i32, bound_ctrl = false, kind = #amdgpu<dpp_perm quad_perm>, permArgument = [0, 2, 1, 1], row_mask = 15 : i32}> : (i64, i64) -> i64
    "func.return"(%4) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f64, f64) -> f64, sym_name = "row_bcast_dpp"}> ({
  ^bb0(%arg6: f64, %arg7: f64):
    %3 = "amdgpu.dpp"(%arg6, %arg7) <{bank_mask = 1 : i32, bound_ctrl = false, kind = #amdgpu<dpp_perm row_bcast_31>, row_mask = 4 : i32}> : (f64, f64) -> f64
    "func.return"(%3) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16, f16) -> f16, sym_name = "test_dpp_f16"}> ({
  ^bb0(%arg4: f16, %arg5: f16):
    %2 = "amdgpu.dpp"(%arg4, %arg5) <{bank_mask = 3 : i32, bound_ctrl = false, kind = #amdgpu<dpp_perm row_shr>, permArgument = 1 : i32, row_mask = 15 : i32}> : (f16, f16) -> f16
    "func.return"(%2) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i16, i16) -> i16, sym_name = "row_shl_dpp_i16"}> ({
  ^bb0(%arg2: i16, %arg3: i16):
    %1 = "amdgpu.dpp"(%arg2, %arg3) <{bank_mask = 1 : i32, bound_ctrl = false, kind = #amdgpu<dpp_perm row_ror>, permArgument = 10 : i32, row_mask = 10 : i32}> : (i16, i16) -> i16
    "func.return"(%1) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16, f16) -> f16, sym_name = "row_bcast_update_dpp_f16"}> ({
  ^bb0(%arg0: f16, %arg1: f16):
    %0 = "amdgpu.dpp"(%arg0, %arg1) <{bank_mask = 15 : i32, bound_ctrl = true, kind = #amdgpu<dpp_perm row_bcast_15>, row_mask = 15 : i32}> : (f16, f16) -> f16
    "func.return"(%0) : (f16) -> ()
  }) : () -> ()
}) : () -> ()

