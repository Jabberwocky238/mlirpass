module attributes {gpu.container_module} {
  llvm.func @main(%arg0: i64) {
    %0 = llvm.call @mgpuStreamCreate() : () -> !llvm.ptr
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.getelementptr %2[%arg0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
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
    %15 = llvm.extractvalue %14[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.call @mgpuMemFree(%15, %0) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.call @mgpuStreamSynchronize(%0) : (!llvm.ptr) -> ()
    llvm.call @mgpuStreamDestroy(%0) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @alloc_sync(%arg0: i64) {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.getelementptr %1[%arg0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i64
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.mlir.constant(1 : i8) : i8
    %6 = llvm.call @mgpuMemAlloc(%3, %4, %5) : (i64, !llvm.ptr, i8) -> !llvm.ptr
    %7 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.insertvalue %6, %8[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.mlir.constant(0 : index) : i64
    %11 = llvm.insertvalue %10, %9[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.insertvalue %arg0, %11[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.insertvalue %0, %12[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.call @mgpuStreamCreate() : () -> !llvm.ptr
    %15 = llvm.extractvalue %13[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.call @mgpuMemFree(%15, %14) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.call @mgpuStreamSynchronize(%14) : (!llvm.ptr) -> ()
    llvm.call @mgpuStreamDestroy(%14) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @mgpuStreamCreate() -> !llvm.ptr
  llvm.func @mgpuMemAlloc(i64, !llvm.ptr, i8) -> !llvm.ptr
  llvm.func @mgpuMemFree(!llvm.ptr, !llvm.ptr)
  llvm.func @mgpuStreamSynchronize(!llvm.ptr)
  llvm.func @mgpuStreamDestroy(!llvm.ptr)
}

