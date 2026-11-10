"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.func"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<512 x f32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "gpu_wmma_load_op"}> ({
    ^bb0(%arg51: !spirv.ptr<!spirv.struct<(!spirv.array<512 x f32, stride=4> [0])>, StorageBuffer>):
      %70 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %71 = "spirv.Constant"() <{value = 528 : i32}> : () -> i32
      %72 = "spirv.AccessChain"(%arg51, %70, %71) : (!spirv.ptr<!spirv.struct<(!spirv.array<512 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %73 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
      %74 = "spirv.KHR.CooperativeMatrixLoad"(%72, %73) <{matrix_layout = #spirv.coop_matrix_layout_khr<RowMajor>}> : (!spirv.ptr<f32, StorageBuffer>, i32) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %75 = "spirv.KHR.CooperativeMatrixLoad"(%72, %73) <{matrix_layout = #spirv.coop_matrix_layout_khr<ColumnMajor>}> : (!spirv.ptr<f32, StorageBuffer>, i32) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      "spirv.Return"() : () -> ()
    }) {kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>} : () -> ()
    "spirv.func"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<512 x f32, stride=4> [0])>, StorageBuffer>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>) -> (), sym_name = "gpu_wmma_store_op"}> ({
    ^bb0(%arg49: !spirv.ptr<!spirv.struct<(!spirv.array<512 x f32, stride=4> [0])>, StorageBuffer>, %arg50: !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>):
      %66 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %67 = "spirv.Constant"() <{value = 528 : i32}> : () -> i32
      %68 = "spirv.AccessChain"(%arg49, %66, %67) : (!spirv.ptr<!spirv.struct<(!spirv.array<512 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %69 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
      "spirv.KHR.CooperativeMatrixStore"(%68, %arg50, %69) <{matrix_layout = #spirv.coop_matrix_layout_khr<RowMajor>}> : (!spirv.ptr<f32, StorageBuffer>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, i32) -> ()
      "spirv.KHR.CooperativeMatrixStore"(%68, %arg50, %69) <{matrix_layout = #spirv.coop_matrix_layout_khr<ColumnMajor>}> : (!spirv.ptr<f32, StorageBuffer>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, i32) -> ()
      "spirv.Return"() : () -> ()
    }) {kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>} : () -> ()
    "spirv.func"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3)>}], function_control = #spirv.function_control<None>, function_type = (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixA>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixB>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, !spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "gpu_wmma_mma_op"}> ({
    ^bb0(%arg45: !spirv.coopmatrix<16x16xf16, Subgroup, MatrixA>, %arg46: !spirv.coopmatrix<16x16xf16, Subgroup, MatrixB>, %arg47: !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, %arg48: !spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>):
      %62 = "spirv.KHR.CooperativeMatrixMulAdd"(%arg45, %arg46, %arg47) : (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixA>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixB>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %63 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %64 = "spirv.AccessChain"(%arg48, %63, %63) : (!spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %65 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
      "spirv.KHR.CooperativeMatrixStore"(%64, %62, %65) <{matrix_layout = #spirv.coop_matrix_layout_khr<RowMajor>}> : (!spirv.ptr<f32, StorageBuffer>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, i32) -> ()
      "spirv.Return"() : () -> ()
    }) {kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>} : () -> ()
    "spirv.func"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3)>}], function_control = #spirv.function_control<None>, function_type = (!spirv.coopmatrix<16x16xsi8, Subgroup, MatrixA>, !spirv.coopmatrix<16x16xsi8, Subgroup, MatrixB>, !spirv.coopmatrix<16x16xi32, Subgroup, MatrixAcc>, !spirv.ptr<!spirv.struct<(!spirv.array<256 x i32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "gpu_wmma_signed_i8_mma_op"}> ({
    ^bb0(%arg41: !spirv.coopmatrix<16x16xsi8, Subgroup, MatrixA>, %arg42: !spirv.coopmatrix<16x16xsi8, Subgroup, MatrixB>, %arg43: !spirv.coopmatrix<16x16xi32, Subgroup, MatrixAcc>, %arg44: !spirv.ptr<!spirv.struct<(!spirv.array<256 x i32, stride=4> [0])>, StorageBuffer>):
      %58 = "spirv.KHR.CooperativeMatrixMulAdd"(%arg41, %arg42, %arg43) <{matrix_operands = #spirv.cooperative_matrix_operands_khr<ASigned|BSigned>}> : (!spirv.coopmatrix<16x16xsi8, Subgroup, MatrixA>, !spirv.coopmatrix<16x16xsi8, Subgroup, MatrixB>, !spirv.coopmatrix<16x16xi32, Subgroup, MatrixAcc>) -> !spirv.coopmatrix<16x16xi32, Subgroup, MatrixAcc>
      %59 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %60 = "spirv.AccessChain"(%arg44, %59, %59) : (!spirv.ptr<!spirv.struct<(!spirv.array<256 x i32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
      %61 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
      "spirv.KHR.CooperativeMatrixStore"(%60, %58, %61) <{matrix_layout = #spirv.coop_matrix_layout_khr<RowMajor>}> : (!spirv.ptr<i32, StorageBuffer>, !spirv.coopmatrix<16x16xi32, Subgroup, MatrixAcc>, i32) -> ()
      "spirv.Return"() : () -> ()
    }) {kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>} : () -> ()
    "spirv.func"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "gpu_wmma_constant_op"}> ({
    ^bb0(%arg40: !spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>):
      %53 = "spirv.Constant"() <{value = 1.000000e+00 : f16}> : () -> f16
      %54 = "spirv.CompositeConstruct"(%53) : (f16) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %55 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %56 = "spirv.AccessChain"(%arg40, %55, %55) : (!spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %57 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
      "spirv.KHR.CooperativeMatrixStore"(%56, %54, %57) <{matrix_layout = #spirv.coop_matrix_layout_khr<RowMajor>}> : (!spirv.ptr<f32, StorageBuffer>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, i32) -> ()
      "spirv.Return"() : () -> ()
    }) {kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>} : () -> ()
    "spirv.func"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], function_control = #spirv.function_control<None>, function_type = (!spirv.coopmatrix<16x16xf32, Subgroup, MatrixA>, !spirv.ptr<!spirv.struct<(!spirv.array<256 x f32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "gpu_wmma_extract_thread_local_op"}> ({
    ^bb0(%arg38: !spirv.coopmatrix<16x16xf32, Subgroup, MatrixA>, %arg39: !spirv.ptr<!spirv.struct<(!spirv.array<256 x f32, stride=4> [0])>, StorageBuffer>):
      %50 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %51 = "spirv.CompositeExtract"(%arg38) <{indices = [0 : i32]}> : (!spirv.coopmatrix<16x16xf32, Subgroup, MatrixA>) -> f32
      %52 = "spirv.AccessChain"(%arg39, %50, %50) : (!spirv.ptr<!spirv.struct<(!spirv.array<256 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      "spirv.Store"(%52, %51) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
      "spirv.Return"() : () -> ()
    }) {kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>} : () -> ()
    "spirv.func"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0), StorageBuffer>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], function_control = #spirv.function_control<None>, function_type = (f16, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, !spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "gpu_wmma_insert_thread_local_op"}> ({
    ^bb0(%arg35: f16, %arg36: !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, %arg37: !spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>):
      %46 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %47 = "spirv.CompositeInsert"(%arg35, %arg36) <{indices = [0 : i32]}> : (f16, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %48 = "spirv.AccessChain"(%arg37, %46, %46) : (!spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %49 = "spirv.Constant"() <{value = 16 : i32}> : () -> i32
      "spirv.KHR.CooperativeMatrixStore"(%48, %47, %49) <{matrix_layout = #spirv.coop_matrix_layout_khr<RowMajor>}> : (!spirv.ptr<f32, StorageBuffer>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, i32) -> ()
      "spirv.Return"() : () -> ()
    }) {kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>} : () -> ()
    "spirv.func"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], function_control = #spirv.function_control<None>, function_type = (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, !spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "gpu_wmma_elementwise_op_default"}> ({
    ^bb0(%arg32: !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, %arg33: !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, %arg34: !spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>):
      %37 = "spirv.FAdd"(%arg32, %arg33) : (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %38 = "spirv.FNegate"(%37) : (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %39 = "spirv.FDiv"(%38, %arg32) : (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %40 = "spirv.FMul"(%39, %arg32) : (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %41 = "spirv.FConvert"(%40) : (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>) -> !spirv.coopmatrix<16x16xf32, Subgroup, MatrixAcc>
      %42 = "spirv.FConvert"(%41) : (!spirv.coopmatrix<16x16xf32, Subgroup, MatrixAcc>) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %43 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %44 = "spirv.AccessChain"(%arg34, %43, %43) : (!spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %45 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
      "spirv.KHR.CooperativeMatrixStore"(%44, %42, %45) <{matrix_layout = #spirv.coop_matrix_layout_khr<RowMajor>}> : (!spirv.ptr<f32, StorageBuffer>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, i32) -> ()
      "spirv.Return"() : () -> ()
    }) {kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>} : () -> ()
    "spirv.func"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1), StorageBuffer>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], function_control = #spirv.function_control<None>, function_type = (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, f16, !spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "gpu_wmma_elementwise_op_matrix_times_scalar"}> ({
    ^bb0(%arg29: !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, %arg30: f16, %arg31: !spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>):
      %32 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %33 = "spirv.MatrixTimesScalar"(%arg29, %arg30) : (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, f16) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %34 = "spirv.AccessChain"(%arg31, %32, %32) : (!spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %35 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
      "spirv.KHR.CooperativeMatrixStore"(%34, %33, %35) <{matrix_layout = #spirv.coop_matrix_layout_khr<RowMajor>}> : (!spirv.ptr<f32, StorageBuffer>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, i32) -> ()
      %36 = "spirv.MatrixTimesScalar"(%33, %arg30) : (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, f16) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      "spirv.KHR.CooperativeMatrixStore"(%34, %36, %35) <{matrix_layout = #spirv.coop_matrix_layout_khr<RowMajor>}> : (!spirv.ptr<f32, StorageBuffer>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, i32) -> ()
      "spirv.Return"() : () -> ()
    }) {kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>} : () -> ()
    "spirv.func"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1), StorageBuffer>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], function_control = #spirv.function_control<None>, function_type = (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, f16, !spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "gpu_wmma_elementwise_op_matrix_plus_scalar"}> ({
    ^bb0(%arg26: !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, %arg27: f16, %arg28: !spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>):
      %27 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %28 = "spirv.CompositeConstruct"(%arg27) : (f16) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %29 = "spirv.FAdd"(%arg26, %28) : (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %30 = "spirv.AccessChain"(%arg28, %27, %27) : (!spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %31 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
      "spirv.KHR.CooperativeMatrixStore"(%30, %29, %31) <{matrix_layout = #spirv.coop_matrix_layout_khr<RowMajor>}> : (!spirv.ptr<f32, StorageBuffer>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, i32) -> ()
      "spirv.Return"() : () -> ()
    }) {kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (memref<32x32xf16, #spirv.storage_class<StorageBuffer>>) -> (), kernel}> ({
    ^bb0(%arg25: memref<32x32xf16, #spirv.storage_class<StorageBuffer>>):
      %26 = "arith.constant"() <{value = 16 : index}> : () -> index
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_load_op"} : () -> ()
    "gpu.func"() <{function_type = (memref<32x32xf16, #spirv.storage_class<StorageBuffer>>, !gpu.mma_matrix<16x16xf16, "COp">) -> (), kernel}> ({
    ^bb0(%arg23: memref<32x32xf16, #spirv.storage_class<StorageBuffer>>, %arg24: !gpu.mma_matrix<16x16xf16, "COp">):
      %25 = "arith.constant"() <{value = 16 : index}> : () -> index
      "gpu.subgroup_mma_store_matrix"(%arg24, %arg23, %25, %25) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<32x32xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.subgroup_mma_store_matrix"(%arg24, %arg23, %25, %25) <{leadDimension = 32 : index, transpose}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<32x32xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_store_op"} : () -> ()
    "gpu.func"() <{function_type = (!gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp">, !gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>) -> (), kernel}> ({
    ^bb0(%arg19: !gpu.mma_matrix<16x16xf16, "AOp">, %arg20: !gpu.mma_matrix<16x16xf16, "BOp">, %arg21: !gpu.mma_matrix<16x16xf16, "COp">, %arg22: memref<16x16xf16, #spirv.storage_class<StorageBuffer>>):
      %23 = "gpu.subgroup_mma_compute"(%arg19, %arg20, %arg21) : (!gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      %24 = "arith.constant"() <{value = 0 : index}> : () -> index
      "gpu.subgroup_mma_store_matrix"(%23, %arg22, %24, %24) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_mma_op"} : () -> ()
    "gpu.func"() <{function_type = (!gpu.mma_matrix<16x16xsi8, "AOp">, !gpu.mma_matrix<16x16xsi8, "BOp">, !gpu.mma_matrix<16x16xi32, "COp">, memref<16x16xi32, #spirv.storage_class<StorageBuffer>>) -> (), kernel}> ({
    ^bb0(%arg15: !gpu.mma_matrix<16x16xsi8, "AOp">, %arg16: !gpu.mma_matrix<16x16xsi8, "BOp">, %arg17: !gpu.mma_matrix<16x16xi32, "COp">, %arg18: memref<16x16xi32, #spirv.storage_class<StorageBuffer>>):
      %21 = "gpu.subgroup_mma_compute"(%arg15, %arg16, %arg17) : (!gpu.mma_matrix<16x16xsi8, "AOp">, !gpu.mma_matrix<16x16xsi8, "BOp">, !gpu.mma_matrix<16x16xi32, "COp">) -> !gpu.mma_matrix<16x16xi32, "COp">
      %22 = "arith.constant"() <{value = 0 : index}> : () -> index
      "gpu.subgroup_mma_store_matrix"(%21, %arg18, %22, %22) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xi32, "COp">, memref<16x16xi32, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_signed_i8_mma_op"} : () -> ()
    "gpu.func"() <{function_type = (memref<16x16xf16, #spirv.storage_class<StorageBuffer>>) -> (), kernel}> ({
    ^bb0(%arg14: memref<16x16xf16, #spirv.storage_class<StorageBuffer>>):
      %18 = "arith.constant"() <{value = 1.000000e+00 : f16}> : () -> f16
      %19 = "gpu.subgroup_mma_constant_matrix"(%18) : (f16) -> !gpu.mma_matrix<16x16xf16, "COp">
      %20 = "arith.constant"() <{value = 0 : index}> : () -> index
      "gpu.subgroup_mma_store_matrix"(%19, %arg14, %20, %20) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_constant_op"} : () -> ()
    "gpu.func"() <{function_type = (!gpu.mma_matrix<16x16xf32, "AOp">, memref<16x16xf32, #spirv.storage_class<StorageBuffer>>) -> (), kernel}> ({
    ^bb0(%arg12: !gpu.mma_matrix<16x16xf32, "AOp">, %arg13: memref<16x16xf32, #spirv.storage_class<StorageBuffer>>):
      %16 = "arith.constant"() <{value = 0 : index}> : () -> index
      %17 = "gpu.subgroup_mma_extract_thread_local"(%arg12, %16) : (!gpu.mma_matrix<16x16xf32, "AOp">, index) -> f32
      "memref.store"(%17, %arg13, %16, %16) : (f32, memref<16x16xf32, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_extract_thread_local_op"} : () -> ()
    "gpu.func"() <{function_type = (f16, !gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>) -> (), kernel}> ({
    ^bb0(%arg9: f16, %arg10: !gpu.mma_matrix<16x16xf16, "COp">, %arg11: memref<16x16xf16, #spirv.storage_class<StorageBuffer>>):
      %14 = "arith.constant"() <{value = 0 : index}> : () -> index
      %15 = "gpu.subgroup_mma_insert_thread_local"(%arg9, %arg10, %14) : (f16, !gpu.mma_matrix<16x16xf16, "COp">, index) -> !gpu.mma_matrix<16x16xf16, "COp">
      "gpu.subgroup_mma_store_matrix"(%15, %arg11, %14, %14) <{leadDimension = 16 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_insert_thread_local_op"} : () -> ()
    "gpu.func"() <{function_type = (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>) -> (), kernel}> ({
    ^bb0(%arg6: !gpu.mma_matrix<16x16xf16, "COp">, %arg7: !gpu.mma_matrix<16x16xf16, "COp">, %arg8: memref<16x16xf16, #spirv.storage_class<StorageBuffer>>):
      %7 = "gpu.subgroup_mma_elementwise"(%arg6, %arg7) <{opType = #gpu<mma_element_wise addf>}> : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      %8 = "gpu.subgroup_mma_elementwise"(%7) <{opType = #gpu<mma_element_wise negatef>}> : (!gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      %9 = "gpu.subgroup_mma_elementwise"(%8, %arg6) <{opType = #gpu<mma_element_wise divf>}> : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      %10 = "gpu.subgroup_mma_elementwise"(%9, %arg6) <{opType = #gpu<mma_element_wise mulf>}> : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      %11 = "gpu.subgroup_mma_elementwise"(%10) <{opType = #gpu<mma_element_wise extf>}> : (!gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf32, "COp">
      %12 = "gpu.subgroup_mma_elementwise"(%11) <{opType = #gpu<mma_element_wise truncf>}> : (!gpu.mma_matrix<16x16xf32, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      %13 = "arith.constant"() <{value = 0 : index}> : () -> index
      "gpu.subgroup_mma_store_matrix"(%12, %arg8, %13, %13) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_elementwise_op_default"} : () -> ()
    "gpu.func"() <{function_type = (!gpu.mma_matrix<16x16xf16, "COp">, f16, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>) -> (), kernel}> ({
    ^bb0(%arg3: !gpu.mma_matrix<16x16xf16, "COp">, %arg4: f16, %arg5: memref<16x16xf16, #spirv.storage_class<StorageBuffer>>):
      %3 = "arith.constant"() <{value = 0 : index}> : () -> index
      %4 = "gpu.subgroup_mma_constant_matrix"(%arg4) : (f16) -> !gpu.mma_matrix<16x16xf16, "COp">
      %5 = "gpu.subgroup_mma_elementwise"(%arg3, %4) <{opType = #gpu<mma_element_wise mulf>}> : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      "gpu.subgroup_mma_store_matrix"(%5, %arg5, %3, %3) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      %6 = "gpu.subgroup_mma_elementwise"(%4, %5) <{opType = #gpu<mma_element_wise mulf>}> : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      "gpu.subgroup_mma_store_matrix"(%6, %arg5, %3, %3) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_elementwise_op_matrix_times_scalar"} : () -> ()
    "gpu.func"() <{function_type = (!gpu.mma_matrix<16x16xf16, "COp">, f16, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>) -> (), kernel}> ({
    ^bb0(%arg0: !gpu.mma_matrix<16x16xf16, "COp">, %arg1: f16, %arg2: memref<16x16xf16, #spirv.storage_class<StorageBuffer>>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "gpu.subgroup_mma_constant_matrix"(%arg1) : (f16) -> !gpu.mma_matrix<16x16xf16, "COp">
      %2 = "gpu.subgroup_mma_elementwise"(%arg0, %1) <{opType = #gpu<mma_element_wise addf>}> : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      "gpu.subgroup_mma_store_matrix"(%2, %arg2, %0, %0) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_elementwise_op_matrix_plus_scalar"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.6, [Shader, CooperativeMatrixKHR, Float16, Int8], [SPV_KHR_storage_buffer_storage_class, SPV_KHR_cooperative_matrix]>, #spirv.resource_limits<>>} : () -> ()

