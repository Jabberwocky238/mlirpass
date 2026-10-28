"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "callee"}> ({
      "spirv.Return"() : () -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "calling_single_block_ret_func"}> ({
      "spirv.FunctionCall"() <{callee = @callee}> : () -> ()
      "spirv.Return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> i32, sym_name = "callee"}> ({
      %1 = "spirv.Constant"() <{value = 42 : i32}> : () -> i32
      "spirv.ReturnValue"(%1) : (i32) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> i32, sym_name = "calling_single_block_retval_func"}> ({
      %0 = "spirv.FunctionCall"() <{callee = @callee}> : () -> i32
      "spirv.ReturnValue"(%0) : (i32) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "data", type = !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32> [0])>, StorageBuffer>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "callee"}> ({
      %0 = "spirv.mlir.addressof"() <{variable = @data}> : () -> !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32> [0])>, StorageBuffer>
      %1 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %2 = "spirv.AccessChain"(%0, %1, %1) : (!spirv.ptr<!spirv.struct<(!spirv.rtarray<i32> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
      "spirv.Branch"()[^bb1] : () -> ()
    ^bb1:  // pred: ^bb0
      %3 = "spirv.Constant"() <{value = 42 : i32}> : () -> i32
      "spirv.Store"(%2, %3) : (!spirv.ptr<i32, StorageBuffer>, i32) -> ()
      "spirv.Return"() : () -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "calling_multi_block_ret_func"}> ({
      "spirv.FunctionCall"() <{callee = @callee}> : () -> ()
      "spirv.Return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1) -> (), sym_name = "callee"}> ({
    ^bb0(%arg0: i1):
      "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
        "spirv.BranchConditional"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
      ^bb1:  // pred: ^bb0
        "spirv.Return"() : () -> ()
      ^bb2:  // pred: ^bb0
        "spirv.mlir.merge"() : () -> ()
      }) : () -> ()
      "spirv.Return"() : () -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "calling_selection_ret_func"}> ({
      %0 = "spirv.Constant"() <{value = true}> : () -> i1
      "spirv.FunctionCall"(%0) <{callee = @callee}> : (i1) -> ()
      "spirv.Return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1) -> (), sym_name = "callee"}> ({
    ^bb0(%arg0: i1):
      "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
        "spirv.BranchConditional"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
      ^bb1:  // pred: ^bb0
        "spirv.Branch"()[^bb2] : () -> ()
      ^bb2:  // 2 preds: ^bb0, ^bb1
        "spirv.mlir.merge"() : () -> ()
      }) : () -> ()
      "spirv.Return"() : () -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "calling_selection_no_ret_func"}> ({
      %0 = "spirv.Constant"() <{value = true}> : () -> i1
      "spirv.FunctionCall"(%0) <{callee = @callee}> : (i1) -> ()
      "spirv.Return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1) -> (), sym_name = "callee"}> ({
    ^bb0(%arg0: i1):
      "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
        "spirv.Branch"()[^bb1] : () -> ()
      ^bb1:  // 2 preds: ^bb0, ^bb3
        "spirv.BranchConditional"(%arg0)[^bb2, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
      ^bb2:  // pred: ^bb1
        "spirv.Return"() : () -> ()
      ^bb3:  // no predecessors
        "spirv.Branch"()[^bb1] : () -> ()
      ^bb4:  // pred: ^bb1
        "spirv.mlir.merge"() : () -> ()
      }) : () -> ()
      "spirv.Return"() : () -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "calling_loop_ret_func"}> ({
      %0 = "spirv.Constant"() <{value = true}> : () -> i1
      "spirv.FunctionCall"(%0) <{callee = @callee}> : (i1) -> ()
      "spirv.Return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1) -> (), sym_name = "callee"}> ({
    ^bb0(%arg0: i1):
      "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
        "spirv.Branch"()[^bb1] : () -> ()
      ^bb1:  // 2 preds: ^bb0, ^bb3
        "spirv.BranchConditional"(%arg0)[^bb2, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
      ^bb2:  // pred: ^bb1
        "spirv.Branch"()[^bb3] : () -> ()
      ^bb3:  // pred: ^bb2
        "spirv.Branch"()[^bb1] : () -> ()
      ^bb4:  // pred: ^bb1
        "spirv.mlir.merge"() : () -> ()
      }) : () -> ()
      "spirv.Return"() : () -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "calling_loop_no_ret_func"}> ({
      %0 = "spirv.Constant"() <{value = true}> : () -> i1
      "spirv.FunctionCall"(%0) <{callee = @callee}> : (i1) -> ()
      "spirv.Return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "arg_0", type = !spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>}> : () -> ()
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "arg_1", type = !spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "inline_into_selection_region"}> ({
      %1 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %2 = "spirv.mlir.addressof"() <{variable = @arg_0}> : () -> !spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>
      %3 = "spirv.mlir.addressof"() <{variable = @arg_1}> : () -> !spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>
      %4 = "spirv.AccessChain"(%2, %1) : (!spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>, i32) -> !spirv.ptr<i32, StorageBuffer>
      %5 = "spirv.Load"(%4) : (!spirv.ptr<i32, StorageBuffer>) -> i32
      %6 = "spirv.SGreaterThan"(%5, %1) : (i32, i32) -> i1
      "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
        "spirv.BranchConditional"(%6)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
      ^bb1:  // pred: ^bb0
        %7 = "spirv.AccessChain"(%3, %1) : (!spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>, i32) -> !spirv.ptr<i32, StorageBuffer>
        "spirv.FunctionCall"(%5, %7) <{callee = @atomic_add}> : (i32, !spirv.ptr<i32, StorageBuffer>) -> ()
        "spirv.Branch"()[^bb2] : () -> ()
      ^bb2:  // 2 preds: ^bb0, ^bb1
        "spirv.mlir.merge"() : () -> ()
      }) : () -> ()
      "spirv.Return"() : () -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, !spirv.ptr<i32, StorageBuffer>) -> (), sym_name = "atomic_add"}> ({
    ^bb0(%arg0: i32, %arg1: !spirv.ptr<i32, StorageBuffer>):
      %0 = "spirv.AtomicIAdd"(%arg1, %arg0) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<AcquireRelease>}> : (!spirv.ptr<i32, StorageBuffer>, i32) -> i32
      "spirv.Return"() : () -> ()
    }) : () -> ()
    "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<GLCompute>, fn = @inline_into_selection_region, interface = []}> : () -> ()
    "spirv.ExecutionMode"() <{execution_mode = #spirv.execution_mode<LocalSize>, fn = @inline_into_selection_region, values = [32 : i32, 1 : i32, 1 : i32]}> : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "foo"}> ({
    ^bb0(%arg1: i32):
      %3 = "spirv.FunctionCall"(%arg1) <{callee = @bar}> : (i32) -> i32
      "spirv.ReturnValue"(%3) : (i32) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "bar"}> ({
    ^bb0(%arg0: i32):
      %0 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %1 = "spirv.IEqual"(%arg0, %0) : (i32, i32) -> i1
      "spirv.BranchConditional"(%1, %0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, i32) -> ()
    ^bb1(%2: i32):  // pred: ^bb0
      "spirv.ReturnValue"(%2) : (i32) -> ()
    ^bb2:  // pred: ^bb0
      "spirv.ReturnValue"(%0) : (i32) -> ()
    }) {sym_visibility = "private"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "callee"}> ({
      "spirv.Kill"() : () -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "do_not_inline_kill"}> ({
      "spirv.FunctionCall"() <{callee = @callee}> : () -> ()
      "spirv.Return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

