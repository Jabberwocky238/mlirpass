// acgpu's crates/intel/driver/examples/atomics/atomics.mlir in upstream dialects.
module attributes {gpu.container_module} {
gpu.module @shaders [#xevm.target<chip = "ptl">] {
gpu.func @atomics(%params: i32, %n: i32) kernel {
  %c4 = arith.constant 4 : i32
  %c16 = arith.constant 16 : i32
  %counters_p1 = llvm.inttoptr %params : i32 to !llvm.ptr<1>
  %counters = llvm.load %counters_p1 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a1 = arith.addi %params, %c4 : i32
  %olds_p2 = llvm.inttoptr %a1 : i32 to !llvm.ptr<1>
  %olds = llvm.load %olds_p2 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a2 = arith.addi %a1, %c4 : i32
  %maxes_p3 = llvm.inttoptr %a2 : i32 to !llvm.ptr<1>
  %maxes = llvm.load %maxes_p3 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a3 = arith.addi %a2, %c4 : i32
  %umins_p4 = llvm.inttoptr %a3 : i32 to !llvm.ptr<1>
  %umins = llvm.load %umins_p4 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a4 = arith.addi %a3, %c4 : i32
  %swap_p5 = llvm.inttoptr %a4 : i32 to !llvm.ptr<1>
  %swap = llvm.load %swap_p5 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a5 = arith.addi %a4, %c4 : i32
  %swaps_p6 = llvm.inttoptr %a5 : i32 to !llvm.ptr<1>
  %swaps = llvm.load %swaps_p6 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %g_ix7 = gpu.block_id x
  %g = arith.index_cast %g_ix7 : index to i32
  %l_ix8 = gpu.thread_id x
  %l = arith.index_cast %l_ix8 : index to i32
  %b0 = arith.muli %g, %c16 : i32
  %i = arith.addi %b0, %l : i32
  %inside = arith.cmpi slt, %i, %n : i32
  scf.if %inside {
    %one = arith.constant 1 : i32
    %c7 = arith.constant 7 : i32
    %k = arith.andi %i, %c7 : i32
    %k4 = arith.muli %k, %c4 : i32
    %ca = arith.addi %counters, %k4 : i32
    %old_p9 = llvm.inttoptr %ca : i32 to !llvm.ptr<1>
    %old = llvm.atomicrmw add %old_p9, %one monotonic : !llvm.ptr<1>, i32
    %i4 = arith.muli %i, %c4 : i32
    %oa = arith.addi %olds, %i4 : i32
    %st_p10 = llvm.inttoptr %oa : i32 to !llvm.ptr<1>
    llvm.store %old, %st_p10 {alignment = 4 : i64} : i32, !llvm.ptr<1>
    %c3 = arith.constant 3 : i32
    %m = arith.andi %i, %c3 : i32
    %m4 = arith.muli %m, %c4 : i32
    %ma = arith.addi %maxes, %m4 : i32
    %c37 = arith.constant 37 : i32
    %c1023 = arith.constant 1023 : i32
    %c512 = arith.constant 512 : i32
    %v0 = arith.muli %i, %c37 : i32
    %v1 = arith.andi %v0, %c1023 : i32
    %v = arith.subi %v1, %c512 : i32
    %mo_p11 = llvm.inttoptr %ma : i32 to !llvm.ptr<1>
    %mo = llvm.atomicrmw max %mo_p11, %v monotonic : !llvm.ptr<1>, i32
    %u0 = arith.shrui %i, %c4 : i32
    %u = arith.andi %u0, %c3 : i32
    %u4 = arith.muli %u, %c4 : i32
    %ua = arith.addi %umins, %u4 : i32
    %c7919 = arith.constant 7919 : i32
    %c65535 = arith.constant 65535 : i32
    %w0 = arith.muli %i, %c7919 : i32
    %w = arith.andi %w0, %c65535 : i32
    %uo_p12 = llvm.inttoptr %ua : i32 to !llvm.ptr<1>
    %uo = llvm.atomicrmw umin %uo_p12, %w monotonic : !llvm.ptr<1>, i32
    %so_p13 = llvm.inttoptr %swap : i32 to !llvm.ptr<1>
    %so = llvm.atomicrmw xchg %so_p13, %i monotonic : !llvm.ptr<1>, i32
    %sa = arith.addi %swaps, %i4 : i32
    %st_p14 = llvm.inttoptr %sa : i32 to !llvm.ptr<1>
    llvm.store %so, %st_p14 {alignment = 4 : i64} : i32, !llvm.ptr<1>
  }
  gpu.return
}
}
}
