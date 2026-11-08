// acgpu's crates/intel/driver/examples/math64/ops.mlir in upstream dialects.
module attributes {gpu.container_module} {
gpu.module @shaders [#xevm.target<chip = "ptl">] {
gpu.func @ops(%src: i32, %dst: i32) kernel {
  %g_ix1 = gpu.block_id x
  %g = arith.index_cast %g_ix1 : index to i32
  %l_ix2 = gpu.thread_id x
  %l = arith.index_cast %l_ix2 : index to i32
  %c16 = arith.constant 16 : i32
  %base = arith.muli %g, %c16 : i32
  %i = arith.addi %base, %l : i32
  %c32 = arith.constant 32 : i32
  %in = arith.muli %i, %c32 : i32
  %at = arith.addi %src, %in : i32
  %c8 = arith.constant 8 : i32
  %at1 = arith.addi %at, %c8 : i32
  %at2 = arith.addi %at1, %c8 : i32
  %at3 = arith.addi %at2, %c8 : i32
  %a_p3 = llvm.inttoptr %at : i32 to !llvm.ptr<1>
  %a = llvm.load %a_p3 {alignment = 8 : i64} : !llvm.ptr<1> -> f64
  %b_p4 = llvm.inttoptr %at1 : i32 to !llvm.ptr<1>
  %b = llvm.load %b_p4 {alignment = 8 : i64} : !llvm.ptr<1> -> f64
  %c_p5 = llvm.inttoptr %at2 : i32 to !llvm.ptr<1>
  %c = llvm.load %c_p5 {alignment = 8 : i64} : !llvm.ptr<1> -> f64
  %d_p6 = llvm.inttoptr %at3 : i32 to !llvm.ptr<1>
  %d = llvm.load %d_p6 {alignment = 8 : i64} : !llvm.ptr<1> -> f64
  %r0 = arith.addf %a, %b : f64
  %r1 = arith.subf %a, %b : f64
  %r2 = arith.mulf %a, %b : f64
  %r3 = math.fma %a, %b, %c : f64
  %r4 = arith.negf %a : f64
  %r5 = math.absf %a : f64
  %k = arith.constant 0.1 : f64
  %r6 = arith.mulf %a, %k : f64
  %t = arith.truncf %a : f64 to f32
  %r7a = arith.extf %t : f32 to f64
  %di = arith.fptosi %d : f64 to i32
  %r7b = arith.sitofp %di : i32 to f64
  %r7 = arith.addf %r7a, %r7b : f64
  %lt = arith.cmpf olt, %a, %b : f64
  %r8 = arith.select %lt, %a, %b : f64
  %eq = arith.cmpf oeq, %a, %b : f64
  %r9 = arith.select %eq, %c, %a : f64
  %r10 = arith.maxnumf %a, %b : f64
  %r11 = arith.divf %a, %b : f64
  %r12 = math.sqrt %a : f64
  %r13 = math.floor %a : f64
  %r14 = math.ceil %a : f64
  %r15 = math.trunc %a : f64
  %r16 = math.roundeven %a : f64
  %c64 = arith.constant 136 : i32
  %out = arith.muli %i, %c64 : i32
  %o0 = arith.addi %dst, %out : i32
  %o1 = arith.addi %o0, %c8 : i32
  %o2 = arith.addi %o1, %c8 : i32
  %o3 = arith.addi %o2, %c8 : i32
  %o4 = arith.addi %o3, %c8 : i32
  %o5 = arith.addi %o4, %c8 : i32
  %o6 = arith.addi %o5, %c8 : i32
  %o7 = arith.addi %o6, %c8 : i32
  %st_p7 = llvm.inttoptr %o0 : i32 to !llvm.ptr<1>
  llvm.store %r0, %st_p7 {alignment = 8 : i64} : f64, !llvm.ptr<1>
  %st_p8 = llvm.inttoptr %o1 : i32 to !llvm.ptr<1>
  llvm.store %r1, %st_p8 {alignment = 8 : i64} : f64, !llvm.ptr<1>
  %st_p9 = llvm.inttoptr %o2 : i32 to !llvm.ptr<1>
  llvm.store %r2, %st_p9 {alignment = 8 : i64} : f64, !llvm.ptr<1>
  %st_p10 = llvm.inttoptr %o3 : i32 to !llvm.ptr<1>
  llvm.store %r3, %st_p10 {alignment = 8 : i64} : f64, !llvm.ptr<1>
  %st_p11 = llvm.inttoptr %o4 : i32 to !llvm.ptr<1>
  llvm.store %r4, %st_p11 {alignment = 8 : i64} : f64, !llvm.ptr<1>
  %st_p12 = llvm.inttoptr %o5 : i32 to !llvm.ptr<1>
  llvm.store %r5, %st_p12 {alignment = 8 : i64} : f64, !llvm.ptr<1>
  %st_p13 = llvm.inttoptr %o6 : i32 to !llvm.ptr<1>
  llvm.store %r6, %st_p13 {alignment = 8 : i64} : f64, !llvm.ptr<1>
  %st_p14 = llvm.inttoptr %o7 : i32 to !llvm.ptr<1>
  llvm.store %r7, %st_p14 {alignment = 8 : i64} : f64, !llvm.ptr<1>
  %o8 = arith.addi %o7, %c8 : i32
  %o9 = arith.addi %o8, %c8 : i32
  %o10 = arith.addi %o9, %c8 : i32
  %st_p15 = llvm.inttoptr %o8 : i32 to !llvm.ptr<1>
  llvm.store %r8, %st_p15 {alignment = 8 : i64} : f64, !llvm.ptr<1>
  %st_p16 = llvm.inttoptr %o9 : i32 to !llvm.ptr<1>
  llvm.store %r9, %st_p16 {alignment = 8 : i64} : f64, !llvm.ptr<1>
  %st_p17 = llvm.inttoptr %o10 : i32 to !llvm.ptr<1>
  llvm.store %r10, %st_p17 {alignment = 8 : i64} : f64, !llvm.ptr<1>
  %o11 = arith.addi %o10, %c8 : i32
  %st_p18 = llvm.inttoptr %o11 : i32 to !llvm.ptr<1>
  llvm.store %r11, %st_p18 {alignment = 8 : i64} : f64, !llvm.ptr<1>
  %o12 = arith.addi %o11, %c8 : i32
  %st_p19 = llvm.inttoptr %o12 : i32 to !llvm.ptr<1>
  llvm.store %r12, %st_p19 {alignment = 8 : i64} : f64, !llvm.ptr<1>
  %o13 = arith.addi %o12, %c8 : i32
  %o14 = arith.addi %o13, %c8 : i32
  %o15 = arith.addi %o14, %c8 : i32
  %o16 = arith.addi %o15, %c8 : i32
  %st_p20 = llvm.inttoptr %o13 : i32 to !llvm.ptr<1>
  llvm.store %r13, %st_p20 {alignment = 8 : i64} : f64, !llvm.ptr<1>
  %st_p21 = llvm.inttoptr %o14 : i32 to !llvm.ptr<1>
  llvm.store %r14, %st_p21 {alignment = 8 : i64} : f64, !llvm.ptr<1>
  %st_p22 = llvm.inttoptr %o15 : i32 to !llvm.ptr<1>
  llvm.store %r15, %st_p22 {alignment = 8 : i64} : f64, !llvm.ptr<1>
  %st_p23 = llvm.inttoptr %o16 : i32 to !llvm.ptr<1>
  llvm.store %r16, %st_p23 {alignment = 8 : i64} : f64, !llvm.ptr<1>
  gpu.return
}
}
}
