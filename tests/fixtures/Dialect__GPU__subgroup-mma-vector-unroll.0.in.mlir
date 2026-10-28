#map = affine_map<()[s0] -> (s0 * 16)>
#map1 = affine_map<()[s0] -> ((s0 floordiv 32) * 16)>
#map2 = affine_map<(d0)[s0] -> (d0 + s0)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map5 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map6 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32x32xf32>, memref<32x32xf32>, memref<32x32xf32>) -> (), sym_name = "matmul"}> ({
  ^bb0(%arg1: memref<32x32xf32>, %arg2: memref<32x32xf32>, %arg3: memref<32x32xf32>):
    %1 = "arith.constant"() <{value = 8 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = dense<0.000000e+00> : vector<16x16xf32>}> : () -> vector<16x16xf32>
    %4 = "arith.constant"() <{value = 16 : index}> : () -> index
    %5 = "arith.constant"() <{value = 32 : index}> : () -> index
    %6 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %7 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
    %8 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
    %9 = "affine.apply"(%8) <{map = #map}> : (index) -> index
    %10 = "affine.apply"(%7) <{map = #map1}> : (index) -> index
    %11 = "scf.for"(%2, %5, %4, %3) ({
    ^bb0(%arg4: index, %arg5: vector<16x16xf32>):
      %14 = "affine.apply"(%2, %9) <{map = #map2}> : (index, index) -> index
      %15 = "affine.apply"(%2, %arg4) <{map = #map2}> : (index, index) -> index
      %16 = "vector.transfer_read"(%arg1, %14, %15, %6) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map3}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
      %17 = "affine.apply"(%2, %10) <{map = #map2}> : (index, index) -> index
      %18 = "affine.apply"(%2, %arg4) <{map = #map2}> : (index, index) -> index
      %19 = "vector.transfer_read"(%arg2, %18, %17, %6) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map3}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
      %20 = "vector.contract"(%16, %19, %arg5) <{indexing_maps = [#map4, #map5, #map6], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>) -> vector<16x16xf32>
      "scf.yield"(%20) : (vector<16x16xf32>) -> ()
    }) : (index, index, index, vector<16x16xf32>) -> vector<16x16xf32>
    %12 = "affine.apply"(%2, %9) <{map = #map2}> : (index, index) -> index
    %13 = "affine.apply"(%2, %10) <{map = #map2}> : (index, index) -> index
    "vector.transfer_write"(%11, %arg3, %12, %13) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map3}> : (vector<16x16xf32>, memref<32x32xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.op<"func.func">
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.gpu.unroll_vectors_subgroup_mma"() <{k = 8 : i64, m = 16 : i64, n = 16 : i64}> : () -> ()
      }) : (!transform.op<"func.func">) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 * 16)>
#map1 = affine_map<()[s0] -> ((s0 floordiv 32) * 16)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
#map3 = affine_map<(d0)[s0] -> (d0 + s0)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map5 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map6 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32x32xf32>, memref<32x32xf32>, memref<32x32xf32>) -> (), sym_name = "gathered_matmul"}> ({
  ^bb0(%arg1: memref<32x32xf32>, %arg2: memref<32x32xf32>, %arg3: memref<32x32xf32>):
    %1 = "arith.constant"() <{value = 8 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = dense<0.000000e+00> : vector<16x16xf32>}> : () -> vector<16x16xf32>
    %4 = "arith.constant"() <{value = dense<true> : vector<4x4xi1>}> : () -> vector<4x4xi1>
    %5 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4x4xf32>}> : () -> vector<4x4xf32>
    %6 = "arith.constant"() <{value = 16 : index}> : () -> index
    %7 = "arith.constant"() <{value = 32 : index}> : () -> index
    %8 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %9 = "arith.constant"() <{value = dense<[0, 1, 2, 3]> : vector<4xindex>}> : () -> vector<4xindex>
    %10 = "arith.constant"() <{value = dense<1> : vector<4x4xindex>}> : () -> vector<4x4xindex>
    %11 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
    %12 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
    %13 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
    %14 = "affine.apply"(%13) <{map = #map}> : (index) -> index
    %15 = "affine.apply"(%12) <{map = #map1}> : (index) -> index
    %16 = "scf.for"(%2, %7, %6, %3) ({
    ^bb0(%arg4: index, %arg5: vector<16x16xf32>):
      %19 = "vector.broadcast"(%arg4) : (index) -> vector<4xindex>
      %20 = "arith.addi"(%19, %9) <{overflowFlags = #arith.overflow<none>}> : (vector<4xindex>, vector<4xindex>) -> vector<4xindex>
      %21 = "vector.broadcast"(%20) : (vector<4xindex>) -> vector<4x4xindex>
      %22 = "arith.addi"(%21, %10) <{overflowFlags = #arith.overflow<none>}> : (vector<4x4xindex>, vector<4x4xindex>) -> vector<4x4xindex>
      %23 = "vector.gather"(%arg1, %2, %2, %22, %4, %5) : (memref<32x32xf32>, index, index, vector<4x4xindex>, vector<4x4xi1>, vector<4x4xf32>) -> vector<4x4xf32>
      "vector.transfer_write"(%23, %11, %2, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map2}> : (vector<4x4xf32>, memref<32x32xf32>, index, index) -> ()
      "gpu.barrier"() : () -> ()
      %24 = "affine.apply"(%2, %14) <{map = #map3}> : (index, index) -> index
      %25 = "affine.apply"(%2, %arg4) <{map = #map3}> : (index, index) -> index
      %26 = "vector.transfer_read"(%11, %24, %25, %8) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
      %27 = "affine.apply"(%2, %15) <{map = #map3}> : (index, index) -> index
      %28 = "affine.apply"(%2, %arg4) <{map = #map3}> : (index, index) -> index
      %29 = "vector.transfer_read"(%arg2, %28, %27, %8) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
      %30 = "vector.contract"(%26, %29, %arg5) <{indexing_maps = [#map4, #map5, #map6], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>) -> vector<16x16xf32>
      "scf.yield"(%30) : (vector<16x16xf32>) -> ()
    }) : (index, index, index, vector<16x16xf32>) -> vector<16x16xf32>
    %17 = "affine.apply"(%2, %14) <{map = #map3}> : (index, index) -> index
    %18 = "affine.apply"(%2, %15) <{map = #map3}> : (index, index) -> index
    "vector.transfer_write"(%16, %arg3, %17, %18) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map2}> : (vector<16x16xf32>, memref<32x32xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.op<"func.func">
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.gpu.unroll_vectors_subgroup_mma"() <{k = 4 : i64, m = 8 : i64, n = 16 : i64}> : () -> ()
      }) : (!transform.op<"func.func">) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

