"builtin.module"() ({
  "func.func"() <{function_type = (memref<10xf32, #spirv.storage_class<StorageBuffer>>, memref<10xf32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "loop_kernel"}> ({
  ^bb0(%arg14: memref<10xf32, #spirv.storage_class<StorageBuffer>>, %arg15: memref<10xf32, #spirv.storage_class<StorageBuffer>>):
    %19 = "arith.constant"() <{value = 4 : index}> : () -> index
    %20 = "arith.constant"() <{value = 42 : index}> : () -> index
    %21 = "arith.constant"() <{value = 2 : index}> : () -> index
    "scf.for"(%19, %20, %21) ({
    ^bb0(%arg16: index):
      %22 = "memref.load"(%arg14, %arg16) : (memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> f32
      "memref.store"(%22, %arg15, %arg16) : (f32, memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xf32, #spirv.storage_class<StorageBuffer>>, memref<10xf32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "unsigned_loop"}> ({
  ^bb0(%arg11: memref<10xf32, #spirv.storage_class<StorageBuffer>>, %arg12: memref<10xf32, #spirv.storage_class<StorageBuffer>>):
    %15 = "arith.constant"() <{value = 4 : index}> : () -> index
    %16 = "arith.constant"() <{value = 42 : index}> : () -> index
    %17 = "arith.constant"() <{value = 2 : index}> : () -> index
    "scf.for"(%15, %16, %17) <{unsignedCmp}> ({
    ^bb0(%arg13: index):
      %18 = "memref.load"(%arg11, %arg13) : (memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> f32
      "memref.store"(%18, %arg12, %arg13) : (f32, memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xf32, #spirv.storage_class<StorageBuffer>>, memref<10xf32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "loop_yield"}> ({
  ^bb0(%arg6: memref<10xf32, #spirv.storage_class<StorageBuffer>>, %arg7: memref<10xf32, #spirv.storage_class<StorageBuffer>>):
    %8 = "arith.constant"() <{value = 4 : index}> : () -> index
    %9 = "arith.constant"() <{value = 42 : index}> : () -> index
    %10 = "arith.constant"() <{value = 2 : index}> : () -> index
    %11 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %12 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %13:2 = "scf.for"(%8, %9, %10, %11, %12) ({
    ^bb0(%arg8: index, %arg9: f32, %arg10: f32):
      %14 = "arith.addf"(%arg9, %arg9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "scf.yield"(%14, %14) : (f32, f32) -> ()
    }) : (index, index, index, f32, f32) -> (f32, f32)
    "memref.store"(%13#0, %arg7, %8) : (f32, memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
    "memref.store"(%13#1, %arg7, %9) : (f32, memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xf32, #spirv.storage_class<StorageBuffer>>, memref<10xf32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "loop_unroll"}> ({
  ^bb0(%arg3: memref<10xf32, #spirv.storage_class<StorageBuffer>>, %arg4: memref<10xf32, #spirv.storage_class<StorageBuffer>>):
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "arith.constant"() <{value = 10 : index}> : () -> index
    %6 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%4, %5, %6) ({
    ^bb0(%arg5: index):
      %7 = "memref.load"(%arg3, %arg5) : (memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> f32
      "memref.store"(%7, %arg4, %arg5) : (f32, memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
      "scf.yield"() : () -> ()
    }) {spirv.loop_control = #spirv.loop_control<Unroll>} : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xf32, #spirv.storage_class<StorageBuffer>>, memref<10xf32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "loop_dont_unroll"}> ({
  ^bb0(%arg0: memref<10xf32, #spirv.storage_class<StorageBuffer>>, %arg1: memref<10xf32, #spirv.storage_class<StorageBuffer>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 10 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%0, %1, %2) ({
    ^bb0(%arg2: index):
      %3 = "memref.load"(%arg0, %arg2) : (memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> f32
      "memref.store"(%3, %arg1, %arg2) : (f32, memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
      "scf.yield"() : () -> ()
    }) {spirv.loop_control = #spirv.loop_control<DontUnroll>} : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

