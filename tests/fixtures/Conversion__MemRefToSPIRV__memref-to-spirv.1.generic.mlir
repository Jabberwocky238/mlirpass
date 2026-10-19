"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32, #spirv.storage_class<StorageBuffer>>, memref<f32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_store_zero_rank_float"}> ({
  ^bb0(%arg24: memref<f32, #spirv.storage_class<StorageBuffer>>, %arg25: memref<f32, #spirv.storage_class<StorageBuffer>>):
    %78 = "builtin.unrealized_conversion_cast"(%arg25) : (memref<f32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>
    %79 = "builtin.unrealized_conversion_cast"(%arg24) : (memref<f32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>
    %80 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %81 = "spirv.AccessChain"(%79, %80, %80) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>, i64, i64) -> !spirv.ptr<f32, StorageBuffer>
    %82 = "spirv.Load"(%81) : (!spirv.ptr<f32, StorageBuffer>) -> f32
    %83 = "spirv.AccessChain"(%78, %80, %80) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>, i64, i64) -> !spirv.ptr<f32, StorageBuffer>
    "spirv.Store"(%83, %82) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i32, #spirv.storage_class<StorageBuffer>>, memref<i32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_store_zero_rank_int"}> ({
  ^bb0(%arg22: memref<i32, #spirv.storage_class<StorageBuffer>>, %arg23: memref<i32, #spirv.storage_class<StorageBuffer>>):
    %72 = "builtin.unrealized_conversion_cast"(%arg23) : (memref<i32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>
    %73 = "builtin.unrealized_conversion_cast"(%arg22) : (memref<i32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>
    %74 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %75 = "spirv.AccessChain"(%73, %74, %74) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>, i64, i64) -> !spirv.ptr<i32, StorageBuffer>
    %76 = "spirv.Load"(%75) : (!spirv.ptr<i32, StorageBuffer>) -> i32
    %77 = "spirv.AccessChain"(%72, %74, %74) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>, i64, i64) -> !spirv.ptr<i32, StorageBuffer>
    "spirv.Store"(%77, %76) : (!spirv.ptr<i32, StorageBuffer>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, memref<?xi32, #spirv.storage_class<StorageBuffer>>, memref<?xi32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_store_unknown_dim"}> ({
  ^bb0(%arg19: index, %arg20: memref<?xi32, #spirv.storage_class<StorageBuffer>>, %arg21: memref<?xi32, #spirv.storage_class<StorageBuffer>>):
    %65 = "builtin.unrealized_conversion_cast"(%arg21) : (memref<?xi32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>
    %66 = "builtin.unrealized_conversion_cast"(%arg19) : (index) -> i64
    %67 = "builtin.unrealized_conversion_cast"(%arg20) : (memref<?xi32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>
    %68 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %69 = "spirv.AccessChain"(%67, %68, %66) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>, i64, i64) -> !spirv.ptr<i32, StorageBuffer>
    %70 = "spirv.Load"(%69) : (!spirv.ptr<i32, StorageBuffer>) -> i32
    %71 = "spirv.AccessChain"(%65, %68, %66) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>, i64, i64) -> !spirv.ptr<i32, StorageBuffer>
    "spirv.Store"(%71, %70) : (!spirv.ptr<i32, StorageBuffer>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xi1, #spirv.storage_class<StorageBuffer>>, index) -> i1, sym_name = "load_i1"}> ({
  ^bb0(%arg17: memref<4xi1, #spirv.storage_class<StorageBuffer>>, %arg18: index):
    %58 = "builtin.unrealized_conversion_cast"(%arg18) : (index) -> i64
    %59 = "builtin.unrealized_conversion_cast"(%arg17) : (memref<4xi1, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<4 x i8, stride=1> [0])>, StorageBuffer>
    %60 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %61 = "spirv.AccessChain"(%59, %60, %58) : (!spirv.ptr<!spirv.struct<(!spirv.array<4 x i8, stride=1> [0])>, StorageBuffer>, i64, i64) -> !spirv.ptr<i8, StorageBuffer>
    %62 = "spirv.Load"(%61) : (!spirv.ptr<i8, StorageBuffer>) -> i8
    %63 = "spirv.Constant"() <{value = 0 : i8}> : () -> i8
    %64 = "spirv.INotEqual"(%62, %63) : (i8, i8) -> i1
    "func.return"(%64) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xi1, #spirv.storage_class<StorageBuffer>>, index) -> i1, sym_name = "load_aligned"}> ({
  ^bb0(%arg15: memref<4xi1, #spirv.storage_class<StorageBuffer>>, %arg16: index):
    %51 = "builtin.unrealized_conversion_cast"(%arg16) : (index) -> i64
    %52 = "builtin.unrealized_conversion_cast"(%arg15) : (memref<4xi1, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<4 x i8, stride=1> [0])>, StorageBuffer>
    %53 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %54 = "spirv.AccessChain"(%52, %53, %51) : (!spirv.ptr<!spirv.struct<(!spirv.array<4 x i8, stride=1> [0])>, StorageBuffer>, i64, i64) -> !spirv.ptr<i8, StorageBuffer>
    %55 = "spirv.Load"(%54) <{alignment = 32 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<i8, StorageBuffer>) -> i8
    %56 = "spirv.Constant"() <{value = 0 : i8}> : () -> i8
    %57 = "spirv.INotEqual"(%55, %56) : (i8, i8) -> i1
    "func.return"(%57) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xi1, #spirv.storage_class<StorageBuffer>>, index) -> i1, sym_name = "load_aligned_nontemporal"}> ({
  ^bb0(%arg13: memref<4xi1, #spirv.storage_class<StorageBuffer>>, %arg14: index):
    %44 = "builtin.unrealized_conversion_cast"(%arg14) : (index) -> i64
    %45 = "builtin.unrealized_conversion_cast"(%arg13) : (memref<4xi1, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<4 x i8, stride=1> [0])>, StorageBuffer>
    %46 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %47 = "spirv.AccessChain"(%45, %46, %44) : (!spirv.ptr<!spirv.struct<(!spirv.array<4 x i8, stride=1> [0])>, StorageBuffer>, i64, i64) -> !spirv.ptr<i8, StorageBuffer>
    %48 = "spirv.Load"(%47) <{alignment = 32 : i32, memory_access = #spirv.memory_access<Aligned|Nontemporal>}> : (!spirv.ptr<i8, StorageBuffer>) -> i8
    %49 = "spirv.Constant"() <{value = 0 : i8}> : () -> i8
    %50 = "spirv.INotEqual"(%48, %49) : (i8, i8) -> i1
    "func.return"(%50) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xi1, #spirv.storage_class<PhysicalStorageBuffer>>, index) -> i1, sym_name = "load_aligned_psb"}> ({
  ^bb0(%arg11: memref<4xi1, #spirv.storage_class<PhysicalStorageBuffer>>, %arg12: index):
    %37 = "builtin.unrealized_conversion_cast"(%arg12) : (index) -> i64
    %38 = "builtin.unrealized_conversion_cast"(%arg11) : (memref<4xi1, #spirv.storage_class<PhysicalStorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<4 x i8, stride=1> [0])>, PhysicalStorageBuffer>
    %39 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %40 = "spirv.AccessChain"(%38, %39, %37) : (!spirv.ptr<!spirv.struct<(!spirv.array<4 x i8, stride=1> [0])>, PhysicalStorageBuffer>, i64, i64) -> !spirv.ptr<i8, PhysicalStorageBuffer>
    %41 = "spirv.Load"(%40) <{alignment = 32 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<i8, PhysicalStorageBuffer>) -> i8
    %42 = "spirv.Constant"() <{value = 0 : i8}> : () -> i8
    %43 = "spirv.INotEqual"(%41, %42) : (i8, i8) -> i1
    "func.return"(%43) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xi1, #spirv.storage_class<StorageBuffer>>, index) -> (), sym_name = "store_i1"}> ({
  ^bb0(%arg9: memref<4xi1, #spirv.storage_class<StorageBuffer>>, %arg10: index):
    %32 = "builtin.unrealized_conversion_cast"(%arg10) : (index) -> i64
    %33 = "builtin.unrealized_conversion_cast"(%arg9) : (memref<4xi1, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<4 x i8, stride=1> [0])>, StorageBuffer>
    %34 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %35 = "spirv.AccessChain"(%33, %34, %32) : (!spirv.ptr<!spirv.struct<(!spirv.array<4 x i8, stride=1> [0])>, StorageBuffer>, i64, i64) -> !spirv.ptr<i8, StorageBuffer>
    %36 = "spirv.Constant"() <{value = 1 : i8}> : () -> i8
    "spirv.Store"(%35, %36) : (!spirv.ptr<i8, StorageBuffer>, i8) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i16, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_i16"}> ({
  ^bb0(%arg8: memref<i16, #spirv.storage_class<StorageBuffer>>):
    %28 = "builtin.unrealized_conversion_cast"(%arg8) : (memref<i16, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x i16, stride=2> [0])>, StorageBuffer>
    %29 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %30 = "spirv.AccessChain"(%28, %29, %29) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i16, stride=2> [0])>, StorageBuffer>, i64, i64) -> !spirv.ptr<i16, StorageBuffer>
    %31 = "spirv.Load"(%30) : (!spirv.ptr<i16, StorageBuffer>) -> i16
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xi16, #spirv.storage_class<StorageBuffer>>, index, i16) -> (), sym_name = "store_i16"}> ({
  ^bb0(%arg5: memref<10xi16, #spirv.storage_class<StorageBuffer>>, %arg6: index, %arg7: i16):
    %24 = "builtin.unrealized_conversion_cast"(%arg6) : (index) -> i64
    %25 = "builtin.unrealized_conversion_cast"(%arg5) : (memref<10xi16, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<10 x i16, stride=2> [0])>, StorageBuffer>
    %26 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %27 = "spirv.AccessChain"(%25, %26, %24) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x i16, stride=2> [0])>, StorageBuffer>, i64, i64) -> !spirv.ptr<i16, StorageBuffer>
    "spirv.Store"(%27, %arg7) : (!spirv.ptr<i16, StorageBuffer>, i16) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i32, #spirv.storage_class<PhysicalStorageBuffer>>) -> (), sym_name = "load_store_i32_physical"}> ({
  ^bb0(%arg4: memref<i32, #spirv.storage_class<PhysicalStorageBuffer>>):
    %20 = "builtin.unrealized_conversion_cast"(%arg4) : (memref<i32, #spirv.storage_class<PhysicalStorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, PhysicalStorageBuffer>
    %21 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %22 = "spirv.AccessChain"(%20, %21, %21) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, PhysicalStorageBuffer>, i64, i64) -> !spirv.ptr<i32, PhysicalStorageBuffer>
    %23 = "spirv.Load"(%22) <{alignment = 4 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<i32, PhysicalStorageBuffer>) -> i32
    "spirv.Store"(%22, %23) <{alignment = 4 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<i32, PhysicalStorageBuffer>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i8, #spirv.storage_class<PhysicalStorageBuffer>>) -> (), sym_name = "load_store_i8_physical"}> ({
  ^bb0(%arg3: memref<i8, #spirv.storage_class<PhysicalStorageBuffer>>):
    %16 = "builtin.unrealized_conversion_cast"(%arg3) : (memref<i8, #spirv.storage_class<PhysicalStorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x i8, stride=1> [0])>, PhysicalStorageBuffer>
    %17 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %18 = "spirv.AccessChain"(%16, %17, %17) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i8, stride=1> [0])>, PhysicalStorageBuffer>, i64, i64) -> !spirv.ptr<i8, PhysicalStorageBuffer>
    %19 = "spirv.Load"(%18) <{alignment = 1 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<i8, PhysicalStorageBuffer>) -> i8
    "spirv.Store"(%18, %19) <{alignment = 1 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<i8, PhysicalStorageBuffer>, i8) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i1, #spirv.storage_class<PhysicalStorageBuffer>>) -> (), sym_name = "load_store_i1_physical"}> ({
  ^bb0(%arg2: memref<i1, #spirv.storage_class<PhysicalStorageBuffer>>):
    %8 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<i1, #spirv.storage_class<PhysicalStorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x i8, stride=1> [0])>, PhysicalStorageBuffer>
    %9 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %10 = "spirv.AccessChain"(%8, %9, %9) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i8, stride=1> [0])>, PhysicalStorageBuffer>, i64, i64) -> !spirv.ptr<i8, PhysicalStorageBuffer>
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
    %5 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %6 = "spirv.AccessChain"(%4, %5, %5) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, PhysicalStorageBuffer>, i64, i64) -> !spirv.ptr<f32, PhysicalStorageBuffer>
    %7 = "spirv.Load"(%6) <{alignment = 4 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<f32, PhysicalStorageBuffer>) -> f32
    "spirv.Store"(%6, %7) <{alignment = 4 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<f32, PhysicalStorageBuffer>, f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f16, #spirv.storage_class<PhysicalStorageBuffer>>) -> (), sym_name = "load_store_f16_physical"}> ({
  ^bb0(%arg0: memref<f16, #spirv.storage_class<PhysicalStorageBuffer>>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<f16, #spirv.storage_class<PhysicalStorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x f16, stride=2> [0])>, PhysicalStorageBuffer>
    %1 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %2 = "spirv.AccessChain"(%0, %1, %1) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x f16, stride=2> [0])>, PhysicalStorageBuffer>, i64, i64) -> !spirv.ptr<f16, PhysicalStorageBuffer>
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
    %24 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %25 = "spirv.AccessChain"(%23, %24) : (!spirv.ptr<!spirv.array<1 x f32>, CrossWorkgroup>, i64) -> !spirv.ptr<f32, CrossWorkgroup>
    %26 = "spirv.Load"(%25) : (!spirv.ptr<f32, CrossWorkgroup>) -> f32
    %27 = "spirv.AccessChain"(%22, %24) : (!spirv.ptr<!spirv.array<1 x f32>, CrossWorkgroup>, i64) -> !spirv.ptr<f32, CrossWorkgroup>
    "spirv.Store"(%27, %26) : (!spirv.ptr<f32, CrossWorkgroup>, f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i32, #spirv.storage_class<CrossWorkgroup>>, memref<i32, #spirv.storage_class<CrossWorkgroup>>) -> (), sym_name = "load_store_zero_rank_int"}> ({
  ^bb0(%arg7: memref<i32, #spirv.storage_class<CrossWorkgroup>>, %arg8: memref<i32, #spirv.storage_class<CrossWorkgroup>>):
    %16 = "builtin.unrealized_conversion_cast"(%arg8) : (memref<i32, #spirv.storage_class<CrossWorkgroup>>) -> !spirv.ptr<!spirv.array<1 x i32>, CrossWorkgroup>
    %17 = "builtin.unrealized_conversion_cast"(%arg7) : (memref<i32, #spirv.storage_class<CrossWorkgroup>>) -> !spirv.ptr<!spirv.array<1 x i32>, CrossWorkgroup>
    %18 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %19 = "spirv.AccessChain"(%17, %18) : (!spirv.ptr<!spirv.array<1 x i32>, CrossWorkgroup>, i64) -> !spirv.ptr<i32, CrossWorkgroup>
    %20 = "spirv.Load"(%19) : (!spirv.ptr<i32, CrossWorkgroup>) -> i32
    %21 = "spirv.AccessChain"(%16, %18) : (!spirv.ptr<!spirv.array<1 x i32>, CrossWorkgroup>, i64) -> !spirv.ptr<i32, CrossWorkgroup>
    "spirv.Store"(%21, %20) : (!spirv.ptr<i32, CrossWorkgroup>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, memref<?xi32, #spirv.storage_class<CrossWorkgroup>>, memref<?xi32, #spirv.storage_class<CrossWorkgroup>>) -> (), sym_name = "load_store_unknown_dim"}> ({
  ^bb0(%arg4: index, %arg5: memref<?xi32, #spirv.storage_class<CrossWorkgroup>>, %arg6: memref<?xi32, #spirv.storage_class<CrossWorkgroup>>):
    %10 = "builtin.unrealized_conversion_cast"(%arg6) : (memref<?xi32, #spirv.storage_class<CrossWorkgroup>>) -> !spirv.ptr<i32, CrossWorkgroup>
    %11 = "builtin.unrealized_conversion_cast"(%arg4) : (index) -> i64
    %12 = "builtin.unrealized_conversion_cast"(%arg5) : (memref<?xi32, #spirv.storage_class<CrossWorkgroup>>) -> !spirv.ptr<i32, CrossWorkgroup>
    %13 = "spirv.PtrAccessChain"(%12, %11) : (!spirv.ptr<i32, CrossWorkgroup>, i64) -> !spirv.ptr<i32, CrossWorkgroup>
    %14 = "spirv.Load"(%13) : (!spirv.ptr<i32, CrossWorkgroup>) -> i32
    %15 = "spirv.PtrAccessChain"(%10, %11) : (!spirv.ptr<i32, CrossWorkgroup>, i64) -> !spirv.ptr<i32, CrossWorkgroup>
    "spirv.Store"(%15, %14) : (!spirv.ptr<i32, CrossWorkgroup>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xi1, #spirv.storage_class<CrossWorkgroup>>, index) -> i1, sym_name = "load_i1"}> ({
  ^bb0(%arg2: memref<4xi1, #spirv.storage_class<CrossWorkgroup>>, %arg3: index):
    %4 = "builtin.unrealized_conversion_cast"(%arg3) : (index) -> i64
    %5 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<4xi1, #spirv.storage_class<CrossWorkgroup>>) -> !spirv.ptr<!spirv.array<4 x i8>, CrossWorkgroup>
    %6 = "spirv.AccessChain"(%5, %4) : (!spirv.ptr<!spirv.array<4 x i8>, CrossWorkgroup>, i64) -> !spirv.ptr<i8, CrossWorkgroup>
    %7 = "spirv.Load"(%6) : (!spirv.ptr<i8, CrossWorkgroup>) -> i8
    %8 = "spirv.Constant"() <{value = 0 : i8}> : () -> i8
    %9 = "spirv.INotEqual"(%7, %8) : (i8, i8) -> i1
    "func.return"(%9) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xi1, #spirv.storage_class<CrossWorkgroup>>, index) -> (), sym_name = "store_i1"}> ({
  ^bb0(%arg0: memref<4xi1, #spirv.storage_class<CrossWorkgroup>>, %arg1: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<4xi1, #spirv.storage_class<CrossWorkgroup>>) -> !spirv.ptr<!spirv.array<4 x i8>, CrossWorkgroup>
    %2 = "spirv.AccessChain"(%1, %0) : (!spirv.ptr<!spirv.array<4 x i8>, CrossWorkgroup>, i64) -> !spirv.ptr<i8, CrossWorkgroup>
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
    %3 = "memref.reinterpret_cast"(%arg2, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 10>, static_strides = array<i64: 1>}> : (memref<?xf32, #spirv.storage_class<CrossWorkgroup>>, index) -> memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>>
    "func.return"(%3) : (memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, #spirv.storage_class<CrossWorkgroup>>) -> memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>>, sym_name = "reinterpret_cast_0"}> ({
  ^bb0(%arg1: memref<?xf32, #spirv.storage_class<CrossWorkgroup>>):
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (memref<?xf32, #spirv.storage_class<CrossWorkgroup>>) -> !spirv.ptr<f32, CrossWorkgroup>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!spirv.ptr<f32, CrossWorkgroup>) -> memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>>
    "func.return"(%2) : (memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>>) -> ()
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
    %1 = "spirv.ConvertPtrToU"(%0) : (!spirv.ptr<f32, CrossWorkgroup>) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Kernel, Int64, Addresses, PhysicalStorageBufferAddresses], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, #spirv.storage_class<CrossWorkgroup>>) -> index, sym_name = "extract_aligned_pointer_as_index_shader"}> ({
  ^bb0(%arg0: memref<?xf32, #spirv.storage_class<CrossWorkgroup>>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32, #spirv.storage_class<CrossWorkgroup>>) -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32>)>, CrossWorkgroup>
    %1 = "spirv.ConvertPtrToU"(%0) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<f32>)>, CrossWorkgroup>) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> index
    "func.return"(%2) : (index) -> ()
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
    %37 = "arith.constant"() <{value = 0 : index}> : () -> index
    %38 = "memref.load"(%arg26, %37) : (memref<1xf32, #spirv.storage_class<Image>>, index) -> f32
    "memref.store"(%38, %arg27, %37) : (f32, memref<1xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x4xf32, #spirv.storage_class<Image>>, memref<2x4xf32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_image_2D"}> ({
  ^bb0(%arg24: memref<2x4xf32, #spirv.storage_class<Image>>, %arg25: memref<2x4xf32, #spirv.storage_class<StorageBuffer>>):
    %34 = "arith.constant"() <{value = 3 : index}> : () -> index
    %35 = "arith.constant"() <{value = 1 : index}> : () -> index
    %36 = "memref.load"(%arg24, %35, %34) : (memref<2x4xf32, #spirv.storage_class<Image>>, index, index) -> f32
    "memref.store"(%36, %arg25, %35, %34) : (f32, memref<2x4xf32, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x4xf32, #map, #spirv.storage_class<Image>>, memref<2x4xf32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_col_major_image_2D"}> ({
  ^bb0(%arg22: memref<2x4xf32, #map, #spirv.storage_class<Image>>, %arg23: memref<2x4xf32, #spirv.storage_class<StorageBuffer>>):
    %31 = "arith.constant"() <{value = 3 : index}> : () -> index
    %32 = "arith.constant"() <{value = 1 : index}> : () -> index
    %33 = "memref.load"(%arg22, %31, %32) : (memref<2x4xf32, #map, #spirv.storage_class<Image>>, index, index) -> f32
    "memref.store"(%33, %arg23, %32, %31) : (f32, memref<2x4xf32, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x3x4xf32, #spirv.storage_class<Image>>, memref<2x3x4xf32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_image_3D"}> ({
  ^bb0(%arg20: memref<2x3x4xf32, #spirv.storage_class<Image>>, %arg21: memref<2x3x4xf32, #spirv.storage_class<StorageBuffer>>):
    %27 = "arith.constant"() <{value = 3 : index}> : () -> index
    %28 = "arith.constant"() <{value = 2 : index}> : () -> index
    %29 = "arith.constant"() <{value = 1 : index}> : () -> index
    %30 = "memref.load"(%arg20, %29, %28, %27) : (memref<2x3x4xf32, #spirv.storage_class<Image>>, index, index, index) -> f32
    "memref.store"(%30, %arg21, %29, %28, %27) : (f32, memref<2x3x4xf32, #spirv.storage_class<StorageBuffer>>, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x3x4xf32, #map1, #spirv.storage_class<Image>>, memref<2x3x4xf32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_custom_layout_image_3D"}> ({
  ^bb0(%arg18: memref<2x3x4xf32, #map1, #spirv.storage_class<Image>>, %arg19: memref<2x3x4xf32, #spirv.storage_class<StorageBuffer>>):
    %23 = "arith.constant"() <{value = 3 : index}> : () -> index
    %24 = "arith.constant"() <{value = 2 : index}> : () -> index
    %25 = "arith.constant"() <{value = 1 : index}> : () -> index
    %26 = "memref.load"(%arg18, %23, %24, %25) : (memref<2x3x4xf32, #map1, #spirv.storage_class<Image>>, index, index, index) -> f32
    "memref.store"(%26, %arg19, %25, %24, %23) : (f32, memref<2x3x4xf32, #spirv.storage_class<StorageBuffer>>, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x3xf16, #spirv.storage_class<Image>>, memref<2x3xf16, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_image_2D_f16"}> ({
  ^bb0(%arg16: memref<2x3xf16, #spirv.storage_class<Image>>, %arg17: memref<2x3xf16, #spirv.storage_class<StorageBuffer>>):
    %20 = "arith.constant"() <{value = 2 : index}> : () -> index
    %21 = "arith.constant"() <{value = 1 : index}> : () -> index
    %22 = "memref.load"(%arg16, %21, %20) : (memref<2x3xf16, #spirv.storage_class<Image>>, index, index) -> f16
    "memref.store"(%22, %arg17, %21, %20) : (f16, memref<2x3xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x3xi32, #spirv.storage_class<Image>>, memref<2x3xi32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_image_2D_i32"}> ({
  ^bb0(%arg14: memref<2x3xi32, #spirv.storage_class<Image>>, %arg15: memref<2x3xi32, #spirv.storage_class<StorageBuffer>>):
    %17 = "arith.constant"() <{value = 2 : index}> : () -> index
    %18 = "arith.constant"() <{value = 1 : index}> : () -> index
    %19 = "memref.load"(%arg14, %18, %17) : (memref<2x3xi32, #spirv.storage_class<Image>>, index, index) -> i32
    "memref.store"(%19, %arg15, %18, %17) : (i32, memref<2x3xi32, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x3xui32, #spirv.storage_class<Image>>, memref<2x3xui32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_image_2D_ui32"}> ({
  ^bb0(%arg12: memref<2x3xui32, #spirv.storage_class<Image>>, %arg13: memref<2x3xui32, #spirv.storage_class<StorageBuffer>>):
    %14 = "arith.constant"() <{value = 2 : index}> : () -> index
    %15 = "arith.constant"() <{value = 1 : index}> : () -> index
    %16 = "memref.load"(%arg12, %15, %14) : (memref<2x3xui32, #spirv.storage_class<Image>>, index, index) -> ui32
    "memref.store"(%16, %arg13, %15, %14) : (ui32, memref<2x3xui32, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x3xi16, #spirv.storage_class<Image>>, memref<2x3xi16, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_image_2D_i16"}> ({
  ^bb0(%arg10: memref<2x3xi16, #spirv.storage_class<Image>>, %arg11: memref<2x3xi16, #spirv.storage_class<StorageBuffer>>):
    %11 = "arith.constant"() <{value = 2 : index}> : () -> index
    %12 = "arith.constant"() <{value = 1 : index}> : () -> index
    %13 = "memref.load"(%arg10, %12, %11) : (memref<2x3xi16, #spirv.storage_class<Image>>, index, index) -> i16
    "memref.store"(%13, %arg11, %12, %11) : (i16, memref<2x3xi16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x3xui16, #spirv.storage_class<Image>>, memref<2x3xui16, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_image_2D_ui16"}> ({
  ^bb0(%arg8: memref<2x3xui16, #spirv.storage_class<Image>>, %arg9: memref<2x3xui16, #spirv.storage_class<StorageBuffer>>):
    %8 = "arith.constant"() <{value = 2 : index}> : () -> index
    %9 = "arith.constant"() <{value = 1 : index}> : () -> index
    %10 = "memref.load"(%arg8, %9, %8) : (memref<2x3xui16, #spirv.storage_class<Image>>, index, index) -> ui16
    "memref.store"(%10, %arg9, %9, %8) : (ui16, memref<2x3xui16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32, #spirv.storage_class<Image>>, memref<f32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_from_image_2D_rank0"}> ({
  ^bb0(%arg6: memref<f32, #spirv.storage_class<Image>>, %arg7: memref<f32, #spirv.storage_class<StorageBuffer>>):
    %7 = "memref.load"(%arg6) : (memref<f32, #spirv.storage_class<Image>>) -> f32
    "memref.store"(%7, %arg7) : (f32, memref<f32, #spirv.storage_class<StorageBuffer>>) -> ()
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

