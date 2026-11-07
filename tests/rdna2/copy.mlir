// acgpu's src/copies/copy.mlir in upstream dialects.
module attributes {gpu.container_module} {
gpu.module @shaders [#rocdl.target<chip = "gfx1036">] {

  gpu.func @copy_words(%src: i32, %ss: i32, %dst: i32, %ds: i32, %wh: i32) kernel {
  %c2 = arith.constant 2 : i32
  %x, %y = func.call @unit(%wh) : (i32) -> (i32, i32)
  %xb = arith.shli %x, %c2 : i32
  %sr = arith.muli %y, %ss : i32
  %s0 = arith.addi %src, %sr : i32
  %s = arith.addi %s0, %xb : i32
  %dr = arith.muli %y, %ds : i32
  %d0 = arith.addi %dst, %dr : i32
  %d = arith.addi %d0, %xb : i32
  %s_p = llvm.inttoptr %s : i32 to !llvm.ptr<1>
  %v = llvm.load %s_p {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %d_p = llvm.inttoptr %d : i32 to !llvm.ptr<1>
  llvm.store %v, %d_p {alignment = 4 : i64} : i32, !llvm.ptr<1>
  gpu.return
}

  gpu.func @copy_bytes(%src: i32, %ss: i32, %dst: i32, %ds: i32, %wh: i32) kernel {
  %x, %y = func.call @unit(%wh) : (i32) -> (i32, i32)
  %sr = arith.muli %y, %ss : i32
  %s0 = arith.addi %src, %sr : i32
  %s = arith.addi %s0, %x : i32
  %dr = arith.muli %y, %ds : i32
  %d0 = arith.addi %dst, %dr : i32
  %d = arith.addi %d0, %x : i32
  %s_p = llvm.inttoptr %s : i32 to !llvm.ptr<1>
  %v_n = llvm.load %s_p {alignment = 1 : i64} : !llvm.ptr<1> -> i8
  %v = arith.extui %v_n : i8 to i32
  %d_p = llvm.inttoptr %d : i32 to !llvm.ptr<1>
  %v_t = arith.trunci %v : i32 to i8
  llvm.store %v_t, %d_p {alignment = 1 : i64} : i8, !llvm.ptr<1>
  gpu.return
}

  func.func private @unit(%wh: i32) -> (i32, i32) {
  %c1 = arith.constant 1 : i32
  %c16 = arith.constant 16 : i32
  %cffff = arith.constant 65535 : i32
  %gx_ix = gpu.block_id x
  %gx = arith.index_cast %gx_ix : index to i32
  %gy_ix = gpu.block_id y
  %gy = arith.index_cast %gy_ix : index to i32
  %l_ix = gpu.thread_id x
  %l = arith.index_cast %l_ix : index to i32
  %w = arith.andi %wh, %cffff : i32
  %b = arith.muli %gx, %c16 : i32
  %x0 = arith.addi %b, %l : i32
  %last = arith.subi %w, %c1 : i32
  %x = arith.minsi %x0, %last : i32
  return %x, %gy : i32, i32
}
}
}
