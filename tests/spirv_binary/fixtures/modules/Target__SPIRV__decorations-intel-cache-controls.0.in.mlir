"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [CacheControlsINTEL], [SPV_INTEL_cache_controls]>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "cache_controls"}> ({
    %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> {cache_control_load_intel = [#spirv.cache_control_load_intel<cache_level = 0, load_cache_control = Uncached>, #spirv.cache_control_load_intel<cache_level = 1, load_cache_control = Cached>, #spirv.cache_control_load_intel<cache_level = 2, load_cache_control = InvalidateAfterR>]} : () -> !spirv.ptr<f32, Function>
    %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> {cache_control_store_intel = [#spirv.cache_control_store_intel<cache_level = 0, store_cache_control = Uncached>, #spirv.cache_control_store_intel<cache_level = 1, store_cache_control = WriteThrough>, #spirv.cache_control_store_intel<cache_level = 2, store_cache_control = WriteBack>]} : () -> !spirv.ptr<f32, Function>
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

