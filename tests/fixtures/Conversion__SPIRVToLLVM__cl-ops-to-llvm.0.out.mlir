module {
  llvm.func @cl_unary_float(%arg0: f32, %arg1: vector<3xf32>) {
    %0 = llvm.intr.ceil(%arg0) : (f32) -> f32
    %1 = llvm.intr.cos(%arg0) : (f32) -> f32
    %2 = llvm.intr.exp(%arg0) : (f32) -> f32
    %3 = llvm.intr.exp2(%arg0) : (f32) -> f32
    %4 = llvm.intr.exp10(%arg0) : (f32) -> f32
    %5 = llvm.intr.fabs(%arg0) : (f32) -> f32
    %6 = llvm.intr.floor(%arg0) : (f32) -> f32
    %7 = llvm.intr.log(%arg0) : (f32) -> f32
    %8 = llvm.intr.log2(%arg0) : (f32) -> f32
    %9 = llvm.intr.log10(%arg0) : (f32) -> f32
    %10 = llvm.intr.rint(%arg0) : (f32) -> f32
    %11 = llvm.intr.round(%arg0) : (f32) -> f32
    %12 = llvm.intr.sin(%arg0) : (f32) -> f32
    %13 = llvm.intr.sinh(%arg0) : (f32) -> f32
    %14 = llvm.intr.cosh(%arg0) : (f32) -> f32
    %15 = llvm.intr.tan(%arg0) : (f32) -> f32
    %16 = llvm.intr.tanh(%arg0) : (f32) -> f32
    %17 = llvm.intr.asin(%arg0) : (f32) -> f32
    %18 = llvm.intr.acos(%arg0) : (f32) -> f32
    %19 = llvm.intr.atan(%arg0) : (f32) -> f32
    %20 = llvm.intr.sqrt(%arg0) : (f32) -> f32
    %21 = llvm.intr.trunc(%arg0) : (f32) -> f32
    %22 = llvm.intr.sin(%arg1) : (vector<3xf32>) -> vector<3xf32>
    llvm.return
  }
  llvm.func @cl_binary_float(%arg0: f32, %arg1: f32) {
    %0 = llvm.intr.pow(%arg0, %arg1) : (f32, f32) -> f32
    %1 = llvm.intr.atan2(%arg0, %arg1) : (f32, f32) -> f32
    %2 = llvm.intr.maxnum(%arg0, %arg1) : (f32, f32) -> f32
    %3 = llvm.intr.minnum(%arg0, %arg1) : (f32, f32) -> f32
    %4 = llvm.intr.copysign(%arg0, %arg1) : (f32, f32) -> f32
    %5 = llvm.frem %arg0, %arg1 : f32
    llvm.return
  }
  llvm.func @cl_fma(%arg0: f32, %arg1: f32, %arg2: f32) {
    %0 = llvm.intr.fma(%arg0, %arg1, %arg2) : (f32, f32, f32) -> f32
    llvm.return
  }
  llvm.func @cl_integer(%arg0: i32, %arg1: i32) {
    %0 = llvm.intr.smax(%arg0, %arg1) : (i32, i32) -> i32
    %1 = llvm.intr.smin(%arg0, %arg1) : (i32, i32) -> i32
    %2 = llvm.intr.umax(%arg0, %arg1) : (i32, i32) -> i32
    %3 = llvm.intr.umin(%arg0, %arg1) : (i32, i32) -> i32
    llvm.return
  }
  llvm.func @mix_scalar(%arg0: f32, %arg1: f32, %arg2: f32) {
    %0 = llvm.fsub %arg1, %arg0 : f32
    %1 = llvm.intr.fma(%arg2, %0, %arg0) : (f32, f32, f32) -> f32
    llvm.return
  }
  llvm.func @mix_vector(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xf32>) {
    %0 = llvm.fsub %arg1, %arg0 : vector<4xf32>
    %1 = llvm.intr.fma(%arg2, %0, %arg0) : (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    llvm.return
  }
}

