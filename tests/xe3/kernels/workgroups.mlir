// acgpu's crates/intel/driver/examples/workgroups/workgroups.mlir in upstream dialects.
module attributes {gpu.container_module} {
gpu.module @shaders [#xevm.target<chip = "ptl">] {
gpu.func @workgroups(%src: i32, %dst: i32, %counts: i32, %n: i32) workgroup(%acgpu_shared : memref<512xi8, #gpu.address_space<workgroup>>) kernel attributes {known_block_size = array<i32: 64, 1, 1>} {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c3 = arith.constant 3 : i32
  %c4 = arith.constant 4 : i32
  %c63 = arith.constant 63 : i32
  %c64 = arith.constant 64 : i32
  %c256 = arith.constant 256 : i32
  %g_ix1 = gpu.block_id x
  %g = arith.index_cast %g_ix1 : index to i32
  %l_ix2 = gpu.thread_id x
  %l = arith.index_cast %l_ix2 : index to i32
  %g64 = arith.muli %g, %c64 : i32
  %i = arith.addi %g64, %l : i32
  %n1 = arith.subi %n, %c1 : i32
  %ic = arith.minui %i, %n1 : i32
  %i4 = arith.muli %ic, %c4 : i32
  %sa = arith.addi %src, %i4 : i32
  %v_p3 = llvm.inttoptr %sa : i32 to !llvm.ptr<1>
  %v = llvm.load %v_p3 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %l4 = arith.muli %l, %c4 : i32
  %st_p4 = llvm.inttoptr %l4 : i32 to !llvm.ptr<3>
  llvm.store %v, %st_p4 {alignment = 4 : i64} : i32, !llvm.ptr<3>
  %first4 = arith.cmpi slt, %l, %c4 : i32
  %ca = arith.addi %c256, %l4 : i32
  scf.if %first4 {
    %st_p5 = llvm.inttoptr %ca : i32 to !llvm.ptr<3>
    llvm.store %c0, %st_p5 {alignment = 4 : i64} : i32, !llvm.ptr<3>
  }
  gpu.barrier
  %k = arith.andi %l, %c3 : i32
  %k4 = arith.muli %k, %c4 : i32
  %kc = arith.addi %c256, %k4 : i32
  %old_p6 = llvm.inttoptr %kc : i32 to !llvm.ptr<3>
  %old = llvm.atomicrmw add %old_p6, %c1 monotonic : !llvm.ptr<3>, i32
  %r = arith.subi %c63, %l : i32
  %r4 = arith.muli %r, %c4 : i32
  %w_p7 = llvm.inttoptr %r4 : i32 to !llvm.ptr<3>
  %w = llvm.load %w_p7 {alignment = 4 : i64} : !llvm.ptr<3> -> i32
  %inside = arith.cmpi slt, %i, %n : i32
  scf.if %inside {
    %i4b = arith.muli %i, %c4 : i32
    %da = arith.addi %dst, %i4b : i32
    %st_p8 = llvm.inttoptr %da : i32 to !llvm.ptr<1>
    llvm.store %w, %st_p8 {alignment = 4 : i64} : i32, !llvm.ptr<1>
  }
  gpu.barrier
  scf.if %first4 {
    %cv_p9 = llvm.inttoptr %ca : i32 to !llvm.ptr<3>
    %cv = llvm.load %cv_p9 {alignment = 4 : i64} : !llvm.ptr<3> -> i32
    %g4 = arith.muli %g, %c4 : i32
    %gl = arith.addi %g4, %l : i32
    %gl4 = arith.muli %gl, %c4 : i32
    %oa = arith.addi %counts, %gl4 : i32
    %st_p10 = llvm.inttoptr %oa : i32 to !llvm.ptr<1>
    llvm.store %cv, %st_p10 {alignment = 4 : i64} : i32, !llvm.ptr<1>
  }
  gpu.return
}
}
}
