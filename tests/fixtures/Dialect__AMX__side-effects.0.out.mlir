module {
  func.func @do_not_fold_tiles(%arg0: memref<2x32x32xbf16>, %arg1: memref<2x16x32xbf16>) -> memref<16x32xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<2x16x32xbf16> to !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<2x32x32xbf16> to !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %2 = builtin.unrealized_conversion_cast %c0 : index to i64
    %c2 = arith.constant 2 : index
    %c16 = arith.constant 16 : index
    %3 = builtin.unrealized_conversion_cast %c16 : index to i64
    %alloca = memref.alloca() : memref<16x32xf32>
    %4 = builtin.unrealized_conversion_cast %alloca : memref<16x32xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %5 = llvm.mlir.constant(16 : i16) : i16
    %6 = llvm.mlir.constant(64 : i16) : i16
    %7 = llvm.call_intrinsic "llvm.x86.tilezero.internal"(%5, %6) : (i16, i16) -> !llvm.x86_amx
    %8 = builtin.unrealized_conversion_cast %7 : !llvm.x86_amx to !amx.tile<16x16xf32>
    %9 = llvm.mlir.constant(16 : i16) : i16
    %10 = llvm.mlir.constant(64 : i16) : i16
    %11 = llvm.call_intrinsic "llvm.x86.tilezero.internal"(%9, %10) : (i16, i16) -> !llvm.x86_amx
    %12 = builtin.unrealized_conversion_cast %11 : !llvm.x86_amx to !amx.tile<16x16xf32>
    %13:2 = scf.for %arg2 = %c0 to %c2 step %c1 iter_args(%arg3 = %8, %arg4 = %12) -> (!amx.tile<16x16xf32>, !amx.tile<16x16xf32>) {
      %32 = builtin.unrealized_conversion_cast %arg4 : !amx.tile<16x16xf32> to !llvm.x86_amx
      %33 = builtin.unrealized_conversion_cast %arg3 : !amx.tile<16x16xf32> to !llvm.x86_amx
      %34 = builtin.unrealized_conversion_cast %arg2 : index to i64
      %35 = llvm.mlir.constant(16 : i16) : i16
      %36 = llvm.mlir.constant(64 : i16) : i16
      %37 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
      %38 = llvm.mlir.constant(1024 : index) : i64
      %39 = llvm.mul %34, %38 : i64
      %40 = llvm.mlir.constant(32 : index) : i64
      %41 = llvm.mul %2, %40 : i64
      %42 = llvm.add %39, %41 : i64
      %43 = llvm.add %42, %2 : i64
      %44 = llvm.getelementptr %37[%43] : (!llvm.ptr, i64) -> !llvm.ptr, bf16
      %45 = llvm.mlir.constant(64 : i64) : i64
      %46 = llvm.call_intrinsic "llvm.x86.tileloadd64.internal"(%35, %36, %44, %45) : (i16, i16, !llvm.ptr, i64) -> !llvm.x86_amx
      %47 = llvm.mlir.constant(16 : i16) : i16
      %48 = llvm.mlir.constant(64 : i16) : i16
      %49 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
      %50 = llvm.mlir.constant(1024 : index) : i64
      %51 = llvm.mul %34, %50 : i64
      %52 = llvm.mlir.constant(32 : index) : i64
      %53 = llvm.mul %3, %52 : i64
      %54 = llvm.add %51, %53 : i64
      %55 = llvm.add %54, %2 : i64
      %56 = llvm.getelementptr %49[%55] : (!llvm.ptr, i64) -> !llvm.ptr, bf16
      %57 = llvm.mlir.constant(64 : i64) : i64
      %58 = llvm.call_intrinsic "llvm.x86.tileloadd64.internal"(%47, %48, %56, %57) : (i16, i16, !llvm.ptr, i64) -> !llvm.x86_amx
      %59 = llvm.mlir.constant(16 : i16) : i16
      %60 = llvm.mlir.constant(64 : i16) : i16
      %61 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
      %62 = llvm.mlir.constant(512 : index) : i64
      %63 = llvm.mul %34, %62 : i64
      %64 = llvm.mlir.constant(32 : index) : i64
      %65 = llvm.mul %2, %64 : i64
      %66 = llvm.add %63, %65 : i64
      %67 = llvm.add %66, %2 : i64
      %68 = llvm.getelementptr %61[%67] : (!llvm.ptr, i64) -> !llvm.ptr, bf16
      %69 = llvm.mlir.constant(64 : i64) : i64
      %70 = llvm.call_intrinsic "llvm.x86.tileloadd64.internal"(%59, %60, %68, %69) : (i16, i16, !llvm.ptr, i64) -> !llvm.x86_amx
      %71 = llvm.mlir.constant(16 : i16) : i16
      %72 = llvm.mlir.constant(64 : i16) : i16
      %73 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
      %74 = llvm.mlir.constant(512 : index) : i64
      %75 = llvm.mul %34, %74 : i64
      %76 = llvm.mlir.constant(32 : index) : i64
      %77 = llvm.mul %2, %76 : i64
      %78 = llvm.add %75, %77 : i64
      %79 = llvm.add %78, %2 : i64
      %80 = llvm.getelementptr %73[%79] : (!llvm.ptr, i64) -> !llvm.ptr, bf16
      %81 = llvm.mlir.constant(64 : i64) : i64
      %82 = llvm.call_intrinsic "llvm.x86.tileloadd64.internal"(%71, %72, %80, %81) : (i16, i16, !llvm.ptr, i64) -> !llvm.x86_amx
      %83 = llvm.mlir.constant(16 : i16) : i16
      %84 = llvm.mlir.constant(64 : i16) : i16
      %85 = llvm.mlir.constant(16 : i16) : i16
      %86 = llvm.mlir.constant(64 : i16) : i16
      %87 = llvm.call_intrinsic "llvm.x86.tdpbf16ps.internal"(%83, %86, %84, %33, %46, %70) : (i16, i16, i16, !llvm.x86_amx, !llvm.x86_amx, !llvm.x86_amx) -> !llvm.x86_amx
      %88 = builtin.unrealized_conversion_cast %87 : !llvm.x86_amx to !amx.tile<16x16xf32>
      %89 = llvm.mlir.constant(16 : i16) : i16
      %90 = llvm.mlir.constant(64 : i16) : i16
      %91 = llvm.mlir.constant(16 : i16) : i16
      %92 = llvm.mlir.constant(64 : i16) : i16
      %93 = llvm.call_intrinsic "llvm.x86.tdpbf16ps.internal"(%89, %92, %90, %32, %58, %82) : (i16, i16, i16, !llvm.x86_amx, !llvm.x86_amx, !llvm.x86_amx) -> !llvm.x86_amx
      %94 = builtin.unrealized_conversion_cast %93 : !llvm.x86_amx to !amx.tile<16x16xf32>
      scf.yield %88, %94 : !amx.tile<16x16xf32>, !amx.tile<16x16xf32>
    }
    %14 = builtin.unrealized_conversion_cast %13#1 : !amx.tile<16x16xf32> to !llvm.x86_amx
    %15 = builtin.unrealized_conversion_cast %13#0 : !amx.tile<16x16xf32> to !llvm.x86_amx
    %16 = llvm.mlir.constant(16 : i16) : i16
    %17 = llvm.mlir.constant(64 : i16) : i16
    %18 = llvm.extractvalue %4[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %19 = llvm.mlir.constant(32 : index) : i64
    %20 = llvm.mul %2, %19 : i64
    %21 = llvm.add %20, %2 : i64
    %22 = llvm.getelementptr %18[%21] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %23 = llvm.mlir.constant(128 : i64) : i64
    llvm.call_intrinsic "llvm.x86.tilestored64.internal"(%16, %17, %22, %23, %15) : (i16, i16, !llvm.ptr, i64, !llvm.x86_amx) -> ()
    %24 = llvm.mlir.constant(16 : i16) : i16
    %25 = llvm.mlir.constant(64 : i16) : i16
    %26 = llvm.extractvalue %4[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %27 = llvm.mlir.constant(32 : index) : i64
    %28 = llvm.mul %2, %27 : i64
    %29 = llvm.add %28, %3 : i64
    %30 = llvm.getelementptr %26[%29] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %31 = llvm.mlir.constant(128 : i64) : i64
    llvm.call_intrinsic "llvm.x86.tilestored64.internal"(%24, %25, %30, %31, %14) : (i16, i16, !llvm.ptr, i64, !llvm.x86_amx) -> ()
    return %alloca : memref<16x32xf32>
  }
}

