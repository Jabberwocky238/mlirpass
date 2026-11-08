// f32 arithmetic for Apple9, one operand triple (a, b, c) per invocation: invocation i reads 16 bytes at src + 16 i (a, b,
// c, unused) and writes twenty results (four floats at a time) at dst + 80 i. Exact IEEE but for denormals (flushed).
module attributes {gpu.container_module} {
gpu.module @shaders [#apple9.target<chip = "m4">] {
  gpu.func @floats(%src: i32, %dst: i32) kernel {
  %g_ix = gpu.block_id x
  %g = arith.index_cast %g_ix : index to i32
  %l_ix = gpu.thread_id x
  %l = arith.index_cast %l_ix : index to i32
  %c32 = arith.constant 32 : i32
  %c16 = arith.constant 16 : i32
  %base = arith.muli %g, %c32 : i32
  %i = arith.addi %base, %l : i32
  %in = arith.muli %i, %c16 : i32
  %at = arith.addi %src, %in : i32
  %at_p = llvm.inttoptr %at : i32 to !llvm.ptr<1>
  %abc = llvm.load %at_p {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xf32>
  %a = vector.extract %abc[0] : f32 from vector<4xf32>
  %b = vector.extract %abc[1] : f32 from vector<4xf32>
  %c = vector.extract %abc[2] : f32 from vector<4xf32>
  %r0 = arith.addf %a, %b : f32
  %r1 = arith.subf %a, %b : f32
  %r2 = arith.mulf %a, %b : f32
  %r3 = math.fma %a, %b, %c : f32
  %r4 = arith.negf %a : f32
  %r5 = math.absf %a : f32
  %r6 = arith.minnumf %a, %b : f32
  %r7 = arith.maxnumf %a, %b : f32
  %r8 = math.floor %a : f32
  %r9 = math.ceil %a : f32
  %r10 = math.trunc %a : f32
  %r11 = math.roundeven %a : f32
  %r12 = arith.divf %a, %b : f32
  %r13 = math.sqrt %a : f32
  %lt = arith.cmpf olt, %a, %b : f32
  %r14 = arith.select %lt, %a, %c : f32
  %ge = arith.cmpf oge, %a, %b : f32
  %r15 = arith.select %ge, %a, %c : f32
  %eq = arith.cmpf oeq, %a, %b : f32
  %r16 = arith.select %eq, %a, %c : f32
  %ne = arith.cmpf une, %a, %b : f32
  %r17 = arith.select %ne, %a, %c : f32
  %uno = arith.cmpf uno, %a, %b : f32
  %r18 = arith.select %uno, %a, %c : f32
  %ugt = arith.cmpf ugt, %a, %b : f32
  %r19 = arith.select %ugt, %a, %c : f32
  %c80 = arith.constant 80 : i32
  %out = arith.muli %i, %c80 : i32
  %o0 = arith.addi %dst, %out : i32
  %o1 = arith.addi %o0, %c16 : i32
  %o2 = arith.addi %o1, %c16 : i32
  %o3 = arith.addi %o2, %c16 : i32
  %o4 = arith.addi %o3, %c16 : i32
  %v0 = vector.from_elements %r0, %r1, %r2, %r3 : vector<4xf32>
  %v1 = vector.from_elements %r4, %r5, %r6, %r7 : vector<4xf32>
  %v2 = vector.from_elements %r8, %r9, %r10, %r11 : vector<4xf32>
  %v3 = vector.from_elements %r12, %r13, %r14, %r15 : vector<4xf32>
  %v4 = vector.from_elements %r16, %r17, %r18, %r19 : vector<4xf32>
  %o0_p = llvm.inttoptr %o0 : i32 to !llvm.ptr<1>
  llvm.store %v0, %o0_p {alignment = 4 : i64} : vector<4xf32>, !llvm.ptr<1>
  %o1_p = llvm.inttoptr %o1 : i32 to !llvm.ptr<1>
  llvm.store %v1, %o1_p {alignment = 4 : i64} : vector<4xf32>, !llvm.ptr<1>
  %o2_p = llvm.inttoptr %o2 : i32 to !llvm.ptr<1>
  llvm.store %v2, %o2_p {alignment = 4 : i64} : vector<4xf32>, !llvm.ptr<1>
  %o3_p = llvm.inttoptr %o3 : i32 to !llvm.ptr<1>
  llvm.store %v3, %o3_p {alignment = 4 : i64} : vector<4xf32>, !llvm.ptr<1>
  %o4_p = llvm.inttoptr %o4 : i32 to !llvm.ptr<1>
  llvm.store %v4, %o4_p {alignment = 4 : i64} : vector<4xf32>, !llvm.ptr<1>
  gpu.return
  }
}
}
