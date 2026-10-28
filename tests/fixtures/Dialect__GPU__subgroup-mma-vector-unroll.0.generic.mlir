#map = affine_map<()[s0] -> (s0 * 16)>
#map1 = affine_map<()[s0] -> ((s0 floordiv 32) * 16)>
#map2 = affine_map<(d0)[s0] -> (d0 + s0)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
#map4 = affine_map<(d0) -> (d0 + 8)>
#map5 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map6 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map7 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32x32xf32>, memref<32x32xf32>, memref<32x32xf32>) -> (), sym_name = "matmul"}> ({
  ^bb0(%arg1: memref<32x32xf32>, %arg2: memref<32x32xf32>, %arg3: memref<32x32xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = dense<0.000000e+00> : vector<16x16xf32>}> : () -> vector<16x16xf32>
    %3 = "arith.constant"() <{value = 16 : index}> : () -> index
    %4 = "arith.constant"() <{value = 32 : index}> : () -> index
    %5 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %6 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
    %7 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
    %8 = "affine.apply"(%7) <{map = #map}> : (index) -> index
    %9 = "affine.apply"(%6) <{map = #map1}> : (index) -> index
    %10 = "scf.for"(%1, %4, %3, %2) ({
    ^bb0(%arg4: index, %arg5: vector<16x16xf32>):
      %13 = "affine.apply"(%1, %8) <{map = #map2}> : (index, index) -> index
      %14 = "affine.apply"(%1, %arg4) <{map = #map2}> : (index, index) -> index
      %15 = "vector.transfer_read"(%arg1, %13, %14, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map3}> : (memref<32x32xf32>, index, index, f32) -> vector<16x8xf32>
      %16 = "affine.apply"(%14) <{map = #map4}> : (index) -> index
      %17 = "vector.transfer_read"(%arg1, %13, %16, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map3}> : (memref<32x32xf32>, index, index, f32) -> vector<16x8xf32>
      %18 = "affine.apply"(%1, %9) <{map = #map2}> : (index, index) -> index
      %19 = "affine.apply"(%1, %arg4) <{map = #map2}> : (index, index) -> index
      %20 = "vector.transfer_read"(%arg2, %19, %18, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map3}> : (memref<32x32xf32>, index, index, f32) -> vector<8x16xf32>
      %21 = "affine.apply"(%19) <{map = #map4}> : (index) -> index
      %22 = "vector.transfer_read"(%arg2, %21, %18, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map3}> : (memref<32x32xf32>, index, index, f32) -> vector<8x16xf32>
      %23 = "vector.contract"(%15, %20, %arg5) <{indexing_maps = [#map5, #map6, #map7], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x8xf32>, vector<8x16xf32>, vector<16x16xf32>) -> vector<16x16xf32>
      %24 = "vector.contract"(%17, %22, %23) <{indexing_maps = [#map5, #map6, #map7], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x8xf32>, vector<8x16xf32>, vector<16x16xf32>) -> vector<16x16xf32>
      "scf.yield"(%24) : (vector<16x16xf32>) -> ()
    }) : (index, index, index, vector<16x16xf32>) -> vector<16x16xf32>
    %11 = "affine.apply"(%1, %8) <{map = #map2}> : (index, index) -> index
    %12 = "affine.apply"(%1, %9) <{map = #map2}> : (index, index) -> index
    "vector.transfer_write"(%10, %arg3, %11, %12) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map3}> : (vector<16x16xf32>, memref<32x32xf32>, index, index) -> ()
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
#map4 = affine_map<(d0) -> (d0 + 4)>
#map5 = affine_map<(d0) -> (d0 + 8)>
#map6 = affine_map<(d0) -> (d0 + 12)>
#map7 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map8 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map9 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32x32xf32>, memref<32x32xf32>, memref<32x32xf32>) -> (), sym_name = "gathered_matmul"}> ({
  ^bb0(%arg1: memref<32x32xf32>, %arg2: memref<32x32xf32>, %arg3: memref<32x32xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = dense<0.000000e+00> : vector<16x16xf32>}> : () -> vector<16x16xf32>
    %3 = "arith.constant"() <{value = dense<true> : vector<4x4xi1>}> : () -> vector<4x4xi1>
    %4 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4x4xf32>}> : () -> vector<4x4xf32>
    %5 = "arith.constant"() <{value = 16 : index}> : () -> index
    %6 = "arith.constant"() <{value = 32 : index}> : () -> index
    %7 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %8 = "arith.constant"() <{value = dense<[0, 1, 2, 3]> : vector<4xindex>}> : () -> vector<4xindex>
    %9 = "arith.constant"() <{value = dense<1> : vector<4x4xindex>}> : () -> vector<4x4xindex>
    %10 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
    %11 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
    %12 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
    %13 = "affine.apply"(%12) <{map = #map}> : (index) -> index
    %14 = "affine.apply"(%11) <{map = #map1}> : (index) -> index
    %15 = "scf.for"(%1, %6, %5, %2) ({
    ^bb0(%arg4: index, %arg5: vector<16x16xf32>):
      %21 = "vector.broadcast"(%arg4) : (index) -> vector<4xindex>
      %22 = "arith.addi"(%21, %8) <{overflowFlags = #arith.overflow<none>}> : (vector<4xindex>, vector<4xindex>) -> vector<4xindex>
      %23 = "vector.broadcast"(%22) : (vector<4xindex>) -> vector<4x4xindex>
      %24 = "arith.addi"(%23, %9) <{overflowFlags = #arith.overflow<none>}> : (vector<4x4xindex>, vector<4x4xindex>) -> vector<4x4xindex>
      %25 = "vector.gather"(%arg1, %1, %1, %24, %3, %4) : (memref<32x32xf32>, index, index, vector<4x4xindex>, vector<4x4xi1>, vector<4x4xf32>) -> vector<4x4xf32>
      "vector.transfer_write"(%25, %10, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map2}> : (vector<4x4xf32>, memref<32x32xf32>, index, index) -> ()
      "gpu.barrier"() : () -> ()
      %26 = "affine.apply"(%1, %13) <{map = #map3}> : (index, index) -> index
      %27 = "affine.apply"(%1, %arg4) <{map = #map3}> : (index, index) -> index
      %28 = "vector.transfer_read"(%10, %26, %27, %7) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<32x32xf32>, index, index, f32) -> vector<8x4xf32>
      %29 = "affine.apply"(%27) <{map = #map4}> : (index) -> index
      %30 = "vector.transfer_read"(%10, %26, %29, %7) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<32x32xf32>, index, index, f32) -> vector<8x4xf32>
      %31 = "affine.apply"(%27) <{map = #map5}> : (index) -> index
      %32 = "vector.transfer_read"(%10, %26, %31, %7) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<32x32xf32>, index, index, f32) -> vector<8x4xf32>
      %33 = "affine.apply"(%27) <{map = #map6}> : (index) -> index
      %34 = "vector.transfer_read"(%10, %26, %33, %7) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<32x32xf32>, index, index, f32) -> vector<8x4xf32>
      %35 = "affine.apply"(%26) <{map = #map5}> : (index) -> index
      %36 = "vector.transfer_read"(%10, %35, %27, %7) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<32x32xf32>, index, index, f32) -> vector<8x4xf32>
      %37 = "affine.apply"(%26) <{map = #map5}> : (index) -> index
      %38 = "affine.apply"(%27) <{map = #map4}> : (index) -> index
      %39 = "vector.transfer_read"(%10, %37, %38, %7) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<32x32xf32>, index, index, f32) -> vector<8x4xf32>
      %40 = "affine.apply"(%26) <{map = #map5}> : (index) -> index
      %41 = "affine.apply"(%27) <{map = #map5}> : (index) -> index
      %42 = "vector.transfer_read"(%10, %40, %41, %7) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<32x32xf32>, index, index, f32) -> vector<8x4xf32>
      %43 = "affine.apply"(%26) <{map = #map5}> : (index) -> index
      %44 = "affine.apply"(%27) <{map = #map6}> : (index) -> index
      %45 = "vector.transfer_read"(%10, %43, %44, %7) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<32x32xf32>, index, index, f32) -> vector<8x4xf32>
      %46 = "affine.apply"(%1, %14) <{map = #map3}> : (index, index) -> index
      %47 = "affine.apply"(%1, %arg4) <{map = #map3}> : (index, index) -> index
      %48 = "vector.transfer_read"(%arg2, %47, %46, %7) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<32x32xf32>, index, index, f32) -> vector<4x16xf32>
      %49 = "affine.apply"(%47) <{map = #map4}> : (index) -> index
      %50 = "vector.transfer_read"(%arg2, %49, %46, %7) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<32x32xf32>, index, index, f32) -> vector<4x16xf32>
      %51 = "affine.apply"(%47) <{map = #map5}> : (index) -> index
      %52 = "vector.transfer_read"(%arg2, %51, %46, %7) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<32x32xf32>, index, index, f32) -> vector<4x16xf32>
      %53 = "affine.apply"(%47) <{map = #map6}> : (index) -> index
      %54 = "vector.transfer_read"(%arg2, %53, %46, %7) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<32x32xf32>, index, index, f32) -> vector<4x16xf32>
      %55 = "vector.extract_strided_slice"(%arg5) <{offsets = [0, 0], sizes = [8, 16], strides = [1, 1]}> : (vector<16x16xf32>) -> vector<8x16xf32>
      %56 = "vector.contract"(%28, %48, %55) <{indexing_maps = [#map7, #map8, #map9], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<8x4xf32>, vector<4x16xf32>, vector<8x16xf32>) -> vector<8x16xf32>
      %57 = "vector.extract_strided_slice"(%arg5) <{offsets = [8, 0], sizes = [8, 16], strides = [1, 1]}> : (vector<16x16xf32>) -> vector<8x16xf32>
      %58 = "vector.contract"(%36, %48, %57) <{indexing_maps = [#map7, #map8, #map9], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<8x4xf32>, vector<4x16xf32>, vector<8x16xf32>) -> vector<8x16xf32>
      %59 = "vector.contract"(%30, %50, %56) <{indexing_maps = [#map7, #map8, #map9], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<8x4xf32>, vector<4x16xf32>, vector<8x16xf32>) -> vector<8x16xf32>
      %60 = "vector.contract"(%39, %50, %58) <{indexing_maps = [#map7, #map8, #map9], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<8x4xf32>, vector<4x16xf32>, vector<8x16xf32>) -> vector<8x16xf32>
      %61 = "vector.contract"(%32, %52, %59) <{indexing_maps = [#map7, #map8, #map9], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<8x4xf32>, vector<4x16xf32>, vector<8x16xf32>) -> vector<8x16xf32>
      %62 = "vector.contract"(%42, %52, %60) <{indexing_maps = [#map7, #map8, #map9], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<8x4xf32>, vector<4x16xf32>, vector<8x16xf32>) -> vector<8x16xf32>
      %63 = "vector.contract"(%34, %54, %61) <{indexing_maps = [#map7, #map8, #map9], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<8x4xf32>, vector<4x16xf32>, vector<8x16xf32>) -> vector<8x16xf32>
      %64 = "vector.contract"(%45, %54, %62) <{indexing_maps = [#map7, #map8, #map9], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<8x4xf32>, vector<4x16xf32>, vector<8x16xf32>) -> vector<8x16xf32>
      %65 = "vector.insert_strided_slice"(%63, %2) <{offsets = [0, 0], strides = [1, 1]}> : (vector<8x16xf32>, vector<16x16xf32>) -> vector<16x16xf32>
      %66 = "vector.insert_strided_slice"(%64, %65) <{offsets = [8, 0], strides = [1, 1]}> : (vector<8x16xf32>, vector<16x16xf32>) -> vector<16x16xf32>
      "scf.yield"(%66) : (vector<16x16xf32>) -> ()
    }) : (index, index, index, vector<16x16xf32>) -> vector<16x16xf32>
    %16 = "affine.apply"(%1, %13) <{map = #map3}> : (index, index) -> index
    %17 = "affine.apply"(%1, %14) <{map = #map3}> : (index, index) -> index
    %18 = "vector.extract_strided_slice"(%15) <{offsets = [0, 0], sizes = [8, 16], strides = [1, 1]}> : (vector<16x16xf32>) -> vector<8x16xf32>
    "vector.transfer_write"(%18, %arg3, %16, %17) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map2}> : (vector<8x16xf32>, memref<32x32xf32>, index, index) -> ()
    %19 = "vector.extract_strided_slice"(%15) <{offsets = [8, 0], sizes = [8, 16], strides = [1, 1]}> : (vector<16x16xf32>) -> vector<8x16xf32>
    %20 = "affine.apply"(%16) <{map = #map5}> : (index) -> index
    "vector.transfer_write"(%19, %arg3, %20, %17) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map2}> : (vector<8x16xf32>, memref<32x32xf32>, index, index) -> ()
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

