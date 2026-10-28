"spirv.module"() <{addressing_model = #spirv.addressing_model<Physical64>, memory_model = #spirv.memory_model<OpenCL>, vce_triple = #spirv.vce<v1.0, [Kernel, Linkage, Addresses, AtomicFloat32AddEXT], [SPV_EXT_shader_atomic_float_add]>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<i32, Workgroup>, i32, i32) -> i32, sym_name = "test_int_atomics"}> ({
  ^bb0(%arg2: !spirv.ptr<i32, Workgroup>, %arg3: i32, %arg4: i32):
    %1 = "spirv.AtomicCompareExchangeWeak"(%arg2, %arg3, %arg4) <{equal_semantics = #spirv.memory_semantics<Release>, memory_scope = #spirv.scope<Workgroup>, unequal_semantics = #spirv.memory_semantics<Acquire>}> : (!spirv.ptr<i32, Workgroup>, i32, i32) -> i32
    %2 = "spirv.AtomicAnd"(%arg2, %arg3) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<None>}> : (!spirv.ptr<i32, Workgroup>, i32) -> i32
    %3 = "spirv.AtomicIAdd"(%arg2, %arg3) <{memory_scope = #spirv.scope<Workgroup>, semantics = #spirv.memory_semantics<Acquire>}> : (!spirv.ptr<i32, Workgroup>, i32) -> i32
    %4 = "spirv.AtomicIDecrement"(%arg2) <{memory_scope = #spirv.scope<Workgroup>, semantics = #spirv.memory_semantics<Acquire>}> : (!spirv.ptr<i32, Workgroup>) -> i32
    %5 = "spirv.AtomicIIncrement"(%arg2) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<Release>}> : (!spirv.ptr<i32, Workgroup>) -> i32
    %6 = "spirv.AtomicISub"(%arg2, %arg3) <{memory_scope = #spirv.scope<Workgroup>, semantics = #spirv.memory_semantics<Acquire>}> : (!spirv.ptr<i32, Workgroup>, i32) -> i32
    %7 = "spirv.AtomicOr"(%arg2, %arg3) <{memory_scope = #spirv.scope<Workgroup>, semantics = #spirv.memory_semantics<AcquireRelease>}> : (!spirv.ptr<i32, Workgroup>, i32) -> i32
    %8 = "spirv.AtomicSMax"(%arg2, %arg3) <{memory_scope = #spirv.scope<Subgroup>, semantics = #spirv.memory_semantics<None>}> : (!spirv.ptr<i32, Workgroup>, i32) -> i32
    %9 = "spirv.AtomicSMin"(%arg2, %arg3) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<Release>}> : (!spirv.ptr<i32, Workgroup>, i32) -> i32
    %10 = "spirv.AtomicUMax"(%arg2, %arg3) <{memory_scope = #spirv.scope<Subgroup>, semantics = #spirv.memory_semantics<None>}> : (!spirv.ptr<i32, Workgroup>, i32) -> i32
    %11 = "spirv.AtomicUMin"(%arg2, %arg3) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<Release>}> : (!spirv.ptr<i32, Workgroup>, i32) -> i32
    %12 = "spirv.AtomicXor"(%arg2, %arg3) <{memory_scope = #spirv.scope<Workgroup>, semantics = #spirv.memory_semantics<AcquireRelease>}> : (!spirv.ptr<i32, Workgroup>, i32) -> i32
    %13 = "spirv.AtomicCompareExchange"(%arg2, %arg3, %arg4) <{equal_semantics = #spirv.memory_semantics<Release>, memory_scope = #spirv.scope<Workgroup>, unequal_semantics = #spirv.memory_semantics<Acquire>}> : (!spirv.ptr<i32, Workgroup>, i32, i32) -> i32
    %14 = "spirv.AtomicExchange"(%arg2, %arg3) <{memory_scope = #spirv.scope<Workgroup>, semantics = #spirv.memory_semantics<Release>}> : (!spirv.ptr<i32, Workgroup>, i32) -> i32
    "spirv.ReturnValue"(%1) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<f32, Workgroup>, f32) -> f32, sym_name = "test_float_atomics"}> ({
  ^bb0(%arg0: !spirv.ptr<f32, Workgroup>, %arg1: f32):
    %0 = "spirv.EXT.AtomicFAdd"(%arg0, %arg1) <{memory_scope = #spirv.scope<Workgroup>, semantics = #spirv.memory_semantics<Acquire>}> : (!spirv.ptr<f32, Workgroup>, f32) -> f32
    "spirv.ReturnValue"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

