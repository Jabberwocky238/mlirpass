// tests/apple9/ints.mlir in workgroups of 16 (known_block_size 16 x 1 x 1, as acgpu's kernels: Xe3's SIMD16), two to a
// hardware workgroup of 32: invocation i = 16 g + l reads 8 bytes at src + 8 i and writes twenty results at dst + 80 i.
module attributes {gpu.container_module} {
gpu.module @shaders [#apple9.target<chip = "m4">] {
  gpu.func @halves(%src: i32, %dst: i32) kernel attributes {known_block_size = array<i32: 16, 1, 1>} {
  %g_ix = gpu.block_id x
  %g = arith.index_cast %g_ix : index to i32
  %l_ix = gpu.thread_id x
  %l = arith.index_cast %l_ix : index to i32
  %c16w = arith.constant 16 : i32
  %base = arith.muli %g, %c16w : i32
  %i = arith.addi %base, %l : i32
  %c8 = arith.constant 8 : i32
  %in = arith.muli %i, %c8 : i32
  %at = arith.addi %src, %in : i32
  %at_p = llvm.inttoptr %at : i32 to !llvm.ptr<1>
  %ab = llvm.load %at_p {alignment = 4 : i64} : !llvm.ptr<1> -> vector<2xi32>
  %a = vector.extract %ab[0] : i32 from vector<2xi32>
  %b = vector.extract %ab[1] : i32 from vector<2xi32>
  %c31 = arith.constant 31 : i32
  %s = arith.andi %b, %c31 : i32
  %r0 = arith.addi %a, %b : i32
  %r1 = arith.subi %a, %b : i32
  %r2 = arith.muli %a, %b : i32
  %r3 = arith.shli %a, %s : i32
  %r4 = arith.shrui %a, %s : i32
  %r5 = arith.shrsi %a, %s : i32
  %r6 = arith.andi %a, %b : i32
  %r7 = arith.ori %a, %b : i32
  %r8 = arith.xori %a, %b : i32
  %r9 = arith.minsi %a, %b : i32
  %r10 = arith.maxsi %a, %b : i32
  %r11 = arith.minui %a, %b : i32
  %r12 = arith.maxui %a, %b : i32
  %lt = arith.cmpi slt, %a, %b : i32
  %r13 = arith.select %lt, %a, %b : i32
  %ult = arith.cmpi ult, %a, %b : i32
  %r14 = arith.extui %ult : i1 to i32
  %eq = arith.cmpi eq, %a, %b : i32
  %r15 = arith.extsi %eq : i1 to i32
  %fa = arith.sitofp %a : i32 to f32
  %r16 = arith.bitcast %fa : f32 to i32
  %ua = arith.uitofp %a : i32 to f32
  %r17 = arith.bitcast %ua : f32 to i32
  %k = arith.constant 0.37 : f32
  %fk = arith.mulf %fa, %k : f32
  %r18 = arith.fptosi %fk : f32 to i32
  %fabs = math.absf %fk : f32
  %r19 = arith.fptoui %fabs : f32 to i32
  %c80 = arith.constant 80 : i32
  %out = arith.muli %i, %c80 : i32
  %o0 = arith.addi %dst, %out : i32
  %c = arith.constant 16 : i32
  %o1 = arith.addi %o0, %c : i32
  %o2 = arith.addi %o1, %c : i32
  %o3 = arith.addi %o2, %c : i32
  %o4 = arith.addi %o3, %c : i32
  %v0 = "vector.from_elements"(%r0, %r1, %r2, %r3) : (i32, i32, i32, i32) -> vector<4xi32>
  %v1 = "vector.from_elements"(%r4, %r5, %r6, %r7) : (i32, i32, i32, i32) -> vector<4xi32>
  %v2 = "vector.from_elements"(%r8, %r9, %r10, %r11) : (i32, i32, i32, i32) -> vector<4xi32>
  %v3 = "vector.from_elements"(%r12, %r13, %r14, %r15) : (i32, i32, i32, i32) -> vector<4xi32>
  %v4 = "vector.from_elements"(%r16, %r17, %r18, %r19) : (i32, i32, i32, i32) -> vector<4xi32>
  %o0_p = llvm.inttoptr %o0 : i32 to !llvm.ptr<1>
  llvm.store %v0, %o0_p {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr<1>
  %o1_p = llvm.inttoptr %o1 : i32 to !llvm.ptr<1>
  llvm.store %v1, %o1_p {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr<1>
  %o2_p = llvm.inttoptr %o2 : i32 to !llvm.ptr<1>
  llvm.store %v2, %o2_p {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr<1>
  %o3_p = llvm.inttoptr %o3 : i32 to !llvm.ptr<1>
  llvm.store %v3, %o3_p {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr<1>
  %o4_p = llvm.inttoptr %o4 : i32 to !llvm.ptr<1>
  llvm.store %v4, %o4_p {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr<1>
  gpu.return
  }
}
}
