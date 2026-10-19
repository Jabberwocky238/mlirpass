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
#map = affine_map<(d0, d1) -> ()>
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
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<7x42xf32>
    "affine.for"() <{lowerBoundMap = #map4, operandSegmentSizes = array<i32: 0, 0, 0>, step = 4 : index, upperBoundMap = #map6}> ({
    ^bb0(%arg0: index):
      "affine.for"() <{lowerBoundMap = #map4, operandSegmentSizes = array<i32: 0, 0, 0>, step = 4 : index, upperBoundMap = #map5}> ({
      ^bb0(%arg1: index):
        %4 = "arith.cmpi"(%arg0, %0) <{predicate = 2 : i64}> : (index, index) -> i1
        %5 = "scf.if"(%4) ({
          %108 = "vector.transfer_read"(%3, %arg0, %arg1, %2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<7x42xf32>, index, index, f32) -> vector<f32>
          %109 = "vector.extract"(%108) <{static_position = array<i64>}> : (vector<f32>) -> f32
          %110 = "vector.insert"(%109, %1) <{static_position = array<i64: 0>}> : (f32, vector<4xf32>) -> vector<4xf32>
          "scf.yield"(%110) : (vector<4xf32>) -> ()
        }, {
          "scf.yield"(%1) : (vector<4xf32>) -> ()
        }) : (i1) -> vector<4xf32>
        %6 = "affine.apply"(%arg0) <{map = #map1}> : (index) -> index
        %7 = "arith.cmpi"(%6, %0) <{predicate = 2 : i64}> : (index, index) -> i1
        %8 = "scf.if"(%7) ({
          %104 = "affine.apply"(%arg0) <{map = #map1}> : (index) -> index
          %105 = "vector.transfer_read"(%3, %104, %arg1, %2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<7x42xf32>, index, index, f32) -> vector<f32>
          %106 = "vector.extract"(%105) <{static_position = array<i64>}> : (vector<f32>) -> f32
          %107 = "vector.insert"(%106, %5) <{static_position = array<i64: 1>}> : (f32, vector<4xf32>) -> vector<4xf32>
          "scf.yield"(%107) : (vector<4xf32>) -> ()
        }, {
          "scf.yield"(%5) : (vector<4xf32>) -> ()
        }) : (i1) -> vector<4xf32>
        %9 = "affine.apply"(%arg0) <{map = #map2}> : (index) -> index
        %10 = "arith.cmpi"(%9, %0) <{predicate = 2 : i64}> : (index, index) -> i1
        %11 = "scf.if"(%10) ({
          %100 = "affine.apply"(%arg0) <{map = #map2}> : (index) -> index
          %101 = "vector.transfer_read"(%3, %100, %arg1, %2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<7x42xf32>, index, index, f32) -> vector<f32>
          %102 = "vector.extract"(%101) <{static_position = array<i64>}> : (vector<f32>) -> f32
          %103 = "vector.insert"(%102, %8) <{static_position = array<i64: 2>}> : (f32, vector<4xf32>) -> vector<4xf32>
          "scf.yield"(%103) : (vector<4xf32>) -> ()
        }, {
          "scf.yield"(%8) : (vector<4xf32>) -> ()
        }) : (i1) -> vector<4xf32>
        %12 = "affine.apply"(%arg0) <{map = #map3}> : (index) -> index
        %13 = "arith.cmpi"(%12, %0) <{predicate = 2 : i64}> : (index, index) -> i1
        %14 = "scf.if"(%13) ({
          %96 = "affine.apply"(%arg0) <{map = #map3}> : (index) -> index
          %97 = "vector.transfer_read"(%3, %96, %arg1, %2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<7x42xf32>, index, index, f32) -> vector<f32>
          %98 = "vector.extract"(%97) <{static_position = array<i64>}> : (vector<f32>) -> f32
          %99 = "vector.insert"(%98, %11) <{static_position = array<i64: 3>}> : (f32, vector<4xf32>) -> vector<4xf32>
          "scf.yield"(%99) : (vector<4xf32>) -> ()
        }, {
          "scf.yield"(%11) : (vector<4xf32>) -> ()
        }) : (i1) -> vector<4xf32>
        %15 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
        %16 = "arith.cmpi"(%arg0, %0) <{predicate = 2 : i64}> : (index, index) -> i1
        %17 = "scf.if"(%16) ({
          %93 = "vector.transfer_read"(%3, %arg0, %15, %2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<7x42xf32>, index, index, f32) -> vector<f32>
          %94 = "vector.extract"(%93) <{static_position = array<i64>}> : (vector<f32>) -> f32
          %95 = "vector.insert"(%94, %1) <{static_position = array<i64: 0>}> : (f32, vector<4xf32>) -> vector<4xf32>
          "scf.yield"(%95) : (vector<4xf32>) -> ()
        }, {
          "scf.yield"(%1) : (vector<4xf32>) -> ()
        }) : (i1) -> vector<4xf32>
        %18 = "affine.apply"(%arg0) <{map = #map1}> : (index) -> index
        %19 = "arith.cmpi"(%18, %0) <{predicate = 2 : i64}> : (index, index) -> i1
        %20 = "scf.if"(%19) ({
          %89 = "affine.apply"(%arg0) <{map = #map1}> : (index) -> index
          %90 = "vector.transfer_read"(%3, %89, %15, %2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<7x42xf32>, index, index, f32) -> vector<f32>
          %91 = "vector.extract"(%90) <{static_position = array<i64>}> : (vector<f32>) -> f32
          %92 = "vector.insert"(%91, %17) <{static_position = array<i64: 1>}> : (f32, vector<4xf32>) -> vector<4xf32>
          "scf.yield"(%92) : (vector<4xf32>) -> ()
        }, {
          "scf.yield"(%17) : (vector<4xf32>) -> ()
        }) : (i1) -> vector<4xf32>
        %21 = "affine.apply"(%arg0) <{map = #map2}> : (index) -> index
        %22 = "arith.cmpi"(%21, %0) <{predicate = 2 : i64}> : (index, index) -> i1
        %23 = "scf.if"(%22) ({
          %85 = "affine.apply"(%arg0) <{map = #map2}> : (index) -> index
          %86 = "vector.transfer_read"(%3, %85, %15, %2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<7x42xf32>, index, index, f32) -> vector<f32>
          %87 = "vector.extract"(%86) <{static_position = array<i64>}> : (vector<f32>) -> f32
          %88 = "vector.insert"(%87, %20) <{static_position = array<i64: 2>}> : (f32, vector<4xf32>) -> vector<4xf32>
          "scf.yield"(%88) : (vector<4xf32>) -> ()
        }, {
          "scf.yield"(%20) : (vector<4xf32>) -> ()
        }) : (i1) -> vector<4xf32>
        %24 = "affine.apply"(%arg0) <{map = #map3}> : (index) -> index
        %25 = "arith.cmpi"(%24, %0) <{predicate = 2 : i64}> : (index, index) -> i1
        %26 = "scf.if"(%25) ({
          %81 = "affine.apply"(%arg0) <{map = #map3}> : (index) -> index
          %82 = "vector.transfer_read"(%3, %81, %15, %2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<7x42xf32>, index, index, f32) -> vector<f32>
          %83 = "vector.extract"(%82) <{static_position = array<i64>}> : (vector<f32>) -> f32
          %84 = "vector.insert"(%83, %23) <{static_position = array<i64: 3>}> : (f32, vector<4xf32>) -> vector<4xf32>
          "scf.yield"(%84) : (vector<4xf32>) -> ()
        }, {
          "scf.yield"(%23) : (vector<4xf32>) -> ()
        }) : (i1) -> vector<4xf32>
        %27 = "affine.apply"(%arg1) <{map = #map2}> : (index) -> index
        %28 = "arith.cmpi"(%arg0, %0) <{predicate = 2 : i64}> : (index, index) -> i1
        %29 = "scf.if"(%28) ({
          %78 = "vector.transfer_read"(%3, %arg0, %27, %2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<7x42xf32>, index, index, f32) -> vector<f32>
          %79 = "vector.extract"(%78) <{static_position = array<i64>}> : (vector<f32>) -> f32
          %80 = "vector.insert"(%79, %1) <{static_position = array<i64: 0>}> : (f32, vector<4xf32>) -> vector<4xf32>
          "scf.yield"(%80) : (vector<4xf32>) -> ()
        }, {
          "scf.yield"(%1) : (vector<4xf32>) -> ()
        }) : (i1) -> vector<4xf32>
        %30 = "affine.apply"(%arg0) <{map = #map1}> : (index) -> index
        %31 = "arith.cmpi"(%30, %0) <{predicate = 2 : i64}> : (index, index) -> i1
        %32 = "scf.if"(%31) ({
          %74 = "affine.apply"(%arg0) <{map = #map1}> : (index) -> index
          %75 = "vector.transfer_read"(%3, %74, %27, %2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<7x42xf32>, index, index, f32) -> vector<f32>
          %76 = "vector.extract"(%75) <{static_position = array<i64>}> : (vector<f32>) -> f32
          %77 = "vector.insert"(%76, %29) <{static_position = array<i64: 1>}> : (f32, vector<4xf32>) -> vector<4xf32>
          "scf.yield"(%77) : (vector<4xf32>) -> ()
        }, {
          "scf.yield"(%29) : (vector<4xf32>) -> ()
        }) : (i1) -> vector<4xf32>
        %33 = "affine.apply"(%arg0) <{map = #map2}> : (index) -> index
        %34 = "arith.cmpi"(%33, %0) <{predicate = 2 : i64}> : (index, index) -> i1
        %35 = "scf.if"(%34) ({
          %70 = "affine.apply"(%arg0) <{map = #map2}> : (index) -> index
          %71 = "vector.transfer_read"(%3, %70, %27, %2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<7x42xf32>, index, index, f32) -> vector<f32>
          %72 = "vector.extract"(%71) <{static_position = array<i64>}> : (vector<f32>) -> f32
          %73 = "vector.insert"(%72, %32) <{static_position = array<i64: 2>}> : (f32, vector<4xf32>) -> vector<4xf32>
          "scf.yield"(%73) : (vector<4xf32>) -> ()
        }, {
          "scf.yield"(%32) : (vector<4xf32>) -> ()
        }) : (i1) -> vector<4xf32>
        %36 = "affine.apply"(%arg0) <{map = #map3}> : (index) -> index
        %37 = "arith.cmpi"(%36, %0) <{predicate = 2 : i64}> : (index, index) -> i1
        %38 = "scf.if"(%37) ({
          %66 = "affine.apply"(%arg0) <{map = #map3}> : (index) -> index
          %67 = "vector.transfer_read"(%3, %66, %27, %2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<7x42xf32>, index, index, f32) -> vector<f32>
          %68 = "vector.extract"(%67) <{static_position = array<i64>}> : (vector<f32>) -> f32
          %69 = "vector.insert"(%68, %35) <{static_position = array<i64: 3>}> : (f32, vector<4xf32>) -> vector<4xf32>
          "scf.yield"(%69) : (vector<4xf32>) -> ()
        }, {
          "scf.yield"(%35) : (vector<4xf32>) -> ()
        }) : (i1) -> vector<4xf32>
        %39 = "affine.apply"(%arg1) <{map = #map3}> : (index) -> index
        %40 = "arith.cmpi"(%arg0, %0) <{predicate = 2 : i64}> : (index, index) -> i1
        %41 = "scf.if"(%40) ({
          %63 = "vector.transfer_read"(%3, %arg0, %39, %2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<7x42xf32>, index, index, f32) -> vector<f32>
          %64 = "vector.extract"(%63) <{static_position = array<i64>}> : (vector<f32>) -> f32
          %65 = "vector.insert"(%64, %1) <{static_position = array<i64: 0>}> : (f32, vector<4xf32>) -> vector<4xf32>
          "scf.yield"(%65) : (vector<4xf32>) -> ()
        }, {
          "scf.yield"(%1) : (vector<4xf32>) -> ()
        }) : (i1) -> vector<4xf32>
        %42 = "affine.apply"(%arg0) <{map = #map1}> : (index) -> index
        %43 = "arith.cmpi"(%42, %0) <{predicate = 2 : i64}> : (index, index) -> i1
        %44 = "scf.if"(%43) ({
          %59 = "affine.apply"(%arg0) <{map = #map1}> : (index) -> index
          %60 = "vector.transfer_read"(%3, %59, %39, %2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<7x42xf32>, index, index, f32) -> vector<f32>
          %61 = "vector.extract"(%60) <{static_position = array<i64>}> : (vector<f32>) -> f32
          %62 = "vector.insert"(%61, %41) <{static_position = array<i64: 1>}> : (f32, vector<4xf32>) -> vector<4xf32>
          "scf.yield"(%62) : (vector<4xf32>) -> ()
        }, {
          "scf.yield"(%41) : (vector<4xf32>) -> ()
        }) : (i1) -> vector<4xf32>
        %45 = "affine.apply"(%arg0) <{map = #map2}> : (index) -> index
        %46 = "arith.cmpi"(%45, %0) <{predicate = 2 : i64}> : (index, index) -> i1
        %47 = "scf.if"(%46) ({
          %55 = "affine.apply"(%arg0) <{map = #map2}> : (index) -> index
          %56 = "vector.transfer_read"(%3, %55, %39, %2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<7x42xf32>, index, index, f32) -> vector<f32>
          %57 = "vector.extract"(%56) <{static_position = array<i64>}> : (vector<f32>) -> f32
          %58 = "vector.insert"(%57, %44) <{static_position = array<i64: 2>}> : (f32, vector<4xf32>) -> vector<4xf32>
          "scf.yield"(%58) : (vector<4xf32>) -> ()
        }, {
          "scf.yield"(%44) : (vector<4xf32>) -> ()
        }) : (i1) -> vector<4xf32>
        %48 = "affine.apply"(%arg0) <{map = #map3}> : (index) -> index
        %49 = "arith.cmpi"(%48, %0) <{predicate = 2 : i64}> : (index, index) -> i1
        %50 = "scf.if"(%49) ({
          %51 = "affine.apply"(%arg0) <{map = #map3}> : (index) -> index
          %52 = "vector.transfer_read"(%3, %51, %39, %2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<7x42xf32>, index, index, f32) -> vector<f32>
          %53 = "vector.extract"(%52) <{static_position = array<i64>}> : (vector<f32>) -> f32
          %54 = "vector.insert"(%53, %47) <{static_position = array<i64: 3>}> : (f32, vector<4xf32>) -> vector<4xf32>
          "scf.yield"(%54) : (vector<4xf32>) -> ()
        }, {
          "scf.yield"(%47) : (vector<4xf32>) -> ()
        }) : (i1) -> vector<4xf32>
        "dummy_use"(%14, %26, %38, %50) : (vector<4xf32>, vector<4xf32>, vector<4xf32>, vector<4xf32>) -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> ()>
#map1 = affine_map<(d0) -> (d0 + 1)>
#map2 = affine_map<(d0) -> (d0 + 2)>
#map3 = affine_map<(d0) -> (d0 + 3)>
#map4 = affine_map<(d0) -> (d0 + 4)>
#map5 = affine_map<() -> (0)>
#map6 = affine_map<()[s0] -> (s0)>
#map7 = affine_map<() -> (42)>
#map8 = affine_map<() -> (7)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "materialize_read_1d_partially_specialized"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 42 : index}> : () -> index
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "memref.alloc"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 3, 0>}> : (index, index, index) -> memref<7x?x?x42x?xf32>
    "affine.for"() <{lowerBoundMap = #map5, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map8}> ({
    ^bb0(%arg3: index):
      "affine.for"(%arg0) <{lowerBoundMap = #map5, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map6}> ({
      ^bb0(%arg4: index):
        "affine.for"(%arg1) <{lowerBoundMap = #map5, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map6}> ({
        ^bb0(%arg5: index):
          "affine.for"() <{lowerBoundMap = #map5, operandSegmentSizes = array<i32: 0, 0, 0>, step = 2 : index, upperBoundMap = #map7}> ({
          ^bb0(%arg6: index):
            "affine.for"(%arg2) <{lowerBoundMap = #map5, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map6}> ({
            ^bb0(%arg7: index):
              %4 = "arith.cmpi"(%arg6, %0) <{predicate = 2 : i64}> : (index, index) -> i1
              %5 = "scf.if"(%4) ({
                %55 = "vector.transfer_read"(%3, %arg3, %arg4, %arg5, %arg6, %arg7, %2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 5, 1, 0>, permutation_map = #map}> : (memref<7x?x?x42x?xf32>, index, index, index, index, index, f32) -> vector<f32>
                %56 = "vector.extract"(%55) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %57 = "vector.insert"(%56, %1) <{static_position = array<i64: 0>}> : (f32, vector<4xf32>) -> vector<4xf32>
                "scf.yield"(%57) : (vector<4xf32>) -> ()
              }, {
                "scf.yield"(%1) : (vector<4xf32>) -> ()
              }) : (i1) -> vector<4xf32>
              %6 = "affine.apply"(%arg6) <{map = #map1}> : (index) -> index
              %7 = "arith.cmpi"(%6, %0) <{predicate = 2 : i64}> : (index, index) -> i1
              %8 = "scf.if"(%7) ({
                %51 = "affine.apply"(%arg6) <{map = #map1}> : (index) -> index
                %52 = "vector.transfer_read"(%3, %arg3, %arg4, %arg5, %51, %arg7, %2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 5, 1, 0>, permutation_map = #map}> : (memref<7x?x?x42x?xf32>, index, index, index, index, index, f32) -> vector<f32>
                %53 = "vector.extract"(%52) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %54 = "vector.insert"(%53, %5) <{static_position = array<i64: 1>}> : (f32, vector<4xf32>) -> vector<4xf32>
                "scf.yield"(%54) : (vector<4xf32>) -> ()
              }, {
                "scf.yield"(%5) : (vector<4xf32>) -> ()
              }) : (i1) -> vector<4xf32>
              %9 = "affine.apply"(%arg6) <{map = #map2}> : (index) -> index
              %10 = "arith.cmpi"(%9, %0) <{predicate = 2 : i64}> : (index, index) -> i1
              %11 = "scf.if"(%10) ({
                %47 = "affine.apply"(%arg6) <{map = #map2}> : (index) -> index
                %48 = "vector.transfer_read"(%3, %arg3, %arg4, %arg5, %47, %arg7, %2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 5, 1, 0>, permutation_map = #map}> : (memref<7x?x?x42x?xf32>, index, index, index, index, index, f32) -> vector<f32>
                %49 = "vector.extract"(%48) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %50 = "vector.insert"(%49, %8) <{static_position = array<i64: 2>}> : (f32, vector<4xf32>) -> vector<4xf32>
                "scf.yield"(%50) : (vector<4xf32>) -> ()
              }, {
                "scf.yield"(%8) : (vector<4xf32>) -> ()
              }) : (i1) -> vector<4xf32>
              %12 = "affine.apply"(%arg6) <{map = #map3}> : (index) -> index
              %13 = "arith.cmpi"(%12, %0) <{predicate = 2 : i64}> : (index, index) -> i1
              %14 = "scf.if"(%13) ({
                %43 = "affine.apply"(%arg6) <{map = #map3}> : (index) -> index
                %44 = "vector.transfer_read"(%3, %arg3, %arg4, %arg5, %43, %arg7, %2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 5, 1, 0>, permutation_map = #map}> : (memref<7x?x?x42x?xf32>, index, index, index, index, index, f32) -> vector<f32>
                %45 = "vector.extract"(%44) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %46 = "vector.insert"(%45, %11) <{static_position = array<i64: 3>}> : (f32, vector<4xf32>) -> vector<4xf32>
                "scf.yield"(%46) : (vector<4xf32>) -> ()
              }, {
                "scf.yield"(%11) : (vector<4xf32>) -> ()
              }) : (i1) -> vector<4xf32>
              %15 = "affine.apply"(%arg6) <{map = #map1}> : (index) -> index
              %16 = "arith.cmpi"(%15, %0) <{predicate = 2 : i64}> : (index, index) -> i1
              %17 = "scf.if"(%16) ({
                %39 = "affine.apply"(%arg6) <{map = #map1}> : (index) -> index
                %40 = "vector.transfer_read"(%3, %arg3, %arg4, %arg5, %39, %arg7, %2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 5, 1, 0>, permutation_map = #map}> : (memref<7x?x?x42x?xf32>, index, index, index, index, index, f32) -> vector<f32>
                %41 = "vector.extract"(%40) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %42 = "vector.insert"(%41, %1) <{static_position = array<i64: 0>}> : (f32, vector<4xf32>) -> vector<4xf32>
                "scf.yield"(%42) : (vector<4xf32>) -> ()
              }, {
                "scf.yield"(%1) : (vector<4xf32>) -> ()
              }) : (i1) -> vector<4xf32>
              %18 = "affine.apply"(%arg6) <{map = #map2}> : (index) -> index
              %19 = "arith.cmpi"(%18, %0) <{predicate = 2 : i64}> : (index, index) -> i1
              %20 = "scf.if"(%19) ({
                %35 = "affine.apply"(%arg6) <{map = #map2}> : (index) -> index
                %36 = "vector.transfer_read"(%3, %arg3, %arg4, %arg5, %35, %arg7, %2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 5, 1, 0>, permutation_map = #map}> : (memref<7x?x?x42x?xf32>, index, index, index, index, index, f32) -> vector<f32>
                %37 = "vector.extract"(%36) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %38 = "vector.insert"(%37, %17) <{static_position = array<i64: 1>}> : (f32, vector<4xf32>) -> vector<4xf32>
                "scf.yield"(%38) : (vector<4xf32>) -> ()
              }, {
                "scf.yield"(%17) : (vector<4xf32>) -> ()
              }) : (i1) -> vector<4xf32>
              %21 = "affine.apply"(%arg6) <{map = #map3}> : (index) -> index
              %22 = "arith.cmpi"(%21, %0) <{predicate = 2 : i64}> : (index, index) -> i1
              %23 = "scf.if"(%22) ({
                %31 = "affine.apply"(%arg6) <{map = #map3}> : (index) -> index
                %32 = "vector.transfer_read"(%3, %arg3, %arg4, %arg5, %31, %arg7, %2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 5, 1, 0>, permutation_map = #map}> : (memref<7x?x?x42x?xf32>, index, index, index, index, index, f32) -> vector<f32>
                %33 = "vector.extract"(%32) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %34 = "vector.insert"(%33, %20) <{static_position = array<i64: 2>}> : (f32, vector<4xf32>) -> vector<4xf32>
                "scf.yield"(%34) : (vector<4xf32>) -> ()
              }, {
                "scf.yield"(%20) : (vector<4xf32>) -> ()
              }) : (i1) -> vector<4xf32>
              %24 = "affine.apply"(%arg6) <{map = #map4}> : (index) -> index
              %25 = "arith.cmpi"(%24, %0) <{predicate = 2 : i64}> : (index, index) -> i1
              %26 = "scf.if"(%25) ({
                %27 = "affine.apply"(%arg6) <{map = #map4}> : (index) -> index
                %28 = "vector.transfer_read"(%3, %arg3, %arg4, %arg5, %27, %arg7, %2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 5, 1, 0>, permutation_map = #map}> : (memref<7x?x?x42x?xf32>, index, index, index, index, index, f32) -> vector<f32>
                %29 = "vector.extract"(%28) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %30 = "vector.insert"(%29, %23) <{static_position = array<i64: 3>}> : (f32, vector<4xf32>) -> vector<4xf32>
                "scf.yield"(%30) : (vector<4xf32>) -> ()
              }, {
                "scf.yield"(%23) : (vector<4xf32>) -> ()
              }) : (i1) -> vector<4xf32>
              "dummy_use"(%14, %26) : (vector<4xf32>, vector<4xf32>) -> ()
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
#map = affine_map<(d0, d1, d2, d3) -> ()>
#map1 = affine_map<(d0) -> (d0 + 1)>
#map2 = affine_map<(d0) -> (d0 + 2)>
#map3 = affine_map<(d0) -> (d0 + 3)>
#map4 = affine_map<(d0) -> (d0 + 4)>
#map5 = affine_map<() -> (0)>
#map6 = affine_map<()[s0] -> (s0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index) -> (), sym_name = "materialize_read"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<5x4x3xf32>}> : () -> vector<5x4x3xf32>
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "memref.alloc"(%arg0, %arg1, %arg2, %arg3) <{operandSegmentSizes = array<i32: 4, 0>}> : (index, index, index, index) -> memref<?x?x?x?xf32>
    "affine.for"(%arg0) <{lowerBoundMap = #map5, operandSegmentSizes = array<i32: 0, 1, 0>, step = 3 : index, upperBoundMap = #map6}> ({
    ^bb0(%arg4: index):
      "affine.for"(%arg1) <{lowerBoundMap = #map5, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map6}> ({
      ^bb0(%arg5: index):
        "affine.for"(%arg2) <{lowerBoundMap = #map5, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map6}> ({
        ^bb0(%arg6: index):
          "affine.for"(%arg3) <{lowerBoundMap = #map5, operandSegmentSizes = array<i32: 0, 1, 0>, step = 5 : index, upperBoundMap = #map6}> ({
          ^bb0(%arg7: index):
            %3 = "arith.cmpi"(%arg3, %arg7) <{predicate = 4 : i64}> : (index, index) -> i1
            %4 = "scf.if"(%3) ({
              %325 = "arith.cmpi"(%arg0, %arg4) <{predicate = 4 : i64}> : (index, index) -> i1
              %326 = "scf.if"(%325) ({
                %398 = "vector.transfer_read"(%2, %arg4, %arg5, %arg6, %arg7, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %399 = "vector.extract"(%398) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %400 = "vector.insert"(%399, %0) <{static_position = array<i64: 0, 0, 0>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%400) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%0) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %327 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
              %328 = "arith.cmpi"(%arg0, %327) <{predicate = 4 : i64}> : (index, index) -> i1
              %329 = "scf.if"(%328) ({
                %394 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
                %395 = "vector.transfer_read"(%2, %394, %arg5, %arg6, %arg7, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %396 = "vector.extract"(%395) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %397 = "vector.insert"(%396, %326) <{static_position = array<i64: 0, 0, 1>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%397) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%326) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %330 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
              %331 = "arith.cmpi"(%arg0, %330) <{predicate = 4 : i64}> : (index, index) -> i1
              %332 = "scf.if"(%331) ({
                %390 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
                %391 = "vector.transfer_read"(%2, %390, %arg5, %arg6, %arg7, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %392 = "vector.extract"(%391) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %393 = "vector.insert"(%392, %329) <{static_position = array<i64: 0, 0, 2>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%393) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%329) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %333 = "arith.cmpi"(%arg0, %arg4) <{predicate = 4 : i64}> : (index, index) -> i1
              %334 = "scf.if"(%333) ({
                %387 = "vector.transfer_read"(%2, %arg4, %arg5, %arg6, %arg7, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %388 = "vector.extract"(%387) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %389 = "vector.insert"(%388, %332) <{static_position = array<i64: 0, 1, 0>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%389) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%332) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %335 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
              %336 = "arith.cmpi"(%arg0, %335) <{predicate = 4 : i64}> : (index, index) -> i1
              %337 = "scf.if"(%336) ({
                %383 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
                %384 = "vector.transfer_read"(%2, %383, %arg5, %arg6, %arg7, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %385 = "vector.extract"(%384) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %386 = "vector.insert"(%385, %334) <{static_position = array<i64: 0, 1, 1>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%386) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%334) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %338 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
              %339 = "arith.cmpi"(%arg0, %338) <{predicate = 4 : i64}> : (index, index) -> i1
              %340 = "scf.if"(%339) ({
                %379 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
                %380 = "vector.transfer_read"(%2, %379, %arg5, %arg6, %arg7, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %381 = "vector.extract"(%380) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %382 = "vector.insert"(%381, %337) <{static_position = array<i64: 0, 1, 2>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%382) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%337) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %341 = "arith.cmpi"(%arg0, %arg4) <{predicate = 4 : i64}> : (index, index) -> i1
              %342 = "scf.if"(%341) ({
                %376 = "vector.transfer_read"(%2, %arg4, %arg5, %arg6, %arg7, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %377 = "vector.extract"(%376) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %378 = "vector.insert"(%377, %340) <{static_position = array<i64: 0, 2, 0>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%378) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%340) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %343 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
              %344 = "arith.cmpi"(%arg0, %343) <{predicate = 4 : i64}> : (index, index) -> i1
              %345 = "scf.if"(%344) ({
                %372 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
                %373 = "vector.transfer_read"(%2, %372, %arg5, %arg6, %arg7, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %374 = "vector.extract"(%373) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %375 = "vector.insert"(%374, %342) <{static_position = array<i64: 0, 2, 1>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%375) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%342) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %346 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
              %347 = "arith.cmpi"(%arg0, %346) <{predicate = 4 : i64}> : (index, index) -> i1
              %348 = "scf.if"(%347) ({
                %368 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
                %369 = "vector.transfer_read"(%2, %368, %arg5, %arg6, %arg7, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %370 = "vector.extract"(%369) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %371 = "vector.insert"(%370, %345) <{static_position = array<i64: 0, 2, 2>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%371) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%345) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %349 = "arith.cmpi"(%arg0, %arg4) <{predicate = 4 : i64}> : (index, index) -> i1
              %350 = "scf.if"(%349) ({
                %365 = "vector.transfer_read"(%2, %arg4, %arg5, %arg6, %arg7, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %366 = "vector.extract"(%365) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %367 = "vector.insert"(%366, %348) <{static_position = array<i64: 0, 3, 0>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%367) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%348) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %351 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
              %352 = "arith.cmpi"(%arg0, %351) <{predicate = 4 : i64}> : (index, index) -> i1
              %353 = "scf.if"(%352) ({
                %361 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
                %362 = "vector.transfer_read"(%2, %361, %arg5, %arg6, %arg7, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %363 = "vector.extract"(%362) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %364 = "vector.insert"(%363, %350) <{static_position = array<i64: 0, 3, 1>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%364) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%350) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %354 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
              %355 = "arith.cmpi"(%arg0, %354) <{predicate = 4 : i64}> : (index, index) -> i1
              %356 = "scf.if"(%355) ({
                %357 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
                %358 = "vector.transfer_read"(%2, %357, %arg5, %arg6, %arg7, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %359 = "vector.extract"(%358) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %360 = "vector.insert"(%359, %353) <{static_position = array<i64: 0, 3, 2>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%360) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%353) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              "scf.yield"(%356) : (vector<5x4x3xf32>) -> ()
            }, {
              "scf.yield"(%0) : (vector<5x4x3xf32>) -> ()
            }) : (i1) -> vector<5x4x3xf32>
            %5 = "affine.apply"(%arg7) <{map = #map1}> : (index) -> index
            %6 = "arith.cmpi"(%arg3, %5) <{predicate = 4 : i64}> : (index, index) -> i1
            %7 = "scf.if"(%6) ({
              %248 = "affine.apply"(%arg7) <{map = #map1}> : (index) -> index
              %249 = "arith.cmpi"(%arg0, %arg4) <{predicate = 4 : i64}> : (index, index) -> i1
              %250 = "scf.if"(%249) ({
                %322 = "vector.transfer_read"(%2, %arg4, %arg5, %arg6, %248, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %323 = "vector.extract"(%322) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %324 = "vector.insert"(%323, %4) <{static_position = array<i64: 1, 0, 0>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%324) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%4) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %251 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
              %252 = "arith.cmpi"(%arg0, %251) <{predicate = 4 : i64}> : (index, index) -> i1
              %253 = "scf.if"(%252) ({
                %318 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
                %319 = "vector.transfer_read"(%2, %318, %arg5, %arg6, %248, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %320 = "vector.extract"(%319) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %321 = "vector.insert"(%320, %250) <{static_position = array<i64: 1, 0, 1>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%321) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%250) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %254 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
              %255 = "arith.cmpi"(%arg0, %254) <{predicate = 4 : i64}> : (index, index) -> i1
              %256 = "scf.if"(%255) ({
                %314 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
                %315 = "vector.transfer_read"(%2, %314, %arg5, %arg6, %248, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %316 = "vector.extract"(%315) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %317 = "vector.insert"(%316, %253) <{static_position = array<i64: 1, 0, 2>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%317) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%253) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %257 = "arith.cmpi"(%arg0, %arg4) <{predicate = 4 : i64}> : (index, index) -> i1
              %258 = "scf.if"(%257) ({
                %311 = "vector.transfer_read"(%2, %arg4, %arg5, %arg6, %248, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %312 = "vector.extract"(%311) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %313 = "vector.insert"(%312, %256) <{static_position = array<i64: 1, 1, 0>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%313) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%256) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %259 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
              %260 = "arith.cmpi"(%arg0, %259) <{predicate = 4 : i64}> : (index, index) -> i1
              %261 = "scf.if"(%260) ({
                %307 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
                %308 = "vector.transfer_read"(%2, %307, %arg5, %arg6, %248, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %309 = "vector.extract"(%308) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %310 = "vector.insert"(%309, %258) <{static_position = array<i64: 1, 1, 1>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%310) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%258) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %262 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
              %263 = "arith.cmpi"(%arg0, %262) <{predicate = 4 : i64}> : (index, index) -> i1
              %264 = "scf.if"(%263) ({
                %303 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
                %304 = "vector.transfer_read"(%2, %303, %arg5, %arg6, %248, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %305 = "vector.extract"(%304) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %306 = "vector.insert"(%305, %261) <{static_position = array<i64: 1, 1, 2>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%306) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%261) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %265 = "arith.cmpi"(%arg0, %arg4) <{predicate = 4 : i64}> : (index, index) -> i1
              %266 = "scf.if"(%265) ({
                %300 = "vector.transfer_read"(%2, %arg4, %arg5, %arg6, %248, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %301 = "vector.extract"(%300) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %302 = "vector.insert"(%301, %264) <{static_position = array<i64: 1, 2, 0>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%302) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%264) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %267 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
              %268 = "arith.cmpi"(%arg0, %267) <{predicate = 4 : i64}> : (index, index) -> i1
              %269 = "scf.if"(%268) ({
                %296 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
                %297 = "vector.transfer_read"(%2, %296, %arg5, %arg6, %248, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %298 = "vector.extract"(%297) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %299 = "vector.insert"(%298, %266) <{static_position = array<i64: 1, 2, 1>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%299) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%266) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %270 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
              %271 = "arith.cmpi"(%arg0, %270) <{predicate = 4 : i64}> : (index, index) -> i1
              %272 = "scf.if"(%271) ({
                %292 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
                %293 = "vector.transfer_read"(%2, %292, %arg5, %arg6, %248, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %294 = "vector.extract"(%293) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %295 = "vector.insert"(%294, %269) <{static_position = array<i64: 1, 2, 2>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%295) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%269) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %273 = "arith.cmpi"(%arg0, %arg4) <{predicate = 4 : i64}> : (index, index) -> i1
              %274 = "scf.if"(%273) ({
                %289 = "vector.transfer_read"(%2, %arg4, %arg5, %arg6, %248, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %290 = "vector.extract"(%289) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %291 = "vector.insert"(%290, %272) <{static_position = array<i64: 1, 3, 0>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%291) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%272) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %275 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
              %276 = "arith.cmpi"(%arg0, %275) <{predicate = 4 : i64}> : (index, index) -> i1
              %277 = "scf.if"(%276) ({
                %285 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
                %286 = "vector.transfer_read"(%2, %285, %arg5, %arg6, %248, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %287 = "vector.extract"(%286) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %288 = "vector.insert"(%287, %274) <{static_position = array<i64: 1, 3, 1>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%288) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%274) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %278 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
              %279 = "arith.cmpi"(%arg0, %278) <{predicate = 4 : i64}> : (index, index) -> i1
              %280 = "scf.if"(%279) ({
                %281 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
                %282 = "vector.transfer_read"(%2, %281, %arg5, %arg6, %248, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %283 = "vector.extract"(%282) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %284 = "vector.insert"(%283, %277) <{static_position = array<i64: 1, 3, 2>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%284) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%277) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              "scf.yield"(%280) : (vector<5x4x3xf32>) -> ()
            }, {
              "scf.yield"(%4) : (vector<5x4x3xf32>) -> ()
            }) : (i1) -> vector<5x4x3xf32>
            %8 = "affine.apply"(%arg7) <{map = #map2}> : (index) -> index
            %9 = "arith.cmpi"(%arg3, %8) <{predicate = 4 : i64}> : (index, index) -> i1
            %10 = "scf.if"(%9) ({
              %171 = "affine.apply"(%arg7) <{map = #map2}> : (index) -> index
              %172 = "arith.cmpi"(%arg0, %arg4) <{predicate = 4 : i64}> : (index, index) -> i1
              %173 = "scf.if"(%172) ({
                %245 = "vector.transfer_read"(%2, %arg4, %arg5, %arg6, %171, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %246 = "vector.extract"(%245) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %247 = "vector.insert"(%246, %7) <{static_position = array<i64: 2, 0, 0>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%247) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%7) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %174 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
              %175 = "arith.cmpi"(%arg0, %174) <{predicate = 4 : i64}> : (index, index) -> i1
              %176 = "scf.if"(%175) ({
                %241 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
                %242 = "vector.transfer_read"(%2, %241, %arg5, %arg6, %171, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %243 = "vector.extract"(%242) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %244 = "vector.insert"(%243, %173) <{static_position = array<i64: 2, 0, 1>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%244) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%173) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %177 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
              %178 = "arith.cmpi"(%arg0, %177) <{predicate = 4 : i64}> : (index, index) -> i1
              %179 = "scf.if"(%178) ({
                %237 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
                %238 = "vector.transfer_read"(%2, %237, %arg5, %arg6, %171, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %239 = "vector.extract"(%238) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %240 = "vector.insert"(%239, %176) <{static_position = array<i64: 2, 0, 2>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%240) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%176) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %180 = "arith.cmpi"(%arg0, %arg4) <{predicate = 4 : i64}> : (index, index) -> i1
              %181 = "scf.if"(%180) ({
                %234 = "vector.transfer_read"(%2, %arg4, %arg5, %arg6, %171, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %235 = "vector.extract"(%234) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %236 = "vector.insert"(%235, %179) <{static_position = array<i64: 2, 1, 0>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%236) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%179) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %182 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
              %183 = "arith.cmpi"(%arg0, %182) <{predicate = 4 : i64}> : (index, index) -> i1
              %184 = "scf.if"(%183) ({
                %230 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
                %231 = "vector.transfer_read"(%2, %230, %arg5, %arg6, %171, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %232 = "vector.extract"(%231) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %233 = "vector.insert"(%232, %181) <{static_position = array<i64: 2, 1, 1>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%233) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%181) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %185 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
              %186 = "arith.cmpi"(%arg0, %185) <{predicate = 4 : i64}> : (index, index) -> i1
              %187 = "scf.if"(%186) ({
                %226 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
                %227 = "vector.transfer_read"(%2, %226, %arg5, %arg6, %171, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %228 = "vector.extract"(%227) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %229 = "vector.insert"(%228, %184) <{static_position = array<i64: 2, 1, 2>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%229) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%184) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %188 = "arith.cmpi"(%arg0, %arg4) <{predicate = 4 : i64}> : (index, index) -> i1
              %189 = "scf.if"(%188) ({
                %223 = "vector.transfer_read"(%2, %arg4, %arg5, %arg6, %171, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %224 = "vector.extract"(%223) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %225 = "vector.insert"(%224, %187) <{static_position = array<i64: 2, 2, 0>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%225) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%187) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %190 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
              %191 = "arith.cmpi"(%arg0, %190) <{predicate = 4 : i64}> : (index, index) -> i1
              %192 = "scf.if"(%191) ({
                %219 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
                %220 = "vector.transfer_read"(%2, %219, %arg5, %arg6, %171, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %221 = "vector.extract"(%220) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %222 = "vector.insert"(%221, %189) <{static_position = array<i64: 2, 2, 1>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%222) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%189) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %193 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
              %194 = "arith.cmpi"(%arg0, %193) <{predicate = 4 : i64}> : (index, index) -> i1
              %195 = "scf.if"(%194) ({
                %215 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
                %216 = "vector.transfer_read"(%2, %215, %arg5, %arg6, %171, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %217 = "vector.extract"(%216) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %218 = "vector.insert"(%217, %192) <{static_position = array<i64: 2, 2, 2>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%218) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%192) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %196 = "arith.cmpi"(%arg0, %arg4) <{predicate = 4 : i64}> : (index, index) -> i1
              %197 = "scf.if"(%196) ({
                %212 = "vector.transfer_read"(%2, %arg4, %arg5, %arg6, %171, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %213 = "vector.extract"(%212) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %214 = "vector.insert"(%213, %195) <{static_position = array<i64: 2, 3, 0>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%214) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%195) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %198 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
              %199 = "arith.cmpi"(%arg0, %198) <{predicate = 4 : i64}> : (index, index) -> i1
              %200 = "scf.if"(%199) ({
                %208 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
                %209 = "vector.transfer_read"(%2, %208, %arg5, %arg6, %171, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %210 = "vector.extract"(%209) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %211 = "vector.insert"(%210, %197) <{static_position = array<i64: 2, 3, 1>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%211) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%197) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %201 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
              %202 = "arith.cmpi"(%arg0, %201) <{predicate = 4 : i64}> : (index, index) -> i1
              %203 = "scf.if"(%202) ({
                %204 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
                %205 = "vector.transfer_read"(%2, %204, %arg5, %arg6, %171, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %206 = "vector.extract"(%205) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %207 = "vector.insert"(%206, %200) <{static_position = array<i64: 2, 3, 2>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%207) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%200) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              "scf.yield"(%203) : (vector<5x4x3xf32>) -> ()
            }, {
              "scf.yield"(%7) : (vector<5x4x3xf32>) -> ()
            }) : (i1) -> vector<5x4x3xf32>
            %11 = "affine.apply"(%arg7) <{map = #map3}> : (index) -> index
            %12 = "arith.cmpi"(%arg3, %11) <{predicate = 4 : i64}> : (index, index) -> i1
            %13 = "scf.if"(%12) ({
              %94 = "affine.apply"(%arg7) <{map = #map3}> : (index) -> index
              %95 = "arith.cmpi"(%arg0, %arg4) <{predicate = 4 : i64}> : (index, index) -> i1
              %96 = "scf.if"(%95) ({
                %168 = "vector.transfer_read"(%2, %arg4, %arg5, %arg6, %94, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %169 = "vector.extract"(%168) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %170 = "vector.insert"(%169, %10) <{static_position = array<i64: 3, 0, 0>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%170) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%10) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %97 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
              %98 = "arith.cmpi"(%arg0, %97) <{predicate = 4 : i64}> : (index, index) -> i1
              %99 = "scf.if"(%98) ({
                %164 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
                %165 = "vector.transfer_read"(%2, %164, %arg5, %arg6, %94, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %166 = "vector.extract"(%165) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %167 = "vector.insert"(%166, %96) <{static_position = array<i64: 3, 0, 1>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%167) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%96) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %100 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
              %101 = "arith.cmpi"(%arg0, %100) <{predicate = 4 : i64}> : (index, index) -> i1
              %102 = "scf.if"(%101) ({
                %160 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
                %161 = "vector.transfer_read"(%2, %160, %arg5, %arg6, %94, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %162 = "vector.extract"(%161) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %163 = "vector.insert"(%162, %99) <{static_position = array<i64: 3, 0, 2>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%163) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%99) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %103 = "arith.cmpi"(%arg0, %arg4) <{predicate = 4 : i64}> : (index, index) -> i1
              %104 = "scf.if"(%103) ({
                %157 = "vector.transfer_read"(%2, %arg4, %arg5, %arg6, %94, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %158 = "vector.extract"(%157) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %159 = "vector.insert"(%158, %102) <{static_position = array<i64: 3, 1, 0>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%159) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%102) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %105 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
              %106 = "arith.cmpi"(%arg0, %105) <{predicate = 4 : i64}> : (index, index) -> i1
              %107 = "scf.if"(%106) ({
                %153 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
                %154 = "vector.transfer_read"(%2, %153, %arg5, %arg6, %94, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %155 = "vector.extract"(%154) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %156 = "vector.insert"(%155, %104) <{static_position = array<i64: 3, 1, 1>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%156) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%104) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %108 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
              %109 = "arith.cmpi"(%arg0, %108) <{predicate = 4 : i64}> : (index, index) -> i1
              %110 = "scf.if"(%109) ({
                %149 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
                %150 = "vector.transfer_read"(%2, %149, %arg5, %arg6, %94, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %151 = "vector.extract"(%150) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %152 = "vector.insert"(%151, %107) <{static_position = array<i64: 3, 1, 2>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%152) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%107) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %111 = "arith.cmpi"(%arg0, %arg4) <{predicate = 4 : i64}> : (index, index) -> i1
              %112 = "scf.if"(%111) ({
                %146 = "vector.transfer_read"(%2, %arg4, %arg5, %arg6, %94, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %147 = "vector.extract"(%146) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %148 = "vector.insert"(%147, %110) <{static_position = array<i64: 3, 2, 0>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%148) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%110) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %113 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
              %114 = "arith.cmpi"(%arg0, %113) <{predicate = 4 : i64}> : (index, index) -> i1
              %115 = "scf.if"(%114) ({
                %142 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
                %143 = "vector.transfer_read"(%2, %142, %arg5, %arg6, %94, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %144 = "vector.extract"(%143) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %145 = "vector.insert"(%144, %112) <{static_position = array<i64: 3, 2, 1>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%145) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%112) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %116 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
              %117 = "arith.cmpi"(%arg0, %116) <{predicate = 4 : i64}> : (index, index) -> i1
              %118 = "scf.if"(%117) ({
                %138 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
                %139 = "vector.transfer_read"(%2, %138, %arg5, %arg6, %94, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %140 = "vector.extract"(%139) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %141 = "vector.insert"(%140, %115) <{static_position = array<i64: 3, 2, 2>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%141) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%115) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %119 = "arith.cmpi"(%arg0, %arg4) <{predicate = 4 : i64}> : (index, index) -> i1
              %120 = "scf.if"(%119) ({
                %135 = "vector.transfer_read"(%2, %arg4, %arg5, %arg6, %94, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %136 = "vector.extract"(%135) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %137 = "vector.insert"(%136, %118) <{static_position = array<i64: 3, 3, 0>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%137) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%118) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %121 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
              %122 = "arith.cmpi"(%arg0, %121) <{predicate = 4 : i64}> : (index, index) -> i1
              %123 = "scf.if"(%122) ({
                %131 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
                %132 = "vector.transfer_read"(%2, %131, %arg5, %arg6, %94, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %133 = "vector.extract"(%132) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %134 = "vector.insert"(%133, %120) <{static_position = array<i64: 3, 3, 1>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%134) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%120) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %124 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
              %125 = "arith.cmpi"(%arg0, %124) <{predicate = 4 : i64}> : (index, index) -> i1
              %126 = "scf.if"(%125) ({
                %127 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
                %128 = "vector.transfer_read"(%2, %127, %arg5, %arg6, %94, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %129 = "vector.extract"(%128) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %130 = "vector.insert"(%129, %123) <{static_position = array<i64: 3, 3, 2>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%130) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%123) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              "scf.yield"(%126) : (vector<5x4x3xf32>) -> ()
            }, {
              "scf.yield"(%10) : (vector<5x4x3xf32>) -> ()
            }) : (i1) -> vector<5x4x3xf32>
            %14 = "affine.apply"(%arg7) <{map = #map4}> : (index) -> index
            %15 = "arith.cmpi"(%arg3, %14) <{predicate = 4 : i64}> : (index, index) -> i1
            %16 = "scf.if"(%15) ({
              %17 = "affine.apply"(%arg7) <{map = #map4}> : (index) -> index
              %18 = "arith.cmpi"(%arg0, %arg4) <{predicate = 4 : i64}> : (index, index) -> i1
              %19 = "scf.if"(%18) ({
                %91 = "vector.transfer_read"(%2, %arg4, %arg5, %arg6, %17, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %92 = "vector.extract"(%91) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %93 = "vector.insert"(%92, %13) <{static_position = array<i64: 4, 0, 0>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%93) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%13) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %20 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
              %21 = "arith.cmpi"(%arg0, %20) <{predicate = 4 : i64}> : (index, index) -> i1
              %22 = "scf.if"(%21) ({
                %87 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
                %88 = "vector.transfer_read"(%2, %87, %arg5, %arg6, %17, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %89 = "vector.extract"(%88) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %90 = "vector.insert"(%89, %19) <{static_position = array<i64: 4, 0, 1>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%90) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%19) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %23 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
              %24 = "arith.cmpi"(%arg0, %23) <{predicate = 4 : i64}> : (index, index) -> i1
              %25 = "scf.if"(%24) ({
                %83 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
                %84 = "vector.transfer_read"(%2, %83, %arg5, %arg6, %17, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %85 = "vector.extract"(%84) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %86 = "vector.insert"(%85, %22) <{static_position = array<i64: 4, 0, 2>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%86) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%22) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %26 = "arith.cmpi"(%arg0, %arg4) <{predicate = 4 : i64}> : (index, index) -> i1
              %27 = "scf.if"(%26) ({
                %80 = "vector.transfer_read"(%2, %arg4, %arg5, %arg6, %17, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %81 = "vector.extract"(%80) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %82 = "vector.insert"(%81, %25) <{static_position = array<i64: 4, 1, 0>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%82) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%25) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %28 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
              %29 = "arith.cmpi"(%arg0, %28) <{predicate = 4 : i64}> : (index, index) -> i1
              %30 = "scf.if"(%29) ({
                %76 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
                %77 = "vector.transfer_read"(%2, %76, %arg5, %arg6, %17, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %78 = "vector.extract"(%77) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %79 = "vector.insert"(%78, %27) <{static_position = array<i64: 4, 1, 1>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%79) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%27) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %31 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
              %32 = "arith.cmpi"(%arg0, %31) <{predicate = 4 : i64}> : (index, index) -> i1
              %33 = "scf.if"(%32) ({
                %72 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
                %73 = "vector.transfer_read"(%2, %72, %arg5, %arg6, %17, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %74 = "vector.extract"(%73) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %75 = "vector.insert"(%74, %30) <{static_position = array<i64: 4, 1, 2>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%75) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%30) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %34 = "arith.cmpi"(%arg0, %arg4) <{predicate = 4 : i64}> : (index, index) -> i1
              %35 = "scf.if"(%34) ({
                %69 = "vector.transfer_read"(%2, %arg4, %arg5, %arg6, %17, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %70 = "vector.extract"(%69) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %71 = "vector.insert"(%70, %33) <{static_position = array<i64: 4, 2, 0>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%71) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%33) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %36 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
              %37 = "arith.cmpi"(%arg0, %36) <{predicate = 4 : i64}> : (index, index) -> i1
              %38 = "scf.if"(%37) ({
                %65 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
                %66 = "vector.transfer_read"(%2, %65, %arg5, %arg6, %17, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %67 = "vector.extract"(%66) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %68 = "vector.insert"(%67, %35) <{static_position = array<i64: 4, 2, 1>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%68) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%35) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %39 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
              %40 = "arith.cmpi"(%arg0, %39) <{predicate = 4 : i64}> : (index, index) -> i1
              %41 = "scf.if"(%40) ({
                %61 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
                %62 = "vector.transfer_read"(%2, %61, %arg5, %arg6, %17, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %63 = "vector.extract"(%62) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %64 = "vector.insert"(%63, %38) <{static_position = array<i64: 4, 2, 2>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%64) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%38) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %42 = "arith.cmpi"(%arg0, %arg4) <{predicate = 4 : i64}> : (index, index) -> i1
              %43 = "scf.if"(%42) ({
                %58 = "vector.transfer_read"(%2, %arg4, %arg5, %arg6, %17, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %59 = "vector.extract"(%58) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %60 = "vector.insert"(%59, %41) <{static_position = array<i64: 4, 3, 0>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%60) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%41) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %44 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
              %45 = "arith.cmpi"(%arg0, %44) <{predicate = 4 : i64}> : (index, index) -> i1
              %46 = "scf.if"(%45) ({
                %54 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
                %55 = "vector.transfer_read"(%2, %54, %arg5, %arg6, %17, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %56 = "vector.extract"(%55) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %57 = "vector.insert"(%56, %43) <{static_position = array<i64: 4, 3, 1>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%57) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%43) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              %47 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
              %48 = "arith.cmpi"(%arg0, %47) <{predicate = 4 : i64}> : (index, index) -> i1
              %49 = "scf.if"(%48) ({
                %50 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
                %51 = "vector.transfer_read"(%2, %50, %arg5, %arg6, %17, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
                %52 = "vector.extract"(%51) <{static_position = array<i64>}> : (vector<f32>) -> f32
                %53 = "vector.insert"(%52, %46) <{static_position = array<i64: 4, 3, 2>}> : (f32, vector<5x4x3xf32>) -> vector<5x4x3xf32>
                "scf.yield"(%53) : (vector<5x4x3xf32>) -> ()
              }, {
                "scf.yield"(%46) : (vector<5x4x3xf32>) -> ()
              }) : (i1) -> vector<5x4x3xf32>
              "scf.yield"(%49) : (vector<5x4x3xf32>) -> ()
            }, {
              "scf.yield"(%13) : (vector<5x4x3xf32>) -> ()
            }) : (i1) -> vector<5x4x3xf32>
            "dummy_use"(%16) : (vector<5x4x3xf32>) -> ()
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
#map = affine_map<(d0, d1, d2, d3) -> ()>
#map1 = affine_map<(d0) -> (d0 + 1)>
#map2 = affine_map<(d0) -> (d0 + 2)>
#map3 = affine_map<(d0) -> (d0 + 3)>
#map4 = affine_map<(d0) -> (d0 + 4)>
#map5 = affine_map<() -> (0)>
#map6 = affine_map<()[s0] -> (s0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index) -> (), sym_name = "materialize_write"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = dense<1.000000e+00> : vector<f32>}> : () -> vector<f32>
    %1 = "memref.alloc"(%arg0, %arg1, %arg2, %arg3) <{operandSegmentSizes = array<i32: 4, 0>}> : (index, index, index, index) -> memref<?x?x?x?xf32>
    "affine.for"(%arg0) <{lowerBoundMap = #map5, operandSegmentSizes = array<i32: 0, 1, 0>, step = 3 : index, upperBoundMap = #map6}> ({
    ^bb0(%arg4: index):
      "affine.for"(%arg1) <{lowerBoundMap = #map5, operandSegmentSizes = array<i32: 0, 1, 0>, step = 4 : index, upperBoundMap = #map6}> ({
      ^bb0(%arg5: index):
        "affine.for"(%arg2) <{lowerBoundMap = #map5, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map6}> ({
        ^bb0(%arg6: index):
          "affine.for"(%arg3) <{lowerBoundMap = #map5, operandSegmentSizes = array<i32: 0, 1, 0>, step = 5 : index, upperBoundMap = #map6}> ({
          ^bb0(%arg7: index):
            %2 = "arith.cmpi"(%arg0, %arg4) <{predicate = 4 : i64}> : (index, index) -> i1
            "scf.if"(%2) ({
              %133 = "arith.cmpi"(%arg1, %arg5) <{predicate = 4 : i64}> : (index, index) -> i1
              "scf.if"(%133) ({
                %182 = "arith.cmpi"(%arg3, %arg7) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%182) ({
                  "vector.transfer_write"(%0, %1, %arg4, %arg5, %arg6, %arg7) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %183 = "affine.apply"(%arg7) <{map = #map1}> : (index) -> index
                %184 = "arith.cmpi"(%arg3, %183) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%184) ({
                  %194 = "affine.apply"(%arg7) <{map = #map1}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %arg4, %arg5, %arg6, %194) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %185 = "affine.apply"(%arg7) <{map = #map2}> : (index) -> index
                %186 = "arith.cmpi"(%arg3, %185) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%186) ({
                  %193 = "affine.apply"(%arg7) <{map = #map2}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %arg4, %arg5, %arg6, %193) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %187 = "affine.apply"(%arg7) <{map = #map3}> : (index) -> index
                %188 = "arith.cmpi"(%arg3, %187) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%188) ({
                  %192 = "affine.apply"(%arg7) <{map = #map3}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %arg4, %arg5, %arg6, %192) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %189 = "affine.apply"(%arg7) <{map = #map4}> : (index) -> index
                %190 = "arith.cmpi"(%arg3, %189) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%190) ({
                  %191 = "affine.apply"(%arg7) <{map = #map4}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %arg4, %arg5, %arg6, %191) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                "scf.yield"() : () -> ()
              }, {
                "scf.yield"() : () -> ()
              }) : (i1) -> ()
              %134 = "affine.apply"(%arg5) <{map = #map1}> : (index) -> index
              %135 = "arith.cmpi"(%arg1, %134) <{predicate = 4 : i64}> : (index, index) -> i1
              "scf.if"(%135) ({
                %168 = "affine.apply"(%arg5) <{map = #map1}> : (index) -> index
                %169 = "arith.cmpi"(%arg3, %arg7) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%169) ({
                  "vector.transfer_write"(%0, %1, %arg4, %168, %arg6, %arg7) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %170 = "affine.apply"(%arg7) <{map = #map1}> : (index) -> index
                %171 = "arith.cmpi"(%arg3, %170) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%171) ({
                  %181 = "affine.apply"(%arg7) <{map = #map1}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %arg4, %168, %arg6, %181) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %172 = "affine.apply"(%arg7) <{map = #map2}> : (index) -> index
                %173 = "arith.cmpi"(%arg3, %172) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%173) ({
                  %180 = "affine.apply"(%arg7) <{map = #map2}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %arg4, %168, %arg6, %180) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %174 = "affine.apply"(%arg7) <{map = #map3}> : (index) -> index
                %175 = "arith.cmpi"(%arg3, %174) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%175) ({
                  %179 = "affine.apply"(%arg7) <{map = #map3}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %arg4, %168, %arg6, %179) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %176 = "affine.apply"(%arg7) <{map = #map4}> : (index) -> index
                %177 = "arith.cmpi"(%arg3, %176) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%177) ({
                  %178 = "affine.apply"(%arg7) <{map = #map4}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %arg4, %168, %arg6, %178) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                "scf.yield"() : () -> ()
              }, {
                "scf.yield"() : () -> ()
              }) : (i1) -> ()
              %136 = "affine.apply"(%arg5) <{map = #map2}> : (index) -> index
              %137 = "arith.cmpi"(%arg1, %136) <{predicate = 4 : i64}> : (index, index) -> i1
              "scf.if"(%137) ({
                %154 = "affine.apply"(%arg5) <{map = #map2}> : (index) -> index
                %155 = "arith.cmpi"(%arg3, %arg7) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%155) ({
                  "vector.transfer_write"(%0, %1, %arg4, %154, %arg6, %arg7) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %156 = "affine.apply"(%arg7) <{map = #map1}> : (index) -> index
                %157 = "arith.cmpi"(%arg3, %156) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%157) ({
                  %167 = "affine.apply"(%arg7) <{map = #map1}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %arg4, %154, %arg6, %167) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %158 = "affine.apply"(%arg7) <{map = #map2}> : (index) -> index
                %159 = "arith.cmpi"(%arg3, %158) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%159) ({
                  %166 = "affine.apply"(%arg7) <{map = #map2}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %arg4, %154, %arg6, %166) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %160 = "affine.apply"(%arg7) <{map = #map3}> : (index) -> index
                %161 = "arith.cmpi"(%arg3, %160) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%161) ({
                  %165 = "affine.apply"(%arg7) <{map = #map3}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %arg4, %154, %arg6, %165) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %162 = "affine.apply"(%arg7) <{map = #map4}> : (index) -> index
                %163 = "arith.cmpi"(%arg3, %162) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%163) ({
                  %164 = "affine.apply"(%arg7) <{map = #map4}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %arg4, %154, %arg6, %164) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                "scf.yield"() : () -> ()
              }, {
                "scf.yield"() : () -> ()
              }) : (i1) -> ()
              %138 = "affine.apply"(%arg5) <{map = #map3}> : (index) -> index
              %139 = "arith.cmpi"(%arg1, %138) <{predicate = 4 : i64}> : (index, index) -> i1
              "scf.if"(%139) ({
                %140 = "affine.apply"(%arg5) <{map = #map3}> : (index) -> index
                %141 = "arith.cmpi"(%arg3, %arg7) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%141) ({
                  "vector.transfer_write"(%0, %1, %arg4, %140, %arg6, %arg7) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %142 = "affine.apply"(%arg7) <{map = #map1}> : (index) -> index
                %143 = "arith.cmpi"(%arg3, %142) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%143) ({
                  %153 = "affine.apply"(%arg7) <{map = #map1}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %arg4, %140, %arg6, %153) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %144 = "affine.apply"(%arg7) <{map = #map2}> : (index) -> index
                %145 = "arith.cmpi"(%arg3, %144) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%145) ({
                  %152 = "affine.apply"(%arg7) <{map = #map2}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %arg4, %140, %arg6, %152) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %146 = "affine.apply"(%arg7) <{map = #map3}> : (index) -> index
                %147 = "arith.cmpi"(%arg3, %146) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%147) ({
                  %151 = "affine.apply"(%arg7) <{map = #map3}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %arg4, %140, %arg6, %151) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %148 = "affine.apply"(%arg7) <{map = #map4}> : (index) -> index
                %149 = "arith.cmpi"(%arg3, %148) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%149) ({
                  %150 = "affine.apply"(%arg7) <{map = #map4}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %arg4, %140, %arg6, %150) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                "scf.yield"() : () -> ()
              }, {
                "scf.yield"() : () -> ()
              }) : (i1) -> ()
              "scf.yield"() : () -> ()
            }, {
              "scf.yield"() : () -> ()
            }) : (i1) -> ()
            %3 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
            %4 = "arith.cmpi"(%arg0, %3) <{predicate = 4 : i64}> : (index, index) -> i1
            "scf.if"(%4) ({
              %70 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
              %71 = "arith.cmpi"(%arg1, %arg5) <{predicate = 4 : i64}> : (index, index) -> i1
              "scf.if"(%71) ({
                %120 = "arith.cmpi"(%arg3, %arg7) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%120) ({
                  "vector.transfer_write"(%0, %1, %70, %arg5, %arg6, %arg7) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %121 = "affine.apply"(%arg7) <{map = #map1}> : (index) -> index
                %122 = "arith.cmpi"(%arg3, %121) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%122) ({
                  %132 = "affine.apply"(%arg7) <{map = #map1}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %70, %arg5, %arg6, %132) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %123 = "affine.apply"(%arg7) <{map = #map2}> : (index) -> index
                %124 = "arith.cmpi"(%arg3, %123) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%124) ({
                  %131 = "affine.apply"(%arg7) <{map = #map2}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %70, %arg5, %arg6, %131) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %125 = "affine.apply"(%arg7) <{map = #map3}> : (index) -> index
                %126 = "arith.cmpi"(%arg3, %125) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%126) ({
                  %130 = "affine.apply"(%arg7) <{map = #map3}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %70, %arg5, %arg6, %130) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %127 = "affine.apply"(%arg7) <{map = #map4}> : (index) -> index
                %128 = "arith.cmpi"(%arg3, %127) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%128) ({
                  %129 = "affine.apply"(%arg7) <{map = #map4}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %70, %arg5, %arg6, %129) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                "scf.yield"() : () -> ()
              }, {
                "scf.yield"() : () -> ()
              }) : (i1) -> ()
              %72 = "affine.apply"(%arg5) <{map = #map1}> : (index) -> index
              %73 = "arith.cmpi"(%arg1, %72) <{predicate = 4 : i64}> : (index, index) -> i1
              "scf.if"(%73) ({
                %106 = "affine.apply"(%arg5) <{map = #map1}> : (index) -> index
                %107 = "arith.cmpi"(%arg3, %arg7) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%107) ({
                  "vector.transfer_write"(%0, %1, %70, %106, %arg6, %arg7) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %108 = "affine.apply"(%arg7) <{map = #map1}> : (index) -> index
                %109 = "arith.cmpi"(%arg3, %108) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%109) ({
                  %119 = "affine.apply"(%arg7) <{map = #map1}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %70, %106, %arg6, %119) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %110 = "affine.apply"(%arg7) <{map = #map2}> : (index) -> index
                %111 = "arith.cmpi"(%arg3, %110) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%111) ({
                  %118 = "affine.apply"(%arg7) <{map = #map2}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %70, %106, %arg6, %118) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %112 = "affine.apply"(%arg7) <{map = #map3}> : (index) -> index
                %113 = "arith.cmpi"(%arg3, %112) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%113) ({
                  %117 = "affine.apply"(%arg7) <{map = #map3}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %70, %106, %arg6, %117) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %114 = "affine.apply"(%arg7) <{map = #map4}> : (index) -> index
                %115 = "arith.cmpi"(%arg3, %114) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%115) ({
                  %116 = "affine.apply"(%arg7) <{map = #map4}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %70, %106, %arg6, %116) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                "scf.yield"() : () -> ()
              }, {
                "scf.yield"() : () -> ()
              }) : (i1) -> ()
              %74 = "affine.apply"(%arg5) <{map = #map2}> : (index) -> index
              %75 = "arith.cmpi"(%arg1, %74) <{predicate = 4 : i64}> : (index, index) -> i1
              "scf.if"(%75) ({
                %92 = "affine.apply"(%arg5) <{map = #map2}> : (index) -> index
                %93 = "arith.cmpi"(%arg3, %arg7) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%93) ({
                  "vector.transfer_write"(%0, %1, %70, %92, %arg6, %arg7) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %94 = "affine.apply"(%arg7) <{map = #map1}> : (index) -> index
                %95 = "arith.cmpi"(%arg3, %94) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%95) ({
                  %105 = "affine.apply"(%arg7) <{map = #map1}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %70, %92, %arg6, %105) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %96 = "affine.apply"(%arg7) <{map = #map2}> : (index) -> index
                %97 = "arith.cmpi"(%arg3, %96) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%97) ({
                  %104 = "affine.apply"(%arg7) <{map = #map2}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %70, %92, %arg6, %104) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %98 = "affine.apply"(%arg7) <{map = #map3}> : (index) -> index
                %99 = "arith.cmpi"(%arg3, %98) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%99) ({
                  %103 = "affine.apply"(%arg7) <{map = #map3}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %70, %92, %arg6, %103) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %100 = "affine.apply"(%arg7) <{map = #map4}> : (index) -> index
                %101 = "arith.cmpi"(%arg3, %100) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%101) ({
                  %102 = "affine.apply"(%arg7) <{map = #map4}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %70, %92, %arg6, %102) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                "scf.yield"() : () -> ()
              }, {
                "scf.yield"() : () -> ()
              }) : (i1) -> ()
              %76 = "affine.apply"(%arg5) <{map = #map3}> : (index) -> index
              %77 = "arith.cmpi"(%arg1, %76) <{predicate = 4 : i64}> : (index, index) -> i1
              "scf.if"(%77) ({
                %78 = "affine.apply"(%arg5) <{map = #map3}> : (index) -> index
                %79 = "arith.cmpi"(%arg3, %arg7) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%79) ({
                  "vector.transfer_write"(%0, %1, %70, %78, %arg6, %arg7) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %80 = "affine.apply"(%arg7) <{map = #map1}> : (index) -> index
                %81 = "arith.cmpi"(%arg3, %80) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%81) ({
                  %91 = "affine.apply"(%arg7) <{map = #map1}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %70, %78, %arg6, %91) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %82 = "affine.apply"(%arg7) <{map = #map2}> : (index) -> index
                %83 = "arith.cmpi"(%arg3, %82) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%83) ({
                  %90 = "affine.apply"(%arg7) <{map = #map2}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %70, %78, %arg6, %90) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %84 = "affine.apply"(%arg7) <{map = #map3}> : (index) -> index
                %85 = "arith.cmpi"(%arg3, %84) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%85) ({
                  %89 = "affine.apply"(%arg7) <{map = #map3}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %70, %78, %arg6, %89) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %86 = "affine.apply"(%arg7) <{map = #map4}> : (index) -> index
                %87 = "arith.cmpi"(%arg3, %86) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%87) ({
                  %88 = "affine.apply"(%arg7) <{map = #map4}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %70, %78, %arg6, %88) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                "scf.yield"() : () -> ()
              }, {
                "scf.yield"() : () -> ()
              }) : (i1) -> ()
              "scf.yield"() : () -> ()
            }, {
              "scf.yield"() : () -> ()
            }) : (i1) -> ()
            %5 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
            %6 = "arith.cmpi"(%arg0, %5) <{predicate = 4 : i64}> : (index, index) -> i1
            "scf.if"(%6) ({
              %7 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
              %8 = "arith.cmpi"(%arg1, %arg5) <{predicate = 4 : i64}> : (index, index) -> i1
              "scf.if"(%8) ({
                %57 = "arith.cmpi"(%arg3, %arg7) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%57) ({
                  "vector.transfer_write"(%0, %1, %7, %arg5, %arg6, %arg7) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %58 = "affine.apply"(%arg7) <{map = #map1}> : (index) -> index
                %59 = "arith.cmpi"(%arg3, %58) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%59) ({
                  %69 = "affine.apply"(%arg7) <{map = #map1}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %7, %arg5, %arg6, %69) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %60 = "affine.apply"(%arg7) <{map = #map2}> : (index) -> index
                %61 = "arith.cmpi"(%arg3, %60) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%61) ({
                  %68 = "affine.apply"(%arg7) <{map = #map2}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %7, %arg5, %arg6, %68) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %62 = "affine.apply"(%arg7) <{map = #map3}> : (index) -> index
                %63 = "arith.cmpi"(%arg3, %62) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%63) ({
                  %67 = "affine.apply"(%arg7) <{map = #map3}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %7, %arg5, %arg6, %67) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %64 = "affine.apply"(%arg7) <{map = #map4}> : (index) -> index
                %65 = "arith.cmpi"(%arg3, %64) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%65) ({
                  %66 = "affine.apply"(%arg7) <{map = #map4}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %7, %arg5, %arg6, %66) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                "scf.yield"() : () -> ()
              }, {
                "scf.yield"() : () -> ()
              }) : (i1) -> ()
              %9 = "affine.apply"(%arg5) <{map = #map1}> : (index) -> index
              %10 = "arith.cmpi"(%arg1, %9) <{predicate = 4 : i64}> : (index, index) -> i1
              "scf.if"(%10) ({
                %43 = "affine.apply"(%arg5) <{map = #map1}> : (index) -> index
                %44 = "arith.cmpi"(%arg3, %arg7) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%44) ({
                  "vector.transfer_write"(%0, %1, %7, %43, %arg6, %arg7) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %45 = "affine.apply"(%arg7) <{map = #map1}> : (index) -> index
                %46 = "arith.cmpi"(%arg3, %45) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%46) ({
                  %56 = "affine.apply"(%arg7) <{map = #map1}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %7, %43, %arg6, %56) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %47 = "affine.apply"(%arg7) <{map = #map2}> : (index) -> index
                %48 = "arith.cmpi"(%arg3, %47) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%48) ({
                  %55 = "affine.apply"(%arg7) <{map = #map2}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %7, %43, %arg6, %55) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %49 = "affine.apply"(%arg7) <{map = #map3}> : (index) -> index
                %50 = "arith.cmpi"(%arg3, %49) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%50) ({
                  %54 = "affine.apply"(%arg7) <{map = #map3}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %7, %43, %arg6, %54) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %51 = "affine.apply"(%arg7) <{map = #map4}> : (index) -> index
                %52 = "arith.cmpi"(%arg3, %51) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%52) ({
                  %53 = "affine.apply"(%arg7) <{map = #map4}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %7, %43, %arg6, %53) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                "scf.yield"() : () -> ()
              }, {
                "scf.yield"() : () -> ()
              }) : (i1) -> ()
              %11 = "affine.apply"(%arg5) <{map = #map2}> : (index) -> index
              %12 = "arith.cmpi"(%arg1, %11) <{predicate = 4 : i64}> : (index, index) -> i1
              "scf.if"(%12) ({
                %29 = "affine.apply"(%arg5) <{map = #map2}> : (index) -> index
                %30 = "arith.cmpi"(%arg3, %arg7) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%30) ({
                  "vector.transfer_write"(%0, %1, %7, %29, %arg6, %arg7) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %31 = "affine.apply"(%arg7) <{map = #map1}> : (index) -> index
                %32 = "arith.cmpi"(%arg3, %31) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%32) ({
                  %42 = "affine.apply"(%arg7) <{map = #map1}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %7, %29, %arg6, %42) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %33 = "affine.apply"(%arg7) <{map = #map2}> : (index) -> index
                %34 = "arith.cmpi"(%arg3, %33) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%34) ({
                  %41 = "affine.apply"(%arg7) <{map = #map2}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %7, %29, %arg6, %41) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %35 = "affine.apply"(%arg7) <{map = #map3}> : (index) -> index
                %36 = "arith.cmpi"(%arg3, %35) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%36) ({
                  %40 = "affine.apply"(%arg7) <{map = #map3}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %7, %29, %arg6, %40) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %37 = "affine.apply"(%arg7) <{map = #map4}> : (index) -> index
                %38 = "arith.cmpi"(%arg3, %37) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%38) ({
                  %39 = "affine.apply"(%arg7) <{map = #map4}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %7, %29, %arg6, %39) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                "scf.yield"() : () -> ()
              }, {
                "scf.yield"() : () -> ()
              }) : (i1) -> ()
              %13 = "affine.apply"(%arg5) <{map = #map3}> : (index) -> index
              %14 = "arith.cmpi"(%arg1, %13) <{predicate = 4 : i64}> : (index, index) -> i1
              "scf.if"(%14) ({
                %15 = "affine.apply"(%arg5) <{map = #map3}> : (index) -> index
                %16 = "arith.cmpi"(%arg3, %arg7) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%16) ({
                  "vector.transfer_write"(%0, %1, %7, %15, %arg6, %arg7) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %17 = "affine.apply"(%arg7) <{map = #map1}> : (index) -> index
                %18 = "arith.cmpi"(%arg3, %17) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%18) ({
                  %28 = "affine.apply"(%arg7) <{map = #map1}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %7, %15, %arg6, %28) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %19 = "affine.apply"(%arg7) <{map = #map2}> : (index) -> index
                %20 = "arith.cmpi"(%arg3, %19) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%20) ({
                  %27 = "affine.apply"(%arg7) <{map = #map2}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %7, %15, %arg6, %27) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %21 = "affine.apply"(%arg7) <{map = #map3}> : (index) -> index
                %22 = "arith.cmpi"(%arg3, %21) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%22) ({
                  %26 = "affine.apply"(%arg7) <{map = #map3}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %7, %15, %arg6, %26) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                %23 = "affine.apply"(%arg7) <{map = #map4}> : (index) -> index
                %24 = "arith.cmpi"(%arg3, %23) <{predicate = 4 : i64}> : (index, index) -> i1
                "scf.if"(%24) ({
                  %25 = "affine.apply"(%arg7) <{map = #map4}> : (index) -> index
                  "vector.transfer_write"(%0, %1, %7, %15, %arg6, %25) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                  "scf.yield"() : () -> ()
                }, {
                  "scf.yield"() : () -> ()
                }) : (i1) -> ()
                "scf.yield"() : () -> ()
              }, {
                "scf.yield"() : () -> ()
              }) : (i1) -> ()
              "scf.yield"() : () -> ()
            }, {
              "scf.yield"() : () -> ()
            }) : (i1) -> ()
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
#map = affine_map<(d0, d1) -> ()>
#map1 = affine_map<()[s0] -> (s0 + 1)>
#map2 = affine_map<()[s0] -> (s0 + 2)>
#map3 = affine_map<()[s0] -> (s0 + 3)>
#map4 = affine_map<()[s0] -> (s0 + 4)>
#map5 = affine_map<()[s0] -> (s0 + 5)>
#map6 = affine_map<()[s0] -> (s0 + 6)>
#map7 = affine_map<()[s0] -> (s0 + 7)>
#map8 = affine_map<()[s0] -> (s0 + 8)>
#map9 = affine_map<()[s0] -> (s0 + 9)>
#map10 = affine_map<()[s0] -> (s0 + 10)>
#map11 = affine_map<()[s0] -> (s0 + 11)>
#map12 = affine_map<()[s0] -> (s0 + 12)>
#map13 = affine_map<()[s0] -> (s0 + 13)>
#map14 = affine_map<()[s0] -> (s0 + 14)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, index) -> vector<3x15xf32>, sym_name = "transfer_read_progressive"}> ({
  ^bb0(%arg0: memref<?x?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = dense<7.000000e+00> : vector<3x15xf32>}> : () -> vector<3x15xf32>
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "memref.dim"(%arg0, %3) : (memref<?x?xf32>, index) -> index
    %5 = "arith.cmpi"(%4, %arg1) <{predicate = 4 : i64}> : (index, index) -> i1
    %6 = "scf.if"(%5) ({
      %253 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %254 = "arith.cmpi"(%253, %arg1) <{predicate = 4 : i64}> : (index, index) -> i1
      %255 = "scf.if"(%254) ({
        %368 = "vector.transfer_read"(%arg0, %arg1, %arg1, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %369 = "vector.extract"(%368) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %370 = "vector.insert"(%369, %2) <{static_position = array<i64: 0, 0>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%370) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%2) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %256 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %257 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
      %258 = "arith.cmpi"(%256, %257) <{predicate = 4 : i64}> : (index, index) -> i1
      %259 = "scf.if"(%258) ({
        %364 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
        %365 = "vector.transfer_read"(%arg0, %arg1, %364, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %366 = "vector.extract"(%365) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %367 = "vector.insert"(%366, %255) <{static_position = array<i64: 0, 1>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%367) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%255) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %260 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %261 = "affine.apply"(%arg1) <{map = #map2}> : (index) -> index
      %262 = "arith.cmpi"(%260, %261) <{predicate = 4 : i64}> : (index, index) -> i1
      %263 = "scf.if"(%262) ({
        %360 = "affine.apply"(%arg1) <{map = #map2}> : (index) -> index
        %361 = "vector.transfer_read"(%arg0, %arg1, %360, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %362 = "vector.extract"(%361) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %363 = "vector.insert"(%362, %259) <{static_position = array<i64: 0, 2>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%363) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%259) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %264 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %265 = "affine.apply"(%arg1) <{map = #map3}> : (index) -> index
      %266 = "arith.cmpi"(%264, %265) <{predicate = 4 : i64}> : (index, index) -> i1
      %267 = "scf.if"(%266) ({
        %356 = "affine.apply"(%arg1) <{map = #map3}> : (index) -> index
        %357 = "vector.transfer_read"(%arg0, %arg1, %356, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %358 = "vector.extract"(%357) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %359 = "vector.insert"(%358, %263) <{static_position = array<i64: 0, 3>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%359) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%263) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %268 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %269 = "affine.apply"(%arg1) <{map = #map4}> : (index) -> index
      %270 = "arith.cmpi"(%268, %269) <{predicate = 4 : i64}> : (index, index) -> i1
      %271 = "scf.if"(%270) ({
        %352 = "affine.apply"(%arg1) <{map = #map4}> : (index) -> index
        %353 = "vector.transfer_read"(%arg0, %arg1, %352, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %354 = "vector.extract"(%353) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %355 = "vector.insert"(%354, %267) <{static_position = array<i64: 0, 4>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%355) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%267) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %272 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %273 = "affine.apply"(%arg1) <{map = #map5}> : (index) -> index
      %274 = "arith.cmpi"(%272, %273) <{predicate = 4 : i64}> : (index, index) -> i1
      %275 = "scf.if"(%274) ({
        %348 = "affine.apply"(%arg1) <{map = #map5}> : (index) -> index
        %349 = "vector.transfer_read"(%arg0, %arg1, %348, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %350 = "vector.extract"(%349) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %351 = "vector.insert"(%350, %271) <{static_position = array<i64: 0, 5>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%351) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%271) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %276 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %277 = "affine.apply"(%arg1) <{map = #map6}> : (index) -> index
      %278 = "arith.cmpi"(%276, %277) <{predicate = 4 : i64}> : (index, index) -> i1
      %279 = "scf.if"(%278) ({
        %344 = "affine.apply"(%arg1) <{map = #map6}> : (index) -> index
        %345 = "vector.transfer_read"(%arg0, %arg1, %344, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %346 = "vector.extract"(%345) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %347 = "vector.insert"(%346, %275) <{static_position = array<i64: 0, 6>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%347) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%275) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %280 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %281 = "affine.apply"(%arg1) <{map = #map7}> : (index) -> index
      %282 = "arith.cmpi"(%280, %281) <{predicate = 4 : i64}> : (index, index) -> i1
      %283 = "scf.if"(%282) ({
        %340 = "affine.apply"(%arg1) <{map = #map7}> : (index) -> index
        %341 = "vector.transfer_read"(%arg0, %arg1, %340, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %342 = "vector.extract"(%341) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %343 = "vector.insert"(%342, %279) <{static_position = array<i64: 0, 7>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%343) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%279) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %284 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %285 = "affine.apply"(%arg1) <{map = #map8}> : (index) -> index
      %286 = "arith.cmpi"(%284, %285) <{predicate = 4 : i64}> : (index, index) -> i1
      %287 = "scf.if"(%286) ({
        %336 = "affine.apply"(%arg1) <{map = #map8}> : (index) -> index
        %337 = "vector.transfer_read"(%arg0, %arg1, %336, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %338 = "vector.extract"(%337) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %339 = "vector.insert"(%338, %283) <{static_position = array<i64: 0, 8>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%339) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%283) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %288 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %289 = "affine.apply"(%arg1) <{map = #map9}> : (index) -> index
      %290 = "arith.cmpi"(%288, %289) <{predicate = 4 : i64}> : (index, index) -> i1
      %291 = "scf.if"(%290) ({
        %332 = "affine.apply"(%arg1) <{map = #map9}> : (index) -> index
        %333 = "vector.transfer_read"(%arg0, %arg1, %332, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %334 = "vector.extract"(%333) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %335 = "vector.insert"(%334, %287) <{static_position = array<i64: 0, 9>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%335) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%287) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %292 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %293 = "affine.apply"(%arg1) <{map = #map10}> : (index) -> index
      %294 = "arith.cmpi"(%292, %293) <{predicate = 4 : i64}> : (index, index) -> i1
      %295 = "scf.if"(%294) ({
        %328 = "affine.apply"(%arg1) <{map = #map10}> : (index) -> index
        %329 = "vector.transfer_read"(%arg0, %arg1, %328, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %330 = "vector.extract"(%329) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %331 = "vector.insert"(%330, %291) <{static_position = array<i64: 0, 10>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%331) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%291) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %296 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %297 = "affine.apply"(%arg1) <{map = #map11}> : (index) -> index
      %298 = "arith.cmpi"(%296, %297) <{predicate = 4 : i64}> : (index, index) -> i1
      %299 = "scf.if"(%298) ({
        %324 = "affine.apply"(%arg1) <{map = #map11}> : (index) -> index
        %325 = "vector.transfer_read"(%arg0, %arg1, %324, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %326 = "vector.extract"(%325) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %327 = "vector.insert"(%326, %295) <{static_position = array<i64: 0, 11>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%327) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%295) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %300 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %301 = "affine.apply"(%arg1) <{map = #map12}> : (index) -> index
      %302 = "arith.cmpi"(%300, %301) <{predicate = 4 : i64}> : (index, index) -> i1
      %303 = "scf.if"(%302) ({
        %320 = "affine.apply"(%arg1) <{map = #map12}> : (index) -> index
        %321 = "vector.transfer_read"(%arg0, %arg1, %320, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %322 = "vector.extract"(%321) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %323 = "vector.insert"(%322, %299) <{static_position = array<i64: 0, 12>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%323) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%299) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %304 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %305 = "affine.apply"(%arg1) <{map = #map13}> : (index) -> index
      %306 = "arith.cmpi"(%304, %305) <{predicate = 4 : i64}> : (index, index) -> i1
      %307 = "scf.if"(%306) ({
        %316 = "affine.apply"(%arg1) <{map = #map13}> : (index) -> index
        %317 = "vector.transfer_read"(%arg0, %arg1, %316, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %318 = "vector.extract"(%317) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %319 = "vector.insert"(%318, %303) <{static_position = array<i64: 0, 13>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%319) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%303) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %308 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %309 = "affine.apply"(%arg1) <{map = #map14}> : (index) -> index
      %310 = "arith.cmpi"(%308, %309) <{predicate = 4 : i64}> : (index, index) -> i1
      %311 = "scf.if"(%310) ({
        %312 = "affine.apply"(%arg1) <{map = #map14}> : (index) -> index
        %313 = "vector.transfer_read"(%arg0, %arg1, %312, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %314 = "vector.extract"(%313) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %315 = "vector.insert"(%314, %307) <{static_position = array<i64: 0, 14>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%315) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%307) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      "scf.yield"(%311) : (vector<3x15xf32>) -> ()
    }, {
      "scf.yield"(%2) : (vector<3x15xf32>) -> ()
    }) : (i1) -> vector<3x15xf32>
    %7 = "memref.dim"(%arg0, %3) : (memref<?x?xf32>, index) -> index
    %8 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
    %9 = "arith.cmpi"(%7, %8) <{predicate = 4 : i64}> : (index, index) -> i1
    %10 = "scf.if"(%9) ({
      %134 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
      %135 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %136 = "arith.cmpi"(%135, %arg1) <{predicate = 4 : i64}> : (index, index) -> i1
      %137 = "scf.if"(%136) ({
        %250 = "vector.transfer_read"(%arg0, %134, %arg1, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %251 = "vector.extract"(%250) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %252 = "vector.insert"(%251, %6) <{static_position = array<i64: 1, 0>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%252) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%6) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %138 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %139 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
      %140 = "arith.cmpi"(%138, %139) <{predicate = 4 : i64}> : (index, index) -> i1
      %141 = "scf.if"(%140) ({
        %246 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
        %247 = "vector.transfer_read"(%arg0, %134, %246, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %248 = "vector.extract"(%247) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %249 = "vector.insert"(%248, %137) <{static_position = array<i64: 1, 1>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%249) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%137) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %142 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %143 = "affine.apply"(%arg1) <{map = #map2}> : (index) -> index
      %144 = "arith.cmpi"(%142, %143) <{predicate = 4 : i64}> : (index, index) -> i1
      %145 = "scf.if"(%144) ({
        %242 = "affine.apply"(%arg1) <{map = #map2}> : (index) -> index
        %243 = "vector.transfer_read"(%arg0, %134, %242, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %244 = "vector.extract"(%243) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %245 = "vector.insert"(%244, %141) <{static_position = array<i64: 1, 2>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%245) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%141) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %146 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %147 = "affine.apply"(%arg1) <{map = #map3}> : (index) -> index
      %148 = "arith.cmpi"(%146, %147) <{predicate = 4 : i64}> : (index, index) -> i1
      %149 = "scf.if"(%148) ({
        %238 = "affine.apply"(%arg1) <{map = #map3}> : (index) -> index
        %239 = "vector.transfer_read"(%arg0, %134, %238, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %240 = "vector.extract"(%239) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %241 = "vector.insert"(%240, %145) <{static_position = array<i64: 1, 3>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%241) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%145) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %150 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %151 = "affine.apply"(%arg1) <{map = #map4}> : (index) -> index
      %152 = "arith.cmpi"(%150, %151) <{predicate = 4 : i64}> : (index, index) -> i1
      %153 = "scf.if"(%152) ({
        %234 = "affine.apply"(%arg1) <{map = #map4}> : (index) -> index
        %235 = "vector.transfer_read"(%arg0, %134, %234, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %236 = "vector.extract"(%235) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %237 = "vector.insert"(%236, %149) <{static_position = array<i64: 1, 4>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%237) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%149) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %154 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %155 = "affine.apply"(%arg1) <{map = #map5}> : (index) -> index
      %156 = "arith.cmpi"(%154, %155) <{predicate = 4 : i64}> : (index, index) -> i1
      %157 = "scf.if"(%156) ({
        %230 = "affine.apply"(%arg1) <{map = #map5}> : (index) -> index
        %231 = "vector.transfer_read"(%arg0, %134, %230, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %232 = "vector.extract"(%231) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %233 = "vector.insert"(%232, %153) <{static_position = array<i64: 1, 5>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%233) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%153) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %158 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %159 = "affine.apply"(%arg1) <{map = #map6}> : (index) -> index
      %160 = "arith.cmpi"(%158, %159) <{predicate = 4 : i64}> : (index, index) -> i1
      %161 = "scf.if"(%160) ({
        %226 = "affine.apply"(%arg1) <{map = #map6}> : (index) -> index
        %227 = "vector.transfer_read"(%arg0, %134, %226, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %228 = "vector.extract"(%227) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %229 = "vector.insert"(%228, %157) <{static_position = array<i64: 1, 6>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%229) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%157) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %162 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %163 = "affine.apply"(%arg1) <{map = #map7}> : (index) -> index
      %164 = "arith.cmpi"(%162, %163) <{predicate = 4 : i64}> : (index, index) -> i1
      %165 = "scf.if"(%164) ({
        %222 = "affine.apply"(%arg1) <{map = #map7}> : (index) -> index
        %223 = "vector.transfer_read"(%arg0, %134, %222, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %224 = "vector.extract"(%223) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %225 = "vector.insert"(%224, %161) <{static_position = array<i64: 1, 7>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%225) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%161) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %166 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %167 = "affine.apply"(%arg1) <{map = #map8}> : (index) -> index
      %168 = "arith.cmpi"(%166, %167) <{predicate = 4 : i64}> : (index, index) -> i1
      %169 = "scf.if"(%168) ({
        %218 = "affine.apply"(%arg1) <{map = #map8}> : (index) -> index
        %219 = "vector.transfer_read"(%arg0, %134, %218, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %220 = "vector.extract"(%219) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %221 = "vector.insert"(%220, %165) <{static_position = array<i64: 1, 8>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%221) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%165) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %170 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %171 = "affine.apply"(%arg1) <{map = #map9}> : (index) -> index
      %172 = "arith.cmpi"(%170, %171) <{predicate = 4 : i64}> : (index, index) -> i1
      %173 = "scf.if"(%172) ({
        %214 = "affine.apply"(%arg1) <{map = #map9}> : (index) -> index
        %215 = "vector.transfer_read"(%arg0, %134, %214, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %216 = "vector.extract"(%215) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %217 = "vector.insert"(%216, %169) <{static_position = array<i64: 1, 9>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%217) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%169) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %174 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %175 = "affine.apply"(%arg1) <{map = #map10}> : (index) -> index
      %176 = "arith.cmpi"(%174, %175) <{predicate = 4 : i64}> : (index, index) -> i1
      %177 = "scf.if"(%176) ({
        %210 = "affine.apply"(%arg1) <{map = #map10}> : (index) -> index
        %211 = "vector.transfer_read"(%arg0, %134, %210, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %212 = "vector.extract"(%211) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %213 = "vector.insert"(%212, %173) <{static_position = array<i64: 1, 10>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%213) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%173) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %178 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %179 = "affine.apply"(%arg1) <{map = #map11}> : (index) -> index
      %180 = "arith.cmpi"(%178, %179) <{predicate = 4 : i64}> : (index, index) -> i1
      %181 = "scf.if"(%180) ({
        %206 = "affine.apply"(%arg1) <{map = #map11}> : (index) -> index
        %207 = "vector.transfer_read"(%arg0, %134, %206, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %208 = "vector.extract"(%207) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %209 = "vector.insert"(%208, %177) <{static_position = array<i64: 1, 11>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%209) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%177) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %182 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %183 = "affine.apply"(%arg1) <{map = #map12}> : (index) -> index
      %184 = "arith.cmpi"(%182, %183) <{predicate = 4 : i64}> : (index, index) -> i1
      %185 = "scf.if"(%184) ({
        %202 = "affine.apply"(%arg1) <{map = #map12}> : (index) -> index
        %203 = "vector.transfer_read"(%arg0, %134, %202, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %204 = "vector.extract"(%203) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %205 = "vector.insert"(%204, %181) <{static_position = array<i64: 1, 12>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%205) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%181) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %186 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %187 = "affine.apply"(%arg1) <{map = #map13}> : (index) -> index
      %188 = "arith.cmpi"(%186, %187) <{predicate = 4 : i64}> : (index, index) -> i1
      %189 = "scf.if"(%188) ({
        %198 = "affine.apply"(%arg1) <{map = #map13}> : (index) -> index
        %199 = "vector.transfer_read"(%arg0, %134, %198, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %200 = "vector.extract"(%199) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %201 = "vector.insert"(%200, %185) <{static_position = array<i64: 1, 13>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%201) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%185) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %190 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %191 = "affine.apply"(%arg1) <{map = #map14}> : (index) -> index
      %192 = "arith.cmpi"(%190, %191) <{predicate = 4 : i64}> : (index, index) -> i1
      %193 = "scf.if"(%192) ({
        %194 = "affine.apply"(%arg1) <{map = #map14}> : (index) -> index
        %195 = "vector.transfer_read"(%arg0, %134, %194, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %196 = "vector.extract"(%195) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %197 = "vector.insert"(%196, %189) <{static_position = array<i64: 1, 14>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%197) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%189) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      "scf.yield"(%193) : (vector<3x15xf32>) -> ()
    }, {
      "scf.yield"(%6) : (vector<3x15xf32>) -> ()
    }) : (i1) -> vector<3x15xf32>
    %11 = "memref.dim"(%arg0, %3) : (memref<?x?xf32>, index) -> index
    %12 = "affine.apply"(%arg1) <{map = #map2}> : (index) -> index
    %13 = "arith.cmpi"(%11, %12) <{predicate = 4 : i64}> : (index, index) -> i1
    %14 = "scf.if"(%13) ({
      %15 = "affine.apply"(%arg1) <{map = #map2}> : (index) -> index
      %16 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %17 = "arith.cmpi"(%16, %arg1) <{predicate = 4 : i64}> : (index, index) -> i1
      %18 = "scf.if"(%17) ({
        %131 = "vector.transfer_read"(%arg0, %15, %arg1, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %132 = "vector.extract"(%131) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %133 = "vector.insert"(%132, %10) <{static_position = array<i64: 2, 0>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%133) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%10) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %19 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %20 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
      %21 = "arith.cmpi"(%19, %20) <{predicate = 4 : i64}> : (index, index) -> i1
      %22 = "scf.if"(%21) ({
        %127 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
        %128 = "vector.transfer_read"(%arg0, %15, %127, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %129 = "vector.extract"(%128) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %130 = "vector.insert"(%129, %18) <{static_position = array<i64: 2, 1>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%130) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%18) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %23 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %24 = "affine.apply"(%arg1) <{map = #map2}> : (index) -> index
      %25 = "arith.cmpi"(%23, %24) <{predicate = 4 : i64}> : (index, index) -> i1
      %26 = "scf.if"(%25) ({
        %123 = "affine.apply"(%arg1) <{map = #map2}> : (index) -> index
        %124 = "vector.transfer_read"(%arg0, %15, %123, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %125 = "vector.extract"(%124) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %126 = "vector.insert"(%125, %22) <{static_position = array<i64: 2, 2>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%126) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%22) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %27 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %28 = "affine.apply"(%arg1) <{map = #map3}> : (index) -> index
      %29 = "arith.cmpi"(%27, %28) <{predicate = 4 : i64}> : (index, index) -> i1
      %30 = "scf.if"(%29) ({
        %119 = "affine.apply"(%arg1) <{map = #map3}> : (index) -> index
        %120 = "vector.transfer_read"(%arg0, %15, %119, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %121 = "vector.extract"(%120) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %122 = "vector.insert"(%121, %26) <{static_position = array<i64: 2, 3>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%122) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%26) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %31 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %32 = "affine.apply"(%arg1) <{map = #map4}> : (index) -> index
      %33 = "arith.cmpi"(%31, %32) <{predicate = 4 : i64}> : (index, index) -> i1
      %34 = "scf.if"(%33) ({
        %115 = "affine.apply"(%arg1) <{map = #map4}> : (index) -> index
        %116 = "vector.transfer_read"(%arg0, %15, %115, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %117 = "vector.extract"(%116) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %118 = "vector.insert"(%117, %30) <{static_position = array<i64: 2, 4>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%118) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%30) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %35 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %36 = "affine.apply"(%arg1) <{map = #map5}> : (index) -> index
      %37 = "arith.cmpi"(%35, %36) <{predicate = 4 : i64}> : (index, index) -> i1
      %38 = "scf.if"(%37) ({
        %111 = "affine.apply"(%arg1) <{map = #map5}> : (index) -> index
        %112 = "vector.transfer_read"(%arg0, %15, %111, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %113 = "vector.extract"(%112) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %114 = "vector.insert"(%113, %34) <{static_position = array<i64: 2, 5>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%114) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%34) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %39 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %40 = "affine.apply"(%arg1) <{map = #map6}> : (index) -> index
      %41 = "arith.cmpi"(%39, %40) <{predicate = 4 : i64}> : (index, index) -> i1
      %42 = "scf.if"(%41) ({
        %107 = "affine.apply"(%arg1) <{map = #map6}> : (index) -> index
        %108 = "vector.transfer_read"(%arg0, %15, %107, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %109 = "vector.extract"(%108) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %110 = "vector.insert"(%109, %38) <{static_position = array<i64: 2, 6>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%110) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%38) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %43 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %44 = "affine.apply"(%arg1) <{map = #map7}> : (index) -> index
      %45 = "arith.cmpi"(%43, %44) <{predicate = 4 : i64}> : (index, index) -> i1
      %46 = "scf.if"(%45) ({
        %103 = "affine.apply"(%arg1) <{map = #map7}> : (index) -> index
        %104 = "vector.transfer_read"(%arg0, %15, %103, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %105 = "vector.extract"(%104) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %106 = "vector.insert"(%105, %42) <{static_position = array<i64: 2, 7>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%106) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%42) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %47 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %48 = "affine.apply"(%arg1) <{map = #map8}> : (index) -> index
      %49 = "arith.cmpi"(%47, %48) <{predicate = 4 : i64}> : (index, index) -> i1
      %50 = "scf.if"(%49) ({
        %99 = "affine.apply"(%arg1) <{map = #map8}> : (index) -> index
        %100 = "vector.transfer_read"(%arg0, %15, %99, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %101 = "vector.extract"(%100) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %102 = "vector.insert"(%101, %46) <{static_position = array<i64: 2, 8>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%102) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%46) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %51 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %52 = "affine.apply"(%arg1) <{map = #map9}> : (index) -> index
      %53 = "arith.cmpi"(%51, %52) <{predicate = 4 : i64}> : (index, index) -> i1
      %54 = "scf.if"(%53) ({
        %95 = "affine.apply"(%arg1) <{map = #map9}> : (index) -> index
        %96 = "vector.transfer_read"(%arg0, %15, %95, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %97 = "vector.extract"(%96) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %98 = "vector.insert"(%97, %50) <{static_position = array<i64: 2, 9>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%98) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%50) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %55 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %56 = "affine.apply"(%arg1) <{map = #map10}> : (index) -> index
      %57 = "arith.cmpi"(%55, %56) <{predicate = 4 : i64}> : (index, index) -> i1
      %58 = "scf.if"(%57) ({
        %91 = "affine.apply"(%arg1) <{map = #map10}> : (index) -> index
        %92 = "vector.transfer_read"(%arg0, %15, %91, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %93 = "vector.extract"(%92) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %94 = "vector.insert"(%93, %54) <{static_position = array<i64: 2, 10>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%94) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%54) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %59 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %60 = "affine.apply"(%arg1) <{map = #map11}> : (index) -> index
      %61 = "arith.cmpi"(%59, %60) <{predicate = 4 : i64}> : (index, index) -> i1
      %62 = "scf.if"(%61) ({
        %87 = "affine.apply"(%arg1) <{map = #map11}> : (index) -> index
        %88 = "vector.transfer_read"(%arg0, %15, %87, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %89 = "vector.extract"(%88) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %90 = "vector.insert"(%89, %58) <{static_position = array<i64: 2, 11>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%90) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%58) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %63 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %64 = "affine.apply"(%arg1) <{map = #map12}> : (index) -> index
      %65 = "arith.cmpi"(%63, %64) <{predicate = 4 : i64}> : (index, index) -> i1
      %66 = "scf.if"(%65) ({
        %83 = "affine.apply"(%arg1) <{map = #map12}> : (index) -> index
        %84 = "vector.transfer_read"(%arg0, %15, %83, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %85 = "vector.extract"(%84) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %86 = "vector.insert"(%85, %62) <{static_position = array<i64: 2, 12>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%86) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%62) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %67 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %68 = "affine.apply"(%arg1) <{map = #map13}> : (index) -> index
      %69 = "arith.cmpi"(%67, %68) <{predicate = 4 : i64}> : (index, index) -> i1
      %70 = "scf.if"(%69) ({
        %79 = "affine.apply"(%arg1) <{map = #map13}> : (index) -> index
        %80 = "vector.transfer_read"(%arg0, %15, %79, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %81 = "vector.extract"(%80) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %82 = "vector.insert"(%81, %66) <{static_position = array<i64: 2, 13>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%82) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%66) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      %71 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %72 = "affine.apply"(%arg1) <{map = #map14}> : (index) -> index
      %73 = "arith.cmpi"(%71, %72) <{predicate = 4 : i64}> : (index, index) -> i1
      %74 = "scf.if"(%73) ({
        %75 = "affine.apply"(%arg1) <{map = #map14}> : (index) -> index
        %76 = "vector.transfer_read"(%arg0, %15, %75, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<f32>
        %77 = "vector.extract"(%76) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %78 = "vector.insert"(%77, %70) <{static_position = array<i64: 2, 14>}> : (f32, vector<3x15xf32>) -> vector<3x15xf32>
        "scf.yield"(%78) : (vector<3x15xf32>) -> ()
      }, {
        "scf.yield"(%70) : (vector<3x15xf32>) -> ()
      }) : (i1) -> vector<3x15xf32>
      "scf.yield"(%74) : (vector<3x15xf32>) -> ()
    }, {
      "scf.yield"(%10) : (vector<3x15xf32>) -> ()
    }) : (i1) -> vector<3x15xf32>
    "func.return"(%14) : (vector<3x15xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> ()>
#map1 = affine_map<()[s0] -> (s0 + 1)>
#map2 = affine_map<()[s0] -> (s0 + 2)>
#map3 = affine_map<()[s0] -> (s0 + 3)>
#map4 = affine_map<()[s0] -> (s0 + 4)>
#map5 = affine_map<()[s0] -> (s0 + 5)>
#map6 = affine_map<()[s0] -> (s0 + 6)>
#map7 = affine_map<()[s0] -> (s0 + 7)>
#map8 = affine_map<()[s0] -> (s0 + 8)>
#map9 = affine_map<()[s0] -> (s0 + 9)>
#map10 = affine_map<()[s0] -> (s0 + 10)>
#map11 = affine_map<()[s0] -> (s0 + 11)>
#map12 = affine_map<()[s0] -> (s0 + 12)>
#map13 = affine_map<()[s0] -> (s0 + 13)>
#map14 = affine_map<()[s0] -> (s0 + 14)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, index, vector<3x15xf32>) -> (), sym_name = "transfer_write_progressive"}> ({
  ^bb0(%arg0: memref<?x?xf32>, %arg1: index, %arg2: vector<3x15xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "memref.dim"(%arg0, %1) : (memref<?x?xf32>, index) -> index
    %3 = "arith.cmpi"(%2, %arg1) <{predicate = 4 : i64}> : (index, index) -> i1
    "scf.if"(%3) ({
      %188 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %189 = "arith.cmpi"(%188, %arg1) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%189) ({
        %274 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 0>}> : (vector<3x15xf32>) -> f32
        %275 = "vector.broadcast"(%274) : (f32) -> vector<f32>
        "vector.transfer_write"(%275, %arg0, %arg1, %arg1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %190 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %191 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
      %192 = "arith.cmpi"(%190, %191) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%192) ({
        %271 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
        %272 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 1>}> : (vector<3x15xf32>) -> f32
        %273 = "vector.broadcast"(%272) : (f32) -> vector<f32>
        "vector.transfer_write"(%273, %arg0, %arg1, %271) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %193 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %194 = "affine.apply"(%arg1) <{map = #map2}> : (index) -> index
      %195 = "arith.cmpi"(%193, %194) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%195) ({
        %268 = "affine.apply"(%arg1) <{map = #map2}> : (index) -> index
        %269 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 2>}> : (vector<3x15xf32>) -> f32
        %270 = "vector.broadcast"(%269) : (f32) -> vector<f32>
        "vector.transfer_write"(%270, %arg0, %arg1, %268) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %196 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %197 = "affine.apply"(%arg1) <{map = #map3}> : (index) -> index
      %198 = "arith.cmpi"(%196, %197) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%198) ({
        %265 = "affine.apply"(%arg1) <{map = #map3}> : (index) -> index
        %266 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 3>}> : (vector<3x15xf32>) -> f32
        %267 = "vector.broadcast"(%266) : (f32) -> vector<f32>
        "vector.transfer_write"(%267, %arg0, %arg1, %265) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %199 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %200 = "affine.apply"(%arg1) <{map = #map4}> : (index) -> index
      %201 = "arith.cmpi"(%199, %200) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%201) ({
        %262 = "affine.apply"(%arg1) <{map = #map4}> : (index) -> index
        %263 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 4>}> : (vector<3x15xf32>) -> f32
        %264 = "vector.broadcast"(%263) : (f32) -> vector<f32>
        "vector.transfer_write"(%264, %arg0, %arg1, %262) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %202 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %203 = "affine.apply"(%arg1) <{map = #map5}> : (index) -> index
      %204 = "arith.cmpi"(%202, %203) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%204) ({
        %259 = "affine.apply"(%arg1) <{map = #map5}> : (index) -> index
        %260 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 5>}> : (vector<3x15xf32>) -> f32
        %261 = "vector.broadcast"(%260) : (f32) -> vector<f32>
        "vector.transfer_write"(%261, %arg0, %arg1, %259) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %205 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %206 = "affine.apply"(%arg1) <{map = #map6}> : (index) -> index
      %207 = "arith.cmpi"(%205, %206) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%207) ({
        %256 = "affine.apply"(%arg1) <{map = #map6}> : (index) -> index
        %257 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 6>}> : (vector<3x15xf32>) -> f32
        %258 = "vector.broadcast"(%257) : (f32) -> vector<f32>
        "vector.transfer_write"(%258, %arg0, %arg1, %256) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %208 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %209 = "affine.apply"(%arg1) <{map = #map7}> : (index) -> index
      %210 = "arith.cmpi"(%208, %209) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%210) ({
        %253 = "affine.apply"(%arg1) <{map = #map7}> : (index) -> index
        %254 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 7>}> : (vector<3x15xf32>) -> f32
        %255 = "vector.broadcast"(%254) : (f32) -> vector<f32>
        "vector.transfer_write"(%255, %arg0, %arg1, %253) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %211 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %212 = "affine.apply"(%arg1) <{map = #map8}> : (index) -> index
      %213 = "arith.cmpi"(%211, %212) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%213) ({
        %250 = "affine.apply"(%arg1) <{map = #map8}> : (index) -> index
        %251 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 8>}> : (vector<3x15xf32>) -> f32
        %252 = "vector.broadcast"(%251) : (f32) -> vector<f32>
        "vector.transfer_write"(%252, %arg0, %arg1, %250) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %214 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %215 = "affine.apply"(%arg1) <{map = #map9}> : (index) -> index
      %216 = "arith.cmpi"(%214, %215) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%216) ({
        %247 = "affine.apply"(%arg1) <{map = #map9}> : (index) -> index
        %248 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 9>}> : (vector<3x15xf32>) -> f32
        %249 = "vector.broadcast"(%248) : (f32) -> vector<f32>
        "vector.transfer_write"(%249, %arg0, %arg1, %247) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %217 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %218 = "affine.apply"(%arg1) <{map = #map10}> : (index) -> index
      %219 = "arith.cmpi"(%217, %218) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%219) ({
        %244 = "affine.apply"(%arg1) <{map = #map10}> : (index) -> index
        %245 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 10>}> : (vector<3x15xf32>) -> f32
        %246 = "vector.broadcast"(%245) : (f32) -> vector<f32>
        "vector.transfer_write"(%246, %arg0, %arg1, %244) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %220 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %221 = "affine.apply"(%arg1) <{map = #map11}> : (index) -> index
      %222 = "arith.cmpi"(%220, %221) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%222) ({
        %241 = "affine.apply"(%arg1) <{map = #map11}> : (index) -> index
        %242 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 11>}> : (vector<3x15xf32>) -> f32
        %243 = "vector.broadcast"(%242) : (f32) -> vector<f32>
        "vector.transfer_write"(%243, %arg0, %arg1, %241) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %223 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %224 = "affine.apply"(%arg1) <{map = #map12}> : (index) -> index
      %225 = "arith.cmpi"(%223, %224) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%225) ({
        %238 = "affine.apply"(%arg1) <{map = #map12}> : (index) -> index
        %239 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 12>}> : (vector<3x15xf32>) -> f32
        %240 = "vector.broadcast"(%239) : (f32) -> vector<f32>
        "vector.transfer_write"(%240, %arg0, %arg1, %238) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %226 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %227 = "affine.apply"(%arg1) <{map = #map13}> : (index) -> index
      %228 = "arith.cmpi"(%226, %227) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%228) ({
        %235 = "affine.apply"(%arg1) <{map = #map13}> : (index) -> index
        %236 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 13>}> : (vector<3x15xf32>) -> f32
        %237 = "vector.broadcast"(%236) : (f32) -> vector<f32>
        "vector.transfer_write"(%237, %arg0, %arg1, %235) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %229 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %230 = "affine.apply"(%arg1) <{map = #map14}> : (index) -> index
      %231 = "arith.cmpi"(%229, %230) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%231) ({
        %232 = "affine.apply"(%arg1) <{map = #map14}> : (index) -> index
        %233 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 14>}> : (vector<3x15xf32>) -> f32
        %234 = "vector.broadcast"(%233) : (f32) -> vector<f32>
        "vector.transfer_write"(%234, %arg0, %arg1, %232) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }, {
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    %4 = "memref.dim"(%arg0, %1) : (memref<?x?xf32>, index) -> index
    %5 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
    %6 = "arith.cmpi"(%4, %5) <{predicate = 4 : i64}> : (index, index) -> i1
    "scf.if"(%6) ({
      %99 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
      %100 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %101 = "arith.cmpi"(%100, %arg1) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%101) ({
        %186 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 0>}> : (vector<3x15xf32>) -> f32
        %187 = "vector.broadcast"(%186) : (f32) -> vector<f32>
        "vector.transfer_write"(%187, %arg0, %99, %arg1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %102 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %103 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
      %104 = "arith.cmpi"(%102, %103) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%104) ({
        %183 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
        %184 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 1>}> : (vector<3x15xf32>) -> f32
        %185 = "vector.broadcast"(%184) : (f32) -> vector<f32>
        "vector.transfer_write"(%185, %arg0, %99, %183) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %105 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %106 = "affine.apply"(%arg1) <{map = #map2}> : (index) -> index
      %107 = "arith.cmpi"(%105, %106) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%107) ({
        %180 = "affine.apply"(%arg1) <{map = #map2}> : (index) -> index
        %181 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 2>}> : (vector<3x15xf32>) -> f32
        %182 = "vector.broadcast"(%181) : (f32) -> vector<f32>
        "vector.transfer_write"(%182, %arg0, %99, %180) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %108 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %109 = "affine.apply"(%arg1) <{map = #map3}> : (index) -> index
      %110 = "arith.cmpi"(%108, %109) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%110) ({
        %177 = "affine.apply"(%arg1) <{map = #map3}> : (index) -> index
        %178 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 3>}> : (vector<3x15xf32>) -> f32
        %179 = "vector.broadcast"(%178) : (f32) -> vector<f32>
        "vector.transfer_write"(%179, %arg0, %99, %177) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %111 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %112 = "affine.apply"(%arg1) <{map = #map4}> : (index) -> index
      %113 = "arith.cmpi"(%111, %112) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%113) ({
        %174 = "affine.apply"(%arg1) <{map = #map4}> : (index) -> index
        %175 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 4>}> : (vector<3x15xf32>) -> f32
        %176 = "vector.broadcast"(%175) : (f32) -> vector<f32>
        "vector.transfer_write"(%176, %arg0, %99, %174) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %114 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %115 = "affine.apply"(%arg1) <{map = #map5}> : (index) -> index
      %116 = "arith.cmpi"(%114, %115) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%116) ({
        %171 = "affine.apply"(%arg1) <{map = #map5}> : (index) -> index
        %172 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 5>}> : (vector<3x15xf32>) -> f32
        %173 = "vector.broadcast"(%172) : (f32) -> vector<f32>
        "vector.transfer_write"(%173, %arg0, %99, %171) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %117 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %118 = "affine.apply"(%arg1) <{map = #map6}> : (index) -> index
      %119 = "arith.cmpi"(%117, %118) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%119) ({
        %168 = "affine.apply"(%arg1) <{map = #map6}> : (index) -> index
        %169 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 6>}> : (vector<3x15xf32>) -> f32
        %170 = "vector.broadcast"(%169) : (f32) -> vector<f32>
        "vector.transfer_write"(%170, %arg0, %99, %168) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %120 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %121 = "affine.apply"(%arg1) <{map = #map7}> : (index) -> index
      %122 = "arith.cmpi"(%120, %121) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%122) ({
        %165 = "affine.apply"(%arg1) <{map = #map7}> : (index) -> index
        %166 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 7>}> : (vector<3x15xf32>) -> f32
        %167 = "vector.broadcast"(%166) : (f32) -> vector<f32>
        "vector.transfer_write"(%167, %arg0, %99, %165) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %123 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %124 = "affine.apply"(%arg1) <{map = #map8}> : (index) -> index
      %125 = "arith.cmpi"(%123, %124) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%125) ({
        %162 = "affine.apply"(%arg1) <{map = #map8}> : (index) -> index
        %163 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 8>}> : (vector<3x15xf32>) -> f32
        %164 = "vector.broadcast"(%163) : (f32) -> vector<f32>
        "vector.transfer_write"(%164, %arg0, %99, %162) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %126 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %127 = "affine.apply"(%arg1) <{map = #map9}> : (index) -> index
      %128 = "arith.cmpi"(%126, %127) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%128) ({
        %159 = "affine.apply"(%arg1) <{map = #map9}> : (index) -> index
        %160 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 9>}> : (vector<3x15xf32>) -> f32
        %161 = "vector.broadcast"(%160) : (f32) -> vector<f32>
        "vector.transfer_write"(%161, %arg0, %99, %159) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %129 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %130 = "affine.apply"(%arg1) <{map = #map10}> : (index) -> index
      %131 = "arith.cmpi"(%129, %130) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%131) ({
        %156 = "affine.apply"(%arg1) <{map = #map10}> : (index) -> index
        %157 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 10>}> : (vector<3x15xf32>) -> f32
        %158 = "vector.broadcast"(%157) : (f32) -> vector<f32>
        "vector.transfer_write"(%158, %arg0, %99, %156) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %132 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %133 = "affine.apply"(%arg1) <{map = #map11}> : (index) -> index
      %134 = "arith.cmpi"(%132, %133) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%134) ({
        %153 = "affine.apply"(%arg1) <{map = #map11}> : (index) -> index
        %154 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 11>}> : (vector<3x15xf32>) -> f32
        %155 = "vector.broadcast"(%154) : (f32) -> vector<f32>
        "vector.transfer_write"(%155, %arg0, %99, %153) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %135 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %136 = "affine.apply"(%arg1) <{map = #map12}> : (index) -> index
      %137 = "arith.cmpi"(%135, %136) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%137) ({
        %150 = "affine.apply"(%arg1) <{map = #map12}> : (index) -> index
        %151 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 12>}> : (vector<3x15xf32>) -> f32
        %152 = "vector.broadcast"(%151) : (f32) -> vector<f32>
        "vector.transfer_write"(%152, %arg0, %99, %150) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %138 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %139 = "affine.apply"(%arg1) <{map = #map13}> : (index) -> index
      %140 = "arith.cmpi"(%138, %139) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%140) ({
        %147 = "affine.apply"(%arg1) <{map = #map13}> : (index) -> index
        %148 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 13>}> : (vector<3x15xf32>) -> f32
        %149 = "vector.broadcast"(%148) : (f32) -> vector<f32>
        "vector.transfer_write"(%149, %arg0, %99, %147) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %141 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %142 = "affine.apply"(%arg1) <{map = #map14}> : (index) -> index
      %143 = "arith.cmpi"(%141, %142) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%143) ({
        %144 = "affine.apply"(%arg1) <{map = #map14}> : (index) -> index
        %145 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 14>}> : (vector<3x15xf32>) -> f32
        %146 = "vector.broadcast"(%145) : (f32) -> vector<f32>
        "vector.transfer_write"(%146, %arg0, %99, %144) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }, {
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    %7 = "memref.dim"(%arg0, %1) : (memref<?x?xf32>, index) -> index
    %8 = "affine.apply"(%arg1) <{map = #map2}> : (index) -> index
    %9 = "arith.cmpi"(%7, %8) <{predicate = 4 : i64}> : (index, index) -> i1
    "scf.if"(%9) ({
      %10 = "affine.apply"(%arg1) <{map = #map2}> : (index) -> index
      %11 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %12 = "arith.cmpi"(%11, %arg1) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%12) ({
        %97 = "vector.extract"(%arg2) <{static_position = array<i64: 2, 0>}> : (vector<3x15xf32>) -> f32
        %98 = "vector.broadcast"(%97) : (f32) -> vector<f32>
        "vector.transfer_write"(%98, %arg0, %10, %arg1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %13 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %14 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
      %15 = "arith.cmpi"(%13, %14) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%15) ({
        %94 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
        %95 = "vector.extract"(%arg2) <{static_position = array<i64: 2, 1>}> : (vector<3x15xf32>) -> f32
        %96 = "vector.broadcast"(%95) : (f32) -> vector<f32>
        "vector.transfer_write"(%96, %arg0, %10, %94) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %16 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %17 = "affine.apply"(%arg1) <{map = #map2}> : (index) -> index
      %18 = "arith.cmpi"(%16, %17) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%18) ({
        %91 = "affine.apply"(%arg1) <{map = #map2}> : (index) -> index
        %92 = "vector.extract"(%arg2) <{static_position = array<i64: 2, 2>}> : (vector<3x15xf32>) -> f32
        %93 = "vector.broadcast"(%92) : (f32) -> vector<f32>
        "vector.transfer_write"(%93, %arg0, %10, %91) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %19 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %20 = "affine.apply"(%arg1) <{map = #map3}> : (index) -> index
      %21 = "arith.cmpi"(%19, %20) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%21) ({
        %88 = "affine.apply"(%arg1) <{map = #map3}> : (index) -> index
        %89 = "vector.extract"(%arg2) <{static_position = array<i64: 2, 3>}> : (vector<3x15xf32>) -> f32
        %90 = "vector.broadcast"(%89) : (f32) -> vector<f32>
        "vector.transfer_write"(%90, %arg0, %10, %88) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %22 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %23 = "affine.apply"(%arg1) <{map = #map4}> : (index) -> index
      %24 = "arith.cmpi"(%22, %23) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%24) ({
        %85 = "affine.apply"(%arg1) <{map = #map4}> : (index) -> index
        %86 = "vector.extract"(%arg2) <{static_position = array<i64: 2, 4>}> : (vector<3x15xf32>) -> f32
        %87 = "vector.broadcast"(%86) : (f32) -> vector<f32>
        "vector.transfer_write"(%87, %arg0, %10, %85) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %25 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %26 = "affine.apply"(%arg1) <{map = #map5}> : (index) -> index
      %27 = "arith.cmpi"(%25, %26) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%27) ({
        %82 = "affine.apply"(%arg1) <{map = #map5}> : (index) -> index
        %83 = "vector.extract"(%arg2) <{static_position = array<i64: 2, 5>}> : (vector<3x15xf32>) -> f32
        %84 = "vector.broadcast"(%83) : (f32) -> vector<f32>
        "vector.transfer_write"(%84, %arg0, %10, %82) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %28 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %29 = "affine.apply"(%arg1) <{map = #map6}> : (index) -> index
      %30 = "arith.cmpi"(%28, %29) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%30) ({
        %79 = "affine.apply"(%arg1) <{map = #map6}> : (index) -> index
        %80 = "vector.extract"(%arg2) <{static_position = array<i64: 2, 6>}> : (vector<3x15xf32>) -> f32
        %81 = "vector.broadcast"(%80) : (f32) -> vector<f32>
        "vector.transfer_write"(%81, %arg0, %10, %79) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %31 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %32 = "affine.apply"(%arg1) <{map = #map7}> : (index) -> index
      %33 = "arith.cmpi"(%31, %32) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%33) ({
        %76 = "affine.apply"(%arg1) <{map = #map7}> : (index) -> index
        %77 = "vector.extract"(%arg2) <{static_position = array<i64: 2, 7>}> : (vector<3x15xf32>) -> f32
        %78 = "vector.broadcast"(%77) : (f32) -> vector<f32>
        "vector.transfer_write"(%78, %arg0, %10, %76) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %34 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %35 = "affine.apply"(%arg1) <{map = #map8}> : (index) -> index
      %36 = "arith.cmpi"(%34, %35) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%36) ({
        %73 = "affine.apply"(%arg1) <{map = #map8}> : (index) -> index
        %74 = "vector.extract"(%arg2) <{static_position = array<i64: 2, 8>}> : (vector<3x15xf32>) -> f32
        %75 = "vector.broadcast"(%74) : (f32) -> vector<f32>
        "vector.transfer_write"(%75, %arg0, %10, %73) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %37 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %38 = "affine.apply"(%arg1) <{map = #map9}> : (index) -> index
      %39 = "arith.cmpi"(%37, %38) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%39) ({
        %70 = "affine.apply"(%arg1) <{map = #map9}> : (index) -> index
        %71 = "vector.extract"(%arg2) <{static_position = array<i64: 2, 9>}> : (vector<3x15xf32>) -> f32
        %72 = "vector.broadcast"(%71) : (f32) -> vector<f32>
        "vector.transfer_write"(%72, %arg0, %10, %70) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %40 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %41 = "affine.apply"(%arg1) <{map = #map10}> : (index) -> index
      %42 = "arith.cmpi"(%40, %41) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%42) ({
        %67 = "affine.apply"(%arg1) <{map = #map10}> : (index) -> index
        %68 = "vector.extract"(%arg2) <{static_position = array<i64: 2, 10>}> : (vector<3x15xf32>) -> f32
        %69 = "vector.broadcast"(%68) : (f32) -> vector<f32>
        "vector.transfer_write"(%69, %arg0, %10, %67) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %43 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %44 = "affine.apply"(%arg1) <{map = #map11}> : (index) -> index
      %45 = "arith.cmpi"(%43, %44) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%45) ({
        %64 = "affine.apply"(%arg1) <{map = #map11}> : (index) -> index
        %65 = "vector.extract"(%arg2) <{static_position = array<i64: 2, 11>}> : (vector<3x15xf32>) -> f32
        %66 = "vector.broadcast"(%65) : (f32) -> vector<f32>
        "vector.transfer_write"(%66, %arg0, %10, %64) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %46 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %47 = "affine.apply"(%arg1) <{map = #map12}> : (index) -> index
      %48 = "arith.cmpi"(%46, %47) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%48) ({
        %61 = "affine.apply"(%arg1) <{map = #map12}> : (index) -> index
        %62 = "vector.extract"(%arg2) <{static_position = array<i64: 2, 12>}> : (vector<3x15xf32>) -> f32
        %63 = "vector.broadcast"(%62) : (f32) -> vector<f32>
        "vector.transfer_write"(%63, %arg0, %10, %61) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %49 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %50 = "affine.apply"(%arg1) <{map = #map13}> : (index) -> index
      %51 = "arith.cmpi"(%49, %50) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%51) ({
        %58 = "affine.apply"(%arg1) <{map = #map13}> : (index) -> index
        %59 = "vector.extract"(%arg2) <{static_position = array<i64: 2, 13>}> : (vector<3x15xf32>) -> f32
        %60 = "vector.broadcast"(%59) : (f32) -> vector<f32>
        "vector.transfer_write"(%60, %arg0, %10, %58) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %52 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
      %53 = "affine.apply"(%arg1) <{map = #map14}> : (index) -> index
      %54 = "arith.cmpi"(%52, %53) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%54) ({
        %55 = "affine.apply"(%arg1) <{map = #map14}> : (index) -> index
        %56 = "vector.extract"(%arg2) <{static_position = array<i64: 2, 14>}> : (vector<3x15xf32>) -> f32
        %57 = "vector.broadcast"(%56) : (f32) -> vector<f32>
        "vector.transfer_write"(%57, %arg0, %10, %55) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }, {
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> ()>
#map1 = affine_map<()[s0] -> (s0 + 1)>
#map2 = affine_map<()[s0] -> (s0 + 2)>
#map3 = affine_map<()[s0] -> (s0 + 3)>
#map4 = affine_map<()[s0] -> (s0 + 4)>
#map5 = affine_map<()[s0] -> (s0 + 5)>
#map6 = affine_map<()[s0] -> (s0 + 6)>
#map7 = affine_map<()[s0] -> (s0 + 7)>
#map8 = affine_map<()[s0] -> (s0 + 8)>
#map9 = affine_map<()[s0] -> (s0 + 9)>
#map10 = affine_map<()[s0] -> (s0 + 10)>
#map11 = affine_map<()[s0] -> (s0 + 11)>
#map12 = affine_map<()[s0] -> (s0 + 12)>
#map13 = affine_map<()[s0] -> (s0 + 13)>
#map14 = affine_map<()[s0] -> (s0 + 14)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, index, vector<3x15xf32>) -> (), sym_name = "transfer_write_progressive_inbounds"}> ({
  ^bb0(%arg0: memref<?x?xf32>, %arg1: index, %arg2: vector<3x15xf32>):
    %0 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 0>}> : (vector<3x15xf32>) -> f32
    %1 = "vector.broadcast"(%0) : (f32) -> vector<f32>
    "vector.transfer_write"(%1, %arg0, %arg1, %arg1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %2 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
    %3 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 1>}> : (vector<3x15xf32>) -> f32
    %4 = "vector.broadcast"(%3) : (f32) -> vector<f32>
    "vector.transfer_write"(%4, %arg0, %arg1, %2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %5 = "affine.apply"(%arg1) <{map = #map2}> : (index) -> index
    %6 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 2>}> : (vector<3x15xf32>) -> f32
    %7 = "vector.broadcast"(%6) : (f32) -> vector<f32>
    "vector.transfer_write"(%7, %arg0, %arg1, %5) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %8 = "affine.apply"(%arg1) <{map = #map3}> : (index) -> index
    %9 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 3>}> : (vector<3x15xf32>) -> f32
    %10 = "vector.broadcast"(%9) : (f32) -> vector<f32>
    "vector.transfer_write"(%10, %arg0, %arg1, %8) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %11 = "affine.apply"(%arg1) <{map = #map4}> : (index) -> index
    %12 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 4>}> : (vector<3x15xf32>) -> f32
    %13 = "vector.broadcast"(%12) : (f32) -> vector<f32>
    "vector.transfer_write"(%13, %arg0, %arg1, %11) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %14 = "affine.apply"(%arg1) <{map = #map5}> : (index) -> index
    %15 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 5>}> : (vector<3x15xf32>) -> f32
    %16 = "vector.broadcast"(%15) : (f32) -> vector<f32>
    "vector.transfer_write"(%16, %arg0, %arg1, %14) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %17 = "affine.apply"(%arg1) <{map = #map6}> : (index) -> index
    %18 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 6>}> : (vector<3x15xf32>) -> f32
    %19 = "vector.broadcast"(%18) : (f32) -> vector<f32>
    "vector.transfer_write"(%19, %arg0, %arg1, %17) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %20 = "affine.apply"(%arg1) <{map = #map7}> : (index) -> index
    %21 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 7>}> : (vector<3x15xf32>) -> f32
    %22 = "vector.broadcast"(%21) : (f32) -> vector<f32>
    "vector.transfer_write"(%22, %arg0, %arg1, %20) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %23 = "affine.apply"(%arg1) <{map = #map8}> : (index) -> index
    %24 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 8>}> : (vector<3x15xf32>) -> f32
    %25 = "vector.broadcast"(%24) : (f32) -> vector<f32>
    "vector.transfer_write"(%25, %arg0, %arg1, %23) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %26 = "affine.apply"(%arg1) <{map = #map9}> : (index) -> index
    %27 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 9>}> : (vector<3x15xf32>) -> f32
    %28 = "vector.broadcast"(%27) : (f32) -> vector<f32>
    "vector.transfer_write"(%28, %arg0, %arg1, %26) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %29 = "affine.apply"(%arg1) <{map = #map10}> : (index) -> index
    %30 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 10>}> : (vector<3x15xf32>) -> f32
    %31 = "vector.broadcast"(%30) : (f32) -> vector<f32>
    "vector.transfer_write"(%31, %arg0, %arg1, %29) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %32 = "affine.apply"(%arg1) <{map = #map11}> : (index) -> index
    %33 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 11>}> : (vector<3x15xf32>) -> f32
    %34 = "vector.broadcast"(%33) : (f32) -> vector<f32>
    "vector.transfer_write"(%34, %arg0, %arg1, %32) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %35 = "affine.apply"(%arg1) <{map = #map12}> : (index) -> index
    %36 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 12>}> : (vector<3x15xf32>) -> f32
    %37 = "vector.broadcast"(%36) : (f32) -> vector<f32>
    "vector.transfer_write"(%37, %arg0, %arg1, %35) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %38 = "affine.apply"(%arg1) <{map = #map13}> : (index) -> index
    %39 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 13>}> : (vector<3x15xf32>) -> f32
    %40 = "vector.broadcast"(%39) : (f32) -> vector<f32>
    "vector.transfer_write"(%40, %arg0, %arg1, %38) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %41 = "affine.apply"(%arg1) <{map = #map14}> : (index) -> index
    %42 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 14>}> : (vector<3x15xf32>) -> f32
    %43 = "vector.broadcast"(%42) : (f32) -> vector<f32>
    "vector.transfer_write"(%43, %arg0, %arg1, %41) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %44 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
    %45 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 0>}> : (vector<3x15xf32>) -> f32
    %46 = "vector.broadcast"(%45) : (f32) -> vector<f32>
    "vector.transfer_write"(%46, %arg0, %44, %arg1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %47 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
    %48 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 1>}> : (vector<3x15xf32>) -> f32
    %49 = "vector.broadcast"(%48) : (f32) -> vector<f32>
    "vector.transfer_write"(%49, %arg0, %44, %47) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %50 = "affine.apply"(%arg1) <{map = #map2}> : (index) -> index
    %51 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 2>}> : (vector<3x15xf32>) -> f32
    %52 = "vector.broadcast"(%51) : (f32) -> vector<f32>
    "vector.transfer_write"(%52, %arg0, %44, %50) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %53 = "affine.apply"(%arg1) <{map = #map3}> : (index) -> index
    %54 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 3>}> : (vector<3x15xf32>) -> f32
    %55 = "vector.broadcast"(%54) : (f32) -> vector<f32>
    "vector.transfer_write"(%55, %arg0, %44, %53) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %56 = "affine.apply"(%arg1) <{map = #map4}> : (index) -> index
    %57 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 4>}> : (vector<3x15xf32>) -> f32
    %58 = "vector.broadcast"(%57) : (f32) -> vector<f32>
    "vector.transfer_write"(%58, %arg0, %44, %56) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %59 = "affine.apply"(%arg1) <{map = #map5}> : (index) -> index
    %60 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 5>}> : (vector<3x15xf32>) -> f32
    %61 = "vector.broadcast"(%60) : (f32) -> vector<f32>
    "vector.transfer_write"(%61, %arg0, %44, %59) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %62 = "affine.apply"(%arg1) <{map = #map6}> : (index) -> index
    %63 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 6>}> : (vector<3x15xf32>) -> f32
    %64 = "vector.broadcast"(%63) : (f32) -> vector<f32>
    "vector.transfer_write"(%64, %arg0, %44, %62) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %65 = "affine.apply"(%arg1) <{map = #map7}> : (index) -> index
    %66 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 7>}> : (vector<3x15xf32>) -> f32
    %67 = "vector.broadcast"(%66) : (f32) -> vector<f32>
    "vector.transfer_write"(%67, %arg0, %44, %65) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %68 = "affine.apply"(%arg1) <{map = #map8}> : (index) -> index
    %69 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 8>}> : (vector<3x15xf32>) -> f32
    %70 = "vector.broadcast"(%69) : (f32) -> vector<f32>
    "vector.transfer_write"(%70, %arg0, %44, %68) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %71 = "affine.apply"(%arg1) <{map = #map9}> : (index) -> index
    %72 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 9>}> : (vector<3x15xf32>) -> f32
    %73 = "vector.broadcast"(%72) : (f32) -> vector<f32>
    "vector.transfer_write"(%73, %arg0, %44, %71) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %74 = "affine.apply"(%arg1) <{map = #map10}> : (index) -> index
    %75 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 10>}> : (vector<3x15xf32>) -> f32
    %76 = "vector.broadcast"(%75) : (f32) -> vector<f32>
    "vector.transfer_write"(%76, %arg0, %44, %74) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %77 = "affine.apply"(%arg1) <{map = #map11}> : (index) -> index
    %78 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 11>}> : (vector<3x15xf32>) -> f32
    %79 = "vector.broadcast"(%78) : (f32) -> vector<f32>
    "vector.transfer_write"(%79, %arg0, %44, %77) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %80 = "affine.apply"(%arg1) <{map = #map12}> : (index) -> index
    %81 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 12>}> : (vector<3x15xf32>) -> f32
    %82 = "vector.broadcast"(%81) : (f32) -> vector<f32>
    "vector.transfer_write"(%82, %arg0, %44, %80) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %83 = "affine.apply"(%arg1) <{map = #map13}> : (index) -> index
    %84 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 13>}> : (vector<3x15xf32>) -> f32
    %85 = "vector.broadcast"(%84) : (f32) -> vector<f32>
    "vector.transfer_write"(%85, %arg0, %44, %83) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %86 = "affine.apply"(%arg1) <{map = #map14}> : (index) -> index
    %87 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 14>}> : (vector<3x15xf32>) -> f32
    %88 = "vector.broadcast"(%87) : (f32) -> vector<f32>
    "vector.transfer_write"(%88, %arg0, %44, %86) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %89 = "affine.apply"(%arg1) <{map = #map2}> : (index) -> index
    %90 = "vector.extract"(%arg2) <{static_position = array<i64: 2, 0>}> : (vector<3x15xf32>) -> f32
    %91 = "vector.broadcast"(%90) : (f32) -> vector<f32>
    "vector.transfer_write"(%91, %arg0, %89, %arg1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %92 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
    %93 = "vector.extract"(%arg2) <{static_position = array<i64: 2, 1>}> : (vector<3x15xf32>) -> f32
    %94 = "vector.broadcast"(%93) : (f32) -> vector<f32>
    "vector.transfer_write"(%94, %arg0, %89, %92) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %95 = "affine.apply"(%arg1) <{map = #map2}> : (index) -> index
    %96 = "vector.extract"(%arg2) <{static_position = array<i64: 2, 2>}> : (vector<3x15xf32>) -> f32
    %97 = "vector.broadcast"(%96) : (f32) -> vector<f32>
    "vector.transfer_write"(%97, %arg0, %89, %95) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %98 = "affine.apply"(%arg1) <{map = #map3}> : (index) -> index
    %99 = "vector.extract"(%arg2) <{static_position = array<i64: 2, 3>}> : (vector<3x15xf32>) -> f32
    %100 = "vector.broadcast"(%99) : (f32) -> vector<f32>
    "vector.transfer_write"(%100, %arg0, %89, %98) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %101 = "affine.apply"(%arg1) <{map = #map4}> : (index) -> index
    %102 = "vector.extract"(%arg2) <{static_position = array<i64: 2, 4>}> : (vector<3x15xf32>) -> f32
    %103 = "vector.broadcast"(%102) : (f32) -> vector<f32>
    "vector.transfer_write"(%103, %arg0, %89, %101) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %104 = "affine.apply"(%arg1) <{map = #map5}> : (index) -> index
    %105 = "vector.extract"(%arg2) <{static_position = array<i64: 2, 5>}> : (vector<3x15xf32>) -> f32
    %106 = "vector.broadcast"(%105) : (f32) -> vector<f32>
    "vector.transfer_write"(%106, %arg0, %89, %104) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %107 = "affine.apply"(%arg1) <{map = #map6}> : (index) -> index
    %108 = "vector.extract"(%arg2) <{static_position = array<i64: 2, 6>}> : (vector<3x15xf32>) -> f32
    %109 = "vector.broadcast"(%108) : (f32) -> vector<f32>
    "vector.transfer_write"(%109, %arg0, %89, %107) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %110 = "affine.apply"(%arg1) <{map = #map7}> : (index) -> index
    %111 = "vector.extract"(%arg2) <{static_position = array<i64: 2, 7>}> : (vector<3x15xf32>) -> f32
    %112 = "vector.broadcast"(%111) : (f32) -> vector<f32>
    "vector.transfer_write"(%112, %arg0, %89, %110) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %113 = "affine.apply"(%arg1) <{map = #map8}> : (index) -> index
    %114 = "vector.extract"(%arg2) <{static_position = array<i64: 2, 8>}> : (vector<3x15xf32>) -> f32
    %115 = "vector.broadcast"(%114) : (f32) -> vector<f32>
    "vector.transfer_write"(%115, %arg0, %89, %113) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %116 = "affine.apply"(%arg1) <{map = #map9}> : (index) -> index
    %117 = "vector.extract"(%arg2) <{static_position = array<i64: 2, 9>}> : (vector<3x15xf32>) -> f32
    %118 = "vector.broadcast"(%117) : (f32) -> vector<f32>
    "vector.transfer_write"(%118, %arg0, %89, %116) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %119 = "affine.apply"(%arg1) <{map = #map10}> : (index) -> index
    %120 = "vector.extract"(%arg2) <{static_position = array<i64: 2, 10>}> : (vector<3x15xf32>) -> f32
    %121 = "vector.broadcast"(%120) : (f32) -> vector<f32>
    "vector.transfer_write"(%121, %arg0, %89, %119) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %122 = "affine.apply"(%arg1) <{map = #map11}> : (index) -> index
    %123 = "vector.extract"(%arg2) <{static_position = array<i64: 2, 11>}> : (vector<3x15xf32>) -> f32
    %124 = "vector.broadcast"(%123) : (f32) -> vector<f32>
    "vector.transfer_write"(%124, %arg0, %89, %122) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %125 = "affine.apply"(%arg1) <{map = #map12}> : (index) -> index
    %126 = "vector.extract"(%arg2) <{static_position = array<i64: 2, 12>}> : (vector<3x15xf32>) -> f32
    %127 = "vector.broadcast"(%126) : (f32) -> vector<f32>
    "vector.transfer_write"(%127, %arg0, %89, %125) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %128 = "affine.apply"(%arg1) <{map = #map13}> : (index) -> index
    %129 = "vector.extract"(%arg2) <{static_position = array<i64: 2, 13>}> : (vector<3x15xf32>) -> f32
    %130 = "vector.broadcast"(%129) : (f32) -> vector<f32>
    "vector.transfer_write"(%130, %arg0, %89, %128) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    %131 = "affine.apply"(%arg1) <{map = #map14}> : (index) -> index
    %132 = "vector.extract"(%arg2) <{static_position = array<i64: 2, 14>}> : (vector<3x15xf32>) -> f32
    %133 = "vector.broadcast"(%132) : (f32) -> vector<f32>
    "vector.transfer_write"(%133, %arg0, %89, %131) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<?x?xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> ()>
#map1 = affine_map<(d0, d1, d2, d3) -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x2xf32>) -> vector<2x2xf32>, sym_name = "transfer_read_simple"}> ({
  ^bb0(%arg3: memref<2x2xf32>):
    %115 = "arith.constant"() <{value = 1 : index}> : () -> index
    %116 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %117 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2x2xf32>}> : () -> vector<2x2xf32>
    %118 = "arith.constant"() <{value = 0 : index}> : () -> index
    %119 = "vector.transfer_read"(%arg3, %118, %118, %116) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x2xf32>, index, index, f32) -> vector<f32>
    %120 = "vector.extract"(%119) <{static_position = array<i64>}> : (vector<f32>) -> f32
    %121 = "vector.insert"(%120, %117) <{static_position = array<i64: 0, 0>}> : (f32, vector<2x2xf32>) -> vector<2x2xf32>
    %122 = "vector.transfer_read"(%arg3, %118, %115, %116) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x2xf32>, index, index, f32) -> vector<f32>
    %123 = "vector.extract"(%122) <{static_position = array<i64>}> : (vector<f32>) -> f32
    %124 = "vector.insert"(%123, %121) <{static_position = array<i64: 0, 1>}> : (f32, vector<2x2xf32>) -> vector<2x2xf32>
    %125 = "vector.transfer_read"(%arg3, %115, %118, %116) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x2xf32>, index, index, f32) -> vector<f32>
    %126 = "vector.extract"(%125) <{static_position = array<i64>}> : (vector<f32>) -> f32
    %127 = "vector.insert"(%126, %124) <{static_position = array<i64: 1, 0>}> : (f32, vector<2x2xf32>) -> vector<2x2xf32>
    %128 = "vector.transfer_read"(%arg3, %115, %115, %116) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x2xf32>, index, index, f32) -> vector<f32>
    %129 = "vector.extract"(%128) <{static_position = array<i64>}> : (vector<f32>) -> f32
    %130 = "vector.insert"(%129, %127) <{static_position = array<i64: 1, 1>}> : (f32, vector<2x2xf32>) -> vector<2x2xf32>
    "func.return"(%130) : (vector<2x2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?x?x?xf32>) -> vector<3x3xf32>, sym_name = "transfer_read_minor_identity"}> ({
  ^bb0(%arg2: memref<?x?x?x?xf32>):
    %46 = "arith.constant"() <{value = 3 : index}> : () -> index
    %47 = "arith.constant"() <{value = 1 : index}> : () -> index
    %48 = "arith.constant"() <{value = 0 : index}> : () -> index
    %49 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %50 = "arith.constant"() <{value = dense<0.000000e+00> : vector<3x3xf32>}> : () -> vector<3x3xf32>
    %51 = "arith.constant"() <{value = 2 : index}> : () -> index
    %52 = "memref.dim"(%arg2, %51) : (memref<?x?x?x?xf32>, index) -> index
    %53 = "arith.cmpi"(%52, %48) <{predicate = 4 : i64}> : (index, index) -> i1
    %54 = "scf.if"(%53) ({
      %97 = "memref.dim"(%arg2, %46) : (memref<?x?x?x?xf32>, index) -> index
      %98 = "arith.cmpi"(%97, %48) <{predicate = 4 : i64}> : (index, index) -> i1
      %99 = "scf.if"(%98) ({
        %112 = "vector.transfer_read"(%arg2, %48, %48, %48, %48, %49) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map1}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
        %113 = "vector.extract"(%112) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %114 = "vector.insert"(%113, %50) <{static_position = array<i64: 0, 0>}> : (f32, vector<3x3xf32>) -> vector<3x3xf32>
        "scf.yield"(%114) : (vector<3x3xf32>) -> ()
      }, {
        "scf.yield"(%50) : (vector<3x3xf32>) -> ()
      }) : (i1) -> vector<3x3xf32>
      %100 = "memref.dim"(%arg2, %46) : (memref<?x?x?x?xf32>, index) -> index
      %101 = "arith.cmpi"(%100, %47) <{predicate = 4 : i64}> : (index, index) -> i1
      %102 = "scf.if"(%101) ({
        %109 = "vector.transfer_read"(%arg2, %48, %48, %48, %47, %49) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map1}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
        %110 = "vector.extract"(%109) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %111 = "vector.insert"(%110, %99) <{static_position = array<i64: 0, 1>}> : (f32, vector<3x3xf32>) -> vector<3x3xf32>
        "scf.yield"(%111) : (vector<3x3xf32>) -> ()
      }, {
        "scf.yield"(%99) : (vector<3x3xf32>) -> ()
      }) : (i1) -> vector<3x3xf32>
      %103 = "memref.dim"(%arg2, %46) : (memref<?x?x?x?xf32>, index) -> index
      %104 = "arith.cmpi"(%103, %51) <{predicate = 4 : i64}> : (index, index) -> i1
      %105 = "scf.if"(%104) ({
        %106 = "vector.transfer_read"(%arg2, %48, %48, %48, %51, %49) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map1}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
        %107 = "vector.extract"(%106) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %108 = "vector.insert"(%107, %102) <{static_position = array<i64: 0, 2>}> : (f32, vector<3x3xf32>) -> vector<3x3xf32>
        "scf.yield"(%108) : (vector<3x3xf32>) -> ()
      }, {
        "scf.yield"(%102) : (vector<3x3xf32>) -> ()
      }) : (i1) -> vector<3x3xf32>
      "scf.yield"(%105) : (vector<3x3xf32>) -> ()
    }, {
      "scf.yield"(%50) : (vector<3x3xf32>) -> ()
    }) : (i1) -> vector<3x3xf32>
    %55 = "memref.dim"(%arg2, %51) : (memref<?x?x?x?xf32>, index) -> index
    %56 = "arith.cmpi"(%55, %47) <{predicate = 4 : i64}> : (index, index) -> i1
    %57 = "scf.if"(%56) ({
      %79 = "memref.dim"(%arg2, %46) : (memref<?x?x?x?xf32>, index) -> index
      %80 = "arith.cmpi"(%79, %48) <{predicate = 4 : i64}> : (index, index) -> i1
      %81 = "scf.if"(%80) ({
        %94 = "vector.transfer_read"(%arg2, %48, %48, %47, %48, %49) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map1}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
        %95 = "vector.extract"(%94) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %96 = "vector.insert"(%95, %54) <{static_position = array<i64: 1, 0>}> : (f32, vector<3x3xf32>) -> vector<3x3xf32>
        "scf.yield"(%96) : (vector<3x3xf32>) -> ()
      }, {
        "scf.yield"(%54) : (vector<3x3xf32>) -> ()
      }) : (i1) -> vector<3x3xf32>
      %82 = "memref.dim"(%arg2, %46) : (memref<?x?x?x?xf32>, index) -> index
      %83 = "arith.cmpi"(%82, %47) <{predicate = 4 : i64}> : (index, index) -> i1
      %84 = "scf.if"(%83) ({
        %91 = "vector.transfer_read"(%arg2, %48, %48, %47, %47, %49) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map1}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
        %92 = "vector.extract"(%91) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %93 = "vector.insert"(%92, %81) <{static_position = array<i64: 1, 1>}> : (f32, vector<3x3xf32>) -> vector<3x3xf32>
        "scf.yield"(%93) : (vector<3x3xf32>) -> ()
      }, {
        "scf.yield"(%81) : (vector<3x3xf32>) -> ()
      }) : (i1) -> vector<3x3xf32>
      %85 = "memref.dim"(%arg2, %46) : (memref<?x?x?x?xf32>, index) -> index
      %86 = "arith.cmpi"(%85, %51) <{predicate = 4 : i64}> : (index, index) -> i1
      %87 = "scf.if"(%86) ({
        %88 = "vector.transfer_read"(%arg2, %48, %48, %47, %51, %49) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map1}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
        %89 = "vector.extract"(%88) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %90 = "vector.insert"(%89, %84) <{static_position = array<i64: 1, 2>}> : (f32, vector<3x3xf32>) -> vector<3x3xf32>
        "scf.yield"(%90) : (vector<3x3xf32>) -> ()
      }, {
        "scf.yield"(%84) : (vector<3x3xf32>) -> ()
      }) : (i1) -> vector<3x3xf32>
      "scf.yield"(%87) : (vector<3x3xf32>) -> ()
    }, {
      "scf.yield"(%54) : (vector<3x3xf32>) -> ()
    }) : (i1) -> vector<3x3xf32>
    %58 = "memref.dim"(%arg2, %51) : (memref<?x?x?x?xf32>, index) -> index
    %59 = "arith.cmpi"(%58, %51) <{predicate = 4 : i64}> : (index, index) -> i1
    %60 = "scf.if"(%59) ({
      %61 = "memref.dim"(%arg2, %46) : (memref<?x?x?x?xf32>, index) -> index
      %62 = "arith.cmpi"(%61, %48) <{predicate = 4 : i64}> : (index, index) -> i1
      %63 = "scf.if"(%62) ({
        %76 = "vector.transfer_read"(%arg2, %48, %48, %51, %48, %49) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map1}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
        %77 = "vector.extract"(%76) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %78 = "vector.insert"(%77, %57) <{static_position = array<i64: 2, 0>}> : (f32, vector<3x3xf32>) -> vector<3x3xf32>
        "scf.yield"(%78) : (vector<3x3xf32>) -> ()
      }, {
        "scf.yield"(%57) : (vector<3x3xf32>) -> ()
      }) : (i1) -> vector<3x3xf32>
      %64 = "memref.dim"(%arg2, %46) : (memref<?x?x?x?xf32>, index) -> index
      %65 = "arith.cmpi"(%64, %47) <{predicate = 4 : i64}> : (index, index) -> i1
      %66 = "scf.if"(%65) ({
        %73 = "vector.transfer_read"(%arg2, %48, %48, %51, %47, %49) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map1}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
        %74 = "vector.extract"(%73) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %75 = "vector.insert"(%74, %63) <{static_position = array<i64: 2, 1>}> : (f32, vector<3x3xf32>) -> vector<3x3xf32>
        "scf.yield"(%75) : (vector<3x3xf32>) -> ()
      }, {
        "scf.yield"(%63) : (vector<3x3xf32>) -> ()
      }) : (i1) -> vector<3x3xf32>
      %67 = "memref.dim"(%arg2, %46) : (memref<?x?x?x?xf32>, index) -> index
      %68 = "arith.cmpi"(%67, %51) <{predicate = 4 : i64}> : (index, index) -> i1
      %69 = "scf.if"(%68) ({
        %70 = "vector.transfer_read"(%arg2, %48, %48, %51, %51, %49) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map1}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<f32>
        %71 = "vector.extract"(%70) <{static_position = array<i64>}> : (vector<f32>) -> f32
        %72 = "vector.insert"(%71, %66) <{static_position = array<i64: 2, 2>}> : (f32, vector<3x3xf32>) -> vector<3x3xf32>
        "scf.yield"(%72) : (vector<3x3xf32>) -> ()
      }, {
        "scf.yield"(%66) : (vector<3x3xf32>) -> ()
      }) : (i1) -> vector<3x3xf32>
      "scf.yield"(%69) : (vector<3x3xf32>) -> ()
    }, {
      "scf.yield"(%57) : (vector<3x3xf32>) -> ()
    }) : (i1) -> vector<3x3xf32>
    "func.return"(%60) : (vector<3x3xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3x3xf32>, memref<?x?x?x?xf32>) -> (), sym_name = "transfer_write_minor_identity"}> ({
  ^bb0(%arg0: vector<3x3xf32>, %arg1: memref<?x?x?x?xf32>):
    %0 = "arith.constant"() <{value = 3 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 2 : index}> : () -> index
    %4 = "memref.dim"(%arg1, %3) : (memref<?x?x?x?xf32>, index) -> index
    %5 = "arith.cmpi"(%4, %2) <{predicate = 4 : i64}> : (index, index) -> i1
    "scf.if"(%5) ({
      %34 = "memref.dim"(%arg1, %0) : (memref<?x?x?x?xf32>, index) -> index
      %35 = "arith.cmpi"(%34, %2) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%35) ({
        %44 = "vector.extract"(%arg0) <{static_position = array<i64: 0, 0>}> : (vector<3x3xf32>) -> f32
        %45 = "vector.broadcast"(%44) : (f32) -> vector<f32>
        "vector.transfer_write"(%45, %arg1, %2, %2, %2, %2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map1}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %36 = "memref.dim"(%arg1, %0) : (memref<?x?x?x?xf32>, index) -> index
      %37 = "arith.cmpi"(%36, %1) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%37) ({
        %42 = "vector.extract"(%arg0) <{static_position = array<i64: 0, 1>}> : (vector<3x3xf32>) -> f32
        %43 = "vector.broadcast"(%42) : (f32) -> vector<f32>
        "vector.transfer_write"(%43, %arg1, %2, %2, %2, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map1}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %38 = "memref.dim"(%arg1, %0) : (memref<?x?x?x?xf32>, index) -> index
      %39 = "arith.cmpi"(%38, %3) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%39) ({
        %40 = "vector.extract"(%arg0) <{static_position = array<i64: 0, 2>}> : (vector<3x3xf32>) -> f32
        %41 = "vector.broadcast"(%40) : (f32) -> vector<f32>
        "vector.transfer_write"(%41, %arg1, %2, %2, %2, %3) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map1}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }, {
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    %6 = "memref.dim"(%arg1, %3) : (memref<?x?x?x?xf32>, index) -> index
    %7 = "arith.cmpi"(%6, %1) <{predicate = 4 : i64}> : (index, index) -> i1
    "scf.if"(%7) ({
      %22 = "memref.dim"(%arg1, %0) : (memref<?x?x?x?xf32>, index) -> index
      %23 = "arith.cmpi"(%22, %2) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%23) ({
        %32 = "vector.extract"(%arg0) <{static_position = array<i64: 1, 0>}> : (vector<3x3xf32>) -> f32
        %33 = "vector.broadcast"(%32) : (f32) -> vector<f32>
        "vector.transfer_write"(%33, %arg1, %2, %2, %1, %2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map1}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %24 = "memref.dim"(%arg1, %0) : (memref<?x?x?x?xf32>, index) -> index
      %25 = "arith.cmpi"(%24, %1) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%25) ({
        %30 = "vector.extract"(%arg0) <{static_position = array<i64: 1, 1>}> : (vector<3x3xf32>) -> f32
        %31 = "vector.broadcast"(%30) : (f32) -> vector<f32>
        "vector.transfer_write"(%31, %arg1, %2, %2, %1, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map1}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %26 = "memref.dim"(%arg1, %0) : (memref<?x?x?x?xf32>, index) -> index
      %27 = "arith.cmpi"(%26, %3) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%27) ({
        %28 = "vector.extract"(%arg0) <{static_position = array<i64: 1, 2>}> : (vector<3x3xf32>) -> f32
        %29 = "vector.broadcast"(%28) : (f32) -> vector<f32>
        "vector.transfer_write"(%29, %arg1, %2, %2, %1, %3) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map1}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }, {
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    %8 = "memref.dim"(%arg1, %3) : (memref<?x?x?x?xf32>, index) -> index
    %9 = "arith.cmpi"(%8, %3) <{predicate = 4 : i64}> : (index, index) -> i1
    "scf.if"(%9) ({
      %10 = "memref.dim"(%arg1, %0) : (memref<?x?x?x?xf32>, index) -> index
      %11 = "arith.cmpi"(%10, %2) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%11) ({
        %20 = "vector.extract"(%arg0) <{static_position = array<i64: 2, 0>}> : (vector<3x3xf32>) -> f32
        %21 = "vector.broadcast"(%20) : (f32) -> vector<f32>
        "vector.transfer_write"(%21, %arg1, %2, %2, %3, %2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map1}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %12 = "memref.dim"(%arg1, %0) : (memref<?x?x?x?xf32>, index) -> index
      %13 = "arith.cmpi"(%12, %1) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%13) ({
        %18 = "vector.extract"(%arg0) <{static_position = array<i64: 2, 1>}> : (vector<3x3xf32>) -> f32
        %19 = "vector.broadcast"(%18) : (f32) -> vector<f32>
        "vector.transfer_write"(%19, %arg1, %2, %2, %3, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map1}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      %14 = "memref.dim"(%arg1, %0) : (memref<?x?x?x?xf32>, index) -> index
      %15 = "arith.cmpi"(%14, %3) <{predicate = 4 : i64}> : (index, index) -> i1
      "scf.if"(%15) ({
        %16 = "vector.extract"(%arg0) <{static_position = array<i64: 2, 2>}> : (vector<3x3xf32>) -> f32
        %17 = "vector.broadcast"(%16) : (f32) -> vector<f32>
        "vector.transfer_write"(%17, %arg1, %2, %2, %3, %3) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map1}> : (vector<f32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }, {
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0 + d1 * 8)>
#map1 = affine_map<(d0, d1) -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x4xf32, #map>) -> vector<4xf32>, sym_name = "transfer_read_strided"}> ({
  ^bb0(%arg2: memref<8x4xf32, #map>):
    %12 = "arith.constant"() <{value = 3 : index}> : () -> index
    %13 = "arith.constant"() <{value = 2 : index}> : () -> index
    %14 = "arith.constant"() <{value = 1 : index}> : () -> index
    %15 = "arith.constant"() <{value = 0 : index}> : () -> index
    %16 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %17 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %18 = "vector.transfer_read"(%arg2, %15, %15, %16) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<8x4xf32, #map>, index, index, f32) -> vector<f32>
    %19 = "vector.extract"(%18) <{static_position = array<i64>}> : (vector<f32>) -> f32
    %20 = "vector.insert"(%19, %17) <{static_position = array<i64: 0>}> : (f32, vector<4xf32>) -> vector<4xf32>
    %21 = "vector.transfer_read"(%arg2, %15, %14, %16) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<8x4xf32, #map>, index, index, f32) -> vector<f32>
    %22 = "vector.extract"(%21) <{static_position = array<i64>}> : (vector<f32>) -> f32
    %23 = "vector.insert"(%22, %20) <{static_position = array<i64: 1>}> : (f32, vector<4xf32>) -> vector<4xf32>
    %24 = "vector.transfer_read"(%arg2, %15, %13, %16) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<8x4xf32, #map>, index, index, f32) -> vector<f32>
    %25 = "vector.extract"(%24) <{static_position = array<i64>}> : (vector<f32>) -> f32
    %26 = "vector.insert"(%25, %23) <{static_position = array<i64: 2>}> : (f32, vector<4xf32>) -> vector<4xf32>
    %27 = "vector.transfer_read"(%arg2, %15, %12, %16) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<8x4xf32, #map>, index, index, f32) -> vector<f32>
    %28 = "vector.extract"(%27) <{static_position = array<i64>}> : (vector<f32>) -> f32
    %29 = "vector.insert"(%28, %26) <{static_position = array<i64: 3>}> : (f32, vector<4xf32>) -> vector<4xf32>
    "func.return"(%29) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, memref<8x4xf32, #map>) -> (), sym_name = "transfer_write_strided"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: memref<8x4xf32, #map>):
    %0 = "arith.constant"() <{value = 3 : index}> : () -> index
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "vector.extract"(%arg0) <{static_position = array<i64: 0>}> : (vector<4xf32>) -> f32
    %5 = "vector.broadcast"(%4) : (f32) -> vector<f32>
    "vector.transfer_write"(%5, %arg1, %3, %3) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<f32>, memref<8x4xf32, #map>, index, index) -> ()
    %6 = "vector.extract"(%arg0) <{static_position = array<i64: 1>}> : (vector<4xf32>) -> f32
    %7 = "vector.broadcast"(%6) : (f32) -> vector<f32>
    "vector.transfer_write"(%7, %arg1, %3, %2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<f32>, memref<8x4xf32, #map>, index, index) -> ()
    %8 = "vector.extract"(%arg0) <{static_position = array<i64: 2>}> : (vector<4xf32>) -> f32
    %9 = "vector.broadcast"(%8) : (f32) -> vector<f32>
    "vector.transfer_write"(%9, %arg1, %3, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<f32>, memref<8x4xf32, #map>, index, index) -> ()
    %10 = "vector.extract"(%arg0) <{static_position = array<i64: 3>}> : (vector<4xf32>) -> f32
    %11 = "vector.broadcast"(%10) : (f32) -> vector<f32>
    "vector.transfer_write"(%11, %arg1, %3, %0) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<f32>, memref<8x4xf32, #map>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xf32>) -> (), sym_name = "fake_side_effecting_fun", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x2xf32>) -> !async.token, sym_name = "transfer_read_within_async_execute"}> ({
  ^bb0(%arg0: memref<2x2xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2x2xf32>}> : () -> vector<2x2xf32>
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "async.execute"() <{operandSegmentSizes = array<i32: 0, 0>}> ({
      %5 = "vector.transfer_read"(%arg0, %1, %1, %3) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x2xf32>, index, index, f32) -> vector<f32>
      %6 = "vector.extract"(%5) <{static_position = array<i64>}> : (vector<f32>) -> f32
      %7 = "vector.insert"(%6, %2) <{static_position = array<i64: 0, 0>}> : (f32, vector<2x2xf32>) -> vector<2x2xf32>
      %8 = "vector.transfer_read"(%arg0, %1, %0, %3) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x2xf32>, index, index, f32) -> vector<f32>
      %9 = "vector.extract"(%8) <{static_position = array<i64>}> : (vector<f32>) -> f32
      %10 = "vector.insert"(%9, %7) <{static_position = array<i64: 0, 1>}> : (f32, vector<2x2xf32>) -> vector<2x2xf32>
      %11 = "vector.transfer_read"(%arg0, %0, %1, %3) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x2xf32>, index, index, f32) -> vector<f32>
      %12 = "vector.extract"(%11) <{static_position = array<i64>}> : (vector<f32>) -> f32
      %13 = "vector.insert"(%12, %10) <{static_position = array<i64: 1, 0>}> : (f32, vector<2x2xf32>) -> vector<2x2xf32>
      %14 = "vector.transfer_read"(%arg0, %0, %0, %3) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x2xf32>, index, index, f32) -> vector<f32>
      %15 = "vector.extract"(%14) <{static_position = array<i64>}> : (vector<f32>) -> f32
      %16 = "vector.insert"(%15, %13) <{static_position = array<i64: 1, 1>}> : (f32, vector<2x2xf32>) -> vector<2x2xf32>
      "func.call"(%16) <{callee = @fake_side_effecting_fun}> : (vector<2x2xf32>) -> ()
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
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, f32) -> (), sym_name = "transfer_write_scalable"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: f32):
    %0 = "llvm.mlir.undef"() : () -> vector<[16]xf32>
    %1 = "llvm.mlir.undef"() : () -> vector<[16]xi32>
    %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "memref.dim"(%arg0, %3) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %5 = "llvm.intr.stepvector"() : () -> vector<[16]xi32>
    %6 = "arith.index_cast"(%4) : (index) -> i32
    %7 = "llvm.insertelement"(%1, %6, %2) : (vector<[16]xi32>, i32, i32) -> vector<[16]xi32>
    %8 = "llvm.shufflevector"(%7, %1) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[16]xi32>, vector<[16]xi32>) -> vector<[16]xi32>
    %9 = "arith.cmpi"(%5, %8) <{predicate = 2 : i64}> : (vector<[16]xi32>, vector<[16]xi32>) -> vector<[16]xi1>
    %10 = "llvm.insertelement"(%0, %arg1, %2) : (vector<[16]xf32>, f32, i32) -> vector<[16]xf32>
    %11 = "llvm.shufflevector"(%10, %0) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[16]xf32>, vector<[16]xf32>) -> vector<[16]xf32>
    "vector.transfer_write"(%11, %arg0, %3, %9) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 1>, permutation_map = #map}> : (vector<[16]xf32>, memref<?xf32, strided<[?], offset: ?>>, index, vector<[16]xi1>) -> ()
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
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : vector<3x[4]xf32>}> : () -> vector<3x[4]xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %5 = "memref.dim"(%arg0, %3) : (memref<3x?xf32>, index) -> index
    %6 = "vector.create_mask"(%3, %5) : (index, index) -> vector<3x[4]xi1>
    %7 = "vector.extract"(%6) <{static_position = array<i64: 0>}> : (vector<3x[4]xi1>) -> vector<[4]xi1>
    %8 = "vector.transfer_read"(%arg0, %2, %2, %4, %7) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 1>, permutation_map = #map}> : (memref<3x?xf32>, index, index, f32, vector<[4]xi1>) -> vector<[4]xf32>
    %9 = "vector.insert"(%8, %1) <{static_position = array<i64: 0>}> : (vector<[4]xf32>, vector<3x[4]xf32>) -> vector<3x[4]xf32>
    %10 = "vector.extract"(%6) <{static_position = array<i64: 1>}> : (vector<3x[4]xi1>) -> vector<[4]xi1>
    %11 = "vector.transfer_read"(%arg0, %3, %2, %4, %10) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 1>, permutation_map = #map}> : (memref<3x?xf32>, index, index, f32, vector<[4]xi1>) -> vector<[4]xf32>
    %12 = "vector.insert"(%11, %9) <{static_position = array<i64: 1>}> : (vector<[4]xf32>, vector<3x[4]xf32>) -> vector<3x[4]xf32>
    %13 = "vector.extract"(%6) <{static_position = array<i64: 2>}> : (vector<3x[4]xi1>) -> vector<[4]xi1>
    %14 = "vector.transfer_read"(%arg0, %0, %2, %4, %13) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 1>, permutation_map = #map}> : (memref<3x?xf32>, index, index, f32, vector<[4]xi1>) -> vector<[4]xf32>
    %15 = "vector.insert"(%14, %12) <{static_position = array<i64: 2>}> : (vector<[4]xf32>, vector<3x[4]xf32>) -> vector<3x[4]xf32>
    "func.return"(%15) : (vector<3x[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3x[4]xf32>, memref<3x?xf32>) -> (), sym_name = "transfer_write_array_of_scalable"}> ({
  ^bb0(%arg0: vector<3x[4]xf32>, %arg1: memref<3x?xf32>):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "memref.dim"(%arg1, %2) : (memref<3x?xf32>, index) -> index
    %4 = "vector.create_mask"(%2, %3) : (index, index) -> vector<3x[4]xi1>
    %5 = "vector.extract"(%arg0) <{static_position = array<i64: 0>}> : (vector<3x[4]xf32>) -> vector<[4]xf32>
    %6 = "vector.extract"(%4) <{static_position = array<i64: 0>}> : (vector<3x[4]xi1>) -> vector<[4]xi1>
    "vector.transfer_write"(%5, %arg1, %1, %1, %6) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 1>, permutation_map = #map}> : (vector<[4]xf32>, memref<3x?xf32>, index, index, vector<[4]xi1>) -> ()
    %7 = "vector.extract"(%arg0) <{static_position = array<i64: 1>}> : (vector<3x[4]xf32>) -> vector<[4]xf32>
    %8 = "vector.extract"(%4) <{static_position = array<i64: 1>}> : (vector<3x[4]xi1>) -> vector<[4]xi1>
    "vector.transfer_write"(%7, %arg1, %2, %1, %8) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 1>, permutation_map = #map}> : (vector<[4]xf32>, memref<3x?xf32>, index, index, vector<[4]xi1>) -> ()
    %9 = "vector.extract"(%arg0) <{static_position = array<i64: 2>}> : (vector<3x[4]xf32>) -> vector<[4]xf32>
    %10 = "vector.extract"(%4) <{static_position = array<i64: 2>}> : (vector<3x[4]xi1>) -> vector<[4]xi1>
    "vector.transfer_write"(%9, %arg1, %0, %1, %10) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 1>, permutation_map = #map}> : (vector<[4]xf32>, memref<3x?xf32>, index, index, vector<[4]xi1>) -> ()
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
#map1 = affine_map<(d0, d1, d2, d3) -> ()>
#map2 = affine_map<(d0, d1, d2) -> (d2)>
#map3 = affine_map<(d0) -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x4xf32>) -> vector<[4]x4xf32>, sym_name = "cannot_lower_transfer_read_with_leading_scalable"}> ({
  ^bb0(%arg7: memref<?x4xf32>):
    %29 = "arith.constant"() <{value = 0 : index}> : () -> index
    %30 = "arith.constant"() <{value = 4 : index}> : () -> index
    %31 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %32 = "memref.dim"(%arg7, %29) : (memref<?x4xf32>, index) -> index
    %33 = "vector.create_mask"(%32, %30) : (index, index) -> vector<[4]x4xi1>
    %34 = "vector.transfer_read"(%arg7, %29, %29, %31, %33) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 1>, permutation_map = #map}> : (memref<?x4xf32>, index, index, f32, vector<[4]x4xi1>) -> vector<[4]x4xf32>
    "func.return"(%34) : (vector<[4]x4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1x1x1x1xi32>, vector<1x1xi1>) -> vector<1x1x1x1xi32>, sym_name = "does_not_crash_on_unpack_one_dim"}> ({
  ^bb0(%arg5: memref<1x1x1x1xi32>, %arg6: vector<1x1xi1>):
    %21 = "arith.constant"() <{value = 0 : index}> : () -> index
    %22 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %23 = "arith.constant"() <{value = dense<0> : vector<1x1x1x1xi32>}> : () -> vector<1x1x1x1xi32>
    %24 = "vector.extract"(%arg6) <{static_position = array<i64: 0, 0>}> : (vector<1x1xi1>) -> i1
    %25 = "scf.if"(%24) ({
      %26 = "vector.transfer_read"(%arg5, %21, %21, %21, %21, %22) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map1}> : (memref<1x1x1x1xi32>, index, index, index, index, i32) -> vector<i32>
      %27 = "vector.extract"(%26) <{static_position = array<i64>}> : (vector<i32>) -> i32
      %28 = "vector.insert"(%27, %23) <{static_position = array<i64: 0, 0, 0, 0>}> : (i32, vector<1x1x1x1xi32>) -> vector<1x1x1x1xi32>
      "scf.yield"(%28) : (vector<1x1x1x1xi32>) -> ()
    }, {
      "scf.yield"(%23) : (vector<1x1x1x1xi32>) -> ()
    }) : (i1) -> vector<1x1x1x1xi32>
    "func.return"(%25) : (vector<1x1x1x1xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1x2x?xf32>, memref<1x2x?xf32>) -> vector<1x2x[4]xf32>, sym_name = "add_arrays_of_scalable_vectors"}> ({
  ^bb0(%arg3: memref<1x2x?xf32>, %arg4: memref<1x2x?xf32>):
    %8 = "arith.constant"() <{value = 1 : index}> : () -> index
    %9 = "arith.constant"() <{value = dense<0.000000e+00> : vector<1x2x[4]xf32>}> : () -> vector<1x2x[4]xf32>
    %10 = "arith.constant"() <{value = 0 : index}> : () -> index
    %11 = "arith.constant"() <{value = 2 : index}> : () -> index
    %12 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %13 = "memref.dim"(%arg3, %11) : (memref<1x2x?xf32>, index) -> index
    %14 = "vector.create_mask"(%11, %11, %13) : (index, index, index) -> vector<1x2x[4]xi1>
    %15 = "vector.extract"(%14) <{static_position = array<i64: 0, 0>}> : (vector<1x2x[4]xi1>) -> vector<[4]xi1>
    %16 = "vector.transfer_read"(%arg3, %10, %10, %10, %12, %15) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 1>, permutation_map = #map2}> : (memref<1x2x?xf32>, index, index, index, f32, vector<[4]xi1>) -> vector<[4]xf32>
    %17 = "vector.insert"(%16, %9) <{static_position = array<i64: 0, 0>}> : (vector<[4]xf32>, vector<1x2x[4]xf32>) -> vector<1x2x[4]xf32>
    %18 = "vector.extract"(%14) <{static_position = array<i64: 0, 1>}> : (vector<1x2x[4]xi1>) -> vector<[4]xi1>
    %19 = "vector.transfer_read"(%arg3, %10, %8, %10, %12, %18) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 1>, permutation_map = #map2}> : (memref<1x2x?xf32>, index, index, index, f32, vector<[4]xi1>) -> vector<[4]xf32>
    %20 = "vector.insert"(%19, %17) <{static_position = array<i64: 0, 1>}> : (vector<[4]xf32>, vector<1x2x[4]xf32>) -> vector<1x2x[4]xf32>
    "func.return"(%20) : (vector<1x2x[4]xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<[4]x[4]xf32>, memref<?x?xf32>) -> (), sym_name = "cannot_fully_unroll_transfer_write_of_nd_scalable_vector"}> ({
  ^bb0(%arg1: vector<[4]x[4]xf32>, %arg2: memref<?x?xf32>):
    %7 = "arith.constant"() <{value = 0 : index}> : () -> index
    "vector.transfer_write"(%arg1, %arg2, %7, %7) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<[4]x[4]xf32>, memref<?x?xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi32>) -> (), sym_name = "unroll_transfer_write_target_rank_zero"}> ({
  ^bb0(%arg0: vector<2xi32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xi32>
    %3 = "vector.extract"(%arg0) <{static_position = array<i64: 0>}> : (vector<2xi32>) -> i32
    %4 = "vector.broadcast"(%3) : (i32) -> vector<i32>
    "vector.transfer_write"(%4, %2, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map3}> : (vector<i32>, memref<4xi32>, index) -> ()
    %5 = "vector.extract"(%arg0) <{static_position = array<i64: 1>}> : (vector<2xi32>) -> i32
    %6 = "vector.broadcast"(%5) : (i32) -> vector<i32>
    "vector.transfer_write"(%6, %2, %0) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map3}> : (vector<i32>, memref<4xi32>, index) -> ()
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
#map = affine_map<(d0, d1) -> (d1)>
#map1 = affine_map<()[s0] -> (s0 + 1)>
#map2 = affine_map<()[s0] -> (s0 + 2)>
#map3 = affine_map<()[s0] -> (s0 + 3)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]x4xf32>, memref<?x?xf32>, index, index) -> (), sym_name = "negative_scalable_transpose_store_0"}> ({
  ^bb0(%arg0: vector<[4]x4xf32>, %arg1: memref<?x?xf32>, %arg2: index, %arg3: index):
    %0 = "vector.transpose"(%arg0) <{permutation = array<i64: 1, 0>}> : (vector<[4]x4xf32>) -> vector<4x[4]xf32>
    %1 = "vector.extract"(%0) <{static_position = array<i64: 0>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    "vector.transfer_write"(%1, %arg1, %arg2, %arg3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<[4]xf32>, memref<?x?xf32>, index, index) -> ()
    %2 = "affine.apply"(%arg2) <{map = #map1}> : (index) -> index
    %3 = "vector.extract"(%0) <{static_position = array<i64: 1>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    "vector.transfer_write"(%3, %arg1, %2, %arg3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<[4]xf32>, memref<?x?xf32>, index, index) -> ()
    %4 = "affine.apply"(%arg2) <{map = #map2}> : (index) -> index
    %5 = "vector.extract"(%0) <{static_position = array<i64: 2>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    "vector.transfer_write"(%5, %arg1, %4, %arg3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<[4]xf32>, memref<?x?xf32>, index, index) -> ()
    %6 = "affine.apply"(%arg2) <{map = #map3}> : (index) -> index
    %7 = "vector.extract"(%0) <{static_position = array<i64: 3>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    "vector.transfer_write"(%7, %arg1, %6, %arg3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<[4]xf32>, memref<?x?xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
#map1 = affine_map<()[s0] -> (s0 + 1)>
#map2 = affine_map<()[s0] -> (s0 + 2)>
#map3 = affine_map<()[s0] -> (s0 + 3)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x[4]xf32>, memref<?x?xf32>, index, index) -> (), sym_name = "negative_scalable_transpose_store_1"}> ({
  ^bb0(%arg0: vector<4x[4]xf32>, %arg1: memref<?x?xf32>, %arg2: index, %arg3: index):
    %0 = "vector.extract"(%arg0) <{static_position = array<i64: 0>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    "vector.transfer_write"(%0, %arg1, %arg2, %arg3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<[4]xf32>, memref<?x?xf32>, index, index) -> ()
    %1 = "affine.apply"(%arg2) <{map = #map1}> : (index) -> index
    %2 = "vector.extract"(%arg0) <{static_position = array<i64: 1>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    "vector.transfer_write"(%2, %arg1, %1, %arg3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<[4]xf32>, memref<?x?xf32>, index, index) -> ()
    %3 = "affine.apply"(%arg2) <{map = #map2}> : (index) -> index
    %4 = "vector.extract"(%arg0) <{static_position = array<i64: 2>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    "vector.transfer_write"(%4, %arg1, %3, %arg3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<[4]xf32>, memref<?x?xf32>, index, index) -> ()
    %5 = "affine.apply"(%arg2) <{map = #map3}> : (index) -> index
    %6 = "vector.extract"(%arg0) <{static_position = array<i64: 3>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    "vector.transfer_write"(%6, %arg1, %5, %arg3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<[4]xf32>, memref<?x?xf32>, index, index) -> ()
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

