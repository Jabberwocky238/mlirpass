"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x72xf32, 1>) -> (), sym_name = "global_load_to_rocdl_f32"}> ({
  ^bb0(%arg8: memref<128x72xf32, 1>):
    %19 = "arith.constant"() <{value = 0 : index}> : () -> index
    %20 = "arith.constant"() <{value = 12 : index}> : () -> index
    %21 = "arith.constant"() <{value = 32 : index}> : () -> index
    %22 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xf32, 3>
    "amdgpu.gather_to_lds"(%arg8, %20, %19, %22, %21, %19) <{operandSegmentSizes = array<i32: 1, 2, 1, 2>, transferType = f32}> : (memref<128x72xf32, 1>, index, index, memref<64x64xf32, 3>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<128x72xf32>) -> (), sym_name = "global_load_to_rocdl_wg_mem"}> ({
  ^bb0(%arg7: memref<128x72xf32>):
    %15 = "arith.constant"() <{value = 0 : index}> : () -> index
    %16 = "arith.constant"() <{value = 12 : index}> : () -> index
    %17 = "arith.constant"() <{value = 32 : index}> : () -> index
    %18 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xf32, #gpu.address_space<workgroup>>
    "amdgpu.gather_to_lds"(%arg7, %16, %15, %18, %17, %15) <{operandSegmentSizes = array<i32: 1, 2, 1, 2>, transferType = f32}> : (memref<128x72xf32>, index, index, memref<64x64xf32, #gpu.address_space<workgroup>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32>) -> (), sym_name = "global_load_to_rocdl_0d"}> ({
  ^bb0(%arg6: memref<f32>):
    %14 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32, #gpu.address_space<workgroup>>
    "amdgpu.gather_to_lds"(%arg6, %14) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, transferType = f32}> : (memref<f32>, memref<f32, #gpu.address_space<workgroup>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<128x72xi8, 1>) -> (), sym_name = "global_load_to_rocdl_i8"}> ({
  ^bb0(%arg5: memref<128x72xi8, 1>):
    %10 = "arith.constant"() <{value = 0 : index}> : () -> index
    %11 = "arith.constant"() <{value = 12 : index}> : () -> index
    %12 = "arith.constant"() <{value = 32 : index}> : () -> index
    %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xi8, 3>
    "amdgpu.gather_to_lds"(%arg5, %11, %10, %13, %12, %10) <{operandSegmentSizes = array<i32: 1, 2, 1, 2>, transferType = i8}> : (memref<128x72xi8, 1>, index, index, memref<64x64xi8, 3>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<128x72xi16, 1>) -> (), sym_name = "global_load_to_rocdl_vec"}> ({
  ^bb0(%arg4: memref<128x72xi16, 1>):
    %6 = "arith.constant"() <{value = 0 : index}> : () -> index
    %7 = "arith.constant"() <{value = 12 : index}> : () -> index
    %8 = "arith.constant"() <{value = 32 : index}> : () -> index
    %9 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x128xi16, 3>
    "amdgpu.gather_to_lds"(%arg4, %7, %6, %9, %8, %6) <{operandSegmentSizes = array<i32: 1, 2, 1, 2>, transferType = vector<2xi16>}> : (memref<128x72xi16, 1>, index, index, memref<64x128xi16, 3>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<512xi32, 1>, index, index) -> (), sym_name = "global_load_to_rocdl_dynamic_indices"}> ({
  ^bb0(%arg1: memref<512xi32, 1>, %arg2: index, %arg3: index):
    %4 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x64xi32, 3>
    %5 = "arith.constant"() <{value = 0 : index}> : () -> index
    "amdgpu.gather_to_lds"(%arg1, %arg2, %4, %arg3, %5) <{operandSegmentSizes = array<i32: 1, 1, 1, 2>, transferType = i32}> : (memref<512xi32, 1>, index, memref<4x64xi32, 3>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<128x72xf32, 7>) -> (), sym_name = "fat_buffer_load_to_rocdl_f32"}> ({
  ^bb0(%arg0: memref<128x72xf32, 7>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 12 : index}> : () -> index
    %2 = "arith.constant"() <{value = 32 : index}> : () -> index
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xf32, 3>
    "amdgpu.gather_to_lds"(%arg0, %1, %0, %3, %2, %0) <{operandSegmentSizes = array<i32: 1, 2, 1, 2>, transferType = f32}> : (memref<128x72xf32, 7>, index, index, memref<64x64xf32, 3>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

