// acgpu's crates/intel/driver/src/fine/fine.mlir in upstream dialects.
module attributes {gpu.container_module} {
gpu.module @shaders [#xevm.target<chip = "ptl">] {
gpu.func @fine(%rows: i32, %cmds: i32, %depth: i32, %attrs: i32, %alphas: i32, %out: i32, %stack: i32, %wd: i32) kernel {
  %tx_ix1 = gpu.block_id x
  %tx = arith.index_cast %tx_ix1 : index to i32
  %ty_ix2 = gpu.block_id y
  %ty = arith.index_cast %ty_ix2 : index to i32
  %l_ix3 = gpu.thread_id x
  %l = arith.index_cast %l_ix3 : index to i32
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c2 = arith.constant 2 : i32
  %c3 = arith.constant 3 : i32
  %c4 = arith.constant 4 : i32
  %c7 = arith.constant 7 : i32
  %c8 = arith.constant 8 : i32
  %c16 = arith.constant 16 : i32
  %c24 = arith.constant 24 : i32
  %c255 = arith.constant 255 : i32
  %cffff = arith.constant 65535 : i32
  %none = arith.constant -1 : i32
  %c6 = arith.constant 6 : i32
  %cattr = arith.constant 80 : i32
  %width = arith.andi %wd, %cffff : i32
  %maxd = arith.shrui %wd, %c16 : i32
  %tiles = arith.shrui %width, %c2 : i32
  %ti0 = arith.muli %ty, %tiles : i32
  %ti = arith.addi %ti0, %tx : i32
  %tslot = arith.muli %ti, %maxd : i32
  %x0 = arith.muli %tx, %c4 : i32
  %col = arith.shrui %l, %c2 : i32
  %r = arith.andi %l, %c3 : i32
  %x = arith.addi %x0, %col : i32
  %y0 = arith.muli %ty, %c4 : i32
  %y = arith.addi %y0, %r : i32
  %bucket = arith.shrui %x0, %c7 : i32
  %c127 = arith.constant 127 : i32
  %w127 = arith.addi %width, %c127 : i32
  %buckets = arith.shrui %w127, %c7 : i32
  %rb0 = arith.muli %ty, %buckets : i32
  %rb = arith.addi %rb0, %bucket : i32
  %roff = arith.muli %rb, %c16 : i32
  %rat = arith.addi %rows, %roff : i32
  %row_p4 = llvm.inttoptr %rat : i32 to !llvm.ptr<1>
  %row = llvm.load %row_p4 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xi32>
  %cfirst = vector.extract %row[0] : i32 from vector<4xi32>
  %cn = vector.extract %row[1] : i32 from vector<4xi32>
  %dfirst = vector.extract %row[2] : i32 from vector<4xi32>
  %dn = vector.extract %row[3] : i32 from vector<4xi32>
  %dres:2 = scf.for %k = %c0 to %dn step %c1 iter_args(%d = %c0, %da = %none) -> (i32, i32) : i32 {
    %e = arith.addi %dfirst, %k : i32
    %eoff = arith.muli %e, %c8 : i32
    %eat = arith.addi %depth, %eoff : i32
    %dv_p5 = llvm.inttoptr %eat : i32 to !llvm.ptr<1>
    %dv = llvm.load %dv_p5 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<2xi32>
    %range = vector.extract %dv[0] : i32 from vector<2xi32>
    %ai = vector.extract %dv[1] : i32 from vector<2xi32>
    %bs = arith.andi %range, %cffff : i32
    %be = arith.shrui %range, %c16 : i32
    %ge = arith.cmpi sge, %bucket, %bs : i32
    %lt = arith.cmpi slt, %bucket, %be : i32
    %ge1 = arith.extui %ge : i1 to i32
    %lt1 = arith.extui %lt : i1 to i32
    %both = arith.andi %ge1, %lt1 : i32
    %in = arith.cmpi ne, %both, %c0 : i32
    %next:2 = scf.if %in -> (i32, i32) {
      %aoff = arith.muli %ai, %cattr : i32
      %aat = arith.addi %attrs, %aoff : i32
      %av_p6 = llvm.inttoptr %aat : i32 to !llvm.ptr<1>
      %av = llvm.load %av_p6 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<2xi32>
      %id = vector.extract %av[1] : i32 from vector<2xi32>
      scf.yield %id, %ai : i32, i32
    } else {
      scf.yield %d, %da : i32, i32
    }
    scf.yield %next#0, %next#1 : i32, i32
  }
  %covered = arith.cmpi ne, %dres#1, %none : i32
  %dcolor = scf.if %covered -> (i32) {
    %aoff = arith.muli %dres#1, %cattr : i32
    %aat = arith.addi %attrs, %aoff : i32
    %av_p7 = llvm.inttoptr %aat : i32 to !llvm.ptr<1>
    %av = llvm.load %av_p7 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xi32>
    %color = vector.extract %av[0] : i32 from vector<4xi32>
    %pkind = vector.extract %av[2] : i32 from vector<4xi32>
    %c = func.call @paint(%attrs, %aat, %pkind, %color, %x, %y) : (i32, i32, i32, i32, i32, i32) -> i32
    scf.yield %c : i32
  } else {
    scf.yield %c0 : i32
  }
  %c0px:4 = func.call @unpack(%dcolor) : (i32) -> (i32, i32, i32, i32)
  %px:5 = scf.for %k = %c0 to %cn step %c1 iter_args(%pr = %c0px#0, %pg = %c0px#1, %pb = %c0px#2, %pa = %c0px#3, %dep = %c0) -> (i32, i32, i32, i32, i32) : i32 {
    %e = arith.addi %cfirst, %k : i32
    %eoff = arith.muli %e, %c16 : i32
    %eat = arith.addi %cmds, %eoff : i32
    %cv_p8 = llvm.inttoptr %eat : i32 to !llvm.ptr<1>
    %cv = llvm.load %cv_p8 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xi32>
    %kind = vector.extract %cv[0] : i32 from vector<4xi32>
    %span = vector.extract %cv[1] : i32 from vector<4xi32>
    %al = vector.extract %cv[2] : i32 from vector<4xi32>
    %ai = vector.extract %cv[3] : i32 from vector<4xi32>
    %sx = arith.andi %span, %cffff : i32
    %sw = arith.shrui %span, %c16 : i32
    %se = arith.addi %sx, %sw : i32
    %aoff = arith.muli %ai, %cattr : i32
    %aat = arith.addi %attrs, %aoff : i32
    %av_p9 = llvm.inttoptr %aat : i32 to !llvm.ptr<1>
    %av = llvm.load %av_p9 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xi32>
    %color = vector.extract %av[0] : i32 from vector<4xi32>
    %id = vector.extract %av[1] : i32 from vector<4xi32>
    %pkind = vector.extract %av[2] : i32 from vector<4xi32>
    %ge = arith.cmpi sge, %x0, %sx : i32
    %lt = arith.cmpi slt, %x0, %se : i32
    %ge1 = arith.extui %ge : i1 to i32
    %lt1 = arith.extui %lt : i1 to i32
    %inside = arith.andi %ge1, %lt1 : i32
    %hasmask = arith.cmpi ne, %al, %none : i32
    %hm1 = arith.extui %hasmask : i1 to i32
    %readmask = arith.andi %hm1, %inside : i32
    %masked = arith.cmpi ne, %readmask, %c0 : i32
    %mm = scf.if %masked -> (i32) {
      %dx = arith.subi %x0, %sx : i32
      %dx4 = arith.muli %dx, %c4 : i32
      %o1 = arith.addi %alphas, %al : i32
      %o2 = arith.addi %o1, %dx4 : i32
      %mat = arith.addi %o2, %l : i32
      %m_p10 = llvm.inttoptr %mat : i32 to !llvm.ptr<1>
      %m_n11 = llvm.load %m_p10 {alignment = 1 : i64} : !llvm.ptr<1> -> i8
      %m = arith.extui %m_n11 : i8 to i32
      scf.yield %m : i32
    } else {
      scf.yield %c255 : i32
    }
    %dm1 = arith.subi %dep, %c1 : i32
    %st0 = arith.addi %tslot, %dm1 : i32
    %st1 = arith.muli %st0, %c16 : i32
    %st2 = arith.addi %st1, %l : i32
    %st3 = arith.muli %st2, %c4 : i32
    %under = arith.addi %stack, %st3 : i32
    %top0 = arith.addi %tslot, %dep : i32
    %top1 = arith.muli %top0, %c16 : i32
    %top2 = arith.addi %top1, %l : i32
    %top3 = arith.muli %top2, %c4 : i32
    %slot = arith.addi %stack, %top3 : i32
    %isfill = arith.cmpi eq, %kind, %c0 : i32
    %res:5 = scf.if %isfill -> (i32, i32, i32, i32, i32) {
      %vis = arith.cmpi sle, %dres#0, %id : i32
      %v1 = arith.extui %vis : i1 to i32
      %a3 = arith.andi %inside, %v1 : i32
      %go = arith.cmpi ne, %a3, %c0 : i32
      %f:4 = scf.if %go -> (i32, i32, i32, i32) {
        %src = func.call @paint(%attrs, %aat, %pkind, %color, %x, %y) : (i32, i32, i32, i32, i32, i32) -> i32
        %s:4 = func.call @unpack(%src) : (i32) -> (i32, i32, i32, i32)
        %mk:2 = func.call @mask(%attrs, %aat, %x, %y, %c255) : (i32, i32, i32, i32, i32) -> (i32, i32)
        %hasmk = arith.cmpi ne, %mk#0, %c0 : i32
        %pm:2 = scf.if %hasmk -> (i32, i1) {
          %t = arith.constant true
          %both = scf.if %masked -> (i32) {
            %n = func.call @scale(%mm, %mk#1) : (i32, i32) -> i32
            scf.yield %n : i32
          } else {
            scf.yield %mk#1 : i32
          }
          scf.yield %both, %t : i32, i1
        } else {
          scf.yield %mm, %masked : i32, i1
        }
        %o:4 = func.call @composite(%aat, %pr, %pg, %pb, %pa, %s#0, %s#1, %s#2, %s#3, %pm#0, %pm#1) : (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i1) -> (i32, i32, i32, i32)
        scf.yield %o#0, %o#1, %o#2, %o#3 : i32, i32, i32, i32
      } else {
        scf.yield %pr, %pg, %pb, %pa : i32, i32, i32, i32
      }
      scf.yield %f#0, %f#1, %f#2, %f#3, %dep : i32, i32, i32, i32, i32
    } else {
      %ispush = arith.cmpi eq, %kind, %c2 : i32
      %q:5 = scf.if %ispush -> (i32, i32, i32, i32, i32) {
        %packed = func.call @pack(%pr, %pg, %pb, %pa) : (i32, i32, i32, i32) -> i32
        %st_p12 = llvm.inttoptr %slot : i32 to !llvm.ptr<1>
        llvm.store %packed, %st_p12 {alignment = 4 : i64} : i32, !llvm.ptr<1>
        %dp = arith.addi %dep, %c1 : i32
        scf.yield %c0, %c0, %c0, %c0, %dp : i32, i32, i32, i32, i32
      } else {
        %ispop = arith.cmpi eq, %kind, %c3 : i32
        %t:5 = scf.if %ispop -> (i32, i32, i32, i32, i32) {
          %w_p13 = llvm.inttoptr %under : i32 to !llvm.ptr<1>
          %w = llvm.load %w_p13 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
          %u:4 = func.call @unpack(%w) : (i32) -> (i32, i32, i32, i32)
          scf.yield %u#0, %u#1, %u#2, %u#3, %dm1 : i32, i32, i32, i32, i32
        } else {
          %ins = arith.cmpi ne, %inside, %c0 : i32
          %lf:4 = scf.if %ins -> (i32, i32, i32, i32) {
            %or = func.call @scale(%pr, %color) : (i32, i32) -> i32
            %og = func.call @scale(%pg, %color) : (i32, i32) -> i32
            %ob = func.call @scale(%pb, %color) : (i32, i32) -> i32
            %oa = func.call @scale(%pa, %color) : (i32, i32) -> i32
            %lm:2 = func.call @mask(%attrs, %aat, %x, %y, %c0) : (i32, i32, i32, i32, i32) -> (i32, i32)
            %haslm = arith.cmpi ne, %lm#0, %c0 : i32
            %tt:4 = scf.if %haslm -> (i32, i32, i32, i32) {
              %mr = func.call @scale(%or, %lm#1) : (i32, i32) -> i32
              %mg = func.call @scale(%og, %lm#1) : (i32, i32) -> i32
              %mb = func.call @scale(%ob, %lm#1) : (i32, i32) -> i32
              %ma = func.call @scale(%oa, %lm#1) : (i32, i32) -> i32
              scf.yield %mr, %mg, %mb, %ma : i32, i32, i32, i32
            } else {
              scf.yield %or, %og, %ob, %oa : i32, i32, i32, i32
            }
            %tr = arith.addi %tt#0, %c0 : i32
            %tg = arith.addi %tt#1, %c0 : i32
            %tb = arith.addi %tt#2, %c0 : i32
            %ta = arith.addi %tt#3, %c0 : i32
            %w_p14 = llvm.inttoptr %under : i32 to !llvm.ptr<1>
            %w = llvm.load %w_p14 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
            %u:4 = func.call @unpack(%w) : (i32) -> (i32, i32, i32, i32)
            %o:4 = func.call @composite(%aat, %u#0, %u#1, %u#2, %u#3, %tr, %tg, %tb, %ta, %mm, %masked) : (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i1) -> (i32, i32, i32, i32)
            %packed = func.call @pack(%o#0, %o#1, %o#2, %o#3) : (i32, i32, i32, i32) -> i32
            %st_p15 = llvm.inttoptr %under : i32 to !llvm.ptr<1>
            llvm.store %packed, %st_p15 {alignment = 4 : i64} : i32, !llvm.ptr<1>
            scf.yield %tr, %tg, %tb, %ta : i32, i32, i32, i32
          } else {
            scf.yield %pr, %pg, %pb, %pa : i32, i32, i32, i32
          }
          scf.yield %lf#0, %lf#1, %lf#2, %lf#3, %dep : i32, i32, i32, i32, i32
        }
        scf.yield %t#0, %t#1, %t#2, %t#3, %t#4 : i32, i32, i32, i32, i32
      }
      scf.yield %q#0, %q#1, %q#2, %q#3, %q#4 : i32, i32, i32, i32, i32
    }
    scf.yield %res#0, %res#1, %res#2, %res#3, %res#4 : i32, i32, i32, i32, i32
  }
  %rgba = func.call @pack(%px#0, %px#1, %px#2, %px#3) : (i32, i32, i32, i32) -> i32
  %yw = arith.muli %y, %width : i32
  %i = arith.addi %yw, %x : i32
  %i4 = arith.muli %i, %c4 : i32
  %oat = arith.addi %out, %i4 : i32
  %st_p16 = llvm.inttoptr %oat : i32 to !llvm.ptr<1>
  llvm.store %rgba, %st_p16 {alignment = 4 : i64} : i32, !llvm.ptr<1>
  gpu.return
}
func.func private @over(%dr: i32, %dg: i32, %db: i32, %da: i32, %sr: i32, %sg: i32, %sb: i32, %sa: i32, %m: i32, %masked: i1) -> (i32, i32, i32, i32) {
  %c8 = arith.constant 8 : i32
  %c255 = arith.constant 255 : i32
  %r:4 = scf.if %masked -> (i32, i32, i32, i32) {
    %am = arith.muli %sa, %m : i32
    %am2 = arith.addi %am, %c255 : i32
    %am3 = arith.shrui %am2, %c8 : i32
    %inv = arith.subi %c255, %am3 : i32
    %r1 = arith.muli %dr, %inv : i32
    %r2 = arith.muli %sr, %m : i32
    %r3 = arith.addi %r1, %r2 : i32
    %r4 = arith.addi %r3, %c255 : i32
    %r5 = arith.shrui %r4, %c8 : i32
    %g1 = arith.muli %dg, %inv : i32
    %g2 = arith.muli %sg, %m : i32
    %g3 = arith.addi %g1, %g2 : i32
    %g4 = arith.addi %g3, %c255 : i32
    %g5 = arith.shrui %g4, %c8 : i32
    %b1 = arith.muli %db, %inv : i32
    %b2 = arith.muli %sb, %m : i32
    %b3 = arith.addi %b1, %b2 : i32
    %b4 = arith.addi %b3, %c255 : i32
    %b5 = arith.shrui %b4, %c8 : i32
    %q1 = arith.muli %da, %inv : i32
    %q2 = arith.muli %sa, %m : i32
    %q3 = arith.addi %q1, %q2 : i32
    %q4 = arith.addi %q3, %c255 : i32
    %q5 = arith.shrui %q4, %c8 : i32
    scf.yield %r5, %g5, %b5, %q5 : i32, i32, i32, i32
  } else {
    %inv = arith.subi %c255, %sa : i32
    %r1 = arith.muli %dr, %inv : i32
    %r2 = arith.addi %r1, %c255 : i32
    %r3 = arith.shrui %r2, %c8 : i32
    %r4 = arith.addi %r3, %sr : i32
    %g1 = arith.muli %dg, %inv : i32
    %g2 = arith.addi %g1, %c255 : i32
    %g3 = arith.shrui %g2, %c8 : i32
    %g4 = arith.addi %g3, %sg : i32
    %b1 = arith.muli %db, %inv : i32
    %b2 = arith.addi %b1, %c255 : i32
    %b3 = arith.shrui %b2, %c8 : i32
    %b4 = arith.addi %b3, %sb : i32
    %q1 = arith.muli %da, %inv : i32
    %q2 = arith.addi %q1, %c255 : i32
    %q3 = arith.shrui %q2, %c8 : i32
    %q4 = arith.addi %q3, %sa : i32
    scf.yield %r4, %g4, %b4, %q4 : i32, i32, i32, i32
  }
  return %r#0, %r#1, %r#2, %r#3 : i32, i32, i32, i32
}
func.func private @scale(%c: i32, %o: i32) -> i32 {
  %c8 = arith.constant 8 : i32
  %c255 = arith.constant 255 : i32
  %m = arith.muli %c, %o : i32
  %a = arith.addi %m, %c255 : i32
  %r = arith.shrui %a, %c8 : i32
  return %r : i32
}
func.func private @pack(%r: i32, %g: i32, %b: i32, %a: i32) -> i32 {
  %c8 = arith.constant 8 : i32
  %c16 = arith.constant 16 : i32
  %c24 = arith.constant 24 : i32
  %g8 = arith.shli %g, %c8 : i32
  %b16 = arith.shli %b, %c16 : i32
  %a24 = arith.shli %a, %c24 : i32
  %rg = arith.ori %r, %g8 : i32
  %rgb = arith.ori %rg, %b16 : i32
  %rgba = arith.ori %rgb, %a24 : i32
  return %rgba : i32
}
func.func private @unpack(%w: i32) -> (i32, i32, i32, i32) {
  %c8 = arith.constant 8 : i32
  %c16 = arith.constant 16 : i32
  %c24 = arith.constant 24 : i32
  %c255 = arith.constant 255 : i32
  %r = arith.andi %w, %c255 : i32
  %g1 = arith.shrui %w, %c8 : i32
  %g = arith.andi %g1, %c255 : i32
  %b1 = arith.shrui %w, %c16 : i32
  %b = arith.andi %b1, %c255 : i32
  %a = arith.shrui %w, %c24 : i32
  return %r, %g, %b, %a : i32, i32, i32, i32
}
func.func private @gradient(%attrs: i32, %a: i32, %x: i32, %y: i32) -> i32 {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c2 = arith.constant 2 : i32
  %c3 = arith.constant 3 : i32
  %c4 = arith.constant 4 : i32
  %c16 = arith.constant 16 : i32
  %c32 = arith.constant 32 : i32
  %c48 = arith.constant 48 : i32
  %cffff = arith.constant 65535 : i32
  %f0 = arith.constant 0.0 : f32
  %f1 = arith.constant 1.0 : f32
  %fm1 = arith.constant -1.0 : f32
  %f2 = arith.constant 2.0 : f32
  %fh = arith.constant 0.5 : f32
  %v_p17 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
  %v = llvm.load %v_p17 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xi32>
  %lut = vector.extract %v[0] : i32 from vector<4xi32>
  %kind = vector.extract %v[2] : i32 from vector<4xi32>
  %scb = vector.extract %v[3] : i32 from vector<4xi32>
  %a16 = arith.addi %a, %c16 : i32
  %w_p18 = llvm.inttoptr %a16 : i32 to !llvm.ptr<1>
  %w = llvm.load %w_p18 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xi32>
  %p0b = vector.extract %w[0] : i32 from vector<4xi32>
  %xab = vector.extract %w[1] : i32 from vector<4xi32>
  %yab = vector.extract %w[2] : i32 from vector<4xi32>
  %eo = vector.extract %w[3] : i32 from vector<4xi32>
  %scale = arith.bitcast %scb : i32 to f32
  %p0 = arith.bitcast %p0b : i32 to f32
  %xa = arith.bitcast %xab : i32 to f32
  %ya = arith.bitcast %yab : i32 to f32
  %extend = arith.andi %eo, %c3 : i32
  %oxs = arith.shrui %eo, %c2 : i32
  %ox = arith.andi %oxs, %cffff : i32
  %oy0 = arith.shrui %eo, %c16 : i32
  %oy = arith.shrui %oy0, %c2 : i32
  %sx = arith.addi %x, %ox : i32
  %sy = arith.addi %y, %oy : i32
  %fx = arith.sitofp %sx : i32 to f32
  %fy = arith.sitofp %sy : i32 to f32
  %t0 = math.fma %fy, %ya, %p0 : f32
  %px = math.fma %fx, %xa, %t0 : f32
  %linear = arith.cmpi eq, %kind, %c1 : i32
  %t = scf.if %linear -> (f32) {
    scf.yield %px : f32
  } else {
    %a32 = arith.addi %a, %c32 : i32
    %u_p19 = llvm.inttoptr %a32 : i32 to !llvm.ptr<1>
    %u = llvm.load %u_p19 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xi32>
    %q0b = vector.extract %u[0] : i32 from vector<4xi32>
    %xyb = vector.extract %u[1] : i32 from vector<4xi32>
    %yyb = vector.extract %u[2] : i32 from vector<4xi32>
    %rk = vector.extract %u[3] : i32 from vector<4xi32>
    %a48 = arith.addi %a, %c48 : i32
    %z_p20 = llvm.inttoptr %a48 : i32 to !llvm.ptr<1>
    %z = llvm.load %z_p20 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<2xi32>
    %k0b = vector.extract %z[0] : i32 from vector<2xi32>
    %k1b = vector.extract %z[1] : i32 from vector<2xi32>
    %q0 = arith.bitcast %q0b : i32 to f32
    %xy = arith.bitcast %xyb : i32 to f32
    %yy = arith.bitcast %yyb : i32 to f32
    %k0 = arith.bitcast %k0b : i32 to f32
    %k1 = arith.bitcast %k1b : i32 to f32
    %s0 = math.fma %fy, %yy, %q0 : f32
    %py = math.fma %fx, %xy, %s0 : f32
    %yy2 = arith.mulf %py, %py : f32
    %rr = math.fma %px, %px, %yy2 : f32
    %issweep = arith.cmpi eq, %kind, %c3 : i32
    %r = scf.if %issweep -> (f32) {
      %fq = arith.constant 0.25 : f32
      %pa0 = arith.constant -7.0547382e-3 : f32
      %pa1 = arith.constant 2.476102e-2 : f32
      %pa2 = arith.constant -5.185397e-2 : f32
      %pa3 = arith.constant 0.15912117 : f32
      %tau = arith.constant 6.28318548 : f32
      %ax = math.absf %px : f32
      %ay = math.absf %py : f32
      %mn = arith.minnumf %ax, %ay : f32
      %mx = arith.maxnumf %ax, %ay : f32
      %slope = arith.divf %mn, %mx : f32
      %sq = arith.mulf %slope, %slope : f32
      %pa = math.fma %pa0, %sq, %pa1 : f32
      %pb = math.fma %pa, %sq, %pa2 : f32
      %pc = math.fma %pb, %sq, %pa3 : f32
      %phi0 = arith.mulf %slope, %pc : f32
      %l1 = arith.cmpf olt, %ax, %ay : f32
      %q1 = arith.subf %fq, %phi0 : f32
      %phi1 = arith.select %l1, %q1, %phi0 : f32
      %l2 = arith.cmpf olt, %px, %f0 : f32
      %q2 = arith.subf %fh, %phi1 : f32
      %phi2 = arith.select %l2, %q2, %phi1 : f32
      %l3 = arith.cmpf olt, %py, %f0 : f32
      %q3 = arith.subf %f1, %phi2 : f32
      %phi3 = arith.select %l3, %q3, %phi2 : f32
      %ord = arith.cmpf oeq, %phi3, %phi3 : f32
      %phi = arith.select %ord, %phi3, %f0 : f32
      %ang = arith.mulf %phi, %tau : f32
      %d = arith.subf %ang, %k0 : f32
      %ts = arith.mulf %d, %k1 : f32
      scf.yield %ts : f32
    } else {
    %radius = math.sqrt %rr : f32
    %variant = arith.andi %rk, %c3 : i32
    %plain = arith.cmpi eq, %variant, %c0 : i32
    %rad = scf.if %plain -> (f32) {
      %tr = math.fma %radius, %k1, %k0 : f32
      scf.yield %tr : f32
    } else {
    %isstrip = arith.cmpi eq, %variant, %c2 : i32
    %rs = scf.if %isstrip -> (f32) {
      %ny = arith.negf %py : f32
      %p1 = math.fma %py, %ny, %k0 : f32
      %sq1 = math.sqrt %p1 : f32
      %ts1 = arith.addf %px, %sq1 : f32
      %neg1 = arith.cmpf olt, %p1, %f0 : f32
      %nanb = arith.constant 2143289344 : i32
      %nan = arith.bitcast %nanb : i32 to f32
      %tst = arith.select %neg1, %nan, %ts1 : f32
      scf.yield %tst : f32
    } else {
      %nfp0 = arith.negf %k0 : f32
      %flags = arith.shrui %rk, %c4 : i32
      %fsh = arith.shrui %flags, %c4 : i32
      %formula = arith.andi %fsh, %c3 : i32
      %isf0 = arith.cmpi eq, %formula, %c0 : i32
      %tf = scf.if %isf0 -> (f32) {
        %w0 = math.fma %px, %nfp0, %radius : f32
        scf.yield %w0 : f32
      } else {
        %isf1 = arith.cmpi eq, %formula, %c1 : i32
        %tf1 = scf.if %isf1 -> (f32) {
          %yx = arith.divf %py, %px : f32
          %w1 = math.fma %py, %yx, %px : f32
          scf.yield %w1 : f32
        } else {
          %nyy = arith.negf %yy2 : f32
          %r2 = math.fma %px, %px, %nyy : f32
          %rad2 = math.sqrt %r2 : f32
          %isf2 = arith.cmpi eq, %formula, %c2 : i32
          %nrad2 = arith.negf %rad2 : f32
          %sr = arith.select %isf2, %nrad2, %rad2 : f32
          %w2 = math.fma %px, %nfp0, %sr : f32
          scf.yield %w2 : f32
        }
        scf.yield %tf1 : f32
      }
      %c8f = arith.constant 8 : i32
      %fund = arith.andi %flags, %c8f : i32
      %isund = arith.cmpi ne, %fund, %c0 : i32
      %le0 = arith.cmpf ole, %tf, %f0 : f32
      %nanb2 = arith.constant 2143289344 : i32
      %nan2 = arith.bitcast %nanb2 : i32 to f32
      %tfd = arith.select %le0, %nan2, %tf : f32
      %tfm = arith.select %isund, %tfd, %tf : f32
      %fneg = arith.andi %flags, %c1 : i32
      %isneg = arith.cmpi ne, %fneg, %c0 : i32
      %t1 = scf.if %isneg -> (f32) {
        %n = arith.mulf %fm1, %tfm : f32
        scf.yield %n : f32
      } else {
        scf.yield %tfm : f32
      }
      %fadd = arith.andi %flags, %c2 : i32
      %isadd = arith.cmpi ne, %fadd, %c0 : i32
      %t2 = scf.if %isadd -> (f32) {
        %n = arith.addf %t1, %k1 : f32
        scf.yield %n : f32
      } else {
        scf.yield %t1 : f32
      }
      %fsw = arith.andi %flags, %c4 : i32
      %issw = arith.cmpi ne, %fsw, %c0 : i32
      %t3 = scf.if %issw -> (f32) {
        %n = arith.subf %f1, %t2 : f32
        scf.yield %n : f32
      } else {
        scf.yield %t2 : f32
      }
      scf.yield %t3 : f32
    }
    scf.yield %rs : f32
    }
    scf.yield %rad : f32
    }
    scf.yield %r : f32
  }
  %pad = arith.cmpi eq, %extend, %c0 : i32
  %te = scf.if %pad -> (f32) {
    %m = arith.maxnumf %t, %f0 : f32
    %n = arith.minnumf %m, %f1 : f32
    scf.yield %n : f32
  } else {
    %rep = arith.cmpi eq, %extend, %c1 : i32
    %r = scf.if %rep -> (f32) {
      %fl = math.floor %t : f32
      %d = arith.subf %t, %fl : f32
      %fl2 = math.floor %d : f32
      %fr = arith.subf %d, %fl2 : f32
      scf.yield %fr : f32
    } else {
      %t1 = arith.subf %t, %f1 : f32
      %h = arith.mulf %t1, %fh : f32
      %hf = math.floor %h : f32
      %h2 = arith.mulf %f2, %hf : f32
      %u = arith.subf %t1, %h2 : f32
      %u1 = arith.subf %u, %f1 : f32
      %ab = math.absf %u1 : f32
      %m = arith.maxnumf %ab, %f0 : f32
      %n = arith.minnumf %m, %f1 : f32
      scf.yield %n : f32
    }
    scf.yield %r : f32
  }
  %c68 = arith.constant 68 : i32
  %a68 = arith.addi %a, %c68 : i32
  %lw_p21 = llvm.inttoptr %a68 : i32 to !llvm.ptr<1>
  %lw = llvm.load %lw_p21 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %c31 = arith.constant 31 : i32
  %undb = arith.shrui %lw, %c31 : i32
  %undefined = arith.cmpi ne, %undb, %c0 : i32
  %cmask = arith.constant 2147483647 : i32
  %last = arith.andi %lw, %cmask : i32
  %ts = arith.mulf %te, %scale : f32
  %idx0 = arith.fptoui %ts : f32 to i32
  %clamped = arith.minui %idx0, %last : i32
  %idx = arith.select %undefined, %clamped, %idx0 : i32
  %e = arith.addi %lut, %idx : i32
  %e4 = arith.muli %e, %c4 : i32
  %at = arith.addi %attrs, %e4 : i32
  %c_p22 = llvm.inttoptr %at : i32 to !llvm.ptr<1>
  %c = llvm.load %c_p22 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %isnan = arith.cmpf une, %t, %t : f32
  %cm = arith.select %isnan, %c0, %c : i32
  %out = arith.select %undefined, %cm, %c : i32
  return %out : i32
}
func.func private @paint(%attrs: i32, %a: i32, %kind: i32, %color: i32, %x: i32, %y: i32) -> i32 {
  %c0 = arith.constant 0 : i32
  %c4 = arith.constant 4 : i32
  %solid = arith.cmpi eq, %kind, %c0 : i32
  %c = scf.if %solid -> (i32) {
    scf.yield %color : i32
  } else {
    %c7 = arith.constant 7 : i32
    %isbox = arith.cmpi eq, %kind, %c7 : i32
    %isimage = arith.cmpi sge, %kind, %c4 : i32
    %p = scf.if %isbox -> (i32) {
      %bx = func.call @boxshadow(%attrs, %a, %x, %y) : (i32, i32, i32, i32) -> i32
      scf.yield %bx : i32
    } else {
    %pi = scf.if %isimage -> (i32) {
      %i = func.call @image(%attrs, %a, %x, %y) : (i32, i32, i32, i32) -> i32
      scf.yield %i : i32
    } else {
      %g = func.call @gradient(%attrs, %a, %x, %y) : (i32, i32, i32, i32) -> i32
      scf.yield %g : i32
    }
    scf.yield %pi : i32
    }
    scf.yield %p : i32
  }
  return %c : i32
}
func.func private @extend(%v: f32, %mode: i32, %max: f32, %inv: f32) -> f32 {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %f0 = arith.constant 0.0 : f32
  %f1 = arith.constant 1.0 : f32
  %fh = arith.constant 0.5 : f32
  %pad = arith.cmpi eq, %mode, %c0 : i32
  %r = scf.if %pad -> (f32) {
    %m1 = arith.subf %max, %f1 : f32
    %a = arith.minnumf %v, %m1 : f32
    %b = arith.maxnumf %a, %f0 : f32
    scf.yield %b : f32
  } else {
    %rep = arith.cmpi eq, %mode, %c1 : i32
    %fl = math.floor %v : f32
    %w = scf.if %rep -> (f32) {
      %m = func.call @euclid(%fl, %max, %inv) : (f32, f32, f32) -> f32
      scf.yield %m : f32
    } else {
      %period = arith.addf %max, %max : f32
      %hinv = arith.mulf %inv, %fh : f32
      %m = func.call @euclid(%fl, %period, %hinv) : (f32, f32, f32) -> f32
      %ge = arith.cmpf oge, %m, %max : f32
      %p1 = arith.subf %period, %f1 : f32
      %back = arith.subf %p1, %m : f32
      %s = arith.select %ge, %back, %m : f32
      scf.yield %s : f32
    }
    scf.yield %w : f32
  }
  return %r : f32
}
func.func private @euclid(%t: f32, %m: f32, %inv: f32) -> f32 {
  %f0 = arith.constant 0.0 : f32
  %ti = arith.mulf %t, %inv : f32
  %q = math.roundeven %ti : f32
  %nm = arith.negf %m : f32
  %r = math.fma %q, %nm, %t : f32
  %neg = arith.cmpf olt, %r, %f0 : f32
  %rm = arith.addf %r, %m : f32
  %s = arith.select %neg, %rm, %r : f32
  return %s : f32
}
func.func private @image(%attrs: i32, %a: i32, %x: i32, %y: i32) -> i32 {
  %c2 = arith.constant 2 : i32
  %c3 = arith.constant 3 : i32
  %c4 = arith.constant 4 : i32
  %c16 = arith.constant 16 : i32
  %c32 = arith.constant 32 : i32
  %c48 = arith.constant 48 : i32
  %cffff = arith.constant 65535 : i32
  %v_p23 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
  %v = llvm.load %v_p23 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xi32>
  %texels = vector.extract %v[0] : i32 from vector<4xi32>
  %wh = vector.extract %v[3] : i32 from vector<4xi32>
  %c68 = arith.constant 68 : i32
  %a68 = arith.addi %a, %c68 : i32
  %stride_p24 = llvm.inttoptr %a68 : i32 to !llvm.ptr<1>
  %stride = llvm.load %stride_p24 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %a16 = arith.addi %a, %c16 : i32
  %w_p25 = llvm.inttoptr %a16 : i32 to !llvm.ptr<1>
  %w = llvm.load %w_p25 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xi32>
  %a32 = arith.addi %a, %c32 : i32
  %u_p26 = llvm.inttoptr %a32 : i32 to !llvm.ptr<1>
  %u = llvm.load %u_p26 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xi32>
  %a48 = arith.addi %a, %c48 : i32
  %z_p27 = llvm.inttoptr %a48 : i32 to !llvm.ptr<1>
  %z = llvm.load %z_p27 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<2xi32>
  %p0x = vector.extract %w[0] : i32 from vector<4xi32>
  %xax = vector.extract %w[1] : i32 from vector<4xi32>
  %yax = vector.extract %w[2] : i32 from vector<4xi32>
  %eo = vector.extract %w[3] : i32 from vector<4xi32>
  %p0y = vector.extract %u[0] : i32 from vector<4xi32>
  %xay = vector.extract %u[1] : i32 from vector<4xi32>
  %yay = vector.extract %u[2] : i32 from vector<4xi32>
  %eyw = vector.extract %u[3] : i32 from vector<4xi32>
  %ey = arith.andi %eyw, %c3 : i32
  %wib = vector.extract %z[0] : i32 from vector<2xi32>
  %hib = vector.extract %z[1] : i32 from vector<2xi32>
  %wi = arith.andi %wh, %cffff : i32
  %hi = arith.shrui %wh, %c16 : i32
  %ex = arith.andi %eo, %c3 : i32
  %oxs = arith.shrui %eo, %c2 : i32
  %ox = arith.andi %oxs, %cffff : i32
  %oy0 = arith.shrui %eo, %c16 : i32
  %oy = arith.shrui %oy0, %c2 : i32
  %sx = arith.addi %x, %ox : i32
  %sy = arith.addi %y, %oy : i32
  %fx = arith.sitofp %sx : i32 to f32
  %fy = arith.sitofp %sy : i32 to f32
  %q0x = arith.bitcast %p0x : i32 to f32
  %q1x = arith.bitcast %xax : i32 to f32
  %q2x = arith.bitcast %yax : i32 to f32
  %q0y = arith.bitcast %p0y : i32 to f32
  %q1y = arith.bitcast %xay : i32 to f32
  %q2y = arith.bitcast %yay : i32 to f32
  %t0 = math.fma %fy, %q2x, %q0x : f32
  %px = math.fma %fx, %q1x, %t0 : f32
  %s0 = math.fma %fy, %q2y, %q0y : f32
  %py = math.fma %fx, %q1y, %s0 : f32
  %wf = arith.uitofp %wi : i32 to f32
  %hf = arith.uitofp %hi : i32 to f32
  %winv = arith.bitcast %wib : i32 to f32
  %hinv = arith.bitcast %hib : i32 to f32
  %kind = vector.extract %v[2] : i32 from vector<4xi32>
  %c5 = arith.constant 5 : i32
  %bilinear = arith.cmpi eq, %kind, %c5 : i32
  %c6 = arith.constant 6 : i32
  %bicubic = arith.cmpi eq, %kind, %c6 : i32
  %c = scf.if %bicubic -> (i32) {
    %bc = func.call @bicubic(%attrs, %texels, %stride, %px, %py, %ex, %ey, %wf, %winv, %hf, %hinv) : (i32, i32, i32, f32, f32, i32, i32, f32, f32, f32, f32) -> i32
    scf.yield %bc : i32
  } else {
  %cl = scf.if %bilinear -> (i32) {
    %fh = arith.constant 0.5 : f32
    %f1 = arith.constant 1.0 : f32
    %f255 = arith.constant 255.0 : f32
    %c255 = arith.constant 255 : i32
    %xs = arith.addf %px, %fh : f32
    %ys = arith.addf %py, %fh : f32
    %xb = math.floor %xs : f32
    %yb = math.floor %ys : f32
    %xfr = arith.subf %xs, %xb : f32
    %yfr = arith.subf %ys, %yb : f32
    %fxf = math.fma %xfr, %f255, %fh : f32
    %fyf = math.fma %yfr, %f255, %fh : f32
    %fx_s1 = arith.fptoui %fxf : f32 to i32
    %fy_s1 = arith.fptoui %fyf : f32 to i32
    %fxi = arith.subi %c255, %fx_s1 : i32
    %fyi = arith.subi %c255, %fy_s1 : i32
    %xb1 = arith.subf %xb, %f1 : f32
    %yb1 = arith.subf %yb, %f1 : f32
    %x1 = func.call @extend(%xb1, %ex, %wf, %winv) : (f32, i32, f32, f32) -> f32
    %x2 = func.call @extend(%xb, %ex, %wf, %winv) : (f32, i32, f32, f32) -> f32
    %y1 = func.call @extend(%yb1, %ey, %hf, %hinv) : (f32, i32, f32, f32) -> f32
    %y2 = func.call @extend(%yb, %ey, %hf, %hinv) : (f32, i32, f32, f32) -> f32
    %p00 = func.call @texel(%attrs, %texels, %stride, %x1, %y1) : (i32, i32, i32, f32, f32) -> i32
    %p10 = func.call @texel(%attrs, %texels, %stride, %x2, %y1) : (i32, i32, i32, f32, f32) -> i32
    %p01 = func.call @texel(%attrs, %texels, %stride, %x1, %y2) : (i32, i32, i32, f32, f32) -> i32
    %p11 = func.call @texel(%attrs, %texels, %stride, %x2, %y2) : (i32, i32, i32, f32, f32) -> i32
    %a_s1:4 = func.call @unpack(%p00) : (i32) -> (i32, i32, i32, i32)
    %b:4 = func.call @unpack(%p10) : (i32) -> (i32, i32, i32, i32)
    %e:4 = func.call @unpack(%p01) : (i32) -> (i32, i32, i32, i32)
    %f:4 = func.call @unpack(%p11) : (i32) -> (i32, i32, i32, i32)
    %r = func.call @bilerp(%a_s1#0, %b#0, %e#0, %f#0, %fx_s1, %fxi, %fy_s1, %fyi) : (i32, i32, i32, i32, i32, i32, i32, i32) -> i32
    %g = func.call @bilerp(%a_s1#1, %b#1, %e#1, %f#1, %fx_s1, %fxi, %fy_s1, %fyi) : (i32, i32, i32, i32, i32, i32, i32, i32) -> i32
    %bl = func.call @bilerp(%a_s1#2, %b#2, %e#2, %f#2, %fx_s1, %fxi, %fy_s1, %fyi) : (i32, i32, i32, i32, i32, i32, i32, i32) -> i32
    %al = func.call @bilerp(%a_s1#3, %b#3, %e#3, %f#3, %fx_s1, %fxi, %fy_s1, %fyi) : (i32, i32, i32, i32, i32, i32, i32, i32) -> i32
    %rgba = func.call @pack(%r, %g, %bl, %al) : (i32, i32, i32, i32) -> i32
    scf.yield %rgba : i32
  } else {
    %ixf = func.call @extend(%px, %ex, %wf, %winv) : (f32, i32, f32, f32) -> f32
    %iyf = func.call @extend(%py, %ey, %hf, %hinv) : (f32, i32, f32, f32) -> f32
    %t = func.call @texel(%attrs, %texels, %stride, %ixf, %iyf) : (i32, i32, i32, f32, f32) -> i32
    scf.yield %t : i32
  }
  scf.yield %cl : i32
  }
  %tm2 = arith.shrui %eyw, %c2 : i32
  %tmode = arith.andi %tm2, %c3 : i32
  %c0t = arith.constant 0 : i32
  %tinted = arith.cmpi ne, %tmode, %c0t : i32
  %ct = scf.if %tinted -> (i32) {
    %c64 = arith.constant 64 : i32
    %tat = arith.addi %a, %c64 : i32
    %tint_p28 = llvm.inttoptr %tat : i32 to !llvm.ptr<1>
    %tint = llvm.load %tint_p28 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %t:4 = func.call @unpack(%tint) : (i32) -> (i32, i32, i32, i32)
    %p:4 = func.call @unpack(%c) : (i32) -> (i32, i32, i32, i32)
    %c1t = arith.constant 1 : i32
    %am = arith.cmpi eq, %tmode, %c1t : i32
    %q:4 = scf.if %am -> (i32, i32, i32, i32) {
      %r = func.call @scale(%t#0, %p#3) : (i32, i32) -> i32
      %g = func.call @scale(%t#1, %p#3) : (i32, i32) -> i32
      %bb = func.call @scale(%t#2, %p#3) : (i32, i32) -> i32
      %aa = func.call @scale(%t#3, %p#3) : (i32, i32) -> i32
      scf.yield %r, %g, %bb, %aa : i32, i32, i32, i32
    } else {
      %r = func.call @scale(%p#0, %t#0) : (i32, i32) -> i32
      %g = func.call @scale(%p#1, %t#1) : (i32, i32) -> i32
      %bb = func.call @scale(%p#2, %t#2) : (i32, i32) -> i32
      %aa = func.call @scale(%p#3, %t#3) : (i32, i32) -> i32
      scf.yield %r, %g, %bb, %aa : i32, i32, i32, i32
    }
    %w_s1 = func.call @pack(%q#0, %q#1, %q#2, %q#3) : (i32, i32, i32, i32) -> i32
    scf.yield %w_s1 : i32
  } else {
    scf.yield %c : i32
  }
  return %ct : i32
}
func.func private @texel(%attrs: i32, %texels: i32, %stride: i32, %x: f32, %y: f32) -> i32 {
  %c4 = arith.constant 4 : i32
  %c31 = arith.constant 31 : i32
  %cmask = arith.constant 2147483647 : i32
  %w = arith.andi %stride, %cmask : i32
  %ix = arith.fptoui %x : f32 to i32
  %iy = arith.fptoui %y : f32 to i32
  %row = arith.muli %iy, %w : i32
  %idx = arith.addi %row, %ix : i32
  %e4 = arith.muli %idx, %c4 : i32
  %base = arith.addi %attrs, %texels : i32
  %at = arith.addi %base, %e4 : i32
  %c_p29 = llvm.inttoptr %at : i32 to !llvm.ptr<1>
  %c = llvm.load %c_p29 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %sb = arith.shrui %stride, %c31 : i32
  %c0 = arith.constant 0 : i32
  %straight = arith.cmpi ne, %sb, %c0 : i32
  %out = scf.if %straight -> (i32) {
    %p:4 = func.call @unpack(%c) : (i32) -> (i32, i32, i32, i32)
    %c1 = arith.constant 1 : i32
    %c8 = arith.constant 8 : i32
    %c127 = arith.constant 127 : i32
    %r0 = arith.muli %p#0, %p#3 : i32
    %r1 = arith.addi %r0, %c127 : i32
    %r2 = arith.shrui %r1, %c8 : i32
    %r3 = arith.addi %r1, %c1 : i32
    %r4 = arith.addi %r3, %r2 : i32
    %r = arith.shrui %r4, %c8 : i32
    %g0 = arith.muli %p#1, %p#3 : i32
    %g1 = arith.addi %g0, %c127 : i32
    %g2 = arith.shrui %g1, %c8 : i32
    %g3 = arith.addi %g1, %c1 : i32
    %g4 = arith.addi %g3, %g2 : i32
    %g = arith.shrui %g4, %c8 : i32
    %b0 = arith.muli %p#2, %p#3 : i32
    %b1 = arith.addi %b0, %c127 : i32
    %b2 = arith.shrui %b1, %c8 : i32
    %b3 = arith.addi %b1, %c1 : i32
    %b4 = arith.addi %b3, %b2 : i32
    %b = arith.shrui %b4, %c8 : i32
    %q = func.call @pack(%r, %g, %b, %p#3) : (i32, i32, i32, i32) -> i32
    scf.yield %q : i32
  } else {
    scf.yield %c : i32
  }
  return %out : i32
}
func.func private @bilerp(%p00: i32, %p10: i32, %p01: i32, %p11: i32, %fx: i32, %fxi: i32, %fy: i32, %fyi: i32) -> i32 {
  %c8 = arith.constant 8 : i32
  %c255 = arith.constant 255 : i32
  %a0 = arith.muli %p00, %fxi : i32
  %a1 = arith.muli %p10, %fx : i32
  %a2 = arith.addi %a0, %a1 : i32
  %a3 = arith.addi %a2, %c255 : i32
  %ip1 = arith.shrui %a3, %c8 : i32
  %b0 = arith.muli %p01, %fxi : i32
  %b1 = arith.muli %p11, %fx : i32
  %b2 = arith.addi %b0, %b1 : i32
  %b3 = arith.addi %b2, %c255 : i32
  %ip2 = arith.shrui %b3, %c8 : i32
  %c0 = arith.muli %ip1, %fyi : i32
  %c1 = arith.muli %ip2, %fy : i32
  %c2 = arith.addi %c0, %c1 : i32
  %c3 = arith.addi %c2, %c255 : i32
  %r = arith.shrui %c3, %c8 : i32
  return %r : i32
}
func.func private @bicubic(%attrs: i32, %texels: i32, %w: i32, %px: f32, %py: f32, %ex: i32, %ey: i32, %wf: f32, %winv: f32, %hf: f32, %hinv: f32) -> i32 {
  %fh = arith.constant 0.5 : f32
  %f0 = arith.constant 0.0 : f32
  %f1 = arith.constant 1.0 : f32
  %f255 = arith.constant 255.0 : f32
  %k255i = arith.constant 998277249 : i32
  %k255 = arith.bitcast %k255i : i32 to f32
  %mf00i = arith.constant 1029934650 : i32
  %mf00 = arith.bitcast %mf00i : i32 to f32
  %mf01i = arith.constant -1090519040 : i32
  %mf01 = arith.bitcast %mf01i : i32 to f32
  %mf02i = arith.constant 1062557014 : i32
  %mf02 = arith.bitcast %mf02i : i32 to f32
  %mf03i = arith.constant -1094247310 : i32
  %mf03 = arith.bitcast %mf03i : i32 to f32
  %mf10i = arith.constant 1063489081 : i32
  %mf10 = arith.bitcast %mf10i : i32 to f32
  %mf11i = arith.constant 0 : i32
  %mf11 = arith.bitcast %mf11i : i32 to f32
  %mf12i = arith.constant -1073741825 : i32
  %mf12 = arith.bitcast %mf12i : i32 to f32
  %mf13i = arith.constant 1066751317 : i32
  %mf13 = arith.bitcast %mf13i : i32 to f32
  %mf20i = arith.constant 1029934650 : i32
  %mf20 = arith.bitcast %mf20i : i32 to f32
  %mf21i = arith.constant 1056964608 : i32
  %mf21 = arith.bitcast %mf21i : i32 to f32
  %mf22i = arith.constant 1069547518 : i32
  %mf22 = arith.bitcast %mf22i : i32 to f32
  %mf23i = arith.constant -1080732331 : i32
  %mf23 = arith.bitcast %mf23i : i32 to f32
  %mf30i = arith.constant 0 : i32
  %mf30 = arith.bitcast %mf30i : i32 to f32
  %mf31i = arith.constant 0 : i32
  %mf31 = arith.bitcast %mf31i : i32 to f32
  %mf32i = arith.constant -1096111445 : i32
  %mf32 = arith.bitcast %mf32i : i32 to f32
  %mf33i = arith.constant 1053236338 : i32
  %mf33 = arith.bitcast %mf33i : i32 to f32
  %xs = arith.addf %px, %fh : f32
  %xb = math.floor %xs : f32
  %xf = arith.subf %xs, %xb : f32
  %xw0a = math.fma %xf, %mf03, %mf02 : f32
  %xw0b = math.fma %xw0a, %xf, %mf01 : f32
  %xw0 = math.fma %xw0b, %xf, %mf00 : f32
  %xw1a = math.fma %xf, %mf13, %mf12 : f32
  %xw1b = math.fma %xw1a, %xf, %mf11 : f32
  %xw1 = math.fma %xw1b, %xf, %mf10 : f32
  %xw2a = math.fma %xf, %mf23, %mf22 : f32
  %xw2b = math.fma %xw2a, %xf, %mf21 : f32
  %xw2 = math.fma %xw2b, %xf, %mf20 : f32
  %xw3a = math.fma %xf, %mf33, %mf32 : f32
  %xw3b = math.fma %xw3a, %xf, %mf31 : f32
  %xw3 = math.fma %xw3b, %xf, %mf30 : f32
  %xo0 = arith.constant -2.0 : f32
  %xq0 = arith.addf %xb, %xo0 : f32
  %xp0 = func.call @extend(%xq0, %ex, %wf, %winv) : (f32, i32, f32, f32) -> f32
  %xo1 = arith.constant -1.0 : f32
  %xq1 = arith.addf %xb, %xo1 : f32
  %xp1 = func.call @extend(%xq1, %ex, %wf, %winv) : (f32, i32, f32, f32) -> f32
  %xo2 = arith.constant 0.0 : f32
  %xq2 = arith.addf %xb, %xo2 : f32
  %xp2 = func.call @extend(%xq2, %ex, %wf, %winv) : (f32, i32, f32, f32) -> f32
  %xo3 = arith.constant 1.0 : f32
  %xq3 = arith.addf %xb, %xo3 : f32
  %xp3 = func.call @extend(%xq3, %ex, %wf, %winv) : (f32, i32, f32, f32) -> f32
  %ys = arith.addf %py, %fh : f32
  %yb = math.floor %ys : f32
  %yf = arith.subf %ys, %yb : f32
  %yw0a = math.fma %yf, %mf03, %mf02 : f32
  %yw0b = math.fma %yw0a, %yf, %mf01 : f32
  %yw0 = math.fma %yw0b, %yf, %mf00 : f32
  %yw1a = math.fma %yf, %mf13, %mf12 : f32
  %yw1b = math.fma %yw1a, %yf, %mf11 : f32
  %yw1 = math.fma %yw1b, %yf, %mf10 : f32
  %yw2a = math.fma %yf, %mf23, %mf22 : f32
  %yw2b = math.fma %yw2a, %yf, %mf21 : f32
  %yw2 = math.fma %yw2b, %yf, %mf20 : f32
  %yw3a = math.fma %yf, %mf33, %mf32 : f32
  %yw3b = math.fma %yw3a, %yf, %mf31 : f32
  %yw3 = math.fma %yw3b, %yf, %mf30 : f32
  %yo0 = arith.constant -2.0 : f32
  %yq0 = arith.addf %yb, %yo0 : f32
  %yp0 = func.call @extend(%yq0, %ey, %hf, %hinv) : (f32, i32, f32, f32) -> f32
  %yo1 = arith.constant -1.0 : f32
  %yq1 = arith.addf %yb, %yo1 : f32
  %yp1 = func.call @extend(%yq1, %ey, %hf, %hinv) : (f32, i32, f32, f32) -> f32
  %yo2 = arith.constant 0.0 : f32
  %yq2 = arith.addf %yb, %yo2 : f32
  %yp2 = func.call @extend(%yq2, %ey, %hf, %hinv) : (f32, i32, f32, f32) -> f32
  %yo3 = arith.constant 1.0 : f32
  %yq3 = arith.addf %yb, %yo3 : f32
  %yp3 = func.call @extend(%yq3, %ey, %hf, %hinv) : (f32, i32, f32, f32) -> f32
  %ww0 = arith.mulf %xw0, %yw0 : f32
  %t0 = func.call @texel(%attrs, %texels, %w, %xp0, %yp0) : (i32, i32, i32, f32, f32) -> i32
  %u0:4 = func.call @unpack(%t0) : (i32) -> (i32, i32, i32, i32)
  %s0c0 = arith.uitofp %u0#0 : i32 to f32
  %a0c0 = math.fma %ww0, %s0c0, %f0 : f32
  %s0c1 = arith.uitofp %u0#1 : i32 to f32
  %a0c1 = math.fma %ww0, %s0c1, %f0 : f32
  %s0c2 = arith.uitofp %u0#2 : i32 to f32
  %a0c2 = math.fma %ww0, %s0c2, %f0 : f32
  %s0c3 = arith.uitofp %u0#3 : i32 to f32
  %a0c3 = math.fma %ww0, %s0c3, %f0 : f32
  %ww1 = arith.mulf %xw0, %yw1 : f32
  %t1 = func.call @texel(%attrs, %texels, %w, %xp0, %yp1) : (i32, i32, i32, f32, f32) -> i32
  %u1:4 = func.call @unpack(%t1) : (i32) -> (i32, i32, i32, i32)
  %s1c0 = arith.uitofp %u1#0 : i32 to f32
  %a1c0 = math.fma %ww1, %s1c0, %a0c0 : f32
  %s1c1 = arith.uitofp %u1#1 : i32 to f32
  %a1c1 = math.fma %ww1, %s1c1, %a0c1 : f32
  %s1c2 = arith.uitofp %u1#2 : i32 to f32
  %a1c2 = math.fma %ww1, %s1c2, %a0c2 : f32
  %s1c3 = arith.uitofp %u1#3 : i32 to f32
  %a1c3 = math.fma %ww1, %s1c3, %a0c3 : f32
  %ww2 = arith.mulf %xw0, %yw2 : f32
  %t2 = func.call @texel(%attrs, %texels, %w, %xp0, %yp2) : (i32, i32, i32, f32, f32) -> i32
  %u2:4 = func.call @unpack(%t2) : (i32) -> (i32, i32, i32, i32)
  %s2c0 = arith.uitofp %u2#0 : i32 to f32
  %a2c0 = math.fma %ww2, %s2c0, %a1c0 : f32
  %s2c1 = arith.uitofp %u2#1 : i32 to f32
  %a2c1 = math.fma %ww2, %s2c1, %a1c1 : f32
  %s2c2 = arith.uitofp %u2#2 : i32 to f32
  %a2c2 = math.fma %ww2, %s2c2, %a1c2 : f32
  %s2c3 = arith.uitofp %u2#3 : i32 to f32
  %a2c3 = math.fma %ww2, %s2c3, %a1c3 : f32
  %ww3 = arith.mulf %xw0, %yw3 : f32
  %t3 = func.call @texel(%attrs, %texels, %w, %xp0, %yp3) : (i32, i32, i32, f32, f32) -> i32
  %u3:4 = func.call @unpack(%t3) : (i32) -> (i32, i32, i32, i32)
  %s3c0 = arith.uitofp %u3#0 : i32 to f32
  %a3c0 = math.fma %ww3, %s3c0, %a2c0 : f32
  %s3c1 = arith.uitofp %u3#1 : i32 to f32
  %a3c1 = math.fma %ww3, %s3c1, %a2c1 : f32
  %s3c2 = arith.uitofp %u3#2 : i32 to f32
  %a3c2 = math.fma %ww3, %s3c2, %a2c2 : f32
  %s3c3 = arith.uitofp %u3#3 : i32 to f32
  %a3c3 = math.fma %ww3, %s3c3, %a2c3 : f32
  %ww4 = arith.mulf %xw1, %yw0 : f32
  %t4 = func.call @texel(%attrs, %texels, %w, %xp1, %yp0) : (i32, i32, i32, f32, f32) -> i32
  %u4:4 = func.call @unpack(%t4) : (i32) -> (i32, i32, i32, i32)
  %s4c0 = arith.uitofp %u4#0 : i32 to f32
  %a4c0 = math.fma %ww4, %s4c0, %a3c0 : f32
  %s4c1 = arith.uitofp %u4#1 : i32 to f32
  %a4c1 = math.fma %ww4, %s4c1, %a3c1 : f32
  %s4c2 = arith.uitofp %u4#2 : i32 to f32
  %a4c2 = math.fma %ww4, %s4c2, %a3c2 : f32
  %s4c3 = arith.uitofp %u4#3 : i32 to f32
  %a4c3 = math.fma %ww4, %s4c3, %a3c3 : f32
  %ww5 = arith.mulf %xw1, %yw1 : f32
  %t5 = func.call @texel(%attrs, %texels, %w, %xp1, %yp1) : (i32, i32, i32, f32, f32) -> i32
  %u5:4 = func.call @unpack(%t5) : (i32) -> (i32, i32, i32, i32)
  %s5c0 = arith.uitofp %u5#0 : i32 to f32
  %a5c0 = math.fma %ww5, %s5c0, %a4c0 : f32
  %s5c1 = arith.uitofp %u5#1 : i32 to f32
  %a5c1 = math.fma %ww5, %s5c1, %a4c1 : f32
  %s5c2 = arith.uitofp %u5#2 : i32 to f32
  %a5c2 = math.fma %ww5, %s5c2, %a4c2 : f32
  %s5c3 = arith.uitofp %u5#3 : i32 to f32
  %a5c3 = math.fma %ww5, %s5c3, %a4c3 : f32
  %ww6 = arith.mulf %xw1, %yw2 : f32
  %t6 = func.call @texel(%attrs, %texels, %w, %xp1, %yp2) : (i32, i32, i32, f32, f32) -> i32
  %u6:4 = func.call @unpack(%t6) : (i32) -> (i32, i32, i32, i32)
  %s6c0 = arith.uitofp %u6#0 : i32 to f32
  %a6c0 = math.fma %ww6, %s6c0, %a5c0 : f32
  %s6c1 = arith.uitofp %u6#1 : i32 to f32
  %a6c1 = math.fma %ww6, %s6c1, %a5c1 : f32
  %s6c2 = arith.uitofp %u6#2 : i32 to f32
  %a6c2 = math.fma %ww6, %s6c2, %a5c2 : f32
  %s6c3 = arith.uitofp %u6#3 : i32 to f32
  %a6c3 = math.fma %ww6, %s6c3, %a5c3 : f32
  %ww7 = arith.mulf %xw1, %yw3 : f32
  %t7 = func.call @texel(%attrs, %texels, %w, %xp1, %yp3) : (i32, i32, i32, f32, f32) -> i32
  %u7:4 = func.call @unpack(%t7) : (i32) -> (i32, i32, i32, i32)
  %s7c0 = arith.uitofp %u7#0 : i32 to f32
  %a7c0 = math.fma %ww7, %s7c0, %a6c0 : f32
  %s7c1 = arith.uitofp %u7#1 : i32 to f32
  %a7c1 = math.fma %ww7, %s7c1, %a6c1 : f32
  %s7c2 = arith.uitofp %u7#2 : i32 to f32
  %a7c2 = math.fma %ww7, %s7c2, %a6c2 : f32
  %s7c3 = arith.uitofp %u7#3 : i32 to f32
  %a7c3 = math.fma %ww7, %s7c3, %a6c3 : f32
  %ww8 = arith.mulf %xw2, %yw0 : f32
  %t8 = func.call @texel(%attrs, %texels, %w, %xp2, %yp0) : (i32, i32, i32, f32, f32) -> i32
  %u8:4 = func.call @unpack(%t8) : (i32) -> (i32, i32, i32, i32)
  %s8c0 = arith.uitofp %u8#0 : i32 to f32
  %a8c0 = math.fma %ww8, %s8c0, %a7c0 : f32
  %s8c1 = arith.uitofp %u8#1 : i32 to f32
  %a8c1 = math.fma %ww8, %s8c1, %a7c1 : f32
  %s8c2 = arith.uitofp %u8#2 : i32 to f32
  %a8c2 = math.fma %ww8, %s8c2, %a7c2 : f32
  %s8c3 = arith.uitofp %u8#3 : i32 to f32
  %a8c3 = math.fma %ww8, %s8c3, %a7c3 : f32
  %ww9 = arith.mulf %xw2, %yw1 : f32
  %t9 = func.call @texel(%attrs, %texels, %w, %xp2, %yp1) : (i32, i32, i32, f32, f32) -> i32
  %u9:4 = func.call @unpack(%t9) : (i32) -> (i32, i32, i32, i32)
  %s9c0 = arith.uitofp %u9#0 : i32 to f32
  %a9c0 = math.fma %ww9, %s9c0, %a8c0 : f32
  %s9c1 = arith.uitofp %u9#1 : i32 to f32
  %a9c1 = math.fma %ww9, %s9c1, %a8c1 : f32
  %s9c2 = arith.uitofp %u9#2 : i32 to f32
  %a9c2 = math.fma %ww9, %s9c2, %a8c2 : f32
  %s9c3 = arith.uitofp %u9#3 : i32 to f32
  %a9c3 = math.fma %ww9, %s9c3, %a8c3 : f32
  %ww10 = arith.mulf %xw2, %yw2 : f32
  %t10 = func.call @texel(%attrs, %texels, %w, %xp2, %yp2) : (i32, i32, i32, f32, f32) -> i32
  %u10:4 = func.call @unpack(%t10) : (i32) -> (i32, i32, i32, i32)
  %s10c0 = arith.uitofp %u10#0 : i32 to f32
  %a10c0 = math.fma %ww10, %s10c0, %a9c0 : f32
  %s10c1 = arith.uitofp %u10#1 : i32 to f32
  %a10c1 = math.fma %ww10, %s10c1, %a9c1 : f32
  %s10c2 = arith.uitofp %u10#2 : i32 to f32
  %a10c2 = math.fma %ww10, %s10c2, %a9c2 : f32
  %s10c3 = arith.uitofp %u10#3 : i32 to f32
  %a10c3 = math.fma %ww10, %s10c3, %a9c3 : f32
  %ww11 = arith.mulf %xw2, %yw3 : f32
  %t11 = func.call @texel(%attrs, %texels, %w, %xp2, %yp3) : (i32, i32, i32, f32, f32) -> i32
  %u11:4 = func.call @unpack(%t11) : (i32) -> (i32, i32, i32, i32)
  %s11c0 = arith.uitofp %u11#0 : i32 to f32
  %a11c0 = math.fma %ww11, %s11c0, %a10c0 : f32
  %s11c1 = arith.uitofp %u11#1 : i32 to f32
  %a11c1 = math.fma %ww11, %s11c1, %a10c1 : f32
  %s11c2 = arith.uitofp %u11#2 : i32 to f32
  %a11c2 = math.fma %ww11, %s11c2, %a10c2 : f32
  %s11c3 = arith.uitofp %u11#3 : i32 to f32
  %a11c3 = math.fma %ww11, %s11c3, %a10c3 : f32
  %ww12 = arith.mulf %xw3, %yw0 : f32
  %t12 = func.call @texel(%attrs, %texels, %w, %xp3, %yp0) : (i32, i32, i32, f32, f32) -> i32
  %u12:4 = func.call @unpack(%t12) : (i32) -> (i32, i32, i32, i32)
  %s12c0 = arith.uitofp %u12#0 : i32 to f32
  %a12c0 = math.fma %ww12, %s12c0, %a11c0 : f32
  %s12c1 = arith.uitofp %u12#1 : i32 to f32
  %a12c1 = math.fma %ww12, %s12c1, %a11c1 : f32
  %s12c2 = arith.uitofp %u12#2 : i32 to f32
  %a12c2 = math.fma %ww12, %s12c2, %a11c2 : f32
  %s12c3 = arith.uitofp %u12#3 : i32 to f32
  %a12c3 = math.fma %ww12, %s12c3, %a11c3 : f32
  %ww13 = arith.mulf %xw3, %yw1 : f32
  %t13 = func.call @texel(%attrs, %texels, %w, %xp3, %yp1) : (i32, i32, i32, f32, f32) -> i32
  %u13:4 = func.call @unpack(%t13) : (i32) -> (i32, i32, i32, i32)
  %s13c0 = arith.uitofp %u13#0 : i32 to f32
  %a13c0 = math.fma %ww13, %s13c0, %a12c0 : f32
  %s13c1 = arith.uitofp %u13#1 : i32 to f32
  %a13c1 = math.fma %ww13, %s13c1, %a12c1 : f32
  %s13c2 = arith.uitofp %u13#2 : i32 to f32
  %a13c2 = math.fma %ww13, %s13c2, %a12c2 : f32
  %s13c3 = arith.uitofp %u13#3 : i32 to f32
  %a13c3 = math.fma %ww13, %s13c3, %a12c3 : f32
  %ww14 = arith.mulf %xw3, %yw2 : f32
  %t14 = func.call @texel(%attrs, %texels, %w, %xp3, %yp2) : (i32, i32, i32, f32, f32) -> i32
  %u14:4 = func.call @unpack(%t14) : (i32) -> (i32, i32, i32, i32)
  %s14c0 = arith.uitofp %u14#0 : i32 to f32
  %a14c0 = math.fma %ww14, %s14c0, %a13c0 : f32
  %s14c1 = arith.uitofp %u14#1 : i32 to f32
  %a14c1 = math.fma %ww14, %s14c1, %a13c1 : f32
  %s14c2 = arith.uitofp %u14#2 : i32 to f32
  %a14c2 = math.fma %ww14, %s14c2, %a13c2 : f32
  %s14c3 = arith.uitofp %u14#3 : i32 to f32
  %a14c3 = math.fma %ww14, %s14c3, %a13c3 : f32
  %ww15 = arith.mulf %xw3, %yw3 : f32
  %t15 = func.call @texel(%attrs, %texels, %w, %xp3, %yp3) : (i32, i32, i32, f32, f32) -> i32
  %u15:4 = func.call @unpack(%t15) : (i32) -> (i32, i32, i32, i32)
  %s15c0 = arith.uitofp %u15#0 : i32 to f32
  %a15c0 = math.fma %ww15, %s15c0, %a14c0 : f32
  %s15c1 = arith.uitofp %u15#1 : i32 to f32
  %a15c1 = math.fma %ww15, %s15c1, %a14c1 : f32
  %s15c2 = arith.uitofp %u15#2 : i32 to f32
  %a15c2 = math.fma %ww15, %s15c2, %a14c2 : f32
  %s15c3 = arith.uitofp %u15#3 : i32 to f32
  %a15c3 = math.fma %ww15, %s15c3, %a14c3 : f32
  %v0 = arith.mulf %a15c0, %k255 : f32
  %v1 = arith.mulf %a15c1, %k255 : f32
  %v2 = arith.mulf %a15c2, %k255 : f32
  %v3 = arith.mulf %a15c3, %k255 : f32
  %m0a = arith.minnumf %v0, %v3 : f32
  %m0b = arith.minnumf %m0a, %f1 : f32
  %m0 = arith.maxnumf %m0b, %f0 : f32
  %q0f = math.fma %m0, %f255, %fh : f32
  %q0 = arith.fptoui %q0f : f32 to i32
  %m1a = arith.minnumf %v1, %v3 : f32
  %m1b = arith.minnumf %m1a, %f1 : f32
  %m1 = arith.maxnumf %m1b, %f0 : f32
  %q1f = math.fma %m1, %f255, %fh : f32
  %q1 = arith.fptoui %q1f : f32 to i32
  %m2a = arith.minnumf %v2, %v3 : f32
  %m2b = arith.minnumf %m2a, %f1 : f32
  %m2 = arith.maxnumf %m2b, %f0 : f32
  %q2f = math.fma %m2, %f255, %fh : f32
  %q2 = arith.fptoui %q2f : f32 to i32
  %m3a = arith.minnumf %v3, %v3 : f32
  %m3b = arith.minnumf %m3a, %f1 : f32
  %m3 = arith.maxnumf %m3b, %f0 : f32
  %q3f = math.fma %m3, %f255, %fh : f32
  %q3 = arith.fptoui %q3f : f32 to i32
  %rgba = func.call @pack(%q0, %q1, %q2, %q3) : (i32, i32, i32, i32) -> i32
  return %rgba : i32
}
func.func private @blend(%dr: i32, %dg: i32, %db: i32, %da: i32, %sr: i32, %sg: i32, %sb: i32, %sa: i32, %m: i32, %masked: i1, %word: i32) -> (i32, i32, i32, i32) {
  %c3 = arith.constant 3 : i32
  %c4 = arith.constant 4 : i32
  %c6 = arith.constant 6 : i32
  %c8 = arith.constant 8 : i32
  %c15 = arith.constant 15 : i32
  %c1 = arith.constant 1 : i32
  %c255 = arith.constant 255 : i32
  %mix = arith.andi %word, %c15 : i32
  %c0b = arith.constant 0 : i32
  %fa4 = arith.shrui %word, %c4 : i32
  %fak = arith.andi %fa4, %c3 : i32
  %fb6 = arith.shrui %word, %c6 : i32
  %fbk = arith.andi %fb6, %c3 : i32
  %sat8 = arith.shrui %word, %c8 : i32
  %sat = arith.andi %sat8, %c1 : i32
  %c9 = arith.constant 9 : i32
  %isf = arith.cmpi uge, %mix, %c9 : i32
  %mm:4 = scf.if %isf -> (i32, i32, i32, i32) {
    %f:4 = func.call @fmix(%dr, %dg, %db, %da, %sr, %sg, %sb, %sa, %mix) : (i32, i32, i32, i32, i32, i32, i32, i32, i32) -> (i32, i32, i32, i32)
    scf.yield %f#0, %f#1, %f#2, %f#3 : i32, i32, i32, i32
  } else {
    %ur = func.call @mix(%sr, %dr, %sa, %da, %mix) : (i32, i32, i32, i32, i32) -> i32
    %ug = func.call @mix(%sg, %dg, %sa, %da, %mix) : (i32, i32, i32, i32, i32) -> i32
    %ub = func.call @mix(%sb, %db, %sa, %da, %mix) : (i32, i32, i32, i32, i32) -> i32
    scf.yield %ur, %ug, %ub, %sa : i32, i32, i32, i32
  }
  %mr = arith.addi %mm#0, %c0b : i32
  %mg = arith.addi %mm#1, %c0b : i32
  %mb = arith.addi %mm#2, %c0b : i32
  %msa = arith.addi %mm#3, %c0b : i32
  %fa = func.call @factor(%fak, %da) : (i32, i32) -> i32
  %fb = func.call @factor(%fbk, %sa) : (i32, i32) -> i32
  %r = func.call @compose(%mr, %dr, %fa, %fb, %sat, %m, %masked) : (i32, i32, i32, i32, i32, i32, i1) -> i32
  %g = func.call @compose(%mg, %dg, %fa, %fb, %sat, %m, %masked) : (i32, i32, i32, i32, i32, i32, i1) -> i32
  %b = func.call @compose(%mb, %db, %fa, %fb, %sat, %m, %masked) : (i32, i32, i32, i32, i32, i32, i1) -> i32
  %a = func.call @compose(%msa, %da, %fa, %fb, %sat, %m, %masked) : (i32, i32, i32, i32, i32, i32, i1) -> i32
  return %r, %g, %b, %a : i32, i32, i32, i32
}
func.func private @factor(%k: i32, %alpha: i32) -> i32 {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c2 = arith.constant 2 : i32
  %c255 = arith.constant 255 : i32
  %inv = arith.subi %c255, %alpha : i32
  %is0 = arith.cmpi eq, %k, %c0 : i32
  %is1 = arith.cmpi eq, %k, %c1 : i32
  %is2 = arith.cmpi eq, %k, %c2 : i32
  %a = arith.select %is2, %alpha, %inv : i32
  %b = arith.select %is1, %c255, %a : i32
  %f = arith.select %is0, %c0, %b : i32
  return %f : i32
}
func.func private @nmul(%a: i32, %b: i32) -> i32 {
  %c8 = arith.constant 8 : i32
  %c255 = arith.constant 255 : i32
  %p = arith.muli %a, %b : i32
  %q = arith.addi %p, %c255 : i32
  %r = arith.shrui %q, %c8 : i32
  return %r : i32
}
func.func private @compose(%s: i32, %d: i32, %fa: i32, %fb: i32, %sat: i32, %m: i32, %masked: i1) -> i32 {
  %c0 = arith.constant 0 : i32
  %c255 = arith.constant 255 : i32
  %p = func.call @nmul(%s, %fa) : (i32, i32) -> i32
  %q = func.call @nmul(%fb, %d) : (i32, i32) -> i32
  %sum = arith.addi %p, %q : i32
  %issat = arith.cmpi ne, %sat, %c0 : i32
  %clamped = arith.minui %sum, %c255 : i32
  %wrapped = arith.andi %sum, %c255 : i32
  %res = arith.select %issat, %clamped, %wrapped : i32
  %r = scf.if %masked -> (i32) {
    %mi = arith.subi %c255, %m : i32
    %p1 = arith.muli %m, %res : i32
    %p2 = arith.muli %mi, %d : i32
    %p3 = arith.addi %p1, %p2 : i32
    %c8 = arith.constant 8 : i32
    %p4 = arith.addi %p3, %c255 : i32
    %p5 = arith.shrui %p4, %c8 : i32
    scf.yield %p5 : i32
  } else {
    scf.yield %res : i32
  }
  return %r : i32
}
func.func private @mix(%s: i32, %b: i32, %sa: i32, %ba: i32, %mix: i32) -> i32 {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c2 = arith.constant 2 : i32
  %c3 = arith.constant 3 : i32
  %c4 = arith.constant 4 : i32
  %c5 = arith.constant 5 : i32
  %c6 = arith.constant 6 : i32
  %c7 = arith.constant 7 : i32
  %c8 = arith.constant 8 : i32
  %c255 = arith.constant 255 : i32
  %iba = arith.subi %c255, %ba : i32
  %p1 = func.call @nmul(%s, %iba) : (i32, i32) -> i32
  %sb = func.call @nmul(%s, %b) : (i32, i32) -> i32
  %sab = func.call @nmul(%sa, %b) : (i32, i32) -> i32
  %sba = func.call @nmul(%s, %ba) : (i32, i32) -> i32
  %bsa = func.call @nmul(%b, %sa) : (i32, i32) -> i32
  %mul = arith.addi %p1, %sb : i32
  %sc1 = arith.addi %s, %sab : i32
  %scr = arith.subi %sc1, %sb : i32
  %mn = arith.minui %sba, %bsa : i32
  %mx = arith.maxui %sba, %bsa : i32
  %dk = arith.addi %p1, %mn : i32
  %lt = arith.addi %p1, %mx : i32
  %df1 = arith.subi %mx, %mn : i32
  %dif = arith.addi %p1, %df1 : i32
  %sub = arith.addi %sb, %sb : i32
  %exge = arith.cmpi uge, %sc1, %sub : i32
  %exd = arith.subi %sc1, %sub : i32
  %exc = arith.select %exge, %exd, %c0 : i32
  %ov = func.call @hardlight(%s, %b, %sa, %ba, %b, %ba) : (i32, i32, i32, i32, i32, i32) -> i32
  %hl = func.call @hardlight(%s, %b, %sa, %ba, %s, %sa) : (i32, i32, i32, i32, i32, i32) -> i32
  %is1 = arith.cmpi eq, %mix, %c1 : i32
  %is2 = arith.cmpi eq, %mix, %c2 : i32
  %is3 = arith.cmpi eq, %mix, %c3 : i32
  %is4 = arith.cmpi eq, %mix, %c4 : i32
  %is5 = arith.cmpi eq, %mix, %c5 : i32
  %is6 = arith.cmpi eq, %mix, %c6 : i32
  %is7 = arith.cmpi eq, %mix, %c7 : i32
  %is8 = arith.cmpi eq, %mix, %c8 : i32
  %v8 = arith.select %is8, %exc, %s : i32
  %v7 = arith.select %is7, %dif, %v8 : i32
  %v6 = arith.select %is6, %hl, %v7 : i32
  %v5 = arith.select %is5, %lt, %v6 : i32
  %v4 = arith.select %is4, %dk, %v5 : i32
  %v3 = arith.select %is3, %ov, %v4 : i32
  %v2 = arith.select %is2, %scr, %v3 : i32
  %v1 = arith.select %is1, %mul, %v2 : i32
  %satd = arith.minui %v1, %c255 : i32
  %r = arith.minui %satd, %sa : i32
  return %r : i32
}
func.func private @hardlight(%s: i32, %b: i32, %sa: i32, %ba: i32, %c: i32, %ca: i32) -> i32 {
  %c2 = arith.constant 2 : i32
  %c8 = arith.constant 8 : i32
  %c255 = arith.constant 255 : i32
  %iba = arith.subi %c255, %ba : i32
  %base = arith.muli %s, %iba : i32
  %sb = arith.muli %s, %b : i32
  %mul = arith.muli %sb, %c2 : i32
  %sab = arith.muli %sa, %ba : i32
  %d1 = arith.subi %sa, %s : i32
  %d2 = arith.subi %ba, %b : i32
  %d3 = arith.muli %d1, %d2 : i32
  %d4 = arith.muli %d3, %c2 : i32
  %scr = arith.subi %sab, %d4 : i32
  %c2x = arith.addi %c, %c : i32
  %le = arith.cmpi ule, %c2x, %ca : i32
  %bl = arith.select %le, %mul, %scr : i32
  %t = arith.addi %base, %bl : i32
  %t1 = arith.addi %t, %c255 : i32
  %t2 = arith.shrui %t1, %c8 : i32
  %t3 = arith.minui %t2, %c255 : i32
  return %t3 : i32
}
func.func private @composite(%a: i32, %dr: i32, %dg: i32, %db: i32, %da: i32, %sr: i32, %sg: i32, %sb: i32, %sa: i32, %m: i32, %masked: i1) -> (i32, i32, i32, i32) {
  %c56 = arith.constant 56 : i32
  %c512 = arith.constant 512 : i32
  %c0 = arith.constant 0 : i32
  %wat = arith.addi %a, %c56 : i32
  %word_p30 = llvm.inttoptr %wat : i32 to !llvm.ptr<1>
  %word = llvm.load %word_p30 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %on = arith.andi %word, %c512 : i32
  %blends = arith.cmpi ne, %on, %c0 : i32
  %r:4 = scf.if %blends -> (i32, i32, i32, i32) {
    %b:4 = func.call @blend(%dr, %dg, %db, %da, %sr, %sg, %sb, %sa, %m, %masked, %word) : (i32, i32, i32, i32, i32, i32, i32, i32, i32, i1, i32) -> (i32, i32, i32, i32)
    scf.yield %b#0, %b#1, %b#2, %b#3 : i32, i32, i32, i32
  } else {
    %o:4 = func.call @over(%dr, %dg, %db, %da, %sr, %sg, %sb, %sa, %m, %masked) : (i32, i32, i32, i32, i32, i32, i32, i32, i32, i1) -> (i32, i32, i32, i32)
    scf.yield %o#0, %o#1, %o#2, %o#3 : i32, i32, i32, i32
  }
  return %r#0, %r#1, %r#2, %r#3 : i32, i32, i32, i32
}
func.func private @mask(%attrs: i32, %a: i32, %x: i32, %y: i32, %outside: i32) -> (i32, i32) {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c4 = arith.constant 4 : i32
  %c16 = arith.constant 16 : i32
  %c60 = arith.constant 60 : i32
  %cffff = arith.constant 65535 : i32
  %at = arith.addi %a, %c60 : i32
  %off1_p31 = llvm.inttoptr %at : i32 to !llvm.ptr<1>
  %off1 = llvm.load %off1_p31 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %has = arith.cmpi ne, %off1, %c0 : i32
  %m = scf.if %has -> (i32) {
    %off = arith.subi %off1, %c1 : i32
    %o4 = arith.muli %off, %c4 : i32
    %hat = arith.addi %attrs, %o4 : i32
    %wh_p32 = llvm.inttoptr %hat : i32 to !llvm.ptr<1>
    %wh = llvm.load %wh_p32 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %w = arith.andi %wh, %cffff : i32
    %h = arith.shrui %wh, %c16 : i32
    %inx = arith.cmpi ult, %x, %w : i32
    %iny = arith.cmpi ult, %y, %h : i32
    %ix = arith.extui %inx : i1 to i32
    %iy = arith.extui %iny : i1 to i32
    %in = arith.andi %ix, %iy : i32
    %inside = arith.cmpi ne, %in, %c0 : i32
    %v = scf.if %inside -> (i32) {
      %row = arith.muli %y, %w : i32
      %i = arith.addi %row, %x : i32
      %d0 = arith.addi %hat, %c4 : i32
      %d = arith.addi %d0, %i : i32
      %b_p33 = llvm.inttoptr %d : i32 to !llvm.ptr<1>
      %b_n34 = llvm.load %b_p33 {alignment = 1 : i64} : !llvm.ptr<1> -> i8
      %b = arith.extui %b_n34 : i8 to i32
      scf.yield %b : i32
    } else {
      scf.yield %outside : i32
    }
    scf.yield %v : i32
  } else {
    scf.yield %c0 : i32
  }
  %h1 = arith.extui %has : i1 to i32
  return %h1, %m : i32, i32
}
func.func private @fmix(%dr: i32, %dg: i32, %db: i32, %da: i32, %sr: i32, %sg: i32, %sb: i32, %sa: i32, %mix: i32) -> (i32, i32, i32, i32) {
  %k255i = arith.constant 998277249 : i32
  %k = arith.bitcast %k255i : i32 to f32
  %f0 = arith.constant 0.0 : f32
  %f1 = arith.constant 1.0 : f32
  %drf = func.call @unorm(%dr, %k) : (i32, f32) -> f32
  %dgf = func.call @unorm(%dg, %k) : (i32, f32) -> f32
  %dbf = func.call @unorm(%db, %k) : (i32, f32) -> f32
  %daf = func.call @unorm(%da, %k) : (i32, f32) -> f32
  %srf = func.call @unorm(%sr, %k) : (i32, f32) -> f32
  %sgf = func.call @unorm(%sg, %k) : (i32, f32) -> f32
  %sbf = func.call @unorm(%sb, %k) : (i32, f32) -> f32
  %saf = func.call @unorm(%sa, %k) : (i32, f32) -> f32
  %br = func.call @unpremul(%drf, %daf) : (f32, f32) -> f32
  %bg = func.call @unpremul(%dgf, %daf) : (f32, f32) -> f32
  %bb = func.call @unpremul(%dbf, %daf) : (f32, f32) -> f32
  %cr = func.call @unpremul(%srf, %saf) : (f32, f32) -> f32
  %cg = func.call @unpremul(%sgf, %saf) : (f32, f32) -> f32
  %cb = func.call @unpremul(%sbf, %saf) : (f32, f32) -> f32
  %c12 = arith.constant 12 : i32
  %sep = arith.cmpi ult, %mix, %c12 : i32
  %m:3 = scf.if %sep -> (f32, f32, f32) {
    %r = func.call @fsep(%cr, %br, %mix) : (f32, f32, i32) -> f32
    %g = func.call @fsep(%cg, %bg, %mix) : (f32, f32, i32) -> f32
    %b = func.call @fsep(%cb, %bb, %mix) : (f32, f32, i32) -> f32
    scf.yield %r, %g, %b : f32, f32, f32
  } else {
    %n:3 = func.call @fnonsep(%cr, %cg, %cb, %br, %bg, %bb, %mix) : (f32, f32, f32, f32, f32, f32, i32) -> (f32, f32, f32)
    scf.yield %n#0, %n#1, %n#2 : f32, f32, f32
  }
  %ia = arith.subf %f1, %daf : f32
  %r = func.call @falpha(%ia, %daf, %saf, %cr, %m#0) : (f32, f32, f32, f32, f32) -> i32
  %g = func.call @falpha(%ia, %daf, %saf, %cg, %m#1) : (f32, f32, f32, f32, f32) -> i32
  %b = func.call @falpha(%ia, %daf, %saf, %cb, %m#2) : (f32, f32, f32, f32, f32) -> i32
  %a = func.call @tou8(%saf) : (f32) -> i32
  return %r, %g, %b, %a : i32, i32, i32, i32
}
func.func private @unorm(%c: i32, %k: f32) -> f32 {
  %f = arith.uitofp %c : i32 to f32
  %r = arith.mulf %f, %k : f32
  return %r : f32
}
func.func private @unpremul(%c: f32, %a: f32) -> f32 {
  %f0 = arith.constant 0.0 : f32
  %d = arith.divf %c, %a : f32
  %z = arith.cmpf oeq, %a, %f0 : f32
  %r = arith.select %z, %f0, %d : f32
  return %r : f32
}
func.func private @tou8(%v: f32) -> i32 {
  %f255 = arith.constant 255.0 : f32
  %fh = arith.constant 0.5 : f32
  %c255 = arith.constant 255 : i32
  %t = math.fma %f255, %v, %fh : f32
  %i = arith.fptoui %t : f32 to i32
  %r = arith.andi %i, %c255 : i32
  return %r : i32
}
func.func private @falpha(%ia: f32, %ba: f32, %sa: f32, %cs: f32, %m: f32) -> i32 {
  %p1 = arith.mulf %ia, %cs : f32
  %p2 = arith.mulf %ba, %m : f32
  %p = arith.addf %p1, %p2 : f32
  %q = arith.mulf %p, %sa : f32
  %r = func.call @tou8(%q) : (f32) -> i32
  return %r : i32
}
func.func private @fsep(%cs: f32, %cb: f32, %mix: i32) -> f32 {
  %f0 = arith.constant 0.0 : f32
  %f1 = arith.constant 1.0 : f32
  %f2 = arith.constant 2.0 : f32
  %f4 = arith.constant 4.0 : f32
  %f12 = arith.constant 12.0 : f32
  %f16 = arith.constant 16.0 : f32
  %fq = arith.constant 0.25 : f32
  %fh = arith.constant 0.5 : f32
  %c9 = arith.constant 9 : i32
  %c10 = arith.constant 10 : i32
  %ics = arith.subf %f1, %cs : f32
  %dq = arith.divf %cb, %ics : f32
  %dm = arith.minnumf %f1, %dq : f32
  %cs1 = arith.cmpf oeq, %cs, %f1 : f32
  %d2 = arith.select %cs1, %f1, %dm : f32
  %cb0 = arith.cmpf oeq, %cb, %f0 : f32
  %dodge = arith.select %cb0, %f0, %d2 : f32
  %icb = arith.subf %f1, %cb : f32
  %bq = arith.divf %icb, %cs : f32
  %bm = arith.minnumf %f1, %bq : f32
  %bm1 = arith.subf %f1, %bm : f32
  %cs0 = arith.cmpf oeq, %cs, %f0 : f32
  %b2 = arith.select %cs0, %f0, %bm1 : f32
  %cb1 = arith.cmpf oeq, %cb, %f1 : f32
  %burn = arith.select %cb1, %f1, %b2 : f32
  %s16 = arith.mulf %f16, %cb : f32
  %s16b = arith.subf %s16, %f12 : f32
  %s16c = arith.mulf %s16b, %cb : f32
  %s16d = arith.addf %s16c, %f4 : f32
  %poly = arith.mulf %s16d, %cb : f32
  %sq = math.sqrt %cb : f32
  %le25 = arith.cmpf ole, %cb, %fq : f32
  %d = arith.select %le25, %poly, %sq : f32
  %two = arith.mulf %f2, %cs : f32
  %one2 = arith.subf %f1, %two : f32
  %t1 = arith.mulf %one2, %cb : f32
  %t2 = arith.mulf %t1, %icb : f32
  %lo = arith.subf %cb, %t2 : f32
  %two1 = arith.subf %two, %f1 : f32
  %dcb = arith.subf %d, %cb : f32
  %t3 = arith.mulf %two1, %dcb : f32
  %hi = arith.addf %cb, %t3 : f32
  %le5 = arith.cmpf ole, %cs, %fh : f32
  %soft = arith.select %le5, %lo, %hi : f32
  %is9 = arith.cmpi eq, %mix, %c9 : i32
  %is10 = arith.cmpi eq, %mix, %c10 : i32
  %x = arith.select %is10, %burn, %soft : f32
  %r = arith.select %is9, %dodge, %x : f32
  return %r : f32
}
func.func private @lum(%r: f32, %g: f32, %b: f32) -> f32 {
  %k3 = arith.constant 0.3 : f32
  %k59 = arith.constant 0.59 : f32
  %k11 = arith.constant 0.11 : f32
  %a = arith.mulf %k3, %r : f32
  %c = arith.mulf %k59, %g : f32
  %e = arith.mulf %k11, %b : f32
  %ac = arith.addf %a, %c : f32
  %l = arith.addf %ac, %e : f32
  return %l : f32
}
func.func private @sat(%r: f32, %g: f32, %b: f32) -> f32 {
  %x1 = arith.maxnumf %r, %g : f32
  %x = arith.maxnumf %x1, %b : f32
  %n1 = arith.minnumf %r, %g : f32
  %n = arith.minnumf %n1, %b : f32
  %s = arith.subf %x, %n : f32
  return %s : f32
}
func.func private @setsat(%r: f32, %g: f32, %b: f32, %s: f32) -> (f32, f32, f32) {
  %f0 = arith.constant 0.0 : f32
  %n1 = arith.minnumf %g, %b : f32
  %mn = arith.minnumf %r, %n1 : f32
  %x1 = arith.maxnumf %g, %b : f32
  %mx = arith.maxnumf %r, %x1 : f32
  %sat = arith.subf %mx, %mn : f32
  %z = arith.cmpf oeq, %sat, %f0 : f32
  %r1 = arith.subf %r, %mn : f32
  %r2 = arith.mulf %r1, %s : f32
  %r3 = arith.divf %r2, %sat : f32
  %rr = arith.select %z, %f0, %r3 : f32
  %g1 = arith.subf %g, %mn : f32
  %g2 = arith.mulf %g1, %s : f32
  %g3 = arith.divf %g2, %sat : f32
  %gg = arith.select %z, %f0, %g3 : f32
  %b1 = arith.subf %b, %mn : f32
  %b2 = arith.mulf %b1, %s : f32
  %b3 = arith.divf %b2, %sat : f32
  %bb = arith.select %z, %f0, %b3 : f32
  return %rr, %gg, %bb : f32, f32, f32
}
func.func private @clip1(%c: f32, %l: f32, %n: f32, %x: f32) -> f32 {
  %f0 = arith.constant 0.0 : f32
  %f1 = arith.constant 1.0 : f32
  %cl = arith.subf %c, %l : f32
  %a1 = arith.mulf %cl, %l : f32
  %ln = arith.subf %l, %n : f32
  %a2 = arith.divf %a1, %ln : f32
  %a3 = arith.addf %l, %a2 : f32
  %neg = arith.cmpf olt, %n, %f0 : f32
  %c1 = arith.select %neg, %a3, %c : f32
  %cl2 = arith.subf %c1, %l : f32
  %il = arith.subf %f1, %l : f32
  %b1 = arith.mulf %cl2, %il : f32
  %xl = arith.subf %x, %l : f32
  %b2 = arith.divf %b1, %xl : f32
  %b3 = arith.addf %l, %b2 : f32
  %over = arith.cmpf ogt, %x, %f1 : f32
  %c2 = arith.select %over, %b3, %c1 : f32
  return %c2 : f32
}
func.func private @setlum(%r: f32, %g: f32, %b: f32, %l: f32) -> (f32, f32, f32) {
  %l0 = func.call @lum(%r, %g, %b) : (f32, f32, f32) -> f32
  %d = arith.subf %l, %l0 : f32
  %r1 = arith.addf %r, %d : f32
  %g1 = arith.addf %g, %d : f32
  %b1 = arith.addf %b, %d : f32
  %ll = func.call @lum(%r1, %g1, %b1) : (f32, f32, f32) -> f32
  %n1 = arith.minnumf %g1, %b1 : f32
  %n = arith.minnumf %r1, %n1 : f32
  %x1 = arith.maxnumf %g1, %b1 : f32
  %x = arith.maxnumf %r1, %x1 : f32
  %r2 = func.call @clip1(%r1, %ll, %n, %x) : (f32, f32, f32, f32) -> f32
  %g2 = func.call @clip1(%g1, %ll, %n, %x) : (f32, f32, f32, f32) -> f32
  %b2 = func.call @clip1(%b1, %ll, %n, %x) : (f32, f32, f32, f32) -> f32
  return %r2, %g2, %b2 : f32, f32, f32
}
func.func private @fnonsep(%sr: f32, %sg: f32, %sb: f32, %br: f32, %bg: f32, %bb: f32, %mix: i32) -> (f32, f32, f32) {
  %c12 = arith.constant 12 : i32
  %c13 = arith.constant 13 : i32
  %c14 = arith.constant 14 : i32
  %lb = func.call @lum(%br, %bg, %bb) : (f32, f32, f32) -> f32
  %ls = func.call @lum(%sr, %sg, %sb) : (f32, f32, f32) -> f32
  %is12 = arith.cmpi eq, %mix, %c12 : i32
  %r:3 = scf.if %is12 -> (f32, f32, f32) {
    %ssb = func.call @sat(%br, %bg, %bb) : (f32, f32, f32) -> f32
    %h:3 = func.call @setsat(%sr, %sg, %sb, %ssb) : (f32, f32, f32, f32) -> (f32, f32, f32)
    %o:3 = func.call @setlum(%h#0, %h#1, %h#2, %lb) : (f32, f32, f32, f32) -> (f32, f32, f32)
    scf.yield %o#0, %o#1, %o#2 : f32, f32, f32
  } else {
    %is13 = arith.cmpi eq, %mix, %c13 : i32
    %q:3 = scf.if %is13 -> (f32, f32, f32) {
      %sss = func.call @sat(%sr, %sg, %sb) : (f32, f32, f32) -> f32
      %h:3 = func.call @setsat(%br, %bg, %bb, %sss) : (f32, f32, f32, f32) -> (f32, f32, f32)
      %o:3 = func.call @setlum(%h#0, %h#1, %h#2, %lb) : (f32, f32, f32, f32) -> (f32, f32, f32)
      scf.yield %o#0, %o#1, %o#2 : f32, f32, f32
    } else {
      %is14 = arith.cmpi eq, %mix, %c14 : i32
      %p:3 = scf.if %is14 -> (f32, f32, f32) {
        %o:3 = func.call @setlum(%sr, %sg, %sb, %lb) : (f32, f32, f32, f32) -> (f32, f32, f32)
        scf.yield %o#0, %o#1, %o#2 : f32, f32, f32
      } else {
        %o:3 = func.call @setlum(%br, %bg, %bb, %ls) : (f32, f32, f32, f32) -> (f32, f32, f32)
        scf.yield %o#0, %o#1, %o#2 : f32, f32, f32
      }
      scf.yield %p#0, %p#1, %p#2 : f32, f32, f32
    }
    scf.yield %q#0, %q#1, %q#2 : f32, f32, f32
  }
  return %r#0, %r#1, %r#2 : f32, f32, f32
}
func.func private @pow(%x: f32, %e: f32) -> f32 {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c23 = arith.constant 23 : i32
  %c127 = arith.constant 127 : i32
  %c255 = arith.constant 255 : i32
  %cman = arith.constant 8388607 : i32
  %cone = arith.constant 1065353216 : i32
  %f0 = arith.constant 0.0 : f32
  %f1 = arith.constant 1.0 : f32
  %fh = arith.constant 0.5 : f32
  %i9i = arith.constant 1038323257 : i32
  %i9 = arith.bitcast %i9i : i32 to f32
  %i7i = arith.constant 1041385765 : i32
  %i7 = arith.bitcast %i7i : i32 to f32
  %i5i = arith.constant 1045220557 : i32
  %i5 = arith.bitcast %i5i : i32 to f32
  %i3i = arith.constant 1051372203 : i32
  %i3 = arith.bitcast %i3i : i32 to f32
  %tli = arith.constant 1077455419 : i32
  %tl = arith.bitcast %tli : i32 to f32
  %sq2i = arith.constant 1068827891 : i32
  %sq2 = arith.bitcast %sq2i : i32 to f32
  %bits = arith.bitcast %x : f32 to i32
  %b1 = arith.shrui %bits, %c23 : i32
  %biased = arith.andi %b1, %c255 : i32
  %pos = arith.cmpf ogt, %x, %f0 : f32
  %normal = arith.cmpi ne, %biased, %c0 : i32
  %p1 = arith.extui %pos : i1 to i32
  %n1 = arith.extui %normal : i1 to i32
  %ok1 = arith.andi %p1, %n1 : i32
  %ok = arith.cmpi ne, %ok1, %c0 : i32
  %r = scf.if %ok -> (f32) {
    %ex0 = arith.subi %biased, %c127 : i32
    %mb = arith.andi %bits, %cman : i32
    %mb1 = arith.ori %mb, %cone : i32
    %m0 = arith.bitcast %mb1 : i32 to f32
    %big = arith.cmpf ogt, %m0, %sq2 : f32
    %mh = arith.mulf %m0, %fh : f32
    %m = arith.select %big, %mh, %m0 : f32
    %exa = arith.addi %ex0, %c1 : i32
    %ex = arith.select %big, %exa, %ex0 : i32
    %mm1 = arith.subf %m, %f1 : f32
    %mp1 = arith.addf %m, %f1 : f32
    %t = arith.divf %mm1, %mp1 : f32
    %s = arith.mulf %t, %t : f32
    %q1 = math.fma %i9, %s, %i7 : f32
    %q2 = math.fma %q1, %s, %i5 : f32
    %q3 = math.fma %q2, %s, %i3 : f32
    %q4 = math.fma %q3, %s, %f1 : f32
    %tp = arith.mulf %t, %q4 : f32
    %exf = arith.sitofp %ex : i32 to f32
    %lg = math.fma %tp, %tl, %exf : f32
    %y = arith.mulf %e, %lg : f32
    %v = func.call @exp2(%y) : (f32) -> f32
    scf.yield %v : f32
  } else {
    scf.yield %f0 : f32
  }
  return %r : f32
}
func.func private @exp2(%y: f32) -> f32 {
  %c23 = arith.constant 23 : i32
  %f0 = arith.constant 0.0 : f32
  %lo = arith.constant -126.0 : f32
  %hi = arith.constant 127.0 : f32
  %infi = arith.constant 2139095040 : i32
  %inf = arith.bitcast %infi : i32 to f32
  %k0i = arith.constant 900816913 : i32
  %k0 = arith.bitcast %k0i : i32 to f32
  %k1i = arith.constant 931128830 : i32
  %k1 = arith.bitcast %k1i : i32 to f32
  %k2i = arith.constant 958497929 : i32
  %k2 = arith.bitcast %k2i : i32 to f32
  %k3i = arith.constant 984531967 : i32
  %k3 = arith.bitcast %k3i : i32 to f32
  %k4i = arith.constant 1008571739 : i32
  %k4 = arith.bitcast %k4i : i32 to f32
  %k5i = arith.constant 1029920839 : i32
  %k5 = arith.bitcast %k5i : i32 to f32
  %k6i = arith.constant 1047920112 : i32
  %k6 = arith.bitcast %k6i : i32 to f32
  %k7i = arith.constant 1060205080 : i32
  %k7 = arith.bitcast %k7i : i32 to f32
  %k8i = arith.constant 1065353216 : i32
  %k8 = arith.bitcast %k8i : i32 to f32
  %yi = math.floor %y : f32
  %f = arith.subf %y, %yi : f32
  %h1 = math.fma %k0, %f, %k1 : f32
  %h2 = math.fma %h1, %f, %k2 : f32
  %h3 = math.fma %h2, %f, %k3 : f32
  %h4 = math.fma %h3, %f, %k4 : f32
  %h5 = math.fma %h4, %f, %k5 : f32
  %h6 = math.fma %h5, %f, %k6 : f32
  %h7 = math.fma %h6, %f, %k7 : f32
  %h8 = math.fma %h7, %f, %k8 : f32
  %pb = arith.bitcast %h8 : f32 to i32
  %yii = arith.fptosi %yi : f32 to i32
  %sh = arith.shli %yii, %c23 : i32
  %rb = arith.addi %pb, %sh : i32
  %r0 = arith.bitcast %rb : i32 to f32
  %under = arith.cmpf olt, %yi, %lo : f32
  %over = arith.cmpf ogt, %yi, %hi : f32
  %r1 = arith.select %over, %inf, %r0 : f32
  %r = arith.select %under, %f0, %r1 : f32
  return %r : f32
}
func.func private @erf7(%x0: f32) -> f32 {
  %f1 = arith.constant 1.0 : f32
  %m10 = arith.constant -10.0 : f32
  %p10 = arith.constant 10.0 : f32
  %tspi = arith.constant 1066430139 : i32
  %tsp = arith.bitcast %tspi : i32 to f32
  %e1i = arith.constant 1009411267 : i32
  %e1 = arith.bitcast %e1i : i32 to f32
  %e2i = arith.constant 1024134952 : i32
  %e2 = arith.bitcast %e2i : i32 to f32
  %e3i = arith.constant 1048102883 : i32
  %e3 = arith.bitcast %e3i : i32 to f32
  %xa = arith.maxnumf %x0, %m10 : f32
  %xb = arith.minnumf %xa, %p10 : f32
  %x = arith.mulf %xb, %tsp : f32
  %xx = arith.mulf %x, %x : f32
  %p1 = math.fma %e1, %xx, %e2 : f32
  %p2 = math.fma %p1, %xx, %e3 : f32
  %p3 = arith.mulf %x, %xx : f32
  %xn = math.fma %p2, %p3, %x : f32
  %dn = math.fma %xn, %xn, %f1 : f32
  %den = math.sqrt %dn : f32
  %r = arith.divf %xn, %den : f32
  return %r : f32
}
func.func private @boxshadow(%attrs: i32, %a: i32, %x: i32, %y: i32) -> i32 {
  %c4 = arith.constant 4 : i32
  %c0 = arith.constant 0 : i32
  %f0 = arith.constant 0.0 : f32
  %f1 = arith.constant 1.0 : f32
  %fh = arith.constant 0.5 : f32
  %off_p35 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
  %off = llvm.load %off_p35 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %o4 = arith.muli %off, %c4 : i32
  %d = arith.addi %attrs, %o4 : i32
  %oex = arith.constant 0 : i32
  %aex = arith.addi %d, %oex : i32
  %bex_p36 = llvm.inttoptr %aex : i32 to !llvm.ptr<1>
  %bex = llvm.load %bex_p36 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %ex = arith.bitcast %bex : i32 to f32
  %orex = arith.constant 4 : i32
  %arex = arith.addi %d, %orex : i32
  %brex_p37 = llvm.inttoptr %arex : i32 to !llvm.ptr<1>
  %brex = llvm.load %brex_p37 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %rex = arith.bitcast %brex : i32 to f32
  %oscale = arith.constant 8 : i32
  %ascale = arith.addi %d, %oscale : i32
  %bscale_p38 = llvm.inttoptr %ascale : i32 to !llvm.ptr<1>
  %bscale = llvm.load %bscale_p38 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %scale = arith.bitcast %bscale : i32 to f32
  %osdi = arith.constant 12 : i32
  %asdi = arith.addi %d, %osdi : i32
  %bsdi_p39 = llvm.inttoptr %asdi : i32 to !llvm.ptr<1>
  %bsdi = llvm.load %bsdi_p39 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %sdi = arith.bitcast %bsdi : i32 to f32
  %ominedge = arith.constant 16 : i32
  %aminedge = arith.addi %d, %ominedge : i32
  %bminedge_p40 = llvm.inttoptr %aminedge : i32 to !llvm.ptr<1>
  %bminedge = llvm.load %bminedge_p40 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %minedge = arith.bitcast %bminedge : i32 to f32
  %ow = arith.constant 20 : i32
  %aw = arith.addi %d, %ow : i32
  %bw_p41 = llvm.inttoptr %aw : i32 to !llvm.ptr<1>
  %bw = llvm.load %bw_p41 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %w = arith.bitcast %bw : i32 to f32
  %oh = arith.constant 24 : i32
  %ah = arith.addi %d, %oh : i32
  %bh_p42 = llvm.inttoptr %ah : i32 to !llvm.ptr<1>
  %bh = llvm.load %bh_p42 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %h = arith.bitcast %bh : i32 to f32
  %owidth = arith.constant 28 : i32
  %awidth = arith.addi %d, %owidth : i32
  %bwidth_p43 = llvm.inttoptr %awidth : i32 to !llvm.ptr<1>
  %bwidth = llvm.load %bwidth_p43 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %width = arith.bitcast %bwidth : i32 to f32
  %oheight = arith.constant 32 : i32
  %aheight = arith.addi %d, %oheight : i32
  %bheight_p44 = llvm.inttoptr %aheight : i32 to !llvm.ptr<1>
  %bheight = llvm.load %bheight_p44 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %height = arith.bitcast %bheight : i32 to f32
  %or1 = arith.constant 36 : i32
  %ar1 = arith.addi %d, %or1 : i32
  %br1_p45 = llvm.inttoptr %ar1 : i32 to !llvm.ptr<1>
  %br1 = llvm.load %br1_p45 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %r1 = arith.bitcast %br1 : i32 to f32
  %oinv = arith.constant 40 : i32
  %ainv = arith.addi %d, %oinv : i32
  %binv_p46 = llvm.inttoptr %ainv : i32 to !llvm.ptr<1>
  %binv = llvm.load %binv_p46 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %ocr = arith.constant 44 : i32
  %acr = arith.addi %d, %ocr : i32
  %bcr_p47 = llvm.inttoptr %acr : i32 to !llvm.ptr<1>
  %bcr = llvm.load %bcr_p47 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %cr = arith.bitcast %bcr : i32 to f32
  %ocg = arith.constant 48 : i32
  %acg = arith.addi %d, %ocg : i32
  %bcg_p48 = llvm.inttoptr %acg : i32 to !llvm.ptr<1>
  %bcg = llvm.load %bcg_p48 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %cg = arith.bitcast %bcg : i32 to f32
  %ocb = arith.constant 52 : i32
  %acb = arith.addi %d, %ocb : i32
  %bcb_p49 = llvm.inttoptr %acb : i32 to !llvm.ptr<1>
  %bcb = llvm.load %bcb_p49 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %cb = arith.bitcast %bcb : i32 to f32
  %oca = arith.constant 56 : i32
  %aca = arith.addi %d, %oca : i32
  %bca_p50 = llvm.inttoptr %aca : i32 to !llvm.ptr<1>
  %bca = llvm.load %bca_p50 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %ca = arith.bitcast %bca : i32 to f32
  %op0x = arith.constant 60 : i32
  %ap0x = arith.addi %d, %op0x : i32
  %bp0x_p51 = llvm.inttoptr %ap0x : i32 to !llvm.ptr<1>
  %bp0x = llvm.load %bp0x_p51 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %p0x = arith.bitcast %bp0x : i32 to f32
  %op0y = arith.constant 64 : i32
  %ap0y = arith.addi %d, %op0y : i32
  %bp0y_p52 = llvm.inttoptr %ap0y : i32 to !llvm.ptr<1>
  %bp0y = llvm.load %bp0y_p52 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %p0y = arith.bitcast %bp0y : i32 to f32
  %oxax = arith.constant 68 : i32
  %axax = arith.addi %d, %oxax : i32
  %bxax_p53 = llvm.inttoptr %axax : i32 to !llvm.ptr<1>
  %bxax = llvm.load %bxax_p53 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %xax = arith.bitcast %bxax : i32 to f32
  %oxay = arith.constant 72 : i32
  %axay = arith.addi %d, %oxay : i32
  %bxay_p54 = llvm.inttoptr %axay : i32 to !llvm.ptr<1>
  %bxay = llvm.load %bxay_p54 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %xay = arith.bitcast %bxay : i32 to f32
  %oyax = arith.constant 76 : i32
  %ayax = arith.addi %d, %oyax : i32
  %byax_p55 = llvm.inttoptr %ayax : i32 to !llvm.ptr<1>
  %byax = llvm.load %byax_p55 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %yax = arith.bitcast %byax : i32 to f32
  %oyay = arith.constant 80 : i32
  %ayay = arith.addi %d, %oyay : i32
  %byay_p56 = llvm.inttoptr %ayay : i32 to !llvm.ptr<1>
  %byay = llvm.load %byay_p56 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %yay = arith.bitcast %byay : i32 to f32
  %fx = arith.sitofp %x : i32 to f32
  %fy = arith.sitofp %y : i32 to f32
  %t0 = math.fma %fy, %yax, %p0x : f32
  %i = math.fma %fx, %xax, %t0 : f32
  %s0 = math.fma %fy, %yay, %p0y : f32
  %j = math.fma %fx, %xay, %s0 : f32
  %hh = arith.mulf %fh, %height : f32
  %yy = arith.subf %j, %hh : f32
  %ay = math.absf %yy : f32
  %nay = arith.negf %ay : f32
  %ym = math.fma %h, %fh, %nay : f32
  %y0 = arith.subf %r1, %ym : f32
  %y1 = arith.maxnumf %y0, %f0 : f32
  %hw = arith.mulf %fh, %width : f32
  %xx = arith.subf %i, %hw : f32
  %ax = math.absf %xx : f32
  %nax = arith.negf %ax : f32
  %xm = math.fma %w, %fh, %nax : f32
  %x0 = arith.subf %r1, %xm : f32
  %x1 = arith.maxnumf %x0, %f0 : f32
  %px = func.call @pow(%x1, %ex) : (f32, f32) -> f32
  %py = func.call @pow(%y1, %ex) : (f32, f32) -> f32
  %ps = arith.addf %px, %py : f32
  %dpos = func.call @pow(%ps, %rex) : (f32, f32) -> f32
  %mxy = arith.maxnumf %x0, %y0 : f32
  %dneg = arith.minnumf %mxy, %f0 : f32
  %dd = arith.addf %dpos, %dneg : f32
  %dist = arith.subf %dd, %r1 : f32
  %u0 = arith.addf %minedge, %dist : f32
  %u1 = arith.mulf %sdi, %u0 : f32
  %v1 = arith.mulf %sdi, %dist : f32
  %e1 = func.call @erf7(%u1) : (f32) -> f32
  %e2 = func.call @erf7(%v1) : (f32) -> f32
  %de = arith.subf %e1, %e2 : f32
  %z0 = arith.mulf %scale, %de : f32
  %isinv = arith.cmpi ne, %binv, %c0 : i32
  %zi = arith.subf %f1, %z0 : f32
  %z = arith.select %isinv, %zi, %z0 : f32
  %qr = arith.mulf %cr, %z : f32
  %qg = arith.mulf %cg, %z : f32
  %qb = arith.mulf %cb, %z : f32
  %qa = arith.mulf %ca, %z : f32
  %ur = func.call @tou8b(%qr) : (f32) -> i32
  %ug = func.call @tou8b(%qg) : (f32) -> i32
  %ub = func.call @tou8b(%qb) : (f32) -> i32
  %ua = func.call @tou8b(%qa) : (f32) -> i32
  %rgba = func.call @pack(%ur, %ug, %ub, %ua) : (i32, i32, i32, i32) -> i32
  return %rgba : i32
}
func.func private @tou8b(%v: f32) -> i32 {
  %f255 = arith.constant 255.0 : f32
  %fh = arith.constant 0.5 : f32
  %c255 = arith.constant 255 : i32
  %t = math.fma %v, %f255, %fh : f32
  %i = arith.fptoui %t : f32 to i32
  %r = arith.andi %i, %c255 : i32
  return %r : i32
}
}
}
