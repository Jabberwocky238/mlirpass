#map = affine_map<(d0)[s0] -> (d0 + s0)>
#map1 = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, index, index) -> vector<4x9xf32>, sym_name = "transfer_read_2d"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 4 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = -4.200000e+01 : f32}> : () -> f32
    %4 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<vector<4x9xf32>>
    %5 = "vector.type_cast"(%4) : (memref<vector<4x9xf32>>) -> memref<4xvector<9xf32>>
    "scf.for"(%2, %1, %0) ({
    ^bb0(%arg3: index):
      %7 = "affine.apply"(%arg3, %arg1) <{map = #map}> : (index, index) -> index
      %8 = "vector.transfer_read"(%arg0, %7, %arg2, %3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (tensor<?x?xf32>, index, index, f32) -> vector<9xf32>
      "memref.store"(%8, %5, %arg3) <{nontemporal = false}> : (vector<9xf32>, memref<4xvector<9xf32>>, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %6 = "memref.load"(%4) : (memref<vector<4x9xf32>>) -> vector<4x9xf32>
    "func.return"(%6) : (vector<4x9xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0] -> (d0 + s0)>
#map1 = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, vector<2x3xf32>, index, index) -> tensor<?x?xf32>, sym_name = "transfer_write_2d"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: vector<2x3xf32>, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<vector<2x3xf32>>
    "memref.store"(%arg1, %3) : (vector<2x3xf32>, memref<vector<2x3xf32>>) -> ()
    %4 = "vector.type_cast"(%3) : (memref<vector<2x3xf32>>) -> memref<2xvector<3xf32>>
    %5 = "scf.for"(%2, %1, %0, %arg0) ({
    ^bb0(%arg4: index, %arg5: tensor<?x?xf32>):
      %6 = "affine.apply"(%arg4, %arg2) <{map = #map}> : (index, index) -> index
      %7 = "memref.load"(%4, %arg4) <{nontemporal = false}> : (memref<2xvector<3xf32>>, index) -> vector<3xf32>
      %8 = "vector.transfer_write"(%7, %arg5, %6, %arg3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<3xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
      "scf.yield"(%8) : (tensor<?x?xf32>) -> ()
    }) : (index, index, index, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%5) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0] -> (d0 + s0)>
#map1 = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x[4]xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>, sym_name = "scalable_transpose_store"}> ({
  ^bb0(%arg0: vector<4x[4]xf32>, %arg1: tensor<?x?xf32>, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 4 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "vector.extract"(%arg0) <{static_position = array<i64: 0>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    %4 = "vector.extract"(%arg0) <{static_position = array<i64: 1>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    %5 = "vector.extract"(%arg0) <{static_position = array<i64: 2>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    %6 = "vector.extract"(%arg0) <{static_position = array<i64: 3>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    %7 = "vector.vscale"() : () -> index
    %8 = "arith.muli"(%7, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %9 = "scf.for"(%2, %8, %0, %arg1) ({
    ^bb0(%arg4: index, %arg5: tensor<?x?xf32>):
      %10 = "affine.apply"(%arg4, %arg2) <{map = #map}> : (index, index) -> index
      %11 = "vector.extract"(%3, %arg4) <{static_position = array<i64: -9223372036854775808>}> : (vector<[4]xf32>, index) -> f32
      %12 = "vector.extract"(%4, %arg4) <{static_position = array<i64: -9223372036854775808>}> : (vector<[4]xf32>, index) -> f32
      %13 = "vector.extract"(%5, %arg4) <{static_position = array<i64: -9223372036854775808>}> : (vector<[4]xf32>, index) -> f32
      %14 = "vector.extract"(%6, %arg4) <{static_position = array<i64: -9223372036854775808>}> : (vector<[4]xf32>, index) -> f32
      %15 = "vector.from_elements"(%11, %12, %13, %14) : (f32, f32, f32, f32) -> vector<4xf32>
      %16 = "vector.transfer_write"(%15, %arg5, %10, %arg3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<4xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
      "scf.yield"(%16) : (tensor<?x?xf32>) -> ()
    }) : (index, index, index, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%9) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

