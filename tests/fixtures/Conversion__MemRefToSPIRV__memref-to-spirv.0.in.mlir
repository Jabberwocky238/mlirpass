"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32, #spirv.storage_class<StorageBuffer>>, memref<f32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_store_zero_rank_float"}> ({
  ^bb0(%arg24: memref<f32, #spirv.storage_class<StorageBuffer>>, %arg25: memref<f32, #spirv.storage_class<StorageBuffer>>):
    %13 = "memref.load"(%arg24) : (memref<f32, #spirv.storage_class<StorageBuffer>>) -> f32
    "memref.store"(%13, %arg25) : (f32, memref<f32, #spirv.storage_class<StorageBuffer>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i32, #spirv.storage_class<StorageBuffer>>, memref<i32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_store_zero_rank_int"}> ({
  ^bb0(%arg22: memref<i32, #spirv.storage_class<StorageBuffer>>, %arg23: memref<i32, #spirv.storage_class<StorageBuffer>>):
    %12 = "memref.load"(%arg22) : (memref<i32, #spirv.storage_class<StorageBuffer>>) -> i32
    "memref.store"(%12, %arg23) : (i32, memref<i32, #spirv.storage_class<StorageBuffer>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, memref<?xi32, #spirv.storage_class<StorageBuffer>>, memref<?xi32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_store_unknown_dim"}> ({
  ^bb0(%arg19: index, %arg20: memref<?xi32, #spirv.storage_class<StorageBuffer>>, %arg21: memref<?xi32, #spirv.storage_class<StorageBuffer>>):
    %11 = "memref.load"(%arg20, %arg19) : (memref<?xi32, #spirv.storage_class<StorageBuffer>>, index) -> i32
    "memref.store"(%11, %arg21, %arg19) : (i32, memref<?xi32, #spirv.storage_class<StorageBuffer>>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xi1, #spirv.storage_class<StorageBuffer>>, index) -> i1, sym_name = "load_i1"}> ({
  ^bb0(%arg17: memref<4xi1, #spirv.storage_class<StorageBuffer>>, %arg18: index):
    %10 = "memref.load"(%arg17, %arg18) : (memref<4xi1, #spirv.storage_class<StorageBuffer>>, index) -> i1
    "func.return"(%10) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xi1, #spirv.storage_class<StorageBuffer>>, index) -> i1, sym_name = "load_aligned"}> ({
  ^bb0(%arg15: memref<4xi1, #spirv.storage_class<StorageBuffer>>, %arg16: index):
    %9 = "memref.load"(%arg15, %arg16) <{alignment = 32 : i64}> : (memref<4xi1, #spirv.storage_class<StorageBuffer>>, index) -> i1
    "func.return"(%9) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xi1, #spirv.storage_class<StorageBuffer>>, index) -> i1, sym_name = "load_aligned_nontemporal"}> ({
  ^bb0(%arg13: memref<4xi1, #spirv.storage_class<StorageBuffer>>, %arg14: index):
    %8 = "memref.load"(%arg13, %arg14) <{alignment = 32 : i64, nontemporal = true}> : (memref<4xi1, #spirv.storage_class<StorageBuffer>>, index) -> i1
    "func.return"(%8) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xi1, #spirv.storage_class<PhysicalStorageBuffer>>, index) -> i1, sym_name = "load_aligned_psb"}> ({
  ^bb0(%arg11: memref<4xi1, #spirv.storage_class<PhysicalStorageBuffer>>, %arg12: index):
    %7 = "memref.load"(%arg11, %arg12) <{alignment = 32 : i64}> : (memref<4xi1, #spirv.storage_class<PhysicalStorageBuffer>>, index) -> i1
    "func.return"(%7) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xi1, #spirv.storage_class<StorageBuffer>>, index) -> (), sym_name = "store_i1"}> ({
  ^bb0(%arg9: memref<4xi1, #spirv.storage_class<StorageBuffer>>, %arg10: index):
    %6 = "arith.constant"() <{value = true}> : () -> i1
    "memref.store"(%6, %arg9, %arg10) : (i1, memref<4xi1, #spirv.storage_class<StorageBuffer>>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i16, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_i16"}> ({
  ^bb0(%arg8: memref<i16, #spirv.storage_class<StorageBuffer>>):
    %5 = "memref.load"(%arg8) : (memref<i16, #spirv.storage_class<StorageBuffer>>) -> i16
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xi16, #spirv.storage_class<StorageBuffer>>, index, i16) -> (), sym_name = "store_i16"}> ({
  ^bb0(%arg5: memref<10xi16, #spirv.storage_class<StorageBuffer>>, %arg6: index, %arg7: i16):
    "memref.store"(%arg7, %arg5, %arg6) : (i16, memref<10xi16, #spirv.storage_class<StorageBuffer>>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i32, #spirv.storage_class<PhysicalStorageBuffer>>) -> (), sym_name = "load_store_i32_physical"}> ({
  ^bb0(%arg4: memref<i32, #spirv.storage_class<PhysicalStorageBuffer>>):
    %4 = "memref.load"(%arg4) : (memref<i32, #spirv.storage_class<PhysicalStorageBuffer>>) -> i32
    "memref.store"(%4, %arg4) : (i32, memref<i32, #spirv.storage_class<PhysicalStorageBuffer>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i8, #spirv.storage_class<PhysicalStorageBuffer>>) -> (), sym_name = "load_store_i8_physical"}> ({
  ^bb0(%arg3: memref<i8, #spirv.storage_class<PhysicalStorageBuffer>>):
    %3 = "memref.load"(%arg3) : (memref<i8, #spirv.storage_class<PhysicalStorageBuffer>>) -> i8
    "memref.store"(%3, %arg3) : (i8, memref<i8, #spirv.storage_class<PhysicalStorageBuffer>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i1, #spirv.storage_class<PhysicalStorageBuffer>>) -> (), sym_name = "load_store_i1_physical"}> ({
  ^bb0(%arg2: memref<i1, #spirv.storage_class<PhysicalStorageBuffer>>):
    %2 = "memref.load"(%arg2) : (memref<i1, #spirv.storage_class<PhysicalStorageBuffer>>) -> i1
    "memref.store"(%2, %arg2) : (i1, memref<i1, #spirv.storage_class<PhysicalStorageBuffer>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32, #spirv.storage_class<PhysicalStorageBuffer>>) -> (), sym_name = "load_store_f32_physical"}> ({
  ^bb0(%arg1: memref<f32, #spirv.storage_class<PhysicalStorageBuffer>>):
    %1 = "memref.load"(%arg1) : (memref<f32, #spirv.storage_class<PhysicalStorageBuffer>>) -> f32
    "memref.store"(%1, %arg1) : (f32, memref<f32, #spirv.storage_class<PhysicalStorageBuffer>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f16, #spirv.storage_class<PhysicalStorageBuffer>>) -> (), sym_name = "load_store_f16_physical"}> ({
  ^bb0(%arg0: memref<f16, #spirv.storage_class<PhysicalStorageBuffer>>):
    %0 = "memref.load"(%arg0) : (memref<f16, #spirv.storage_class<PhysicalStorageBuffer>>) -> f16
    "memref.store"(%0, %arg0) : (f16, memref<f16, #spirv.storage_class<PhysicalStorageBuffer>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, Int8, Int16, Int64, Float16, Float64, StorageBuffer16BitAccess, StorageUniform16, StoragePushConstant16, StorageBuffer8BitAccess, UniformAndStorageBuffer8BitAccess, StoragePushConstant8, PhysicalStorageBufferAddresses], [SPV_KHR_16bit_storage, SPV_KHR_8bit_storage, SPV_KHR_storage_buffer_storage_class, SPV_KHR_physical_storage_buffer]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32, #spirv.storage_class<CrossWorkgroup>>, memref<f32, #spirv.storage_class<CrossWorkgroup>>) -> (), sym_name = "load_store_zero_rank_float"}> ({
  ^bb0(%arg9: memref<f32, #spirv.storage_class<CrossWorkgroup>>, %arg10: memref<f32, #spirv.storage_class<CrossWorkgroup>>):
    %4 = "memref.load"(%arg9) : (memref<f32, #spirv.storage_class<CrossWorkgroup>>) -> f32
    "memref.store"(%4, %arg10) : (f32, memref<f32, #spirv.storage_class<CrossWorkgroup>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i32, #spirv.storage_class<CrossWorkgroup>>, memref<i32, #spirv.storage_class<CrossWorkgroup>>) -> (), sym_name = "load_store_zero_rank_int"}> ({
  ^bb0(%arg7: memref<i32, #spirv.storage_class<CrossWorkgroup>>, %arg8: memref<i32, #spirv.storage_class<CrossWorkgroup>>):
    %3 = "memref.load"(%arg7) : (memref<i32, #spirv.storage_class<CrossWorkgroup>>) -> i32
    "memref.store"(%3, %arg8) : (i32, memref<i32, #spirv.storage_class<CrossWorkgroup>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, memref<?xi32, #spirv.storage_class<CrossWorkgroup>>, memref<?xi32, #spirv.storage_class<CrossWorkgroup>>) -> (), sym_name = "load_store_unknown_dim"}> ({
  ^bb0(%arg4: index, %arg5: memref<?xi32, #spirv.storage_class<CrossWorkgroup>>, %arg6: memref<?xi32, #spirv.storage_class<CrossWorkgroup>>):
    %2 = "memref.load"(%arg5, %arg4) : (memref<?xi32, #spirv.storage_class<CrossWorkgroup>>, index) -> i32
    "memref.store"(%2, %arg6, %arg4) : (i32, memref<?xi32, #spirv.storage_class<CrossWorkgroup>>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xi1, #spirv.storage_class<CrossWorkgroup>>, index) -> i1, sym_name = "load_i1"}> ({
  ^bb0(%arg2: memref<4xi1, #spirv.storage_class<CrossWorkgroup>>, %arg3: index):
    %1 = "memref.load"(%arg2, %arg3) : (memref<4xi1, #spirv.storage_class<CrossWorkgroup>>, index) -> i1
    "func.return"(%1) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xi1, #spirv.storage_class<CrossWorkgroup>>, index) -> (), sym_name = "store_i1"}> ({
  ^bb0(%arg0: memref<4xi1, #spirv.storage_class<CrossWorkgroup>>, %arg1: index):
    %0 = "arith.constant"() <{value = true}> : () -> i1
    "memref.store"(%0, %arg0, %arg1) : (i1, memref<4xi1, #spirv.storage_class<CrossWorkgroup>>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel, Addresses, Int8, Int16, Int64, Float16, Float64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4xf32, #spirv.storage_class<CrossWorkgroup>>) -> memref<4xf32, #spirv.storage_class<Function>>, sym_name = "memory_space_cast"}> ({
  ^bb0(%arg0: memref<4xf32, #spirv.storage_class<CrossWorkgroup>>):
    %0 = "memref.memory_space_cast"(%arg0) : (memref<4xf32, #spirv.storage_class<CrossWorkgroup>>) -> memref<4xf32, #spirv.storage_class<Function>>
    "func.return"(%0) : (memref<4xf32, #spirv.storage_class<Function>>) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel, Addresses, GenericPointer], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<i1, #spirv.storage_class<StorageBuffer>>) -> i1, sym_name = "load_i1"}> ({
  ^bb0(%arg3: memref<i1, #spirv.storage_class<StorageBuffer>>):
    %2 = "memref.load"(%arg3) : (memref<i1, #spirv.storage_class<StorageBuffer>>) -> i1
    "func.return"(%2) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i8, #spirv.storage_class<StorageBuffer>>) -> i8, sym_name = "load_i8"}> ({
  ^bb0(%arg2: memref<i8, #spirv.storage_class<StorageBuffer>>):
    %1 = "memref.load"(%arg2) : (memref<i8, #spirv.storage_class<StorageBuffer>>) -> i8
    "func.return"(%1) : (i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xi16, #spirv.storage_class<StorageBuffer>>, index) -> i16, sym_name = "load_i16"}> ({
  ^bb0(%arg0: memref<10xi16, #spirv.storage_class<StorageBuffer>>, %arg1: index):
    %0 = "memref.load"(%arg0, %arg1) : (memref<10xi16, #spirv.storage_class<StorageBuffer>>, index) -> i16
    "func.return"(%0) : (i16) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int8, Int16], [SPV_KHR_8bit_storage, SPV_KHR_16bit_storage, SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, #spirv.storage_class<CrossWorkgroup>>, index) -> memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>>, sym_name = "reinterpret_cast"}> ({
  ^bb0(%arg2: memref<?xf32, #spirv.storage_class<CrossWorkgroup>>, %arg3: index):
    %2 = "memref.reinterpret_cast"(%arg2, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 10>, static_strides = array<i64: 1>}> : (memref<?xf32, #spirv.storage_class<CrossWorkgroup>>, index) -> memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>>
    "func.return"(%2) : (memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, #spirv.storage_class<CrossWorkgroup>>) -> memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>>, sym_name = "reinterpret_cast_0"}> ({
  ^bb0(%arg1: memref<?xf32, #spirv.storage_class<CrossWorkgroup>>):
    %1 = "memref.reinterpret_cast"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 10>, static_strides = array<i64: 1>}> : (memref<?xf32, #spirv.storage_class<CrossWorkgroup>>) -> memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>>
    "func.return"(%1) : (memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, #spirv.storage_class<CrossWorkgroup>>) -> memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>>, sym_name = "reinterpret_cast_5"}> ({
  ^bb0(%arg0: memref<?xf32, #spirv.storage_class<CrossWorkgroup>>):
    %0 = "memref.reinterpret_cast"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 5>, static_sizes = array<i64: 10>, static_strides = array<i64: 1>}> : (memref<?xf32, #spirv.storage_class<CrossWorkgroup>>) -> memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>>
    "func.return"(%0) : (memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>>) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel, Addresses, GenericPointer], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x?xf32, #spirv.storage_class<CrossWorkgroup>>) -> memref<?x4xf32, #spirv.storage_class<CrossWorkgroup>>, sym_name = "cast"}> ({
  ^bb0(%arg3: memref<4x?xf32, #spirv.storage_class<CrossWorkgroup>>):
    %3 = "memref.cast"(%arg3) : (memref<4x?xf32, #spirv.storage_class<CrossWorkgroup>>) -> memref<?x4xf32, #spirv.storage_class<CrossWorkgroup>>
    "func.return"(%3) : (memref<?x4xf32, #spirv.storage_class<CrossWorkgroup>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4x4xf32, #spirv.storage_class<CrossWorkgroup>>) -> memref<?x4xf32, #spirv.storage_class<CrossWorkgroup>>, sym_name = "cast_from_static"}> ({
  ^bb0(%arg2: memref<4x4xf32, #spirv.storage_class<CrossWorkgroup>>):
    %2 = "memref.cast"(%arg2) : (memref<4x4xf32, #spirv.storage_class<CrossWorkgroup>>) -> memref<?x4xf32, #spirv.storage_class<CrossWorkgroup>>
    "func.return"(%2) : (memref<?x4xf32, #spirv.storage_class<CrossWorkgroup>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4x?xf32, #spirv.storage_class<CrossWorkgroup>>) -> memref<4x4xf32, #spirv.storage_class<CrossWorkgroup>>, sym_name = "cast_to_static"}> ({
  ^bb0(%arg1: memref<4x?xf32, #spirv.storage_class<CrossWorkgroup>>):
    %1 = "memref.cast"(%arg1) : (memref<4x?xf32, #spirv.storage_class<CrossWorkgroup>>) -> memref<4x4xf32, #spirv.storage_class<CrossWorkgroup>>
    "func.return"(%1) : (memref<4x4xf32, #spirv.storage_class<CrossWorkgroup>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, #spirv.storage_class<CrossWorkgroup>>) -> memref<0xf32, #spirv.storage_class<CrossWorkgroup>>, sym_name = "cast_to_static_zero_elems"}> ({
  ^bb0(%arg0: memref<?xf32, #spirv.storage_class<CrossWorkgroup>>):
    %0 = "memref.cast"(%arg0) : (memref<?xf32, #spirv.storage_class<CrossWorkgroup>>) -> memref<0xf32, #spirv.storage_class<CrossWorkgroup>>
    "func.return"(%0) : (memref<0xf32, #spirv.storage_class<CrossWorkgroup>>) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel, Addresses, GenericPointer], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, #spirv.storage_class<CrossWorkgroup>>) -> index, sym_name = "extract_aligned_pointer_as_index_kernel"}> ({
  ^bb0(%arg0: memref<?xf32, #spirv.storage_class<CrossWorkgroup>>):
    %0 = "memref.extract_aligned_pointer_as_index"(%arg0) : (memref<?xf32, #spirv.storage_class<CrossWorkgroup>>) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Kernel, Int64, Addresses, PhysicalStorageBufferAddresses], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, #spirv.storage_class<CrossWorkgroup>>) -> index, sym_name = "extract_aligned_pointer_as_index_shader"}> ({
  ^bb0(%arg0: memref<?xf32, #spirv.storage_class<CrossWorkgroup>>):
    %0 = "memref.extract_aligned_pointer_as_index"(%arg0) : (memref<?xf32, #spirv.storage_class<CrossWorkgroup>>) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, Int64, Addresses, PhysicalStorageBufferAddresses], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_nontemporal"}> ({
  ^bb0(%arg1: memref<f32, #spirv.storage_class<StorageBuffer>>):
    %1 = "memref.load"(%arg1) <{nontemporal = true}> : (memref<f32, #spirv.storage_class<StorageBuffer>>) -> f32
    "memref.store"(%1, %arg1) <{nontemporal = true}> : (f32, memref<f32, #spirv.storage_class<StorageBuffer>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32, #spirv.storage_class<PhysicalStorageBuffer>>) -> (), sym_name = "load_nontemporal_aligned"}> ({
  ^bb0(%arg0: memref<f32, #spirv.storage_class<PhysicalStorageBuffer>>):
    %0 = "memref.load"(%arg0) <{nontemporal = true}> : (memref<f32, #spirv.storage_class<PhysicalStorageBuffer>>) -> f32
    "memref.store"(%0, %arg0) <{nontemporal = true}> : (f32, memref<f32, #spirv.storage_class<PhysicalStorageBuffer>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, PhysicalStorageBufferAddresses], [SPV_KHR_storage_buffer_storage_class, SPV_KHR_physical_storage_buffer]>, #spirv.resource_limits<>>} : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1, d0)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1, d0)>
#map2 = affine_map<(d0, d1) -> (d0, d1 mod 2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1xf32, #spirv.storage_class<Image>>, memref<1xf32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_image_1D"}> ({
  ^bb0(%arg26: memref<1xf32, #spirv.storage_class<Image>>, %arg27: memref<1xf32, #spirv.storage_class<StorageBuffer>>):
    %38 = "arith.constant"() <{value = 0 : index}> : () -> index
    %39 = "memref.load"(%arg26, %38) : (memref<1xf32, #spirv.storage_class<Image>>, index) -> f32
    "memref.store"(%39, %arg27, %38) : (f32, memref<1xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x4xf32, #spirv.storage_class<Image>>, memref<2x4xf32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_image_2D"}> ({
  ^bb0(%arg24: memref<2x4xf32, #spirv.storage_class<Image>>, %arg25: memref<2x4xf32, #spirv.storage_class<StorageBuffer>>):
    %35 = "arith.constant"() <{value = 3 : index}> : () -> index
    %36 = "arith.constant"() <{value = 1 : index}> : () -> index
    %37 = "memref.load"(%arg24, %36, %35) : (memref<2x4xf32, #spirv.storage_class<Image>>, index, index) -> f32
    "memref.store"(%37, %arg25, %36, %35) : (f32, memref<2x4xf32, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x4xf32, #map, #spirv.storage_class<Image>>, memref<2x4xf32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_col_major_image_2D"}> ({
  ^bb0(%arg22: memref<2x4xf32, #map, #spirv.storage_class<Image>>, %arg23: memref<2x4xf32, #spirv.storage_class<StorageBuffer>>):
    %32 = "arith.constant"() <{value = 3 : index}> : () -> index
    %33 = "arith.constant"() <{value = 1 : index}> : () -> index
    %34 = "memref.load"(%arg22, %32, %33) : (memref<2x4xf32, #map, #spirv.storage_class<Image>>, index, index) -> f32
    "memref.store"(%34, %arg23, %33, %32) : (f32, memref<2x4xf32, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x3x4xf32, #spirv.storage_class<Image>>, memref<2x3x4xf32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_image_3D"}> ({
  ^bb0(%arg20: memref<2x3x4xf32, #spirv.storage_class<Image>>, %arg21: memref<2x3x4xf32, #spirv.storage_class<StorageBuffer>>):
    %28 = "arith.constant"() <{value = 3 : index}> : () -> index
    %29 = "arith.constant"() <{value = 2 : index}> : () -> index
    %30 = "arith.constant"() <{value = 1 : index}> : () -> index
    %31 = "memref.load"(%arg20, %30, %29, %28) : (memref<2x3x4xf32, #spirv.storage_class<Image>>, index, index, index) -> f32
    "memref.store"(%31, %arg21, %30, %29, %28) : (f32, memref<2x3x4xf32, #spirv.storage_class<StorageBuffer>>, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x3x4xf32, #map1, #spirv.storage_class<Image>>, memref<2x3x4xf32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_custom_layout_image_3D"}> ({
  ^bb0(%arg18: memref<2x3x4xf32, #map1, #spirv.storage_class<Image>>, %arg19: memref<2x3x4xf32, #spirv.storage_class<StorageBuffer>>):
    %24 = "arith.constant"() <{value = 3 : index}> : () -> index
    %25 = "arith.constant"() <{value = 2 : index}> : () -> index
    %26 = "arith.constant"() <{value = 1 : index}> : () -> index
    %27 = "memref.load"(%arg18, %24, %25, %26) : (memref<2x3x4xf32, #map1, #spirv.storage_class<Image>>, index, index, index) -> f32
    "memref.store"(%27, %arg19, %26, %25, %24) : (f32, memref<2x3x4xf32, #spirv.storage_class<StorageBuffer>>, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x3xf16, #spirv.storage_class<Image>>, memref<2x3xf16, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_image_2D_f16"}> ({
  ^bb0(%arg16: memref<2x3xf16, #spirv.storage_class<Image>>, %arg17: memref<2x3xf16, #spirv.storage_class<StorageBuffer>>):
    %21 = "arith.constant"() <{value = 2 : index}> : () -> index
    %22 = "arith.constant"() <{value = 1 : index}> : () -> index
    %23 = "memref.load"(%arg16, %22, %21) : (memref<2x3xf16, #spirv.storage_class<Image>>, index, index) -> f16
    "memref.store"(%23, %arg17, %22, %21) : (f16, memref<2x3xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x3xi32, #spirv.storage_class<Image>>, memref<2x3xi32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_image_2D_i32"}> ({
  ^bb0(%arg14: memref<2x3xi32, #spirv.storage_class<Image>>, %arg15: memref<2x3xi32, #spirv.storage_class<StorageBuffer>>):
    %18 = "arith.constant"() <{value = 2 : index}> : () -> index
    %19 = "arith.constant"() <{value = 1 : index}> : () -> index
    %20 = "memref.load"(%arg14, %19, %18) : (memref<2x3xi32, #spirv.storage_class<Image>>, index, index) -> i32
    "memref.store"(%20, %arg15, %19, %18) : (i32, memref<2x3xi32, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x3xui32, #spirv.storage_class<Image>>, memref<2x3xui32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_image_2D_ui32"}> ({
  ^bb0(%arg12: memref<2x3xui32, #spirv.storage_class<Image>>, %arg13: memref<2x3xui32, #spirv.storage_class<StorageBuffer>>):
    %15 = "arith.constant"() <{value = 2 : index}> : () -> index
    %16 = "arith.constant"() <{value = 1 : index}> : () -> index
    %17 = "memref.load"(%arg12, %16, %15) : (memref<2x3xui32, #spirv.storage_class<Image>>, index, index) -> ui32
    "memref.store"(%17, %arg13, %16, %15) : (ui32, memref<2x3xui32, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x3xi16, #spirv.storage_class<Image>>, memref<2x3xi16, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_image_2D_i16"}> ({
  ^bb0(%arg10: memref<2x3xi16, #spirv.storage_class<Image>>, %arg11: memref<2x3xi16, #spirv.storage_class<StorageBuffer>>):
    %12 = "arith.constant"() <{value = 2 : index}> : () -> index
    %13 = "arith.constant"() <{value = 1 : index}> : () -> index
    %14 = "memref.load"(%arg10, %13, %12) : (memref<2x3xi16, #spirv.storage_class<Image>>, index, index) -> i16
    "memref.store"(%14, %arg11, %13, %12) : (i16, memref<2x3xi16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x3xui16, #spirv.storage_class<Image>>, memref<2x3xui16, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_image_2D_ui16"}> ({
  ^bb0(%arg8: memref<2x3xui16, #spirv.storage_class<Image>>, %arg9: memref<2x3xui16, #spirv.storage_class<StorageBuffer>>):
    %9 = "arith.constant"() <{value = 2 : index}> : () -> index
    %10 = "arith.constant"() <{value = 1 : index}> : () -> index
    %11 = "memref.load"(%arg8, %10, %9) : (memref<2x3xui16, #spirv.storage_class<Image>>, index, index) -> ui16
    "memref.store"(%11, %arg9, %10, %9) : (ui16, memref<2x3xui16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32, #spirv.storage_class<Image>>, memref<f32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_image_2D_rank0"}> ({
  ^bb0(%arg6: memref<f32, #spirv.storage_class<Image>>, %arg7: memref<f32, #spirv.storage_class<StorageBuffer>>):
    %7 = "arith.constant"() <{value = 0 : index}> : () -> index
    %8 = "memref.load"(%arg6) : (memref<f32, #spirv.storage_class<Image>>) -> f32
    "memref.store"(%8, %arg7) : (f32, memref<f32, #spirv.storage_class<StorageBuffer>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1x1x1x1xf32, #spirv.storage_class<Image>>, memref<1x1x1x1xf32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_image_2D_rank4"}> ({
  ^bb0(%arg4: memref<1x1x1x1xf32, #spirv.storage_class<Image>>, %arg5: memref<1x1x1x1xf32, #spirv.storage_class<StorageBuffer>>):
    %5 = "arith.constant"() <{value = 0 : index}> : () -> index
    %6 = "memref.load"(%arg4, %5, %5, %5, %5) : (memref<1x1x1x1xf32, #spirv.storage_class<Image>>, index, index, index, index) -> f32
    "memref.store"(%6, %arg5, %5, %5, %5, %5) : (f32, memref<1x1x1x1xf32, #spirv.storage_class<StorageBuffer>>, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1xvector<1xf32>, #spirv.storage_class<Image>>, memref<1xvector<1xf32>, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_image_2D_vector"}> ({
  ^bb0(%arg2: memref<1xvector<1xf32>, #spirv.storage_class<Image>>, %arg3: memref<1xvector<1xf32>, #spirv.storage_class<StorageBuffer>>):
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "memref.load"(%arg2, %3) : (memref<1xvector<1xf32>, #spirv.storage_class<Image>>, index) -> vector<1xf32>
    "memref.store"(%4, %arg3, %3) : (vector<1xf32>, memref<1xvector<1xf32>, #spirv.storage_class<StorageBuffer>>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x4xf32, #map2, #spirv.storage_class<Image>>, memref<2x4xf32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_non_perm_layout"}> ({
  ^bb0(%arg0: memref<2x4xf32, #map2, #spirv.storage_class<Image>>, %arg1: memref<2x4xf32, #spirv.storage_class<StorageBuffer>>):
    %0 = "arith.constant"() <{value = 3 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "memref.load"(%arg0, %1, %0) : (memref<2x4xf32, #map2, #spirv.storage_class<Image>>, index, index) -> f32
    "memref.store"(%2, %arg1, %1, %0) : (f32, memref<2x4xf32, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, PhysicalStorageBufferAddresses, Image1D, StorageImageExtendedFormats, Float16, StorageBuffer16BitAccess, StorageUniform16, Int16], [SPV_KHR_storage_buffer_storage_class, SPV_KHR_physical_storage_buffer, SPV_KHR_16bit_storage]>, #spirv.resource_limits<>>} : () -> ()

