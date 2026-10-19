"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "loop_kernel"}> ({
  ^bb0(%arg4: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg5: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>):
    %38 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %39 = "spirv.Constant"() <{value = 42 : i32}> : () -> i32
    %40 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      "spirv.Branch"(%38)[^bb1] : (i32) -> ()
    ^bb1(%41: i32):  // 2 preds: ^bb0, ^bb2
      %42 = "spirv.SLessThan"(%41, %39) : (i32, i32) -> i1
      "spirv.BranchConditional"(%42)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      %43 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %44 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %45 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %46 = "spirv.AccessChain"(%arg4, %43, %41) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %47 = "spirv.Load"(%46) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %48 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %49 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %50 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %51 = "spirv.AccessChain"(%arg5, %48, %41) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      "spirv.Store"(%51, %47) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
      %52 = "spirv.IAdd"(%41, %40) : (i32, i32) -> i32
      "spirv.Branch"(%52)[^bb1] : (i32) -> ()
    ^bb3:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "unsigned_loop"}> ({
  ^bb0(%arg2: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg3: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>):
    %23 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %24 = "spirv.Constant"() <{value = 42 : i32}> : () -> i32
    %25 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      "spirv.Branch"(%23)[^bb1] : (i32) -> ()
    ^bb1(%26: i32):  // 2 preds: ^bb0, ^bb2
      %27 = "spirv.ULessThan"(%26, %24) : (i32, i32) -> i1
      "spirv.BranchConditional"(%27)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      %28 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %29 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %30 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %31 = "spirv.AccessChain"(%arg2, %28, %26) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %32 = "spirv.Load"(%31) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %33 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %34 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %35 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %36 = "spirv.AccessChain"(%arg3, %33, %26) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      "spirv.Store"(%36, %32) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
      %37 = "spirv.IAdd"(%26, %25) : (i32, i32) -> i32
      "spirv.Branch"(%37)[^bb1] : (i32) -> ()
    ^bb3:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "loop_yield"}> ({
  ^bb0(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>):
    %0 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %1 = "spirv.Constant"() <{value = 42 : i32}> : () -> i32
    %2 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    %3 = "spirv.Constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "spirv.Constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %5 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
    %6 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      "spirv.Branch"(%0, %3, %4)[^bb1] : (i32, f32, f32) -> ()
    ^bb1(%17: i32, %18: f32, %19: f32):  // 2 preds: ^bb0, ^bb2
      %20 = "spirv.SLessThan"(%17, %1) : (i32, i32) -> i1
      "spirv.BranchConditional"(%20)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      %21 = "spirv.FAdd"(%18, %18) : (f32, f32) -> f32
      "spirv.Store"(%5, %21) : (!spirv.ptr<f32, Function>, f32) -> ()
      "spirv.Store"(%6, %21) : (!spirv.ptr<f32, Function>, f32) -> ()
      %22 = "spirv.IAdd"(%17, %2) : (i32, i32) -> i32
      "spirv.Branch"(%22, %21, %21)[^bb1] : (i32, f32, f32) -> ()
    ^bb3:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    %7 = "spirv.Load"(%6) : (!spirv.ptr<f32, Function>) -> f32
    %8 = "spirv.Load"(%5) : (!spirv.ptr<f32, Function>) -> f32
    %9 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %10 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %11 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %12 = "spirv.AccessChain"(%arg1, %9, %0) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    "spirv.Store"(%12, %8) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
    %13 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %14 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %15 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %16 = "spirv.AccessChain"(%arg1, %13, %1) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    "spirv.Store"(%16, %7) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

