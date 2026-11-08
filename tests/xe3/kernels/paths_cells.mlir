// acgpu's crates/intel/driver/src/paths/cells.mlir in upstream dialects.
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
func.func private @tile(%params: i32, %i: i32) -> (i32, i32, i32, i32) {
  %c0 = arith.constant 0 : i32
  %c3 = arith.constant 3 : i32
  %c8 = arith.constant 8 : i32
  %c16 = arith.constant 16 : i32
  %cffff = arith.constant 65535 : i32
  %tiles = func.call @param(%params, %c0) : (i32, i32) -> i32
  %paths = func.call @param(%params, %c3) : (i32, i32) -> i32
  %p = func.call @word(%paths, %i) : (i32, i32) -> i32
  %o = arith.muli %i, %c8 : i32
  %ta = arith.addi %tiles, %o : i32
  %t_p6 = llvm.inttoptr %ta : i32 to !llvm.ptr<1>
  %t = llvm.load %t_p6 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<2xi32>
  %lo = vector.extract %t[0] : i32 from vector<2xi32>
  %hi = vector.extract %t[1] : i32 from vector<2xi32>
  %x = arith.andi %hi, %cffff : i32
  %y = arith.shrui %hi, %c16 : i32
  return %p, %x, %y, %lo : i32, i32, i32, i32
}
func.func private @cell(%params: i32, %p: i32, %x: i32, %y: i32) -> i32 {
  %c1 = arith.constant 1 : i32
  %c4 = arith.constant 4 : i32
  %c6 = arith.constant 6 : i32
  %c16 = arith.constant 16 : i32
  %bbox = func.call @param(%params, %c4) : (i32, i32) -> i32
  %cbase = func.call @param(%params, %c6) : (i32, i32) -> i32
  %po = arith.muli %p, %c16 : i32
  %ba = arith.addi %bbox, %po : i32
  %b_p7 = llvm.inttoptr %ba : i32 to !llvm.ptr<1>
  %b = llvm.load %b_p7 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xi32>
  %x0 = vector.extract %b[0] : i32 from vector<4xi32>
  %y0 = vector.extract %b[1] : i32 from vector<4xi32>
  %x1 = vector.extract %b[2] : i32 from vector<4xi32>
  %w0 = arith.subi %x1, %x0 : i32
  %w = arith.addi %w0, %c1 : i32
  %base = func.call @word(%cbase, %p) : (i32, i32) -> i32
  %dy = arith.subi %y, %y0 : i32
  %dx = arith.subi %x, %x0 : i32
  %r = arith.muli %dy, %w : i32
  %c0 = arith.addi %base, %r : i32
  %c = arith.addi %c0, %dx : i32
  return %c : i32
}
gpu.func @paths(%params: i32, %npaths: i32) kernel {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c2 = arith.constant 2 : i32
  %c3 = arith.constant 3 : i32
  %c4 = arith.constant 4 : i32
  %c16 = arith.constant 16 : i32
  %p = func.call @lane() : () -> i32
  %inside = arith.cmpi slt, %p, %npaths : i32
  scf.if %inside {
    %offsets = func.call @param(%params, %c1) : (i32, i32) -> i32
    %counts = func.call @param(%params, %c2) : (i32, i32) -> i32
    %paths = func.call @param(%params, %c3) : (i32, i32) -> i32
    %bbox = func.call @param(%params, %c4) : (i32, i32) -> i32
    %first = func.call @word(%offsets, %p) : (i32, i32) -> i32
    %n = func.call @word(%counts, %p) : (i32, i32) -> i32
    %end = arith.addi %first, %n : i32
    scf.for %i = %first to %end step %c1 : i32 {
      func.call @put(%paths, %i, %p) : (i32, i32, i32) -> ()
    }
    %ones = arith.constant -1 : i32
    %e = vector.from_elements %ones, %ones, %c0, %c0 : vector<4xi32>
    %po = arith.muli %p, %c16 : i32
    %ba = arith.addi %bbox, %po : i32
    %st_p8 = llvm.inttoptr %ba : i32 to !llvm.ptr<1>
    llvm.store %e, %st_p8 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr<1>
  }
  gpu.return
}
func.func private @merge_box(%params: i32, %p: i32, %x0: i32, %y0: i32, %x1: i32, %y1: i32) {
  %c4 = arith.constant 4 : i32
  %c8 = arith.constant 8 : i32
  %c12 = arith.constant 12 : i32
  %c16 = arith.constant 16 : i32
  %bbox = func.call @param(%params, %c4) : (i32, i32) -> i32
  %po = arith.muli %p, %c16 : i32
  %b0 = arith.addi %bbox, %po : i32
  %o0_p9 = llvm.inttoptr %b0 : i32 to !llvm.ptr<1>
  %o0 = llvm.atomicrmw umin %o0_p9, %x0 monotonic : !llvm.ptr<1>, i32
  %b1 = arith.addi %b0, %c4 : i32
  %o1_p10 = llvm.inttoptr %b1 : i32 to !llvm.ptr<1>
  %o1 = llvm.atomicrmw umin %o1_p10, %y0 monotonic : !llvm.ptr<1>, i32
  %b2 = arith.addi %b0, %c8 : i32
  %o2_p11 = llvm.inttoptr %b2 : i32 to !llvm.ptr<1>
  %o2 = llvm.atomicrmw umax %o2_p11, %x1 monotonic : !llvm.ptr<1>, i32
  %b3 = arith.addi %b0, %c12 : i32
  %o3_p12 = llvm.inttoptr %b3 : i32 to !llvm.ptr<1>
  %o3 = llvm.atomicrmw umax %o3_p12, %y1 monotonic : !llvm.ptr<1>, i32
  return
}
gpu.func @bbox(%params: i32, %n: i32) kernel {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c5 = arith.constant 5 : i32
  %c32 = arith.constant 32 : i32
  %ones = arith.constant -1 : i32
  %j = func.call @lane() : () -> i32
  %first = arith.shli %j, %c5 : i32
  %inside = arith.cmpi slt, %first, %n : i32
  scf.if %inside {
    %e0 = arith.addi %first, %c32 : i32
    %end = arith.minui %e0, %n : i32
    %t0:4 = func.call @tile(%params, %first) : (i32, i32) -> (i32, i32, i32, i32)
    %r:5 = scf.for %i = %first to %end step %c1 iter_args(%p = %t0#0, %x0 = %ones, %y0 = %ones, %x1 = %c0, %y1 = %c0) -> (i32, i32, i32, i32, i32) : i32 {
      %t:4 = func.call @tile(%params, %i) : (i32, i32) -> (i32, i32, i32, i32)
      %other = arith.cmpi ne, %t#0, %p : i32
      %b:4 = scf.if %other -> (i32, i32, i32, i32) {
        func.call @merge_box(%params, %p, %x0, %y0, %x1, %y1) : (i32, i32, i32, i32, i32, i32) -> ()
        scf.yield %ones, %ones, %c0, %c0 : i32, i32, i32, i32
      } else {
        scf.yield %x0, %y0, %x1, %y1 : i32, i32, i32, i32
      }
      %nx0 = arith.minui %b#0, %t#1 : i32
      %ny0 = arith.minui %b#1, %t#2 : i32
      %nx1 = arith.maxui %b#2, %t#1 : i32
      %ny1 = arith.maxui %b#3, %t#2 : i32
      scf.yield %t#0, %nx0, %ny0, %nx1, %ny1 : i32, i32, i32, i32, i32
    }
    func.call @merge_box(%params, %r#0, %r#1, %r#2, %r#3, %r#4) : (i32, i32, i32, i32, i32, i32) -> ()
  }
  gpu.return
}
gpu.func @cells(%params: i32, %npaths: i32) kernel {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c4 = arith.constant 4 : i32
  %c5 = arith.constant 5 : i32
  %c16 = arith.constant 16 : i32
  %p = func.call @lane() : () -> i32
  %inside = arith.cmpi slt, %p, %npaths : i32
  scf.if %inside {
    %bbox = func.call @param(%params, %c4) : (i32, i32) -> i32
    %ccount = func.call @param(%params, %c5) : (i32, i32) -> i32
    %po = arith.muli %p, %c16 : i32
    %ba = arith.addi %bbox, %po : i32
    %b_p13 = llvm.inttoptr %ba : i32 to !llvm.ptr<1>
    %b = llvm.load %b_p13 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xi32>
    %x0 = vector.extract %b[0] : i32 from vector<4xi32>
    %y0 = vector.extract %b[1] : i32 from vector<4xi32>
    %x1 = vector.extract %b[2] : i32 from vector<4xi32>
    %y1 = vector.extract %b[3] : i32 from vector<4xi32>
    %some = arith.cmpi ule, %x0, %x1 : i32
    %w0 = arith.subi %x1, %x0 : i32
    %w = arith.addi %w0, %c1 : i32
    %h0 = arith.subi %y1, %y0 : i32
    %h = arith.addi %h0, %c1 : i32
    %wh = arith.muli %w, %h : i32
    %n = arith.select %some, %wh, %c0 : i32
    func.call @put(%ccount, %p, %n) : (i32, i32, i32) -> ()
  }
  gpu.return
}
gpu.func @count(%params: i32, %n: i32) kernel {
  %c1 = arith.constant 1 : i32
  %c4 = arith.constant 4 : i32
  %c7 = arith.constant 7 : i32
  %i = func.call @lane() : () -> i32
  %inside = arith.cmpi slt, %i, %n : i32
  scf.if %inside {
    %t:4 = func.call @tile(%params, %i) : (i32, i32) -> (i32, i32, i32, i32)
    %c = func.call @cell(%params, %t#0, %t#1, %t#2) : (i32, i32, i32, i32) -> i32
    %cellcount = func.call @param(%params, %c7) : (i32, i32) -> i32
    %co = arith.muli %c, %c4 : i32
    %ca = arith.addi %cellcount, %co : i32
    %old_p14 = llvm.inttoptr %ca : i32 to !llvm.ptr<1>
    %old = llvm.atomicrmw add %old_p14, %c1 monotonic : !llvm.ptr<1>, i32
  }
  gpu.return
}
gpu.func @place(%params: i32, %n: i32) kernel {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c4 = arith.constant 4 : i32
  %c8 = arith.constant 8 : i32
  %c9 = arith.constant 9 : i32
  %c10 = arith.constant 10 : i32
  %c16 = arith.constant 16 : i32
  %i = func.call @lane() : () -> i32
  %inside = arith.cmpi slt, %i, %n : i32
  scf.if %inside {
    %t:4 = func.call @tile(%params, %i) : (i32, i32) -> (i32, i32, i32, i32)
    %c = func.call @cell(%params, %t#0, %t#1, %t#2) : (i32, i32, i32, i32) -> i32
    %celloff = func.call @param(%params, %c8) : (i32, i32) -> i32
    %cellfill = func.call @param(%params, %c9) : (i32, i32) -> i32
    %tmp = func.call @param(%params, %c10) : (i32, i32) -> i32
    %start = func.call @word(%celloff, %c) : (i32, i32) -> i32
    %co = arith.muli %c, %c4 : i32
    %fa = arith.addi %cellfill, %co : i32
    %k_p15 = llvm.inttoptr %fa : i32 to !llvm.ptr<1>
    %k = llvm.atomicrmw add %k_p15, %c1 monotonic : !llvm.ptr<1>, i32
    %at = arith.addi %start, %k : i32
    %ao = arith.muli %at, %c16 : i32
    %ta = arith.addi %tmp, %ao : i32
    %c16b = arith.constant 16 : i32
    %hy = arith.shli %t#2, %c16b : i32
    %hi = arith.ori %hy, %t#1 : i32
    %v = vector.from_elements %t#3, %hi, %c, %c0 : vector<4xi32>
    %st_p16 = llvm.inttoptr %ta : i32 to !llvm.ptr<1>
    llvm.store %v, %st_p16 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr<1>
  }
  gpu.return
}
gpu.func @rank(%params: i32, %n: i32) kernel {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c7 = arith.constant 7 : i32
  %c8 = arith.constant 8 : i32
  %c10 = arith.constant 10 : i32
  %c16 = arith.constant 16 : i32
  %i = func.call @lane() : () -> i32
  %inside = arith.cmpi slt, %i, %n : i32
  scf.if %inside {
    %tiles = func.call @param(%params, %c0) : (i32, i32) -> i32
    %cellcount = func.call @param(%params, %c7) : (i32, i32) -> i32
    %celloff = func.call @param(%params, %c8) : (i32, i32) -> i32
    %tmp = func.call @param(%params, %c10) : (i32, i32) -> i32
    %io = arith.muli %i, %c16 : i32
    %ia = arith.addi %tmp, %io : i32
    %v_p17 = llvm.inttoptr %ia : i32 to !llvm.ptr<1>
    %v = llvm.load %v_p17 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xi32>
    %lo = vector.extract %v[0] : i32 from vector<4xi32>
    %hi = vector.extract %v[1] : i32 from vector<4xi32>
    %c = vector.extract %v[2] : i32 from vector<4xi32>
    %start = func.call @word(%celloff, %c) : (i32, i32) -> i32
    %cnt = func.call @word(%cellcount, %c) : (i32, i32) -> i32
    %end = arith.addi %start, %cnt : i32
    %rank = scf.for %j = %start to %end step %c1 iter_args(%r = %c0) -> (i32) : i32 {
      %jo = arith.muli %j, %c16 : i32
      %ja = arith.addi %tmp, %jo : i32
      %lj_p18 = llvm.inttoptr %ja : i32 to !llvm.ptr<1>
      %lj = llvm.load %lj_p18 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
      %below = arith.cmpi ult, %lj, %lo : i32
      %same = arith.cmpi eq, %lj, %lo : i32
      %earlier = arith.cmpi slt, %j, %i : i32
      %tie = arith.andi %same, %earlier : i1
      %one = arith.ori %below, %tie : i1
      %r1 = arith.addi %r, %c1 : i32
      %rn = arith.select %one, %r1, %r : i32
      scf.yield %rn : i32
    }
    %at = arith.addi %start, %rank : i32
    %ao = arith.muli %at, %c8 : i32
    %ta = arith.addi %tiles, %ao : i32
    %t = vector.from_elements %lo, %hi : vector<2xi32>
    %st_p19 = llvm.inttoptr %ta : i32 to !llvm.ptr<1>
    llvm.store %t, %st_p19 {alignment = 4 : i64} : vector<2xi32>, !llvm.ptr<1>
  }
  gpu.return
}
}
}
