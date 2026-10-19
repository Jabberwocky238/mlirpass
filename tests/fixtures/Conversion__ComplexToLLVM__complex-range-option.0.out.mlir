module {
  func.func @complex_div(%arg0: complex<f32>, %arg1: complex<f32>) -> complex<f32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : complex<f32> to !llvm.struct<(f32, f32)>
    %1 = builtin.unrealized_conversion_cast %arg0 : complex<f32> to !llvm.struct<(f32, f32)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(f32, f32)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(f32, f32)> 
    %4 = llvm.extractvalue %0[0] : !llvm.struct<(f32, f32)> 
    %5 = llvm.extractvalue %0[1] : !llvm.struct<(f32, f32)> 
    %6 = llvm.mlir.poison : !llvm.struct<(f32, f32)>
    %7 = llvm.fdiv %4, %5 : f32
    %8 = llvm.fmul %7, %4 : f32
    %9 = llvm.fadd %5, %8 : f32
    %10 = llvm.fmul %2, %7 : f32
    %11 = llvm.fadd %10, %3 : f32
    %12 = llvm.fdiv %11, %9 : f32
    %13 = llvm.fmul %3, %7 : f32
    %14 = llvm.fsub %13, %2 : f32
    %15 = llvm.fdiv %14, %9 : f32
    %16 = llvm.fdiv %5, %4 : f32
    %17 = llvm.fmul %16, %5 : f32
    %18 = llvm.fadd %4, %17 : f32
    %19 = llvm.fmul %3, %16 : f32
    %20 = llvm.fadd %2, %19 : f32
    %21 = llvm.fdiv %20, %18 : f32
    %22 = llvm.fmul %2, %16 : f32
    %23 = llvm.fsub %3, %22 : f32
    %24 = llvm.fdiv %23, %18 : f32
    %25 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %26 = llvm.intr.fabs(%4) : (f32) -> f32
    %27 = llvm.fcmp "oeq" %26, %25 : f32
    %28 = llvm.intr.fabs(%5) : (f32) -> f32
    %29 = llvm.fcmp "oeq" %28, %25 : f32
    %30 = llvm.fcmp "ord" %2, %25 : f32
    %31 = llvm.fcmp "ord" %3, %25 : f32
    %32 = llvm.or %30, %31 : i1
    %33 = llvm.and %27, %29 : i1
    %34 = llvm.and %32, %33 : i1
    %35 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %36 = llvm.intr.copysign(%35, %4) : (f32, f32) -> f32
    %37 = llvm.fmul %36, %2 : f32
    %38 = llvm.fmul %36, %3 : f32
    %39 = llvm.fcmp "one" %26, %35 : f32
    %40 = llvm.fcmp "one" %28, %35 : f32
    %41 = llvm.and %39, %40 : i1
    %42 = llvm.intr.fabs(%2) : (f32) -> f32
    %43 = llvm.fcmp "oeq" %42, %35 : f32
    %44 = llvm.intr.fabs(%3) : (f32) -> f32
    %45 = llvm.fcmp "oeq" %44, %35 : f32
    %46 = llvm.or %43, %45 : i1
    %47 = llvm.and %46, %41 : i1
    %48 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %49 = llvm.select %43, %48, %25 : i1, f32
    %50 = llvm.intr.copysign(%49, %2) : (f32, f32) -> f32
    %51 = llvm.select %45, %48, %25 : i1, f32
    %52 = llvm.intr.copysign(%51, %3) : (f32, f32) -> f32
    %53 = llvm.fmul %50, %4 : f32
    %54 = llvm.fmul %52, %5 : f32
    %55 = llvm.fadd %53, %54 : f32
    %56 = llvm.fmul %35, %55 : f32
    %57 = llvm.fmul %50, %5 : f32
    %58 = llvm.fmul %52, %4 : f32
    %59 = llvm.fsub %58, %57 : f32
    %60 = llvm.fmul %35, %59 : f32
    %61 = llvm.fcmp "one" %42, %35 : f32
    %62 = llvm.fcmp "one" %44, %35 : f32
    %63 = llvm.and %61, %62 : i1
    %64 = llvm.fcmp "oeq" %26, %35 : f32
    %65 = llvm.fcmp "oeq" %28, %35 : f32
    %66 = llvm.or %64, %65 : i1
    %67 = llvm.and %63, %66 : i1
    %68 = llvm.select %64, %48, %25 : i1, f32
    %69 = llvm.intr.copysign(%68, %4) : (f32, f32) -> f32
    %70 = llvm.select %65, %48, %25 : i1, f32
    %71 = llvm.intr.copysign(%70, %5) : (f32, f32) -> f32
    %72 = llvm.fmul %2, %69 : f32
    %73 = llvm.fmul %3, %71 : f32
    %74 = llvm.fadd %72, %73 : f32
    %75 = llvm.fmul %25, %74 : f32
    %76 = llvm.fmul %3, %69 : f32
    %77 = llvm.fmul %2, %71 : f32
    %78 = llvm.fsub %76, %77 : f32
    %79 = llvm.fmul %25, %78 : f32
    %80 = llvm.fcmp "olt" %26, %28 : f32
    %81 = llvm.select %80, %12, %21 : i1, f32
    %82 = llvm.select %80, %15, %24 : i1, f32
    %83 = llvm.select %67, %75, %81 : i1, f32
    %84 = llvm.select %67, %79, %82 : i1, f32
    %85 = llvm.select %47, %56, %83 : i1, f32
    %86 = llvm.select %47, %60, %84 : i1, f32
    %87 = llvm.select %34, %37, %85 : i1, f32
    %88 = llvm.select %34, %38, %86 : i1, f32
    %89 = llvm.fcmp "uno" %81, %25 : f32
    %90 = llvm.fcmp "uno" %82, %25 : f32
    %91 = llvm.and %89, %90 : i1
    %92 = llvm.select %91, %87, %81 : i1, f32
    %93 = llvm.select %91, %88, %82 : i1, f32
    %94 = llvm.insertvalue %92, %6[0] : !llvm.struct<(f32, f32)> 
    %95 = llvm.insertvalue %93, %94[1] : !llvm.struct<(f32, f32)> 
    %96 = builtin.unrealized_conversion_cast %95 : !llvm.struct<(f32, f32)> to complex<f32>
    return %96 : complex<f32>
  }
  func.func @complex_div_with_fmf(%arg0: complex<f32>, %arg1: complex<f32>) -> complex<f32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : complex<f32> to !llvm.struct<(f32, f32)>
    %1 = builtin.unrealized_conversion_cast %arg0 : complex<f32> to !llvm.struct<(f32, f32)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(f32, f32)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(f32, f32)> 
    %4 = llvm.extractvalue %0[0] : !llvm.struct<(f32, f32)> 
    %5 = llvm.extractvalue %0[1] : !llvm.struct<(f32, f32)> 
    %6 = llvm.mlir.poison : !llvm.struct<(f32, f32)>
    %7 = llvm.fdiv %4, %5 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %8 = llvm.fmul %7, %4 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %9 = llvm.fadd %5, %8 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %10 = llvm.fmul %2, %7 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %11 = llvm.fadd %10, %3 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %12 = llvm.fdiv %11, %9 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %13 = llvm.fmul %3, %7 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %14 = llvm.fsub %13, %2 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %15 = llvm.fdiv %14, %9 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %16 = llvm.fdiv %5, %4 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %17 = llvm.fmul %16, %5 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %18 = llvm.fadd %4, %17 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %19 = llvm.fmul %3, %16 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %20 = llvm.fadd %2, %19 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %21 = llvm.fdiv %20, %18 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %22 = llvm.fmul %2, %16 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %23 = llvm.fsub %3, %22 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %24 = llvm.fdiv %23, %18 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %25 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %26 = llvm.intr.fabs(%4) {fastmathFlags = #llvm.fastmath<nsz, arcp>} : (f32) -> f32
    %27 = llvm.fcmp "oeq" %26, %25 : f32
    %28 = llvm.intr.fabs(%5) {fastmathFlags = #llvm.fastmath<nsz, arcp>} : (f32) -> f32
    %29 = llvm.fcmp "oeq" %28, %25 : f32
    %30 = llvm.fcmp "ord" %2, %25 : f32
    %31 = llvm.fcmp "ord" %3, %25 : f32
    %32 = llvm.or %30, %31 : i1
    %33 = llvm.and %27, %29 : i1
    %34 = llvm.and %32, %33 : i1
    %35 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %36 = llvm.intr.copysign(%35, %4) : (f32, f32) -> f32
    %37 = llvm.fmul %36, %2 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %38 = llvm.fmul %36, %3 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %39 = llvm.fcmp "one" %26, %35 : f32
    %40 = llvm.fcmp "one" %28, %35 : f32
    %41 = llvm.and %39, %40 : i1
    %42 = llvm.intr.fabs(%2) {fastmathFlags = #llvm.fastmath<nsz, arcp>} : (f32) -> f32
    %43 = llvm.fcmp "oeq" %42, %35 : f32
    %44 = llvm.intr.fabs(%3) {fastmathFlags = #llvm.fastmath<nsz, arcp>} : (f32) -> f32
    %45 = llvm.fcmp "oeq" %44, %35 : f32
    %46 = llvm.or %43, %45 : i1
    %47 = llvm.and %46, %41 : i1
    %48 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %49 = llvm.select %43, %48, %25 : i1, f32
    %50 = llvm.intr.copysign(%49, %2) : (f32, f32) -> f32
    %51 = llvm.select %45, %48, %25 : i1, f32
    %52 = llvm.intr.copysign(%51, %3) : (f32, f32) -> f32
    %53 = llvm.fmul %50, %4 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %54 = llvm.fmul %52, %5 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %55 = llvm.fadd %53, %54 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %56 = llvm.fmul %35, %55 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %57 = llvm.fmul %50, %5 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %58 = llvm.fmul %52, %4 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %59 = llvm.fsub %58, %57 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %60 = llvm.fmul %35, %59 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %61 = llvm.fcmp "one" %42, %35 : f32
    %62 = llvm.fcmp "one" %44, %35 : f32
    %63 = llvm.and %61, %62 : i1
    %64 = llvm.fcmp "oeq" %26, %35 : f32
    %65 = llvm.fcmp "oeq" %28, %35 : f32
    %66 = llvm.or %64, %65 : i1
    %67 = llvm.and %63, %66 : i1
    %68 = llvm.select %64, %48, %25 : i1, f32
    %69 = llvm.intr.copysign(%68, %4) : (f32, f32) -> f32
    %70 = llvm.select %65, %48, %25 : i1, f32
    %71 = llvm.intr.copysign(%70, %5) : (f32, f32) -> f32
    %72 = llvm.fmul %2, %69 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %73 = llvm.fmul %3, %71 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %74 = llvm.fadd %72, %73 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %75 = llvm.fmul %25, %74 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %76 = llvm.fmul %3, %69 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %77 = llvm.fmul %2, %71 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %78 = llvm.fsub %76, %77 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %79 = llvm.fmul %25, %78 {fastmathFlags = #llvm.fastmath<nsz, arcp>} : f32
    %80 = llvm.fcmp "olt" %26, %28 : f32
    %81 = llvm.select %80, %12, %21 : i1, f32
    %82 = llvm.select %80, %15, %24 : i1, f32
    %83 = llvm.select %67, %75, %81 : i1, f32
    %84 = llvm.select %67, %79, %82 : i1, f32
    %85 = llvm.select %47, %56, %83 : i1, f32
    %86 = llvm.select %47, %60, %84 : i1, f32
    %87 = llvm.select %34, %37, %85 : i1, f32
    %88 = llvm.select %34, %38, %86 : i1, f32
    %89 = llvm.fcmp "uno" %81, %25 : f32
    %90 = llvm.fcmp "uno" %82, %25 : f32
    %91 = llvm.and %89, %90 : i1
    %92 = llvm.select %91, %87, %81 : i1, f32
    %93 = llvm.select %91, %88, %82 : i1, f32
    %94 = llvm.insertvalue %92, %6[0] : !llvm.struct<(f32, f32)> 
    %95 = llvm.insertvalue %93, %94[1] : !llvm.struct<(f32, f32)> 
    %96 = builtin.unrealized_conversion_cast %95 : !llvm.struct<(f32, f32)> to complex<f32>
    return %96 : complex<f32>
  }
}

