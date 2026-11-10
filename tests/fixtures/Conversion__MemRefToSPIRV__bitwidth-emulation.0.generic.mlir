"builtin.module"() ({
  "func.func"() <{function_type = (memref<i1, #spirv.storage_class<StorageBuffer>>) -> i1, sym_name = "load_i1"}> ({
  ^bb0(%arg18: memref<i1, #spirv.storage_class<StorageBuffer>>):
    %76 = "builtin.unrealized_conversion_cast"(%arg18) : (memref<i1, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>
    %77 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %78 = "spirv.AccessChain"(%76, %77, %77) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
    %79 = "spirv.Load"(%78) : (!spirv.ptr<i32, StorageBuffer>) -> i32
    %80 = "spirv.Constant"() <{value = 255 : i32}> : () -> i32
    %81 = "spirv.BitwiseAnd"(%79, %80) : (i32, i32) -> i32
    %82 = "spirv.Constant"() <{value = 24 : i32}> : () -> i32
    %83 = "spirv.ShiftLeftLogical"(%81, %82) : (i32, i32) -> i32
    %84 = "spirv.ShiftRightArithmetic"(%83, %82) : (i32, i32) -> i32
    %85 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %86 = "spirv.IEqual"(%84, %85) : (i32, i32) -> i1
    "func.return"(%86) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i8, #spirv.storage_class<StorageBuffer>>) -> i8, sym_name = "load_i8"}> ({
  ^bb0(%arg17: memref<i8, #spirv.storage_class<StorageBuffer>>):
    %66 = "builtin.unrealized_conversion_cast"(%arg17) : (memref<i8, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>
    %67 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %68 = "spirv.AccessChain"(%66, %67, %67) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
    %69 = "spirv.Load"(%68) : (!spirv.ptr<i32, StorageBuffer>) -> i32
    %70 = "spirv.Constant"() <{value = 255 : i32}> : () -> i32
    %71 = "spirv.BitwiseAnd"(%69, %70) : (i32, i32) -> i32
    %72 = "spirv.Constant"() <{value = 24 : i32}> : () -> i32
    %73 = "spirv.ShiftLeftLogical"(%71, %72) : (i32, i32) -> i32
    %74 = "spirv.ShiftRightArithmetic"(%73, %72) : (i32, i32) -> i32
    %75 = "builtin.unrealized_conversion_cast"(%74) : (i32) -> i8
    "func.return"(%75) : (i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xi16, #spirv.storage_class<StorageBuffer>>, index) -> i16, sym_name = "load_i16"}> ({
  ^bb0(%arg15: memref<10xi16, #spirv.storage_class<StorageBuffer>>, %arg16: index):
    %50 = "builtin.unrealized_conversion_cast"(%arg16) : (index) -> i32
    %51 = "builtin.unrealized_conversion_cast"(%arg15) : (memref<10xi16, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<5 x i32, stride=4> [0])>, StorageBuffer>
    %52 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %53 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    %54 = "spirv.SDiv"(%50, %53) : (i32, i32) -> i32
    %55 = "spirv.AccessChain"(%51, %52, %54) : (!spirv.ptr<!spirv.struct<(!spirv.array<5 x i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
    %56 = "spirv.Load"(%55) : (!spirv.ptr<i32, StorageBuffer>) -> i32
    %57 = "spirv.Constant"() <{value = 16 : i32}> : () -> i32
    %58 = "spirv.UMod"(%50, %53) : (i32, i32) -> i32
    %59 = "spirv.IMul"(%58, %57) : (i32, i32) -> i32
    %60 = "spirv.ShiftRightArithmetic"(%56, %59) : (i32, i32) -> i32
    %61 = "spirv.Constant"() <{value = 65535 : i32}> : () -> i32
    %62 = "spirv.BitwiseAnd"(%60, %61) : (i32, i32) -> i32
    %63 = "spirv.ShiftLeftLogical"(%62, %57) : (i32, i32) -> i32
    %64 = "spirv.ShiftRightArithmetic"(%63, %57) : (i32, i32) -> i32
    %65 = "builtin.unrealized_conversion_cast"(%64) : (i32) -> i16
    "func.return"(%65) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xi64, #spirv.storage_class<StorageBuffer>>, index) -> i64, sym_name = "load_i64"}> ({
  ^bb0(%arg13: memref<10xi64, #spirv.storage_class<StorageBuffer>>, %arg14: index):
    %45 = "builtin.unrealized_conversion_cast"(%arg14) : (index) -> i32
    %46 = "builtin.unrealized_conversion_cast"(%arg13) : (memref<10xi64, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<10 x i64, stride=8> [0])>, StorageBuffer>
    %47 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %48 = "spirv.AccessChain"(%46, %47, %45) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x i64, stride=8> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i64, StorageBuffer>
    %49 = "spirv.Load"(%48) : (!spirv.ptr<i64, StorageBuffer>) -> i64
    "func.return"(%49) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_f32"}> ({
  ^bb0(%arg12: memref<f32, #spirv.storage_class<StorageBuffer>>):
    %41 = "builtin.unrealized_conversion_cast"(%arg12) : (memref<f32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>
    %42 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %43 = "spirv.AccessChain"(%41, %42, %42) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    %44 = "spirv.Load"(%43) : (!spirv.ptr<f32, StorageBuffer>) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i1, #spirv.storage_class<StorageBuffer>>, i1) -> (), sym_name = "store_i1"}> ({
  ^bb0(%arg10: memref<i1, #spirv.storage_class<StorageBuffer>>, %arg11: i1):
    %33 = "builtin.unrealized_conversion_cast"(%arg10) : (memref<i1, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>
    %34 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %35 = "spirv.Constant"() <{value = -256 : i32}> : () -> i32
    %36 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %37 = "spirv.Select"(%arg11, %36, %34) : (i1, i32, i32) -> i32
    %38 = "spirv.AccessChain"(%33, %34, %34) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
    %39 = "spirv.AtomicAnd"(%38, %35) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease|UniformMemory>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    %40 = "spirv.AtomicOr"(%38, %37) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease|UniformMemory>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i8, #spirv.storage_class<StorageBuffer>>, i8) -> (), sym_name = "store_i8"}> ({
  ^bb0(%arg8: memref<i8, #spirv.storage_class<StorageBuffer>>, %arg9: i8):
    %24 = "builtin.unrealized_conversion_cast"(%arg8) : (memref<i8, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>
    %25 = "builtin.unrealized_conversion_cast"(%arg9) : (i8) -> i32
    %26 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %27 = "spirv.Constant"() <{value = 255 : i32}> : () -> i32
    %28 = "spirv.Constant"() <{value = -256 : i32}> : () -> i32
    %29 = "spirv.BitwiseAnd"(%25, %27) : (i32, i32) -> i32
    %30 = "spirv.AccessChain"(%24, %26, %26) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
    %31 = "spirv.AtomicAnd"(%30, %28) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease|UniformMemory>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    %32 = "spirv.AtomicOr"(%30, %29) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease|UniformMemory>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xi16, #spirv.storage_class<StorageBuffer>>, index, i16) -> (), sym_name = "store_i16"}> ({
  ^bb0(%arg5: memref<10xi16, #spirv.storage_class<StorageBuffer>>, %arg6: index, %arg7: i16):
    %7 = "builtin.unrealized_conversion_cast"(%arg6) : (index) -> i32
    %8 = "builtin.unrealized_conversion_cast"(%arg5) : (memref<10xi16, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<5 x i32, stride=4> [0])>, StorageBuffer>
    %9 = "builtin.unrealized_conversion_cast"(%arg7) : (i16) -> i32
    %10 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %11 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    %12 = "spirv.Constant"() <{value = 16 : i32}> : () -> i32
    %13 = "spirv.UMod"(%7, %11) : (i32, i32) -> i32
    %14 = "spirv.IMul"(%13, %12) : (i32, i32) -> i32
    %15 = "spirv.Constant"() <{value = 65535 : i32}> : () -> i32
    %16 = "spirv.ShiftLeftLogical"(%15, %14) : (i32, i32) -> i32
    %17 = "spirv.Not"(%16) : (i32) -> i32
    %18 = "spirv.BitwiseAnd"(%9, %15) : (i32, i32) -> i32
    %19 = "spirv.ShiftLeftLogical"(%18, %14) : (i32, i32) -> i32
    %20 = "spirv.SDiv"(%7, %11) : (i32, i32) -> i32
    %21 = "spirv.AccessChain"(%8, %10, %20) : (!spirv.ptr<!spirv.struct<(!spirv.array<5 x i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
    %22 = "spirv.AtomicAnd"(%21, %17) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease|UniformMemory>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    %23 = "spirv.AtomicOr"(%21, %19) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease|UniformMemory>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xi64, #spirv.storage_class<StorageBuffer>>, index, i64) -> (), sym_name = "store_i64"}> ({
  ^bb0(%arg2: memref<10xi64, #spirv.storage_class<StorageBuffer>>, %arg3: index, %arg4: i64):
    %3 = "builtin.unrealized_conversion_cast"(%arg3) : (index) -> i32
    %4 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<10xi64, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<10 x i64, stride=8> [0])>, StorageBuffer>
    %5 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %6 = "spirv.AccessChain"(%4, %5, %3) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x i64, stride=8> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i64, StorageBuffer>
    "spirv.Store"(%6, %arg4) : (!spirv.ptr<i64, StorageBuffer>, i64) -> ()
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
    %15 = "spirv.AtomicAnd"(%14, %10) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease|UniformMemory>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    %16 = "spirv.AtomicOr"(%14, %12) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease|UniformMemory>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
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
    %5 = "spirv.AtomicAnd"(%4, %2) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease|UniformMemory>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    %6 = "spirv.AtomicOr"(%4, %3) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease|UniformMemory>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64, Int8], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

