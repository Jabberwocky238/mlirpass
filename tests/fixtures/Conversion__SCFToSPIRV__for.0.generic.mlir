"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "loop_kernel"}> ({
  ^bb0(%arg8: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg9: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>):
    %68 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %69 = "spirv.Constant"() <{value = 42 : i32}> : () -> i32
    %70 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      "spirv.Branch"(%68)[^bb1] : (i32) -> ()
    ^bb1(%71: i32):  // 2 preds: ^bb0, ^bb2
      %72 = "spirv.SLessThan"(%71, %69) : (i32, i32) -> i1
      "spirv.BranchConditional"(%72)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      %73 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %74 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %75 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %76 = "spirv.AccessChain"(%arg8, %73, %71) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %77 = "spirv.Load"(%76) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %78 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %79 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %80 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %81 = "spirv.AccessChain"(%arg9, %78, %71) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      "spirv.Store"(%81, %77) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
      %82 = "spirv.IAdd"(%71, %70) : (i32, i32) -> i32
      "spirv.Branch"(%82)[^bb1] : (i32) -> ()
    ^bb3:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "unsigned_loop"}> ({
  ^bb0(%arg6: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg7: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>):
    %53 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %54 = "spirv.Constant"() <{value = 42 : i32}> : () -> i32
    %55 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      "spirv.Branch"(%53)[^bb1] : (i32) -> ()
    ^bb1(%56: i32):  // 2 preds: ^bb0, ^bb2
      %57 = "spirv.ULessThan"(%56, %54) : (i32, i32) -> i1
      "spirv.BranchConditional"(%57)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      %58 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %59 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %60 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %61 = "spirv.AccessChain"(%arg6, %58, %56) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %62 = "spirv.Load"(%61) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %63 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %64 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %65 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %66 = "spirv.AccessChain"(%arg7, %63, %56) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      "spirv.Store"(%66, %62) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
      %67 = "spirv.IAdd"(%56, %55) : (i32, i32) -> i32
      "spirv.Branch"(%67)[^bb1] : (i32) -> ()
    ^bb3:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "loop_yield"}> ({
  ^bb0(%arg4: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg5: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>):
    %30 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %31 = "spirv.Constant"() <{value = 42 : i32}> : () -> i32
    %32 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    %33 = "spirv.Constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %34 = "spirv.Constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %35 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
    %36 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      "spirv.Branch"(%30, %33, %34)[^bb1] : (i32, f32, f32) -> ()
    ^bb1(%47: i32, %48: f32, %49: f32):  // 2 preds: ^bb0, ^bb2
      %50 = "spirv.SLessThan"(%47, %31) : (i32, i32) -> i1
      "spirv.BranchConditional"(%50)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      %51 = "spirv.FAdd"(%48, %48) : (f32, f32) -> f32
      "spirv.Store"(%35, %51) : (!spirv.ptr<f32, Function>, f32) -> ()
      "spirv.Store"(%36, %51) : (!spirv.ptr<f32, Function>, f32) -> ()
      %52 = "spirv.IAdd"(%47, %32) : (i32, i32) -> i32
      "spirv.Branch"(%52, %51, %51)[^bb1] : (i32, f32, f32) -> ()
    ^bb3:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    %37 = "spirv.Load"(%36) : (!spirv.ptr<f32, Function>) -> f32
    %38 = "spirv.Load"(%35) : (!spirv.ptr<f32, Function>) -> f32
    %39 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %40 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %41 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %42 = "spirv.AccessChain"(%arg5, %39, %30) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    "spirv.Store"(%42, %38) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
    %43 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %44 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %45 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %46 = "spirv.AccessChain"(%arg5, %43, %31) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    "spirv.Store"(%46, %37) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "loop_unroll"}> ({
  ^bb0(%arg2: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg3: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>):
    %15 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %16 = "spirv.Constant"() <{value = 10 : i32}> : () -> i32
    %17 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<Unroll>}> ({
      "spirv.Branch"(%15)[^bb1] : (i32) -> ()
    ^bb1(%18: i32):  // 2 preds: ^bb0, ^bb2
      %19 = "spirv.SLessThan"(%18, %16) : (i32, i32) -> i1
      "spirv.BranchConditional"(%19)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      %20 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %21 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %22 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %23 = "spirv.AccessChain"(%arg2, %20, %18) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %24 = "spirv.Load"(%23) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %25 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %26 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %27 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %28 = "spirv.AccessChain"(%arg3, %25, %18) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      "spirv.Store"(%28, %24) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
      %29 = "spirv.IAdd"(%18, %17) : (i32, i32) -> i32
      "spirv.Branch"(%29)[^bb1] : (i32) -> ()
    ^bb3:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "loop_dont_unroll"}> ({
  ^bb0(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>):
    %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %1 = "spirv.Constant"() <{value = 10 : i32}> : () -> i32
    %2 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<DontUnroll>}> ({
      "spirv.Branch"(%0)[^bb1] : (i32) -> ()
    ^bb1(%3: i32):  // 2 preds: ^bb0, ^bb2
      %4 = "spirv.SLessThan"(%3, %1) : (i32, i32) -> i1
      "spirv.BranchConditional"(%4)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      %5 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %6 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %7 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %8 = "spirv.AccessChain"(%arg0, %5, %3) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %9 = "spirv.Load"(%8) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %10 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %11 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %12 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %13 = "spirv.AccessChain"(%arg1, %10, %3) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      "spirv.Store"(%13, %9) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
      %14 = "spirv.IAdd"(%3, %2) : (i32, i32) -> i32
      "spirv.Branch"(%14)[^bb1] : (i32) -> ()
    ^bb3:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

