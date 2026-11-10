"builtin.module"() ({
  "func.func"() <{function_type = (memref<100xf32>) -> (i32, i32), sym_name = "mpi_test"}> ({
  ^bb0(%arg0: memref<100xf32>):
    %0 = "mpi.comm_world"() : () -> !mpi.comm
    %1 = "mpi.comm_size"(%0) : (!mpi.comm) -> i32
    %2 = "mpi.comm_rank"(%0) : (!mpi.comm) -> i32
    "func.return"(%1, %2) : (i32, i32) -> ()
  }) : () -> ()
}) {mpi.dlti = #dlti.map<"MPI:comm_world_size" = 12 : i64, "MPI:comm_world_rank" = 5 : i64>} : () -> ()

