"builtin.module"() ({
  "func.func"() <{function_type = (memref<64x64xf16, #gpu.address_space<global>>, i64, i64) -> (), sym_name = "glb_prefetch0"}> ({
  ^bb0(%arg9: memref<64x64xf16, #gpu.address_space<global>>, %arg10: i64, %arg11: i64):
    "amdgpu.global_prefetch"(%arg9, %arg10, %arg11) <{cacheScope = #amdgpu<cache_scope WGP>, temporalHint = #amdgpu<load_temporal_hint HT>}> : (memref<64x64xf16, #gpu.address_space<global>>, i64, i64) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64x64xf16, #gpu.address_space<global>>, i64, i64) -> (), sym_name = "glb_prefetch1"}> ({
  ^bb0(%arg6: memref<64x64xf16, #gpu.address_space<global>>, %arg7: i64, %arg8: i64):
    "amdgpu.global_prefetch"(%arg6, %arg7, %arg8) <{cacheScope = #amdgpu<cache_scope SE>, speculative, temporalHint = #amdgpu<load_temporal_hint HT>}> : (memref<64x64xf16, #gpu.address_space<global>>, i64, i64) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64x64xf16, #gpu.address_space<global>>, i64, i64) -> (), sym_name = "glb_prefetch2"}> ({
  ^bb0(%arg3: memref<64x64xf16, #gpu.address_space<global>>, %arg4: i64, %arg5: i64):
    "amdgpu.global_prefetch"(%arg3, %arg4, %arg5) <{cacheScope = #amdgpu<cache_scope DEV>, speculative, temporalHint = #amdgpu<load_temporal_hint RT>}> : (memref<64x64xf16, #gpu.address_space<global>>, i64, i64) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64x64xf16, #gpu.address_space<global>>, i64, i64) -> (), sym_name = "glb_prefetch3"}> ({
  ^bb0(%arg0: memref<64x64xf16, #gpu.address_space<global>>, %arg1: i64, %arg2: i64):
    "amdgpu.global_prefetch"(%arg0, %arg1, %arg2) <{cacheScope = #amdgpu<cache_scope SE>, speculative, temporalHint = #amdgpu<load_temporal_hint NT_RT>}> : (memref<64x64xf16, #gpu.address_space<global>>, i64, i64) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

