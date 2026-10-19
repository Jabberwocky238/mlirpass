#map = affine_map<(d0, d1, d2) -> (d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf32>) -> vector<2x3x4xf32>, sym_name = "transfer_read_inbounds"}> ({
  ^bb0(%arg0: memref<?x?x?xf32>):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2x3x4xf32>}> : () -> vector<2x3x4xf32>
    %5 = "vector.transfer_read"(%arg0, %3, %3, %3, %2) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<?x?x?xf32>, index, index, index, f32) -> vector<4xf32>
    %6 = "vector.insert"(%5, %4) <{static_position = array<i64: 0, 0>}> : (vector<4xf32>, vector<2x3x4xf32>) -> vector<2x3x4xf32>
    %7 = "vector.transfer_read"(%arg0, %3, %1, %3, %2) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<?x?x?xf32>, index, index, index, f32) -> vector<4xf32>
    %8 = "vector.insert"(%7, %6) <{static_position = array<i64: 0, 1>}> : (vector<4xf32>, vector<2x3x4xf32>) -> vector<2x3x4xf32>
    %9 = "vector.transfer_read"(%arg0, %3, %0, %3, %2) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<?x?x?xf32>, index, index, index, f32) -> vector<4xf32>
    %10 = "vector.insert"(%9, %8) <{static_position = array<i64: 0, 2>}> : (vector<4xf32>, vector<2x3x4xf32>) -> vector<2x3x4xf32>
    %11 = "vector.transfer_read"(%arg0, %1, %3, %3, %2) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<?x?x?xf32>, index, index, index, f32) -> vector<4xf32>
    %12 = "vector.insert"(%11, %10) <{static_position = array<i64: 1, 0>}> : (vector<4xf32>, vector<2x3x4xf32>) -> vector<2x3x4xf32>
    %13 = "vector.transfer_read"(%arg0, %1, %1, %3, %2) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<?x?x?xf32>, index, index, index, f32) -> vector<4xf32>
    %14 = "vector.insert"(%13, %12) <{static_position = array<i64: 1, 1>}> : (vector<4xf32>, vector<2x3x4xf32>) -> vector<2x3x4xf32>
    %15 = "vector.transfer_read"(%arg0, %1, %0, %3, %2) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<?x?x?xf32>, index, index, index, f32) -> vector<4xf32>
    %16 = "vector.insert"(%15, %14) <{static_position = array<i64: 1, 2>}> : (vector<4xf32>, vector<2x3x4xf32>) -> vector<2x3x4xf32>
    "func.return"(%16) : (vector<2x3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf32>) -> vector<2x3x4xf32>, sym_name = "transfer_read_out_of_bounds"}> ({
  ^bb0(%arg0: memref<?x?x?xf32>):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2x3x4xf32>}> : () -> vector<2x3x4xf32>
    %5 = "memref.dim"(%arg0, %3) : (memref<?x?x?xf32>, index) -> index
    %6 = "arith.cmpi"(%5, %3) <{predicate = 4 : i64}> : (index, index) -> i1
    %7 = "scf.if"(%6) ({
      %26 = "memref.dim"(%arg0, %1) : (memref<?x?x?xf32>, index) -> index
      %27 = "arith.cmpi"(%26, %3) <{predicate = 4 : i64}> : (index, index) -> i1
      %28 = "scf.if"(%27) ({
        %39 = "vector.transfer_read"(%arg0, %3, %3, %3, %2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<?x?x?xf32>, index, index, index, f32) -> vector<4xf32>
        %40 = "vector.insert"(%39, %4) <{static_position = array<i64: 0, 0>}> : (vector<4xf32>, vector<2x3x4xf32>) -> vector<2x3x4xf32>
        "scf.yield"(%40) : (vector<2x3x4xf32>) -> ()
      }, {
        "scf.yield"(%4) : (vector<2x3x4xf32>) -> ()
      }) : (i1) -> vector<2x3x4xf32>
      %29 = "memref.dim"(%arg0, %1) : (memref<?x?x?xf32>, index) -> index
      %30 = "arith.cmpi"(%29, %1) <{predicate = 4 : i64}> : (index, index) -> i1
      %31 = "scf.if"(%30) ({
        %37 = "vector.transfer_read"(%arg0, %3, %1, %3, %2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<?x?x?xf32>, index, index, index, f32) -> vector<4xf32>
        %38 = "vector.insert"(%37, %28) <{static_position = array<i64: 0, 1>}> : (vector<4xf32>, vector<2x3x4xf32>) -> vector<2x3x4xf32>
        "scf.yield"(%38) : (vector<2x3x4xf32>) -> ()
      }, {
        "scf.yield"(%28) : (vector<2x3x4xf32>) -> ()
      }) : (i1) -> vector<2x3x4xf32>
      %32 = "memref.dim"(%arg0, %1) : (memref<?x?x?xf32>, index) -> index
      %33 = "arith.cmpi"(%32, %0) <{predicate = 4 : i64}> : (index, index) -> i1
      %34 = "scf.if"(%33) ({
        %35 = "vector.transfer_read"(%arg0, %3, %0, %3, %2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<?x?x?xf32>, index, index, index, f32) -> vector<4xf32>
        %36 = "vector.insert"(%35, %31) <{static_position = array<i64: 0, 2>}> : (vector<4xf32>, vector<2x3x4xf32>) -> vector<2x3x4xf32>
        "scf.yield"(%36) : (vector<2x3x4xf32>) -> ()
      }, {
        "scf.yield"(%31) : (vector<2x3x4xf32>) -> ()
      }) : (i1) -> vector<2x3x4xf32>
      "scf.yield"(%34) : (vector<2x3x4xf32>) -> ()
    }, {
      "scf.yield"(%4) : (vector<2x3x4xf32>) -> ()
    }) : (i1) -> vector<2x3x4xf32>
    %8 = "memref.dim"(%arg0, %3) : (memref<?x?x?xf32>, index) -> index
    %9 = "arith.cmpi"(%8, %1) <{predicate = 4 : i64}> : (index, index) -> i1
    %10 = "scf.if"(%9) ({
      %11 = "memref.dim"(%arg0, %1) : (memref<?x?x?xf32>, index) -> index
      %12 = "arith.cmpi"(%11, %3) <{predicate = 4 : i64}> : (index, index) -> i1
      %13 = "scf.if"(%12) ({
        %24 = "vector.transfer_read"(%arg0, %1, %3, %3, %2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<?x?x?xf32>, index, index, index, f32) -> vector<4xf32>
        %25 = "vector.insert"(%24, %7) <{static_position = array<i64: 1, 0>}> : (vector<4xf32>, vector<2x3x4xf32>) -> vector<2x3x4xf32>
        "scf.yield"(%25) : (vector<2x3x4xf32>) -> ()
      }, {
        "scf.yield"(%7) : (vector<2x3x4xf32>) -> ()
      }) : (i1) -> vector<2x3x4xf32>
      %14 = "memref.dim"(%arg0, %1) : (memref<?x?x?xf32>, index) -> index
      %15 = "arith.cmpi"(%14, %1) <{predicate = 4 : i64}> : (index, index) -> i1
      %16 = "scf.if"(%15) ({
        %22 = "vector.transfer_read"(%arg0, %1, %1, %3, %2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<?x?x?xf32>, index, index, index, f32) -> vector<4xf32>
        %23 = "vector.insert"(%22, %13) <{static_position = array<i64: 1, 1>}> : (vector<4xf32>, vector<2x3x4xf32>) -> vector<2x3x4xf32>
        "scf.yield"(%23) : (vector<2x3x4xf32>) -> ()
      }, {
        "scf.yield"(%13) : (vector<2x3x4xf32>) -> ()
      }) : (i1) -> vector<2x3x4xf32>
      %17 = "memref.dim"(%arg0, %1) : (memref<?x?x?xf32>, index) -> index
      %18 = "arith.cmpi"(%17, %0) <{predicate = 4 : i64}> : (index, index) -> i1
      %19 = "scf.if"(%18) ({
        %20 = "vector.transfer_read"(%arg0, %1, %0, %3, %2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<?x?x?xf32>, index, index, index, f32) -> vector<4xf32>
        %21 = "vector.insert"(%20, %16) <{static_position = array<i64: 1, 2>}> : (vector<4xf32>, vector<2x3x4xf32>) -> vector<2x3x4xf32>
        "scf.yield"(%21) : (vector<2x3x4xf32>) -> ()
      }, {
        "scf.yield"(%16) : (vector<2x3x4xf32>) -> ()
      }) : (i1) -> vector<2x3x4xf32>
      "scf.yield"(%19) : (vector<2x3x4xf32>) -> ()
    }, {
      "scf.yield"(%7) : (vector<2x3x4xf32>) -> ()
    }) : (i1) -> vector<2x3x4xf32>
    "func.return"(%10) : (vector<2x3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf32>, vector<2x3x4xi1>) -> vector<2x3x4xf32>, sym_name = "transfer_read_mask"}> ({
  ^bb0(%arg0: memref<?x?x?xf32>, %arg1: vector<2x3x4xi1>):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2x3x4xf32>}> : () -> vector<2x3x4xf32>
    %5 = "vector.extract"(%arg1) <{static_position = array<i64: 0, 0>}> : (vector<2x3x4xi1>) -> vector<4xi1>
    %6 = "vector.transfer_read"(%arg0, %3, %3, %3, %2, %5) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 1>, permutation_map = #map}> : (memref<?x?x?xf32>, index, index, index, f32, vector<4xi1>) -> vector<4xf32>
    %7 = "vector.insert"(%6, %4) <{static_position = array<i64: 0, 0>}> : (vector<4xf32>, vector<2x3x4xf32>) -> vector<2x3x4xf32>
    %8 = "vector.extract"(%arg1) <{static_position = array<i64: 0, 1>}> : (vector<2x3x4xi1>) -> vector<4xi1>
    %9 = "vector.transfer_read"(%arg0, %3, %1, %3, %2, %8) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 1>, permutation_map = #map}> : (memref<?x?x?xf32>, index, index, index, f32, vector<4xi1>) -> vector<4xf32>
    %10 = "vector.insert"(%9, %7) <{static_position = array<i64: 0, 1>}> : (vector<4xf32>, vector<2x3x4xf32>) -> vector<2x3x4xf32>
    %11 = "vector.extract"(%arg1) <{static_position = array<i64: 0, 2>}> : (vector<2x3x4xi1>) -> vector<4xi1>
    %12 = "vector.transfer_read"(%arg0, %3, %0, %3, %2, %11) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 1>, permutation_map = #map}> : (memref<?x?x?xf32>, index, index, index, f32, vector<4xi1>) -> vector<4xf32>
    %13 = "vector.insert"(%12, %10) <{static_position = array<i64: 0, 2>}> : (vector<4xf32>, vector<2x3x4xf32>) -> vector<2x3x4xf32>
    %14 = "vector.extract"(%arg1) <{static_position = array<i64: 1, 0>}> : (vector<2x3x4xi1>) -> vector<4xi1>
    %15 = "vector.transfer_read"(%arg0, %1, %3, %3, %2, %14) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 1>, permutation_map = #map}> : (memref<?x?x?xf32>, index, index, index, f32, vector<4xi1>) -> vector<4xf32>
    %16 = "vector.insert"(%15, %13) <{static_position = array<i64: 1, 0>}> : (vector<4xf32>, vector<2x3x4xf32>) -> vector<2x3x4xf32>
    %17 = "vector.extract"(%arg1) <{static_position = array<i64: 1, 1>}> : (vector<2x3x4xi1>) -> vector<4xi1>
    %18 = "vector.transfer_read"(%arg0, %1, %1, %3, %2, %17) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 1>, permutation_map = #map}> : (memref<?x?x?xf32>, index, index, index, f32, vector<4xi1>) -> vector<4xf32>
    %19 = "vector.insert"(%18, %16) <{static_position = array<i64: 1, 1>}> : (vector<4xf32>, vector<2x3x4xf32>) -> vector<2x3x4xf32>
    %20 = "vector.extract"(%arg1) <{static_position = array<i64: 1, 2>}> : (vector<2x3x4xi1>) -> vector<4xi1>
    %21 = "vector.transfer_read"(%arg0, %1, %0, %3, %2, %20) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 1>, permutation_map = #map}> : (memref<?x?x?xf32>, index, index, index, f32, vector<4xi1>) -> vector<4xf32>
    %22 = "vector.insert"(%21, %19) <{static_position = array<i64: 1, 2>}> : (vector<4xf32>, vector<2x3x4xf32>) -> vector<2x3x4xf32>
    "func.return"(%22) : (vector<2x3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

