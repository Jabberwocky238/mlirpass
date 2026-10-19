"builtin.module"() ({
  "func.func"() <{function_type = (i32, memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>>, index, index, index) -> i32, sym_name = "atomic_addi_storage_buffer"}> ({
  ^bb0(%arg30: i32, %arg31: memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>>, %arg32: index, %arg33: index, %arg34: index):
    %90 = "builtin.unrealized_conversion_cast"(%arg34) : (index) -> i32
    %91 = "builtin.unrealized_conversion_cast"(%arg33) : (index) -> i32
    %92 = "builtin.unrealized_conversion_cast"(%arg32) : (index) -> i32
    %93 = "builtin.unrealized_conversion_cast"(%arg31) : (memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<24 x i32, stride=4> [0])>, StorageBuffer>
    %94 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %95 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %96 = "spirv.Constant"() <{value = 12 : i32}> : () -> i32
    %97 = "spirv.IMul"(%92, %96) : (i32, i32) -> i32
    %98 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %99 = "spirv.IMul"(%91, %98) : (i32, i32) -> i32
    %100 = "spirv.IAdd"(%99, %97) : (i32, i32) -> i32
    %101 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %102 = "spirv.IAdd"(%90, %100) : (i32, i32) -> i32
    %103 = "spirv.AccessChain"(%93, %94, %102) : (!spirv.ptr<!spirv.struct<(!spirv.array<24 x i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
    %104 = "spirv.AtomicIAdd"(%103, %arg30) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    "func.return"(%104) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, memref<2x3x4xi32, #spirv.storage_class<Workgroup>>, index, index, index) -> i32, sym_name = "atomic_maxs_workgroup"}> ({
  ^bb0(%arg25: i32, %arg26: memref<2x3x4xi32, #spirv.storage_class<Workgroup>>, %arg27: index, %arg28: index, %arg29: index):
    %75 = "builtin.unrealized_conversion_cast"(%arg29) : (index) -> i32
    %76 = "builtin.unrealized_conversion_cast"(%arg28) : (index) -> i32
    %77 = "builtin.unrealized_conversion_cast"(%arg27) : (index) -> i32
    %78 = "builtin.unrealized_conversion_cast"(%arg26) : (memref<2x3x4xi32, #spirv.storage_class<Workgroup>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<24 x i32>)>, Workgroup>
    %79 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %80 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %81 = "spirv.Constant"() <{value = 12 : i32}> : () -> i32
    %82 = "spirv.IMul"(%77, %81) : (i32, i32) -> i32
    %83 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %84 = "spirv.IMul"(%76, %83) : (i32, i32) -> i32
    %85 = "spirv.IAdd"(%84, %82) : (i32, i32) -> i32
    %86 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %87 = "spirv.IAdd"(%75, %85) : (i32, i32) -> i32
    %88 = "spirv.AccessChain"(%78, %79, %87) : (!spirv.ptr<!spirv.struct<(!spirv.array<24 x i32>)>, Workgroup>, i32, i32) -> !spirv.ptr<i32, Workgroup>
    %89 = "spirv.AtomicSMax"(%88, %arg25) <{memory_scope = #spirv.scope<Workgroup>, semantics = #spirv.memory_semantics<AcquireRelease>}> : (!spirv.ptr<i32, Workgroup>, i32) -> i32
    "func.return"(%89) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>>, index, index, index) -> i32, sym_name = "atomic_maxu_storage_buffer"}> ({
  ^bb0(%arg20: i32, %arg21: memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>>, %arg22: index, %arg23: index, %arg24: index):
    %60 = "builtin.unrealized_conversion_cast"(%arg24) : (index) -> i32
    %61 = "builtin.unrealized_conversion_cast"(%arg23) : (index) -> i32
    %62 = "builtin.unrealized_conversion_cast"(%arg22) : (index) -> i32
    %63 = "builtin.unrealized_conversion_cast"(%arg21) : (memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<24 x i32, stride=4> [0])>, StorageBuffer>
    %64 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %65 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %66 = "spirv.Constant"() <{value = 12 : i32}> : () -> i32
    %67 = "spirv.IMul"(%62, %66) : (i32, i32) -> i32
    %68 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %69 = "spirv.IMul"(%61, %68) : (i32, i32) -> i32
    %70 = "spirv.IAdd"(%69, %67) : (i32, i32) -> i32
    %71 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %72 = "spirv.IAdd"(%60, %70) : (i32, i32) -> i32
    %73 = "spirv.AccessChain"(%63, %64, %72) : (!spirv.ptr<!spirv.struct<(!spirv.array<24 x i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
    %74 = "spirv.AtomicUMax"(%73, %arg20) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    "func.return"(%74) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, memref<2x3x4xi32, #spirv.storage_class<Workgroup>>, index, index, index) -> i32, sym_name = "atomic_mins_workgroup"}> ({
  ^bb0(%arg15: i32, %arg16: memref<2x3x4xi32, #spirv.storage_class<Workgroup>>, %arg17: index, %arg18: index, %arg19: index):
    %45 = "builtin.unrealized_conversion_cast"(%arg19) : (index) -> i32
    %46 = "builtin.unrealized_conversion_cast"(%arg18) : (index) -> i32
    %47 = "builtin.unrealized_conversion_cast"(%arg17) : (index) -> i32
    %48 = "builtin.unrealized_conversion_cast"(%arg16) : (memref<2x3x4xi32, #spirv.storage_class<Workgroup>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<24 x i32>)>, Workgroup>
    %49 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %50 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %51 = "spirv.Constant"() <{value = 12 : i32}> : () -> i32
    %52 = "spirv.IMul"(%47, %51) : (i32, i32) -> i32
    %53 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %54 = "spirv.IMul"(%46, %53) : (i32, i32) -> i32
    %55 = "spirv.IAdd"(%54, %52) : (i32, i32) -> i32
    %56 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %57 = "spirv.IAdd"(%45, %55) : (i32, i32) -> i32
    %58 = "spirv.AccessChain"(%48, %49, %57) : (!spirv.ptr<!spirv.struct<(!spirv.array<24 x i32>)>, Workgroup>, i32, i32) -> !spirv.ptr<i32, Workgroup>
    %59 = "spirv.AtomicSMin"(%58, %arg15) <{memory_scope = #spirv.scope<Workgroup>, semantics = #spirv.memory_semantics<AcquireRelease>}> : (!spirv.ptr<i32, Workgroup>, i32) -> i32
    "func.return"(%59) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>>, index, index, index) -> i32, sym_name = "atomic_minu_storage_buffer"}> ({
  ^bb0(%arg10: i32, %arg11: memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>>, %arg12: index, %arg13: index, %arg14: index):
    %30 = "builtin.unrealized_conversion_cast"(%arg14) : (index) -> i32
    %31 = "builtin.unrealized_conversion_cast"(%arg13) : (index) -> i32
    %32 = "builtin.unrealized_conversion_cast"(%arg12) : (index) -> i32
    %33 = "builtin.unrealized_conversion_cast"(%arg11) : (memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<24 x i32, stride=4> [0])>, StorageBuffer>
    %34 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %35 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %36 = "spirv.Constant"() <{value = 12 : i32}> : () -> i32
    %37 = "spirv.IMul"(%32, %36) : (i32, i32) -> i32
    %38 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %39 = "spirv.IMul"(%31, %38) : (i32, i32) -> i32
    %40 = "spirv.IAdd"(%39, %37) : (i32, i32) -> i32
    %41 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %42 = "spirv.IAdd"(%30, %40) : (i32, i32) -> i32
    %43 = "spirv.AccessChain"(%33, %34, %42) : (!spirv.ptr<!spirv.struct<(!spirv.array<24 x i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
    %44 = "spirv.AtomicUMin"(%43, %arg10) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    "func.return"(%44) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, memref<2x3x4xi32, #spirv.storage_class<Workgroup>>, index, index, index) -> i32, sym_name = "atomic_ori_workgroup"}> ({
  ^bb0(%arg5: i32, %arg6: memref<2x3x4xi32, #spirv.storage_class<Workgroup>>, %arg7: index, %arg8: index, %arg9: index):
    %15 = "builtin.unrealized_conversion_cast"(%arg9) : (index) -> i32
    %16 = "builtin.unrealized_conversion_cast"(%arg8) : (index) -> i32
    %17 = "builtin.unrealized_conversion_cast"(%arg7) : (index) -> i32
    %18 = "builtin.unrealized_conversion_cast"(%arg6) : (memref<2x3x4xi32, #spirv.storage_class<Workgroup>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<24 x i32>)>, Workgroup>
    %19 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %20 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %21 = "spirv.Constant"() <{value = 12 : i32}> : () -> i32
    %22 = "spirv.IMul"(%17, %21) : (i32, i32) -> i32
    %23 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %24 = "spirv.IMul"(%16, %23) : (i32, i32) -> i32
    %25 = "spirv.IAdd"(%24, %22) : (i32, i32) -> i32
    %26 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %27 = "spirv.IAdd"(%15, %25) : (i32, i32) -> i32
    %28 = "spirv.AccessChain"(%18, %19, %27) : (!spirv.ptr<!spirv.struct<(!spirv.array<24 x i32>)>, Workgroup>, i32, i32) -> !spirv.ptr<i32, Workgroup>
    %29 = "spirv.AtomicOr"(%28, %arg5) <{memory_scope = #spirv.scope<Workgroup>, semantics = #spirv.memory_semantics<AcquireRelease>}> : (!spirv.ptr<i32, Workgroup>, i32) -> i32
    "func.return"(%29) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>>, index, index, index) -> i32, sym_name = "atomic_andi_storage_buffer"}> ({
  ^bb0(%arg0: i32, %arg1: memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>>, %arg2: index, %arg3: index, %arg4: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg4) : (index) -> i32
    %1 = "builtin.unrealized_conversion_cast"(%arg3) : (index) -> i32
    %2 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i32
    %3 = "builtin.unrealized_conversion_cast"(%arg1) : (memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<24 x i32, stride=4> [0])>, StorageBuffer>
    %4 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %5 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %6 = "spirv.Constant"() <{value = 12 : i32}> : () -> i32
    %7 = "spirv.IMul"(%2, %6) : (i32, i32) -> i32
    %8 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %9 = "spirv.IMul"(%1, %8) : (i32, i32) -> i32
    %10 = "spirv.IAdd"(%9, %7) : (i32, i32) -> i32
    %11 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %12 = "spirv.IAdd"(%0, %10) : (i32, i32) -> i32
    %13 = "spirv.AccessChain"(%3, %4, %12) : (!spirv.ptr<!spirv.struct<(!spirv.array<24 x i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
    %14 = "spirv.AtomicAnd"(%13, %arg0) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
    "func.return"(%14) : (i32) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader], []>, #spirv.resource_limits<>>} : () -> ()

