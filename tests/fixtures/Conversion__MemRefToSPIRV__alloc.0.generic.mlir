"builtin.module"() ({
  "spirv.GlobalVariable"() <{sym_name = "__workgroup_mem__0", type = !spirv.ptr<!spirv.struct<(!spirv.array<20 x f32>)>, Workgroup>}> : () -> ()
  "func.func"() <{function_type = (index, index) -> (), sym_name = "alloc_dealloc_workgroup_mem_shader_f32"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "spirv.Constant"() <{value = 5 : i32}> : () -> i32
    %1 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %2 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i32
    %3 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> i32
    %4 = "spirv.mlir.addressof"() <{variable = @__workgroup_mem__0}> : () -> !spirv.ptr<!spirv.struct<(!spirv.array<20 x f32>)>, Workgroup>
    %5 = "spirv.IMul"(%3, %0) : (i32, i32) -> i32
    %6 = "spirv.IAdd"(%2, %5) : (i32, i32) -> i32
    %7 = "spirv.AccessChain"(%4, %1, %6) : (!spirv.ptr<!spirv.struct<(!spirv.array<20 x f32>)>, Workgroup>, i32, i32) -> !spirv.ptr<f32, Workgroup>
    %8 = "spirv.Load"(%7) : (!spirv.ptr<f32, Workgroup>) -> f32
    %9 = "spirv.IMul"(%3, %0) : (i32, i32) -> i32
    %10 = "spirv.IAdd"(%2, %9) : (i32, i32) -> i32
    %11 = "spirv.AccessChain"(%4, %1, %10) : (!spirv.ptr<!spirv.struct<(!spirv.array<20 x f32>)>, Workgroup>, i32, i32) -> !spirv.ptr<f32, Workgroup>
    "spirv.Store"(%11, %8) : (!spirv.ptr<f32, Workgroup>, f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.GlobalVariable"() <{sym_name = "__workgroup_mem__0", type = !spirv.ptr<!spirv.struct<(!spirv.array<10 x i32>)>, Workgroup>}> : () -> ()
  "func.func"() <{function_type = (index, index) -> (), sym_name = "alloc_dealloc_workgroup_mem_shader_i16"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "spirv.Constant"() <{value = 65535 : i32}> : () -> i32
    %1 = "spirv.Constant"() <{value = 16 : i32}> : () -> i32
    %2 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    %3 = "spirv.Constant"() <{value = 5 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %5 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i32
    %6 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> i32
    %7 = "spirv.mlir.addressof"() <{variable = @__workgroup_mem__0}> : () -> !spirv.ptr<!spirv.struct<(!spirv.array<10 x i32>)>, Workgroup>
    %8 = "spirv.IMul"(%6, %3) : (i32, i32) -> i32
    %9 = "spirv.IAdd"(%5, %8) : (i32, i32) -> i32
    %10 = "spirv.SDiv"(%9, %2) : (i32, i32) -> i32
    %11 = "spirv.AccessChain"(%7, %4, %10) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x i32>)>, Workgroup>, i32, i32) -> !spirv.ptr<i32, Workgroup>
    %12 = "spirv.Load"(%11) : (!spirv.ptr<i32, Workgroup>) -> i32
    %13 = "spirv.UMod"(%9, %2) : (i32, i32) -> i32
    %14 = "spirv.IMul"(%13, %1) : (i32, i32) -> i32
    %15 = "spirv.ShiftRightArithmetic"(%12, %14) : (i32, i32) -> i32
    %16 = "spirv.BitwiseAnd"(%15, %0) : (i32, i32) -> i32
    %17 = "spirv.ShiftLeftLogical"(%16, %1) : (i32, i32) -> i32
    %18 = "spirv.ShiftRightArithmetic"(%17, %1) : (i32, i32) -> i32
    %19 = "spirv.IMul"(%6, %3) : (i32, i32) -> i32
    %20 = "spirv.IAdd"(%5, %19) : (i32, i32) -> i32
    %21 = "spirv.UMod"(%20, %2) : (i32, i32) -> i32
    %22 = "spirv.IMul"(%21, %1) : (i32, i32) -> i32
    %23 = "spirv.ShiftLeftLogical"(%0, %22) : (i32, i32) -> i32
    %24 = "spirv.Not"(%23) : (i32) -> i32
    %25 = "spirv.BitwiseAnd"(%18, %0) : (i32, i32) -> i32
    %26 = "spirv.ShiftLeftLogical"(%25, %22) : (i32, i32) -> i32
    %27 = "spirv.SDiv"(%20, %2) : (i32, i32) -> i32
    %28 = "spirv.AccessChain"(%7, %4, %27) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x i32>)>, Workgroup>, i32, i32) -> !spirv.ptr<i32, Workgroup>
    %29 = "spirv.AtomicAnd"(%28, %24) <{memory_scope = #spirv.scope<Workgroup>, semantics = #spirv.memory_semantics<AcquireRelease>}> : (!spirv.ptr<i32, Workgroup>, i32) -> i32
    %30 = "spirv.AtomicOr"(%28, %26) <{memory_scope = #spirv.scope<Workgroup>, semantics = #spirv.memory_semantics<AcquireRelease>}> : (!spirv.ptr<i32, Workgroup>, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.GlobalVariable"() <{sym_name = "__workgroup_mem__1", type = !spirv.ptr<!spirv.struct<(!spirv.array<6 x i32>)>, Workgroup>}> : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "__workgroup_mem__0", type = !spirv.ptr<!spirv.struct<(!spirv.array<20 x f32>)>, Workgroup>}> : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "two_allocs"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.GlobalVariable"() <{sym_name = "__workgroup_mem__1", type = !spirv.ptr<!spirv.struct<(!spirv.array<2 x vector<2xi32>>)>, Workgroup>}> : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "__workgroup_mem__0", type = !spirv.ptr<!spirv.struct<(!spirv.array<4 x vector<4xf32>>)>, Workgroup>}> : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "two_allocs_vector"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> f32, sym_name = "alloc_dynamic_size"}> ({
  ^bb0(%arg0: index):
    %0 = "memref.alloc"(%arg0) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<4x?xf32, #spirv.storage_class<Workgroup>>
    %1 = "memref.load"(%0, %arg0, %arg0) : (memref<4x?xf32, #spirv.storage_class<Workgroup>>, index, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> f32, sym_name = "alloc_unsupported_memory_space"}> ({
  ^bb0(%arg0: index):
    %0 = "spirv.Constant"() <{value = 5 : i32}> : () -> i32
    %1 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> i32
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x5xf32, #spirv.storage_class<StorageBuffer>>
    %4 = "builtin.unrealized_conversion_cast"(%3) : (memref<4x5xf32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<20 x f32, stride=4> [0])>, StorageBuffer>
    %5 = "spirv.IMul"(%2, %0) : (i32, i32) -> i32
    %6 = "spirv.IAdd"(%2, %5) : (i32, i32) -> i32
    %7 = "spirv.AccessChain"(%4, %1, %6) : (!spirv.ptr<!spirv.struct<(!spirv.array<20 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    %8 = "spirv.Load"(%7) : (!spirv.ptr<f32, StorageBuffer>) -> f32
    "func.return"(%8) : (f32) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x?xf32, #spirv.storage_class<Workgroup>>) -> (), sym_name = "dealloc_dynamic_size"}> ({
  ^bb0(%arg0: memref<4x?xf32, #spirv.storage_class<Workgroup>>):
    "memref.dealloc"(%arg0) : (memref<4x?xf32, #spirv.storage_class<Workgroup>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x5xf32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "dealloc_unsupported_memory_space"}> ({
  ^bb0(%arg0: memref<4x5xf32, #spirv.storage_class<StorageBuffer>>):
    "memref.dealloc"(%arg0) : (memref<4x5xf32, #spirv.storage_class<StorageBuffer>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.GlobalVariable"() <{sym_name = "__workgroup_mem__0", type = !spirv.ptr<!spirv.array<20 x f32>, Workgroup>}> : () -> ()
  "func.func"() <{function_type = (index, index) -> (), sym_name = "alloc_dealloc_workgroup_mem_kernel"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "spirv.Constant"() <{value = 5 : i32}> : () -> i32
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i32
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> i32
    %3 = "spirv.mlir.addressof"() <{variable = @__workgroup_mem__0}> : () -> !spirv.ptr<!spirv.array<20 x f32>, Workgroup>
    %4 = "spirv.IMul"(%2, %0) : (i32, i32) -> i32
    %5 = "spirv.IAdd"(%1, %4) : (i32, i32) -> i32
    %6 = "spirv.AccessChain"(%3, %5) : (!spirv.ptr<!spirv.array<20 x f32>, Workgroup>, i32) -> !spirv.ptr<f32, Workgroup>
    %7 = "spirv.Load"(%6) : (!spirv.ptr<f32, Workgroup>) -> f32
    %8 = "spirv.IMul"(%2, %0) : (i32, i32) -> i32
    %9 = "spirv.IAdd"(%1, %8) : (i32, i32) -> i32
    %10 = "spirv.AccessChain"(%3, %9) : (!spirv.ptr<!spirv.array<20 x f32>, Workgroup>, i32) -> !spirv.ptr<f32, Workgroup>
    "spirv.Store"(%10, %7) : (!spirv.ptr<f32, Workgroup>, f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "zero_size"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

