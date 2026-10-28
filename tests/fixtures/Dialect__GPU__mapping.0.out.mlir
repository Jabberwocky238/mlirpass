module {
  func.func @parallel_loop(%arg0: index, %arg1: index, %arg2: index, %arg3: index) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c4 = arith.constant 4 : index
    scf.parallel (%arg4, %arg5) = (%arg0, %arg1) to (%arg2, %arg3) step (%c4, %c4) {
      scf.parallel (%arg6, %arg7) = (%c0, %c0) to (%c4, %c4) step (%c1, %c1) {
        scf.reduce 
      } {mapping = [#gpu.loop_dim_map<processor = thread_x, map = (d0) -> (d0), bound = (d0) -> (d0)>, #gpu.loop_dim_map<processor = thread_y, map = (d0) -> (d0), bound = (d0) -> (d0)>]}
      scf.reduce 
    } {mapping = [#gpu.loop_dim_map<processor = block_x, map = (d0) -> (d0), bound = (d0) -> (d0)>, #gpu.loop_dim_map<processor = block_y, map = (d0) -> (d0), bound = (d0) -> (d0)>]}
    return
  }
}

// -----
module {
  func.func @parallel_loop_4d(%arg0: index, %arg1: index, %arg2: index, %arg3: index) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c4 = arith.constant 4 : index
    scf.parallel (%arg4, %arg5, %arg6, %arg7) = (%c0, %c0, %c0, %c0) to (%arg0, %arg1, %arg2, %arg3) step (%c4, %c4, %c4, %c4) {
      scf.parallel (%arg8, %arg9, %arg10, %arg11) = (%c0, %c0, %c0, %c0) to (%c4, %c4, %c4, %c4) step (%c1, %c1, %c1, %c1) {
        scf.parallel (%arg12, %arg13, %arg14, %arg15) = (%c0, %c0, %c0, %c0) to (%c4, %c4, %c4, %c4) step (%c1, %c1, %c1, %c1) {
          scf.reduce 
        } {mapping = [#gpu.loop_dim_map<processor = sequential, map = (d0) -> (d0), bound = (d0) -> (d0)>, #gpu.loop_dim_map<processor = sequential, map = (d0) -> (d0), bound = (d0) -> (d0)>, #gpu.loop_dim_map<processor = sequential, map = (d0) -> (d0), bound = (d0) -> (d0)>, #gpu.loop_dim_map<processor = sequential, map = (d0) -> (d0), bound = (d0) -> (d0)>]}
        scf.reduce 
      } {mapping = [#gpu.loop_dim_map<processor = thread_x, map = (d0) -> (d0), bound = (d0) -> (d0)>, #gpu.loop_dim_map<processor = thread_y, map = (d0) -> (d0), bound = (d0) -> (d0)>, #gpu.loop_dim_map<processor = thread_z, map = (d0) -> (d0), bound = (d0) -> (d0)>, #gpu.loop_dim_map<processor = sequential, map = (d0) -> (d0), bound = (d0) -> (d0)>]}
      scf.reduce 
    } {mapping = [#gpu.loop_dim_map<processor = block_x, map = (d0) -> (d0), bound = (d0) -> (d0)>, #gpu.loop_dim_map<processor = block_y, map = (d0) -> (d0), bound = (d0) -> (d0)>, #gpu.loop_dim_map<processor = block_z, map = (d0) -> (d0), bound = (d0) -> (d0)>, #gpu.loop_dim_map<processor = sequential, map = (d0) -> (d0), bound = (d0) -> (d0)>]}
    return
  }
}

