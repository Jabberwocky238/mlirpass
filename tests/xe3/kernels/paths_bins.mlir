// acgpu's crates/intel/driver/src/paths/bins.mlir in upstream dialects.
module attributes {gpu.container_module} {
gpu.module @shaders [#xevm.target<chip = "ptl">] {
gpu.func @bins(%params: i32, %nlanes: i32, %pass: i32) kernel {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c4 = arith.constant 4 : i32
  %c7 = arith.constant 7 : i32
  %c8 = arith.constant 8 : i32
  %c16 = arith.constant 16 : i32
  %c128 = arith.constant 128 : i32
  %c65535 = arith.constant 65535 : i32
  %true1 = arith.constant true
  %cin_p1 = llvm.inttoptr %params : i32 to !llvm.ptr<1>
  %cin = llvm.load %cin_p1 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a1 = arith.addi %params, %c4 : i32
  %din_p2 = llvm.inttoptr %a1 : i32 to !llvm.ptr<1>
  %din = llvm.load %din_p2 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a2 = arith.addi %a1, %c4 : i32
  %coffs_p3 = llvm.inttoptr %a2 : i32 to !llvm.ptr<1>
  %coffs = llvm.load %coffs_p3 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a3 = arith.addi %a2, %c4 : i32
  %doffs_p4 = llvm.inttoptr %a3 : i32 to !llvm.ptr<1>
  %doffs = llvm.load %doffs_p4 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a4 = arith.addi %a3, %c4 : i32
  %ctotal_p5 = llvm.inttoptr %a4 : i32 to !llvm.ptr<1>
  %ctotal = llvm.load %ctotal_p5 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a5 = arith.addi %a4, %c4 : i32
  %dtotal_p6 = llvm.inttoptr %a5 : i32 to !llvm.ptr<1>
  %dtotal = llvm.load %dtotal_p6 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a6 = arith.addi %a5, %c4 : i32
  %consts_p7 = llvm.inttoptr %a6 : i32 to !llvm.ptr<1>
  %consts = llvm.load %consts_p7 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a7 = arith.addi %a6, %c4 : i32
  %ccounts_p8 = llvm.inttoptr %a7 : i32 to !llvm.ptr<1>
  %ccounts = llvm.load %ccounts_p8 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a8 = arith.addi %a7, %c4 : i32
  %dcounts_p9 = llvm.inttoptr %a8 : i32 to !llvm.ptr<1>
  %dcounts = llvm.load %dcounts_p9 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a9 = arith.addi %a8, %c4 : i32
  %coffsets_p10 = llvm.inttoptr %a9 : i32 to !llvm.ptr<1>
  %coffsets = llvm.load %coffsets_p10 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a10 = arith.addi %a9, %c4 : i32
  %doffsets_p11 = llvm.inttoptr %a10 : i32 to !llvm.ptr<1>
  %doffsets = llvm.load %doffsets_p11 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a11 = arith.addi %a10, %c4 : i32
  %cout_p12 = llvm.inttoptr %a11 : i32 to !llvm.ptr<1>
  %cout = llvm.load %cout_p12 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a12 = arith.addi %a11, %c4 : i32
  %dout_p13 = llvm.inttoptr %a12 : i32 to !llvm.ptr<1>
  %dout = llvm.load %dout_p13 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a13 = arith.addi %a12, %c4 : i32
  %rout_p14 = llvm.inttoptr %a13 : i32 to !llvm.ptr<1>
  %rout = llvm.load %rout_p14 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %nrows_p15 = llvm.inttoptr %consts : i32 to !llvm.ptr<1>
  %nrows = llvm.load %nrows_p15 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %k1 = arith.addi %consts, %c4 : i32
  %np_p16 = llvm.inttoptr %k1 : i32 to !llvm.ptr<1>
  %np = llvm.load %np_p16 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %k2 = arith.addi %k1, %c4 : i32
  %nb_p17 = llvm.inttoptr %k2 : i32 to !llvm.ptr<1>
  %nb = llvm.load %nb_p17 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %g_ix18 = gpu.block_id x
  %g = arith.index_cast %g_ix18 : index to i32
  %row_ix19 = gpu.block_id y
  %row = arith.index_cast %row_ix19 : index to i32
  %l_ix20 = gpu.thread_id x
  %l = arith.index_cast %l_ix20 : index to i32
  %g16 = arith.muli %g, %c16 : i32
  %b = arith.addi %g16, %l : i32
  %inside = arith.cmpi slt, %b, %nb : i32
  scf.if %inside {
    %rb = arith.muli %row, %nb : i32
    %lane = arith.addi %rb, %b : i32
    %l4 = arith.muli %lane, %c4 : i32
    %write = arith.cmpi eq, %pass, %c1 : i32
    %c12 = arith.constant 12 : i32
    %rsa = arith.addi %consts, %c12 : i32
    %rowstart_p21 = llvm.inttoptr %rsa : i32 to !llvm.ptr<1>
    %rowstart = llvm.load %rowstart_p21 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %sparse = arith.cmpi ne, %rowstart, %c0 : i32
    %r1 = arith.addi %row, %c1 : i32
    %t0 = arith.muli %row, %np : i32
    %row4 = arith.muli %row, %c4 : i32
    %rs0a = arith.addi %rowstart, %row4 : i32
    %k0 = scf.if %sparse -> (i32) {
      %v_p22 = llvm.inttoptr %rs0a : i32 to !llvm.ptr<1>
      %v = llvm.load %v_p22 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
      scf.yield %v : i32
    } else {
      scf.yield %t0 : i32
    }
    %t04 = arith.muli %k0, %c4 : i32
    %ca0 = arith.addi %coffs, %t04 : i32
    %cf_p23 = llvm.inttoptr %ca0 : i32 to !llvm.ptr<1>
    %cf = llvm.load %cf_p23 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %da0 = arith.addi %doffs, %t04 : i32
    %df_p24 = llvm.inttoptr %da0 : i32 to !llvm.ptr<1>
    %df = llvm.load %df_p24 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %notlast0 = arith.cmpi slt, %r1, %nrows : i32
    %notlast = arith.ori %notlast0, %sparse : i1
    %ce, %de = scf.if %notlast -> (i32, i32) {
      %k1_s1 = scf.if %sparse -> (i32) {
        %rs1a = arith.addi %rs0a, %c4 : i32
        %v_p25 = llvm.inttoptr %rs1a : i32 to !llvm.ptr<1>
        %v = llvm.load %v_p25 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
        scf.yield %v : i32
      } else {
        %v = arith.addi %t0, %np : i32
        scf.yield %v : i32
      }
      %t14 = arith.muli %k1_s1, %c4 : i32
      %ca1 = arith.addi %coffs, %t14 : i32
      %x_p26 = llvm.inttoptr %ca1 : i32 to !llvm.ptr<1>
      %x = llvm.load %x_p26 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
      %da1 = arith.addi %doffs, %t14 : i32
      %y_p27 = llvm.inttoptr %da1 : i32 to !llvm.ptr<1>
      %y = llvm.load %y_p27 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
      scf.yield %x, %y : i32, i32
    } else {
      %x_p28 = llvm.inttoptr %ctotal : i32 to !llvm.ptr<1>
      %x = llvm.load %x_p28 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
      %y_p29 = llvm.inttoptr %dtotal : i32 to !llvm.ptr<1>
      %y = llvm.load %y_p29 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
      scf.yield %x, %y : i32, i32
    }
    %co, %dn = scf.if %write -> (i32, i32) {
      %oa = arith.addi %coffsets, %l4 : i32
      %x_p30 = llvm.inttoptr %oa : i32 to !llvm.ptr<1>
      %x = llvm.load %x_p30 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
      %ob = arith.addi %doffsets, %l4 : i32
      %y_p31 = llvm.inttoptr %ob : i32 to !llvm.ptr<1>
      %y = llvm.load %y_p31 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
      scf.yield %x, %y : i32, i32
    } else {
      scf.yield %c0, %c0 : i32, i32
    }
    %lo = arith.shli %b, %c7 : i32
    %hi = arith.addi %lo, %c128 : i32
    %c16b = arith.constant 16 : i32
    %l0a = arith.addi %consts, %c16b : i32
    %layer0_p32 = llvm.inttoptr %l0a : i32 to !llvm.ptr<1>
    %layer0 = llvm.load %layer0_p32 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %c2k = arith.constant 2 : i32
    %c3k = arith.constant 3 : i32
    %m1k = arith.constant -1 : i32
    %nct:2 = scf.for %i = %cf to %ce step %c1 iter_args(%k = %c0, %tp = %c0) -> (i32, i32) : i32 {
      %i16 = arith.muli %i, %c16 : i32
      %ia = arith.addi %cin, %i16 : i32
      %v_p33 = llvm.inttoptr %ia : i32 to !llvm.ptr<1>
      %v = llvm.load %v_p33 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xi32>
      %xw = vector.extract %v[0] : i32 from vector<4xi32>
      %kind = vector.extract %v[3] : i32 from vector<4xi32>
      %x = arith.andi %xw, %c65535 : i32
      %w = arith.shrui %xw, %c16 : i32
      %xe = arith.addi %x, %w : i32
      %o1 = arith.cmpi slt, %x, %hi : i32
      %o2 = arith.cmpi sgt, %xe, %lo : i32
      %ov = arith.andi %o1, %o2 : i1
      %isfill = arith.cmpi ult, %kind, %c2k : i32
      %ispush = arith.cmpi eq, %kind, %c2k : i32
      %ispop = arith.cmpi eq, %kind, %c3k : i32
      %haspush = arith.cmpi ne, %tp, %c0 : i32
      %takeback = arith.andi %ispop, %haspush : i1
      %fillin = arith.andi %isfill, %ov : i1
      %notback = arith.xori %takeback, %true1 : i1
      %popin = arith.andi %ispop, %notback : i1
      %emit = arith.ori %fillin, %popin : i1
      %k2_s1 = scf.if %emit -> (i32) {
        %kp = func.call @held(%cout, %co, %k, %tp, %write) : (i32, i32, i32, i32, i1) -> i32
        scf.if %write {
          %at = arith.addi %co, %kp : i32
          %at16 = arith.muli %at, %c16 : i32
          %wa = arith.addi %cout, %at16 : i32
          %alpha = vector.extract %v[1] : i32 from vector<4xi32>
          %attrs0 = vector.extract %v[2] : i32 from vector<4xi32>
          %islayer = arith.cmpi eq, %kind, %c1 : i32
          %la = arith.addi %attrs0, %layer0 : i32
          %attrs = arith.select %islayer, %la, %attrs0 : i32
          %sp = arith.select %isfill, %xw, %c0 : i32
          %o = vector.from_elements %kind, %sp, %alpha, %attrs : vector<4xi32>
          %st_p34 = llvm.inttoptr %wa : i32 to !llvm.ptr<1>
          llvm.store %o, %st_p34 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr<1>
        }
        %kk = arith.addi %kp, %c1 : i32
        scf.yield %kk : i32
      } else {
        scf.yield %k : i32
      }
      %tp1 = arith.addi %tp, %c1 : i32
      %tm1 = arith.subi %tp, %c1 : i32
      %t2 = arith.select %ispush, %tp1, %tp : i32
      %t3 = arith.select %takeback, %tm1, %t2 : i32
      %t4 = arith.select %emit, %c0, %t3 : i32
      scf.yield %k2_s1, %t4 : i32, i32
    }
    %nc = func.call @held(%cout, %co, %nct#0, %nct#1, %write) : (i32, i32, i32, i32, i1) -> i32
    %nd = scf.for %i = %df to %de step %c1 iter_args(%k = %c0) -> (i32) : i32 {
      %i8 = arith.muli %i, %c8 : i32
      %ia = arith.addi %din, %i8 : i32
      %v_p35 = llvm.inttoptr %ia : i32 to !llvm.ptr<1>
      %v = llvm.load %v_p35 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<2xi32>
      %se = vector.extract %v[0] : i32 from vector<2xi32>
      %s = arith.andi %se, %c65535 : i32
      %e = arith.shrui %se, %c16 : i32
      %o1 = arith.cmpi sle, %s, %b : i32
      %o2 = arith.cmpi slt, %b, %e : i32
      %ov = arith.andi %o1, %o2 : i1
      %k1n = scf.if %ov -> (i32) {
        scf.if %write {
          %at = arith.addi %dn, %k : i32
          %at8 = arith.muli %at, %c8 : i32
          %wa = arith.addi %dout, %at8 : i32
          %st_p36 = llvm.inttoptr %wa : i32 to !llvm.ptr<1>
          llvm.store %v, %st_p36 {alignment = 4 : i64} : vector<2xi32>, !llvm.ptr<1>
        }
        %kk = arith.addi %k, %c1 : i32
        scf.yield %kk : i32
      } else {
        scf.yield %k : i32
      }
      scf.yield %k1n : i32
    }
    scf.if %write {
      %l16 = arith.muli %lane, %c16 : i32
      %ra = arith.addi %rout, %l16 : i32
      %o = vector.from_elements %co, %nc, %dn, %nd : vector<4xi32>
      %st_p37 = llvm.inttoptr %ra : i32 to !llvm.ptr<1>
      llvm.store %o, %st_p37 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr<1>
    } else {
      %ca = arith.addi %ccounts, %l4 : i32
      %st_p38 = llvm.inttoptr %ca : i32 to !llvm.ptr<1>
      llvm.store %nc, %st_p38 {alignment = 4 : i64} : i32, !llvm.ptr<1>
      %da = arith.addi %dcounts, %l4 : i32
      %st_p39 = llvm.inttoptr %da : i32 to !llvm.ptr<1>
      llvm.store %nd, %st_p39 {alignment = 4 : i64} : i32, !llvm.ptr<1>
    }
  }
  gpu.return
}
func.func private @held(%cout: i32, %co: i32, %k: i32, %t: i32, %write: i1) -> i32 {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c2 = arith.constant 2 : i32
  %c16 = arith.constant 16 : i32
  %m1 = arith.constant -1 : i32
  scf.if %write {
    scf.for %j = %c0 to %t step %c1 : i32 {
      %a0 = arith.addi %co, %k : i32
      %a1 = arith.addi %a0, %j : i32
      %a16 = arith.muli %a1, %c16 : i32
      %wa = arith.addi %cout, %a16 : i32
      %o = vector.from_elements %c2, %c0, %m1, %c0 : vector<4xi32>
      %st_p40 = llvm.inttoptr %wa : i32 to !llvm.ptr<1>
      llvm.store %o, %st_p40 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr<1>
    }
  }
  %n = arith.addi %k, %t : i32
  return %n : i32
}
}
}
