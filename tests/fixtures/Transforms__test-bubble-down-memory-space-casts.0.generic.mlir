#map = affine_map<(d0, d1)[s0] -> (d1 * s0 + d0)>
#map1 = affine_map<(d0, d1) -> (d1, d0)>
#map2 = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, 1>, index) -> (), sym_name = "load_store"}> ({
  ^bb0(%arg35: memref<?xf32, 1>, %arg36: index):
    %48 = "memref.load"(%arg35, %arg36) : (memref<?xf32, 1>, index) -> f32
    "memref.store"(%48, %arg35, %arg36) : (f32, memref<?xf32, 1>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, 1>, index) -> (), sym_name = "load_store_unfoldable"}> ({
  ^bb0(%arg33: memref<?xf32, 1>, %arg34: index):
    %46 = "memref.memory_space_cast"(%arg33) : (memref<?xf32, 1>) -> memref<?xf32, 2>
    %47 = "memref.load"(%46, %arg34) : (memref<?xf32, 2>, index) -> f32
    "memref.store"(%47, %46, %arg34) : (f32, memref<?xf32, 2>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2xf32, 1>, memref<*xf32, 1>) -> (memref<*xf32>, memref<3x2xf32>), sym_name = "cast"}> ({
  ^bb0(%arg31: memref<2xf32, 1>, %arg32: memref<*xf32, 1>):
    %42 = "memref.cast"(%arg31) : (memref<2xf32, 1>) -> memref<*xf32, 1>
    %43 = "memref.memory_space_cast"(%42) : (memref<*xf32, 1>) -> memref<*xf32>
    %44 = "memref.cast"(%arg32) : (memref<*xf32, 1>) -> memref<3x2xf32, 1>
    %45 = "memref.memory_space_cast"(%44) : (memref<3x2xf32, 1>) -> memref<3x2xf32>
    "func.return"(%43, %45) : (memref<*xf32>, memref<3x2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi8, 1>, index, index) -> memref<?x?xi8>, sym_name = "view"}> ({
  ^bb0(%arg28: memref<?xi8, 1>, %arg29: index, %arg30: index):
    %39 = "arith.constant"() <{value = 100 : index}> : () -> index
    %40 = "memref.view"(%arg28, %arg29, %arg30, %39) : (memref<?xi8, 1>, index, index, index) -> memref<?x?xi8, 1>
    %41 = "memref.memory_space_cast"(%40) : (memref<?x?xi8, 1>) -> memref<?x?xi8>
    "func.return"(%41) : (memref<?x?xi8>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf32, 1>, index) -> memref<8x2xf32, strided<[?, 2], offset: ?>>, sym_name = "subview"}> ({
  ^bb0(%arg26: memref<?x?xf32, 1>, %arg27: index):
    %37 = "memref.subview"(%arg26) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 4, 2>, static_sizes = array<i64: 8, 2>, static_strides = array<i64: 3, 2>}> : (memref<?x?xf32, 1>) -> memref<8x2xf32, strided<[?, 2], offset: ?>, 1>
    %38 = "memref.memory_space_cast"(%37) : (memref<8x2xf32, strided<[?, 2], offset: ?>, 1>) -> memref<8x2xf32, strided<[?, 2], offset: ?>>
    "func.return"(%38) : (memref<8x2xf32, strided<[?, 2], offset: ?>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, 1>, index) -> memref<10x?xf32, strided<[?, 1], offset: ?>>, sym_name = "reinterpret_cast"}> ({
  ^bb0(%arg24: memref<?xf32, 1>, %arg25: index):
    %33 = "arith.constant"() <{value = 10 : index}> : () -> index
    %34 = "arith.constant"() <{value = 0 : index}> : () -> index
    %35 = "memref.reinterpret_cast"(%arg24, %34, %33, %33) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 10, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32, 1>, index, index, index) -> memref<10x?xf32, strided<[?, 1], offset: ?>, 1>
    %36 = "memref.memory_space_cast"(%35) : (memref<10x?xf32, strided<[?, 1], offset: ?>, 1>) -> memref<10x?xf32, strided<[?, 1], offset: ?>>
    "func.return"(%36) : (memref<10x?xf32, strided<[?, 1], offset: ?>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf32, 1>, memref<1xindex>) -> memref<?xf32>, sym_name = "reshape"}> ({
  ^bb0(%arg22: memref<?x?xf32, 1>, %arg23: memref<1xindex>):
    %31 = "memref.reshape"(%arg22, %arg23) : (memref<?x?xf32, 1>, memref<1xindex>) -> memref<?xf32, 1>
    %32 = "memref.memory_space_cast"(%31) : (memref<?xf32, 1>) -> memref<?xf32>
    "func.return"(%32) : (memref<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<12xf32, 1>) -> memref<3x4xf32>, sym_name = "expand_shape"}> ({
  ^bb0(%arg21: memref<12xf32, 1>):
    %29 = "memref.expand_shape"(%arg21) <{reassociation = [[0, 1]], static_output_shape = array<i64: 3, 4>}> : (memref<12xf32, 1>) -> memref<3x4xf32, 1>
    %30 = "memref.memory_space_cast"(%29) : (memref<3x4xf32, 1>) -> memref<3x4xf32>
    "func.return"(%30) : (memref<3x4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<3x4xf32, 1>) -> memref<12xf32>, sym_name = "collapse_shape"}> ({
  ^bb0(%arg20: memref<3x4xf32, 1>):
    %27 = "memref.collapse_shape"(%arg20) <{reassociation = [[0, 1]]}> : (memref<3x4xf32, 1>) -> memref<12xf32, 1>
    %28 = "memref.memory_space_cast"(%27) : (memref<12xf32, 1>) -> memref<12xf32>
    "func.return"(%28) : (memref<12xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf32, 1>) -> memref<?x?xf32, #map>, sym_name = "transpose"}> ({
  ^bb0(%arg19: memref<?x?xf32, 1>):
    %25 = "memref.transpose"(%arg19) <{permutation = #map1}> : (memref<?x?xf32, 1>) -> memref<?x?xf32, #map, 1>
    %26 = "memref.memory_space_cast"(%25) : (memref<?x?xf32, #map, 1>) -> memref<?x?xf32, #map>
    "func.return"(%26) : (memref<?x?xf32, #map>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, 1>, index, f32) -> f32, sym_name = "atomic_rmw"}> ({
  ^bb0(%arg16: memref<?xf32, 1>, %arg17: index, %arg18: f32):
    %24 = "memref.atomic_rmw"(%arg18, %arg16, %arg17) <{kind = 0 : i64}> : (f32, memref<?xf32, 1>, index) -> f32
    "func.return"(%24) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, 1>) -> memref<?xf32>, sym_name = "assume_alignment"}> ({
  ^bb0(%arg15: memref<?xf32, 1>):
    %22 = "memref.assume_alignment"(%arg15) <{alignment = 16 : i32}> : (memref<?xf32, 1>) -> memref<?xf32, 1>
    %23 = "memref.memory_space_cast"(%22) : (memref<?xf32, 1>) -> memref<?xf32>
    "func.return"(%23) : (memref<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4x4xf32, 1>, index, f32) -> memref<16xf32>, sym_name = "op_with_cast_sequence"}> ({
  ^bb0(%arg12: memref<4x4xf32, 1>, %arg13: index, %arg14: f32):
    %14 = "arith.constant"() <{value = 4 : index}> : () -> index
    %15 = "arith.constant"() <{value = 0 : index}> : () -> index
    %16 = "memref.expand_shape"(%arg12) <{reassociation = [[0], [1, 2]], static_output_shape = array<i64: 4, 2, 2>}> : (memref<4x4xf32, 1>) -> memref<4x2x2xf32, 1>
    %17 = "memref.collapse_shape"(%16) <{reassociation = [[0, 1, 2]]}> : (memref<4x2x2xf32, 1>) -> memref<16xf32, 1>
    %18 = "memref.memory_space_cast"(%17) : (memref<16xf32, 1>) -> memref<16xf32>
    %19 = "memref.load"(%17, %15) : (memref<16xf32, 1>, index) -> f32
    %20 = "arith.addf"(%19, %arg14) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "memref.store"(%20, %17, %15) : (f32, memref<16xf32, 1>, index) -> ()
    %21 = "memref.atomic_rmw"(%arg14, %17, %14) <{kind = 0 : i64}> : (f32, memref<16xf32, 1>, index) -> f32
    "func.return"(%18) : (memref<16xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, 1>, index) -> (), sym_name = "transfer_read_write"}> ({
  ^bb0(%arg10: memref<?xf32, 1>, %arg11: index):
    %12 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %13 = "vector.transfer_read"(%arg10, %arg11, %12) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map2}> : (memref<?xf32, 1>, index, f32) -> vector<4xf32>
    "vector.transfer_write"(%13, %arg10, %arg11) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map2}> : (vector<4xf32>, memref<?xf32, 1>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?xf32>, index) -> tensor<?xf32>, sym_name = "transfer_read_write_tensor"}> ({
  ^bb0(%arg8: tensor<?xf32>, %arg9: index):
    "func.return"(%arg8) : (tensor<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, 1>, index) -> (), sym_name = "vector_load_store"}> ({
  ^bb0(%arg6: memref<?xf32, 1>, %arg7: index):
    %11 = "vector.load"(%arg6, %arg7) : (memref<?xf32, 1>, index) -> vector<4xf32>
    "vector.store"(%11, %arg6, %arg7) : (vector<4xf32>, memref<?xf32, 1>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, 1>, index) -> (), sym_name = "masked_load_store"}> ({
  ^bb0(%arg4: memref<?xf32, 1>, %arg5: index):
    %8 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %9 = "arith.constant"() <{value = dense<[true, true, false, false]> : vector<4xi1>}> : () -> vector<4xi1>
    %10 = "vector.maskedload"(%arg4, %arg5, %9, %8) : (memref<?xf32, 1>, index, vector<4xi1>, vector<4xf32>) -> vector<4xf32>
    "vector.maskedstore"(%arg4, %arg5, %9, %10) : (memref<?xf32, 1>, index, vector<4xi1>, vector<4xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, 1>, index) -> (), sym_name = "gather_scatter"}> ({
  ^bb0(%arg2: memref<?xf32, 1>, %arg3: index):
    %3 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %4 = "arith.constant"() <{value = dense<true> : vector<4xi1>}> : () -> vector<4xi1>
    %5 = "arith.constant"() <{value = dense<[0, 1, 2, 3]> : vector<4xindex>}> : () -> vector<4xindex>
    %6 = "arith.constant"() <{value = 0 : index}> : () -> index
    %7 = "vector.gather"(%arg2, %6, %5, %4, %3) : (memref<?xf32, 1>, index, vector<4xindex>, vector<4xi1>, vector<4xf32>) -> vector<4xf32>
    "vector.scatter"(%arg2, %6, %5, %4, %7) : (memref<?xf32, 1>, index, vector<4xindex>, vector<4xi1>, vector<4xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, 1>, index) -> (), sym_name = "expandload_compressstore"}> ({
  ^bb0(%arg0: memref<?xf32, 1>, %arg1: index):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %1 = "arith.constant"() <{value = dense<[true, true, false, false]> : vector<4xi1>}> : () -> vector<4xi1>
    %2 = "vector.expandload"(%arg0, %arg1, %1, %0) : (memref<?xf32, 1>, index, vector<4xi1>, vector<4xf32>) -> vector<4xf32>
    "vector.compressstore"(%arg0, %arg1, %1, %2) : (memref<?xf32, 1>, index, vector<4xi1>, vector<4xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

