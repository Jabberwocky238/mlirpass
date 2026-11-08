// acgpu's paths#stripgen+runs in upstream dialects.
module attributes {gpu.container_module} {
gpu.module @shaders [#xevm.target<chip = "ptl">] {
gpu.func @strips(%params: i32, %npaths: i32, %pass: i32) kernel {
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
  %tiles_p3 = llvm.inttoptr %a2 : i32 to !llvm.ptr<1>
  %tiles = llvm.load %tiles_p3 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a3 = arith.addi %a2, %c4 : i32
  %windings_p4 = llvm.inttoptr %a3 : i32 to !llvm.ptr<1>
  %windings = llvm.load %windings_p4 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a4 = arith.addi %a3, %c4 : i32
  %consts_p5 = llvm.inttoptr %a4 : i32 to !llvm.ptr<1>
  %consts = llvm.load %consts_p5 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a5 = arith.addi %a4, %c4 : i32
  %counts_p6 = llvm.inttoptr %a5 : i32 to !llvm.ptr<1>
  %counts = llvm.load %counts_p6 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a6 = arith.addi %a5, %c4 : i32
  %offsets_p7 = llvm.inttoptr %a6 : i32 to !llvm.ptr<1>
  %offsets = llvm.load %offsets_p7 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a7 = arith.addi %a6, %c4 : i32
  %strips_p8 = llvm.inttoptr %a7 : i32 to !llvm.ptr<1>
  %strips = llvm.load %strips_p8 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a8 = arith.addi %a7, %c4 : i32
  %alphas_p9 = llvm.inttoptr %a8 : i32 to !llvm.ptr<1>
  %alphas = llvm.load %alphas_p9 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a9 = arith.addi %a8, %c4 : i32
  %scratch_p10 = llvm.inttoptr %a9 : i32 to !llvm.ptr<1>
  %scratch = llvm.load %scratch_p10 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %rows_p11 = llvm.inttoptr %consts : i32 to !llvm.ptr<1>
  %rows = llvm.load %rows_p11 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %k1 = arith.addi %consts, %c4 : i32
  %vw_p12 = llvm.inttoptr %k1 : i32 to !llvm.ptr<1>
  %vw = llvm.load %vw_p12 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %k2 = arith.addi %k1, %c4 : i32
  %wstride_p13 = llvm.inttoptr %k2 : i32 to !llvm.ptr<1>
  %wstride = llvm.load %wstride_p13 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %g_ix14 = gpu.block_id x
  %g = arith.index_cast %g_ix14 : index to i32
  %l_ix15 = gpu.thread_id x
  %l = arith.index_cast %l_ix15 : index to i32
  %b0 = arith.muli %g, %c16 : i32
  %p = arith.addi %b0, %l : i32
  %inside = arith.cmpi slt, %p, %npaths : i32
  scf.if %inside {
    %po = arith.muli %p, %c16 : i32
    %pa = arith.addi %paths, %po : i32
    %pv_p16 = llvm.inttoptr %pa : i32 to !llvm.ptr<1>
    %pv = llvm.load %pv_p16 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xi32>
    %fl = vector.extract %pv[0] : i32 from vector<4xi32>
    %ft = vector.extract %pv[1] : i32 from vector<4xi32>
    %nt = vector.extract %pv[2] : i32 from vector<4xi32>
    %rule = vector.extract %pv[3] : i32 from vector<4xi32>
    %write = arith.cmpi eq, %pass, %c1 : i32
    %p8 = arith.muli %p, %c8 : i32
    %oa = arith.addi %offsets, %p8 : i32
    %ov = scf.if %write -> (vector<2xi32>) {
      %v_p17 = llvm.inttoptr %oa : i32 to !llvm.ptr<1>
      %v = llvm.load %v_p17 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<2xi32>
      scf.yield %v : vector<2xi32>
    } else {
      %z = vector.from_elements %c0, %c0 : vector<2xi32>
      scf.yield %z : vector<2xi32>
    }
    %so = vector.extract %ov[0] : i32 from vector<2xi32>
    %ao = vector.extract %ov[1] : i32 from vector<2xi32>
    %s8 = arith.muli %so, %c8 : i32
    %sout = arith.addi %strips, %s8 : i32
    %aout = arith.addi %alphas, %ao : i32
    %wb = func.call @wblock(%windings, %consts, %p, %wstride) : (i32, i32, i32, i32) -> i32
    %c80 = arith.constant 80 : i32
    %sc0 = arith.muli %p, %c80 : i32
    %sc = arith.addi %scratch, %sc0 : i32
    %c8l = arith.constant 8 : i32
    %t8 = arith.muli %ft, %c8l : i32
    %tb = arith.addi %tiles, %t8 : i32
    %c16l = arith.constant 16 : i32
    %l16 = arith.muli %fl, %c16l : i32
    %lb = arith.addi %lines, %l16 : i32
    %n:2 = func.call @render(%lb, %tb, %nt, %rule, %wb, %rows, %vw, %sc, %sout, %aout, %write) : (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i1) -> (i32, i32)
    %first = arith.cmpi eq, %pass, %c0 : i32
    scf.if %first {
      %ca = arith.addi %counts, %p8 : i32
      %cv = vector.from_elements %n#0, %n#1 : vector<2xi32>
      %st_p18 = llvm.inttoptr %ca : i32 to !llvm.ptr<1>
      llvm.store %cv, %st_p18 {alignment = 4 : i64} : vector<2xi32>, !llvm.ptr<1>
    }
  }
  gpu.return
}
func.func private @push(%sout: i32, %ns: i32, %x: i32, %y: i32, %ai: i32, %fill: i1, %write: i1) -> i32 {
  scf.if %write {
    %c16 = arith.constant 16 : i32
    %c8 = arith.constant 8 : i32
    %ys = arith.shli %y, %c16 : i32
    %xy = arith.ori %x, %ys : i32
    %top = arith.constant -2147483648 : i32
    %zero = arith.constant 0 : i32
    %fb = arith.select %fill, %top, %zero : i32
    %pk = arith.ori %ai, %fb : i32
    %o = arith.muli %ns, %c8 : i32
    %a = arith.addi %sout, %o : i32
    %v = vector.from_elements %xy, %pk : vector<2xi32>
    %st_p19 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
    llvm.store %v, %st_p19 {alignment = 4 : i64} : vector<2xi32>, !llvm.ptr<1>
  }
  %c1 = arith.constant 1 : i32
  %n = arith.addi %ns, %c1 : i32
  return %n : i32
}
func.func private @alpha16(%aout: i32, %na: i32, %w0: i32, %w1: i32, %w2: i32, %w3: i32, %write: i1) -> i32 {
  scf.if %write {
    %a = arith.addi %aout, %na : i32
    %v = vector.from_elements %w0, %w1, %w2, %w3 : vector<4xi32>
    %st_p20 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
    llvm.store %v, %st_p20 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr<1>
  }
  %c16 = arith.constant 16 : i32
  %n = arith.addi %na, %c16 : i32
  return %n : i32
}
func.func private @fillp(%w: i32, %rule: i32) -> i1 {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %nz = arith.cmpi ne, %w, %c0 : i32
  %odd0 = arith.andi %w, %c1 : i32
  %odd = arith.cmpi ne, %odd0, %c0 : i32
  %eo = arith.cmpi eq, %rule, %c1 : i32
  %r = arith.select %eo, %odd, %nz : i1
  return %r : i1
}
func.func private @coarse(%wb: i32, %rows: i32, %y: i32) -> i32 {
  %c16 = arith.constant 16 : i32
  %c4 = arith.constant 4 : i32
  %b = arith.muli %rows, %c16 : i32
  %o = arith.muli %y, %c4 : i32
  %s = arith.addi %b, %o : i32
  %a = arith.addi %wb, %s : i32
  %v_p21 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
  %v = llvm.load %v_p21 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  return %v : i32
}
func.func private @isactive(%wb: i32, %rows: i32, %y: i32) -> i1 {
  %c20 = arith.constant 20 : i32
  %c5 = arith.constant 5 : i32
  %c31 = arith.constant 31 : i32
  %c4 = arith.constant 4 : i32
  %c1 = arith.constant 1 : i32
  %c0 = arith.constant 0 : i32
  %b = arith.muli %rows, %c20 : i32
  %w = arith.shrui %y, %c5 : i32
  %wo = arith.muli %w, %c4 : i32
  %s = arith.addi %b, %wo : i32
  %a = arith.addi %wb, %s : i32
  %v_p22 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
  %v = llvm.load %v_p22 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %bit = arith.andi %y, %c31 : i32
  %sh = arith.shrui %v, %bit : i32
  %one = arith.andi %sh, %c1 : i32
  %r = arith.cmpi ne, %one, %c0 : i32
  return %r : i1
}
func.func private @emit_bg(%start: i32, %end: i32, %vw: i32, %wb: i32, %rows: i32, %rule: i32, %sout: i32, %ns: i32, %aout: i32, %na: i32, %ly: i32, %write: i1) -> (i32, i32, i32) {
  %c1 = arith.constant 1 : i32
  %c4 = arith.constant 4 : i32
  %c0 = arith.constant 0 : i32
  %full = arith.constant -1 : i32
  %r:3 = scf.for %y = %start to %end step %c1 iter_args(%s = %ns, %a = %na, %lyy = %ly) -> (i32, i32, i32) : i32 {
    %act = func.call @isactive(%wb, %rows, %y) : (i32, i32, i32) -> i1
    %cw = func.call @coarse(%wb, %rows, %y) : (i32, i32, i32) -> i32
    %f = func.call @fillp(%cw, %rule) : (i32, i32) -> i1
    %go = arith.andi %act, %f : i1
    %o:3 = scf.if %go -> (i32, i32, i32) {
      %yp = arith.muli %y, %c4 : i32
      %false = arith.constant false
      %true = arith.constant true
      %s1 = func.call @push(%sout, %s, %c0, %yp, %a, %false, %write) : (i32, i32, i32, i32, i32, i1, i1) -> i32
      %a1 = func.call @alpha16(%aout, %a, %full, %full, %full, %full, %write) : (i32, i32, i32, i32, i32, i32, i1) -> i32
      %s2 = func.call @push(%sout, %s1, %vw, %yp, %a1, %true, %write) : (i32, i32, i32, i32, i32, i1, i1) -> i32
      scf.yield %s2, %a1, %yp : i32, i32, i32
    } else {
      scf.yield %s, %a, %lyy : i32, i32, i32
    }
    scf.yield %o#0, %o#1, %o#2 : i32, i32, i32
  }
  return %r#0, %r#1, %r#2 : i32, i32, i32
}
func.func private @captive(%y: i32, %left: i1, %wb: i32, %rows: i32, %rule: i32, %sc: i32, %sout: i32, %ns: i32, %aout: i32, %na: i32, %ly: i32, %write: i1) -> (i32, i32, i32, i32) {
  %c0 = arith.constant 0 : i32
  %c4 = arith.constant 4 : i32
  %c16 = arith.constant 16 : i32
  %full = arith.constant -1 : i32
  %cw = func.call @coarse(%wb, %rows, %y) : (i32, i32, i32) -> i32
  %f = func.call @fillp(%cw, %rule) : (i32, i32) -> i1
  %true = arith.constant true
  %nl = arith.xori %left, %true : i1
  %go = arith.andi %f, %nl : i1
  %o:3 = scf.if %go -> (i32, i32, i32) {
    %yp = arith.muli %y, %c4 : i32
    %false = arith.constant false
    %s1 = func.call @push(%sout, %ns, %c0, %yp, %na, %false, %write) : (i32, i32, i32, i32, i32, i1, i1) -> i32
    %a1 = func.call @alpha16(%aout, %na, %full, %full, %full, %full, %write) : (i32, i32, i32, i32, i32, i32, i1) -> i32
    scf.yield %s1, %a1, %yp : i32, i32, i32
  } else {
    scf.yield %ns, %na, %ly : i32, i32, i32
  }
  %cf = arith.sitofp %cw : i32 to f32
  %po = arith.muli %y, %c16 : i32
  %pa = arith.addi %wb, %po : i32
  %pv_p23 = llvm.inttoptr %pa : i32 to !llvm.ptr<1>
  %pv = llvm.load %pv_p23 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xf32>
  %p0 = vector.extract %pv[0] : f32 from vector<4xf32>
  %p1 = vector.extract %pv[1] : f32 from vector<4xf32>
  %p2 = vector.extract %pv[2] : f32 from vector<4xf32>
  %p3 = vector.extract %pv[3] : f32 from vector<4xf32>
  %q0 = arith.addf %cf, %p0 : f32
  %q1 = arith.addf %cf, %p1 : f32
  %q2 = arith.addf %cf, %p2 : f32
  %q3 = arith.addf %cf, %p3 : f32
  %r0 = arith.select %left, %q0, %cf : f32
  %r1 = arith.select %left, %q1, %cf : f32
  %r2 = arith.select %left, %q2, %cf : f32
  %r3 = arith.select %left, %q3, %cf : f32
  %acc = vector.from_elements %r0, %r1, %r2, %r3 : vector<4xf32>
  %c64 = arith.constant 64 : i32
  %aa = arith.addi %sc, %c64 : i32
  %st_p24 = llvm.inttoptr %aa : i32 to !llvm.ptr<1>
  llvm.store %acc, %st_p24 {alignment = 4 : i64} : vector<4xf32>, !llvm.ptr<1>
  return %cw, %o#0, %o#1, %o#2 : i32, i32, i32, i32
}
func.func private @setloc(%sc: i32) {
  %c64 = arith.constant 64 : i32
  %aa = arith.addi %sc, %c64 : i32
  %acc_p25 = llvm.inttoptr %aa : i32 to !llvm.ptr<1>
  %acc = llvm.load %acc_p25 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xf32>
  %c16 = arith.constant 16 : i32
  %c32 = arith.constant 32 : i32
  %c48 = arith.constant 48 : i32
  %st_p26 = llvm.inttoptr %sc : i32 to !llvm.ptr<1>
  llvm.store %acc, %st_p26 {alignment = 4 : i64} : vector<4xf32>, !llvm.ptr<1>
  %a1 = arith.addi %sc, %c16 : i32
  %st_p27 = llvm.inttoptr %a1 : i32 to !llvm.ptr<1>
  llvm.store %acc, %st_p27 {alignment = 4 : i64} : vector<4xf32>, !llvm.ptr<1>
  %a2 = arith.addi %sc, %c32 : i32
  %st_p28 = llvm.inttoptr %a2 : i32 to !llvm.ptr<1>
  llvm.store %acc, %st_p28 {alignment = 4 : i64} : vector<4xf32>, !llvm.ptr<1>
  %a3 = arith.addi %sc, %c48 : i32
  %st_p29 = llvm.inttoptr %a3 : i32 to !llvm.ptr<1>
  llvm.store %acc, %st_p29 {alignment = 4 : i64} : vector<4xf32>, !llvm.ptr<1>
  return
}
func.func private @mx(%a: f32, %b: f32) -> f32 {
  %gt = arith.cmpf ogt, %a, %b : f32
  %r = arith.select %gt, %a, %b : f32
  return %r : f32
}
func.func private @mn(%a: f32, %b: f32) -> f32 {
  %lt = arith.cmpf olt, %a, %b : f32
  %r = arith.select %lt, %a, %b : f32
  return %r : f32
}
func.func private @alpha(%w: f32, %rule: i32) -> i32 {
  %half = arith.constant 0.5 : f32
  %f255 = arith.constant 255.0 : f32
  %m2 = arith.constant -2.0 : f32
  %c1 = arith.constant 1 : i32
  %aw = math.absf %w : f32
  %nz0 = math.fma %aw, %f255, %half : f32
  %nz = func.call @mn(%nz0, %f255) : (f32, f32) -> f32
  %e0 = math.fma %w, %half, %half : f32
  %im1 = math.floor %e0 : f32
  %e1 = math.fma %m2, %im1, %w : f32
  %cov = math.absf %e1 : f32
  %eo0 = math.fma %f255, %cov, %half : f32
  %eo = func.call @mn(%eo0, %f255) : (f32, f32) -> f32
  %iseo = arith.cmpi eq, %rule, %c1 : i32
  %v = arith.select %iseo, %eo, %nz : f32
  %u = arith.fptoui %v : f32 to i32
  %m = arith.constant 255 : i32
  %b = arith.andi %u, %m : i32
  return %b : i32
}
func.func private @column(%sc: i32, %x: i32, %rule: i32) -> i32 {
  %c16 = arith.constant 16 : i32
  %o = arith.muli %x, %c16 : i32
  %a = arith.addi %sc, %o : i32
  %v_p30 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
  %v = llvm.load %v_p30 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xf32>
  %w0 = vector.extract %v[0] : f32 from vector<4xf32>
  %w1 = vector.extract %v[1] : f32 from vector<4xf32>
  %w2 = vector.extract %v[2] : f32 from vector<4xf32>
  %w3 = vector.extract %v[3] : f32 from vector<4xf32>
  %b0 = func.call @alpha(%w0, %rule) : (f32, i32) -> i32
  %b1 = func.call @alpha(%w1, %rule) : (f32, i32) -> i32
  %b2 = func.call @alpha(%w2, %rule) : (f32, i32) -> i32
  %b3 = func.call @alpha(%w3, %rule) : (f32, i32) -> i32
  %c8 = arith.constant 8 : i32
  %c24 = arith.constant 24 : i32
  %s1 = arith.shli %b1, %c8 : i32
  %s2 = arith.shli %b2, %c16 : i32
  %s3 = arith.shli %b3, %c24 : i32
  %o1 = arith.ori %b0, %s1 : i32
  %o2 = arith.ori %o1, %s2 : i32
  %o3 = arith.ori %o2, %s3 : i32
  return %o3 : i32
}
func.func private @finalize(%sc: i32, %rule: i32, %aout: i32, %na: i32, %write: i1) -> i32 {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c2 = arith.constant 2 : i32
  %c3 = arith.constant 3 : i32
  scf.if %write {
    %w0 = func.call @column(%sc, %c0, %rule) : (i32, i32, i32) -> i32
    %w1 = func.call @column(%sc, %c1, %rule) : (i32, i32, i32) -> i32
    %w2 = func.call @column(%sc, %c2, %rule) : (i32, i32, i32) -> i32
    %w3 = func.call @column(%sc, %c3, %rule) : (i32, i32, i32) -> i32
    %n0 = func.call @alpha16(%aout, %na, %w0, %w1, %w2, %w3, %write) : (i32, i32, i32, i32, i32, i32, i1) -> i32
    func.call @setloc(%sc) : (i32) -> ()
  }
  %c16 = arith.constant 16 : i32
  %n = arith.addi %na, %c16 : i32
  return %n : i32
}
func.func private @area(%sc: i32, %p0x: f32, %p0y: f32, %p1x: f32, %p1y: f32) {
  %one = arith.constant 1.0 : f32
  %mhalf = arith.constant -0.5 : f32
  %z = arith.constant 0.0 : f32
  %d = arith.subf %p0y, %p1y : f32
  %pos = arith.cmpf ogt, %d, %z : f32
  %m1 = arith.constant -1.0 : f32
  %sign = arith.select %pos, %one, %m1 : f32
  %lt = arith.cmpf olt, %p0y, %p1y : f32
  %ty = arith.select %lt, %p0y, %p1y : f32
  %tx = arith.select %lt, %p0x, %p1x : f32
  %by = arith.select %lt, %p1y, %p0y : f32
  %bx = arith.select %lt, %p1x, %p0x : f32
  %dy = arith.subf %by, %ty : f32
  %dx = arith.subf %bx, %tx : f32
  %ys = arith.divf %dy, %dx : f32
  %xs = arith.divf %one, %ys : f32
  %nxs = arith.negf %xs : f32
  %base = math.fma %ty, %nxs, %tx : f32
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c4 = arith.constant 4 : i32
  %c16 = arith.constant 16 : i32
  %c64 = arith.constant 64 : i32
  %f1 = arith.constant 1.0 : f32
  %f2 = arith.constant 2.0 : f32
  %f3 = arith.constant 3.0 : f32
  %f4 = arith.constant 4.0 : f32
  %ymin0 = func.call @mx(%ty, %z) : (f32, f32) -> f32
  %ymin1 = func.call @mx(%ty, %f1) : (f32, f32) -> f32
  %ymin2 = func.call @mx(%ty, %f2) : (f32, f32) -> f32
  %ymin3 = func.call @mx(%ty, %f3) : (f32, f32) -> f32
  %ymax0 = func.call @mn(%by, %f1) : (f32, f32) -> f32
  %ymax1 = func.call @mn(%by, %f2) : (f32, f32) -> f32
  %ymax2 = func.call @mn(%by, %f3) : (f32, f32) -> f32
  %ymax3 = func.call @mn(%by, %f4) : (f32, f32) -> f32
  %acc:4 = scf.for %x = %c0 to %c4 step %c1 iter_args(%a0 = %z, %a1 = %z, %a2 = %z, %a3 = %z) -> (f32, f32, f32, f32) : i32 {
    %pl = arith.sitofp %x : i32 to f32
    %pr = arith.addf %one, %pl : f32
    %l0 = arith.subf %pl, %tx : f32
    %l1 = math.fma %l0, %ys, %ty : f32
    %q0 = arith.subf %pr, %tx : f32
    %q1 = math.fma %q0, %ys, %ty : f32
    %xo = arith.muli %x, %c16 : i32
    %la = arith.addi %sc, %xo : i32
    %cur_p31 = llvm.inttoptr %la : i32 to !llvm.ptr<1>
    %cur = llvm.load %cur_p31 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xf32>
    %cu0 = vector.extract %cur[0] : f32 from vector<4xf32>
    %cu1 = vector.extract %cur[1] : f32 from vector<4xf32>
    %cu2 = vector.extract %cur[2] : f32 from vector<4xf32>
    %cu3 = vector.extract %cur[3] : f32 from vector<4xf32>
    %r0:2 = func.call @pix(%l1, %q1, %ymin0, %ymax0, %xs, %base, %pr, %mhalf, %sign, %a0, %cu0) : (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32) -> (f32, f32)
    %r1:2 = func.call @pix(%l1, %q1, %ymin1, %ymax1, %xs, %base, %pr, %mhalf, %sign, %a1, %cu1) : (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32) -> (f32, f32)
    %r2:2 = func.call @pix(%l1, %q1, %ymin2, %ymax2, %xs, %base, %pr, %mhalf, %sign, %a2, %cu2) : (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32) -> (f32, f32)
    %r3:2 = func.call @pix(%l1, %q1, %ymin3, %ymax3, %xs, %base, %pr, %mhalf, %sign, %a3, %cu3) : (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32) -> (f32, f32)
    %nv = vector.from_elements %r0#0, %r1#0, %r2#0, %r3#0 : vector<4xf32>
    %st_p32 = llvm.inttoptr %la : i32 to !llvm.ptr<1>
    llvm.store %nv, %st_p32 {alignment = 4 : i64} : vector<4xf32>, !llvm.ptr<1>
    scf.yield %r0#1, %r1#1, %r2#1, %r3#1 : f32, f32, f32, f32
  }
  %aa = arith.addi %sc, %c64 : i32
  %accv_p33 = llvm.inttoptr %aa : i32 to !llvm.ptr<1>
  %accv = llvm.load %accv_p33 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xf32>
  %v0 = vector.extract %accv[0] : f32 from vector<4xf32>
  %v1 = vector.extract %accv[1] : f32 from vector<4xf32>
  %v2 = vector.extract %accv[2] : f32 from vector<4xf32>
  %v3 = vector.extract %accv[3] : f32 from vector<4xf32>
  %n0 = arith.addf %v0, %acc#0 : f32
  %n1 = arith.addf %v1, %acc#1 : f32
  %n2 = arith.addf %v2, %acc#2 : f32
  %n3 = arith.addf %v3, %acc#3 : f32
  %nacc = vector.from_elements %n0, %n1, %n2, %n3 : vector<4xf32>
  %st_p34 = llvm.inttoptr %aa : i32 to !llvm.ptr<1>
  llvm.store %nacc, %st_p34 {alignment = 4 : i64} : vector<4xf32>, !llvm.ptr<1>
  return
}
func.func private @pix(%l1: f32, %q1: f32, %ymin: f32, %ymax: f32, %xs: f32, %base: f32, %pr: f32, %mhalf: f32, %sign: f32, %acc: f32, %cur: f32) -> (f32, f32) {
  %l2 = func.call @mx(%l1, %ymin) : (f32, f32) -> f32
  %ly = func.call @mn(%l2, %ymax) : (f32, f32) -> f32
  %q2 = func.call @mx(%q1, %ymin) : (f32, f32) -> f32
  %ry = func.call @mn(%q2, %ymax) : (f32, f32) -> f32
  %lyx = math.fma %ly, %xs, %base : f32
  %ryx = math.fma %ry, %xs, %base : f32
  %hd = arith.subf %ry, %ly : f32
  %h = math.absf %hd : f32
  %sx = arith.addf %ryx, %lyx : f32
  %ar0 = math.fma %sx, %mhalf, %pr : f32
  %area = arith.mulf %h, %ar0 : f32
  %contrib = math.fma %area, %sign, %acc : f32
  %nw = arith.addf %cur, %contrib : f32
  %ac2 = math.fma %h, %sign, %acc : f32
  return %nw, %ac2 : f32, f32
}
func.func private @tileat(%tb: i32, %i: i32, %n: i32) -> (i32, i32, i32) {
  %c8 = arith.constant 8 : i32
  %c16 = arith.constant 16 : i32
  %m = arith.constant 65535 : i32
  %c0 = arith.constant 0 : i32
  %real = arith.cmpi slt, %i, %n : i32
  %r:3 = scf.if %real -> (i32, i32, i32) {
    %o = arith.muli %i, %c8 : i32
    %a = arith.addi %tb, %o : i32
    %v_p35 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
    %v = llvm.load %v_p35 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<2xi32>
    %lo = vector.extract %v[0] : i32 from vector<2xi32>
    %hi = vector.extract %v[1] : i32 from vector<2xi32>
    %x = arith.andi %hi, %m : i32
    %y = arith.shrui %hi, %c16 : i32
    scf.yield %lo, %x, %y : i32, i32, i32
  } else {
    scf.yield %c0, %m, %m : i32, i32, i32
  }
  return %r#0, %r#1, %r#2 : i32, i32, i32
}
func.func private @render(%lb: i32, %tb: i32, %nt: i32, %rule: i32, %wb: i32, %rows: i32, %vw: i32, %sc: i32, %sout: i32, %aout: i32, %write: i1) -> (i32, i32) {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c4 = arith.constant 4 : i32
  %c5 = arith.constant 5 : i32
  %c16 = arith.constant 16 : i32
  %c20 = arith.constant 20 : i32
  %c31 = arith.constant 31 : i32
  %z = arith.constant 0.0 : f32
  %true = arith.constant true
  %false = arith.constant false
  %rw0 = arith.addi %rows, %c31 : i32
  %words = arith.shrui %rw0, %c5 : i32
  %r20 = arith.muli %rows, %c20 : i32
  %w4 = arith.muli %words, %c4 : i32
  %co = arith.addi %r20, %w4 : i32
  %ca = arith.addi %wb, %co : i32
  %culledw_p36 = llvm.inttoptr %ca : i32 to !llvm.ptr<1>
  %culledw = llvm.load %culledw_p36 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %culled = arith.cmpi ne, %culledw, %c0 : i32
  %none = arith.cmpi eq, %nt, %c0 : i32
  %notc = arith.xori %culled, %true : i1
  %nothing = arith.andi %notc, %none : i1
  %res:2 = scf.if %nothing -> (i32, i32) {
    scf.yield %c0, %c0 : i32, i32
  } else {
    %zv = vector.from_elements %z, %z, %z, %z : vector<4xf32>
    %c64 = arith.constant 64 : i32
    %aa = arith.addi %sc, %c64 : i32
    %st_p37 = llvm.inttoptr %aa : i32 to !llvm.ptr<1>
    llvm.store %zv, %st_p37 {alignment = 4 : i64} : vector<4xf32>, !llvm.ptr<1>
    func.call @setloc(%sc) : (i32) -> ()
    %t0:3 = func.call @tileat(%tb, %c0, %nt) : (i32, i32, i32) -> (i32, i32, i32)
    %lv0 = arith.cmpi eq, %t0#1, %c0 : i32
    %m1 = arith.constant -1 : i32
    %st:4 = scf.if %culled -> (i32, i32, i32, i32) {
      %rmax = arith.minsi %t0#2, %rows : i32
      %bg:3 = func.call @emit_bg(%c0, %rmax, %vw, %wb, %rows, %rule, %sout, %c0, %aout, %c0, %m1, %write) : (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i1) -> (i32, i32, i32)
      %cp:4 = scf.if %none -> (i32, i32, i32, i32) {
        scf.yield %c0, %bg#0, %bg#1, %bg#2 : i32, i32, i32, i32
      } else {
        %c:4 = func.call @captive(%t0#2, %lv0, %wb, %rows, %rule, %sc, %sout, %bg#0, %aout, %bg#1, %bg#2, %write) : (i32, i1, i32, i32, i32, i32, i32, i32, i32, i32, i32, i1) -> (i32, i32, i32, i32)
        func.call @setloc(%sc) : (i32) -> ()
        scf.yield %c#0, %c#1, %c#2, %c#3 : i32, i32, i32, i32
      }
      scf.yield %cp#0, %cp#1, %cp#2, %cp#3 : i32, i32, i32, i32
    } else {
      scf.yield %c0, %c0, %c0, %m1 : i32, i32, i32, i32
    }
    %onlybg = arith.andi %culled, %none : i1
    %out:2 = scf.if %onlybg -> (i32, i32) {
      %any = arith.cmpi sge, %st#3, %c0 : i32
      %fs = scf.if %any -> (i32) {
        %m = arith.constant 65535 : i32
        %s = func.call @push(%sout, %st#1, %m, %st#3, %st#2, %false, %write) : (i32, i32, i32, i32, i32, i1, i1) -> i32
        scf.yield %s : i32
      } else {
        scf.yield %st#1 : i32
      }
      scf.yield %fs, %st#2 : i32, i32
    } else {
      %fw = func.call @fillp(%st#0, %rule) : (i32, i32) -> i1
      %nlv = arith.xori %lv0, %true : i1
      %sf0 = arith.andi %fw, %nlv : i1
      %sx0 = arith.muli %t0#1, %c4 : i32
      %sy0 = arith.muli %t0#2, %c4 : i32
      %sfi = arith.extui %sf0 : i1 to i32
      %ntp = arith.addi %nt, %c1 : i32
      %lp:12 = scf.for %i = %c0 to %ntp step %c1 iter_args(%plo = %t0#0, %px = %t0#1, %py = %t0#2, %wd = %st#0, %ns = %st#1, %na = %st#2, %sx = %sx0, %sy = %sy0, %sai = %st#2, %sfl = %sfi, %ly = %st#3, %done = %c0) -> (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32) : i32 {
        %live = arith.cmpi eq, %done, %c0 : i32
        %o:12 = scf.if %live -> (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32) {
          %t:3 = func.call @tileat(%tb, %i, %nt) : (i32, i32, i32) -> (i32, i32, i32)
          %sent = arith.cmpi eq, %i, %nt : i32
          %li = arith.shrui %t#0, %c5 : i32
          %c16l = arith.constant 16 : i32
          %lo16 = arith.muli %li, %c16l : i32
          %la = arith.addi %lb, %lo16 : i32
          %lv_p38 = llvm.inttoptr %la : i32 to !llvm.ptr<1>
          %lv = llvm.load %lv_p38 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xf32>
          %txf0 = arith.sitofp %t#1 : i32 to f32
          %tyf0 = arith.sitofp %t#2 : i32 to f32
          %four = arith.constant 4.0 : f32
          %tlx = arith.mulf %txf0, %four : f32
          %tty = arith.mulf %tyf0, %four : f32
          %x0 = vector.extract %lv[0] : f32 from vector<4xf32>
          %y0 = vector.extract %lv[1] : f32 from vector<4xf32>
          %x1 = vector.extract %lv[2] : f32 from vector<4xf32>
          %y1 = vector.extract %lv[3] : f32 from vector<4xf32>
          %q0x = arith.subf %x0, %tlx : f32
          %q0y = arith.subf %y0, %tty : f32
          %q1x = arith.subf %x1, %tlx : f32
          %q1y = arith.subf %y1, %tty : f32
          %samerow = arith.cmpi eq, %py, %t#2 : i32
          %samex = arith.cmpi eq, %px, %t#1 : i32
          %sameloc = arith.andi %samerow, %samex : i1
          %pxn = arith.addi %px, %c1 : i32
          %nextx = arith.cmpi eq, %pxn, %t#1 : i32
          %prevloc = arith.andi %samerow, %nextx : i1
          %newloc = arith.xori %sameloc, %true : i1
          %na1 = scf.if %newloc -> (i32) {
            %n = func.call @finalize(%sc, %rule, %aout, %na, %write) : (i32, i32, i32, i32, i1) -> i32
            scf.yield %n : i32
          } else {
            scf.yield %na : i32
          }
          %np = arith.xori %prevloc, %true : i1
          %newstrip = arith.andi %newloc, %np : i1
          %s:10 = scf.if %newstrip -> (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32) {
            %sfb = arith.cmpi ne, %sfl, %c0 : i32
            %ns1 = func.call @push(%sout, %ns, %sx, %sy, %sai, %sfb, %write) : (i32, i32, i32, i32, i32, i1, i1) -> i32
            %lvp = arith.cmpi eq, %t#1, %c0 : i32
            %nr = arith.xori %samerow, %true : i1
            %rw:5 = scf.if %nr -> (i32, i32, i32, i32, i32) {
              %wnz = arith.cmpi ne, %wd, %c0 : i32
              %e:3 = scf.if %wnz -> (i32, i32, i32) {
                %pyp = arith.muli %py, %c4 : i32
                %fw2 = func.call @fillp(%wd, %rule) : (i32, i32) -> i1
                %n2 = func.call @push(%sout, %ns1, %vw, %pyp, %na1, %fw2, %write) : (i32, i32, i32, i32, i32, i1, i1) -> i32
                scf.yield %n2, %na1, %pyp : i32, i32, i32
              } else {
                %psy = arith.muli %py, %c4 : i32
                scf.yield %ns1, %na1, %psy : i32, i32, i32
              }
              %ns_ = arith.xori %sent, %true : i1
              %cb = arith.andi %culled, %ns_ : i1
              %f:4 = scf.if %cb -> (i32, i32, i32, i32) {
                %py1 = arith.addi %py, %c1 : i32
                %bg:3 = func.call @emit_bg(%py1, %t#2, %vw, %wb, %rows, %rule, %sout, %e#0, %aout, %e#1, %e#2, %write) : (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i1) -> (i32, i32, i32)
                %cp:4 = func.call @captive(%t#2, %lvp, %wb, %rows, %rule, %sc, %sout, %bg#0, %aout, %bg#1, %bg#2, %write) : (i32, i1, i32, i32, i32, i32, i32, i32, i32, i32, i32, i1) -> (i32, i32, i32, i32)
                scf.yield %cp#0, %cp#1, %cp#2, %cp#3 : i32, i32, i32, i32
              } else {
                %zv2 = vector.from_elements %z, %z, %z, %z : vector<4xf32>
                %c64b = arith.constant 64 : i32
                %aab = arith.addi %sc, %c64b : i32
                %st_p39 = llvm.inttoptr %aab : i32 to !llvm.ptr<1>
                llvm.store %zv2, %st_p39 {alignment = 4 : i64} : vector<4xf32>, !llvm.ptr<1>
                scf.yield %c0, %e#0, %e#1, %e#2 : i32, i32, i32, i32
              }
              func.call @setloc(%sc) : (i32) -> ()
              scf.yield %f#0, %f#1, %f#2, %f#3, %c0 : i32, i32, i32, i32, i32
            } else {
              %wf = arith.sitofp %wd : i32 to f32
              %wv = vector.from_elements %wf, %wf, %wf, %wf : vector<4xf32>
              %c64c = arith.constant 64 : i32
              %aac = arith.addi %sc, %c64c : i32
              %st_p40 = llvm.inttoptr %aac : i32 to !llvm.ptr<1>
              llvm.store %wv, %st_p40 {alignment = 4 : i64} : vector<4xf32>, !llvm.ptr<1>
              %psy2 = arith.muli %py, %c4 : i32
              scf.yield %wd, %ns1, %na1, %psy2, %c0 : i32, i32, i32, i32, i32
            }
            %fw3 = func.call @fillp(%rw#0, %rule) : (i32, i32) -> i1
            %nlv2 = arith.xori %lvp, %true : i1
            %sf2 = arith.andi %fw3, %nlv2 : i1
            %sfi2 = arith.extui %sf2 : i1 to i32
            %sx2 = arith.muli %t#1, %c4 : i32
            %sy2 = arith.muli %t#2, %c4 : i32
            %dn = arith.extui %sent : i1 to i32
            scf.yield %rw#0, %rw#1, %rw#2, %sx2, %sy2, %rw#2, %sfi2, %rw#3, %dn, %c0 : i32, i32, i32, i32, i32, i32, i32, i32, i32, i32
          } else {
            scf.yield %wd, %ns, %na1, %sx, %sy, %sai, %sfl, %ly, %c0, %c0 : i32, i32, i32, i32, i32, i32, i32, i32, i32, i32
          }
          %stop = arith.cmpi ne, %s#8, %c0 : i32
          %o2:12 = scf.if %stop -> (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32) {
            scf.yield %plo, %px, %py, %s#0, %s#1, %s#2, %s#3, %s#4, %s#5, %s#6, %s#7, %c1 : i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32
          } else {
            %flat = arith.cmpf oeq, %q0y, %q1y : f32
            %wd2 = scf.if %flat -> (i32) {
              scf.yield %s#0 : i32
            } else {
              %dd = arith.subf %q0y, %q1y : f32
              %up = arith.cmpf ogt, %dd, %z : f32
              %m1c = arith.constant -1 : i32
              %sgn = arith.select %up, %c1, %m1c : i32
              %c4w = arith.constant 4 : i32
              %wbit0 = arith.shrui %t#0, %c4w : i32
              %wbit = arith.andi %wbit0, %c1 : i32
              %dw = arith.muli %sgn, %wbit : i32
              %wn = arith.addi %s#0, %dw : i32
              func.call @area(%sc, %q0x, %q0y, %q1x, %q1y) : (i32, f32, f32, f32, f32) -> ()
              scf.yield %wn : i32
            }
            scf.yield %t#0, %t#1, %t#2, %wd2, %s#1, %s#2, %s#3, %s#4, %s#5, %s#6, %s#7, %c0 : i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32
          }
          scf.yield %o2#0, %o2#1, %o2#2, %o2#3, %o2#4, %o2#5, %o2#6, %o2#7, %o2#8, %o2#9, %o2#10, %o2#11 : i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32
        } else {
          scf.yield %plo, %px, %py, %wd, %ns, %na, %sx, %sy, %sai, %sfl, %ly, %done : i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32
        }
        scf.yield %o#0, %o#1, %o#2, %o#3, %o#4, %o#5, %o#6, %o#7, %o#8, %o#9, %o#10, %o#11 : i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32
      }
      %fin:3 = scf.if %culled -> (i32, i32, i32) {
        %py1 = arith.addi %lp#2, %c1 : i32
        %ys = arith.minsi %py1, %rows : i32
        %bg:3 = func.call @emit_bg(%ys, %rows, %vw, %wb, %rows, %rule, %sout, %lp#4, %aout, %lp#5, %lp#10, %write) : (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i1) -> (i32, i32, i32)
        scf.yield %bg#0, %bg#1, %bg#2 : i32, i32, i32
      } else {
        scf.yield %lp#4, %lp#5, %lp#10 : i32, i32, i32
      }
      %any = arith.cmpi sgt, %fin#0, %c0 : i32
      %fs = scf.if %any -> (i32) {
        %m = arith.constant 65535 : i32
        %s = func.call @push(%sout, %fin#0, %m, %fin#2, %fin#1, %false, %write) : (i32, i32, i32, i32, i32, i1, i1) -> i32
        scf.yield %s : i32
      } else {
        scf.yield %fin#0 : i32
      }
      scf.yield %fs, %fin#1 : i32, i32
    }
    scf.yield %out#0, %out#1 : i32, i32
  }
  return %res#0, %res#1 : i32, i32
}
func.func private @wblock(%windings: i32, %consts: i32, %p: i32, %stride: i32) -> i32 {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c4 = arith.constant 4 : i32
  %c12 = arith.constant 12 : i32
  %c16 = arith.constant 16 : i32
  %fa = arith.addi %consts, %c12 : i32
  %flags_p41 = llvm.inttoptr %fa : i32 to !llvm.ptr<1>
  %flags = llvm.load %flags_p41 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %sparse = arith.cmpi ne, %flags, %c0 : i32
  %blk = scf.if %sparse -> (i32) {
    %p4 = arith.muli %p, %c4 : i32
    %f0 = arith.addi %flags, %p4 : i32
    %f_p42 = llvm.inttoptr %f0 : i32 to !llvm.ptr<1>
    %f = llvm.load %f_p42 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %pa = arith.addi %consts, %c16 : i32
    %pre0_p43 = llvm.inttoptr %pa : i32 to !llvm.ptr<1>
    %pre0 = llvm.load %pre0_p43 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %pre1 = arith.addi %pre0, %p4 : i32
    %pre_p44 = llvm.inttoptr %pre1 : i32 to !llvm.ptr<1>
    %pre = llvm.load %pre_p44 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
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
gpu.func @runs(%params: i32, %npaths: i32, %pass: i32) kernel {
  %q4 = arith.constant 4 : i32
  %paths_p45 = llvm.inttoptr %params : i32 to !llvm.ptr<1>
  %paths = llvm.load %paths_p45 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %q1 = arith.addi %params, %q4 : i32
  %windings_p46 = llvm.inttoptr %q1 : i32 to !llvm.ptr<1>
  %windings = llvm.load %windings_p46 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %q2 = arith.addi %q1, %q4 : i32
  %consts_p47 = llvm.inttoptr %q2 : i32 to !llvm.ptr<1>
  %consts = llvm.load %consts_p47 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %q3 = arith.addi %q2, %q4 : i32
  %tiles_p48 = llvm.inttoptr %q3 : i32 to !llvm.ptr<1>
  %tiles = llvm.load %tiles_p48 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %q5 = arith.addi %q3, %q4 : i32
  %runs_p49 = llvm.inttoptr %q5 : i32 to !llvm.ptr<1>
  %runs = llvm.load %runs_p49 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %q6 = arith.addi %q5, %q4 : i32
  %rcounts_p50 = llvm.inttoptr %q6 : i32 to !llvm.ptr<1>
  %rcounts = llvm.load %rcounts_p50 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %q7 = arith.addi %q6, %q4 : i32
  %roffsets_p51 = llvm.inttoptr %q7 : i32 to !llvm.ptr<1>
  %roffsets = llvm.load %roffsets_p51 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c4 = arith.constant 4 : i32
  %c5 = arith.constant 5 : i32
  %c16 = arith.constant 16 : i32
  %c20 = arith.constant 20 : i32
  %c31 = arith.constant 31 : i32
  %c32 = arith.constant 32 : i32
  %m1 = arith.constant -1 : i32
  %rows_p52 = llvm.inttoptr %consts : i32 to !llvm.ptr<1>
  %rows = llvm.load %rows_p52 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %k2 = arith.constant 8 : i32
  %ka = arith.addi %consts, %k2 : i32
  %wstride_p53 = llvm.inttoptr %ka : i32 to !llvm.ptr<1>
  %wstride = llvm.load %wstride_p53 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %g_ix54 = gpu.block_id x
  %g = arith.index_cast %g_ix54 : index to i32
  %l_ix55 = gpu.thread_id x
  %l = arith.index_cast %l_ix55 : index to i32
  %b0 = arith.muli %g, %c16 : i32
  %p = arith.addi %b0, %l : i32
  %inside = arith.cmpi slt, %p, %npaths : i32
  scf.if %inside {
    %po = arith.muli %p, %c16 : i32
    %pa = arith.addi %paths, %po : i32
    %pv_p56 = llvm.inttoptr %pa : i32 to !llvm.ptr<1>
    %pv = llvm.load %pv_p56 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xi32>
    %ft = vector.extract %pv[1] : i32 from vector<4xi32>
    %nt = vector.extract %pv[2] : i32 from vector<4xi32>
    %p4r = arith.muli %p, %q4 : i32
    %roa = arith.addi %roffsets, %p4r : i32
    %write = arith.cmpi eq, %pass, %c1 : i32
    %slot0 = scf.if %write -> (i32) {
      %v_p57 = llvm.inttoptr %roa : i32 to !llvm.ptr<1>
      %v = llvm.load %v_p57 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
      scf.yield %v : i32
    } else {
      scf.yield %c0 : i32
    }
    %wb = func.call @wblock(%windings, %consts, %p, %wstride) : (i32, i32, i32, i32) -> i32
    %rw0 = arith.addi %rows, %c31 : i32
    %words = arith.shrui %rw0, %c5 : i32
    %r20 = arith.muli %rows, %c20 : i32
    %w4 = arith.muli %words, %c4 : i32
    %co = arith.addi %r20, %w4 : i32
    %ca = arith.addi %wb, %co : i32
    %culledw_p58 = llvm.inttoptr %ca : i32 to !llvm.ptr<1>
    %culledw = llvm.load %culledw_p58 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %culled = arith.cmpi ne, %culledw, %c0 : i32
    %none = arith.cmpi eq, %nt, %c0 : i32
    %c7 = arith.constant 7 : i32
    %nruns = scf.if %none -> (i32) {
      %one = arith.select %culled, %c1, %c0 : i32
      %w1 = arith.andi %culled, %write : i1
      scf.if %w1 {
        func.call @run_put(%runs, %slot0, %p, %ft, %c0, %m1, %c7) : (i32, i32, i32, i32, i32, i32, i32) -> ()
      }
      scf.yield %one : i32
    } else {
      %t8 = arith.constant 8 : i32
      %tb0 = arith.muli %ft, %t8 : i32
      %tb = arith.addi %tiles, %tb0 : i32
      %t0:3 = func.call @tileat(%tb, %c0, %nt) : (i32, i32, i32) -> (i32, i32, i32)
      %w:4 = scf.for %i = %c1 to %nt step %c1 iter_args(%rf = %c0, %ry = %t0#2, %rprev = %m1, %k = %c0) -> (i32, i32, i32, i32) : i32 {
        %t:3 = func.call @tileat(%tb, %i, %nt) : (i32, i32, i32) -> (i32, i32, i32)
        %newrow = arith.cmpi ne, %t#2, %ry : i32
        %o:4 = scf.if %newrow -> (i32, i32, i32, i32) {
          %first = arith.cmpi eq, %k, %c0 : i32
          %fl0 = arith.select %first, %c1, %c0 : i32
          %c4f = arith.constant 4 : i32
          %fl = arith.ori %fl0, %c4f : i32
          %n = arith.subi %i, %rf : i32
          %slot = arith.addi %slot0, %k : i32
          %g0 = arith.addi %ft, %rf : i32
          scf.if %write {
            func.call @run_put(%runs, %slot, %p, %g0, %n, %rprev, %fl) : (i32, i32, i32, i32, i32, i32, i32) -> ()
          }
          %k1 = arith.addi %k, %c1 : i32
          scf.yield %i, %t#2, %ry, %k1 : i32, i32, i32, i32
        } else {
          scf.yield %rf, %ry, %rprev, %k : i32, i32, i32, i32
        }
        scf.yield %o#0, %o#1, %o#2, %o#3 : i32, i32, i32, i32
      }
      %first = arith.cmpi eq, %w#3, %c0 : i32
      %fl0 = arith.select %first, %c1, %c0 : i32
      %c6 = arith.constant 6 : i32
      %fl = arith.ori %fl0, %c6 : i32
      %n = arith.subi %nt, %w#0 : i32
      %slot = arith.addi %slot0, %w#3 : i32
      %g0 = arith.addi %ft, %w#0 : i32
      scf.if %write {
        func.call @run_put(%runs, %slot, %p, %g0, %n, %w#2, %fl) : (i32, i32, i32, i32, i32, i32, i32) -> ()
      }
      %nr = arith.addi %w#3, %c1 : i32
      scf.yield %nr : i32
    }
    %pass0 = arith.cmpi eq, %pass, %c0 : i32
    scf.if %pass0 {
      %rca = arith.addi %rcounts, %p4r : i32
      %st_p59 = llvm.inttoptr %rca : i32 to !llvm.ptr<1>
      llvm.store %nruns, %st_p59 {alignment = 4 : i64} : i32, !llvm.ptr<1>
    }
  }
  gpu.return
}
func.func private @run_put(%runs: i32, %slot: i32, %p: i32, %first: i32, %n: i32, %prev: i32, %flags: i32) {
  %c32 = arith.constant 32 : i32
  %o = arith.muli %slot, %c32 : i32
  %a = arith.addi %runs, %o : i32
  %v = vector.from_elements %p, %first, %n, %prev : vector<4xi32>
  %st_p60 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
  llvm.store %v, %st_p60 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr<1>
  %c16 = arith.constant 16 : i32
  %a2 = arith.addi %a, %c16 : i32
  %st_p61 = llvm.inttoptr %a2 : i32 to !llvm.ptr<1>
  llvm.store %flags, %st_p61 {alignment = 4 : i64} : i32, !llvm.ptr<1>
  return
}
gpu.func @strips_run(%params: i32, %nslots: i32, %pass: i32) kernel {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c2 = arith.constant 2 : i32
  %c4 = arith.constant 4 : i32
  %c8 = arith.constant 8 : i32
  %c16 = arith.constant 16 : i32
  %lines_p62 = llvm.inttoptr %params : i32 to !llvm.ptr<1>
  %lines = llvm.load %lines_p62 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a1 = arith.addi %params, %c4 : i32
  %paths_p63 = llvm.inttoptr %a1 : i32 to !llvm.ptr<1>
  %paths = llvm.load %paths_p63 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a2 = arith.addi %a1, %c4 : i32
  %tiles_p64 = llvm.inttoptr %a2 : i32 to !llvm.ptr<1>
  %tiles = llvm.load %tiles_p64 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a3 = arith.addi %a2, %c4 : i32
  %windings_p65 = llvm.inttoptr %a3 : i32 to !llvm.ptr<1>
  %windings = llvm.load %windings_p65 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a4 = arith.addi %a3, %c4 : i32
  %consts_p66 = llvm.inttoptr %a4 : i32 to !llvm.ptr<1>
  %consts = llvm.load %consts_p66 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a5 = arith.addi %a4, %c4 : i32
  %counts_p67 = llvm.inttoptr %a5 : i32 to !llvm.ptr<1>
  %counts = llvm.load %counts_p67 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a6 = arith.addi %a5, %c4 : i32
  %offsets_p68 = llvm.inttoptr %a6 : i32 to !llvm.ptr<1>
  %offsets = llvm.load %offsets_p68 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a7 = arith.addi %a6, %c4 : i32
  %strips_p69 = llvm.inttoptr %a7 : i32 to !llvm.ptr<1>
  %strips = llvm.load %strips_p69 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a8 = arith.addi %a7, %c4 : i32
  %alphas_p70 = llvm.inttoptr %a8 : i32 to !llvm.ptr<1>
  %alphas = llvm.load %alphas_p70 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a9 = arith.addi %a8, %c4 : i32
  %scratch_p71 = llvm.inttoptr %a9 : i32 to !llvm.ptr<1>
  %scratch = llvm.load %scratch_p71 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a10 = arith.addi %a9, %c4 : i32
  %runs_p72 = llvm.inttoptr %a10 : i32 to !llvm.ptr<1>
  %runs = llvm.load %runs_p72 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a11 = arith.addi %a10, %c4 : i32
  %roffsets_p73 = llvm.inttoptr %a11 : i32 to !llvm.ptr<1>
  %roffsets = llvm.load %roffsets_p73 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %rows_p74 = llvm.inttoptr %consts : i32 to !llvm.ptr<1>
  %rows = llvm.load %rows_p74 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %k1 = arith.addi %consts, %c4 : i32
  %vw_p75 = llvm.inttoptr %k1 : i32 to !llvm.ptr<1>
  %vw = llvm.load %vw_p75 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %k2 = arith.addi %k1, %c4 : i32
  %wstride_p76 = llvm.inttoptr %k2 : i32 to !llvm.ptr<1>
  %wstride = llvm.load %wstride_p76 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %g_ix77 = gpu.block_id x
  %g = arith.index_cast %g_ix77 : index to i32
  %l_ix78 = gpu.thread_id x
  %l = arith.index_cast %l_ix78 : index to i32
  %b0 = arith.muli %g, %c16 : i32
  %s = arith.addi %b0, %l : i32
  %inside = arith.cmpi slt, %s, %nslots : i32
  scf.if %inside {
    %c32 = arith.constant 32 : i32
    %ro = arith.muli %s, %c32 : i32
    %ra = arith.addi %runs, %ro : i32
    %rv_p79 = llvm.inttoptr %ra : i32 to !llvm.ptr<1>
    %rv = llvm.load %rv_p79 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xi32>
    %c16r = arith.constant 16 : i32
    %rfa = arith.addi %ra, %c16r : i32
    %flags_p80 = llvm.inttoptr %rfa : i32 to !llvm.ptr<1>
    %flags = llvm.load %flags_p80 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %p = vector.extract %rv[0] : i32 from vector<4xi32>
    %rfirst = vector.extract %rv[1] : i32 from vector<4xi32>
    %rn = vector.extract %rv[2] : i32 from vector<4xi32>
    %rprev = vector.extract %rv[3] : i32 from vector<4xi32>
    %isrun0 = arith.andi %flags, %c4 : i32
    %isrun = arith.cmpi ne, %isrun0, %c0 : i32
    %write = arith.cmpi eq, %pass, %c1 : i32
    %s8 = arith.muli %s, %c8 : i32
    %n:2 = scf.if %isrun -> (i32, i32) {
      %po = arith.muli %p, %c16 : i32
      %pa = arith.addi %paths, %po : i32
      %pv_p81 = llvm.inttoptr %pa : i32 to !llvm.ptr<1>
      %pv = llvm.load %pv_p81 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xi32>
      %fl = vector.extract %pv[0] : i32 from vector<4xi32>
      %ft = vector.extract %pv[1] : i32 from vector<4xi32>
      %rule = vector.extract %pv[3] : i32 from vector<4xi32>
      %oa = arith.addi %offsets, %s8 : i32
      %p4s = arith.muli %p, %c4 : i32
      %rpa = arith.addi %roffsets, %p4s : i32
      %slot0_p82 = llvm.inttoptr %rpa : i32 to !llvm.ptr<1>
      %slot0 = llvm.load %slot0_p82 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
      %s08 = arith.muli %slot0, %c8 : i32
      %oa0 = arith.addi %offsets, %s08 : i32
      %ov:3 = scf.if %write -> (i32, i32, i32) {
        %v_p83 = llvm.inttoptr %oa : i32 to !llvm.ptr<1>
        %v = llvm.load %v_p83 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<2xi32>
        %v0_p84 = llvm.inttoptr %oa0 : i32 to !llvm.ptr<1>
        %v0 = llvm.load %v0_p84 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<2xi32>
        %so = vector.extract %v[0] : i32 from vector<2xi32>
        %ao = vector.extract %v[1] : i32 from vector<2xi32>
        %ab = vector.extract %v0[1] : i32 from vector<2xi32>
        scf.yield %so, %ao, %ab : i32, i32, i32
      } else {
        scf.yield %c0, %c0, %c0 : i32, i32, i32
      }
      %so8 = arith.muli %ov#0, %c8 : i32
      %sout = arith.addi %strips, %so8 : i32
      %abase = arith.subi %ov#1, %ov#2 : i32
      %aout = arith.addi %alphas, %ov#2 : i32
      %wb = func.call @wblock(%windings, %consts, %p, %wstride) : (i32, i32, i32, i32) -> i32
      %c80 = arith.constant 80 : i32
      %sc0 = arith.muli %s, %c80 : i32
      %sc = arith.addi %scratch, %sc0 : i32
      %l16 = arith.muli %fl, %c16 : i32
      %lb = arith.addi %lines, %l16 : i32
      %tb0 = arith.muli %rfirst, %c8 : i32
      %tb = arith.addi %tiles, %tb0 : i32
      %r:2 = func.call @render_run(%lb, %tb, %rn, %rprev, %flags, %rule, %wb, %rows, %vw, %sc, %sout, %aout, %abase, %write) : (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i1) -> (i32, i32)
      scf.yield %r#0, %r#1 : i32, i32
    } else {
      scf.yield %c0, %c0 : i32, i32
    }
    %first = arith.cmpi eq, %pass, %c0 : i32
    scf.if %first {
      %ca = arith.addi %counts, %s8 : i32
      %cv = vector.from_elements %n#0, %n#1 : vector<2xi32>
      %st_p85 = llvm.inttoptr %ca : i32 to !llvm.ptr<1>
      llvm.store %cv, %st_p85 {alignment = 4 : i64} : vector<2xi32>, !llvm.ptr<1>
    }
  }
  gpu.return
}
func.func private @render_run(%lb: i32, %tb: i32, %nt: i32, %prev: i32, %flags: i32, %rule: i32, %wb: i32, %rows: i32, %vw: i32, %sc: i32, %sout: i32, %aout: i32, %abase: i32, %write: i1) -> (i32, i32) {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c2 = arith.constant 2 : i32
  %c4 = arith.constant 4 : i32
  %c5 = arith.constant 5 : i32
  %c16 = arith.constant 16 : i32
  %c20 = arith.constant 20 : i32
  %c31 = arith.constant 31 : i32
  %m1 = arith.constant -1 : i32
  %z = arith.constant 0.0 : f32
  %true = arith.constant true
  %false = arith.constant false
  %rw0 = arith.addi %rows, %c31 : i32
  %words = arith.shrui %rw0, %c5 : i32
  %r20 = arith.muli %rows, %c20 : i32
  %w4 = arith.muli %words, %c4 : i32
  %co = arith.addi %r20, %w4 : i32
  %ca = arith.addi %wb, %co : i32
  %culledw_p86 = llvm.inttoptr %ca : i32 to !llvm.ptr<1>
  %culledw = llvm.load %culledw_p86 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %culled = arith.cmpi ne, %culledw, %c0 : i32
  %f1 = arith.andi %flags, %c1 : i32
  %isfirst = arith.cmpi ne, %f1, %c0 : i32
  %f2 = arith.andi %flags, %c2 : i32
  %islast = arith.cmpi ne, %f2, %c0 : i32
  %none = arith.cmpi eq, %nt, %c0 : i32
  %zv = vector.from_elements %z, %z, %z, %z : vector<4xf32>
  %c64 = arith.constant 64 : i32
  %aa = arith.addi %sc, %c64 : i32
  %st_p87 = llvm.inttoptr %aa : i32 to !llvm.ptr<1>
  llvm.store %zv, %st_p87 {alignment = 4 : i64} : vector<4xf32>, !llvm.ptr<1>
  func.call @setloc(%sc) : (i32) -> ()
  %res:3 = scf.if %none -> (i32, i32, i32) {
    %bg:3 = func.call @emit_bg(%c0, %rows, %vw, %wb, %rows, %rule, %sout, %c0, %aout, %abase, %m1, %write) : (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i1) -> (i32, i32, i32)
    scf.yield %bg#0, %bg#1, %bg#2 : i32, i32, i32
  } else {
    %t0:3 = func.call @tileat(%tb, %c0, %nt) : (i32, i32, i32) -> (i32, i32, i32)
    %y = arith.addi %t0#2, %c0 : i32
    %lv0 = arith.cmpi eq, %t0#1, %c0 : i32
    %st:4 = scf.if %culled -> (i32, i32, i32, i32) {
      %pv1 = arith.addi %prev, %c1 : i32
      %rmax = arith.minsi %y, %rows : i32
      %from = arith.select %isfirst, %c0, %pv1 : i32
      %to = arith.select %isfirst, %rmax, %y : i32
      %bg:3 = func.call @emit_bg(%from, %to, %vw, %wb, %rows, %rule, %sout, %c0, %aout, %abase, %m1, %write) : (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i1) -> (i32, i32, i32)
      %c:4 = func.call @captive(%y, %lv0, %wb, %rows, %rule, %sc, %sout, %bg#0, %aout, %bg#1, %bg#2, %write) : (i32, i1, i32, i32, i32, i32, i32, i32, i32, i32, i32, i1) -> (i32, i32, i32, i32)
      func.call @setloc(%sc) : (i32) -> ()
      scf.yield %c#0, %c#1, %c#2, %c#3 : i32, i32, i32, i32
    } else {
      scf.yield %c0, %c0, %abase, %m1 : i32, i32, i32, i32
    }
    %fw = func.call @fillp(%st#0, %rule) : (i32, i32) -> i1
    %nlv = arith.xori %lv0, %true : i1
    %sf0 = arith.andi %fw, %nlv : i1
    %sx0 = arith.muli %t0#1, %c4 : i32
    %sy0 = arith.muli %y, %c4 : i32
    %sfi = arith.extui %sf0 : i1 to i32
    %lp:8 = scf.for %i = %c0 to %nt step %c1 iter_args(%plo = %t0#0, %px = %t0#1, %wd = %st#0, %ns = %st#1, %na = %st#2, %sx = %sx0, %sai = %st#2, %sfl = %sfi) -> (i32, i32, i32, i32, i32, i32, i32, i32) : i32 {
      %t:3 = func.call @tileat(%tb, %i, %nt) : (i32, i32, i32) -> (i32, i32, i32)
      %li = arith.shrui %t#0, %c5 : i32
      %lo16 = arith.muli %li, %c16 : i32
      %la = arith.addi %lb, %lo16 : i32
      %lv_p88 = llvm.inttoptr %la : i32 to !llvm.ptr<1>
      %lv = llvm.load %lv_p88 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xf32>
      %txf0 = arith.sitofp %t#1 : i32 to f32
      %tyf0 = arith.sitofp %y : i32 to f32
      %four = arith.constant 4.0 : f32
      %tlx = arith.mulf %txf0, %four : f32
      %tty = arith.mulf %tyf0, %four : f32
      %x0 = vector.extract %lv[0] : f32 from vector<4xf32>
      %y0 = vector.extract %lv[1] : f32 from vector<4xf32>
      %x1 = vector.extract %lv[2] : f32 from vector<4xf32>
      %y1 = vector.extract %lv[3] : f32 from vector<4xf32>
      %q0x = arith.subf %x0, %tlx : f32
      %q0y = arith.subf %y0, %tty : f32
      %q1x = arith.subf %x1, %tlx : f32
      %q1y = arith.subf %y1, %tty : f32
      %samex = arith.cmpi eq, %px, %t#1 : i32
      %pxn = arith.addi %px, %c1 : i32
      %nextx = arith.cmpi eq, %pxn, %t#1 : i32
      %newloc = arith.xori %samex, %true : i1
      %na1 = scf.if %newloc -> (i32) {
        %n = func.call @finalize(%sc, %rule, %aout, %na, %write) : (i32, i32, i32, i32, i1) -> i32
        scf.yield %n : i32
      } else {
        scf.yield %na : i32
      }
      %np = arith.xori %nextx, %true : i1
      %newstrip = arith.andi %newloc, %np : i1
      %ss:4 = scf.if %newstrip -> (i32, i32, i32, i32) {
        %sfb = arith.cmpi ne, %sfl, %c0 : i32
        %ns1 = func.call @push(%sout, %ns, %sx, %sy0, %sai, %sfb, %write) : (i32, i32, i32, i32, i32, i1, i1) -> i32
        %wf = arith.sitofp %wd : i32 to f32
        %wv = vector.from_elements %wf, %wf, %wf, %wf : vector<4xf32>
        %st_p89 = llvm.inttoptr %aa : i32 to !llvm.ptr<1>
        llvm.store %wv, %st_p89 {alignment = 4 : i64} : vector<4xf32>, !llvm.ptr<1>
        %lvp = arith.cmpi eq, %t#1, %c0 : i32
        %fw3 = func.call @fillp(%wd, %rule) : (i32, i32) -> i1
        %nlv2 = arith.xori %lvp, %true : i1
        %sf2 = arith.andi %fw3, %nlv2 : i1
        %sfi2 = arith.extui %sf2 : i1 to i32
        %sx2 = arith.muli %t#1, %c4 : i32
        scf.yield %ns1, %sx2, %na1, %sfi2 : i32, i32, i32, i32
      } else {
        scf.yield %ns, %sx, %sai, %sfl : i32, i32, i32, i32
      }
      %flat = arith.cmpf oeq, %q0y, %q1y : f32
      %wd2 = scf.if %flat -> (i32) {
        scf.yield %wd : i32
      } else {
        %dd = arith.subf %q0y, %q1y : f32
        %up = arith.cmpf ogt, %dd, %z : f32
        %sgn = arith.select %up, %c1, %m1 : i32
        %wbit0 = arith.shrui %t#0, %c4 : i32
        %wbit = arith.andi %wbit0, %c1 : i32
        %dw = arith.muli %sgn, %wbit : i32
        %wn = arith.addi %wd, %dw : i32
        scf.if %write {
          func.call @area(%sc, %q0x, %q0y, %q1x, %q1y) : (i32, f32, f32, f32, f32) -> ()
        }
        scf.yield %wn : i32
      }
      scf.yield %t#0, %t#1, %wd2, %ss#0, %na1, %ss#1, %ss#2, %ss#3 : i32, i32, i32, i32, i32, i32, i32, i32
    }
    %naf = func.call @finalize(%sc, %rule, %aout, %lp#4, %write) : (i32, i32, i32, i32, i1) -> i32
    %sfb = arith.cmpi ne, %lp#7, %c0 : i32
    %ns1 = func.call @push(%sout, %lp#3, %lp#5, %sy0, %lp#6, %sfb, %write) : (i32, i32, i32, i32, i32, i1, i1) -> i32
    %wnz = arith.cmpi ne, %lp#2, %c0 : i32
    %ns2 = scf.if %wnz -> (i32) {
      %fw2 = func.call @fillp(%lp#2, %rule) : (i32, i32) -> i1
      %n2 = func.call @push(%sout, %ns1, %vw, %sy0, %naf, %fw2, %write) : (i32, i32, i32, i32, i32, i1, i1) -> i32
      scf.yield %n2 : i32
    } else {
      scf.yield %ns1 : i32
    }
    %lastbg = arith.andi %islast, %culled : i1
    %e:3 = scf.if %lastbg -> (i32, i32, i32) {
      %y1 = arith.addi %y, %c1 : i32
      %ys = arith.minsi %y1, %rows : i32
      %bg:3 = func.call @emit_bg(%ys, %rows, %vw, %wb, %rows, %rule, %sout, %ns2, %aout, %naf, %sy0, %write) : (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i1) -> (i32, i32, i32)
      scf.yield %bg#0, %bg#1, %bg#2 : i32, i32, i32
    } else {
      scf.yield %ns2, %naf, %sy0 : i32, i32, i32
    }
    scf.yield %e#0, %e#1, %e#2 : i32, i32, i32
  }
  %c7 = arith.constant 0 : i32
  %any = arith.cmpi sge, %res#2, %c7 : i32
  %sent = arith.andi %islast, %any : i1
  %fs = scf.if %sent -> (i32) {
    %m = arith.constant 65535 : i32
    %s = func.call @push(%sout, %res#0, %m, %res#2, %res#1, %false, %write) : (i32, i32, i32, i32, i32, i1, i1) -> i32
    scf.yield %s : i32
  } else {
    scf.yield %res#0 : i32
  }
  %nal = arith.subi %res#1, %abase : i32
  return %fs, %nal : i32, i32
}
}
}
