module {
  gpu.module @fence_check {
    gpu.func @fence(%arg0: memref<8x16xf32, 1>) kernel {
      %thread_id_x = gpu.thread_id  x
      %0 = arith.index_cast %thread_id_x : index to i32
      %1 = arith.sitofp %0 : i32 to f32
      xevm.memfence <{addrspace = #xevm.addr_space<global>, scope = #xevm.mem_scope<workgroup>}>
      %c0 = arith.constant 0 : index
      memref.store %1, %arg0[%c0, %c0] : memref<8x16xf32, 1>
      gpu.return
    }
  }
}

