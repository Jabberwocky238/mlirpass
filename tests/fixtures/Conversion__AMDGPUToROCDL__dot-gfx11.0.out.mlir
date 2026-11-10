module {
  func.func @dot_fdot2_f16_f16(%arg0: vector<2xf16>, %arg1: vector<2xf16>, %arg2: f16) -> f16 {
    %0 = rocdl.fdot2.f16.f16 %arg0, %arg1, %arg2 : (vector<2xf16>, vector<2xf16>, f16) -> f16
    return %0 : f16
  }
  func.func @dot_fdot2_bf16_bf16(%arg0: vector<2xbf16>, %arg1: vector<2xbf16>, %arg2: bf16) -> bf16 {
    %0 = rocdl.fdot2.bf16.bf16 %arg0, %arg1, %arg2 : (vector<2xbf16>, vector<2xbf16>, bf16) -> bf16
    return %0 : bf16
  }
  func.func @dot_fdot2_f32_bf16(%arg0: vector<2xbf16>, %arg1: vector<2xbf16>, %arg2: f32) -> f32 {
    %0 = rocdl.fdot2.f32.bf16 %arg0, %arg1, %arg2 : (vector<2xbf16>, vector<2xbf16>, f32) -> f32
    return %0 : f32
  }
  func.func @dot_sdot4_gfx11_uniform_sign(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: i32) -> i32 {
    %0 = llvm.bitcast %arg0 : vector<4xi8> to i32
    %1 = llvm.bitcast %arg1 : vector<4xi8> to i32
    %2 = rocdl.sdot4 %0, %1, %arg2 : (i32, i32, i32) -> i32
    return %2 : i32
  }
  func.func @dot_sudot4_signA_unsignedB(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: i32) -> i32 {
    %0 = llvm.bitcast %arg0 : vector<4xi8> to i32
    %1 = llvm.bitcast %arg1 : vector<4xi8> to i32
    %2 = rocdl.sudot4 %0, %1, %arg2 {signA = true} : (i32, i32, i32) -> i32
    return %2 : i32
  }
  func.func @dot_sudot4_unsignedA_signB_clamp(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: i32) -> i32 {
    %0 = llvm.bitcast %arg0 : vector<4xi8> to i32
    %1 = llvm.bitcast %arg1 : vector<4xi8> to i32
    %2 = rocdl.sudot4 %0, %1, %arg2 {clamp = true, signB = true} : (i32, i32, i32) -> i32
    return %2 : i32
  }
  func.func @dot_sudot8(%arg0: vector<8xi4>, %arg1: vector<8xi4>, %arg2: i32) -> i32 {
    %0 = llvm.bitcast %arg0 : vector<8xi4> to i32
    %1 = llvm.bitcast %arg1 : vector<8xi4> to i32
    %2 = rocdl.sudot8 %0, %1, %arg2 {signA = true} : (i32, i32, i32) -> i32
    return %2 : i32
  }
}

