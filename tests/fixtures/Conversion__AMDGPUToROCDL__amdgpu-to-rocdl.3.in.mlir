"builtin.module"() ({
  "func.func"() <{function_type = (memref<8xi32, #gpu.address_space<global>>) -> memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>, sym_name = "fat_raw_buffer_cast"}> ({
  ^bb0(%arg73: memref<8xi32, #gpu.address_space<global>>):
    %27 = "amdgpu.fat_raw_buffer_cast"(%arg73) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 0, 0>}> : (memref<8xi32, #gpu.address_space<global>>) -> memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>
    "func.return"(%27) : (memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i32, #gpu.address_space<global>>) -> memref<i32, #amdgpu.address_space<fat_raw_buffer>>, sym_name = "fat_raw_buffer_cast_0d"}> ({
  ^bb0(%arg72: memref<i32, #gpu.address_space<global>>):
    %26 = "amdgpu.fat_raw_buffer_cast"(%arg72) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 0, 0>}> : (memref<i32, #gpu.address_space<global>>) -> memref<i32, #amdgpu.address_space<fat_raw_buffer>>
    "func.return"(%26) : (memref<i32, #amdgpu.address_space<fat_raw_buffer>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi32, strided<[1], offset: ?>, #gpu.address_space<global>>) -> memref<?xi32, strided<[1], offset: ?>, #amdgpu.address_space<fat_raw_buffer>>, sym_name = "fat_raw_buffer_cast_dyn_size_offset"}> ({
  ^bb0(%arg71: memref<?xi32, strided<[1], offset: ?>, #gpu.address_space<global>>):
    %25 = "amdgpu.fat_raw_buffer_cast"(%arg71) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 0, 0>}> : (memref<?xi32, strided<[1], offset: ?>, #gpu.address_space<global>>) -> memref<?xi32, strided<[1], offset: ?>, #amdgpu.address_space<fat_raw_buffer>>
    "func.return"(%25) : (memref<?xi32, strided<[1], offset: ?>, #amdgpu.address_space<fat_raw_buffer>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi32, strided<[1], offset: ?>, #gpu.address_space<global>>) -> memref<?xi32, #amdgpu.address_space<fat_raw_buffer>>, sym_name = "fat_raw_buffer_cast_reset_offset"}> ({
  ^bb0(%arg70: memref<?xi32, strided<[1], offset: ?>, #gpu.address_space<global>>):
    %24 = "amdgpu.fat_raw_buffer_cast"(%arg70) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 0, 0>, resetOffset}> : (memref<?xi32, strided<[1], offset: ?>, #gpu.address_space<global>>) -> memref<?xi32, #amdgpu.address_space<fat_raw_buffer>>
    "func.return"(%24) : (memref<?xi32, #amdgpu.address_space<fat_raw_buffer>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<8xi32, #gpu.address_space<global>>) -> memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>, sym_name = "fat_raw_buffer_cast_valid_bytes"}> ({
  ^bb0(%arg69: memref<8xi32, #gpu.address_space<global>>):
    %22 = "arith.constant"() <{value = -1 : i64}> : () -> i64
    %23 = "amdgpu.fat_raw_buffer_cast"(%arg69, %22) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 1, 0>}> : (memref<8xi32, #gpu.address_space<global>>, i64) -> memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>
    "func.return"(%23) : (memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<8xi32, #gpu.address_space<global>>) -> memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>, sym_name = "fat_raw_buffer_cast_bounds_check"}> ({
  ^bb0(%arg68: memref<8xi32, #gpu.address_space<global>>):
    %21 = "amdgpu.fat_raw_buffer_cast"(%arg68) <{boundsCheck = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (memref<8xi32, #gpu.address_space<global>>) -> memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>
    "func.return"(%21) : (memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64x64xi32, #gpu.address_space<global>>, i14) -> memref<64x64xi32, #amdgpu.address_space<fat_raw_buffer>>, sym_name = "fat_raw_buffer_cast_cache_swizzle"}> ({
  ^bb0(%arg66: memref<64x64xi32, #gpu.address_space<global>>, %arg67: i14):
    %20 = "amdgpu.fat_raw_buffer_cast"(%arg66, %arg67) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 0, 1>}> : (memref<64x64xi32, #gpu.address_space<global>>, i14) -> memref<64x64xi32, #amdgpu.address_space<fat_raw_buffer>>
    "func.return"(%20) : (memref<64x64xi32, #amdgpu.address_space<fat_raw_buffer>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i32>) -> i32, sym_name = "gpu_gcn_raw_buffer_load_scalar_i32"}> ({
  ^bb0(%arg65: memref<i32>):
    %19 = "amdgpu.raw_buffer_load"(%arg65) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 0, 0>}> : (memref<i32>) -> i32
    "func.return"(%19) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64xi32>, i32) -> i32, sym_name = "gpu_gcn_raw_buffer_load_i32"}> ({
  ^bb0(%arg63: memref<64xi32>, %arg64: i32):
    %18 = "amdgpu.raw_buffer_load"(%arg63, %arg64) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 1, 0>}> : (memref<64xi32>, i32) -> i32
    "func.return"(%18) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16x16xi32, strided<[?, ?], offset: ?>>, i32, i32) -> i32, sym_name = "gpu_gcn_raw_buffer_load_i32_strided"}> ({
  ^bb0(%arg60: memref<16x16xi32, strided<[?, ?], offset: ?>>, %arg61: i32, %arg62: i32):
    %17 = "amdgpu.raw_buffer_load"(%arg60, %arg61, %arg62) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<16x16xi32, strided<[?, ?], offset: ?>>, i32, i32) -> i32
    "func.return"(%17) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64xi32>, i32) -> i32, sym_name = "gpu_gcn_raw_buffer_load_i32_oob_off"}> ({
  ^bb0(%arg58: memref<64xi32>, %arg59: i32):
    %16 = "amdgpu.raw_buffer_load"(%arg58, %arg59) <{boundsCheck = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (memref<64xi32>, i32) -> i32
    "func.return"(%16) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64xi32>, i32) -> vector<1xi32>, sym_name = "gpu_gcn_raw_buffer_load_1xi32"}> ({
  ^bb0(%arg56: memref<64xi32>, %arg57: i32):
    %15 = "amdgpu.raw_buffer_load"(%arg56, %arg57) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 1, 0>}> : (memref<64xi32>, i32) -> vector<1xi32>
    "func.return"(%15) : (vector<1xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64xi32>, i32) -> vector<2xi32>, sym_name = "gpu_gcn_raw_buffer_load_2xi32"}> ({
  ^bb0(%arg54: memref<64xi32>, %arg55: i32):
    %14 = "amdgpu.raw_buffer_load"(%arg54, %arg55) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 1, 0>}> : (memref<64xi32>, i32) -> vector<2xi32>
    "func.return"(%14) : (vector<2xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64xi8>, i32) -> i8, sym_name = "gpu_gcn_raw_buffer_load_i8"}> ({
  ^bb0(%arg52: memref<64xi8>, %arg53: i32):
    %13 = "amdgpu.raw_buffer_load"(%arg52, %arg53) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 1, 0>}> : (memref<64xi8>, i32) -> i8
    "func.return"(%13) : (i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64xi8>, i32) -> vector<2xi8>, sym_name = "gpu_gcn_raw_buffer_load_2xi8"}> ({
  ^bb0(%arg50: memref<64xi8>, %arg51: i32):
    %12 = "amdgpu.raw_buffer_load"(%arg50, %arg51) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 1, 0>}> : (memref<64xi8>, i32) -> vector<2xi8>
    "func.return"(%12) : (vector<2xi8>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64xi8>, i32) -> vector<16xi8>, sym_name = "gpu_gcn_raw_buffer_load_16xi8"}> ({
  ^bb0(%arg48: memref<64xi8>, %arg49: i32):
    %11 = "amdgpu.raw_buffer_load"(%arg48, %arg49) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 1, 0>}> : (memref<64xi8>, i32) -> vector<16xi8>
    "func.return"(%11) : (vector<16xi8>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64xf8E5M2FNUZ>, i32) -> f8E5M2FNUZ, sym_name = "gpu_gcn_raw_buffer_load_f8E5M2FNUZ"}> ({
  ^bb0(%arg46: memref<64xf8E5M2FNUZ>, %arg47: i32):
    %10 = "amdgpu.raw_buffer_load"(%arg46, %arg47) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 1, 0>}> : (memref<64xf8E5M2FNUZ>, i32) -> f8E5M2FNUZ
    "func.return"(%10) : (f8E5M2FNUZ) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64xf8E4M3FNUZ>, i32) -> vector<4xf8E4M3FNUZ>, sym_name = "gpu_gcn_raw_buffer_load_4xf8E4M3FNUZ"}> ({
  ^bb0(%arg44: memref<64xf8E4M3FNUZ>, %arg45: i32):
    %9 = "amdgpu.raw_buffer_load"(%arg44, %arg45) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 1, 0>}> : (memref<64xf8E4M3FNUZ>, i32) -> vector<4xf8E4M3FNUZ>
    "func.return"(%9) : (vector<4xf8E4M3FNUZ>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, memref<i32>) -> (), sym_name = "gpu_gcn_raw_buffer_store_scalar_i32"}> ({
  ^bb0(%arg42: i32, %arg43: memref<i32>):
    "amdgpu.raw_buffer_store"(%arg42, %arg43) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 1, 0, 0>}> : (i32, memref<i32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, memref<64xi32>, i32) -> (), sym_name = "gpu_gcn_raw_buffer_store_i32"}> ({
  ^bb0(%arg39: i32, %arg40: memref<64xi32>, %arg41: i32):
    "amdgpu.raw_buffer_store"(%arg39, %arg40, %arg41) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 1, 1, 0>}> : (i32, memref<64xi32>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf32>, memref<64xf32>, i32) -> (), sym_name = "gpu_gcn_raw_buffer_store_1xf32"}> ({
  ^bb0(%arg36: vector<1xf32>, %arg37: memref<64xf32>, %arg38: i32):
    "amdgpu.raw_buffer_store"(%arg36, %arg37, %arg38) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 1, 1, 0>}> : (vector<1xf32>, memref<64xf32>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi8>, memref<64xi8>, i32) -> (), sym_name = "gpu_gcn_raw_buffer_store_2xi8"}> ({
  ^bb0(%arg33: vector<2xi8>, %arg34: memref<64xi8>, %arg35: i32):
    "amdgpu.raw_buffer_store"(%arg33, %arg34, %arg35) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 1, 1, 0>}> : (vector<2xi8>, memref<64xi8>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<16xi8>, memref<64xi8>, i32) -> (), sym_name = "gpu_gcn_raw_buffer_store_16xi8"}> ({
  ^bb0(%arg30: vector<16xi8>, %arg31: memref<64xi8>, %arg32: i32):
    "amdgpu.raw_buffer_store"(%arg30, %arg31, %arg32) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 1, 1, 0>}> : (vector<16xi8>, memref<64xi8>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, memref<64xf32>, i32) -> f32, sym_name = "gpu_gcn_raw_buffer_atomic_fadd_f32"}> ({
  ^bb0(%arg27: f32, %arg28: memref<64xf32>, %arg29: i32):
    %8 = "amdgpu.raw_buffer_atomic_fadd"(%arg27, %arg28, %arg29) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 1, 1, 0>}> : (f32, memref<64xf32>, i32) -> f32
    "func.return"(%8) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf16>, memref<64xf16>, i32) -> vector<2xf16>, sym_name = "gpu_gcn_raw_buffer_atomic_fadd_v2f16"}> ({
  ^bb0(%arg24: vector<2xf16>, %arg25: memref<64xf16>, %arg26: i32):
    %7 = "amdgpu.raw_buffer_atomic_fadd"(%arg24, %arg25, %arg26) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 1, 1, 0>}> : (vector<2xf16>, memref<64xf16>, i32) -> vector<2xf16>
    "func.return"(%7) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xbf16>, memref<64xbf16>, i32) -> vector<2xbf16>, sym_name = "gpu_gcn_raw_buffer_atomic_fadd_v2bf16"}> ({
  ^bb0(%arg21: vector<2xbf16>, %arg22: memref<64xbf16>, %arg23: i32):
    %6 = "amdgpu.raw_buffer_atomic_fadd"(%arg21, %arg22, %arg23) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 1, 1, 0>}> : (vector<2xbf16>, memref<64xbf16>, i32) -> vector<2xbf16>
    "func.return"(%6) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, memref<64xf32>, i32) -> f32, sym_name = "gpu_gcn_raw_buffer_atomic_fmax_f32"}> ({
  ^bb0(%arg18: f32, %arg19: memref<64xf32>, %arg20: i32):
    %5 = "amdgpu.raw_buffer_atomic_fmax"(%arg18, %arg19, %arg20) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 1, 1, 0>}> : (f32, memref<64xf32>, i32) -> f32
    "func.return"(%5) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, memref<64xi32>, i32) -> i32, sym_name = "gpu_gcn_raw_buffer_atomic_smax_i32"}> ({
  ^bb0(%arg15: i32, %arg16: memref<64xi32>, %arg17: i32):
    %4 = "amdgpu.raw_buffer_atomic_smax"(%arg15, %arg16, %arg17) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 1, 1, 0>}> : (i32, memref<64xi32>, i32) -> i32
    "func.return"(%4) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, memref<64xi32>, i32) -> i32, sym_name = "gpu_gcn_raw_buffer_atomic_umin_i32"}> ({
  ^bb0(%arg12: i32, %arg13: memref<64xi32>, %arg14: i32):
    %3 = "amdgpu.raw_buffer_atomic_umin"(%arg12, %arg13, %arg14) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 1, 1, 0>}> : (i32, memref<64xi32>, i32) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, memref<64xf32>, i32) -> f32, sym_name = "amdgpu_raw_buffer_atomic_cmpswap_f32"}> ({
  ^bb0(%arg8: f32, %arg9: f32, %arg10: memref<64xf32>, %arg11: i32):
    %2 = "amdgpu.raw_buffer_atomic_cmpswap"(%arg8, %arg9, %arg10, %arg11) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 1, 1, 1, 0>}> : (f32, f32, memref<64xf32>, i32) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64, i64, memref<64xi64>, i32) -> i64, sym_name = "amdgpu_raw_buffer_atomic_cmpswap_i64"}> ({
  ^bb0(%arg4: i64, %arg5: i64, %arg6: memref<64xi64>, %arg7: i32):
    %1 = "amdgpu.raw_buffer_atomic_cmpswap"(%arg4, %arg5, %arg6, %arg7) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 1, 1, 1, 0>}> : (i64, i64, memref<64xi64>, i32) -> i64
    "func.return"(%1) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf16>, vector<2xf16>, memref<64xf16>, i32) -> vector<2xf16>, sym_name = "amdgpu_raw_buffer_atomic_cmpswap_v2f16"}> ({
  ^bb0(%arg0: vector<2xf16>, %arg1: vector<2xf16>, %arg2: memref<64xf16>, %arg3: i32):
    %0 = "amdgpu.raw_buffer_atomic_cmpswap"(%arg0, %arg1, %arg2, %arg3) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 1, 1, 1, 0>}> : (vector<2xf16>, vector<2xf16>, memref<64xf16>, i32) -> vector<2xf16>
    "func.return"(%0) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "lds_barrier"}> ({
    "amdgpu.lds_barrier"() : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "sched_barrier"}> ({
    "amdgpu.sched_barrier"() <{opts = #rocdl<sched_group_mask none>}> : () -> ()
    "amdgpu.sched_barrier"() <{opts = #rocdl<sched_group_mask non_mem_non_sideeffect>}> : () -> ()
    "amdgpu.sched_barrier"() <{opts = #rocdl<sched_group_mask valu|all_vmem>}> : () -> ()
    "amdgpu.sched_barrier"() <{opts = #rocdl<sched_group_mask all>}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

