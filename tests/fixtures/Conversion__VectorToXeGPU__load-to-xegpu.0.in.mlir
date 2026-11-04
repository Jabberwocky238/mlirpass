"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x16x32xf32>, index) -> vector<8xf32>, sym_name = "load_1D_vector"}> ({
  ^bb0(%arg0: memref<8x16x32xf32>, %arg1: index):
    %0 = "vector.load"(%arg0, %arg1, %arg1, %arg1) : (memref<8x16x32xf32>, index, index, index) -> vector<8xf32>
    "func.return"(%0) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x16x32xf32>, index) -> vector<8x16xf32>, sym_name = "load_2D_vector"}> ({
  ^bb0(%arg0: memref<8x16x32xf32>, %arg1: index):
    %0 = "vector.load"(%arg0, %arg1, %arg1, %arg1) : (memref<8x16x32xf32>, index, index, index) -> vector<8x16xf32>
    "func.return"(%0) : (vector<8x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf32>, index, index, index) -> vector<8x16xf32>, sym_name = "load_dynamic_source"}> ({
  ^bb0(%arg0: memref<?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "vector.load"(%arg0, %arg1, %arg2, %arg3) : (memref<?x?x?xf32>, index, index, index) -> vector<8x16xf32>
    "func.return"(%0) : (vector<8x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<7x15xf32>, index) -> vector<8x16xf32>, sym_name = "load_out_of_bounds"}> ({
  ^bb0(%arg0: memref<7x15xf32>, %arg1: index):
    %0 = "vector.load"(%arg0, %arg1, %arg1) : (memref<7x15xf32>, index, index) -> vector<8x16xf32>
    "func.return"(%0) : (vector<8x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x32x64xf32>, index) -> vector<8x16x32xf32>, sym_name = "no_load_high_dim_vector"}> ({
  ^bb0(%arg0: memref<16x32x64xf32>, %arg1: index):
    %0 = "vector.load"(%arg0, %arg1, %arg1, %arg1) : (memref<16x32x64xf32>, index, index, index) -> vector<8x16x32xf32>
    "func.return"(%0) : (vector<8x16x32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<64xf32>, index) -> vector<f32>, sym_name = "no_load_zero_dim_vector"}> ({
  ^bb0(%arg0: memref<64xf32>, %arg1: index):
    %0 = "vector.load"(%arg0, %arg1) : (memref<64xf32>, index) -> vector<f32>
    "func.return"(%0) : (vector<f32>) -> ()
  }) : () -> ()
}) : () -> ()

