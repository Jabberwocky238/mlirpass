module {
  func.func @dot_fdot2(%arg0: vector<2xf16>, %arg1: vector<2xf16>, %arg2: f32) -> f32 {
    %0 = rocdl.fdot2 %arg0, %arg1, %arg2 : (vector<2xf16>, vector<2xf16>, f32) -> f32
    return %0 : f32
  }
  func.func @dot_fdot2_clamp(%arg0: vector<2xf16>, %arg1: vector<2xf16>, %arg2: f32) -> f32 {
    %0 = rocdl.fdot2 %arg0, %arg1, %arg2 {clamp = true} : (vector<2xf16>, vector<2xf16>, f32) -> f32
    return %0 : f32
  }
  func.func @dot_sdot2(%arg0: vector<2xi16>, %arg1: vector<2xi16>, %arg2: i32) -> i32 {
    %0 = rocdl.sdot2 %arg0, %arg1, %arg2 : (vector<2xi16>, vector<2xi16>, i32) -> i32
    return %0 : i32
  }
  func.func @dot_udot2_clamp(%arg0: vector<2xi16>, %arg1: vector<2xi16>, %arg2: i32) -> i32 {
    %0 = rocdl.udot2 %arg0, %arg1, %arg2 {clamp = true} : (vector<2xi16>, vector<2xi16>, i32) -> i32
    return %0 : i32
  }
  func.func @dot_sdot4(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: i32) -> i32 {
    %0 = llvm.bitcast %arg0 : vector<4xi8> to i32
    %1 = llvm.bitcast %arg1 : vector<4xi8> to i32
    %2 = rocdl.sdot4 %0, %1, %arg2 : (i32, i32, i32) -> i32
    return %2 : i32
  }
  func.func @dot_udot4_clamp(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: i32) -> i32 {
    %0 = llvm.bitcast %arg0 : vector<4xi8> to i32
    %1 = llvm.bitcast %arg1 : vector<4xi8> to i32
    %2 = rocdl.udot4 %0, %1, %arg2 {clamp = true} : (i32, i32, i32) -> i32
    return %2 : i32
  }
  func.func @dot_sdot8(%arg0: vector<8xi4>, %arg1: vector<8xi4>, %arg2: i32) -> i32 {
    %0 = llvm.bitcast %arg0 : vector<8xi4> to i32
    %1 = llvm.bitcast %arg1 : vector<8xi4> to i32
    %2 = rocdl.sdot8 %0, %1, %arg2 : (i32, i32, i32) -> i32
    return %2 : i32
  }
  func.func @dot_udot8(%arg0: vector<8xi4>, %arg1: vector<8xi4>, %arg2: i32) -> i32 {
    %0 = llvm.bitcast %arg0 : vector<8xi4> to i32
    %1 = llvm.bitcast %arg1 : vector<8xi4> to i32
    %2 = rocdl.udot8 %0, %1, %arg2 : (i32, i32, i32) -> i32
    return %2 : i32
  }
}

