"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.func"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<512 x f32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "gpu_wmma_load_op"}> ({
    ^bb0(%arg43: !spirv.ptr<!spirv.struct<(!spirv.array<512 x f32, stride=4> [0])>, StorageBuffer>):
      %62 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %63 = "spirv.Constant"() <{value = 528 : i32}> : () -> i32
      %64 = "spirv.AccessChain"(%arg43, %62, %63) : (!spirv.ptr<!spirv.struct<(!spirv.array<512 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %65 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
      %66 = "spirv.KHR.CooperativeMatrixLoad"(%64, %65) <{matrix_layout = #spirv.coop_matrix_layout_khr<RowMajor>}> : (!spirv.ptr<f32, StorageBuffer>, i32) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %67 = "spirv.KHR.CooperativeMatrixLoad"(%64, %65) <{matrix_layout = #spirv.coop_matrix_layout_khr<ColumnMajor>}> : (!spirv.ptr<f32, StorageBuffer>, i32) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    "spirv.func"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<512 x f32, stride=4> [0])>, StorageBuffer>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>) -> (), sym_name = "gpu_wmma_store_op"}> ({
    ^bb0(%arg41: !spirv.ptr<!spirv.struct<(!spirv.array<512 x f32, stride=4> [0])>, StorageBuffer>, %arg42: !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>):
      %58 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %59 = "spirv.Constant"() <{value = 528 : i32}> : () -> i32
      %60 = "spirv.AccessChain"(%arg41, %58, %59) : (!spirv.ptr<!spirv.struct<(!spirv.array<512 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %61 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
      "spirv.KHR.CooperativeMatrixStore"(%60, %arg42, %61) <{matrix_layout = #spirv.coop_matrix_layout_khr<RowMajor>}> : (!spirv.ptr<f32, StorageBuffer>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, i32) -> ()
      "spirv.KHR.CooperativeMatrixStore"(%60, %arg42, %61) <{matrix_layout = #spirv.coop_matrix_layout_khr<ColumnMajor>}> : (!spirv.ptr<f32, StorageBuffer>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, i32) -> ()
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    "spirv.func"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3)>}], function_control = #spirv.function_control<None>, function_type = (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixA>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixB>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, !spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "gpu_wmma_mma_op"}> ({
    ^bb0(%arg37: !spirv.coopmatrix<16x16xf16, Subgroup, MatrixA>, %arg38: !spirv.coopmatrix<16x16xf16, Subgroup, MatrixB>, %arg39: !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, %arg40: !spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>):
      %54 = "spirv.KHR.CooperativeMatrixMulAdd"(%arg37, %arg38, %arg39) : (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixA>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixB>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %55 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %56 = "spirv.AccessChain"(%arg40, %55, %55) : (!spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %57 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
      "spirv.KHR.CooperativeMatrixStore"(%56, %54, %57) <{matrix_layout = #spirv.coop_matrix_layout_khr<RowMajor>}> : (!spirv.ptr<f32, StorageBuffer>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, i32) -> ()
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    "spirv.func"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "gpu_wmma_constant_op"}> ({
    ^bb0(%arg36: !spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>):
      %49 = "spirv.Constant"() <{value = 1.000000e+00 : f16}> : () -> f16
      %50 = "spirv.CompositeConstruct"(%49) : (f16) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %51 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %52 = "spirv.AccessChain"(%arg36, %51, %51) : (!spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %53 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
      "spirv.KHR.CooperativeMatrixStore"(%52, %50, %53) <{matrix_layout = #spirv.coop_matrix_layout_khr<RowMajor>}> : (!spirv.ptr<f32, StorageBuffer>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, i32) -> ()
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    "spirv.func"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], function_control = #spirv.function_control<None>, function_type = (!spirv.coopmatrix<16x16xf32, Subgroup, MatrixA>, !spirv.ptr<!spirv.struct<(!spirv.array<256 x f32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "gpu_wmma_extract_thread_local_op"}> ({
    ^bb0(%arg34: !spirv.coopmatrix<16x16xf32, Subgroup, MatrixA>, %arg35: !spirv.ptr<!spirv.struct<(!spirv.array<256 x f32, stride=4> [0])>, StorageBuffer>):
      %46 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %47 = "spirv.CompositeExtract"(%arg34) <{indices = [0 : i32]}> : (!spirv.coopmatrix<16x16xf32, Subgroup, MatrixA>) -> f32
      %48 = "spirv.AccessChain"(%arg35, %46, %46) : (!spirv.ptr<!spirv.struct<(!spirv.array<256 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      "spirv.Store"(%48, %47) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    "spirv.func"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0), StorageBuffer>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], function_control = #spirv.function_control<None>, function_type = (f16, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, !spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "gpu_wmma_insert_thread_local_op"}> ({
    ^bb0(%arg31: f16, %arg32: !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, %arg33: !spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>):
      %42 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %43 = "spirv.CompositeInsert"(%arg31, %arg32) <{indices = [0 : i32]}> : (f16, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %44 = "spirv.AccessChain"(%arg33, %42, %42) : (!spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %45 = "spirv.Constant"() <{value = 16 : i32}> : () -> i32
      "spirv.KHR.CooperativeMatrixStore"(%44, %43, %45) <{matrix_layout = #spirv.coop_matrix_layout_khr<RowMajor>}> : (!spirv.ptr<f32, StorageBuffer>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, i32) -> ()
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    "spirv.func"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], function_control = #spirv.function_control<None>, function_type = (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, !spirv.ptr<!spirv.struct<(!spirv.array<256 x f32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "gpu_wmma_elementwise_op_default"}> ({
    ^bb0(%arg28: !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, %arg29: !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, %arg30: !spirv.ptr<!spirv.struct<(!spirv.array<256 x f32, stride=4> [0])>, StorageBuffer>):
      %34 = "spirv.FAdd"(%arg28, %arg29) : (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %35 = "spirv.FNegate"(%34) : (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %36 = "spirv.FDiv"(%35, %arg28) : (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %37 = "spirv.FMul"(%36, %arg28) : (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %38 = "spirv.FConvert"(%37) : (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>) -> !spirv.coopmatrix<16x16xf32, Subgroup, MatrixAcc>
      %39 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %40 = "spirv.AccessChain"(%arg30, %39, %39) : (!spirv.ptr<!spirv.struct<(!spirv.array<256 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %41 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
      "spirv.KHR.CooperativeMatrixStore"(%40, %38, %41) <{matrix_layout = #spirv.coop_matrix_layout_khr<RowMajor>}> : (!spirv.ptr<f32, StorageBuffer>, !spirv.coopmatrix<16x16xf32, Subgroup, MatrixAcc>, i32) -> ()
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    "spirv.func"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1), StorageBuffer>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], function_control = #spirv.function_control<None>, function_type = (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, f16, !spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "gpu_wmma_elementwise_op_matrix_times_scalar"}> ({
    ^bb0(%arg25: !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, %arg26: f16, %arg27: !spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>):
      %29 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %30 = "spirv.MatrixTimesScalar"(%arg25, %arg26) : (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, f16) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %31 = "spirv.AccessChain"(%arg27, %29, %29) : (!spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %32 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
      "spirv.KHR.CooperativeMatrixStore"(%31, %30, %32) <{matrix_layout = #spirv.coop_matrix_layout_khr<RowMajor>}> : (!spirv.ptr<f32, StorageBuffer>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, i32) -> ()
      %33 = "spirv.MatrixTimesScalar"(%30, %arg26) : (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, f16) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      "spirv.KHR.CooperativeMatrixStore"(%31, %33, %32) <{matrix_layout = #spirv.coop_matrix_layout_khr<RowMajor>}> : (!spirv.ptr<f32, StorageBuffer>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, i32) -> ()
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    "spirv.func"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1), StorageBuffer>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], function_control = #spirv.function_control<None>, function_type = (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, f16, !spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "gpu_wmma_elementwise_op_matrix_plus_scalar"}> ({
    ^bb0(%arg22: !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, %arg23: f16, %arg24: !spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>):
      %24 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %25 = "spirv.CompositeConstruct"(%arg23) : (f16) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %26 = "spirv.FAdd"(%arg22, %25) : (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %27 = "spirv.AccessChain"(%arg24, %24, %24) : (!spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %28 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
      "spirv.KHR.CooperativeMatrixStore"(%27, %26, %28) <{matrix_layout = #spirv.coop_matrix_layout_khr<RowMajor>}> : (!spirv.ptr<f32, StorageBuffer>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, i32) -> ()
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (memref<32x32xf16, #spirv.storage_class<StorageBuffer>>) -> ()}> ({
    ^bb0(%arg21: memref<32x32xf16, #spirv.storage_class<StorageBuffer>>):
      %23 = "arith.constant"() <{value = 16 : index}> : () -> index
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_load_op", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (memref<32x32xf16, #spirv.storage_class<StorageBuffer>>, !gpu.mma_matrix<16x16xf16, "COp">) -> ()}> ({
    ^bb0(%arg19: memref<32x32xf16, #spirv.storage_class<StorageBuffer>>, %arg20: !gpu.mma_matrix<16x16xf16, "COp">):
      %22 = "arith.constant"() <{value = 16 : index}> : () -> index
      "gpu.subgroup_mma_store_matrix"(%arg20, %arg19, %22, %22) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<32x32xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.subgroup_mma_store_matrix"(%arg20, %arg19, %22, %22) <{leadDimension = 32 : index, transpose}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<32x32xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_store_op", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (!gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp">, !gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>) -> ()}> ({
    ^bb0(%arg15: !gpu.mma_matrix<16x16xf16, "AOp">, %arg16: !gpu.mma_matrix<16x16xf16, "BOp">, %arg17: !gpu.mma_matrix<16x16xf16, "COp">, %arg18: memref<16x16xf16, #spirv.storage_class<StorageBuffer>>):
      %20 = "gpu.subgroup_mma_compute"(%arg15, %arg16, %arg17) : (!gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      %21 = "arith.constant"() <{value = 0 : index}> : () -> index
      "gpu.subgroup_mma_store_matrix"(%20, %arg18, %21, %21) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_mma_op", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (memref<16x16xf16, #spirv.storage_class<StorageBuffer>>) -> ()}> ({
    ^bb0(%arg14: memref<16x16xf16, #spirv.storage_class<StorageBuffer>>):
      %17 = "arith.constant"() <{value = 1.000000e+00 : f16}> : () -> f16
      %18 = "gpu.subgroup_mma_constant_matrix"(%17) : (f16) -> !gpu.mma_matrix<16x16xf16, "COp">
      %19 = "arith.constant"() <{value = 0 : index}> : () -> index
      "gpu.subgroup_mma_store_matrix"(%18, %arg14, %19, %19) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_constant_op", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (!gpu.mma_matrix<16x16xf32, "AOp">, memref<16x16xf32, #spirv.storage_class<StorageBuffer>>) -> ()}> ({
    ^bb0(%arg12: !gpu.mma_matrix<16x16xf32, "AOp">, %arg13: memref<16x16xf32, #spirv.storage_class<StorageBuffer>>):
      %15 = "arith.constant"() <{value = 0 : index}> : () -> index
      %16 = "gpu.subgroup_mma_extract_thread_local"(%arg12, %15) : (!gpu.mma_matrix<16x16xf32, "AOp">, index) -> f32
      "memref.store"(%16, %arg13, %15, %15) : (f32, memref<16x16xf32, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_extract_thread_local_op", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (f16, !gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>) -> ()}> ({
    ^bb0(%arg9: f16, %arg10: !gpu.mma_matrix<16x16xf16, "COp">, %arg11: memref<16x16xf16, #spirv.storage_class<StorageBuffer>>):
      %13 = "arith.constant"() <{value = 0 : index}> : () -> index
      %14 = "gpu.subgroup_mma_insert_thread_local"(%arg9, %arg10, %13) : (f16, !gpu.mma_matrix<16x16xf16, "COp">, index) -> !gpu.mma_matrix<16x16xf16, "COp">
      "gpu.subgroup_mma_store_matrix"(%14, %arg11, %13, %13) <{leadDimension = 16 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_insert_thread_local_op", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf32, #spirv.storage_class<StorageBuffer>>) -> ()}> ({
    ^bb0(%arg6: !gpu.mma_matrix<16x16xf16, "COp">, %arg7: !gpu.mma_matrix<16x16xf16, "COp">, %arg8: memref<16x16xf32, #spirv.storage_class<StorageBuffer>>):
      %7 = "gpu.subgroup_mma_elementwise"(%arg6, %arg7) <{opType = #gpu<mma_element_wise addf>}> : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      %8 = "gpu.subgroup_mma_elementwise"(%7) <{opType = #gpu<mma_element_wise negatef>}> : (!gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      %9 = "gpu.subgroup_mma_elementwise"(%8, %arg6) <{opType = #gpu<mma_element_wise divf>}> : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      %10 = "gpu.subgroup_mma_elementwise"(%9, %arg6) <{opType = #gpu<mma_element_wise mulf>}> : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      %11 = "gpu.subgroup_mma_elementwise"(%10) <{opType = #gpu<mma_element_wise extf>}> : (!gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf32, "COp">
      %12 = "arith.constant"() <{value = 0 : index}> : () -> index
      "gpu.subgroup_mma_store_matrix"(%11, %arg8, %12, %12) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf32, "COp">, memref<16x16xf32, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_elementwise_op_default", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (!gpu.mma_matrix<16x16xf16, "COp">, f16, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>) -> ()}> ({
    ^bb0(%arg3: !gpu.mma_matrix<16x16xf16, "COp">, %arg4: f16, %arg5: memref<16x16xf16, #spirv.storage_class<StorageBuffer>>):
      %3 = "arith.constant"() <{value = 0 : index}> : () -> index
      %4 = "gpu.subgroup_mma_constant_matrix"(%arg4) : (f16) -> !gpu.mma_matrix<16x16xf16, "COp">
      %5 = "gpu.subgroup_mma_elementwise"(%arg3, %4) <{opType = #gpu<mma_element_wise mulf>}> : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      "gpu.subgroup_mma_store_matrix"(%5, %arg5, %3, %3) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      %6 = "gpu.subgroup_mma_elementwise"(%4, %5) <{opType = #gpu<mma_element_wise mulf>}> : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      "gpu.subgroup_mma_store_matrix"(%6, %arg5, %3, %3) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_elementwise_op_matrix_times_scalar", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (!gpu.mma_matrix<16x16xf16, "COp">, f16, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>) -> ()}> ({
    ^bb0(%arg0: !gpu.mma_matrix<16x16xf16, "COp">, %arg1: f16, %arg2: memref<16x16xf16, #spirv.storage_class<StorageBuffer>>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "gpu.subgroup_mma_constant_matrix"(%arg1) : (f16) -> !gpu.mma_matrix<16x16xf16, "COp">
      %2 = "gpu.subgroup_mma_elementwise"(%arg0, %1) <{opType = #gpu<mma_element_wise addf>}> : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      "gpu.subgroup_mma_store_matrix"(%2, %arg2, %0, %0) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_elementwise_op_matrix_plus_scalar", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.6, [Shader, CooperativeMatrixKHR, Float16], [SPV_KHR_storage_buffer_storage_class, SPV_KHR_cooperative_matrix]>, #spirv.resource_limits<>>} : () -> ()

