module {
  gpu.module @nvvm_module [#nvvm.target] {
    llvm.func @kernel_0() -> i64 {
      %0 = nvvm.read.ptx.sreg.tid.x : i32
      %1 = llvm.sext %0 : i32 to i64
      %2 = nvvm.read.ptx.sreg.laneid range <i32, 0, 32> : i32
      %3 = llvm.sext %2 : i32 to i64
      %4 = llvm.add %1, %3 : i64
      llvm.return %4 : i64
    }
    llvm.func @kernel_1(%arg0: !llvm.ptr<1>, %arg1: !llvm.ptr<1>, %arg2: i64) attributes {gpu.kernel, gpu.known_block_size = array<i32: 128, 1, 1>, nvvm.kernel, nvvm.maxntid = array<i32: 128, 1, 1>} {
      llvm.return
    }
  }
  gpu.module @nvvm_module_2 {
    llvm.func @kernel_0() -> i64 {
      %thread_id_x = gpu.thread_id x
      %0 = builtin.unrealized_conversion_cast %thread_id_x : index to i64
      %1 = gpu.lane_id
      %2 = builtin.unrealized_conversion_cast %1 : index to i64
      %3 = llvm.add %0, %2 : i64
      llvm.return %3 : i64
    }
    gpu.func @kernel_1(%arg0: memref<f32, #gpu.address_space<global>>) kernel attributes {known_block_size = array<i32: 128, 1, 1>} {
      gpu.return
    }
  }
}

