// acgpu's crates/intel/driver/src/paths/glue.mlir in upstream dialects.
module attributes {gpu.container_module} {
gpu.module @shaders [#xevm.target<chip = "ptl">] {
gpu.func @ranges(%elems: i32, %flags: i32, %offsets: i32, %nans: i32, %total: i32, %out: i32, %npaths: i32, %nel: i32) kernel {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c4 = arith.constant 4 : i32
  %c8 = arith.constant 8 : i32
  %c16 = arith.constant 16 : i32
  %g_ix1 = gpu.block_id x
  %g = arith.index_cast %g_ix1 : index to i32
  %l_ix2 = gpu.thread_id x
  %l = arith.index_cast %l_ix2 : index to i32
  %b0 = arith.muli %g, %c16 : i32
  %p = arith.addi %b0, %l : i32
  %inside = arith.cmpi slt, %p, %npaths : i32
  scf.if %inside {
    %p8 = arith.muli %p, %c8 : i32
    %ea = arith.addi %elems, %p8 : i32
    %ev_p3 = llvm.inttoptr %ea : i32 to !llvm.ptr<1>
    %ev = llvm.load %ev_p3 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<2xi32>
    %e0 = vector.extract %ev[0] : i32 from vector<2xi32>
    %ne = vector.extract %ev[1] : i32 from vector<2xi32>
    %p4 = arith.muli %p, %c4 : i32
    %fa = arith.addi %flags, %p4 : i32
    %moved_p4 = llvm.inttoptr %fa : i32 to !llvm.ptr<1>
    %moved = llvm.load %moved_p4 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %e1 = arith.addi %e0, %ne : i32
    %bad = scf.for %e = %e0 to %e1 step %c1 iter_args(%acc = %moved) -> (i32) : i32 {
      %eo = arith.muli %e, %c4 : i32
      %na = arith.addi %nans, %eo : i32
      %nv_p5 = llvm.inttoptr %na : i32 to !llvm.ptr<1>
      %nv = llvm.load %nv_p5 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
      %a2 = arith.ori %acc, %nv : i32
      scf.yield %a2 : i32
    }
    %e0o = arith.muli %e0, %c4 : i32
    %f0a = arith.addi %offsets, %e0o : i32
    %some = arith.cmpi slt, %e0, %nel : i32
    %first = scf.if %some -> (i32) {
      %v_p6 = llvm.inttoptr %f0a : i32 to !llvm.ptr<1>
      %v = llvm.load %v_p6 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
      scf.yield %v : i32
    } else {
      %t_p7 = llvm.inttoptr %total : i32 to !llvm.ptr<1>
      %t = llvm.load %t_p7 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
      scf.yield %t : i32
    }
    %last = arith.cmpi slt, %e1, %nel : i32
    %end = scf.if %last -> (i32) {
      %e1o = arith.muli %e1, %c4 : i32
      %f1a = arith.addi %offsets, %e1o : i32
      %v_p8 = llvm.inttoptr %f1a : i32 to !llvm.ptr<1>
      %v = llvm.load %v_p8 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
      scf.yield %v : i32
    } else {
      %t_p9 = llvm.inttoptr %total : i32 to !llvm.ptr<1>
      %t = llvm.load %t_p9 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
      scf.yield %t : i32
    }
    %n0 = arith.subi %end, %first : i32
    %isbad = arith.cmpi ne, %bad, %c0 : i32
    %n = arith.select %isbad, %c0, %n0 : i32
    %oa = arith.addi %out, %p8 : i32
    %ov = vector.from_elements %first, %n : vector<2xi32>
    %st_p10 = llvm.inttoptr %oa : i32 to !llvm.ptr<1>
    llvm.store %ov, %st_p10 {alignment = 4 : i64} : vector<2xi32>, !llvm.ptr<1>
  }
  gpu.return
}
gpu.func @stripin(%ranges: i32, %toffsets: i32, %tcounts: i32, %rules: i32, %out: i32, %npaths: i32) kernel {
  %c4 = arith.constant 4 : i32
  %c8 = arith.constant 8 : i32
  %c16 = arith.constant 16 : i32
  %g_ix11 = gpu.block_id x
  %g = arith.index_cast %g_ix11 : index to i32
  %l_ix12 = gpu.thread_id x
  %l = arith.index_cast %l_ix12 : index to i32
  %b0 = arith.muli %g, %c16 : i32
  %p = arith.addi %b0, %l : i32
  %inside = arith.cmpi slt, %p, %npaths : i32
  scf.if %inside {
    %p8 = arith.muli %p, %c8 : i32
    %ra = arith.addi %ranges, %p8 : i32
    %fl_p13 = llvm.inttoptr %ra : i32 to !llvm.ptr<1>
    %fl = llvm.load %fl_p13 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %p4 = arith.muli %p, %c4 : i32
    %toa = arith.addi %toffsets, %p4 : i32
    %ft_p14 = llvm.inttoptr %toa : i32 to !llvm.ptr<1>
    %ft = llvm.load %ft_p14 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %tca = arith.addi %tcounts, %p4 : i32
    %nt_p15 = llvm.inttoptr %tca : i32 to !llvm.ptr<1>
    %nt = llvm.load %nt_p15 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %rua = arith.addi %rules, %p4 : i32
    %ru_p16 = llvm.inttoptr %rua : i32 to !llvm.ptr<1>
    %ru = llvm.load %ru_p16 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %p16 = arith.muli %p, %c16 : i32
    %oa = arith.addi %out, %p16 : i32
    %v = vector.from_elements %fl, %ft, %nt, %ru : vector<4xi32>
    %st_p17 = llvm.inttoptr %oa : i32 to !llvm.ptr<1>
    llvm.store %v, %st_p17 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr<1>
  }
  gpu.return
}
gpu.func @split(%pairs: i32, %a: i32, %b: i32, %n: i32) kernel {
  %c4 = arith.constant 4 : i32
  %c8 = arith.constant 8 : i32
  %c16 = arith.constant 16 : i32
  %g_ix18 = gpu.block_id x
  %g = arith.index_cast %g_ix18 : index to i32
  %l_ix19 = gpu.thread_id x
  %l = arith.index_cast %l_ix19 : index to i32
  %b0 = arith.muli %g, %c16 : i32
  %p = arith.addi %b0, %l : i32
  %inside = arith.cmpi slt, %p, %n : i32
  scf.if %inside {
    %p8 = arith.muli %p, %c8 : i32
    %pa = arith.addi %pairs, %p8 : i32
    %v_p20 = llvm.inttoptr %pa : i32 to !llvm.ptr<1>
    %v = llvm.load %v_p20 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<2xi32>
    %x = vector.extract %v[0] : i32 from vector<2xi32>
    %y = vector.extract %v[1] : i32 from vector<2xi32>
    %p4 = arith.muli %p, %c4 : i32
    %aa = arith.addi %a, %p4 : i32
    %ba = arith.addi %b, %p4 : i32
    %st_p21 = llvm.inttoptr %aa : i32 to !llvm.ptr<1>
    llvm.store %x, %st_p21 {alignment = 4 : i64} : i32, !llvm.ptr<1>
    %st_p22 = llvm.inttoptr %ba : i32 to !llvm.ptr<1>
    llvm.store %y, %st_p22 {alignment = 4 : i64} : i32, !llvm.ptr<1>
  }
  gpu.return
}
gpu.func @pairs(%a: i32, %b: i32, %pairs: i32, %n: i32) kernel {
  %c4 = arith.constant 4 : i32
  %c8 = arith.constant 8 : i32
  %c16 = arith.constant 16 : i32
  %g_ix23 = gpu.block_id x
  %g = arith.index_cast %g_ix23 : index to i32
  %l_ix24 = gpu.thread_id x
  %l = arith.index_cast %l_ix24 : index to i32
  %b0 = arith.muli %g, %c16 : i32
  %p = arith.addi %b0, %l : i32
  %inside = arith.cmpi slt, %p, %n : i32
  scf.if %inside {
    %p4 = arith.muli %p, %c4 : i32
    %aa = arith.addi %a, %p4 : i32
    %ba = arith.addi %b, %p4 : i32
    %x_p25 = llvm.inttoptr %aa : i32 to !llvm.ptr<1>
    %x = llvm.load %x_p25 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %y_p26 = llvm.inttoptr %ba : i32 to !llvm.ptr<1>
    %y = llvm.load %y_p26 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %p8 = arith.muli %p, %c8 : i32
    %pa = arith.addi %pairs, %p8 : i32
    %v = vector.from_elements %x, %y : vector<2xi32>
    %st_p27 = llvm.inttoptr %pa : i32 to !llvm.ptr<1>
    llvm.store %v, %st_p27 {alignment = 4 : i64} : vector<2xi32>, !llvm.ptr<1>
  }
  gpu.return
}
gpu.func @cpaths(%params: i32, %npaths: i32, %nslots: i32, %pass: i32) kernel {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c4 = arith.constant 4 : i32
  %c8 = arith.constant 8 : i32
  %c12 = arith.constant 12 : i32
  %c16 = arith.constant 16 : i32
  %c32 = arith.constant 32 : i32
  %soffsets_p28 = llvm.inttoptr %params : i32 to !llvm.ptr<1>
  %soffsets = llvm.load %soffsets_p28 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a1 = arith.addi %params, %c4 : i32
  %roffsets_p29 = llvm.inttoptr %a1 : i32 to !llvm.ptr<1>
  %roffsets = llvm.load %roffsets_p29 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a2 = arith.addi %a1, %c4 : i32
  %stotal_p30 = llvm.inttoptr %a2 : i32 to !llvm.ptr<1>
  %stotal = llvm.load %stotal_p30 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a3 = arith.addi %a2, %c4 : i32
  %atotal_p31 = llvm.inttoptr %a3 : i32 to !llvm.ptr<1>
  %atotal = llvm.load %atotal_p31 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a4 = arith.addi %a3, %c4 : i32
  %opaque_p32 = llvm.inttoptr %a4 : i32 to !llvm.ptr<1>
  %opaque = llvm.load %opaque_p32 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a5 = arith.addi %a4, %c4 : i32
  %out_p33 = llvm.inttoptr %a5 : i32 to !llvm.ptr<1>
  %out = llvm.load %out_p33 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a6 = arith.addi %a5, %c4 : i32
  %flags_p34 = llvm.inttoptr %a6 : i32 to !llvm.ptr<1>
  %flags = llvm.load %flags_p34 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a7 = arith.addi %a6, %c4 : i32
  %attrs_p35 = llvm.inttoptr %a7 : i32 to !llvm.ptr<1>
  %attrs = llvm.load %attrs_p35 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %g_ix36 = gpu.block_id x
  %g = arith.index_cast %g_ix36 : index to i32
  %l_ix37 = gpu.thread_id x
  %l = arith.index_cast %l_ix37 : index to i32
  %b0 = arith.muli %g, %c16 : i32
  %p = arith.addi %b0, %l : i32
  %inside = arith.cmpi slt, %p, %npaths : i32
  scf.if %inside {
    %p4 = arith.muli %p, %c4 : i32
    %p32 = arith.muli %p, %c32 : i32
    %out0 = arith.addi %out, %p32 : i32
    %second = arith.cmpi eq, %pass, %c1 : i32
    scf.if %second {
      %aa = arith.addi %attrs, %p4 : i32
      %at_p38 = llvm.inttoptr %aa : i32 to !llvm.ptr<1>
      %at = llvm.load %at_p38 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
      %o12 = arith.addi %out0, %c12 : i32
      %st_p39 = llvm.inttoptr %o12 : i32 to !llvm.ptr<1>
      llvm.store %at, %st_p39 {alignment = 4 : i64} : i32, !llvm.ptr<1>
    } else {
      %ra = arith.addi %roffsets, %p4 : i32
      %s0_p40 = llvm.inttoptr %ra : i32 to !llvm.ptr<1>
      %s0 = llvm.load %s0_p40 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
      %p1 = arith.addi %p, %c1 : i32
      %notlast = arith.cmpi slt, %p1, %npaths : i32
      %s1 = scf.if %notlast -> (i32) {
        %ra1 = arith.addi %ra, %c4 : i32
        %v_p41 = llvm.inttoptr %ra1 : i32 to !llvm.ptr<1>
        %v = llvm.load %v_p41 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
        scf.yield %v : i32
      } else {
        scf.yield %nslots : i32
      }
      %in0 = arith.cmpi slt, %s0, %nslots : i32
      %so, %ao = scf.if %in0 -> (i32, i32) {
        %o = arith.muli %s0, %c8 : i32
        %a = arith.addi %soffsets, %o : i32
        %v_p42 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
        %v = llvm.load %v_p42 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<2xi32>
        %x = vector.extract %v[0] : i32 from vector<2xi32>
        %y = vector.extract %v[1] : i32 from vector<2xi32>
        scf.yield %x, %y : i32, i32
      } else {
        %x_p43 = llvm.inttoptr %stotal : i32 to !llvm.ptr<1>
        %x = llvm.load %x_p43 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
        %y_p44 = llvm.inttoptr %atotal : i32 to !llvm.ptr<1>
        %y = llvm.load %y_p44 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
        scf.yield %x, %y : i32, i32
      }
      %in1 = arith.cmpi slt, %s1, %nslots : i32
      %se = scf.if %in1 -> (i32) {
        %o = arith.muli %s1, %c8 : i32
        %a = arith.addi %soffsets, %o : i32
        %x_p45 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
        %x = llvm.load %x_p45 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
        scf.yield %x : i32
      } else {
        %x_p46 = llvm.inttoptr %stotal : i32 to !llvm.ptr<1>
        %x = llvm.load %x_p46 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
        scf.yield %x : i32
      }
      %ns = arith.subi %se, %so : i32
      %oa = arith.addi %opaque, %p4 : i32
      %op_p47 = llvm.inttoptr %oa : i32 to !llvm.ptr<1>
      %op = llvm.load %op_p47 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
      %v0 = vector.from_elements %so, %ns, %ao, %c0 : vector<4xi32>
      %st_p48 = llvm.inttoptr %out0 : i32 to !llvm.ptr<1>
      llvm.store %v0, %st_p48 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr<1>
      %out1 = arith.addi %out0, %c16 : i32
      %v1 = vector.from_elements %op, %c0, %c0, %c0 : vector<4xi32>
      %st_p49 = llvm.inttoptr %out1 : i32 to !llvm.ptr<1>
      llvm.store %v1, %st_p49 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr<1>
      %some = arith.cmpi ne, %ns, %c0 : i32
      %f = arith.select %some, %c1, %c0 : i32
      %fa = arith.addi %flags, %p4 : i32
      %st_p50 = llvm.inttoptr %fa : i32 to !llvm.ptr<1>
      llvm.store %f, %st_p50 {alignment = 4 : i64} : i32, !llvm.ptr<1>
    }
  }
  gpu.return
}
gpu.func @zero(%a: i32, %n: i32) kernel {
  %c0 = arith.constant 0 : i32
  %c4 = arith.constant 4 : i32
  %c16 = arith.constant 16 : i32
  %g_ix51 = gpu.block_id x
  %g = arith.index_cast %g_ix51 : index to i32
  %l_ix52 = gpu.thread_id x
  %l = arith.index_cast %l_ix52 : index to i32
  %b0 = arith.muli %g, %c16 : i32
  %i = arith.addi %b0, %l : i32
  %i4 = arith.muli %i, %c4 : i32
  %inside = arith.cmpi slt, %i4, %n : i32
  scf.if %inside {
    %o = arith.muli %i, %c16 : i32
    %at = arith.addi %a, %o : i32
    %z = vector.from_elements %c0, %c0, %c0, %c0 : vector<4xi32>
    %st_p53 = llvm.inttoptr %at : i32 to !llvm.ptr<1>
    llvm.store %z, %st_p53 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr<1>
  }
  gpu.return
}
gpu.func @fill(%a: i32, %n: i32, %v: i32) kernel {
  %c4 = arith.constant 4 : i32
  %c16 = arith.constant 16 : i32
  %g_ix54 = gpu.block_id x
  %g = arith.index_cast %g_ix54 : index to i32
  %l_ix55 = gpu.thread_id x
  %l = arith.index_cast %l_ix55 : index to i32
  %b0 = arith.muli %g, %c16 : i32
  %i = arith.addi %b0, %l : i32
  %i4 = arith.muli %i, %c4 : i32
  %inside = arith.cmpi slt, %i4, %n : i32
  scf.if %inside {
    %o = arith.muli %i, %c16 : i32
    %at = arith.addi %a, %o : i32
    %w = vector.from_elements %v, %v, %v, %v : vector<4xi32>
    %st_p56 = llvm.inttoptr %at : i32 to !llvm.ptr<1>
    llvm.store %w, %st_p56 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr<1>
  }
  gpu.return
}
}
}
