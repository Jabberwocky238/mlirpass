"builtin.module"() ({
  "func.func"() <{function_type = (memref<10xf32, #spirv.storage_class<StorageBuffer>>, i1) -> (), sym_name = "kernel_simple_selection"}> ({
  ^bb0(%arg12: memref<10xf32, #spirv.storage_class<StorageBuffer>>, %arg13: i1):
    %17 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %18 = "arith.constant"() <{value = 0 : index}> : () -> index
    "scf.if"(%arg13) ({
      "memref.store"(%17, %arg12, %18) : (f32, memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xf32, #spirv.storage_class<StorageBuffer>>, memref<10xf32, #spirv.storage_class<StorageBuffer>>, i1, i1) -> (), sym_name = "kernel_nested_selection"}> ({
  ^bb0(%arg8: memref<10xf32, #spirv.storage_class<StorageBuffer>>, %arg9: memref<10xf32, #spirv.storage_class<StorageBuffer>>, %arg10: i1, %arg11: i1):
    %11 = "arith.constant"() <{value = 0 : index}> : () -> index
    %12 = "arith.constant"() <{value = 9 : index}> : () -> index
    "scf.if"(%arg10) ({
      "scf.if"(%arg11) ({
        %16 = "memref.load"(%arg8, %11) : (memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> f32
        "memref.store"(%16, %arg9, %11) : (f32, memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        %15 = "memref.load"(%arg9, %11) : (memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> f32
        "memref.store"(%15, %arg8, %11) : (f32, memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }, {
      "scf.if"(%arg11) ({
        %14 = "memref.load"(%arg8, %12) : (memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> f32
        "memref.store"(%14, %arg9, %12) : (f32, memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        %13 = "memref.load"(%arg9, %12) : (memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> f32
        "memref.store"(%13, %arg8, %12) : (f32, memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xf32, #spirv.storage_class<StorageBuffer>>, i1) -> (), sym_name = "simple_if_yield"}> ({
  ^bb0(%arg6: memref<10xf32, #spirv.storage_class<StorageBuffer>>, %arg7: i1):
    %4:2 = "scf.if"(%arg7) ({
      %9 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %10 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      "scf.yield"(%9, %10) : (f32, f32) -> ()
    }, {
      %7 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
      %8 = "arith.constant"() <{value = 3.000000e+00 : f32}> : () -> f32
      "scf.yield"(%8, %7) : (f32, f32) -> ()
    }) : (i1) -> (f32, f32)
    %5 = "arith.constant"() <{value = 0 : index}> : () -> index
    %6 = "arith.constant"() <{value = 1 : index}> : () -> index
    "memref.store"(%4#0, %arg6, %5) : (f32, memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
    "memref.store"(%4#1, %arg6, %6) : (f32, memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xf32, #spirv.storage_class<StorageBuffer>>, memref<10xf32, #spirv.storage_class<StorageBuffer>>, i1) -> (), sym_name = "simple_if_yield_type_change"}> ({
  ^bb0(%arg3: memref<10xf32, #spirv.storage_class<StorageBuffer>>, %arg4: memref<10xf32, #spirv.storage_class<StorageBuffer>>, %arg5: i1):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "scf.if"(%arg5) ({
      "scf.yield"(%arg3) : (memref<10xf32, #spirv.storage_class<StorageBuffer>>) -> ()
    }, {
      "scf.yield"(%arg4) : (memref<10xf32, #spirv.storage_class<StorageBuffer>>) -> ()
    }) : (i1) -> memref<10xf32, #spirv.storage_class<StorageBuffer>>
    "memref.store"(%2, %3, %1) : (f32, memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<8xi32>, memref<8xi32>, i1) -> (), sym_name = "unsupported_yield_type"}> ({
  ^bb0(%arg0: memref<8xi32>, %arg1: memref<8xi32>, %arg2: i1):
    %0 = "scf.if"(%arg2) ({
      "scf.yield"(%arg0) : (memref<8xi32>) -> ()
    }, {
      "scf.yield"(%arg1) : (memref<8xi32>) -> ()
    }) : (i1) -> memref<8xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

