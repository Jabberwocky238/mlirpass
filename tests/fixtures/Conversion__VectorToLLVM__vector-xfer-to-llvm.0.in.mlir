#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, index) -> vector<17xf32>, sym_name = "transfer_read_write_1d"}> ({
  ^bb0(%arg2: memref<?xf32>, %arg3: index):
    %2 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %3 = "vector.transfer_read"(%arg2, %arg3, %2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<?xf32>, index, f32) -> vector<17xf32>
    "vector.transfer_write"(%3, %arg2, %arg3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<17xf32>, memref<?xf32>, index) -> ()
    "func.return"(%3) : (vector<17xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index) -> vector<[17]xf32>, sym_name = "transfer_read_write_1d_scalable"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %1 = "vector.transfer_read"(%arg0, %arg1, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<?xf32>, index, f32) -> vector<[17]xf32>
    "vector.transfer_write"(%1, %arg0, %arg1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<[17]xf32>, memref<?xf32>, index) -> ()
    "func.return"(%1) : (vector<[17]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xindex>, index) -> vector<17xindex>, sym_name = "transfer_read_write_index_1d"}> ({
  ^bb0(%arg2: memref<?xindex>, %arg3: index):
    %2 = "arith.constant"() <{value = 7 : index}> : () -> index
    %3 = "vector.transfer_read"(%arg2, %arg3, %2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<?xindex>, index, index) -> vector<17xindex>
    "vector.transfer_write"(%3, %arg2, %arg3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<17xindex>, memref<?xindex>, index) -> ()
    "func.return"(%3) : (vector<17xindex>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xindex>, index) -> vector<[17]xindex>, sym_name = "transfer_read_write_index_1d_scalable"}> ({
  ^bb0(%arg0: memref<?xindex>, %arg1: index):
    %0 = "arith.constant"() <{value = 7 : index}> : () -> index
    %1 = "vector.transfer_read"(%arg0, %arg1, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<?xindex>, index, index) -> vector<[17]xindex>
    "vector.transfer_write"(%1, %arg0, %arg1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<[17]xindex>, memref<?xindex>, index) -> ()
    "func.return"(%1) : (vector<[17]xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, index, index) -> vector<17xf32>, sym_name = "transfer_read_2d_to_1d"}> ({
  ^bb0(%arg3: memref<?x?xf32>, %arg4: index, %arg5: index):
    %2 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %3 = "vector.transfer_read"(%arg3, %arg4, %arg5, %2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<17xf32>
    "func.return"(%3) : (vector<17xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf32>, index, index) -> vector<[17]xf32>, sym_name = "transfer_read_2d_to_1d_scalable"}> ({
  ^bb0(%arg0: memref<?x?xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %1 = "vector.transfer_read"(%arg0, %arg1, %arg2, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<[17]xf32>
    "func.return"(%1) : (vector<[17]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, 3>, index) -> vector<17xf32>, sym_name = "transfer_read_write_1d_non_zero_addrspace"}> ({
  ^bb0(%arg2: memref<?xf32, 3>, %arg3: index):
    %2 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %3 = "vector.transfer_read"(%arg2, %arg3, %2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<?xf32, 3>, index, f32) -> vector<17xf32>
    "vector.transfer_write"(%3, %arg2, %arg3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<17xf32>, memref<?xf32, 3>, index) -> ()
    "func.return"(%3) : (vector<17xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, 3>, index) -> vector<[17]xf32>, sym_name = "transfer_read_write_1d_non_zero_addrspace_scalable"}> ({
  ^bb0(%arg0: memref<?xf32, 3>, %arg1: index):
    %0 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %1 = "vector.transfer_read"(%arg0, %arg1, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<?xf32, 3>, index, f32) -> vector<[17]xf32>
    "vector.transfer_write"(%1, %arg0, %arg1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<[17]xf32>, memref<?xf32, 3>, index) -> ()
    "func.return"(%1) : (vector<[17]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, index) -> vector<17xf32>, sym_name = "transfer_read_1d_inbounds"}> ({
  ^bb0(%arg2: memref<?xf32>, %arg3: index):
    %2 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %3 = "vector.transfer_read"(%arg2, %arg3, %2) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<?xf32>, index, f32) -> vector<17xf32>
    "func.return"(%3) : (vector<17xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index) -> vector<[17]xf32>, sym_name = "transfer_read_1d_inbounds_scalable"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %1 = "vector.transfer_read"(%arg0, %arg1, %0) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<?xf32>, index, f32) -> vector<[17]xf32>
    "func.return"(%1) : (vector<[17]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, index) -> vector<5xf32>, sym_name = "transfer_read_write_1d_mask"}> ({
  ^bb0(%arg3: memref<?xf32>, %arg4: index):
    %2 = "arith.constant"() <{value = dense<[false, false, true, false, true]> : vector<5xi1>}> : () -> vector<5xi1>
    %3 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %4 = "vector.transfer_read"(%arg3, %arg4, %3, %2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 1>, permutation_map = #map}> : (memref<?xf32>, index, f32, vector<5xi1>) -> vector<5xf32>
    "vector.transfer_write"(%4, %arg3, %arg4, %2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 1>, permutation_map = #map}> : (vector<5xf32>, memref<?xf32>, index, vector<5xi1>) -> ()
    "func.return"(%4) : (vector<5xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index, vector<[5]xi1>) -> vector<[5]xf32>, sym_name = "transfer_read_write_1d_mask_scalable"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: index, %arg2: vector<[5]xi1>):
    %0 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %1 = "vector.transfer_read"(%arg0, %arg1, %0, %arg2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 1>, permutation_map = #map}> : (memref<?xf32>, index, f32, vector<[5]xi1>) -> vector<[5]xf32>
    "vector.transfer_write"(%1, %arg0, %arg1, %arg2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 1>, permutation_map = #map}> : (vector<[5]xf32>, memref<?xf32>, index, vector<[5]xi1>) -> ()
    "func.return"(%1) : (vector<[5]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, index) -> vector<4xf32>, sym_name = "transfer_read_write_tensor"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "vector.transfer_read"(%arg0, %arg1, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (tensor<?xf32>, index, f32) -> vector<4xf32>
    %3 = "vector.transfer_write"(%2, %arg0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<4xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    "test.some_use"(%3) : (tensor<?xf32>) -> ()
    "func.return"(%2) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

