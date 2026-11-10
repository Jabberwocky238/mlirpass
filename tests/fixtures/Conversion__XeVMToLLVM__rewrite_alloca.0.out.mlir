module {
  llvm.mlir.global internal @__global_alloca_2() {addr_space = 3 : i32, alignment = 8 : i64} : !llvm.array<10 x i32>
  llvm.mlir.global internal @__global_alloca_1() {addr_space = 3 : i32, alignment = 8 : i64} : !llvm.array<10 x i32>
  llvm.mlir.global internal @__global_alloca_0() {addr_space = 3 : i32, alignment = 8 : i64} : !llvm.array<10 x i32>
  llvm.func @test_with_parent_module() -> !llvm.ptr<3> {
    %0 = llvm.mlir.addressof @__global_alloca_0 : !llvm.ptr<3>
    %1 = llvm.mlir.addressof @__global_alloca_1 : !llvm.ptr<3>
    %2 = llvm.mlir.addressof @__global_alloca_2 : !llvm.ptr<3>
    %3 = llvm.load %1 : !llvm.ptr<3> -> i32
    %4 = llvm.load %2 : !llvm.ptr<3> -> i32
    %5 = llvm.add %3, %4 : i32
    llvm.store %5, %0 : i32, !llvm.ptr<3>
    llvm.return %0 : !llvm.ptr<3>
  }
}

// -----
module {
  gpu.module @test {
    llvm.mlir.global internal @__global_alloca_5() {addr_space = 3 : i32, alignment = 8 : i64} : !llvm.array<10 x i32>
    llvm.mlir.global internal @__global_alloca_4() {addr_space = 3 : i32, alignment = 8 : i64} : !llvm.array<10 x i32>
    llvm.mlir.global internal @__global_alloca_3() {addr_space = 3 : i32, alignment = 8 : i64} : !llvm.array<10 x i32>
    llvm.func @test_with_parent_gpu_module() -> !llvm.ptr<3> {
      %0 = llvm.mlir.addressof @__global_alloca_3 : !llvm.ptr<3>
      %1 = llvm.mlir.addressof @__global_alloca_4 : !llvm.ptr<3>
      %2 = llvm.mlir.addressof @__global_alloca_5 : !llvm.ptr<3>
      %3 = llvm.load %1 : !llvm.ptr<3> -> i32
      %4 = llvm.load %2 : !llvm.ptr<3> -> i32
      %5 = llvm.add %3, %4 : i32
      llvm.store %5, %0 : i32, !llvm.ptr<3>
      llvm.return %0 : !llvm.ptr<3>
    }
  }
}

// -----
module {
  llvm.func @test_with_default_addr_space() -> !llvm.ptr {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.alloca %0 x i32 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.alloca %0 x i32 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.load %2 : !llvm.ptr -> i32
    %5 = llvm.load %3 : !llvm.ptr -> i32
    %6 = llvm.add %4, %5 : i32
    llvm.store %6, %1 : i32, !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
}

