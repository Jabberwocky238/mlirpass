"builtin.module"() ({
  "func.func"() <{function_type = (i32, memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>>, index, index, index) -> i32, sym_name = "atomic_addi_storage_buffer"}> ({
  ^bb0(%arg30: i32, %arg31: memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>>, %arg32: index, %arg33: index, %arg34: index):
    %6 = "memref.atomic_rmw"(%arg30, %arg31, %arg32, %arg33, %arg34) <{kind = 1 : i64}> : (i32, memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>>, index, index, index) -> i32
    "func.return"(%6) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, memref<2x3x4xi32, #spirv.storage_class<Workgroup>>, index, index, index) -> i32, sym_name = "atomic_maxs_workgroup"}> ({
  ^bb0(%arg25: i32, %arg26: memref<2x3x4xi32, #spirv.storage_class<Workgroup>>, %arg27: index, %arg28: index, %arg29: index):
    %5 = "memref.atomic_rmw"(%arg25, %arg26, %arg27, %arg28, %arg29) <{kind = 6 : i64}> : (i32, memref<2x3x4xi32, #spirv.storage_class<Workgroup>>, index, index, index) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>>, index, index, index) -> i32, sym_name = "atomic_maxu_storage_buffer"}> ({
  ^bb0(%arg20: i32, %arg21: memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>>, %arg22: index, %arg23: index, %arg24: index):
    %4 = "memref.atomic_rmw"(%arg20, %arg21, %arg22, %arg23, %arg24) <{kind = 7 : i64}> : (i32, memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>>, index, index, index) -> i32
    "func.return"(%4) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, memref<2x3x4xi32, #spirv.storage_class<Workgroup>>, index, index, index) -> i32, sym_name = "atomic_mins_workgroup"}> ({
  ^bb0(%arg15: i32, %arg16: memref<2x3x4xi32, #spirv.storage_class<Workgroup>>, %arg17: index, %arg18: index, %arg19: index):
    %3 = "memref.atomic_rmw"(%arg15, %arg16, %arg17, %arg18, %arg19) <{kind = 10 : i64}> : (i32, memref<2x3x4xi32, #spirv.storage_class<Workgroup>>, index, index, index) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>>, index, index, index) -> i32, sym_name = "atomic_minu_storage_buffer"}> ({
  ^bb0(%arg10: i32, %arg11: memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>>, %arg12: index, %arg13: index, %arg14: index):
    %2 = "memref.atomic_rmw"(%arg10, %arg11, %arg12, %arg13, %arg14) <{kind = 11 : i64}> : (i32, memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>>, index, index, index) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, memref<2x3x4xi32, #spirv.storage_class<Workgroup>>, index, index, index) -> i32, sym_name = "atomic_ori_workgroup"}> ({
  ^bb0(%arg5: i32, %arg6: memref<2x3x4xi32, #spirv.storage_class<Workgroup>>, %arg7: index, %arg8: index, %arg9: index):
    %1 = "memref.atomic_rmw"(%arg5, %arg6, %arg7, %arg8, %arg9) <{kind = 14 : i64}> : (i32, memref<2x3x4xi32, #spirv.storage_class<Workgroup>>, index, index, index) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>>, index, index, index) -> i32, sym_name = "atomic_andi_storage_buffer"}> ({
  ^bb0(%arg0: i32, %arg1: memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>>, %arg2: index, %arg3: index, %arg4: index):
    %0 = "memref.atomic_rmw"(%arg0, %arg1, %arg2, %arg3, %arg4) <{kind = 2 : i64}> : (i32, memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>>, index, index, index) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader], []>, #spirv.resource_limits<>>} : () -> ()

