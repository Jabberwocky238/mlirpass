// acgpu's crates/intel/driver/src/paths/tiles.mlir in upstream dialects.
module attributes {gpu.container_module} {
gpu.module @shaders [#xevm.target<chip = "ptl">] {
gpu.func @tiles(%params: i32, %npaths: i32, %pass: i32) kernel {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c4 = arith.constant 4 : i32
  %c8 = arith.constant 8 : i32
  %c16 = arith.constant 16 : i32
  %lines_p1 = llvm.inttoptr %params : i32 to !llvm.ptr<1>
  %lines = llvm.load %lines_p1 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a1 = arith.addi %params, %c4 : i32
  %paths_p2 = llvm.inttoptr %a1 : i32 to !llvm.ptr<1>
  %paths = llvm.load %paths_p2 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a2 = arith.addi %a1, %c4 : i32
  %consts_p3 = llvm.inttoptr %a2 : i32 to !llvm.ptr<1>
  %consts = llvm.load %consts_p3 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a3 = arith.addi %a2, %c4 : i32
  %counts_p4 = llvm.inttoptr %a3 : i32 to !llvm.ptr<1>
  %counts = llvm.load %counts_p4 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a4 = arith.addi %a3, %c4 : i32
  %offsets_p5 = llvm.inttoptr %a4 : i32 to !llvm.ptr<1>
  %offsets = llvm.load %offsets_p5 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a5 = arith.addi %a4, %c4 : i32
  %tiles_p6 = llvm.inttoptr %a5 : i32 to !llvm.ptr<1>
  %tiles = llvm.load %tiles_p6 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a6 = arith.addi %a5, %c4 : i32
  %windings_p7 = llvm.inttoptr %a6 : i32 to !llvm.ptr<1>
  %windings = llvm.load %windings_p7 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %cols_p8 = llvm.inttoptr %consts : i32 to !llvm.ptr<1>
  %cols = llvm.load %cols_p8 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %k1 = arith.addi %consts, %c4 : i32
  %rows_p9 = llvm.inttoptr %k1 : i32 to !llvm.ptr<1>
  %rows = llvm.load %rows_p9 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %k2 = arith.addi %k1, %c4 : i32
  %stride_p10 = llvm.inttoptr %k2 : i32 to !llvm.ptr<1>
  %stride = llvm.load %stride_p10 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %g_ix11 = gpu.block_id x
  %g = arith.index_cast %g_ix11 : index to i32
  %l_ix12 = gpu.thread_id x
  %l = arith.index_cast %l_ix12 : index to i32
  %b0 = arith.muli %g, %c16 : i32
  %p = arith.addi %b0, %l : i32
  %inside = arith.cmpi slt, %p, %npaths : i32
  scf.if %inside {
    %po = arith.muli %p, %c8 : i32
    %pa = arith.addi %paths, %po : i32
    %first_p13 = llvm.inttoptr %pa : i32 to !llvm.ptr<1>
    %first = llvm.load %first_p13 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %pa2 = arith.addi %pa, %c4 : i32
    %nl_p14 = llvm.inttoptr %pa2 : i32 to !llvm.ptr<1>
    %nl = llvm.load %nl_p14 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %p4 = arith.muli %p, %c4 : i32
    %oa = arith.addi %offsets, %p4 : i32
    %write = arith.cmpi ne, %pass, %c0 : i32
    %at = scf.if %write -> (i32) {
      %v_p15 = llvm.inttoptr %oa : i32 to !llvm.ptr<1>
      %v = llvm.load %v_p15 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
      scf.yield %v : i32
    } else {
      scf.yield %c0 : i32
    }
    %wb = func.call @wblock(%windings, %consts, %p, %stride) : (i32, i32, i32, i32) -> i32
    %out0 = arith.constant 8 : i32
    %ato = arith.muli %at, %out0 : i32
    %out = arith.addi %tiles, %ato : i32
    %res:2 = scf.for %li = %c0 to %nl step %c1 iter_args(%k = %c0, %cu = %c0) -> (i32, i32) : i32 {
      %gl = arith.addi %first, %li : i32
      %lo = arith.muli %gl, %c16 : i32
      %la = arith.addi %lines, %lo : i32
      %lv_p16 = llvm.inttoptr %la : i32 to !llvm.ptr<1>
      %lv = llvm.load %lv_p16 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xf32>
      %r:2 = func.call @line(%lv, %li, %cols, %rows, %write, %out, %k, %wb) : (vector<4xf32>, i32, i32, i32, i1, i32, i32, i32) -> (i32, i32)
      %cu2 = arith.ori %cu, %r#1 : i32
      scf.yield %r#0, %cu2 : i32, i32
    }
    %first0 = arith.cmpi eq, %pass, %c0 : i32
    scf.if %first0 {
      %ca = arith.addi %counts, %p4 : i32
      %st_p17 = llvm.inttoptr %ca : i32 to !llvm.ptr<1>
      llvm.store %res#0, %st_p17 {alignment = 4 : i64} : i32, !llvm.ptr<1>
      %c12w = arith.constant 12 : i32
      %fla = arith.addi %consts, %c12w : i32
      %flags_p18 = llvm.inttoptr %fla : i32 to !llvm.ptr<1>
      %flags = llvm.load %flags_p18 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
      %sparse = arith.cmpi ne, %flags, %c0 : i32
      scf.if %sparse {
        %fp = arith.addi %flags, %p4 : i32
        %st_p19 = llvm.inttoptr %fp : i32 to !llvm.ptr<1>
        llvm.store %res#1, %st_p19 {alignment = 4 : i64} : i32, !llvm.ptr<1>
      }
    } else {
      %dosort = arith.cmpi eq, %pass, %c1 : i32
      scf.if %dosort {
        func.call @sort(%out, %res#0) : (i32, i32) -> ()
      }
      %c20 = arith.constant 20 : i32
      %r20 = arith.muli %rows, %c20 : i32
      %c31 = arith.constant 31 : i32
      %rw0 = arith.addi %rows, %c31 : i32
      %c5 = arith.constant 5 : i32
      %words = arith.shrui %rw0, %c5 : i32
      %w4 = arith.muli %words, %c4 : i32
      %cuo = arith.addi %r20, %w4 : i32
      %cua = arith.addi %wb, %cuo : i32
      %st_p20 = llvm.inttoptr %cua : i32 to !llvm.ptr<1>
      llvm.store %res#1, %st_p20 {alignment = 4 : i64} : i32, !llvm.ptr<1>
    }
  }
  gpu.return
}
func.func private @u16(%x: f32) -> i32 {
  %z = arith.constant 0.0 : f32
  %m = arith.constant 65535.0 : f32
  %pos = arith.cmpf ogt, %x, %z : f32
  %v0 = arith.select %pos, %x, %z : f32
  %v = arith.minnumf %v0, %m : f32
  %i = arith.fptosi %v : f32 to i32
  return %i : i32
}
func.func private @tile(%out: i32, %k: i32, %x: i32, %y: i32, %line: i32, %mask: i32, %write: i1) -> i32 {
  scf.if %write {
    %c5 = arith.constant 5 : i32
    %c16 = arith.constant 16 : i32
    %c8 = arith.constant 8 : i32
    %li = arith.shli %line, %c5 : i32
    %lo = arith.ori %li, %mask : i32
    %ys = arith.shli %y, %c16 : i32
    %hi = arith.ori %ys, %x : i32
    %o = arith.muli %k, %c8 : i32
    %a = arith.addi %out, %o : i32
    %v = vector.from_elements %lo, %hi : vector<2xi32>
    %st_p21 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
    llvm.store %v, %st_p21 {alignment = 4 : i64} : vector<2xi32>, !llvm.ptr<1>
  }
  %c1 = arith.constant 1 : i32
  %k2 = arith.addi %k, %c1 : i32
  return %k2 : i32
}
func.func private @tile_clamped(%out: i32, %k: i32, %x: i32, %y: i32, %line: i32, %mask: i32, %write: i1) -> i32 {
  %m = arith.constant 16383 : i32
  %xc = arith.minsi %x, %m : i32
  %yc = arith.minsi %y, %m : i32
  %k2 = func.call @tile(%out, %k, %xc, %yc, %line, %mask, %write) : (i32, i32, i32, i32, i32, i32, i1) -> i32
  return %k2 : i32
}
func.func private @active(%wb: i32, %rows: i32, %row: i32, %write: i1) {
  scf.if %write {
    %c20 = arith.constant 20 : i32
    %c5 = arith.constant 5 : i32
    %c31 = arith.constant 31 : i32
    %c4 = arith.constant 4 : i32
    %c1 = arith.constant 1 : i32
    %base = arith.muli %rows, %c20 : i32
    %w = arith.shrui %row, %c5 : i32
    %wo = arith.muli %w, %c4 : i32
    %o = arith.addi %base, %wo : i32
    %a = arith.addi %wb, %o : i32
    %bit = arith.andi %row, %c31 : i32
    %m = arith.shli %c1, %bit : i32
    %v_p22 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
    %v = llvm.load %v_p22 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %v2 = arith.ori %v, %m : i32
    %st_p23 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
    llvm.store %v2, %st_p23 {alignment = 4 : i64} : i32, !llvm.ptr<1>
  }
  return
}
func.func private @coarse(%wb: i32, %rows: i32, %row: i32, %dir: i32, %write: i1) {
  scf.if %write {
    %c16 = arith.constant 16 : i32
    %c4 = arith.constant 4 : i32
    %base = arith.muli %rows, %c16 : i32
    %ro = arith.muli %row, %c4 : i32
    %o = arith.addi %base, %ro : i32
    %a = arith.addi %wb, %o : i32
    %v_p24 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
    %v = llvm.load %v_p24 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %v2 = arith.addi %v, %dir : i32
    %st_p25 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
    llvm.store %v2, %st_p25 {alignment = 4 : i64} : i32, !llvm.ptr<1>
  }
  return
}
func.func private @partial(%wb: i32, %row: i32, %top: f32, %bottom: f32, %fdir: f32, %sub: f32, %write: i1) {
  scf.if %write {
    %c16 = arith.constant 16 : i32
    %ro = arith.muli %row, %c16 : i32
    %a = arith.addi %wb, %ro : i32
    %cur_p26 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
    %cur = llvm.load %cur_p26 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xf32>
    %yf = arith.sitofp %row : i32 to f32
    %four = arith.constant 4.0 : f32
    %ts = arith.subf %top, %yf : f32
    %start = arith.mulf %ts, %four : f32
    %bs = arith.subf %bottom, %yf : f32
    %end = arith.mulf %bs, %four : f32
    %f0 = arith.constant 0.0 : f32
    %f1 = arith.constant 1.0 : f32
    %f2 = arith.constant 2.0 : f32
    %f3 = arith.constant 3.0 : f32
    %c0v = vector.extract %cur[0] : f32 from vector<4xf32>
    %c1v = vector.extract %cur[1] : f32 from vector<4xf32>
    %c2v = vector.extract %cur[2] : f32 from vector<4xf32>
    %c3v = vector.extract %cur[3] : f32 from vector<4xf32>
    %n0 = func.call @cov(%f0, %f1, %start, %end, %fdir, %c0v, %sub) : (f32, f32, f32, f32, f32, f32, f32) -> f32
    %n1 = func.call @cov(%f1, %f2, %start, %end, %fdir, %c1v, %sub) : (f32, f32, f32, f32, f32, f32, f32) -> f32
    %n2 = func.call @cov(%f2, %f3, %start, %end, %fdir, %c2v, %sub) : (f32, f32, f32, f32, f32, f32, f32) -> f32
    %n3 = func.call @cov(%f3, %four, %start, %end, %fdir, %c3v, %sub) : (f32, f32, f32, f32, f32, f32, f32) -> f32
    %nv = vector.from_elements %n0, %n1, %n2, %n3 : vector<4xf32>
    %st_p27 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
    llvm.store %nv, %st_p27 {alignment = 4 : i64} : vector<4xf32>, !llvm.ptr<1>
  }
  return
}
func.func private @cov(%pt: f32, %pb: f32, %start: f32, %end: f32, %fdir: f32, %cur: f32, %sub: f32) -> f32 {
  %lo = arith.minnumf %pb, %end : f32
  %hi = arith.maxnumf %pt, %start : f32
  %d = arith.subf %lo, %hi : f32
  %z = arith.constant 0.0 : f32
  %c = arith.maxnumf %d, %z : f32
  %base = arith.subf %cur, %sub : f32
  %v = math.fma %c, %fdir, %base : f32
  return %v : f32
}
func.func private @extents(%out: i32, %k: i32, %y: i32, %rl: f32, %rr: f32, %ws: i32, %we: i32, %w1: i32, %cols: i32, %line: i32, %write: i1) -> i32 {
  %c1 = arith.constant 1 : i32
  %xs = func.call @u16(%rl) : (f32) -> i32
  %xe0 = func.call @u16(%rr) : (f32) -> i32
  %cm1 = arith.subi %cols, %c1 : i32
  %xe = arith.minsi %xe0, %cm1 : i32
  %some = arith.cmpi sle, %xs, %xe : i32
  %r = scf.if %some -> (i32) {
    %single = arith.cmpi eq, %xs, %xe : i32
    %w = arith.select %single, %w1, %ws : i32
    %k1 = func.call @tile(%out, %k, %xs, %y, %line, %w, %write) : (i32, i32, i32, i32, i32, i32, i1) -> i32
    %m = arith.constant 65535 : i32
    %xs1a = arith.addi %xs, %c1 : i32
    %xs1 = arith.minsi %xs1a, %m : i32
    %z = arith.constant 0 : i32
    %k2 = scf.for %x = %xs1 to %xe step %c1 iter_args(%kk = %k1) -> (i32) : i32 {
      %kn = func.call @tile(%out, %kk, %x, %y, %line, %z, %write) : (i32, i32, i32, i32, i32, i32, i1) -> i32
      scf.yield %kn : i32
    }
    %two = arith.cmpi slt, %xs, %xe : i32
    %k3 = scf.if %two -> (i32) {
      %kn = func.call @tile(%out, %k2, %xe, %y, %line, %we, %write) : (i32, i32, i32, i32, i32, i32, i1) -> i32
      scf.yield %kn : i32
    } else {
      scf.yield %k2 : i32
    }
    scf.yield %k3 : i32
  } else {
    scf.yield %k : i32
  }
  return %r : i32
}
func.func private @push_row(%out: i32, %k: i32, %y: i32, %rty: f32, %rby: f32, %ws: i32, %we: i32, %w1: i32, %p0x: f32, %p0y: f32, %xs: f32, %dx: f32, %dy: f32, %left: f32, %right: f32, %fdir: f32, %dir: i32, %cols: i32, %rows: i32, %line: i32, %wb: i32, %write: i1) -> (i32, i32) {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %z = arith.constant 0.0 : f32
  %t0 = arith.subf %rty, %p0y : f32
  %t1 = arith.mulf %t0, %xs : f32
  %rtx = arith.addf %p0x, %t1 : f32
  %b0 = arith.subf %rby, %p0y : f32
  %b1 = arith.mulf %b0, %xs : f32
  %rbx = arith.addf %p0x, %b1 : f32
  %mn = arith.minnumf %rtx, %rbx : f32
  %rl = arith.maxnumf %mn, %left : f32
  %mx = arith.maxnumf %rtx, %rbx : f32
  %rr = arith.minnumf %mx, %right : f32
  %lneg = arith.cmpf olt, %rl, %z : f32
  %rneg = arith.cmpf olt, %rr, %z : f32
  %allout = arith.andi %lneg, %rneg : i1
  scf.if %allout {
    func.call @active(%wb, %rows, %y, %write) : (i32, i32, i32, i1) -> ()
    %wbit = arith.constant 16 : i32
    %ct0 = arith.andi %w1, %wbit : i32
    %crosses = arith.cmpi ne, %ct0, %c0 : i32
    scf.if %crosses {
      func.call @coarse(%wb, %rows, %y, %dir, %write) : (i32, i32, i32, i32, i1) -> ()
    }
    %sub = arith.select %crosses, %fdir, %z : f32
    func.call @partial(%wb, %y, %rty, %rby, %fdir, %sub, %write) : (i32, i32, f32, f32, f32, f32, i1) -> ()
  }
  %partly = arith.cmpf oge, %rr, %z : f32
  %part = arith.andi %lneg, %partly : i1
  scf.if %part {
    %ysl = arith.divf %dy, %dx : f32
    %q = arith.mulf %rtx, %ysl : f32
    %yint = arith.subf %rty, %q : f32
    %tneg = arith.cmpf olt, %rtx, %z : f32
    %mb = arith.minnumf %rby, %yint : f32
    %mt = arith.maxnumf %rty, %yint : f32
    %ost = arith.select %tneg, %rty, %mt : f32
    %osb = arith.select %tneg, %mb, %rby : f32
    %some = arith.cmpf olt, %ost, %osb : f32
    scf.if %some {
      func.call @active(%wb, %rows, %y, %write) : (i32, i32, i32, i1) -> ()
      func.call @partial(%wb, %y, %ost, %osb, %fdir, %z, %write) : (i32, i32, f32, f32, f32, f32, i1) -> ()
    }
  }
  %true = arith.constant true
  %notall = arith.xori %allout, %true : i1
  %k2 = scf.if %notall -> (i32) {
    %kn = func.call @extents(%out, %k, %y, %rl, %rr, %ws, %we, %w1, %cols, %line, %write) : (i32, i32, i32, f32, f32, i32, i32, i32, i32, i32, i1) -> i32
    scf.yield %kn : i32
  } else {
    scf.yield %k : i32
  }
  %cul = arith.extui %lneg : i1 to i32
  return %k2, %cul : i32, i32
}
func.func private @line(%lv: vector<4xf32>, %line: i32, %cols: i32, %rows: i32, %write: i1, %out: i32, %k: i32, %wb: i32) -> (i32, i32) {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %cm1 = arith.constant -1 : i32
  %wbit = arith.constant 16 : i32
  %z = arith.constant 0.0 : f32
  %one = arith.constant 1.0 : f32
  %q = arith.constant 0.25 : f32
  %x0 = vector.extract %lv[0] : f32 from vector<4xf32>
  %y0 = vector.extract %lv[1] : f32 from vector<4xf32>
  %x1 = vector.extract %lv[2] : f32 from vector<4xf32>
  %y1 = vector.extract %lv[3] : f32 from vector<4xf32>
  %p0x = arith.mulf %x0, %q : f32
  %p0y = arith.mulf %y0, %q : f32
  %p1x = arith.mulf %x1, %q : f32
  %p1y = arith.mulf %y1, %q : f32
  %ltx = arith.cmpf olt, %p0x, %p1x : f32
  %left = arith.select %ltx, %p0x, %p1x : f32
  %right = arith.select %ltx, %p1x, %p0x : f32
  %colsf = arith.sitofp %cols : i32 to f32
  %pastright = arith.cmpf ogt, %left, %colsf : f32
  %lty = arith.cmpf olt, %p0y, %p1y : f32
  %topy = arith.select %lty, %p0y, %p1y : f32
  %topx = arith.select %lty, %p0x, %p1x : f32
  %boty = arith.select %lty, %p1y, %p0y : f32
  %botx = arith.select %lty, %p1x, %p0x : f32
  %yt0 = func.call @u16(%topy) : (f32) -> i32
  %yt = arith.minsi %yt0, %rows : i32
  %bc = math.ceil %boty : f32
  %yb0 = func.call @u16(%bc) : (f32) -> i32
  %yb = arith.minsi %yb0, %rows : i32
  %empty = arith.cmpi sge, %yt, %yb : i32
  %skip = arith.ori %pastright, %empty : i1
  %ge = arith.cmpf oge, %p0y, %p1y : f32
  %dir = arith.select %ge, %c1, %cm1 : i32
  %fdir = arith.sitofp %dir : i32 to f32
  %ytf = arith.sitofp %yt : i32 to f32
  %scull = arith.cmpf olt, %topy, %z : f32
  %yt1 = arith.addi %yt, %c1 : i32
  %ys = arith.select %scull, %yt, %yt1 : i32
  %rneg = arith.cmpf olt, %right, %z : f32
  %res:2 = scf.if %skip -> (i32, i32) {
    scf.yield %k, %c0 : i32, i32
  } else {
    %r:2 = scf.if %rneg -> (i32, i32) {
      %true = arith.constant true
      %notsc = arith.xori %scull, %true : i1
      scf.if %notsc {
        func.call @active(%wb, %rows, %yt, %write) : (i32, i32, i32, i1) -> ()
        %attop = arith.cmpf ole, %topy, %ytf : f32
        scf.if %attop {
          func.call @coarse(%wb, %rows, %yt, %dir, %write) : (i32, i32, i32, i32, i1) -> ()
        }
        %sub = arith.select %attop, %fdir, %z : f32
        func.call @partial(%wb, %yt, %topy, %boty, %fdir, %sub, %write) : (i32, i32, f32, f32, f32, f32, i1) -> ()
      }
      %bf = math.floor %boty : f32
      %ye0 = func.call @u16(%bf) : (f32) -> i32
      %ye = arith.minsi %ye0, %rows : i32
      scf.for %y = %ys to %ye step %c1 : i32 {
        func.call @coarse(%wb, %rows, %y, %dir, %write) : (i32, i32, i32, i32, i1) -> ()
        func.call @active(%wb, %rows, %y, %write) : (i32, i32, i32, i1) -> ()
      }
      %frac = arith.cmpf une, %boty, %bf : f32
      %inrows = arith.cmpi slt, %ye, %rows : i32
      %neq = arith.cmpi ne, %ye, %yt : i32
      %either = arith.ori %scull, %neq : i1
      %c0a = arith.andi %frac, %inrows : i1
      %last = arith.andi %c0a, %either : i1
      scf.if %last {
        func.call @active(%wb, %rows, %ye, %write) : (i32, i32, i32, i1) -> ()
        func.call @coarse(%wb, %rows, %ye, %dir, %write) : (i32, i32, i32, i32, i1) -> ()
        func.call @partial(%wb, %ye, %topy, %boty, %fdir, %fdir, %write) : (i32, i32, f32, f32, f32, f32, i1) -> ()
      }
      scf.yield %k, %c1 : i32, i32
    } else {
      %ftx = math.floor %topx : f32
      %fty = math.floor %topy : f32
      %fbx = math.floor %botx : f32
      %fby = math.floor %boty : f32
      %dx_t = arith.cmpf une, %ftx, %fbx : f32
      %dy_t = arith.cmpf une, %fty, %fby : f32
      %notsame = arith.ori %dx_t, %dy_t : i1
      %r2:2 = scf.if %notsame -> (i32, i32) {
        %vert = arith.cmpf oeq, %left, %right : f32
        %r3:2 = scf.if %vert -> (i32, i32) {
          %xl = func.call @u16(%left) : (f32) -> i32
          %cm = arith.subi %cols, %c1 : i32
          %cmz = arith.maxsi %cm, %c0 : i32
          %x = arith.minsi %xl, %cmz : i32
          %true = arith.constant true
          %notsc = arith.xori %scull, %true : i1
          %ka = scf.if %notsc -> (i32) {
            %wt = arith.cmpf oge, %ytf, %topy : f32
            %w = arith.select %wt, %wbit, %c0 : i32
            %kn = func.call @tile_clamped(%out, %k, %x, %yt, %line, %w, %write) : (i32, i32, i32, i32, i32, i32, i1) -> i32
            scf.yield %kn : i32
          } else {
            scf.yield %k : i32
          }
          %kb = scf.for %y = %ys to %yb step %c1 iter_args(%kk = %ka) -> (i32) : i32 {
            %kn = func.call @tile_clamped(%out, %kk, %x, %y, %line, %wbit, %write) : (i32, i32, i32, i32, i32, i32, i1) -> i32
            scf.yield %kn : i32
          }
          scf.yield %kb, %c0 : i32, i32
        } else {
          %dx = arith.subf %p1x, %p0x : f32
          %dy = arith.subf %p1y, %p0y : f32
          %xs = arith.divf %dx, %dy : f32
          %dxd = arith.cmpf oge, %botx, %topx : f32
          %wsb = arith.select %dxd, %wbit, %c0 : i32
          %web = arith.select %dxd, %c0, %wbit : i32
          %lin = arith.cmpf oge, %left, %z : f32
          %rin = arith.cmpf olt, %right, %colsf : f32
          %within = arith.andi %lin, %rin : i1
          %wt = arith.cmpf oge, %ytf, %topy : f32
          %mask = arith.select %wt, %c1, %c0 : i32
          %mw = arith.muli %mask, %wbit : i32
          %wsm = arith.andi %wsb, %mw : i32
          %wem = arith.andi %web, %mw : i32
          %true = arith.constant true
          %notsc = arith.xori %scull, %true : i1
          %yf1 = arith.addf %ytf, %one : f32
          %rby0 = arith.minnumf %yf1, %boty : f32
          %r4:2 = scf.if %within -> (i32, i32) {
            %ka = scf.if %notsc -> (i32) {
              %atend = arith.cmpf oeq, %rby0, %boty : f32
              %t0 = arith.subf %rby0, %p0y : f32
              %t1 = arith.mulf %t0, %xs : f32
              %rbxs = arith.addf %p0x, %t1 : f32
              %rbx = arith.select %atend, %botx, %rbxs : f32
              %mn = arith.minnumf %topx, %rbx : f32
              %mx = arith.maxnumf %topx, %rbx : f32
              %kn = func.call @extents(%out, %k, %yt, %mn, %mx, %wsm, %wem, %mw, %cols, %line, %write) : (i32, i32, i32, f32, f32, i32, i32, i32, i32, i32, i1) -> i32
              scf.yield %kn : i32
            } else {
              scf.yield %k : i32
            }
            %some = arith.cmpi slt, %ys, %yb : i32
            %kb = scf.if %some -> (i32) {
              %ysf = arith.sitofp %ys : i32 to f32
              %s0 = arith.subf %ysf, %p0y : f32
              %s1 = arith.mulf %s0, %xs : f32
              %rtx0 = arith.addf %p0x, %s1 : f32
              %kr:2 = scf.for %y = %ys to %yb step %c1 iter_args(%kk = %ka, %rtx = %rtx0) -> (i32, f32) : i32 {
                %yf = arith.sitofp %y : i32 to f32
                %yfp = arith.addf %yf, %one : f32
                %below = arith.cmpf olt, %boty, %yfp : f32
                %u0 = arith.subf %yfp, %p0y : f32
                %u1 = arith.mulf %u0, %xs : f32
                %rbxs = arith.addf %p0x, %u1 : f32
                %rbx = arith.select %below, %botx, %rbxs : f32
                %mn = arith.minnumf %rtx, %rbx : f32
                %mx = arith.maxnumf %rtx, %rbx : f32
                %kn = func.call @extents(%out, %kk, %y, %mn, %mx, %wsb, %web, %wbit, %cols, %line, %write) : (i32, i32, i32, f32, f32, i32, i32, i32, i32, i32, i1) -> i32
                scf.yield %kn, %rbx : i32, f32
              }
              scf.yield %kr#0 : i32
            } else {
              scf.yield %ka : i32
            }
            scf.yield %kb, %c0 : i32, i32
          } else {
            %ka:2 = scf.if %notsc -> (i32, i32) {
              %kn:2 = func.call @push_row(%out, %k, %yt, %topy, %rby0, %wsm, %wem, %mw, %p0x, %p0y, %xs, %dx, %dy, %left, %right, %fdir, %dir, %cols, %rows, %line, %wb, %write) : (i32, i32, i32, f32, f32, i32, i32, i32, f32, f32, f32, f32, f32, f32, f32, f32, i32, i32, i32, i32, i32, i1) -> (i32, i32)
              scf.yield %kn#0, %kn#1 : i32, i32
            } else {
              scf.yield %k, %c0 : i32, i32
            }
            %kb:2 = scf.for %y = %ys to %yb step %c1 iter_args(%kk = %ka#0, %cc = %ka#1) -> (i32, i32) : i32 {
              %yf = arith.sitofp %y : i32 to f32
              %yfp = arith.addf %yf, %one : f32
              %rby = arith.minnumf %yfp, %boty : f32
              %kn:2 = func.call @push_row(%out, %kk, %y, %yf, %rby, %wsb, %web, %wbit, %p0x, %p0y, %xs, %dx, %dy, %left, %right, %fdir, %dir, %cols, %rows, %line, %wb, %write) : (i32, i32, i32, f32, f32, i32, i32, i32, f32, f32, f32, f32, f32, f32, f32, f32, i32, i32, i32, i32, i32, i1) -> (i32, i32)
              %cc2 = arith.ori %cc, %kn#1 : i32
              scf.yield %kn#0, %cc2 : i32, i32
            }
            scf.yield %kb#0, %kb#1 : i32, i32
          }
          scf.yield %r4#0, %r4#1 : i32, i32
        }
        scf.yield %r3#0, %r3#1 : i32, i32
      } else {
        %xl = func.call @u16(%left) : (f32) -> i32
        %cp = arith.addi %cols, %c1 : i32
        %x = arith.minsi %xl, %cp : i32
        %wt = arith.cmpf oge, %ytf, %topy : f32
        %w = arith.select %wt, %wbit, %c0 : i32
        %kn = func.call @tile_clamped(%out, %k, %x, %yt, %line, %w, %write) : (i32, i32, i32, i32, i32, i32, i1) -> i32
        scf.yield %kn, %c0 : i32, i32
      }
      scf.yield %r2#0, %r2#1 : i32, i32
    }
    scf.yield %r#0, %r#1 : i32, i32
  }
  return %res#0, %res#1 : i32, i32
}
func.func private @sort(%a: i32, %n: i32) {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c2 = arith.constant 2 : i32
  %h0 = arith.shrui %n, %c1 : i32
  scf.for %j = %c0 to %h0 step %c1 : i32 {
    %t = arith.subi %h0, %j : i32
    %i = arith.subi %t, %c1 : i32
    func.call @sift(%a, %i, %n) : (i32, i32, i32) -> ()
  }
  scf.for %j = %c1 to %n step %c1 : i32 {
    %end = arith.subi %n, %j : i32
    func.call @swap(%a, %c0, %end) : (i32, i32, i32) -> ()
    func.call @sift(%a, %c0, %end) : (i32, i32, i32) -> ()
  }
  return
}
func.func private @key(%a: i32, %i: i32) -> (i32, i32) {
  %c8 = arith.constant 8 : i32
  %o = arith.muli %i, %c8 : i32
  %at = arith.addi %a, %o : i32
  %v_p28 = llvm.inttoptr %at : i32 to !llvm.ptr<1>
  %v = llvm.load %v_p28 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<2xi32>
  %lo = vector.extract %v[0] : i32 from vector<2xi32>
  %hi = vector.extract %v[1] : i32 from vector<2xi32>
  return %lo, %hi : i32, i32
}
func.func private @less(%a: i32, %i: i32, %j: i32) -> i1 {
  %x:2 = func.call @key(%a, %i) : (i32, i32) -> (i32, i32)
  %y:2 = func.call @key(%a, %j) : (i32, i32) -> (i32, i32)
  %hl = arith.cmpi ult, %x#1, %y#1 : i32
  %he = arith.cmpi eq, %x#1, %y#1 : i32
  %ll = arith.cmpi ult, %x#0, %y#0 : i32
  %e = arith.andi %he, %ll : i1
  %r = arith.ori %hl, %e : i1
  return %r : i1
}
func.func private @swap(%a: i32, %i: i32, %j: i32) {
  %c8 = arith.constant 8 : i32
  %oi = arith.muli %i, %c8 : i32
  %ai = arith.addi %a, %oi : i32
  %oj = arith.muli %j, %c8 : i32
  %aj = arith.addi %a, %oj : i32
  %vi_p29 = llvm.inttoptr %ai : i32 to !llvm.ptr<1>
  %vi = llvm.load %vi_p29 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<2xi32>
  %vj_p30 = llvm.inttoptr %aj : i32 to !llvm.ptr<1>
  %vj = llvm.load %vj_p30 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<2xi32>
  %st_p31 = llvm.inttoptr %ai : i32 to !llvm.ptr<1>
  llvm.store %vj, %st_p31 {alignment = 4 : i64} : vector<2xi32>, !llvm.ptr<1>
  %st_p32 = llvm.inttoptr %aj : i32 to !llvm.ptr<1>
  llvm.store %vi, %st_p32 {alignment = 4 : i64} : vector<2xi32>, !llvm.ptr<1>
  return
}
func.func private @sift(%a: i32, %i0: i32, %n: i32) {
  %c1 = arith.constant 1 : i32
  %c2 = arith.constant 2 : i32
  %true = arith.constant true
  %fin:2 = "scf.while"(%i0, %true) ({
  ^bb0(%iw: i32, %gw: i1):
    "scf.condition"(%gw, %iw, %gw) : (i1, i32, i1) -> ()
  }, {
  ^bb0(%i: i32, %g0: i1):
    %l0 = arith.muli %i, %c2 : i32
    %l = arith.addi %l0, %c1 : i32
    %r = arith.addi %l, %c1 : i32
    %hasl = arith.cmpi slt, %l, %n : i32
    %next:2 = scf.if %hasl -> (i32, i1) {
      %hasr = arith.cmpi slt, %r, %n : i32
      %big = scf.if %hasr -> (i32) {
        %lr = func.call @less(%a, %l, %r) : (i32, i32, i32) -> i1
        %b = arith.select %lr, %r, %l : i32
        scf.yield %b : i32
      } else {
        scf.yield %l : i32
      }
      %down = func.call @less(%a, %i, %big) : (i32, i32, i32) -> i1
      scf.if %down {
        func.call @swap(%a, %i, %big) : (i32, i32, i32) -> ()
      }
      %ni = arith.select %down, %big, %i : i32
      scf.yield %ni, %down : i32, i1
    } else {
      %f = arith.constant false
      scf.yield %i, %f : i32, i1
    }
    "scf.yield"(%next#0, %next#1) : (i32, i1) -> ()
  }) : (i32, i1) -> (i32, i1)
  return
}
func.func private @wblock(%windings: i32, %consts: i32, %p: i32, %stride: i32) -> i32 {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c4 = arith.constant 4 : i32
  %c12 = arith.constant 12 : i32
  %c16 = arith.constant 16 : i32
  %fa = arith.addi %consts, %c12 : i32
  %flags_p33 = llvm.inttoptr %fa : i32 to !llvm.ptr<1>
  %flags = llvm.load %flags_p33 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %sparse = arith.cmpi ne, %flags, %c0 : i32
  %blk = scf.if %sparse -> (i32) {
    %p4 = arith.muli %p, %c4 : i32
    %f0 = arith.addi %flags, %p4 : i32
    %f_p34 = llvm.inttoptr %f0 : i32 to !llvm.ptr<1>
    %f = llvm.load %f_p34 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %pa = arith.addi %consts, %c16 : i32
    %pre0_p35 = llvm.inttoptr %pa : i32 to !llvm.ptr<1>
    %pre0 = llvm.load %pre0_p35 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %pre1 = arith.addi %pre0, %p4 : i32
    %pre_p36 = llvm.inttoptr %pre1 : i32 to !llvm.ptr<1>
    %pre = llvm.load %pre_p36 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %own = arith.cmpi ne, %f, %c0 : i32
    %b1 = arith.addi %pre, %c1 : i32
    %b = arith.select %own, %b1, %c0 : i32
    scf.yield %b : i32
  } else {
    scf.yield %p : i32
  }
  %o = arith.muli %blk, %stride : i32
  %wb = arith.addi %windings, %o : i32
  return %wb : i32
}
}
}
