"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x72xf32, #amdgpu.address_space<fat_raw_buffer>>) -> (), sym_name = "fat_buffer_load_to_rocdl_f96"}> ({
  ^bb0(%arg0: memref<128x72xf32, #amdgpu.address_space<fat_raw_buffer>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 12 : index}> : () -> index
    %2 = "arith.constant"() <{value = 32 : index}> : () -> index
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xf32, #gpu.address_space<workgroup>>
    "amdgpu.gather_to_lds"(%arg0, %1, %0, %3, %2, %0) <{operandSegmentSizes = array<i32: 1, 2, 1, 2>, transferType = vector<16xf6E3M2FN>}> : (memref<128x72xf32, #amdgpu.address_space<fat_raw_buffer>>, index, index, memref<64x64xf32, #gpu.address_space<workgroup>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x72xf32, #amdgpu.address_space<fat_raw_buffer>>) -> (), sym_name = "fat_buffer_load_to_rocdl_f128"}> ({
  ^bb0(%arg0: memref<128x72xf32, #amdgpu.address_space<fat_raw_buffer>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 12 : index}> : () -> index
    %2 = "arith.constant"() <{value = 32 : index}> : () -> index
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xf32, #gpu.address_space<workgroup>>
    "amdgpu.gather_to_lds"(%arg0, %1, %0, %3, %2, %0) <{operandSegmentSizes = array<i32: 1, 2, 1, 2>, transferType = f128}> : (memref<128x72xf32, #amdgpu.address_space<fat_raw_buffer>>, index, index, memref<64x64xf32, #gpu.address_space<workgroup>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

