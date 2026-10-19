"builtin.module"() ({
  "func.func"() <{function_type = (memref<10xf32, #spirv.storage_class<StorageBuffer>>, memref<10xf32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "loop_kernel"}> ({
  ^bb0(%arg8: memref<10xf32, #spirv.storage_class<StorageBuffer>>, %arg9: memref<10xf32, #spirv.storage_class<StorageBuffer>>):
    %11 = "arith.constant"() <{value = 4 : index}> : () -> index
    %12 = "arith.constant"() <{value = 42 : index}> : () -> index
    %13 = "arith.constant"() <{value = 2 : index}> : () -> index
    "scf.for"(%11, %12, %13) ({
    ^bb0(%arg10: index):
      %14 = "memref.load"(%arg8, %arg10) : (memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> f32
      "memref.store"(%14, %arg9, %arg10) : (f32, memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xf32, #spirv.storage_class<StorageBuffer>>, memref<10xf32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "unsigned_loop"}> ({
  ^bb0(%arg5: memref<10xf32, #spirv.storage_class<StorageBuffer>>, %arg6: memref<10xf32, #spirv.storage_class<StorageBuffer>>):
    %7 = "arith.constant"() <{value = 4 : index}> : () -> index
    %8 = "arith.constant"() <{value = 42 : index}> : () -> index
    %9 = "arith.constant"() <{value = 2 : index}> : () -> index
    "scf.for"(%7, %8, %9) <{unsignedCmp}> ({
    ^bb0(%arg7: index):
      %10 = "memref.load"(%arg5, %arg7) : (memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> f32
      "memref.store"(%10, %arg6, %arg7) : (f32, memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xf32, #spirv.storage_class<StorageBuffer>>, memref<10xf32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "loop_yield"}> ({
  ^bb0(%arg0: memref<10xf32, #spirv.storage_class<StorageBuffer>>, %arg1: memref<10xf32, #spirv.storage_class<StorageBuffer>>):
    %0 = "arith.constant"() <{value = 4 : index}> : () -> index
    %1 = "arith.constant"() <{value = 42 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %5:2 = "scf.for"(%0, %1, %2, %3, %4) ({
    ^bb0(%arg2: index, %arg3: f32, %arg4: f32):
      %6 = "arith.addf"(%arg3, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "scf.yield"(%6, %6) : (f32, f32) -> ()
    }) : (index, index, index, f32, f32) -> (f32, f32)
    "memref.store"(%5#0, %arg1, %0) : (f32, memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
    "memref.store"(%5#1, %arg1, %1) : (f32, memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

