#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, index) -> vector<17xf32>, sym_name = "transfer_read_write_1d"}> ({
  ^bb0(%arg27: memref<?xf32>, %arg28: index):
    %27 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %28 = "vector.transfer_read"(%arg27, %arg28, %27) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<?xf32>, index, f32) -> vector<17xf32>
    "vector.transfer_write"(%28, %arg27, %arg28) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<17xf32>, memref<?xf32>, index) -> ()
    "func.return"(%28) : (vector<17xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index) -> vector<[17]xf32>, sym_name = "transfer_read_write_1d_scalable"}> ({
  ^bb0(%arg25: memref<?xf32>, %arg26: index):
    %25 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %26 = "vector.transfer_read"(%arg25, %arg26, %25) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<?xf32>, index, f32) -> vector<[17]xf32>
    "vector.transfer_write"(%26, %arg25, %arg26) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<[17]xf32>, memref<?xf32>, index) -> ()
    "func.return"(%26) : (vector<[17]xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xindex>, index) -> vector<17xindex>, sym_name = "transfer_read_write_index_1d"}> ({
  ^bb0(%arg23: memref<?xindex>, %arg24: index):
    %23 = "arith.constant"() <{value = 7 : index}> : () -> index
    %24 = "vector.transfer_read"(%arg23, %arg24, %23) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<?xindex>, index, index) -> vector<17xindex>
    "vector.transfer_write"(%24, %arg23, %arg24) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<17xindex>, memref<?xindex>, index) -> ()
    "func.return"(%24) : (vector<17xindex>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xindex>, index) -> vector<[17]xindex>, sym_name = "transfer_read_write_index_1d_scalable"}> ({
  ^bb0(%arg21: memref<?xindex>, %arg22: index):
    %21 = "arith.constant"() <{value = 7 : index}> : () -> index
    %22 = "vector.transfer_read"(%arg21, %arg22, %21) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<?xindex>, index, index) -> vector<[17]xindex>
    "vector.transfer_write"(%22, %arg21, %arg22) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<[17]xindex>, memref<?xindex>, index) -> ()
    "func.return"(%22) : (vector<[17]xindex>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf32>, index, index) -> vector<17xf32>, sym_name = "transfer_read_2d_to_1d"}> ({
  ^bb0(%arg18: memref<?x?xf32>, %arg19: index, %arg20: index):
    %19 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %20 = "vector.transfer_read"(%arg18, %arg19, %arg20, %19) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<?x?xf32>, index, index, f32) -> vector<17xf32>
    "func.return"(%20) : (vector<17xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf32>, index, index) -> vector<[17]xf32>, sym_name = "transfer_read_2d_to_1d_scalable"}> ({
  ^bb0(%arg15: memref<?x?xf32>, %arg16: index, %arg17: index):
    %17 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %18 = "vector.transfer_read"(%arg15, %arg16, %arg17, %17) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<?x?xf32>, index, index, f32) -> vector<[17]xf32>
    "func.return"(%18) : (vector<[17]xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, 3>, index) -> vector<17xf32>, sym_name = "transfer_read_write_1d_non_zero_addrspace"}> ({
  ^bb0(%arg13: memref<?xf32, 3>, %arg14: index):
    %15 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %16 = "vector.transfer_read"(%arg13, %arg14, %15) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<?xf32, 3>, index, f32) -> vector<17xf32>
    "vector.transfer_write"(%16, %arg13, %arg14) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<17xf32>, memref<?xf32, 3>, index) -> ()
    "func.return"(%16) : (vector<17xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, 3>, index) -> vector<[17]xf32>, sym_name = "transfer_read_write_1d_non_zero_addrspace_scalable"}> ({
  ^bb0(%arg11: memref<?xf32, 3>, %arg12: index):
    %13 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %14 = "vector.transfer_read"(%arg11, %arg12, %13) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<?xf32, 3>, index, f32) -> vector<[17]xf32>
    "vector.transfer_write"(%14, %arg11, %arg12) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<[17]xf32>, memref<?xf32, 3>, index) -> ()
    "func.return"(%14) : (vector<[17]xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index) -> vector<17xf32>, sym_name = "transfer_read_1d_inbounds"}> ({
  ^bb0(%arg9: memref<?xf32>, %arg10: index):
    %11 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %12 = "vector.transfer_read"(%arg9, %arg10, %11) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<?xf32>, index, f32) -> vector<17xf32>
    "func.return"(%12) : (vector<17xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index) -> vector<[17]xf32>, sym_name = "transfer_read_1d_inbounds_scalable"}> ({
  ^bb0(%arg7: memref<?xf32>, %arg8: index):
    %9 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %10 = "vector.transfer_read"(%arg7, %arg8, %9) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<?xf32>, index, f32) -> vector<[17]xf32>
    "func.return"(%10) : (vector<[17]xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index) -> vector<5xf32>, sym_name = "transfer_read_write_1d_mask"}> ({
  ^bb0(%arg5: memref<?xf32>, %arg6: index):
    %6 = "arith.constant"() <{value = dense<[false, false, true, false, true]> : vector<5xi1>}> : () -> vector<5xi1>
    %7 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %8 = "vector.transfer_read"(%arg5, %arg6, %7, %6) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 1>, permutation_map = #map}> : (memref<?xf32>, index, f32, vector<5xi1>) -> vector<5xf32>
    "vector.transfer_write"(%8, %arg5, %arg6, %6) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 1>, permutation_map = #map}> : (vector<5xf32>, memref<?xf32>, index, vector<5xi1>) -> ()
    "func.return"(%8) : (vector<5xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index, vector<[5]xi1>) -> vector<[5]xf32>, sym_name = "transfer_read_write_1d_mask_scalable"}> ({
  ^bb0(%arg2: memref<?xf32>, %arg3: index, %arg4: vector<[5]xi1>):
    %4 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %5 = "vector.transfer_read"(%arg2, %arg3, %4, %arg4) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 1>, permutation_map = #map}> : (memref<?xf32>, index, f32, vector<[5]xi1>) -> vector<[5]xf32>
    "vector.transfer_write"(%5, %arg2, %arg3, %arg4) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 1>, permutation_map = #map}> : (vector<[5]xf32>, memref<?xf32>, index, vector<[5]xi1>) -> ()
    "func.return"(%5) : (vector<[5]xf32>) -> ()
  }) : () -> ()
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

