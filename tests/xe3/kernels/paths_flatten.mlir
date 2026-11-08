// acgpu's crates/intel/driver/src/paths/flatten.mlir in upstream dialects.
module attributes {gpu.container_module} {
gpu.module @shaders [#xevm.target<chip = "ptl">] {
gpu.func @flatten(%params: i32, %n: i32, %pass: i32) kernel {
  %elems_p1 = llvm.inttoptr %params : i32 to !llvm.ptr<1>
  %elems = llvm.load %elems_p1 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %pa4 = arith.constant 4 : i32
  %pc = arith.addi %params, %pa4 : i32
  %consts_p2 = llvm.inttoptr %pc : i32 to !llvm.ptr<1>
  %consts = llvm.load %consts_p2 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %pn = arith.addi %pc, %pa4 : i32
  %counts_p3 = llvm.inttoptr %pn : i32 to !llvm.ptr<1>
  %counts = llvm.load %counts_p3 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %po = arith.addi %pn, %pa4 : i32
  %offsets_p4 = llvm.inttoptr %po : i32 to !llvm.ptr<1>
  %offsets = llvm.load %offsets_p4 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %pp = arith.addi %po, %pa4 : i32
  %pts_p5 = llvm.inttoptr %pp : i32 to !llvm.ptr<1>
  %pts = llvm.load %pts_p5 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %ps = arith.addi %pp, %pa4 : i32
  %scratch_p6 = llvm.inttoptr %ps : i32 to !llvm.ptr<1>
  %scratch = llvm.load %scratch_p6 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %pl = arith.addi %ps, %pa4 : i32
  %lines_p7 = llvm.inttoptr %pl : i32 to !llvm.ptr<1>
  %lines = llvm.load %lines_p7 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %pz = arith.addi %pl, %pa4 : i32
  %nans_p8 = llvm.inttoptr %pz : i32 to !llvm.ptr<1>
  %nans = llvm.load %nans_p8 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %pe = arith.addi %pz, %pa4 : i32
  %perm_p9 = llvm.inttoptr %pe : i32 to !llvm.ptr<1>
  %perm = llvm.load %perm_p9 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %g_ix10 = gpu.block_id x
  %g = arith.index_cast %g_ix10 : index to i32
  %l_ix11 = gpu.thread_id x
  %l = arith.index_cast %l_ix11 : index to i32
  %c16 = arith.constant 16 : i32
  %base = arith.muli %g, %c16 : i32
  %i = arith.addi %base, %l : i32
  %inside = arith.cmpi slt, %i, %n : i32
  scf.if %inside {
    %c0 = arith.constant 0 : i32
    %c1 = arith.constant 1 : i32
    %c4 = arith.constant 4 : i32
    %c8 = arith.constant 8 : i32
    %c128 = arith.constant 128 : i32
    %c4p = arith.constant 4 : i32
    %pio = arith.muli %i, %c4p : i32
    %pia = arith.addi %perm, %pio : i32
    %ei_p12 = llvm.inttoptr %pia : i32 to !llvm.ptr<1>
    %ei = llvm.load %ei_p12 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %eoff = arith.muli %ei, %c128 : i32
    %e = arith.addi %elems, %eoff : i32
    %kind_p13 = llvm.inttoptr %e : i32 to !llvm.ptr<1>
    %kind = llvm.load %kind_p13 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %q = arith.addi %e, %c8 : i32
    %p0x0 = func.call @f64at(%q, %c0) : (i32, i32) -> f64
    %k1 = arith.constant 1 : i32
    %p0y0 = func.call @f64at(%q, %k1) : (i32, i32) -> f64
    %k2 = arith.constant 2 : i32
    %p1x0 = func.call @f64at(%q, %k2) : (i32, i32) -> f64
    %k3 = arith.constant 3 : i32
    %p1y0 = func.call @f64at(%q, %k3) : (i32, i32) -> f64
    %k4 = arith.constant 4 : i32
    %p2x0 = func.call @f64at(%q, %k4) : (i32, i32) -> f64
    %k5 = arith.constant 5 : i32
    %p2y0 = func.call @f64at(%q, %k5) : (i32, i32) -> f64
    %k6 = arith.constant 6 : i32
    %k7 = arith.constant 7 : i32
    %k9 = arith.constant 9 : i32
    %k10 = arith.constant 10 : i32
    %k11 = arith.constant 11 : i32
    %p3x0 = func.call @f64at(%q, %k6) : (i32, i32) -> f64
    %p3y0 = func.call @f64at(%q, %k7) : (i32, i32) -> f64
    %k12 = arith.constant 12 : i32
    %k13 = arith.constant 13 : i32
    %xa = func.call @f64at(%q, %c8) : (i32, i32) -> f64
    %xb = func.call @f64at(%q, %k9) : (i32, i32) -> f64
    %xc = func.call @f64at(%q, %k10) : (i32, i32) -> f64
    %xd = func.call @f64at(%q, %k11) : (i32, i32) -> f64
    %xe = func.call @f64at(%q, %k12) : (i32, i32) -> f64
    %xf = func.call @f64at(%q, %k13) : (i32, i32) -> f64
    %left = func.call @f64at(%consts, %c0) : (i32, i32) -> f64
    %top = func.call @f64at(%consts, %k1) : (i32, i32) -> f64
    %right = func.call @f64at(%consts, %k2) : (i32, i32) -> f64
    %bottom = func.call @f64at(%consts, %k3) : (i32, i32) -> f64
    %p0:2 = func.call @xf(%xa, %xb, %xc, %xd, %xe, %xf, %p0x0, %p0y0) : (f64, f64, f64, f64, f64, f64, f64, f64) -> (f64, f64)
    %p1:2 = func.call @xf(%xa, %xb, %xc, %xd, %xe, %xf, %p1x0, %p1y0) : (f64, f64, f64, f64, f64, f64, f64, f64) -> (f64, f64)
    %p2:2 = func.call @xf(%xa, %xb, %xc, %xd, %xe, %xf, %p2x0, %p2y0) : (f64, f64, f64, f64, f64, f64, f64, f64) -> (f64, f64)
    %p3:2 = func.call @xf(%xa, %xb, %xc, %xd, %xe, %xf, %p3x0, %p3y0) : (f64, f64, f64, f64, f64, f64, f64, f64) -> (f64, f64)
    %c640 = arith.constant 640 : i32
    %soff = arith.muli %ei, %c640 : i32
    %scr = arith.addi %scratch, %soff : i32
    %isquad = arith.cmpi eq, %kind, %c1 : i32
    %c3k = arith.constant 3 : i32
    %r0 = arith.cmpf ogt, %p0#0, %right : f64
    %r1 = arith.cmpf ogt, %p1#0, %right : f64
    %r2 = arith.cmpf ogt, %p2#0, %right : f64
    %ra = arith.andi %r0, %r1 : i1
    %rr = arith.andi %ra, %r2 : i1
    %t0 = arith.cmpf olt, %p0#1, %top : f64
    %t1 = arith.cmpf olt, %p1#1, %top : f64
    %t2 = arith.cmpf olt, %p2#1, %top : f64
    %ta = arith.andi %t0, %t1 : i1
    %tt = arith.andi %ta, %t2 : i1
    %b0 = arith.cmpf ogt, %p0#1, %bottom : f64
    %b1 = arith.cmpf ogt, %p1#1, %bottom : f64
    %b2 = arith.cmpf ogt, %p2#1, %bottom : f64
    %ba = arith.andi %b0, %b1 : i1
    %bb = arith.andi %ba, %b2 : i1
    %cu0 = arith.ori %rr, %tt : i1
    %culled = arith.ori %cu0, %bb : i1
    %l0 = arith.cmpf olt, %p0#0, %left : f64
    %l1 = arith.cmpf olt, %p1#0, %left : f64
    %l2 = arith.cmpf olt, %p2#0, %left : f64
    %la = arith.andi %l0, %l1 : i1
    %ll = arith.andi %la, %l2 : i1
    %dist = func.call @nearest(%p0#0, %p0#1, %p2#0, %p2#1, %p1#0, %p1#1) : (f64, f64, f64, f64, f64, f64) -> f64
    %tol4 = arith.constant 0.25 : f64
    %near = arith.cmpf ole, %dist, %tol4 : f64
    %straight = arith.ori %ll, %near : i1
    %tru = arith.constant true
    %ncul = arith.xori %culled, %tru : i1
    %nstr = arith.xori %straight, %tru : i1
    %qg0 = arith.andi %isquad, %ncul : i1
    %qgen = arith.andi %qg0, %nstr : i1
    %pass0 = arith.cmpi eq, %pass, %c0 : i32
    %zf = arith.constant 0.0 : f64
    %sp:5 = scf.if %qgen -> (f64, f64, f64, f64, f64) {
      %r:5 = scf.if %pass0 -> (f64, f64, f64, f64, f64) {
        %v:5 = func.call @subdiv(%p0#0, %p0#1, %p1#0, %p1#1, %p2#0, %p2#1) : (f64, f64, f64, f64, f64, f64) -> (f64, f64, f64, f64, f64)
        %s1 = arith.addi %scr, %c8 : i32
        %c16s = arith.constant 16 : i32
        %s2 = arith.addi %scr, %c16s : i32
        %c24s = arith.constant 24 : i32
        %s3 = arith.addi %scr, %c24s : i32
        %c32s = arith.constant 32 : i32
        %s4 = arith.addi %scr, %c32s : i32
        %st_p14 = llvm.inttoptr %scr : i32 to !llvm.ptr<1>
        llvm.store %v#0, %st_p14 {alignment = 8 : i64} : f64, !llvm.ptr<1>
        %st_p15 = llvm.inttoptr %s1 : i32 to !llvm.ptr<1>
        llvm.store %v#1, %st_p15 {alignment = 8 : i64} : f64, !llvm.ptr<1>
        %st_p16 = llvm.inttoptr %s2 : i32 to !llvm.ptr<1>
        llvm.store %v#2, %st_p16 {alignment = 8 : i64} : f64, !llvm.ptr<1>
        %st_p17 = llvm.inttoptr %s3 : i32 to !llvm.ptr<1>
        llvm.store %v#3, %st_p17 {alignment = 8 : i64} : f64, !llvm.ptr<1>
        %st_p18 = llvm.inttoptr %s4 : i32 to !llvm.ptr<1>
        llvm.store %v#4, %st_p18 {alignment = 8 : i64} : f64, !llvm.ptr<1>
        scf.yield %v#0, %v#1, %v#2, %v#3, %v#4 : f64, f64, f64, f64, f64
      } else {
        %v0 = func.call @f64at(%scr, %c0) : (i32, i32) -> f64
        %v1 = func.call @f64at(%scr, %k1) : (i32, i32) -> f64
        %v2 = func.call @f64at(%scr, %k2) : (i32, i32) -> f64
        %v3 = func.call @f64at(%scr, %k3) : (i32, i32) -> f64
        %v4 = func.call @f64at(%scr, %k4) : (i32, i32) -> f64
        scf.yield %v0, %v1, %v2, %v3, %v4 : f64, f64, f64, f64, f64
      }
      scf.yield %r#0, %r#1, %r#2, %r#3, %r#4 : f64, f64, f64, f64, f64
    } else {
      scf.yield %zf, %zf, %zf, %zf, %zf : f64, f64, f64, f64, f64
    }
    %one = arith.constant 1.0 : f64
    %up = math.ceil %sp#4 : f64
    %big = arith.constant 1048576.0 : f64
    %capped = arith.minnumf %up, %big : f64
    %ge1 = arith.cmpf oge, %up, %one : f64
    %nf = arith.select %ge1, %capped, %one : f64
    %nq = arith.fptosi %nf : f64 to i32
    %cs = arith.select %straight, %c1, %nq : i32
    %cm1 = arith.constant -1 : i32
    %cq = arith.select %culled, %cm1, %cs : i32
    %iscubic = arith.cmpi eq, %kind, %k2 : i32
    %r3 = arith.cmpf ogt, %p3#0, %right : f64
    %rc = arith.andi %rr, %r3 : i1
    %t3 = arith.cmpf olt, %p3#1, %top : f64
    %tc = arith.andi %tt, %t3 : i1
    %b3 = arith.cmpf ogt, %p3#1, %bottom : f64
    %bc = arith.andi %bb, %b3 : i1
    %cc0 = arith.ori %rc, %tc : i1
    %cculled = arith.ori %cc0, %bc : i1
    %l3 = arith.cmpf olt, %p3#0, %left : f64
    %lc = arith.andi %ll, %l3 : i1
    %dist1 = func.call @nearest(%p0#0, %p0#1, %p3#0, %p3#1, %p1#0, %p1#1) : (f64, f64, f64, f64, f64, f64) -> f64
    %dist2 = func.call @nearest(%p0#0, %p0#1, %p3#0, %p3#1, %p2#0, %p2#1) : (f64, f64, f64, f64, f64, f64) -> f64
    %dmax = arith.maxnumf %dist1, %dist2 : f64
    %k169 = arith.constant 0x3FBC71C71C71C71C : f64
    %cnear = arith.cmpf ole, %dmax, %k169 : f64
    %cstraight = arith.ori %lc, %cnear : i1
    %ncc = arith.xori %cculled, %tru : i1
    %ncs = arith.xori %cstraight, %tru : i1
    %cg0 = arith.andi %iscubic, %ncc : i1
    %cgen0 = arith.andi %cg0, %ncs : i1
    %z32 = arith.constant 0.0 : f32
    %c608 = arith.constant 608 : i32
    %sr = arith.addi %scr, %c608 : i32
    %cp:4 = scf.if %cgen0 -> (i32, i32, f32, f32) {
      %r:4 = scf.if %pass0 -> (i32, i32, f32, f32) {
        %v:4 = func.call @cubic_prep(%p0#0, %p0#1, %p1#0, %p1#1, %p2#0, %p2#1, %p3#0, %p3#1, %scr) : (f64, f64, f64, f64, f64, f64, f64, f64, i32) -> (i32, i32, f32, f32)
        %b2_s1 = arith.bitcast %v#2 : f32 to i32
        %b3_s1 = arith.bitcast %v#3 : f32 to i32
        %vv = vector.from_elements %v#0, %v#1, %b2_s1, %b3_s1 : vector<4xi32>
        %st_p19 = llvm.inttoptr %sr : i32 to !llvm.ptr<1>
        llvm.store %vv, %st_p19 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr<1>
        scf.yield %v#0, %v#1, %v#2, %v#3 : i32, i32, f32, f32
      } else {
        %vv_p20 = llvm.inttoptr %sr : i32 to !llvm.ptr<1>
        %vv = llvm.load %vv_p20 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xi32>
        %e0 = vector.extract %vv[0] : i32 from vector<4xi32>
        %e1 = vector.extract %vv[1] : i32 from vector<4xi32>
        %e2 = vector.extract %vv[2] : i32 from vector<4xi32>
        %e3 = vector.extract %vv[3] : i32 from vector<4xi32>
        %f2 = arith.bitcast %e2 : i32 to f32
        %f3 = arith.bitcast %e3 : i32 to f32
        scf.yield %e0, %e1, %f2, %f3 : i32, i32, f32, f32
      }
      scf.yield %r#0, %r#1, %r#2, %r#3 : i32, i32, f32, f32
    } else {
      scf.yield %c0, %c0, %z32, %z32 : i32, i32, f32, f32
    }
    %ccs = arith.select %cstraight, %c1, %cp#1 : i32
    %ccq = arith.select %cculled, %cm1, %ccs : i32
    %cnt0 = arith.select %isquad, %cq, %c1 : i32
    %cnt1 = arith.select %iscubic, %ccq, %cnt0 : i32
    %isclose = arith.cmpi eq, %kind, %c3k : i32
    %ux = arith.cmpf une, %p0#0, %p1#0 : f64
    %uy = arith.cmpf une, %p0#1, %p1#1 : f64
    %back = arith.ori %ux, %uy : i1
    %cl1 = arith.select %back, %c1, %c0 : i32
    %count = arith.select %isclose, %cl1, %cnt1 : i32
    %first = arith.cmpi eq, %pass, %c0 : i32
    scf.if %first {
      %co = arith.muli %ei, %c4 : i32
      %ca = arith.addi %counts, %co : i32
      %st_p21 = llvm.inttoptr %ca : i32 to !llvm.ptr<1>
      llvm.store %count, %st_p21 {alignment = 4 : i64} : i32, !llvm.ptr<1>
    } else {
      %oo = arith.muli %ei, %c4 : i32
      %oa = arith.addi %offsets, %oo : i32
      %at_p22 = llvm.inttoptr %oa : i32 to !llvm.ptr<1>
      %at = llvm.load %at_p22 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
      %nd = arith.sitofp %count : i32 to f64
      %step = arith.divf %one, %nd : f64
      %lim = arith.select %isquad, %count, %c1 : i32
      scf.for %j = %c1 to %lim step %c1 : i32 {
        %jd = arith.sitofp %j : i32 to f64
        %u = arith.mulf %jd, %step : f64
        %da = arith.subf %sp#1, %sp#0 : f64
        %dax = arith.mulf %da, %u : f64
        %aa = arith.addf %sp#0, %dax : f64
        %uu = func.call @apii(%aa) : (f64) -> f64
        %du = arith.subf %uu, %sp#2 : f64
        %t = arith.mulf %du, %sp#3 : f64
        %ev:2 = func.call @eval(%p0#0, %p0#1, %p1#0, %p1#1, %p2#0, %p2#1, %t) : (f64, f64, f64, f64, f64, f64, f64) -> (f64, f64)
        %jm = arith.subi %j, %c1 : i32
        %k = arith.addi %at, %jm : i32
        func.call @put(%pts, %k, %ev#0, %ev#1) : (i32, i32, f64, f64) -> ()
      }
      %general = arith.cmpi sgt, %count, %c1 : i32
      %cgen = arith.andi %iscubic, %general : i1
      scf.if %cgen {
        func.call @cubic_emit(%scr, %cp#0, %cp#1, %cp#2, %cp#3, %pts, %at) : (i32, i32, i32, f32, f32, i32, i32) -> ()
      }
      %lx0 = arith.select %isquad, %p2#0, %p1#0 : f64
      %ly0 = arith.select %isquad, %p2#1, %p1#1 : f64
      %lastx = arith.select %iscubic, %p3#0, %lx0 : f64
      %lasty = arith.select %iscubic, %p3#1, %ly0 : f64
      %some = arith.cmpi sgt, %count, %c0 : i32
      scf.if %some {
        %cl = arith.subi %count, %c1 : i32
        %k = arith.addi %at, %cl : i32
        func.call @put(%pts, %k, %lastx, %lasty) : (i32, i32, f64, f64) -> ()
      }
      %sx = arith.truncf %p0#0 : f64 to f32
      %sy = arith.truncf %p0#1 : f64 to f32
      %lim2 = arith.maxsi %count, %c0 : i32
      %lr:3 = scf.for %q2 = %c0 to %lim2 step %c1 iter_args(%px = %sx, %py = %sy, %bad = %c0) -> (f32, f32, i32) : i32 {
        %kq = arith.addi %at, %q2 : i32
        %c8q = arith.constant 8 : i32
        %pq = arith.muli %kq, %c8q : i32
        %pa = arith.addi %pts, %pq : i32
        %pt_p23 = llvm.inttoptr %pa : i32 to !llvm.ptr<1>
        %pt = llvm.load %pt_p23 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<2xf32>
        %qx = vector.extract %pt[0] : f32 from vector<2xf32>
        %qy = vector.extract %pt[1] : f32 from vector<2xf32>
        %c16l = arith.constant 16 : i32
        %lq = arith.muli %kq, %c16l : i32
        %la_s1 = arith.addi %lines, %lq : i32
        %lv = vector.from_elements %px, %py, %qx, %qy : vector<4xf32>
        %st_p24 = llvm.inttoptr %la_s1 : i32 to !llvm.ptr<1>
        llvm.store %lv, %st_p24 {alignment = 4 : i64} : vector<4xf32>, !llvm.ptr<1>
        %nx = arith.cmpf une, %qx, %qx : f32
        %ny = arith.cmpf une, %qy, %qy : f32
        %nxy = arith.ori %nx, %ny : i1
        %ni = arith.extui %nxy : i1 to i32
        %bad2 = arith.ori %bad, %ni : i32
        scf.yield %qx, %qy, %bad2 : f32, f32, i32
      }
      %ex0 = arith.cmpf une, %lastx, %lastx : f64
      %ey0 = arith.cmpf une, %lasty, %lasty : f64
      %eany = arith.ori %ex0, %ey0 : i1
      %gone = arith.cmpi slt, %count, %c0 : i32
      %ebad = arith.andi %eany, %gone : i1
      %ebi = arith.extui %ebad : i1 to i32
      %nanv = arith.ori %lr#2, %ebi : i32
      %zo = arith.muli %ei, %c4 : i32
      %za = arith.addi %nans, %zo : i32
      %st_p25 = llvm.inttoptr %za : i32 to !llvm.ptr<1>
      llvm.store %nanv, %st_p25 {alignment = 4 : i64} : i32, !llvm.ptr<1>
    }
  }
  gpu.return
}
func.func private @f64at(%a: i32, %k: i32) -> f64 {
  %c8 = arith.constant 8 : i32
  %o = arith.muli %k, %c8 : i32
  %at = arith.addi %a, %o : i32
  %v_p26 = llvm.inttoptr %at : i32 to !llvm.ptr<1>
  %v = llvm.load %v_p26 {alignment = 8 : i64} : !llvm.ptr<1> -> f64
  return %v : f64
}
func.func private @xf(%a: f64, %b: f64, %c: f64, %d: f64, %e: f64, %f: f64, %x: f64, %y: f64) -> (f64, f64) {
  %ax = arith.mulf %a, %x : f64
  %cy = arith.mulf %c, %y : f64
  %s0 = arith.addf %ax, %cy : f64
  %x2 = arith.addf %s0, %e : f64
  %bx = arith.mulf %b, %x : f64
  %dy = arith.mulf %d, %y : f64
  %s1 = arith.addf %bx, %dy : f64
  %y2 = arith.addf %s1, %f : f64
  return %x2, %y2 : f64, f64
}
func.func private @nearest(%ax: f64, %ay: f64, %bx: f64, %by: f64, %px: f64, %py: f64) -> f64 {
  %dx = arith.subf %bx, %ax : f64
  %dy = arith.subf %by, %ay : f64
  %vx = arith.subf %px, %ax : f64
  %vy = arith.subf %py, %ay : f64
  %d0 = arith.mulf %dx, %vx : f64
  %d1 = arith.mulf %dy, %vy : f64
  %dot = arith.addf %d0, %d1 : f64
  %h0 = arith.mulf %dx, %dx : f64
  %h1 = arith.mulf %dy, %dy : f64
  %h = arith.addf %h0, %h1 : f64
  %t0 = arith.divf %dot, %h : f64
  %zero = arith.constant 0.0 : f64
  %one = arith.constant 1.0 : f64
  %t1 = arith.maxnumf %t0, %zero : f64
  %t = arith.minnumf %t1, %one : f64
  %tdx = arith.mulf %t, %dx : f64
  %tdy = arith.mulf %t, %dy : f64
  %wx = arith.subf %vx, %tdx : f64
  %wy = arith.subf %vy, %tdy : f64
  %w0 = arith.mulf %wx, %wx : f64
  %w1 = arith.mulf %wy, %wy : f64
  %w = arith.addf %w0, %w1 : f64
  return %w : f64
}
func.func private @api(%x: f64) -> f64 {
  %q = arith.constant 0.25 : f64
  %d4 = arith.constant 0x3FC9CB1E8C5D1B10 : f64
  %omd = arith.constant 0x3FD51EB851EB851E : f64
  %qx = arith.mulf %q, %x : f64
  %qxx = arith.mulf %qx, %x : f64
  %s = arith.addf %d4, %qxx : f64
  %r = math.sqrt %s : f64
  %rr = math.sqrt %r : f64
  %den = arith.addf %omd, %rr : f64
  %v = arith.divf %x, %den : f64
  return %v : f64
}
func.func private @apii(%x: f64) -> f64 {
  %q = arith.constant 0.25 : f64
  %b2 = arith.constant 0x3FC3780346DC5D64 : f64
  %omb = arith.constant 0x3FE3851EB851EB85 : f64
  %qx = arith.mulf %q, %x : f64
  %qxx = arith.mulf %qx, %x : f64
  %s = arith.addf %b2, %qxx : f64
  %r = math.sqrt %s : f64
  %f = arith.addf %omb, %r : f64
  %v = arith.mulf %x, %f : f64
  return %v : f64
}
func.func private @subdiv(%p0x: f64, %p0y: f64, %p1x: f64, %p1y: f64, %p2x: f64, %p2y: f64) -> (f64, f64, f64, f64, f64) {
  %d01x = arith.subf %p1x, %p0x : f64
  %d01y = arith.subf %p1y, %p0y : f64
  %d12x = arith.subf %p2x, %p1x : f64
  %d12y = arith.subf %p2y, %p1y : f64
  %ddx = arith.subf %d01x, %d12x : f64
  %ddy = arith.subf %d01y, %d12y : f64
  %d02x = arith.subf %p2x, %p0x : f64
  %d02y = arith.subf %p2y, %p0y : f64
  %c0 = arith.mulf %d02x, %ddy : f64
  %c1 = arith.mulf %d02y, %ddx : f64
  %cross = arith.subf %c0, %c1 : f64
  %one = arith.constant 1.0 : f64
  %rc = arith.divf %one, %cross : f64
  %o0 = arith.mulf %d01x, %ddx : f64
  %o1 = arith.mulf %d01y, %ddy : f64
  %dot0 = arith.addf %o0, %o1 : f64
  %x0 = arith.mulf %dot0, %rc : f64
  %o2 = arith.mulf %d12x, %ddx : f64
  %o3 = arith.mulf %d12y, %ddy : f64
  %dot2 = arith.addf %o2, %o3 : f64
  %x2 = arith.mulf %dot2, %rc : f64
  %h0 = arith.mulf %ddx, %ddx : f64
  %h1 = arith.mulf %ddy, %ddy : f64
  %h2 = arith.addf %h0, %h1 : f64
  %hyp = math.sqrt %h2 : f64
  %dx = arith.subf %x2, %x0 : f64
  %den = arith.mulf %hyp, %dx : f64
  %sq = arith.divf %cross, %den : f64
  %scale = math.absf %sq : f64
  %a0 = func.call @api(%x0) : (f64) -> f64
  %a2 = func.call @api(%x2) : (f64) -> f64
  %inf = arith.constant 0x7FF0000000000000 : f64
  %fin = arith.cmpf olt, %scale, %inf : f64
  %da0 = arith.subf %a2, %a0 : f64
  %da = math.absf %da0 : f64
  %ss = math.sqrt %scale : f64
  %s0 = func.call @signum(%x0) : (f64) -> f64
  %s2 = func.call @signum(%x2) : (f64) -> f64
  %same = arith.cmpf oeq, %s0, %s2 : f64
  %noncusp = arith.mulf %da, %ss : f64
  %tol = arith.constant 0.5 : f64
  %xmin = arith.divf %tol, %ss : f64
  %ai = func.call @api(%xmin) : (f64) -> f64
  %td = arith.mulf %tol, %da : f64
  %cusp = arith.divf %td, %ai : f64
  %v0 = arith.select %same, %noncusp, %cusp : f64
  %zero = arith.constant 0.0 : f64
  %val = arith.select %fin, %v0, %zero : f64
  %u0 = func.call @apii(%a0) : (f64) -> f64
  %u2 = func.call @apii(%a2) : (f64) -> f64
  %du = arith.subf %u2, %u0 : f64
  %us = arith.divf %one, %du : f64
  return %a0, %a2, %u0, %us, %val : f64, f64, f64, f64, f64
}
func.func private @signum(%x: f64) -> f64 {
  %one = arith.constant 1.0 : f64
  %m = arith.constant -1.0 : f64
  %neg = func.call @negative(%x) : (f64) -> i1
  %s = arith.select %neg, %m, %one : f64
  %nan = arith.cmpf une, %x, %x : f64
  %v = arith.select %nan, %x, %s : f64
  return %v : f64
}
func.func private @negative(%x: f64) -> i1 {
  %z = arith.constant 0.0 : f64
  %one = arith.constant 1.0 : f64
  %lt = arith.cmpf olt, %x, %z : f64
  %eq = arith.cmpf oeq, %x, %z : f64
  %r = arith.divf %one, %x : f64
  %rn = arith.cmpf olt, %r, %z : f64
  %mz = arith.andi %eq, %rn : i1
  %n = arith.ori %lt, %mz : i1
  return %n : i1
}
func.func private @eval(%p0x: f64, %p0y: f64, %p1x: f64, %p1y: f64, %p2x: f64, %p2y: f64, %t: f64) -> (f64, f64) {
  %one = arith.constant 1.0 : f64
  %two = arith.constant 2.0 : f64
  %mt = arith.subf %one, %t : f64
  %mt2 = arith.mulf %mt, %mt : f64
  %m2 = arith.mulf %mt, %two : f64
  %ax = arith.mulf %p0x, %mt2 : f64
  %ay = arith.mulf %p0y, %mt2 : f64
  %bx = arith.mulf %p1x, %m2 : f64
  %by = arith.mulf %p1y, %m2 : f64
  %cx = arith.mulf %p2x, %t : f64
  %cy = arith.mulf %p2y, %t : f64
  %bcx = arith.addf %bx, %cx : f64
  %bcy = arith.addf %by, %cy : f64
  %tx = arith.mulf %bcx, %t : f64
  %ty = arith.mulf %bcy, %t : f64
  %x = arith.addf %ax, %tx : f64
  %y = arith.addf %ay, %ty : f64
  return %x, %y : f64, f64
}
func.func private @put(%pts: i32, %k: i32, %x: f64, %y: f64) {
  %c8 = arith.constant 8 : i32
  %o = arith.muli %k, %c8 : i32
  %at = arith.addi %pts, %o : i32
  %fx = arith.truncf %x : f64 to f32
  %fy = arith.truncf %y : f64 to f32
  %v = vector.from_elements %fx, %fy : vector<2xf32>
  %st_p27 = llvm.inttoptr %at : i32 to !llvm.ptr<1>
  llvm.store %v, %st_p27 {alignment = 4 : i64} : vector<2xf32>, !llvm.ptr<1>
  return
}
func.func private @sget(%s: i32, %k: i32) -> f32 {
  %c4 = arith.constant 4 : i32
  %o = arith.muli %k, %c4 : i32
  %at = arith.addi %s, %o : i32
  %v_p28 = llvm.inttoptr %at : i32 to !llvm.ptr<1>
  %v = llvm.load %v_p28 {alignment = 4 : i64} : !llvm.ptr<1> -> f32
  return %v : f32
}
func.func private @sput(%s: i32, %k: i32, %v: f32) {
  %c4 = arith.constant 4 : i32
  %o = arith.muli %k, %c4 : i32
  %at = arith.addi %s, %o : i32
  %st_p29 = llvm.inttoptr %at : i32 to !llvm.ptr<1>
  llvm.store %v, %st_p29 {alignment = 4 : i64} : f32, !llvm.ptr<1>
  return
}
func.func private @pput(%s: i32, %base: i32, %k: i32, %x: f32, %y: f32) {
  %c2 = arith.constant 2 : i32
  %c1 = arith.constant 1 : i32
  %k2 = arith.muli %k, %c2 : i32
  %ix = arith.addi %base, %k2 : i32
  %iy = arith.addi %ix, %c1 : i32
  func.call @sput(%s, %ix, %x) : (i32, i32, f32) -> ()
  func.call @sput(%s, %iy, %y) : (i32, i32, f32) -> ()
  return
}
func.func private @pget(%s: i32, %base: i32, %k: i32) -> (f32, f32) {
  %c2 = arith.constant 2 : i32
  %c1 = arith.constant 1 : i32
  %k2 = arith.muli %k, %c2 : i32
  %ix = arith.addi %base, %k2 : i32
  %iy = arith.addi %ix, %c1 : i32
  %x = func.call @sget(%s, %ix) : (i32, i32) -> f32
  %y = func.call @sget(%s, %iy) : (i32, i32) -> f32
  return %x, %y : f32, f32
}
func.func private @api32(%x: f32) -> f32 {
  %q = arith.constant 0.25 : f32
  %d4 = arith.constant 0x3E4E58F4 : f32
  %omd = arith.constant 0x3EA8F5C2 : f32
  %xx = arith.mulf %x, %x : f32
  %s = math.fma %q, %xx, %d4 : f32
  %r = math.sqrt %s : f32
  %rr = math.sqrt %r : f32
  %den = arith.addf %rr, %omd : f32
  %v = arith.divf %x, %den : f32
  return %v : f32
}
func.func private @apii32(%x: f32) -> f32 {
  %q = arith.constant 0.25 : f32
  %bb = arith.constant 0x3E1BC019 : f32
  %omb = arith.constant 0x3F1C28F6 : f32
  %xx = arith.mulf %x, %x : f32
  %s = math.fma %q, %xx, %bb : f32
  %r = math.sqrt %s : f32
  %f = arith.addf %omb, %r : f32
  %v = arith.mulf %x, %f : f32
  return %v : f32
}
func.func private @horner(%a: f32, %b: f32, %c: f32, %d: f32, %t: f32) -> f32 {
  %h0 = math.fma %a, %t, %b : f32
  %h1 = math.fma %h0, %t, %c : f32
  %h2 = math.fma %h1, %t, %d : f32
  return %h2 : f32
}
func.func private @coeffs(%p0: f32, %p1: f32, %p2: f32, %p3: f32) -> (f32, f32, f32) {
  %three = arith.constant 3.0 : f32
  %m2 = arith.constant -2.0 : f32
  %d12 = arith.subf %p1, %p2 : f32
  %d30 = arith.subf %p3, %p0 : f32
  %a = math.fma %d12, %three, %d30 : f32
  %s02 = arith.addf %p0, %p2 : f32
  %b0 = math.fma %p1, %m2, %s02 : f32
  %b = arith.mulf %b0, %three : f32
  %d10 = arith.subf %p1, %p0 : f32
  %c = arith.mulf %d10, %three : f32
  return %a, %b, %c : f32, f32, f32
}
func.func private @cubic_prep(%p0x: f64, %p0y: f64, %p1x: f64, %p1y: f64, %p2x: f64, %p2y: f64, %p3x: f64, %p3y: f64, %s: i32) -> (i32, i32, f32, f32) {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c2 = arith.constant 2 : i32
  %three64 = arith.constant 3.0 : f64
  %a1x = arith.mulf %p1x, %three64 : f64
  %q1x = arith.subf %a1x, %p0x : f64
  %a1y = arith.mulf %p1y, %three64 : f64
  %q1y = arith.subf %a1y, %p0y : f64
  %a2x = arith.mulf %p2x, %three64 : f64
  %q2x = arith.subf %a2x, %p3x : f64
  %a2y = arith.mulf %p2y, %three64 : f64
  %q2y = arith.subf %a2y, %p3y : f64
  %ex = arith.subf %q2x, %q1x : f64
  %ey = arith.subf %q2y, %q1y : f64
  %exx = arith.mulf %ex, %ex : f64
  %eyy = arith.mulf %ey, %ey : f64
  %err = arith.addf %exx, %eyy : f64
  %mh = arith.constant 0x3FD147AE1D1EB853 : f64
  %ed = arith.divf %err, %mh : f64
  %nq0 = func.call @estimate(%ed) : (f64) -> i32
  %c16q = arith.constant 16 : i32
  %nq = arith.minsi %nq0, %c16q : i32
  %x0 = arith.truncf %p0x : f64 to f32
  %y0 = arith.truncf %p0y : f64 to f32
  %x1 = arith.truncf %p1x : f64 to f32
  %y1 = arith.truncf %p1y : f64 to f32
  %x2 = arith.truncf %p2x : f64 to f32
  %y2 = arith.truncf %p2y : f64 to f32
  %x3 = arith.truncf %p3x : f64 to f32
  %y3 = arith.truncf %p3y : f64 to f32
  %cx:3 = func.call @coeffs(%x0, %x1, %x2, %x3) : (f32, f32, f32, f32) -> (f32, f32, f32)
  %cy:3 = func.call @coeffs(%y0, %y1, %y2, %y3) : (f32, f32, f32, f32) -> (f32, f32, f32)
  %half = arith.constant 0.5 : f32
  %nqf = arith.sitofp %nq : i32 to f32
  %dt = arith.divf %half, %nqf : f32
  %f0 = arith.constant 0.0 : f32
  %f1 = arith.constant 1.0 : f32
  %f2 = arith.constant 2.0 : f32
  %f3 = arith.constant 3.0 : f32
  %f4 = arith.constant 4.0 : f32
  %te0 = arith.mulf %f0, %dt : f32
  %te1 = arith.mulf %f2, %dt : f32
  %to0 = arith.mulf %f1, %dt : f32
  %to1 = arith.mulf %f3, %dt : f32
  %tinc = arith.mulf %f4, %dt : f32
  %halves0 = arith.addi %nq, %c1 : i32
  %halves = arith.shrui %halves0, %c1 : i32
  %odd = arith.constant 40 : i32
  %ts:4 = scf.for %i = %c0 to %halves step %c1 iter_args(%e0 = %te0, %e1 = %te1, %o0 = %to0, %o1 = %to1) -> (f32, f32, f32, f32) : i32 {
    %k0 = arith.muli %i, %c2 : i32
    %k1 = arith.addi %k0, %c1 : i32
    %ve0x = func.call @horner(%cx#0, %cx#1, %cx#2, %x0, %e0) : (f32, f32, f32, f32, f32) -> f32
    %ve0y = func.call @horner(%cy#0, %cy#1, %cy#2, %y0, %e0) : (f32, f32, f32, f32, f32) -> f32
    func.call @pput(%s, %c0, %k0, %ve0x, %ve0y) : (i32, i32, i32, f32, f32) -> ()
    %ve1x = func.call @horner(%cx#0, %cx#1, %cx#2, %x0, %e1) : (f32, f32, f32, f32, f32) -> f32
    %ve1y = func.call @horner(%cy#0, %cy#1, %cy#2, %y0, %e1) : (f32, f32, f32, f32, f32) -> f32
    func.call @pput(%s, %c0, %k1, %ve1x, %ve1y) : (i32, i32, i32, f32, f32) -> ()
    %vo0x = func.call @horner(%cx#0, %cx#1, %cx#2, %x0, %o0) : (f32, f32, f32, f32, f32) -> f32
    %vo0y = func.call @horner(%cy#0, %cy#1, %cy#2, %y0, %o0) : (f32, f32, f32, f32, f32) -> f32
    func.call @pput(%s, %odd, %k0, %vo0x, %vo0y) : (i32, i32, i32, f32, f32) -> ()
    %vo1x = func.call @horner(%cx#0, %cx#1, %cx#2, %x0, %o1) : (f32, f32, f32, f32, f32) -> f32
    %vo1y = func.call @horner(%cy#0, %cy#1, %cy#2, %y0, %o1) : (f32, f32, f32, f32, f32) -> f32
    func.call @pput(%s, %odd, %k1, %vo1x, %vo1y) : (i32, i32, i32, f32, f32) -> ()
    %n0 = arith.addf %e0, %tinc : f32
    %n1 = arith.addf %e1, %tinc : f32
    %n2 = arith.addf %o0, %tinc : f32
    %n3 = arith.addf %o1, %tinc : f32
    scf.yield %n0, %n1, %n2, %n3 : f32, f32, f32, f32
  }
  func.call @pput(%s, %c0, %nq, %x3, %y3) : (i32, i32, i32, f32, f32) -> ()
  %st = arith.constant 0x3EF2DCE8 : f32
  %mhalf = arith.constant -0.5 : f32
  %sum = scf.for %k = %c0 to %nq step %c1 iter_args(%acc = %f0) -> (f32) : i32 {
    %kn = arith.addi %k, %c1 : i32
    %q0:2 = func.call @pget(%s, %c0, %k) : (i32, i32, i32) -> (f32, f32)
    %qh:2 = func.call @pget(%s, %odd, %k) : (i32, i32, i32) -> (f32, f32)
    %q2:2 = func.call @pget(%s, %c0, %kn) : (i32, i32, i32) -> (f32, f32)
    %hx = arith.mulf %q0#0, %mhalf : f32
    %hy = arith.mulf %q0#1, %mhalf : f32
    %h1x = math.fma %qh#0, %f2, %hx : f32
    %h1y = math.fma %qh#1, %f2, %hy : f32
    %q1x_s1 = math.fma %q2#0, %mhalf, %h1x : f32
    %q1y_s1 = math.fma %q2#1, %mhalf, %h1y : f32
    func.call @pput(%s, %odd, %k, %q1x_s1, %q1y_s1) : (i32, i32, i32, f32, f32) -> ()
    %d01x = arith.subf %q1x_s1, %q0#0 : f32
    %d01y = arith.subf %q1y_s1, %q0#1 : f32
    %d12x = arith.subf %q2#0, %q1x_s1 : f32
    %d12y = arith.subf %q2#1, %q1y_s1 : f32
    %ddx = arith.subf %d01x, %d12x : f32
    %ddy = arith.subf %d01y, %d12y : f32
    %d02x = arith.addf %d01x, %d12x : f32
    %d02y = arith.addf %d01y, %d12y : f32
    %nd02y = arith.negf %d02y : f32
    %xdy = arith.mulf %d02x, %ddy : f32
    %cross = math.fma %ddx, %nd02y, %xdy : f32
    %n0a = arith.mulf %d12x, %ddx : f32
    %n0 = math.fma %d12y, %ddy, %n0a : f32
    %n2a = arith.mulf %d01x, %ddx : f32
    %n2 = math.fma %d01y, %ddy, %n2a : f32
    %xa = arith.divf %n0, %cross : f32
    %xb = arith.divf %n2, %cross : f32
    %hh0 = arith.mulf %ddx, %ddx : f32
    %hh = math.fma %ddy, %ddy, %hh0 : f32
    %hyp = math.sqrt %hh : f32
    %dxb = arith.subf %xb, %xa : f32
    %sden = arith.mulf %hyp, %dxb : f32
    %sq = arith.divf %cross, %sden : f32
    %scale = math.absf %sq : f32
    %a0 = func.call @api32(%xa) : (f32) -> f32
    %a2 = func.call @api32(%xb) : (f32) -> f32
    %da = arith.subf %a2, %a0 : f32
    %dab = math.absf %da : f32
    %ss = math.sqrt %scale : f32
    %bxa = arith.bitcast %xa : f32 to i32
    %bxb = arith.bitcast %xb : f32 to i32
    %bor = arith.ori %bxa, %bxb : i32
    %pos = arith.cmpi sge, %bor, %c0 : i32
    %noncusp = arith.mulf %dab, %ss : f32
    %xmin = arith.divf %st, %ss : f32
    %ai = func.call @api32(%xmin) : (f32) -> f32
    %tda = arith.mulf %st, %dab : f32
    %cusp = arith.divf %tda, %ai : f32
    %vr = arith.select %pos, %noncusp, %cusp : f32
    %vabs = math.absf %vr : f32
    %vbits = arith.bitcast %vabs : f32 to i32
    %infb = arith.constant 0x7f800000 : i32
    %fin = arith.cmpi ult, %vbits, %infb : i32
    %val = arith.select %fin, %vr, %f0 : f32
    %u0 = func.call @apii32(%a0) : (f32) -> f32
    %u2 = func.call @apii32(%a2) : (f32) -> f32
    %du = arith.subf %u2, %u0 : f32
    %us = arith.divf %f1, %du : f32
    %i72 = arith.constant 72 : i32
    %i88 = arith.constant 88 : i32
    %i104 = arith.constant 104 : i32
    %i120 = arith.constant 120 : i32
    %i136 = arith.constant 136 : i32
    %ka0 = arith.addi %i72, %k : i32
    %kda = arith.addi %i88, %k : i32
    %ku0 = arith.addi %i104, %k : i32
    %kus = arith.addi %i120, %k : i32
    %kv = arith.addi %i136, %k : i32
    func.call @sput(%s, %ka0, %a0) : (i32, i32, f32) -> ()
    func.call @sput(%s, %kda, %da) : (i32, i32, f32) -> ()
    func.call @sput(%s, %ku0, %u0) : (i32, i32, f32) -> ()
    func.call @sput(%s, %kus, %us) : (i32, i32, f32) -> ()
    func.call @sput(%s, %kv, %val) : (i32, i32, f32) -> ()
    %acc2 = arith.addf %acc, %val : f32
    scf.yield %acc2 : f32
  }
  %hs = arith.mulf %half, %sum : f32
  %nr = arith.divf %hs, %st : f32
  %nc = math.ceil %nr : f32
  %cap = arith.constant 1048576.0 : f32
  %ncap = arith.minnumf %nc, %cap : f32
  %ge1 = arith.cmpf oge, %nc, %f1 : f32
  %nff = arith.select %ge1, %ncap, %f1 : f32
  %nn = arith.fptosi %nff : f32 to i32
  %nnf = arith.sitofp %nn : i32 to f32
  %step = arith.divf %sum, %nnf : f32
  %srecip = arith.divf %f1, %step : f32
  return %nq, %nn, %step, %srecip : i32, i32, f32, f32
}
func.func private @estimate(%e: f64) -> i32 {
  %c1 = arith.constant 1 : i32
  %l0 = arith.constant 1.0 : f64
  %l1 = arith.constant 64.0 : f64
  %l2 = arith.constant 729.0 : f64
  %l3 = arith.constant 4096.0 : f64
  %l4 = arith.constant 15625.0 : f64
  %l5 = arith.constant 46656.0 : f64
  %l6 = arith.constant 117649.0 : f64
  %l7 = arith.constant 262144.0 : f64
  %l8 = arith.constant 531441.0 : f64
  %l9 = arith.constant 1000000.0 : f64
  %l10 = arith.constant 1771561.0 : f64
  %l11 = arith.constant 2985984.0 : f64
  %l12 = arith.constant 4826809.0 : f64
  %l13 = arith.constant 7529536.0 : f64
  %l14 = arith.constant 11390625.0 : f64
  %l15 = arith.constant 16777216.0 : f64
  %w0 = func.call @past(%e, %l0) : (f64, f64) -> i32
  %w1 = func.call @past(%e, %l1) : (f64, f64) -> i32
  %w2 = func.call @past(%e, %l2) : (f64, f64) -> i32
  %w3 = func.call @past(%e, %l3) : (f64, f64) -> i32
  %w4 = func.call @past(%e, %l4) : (f64, f64) -> i32
  %w5 = func.call @past(%e, %l5) : (f64, f64) -> i32
  %w6 = func.call @past(%e, %l6) : (f64, f64) -> i32
  %w7 = func.call @past(%e, %l7) : (f64, f64) -> i32
  %w8 = func.call @past(%e, %l8) : (f64, f64) -> i32
  %w9 = func.call @past(%e, %l9) : (f64, f64) -> i32
  %w10 = func.call @past(%e, %l10) : (f64, f64) -> i32
  %w11 = func.call @past(%e, %l11) : (f64, f64) -> i32
  %w12 = func.call @past(%e, %l12) : (f64, f64) -> i32
  %w13 = func.call @past(%e, %l13) : (f64, f64) -> i32
  %w14 = func.call @past(%e, %l14) : (f64, f64) -> i32
  %w15 = func.call @past(%e, %l15) : (f64, f64) -> i32
  %s0 = arith.addi %c1, %w0 : i32
  %s1 = arith.addi %s0, %w1 : i32
  %s2 = arith.addi %s1, %w2 : i32
  %s3 = arith.addi %s2, %w3 : i32
  %s4 = arith.addi %s3, %w4 : i32
  %s5 = arith.addi %s4, %w5 : i32
  %s6 = arith.addi %s5, %w6 : i32
  %s7 = arith.addi %s6, %w7 : i32
  %s8 = arith.addi %s7, %w8 : i32
  %s9 = arith.addi %s8, %w9 : i32
  %s10 = arith.addi %s9, %w10 : i32
  %s11 = arith.addi %s10, %w11 : i32
  %s12 = arith.addi %s11, %w12 : i32
  %s13 = arith.addi %s12, %w13 : i32
  %s14 = arith.addi %s13, %w14 : i32
  %s15 = arith.addi %s14, %w15 : i32
  return %s15 : i32
}
func.func private @past(%e: f64, %l: f64) -> i32 {
  %le = arith.cmpf ole, %e, %l : f64
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %v = arith.select %le, %c0, %c1 : i32
  return %v : i32
}
func.func private @cubic_emit(%s: i32, %nq: i32, %n: i32, %step: f32, %srecip: f32, %pts: i32, %at: i32) {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c3 = arith.constant 3 : i32
  %c4 = arith.constant 4 : i32
  %f0 = arith.constant 0.0 : f32
  %f1 = arith.constant 1.0 : f32
  %f2 = arith.constant 2.0 : f32
  %f3 = arith.constant 3.0 : f32
  %f4 = arith.constant 4.0 : f32
  %m2 = arith.constant -2.0 : f32
  %odd = arith.constant 40 : i32
  %i72 = arith.constant 72 : i32
  %i88 = arith.constant 88 : i32
  %i104 = arith.constant 104 : i32
  %i120 = arith.constant 120 : i32
  %i136 = arith.constant 136 : i32
  %fin:3 = scf.for %i = %c0 to %nq step %c1 iter_args(%vs = %f0, %last = %c0, %xb = %f0) -> (f32, i32, f32) : i32 {
    %kv = arith.addi %i136, %i : i32
    %val = func.call @sget(%s, %kv) : (i32, i32) -> f32
    %vs2 = arith.addf %vs, %val : f32
    %tn = arith.mulf %vs2, %srecip : f32
    %fl = math.floor %tn : f32
    %tnn = arith.addf %f1, %fl : f32
    %tni = arith.fptosi %tnn : f32 to i32
    %dn = arith.subi %tni, %last : i32
    %some = arith.cmpi sgt, %dn, %c0 : i32
    scf.if %some {
      %dx = arith.divf %step, %val : f32
      %x0 = arith.mulf %xb, %dx : f32
      %in = arith.addi %i, %c1 : i32
      %e0:2 = func.call @pget(%s, %c0, %i) : (i32, i32, i32) -> (f32, f32)
      %e1:2 = func.call @pget(%s, %odd, %i) : (i32, i32, i32) -> (f32, f32)
      %e2:2 = func.call @pget(%s, %c0, %in) : (i32, i32, i32) -> (f32, f32)
      %ka0 = arith.addi %i72, %i : i32
      %kda = arith.addi %i88, %i : i32
      %ku0 = arith.addi %i104, %i : i32
      %kus = arith.addi %i120, %i : i32
      %a0 = func.call @sget(%s, %ka0) : (i32, i32) -> f32
      %da = func.call @sget(%s, %kda) : (i32, i32) -> f32
      %u0 = func.call @sget(%s, %ku0) : (i32, i32) -> f32
      %us = func.call @sget(%s, %kus) : (i32, i32) -> f32
      %ax0 = math.fma %e1#0, %m2, %e0#0 : f32
      %ax = arith.addf %ax0, %e2#0 : f32
      %ay0 = math.fma %e1#1, %m2, %e0#1 : f32
      %ay = arith.addf %ay0, %e2#1 : f32
      %bx0 = arith.subf %e1#0, %e0#0 : f32
      %bx = arith.mulf %bx0, %f2 : f32
      %by0 = arith.subf %e1#1, %e0#1 : f32
      %by = arith.mulf %by0, %f2 : f32
      %fdx = arith.mulf %f4, %dx : f32
      %ainc = arith.mulf %fdx, %da : f32
      %xm0 = math.fma %f0, %dx, %x0 : f32
      %xm1 = math.fma %f1, %dx, %x0 : f32
      %xm2 = math.fma %f2, %dx, %x0 : f32
      %xm3 = math.fma %f3, %dx, %x0 : f32
      %am0 = math.fma %da, %xm0, %a0 : f32
      %am1 = math.fma %da, %xm1, %a0 : f32
      %am2 = math.fma %da, %xm2, %a0 : f32
      %am3 = math.fma %da, %xm3, %a0 : f32
      %rounds0 = arith.addi %dn, %c3 : i32
      %c2s = arith.constant 2 : i32
      %rounds = arith.shrui %rounds0, %c2s : i32
      %r:4 = scf.for %j = %c0 to %rounds step %c1 iter_args(%b0 = %am0, %b1 = %am1, %b2 = %am2, %b3 = %am3) -> (f32, f32, f32, f32) : i32 {
        %j4 = arith.muli %j, %c4 : i32
        %base = arith.addi %last, %j4 : i32
        func.call @cubic_point(%b0, %u0, %us, %ax, %ay, %bx, %by, %e0#0, %e0#1, %base, %c0, %dn, %last, %n, %pts, %at) : (f32, f32, f32, f32, f32, f32, f32, f32, f32, i32, i32, i32, i32, i32, i32, i32) -> ()
        func.call @cubic_point(%b1, %u0, %us, %ax, %ay, %bx, %by, %e0#0, %e0#1, %base, %c1, %dn, %last, %n, %pts, %at) : (f32, f32, f32, f32, f32, f32, f32, f32, f32, i32, i32, i32, i32, i32, i32, i32) -> ()
        %c2 = arith.constant 2 : i32
        func.call @cubic_point(%b2, %u0, %us, %ax, %ay, %bx, %by, %e0#0, %e0#1, %base, %c2, %dn, %last, %n, %pts, %at) : (f32, f32, f32, f32, f32, f32, f32, f32, f32, i32, i32, i32, i32, i32, i32, i32) -> ()
        func.call @cubic_point(%b3, %u0, %us, %ax, %ay, %bx, %by, %e0#0, %e0#1, %base, %c3, %dn, %last, %n, %pts, %at) : (f32, f32, f32, f32, f32, f32, f32, f32, f32, i32, i32, i32, i32, i32, i32, i32) -> ()
        %nb0 = arith.addf %b0, %ainc : f32
        %nb1 = arith.addf %b1, %ainc : f32
        %nb2 = arith.addf %b2, %ainc : f32
        %nb3 = arith.addf %b3, %ainc : f32
        scf.yield %nb0, %nb1, %nb2, %nb3 : f32, f32, f32, f32
      }
    }
    %xb2 = arith.subf %tnn, %tn : f32
    scf.yield %vs2, %tni, %xb2 : f32, i32, f32
  }
  return
}
func.func private @cubic_point(%a: f32, %u0: f32, %us: f32, %ax: f32, %ay: f32, %bx: f32, %by: f32, %cx: f32, %cy: f32, %base: i32, %m: i32, %dn: i32, %last: i32, %n: i32, %pts: i32, %at: i32) {
  %c1 = arith.constant 1 : i32
  %g = arith.addi %base, %m : i32
  %q = arith.subi %g, %last : i32
  %mine = arith.cmpi slt, %q, %dn : i32
  %lo = arith.cmpi sge, %g, %c1 : i32
  %hi = arith.cmpi slt, %g, %n : i32
  %w0 = arith.andi %mine, %lo : i1
  %w = arith.andi %w0, %hi : i1
  scf.if %w {
    %u = func.call @apii32(%a) : (f32) -> f32
    %du = arith.subf %u, %u0 : f32
    %t = arith.mulf %du, %us : f32
    %px0 = math.fma %ax, %t, %bx : f32
    %px = math.fma %px0, %t, %cx : f32
    %py0 = math.fma %ay, %t, %by : f32
    %py = math.fma %py0, %t, %cy : f32
    %k0 = arith.subi %g, %c1 : i32
    %k = arith.addi %at, %k0 : i32
    %c8 = arith.constant 8 : i32
    %o = arith.muli %k, %c8 : i32
    %ad = arith.addi %pts, %o : i32
    %v = vector.from_elements %px, %py : vector<2xf32>
    %st_p30 = llvm.inttoptr %ad : i32 to !llvm.ptr<1>
    llvm.store %v, %st_p30 {alignment = 4 : i64} : vector<2xf32>, !llvm.ptr<1>
  }
  return
}
}
}
