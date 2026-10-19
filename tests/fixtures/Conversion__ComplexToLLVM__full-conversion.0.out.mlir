module {
  llvm.func @complex_div(%arg0: !llvm.struct<(f32, f32)>, %arg1: !llvm.struct<(f32, f32)>) -> !llvm.struct<(f32, f32)> {
    %0 = llvm.extractvalue %arg0[0] : !llvm.struct<(f32, f32)> 
    %1 = llvm.extractvalue %arg0[1] : !llvm.struct<(f32, f32)> 
    %2 = llvm.extractvalue %arg1[0] : !llvm.struct<(f32, f32)> 
    %3 = llvm.extractvalue %arg1[1] : !llvm.struct<(f32, f32)> 
    %4 = llvm.mlir.poison : !llvm.struct<(f32, f32)>
    %5 = llvm.fmul %2, %2 : f32
    %6 = llvm.fmul %3, %3 : f32
    %7 = llvm.fadd %5, %6 : f32
    %8 = llvm.fmul %0, %2 : f32
    %9 = llvm.fmul %1, %3 : f32
    %10 = llvm.fadd %8, %9 : f32
    %11 = llvm.fmul %1, %2 : f32
    %12 = llvm.fmul %0, %3 : f32
    %13 = llvm.fsub %11, %12 : f32
    %14 = llvm.fdiv %10, %7 : f32
    %15 = llvm.fdiv %13, %7 : f32
    %16 = llvm.insertvalue %14, %4[0] : !llvm.struct<(f32, f32)> 
    %17 = llvm.insertvalue %15, %16[1] : !llvm.struct<(f32, f32)> 
    llvm.return %17 : !llvm.struct<(f32, f32)>
  }
  llvm.func @complex_mul(%arg0: !llvm.struct<(f32, f32)>, %arg1: !llvm.struct<(f32, f32)>) -> !llvm.struct<(f32, f32)> {
    %0 = llvm.extractvalue %arg0[0] : !llvm.struct<(f32, f32)> 
    %1 = llvm.extractvalue %arg0[1] : !llvm.struct<(f32, f32)> 
    %2 = llvm.extractvalue %arg1[0] : !llvm.struct<(f32, f32)> 
    %3 = llvm.extractvalue %arg1[1] : !llvm.struct<(f32, f32)> 
    %4 = llvm.mlir.poison : !llvm.struct<(f32, f32)>
    %5 = llvm.fmul %2, %0 : f32
    %6 = llvm.fmul %3, %1 : f32
    %7 = llvm.fsub %5, %6 : f32
    %8 = llvm.fmul %1, %2 : f32
    %9 = llvm.fmul %0, %3 : f32
    %10 = llvm.fadd %8, %9 : f32
    %11 = llvm.insertvalue %7, %4[0] : !llvm.struct<(f32, f32)> 
    %12 = llvm.insertvalue %10, %11[1] : !llvm.struct<(f32, f32)> 
    llvm.return %12 : !llvm.struct<(f32, f32)>
  }
  llvm.func @complex_abs(%arg0: !llvm.struct<(f32, f32)>) -> f32 {
    %0 = llvm.extractvalue %arg0[0] : !llvm.struct<(f32, f32)> 
    %1 = llvm.extractvalue %arg0[1] : !llvm.struct<(f32, f32)> 
    %2 = llvm.fmul %0, %0 : f32
    %3 = llvm.fmul %1, %1 : f32
    %4 = llvm.fadd %2, %3 : f32
    %5 = llvm.intr.sqrt(%4) : (f32) -> f32
    llvm.return %5 : f32
  }
}

