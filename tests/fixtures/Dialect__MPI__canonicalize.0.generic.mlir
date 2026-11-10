"builtin.module"() ({
  "func.func"() <{function_type = (memref<100xf32>) -> (i32, i32), sym_name = "mpi_test"}> ({
  ^bb0(%arg0: memref<100xf32>):
    %0 = "arith.constant"() <{value = 12 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    "func.return"(%0, %1) : (i32, i32) -> ()
  }) : () -> ()
}) {mpi.dlti = #dlti.map<"MPI:comm_world_size" = 12 : i64, "MPI:comm_world_rank" = 5 : i64>} : () -> ()

