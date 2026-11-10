"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> i32, sym_name = "while_loop1"}> ({
  ^bb0(%arg5: i32, %arg6: i32):
    %32 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    %33 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i32, Function>
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      "spirv.Branch"(%arg5)[^bb1] : (i32) -> ()
    ^bb1(%35: i32):  // 2 preds: ^bb0, ^bb2
      %36 = "spirv.SLessThan"(%35, %arg6) : (i32, i32) -> i1
      "spirv.Store"(%33, %35) : (!spirv.ptr<i32, Function>, i32) -> ()
      "spirv.BranchConditional"(%36, %35)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, i32) -> ()
    ^bb2(%37: i32):  // pred: ^bb1
      %38 = "spirv.IMul"(%37, %32) : (i32, i32) -> i32
      "spirv.Branch"(%38)[^bb1] : (i32) -> ()
    ^bb3:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    %34 = "spirv.Load"(%33) : (!spirv.ptr<i32, Function>) -> i32
    "spirv.ReturnValue"(%34) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> i64, sym_name = "while_loop2"}> ({
  ^bb0(%arg4: f32):
    %25 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i64, Function>
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      "spirv.Branch"(%arg4)[^bb1] : (f32) -> ()
    ^bb1(%27: f32):  // 2 preds: ^bb0, ^bb2
      %28 = "foo.shared_compute"(%27) : (f32) -> i64
      %29 = "foo.evaluate_condition"(%27, %28) : (f32, i64) -> i1
      "spirv.Store"(%25, %28) : (!spirv.ptr<i64, Function>, i64) -> ()
      "spirv.BranchConditional"(%29, %28)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, i64) -> ()
    ^bb2(%30: i64):  // pred: ^bb1
      %31 = "foo.payload"(%30) : (i64) -> f32
      "spirv.Branch"(%31)[^bb1] : (f32) -> ()
    ^bb3:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    %26 = "spirv.Load"(%25) : (!spirv.ptr<i64, Function>) -> i64
    "spirv.ReturnValue"(%26) : (i64) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i64, sym_name = "while_loop_before_typeconv"}> ({
  ^bb0(%arg3: i32):
    %16 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i64, Function>
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      "spirv.Branch"(%arg3)[^bb1] : (i32) -> ()
    ^bb1(%18: i32):  // 2 preds: ^bb0, ^bb2
      %19 = "builtin.unrealized_conversion_cast"(%18) : (i32) -> index
      %20 = "foo.shared_compute"(%19) : (index) -> i64
      %21 = "foo.evaluate_condition"(%19, %20) : (index, i64) -> i1
      "spirv.Store"(%16, %20) : (!spirv.ptr<i64, Function>, i64) -> ()
      "spirv.BranchConditional"(%21, %20)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, i64) -> ()
    ^bb2(%22: i64):  // pred: ^bb1
      %23 = "foo.payload"(%22) : (i64) -> index
      %24 = "builtin.unrealized_conversion_cast"(%23) : (index) -> i32
      "spirv.Branch"(%24)[^bb1] : (i32) -> ()
    ^bb3:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    %17 = "spirv.Load"(%16) : (!spirv.ptr<i64, Function>) -> i64
    "spirv.ReturnValue"(%17) : (i64) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> i32, sym_name = "while_loop_after_typeconv"}> ({
  ^bb0(%arg2: f32):
    %7 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i32, Function>
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      "spirv.Branch"(%arg2)[^bb1] : (f32) -> ()
    ^bb1(%9: f32):  // 2 preds: ^bb0, ^bb2
      %10 = "foo.shared_compute"(%9) : (f32) -> index
      %11 = "builtin.unrealized_conversion_cast"(%10) : (index) -> i32
      %12 = "foo.evaluate_condition"(%9, %10) : (f32, index) -> i1
      "spirv.Store"(%7, %11) : (!spirv.ptr<i32, Function>, i32) -> ()
      "spirv.BranchConditional"(%12, %11)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, i32) -> ()
    ^bb2(%13: i32):  // pred: ^bb1
      %14 = "builtin.unrealized_conversion_cast"(%13) : (i32) -> index
      %15 = "foo.payload"(%14) : (index) -> f32
      "spirv.Branch"(%15)[^bb1] : (f32) -> ()
    ^bb3:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    %8 = "spirv.Load"(%7) : (!spirv.ptr<i32, Function>) -> i32
    "spirv.ReturnValue"(%8) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> i32, sym_name = "while_loop_unroll"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i32, Function>
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<Unroll>}> ({
      "spirv.Branch"(%arg0)[^bb1] : (i32) -> ()
    ^bb1(%3: i32):  // 2 preds: ^bb0, ^bb2
      %4 = "spirv.SLessThan"(%3, %arg1) : (i32, i32) -> i1
      "spirv.Store"(%1, %3) : (!spirv.ptr<i32, Function>, i32) -> ()
      "spirv.BranchConditional"(%4, %3)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, i32) -> ()
    ^bb2(%5: i32):  // pred: ^bb1
      %6 = "spirv.IMul"(%5, %0) : (i32, i32) -> i32
      "spirv.Branch"(%6)[^bb1] : (i32) -> ()
    ^bb3:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    %2 = "spirv.Load"(%1) : (!spirv.ptr<i32, Function>) -> i32
    "spirv.ReturnValue"(%2) : (i32) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

