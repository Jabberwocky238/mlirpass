"builtin.module"() ({
  "func.func"() <{function_type = (vector<8xf32>, memref<8x16x32xf32>, index) -> (), sym_name = "store_1D_vector"}> ({
  ^bb0(%arg0: vector<8xf32>, %arg1: memref<8x16x32xf32>, %arg2: index):
    "vector.store"(%arg0, %arg1, %arg2, %arg2, %arg2) : (vector<8xf32>, memref<8x16x32xf32>, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8x16xf32>, memref<8x16x32xf32>, index) -> (), sym_name = "store_2D_vector"}> ({
  ^bb0(%arg0: vector<8x16xf32>, %arg1: memref<8x16x32xf32>, %arg2: index):
    "vector.store"(%arg0, %arg1, %arg2, %arg2, %arg2) : (vector<8x16xf32>, memref<8x16x32xf32>, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8x16xf32>, memref<?x?x?xf32>, index, index, index) -> (), sym_name = "store_dynamic_source"}> ({
  ^bb0(%arg0: vector<8x16xf32>, %arg1: memref<?x?x?xf32>, %arg2: index, %arg3: index, %arg4: index):
    "vector.store"(%arg0, %arg1, %arg2, %arg3, %arg4) : (vector<8x16xf32>, memref<?x?x?xf32>, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8x16xf32>, memref<7x64xf32>, index) -> (), sym_name = "store_out_of_bounds"}> ({
  ^bb0(%arg0: vector<8x16xf32>, %arg1: memref<7x64xf32>, %arg2: index):
    "vector.store"(%arg0, %arg1, %arg2, %arg2) : (vector<8x16xf32>, memref<7x64xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8x16x32xf32>, memref<16x32x64xf32>, index) -> (), sym_name = "no_store_high_dim_vector"}> ({
  ^bb0(%arg0: vector<8x16x32xf32>, %arg1: memref<16x32x64xf32>, %arg2: index):
    "vector.store"(%arg0, %arg1, %arg2, %arg2, %arg2) : (vector<8x16x32xf32>, memref<16x32x64xf32>, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>, memref<64xf32>, index) -> (), sym_name = "no_store_zero_dim_vector"}> ({
  ^bb0(%arg0: vector<f32>, %arg1: memref<64xf32>, %arg2: index):
    "vector.store"(%arg0, %arg1, %arg2) : (vector<f32>, memref<64xf32>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>, memref<?xvector<4xf32>>, index) -> (), sym_name = "no_store_vec_element_memref"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: memref<?xvector<4xf32>>, %arg2: index):
    "vector.store"(%arg0, %arg1, %arg2) : (vector<4xf32>, memref<?xvector<4xf32>>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

