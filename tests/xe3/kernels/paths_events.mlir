// acgpu's crates/intel/driver/src/paths/events.mlir in upstream dialects.
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
func.func private @path(%cpaths: i32, %p: i32) -> (i32, i32, i32) {
  %c0 = arith.constant 0 : i32
  %c32 = arith.constant 32 : i32
  %some = arith.cmpi sge, %p, %c0 : i32
  %r:3 = scf.if %some -> (i32, i32, i32) {
    %o = arith.muli %p, %c32 : i32
    %a = arith.addi %cpaths, %o : i32
    %v_p4 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
    %v = llvm.load %v_p4 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xi32>
    %s0 = vector.extract %v[0] : i32 from vector<4xi32>
    %ns = vector.extract %v[1] : i32 from vector<4xi32>
    %ab = vector.extract %v[2] : i32 from vector<4xi32>
    scf.yield %s0, %ns, %ab : i32, i32, i32
  } else {
    scf.yield %c0, %c0, %c0 : i32, i32, i32
  }
  return %r#0, %r#1, %r#2 : i32, i32, i32
}
func.func private @item(%items: i32, %i: i32) -> (i32, i32, i32, i32) {
  %c16 = arith.constant 16 : i32
  %o = arith.muli %i, %c16 : i32
  %a = arith.addi %items, %o : i32
  %v_p5 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
  %v = llvm.load %v_p5 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xi32>
  %k = vector.extract %v[0] : i32 from vector<4xi32>
  %p = vector.extract %v[1] : i32 from vector<4xi32>
  %l = vector.extract %v[2] : i32 from vector<4xi32>
  %q = vector.extract %v[3] : i32 from vector<4xi32>
  return %k, %p, %l, %q : i32, i32, i32, i32
}
gpu.func @evflags(%params: i32, %n: i32) kernel {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c3 = arith.constant 3 : i32
  %c4 = arith.constant 4 : i32
  %i = func.call @lane() : () -> i32
  %inside = arith.cmpi slt, %i, %n : i32
  scf.if %inside {
    %cpaths = func.call @param(%params, %c0) : (i32, i32) -> i32
    %items = func.call @param(%params, %c1) : (i32, i32) -> i32
    %flags = func.call @param(%params, %c3) : (i32, i32) -> i32
    %it:4 = func.call @item(%items, %i) : (i32, i32) -> (i32, i32, i32, i32)
    %fill = arith.cmpi eq, %it#0, %c0 : i32
    %pp = arith.select %fill, %it#1, %c0 : i32
    %pth:3 = func.call @path(%cpaths, %it#1) : (i32, i32) -> (i32, i32, i32)
    %has = arith.cmpi ne, %pth#1, %c0 : i32
    %both = arith.andi %fill, %has : i1
    %f = arith.select %both, %c1, %c0 : i32
    %i4 = arith.muli %i, %c4 : i32
    %fa = arith.addi %flags, %i4 : i32
    %st_p6 = llvm.inttoptr %fa : i32 to !llvm.ptr<1>
    llvm.store %f, %st_p6 {alignment = 4 : i64} : i32, !llvm.ptr<1>
  }
  gpu.return
}
gpu.func @lclip(%params: i32, %nl: i32) kernel {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c2 = arith.constant 2 : i32
  %c4 = arith.constant 4 : i32
  %c8 = arith.constant 8 : i32
  %c9 = arith.constant 9 : i32
  %c10 = arith.constant 10 : i32
  %c16 = arith.constant 16 : i32
  %c20 = arith.constant 20 : i32
  %c32 = arith.constant 32 : i32
  %m = arith.constant 65535 : i32
  %big = arith.constant 65535 : i32
  %lm = func.call @lane() : () -> i32
  %inside = arith.cmpi slt, %lm, %nl : i32
  scf.if %inside {
    %cpaths = func.call @param(%params, %c0) : (i32, i32) -> i32
    %layers = func.call @param(%params, %c2) : (i32, i32) -> i32
    %strips = func.call @param(%params, %c8) : (i32, i32) -> i32
    %consts = func.call @param(%params, %c9) : (i32, i32) -> i32
    %own = func.call @param(%params, %c10) : (i32, i32) -> i32
    %cols_p7 = llvm.inttoptr %consts : i32 to !llvm.ptr<1>
    %cols = llvm.load %cols_p7 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %ra = arith.addi %consts, %c4 : i32
    %rows_p8 = llvm.inttoptr %ra : i32 to !llvm.ptr<1>
    %rows = llvm.load %rows_p8 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %lo = arith.muli %lm, %c32 : i32
    %la = arith.addi %layers, %lo : i32
    %cpa = arith.addi %la, %c20 : i32
    %cp_p9 = llvm.inttoptr %cpa : i32 to !llvm.ptr<1>
    %cp = llvm.load %cp_p9 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %clipped = arith.cmpi sge, %cp, %c0 : i32
    %b:4 = scf.if %clipped -> (i32, i32, i32, i32) {
      %pth:3 = func.call @path(%cpaths, %cp) : (i32, i32) -> (i32, i32, i32)
      %sb0 = arith.muli %pth#0, %c8 : i32
      %sb = arith.addi %strips, %sb0 : i32
      %last0 = arith.subi %pth#1, %c1 : i32
      %last = arith.maxsi %last0, %c0 : i32
      %r:4 = scf.for %i = %c0 to %last step %c1 iter_args(%x0 = %big, %y0 = %big, %x1 = %c0, %y1 = %c0) -> (i32, i32, i32, i32) : i32 {
        %o = arith.muli %i, %c8 : i32
        %a = arith.addi %sb, %o : i32
        %v_p10 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
        %v = llvm.load %v_p10 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<2xi32>
        %xy = vector.extract %v[0] : i32 from vector<2xi32>
        %pk = vector.extract %v[1] : i32 from vector<2xi32>
        %an = arith.addi %a, %c8 : i32
        %vn_p11 = llvm.inttoptr %an : i32 to !llvm.ptr<1>
        %vn = llvm.load %vn_p11 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<2xi32>
        %nxy = vector.extract %vn[0] : i32 from vector<2xi32>
        %npk = vector.extract %vn[1] : i32 from vector<2xi32>
        %x = arith.andi %xy, %m : i32
        %y = arith.shrui %xy, %c16 : i32
        %ty = arith.shrui %y, %c2 : i32
        %nx = arith.andi %nxy, %m : i32
        %ny = arith.shrui %nxy, %c16 : i32
        %mask = arith.constant 2147483647 : i32
        %ai = arith.andi %pk, %mask : i32
        %nai = arith.andi %npk, %mask : i32
        %c31 = arith.constant 31 : i32
        %nfg = arith.shrui %npk, %c31 : i32
        %col = arith.shrui %ai, %c2 : i32
        %ncol = arith.shrui %nai, %c2 : i32
        %wd0 = arith.subi %ncol, %col : i32
        %wd = arith.maxsi %wd0, %c0 : i32
        %wdm = arith.andi %wd, %m : i32
        %tx0 = arith.shrui %x, %c2 : i32
        %wt = arith.shrui %wdm, %c2 : i32
        %tx1a = arith.addi %tx0, %wt : i32
        %tx1 = arith.minui %tx1a, %m : i32
        %af = arith.cmpi ult, %tx0, %tx1 : i32
        %ty1 = arith.addi %ty, %c1 : i32
        %ax0 = arith.minui %x0, %tx0 : i32
        %ay0 = arith.minui %y0, %ty : i32
        %ax1 = arith.maxui %x1, %tx1 : i32
        %ay1 = arith.maxui %y1, %ty1 : i32
        %bx0 = arith.select %af, %ax0, %x0 : i32
        %by0 = arith.select %af, %ay0, %y0 : i32
        %bx1 = arith.select %af, %ax1, %x1 : i32
        %by1 = arith.select %af, %ay1, %y1 : i32
        %gap = arith.cmpi ne, %nfg, %c0 : i32
        %samey = arith.cmpi eq, %ny, %y : i32
        %g0 = arith.andi %gap, %samey : i1
        %gx1 = arith.shrui %nx, %c2 : i32
        %gs = arith.cmpi ult, %tx1, %gx1 : i32
        %g = arith.andi %g0, %gs : i1
        %cx0 = arith.minui %bx0, %tx1 : i32
        %cy0 = arith.minui %by0, %ty : i32
        %cx1 = arith.maxui %bx1, %gx1 : i32
        %cy1 = arith.maxui %by1, %ty1 : i32
        %ex0 = arith.select %g, %cx0, %bx0 : i32
        %ey0 = arith.select %g, %cy0, %by0 : i32
        %ex1 = arith.select %g, %cx1, %bx1 : i32
        %ey1 = arith.select %g, %cy1, %by1 : i32
        scf.yield %ex0, %ey0, %ex1, %ey1 : i32, i32, i32, i32
      }
      %empty0 = arith.cmpi uge, %r#0, %r#2 : i32
      %empty1 = arith.cmpi uge, %r#1, %r#3 : i32
      %empty = arith.ori %empty0, %empty1 : i1
      %z0 = arith.select %empty, %c0, %r#0 : i32
      %z1 = arith.select %empty, %c0, %r#1 : i32
      %z2 = arith.select %empty, %c0, %r#2 : i32
      %z3 = arith.select %empty, %c0, %r#3 : i32
      scf.yield %z0, %z1, %z2, %z3 : i32, i32, i32, i32
    } else {
      scf.yield %c0, %c0, %cols, %rows : i32, i32, i32, i32
    }
    %oo = arith.muli %lm, %c16 : i32
    %oa = arith.addi %own, %oo : i32
    %v = vector.from_elements %b#0, %b#1, %b#2, %b#3 : vector<4xi32>
    %st_p12 = llvm.inttoptr %oa : i32 to !llvm.ptr<1>
    llvm.store %v, %st_p12 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr<1>
  }
  gpu.return
}
gpu.func @lbox(%params: i32, %nl: i32) kernel {
  %c0 = arith.constant 0 : i32
  %c2 = arith.constant 2 : i32
  %c4 = arith.constant 4 : i32
  %c9 = arith.constant 9 : i32
  %c10 = arith.constant 10 : i32
  %c16 = arith.constant 16 : i32
  %c32 = arith.constant 32 : i32
  %lm = func.call @lane() : () -> i32
  %inside = arith.cmpi slt, %lm, %nl : i32
  scf.if %inside {
    %layers = func.call @param(%params, %c2) : (i32, i32) -> i32
    %consts = func.call @param(%params, %c9) : (i32, i32) -> i32
    %own = func.call @param(%params, %c10) : (i32, i32) -> i32
    %cols_p13 = llvm.inttoptr %consts : i32 to !llvm.ptr<1>
    %cols = llvm.load %cols_p13 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %ra = arith.addi %consts, %c4 : i32
    %rows_p14 = llvm.inttoptr %ra : i32 to !llvm.ptr<1>
    %rows = llvm.load %rows_p14 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %r:5 = "scf.while"(%lm, %c0, %c0, %cols, %rows) ({
    ^bb0(%m: i32, %x0: i32, %y0: i32, %x1: i32, %y1: i32):
      %more = arith.cmpi sge, %m, %c0 : i32
      "scf.condition"(%more, %m, %x0, %y0, %x1, %y1) : (i1, i32, i32, i32, i32, i32) -> ()
    }, {
    ^bb0(%m: i32, %x0: i32, %y0: i32, %x1: i32, %y1: i32):
      %oo = arith.muli %m, %c16 : i32
      %oa = arith.addi %own, %oo : i32
      %b_p15 = llvm.inttoptr %oa : i32 to !llvm.ptr<1>
      %b = llvm.load %b_p15 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xi32>
      %b0 = vector.extract %b[0] : i32 from vector<4xi32>
      %b1 = vector.extract %b[1] : i32 from vector<4xi32>
      %b2 = vector.extract %b[2] : i32 from vector<4xi32>
      %b3 = vector.extract %b[3] : i32 from vector<4xi32>
      %n0 = arith.maxui %x0, %b0 : i32
      %n1 = arith.maxui %y0, %b1 : i32
      %n2 = arith.minui %x1, %b2 : i32
      %n3 = arith.minui %y1, %b3 : i32
      %lo = arith.muli %m, %c32 : i32
      %la = arith.addi %layers, %lo : i32
      %p_p16 = llvm.inttoptr %la : i32 to !llvm.ptr<1>
      %p = llvm.load %p_p16 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
      "scf.yield"(%p, %n0, %n1, %n2, %n3) : (i32, i32, i32, i32, i32) -> ()
    }) : (i32, i32, i32, i32, i32) -> (i32, i32, i32, i32, i32)
    %lo = arith.muli %lm, %c32 : i32
    %la = arith.addi %layers, %lo : i32
    %c4b = arith.constant 4 : i32
    %ba = arith.addi %la, %c4b : i32
    %v = vector.from_elements %r#1, %r#2, %r#3, %r#4 : vector<4xi32>
    %st_p17 = llvm.inttoptr %ba : i32 to !llvm.ptr<1>
    llvm.store %v, %st_p17 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr<1>
  }
  gpu.return
}
gpu.func @evbuild(%params: i32, %n: i32) kernel {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c2 = arith.constant 2 : i32
  %c4 = arith.constant 4 : i32
  %c5 = arith.constant 5 : i32
  %c6 = arith.constant 6 : i32
  %c7 = arith.constant 7 : i32
  %c8 = arith.constant 8 : i32
  %c9 = arith.constant 9 : i32
  %c16 = arith.constant 16 : i32
  %c18 = arith.constant 18 : i32
  %c32 = arith.constant 32 : i32
  %m1 = arith.constant -1 : i32
  %i = func.call @lane() : () -> i32
  %inside = arith.cmpi slt, %i, %n : i32
  scf.if %inside {
    %cpaths = func.call @param(%params, %c0) : (i32, i32) -> i32
    %items = func.call @param(%params, %c1) : (i32, i32) -> i32
    %layers = func.call @param(%params, %c2) : (i32, i32) -> i32
    %attrs = func.call @param(%params, %c4) : (i32, i32) -> i32
    %events = func.call @param(%params, %c5) : (i32, i32) -> i32
    %prow = func.call @param(%params, %c6) : (i32, i32) -> i32
    %prcount = func.call @param(%params, %c7) : (i32, i32) -> i32
    %strips = func.call @param(%params, %c8) : (i32, i32) -> i32
    %consts = func.call @param(%params, %c9) : (i32, i32) -> i32
    %cols_p18 = llvm.inttoptr %consts : i32 to !llvm.ptr<1>
    %cols = llvm.load %cols_p18 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %ra = arith.addi %consts, %c4 : i32
    %rows_p19 = llvm.inttoptr %ra : i32 to !llvm.ptr<1>
    %rows = llvm.load %rows_p19 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %it:4 = func.call @item(%items, %i) : (i32, i32) -> (i32, i32, i32, i32)
    %pth:3 = func.call @path(%cpaths, %it#1) : (i32, i32) -> (i32, i32, i32)
    %i4 = arith.muli %i, %c4 : i32
    %aa = arith.addi %attrs, %i4 : i32
    %pa_p20 = llvm.inttoptr %aa : i32 to !llvm.ptr<1>
    %pa = llvm.load %pa_p20 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %fill = arith.cmpi eq, %it#0, %c0 : i32
    %at = arith.select %fill, %pa, %it#3 : i32
    %top = arith.cmpi slt, %it#2, %c0 : i32
    %opq0 = arith.andi %fill, %top : i1
    %opq1 = arith.cmpi ne, %it#3, %c0 : i32
    %opqb = arith.andi %opq0, %opq1 : i1
    %opq = arith.select %opqb, %c1, %c0 : i32
    %eo = arith.muli %i, %c32 : i32
    %ea = arith.addi %events, %eo : i32
    %v0 = vector.from_elements %it#0, %pth#0, %pth#1, %pth#2 : vector<4xi32>
    %st_p21 = llvm.inttoptr %ea : i32 to !llvm.ptr<1>
    llvm.store %v0, %st_p21 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr<1>
    %ea2 = arith.addi %ea, %c16 : i32
    %v1 = vector.from_elements %at, %opq, %it#2, %c0 : vector<4xi32>
    %st_p22 = llvm.inttoptr %ea2 : i32 to !llvm.ptr<1>
    llvm.store %v1, %st_p22 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr<1>
    %bx:4 = scf.if %top -> (i32, i32, i32, i32) {
      scf.yield %c0, %c0, %cols, %rows : i32, i32, i32, i32
    } else {
      %lo = arith.muli %it#2, %c32 : i32
      %la = arith.addi %layers, %lo : i32
      %lb = arith.addi %la, %c4 : i32
      %b_p23 = llvm.inttoptr %lb : i32 to !llvm.ptr<1>
      %b = llvm.load %b_p23 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xi32>
      %b0 = vector.extract %b[0] : i32 from vector<4xi32>
      %b1 = vector.extract %b[1] : i32 from vector<4xi32>
      %b2 = vector.extract %b[2] : i32 from vector<4xi32>
      %b3 = vector.extract %b[3] : i32 from vector<4xi32>
      scf.yield %b0, %b1, %b2, %b3 : i32, i32, i32, i32
    }
    %boxok = arith.cmpi ult, %bx#1, %bx#3 : i32
    %rr:2 = scf.if %fill -> (i32, i32) {
      %some = arith.cmpi sge, %pth#1, %c2 : i32
      %ok = arith.andi %some, %boxok : i1
      %q:2 = scf.if %ok -> (i32, i32) {
        %sb0 = arith.muli %pth#0, %c8 : i32
        %sb = arith.addi %strips, %sb0 : i32
        %w0_p24 = llvm.inttoptr %sb : i32 to !llvm.ptr<1>
        %w0 = llvm.load %w0_p24 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
        %y0 = arith.shrui %w0, %c18 : i32
        %l2 = arith.subi %pth#1, %c2 : i32
        %l8 = arith.muli %l2, %c8 : i32
        %la = arith.addi %sb, %l8 : i32
        %w1_p25 = llvm.inttoptr %la : i32 to !llvm.ptr<1>
        %w1 = llvm.load %w1_p25 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
        %y1 = arith.shrui %w1, %c18 : i32
        %r0 = arith.maxui %y0, %bx#1 : i32
        %bm = arith.subi %bx#3, %c1 : i32
        %r1 = arith.minui %y1, %bm : i32
        %has = arith.cmpi ule, %r0, %r1 : i32
        %d = arith.subi %r1, %r0 : i32
        %d1 = arith.addi %d, %c1 : i32
        %nr = arith.select %has, %d1, %c0 : i32
        scf.yield %r0, %nr : i32, i32
      } else {
        scf.yield %c0, %c0 : i32, i32
      }
      scf.yield %q#0, %q#1 : i32, i32
    } else {
      %d = arith.subi %bx#3, %bx#1 : i32
      %nr = arith.select %boxok, %d, %c0 : i32
      scf.yield %bx#1, %nr : i32, i32
    }
    %i8 = arith.muli %i, %c8 : i32
    %pra = arith.addi %prow, %i8 : i32
    %pv = vector.from_elements %rr#0, %rr#1 : vector<2xi32>
    %st_p26 = llvm.inttoptr %pra : i32 to !llvm.ptr<1>
    llvm.store %pv, %st_p26 {alignment = 4 : i64} : vector<2xi32>, !llvm.ptr<1>
    %pca = arith.addi %prcount, %i4 : i32
    %st_p27 = llvm.inttoptr %pca : i32 to !llvm.ptr<1>
    llvm.store %rr#1, %st_p27 {alignment = 4 : i64} : i32, !llvm.ptr<1>
  }
  gpu.return
}
}
}
