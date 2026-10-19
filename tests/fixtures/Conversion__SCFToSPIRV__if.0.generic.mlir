"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i1) -> (), sym_name = "kernel_simple_selection"}> ({
  ^bb0(%arg12: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg13: i1):
    %65 = "spirv.Constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %66 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
      "spirv.BranchConditional"(%arg13)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %67 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %68 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %69 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %70 = "spirv.AccessChain"(%arg12, %67, %66) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      "spirv.Store"(%70, %65) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
      "spirv.Branch"()[^bb2] : () -> ()
    ^bb2:  // 2 preds: ^bb0, ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i1, i1) -> (), sym_name = "kernel_nested_selection"}> ({
  ^bb0(%arg8: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg9: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg10: i1, %arg11: i1):
    %27 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %28 = "spirv.Constant"() <{value = 9 : i32}> : () -> i32
    "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
      "spirv.BranchConditional"(%arg10)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
        "spirv.BranchConditional"(%arg11)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
      ^bb1:  // pred: ^bb0
        %47 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %48 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %49 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
        %50 = "spirv.AccessChain"(%arg8, %47, %27) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
        %51 = "spirv.Load"(%50) : (!spirv.ptr<f32, StorageBuffer>) -> f32
        %52 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %53 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %54 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
        %55 = "spirv.AccessChain"(%arg9, %52, %27) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
        "spirv.Store"(%55, %51) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
        "spirv.Branch"()[^bb3] : () -> ()
      ^bb2:  // pred: ^bb0
        %56 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %57 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %58 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
        %59 = "spirv.AccessChain"(%arg9, %56, %27) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
        %60 = "spirv.Load"(%59) : (!spirv.ptr<f32, StorageBuffer>) -> f32
        %61 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %62 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %63 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
        %64 = "spirv.AccessChain"(%arg8, %61, %27) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
        "spirv.Store"(%64, %60) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
        "spirv.Branch"()[^bb3] : () -> ()
      ^bb3:  // 2 preds: ^bb1, ^bb2
        "spirv.mlir.merge"() : () -> ()
      }) : () -> ()
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb2:  // pred: ^bb0
      "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
        "spirv.BranchConditional"(%arg11)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
      ^bb1:  // pred: ^bb0
        %29 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %30 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %31 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
        %32 = "spirv.AccessChain"(%arg8, %29, %28) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
        %33 = "spirv.Load"(%32) : (!spirv.ptr<f32, StorageBuffer>) -> f32
        %34 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %35 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %36 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
        %37 = "spirv.AccessChain"(%arg9, %34, %28) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
        "spirv.Store"(%37, %33) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
        "spirv.Branch"()[^bb3] : () -> ()
      ^bb2:  // pred: ^bb0
        %38 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %39 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %40 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
        %41 = "spirv.AccessChain"(%arg9, %38, %28) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
        %42 = "spirv.Load"(%41) : (!spirv.ptr<f32, StorageBuffer>) -> f32
        %43 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %44 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
        %45 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
        %46 = "spirv.AccessChain"(%arg8, %43, %28) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
        "spirv.Store"(%46, %42) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
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
  ^bb0(%arg6: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg7: i1):
    %9 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
    %10 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
    "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
      "spirv.BranchConditional"(%arg7)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %23 = "spirv.Constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %24 = "spirv.Constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      "spirv.Store"(%9, %23) : (!spirv.ptr<f32, Function>, f32) -> ()
      "spirv.Store"(%10, %24) : (!spirv.ptr<f32, Function>, f32) -> ()
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb2:  // pred: ^bb0
      %25 = "spirv.Constant"() <{value = 2.000000e+00 : f32}> : () -> f32
      %26 = "spirv.Constant"() <{value = 3.000000e+00 : f32}> : () -> f32
      "spirv.Store"(%9, %26) : (!spirv.ptr<f32, Function>, f32) -> ()
      "spirv.Store"(%10, %25) : (!spirv.ptr<f32, Function>, f32) -> ()
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb3:  // 2 preds: ^bb1, ^bb2
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    %11 = "spirv.Load"(%10) : (!spirv.ptr<f32, Function>) -> f32
    %12 = "spirv.Load"(%9) : (!spirv.ptr<f32, Function>) -> f32
    %13 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %14 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %15 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %16 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %17 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %18 = "spirv.AccessChain"(%arg6, %15, %13) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    "spirv.Store"(%18, %12) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
    %19 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %20 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %21 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %22 = "spirv.AccessChain"(%arg6, %19, %14) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    "spirv.Store"(%22, %11) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i1) -> (), sym_name = "simple_if_yield_type_change"}> ({
  ^bb0(%arg3: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg4: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg5: i1):
    %1 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %2 = "spirv.Constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, Function>
    "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
      "spirv.BranchConditional"(%arg5)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "spirv.Store"(%3, %arg3) : (!spirv.ptr<!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, Function>, !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>) -> ()
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb2:  // pred: ^bb0
      "spirv.Store"(%3, %arg4) : (!spirv.ptr<!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, Function>, !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>) -> ()
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb3:  // 2 preds: ^bb1, ^bb2
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    %4 = "spirv.Load"(%3) : (!spirv.ptr<!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, Function>) -> !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>
    %5 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %6 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %7 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %8 = "spirv.AccessChain"(%4, %5, %1) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    "spirv.Store"(%8, %2) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<8xi32>, memref<8xi32>, i1) -> (), sym_name = "unsupported_yield_type"}> ({
  ^bb0(%arg0: memref<8xi32>, %arg1: memref<8xi32>, %arg2: i1):
    %0 = "scf.if"(%arg2) ({
      "scf.yield"(%arg0) : (memref<8xi32>) -> ()
    }, {
      "scf.yield"(%arg1) : (memref<8xi32>) -> ()
    }) : (i1) -> memref<8xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

