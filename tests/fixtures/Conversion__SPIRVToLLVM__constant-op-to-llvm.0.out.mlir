module {
  llvm.func @bool_constant_scalar() {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    llvm.return
  }
  llvm.func @bool_constant_vector() {
    %0 = llvm.mlir.constant(dense<[true, false]> : vector<2xi1>) : vector<2xi1>
    %1 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    llvm.return
  }
  llvm.func @integer_constant_scalar() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-5 : i64) : i64
    %2 = llvm.mlir.constant(10 : i16) : i16
    llvm.return
  }
  llvm.func @integer_constant_vector() {
    %0 = llvm.mlir.constant(dense<[2, 3]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-4> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[2, 3, 4]> : vector<3xi32>) : vector<3xi32>
    llvm.return
  }
  llvm.func @float_constant_scalar() {
    %0 = llvm.mlir.constant(5.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(5.000000e+00 : f64) : f64
    llvm.return
  }
  llvm.func @float_constant_vector() {
    %0 = llvm.mlir.constant(dense<[2.000000e+00, 3.000000e+00]> : vector<2xf32>) : vector<2xf32>
    llvm.return
  }
}

