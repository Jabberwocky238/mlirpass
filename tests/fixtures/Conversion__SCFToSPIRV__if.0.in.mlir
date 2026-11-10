"builtin.module"() ({
  "func.func"() <{function_type = (memref<10xf32, #spirv.storage_class<StorageBuffer>>, i1) -> (), sym_name = "kernel_simple_selection"}> ({
  ^bb0(%arg16: memref<10xf32, #spirv.storage_class<StorageBuffer>>, %arg17: i1):
    %21 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %22 = "arith.constant"() <{value = 0 : index}> : () -> index
    "scf.if"(%arg17) ({
      "memref.store"(%21, %arg16, %22) : (f32, memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xf32, #spirv.storage_class<StorageBuffer>>, memref<10xf32, #spirv.storage_class<StorageBuffer>>, i1, i1) -> (), sym_name = "kernel_nested_selection"}> ({
  ^bb0(%arg12: memref<10xf32, #spirv.storage_class<StorageBuffer>>, %arg13: memref<10xf32, #spirv.storage_class<StorageBuffer>>, %arg14: i1, %arg15: i1):
    %15 = "arith.constant"() <{value = 0 : index}> : () -> index
    %16 = "arith.constant"() <{value = 9 : index}> : () -> index
    "scf.if"(%arg14) ({
      "scf.if"(%arg15) ({
        %20 = "memref.load"(%arg12, %15) : (memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> f32
        "memref.store"(%20, %arg13, %15) : (f32, memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        %19 = "memref.load"(%arg13, %15) : (memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> f32
        "memref.store"(%19, %arg12, %15) : (f32, memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }, {
      "scf.if"(%arg15) ({
        %18 = "memref.load"(%arg12, %16) : (memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> f32
        "memref.store"(%18, %arg13, %16) : (f32, memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        %17 = "memref.load"(%arg13, %16) : (memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> f32
        "memref.store"(%17, %arg12, %16) : (f32, memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xf32, #spirv.storage_class<StorageBuffer>>, i1) -> (), sym_name = "simple_if_yield"}> ({
  ^bb0(%arg10: memref<10xf32, #spirv.storage_class<StorageBuffer>>, %arg11: i1):
    %8:2 = "scf.if"(%arg11) ({
      %13 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %14 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      "scf.yield"(%13, %14) : (f32, f32) -> ()
    }, {
      %11 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
      %12 = "arith.constant"() <{value = 3.000000e+00 : f32}> : () -> f32
      "scf.yield"(%12, %11) : (f32, f32) -> ()
    }) : (i1) -> (f32, f32)
    %9 = "arith.constant"() <{value = 0 : index}> : () -> index
    %10 = "arith.constant"() <{value = 1 : index}> : () -> index
    "memref.store"(%8#0, %arg10, %9) : (f32, memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
    "memref.store"(%8#1, %arg10, %10) : (f32, memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xf32, #spirv.storage_class<StorageBuffer>>, memref<10xf32, #spirv.storage_class<StorageBuffer>>, i1) -> (), sym_name = "simple_if_yield_type_change"}> ({
  ^bb0(%arg7: memref<10xf32, #spirv.storage_class<StorageBuffer>>, %arg8: memref<10xf32, #spirv.storage_class<StorageBuffer>>, %arg9: i1):
    %5 = "arith.constant"() <{value = 0 : index}> : () -> index
    %6 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %7 = "scf.if"(%arg9) ({
      "scf.yield"(%arg7) : (memref<10xf32, #spirv.storage_class<StorageBuffer>>) -> ()
    }, {
      "scf.yield"(%arg8) : (memref<10xf32, #spirv.storage_class<StorageBuffer>>) -> ()
    }) : (i1) -> memref<10xf32, #spirv.storage_class<StorageBuffer>>
    "memref.store"(%6, %7, %5) : (f32, memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<8xi32>, memref<8xi32>, i1) -> (), sym_name = "unsupported_yield_type"}> ({
  ^bb0(%arg4: memref<8xi32>, %arg5: memref<8xi32>, %arg6: i1):
    %4 = "scf.if"(%arg6) ({
      "scf.yield"(%arg4) : (memref<8xi32>) -> ()
    }, {
      "scf.yield"(%arg5) : (memref<8xi32>) -> ()
    }) : (i1) -> memref<8xi32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xf32, #spirv.storage_class<StorageBuffer>>, i1) -> (), sym_name = "selection_flatten"}> ({
  ^bb0(%arg2: memref<10xf32, #spirv.storage_class<StorageBuffer>>, %arg3: i1):
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    "scf.if"(%arg3) ({
      "memref.store"(%2, %arg2, %3) : (f32, memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) {spirv.selection_control = #spirv.selection_control<Flatten>} : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<10xf32, #spirv.storage_class<StorageBuffer>>, i1) -> (), sym_name = "selection_dont_flatten"}> ({
  ^bb0(%arg0: memref<10xf32, #spirv.storage_class<StorageBuffer>>, %arg1: i1):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    "scf.if"(%arg1) ({
      "memref.store"(%0, %arg0, %1) : (f32, memref<10xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) {spirv.selection_control = #spirv.selection_control<DontFlatten>} : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

