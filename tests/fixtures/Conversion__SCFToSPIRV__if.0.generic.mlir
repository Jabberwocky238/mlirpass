"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i1) -> (), sym_name = "kernel_simple_selection"}> ({
  ^bb0(%arg16: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg17: i1):
    %77 = "spirv.Constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %78 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
      "spirv.BranchConditional"(%arg17)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %79 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %80 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %81 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %82 = "spirv.AccessChain"(%arg16, %79, %78) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      "spirv.Store"(%82, %77) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
      "spirv.Branch"()[^bb2] : () -> ()
    ^bb2:  // 2 preds: ^bb0, ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i1, i1) -> (), sym_name = "kernel_nested_selection"}> ({
  ^bb0(%arg12: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg13: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg14: i1, %arg15: i1):
    %39 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %40 = "spirv.Constant"() <{value = 9 : i32}> : () -> i32
    "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
      "spirv.BranchConditional"(%arg14)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
        "spirv.BranchConditional"(%arg15)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
      ^bb1:  // pred: ^bb0
        %59 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %60 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %61 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
        %62 = "spirv.AccessChain"(%arg12, %59, %39) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
        %63 = "spirv.Load"(%62) : (!spirv.ptr<f32, StorageBuffer>) -> f32
        %64 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %65 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %66 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
        %67 = "spirv.AccessChain"(%arg13, %64, %39) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
        "spirv.Store"(%67, %63) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
        "spirv.Branch"()[^bb3] : () -> ()
      ^bb2:  // pred: ^bb0
        %68 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %69 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %70 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
        %71 = "spirv.AccessChain"(%arg13, %68, %39) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
        %72 = "spirv.Load"(%71) : (!spirv.ptr<f32, StorageBuffer>) -> f32
        %73 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %74 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %75 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
        %76 = "spirv.AccessChain"(%arg12, %73, %39) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
        "spirv.Store"(%76, %72) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
        "spirv.Branch"()[^bb3] : () -> ()
      ^bb3:  // 2 preds: ^bb1, ^bb2
        "spirv.mlir.merge"() : () -> ()
      }) : () -> ()
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb2:  // pred: ^bb0
      "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
        "spirv.BranchConditional"(%arg15)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
      ^bb1:  // pred: ^bb0
        %41 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %42 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %43 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
        %44 = "spirv.AccessChain"(%arg12, %41, %40) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
        %45 = "spirv.Load"(%44) : (!spirv.ptr<f32, StorageBuffer>) -> f32
        %46 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %47 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %48 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
        %49 = "spirv.AccessChain"(%arg13, %46, %40) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
        "spirv.Store"(%49, %45) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
        "spirv.Branch"()[^bb3] : () -> ()
      ^bb2:  // pred: ^bb0
        %50 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %51 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %52 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
        %53 = "spirv.AccessChain"(%arg13, %50, %40) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
        %54 = "spirv.Load"(%53) : (!spirv.ptr<f32, StorageBuffer>) -> f32
        %55 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %56 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %57 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
        %58 = "spirv.AccessChain"(%arg12, %55, %40) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
        "spirv.Store"(%58, %54) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
        "spirv.Branch"()[^bb3] : () -> ()
      ^bb3:  // 2 preds: ^bb1, ^bb2
        "spirv.mlir.merge"() : () -> ()
      }) : () -> ()
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb3:  // 2 preds: ^bb1, ^bb2
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i1) -> (), sym_name = "simple_if_yield"}> ({
  ^bb0(%arg10: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg11: i1):
    %21 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
    %22 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
    "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
      "spirv.BranchConditional"(%arg11)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %35 = "spirv.Constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %36 = "spirv.Constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      "spirv.Store"(%21, %35) : (!spirv.ptr<f32, Function>, f32) -> ()
      "spirv.Store"(%22, %36) : (!spirv.ptr<f32, Function>, f32) -> ()
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb2:  // pred: ^bb0
      %37 = "spirv.Constant"() <{value = 2.000000e+00 : f32}> : () -> f32
      %38 = "spirv.Constant"() <{value = 3.000000e+00 : f32}> : () -> f32
      "spirv.Store"(%21, %38) : (!spirv.ptr<f32, Function>, f32) -> ()
      "spirv.Store"(%22, %37) : (!spirv.ptr<f32, Function>, f32) -> ()
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb3:  // 2 preds: ^bb1, ^bb2
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    %23 = "spirv.Load"(%22) : (!spirv.ptr<f32, Function>) -> f32
    %24 = "spirv.Load"(%21) : (!spirv.ptr<f32, Function>) -> f32
    %25 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %26 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %27 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %28 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %29 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %30 = "spirv.AccessChain"(%arg10, %27, %25) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    "spirv.Store"(%30, %24) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
    %31 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %32 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %33 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %34 = "spirv.AccessChain"(%arg10, %31, %26) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    "spirv.Store"(%34, %23) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i1) -> (), sym_name = "simple_if_yield_type_change"}> ({
  ^bb0(%arg7: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg8: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg9: i1):
    %13 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %14 = "spirv.Constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %15 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, Function>
    "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
      "spirv.BranchConditional"(%arg9)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "spirv.Store"(%15, %arg7) : (!spirv.ptr<!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, Function>, !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>) -> ()
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb2:  // pred: ^bb0
      "spirv.Store"(%15, %arg8) : (!spirv.ptr<!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, Function>, !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>) -> ()
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb3:  // 2 preds: ^bb1, ^bb2
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    %16 = "spirv.Load"(%15) : (!spirv.ptr<!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, Function>) -> !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>
    %17 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %18 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %19 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %20 = "spirv.AccessChain"(%16, %17, %13) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    "spirv.Store"(%20, %14) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<8xi32>, memref<8xi32>, i1) -> (), sym_name = "unsupported_yield_type"}> ({
  ^bb0(%arg4: memref<8xi32>, %arg5: memref<8xi32>, %arg6: i1):
    %12 = "scf.if"(%arg6) ({
      "scf.yield"(%arg4) : (memref<8xi32>) -> ()
    }, {
      "scf.yield"(%arg5) : (memref<8xi32>) -> ()
    }) : (i1) -> memref<8xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i1) -> (), sym_name = "selection_flatten"}> ({
  ^bb0(%arg2: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg3: i1):
    %6 = "spirv.Constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %7 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<Flatten>}> ({
      "spirv.BranchConditional"(%arg3)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %8 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %9 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %10 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %11 = "spirv.AccessChain"(%arg2, %8, %7) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      "spirv.Store"(%11, %6) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
      "spirv.Branch"()[^bb2] : () -> ()
    ^bb2:  // 2 preds: ^bb0, ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i1) -> (), sym_name = "selection_dont_flatten"}> ({
  ^bb0(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg1: i1):
    %0 = "spirv.Constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<DontFlatten>}> ({
      "spirv.BranchConditional"(%arg1)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %2 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %3 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %4 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %5 = "spirv.AccessChain"(%arg0, %2, %1) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      "spirv.Store"(%5, %0) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
      "spirv.Branch"()[^bb2] : () -> ()
    ^bb2:  // 2 preds: ^bb0, ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

