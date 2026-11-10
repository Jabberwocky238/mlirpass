"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<17xi32>, sym_name = "large_const"}> ({
    %0 = "tosa.const"() <{values = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : tensor<17xi32>}> : () -> tensor<17xi32>
    "func.return"(%0) : (tensor<17xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<16xi32>, sym_name = "small_const"}> ({
    %0 = "tosa.const"() <{values = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]> : tensor<16xi32>}> : () -> tensor<16xi32>
    "func.return"(%0) : (tensor<16xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> !tosa.shape<33>, sym_name = "large_const_shape"}> ({
    %0 = "tosa.const_shape"() <{values = dense<[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33]> : tensor<33xindex>}> : () -> !tosa.shape<33>
    "func.return"(%0) : (!tosa.shape<33>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> !tosa.shape<32>, sym_name = "small_const_shape"}> ({
    %0 = "tosa.const_shape"() <{values = dense<[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]> : tensor<32xindex>}> : () -> !tosa.shape<32>
    "func.return"(%0) : (!tosa.shape<32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (tensor<17xi32>, tensor<18xi32>, !tosa.shape<33>), sym_name = "mixed_large_constants"}> ({
    %0 = "tosa.const"() <{values = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : tensor<17xi32>}> : () -> tensor<17xi32>
    %1 = "tosa.const"() <{values = dense<[20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37]> : tensor<18xi32>}> : () -> tensor<18xi32>
    %2 = "tosa.const_shape"() <{values = dense<[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33]> : tensor<33xindex>}> : () -> !tosa.shape<33>
    "func.return"(%0, %1, %2) : (tensor<17xi32>, tensor<18xi32>, !tosa.shape<33>) -> ()
  }) : () -> ()
}) : () -> ()

