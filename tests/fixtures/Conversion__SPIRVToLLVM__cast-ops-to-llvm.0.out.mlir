module {
  llvm.func @bitcast_float_to_integer_scalar(%arg0: f32) {
    %0 = llvm.bitcast %arg0 : f32 to i32
    llvm.return
  }
  llvm.func @bitcast_float_to_integer_vector(%arg0: vector<3xf32>) {
    %0 = llvm.bitcast %arg0 : vector<3xf32> to vector<3xi32>
    llvm.return
  }
  llvm.func @bitcast_vector_to_scalar(%arg0: vector<2xf32>) {
    %0 = llvm.bitcast %arg0 : vector<2xf32> to i64
    llvm.return
  }
  llvm.func @bitcast_scalar_to_vector(%arg0: f64) {
    %0 = llvm.bitcast %arg0 : f64 to vector<2xi32>
    llvm.return
  }
  llvm.func @bitcast_vector_to_vector(%arg0: vector<4xf32>) {
    %0 = llvm.bitcast %arg0 : vector<4xf32> to vector<2xi64>
    llvm.return
  }
  llvm.func @bitcast_pointer(%arg0: !llvm.ptr) {
    llvm.return
  }
  llvm.func @convert_float_to_signed_scalar(%arg0: f32) {
    %0 = llvm.fptosi %arg0 : f32 to i32
    llvm.return
  }
  llvm.func @convert_float_to_signed_vector(%arg0: vector<2xf32>) {
    %0 = llvm.fptosi %arg0 : vector<2xf32> to vector<2xi32>
    llvm.return
  }
  llvm.func @convert_float_to_unsigned_scalar(%arg0: f32) {
    %0 = llvm.fptoui %arg0 : f32 to i32
    llvm.return
  }
  llvm.func @convert_float_to_unsigned_vector(%arg0: vector<2xf32>) {
    %0 = llvm.fptoui %arg0 : vector<2xf32> to vector<2xi32>
    llvm.return
  }
  llvm.func @convert_signed_to_float_scalar(%arg0: i32) {
    %0 = llvm.sitofp %arg0 : i32 to f32
    llvm.return
  }
  llvm.func @convert_signed_to_float_vector(%arg0: vector<3xi32>) {
    %0 = llvm.sitofp %arg0 : vector<3xi32> to vector<3xf32>
    llvm.return
  }
  llvm.func @convert_unsigned_to_float_scalar(%arg0: i32) {
    %0 = llvm.uitofp %arg0 : i32 to f32
    llvm.return
  }
  llvm.func @convert_unsigned_to_float_vector(%arg0: vector<3xi32>) {
    %0 = llvm.uitofp %arg0 : vector<3xi32> to vector<3xf32>
    llvm.return
  }
  llvm.func @fconvert_scalar(%arg0: f32, %arg1: f64) {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fptrunc %arg1 : f64 to f32
    llvm.return
  }
  llvm.func @fconvert_vector(%arg0: vector<2xf32>, %arg1: vector<2xf64>) {
    %0 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %1 = llvm.fptrunc %arg1 : vector<2xf64> to vector<2xf32>
    llvm.return
  }
  llvm.func @sconvert_scalar(%arg0: i32, %arg1: i64) {
    %0 = llvm.sext %arg0 : i32 to i64
    %1 = llvm.trunc %arg1 : i64 to i32
    llvm.return
  }
  llvm.func @sconvert_vector(%arg0: vector<3xi32>, %arg1: vector<3xi64>) {
    %0 = llvm.sext %arg0 : vector<3xi32> to vector<3xi64>
    %1 = llvm.trunc %arg1 : vector<3xi64> to vector<3xi32>
    llvm.return
  }
  llvm.func @uconvert_scalar(%arg0: i32, %arg1: i64) {
    %0 = llvm.zext %arg0 : i32 to i64
    %1 = llvm.trunc %arg1 : i64 to i32
    llvm.return
  }
  llvm.func @uconvert_vector(%arg0: vector<3xi32>, %arg1: vector<3xi64>) {
    %0 = llvm.zext %arg0 : vector<3xi32> to vector<3xi64>
    %1 = llvm.trunc %arg1 : vector<3xi64> to vector<3xi32>
    llvm.return
  }
}

