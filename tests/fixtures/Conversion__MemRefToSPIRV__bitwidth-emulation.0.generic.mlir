"builtin.module"() ({
  "func.func"() <{function_type = (memref<i1, #spirv.storage_class<StorageBuffer>>) -> i1, sym_name = "load_i1"}> ({
  ^bb0(%arg13: memref<i1, #spirv.storage_class<StorageBuffer>>):
    %67 = "builtin.unrealized_conversion_cast"(%arg13) : (memref<i1, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>
    %68 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %69 = "spirv.AccessChain"(%67, %68, %68) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
    %70 = "spirv.Load"(%69) : (!spirv.ptr<i32, StorageBuffer>) -> i32
    %71 = "spirv.Constant"() <{value = 255 : i32}> : () -> i32
    %72 = "spirv.BitwiseAnd"(%70, %71) : (i32, i32) -> i32
    %73 = "spirv.Constant"() <{value = 24 : i32}> : () -> i32
    %74 = "spirv.ShiftLeftLogical"(%72, %73) : (i32, i32) -> i32
    %75 = "spirv.ShiftRightArithmetic"(%74, %73) : (i32, i32) -> i32
    %76 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %77 = "spirv.IEqual"(%75, %76) : (i32, i32) -> i1
    "func.return"(%77) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i8, #spirv.storage_class<StorageBuffer>>) -> i8, sym_name = "load_i8"}> ({
  ^bb0(%arg12: memref<i8, #spirv.storage_class<StorageBuffer>>):
    %57 = "builtin.unrealized_conversion_cast"(%arg12) : (memref<i8, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>
    %58 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %59 = "spirv.AccessChain"(%57, %58, %58) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
    %60 = "spirv.Load"(%59) : (!spirv.ptr<i32, StorageBuffer>) -> i32
    %61 = "spirv.Constant"() <{value = 255 : i32}> : () -> i32
    %62 = "spirv.BitwiseAnd"(%60, %61) : (i32, i32) -> i32
    %63 = "spirv.Constant"() <{value = 24 : i32}> : () -> i32
    %64 = "spirv.ShiftLeftLogical"(%62, %63) : (i32, i32) -> i32
    %65 = "spirv.ShiftRightArithmetic"(%64, %63) : (i32, i32) -> i32
    %66 = "builtin.unrealized_conversion_cast"(%65) : (i32) -> i8
    "func.return"(%66) : (i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xi16, #spirv.storage_class<StorageBuffer>>, index) -> i16, sym_name = "load_i16"}> ({
  ^bb0(%arg10: memref<10xi16, #spirv.storage_class<StorageBuffer>>, %arg11: index):
    %41 = "builtin.unrealized_conversion_cast"(%arg11) : (index) -> i32
    %42 = "builtin.unrealized_conversion_cast"(%arg10) : (memref<10xi16, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<5 x i32, stride=4> [0])>, StorageBuffer>
    %43 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %44 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    %45 = "spirv.SDiv"(%41, %44) : (i32, i32) -> i32
    %46 = "spirv.AccessChain"(%42, %43, %45) : (!spirv.ptr<!spirv.struct<(!spirv.array<5 x i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
    %47 = "spirv.Load"(%46) : (!spirv.ptr<i32, StorageBuffer>) -> i32
    %48 = "spirv.Constant"() <{value = 16 : i32}> : () -> i32
    %49 = "spirv.UMod"(%41, %44) : (i32, i32) -> i32
    %50 = "spirv.IMul"(%49, %48) : (i32, i32) -> i32
    %51 = "spirv.ShiftRightArithmetic"(%47, %50) : (i32, i32) -> i32
    %52 = "spirv.Constant"() <{value = 65535 : i32}> : () -> i32
    %53 = "spirv.BitwiseAnd"(%51, %52) : (i32, i32) -> i32
    %54 = "spirv.ShiftLeftLogical"(%53, %48) : (i32, i32) -> i32
    %55 = "spirv.ShiftRightArithmetic"(%54, %48) : (i32, i32) -> i32
    %56 = "builtin.unrealized_conversion_cast"(%55) : (i32) -> i16
    "func.return"(%56) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_f32"}> ({
  ^bb0(%arg9: memref<f32, #spirv.storage_class<StorageBuffer>>):
    %37 = "builtin.unrealized_conversion_cast"(%arg9) : (memref<f32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>
    %38 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %39 = "spirv.AccessChain"(%37, %38, %38) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    %40 = "spirv.Load"(%39) : (!spirv.ptr<f32, StorageBuffer>) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i1, #spirv.storage_class<StorageBuffer>>, i1) -> (), sym_name = "store_i1"}> ({
  ^bb0(%arg7: memref<i1, #spirv.storage_class<StorageBuffer>>, %arg8: i1):
    %29 = "builtin.unrealized_conversion_cast"(%arg7) : (memref<i1, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>
    %30 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %31 = "spirv.Constant"() <{value = -256 : i32}> : () -> i32
    %32 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %33 = "spirv.Select"(%arg8, %32, %30) : (i1, i32, i32) -> i32
    %34 = "spirv.AccessChain"(%29, %30, %30) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
    %35 = "spirv.AtomicAnd"(%34, %31) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    %36 = "spirv.AtomicOr"(%34, %33) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i8, #spirv.storage_class<StorageBuffer>>, i8) -> (), sym_name = "store_i8"}> ({
  ^bb0(%arg5: memref<i8, #spirv.storage_class<StorageBuffer>>, %arg6: i8):
    %20 = "builtin.unrealized_conversion_cast"(%arg5) : (memref<i8, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>
    %21 = "builtin.unrealized_conversion_cast"(%arg6) : (i8) -> i32
    %22 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %23 = "spirv.Constant"() <{value = 255 : i32}> : () -> i32
    %24 = "spirv.Constant"() <{value = -256 : i32}> : () -> i32
    %25 = "spirv.BitwiseAnd"(%21, %23) : (i32, i32) -> i32
    %26 = "spirv.AccessChain"(%20, %22, %22) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
    %27 = "spirv.AtomicAnd"(%26, %24) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    %28 = "spirv.AtomicOr"(%26, %25) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xi16, #spirv.storage_class<StorageBuffer>>, index, i16) -> (), sym_name = "store_i16"}> ({
  ^bb0(%arg2: memref<10xi16, #spirv.storage_class<StorageBuffer>>, %arg3: index, %arg4: i16):
    %3 = "builtin.unrealized_conversion_cast"(%arg3) : (index) -> i32
    %4 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<10xi16, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<5 x i32, stride=4> [0])>, StorageBuffer>
    %5 = "builtin.unrealized_conversion_cast"(%arg4) : (i16) -> i32
    %6 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %7 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    %8 = "spirv.Constant"() <{value = 16 : i32}> : () -> i32
    %9 = "spirv.UMod"(%3, %7) : (i32, i32) -> i32
    %10 = "spirv.IMul"(%9, %8) : (i32, i32) -> i32
    %11 = "spirv.Constant"() <{value = 65535 : i32}> : () -> i32
    %12 = "spirv.ShiftLeftLogical"(%11, %10) : (i32, i32) -> i32
    %13 = "spirv.Not"(%12) : (i32) -> i32
    %14 = "spirv.BitwiseAnd"(%5, %11) : (i32, i32) -> i32
    %15 = "spirv.ShiftLeftLogical"(%14, %10) : (i32, i32) -> i32
    %16 = "spirv.SDiv"(%3, %7) : (i32, i32) -> i32
    %17 = "spirv.AccessChain"(%4, %6, %16) : (!spirv.ptr<!spirv.struct<(!spirv.array<5 x i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
    %18 = "spirv.AtomicAnd"(%17, %13) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    %19 = "spirv.AtomicOr"(%17, %15) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32, #spirv.storage_class<StorageBuffer>>, f32) -> (), sym_name = "store_f32"}> ({
  ^bb0(%arg0: memref<f32, #spirv.storage_class<StorageBuffer>>, %arg1: f32):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<f32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>
    %1 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %2 = "spirv.AccessChain"(%0, %1, %1) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    "spirv.Store"(%2, %arg1) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi4, #spirv.storage_class<StorageBuffer>>, index) -> i4, sym_name = "load_i4"}> ({
  ^bb0(%arg3: memref<?xi4, #spirv.storage_class<StorageBuffer>>, %arg4: index):
    %17 = "builtin.unrealized_conversion_cast"(%arg4) : (index) -> i32
    %18 = "builtin.unrealized_conversion_cast"(%arg3) : (memref<?xi4, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>
    %19 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %20 = "spirv.Constant"() <{value = 8 : i32}> : () -> i32
    %21 = "spirv.SDiv"(%17, %20) : (i32, i32) -> i32
    %22 = "spirv.AccessChain"(%18, %19, %21) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
    %23 = "spirv.Load"(%22) : (!spirv.ptr<i32, StorageBuffer>) -> i32
    %24 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %25 = "spirv.UMod"(%17, %20) : (i32, i32) -> i32
    %26 = "spirv.IMul"(%25, %24) : (i32, i32) -> i32
    %27 = "spirv.ShiftRightArithmetic"(%23, %26) : (i32, i32) -> i32
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
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i32
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xi4, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>
    %2 = "builtin.unrealized_conversion_cast"(%arg1) : (i4) -> i32
    %3 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = 8 : i32}> : () -> i32
    %5 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %6 = "spirv.UMod"(%0, %4) : (i32, i32) -> i32
    %7 = "spirv.IMul"(%6, %5) : (i32, i32) -> i32
    %8 = "spirv.Constant"() <{value = 15 : i32}> : () -> i32
    %9 = "spirv.ShiftLeftLogical"(%8, %7) : (i32, i32) -> i32
    %10 = "spirv.Not"(%9) : (i32) -> i32
    %11 = "spirv.BitwiseAnd"(%2, %8) : (i32, i32) -> i32
    %12 = "spirv.ShiftLeftLogical"(%11, %7) : (i32, i32) -> i32
    %13 = "spirv.SDiv"(%0, %4) : (i32, i32) -> i32
    %14 = "spirv.AccessChain"(%1, %3, %13) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
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
    %8 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %9 = "spirv.AccessChain"(%7, %8, %8) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
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
    %1 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %2 = "spirv.Constant"() <{value = -256 : i32}> : () -> i32
    %3 = "spirv.UConvert"(%arg1) : (i8) -> i32
    %4 = "spirv.AccessChain"(%0, %1, %1) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
    %5 = "spirv.AtomicAnd"(%4, %2) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    %6 = "spirv.AtomicOr"(%4, %3) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64, Int8], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

