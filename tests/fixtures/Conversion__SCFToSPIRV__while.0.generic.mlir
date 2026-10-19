"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> i32, sym_name = "while_loop1"}> ({
  ^bb0(%arg3: i32, %arg4: i32):
    %25 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    %26 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i32, Function>
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      "spirv.Branch"(%arg3)[^bb1] : (i32) -> ()
    ^bb1(%28: i32):  // 2 preds: ^bb0, ^bb2
      %29 = "spirv.SLessThan"(%28, %arg4) : (i32, i32) -> i1
      "spirv.Store"(%26, %28) : (!spirv.ptr<i32, Function>, i32) -> ()
      "spirv.BranchConditional"(%29, %28)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, i32) -> ()
    ^bb2(%30: i32):  // pred: ^bb1
      %31 = "spirv.IMul"(%30, %25) : (i32, i32) -> i32
      "spirv.Branch"(%31)[^bb1] : (i32) -> ()
    ^bb3:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    %27 = "spirv.Load"(%26) : (!spirv.ptr<i32, Function>) -> i32
    "spirv.ReturnValue"(%27) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> i64, sym_name = "while_loop2"}> ({
  ^bb0(%arg2: f32):
    %18 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i64, Function>
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      "spirv.Branch"(%arg2)[^bb1] : (f32) -> ()
    ^bb1(%20: f32):  // 2 preds: ^bb0, ^bb2
      %21 = "foo.shared_compute"(%20) : (f32) -> i64
      %22 = "foo.evaluate_condition"(%20, %21) : (f32, i64) -> i1
      "spirv.Store"(%18, %21) : (!spirv.ptr<i64, Function>, i64) -> ()
      "spirv.BranchConditional"(%22, %21)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, i64) -> ()
    ^bb2(%23: i64):  // pred: ^bb1
      %24 = "foo.payload"(%23) : (i64) -> f32
      "spirv.Branch"(%24)[^bb1] : (f32) -> ()
    ^bb3:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    %19 = "spirv.Load"(%18) : (!spirv.ptr<i64, Function>) -> i64
    "spirv.ReturnValue"(%19) : (i64) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i64, sym_name = "while_loop_before_typeconv"}> ({
  ^bb0(%arg1: i32):
    %9 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i64, Function>
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      "spirv.Branch"(%arg1)[^bb1] : (i32) -> ()
    ^bb1(%11: i32):  // 2 preds: ^bb0, ^bb2
      %12 = "builtin.unrealized_conversion_cast"(%11) : (i32) -> index
      %13 = "foo.shared_compute"(%12) : (index) -> i64
      %14 = "foo.evaluate_condition"(%12, %13) : (index, i64) -> i1
      "spirv.Store"(%9, %13) : (!spirv.ptr<i64, Function>, i64) -> ()
      "spirv.BranchConditional"(%14, %13)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, i64) -> ()
    ^bb2(%15: i64):  // pred: ^bb1
      %16 = "foo.payload"(%15) : (i64) -> index
      %17 = "builtin.unrealized_conversion_cast"(%16) : (index) -> i32
      "spirv.Branch"(%17)[^bb1] : (i32) -> ()
    ^bb3:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    %10 = "spirv.Load"(%9) : (!spirv.ptr<i64, Function>) -> i64
    "spirv.ReturnValue"(%10) : (i64) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> i32, sym_name = "while_loop_after_typeconv"}> ({
  ^bb0(%arg0: f32):
    %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i32, Function>
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      "spirv.Branch"(%arg0)[^bb1] : (f32) -> ()
    ^bb1(%2: f32):  // 2 preds: ^bb0, ^bb2
      %3 = "foo.shared_compute"(%2) : (f32) -> index
      %4 = "builtin.unrealized_conversion_cast"(%3) : (index) -> i32
      %5 = "foo.evaluate_condition"(%2, %3) : (f32, index) -> i1
      "spirv.Store"(%0, %4) : (!spirv.ptr<i32, Function>, i32) -> ()
      "spirv.BranchConditional"(%5, %4)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, i32) -> ()
    ^bb2(%6: i32):  // pred: ^bb1
      %7 = "builtin.unrealized_conversion_cast"(%6) : (i32) -> index
      %8 = "foo.payload"(%7) : (index) -> f32
      "spirv.Branch"(%8)[^bb1] : (f32) -> ()
    ^bb3:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    %1 = "spirv.Load"(%0) : (!spirv.ptr<i32, Function>) -> i32
    "spirv.ReturnValue"(%1) : (i32) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

