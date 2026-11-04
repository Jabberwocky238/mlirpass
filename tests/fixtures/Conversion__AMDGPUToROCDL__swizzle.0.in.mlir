"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "test_swizzle_i32"}> ({
  ^bb0(%arg4: i32):
    %4 = "amdgpu.swizzle_bitmode"(%arg4) <{and_mask = 1 : i32, or_mask = 2 : i32, xor_mask = 4 : i32}> : (i32) -> i32
    "func.return"(%4) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "test_swizzle_f32"}> ({
  ^bb0(%arg3: f32):
    %3 = "amdgpu.swizzle_bitmode"(%arg3) <{and_mask = 1 : i32, or_mask = 2 : i32, xor_mask = 4 : i32}> : (f32) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16) -> f16, sym_name = "test_swizzle_f16"}> ({
  ^bb0(%arg2: f16):
    %2 = "amdgpu.swizzle_bitmode"(%arg2) <{and_mask = 1 : i32, or_mask = 2 : i32, xor_mask = 4 : i32}> : (f16) -> f16
    "func.return"(%2) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi32>) -> vector<2xi32>, sym_name = "test_swizzle_2xi32"}> ({
  ^bb0(%arg1: vector<2xi32>):
    %1 = "amdgpu.swizzle_bitmode"(%arg1) <{and_mask = 1 : i32, or_mask = 2 : i32, xor_mask = 4 : i32}> : (vector<2xi32>) -> vector<2xi32>
    "func.return"(%1) : (vector<2xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf16>) -> vector<4xf16>, sym_name = "test_swizzle_4xf16"}> ({
  ^bb0(%arg0: vector<4xf16>):
    %0 = "amdgpu.swizzle_bitmode"(%arg0) <{and_mask = 1 : i32, or_mask = 2 : i32, xor_mask = 4 : i32}> : (vector<4xf16>) -> vector<4xf16>
    "func.return"(%0) : (vector<4xf16>) -> ()
  }) : () -> ()
}) : () -> ()

