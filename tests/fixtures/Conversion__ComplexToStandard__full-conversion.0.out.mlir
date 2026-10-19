module {
  llvm.func @complex_abs(%arg0: !llvm.struct<(f32, f32)>) -> f32 {
    %0 = llvm.extractvalue %arg0[0] : !llvm.struct<(f32, f32)> 
    %1 = llvm.extractvalue %arg0[1] : !llvm.struct<(f32, f32)> 
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.intr.fabs(%0) : (f32) -> f32
    %4 = llvm.intr.fabs(%1) : (f32) -> f32
    %5 = llvm.intr.maximum(%3, %4) : (f32, f32) -> f32
    %6 = llvm.intr.minimum(%3, %4) : (f32, f32) -> f32
    %7 = llvm.fdiv %6, %5 : f32
    %8 = llvm.fmul %7, %7 : f32
    %9 = llvm.fadd %8, %2 : f32
    %10 = llvm.intr.sqrt(%9) : (f32) -> f32
    %11 = llvm.fmul %5, %10 : f32
    %12 = llvm.fcmp "uno" %11, %11 : f32
    %13 = llvm.select %12, %6, %11 : i1, f32
    llvm.return %13 : f32
  }
  llvm.func @complex_eq(%arg0: !llvm.struct<(f32, f32)>, %arg1: !llvm.struct<(f32, f32)>) -> i1 {
    %0 = llvm.extractvalue %arg0[0] : !llvm.struct<(f32, f32)> 
    %1 = llvm.extractvalue %arg0[1] : !llvm.struct<(f32, f32)> 
    %2 = llvm.extractvalue %arg1[0] : !llvm.struct<(f32, f32)> 
    %3 = llvm.extractvalue %arg1[1] : !llvm.struct<(f32, f32)> 
    %4 = llvm.fcmp "oeq" %0, %2 : f32
    %5 = llvm.fcmp "oeq" %1, %3 : f32
    %6 = llvm.and %4, %5 : i1
    llvm.return %6 : i1
  }
  llvm.func @complex_neq(%arg0: !llvm.struct<(f32, f32)>, %arg1: !llvm.struct<(f32, f32)>) -> i1 {
    %0 = llvm.extractvalue %arg0[0] : !llvm.struct<(f32, f32)> 
    %1 = llvm.extractvalue %arg0[1] : !llvm.struct<(f32, f32)> 
    %2 = llvm.extractvalue %arg1[0] : !llvm.struct<(f32, f32)> 
    %3 = llvm.extractvalue %arg1[1] : !llvm.struct<(f32, f32)> 
    %4 = llvm.fcmp "une" %0, %2 : f32
    %5 = llvm.fcmp "une" %1, %3 : f32
    %6 = llvm.or %4, %5 : i1
    llvm.return %6 : i1
  }
}

