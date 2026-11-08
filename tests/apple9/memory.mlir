// Threadgroup memory, barriers and atomics for Apple9: invocation i (l in its workgroup) reads a = the word at src + 4 i;
// puts a at word l and 7 a at word 32 + l of the threadgroup memory; after a barrier writes at dst + 8 i the words
// 31 - l and 32 + ((l + 5) & 31) summed (other lanes' writes) and the old value of an atomic add of i to the counter
// at cnt + 4 (i & 3); then umax i, smin -i, or i, xor i, and ~(1 << (i & 31)), sub 1, xchg i on the counters at cnt + 16 ..
module attributes {gpu.container_module} {
gpu.module @shaders [#apple9.target<chip = "m4">] {
  gpu.func @memory(%src: i32, %dst: i32, %cnt: i32) workgroup(%t : memref<64xi32, #gpu.address_space<workgroup>>) kernel {
  %g_ix = gpu.block_id x
  %g = arith.index_cast %g_ix : index to i32
  %l_ix = gpu.thread_id x
  %l = arith.index_cast %l_ix : index to i32
  %c1 = arith.constant 1 : i32
  %c3 = arith.constant 3 : i32
  %c4 = arith.constant 4 : i32
  %c5 = arith.constant 5 : i32
  %c7 = arith.constant 7 : i32
  %c8 = arith.constant 8 : i32
  %c31 = arith.constant 31 : i32
  %c32 = arith.constant 32 : i32
  %c128 = arith.constant 128 : i32
  %base = arith.muli %g, %c32 : i32
  %i = arith.addi %base, %l : i32
  %in = arith.muli %i, %c4 : i32
  %at = arith.addi %src, %in : i32
  %at_p = llvm.inttoptr %at : i32 to !llvm.ptr<1>
  %a = llvm.load %at_p {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %l4 = arith.muli %l, %c4 : i32
  %t0_p = llvm.inttoptr %l4 : i32 to !llvm.ptr<3>
  llvm.store %a, %t0_p {alignment = 4 : i64} : i32, !llvm.ptr<3>
  %a7 = arith.muli %a, %c7 : i32
  %u = arith.addi %l4, %c128 : i32
  %t1_p = llvm.inttoptr %u : i32 to !llvm.ptr<3>
  llvm.store %a7, %t1_p {alignment = 4 : i64} : i32, !llvm.ptr<3>
  gpu.barrier
  %m = arith.subi %c31, %l : i32
  %m4 = arith.muli %m, %c4 : i32
  %x_p = llvm.inttoptr %m4 : i32 to !llvm.ptr<3>
  %x = llvm.load %x_p {alignment = 4 : i64} : !llvm.ptr<3> -> i32
  %l5 = arith.addi %l, %c5 : i32
  %l5m = arith.andi %l5, %c31 : i32
  %l5m4 = arith.muli %l5m, %c4 : i32
  %y_at = arith.addi %l5m4, %c128 : i32
  %y_p = llvm.inttoptr %y_at : i32 to !llvm.ptr<3>
  %y = llvm.load %y_p {alignment = 4 : i64} : !llvm.ptr<3> -> i32
  %r0 = arith.addi %x, %y : i32
  %k = arith.andi %i, %c3 : i32
  %k4 = arith.muli %k, %c4 : i32
  %ca = arith.addi %cnt, %k4 : i32
  %ca_p = llvm.inttoptr %ca : i32 to !llvm.ptr<1>
  %r1 = llvm.atomicrmw add %ca_p, %i monotonic : !llvm.ptr<1>, i32
  %o = arith.muli %i, %c8 : i32
  %o0 = arith.addi %dst, %o : i32
  %v = vector.from_elements %r0, %r1 : vector<2xi32>
  %o0_p = llvm.inttoptr %o0 : i32 to !llvm.ptr<1>
  llvm.store %v, %o0_p {alignment = 4 : i64} : vector<2xi32>, !llvm.ptr<1>
  %c16 = arith.constant 16 : i32
  %p0 = arith.addi %cnt, %c16 : i32
  %p0_p = llvm.inttoptr %p0 : i32 to !llvm.ptr<1>
  %d0 = llvm.atomicrmw umax %p0_p, %i monotonic : !llvm.ptr<1>, i32
  %p1 = arith.addi %p0, %c4 : i32
  %p1_p = llvm.inttoptr %p1 : i32 to !llvm.ptr<1>
  %c0 = arith.constant 0 : i32
  %ni = arith.subi %c0, %i : i32
  %d1 = llvm.atomicrmw min %p1_p, %ni monotonic : !llvm.ptr<1>, i32
  %p2 = arith.addi %p1, %c4 : i32
  %p2_p = llvm.inttoptr %p2 : i32 to !llvm.ptr<1>
  %d2 = llvm.atomicrmw _or %p2_p, %i monotonic : !llvm.ptr<1>, i32
  %p3 = arith.addi %p2, %c4 : i32
  %p3_p = llvm.inttoptr %p3 : i32 to !llvm.ptr<1>
  %d3 = llvm.atomicrmw _xor %p3_p, %i monotonic : !llvm.ptr<1>, i32
  %p4 = arith.addi %p3, %c4 : i32
  %p4_p = llvm.inttoptr %p4 : i32 to !llvm.ptr<1>
  %bit_n = arith.andi %i, %c31 : i32
  %bit = arith.shli %c1, %bit_n : i32
  %cm1 = arith.constant -1 : i32
  %nbit = arith.xori %bit, %cm1 : i32
  %d4 = llvm.atomicrmw _and %p4_p, %nbit monotonic : !llvm.ptr<1>, i32
  %p5 = arith.addi %p4, %c4 : i32
  %p5_p = llvm.inttoptr %p5 : i32 to !llvm.ptr<1>
  %d5 = llvm.atomicrmw sub %p5_p, %c1 monotonic : !llvm.ptr<1>, i32
  %p6 = arith.addi %p5, %c4 : i32
  %p6_p = llvm.inttoptr %p6 : i32 to !llvm.ptr<1>
  %d6 = llvm.atomicrmw xchg %p6_p, %i monotonic : !llvm.ptr<1>, i32
  gpu.return
  }
}
}
