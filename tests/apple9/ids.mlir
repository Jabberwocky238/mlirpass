// The ids of a 3 × 2 × 2 grid of workgroups for Apple9: invocation (g, l) writes at dst + 48 k, k its number in the
// grid (((g.z * 2 + g.y) * 3 + g.x) * 32 + l.x), the twelve words g.x, g.y, g.z, l.x, l.y, l.z, k, 0, 0, block.x,
// block.y, block.z.
module attributes {gpu.container_module} {
gpu.module @shaders [#apple9.target<chip = "m4">] {
  gpu.func @ids(%dst: i32) kernel {
  %gx_ix = gpu.block_id x
  %gy_ix = gpu.block_id y
  %gz_ix = gpu.block_id z
  %lx_ix = gpu.thread_id x
  %ly_ix = gpu.thread_id y
  %lz_ix = gpu.thread_id z
  %bx_ix = gpu.block_dim x
  %by_ix = gpu.block_dim y
  %bz_ix = gpu.block_dim z
  %gx = arith.index_cast %gx_ix : index to i32
  %gy = arith.index_cast %gy_ix : index to i32
  %gz = arith.index_cast %gz_ix : index to i32
  %lx = arith.index_cast %lx_ix : index to i32
  %ly = arith.index_cast %ly_ix : index to i32
  %lz = arith.index_cast %lz_ix : index to i32
  %bx = arith.index_cast %bx_ix : index to i32
  %by = arith.index_cast %by_ix : index to i32
  %bz = arith.index_cast %bz_ix : index to i32
  %c32 = arith.constant 32 : i32
  %nx = arith.constant 3 : i32
  %ny = arith.constant 2 : i32
  %c0 = arith.constant 0 : i32
  %c48 = arith.constant 48 : i32
  %c16 = arith.constant 16 : i32
  %zy = arith.muli %gz, %ny : i32
  %zyy = arith.addi %zy, %gy : i32
  %zyx = arith.muli %zyy, %nx : i32
  %g = arith.addi %zyx, %gx : i32
  %g32 = arith.muli %g, %c32 : i32
  %k = arith.addi %g32, %lx : i32
  %o = arith.muli %k, %c48 : i32
  %o0 = arith.addi %dst, %o : i32
  %o1 = arith.addi %o0, %c16 : i32
  %o2 = arith.addi %o1, %c16 : i32
  %v0 = vector.from_elements %gx, %gy, %gz, %lx : vector<4xi32>
  %v1 = vector.from_elements %ly, %lz, %k, %c0 : vector<4xi32>
  %v2 = vector.from_elements %c0, %bx, %by, %bz : vector<4xi32>
  %p0 = llvm.inttoptr %o0 : i32 to !llvm.ptr<1>
  llvm.store %v0, %p0 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr<1>
  %p1 = llvm.inttoptr %o1 : i32 to !llvm.ptr<1>
  llvm.store %v1, %p1 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr<1>
  %p2 = llvm.inttoptr %o2 : i32 to !llvm.ptr<1>
  llvm.store %v2, %p2 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr<1>
  gpu.return
  }
}
}
