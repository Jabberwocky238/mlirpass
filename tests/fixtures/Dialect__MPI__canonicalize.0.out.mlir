module attributes {mpi.dlti = #dlti.map<"MPI:comm_world_size" = 12 : i64, "MPI:comm_world_rank" = 5 : i64>} {
  func.func @mpi_test(%arg0: memref<100xf32>) -> (i32, i32) {
    %c12_i32 = arith.constant 12 : i32
    %c5_i32 = arith.constant 5 : i32
    return %c12_i32, %c5_i32 : i32, i32
  }
}

