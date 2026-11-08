// acgpu's crates/intel/driver/examples/control/loops.mlir in upstream dialects.
module attributes {gpu.container_module} {
gpu.module @shaders [#xevm.target<chip = "ptl">] {
gpu.func @loops(%dst: i32) kernel {
  %g_ix1 = gpu.block_id x
  %g = arith.index_cast %g_ix1 : index to i32
  %l_ix2 = gpu.thread_id x
  %l = arith.index_cast %l_ix2 : index to i32
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c3 = arith.constant 3 : i32
  %c4 = arith.constant 4 : i32
  %c5 = arith.constant 5 : i32
  %c7 = arith.constant 7 : i32
  %c10 = arith.constant 10 : i32
  %c16 = arith.constant 16 : i32
  %c100 = arith.constant 100 : i32
  %base = arith.muli %g, %c16 : i32
  %i = arith.addi %base, %l : i32
  %r0 = scf.for %k = %c0 to %c10 step %c1 iter_args(%a = %c0) -> (i32) : i32 {
    %ki = arith.muli %k, %i : i32
    %t = arith.addi %ki, %c3 : i32
    %n = arith.addi %a, %t : i32
    scf.yield %n : i32
  }
  %m = arith.andi %i, %c7 : i32
  %r1 = scf.for %k = %c0 to %m step %c1 iter_args(%a = %c1) -> (i32) : i32 {
    %a3 = arith.muli %a, %c3 : i32
    %n = arith.addi %a3, %k : i32
    scf.yield %n : i32
  }
  %odd = arith.andi %i, %c1 : i32
  %isodd = arith.cmpi ne, %odd, %c0 : i32
  %r2 = scf.if %isodd -> (i32) {
    %v = arith.muli %i, %c5 : i32
    scf.yield %v : i32
  } else {
    %v = arith.subi %c100, %i : i32
    scf.yield %v : i32
  }
  %m3 = arith.andi %i, %c3 : i32
  %r3 = scf.for %k = %c0 to %c4 step %c1 iter_args(%a = %c0) -> (i32) : i32 {
    %lt = arith.cmpi slt, %k, %m3 : i32
    %add = scf.if %lt -> (i32) {
      %k5 = arith.muli %k, %c5 : i32
      scf.yield %k5 : i32
    } else {
      %i10 = arith.addi %i, %c10 : i32
      scf.yield %i10 : i32
    }
    %n = arith.addi %a, %add : i32
    scf.yield %n : i32
  }
  %x0 = arith.addi %i, %c1 : i32
  %w:2 = "scf.while"(%x0, %c0) ({
  ^bb0(%x: i32, %n: i32):
    %more = arith.cmpi ne, %x, %c1 : i32
    "scf.condition"(%more, %x, %n) : (i1, i32, i32) -> ()
  }, {
  ^bb0(%x2: i32, %n2: i32):
    %xo = arith.andi %x2, %c1 : i32
    %xodd = arith.cmpi ne, %xo, %c0 : i32
    %half = arith.shrui %x2, %c1 : i32
    %x3 = arith.muli %x2, %c3 : i32
    %up = arith.addi %x3, %c1 : i32
    %next = arith.select %xodd, %up, %half : i32
    %n3 = arith.addi %n2, %c1 : i32
    "scf.yield"(%next, %n3) : (i32, i32) -> ()
  }) : (i32, i32) -> (i32, i32)
  %v = "vector.from_elements"(%r0, %r1, %r2, %r3) : (i32, i32, i32, i32) -> vector<4xi32>
  %c32 = arith.constant 32 : i32
  %off = arith.muli %i, %c32 : i32
  %at = arith.addi %dst, %off : i32
  %st_p3 = llvm.inttoptr %at : i32 to !llvm.ptr<1>
  llvm.store %v, %st_p3 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr<1>
  %at4 = arith.addi %at, %c16 : i32
  %st_p4 = llvm.inttoptr %at4 : i32 to !llvm.ptr<1>
  llvm.store %w#1, %st_p4 {alignment = 4 : i64} : i32, !llvm.ptr<1>
  gpu.return
}
}
}
