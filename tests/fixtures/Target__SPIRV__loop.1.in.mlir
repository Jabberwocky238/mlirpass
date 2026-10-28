"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "GV1", type = !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "GV2", type = !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>}> : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "loop_kernel"}> ({
    %0 = "spirv.mlir.addressof"() <{variable = @GV1}> : () -> !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>
    %1 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %2 = "spirv.AccessChain"(%0, %1) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32) -> !spirv.ptr<!spirv.array<10 x f32, stride=4>, StorageBuffer>
    %3 = "spirv.mlir.addressof"() <{variable = @GV2}> : () -> !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>
    %4 = "spirv.AccessChain"(%3, %1) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32) -> !spirv.ptr<!spirv.array<10 x f32, stride=4>, StorageBuffer>
    %5 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %6 = "spirv.Constant"() <{value = 42 : i32}> : () -> i32
    %7 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      "spirv.Branch"(%5)[^bb1] : (i32) -> ()
    ^bb1(%8: i32):  // 2 preds: ^bb0, ^bb2
      %9 = "spirv.SLessThan"(%8, %6) : (i32, i32) -> i1
      "spirv.BranchConditional"(%9)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      %10 = "spirv.AccessChain"(%2, %8) : (!spirv.ptr<!spirv.array<10 x f32, stride=4>, StorageBuffer>, i32) -> !spirv.ptr<f32, StorageBuffer>
      %11 = "spirv.Load"(%10) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %12 = "spirv.AccessChain"(%4, %8) : (!spirv.ptr<!spirv.array<10 x f32, stride=4>, StorageBuffer>, i32) -> !spirv.ptr<f32, StorageBuffer>
      "spirv.Store"(%12, %11) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
      %13 = "spirv.IAdd"(%8, %7) : (i32, i32) -> i32
      "spirv.Branch"(%13)[^bb1] : (i32) -> ()
    ^bb3:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<GLCompute>, fn = @loop_kernel, interface = []}> : () -> ()
  "spirv.ExecutionMode"() <{execution_mode = #spirv.execution_mode<LocalSize>, fn = @loop_kernel, values = [1 : i32, 1 : i32, 1 : i32]}> : () -> ()
}) : () -> ()

