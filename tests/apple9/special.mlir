// The roundings of a value used once (its source released) for Apple9: invocation i reads a, b at src + 8 i and writes
// floor(a * b), ceil(a + b), trunc(a - b), roundeven(a * b + a) at dst + 16 i.
module attributes {gpu.container_module} {
gpu.module @shaders [#apple9.target<chip = "m4">] {
  gpu.func @special(%src: i32, %dst: i32) kernel {
  %g_ix = gpu.block_id x
  %g = arith.index_cast %g_ix : index to i32
  %l_ix = gpu.thread_id x
  %l = arith.index_cast %l_ix : index to i32
  %c8 = arith.constant 8 : i32
  %c16 = arith.constant 16 : i32
  %c32 = arith.constant 32 : i32
  %base = arith.muli %g, %c32 : i32
  %i = arith.addi %base, %l : i32
  %in = arith.muli %i, %c8 : i32
  %at = arith.addi %src, %in : i32
  %at_p = llvm.inttoptr %at : i32 to !llvm.ptr<1>
  %ab = llvm.load %at_p {alignment = 4 : i64} : !llvm.ptr<1> -> vector<2xf32>
  %a = vector.extract %ab[0] : f32 from vector<2xf32>
  %b = vector.extract %ab[1] : f32 from vector<2xf32>
  %m = arith.mulf %a, %b : f32
  %r0 = math.floor %m : f32
  %s = arith.addf %a, %b : f32
  %r1 = math.ceil %s : f32
  %d = arith.subf %a, %b : f32
  %r2 = math.trunc %d : f32
  %m2 = arith.mulf %a, %b : f32
  %e = arith.addf %m2, %a : f32
  %r3 = math.roundeven %e : f32
  %out = arith.muli %i, %c16 : i32
  %o = arith.addi %dst, %out : i32
  %v = vector.from_elements %r0, %r1, %r2, %r3 : vector<4xf32>
  %o_p = llvm.inttoptr %o : i32 to !llvm.ptr<1>
  llvm.store %v, %o_p {alignment = 4 : i64} : vector<4xf32>, !llvm.ptr<1>
  gpu.return
  }
}
}
