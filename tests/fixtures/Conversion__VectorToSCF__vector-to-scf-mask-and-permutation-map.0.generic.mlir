#map = affine_map<(d0)[s0] -> (d0 + s0)>
#map1 = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, index, index) -> vector<9x4xf32>, sym_name = "transfer_read_2d_mask_transposed"}> ({
  ^bb0(%arg0: memref<?x?xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = dense<-4.200000e+01> : vector<9xf32>}> : () -> vector<9xf32>
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 4 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = dense<[[true, false, true, false, true, true, true, false, true], [false, false, true, true, true, true, true, false, true], [true, true, true, true, true, true, true, false, true], [false, false, true, false, true, true, true, false, true]]> : vector<4x9xi1>}> : () -> vector<4x9xi1>
    %5 = "arith.constant"() <{value = -4.200000e+01 : f32}> : () -> f32
    %6 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<vector<4x9xf32>>
    %7 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<vector<4x9xi1>>
    "memref.store"(%4, %7) : (vector<4x9xi1>, memref<vector<4x9xi1>>) -> ()
    %8 = "vector.type_cast"(%6) : (memref<vector<4x9xf32>>) -> memref<4xvector<9xf32>>
    %9 = "vector.type_cast"(%7) : (memref<vector<4x9xi1>>) -> memref<4xvector<9xi1>>
    "scf.for"(%3, %2, %1) ({
    ^bb0(%arg3: index):
      %12 = "memref.dim"(%arg0, %3) : (memref<?x?xf32>, index) -> index
      %13 = "affine.apply"(%arg3, %arg1) <{map = #map}> : (index, index) -> index
      %14 = "arith.cmpi"(%12, %13) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%14) ({
        %15 = "affine.apply"(%arg3, %arg1) <{map = #map}> : (index, index) -> index
        %16 = "memref.load"(%9, %arg3) <{nontemporal = false}> : (memref<4xvector<9xi1>>, index) -> vector<9xi1>
        %17 = "vector.transfer_read"(%arg0, %15, %arg2, %5, %16) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 1>, permutation_map = #map1}> : (memref<?x?xf32>, index, index, f32, vector<9xi1>) -> vector<9xf32>
        "memref.store"(%17, %8, %arg3) <{nontemporal = false}> : (vector<9xf32>, memref<4xvector<9xf32>>, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "memref.store"(%0, %8, %arg3) <{nontemporal = false}> : (vector<9xf32>, memref<4xvector<9xf32>>, index) -> ()
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %10 = "memref.load"(%6) : (memref<vector<4x9xf32>>) -> vector<4x9xf32>
    %11 = "vector.transpose"(%10) <{permutation = array<i64: 1, 0>}> : (vector<4x9xf32>) -> vector<9x4xf32>
    "func.return"(%11) : (vector<9x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

