// acgpu's crates/intel/driver/src/copies/copy.mlir in upstream dialects.
module attributes {gpu.container_module} {
gpu.module @shaders [#xevm.target<chip = "ptl">] {
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
  %v_p1 = llvm.inttoptr %s : i32 to !llvm.ptr<1>
  %v = llvm.load %v_p1 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
  %st_p2 = llvm.inttoptr %d : i32 to !llvm.ptr<1>
  llvm.store %v, %st_p2 {alignment = 4 : i64} : i32, !llvm.ptr<1>
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
  %v_p3 = llvm.inttoptr %s : i32 to !llvm.ptr<1>
  %v_n4 = llvm.load %v_p3 {alignment = 1 : i64} : !llvm.ptr<1> -> i8
  %v = arith.extui %v_n4 : i8 to i32
  %st_p5 = llvm.inttoptr %d : i32 to !llvm.ptr<1>
  %st_t6 = arith.trunci %v : i32 to i8
  llvm.store %st_t6, %st_p5 {alignment = 1 : i64} : i8, !llvm.ptr<1>
  gpu.return
}
func.func private @unit(%wh: i32) -> (i32, i32) {
  %c1 = arith.constant 1 : i32
  %c16 = arith.constant 16 : i32
  %cffff = arith.constant 65535 : i32
  %gx_ix7 = gpu.block_id x
  %gx = arith.index_cast %gx_ix7 : index to i32
  %gy_ix8 = gpu.block_id y
  %gy = arith.index_cast %gy_ix8 : index to i32
  %l_ix9 = gpu.thread_id x
  %l = arith.index_cast %l_ix9 : index to i32
  %w = arith.andi %wh, %cffff : i32
  %b = arith.muli %gx, %c16 : i32
  %x0 = arith.addi %b, %l : i32
  %last = arith.subi %w, %c1 : i32
  %x = arith.minsi %x0, %last : i32
  return %x, %gy : i32, i32
}
}
}
