"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x72xf32, #gpu.address_space<global>>) -> (), sym_name = "global_load_to_rocdl_f32"}> ({
  ^bb0(%arg10: memref<128x72xf32, #gpu.address_space<global>>):
    %27 = "arith.constant"() <{value = 0 : index}> : () -> index
    %28 = "arith.constant"() <{value = 12 : index}> : () -> index
    %29 = "arith.constant"() <{value = 32 : index}> : () -> index
    %30 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xf32, #gpu.address_space<workgroup>>
    "amdgpu.gather_to_lds"(%arg10, %28, %27, %30, %29, %27) <{operandSegmentSizes = array<i32: 1, 2, 1, 2>, transferType = f32}> : (memref<128x72xf32, #gpu.address_space<global>>, index, index, memref<64x64xf32, #gpu.address_space<workgroup>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<128x72xf32>) -> (), sym_name = "global_load_to_rocdl_wg_mem"}> ({
  ^bb0(%arg9: memref<128x72xf32>):
    %23 = "arith.constant"() <{value = 0 : index}> : () -> index
    %24 = "arith.constant"() <{value = 12 : index}> : () -> index
    %25 = "arith.constant"() <{value = 32 : index}> : () -> index
    %26 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xf32, #gpu.address_space<workgroup>>
    "amdgpu.gather_to_lds"(%arg9, %24, %23, %26, %25, %23) <{operandSegmentSizes = array<i32: 1, 2, 1, 2>, transferType = f32}> : (memref<128x72xf32>, index, index, memref<64x64xf32, #gpu.address_space<workgroup>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32>) -> (), sym_name = "global_load_to_rocdl_0d"}> ({
  ^bb0(%arg8: memref<f32>):
    %22 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32, #gpu.address_space<workgroup>>
    "amdgpu.gather_to_lds"(%arg8, %22) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, transferType = f32}> : (memref<f32>, memref<f32, #gpu.address_space<workgroup>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<128x72xi8, #gpu.address_space<global>>) -> (), sym_name = "global_load_to_rocdl_i8"}> ({
  ^bb0(%arg7: memref<128x72xi8, #gpu.address_space<global>>):
    %18 = "arith.constant"() <{value = 0 : index}> : () -> index
    %19 = "arith.constant"() <{value = 12 : index}> : () -> index
    %20 = "arith.constant"() <{value = 32 : index}> : () -> index
    %21 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xi8, #gpu.address_space<workgroup>>
    "amdgpu.gather_to_lds"(%arg7, %19, %18, %21, %20, %18) <{operandSegmentSizes = array<i32: 1, 2, 1, 2>, transferType = i8}> : (memref<128x72xi8, #gpu.address_space<global>>, index, index, memref<64x64xi8, #gpu.address_space<workgroup>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<128x72xi16, #gpu.address_space<global>>) -> (), sym_name = "global_load_to_rocdl_vec"}> ({
  ^bb0(%arg6: memref<128x72xi16, #gpu.address_space<global>>):
    %14 = "arith.constant"() <{value = 0 : index}> : () -> index
    %15 = "arith.constant"() <{value = 12 : index}> : () -> index
    %16 = "arith.constant"() <{value = 32 : index}> : () -> index
    %17 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x128xi16, #gpu.address_space<workgroup>>
    "amdgpu.gather_to_lds"(%arg6, %15, %14, %17, %16, %14) <{operandSegmentSizes = array<i32: 1, 2, 1, 2>, transferType = vector<2xi16>}> : (memref<128x72xi16, #gpu.address_space<global>>, index, index, memref<64x128xi16, #gpu.address_space<workgroup>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<512xi32, #gpu.address_space<global>>, index, index) -> (), sym_name = "global_load_to_rocdl_dynamic_indices"}> ({
  ^bb0(%arg3: memref<512xi32, #gpu.address_space<global>>, %arg4: index, %arg5: index):
    %12 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x64xi32, #gpu.address_space<workgroup>>
    %13 = "arith.constant"() <{value = 0 : index}> : () -> index
    "amdgpu.gather_to_lds"(%arg3, %arg4, %12, %arg5, %13) <{operandSegmentSizes = array<i32: 1, 1, 1, 2>, transferType = i32}> : (memref<512xi32, #gpu.address_space<global>>, index, memref<4x64xi32, #gpu.address_space<workgroup>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<128x72xf32, #amdgpu.address_space<fat_raw_buffer>>) -> (), sym_name = "fat_buffer_load_to_rocdl_f32"}> ({
  ^bb0(%arg2: memref<128x72xf32, #amdgpu.address_space<fat_raw_buffer>>):
    %8 = "arith.constant"() <{value = 0 : index}> : () -> index
    %9 = "arith.constant"() <{value = 12 : index}> : () -> index
    %10 = "arith.constant"() <{value = 32 : index}> : () -> index
    %11 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xf32, #gpu.address_space<workgroup>>
    "amdgpu.gather_to_lds"(%arg2, %9, %8, %11, %10, %8) <{operandSegmentSizes = array<i32: 1, 2, 1, 2>, transferType = f32}> : (memref<128x72xf32, #amdgpu.address_space<fat_raw_buffer>>, index, index, memref<64x64xf32, #gpu.address_space<workgroup>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<128x72xf32, #gpu.address_space<global>>) -> (), sym_name = "global_load_to_rocdl_async_f32"}> ({
  ^bb0(%arg1: memref<128x72xf32, #gpu.address_space<global>>):
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "arith.constant"() <{value = 12 : index}> : () -> index
    %6 = "arith.constant"() <{value = 32 : index}> : () -> index
    %7 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xf32, #gpu.address_space<workgroup>>
    "amdgpu.gather_to_lds"(%arg1, %5, %4, %7, %6, %4) <{async, operandSegmentSizes = array<i32: 1, 2, 1, 2>, transferType = f32}> : (memref<128x72xf32, #gpu.address_space<global>>, index, index, memref<64x64xf32, #gpu.address_space<workgroup>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<128x72xf32, #amdgpu.address_space<fat_raw_buffer>>) -> (), sym_name = "global_load_to_rocdl_async_f32_fat_raw_buffer"}> ({
  ^bb0(%arg0: memref<128x72xf32, #amdgpu.address_space<fat_raw_buffer>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 12 : index}> : () -> index
    %2 = "arith.constant"() <{value = 32 : index}> : () -> index
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xf32, #gpu.address_space<workgroup>>
    "amdgpu.gather_to_lds"(%arg0, %1, %0, %3, %2, %0) <{async, operandSegmentSizes = array<i32: 1, 2, 1, 2>, transferType = f32}> : (memref<128x72xf32, #amdgpu.address_space<fat_raw_buffer>>, index, index, memref<64x64xf32, #gpu.address_space<workgroup>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

