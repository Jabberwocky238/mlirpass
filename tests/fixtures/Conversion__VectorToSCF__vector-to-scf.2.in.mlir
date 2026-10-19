#map = affine_map<() -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>) -> (), sym_name = "vector_transfer_ops_0d"}> ({
  ^bb0(%arg0: memref<f32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "vector.transfer_read"(%arg0, %0) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 0, 1, 0>, permutation_map = #map}> : (memref<f32>, f32) -> vector<f32>
    "vector.transfer_write"(%1, %arg0) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 0, 0>, permutation_map = #map}> : (vector<f32>, memref<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0)>
#map1 = affine_map<(d0) -> (d0 + 1)>
#map2 = affine_map<(d0) -> (d0 + 2)>
#map3 = affine_map<(d0) -> (d0 + 3)>
#map4 = affine_map<() -> (0)>
#map5 = affine_map<() -> (42)>
#map6 = affine_map<() -> (7)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "materialize_read_1d"}> ({
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<7x42xf32>
    "affine.for"() <{lowerBoundMap = #map4, operandSegmentSizes = array<i32: 0, 0, 0>, step = 4 : index, upperBoundMap = #map6}> ({
    ^bb0(%arg0: index):
      "affine.for"() <{lowerBoundMap = #map4, operandSegmentSizes = array<i32: 0, 0, 0>, step = 4 : index, upperBoundMap = #map5}> ({
      ^bb0(%arg1: index):
        %2 = "vector.transfer_read"(%1, %arg0, %arg1, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<7x42xf32>, index, index, f32) -> vector<4xf32>
        %3 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
        %4 = "vector.transfer_read"(%1, %arg0, %3, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<7x42xf32>, index, index, f32) -> vector<4xf32>
        %5 = "affine.apply"(%arg1) <{map = #map2}> : (index) -> index
        %6 = "vector.transfer_read"(%1, %arg0, %5, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<7x42xf32>, index, index, f32) -> vector<4xf32>
        %7 = "affine.apply"(%arg1) <{map = #map3}> : (index) -> index
        %8 = "vector.transfer_read"(%1, %arg0, %7, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<7x42xf32>, index, index, f32) -> vector<4xf32>
        "dummy_use"(%2, %4, %6, %8) : (vector<4xf32>, vector<4xf32>, vector<4xf32>, vector<4xf32>) -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d3)>
#map1 = affine_map<(d0) -> (d0 + 1)>
#map2 = affine_map<() -> (0)>
#map3 = affine_map<()[s0] -> (s0)>
#map4 = affine_map<() -> (42)>
#map5 = affine_map<() -> (7)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "materialize_read_1d_partially_specialized"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "memref.alloc"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 3, 0>}> : (index, index, index) -> memref<7x?x?x42x?xf32>
    "affine.for"() <{lowerBoundMap = #map2, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map5}> ({
    ^bb0(%arg3: index):
      "affine.for"(%arg0) <{lowerBoundMap = #map2, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map3}> ({
      ^bb0(%arg4: index):
        "affine.for"(%arg1) <{lowerBoundMap = #map2, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map3}> ({
        ^bb0(%arg5: index):
          "affine.for"() <{lowerBoundMap = #map2, operandSegmentSizes = array<i32: 0, 0, 0>, step = 2 : index, upperBoundMap = #map4}> ({
          ^bb0(%arg6: index):
            "affine.for"(%arg2) <{lowerBoundMap = #map2, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map3}> ({
            ^bb0(%arg7: index):
              %2 = "vector.transfer_read"(%1, %arg3, %arg4, %arg5, %arg6, %arg7, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 5, 1, 0>, permutation_map = #map}> : (memref<7x?x?x42x?xf32>, index, index, index, index, index, f32) -> vector<4xf32>
              %3 = "affine.apply"(%arg6) <{map = #map1}> : (index) -> index
              %4 = "vector.transfer_read"(%1, %arg3, %arg4, %arg5, %3, %arg7, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 5, 1, 0>, permutation_map = #map}> : (memref<7x?x?x42x?xf32>, index, index, index, index, index, f32) -> vector<4xf32>
              "dummy_use"(%2, %4) : (vector<4xf32>, vector<4xf32>) -> ()
              "affine.yield"() : () -> ()
            }) : (index) -> ()
            "affine.yield"() : () -> ()
          }) : () -> ()
          "affine.yield"() : () -> ()
        }) : (index) -> ()
        "affine.yield"() : () -> ()
      }) : (index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3, 0, d0)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<()[s0] -> (s0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index) -> (), sym_name = "materialize_read"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "memref.alloc"(%arg0, %arg1, %arg2, %arg3) <{operandSegmentSizes = array<i32: 4, 0>}> : (index, index, index, index) -> memref<?x?x?x?xf32>
    "affine.for"(%arg0) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 1, 0>, step = 3 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg4: index):
      "affine.for"(%arg1) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map2}> ({
      ^bb0(%arg5: index):
        "affine.for"(%arg2) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map2}> ({
        ^bb0(%arg6: index):
          "affine.for"(%arg3) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 1, 0>, step = 5 : index, upperBoundMap = #map2}> ({
          ^bb0(%arg7: index):
            %2 = "vector.transfer_read"(%1, %arg4, %arg5, %arg6, %arg7, %0) <{in_bounds = [false, false, false], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<5x4x3xf32>
            "dummy_use"(%2) : (vector<5x4x3xf32>) -> ()
            "affine.yield"() : () -> ()
          }) : (index) -> ()
          "affine.yield"() : () -> ()
        }) : (index) -> ()
        "affine.yield"() : () -> ()
      }) : (index) -> ()
      "affine.yield"() : () -> ()
    }) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3, d1, d0)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<()[s0] -> (s0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index) -> (), sym_name = "materialize_write"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index):
    %0 = "memref.alloc"(%arg0, %arg1, %arg2, %arg3) <{operandSegmentSizes = array<i32: 4, 0>}> : (index, index, index, index) -> memref<?x?x?x?xf32>
    %1 = "arith.constant"() <{value = dense<1.000000e+00> : vector<5x4x3xf32>}> : () -> vector<5x4x3xf32>
    "affine.for"(%arg0) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 1, 0>, step = 3 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg4: index):
      "affine.for"(%arg1) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 1, 0>, step = 4 : index, upperBoundMap = #map2}> ({
      ^bb0(%arg5: index):
        "affine.for"(%arg2) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map2}> ({
        ^bb0(%arg6: index):
          "affine.for"(%arg3) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 1, 0>, step = 5 : index, upperBoundMap = #map2}> ({
          ^bb0(%arg7: index):
            "vector.transfer_write"(%1, %0, %arg4, %arg5, %arg6, %arg7) <{in_bounds = [false, false, false], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<5x4x3xf32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
            "affine.yield"() : () -> ()
          }) : (index) -> ()
          "affine.yield"() : () -> ()
        }) : (index) -> ()
        "affine.yield"() : () -> ()
      }) : (index) -> ()
      "affine.yield"() : () -> ()
    }) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, index) -> vector<3x15xf32>, sym_name = "transfer_read_progressive"}> ({
  ^bb0(%arg0: memref<?x?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %1 = "vector.transfer_read"(%arg0, %arg1, %arg1, %0) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<3x15xf32>
    "func.return"(%1) : (vector<3x15xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, index, vector<3x15xf32>) -> (), sym_name = "transfer_write_progressive"}> ({
  ^bb0(%arg0: memref<?x?xf32>, %arg1: index, %arg2: vector<3x15xf32>):
    "vector.transfer_write"(%arg2, %arg0, %arg1, %arg1) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<3x15xf32>, memref<?x?xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, index, vector<3x15xf32>) -> (), sym_name = "transfer_write_progressive_inbounds"}> ({
  ^bb0(%arg0: memref<?x?xf32>, %arg1: index, %arg2: vector<3x15xf32>):
    "vector.transfer_write"(%arg2, %arg0, %arg1, %arg1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<3x15xf32>, memref<?x?xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x2xf32>) -> vector<2x2xf32>, sym_name = "transfer_read_simple"}> ({
  ^bb0(%arg3: memref<2x2xf32>):
    %5 = "arith.constant"() <{value = 0 : index}> : () -> index
    %6 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %7 = "vector.transfer_read"(%arg3, %5, %5, %6) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x2xf32>, index, index, f32) -> vector<2x2xf32>
    "func.return"(%7) : (vector<2x2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?x?x?xf32>) -> vector<3x3xf32>, sym_name = "transfer_read_minor_identity"}> ({
  ^bb0(%arg2: memref<?x?x?x?xf32>):
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "vector.transfer_read"(%arg2, %2, %2, %2, %2, %3) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map1}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<3x3xf32>
    "func.return"(%4) : (vector<3x3xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3x3xf32>, memref<?x?x?x?xf32>) -> (), sym_name = "transfer_write_minor_identity"}> ({
  ^bb0(%arg0: vector<3x3xf32>, %arg1: memref<?x?x?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "vector.transfer_write"(%arg0, %arg1, %0, %0, %0, %0) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map1}> : (vector<3x3xf32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0 + d1 * 8)>
#map1 = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x4xf32, #map>) -> vector<4xf32>, sym_name = "transfer_read_strided"}> ({
  ^bb0(%arg2: memref<8x4xf32, #map>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "vector.transfer_read"(%arg2, %1, %1, %2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<8x4xf32, #map>, index, index, f32) -> vector<4xf32>
    "func.return"(%3) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, memref<8x4xf32, #map>) -> (), sym_name = "transfer_write_strided"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: memref<8x4xf32, #map>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    "vector.transfer_write"(%arg0, %arg1, %0, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<4xf32>, memref<8x4xf32, #map>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xf32>) -> (), sym_name = "fake_side_effecting_fun", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x2xf32>) -> !async.token, sym_name = "transfer_read_within_async_execute"}> ({
  ^bb0(%arg0: memref<2x2xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "async.execute"() <{operandSegmentSizes = array<i32: 0, 0>}> ({
      %3 = "vector.transfer_read"(%arg0, %0, %0, %1) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x2xf32>, index, index, f32) -> vector<2x2xf32>
      "func.call"(%3) <{callee = @fake_side_effecting_fun}> : (vector<2x2xf32>) -> ()
      "async.yield"() : () -> ()
    }) : () -> !async.token
    "func.return"(%2) : (!async.token) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> (0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>) -> vector<1xf32>, sym_name = "transfer_read_with_tensor"}> ({
  ^bb0(%arg0: tensor<f32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "vector.transfer_read"(%arg0, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 0, 1, 0>, permutation_map = #map}> : (tensor<f32>, f32) -> vector<1xf32>
    "func.return"(%1) : (vector<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, f32) -> (), sym_name = "transfer_write_scalable"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: f32):
    %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "memref.dim"(%arg0, %1) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %3 = "llvm.intr.stepvector"() : () -> vector<[16]xi32>
    %4 = "arith.index_cast"(%2) : (index) -> i32
    %5 = "llvm.mlir.undef"() : () -> vector<[16]xi32>
    %6 = "llvm.insertelement"(%5, %4, %0) : (vector<[16]xi32>, i32, i32) -> vector<[16]xi32>
    %7 = "llvm.shufflevector"(%6, %5) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[16]xi32>, vector<[16]xi32>) -> vector<[16]xi32>
    %8 = "arith.cmpi"(%3, %7) <{predicate = 2 : i64}> : (vector<[16]xi32>, vector<[16]xi32>) -> vector<[16]xi1>
    %9 = "llvm.mlir.undef"() : () -> vector<[16]xf32>
    %10 = "llvm.insertelement"(%9, %arg1, %0) : (vector<[16]xf32>, f32, i32) -> vector<[16]xf32>
    %11 = "llvm.shufflevector"(%10, %9) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[16]xf32>, vector<[16]xf32>) -> vector<[16]xf32>
    "vector.transfer_write"(%11, %arg0, %1, %8) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 1>, permutation_map = #map}> : (vector<[16]xf32>, memref<?xf32, strided<[?], offset: ?>>, index, vector<[16]xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>) -> (), sym_name = "vector_print_vector_0d"}> ({
  ^bb0(%arg0: vector<f32>):
    "vector.print"(%arg0) <{punctuation = #vector.punctuation<newline>}> : (vector<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xf32>) -> (), sym_name = "vector_print_vector"}> ({
  ^bb0(%arg0: vector<2x2xf32>):
    "vector.print"(%arg0) <{punctuation = #vector.punctuation<newline>}> : (vector<2x2xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]xi32>) -> (), sym_name = "vector_print_scalable_vector"}> ({
  ^bb0(%arg0: vector<[4]xi32>):
    "vector.print"(%arg0) <{punctuation = #vector.punctuation<newline>}> : (vector<[4]xi32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<3x?xf32>) -> vector<3x[4]xf32>, sym_name = "transfer_read_array_of_scalable"}> ({
  ^bb0(%arg0: memref<3x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "memref.dim"(%arg0, %1) : (memref<3x?xf32>, index) -> index
    %4 = "vector.create_mask"(%1, %3) : (index, index) -> vector<3x[4]xi1>
    %5 = "vector.transfer_read"(%arg0, %0, %0, %2, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 1>, permutation_map = #map}> : (memref<3x?xf32>, index, index, f32, vector<3x[4]xi1>) -> vector<3x[4]xf32>
    "func.return"(%5) : (vector<3x[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3x[4]xf32>, memref<3x?xf32>) -> (), sym_name = "transfer_write_array_of_scalable"}> ({
  ^bb0(%arg0: vector<3x[4]xf32>, %arg1: memref<3x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "memref.dim"(%arg1, %1) : (memref<3x?xf32>, index) -> index
    %4 = "vector.create_mask"(%1, %3) : (index, index) -> vector<3x[4]xi1>
    "vector.transfer_write"(%arg0, %arg1, %0, %0, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 1>, permutation_map = #map}> : (vector<3x[4]xf32>, memref<3x?xf32>, index, index, vector<3x[4]xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]x4xf32>, memref<?x4xf32>) -> (), sym_name = "cannot_lower_transfer_write_with_leading_scalable"}> ({
  ^bb0(%arg0: vector<[4]x4xf32>, %arg1: memref<?x4xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 4 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "memref.dim"(%arg1, %0) : (memref<?x4xf32>, index) -> index
    %4 = "vector.create_mask"(%3, %1) : (index, index) -> vector<[4]x4xi1>
    "vector.transfer_write"(%arg0, %arg1, %0, %0, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 1>, permutation_map = #map}> : (vector<[4]x4xf32>, memref<?x4xf32>, index, index, vector<[4]x4xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, 0, 0, d3)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map3 = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x4xf32>) -> vector<[4]x4xf32>, sym_name = "cannot_lower_transfer_read_with_leading_scalable"}> ({
  ^bb0(%arg7: memref<?x4xf32>):
    %13 = "arith.constant"() <{value = 0 : index}> : () -> index
    %14 = "arith.constant"() <{value = 1 : index}> : () -> index
    %15 = "arith.constant"() <{value = 4 : index}> : () -> index
    %16 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %17 = "memref.dim"(%arg7, %13) : (memref<?x4xf32>, index) -> index
    %18 = "vector.create_mask"(%17, %15) : (index, index) -> vector<[4]x4xi1>
    %19 = "vector.transfer_read"(%arg7, %13, %13, %16, %18) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 1>, permutation_map = #map}> : (memref<?x4xf32>, index, index, f32, vector<[4]x4xi1>) -> vector<[4]x4xf32>
    "func.return"(%19) : (vector<[4]x4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1x1x1x1xi32>, vector<1x1xi1>) -> vector<1x1x1x1xi32>, sym_name = "does_not_crash_on_unpack_one_dim"}> ({
  ^bb0(%arg5: memref<1x1x1x1xi32>, %arg6: vector<1x1xi1>):
    %10 = "arith.constant"() <{value = 0 : index}> : () -> index
    %11 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %12 = "vector.transfer_read"(%arg5, %10, %10, %10, %10, %11, %arg6) <{in_bounds = [false, false, false, false], operandSegmentSizes = array<i32: 1, 4, 1, 1>, permutation_map = #map1}> : (memref<1x1x1x1xi32>, index, index, index, index, i32, vector<1x1xi1>) -> vector<1x1x1x1xi32>
    "func.return"(%12) : (vector<1x1x1x1xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1x2x?xf32>, memref<1x2x?xf32>) -> vector<1x2x[4]xf32>, sym_name = "add_arrays_of_scalable_vectors"}> ({
  ^bb0(%arg3: memref<1x2x?xf32>, %arg4: memref<1x2x?xf32>):
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 2 : index}> : () -> index
    %5 = "arith.constant"() <{value = 2 : index}> : () -> index
    %6 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %7 = "memref.dim"(%arg3, %4) : (memref<1x2x?xf32>, index) -> index
    %8 = "vector.create_mask"(%4, %5, %7) : (index, index, index) -> vector<1x2x[4]xi1>
    %9 = "vector.transfer_read"(%arg3, %3, %3, %3, %6, %8) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 1>, permutation_map = #map2}> : (memref<1x2x?xf32>, index, index, index, f32, vector<1x2x[4]xi1>) -> vector<1x2x[4]xf32>
    "func.return"(%9) : (vector<1x2x[4]xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<[4]x[4]xf32>, memref<?x?xf32>) -> (), sym_name = "cannot_fully_unroll_transfer_write_of_nd_scalable_vector"}> ({
  ^bb0(%arg1: vector<[4]x[4]xf32>, %arg2: memref<?x?xf32>):
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    "vector.transfer_write"(%arg1, %arg2, %2, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<[4]x[4]xf32>, memref<?x?xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi32>) -> (), sym_name = "unroll_transfer_write_target_rank_zero"}> ({
  ^bb0(%arg0: vector<2xi32>):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xi32>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    "vector.transfer_write"(%arg0, %0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map3}> : (vector<2xi32>, memref<4xi32>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x[4]xf32>, memref<?x?xf32>, index, index) -> (), sym_name = "scalable_transpose_store_unmasked"}> ({
  ^bb0(%arg0: vector<4x[4]xf32>, %arg1: memref<?x?xf32>, %arg2: index, %arg3: index):
    %0 = "vector.transpose"(%arg0) <{permutation = array<i64: 1, 0>}> : (vector<4x[4]xf32>) -> vector<[4]x4xf32>
    "vector.transfer_write"(%0, %arg1, %arg2, %arg3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<[4]x4xf32>, memref<?x?xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x[4]xf32>, memref<?x?xf32>, index, index, index, index) -> (), sym_name = "scalable_transpose_store_dynamic_mask"}> ({
  ^bb0(%arg0: vector<4x[4]xf32>, %arg1: memref<?x?xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: index):
    %0 = "vector.transpose"(%arg0) <{permutation = array<i64: 1, 0>}> : (vector<4x[4]xf32>) -> vector<[4]x4xf32>
    %1 = "vector.create_mask"(%arg4, %arg5) : (index, index) -> vector<[4]x4xi1>
    "vector.transfer_write"(%0, %arg1, %arg2, %arg3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 1>, permutation_map = #map}> : (vector<[4]x4xf32>, memref<?x?xf32>, index, index, vector<[4]x4xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x[4]xf32>, memref<?x?xf32>, index, index) -> (), sym_name = "scalable_transpose_store_constant_mask"}> ({
  ^bb0(%arg0: vector<4x[4]xf32>, %arg1: memref<?x?xf32>, %arg2: index, %arg3: index):
    %0 = "vector.transpose"(%arg0) <{permutation = array<i64: 1, 0>}> : (vector<4x[4]xf32>) -> vector<[4]x4xf32>
    %1 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 4, 3>}> : () -> vector<[4]x4xi1>
    "vector.transfer_write"(%0, %arg1, %arg2, %arg3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 1>, permutation_map = #map}> : (vector<[4]x4xf32>, memref<?x?xf32>, index, index, vector<[4]x4xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]x4xf32>, memref<?x?xf32>, index, index) -> (), sym_name = "negative_scalable_transpose_store_0"}> ({
  ^bb0(%arg0: vector<[4]x4xf32>, %arg1: memref<?x?xf32>, %arg2: index, %arg3: index):
    %0 = "vector.transpose"(%arg0) <{permutation = array<i64: 1, 0>}> : (vector<[4]x4xf32>) -> vector<4x[4]xf32>
    "vector.transfer_write"(%0, %arg1, %arg2, %arg3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<4x[4]xf32>, memref<?x?xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1, d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x[4]xf32>, memref<?x?xf32>, index, index) -> (), sym_name = "negative_scalable_transpose_store_1"}> ({
  ^bb0(%arg0: vector<4x[4]xf32>, %arg1: memref<?x?xf32>, %arg2: index, %arg3: index):
    %0 = "vector.transpose"(%arg0) <{permutation = array<i64: 1, 0>}> : (vector<4x[4]xf32>) -> vector<[4]x4xf32>
    "vector.transfer_write"(%0, %arg1, %arg2, %arg3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<[4]x4xf32>, memref<?x?xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x[4]xf32>, memref<?x?xf32>, index, index) -> (), sym_name = "negative_scalable_transpose_store_2"}> ({
  ^bb0(%arg0: vector<4x[4]xf32>, %arg1: memref<?x?xf32>, %arg2: index, %arg3: index):
    %0 = "vector.transpose"(%arg0) <{permutation = array<i64: 1, 0>}> : (vector<4x[4]xf32>) -> vector<[4]x4xf32>
    "vector.transfer_write"(%0, %arg1, %arg2, %arg3) <{in_bounds = [false, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<[4]x4xf32>, memref<?x?xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]x4xf32>, memref<?x?xf32>, index, index) -> (), sym_name = "negative_scalable_transpose_store_3"}> ({
  ^bb0(%arg0: vector<[4]x4xf32>, %arg1: memref<?x?xf32>, %arg2: index, %arg3: index):
    "vector.transfer_write"(%arg0, %arg1, %arg2, %arg3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<[4]x4xf32>, memref<?x?xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

