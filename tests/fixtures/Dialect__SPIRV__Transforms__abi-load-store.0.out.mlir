module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
  spirv.module Logical GLSL450 {
    spirv.GlobalVariable @__builtin_var_WorkgroupSize__ built_in("WorkgroupSize") : !spirv.ptr<vector<3xi32>, Input>
    spirv.GlobalVariable @__builtin_var_NumWorkgroups__ built_in("NumWorkgroups") : !spirv.ptr<vector<3xi32>, Input>
    spirv.GlobalVariable @__builtin_var_LocalInvocationId__ built_in("LocalInvocationId") : !spirv.ptr<vector<3xi32>, Input>
    spirv.GlobalVariable @__builtin_var_WorkgroupId__ built_in("WorkgroupId") : !spirv.ptr<vector<3xi32>, Input>
    spirv.GlobalVariable @load_store_kernel_arg_0 bind(0, 0) : !spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32, stride=4>, stride=16> [0])>, StorageBuffer>
    spirv.GlobalVariable @load_store_kernel_arg_1 bind(0, 1) : !spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32, stride=4>, stride=16> [0])>, StorageBuffer>
    spirv.GlobalVariable @load_store_kernel_arg_2 bind(0, 2) : !spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32, stride=4>, stride=16> [0])>, StorageBuffer>
    spirv.GlobalVariable @load_store_kernel_arg_3 bind(0, 3) : !spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>
    spirv.GlobalVariable @load_store_kernel_arg_4 bind(0, 4) : !spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>
    spirv.GlobalVariable @load_store_kernel_arg_5 bind(0, 5) : !spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>
    spirv.GlobalVariable @load_store_kernel_arg_6 bind(0, 6) : !spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>
    spirv.func @load_store_kernel() "None" {
      %load_store_kernel_arg_0_addr = spirv.mlir.addressof @load_store_kernel_arg_0 : !spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32, stride=4>, stride=16> [0])>, StorageBuffer>
      %0 = spirv.Bitcast %load_store_kernel_arg_0_addr : !spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32, stride=4>, stride=16> [0])>, StorageBuffer> to !spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32>>)>, StorageBuffer>
      %load_store_kernel_arg_1_addr = spirv.mlir.addressof @load_store_kernel_arg_1 : !spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32, stride=4>, stride=16> [0])>, StorageBuffer>
      %1 = spirv.Bitcast %load_store_kernel_arg_1_addr : !spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32, stride=4>, stride=16> [0])>, StorageBuffer> to !spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32>>)>, StorageBuffer>
      %load_store_kernel_arg_2_addr = spirv.mlir.addressof @load_store_kernel_arg_2 : !spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32, stride=4>, stride=16> [0])>, StorageBuffer>
      %2 = spirv.Bitcast %load_store_kernel_arg_2_addr : !spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32, stride=4>, stride=16> [0])>, StorageBuffer> to !spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32>>)>, StorageBuffer>
      %load_store_kernel_arg_3_addr = spirv.mlir.addressof @load_store_kernel_arg_3 : !spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>
      %cst0_i32 = spirv.Constant 0 : i32
      %3 = spirv.AccessChain %load_store_kernel_arg_3_addr[%cst0_i32] : !spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>, i32 -> !spirv.ptr<i32, StorageBuffer>
      %4 = spirv.Load "StorageBuffer" %3 : i32
      %load_store_kernel_arg_4_addr = spirv.mlir.addressof @load_store_kernel_arg_4 : !spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>
      %cst0_i32_0 = spirv.Constant 0 : i32
      %5 = spirv.AccessChain %load_store_kernel_arg_4_addr[%cst0_i32_0] : !spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>, i32 -> !spirv.ptr<i32, StorageBuffer>
      %6 = spirv.Load "StorageBuffer" %5 : i32
      %load_store_kernel_arg_5_addr = spirv.mlir.addressof @load_store_kernel_arg_5 : !spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>
      %cst0_i32_1 = spirv.Constant 0 : i32
      %7 = spirv.AccessChain %load_store_kernel_arg_5_addr[%cst0_i32_1] : !spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>, i32 -> !spirv.ptr<i32, StorageBuffer>
      %8 = spirv.Load "StorageBuffer" %7 : i32
      %load_store_kernel_arg_6_addr = spirv.mlir.addressof @load_store_kernel_arg_6 : !spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>
      %cst0_i32_2 = spirv.Constant 0 : i32
      %9 = spirv.AccessChain %load_store_kernel_arg_6_addr[%cst0_i32_2] : !spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>, i32 -> !spirv.ptr<i32, StorageBuffer>
      %10 = spirv.Load "StorageBuffer" %9 : i32
      %__builtin_var_WorkgroupId___addr = spirv.mlir.addressof @__builtin_var_WorkgroupId__ : !spirv.ptr<vector<3xi32>, Input>
      %11 = spirv.Load "Input" %__builtin_var_WorkgroupId___addr : vector<3xi32>
      %12 = spirv.CompositeExtract %11[0 : i32] : vector<3xi32>
      %__builtin_var_WorkgroupId___addr_3 = spirv.mlir.addressof @__builtin_var_WorkgroupId__ : !spirv.ptr<vector<3xi32>, Input>
      %13 = spirv.Load "Input" %__builtin_var_WorkgroupId___addr_3 : vector<3xi32>
      %14 = spirv.CompositeExtract %13[1 : i32] : vector<3xi32>
      %__builtin_var_WorkgroupId___addr_4 = spirv.mlir.addressof @__builtin_var_WorkgroupId__ : !spirv.ptr<vector<3xi32>, Input>
      %15 = spirv.Load "Input" %__builtin_var_WorkgroupId___addr_4 : vector<3xi32>
      %16 = spirv.CompositeExtract %15[2 : i32] : vector<3xi32>
      %__builtin_var_LocalInvocationId___addr = spirv.mlir.addressof @__builtin_var_LocalInvocationId__ : !spirv.ptr<vector<3xi32>, Input>
      %17 = spirv.Load "Input" %__builtin_var_LocalInvocationId___addr : vector<3xi32>
      %18 = spirv.CompositeExtract %17[0 : i32] : vector<3xi32>
      %__builtin_var_LocalInvocationId___addr_5 = spirv.mlir.addressof @__builtin_var_LocalInvocationId__ : !spirv.ptr<vector<3xi32>, Input>
      %19 = spirv.Load "Input" %__builtin_var_LocalInvocationId___addr_5 : vector<3xi32>
      %20 = spirv.CompositeExtract %19[1 : i32] : vector<3xi32>
      %__builtin_var_LocalInvocationId___addr_6 = spirv.mlir.addressof @__builtin_var_LocalInvocationId__ : !spirv.ptr<vector<3xi32>, Input>
      %21 = spirv.Load "Input" %__builtin_var_LocalInvocationId___addr_6 : vector<3xi32>
      %22 = spirv.CompositeExtract %21[2 : i32] : vector<3xi32>
      %__builtin_var_NumWorkgroups___addr = spirv.mlir.addressof @__builtin_var_NumWorkgroups__ : !spirv.ptr<vector<3xi32>, Input>
      %23 = spirv.Load "Input" %__builtin_var_NumWorkgroups___addr : vector<3xi32>
      %24 = spirv.CompositeExtract %23[0 : i32] : vector<3xi32>
      %__builtin_var_NumWorkgroups___addr_7 = spirv.mlir.addressof @__builtin_var_NumWorkgroups__ : !spirv.ptr<vector<3xi32>, Input>
      %25 = spirv.Load "Input" %__builtin_var_NumWorkgroups___addr_7 : vector<3xi32>
      %26 = spirv.CompositeExtract %25[1 : i32] : vector<3xi32>
      %__builtin_var_NumWorkgroups___addr_8 = spirv.mlir.addressof @__builtin_var_NumWorkgroups__ : !spirv.ptr<vector<3xi32>, Input>
      %27 = spirv.Load "Input" %__builtin_var_NumWorkgroups___addr_8 : vector<3xi32>
      %28 = spirv.CompositeExtract %27[2 : i32] : vector<3xi32>
      %__builtin_var_WorkgroupSize___addr = spirv.mlir.addressof @__builtin_var_WorkgroupSize__ : !spirv.ptr<vector<3xi32>, Input>
      %29 = spirv.Load "Input" %__builtin_var_WorkgroupSize___addr : vector<3xi32>
      %30 = spirv.CompositeExtract %29[0 : i32] : vector<3xi32>
      %__builtin_var_WorkgroupSize___addr_9 = spirv.mlir.addressof @__builtin_var_WorkgroupSize__ : !spirv.ptr<vector<3xi32>, Input>
      %31 = spirv.Load "Input" %__builtin_var_WorkgroupSize___addr_9 : vector<3xi32>
      %32 = spirv.CompositeExtract %31[1 : i32] : vector<3xi32>
      %__builtin_var_WorkgroupSize___addr_10 = spirv.mlir.addressof @__builtin_var_WorkgroupSize__ : !spirv.ptr<vector<3xi32>, Input>
      %33 = spirv.Load "Input" %__builtin_var_WorkgroupSize___addr_10 : vector<3xi32>
      %34 = spirv.CompositeExtract %33[2 : i32] : vector<3xi32>
      %35 = spirv.IAdd %4, %12 : i32
      %36 = spirv.IAdd %6, %18 : i32
      %cst0_i32_11 = spirv.Constant 0 : i32
      %37 = spirv.AccessChain %0[%cst0_i32_11, %35, %36] : !spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32>>)>, StorageBuffer>, i32, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %38 = spirv.Load "StorageBuffer" %37 : f32
      %39 = spirv.AccessChain %1[%cst0_i32_11, %35, %36] : !spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32>>)>, StorageBuffer>, i32, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %40 = spirv.Load "StorageBuffer" %39 : f32
      %41 = spirv.FAdd %38, %40 : f32
      %42 = spirv.AccessChain %2[%cst0_i32_11, %35, %36] : !spirv.ptr<!spirv.struct<(!spirv.array<12 x !spirv.array<4 x f32>>)>, StorageBuffer>, i32, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      spirv.Store "StorageBuffer" %42, %41 : f32
      spirv.Return
    }
    spirv.EntryPoint "GLCompute" @load_store_kernel, @__builtin_var_WorkgroupId__, @__builtin_var_LocalInvocationId__, @__builtin_var_NumWorkgroups__, @__builtin_var_WorkgroupSize__
    spirv.ExecutionMode @load_store_kernel "LocalSize", 32, 1, 1
  }
}

