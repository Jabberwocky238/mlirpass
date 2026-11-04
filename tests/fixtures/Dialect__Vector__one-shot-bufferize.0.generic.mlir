#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, vector<16xf32>, index, vector<16xi1>) -> memref<?xf32, strided<[?], offset: ?>>, sym_name = "mask"}> ({
  ^bb0(%arg4: memref<?xf32, strided<[?], offset: ?>>, %arg5: vector<16xf32>, %arg6: index, %arg7: vector<16xi1>):
    "vector.mask"(%arg7) ({
      "vector.transfer_write"(%arg5, %arg4, %arg6) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<16xf32>, memref<?xf32, strided<[?], offset: ?>>, index) -> ()
      "vector.yield"() : () -> ()
    }) : (vector<16xi1>) -> ()
    "func.return"(%arg4) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, vector<[16]xf32>, index, vector<[16]xi1>) -> memref<?xf32, strided<[?], offset: ?>>, sym_name = "mask_scalable"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: vector<[16]xf32>, %arg2: index, %arg3: vector<[16]xi1>):
    "vector.mask"(%arg3) ({
      "vector.transfer_write"(%arg1, %arg0, %arg2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<[16]xf32>, memref<?xf32, strided<[?], offset: ?>>, index) -> ()
      "vector.yield"() : () -> ()
    }) : (vector<[16]xi1>) -> ()
    "func.return"(%arg0) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5x10xf32, strided<[?, ?], offset: ?>>, vector<6x11xf32>) -> memref<5x10xf32, strided<[?, ?], offset: ?>>, sym_name = "non_reading_xfer_write"}> ({
  ^bb0(%arg0: memref<5x10xf32, strided<[?, ?], offset: ?>>, %arg1: vector<6x11xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    "vector.transfer_write"(%arg1, %arg0, %0, %0) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<6x11xf32>, memref<5x10xf32, strided<[?, ?], offset: ?>>, index, index) -> ()
    "func.return"(%arg0) : (memref<5x10xf32, strided<[?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5x10xf32, strided<[?, ?], offset: ?>>, vector<4x11xf32>) -> memref<5x10xf32, strided<[?, ?], offset: ?>>, sym_name = "reading_xfer_write"}> ({
  ^bb0(%arg0: memref<5x10xf32, strided<[?, ?], offset: ?>>, %arg1: vector<4x11xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    "vector.transfer_write"(%arg1, %arg0, %0, %0) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<4x11xf32>, memref<5x10xf32, strided<[?, ?], offset: ?>>, index, index) -> ()
    "func.return"(%arg0) : (memref<5x10xf32, strided<[?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

