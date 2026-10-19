module {
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
}

