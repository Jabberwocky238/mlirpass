"builtin.module"() ({
  "func.func"() <{function_type = (memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> (), sym_name = "switch_no_result"}> ({
  ^bb0(%arg3: memref<10xf32, #spirv.storage_class<StorageBuffer>>, %arg4: index):
    %6 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %7 = "arith.constant"() <{value = 0 : index}> : () -> index
    "scf.index_switch"(%arg4) <{cases = array<i64: 2>}> ({
      "scf.yield"() : () -> ()
    }, {
      "memref.store"(%6, %arg3, %7) : (f32, memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> i32, sym_name = "switch_yield"}> ({
  ^bb0(%arg2: index):
    %2 = "scf.index_switch"(%arg2) <{cases = array<i64: 2, 5>}> ({
      %5 = "arith.constant"() <{value = 30 : i32}> : () -> i32
      "scf.yield"(%5) : (i32) -> ()
    }, {
      %4 = "arith.constant"() <{value = 10 : i32}> : () -> i32
      "scf.yield"(%4) : (i32) -> ()
    }, {
      %3 = "arith.constant"() <{value = 20 : i32}> : () -> i32
      "scf.yield"(%3) : (i32) -> ()
    }) : (index) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> (), sym_name = "switch_selection_control"}> ({
  ^bb0(%arg0: memref<10xf32, #spirv.storage_class<StorageBuffer>>, %arg1: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    "scf.index_switch"(%arg1) <{cases = array<i64: 2>}> ({
      "scf.yield"() : () -> ()
    }, {
      "memref.store"(%0, %arg0, %1) : (f32, memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
      "scf.yield"() : () -> ()
    }) {spirv.selection_control = #spirv.selection_control<Flatten>} : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

