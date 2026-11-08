// acgpu's crates/intel/driver/src/paths/pairs.mlir in upstream dialects.
module attributes {gpu.container_module} {
gpu.module @shaders [#xevm.target<chip = "ptl">] {
func.func private @lane() -> i32 {
  %c16 = arith.constant 16 : i32
  %g_ix1 = gpu.block_id x
  %g = arith.index_cast %g_ix1 : index to i32
  %l_ix2 = gpu.thread_id x
  %l = arith.index_cast %l_ix2 : index to i32
  %b0 = arith.muli %g, %c16 : i32
  %i = arith.addi %b0, %l : i32
  return %i : i32
}
func.func private @param(%params: i32, %k: i32) -> i32 {
  %c4 = arith.constant 4 : i32
  %o = arith.muli %k, %c4 : i32
  %a = arith.addi %params, %o : i32
  %v_p3 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
  %v = llvm.load %v_p3 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  return %v : i32
}
func.func private @word(%a: i32, %i: i32) -> i32 {
  %c4 = arith.constant 4 : i32
  %o = arith.muli %i, %c4 : i32
  %at = arith.addi %a, %o : i32
  %v_p4 = llvm.inttoptr %at : i32 to !llvm.ptr<1>
  %v = llvm.load %v_p4 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  return %v : i32
}
func.func private @put(%a: i32, %i: i32, %v: i32) {
  %c4 = arith.constant 4 : i32
  %o = arith.muli %i, %c4 : i32
  %at = arith.addi %a, %o : i32
  %st_p5 = llvm.inttoptr %at : i32 to !llvm.ptr<1>
  llvm.store %v, %st_p5 {alignment = 4 : i64} : i32, !llvm.ptr<1>
  return
}
func.func private @srow(%sb: i32, %i: i32) -> i32 {
  %c8 = arith.constant 8 : i32
  %c18 = arith.constant 18 : i32
  %o = arith.muli %i, %c8 : i32
  %a = arith.addi %sb, %o : i32
  %w_p6 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
  %w = llvm.load %w_p6 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %r = arith.shrui %w, %c18 : i32
  return %r : i32
}
func.func private @pair_of(%params: i32, %s: i32) -> (i32, i32) {
  %c3 = arith.constant 3 : i32
  %c5 = arith.constant 5 : i32
  %c6 = arith.constant 6 : i32
  %c8 = arith.constant 8 : i32
  %prow = func.call @param(%params, %c3) : (i32, i32) -> i32
  %pairbase = func.call @param(%params, %c5) : (i32, i32) -> i32
  %pairpath = func.call @param(%params, %c6) : (i32, i32) -> i32
  %p = func.call @word(%pairpath, %s) : (i32, i32) -> i32
  %p2 = arith.muli %p, %c8 : i32
  %ra = arith.addi %prow, %p2 : i32
  %r0_p7 = llvm.inttoptr %ra : i32 to !llvm.ptr<1>
  %r0 = llvm.load %r0_p7 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %b = func.call @word(%pairbase, %p) : (i32, i32) -> i32
  %d = arith.subi %s, %b : i32
  %row = arith.addi %r0, %d : i32
  return %p, %row : i32, i32
}
gpu.func @prows(%params: i32, %npaths: i32) kernel {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c2 = arith.constant 2 : i32
  %c3 = arith.constant 3 : i32
  %c4 = arith.constant 4 : i32
  %c8 = arith.constant 8 : i32
  %c32 = arith.constant 32 : i32
  %p = func.call @lane() : () -> i32
  %inside = arith.cmpi slt, %p, %npaths : i32
  scf.if %inside {
    %strips = func.call @param(%params, %c0) : (i32, i32) -> i32
    %paths = func.call @param(%params, %c1) : (i32, i32) -> i32
    %consts = func.call @param(%params, %c2) : (i32, i32) -> i32
    %prow = func.call @param(%params, %c3) : (i32, i32) -> i32
    %prcount = func.call @param(%params, %c4) : (i32, i32) -> i32
    %ka = arith.addi %consts, %c4 : i32
    %rows_p8 = llvm.inttoptr %ka : i32 to !llvm.ptr<1>
    %rows = llvm.load %rows_p8 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %po = arith.muli %p, %c32 : i32
    %pa = arith.addi %paths, %po : i32
    %pv_p9 = llvm.inttoptr %pa : i32 to !llvm.ptr<1>
    %pv = llvm.load %pv_p9 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<2xi32>
    %s0 = vector.extract %pv[0] : i32 from vector<2xi32>
    %ns = vector.extract %pv[1] : i32 from vector<2xi32>
    %some = arith.cmpi sge, %ns, %c2 : i32
    %rr:2 = scf.if %some -> (i32, i32) {
      %sb0 = arith.muli %s0, %c8 : i32
      %sb = arith.addi %strips, %sb0 : i32
      %y0 = func.call @srow(%sb, %c0) : (i32, i32) -> i32
      %i1 = arith.subi %ns, %c2 : i32
      %y1 = func.call @srow(%sb, %i1) : (i32, i32) -> i32
      %rm = arith.subi %rows, %c1 : i32
      %y1c = arith.minui %y1, %rm : i32
      %within = arith.cmpi ult, %y0, %rows : i32
      %n0 = arith.subi %y1c, %y0 : i32
      %n1 = arith.addi %n0, %c1 : i32
      %n = arith.select %within, %n1, %c0 : i32
      scf.yield %y0, %n : i32, i32
    } else {
      scf.yield %c0, %c0 : i32, i32
    }
    %p8 = arith.muli %p, %c8 : i32
    %ra = arith.addi %prow, %p8 : i32
    %v = vector.from_elements %rr#0, %rr#1 : vector<2xi32>
    %st_p10 = llvm.inttoptr %ra : i32 to !llvm.ptr<1>
    llvm.store %v, %st_p10 {alignment = 4 : i64} : vector<2xi32>, !llvm.ptr<1>
    func.call @put(%prcount, %p, %rr#1) : (i32, i32, i32) -> ()
  }
  gpu.return
}
gpu.func @pfill(%params: i32, %npaths: i32) kernel {
  %c1 = arith.constant 1 : i32
  %c3 = arith.constant 3 : i32
  %c4 = arith.constant 4 : i32
  %c5 = arith.constant 5 : i32
  %c6 = arith.constant 6 : i32
  %c7 = arith.constant 7 : i32
  %c8 = arith.constant 8 : i32
  %p = func.call @lane() : () -> i32
  %inside = arith.cmpi slt, %p, %npaths : i32
  scf.if %inside {
    %prow = func.call @param(%params, %c3) : (i32, i32) -> i32
    %pairbase = func.call @param(%params, %c5) : (i32, i32) -> i32
    %pairpath = func.call @param(%params, %c6) : (i32, i32) -> i32
    %rowcount = func.call @param(%params, %c7) : (i32, i32) -> i32
    %p8 = arith.muli %p, %c8 : i32
    %ra = arith.addi %prow, %p8 : i32
    %rv_p11 = llvm.inttoptr %ra : i32 to !llvm.ptr<1>
    %rv = llvm.load %rv_p11 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<2xi32>
    %r0 = vector.extract %rv[0] : i32 from vector<2xi32>
    %nr = vector.extract %rv[1] : i32 from vector<2xi32>
    %b = func.call @word(%pairbase, %p) : (i32, i32) -> i32
    %c0 = arith.constant 0 : i32
    scf.for %k = %c0 to %nr step %c1 : i32 {
      %s = arith.addi %b, %k : i32
      func.call @put(%pairpath, %s, %p) : (i32, i32, i32) -> ()
      %row = arith.addi %r0, %k : i32
      %r4 = arith.muli %row, %c4 : i32
      %ca = arith.addi %rowcount, %r4 : i32
      %old_p12 = llvm.inttoptr %ca : i32 to !llvm.ptr<1>
      %old = llvm.atomicrmw add %old_p12, %c1 monotonic : !llvm.ptr<1>, i32
    }
  }
  gpu.return
}
gpu.func @pplace(%params: i32, %npairs: i32) kernel {
  %c1 = arith.constant 1 : i32
  %c4 = arith.constant 4 : i32
  %c8 = arith.constant 8 : i32
  %c9 = arith.constant 9 : i32
  %c10 = arith.constant 10 : i32
  %s = func.call @lane() : () -> i32
  %inside = arith.cmpi slt, %s, %npairs : i32
  scf.if %inside {
    %pr:2 = func.call @pair_of(%params, %s) : (i32, i32) -> (i32, i32)
    %rowstart = func.call @param(%params, %c8) : (i32, i32) -> i32
    %rowfill = func.call @param(%params, %c9) : (i32, i32) -> i32
    %bucket = func.call @param(%params, %c10) : (i32, i32) -> i32
    %st = func.call @word(%rowstart, %pr#1) : (i32, i32) -> i32
    %r4 = arith.muli %pr#1, %c4 : i32
    %fa = arith.addi %rowfill, %r4 : i32
    %k_p13 = llvm.inttoptr %fa : i32 to !llvm.ptr<1>
    %k = llvm.atomicrmw add %k_p13, %c1 monotonic : !llvm.ptr<1>, i32
    %at = arith.addi %st, %k : i32
    func.call @put(%bucket, %at, %s) : (i32, i32, i32) -> ()
  }
  gpu.return
}
gpu.func @prank(%params: i32, %npairs: i32) kernel {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c6 = arith.constant 6 : i32
  %c8 = arith.constant 8 : i32
  %c10 = arith.constant 10 : i32
  %c11 = arith.constant 11 : i32
  %j = func.call @lane() : () -> i32
  %inside = arith.cmpi slt, %j, %npairs : i32
  scf.if %inside {
    %pairpath = func.call @param(%params, %c6) : (i32, i32) -> i32
    %rowstart = func.call @param(%params, %c8) : (i32, i32) -> i32
    %bucket = func.call @param(%params, %c10) : (i32, i32) -> i32
    %sorted = func.call @param(%params, %c11) : (i32, i32) -> i32
    %s = func.call @word(%bucket, %j) : (i32, i32) -> i32
    %pr:2 = func.call @pair_of(%params, %s) : (i32, i32) -> (i32, i32)
    %st = func.call @word(%rowstart, %pr#1) : (i32, i32) -> i32
    %r1 = arith.addi %pr#1, %c1 : i32
    %en = func.call @word(%rowstart, %r1) : (i32, i32) -> i32
    %rank = scf.for %q = %st to %en step %c1 iter_args(%r = %c0) -> (i32) : i32 {
      %sq = func.call @word(%bucket, %q) : (i32, i32) -> i32
      %pq = func.call @word(%pairpath, %sq) : (i32, i32) -> i32
      %before = arith.cmpi slt, %pq, %pr#0 : i32
      %r2 = arith.addi %r, %c1 : i32
      %rn = arith.select %before, %r2, %r : i32
      scf.yield %rn : i32
    }
    %pos = arith.addi %st, %rank : i32
    func.call @put(%sorted, %s, %pos) : (i32, i32, i32) -> ()
  }
  gpu.return
}
gpu.func @pgather(%params: i32, %npairs: i32) kernel {
  %c11 = arith.constant 11 : i32
  %c12 = arith.constant 12 : i32
  %c13 = arith.constant 13 : i32
  %c14 = arith.constant 14 : i32
  %c15 = arith.constant 15 : i32
  %s = func.call @lane() : () -> i32
  %inside = arith.cmpi slt, %s, %npairs : i32
  scf.if %inside {
    %sorted = func.call @param(%params, %c11) : (i32, i32) -> i32
    %ctab = func.call @param(%params, %c12) : (i32, i32) -> i32
    %dtab = func.call @param(%params, %c13) : (i32, i32) -> i32
    %sc = func.call @param(%params, %c14) : (i32, i32) -> i32
    %sd = func.call @param(%params, %c15) : (i32, i32) -> i32
    %pos = func.call @word(%sorted, %s) : (i32, i32) -> i32
    %c = func.call @word(%ctab, %s) : (i32, i32) -> i32
    %d = func.call @word(%dtab, %s) : (i32, i32) -> i32
    func.call @put(%sc, %pos, %c) : (i32, i32, i32) -> ()
    func.call @put(%sd, %pos, %d) : (i32, i32, i32) -> ()
  }
  gpu.return
}
}
}
