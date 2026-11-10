"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "test_permlane_var_i32"}> ({
  ^bb0(%arg12: i32, %arg13: i32):
    %6 = "amdgpu.permlane_var"(%arg12, %arg13) <{bound_ctrl = false, cross = false, fetch_inactive = false}> : (i32, i32) -> i32
    "func.return"(%6) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "test_permlane_var_cross_i32"}> ({
  ^bb0(%arg10: i32, %arg11: i32):
    %5 = "amdgpu.permlane_var"(%arg10, %arg11) <{bound_ctrl = false, cross = true, fetch_inactive = false}> : (i32, i32) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, i32) -> f32, sym_name = "test_permlane_var_f32"}> ({
  ^bb0(%arg8: f32, %arg9: i32):
    %4 = "amdgpu.permlane_var"(%arg8, %arg9) <{bound_ctrl = false, cross = false, fetch_inactive = false}> : (f32, i32) -> f32
    "func.return"(%4) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16, i32) -> f16, sym_name = "test_permlane_var_f16"}> ({
  ^bb0(%arg6: f16, %arg7: i32):
    %3 = "amdgpu.permlane_var"(%arg6, %arg7) <{bound_ctrl = false, cross = false, fetch_inactive = false}> : (f16, i32) -> f16
    "func.return"(%3) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16, i32) -> f16, sym_name = "test_permlane_var_cross_f16"}> ({
  ^bb0(%arg4: f16, %arg5: i32):
    %2 = "amdgpu.permlane_var"(%arg4, %arg5) <{bound_ctrl = false, cross = true, fetch_inactive = false}> : (f16, i32) -> f16
    "func.return"(%2) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf16>, i32) -> vector<4xf16>, sym_name = "test_permlane_var_4xf16"}> ({
  ^bb0(%arg2: vector<4xf16>, %arg3: i32):
    %1 = "amdgpu.permlane_var"(%arg2, %arg3) <{bound_ctrl = false, cross = false, fetch_inactive = false}> : (vector<4xf16>, i32) -> vector<4xf16>
    "func.return"(%1) : (vector<4xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "test_permlane_var_attrs"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "amdgpu.permlane_var"(%arg0, %arg1) <{bound_ctrl = true, cross = true, fetch_inactive = true}> : (i32, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

