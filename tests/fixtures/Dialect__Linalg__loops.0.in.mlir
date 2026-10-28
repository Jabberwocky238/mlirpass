#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
#map4 = affine_map<(d0, d1) -> (d1)>
#map5 = affine_map<(d0, d1) -> (d0)>
#map6 = affine_map<(d0) -> (d0)>
#map7 = affine_map<(d0) -> ()>
#map8 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map9 = affine_map<(d0, d1, d2) -> (d0, d2, d1)>
#map10 = affine_map<(d0, d1) -> ()>
#map11 = affine_map<() -> ()>
#map12 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map13 = affine_map<(d0, d1, d2, d3) -> (d0, d3, d2)>
#map14 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
#map15 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2)>
#map16 = affine_map<(d0, d1) -> (d0 + d1)>
#map17 = affine_map<(d0, d1, d2, d3) -> (d0 + d2, d1 + d3)>
#map18 = affine_map<(d0, d1, d2, d3) -> (d2, d3)>
#map19 = affine_map<(d0, d1, d2, d3) -> (d0, d1)>
#map20 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0 + d3, d1 + d4, d2 + d5)>
#map21 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d3, d4, d5)>
#map22 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi8>, index, index, index) -> (), sym_name = "matmul"}> ({
  ^bb0(%arg129: memref<?xi8>, %arg130: index, %arg131: index, %arg132: index):
    %56 = "arith.constant"() <{value = 0 : index}> : () -> index
    %57 = "arith.constant"() <{value = 1 : index}> : () -> index
    %58 = "memref.view"(%arg129, %56, %arg130, %arg132) : (memref<?xi8>, index, index, index) -> memref<?x?xf32>
    %59 = "memref.view"(%arg129, %56, %arg132, %arg131) : (memref<?xi8>, index, index, index) -> memref<?x?xf32>
    %60 = "memref.view"(%arg129, %56, %arg130, %arg131) : (memref<?xi8>, index, index, index) -> memref<?x?xf32>
    "linalg.matmul"(%58, %59, %60) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg133: f32, %arg134: f32, %arg135: f32):
      %61 = "arith.mulf"(%arg133, %arg134) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %62 = "arith.addf"(%arg135, %61) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%62) : (f32) -> ()
    }) : (memref<?x?xf32>, memref<?x?xf32>, memref<?x?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi8>, index, index) -> (), sym_name = "matvec"}> ({
  ^bb0(%arg123: memref<?xi8>, %arg124: index, %arg125: index):
    %49 = "arith.constant"() <{value = 0 : index}> : () -> index
    %50 = "arith.constant"() <{value = 1 : index}> : () -> index
    %51 = "memref.view"(%arg123, %49, %arg124, %arg125) : (memref<?xi8>, index, index, index) -> memref<?x?xf32>
    %52 = "memref.view"(%arg123, %49, %arg124) : (memref<?xi8>, index, index) -> memref<?xf32>
    %53 = "memref.view"(%arg123, %49, %arg125) : (memref<?xi8>, index, index) -> memref<?xf32>
    "linalg.matvec"(%51, %52, %53) <{operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg126: f32, %arg127: f32, %arg128: f32):
      %54 = "arith.mulf"(%arg126, %arg127) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %55 = "arith.addf"(%arg128, %54) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%55) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map3, #map4, #map5]} : (memref<?x?xf32>, memref<?xf32>, memref<?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi8>, index) -> (), sym_name = "dot"}> ({
  ^bb0(%arg118: memref<?xi8>, %arg119: index):
    %42 = "arith.constant"() <{value = 0 : index}> : () -> index
    %43 = "arith.constant"() <{value = 1 : index}> : () -> index
    %44 = "memref.view"(%arg118, %42, %arg119) : (memref<?xi8>, index, index) -> memref<?xf32>
    %45 = "memref.view"(%arg118, %42, %arg119) : (memref<?xi8>, index, index) -> memref<?xf32>
    %46 = "memref.view"(%arg118, %42) : (memref<?xi8>, index) -> memref<f32>
    "linalg.dot"(%44, %45, %46) <{operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg120: f32, %arg121: f32, %arg122: f32):
      %47 = "arith.mulf"(%arg120, %arg121) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %48 = "arith.addf"(%arg122, %47) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%48) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map6, #map6, #map7]} : (memref<?xf32>, memref<?xf32>, memref<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi32>, memref<?xi32>, memref<i32>) -> (), sym_name = "dot_int"}> ({
  ^bb0(%arg112: memref<?xi32>, %arg113: memref<?xi32>, %arg114: memref<i32>):
    "linalg.dot"(%arg112, %arg113, %arg114) <{operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg115: i32, %arg116: i32, %arg117: i32):
      %40 = "arith.muli"(%arg115, %arg116) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %41 = "arith.addi"(%arg117, %40) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%41) : (i32) -> ()
    }) {linalg.memoized_indexing_maps = [#map6, #map6, #map7]} : (memref<?xi32>, memref<?xi32>, memref<i32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi1>, memref<?xi1>, memref<i1>) -> (), sym_name = "dot_bool"}> ({
  ^bb0(%arg106: memref<?xi1>, %arg107: memref<?xi1>, %arg108: memref<i1>):
    "linalg.dot"(%arg106, %arg107, %arg108) <{operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg109: i1, %arg110: i1, %arg111: i1):
      %38 = "arith.andi"(%arg109, %arg110) : (i1, i1) -> i1
      %39 = "arith.ori"(%arg111, %38) : (i1, i1) -> i1
      "linalg.yield"(%39) : (i1) -> ()
    }) {linalg.memoized_indexing_maps = [#map6, #map6, #map7]} : (memref<?xi1>, memref<?xi1>, memref<i1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1], offset: ?>>, memref<f32>) -> (), sym_name = "dot_view"}> ({
  ^bb0(%arg100: memref<?xf32, strided<[1], offset: ?>>, %arg101: memref<?xf32, strided<[1], offset: ?>>, %arg102: memref<f32>):
    "linalg.dot"(%arg100, %arg101, %arg102) <{operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg103: f32, %arg104: f32, %arg105: f32):
      %36 = "arith.mulf"(%arg103, %arg104) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %37 = "arith.addf"(%arg105, %36) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%37) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map6, #map6, #map7]} : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1], offset: ?>>, memref<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, strided<[1], offset: ?>>, f32) -> (), sym_name = "fill_view"}> ({
  ^bb0(%arg96: memref<?xf32, strided<[1], offset: ?>>, %arg97: f32):
    "linalg.fill"(%arg97, %arg96) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg98: f32, %arg99: f32):
      "linalg.yield"(%arg98) : (f32) -> ()
    }) : (f32, memref<?xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32>, f32) -> (), sym_name = "fill_view0"}> ({
  ^bb0(%arg92: memref<f32>, %arg93: f32):
    "linalg.fill"(%arg93, %arg92) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg94: f32, %arg95: f32):
      "linalg.yield"(%arg94) : (f32) -> ()
    }) : (f32, memref<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, f32) -> (), sym_name = "fill_view3"}> ({
  ^bb0(%arg88: memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, %arg89: f32):
    "linalg.fill"(%arg89, %arg88) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg90: f32, %arg91: f32):
      "linalg.yield"(%arg90) : (f32) -> ()
    }) : (f32, memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1], offset: ?>>) -> (), sym_name = "copy_view"}> ({
  ^bb0(%arg84: memref<?xf32, strided<[1], offset: ?>>, %arg85: memref<?xf32, strided<[1], offset: ?>>):
    "linalg.generic"(%arg84, %arg85) <{indexing_maps = [#map6, #map6], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg86: f32, %arg87: f32):
      "linalg.yield"(%arg86) : (f32) -> ()
    }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf32, strided<[?, 1], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) -> (), sym_name = "generic_region"}> ({
  ^bb0(%arg78: memref<?x?xf32, strided<[?, 1], offset: ?>>, %arg79: memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, %arg80: memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>):
    "linalg.generic"(%arg78, %arg79, %arg80) <{doc = "B(i,j,k), C(i,k,j) = foo(A(i, j), B(i,j,k), C(i,k,j))", indexing_maps = [#map2, #map8, #map9], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], library_call = "some_external_function_name_2", operandSegmentSizes = array<i32: 1, 2>}> ({
    ^bb0(%arg81: f32, %arg82: f32, %arg83: f32):
      %34 = "arith.mulf"(%arg81, %arg82) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %35 = "arith.addf"(%arg83, %34) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%34, %35) : (f32, f32) -> ()
    }) : (memref<?x?xf32, strided<[?, 1], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf32, strided<[?, 1], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) -> (), sym_name = "generic_index_region"}> ({
  ^bb0(%arg72: memref<?x?xf32, strided<[?, 1], offset: ?>>, %arg73: memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, %arg74: memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>):
    "linalg.generic"(%arg72, %arg73, %arg74) <{doc = "B(i,j,k), C(i,k,j) = foo(A(i, j) * B(i,j,k), i * j * k + C(i,k,j))", indexing_maps = [#map2, #map8, #map9], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], library_call = "some_external_function_name_2", operandSegmentSizes = array<i32: 1, 2>}> ({
    ^bb0(%arg75: f32, %arg76: f32, %arg77: f32):
      %25 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %26 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %27 = "linalg.index"() <{dim = 2 : i64}> : () -> index
      %28 = "arith.mulf"(%arg75, %arg76) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %29 = "arith.addi"(%25, %26) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %30 = "arith.addi"(%29, %27) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %31 = "arith.index_cast"(%30) : (index) -> i32
      %32 = "arith.sitofp"(%31) : (i32) -> f32
      %33 = "arith.addf"(%arg77, %32) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%28, %33) : (f32, f32) -> ()
    }) : (memref<?x?xf32, strided<[?, 1], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32>, memref<3x4xf32>) -> (), sym_name = "generic_op_zero_rank"}> ({
  ^bb0(%arg68: memref<f32>, %arg69: memref<3x4xf32>):
    "linalg.generic"(%arg68, %arg69) <{indexing_maps = [#map10, #map3], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], library_call = "some_broadcast_external_fn", operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg70: f32, %arg71: f32):
      "linalg.yield"(%arg70) : (f32) -> ()
    }) : (memref<f32>, memref<3x4xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, memref<3x4xf32>) -> (), sym_name = "generic_op_scalar"}> ({
  ^bb0(%arg64: f32, %arg65: memref<3x4xf32>):
    "linalg.generic"(%arg64, %arg65) <{indexing_maps = [#map10, #map3], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], library_call = "some_broadcast_external_fn", operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg66: f32, %arg67: f32):
      "linalg.yield"(%arg66) : (f32) -> ()
    }) : (f32, memref<3x4xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i32>, memref<3x4xi32>) -> (), sym_name = "generic_index_op_zero_rank"}> ({
  ^bb0(%arg60: memref<i32>, %arg61: memref<3x4xi32>):
    "linalg.generic"(%arg60, %arg61) <{indexing_maps = [#map10, #map3], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], library_call = "some_broadcast_external_fn", operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg62: i32, %arg63: i32):
      %20 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %21 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %22 = "arith.addi"(%20, %21) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %23 = "arith.index_cast"(%22) : (index) -> i32
      %24 = "arith.addi"(%arg62, %23) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%24) : (i32) -> ()
    }) : (memref<i32>, memref<3x4xi32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, memref<f32>) -> (), sym_name = "generic_op_1D_reduce"}> ({
  ^bb0(%arg56: memref<?xf32>, %arg57: memref<f32>):
    "linalg.generic"(%arg56, %arg57) <{indexing_maps = [#map6, #map7], iterator_types = [#linalg.iterator_type<reduction>], library_call = "some_reduce_external_fn", operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg58: f32, %arg59: f32):
      %19 = "arith.addf"(%arg58, %arg59) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%19) : (f32) -> ()
    }) : (memref<?xf32>, memref<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, memref<f32>, memref<f32>) -> (), sym_name = "generic_index_op_1D_reduce"}> ({
  ^bb0(%arg50: memref<?xf32>, %arg51: memref<f32>, %arg52: memref<f32>):
    "linalg.generic"(%arg50, %arg51, %arg52) <{indexing_maps = [#map6, #map7, #map7], iterator_types = [#linalg.iterator_type<reduction>], library_call = "some_reduce_external_fn", operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg53: f32, %arg54: f32, %arg55: f32):
      %14 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %15 = "arith.constant"() <{value = 0 : index}> : () -> index
      %16 = "arith.cmpi"(%15, %14) <{predicate = 0 : i64}> : (index, index) -> i1
      %17 = "arith.select"(%16, %arg54, %arg55) : (i1, f32, f32) -> f32
      %18 = "arith.addf"(%arg53, %17) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%18) : (f32) -> ()
    }) : (memref<?xf32>, memref<f32>, memref<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>) -> (), sym_name = "generic_const_init"}> ({
  ^bb0(%arg48: memref<?xf32>):
    %13 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    "linalg.generic"(%arg48) <{indexing_maps = [#map6], iterator_types = [#linalg.iterator_type<parallel>], library_call = "some_external_fn", operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg49: f32):
      "linalg.yield"(%13) : (f32) -> ()
    }) : (memref<?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32>, memref<f32>, memref<f32>, i1) -> (), sym_name = "scalar_code"}> ({
  ^bb0(%arg41: memref<f32>, %arg42: memref<f32>, %arg43: memref<f32>, %arg44: i1):
    "linalg.generic"(%arg41, %arg42, %arg43) <{indexing_maps = [#map11, #map11, #map11], iterator_types = [], library_call = "some_external_fn", operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg45: f32, %arg46: f32, %arg47: f32):
      %12 = "scf.if"(%arg44) ({
        "scf.yield"(%arg45) : (f32) -> ()
      }, {
        "scf.yield"(%arg46) : (f32) -> ()
      }) : (i1) -> f32
      "linalg.yield"(%12) : (f32) -> ()
    }) : (memref<f32>, memref<f32>, memref<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?x?xf32>, memref<?x?x?xf32>, memref<?x?xf32>) -> (), sym_name = "batch_reduce_matmul_as_contract"}> ({
  ^bb0(%arg35: memref<?x?x?xf32>, %arg36: memref<?x?x?xf32>, %arg37: memref<?x?xf32>):
    "linalg.contract"(%arg35, %arg36, %arg37) <{indexing_maps = [#map12, #map13, #map14], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg38: f32, %arg39: f32, %arg40: f32):
      %10 = "arith.mulf"(%arg38, %arg39) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %11 = "arith.addf"(%arg40, %10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%11) : (f32) -> ()
    }) : (memref<?x?x?xf32>, memref<?x?x?xf32>, memref<?x?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?x?xf32>, memref<?x?x?xf32>, memref<?x?x?xf32>) -> (), sym_name = "named_batch_matmul"}> ({
  ^bb0(%arg29: memref<?x?x?xf32>, %arg30: memref<?x?x?xf32>, %arg31: memref<?x?x?xf32>):
    "linalg.batch_matmul"(%arg29, %arg30, %arg31) <{indexing_maps = [#map12, #map13, #map15], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg32: f32, %arg33: f32, %arg34: f32):
      %8 = "arith.mulf"(%arg32, %arg33) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %9 = "arith.addf"(%arg34, %8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%9) : (f32) -> ()
    }) : (memref<?x?x?xf32>, memref<?x?x?xf32>, memref<?x?x?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>) -> (), sym_name = "conv1d_no_symbols"}> ({
  ^bb0(%arg23: memref<?xf32>, %arg24: memref<?xf32>, %arg25: memref<?xf32>):
    "linalg.conv_1d"(%arg23, %arg24, %arg25) <{operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: f32, %arg27: f32, %arg28: f32):
      %6 = "arith.mulf"(%arg26, %arg27) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %7 = "arith.addf"(%arg28, %6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%7) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map16, #map4, #map5]} : (memref<?xf32>, memref<?xf32>, memref<?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf32>, memref<?x?xf32>, memref<?x?xf32>) -> (), sym_name = "conv2d_no_symbols"}> ({
  ^bb0(%arg17: memref<?x?xf32>, %arg18: memref<?x?xf32>, %arg19: memref<?x?xf32>):
    "linalg.conv_2d"(%arg17, %arg18, %arg19) <{operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg20: f32, %arg21: f32, %arg22: f32):
      %4 = "arith.mulf"(%arg20, %arg21) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %5 = "arith.addf"(%arg22, %4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%5) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map17, #map18, #map19]} : (memref<?x?xf32>, memref<?x?xf32>, memref<?x?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?x?xf32>, memref<?x?x?xf32>, memref<?x?x?xf32>) -> (), sym_name = "conv3d_no_symbols"}> ({
  ^bb0(%arg11: memref<?x?x?xf32>, %arg12: memref<?x?x?xf32>, %arg13: memref<?x?x?xf32>):
    "linalg.conv_3d"(%arg11, %arg12, %arg13) <{operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32, %arg16: f32):
      %2 = "arith.mulf"(%arg14, %arg15) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %3 = "arith.addf"(%arg16, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%3) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map20, #map21, #map22]} : (memref<?x?x?xf32>, memref<?x?x?xf32>, memref<?x?x?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi32>, memref<?x?xi32>, index, index, index) -> (), sym_name = "lower_to_loops_with_rank_reducing_subviews"}> ({
  ^bb0(%arg4: memref<?xi32>, %arg5: memref<?x?xi32>, %arg6: index, %arg7: index, %arg8: index):
    %0 = "memref.subview"(%arg4, %arg6, %arg7) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xi32>, index, index) -> memref<?xi32, strided<[1], offset: ?>>
    %1 = "memref.subview"(%arg5, %arg8, %arg7) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: 1, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<?x?xi32>, index, index) -> memref<?xi32, strided<[1], offset: ?>>
    "linalg.generic"(%0, %1) <{indexing_maps = [#map6, #map6], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: i32, %arg10: i32):
      "linalg.yield"(%arg9) : (i32) -> ()
    }) : (memref<?xi32, strided<[1], offset: ?>>, memref<?xi32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>) -> (), sym_name = "transpose"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>):
    "linalg.transpose"(%arg0, %arg1) <{permutation = array<i64: 0>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (memref<?xf32>, memref<?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

