// acgpu's crates/intel/driver/src/filters/shadow.mlir in upstream dialects.
module attributes {gpu.container_module} {
gpu.module @shaders [#xevm.target<chip = "ptl">] {
gpu.func @offset(%src: i32, %ss: i32, %dst: i32, %ds: i32, %wh: i32, %dx: i32, %dy: i32) kernel {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c16 = arith.constant 16 : i32
  %cffff = arith.constant 65535 : i32
  %x, %y, %w, %h = func.call @pixel(%wh) : (i32) -> (i32, i32, i32, i32)
  %sx = arith.subi %x, %dx : i32
  %sy = arith.subi %y, %dy : i32
  %own = func.call @get(%src, %ss, %x, %y) : (i32, i32, i32, i32) -> i32
  %lx = arith.subi %w, %c1 : i32
  %ly = arith.subi %h, %c1 : i32
  %cx0 = arith.maxsi %sx, %c0 : i32
  %cx = arith.minsi %cx0, %lx : i32
  %cy0 = arith.maxsi %sy, %c0 : i32
  %cy = arith.minsi %cy0, %ly : i32
  %moved = func.call @get(%src, %ss, %cx, %cy) : (i32, i32, i32, i32) -> i32
  %inx = arith.cmpi eq, %cx, %sx : i32
  %iny = arith.cmpi eq, %cy, %sy : i32
  %wdx0 = arith.addi %w, %dx : i32
  %wdx = arith.andi %wdx0, %cffff : i32
  %hdy0 = arith.addi %h, %dy : i32
  %hdy = arith.andi %hdy0, %cffff : i32
  %dxp = arith.cmpi sgt, %dx, %c0 : i32
  %dxn = arith.cmpi slt, %dx, %c0 : i32
  %dyp = arith.cmpi sgt, %dy, %c0 : i32
  %dyn = arith.cmpi slt, %dy, %c0 : i32
  %xlt = arith.cmpi slt, %x, %dx : i32
  %xge = arith.cmpi sge, %x, %wdx : i32
  %ylt = arith.cmpi slt, %y, %dy : i32
  %yge = arith.cmpi sge, %y, %hdy : i32
  %a0 = arith.select %xlt, %c1, %c0 : i32
  %a = arith.select %dxp, %a0, %c0 : i32
  %b0 = arith.select %xge, %c1, %c0 : i32
  %b = arith.select %dxn, %b0, %c0 : i32
  %c0s = arith.select %ylt, %c1, %c0 : i32
  %c = arith.select %dyp, %c0s, %c0 : i32
  %d0 = arith.select %yge, %c1, %c0 : i32
  %d = arith.select %dyn, %d0, %c0 : i32
  %ab = arith.ori %a, %b : i32
  %cd = arith.ori %c, %d : i32
  %clear = arith.ori %ab, %cd : i32
  %isclear = arith.cmpi ne, %clear, %c0 : i32
  %kept = arith.select %isclear, %c0, %own : i32
  %v1 = arith.select %iny, %moved, %kept : i32
  %v = arith.select %inx, %v1, %kept : i32
  func.call @put(%dst, %ds, %x, %y, %v) : (i32, i32, i32, i32, i32) -> ()
  gpu.return
}
gpu.func @shadow(%layer: i32, %blurred: i32, %dst: i32, %ls: i32, %wh: i32, %rgbo: i32, %cab: i32) kernel {
  %c0i = arith.constant 0 : i32
  %c00ffffff = arith.constant 16777215 : i32
  %bs = arith.addi %ls, %c0i : i32
  %ds = arith.addi %ls, %c0i : i32
  %c24o = arith.constant 24 : i32
  %over = arith.shrui %rgbo, %c24o : i32
  %rgb = arith.andi %rgbo, %c00ffffff : i32
  %c0 = arith.constant 0 : i32
  %c8 = arith.constant 8 : i32
  %c16 = arith.constant 16 : i32
  %c24 = arith.constant 24 : i32
  %cff = arith.constant 255 : i32
  %f1 = arith.constant 1.0 : f32
  %f255 = arith.constant 255.0 : f32
  %x, %y, %w, %h = func.call @pixel(%wh) : (i32) -> (i32, i32, i32, i32)
  %s = func.call @get(%blurred, %bs, %x, %y) : (i32, i32, i32, i32) -> i32
  %sa = arith.shrui %s, %c24 : i32
  %ca = arith.bitcast %cab : i32 to f32
  %saf = arith.uitofp %sa : i32 to f32
  %san = arith.divf %saf, %f255 : f32
  %m = arith.mulf %san, %ca : f32
  %mc = arith.minnumf %m, %f1 : f32
  %m255 = arith.mulf %mc, %f255 : f32
  %fa = func.call @round(%m255) : (f32) -> i32
  %cr = arith.andi %rgb, %cff : i32
  %cg0 = arith.shrui %rgb, %c8 : i32
  %cg = arith.andi %cg0, %cff : i32
  %cb0 = arith.shrui %rgb, %c16 : i32
  %cb = arith.andi %cb0, %cff : i32
  %pr = func.call @div255(%cr, %fa) : (i32, i32) -> i32
  %pg = func.call @div255(%cg, %fa) : (i32, i32) -> i32
  %pb = func.call @div255(%cb, %fa) : (i32, i32) -> i32
  %colored = func.call @pack(%pr, %pg, %pb, %fa) : (i32, i32, i32, i32) -> i32
  %put_over = arith.cmpi ne, %over, %c0 : i32
  %out = scf.if %put_over -> (i32) {
    %l = func.call @get(%layer, %ls, %x, %y) : (i32, i32, i32, i32) -> i32
    %lc:4 = func.call @unpack(%l) : (i32) -> (i32, i32, i32, i32)
    %la = arith.uitofp %lc#3 : i32 to f32
    %lan = arith.divf %la, %f255 : f32
    %k = arith.subf %f1, %lan : f32
    %r = func.call @src_over(%lc#0, %pr, %k) : (i32, i32, f32) -> i32
    %g = func.call @src_over(%lc#1, %pg, %k) : (i32, i32, f32) -> i32
    %b = func.call @src_over(%lc#2, %pb, %k) : (i32, i32, f32) -> i32
    %a = func.call @src_over(%lc#3, %fa, %k) : (i32, i32, f32) -> i32
    %o = func.call @pack(%r, %g, %b, %a) : (i32, i32, i32, i32) -> i32
    scf.yield %o : i32
  } else {
    scf.yield %colored : i32
  }
  func.call @put(%dst, %ds, %x, %y, %out) : (i32, i32, i32, i32, i32) -> ()
  gpu.return
}
func.func private @src_over(%s: i32, %d: i32, %k: f32) -> i32 {
  %f255 = arith.constant 255.0 : f32
  %sf = arith.uitofp %s : i32 to f32
  %df = arith.uitofp %d : i32 to f32
  %sn = arith.divf %sf, %f255 : f32
  %dn = arith.divf %df, %f255 : f32
  %t = arith.mulf %dn, %k : f32
  %v = arith.addf %sn, %t : f32
  %v255 = arith.mulf %v, %f255 : f32
  %r = func.call @round(%v255) : (f32) -> i32
  return %r : i32
}
func.func private @div255(%c: i32, %a: i32) -> i32 {
  %c1 = arith.constant 1 : i32
  %c8 = arith.constant 8 : i32
  %v = arith.muli %c, %a : i32
  %s = arith.shrui %v, %c8 : i32
  %v1 = arith.addi %v, %c1 : i32
  %t = arith.addi %v1, %s : i32
  %r = arith.shrui %t, %c8 : i32
  return %r : i32
}
func.func private @round(%v: f32) -> i32 {
  %fh = arith.constant 0.5 : f32
  %f1 = arith.constant 1.0 : f32
  %f0 = arith.constant 0.0 : f32
  %f255 = arith.constant 255.0 : f32
  %fl = math.floor %v : f32
  %fr = arith.subf %v, %fl : f32
  %up = arith.cmpf oge, %fr, %fh : f32
  %fl1 = arith.addf %fl, %f1 : f32
  %r = arith.select %up, %fl1, %fl : f32
  %lo = arith.maxnumf %r, %f0 : f32
  %hi = arith.minnumf %lo, %f255 : f32
  %i = arith.fptoui %hi : f32 to i32
  return %i : i32
}
func.func private @pixel(%wh: i32) -> (i32, i32, i32, i32) {
  %c1 = arith.constant 1 : i32
  %c16 = arith.constant 16 : i32
  %cffff = arith.constant 65535 : i32
  %gx_ix1 = gpu.block_id x
  %gx = arith.index_cast %gx_ix1 : index to i32
  %gy_ix2 = gpu.block_id y
  %gy = arith.index_cast %gy_ix2 : index to i32
  %l_ix3 = gpu.thread_id x
  %l = arith.index_cast %l_ix3 : index to i32
  %w = arith.andi %wh, %cffff : i32
  %h = arith.shrui %wh, %c16 : i32
  %b = arith.muli %gx, %c16 : i32
  %x0 = arith.addi %b, %l : i32
  %last = arith.subi %w, %c1 : i32
  %x = arith.minsi %x0, %last : i32
  return %x, %gy, %w, %h : i32, i32, i32, i32
}
func.func private @get(%src: i32, %ss: i32, %x: i32, %y: i32) -> i32 {
  %c2 = arith.constant 2 : i32
  %row = arith.muli %y, %ss : i32
  %i = arith.addi %row, %x : i32
  %b = arith.shli %i, %c2 : i32
  %at = arith.addi %src, %b : i32
  %p_p4 = llvm.inttoptr %at : i32 to !llvm.ptr<1>
  %p = llvm.load %p_p4 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  return %p : i32
}
func.func private @put(%dst: i32, %ds: i32, %x: i32, %y: i32, %c: i32) {
  %c2 = arith.constant 2 : i32
  %row = arith.muli %y, %ds : i32
  %i = arith.addi %row, %x : i32
  %b = arith.shli %i, %c2 : i32
  %at = arith.addi %dst, %b : i32
  %st_p5 = llvm.inttoptr %at : i32 to !llvm.ptr<1>
  llvm.store %c, %st_p5 {alignment = 4 : i64} : i32, !llvm.ptr<1>
  return
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
  %w = arith.ori %rgb, %a24 : i32
  return %w : i32
}
func.func private @unpack(%w: i32) -> (i32, i32, i32, i32) {
  %c8 = arith.constant 8 : i32
  %c16 = arith.constant 16 : i32
  %c24 = arith.constant 24 : i32
  %cff = arith.constant 255 : i32
  %r = arith.andi %w, %cff : i32
  %g0 = arith.shrui %w, %c8 : i32
  %g = arith.andi %g0, %cff : i32
  %b0 = arith.shrui %w, %c16 : i32
  %b = arith.andi %b0, %cff : i32
  %a = arith.shrui %w, %c24 : i32
  return %r, %g, %b, %a : i32, i32, i32, i32
}
}
}
