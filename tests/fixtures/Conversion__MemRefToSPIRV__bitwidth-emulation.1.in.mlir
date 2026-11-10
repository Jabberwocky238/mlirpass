"builtin.module"() ({
  "func.func"() <{function_type = (memref<i1, #spirv.storage_class<StorageBuffer>>) -> i1, sym_name = "load_i1"}> ({
  ^bb0(%arg18: memref<i1, #spirv.storage_class<StorageBuffer>>):
    %4 = "memref.load"(%arg18) : (memref<i1, #spirv.storage_class<StorageBuffer>>) -> i1
    "func.return"(%4) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i8, #spirv.storage_class<StorageBuffer>>) -> i8, sym_name = "load_i8"}> ({
  ^bb0(%arg17: memref<i8, #spirv.storage_class<StorageBuffer>>):
    %3 = "memref.load"(%arg17) : (memref<i8, #spirv.storage_class<StorageBuffer>>) -> i8
    "func.return"(%3) : (i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xi16, #spirv.storage_class<StorageBuffer>>, index) -> i16, sym_name = "load_i16"}> ({
  ^bb0(%arg15: memref<10xi16, #spirv.storage_class<StorageBuffer>>, %arg16: index):
    %2 = "memref.load"(%arg15, %arg16) : (memref<10xi16, #spirv.storage_class<StorageBuffer>>, index) -> i16
    "func.return"(%2) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xi64, #spirv.storage_class<StorageBuffer>>, index) -> i64, sym_name = "load_i64"}> ({
  ^bb0(%arg13: memref<10xi64, #spirv.storage_class<StorageBuffer>>, %arg14: index):
    %1 = "memref.load"(%arg13, %arg14) : (memref<10xi64, #spirv.storage_class<StorageBuffer>>, index) -> i64
    "func.return"(%1) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_f32"}> ({
  ^bb0(%arg12: memref<f32, #spirv.storage_class<StorageBuffer>>):
    %0 = "memref.load"(%arg12) : (memref<f32, #spirv.storage_class<StorageBuffer>>) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i1, #spirv.storage_class<StorageBuffer>>, i1) -> (), sym_name = "store_i1"}> ({
  ^bb0(%arg10: memref<i1, #spirv.storage_class<StorageBuffer>>, %arg11: i1):
    "memref.store"(%arg11, %arg10) : (i1, memref<i1, #spirv.storage_class<StorageBuffer>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i8, #spirv.storage_class<StorageBuffer>>, i8) -> (), sym_name = "store_i8"}> ({
  ^bb0(%arg8: memref<i8, #spirv.storage_class<StorageBuffer>>, %arg9: i8):
    "memref.store"(%arg9, %arg8) : (i8, memref<i8, #spirv.storage_class<StorageBuffer>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xi16, #spirv.storage_class<StorageBuffer>>, index, i16) -> (), sym_name = "store_i16"}> ({
  ^bb0(%arg5: memref<10xi16, #spirv.storage_class<StorageBuffer>>, %arg6: index, %arg7: i16):
    "memref.store"(%arg7, %arg5, %arg6) : (i16, memref<10xi16, #spirv.storage_class<StorageBuffer>>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xi64, #spirv.storage_class<StorageBuffer>>, index, i64) -> (), sym_name = "store_i64"}> ({
  ^bb0(%arg2: memref<10xi64, #spirv.storage_class<StorageBuffer>>, %arg3: index, %arg4: i64):
    "memref.store"(%arg4, %arg2, %arg3) : (i64, memref<10xi64, #spirv.storage_class<StorageBuffer>>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32, #spirv.storage_class<StorageBuffer>>, f32) -> (), sym_name = "store_f32"}> ({
  ^bb0(%arg0: memref<f32, #spirv.storage_class<StorageBuffer>>, %arg1: f32):
    "memref.store"(%arg1, %arg0) : (f32, memref<f32, #spirv.storage_class<StorageBuffer>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi4, #spirv.storage_class<StorageBuffer>>, index) -> i4, sym_name = "load_i4"}> ({
  ^bb0(%arg3: memref<?xi4, #spirv.storage_class<StorageBuffer>>, %arg4: index):
    %0 = "memref.load"(%arg3, %arg4) : (memref<?xi4, #spirv.storage_class<StorageBuffer>>, index) -> i4
    "func.return"(%0) : (i4) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi4, #spirv.storage_class<StorageBuffer>>, i4, index) -> (), sym_name = "store_i4"}> ({
  ^bb0(%arg0: memref<?xi4, #spirv.storage_class<StorageBuffer>>, %arg1: i4, %arg2: index):
    "memref.store"(%arg1, %arg0, %arg2) : (i4, memref<?xi4, #spirv.storage_class<StorageBuffer>>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<i8, #spirv.storage_class<StorageBuffer>>) -> i8, sym_name = "load_i8"}> ({
  ^bb0(%arg2: memref<i8, #spirv.storage_class<StorageBuffer>>):
    %0 = "memref.load"(%arg2) : (memref<i8, #spirv.storage_class<StorageBuffer>>) -> i8
    "func.return"(%0) : (i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i8, #spirv.storage_class<StorageBuffer>>, i8) -> (), sym_name = "store_i8"}> ({
  ^bb0(%arg0: memref<i8, #spirv.storage_class<StorageBuffer>>, %arg1: i8):
    "memref.store"(%arg1, %arg0) : (i8, memref<i8, #spirv.storage_class<StorageBuffer>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64, Int8], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

