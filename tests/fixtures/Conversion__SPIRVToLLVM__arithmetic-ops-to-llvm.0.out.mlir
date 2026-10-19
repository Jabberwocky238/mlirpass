module {
  llvm.func @iadd_scalar(%arg0: i32, %arg1: i32) {
    %0 = llvm.add %arg0, %arg1 : i32
    llvm.return
  }
  llvm.func @iadd_vector(%arg0: vector<4xi64>, %arg1: vector<4xi64>) {
    %0 = llvm.add %arg0, %arg1 : vector<4xi64>
    llvm.return
  }
  llvm.func @isub_scalar(%arg0: i8, %arg1: i8) {
    %0 = llvm.sub %arg0, %arg1 : i8
    llvm.return
  }
  llvm.func @isub_vector(%arg0: vector<2xi16>, %arg1: vector<2xi16>) {
    %0 = llvm.sub %arg0, %arg1 : vector<2xi16>
    llvm.return
  }
  llvm.func @imul_scalar(%arg0: i32, %arg1: i32) {
    %0 = llvm.mul %arg0, %arg1 : i32
    llvm.return
  }
  llvm.func @imul_vector(%arg0: vector<3xi32>, %arg1: vector<3xi32>) {
    %0 = llvm.mul %arg0, %arg1 : vector<3xi32>
    llvm.return
  }
  llvm.func @fadd_scalar(%arg0: f16, %arg1: f16) {
    %0 = llvm.fadd %arg0, %arg1 : f16
    llvm.return
  }
  llvm.func @fadd_vector(%arg0: vector<4xf32>, %arg1: vector<4xf32>) {
    %0 = llvm.fadd %arg0, %arg1 : vector<4xf32>
    llvm.return
  }
  llvm.func @fsub_scalar(%arg0: f32, %arg1: f32) {
    %0 = llvm.fsub %arg0, %arg1 : f32
    llvm.return
  }
  llvm.func @fsub_vector(%arg0: vector<2xf32>, %arg1: vector<2xf32>) {
    %0 = llvm.fsub %arg0, %arg1 : vector<2xf32>
    llvm.return
  }
  llvm.func @fdiv_scalar(%arg0: f32, %arg1: f32) {
    %0 = llvm.fdiv %arg0, %arg1 : f32
    llvm.return
  }
  llvm.func @fdiv_vector(%arg0: vector<3xf64>, %arg1: vector<3xf64>) {
    %0 = llvm.fdiv %arg0, %arg1 : vector<3xf64>
    llvm.return
  }
  llvm.func @fmul_scalar(%arg0: f32, %arg1: f32) {
    %0 = llvm.fmul %arg0, %arg1 : f32
    llvm.return
  }
  llvm.func @fmul_vector(%arg0: vector<2xf32>, %arg1: vector<2xf32>) {
    %0 = llvm.fmul %arg0, %arg1 : vector<2xf32>
    llvm.return
  }
  llvm.func @frem_scalar(%arg0: f32, %arg1: f32) {
    %0 = llvm.frem %arg0, %arg1 : f32
    llvm.return
  }
  llvm.func @frem_vector(%arg0: vector<3xf64>, %arg1: vector<3xf64>) {
    %0 = llvm.frem %arg0, %arg1 : vector<3xf64>
    llvm.return
  }
  llvm.func @fneg_scalar(%arg0: f64) {
    %0 = llvm.fneg %arg0 : f64
    llvm.return
  }
  llvm.func @fneg_vector(%arg0: vector<2xf32>) {
    %0 = llvm.fneg %arg0 : vector<2xf32>
    llvm.return
  }
  llvm.func @udiv_scalar(%arg0: i32, %arg1: i32) {
    %0 = llvm.udiv %arg0, %arg1 : i32
    llvm.return
  }
  llvm.func @udiv_vector(%arg0: vector<3xi64>, %arg1: vector<3xi64>) {
    %0 = llvm.udiv %arg0, %arg1 : vector<3xi64>
    llvm.return
  }
  llvm.func @umod_scalar(%arg0: i32, %arg1: i32) {
    %0 = llvm.urem %arg0, %arg1 : i32
    llvm.return
  }
  llvm.func @umod_vector(%arg0: vector<3xi64>, %arg1: vector<3xi64>) {
    %0 = llvm.urem %arg0, %arg1 : vector<3xi64>
    llvm.return
  }
  llvm.func @sdiv_scalar(%arg0: i16, %arg1: i16) {
    %0 = llvm.sdiv %arg0, %arg1 : i16
    llvm.return
  }
  llvm.func @sdiv_vector(%arg0: vector<2xi64>, %arg1: vector<2xi64>) {
    %0 = llvm.sdiv %arg0, %arg1 : vector<2xi64>
    llvm.return
  }
  llvm.func @srem_scalar(%arg0: i32, %arg1: i32) {
    %0 = llvm.srem %arg0, %arg1 : i32
    llvm.return
  }
  llvm.func @srem_vector(%arg0: vector<4xi32>, %arg1: vector<4xi32>) {
    %0 = llvm.srem %arg0, %arg1 : vector<4xi32>
    llvm.return
  }
}

