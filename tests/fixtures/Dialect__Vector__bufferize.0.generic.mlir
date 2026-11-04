#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, index, index, f32) -> vector<5x6xf32>, sym_name = "transfer_read"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: index, %arg2: index, %arg3: f32):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<?x?xf32>) -> memref<?x?xf32>
    %1 = "vector.transfer_read"(%0, %arg1, %arg2, %arg3) <{in_bounds = [true, false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<5x6xf32>
    "func.return"(%1) : (vector<5x6xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, index, index, vector<5x6xf32>, vector<5x6xi1>) -> tensor<?x?xf32>, sym_name = "transfer_write"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: index, %arg2: index, %arg3: vector<5x6xf32>, %arg4: vector<5x6xi1>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<?x?xf32>) -> memref<?x?xf32>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "memref.dim"(%0, %1) : (memref<?x?xf32>, index) -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "memref.dim"(%0, %3) : (memref<?x?xf32>, index) -> index
    %5 = "memref.alloc"(%2, %4) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
    "memref.copy"(%0, %5) : (memref<?x?xf32>, memref<?x?xf32>) -> ()
    "vector.transfer_write"(%arg3, %5, %arg1, %arg2, %arg4) <{in_bounds = [true, false], operandSegmentSizes = array<i32: 1, 1, 2, 1>, permutation_map = #map}> : (vector<5x6xf32>, memref<?x?xf32>, index, index, vector<5x6xi1>) -> ()
    %6 = "bufferization.to_tensor"(%5) : (memref<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%6) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<16x16xf32>, vector<16xi32>, vector<16xi1>, vector<16xf32>) -> tensor<16x16xf32>, sym_name = "scatter"}> ({
  ^bb0(%arg0: tensor<16x16xf32>, %arg1: vector<16xi32>, %arg2: vector<16xi1>, %arg3: vector<16xf32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<16x16xf32>) -> memref<16x16xf32>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16x16xf32>
    "memref.copy"(%0, %2) : (memref<16x16xf32>, memref<16x16xf32>) -> ()
    "vector.scatter"(%2, %1, %1, %arg1, %arg2, %arg3) : (memref<16x16xf32>, index, index, vector<16xi32>, vector<16xi1>, vector<16xf32>) -> ()
    %3 = "bufferization.to_tensor"(%2) : (memref<16x16xf32>) -> tensor<16x16xf32>
    "func.return"(%3) : (tensor<16x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, vector<16xi32>, vector<16xi1>, vector<16xf32>) -> vector<16xf32>, sym_name = "gather"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: vector<16xi32>, %arg2: vector<16xi1>, %arg3: vector<16xf32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<?x?xf32>) -> memref<?x?xf32>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "vector.gather"(%0, %1, %1, %arg1, %arg2, %arg3) : (memref<?x?xf32>, index, index, vector<16xi32>, vector<16xi1>, vector<16xf32>) -> vector<16xf32>
    "func.return"(%2) : (vector<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

