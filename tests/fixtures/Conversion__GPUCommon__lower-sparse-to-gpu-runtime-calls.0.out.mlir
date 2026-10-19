module attributes {gpu.container_module} {
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.func @matvec(%arg0: i64) {
    %0 = llvm.call @mgpuStreamCreate() : () -> !llvm.ptr
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.getelementptr %2[%arg0] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i64
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.mlir.constant(0 : i8) : i8
    %7 = llvm.call @mgpuMemAlloc(%4, %0, %6) : (i64, !llvm.ptr, i8) -> !llvm.ptr
    %8 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.insertvalue %7, %9[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.mlir.constant(0 : index) : i64
    %12 = llvm.insertvalue %11, %10[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.insertvalue %arg0, %12[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.insertvalue %1, %13[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.mlir.constant(1 : index) : i64
    %16 = llvm.mlir.zero : !llvm.ptr
    %17 = llvm.getelementptr %16[%arg0] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %18 = llvm.ptrtoint %17 : !llvm.ptr to i64
    %19 = llvm.mlir.zero : !llvm.ptr
    %20 = llvm.mlir.constant(0 : i8) : i8
    %21 = llvm.call @mgpuMemAlloc(%18, %0, %20) : (i64, !llvm.ptr, i8) -> !llvm.ptr
    %22 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %23 = llvm.insertvalue %21, %22[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %24 = llvm.insertvalue %21, %23[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %25 = llvm.mlir.constant(0 : index) : i64
    %26 = llvm.insertvalue %25, %24[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %27 = llvm.insertvalue %arg0, %26[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %28 = llvm.insertvalue %15, %27[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %29 = llvm.extractvalue %14[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %30 = llvm.extractvalue %14[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %31 = llvm.extractvalue %28[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %32 = llvm.mlir.constant(3 : i32) : i32
    %33 = llvm.mlir.constant(1 : i32) : i32
    %34 = llvm.call @mgpuCreateCoo(%arg0, %arg0, %arg0, %29, %30, %31, %32, %33, %0) : (i64, i64, i64, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, !llvm.ptr) -> !llvm.ptr
    %35 = llvm.extractvalue %28[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %36 = llvm.mlir.constant(1 : i32) : i32
    %37 = llvm.call @mgpuCreateDnVec(%arg0, %35, %36, %0) : (i64, !llvm.ptr, i32, !llvm.ptr) -> !llvm.ptr
    %38 = llvm.mlir.constant(0 : i32) : i32
    %39 = llvm.mlir.constant(1 : i32) : i32
    %40 = llvm.call @mgpuSpMVBufferSize(%38, %34, %37, %37, %39, %0) : (i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, !llvm.ptr) -> i64
    %41 = llvm.mlir.constant(0 : i32) : i32
    %42 = llvm.mlir.constant(1 : i32) : i32
    %43 = llvm.extractvalue %28[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.call @mgpuSpMV(%41, %34, %37, %37, %42, %43, %0) : (i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, !llvm.ptr, !llvm.ptr) -> ()
    llvm.call @mgpuDestroySpMat(%34, %0) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.call @mgpuDestroyDnVec(%37, %0) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.call @mgpuStreamSynchronize(%0) : (!llvm.ptr) -> ()
    llvm.call @mgpuStreamDestroy(%0) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @matmul(%arg0: i64) {
    %0 = llvm.call @mgpuStreamCreate() : () -> !llvm.ptr
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.getelementptr %2[%arg0] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i64
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.mlir.constant(0 : i8) : i8
    %7 = llvm.call @mgpuMemAlloc(%4, %0, %6) : (i64, !llvm.ptr, i8) -> !llvm.ptr
    %8 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.insertvalue %7, %9[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.mlir.constant(0 : index) : i64
    %12 = llvm.insertvalue %11, %10[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.insertvalue %arg0, %12[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.insertvalue %1, %13[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.mlir.constant(1 : index) : i64
    %16 = llvm.mlir.zero : !llvm.ptr
    %17 = llvm.getelementptr %16[%arg0] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %18 = llvm.ptrtoint %17 : !llvm.ptr to i64
    %19 = llvm.mlir.zero : !llvm.ptr
    %20 = llvm.mlir.constant(0 : i8) : i8
    %21 = llvm.call @mgpuMemAlloc(%18, %0, %20) : (i64, !llvm.ptr, i8) -> !llvm.ptr
    %22 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %23 = llvm.insertvalue %21, %22[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %24 = llvm.insertvalue %21, %23[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %25 = llvm.mlir.constant(0 : index) : i64
    %26 = llvm.insertvalue %25, %24[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %27 = llvm.insertvalue %arg0, %26[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %28 = llvm.insertvalue %15, %27[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %29 = llvm.extractvalue %14[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %30 = llvm.extractvalue %14[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %31 = llvm.extractvalue %28[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %32 = llvm.mlir.constant(3 : i32) : i32
    %33 = llvm.mlir.constant(3 : i32) : i32
    %34 = llvm.mlir.constant(1 : i32) : i32
    %35 = llvm.call @mgpuCreateCsr(%arg0, %arg0, %arg0, %29, %30, %31, %32, %33, %34, %0) : (i64, i64, i64, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, !llvm.ptr) -> !llvm.ptr
    %36 = llvm.extractvalue %28[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %37 = llvm.mlir.constant(1 : i32) : i32
    %38 = llvm.call @mgpuCreateDnMat(%arg0, %arg0, %36, %37, %0) : (i64, i64, !llvm.ptr, i32, !llvm.ptr) -> !llvm.ptr
    %39 = llvm.mlir.constant(0 : i32) : i32
    %40 = llvm.mlir.constant(0 : i32) : i32
    %41 = llvm.mlir.constant(1 : i32) : i32
    %42 = llvm.call @mgpuSpMMBufferSize(%39, %40, %35, %38, %38, %41, %0) : (i32, i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, !llvm.ptr) -> i64
    %43 = llvm.mlir.constant(0 : i32) : i32
    %44 = llvm.mlir.constant(0 : i32) : i32
    %45 = llvm.mlir.constant(1 : i32) : i32
    %46 = llvm.extractvalue %28[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.call @mgpuSpMM(%43, %44, %35, %38, %38, %45, %46, %0) : (i32, i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, !llvm.ptr, !llvm.ptr) -> ()
    llvm.call @mgpuDestroySpMat(%35, %0) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.call @mgpuDestroyDnMat(%38, %0) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.call @mgpuStreamSynchronize(%0) : (!llvm.ptr) -> ()
    llvm.call @mgpuStreamDestroy(%0) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @spgemm(%arg0: i64) {
    %0 = llvm.mlir.constant(0 : index) : i64
    %1 = llvm.call @mgpuStreamCreate() : () -> !llvm.ptr
    %2 = llvm.mlir.constant(1 : index) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.getelementptr %3[%arg0] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %5 = llvm.ptrtoint %4 : !llvm.ptr to i64
    %6 = llvm.mlir.zero : !llvm.ptr
    %7 = llvm.mlir.constant(0 : i8) : i8
    %8 = llvm.call @mgpuMemAlloc(%5, %1, %7) : (i64, !llvm.ptr, i8) -> !llvm.ptr
    %9 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.insertvalue %8, %9[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.insertvalue %8, %10[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.mlir.constant(0 : index) : i64
    %13 = llvm.insertvalue %12, %11[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.insertvalue %arg0, %13[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.insertvalue %2, %14[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.mlir.constant(1 : index) : i64
    %17 = llvm.mlir.zero : !llvm.ptr
    %18 = llvm.getelementptr %17[%arg0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %19 = llvm.ptrtoint %18 : !llvm.ptr to i64
    %20 = llvm.mlir.zero : !llvm.ptr
    %21 = llvm.mlir.constant(0 : i8) : i8
    %22 = llvm.call @mgpuMemAlloc(%19, %1, %21) : (i64, !llvm.ptr, i8) -> !llvm.ptr
    %23 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %24 = llvm.insertvalue %22, %23[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %25 = llvm.insertvalue %22, %24[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %26 = llvm.mlir.constant(0 : index) : i64
    %27 = llvm.insertvalue %26, %25[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %28 = llvm.insertvalue %arg0, %27[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %29 = llvm.insertvalue %16, %28[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %30 = llvm.extractvalue %15[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %31 = llvm.extractvalue %15[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %32 = llvm.extractvalue %29[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %33 = llvm.mlir.constant(3 : i32) : i32
    %34 = llvm.mlir.constant(3 : i32) : i32
    %35 = llvm.mlir.constant(0 : i32) : i32
    %36 = llvm.call @mgpuCreateCsr(%arg0, %arg0, %arg0, %30, %31, %32, %33, %34, %35, %1) : (i64, i64, i64, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, !llvm.ptr) -> !llvm.ptr
    %37 = llvm.extractvalue %15[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %38 = llvm.extractvalue %15[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %39 = llvm.extractvalue %29[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %40 = llvm.mlir.constant(3 : i32) : i32
    %41 = llvm.mlir.constant(3 : i32) : i32
    %42 = llvm.mlir.constant(0 : i32) : i32
    %43 = llvm.call @mgpuCreateCsr(%arg0, %arg0, %arg0, %37, %38, %39, %40, %41, %42, %1) : (i64, i64, i64, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, !llvm.ptr) -> !llvm.ptr
    %44 = llvm.extractvalue %15[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %45 = llvm.extractvalue %15[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %46 = llvm.extractvalue %29[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %47 = llvm.mlir.constant(3 : i32) : i32
    %48 = llvm.mlir.constant(3 : i32) : i32
    %49 = llvm.mlir.constant(0 : i32) : i32
    %50 = llvm.call @mgpuCreateCsr(%arg0, %arg0, %arg0, %44, %45, %46, %47, %48, %49, %1) : (i64, i64, i64, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, !llvm.ptr) -> !llvm.ptr
    %51 = llvm.call @mgpuSpGEMMCreateDescr(%1) : (!llvm.ptr) -> !llvm.ptr
    %52 = llvm.mlir.constant(0 : index) : i64
    %53 = llvm.mlir.constant(1 : index) : i64
    %54 = llvm.mlir.zero : !llvm.ptr
    %55 = llvm.getelementptr %54[%52] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %56 = llvm.ptrtoint %55 : !llvm.ptr to i64
    %57 = llvm.call @malloc(%56) : (i64) -> !llvm.ptr
    %58 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %59 = llvm.insertvalue %57, %58[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %60 = llvm.insertvalue %57, %59[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %61 = llvm.mlir.constant(0 : index) : i64
    %62 = llvm.insertvalue %61, %60[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %63 = llvm.insertvalue %52, %62[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %64 = llvm.insertvalue %53, %63[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %65 = llvm.mlir.constant(0 : i32) : i32
    %66 = llvm.mlir.constant(0 : i32) : i32
    %67 = llvm.mlir.constant(0 : i32) : i32
    %68 = llvm.extractvalue %64[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %69 = llvm.call @mgpuSpGEMMWorkEstimation(%51, %66, %67, %36, %43, %50, %65, %0, %68, %1) : (!llvm.ptr, i32, i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i64, !llvm.ptr, !llvm.ptr) -> i64
    %70 = llvm.mlir.constant(0 : i32) : i32
    %71 = llvm.mlir.constant(0 : i32) : i32
    %72 = llvm.mlir.constant(0 : i32) : i32
    %73 = llvm.extractvalue %64[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %74 = llvm.call @mgpuSpGEMMCompute(%51, %71, %72, %36, %43, %50, %70, %0, %73, %1) : (!llvm.ptr, i32, i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i64, !llvm.ptr, !llvm.ptr) -> i64
    %75 = llvm.mlir.constant(3 : index) : i64
    %76 = llvm.alloca %75 x i64 {alignment = 16 : i64} : (i64) -> !llvm.ptr
    %77 = llvm.mlir.constant(0 : index) : i64
    %78 = llvm.getelementptr %76[%77] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %79 = llvm.mlir.constant(1 : index) : i64
    %80 = llvm.getelementptr %76[%79] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %81 = llvm.mlir.constant(2 : index) : i64
    %82 = llvm.getelementptr %76[%81] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    llvm.call @mgpuSpMatGetSize(%50, %78, %80, %82, %1) : (!llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr) -> ()
    %83 = llvm.load %78 : !llvm.ptr -> i64
    %84 = llvm.load %80 : !llvm.ptr -> i64
    %85 = llvm.load %82 : !llvm.ptr -> i64
    %86 = llvm.extractvalue %15[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %87 = llvm.extractvalue %15[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %88 = llvm.extractvalue %29[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.call @mgpuSetCsrPointers(%50, %86, %87, %88, %1) : (!llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr) -> ()
    %89 = llvm.mlir.constant(0 : i32) : i32
    %90 = llvm.mlir.constant(0 : i32) : i32
    %91 = llvm.mlir.constant(0 : i32) : i32
    llvm.call @mgpuSpGEMMCopy(%51, %90, %91, %36, %43, %50, %89, %1) : (!llvm.ptr, i32, i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, !llvm.ptr) -> ()
    llvm.call @mgpuSpGEMMDestroyDescr(%51, %1) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.call @mgpuDestroySpMat(%36, %1) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.call @mgpuDestroySpMat(%43, %1) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.call @mgpuDestroySpMat(%50, %1) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.call @mgpuStreamSynchronize(%1) : (!llvm.ptr) -> ()
    llvm.call @mgpuStreamDestroy(%1) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @sddmm(%arg0: i64) {
    %0 = llvm.call @mgpuStreamCreate() : () -> !llvm.ptr
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.getelementptr %2[%arg0] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i64
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.mlir.constant(0 : i8) : i8
    %7 = llvm.call @mgpuMemAlloc(%4, %0, %6) : (i64, !llvm.ptr, i8) -> !llvm.ptr
    %8 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.insertvalue %7, %9[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.mlir.constant(0 : index) : i64
    %12 = llvm.insertvalue %11, %10[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.insertvalue %arg0, %12[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.insertvalue %1, %13[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.mlir.constant(1 : index) : i64
    %16 = llvm.mlir.zero : !llvm.ptr
    %17 = llvm.getelementptr %16[%arg0] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %18 = llvm.ptrtoint %17 : !llvm.ptr to i64
    %19 = llvm.mlir.zero : !llvm.ptr
    %20 = llvm.mlir.constant(0 : i8) : i8
    %21 = llvm.call @mgpuMemAlloc(%18, %0, %20) : (i64, !llvm.ptr, i8) -> !llvm.ptr
    %22 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %23 = llvm.insertvalue %21, %22[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %24 = llvm.insertvalue %21, %23[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %25 = llvm.mlir.constant(0 : index) : i64
    %26 = llvm.insertvalue %25, %24[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %27 = llvm.insertvalue %arg0, %26[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %28 = llvm.insertvalue %15, %27[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %29 = llvm.extractvalue %14[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %30 = llvm.extractvalue %14[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %31 = llvm.extractvalue %28[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %32 = llvm.mlir.constant(3 : i32) : i32
    %33 = llvm.mlir.constant(3 : i32) : i32
    %34 = llvm.mlir.constant(1 : i32) : i32
    %35 = llvm.call @mgpuCreateCsr(%arg0, %arg0, %arg0, %29, %30, %31, %32, %33, %34, %0) : (i64, i64, i64, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, !llvm.ptr) -> !llvm.ptr
    %36 = llvm.extractvalue %28[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %37 = llvm.mlir.constant(1 : i32) : i32
    %38 = llvm.call @mgpuCreateDnMat(%arg0, %arg0, %36, %37, %0) : (i64, i64, !llvm.ptr, i32, !llvm.ptr) -> !llvm.ptr
    %39 = llvm.mlir.constant(0 : i32) : i32
    %40 = llvm.mlir.constant(0 : i32) : i32
    %41 = llvm.mlir.constant(1 : i32) : i32
    %42 = llvm.call @mgpuSDDMMBufferSize(%39, %40, %38, %38, %35, %41, %0) : (i32, i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, !llvm.ptr) -> i64
    %43 = llvm.mlir.constant(1 : i32) : i32
    %44 = llvm.mlir.constant(0 : i32) : i32
    %45 = llvm.mlir.constant(0 : i32) : i32
    %46 = llvm.extractvalue %28[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.call @mgpuSDDMM(%44, %45, %38, %38, %35, %43, %46, %0) : (i32, i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, !llvm.ptr, !llvm.ptr) -> ()
    llvm.call @mgpuDestroySpMat(%35, %0) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.call @mgpuDestroyDnMat(%38, %0) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.call @mgpuStreamSynchronize(%0) : (!llvm.ptr) -> ()
    llvm.call @mgpuStreamDestroy(%0) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @csc_and_bsr(%arg0: i64) {
    %0 = llvm.call @mgpuStreamCreate() : () -> !llvm.ptr
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.getelementptr %2[%arg0] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i64
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.mlir.constant(0 : i8) : i8
    %7 = llvm.call @mgpuMemAlloc(%4, %0, %6) : (i64, !llvm.ptr, i8) -> !llvm.ptr
    %8 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.insertvalue %7, %9[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.mlir.constant(0 : index) : i64
    %12 = llvm.insertvalue %11, %10[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.insertvalue %arg0, %12[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.insertvalue %1, %13[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.mlir.constant(1 : index) : i64
    %16 = llvm.mlir.zero : !llvm.ptr
    %17 = llvm.getelementptr %16[%arg0] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %18 = llvm.ptrtoint %17 : !llvm.ptr to i64
    %19 = llvm.mlir.zero : !llvm.ptr
    %20 = llvm.mlir.constant(0 : i8) : i8
    %21 = llvm.call @mgpuMemAlloc(%18, %0, %20) : (i64, !llvm.ptr, i8) -> !llvm.ptr
    %22 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %23 = llvm.insertvalue %21, %22[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %24 = llvm.insertvalue %21, %23[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %25 = llvm.mlir.constant(0 : index) : i64
    %26 = llvm.insertvalue %25, %24[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %27 = llvm.insertvalue %arg0, %26[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %28 = llvm.insertvalue %15, %27[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %29 = llvm.extractvalue %14[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %30 = llvm.extractvalue %14[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %31 = llvm.extractvalue %28[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %32 = llvm.mlir.constant(3 : i32) : i32
    %33 = llvm.mlir.constant(3 : i32) : i32
    %34 = llvm.mlir.constant(1 : i32) : i32
    %35 = llvm.call @mgpuCreateCsc(%arg0, %arg0, %arg0, %29, %30, %31, %32, %33, %34, %0) : (i64, i64, i64, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, !llvm.ptr) -> !llvm.ptr
    %36 = llvm.extractvalue %14[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %37 = llvm.extractvalue %14[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %38 = llvm.extractvalue %28[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %39 = llvm.mlir.constant(3 : i32) : i32
    %40 = llvm.mlir.constant(3 : i32) : i32
    %41 = llvm.mlir.constant(1 : i32) : i32
    %42 = llvm.call @mgpuCreateBsr(%arg0, %arg0, %arg0, %arg0, %arg0, %36, %37, %38, %39, %40, %41, %0) : (i64, i64, i64, i64, i64, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, !llvm.ptr) -> !llvm.ptr
    llvm.call @mgpuDestroySpMat(%35, %0) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.call @mgpuDestroySpMat(%42, %0) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.call @mgpuStreamSynchronize(%0) : (!llvm.ptr) -> ()
    llvm.call @mgpuStreamDestroy(%0) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @mgpuStreamCreate() -> !llvm.ptr
  llvm.func @mgpuMemAlloc(i64, !llvm.ptr, i8) -> !llvm.ptr
  llvm.func @mgpuCreateCoo(i64, i64, i64, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, !llvm.ptr) -> !llvm.ptr
  llvm.func @mgpuCreateDnVec(i64, !llvm.ptr, i32, !llvm.ptr) -> !llvm.ptr
  llvm.func @mgpuSpMVBufferSize(i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, !llvm.ptr) -> i64
  llvm.func @mgpuSpMV(i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, !llvm.ptr, !llvm.ptr)
  llvm.func @mgpuDestroySpMat(!llvm.ptr, !llvm.ptr)
  llvm.func @mgpuDestroyDnVec(!llvm.ptr, !llvm.ptr)
  llvm.func @mgpuStreamSynchronize(!llvm.ptr)
  llvm.func @mgpuStreamDestroy(!llvm.ptr)
  llvm.func @mgpuCreateCsr(i64, i64, i64, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, !llvm.ptr) -> !llvm.ptr
  llvm.func @mgpuCreateDnMat(i64, i64, !llvm.ptr, i32, !llvm.ptr) -> !llvm.ptr
  llvm.func @mgpuSpMMBufferSize(i32, i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, !llvm.ptr) -> i64
  llvm.func @mgpuSpMM(i32, i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, !llvm.ptr, !llvm.ptr)
  llvm.func @mgpuDestroyDnMat(!llvm.ptr, !llvm.ptr)
  llvm.func @mgpuSpGEMMCreateDescr(!llvm.ptr) -> !llvm.ptr
  llvm.func @mgpuSpGEMMWorkEstimation(!llvm.ptr, i32, i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i64, !llvm.ptr, !llvm.ptr) -> i64
  llvm.func @mgpuSpGEMMCompute(!llvm.ptr, i32, i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i64, !llvm.ptr, !llvm.ptr) -> i64
  llvm.func @mgpuSpMatGetSize(!llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr)
  llvm.func @mgpuSetCsrPointers(!llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr)
  llvm.func @mgpuSpGEMMCopy(!llvm.ptr, i32, i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, !llvm.ptr)
  llvm.func @mgpuSpGEMMDestroyDescr(!llvm.ptr, !llvm.ptr)
  llvm.func @mgpuSDDMMBufferSize(i32, i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, !llvm.ptr) -> i64
  llvm.func @mgpuSDDMM(i32, i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, !llvm.ptr, !llvm.ptr)
  llvm.func @mgpuCreateCsc(i64, i64, i64, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, !llvm.ptr) -> !llvm.ptr
  llvm.func @mgpuCreateBsr(i64, i64, i64, i64, i64, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, !llvm.ptr) -> !llvm.ptr
}

