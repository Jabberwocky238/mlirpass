// acgpu's crates/intel/driver/src/filters/blur.mlir in upstream dialects.
module attributes {gpu.container_module} {
gpu.module @shaders [#xevm.target<chip = "ptl">] {
gpu.func @blur_x(%src: i32, %ss: i32, %dst: i32, %ds: i32, %wh: i32, %kern: i32, %klen: i32) kernel {
  %x, %y, %w, %h = func.call @pixel(%wh, %wh) : (i32, i32) -> (i32, i32, i32, i32)
  %c1 = arith.constant 1 : i32
  %c = func.call @convolve(%src, %ss, %x, %y, %w, %kern, %klen, %c1) : (i32, i32, i32, i32, i32, i32, i32, i32) -> i32
  func.call @put(%dst, %ds, %x, %y, %c) : (i32, i32, i32, i32, i32) -> ()
  gpu.return
}
gpu.func @blur_y(%src: i32, %ss: i32, %dst: i32, %ds: i32, %wh: i32, %kern: i32, %klen: i32) kernel {
  %x, %y, %w, %h = func.call @pixel(%wh, %wh) : (i32, i32) -> (i32, i32, i32, i32)
  %c0 = arith.constant 0 : i32
  %c = func.call @convolve(%src, %ss, %y, %x, %h, %kern, %klen, %c0) : (i32, i32, i32, i32, i32, i32, i32, i32) -> i32
  func.call @put(%dst, %ds, %x, %y, %c) : (i32, i32, i32, i32, i32) -> ()
  gpu.return
}
gpu.func @down_x(%src: i32, %ss: i32, %dst: i32, %ds: i32, %swh: i32) kernel {
  %c1 = arith.constant 1 : i32
  %c16 = arith.constant 16 : i32
  %sw = func.call @low(%swh) : (i32) -> i32
  %sh = arith.shrui %swh, %c16 : i32
  %sw1 = arith.addi %sw, %c1 : i32
  %dw = arith.shrui %sw1, %c1 : i32
  %dwh0 = arith.shli %sh, %c16 : i32
  %dwh = arith.ori %dwh0, %dw : i32
  %x, %y, %w, %h = func.call @pixel(%dwh, %swh) : (i32, i32) -> (i32, i32, i32, i32)
  %c = func.call @decimate(%src, %ss, %x, %y, %sw, %c1) : (i32, i32, i32, i32, i32, i32) -> i32
  func.call @put(%dst, %ds, %x, %y, %c) : (i32, i32, i32, i32, i32) -> ()
  gpu.return
}
gpu.func @down_y(%src: i32, %ss: i32, %dst: i32, %ds: i32, %swh: i32) kernel {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c16 = arith.constant 16 : i32
  %sh = arith.shrui %swh, %c16 : i32
  %sh1 = arith.addi %sh, %c1 : i32
  %dh = arith.shrui %sh1, %c1 : i32
  %sw = func.call @low(%swh) : (i32) -> i32
  %dwh0 = arith.shli %dh, %c16 : i32
  %dwh = arith.ori %dwh0, %sw : i32
  %x, %y, %w, %h = func.call @pixel(%dwh, %swh) : (i32, i32) -> (i32, i32, i32, i32)
  %c = func.call @decimate(%src, %ss, %y, %x, %sh, %c0) : (i32, i32, i32, i32, i32, i32) -> i32
  func.call @put(%dst, %ds, %x, %y, %c) : (i32, i32, i32, i32, i32) -> ()
  gpu.return
}
gpu.func @up_x(%src: i32, %ss: i32, %dst: i32, %ds: i32, %swh: i32, %dw: i32) kernel {
  %c1 = arith.constant 1 : i32
  %c16 = arith.constant 16 : i32
  %sw = func.call @low(%swh) : (i32) -> i32
  %sh = arith.shrui %swh, %c16 : i32
  %dwh0 = arith.shli %sh, %c16 : i32
  %dwh = arith.ori %dwh0, %dw : i32
  %x, %y, %w, %h = func.call @pixel(%dwh, %swh) : (i32, i32) -> (i32, i32, i32, i32)
  %c = func.call @interpolate(%src, %ss, %x, %y, %sw, %c1) : (i32, i32, i32, i32, i32, i32) -> i32
  func.call @put(%dst, %ds, %x, %y, %c) : (i32, i32, i32, i32, i32) -> ()
  gpu.return
}
gpu.func @up_y(%src: i32, %ss: i32, %dst: i32, %ds: i32, %swh: i32, %dh: i32) kernel {
  %c0 = arith.constant 0 : i32
  %c16 = arith.constant 16 : i32
  %sw = func.call @low(%swh) : (i32) -> i32
  %sh = arith.shrui %swh, %c16 : i32
  %dwh0 = arith.shli %dh, %c16 : i32
  %dwh = arith.ori %dwh0, %sw : i32
  %x, %y, %w, %h = func.call @pixel(%dwh, %swh) : (i32, i32) -> (i32, i32, i32, i32)
  %c = func.call @interpolate(%src, %ss, %y, %x, %sh, %c0) : (i32, i32, i32, i32, i32, i32) -> i32
  func.call @put(%dst, %ds, %x, %y, %c) : (i32, i32, i32, i32, i32) -> ()
  gpu.return
}
func.func private @pixel(%dwh: i32, %unused: i32) -> (i32, i32, i32, i32) {
  %c1 = arith.constant 1 : i32
  %c16 = arith.constant 16 : i32
  %gx_ix1 = gpu.block_id x
  %gx = arith.index_cast %gx_ix1 : index to i32
  %gy_ix2 = gpu.block_id y
  %gy = arith.index_cast %gy_ix2 : index to i32
  %l_ix3 = gpu.thread_id x
  %l = arith.index_cast %l_ix3 : index to i32
  %w = func.call @low(%dwh) : (i32) -> i32
  %h = arith.shrui %dwh, %c16 : i32
  %b = arith.muli %gx, %c16 : i32
  %x0 = arith.addi %b, %l : i32
  %last = arith.subi %w, %c1 : i32
  %x = arith.minsi %x0, %last : i32
  return %x, %gy, %w, %h : i32, i32, i32, i32
}
func.func private @low(%v: i32) -> i32 {
  %cffff = arith.constant 65535 : i32
  %l = arith.andi %v, %cffff : i32
  return %l : i32
}
func.func private @sample(%src: i32, %ss: i32, %along: i32, %across: i32, %n: i32, %horizontal: i32) -> i32 {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c2 = arith.constant 2 : i32
  %last = arith.subi %n, %c1 : i32
  %lo = arith.maxsi %along, %c0 : i32
  %k = arith.minsi %lo, %last : i32
  %hz = arith.cmpi ne, %horizontal, %c0 : i32
  %x = arith.select %hz, %k, %across : i32
  %y = arith.select %hz, %across, %k : i32
  %row = arith.muli %y, %ss : i32
  %i = arith.addi %row, %x : i32
  %b = arith.shli %i, %c2 : i32
  %at = arith.addi %src, %b : i32
  %p_p4 = llvm.inttoptr %at : i32 to !llvm.ptr<1>
  %p = llvm.load %p_p4 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %below = arith.cmpi slt, %along, %c0 : i32
  %above = arith.cmpi sgt, %along, %last : i32
  %p1 = arith.select %below, %c0, %p : i32
  %p2 = arith.select %above, %c0, %p1 : i32
  return %p2 : i32
}
func.func private @convolve(%src: i32, %ss: i32, %along: i32, %across: i32, %n: i32, %kern: i32, %klen: i32, %hzi: i32) -> i32 {
  %c0 = arith.constant 0 : i32
  %c1 = arith.constant 1 : i32
  %c4 = arith.constant 4 : i32
  %f0 = arith.constant 0.0 : f32
  %r = arith.shrui %klen, %c1 : i32
  %start = arith.subi %along, %r : i32
  %acc:4 = scf.for %j = %c0 to %klen step %c1 iter_args(%ar = %f0, %ag = %f0, %ab = %f0, %aa = %f0) -> (f32, f32, f32, f32) : i32 {
    %s = arith.addi %start, %j : i32
    %p = func.call @sample(%src, %ss, %s, %across, %n, %hzi) : (i32, i32, i32, i32, i32, i32) -> i32
    %ko = arith.muli %j, %c4 : i32
    %kat = arith.addi %kern, %ko : i32
    %kb_p5 = llvm.inttoptr %kat : i32 to !llvm.ptr<1>
    %kb = llvm.load %kb_p5 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    %k = arith.bitcast %kb : i32 to f32
    %c:4 = func.call @unpack(%p) : (i32) -> (i32, i32, i32, i32)
    %fr = arith.uitofp %c#0 : i32 to f32
    %fg = arith.uitofp %c#1 : i32 to f32
    %fb = arith.uitofp %c#2 : i32 to f32
    %fa = arith.uitofp %c#3 : i32 to f32
    %tr = arith.mulf %fr, %k : f32
    %tg = arith.mulf %fg, %k : f32
    %tb = arith.mulf %fb, %k : f32
    %ta = arith.mulf %fa, %k : f32
    %nr = arith.addf %ar, %tr : f32
    %ng = arith.addf %ag, %tg : f32
    %nb = arith.addf %ab, %tb : f32
    %na = arith.addf %aa, %ta : f32
    scf.yield %nr, %ng, %nb, %na : f32, f32, f32, f32
  }
  %r8 = func.call @round(%acc#0) : (f32) -> i32
  %g8 = func.call @round(%acc#1) : (f32) -> i32
  %b8 = func.call @round(%acc#2) : (f32) -> i32
  %a8 = func.call @round(%acc#3) : (f32) -> i32
  %w = func.call @pack(%r8, %g8, %b8, %a8) : (i32, i32, i32, i32) -> i32
  return %w : i32
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
func.func private @decimate(%src: i32, %ss: i32, %along: i32, %across: i32, %n: i32, %horizontal: i32) -> i32 {
  %c1 = arith.constant 1 : i32
  %c2 = arith.constant 2 : i32
  %c3 = arith.constant 3 : i32
  %c4 = arith.constant 4 : i32
  %i2 = arith.shli %along, %c1 : i32
  %im = arith.subi %i2, %c1 : i32
  %ip = arith.addi %i2, %c1 : i32
  %ipp = arith.addi %i2, %c2 : i32
  %p0 = func.call @sample(%src, %ss, %im, %across, %n, %horizontal) : (i32, i32, i32, i32, i32, i32) -> i32
  %p1 = func.call @sample(%src, %ss, %i2, %across, %n, %horizontal) : (i32, i32, i32, i32, i32, i32) -> i32
  %p2 = func.call @sample(%src, %ss, %ip, %across, %n, %horizontal) : (i32, i32, i32, i32, i32, i32) -> i32
  %p3 = func.call @sample(%src, %ss, %ipp, %across, %n, %horizontal) : (i32, i32, i32, i32, i32, i32) -> i32
  %a:4 = func.call @unpack(%p0) : (i32) -> (i32, i32, i32, i32)
  %b:4 = func.call @unpack(%p1) : (i32) -> (i32, i32, i32, i32)
  %c:4 = func.call @unpack(%p2) : (i32) -> (i32, i32, i32, i32)
  %d:4 = func.call @unpack(%p3) : (i32) -> (i32, i32, i32, i32)
  %r = func.call @weigh4(%a#0, %b#0, %c#0, %d#0) : (i32, i32, i32, i32) -> i32
  %g = func.call @weigh4(%a#1, %b#1, %c#1, %d#1) : (i32, i32, i32, i32) -> i32
  %bb = func.call @weigh4(%a#2, %b#2, %c#2, %d#2) : (i32, i32, i32, i32) -> i32
  %aa = func.call @weigh4(%a#3, %b#3, %c#3, %d#3) : (i32, i32, i32, i32) -> i32
  %w = func.call @pack(%r, %g, %bb, %aa) : (i32, i32, i32, i32) -> i32
  return %w : i32
}
func.func private @weigh4(%p0: i32, %p1: i32, %p2: i32, %p3: i32) -> i32 {
  %c1 = arith.constant 1 : i32
  %c3 = arith.constant 3 : i32
  %c4 = arith.constant 4 : i32
  %t1 = arith.shli %p1, %c1 : i32
  %m1 = arith.addi %t1, %p1 : i32
  %t2 = arith.shli %p2, %c1 : i32
  %m2 = arith.addi %t2, %p2 : i32
  %s0 = arith.addi %p0, %m1 : i32
  %s1 = arith.addi %s0, %m2 : i32
  %s2 = arith.addi %s1, %p3 : i32
  %s3 = arith.addi %s2, %c4 : i32
  %r = arith.shrui %s3, %c3 : i32
  return %r : i32
}
func.func private @interpolate(%src: i32, %ss: i32, %along: i32, %across: i32, %n: i32, %horizontal: i32) -> i32 {
  %c1 = arith.constant 1 : i32
  %c0 = arith.constant 0 : i32
  %k = arith.shrui %along, %c1 : i32
  %odd = arith.andi %along, %c1 : i32
  %isodd = arith.cmpi ne, %odd, %c0 : i32
  %km = arith.subi %k, %c1 : i32
  %kp = arith.addi %k, %c1 : i32
  %o = arith.select %isodd, %kp, %km : i32
  %pk = func.call @sample(%src, %ss, %k, %across, %n, %horizontal) : (i32, i32, i32, i32, i32, i32) -> i32
  %po = func.call @sample(%src, %ss, %o, %across, %n, %horizontal) : (i32, i32, i32, i32, i32, i32) -> i32
  %a:4 = func.call @unpack(%pk) : (i32) -> (i32, i32, i32, i32)
  %b:4 = func.call @unpack(%po) : (i32) -> (i32, i32, i32, i32)
  %r = func.call @weigh2(%a#0, %b#0) : (i32, i32) -> i32
  %g = func.call @weigh2(%a#1, %b#1) : (i32, i32) -> i32
  %bb = func.call @weigh2(%a#2, %b#2) : (i32, i32) -> i32
  %aa = func.call @weigh2(%a#3, %b#3) : (i32, i32) -> i32
  %w = func.call @pack(%r, %g, %bb, %aa) : (i32, i32, i32, i32) -> i32
  return %w : i32
}
func.func private @weigh2(%near: i32, %far: i32) -> i32 {
  %c1 = arith.constant 1 : i32
  %c2 = arith.constant 2 : i32
  %t = arith.shli %near, %c1 : i32
  %m = arith.addi %t, %near : i32
  %s = arith.addi %m, %far : i32
  %s2 = arith.addi %s, %c2 : i32
  %r = arith.shrui %s2, %c2 : i32
  return %r : i32
}
func.func private @put(%dst: i32, %ds: i32, %x: i32, %y: i32, %c: i32) {
  %c2 = arith.constant 2 : i32
  %row = arith.muli %y, %ds : i32
  %i = arith.addi %row, %x : i32
  %b = arith.shli %i, %c2 : i32
  %at = arith.addi %dst, %b : i32
  %st_p6 = llvm.inttoptr %at : i32 to !llvm.ptr<1>
  llvm.store %c, %st_p6 {alignment = 4 : i64} : i32, !llvm.ptr<1>
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
