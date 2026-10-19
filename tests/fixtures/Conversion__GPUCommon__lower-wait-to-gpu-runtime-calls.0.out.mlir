module attributes {gpu.container_module} {
  llvm.func @foo() {
    %0 = llvm.call @mgpuStreamCreate() : () -> !llvm.ptr
    %1 = llvm.call @mgpuEventCreate() : () -> !llvm.ptr
    llvm.call @mgpuEventRecord(%1, %0) : (!llvm.ptr, !llvm.ptr) -> ()
    %2 = llvm.call @mgpuStreamCreate() : () -> !llvm.ptr
    llvm.call @mgpuStreamWaitEvent(%2, %1) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.call @mgpuEventDestroy(%1) : (!llvm.ptr) -> ()
    llvm.call @mgpuStreamSynchronize(%0) : (!llvm.ptr) -> ()
    llvm.call @mgpuStreamDestroy(%0) : (!llvm.ptr) -> ()
    llvm.call @mgpuStreamSynchronize(%2) : (!llvm.ptr) -> ()
    llvm.call @mgpuStreamDestroy(%2) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @mgpuStreamCreate() -> !llvm.ptr
  llvm.func @mgpuEventCreate() -> !llvm.ptr
  llvm.func @mgpuEventRecord(!llvm.ptr, !llvm.ptr)
  llvm.func @mgpuStreamWaitEvent(!llvm.ptr, !llvm.ptr)
  llvm.func @mgpuEventDestroy(!llvm.ptr)
  llvm.func @mgpuStreamSynchronize(!llvm.ptr)
  llvm.func @mgpuStreamDestroy(!llvm.ptr)
}

