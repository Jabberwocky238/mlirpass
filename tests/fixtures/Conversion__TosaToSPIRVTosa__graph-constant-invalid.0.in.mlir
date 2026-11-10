"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<17xi32>, sym_name = "graph_constant_id_i64"}> ({
    %0 = "tosa.const"() <{values = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : tensor<17xi32>}> {grapharm.graph_constant_id = 7 : i64} : () -> tensor<17xi32>
    "func.return"(%0) : (tensor<17xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<17xi32>, sym_name = "graph_constant_id_si32"}> ({
    %0 = "tosa.const"() <{values = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : tensor<17xi32>}> {grapharm.graph_constant_id = 7 : si32} : () -> tensor<17xi32>
    "func.return"(%0) : (tensor<17xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<17xi32>, sym_name = "graph_constant_id_ui32"}> ({
    %0 = "tosa.const"() <{values = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : tensor<17xi32>}> {grapharm.graph_constant_id = 7 : ui32} : () -> tensor<17xi32>
    "func.return"(%0) : (tensor<17xi32>) -> ()
  }) : () -> ()
}) : () -> ()

