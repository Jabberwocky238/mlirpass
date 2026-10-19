module {
  func.func @complex_create(%arg0: f32, %arg1: f32) -> complex<f32> {
    %0 = llvm.mlir.poison : !llvm.struct<(f32, f32)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(f32, f32)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(f32, f32)> 
    %3 = builtin.unrealized_conversion_cast %2 : !llvm.struct<(f32, f32)> to complex<f32>
    return %3 : complex<f32>
  }
  func.func @complex_constant() -> complex<f64> {
    %0 = llvm.mlir.constant([1.000000e+00, 2.000000e+00]) : !llvm.struct<(f64, f64)>
    %1 = builtin.unrealized_conversion_cast %0 : !llvm.struct<(f64, f64)> to complex<f64>
    return %1 : complex<f64>
  }
  func.func @complex_extract(%arg0: complex<f32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : complex<f32> to !llvm.struct<(f32, f32)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(f32, f32)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(f32, f32)> 
    return
  }
  func.func @complex_addition() {
    %cst = arith.constant 1.200000e+00 : f64
    %cst_0 = arith.constant 3.400000e+00 : f64
    %0 = llvm.mlir.poison : !llvm.struct<(f64, f64)>
    %1 = llvm.insertvalue %cst, %0[0] : !llvm.struct<(f64, f64)> 
    %2 = llvm.insertvalue %cst_0, %1[1] : !llvm.struct<(f64, f64)> 
    %cst_1 = arith.constant 5.600000e+00 : f64
    %cst_2 = arith.constant 7.7999999999999998 : f64
    %3 = llvm.mlir.poison : !llvm.struct<(f64, f64)>
    %4 = llvm.insertvalue %cst_1, %3[0] : !llvm.struct<(f64, f64)> 
    %5 = llvm.insertvalue %cst_2, %4[1] : !llvm.struct<(f64, f64)> 
    %6 = llvm.extractvalue %2[0] : !llvm.struct<(f64, f64)> 
    %7 = llvm.extractvalue %2[1] : !llvm.struct<(f64, f64)> 
    %8 = llvm.extractvalue %5[0] : !llvm.struct<(f64, f64)> 
    %9 = llvm.extractvalue %5[1] : !llvm.struct<(f64, f64)> 
    %10 = llvm.mlir.poison : !llvm.struct<(f64, f64)>
    %11 = llvm.fadd %6, %8 : f64
    %12 = llvm.fadd %7, %9 : f64
    %13 = llvm.insertvalue %11, %10[0] : !llvm.struct<(f64, f64)> 
    %14 = llvm.insertvalue %12, %13[1] : !llvm.struct<(f64, f64)> 
    return
  }
  func.func @complex_substraction() {
    %cst = arith.constant 1.200000e+00 : f64
    %cst_0 = arith.constant 3.400000e+00 : f64
    %0 = llvm.mlir.poison : !llvm.struct<(f64, f64)>
    %1 = llvm.insertvalue %cst, %0[0] : !llvm.struct<(f64, f64)> 
    %2 = llvm.insertvalue %cst_0, %1[1] : !llvm.struct<(f64, f64)> 
    %cst_1 = arith.constant 5.600000e+00 : f64
    %cst_2 = arith.constant 7.7999999999999998 : f64
    %3 = llvm.mlir.poison : !llvm.struct<(f64, f64)>
    %4 = llvm.insertvalue %cst_1, %3[0] : !llvm.struct<(f64, f64)> 
    %5 = llvm.insertvalue %cst_2, %4[1] : !llvm.struct<(f64, f64)> 
    %6 = llvm.extractvalue %2[0] : !llvm.struct<(f64, f64)> 
    %7 = llvm.extractvalue %2[1] : !llvm.struct<(f64, f64)> 
    %8 = llvm.extractvalue %5[0] : !llvm.struct<(f64, f64)> 
    %9 = llvm.extractvalue %5[1] : !llvm.struct<(f64, f64)> 
    %10 = llvm.mlir.poison : !llvm.struct<(f64, f64)>
    %11 = llvm.fsub %6, %8 : f64
    %12 = llvm.fsub %7, %9 : f64
    %13 = llvm.insertvalue %11, %10[0] : !llvm.struct<(f64, f64)> 
    %14 = llvm.insertvalue %12, %13[1] : !llvm.struct<(f64, f64)> 
    return
  }
  func.func @complex_div(%arg0: complex<f32>, %arg1: complex<f32>) -> complex<f32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : complex<f32> to !llvm.struct<(f32, f32)>
    %1 = builtin.unrealized_conversion_cast %arg0 : complex<f32> to !llvm.struct<(f32, f32)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(f32, f32)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(f32, f32)> 
    %4 = llvm.extractvalue %0[0] : !llvm.struct<(f32, f32)> 
    %5 = llvm.extractvalue %0[1] : !llvm.struct<(f32, f32)> 
    %6 = llvm.mlir.poison : !llvm.struct<(f32, f32)>
    %7 = llvm.fmul %4, %4 : f32
    %8 = llvm.fmul %5, %5 : f32
    %9 = llvm.fadd %7, %8 : f32
    %10 = llvm.fmul %2, %4 : f32
    %11 = llvm.fmul %3, %5 : f32
    %12 = llvm.fadd %10, %11 : f32
    %13 = llvm.fmul %3, %4 : f32
    %14 = llvm.fmul %2, %5 : f32
    %15 = llvm.fsub %13, %14 : f32
    %16 = llvm.fdiv %12, %9 : f32
    %17 = llvm.fdiv %15, %9 : f32
    %18 = llvm.insertvalue %16, %6[0] : !llvm.struct<(f32, f32)> 
    %19 = llvm.insertvalue %17, %18[1] : !llvm.struct<(f32, f32)> 
    %20 = builtin.unrealized_conversion_cast %19 : !llvm.struct<(f32, f32)> to complex<f32>
    return %20 : complex<f32>
  }
  func.func @complex_mul(%arg0: complex<f32>, %arg1: complex<f32>) -> complex<f32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : complex<f32> to !llvm.struct<(f32, f32)>
    %1 = builtin.unrealized_conversion_cast %arg0 : complex<f32> to !llvm.struct<(f32, f32)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(f32, f32)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(f32, f32)> 
    %4 = llvm.extractvalue %0[0] : !llvm.struct<(f32, f32)> 
    %5 = llvm.extractvalue %0[1] : !llvm.struct<(f32, f32)> 
    %6 = llvm.mlir.poison : !llvm.struct<(f32, f32)>
    %7 = llvm.fmul %4, %2 : f32
    %8 = llvm.fmul %5, %3 : f32
    %9 = llvm.fsub %7, %8 : f32
    %10 = llvm.fmul %3, %4 : f32
    %11 = llvm.fmul %2, %5 : f32
    %12 = llvm.fadd %10, %11 : f32
    %13 = llvm.insertvalue %9, %6[0] : !llvm.struct<(f32, f32)> 
    %14 = llvm.insertvalue %12, %13[1] : !llvm.struct<(f32, f32)> 
    %15 = builtin.unrealized_conversion_cast %14 : !llvm.struct<(f32, f32)> to complex<f32>
    return %15 : complex<f32>
  }
  func.func @complex_abs(%arg0: complex<f32>) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg0 : complex<f32> to !llvm.struct<(f32, f32)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(f32, f32)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(f32, f32)> 
    %3 = llvm.fmul %1, %1 : f32
    %4 = llvm.fmul %2, %2 : f32
    %5 = llvm.fadd %3, %4 : f32
    %6 = llvm.intr.sqrt(%5) : (f32) -> f32
    return %6 : f32
  }
  func.func @complex_addition_with_fmf() {
    %cst = arith.constant 1.200000e+00 : f64
    %cst_0 = arith.constant 3.400000e+00 : f64
    %0 = llvm.mlir.poison : !llvm.struct<(f64, f64)>
    %1 = llvm.insertvalue %cst, %0[0] : !llvm.struct<(f64, f64)> 
    %2 = llvm.insertvalue %cst_0, %1[1] : !llvm.struct<(f64, f64)> 
    %cst_1 = arith.constant 5.600000e+00 : f64
    %cst_2 = arith.constant 7.7999999999999998 : f64
    %3 = llvm.mlir.poison : !llvm.struct<(f64, f64)>
    %4 = llvm.insertvalue %cst_1, %3[0] : !llvm.struct<(f64, f64)> 
    %5 = llvm.insertvalue %cst_2, %4[1] : !llvm.struct<(f64, f64)> 
    %6 = llvm.extractvalue %2[0] : !llvm.struct<(f64, f64)> 
    %7 = llvm.extractvalue %2[1] : !llvm.struct<(f64, f64)> 
    %8 = llvm.extractvalue %5[0] : !llvm.struct<(f64, f64)> 
    %9 = llvm.extractvalue %5[1] : !llvm.struct<(f64, f64)> 
    %10 = llvm.mlir.poison : !llvm.struct<(f64, f64)>
    %11 = llvm.fadd %6, %8 {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %12 = llvm.fadd %7, %9 {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %13 = llvm.insertvalue %11, %10[0] : !llvm.struct<(f64, f64)> 
    %14 = llvm.insertvalue %12, %13[1] : !llvm.struct<(f64, f64)> 
    return
  }
  func.func @complex_substraction_with_fmf() {
    %cst = arith.constant 1.200000e+00 : f64
    %cst_0 = arith.constant 3.400000e+00 : f64
    %0 = llvm.mlir.poison : !llvm.struct<(f64, f64)>
    %1 = llvm.insertvalue %cst, %0[0] : !llvm.struct<(f64, f64)> 
    %2 = llvm.insertvalue %cst_0, %1[1] : !llvm.struct<(f64, f64)> 
    %cst_1 = arith.constant 5.600000e+00 : f64
    %cst_2 = arith.constant 7.7999999999999998 : f64
    %3 = llvm.mlir.poison : !llvm.struct<(f64, f64)>
    %4 = llvm.insertvalue %cst_1, %3[0] : !llvm.struct<(f64, f64)> 
    %5 = llvm.insertvalue %cst_2, %4[1] : !llvm.struct<(f64, f64)> 
    %6 = llvm.extractvalue %2[0] : !llvm.struct<(f64, f64)> 
    %7 = llvm.extractvalue %2[1] : !llvm.struct<(f64, f64)> 
    %8 = llvm.extractvalue %5[0] : !llvm.struct<(f64, f64)> 
    %9 = llvm.extractvalue %5[1] : !llvm.struct<(f64, f64)> 
    %10 = llvm.mlir.poison : !llvm.struct<(f64, f64)>
    %11 = llvm.fsub %6, %8 {fastmathFlags = #llvm.fastmath<nnan, ninf>} : f64
    %12 = llvm.fsub %7, %9 {fastmathFlags = #llvm.fastmath<nnan, ninf>} : f64
    %13 = llvm.insertvalue %11, %10[0] : !llvm.struct<(f64, f64)> 
    %14 = llvm.insertvalue %12, %13[1] : !llvm.struct<(f64, f64)> 
    return
  }
  func.func @complex_div_with_fmf(%arg0: complex<f32>, %arg1: complex<f32>) -> complex<f32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : complex<f32> to !llvm.struct<(f32, f32)>
    %1 = builtin.unrealized_conversion_cast %arg0 : complex<f32> to !llvm.struct<(f32, f32)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(f32, f32)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(f32, f32)> 
    %4 = llvm.extractvalue %0[0] : !llvm.struct<(f32, f32)> 
    %5 = llvm.extractvalue %0[1] : !llvm.struct<(f32, f32)> 
    %6 = llvm.mlir.poison : !llvm.struct<(f32, f32)>
    %7 = llvm.fmul %4, %4 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %8 = llvm.fmul %5, %5 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %9 = llvm.fadd %7, %8 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %10 = llvm.fmul %2, %4 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %11 = llvm.fmul %3, %5 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %12 = llvm.fadd %10, %11 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %13 = llvm.fmul %3, %4 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %14 = llvm.fmul %2, %5 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %15 = llvm.fsub %13, %14 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %16 = llvm.fdiv %12, %9 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %17 = llvm.fdiv %15, %9 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %18 = llvm.insertvalue %16, %6[0] : !llvm.struct<(f32, f32)> 
    %19 = llvm.insertvalue %17, %18[1] : !llvm.struct<(f32, f32)> 
    %20 = builtin.unrealized_conversion_cast %19 : !llvm.struct<(f32, f32)> to complex<f32>
    return %20 : complex<f32>
  }
  func.func @complex_mul_with_fmf(%arg0: complex<f32>, %arg1: complex<f32>) -> complex<f32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : complex<f32> to !llvm.struct<(f32, f32)>
    %1 = builtin.unrealized_conversion_cast %arg0 : complex<f32> to !llvm.struct<(f32, f32)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(f32, f32)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(f32, f32)> 
    %4 = llvm.extractvalue %0[0] : !llvm.struct<(f32, f32)> 
    %5 = llvm.extractvalue %0[1] : !llvm.struct<(f32, f32)> 
    %6 = llvm.mlir.poison : !llvm.struct<(f32, f32)>
    %7 = llvm.fmul %4, %2 {fastmathFlags = #llvm.fastmath<contract, afn>} : f32
    %8 = llvm.fmul %5, %3 {fastmathFlags = #llvm.fastmath<contract, afn>} : f32
    %9 = llvm.fsub %7, %8 {fastmathFlags = #llvm.fastmath<contract, afn>} : f32
    %10 = llvm.fmul %3, %4 {fastmathFlags = #llvm.fastmath<contract, afn>} : f32
    %11 = llvm.fmul %2, %5 {fastmathFlags = #llvm.fastmath<contract, afn>} : f32
    %12 = llvm.fadd %10, %11 {fastmathFlags = #llvm.fastmath<contract, afn>} : f32
    %13 = llvm.insertvalue %9, %6[0] : !llvm.struct<(f32, f32)> 
    %14 = llvm.insertvalue %12, %13[1] : !llvm.struct<(f32, f32)> 
    %15 = builtin.unrealized_conversion_cast %14 : !llvm.struct<(f32, f32)> to complex<f32>
    return %15 : complex<f32>
  }
  func.func @complex_abs_with_fmf(%arg0: complex<f32>) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg0 : complex<f32> to !llvm.struct<(f32, f32)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(f32, f32)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(f32, f32)> 
    %3 = llvm.fmul %1, %1 {fastmathFlags = #llvm.fastmath<contract>} : f32
    %4 = llvm.fmul %2, %2 {fastmathFlags = #llvm.fastmath<contract>} : f32
    %5 = llvm.fadd %3, %4 {fastmathFlags = #llvm.fastmath<contract>} : f32
    %6 = llvm.intr.sqrt(%5) : (f32) -> f32
    return %6 : f32
  }
}

