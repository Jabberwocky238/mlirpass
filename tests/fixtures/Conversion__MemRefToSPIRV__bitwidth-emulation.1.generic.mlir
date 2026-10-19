"builtin.module"() ({
  "func.func"() <{function_type = (memref<i1, #spirv.storage_class<StorageBuffer>>) -> i1, sym_name = "load_i1"}> ({
  ^bb0(%arg13: memref<i1, #spirv.storage_class<StorageBuffer>>):
    %69 = "builtin.unrealized_conversion_cast"(%arg13) : (memref<i1, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>
    %70 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %71 = "spirv.AccessChain"(%69, %70, %70) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>, i64, i64) -> !spirv.ptr<i32, StorageBuffer>
    %72 = "spirv.Load"(%71) : (!spirv.ptr<i32, StorageBuffer>) -> i32
    %73 = "spirv.Constant"() <{value = 255 : i32}> : () -> i32
    %74 = "spirv.BitwiseAnd"(%72, %73) : (i32, i32) -> i32
    %75 = "spirv.Constant"() <{value = 24 : i32}> : () -> i32
    %76 = "spirv.ShiftLeftLogical"(%74, %75) : (i32, i32) -> i32
    %77 = "spirv.ShiftRightArithmetic"(%76, %75) : (i32, i32) -> i32
    %78 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %79 = "spirv.IEqual"(%77, %78) : (i32, i32) -> i1
    "func.return"(%79) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i8, #spirv.storage_class<StorageBuffer>>) -> i8, sym_name = "load_i8"}> ({
  ^bb0(%arg12: memref<i8, #spirv.storage_class<StorageBuffer>>):
    %59 = "builtin.unrealized_conversion_cast"(%arg12) : (memref<i8, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>
    %60 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %61 = "spirv.AccessChain"(%59, %60, %60) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>, i64, i64) -> !spirv.ptr<i32, StorageBuffer>
    %62 = "spirv.Load"(%61) : (!spirv.ptr<i32, StorageBuffer>) -> i32
    %63 = "spirv.Constant"() <{value = 255 : i32}> : () -> i32
    %64 = "spirv.BitwiseAnd"(%62, %63) : (i32, i32) -> i32
    %65 = "spirv.Constant"() <{value = 24 : i32}> : () -> i32
    %66 = "spirv.ShiftLeftLogical"(%64, %65) : (i32, i32) -> i32
    %67 = "spirv.ShiftRightArithmetic"(%66, %65) : (i32, i32) -> i32
    %68 = "builtin.unrealized_conversion_cast"(%67) : (i32) -> i8
    "func.return"(%68) : (i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xi16, #spirv.storage_class<StorageBuffer>>, index) -> i16, sym_name = "load_i16"}> ({
  ^bb0(%arg10: memref<10xi16, #spirv.storage_class<StorageBuffer>>, %arg11: index):
    %42 = "builtin.unrealized_conversion_cast"(%arg11) : (index) -> i64
    %43 = "builtin.unrealized_conversion_cast"(%arg10) : (memref<10xi16, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<5 x i32, stride=4> [0])>, StorageBuffer>
    %44 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %45 = "spirv.Constant"() <{value = 2 : i64}> : () -> i64
    %46 = "spirv.SDiv"(%42, %45) : (i64, i64) -> i64
    %47 = "spirv.AccessChain"(%43, %44, %46) : (!spirv.ptr<!spirv.struct<(!spirv.array<5 x i32, stride=4> [0])>, StorageBuffer>, i64, i64) -> !spirv.ptr<i32, StorageBuffer>
    %48 = "spirv.Load"(%47) : (!spirv.ptr<i32, StorageBuffer>) -> i32
    %49 = "spirv.Constant"() <{value = 16 : i64}> : () -> i64
    %50 = "spirv.UMod"(%42, %45) : (i64, i64) -> i64
    %51 = "spirv.IMul"(%50, %49) : (i64, i64) -> i64
    %52 = "spirv.ShiftRightArithmetic"(%48, %51) : (i32, i64) -> i32
    %53 = "spirv.Constant"() <{value = 65535 : i32}> : () -> i32
    %54 = "spirv.BitwiseAnd"(%52, %53) : (i32, i32) -> i32
    %55 = "spirv.Constant"() <{value = 16 : i32}> : () -> i32
    %56 = "spirv.ShiftLeftLogical"(%54, %55) : (i32, i32) -> i32
    %57 = "spirv.ShiftRightArithmetic"(%56, %55) : (i32, i32) -> i32
    %58 = "builtin.unrealized_conversion_cast"(%57) : (i32) -> i16
    "func.return"(%58) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_f32"}> ({
  ^bb0(%arg9: memref<f32, #spirv.storage_class<StorageBuffer>>):
    %38 = "builtin.unrealized_conversion_cast"(%arg9) : (memref<f32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>
    %39 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %40 = "spirv.AccessChain"(%38, %39, %39) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>, i64, i64) -> !spirv.ptr<f32, StorageBuffer>
    %41 = "spirv.Load"(%40) : (!spirv.ptr<f32, StorageBuffer>) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i1, #spirv.storage_class<StorageBuffer>>, i1) -> (), sym_name = "store_i1"}> ({
  ^bb0(%arg7: memref<i1, #spirv.storage_class<StorageBuffer>>, %arg8: i1):
    %29 = "builtin.unrealized_conversion_cast"(%arg7) : (memref<i1, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>
    %30 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %31 = "spirv.Constant"() <{value = -256 : i32}> : () -> i32
    %32 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %33 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %34 = "spirv.Select"(%arg8, %33, %32) : (i1, i32, i32) -> i32
    %35 = "spirv.AccessChain"(%29, %30, %30) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>, i64, i64) -> !spirv.ptr<i32, StorageBuffer>
    %36 = "spirv.AtomicAnd"(%35, %31) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    %37 = "spirv.AtomicOr"(%35, %34) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i8, #spirv.storage_class<StorageBuffer>>, i8) -> (), sym_name = "store_i8"}> ({
  ^bb0(%arg5: memref<i8, #spirv.storage_class<StorageBuffer>>, %arg6: i8):
    %20 = "builtin.unrealized_conversion_cast"(%arg5) : (memref<i8, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>
    %21 = "builtin.unrealized_conversion_cast"(%arg6) : (i8) -> i32
    %22 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %23 = "spirv.Constant"() <{value = 255 : i32}> : () -> i32
    %24 = "spirv.Constant"() <{value = -256 : i32}> : () -> i32
    %25 = "spirv.BitwiseAnd"(%21, %23) : (i32, i32) -> i32
    %26 = "spirv.AccessChain"(%20, %22, %22) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>, i64, i64) -> !spirv.ptr<i32, StorageBuffer>
    %27 = "spirv.AtomicAnd"(%26, %24) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    %28 = "spirv.AtomicOr"(%26, %25) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xi16, #spirv.storage_class<StorageBuffer>>, index, i16) -> (), sym_name = "store_i16"}> ({
  ^bb0(%arg2: memref<10xi16, #spirv.storage_class<StorageBuffer>>, %arg3: index, %arg4: i16):
    %3 = "builtin.unrealized_conversion_cast"(%arg3) : (index) -> i64
    %4 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<10xi16, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<5 x i32, stride=4> [0])>, StorageBuffer>
    %5 = "builtin.unrealized_conversion_cast"(%arg4) : (i16) -> i32
    %6 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %7 = "spirv.Constant"() <{value = 2 : i64}> : () -> i64
    %8 = "spirv.Constant"() <{value = 16 : i64}> : () -> i64
    %9 = "spirv.UMod"(%3, %7) : (i64, i64) -> i64
    %10 = "spirv.IMul"(%9, %8) : (i64, i64) -> i64
    %11 = "spirv.Constant"() <{value = 65535 : i32}> : () -> i32
    %12 = "spirv.ShiftLeftLogical"(%11, %10) : (i32, i64) -> i32
    %13 = "spirv.Not"(%12) : (i32) -> i32
    %14 = "spirv.BitwiseAnd"(%5, %11) : (i32, i32) -> i32
    %15 = "spirv.ShiftLeftLogical"(%14, %10) : (i32, i64) -> i32
    %16 = "spirv.SDiv"(%3, %7) : (i64, i64) -> i64
    %17 = "spirv.AccessChain"(%4, %6, %16) : (!spirv.ptr<!spirv.struct<(!spirv.array<5 x i32, stride=4> [0])>, StorageBuffer>, i64, i64) -> !spirv.ptr<i32, StorageBuffer>
    %18 = "spirv.AtomicAnd"(%17, %13) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    %19 = "spirv.AtomicOr"(%17, %15) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32, #spirv.storage_class<StorageBuffer>>, f32) -> (), sym_name = "store_f32"}> ({
  ^bb0(%arg0: memref<f32, #spirv.storage_class<StorageBuffer>>, %arg1: f32):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<f32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>
    %1 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %2 = "spirv.AccessChain"(%0, %1, %1) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>, i64, i64) -> !spirv.ptr<f32, StorageBuffer>
    "spirv.Store"(%2, %arg1) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi4, #spirv.storage_class<StorageBuffer>>, index) -> i4, sym_name = "load_i4"}> ({
  ^bb0(%arg3: memref<?xi4, #spirv.storage_class<StorageBuffer>>, %arg4: index):
    %17 = "builtin.unrealized_conversion_cast"(%arg4) : (index) -> i64
    %18 = "builtin.unrealized_conversion_cast"(%arg3) : (memref<?xi4, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>
    %19 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %20 = "spirv.Constant"() <{value = 8 : i64}> : () -> i64
    %21 = "spirv.SDiv"(%17, %20) : (i64, i64) -> i64
    %22 = "spirv.AccessChain"(%18, %19, %21) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>, i64, i64) -> !spirv.ptr<i32, StorageBuffer>
    %23 = "spirv.Load"(%22) : (!spirv.ptr<i32, StorageBuffer>) -> i32
    %24 = "spirv.Constant"() <{value = 4 : i64}> : () -> i64
    %25 = "spirv.UMod"(%17, %20) : (i64, i64) -> i64
    %26 = "spirv.IMul"(%25, %24) : (i64, i64) -> i64
    %27 = "spirv.ShiftRightArithmetic"(%23, %26) : (i32, i64) -> i32
    %28 = "spirv.Constant"() <{value = 15 : i32}> : () -> i32
    %29 = "spirv.BitwiseAnd"(%27, %28) : (i32, i32) -> i32
    %30 = "spirv.Constant"() <{value = 28 : i32}> : () -> i32
    %31 = "spirv.ShiftLeftLogical"(%29, %30) : (i32, i32) -> i32
    %32 = "spirv.ShiftRightArithmetic"(%31, %30) : (i32, i32) -> i32
    %33 = "builtin.unrealized_conversion_cast"(%32) : (i32) -> i4
    "func.return"(%33) : (i4) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi4, #spirv.storage_class<StorageBuffer>>, i4, index) -> (), sym_name = "store_i4"}> ({
  ^bb0(%arg0: memref<?xi4, #spirv.storage_class<StorageBuffer>>, %arg1: i4, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xi4, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>
    %2 = "builtin.unrealized_conversion_cast"(%arg1) : (i4) -> i32
    %3 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %4 = "spirv.Constant"() <{value = 8 : i64}> : () -> i64
    %5 = "spirv.Constant"() <{value = 4 : i64}> : () -> i64
    %6 = "spirv.UMod"(%0, %4) : (i64, i64) -> i64
    %7 = "spirv.IMul"(%6, %5) : (i64, i64) -> i64
    %8 = "spirv.Constant"() <{value = 15 : i32}> : () -> i32
    %9 = "spirv.ShiftLeftLogical"(%8, %7) : (i32, i64) -> i32
    %10 = "spirv.Not"(%9) : (i32) -> i32
    %11 = "spirv.BitwiseAnd"(%2, %8) : (i32, i32) -> i32
    %12 = "spirv.ShiftLeftLogical"(%11, %7) : (i32, i64) -> i32
    %13 = "spirv.SDiv"(%0, %4) : (i64, i64) -> i64
    %14 = "spirv.AccessChain"(%1, %3, %13) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>, i64, i64) -> !spirv.ptr<i32, StorageBuffer>
    %15 = "spirv.AtomicAnd"(%14, %10) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    %16 = "spirv.AtomicOr"(%14, %12) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<i8, #spirv.storage_class<StorageBuffer>>) -> i8, sym_name = "load_i8"}> ({
  ^bb0(%arg2: memref<i8, #spirv.storage_class<StorageBuffer>>):
    %7 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<i8, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>
    %8 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %9 = "spirv.AccessChain"(%7, %8, %8) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>, i64, i64) -> !spirv.ptr<i32, StorageBuffer>
    %10 = "spirv.Load"(%9) : (!spirv.ptr<i32, StorageBuffer>) -> i32
    %11 = "spirv.Constant"() <{value = 255 : i32}> : () -> i32
    %12 = "spirv.BitwiseAnd"(%10, %11) : (i32, i32) -> i32
    %13 = "spirv.Constant"() <{value = 24 : i32}> : () -> i32
    %14 = "spirv.ShiftLeftLogical"(%12, %13) : (i32, i32) -> i32
    %15 = "spirv.ShiftRightArithmetic"(%14, %13) : (i32, i32) -> i32
    %16 = "spirv.UConvert"(%15) : (i32) -> i8
    "func.return"(%16) : (i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i8, #spirv.storage_class<StorageBuffer>>, i8) -> (), sym_name = "store_i8"}> ({
  ^bb0(%arg0: memref<i8, #spirv.storage_class<StorageBuffer>>, %arg1: i8):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<i8, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>
    %1 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %2 = "spirv.Constant"() <{value = -256 : i32}> : () -> i32
    %3 = "spirv.UConvert"(%arg1) : (i8) -> i32
    %4 = "spirv.AccessChain"(%0, %1, %1) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>, i64, i64) -> !spirv.ptr<i32, StorageBuffer>
    %5 = "spirv.AtomicAnd"(%4, %2) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    %6 = "spirv.AtomicOr"(%4, %3) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64, Int8], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

