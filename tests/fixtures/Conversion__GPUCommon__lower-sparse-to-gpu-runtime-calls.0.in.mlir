"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "matvec"}> ({
  ^bb0(%arg4: index):
    %43 = "gpu.wait"() : () -> !gpu.async.token
    %44:2 = "gpu.alloc"(%43, %arg4) <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (!gpu.async.token, index) -> (memref<?xindex>, !gpu.async.token)
    %45:2 = "gpu.alloc"(%44#1, %arg4) <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (!gpu.async.token, index) -> (memref<?xf64>, !gpu.async.token)
    %46:2 = "gpu.create_coo"(%45#1, %arg4, %arg4, %arg4, %44#0, %44#0, %45#0) : (!gpu.async.token, index, index, index, memref<?xindex>, memref<?xindex>, memref<?xf64>) -> (!gpu.sparse.spmat_handle, !gpu.async.token)
    %47:2 = "gpu.create_dn_tensor"(%46#1, %45#0, %arg4) <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (!gpu.async.token, memref<?xf64>, index) -> (!gpu.sparse.dntensor_handle, !gpu.async.token)
    %48:2 = "gpu.spmv_buffer_size"(%47#1, %46#0, %47#0, %47#0) <{computeType = f64, modeA = #gpu<mat_transpose_mode NON_TRANSPOSE>}> : (!gpu.async.token, !gpu.sparse.spmat_handle, !gpu.sparse.dntensor_handle, !gpu.sparse.dntensor_handle) -> (index, !gpu.async.token)
    %49 = "gpu.spmv"(%48#1, %46#0, %47#0, %47#0, %45#0) <{computeType = f64, modeA = #gpu<mat_transpose_mode NON_TRANSPOSE>}> : (!gpu.async.token, !gpu.sparse.spmat_handle, !gpu.sparse.dntensor_handle, !gpu.sparse.dntensor_handle, memref<?xf64>) -> !gpu.async.token
    %50 = "gpu.destroy_sp_mat"(%49, %46#0) : (!gpu.async.token, !gpu.sparse.spmat_handle) -> !gpu.async.token
    %51 = "gpu.destroy_dn_tensor"(%50, %47#0) : (!gpu.async.token, !gpu.sparse.dntensor_handle) -> !gpu.async.token
    "gpu.wait"(%51) : (!gpu.async.token) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "matmul"}> ({
  ^bb0(%arg3: index):
    %34 = "gpu.wait"() : () -> !gpu.async.token
    %35:2 = "gpu.alloc"(%34, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (!gpu.async.token, index) -> (memref<?xindex>, !gpu.async.token)
    %36:2 = "gpu.alloc"(%35#1, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (!gpu.async.token, index) -> (memref<?xf64>, !gpu.async.token)
    %37:2 = "gpu.create_csr"(%36#1, %arg3, %arg3, %arg3, %35#0, %35#0, %36#0) : (!gpu.async.token, index, index, index, memref<?xindex>, memref<?xindex>, memref<?xf64>) -> (!gpu.sparse.spmat_handle, !gpu.async.token)
    %38:2 = "gpu.create_dn_tensor"(%37#1, %36#0, %arg3, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 2>}> : (!gpu.async.token, memref<?xf64>, index, index) -> (!gpu.sparse.dntensor_handle, !gpu.async.token)
    %39:2 = "gpu.spmm_buffer_size"(%38#1, %37#0, %38#0, %38#0) <{computeType = f64, modeA = #gpu<mat_transpose_mode NON_TRANSPOSE>, modeB = #gpu<mat_transpose_mode NON_TRANSPOSE>, resultSegmentSizes = array<i32: 1, 1>}> : (!gpu.async.token, !gpu.sparse.spmat_handle, !gpu.sparse.dntensor_handle, !gpu.sparse.dntensor_handle) -> (index, !gpu.async.token)
    %40 = "gpu.spmm"(%39#1, %37#0, %38#0, %38#0, %36#0) <{computeType = f64, modeA = #gpu<mat_transpose_mode NON_TRANSPOSE>, modeB = #gpu<mat_transpose_mode NON_TRANSPOSE>, operandSegmentSizes = array<i32: 1, 1, 1, 1, 1>}> : (!gpu.async.token, !gpu.sparse.spmat_handle, !gpu.sparse.dntensor_handle, !gpu.sparse.dntensor_handle, memref<?xf64>) -> !gpu.async.token
    %41 = "gpu.destroy_sp_mat"(%40, %37#0) : (!gpu.async.token, !gpu.sparse.spmat_handle) -> !gpu.async.token
    %42 = "gpu.destroy_dn_tensor"(%41, %38#0) : (!gpu.async.token, !gpu.sparse.dntensor_handle) -> !gpu.async.token
    "gpu.wait"(%42) : (!gpu.async.token) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "spgemm"}> ({
  ^bb0(%arg2: index):
    %16 = "gpu.wait"() : () -> !gpu.async.token
    %17:2 = "gpu.alloc"(%16, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (!gpu.async.token, index) -> (memref<?xindex>, !gpu.async.token)
    %18:2 = "gpu.alloc"(%17#1, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (!gpu.async.token, index) -> (memref<?xf32>, !gpu.async.token)
    %19:2 = "gpu.create_csr"(%18#1, %arg2, %arg2, %arg2, %17#0, %17#0, %18#0) : (!gpu.async.token, index, index, index, memref<?xindex>, memref<?xindex>, memref<?xf32>) -> (!gpu.sparse.spmat_handle, !gpu.async.token)
    %20:2 = "gpu.create_csr"(%19#1, %arg2, %arg2, %arg2, %17#0, %17#0, %18#0) : (!gpu.async.token, index, index, index, memref<?xindex>, memref<?xindex>, memref<?xf32>) -> (!gpu.sparse.spmat_handle, !gpu.async.token)
    %21:2 = "gpu.create_csr"(%20#1, %arg2, %arg2, %arg2, %17#0, %17#0, %18#0) : (!gpu.async.token, index, index, index, memref<?xindex>, memref<?xindex>, memref<?xf32>) -> (!gpu.sparse.spmat_handle, !gpu.async.token)
    %22:2 = "gpu.spgemm_create_descr"(%21#1) : (!gpu.async.token) -> (!gpu.sparse.spgemmop_handle, !gpu.async.token)
    %23 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<0xi8>
    %24 = "arith.constant"() <{value = 0 : index}> : () -> index
    %25:2 = "gpu.spgemm_work_estimation_or_compute"(%22#1, %22#0, %19#0, %20#0, %21#0, %24, %23) <{computeType = f32, kind = #gpu<spgemm_work_estimation_or_compute_kind WORK_ESTIMATION>, modeA = #gpu<mat_transpose_mode NON_TRANSPOSE>, modeB = #gpu<mat_transpose_mode NON_TRANSPOSE>}> : (!gpu.async.token, !gpu.sparse.spgemmop_handle, !gpu.sparse.spmat_handle, !gpu.sparse.spmat_handle, !gpu.sparse.spmat_handle, index, memref<0xi8>) -> (index, !gpu.async.token)
    %26:2 = "gpu.spgemm_work_estimation_or_compute"(%25#1, %22#0, %19#0, %20#0, %21#0, %24, %23) <{computeType = f32, kind = #gpu<spgemm_work_estimation_or_compute_kind COMPUTE>, modeA = #gpu<mat_transpose_mode NON_TRANSPOSE>, modeB = #gpu<mat_transpose_mode NON_TRANSPOSE>}> : (!gpu.async.token, !gpu.sparse.spgemmop_handle, !gpu.sparse.spmat_handle, !gpu.sparse.spmat_handle, !gpu.sparse.spmat_handle, index, memref<0xi8>) -> (index, !gpu.async.token)
    %27:4 = "gpu.spmat_get_size"(%26#1, %21#0) : (!gpu.async.token, !gpu.sparse.spmat_handle) -> (index, index, index, !gpu.async.token)
    %28 = "gpu.set_csr_pointers"(%26#1, %21#0, %17#0, %17#0, %18#0) : (!gpu.async.token, !gpu.sparse.spmat_handle, memref<?xindex>, memref<?xindex>, memref<?xf32>) -> !gpu.async.token
    %29 = "gpu.spgemm_copy"(%28, %22#0, %19#0, %20#0, %21#0) <{computeType = f32, modeA = #gpu<mat_transpose_mode NON_TRANSPOSE>, modeB = #gpu<mat_transpose_mode NON_TRANSPOSE>}> : (!gpu.async.token, !gpu.sparse.spgemmop_handle, !gpu.sparse.spmat_handle, !gpu.sparse.spmat_handle, !gpu.sparse.spmat_handle) -> !gpu.async.token
    %30 = "gpu.spgemm_destroy_descr"(%29, %22#0) : (!gpu.async.token, !gpu.sparse.spgemmop_handle) -> !gpu.async.token
    %31 = "gpu.destroy_sp_mat"(%30, %19#0) : (!gpu.async.token, !gpu.sparse.spmat_handle) -> !gpu.async.token
    %32 = "gpu.destroy_sp_mat"(%31, %20#0) : (!gpu.async.token, !gpu.sparse.spmat_handle) -> !gpu.async.token
    %33 = "gpu.destroy_sp_mat"(%32, %21#0) : (!gpu.async.token, !gpu.sparse.spmat_handle) -> !gpu.async.token
    "gpu.wait"(%33) : (!gpu.async.token) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "sddmm"}> ({
  ^bb0(%arg1: index):
    %7 = "gpu.wait"() : () -> !gpu.async.token
    %8:2 = "gpu.alloc"(%7, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (!gpu.async.token, index) -> (memref<?xindex>, !gpu.async.token)
    %9:2 = "gpu.alloc"(%8#1, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (!gpu.async.token, index) -> (memref<?xf64>, !gpu.async.token)
    %10:2 = "gpu.create_csr"(%9#1, %arg1, %arg1, %arg1, %8#0, %8#0, %9#0) : (!gpu.async.token, index, index, index, memref<?xindex>, memref<?xindex>, memref<?xf64>) -> (!gpu.sparse.spmat_handle, !gpu.async.token)
    %11:2 = "gpu.create_dn_tensor"(%10#1, %9#0, %arg1, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 2>}> : (!gpu.async.token, memref<?xf64>, index, index) -> (!gpu.sparse.dntensor_handle, !gpu.async.token)
    %12:2 = "gpu.sddmm_buffer_size"(%11#1, %11#0, %11#0, %10#0) <{computeType = f64, modeA = #gpu<mat_transpose_mode NON_TRANSPOSE>, modeB = #gpu<mat_transpose_mode NON_TRANSPOSE>}> : (!gpu.async.token, !gpu.sparse.dntensor_handle, !gpu.sparse.dntensor_handle, !gpu.sparse.spmat_handle) -> (index, !gpu.async.token)
    %13 = "gpu.sddmm"(%12#1, %11#0, %11#0, %10#0, %9#0) <{computeType = f64, modeA = #gpu<mat_transpose_mode NON_TRANSPOSE>, modeB = #gpu<mat_transpose_mode NON_TRANSPOSE>}> : (!gpu.async.token, !gpu.sparse.dntensor_handle, !gpu.sparse.dntensor_handle, !gpu.sparse.spmat_handle, memref<?xf64>) -> !gpu.async.token
    %14 = "gpu.destroy_sp_mat"(%13, %10#0) : (!gpu.async.token, !gpu.sparse.spmat_handle) -> !gpu.async.token
    %15 = "gpu.destroy_dn_tensor"(%14, %11#0) : (!gpu.async.token, !gpu.sparse.dntensor_handle) -> !gpu.async.token
    "gpu.wait"(%15) : (!gpu.async.token) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "csc_and_bsr"}> ({
  ^bb0(%arg0: index):
    %0 = "gpu.wait"() : () -> !gpu.async.token
    %1:2 = "gpu.alloc"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (!gpu.async.token, index) -> (memref<?xindex>, !gpu.async.token)
    %2:2 = "gpu.alloc"(%1#1, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (!gpu.async.token, index) -> (memref<?xf64>, !gpu.async.token)
    %3:2 = "gpu.create_csc"(%2#1, %arg0, %arg0, %arg0, %1#0, %1#0, %2#0) : (!gpu.async.token, index, index, index, memref<?xindex>, memref<?xindex>, memref<?xf64>) -> (!gpu.sparse.spmat_handle, !gpu.async.token)
    %4:2 = "gpu.create_bsr"(%3#1, %arg0, %arg0, %arg0, %arg0, %arg0, %1#0, %1#0, %2#0) : (!gpu.async.token, index, index, index, index, index, memref<?xindex>, memref<?xindex>, memref<?xf64>) -> (!gpu.sparse.spmat_handle, !gpu.async.token)
    %5 = "gpu.destroy_sp_mat"(%4#1, %3#0) : (!gpu.async.token, !gpu.sparse.spmat_handle) -> !gpu.async.token
    %6 = "gpu.destroy_sp_mat"(%5, %4#0) : (!gpu.async.token, !gpu.sparse.spmat_handle) -> !gpu.async.token
    "gpu.wait"(%6) : (!gpu.async.token) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

