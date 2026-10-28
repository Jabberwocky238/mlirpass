"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{built_in = "WorkgroupSize", sym_name = "__builtin_var_WorkgroupSize__", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
    "spirv.GlobalVariable"() <{built_in = "NumWorkgroups", sym_name = "__builtin_var_NumWorkgroups__", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
    "spirv.GlobalVariable"() <{built_in = "LocalInvocationId", sym_name = "__builtin_var_LocalInvocationId__", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
    "spirv.GlobalVariable"() <{built_in = "WorkgroupId", sym_name = "__builtin_var_WorkgroupId__", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
    "spirv.func"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3), StorageBuffer>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 4), StorageBuffer>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 5), StorageBuffer>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 6), StorageBuffer>}], function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32>>)>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32>>)>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32>>)>, StorageBuffer>, i32, i32, i32, i32) -> (), sym_name = "load_store_kernel"}> ({
    ^bb0(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32>>)>, StorageBuffer>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32>>)>, StorageBuffer>, %arg2: !spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32>>)>, StorageBuffer>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32):
      %0 = "spirv.mlir.addressof"() <{variable = @__builtin_var_WorkgroupId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %1 = "spirv.Load"(%0) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %2 = "spirv.CompositeExtract"(%1) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
      %3 = "spirv.mlir.addressof"() <{variable = @__builtin_var_WorkgroupId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %4 = "spirv.Load"(%3) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %5 = "spirv.CompositeExtract"(%4) <{indices = [1 : i32]}> : (vector<3xi32>) -> i32
      %6 = "spirv.mlir.addressof"() <{variable = @__builtin_var_WorkgroupId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %7 = "spirv.Load"(%6) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %8 = "spirv.CompositeExtract"(%7) <{indices = [2 : i32]}> : (vector<3xi32>) -> i32
      %9 = "spirv.mlir.addressof"() <{variable = @__builtin_var_LocalInvocationId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %10 = "spirv.Load"(%9) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %11 = "spirv.CompositeExtract"(%10) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
      %12 = "spirv.mlir.addressof"() <{variable = @__builtin_var_LocalInvocationId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %13 = "spirv.Load"(%12) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %14 = "spirv.CompositeExtract"(%13) <{indices = [1 : i32]}> : (vector<3xi32>) -> i32
      %15 = "spirv.mlir.addressof"() <{variable = @__builtin_var_LocalInvocationId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %16 = "spirv.Load"(%15) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %17 = "spirv.CompositeExtract"(%16) <{indices = [2 : i32]}> : (vector<3xi32>) -> i32
      %18 = "spirv.mlir.addressof"() <{variable = @__builtin_var_NumWorkgroups__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %19 = "spirv.Load"(%18) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %20 = "spirv.CompositeExtract"(%19) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
      %21 = "spirv.mlir.addressof"() <{variable = @__builtin_var_NumWorkgroups__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %22 = "spirv.Load"(%21) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %23 = "spirv.CompositeExtract"(%22) <{indices = [1 : i32]}> : (vector<3xi32>) -> i32
      %24 = "spirv.mlir.addressof"() <{variable = @__builtin_var_NumWorkgroups__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %25 = "spirv.Load"(%24) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %26 = "spirv.CompositeExtract"(%25) <{indices = [2 : i32]}> : (vector<3xi32>) -> i32
      %27 = "spirv.mlir.addressof"() <{variable = @__builtin_var_WorkgroupSize__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %28 = "spirv.Load"(%27) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %29 = "spirv.CompositeExtract"(%28) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
      %30 = "spirv.mlir.addressof"() <{variable = @__builtin_var_WorkgroupSize__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %31 = "spirv.Load"(%30) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %32 = "spirv.CompositeExtract"(%31) <{indices = [1 : i32]}> : (vector<3xi32>) -> i32
      %33 = "spirv.mlir.addressof"() <{variable = @__builtin_var_WorkgroupSize__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %34 = "spirv.Load"(%33) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %35 = "spirv.CompositeExtract"(%34) <{indices = [2 : i32]}> : (vector<3xi32>) -> i32
      %36 = "spirv.IAdd"(%arg3, %2) : (i32, i32) -> i32
      %37 = "spirv.IAdd"(%arg4, %11) : (i32, i32) -> i32
      %38 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %39 = "spirv.AccessChain"(%arg0, %38, %36, %37) : (!spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32>>)>, StorageBuffer>, i32, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %40 = "spirv.Load"(%39) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %41 = "spirv.AccessChain"(%arg1, %38, %36, %37) : (!spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32>>)>, StorageBuffer>, i32, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %42 = "spirv.Load"(%41) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %43 = "spirv.FAdd"(%40, %42) : (f32, f32) -> f32
      %44 = "spirv.AccessChain"(%arg2, %38, %36, %37) : (!spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32>>)>, StorageBuffer>, i32, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      "spirv.Store"(%44, %43) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 1, 1]>} : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

