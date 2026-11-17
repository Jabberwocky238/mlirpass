"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, VariablePointers, Linkage], [SPV_KHR_storage_buffer_storage_class, SPV_KHR_variable_pointers]>}> ({
  "spirv.GlobalVariable"() <{sym_name = "var1", type = !spirv.ptr<!spirv.array<4 x f32>, StorageBuffer>}> : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> i32, sym_name = "fmain"}> ({
    %7 = "spirv.Constant"() <{value = 16 : i32}> : () -> i32
    %8 = "spirv.mlir.addressof"() <{variable = @var1}> : () -> !spirv.ptr<!spirv.array<4 x f32>, StorageBuffer>
    %9 = "spirv.FunctionCall"(%7) <{callee = @f_0}> : (i32) -> i32
    "spirv.FunctionCall"(%9, %8) <{callee = @f_1}> : (i32, !spirv.ptr<!spirv.array<4 x f32>, StorageBuffer>) -> ()
    %10 = "spirv.FunctionCall"(%8) <{callee = @f_2}> : (!spirv.ptr<!spirv.array<4 x f32>, StorageBuffer>) -> !spirv.ptr<!spirv.array<4 x f32>, StorageBuffer>
    "spirv.ReturnValue"(%9) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "f_0"}> ({
  ^bb0(%arg5: i32):
    "spirv.ReturnValue"(%arg5) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, !spirv.ptr<!spirv.array<4 x f32>, StorageBuffer>) -> (), sym_name = "f_1"}> ({
  ^bb0(%arg3: i32, %arg4: !spirv.ptr<!spirv.array<4 x f32>, StorageBuffer>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.array<4 x f32>, StorageBuffer>) -> !spirv.ptr<!spirv.array<4 x f32>, StorageBuffer>, sym_name = "f_2"}> ({
  ^bb0(%arg2: !spirv.ptr<!spirv.array<4 x f32>, StorageBuffer>):
    "spirv.ReturnValue"(%arg2) : (!spirv.ptr<!spirv.array<4 x f32>, StorageBuffer>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "f_loop_with_function_call"}> ({
  ^bb0(%arg1: i32):
    %3 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %4 = "spirv.Variable"(%3) <{storage_class = #spirv.storage_class<Function>}> : (i32) -> !spirv.ptr<i32, Function>
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      "spirv.Branch"()[^bb1] : () -> ()
    ^bb1:  // 2 preds: ^bb0, ^bb3
      %5 = "spirv.Load"(%4) : (!spirv.ptr<i32, Function>) -> i32
      %6 = "spirv.SLessThan"(%5, %arg1) : (i32, i32) -> i1
      "spirv.BranchConditional"(%6)[^bb2, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb3:  // pred: ^bb2
      "spirv.FunctionCall"(%4) <{callee = @f_inc}> : (!spirv.ptr<i32, Function>) -> ()
      "spirv.Branch"()[^bb1] : () -> ()
    ^bb4:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<i32, Function>) -> (), sym_name = "f_inc"}> ({
  ^bb0(%arg0: !spirv.ptr<i32, Function>):
    %0 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %1 = "spirv.Load"(%arg0) : (!spirv.ptr<i32, Function>) -> i32
    %2 = "spirv.IAdd"(%1, %0) : (i32, i32) -> i32
    "spirv.Store"(%arg0, %2) : (!spirv.ptr<i32, Function>, i32) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

