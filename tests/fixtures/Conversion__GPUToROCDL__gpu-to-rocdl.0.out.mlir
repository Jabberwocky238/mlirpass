module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @gpu_index_ops() -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> attributes {llvm.emit_c_interface} {
      %0 = rocdl.workitem.id.x : i32
      %1 = llvm.sext %0 : i32 to i64
      %2 = rocdl.workitem.id.y : i32
      %3 = llvm.sext %2 : i32 to i64
      %4 = rocdl.workitem.id.z : i32
      %5 = llvm.sext %4 : i32 to i64
      %6 = rocdl.workgroup.dim.x : i32
      %7 = llvm.sext %6 : i32 to i64
      %8 = rocdl.workgroup.dim.y : i32
      %9 = llvm.sext %8 : i32 to i64
      %10 = rocdl.workgroup.dim.z : i32
      %11 = llvm.sext %10 : i32 to i64
      %12 = rocdl.workgroup.id.x : i32
      %13 = llvm.sext %12 : i32 to i64
      %14 = rocdl.workgroup.id.y : i32
      %15 = llvm.sext %14 : i32 to i64
      %16 = rocdl.workgroup.id.z : i32
      %17 = llvm.sext %16 : i32 to i64
      %18 = rocdl.grid.dim.x : i32
      %19 = llvm.sext %18 : i32 to i64
      %20 = rocdl.grid.dim.y : i32
      %21 = llvm.sext %20 : i32 to i64
      %22 = rocdl.grid.dim.z : i32
      %23 = llvm.sext %22 : i32 to i64
      %24 = llvm.mlir.constant(0 : i32) : i32
      %25 = llvm.mlir.constant(-1 : i32) : i32
      %26 = rocdl.mbcnt.lo %25, %24 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %27 = rocdl.mbcnt.hi %25, %26 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %28 = llvm.sext %27 : i32 to i64
      %29 = rocdl.wavefrontsize : i32
      %30 = llvm.sext %29 : i32 to i64
      %31 = rocdl.wavefrontsize range <i32, 64, 65> : i32
      %32 = llvm.sext %31 : i32 to i64
      %33 = llvm.mlir.poison : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %34 = llvm.insertvalue %1, %33[0] : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> 
      %35 = llvm.insertvalue %3, %34[1] : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> 
      %36 = llvm.insertvalue %5, %35[2] : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> 
      %37 = llvm.insertvalue %7, %36[3] : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> 
      %38 = llvm.insertvalue %9, %37[4] : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> 
      %39 = llvm.insertvalue %11, %38[5] : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> 
      %40 = llvm.insertvalue %13, %39[6] : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> 
      %41 = llvm.insertvalue %15, %40[7] : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> 
      %42 = llvm.insertvalue %17, %41[8] : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> 
      %43 = llvm.insertvalue %19, %42[9] : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> 
      %44 = llvm.insertvalue %21, %43[10] : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> 
      %45 = llvm.insertvalue %23, %44[11] : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> 
      %46 = llvm.insertvalue %28, %45[12] : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> 
      %47 = llvm.insertvalue %30, %46[13] : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> 
      %48 = llvm.insertvalue %32, %47[14] : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> 
      llvm.return %48 : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
    }
    llvm.func @_mlir_ciface_gpu_index_ops(%arg0: !llvm.ptr) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_index_ops() : () -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      llvm.store %0, %arg0 : !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @gpu_index_ops_range(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64) attributes {gpu.kernel, gpu.known_block_size = array<i32: 8, 12, 16>, gpu.known_grid_size = array<i32: 20, 24, 28>, rocdl.flat_work_group_size = "1536,1536", rocdl.kernel, rocdl.reqd_work_group_size = array<i32: 8, 12, 16>} {
      %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64)>
      %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64)> 
      %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64)> 
      %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64)> 
      %4 = rocdl.workitem.id.x range <i32, 0, 8> : i32
      %5 = llvm.sext %4 : i32 to i64
      %6 = rocdl.workitem.id.y range <i32, 0, 12> : i32
      %7 = llvm.sext %6 : i32 to i64
      %8 = rocdl.workitem.id.z range <i32, 0, 16> : i32
      %9 = llvm.sext %8 : i32 to i64
      %10 = rocdl.workgroup.id.x range <i32, 0, 20> : i32
      %11 = llvm.sext %10 : i32 to i64
      %12 = rocdl.workgroup.id.y range <i32, 0, 24> : i32
      %13 = llvm.sext %12 : i32 to i64
      %14 = rocdl.workgroup.id.z range <i32, 0, 28> : i32
      %15 = llvm.sext %14 : i32 to i64
      %16 = llvm.add %5, %7 : i64
      %17 = llvm.add %16, %9 : i64
      %18 = llvm.add %17, %11 : i64
      %19 = llvm.add %18, %13 : i64
      %20 = llvm.add %19, %15 : i64
      %21 = llvm.trunc %20 : i64 to i32
      %22 = llvm.extractvalue %3[1] : !llvm.struct<(ptr, ptr, i64)> 
      llvm.store %21, %22 : i32, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @gpu_index_comp(%arg0: i64) -> i64 attributes {llvm.emit_c_interface} {
      %0 = llvm.add %arg0, %arg0 : i64
      llvm.return %0 : i64
    }
    llvm.func @_mlir_ciface_gpu_index_comp(%arg0: i64) -> i64 attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_index_comp(%arg0) : (i64) -> i64
      llvm.return %0 : i64
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @gpu_sync() attributes {llvm.emit_c_interface} {
      rocdl.barrier
      llvm.return
    }
    llvm.func @_mlir_ciface_gpu_sync() attributes {llvm.emit_c_interface} {
      llvm.call @gpu_sync() : () -> ()
      llvm.return
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
      %1 = llvm.mlir.constant(0 : i64) : i64
      %2 = llvm.extractelement %arg0[%1 : i64] : vector<4xf32>
      %3 = llvm.call @__ocml_sin_f32(%2) : (f32) -> f32
      %4 = llvm.insertelement %3, %0[%1 : i64] : vector<4xf32>
      %5 = llvm.mlir.constant(1 : i64) : i64
      %6 = llvm.extractelement %arg0[%5 : i64] : vector<4xf32>
      %7 = llvm.call @__ocml_sin_f32(%6) : (f32) -> f32
      %8 = llvm.insertelement %7, %4[%5 : i64] : vector<4xf32>
      %9 = llvm.mlir.constant(2 : i64) : i64
      %10 = llvm.extractelement %arg0[%9 : i64] : vector<4xf32>
      %11 = llvm.call @__ocml_sin_f32(%10) : (f32) -> f32
      %12 = llvm.insertelement %11, %8[%9 : i64] : vector<4xf32>
      %13 = llvm.mlir.constant(3 : i64) : i64
      %14 = llvm.extractelement %arg0[%13 : i64] : vector<4xf32>
      %15 = llvm.call @__ocml_sin_f32(%14) : (f32) -> f32
      %16 = llvm.insertelement %15, %12[%13 : i64] : vector<4xf32>
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
      %1 = llvm.mlir.constant(0 : i64) : i64
      %2 = llvm.extractelement %arg0[%1 : i64] : vector<4xf32>
      %3 = llvm.call @__ocml_sin_f32(%2) : (f32) -> f32
      %4 = llvm.insertelement %3, %0[%1 : i64] : vector<4xf32>
      %5 = llvm.mlir.constant(1 : i64) : i64
      %6 = llvm.extractelement %arg0[%5 : i64] : vector<4xf32>
      %7 = llvm.call @__ocml_sin_f32(%6) : (f32) -> f32
      %8 = llvm.insertelement %7, %4[%5 : i64] : vector<4xf32>
      %9 = llvm.mlir.constant(2 : i64) : i64
      %10 = llvm.extractelement %arg0[%9 : i64] : vector<4xf32>
      %11 = llvm.call @__ocml_sin_f32(%10) : (f32) -> f32
      %12 = llvm.insertelement %11, %8[%9 : i64] : vector<4xf32>
      %13 = llvm.mlir.constant(3 : i64) : i64
      %14 = llvm.extractelement %arg0[%13 : i64] : vector<4xf32>
      %15 = llvm.call @__ocml_sin_f32(%14) : (f32) -> f32
      %16 = llvm.insertelement %15, %12[%13 : i64] : vector<4xf32>
      spirv.ReturnValue %16 : vector<4xf32>
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.mlir.global internal @__wg_gpu_all_reduce_op_0() {addr_space = 3 : i32} : !llvm.array<32 x f32>
    llvm.func @gpu_all_reduce_op() {
      %0 = llvm.mlir.addressof @__wg_gpu_all_reduce_op_0 : !llvm.ptr<3>
      %1 = llvm.getelementptr %0[0, 0] : (!llvm.ptr<3>) -> !llvm.ptr<3>, !llvm.array<32 x f32>
      %2 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %5 = llvm.mlir.constant(0 : index) : i64
      %6 = llvm.insertvalue %5, %4[2] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %7 = llvm.mlir.constant(32 : index) : i64
      %8 = llvm.insertvalue %7, %6[3, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %9 = llvm.mlir.constant(1 : index) : i64
      %10 = llvm.insertvalue %9, %8[4, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %11 = llvm.mlir.constant(0 : index) : i64
      %12 = llvm.mlir.constant(16 : i32) : i32
      %13 = llvm.mlir.constant(8 : i32) : i32
      %14 = llvm.mlir.constant(4 : i32) : i32
      %15 = llvm.mlir.constant(2 : i32) : i32
      %16 = llvm.mlir.constant(1 : i32) : i32
      %17 = llvm.mlir.constant(32 : i32) : i32
      %18 = llvm.mlir.constant(0 : i32) : i32
      %19 = llvm.mlir.constant(31 : i32) : i32
      %20 = llvm.mlir.constant(1.000000e+00 : f32) : f32
      %21 = rocdl.workgroup.dim.x : i32
      %22 = llvm.sext %21 : i32 to i64
      %23 = llvm.trunc %22 : i64 to i32
      %24 = rocdl.workgroup.dim.y : i32
      %25 = llvm.sext %24 : i32 to i64
      %26 = llvm.trunc %25 : i64 to i32
      %27 = rocdl.workgroup.dim.z : i32
      %28 = llvm.sext %27 : i32 to i64
      %29 = llvm.trunc %28 : i64 to i32
      %30 = rocdl.workitem.id.x : i32
      %31 = llvm.sext %30 : i32 to i64
      %32 = llvm.trunc %31 : i64 to i32
      %33 = rocdl.workitem.id.y : i32
      %34 = llvm.sext %33 : i32 to i64
      %35 = llvm.trunc %34 : i64 to i32
      %36 = rocdl.workitem.id.z : i32
      %37 = llvm.sext %36 : i32 to i64
      %38 = llvm.trunc %37 : i64 to i32
      %39 = llvm.mul %38, %26 : i32
      %40 = llvm.add %39, %35 : i32
      %41 = llvm.mul %40, %23 : i32
      %42 = llvm.mul %23, %26 : i32
      %43 = llvm.add %41, %32 : i32
      %44 = llvm.mul %42, %29 : i32
      %45 = llvm.and %43, %19 : i32
      %46 = llvm.icmp "eq" %45, %18 : i32
      %47 = llvm.sub %43, %45 : i32
      %48 = llvm.sub %44, %47 : i32
      %49 = llvm.icmp "slt" %48, %17 : i32
      llvm.cond_br %49, ^bb1, ^bb17
    ^bb1:  // pred: ^bb0
      %50 = llvm.mlir.constant(0 : i32) : i32
      %51 = llvm.mlir.constant(-1 : i32) : i32
      %52 = rocdl.mbcnt.lo %51, %50 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %53 = rocdl.mbcnt.hi %51, %52 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %54 = llvm.mlir.constant(0 : i32) : i32
      %55 = llvm.sub %54, %48 : i32
      %56 = llvm.add %53, %48 : i32
      %57 = llvm.and %56, %55 : i32
      %58 = llvm.xor %53, %16 : i32
      %59 = llvm.icmp "slt" %58, %57 : i32
      %60 = llvm.select %59, %58, %53 : i1, i32
      %61 = llvm.mlir.constant(2 : i32) : i32
      %62 = llvm.shl %60, %61 : i32
      %63 = llvm.bitcast %20 : f32 to i32
      %64 = rocdl.ds_bpermute %62, %63 : (i32, i32) -> i32
      %65 = llvm.bitcast %64 : i32 to f32
      llvm.cond_br %59, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %66 = llvm.fadd %65, %20 : f32
      llvm.br ^bb4(%66 : f32)
    ^bb3:  // pred: ^bb1
      llvm.br ^bb4(%20 : f32)
    ^bb4(%67: f32):  // 2 preds: ^bb2, ^bb3
      %68 = llvm.mlir.constant(0 : i32) : i32
      %69 = llvm.mlir.constant(-1 : i32) : i32
      %70 = rocdl.mbcnt.lo %69, %68 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %71 = rocdl.mbcnt.hi %69, %70 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %72 = llvm.mlir.constant(0 : i32) : i32
      %73 = llvm.sub %72, %48 : i32
      %74 = llvm.add %71, %48 : i32
      %75 = llvm.and %74, %73 : i32
      %76 = llvm.xor %71, %15 : i32
      %77 = llvm.icmp "slt" %76, %75 : i32
      %78 = llvm.select %77, %76, %71 : i1, i32
      %79 = llvm.mlir.constant(2 : i32) : i32
      %80 = llvm.shl %78, %79 : i32
      %81 = llvm.bitcast %67 : f32 to i32
      %82 = rocdl.ds_bpermute %80, %81 : (i32, i32) -> i32
      %83 = llvm.bitcast %82 : i32 to f32
      llvm.cond_br %77, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      %84 = llvm.fadd %67, %83 : f32
      llvm.br ^bb7(%84 : f32)
    ^bb6:  // pred: ^bb4
      llvm.br ^bb7(%67 : f32)
    ^bb7(%85: f32):  // 2 preds: ^bb5, ^bb6
      %86 = llvm.mlir.constant(0 : i32) : i32
      %87 = llvm.mlir.constant(-1 : i32) : i32
      %88 = rocdl.mbcnt.lo %87, %86 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %89 = rocdl.mbcnt.hi %87, %88 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %90 = llvm.mlir.constant(0 : i32) : i32
      %91 = llvm.sub %90, %48 : i32
      %92 = llvm.add %89, %48 : i32
      %93 = llvm.and %92, %91 : i32
      %94 = llvm.xor %89, %14 : i32
      %95 = llvm.icmp "slt" %94, %93 : i32
      %96 = llvm.select %95, %94, %89 : i1, i32
      %97 = llvm.mlir.constant(2 : i32) : i32
      %98 = llvm.shl %96, %97 : i32
      %99 = llvm.bitcast %85 : f32 to i32
      %100 = rocdl.ds_bpermute %98, %99 : (i32, i32) -> i32
      %101 = llvm.bitcast %100 : i32 to f32
      llvm.cond_br %95, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %102 = llvm.fadd %85, %101 : f32
      llvm.br ^bb10(%102 : f32)
    ^bb9:  // pred: ^bb7
      llvm.br ^bb10(%85 : f32)
    ^bb10(%103: f32):  // 2 preds: ^bb8, ^bb9
      %104 = llvm.mlir.constant(0 : i32) : i32
      %105 = llvm.mlir.constant(-1 : i32) : i32
      %106 = rocdl.mbcnt.lo %105, %104 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %107 = rocdl.mbcnt.hi %105, %106 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %108 = llvm.mlir.constant(0 : i32) : i32
      %109 = llvm.sub %108, %48 : i32
      %110 = llvm.add %107, %48 : i32
      %111 = llvm.and %110, %109 : i32
      %112 = llvm.xor %107, %13 : i32
      %113 = llvm.icmp "slt" %112, %111 : i32
      %114 = llvm.select %113, %112, %107 : i1, i32
      %115 = llvm.mlir.constant(2 : i32) : i32
      %116 = llvm.shl %114, %115 : i32
      %117 = llvm.bitcast %103 : f32 to i32
      %118 = rocdl.ds_bpermute %116, %117 : (i32, i32) -> i32
      %119 = llvm.bitcast %118 : i32 to f32
      llvm.cond_br %113, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      %120 = llvm.fadd %103, %119 : f32
      llvm.br ^bb13(%120 : f32)
    ^bb12:  // pred: ^bb10
      llvm.br ^bb13(%103 : f32)
    ^bb13(%121: f32):  // 2 preds: ^bb11, ^bb12
      %122 = llvm.mlir.constant(0 : i32) : i32
      %123 = llvm.mlir.constant(-1 : i32) : i32
      %124 = rocdl.mbcnt.lo %123, %122 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %125 = rocdl.mbcnt.hi %123, %124 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %126 = llvm.mlir.constant(0 : i32) : i32
      %127 = llvm.sub %126, %48 : i32
      %128 = llvm.add %125, %48 : i32
      %129 = llvm.and %128, %127 : i32
      %130 = llvm.xor %125, %12 : i32
      %131 = llvm.icmp "slt" %130, %129 : i32
      %132 = llvm.select %131, %130, %125 : i1, i32
      %133 = llvm.mlir.constant(2 : i32) : i32
      %134 = llvm.shl %132, %133 : i32
      %135 = llvm.bitcast %121 : f32 to i32
      %136 = rocdl.ds_bpermute %134, %135 : (i32, i32) -> i32
      %137 = llvm.bitcast %136 : i32 to f32
      llvm.cond_br %131, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %138 = llvm.fadd %121, %137 : f32
      llvm.br ^bb16(%138 : f32)
    ^bb15:  // pred: ^bb13
      llvm.br ^bb16(%121 : f32)
    ^bb16(%139: f32):  // 2 preds: ^bb14, ^bb15
      llvm.br ^bb18(%139 : f32)
    ^bb17:  // pred: ^bb0
      %140 = llvm.mlir.constant(0 : i32) : i32
      %141 = llvm.mlir.constant(-1 : i32) : i32
      %142 = rocdl.mbcnt.lo %141, %140 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %143 = rocdl.mbcnt.hi %141, %142 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %144 = llvm.mlir.constant(0 : i32) : i32
      %145 = llvm.sub %144, %17 : i32
      %146 = llvm.add %143, %17 : i32
      %147 = llvm.and %146, %145 : i32
      %148 = llvm.xor %143, %16 : i32
      %149 = llvm.icmp "slt" %148, %147 : i32
      %150 = llvm.select %149, %148, %143 : i1, i32
      %151 = llvm.mlir.constant(2 : i32) : i32
      %152 = llvm.shl %150, %151 : i32
      %153 = llvm.bitcast %20 : f32 to i32
      %154 = rocdl.ds_bpermute %152, %153 : (i32, i32) -> i32
      %155 = llvm.bitcast %154 : i32 to f32
      %156 = llvm.fadd %155, %20 : f32
      %157 = llvm.mlir.constant(0 : i32) : i32
      %158 = llvm.mlir.constant(-1 : i32) : i32
      %159 = rocdl.mbcnt.lo %158, %157 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %160 = rocdl.mbcnt.hi %158, %159 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %161 = llvm.mlir.constant(0 : i32) : i32
      %162 = llvm.sub %161, %17 : i32
      %163 = llvm.add %160, %17 : i32
      %164 = llvm.and %163, %162 : i32
      %165 = llvm.xor %160, %15 : i32
      %166 = llvm.icmp "slt" %165, %164 : i32
      %167 = llvm.select %166, %165, %160 : i1, i32
      %168 = llvm.mlir.constant(2 : i32) : i32
      %169 = llvm.shl %167, %168 : i32
      %170 = llvm.bitcast %156 : f32 to i32
      %171 = rocdl.ds_bpermute %169, %170 : (i32, i32) -> i32
      %172 = llvm.bitcast %171 : i32 to f32
      %173 = llvm.fadd %156, %172 : f32
      %174 = llvm.mlir.constant(0 : i32) : i32
      %175 = llvm.mlir.constant(-1 : i32) : i32
      %176 = rocdl.mbcnt.lo %175, %174 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %177 = rocdl.mbcnt.hi %175, %176 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %178 = llvm.mlir.constant(0 : i32) : i32
      %179 = llvm.sub %178, %17 : i32
      %180 = llvm.add %177, %17 : i32
      %181 = llvm.and %180, %179 : i32
      %182 = llvm.xor %177, %14 : i32
      %183 = llvm.icmp "slt" %182, %181 : i32
      %184 = llvm.select %183, %182, %177 : i1, i32
      %185 = llvm.mlir.constant(2 : i32) : i32
      %186 = llvm.shl %184, %185 : i32
      %187 = llvm.bitcast %173 : f32 to i32
      %188 = rocdl.ds_bpermute %186, %187 : (i32, i32) -> i32
      %189 = llvm.bitcast %188 : i32 to f32
      %190 = llvm.fadd %173, %189 : f32
      %191 = llvm.mlir.constant(0 : i32) : i32
      %192 = llvm.mlir.constant(-1 : i32) : i32
      %193 = rocdl.mbcnt.lo %192, %191 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %194 = rocdl.mbcnt.hi %192, %193 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %195 = llvm.mlir.constant(0 : i32) : i32
      %196 = llvm.sub %195, %17 : i32
      %197 = llvm.add %194, %17 : i32
      %198 = llvm.and %197, %196 : i32
      %199 = llvm.xor %194, %13 : i32
      %200 = llvm.icmp "slt" %199, %198 : i32
      %201 = llvm.select %200, %199, %194 : i1, i32
      %202 = llvm.mlir.constant(2 : i32) : i32
      %203 = llvm.shl %201, %202 : i32
      %204 = llvm.bitcast %190 : f32 to i32
      %205 = rocdl.ds_bpermute %203, %204 : (i32, i32) -> i32
      %206 = llvm.bitcast %205 : i32 to f32
      %207 = llvm.fadd %190, %206 : f32
      %208 = llvm.mlir.constant(0 : i32) : i32
      %209 = llvm.mlir.constant(-1 : i32) : i32
      %210 = rocdl.mbcnt.lo %209, %208 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %211 = rocdl.mbcnt.hi %209, %210 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %212 = llvm.mlir.constant(0 : i32) : i32
      %213 = llvm.sub %212, %17 : i32
      %214 = llvm.add %211, %17 : i32
      %215 = llvm.and %214, %213 : i32
      %216 = llvm.xor %211, %12 : i32
      %217 = llvm.icmp "slt" %216, %215 : i32
      %218 = llvm.select %217, %216, %211 : i1, i32
      %219 = llvm.mlir.constant(2 : i32) : i32
      %220 = llvm.shl %218, %219 : i32
      %221 = llvm.bitcast %207 : f32 to i32
      %222 = rocdl.ds_bpermute %220, %221 : (i32, i32) -> i32
      %223 = llvm.bitcast %222 : i32 to f32
      %224 = llvm.fadd %207, %223 : f32
      llvm.br ^bb18(%224 : f32)
    ^bb18(%225: f32):  // 2 preds: ^bb16, ^bb17
      llvm.cond_br %46, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      %226 = llvm.sdiv %43, %17 : i32
      %227 = llvm.sext %226 : i32 to i64
      %228 = llvm.extractvalue %10[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %229 = llvm.getelementptr inbounds|nuw %228[%227] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
      llvm.store %225, %229 : f32, !llvm.ptr<3>
      llvm.br ^bb21
    ^bb20:  // pred: ^bb18
      llvm.br ^bb21
    ^bb21:  // 2 preds: ^bb19, ^bb20
      rocdl.barrier
      %230 = llvm.add %44, %19 : i32
      %231 = llvm.sdiv %230, %17 : i32
      %232 = llvm.icmp "slt" %43, %231 : i32
      llvm.cond_br %232, ^bb22, ^bb41
    ^bb22:  // pred: ^bb21
      %233 = llvm.sext %43 : i32 to i64
      %234 = llvm.extractvalue %10[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %235 = llvm.getelementptr inbounds|nuw %234[%233] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
      %236 = llvm.load %235 : !llvm.ptr<3> -> f32
      %237 = llvm.icmp "slt" %231, %17 : i32
      llvm.cond_br %237, ^bb23, ^bb39
    ^bb23:  // pred: ^bb22
      %238 = llvm.mlir.constant(0 : i32) : i32
      %239 = llvm.mlir.constant(-1 : i32) : i32
      %240 = rocdl.mbcnt.lo %239, %238 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %241 = rocdl.mbcnt.hi %239, %240 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %242 = llvm.mlir.constant(0 : i32) : i32
      %243 = llvm.sub %242, %231 : i32
      %244 = llvm.add %241, %231 : i32
      %245 = llvm.and %244, %243 : i32
      %246 = llvm.xor %241, %16 : i32
      %247 = llvm.icmp "slt" %246, %245 : i32
      %248 = llvm.select %247, %246, %241 : i1, i32
      %249 = llvm.mlir.constant(2 : i32) : i32
      %250 = llvm.shl %248, %249 : i32
      %251 = llvm.bitcast %236 : f32 to i32
      %252 = rocdl.ds_bpermute %250, %251 : (i32, i32) -> i32
      %253 = llvm.bitcast %252 : i32 to f32
      llvm.cond_br %247, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      %254 = llvm.fadd %236, %253 : f32
      llvm.br ^bb26(%254 : f32)
    ^bb25:  // pred: ^bb23
      llvm.br ^bb26(%236 : f32)
    ^bb26(%255: f32):  // 2 preds: ^bb24, ^bb25
      %256 = llvm.mlir.constant(0 : i32) : i32
      %257 = llvm.mlir.constant(-1 : i32) : i32
      %258 = rocdl.mbcnt.lo %257, %256 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %259 = rocdl.mbcnt.hi %257, %258 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %260 = llvm.mlir.constant(0 : i32) : i32
      %261 = llvm.sub %260, %231 : i32
      %262 = llvm.add %259, %231 : i32
      %263 = llvm.and %262, %261 : i32
      %264 = llvm.xor %259, %15 : i32
      %265 = llvm.icmp "slt" %264, %263 : i32
      %266 = llvm.select %265, %264, %259 : i1, i32
      %267 = llvm.mlir.constant(2 : i32) : i32
      %268 = llvm.shl %266, %267 : i32
      %269 = llvm.bitcast %255 : f32 to i32
      %270 = rocdl.ds_bpermute %268, %269 : (i32, i32) -> i32
      %271 = llvm.bitcast %270 : i32 to f32
      llvm.cond_br %265, ^bb27, ^bb28
    ^bb27:  // pred: ^bb26
      %272 = llvm.fadd %255, %271 : f32
      llvm.br ^bb29(%272 : f32)
    ^bb28:  // pred: ^bb26
      llvm.br ^bb29(%255 : f32)
    ^bb29(%273: f32):  // 2 preds: ^bb27, ^bb28
      %274 = llvm.mlir.constant(0 : i32) : i32
      %275 = llvm.mlir.constant(-1 : i32) : i32
      %276 = rocdl.mbcnt.lo %275, %274 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %277 = rocdl.mbcnt.hi %275, %276 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %278 = llvm.mlir.constant(0 : i32) : i32
      %279 = llvm.sub %278, %231 : i32
      %280 = llvm.add %277, %231 : i32
      %281 = llvm.and %280, %279 : i32
      %282 = llvm.xor %277, %14 : i32
      %283 = llvm.icmp "slt" %282, %281 : i32
      %284 = llvm.select %283, %282, %277 : i1, i32
      %285 = llvm.mlir.constant(2 : i32) : i32
      %286 = llvm.shl %284, %285 : i32
      %287 = llvm.bitcast %273 : f32 to i32
      %288 = rocdl.ds_bpermute %286, %287 : (i32, i32) -> i32
      %289 = llvm.bitcast %288 : i32 to f32
      llvm.cond_br %283, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      %290 = llvm.fadd %273, %289 : f32
      llvm.br ^bb32(%290 : f32)
    ^bb31:  // pred: ^bb29
      llvm.br ^bb32(%273 : f32)
    ^bb32(%291: f32):  // 2 preds: ^bb30, ^bb31
      %292 = llvm.mlir.constant(0 : i32) : i32
      %293 = llvm.mlir.constant(-1 : i32) : i32
      %294 = rocdl.mbcnt.lo %293, %292 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %295 = rocdl.mbcnt.hi %293, %294 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %296 = llvm.mlir.constant(0 : i32) : i32
      %297 = llvm.sub %296, %231 : i32
      %298 = llvm.add %295, %231 : i32
      %299 = llvm.and %298, %297 : i32
      %300 = llvm.xor %295, %13 : i32
      %301 = llvm.icmp "slt" %300, %299 : i32
      %302 = llvm.select %301, %300, %295 : i1, i32
      %303 = llvm.mlir.constant(2 : i32) : i32
      %304 = llvm.shl %302, %303 : i32
      %305 = llvm.bitcast %291 : f32 to i32
      %306 = rocdl.ds_bpermute %304, %305 : (i32, i32) -> i32
      %307 = llvm.bitcast %306 : i32 to f32
      llvm.cond_br %301, ^bb33, ^bb34
    ^bb33:  // pred: ^bb32
      %308 = llvm.fadd %291, %307 : f32
      llvm.br ^bb35(%308 : f32)
    ^bb34:  // pred: ^bb32
      llvm.br ^bb35(%291 : f32)
    ^bb35(%309: f32):  // 2 preds: ^bb33, ^bb34
      %310 = llvm.mlir.constant(0 : i32) : i32
      %311 = llvm.mlir.constant(-1 : i32) : i32
      %312 = rocdl.mbcnt.lo %311, %310 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %313 = rocdl.mbcnt.hi %311, %312 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %314 = llvm.mlir.constant(0 : i32) : i32
      %315 = llvm.sub %314, %231 : i32
      %316 = llvm.add %313, %231 : i32
      %317 = llvm.and %316, %315 : i32
      %318 = llvm.xor %313, %12 : i32
      %319 = llvm.icmp "slt" %318, %317 : i32
      %320 = llvm.select %319, %318, %313 : i1, i32
      %321 = llvm.mlir.constant(2 : i32) : i32
      %322 = llvm.shl %320, %321 : i32
      %323 = llvm.bitcast %309 : f32 to i32
      %324 = rocdl.ds_bpermute %322, %323 : (i32, i32) -> i32
      %325 = llvm.bitcast %324 : i32 to f32
      llvm.cond_br %319, ^bb36, ^bb37
    ^bb36:  // pred: ^bb35
      %326 = llvm.fadd %309, %325 : f32
      llvm.br ^bb38(%326 : f32)
    ^bb37:  // pred: ^bb35
      llvm.br ^bb38(%309 : f32)
    ^bb38(%327: f32):  // 2 preds: ^bb36, ^bb37
      llvm.br ^bb40(%327 : f32)
    ^bb39:  // pred: ^bb22
      %328 = llvm.mlir.constant(0 : i32) : i32
      %329 = llvm.mlir.constant(-1 : i32) : i32
      %330 = rocdl.mbcnt.lo %329, %328 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %331 = rocdl.mbcnt.hi %329, %330 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %332 = llvm.mlir.constant(0 : i32) : i32
      %333 = llvm.sub %332, %17 : i32
      %334 = llvm.add %331, %17 : i32
      %335 = llvm.and %334, %333 : i32
      %336 = llvm.xor %331, %16 : i32
      %337 = llvm.icmp "slt" %336, %335 : i32
      %338 = llvm.select %337, %336, %331 : i1, i32
      %339 = llvm.mlir.constant(2 : i32) : i32
      %340 = llvm.shl %338, %339 : i32
      %341 = llvm.bitcast %236 : f32 to i32
      %342 = rocdl.ds_bpermute %340, %341 : (i32, i32) -> i32
      %343 = llvm.bitcast %342 : i32 to f32
      %344 = llvm.fadd %236, %343 : f32
      %345 = llvm.mlir.constant(0 : i32) : i32
      %346 = llvm.mlir.constant(-1 : i32) : i32
      %347 = rocdl.mbcnt.lo %346, %345 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %348 = rocdl.mbcnt.hi %346, %347 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %349 = llvm.mlir.constant(0 : i32) : i32
      %350 = llvm.sub %349, %17 : i32
      %351 = llvm.add %348, %17 : i32
      %352 = llvm.and %351, %350 : i32
      %353 = llvm.xor %348, %15 : i32
      %354 = llvm.icmp "slt" %353, %352 : i32
      %355 = llvm.select %354, %353, %348 : i1, i32
      %356 = llvm.mlir.constant(2 : i32) : i32
      %357 = llvm.shl %355, %356 : i32
      %358 = llvm.bitcast %344 : f32 to i32
      %359 = rocdl.ds_bpermute %357, %358 : (i32, i32) -> i32
      %360 = llvm.bitcast %359 : i32 to f32
      %361 = llvm.fadd %344, %360 : f32
      %362 = llvm.mlir.constant(0 : i32) : i32
      %363 = llvm.mlir.constant(-1 : i32) : i32
      %364 = rocdl.mbcnt.lo %363, %362 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %365 = rocdl.mbcnt.hi %363, %364 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %366 = llvm.mlir.constant(0 : i32) : i32
      %367 = llvm.sub %366, %17 : i32
      %368 = llvm.add %365, %17 : i32
      %369 = llvm.and %368, %367 : i32
      %370 = llvm.xor %365, %14 : i32
      %371 = llvm.icmp "slt" %370, %369 : i32
      %372 = llvm.select %371, %370, %365 : i1, i32
      %373 = llvm.mlir.constant(2 : i32) : i32
      %374 = llvm.shl %372, %373 : i32
      %375 = llvm.bitcast %361 : f32 to i32
      %376 = rocdl.ds_bpermute %374, %375 : (i32, i32) -> i32
      %377 = llvm.bitcast %376 : i32 to f32
      %378 = llvm.fadd %361, %377 : f32
      %379 = llvm.mlir.constant(0 : i32) : i32
      %380 = llvm.mlir.constant(-1 : i32) : i32
      %381 = rocdl.mbcnt.lo %380, %379 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %382 = rocdl.mbcnt.hi %380, %381 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %383 = llvm.mlir.constant(0 : i32) : i32
      %384 = llvm.sub %383, %17 : i32
      %385 = llvm.add %382, %17 : i32
      %386 = llvm.and %385, %384 : i32
      %387 = llvm.xor %382, %13 : i32
      %388 = llvm.icmp "slt" %387, %386 : i32
      %389 = llvm.select %388, %387, %382 : i1, i32
      %390 = llvm.mlir.constant(2 : i32) : i32
      %391 = llvm.shl %389, %390 : i32
      %392 = llvm.bitcast %378 : f32 to i32
      %393 = rocdl.ds_bpermute %391, %392 : (i32, i32) -> i32
      %394 = llvm.bitcast %393 : i32 to f32
      %395 = llvm.fadd %378, %394 : f32
      %396 = llvm.mlir.constant(0 : i32) : i32
      %397 = llvm.mlir.constant(-1 : i32) : i32
      %398 = rocdl.mbcnt.lo %397, %396 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %399 = rocdl.mbcnt.hi %397, %398 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %400 = llvm.mlir.constant(0 : i32) : i32
      %401 = llvm.sub %400, %17 : i32
      %402 = llvm.add %399, %17 : i32
      %403 = llvm.and %402, %401 : i32
      %404 = llvm.xor %399, %12 : i32
      %405 = llvm.icmp "slt" %404, %403 : i32
      %406 = llvm.select %405, %404, %399 : i1, i32
      %407 = llvm.mlir.constant(2 : i32) : i32
      %408 = llvm.shl %406, %407 : i32
      %409 = llvm.bitcast %395 : f32 to i32
      %410 = rocdl.ds_bpermute %408, %409 : (i32, i32) -> i32
      %411 = llvm.bitcast %410 : i32 to f32
      %412 = llvm.fadd %395, %411 : f32
      llvm.br ^bb40(%412 : f32)
    ^bb40(%413: f32):  // 2 preds: ^bb38, ^bb39
      %414 = llvm.extractvalue %10[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %415 = llvm.getelementptr inbounds|nuw %414[%11] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
      llvm.store %413, %415 : f32, !llvm.ptr<3>
      llvm.br ^bb42
    ^bb41:  // pred: ^bb21
      llvm.br ^bb42
    ^bb42:  // 2 preds: ^bb40, ^bb41
      rocdl.barrier
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.mlir.global internal @__wg_gpu_all_reduce_region_0() {addr_space = 3 : i32} : !llvm.array<32 x i32>
    llvm.func @gpu_all_reduce_region() {
      %0 = llvm.mlir.addressof @__wg_gpu_all_reduce_region_0 : !llvm.ptr<3>
      %1 = llvm.getelementptr %0[0, 0] : (!llvm.ptr<3>) -> !llvm.ptr<3>, !llvm.array<32 x i32>
      %2 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %5 = llvm.mlir.constant(0 : index) : i64
      %6 = llvm.insertvalue %5, %4[2] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %7 = llvm.mlir.constant(32 : index) : i64
      %8 = llvm.insertvalue %7, %6[3, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %9 = llvm.mlir.constant(1 : index) : i64
      %10 = llvm.insertvalue %9, %8[4, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %11 = llvm.mlir.constant(0 : index) : i64
      %12 = llvm.mlir.constant(16 : i32) : i32
      %13 = llvm.mlir.constant(8 : i32) : i32
      %14 = llvm.mlir.constant(4 : i32) : i32
      %15 = llvm.mlir.constant(2 : i32) : i32
      %16 = llvm.mlir.constant(32 : i32) : i32
      %17 = llvm.mlir.constant(0 : i32) : i32
      %18 = llvm.mlir.constant(31 : i32) : i32
      %19 = llvm.mlir.constant(1 : i32) : i32
      %20 = rocdl.workgroup.dim.x : i32
      %21 = llvm.sext %20 : i32 to i64
      %22 = llvm.trunc %21 : i64 to i32
      %23 = rocdl.workgroup.dim.y : i32
      %24 = llvm.sext %23 : i32 to i64
      %25 = llvm.trunc %24 : i64 to i32
      %26 = rocdl.workgroup.dim.z : i32
      %27 = llvm.sext %26 : i32 to i64
      %28 = llvm.trunc %27 : i64 to i32
      %29 = rocdl.workitem.id.x : i32
      %30 = llvm.sext %29 : i32 to i64
      %31 = llvm.trunc %30 : i64 to i32
      %32 = rocdl.workitem.id.y : i32
      %33 = llvm.sext %32 : i32 to i64
      %34 = llvm.trunc %33 : i64 to i32
      %35 = rocdl.workitem.id.z : i32
      %36 = llvm.sext %35 : i32 to i64
      %37 = llvm.trunc %36 : i64 to i32
      %38 = llvm.mul %37, %25 : i32
      %39 = llvm.add %38, %34 : i32
      %40 = llvm.mul %39, %22 : i32
      %41 = llvm.mul %22, %25 : i32
      %42 = llvm.add %40, %31 : i32
      %43 = llvm.mul %41, %28 : i32
      %44 = llvm.and %42, %18 : i32
      %45 = llvm.icmp "eq" %44, %17 : i32
      %46 = llvm.sub %42, %44 : i32
      %47 = llvm.sub %43, %46 : i32
      %48 = llvm.icmp "slt" %47, %16 : i32
      llvm.cond_br %48, ^bb1, ^bb22
    ^bb1:  // pred: ^bb0
      %49 = llvm.mlir.constant(0 : i32) : i32
      %50 = llvm.mlir.constant(-1 : i32) : i32
      %51 = rocdl.mbcnt.lo %50, %49 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %52 = rocdl.mbcnt.hi %50, %51 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %53 = llvm.mlir.constant(0 : i32) : i32
      %54 = llvm.sub %53, %47 : i32
      %55 = llvm.add %52, %47 : i32
      %56 = llvm.and %55, %54 : i32
      %57 = llvm.xor %52, %19 : i32
      %58 = llvm.icmp "slt" %57, %56 : i32
      %59 = llvm.select %58, %57, %52 : i1, i32
      %60 = llvm.mlir.constant(2 : i32) : i32
      %61 = llvm.shl %59, %60 : i32
      %62 = rocdl.ds_bpermute %61, %19 : (i32, i32) -> i32
      llvm.cond_br %58, ^bb2, ^bb4(%19 : i32)
    ^bb2:  // pred: ^bb1
      llvm.br ^bb3
    ^bb3:  // pred: ^bb2
      %63 = llvm.xor %62, %19 : i32
      llvm.br ^bb4(%63 : i32)
    ^bb4(%64: i32):  // 2 preds: ^bb1, ^bb3
      llvm.br ^bb5
    ^bb5:  // pred: ^bb4
      %65 = llvm.mlir.constant(0 : i32) : i32
      %66 = llvm.mlir.constant(-1 : i32) : i32
      %67 = rocdl.mbcnt.lo %66, %65 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %68 = rocdl.mbcnt.hi %66, %67 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %69 = llvm.mlir.constant(0 : i32) : i32
      %70 = llvm.sub %69, %47 : i32
      %71 = llvm.add %68, %47 : i32
      %72 = llvm.and %71, %70 : i32
      %73 = llvm.xor %68, %15 : i32
      %74 = llvm.icmp "slt" %73, %72 : i32
      %75 = llvm.select %74, %73, %68 : i1, i32
      %76 = llvm.mlir.constant(2 : i32) : i32
      %77 = llvm.shl %75, %76 : i32
      %78 = rocdl.ds_bpermute %77, %64 : (i32, i32) -> i32
      llvm.cond_br %74, ^bb6, ^bb8(%64 : i32)
    ^bb6:  // pred: ^bb5
      llvm.br ^bb7
    ^bb7:  // pred: ^bb6
      %79 = llvm.xor %64, %78 : i32
      llvm.br ^bb8(%79 : i32)
    ^bb8(%80: i32):  // 2 preds: ^bb5, ^bb7
      llvm.br ^bb9
    ^bb9:  // pred: ^bb8
      %81 = llvm.mlir.constant(0 : i32) : i32
      %82 = llvm.mlir.constant(-1 : i32) : i32
      %83 = rocdl.mbcnt.lo %82, %81 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %84 = rocdl.mbcnt.hi %82, %83 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %85 = llvm.mlir.constant(0 : i32) : i32
      %86 = llvm.sub %85, %47 : i32
      %87 = llvm.add %84, %47 : i32
      %88 = llvm.and %87, %86 : i32
      %89 = llvm.xor %84, %14 : i32
      %90 = llvm.icmp "slt" %89, %88 : i32
      %91 = llvm.select %90, %89, %84 : i1, i32
      %92 = llvm.mlir.constant(2 : i32) : i32
      %93 = llvm.shl %91, %92 : i32
      %94 = rocdl.ds_bpermute %93, %80 : (i32, i32) -> i32
      llvm.cond_br %90, ^bb10, ^bb12(%80 : i32)
    ^bb10:  // pred: ^bb9
      llvm.br ^bb11
    ^bb11:  // pred: ^bb10
      %95 = llvm.xor %80, %94 : i32
      llvm.br ^bb12(%95 : i32)
    ^bb12(%96: i32):  // 2 preds: ^bb9, ^bb11
      llvm.br ^bb13
    ^bb13:  // pred: ^bb12
      %97 = llvm.mlir.constant(0 : i32) : i32
      %98 = llvm.mlir.constant(-1 : i32) : i32
      %99 = rocdl.mbcnt.lo %98, %97 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %100 = rocdl.mbcnt.hi %98, %99 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %101 = llvm.mlir.constant(0 : i32) : i32
      %102 = llvm.sub %101, %47 : i32
      %103 = llvm.add %100, %47 : i32
      %104 = llvm.and %103, %102 : i32
      %105 = llvm.xor %100, %13 : i32
      %106 = llvm.icmp "slt" %105, %104 : i32
      %107 = llvm.select %106, %105, %100 : i1, i32
      %108 = llvm.mlir.constant(2 : i32) : i32
      %109 = llvm.shl %107, %108 : i32
      %110 = rocdl.ds_bpermute %109, %96 : (i32, i32) -> i32
      llvm.cond_br %106, ^bb14, ^bb16(%96 : i32)
    ^bb14:  // pred: ^bb13
      llvm.br ^bb15
    ^bb15:  // pred: ^bb14
      %111 = llvm.xor %96, %110 : i32
      llvm.br ^bb16(%111 : i32)
    ^bb16(%112: i32):  // 2 preds: ^bb13, ^bb15
      llvm.br ^bb17
    ^bb17:  // pred: ^bb16
      %113 = llvm.mlir.constant(0 : i32) : i32
      %114 = llvm.mlir.constant(-1 : i32) : i32
      %115 = rocdl.mbcnt.lo %114, %113 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %116 = rocdl.mbcnt.hi %114, %115 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %117 = llvm.mlir.constant(0 : i32) : i32
      %118 = llvm.sub %117, %47 : i32
      %119 = llvm.add %116, %47 : i32
      %120 = llvm.and %119, %118 : i32
      %121 = llvm.xor %116, %12 : i32
      %122 = llvm.icmp "slt" %121, %120 : i32
      %123 = llvm.select %122, %121, %116 : i1, i32
      %124 = llvm.mlir.constant(2 : i32) : i32
      %125 = llvm.shl %123, %124 : i32
      %126 = rocdl.ds_bpermute %125, %112 : (i32, i32) -> i32
      llvm.cond_br %122, ^bb18, ^bb20(%112 : i32)
    ^bb18:  // pred: ^bb17
      llvm.br ^bb19
    ^bb19:  // pred: ^bb18
      %127 = llvm.xor %112, %126 : i32
      llvm.br ^bb20(%127 : i32)
    ^bb20(%128: i32):  // 2 preds: ^bb17, ^bb19
      llvm.br ^bb21(%128 : i32)
    ^bb21(%129: i32):  // 2 preds: ^bb20, ^bb31
      llvm.br ^bb32
    ^bb22:  // pred: ^bb0
      %130 = llvm.mlir.constant(0 : i32) : i32
      %131 = llvm.mlir.constant(-1 : i32) : i32
      %132 = rocdl.mbcnt.lo %131, %130 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %133 = rocdl.mbcnt.hi %131, %132 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %134 = llvm.mlir.constant(0 : i32) : i32
      %135 = llvm.sub %134, %16 : i32
      %136 = llvm.add %133, %16 : i32
      %137 = llvm.and %136, %135 : i32
      %138 = llvm.xor %133, %19 : i32
      %139 = llvm.icmp "slt" %138, %137 : i32
      %140 = llvm.select %139, %138, %133 : i1, i32
      %141 = llvm.mlir.constant(2 : i32) : i32
      %142 = llvm.shl %140, %141 : i32
      %143 = rocdl.ds_bpermute %142, %19 : (i32, i32) -> i32
      llvm.br ^bb23
    ^bb23:  // pred: ^bb22
      %144 = llvm.xor %143, %19 : i32
      llvm.br ^bb24
    ^bb24:  // pred: ^bb23
      %145 = llvm.mlir.constant(0 : i32) : i32
      %146 = llvm.mlir.constant(-1 : i32) : i32
      %147 = rocdl.mbcnt.lo %146, %145 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %148 = rocdl.mbcnt.hi %146, %147 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %149 = llvm.mlir.constant(0 : i32) : i32
      %150 = llvm.sub %149, %16 : i32
      %151 = llvm.add %148, %16 : i32
      %152 = llvm.and %151, %150 : i32
      %153 = llvm.xor %148, %15 : i32
      %154 = llvm.icmp "slt" %153, %152 : i32
      %155 = llvm.select %154, %153, %148 : i1, i32
      %156 = llvm.mlir.constant(2 : i32) : i32
      %157 = llvm.shl %155, %156 : i32
      %158 = rocdl.ds_bpermute %157, %144 : (i32, i32) -> i32
      llvm.br ^bb25
    ^bb25:  // pred: ^bb24
      %159 = llvm.xor %144, %158 : i32
      llvm.br ^bb26
    ^bb26:  // pred: ^bb25
      %160 = llvm.mlir.constant(0 : i32) : i32
      %161 = llvm.mlir.constant(-1 : i32) : i32
      %162 = rocdl.mbcnt.lo %161, %160 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %163 = rocdl.mbcnt.hi %161, %162 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %164 = llvm.mlir.constant(0 : i32) : i32
      %165 = llvm.sub %164, %16 : i32
      %166 = llvm.add %163, %16 : i32
      %167 = llvm.and %166, %165 : i32
      %168 = llvm.xor %163, %14 : i32
      %169 = llvm.icmp "slt" %168, %167 : i32
      %170 = llvm.select %169, %168, %163 : i1, i32
      %171 = llvm.mlir.constant(2 : i32) : i32
      %172 = llvm.shl %170, %171 : i32
      %173 = rocdl.ds_bpermute %172, %159 : (i32, i32) -> i32
      llvm.br ^bb27
    ^bb27:  // pred: ^bb26
      %174 = llvm.xor %159, %173 : i32
      llvm.br ^bb28
    ^bb28:  // pred: ^bb27
      %175 = llvm.mlir.constant(0 : i32) : i32
      %176 = llvm.mlir.constant(-1 : i32) : i32
      %177 = rocdl.mbcnt.lo %176, %175 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %178 = rocdl.mbcnt.hi %176, %177 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %179 = llvm.mlir.constant(0 : i32) : i32
      %180 = llvm.sub %179, %16 : i32
      %181 = llvm.add %178, %16 : i32
      %182 = llvm.and %181, %180 : i32
      %183 = llvm.xor %178, %13 : i32
      %184 = llvm.icmp "slt" %183, %182 : i32
      %185 = llvm.select %184, %183, %178 : i1, i32
      %186 = llvm.mlir.constant(2 : i32) : i32
      %187 = llvm.shl %185, %186 : i32
      %188 = rocdl.ds_bpermute %187, %174 : (i32, i32) -> i32
      llvm.br ^bb29
    ^bb29:  // pred: ^bb28
      %189 = llvm.xor %174, %188 : i32
      llvm.br ^bb30
    ^bb30:  // pred: ^bb29
      %190 = llvm.mlir.constant(0 : i32) : i32
      %191 = llvm.mlir.constant(-1 : i32) : i32
      %192 = rocdl.mbcnt.lo %191, %190 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %193 = rocdl.mbcnt.hi %191, %192 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %194 = llvm.mlir.constant(0 : i32) : i32
      %195 = llvm.sub %194, %16 : i32
      %196 = llvm.add %193, %16 : i32
      %197 = llvm.and %196, %195 : i32
      %198 = llvm.xor %193, %12 : i32
      %199 = llvm.icmp "slt" %198, %197 : i32
      %200 = llvm.select %199, %198, %193 : i1, i32
      %201 = llvm.mlir.constant(2 : i32) : i32
      %202 = llvm.shl %200, %201 : i32
      %203 = rocdl.ds_bpermute %202, %189 : (i32, i32) -> i32
      llvm.br ^bb31
    ^bb31:  // pred: ^bb30
      %204 = llvm.xor %189, %203 : i32
      llvm.br ^bb21(%204 : i32)
    ^bb32:  // pred: ^bb21
      llvm.cond_br %45, ^bb33, ^bb34
    ^bb33:  // pred: ^bb32
      %205 = llvm.sdiv %42, %16 : i32
      %206 = llvm.sext %205 : i32 to i64
      %207 = llvm.extractvalue %10[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %208 = llvm.getelementptr inbounds|nuw %207[%206] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, i32
      llvm.store %129, %208 : i32, !llvm.ptr<3>
      llvm.br ^bb35
    ^bb34:  // pred: ^bb32
      llvm.br ^bb35
    ^bb35:  // 2 preds: ^bb33, ^bb34
      rocdl.barrier
      %209 = llvm.add %43, %18 : i32
      %210 = llvm.sdiv %209, %16 : i32
      %211 = llvm.icmp "slt" %42, %210 : i32
      llvm.cond_br %211, ^bb36, ^bb69
    ^bb36:  // pred: ^bb35
      %212 = llvm.sext %42 : i32 to i64
      %213 = llvm.extractvalue %10[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %214 = llvm.getelementptr inbounds|nuw %213[%212] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, i32
      %215 = llvm.load %214 : !llvm.ptr<3> -> i32
      %216 = llvm.icmp "slt" %210, %16 : i32
      llvm.cond_br %216, ^bb37, ^bb58
    ^bb37:  // pred: ^bb36
      %217 = llvm.mlir.constant(0 : i32) : i32
      %218 = llvm.mlir.constant(-1 : i32) : i32
      %219 = rocdl.mbcnt.lo %218, %217 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %220 = rocdl.mbcnt.hi %218, %219 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %221 = llvm.mlir.constant(0 : i32) : i32
      %222 = llvm.sub %221, %210 : i32
      %223 = llvm.add %220, %210 : i32
      %224 = llvm.and %223, %222 : i32
      %225 = llvm.xor %220, %19 : i32
      %226 = llvm.icmp "slt" %225, %224 : i32
      %227 = llvm.select %226, %225, %220 : i1, i32
      %228 = llvm.mlir.constant(2 : i32) : i32
      %229 = llvm.shl %227, %228 : i32
      %230 = rocdl.ds_bpermute %229, %215 : (i32, i32) -> i32
      llvm.cond_br %226, ^bb38, ^bb40(%215 : i32)
    ^bb38:  // pred: ^bb37
      llvm.br ^bb39
    ^bb39:  // pred: ^bb38
      %231 = llvm.xor %215, %230 : i32
      llvm.br ^bb40(%231 : i32)
    ^bb40(%232: i32):  // 2 preds: ^bb37, ^bb39
      llvm.br ^bb41
    ^bb41:  // pred: ^bb40
      %233 = llvm.mlir.constant(0 : i32) : i32
      %234 = llvm.mlir.constant(-1 : i32) : i32
      %235 = rocdl.mbcnt.lo %234, %233 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %236 = rocdl.mbcnt.hi %234, %235 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %237 = llvm.mlir.constant(0 : i32) : i32
      %238 = llvm.sub %237, %210 : i32
      %239 = llvm.add %236, %210 : i32
      %240 = llvm.and %239, %238 : i32
      %241 = llvm.xor %236, %15 : i32
      %242 = llvm.icmp "slt" %241, %240 : i32
      %243 = llvm.select %242, %241, %236 : i1, i32
      %244 = llvm.mlir.constant(2 : i32) : i32
      %245 = llvm.shl %243, %244 : i32
      %246 = rocdl.ds_bpermute %245, %232 : (i32, i32) -> i32
      llvm.cond_br %242, ^bb42, ^bb44(%232 : i32)
    ^bb42:  // pred: ^bb41
      llvm.br ^bb43
    ^bb43:  // pred: ^bb42
      %247 = llvm.xor %232, %246 : i32
      llvm.br ^bb44(%247 : i32)
    ^bb44(%248: i32):  // 2 preds: ^bb41, ^bb43
      llvm.br ^bb45
    ^bb45:  // pred: ^bb44
      %249 = llvm.mlir.constant(0 : i32) : i32
      %250 = llvm.mlir.constant(-1 : i32) : i32
      %251 = rocdl.mbcnt.lo %250, %249 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %252 = rocdl.mbcnt.hi %250, %251 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %253 = llvm.mlir.constant(0 : i32) : i32
      %254 = llvm.sub %253, %210 : i32
      %255 = llvm.add %252, %210 : i32
      %256 = llvm.and %255, %254 : i32
      %257 = llvm.xor %252, %14 : i32
      %258 = llvm.icmp "slt" %257, %256 : i32
      %259 = llvm.select %258, %257, %252 : i1, i32
      %260 = llvm.mlir.constant(2 : i32) : i32
      %261 = llvm.shl %259, %260 : i32
      %262 = rocdl.ds_bpermute %261, %248 : (i32, i32) -> i32
      llvm.cond_br %258, ^bb46, ^bb48(%248 : i32)
    ^bb46:  // pred: ^bb45
      llvm.br ^bb47
    ^bb47:  // pred: ^bb46
      %263 = llvm.xor %248, %262 : i32
      llvm.br ^bb48(%263 : i32)
    ^bb48(%264: i32):  // 2 preds: ^bb45, ^bb47
      llvm.br ^bb49
    ^bb49:  // pred: ^bb48
      %265 = llvm.mlir.constant(0 : i32) : i32
      %266 = llvm.mlir.constant(-1 : i32) : i32
      %267 = rocdl.mbcnt.lo %266, %265 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %268 = rocdl.mbcnt.hi %266, %267 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %269 = llvm.mlir.constant(0 : i32) : i32
      %270 = llvm.sub %269, %210 : i32
      %271 = llvm.add %268, %210 : i32
      %272 = llvm.and %271, %270 : i32
      %273 = llvm.xor %268, %13 : i32
      %274 = llvm.icmp "slt" %273, %272 : i32
      %275 = llvm.select %274, %273, %268 : i1, i32
      %276 = llvm.mlir.constant(2 : i32) : i32
      %277 = llvm.shl %275, %276 : i32
      %278 = rocdl.ds_bpermute %277, %264 : (i32, i32) -> i32
      llvm.cond_br %274, ^bb50, ^bb52(%264 : i32)
    ^bb50:  // pred: ^bb49
      llvm.br ^bb51
    ^bb51:  // pred: ^bb50
      %279 = llvm.xor %264, %278 : i32
      llvm.br ^bb52(%279 : i32)
    ^bb52(%280: i32):  // 2 preds: ^bb49, ^bb51
      llvm.br ^bb53
    ^bb53:  // pred: ^bb52
      %281 = llvm.mlir.constant(0 : i32) : i32
      %282 = llvm.mlir.constant(-1 : i32) : i32
      %283 = rocdl.mbcnt.lo %282, %281 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %284 = rocdl.mbcnt.hi %282, %283 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %285 = llvm.mlir.constant(0 : i32) : i32
      %286 = llvm.sub %285, %210 : i32
      %287 = llvm.add %284, %210 : i32
      %288 = llvm.and %287, %286 : i32
      %289 = llvm.xor %284, %12 : i32
      %290 = llvm.icmp "slt" %289, %288 : i32
      %291 = llvm.select %290, %289, %284 : i1, i32
      %292 = llvm.mlir.constant(2 : i32) : i32
      %293 = llvm.shl %291, %292 : i32
      %294 = rocdl.ds_bpermute %293, %280 : (i32, i32) -> i32
      llvm.cond_br %290, ^bb54, ^bb56(%280 : i32)
    ^bb54:  // pred: ^bb53
      llvm.br ^bb55
    ^bb55:  // pred: ^bb54
      %295 = llvm.xor %280, %294 : i32
      llvm.br ^bb56(%295 : i32)
    ^bb56(%296: i32):  // 2 preds: ^bb53, ^bb55
      llvm.br ^bb57(%296 : i32)
    ^bb57(%297: i32):  // 2 preds: ^bb56, ^bb67
      llvm.br ^bb68
    ^bb58:  // pred: ^bb36
      %298 = llvm.mlir.constant(0 : i32) : i32
      %299 = llvm.mlir.constant(-1 : i32) : i32
      %300 = rocdl.mbcnt.lo %299, %298 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %301 = rocdl.mbcnt.hi %299, %300 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %302 = llvm.mlir.constant(0 : i32) : i32
      %303 = llvm.sub %302, %16 : i32
      %304 = llvm.add %301, %16 : i32
      %305 = llvm.and %304, %303 : i32
      %306 = llvm.xor %301, %19 : i32
      %307 = llvm.icmp "slt" %306, %305 : i32
      %308 = llvm.select %307, %306, %301 : i1, i32
      %309 = llvm.mlir.constant(2 : i32) : i32
      %310 = llvm.shl %308, %309 : i32
      %311 = rocdl.ds_bpermute %310, %215 : (i32, i32) -> i32
      llvm.br ^bb59
    ^bb59:  // pred: ^bb58
      %312 = llvm.xor %215, %311 : i32
      llvm.br ^bb60
    ^bb60:  // pred: ^bb59
      %313 = llvm.mlir.constant(0 : i32) : i32
      %314 = llvm.mlir.constant(-1 : i32) : i32
      %315 = rocdl.mbcnt.lo %314, %313 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %316 = rocdl.mbcnt.hi %314, %315 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %317 = llvm.mlir.constant(0 : i32) : i32
      %318 = llvm.sub %317, %16 : i32
      %319 = llvm.add %316, %16 : i32
      %320 = llvm.and %319, %318 : i32
      %321 = llvm.xor %316, %15 : i32
      %322 = llvm.icmp "slt" %321, %320 : i32
      %323 = llvm.select %322, %321, %316 : i1, i32
      %324 = llvm.mlir.constant(2 : i32) : i32
      %325 = llvm.shl %323, %324 : i32
      %326 = rocdl.ds_bpermute %325, %312 : (i32, i32) -> i32
      llvm.br ^bb61
    ^bb61:  // pred: ^bb60
      %327 = llvm.xor %312, %326 : i32
      llvm.br ^bb62
    ^bb62:  // pred: ^bb61
      %328 = llvm.mlir.constant(0 : i32) : i32
      %329 = llvm.mlir.constant(-1 : i32) : i32
      %330 = rocdl.mbcnt.lo %329, %328 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %331 = rocdl.mbcnt.hi %329, %330 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %332 = llvm.mlir.constant(0 : i32) : i32
      %333 = llvm.sub %332, %16 : i32
      %334 = llvm.add %331, %16 : i32
      %335 = llvm.and %334, %333 : i32
      %336 = llvm.xor %331, %14 : i32
      %337 = llvm.icmp "slt" %336, %335 : i32
      %338 = llvm.select %337, %336, %331 : i1, i32
      %339 = llvm.mlir.constant(2 : i32) : i32
      %340 = llvm.shl %338, %339 : i32
      %341 = rocdl.ds_bpermute %340, %327 : (i32, i32) -> i32
      llvm.br ^bb63
    ^bb63:  // pred: ^bb62
      %342 = llvm.xor %327, %341 : i32
      llvm.br ^bb64
    ^bb64:  // pred: ^bb63
      %343 = llvm.mlir.constant(0 : i32) : i32
      %344 = llvm.mlir.constant(-1 : i32) : i32
      %345 = rocdl.mbcnt.lo %344, %343 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %346 = rocdl.mbcnt.hi %344, %345 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %347 = llvm.mlir.constant(0 : i32) : i32
      %348 = llvm.sub %347, %16 : i32
      %349 = llvm.add %346, %16 : i32
      %350 = llvm.and %349, %348 : i32
      %351 = llvm.xor %346, %13 : i32
      %352 = llvm.icmp "slt" %351, %350 : i32
      %353 = llvm.select %352, %351, %346 : i1, i32
      %354 = llvm.mlir.constant(2 : i32) : i32
      %355 = llvm.shl %353, %354 : i32
      %356 = rocdl.ds_bpermute %355, %342 : (i32, i32) -> i32
      llvm.br ^bb65
    ^bb65:  // pred: ^bb64
      %357 = llvm.xor %342, %356 : i32
      llvm.br ^bb66
    ^bb66:  // pred: ^bb65
      %358 = llvm.mlir.constant(0 : i32) : i32
      %359 = llvm.mlir.constant(-1 : i32) : i32
      %360 = rocdl.mbcnt.lo %359, %358 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %361 = rocdl.mbcnt.hi %359, %360 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %362 = llvm.mlir.constant(0 : i32) : i32
      %363 = llvm.sub %362, %16 : i32
      %364 = llvm.add %361, %16 : i32
      %365 = llvm.and %364, %363 : i32
      %366 = llvm.xor %361, %12 : i32
      %367 = llvm.icmp "slt" %366, %365 : i32
      %368 = llvm.select %367, %366, %361 : i1, i32
      %369 = llvm.mlir.constant(2 : i32) : i32
      %370 = llvm.shl %368, %369 : i32
      %371 = rocdl.ds_bpermute %370, %357 : (i32, i32) -> i32
      llvm.br ^bb67
    ^bb67:  // pred: ^bb66
      %372 = llvm.xor %357, %371 : i32
      llvm.br ^bb57(%372 : i32)
    ^bb68:  // pred: ^bb57
      %373 = llvm.extractvalue %10[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %374 = llvm.getelementptr inbounds|nuw %373[%11] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, i32
      llvm.store %297, %374 : i32, !llvm.ptr<3>
      llvm.br ^bb70
    ^bb69:  // pred: ^bb35
      llvm.br ^bb70
    ^bb70:  // 2 preds: ^bb68, ^bb69
      rocdl.barrier
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
    llvm.func @gpu_dim_int_max_upper_bound() -> i64 attributes {llvm.emit_c_interface} {
      %0 = rocdl.workgroup.dim.x range <i32, 1, 2147483647> : i32
      %1 = llvm.sext %0 : i32 to i64
      llvm.return %1 : i64
    }
    llvm.func @_mlir_ciface_gpu_dim_int_max_upper_bound() -> i64 attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_dim_int_max_upper_bound() : () -> i64
      llvm.return %0 : i64
    }
  }
}

// -----
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @broadcast(%arg0: i64, %arg1: i32) -> !llvm.struct<(i64, i64)> attributes {llvm.emit_c_interface} {
      %0 = rocdl.readfirstlane %arg0 : i64
      %1 = rocdl.readlane %arg0, %arg1 : (i64, i32) -> i64
      %2 = llvm.mlir.poison : !llvm.struct<(i64, i64)>
      %3 = llvm.insertvalue %0, %2[0] : !llvm.struct<(i64, i64)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(i64, i64)> 
      llvm.return %4 : !llvm.struct<(i64, i64)>
    }
    llvm.func @_mlir_ciface_broadcast(%arg0: !llvm.ptr, %arg1: i64, %arg2: i32) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @broadcast(%arg1, %arg2) : (i64, i32) -> !llvm.struct<(i64, i64)>
      llvm.store %0, %arg0 : !llvm.struct<(i64, i64)>, !llvm.ptr
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
  }
}

