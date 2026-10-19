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
#map = affine_map<(d0, d1) -> (d0 + d1)>
#map1 = affine_map<(d0) -> (d0 + 1)>
#map2 = affine_map<(d0) -> (d0 + 2)>
#map3 = affine_map<(d0) -> (d0 + 3)>
#map4 = affine_map<() -> (0)>
#map5 = affine_map<() -> (42)>
#map6 = affine_map<() -> (7)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "materialize_read_1d"}> ({
    %0 = "arith.constant"() <{value = 7 : index}> : () -> index
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 4 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<7x42xf32>
    "affine.for"() <{lowerBoundMap = #map4, operandSegmentSizes = array<i32: 0, 0, 0>, step = 4 : index, upperBoundMap = #map6}> ({
    ^bb0(%arg0: index):
      "affine.for"() <{lowerBoundMap = #map4, operandSegmentSizes = array<i32: 0, 0, 0>, step = 4 : index, upperBoundMap = #map5}> ({
      ^bb0(%arg1: index):
        %6 = "scf.for"(%4, %3, %2, %1) ({
        ^bb0(%arg8: index, %arg9: vector<4xf32>):
          %31 = "affine.apply"(%arg0, %arg8) <{map = #map}> : (index, index) -> index
          %32 = "affine.apply"(%arg0, %arg8) <{map = #map}> : (index, index) -> index
          %33 = "arith.cmpi"(%32, %0) <{predicate = 2 : i64}> : (index, index) -> i1
          %34 = "scf.if"(%33) ({
            %35 = "memref.load"(%5, %31, %arg1) <{nontemporal = false}> : (memref<7x42xf32>, index, index) -> f32
            %36 = "vector.insert"(%35, %arg9, %arg8) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<4xf32>, index) -> vector<4xf32>
            "scf.yield"(%36) : (vector<4xf32>) -> ()
          }, {
            "scf.yield"(%arg9) : (vector<4xf32>) -> ()
          }) : (i1) -> vector<4xf32>
          "scf.yield"(%34) : (vector<4xf32>) -> ()
        }) : (index, index, index, vector<4xf32>) -> vector<4xf32>
        %7 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
        %8 = "scf.for"(%4, %3, %2, %1) ({
        ^bb0(%arg6: index, %arg7: vector<4xf32>):
          %25 = "affine.apply"(%arg0, %arg6) <{map = #map}> : (index, index) -> index
          %26 = "affine.apply"(%arg0, %arg6) <{map = #map}> : (index, index) -> index
          %27 = "arith.cmpi"(%26, %0) <{predicate = 2 : i64}> : (index, index) -> i1
          %28 = "scf.if"(%27) ({
            %29 = "memref.load"(%5, %25, %7) <{nontemporal = false}> : (memref<7x42xf32>, index, index) -> f32
            %30 = "vector.insert"(%29, %arg7, %arg6) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<4xf32>, index) -> vector<4xf32>
            "scf.yield"(%30) : (vector<4xf32>) -> ()
          }, {
            "scf.yield"(%arg7) : (vector<4xf32>) -> ()
          }) : (i1) -> vector<4xf32>
          "scf.yield"(%28) : (vector<4xf32>) -> ()
        }) : (index, index, index, vector<4xf32>) -> vector<4xf32>
        %9 = "affine.apply"(%arg1) <{map = #map2}> : (index) -> index
        %10 = "scf.for"(%4, %3, %2, %1) ({
        ^bb0(%arg4: index, %arg5: vector<4xf32>):
          %19 = "affine.apply"(%arg0, %arg4) <{map = #map}> : (index, index) -> index
          %20 = "affine.apply"(%arg0, %arg4) <{map = #map}> : (index, index) -> index
          %21 = "arith.cmpi"(%20, %0) <{predicate = 2 : i64}> : (index, index) -> i1
          %22 = "scf.if"(%21) ({
            %23 = "memref.load"(%5, %19, %9) <{nontemporal = false}> : (memref<7x42xf32>, index, index) -> f32
            %24 = "vector.insert"(%23, %arg5, %arg4) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<4xf32>, index) -> vector<4xf32>
            "scf.yield"(%24) : (vector<4xf32>) -> ()
          }, {
            "scf.yield"(%arg5) : (vector<4xf32>) -> ()
          }) : (i1) -> vector<4xf32>
          "scf.yield"(%22) : (vector<4xf32>) -> ()
        }) : (index, index, index, vector<4xf32>) -> vector<4xf32>
        %11 = "affine.apply"(%arg1) <{map = #map3}> : (index) -> index
        %12 = "scf.for"(%4, %3, %2, %1) ({
        ^bb0(%arg2: index, %arg3: vector<4xf32>):
          %13 = "affine.apply"(%arg0, %arg2) <{map = #map}> : (index, index) -> index
          %14 = "affine.apply"(%arg0, %arg2) <{map = #map}> : (index, index) -> index
          %15 = "arith.cmpi"(%14, %0) <{predicate = 2 : i64}> : (index, index) -> i1
          %16 = "scf.if"(%15) ({
            %17 = "memref.load"(%5, %13, %11) <{nontemporal = false}> : (memref<7x42xf32>, index, index) -> f32
            %18 = "vector.insert"(%17, %arg3, %arg2) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<4xf32>, index) -> vector<4xf32>
            "scf.yield"(%18) : (vector<4xf32>) -> ()
          }, {
            "scf.yield"(%arg3) : (vector<4xf32>) -> ()
          }) : (i1) -> vector<4xf32>
          "scf.yield"(%16) : (vector<4xf32>) -> ()
        }) : (index, index, index, vector<4xf32>) -> vector<4xf32>
        "dummy_use"(%6, %8, %10, %12) : (vector<4xf32>, vector<4xf32>, vector<4xf32>, vector<4xf32>) -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0 + d1)>
#map1 = affine_map<(d0, d1) -> (d0 + d1 + 1)>
#map2 = affine_map<() -> (0)>
#map3 = affine_map<()[s0] -> (s0)>
#map4 = affine_map<() -> (42)>
#map5 = affine_map<() -> (7)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "materialize_read_1d_partially_specialized"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 42 : index}> : () -> index
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 4 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "memref.alloc"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 3, 0>}> : (index, index, index) -> memref<7x?x?x42x?xf32>
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
              %6 = "scf.for"(%4, %3, %2, %1) ({
              ^bb0(%arg10: index, %arg11: vector<4xf32>):
                %14 = "affine.apply"(%arg6, %arg10) <{map = #map}> : (index, index) -> index
                %15 = "affine.apply"(%arg6, %arg10) <{map = #map}> : (index, index) -> index
                %16 = "arith.cmpi"(%15, %0) <{predicate = 2 : i64}> : (index, index) -> i1
                %17 = "scf.if"(%16) ({
                  %18 = "memref.load"(%5, %arg3, %arg4, %arg5, %14, %arg7) <{nontemporal = false}> : (memref<7x?x?x42x?xf32>, index, index, index, index, index) -> f32
                  %19 = "vector.insert"(%18, %arg11, %arg10) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<4xf32>, index) -> vector<4xf32>
                  "scf.yield"(%19) : (vector<4xf32>) -> ()
                }, {
                  "scf.yield"(%arg11) : (vector<4xf32>) -> ()
                }) : (i1) -> vector<4xf32>
                "scf.yield"(%17) : (vector<4xf32>) -> ()
              }) : (index, index, index, vector<4xf32>) -> vector<4xf32>
              %7 = "scf.for"(%4, %3, %2, %1) ({
              ^bb0(%arg8: index, %arg9: vector<4xf32>):
                %8 = "affine.apply"(%arg8, %arg6) <{map = #map1}> : (index, index) -> index
                %9 = "affine.apply"(%arg8, %arg6) <{map = #map1}> : (index, index) -> index
                %10 = "arith.cmpi"(%9, %0) <{predicate = 2 : i64}> : (index, index) -> i1
                %11 = "scf.if"(%10) ({
                  %12 = "memref.load"(%5, %arg3, %arg4, %arg5, %8, %arg7) <{nontemporal = false}> : (memref<7x?x?x42x?xf32>, index, index, index, index, index) -> f32
                  %13 = "vector.insert"(%12, %arg9, %arg8) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<4xf32>, index) -> vector<4xf32>
                  "scf.yield"(%13) : (vector<4xf32>) -> ()
                }, {
                  "scf.yield"(%arg9) : (vector<4xf32>) -> ()
                }) : (i1) -> vector<4xf32>
                "scf.yield"(%11) : (vector<4xf32>) -> ()
              }) : (index, index, index, vector<4xf32>) -> vector<4xf32>
              "dummy_use"(%6, %7) : (vector<4xf32>, vector<4xf32>) -> ()
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
#map = affine_map<(d0, d1) -> (d0 + d1)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<()[s0] -> (s0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index) -> (), sym_name = "materialize_read"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<3xf32>}> : () -> vector<3xf32>
    %1 = "arith.constant"() <{value = 3 : index}> : () -> index
    %2 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4x3xf32>}> : () -> vector<4x3xf32>
    %3 = "arith.constant"() <{value = 4 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "arith.constant"() <{value = 5 : index}> : () -> index
    %6 = "arith.constant"() <{value = 0 : index}> : () -> index
    %7 = "memref.alloc"(%arg0, %arg1, %arg2, %arg3) <{operandSegmentSizes = array<i32: 4, 0>}> : (index, index, index, index) -> memref<?x?x?x?xf32>
    "affine.for"(%arg0) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 1, 0>, step = 3 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg4: index):
      "affine.for"(%arg1) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map2}> ({
      ^bb0(%arg5: index):
        "affine.for"(%arg2) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map2}> ({
        ^bb0(%arg6: index):
          "affine.for"(%arg3) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 1, 0>, step = 5 : index, upperBoundMap = #map2}> ({
          ^bb0(%arg7: index):
            %8 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<vector<5x4x3xf32>>
            %9 = "vector.type_cast"(%8) : (memref<vector<5x4x3xf32>>) -> memref<5xvector<4x3xf32>>
            "scf.for"(%6, %5, %4) ({
            ^bb0(%arg8: index):
              %11 = "affine.apply"(%arg7, %arg8) <{map = #map}> : (index, index) -> index
              %12 = "arith.cmpi"(%arg3, %11) <{predicate = 4 : i64}> : (index, index) -> i1
              "scf.if"(%12) ({
                %13 = "affine.apply"(%arg7, %arg8) <{map = #map}> : (index, index) -> index
                %14 = "vector.type_cast"(%9) : (memref<5xvector<4x3xf32>>) -> memref<5x4xvector<3xf32>>
                "scf.for"(%6, %3, %4) ({
                ^bb0(%arg9: index):
                  %15 = "scf.for"(%6, %1, %4, %0) ({
                  ^bb0(%arg10: index, %arg11: vector<3xf32>):
                    %16 = "affine.apply"(%arg4, %arg10) <{map = #map}> : (index, index) -> index
                    %17 = "affine.apply"(%arg4, %arg10) <{map = #map}> : (index, index) -> index
                    %18 = "arith.cmpi"(%arg0, %17) <{predicate = 4 : i64}> : (index, index) -> i1
                    %19 = "scf.if"(%18) ({
                      %20 = "memref.load"(%7, %16, %arg5, %arg6, %13) <{nontemporal = false}> : (memref<?x?x?x?xf32>, index, index, index, index) -> f32
                      %21 = "vector.insert"(%20, %arg11, %arg10) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<3xf32>, index) -> vector<3xf32>
                      "scf.yield"(%21) : (vector<3xf32>) -> ()
                    }, {
                      "scf.yield"(%arg11) : (vector<3xf32>) -> ()
                    }) : (i1) -> vector<3xf32>
                    "scf.yield"(%19) : (vector<3xf32>) -> ()
                  }) : (index, index, index, vector<3xf32>) -> vector<3xf32>
                  "memref.store"(%15, %14, %arg8, %arg9) <{nontemporal = false}> : (vector<3xf32>, memref<5x4xvector<3xf32>>, index, index) -> ()
                  "scf.yield"() : () -> ()
                }) : (index, index, index) -> ()
                "scf.yield"() : () -> ()
              }, {
                "memref.store"(%2, %9, %arg8) <{nontemporal = false}> : (vector<4x3xf32>, memref<5xvector<4x3xf32>>, index) -> ()
                "scf.yield"() : () -> ()
              }) : (i1) -> ()
              "scf.yield"() : () -> ()
            }) : (index, index, index) -> ()
            %10 = "memref.load"(%8) : (memref<vector<5x4x3xf32>>) -> vector<5x4x3xf32>
            "dummy_use"(%10) : (vector<5x4x3xf32>) -> ()
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
#map = affine_map<(d0, d1) -> (d0 + d1)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d3)>
#map2 = affine_map<() -> (0)>
#map3 = affine_map<()[s0] -> (s0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index) -> (), sym_name = "materialize_write"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 4 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 3 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = dense<1.000000e+00> : vector<3x4x1x5xf32>}> : () -> vector<3x4x1x5xf32>
    %5 = "memref.alloc"(%arg0, %arg1, %arg2, %arg3) <{operandSegmentSizes = array<i32: 4, 0>}> : (index, index, index, index) -> memref<?x?x?x?xf32>
    "affine.for"(%arg0) <{lowerBoundMap = #map2, operandSegmentSizes = array<i32: 0, 1, 0>, step = 3 : index, upperBoundMap = #map3}> ({
    ^bb0(%arg4: index):
      "affine.for"(%arg1) <{lowerBoundMap = #map2, operandSegmentSizes = array<i32: 0, 1, 0>, step = 4 : index, upperBoundMap = #map3}> ({
      ^bb0(%arg5: index):
        "affine.for"(%arg2) <{lowerBoundMap = #map2, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map3}> ({
        ^bb0(%arg6: index):
          "affine.for"(%arg3) <{lowerBoundMap = #map2, operandSegmentSizes = array<i32: 0, 1, 0>, step = 5 : index, upperBoundMap = #map3}> ({
          ^bb0(%arg7: index):
            %6 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<vector<3x4x1x5xf32>>
            "memref.store"(%4, %6) : (vector<3x4x1x5xf32>, memref<vector<3x4x1x5xf32>>) -> ()
            %7 = "vector.type_cast"(%6) : (memref<vector<3x4x1x5xf32>>) -> memref<3xvector<4x1x5xf32>>
            "scf.for"(%3, %2, %1) ({
            ^bb0(%arg8: index):
              %8 = "affine.apply"(%arg4, %arg8) <{map = #map}> : (index, index) -> index
              %9 = "arith.cmpi"(%arg0, %8) <{predicate = 4 : i64}> : (index, index) -> i1
              "scf.if"(%9) ({
                %10 = "affine.apply"(%arg4, %arg8) <{map = #map}> : (index, index) -> index
                %11 = "vector.type_cast"(%7) : (memref<3xvector<4x1x5xf32>>) -> memref<3x4xvector<1x5xf32>>
                "scf.for"(%3, %0, %1) ({
                ^bb0(%arg9: index):
                  %12 = "affine.apply"(%arg5, %arg9) <{map = #map}> : (index, index) -> index
                  %13 = "arith.cmpi"(%arg1, %12) <{predicate = 4 : i64}> : (index, index) -> i1
                  "scf.if"(%13) ({
                    %14 = "affine.apply"(%arg5, %arg9) <{map = #map}> : (index, index) -> index
                    %15 = "vector.type_cast"(%11) : (memref<3x4xvector<1x5xf32>>) -> memref<3x4x1xvector<5xf32>>
                    "scf.for"(%3, %1, %1) ({
                    ^bb0(%arg10: index):
                      %16 = "affine.apply"(%arg6, %arg10) <{map = #map}> : (index, index) -> index
                      %17 = "memref.load"(%15, %arg8, %arg9, %arg10) <{nontemporal = false}> : (memref<3x4x1xvector<5xf32>>, index, index, index) -> vector<5xf32>
                      "vector.transfer_write"(%17, %5, %10, %14, %16, %arg7) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map1}> : (vector<5xf32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                      "scf.yield"() : () -> ()
                    }) : (index, index, index) -> ()
                    "scf.yield"() : () -> ()
                  }, {
                    "scf.yield"() : () -> ()
                  }) : (i1) -> ()
                  "scf.yield"() : () -> ()
                }) : (index, index, index) -> ()
                "scf.yield"() : () -> ()
              }, {
                "scf.yield"() : () -> ()
              }) : (i1) -> ()
              "scf.yield"() : () -> ()
            }) : (index, index, index) -> ()
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
#map = affine_map<(d0)[s0] -> (d0 + s0)>
#map1 = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, index) -> vector<3x15xf32>, sym_name = "transfer_read_progressive"}> ({
  ^bb0(%arg0: memref<?x?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = dense<7.000000e+00> : vector<15xf32>}> : () -> vector<15xf32>
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 3 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %5 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<vector<3x15xf32>>
    %6 = "vector.type_cast"(%5) : (memref<vector<3x15xf32>>) -> memref<3xvector<15xf32>>
    "scf.for"(%3, %2, %1) ({
    ^bb0(%arg2: index):
      %8 = "memref.dim"(%arg0, %3) : (memref<?x?xf32>, index) -> index
      %9 = "affine.apply"(%arg2, %arg1) <{map = #map}> : (index, index) -> index
      %10 = "arith.cmpi"(%8, %9) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%10) ({
        %11 = "affine.apply"(%arg2, %arg1) <{map = #map}> : (index, index) -> index
        %12 = "vector.transfer_read"(%arg0, %11, %arg1, %4) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<?x?xf32>, index, index, f32) -> vector<15xf32>
        "memref.store"(%12, %6, %arg2) <{nontemporal = false}> : (vector<15xf32>, memref<3xvector<15xf32>>, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "memref.store"(%0, %6, %arg2) <{nontemporal = false}> : (vector<15xf32>, memref<3xvector<15xf32>>, index) -> ()
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %7 = "memref.load"(%5) : (memref<vector<3x15xf32>>) -> vector<3x15xf32>
    "func.return"(%7) : (vector<3x15xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0] -> (d0 + s0)>
#map1 = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, index, vector<3x15xf32>) -> (), sym_name = "transfer_write_progressive"}> ({
  ^bb0(%arg0: memref<?x?xf32>, %arg1: index, %arg2: vector<3x15xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 3 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<vector<3x15xf32>>
    "memref.store"(%arg2, %3) : (vector<3x15xf32>, memref<vector<3x15xf32>>) -> ()
    %4 = "vector.type_cast"(%3) : (memref<vector<3x15xf32>>) -> memref<3xvector<15xf32>>
    "scf.for"(%2, %1, %0) ({
    ^bb0(%arg3: index):
      %5 = "memref.dim"(%arg0, %2) : (memref<?x?xf32>, index) -> index
      %6 = "affine.apply"(%arg3, %arg1) <{map = #map}> : (index, index) -> index
      %7 = "arith.cmpi"(%5, %6) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%7) ({
        %8 = "affine.apply"(%arg3, %arg1) <{map = #map}> : (index, index) -> index
        %9 = "memref.load"(%4, %arg3) <{nontemporal = false}> : (memref<3xvector<15xf32>>, index) -> vector<15xf32>
        "vector.transfer_write"(%9, %arg0, %8, %arg1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<15xf32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0] -> (d0 + s0)>
#map1 = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, index, vector<3x15xf32>) -> (), sym_name = "transfer_write_progressive_inbounds"}> ({
  ^bb0(%arg0: memref<?x?xf32>, %arg1: index, %arg2: vector<3x15xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 3 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<vector<3x15xf32>>
    "memref.store"(%arg2, %3) : (vector<3x15xf32>, memref<vector<3x15xf32>>) -> ()
    %4 = "vector.type_cast"(%3) : (memref<vector<3x15xf32>>) -> memref<3xvector<15xf32>>
    "scf.for"(%2, %1, %0) ({
    ^bb0(%arg3: index):
      %5 = "affine.apply"(%arg3, %arg1) <{map = #map}> : (index, index) -> index
      %6 = "memref.load"(%4, %arg3) <{nontemporal = false}> : (memref<3xvector<15xf32>>, index) -> vector<15xf32>
      "vector.transfer_write"(%6, %arg0, %5, %arg1) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<15xf32>, memref<?x?xf32>, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x2xf32>) -> vector<2x2xf32>, sym_name = "transfer_read_simple"}> ({
  ^bb0(%arg5: memref<2x2xf32>):
    %21 = "arith.constant"() <{value = 1 : index}> : () -> index
    %22 = "arith.constant"() <{value = 2 : index}> : () -> index
    %23 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %24 = "arith.constant"() <{value = 0 : index}> : () -> index
    %25 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<vector<2x2xf32>>
    %26 = "vector.type_cast"(%25) : (memref<vector<2x2xf32>>) -> memref<2xvector<2xf32>>
    "scf.for"(%24, %22, %21) ({
    ^bb0(%arg6: index):
      %28 = "vector.transfer_read"(%arg5, %arg6, %24, %23) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x2xf32>, index, index, f32) -> vector<2xf32>
      "memref.store"(%28, %26, %arg6) <{nontemporal = false}> : (vector<2xf32>, memref<2xvector<2xf32>>, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %27 = "memref.load"(%25) : (memref<vector<2x2xf32>>) -> vector<2x2xf32>
    "func.return"(%27) : (vector<2x2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?x?x?xf32>) -> vector<3x3xf32>, sym_name = "transfer_read_minor_identity"}> ({
  ^bb0(%arg3: memref<?x?x?x?xf32>):
    %9 = "arith.constant"() <{value = dense<0.000000e+00> : vector<3xf32>}> : () -> vector<3xf32>
    %10 = "arith.constant"() <{value = 2 : index}> : () -> index
    %11 = "arith.constant"() <{value = 1 : index}> : () -> index
    %12 = "arith.constant"() <{value = 3 : index}> : () -> index
    %13 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %14 = "arith.constant"() <{value = 0 : index}> : () -> index
    %15 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<vector<3x3xf32>>
    %16 = "vector.type_cast"(%15) : (memref<vector<3x3xf32>>) -> memref<3xvector<3xf32>>
    "scf.for"(%14, %12, %11) ({
    ^bb0(%arg4: index):
      %18 = "memref.dim"(%arg3, %10) : (memref<?x?x?x?xf32>, index) -> index
      %19 = "arith.cmpi"(%18, %arg4) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%19) ({
        %20 = "vector.transfer_read"(%arg3, %14, %14, %arg4, %14, %13) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map1}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<3xf32>
        "memref.store"(%20, %16, %arg4) <{nontemporal = false}> : (vector<3xf32>, memref<3xvector<3xf32>>, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "memref.store"(%9, %16, %arg4) <{nontemporal = false}> : (vector<3xf32>, memref<3xvector<3xf32>>, index) -> ()
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %17 = "memref.load"(%15) : (memref<vector<3x3xf32>>) -> vector<3x3xf32>
    "func.return"(%17) : (vector<3x3xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3x3xf32>, memref<?x?x?x?xf32>) -> (), sym_name = "transfer_write_minor_identity"}> ({
  ^bb0(%arg0: vector<3x3xf32>, %arg1: memref<?x?x?x?xf32>):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 3 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<vector<3x3xf32>>
    "memref.store"(%arg0, %4) : (vector<3x3xf32>, memref<vector<3x3xf32>>) -> ()
    %5 = "vector.type_cast"(%4) : (memref<vector<3x3xf32>>) -> memref<3xvector<3xf32>>
    "scf.for"(%3, %2, %1) ({
    ^bb0(%arg2: index):
      %6 = "memref.dim"(%arg1, %0) : (memref<?x?x?x?xf32>, index) -> index
      %7 = "arith.cmpi"(%6, %arg2) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%7) ({
        %8 = "memref.load"(%5, %arg2) <{nontemporal = false}> : (memref<3xvector<3xf32>>, index) -> vector<3xf32>
        "vector.transfer_write"(%8, %arg1, %3, %3, %arg2, %3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map1}> : (vector<3xf32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0 + d1 * 8)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x4xf32, #map>) -> vector<4xf32>, sym_name = "transfer_read_strided"}> ({
  ^bb0(%arg3: memref<8x4xf32, #map>):
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "arith.constant"() <{value = 4 : index}> : () -> index
    %6 = "arith.constant"() <{value = 1 : index}> : () -> index
    %7 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %8 = "scf.for"(%4, %5, %6, %7) ({
    ^bb0(%arg4: index, %arg5: vector<4xf32>):
      %9 = "memref.load"(%arg3, %4, %arg4) <{nontemporal = false}> : (memref<8x4xf32, #map>, index, index) -> f32
      %10 = "vector.insert"(%9, %arg5, %arg4) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<4xf32>, index) -> vector<4xf32>
      "scf.yield"(%10) : (vector<4xf32>) -> ()
    }) : (index, index, index, vector<4xf32>) -> vector<4xf32>
    "func.return"(%8) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, memref<8x4xf32, #map>) -> (), sym_name = "transfer_write_strided"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: memref<8x4xf32, #map>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 4 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%0, %1, %2) ({
    ^bb0(%arg2: index):
      %3 = "vector.extract"(%arg0, %arg2) <{static_position = array<i64: -9223372036854775808>}> : (vector<4xf32>, index) -> f32
      "memref.store"(%3, %arg1, %0, %arg2) <{nontemporal = false}> : (f32, memref<8x4xf32, #map>, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xf32>) -> (), sym_name = "fake_side_effecting_fun", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x2xf32>) -> !async.token, sym_name = "transfer_read_within_async_execute"}> ({
  ^bb0(%arg0: memref<2x2xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "async.execute"() <{operandSegmentSizes = array<i32: 0, 0>}> ({
      %5 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<vector<2x2xf32>>
      %6 = "vector.type_cast"(%5) : (memref<vector<2x2xf32>>) -> memref<2xvector<2xf32>>
      "scf.for"(%2, %1, %0) ({
      ^bb0(%arg1: index):
        %8 = "vector.transfer_read"(%arg0, %arg1, %2, %3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x2xf32>, index, index, f32) -> vector<2xf32>
        "memref.store"(%8, %6, %arg1) <{nontemporal = false}> : (vector<2xf32>, memref<2xvector<2xf32>>, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      %7 = "memref.load"(%5) : (memref<vector<2x2xf32>>) -> vector<2x2xf32>
      "func.call"(%7) <{callee = @fake_side_effecting_fun}> : (vector<2x2xf32>) -> ()
      "async.yield"() : () -> ()
    }) : () -> !async.token
    "func.return"(%4) : (!async.token) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>) -> vector<1xf32>, sym_name = "transfer_read_with_tensor"}> ({
  ^bb0(%arg0: tensor<f32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "vector.transfer_read"(%arg0, %0) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 0, 1, 0>, permutation_map = #map}> : (tensor<f32>, f32) -> vector<f32>
    %2 = "vector.broadcast"(%1) : (vector<f32>) -> vector<1xf32>
    "func.return"(%2) : (vector<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, f32) -> (), sym_name = "transfer_write_scalable"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: f32):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 16 : index}> : () -> index
    %2 = "llvm.mlir.undef"() : () -> vector<[16]xf32>
    %3 = "llvm.mlir.undef"() : () -> vector<[16]xi32>
    %4 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 0 : index}> : () -> index
    %6 = "memref.dim"(%arg0, %5) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %7 = "llvm.intr.stepvector"() : () -> vector<[16]xi32>
    %8 = "arith.index_cast"(%6) : (index) -> i32
    %9 = "llvm.insertelement"(%3, %8, %4) : (vector<[16]xi32>, i32, i32) -> vector<[16]xi32>
    %10 = "llvm.shufflevector"(%9, %3) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[16]xi32>, vector<[16]xi32>) -> vector<[16]xi32>
    %11 = "arith.cmpi"(%7, %10) <{predicate = 2 : i64}> : (vector<[16]xi32>, vector<[16]xi32>) -> vector<[16]xi1>
    %12 = "llvm.insertelement"(%2, %arg1, %4) : (vector<[16]xf32>, f32, i32) -> vector<[16]xf32>
    %13 = "llvm.shufflevector"(%12, %2) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[16]xf32>, vector<[16]xf32>) -> vector<[16]xf32>
    %14 = "vector.vscale"() : () -> index
    %15 = "arith.muli"(%14, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "scf.for"(%5, %15, %0) ({
    ^bb0(%arg2: index):
      %16 = "vector.extract"(%11, %arg2) <{static_position = array<i64: -9223372036854775808>}> : (vector<[16]xi1>, index) -> i1
      "scf.if"(%16) ({
        %17 = "vector.extract"(%13, %arg2) <{static_position = array<i64: -9223372036854775808>}> : (vector<[16]xf32>, index) -> f32
        "memref.store"(%17, %arg0, %arg2) <{nontemporal = false}> : (f32, memref<?xf32, strided<[?], offset: ?>>, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>) -> (), sym_name = "vector_print_vector_0d"}> ({
  ^bb0(%arg0: vector<f32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    "vector.print"() <{punctuation = #vector.punctuation<open>}> : () -> ()
    "scf.for"(%0, %1, %1) ({
    ^bb0(%arg1: index):
      %2 = "vector.extract"(%arg0) <{static_position = array<i64>}> : (vector<f32>) -> f32
      "vector.print"(%2) <{punctuation = #vector.punctuation<no_punctuation>}> : (f32) -> ()
      %3 = "arith.cmpi"(%arg1, %0) <{predicate = 6 : i64}> : (index, index) -> i1
      "scf.if"(%3) ({
        "vector.print"() <{punctuation = #vector.punctuation<comma>}> : () -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "vector.print"() <{punctuation = #vector.punctuation<close>}> : () -> ()
    "vector.print"() <{punctuation = #vector.punctuation<newline>}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xf32>) -> (), sym_name = "vector_print_vector"}> ({
  ^bb0(%arg0: vector<2x2xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "vector.shape_cast"(%arg0) : (vector<2x2xf32>) -> vector<4xf32>
    "vector.print"() <{punctuation = #vector.punctuation<open>}> : () -> ()
    "scf.for"(%2, %1, %0) ({
    ^bb0(%arg1: index):
      "vector.print"() <{punctuation = #vector.punctuation<open>}> : () -> ()
      "scf.for"(%2, %1, %0) ({
      ^bb0(%arg2: index):
        %5 = "arith.muli"(%arg1, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %6 = "arith.addi"(%arg2, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %7 = "vector.extract"(%3, %6) <{static_position = array<i64: -9223372036854775808>}> : (vector<4xf32>, index) -> f32
        "vector.print"(%7) <{punctuation = #vector.punctuation<no_punctuation>}> : (f32) -> ()
        %8 = "arith.cmpi"(%arg2, %0) <{predicate = 6 : i64}> : (index, index) -> i1
        "scf.if"(%8) ({
          "vector.print"() <{punctuation = #vector.punctuation<comma>}> : () -> ()
          "scf.yield"() : () -> ()
        }, {
        }) : (i1) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "vector.print"() <{punctuation = #vector.punctuation<close>}> : () -> ()
      %4 = "arith.cmpi"(%arg1, %0) <{predicate = 6 : i64}> : (index, index) -> i1
      "scf.if"(%4) ({
        "vector.print"() <{punctuation = #vector.punctuation<comma>}> : () -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "vector.print"() <{punctuation = #vector.punctuation<close>}> : () -> ()
    "vector.print"() <{punctuation = #vector.punctuation<newline>}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]xi32>) -> (), sym_name = "vector_print_scalable_vector"}> ({
  ^bb0(%arg0: vector<[4]xi32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 4 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "vector.vscale"() : () -> index
    %4 = "arith.muli"(%3, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %5 = "arith.subi"(%4, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "vector.print"() <{punctuation = #vector.punctuation<open>}> : () -> ()
    "scf.for"(%0, %4, %2) ({
    ^bb0(%arg1: index):
      %6 = "vector.extract"(%arg0, %arg1) <{static_position = array<i64: -9223372036854775808>}> : (vector<[4]xi32>, index) -> i32
      "vector.print"(%6) <{punctuation = #vector.punctuation<no_punctuation>}> : (i32) -> ()
      %7 = "arith.cmpi"(%arg1, %5) <{predicate = 6 : i64}> : (index, index) -> i1
      "scf.if"(%7) ({
        "vector.print"() <{punctuation = #vector.punctuation<comma>}> : () -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "vector.print"() <{punctuation = #vector.punctuation<close>}> : () -> ()
    "vector.print"() <{punctuation = #vector.punctuation<newline>}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<3x?xf32>) -> vector<3x[4]xf32>, sym_name = "transfer_read_array_of_scalable"}> ({
  ^bb0(%arg0: memref<3x?xf32>):
    %0 = "arith.constant"() <{value = 3 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<vector<3x[4]xf32>>
    %5 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<vector<3x[4]xi1>>
    %6 = "memref.dim"(%arg0, %2) : (memref<3x?xf32>, index) -> index
    %7 = "vector.create_mask"(%2, %6) : (index, index) -> vector<3x[4]xi1>
    "memref.store"(%7, %5) : (vector<3x[4]xi1>, memref<vector<3x[4]xi1>>) -> ()
    %8 = "vector.type_cast"(%4) : (memref<vector<3x[4]xf32>>) -> memref<3xvector<[4]xf32>>
    %9 = "vector.type_cast"(%5) : (memref<vector<3x[4]xi1>>) -> memref<3xvector<[4]xi1>>
    "scf.for"(%3, %0, %2) ({
    ^bb0(%arg1: index):
      %11 = "memref.load"(%9, %arg1) <{nontemporal = false}> : (memref<3xvector<[4]xi1>>, index) -> vector<[4]xi1>
      %12 = "vector.transfer_read"(%arg0, %arg1, %3, %1, %11) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 1>, permutation_map = #map}> : (memref<3x?xf32>, index, index, f32, vector<[4]xi1>) -> vector<[4]xf32>
      "memref.store"(%12, %8, %arg1) <{nontemporal = false}> : (vector<[4]xf32>, memref<3xvector<[4]xf32>>, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %10 = "memref.load"(%4) : (memref<vector<3x[4]xf32>>) -> vector<3x[4]xf32>
    "func.return"(%10) : (vector<3x[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3x[4]xf32>, memref<3x?xf32>) -> (), sym_name = "transfer_write_array_of_scalable"}> ({
  ^bb0(%arg0: vector<3x[4]xf32>, %arg1: memref<3x?xf32>):
    %0 = "arith.constant"() <{value = 3 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<vector<3x[4]xf32>>
    %4 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<vector<3x[4]xi1>>
    %5 = "memref.dim"(%arg1, %1) : (memref<3x?xf32>, index) -> index
    %6 = "vector.create_mask"(%1, %5) : (index, index) -> vector<3x[4]xi1>
    "memref.store"(%6, %4) : (vector<3x[4]xi1>, memref<vector<3x[4]xi1>>) -> ()
    "memref.store"(%arg0, %3) : (vector<3x[4]xf32>, memref<vector<3x[4]xf32>>) -> ()
    %7 = "vector.type_cast"(%3) : (memref<vector<3x[4]xf32>>) -> memref<3xvector<[4]xf32>>
    %8 = "vector.type_cast"(%4) : (memref<vector<3x[4]xi1>>) -> memref<3xvector<[4]xi1>>
    "scf.for"(%2, %0, %1) ({
    ^bb0(%arg2: index):
      %9 = "memref.load"(%7, %arg2) <{nontemporal = false}> : (memref<3xvector<[4]xf32>>, index) -> vector<[4]xf32>
      %10 = "memref.load"(%8, %arg2) <{nontemporal = false}> : (memref<3xvector<[4]xi1>>, index) -> vector<[4]xi1>
      "vector.transfer_write"(%9, %arg1, %arg2, %2, %10) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 1>, permutation_map = #map}> : (vector<[4]xf32>, memref<3x?xf32>, index, index, vector<[4]xi1>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
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
    %2 = "memref.dim"(%arg1, %0) : (memref<?x4xf32>, index) -> index
    %3 = "vector.create_mask"(%2, %1) : (index, index) -> vector<[4]x4xi1>
    "vector.transfer_write"(%arg0, %arg1, %0, %0, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 1>, permutation_map = #map}> : (vector<[4]x4xf32>, memref<?x4xf32>, index, index, vector<[4]x4xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d3)>
#map2 = affine_map<(d0, d1, d2) -> (d2)>
#map3 = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x4xf32>) -> vector<[4]x4xf32>, sym_name = "cannot_lower_transfer_read_with_leading_scalable"}> ({
  ^bb0(%arg12: memref<?x4xf32>):
    %30 = "arith.constant"() <{value = 0 : index}> : () -> index
    %31 = "arith.constant"() <{value = 4 : index}> : () -> index
    %32 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %33 = "memref.dim"(%arg12, %30) : (memref<?x4xf32>, index) -> index
    %34 = "vector.create_mask"(%33, %31) : (index, index) -> vector<[4]x4xi1>
    %35 = "vector.transfer_read"(%arg12, %30, %30, %32, %34) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 1>, permutation_map = #map}> : (memref<?x4xf32>, index, index, f32, vector<[4]x4xi1>) -> vector<[4]x4xf32>
    "func.return"(%35) : (vector<[4]x4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1x1x1x1xi32>, vector<1x1xi1>) -> vector<1x1x1x1xi32>, sym_name = "does_not_crash_on_unpack_one_dim"}> ({
  ^bb0(%arg7: memref<1x1x1x1xi32>, %arg8: vector<1x1xi1>):
    %18 = "arith.constant"() <{value = 1 : index}> : () -> index
    %19 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %20 = "arith.constant"() <{value = 0 : index}> : () -> index
    %21 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<vector<1x1x1x1xi32>>
    %22 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<vector<1x1xi1>>
    "memref.store"(%arg8, %22) : (vector<1x1xi1>, memref<vector<1x1xi1>>) -> ()
    %23 = "vector.type_cast"(%21) : (memref<vector<1x1x1x1xi32>>) -> memref<1xvector<1x1x1xi32>>
    %24 = "vector.type_cast"(%22) : (memref<vector<1x1xi1>>) -> memref<1xvector<1xi1>>
    "scf.for"(%20, %18, %18) ({
    ^bb0(%arg9: index):
      %26 = "vector.type_cast"(%23) : (memref<1xvector<1x1x1xi32>>) -> memref<1x1xvector<1x1xi32>>
      "scf.for"(%20, %18, %18) ({
      ^bb0(%arg10: index):
        %27 = "vector.type_cast"(%26) : (memref<1x1xvector<1x1xi32>>) -> memref<1x1x1xvector<1xi32>>
        "scf.for"(%20, %18, %18) ({
        ^bb0(%arg11: index):
          %28 = "memref.load"(%24, %arg9) <{nontemporal = false}> : (memref<1xvector<1xi1>>, index) -> vector<1xi1>
          %29 = "vector.transfer_read"(%arg7, %arg9, %20, %20, %20, %19, %28) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 4, 1, 1>, permutation_map = #map1}> : (memref<1x1x1x1xi32>, index, index, index, index, i32, vector<1xi1>) -> vector<1xi32>
          "memref.store"(%29, %27, %arg9, %arg10, %arg11) <{nontemporal = false}> : (vector<1xi32>, memref<1x1x1xvector<1xi32>>, index, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %25 = "memref.load"(%21) : (memref<vector<1x1x1x1xi32>>) -> vector<1x1x1x1xi32>
    "func.return"(%25) : (vector<1x1x1x1xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1x2x?xf32>, memref<1x2x?xf32>) -> vector<1x2x[4]xf32>, sym_name = "add_arrays_of_scalable_vectors"}> ({
  ^bb0(%arg3: memref<1x2x?xf32>, %arg4: memref<1x2x?xf32>):
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %5 = "arith.constant"() <{value = 2 : index}> : () -> index
    %6 = "arith.constant"() <{value = 0 : index}> : () -> index
    %7 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<vector<1x2x[4]xf32>>
    %8 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<vector<1x2x[4]xi1>>
    %9 = "memref.dim"(%arg3, %5) : (memref<1x2x?xf32>, index) -> index
    %10 = "vector.create_mask"(%5, %5, %9) : (index, index, index) -> vector<1x2x[4]xi1>
    "memref.store"(%10, %8) : (vector<1x2x[4]xi1>, memref<vector<1x2x[4]xi1>>) -> ()
    %11 = "vector.type_cast"(%7) : (memref<vector<1x2x[4]xf32>>) -> memref<1xvector<2x[4]xf32>>
    %12 = "vector.type_cast"(%8) : (memref<vector<1x2x[4]xi1>>) -> memref<1xvector<2x[4]xi1>>
    "scf.for"(%6, %3, %3) ({
    ^bb0(%arg5: index):
      %14 = "vector.type_cast"(%11) : (memref<1xvector<2x[4]xf32>>) -> memref<1x2xvector<[4]xf32>>
      %15 = "vector.type_cast"(%12) : (memref<1xvector<2x[4]xi1>>) -> memref<1x2xvector<[4]xi1>>
      "scf.for"(%6, %5, %3) ({
      ^bb0(%arg6: index):
        %16 = "memref.load"(%15, %arg5, %arg6) <{nontemporal = false}> : (memref<1x2xvector<[4]xi1>>, index, index) -> vector<[4]xi1>
        %17 = "vector.transfer_read"(%arg3, %arg5, %arg6, %6, %4, %16) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 1>, permutation_map = #map2}> : (memref<1x2x?xf32>, index, index, index, f32, vector<[4]xi1>) -> vector<[4]xf32>
        "memref.store"(%17, %14, %arg5, %arg6) <{nontemporal = false}> : (vector<[4]xf32>, memref<1x2xvector<[4]xf32>>, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %13 = "memref.load"(%7) : (memref<vector<1x2x[4]xf32>>) -> vector<1x2x[4]xf32>
    "func.return"(%13) : (vector<1x2x[4]xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<[4]x[4]xf32>, memref<?x?xf32>) -> (), sym_name = "cannot_fully_unroll_transfer_write_of_nd_scalable_vector"}> ({
  ^bb0(%arg1: vector<[4]x[4]xf32>, %arg2: memref<?x?xf32>):
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    "vector.transfer_write"(%arg1, %arg2, %2, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<[4]x[4]xf32>, memref<?x?xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi32>) -> (), sym_name = "unroll_transfer_write_target_rank_zero"}> ({
  ^bb0(%arg0: vector<2xi32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xi32>
    "vector.transfer_write"(%arg0, %1, %0) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map3}> : (vector<2xi32>, memref<4xi32>, index) -> ()
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
#map = affine_map<(d0)[s0] -> (d0 + s0)>
#map1 = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]x4xf32>, memref<?x?xf32>, index, index) -> (), sym_name = "negative_scalable_transpose_store_0"}> ({
  ^bb0(%arg0: vector<[4]x4xf32>, %arg1: memref<?x?xf32>, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 4 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<vector<4x[4]xf32>>
    %4 = "vector.transpose"(%arg0) <{permutation = array<i64: 1, 0>}> : (vector<[4]x4xf32>) -> vector<4x[4]xf32>
    "memref.store"(%4, %3) : (vector<4x[4]xf32>, memref<vector<4x[4]xf32>>) -> ()
    %5 = "vector.type_cast"(%3) : (memref<vector<4x[4]xf32>>) -> memref<4xvector<[4]xf32>>
    "scf.for"(%2, %1, %0) ({
    ^bb0(%arg4: index):
      %6 = "affine.apply"(%arg4, %arg2) <{map = #map}> : (index, index) -> index
      %7 = "memref.load"(%5, %arg4) <{nontemporal = false}> : (memref<4xvector<[4]xf32>>, index) -> vector<[4]xf32>
      "vector.transfer_write"(%7, %arg1, %6, %arg3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<[4]xf32>, memref<?x?xf32>, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0] -> (d0 + s0)>
#map1 = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x[4]xf32>, memref<?x?xf32>, index, index) -> (), sym_name = "negative_scalable_transpose_store_1"}> ({
  ^bb0(%arg0: vector<4x[4]xf32>, %arg1: memref<?x?xf32>, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 4 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<vector<4x[4]xf32>>
    %4 = "vector.transpose"(%arg0) <{permutation = array<i64: 1, 0>}> : (vector<4x[4]xf32>) -> vector<[4]x4xf32>
    %5 = "vector.transpose"(%4) <{permutation = array<i64: 1, 0>}> : (vector<[4]x4xf32>) -> vector<4x[4]xf32>
    "memref.store"(%5, %3) : (vector<4x[4]xf32>, memref<vector<4x[4]xf32>>) -> ()
    %6 = "vector.type_cast"(%3) : (memref<vector<4x[4]xf32>>) -> memref<4xvector<[4]xf32>>
    "scf.for"(%2, %1, %0) ({
    ^bb0(%arg4: index):
      %7 = "affine.apply"(%arg4, %arg2) <{map = #map}> : (index, index) -> index
      %8 = "memref.load"(%6, %arg4) <{nontemporal = false}> : (memref<4xvector<[4]xf32>>, index) -> vector<[4]xf32>
      "vector.transfer_write"(%8, %arg1, %7, %arg3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<[4]xf32>, memref<?x?xf32>, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
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

