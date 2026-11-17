"spirv.module"() <{addressing_model = #spirv.addressing_model<Physical64>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.3, [Addresses, Shader, Linkage, SubgroupBufferBlockIOINTEL], [SPV_KHR_storage_buffer_storage_class, SPV_INTEL_subgroups]>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<i32, StorageBuffer>) -> i32, sym_name = "subgroup_block_read_intel"}> ({
  ^bb0(%arg5: !spirv.ptr<i32, StorageBuffer>):
    %1 = "spirv.INTEL.SubgroupBlockRead"(%arg5) : (!spirv.ptr<i32, StorageBuffer>) -> i32
    "spirv.ReturnValue"(%1) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<i32, StorageBuffer>) -> vector<3xi32>, sym_name = "subgroup_block_read_intel_vector"}> ({
  ^bb0(%arg4: !spirv.ptr<i32, StorageBuffer>):
    %0 = "spirv.INTEL.SubgroupBlockRead"(%arg4) : (!spirv.ptr<i32, StorageBuffer>) -> vector<3xi32>
    "spirv.ReturnValue"(%0) : (vector<3xi32>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<i32, StorageBuffer>, i32) -> (), sym_name = "subgroup_block_write_intel"}> ({
  ^bb0(%arg2: !spirv.ptr<i32, StorageBuffer>, %arg3: i32):
    "spirv.INTEL.SubgroupBlockWrite"(%arg2, %arg3) : (!spirv.ptr<i32, StorageBuffer>, i32) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<i32, StorageBuffer>, vector<3xi32>) -> (), sym_name = "subgroup_block_write_intel_vector"}> ({
  ^bb0(%arg0: !spirv.ptr<i32, StorageBuffer>, %arg1: vector<3xi32>):
    "spirv.INTEL.SubgroupBlockWrite"(%arg0, %arg1) : (!spirv.ptr<i32, StorageBuffer>, vector<3xi32>) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

