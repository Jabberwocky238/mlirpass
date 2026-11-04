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
      %4 = builtin.unrealized_conversion_cast %3 : !llvm.struct<(ptr, ptr, i64)> to memref<i32>
      %5 = rocdl.workitem.id.x range <i32, 0, 8> : i32
      %6 = llvm.sext %5 : i32 to i64
      %7 = rocdl.workitem.id.y range <i32, 0, 12> : i32
      %8 = llvm.sext %7 : i32 to i64
      %9 = rocdl.workitem.id.z range <i32, 0, 16> : i32
      %10 = llvm.sext %9 : i32 to i64
      %11 = rocdl.workgroup.id.x range <i32, 0, 20> : i32
      %12 = llvm.sext %11 : i32 to i64
      %13 = rocdl.workgroup.id.y range <i32, 0, 24> : i32
      %14 = llvm.sext %13 : i32 to i64
      %15 = rocdl.workgroup.id.z range <i32, 0, 28> : i32
      %16 = llvm.sext %15 : i32 to i64
      %17 = llvm.add %6, %8 : i64
      %18 = llvm.add %17, %10 : i64
      %19 = llvm.add %18, %12 : i64
      %20 = llvm.add %19, %14 : i64
      %21 = llvm.add %20, %16 : i64
      %22 = llvm.trunc %21 : i64 to i32
      memref.store %22, %4[] : memref<i32>
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
      %11 = builtin.unrealized_conversion_cast %10 : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> to memref<32xf32, #gpu.address_space<workgroup>>
      %12 = llvm.mlir.constant(0 : index) : i64
      %13 = builtin.unrealized_conversion_cast %12 : i64 to index
      %14 = llvm.mlir.constant(16 : i32) : i32
      %15 = llvm.mlir.constant(8 : i32) : i32
      %16 = llvm.mlir.constant(4 : i32) : i32
      %17 = llvm.mlir.constant(2 : i32) : i32
      %18 = llvm.mlir.constant(1 : i32) : i32
      %19 = llvm.mlir.constant(32 : i32) : i32
      %20 = llvm.mlir.constant(0 : i32) : i32
      %21 = llvm.mlir.constant(31 : i32) : i32
      %22 = llvm.mlir.constant(1.000000e+00 : f32) : f32
      %23 = rocdl.workgroup.dim.x : i32
      %24 = llvm.sext %23 : i32 to i64
      %25 = llvm.trunc %24 : i64 to i32
      %26 = rocdl.workgroup.dim.y : i32
      %27 = llvm.sext %26 : i32 to i64
      %28 = llvm.trunc %27 : i64 to i32
      %29 = rocdl.workgroup.dim.z : i32
      %30 = llvm.sext %29 : i32 to i64
      %31 = llvm.trunc %30 : i64 to i32
      %32 = rocdl.workitem.id.x : i32
      %33 = llvm.sext %32 : i32 to i64
      %34 = llvm.trunc %33 : i64 to i32
      %35 = rocdl.workitem.id.y : i32
      %36 = llvm.sext %35 : i32 to i64
      %37 = llvm.trunc %36 : i64 to i32
      %38 = rocdl.workitem.id.z : i32
      %39 = llvm.sext %38 : i32 to i64
      %40 = llvm.trunc %39 : i64 to i32
      %41 = llvm.mul %40, %28 : i32
      %42 = llvm.add %41, %37 : i32
      %43 = llvm.mul %42, %25 : i32
      %44 = llvm.mul %25, %28 : i32
      %45 = llvm.add %43, %34 : i32
      %46 = llvm.mul %44, %31 : i32
      %47 = llvm.and %45, %21 : i32
      %48 = llvm.icmp "eq" %47, %20 : i32
      %49 = llvm.sub %45, %47 : i32
      %50 = llvm.sub %46, %49 : i32
      %51 = llvm.icmp "slt" %50, %19 : i32
      cf.cond_br %51, ^bb1, ^bb17
    ^bb1:  // pred: ^bb0
      %52 = llvm.mlir.constant(0 : i32) : i32
      %53 = llvm.mlir.constant(-1 : i32) : i32
      %54 = rocdl.mbcnt.lo %53, %52 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %55 = rocdl.mbcnt.hi %53, %54 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %56 = llvm.mlir.constant(0 : i32) : i32
      %57 = llvm.sub %56, %50 : i32
      %58 = llvm.add %55, %50 : i32
      %59 = llvm.and %58, %57 : i32
      %60 = llvm.xor %55, %18 : i32
      %61 = llvm.icmp "slt" %60, %59 : i32
      %62 = llvm.select %61, %60, %55 : i1, i32
      %63 = llvm.mlir.constant(2 : i32) : i32
      %64 = llvm.shl %62, %63 : i32
      %65 = llvm.bitcast %22 : f32 to i32
      %66 = rocdl.ds_bpermute %64, %65 : (i32, i32) -> i32
      %67 = llvm.bitcast %66 : i32 to f32
      cf.cond_br %61, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %68 = llvm.fadd %67, %22 : f32
      cf.br ^bb4(%68 : f32)
    ^bb3:  // pred: ^bb1
      cf.br ^bb4(%22 : f32)
    ^bb4(%69: f32):  // 2 preds: ^bb2, ^bb3
      %70 = llvm.mlir.constant(0 : i32) : i32
      %71 = llvm.mlir.constant(-1 : i32) : i32
      %72 = rocdl.mbcnt.lo %71, %70 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %73 = rocdl.mbcnt.hi %71, %72 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %74 = llvm.mlir.constant(0 : i32) : i32
      %75 = llvm.sub %74, %50 : i32
      %76 = llvm.add %73, %50 : i32
      %77 = llvm.and %76, %75 : i32
      %78 = llvm.xor %73, %17 : i32
      %79 = llvm.icmp "slt" %78, %77 : i32
      %80 = llvm.select %79, %78, %73 : i1, i32
      %81 = llvm.mlir.constant(2 : i32) : i32
      %82 = llvm.shl %80, %81 : i32
      %83 = llvm.bitcast %69 : f32 to i32
      %84 = rocdl.ds_bpermute %82, %83 : (i32, i32) -> i32
      %85 = llvm.bitcast %84 : i32 to f32
      cf.cond_br %79, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      %86 = llvm.fadd %69, %85 : f32
      cf.br ^bb7(%86 : f32)
    ^bb6:  // pred: ^bb4
      cf.br ^bb7(%69 : f32)
    ^bb7(%87: f32):  // 2 preds: ^bb5, ^bb6
      %88 = llvm.mlir.constant(0 : i32) : i32
      %89 = llvm.mlir.constant(-1 : i32) : i32
      %90 = rocdl.mbcnt.lo %89, %88 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %91 = rocdl.mbcnt.hi %89, %90 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %92 = llvm.mlir.constant(0 : i32) : i32
      %93 = llvm.sub %92, %50 : i32
      %94 = llvm.add %91, %50 : i32
      %95 = llvm.and %94, %93 : i32
      %96 = llvm.xor %91, %16 : i32
      %97 = llvm.icmp "slt" %96, %95 : i32
      %98 = llvm.select %97, %96, %91 : i1, i32
      %99 = llvm.mlir.constant(2 : i32) : i32
      %100 = llvm.shl %98, %99 : i32
      %101 = llvm.bitcast %87 : f32 to i32
      %102 = rocdl.ds_bpermute %100, %101 : (i32, i32) -> i32
      %103 = llvm.bitcast %102 : i32 to f32
      cf.cond_br %97, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %104 = llvm.fadd %87, %103 : f32
      cf.br ^bb10(%104 : f32)
    ^bb9:  // pred: ^bb7
      cf.br ^bb10(%87 : f32)
    ^bb10(%105: f32):  // 2 preds: ^bb8, ^bb9
      %106 = llvm.mlir.constant(0 : i32) : i32
      %107 = llvm.mlir.constant(-1 : i32) : i32
      %108 = rocdl.mbcnt.lo %107, %106 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %109 = rocdl.mbcnt.hi %107, %108 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %110 = llvm.mlir.constant(0 : i32) : i32
      %111 = llvm.sub %110, %50 : i32
      %112 = llvm.add %109, %50 : i32
      %113 = llvm.and %112, %111 : i32
      %114 = llvm.xor %109, %15 : i32
      %115 = llvm.icmp "slt" %114, %113 : i32
      %116 = llvm.select %115, %114, %109 : i1, i32
      %117 = llvm.mlir.constant(2 : i32) : i32
      %118 = llvm.shl %116, %117 : i32
      %119 = llvm.bitcast %105 : f32 to i32
      %120 = rocdl.ds_bpermute %118, %119 : (i32, i32) -> i32
      %121 = llvm.bitcast %120 : i32 to f32
      cf.cond_br %115, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      %122 = llvm.fadd %105, %121 : f32
      cf.br ^bb13(%122 : f32)
    ^bb12:  // pred: ^bb10
      cf.br ^bb13(%105 : f32)
    ^bb13(%123: f32):  // 2 preds: ^bb11, ^bb12
      %124 = llvm.mlir.constant(0 : i32) : i32
      %125 = llvm.mlir.constant(-1 : i32) : i32
      %126 = rocdl.mbcnt.lo %125, %124 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %127 = rocdl.mbcnt.hi %125, %126 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %128 = llvm.mlir.constant(0 : i32) : i32
      %129 = llvm.sub %128, %50 : i32
      %130 = llvm.add %127, %50 : i32
      %131 = llvm.and %130, %129 : i32
      %132 = llvm.xor %127, %14 : i32
      %133 = llvm.icmp "slt" %132, %131 : i32
      %134 = llvm.select %133, %132, %127 : i1, i32
      %135 = llvm.mlir.constant(2 : i32) : i32
      %136 = llvm.shl %134, %135 : i32
      %137 = llvm.bitcast %123 : f32 to i32
      %138 = rocdl.ds_bpermute %136, %137 : (i32, i32) -> i32
      %139 = llvm.bitcast %138 : i32 to f32
      cf.cond_br %133, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %140 = llvm.fadd %123, %139 : f32
      cf.br ^bb16(%140 : f32)
    ^bb15:  // pred: ^bb13
      cf.br ^bb16(%123 : f32)
    ^bb16(%141: f32):  // 2 preds: ^bb14, ^bb15
      cf.br ^bb18(%141 : f32)
    ^bb17:  // pred: ^bb0
      %142 = llvm.mlir.constant(0 : i32) : i32
      %143 = llvm.mlir.constant(-1 : i32) : i32
      %144 = rocdl.mbcnt.lo %143, %142 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %145 = rocdl.mbcnt.hi %143, %144 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %146 = llvm.mlir.constant(0 : i32) : i32
      %147 = llvm.sub %146, %19 : i32
      %148 = llvm.add %145, %19 : i32
      %149 = llvm.and %148, %147 : i32
      %150 = llvm.xor %145, %18 : i32
      %151 = llvm.icmp "slt" %150, %149 : i32
      %152 = llvm.select %151, %150, %145 : i1, i32
      %153 = llvm.mlir.constant(2 : i32) : i32
      %154 = llvm.shl %152, %153 : i32
      %155 = llvm.bitcast %22 : f32 to i32
      %156 = rocdl.ds_bpermute %154, %155 : (i32, i32) -> i32
      %157 = llvm.bitcast %156 : i32 to f32
      %158 = llvm.fadd %157, %22 : f32
      %159 = llvm.mlir.constant(0 : i32) : i32
      %160 = llvm.mlir.constant(-1 : i32) : i32
      %161 = rocdl.mbcnt.lo %160, %159 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %162 = rocdl.mbcnt.hi %160, %161 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %163 = llvm.mlir.constant(0 : i32) : i32
      %164 = llvm.sub %163, %19 : i32
      %165 = llvm.add %162, %19 : i32
      %166 = llvm.and %165, %164 : i32
      %167 = llvm.xor %162, %17 : i32
      %168 = llvm.icmp "slt" %167, %166 : i32
      %169 = llvm.select %168, %167, %162 : i1, i32
      %170 = llvm.mlir.constant(2 : i32) : i32
      %171 = llvm.shl %169, %170 : i32
      %172 = llvm.bitcast %158 : f32 to i32
      %173 = rocdl.ds_bpermute %171, %172 : (i32, i32) -> i32
      %174 = llvm.bitcast %173 : i32 to f32
      %175 = llvm.fadd %158, %174 : f32
      %176 = llvm.mlir.constant(0 : i32) : i32
      %177 = llvm.mlir.constant(-1 : i32) : i32
      %178 = rocdl.mbcnt.lo %177, %176 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %179 = rocdl.mbcnt.hi %177, %178 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %180 = llvm.mlir.constant(0 : i32) : i32
      %181 = llvm.sub %180, %19 : i32
      %182 = llvm.add %179, %19 : i32
      %183 = llvm.and %182, %181 : i32
      %184 = llvm.xor %179, %16 : i32
      %185 = llvm.icmp "slt" %184, %183 : i32
      %186 = llvm.select %185, %184, %179 : i1, i32
      %187 = llvm.mlir.constant(2 : i32) : i32
      %188 = llvm.shl %186, %187 : i32
      %189 = llvm.bitcast %175 : f32 to i32
      %190 = rocdl.ds_bpermute %188, %189 : (i32, i32) -> i32
      %191 = llvm.bitcast %190 : i32 to f32
      %192 = llvm.fadd %175, %191 : f32
      %193 = llvm.mlir.constant(0 : i32) : i32
      %194 = llvm.mlir.constant(-1 : i32) : i32
      %195 = rocdl.mbcnt.lo %194, %193 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %196 = rocdl.mbcnt.hi %194, %195 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %197 = llvm.mlir.constant(0 : i32) : i32
      %198 = llvm.sub %197, %19 : i32
      %199 = llvm.add %196, %19 : i32
      %200 = llvm.and %199, %198 : i32
      %201 = llvm.xor %196, %15 : i32
      %202 = llvm.icmp "slt" %201, %200 : i32
      %203 = llvm.select %202, %201, %196 : i1, i32
      %204 = llvm.mlir.constant(2 : i32) : i32
      %205 = llvm.shl %203, %204 : i32
      %206 = llvm.bitcast %192 : f32 to i32
      %207 = rocdl.ds_bpermute %205, %206 : (i32, i32) -> i32
      %208 = llvm.bitcast %207 : i32 to f32
      %209 = llvm.fadd %192, %208 : f32
      %210 = llvm.mlir.constant(0 : i32) : i32
      %211 = llvm.mlir.constant(-1 : i32) : i32
      %212 = rocdl.mbcnt.lo %211, %210 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %213 = rocdl.mbcnt.hi %211, %212 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %214 = llvm.mlir.constant(0 : i32) : i32
      %215 = llvm.sub %214, %19 : i32
      %216 = llvm.add %213, %19 : i32
      %217 = llvm.and %216, %215 : i32
      %218 = llvm.xor %213, %14 : i32
      %219 = llvm.icmp "slt" %218, %217 : i32
      %220 = llvm.select %219, %218, %213 : i1, i32
      %221 = llvm.mlir.constant(2 : i32) : i32
      %222 = llvm.shl %220, %221 : i32
      %223 = llvm.bitcast %209 : f32 to i32
      %224 = rocdl.ds_bpermute %222, %223 : (i32, i32) -> i32
      %225 = llvm.bitcast %224 : i32 to f32
      %226 = llvm.fadd %209, %225 : f32
      cf.br ^bb18(%226 : f32)
    ^bb18(%227: f32):  // 2 preds: ^bb16, ^bb17
      cf.cond_br %48, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      %228 = llvm.sdiv %45, %19 : i32
      %229 = llvm.sext %228 : i32 to i64
      %230 = builtin.unrealized_conversion_cast %229 : i64 to index
      memref.store %227, %11[%230] : memref<32xf32, #gpu.address_space<workgroup>>
      cf.br ^bb21
    ^bb20:  // pred: ^bb18
      cf.br ^bb21
    ^bb21:  // 2 preds: ^bb19, ^bb20
      rocdl.barrier
      %231 = llvm.add %46, %21 : i32
      %232 = llvm.sdiv %231, %19 : i32
      %233 = llvm.icmp "slt" %45, %232 : i32
      cf.cond_br %233, ^bb22, ^bb41
    ^bb22:  // pred: ^bb21
      %234 = llvm.sext %45 : i32 to i64
      %235 = builtin.unrealized_conversion_cast %234 : i64 to index
      %236 = memref.load %11[%235] : memref<32xf32, #gpu.address_space<workgroup>>
      %237 = llvm.icmp "slt" %232, %19 : i32
      cf.cond_br %237, ^bb23, ^bb39
    ^bb23:  // pred: ^bb22
      %238 = llvm.mlir.constant(0 : i32) : i32
      %239 = llvm.mlir.constant(-1 : i32) : i32
      %240 = rocdl.mbcnt.lo %239, %238 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %241 = rocdl.mbcnt.hi %239, %240 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %242 = llvm.mlir.constant(0 : i32) : i32
      %243 = llvm.sub %242, %232 : i32
      %244 = llvm.add %241, %232 : i32
      %245 = llvm.and %244, %243 : i32
      %246 = llvm.xor %241, %18 : i32
      %247 = llvm.icmp "slt" %246, %245 : i32
      %248 = llvm.select %247, %246, %241 : i1, i32
      %249 = llvm.mlir.constant(2 : i32) : i32
      %250 = llvm.shl %248, %249 : i32
      %251 = llvm.bitcast %236 : f32 to i32
      %252 = rocdl.ds_bpermute %250, %251 : (i32, i32) -> i32
      %253 = llvm.bitcast %252 : i32 to f32
      cf.cond_br %247, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      %254 = llvm.fadd %236, %253 : f32
      cf.br ^bb26(%254 : f32)
    ^bb25:  // pred: ^bb23
      cf.br ^bb26(%236 : f32)
    ^bb26(%255: f32):  // 2 preds: ^bb24, ^bb25
      %256 = llvm.mlir.constant(0 : i32) : i32
      %257 = llvm.mlir.constant(-1 : i32) : i32
      %258 = rocdl.mbcnt.lo %257, %256 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %259 = rocdl.mbcnt.hi %257, %258 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %260 = llvm.mlir.constant(0 : i32) : i32
      %261 = llvm.sub %260, %232 : i32
      %262 = llvm.add %259, %232 : i32
      %263 = llvm.and %262, %261 : i32
      %264 = llvm.xor %259, %17 : i32
      %265 = llvm.icmp "slt" %264, %263 : i32
      %266 = llvm.select %265, %264, %259 : i1, i32
      %267 = llvm.mlir.constant(2 : i32) : i32
      %268 = llvm.shl %266, %267 : i32
      %269 = llvm.bitcast %255 : f32 to i32
      %270 = rocdl.ds_bpermute %268, %269 : (i32, i32) -> i32
      %271 = llvm.bitcast %270 : i32 to f32
      cf.cond_br %265, ^bb27, ^bb28
    ^bb27:  // pred: ^bb26
      %272 = llvm.fadd %255, %271 : f32
      cf.br ^bb29(%272 : f32)
    ^bb28:  // pred: ^bb26
      cf.br ^bb29(%255 : f32)
    ^bb29(%273: f32):  // 2 preds: ^bb27, ^bb28
      %274 = llvm.mlir.constant(0 : i32) : i32
      %275 = llvm.mlir.constant(-1 : i32) : i32
      %276 = rocdl.mbcnt.lo %275, %274 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %277 = rocdl.mbcnt.hi %275, %276 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %278 = llvm.mlir.constant(0 : i32) : i32
      %279 = llvm.sub %278, %232 : i32
      %280 = llvm.add %277, %232 : i32
      %281 = llvm.and %280, %279 : i32
      %282 = llvm.xor %277, %16 : i32
      %283 = llvm.icmp "slt" %282, %281 : i32
      %284 = llvm.select %283, %282, %277 : i1, i32
      %285 = llvm.mlir.constant(2 : i32) : i32
      %286 = llvm.shl %284, %285 : i32
      %287 = llvm.bitcast %273 : f32 to i32
      %288 = rocdl.ds_bpermute %286, %287 : (i32, i32) -> i32
      %289 = llvm.bitcast %288 : i32 to f32
      cf.cond_br %283, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      %290 = llvm.fadd %273, %289 : f32
      cf.br ^bb32(%290 : f32)
    ^bb31:  // pred: ^bb29
      cf.br ^bb32(%273 : f32)
    ^bb32(%291: f32):  // 2 preds: ^bb30, ^bb31
      %292 = llvm.mlir.constant(0 : i32) : i32
      %293 = llvm.mlir.constant(-1 : i32) : i32
      %294 = rocdl.mbcnt.lo %293, %292 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %295 = rocdl.mbcnt.hi %293, %294 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %296 = llvm.mlir.constant(0 : i32) : i32
      %297 = llvm.sub %296, %232 : i32
      %298 = llvm.add %295, %232 : i32
      %299 = llvm.and %298, %297 : i32
      %300 = llvm.xor %295, %15 : i32
      %301 = llvm.icmp "slt" %300, %299 : i32
      %302 = llvm.select %301, %300, %295 : i1, i32
      %303 = llvm.mlir.constant(2 : i32) : i32
      %304 = llvm.shl %302, %303 : i32
      %305 = llvm.bitcast %291 : f32 to i32
      %306 = rocdl.ds_bpermute %304, %305 : (i32, i32) -> i32
      %307 = llvm.bitcast %306 : i32 to f32
      cf.cond_br %301, ^bb33, ^bb34
    ^bb33:  // pred: ^bb32
      %308 = llvm.fadd %291, %307 : f32
      cf.br ^bb35(%308 : f32)
    ^bb34:  // pred: ^bb32
      cf.br ^bb35(%291 : f32)
    ^bb35(%309: f32):  // 2 preds: ^bb33, ^bb34
      %310 = llvm.mlir.constant(0 : i32) : i32
      %311 = llvm.mlir.constant(-1 : i32) : i32
      %312 = rocdl.mbcnt.lo %311, %310 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %313 = rocdl.mbcnt.hi %311, %312 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %314 = llvm.mlir.constant(0 : i32) : i32
      %315 = llvm.sub %314, %232 : i32
      %316 = llvm.add %313, %232 : i32
      %317 = llvm.and %316, %315 : i32
      %318 = llvm.xor %313, %14 : i32
      %319 = llvm.icmp "slt" %318, %317 : i32
      %320 = llvm.select %319, %318, %313 : i1, i32
      %321 = llvm.mlir.constant(2 : i32) : i32
      %322 = llvm.shl %320, %321 : i32
      %323 = llvm.bitcast %309 : f32 to i32
      %324 = rocdl.ds_bpermute %322, %323 : (i32, i32) -> i32
      %325 = llvm.bitcast %324 : i32 to f32
      cf.cond_br %319, ^bb36, ^bb37
    ^bb36:  // pred: ^bb35
      %326 = llvm.fadd %309, %325 : f32
      cf.br ^bb38(%326 : f32)
    ^bb37:  // pred: ^bb35
      cf.br ^bb38(%309 : f32)
    ^bb38(%327: f32):  // 2 preds: ^bb36, ^bb37
      cf.br ^bb40(%327 : f32)
    ^bb39:  // pred: ^bb22
      %328 = llvm.mlir.constant(0 : i32) : i32
      %329 = llvm.mlir.constant(-1 : i32) : i32
      %330 = rocdl.mbcnt.lo %329, %328 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %331 = rocdl.mbcnt.hi %329, %330 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %332 = llvm.mlir.constant(0 : i32) : i32
      %333 = llvm.sub %332, %19 : i32
      %334 = llvm.add %331, %19 : i32
      %335 = llvm.and %334, %333 : i32
      %336 = llvm.xor %331, %18 : i32
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
      %350 = llvm.sub %349, %19 : i32
      %351 = llvm.add %348, %19 : i32
      %352 = llvm.and %351, %350 : i32
      %353 = llvm.xor %348, %17 : i32
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
      %367 = llvm.sub %366, %19 : i32
      %368 = llvm.add %365, %19 : i32
      %369 = llvm.and %368, %367 : i32
      %370 = llvm.xor %365, %16 : i32
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
      %384 = llvm.sub %383, %19 : i32
      %385 = llvm.add %382, %19 : i32
      %386 = llvm.and %385, %384 : i32
      %387 = llvm.xor %382, %15 : i32
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
      %401 = llvm.sub %400, %19 : i32
      %402 = llvm.add %399, %19 : i32
      %403 = llvm.and %402, %401 : i32
      %404 = llvm.xor %399, %14 : i32
      %405 = llvm.icmp "slt" %404, %403 : i32
      %406 = llvm.select %405, %404, %399 : i1, i32
      %407 = llvm.mlir.constant(2 : i32) : i32
      %408 = llvm.shl %406, %407 : i32
      %409 = llvm.bitcast %395 : f32 to i32
      %410 = rocdl.ds_bpermute %408, %409 : (i32, i32) -> i32
      %411 = llvm.bitcast %410 : i32 to f32
      %412 = llvm.fadd %395, %411 : f32
      cf.br ^bb40(%412 : f32)
    ^bb40(%413: f32):  // 2 preds: ^bb38, ^bb39
      memref.store %413, %11[%13] : memref<32xf32, #gpu.address_space<workgroup>>
      cf.br ^bb42
    ^bb41:  // pred: ^bb21
      cf.br ^bb42
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
      %11 = builtin.unrealized_conversion_cast %10 : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> to memref<32xi32, #gpu.address_space<workgroup>>
      %12 = llvm.mlir.constant(0 : index) : i64
      %13 = builtin.unrealized_conversion_cast %12 : i64 to index
      %14 = llvm.mlir.constant(16 : i32) : i32
      %15 = llvm.mlir.constant(8 : i32) : i32
      %16 = llvm.mlir.constant(4 : i32) : i32
      %17 = llvm.mlir.constant(2 : i32) : i32
      %18 = llvm.mlir.constant(32 : i32) : i32
      %19 = llvm.mlir.constant(0 : i32) : i32
      %20 = llvm.mlir.constant(31 : i32) : i32
      %21 = llvm.mlir.constant(1 : i32) : i32
      %22 = rocdl.workgroup.dim.x : i32
      %23 = llvm.sext %22 : i32 to i64
      %24 = llvm.trunc %23 : i64 to i32
      %25 = rocdl.workgroup.dim.y : i32
      %26 = llvm.sext %25 : i32 to i64
      %27 = llvm.trunc %26 : i64 to i32
      %28 = rocdl.workgroup.dim.z : i32
      %29 = llvm.sext %28 : i32 to i64
      %30 = llvm.trunc %29 : i64 to i32
      %31 = rocdl.workitem.id.x : i32
      %32 = llvm.sext %31 : i32 to i64
      %33 = llvm.trunc %32 : i64 to i32
      %34 = rocdl.workitem.id.y : i32
      %35 = llvm.sext %34 : i32 to i64
      %36 = llvm.trunc %35 : i64 to i32
      %37 = rocdl.workitem.id.z : i32
      %38 = llvm.sext %37 : i32 to i64
      %39 = llvm.trunc %38 : i64 to i32
      %40 = llvm.mul %39, %27 : i32
      %41 = llvm.add %40, %36 : i32
      %42 = llvm.mul %41, %24 : i32
      %43 = llvm.mul %24, %27 : i32
      %44 = llvm.add %42, %33 : i32
      %45 = llvm.mul %43, %30 : i32
      %46 = llvm.and %44, %20 : i32
      %47 = llvm.icmp "eq" %46, %19 : i32
      %48 = llvm.sub %44, %46 : i32
      %49 = llvm.sub %45, %48 : i32
      %50 = llvm.icmp "slt" %49, %18 : i32
      cf.cond_br %50, ^bb1, ^bb22
    ^bb1:  // pred: ^bb0
      %51 = llvm.mlir.constant(0 : i32) : i32
      %52 = llvm.mlir.constant(-1 : i32) : i32
      %53 = rocdl.mbcnt.lo %52, %51 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %54 = rocdl.mbcnt.hi %52, %53 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %55 = llvm.mlir.constant(0 : i32) : i32
      %56 = llvm.sub %55, %49 : i32
      %57 = llvm.add %54, %49 : i32
      %58 = llvm.and %57, %56 : i32
      %59 = llvm.xor %54, %21 : i32
      %60 = llvm.icmp "slt" %59, %58 : i32
      %61 = llvm.select %60, %59, %54 : i1, i32
      %62 = llvm.mlir.constant(2 : i32) : i32
      %63 = llvm.shl %61, %62 : i32
      %64 = rocdl.ds_bpermute %63, %21 : (i32, i32) -> i32
      cf.cond_br %60, ^bb2, ^bb4(%21 : i32)
    ^bb2:  // pred: ^bb1
      cf.br ^bb3
    ^bb3:  // pred: ^bb2
      %65 = llvm.xor %64, %21 : i32
      cf.br ^bb4(%65 : i32)
    ^bb4(%66: i32):  // 2 preds: ^bb1, ^bb3
      cf.br ^bb5
    ^bb5:  // pred: ^bb4
      %67 = llvm.mlir.constant(0 : i32) : i32
      %68 = llvm.mlir.constant(-1 : i32) : i32
      %69 = rocdl.mbcnt.lo %68, %67 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %70 = rocdl.mbcnt.hi %68, %69 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %71 = llvm.mlir.constant(0 : i32) : i32
      %72 = llvm.sub %71, %49 : i32
      %73 = llvm.add %70, %49 : i32
      %74 = llvm.and %73, %72 : i32
      %75 = llvm.xor %70, %17 : i32
      %76 = llvm.icmp "slt" %75, %74 : i32
      %77 = llvm.select %76, %75, %70 : i1, i32
      %78 = llvm.mlir.constant(2 : i32) : i32
      %79 = llvm.shl %77, %78 : i32
      %80 = rocdl.ds_bpermute %79, %66 : (i32, i32) -> i32
      cf.cond_br %76, ^bb6, ^bb8(%66 : i32)
    ^bb6:  // pred: ^bb5
      cf.br ^bb7
    ^bb7:  // pred: ^bb6
      %81 = llvm.xor %66, %80 : i32
      cf.br ^bb8(%81 : i32)
    ^bb8(%82: i32):  // 2 preds: ^bb5, ^bb7
      cf.br ^bb9
    ^bb9:  // pred: ^bb8
      %83 = llvm.mlir.constant(0 : i32) : i32
      %84 = llvm.mlir.constant(-1 : i32) : i32
      %85 = rocdl.mbcnt.lo %84, %83 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %86 = rocdl.mbcnt.hi %84, %85 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %87 = llvm.mlir.constant(0 : i32) : i32
      %88 = llvm.sub %87, %49 : i32
      %89 = llvm.add %86, %49 : i32
      %90 = llvm.and %89, %88 : i32
      %91 = llvm.xor %86, %16 : i32
      %92 = llvm.icmp "slt" %91, %90 : i32
      %93 = llvm.select %92, %91, %86 : i1, i32
      %94 = llvm.mlir.constant(2 : i32) : i32
      %95 = llvm.shl %93, %94 : i32
      %96 = rocdl.ds_bpermute %95, %82 : (i32, i32) -> i32
      cf.cond_br %92, ^bb10, ^bb12(%82 : i32)
    ^bb10:  // pred: ^bb9
      cf.br ^bb11
    ^bb11:  // pred: ^bb10
      %97 = llvm.xor %82, %96 : i32
      cf.br ^bb12(%97 : i32)
    ^bb12(%98: i32):  // 2 preds: ^bb9, ^bb11
      cf.br ^bb13
    ^bb13:  // pred: ^bb12
      %99 = llvm.mlir.constant(0 : i32) : i32
      %100 = llvm.mlir.constant(-1 : i32) : i32
      %101 = rocdl.mbcnt.lo %100, %99 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %102 = rocdl.mbcnt.hi %100, %101 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %103 = llvm.mlir.constant(0 : i32) : i32
      %104 = llvm.sub %103, %49 : i32
      %105 = llvm.add %102, %49 : i32
      %106 = llvm.and %105, %104 : i32
      %107 = llvm.xor %102, %15 : i32
      %108 = llvm.icmp "slt" %107, %106 : i32
      %109 = llvm.select %108, %107, %102 : i1, i32
      %110 = llvm.mlir.constant(2 : i32) : i32
      %111 = llvm.shl %109, %110 : i32
      %112 = rocdl.ds_bpermute %111, %98 : (i32, i32) -> i32
      cf.cond_br %108, ^bb14, ^bb16(%98 : i32)
    ^bb14:  // pred: ^bb13
      cf.br ^bb15
    ^bb15:  // pred: ^bb14
      %113 = llvm.xor %98, %112 : i32
      cf.br ^bb16(%113 : i32)
    ^bb16(%114: i32):  // 2 preds: ^bb13, ^bb15
      cf.br ^bb17
    ^bb17:  // pred: ^bb16
      %115 = llvm.mlir.constant(0 : i32) : i32
      %116 = llvm.mlir.constant(-1 : i32) : i32
      %117 = rocdl.mbcnt.lo %116, %115 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %118 = rocdl.mbcnt.hi %116, %117 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %119 = llvm.mlir.constant(0 : i32) : i32
      %120 = llvm.sub %119, %49 : i32
      %121 = llvm.add %118, %49 : i32
      %122 = llvm.and %121, %120 : i32
      %123 = llvm.xor %118, %14 : i32
      %124 = llvm.icmp "slt" %123, %122 : i32
      %125 = llvm.select %124, %123, %118 : i1, i32
      %126 = llvm.mlir.constant(2 : i32) : i32
      %127 = llvm.shl %125, %126 : i32
      %128 = rocdl.ds_bpermute %127, %114 : (i32, i32) -> i32
      cf.cond_br %124, ^bb18, ^bb20(%114 : i32)
    ^bb18:  // pred: ^bb17
      cf.br ^bb19
    ^bb19:  // pred: ^bb18
      %129 = llvm.xor %114, %128 : i32
      cf.br ^bb20(%129 : i32)
    ^bb20(%130: i32):  // 2 preds: ^bb17, ^bb19
      cf.br ^bb21(%130 : i32)
    ^bb21(%131: i32):  // 2 preds: ^bb20, ^bb31
      cf.br ^bb32
    ^bb22:  // pred: ^bb0
      %132 = llvm.mlir.constant(0 : i32) : i32
      %133 = llvm.mlir.constant(-1 : i32) : i32
      %134 = rocdl.mbcnt.lo %133, %132 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %135 = rocdl.mbcnt.hi %133, %134 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %136 = llvm.mlir.constant(0 : i32) : i32
      %137 = llvm.sub %136, %18 : i32
      %138 = llvm.add %135, %18 : i32
      %139 = llvm.and %138, %137 : i32
      %140 = llvm.xor %135, %21 : i32
      %141 = llvm.icmp "slt" %140, %139 : i32
      %142 = llvm.select %141, %140, %135 : i1, i32
      %143 = llvm.mlir.constant(2 : i32) : i32
      %144 = llvm.shl %142, %143 : i32
      %145 = rocdl.ds_bpermute %144, %21 : (i32, i32) -> i32
      cf.br ^bb23
    ^bb23:  // pred: ^bb22
      %146 = llvm.xor %145, %21 : i32
      cf.br ^bb24
    ^bb24:  // pred: ^bb23
      %147 = llvm.mlir.constant(0 : i32) : i32
      %148 = llvm.mlir.constant(-1 : i32) : i32
      %149 = rocdl.mbcnt.lo %148, %147 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %150 = rocdl.mbcnt.hi %148, %149 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %151 = llvm.mlir.constant(0 : i32) : i32
      %152 = llvm.sub %151, %18 : i32
      %153 = llvm.add %150, %18 : i32
      %154 = llvm.and %153, %152 : i32
      %155 = llvm.xor %150, %17 : i32
      %156 = llvm.icmp "slt" %155, %154 : i32
      %157 = llvm.select %156, %155, %150 : i1, i32
      %158 = llvm.mlir.constant(2 : i32) : i32
      %159 = llvm.shl %157, %158 : i32
      %160 = rocdl.ds_bpermute %159, %146 : (i32, i32) -> i32
      cf.br ^bb25
    ^bb25:  // pred: ^bb24
      %161 = llvm.xor %146, %160 : i32
      cf.br ^bb26
    ^bb26:  // pred: ^bb25
      %162 = llvm.mlir.constant(0 : i32) : i32
      %163 = llvm.mlir.constant(-1 : i32) : i32
      %164 = rocdl.mbcnt.lo %163, %162 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %165 = rocdl.mbcnt.hi %163, %164 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %166 = llvm.mlir.constant(0 : i32) : i32
      %167 = llvm.sub %166, %18 : i32
      %168 = llvm.add %165, %18 : i32
      %169 = llvm.and %168, %167 : i32
      %170 = llvm.xor %165, %16 : i32
      %171 = llvm.icmp "slt" %170, %169 : i32
      %172 = llvm.select %171, %170, %165 : i1, i32
      %173 = llvm.mlir.constant(2 : i32) : i32
      %174 = llvm.shl %172, %173 : i32
      %175 = rocdl.ds_bpermute %174, %161 : (i32, i32) -> i32
      cf.br ^bb27
    ^bb27:  // pred: ^bb26
      %176 = llvm.xor %161, %175 : i32
      cf.br ^bb28
    ^bb28:  // pred: ^bb27
      %177 = llvm.mlir.constant(0 : i32) : i32
      %178 = llvm.mlir.constant(-1 : i32) : i32
      %179 = rocdl.mbcnt.lo %178, %177 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %180 = rocdl.mbcnt.hi %178, %179 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %181 = llvm.mlir.constant(0 : i32) : i32
      %182 = llvm.sub %181, %18 : i32
      %183 = llvm.add %180, %18 : i32
      %184 = llvm.and %183, %182 : i32
      %185 = llvm.xor %180, %15 : i32
      %186 = llvm.icmp "slt" %185, %184 : i32
      %187 = llvm.select %186, %185, %180 : i1, i32
      %188 = llvm.mlir.constant(2 : i32) : i32
      %189 = llvm.shl %187, %188 : i32
      %190 = rocdl.ds_bpermute %189, %176 : (i32, i32) -> i32
      cf.br ^bb29
    ^bb29:  // pred: ^bb28
      %191 = llvm.xor %176, %190 : i32
      cf.br ^bb30
    ^bb30:  // pred: ^bb29
      %192 = llvm.mlir.constant(0 : i32) : i32
      %193 = llvm.mlir.constant(-1 : i32) : i32
      %194 = rocdl.mbcnt.lo %193, %192 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %195 = rocdl.mbcnt.hi %193, %194 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %196 = llvm.mlir.constant(0 : i32) : i32
      %197 = llvm.sub %196, %18 : i32
      %198 = llvm.add %195, %18 : i32
      %199 = llvm.and %198, %197 : i32
      %200 = llvm.xor %195, %14 : i32
      %201 = llvm.icmp "slt" %200, %199 : i32
      %202 = llvm.select %201, %200, %195 : i1, i32
      %203 = llvm.mlir.constant(2 : i32) : i32
      %204 = llvm.shl %202, %203 : i32
      %205 = rocdl.ds_bpermute %204, %191 : (i32, i32) -> i32
      cf.br ^bb31
    ^bb31:  // pred: ^bb30
      %206 = llvm.xor %191, %205 : i32
      cf.br ^bb21(%206 : i32)
    ^bb32:  // pred: ^bb21
      cf.cond_br %47, ^bb33, ^bb34
    ^bb33:  // pred: ^bb32
      %207 = llvm.sdiv %44, %18 : i32
      %208 = llvm.sext %207 : i32 to i64
      %209 = builtin.unrealized_conversion_cast %208 : i64 to index
      memref.store %131, %11[%209] : memref<32xi32, #gpu.address_space<workgroup>>
      cf.br ^bb35
    ^bb34:  // pred: ^bb32
      cf.br ^bb35
    ^bb35:  // 2 preds: ^bb33, ^bb34
      rocdl.barrier
      %210 = llvm.add %45, %20 : i32
      %211 = llvm.sdiv %210, %18 : i32
      %212 = llvm.icmp "slt" %44, %211 : i32
      cf.cond_br %212, ^bb36, ^bb69
    ^bb36:  // pred: ^bb35
      %213 = llvm.sext %44 : i32 to i64
      %214 = builtin.unrealized_conversion_cast %213 : i64 to index
      %215 = memref.load %11[%214] : memref<32xi32, #gpu.address_space<workgroup>>
      %216 = llvm.icmp "slt" %211, %18 : i32
      cf.cond_br %216, ^bb37, ^bb58
    ^bb37:  // pred: ^bb36
      %217 = llvm.mlir.constant(0 : i32) : i32
      %218 = llvm.mlir.constant(-1 : i32) : i32
      %219 = rocdl.mbcnt.lo %218, %217 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %220 = rocdl.mbcnt.hi %218, %219 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %221 = llvm.mlir.constant(0 : i32) : i32
      %222 = llvm.sub %221, %211 : i32
      %223 = llvm.add %220, %211 : i32
      %224 = llvm.and %223, %222 : i32
      %225 = llvm.xor %220, %21 : i32
      %226 = llvm.icmp "slt" %225, %224 : i32
      %227 = llvm.select %226, %225, %220 : i1, i32
      %228 = llvm.mlir.constant(2 : i32) : i32
      %229 = llvm.shl %227, %228 : i32
      %230 = rocdl.ds_bpermute %229, %215 : (i32, i32) -> i32
      cf.cond_br %226, ^bb38, ^bb40(%215 : i32)
    ^bb38:  // pred: ^bb37
      cf.br ^bb39
    ^bb39:  // pred: ^bb38
      %231 = llvm.xor %215, %230 : i32
      cf.br ^bb40(%231 : i32)
    ^bb40(%232: i32):  // 2 preds: ^bb37, ^bb39
      cf.br ^bb41
    ^bb41:  // pred: ^bb40
      %233 = llvm.mlir.constant(0 : i32) : i32
      %234 = llvm.mlir.constant(-1 : i32) : i32
      %235 = rocdl.mbcnt.lo %234, %233 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %236 = rocdl.mbcnt.hi %234, %235 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %237 = llvm.mlir.constant(0 : i32) : i32
      %238 = llvm.sub %237, %211 : i32
      %239 = llvm.add %236, %211 : i32
      %240 = llvm.and %239, %238 : i32
      %241 = llvm.xor %236, %17 : i32
      %242 = llvm.icmp "slt" %241, %240 : i32
      %243 = llvm.select %242, %241, %236 : i1, i32
      %244 = llvm.mlir.constant(2 : i32) : i32
      %245 = llvm.shl %243, %244 : i32
      %246 = rocdl.ds_bpermute %245, %232 : (i32, i32) -> i32
      cf.cond_br %242, ^bb42, ^bb44(%232 : i32)
    ^bb42:  // pred: ^bb41
      cf.br ^bb43
    ^bb43:  // pred: ^bb42
      %247 = llvm.xor %232, %246 : i32
      cf.br ^bb44(%247 : i32)
    ^bb44(%248: i32):  // 2 preds: ^bb41, ^bb43
      cf.br ^bb45
    ^bb45:  // pred: ^bb44
      %249 = llvm.mlir.constant(0 : i32) : i32
      %250 = llvm.mlir.constant(-1 : i32) : i32
      %251 = rocdl.mbcnt.lo %250, %249 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %252 = rocdl.mbcnt.hi %250, %251 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %253 = llvm.mlir.constant(0 : i32) : i32
      %254 = llvm.sub %253, %211 : i32
      %255 = llvm.add %252, %211 : i32
      %256 = llvm.and %255, %254 : i32
      %257 = llvm.xor %252, %16 : i32
      %258 = llvm.icmp "slt" %257, %256 : i32
      %259 = llvm.select %258, %257, %252 : i1, i32
      %260 = llvm.mlir.constant(2 : i32) : i32
      %261 = llvm.shl %259, %260 : i32
      %262 = rocdl.ds_bpermute %261, %248 : (i32, i32) -> i32
      cf.cond_br %258, ^bb46, ^bb48(%248 : i32)
    ^bb46:  // pred: ^bb45
      cf.br ^bb47
    ^bb47:  // pred: ^bb46
      %263 = llvm.xor %248, %262 : i32
      cf.br ^bb48(%263 : i32)
    ^bb48(%264: i32):  // 2 preds: ^bb45, ^bb47
      cf.br ^bb49
    ^bb49:  // pred: ^bb48
      %265 = llvm.mlir.constant(0 : i32) : i32
      %266 = llvm.mlir.constant(-1 : i32) : i32
      %267 = rocdl.mbcnt.lo %266, %265 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %268 = rocdl.mbcnt.hi %266, %267 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %269 = llvm.mlir.constant(0 : i32) : i32
      %270 = llvm.sub %269, %211 : i32
      %271 = llvm.add %268, %211 : i32
      %272 = llvm.and %271, %270 : i32
      %273 = llvm.xor %268, %15 : i32
      %274 = llvm.icmp "slt" %273, %272 : i32
      %275 = llvm.select %274, %273, %268 : i1, i32
      %276 = llvm.mlir.constant(2 : i32) : i32
      %277 = llvm.shl %275, %276 : i32
      %278 = rocdl.ds_bpermute %277, %264 : (i32, i32) -> i32
      cf.cond_br %274, ^bb50, ^bb52(%264 : i32)
    ^bb50:  // pred: ^bb49
      cf.br ^bb51
    ^bb51:  // pred: ^bb50
      %279 = llvm.xor %264, %278 : i32
      cf.br ^bb52(%279 : i32)
    ^bb52(%280: i32):  // 2 preds: ^bb49, ^bb51
      cf.br ^bb53
    ^bb53:  // pred: ^bb52
      %281 = llvm.mlir.constant(0 : i32) : i32
      %282 = llvm.mlir.constant(-1 : i32) : i32
      %283 = rocdl.mbcnt.lo %282, %281 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %284 = rocdl.mbcnt.hi %282, %283 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %285 = llvm.mlir.constant(0 : i32) : i32
      %286 = llvm.sub %285, %211 : i32
      %287 = llvm.add %284, %211 : i32
      %288 = llvm.and %287, %286 : i32
      %289 = llvm.xor %284, %14 : i32
      %290 = llvm.icmp "slt" %289, %288 : i32
      %291 = llvm.select %290, %289, %284 : i1, i32
      %292 = llvm.mlir.constant(2 : i32) : i32
      %293 = llvm.shl %291, %292 : i32
      %294 = rocdl.ds_bpermute %293, %280 : (i32, i32) -> i32
      cf.cond_br %290, ^bb54, ^bb56(%280 : i32)
    ^bb54:  // pred: ^bb53
      cf.br ^bb55
    ^bb55:  // pred: ^bb54
      %295 = llvm.xor %280, %294 : i32
      cf.br ^bb56(%295 : i32)
    ^bb56(%296: i32):  // 2 preds: ^bb53, ^bb55
      cf.br ^bb57(%296 : i32)
    ^bb57(%297: i32):  // 2 preds: ^bb56, ^bb67
      cf.br ^bb68
    ^bb58:  // pred: ^bb36
      %298 = llvm.mlir.constant(0 : i32) : i32
      %299 = llvm.mlir.constant(-1 : i32) : i32
      %300 = rocdl.mbcnt.lo %299, %298 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %301 = rocdl.mbcnt.hi %299, %300 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %302 = llvm.mlir.constant(0 : i32) : i32
      %303 = llvm.sub %302, %18 : i32
      %304 = llvm.add %301, %18 : i32
      %305 = llvm.and %304, %303 : i32
      %306 = llvm.xor %301, %21 : i32
      %307 = llvm.icmp "slt" %306, %305 : i32
      %308 = llvm.select %307, %306, %301 : i1, i32
      %309 = llvm.mlir.constant(2 : i32) : i32
      %310 = llvm.shl %308, %309 : i32
      %311 = rocdl.ds_bpermute %310, %215 : (i32, i32) -> i32
      cf.br ^bb59
    ^bb59:  // pred: ^bb58
      %312 = llvm.xor %215, %311 : i32
      cf.br ^bb60
    ^bb60:  // pred: ^bb59
      %313 = llvm.mlir.constant(0 : i32) : i32
      %314 = llvm.mlir.constant(-1 : i32) : i32
      %315 = rocdl.mbcnt.lo %314, %313 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %316 = rocdl.mbcnt.hi %314, %315 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %317 = llvm.mlir.constant(0 : i32) : i32
      %318 = llvm.sub %317, %18 : i32
      %319 = llvm.add %316, %18 : i32
      %320 = llvm.and %319, %318 : i32
      %321 = llvm.xor %316, %17 : i32
      %322 = llvm.icmp "slt" %321, %320 : i32
      %323 = llvm.select %322, %321, %316 : i1, i32
      %324 = llvm.mlir.constant(2 : i32) : i32
      %325 = llvm.shl %323, %324 : i32
      %326 = rocdl.ds_bpermute %325, %312 : (i32, i32) -> i32
      cf.br ^bb61
    ^bb61:  // pred: ^bb60
      %327 = llvm.xor %312, %326 : i32
      cf.br ^bb62
    ^bb62:  // pred: ^bb61
      %328 = llvm.mlir.constant(0 : i32) : i32
      %329 = llvm.mlir.constant(-1 : i32) : i32
      %330 = rocdl.mbcnt.lo %329, %328 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %331 = rocdl.mbcnt.hi %329, %330 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %332 = llvm.mlir.constant(0 : i32) : i32
      %333 = llvm.sub %332, %18 : i32
      %334 = llvm.add %331, %18 : i32
      %335 = llvm.and %334, %333 : i32
      %336 = llvm.xor %331, %16 : i32
      %337 = llvm.icmp "slt" %336, %335 : i32
      %338 = llvm.select %337, %336, %331 : i1, i32
      %339 = llvm.mlir.constant(2 : i32) : i32
      %340 = llvm.shl %338, %339 : i32
      %341 = rocdl.ds_bpermute %340, %327 : (i32, i32) -> i32
      cf.br ^bb63
    ^bb63:  // pred: ^bb62
      %342 = llvm.xor %327, %341 : i32
      cf.br ^bb64
    ^bb64:  // pred: ^bb63
      %343 = llvm.mlir.constant(0 : i32) : i32
      %344 = llvm.mlir.constant(-1 : i32) : i32
      %345 = rocdl.mbcnt.lo %344, %343 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %346 = rocdl.mbcnt.hi %344, %345 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %347 = llvm.mlir.constant(0 : i32) : i32
      %348 = llvm.sub %347, %18 : i32
      %349 = llvm.add %346, %18 : i32
      %350 = llvm.and %349, %348 : i32
      %351 = llvm.xor %346, %15 : i32
      %352 = llvm.icmp "slt" %351, %350 : i32
      %353 = llvm.select %352, %351, %346 : i1, i32
      %354 = llvm.mlir.constant(2 : i32) : i32
      %355 = llvm.shl %353, %354 : i32
      %356 = rocdl.ds_bpermute %355, %342 : (i32, i32) -> i32
      cf.br ^bb65
    ^bb65:  // pred: ^bb64
      %357 = llvm.xor %342, %356 : i32
      cf.br ^bb66
    ^bb66:  // pred: ^bb65
      %358 = llvm.mlir.constant(0 : i32) : i32
      %359 = llvm.mlir.constant(-1 : i32) : i32
      %360 = rocdl.mbcnt.lo %359, %358 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %361 = rocdl.mbcnt.hi %359, %360 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %362 = llvm.mlir.constant(0 : i32) : i32
      %363 = llvm.sub %362, %18 : i32
      %364 = llvm.add %361, %18 : i32
      %365 = llvm.and %364, %363 : i32
      %366 = llvm.xor %361, %14 : i32
      %367 = llvm.icmp "slt" %366, %365 : i32
      %368 = llvm.select %367, %366, %361 : i1, i32
      %369 = llvm.mlir.constant(2 : i32) : i32
      %370 = llvm.shl %368, %369 : i32
      %371 = rocdl.ds_bpermute %370, %357 : (i32, i32) -> i32
      cf.br ^bb67
    ^bb67:  // pred: ^bb66
      %372 = llvm.xor %357, %371 : i32
      cf.br ^bb57(%372 : i32)
    ^bb68:  // pred: ^bb57
      memref.store %297, %11[%13] : memref<32xi32, #gpu.address_space<workgroup>>
      cf.br ^bb70
    ^bb69:  // pred: ^bb35
      cf.br ^bb70
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

