// acgpu's compute shader of the same name, in upstream dialects (the comments say what acgpu called things).
module attributes {gpu.container_module} {
gpu.module @shaders [#xevm.target<chip = "ptl">] {
// f64 arithmetic, one operand set (a, b, c, d) per invocation: invocation i reads four f64 at src + 32 i and writes
// seventeen f64 results at dst + 136 i.
  gpu.func @ops(%src: i32, %dst: i32) kernel {
  %g_u1 = gpu.block_id x
  %g = arith.index_cast %g_u1 : index to i32
  %l_u2 = gpu.thread_id x
  %l = arith.index_cast %l_u2 : index to i32
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
  %at_u3 = llvm.inttoptr %at : i32 to !llvm.ptr<1>
  %a = llvm.load %at_u3 {alignment = 4 : i64} : !llvm.ptr<1> -> f64
  %at1_u4 = llvm.inttoptr %at1 : i32 to !llvm.ptr<1>
  %b = llvm.load %at1_u4 {alignment = 4 : i64} : !llvm.ptr<1> -> f64
  %at2_u5 = llvm.inttoptr %at2 : i32 to !llvm.ptr<1>
  %c = llvm.load %at2_u5 {alignment = 4 : i64} : !llvm.ptr<1> -> f64
  %at3_u6 = llvm.inttoptr %at3 : i32 to !llvm.ptr<1>
  %d = llvm.load %at3_u6 {alignment = 4 : i64} : !llvm.ptr<1> -> f64
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
  %o0_u7 = llvm.inttoptr %o0 : i32 to !llvm.ptr<1>
  llvm.store %r0, %o0_u7 {alignment = 4 : i64} : f64, !llvm.ptr<1>
  %o1_u8 = llvm.inttoptr %o1 : i32 to !llvm.ptr<1>
  llvm.store %r1, %o1_u8 {alignment = 4 : i64} : f64, !llvm.ptr<1>
  %o2_u9 = llvm.inttoptr %o2 : i32 to !llvm.ptr<1>
  llvm.store %r2, %o2_u9 {alignment = 4 : i64} : f64, !llvm.ptr<1>
  %o3_u10 = llvm.inttoptr %o3 : i32 to !llvm.ptr<1>
  llvm.store %r3, %o3_u10 {alignment = 4 : i64} : f64, !llvm.ptr<1>
  %o4_u11 = llvm.inttoptr %o4 : i32 to !llvm.ptr<1>
  llvm.store %r4, %o4_u11 {alignment = 4 : i64} : f64, !llvm.ptr<1>
  %o5_u12 = llvm.inttoptr %o5 : i32 to !llvm.ptr<1>
  llvm.store %r5, %o5_u12 {alignment = 4 : i64} : f64, !llvm.ptr<1>
  %o6_u13 = llvm.inttoptr %o6 : i32 to !llvm.ptr<1>
  llvm.store %r6, %o6_u13 {alignment = 4 : i64} : f64, !llvm.ptr<1>
  %o7_u14 = llvm.inttoptr %o7 : i32 to !llvm.ptr<1>
  llvm.store %r7, %o7_u14 {alignment = 4 : i64} : f64, !llvm.ptr<1>
  %o8 = arith.addi %o7, %c8 : i32
  %o9 = arith.addi %o8, %c8 : i32
  %o10 = arith.addi %o9, %c8 : i32
  %o8_u15 = llvm.inttoptr %o8 : i32 to !llvm.ptr<1>
  llvm.store %r8, %o8_u15 {alignment = 4 : i64} : f64, !llvm.ptr<1>
  %o9_u16 = llvm.inttoptr %o9 : i32 to !llvm.ptr<1>
  llvm.store %r9, %o9_u16 {alignment = 4 : i64} : f64, !llvm.ptr<1>
  %o10_u17 = llvm.inttoptr %o10 : i32 to !llvm.ptr<1>
  llvm.store %r10, %o10_u17 {alignment = 4 : i64} : f64, !llvm.ptr<1>
  %o11 = arith.addi %o10, %c8 : i32
  %o11_u18 = llvm.inttoptr %o11 : i32 to !llvm.ptr<1>
  llvm.store %r11, %o11_u18 {alignment = 4 : i64} : f64, !llvm.ptr<1>
  %o12 = arith.addi %o11, %c8 : i32
  %o12_u19 = llvm.inttoptr %o12 : i32 to !llvm.ptr<1>
  llvm.store %r12, %o12_u19 {alignment = 4 : i64} : f64, !llvm.ptr<1>
  %o13 = arith.addi %o12, %c8 : i32
  %o14 = arith.addi %o13, %c8 : i32
  %o15 = arith.addi %o14, %c8 : i32
  %o16 = arith.addi %o15, %c8 : i32
  %o13_u20 = llvm.inttoptr %o13 : i32 to !llvm.ptr<1>
  llvm.store %r13, %o13_u20 {alignment = 4 : i64} : f64, !llvm.ptr<1>
  %o14_u21 = llvm.inttoptr %o14 : i32 to !llvm.ptr<1>
  llvm.store %r14, %o14_u21 {alignment = 4 : i64} : f64, !llvm.ptr<1>
  %o15_u22 = llvm.inttoptr %o15 : i32 to !llvm.ptr<1>
  llvm.store %r15, %o15_u22 {alignment = 4 : i64} : f64, !llvm.ptr<1>
  %o16_u23 = llvm.inttoptr %o16 : i32 to !llvm.ptr<1>
  llvm.store %r16, %o16_u23 {alignment = 4 : i64} : f64, !llvm.ptr<1>
  gpu.return
  }
}
}
