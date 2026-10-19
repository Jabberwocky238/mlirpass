"builtin.module"() ({
  "func.func"() <{function_type = (memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, memref<12x4xf32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_store"}> ({
  ^bb0(%arg14: memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, %arg15: memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, %arg16: memref<12x4xf32, #spirv.storage_class<StorageBuffer>>):
    %73 = "arith.constant"() <{value = 0 : index}> : () -> index
    %74 = "arith.constant"() <{value = 12 : index}> : () -> index
    %75 = "arith.subi"(%74, %73) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %76 = "arith.constant"() <{value = 1 : index}> : () -> index
    %77 = "arith.constant"() <{value = 0 : index}> : () -> index
    %78 = "arith.constant"() <{value = 4 : index}> : () -> index
    %79 = "arith.subi"(%78, %77) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %80 = "arith.constant"() <{value = 1 : index}> : () -> index
    %81 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch_func"(%75, %81, %81, %79, %81, %81, %arg14, %arg15, %arg16, %73, %77, %76, %80) <{kernel = @kernels::@load_store_kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 7, 0>}> : (index, index, index, index, index, index, memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.GlobalVariable"() <{built_in = "NumWorkgroups", sym_name = "__builtin__NumWorkgroups__", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
    "spirv.GlobalVariable"() <{built_in = "LocalInvocationId", sym_name = "__builtin__LocalInvocationId__", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
    "spirv.GlobalVariable"() <{built_in = "WorkgroupId", sym_name = "__builtin__WorkgroupId__", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
    "spirv.func"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3), StorageBuffer>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 4), StorageBuffer>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 5), StorageBuffer>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 6), StorageBuffer>}], function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<48 x f32, stride=4> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<48 x f32, stride=4> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<48 x f32, stride=4> [0])>, StorageBuffer>, i32, i32, i32, i32) -> (), sym_name = "load_store_kernel"}> ({
    ^bb0(%arg7: !spirv.ptr<!spirv.struct<(!spirv.array<48 x f32, stride=4> [0])>, StorageBuffer>, %arg8: !spirv.ptr<!spirv.struct<(!spirv.array<48 x f32, stride=4> [0])>, StorageBuffer>, %arg9: !spirv.ptr<!spirv.struct<(!spirv.array<48 x f32, stride=4> [0])>, StorageBuffer>, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32):
      %17 = "spirv.mlir.addressof"() <{variable = @__builtin__WorkgroupId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %18 = "spirv.Load"(%17) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %19 = "spirv.CompositeExtract"(%18) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
      %20 = "spirv.mlir.addressof"() <{variable = @__builtin__WorkgroupId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %21 = "spirv.Load"(%20) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %22 = "spirv.CompositeExtract"(%21) <{indices = [1 : i32]}> : (vector<3xi32>) -> i32
      %23 = "spirv.mlir.addressof"() <{variable = @__builtin__WorkgroupId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %24 = "spirv.Load"(%23) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %25 = "spirv.CompositeExtract"(%24) <{indices = [2 : i32]}> : (vector<3xi32>) -> i32
      %26 = "spirv.mlir.addressof"() <{variable = @__builtin__LocalInvocationId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %27 = "spirv.Load"(%26) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %28 = "spirv.CompositeExtract"(%27) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
      %29 = "spirv.mlir.addressof"() <{variable = @__builtin__LocalInvocationId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %30 = "spirv.Load"(%29) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %31 = "spirv.CompositeExtract"(%30) <{indices = [1 : i32]}> : (vector<3xi32>) -> i32
      %32 = "spirv.mlir.addressof"() <{variable = @__builtin__LocalInvocationId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %33 = "spirv.Load"(%32) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %34 = "spirv.CompositeExtract"(%33) <{indices = [2 : i32]}> : (vector<3xi32>) -> i32
      %35 = "spirv.mlir.addressof"() <{variable = @__builtin__NumWorkgroups__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %36 = "spirv.Load"(%35) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %37 = "spirv.CompositeExtract"(%36) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
      %38 = "spirv.mlir.addressof"() <{variable = @__builtin__NumWorkgroups__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %39 = "spirv.Load"(%38) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %40 = "spirv.CompositeExtract"(%39) <{indices = [1 : i32]}> : (vector<3xi32>) -> i32
      %41 = "spirv.mlir.addressof"() <{variable = @__builtin__NumWorkgroups__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %42 = "spirv.Load"(%41) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %43 = "spirv.CompositeExtract"(%42) <{indices = [2 : i32]}> : (vector<3xi32>) -> i32
      %44 = "spirv.Constant"() <{value = 16 : i32}> : () -> i32
      %45 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %46 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %47 = "spirv.IAdd"(%arg10, %19) : (i32, i32) -> i32
      %48 = "spirv.IAdd"(%arg11, %28) : (i32, i32) -> i32
      %49 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %50 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %51 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
      %52 = "spirv.IMul"(%47, %51) : (i32, i32) -> i32
      %53 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %54 = "spirv.IAdd"(%48, %52) : (i32, i32) -> i32
      %55 = "spirv.AccessChain"(%arg7, %49, %54) : (!spirv.ptr<!spirv.struct<(!spirv.array<48 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %56 = "spirv.Load"(%55) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %57 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %58 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %59 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
      %60 = "spirv.IMul"(%47, %59) : (i32, i32) -> i32
      %61 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %62 = "spirv.IAdd"(%48, %60) : (i32, i32) -> i32
      %63 = "spirv.AccessChain"(%arg8, %57, %62) : (!spirv.ptr<!spirv.struct<(!spirv.array<48 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %64 = "spirv.Load"(%63) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      %65 = "spirv.FAdd"(%56, %64) : (f32, f32) -> f32
      %66 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %67 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %68 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
      %69 = "spirv.IMul"(%47, %68) : (i32, i32) -> i32
      %70 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %71 = "spirv.IAdd"(%48, %69) : (i32, i32) -> i32
      %72 = "spirv.AccessChain"(%arg9, %66, %71) : (!spirv.ptr<!spirv.struct<(!spirv.array<48 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      "spirv.Store"(%72, %65) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, index, index, index, index) -> ()}> ({
    ^bb0(%arg0: memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, %arg1: memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, %arg2: memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, %arg3: index, %arg4: index, %arg5: index, %arg6: index):
      %0 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %2 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %3 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %4 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %5 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %6 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %7 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %8 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %9 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %10 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %11 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %12 = "arith.addi"(%arg3, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %13 = "arith.addi"(%arg4, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %14 = "memref.load"(%arg0, %12, %13) : (memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, index, index) -> f32
      %15 = "memref.load"(%arg1, %12, %13) : (memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, index, index) -> f32
      %16 = "arith.addf"(%14, %15) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "memref.store"(%16, %arg2, %12, %13) : (f32, memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "load_store_kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

