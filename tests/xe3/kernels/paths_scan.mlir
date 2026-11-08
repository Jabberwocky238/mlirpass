// acgpu's crates/intel/driver/src/paths/scan.mlir in upstream dialects.
module attributes {gpu.container_module} {
gpu.module @shaders [#xevm.target<chip = "ptl">] {
gpu.func @scan(%counts: i32, %offsets: i32, %sums: i32, %n: i32, %pass: i32) workgroup(%acgpu_shared : memref<2048xi8, #gpu.address_space<workgroup>>) kernel attributes {known_block_size = array<i32: 256, 1, 1>} {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c2 = arith.constant 2 : i32
  %c3 = arith.constant 3 : i32
  %c4 = arith.constant 4 : i32
  %c255 = arith.constant 255 : i32
  %c256 = arith.constant 256 : i32
  %c1024 = arith.constant 1024 : i32
  %g_ix1 = gpu.block_id x
  %g = arith.index_cast %g_ix1 : index to i32
  %l_ix2 = gpu.thread_id x
  %l = arith.index_cast %l_ix2 : index to i32
  %g1024 = arith.muli %g, %c1024 : i32
  %l4 = arith.muli %l, %c4 : i32
  %base = arith.addi %g1024, %l4 : i32
  %g4 = arith.muli %g, %c4 : i32
  %sa = arith.addi %sums, %g4 : i32
  %second = arith.cmpi eq, %pass, %c2 : i32
  scf.if %second {
    %start_p3 = llvm.inttoptr %sa : i32 to !llvm.ptr<1>
    %start = llvm.load %start_p3 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    scf.for %k = %c0 to %c4 step %c1 : i32 {
      %i = arith.addi %base, %k : i32
      %in = arith.cmpi slt, %i, %n : i32
      scf.if %in {
        %i4 = arith.muli %i, %c4 : i32
        %oa = arith.addi %offsets, %i4 : i32
        %o_p4 = llvm.inttoptr %oa : i32 to !llvm.ptr<1>
        %o = llvm.load %o_p4 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
        %o2 = arith.addi %o, %start : i32
        %st_p5 = llvm.inttoptr %oa : i32 to !llvm.ptr<1>
        llvm.store %o2, %st_p5 {alignment = 4 : i64} : i32, !llvm.ptr<1>
      }
    }
  } else {
    %x0 = func.call @count(%counts, %base, %c0, %n) : (i32, i32, i32, i32) -> i32
    %x1 = func.call @count(%counts, %base, %c1, %n) : (i32, i32, i32, i32) -> i32
    %x2 = func.call @count(%counts, %base, %c2, %n) : (i32, i32, i32, i32) -> i32
    %x3 = func.call @count(%counts, %base, %c3, %n) : (i32, i32, i32, i32) -> i32
    %s1 = arith.addi %x0, %x1 : i32
    %s2 = arith.addi %s1, %x2 : i32
    %t = arith.addi %s2, %x3 : i32
    %st_p6 = llvm.inttoptr %l4 : i32 to !llvm.ptr<3>
    llvm.store %t, %st_p6 {alignment = 4 : i64} : i32, !llvm.ptr<3>
    gpu.barrier
    %c8 = arith.constant 8 : i32
    %fin:2 = scf.for %r = %c0 to %c8 step %c1 iter_args(%d = %c1, %cur = %c0) -> (i32, i32) : i32 {
        %nxt = arith.subi %c1024, %cur : i32
        %ca = arith.addi %cur, %l4 : i32
        %v_p7 = llvm.inttoptr %ca : i32 to !llvm.ptr<3>
        %v = llvm.load %v_p7 {alignment = 4 : i64} : !llvm.ptr<3> -> i32
        %has = arith.cmpi uge, %l, %d : i32
        %ld = arith.subi %l, %d : i32
        %lc = arith.select %has, %ld, %c0 : i32
        %lc4 = arith.muli %lc, %c4 : i32
        %ua = arith.addi %cur, %lc4 : i32
        %u0_p8 = llvm.inttoptr %ua : i32 to !llvm.ptr<3>
        %u0 = llvm.load %u0_p8 {alignment = 4 : i64} : !llvm.ptr<3> -> i32
        %u = arith.select %has, %u0, %c0 : i32
        %w = arith.addi %v, %u : i32
        %na = arith.addi %nxt, %l4 : i32
        %st_p9 = llvm.inttoptr %na : i32 to !llvm.ptr<3>
        llvm.store %w, %st_p9 {alignment = 4 : i64} : i32, !llvm.ptr<3>
        gpu.barrier
        %d2 = arith.addi %d, %d : i32
        scf.yield %d2, %nxt : i32, i32
    }
    %ia = arith.addi %fin#1, %l4 : i32
    %incl_p10 = llvm.inttoptr %ia : i32 to !llvm.ptr<3>
    %incl = llvm.load %incl_p10 {alignment = 4 : i64} : !llvm.ptr<3> -> i32
    %excl = arith.subi %incl, %t : i32
    %o1 = arith.addi %excl, %x0 : i32
    %o2 = arith.addi %o1, %x1 : i32
    %o3 = arith.addi %o2, %x2 : i32
    func.call @put(%offsets, %base, %c0, %n, %excl) : (i32, i32, i32, i32, i32) -> ()
    func.call @put(%offsets, %base, %c1, %n, %o1) : (i32, i32, i32, i32, i32) -> ()
    func.call @put(%offsets, %base, %c2, %n, %o2) : (i32, i32, i32, i32, i32) -> ()
    func.call @put(%offsets, %base, %c3, %n, %o3) : (i32, i32, i32, i32, i32) -> ()
    %last = arith.cmpi eq, %l, %c255 : i32
    scf.if %last {
      %st_p11 = llvm.inttoptr %sa : i32 to !llvm.ptr<1>
      llvm.store %incl, %st_p11 {alignment = 4 : i64} : i32, !llvm.ptr<1>
    }
  }
  gpu.return
}
func.func private @count(%counts: i32, %base: i32, %k: i32, %n: i32) -> i32 {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c4 = arith.constant 4 : i32
  %i = arith.addi %base, %k : i32
  %in = arith.cmpi slt, %i, %n : i32
  %n1 = arith.subi %n, %c1 : i32
  %ic = arith.minsi %i, %n1 : i32
  %i4 = arith.muli %ic, %c4 : i32
  %a = arith.addi %counts, %i4 : i32
  %v_p12 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
  %v = llvm.load %v_p12 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %pos = arith.maxsi %v, %c0 : i32
  %r = arith.select %in, %pos, %c0 : i32
  return %r : i32
}
func.func private @put(%offsets: i32, %base: i32, %k: i32, %n: i32, %v: i32) {
  %c4 = arith.constant 4 : i32
  %i = arith.addi %base, %k : i32
  %in = arith.cmpi slt, %i, %n : i32
  scf.if %in {
    %i4 = arith.muli %i, %c4 : i32
    %a = arith.addi %offsets, %i4 : i32
    %st_p13 = llvm.inttoptr %a : i32 to !llvm.ptr<1>
    llvm.store %v, %st_p13 {alignment = 4 : i64} : i32, !llvm.ptr<1>
  }
  return
}
}
}
