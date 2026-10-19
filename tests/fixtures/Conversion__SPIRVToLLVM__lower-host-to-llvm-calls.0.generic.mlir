"builtin.module"() ({
  "llvm.mlir.global"() <{addr_space = 0 : i32, global_type = !llvm.struct<(array<6 x i32>)>, linkage = #llvm.linkage<linkonce>, sym_name = "__spv__foo_bar_arg_0_descriptor_set0_binding0", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "__spv__foo_bar", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64)>, linkage = #llvm.linkage<external>, sym_name = "malloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__foo", vce_triple = #spirv.vce<v1.0, [Shader], [SPV_KHR_variable_pointers]>}> ({
    "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "bar_arg_0", type = !spirv.ptr<!spirv.struct<(!spirv.array<6 x i32, stride=4> [0])>, StorageBuffer>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "__spv__foo_bar"}> ({
      %21 = "spirv.mlir.addressof"() <{variable = @bar_arg_0}> : () -> !spirv.ptr<!spirv.struct<(!spirv.array<6 x i32, stride=4> [0])>, StorageBuffer>
      "spirv.Return"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : () -> ()
    "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<GLCompute>, fn = @__spv__foo_bar, interface = []}> : () -> ()
    "spirv.ExecutionMode"() <{execution_mode = #spirv.execution_mode<LocalSize>, fn = @__spv__foo_bar, values = [1 : i32, 1 : i32, 1 : i32]}> : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 6 : index}> : () -> i64
    %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %3 = "llvm.getelementptr"(%2, %0) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
    %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %6 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %13 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %14 = "llvm.mlir.constant"() <{value = 6 : index}> : () -> i64
    %15 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %16 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %17 = "llvm.getelementptr"(%16, %14) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %18 = "llvm.ptrtoint"(%17) : (!llvm.ptr) -> i64
    %19 = "llvm.extractvalue"(%12) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %20 = "llvm.mlir.addressof"() <{global_name = @__spv__foo_bar_arg_0_descriptor_set0_binding0}> : () -> !llvm.ptr
    "llvm.intr.memcpy"(%20, %19, %18) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__spv__foo_bar, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
    "llvm.intr.memcpy"(%19, %20, %18) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    "llvm.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_main", visibility_ = 0 : i64}> ({
    "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @main, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
    "llvm.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_variable_pointers]>, #spirv.resource_limits<max_compute_workgroup_size = [128, 128, 64]>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "spirv.sym"}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "spirv.sym_bar"}> ({
      "spirv.Return"() : () -> ()
    }) : () -> ()
    "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<GLCompute>, fn = @spirv.sym_bar, interface = []}> : () -> ()
    "spirv.ExecutionMode"() <{execution_mode = #spirv.execution_mode<LocalSize>, fn = @spirv.sym_bar, values = [1 : i32, 1 : i32, 1 : i32]}> : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "__spv___bar"}> ({
      "spirv.Return"() : () -> ()
    }) : () -> ()
    "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<GLCompute>, fn = @__spv___bar, interface = []}> : () -> ()
    "spirv.ExecutionMode"() <{execution_mode = #spirv.execution_mode<LocalSize>, fn = @__spv___bar, values = [1 : i32, 1 : i32, 1 : i32]}> : () -> ()
  }) : () -> ()
}) : () -> ()

