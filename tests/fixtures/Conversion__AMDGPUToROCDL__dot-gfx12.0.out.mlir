module {
  func.func @dot_fp8_fp8(%arg0: vector<4xf8E4M3FN>, %arg1: vector<4xf8E4M3FN>, %arg2: f32) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4xf8E4M3FN> to vector<4xi8>
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<4xf8E4M3FN> to vector<4xi8>
    %2 = llvm.bitcast %1 : vector<4xi8> to i32
    %3 = llvm.bitcast %0 : vector<4xi8> to i32
    %4 = rocdl.dot4.f32.fp8.fp8 %2, %3, %arg2 : (i32, i32, f32) -> f32
    return %4 : f32
  }
  func.func @dot_fp8_bf8(%arg0: vector<4xf8E4M3FN>, %arg1: vector<4xf8E5M2>, %arg2: f32) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4xf8E5M2> to vector<4xi8>
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<4xf8E4M3FN> to vector<4xi8>
    %2 = llvm.bitcast %1 : vector<4xi8> to i32
    %3 = llvm.bitcast %0 : vector<4xi8> to i32
    %4 = rocdl.dot4.f32.fp8.bf8 %2, %3, %arg2 : (i32, i32, f32) -> f32
    return %4 : f32
  }
  func.func @dot_bf8_fp8(%arg0: vector<4xf8E5M2>, %arg1: vector<4xf8E4M3FN>, %arg2: f32) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4xf8E4M3FN> to vector<4xi8>
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<4xf8E5M2> to vector<4xi8>
    %2 = llvm.bitcast %1 : vector<4xi8> to i32
    %3 = llvm.bitcast %0 : vector<4xi8> to i32
    %4 = rocdl.dot4.f32.bf8.fp8 %2, %3, %arg2 : (i32, i32, f32) -> f32
    return %4 : f32
  }
  func.func @dot_bf8_bf8(%arg0: vector<4xf8E5M2>, %arg1: vector<4xf8E5M2>, %arg2: f32) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4xf8E5M2> to vector<4xi8>
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<4xf8E5M2> to vector<4xi8>
    %2 = llvm.bitcast %1 : vector<4xi8> to i32
    %3 = llvm.bitcast %0 : vector<4xi8> to i32
    %4 = rocdl.dot4.f32.bf8.bf8 %2, %3, %arg2 : (i32, i32, f32) -> f32
    return %4 : f32
  }
}

