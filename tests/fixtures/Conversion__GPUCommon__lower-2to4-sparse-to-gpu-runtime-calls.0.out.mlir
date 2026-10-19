module attributes {gpu.container_module} {
  llvm.func @matmul(%arg0: i64) {
    %0 = llvm.call @mgpuStreamCreate() : () -> !llvm.ptr
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.getelementptr %2[%arg0] : (!llvm.ptr, i64) -> !llvm.ptr, f16
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
    %17 = llvm.getelementptr %16[%arg0] : (!llvm.ptr, i64) -> !llvm.ptr, f16
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
    %30 = llvm.mlir.constant(2 : i32) : i32
    %31 = llvm.mlir.constant(44104 : index) : i64
    %32 = llvm.alloca %31 x i8 {alignment = 16 : i64} : (i64) -> !llvm.ptr
    %33 = llvm.bitcast %32 : !llvm.ptr to !llvm.ptr
    llvm.call @mgpuCusparseLtCreate2To4SpMat(%33, %arg0, %arg0, %29, %30, %0) : (!llvm.ptr, i64, i64, !llvm.ptr, i32, !llvm.ptr) -> ()
    %34 = llvm.extractvalue %28[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %35 = llvm.mlir.constant(2 : i32) : i32
    %36 = llvm.mlir.constant(11032 : index) : i64
    %37 = llvm.alloca %36 x i8 {alignment = 16 : i64} : (i64) -> !llvm.ptr
    %38 = llvm.bitcast %37 : !llvm.ptr to !llvm.ptr
    llvm.call @mgpuCreateCuSparseLtDnMat(%38, %arg0, %arg0, %34, %35, %0) : (!llvm.ptr, i64, i64, !llvm.ptr, i32, !llvm.ptr) -> ()
    %39 = llvm.mlir.constant(0 : i32) : i32
    %40 = llvm.mlir.constant(0 : i32) : i32
    %41 = llvm.mlir.constant(2 : i32) : i32
    %42 = llvm.mlir.constant(0 : i32) : i32
    %43 = llvm.mlir.constant(3 : index) : i64
    %44 = llvm.alloca %43 x !llvm.ptr {alignment = 16 : i64} : (i64) -> !llvm.ptr
    llvm.call @mgpuCuSparseLtSpMMBufferSize(%44, %39, %40, %33, %38, %38, %42, %41, %0) : (!llvm.ptr, i32, i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, !llvm.ptr) -> ()
    %45 = llvm.mlir.constant(1 : index) : i64
    %46 = llvm.getelementptr %44[%45] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %47 = llvm.mlir.constant(2 : index) : i64
    %48 = llvm.getelementptr %44[%47] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %49 = llvm.load %44 : !llvm.ptr -> i64
    %50 = llvm.load %46 : !llvm.ptr -> i64
    %51 = llvm.load %48 : !llvm.ptr -> i64
    %52 = llvm.mlir.constant(0 : i32) : i32
    %53 = llvm.mlir.constant(0 : i32) : i32
    %54 = llvm.mlir.constant(2 : i32) : i32
    %55 = llvm.extractvalue %28[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %56 = llvm.extractvalue %28[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %57 = llvm.extractvalue %28[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.call @mgpuCuSparseLtSpMM(%33, %38, %38, %55, %56, %57, %0) : (!llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr) -> ()
    llvm.call @mgpuDestroyCuSparseLtSpMat(%33, %0) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.call @mgpuDestroyCuSparseLtDnMat(%38, %0) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.call @mgpuStreamSynchronize(%0) : (!llvm.ptr) -> ()
    llvm.call @mgpuStreamDestroy(%0) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @mgpuStreamCreate() -> !llvm.ptr
  llvm.func @mgpuMemAlloc(i64, !llvm.ptr, i8) -> !llvm.ptr
  llvm.func @mgpuCusparseLtCreate2To4SpMat(!llvm.ptr, i64, i64, !llvm.ptr, i32, !llvm.ptr)
  llvm.func @mgpuCreateCuSparseLtDnMat(!llvm.ptr, i64, i64, !llvm.ptr, i32, !llvm.ptr)
  llvm.func @mgpuCuSparseLtSpMMBufferSize(!llvm.ptr, i32, i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, !llvm.ptr)
  llvm.func @mgpuCuSparseLtSpMM(!llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr)
  llvm.func @mgpuDestroyCuSparseLtSpMat(!llvm.ptr, !llvm.ptr)
  llvm.func @mgpuDestroyCuSparseLtDnMat(!llvm.ptr, !llvm.ptr)
  llvm.func @mgpuStreamSynchronize(!llvm.ptr)
  llvm.func @mgpuStreamDestroy(!llvm.ptr)
}

