"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32, #spirv.storage_class<StorageBuffer>>, memref<f32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_store_zero_rank_float"}> ({
  ^bb0(%arg24: memref<f32, #spirv.storage_class<StorageBuffer>>, %arg25: memref<f32, #spirv.storage_class<StorageBuffer>>):
    %78 = "builtin.unrealized_conversion_cast"(%arg25) : (memref<f32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>
    %79 = "builtin.unrealized_conversion_cast"(%arg24) : (memref<f32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>
    %80 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %81 = "spirv.AccessChain"(%79, %80, %80) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    %82 = "spirv.Load"(%81) : (!spirv.ptr<f32, StorageBuffer>) -> f32
    %83 = "spirv.AccessChain"(%78, %80, %80) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    "spirv.Store"(%83, %82) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i32, #spirv.storage_class<StorageBuffer>>, memref<i32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_store_zero_rank_int"}> ({
  ^bb0(%arg22: memref<i32, #spirv.storage_class<StorageBuffer>>, %arg23: memref<i32, #spirv.storage_class<StorageBuffer>>):
    %72 = "builtin.unrealized_conversion_cast"(%arg23) : (memref<i32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>
    %73 = "builtin.unrealized_conversion_cast"(%arg22) : (memref<i32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>
    %74 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %75 = "spirv.AccessChain"(%73, %74, %74) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
    %76 = "spirv.Load"(%75) : (!spirv.ptr<i32, StorageBuffer>) -> i32
    %77 = "spirv.AccessChain"(%72, %74, %74) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
    "spirv.Store"(%77, %76) : (!spirv.ptr<i32, StorageBuffer>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, memref<?xi32, #spirv.storage_class<StorageBuffer>>, memref<?xi32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_store_unknown_dim"}> ({
  ^bb0(%arg19: index, %arg20: memref<?xi32, #spirv.storage_class<StorageBuffer>>, %arg21: memref<?xi32, #spirv.storage_class<StorageBuffer>>):
    %65 = "builtin.unrealized_conversion_cast"(%arg21) : (memref<?xi32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>
    %66 = "builtin.unrealized_conversion_cast"(%arg19) : (index) -> i32
    %67 = "builtin.unrealized_conversion_cast"(%arg20) : (memref<?xi32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>
    %68 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %69 = "spirv.AccessChain"(%67, %68, %66) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
    %70 = "spirv.Load"(%69) : (!spirv.ptr<i32, StorageBuffer>) -> i32
    %71 = "spirv.AccessChain"(%65, %68, %66) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
    "spirv.Store"(%71, %70) : (!spirv.ptr<i32, StorageBuffer>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xi1, #spirv.storage_class<StorageBuffer>>, index) -> i1, sym_name = "load_i1"}> ({
  ^bb0(%arg17: memref<4xi1, #spirv.storage_class<StorageBuffer>>, %arg18: index):
    %58 = "builtin.unrealized_conversion_cast"(%arg18) : (index) -> i32
    %59 = "builtin.unrealized_conversion_cast"(%arg17) : (memref<4xi1, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<4 x i8, stride=1> [0])>, StorageBuffer>
    %60 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %61 = "spirv.AccessChain"(%59, %60, %58) : (!spirv.ptr<!spirv.struct<(!spirv.array<4 x i8, stride=1> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i8, StorageBuffer>
    %62 = "spirv.Load"(%61) : (!spirv.ptr<i8, StorageBuffer>) -> i8
    %63 = "spirv.Constant"() <{value = 0 : i8}> : () -> i8
    %64 = "spirv.INotEqual"(%62, %63) : (i8, i8) -> i1
    "func.return"(%64) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xi1, #spirv.storage_class<StorageBuffer>>, index) -> i1, sym_name = "load_aligned"}> ({
  ^bb0(%arg15: memref<4xi1, #spirv.storage_class<StorageBuffer>>, %arg16: index):
    %51 = "builtin.unrealized_conversion_cast"(%arg16) : (index) -> i32
    %52 = "builtin.unrealized_conversion_cast"(%arg15) : (memref<4xi1, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<4 x i8, stride=1> [0])>, StorageBuffer>
    %53 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %54 = "spirv.AccessChain"(%52, %53, %51) : (!spirv.ptr<!spirv.struct<(!spirv.array<4 x i8, stride=1> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i8, StorageBuffer>
    %55 = "spirv.Load"(%54) <{alignment = 32 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<i8, StorageBuffer>) -> i8
    %56 = "spirv.Constant"() <{value = 0 : i8}> : () -> i8
    %57 = "spirv.INotEqual"(%55, %56) : (i8, i8) -> i1
    "func.return"(%57) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xi1, #spirv.storage_class<StorageBuffer>>, index) -> i1, sym_name = "load_aligned_nontemporal"}> ({
  ^bb0(%arg13: memref<4xi1, #spirv.storage_class<StorageBuffer>>, %arg14: index):
    %44 = "builtin.unrealized_conversion_cast"(%arg14) : (index) -> i32
    %45 = "builtin.unrealized_conversion_cast"(%arg13) : (memref<4xi1, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<4 x i8, stride=1> [0])>, StorageBuffer>
    %46 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %47 = "spirv.AccessChain"(%45, %46, %44) : (!spirv.ptr<!spirv.struct<(!spirv.array<4 x i8, stride=1> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i8, StorageBuffer>
    %48 = "spirv.Load"(%47) <{alignment = 32 : i32, memory_access = #spirv.memory_access<Aligned|Nontemporal>}> : (!spirv.ptr<i8, StorageBuffer>) -> i8
    %49 = "spirv.Constant"() <{value = 0 : i8}> : () -> i8
    %50 = "spirv.INotEqual"(%48, %49) : (i8, i8) -> i1
    "func.return"(%50) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xi1, #spirv.storage_class<PhysicalStorageBuffer>>, index) -> i1, sym_name = "load_aligned_psb"}> ({
  ^bb0(%arg11: memref<4xi1, #spirv.storage_class<PhysicalStorageBuffer>>, %arg12: index):
    %37 = "builtin.unrealized_conversion_cast"(%arg12) : (index) -> i32
    %38 = "builtin.unrealized_conversion_cast"(%arg11) : (memref<4xi1, #spirv.storage_class<PhysicalStorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<4 x i8, stride=1> [0])>, PhysicalStorageBuffer>
    %39 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %40 = "spirv.AccessChain"(%38, %39, %37) : (!spirv.ptr<!spirv.struct<(!spirv.array<4 x i8, stride=1> [0])>, PhysicalStorageBuffer>, i32, i32) -> !spirv.ptr<i8, PhysicalStorageBuffer>
    %41 = "spirv.Load"(%40) <{alignment = 32 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<i8, PhysicalStorageBuffer>) -> i8
    %42 = "spirv.Constant"() <{value = 0 : i8}> : () -> i8
    %43 = "spirv.INotEqual"(%41, %42) : (i8, i8) -> i1
    "func.return"(%43) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xi1, #spirv.storage_class<StorageBuffer>>, index) -> (), sym_name = "store_i1"}> ({
  ^bb0(%arg9: memref<4xi1, #spirv.storage_class<StorageBuffer>>, %arg10: index):
    %32 = "builtin.unrealized_conversion_cast"(%arg10) : (index) -> i32
    %33 = "builtin.unrealized_conversion_cast"(%arg9) : (memref<4xi1, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<4 x i8, stride=1> [0])>, StorageBuffer>
    %34 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %35 = "spirv.AccessChain"(%33, %34, %32) : (!spirv.ptr<!spirv.struct<(!spirv.array<4 x i8, stride=1> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i8, StorageBuffer>
    %36 = "spirv.Constant"() <{value = 1 : i8}> : () -> i8
    "spirv.Store"(%35, %36) : (!spirv.ptr<i8, StorageBuffer>, i8) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i16, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_i16"}> ({
  ^bb0(%arg8: memref<i16, #spirv.storage_class<StorageBuffer>>):
    %28 = "builtin.unrealized_conversion_cast"(%arg8) : (memref<i16, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x i16, stride=2> [0])>, StorageBuffer>
    %29 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %30 = "spirv.AccessChain"(%28, %29, %29) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i16, stride=2> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i16, StorageBuffer>
    %31 = "spirv.Load"(%30) : (!spirv.ptr<i16, StorageBuffer>) -> i16
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xi16, #spirv.storage_class<StorageBuffer>>, index, i16) -> (), sym_name = "store_i16"}> ({
  ^bb0(%arg5: memref<10xi16, #spirv.storage_class<StorageBuffer>>, %arg6: index, %arg7: i16):
    %24 = "builtin.unrealized_conversion_cast"(%arg6) : (index) -> i32
    %25 = "builtin.unrealized_conversion_cast"(%arg5) : (memref<10xi16, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<10 x i16, stride=2> [0])>, StorageBuffer>
    %26 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %27 = "spirv.AccessChain"(%25, %26, %24) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x i16, stride=2> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i16, StorageBuffer>
    "spirv.Store"(%27, %arg7) : (!spirv.ptr<i16, StorageBuffer>, i16) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i32, #spirv.storage_class<PhysicalStorageBuffer>>) -> (), sym_name = "load_store_i32_physical"}> ({
  ^bb0(%arg4: memref<i32, #spirv.storage_class<PhysicalStorageBuffer>>):
    %20 = "builtin.unrealized_conversion_cast"(%arg4) : (memref<i32, #spirv.storage_class<PhysicalStorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, PhysicalStorageBuffer>
    %21 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %22 = "spirv.AccessChain"(%20, %21, %21) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, PhysicalStorageBuffer>, i32, i32) -> !spirv.ptr<i32, PhysicalStorageBuffer>
    %23 = "spirv.Load"(%22) <{alignment = 4 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<i32, PhysicalStorageBuffer>) -> i32
    "spirv.Store"(%22, %23) <{alignment = 4 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<i32, PhysicalStorageBuffer>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i8, #spirv.storage_class<PhysicalStorageBuffer>>) -> (), sym_name = "load_store_i8_physical"}> ({
  ^bb0(%arg3: memref<i8, #spirv.storage_class<PhysicalStorageBuffer>>):
    %16 = "builtin.unrealized_conversion_cast"(%arg3) : (memref<i8, #spirv.storage_class<PhysicalStorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x i8, stride=1> [0])>, PhysicalStorageBuffer>
    %17 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %18 = "spirv.AccessChain"(%16, %17, %17) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i8, stride=1> [0])>, PhysicalStorageBuffer>, i32, i32) -> !spirv.ptr<i8, PhysicalStorageBuffer>
    %19 = "spirv.Load"(%18) <{alignment = 1 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<i8, PhysicalStorageBuffer>) -> i8
    "spirv.Store"(%18, %19) <{alignment = 1 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<i8, PhysicalStorageBuffer>, i8) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i1, #spirv.storage_class<PhysicalStorageBuffer>>) -> (), sym_name = "load_store_i1_physical"}> ({
  ^bb0(%arg2: memref<i1, #spirv.storage_class<PhysicalStorageBuffer>>):
    %8 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<i1, #spirv.storage_class<PhysicalStorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x i8, stride=1> [0])>, PhysicalStorageBuffer>
    %9 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %10 = "spirv.AccessChain"(%8, %9, %9) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i8, stride=1> [0])>, PhysicalStorageBuffer>, i32, i32) -> !spirv.ptr<i8, PhysicalStorageBuffer>
    %11 = "spirv.Load"(%10) <{alignment = 1 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<i8, PhysicalStorageBuffer>) -> i8
    %12 = "spirv.Constant"() <{value = 0 : i8}> : () -> i8
    %13 = "spirv.INotEqual"(%11, %12) : (i8, i8) -> i1
    %14 = "spirv.Constant"() <{value = 1 : i8}> : () -> i8
    %15 = "spirv.Select"(%13, %14, %12) : (i1, i8, i8) -> i8
    "spirv.Store"(%10, %15) <{alignment = 1 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<i8, PhysicalStorageBuffer>, i8) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32, #spirv.storage_class<PhysicalStorageBuffer>>) -> (), sym_name = "load_store_f32_physical"}> ({
  ^bb0(%arg1: memref<f32, #spirv.storage_class<PhysicalStorageBuffer>>):
    %4 = "builtin.unrealized_conversion_cast"(%arg1) : (memref<f32, #spirv.storage_class<PhysicalStorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, PhysicalStorageBuffer>
    %5 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %6 = "spirv.AccessChain"(%4, %5, %5) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, PhysicalStorageBuffer>, i32, i32) -> !spirv.ptr<f32, PhysicalStorageBuffer>
    %7 = "spirv.Load"(%6) <{alignment = 4 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<f32, PhysicalStorageBuffer>) -> f32
    "spirv.Store"(%6, %7) <{alignment = 4 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<f32, PhysicalStorageBuffer>, f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f16, #spirv.storage_class<PhysicalStorageBuffer>>) -> (), sym_name = "load_store_f16_physical"}> ({
  ^bb0(%arg0: memref<f16, #spirv.storage_class<PhysicalStorageBuffer>>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<f16, #spirv.storage_class<PhysicalStorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x f16, stride=2> [0])>, PhysicalStorageBuffer>
    %1 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %2 = "spirv.AccessChain"(%0, %1, %1) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x f16, stride=2> [0])>, PhysicalStorageBuffer>, i32, i32) -> !spirv.ptr<f16, PhysicalStorageBuffer>
    %3 = "spirv.Load"(%2) <{alignment = 2 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<f16, PhysicalStorageBuffer>) -> f16
    "spirv.Store"(%2, %3) <{alignment = 2 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<f16, PhysicalStorageBuffer>, f16) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, Int8, Int16, Int64, Float16, Float64, StorageBuffer16BitAccess, StorageUniform16, StoragePushConstant16, StorageBuffer8BitAccess, UniformAndStorageBuffer8BitAccess, StoragePushConstant8, PhysicalStorageBufferAddresses], [SPV_KHR_16bit_storage, SPV_KHR_8bit_storage, SPV_KHR_storage_buffer_storage_class, SPV_KHR_physical_storage_buffer]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32, #spirv.storage_class<CrossWorkgroup>>, memref<f32, #spirv.storage_class<CrossWorkgroup>>) -> (), sym_name = "load_store_zero_rank_float"}> ({
  ^bb0(%arg9: memref<f32, #spirv.storage_class<CrossWorkgroup>>, %arg10: memref<f32, #spirv.storage_class<CrossWorkgroup>>):
    %22 = "builtin.unrealized_conversion_cast"(%arg10) : (memref<f32, #spirv.storage_class<CrossWorkgroup>>) -> !spirv.ptr<!spirv.array<1 x f32>, CrossWorkgroup>
    %23 = "builtin.unrealized_conversion_cast"(%arg9) : (memref<f32, #spirv.storage_class<CrossWorkgroup>>) -> !spirv.ptr<!spirv.array<1 x f32>, CrossWorkgroup>
    %24 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %25 = "spirv.AccessChain"(%23, %24) : (!spirv.ptr<!spirv.array<1 x f32>, CrossWorkgroup>, i32) -> !spirv.ptr<f32, CrossWorkgroup>
    %26 = "spirv.Load"(%25) : (!spirv.ptr<f32, CrossWorkgroup>) -> f32
    %27 = "spirv.AccessChain"(%22, %24) : (!spirv.ptr<!spirv.array<1 x f32>, CrossWorkgroup>, i32) -> !spirv.ptr<f32, CrossWorkgroup>
    "spirv.Store"(%27, %26) : (!spirv.ptr<f32, CrossWorkgroup>, f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i32, #spirv.storage_class<CrossWorkgroup>>, memref<i32, #spirv.storage_class<CrossWorkgroup>>) -> (), sym_name = "load_store_zero_rank_int"}> ({
  ^bb0(%arg7: memref<i32, #spirv.storage_class<CrossWorkgroup>>, %arg8: memref<i32, #spirv.storage_class<CrossWorkgroup>>):
    %16 = "builtin.unrealized_conversion_cast"(%arg8) : (memref<i32, #spirv.storage_class<CrossWorkgroup>>) -> !spirv.ptr<!spirv.array<1 x i32>, CrossWorkgroup>
    %17 = "builtin.unrealized_conversion_cast"(%arg7) : (memref<i32, #spirv.storage_class<CrossWorkgroup>>) -> !spirv.ptr<!spirv.array<1 x i32>, CrossWorkgroup>
    %18 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %19 = "spirv.AccessChain"(%17, %18) : (!spirv.ptr<!spirv.array<1 x i32>, CrossWorkgroup>, i32) -> !spirv.ptr<i32, CrossWorkgroup>
    %20 = "spirv.Load"(%19) : (!spirv.ptr<i32, CrossWorkgroup>) -> i32
    %21 = "spirv.AccessChain"(%16, %18) : (!spirv.ptr<!spirv.array<1 x i32>, CrossWorkgroup>, i32) -> !spirv.ptr<i32, CrossWorkgroup>
    "spirv.Store"(%21, %20) : (!spirv.ptr<i32, CrossWorkgroup>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, memref<?xi32, #spirv.storage_class<CrossWorkgroup>>, memref<?xi32, #spirv.storage_class<CrossWorkgroup>>) -> (), sym_name = "load_store_unknown_dim"}> ({
  ^bb0(%arg4: index, %arg5: memref<?xi32, #spirv.storage_class<CrossWorkgroup>>, %arg6: memref<?xi32, #spirv.storage_class<CrossWorkgroup>>):
    %10 = "builtin.unrealized_conversion_cast"(%arg6) : (memref<?xi32, #spirv.storage_class<CrossWorkgroup>>) -> !spirv.ptr<i32, CrossWorkgroup>
    %11 = "builtin.unrealized_conversion_cast"(%arg4) : (index) -> i32
    %12 = "builtin.unrealized_conversion_cast"(%arg5) : (memref<?xi32, #spirv.storage_class<CrossWorkgroup>>) -> !spirv.ptr<i32, CrossWorkgroup>
    %13 = "spirv.PtrAccessChain"(%12, %11) : (!spirv.ptr<i32, CrossWorkgroup>, i32) -> !spirv.ptr<i32, CrossWorkgroup>
    %14 = "spirv.Load"(%13) : (!spirv.ptr<i32, CrossWorkgroup>) -> i32
    %15 = "spirv.PtrAccessChain"(%10, %11) : (!spirv.ptr<i32, CrossWorkgroup>, i32) -> !spirv.ptr<i32, CrossWorkgroup>
    "spirv.Store"(%15, %14) : (!spirv.ptr<i32, CrossWorkgroup>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xi1, #spirv.storage_class<CrossWorkgroup>>, index) -> i1, sym_name = "load_i1"}> ({
  ^bb0(%arg2: memref<4xi1, #spirv.storage_class<CrossWorkgroup>>, %arg3: index):
    %4 = "builtin.unrealized_conversion_cast"(%arg3) : (index) -> i32
    %5 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<4xi1, #spirv.storage_class<CrossWorkgroup>>) -> !spirv.ptr<!spirv.array<4 x i8>, CrossWorkgroup>
    %6 = "spirv.AccessChain"(%5, %4) : (!spirv.ptr<!spirv.array<4 x i8>, CrossWorkgroup>, i32) -> !spirv.ptr<i8, CrossWorkgroup>
    %7 = "spirv.Load"(%6) : (!spirv.ptr<i8, CrossWorkgroup>) -> i8
    %8 = "spirv.Constant"() <{value = 0 : i8}> : () -> i8
    %9 = "spirv.INotEqual"(%7, %8) : (i8, i8) -> i1
    "func.return"(%9) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xi1, #spirv.storage_class<CrossWorkgroup>>, index) -> (), sym_name = "store_i1"}> ({
  ^bb0(%arg0: memref<4xi1, #spirv.storage_class<CrossWorkgroup>>, %arg1: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i32
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<4xi1, #spirv.storage_class<CrossWorkgroup>>) -> !spirv.ptr<!spirv.array<4 x i8>, CrossWorkgroup>
    %2 = "spirv.AccessChain"(%1, %0) : (!spirv.ptr<!spirv.array<4 x i8>, CrossWorkgroup>, i32) -> !spirv.ptr<i8, CrossWorkgroup>
    %3 = "spirv.Constant"() <{value = 1 : i8}> : () -> i8
    "spirv.Store"(%2, %3) : (!spirv.ptr<i8, CrossWorkgroup>, i8) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel, Addresses, Int8, Int16, Int64, Float16, Float64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4xf32, #spirv.storage_class<CrossWorkgroup>>) -> memref<4xf32, #spirv.storage_class<Function>>, sym_name = "memory_space_cast"}> ({
  ^bb0(%arg0: memref<4xf32, #spirv.storage_class<CrossWorkgroup>>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<4xf32, #spirv.storage_class<CrossWorkgroup>>) -> !spirv.ptr<!spirv.array<4 x f32>, CrossWorkgroup>
    %1 = "spirv.PtrCastToGeneric"(%0) : (!spirv.ptr<!spirv.array<4 x f32>, CrossWorkgroup>) -> !spirv.ptr<!spirv.array<4 x f32>, Generic>
    %2 = "spirv.GenericCastToPtr"(%1) : (!spirv.ptr<!spirv.array<4 x f32>, Generic>) -> !spirv.ptr<!spirv.array<4 x f32>, Function>
    %3 = "builtin.unrealized_conversion_cast"(%2) : (!spirv.ptr<!spirv.array<4 x f32>, Function>) -> memref<4xf32, #spirv.storage_class<Function>>
    "func.return"(%3) : (memref<4xf32, #spirv.storage_class<Function>>) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel, Addresses, GenericPointer], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<i1, #spirv.storage_class<StorageBuffer>>) -> i1, sym_name = "load_i1"}> ({
  ^bb0(%arg3: memref<i1, #spirv.storage_class<StorageBuffer>>):
    %26 = "builtin.unrealized_conversion_cast"(%arg3) : (memref<i1, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>
    %27 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %28 = "spirv.AccessChain"(%26, %27, %27) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
    %29 = "spirv.Load"(%28) : (!spirv.ptr<i32, StorageBuffer>) -> i32
    %30 = "spirv.Constant"() <{value = 255 : i32}> : () -> i32
    %31 = "spirv.BitwiseAnd"(%29, %30) : (i32, i32) -> i32
    %32 = "spirv.Constant"() <{value = 24 : i32}> : () -> i32
    %33 = "spirv.ShiftLeftLogical"(%31, %32) : (i32, i32) -> i32
    %34 = "spirv.ShiftRightArithmetic"(%33, %32) : (i32, i32) -> i32
    %35 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %36 = "spirv.IEqual"(%34, %35) : (i32, i32) -> i1
    "func.return"(%36) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i8, #spirv.storage_class<StorageBuffer>>) -> i8, sym_name = "load_i8"}> ({
  ^bb0(%arg2: memref<i8, #spirv.storage_class<StorageBuffer>>):
    %16 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<i8, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>
    %17 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %18 = "spirv.AccessChain"(%16, %17, %17) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
    %19 = "spirv.Load"(%18) : (!spirv.ptr<i32, StorageBuffer>) -> i32
    %20 = "spirv.Constant"() <{value = 255 : i32}> : () -> i32
    %21 = "spirv.BitwiseAnd"(%19, %20) : (i32, i32) -> i32
    %22 = "spirv.Constant"() <{value = 24 : i32}> : () -> i32
    %23 = "spirv.ShiftLeftLogical"(%21, %22) : (i32, i32) -> i32
    %24 = "spirv.ShiftRightArithmetic"(%23, %22) : (i32, i32) -> i32
    %25 = "spirv.UConvert"(%24) : (i32) -> i8
    "func.return"(%25) : (i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xi16, #spirv.storage_class<StorageBuffer>>, index) -> i16, sym_name = "load_i16"}> ({
  ^bb0(%arg0: memref<10xi16, #spirv.storage_class<StorageBuffer>>, %arg1: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i32
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<10xi16, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<5 x i32, stride=4> [0])>, StorageBuffer>
    %2 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %3 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    %4 = "spirv.SDiv"(%0, %3) : (i32, i32) -> i32
    %5 = "spirv.AccessChain"(%1, %2, %4) : (!spirv.ptr<!spirv.struct<(!spirv.array<5 x i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
    %6 = "spirv.Load"(%5) : (!spirv.ptr<i32, StorageBuffer>) -> i32
    %7 = "spirv.Constant"() <{value = 16 : i32}> : () -> i32
    %8 = "spirv.UMod"(%0, %3) : (i32, i32) -> i32
    %9 = "spirv.IMul"(%8, %7) : (i32, i32) -> i32
    %10 = "spirv.ShiftRightArithmetic"(%6, %9) : (i32, i32) -> i32
    %11 = "spirv.Constant"() <{value = 65535 : i32}> : () -> i32
    %12 = "spirv.BitwiseAnd"(%10, %11) : (i32, i32) -> i32
    %13 = "spirv.ShiftLeftLogical"(%12, %7) : (i32, i32) -> i32
    %14 = "spirv.ShiftRightArithmetic"(%13, %7) : (i32, i32) -> i32
    %15 = "spirv.UConvert"(%14) : (i32) -> i16
    "func.return"(%15) : (i16) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int8, Int16], [SPV_KHR_8bit_storage, SPV_KHR_16bit_storage, SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, #spirv.storage_class<CrossWorkgroup>>, index) -> memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>>, sym_name = "reinterpret_cast"}> ({
  ^bb0(%arg2: memref<?xf32, #spirv.storage_class<CrossWorkgroup>>, %arg3: index):
    %6 = "builtin.unrealized_conversion_cast"(%arg3) : (index) -> i32
    %7 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<?xf32, #spirv.storage_class<CrossWorkgroup>>) -> !spirv.ptr<f32, CrossWorkgroup>
    %8 = "spirv.InBoundsPtrAccessChain"(%7, %6) : (!spirv.ptr<f32, CrossWorkgroup>, i32) -> !spirv.ptr<f32, CrossWorkgroup>
    %9 = "builtin.unrealized_conversion_cast"(%8) : (!spirv.ptr<f32, CrossWorkgroup>) -> memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>>
    "func.return"(%9) : (memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, #spirv.storage_class<CrossWorkgroup>>) -> memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>>, sym_name = "reinterpret_cast_0"}> ({
  ^bb0(%arg1: memref<?xf32, #spirv.storage_class<CrossWorkgroup>>):
    %4 = "builtin.unrealized_conversion_cast"(%arg1) : (memref<?xf32, #spirv.storage_class<CrossWorkgroup>>) -> !spirv.ptr<f32, CrossWorkgroup>
    %5 = "builtin.unrealized_conversion_cast"(%4) : (!spirv.ptr<f32, CrossWorkgroup>) -> memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>>
    "func.return"(%5) : (memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, #spirv.storage_class<CrossWorkgroup>>) -> memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>>, sym_name = "reinterpret_cast_5"}> ({
  ^bb0(%arg0: memref<?xf32, #spirv.storage_class<CrossWorkgroup>>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32, #spirv.storage_class<CrossWorkgroup>>) -> !spirv.ptr<f32, CrossWorkgroup>
    %1 = "spirv.Constant"() <{value = 5 : i32}> : () -> i32
    %2 = "spirv.InBoundsPtrAccessChain"(%0, %1) : (!spirv.ptr<f32, CrossWorkgroup>, i32) -> !spirv.ptr<f32, CrossWorkgroup>
    %3 = "builtin.unrealized_conversion_cast"(%2) : (!spirv.ptr<f32, CrossWorkgroup>) -> memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>>
    "func.return"(%3) : (memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>>) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel, Addresses, GenericPointer], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x?xf32, #spirv.storage_class<CrossWorkgroup>>) -> memref<?x4xf32, #spirv.storage_class<CrossWorkgroup>>, sym_name = "cast"}> ({
  ^bb0(%arg3: memref<4x?xf32, #spirv.storage_class<CrossWorkgroup>>):
    %3 = "builtin.unrealized_conversion_cast"(%arg3) : (memref<4x?xf32, #spirv.storage_class<CrossWorkgroup>>) -> !spirv.ptr<f32, CrossWorkgroup>
    %4 = "builtin.unrealized_conversion_cast"(%3) : (!spirv.ptr<f32, CrossWorkgroup>) -> memref<?x4xf32, #spirv.storage_class<CrossWorkgroup>>
    "func.return"(%4) : (memref<?x4xf32, #spirv.storage_class<CrossWorkgroup>>) -> ()
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
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32, #spirv.storage_class<CrossWorkgroup>>) -> !spirv.ptr<f32, CrossWorkgroup>
    %1 = "spirv.ConvertPtrToU"(%0) : (!spirv.ptr<f32, CrossWorkgroup>) -> i32
    %2 = "builtin.unrealized_conversion_cast"(%1) : (i32) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Kernel, Int64, Addresses, PhysicalStorageBufferAddresses], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, #spirv.storage_class<CrossWorkgroup>>) -> index, sym_name = "extract_aligned_pointer_as_index_shader"}> ({
  ^bb0(%arg0: memref<?xf32, #spirv.storage_class<CrossWorkgroup>>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32, #spirv.storage_class<CrossWorkgroup>>) -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32>)>, CrossWorkgroup>
    %1 = "spirv.ConvertPtrToU"(%0) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<f32>)>, CrossWorkgroup>) -> i32
    %2 = "builtin.unrealized_conversion_cast"(%1) : (i32) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, Int64, Addresses, PhysicalStorageBufferAddresses], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_nontemporal"}> ({
  ^bb0(%arg1: memref<f32, #spirv.storage_class<StorageBuffer>>):
    %4 = "builtin.unrealized_conversion_cast"(%arg1) : (memref<f32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>
    %5 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %6 = "spirv.AccessChain"(%4, %5, %5) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    %7 = "spirv.Load"(%6) <{memory_access = #spirv.memory_access<Nontemporal>}> : (!spirv.ptr<f32, StorageBuffer>) -> f32
    "spirv.Store"(%6, %7) <{memory_access = #spirv.memory_access<Nontemporal>}> : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32, #spirv.storage_class<PhysicalStorageBuffer>>) -> (), sym_name = "load_nontemporal_aligned"}> ({
  ^bb0(%arg0: memref<f32, #spirv.storage_class<PhysicalStorageBuffer>>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<f32, #spirv.storage_class<PhysicalStorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, PhysicalStorageBuffer>
    %1 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %2 = "spirv.AccessChain"(%0, %1, %1) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, PhysicalStorageBuffer>, i32, i32) -> !spirv.ptr<f32, PhysicalStorageBuffer>
    %3 = "spirv.Load"(%2) <{alignment = 4 : i32, memory_access = #spirv.memory_access<Aligned|Nontemporal>}> : (!spirv.ptr<f32, PhysicalStorageBuffer>) -> f32
    "spirv.Store"(%2, %3) <{alignment = 4 : i32, memory_access = #spirv.memory_access<Aligned|Nontemporal>}> : (!spirv.ptr<f32, PhysicalStorageBuffer>, f32) -> ()
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
    %185 = "builtin.unrealized_conversion_cast"(%arg27) : (memref<1xf32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>
    %186 = "builtin.unrealized_conversion_cast"(%arg26) : (memref<1xf32, #spirv.storage_class<Image>>) -> !spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim1D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>, UniformConstant>
    %187 = "arith.constant"() <{value = 0 : index}> : () -> index
    %188 = "builtin.unrealized_conversion_cast"(%187) : (index) -> i32
    %189 = "spirv.Load"(%186) : (!spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim1D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>, UniformConstant>) -> !spirv.sampled_image<!spirv.image<f32, Dim1D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>
    %190 = "spirv.Image"(%189) : (!spirv.sampled_image<!spirv.image<f32, Dim1D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>) -> !spirv.image<f32, Dim1D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>
    %191 = "spirv.ImageFetch"(%190, %188) : (!spirv.image<f32, Dim1D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>, i32) -> vector<4xf32>
    %192 = "spirv.CompositeExtract"(%191) <{indices = [0 : i32]}> : (vector<4xf32>) -> f32
    %193 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %194 = "spirv.AccessChain"(%185, %193, %188) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    "spirv.Store"(%194, %192) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x4xf32, #spirv.storage_class<Image>>, memref<2x4xf32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_image_2D"}> ({
  ^bb0(%arg24: memref<2x4xf32, #spirv.storage_class<Image>>, %arg25: memref<2x4xf32, #spirv.storage_class<StorageBuffer>>):
    %169 = "builtin.unrealized_conversion_cast"(%arg25) : (memref<2x4xf32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<8 x f32, stride=4> [0])>, StorageBuffer>
    %170 = "builtin.unrealized_conversion_cast"(%arg24) : (memref<2x4xf32, #spirv.storage_class<Image>>) -> !spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>, UniformConstant>
    %171 = "arith.constant"() <{value = 3 : index}> : () -> index
    %172 = "builtin.unrealized_conversion_cast"(%171) : (index) -> i32
    %173 = "arith.constant"() <{value = 1 : index}> : () -> index
    %174 = "builtin.unrealized_conversion_cast"(%173) : (index) -> i32
    %175 = "spirv.Load"(%170) : (!spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>, UniformConstant>) -> !spirv.sampled_image<!spirv.image<f32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>
    %176 = "spirv.Image"(%175) : (!spirv.sampled_image<!spirv.image<f32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>) -> !spirv.image<f32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>
    %177 = "spirv.CompositeConstruct"(%172, %174) : (i32, i32) -> vector<2xi32>
    %178 = "spirv.ImageFetch"(%176, %177) : (!spirv.image<f32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>, vector<2xi32>) -> vector<4xf32>
    %179 = "spirv.CompositeExtract"(%178) <{indices = [0 : i32]}> : (vector<4xf32>) -> f32
    %180 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %181 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %182 = "spirv.IMul"(%174, %181) : (i32, i32) -> i32
    %183 = "spirv.IAdd"(%172, %182) : (i32, i32) -> i32
    %184 = "spirv.AccessChain"(%169, %180, %183) : (!spirv.ptr<!spirv.struct<(!spirv.array<8 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    "spirv.Store"(%184, %179) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x4xf32, #map, #spirv.storage_class<Image>>, memref<2x4xf32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_col_major_image_2D"}> ({
  ^bb0(%arg22: memref<2x4xf32, #map, #spirv.storage_class<Image>>, %arg23: memref<2x4xf32, #spirv.storage_class<StorageBuffer>>):
    %153 = "builtin.unrealized_conversion_cast"(%arg23) : (memref<2x4xf32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<8 x f32, stride=4> [0])>, StorageBuffer>
    %154 = "builtin.unrealized_conversion_cast"(%arg22) : (memref<2x4xf32, #map, #spirv.storage_class<Image>>) -> !spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>, UniformConstant>
    %155 = "arith.constant"() <{value = 3 : index}> : () -> index
    %156 = "builtin.unrealized_conversion_cast"(%155) : (index) -> i32
    %157 = "arith.constant"() <{value = 1 : index}> : () -> index
    %158 = "builtin.unrealized_conversion_cast"(%157) : (index) -> i32
    %159 = "spirv.Load"(%154) : (!spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>, UniformConstant>) -> !spirv.sampled_image<!spirv.image<f32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>
    %160 = "spirv.Image"(%159) : (!spirv.sampled_image<!spirv.image<f32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>) -> !spirv.image<f32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>
    %161 = "spirv.CompositeConstruct"(%156, %158) : (i32, i32) -> vector<2xi32>
    %162 = "spirv.ImageFetch"(%160, %161) : (!spirv.image<f32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>, vector<2xi32>) -> vector<4xf32>
    %163 = "spirv.CompositeExtract"(%162) <{indices = [0 : i32]}> : (vector<4xf32>) -> f32
    %164 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %165 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %166 = "spirv.IMul"(%158, %165) : (i32, i32) -> i32
    %167 = "spirv.IAdd"(%156, %166) : (i32, i32) -> i32
    %168 = "spirv.AccessChain"(%153, %164, %167) : (!spirv.ptr<!spirv.struct<(!spirv.array<8 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    "spirv.Store"(%168, %163) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x3x4xf32, #spirv.storage_class<Image>>, memref<2x3x4xf32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_image_3D"}> ({
  ^bb0(%arg20: memref<2x3x4xf32, #spirv.storage_class<Image>>, %arg21: memref<2x3x4xf32, #spirv.storage_class<StorageBuffer>>):
    %132 = "builtin.unrealized_conversion_cast"(%arg21) : (memref<2x3x4xf32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<24 x f32, stride=4> [0])>, StorageBuffer>
    %133 = "builtin.unrealized_conversion_cast"(%arg20) : (memref<2x3x4xf32, #spirv.storage_class<Image>>) -> !spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim3D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>, UniformConstant>
    %134 = "arith.constant"() <{value = 3 : index}> : () -> index
    %135 = "builtin.unrealized_conversion_cast"(%134) : (index) -> i32
    %136 = "arith.constant"() <{value = 2 : index}> : () -> index
    %137 = "builtin.unrealized_conversion_cast"(%136) : (index) -> i32
    %138 = "arith.constant"() <{value = 1 : index}> : () -> index
    %139 = "builtin.unrealized_conversion_cast"(%138) : (index) -> i32
    %140 = "spirv.Load"(%133) : (!spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim3D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>, UniformConstant>) -> !spirv.sampled_image<!spirv.image<f32, Dim3D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>
    %141 = "spirv.Image"(%140) : (!spirv.sampled_image<!spirv.image<f32, Dim3D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>) -> !spirv.image<f32, Dim3D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>
    %142 = "spirv.CompositeConstruct"(%135, %137, %139) : (i32, i32, i32) -> vector<3xi32>
    %143 = "spirv.ImageFetch"(%141, %142) : (!spirv.image<f32, Dim3D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>, vector<3xi32>) -> vector<4xf32>
    %144 = "spirv.CompositeExtract"(%143) <{indices = [0 : i32]}> : (vector<4xf32>) -> f32
    %145 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %146 = "spirv.Constant"() <{value = 12 : i32}> : () -> i32
    %147 = "spirv.IMul"(%139, %146) : (i32, i32) -> i32
    %148 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %149 = "spirv.IMul"(%137, %148) : (i32, i32) -> i32
    %150 = "spirv.IAdd"(%149, %147) : (i32, i32) -> i32
    %151 = "spirv.IAdd"(%135, %150) : (i32, i32) -> i32
    %152 = "spirv.AccessChain"(%132, %145, %151) : (!spirv.ptr<!spirv.struct<(!spirv.array<24 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    "spirv.Store"(%152, %144) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x3x4xf32, #map1, #spirv.storage_class<Image>>, memref<2x3x4xf32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_custom_layout_image_3D"}> ({
  ^bb0(%arg18: memref<2x3x4xf32, #map1, #spirv.storage_class<Image>>, %arg19: memref<2x3x4xf32, #spirv.storage_class<StorageBuffer>>):
    %111 = "builtin.unrealized_conversion_cast"(%arg19) : (memref<2x3x4xf32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<24 x f32, stride=4> [0])>, StorageBuffer>
    %112 = "builtin.unrealized_conversion_cast"(%arg18) : (memref<2x3x4xf32, #map1, #spirv.storage_class<Image>>) -> !spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim3D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>, UniformConstant>
    %113 = "arith.constant"() <{value = 3 : index}> : () -> index
    %114 = "builtin.unrealized_conversion_cast"(%113) : (index) -> i32
    %115 = "arith.constant"() <{value = 2 : index}> : () -> index
    %116 = "builtin.unrealized_conversion_cast"(%115) : (index) -> i32
    %117 = "arith.constant"() <{value = 1 : index}> : () -> index
    %118 = "builtin.unrealized_conversion_cast"(%117) : (index) -> i32
    %119 = "spirv.Load"(%112) : (!spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim3D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>, UniformConstant>) -> !spirv.sampled_image<!spirv.image<f32, Dim3D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>
    %120 = "spirv.Image"(%119) : (!spirv.sampled_image<!spirv.image<f32, Dim3D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>) -> !spirv.image<f32, Dim3D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>
    %121 = "spirv.CompositeConstruct"(%114, %116, %118) : (i32, i32, i32) -> vector<3xi32>
    %122 = "spirv.ImageFetch"(%120, %121) : (!spirv.image<f32, Dim3D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>, vector<3xi32>) -> vector<4xf32>
    %123 = "spirv.CompositeExtract"(%122) <{indices = [0 : i32]}> : (vector<4xf32>) -> f32
    %124 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %125 = "spirv.Constant"() <{value = 12 : i32}> : () -> i32
    %126 = "spirv.IMul"(%118, %125) : (i32, i32) -> i32
    %127 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %128 = "spirv.IMul"(%116, %127) : (i32, i32) -> i32
    %129 = "spirv.IAdd"(%128, %126) : (i32, i32) -> i32
    %130 = "spirv.IAdd"(%114, %129) : (i32, i32) -> i32
    %131 = "spirv.AccessChain"(%111, %124, %130) : (!spirv.ptr<!spirv.struct<(!spirv.array<24 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    "spirv.Store"(%131, %123) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x3xf16, #spirv.storage_class<Image>>, memref<2x3xf16, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_image_2D_f16"}> ({
  ^bb0(%arg16: memref<2x3xf16, #spirv.storage_class<Image>>, %arg17: memref<2x3xf16, #spirv.storage_class<StorageBuffer>>):
    %95 = "builtin.unrealized_conversion_cast"(%arg17) : (memref<2x3xf16, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<6 x f16, stride=2> [0])>, StorageBuffer>
    %96 = "builtin.unrealized_conversion_cast"(%arg16) : (memref<2x3xf16, #spirv.storage_class<Image>>) -> !spirv.ptr<!spirv.sampled_image<!spirv.image<f16, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R16f>>, UniformConstant>
    %97 = "arith.constant"() <{value = 2 : index}> : () -> index
    %98 = "builtin.unrealized_conversion_cast"(%97) : (index) -> i32
    %99 = "arith.constant"() <{value = 1 : index}> : () -> index
    %100 = "builtin.unrealized_conversion_cast"(%99) : (index) -> i32
    %101 = "spirv.Load"(%96) : (!spirv.ptr<!spirv.sampled_image<!spirv.image<f16, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R16f>>, UniformConstant>) -> !spirv.sampled_image<!spirv.image<f16, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R16f>>
    %102 = "spirv.Image"(%101) : (!spirv.sampled_image<!spirv.image<f16, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R16f>>) -> !spirv.image<f16, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R16f>
    %103 = "spirv.CompositeConstruct"(%98, %100) : (i32, i32) -> vector<2xi32>
    %104 = "spirv.ImageFetch"(%102, %103) : (!spirv.image<f16, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R16f>, vector<2xi32>) -> vector<4xf16>
    %105 = "spirv.CompositeExtract"(%104) <{indices = [0 : i32]}> : (vector<4xf16>) -> f16
    %106 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %107 = "spirv.Constant"() <{value = 3 : i32}> : () -> i32
    %108 = "spirv.IMul"(%100, %107) : (i32, i32) -> i32
    %109 = "spirv.IAdd"(%98, %108) : (i32, i32) -> i32
    %110 = "spirv.AccessChain"(%95, %106, %109) : (!spirv.ptr<!spirv.struct<(!spirv.array<6 x f16, stride=2> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f16, StorageBuffer>
    "spirv.Store"(%110, %105) : (!spirv.ptr<f16, StorageBuffer>, f16) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x3xi32, #spirv.storage_class<Image>>, memref<2x3xi32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_image_2D_i32"}> ({
  ^bb0(%arg14: memref<2x3xi32, #spirv.storage_class<Image>>, %arg15: memref<2x3xi32, #spirv.storage_class<StorageBuffer>>):
    %79 = "builtin.unrealized_conversion_cast"(%arg15) : (memref<2x3xi32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<6 x i32, stride=4> [0])>, StorageBuffer>
    %80 = "builtin.unrealized_conversion_cast"(%arg14) : (memref<2x3xi32, #spirv.storage_class<Image>>) -> !spirv.ptr<!spirv.sampled_image<!spirv.image<i32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32i>>, UniformConstant>
    %81 = "arith.constant"() <{value = 2 : index}> : () -> index
    %82 = "builtin.unrealized_conversion_cast"(%81) : (index) -> i32
    %83 = "arith.constant"() <{value = 1 : index}> : () -> index
    %84 = "builtin.unrealized_conversion_cast"(%83) : (index) -> i32
    %85 = "spirv.Load"(%80) : (!spirv.ptr<!spirv.sampled_image<!spirv.image<i32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32i>>, UniformConstant>) -> !spirv.sampled_image<!spirv.image<i32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32i>>
    %86 = "spirv.Image"(%85) : (!spirv.sampled_image<!spirv.image<i32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32i>>) -> !spirv.image<i32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32i>
    %87 = "spirv.CompositeConstruct"(%82, %84) : (i32, i32) -> vector<2xi32>
    %88 = "spirv.ImageFetch"(%86, %87) : (!spirv.image<i32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32i>, vector<2xi32>) -> vector<4xi32>
    %89 = "spirv.CompositeExtract"(%88) <{indices = [0 : i32]}> : (vector<4xi32>) -> i32
    %90 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %91 = "spirv.Constant"() <{value = 3 : i32}> : () -> i32
    %92 = "spirv.IMul"(%84, %91) : (i32, i32) -> i32
    %93 = "spirv.IAdd"(%82, %92) : (i32, i32) -> i32
    %94 = "spirv.AccessChain"(%79, %90, %93) : (!spirv.ptr<!spirv.struct<(!spirv.array<6 x i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
    "spirv.Store"(%94, %89) : (!spirv.ptr<i32, StorageBuffer>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x3xui32, #spirv.storage_class<Image>>, memref<2x3xui32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_image_2D_ui32"}> ({
  ^bb0(%arg12: memref<2x3xui32, #spirv.storage_class<Image>>, %arg13: memref<2x3xui32, #spirv.storage_class<StorageBuffer>>):
    %63 = "builtin.unrealized_conversion_cast"(%arg13) : (memref<2x3xui32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<6 x ui32, stride=4> [0])>, StorageBuffer>
    %64 = "builtin.unrealized_conversion_cast"(%arg12) : (memref<2x3xui32, #spirv.storage_class<Image>>) -> !spirv.ptr<!spirv.sampled_image<!spirv.image<ui32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32ui>>, UniformConstant>
    %65 = "arith.constant"() <{value = 2 : index}> : () -> index
    %66 = "builtin.unrealized_conversion_cast"(%65) : (index) -> i32
    %67 = "arith.constant"() <{value = 1 : index}> : () -> index
    %68 = "builtin.unrealized_conversion_cast"(%67) : (index) -> i32
    %69 = "spirv.Load"(%64) : (!spirv.ptr<!spirv.sampled_image<!spirv.image<ui32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32ui>>, UniformConstant>) -> !spirv.sampled_image<!spirv.image<ui32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32ui>>
    %70 = "spirv.Image"(%69) : (!spirv.sampled_image<!spirv.image<ui32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32ui>>) -> !spirv.image<ui32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32ui>
    %71 = "spirv.CompositeConstruct"(%66, %68) : (i32, i32) -> vector<2xi32>
    %72 = "spirv.ImageFetch"(%70, %71) : (!spirv.image<ui32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32ui>, vector<2xi32>) -> vector<4xui32>
    %73 = "spirv.CompositeExtract"(%72) <{indices = [0 : i32]}> : (vector<4xui32>) -> ui32
    %74 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %75 = "spirv.Constant"() <{value = 3 : i32}> : () -> i32
    %76 = "spirv.IMul"(%68, %75) : (i32, i32) -> i32
    %77 = "spirv.IAdd"(%66, %76) : (i32, i32) -> i32
    %78 = "spirv.AccessChain"(%63, %74, %77) : (!spirv.ptr<!spirv.struct<(!spirv.array<6 x ui32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<ui32, StorageBuffer>
    "spirv.Store"(%78, %73) : (!spirv.ptr<ui32, StorageBuffer>, ui32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x3xi16, #spirv.storage_class<Image>>, memref<2x3xi16, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_image_2D_i16"}> ({
  ^bb0(%arg10: memref<2x3xi16, #spirv.storage_class<Image>>, %arg11: memref<2x3xi16, #spirv.storage_class<StorageBuffer>>):
    %47 = "builtin.unrealized_conversion_cast"(%arg11) : (memref<2x3xi16, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<6 x i16, stride=2> [0])>, StorageBuffer>
    %48 = "builtin.unrealized_conversion_cast"(%arg10) : (memref<2x3xi16, #spirv.storage_class<Image>>) -> !spirv.ptr<!spirv.sampled_image<!spirv.image<i16, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R16i>>, UniformConstant>
    %49 = "arith.constant"() <{value = 2 : index}> : () -> index
    %50 = "builtin.unrealized_conversion_cast"(%49) : (index) -> i32
    %51 = "arith.constant"() <{value = 1 : index}> : () -> index
    %52 = "builtin.unrealized_conversion_cast"(%51) : (index) -> i32
    %53 = "spirv.Load"(%48) : (!spirv.ptr<!spirv.sampled_image<!spirv.image<i16, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R16i>>, UniformConstant>) -> !spirv.sampled_image<!spirv.image<i16, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R16i>>
    %54 = "spirv.Image"(%53) : (!spirv.sampled_image<!spirv.image<i16, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R16i>>) -> !spirv.image<i16, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R16i>
    %55 = "spirv.CompositeConstruct"(%50, %52) : (i32, i32) -> vector<2xi32>
    %56 = "spirv.ImageFetch"(%54, %55) : (!spirv.image<i16, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R16i>, vector<2xi32>) -> vector<4xi16>
    %57 = "spirv.CompositeExtract"(%56) <{indices = [0 : i32]}> : (vector<4xi16>) -> i16
    %58 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %59 = "spirv.Constant"() <{value = 3 : i32}> : () -> i32
    %60 = "spirv.IMul"(%52, %59) : (i32, i32) -> i32
    %61 = "spirv.IAdd"(%50, %60) : (i32, i32) -> i32
    %62 = "spirv.AccessChain"(%47, %58, %61) : (!spirv.ptr<!spirv.struct<(!spirv.array<6 x i16, stride=2> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i16, StorageBuffer>
    "spirv.Store"(%62, %57) : (!spirv.ptr<i16, StorageBuffer>, i16) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x3xui16, #spirv.storage_class<Image>>, memref<2x3xui16, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_image_2D_ui16"}> ({
  ^bb0(%arg8: memref<2x3xui16, #spirv.storage_class<Image>>, %arg9: memref<2x3xui16, #spirv.storage_class<StorageBuffer>>):
    %31 = "builtin.unrealized_conversion_cast"(%arg9) : (memref<2x3xui16, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<6 x ui16, stride=2> [0])>, StorageBuffer>
    %32 = "builtin.unrealized_conversion_cast"(%arg8) : (memref<2x3xui16, #spirv.storage_class<Image>>) -> !spirv.ptr<!spirv.sampled_image<!spirv.image<ui16, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R16ui>>, UniformConstant>
    %33 = "arith.constant"() <{value = 2 : index}> : () -> index
    %34 = "builtin.unrealized_conversion_cast"(%33) : (index) -> i32
    %35 = "arith.constant"() <{value = 1 : index}> : () -> index
    %36 = "builtin.unrealized_conversion_cast"(%35) : (index) -> i32
    %37 = "spirv.Load"(%32) : (!spirv.ptr<!spirv.sampled_image<!spirv.image<ui16, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R16ui>>, UniformConstant>) -> !spirv.sampled_image<!spirv.image<ui16, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R16ui>>
    %38 = "spirv.Image"(%37) : (!spirv.sampled_image<!spirv.image<ui16, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R16ui>>) -> !spirv.image<ui16, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R16ui>
    %39 = "spirv.CompositeConstruct"(%34, %36) : (i32, i32) -> vector<2xi32>
    %40 = "spirv.ImageFetch"(%38, %39) : (!spirv.image<ui16, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R16ui>, vector<2xi32>) -> vector<4xui16>
    %41 = "spirv.CompositeExtract"(%40) <{indices = [0 : i32]}> : (vector<4xui16>) -> ui16
    %42 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %43 = "spirv.Constant"() <{value = 3 : i32}> : () -> i32
    %44 = "spirv.IMul"(%36, %43) : (i32, i32) -> i32
    %45 = "spirv.IAdd"(%34, %44) : (i32, i32) -> i32
    %46 = "spirv.AccessChain"(%31, %42, %45) : (!spirv.ptr<!spirv.struct<(!spirv.array<6 x ui16, stride=2> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<ui16, StorageBuffer>
    "spirv.Store"(%46, %41) : (!spirv.ptr<ui16, StorageBuffer>, ui16) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32, #spirv.storage_class<Image>>, memref<f32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_image_2D_rank0"}> ({
  ^bb0(%arg6: memref<f32, #spirv.storage_class<Image>>, %arg7: memref<f32, #spirv.storage_class<StorageBuffer>>):
    %27 = "builtin.unrealized_conversion_cast"(%arg7) : (memref<f32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>
    %28 = "memref.load"(%arg6) : (memref<f32, #spirv.storage_class<Image>>) -> f32
    %29 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %30 = "spirv.AccessChain"(%27, %29, %29) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    "spirv.Store"(%30, %28) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1x1x1x1xf32, #spirv.storage_class<Image>>, memref<1x1x1x1xf32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_image_2D_rank4"}> ({
  ^bb0(%arg4: memref<1x1x1x1xf32, #spirv.storage_class<Image>>, %arg5: memref<1x1x1x1xf32, #spirv.storage_class<StorageBuffer>>):
    %18 = "builtin.unrealized_conversion_cast"(%arg5) : (memref<1x1x1x1xf32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>
    %19 = "arith.constant"() <{value = 0 : index}> : () -> index
    %20 = "builtin.unrealized_conversion_cast"(%19) : (index) -> i32
    %21 = "memref.load"(%arg4, %19, %19, %19, %19) : (memref<1x1x1x1xf32, #spirv.storage_class<Image>>, index, index, index, index) -> f32
    %22 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %23 = "spirv.IAdd"(%20, %20) : (i32, i32) -> i32
    %24 = "spirv.IAdd"(%20, %23) : (i32, i32) -> i32
    %25 = "spirv.IAdd"(%20, %24) : (i32, i32) -> i32
    %26 = "spirv.AccessChain"(%18, %22, %25) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    "spirv.Store"(%26, %21) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1xvector<1xf32>, #spirv.storage_class<Image>>, memref<1xvector<1xf32>, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_image_2D_vector"}> ({
  ^bb0(%arg2: memref<1xvector<1xf32>, #spirv.storage_class<Image>>, %arg3: memref<1xvector<1xf32>, #spirv.storage_class<StorageBuffer>>):
    %11 = "builtin.unrealized_conversion_cast"(%arg3) : (memref<1xvector<1xf32>, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>
    %12 = "arith.constant"() <{value = 0 : index}> : () -> index
    %13 = "builtin.unrealized_conversion_cast"(%12) : (index) -> i32
    %14 = "memref.load"(%arg2, %12) : (memref<1xvector<1xf32>, #spirv.storage_class<Image>>, index) -> vector<1xf32>
    %15 = "builtin.unrealized_conversion_cast"(%14) : (vector<1xf32>) -> f32
    %16 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %17 = "spirv.AccessChain"(%11, %16, %13) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    "spirv.Store"(%17, %15) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x4xf32, #map2, #spirv.storage_class<Image>>, memref<2x4xf32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_non_perm_layout"}> ({
  ^bb0(%arg0: memref<2x4xf32, #map2, #spirv.storage_class<Image>>, %arg1: memref<2x4xf32, #spirv.storage_class<StorageBuffer>>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (memref<2x4xf32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<8 x f32, stride=4> [0])>, StorageBuffer>
    %1 = "arith.constant"() <{value = 3 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i32
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "builtin.unrealized_conversion_cast"(%3) : (index) -> i32
    %5 = "memref.load"(%arg0, %3, %1) : (memref<2x4xf32, #map2, #spirv.storage_class<Image>>, index, index) -> f32
    %6 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %7 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %8 = "spirv.IMul"(%4, %7) : (i32, i32) -> i32
    %9 = "spirv.IAdd"(%2, %8) : (i32, i32) -> i32
    %10 = "spirv.AccessChain"(%0, %6, %9) : (!spirv.ptr<!spirv.struct<(!spirv.array<8 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    "spirv.Store"(%10, %5) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, PhysicalStorageBufferAddresses, Image1D, StorageImageExtendedFormats, Float16, StorageBuffer16BitAccess, StorageUniform16, Int16], [SPV_KHR_storage_buffer_storage_class, SPV_KHR_physical_storage_buffer, SPV_KHR_16bit_storage]>, #spirv.resource_limits<>>} : () -> ()

