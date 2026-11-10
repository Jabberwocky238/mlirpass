"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<17xi32>, sym_name = "pre_marked_const"}> ({
    %0 = "tosa.const"() <{values = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : tensor<17xi32>}> {grapharm.graph_constant_id = 7 : i32} : () -> tensor<17xi32>
    "func.return"(%0) : (tensor<17xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> !tosa.shape<33>, sym_name = "pre_marked_const_shape"}> ({
    %0 = "tosa.const_shape"() <{values = dense<[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33]> : tensor<33xindex>}> {grapharm.graph_constant_id = 8 : i32} : () -> !tosa.shape<33>
    "func.return"(%0) : (!tosa.shape<33>) -> ()
  }) : () -> ()
}) : () -> ()

