"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>) -> (), sym_name = "testenterdataop"}> ({
  ^bb0(%arg0: memref<f32>):
    %0 = "acc.create"(%arg0) <{dataClause = #acc<data_clause acc_create>, implicit = false, modifiers = #acc<data_clause_modifier none>, operandSegmentSizes = array<i32: 1, 0, 0, 0>, structured = true, varType = f32}> : (memref<f32>) -> memref<f32>
    "acc.enter_data"(%0) <{operandSegmentSizes = array<i32: 0, 0, 0, 0, 1>}> : (memref<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>) -> (), sym_name = "testenterdataop"}> ({
  ^bb0(%arg0: memref<f32>):
    %0 = "acc.create"(%arg0) <{dataClause = #acc<data_clause acc_create>, implicit = false, modifiers = #acc<data_clause_modifier none>, operandSegmentSizes = array<i32: 1, 0, 0, 0>, structured = true, varType = f32}> : (memref<f32>) -> memref<f32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>) -> (), sym_name = "testexitdataop"}> ({
  ^bb0(%arg0: memref<f32>):
    %0 = "acc.getdeviceptr"(%arg0) <{dataClause = #acc<data_clause acc_getdeviceptr>, implicit = false, modifiers = #acc<data_clause_modifier none>, operandSegmentSizes = array<i32: 1, 0, 0, 0>, structured = true, varType = f32}> : (memref<f32>) -> memref<f32>
    "acc.exit_data"(%0) <{operandSegmentSizes = array<i32: 0, 0, 0, 0, 1>}> : (memref<f32>) -> ()
    "acc.delete"(%0) <{dataClause = #acc<data_clause acc_delete>, implicit = false, modifiers = #acc<data_clause_modifier none>, operandSegmentSizes = array<i32: 1, 0, 0>, structured = true}> : (memref<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>) -> (), sym_name = "testexitdataop"}> ({
  ^bb0(%arg0: memref<f32>):
    %0 = "acc.getdeviceptr"(%arg0) <{dataClause = #acc<data_clause acc_getdeviceptr>, implicit = false, modifiers = #acc<data_clause_modifier none>, operandSegmentSizes = array<i32: 1, 0, 0, 0>, structured = true, varType = f32}> : (memref<f32>) -> memref<f32>
    "acc.delete"(%0) <{dataClause = #acc<data_clause acc_delete>, implicit = false, modifiers = #acc<data_clause_modifier none>, operandSegmentSizes = array<i32: 1, 0, 0>, structured = true}> : (memref<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>) -> (), sym_name = "testupdateop"}> ({
  ^bb0(%arg0: memref<f32>):
    %0 = "acc.getdeviceptr"(%arg0) <{dataClause = #acc<data_clause acc_getdeviceptr>, implicit = false, modifiers = #acc<data_clause_modifier none>, operandSegmentSizes = array<i32: 1, 0, 0, 0>, structured = true, varType = f32}> : (memref<f32>) -> memref<f32>
    "acc.update_host"(%0, %arg0) <{dataClause = #acc<data_clause acc_update_host>, implicit = false, modifiers = #acc<data_clause_modifier none>, operandSegmentSizes = array<i32: 1, 1, 0, 0>, structured = true, varType = f32}> : (memref<f32>, memref<f32>) -> ()
    "acc.update"(%0) <{operandSegmentSizes = array<i32: 0, 0, 0, 1>}> : (memref<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>) -> (), sym_name = "testupdateop"}> ({
  ^bb0(%arg0: memref<f32>):
    %0 = "acc.getdeviceptr"(%arg0) <{dataClause = #acc<data_clause acc_getdeviceptr>, implicit = false, modifiers = #acc<data_clause_modifier none>, operandSegmentSizes = array<i32: 1, 0, 0, 0>, structured = true, varType = f32}> : (memref<f32>) -> memref<f32>
    "acc.update_host"(%0, %arg0) <{dataClause = #acc<data_clause acc_update_host>, implicit = false, modifiers = #acc<data_clause_modifier none>, operandSegmentSizes = array<i32: 1, 1, 0, 0>, structured = true, varType = f32}> : (memref<f32>, memref<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>, i1) -> (), sym_name = "testenterdataop"}> ({
  ^bb0(%arg0: memref<f32>, %arg1: i1):
    %0 = "acc.create"(%arg0) <{dataClause = #acc<data_clause acc_create>, implicit = false, modifiers = #acc<data_clause_modifier none>, operandSegmentSizes = array<i32: 1, 0, 0, 0>, structured = true, varType = f32}> : (memref<f32>) -> memref<f32>
    "acc.enter_data"(%arg1, %0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0, 1>}> : (i1, memref<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>, i1) -> (), sym_name = "testexitdataop"}> ({
  ^bb0(%arg0: memref<f32>, %arg1: i1):
    %0 = "acc.getdeviceptr"(%arg0) <{dataClause = #acc<data_clause acc_getdeviceptr>, implicit = false, modifiers = #acc<data_clause_modifier none>, operandSegmentSizes = array<i32: 1, 0, 0, 0>, structured = true, varType = f32}> : (memref<f32>) -> memref<f32>
    "acc.exit_data"(%arg1, %0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0, 1>}> : (i1, memref<f32>) -> ()
    "acc.delete"(%0) <{dataClause = #acc<data_clause acc_delete>, implicit = false, modifiers = #acc<data_clause_modifier none>, operandSegmentSizes = array<i32: 1, 0, 0>, structured = true}> : (memref<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>, i1) -> (), sym_name = "testupdateop"}> ({
  ^bb0(%arg0: memref<f32>, %arg1: i1):
    %0 = "acc.getdeviceptr"(%arg0) <{dataClause = #acc<data_clause acc_getdeviceptr>, implicit = false, modifiers = #acc<data_clause_modifier none>, operandSegmentSizes = array<i32: 1, 0, 0, 0>, structured = true, varType = f32}> : (memref<f32>) -> memref<f32>
    "acc.update_host"(%0, %arg0) <{dataClause = #acc<data_clause acc_update_host>, implicit = false, modifiers = #acc<data_clause_modifier none>, operandSegmentSizes = array<i32: 1, 1, 0, 0>, structured = true, varType = f32}> : (memref<f32>, memref<f32>) -> ()
    "acc.update"(%arg1, %0) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>}> : (i1, memref<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>, i1) -> (), sym_name = "testhostdataop"}> ({
  ^bb0(%arg0: memref<f32>, %arg1: i1):
    %0 = "arith.constant"() <{value = 10 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "acc.loop"(%1, %0, %1) <{inclusiveUpperbound = array<i1: true>, independent = [#acc.device_type<none>], operandSegmentSizes = array<i32: 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0>}> ({
    ^bb0(%arg3: i32):
      "acc.yield"() : () -> ()
    }) : (i32, i32, i32) -> ()
    "acc.loop"(%1, %0, %1) <{inclusiveUpperbound = array<i1: true>, independent = [#acc.device_type<none>], operandSegmentSizes = array<i32: 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0>}> ({
    ^bb0(%arg2: i32):
      "acc.yield"() : () -> ()
    }) : (i32, i32, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>, i1) -> (), sym_name = "testhostdataop"}> ({
  ^bb0(%arg0: memref<f32>, %arg1: i1):
    %0 = "acc.use_device"(%arg0) <{dataClause = #acc<data_clause acc_use_device>, implicit = false, modifiers = #acc<data_clause_modifier none>, operandSegmentSizes = array<i32: 1, 0, 0, 0>, structured = true, varType = f32}> : (memref<f32>) -> memref<f32>
    "acc.host_data"(%0) <{operandSegmentSizes = array<i32: 0, 1>}> ({
    }) : (memref<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<i32>) -> (), sym_name = "update_no_op"}> ({
  ^bb0(%arg0: memref<i32>):
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<i32>, i32) -> (), sym_name = "update_write_op"}> ({
  ^bb0(%arg0: memref<i32>, %arg1: i32):
    "acc.atomic.write"(%arg0, %arg1) : (memref<i32>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<i32>, i32) -> (), sym_name = "update_normal"}> ({
  ^bb0(%arg0: memref<i32>, %arg1: i32):
    "acc.atomic.update"(%arg0) ({
    ^bb0(%arg2: i32):
      %0 = "arith.addi"(%arg2, %arg1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "acc.yield"(%0) : (i32) -> ()
    }) : (memref<i32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<i32>) -> (), sym_name = "update_unnecessary_computations"}> ({
  ^bb0(%arg0: memref<i32>):
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<i32>) -> (), sym_name = "update_unnecessary_computations"}> ({
  ^bb0(%arg0: memref<i32>):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "acc.atomic.write"(%arg0, %0) : (memref<i32>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, i32) -> (), sym_name = "kernel_environment_canonicalization"}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):
    "acc.wait"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 2, 0, 0, 0>}> : (i32, i32) -> ()
    "acc.wait"() <{operandSegmentSizes = array<i32: 0, 0, 0, 0>}> : () -> ()
    "acc.kernel_environment"(%arg2) <{hasWaitDevnum = [false], operandSegmentSizes = array<i32: 0, 0, 1>, waitOnly = [], waitOperandsDeviceType = [#acc.device_type<nvidia>], waitOperandsSegments = array<i32: 1>}> ({
    ^bb0:
    }) : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

