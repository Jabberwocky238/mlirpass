// acgpu's compute shader of the same name, in upstream dialects (the comments say what acgpu called things).
module attributes {gpu.container_module} {
gpu.module @shaders [#xevm.target<chip = "ptl">] {
// Workgroups of 4 threads (64 invocations) with 512 bytes of shared memory and barriers (acgpu.workgroup,
// acgpu.shared, acgpu.barrier): invocation l of workgroup g (i = 64 g + l) writes src[i] into shared[l]; after a
// barrier it reads shared[63 - l] into dst[i] (the workgroup's 64 reversed); it also adds 1 into shared counter
// l & 3 (atomically; zeroed by invocations 0 .. 3 before the first barrier), whose values invocations 0 .. 3 write to
// counts[4 g + l] after a second one. Out of range invocations take part (barriers want them all), writing nothing.
  gpu.func @workgroups(%src: i32, %dst: i32, %counts: i32, %n: i32) workgroup(%acgpu_shared : memref<512xi8, #gpu.address_space<workgroup>>) kernel attributes {known_block_size = array<i32: 64, 1, 1>} {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c3 = arith.constant 3 : i32
  %c4 = arith.constant 4 : i32
  %c63 = arith.constant 63 : i32
  %c64 = arith.constant 64 : i32
  %c256 = arith.constant 256 : i32
  %g_u1 = gpu.block_id x
  %g = arith.index_cast %g_u1 : index to i32
  %l_u2 = gpu.thread_id x
  %l = arith.index_cast %l_u2 : index to i32
  %g64 = arith.muli %g, %c64 : i32
  %i = arith.addi %g64, %l : i32
  %n1 = arith.subi %n, %c1 : i32
  %ic = arith.minui %i, %n1 : i32
  %i4 = arith.muli %ic, %c4 : i32
  %sa = arith.addi %src, %i4 : i32
  %sa_u3 = llvm.inttoptr %sa : i32 to !llvm.ptr<1>
  %v = llvm.load %sa_u3 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %l4 = arith.muli %l, %c4 : i32
  %l4_u4 = llvm.inttoptr %l4 : i32 to !llvm.ptr<3>
  llvm.store %v, %l4_u4 {alignment = 4 : i64} : i32, !llvm.ptr<3>
  %first4 = arith.cmpi slt, %l, %c4 : i32
  %ca = arith.addi %c256, %l4 : i32
  scf.if %first4 {
  %ca_u5 = llvm.inttoptr %ca : i32 to !llvm.ptr<3>
  llvm.store %c0, %ca_u5 {alignment = 4 : i64} : i32, !llvm.ptr<3>
  }
  gpu.barrier
  %k = arith.andi %l, %c3 : i32
  %k4 = arith.muli %k, %c4 : i32
  %kc = arith.addi %c256, %k4 : i32
  %kc_u6 = llvm.inttoptr %kc : i32 to !llvm.ptr<3>
  %old = llvm.atomicrmw add %kc_u6, %c1 monotonic : !llvm.ptr<3>, i32
  %r = arith.subi %c63, %l : i32
  %r4 = arith.muli %r, %c4 : i32
  %r4_u7 = llvm.inttoptr %r4 : i32 to !llvm.ptr<3>
  %w = llvm.load %r4_u7 {alignment = 4 : i64} : !llvm.ptr<3> -> i32
  %inside = arith.cmpi slt, %i, %n : i32
  scf.if %inside {
    %i4b = arith.muli %i, %c4 : i32
    %da = arith.addi %dst, %i4b : i32
  %da_u8 = llvm.inttoptr %da : i32 to !llvm.ptr<1>
  llvm.store %w, %da_u8 {alignment = 4 : i64} : i32, !llvm.ptr<1>
  }
  gpu.barrier
  scf.if %first4 {
  %ca_u9 = llvm.inttoptr %ca : i32 to !llvm.ptr<3>
  %cv = llvm.load %ca_u9 {alignment = 4 : i64} : !llvm.ptr<3> -> i32
    %g4 = arith.muli %g, %c4 : i32
    %gl = arith.addi %g4, %l : i32
    %gl4 = arith.muli %gl, %c4 : i32
    %oa = arith.addi %counts, %gl4 : i32
  %oa_u10 = llvm.inttoptr %oa : i32 to !llvm.ptr<1>
  llvm.store %cv, %oa_u10 {alignment = 4 : i64} : i32, !llvm.ptr<1>
  }
  gpu.return
  }
}
}
