module {
  func.func @test_dpp(%arg0: i32, %arg1: i32) -> i32 {
    %0 = rocdl.update.dpp %arg0, %arg1 with 257, 10, 15, false : i32
    return %0 : i32
  }
  func.func @quad_dpp(%arg0: i32, %arg1: i32) -> i32 {
    %0 = rocdl.update.dpp %arg0, %arg1 with 145, 1, 1, true : i32
    return %0 : i32
  }
  func.func @wave_shr_dpp(%arg0: i32, %arg1: i32) -> i32 {
    %0 = rocdl.update.dpp %arg0, %arg1 with 312, 10, 1, true : i32
    return %0 : i32
  }
  func.func @row_half_mirror_update_dpp(%arg0: i32, %arg1: i32) -> i32 {
    %0 = rocdl.update.dpp %arg0, %arg1 with 321, 15, 1, false : i32
    return %0 : i32
  }
  func.func @wave_rol_update_dpp(%arg0: i32, %arg1: i32) -> i32 {
    %0 = rocdl.update.dpp %arg0, %arg1 with 308, 10, 1, false : i32
    return %0 : i32
  }
  func.func @row_bcast_dpp_f32(%arg0: f32, %arg1: f32) -> f32 {
    %0 = rocdl.update.dpp %arg0, %arg1 with 322, 15, 15, true : f32
    return %0 : f32
  }
  func.func @test_dpp_f32(%arg0: f32, %arg1: f32) -> f32 {
    %0 = rocdl.update.dpp %arg0, %arg1 with 320, 1, 4, true : f32
    return %0 : f32
  }
  func.func @quad_perm_update_dpp_f32(%arg0: f32, %arg1: f32) -> f32 {
    %0 = rocdl.update.dpp %arg0, %arg1 with 88, 15, 1, false : f32
    return %0 : f32
  }
  func.func @quad_perm_dpp(%arg0: i64, %arg1: i64) -> i64 {
    %0 = rocdl.update.dpp %arg0, %arg1 with 88, 15, 15, false : i64
    return %0 : i64
  }
  func.func @row_bcast_dpp(%arg0: f64, %arg1: f64) -> f64 {
    %0 = rocdl.update.dpp %arg0, %arg1 with 323, 4, 1, false : f64
    return %0 : f64
  }
  func.func @test_dpp_f16(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.bitcast %arg1 : f16 to i16
    %1 = llvm.mlir.undef : vector<2xi16>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : vector<2xi16>
    %4 = llvm.bitcast %3 : vector<2xi16> to i32
    %5 = llvm.bitcast %arg0 : f16 to i16
    %6 = llvm.mlir.undef : vector<2xi16>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.insertelement %5, %6[%7 : i32] : vector<2xi16>
    %9 = llvm.bitcast %8 : vector<2xi16> to i32
    %10 = rocdl.update.dpp %9, %4 with 273, 15, 3, false : i32
    %11 = llvm.trunc %10 : i32 to i16
    %12 = llvm.bitcast %11 : i16 to f16
    return %12 : f16
  }
  func.func @row_shl_dpp_i16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.undef : vector<2xi16>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg1, %0[%1 : i32] : vector<2xi16>
    %3 = llvm.bitcast %2 : vector<2xi16> to i32
    %4 = llvm.mlir.undef : vector<2xi16>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %arg0, %4[%5 : i32] : vector<2xi16>
    %7 = llvm.bitcast %6 : vector<2xi16> to i32
    %8 = rocdl.update.dpp %7, %3 with 298, 10, 1, false : i32
    %9 = llvm.trunc %8 : i32 to i16
    return %9 : i16
  }
  func.func @row_bcast_update_dpp_f16(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.bitcast %arg1 : f16 to i16
    %1 = llvm.mlir.undef : vector<2xi16>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : vector<2xi16>
    %4 = llvm.bitcast %3 : vector<2xi16> to i32
    %5 = llvm.bitcast %arg0 : f16 to i16
    %6 = llvm.mlir.undef : vector<2xi16>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.insertelement %5, %6[%7 : i32] : vector<2xi16>
    %9 = llvm.bitcast %8 : vector<2xi16> to i32
    %10 = rocdl.update.dpp %9, %4 with 322, 15, 15, true : i32
    %11 = llvm.trunc %10 : i32 to i16
    %12 = llvm.bitcast %11 : i16 to f16
    return %12 : f16
  }
}

