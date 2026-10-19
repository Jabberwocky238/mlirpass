#map = affine_map<(d0, d1)[s0] -> (d1 * s0 + d0)>
#map1 = affine_map<(d0, d1) -> (d1, d0)>
#map2 = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, 1>, index) -> (), sym_name = "load_store"}> ({
  ^bb0(%arg35: memref<?xf32, 1>, %arg36: index):
    %57 = "memref.memory_space_cast"(%arg35) : (memref<?xf32, 1>) -> memref<?xf32>
    %58 = "memref.load"(%57, %arg36) : (memref<?xf32>, index) -> f32
    "memref.store"(%58, %57, %arg36) : (f32, memref<?xf32>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, 1>, index) -> (), sym_name = "load_store_unfoldable"}> ({
  ^bb0(%arg33: memref<?xf32, 1>, %arg34: index):
    %55 = "memref.memory_space_cast"(%arg33) : (memref<?xf32, 1>) -> memref<?xf32, 2>
    %56 = "memref.load"(%55, %arg34) : (memref<?xf32, 2>, index) -> f32
    "memref.store"(%56, %55, %arg34) : (f32, memref<?xf32, 2>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2xf32, 1>, memref<*xf32, 1>) -> (memref<*xf32>, memref<3x2xf32>), sym_name = "cast"}> ({
  ^bb0(%arg31: memref<2xf32, 1>, %arg32: memref<*xf32, 1>):
    %51 = "memref.memory_space_cast"(%arg31) : (memref<2xf32, 1>) -> memref<2xf32>
    %52 = "memref.cast"(%51) : (memref<2xf32>) -> memref<*xf32>
    %53 = "memref.memory_space_cast"(%arg32) : (memref<*xf32, 1>) -> memref<*xf32>
    %54 = "memref.cast"(%53) : (memref<*xf32>) -> memref<3x2xf32>
    "func.return"(%52, %54) : (memref<*xf32>, memref<3x2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi8, 1>, index, index) -> memref<?x?xi8>, sym_name = "view"}> ({
  ^bb0(%arg28: memref<?xi8, 1>, %arg29: index, %arg30: index):
    %48 = "memref.memory_space_cast"(%arg28) : (memref<?xi8, 1>) -> memref<?xi8>
    %49 = "arith.constant"() <{value = 100 : index}> : () -> index
    %50 = "memref.view"(%48, %arg29, %arg30, %49) : (memref<?xi8>, index, index, index) -> memref<?x?xi8>
    "func.return"(%50) : (memref<?x?xi8>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf32, 1>, index) -> memref<8x2xf32, strided<[?, 2], offset: ?>>, sym_name = "subview"}> ({
  ^bb0(%arg26: memref<?x?xf32, 1>, %arg27: index):
    %46 = "memref.memory_space_cast"(%arg26) : (memref<?x?xf32, 1>) -> memref<?x?xf32>
    %47 = "memref.subview"(%46) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 4, 2>, static_sizes = array<i64: 8, 2>, static_strides = array<i64: 3, 2>}> : (memref<?x?xf32>) -> memref<8x2xf32, strided<[?, 2], offset: ?>>
    "func.return"(%47) : (memref<8x2xf32, strided<[?, 2], offset: ?>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, 1>, index) -> memref<10x?xf32, strided<[?, 1], offset: ?>>, sym_name = "reinterpret_cast"}> ({
  ^bb0(%arg24: memref<?xf32, 1>, %arg25: index):
    %42 = "memref.memory_space_cast"(%arg24) : (memref<?xf32, 1>) -> memref<?xf32>
    %43 = "arith.constant"() <{value = 0 : index}> : () -> index
    %44 = "arith.constant"() <{value = 10 : index}> : () -> index
    %45 = "memref.reinterpret_cast"(%42, %43, %44, %44) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 10, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index, index, index) -> memref<10x?xf32, strided<[?, 1], offset: ?>>
    "func.return"(%45) : (memref<10x?xf32, strided<[?, 1], offset: ?>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf32, 1>, memref<1xindex>) -> memref<?xf32>, sym_name = "reshape"}> ({
  ^bb0(%arg22: memref<?x?xf32, 1>, %arg23: memref<1xindex>):
    %40 = "memref.memory_space_cast"(%arg22) : (memref<?x?xf32, 1>) -> memref<?x?xf32>
    %41 = "memref.reshape"(%40, %arg23) : (memref<?x?xf32>, memref<1xindex>) -> memref<?xf32>
    "func.return"(%41) : (memref<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<12xf32, 1>) -> memref<3x4xf32>, sym_name = "expand_shape"}> ({
  ^bb0(%arg21: memref<12xf32, 1>):
    %38 = "memref.memory_space_cast"(%arg21) : (memref<12xf32, 1>) -> memref<12xf32>
    %39 = "memref.expand_shape"(%38) <{reassociation = [[0, 1]], static_output_shape = array<i64: 3, 4>}> : (memref<12xf32>) -> memref<3x4xf32>
    "func.return"(%39) : (memref<3x4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<3x4xf32, 1>) -> memref<12xf32>, sym_name = "collapse_shape"}> ({
  ^bb0(%arg20: memref<3x4xf32, 1>):
    %36 = "memref.memory_space_cast"(%arg20) : (memref<3x4xf32, 1>) -> memref<3x4xf32>
    %37 = "memref.collapse_shape"(%36) <{reassociation = [[0, 1]]}> : (memref<3x4xf32>) -> memref<12xf32>
    "func.return"(%37) : (memref<12xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf32, 1>) -> memref<?x?xf32, #map>, sym_name = "transpose"}> ({
  ^bb0(%arg19: memref<?x?xf32, 1>):
    %34 = "memref.memory_space_cast"(%arg19) : (memref<?x?xf32, 1>) -> memref<?x?xf32>
    %35 = "memref.transpose"(%34) <{permutation = #map1}> : (memref<?x?xf32>) -> memref<?x?xf32, #map>
    "func.return"(%35) : (memref<?x?xf32, #map>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, 1>, index, f32) -> f32, sym_name = "atomic_rmw"}> ({
  ^bb0(%arg16: memref<?xf32, 1>, %arg17: index, %arg18: f32):
    %32 = "memref.memory_space_cast"(%arg16) : (memref<?xf32, 1>) -> memref<?xf32>
    %33 = "memref.atomic_rmw"(%arg18, %32, %arg17) <{kind = 0 : i64}> : (f32, memref<?xf32>, index) -> f32
    "func.return"(%33) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, 1>) -> memref<?xf32>, sym_name = "assume_alignment"}> ({
  ^bb0(%arg15: memref<?xf32, 1>):
    %30 = "memref.memory_space_cast"(%arg15) : (memref<?xf32, 1>) -> memref<?xf32>
    %31 = "memref.assume_alignment"(%30) <{alignment = 16 : i32}> : (memref<?xf32>) -> memref<?xf32>
    "func.return"(%31) : (memref<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4x4xf32, 1>, index, f32) -> memref<16xf32>, sym_name = "op_with_cast_sequence"}> ({
  ^bb0(%arg12: memref<4x4xf32, 1>, %arg13: index, %arg14: f32):
    %22 = "memref.memory_space_cast"(%arg12) : (memref<4x4xf32, 1>) -> memref<4x4xf32>
    %23 = "arith.constant"() <{value = 0 : index}> : () -> index
    %24 = "arith.constant"() <{value = 4 : index}> : () -> index
    %25 = "memref.expand_shape"(%22) <{reassociation = [[0], [1, 2]], static_output_shape = array<i64: 4, 2, 2>}> : (memref<4x4xf32>) -> memref<4x2x2xf32>
    %26 = "memref.collapse_shape"(%25) <{reassociation = [[0, 1, 2]]}> : (memref<4x2x2xf32>) -> memref<16xf32>
    %27 = "memref.load"(%26, %23) : (memref<16xf32>, index) -> f32
    %28 = "arith.addf"(%27, %arg14) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "memref.store"(%28, %26, %23) : (f32, memref<16xf32>, index) -> ()
    %29 = "memref.atomic_rmw"(%arg14, %26, %24) <{kind = 0 : i64}> : (f32, memref<16xf32>, index) -> f32
    "func.return"(%26) : (memref<16xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, 1>, index) -> (), sym_name = "transfer_read_write"}> ({
  ^bb0(%arg10: memref<?xf32, 1>, %arg11: index):
    %19 = "memref.memory_space_cast"(%arg10) : (memref<?xf32, 1>) -> memref<?xf32>
    %20 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %21 = "vector.transfer_read"(%19, %arg11, %20) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map2}> : (memref<?xf32>, index, f32) -> vector<4xf32>
    "vector.transfer_write"(%21, %19, %arg11) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map2}> : (vector<4xf32>, memref<?xf32>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?xf32>, index) -> tensor<?xf32>, sym_name = "transfer_read_write_tensor"}> ({
  ^bb0(%arg8: tensor<?xf32>, %arg9: index):
    %16 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %17 = "vector.transfer_read"(%arg8, %arg9, %16) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map2}> : (tensor<?xf32>, index, f32) -> vector<4xf32>
    %18 = "vector.transfer_write"(%17, %arg8, %arg9) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map2}> : (vector<4xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%18) : (tensor<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, 1>, index) -> (), sym_name = "vector_load_store"}> ({
  ^bb0(%arg6: memref<?xf32, 1>, %arg7: index):
    %14 = "memref.memory_space_cast"(%arg6) : (memref<?xf32, 1>) -> memref<?xf32>
    %15 = "vector.load"(%14, %arg7) : (memref<?xf32>, index) -> vector<4xf32>
    "vector.store"(%15, %14, %arg7) : (vector<4xf32>, memref<?xf32>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, 1>, index) -> (), sym_name = "masked_load_store"}> ({
  ^bb0(%arg4: memref<?xf32, 1>, %arg5: index):
    %10 = "memref.memory_space_cast"(%arg4) : (memref<?xf32, 1>) -> memref<?xf32>
    %11 = "arith.constant"() <{value = dense<[true, true, false, false]> : vector<4xi1>}> : () -> vector<4xi1>
    %12 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %13 = "vector.maskedload"(%10, %arg5, %11, %12) : (memref<?xf32>, index, vector<4xi1>, vector<4xf32>) -> vector<4xf32>
    "vector.maskedstore"(%10, %arg5, %11, %13) : (memref<?xf32>, index, vector<4xi1>, vector<4xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, 1>, index) -> (), sym_name = "gather_scatter"}> ({
  ^bb0(%arg2: memref<?xf32, 1>, %arg3: index):
    %4 = "memref.memory_space_cast"(%arg2) : (memref<?xf32, 1>) -> memref<?xf32>
    %5 = "arith.constant"() <{value = 0 : index}> : () -> index
    %6 = "arith.constant"() <{value = dense<[0, 1, 2, 3]> : vector<4xindex>}> : () -> vector<4xindex>
    %7 = "arith.constant"() <{value = dense<true> : vector<4xi1>}> : () -> vector<4xi1>
    %8 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %9 = "vector.gather"(%4, %5, %6, %7, %8) : (memref<?xf32>, index, vector<4xindex>, vector<4xi1>, vector<4xf32>) -> vector<4xf32>
    "vector.scatter"(%4, %5, %6, %7, %9) : (memref<?xf32>, index, vector<4xindex>, vector<4xi1>, vector<4xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, 1>, index) -> (), sym_name = "expandload_compressstore"}> ({
  ^bb0(%arg0: memref<?xf32, 1>, %arg1: index):
    %0 = "memref.memory_space_cast"(%arg0) : (memref<?xf32, 1>) -> memref<?xf32>
    %1 = "arith.constant"() <{value = dense<[true, true, false, false]> : vector<4xi1>}> : () -> vector<4xi1>
    %2 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %3 = "vector.expandload"(%0, %arg1, %1, %2) : (memref<?xf32>, index, vector<4xi1>, vector<4xf32>) -> vector<4xf32>
    "vector.compressstore"(%0, %arg1, %1, %3) : (memref<?xf32>, index, vector<4xi1>, vector<4xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

