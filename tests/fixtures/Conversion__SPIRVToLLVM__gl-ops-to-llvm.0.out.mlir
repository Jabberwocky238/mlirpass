module {
  llvm.func @ceil(%arg0: f32, %arg1: vector<3xf16>) {
    %0 = llvm.intr.ceil(%arg0) : (f32) -> f32
    %1 = llvm.intr.ceil(%arg1) : (vector<3xf16>) -> vector<3xf16>
    llvm.return
  }
  llvm.func @cos(%arg0: f32, %arg1: vector<3xf16>) {
    %0 = llvm.intr.cos(%arg0) : (f32) -> f32
    %1 = llvm.intr.cos(%arg1) : (vector<3xf16>) -> vector<3xf16>
    llvm.return
  }
  llvm.func @exp(%arg0: f32, %arg1: vector<3xf16>) {
    %0 = llvm.intr.exp(%arg0) : (f32) -> f32
    %1 = llvm.intr.exp(%arg1) : (vector<3xf16>) -> vector<3xf16>
    llvm.return
  }
  llvm.func @fabs(%arg0: f32, %arg1: vector<3xf16>) {
    %0 = llvm.intr.fabs(%arg0) : (f32) -> f32
    %1 = llvm.intr.fabs(%arg1) : (vector<3xf16>) -> vector<3xf16>
    llvm.return
  }
  llvm.func @floor(%arg0: f32, %arg1: vector<3xf16>) {
    %0 = llvm.intr.floor(%arg0) : (f32) -> f32
    %1 = llvm.intr.floor(%arg1) : (vector<3xf16>) -> vector<3xf16>
    llvm.return
  }
  llvm.func @fmax(%arg0: f32, %arg1: vector<3xf16>) {
    %0 = llvm.intr.maxnum(%arg0, %arg0) : (f32, f32) -> f32
    %1 = llvm.intr.maxnum(%arg1, %arg1) : (vector<3xf16>, vector<3xf16>) -> vector<3xf16>
    llvm.return
  }
  llvm.func @fmin(%arg0: f32, %arg1: vector<3xf16>) {
    %0 = llvm.intr.minnum(%arg0, %arg0) : (f32, f32) -> f32
    %1 = llvm.intr.minnum(%arg1, %arg1) : (vector<3xf16>, vector<3xf16>) -> vector<3xf16>
    llvm.return
  }
  llvm.func @fclamp(%arg0: f32, %arg1: f32, %arg2: f32) {
    %0 = llvm.intr.maxnum(%arg0, %arg1) : (f32, f32) -> f32
    %1 = llvm.intr.minnum(%0, %arg2) : (f32, f32) -> f32
    llvm.return
  }
  llvm.func @nmax(%arg0: f32, %arg1: vector<3xf16>) {
    %0 = llvm.intr.maxnum(%arg0, %arg0) : (f32, f32) -> f32
    %1 = llvm.intr.maxnum(%arg1, %arg1) : (vector<3xf16>, vector<3xf16>) -> vector<3xf16>
    llvm.return
  }
  llvm.func @nmin(%arg0: f32, %arg1: vector<3xf16>) {
    %0 = llvm.intr.minnum(%arg0, %arg0) : (f32, f32) -> f32
    %1 = llvm.intr.minnum(%arg1, %arg1) : (vector<3xf16>, vector<3xf16>) -> vector<3xf16>
    llvm.return
  }
  llvm.func @log(%arg0: f32, %arg1: vector<3xf16>) {
    %0 = llvm.intr.log(%arg0) : (f32) -> f32
    %1 = llvm.intr.log(%arg1) : (vector<3xf16>) -> vector<3xf16>
    llvm.return
  }
  llvm.func @sin(%arg0: f32, %arg1: vector<3xf16>) {
    %0 = llvm.intr.sin(%arg0) : (f32) -> f32
    %1 = llvm.intr.sin(%arg1) : (vector<3xf16>) -> vector<3xf16>
    llvm.return
  }
  llvm.func @pow(%arg0: f32, %arg1: vector<3xf16>) {
    %0 = llvm.intr.pow(%arg0, %arg0) : (f32, f32) -> f32
    %1 = llvm.intr.pow(%arg1, %arg1) : (vector<3xf16>, vector<3xf16>) -> vector<3xf16>
    llvm.return
  }
  llvm.func @fma(%arg0: f32, %arg1: vector<3xf16>) {
    %0 = llvm.intr.fma(%arg0, %arg0, %arg0) : (f32, f32, f32) -> f32
    %1 = llvm.intr.fma(%arg1, %arg1, %arg1) : (vector<3xf16>, vector<3xf16>, vector<3xf16>) -> vector<3xf16>
    llvm.return
  }
  llvm.func @sabs(%arg0: i16, %arg1: vector<3xi32>) {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i16) -> i16
    %1 = "llvm.intr.abs"(%arg1) <{is_int_min_poison = false}> : (vector<3xi32>) -> vector<3xi32>
    llvm.return
  }
  llvm.func @smax(%arg0: i16, %arg1: vector<3xi32>) {
    %0 = llvm.intr.smax(%arg0, %arg0) : (i16, i16) -> i16
    %1 = llvm.intr.smax(%arg1, %arg1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    llvm.return
  }
  llvm.func @smin(%arg0: i16, %arg1: vector<3xi32>) {
    %0 = llvm.intr.smin(%arg0, %arg0) : (i16, i16) -> i16
    %1 = llvm.intr.smin(%arg1, %arg1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    llvm.return
  }
  llvm.func @umax(%arg0: i16, %arg1: vector<3xi32>) {
    %0 = llvm.intr.umax(%arg0, %arg0) : (i16, i16) -> i16
    %1 = llvm.intr.umax(%arg1, %arg1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    llvm.return
  }
  llvm.func @umin(%arg0: i16, %arg1: vector<3xi32>) {
    %0 = llvm.intr.umin(%arg0, %arg0) : (i16, i16) -> i16
    %1 = llvm.intr.umin(%arg1, %arg1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    llvm.return
  }
  llvm.func @sclamp(%arg0: i16, %arg1: i16, %arg2: i16) {
    %0 = llvm.intr.smax(%arg0, %arg1) : (i16, i16) -> i16
    %1 = llvm.intr.smin(%0, %arg2) : (i16, i16) -> i16
    llvm.return
  }
  llvm.func @uclamp(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.intr.umax(%arg0, %arg1) : (i32, i32) -> i32
    %1 = llvm.intr.umin(%0, %arg2) : (i32, i32) -> i32
    llvm.return
  }
  llvm.func @sqrt(%arg0: f32, %arg1: vector<3xf16>) {
    %0 = llvm.intr.sqrt(%arg0) : (f32) -> f32
    %1 = llvm.intr.sqrt(%arg1) : (vector<3xf16>) -> vector<3xf16>
    llvm.return
  }
  llvm.func @tan(%arg0: f32) {
    %0 = llvm.intr.tan(%arg0) : (f32) -> f32
    llvm.return
  }
  llvm.func @tanh(%arg0: f32) {
    %0 = llvm.intr.tanh(%arg0) : (f32) -> f32
    llvm.return
  }
  llvm.func @exp2(%arg0: f32, %arg1: vector<3xf16>) {
    %0 = llvm.intr.exp2(%arg0) : (f32) -> f32
    %1 = llvm.intr.exp2(%arg1) : (vector<3xf16>) -> vector<3xf16>
    llvm.return
  }
  llvm.func @log2(%arg0: f32, %arg1: vector<3xf16>) {
    %0 = llvm.intr.log2(%arg0) : (f32) -> f32
    %1 = llvm.intr.log2(%arg1) : (vector<3xf16>) -> vector<3xf16>
    llvm.return
  }
  llvm.func @round(%arg0: f32, %arg1: vector<3xf16>) {
    %0 = llvm.intr.round(%arg0) : (f32) -> f32
    %1 = llvm.intr.round(%arg1) : (vector<3xf16>) -> vector<3xf16>
    llvm.return
  }
  llvm.func @round_even(%arg0: f32, %arg1: vector<3xf16>) {
    %0 = llvm.intr.roundeven(%arg0) : (f32) -> f32
    %1 = llvm.intr.roundeven(%arg1) : (vector<3xf16>) -> vector<3xf16>
    llvm.return
  }
  llvm.func @sinh(%arg0: f32, %arg1: vector<3xf16>) {
    %0 = llvm.intr.sinh(%arg0) : (f32) -> f32
    %1 = llvm.intr.sinh(%arg1) : (vector<3xf16>) -> vector<3xf16>
    llvm.return
  }
  llvm.func @cosh(%arg0: f32, %arg1: vector<3xf16>) {
    %0 = llvm.intr.cosh(%arg0) : (f32) -> f32
    %1 = llvm.intr.cosh(%arg1) : (vector<3xf16>) -> vector<3xf16>
    llvm.return
  }
  llvm.func @inverse_sqrt(%arg0: f32) {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.sqrt(%arg0) : (f32) -> f32
    %2 = llvm.fdiv %0, %1 : f32
    llvm.return
  }
  llvm.func @radians(%arg0: f32, %arg1: vector<3xf32>) {
    %0 = llvm.mlir.constant(0.0174532924 : f32) : f32
    %1 = llvm.fmul %arg0, %0 : f32
    %2 = llvm.mlir.constant(dense<0.0174532924> : vector<3xf32>) : vector<3xf32>
    %3 = llvm.fmul %arg1, %2 : vector<3xf32>
    llvm.return
  }
  llvm.func @degrees(%arg0: f32, %arg1: vector<3xf32>) {
    %0 = llvm.mlir.constant(57.2957802 : f32) : f32
    %1 = llvm.fmul %arg0, %0 : f32
    %2 = llvm.mlir.constant(dense<57.2957802> : vector<3xf32>) : vector<3xf32>
    %3 = llvm.fmul %arg1, %2 : vector<3xf32>
    llvm.return
  }
  llvm.func @trunc(%arg0: f32, %arg1: vector<3xf16>) {
    %0 = llvm.intr.trunc(%arg0) : (f32) -> f32
    %1 = llvm.intr.trunc(%arg1) : (vector<3xf16>) -> vector<3xf16>
    llvm.return
  }
  llvm.func @asin_acos_atan(%arg0: f32, %arg1: vector<3xf16>) {
    %0 = llvm.intr.asin(%arg0) : (f32) -> f32
    %1 = llvm.intr.acos(%arg1) : (vector<3xf16>) -> vector<3xf16>
    %2 = llvm.intr.atan(%arg0) : (f32) -> f32
    llvm.return
  }
  llvm.func @fract(%arg0: f32, %arg1: vector<3xf16>) {
    %0 = llvm.intr.floor(%arg0) : (f32) -> f32
    %1 = llvm.fsub %arg0, %0 : f32
    %2 = llvm.intr.floor(%arg1) : (vector<3xf16>) -> vector<3xf16>
    %3 = llvm.fsub %arg1, %2 : vector<3xf16>
    llvm.return
  }
  llvm.func @fmix_scalar(%arg0: f32, %arg1: f32, %arg2: f32) {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg2 : f32
    %2 = llvm.fmul %arg0, %1 : f32
    %3 = llvm.fmul %arg1, %arg2 : f32
    %4 = llvm.fadd %2, %3 : f32
    llvm.return
  }
  llvm.func @fmix_vector(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xf32>) {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.fsub %0, %arg2 : vector<4xf32>
    %2 = llvm.fmul %arg0, %1 : vector<4xf32>
    %3 = llvm.fmul %arg1, %arg2 : vector<4xf32>
    %4 = llvm.fadd %2, %3 : vector<4xf32>
    llvm.return
  }
}

