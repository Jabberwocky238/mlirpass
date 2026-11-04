"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xf8E5M2>, vector<2x2xf8E8M0FNU>) -> vector<2x2xf32>, sym_name = "conversion_f8_f32_fallback"}> ({
  ^bb0(%arg0: vector<2x2xf8E5M2>, %arg1: vector<2x2xf8E8M0FNU>):
    %0 = "arith.scaling_extf"(%arg0, %arg1) : (vector<2x2xf8E5M2>, vector<2x2xf8E8M0FNU>) -> vector<2x2xf32>
    "func.return"(%0) : (vector<2x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xf4E2M1FN>, vector<2x2xf8E8M0FNU>) -> vector<2x2xf32>, sym_name = "conversion_f4_f32_fallback"}> ({
  ^bb0(%arg0: vector<2x2xf4E2M1FN>, %arg1: vector<2x2xf8E8M0FNU>):
    %0 = "arith.scaling_extf"(%arg0, %arg1) : (vector<2x2xf4E2M1FN>, vector<2x2xf8E8M0FNU>) -> vector<2x2xf32>
    "func.return"(%0) : (vector<2x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xf8E5M2>, vector<2x2xf8E8M0FNU>) -> vector<2x2xf16>, sym_name = "conversion_f8_f16_fallback"}> ({
  ^bb0(%arg0: vector<2x2xf8E5M2>, %arg1: vector<2x2xf8E8M0FNU>):
    %0 = "arith.scaling_extf"(%arg0, %arg1) : (vector<2x2xf8E5M2>, vector<2x2xf8E8M0FNU>) -> vector<2x2xf16>
    "func.return"(%0) : (vector<2x2xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xf4E2M1FN>, vector<2x2xf8E8M0FNU>) -> vector<2x2xf16>, sym_name = "conversion_f4_f16_fallback"}> ({
  ^bb0(%arg0: vector<2x2xf4E2M1FN>, %arg1: vector<2x2xf8E8M0FNU>):
    %0 = "arith.scaling_extf"(%arg0, %arg1) : (vector<2x2xf4E2M1FN>, vector<2x2xf8E8M0FNU>) -> vector<2x2xf16>
    "func.return"(%0) : (vector<2x2xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8x8xf8E5M2>, vector<8x2xf8E8M0FNU>) -> vector<8x8xf32>, sym_name = "conversion_broadcast"}> ({
  ^bb0(%arg0: vector<8x8xf8E5M2>, %arg1: vector<8x2xf8E8M0FNU>):
    %0 = "vector.broadcast"(%arg1) : (vector<8x2xf8E8M0FNU>) -> vector<4x8x2xf8E8M0FNU>
    %1 = "vector.shape_cast"(%arg0) : (vector<8x8xf8E5M2>) -> vector<8x2x4xf8E5M2>
    %2 = "vector.shape_cast"(%0) : (vector<4x8x2xf8E8M0FNU>) -> vector<8x2x4xf8E8M0FNU>
    %3 = "arith.scaling_extf"(%1, %2) : (vector<8x2x4xf8E5M2>, vector<8x2x4xf8E8M0FNU>) -> vector<8x2x4xf32>
    %4 = "vector.shape_cast"(%3) : (vector<8x2x4xf32>) -> vector<8x8xf32>
    "func.return"(%4) : (vector<8x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<6xf8E5M2>, vector<2xf8E8M0FNU>) -> vector<6xf32>, sym_name = "conversion_broadcast_odd"}> ({
  ^bb0(%arg0: vector<6xf8E5M2>, %arg1: vector<2xf8E8M0FNU>):
    %0 = "vector.broadcast"(%arg1) : (vector<2xf8E8M0FNU>) -> vector<3x2xf8E8M0FNU>
    %1 = "vector.shape_cast"(%0) : (vector<3x2xf8E8M0FNU>) -> vector<6xf8E8M0FNU>
    %2 = "arith.scaling_extf"(%arg0, %1) : (vector<6xf8E5M2>, vector<6xf8E8M0FNU>) -> vector<6xf32>
    "func.return"(%2) : (vector<6xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf8E5M2>, f8E8M0FNU) -> vector<4xf32>, sym_name = "conversion_broadcast"}> ({
  ^bb0(%arg0: vector<4xf8E5M2>, %arg1: f8E8M0FNU):
    %0 = "vector.broadcast"(%arg1) : (f8E8M0FNU) -> vector<4xf8E8M0FNU>
    %1 = "arith.scaling_extf"(%arg0, %0) : (vector<4xf8E5M2>, vector<4xf8E8M0FNU>) -> vector<4xf32>
    "func.return"(%1) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f8E5M2, f8E8M0FNU) -> f32, sym_name = "conversion_scalar"}> ({
  ^bb0(%arg0: f8E5M2, %arg1: f8E8M0FNU):
    %0 = "arith.scaling_extf"(%arg0, %arg1) : (f8E5M2, f8E8M0FNU) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32xf4E2M1FN>, f32) -> vector<32xf32>, sym_name = "long_fp4_broadcast"}> ({
  ^bb0(%arg0: vector<32xf4E2M1FN>, %arg1: f32):
    %0 = "vector.broadcast"(%arg1) : (f32) -> vector<32xf32>
    %1 = "arith.scaling_extf"(%arg0, %0) : (vector<32xf4E2M1FN>, vector<32xf32>) -> vector<32xf32>
    "func.return"(%1) : (vector<32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32xf8E4M3FN>, f32) -> vector<32xf32>, sym_name = "long_fp8_broadcast"}> ({
  ^bb0(%arg0: vector<32xf8E4M3FN>, %arg1: f32):
    %0 = "vector.broadcast"(%arg1) : (f32) -> vector<32xf32>
    %1 = "arith.scaling_extf"(%arg0, %0) : (vector<32xf8E4M3FN>, vector<32xf32>) -> vector<32xf32>
    "func.return"(%1) : (vector<32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

