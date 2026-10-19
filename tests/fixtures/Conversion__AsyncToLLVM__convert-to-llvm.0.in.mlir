"builtin.module"() ({
  "func.func"() <{function_type = (!async.token) -> (), sym_name = "reference_counting"}> ({
  ^bb0(%arg0: !async.token):
    "async.runtime.add_ref"(%arg0) <{count = 2 : i64}> : (!async.token) -> ()
    "async.runtime.drop_ref"(%arg0) <{count = 1 : i64}> : (!async.token) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, memref<1xf32>) -> (), sym_name = "execute_no_async_args"}> ({
  ^bb0(%arg0: f32, %arg1: memref<1xf32>):
    %0 = "async.execute"() <{operandSegmentSizes = array<i32: 0, 0>}> ({
      %1 = "arith.constant"() <{value = 0 : index}> : () -> index
      "memref.store"(%arg0, %arg1, %1) : (f32, memref<1xf32>, index) -> ()
      "async.yield"() : () -> ()
    }) : () -> !async.token
    "async.await"(%0) : (!async.token) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, memref<1xf32>) -> (), sym_name = "nested_async_execute"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: memref<1xf32>):
    %0 = "async.execute"() <{operandSegmentSizes = array<i32: 0, 0>}> ({
      %1 = "arith.constant"() <{value = 0 : index}> : () -> index
      %2 = "async.execute"() <{operandSegmentSizes = array<i32: 0, 0>}> ({
        %3 = "arith.constant"() <{value = 1 : index}> : () -> index
        "memref.store"(%arg0, %arg2, %1) : (f32, memref<1xf32>, index) -> ()
        "async.yield"() : () -> ()
      }) : () -> !async.token
      "async.await"(%2) : (!async.token) -> ()
      "memref.store"(%arg1, %arg2, %1) : (f32, memref<1xf32>, index) -> ()
      "async.yield"() : () -> ()
    }) : () -> !async.token
    "async.await"(%0) : (!async.token) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, memref<1xf32>) -> (), sym_name = "async_execute_token_dependency"}> ({
  ^bb0(%arg0: f32, %arg1: memref<1xf32>):
    %0 = "async.execute"() <{operandSegmentSizes = array<i32: 0, 0>}> ({
      %3 = "arith.constant"() <{value = 0 : index}> : () -> index
      "memref.store"(%arg0, %arg1, %3) : (f32, memref<1xf32>, index) -> ()
      "async.yield"() : () -> ()
    }) : () -> !async.token
    %1 = "async.execute"(%0) <{operandSegmentSizes = array<i32: 1, 0>}> ({
      %2 = "arith.constant"() <{value = 0 : index}> : () -> index
      "memref.store"(%arg0, %arg1, %2) : (f32, memref<1xf32>, index) -> ()
      "async.yield"() : () -> ()
    }) : (!async.token) -> !async.token
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, memref<1xf32>) -> (), sym_name = "async_group_await_all"}> ({
  ^bb0(%arg0: f32, %arg1: memref<1xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "async.create_group"(%0) : (index) -> !async.group
    %2 = "async.execute"() <{operandSegmentSizes = array<i32: 0, 0>}> ({
      "async.yield"() : () -> ()
    }) : () -> !async.token
    %3 = "async.add_to_group"(%2, %1) : (!async.token, !async.group) -> index
    %4 = "async.execute"() <{operandSegmentSizes = array<i32: 0, 0>}> ({
      "async.await_all"(%1) : (!async.group) -> ()
      "async.yield"() : () -> ()
    }) : () -> !async.token
    "async.await_all"(%1) : (!async.group) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "execute_and_return_f32"}> ({
    %0:2 = "async.execute"() <{operandSegmentSizes = array<i32: 0, 0>}> ({
      %2 = "arith.constant"() <{value = 1.230000e+02 : f32}> : () -> f32
      "async.yield"(%2) : (f32) -> ()
    }) : () -> (!async.token, !async.value<f32>)
    %1 = "async.await"(%0#1) : (!async.value<f32>) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "async_value_operands"}> ({
    %0:2 = "async.execute"() <{operandSegmentSizes = array<i32: 0, 0>}> ({
      %3 = "arith.constant"() <{value = 1.230000e+02 : f32}> : () -> f32
      "async.yield"(%3) : (f32) -> ()
    }) : () -> (!async.token, !async.value<f32>)
    %1 = "async.execute"(%0#1) <{operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg0: f32):
      %2 = "arith.addf"(%arg0, %arg0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "async.yield"() : () -> ()
    }) : (!async.value<f32>) -> !async.token
    "async.await"(%1) : (!async.token) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

