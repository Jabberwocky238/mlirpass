"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "test_permlane16_i32"}> ({
  ^bb0(%arg10: i32):
    %10 = "amdgpu.permlane_swap"(%arg10) <{bound_ctrl = false, fetch_inactive = false, row_length = 16 : i32}> : (i32) -> i32
    "func.return"(%10) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "test_permlane16_i32_optional_attr"}> ({
  ^bb0(%arg9: i32):
    %9 = "amdgpu.permlane_swap"(%arg9) <{bound_ctrl = true, fetch_inactive = true, row_length = 16 : i32}> : (i32) -> i32
    "func.return"(%9) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "test_permlane32_i32"}> ({
  ^bb0(%arg8: i32):
    %8 = "amdgpu.permlane_swap"(%arg8) <{bound_ctrl = false, fetch_inactive = false, row_length = 32 : i32}> : (i32) -> i32
    "func.return"(%8) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "test_permlane16_f32"}> ({
  ^bb0(%arg7: f32):
    %7 = "amdgpu.permlane_swap"(%arg7) <{bound_ctrl = false, fetch_inactive = false, row_length = 16 : i32}> : (f32) -> f32
    "func.return"(%7) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "test_permlane32_f32"}> ({
  ^bb0(%arg6: f32):
    %6 = "amdgpu.permlane_swap"(%arg6) <{bound_ctrl = false, fetch_inactive = false, row_length = 32 : i32}> : (f32) -> f32
    "func.return"(%6) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16) -> f16, sym_name = "test_permlane16_f16"}> ({
  ^bb0(%arg5: f16):
    %5 = "amdgpu.permlane_swap"(%arg5) <{bound_ctrl = false, fetch_inactive = false, row_length = 16 : i32}> : (f16) -> f16
    "func.return"(%5) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16) -> f16, sym_name = "test_permlane32_f16"}> ({
  ^bb0(%arg4: f16):
    %4 = "amdgpu.permlane_swap"(%arg4) <{bound_ctrl = false, fetch_inactive = false, row_length = 32 : i32}> : (f16) -> f16
    "func.return"(%4) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi32>) -> vector<2xi32>, sym_name = "test_permlane16_2xi32"}> ({
  ^bb0(%arg3: vector<2xi32>):
    %3 = "amdgpu.permlane_swap"(%arg3) <{bound_ctrl = false, fetch_inactive = false, row_length = 16 : i32}> : (vector<2xi32>) -> vector<2xi32>
    "func.return"(%3) : (vector<2xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi32>) -> vector<2xi32>, sym_name = "test_permlane32_2xi32"}> ({
  ^bb0(%arg2: vector<2xi32>):
    %2 = "amdgpu.permlane_swap"(%arg2) <{bound_ctrl = false, fetch_inactive = false, row_length = 32 : i32}> : (vector<2xi32>) -> vector<2xi32>
    "func.return"(%2) : (vector<2xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf16>) -> vector<4xf16>, sym_name = "test_permlane16_4xf16"}> ({
  ^bb0(%arg1: vector<4xf16>):
    %1 = "amdgpu.permlane_swap"(%arg1) <{bound_ctrl = false, fetch_inactive = false, row_length = 16 : i32}> : (vector<4xf16>) -> vector<4xf16>
    "func.return"(%1) : (vector<4xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf16>) -> vector<4xf16>, sym_name = "test_permlane32_4xf16"}> ({
  ^bb0(%arg0: vector<4xf16>):
    %0 = "amdgpu.permlane_swap"(%arg0) <{bound_ctrl = false, fetch_inactive = false, row_length = 32 : i32}> : (vector<4xf16>) -> vector<4xf16>
    "func.return"(%0) : (vector<4xf16>) -> ()
  }) : () -> ()
}) : () -> ()

