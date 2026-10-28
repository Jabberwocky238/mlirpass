#map = affine_map<(d0, d1) -> (d0 * 64 + d1)>
module {
  module attributes {gpu.container_module} {
    func.func @no_args(%arg0: index) {
      gpu.launch blocks(%arg1, %arg2, %arg3) in (%arg7 = %arg0, %arg8 = %arg0, %arg9 = %arg0) threads(%arg4, %arg5, %arg6) in (%arg10 = %arg0, %arg11 = %arg0, %arg12 = %arg0) {
        gpu.terminator
      }
      return
    }
    func.func @launch_with_module_func_attr(%arg0: index) {
      gpu.launch blocks(%arg1, %arg2, %arg3) in (%arg7 = %arg0, %arg8 = %arg0, %arg9 = %arg0) threads(%arg4, %arg5, %arg6) in (%arg10 = %arg0, %arg11 = %arg0, %arg12 = %arg0) module(@test_module) function(@test_kernel_func) {
        gpu.terminator
      }
      return
    }
    func.func @args(%arg0: index, %arg1: index, %arg2: f32, %arg3: memref<?xf32, 1>) {
      gpu.launch blocks(%arg4, %arg5, %arg6) in (%arg10 = %arg0, %arg11 = %arg0, %arg12 = %arg0) threads(%arg7, %arg8, %arg9) in (%arg13 = %arg1, %arg14 = %arg1, %arg15 = %arg1) {
        "use"(%arg2) : (f32) -> ()
        "use"(%arg3) : (memref<?xf32, 1>) -> ()
        gpu.terminator
      }
      return
    }
    func.func @launch_async(%arg0: index, %arg1: index) {
      %0 = gpu.wait async
      %1 = gpu.launch async [%0] blocks(%arg2, %arg3, %arg4) in (%arg8 = %arg0, %arg9 = %arg0, %arg10 = %arg0) threads(%arg5, %arg6, %arg7) in (%arg11 = %arg1, %arg12 = %arg1, %arg13 = %arg1) {
        gpu.terminator
      }
      return
    }
    func.func @launch_async_no_deps(%arg0: index, %arg1: index) {
      %0 = gpu.launch async blocks(%arg2, %arg3, %arg4) in (%arg8 = %arg0, %arg9 = %arg0, %arg10 = %arg0) threads(%arg5, %arg6, %arg7) in (%arg11 = %arg1, %arg12 = %arg1, %arg13 = %arg1) {
        gpu.terminator
      }
      %1 = gpu.launch async blocks(%arg2, %arg3, %arg4) in (%arg8 = %arg0, %arg9 = %arg0, %arg10 = %arg0) threads(%arg5, %arg6, %arg7) in (%arg11 = %arg1, %arg12 = %arg1, %arg13 = %arg1) {
        gpu.terminator
      }
      return
    }
    func.func @launch_with_attributions(%arg0: index, %arg1: index, %arg2: f32, %arg3: memref<?xf32, 1>) {
      gpu.launch blocks(%arg4, %arg5, %arg6) in (%arg10 = %arg0, %arg11 = %arg0, %arg12 = %arg0) threads(%arg7, %arg8, %arg9) in (%arg13 = %arg1, %arg14 = %arg1, %arg15 = %arg1) workgroup(%arg16 : memref<42xf32, 3>, %arg17 : memref<2xf32, 3>) private(%arg18 : memref<2xf32, 5>, %arg19 : memref<1xf32, 5>) {
        "use"(%arg2) : (f32) -> ()
        "use"(%arg3) : (memref<?xf32, 1>) -> ()
        "use"(%arg16, %arg17) : (memref<42xf32, 3>, memref<2xf32, 3>) -> ()
        "use"(%arg18) : (memref<2xf32, 5>) -> ()
        "use"(%arg19) : (memref<1xf32, 5>) -> ()
        gpu.terminator
      }
      return
    }
    gpu.module @kernels {
      gpu.func @kernel_1(%arg0: f32, %arg1: memref<?xf32, 1>) kernel {
        %thread_id_x = gpu.thread_id  x
        %thread_id_y = gpu.thread_id  y
        %thread_id_z = gpu.thread_id  z
        %block_dim_x = gpu.block_dim  x
        %block_dim_y = gpu.block_dim  y
        %block_dim_z = gpu.block_dim  z
        %block_id_x = gpu.block_id  x
        %block_id_y = gpu.block_id  y
        %block_id_z = gpu.block_id  z
        %grid_dim_x = gpu.grid_dim  x
        %grid_dim_y = gpu.grid_dim  y
        %grid_dim_z = gpu.grid_dim  z
        %global_id_x = gpu.global_id  x
        %global_id_y = gpu.global_id  y
        %global_id_z = gpu.global_id  z
        %0 = gpu.subgroup_id : index
        %1 = gpu.num_subgroups : index
        %2 = gpu.subgroup_size : index
        %cst = arith.constant 1.000000e+00 : f32
        %3 = vector.broadcast %arg0 : f32 to vector<4xf32>
        %4 = gpu.all_reduce  add %cst {
        } : (f32) -> f32
        %5 = gpu.all_reduce  add %cst uniform {
        } : (f32) -> f32
        %6 = gpu.all_reduce  %cst {
        ^bb0(%arg2: f32, %arg3: f32):
          %11 = arith.addf %arg2, %arg3 : f32
          gpu.yield %11 : f32
        } : (f32) -> f32
        %7 = gpu.subgroup_reduce  add %cst : (f32) -> f32
        %8 = gpu.subgroup_reduce  add %cst uniform : (f32) -> f32
        %9 = gpu.subgroup_reduce  add %3 : (vector<4xf32>) -> vector<4xf32>
        %c7_i32 = arith.constant 7 : i32
        %c3_i32 = arith.constant 3 : i32
        %shuffleResult, %valid = gpu.shuffle  xor %arg0, %c3_i32, %c7_i32 : f32
        %shuffleResult_0, %valid_1 = gpu.shuffle  up %arg0, %c3_i32, %c7_i32 : f32
        %shuffleResult_2, %valid_3 = gpu.shuffle  down %arg0, %c3_i32, %c7_i32 : f32
        %shuffleResult_4, %valid_5 = gpu.shuffle  idx %arg0, %c3_i32, %c7_i32 : f32
        %rotateResult, %valid_6 = gpu.rotate %arg0, 3, 16 : f32
        gpu.barrier
        "some_op"(%block_id_x, %thread_id_x) : (index, index) -> ()
        %10 = memref.load %arg1[%block_id_x] : memref<?xf32, 1>
        gpu.return
      }
      gpu.func @kernel_2() kernel {
        gpu.return
      }
    }
    gpu.binary @binary_1  [#gpu.object<#nvvm.target, "">]
    gpu.binary @binary_2 <#gpu.select_object<#nvvm.target<chip = "sm_90">>> [#gpu.object<#nvvm.target, "">, #gpu.object<#nvvm.target<chip = "sm_90">, "">]
    gpu.binary @binary_3 <#gpu.select_object<1 : i64>> [#gpu.object<#nvvm.target, "">, #gpu.object<#nvvm.target<chip = "sm_90">, "">]
    gpu.binary @binary_4  [#gpu.object<#nvvm.target, bin = "">, #gpu.object<#nvvm.target, assembly = "">, #gpu.object<#nvvm.target, offload = "">, #gpu.object<#nvvm.target, properties = {O = 3 : i32}, offload = "">]
    gpu.binary @binary_5  [#gpu.object<#nvvm.target, properties = {O = 3 : i32}, "">]
    func.func private @two_value_generator() -> (f32, memref<?xf32, 1>)
    func.func @foo() {
      %0 = "op"() : () -> f32
      %1 = "op"() : () -> memref<?xf32, 1>
      %c8 = arith.constant 8 : index
      %c8_i64 = arith.constant 8 : i64
      %c0_i32 = arith.constant 0 : i32
      %2 = gpu.wait async
      %3 = llvm.mlir.zero : !llvm.ptr
      gpu.launch_func  @kernels::@kernel_1 blocks in (%c8, %c8, %c8) threads in (%c8, %c8, %c8)  args(%0 : f32, %1 : memref<?xf32, 1>)
      gpu.launch_func  @kernels::@kernel_1 clusters in (%c8, %c8, %c8) blocks in (%c8, %c8, %c8) threads in (%c8, %c8, %c8)  args(%0 : f32, %1 : memref<?xf32, 1>)
      gpu.launch_func  @kernels::@kernel_1 blocks in (%c8, %c8, %c8) threads in (%c8, %c8, %c8)  dynamic_shared_memory_size %c0_i32 args(%0 : f32, %1 : memref<?xf32, 1>)
      gpu.launch_func  @kernels::@kernel_2 blocks in (%c8, %c8, %c8) threads in (%c8, %c8, %c8)  
      %4 = gpu.launch_func async [%2] @kernels::@kernel_2 blocks in (%c8, %c8, %c8) threads in (%c8, %c8, %c8)  
      gpu.launch_func <%3 : !llvm.ptr> @kernels::@kernel_1 blocks in (%c8_i64, %c8_i64, %c8_i64) threads in (%c8_i64, %c8_i64, %c8_i64) : i64 args(%0 : f32, %1 : memref<?xf32, 1>)
      gpu.launch_func  @kernels::@kernel_1 blocks in (%c0_i32, %c0_i32, %c0_i32) threads in (%c0_i32, %c0_i32, %c0_i32) : i32 args(%0 : f32, %1 : memref<?xf32, 1>)
      gpu.launch_func  @binary_1::@kernel blocks in (%c0_i32, %c0_i32, %c0_i32) threads in (%c0_i32, %c0_i32, %c0_i32) : i32 args(%0 : f32, %1 : memref<?xf32, 1>)
      %5:2 = call @two_value_generator() : () -> (f32, memref<?xf32, 1>)
      gpu.launch_func  @kernels::@kernel_1 blocks in (%c8, %c8, %c8) threads in (%c8, %c8, %c8)  args(%5#0 : f32, %5#1 : memref<?xf32, 1>)
      return
    }
    gpu.module @gpu_funcs {
      gpu.func @kernel_1(%arg0: f32) workgroup(%arg1 : memref<42xf32, 3>, %arg2 : memref<2xf32, 3>) private(%arg3 : memref<2xf32, 5>, %arg4 : memref<1xf32, 5>) kernel attributes {foo = "bar"} {
        "use"(%arg1, %arg2) : (memref<42xf32, 3>, memref<2xf32, 3>) -> ()
        "use"(%arg3) : (memref<2xf32, 5>) -> ()
        "use"(%arg4) : (memref<1xf32, 5>) -> ()
        gpu.return
      }
      gpu.func @printf_test(%arg0: i32) {
        gpu.printf "Value: %d", %arg0 : i32
        gpu.return
      }
      gpu.func @printf_empty(%arg0: i32) {
        gpu.printf "]"
        %0 = arith.cmpi slt, %arg0, %arg0 : i32
        scf.if %0 {
          gpu.printf ", "
        }
        gpu.return
      }
      gpu.func @no_attribution(%arg0: f32) {
        gpu.return
      }
      gpu.func @no_attribution_attrs(%arg0: f32) attributes {foo = "bar"} {
        gpu.return
      }
      gpu.func @workgroup_only() workgroup(%arg0 : memref<42xf32, 3>) {
        gpu.return
      }
      gpu.func @private_only() private(%arg0 : memref<2xf32, 5>) {
        gpu.return
      }
      gpu.func @empty_attribution(%arg0: f32) {
        gpu.return
      }
    }
    gpu.module @explicit_attributions {
      gpu.func @kernel_1(%arg0: f32, %arg1: memref<?xf32>) workgroup(%arg2 : memref<5xf32, 3>) private(%arg3 : memref<5xf32, 5>) kernel {
        gpu.return
      }
    }
    func.func @alloc() {
      %memref = gpu.alloc  () : memref<13xf32, 1>
      gpu.dealloc  %memref : memref<13xf32, 1>
      %0 = gpu.wait async
      %memref_0, %asyncToken = gpu.alloc async [%0] () : memref<13xf32, 1>
      %1 = gpu.dealloc async [%asyncToken] %memref_0 : memref<13xf32, 1>
      %memref_1 = gpu.alloc  host_shared () : memref<13xf32, 1>
      gpu.dealloc  %memref_1 : memref<13xf32, 1>
      return
    }
    func.func @async_token(%arg0: !gpu.async.token) -> !gpu.async.token {
      return %arg0 : !gpu.async.token
    }
    func.func @async_wait() {
      %0 = gpu.wait async
      %1 = gpu.wait async [%0]
      %2 = gpu.wait async [%0, %1]
      gpu.wait [%0, %1]
      gpu.wait 
      return
    }
    func.func @memcpy(%arg0: memref<3x7xf32>, %arg1: memref<3x7xf32, 1>) {
      gpu.memcpy  %arg0, %arg1 : memref<3x7xf32>, memref<3x7xf32, 1>
      %0 = gpu.wait async
      %1 = gpu.memcpy async [%0] %arg0, %arg1 : memref<3x7xf32>, memref<3x7xf32, 1>
      return
    }
    func.func @memset(%arg0: memref<3x7xf32>, %arg1: f32) {
      gpu.memset  %arg0, %arg1 : memref<3x7xf32>, f32
      %0 = gpu.wait async
      %1 = gpu.memset async [%0] %arg0, %arg1 : memref<3x7xf32>, f32
      return
    }
    func.func @mmamatrix_valid_scalar_element_type(%arg0: memref<32x32xf16, #map>) {
      %alloca = memref.alloca() {alignment = 32 : i64} : memref<32x32xf16, 3>
      %c16 = arith.constant 16 : index
      %cst = arith.constant 1.000000e+00 : f32
      %0 = gpu.subgroup_mma_load_matrix %alloca[%c16, %c16] {leadDimension = 32 : index} : memref<32x32xf16, 3> -> !gpu.mma_matrix<16x16xf16, "AOp">
      %1 = gpu.subgroup_mma_load_matrix %arg0[%c16, %c16] {leadDimension = 64 : index} : memref<32x32xf16, #map> -> !gpu.mma_matrix<16x16xf16, "AOp">
      %2 = gpu.subgroup_mma_constant_matrix %cst : !gpu.mma_matrix<16x16xf32, "COp">
      %3 = gpu.subgroup_mma_elementwise  addf %2, %2 : (!gpu.mma_matrix<16x16xf32, "COp">, !gpu.mma_matrix<16x16xf32, "COp">) -> !gpu.mma_matrix<16x16xf32, "COp">
      %4 = gpu.subgroup_mma_elementwise  maxf %3, %2 : (!gpu.mma_matrix<16x16xf32, "COp">, !gpu.mma_matrix<16x16xf32, "COp">) -> !gpu.mma_matrix<16x16xf32, "COp">
      return
    }
    func.func @mmamatrix_valid_vector_element_type(%arg0: memref<32x4xvector<4xf32>>, %arg1: index) {
      %0 = gpu.subgroup_mma_load_matrix %arg0[%arg1, %arg1] {leadDimension = 4 : index} : memref<32x4xvector<4xf32>> -> !gpu.mma_matrix<16x16xf16, "COp">
      gpu.subgroup_mma_store_matrix %0, %arg0[%arg1, %arg1] {leadDimension = 4 : index} : !gpu.mma_matrix<16x16xf16, "COp">, memref<32x4xvector<4xf32>>
      return
    }
    func.func @set_default_device(%arg0: i32) {
      gpu.set_default_device %arg0
      return
    }
    func.func @sparse_ops(%arg0: index) {
      %0 = gpu.wait async
      %memref, %asyncToken = gpu.alloc async [%0] (%arg0) : memref<?xindex>
      %memref_0, %asyncToken_1 = gpu.alloc async [%asyncToken] (%arg0) : memref<?xf64>
      %spmat, %asyncToken_2 = gpu.create_coo async [%asyncToken_1] %arg0, %arg0, %arg0, %memref, %memref, %memref_0 : memref<?xindex>, memref<?xindex>, memref<?xf64>
      %spmat_3, %asyncToken_4 = gpu.create_csr async [%asyncToken_2] %arg0, %arg0, %arg0, %memref, %memref, %memref_0 : memref<?xindex>, memref<?xindex>, memref<?xf64>
      %dnTensor, %asyncToken_5 = gpu.create_dn_tensor async [%asyncToken_4] %memref_0, %arg0 : index into memref<?xf64>
      %bufferSz, %asyncToken_6 = gpu.spmv_buffer_size async [%asyncToken_5] %spmat, %dnTensor, %dnTensor into f64
      %1 = gpu.spmv async [%asyncToken_6] %spmat, %dnTensor, %dnTensor, %memref_0 : memref<?xf64> into f64
      %dnTensor_7, %asyncToken_8 = gpu.create_dn_tensor async [%1] %memref_0, %arg0, %arg0 : index, index into memref<?xf64>
      %bufferSzs, %asyncToken_9 = gpu.spmm_buffer_size async [%asyncToken_8] %spmat, %dnTensor_7, %dnTensor_7 : index into f64
      %2 = gpu.spmm async [%asyncToken_9] %spmat, %dnTensor_7, %dnTensor_7, %memref_0 : memref<?xf64> into f64
      %bufferSz_10, %asyncToken_11 = gpu.sddmm_buffer_size async [%2] %dnTensor_7, %dnTensor_7, %spmat into f64
      %3 = gpu.sddmm async [%asyncToken_11] %dnTensor_7, %dnTensor_7, %spmat, %memref_0 : memref<?xf64> into f64
      %4 = gpu.destroy_dn_tensor async [%3] %dnTensor_7
      %5 = gpu.destroy_sp_mat async [%4] %spmat
      %6 = gpu.destroy_dn_tensor async [%5] %dnTensor
      gpu.wait [%6]
      return
    }
    func.func @extract_insert_mma(%arg0: !gpu.mma_matrix<16x16xf32, "COp">, %arg1: memref<16x16xf32>) {
      %cst = arith.constant 0.000000e+00 : f32
      %c0 = arith.constant 0 : index
      %0 = gpu.subgroup_mma_extract_thread_local %arg0[%c0] : !gpu.mma_matrix<16x16xf32, "COp"> -> f32
      %1 = gpu.subgroup_mma_constant_matrix %cst : !gpu.mma_matrix<16x16xf32, "COp">
      %2 = gpu.subgroup_mma_insert_thread_local %0, %1[%c0] : f32, !gpu.mma_matrix<16x16xf32, "COp"> -> !gpu.mma_matrix<16x16xf32, "COp">
      gpu.subgroup_mma_store_matrix %2, %arg1[%c0, %c0] {leadDimension = 16 : index} : !gpu.mma_matrix<16x16xf32, "COp">, memref<16x16xf32>
      return
    }
  }
  gpu.module @module {
    gpu.func @func() {
      gpu.return
    }
  }
  gpu.module @module_with_one_target [#nvvm.target] {
    gpu.func @kernel(%arg0: f32) kernel {
      gpu.return
    }
  }
  gpu.module @module_with_two_target [#nvvm.target, #rocdl.target<chip = "gfx90a">] {
    gpu.func @kernel(%arg0: f32) kernel {
      gpu.return
    }
  }
  gpu.module @module_with_offload_handler<#gpu.select_object<0 : i64>> [#nvvm.target] {
  }
  gpu.binary @kernel_attrs_1  [#gpu.object<#rocdl.target, kernels = <[#gpu.kernel_metadata<"kernel0", (i32, f32) -> (), metadata = {sgpr_count = 255 : i64}>, #gpu.kernel_metadata<"kernel1", (i32) -> (), arg_attrs = [{llvm.read_only}]>]>, bin = "BLOB">]
  gpu.binary @kernel_attrs_2  [#gpu.object<#rocdl.target, kernels = <[#gpu.kernel_metadata<"a_kernel", () -> ()>, #gpu.kernel_metadata<"m_kernel", () -> ()>, #gpu.kernel_metadata<"z_kernel", () -> ()>]>, bin = "BLOB">]
  func.func @warp_execute_on_lane_0(%arg0: index) {
    gpu.warp_execute_on_lane_0(%arg0)[32] {
    }
    return
  }
  func.func @warp_execute_on_lane_0_2d(%arg0: index) {
    %0 = gpu.warp_execute_on_lane_0(%arg0)[32] -> (vector<1x4xi32>) {
      %cst = arith.constant dense<2> : vector<4x32xi32>
      gpu.yield %cst : vector<4x32xi32>
    }
    return
  }
  func.func @warp_operand_result(%arg0: index, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = gpu.warp_execute_on_lane_0(%arg0)[32] args(%arg1 : vector<4xi32>) -> (vector<4xi32>) {
    ^bb0(%arg2: vector<128xi32>):
      %cst = arith.constant dense<2> : vector<128xi32>
      %1 = arith.addi %arg2, %cst : vector<128xi32>
      gpu.yield %1 : vector<128xi32>
    }
    return %0 : vector<4xi32>
  }
  func.func @subgroup_broadcast(%arg0: f32, %arg1: i32) -> (f32, f32) {
    %0 = gpu.subgroup_broadcast %arg0,  first_active_lane : f32
    %1 = gpu.subgroup_broadcast %arg0,  specific_lane %arg1 : f32
    return %0, %1 : f32, f32
  }
}

