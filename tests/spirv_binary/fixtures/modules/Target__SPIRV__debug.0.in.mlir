"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.3, [Shader, GroupNonUniformArithmetic], [SPV_KHR_non_semantic_info, SPV_KHR_storage_buffer_storage_class]>}> ({
  "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var0", type = !spirv.ptr<f32, Input>}> : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xf32>, vector<4xf32>) -> (), sym_name = "arithmetic"}> ({
  ^bb0(%arg18: vector<4xf32>, %arg19: vector<4xf32>):
    %27 = "spirv.FAdd"(%arg18, %arg19) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %28 = "spirv.FNegate"(%arg18) : (vector<4xf32>) -> vector<4xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<i32, Workgroup>, i32, i32) -> (), sym_name = "atomic"}> ({
  ^bb0(%arg15: !spirv.ptr<i32, Workgroup>, %arg16: i32, %arg17: i32):
    %26 = "spirv.AtomicAnd"(%arg15, %arg16) <{memory_scope = #spirv.scope<Device>, semantics = #spirv.memory_semantics<None>}> : (!spirv.ptr<i32, Workgroup>, i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> (), sym_name = "bitwiser"}> ({
  ^bb0(%arg13: i32, %arg14: i32):
    %25 = "spirv.BitwiseAnd"(%arg13, %arg14) : (i32, i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "convert"}> ({
  ^bb0(%arg12: f32):
    %24 = "spirv.ConvertFToU"(%arg12) : (f32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.struct<(f32, !spirv.struct<(!spirv.array<4 x f32>, f32)>)>, !spirv.array<4 x f32>, f32, f32) -> (), sym_name = "composite"}> ({
  ^bb0(%arg8: !spirv.struct<(f32, !spirv.struct<(!spirv.array<4 x f32>, f32)>)>, %arg9: !spirv.array<4 x f32>, %arg10: f32, %arg11: f32):
    %22 = "spirv.CompositeInsert"(%arg9, %arg8) <{indices = [1 : i32, 0 : i32]}> : (!spirv.array<4 x f32>, !spirv.struct<(f32, !spirv.struct<(!spirv.array<4 x f32>, f32)>)>) -> !spirv.struct<(f32, !spirv.struct<(!spirv.array<4 x f32>, f32)>)>
    %23 = "spirv.CompositeConstruct"(%arg10, %arg11) : (f32, f32) -> vector<2xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "group_non_uniform"}> ({
  ^bb0(%arg7: f32):
    %21 = "spirv.GroupNonUniformFAdd"(%arg7) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "local_var"}> ({
    %19 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %20 = "spirv.Variable"(%19) <{storage_class = #spirv.storage_class<Function>}> : (i32) -> !spirv.ptr<i32, Function>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> (), sym_name = "logical"}> ({
  ^bb0(%arg5: i32, %arg6: i32):
    %18 = "spirv.IEqual"(%arg5, %arg6) : (i32, i32) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.array<4 x !spirv.array<4 x f32>>, StorageBuffer>, i32, i32) -> (), sym_name = "memory_accesses"}> ({
  ^bb0(%arg2: !spirv.ptr<!spirv.array<4 x !spirv.array<4 x f32>>, StorageBuffer>, %arg3: i32, %arg4: i32):
    %16 = "spirv.AccessChain"(%arg2, %arg3, %arg4) : (!spirv.ptr<!spirv.array<4 x !spirv.array<4 x f32>>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    %17 = "spirv.Load"(%16) : (!spirv.ptr<f32, StorageBuffer>) -> f32
    "spirv.Store"(%16, %17) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "loop"}> ({
  ^bb0(%arg1: i32):
    %4 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %5 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %6 = "spirv.Variable"(%4) <{storage_class = #spirv.storage_class<Function>}> : (i32) -> !spirv.ptr<i32, Function>
    %7 = "spirv.Variable"(%4) <{storage_class = #spirv.storage_class<Function>}> : (i32) -> !spirv.ptr<i32, Function>
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      "spirv.Branch"()[^bb1] : () -> ()
    ^bb1:  // 2 preds: ^bb0, ^bb3
      %8 = "spirv.Load"(%6) : (!spirv.ptr<i32, Function>) -> i32
      %9 = "spirv.SLessThan"(%8, %arg1) : (i32, i32) -> i1
      "spirv.BranchConditional"(%9)[^bb2, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      "spirv.Store"(%7, %4) : (!spirv.ptr<i32, Function>, i32) -> ()
      "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
        "spirv.Branch"()[^bb1] : () -> ()
      ^bb1:  // 2 preds: ^bb0, ^bb3
        %12 = "spirv.Load"(%7) : (!spirv.ptr<i32, Function>) -> i32
        %13 = "spirv.SLessThan"(%12, %arg1) : (i32, i32) -> i1
        "spirv.BranchConditional"(%13)[^bb2, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
      ^bb2:  // pred: ^bb1
        "spirv.Branch"()[^bb3] : () -> ()
      ^bb3:  // pred: ^bb2
        %14 = "spirv.Load"(%7) : (!spirv.ptr<i32, Function>) -> i32
        %15 = "spirv.IAdd"(%14, %5) : (i32, i32) -> i32
        "spirv.Store"(%7, %15) : (!spirv.ptr<i32, Function>, i32) -> ()
        "spirv.Branch"()[^bb1] : () -> ()
      ^bb4:  // pred: ^bb1
        "spirv.mlir.merge"() : () -> ()
      }) : () -> ()
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb3:  // pred: ^bb2
      %10 = "spirv.Load"(%6) : (!spirv.ptr<i32, Function>) -> i32
      %11 = "spirv.IAdd"(%10, %5) : (i32, i32) -> i32
      "spirv.Store"(%6, %11) : (!spirv.ptr<i32, Function>, i32) -> ()
      "spirv.Branch"()[^bb1] : () -> ()
    ^bb4:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1) -> (), sym_name = "selection"}> ({
  ^bb0(%arg0: i1):
    %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %1 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %2 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    %3 = "spirv.Variable"(%0) <{storage_class = #spirv.storage_class<Function>}> : (i32) -> !spirv.ptr<i32, Function>
    "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
      "spirv.BranchConditional"(%arg0)[^bb1, ^bb2] <{branch_weights = [5 : i32, 10 : i32], operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "spirv.Store"(%3, %1) : (!spirv.ptr<i32, Function>, i32) -> ()
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb2:  // pred: ^bb0
      "spirv.Store"(%3, %2) : (!spirv.ptr<i32, Function>, i32) -> ()
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb3:  // 2 preds: ^bb1, ^bb2
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<GLCompute>, fn = @local_var, interface = []}> : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, GroupNonUniformArithmetic], [SPV_KHR_non_semantic_info, SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

