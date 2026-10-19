#map = affine_map<() -> (3)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<() -> (10)>
#map3 = affine_map<()[s0] -> (s0)>
#map4 = affine_map<() -> (8)>
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "test_subi_zero"}> ({
  ^bb0(%arg62: i32):
    %46 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%46) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> vector<4xi32>, sym_name = "test_subi_zero_vector"}> ({
  ^bb0(%arg61: vector<4xi32>):
    %45 = "arith.constant"() <{value = dense<0> : vector<4xi32>}> : () -> vector<4xi32>
    "func.return"(%45) : (vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x5xi32>) -> tensor<4x5xi32>, sym_name = "test_subi_zero_tensor"}> ({
  ^bb0(%arg60: tensor<4x5xi32>):
    %44 = "arith.constant"() <{value = dense<0> : tensor<4x5xi32>}> : () -> tensor<4x5xi32>
    "func.return"(%44) : (tensor<4x5xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<8x4xf32>) -> index, sym_name = "dim"}> ({
  ^bb0(%arg59: tensor<8x4xf32>):
    %43 = "arith.constant"() <{value = 4 : index}> : () -> index
    "func.return"(%43) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "test_commutative"}> ({
  ^bb0(%arg58: i32):
    %40 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    %41 = "arith.addi"(%arg58, %40) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %42 = "arith.subi"(%40, %arg58) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%41, %42) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<8x4xf32>) -> (), sym_name = "trivial_dce"}> ({
  ^bb0(%arg57: tensor<8x4xf32>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "load_dce"}> ({
  ^bb0(%arg56: index):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "addi_zero"}> ({
  ^bb0(%arg55: i32):
    "func.return"(%arg55) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "addi_zero_index"}> ({
  ^bb0(%arg54: index):
    "func.return"(%arg54) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> vector<4xi32>, sym_name = "addi_zero_vector"}> ({
  ^bb0(%arg53: vector<4xi32>):
    "func.return"(%arg53) : (vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x5xi32>) -> tensor<4x5xi32>, sym_name = "addi_zero_tensor"}> ({
  ^bb0(%arg52: tensor<4x5xi32>):
    "func.return"(%arg52) : (tensor<4x5xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "muli_zero"}> ({
  ^bb0(%arg51: i32):
    %39 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%39) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "muli_zero_index"}> ({
  ^bb0(%arg50: index):
    %38 = "arith.constant"() <{value = 0 : index}> : () -> index
    "func.return"(%38) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> vector<4xi32>, sym_name = "muli_zero_vector"}> ({
  ^bb0(%arg49: vector<4xi32>):
    %37 = "arith.constant"() <{value = dense<0> : vector<4xi32>}> : () -> vector<4xi32>
    "func.return"(%37) : (vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x5xi32>) -> tensor<4x5xi32>, sym_name = "muli_zero_tensor"}> ({
  ^bb0(%arg48: tensor<4x5xi32>):
    %36 = "arith.constant"() <{value = dense<0> : tensor<4x5xi32>}> : () -> tensor<4x5xi32>
    "func.return"(%36) : (tensor<4x5xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "muli_one"}> ({
  ^bb0(%arg47: i32):
    "func.return"(%arg47) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "muli_one_index"}> ({
  ^bb0(%arg46: index):
    "func.return"(%arg46) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> vector<4xi32>, sym_name = "muli_one_vector"}> ({
  ^bb0(%arg45: vector<4xi32>):
    "func.return"(%arg45) : (vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x5xi32>) -> tensor<4x5xi32>, sym_name = "muli_one_tensor"}> ({
  ^bb0(%arg44: tensor<4x5xi32>):
    "func.return"(%arg44) : (tensor<4x5xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "and_self"}> ({
  ^bb0(%arg43: i32):
    "func.return"(%arg43) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> vector<4xi32>, sym_name = "and_self_vector"}> ({
  ^bb0(%arg42: vector<4xi32>):
    "func.return"(%arg42) : (vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x5xi32>) -> tensor<4x5xi32>, sym_name = "and_self_tensor"}> ({
  ^bb0(%arg41: tensor<4x5xi32>):
    "func.return"(%arg41) : (tensor<4x5xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "and_zero"}> ({
  ^bb0(%arg40: i32):
    %35 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%35) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "and_zero_index"}> ({
  ^bb0(%arg39: index):
    %34 = "arith.constant"() <{value = 0 : index}> : () -> index
    "func.return"(%34) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> vector<4xi32>, sym_name = "and_zero_vector"}> ({
  ^bb0(%arg38: vector<4xi32>):
    %33 = "arith.constant"() <{value = dense<0> : vector<4xi32>}> : () -> vector<4xi32>
    "func.return"(%33) : (vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x5xi32>) -> tensor<4x5xi32>, sym_name = "and_zero_tensor"}> ({
  ^bb0(%arg37: tensor<4x5xi32>):
    %32 = "arith.constant"() <{value = dense<0> : tensor<4x5xi32>}> : () -> tensor<4x5xi32>
    "func.return"(%32) : (tensor<4x5xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "or_self"}> ({
  ^bb0(%arg36: i32):
    "func.return"(%arg36) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> vector<4xi32>, sym_name = "or_self_vector"}> ({
  ^bb0(%arg35: vector<4xi32>):
    "func.return"(%arg35) : (vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x5xi32>) -> tensor<4x5xi32>, sym_name = "or_self_tensor"}> ({
  ^bb0(%arg34: tensor<4x5xi32>):
    "func.return"(%arg34) : (tensor<4x5xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "or_zero"}> ({
  ^bb0(%arg33: i32):
    "func.return"(%arg33) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "or_zero_index"}> ({
  ^bb0(%arg32: index):
    "func.return"(%arg32) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> vector<4xi32>, sym_name = "or_zero_vector"}> ({
  ^bb0(%arg31: vector<4xi32>):
    "func.return"(%arg31) : (vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x5xi32>) -> tensor<4x5xi32>, sym_name = "or_zero_tensor"}> ({
  ^bb0(%arg30: tensor<4x5xi32>):
    "func.return"(%arg30) : (tensor<4x5xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i4) -> (i1, i4), sym_name = "or_all_ones"}> ({
  ^bb0(%arg28: i1, %arg29: i4):
    %30 = "arith.constant"() <{value = true}> : () -> i1
    %31 = "arith.constant"() <{value = -1 : i4}> : () -> i4
    "func.return"(%30, %31) : (i1, i4) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "xor_self"}> ({
  ^bb0(%arg27: i32):
    %29 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%29) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> vector<4xi32>, sym_name = "xor_self_vector"}> ({
  ^bb0(%arg26: vector<4xi32>):
    %28 = "arith.constant"() <{value = dense<0> : vector<4xi32>}> : () -> vector<4xi32>
    "func.return"(%28) : (vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x5xi32>) -> tensor<4x5xi32>, sym_name = "xor_self_tensor"}> ({
  ^bb0(%arg25: tensor<4x5xi32>):
    %27 = "arith.constant"() <{value = dense<0> : tensor<4x5xi32>}> : () -> tensor<4x5xi32>
    "func.return"(%27) : (tensor<4x5xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xf32>, f32) -> (f32, f32), sym_name = "memref_cast_folding"}> ({
  ^bb0(%arg23: memref<4xf32>, %arg24: f32):
    %24 = "arith.constant"() <{value = 0 : index}> : () -> index
    %25 = "affine.load"(%arg23) <{map = #map}> : (memref<4xf32>) -> f32
    "memref.store"(%arg24, %arg23, %24) : (f32, memref<4xf32>, index) -> ()
    %26 = "memref.load"(%arg23, %24) : (memref<4xf32>, index) -> f32
    "memref.dealloc"(%arg23) : (memref<4xf32>) -> ()
    "func.return"(%25, %26) : (f32, f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<42x42xf64>) -> (), sym_name = "fold_memref_cast_in_memref_cast"}> ({
  ^bb0(%arg22: memref<42x42xf64>):
    %23 = "memref.cast"(%arg22) : (memref<42x42xf64>) -> memref<?x?xf64>
    "test.user"(%23) : (memref<?x?xf64>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<42x42xf64>) -> (), sym_name = "fold_memref_cast_chain"}> ({
  ^bb0(%arg21: memref<42x42xf64>):
    "test.user"(%arg21) : (memref<42x42xf64>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "dead_alloc_fold"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "dead_dealloc_fold"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "dead_dealloc_fold_multi_use"}> ({
  ^bb0(%arg20: i1):
    "cf.cond_br"(%arg20)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"() : () -> ()
  ^bb2:  // pred: ^bb0
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> (), sym_name = "write_only_alloc_fold"}> ({
  ^bb0(%arg19: f32):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> (), sym_name = "write_only_alloca_fold"}> ({
  ^bb0(%arg18: f32):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "dead_block_elim"}> ({
    "builtin.module"() ({
      "func.func"() <{function_type = () -> (), sym_name = "nested"}> ({
        "func.return"() : () -> ()
      }) : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> (memref<4x?x8x?x?xf32>, memref<?x?xi32>, memref<?x?xf32>, memref<4x?x8x?x?xf32>), sym_name = "dyn_shape_fold"}> ({
  ^bb0(%arg14: index, %arg15: index):
    %12 = "arith.constant"() <{value = 0 : index}> : () -> index
    %13 = "memref.alloc"(%arg14) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?x1024xf32>
    %14 = "memref.alloc"(%arg15) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<4x1024x8x512x?xf32>
    %15 = "memref.cast"(%14) : (memref<4x1024x8x512x?xf32>) -> memref<4x?x8x?x?xf32>
    %16 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512x1024xi32>
    %17 = "memref.cast"(%16) : (memref<512x1024xi32>) -> memref<?x?xi32>
    %18 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<9x9xf32>
    %19 = "memref.cast"(%18) : (memref<9x9xf32>) -> memref<?x?xf32>
    %20 = "memref.alloca"(%arg15) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<4x1024x8x512x?xf32>
    %21 = "memref.cast"(%20) : (memref<4x1024x8x512x?xf32>) -> memref<4x?x8x?x?xf32>
    "affine.for"(%arg14) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map3}> ({
    ^bb0(%arg16: index):
      "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map2}> ({
      ^bb0(%arg17: index):
        %22 = "memref.load"(%13, %arg16, %arg17) : (memref<?x1024xf32>, index, index) -> f32
        "memref.store"(%22, %14, %12, %12, %arg16, %arg17, %12) : (f32, memref<4x1024x8x512x?xf32>, index, index, index, index, index) -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "affine.yield"() : () -> ()
    }) : (index) -> ()
    "func.return"(%15, %17, %19, %21) : (memref<4x?x8x?x?xf32>, memref<?x?xi32>, memref<?x?xf32>, memref<4x?x8x?x?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index, memref<?xi8>, index, index, index) -> (), sym_name = "dim_op_fold"}> ({
  ^bb0(%arg3: index, %arg4: index, %arg5: index, %arg6: memref<?xi8>, %arg7: index, %arg8: index, %arg9: index):
    %11 = "arith.constant"() <{value = 1 : index}> : () -> index
    "affine.for"(%arg5) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map3}> ({
    ^bb0(%arg10: index):
      "affine.for"(%arg3) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map3}> ({
      ^bb0(%arg11: index):
        "affine.for"(%arg3, %arg3) <{lowerBoundMap = #map3, operandSegmentSizes = array<i32: 1, 1, 0>, step = 1 : index, upperBoundMap = #map3}> ({
        ^bb0(%arg13: index):
          "foo"() : () -> ()
          "affine.yield"() : () -> ()
        }) : (index, index) -> ()
        "scf.for"(%arg3, %arg11, %11) ({
        ^bb0(%arg12: index):
          "foo"() : () -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        "affine.yield"() : () -> ()
      }) : (index) -> ()
      "affine.yield"() : () -> ()
    }) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (index, index), sym_name = "merge_constants"}> ({
    %10 = "arith.constant"() <{value = 42 : index}> : () -> index
    "func.return"(%10, %10) : (index, index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<8xi32>) -> (), sym_name = "hoist_constant"}> ({
  ^bb0(%arg1: memref<8xi32>):
    %9 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map4}> ({
    ^bb0(%arg2: index):
      "memref.store"(%9, %arg1, %arg2) : (i32, memref<8xi32>, index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<?x?xf32>, sym_name = "const_fold_propagate"}> ({
    %7 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x32xf32>
    %8 = "memref.cast"(%7) : (memref<64x32xf32>) -> memref<?x?xf32>
    "func.return"(%8) : (memref<?x?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "indirect_target"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "indirect_call_folding"}> ({
    "func.call"() <{callee = @indirect_target}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (index, index), sym_name = "lowered_affine_mod"}> ({
    %5 = "arith.constant"() <{value = 41 : index}> : () -> index
    %6 = "arith.constant"() <{value = 1 : index}> : () -> index
    "func.return"(%5, %6) : (index, index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (index, index), sym_name = "lowered_affine_floordiv"}> ({
    %3 = "arith.constant"() <{value = -2 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    "func.return"(%3, %4) : (index, index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (index, index), sym_name = "lowered_affine_ceildiv"}> ({
    %1 = "arith.constant"() <{value = -1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    "func.return"(%1, %2) : (index, index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi32>) -> memref<2xi32>, sym_name = "cast_values"}> ({
  ^bb0(%arg0: memref<?xi32>):
    %0 = "memref.cast"(%arg0) : (memref<?xi32>) -> memref<2xi32>
    "func.return"(%0) : (memref<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (f32, f32, f32, f32), sym_name = "view"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 15 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2048xi8>
    %3 = "memref.view"(%2, %0) : (memref<2048xi8>, index) -> memref<7x11xf32>
    %4 = "memref.load"(%3, %1, %1) : (memref<7x11xf32>, index, index) -> f32
    %5 = "memref.view"(%2, %0, %arg0, %arg0) : (memref<2048xi8>, index, index, index) -> memref<?x?x7xf32>
    %6 = "memref.load"(%5, %1, %1, %1) : (memref<?x?x7xf32>, index, index, index) -> f32
    %7 = "memref.view"(%2, %0) : (memref<2048xi8>, index) -> memref<7x4xf32>
    %8 = "memref.load"(%7, %1, %1) : (memref<7x4xf32>, index, index) -> f32
    %9 = "memref.view"(%2, %0) : (memref<2048xi8>, index) -> memref<15x7xf32>
    %10 = "memref.load"(%9, %1, %1) : (memref<15x7xf32>, index, index) -> f32
    "func.return"(%4, %6, %8, %10) : (f32, f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<() -> (100)>
#set = affine_set<(d0) : (d0 - 2 >= 0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (index, index), sym_name = "subview"}> ({
  ^bb0(%arg4: index, %arg5: index):
    %3 = "arith.constant"() <{value = 11 : index}> : () -> index
    %4 = "arith.constant"() <{value = 7 : index}> : () -> index
    %5 = "arith.constant"() <{value = 0 : index}> : () -> index
    %6 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128x96x64xf32, strided<[6144, 64, 1]>>
    %7 = "memref.subview"(%6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 7, 11, 2>, static_strides = array<i64: 1, 1, 1>}> : (memref<128x96x64xf32, strided<[6144, 64, 1]>>) -> memref<7x11x2xf32, strided<[6144, 64, 1]>>
    %8 = "memref.load"(%7, %5, %5, %5) : (memref<7x11x2xf32, strided<[6144, 64, 1]>>, index, index, index) -> f32
    %9 = "memref.subview"(%6, %arg4) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 0, -9223372036854775808, 0>, static_sizes = array<i64: 7, 11, 15>, static_strides = array<i64: 1, 1, 1>}> : (memref<128x96x64xf32, strided<[6144, 64, 1]>>, index) -> memref<7x11x15xf32, strided<[6144, 64, 1], offset: ?>>
    "memref.store"(%8, %9, %5, %5, %5) : (f32, memref<7x11x15xf32, strided<[6144, 64, 1], offset: ?>>, index, index, index) -> ()
    %10 = "memref.alloc"(%arg4) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?x16x4xf32, strided<[64, 4, 1]>>
    %11 = "memref.subview"(%10) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 7, 11, 2>, static_strides = array<i64: 1, 1, 1>}> : (memref<?x16x4xf32, strided<[64, 4, 1]>>) -> memref<7x11x2xf32, strided<[64, 4, 1]>>
    "memref.store"(%8, %11, %5, %5, %5) : (f32, memref<7x11x2xf32, strided<[64, 4, 1]>>, index, index, index) -> ()
    %12 = "memref.subview"(%6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 1, 2, 7>, static_sizes = array<i64: 7, 11, 2>, static_strides = array<i64: 1, 1, 1>}> : (memref<128x96x64xf32, strided<[6144, 64, 1]>>) -> memref<7x11x2xf32, strided<[6144, 64, 1], offset: 6279>>
    "memref.store"(%8, %12, %5, %5, %5) : (f32, memref<7x11x2xf32, strided<[6144, 64, 1], offset: 6279>>, index, index, index) -> ()
    %13 = "memref.subview"(%6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 7, 11, 2>, static_strides = array<i64: 2, 7, 11>}> : (memref<128x96x64xf32, strided<[6144, 64, 1]>>) -> memref<7x11x2xf32, strided<[12288, 448, 11]>>
    "memref.store"(%8, %13, %5, %5, %5) : (f32, memref<7x11x2xf32, strided<[12288, 448, 11]>>, index, index, index) -> ()
    %14 = "memref.subview"(%6, %arg4, %arg4, %arg4, %arg5, %arg5, %arg5) <{operandSegmentSizes = array<i32: 1, 3, 0, 3>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 7, 11, 2>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (memref<128x96x64xf32, strided<[6144, 64, 1]>>, index, index, index, index, index, index) -> memref<7x11x2xf32, strided<[?, ?, ?], offset: ?>>
    "memref.store"(%8, %14, %arg5, %arg5, %arg5) : (f32, memref<7x11x2xf32, strided<[?, ?, ?], offset: ?>>, index, index, index) -> ()
    %15 = "memref.subview"(%6, %arg4, %arg4, %arg4, %arg5, %arg5, %arg5) <{operandSegmentSizes = array<i32: 1, 3, 3, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 2, 7, 11>}> : (memref<128x96x64xf32, strided<[6144, 64, 1]>>, index, index, index, index, index, index) -> memref<?x?x?xf32, strided<[12288, 448, 11], offset: ?>>
    "memref.store"(%8, %15, %arg4, %arg4, %arg4) : (f32, memref<?x?x?xf32, strided<[12288, 448, 11], offset: ?>>, index, index, index) -> ()
    %16 = "memref.subview"(%6, %arg5, %arg5, %arg5, %arg4, %arg4, %arg4) <{operandSegmentSizes = array<i32: 1, 0, 3, 3>, static_offsets = array<i64: 1, 2, 7>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (memref<128x96x64xf32, strided<[6144, 64, 1]>>, index, index, index, index, index, index) -> memref<?x?x?xf32, strided<[?, ?, ?], offset: 6279>>
    "memref.store"(%8, %16, %arg5, %arg5, %arg5) : (f32, memref<?x?x?xf32, strided<[?, ?, ?], offset: 6279>>, index, index, index) -> ()
    %17 = "memref.alloc"(%arg4, %arg4, %arg5) <{operandSegmentSizes = array<i32: 3, 0>}> : (index, index, index) -> memref<?x?x?xf32>
    %18 = "memref.subview"(%17, %arg4, %arg4, %arg4, %arg5, %arg5, %arg5) <{operandSegmentSizes = array<i32: 1, 3, 0, 3>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 7, 11, 2>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (memref<?x?x?xf32>, index, index, index, index, index, index) -> memref<7x11x2xf32, strided<[?, ?, ?], offset: ?>>
    "memref.store"(%8, %18, %arg5, %arg5, %arg5) : (f32, memref<7x11x2xf32, strided<[?, ?, ?], offset: ?>>, index, index, index) -> ()
    %19 = "memref.subview"(%17, %arg4, %arg4, %arg4, %arg5, %arg5, %arg5) <{operandSegmentSizes = array<i32: 1, 3, 3, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 2, 2, 2>}> : (memref<?x?x?xf32>, index, index, index, index, index, index) -> memref<?x?x?xf32, strided<[?, ?, 2], offset: ?>>
    "memref.store"(%8, %19, %arg4, %arg4, %arg4) : (f32, memref<?x?x?xf32, strided<[?, ?, 2], offset: ?>>, index, index, index) -> ()
    %20 = "memref.subview"(%17, %arg4, %arg4, %arg4, %arg5, %arg5, %arg5) <{operandSegmentSizes = array<i32: 1, 0, 3, 3>, static_offsets = array<i64: 1, 1, 1>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (memref<?x?x?xf32>, index, index, index, index, index, index) -> memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    "memref.store"(%8, %20, %arg4, %arg4, %arg4) : (f32, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index, index, index) -> ()
    %21 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128x64xf32>
    %22 = "memref.subview"(%21, %arg5, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 2, 4>, static_strides = array<i64: 1, 1>}> : (memref<128x64xf32>, index, index) -> memref<2x4xf32, strided<[64, 1], offset: ?>>
    "memref.store"(%8, %22, %arg5, %arg5) : (f32, memref<2x4xf32, strided<[64, 1], offset: ?>>, index, index) -> ()
    %23 = "memref.subview"(%21) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 2, 4>, static_sizes = array<i64: 12, 4>, static_strides = array<i64: 1, 1>}> : (memref<128x64xf32>) -> memref<12x4xf32, strided<[64, 1], offset: 132>>
    "memref.store"(%8, %23, %arg5, %arg5) : (f32, memref<12x4xf32, strided<[64, 1], offset: 132>>, index, index) -> ()
    "func.return"(%4, %3) : (index, index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i16) -> i16, sym_name = "index_cast"}> ({
  ^bb0(%arg3: i16):
    "func.return"(%arg3) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i16, index), sym_name = "index_cast_fold"}> ({
    %1 = "arith.constant"() <{value = 4 : i16}> : () -> i16
    %2 = "arith.constant"() <{value = 4 : index}> : () -> index
    "func.return"(%1, %2) : (i16, index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<100xi32>) -> (), sym_name = "remove_dead_else"}> ({
  ^bb0(%arg0: memref<100xi32>):
    "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg1: index):
      "affine.if"(%arg1) <{condition = #set}> ({
        "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map2}> ({
        ^bb0(%arg2: index):
          %0 = "affine.load"(%arg0, %arg2) <{map = #map}> : (memref<100xi32>, index) -> i32
          "prevent.dce"(%0) : (i32) -> ()
          "affine.yield"() : () -> ()
        }) : () -> ()
        "affine.yield"() : () -> ()
      }, {
      }) : (index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "divi_signed_by_one"}> ({
  ^bb0(%arg3: i32):
    "func.return"(%arg3) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "divi_unsigned_by_one"}> ({
  ^bb0(%arg2: i32):
    "func.return"(%arg2) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x5xi32>) -> tensor<4x5xi32>, sym_name = "tensor_divi_signed_by_one"}> ({
  ^bb0(%arg1: tensor<4x5xi32>):
    "func.return"(%arg1) : (tensor<4x5xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x5xi32>) -> tensor<4x5xi32>, sym_name = "tensor_divi_unsigned_by_one"}> ({
  ^bb0(%arg0: tensor<4x5xi32>):
    "func.return"(%arg0) : (tensor<4x5xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "arith.floordivsi_by_one"}> ({
  ^bb0(%arg1: i32):
    "func.return"(%arg1) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x5xi32>) -> tensor<4x5xi32>, sym_name = "tensor_arith.floordivsi_by_one"}> ({
  ^bb0(%arg0: tensor<4x5xi32>):
    "func.return"(%arg0) : (tensor<4x5xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "arith.floordivsi_by_one_overflow"}> ({
    %0 = "arith.constant"() <{value = -1 : i64}> : () -> i64
    %1 = "arith.constant"() <{value = -9223372036854775808 : i64}> : () -> i64
    %2 = "arith.floordivsi"(%1, %0) : (i64, i64) -> i64
    "func.return"(%2) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "arith.ceildivsi_by_one"}> ({
  ^bb0(%arg1: i32):
    "func.return"(%arg1) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x5xi32>) -> tensor<4x5xi32>, sym_name = "tensor_arith.ceildivsi_by_one"}> ({
  ^bb0(%arg0: tensor<4x5xi32>):
    "func.return"(%arg0) : (tensor<4x5xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "arith.ceildivui_by_one"}> ({
  ^bb0(%arg1: i32):
    "func.return"(%arg1) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x5xi32>) -> tensor<4x5xi32>, sym_name = "tensor_arith.ceildivui_by_one"}> ({
  ^bb0(%arg0: tensor<4x5xi32>):
    "func.return"(%arg0) : (tensor<4x5xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x5xf32>, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>, sym_name = "memref_cast_folding_subview"}> ({
  ^bb0(%arg0: memref<4x5xf32>, %arg1: index):
    %0 = "memref.subview"(%arg0, %arg1, %arg1, %arg1, %arg1, %arg1, %arg1) <{operandSegmentSizes = array<i32: 1, 2, 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (memref<4x5xf32>, index, index, index, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
    "func.return"(%0) : (memref<?x?xf32, strided<[?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x16xf32>, index, index) -> memref<3x4xf32, strided<[?, 1]>>, sym_name = "memref_cast_folding_subview_static"}> ({
  ^bb0(%arg0: memref<16x16xf32>, %arg1: index, %arg2: index):
    %0 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 3, 4>, static_strides = array<i64: 1, 1>}> : (memref<16x16xf32>) -> memref<3x4xf32, strided<[16, 1]>>
    %1 = "memref.cast"(%0) : (memref<3x4xf32, strided<[16, 1]>>) -> memref<3x4xf32, strided<[?, 1]>>
    "func.return"(%1) : (memref<3x4xf32, strided<[?, 1]>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<8x16x4xf32>, index, index) -> tensor<?x?x?xf32>, sym_name = "slice"}> ({
  ^bb0(%arg0: tensor<8x16x4xf32>, %arg1: index, %arg2: index):
    %0 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 7, 11, 2>, static_strides = array<i64: 1, 1, 1>}> : (tensor<8x16x4xf32>) -> tensor<7x11x2xf32>
    %1 = "tensor.extract_slice"(%0, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 2, -9223372036854775808, 2>, static_strides = array<i64: 1, 1, 1>}> : (tensor<7x11x2xf32>, index) -> tensor<2x?x2xf32>
    %2 = "tensor.cast"(%1) : (tensor<2x?x2xf32>) -> tensor<?x?x?xf32>
    "func.return"(%2) : (tensor<?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i1, sym_name = "fold_trunci"}> ({
  ^bb0(%arg0: i1):
    "func.return"(%arg0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi1>) -> vector<4xi1>, sym_name = "fold_trunci_vector"}> ({
  ^bb0(%arg0: vector<4xi1>):
    "func.return"(%arg0) : (vector<4xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i2, sym_name = "fold_trunci"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.extui"(%arg0) : (i1) -> i2
    "func.return"(%0) : (i2) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi1>) -> vector<4xi2>, sym_name = "fold_trunci_vector"}> ({
  ^bb0(%arg0: vector<4xi1>):
    %0 = "arith.extui"(%arg0) : (vector<4xi1>) -> vector<4xi2>
    "func.return"(%0) : (vector<4xi2>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i1, sym_name = "fold_trunci_sexti"}> ({
  ^bb0(%arg0: i1):
    "func.return"(%arg0) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<5xf32>, sym_name = "simple_clone_elimination"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32>
    "func.return"(%0) : (memref<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, memref<2xf32>, memref<2xf32>) -> (), sym_name = "clone_loop_alloc"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: memref<2xf32>, %arg4: memref<2xf32>):
    %0 = "bufferization.clone"(%arg3) : (memref<2xf32>) -> memref<2xf32>
    %1 = "scf.for"(%arg0, %arg1, %arg2, %0) ({
    ^bb0(%arg5: index, %arg6: memref<2xf32>):
      "memref.dealloc"(%arg6) : (memref<2xf32>) -> ()
      %2 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf32>
      "scf.yield"(%2) : (memref<2xf32>) -> ()
    }) : (index, index, index, memref<2xf32>) -> memref<2xf32>
    "memref.copy"(%1, %arg4) : (memref<2xf32>, memref<2xf32>) -> ()
    "memref.dealloc"(%1) : (memref<2xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> memref<?x?xf32>, sym_name = "clone_nested_region"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.cmpi"(%arg0, %arg1) <{predicate = 0 : i64}> : (index, index) -> i1
    %1 = "arith.cmpi"(%arg0, %arg1) <{predicate = 0 : i64}> : (index, index) -> i1
    %2 = "memref.alloc"(%arg0, %arg0) <{operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
    %3 = "scf.if"(%1) ({
      %5 = "scf.if"(%0) ({
        %7 = "bufferization.clone"(%2) : (memref<?x?xf32>) -> memref<?x?xf32>
        "scf.yield"(%7) : (memref<?x?xf32>) -> ()
      }, {
        %6 = "memref.alloc"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
        "scf.yield"(%6) : (memref<?x?xf32>) -> ()
      }) : (i1) -> memref<?x?xf32>
      "scf.yield"(%5) : (memref<?x?xf32>) -> ()
    }, {
      %4 = "memref.alloc"(%arg1, %arg1) <{operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
      "scf.yield"(%4) : (memref<?x?xf32>) -> ()
    }) : (i1) -> memref<?x?xf32>
    "memref.dealloc"(%2) : (memref<?x?xf32>) -> ()
    "func.return"(%3) : (memref<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i64, sym_name = "test_materialize_failure"}> ({
    %0 = "index.constant"() <{value = 1234 : index}> : () -> index
    %1 = "index.castu"(%0) : (index) -> i64
    "func.return"(%1) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

