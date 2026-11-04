module {
  func.func @conversion_f8_fallback(%arg0: vector<2x2xf32>, %arg1: vector<2x2xf8E8M0FNU>) -> vector<2x2xf8E5M2> {
    %0 = arith.scaling_truncf %arg0, %arg1 : vector<2x2xf32>, vector<2x2xf8E8M0FNU> to vector<2x2xf8E5M2>
    return %0 : vector<2x2xf8E5M2>
  }
}

// -----
module {
  func.func @conversion_f4_fallback(%arg0: vector<2x2xf32>, %arg1: vector<2x2xf8E8M0FNU>) -> vector<2x2xf4E2M1FN> {
    %0 = arith.scaling_truncf %arg0, %arg1 : vector<2x2xf32>, vector<2x2xf8E8M0FNU> to vector<2x2xf4E2M1FN>
    return %0 : vector<2x2xf4E2M1FN>
  }
}

// -----
module {
  func.func @conversion_broadcast(%arg0: vector<8x8xf32>, %arg1: vector<8x2xf8E8M0FNU>) -> vector<8x8xf8E5M2> {
    %0 = vector.broadcast %arg1 : vector<8x2xf8E8M0FNU> to vector<4x8x2xf8E8M0FNU>
    %1 = vector.shape_cast %arg0 : vector<8x8xf32> to vector<8x2x4xf32>
    %2 = vector.shape_cast %0 : vector<4x8x2xf8E8M0FNU> to vector<8x2x4xf8E8M0FNU>
    %3 = arith.scaling_truncf %1, %2 : vector<8x2x4xf32>, vector<8x2x4xf8E8M0FNU> to vector<8x2x4xf8E5M2>
    %4 = vector.shape_cast %3 : vector<8x2x4xf8E5M2> to vector<8x8xf8E5M2>
    return %4 : vector<8x8xf8E5M2>
  }
}

// -----
module {
  func.func @conversion_broadcast_odd(%arg0: vector<6xf32>, %arg1: vector<2xf8E8M0FNU>) -> vector<6xf8E5M2> {
    %0 = vector.broadcast %arg1 : vector<2xf8E8M0FNU> to vector<3x2xf8E8M0FNU>
    %1 = vector.shape_cast %0 : vector<3x2xf8E8M0FNU> to vector<6xf8E8M0FNU>
    %2 = arith.scaling_truncf %arg0, %1 : vector<6xf32>, vector<6xf8E8M0FNU> to vector<6xf8E5M2>
    return %2 : vector<6xf8E5M2>
  }
}

// -----
module {
  func.func @conversion_broadcast(%arg0: vector<4xf32>, %arg1: f8E8M0FNU) -> vector<4xf8E5M2> {
    %0 = vector.broadcast %arg1 : f8E8M0FNU to vector<4xf8E8M0FNU>
    %1 = arith.scaling_truncf %arg0, %0 : vector<4xf32>, vector<4xf8E8M0FNU> to vector<4xf8E5M2>
    return %1 : vector<4xf8E5M2>
  }
}

// -----
module {
  func.func @conversion_scalar(%arg0: f32, %arg1: f8E8M0FNU) -> f8E5M2 {
    %0 = arith.scaling_truncf %arg0, %arg1 : f32, f8E8M0FNU to f8E5M2
    return %0 : f8E5M2
  }
}

// -----
module {
  func.func @long_fp4_broadcast(%arg0: vector<32xf32>, %arg1: f32) -> vector<32xf4E2M1FN> {
    %0 = vector.broadcast %arg1 : f32 to vector<32xf32>
    %1 = arith.scaling_truncf %arg0, %0 : vector<32xf32>, vector<32xf32> to vector<32xf4E2M1FN>
    return %1 : vector<32xf4E2M1FN>
  }
}

// -----
module {
  func.func @long_fp8_broadcast(%arg0: vector<32xf32>, %arg1: f32) -> vector<32xf8E4M3FN> {
    %0 = vector.broadcast %arg1 : f32 to vector<32xf32>
    %1 = arith.scaling_truncf %arg0, %0 : vector<32xf32>, vector<32xf32> to vector<32xf8E4M3FN>
    return %1 : vector<32xf8E4M3FN>
  }
}

