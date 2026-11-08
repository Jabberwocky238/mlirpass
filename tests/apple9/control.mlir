// Structured control flow for Apple9, the condition differing between lanes: invocation i reads a = the word at
// src + 4 i and writes four words at dst + 16 i: a > 5 ? a * 3 : a + 9 (an if with a result); the loop s = s * 5 + k
// for k < a; the loop over k < (a & 7) of an if (k odd: acc + k, else acc ^ 3) from acc = a; and, for an odd a only
// (an if with a store and no else), a + 1000.
module attributes {gpu.container_module} {
gpu.module @shaders [#apple9.target<chip = "m4">] {
  gpu.func @control(%src: i32, %dst: i32) kernel {
  %g_ix = gpu.block_id x
  %g = arith.index_cast %g_ix : index to i32
  %l_ix = gpu.thread_id x
  %l = arith.index_cast %l_ix : index to i32
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c3 = arith.constant 3 : i32
  %c4 = arith.constant 4 : i32
  %c5 = arith.constant 5 : i32
  %c7 = arith.constant 7 : i32
  %c9 = arith.constant 9 : i32
  %c12 = arith.constant 12 : i32
  %c16 = arith.constant 16 : i32
  %c32 = arith.constant 32 : i32
  %c1000 = arith.constant 1000 : i32
  %base = arith.muli %g, %c32 : i32
  %i = arith.addi %base, %l : i32
  %in = arith.muli %i, %c4 : i32
  %at = arith.addi %src, %in : i32
  %at_p = llvm.inttoptr %at : i32 to !llvm.ptr<1>
  %a = llvm.load %at_p {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %big = arith.cmpi sgt, %a, %c5 : i32
  %r0 = scf.if %big -> (i32) {
    %t = arith.muli %a, %c3 : i32
    scf.yield %t : i32
  } else {
    %e = arith.addi %a, %c9 : i32
    scf.yield %e : i32
  }
  %r1 = scf.for %k = %c0 to %a step %c1 iter_args(%s = %c0) -> (i32) : i32 {
    %s5 = arith.muli %s, %c5 : i32
    %n = arith.addi %s5, %k : i32
    scf.yield %n : i32
  }
  %m = arith.andi %a, %c7 : i32
  %r2 = scf.for %k = %c0 to %m step %c1 iter_args(%acc = %a) -> (i32) : i32 {
    %odd_k = arith.andi %k, %c1 : i32
    %is_odd = arith.cmpi ne, %odd_k, %c0 : i32
    %next = scf.if %is_odd -> (i32) {
      %p = arith.addi %acc, %k : i32
      scf.yield %p : i32
    } else {
      %x = arith.xori %acc, %c3 : i32
      scf.yield %x : i32
    }
    scf.yield %next : i32
  }
  %out = arith.muli %i, %c16 : i32
  %o0 = arith.addi %dst, %out : i32
  %v = vector.from_elements %r0, %r1, %r2 : vector<3xi32>
  %o0_p = llvm.inttoptr %o0 : i32 to !llvm.ptr<1>
  llvm.store %v, %o0_p {alignment = 4 : i64} : vector<3xi32>, !llvm.ptr<1>
  %odd_a = arith.andi %a, %c1 : i32
  %is_odd_a = arith.cmpi ne, %odd_a, %c0 : i32
  scf.if %is_odd_a {
    %o3 = arith.addi %o0, %c12 : i32
    %mark = arith.addi %a, %c1000 : i32
    %o3_p = llvm.inttoptr %o3 : i32 to !llvm.ptr<1>
    llvm.store %mark, %o3_p {alignment = 4 : i64} : i32, !llvm.ptr<1>
  }
  gpu.return
  }
}
}
