"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{built_in = "WorkgroupSize", sym_name = "__builtin_var_WorkgroupSize__", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
    "spirv.GlobalVariable"() <{built_in = "NumWorkgroups", sym_name = "__builtin_var_NumWorkgroups__", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
    "spirv.GlobalVariable"() <{built_in = "LocalInvocationId", sym_name = "__builtin_var_LocalInvocationId__", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
    "spirv.GlobalVariable"() <{built_in = "WorkgroupId", sym_name = "__builtin_var_WorkgroupId__", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
    "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "load_store_kernel_arg_0", type = !spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32, stride=4>, stride=16> [0])>, StorageBuffer>}> : () -> ()
    "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "load_store_kernel_arg_1", type = !spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32, stride=4>, stride=16> [0])>, StorageBuffer>}> : () -> ()
    "spirv.GlobalVariable"() <{binding = 2 : i32, descriptor_set = 0 : i32, sym_name = "load_store_kernel_arg_2", type = !spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32, stride=4>, stride=16> [0])>, StorageBuffer>}> : () -> ()
    "spirv.GlobalVariable"() <{binding = 3 : i32, descriptor_set = 0 : i32, sym_name = "load_store_kernel_arg_3", type = !spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>}> : () -> ()
    "spirv.GlobalVariable"() <{binding = 4 : i32, descriptor_set = 0 : i32, sym_name = "load_store_kernel_arg_4", type = !spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>}> : () -> ()
    "spirv.GlobalVariable"() <{binding = 5 : i32, descriptor_set = 0 : i32, sym_name = "load_store_kernel_arg_5", type = !spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>}> : () -> ()
    "spirv.GlobalVariable"() <{binding = 6 : i32, descriptor_set = 0 : i32, sym_name = "load_store_kernel_arg_6", type = !spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "load_store_kernel"}> ({
      %0 = "spirv.mlir.addressof"() <{variable = @load_store_kernel_arg_0}> : () -> !spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32, stride=4>, stride=16> [0])>, StorageBuffer>
      %1 = "spirv.Bitcast"(%0) : (!spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32, stride=4>, stride=16> [0])>, StorageBuffer>) -> !spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32>>)>, StorageBuffer>
      %2 = "spirv.mlir.addressof"() <{variable = @load_store_kernel_arg_1}> : () -> !spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32, stride=4>, stride=16> [0])>, StorageBuffer>
      %3 = "spirv.Bitcast"(%2) : (!spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32, stride=4>, stride=16> [0])>, StorageBuffer>) -> !spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32>>)>, StorageBuffer>
      %4 = "spirv.mlir.addressof"() <{variable = @load_store_kernel_arg_2}> : () -> !spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32, stride=4>, stride=16> [0])>, StorageBuffer>
      %5 = "spirv.Bitcast"(%4) : (!spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32, stride=4>, stride=16> [0])>, StorageBuffer>) -> !spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32>>)>, StorageBuffer>
      %6 = "spirv.mlir.addressof"() <{variable = @load_store_kernel_arg_3}> : () -> !spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>
      %7 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %8 = "spirv.AccessChain"(%6, %7) : (!spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>, i32) -> !spirv.ptr<i32, StorageBuffer>
      %9 = "spirv.Load"(%8) : (!spirv.ptr<i32, StorageBuffer>) -> i32
      %10 = "spirv.mlir.addressof"() <{variable = @load_store_kernel_arg_4}> : () -> !spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>
      %11 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %12 = "spirv.AccessChain"(%10, %11) : (!spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>, i32) -> !spirv.ptr<i32, StorageBuffer>
      %13 = "spirv.Load"(%12) : (!spirv.ptr<i32, StorageBuffer>) -> i32
      %14 = "spirv.mlir.addressof"() <{variable = @load_store_kernel_arg_5}> : () -> !spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>
      %15 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %16 = "spirv.AccessChain"(%14, %15) : (!spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>, i32) -> !spirv.ptr<i32, StorageBuffer>
      %17 = "spirv.Load"(%16) : (!spirv.ptr<i32, StorageBuffer>) -> i32
      %18 = "spirv.mlir.addressof"() <{variable = @load_store_kernel_arg_6}> : () -> !spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>
      %19 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %20 = "spirv.AccessChain"(%18, %19) : (!spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>, i32) -> !spirv.ptr<i32, StorageBuffer>
      %21 = "spirv.Load"(%20) : (!spirv.ptr<i32, StorageBuffer>) -> i32
      %22 = "spirv.mlir.addressof"() <{variable = @__builtin_var_WorkgroupId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %23 = "spirv.Load"(%22) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %24 = "spirv.CompositeExtract"(%23) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
      %25 = "spirv.mlir.addressof"() <{variable = @__builtin_var_WorkgroupId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %26 = "spirv.Load"(%25) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %27 = "spirv.CompositeExtract"(%26) <{indices = [1 : i32]}> : (vector<3xi32>) -> i32
      %28 = "spirv.mlir.addressof"() <{variable = @__builtin_var_WorkgroupId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %29 = "spirv.Load"(%28) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %30 = "spirv.CompositeExtract"(%29) <{indices = [2 : i32]}> : (vector<3xi32>) -> i32
      %31 = "spirv.mlir.addressof"() <{variable = @__builtin_var_LocalInvocationId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %32 = "spirv.Load"(%31) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %33 = "spirv.CompositeExtract"(%32) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
      %34 = "spirv.mlir.addressof"() <{variable = @__builtin_var_LocalInvocationId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %35 = "spirv.Load"(%34) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %36 = "spirv.CompositeExtract"(%35) <{indices = [1 : i32]}> : (vector<3xi32>) -> i32
      %37 = "spirv.mlir.addressof"() <{variable = @__builtin_var_LocalInvocationId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %38 = "spirv.Load"(%37) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %39 = "spirv.CompositeExtract"(%38) <{indices = [2 : i32]}> : (vector<3xi32>) -> i32
      %40 = "spirv.mlir.addressof"() <{variable = @__builtin_var_NumWorkgroups__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %41 = "spirv.Load"(%40) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %42 = "spirv.CompositeExtract"(%41) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
      %43 = "spirv.mlir.addressof"() <{variable = @__builtin_var_NumWorkgroups__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %44 = "spirv.Load"(%43) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %45 = "spirv.CompositeExtract"(%44) <{indices = [1 : i32]}> : (vector<3xi32>) -> i32
      %46 = "spirv.mlir.addressof"() <{variable = @__builtin_var_NumWorkgroups__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %47 = "spirv.Load"(%46) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %48 = "spirv.CompositeExtract"(%47) <{indices = [2 : i32]}> : (vector<3xi32>) -> i32
      %49 = "spirv.mlir.addressof"() <{variable = @__builtin_var_WorkgroupSize__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %50 = "spirv.Load"(%49) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %51 = "spirv.CompositeExtract"(%50) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
      %52 = "spirv.mlir.addressof"() <{variable = @__builtin_var_WorkgroupSize__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %53 = "spirv.Load"(%52) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %54 = "spirv.CompositeExtract"(%53) <{indices = [1 : i32]}> : (vector<3xi32>) -> i32
      %55 = "spirv.mlir.addressof"() <{variable = @__builtin_var_WorkgroupSize__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %56 = "spirv.Load"(%55) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %57 = "spirv.CompositeExtract"(%56) <{indices = [2 : i32]}> : (vector<3xi32>) -> i32
      %58 = "spirv.IAdd"(%9, %24) : (i32, i32) -> i32
      %59 = "spirv.IAdd"(%13, %33) : (i32, i32) -> i32
      %60 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %61 = "spirv.AccessChain"(%1, %60, %58, %59) : (!spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32>>)>, StorageBuffer>, i32, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %62 = "spirv.Load"(%61) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %63 = "spirv.AccessChain"(%3, %60, %58, %59) : (!spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32>>)>, StorageBuffer>, i32, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %64 = "spirv.Load"(%63) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %65 = "spirv.FAdd"(%62, %64) : (f32, f32) -> f32
      %66 = "spirv.AccessChain"(%5, %60, %58, %59) : (!spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32>>)>, StorageBuffer>, i32, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      "spirv.Store"(%66, %65) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
      "spirv.Return"() : () -> ()
    }) : () -> ()
    "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<GLCompute>, fn = @load_store_kernel, interface = [@__builtin_var_WorkgroupId__, @__builtin_var_LocalInvocationId__, @__builtin_var_NumWorkgroups__, @__builtin_var_WorkgroupSize__]}> : () -> ()
    "spirv.ExecutionMode"() <{execution_mode = #spirv.execution_mode<LocalSize>, fn = @load_store_kernel, values = [32 : i32, 1 : i32, 1 : i32]}> : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

