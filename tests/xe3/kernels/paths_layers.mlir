// acgpu's paths#rowcoarse+layers in upstream dialects.
module attributes {gpu.container_module} {
gpu.module @shaders [#xevm.target<chip = "ptl">] {
gpu.func @coarse(%params: i32, %nrows: i32, %pass: i32) kernel {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c4 = arith.constant 4 : i32
  %c8 = arith.constant 8 : i32
  %c16 = arith.constant 16 : i32
  %strips_p1 = llvm.inttoptr %params : i32 to !llvm.ptr<1>
  %strips = llvm.load %strips_p1 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
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
  %cmds_p6 = llvm.inttoptr %a5 : i32 to !llvm.ptr<1>
  %cmds = llvm.load %cmds_p6 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a6 = arith.addi %a5, %c4 : i32
  %depth_p7 = llvm.inttoptr %a6 : i32 to !llvm.ptr<1>
  %depth = llvm.load %depth_p7 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %cols_p8 = llvm.inttoptr %consts : i32 to !llvm.ptr<1>
  %cols = llvm.load %cols_p8 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %k1 = arith.addi %consts, %c4 : i32
  %k2 = arith.addi %k1, %c4 : i32
  %np_p9 = llvm.inttoptr %k2 : i32 to !llvm.ptr<1>
  %np = llvm.load %np_p9 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %k3 = arith.addi %k2, %c4 : i32
  %chunk_p10 = llvm.inttoptr %k3 : i32 to !llvm.ptr<1>
  %chunk = llvm.load %chunk_p10 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %k4 = arith.addi %k3, %c4 : i32
  %nchunks_p11 = llvm.inttoptr %k4 : i32 to !llvm.ptr<1>
  %nchunks = llvm.load %nchunks_p11 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %g_ix12 = gpu.block_id x
  %g = arith.index_cast %g_ix12 : index to i32
  %row_ix13 = gpu.block_id y
  %row = arith.index_cast %row_ix13 : index to i32
  %l_ix14 = gpu.thread_id x
  %l = arith.index_cast %l_ix14 : index to i32
  %b0 = arith.muli %g, %c16 : i32
  %ci = arith.addi %b0, %l : i32
  %inside = arith.cmpi slt, %ci, %nchunks : i32
  scf.if %inside {
    %rc = arith.muli %row, %nchunks : i32
    %lane = arith.addi %rc, %ci : i32
    %pfirst = arith.muli %ci, %chunk : i32
    %pend0 = arith.addi %pfirst, %chunk : i32
    %pend = arith.minui %pend0, %np : i32
    %write = arith.cmpi eq, %pass, %c1 : i32
    %r8 = arith.muli %lane, %c8 : i32
    %oa = arith.addi %offsets, %r8 : i32
    %ov = scf.if %write -> (vector<2xi32>) {
      %v_p15 = llvm.inttoptr %oa : i32 to !llvm.ptr<1>
      %v = llvm.load %v_p15 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<2xi32>
      scf.yield %v : vector<2xi32>
    } else {
      %z = vector.from_elements %c0, %c0 : vector<2xi32>
      scf.yield %z : vector<2xi32>
    }
    %co = vector.extract %ov[0] : i32 from vector<2xi32>
    %do = vector.extract %ov[1] : i32 from vector<2xi32>
    %res:2 = scf.for %p = %pfirst to %pend step %c1 iter_args(%nc = %co, %nd = %do) -> (i32, i32) : i32 {
      %c32 = arith.constant 32 : i32
      %po = arith.muli %p, %c32 : i32
      %pa = arith.addi %paths, %po : i32
      %pv_p16 = llvm.inttoptr %pa : i32 to !llvm.ptr<1>
      %pv = llvm.load %pv_p16 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xi32>
      %s0 = vector.extract %pv[0] : i32 from vector<4xi32>
      %ns = vector.extract %pv[1] : i32 from vector<4xi32>
      %ab = vector.extract %pv[2] : i32 from vector<4xi32>
      %at = vector.extract %pv[3] : i32 from vector<4xi32>
      %pa2 = arith.addi %pa, %c16 : i32
      %opq_p17 = llvm.inttoptr %pa2 : i32 to !llvm.ptr<1>
      %opq = llvm.load %opq_p17 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
      %c8s = arith.constant 8 : i32
      %sb0 = arith.muli %s0, %c8s : i32
      %sb = arith.addi %strips, %sb0 : i32
      %last = arith.subi %ns, %c1 : i32
      %first = func.call @lower_bound(%sb, %last, %row) : (i32, i32, i32) -> i32
      %r:3 = scf.for %i = %first to %last step %c1 iter_args(%c = %nc, %d = %nd, %go = %c1) -> (i32, i32, i32) : i32 {
        %alive = arith.cmpi ne, %go, %c0 : i32
        %o:3 = scf.if %alive -> (i32, i32, i32) {
          %s:4 = func.call @strip(%sb, %i) : (i32, i32) -> (i32, i32, i32, i32)
          %c2s = arith.constant 2 : i32
          %ty = arith.shrui %s#1, %c2s : i32
          %mine = arith.cmpi eq, %ty, %row : i32
          %q:3 = scf.if %mine -> (i32, i32, i32) {
            %in = arith.addi %i, %c1 : i32
            %t:4 = func.call @strip(%sb, %in) : (i32, i32) -> (i32, i32, i32, i32)
            %e:2 = func.call @pair(%s#0, %s#1, %s#2, %s#3, %t#0, %t#1, %t#2, %t#3, %row, %cols, %ab, %at, %opq, %cmds, %depth, %c, %d, %write) : (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i1) -> (i32, i32)
            scf.yield %e#0, %e#1, %c1 : i32, i32, i32
          } else {
            scf.yield %c, %d, %c0 : i32, i32, i32
          }
          scf.yield %q#0, %q#1, %q#2 : i32, i32, i32
        } else {
          scf.yield %c, %d, %go : i32, i32, i32
        }
        scf.yield %o#0, %o#1, %o#2 : i32, i32, i32
      }
      scf.yield %r#0, %r#1 : i32, i32
    }
    %first0 = arith.cmpi eq, %pass, %c0 : i32
    scf.if %first0 {
      %ca = arith.addi %counts, %r8 : i32
      %cv = vector.from_elements %res#0, %res#1 : vector<2xi32>
      %st_p18 = llvm.inttoptr %ca : i32 to !llvm.ptr<1>
      llvm.store %cv, %st_p18 {alignment = 4 : i64} : vector<2xi32>, !llvm.ptr<1>
    }
  }
  gpu.return
}
func.func private @strip(%sb: i32, %i: i32) -> (i32, i32, i32, i32) {
  %c8 = arith.constant 8 : i32
  %c16 = arith.constant 16 : i32
  %m = arith.constant 65535 : i32
  %c31 = arith.constant 31 : i32
  %mask = arith.constant 2147483647 : i32
  %o = arith.muli %i, %c8 : i32
  %a = arith.addi %sb, %o : i32
  %v_p19 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
  %v = llvm.load %v_p19 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<2xi32>
  %xy = vector.extract %v[0] : i32 from vector<2xi32>
  %pk = vector.extract %v[1] : i32 from vector<2xi32>
  %x = arith.andi %xy, %m : i32
  %y = arith.shrui %xy, %c16 : i32
  %ai = arith.andi %pk, %mask : i32
  %fg = arith.shrui %pk, %c31 : i32
  return %x, %y, %ai, %fg : i32, i32, i32, i32
}
func.func private @lower_bound(%sb: i32, %n: i32, %row: i32) -> i32 {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c2 = arith.constant 2 : i32
  %true = arith.constant true
  %r:3 = "scf.while"(%c0, %n, %true) ({
  ^bb0(%lw: i32, %hw: i32, %gw: i1):
    "scf.condition"(%gw, %lw, %hw, %gw) : (i1, i32, i32, i1) -> ()
  }, {
  ^bb0(%lo: i32, %hi: i32, %g0: i1):
    %more = arith.cmpi slt, %lo, %hi : i32
    %nx:3 = scf.if %more -> (i32, i32, i1) {
      %s = arith.addi %lo, %hi : i32
      %mid = arith.shrui %s, %c1 : i32
      %st:4 = func.call @strip(%sb, %mid) : (i32, i32) -> (i32, i32, i32, i32)
      %ty = arith.shrui %st#1, %c2 : i32
      %below = arith.cmpi slt, %ty, %row : i32
      %m1 = arith.addi %mid, %c1 : i32
      %lo2 = arith.select %below, %m1, %lo : i32
      %hi2 = arith.select %below, %hi, %mid : i32
      scf.yield %lo2, %hi2, %true : i32, i32, i1
    } else {
      %f = arith.constant false
      scf.yield %lo, %hi, %f : i32, i32, i1
    }
    "scf.yield"(%nx#0, %nx#1, %nx#2) : (i32, i32, i1) -> ()
  }) : (i32, i32, i1) -> (i32, i32, i1)
  return %r#0 : i32
}
func.func private @cmd(%cmds: i32, %c: i32, %x0: i32, %x1: i32, %alpha: i32, %attrs: i32, %write: i1) -> i32 {
  scf.if %write {
    %c4 = arith.constant 4 : i32
    %c16 = arith.constant 16 : i32
    %px = arith.muli %x0, %c4 : i32
    %w0 = arith.subi %x1, %x0 : i32
    %pw = arith.muli %w0, %c4 : i32
    %ws = arith.shli %pw, %c16 : i32
    %xw = arith.ori %px, %ws : i32
    %z = arith.constant 0 : i32
    %o = arith.muli %c, %c16 : i32
    %a = arith.addi %cmds, %o : i32
    %v = vector.from_elements %xw, %alpha, %attrs, %z : vector<4xi32>
    %st_p20 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
    llvm.store %v, %st_p20 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr<1>
  }
  %c1 = arith.constant 1 : i32
  %n = arith.addi %c, %c1 : i32
  return %n : i32
}
func.func private @dcmd(%depth: i32, %d: i32, %start: i32, %end: i32, %attrs: i32, %write: i1) -> i32 {
  scf.if %write {
    %c8 = arith.constant 8 : i32
    %c16 = arith.constant 16 : i32
    %es = arith.shli %end, %c16 : i32
    %se = arith.ori %start, %es : i32
    %o = arith.muli %d, %c8 : i32
    %a = arith.addi %depth, %o : i32
    %v = vector.from_elements %se, %attrs : vector<2xi32>
    %st_p21 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
    llvm.store %v, %st_p21 {alignment = 4 : i64} : vector<2xi32>, !llvm.ptr<1>
  }
  %c1 = arith.constant 1 : i32
  %n = arith.addi %d, %c1 : i32
  return %n : i32
}
func.func private @pair(%x: i32, %y: i32, %ai: i32, %fg: i32, %nx: i32, %ny: i32, %nai: i32, %nfg: i32, %row: i32, %cols: i32, %ab: i32, %at: i32, %opq: i32, %cmds: i32, %depth: i32, %c: i32, %d: i32, %write: i1) -> (i32, i32) {
  %c0 = arith.constant 0 : i32
  %c2 = arith.constant 2 : i32
  %c4 = arith.constant 4 : i32
  %c16 = arith.constant 16 : i32
  %m = arith.constant 65535 : i32
  %col = arith.shrui %ai, %c2 : i32
  %ncol = arith.shrui %nai, %c2 : i32
  %wd0 = arith.subi %ncol, %col : i32
  %wd = arith.maxsi %wd0, %c0 : i32
  %wdm = arith.andi %wd, %m : i32
  %tx0 = arith.shrui %x, %c2 : i32
  %wt = arith.shrui %wdm, %c2 : i32
  %tx1a = arith.addi %tx0, %wt : i32
  %tx1 = arith.minui %tx1a, %m : i32
  %x0 = arith.maxui %tx0, %c0 : i32
  %x1 = arith.minui %tx1, %cols : i32
  %fills = arith.cmpi ult, %x0, %x1 : i32
  %c1 = scf.if %fills -> (i32) {
    %dx = arith.subi %x0, %tx0 : i32
    %d16 = arith.muli %dx, %c16 : i32
    %a0 = arith.addi %ab, %ai : i32
    %alpha = arith.addi %a0, %d16 : i32
    %n = func.call @cmd(%cmds, %c, %x0, %x1, %alpha, %at, %write) : (i32, i32, i32, i32, i32, i32, i1) -> i32
    scf.yield %n : i32
  } else {
    scf.yield %c : i32
  }
  %gap = arith.cmpi ne, %nfg, %c0 : i32
  %samey = arith.cmpi eq, %ny, %y : i32
  %g = arith.andi %gap, %samey : i1
  %r:2 = scf.if %g -> (i32, i32) {
    %gx0 = arith.maxui %tx1, %c0 : i32
    %nt = arith.shrui %nx, %c2 : i32
    %gx1 = arith.minui %nt, %cols : i32
    %some = arith.cmpi ult, %gx0, %gx1 : i32
    %q:2 = scf.if %some -> (i32, i32) {
      %isopq = arith.cmpi ne, %opq, %c0 : i32
      %w:2 = scf.if %isopq -> (i32, i32) {
        %v:2 = func.call @split(%gx0, %gx1, %at, %cmds, %depth, %c1, %d, %write) : (i32, i32, i32, i32, i32, i32, i32, i1) -> (i32, i32)
        scf.yield %v#0, %v#1 : i32, i32
      } else {
        %m1 = arith.constant -1 : i32
        %n = func.call @cmd(%cmds, %c1, %gx0, %gx1, %m1, %at, %write) : (i32, i32, i32, i32, i32, i32, i1) -> i32
        scf.yield %n, %d : i32, i32
      }
      scf.yield %w#0, %w#1 : i32, i32
    } else {
      scf.yield %c1, %d : i32, i32
    }
    scf.yield %q#0, %q#1 : i32, i32
  } else {
    scf.yield %c1, %d : i32, i32
  }
  return %r#0, %r#1 : i32, i32
}
func.func private @split(%x: i32, %end: i32, %at: i32, %cmds: i32, %depth: i32, %c: i32, %d: i32, %write: i1) -> (i32, i32) {
  %c31 = arith.constant 31 : i32
  %c5 = arith.constant 5 : i32
  %m1 = arith.constant -1 : i32
  %nm = arith.constant -32 : i32
  %xa0 = arith.addi %x, %c31 : i32
  %ax = arith.andi %xa0, %nm : i32
  %ae = arith.andi %end, %nm : i32
  %none = arith.cmpi uge, %ax, %ae : i32
  %r:2 = scf.if %none -> (i32, i32) {
    %n = func.call @cmd(%cmds, %c, %x, %end, %m1, %at, %write) : (i32, i32, i32, i32, i32, i32, i1) -> i32
    scf.yield %n, %d : i32, i32
  } else {
    %lead = arith.cmpi ult, %x, %ax : i32
    %c1 = scf.if %lead -> (i32) {
      %n = func.call @cmd(%cmds, %c, %x, %ax, %m1, %at, %write) : (i32, i32, i32, i32, i32, i32, i1) -> i32
      scf.yield %n : i32
    } else {
      scf.yield %c : i32
    }
    %bs = arith.shrui %ax, %c5 : i32
    %be = arith.shrui %ae, %c5 : i32
    %d1 = func.call @dcmd(%depth, %d, %bs, %be, %at, %write) : (i32, i32, i32, i32, i32, i1) -> i32
    %trail = arith.cmpi ult, %ae, %end : i32
    %c2 = scf.if %trail -> (i32) {
      %n = func.call @cmd(%cmds, %c1, %ae, %end, %m1, %at, %write) : (i32, i32, i32, i32, i32, i32, i1) -> i32
      scf.yield %n : i32
    } else {
      scf.yield %c1 : i32
    }
    scf.yield %c2, %d1 : i32, i32
  }
  return %r#0, %r#1 : i32, i32
}
gpu.func @coarse_path(%params: i32, %npaths: i32, %pass: i32) kernel {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c2 = arith.constant 2 : i32
  %c4 = arith.constant 4 : i32
  %c8 = arith.constant 8 : i32
  %c16 = arith.constant 16 : i32
  %strips_p22 = llvm.inttoptr %params : i32 to !llvm.ptr<1>
  %strips = llvm.load %strips_p22 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a1 = arith.addi %params, %c4 : i32
  %paths_p23 = llvm.inttoptr %a1 : i32 to !llvm.ptr<1>
  %paths = llvm.load %paths_p23 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a2 = arith.addi %a1, %c4 : i32
  %consts_p24 = llvm.inttoptr %a2 : i32 to !llvm.ptr<1>
  %consts = llvm.load %consts_p24 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a3 = arith.addi %a2, %c4 : i32
  %ctab_p25 = llvm.inttoptr %a3 : i32 to !llvm.ptr<1>
  %ctab = llvm.load %ctab_p25 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a4 = arith.addi %a3, %c4 : i32
  %dtab_p26 = llvm.inttoptr %a4 : i32 to !llvm.ptr<1>
  %dtab = llvm.load %dtab_p26 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a5 = arith.addi %a4, %c4 : i32
  %coffs_p27 = llvm.inttoptr %a5 : i32 to !llvm.ptr<1>
  %coffs = llvm.load %coffs_p27 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a6 = arith.addi %a5, %c4 : i32
  %doffs_p28 = llvm.inttoptr %a6 : i32 to !llvm.ptr<1>
  %doffs = llvm.load %doffs_p28 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a7 = arith.addi %a6, %c4 : i32
  %cmds_p29 = llvm.inttoptr %a7 : i32 to !llvm.ptr<1>
  %cmds = llvm.load %cmds_p29 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a8 = arith.addi %a7, %c4 : i32
  %depth_p30 = llvm.inttoptr %a8 : i32 to !llvm.ptr<1>
  %depth = llvm.load %depth_p30 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %cols_p31 = llvm.inttoptr %consts : i32 to !llvm.ptr<1>
  %cols = llvm.load %cols_p31 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %k1 = arith.addi %consts, %c4 : i32
  %rows_p32 = llvm.inttoptr %k1 : i32 to !llvm.ptr<1>
  %rows = llvm.load %rows_p32 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %g_ix33 = gpu.block_id x
  %g = arith.index_cast %g_ix33 : index to i32
  %l_ix34 = gpu.thread_id x
  %l = arith.index_cast %l_ix34 : index to i32
  %b0 = arith.muli %g, %c16 : i32
  %p = arith.addi %b0, %l : i32
  %inside = arith.cmpi slt, %p, %npaths : i32
  scf.if %inside {
    %write = arith.cmpi eq, %pass, %c1 : i32
    %c32 = arith.constant 32 : i32
    %po = arith.muli %p, %c32 : i32
    %pa = arith.addi %paths, %po : i32
    %pv_p35 = llvm.inttoptr %pa : i32 to !llvm.ptr<1>
    %pv = llvm.load %pv_p35 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xi32>
    %s0 = vector.extract %pv[0] : i32 from vector<4xi32>
    %ns = vector.extract %pv[1] : i32 from vector<4xi32>
    %ab = vector.extract %pv[2] : i32 from vector<4xi32>
    %at = vector.extract %pv[3] : i32 from vector<4xi32>
    %pa2 = arith.addi %pa, %c16 : i32
    %opq_p36 = llvm.inttoptr %pa2 : i32 to !llvm.ptr<1>
    %opq = llvm.load %opq_p36 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %sb0 = arith.muli %s0, %c8 : i32
    %sb = arith.addi %strips, %sb0 : i32
    %last = arith.subi %ns, %c1 : i32
    %m1 = arith.constant -1 : i32
    %fin:3 = scf.for %i = %c0 to %last step %c1 iter_args(%cur = %m1, %c = %c0, %d = %c0) -> (i32, i32, i32) : i32 {
      %s:4 = func.call @strip(%sb, %i) : (i32, i32) -> (i32, i32, i32, i32)
      %ty = arith.shrui %s#1, %c2 : i32
      %inrows = arith.cmpi ult, %ty, %rows : i32
      %o:3 = scf.if %inrows -> (i32, i32, i32) {
        %newrow = arith.cmpi ne, %ty, %cur : i32
        %st:2 = scf.if %newrow -> (i32, i32) {
          %done = arith.cmpi sge, %cur, %c0 : i32
          %true0 = arith.constant true
          %w0 = arith.xori %write, %true0 : i1
          %flush = arith.andi %done, %w0 : i1
          scf.if %flush {
            func.call @tab_put(%consts, %ctab, %dtab, %cur, %npaths, %p, %c, %d) : (i32, i32, i32, i32, i32, i32, i32, i32) -> ()
          }
          %n:2 = scf.if %write -> (i32, i32) {
            %v:2 = func.call @tab_get(%consts, %coffs, %doffs, %ty, %npaths, %p) : (i32, i32, i32, i32, i32, i32) -> (i32, i32)
            scf.yield %v#0, %v#1 : i32, i32
          } else {
            scf.yield %c0, %c0 : i32, i32
          }
          scf.yield %n#0, %n#1 : i32, i32
        } else {
          scf.yield %c, %d : i32, i32
        }
        %in = arith.addi %i, %c1 : i32
        %t:4 = func.call @strip(%sb, %in) : (i32, i32) -> (i32, i32, i32, i32)
        %e:2 = func.call @pair(%s#0, %s#1, %s#2, %s#3, %t#0, %t#1, %t#2, %t#3, %ty, %cols, %ab, %at, %opq, %cmds, %depth, %st#0, %st#1, %write) : (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i1) -> (i32, i32)
        scf.yield %ty, %e#0, %e#1 : i32, i32, i32
      } else {
        scf.yield %cur, %c, %d : i32, i32, i32
      }
      scf.yield %o#0, %o#1, %o#2 : i32, i32, i32
    }
    %done = arith.cmpi sge, %fin#0, %c0 : i32
    %true = arith.constant true
    %w0 = arith.xori %write, %true : i1
    %flush = arith.andi %done, %w0 : i1
    scf.if %flush {
      func.call @tab_put(%consts, %ctab, %dtab, %fin#0, %npaths, %p, %fin#1, %fin#2) : (i32, i32, i32, i32, i32, i32, i32, i32) -> ()
    }
  }
  gpu.return
}
func.func private @tab_at(%consts: i32, %row: i32, %np: i32, %p: i32, %sorted: i1) -> i32 {
  %c0 = arith.constant 0 : i32
  %c4 = arith.constant 4 : i32
  %c8 = arith.constant 8 : i32
  %c20 = arith.constant 20 : i32
  %c24 = arith.constant 24 : i32
  %c28 = arith.constant 28 : i32
  %pra = arith.addi %consts, %c20 : i32
  %prow_p37 = llvm.inttoptr %pra : i32 to !llvm.ptr<1>
  %prow = llvm.load %prow_p37 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %sparse = arith.cmpi ne, %prow, %c0 : i32
  %k = scf.if %sparse -> (i32) {
    %p8 = arith.muli %p, %c8 : i32
    %ra = arith.addi %prow, %p8 : i32
    %r0_p38 = llvm.inttoptr %ra : i32 to !llvm.ptr<1>
    %r0 = llvm.load %r0_p38 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %pba = arith.addi %consts, %c24 : i32
    %pbase_p39 = llvm.inttoptr %pba : i32 to !llvm.ptr<1>
    %pbase = llvm.load %pbase_p39 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %p4 = arith.muli %p, %c4 : i32
    %ba = arith.addi %pbase, %p4 : i32
    %b_p40 = llvm.inttoptr %ba : i32 to !llvm.ptr<1>
    %b = llvm.load %b_p40 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %dr = arith.subi %row, %r0 : i32
    %slot = arith.addi %b, %dr : i32
    %pos = scf.if %sorted -> (i32) {
      %sa0 = arith.addi %consts, %c28 : i32
      %sarr_p41 = llvm.inttoptr %sa0 : i32 to !llvm.ptr<1>
      %sarr = llvm.load %sarr_p41 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
      %s4 = arith.muli %slot, %c4 : i32
      %sa = arith.addi %sarr, %s4 : i32
      %v_p42 = llvm.inttoptr %sa : i32 to !llvm.ptr<1>
      %v = llvm.load %v_p42 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
      scf.yield %v : i32
    } else {
      scf.yield %slot : i32
    }
    scf.yield %pos : i32
  } else {
    %rn = arith.muli %row, %np : i32
    %d = arith.addi %rn, %p : i32
    scf.yield %d : i32
  }
  return %k : i32
}
func.func private @tab_put(%consts: i32, %ctab: i32, %dtab: i32, %row: i32, %np: i32, %p: i32, %c: i32, %d: i32) {
  %c4 = arith.constant 4 : i32
  %f = arith.constant false
  %k = func.call @tab_at(%consts, %row, %np, %p, %f) : (i32, i32, i32, i32, i1) -> i32
  %o = arith.muli %k, %c4 : i32
  %ca = arith.addi %ctab, %o : i32
  %da = arith.addi %dtab, %o : i32
  %st_p43 = llvm.inttoptr %ca : i32 to !llvm.ptr<1>
  llvm.store %c, %st_p43 {alignment = 4 : i64} : i32, !llvm.ptr<1>
  %st_p44 = llvm.inttoptr %da : i32 to !llvm.ptr<1>
  llvm.store %d, %st_p44 {alignment = 4 : i64} : i32, !llvm.ptr<1>
  return
}
func.func private @tab_get(%consts: i32, %coffs: i32, %doffs: i32, %row: i32, %np: i32, %p: i32) -> (i32, i32) {
  %c4 = arith.constant 4 : i32
  %t = arith.constant true
  %k = func.call @tab_at(%consts, %row, %np, %p, %t) : (i32, i32, i32, i32, i1) -> i32
  %o = arith.muli %k, %c4 : i32
  %ca = arith.addi %coffs, %o : i32
  %da = arith.addi %doffs, %o : i32
  %c_p45 = llvm.inttoptr %ca : i32 to !llvm.ptr<1>
  %c = llvm.load %c_p45 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %d_p46 = llvm.inttoptr %da : i32 to !llvm.ptr<1>
  %d = llvm.load %d_p46 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  return %c, %d : i32, i32
}
func.func private @cmdk(%cmds: i32, %c: i32, %x0: i32, %x1: i32, %alpha: i32, %attrs: i32, %kind: i32, %write: i1) -> i32 {
  scf.if %write {
    %c4 = arith.constant 4 : i32
    %c16 = arith.constant 16 : i32
    %px = arith.muli %x0, %c4 : i32
    %w0 = arith.subi %x1, %x0 : i32
    %pw = arith.muli %w0, %c4 : i32
    %ws = arith.shli %pw, %c16 : i32
    %xw = arith.ori %px, %ws : i32
    %o = arith.muli %c, %c16 : i32
    %a = arith.addi %cmds, %o : i32
    %v = vector.from_elements %xw, %alpha, %attrs, %kind : vector<4xi32>
    %st_p47 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
    llvm.store %v, %st_p47 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr<1>
  }
  %c1 = arith.constant 1 : i32
  %n = arith.addi %c, %c1 : i32
  return %n : i32
}
func.func private @pair_b(%x: i32, %y: i32, %ai: i32, %nx: i32, %ny: i32, %nai: i32, %nfg: i32, %bx0: i32, %bx1: i32, %ab: i32, %at: i32, %opq: i32, %kind: i32, %cmds: i32, %depth: i32, %c: i32, %d: i32, %write: i1) -> (i32, i32) {
  %c0 = arith.constant 0 : i32
  %c2 = arith.constant 2 : i32
  %c16 = arith.constant 16 : i32
  %m = arith.constant 65535 : i32
  %col = arith.shrui %ai, %c2 : i32
  %ncol = arith.shrui %nai, %c2 : i32
  %wd0 = arith.subi %ncol, %col : i32
  %wd = arith.maxsi %wd0, %c0 : i32
  %wdm = arith.andi %wd, %m : i32
  %tx0 = arith.shrui %x, %c2 : i32
  %wt = arith.shrui %wdm, %c2 : i32
  %tx1a = arith.addi %tx0, %wt : i32
  %tx1 = arith.minui %tx1a, %m : i32
  %x0 = arith.maxui %tx0, %bx0 : i32
  %x1 = arith.minui %tx1, %bx1 : i32
  %fills = arith.cmpi ult, %x0, %x1 : i32
  %c1 = scf.if %fills -> (i32) {
    %dx = arith.subi %x0, %tx0 : i32
    %d16 = arith.muli %dx, %c16 : i32
    %a0 = arith.addi %ab, %ai : i32
    %alpha = arith.addi %a0, %d16 : i32
    %n = func.call @cmdk(%cmds, %c, %x0, %x1, %alpha, %at, %kind, %write) : (i32, i32, i32, i32, i32, i32, i32, i1) -> i32
    scf.yield %n : i32
  } else {
    scf.yield %c : i32
  }
  %gap = arith.cmpi ne, %nfg, %c0 : i32
  %samey = arith.cmpi eq, %ny, %y : i32
  %g = arith.andi %gap, %samey : i1
  %r:2 = scf.if %g -> (i32, i32) {
    %gx0 = arith.maxui %tx1, %bx0 : i32
    %nt = arith.shrui %nx, %c2 : i32
    %gx1 = arith.minui %nt, %bx1 : i32
    %some = arith.cmpi ult, %gx0, %gx1 : i32
    %q:2 = scf.if %some -> (i32, i32) {
      %isopq = arith.cmpi ne, %opq, %c0 : i32
      %w:2 = scf.if %isopq -> (i32, i32) {
        %v:2 = func.call @split(%gx0, %gx1, %at, %cmds, %depth, %c1, %d, %write) : (i32, i32, i32, i32, i32, i32, i32, i1) -> (i32, i32)
        scf.yield %v#0, %v#1 : i32, i32
      } else {
        %m1 = arith.constant -1 : i32
        %n = func.call @cmdk(%cmds, %c1, %gx0, %gx1, %m1, %at, %kind, %write) : (i32, i32, i32, i32, i32, i32, i32, i1) -> i32
        scf.yield %n, %d : i32, i32
      }
      scf.yield %w#0, %w#1 : i32, i32
    } else {
      scf.yield %c1, %d : i32, i32
    }
    scf.yield %q#0, %q#1 : i32, i32
  } else {
    scf.yield %c1, %d : i32, i32
  }
  return %r#0, %r#1 : i32, i32
}
func.func private @layer(%layers: i32, %cols: i32, %rows: i32, %lm: i32) -> (i32, i32, i32, i32, i32) {
  %c0 = arith.constant 0 : i32
  %c32 = arith.constant 32 : i32
  %m1 = arith.constant -1 : i32
  %none = arith.cmpi slt, %lm, %c0 : i32
  %r:5 = scf.if %none -> (i32, i32, i32, i32, i32) {
    scf.yield %m1, %c0, %c0, %cols, %rows : i32, i32, i32, i32, i32
  } else {
    %o = arith.muli %lm, %c32 : i32
    %a = arith.addi %layers, %o : i32
    %v_p48 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
    %v = llvm.load %v_p48 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xi32>
    %p = vector.extract %v[0] : i32 from vector<4xi32>
    %x0 = vector.extract %v[1] : i32 from vector<4xi32>
    %y0 = vector.extract %v[2] : i32 from vector<4xi32>
    %x1 = vector.extract %v[3] : i32 from vector<4xi32>
    %c16 = arith.constant 16 : i32
    %a2 = arith.addi %a, %c16 : i32
    %y1_p49 = llvm.inttoptr %a2 : i32 to !llvm.ptr<1>
    %y1 = llvm.load %y1_p49 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    scf.yield %p, %x0, %y0, %x1, %y1 : i32, i32, i32, i32, i32
  }
  return %r#0, %r#1, %r#2, %r#3, %r#4 : i32, i32, i32, i32, i32
}
func.func private @ancestor(%layers: i32, %lm: i32, %k: i32) -> i32 {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c32 = arith.constant 32 : i32
  %a = scf.for %i = %c0 to %k step %c1 iter_args(%m = %lm) -> (i32) : i32 {
    %o = arith.muli %m, %c32 : i32
    %at = arith.addi %layers, %o : i32
    %p_p50 = llvm.inttoptr %at : i32 to !llvm.ptr<1>
    %p = llvm.load %p_p50 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    scf.yield %p : i32
  }
  return %a : i32
}
func.func private @depth_of(%layers: i32, %lm: i32) -> i32 {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c32 = arith.constant 32 : i32
  %true = arith.constant true
  %r:2 = "scf.while"(%lm, %c0) ({
  ^bb0(%m: i32, %n: i32):
    %more = arith.cmpi sge, %m, %c0 : i32
    "scf.condition"(%more, %m, %n) : (i1, i32, i32) -> ()
  }, {
  ^bb0(%m: i32, %n: i32):
    %o = arith.muli %m, %c32 : i32
    %at = arith.addi %layers, %o : i32
    %p_p51 = llvm.inttoptr %at : i32 to !llvm.ptr<1>
    %p = llvm.load %p_p51 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %n1 = arith.addi %n, %c1 : i32
    "scf.yield"(%p, %n1) : (i32, i32) -> ()
  }) : (i32, i32) -> (i32, i32)
  return %r#1 : i32
}
func.func private @first_at(%first: i32, %row: i32, %nl: i32, %lm: i32) -> i32 {
  %c4 = arith.constant 4 : i32
  %rn = arith.muli %row, %nl : i32
  %k = arith.addi %rn, %lm : i32
  %o = arith.muli %k, %c4 : i32
  %a = arith.addi %first, %o : i32
  return %a : i32
}
func.func private @pushes(%cmds: i32, %c: i32, %first: i32, %row: i32, %nl: i32, %k: i32, %layers: i32, %lm: i32, %depth: i32, %write: i1) -> i32 {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c2 = arith.constant 2 : i32
  %m1 = arith.constant -1 : i32
  %r = scf.for %i = %c0 to %depth step %c1 iter_args(%cc = %c) -> (i32) : i32 {
    %up0 = arith.subi %depth, %i : i32
    %up = arith.subi %up0, %c1 : i32
    %a = func.call @ancestor(%layers, %lm, %up) : (i32, i32, i32) -> i32
    %fa = func.call @first_at(%first, %row, %nl, %a) : (i32, i32, i32, i32) -> i32
    %f_p52 = llvm.inttoptr %fa : i32 to !llvm.ptr<1>
    %f = llvm.load %f_p52 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %mine = arith.cmpi eq, %f, %k : i32
    %n = scf.if %mine -> (i32) {
      %v = func.call @cmdk(%cmds, %cc, %c0, %c0, %m1, %c0, %c2, %write) : (i32, i32, i32, i32, i32, i32, i32, i1) -> i32
      scf.yield %v : i32
    } else {
      scf.yield %cc : i32
    }
    scf.yield %n : i32
  }
  return %r : i32
}
func.func private @mark(%first: i32, %row: i32, %nl: i32, %k: i32, %layers: i32, %lm: i32, %depth: i32) {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  scf.for %i = %c0 to %depth step %c1 : i32 {
    %a = func.call @ancestor(%layers, %lm, %i) : (i32, i32, i32) -> i32
    %fa = func.call @first_at(%first, %row, %nl, %a) : (i32, i32, i32, i32) -> i32
    %o_p53 = llvm.inttoptr %fa : i32 to !llvm.ptr<1>
    %o = llvm.atomicrmw umin %o_p53, %k monotonic : !llvm.ptr<1>, i32
  }
  return
}
gpu.func @coarse_ev(%params: i32, %nev: i32, %pass: i32) kernel {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c2 = arith.constant 2 : i32
  %c3 = arith.constant 3 : i32
  %c4 = arith.constant 4 : i32
  %c8 = arith.constant 8 : i32
  %c12 = arith.constant 12 : i32
  %c16 = arith.constant 16 : i32
  %c32 = arith.constant 32 : i32
  %m1 = arith.constant -1 : i32
  %true = arith.constant true
  %false = arith.constant false
  %strips_p54 = llvm.inttoptr %params : i32 to !llvm.ptr<1>
  %strips = llvm.load %strips_p54 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a1 = arith.addi %params, %c4 : i32
  %events_p55 = llvm.inttoptr %a1 : i32 to !llvm.ptr<1>
  %events = llvm.load %events_p55 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a2 = arith.addi %a1, %c4 : i32
  %layers_p56 = llvm.inttoptr %a2 : i32 to !llvm.ptr<1>
  %layers = llvm.load %layers_p56 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a3 = arith.addi %a2, %c4 : i32
  %consts_p57 = llvm.inttoptr %a3 : i32 to !llvm.ptr<1>
  %consts = llvm.load %consts_p57 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a4 = arith.addi %a3, %c4 : i32
  %first_p58 = llvm.inttoptr %a4 : i32 to !llvm.ptr<1>
  %first = llvm.load %first_p58 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a5 = arith.addi %a4, %c4 : i32
  %ctab_p59 = llvm.inttoptr %a5 : i32 to !llvm.ptr<1>
  %ctab = llvm.load %ctab_p59 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a6 = arith.addi %a5, %c4 : i32
  %dtab_p60 = llvm.inttoptr %a6 : i32 to !llvm.ptr<1>
  %dtab = llvm.load %dtab_p60 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a7 = arith.addi %a6, %c4 : i32
  %coffs_p61 = llvm.inttoptr %a7 : i32 to !llvm.ptr<1>
  %coffs = llvm.load %coffs_p61 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a8 = arith.addi %a7, %c4 : i32
  %doffs_p62 = llvm.inttoptr %a8 : i32 to !llvm.ptr<1>
  %doffs = llvm.load %doffs_p62 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a9 = arith.addi %a8, %c4 : i32
  %cmds_p63 = llvm.inttoptr %a9 : i32 to !llvm.ptr<1>
  %cmds = llvm.load %cmds_p63 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a10 = arith.addi %a9, %c4 : i32
  %depth_p64 = llvm.inttoptr %a10 : i32 to !llvm.ptr<1>
  %depth = llvm.load %depth_p64 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %cols_p65 = llvm.inttoptr %consts : i32 to !llvm.ptr<1>
  %cols = llvm.load %cols_p65 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %k1 = arith.addi %consts, %c4 : i32
  %rows_p66 = llvm.inttoptr %k1 : i32 to !llvm.ptr<1>
  %rows = llvm.load %rows_p66 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %k3 = arith.addi %consts, %c12 : i32
  %nl_p67 = llvm.inttoptr %k3 : i32 to !llvm.ptr<1>
  %nl = llvm.load %nl_p67 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %g_ix68 = gpu.block_id x
  %g = arith.index_cast %g_ix68 : index to i32
  %l_ix69 = gpu.thread_id x
  %l = arith.index_cast %l_ix69 : index to i32
  %b0 = arith.muli %g, %c16 : i32
  %k = arith.addi %b0, %l : i32
  %inside = arith.cmpi slt, %k, %nev : i32
  scf.if %inside {
    %write = arith.cmpi eq, %pass, %c1 : i32
    %marking = arith.cmpi eq, %pass, %c2 : i32
    %eo = arith.muli %k, %c32 : i32
    %ea = arith.addi %events, %eo : i32
    %ev_p70 = llvm.inttoptr %ea : i32 to !llvm.ptr<1>
    %ev = llvm.load %ev_p70 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xi32>
    %kind = vector.extract %ev[0] : i32 from vector<4xi32>
    %s0 = vector.extract %ev[1] : i32 from vector<4xi32>
    %ns = vector.extract %ev[2] : i32 from vector<4xi32>
    %ab = vector.extract %ev[3] : i32 from vector<4xi32>
    %ea2 = arith.addi %ea, %c16 : i32
    %ev2_p71 = llvm.inttoptr %ea2 : i32 to !llvm.ptr<1>
    %ev2 = llvm.load %ev2_p71 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xi32>
    %at = vector.extract %ev2[0] : i32 from vector<4xi32>
    %opq = vector.extract %ev2[1] : i32 from vector<4xi32>
    %lm = vector.extract %ev2[2] : i32 from vector<4xi32>
    %sb0 = arith.muli %s0, %c8 : i32
    %sb = arith.addi %strips, %sb0 : i32
    %last = arith.subi %ns, %c1 : i32
    %isfill = arith.cmpi eq, %kind, %c0 : i32
    scf.if %isfill {
      %bx:5 = func.call @layer(%layers, %cols, %rows, %lm) : (i32, i32, i32, i32) -> (i32, i32, i32, i32, i32)
      %dep = func.call @depth_of(%layers, %lm) : (i32, i32) -> i32
      %fin:4 = scf.for %i = %c0 to %last step %c1 iter_args(%cur = %m1, %c = %c0, %d = %c0, %open = %false) -> (i32, i32, i32, i1) : i32 {
        %s:4 = func.call @strip(%sb, %i) : (i32, i32) -> (i32, i32, i32, i32)
        %ty = arith.shrui %s#1, %c2 : i32
        %ge = arith.cmpi uge, %ty, %bx#2 : i32
        %lt = arith.cmpi ult, %ty, %bx#4 : i32
        %inr = arith.andi %ge, %lt : i1
        %o:4 = scf.if %inr -> (i32, i32, i32, i1) {
          %newrow = arith.cmpi ne, %ty, %cur : i32
          %st:3 = scf.if %newrow -> (i32, i32, i1) {
            %done = arith.cmpi sge, %cur, %c0 : i32
            %count = arith.cmpi eq, %pass, %c0 : i32
            %flush = arith.andi %done, %count : i1
            scf.if %flush {
              func.call @tab_put(%consts, %ctab, %dtab, %cur, %nev, %k, %c, %d) : (i32, i32, i32, i32, i32, i32, i32, i32) -> ()
            }
            %n:2 = scf.if %write -> (i32, i32) {
              %v:2 = func.call @tab_get(%consts, %coffs, %doffs, %ty, %nev, %k) : (i32, i32, i32, i32, i32, i32) -> (i32, i32)
              scf.yield %v#0, %v#1 : i32, i32
            } else {
              scf.yield %c0, %c0 : i32, i32
            }
            scf.yield %n#0, %n#1, %false : i32, i32, i1
          } else {
            scf.yield %c, %d, %open : i32, i32, i1
          }
          %in = arith.addi %i, %c1 : i32
          %t:4 = func.call @strip(%sb, %in) : (i32, i32) -> (i32, i32, i32, i32)
          %dry:2 = func.call @pair_b(%s#0, %s#1, %s#2, %t#0, %t#1, %t#2, %t#3, %bx#1, %bx#3, %ab, %at, %opq, %c0, %cmds, %depth, %c0, %c0, %false) : (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i1) -> (i32, i32)
          %any0 = arith.addi %dry#0, %dry#1 : i32
          %any = arith.cmpi ne, %any0, %c0 : i32
          %notopen = arith.xori %st#2, %true : i1
          %opening = arith.andi %any, %notopen : i1
          %cp = scf.if %opening -> (i32) {
            scf.if %marking {
              func.call @mark(%first, %ty, %nl, %k, %layers, %lm, %dep) : (i32, i32, i32, i32, i32, i32, i32) -> ()
            }
            %v = func.call @pushes(%cmds, %st#0, %first, %ty, %nl, %k, %layers, %lm, %dep, %write) : (i32, i32, i32, i32, i32, i32, i32, i32, i32, i1) -> i32
            scf.yield %v : i32
          } else {
            scf.yield %st#0 : i32
          }
          %open2 = arith.ori %st#2, %any : i1
          %e:2 = func.call @pair_b(%s#0, %s#1, %s#2, %t#0, %t#1, %t#2, %t#3, %bx#1, %bx#3, %ab, %at, %opq, %c0, %cmds, %depth, %cp, %st#1, %write) : (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i1) -> (i32, i32)
          scf.yield %ty, %e#0, %e#1, %open2 : i32, i32, i32, i1
        } else {
          scf.yield %cur, %c, %d, %open : i32, i32, i32, i1
        }
        scf.yield %o#0, %o#1, %o#2, %o#3 : i32, i32, i32, i1
      }
      %done = arith.cmpi sge, %fin#0, %c0 : i32
      %count = arith.cmpi eq, %pass, %c0 : i32
      %flush = arith.andi %done, %count : i1
      scf.if %flush {
        func.call @tab_put(%consts, %ctab, %dtab, %fin#0, %nev, %k, %fin#1, %fin#2) : (i32, i32, i32, i32, i32, i32, i32, i32) -> ()
      }
    } else {
      %notmark = arith.xori %marking, %true : i1
      scf.if %notmark {
        %bx:5 = func.call @layer(%layers, %cols, %rows, %lm) : (i32, i32, i32, i32) -> (i32, i32, i32, i32, i32)
        %px:5 = func.call @layer(%layers, %cols, %rows, %bx#0) : (i32, i32, i32, i32) -> (i32, i32, i32, i32, i32)
        %clipped = arith.cmpi sge, %ns, %c2 : i32
        scf.for %y = %bx#2 to %bx#4 step %c1 : i32 {
          %fa = func.call @first_at(%first, %y, %nl, %lm) : (i32, i32, i32, i32) -> i32
          %f_p72 = llvm.inttoptr %fa : i32 to !llvm.ptr<1>
          %f = llvm.load %f_p72 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
          %occ = arith.cmpi ne, %f, %m1 : i32
          scf.if %occ {
            %cd:2 = scf.if %write -> (i32, i32) {
              %v:2 = func.call @tab_get(%consts, %coffs, %doffs, %y, %nev, %k) : (i32, i32, i32, i32, i32, i32) -> (i32, i32)
              scf.yield %v#0, %v#1 : i32, i32
            } else {
              scf.yield %c0, %c0 : i32, i32
            }
            %cf = scf.if %clipped -> (i32) {
              %lo = func.call @lower_bound(%sb, %last, %y) : (i32, i32, i32) -> i32
              %y1 = arith.addi %y, %c1 : i32
              %hi = func.call @lower_bound(%sb, %last, %y1) : (i32, i32, i32) -> i32
              %r = scf.for %i = %lo to %hi step %c1 iter_args(%c = %cd#0) -> (i32) : i32 {
                %s:4 = func.call @strip(%sb, %i) : (i32, i32) -> (i32, i32, i32, i32)
                %in = arith.addi %i, %c1 : i32
                %t:4 = func.call @strip(%sb, %in) : (i32, i32) -> (i32, i32, i32, i32)
                %e:2 = func.call @pair_b(%s#0, %s#1, %s#2, %t#0, %t#1, %t#2, %t#3, %px#1, %px#3, %ab, %at, %c0, %c1, %cmds, %depth, %c, %c0, %write) : (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i1) -> (i32, i32)
                scf.yield %e#0 : i32
              }
              scf.yield %r : i32
            } else {
              %v = func.call @cmdk(%cmds, %cd#0, %bx#1, %bx#3, %m1, %at, %c1, %write) : (i32, i32, i32, i32, i32, i32, i32, i1) -> i32
              scf.yield %v : i32
            }
            %cpop = func.call @cmdk(%cmds, %cf, %c0, %c0, %m1, %c0, %c3, %write) : (i32, i32, i32, i32, i32, i32, i32, i1) -> i32
            %count = arith.cmpi eq, %pass, %c0 : i32
            scf.if %count {
              func.call @tab_put(%consts, %ctab, %dtab, %y, %nev, %k, %cpop, %c0) : (i32, i32, i32, i32, i32, i32, i32, i32) -> ()
            }
          }
        }
      }
    }
  }
  gpu.return
}
}
}
