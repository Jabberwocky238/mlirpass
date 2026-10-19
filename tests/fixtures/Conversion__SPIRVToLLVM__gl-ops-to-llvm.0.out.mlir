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
  llvm.func @inverse_sqrt(%arg0: f32) {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.sqrt(%arg0) : (f32) -> f32
    %2 = llvm.fdiv %0, %1 : f32
    llvm.return
  }
}

