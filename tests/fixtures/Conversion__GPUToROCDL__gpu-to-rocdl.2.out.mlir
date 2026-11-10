module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @__ockl_get_num_groups(i32) -> i64
    llvm.func @__ockl_get_local_size(i32) -> i64
    llvm.func @gpu_index_ops() -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> attributes {llvm.emit_c_interface} {
      %0 = rocdl.workitem.id.x : i32
      %1 = rocdl.workitem.id.y : i32
      %2 = rocdl.workitem.id.z : i32
      %3 = llvm.mlir.constant(0 : i32) : i32
      %4 = llvm.call @__ockl_get_local_size(%3) : (i32) -> (i64 {llvm.range = #llvm.constant_range<i64, 1, 1025>})
      %5 = llvm.trunc %4 : i64 to i32
      %6 = llvm.mlir.constant(1 : i32) : i32
      %7 = llvm.call @__ockl_get_local_size(%6) : (i32) -> (i64 {llvm.range = #llvm.constant_range<i64, 1, 1025>})
      %8 = llvm.trunc %7 : i64 to i32
      %9 = llvm.mlir.constant(2 : i32) : i32
      %10 = llvm.call @__ockl_get_local_size(%9) : (i32) -> (i64 {llvm.range = #llvm.constant_range<i64, 1, 1025>})
      %11 = llvm.trunc %10 : i64 to i32
      %12 = rocdl.workgroup.id.x : i32
      %13 = rocdl.workgroup.id.y : i32
      %14 = rocdl.workgroup.id.z : i32
      %15 = llvm.mlir.constant(0 : i32) : i32
      %16 = llvm.call @__ockl_get_num_groups(%15) : (i32) -> i64
      %17 = llvm.trunc %16 : i64 to i32
      %18 = llvm.mlir.constant(1 : i32) : i32
      %19 = llvm.call @__ockl_get_num_groups(%18) : (i32) -> i64
      %20 = llvm.trunc %19 : i64 to i32
      %21 = llvm.mlir.constant(2 : i32) : i32
      %22 = llvm.call @__ockl_get_num_groups(%21) : (i32) -> i64
      %23 = llvm.trunc %22 : i64 to i32
      %24 = llvm.mlir.constant(0 : i32) : i32
      %25 = llvm.mlir.constant(-1 : i32) : i32
      %26 = rocdl.mbcnt.lo %25, %24 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %27 = rocdl.mbcnt.hi %25, %26 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %28 = rocdl.wavefrontsize : i32
      %29 = rocdl.wavefrontsize range <i32, 64, 65> : i32
      %30 = llvm.mlir.poison : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %31 = llvm.insertvalue %0, %30[0] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %32 = llvm.insertvalue %1, %31[1] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %33 = llvm.insertvalue %2, %32[2] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %34 = llvm.insertvalue %5, %33[3] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %35 = llvm.insertvalue %8, %34[4] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %36 = llvm.insertvalue %11, %35[5] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %37 = llvm.insertvalue %12, %36[6] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %38 = llvm.insertvalue %13, %37[7] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %39 = llvm.insertvalue %14, %38[8] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %40 = llvm.insertvalue %17, %39[9] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %41 = llvm.insertvalue %20, %40[10] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %42 = llvm.insertvalue %23, %41[11] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %43 = llvm.insertvalue %27, %42[12] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %44 = llvm.insertvalue %28, %43[13] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %45 = llvm.insertvalue %29, %44[14] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      llvm.return %45 : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
    }
    llvm.func @_mlir_ciface_gpu_index_ops(%arg0: !llvm.ptr) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_index_ops() : () -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      llvm.store %0, %arg0 : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @gpu_index_ops_range(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) attributes {gpu.kernel, gpu.known_block_size = array<i32: 8, 12, 16>, gpu.known_grid_size = array<i32: 20, 24, 28>, rocdl.flat_work_group_size = "1536,1536", rocdl.kernel, rocdl.reqd_work_group_size = array<i32: 8, 12, 16>} {
      %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32)>
      %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i32)> 
      %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i32)> 
      %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i32)> 
      %4 = rocdl.workitem.id.x range <i32, 0, 8> : i32
      %5 = rocdl.workitem.id.y range <i32, 0, 12> : i32
      %6 = rocdl.workitem.id.z range <i32, 0, 16> : i32
      %7 = rocdl.workgroup.id.x range <i32, 0, 20> : i32
      %8 = rocdl.workgroup.id.y range <i32, 0, 24> : i32
      %9 = rocdl.workgroup.id.z range <i32, 0, 28> : i32
      %10 = llvm.mlir.constant(8 : i64) : i64
      %11 = llvm.trunc %10 : i64 to i32
      %12 = llvm.mlir.constant(12 : i64) : i64
      %13 = llvm.trunc %12 : i64 to i32
      %14 = llvm.mlir.constant(16 : i64) : i64
      %15 = llvm.trunc %14 : i64 to i32
      %16 = llvm.mlir.constant(20 : i64) : i64
      %17 = llvm.trunc %16 : i64 to i32
      %18 = llvm.mlir.constant(24 : i64) : i64
      %19 = llvm.trunc %18 : i64 to i32
      %20 = llvm.mlir.constant(28 : i64) : i64
      %21 = llvm.trunc %20 : i64 to i32
      %22 = llvm.add %4, %5 : i32
      %23 = llvm.add %22, %6 : i32
      %24 = llvm.add %23, %7 : i32
      %25 = llvm.add %24, %8 : i32
      %26 = llvm.add %25, %9 : i32
      %27 = llvm.add %26, %11 : i32
      %28 = llvm.add %27, %13 : i32
      %29 = llvm.add %28, %15 : i32
      %30 = llvm.add %29, %17 : i32
      %31 = llvm.add %30, %19 : i32
      %32 = llvm.add %31, %21 : i32
      %33 = llvm.extractvalue %3[1] : !llvm.struct<(ptr, ptr, i32)> 
      llvm.store %32, %33 : i32, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @gpu_index_comp(%arg0: i32) -> i32 attributes {llvm.emit_c_interface} {
      %0 = llvm.add %arg0, %arg0 : i32
      llvm.return %0 : i32
    }
    llvm.func @_mlir_ciface_gpu_index_comp(%arg0: i32) -> i32 attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_index_comp(%arg0) : (i32) -> i32
      llvm.return %0 : i32
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @gpu_sqrt(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> attributes {llvm.emit_c_interface} {
      %0 = llvm.intr.sqrt(%arg0) : (f16) -> f16
      %1 = llvm.intr.sqrt(%arg1) : (f32) -> f32
      %2 = llvm.intr.sqrt(%arg2) : (f64) -> f64
      %3 = llvm.mlir.poison : !llvm.struct<(f16, f32, f64)>
      %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(f16, f32, f64)> 
      %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(f16, f32, f64)> 
      %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(f16, f32, f64)> 
      llvm.return %6 : !llvm.struct<(f16, f32, f64)>
    }
    llvm.func @_mlir_ciface_gpu_sqrt(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_sqrt(%arg1, %arg2, %arg3) : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      llvm.store %0, %arg0 : !llvm.struct<(f16, f32, f64)>, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @gpu_fabs(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> attributes {llvm.emit_c_interface} {
      %0 = llvm.intr.fabs(%arg0) : (f16) -> f16
      %1 = llvm.intr.fabs(%arg1) : (f32) -> f32
      %2 = llvm.intr.fabs(%arg2) : (f64) -> f64
      %3 = llvm.mlir.poison : !llvm.struct<(f16, f32, f64)>
      %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(f16, f32, f64)> 
      %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(f16, f32, f64)> 
      %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(f16, f32, f64)> 
      llvm.return %6 : !llvm.struct<(f16, f32, f64)>
    }
    llvm.func @_mlir_ciface_gpu_fabs(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_fabs(%arg1, %arg2, %arg3) : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      llvm.store %0, %arg0 : !llvm.struct<(f16, f32, f64)>, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @__ocml_exp_f16(f16) -> f16
    llvm.func @__ocml_exp_f64(f64) -> f64
    llvm.func @gpu_exp(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> attributes {llvm.emit_c_interface} {
      %0 = llvm.call @__ocml_exp_f16(%arg0) : (f16) -> f16
      %1 = llvm.intr.exp(%arg1) : (f32) -> f32
      %2 = llvm.call @__ocml_exp_f64(%arg2) : (f64) -> f64
      %3 = llvm.mlir.poison : !llvm.struct<(f16, f32, f64)>
      %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(f16, f32, f64)> 
      %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(f16, f32, f64)> 
      %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(f16, f32, f64)> 
      llvm.return %6 : !llvm.struct<(f16, f32, f64)>
    }
    llvm.func @_mlir_ciface_gpu_exp(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_exp(%arg1, %arg2, %arg3) : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      llvm.store %0, %arg0 : !llvm.struct<(f16, f32, f64)>, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @__ocml_log_f16(f16) -> f16
    llvm.func @__ocml_log_f64(f64) -> f64
    llvm.func @gpu_log(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> attributes {llvm.emit_c_interface} {
      %0 = llvm.call @__ocml_log_f16(%arg0) : (f16) -> f16
      %1 = llvm.intr.log(%arg1) : (f32) -> f32
      %2 = llvm.call @__ocml_log_f64(%arg2) : (f64) -> f64
      %3 = llvm.mlir.poison : !llvm.struct<(f16, f32, f64)>
      %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(f16, f32, f64)> 
      %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(f16, f32, f64)> 
      %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(f16, f32, f64)> 
      llvm.return %6 : !llvm.struct<(f16, f32, f64)>
    }
    llvm.func @_mlir_ciface_gpu_log(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_log(%arg1, %arg2, %arg3) : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      llvm.store %0, %arg0 : !llvm.struct<(f16, f32, f64)>, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @__ocml_cbrt_f16(f16) -> f16
    llvm.func @__ocml_cbrt_f32(f32) -> f32
    llvm.func @__ocml_cbrt_f64(f64) -> f64
    llvm.func @gpu_cbrt(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> attributes {llvm.emit_c_interface} {
      %0 = llvm.call @__ocml_cbrt_f16(%arg0) : (f16) -> f16
      %1 = llvm.call @__ocml_cbrt_f32(%arg1) : (f32) -> f32
      %2 = llvm.call @__ocml_cbrt_f64(%arg2) : (f64) -> f64
      %3 = llvm.mlir.poison : !llvm.struct<(f16, f32, f64)>
      %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(f16, f32, f64)> 
      %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(f16, f32, f64)> 
      %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(f16, f32, f64)> 
      llvm.return %6 : !llvm.struct<(f16, f32, f64)>
    }
    llvm.func @_mlir_ciface_gpu_cbrt(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_cbrt(%arg1, %arg2, %arg3) : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      llvm.store %0, %arg0 : !llvm.struct<(f16, f32, f64)>, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @__ocml_ceil_f16(f16) -> f16
    llvm.func @__ocml_ceil_f32(f32) -> f32
    llvm.func @__ocml_ceil_f64(f64) -> f64
    llvm.func @gpu_ceil(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> attributes {llvm.emit_c_interface} {
      %0 = llvm.call @__ocml_ceil_f16(%arg0) : (f16) -> f16
      %1 = llvm.call @__ocml_ceil_f32(%arg1) : (f32) -> f32
      %2 = llvm.call @__ocml_ceil_f64(%arg2) : (f64) -> f64
      %3 = llvm.mlir.poison : !llvm.struct<(f16, f32, f64)>
      %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(f16, f32, f64)> 
      %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(f16, f32, f64)> 
      %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(f16, f32, f64)> 
      llvm.return %6 : !llvm.struct<(f16, f32, f64)>
    }
    llvm.func @_mlir_ciface_gpu_ceil(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_ceil(%arg1, %arg2, %arg3) : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      llvm.store %0, %arg0 : !llvm.struct<(f16, f32, f64)>, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @__ocml_floor_f16(f16) -> f16
    llvm.func @__ocml_floor_f32(f32) -> f32
    llvm.func @__ocml_floor_f64(f64) -> f64
    llvm.func @gpu_floor(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> attributes {llvm.emit_c_interface} {
      %0 = llvm.call @__ocml_floor_f16(%arg0) : (f16) -> f16
      %1 = llvm.call @__ocml_floor_f32(%arg1) : (f32) -> f32
      %2 = llvm.call @__ocml_floor_f64(%arg2) : (f64) -> f64
      %3 = llvm.mlir.poison : !llvm.struct<(f16, f32, f64)>
      %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(f16, f32, f64)> 
      %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(f16, f32, f64)> 
      %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(f16, f32, f64)> 
      llvm.return %6 : !llvm.struct<(f16, f32, f64)>
    }
    llvm.func @_mlir_ciface_gpu_floor(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_floor(%arg1, %arg2, %arg3) : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      llvm.store %0, %arg0 : !llvm.struct<(f16, f32, f64)>, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @__ocml_cos_f16(f16) -> f16
    llvm.func @__ocml_cos_f32(f32) -> f32
    llvm.func @__ocml_cos_f64(f64) -> f64
    llvm.func @gpu_cos(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> attributes {llvm.emit_c_interface} {
      %0 = llvm.call @__ocml_cos_f16(%arg0) : (f16) -> f16
      %1 = llvm.call @__ocml_cos_f32(%arg1) : (f32) -> f32
      %2 = llvm.call @__ocml_cos_f64(%arg2) : (f64) -> f64
      %3 = llvm.mlir.poison : !llvm.struct<(f16, f32, f64)>
      %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(f16, f32, f64)> 
      %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(f16, f32, f64)> 
      %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(f16, f32, f64)> 
      llvm.return %6 : !llvm.struct<(f16, f32, f64)>
    }
    llvm.func @_mlir_ciface_gpu_cos(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_cos(%arg1, %arg2, %arg3) : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      llvm.store %0, %arg0 : !llvm.struct<(f16, f32, f64)>, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @__ocml_exp2_f16(f16) -> f16
    llvm.func @__ocml_exp2_f32(f32) -> f32
    llvm.func @__ocml_exp2_f64(f64) -> f64
    llvm.func @gpu_exp2(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> attributes {llvm.emit_c_interface} {
      %0 = llvm.call @__ocml_exp2_f16(%arg0) : (f16) -> f16
      %1 = llvm.call @__ocml_exp2_f32(%arg1) : (f32) -> f32
      %2 = llvm.call @__ocml_exp2_f32(%1) : (f32) -> f32
      %3 = llvm.call @__ocml_exp2_f64(%arg2) : (f64) -> f64
      %4 = llvm.mlir.poison : !llvm.struct<(f16, f32, f64)>
      %5 = llvm.insertvalue %0, %4[0] : !llvm.struct<(f16, f32, f64)> 
      %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<(f16, f32, f64)> 
      %7 = llvm.insertvalue %3, %6[2] : !llvm.struct<(f16, f32, f64)> 
      llvm.return %7 : !llvm.struct<(f16, f32, f64)>
    }
    llvm.func @_mlir_ciface_gpu_exp2(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_exp2(%arg1, %arg2, %arg3) : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      llvm.store %0, %arg0 : !llvm.struct<(f16, f32, f64)>, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    "test.symbol_scope"() ({
      llvm.func @__ocml_sin_f16(f16) -> f16
      llvm.func @__ocml_sin_f32(f32) -> f32
      llvm.func @__ocml_sin_f64(f64) -> f64
      llvm.func @gpu_sin(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> {
        %0 = llvm.call @__ocml_sin_f16(%arg0) : (f16) -> f16
        %1 = llvm.call @__ocml_sin_f32(%arg1) : (f32) -> f32
        %2 = llvm.call @__ocml_sin_f64(%arg2) : (f64) -> f64
        %3 = llvm.mlir.poison : !llvm.struct<(f16, f32, f64)>
        %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(f16, f32, f64)> 
        %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(f16, f32, f64)> 
        %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(f16, f32, f64)> 
        llvm.return %6 : !llvm.struct<(f16, f32, f64)>
      }
      "test.finish"() : () -> ()
    }) : () -> ()
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @__ocml_expm1_f16(f16) -> f16
    llvm.func @__ocml_expm1_f32(f32) -> f32
    llvm.func @__ocml_expm1_f64(f64) -> f64
    llvm.func @gpu_expm1(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> attributes {llvm.emit_c_interface} {
      %0 = llvm.call @__ocml_expm1_f16(%arg0) : (f16) -> f16
      %1 = llvm.call @__ocml_expm1_f32(%arg1) : (f32) -> f32
      %2 = llvm.call @__ocml_expm1_f32(%1) : (f32) -> f32
      %3 = llvm.call @__ocml_expm1_f64(%arg2) : (f64) -> f64
      %4 = llvm.mlir.poison : !llvm.struct<(f16, f32, f64)>
      %5 = llvm.insertvalue %0, %4[0] : !llvm.struct<(f16, f32, f64)> 
      %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<(f16, f32, f64)> 
      %7 = llvm.insertvalue %3, %6[2] : !llvm.struct<(f16, f32, f64)> 
      llvm.return %7 : !llvm.struct<(f16, f32, f64)>
    }
    llvm.func @_mlir_ciface_gpu_expm1(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_expm1(%arg1, %arg2, %arg3) : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      llvm.store %0, %arg0 : !llvm.struct<(f16, f32, f64)>, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @__ocml_log_f16(f16) -> f16
    llvm.func @__ocml_log_f64(f64) -> f64
    llvm.func @gpu_log(%arg0: f16, %arg1: f64) -> !llvm.struct<(f16, f64)> attributes {llvm.emit_c_interface} {
      %0 = llvm.call @__ocml_log_f16(%arg0) : (f16) -> f16
      %1 = llvm.call @__ocml_log_f64(%arg1) : (f64) -> f64
      %2 = llvm.mlir.poison : !llvm.struct<(f16, f64)>
      %3 = llvm.insertvalue %0, %2[0] : !llvm.struct<(f16, f64)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(f16, f64)> 
      llvm.return %4 : !llvm.struct<(f16, f64)>
    }
    llvm.func @_mlir_ciface_gpu_log(%arg0: !llvm.ptr, %arg1: f16, %arg2: f64) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_log(%arg1, %arg2) : (f16, f64) -> !llvm.struct<(f16, f64)>
      llvm.store %0, %arg0 : !llvm.struct<(f16, f64)>, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @__ocml_log1p_f16(f16) -> f16
    llvm.func @__ocml_log1p_f32(f32) -> f32
    llvm.func @__ocml_log1p_f64(f64) -> f64
    llvm.func @gpu_log1p(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> attributes {llvm.emit_c_interface} {
      %0 = llvm.call @__ocml_log1p_f16(%arg0) : (f16) -> f16
      %1 = llvm.call @__ocml_log1p_f32(%arg1) : (f32) -> f32
      %2 = llvm.call @__ocml_log1p_f64(%arg2) : (f64) -> f64
      %3 = llvm.mlir.poison : !llvm.struct<(f16, f32, f64)>
      %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(f16, f32, f64)> 
      %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(f16, f32, f64)> 
      %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(f16, f32, f64)> 
      llvm.return %6 : !llvm.struct<(f16, f32, f64)>
    }
    llvm.func @_mlir_ciface_gpu_log1p(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_log1p(%arg1, %arg2, %arg3) : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      llvm.store %0, %arg0 : !llvm.struct<(f16, f32, f64)>, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @__ocml_log10_f16(f16) -> f16
    llvm.func @__ocml_log10_f32(f32) -> f32
    llvm.func @__ocml_log10_f64(f64) -> f64
    llvm.func @gpu_log10(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> attributes {llvm.emit_c_interface} {
      %0 = llvm.call @__ocml_log10_f16(%arg0) : (f16) -> f16
      %1 = llvm.call @__ocml_log10_f32(%arg1) : (f32) -> f32
      %2 = llvm.call @__ocml_log10_f64(%arg2) : (f64) -> f64
      %3 = llvm.mlir.poison : !llvm.struct<(f16, f32, f64)>
      %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(f16, f32, f64)> 
      %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(f16, f32, f64)> 
      %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(f16, f32, f64)> 
      llvm.return %6 : !llvm.struct<(f16, f32, f64)>
    }
    llvm.func @_mlir_ciface_gpu_log10(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_log10(%arg1, %arg2, %arg3) : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      llvm.store %0, %arg0 : !llvm.struct<(f16, f32, f64)>, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @__ocml_log2_f16(f16) -> f16
    llvm.func @__ocml_log2_f32(f32) -> f32
    llvm.func @__ocml_log2_f64(f64) -> f64
    llvm.func @gpu_log2(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> attributes {llvm.emit_c_interface} {
      %0 = llvm.call @__ocml_log2_f16(%arg0) : (f16) -> f16
      %1 = llvm.call @__ocml_log2_f32(%arg1) : (f32) -> f32
      %2 = llvm.call @__ocml_log2_f64(%arg2) : (f64) -> f64
      %3 = llvm.mlir.poison : !llvm.struct<(f16, f32, f64)>
      %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(f16, f32, f64)> 
      %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(f16, f32, f64)> 
      %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(f16, f32, f64)> 
      llvm.return %6 : !llvm.struct<(f16, f32, f64)>
    }
    llvm.func @_mlir_ciface_gpu_log2(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_log2(%arg1, %arg2, %arg3) : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      llvm.store %0, %arg0 : !llvm.struct<(f16, f32, f64)>, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @__ocml_rsqrt_f16(f16) -> f16
    llvm.func @__ocml_rsqrt_f32(f32) -> f32
    llvm.func @__ocml_rsqrt_f64(f64) -> f64
    llvm.func @gpu_rsqrt(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> attributes {llvm.emit_c_interface} {
      %0 = llvm.call @__ocml_rsqrt_f16(%arg0) : (f16) -> f16
      %1 = llvm.call @__ocml_rsqrt_f32(%arg1) : (f32) -> f32
      %2 = llvm.call @__ocml_rsqrt_f64(%arg2) : (f64) -> f64
      %3 = llvm.mlir.poison : !llvm.struct<(f16, f32, f64)>
      %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(f16, f32, f64)> 
      %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(f16, f32, f64)> 
      %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(f16, f32, f64)> 
      llvm.return %6 : !llvm.struct<(f16, f32, f64)>
    }
    llvm.func @_mlir_ciface_gpu_rsqrt(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_rsqrt(%arg1, %arg2, %arg3) : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      llvm.store %0, %arg0 : !llvm.struct<(f16, f32, f64)>, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @__ocml_tan_f16(f16) -> f16
    llvm.func @__ocml_tan_f32(f32) -> f32
    llvm.func @__ocml_tan_f64(f64) -> f64
    llvm.func @gpu_tan(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> attributes {llvm.emit_c_interface} {
      %0 = llvm.call @__ocml_tan_f16(%arg0) : (f16) -> f16
      %1 = llvm.call @__ocml_tan_f32(%arg1) : (f32) -> f32
      %2 = llvm.call @__ocml_tan_f64(%arg2) : (f64) -> f64
      %3 = llvm.mlir.poison : !llvm.struct<(f16, f32, f64)>
      %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(f16, f32, f64)> 
      %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(f16, f32, f64)> 
      %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(f16, f32, f64)> 
      llvm.return %6 : !llvm.struct<(f16, f32, f64)>
    }
    llvm.func @_mlir_ciface_gpu_tan(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_tan(%arg1, %arg2, %arg3) : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      llvm.store %0, %arg0 : !llvm.struct<(f16, f32, f64)>, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @__ocml_tanh_f16(f16) -> f16
    llvm.func @__ocml_tanh_f32(f32) -> f32
    llvm.func @__ocml_tanh_f64(f64) -> f64
    llvm.func @gpu_tanh(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> attributes {llvm.emit_c_interface} {
      %0 = llvm.call @__ocml_tanh_f16(%arg0) : (f16) -> f16
      %1 = llvm.call @__ocml_tanh_f32(%arg1) : (f32) -> f32
      %2 = llvm.call @__ocml_tanh_f64(%arg2) : (f64) -> f64
      %3 = llvm.mlir.poison : !llvm.struct<(f16, f32, f64)>
      %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(f16, f32, f64)> 
      %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(f16, f32, f64)> 
      %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(f16, f32, f64)> 
      llvm.return %6 : !llvm.struct<(f16, f32, f64)>
    }
    llvm.func @_mlir_ciface_gpu_tanh(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_tanh(%arg1, %arg2, %arg3) : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      llvm.store %0, %arg0 : !llvm.struct<(f16, f32, f64)>, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @__ocml_atan_f16(f16) -> f16
    llvm.func @__ocml_atan_f32(f32) -> f32
    llvm.func @__ocml_atan_f64(f64) -> f64
    llvm.func @gpu_atan(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> attributes {llvm.emit_c_interface} {
      %0 = llvm.call @__ocml_atan_f16(%arg0) : (f16) -> f16
      %1 = llvm.call @__ocml_atan_f32(%arg1) : (f32) -> f32
      %2 = llvm.call @__ocml_atan_f64(%arg2) : (f64) -> f64
      %3 = llvm.mlir.poison : !llvm.struct<(f16, f32, f64)>
      %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(f16, f32, f64)> 
      %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(f16, f32, f64)> 
      %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(f16, f32, f64)> 
      llvm.return %6 : !llvm.struct<(f16, f32, f64)>
    }
    llvm.func @_mlir_ciface_gpu_atan(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_atan(%arg1, %arg2, %arg3) : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      llvm.store %0, %arg0 : !llvm.struct<(f16, f32, f64)>, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @__ocml_atan2_f16(f16, f16) -> f16
    llvm.func @__ocml_atan2_f32(f32, f32) -> f32
    llvm.func @__ocml_atan2_f64(f64, f64) -> f64
    llvm.func @gpu_atan2(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> attributes {llvm.emit_c_interface} {
      %0 = llvm.call @__ocml_atan2_f16(%arg0, %arg0) : (f16, f16) -> f16
      %1 = llvm.call @__ocml_atan2_f32(%arg1, %arg1) : (f32, f32) -> f32
      %2 = llvm.call @__ocml_atan2_f64(%arg2, %arg2) : (f64, f64) -> f64
      %3 = llvm.mlir.poison : !llvm.struct<(f16, f32, f64)>
      %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(f16, f32, f64)> 
      %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(f16, f32, f64)> 
      %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(f16, f32, f64)> 
      llvm.return %6 : !llvm.struct<(f16, f32, f64)>
    }
    llvm.func @_mlir_ciface_gpu_atan2(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_atan2(%arg1, %arg2, %arg3) : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      llvm.store %0, %arg0 : !llvm.struct<(f16, f32, f64)>, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @__ocml_pow_f16(f16, f16) -> f16
    llvm.func @__ocml_pow_f32(f32, f32) -> f32
    llvm.func @__ocml_pow_f64(f64, f64) -> f64
    llvm.func @gpu_pow(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> attributes {llvm.emit_c_interface} {
      %0 = llvm.call @__ocml_pow_f16(%arg0, %arg0) : (f16, f16) -> f16
      %1 = llvm.call @__ocml_pow_f32(%arg1, %arg1) : (f32, f32) -> f32
      %2 = llvm.call @__ocml_pow_f64(%arg2, %arg2) : (f64, f64) -> f64
      %3 = llvm.mlir.poison : !llvm.struct<(f16, f32, f64)>
      %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(f16, f32, f64)> 
      %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(f16, f32, f64)> 
      %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(f16, f32, f64)> 
      llvm.return %6 : !llvm.struct<(f16, f32, f64)>
    }
    llvm.func @_mlir_ciface_gpu_pow(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_pow(%arg1, %arg2, %arg3) : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      llvm.store %0, %arg0 : !llvm.struct<(f16, f32, f64)>, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @__ocml_erf_f16(f16) -> f16
    llvm.func @__ocml_erf_f32(f32) -> f32
    llvm.func @__ocml_erf_f64(f64) -> f64
    llvm.func @gpu_erf(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> attributes {llvm.emit_c_interface} {
      %0 = llvm.call @__ocml_erf_f16(%arg0) : (f16) -> f16
      %1 = llvm.call @__ocml_erf_f32(%arg1) : (f32) -> f32
      %2 = llvm.call @__ocml_erf_f64(%arg2) : (f64) -> f64
      %3 = llvm.mlir.poison : !llvm.struct<(f16, f32, f64)>
      %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(f16, f32, f64)> 
      %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(f16, f32, f64)> 
      %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(f16, f32, f64)> 
      llvm.return %6 : !llvm.struct<(f16, f32, f64)>
    }
    llvm.func @_mlir_ciface_gpu_erf(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_erf(%arg1, %arg2, %arg3) : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      llvm.store %0, %arg0 : !llvm.struct<(f16, f32, f64)>, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @__ocml_sin_f32(f32) -> f32
    llvm.func @gpu_unroll(%arg0: vector<4xf32>) -> vector<4xf32> attributes {llvm.emit_c_interface} {
      %0 = llvm.mlir.poison : vector<4xf32>
      %1 = llvm.mlir.constant(0 : i32) : i32
      %2 = llvm.extractelement %arg0[%1 : i32] : vector<4xf32>
      %3 = llvm.call @__ocml_sin_f32(%2) : (f32) -> f32
      %4 = llvm.insertelement %3, %0[%1 : i32] : vector<4xf32>
      %5 = llvm.mlir.constant(1 : i32) : i32
      %6 = llvm.extractelement %arg0[%5 : i32] : vector<4xf32>
      %7 = llvm.call @__ocml_sin_f32(%6) : (f32) -> f32
      %8 = llvm.insertelement %7, %4[%5 : i32] : vector<4xf32>
      %9 = llvm.mlir.constant(2 : i32) : i32
      %10 = llvm.extractelement %arg0[%9 : i32] : vector<4xf32>
      %11 = llvm.call @__ocml_sin_f32(%10) : (f32) -> f32
      %12 = llvm.insertelement %11, %8[%9 : i32] : vector<4xf32>
      %13 = llvm.mlir.constant(3 : i32) : i32
      %14 = llvm.extractelement %arg0[%13 : i32] : vector<4xf32>
      %15 = llvm.call @__ocml_sin_f32(%14) : (f32) -> f32
      %16 = llvm.insertelement %15, %12[%13 : i32] : vector<4xf32>
      llvm.return %16 : vector<4xf32>
    }
    llvm.func @_mlir_ciface_gpu_unroll(%arg0: vector<4xf32>) -> vector<4xf32> attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_unroll(%arg0) : (vector<4xf32>) -> vector<4xf32>
      llvm.return %0 : vector<4xf32>
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @bf16_id(%arg0: bf16) -> bf16 attributes {llvm.emit_c_interface} {
      llvm.return %arg0 : bf16
    }
    llvm.func @_mlir_ciface_bf16_id(%arg0: bf16) -> bf16 attributes {llvm.emit_c_interface} {
      %0 = llvm.call @bf16_id(%arg0) : (bf16) -> bf16
      llvm.return %0 : bf16
    }
    llvm.func @bf16x4_id(%arg0: vector<4xbf16>) -> vector<4xbf16> attributes {llvm.emit_c_interface} {
      llvm.return %arg0 : vector<4xbf16>
    }
    llvm.func @_mlir_ciface_bf16x4_id(%arg0: vector<4xbf16>) -> vector<4xbf16> attributes {llvm.emit_c_interface} {
      %0 = llvm.call @bf16x4_id(%arg0) : (vector<4xbf16>) -> vector<4xbf16>
      llvm.return %0 : vector<4xbf16>
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @kernel_func() attributes {gpu.kernel, rocdl.kernel} {
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @__ocml_sin_f32(f32) -> f32
    spirv.func @spirv_sin(%arg0: vector<4xf32>) -> vector<4xf32> "None" {
      %0 = llvm.mlir.poison : vector<4xf32>
      %1 = llvm.mlir.constant(0 : i32) : i32
      %2 = llvm.extractelement %arg0[%1 : i32] : vector<4xf32>
      %3 = llvm.call @__ocml_sin_f32(%2) : (f32) -> f32
      %4 = llvm.insertelement %3, %0[%1 : i32] : vector<4xf32>
      %5 = llvm.mlir.constant(1 : i32) : i32
      %6 = llvm.extractelement %arg0[%5 : i32] : vector<4xf32>
      %7 = llvm.call @__ocml_sin_f32(%6) : (f32) -> f32
      %8 = llvm.insertelement %7, %4[%5 : i32] : vector<4xf32>
      %9 = llvm.mlir.constant(2 : i32) : i32
      %10 = llvm.extractelement %arg0[%9 : i32] : vector<4xf32>
      %11 = llvm.call @__ocml_sin_f32(%10) : (f32) -> f32
      %12 = llvm.insertelement %11, %8[%9 : i32] : vector<4xf32>
      %13 = llvm.mlir.constant(3 : i32) : i32
      %14 = llvm.extractelement %arg0[%13 : i32] : vector<4xf32>
      %15 = llvm.call @__ocml_sin_f32(%14) : (f32) -> f32
      %16 = llvm.insertelement %15, %12[%13 : i32] : vector<4xf32>
      spirv.ReturnValue %16 : vector<4xf32>
    }
  }
}

// -----
#mmra_tag = #llvm.mmra_tag<"amdgpu-synchronize-as":"local">
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @__ockl_get_local_size(i32) -> i64
    llvm.mlir.global internal @__wg_gpu_all_reduce_op_0() {addr_space = 3 : i32} : !llvm.array<32 x f32>
    llvm.func @gpu_all_reduce_op() {
      %0 = llvm.mlir.addressof @__wg_gpu_all_reduce_op_0 : !llvm.ptr<3>
      %1 = llvm.getelementptr %0[0, 0] : (!llvm.ptr<3>) -> !llvm.ptr<3>, !llvm.array<32 x f32>
      %2 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %5 = llvm.mlir.constant(0 : index) : i32
      %6 = llvm.insertvalue %5, %4[2] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %7 = llvm.mlir.constant(32 : index) : i32
      %8 = llvm.insertvalue %7, %6[3, 0] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %9 = llvm.mlir.constant(1 : index) : i32
      %10 = llvm.insertvalue %9, %8[4, 0] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %11 = llvm.mlir.constant(0 : index) : i32
      %12 = llvm.mlir.constant(16 : i32) : i32
      %13 = llvm.mlir.constant(8 : i32) : i32
      %14 = llvm.mlir.constant(4 : i32) : i32
      %15 = llvm.mlir.constant(2 : i32) : i32
      %16 = llvm.mlir.constant(1 : i32) : i32
      %17 = llvm.mlir.constant(32 : i32) : i32
      %18 = llvm.mlir.constant(0 : i32) : i32
      %19 = llvm.mlir.constant(31 : i32) : i32
      %20 = llvm.mlir.constant(1.000000e+00 : f32) : f32
      %21 = llvm.mlir.constant(0 : i32) : i32
      %22 = llvm.call @__ockl_get_local_size(%21) : (i32) -> (i64 {llvm.range = #llvm.constant_range<i64, 1, 1025>})
      %23 = llvm.trunc %22 : i64 to i32
      %24 = llvm.mlir.constant(1 : i32) : i32
      %25 = llvm.call @__ockl_get_local_size(%24) : (i32) -> (i64 {llvm.range = #llvm.constant_range<i64, 1, 1025>})
      %26 = llvm.trunc %25 : i64 to i32
      %27 = llvm.mlir.constant(2 : i32) : i32
      %28 = llvm.call @__ockl_get_local_size(%27) : (i32) -> (i64 {llvm.range = #llvm.constant_range<i64, 1, 1025>})
      %29 = llvm.trunc %28 : i64 to i32
      %30 = rocdl.workitem.id.x : i32
      %31 = rocdl.workitem.id.y : i32
      %32 = rocdl.workitem.id.z : i32
      %33 = llvm.mul %32, %26 : i32
      %34 = llvm.add %33, %31 : i32
      %35 = llvm.mul %34, %23 : i32
      %36 = llvm.mul %23, %26 : i32
      %37 = llvm.add %35, %30 : i32
      %38 = llvm.mul %36, %29 : i32
      %39 = llvm.and %37, %19 : i32
      %40 = llvm.icmp "eq" %39, %18 : i32
      %41 = llvm.sub %37, %39 : i32
      %42 = llvm.sub %38, %41 : i32
      %43 = llvm.icmp "slt" %42, %17 : i32
      llvm.cond_br %43, ^bb1, ^bb17
    ^bb1:  // pred: ^bb0
      %44 = llvm.mlir.constant(0 : i32) : i32
      %45 = llvm.mlir.constant(-1 : i32) : i32
      %46 = rocdl.mbcnt.lo %45, %44 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %47 = rocdl.mbcnt.hi %45, %46 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %48 = llvm.mlir.constant(0 : i32) : i32
      %49 = llvm.sub %48, %42 : i32
      %50 = llvm.add %47, %42 : i32
      %51 = llvm.and %50, %49 : i32
      %52 = llvm.xor %47, %16 : i32
      %53 = llvm.icmp "slt" %52, %51 : i32
      %54 = llvm.select %53, %52, %47 : i1, i32
      %55 = llvm.mlir.constant(2 : i32) : i32
      %56 = llvm.shl %54, %55 : i32
      %57 = llvm.bitcast %20 : f32 to i32
      %58 = rocdl.ds_bpermute %56, %57 : (i32, i32) -> i32
      %59 = llvm.bitcast %58 : i32 to f32
      llvm.cond_br %53, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %60 = llvm.fadd %59, %20 : f32
      llvm.br ^bb4(%60 : f32)
    ^bb3:  // pred: ^bb1
      llvm.br ^bb4(%20 : f32)
    ^bb4(%61: f32):  // 2 preds: ^bb2, ^bb3
      %62 = llvm.mlir.constant(0 : i32) : i32
      %63 = llvm.mlir.constant(-1 : i32) : i32
      %64 = rocdl.mbcnt.lo %63, %62 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %65 = rocdl.mbcnt.hi %63, %64 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %66 = llvm.mlir.constant(0 : i32) : i32
      %67 = llvm.sub %66, %42 : i32
      %68 = llvm.add %65, %42 : i32
      %69 = llvm.and %68, %67 : i32
      %70 = llvm.xor %65, %15 : i32
      %71 = llvm.icmp "slt" %70, %69 : i32
      %72 = llvm.select %71, %70, %65 : i1, i32
      %73 = llvm.mlir.constant(2 : i32) : i32
      %74 = llvm.shl %72, %73 : i32
      %75 = llvm.bitcast %61 : f32 to i32
      %76 = rocdl.ds_bpermute %74, %75 : (i32, i32) -> i32
      %77 = llvm.bitcast %76 : i32 to f32
      llvm.cond_br %71, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      %78 = llvm.fadd %61, %77 : f32
      llvm.br ^bb7(%78 : f32)
    ^bb6:  // pred: ^bb4
      llvm.br ^bb7(%61 : f32)
    ^bb7(%79: f32):  // 2 preds: ^bb5, ^bb6
      %80 = llvm.mlir.constant(0 : i32) : i32
      %81 = llvm.mlir.constant(-1 : i32) : i32
      %82 = rocdl.mbcnt.lo %81, %80 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %83 = rocdl.mbcnt.hi %81, %82 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %84 = llvm.mlir.constant(0 : i32) : i32
      %85 = llvm.sub %84, %42 : i32
      %86 = llvm.add %83, %42 : i32
      %87 = llvm.and %86, %85 : i32
      %88 = llvm.xor %83, %14 : i32
      %89 = llvm.icmp "slt" %88, %87 : i32
      %90 = llvm.select %89, %88, %83 : i1, i32
      %91 = llvm.mlir.constant(2 : i32) : i32
      %92 = llvm.shl %90, %91 : i32
      %93 = llvm.bitcast %79 : f32 to i32
      %94 = rocdl.ds_bpermute %92, %93 : (i32, i32) -> i32
      %95 = llvm.bitcast %94 : i32 to f32
      llvm.cond_br %89, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %96 = llvm.fadd %79, %95 : f32
      llvm.br ^bb10(%96 : f32)
    ^bb9:  // pred: ^bb7
      llvm.br ^bb10(%79 : f32)
    ^bb10(%97: f32):  // 2 preds: ^bb8, ^bb9
      %98 = llvm.mlir.constant(0 : i32) : i32
      %99 = llvm.mlir.constant(-1 : i32) : i32
      %100 = rocdl.mbcnt.lo %99, %98 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %101 = rocdl.mbcnt.hi %99, %100 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %102 = llvm.mlir.constant(0 : i32) : i32
      %103 = llvm.sub %102, %42 : i32
      %104 = llvm.add %101, %42 : i32
      %105 = llvm.and %104, %103 : i32
      %106 = llvm.xor %101, %13 : i32
      %107 = llvm.icmp "slt" %106, %105 : i32
      %108 = llvm.select %107, %106, %101 : i1, i32
      %109 = llvm.mlir.constant(2 : i32) : i32
      %110 = llvm.shl %108, %109 : i32
      %111 = llvm.bitcast %97 : f32 to i32
      %112 = rocdl.ds_bpermute %110, %111 : (i32, i32) -> i32
      %113 = llvm.bitcast %112 : i32 to f32
      llvm.cond_br %107, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      %114 = llvm.fadd %97, %113 : f32
      llvm.br ^bb13(%114 : f32)
    ^bb12:  // pred: ^bb10
      llvm.br ^bb13(%97 : f32)
    ^bb13(%115: f32):  // 2 preds: ^bb11, ^bb12
      %116 = llvm.mlir.constant(0 : i32) : i32
      %117 = llvm.mlir.constant(-1 : i32) : i32
      %118 = rocdl.mbcnt.lo %117, %116 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %119 = rocdl.mbcnt.hi %117, %118 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %120 = llvm.mlir.constant(0 : i32) : i32
      %121 = llvm.sub %120, %42 : i32
      %122 = llvm.add %119, %42 : i32
      %123 = llvm.and %122, %121 : i32
      %124 = llvm.xor %119, %12 : i32
      %125 = llvm.icmp "slt" %124, %123 : i32
      %126 = llvm.select %125, %124, %119 : i1, i32
      %127 = llvm.mlir.constant(2 : i32) : i32
      %128 = llvm.shl %126, %127 : i32
      %129 = llvm.bitcast %115 : f32 to i32
      %130 = rocdl.ds_bpermute %128, %129 : (i32, i32) -> i32
      %131 = llvm.bitcast %130 : i32 to f32
      llvm.cond_br %125, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %132 = llvm.fadd %115, %131 : f32
      llvm.br ^bb16(%132 : f32)
    ^bb15:  // pred: ^bb13
      llvm.br ^bb16(%115 : f32)
    ^bb16(%133: f32):  // 2 preds: ^bb14, ^bb15
      llvm.br ^bb18(%133 : f32)
    ^bb17:  // pred: ^bb0
      %134 = llvm.mlir.constant(0 : i32) : i32
      %135 = llvm.mlir.constant(-1 : i32) : i32
      %136 = rocdl.mbcnt.lo %135, %134 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %137 = rocdl.mbcnt.hi %135, %136 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %138 = llvm.mlir.constant(0 : i32) : i32
      %139 = llvm.sub %138, %17 : i32
      %140 = llvm.add %137, %17 : i32
      %141 = llvm.and %140, %139 : i32
      %142 = llvm.xor %137, %16 : i32
      %143 = llvm.icmp "slt" %142, %141 : i32
      %144 = llvm.select %143, %142, %137 : i1, i32
      %145 = llvm.mlir.constant(2 : i32) : i32
      %146 = llvm.shl %144, %145 : i32
      %147 = llvm.bitcast %20 : f32 to i32
      %148 = rocdl.ds_bpermute %146, %147 : (i32, i32) -> i32
      %149 = llvm.bitcast %148 : i32 to f32
      %150 = llvm.fadd %149, %20 : f32
      %151 = llvm.mlir.constant(0 : i32) : i32
      %152 = llvm.mlir.constant(-1 : i32) : i32
      %153 = rocdl.mbcnt.lo %152, %151 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %154 = rocdl.mbcnt.hi %152, %153 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %155 = llvm.mlir.constant(0 : i32) : i32
      %156 = llvm.sub %155, %17 : i32
      %157 = llvm.add %154, %17 : i32
      %158 = llvm.and %157, %156 : i32
      %159 = llvm.xor %154, %15 : i32
      %160 = llvm.icmp "slt" %159, %158 : i32
      %161 = llvm.select %160, %159, %154 : i1, i32
      %162 = llvm.mlir.constant(2 : i32) : i32
      %163 = llvm.shl %161, %162 : i32
      %164 = llvm.bitcast %150 : f32 to i32
      %165 = rocdl.ds_bpermute %163, %164 : (i32, i32) -> i32
      %166 = llvm.bitcast %165 : i32 to f32
      %167 = llvm.fadd %150, %166 : f32
      %168 = llvm.mlir.constant(0 : i32) : i32
      %169 = llvm.mlir.constant(-1 : i32) : i32
      %170 = rocdl.mbcnt.lo %169, %168 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %171 = rocdl.mbcnt.hi %169, %170 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %172 = llvm.mlir.constant(0 : i32) : i32
      %173 = llvm.sub %172, %17 : i32
      %174 = llvm.add %171, %17 : i32
      %175 = llvm.and %174, %173 : i32
      %176 = llvm.xor %171, %14 : i32
      %177 = llvm.icmp "slt" %176, %175 : i32
      %178 = llvm.select %177, %176, %171 : i1, i32
      %179 = llvm.mlir.constant(2 : i32) : i32
      %180 = llvm.shl %178, %179 : i32
      %181 = llvm.bitcast %167 : f32 to i32
      %182 = rocdl.ds_bpermute %180, %181 : (i32, i32) -> i32
      %183 = llvm.bitcast %182 : i32 to f32
      %184 = llvm.fadd %167, %183 : f32
      %185 = llvm.mlir.constant(0 : i32) : i32
      %186 = llvm.mlir.constant(-1 : i32) : i32
      %187 = rocdl.mbcnt.lo %186, %185 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %188 = rocdl.mbcnt.hi %186, %187 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %189 = llvm.mlir.constant(0 : i32) : i32
      %190 = llvm.sub %189, %17 : i32
      %191 = llvm.add %188, %17 : i32
      %192 = llvm.and %191, %190 : i32
      %193 = llvm.xor %188, %13 : i32
      %194 = llvm.icmp "slt" %193, %192 : i32
      %195 = llvm.select %194, %193, %188 : i1, i32
      %196 = llvm.mlir.constant(2 : i32) : i32
      %197 = llvm.shl %195, %196 : i32
      %198 = llvm.bitcast %184 : f32 to i32
      %199 = rocdl.ds_bpermute %197, %198 : (i32, i32) -> i32
      %200 = llvm.bitcast %199 : i32 to f32
      %201 = llvm.fadd %184, %200 : f32
      %202 = llvm.mlir.constant(0 : i32) : i32
      %203 = llvm.mlir.constant(-1 : i32) : i32
      %204 = rocdl.mbcnt.lo %203, %202 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %205 = rocdl.mbcnt.hi %203, %204 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %206 = llvm.mlir.constant(0 : i32) : i32
      %207 = llvm.sub %206, %17 : i32
      %208 = llvm.add %205, %17 : i32
      %209 = llvm.and %208, %207 : i32
      %210 = llvm.xor %205, %12 : i32
      %211 = llvm.icmp "slt" %210, %209 : i32
      %212 = llvm.select %211, %210, %205 : i1, i32
      %213 = llvm.mlir.constant(2 : i32) : i32
      %214 = llvm.shl %212, %213 : i32
      %215 = llvm.bitcast %201 : f32 to i32
      %216 = rocdl.ds_bpermute %214, %215 : (i32, i32) -> i32
      %217 = llvm.bitcast %216 : i32 to f32
      %218 = llvm.fadd %201, %217 : f32
      llvm.br ^bb18(%218 : f32)
    ^bb18(%219: f32):  // 2 preds: ^bb16, ^bb17
      llvm.cond_br %40, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      %220 = llvm.sdiv %37, %17 : i32
      %221 = llvm.extractvalue %10[1] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %222 = llvm.getelementptr inbounds|nuw %221[%220] : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>, f32
      llvm.store %219, %222 : f32, !llvm.ptr<3>
      llvm.br ^bb21
    ^bb20:  // pred: ^bb18
      llvm.br ^bb21
    ^bb21:  // 2 preds: ^bb19, ^bb20
      llvm.fence syncscope("workgroup") release {llvm.mmra = #mmra_tag}
      rocdl.s.barrier
      llvm.fence syncscope("workgroup") acquire {llvm.mmra = #mmra_tag}
      %223 = llvm.add %38, %19 : i32
      %224 = llvm.sdiv %223, %17 : i32
      %225 = llvm.icmp "slt" %37, %224 : i32
      llvm.cond_br %225, ^bb22, ^bb41
    ^bb22:  // pred: ^bb21
      %226 = llvm.extractvalue %10[1] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %227 = llvm.getelementptr inbounds|nuw %226[%37] : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>, f32
      %228 = llvm.load %227 : !llvm.ptr<3> -> f32
      %229 = llvm.icmp "slt" %224, %17 : i32
      llvm.cond_br %229, ^bb23, ^bb39
    ^bb23:  // pred: ^bb22
      %230 = llvm.mlir.constant(0 : i32) : i32
      %231 = llvm.mlir.constant(-1 : i32) : i32
      %232 = rocdl.mbcnt.lo %231, %230 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %233 = rocdl.mbcnt.hi %231, %232 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %234 = llvm.mlir.constant(0 : i32) : i32
      %235 = llvm.sub %234, %224 : i32
      %236 = llvm.add %233, %224 : i32
      %237 = llvm.and %236, %235 : i32
      %238 = llvm.xor %233, %16 : i32
      %239 = llvm.icmp "slt" %238, %237 : i32
      %240 = llvm.select %239, %238, %233 : i1, i32
      %241 = llvm.mlir.constant(2 : i32) : i32
      %242 = llvm.shl %240, %241 : i32
      %243 = llvm.bitcast %228 : f32 to i32
      %244 = rocdl.ds_bpermute %242, %243 : (i32, i32) -> i32
      %245 = llvm.bitcast %244 : i32 to f32
      llvm.cond_br %239, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      %246 = llvm.fadd %228, %245 : f32
      llvm.br ^bb26(%246 : f32)
    ^bb25:  // pred: ^bb23
      llvm.br ^bb26(%228 : f32)
    ^bb26(%247: f32):  // 2 preds: ^bb24, ^bb25
      %248 = llvm.mlir.constant(0 : i32) : i32
      %249 = llvm.mlir.constant(-1 : i32) : i32
      %250 = rocdl.mbcnt.lo %249, %248 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %251 = rocdl.mbcnt.hi %249, %250 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %252 = llvm.mlir.constant(0 : i32) : i32
      %253 = llvm.sub %252, %224 : i32
      %254 = llvm.add %251, %224 : i32
      %255 = llvm.and %254, %253 : i32
      %256 = llvm.xor %251, %15 : i32
      %257 = llvm.icmp "slt" %256, %255 : i32
      %258 = llvm.select %257, %256, %251 : i1, i32
      %259 = llvm.mlir.constant(2 : i32) : i32
      %260 = llvm.shl %258, %259 : i32
      %261 = llvm.bitcast %247 : f32 to i32
      %262 = rocdl.ds_bpermute %260, %261 : (i32, i32) -> i32
      %263 = llvm.bitcast %262 : i32 to f32
      llvm.cond_br %257, ^bb27, ^bb28
    ^bb27:  // pred: ^bb26
      %264 = llvm.fadd %247, %263 : f32
      llvm.br ^bb29(%264 : f32)
    ^bb28:  // pred: ^bb26
      llvm.br ^bb29(%247 : f32)
    ^bb29(%265: f32):  // 2 preds: ^bb27, ^bb28
      %266 = llvm.mlir.constant(0 : i32) : i32
      %267 = llvm.mlir.constant(-1 : i32) : i32
      %268 = rocdl.mbcnt.lo %267, %266 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %269 = rocdl.mbcnt.hi %267, %268 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %270 = llvm.mlir.constant(0 : i32) : i32
      %271 = llvm.sub %270, %224 : i32
      %272 = llvm.add %269, %224 : i32
      %273 = llvm.and %272, %271 : i32
      %274 = llvm.xor %269, %14 : i32
      %275 = llvm.icmp "slt" %274, %273 : i32
      %276 = llvm.select %275, %274, %269 : i1, i32
      %277 = llvm.mlir.constant(2 : i32) : i32
      %278 = llvm.shl %276, %277 : i32
      %279 = llvm.bitcast %265 : f32 to i32
      %280 = rocdl.ds_bpermute %278, %279 : (i32, i32) -> i32
      %281 = llvm.bitcast %280 : i32 to f32
      llvm.cond_br %275, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      %282 = llvm.fadd %265, %281 : f32
      llvm.br ^bb32(%282 : f32)
    ^bb31:  // pred: ^bb29
      llvm.br ^bb32(%265 : f32)
    ^bb32(%283: f32):  // 2 preds: ^bb30, ^bb31
      %284 = llvm.mlir.constant(0 : i32) : i32
      %285 = llvm.mlir.constant(-1 : i32) : i32
      %286 = rocdl.mbcnt.lo %285, %284 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %287 = rocdl.mbcnt.hi %285, %286 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %288 = llvm.mlir.constant(0 : i32) : i32
      %289 = llvm.sub %288, %224 : i32
      %290 = llvm.add %287, %224 : i32
      %291 = llvm.and %290, %289 : i32
      %292 = llvm.xor %287, %13 : i32
      %293 = llvm.icmp "slt" %292, %291 : i32
      %294 = llvm.select %293, %292, %287 : i1, i32
      %295 = llvm.mlir.constant(2 : i32) : i32
      %296 = llvm.shl %294, %295 : i32
      %297 = llvm.bitcast %283 : f32 to i32
      %298 = rocdl.ds_bpermute %296, %297 : (i32, i32) -> i32
      %299 = llvm.bitcast %298 : i32 to f32
      llvm.cond_br %293, ^bb33, ^bb34
    ^bb33:  // pred: ^bb32
      %300 = llvm.fadd %283, %299 : f32
      llvm.br ^bb35(%300 : f32)
    ^bb34:  // pred: ^bb32
      llvm.br ^bb35(%283 : f32)
    ^bb35(%301: f32):  // 2 preds: ^bb33, ^bb34
      %302 = llvm.mlir.constant(0 : i32) : i32
      %303 = llvm.mlir.constant(-1 : i32) : i32
      %304 = rocdl.mbcnt.lo %303, %302 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %305 = rocdl.mbcnt.hi %303, %304 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %306 = llvm.mlir.constant(0 : i32) : i32
      %307 = llvm.sub %306, %224 : i32
      %308 = llvm.add %305, %224 : i32
      %309 = llvm.and %308, %307 : i32
      %310 = llvm.xor %305, %12 : i32
      %311 = llvm.icmp "slt" %310, %309 : i32
      %312 = llvm.select %311, %310, %305 : i1, i32
      %313 = llvm.mlir.constant(2 : i32) : i32
      %314 = llvm.shl %312, %313 : i32
      %315 = llvm.bitcast %301 : f32 to i32
      %316 = rocdl.ds_bpermute %314, %315 : (i32, i32) -> i32
      %317 = llvm.bitcast %316 : i32 to f32
      llvm.cond_br %311, ^bb36, ^bb37
    ^bb36:  // pred: ^bb35
      %318 = llvm.fadd %301, %317 : f32
      llvm.br ^bb38(%318 : f32)
    ^bb37:  // pred: ^bb35
      llvm.br ^bb38(%301 : f32)
    ^bb38(%319: f32):  // 2 preds: ^bb36, ^bb37
      llvm.br ^bb40(%319 : f32)
    ^bb39:  // pred: ^bb22
      %320 = llvm.mlir.constant(0 : i32) : i32
      %321 = llvm.mlir.constant(-1 : i32) : i32
      %322 = rocdl.mbcnt.lo %321, %320 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %323 = rocdl.mbcnt.hi %321, %322 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %324 = llvm.mlir.constant(0 : i32) : i32
      %325 = llvm.sub %324, %17 : i32
      %326 = llvm.add %323, %17 : i32
      %327 = llvm.and %326, %325 : i32
      %328 = llvm.xor %323, %16 : i32
      %329 = llvm.icmp "slt" %328, %327 : i32
      %330 = llvm.select %329, %328, %323 : i1, i32
      %331 = llvm.mlir.constant(2 : i32) : i32
      %332 = llvm.shl %330, %331 : i32
      %333 = llvm.bitcast %228 : f32 to i32
      %334 = rocdl.ds_bpermute %332, %333 : (i32, i32) -> i32
      %335 = llvm.bitcast %334 : i32 to f32
      %336 = llvm.fadd %228, %335 : f32
      %337 = llvm.mlir.constant(0 : i32) : i32
      %338 = llvm.mlir.constant(-1 : i32) : i32
      %339 = rocdl.mbcnt.lo %338, %337 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %340 = rocdl.mbcnt.hi %338, %339 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %341 = llvm.mlir.constant(0 : i32) : i32
      %342 = llvm.sub %341, %17 : i32
      %343 = llvm.add %340, %17 : i32
      %344 = llvm.and %343, %342 : i32
      %345 = llvm.xor %340, %15 : i32
      %346 = llvm.icmp "slt" %345, %344 : i32
      %347 = llvm.select %346, %345, %340 : i1, i32
      %348 = llvm.mlir.constant(2 : i32) : i32
      %349 = llvm.shl %347, %348 : i32
      %350 = llvm.bitcast %336 : f32 to i32
      %351 = rocdl.ds_bpermute %349, %350 : (i32, i32) -> i32
      %352 = llvm.bitcast %351 : i32 to f32
      %353 = llvm.fadd %336, %352 : f32
      %354 = llvm.mlir.constant(0 : i32) : i32
      %355 = llvm.mlir.constant(-1 : i32) : i32
      %356 = rocdl.mbcnt.lo %355, %354 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %357 = rocdl.mbcnt.hi %355, %356 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %358 = llvm.mlir.constant(0 : i32) : i32
      %359 = llvm.sub %358, %17 : i32
      %360 = llvm.add %357, %17 : i32
      %361 = llvm.and %360, %359 : i32
      %362 = llvm.xor %357, %14 : i32
      %363 = llvm.icmp "slt" %362, %361 : i32
      %364 = llvm.select %363, %362, %357 : i1, i32
      %365 = llvm.mlir.constant(2 : i32) : i32
      %366 = llvm.shl %364, %365 : i32
      %367 = llvm.bitcast %353 : f32 to i32
      %368 = rocdl.ds_bpermute %366, %367 : (i32, i32) -> i32
      %369 = llvm.bitcast %368 : i32 to f32
      %370 = llvm.fadd %353, %369 : f32
      %371 = llvm.mlir.constant(0 : i32) : i32
      %372 = llvm.mlir.constant(-1 : i32) : i32
      %373 = rocdl.mbcnt.lo %372, %371 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %374 = rocdl.mbcnt.hi %372, %373 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %375 = llvm.mlir.constant(0 : i32) : i32
      %376 = llvm.sub %375, %17 : i32
      %377 = llvm.add %374, %17 : i32
      %378 = llvm.and %377, %376 : i32
      %379 = llvm.xor %374, %13 : i32
      %380 = llvm.icmp "slt" %379, %378 : i32
      %381 = llvm.select %380, %379, %374 : i1, i32
      %382 = llvm.mlir.constant(2 : i32) : i32
      %383 = llvm.shl %381, %382 : i32
      %384 = llvm.bitcast %370 : f32 to i32
      %385 = rocdl.ds_bpermute %383, %384 : (i32, i32) -> i32
      %386 = llvm.bitcast %385 : i32 to f32
      %387 = llvm.fadd %370, %386 : f32
      %388 = llvm.mlir.constant(0 : i32) : i32
      %389 = llvm.mlir.constant(-1 : i32) : i32
      %390 = rocdl.mbcnt.lo %389, %388 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %391 = rocdl.mbcnt.hi %389, %390 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %392 = llvm.mlir.constant(0 : i32) : i32
      %393 = llvm.sub %392, %17 : i32
      %394 = llvm.add %391, %17 : i32
      %395 = llvm.and %394, %393 : i32
      %396 = llvm.xor %391, %12 : i32
      %397 = llvm.icmp "slt" %396, %395 : i32
      %398 = llvm.select %397, %396, %391 : i1, i32
      %399 = llvm.mlir.constant(2 : i32) : i32
      %400 = llvm.shl %398, %399 : i32
      %401 = llvm.bitcast %387 : f32 to i32
      %402 = rocdl.ds_bpermute %400, %401 : (i32, i32) -> i32
      %403 = llvm.bitcast %402 : i32 to f32
      %404 = llvm.fadd %387, %403 : f32
      llvm.br ^bb40(%404 : f32)
    ^bb40(%405: f32):  // 2 preds: ^bb38, ^bb39
      %406 = llvm.extractvalue %10[1] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %407 = llvm.getelementptr inbounds|nuw %406[%11] : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>, f32
      llvm.store %405, %407 : f32, !llvm.ptr<3>
      llvm.br ^bb42
    ^bb41:  // pred: ^bb21
      llvm.br ^bb42
    ^bb42:  // 2 preds: ^bb40, ^bb41
      llvm.fence syncscope("workgroup") release {llvm.mmra = #mmra_tag}
      rocdl.s.barrier
      llvm.fence syncscope("workgroup") acquire {llvm.mmra = #mmra_tag}
      llvm.return
    }
  }
}

// -----
#mmra_tag = #llvm.mmra_tag<"amdgpu-synchronize-as":"local">
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @__ockl_get_local_size(i32) -> i64
    llvm.mlir.global internal @__wg_gpu_all_reduce_region_0() {addr_space = 3 : i32} : !llvm.array<32 x i32>
    llvm.func @gpu_all_reduce_region() {
      %0 = llvm.mlir.addressof @__wg_gpu_all_reduce_region_0 : !llvm.ptr<3>
      %1 = llvm.getelementptr %0[0, 0] : (!llvm.ptr<3>) -> !llvm.ptr<3>, !llvm.array<32 x i32>
      %2 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %5 = llvm.mlir.constant(0 : index) : i32
      %6 = llvm.insertvalue %5, %4[2] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %7 = llvm.mlir.constant(32 : index) : i32
      %8 = llvm.insertvalue %7, %6[3, 0] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %9 = llvm.mlir.constant(1 : index) : i32
      %10 = llvm.insertvalue %9, %8[4, 0] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %11 = llvm.mlir.constant(0 : index) : i32
      %12 = llvm.mlir.constant(16 : i32) : i32
      %13 = llvm.mlir.constant(8 : i32) : i32
      %14 = llvm.mlir.constant(4 : i32) : i32
      %15 = llvm.mlir.constant(2 : i32) : i32
      %16 = llvm.mlir.constant(32 : i32) : i32
      %17 = llvm.mlir.constant(0 : i32) : i32
      %18 = llvm.mlir.constant(31 : i32) : i32
      %19 = llvm.mlir.constant(1 : i32) : i32
      %20 = llvm.mlir.constant(0 : i32) : i32
      %21 = llvm.call @__ockl_get_local_size(%20) : (i32) -> (i64 {llvm.range = #llvm.constant_range<i64, 1, 1025>})
      %22 = llvm.trunc %21 : i64 to i32
      %23 = llvm.mlir.constant(1 : i32) : i32
      %24 = llvm.call @__ockl_get_local_size(%23) : (i32) -> (i64 {llvm.range = #llvm.constant_range<i64, 1, 1025>})
      %25 = llvm.trunc %24 : i64 to i32
      %26 = llvm.mlir.constant(2 : i32) : i32
      %27 = llvm.call @__ockl_get_local_size(%26) : (i32) -> (i64 {llvm.range = #llvm.constant_range<i64, 1, 1025>})
      %28 = llvm.trunc %27 : i64 to i32
      %29 = rocdl.workitem.id.x : i32
      %30 = rocdl.workitem.id.y : i32
      %31 = rocdl.workitem.id.z : i32
      %32 = llvm.mul %31, %25 : i32
      %33 = llvm.add %32, %30 : i32
      %34 = llvm.mul %33, %22 : i32
      %35 = llvm.mul %22, %25 : i32
      %36 = llvm.add %34, %29 : i32
      %37 = llvm.mul %35, %28 : i32
      %38 = llvm.and %36, %18 : i32
      %39 = llvm.icmp "eq" %38, %17 : i32
      %40 = llvm.sub %36, %38 : i32
      %41 = llvm.sub %37, %40 : i32
      %42 = llvm.icmp "slt" %41, %16 : i32
      llvm.cond_br %42, ^bb1, ^bb22
    ^bb1:  // pred: ^bb0
      %43 = llvm.mlir.constant(0 : i32) : i32
      %44 = llvm.mlir.constant(-1 : i32) : i32
      %45 = rocdl.mbcnt.lo %44, %43 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %46 = rocdl.mbcnt.hi %44, %45 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %47 = llvm.mlir.constant(0 : i32) : i32
      %48 = llvm.sub %47, %41 : i32
      %49 = llvm.add %46, %41 : i32
      %50 = llvm.and %49, %48 : i32
      %51 = llvm.xor %46, %19 : i32
      %52 = llvm.icmp "slt" %51, %50 : i32
      %53 = llvm.select %52, %51, %46 : i1, i32
      %54 = llvm.mlir.constant(2 : i32) : i32
      %55 = llvm.shl %53, %54 : i32
      %56 = rocdl.ds_bpermute %55, %19 : (i32, i32) -> i32
      llvm.cond_br %52, ^bb2, ^bb4(%19 : i32)
    ^bb2:  // pred: ^bb1
      llvm.br ^bb3
    ^bb3:  // pred: ^bb2
      %57 = llvm.xor %56, %19 : i32
      llvm.br ^bb4(%57 : i32)
    ^bb4(%58: i32):  // 2 preds: ^bb1, ^bb3
      llvm.br ^bb5
    ^bb5:  // pred: ^bb4
      %59 = llvm.mlir.constant(0 : i32) : i32
      %60 = llvm.mlir.constant(-1 : i32) : i32
      %61 = rocdl.mbcnt.lo %60, %59 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %62 = rocdl.mbcnt.hi %60, %61 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %63 = llvm.mlir.constant(0 : i32) : i32
      %64 = llvm.sub %63, %41 : i32
      %65 = llvm.add %62, %41 : i32
      %66 = llvm.and %65, %64 : i32
      %67 = llvm.xor %62, %15 : i32
      %68 = llvm.icmp "slt" %67, %66 : i32
      %69 = llvm.select %68, %67, %62 : i1, i32
      %70 = llvm.mlir.constant(2 : i32) : i32
      %71 = llvm.shl %69, %70 : i32
      %72 = rocdl.ds_bpermute %71, %58 : (i32, i32) -> i32
      llvm.cond_br %68, ^bb6, ^bb8(%58 : i32)
    ^bb6:  // pred: ^bb5
      llvm.br ^bb7
    ^bb7:  // pred: ^bb6
      %73 = llvm.xor %58, %72 : i32
      llvm.br ^bb8(%73 : i32)
    ^bb8(%74: i32):  // 2 preds: ^bb5, ^bb7
      llvm.br ^bb9
    ^bb9:  // pred: ^bb8
      %75 = llvm.mlir.constant(0 : i32) : i32
      %76 = llvm.mlir.constant(-1 : i32) : i32
      %77 = rocdl.mbcnt.lo %76, %75 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %78 = rocdl.mbcnt.hi %76, %77 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %79 = llvm.mlir.constant(0 : i32) : i32
      %80 = llvm.sub %79, %41 : i32
      %81 = llvm.add %78, %41 : i32
      %82 = llvm.and %81, %80 : i32
      %83 = llvm.xor %78, %14 : i32
      %84 = llvm.icmp "slt" %83, %82 : i32
      %85 = llvm.select %84, %83, %78 : i1, i32
      %86 = llvm.mlir.constant(2 : i32) : i32
      %87 = llvm.shl %85, %86 : i32
      %88 = rocdl.ds_bpermute %87, %74 : (i32, i32) -> i32
      llvm.cond_br %84, ^bb10, ^bb12(%74 : i32)
    ^bb10:  // pred: ^bb9
      llvm.br ^bb11
    ^bb11:  // pred: ^bb10
      %89 = llvm.xor %74, %88 : i32
      llvm.br ^bb12(%89 : i32)
    ^bb12(%90: i32):  // 2 preds: ^bb9, ^bb11
      llvm.br ^bb13
    ^bb13:  // pred: ^bb12
      %91 = llvm.mlir.constant(0 : i32) : i32
      %92 = llvm.mlir.constant(-1 : i32) : i32
      %93 = rocdl.mbcnt.lo %92, %91 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %94 = rocdl.mbcnt.hi %92, %93 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %95 = llvm.mlir.constant(0 : i32) : i32
      %96 = llvm.sub %95, %41 : i32
      %97 = llvm.add %94, %41 : i32
      %98 = llvm.and %97, %96 : i32
      %99 = llvm.xor %94, %13 : i32
      %100 = llvm.icmp "slt" %99, %98 : i32
      %101 = llvm.select %100, %99, %94 : i1, i32
      %102 = llvm.mlir.constant(2 : i32) : i32
      %103 = llvm.shl %101, %102 : i32
      %104 = rocdl.ds_bpermute %103, %90 : (i32, i32) -> i32
      llvm.cond_br %100, ^bb14, ^bb16(%90 : i32)
    ^bb14:  // pred: ^bb13
      llvm.br ^bb15
    ^bb15:  // pred: ^bb14
      %105 = llvm.xor %90, %104 : i32
      llvm.br ^bb16(%105 : i32)
    ^bb16(%106: i32):  // 2 preds: ^bb13, ^bb15
      llvm.br ^bb17
    ^bb17:  // pred: ^bb16
      %107 = llvm.mlir.constant(0 : i32) : i32
      %108 = llvm.mlir.constant(-1 : i32) : i32
      %109 = rocdl.mbcnt.lo %108, %107 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %110 = rocdl.mbcnt.hi %108, %109 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %111 = llvm.mlir.constant(0 : i32) : i32
      %112 = llvm.sub %111, %41 : i32
      %113 = llvm.add %110, %41 : i32
      %114 = llvm.and %113, %112 : i32
      %115 = llvm.xor %110, %12 : i32
      %116 = llvm.icmp "slt" %115, %114 : i32
      %117 = llvm.select %116, %115, %110 : i1, i32
      %118 = llvm.mlir.constant(2 : i32) : i32
      %119 = llvm.shl %117, %118 : i32
      %120 = rocdl.ds_bpermute %119, %106 : (i32, i32) -> i32
      llvm.cond_br %116, ^bb18, ^bb20(%106 : i32)
    ^bb18:  // pred: ^bb17
      llvm.br ^bb19
    ^bb19:  // pred: ^bb18
      %121 = llvm.xor %106, %120 : i32
      llvm.br ^bb20(%121 : i32)
    ^bb20(%122: i32):  // 2 preds: ^bb17, ^bb19
      llvm.br ^bb21(%122 : i32)
    ^bb21(%123: i32):  // 2 preds: ^bb20, ^bb31
      llvm.br ^bb32
    ^bb22:  // pred: ^bb0
      %124 = llvm.mlir.constant(0 : i32) : i32
      %125 = llvm.mlir.constant(-1 : i32) : i32
      %126 = rocdl.mbcnt.lo %125, %124 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %127 = rocdl.mbcnt.hi %125, %126 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %128 = llvm.mlir.constant(0 : i32) : i32
      %129 = llvm.sub %128, %16 : i32
      %130 = llvm.add %127, %16 : i32
      %131 = llvm.and %130, %129 : i32
      %132 = llvm.xor %127, %19 : i32
      %133 = llvm.icmp "slt" %132, %131 : i32
      %134 = llvm.select %133, %132, %127 : i1, i32
      %135 = llvm.mlir.constant(2 : i32) : i32
      %136 = llvm.shl %134, %135 : i32
      %137 = rocdl.ds_bpermute %136, %19 : (i32, i32) -> i32
      llvm.br ^bb23
    ^bb23:  // pred: ^bb22
      %138 = llvm.xor %137, %19 : i32
      llvm.br ^bb24
    ^bb24:  // pred: ^bb23
      %139 = llvm.mlir.constant(0 : i32) : i32
      %140 = llvm.mlir.constant(-1 : i32) : i32
      %141 = rocdl.mbcnt.lo %140, %139 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %142 = rocdl.mbcnt.hi %140, %141 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %143 = llvm.mlir.constant(0 : i32) : i32
      %144 = llvm.sub %143, %16 : i32
      %145 = llvm.add %142, %16 : i32
      %146 = llvm.and %145, %144 : i32
      %147 = llvm.xor %142, %15 : i32
      %148 = llvm.icmp "slt" %147, %146 : i32
      %149 = llvm.select %148, %147, %142 : i1, i32
      %150 = llvm.mlir.constant(2 : i32) : i32
      %151 = llvm.shl %149, %150 : i32
      %152 = rocdl.ds_bpermute %151, %138 : (i32, i32) -> i32
      llvm.br ^bb25
    ^bb25:  // pred: ^bb24
      %153 = llvm.xor %138, %152 : i32
      llvm.br ^bb26
    ^bb26:  // pred: ^bb25
      %154 = llvm.mlir.constant(0 : i32) : i32
      %155 = llvm.mlir.constant(-1 : i32) : i32
      %156 = rocdl.mbcnt.lo %155, %154 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %157 = rocdl.mbcnt.hi %155, %156 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %158 = llvm.mlir.constant(0 : i32) : i32
      %159 = llvm.sub %158, %16 : i32
      %160 = llvm.add %157, %16 : i32
      %161 = llvm.and %160, %159 : i32
      %162 = llvm.xor %157, %14 : i32
      %163 = llvm.icmp "slt" %162, %161 : i32
      %164 = llvm.select %163, %162, %157 : i1, i32
      %165 = llvm.mlir.constant(2 : i32) : i32
      %166 = llvm.shl %164, %165 : i32
      %167 = rocdl.ds_bpermute %166, %153 : (i32, i32) -> i32
      llvm.br ^bb27
    ^bb27:  // pred: ^bb26
      %168 = llvm.xor %153, %167 : i32
      llvm.br ^bb28
    ^bb28:  // pred: ^bb27
      %169 = llvm.mlir.constant(0 : i32) : i32
      %170 = llvm.mlir.constant(-1 : i32) : i32
      %171 = rocdl.mbcnt.lo %170, %169 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %172 = rocdl.mbcnt.hi %170, %171 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %173 = llvm.mlir.constant(0 : i32) : i32
      %174 = llvm.sub %173, %16 : i32
      %175 = llvm.add %172, %16 : i32
      %176 = llvm.and %175, %174 : i32
      %177 = llvm.xor %172, %13 : i32
      %178 = llvm.icmp "slt" %177, %176 : i32
      %179 = llvm.select %178, %177, %172 : i1, i32
      %180 = llvm.mlir.constant(2 : i32) : i32
      %181 = llvm.shl %179, %180 : i32
      %182 = rocdl.ds_bpermute %181, %168 : (i32, i32) -> i32
      llvm.br ^bb29
    ^bb29:  // pred: ^bb28
      %183 = llvm.xor %168, %182 : i32
      llvm.br ^bb30
    ^bb30:  // pred: ^bb29
      %184 = llvm.mlir.constant(0 : i32) : i32
      %185 = llvm.mlir.constant(-1 : i32) : i32
      %186 = rocdl.mbcnt.lo %185, %184 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %187 = rocdl.mbcnt.hi %185, %186 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %188 = llvm.mlir.constant(0 : i32) : i32
      %189 = llvm.sub %188, %16 : i32
      %190 = llvm.add %187, %16 : i32
      %191 = llvm.and %190, %189 : i32
      %192 = llvm.xor %187, %12 : i32
      %193 = llvm.icmp "slt" %192, %191 : i32
      %194 = llvm.select %193, %192, %187 : i1, i32
      %195 = llvm.mlir.constant(2 : i32) : i32
      %196 = llvm.shl %194, %195 : i32
      %197 = rocdl.ds_bpermute %196, %183 : (i32, i32) -> i32
      llvm.br ^bb31
    ^bb31:  // pred: ^bb30
      %198 = llvm.xor %183, %197 : i32
      llvm.br ^bb21(%198 : i32)
    ^bb32:  // pred: ^bb21
      llvm.cond_br %39, ^bb33, ^bb34
    ^bb33:  // pred: ^bb32
      %199 = llvm.sdiv %36, %16 : i32
      %200 = llvm.extractvalue %10[1] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %201 = llvm.getelementptr inbounds|nuw %200[%199] : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>, i32
      llvm.store %123, %201 : i32, !llvm.ptr<3>
      llvm.br ^bb35
    ^bb34:  // pred: ^bb32
      llvm.br ^bb35
    ^bb35:  // 2 preds: ^bb33, ^bb34
      llvm.fence syncscope("workgroup") release {llvm.mmra = #mmra_tag}
      rocdl.s.barrier
      llvm.fence syncscope("workgroup") acquire {llvm.mmra = #mmra_tag}
      %202 = llvm.add %37, %18 : i32
      %203 = llvm.sdiv %202, %16 : i32
      %204 = llvm.icmp "slt" %36, %203 : i32
      llvm.cond_br %204, ^bb36, ^bb69
    ^bb36:  // pred: ^bb35
      %205 = llvm.extractvalue %10[1] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %206 = llvm.getelementptr inbounds|nuw %205[%36] : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>, i32
      %207 = llvm.load %206 : !llvm.ptr<3> -> i32
      %208 = llvm.icmp "slt" %203, %16 : i32
      llvm.cond_br %208, ^bb37, ^bb58
    ^bb37:  // pred: ^bb36
      %209 = llvm.mlir.constant(0 : i32) : i32
      %210 = llvm.mlir.constant(-1 : i32) : i32
      %211 = rocdl.mbcnt.lo %210, %209 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %212 = rocdl.mbcnt.hi %210, %211 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %213 = llvm.mlir.constant(0 : i32) : i32
      %214 = llvm.sub %213, %203 : i32
      %215 = llvm.add %212, %203 : i32
      %216 = llvm.and %215, %214 : i32
      %217 = llvm.xor %212, %19 : i32
      %218 = llvm.icmp "slt" %217, %216 : i32
      %219 = llvm.select %218, %217, %212 : i1, i32
      %220 = llvm.mlir.constant(2 : i32) : i32
      %221 = llvm.shl %219, %220 : i32
      %222 = rocdl.ds_bpermute %221, %207 : (i32, i32) -> i32
      llvm.cond_br %218, ^bb38, ^bb40(%207 : i32)
    ^bb38:  // pred: ^bb37
      llvm.br ^bb39
    ^bb39:  // pred: ^bb38
      %223 = llvm.xor %207, %222 : i32
      llvm.br ^bb40(%223 : i32)
    ^bb40(%224: i32):  // 2 preds: ^bb37, ^bb39
      llvm.br ^bb41
    ^bb41:  // pred: ^bb40
      %225 = llvm.mlir.constant(0 : i32) : i32
      %226 = llvm.mlir.constant(-1 : i32) : i32
      %227 = rocdl.mbcnt.lo %226, %225 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %228 = rocdl.mbcnt.hi %226, %227 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %229 = llvm.mlir.constant(0 : i32) : i32
      %230 = llvm.sub %229, %203 : i32
      %231 = llvm.add %228, %203 : i32
      %232 = llvm.and %231, %230 : i32
      %233 = llvm.xor %228, %15 : i32
      %234 = llvm.icmp "slt" %233, %232 : i32
      %235 = llvm.select %234, %233, %228 : i1, i32
      %236 = llvm.mlir.constant(2 : i32) : i32
      %237 = llvm.shl %235, %236 : i32
      %238 = rocdl.ds_bpermute %237, %224 : (i32, i32) -> i32
      llvm.cond_br %234, ^bb42, ^bb44(%224 : i32)
    ^bb42:  // pred: ^bb41
      llvm.br ^bb43
    ^bb43:  // pred: ^bb42
      %239 = llvm.xor %224, %238 : i32
      llvm.br ^bb44(%239 : i32)
    ^bb44(%240: i32):  // 2 preds: ^bb41, ^bb43
      llvm.br ^bb45
    ^bb45:  // pred: ^bb44
      %241 = llvm.mlir.constant(0 : i32) : i32
      %242 = llvm.mlir.constant(-1 : i32) : i32
      %243 = rocdl.mbcnt.lo %242, %241 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %244 = rocdl.mbcnt.hi %242, %243 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %245 = llvm.mlir.constant(0 : i32) : i32
      %246 = llvm.sub %245, %203 : i32
      %247 = llvm.add %244, %203 : i32
      %248 = llvm.and %247, %246 : i32
      %249 = llvm.xor %244, %14 : i32
      %250 = llvm.icmp "slt" %249, %248 : i32
      %251 = llvm.select %250, %249, %244 : i1, i32
      %252 = llvm.mlir.constant(2 : i32) : i32
      %253 = llvm.shl %251, %252 : i32
      %254 = rocdl.ds_bpermute %253, %240 : (i32, i32) -> i32
      llvm.cond_br %250, ^bb46, ^bb48(%240 : i32)
    ^bb46:  // pred: ^bb45
      llvm.br ^bb47
    ^bb47:  // pred: ^bb46
      %255 = llvm.xor %240, %254 : i32
      llvm.br ^bb48(%255 : i32)
    ^bb48(%256: i32):  // 2 preds: ^bb45, ^bb47
      llvm.br ^bb49
    ^bb49:  // pred: ^bb48
      %257 = llvm.mlir.constant(0 : i32) : i32
      %258 = llvm.mlir.constant(-1 : i32) : i32
      %259 = rocdl.mbcnt.lo %258, %257 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %260 = rocdl.mbcnt.hi %258, %259 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %261 = llvm.mlir.constant(0 : i32) : i32
      %262 = llvm.sub %261, %203 : i32
      %263 = llvm.add %260, %203 : i32
      %264 = llvm.and %263, %262 : i32
      %265 = llvm.xor %260, %13 : i32
      %266 = llvm.icmp "slt" %265, %264 : i32
      %267 = llvm.select %266, %265, %260 : i1, i32
      %268 = llvm.mlir.constant(2 : i32) : i32
      %269 = llvm.shl %267, %268 : i32
      %270 = rocdl.ds_bpermute %269, %256 : (i32, i32) -> i32
      llvm.cond_br %266, ^bb50, ^bb52(%256 : i32)
    ^bb50:  // pred: ^bb49
      llvm.br ^bb51
    ^bb51:  // pred: ^bb50
      %271 = llvm.xor %256, %270 : i32
      llvm.br ^bb52(%271 : i32)
    ^bb52(%272: i32):  // 2 preds: ^bb49, ^bb51
      llvm.br ^bb53
    ^bb53:  // pred: ^bb52
      %273 = llvm.mlir.constant(0 : i32) : i32
      %274 = llvm.mlir.constant(-1 : i32) : i32
      %275 = rocdl.mbcnt.lo %274, %273 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %276 = rocdl.mbcnt.hi %274, %275 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %277 = llvm.mlir.constant(0 : i32) : i32
      %278 = llvm.sub %277, %203 : i32
      %279 = llvm.add %276, %203 : i32
      %280 = llvm.and %279, %278 : i32
      %281 = llvm.xor %276, %12 : i32
      %282 = llvm.icmp "slt" %281, %280 : i32
      %283 = llvm.select %282, %281, %276 : i1, i32
      %284 = llvm.mlir.constant(2 : i32) : i32
      %285 = llvm.shl %283, %284 : i32
      %286 = rocdl.ds_bpermute %285, %272 : (i32, i32) -> i32
      llvm.cond_br %282, ^bb54, ^bb56(%272 : i32)
    ^bb54:  // pred: ^bb53
      llvm.br ^bb55
    ^bb55:  // pred: ^bb54
      %287 = llvm.xor %272, %286 : i32
      llvm.br ^bb56(%287 : i32)
    ^bb56(%288: i32):  // 2 preds: ^bb53, ^bb55
      llvm.br ^bb57(%288 : i32)
    ^bb57(%289: i32):  // 2 preds: ^bb56, ^bb67
      llvm.br ^bb68
    ^bb58:  // pred: ^bb36
      %290 = llvm.mlir.constant(0 : i32) : i32
      %291 = llvm.mlir.constant(-1 : i32) : i32
      %292 = rocdl.mbcnt.lo %291, %290 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %293 = rocdl.mbcnt.hi %291, %292 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %294 = llvm.mlir.constant(0 : i32) : i32
      %295 = llvm.sub %294, %16 : i32
      %296 = llvm.add %293, %16 : i32
      %297 = llvm.and %296, %295 : i32
      %298 = llvm.xor %293, %19 : i32
      %299 = llvm.icmp "slt" %298, %297 : i32
      %300 = llvm.select %299, %298, %293 : i1, i32
      %301 = llvm.mlir.constant(2 : i32) : i32
      %302 = llvm.shl %300, %301 : i32
      %303 = rocdl.ds_bpermute %302, %207 : (i32, i32) -> i32
      llvm.br ^bb59
    ^bb59:  // pred: ^bb58
      %304 = llvm.xor %207, %303 : i32
      llvm.br ^bb60
    ^bb60:  // pred: ^bb59
      %305 = llvm.mlir.constant(0 : i32) : i32
      %306 = llvm.mlir.constant(-1 : i32) : i32
      %307 = rocdl.mbcnt.lo %306, %305 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %308 = rocdl.mbcnt.hi %306, %307 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %309 = llvm.mlir.constant(0 : i32) : i32
      %310 = llvm.sub %309, %16 : i32
      %311 = llvm.add %308, %16 : i32
      %312 = llvm.and %311, %310 : i32
      %313 = llvm.xor %308, %15 : i32
      %314 = llvm.icmp "slt" %313, %312 : i32
      %315 = llvm.select %314, %313, %308 : i1, i32
      %316 = llvm.mlir.constant(2 : i32) : i32
      %317 = llvm.shl %315, %316 : i32
      %318 = rocdl.ds_bpermute %317, %304 : (i32, i32) -> i32
      llvm.br ^bb61
    ^bb61:  // pred: ^bb60
      %319 = llvm.xor %304, %318 : i32
      llvm.br ^bb62
    ^bb62:  // pred: ^bb61
      %320 = llvm.mlir.constant(0 : i32) : i32
      %321 = llvm.mlir.constant(-1 : i32) : i32
      %322 = rocdl.mbcnt.lo %321, %320 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %323 = rocdl.mbcnt.hi %321, %322 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %324 = llvm.mlir.constant(0 : i32) : i32
      %325 = llvm.sub %324, %16 : i32
      %326 = llvm.add %323, %16 : i32
      %327 = llvm.and %326, %325 : i32
      %328 = llvm.xor %323, %14 : i32
      %329 = llvm.icmp "slt" %328, %327 : i32
      %330 = llvm.select %329, %328, %323 : i1, i32
      %331 = llvm.mlir.constant(2 : i32) : i32
      %332 = llvm.shl %330, %331 : i32
      %333 = rocdl.ds_bpermute %332, %319 : (i32, i32) -> i32
      llvm.br ^bb63
    ^bb63:  // pred: ^bb62
      %334 = llvm.xor %319, %333 : i32
      llvm.br ^bb64
    ^bb64:  // pred: ^bb63
      %335 = llvm.mlir.constant(0 : i32) : i32
      %336 = llvm.mlir.constant(-1 : i32) : i32
      %337 = rocdl.mbcnt.lo %336, %335 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %338 = rocdl.mbcnt.hi %336, %337 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %339 = llvm.mlir.constant(0 : i32) : i32
      %340 = llvm.sub %339, %16 : i32
      %341 = llvm.add %338, %16 : i32
      %342 = llvm.and %341, %340 : i32
      %343 = llvm.xor %338, %13 : i32
      %344 = llvm.icmp "slt" %343, %342 : i32
      %345 = llvm.select %344, %343, %338 : i1, i32
      %346 = llvm.mlir.constant(2 : i32) : i32
      %347 = llvm.shl %345, %346 : i32
      %348 = rocdl.ds_bpermute %347, %334 : (i32, i32) -> i32
      llvm.br ^bb65
    ^bb65:  // pred: ^bb64
      %349 = llvm.xor %334, %348 : i32
      llvm.br ^bb66
    ^bb66:  // pred: ^bb65
      %350 = llvm.mlir.constant(0 : i32) : i32
      %351 = llvm.mlir.constant(-1 : i32) : i32
      %352 = rocdl.mbcnt.lo %351, %350 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %353 = rocdl.mbcnt.hi %351, %352 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %354 = llvm.mlir.constant(0 : i32) : i32
      %355 = llvm.sub %354, %16 : i32
      %356 = llvm.add %353, %16 : i32
      %357 = llvm.and %356, %355 : i32
      %358 = llvm.xor %353, %12 : i32
      %359 = llvm.icmp "slt" %358, %357 : i32
      %360 = llvm.select %359, %358, %353 : i1, i32
      %361 = llvm.mlir.constant(2 : i32) : i32
      %362 = llvm.shl %360, %361 : i32
      %363 = rocdl.ds_bpermute %362, %349 : (i32, i32) -> i32
      llvm.br ^bb67
    ^bb67:  // pred: ^bb66
      %364 = llvm.xor %349, %363 : i32
      llvm.br ^bb57(%364 : i32)
    ^bb68:  // pred: ^bb57
      %365 = llvm.extractvalue %10[1] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %366 = llvm.getelementptr inbounds|nuw %365[%11] : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>, i32
      llvm.store %289, %366 : i32, !llvm.ptr<3>
      llvm.br ^bb70
    ^bb69:  // pred: ^bb35
      llvm.br ^bb70
    ^bb70:  // 2 preds: ^bb68, ^bb69
      llvm.fence syncscope("workgroup") release {llvm.mmra = #mmra_tag}
      rocdl.s.barrier
      llvm.fence syncscope("workgroup") acquire {llvm.mmra = #mmra_tag}
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @__ocml_fmod_f16(f16, f16) -> f16
    llvm.func @__ocml_fmod_f32(f32, f32) -> f32
    llvm.func @__ocml_fmod_f64(f64, f64) -> f64
    llvm.func @gpu_fmod(%arg0: f16, %arg1: f32, %arg2: f64) -> !llvm.struct<(f16, f32, f64)> attributes {llvm.emit_c_interface} {
      %0 = llvm.call @__ocml_fmod_f16(%arg0, %arg0) : (f16, f16) -> f16
      %1 = llvm.call @__ocml_fmod_f32(%arg1, %arg1) : (f32, f32) -> f32
      %2 = llvm.call @__ocml_fmod_f64(%arg2, %arg2) : (f64, f64) -> f64
      %3 = llvm.mlir.poison : !llvm.struct<(f16, f32, f64)>
      %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(f16, f32, f64)> 
      %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(f16, f32, f64)> 
      %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(f16, f32, f64)> 
      llvm.return %6 : !llvm.struct<(f16, f32, f64)>
    }
    llvm.func @_mlir_ciface_gpu_fmod(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_fmod(%arg1, %arg2, %arg3) : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      llvm.store %0, %arg0 : !llvm.struct<(f16, f32, f64)>, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @gpu_shuffle() -> !llvm.struct<(f32, f32, f32, f32)> attributes {llvm.emit_c_interface} {
      %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
      %1 = llvm.mlir.constant(4 : i32) : i32
      %2 = llvm.mlir.constant(23 : i32) : i32
      %3 = llvm.mlir.constant(0 : i32) : i32
      %4 = llvm.mlir.constant(-1 : i32) : i32
      %5 = rocdl.mbcnt.lo %4, %3 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %6 = rocdl.mbcnt.hi %4, %5 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %7 = llvm.mlir.constant(0 : i32) : i32
      %8 = llvm.sub %7, %2 : i32
      %9 = llvm.add %6, %2 : i32
      %10 = llvm.and %9, %8 : i32
      %11 = llvm.xor %6, %1 : i32
      %12 = llvm.icmp "slt" %11, %10 : i32
      %13 = llvm.select %12, %11, %6 : i1, i32
      %14 = llvm.mlir.constant(2 : i32) : i32
      %15 = llvm.shl %13, %14 : i32
      %16 = llvm.bitcast %0 : f32 to i32
      %17 = rocdl.ds_bpermute %15, %16 : (i32, i32) -> i32
      %18 = llvm.bitcast %17 : i32 to f32
      %19 = llvm.mlir.constant(0 : i32) : i32
      %20 = llvm.mlir.constant(-1 : i32) : i32
      %21 = rocdl.mbcnt.lo %20, %19 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %22 = rocdl.mbcnt.hi %20, %21 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %23 = llvm.mlir.constant(0 : i32) : i32
      %24 = llvm.sub %23, %2 : i32
      %25 = llvm.add %22, %2 : i32
      %26 = llvm.and %25, %24 : i32
      %27 = llvm.icmp "slt" %1, %26 : i32
      %28 = llvm.select %27, %1, %22 : i1, i32
      %29 = llvm.mlir.constant(2 : i32) : i32
      %30 = llvm.shl %28, %29 : i32
      %31 = llvm.bitcast %0 : f32 to i32
      %32 = rocdl.ds_bpermute %30, %31 : (i32, i32) -> i32
      %33 = llvm.bitcast %32 : i32 to f32
      %34 = llvm.mlir.constant(0 : i32) : i32
      %35 = llvm.mlir.constant(-1 : i32) : i32
      %36 = rocdl.mbcnt.lo %35, %34 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %37 = rocdl.mbcnt.hi %35, %36 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %38 = llvm.mlir.constant(0 : i32) : i32
      %39 = llvm.sub %38, %2 : i32
      %40 = llvm.add %37, %2 : i32
      %41 = llvm.and %40, %39 : i32
      %42 = llvm.sub %37, %1 : i32
      %43 = llvm.icmp "slt" %42, %41 : i32
      %44 = llvm.select %43, %42, %37 : i1, i32
      %45 = llvm.mlir.constant(2 : i32) : i32
      %46 = llvm.shl %44, %45 : i32
      %47 = llvm.bitcast %0 : f32 to i32
      %48 = rocdl.ds_bpermute %46, %47 : (i32, i32) -> i32
      %49 = llvm.bitcast %48 : i32 to f32
      %50 = llvm.mlir.constant(0 : i32) : i32
      %51 = llvm.mlir.constant(-1 : i32) : i32
      %52 = rocdl.mbcnt.lo %51, %50 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %53 = rocdl.mbcnt.hi %51, %52 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %54 = llvm.mlir.constant(0 : i32) : i32
      %55 = llvm.sub %54, %2 : i32
      %56 = llvm.add %53, %2 : i32
      %57 = llvm.and %56, %55 : i32
      %58 = llvm.add %53, %1 : i32
      %59 = llvm.icmp "slt" %58, %57 : i32
      %60 = llvm.select %59, %58, %53 : i1, i32
      %61 = llvm.mlir.constant(2 : i32) : i32
      %62 = llvm.shl %60, %61 : i32
      %63 = llvm.bitcast %0 : f32 to i32
      %64 = rocdl.ds_bpermute %62, %63 : (i32, i32) -> i32
      %65 = llvm.bitcast %64 : i32 to f32
      %66 = llvm.mlir.poison : !llvm.struct<(f32, f32, f32, f32)>
      %67 = llvm.insertvalue %18, %66[0] : !llvm.struct<(f32, f32, f32, f32)> 
      %68 = llvm.insertvalue %33, %67[1] : !llvm.struct<(f32, f32, f32, f32)> 
      %69 = llvm.insertvalue %49, %68[2] : !llvm.struct<(f32, f32, f32, f32)> 
      %70 = llvm.insertvalue %65, %69[3] : !llvm.struct<(f32, f32, f32, f32)> 
      llvm.return %70 : !llvm.struct<(f32, f32, f32, f32)>
    }
    llvm.func @_mlir_ciface_gpu_shuffle(%arg0: !llvm.ptr) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_shuffle() : () -> !llvm.struct<(f32, f32, f32, f32)>
      llvm.store %0, %arg0 : !llvm.struct<(f32, f32, f32, f32)>, !llvm.ptr
      llvm.return
    }
    llvm.func @gpu_shuffle_promote() -> !llvm.struct<(f32, f32, f32)> attributes {llvm.emit_c_interface} {
      %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
      %1 = llvm.bitcast %0 : f32 to i32
      %2 = llvm.mlir.constant(4127 : i32) : i32
      %3 = rocdl.ds_swizzle %1, %2 : (i32, i32) -> i32
      %4 = llvm.bitcast %3 : i32 to f32
      %5 = llvm.bitcast %0 : f32 to i32
      %6 = rocdl.permlane16.swap %5, %5, false, false : (i32, i32) -> <(i32, i32)>
      %7 = llvm.extractvalue %6[0] : !llvm.struct<(i32, i32)> 
      %8 = llvm.extractvalue %6[1] : !llvm.struct<(i32, i32)> 
      %9 = llvm.icmp "eq" %7, %5 : i32
      %10 = llvm.select %9, %8, %7 : i1, i32
      %11 = llvm.bitcast %10 : i32 to f32
      %12 = llvm.bitcast %0 : f32 to i32
      %13 = rocdl.permlane32.swap %12, %12, false, false : (i32, i32) -> <(i32, i32)>
      %14 = llvm.extractvalue %13[0] : !llvm.struct<(i32, i32)> 
      %15 = llvm.extractvalue %13[1] : !llvm.struct<(i32, i32)> 
      %16 = llvm.icmp "eq" %14, %12 : i32
      %17 = llvm.select %16, %15, %14 : i1, i32
      %18 = llvm.bitcast %17 : i32 to f32
      %19 = llvm.mlir.poison : !llvm.struct<(f32, f32, f32)>
      %20 = llvm.insertvalue %4, %19[0] : !llvm.struct<(f32, f32, f32)> 
      %21 = llvm.insertvalue %11, %20[1] : !llvm.struct<(f32, f32, f32)> 
      %22 = llvm.insertvalue %18, %21[2] : !llvm.struct<(f32, f32, f32)> 
      llvm.return %22 : !llvm.struct<(f32, f32, f32)>
    }
    llvm.func @_mlir_ciface_gpu_shuffle_promote(%arg0: !llvm.ptr) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_shuffle_promote() : () -> !llvm.struct<(f32, f32, f32)>
      llvm.store %0, %arg0 : !llvm.struct<(f32, f32, f32)>, !llvm.ptr
      llvm.return
    }
    llvm.func @gpu_shuffle_vec(%arg0: vector<4xf16>, %arg1: i32, %arg2: i32) -> vector<4xf16> attributes {llvm.emit_c_interface} {
      %0 = llvm.mlir.constant(0 : i32) : i32
      %1 = llvm.mlir.constant(-1 : i32) : i32
      %2 = rocdl.mbcnt.lo %1, %0 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %3 = rocdl.mbcnt.hi %1, %2 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %4 = llvm.mlir.constant(0 : i32) : i32
      %5 = llvm.sub %4, %arg2 : i32
      %6 = llvm.add %3, %arg2 : i32
      %7 = llvm.and %6, %5 : i32
      %8 = llvm.xor %3, %arg1 : i32
      %9 = llvm.icmp "slt" %8, %7 : i32
      %10 = llvm.select %9, %8, %3 : i1, i32
      %11 = llvm.mlir.constant(2 : i32) : i32
      %12 = llvm.shl %10, %11 : i32
      %13 = llvm.bitcast %arg0 : vector<4xf16> to vector<2xi32>
      %14 = llvm.mlir.constant(0 : i32) : i32
      %15 = llvm.extractelement %13[%14 : i32] : vector<2xi32>
      %16 = llvm.mlir.constant(1 : i32) : i32
      %17 = llvm.extractelement %13[%16 : i32] : vector<2xi32>
      %18 = rocdl.ds_bpermute %12, %15 : (i32, i32) -> i32
      %19 = rocdl.ds_bpermute %12, %17 : (i32, i32) -> i32
      %20 = llvm.mlir.poison : vector<2xi32>
      %21 = llvm.mlir.constant(0 : i32) : i32
      %22 = llvm.insertelement %18, %20[%21 : i32] : vector<2xi32>
      %23 = llvm.mlir.constant(1 : i32) : i32
      %24 = llvm.insertelement %19, %22[%23 : i32] : vector<2xi32>
      %25 = llvm.bitcast %24 : vector<2xi32> to vector<4xf16>
      llvm.return %25 : vector<4xf16>
    }
    llvm.func @_mlir_ciface_gpu_shuffle_vec(%arg0: vector<4xf16>, %arg1: i32, %arg2: i32) -> vector<4xf16> attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_shuffle_vec(%arg0, %arg1, %arg2) : (vector<4xf16>, i32, i32) -> vector<4xf16>
      llvm.return %0 : vector<4xf16>
    }
  }
}

// -----
module {
  gpu.module @test_custom_data_layout attributes {llvm.data_layout = "e"} {
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @__ockl_get_local_size(i32) -> i64
    llvm.func @gpu_dim_int_max_upper_bound() -> i32 attributes {llvm.emit_c_interface} {
      %0 = llvm.mlir.constant(0 : i32) : i32
      %1 = llvm.call @__ockl_get_local_size(%0) : (i32) -> (i64 {llvm.range = #llvm.constant_range<i64, 1, 2147483648>})
      %2 = llvm.trunc %1 : i64 to i32
      llvm.return %2 : i32
    }
    llvm.func @_mlir_ciface_gpu_dim_int_max_upper_bound() -> i32 attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_dim_int_max_upper_bound() : () -> i32
      llvm.return %0 : i32
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @broadcast(%arg0: i32, %arg1: i32) -> !llvm.struct<(i32, i32)> attributes {llvm.emit_c_interface} {
      %0 = rocdl.readfirstlane %arg0 : i32
      %1 = rocdl.readlane %arg0, %arg1 : (i32, i32) -> i32
      %2 = llvm.mlir.poison : !llvm.struct<(i32, i32)>
      %3 = llvm.insertvalue %0, %2[0] : !llvm.struct<(i32, i32)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(i32, i32)> 
      llvm.return %4 : !llvm.struct<(i32, i32)>
    }
    llvm.func @_mlir_ciface_broadcast(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @broadcast(%arg1, %arg2) : (i32, i32) -> !llvm.struct<(i32, i32)>
      llvm.store %0, %arg0 : !llvm.struct<(i32, i32)>, !llvm.ptr
      llvm.return
    }
    llvm.func @broadcast_i8(%arg0: i8, %arg1: i32) -> !llvm.struct<(i8, i8)> attributes {llvm.emit_c_interface} {
      %0 = llvm.zext %arg0 : i8 to i32
      %1 = rocdl.readfirstlane %0 : i32
      %2 = llvm.trunc %1 : i32 to i8
      %3 = llvm.zext %arg0 : i8 to i32
      %4 = rocdl.readlane %3, %arg1 : (i32, i32) -> i32
      %5 = llvm.trunc %4 : i32 to i8
      %6 = llvm.mlir.poison : !llvm.struct<(i8, i8)>
      %7 = llvm.insertvalue %2, %6[0] : !llvm.struct<(i8, i8)> 
      %8 = llvm.insertvalue %5, %7[1] : !llvm.struct<(i8, i8)> 
      llvm.return %8 : !llvm.struct<(i8, i8)>
    }
    llvm.func @_mlir_ciface_broadcast_i8(%arg0: !llvm.ptr, %arg1: i8, %arg2: i32) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @broadcast_i8(%arg1, %arg2) : (i8, i32) -> !llvm.struct<(i8, i8)>
      llvm.store %0, %arg0 : !llvm.struct<(i8, i8)>, !llvm.ptr
      llvm.return
    }
    llvm.func @broadcast_4xi16(%arg0: vector<4xi16>) -> vector<4xi16> attributes {llvm.emit_c_interface} {
      %0 = llvm.bitcast %arg0 : vector<4xi16> to vector<2xi32>
      %1 = llvm.mlir.constant(0 : i32) : i32
      %2 = llvm.extractelement %0[%1 : i32] : vector<2xi32>
      %3 = llvm.mlir.constant(1 : i32) : i32
      %4 = llvm.extractelement %0[%3 : i32] : vector<2xi32>
      %5 = rocdl.readfirstlane %2 : i32
      %6 = rocdl.readfirstlane %4 : i32
      %7 = llvm.mlir.poison : vector<2xi32>
      %8 = llvm.mlir.constant(0 : i32) : i32
      %9 = llvm.insertelement %5, %7[%8 : i32] : vector<2xi32>
      %10 = llvm.mlir.constant(1 : i32) : i32
      %11 = llvm.insertelement %6, %9[%10 : i32] : vector<2xi32>
      %12 = llvm.bitcast %11 : vector<2xi32> to vector<4xi16>
      llvm.return %12 : vector<4xi16>
    }
    llvm.func @_mlir_ciface_broadcast_4xi16(%arg0: vector<4xi16>) -> vector<4xi16> attributes {llvm.emit_c_interface} {
      %0 = llvm.call @broadcast_4xi16(%arg0) : (vector<4xi16>) -> vector<4xi16>
      llvm.return %0 : vector<4xi16>
    }
    llvm.func @broadcast_2x2xi16(%arg0: !llvm.array<2 x vector<2xi16>>) -> !llvm.array<2 x vector<2xi16>> attributes {llvm.emit_c_interface} {
      %0 = llvm.extractvalue %arg0[0] : !llvm.array<2 x vector<2xi16>> 
      %1 = llvm.bitcast %0 : vector<2xi16> to i32
      %2 = llvm.extractvalue %arg0[1] : !llvm.array<2 x vector<2xi16>> 
      %3 = llvm.bitcast %2 : vector<2xi16> to i32
      %4 = rocdl.readfirstlane %1 : i32
      %5 = rocdl.readfirstlane %3 : i32
      %6 = llvm.mlir.poison : !llvm.array<2 x vector<2xi16>>
      %7 = llvm.bitcast %4 : i32 to vector<2xi16>
      %8 = llvm.insertvalue %7, %6[0] : !llvm.array<2 x vector<2xi16>> 
      %9 = llvm.bitcast %5 : i32 to vector<2xi16>
      %10 = llvm.insertvalue %9, %8[1] : !llvm.array<2 x vector<2xi16>> 
      llvm.return %10 : !llvm.array<2 x vector<2xi16>>
    }
    llvm.func @_mlir_ciface_broadcast_2x2xi16(%arg0: !llvm.array<2 x vector<2xi16>>) -> !llvm.array<2 x vector<2xi16>> attributes {llvm.emit_c_interface} {
      %0 = llvm.call @broadcast_2x2xi16(%arg0) : (!llvm.array<2 x vector<2xi16>>) -> !llvm.array<2 x vector<2xi16>>
      llvm.return %0 : !llvm.array<2 x vector<2xi16>>
    }
    llvm.func @broadcast_memref(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32, %arg3: i32, %arg4: i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> attributes {llvm.emit_c_interface} {
      %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %5 = llvm.insertvalue %arg4, %4[4, 0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %6 = llvm.extractvalue %5[0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %7 = llvm.extractvalue %5[1] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %8 = llvm.extractvalue %5[2] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %9 = llvm.extractvalue %5[3] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %10 = llvm.extractvalue %9[0] : !llvm.array<1 x i32> 
      %11 = llvm.extractvalue %5[4] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %12 = llvm.extractvalue %11[0] : !llvm.array<1 x i32> 
      %13 = rocdl.readfirstlane %6 : !llvm.ptr
      %14 = rocdl.readfirstlane %7 : !llvm.ptr
      %15 = rocdl.readfirstlane %8 : i32
      %16 = rocdl.readfirstlane %10 : i32
      %17 = rocdl.readfirstlane %12 : i32
      %18 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %19 = llvm.insertvalue %13, %18[0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %20 = llvm.insertvalue %14, %19[1] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %21 = llvm.insertvalue %15, %20[2] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %22 = llvm.mlir.poison : !llvm.array<1 x i32>
      %23 = llvm.insertvalue %16, %22[0] : !llvm.array<1 x i32> 
      %24 = llvm.insertvalue %23, %21[3] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %25 = llvm.mlir.poison : !llvm.array<1 x i32>
      %26 = llvm.insertvalue %17, %25[0] : !llvm.array<1 x i32> 
      %27 = llvm.insertvalue %26, %24[4] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      llvm.return %27 : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    }
    llvm.func @_mlir_ciface_broadcast_memref(%arg0: !llvm.ptr, %arg1: !llvm.ptr) attributes {llvm.emit_c_interface} {
      %0 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %4 = llvm.extractvalue %0[3, 0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %5 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %6 = llvm.call @broadcast_memref(%1, %2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i32, i32, i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      llvm.store %6, %arg0 : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr
      llvm.return
    }
    llvm.func @broadcast_i48(%arg0: i48) -> i48 attributes {llvm.emit_c_interface} {
      %0 = llvm.zext %arg0 : i48 to i64
      %1 = llvm.bitcast %0 : i64 to vector<2xi32>
      %2 = llvm.mlir.constant(0 : i32) : i32
      %3 = llvm.extractelement %1[%2 : i32] : vector<2xi32>
      %4 = llvm.mlir.constant(1 : i32) : i32
      %5 = llvm.extractelement %1[%4 : i32] : vector<2xi32>
      %6 = rocdl.readfirstlane %3 : i32
      %7 = rocdl.readfirstlane %5 : i32
      %8 = llvm.mlir.poison : vector<2xi32>
      %9 = llvm.mlir.constant(0 : i32) : i32
      %10 = llvm.insertelement %6, %8[%9 : i32] : vector<2xi32>
      %11 = llvm.mlir.constant(1 : i32) : i32
      %12 = llvm.insertelement %7, %10[%11 : i32] : vector<2xi32>
      %13 = llvm.bitcast %12 : vector<2xi32> to i64
      %14 = llvm.trunc %13 : i64 to i48
      llvm.return %14 : i48
    }
    llvm.func @_mlir_ciface_broadcast_i48(%arg0: i48) -> i48 attributes {llvm.emit_c_interface} {
      %0 = llvm.call @broadcast_i48(%arg0) : (i48) -> i48
      llvm.return %0 : i48
    }
    llvm.func @broadcast_3xi16(%arg0: vector<3xi16>) -> vector<3xi16> attributes {llvm.emit_c_interface} {
      %0 = llvm.bitcast %arg0 : vector<3xi16> to i48
      %1 = llvm.zext %0 : i48 to i64
      %2 = llvm.bitcast %1 : i64 to vector<2xi32>
      %3 = llvm.mlir.constant(0 : i32) : i32
      %4 = llvm.extractelement %2[%3 : i32] : vector<2xi32>
      %5 = llvm.mlir.constant(1 : i32) : i32
      %6 = llvm.extractelement %2[%5 : i32] : vector<2xi32>
      %7 = rocdl.readfirstlane %4 : i32
      %8 = rocdl.readfirstlane %6 : i32
      %9 = llvm.mlir.poison : vector<2xi32>
      %10 = llvm.mlir.constant(0 : i32) : i32
      %11 = llvm.insertelement %7, %9[%10 : i32] : vector<2xi32>
      %12 = llvm.mlir.constant(1 : i32) : i32
      %13 = llvm.insertelement %8, %11[%12 : i32] : vector<2xi32>
      %14 = llvm.bitcast %13 : vector<2xi32> to i64
      %15 = llvm.trunc %14 : i64 to i48
      %16 = llvm.bitcast %15 : i48 to vector<3xi16>
      llvm.return %16 : vector<3xi16>
    }
    llvm.func @_mlir_ciface_broadcast_3xi16(%arg0: vector<3xi16>) -> vector<3xi16> attributes {llvm.emit_c_interface} {
      %0 = llvm.call @broadcast_3xi16(%arg0) : (vector<3xi16>) -> vector<3xi16>
      llvm.return %0 : vector<3xi16>
    }
    llvm.func @ballot(%arg0: i1) -> !llvm.struct<(i32, i64)> attributes {llvm.emit_c_interface} {
      %0 = rocdl.ballot %arg0 : i32
      %1 = rocdl.ballot %arg0 : i64
      %2 = llvm.mlir.poison : !llvm.struct<(i32, i64)>
      %3 = llvm.insertvalue %0, %2[0] : !llvm.struct<(i32, i64)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(i32, i64)> 
      llvm.return %4 : !llvm.struct<(i32, i64)>
    }
    llvm.func @_mlir_ciface_ballot(%arg0: !llvm.ptr, %arg1: i1) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @ballot(%arg1) : (i1) -> !llvm.struct<(i32, i64)>
      llvm.store %0, %arg0 : !llvm.struct<(i32, i64)>, !llvm.ptr
      llvm.return
    }
  }
}

