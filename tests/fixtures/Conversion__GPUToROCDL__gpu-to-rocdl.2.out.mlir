module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @gpu_index_ops() -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> attributes {llvm.emit_c_interface} {
      %0 = rocdl.workitem.id.x : i32
      %1 = rocdl.workitem.id.y : i32
      %2 = rocdl.workitem.id.z : i32
      %3 = rocdl.workgroup.dim.x : i32
      %4 = rocdl.workgroup.dim.y : i32
      %5 = rocdl.workgroup.dim.z : i32
      %6 = rocdl.workgroup.id.x : i32
      %7 = rocdl.workgroup.id.y : i32
      %8 = rocdl.workgroup.id.z : i32
      %9 = rocdl.grid.dim.x : i32
      %10 = rocdl.grid.dim.y : i32
      %11 = rocdl.grid.dim.z : i32
      %12 = llvm.mlir.constant(0 : i32) : i32
      %13 = llvm.mlir.constant(-1 : i32) : i32
      %14 = rocdl.mbcnt.lo %13, %12 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %15 = rocdl.mbcnt.hi %13, %14 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %16 = rocdl.wavefrontsize : i32
      %17 = rocdl.wavefrontsize range <i32, 64, 65> : i32
      %18 = llvm.mlir.poison : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %19 = llvm.insertvalue %0, %18[0] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %20 = llvm.insertvalue %1, %19[1] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %21 = llvm.insertvalue %2, %20[2] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %22 = llvm.insertvalue %3, %21[3] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %23 = llvm.insertvalue %4, %22[4] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %24 = llvm.insertvalue %5, %23[5] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %25 = llvm.insertvalue %6, %24[6] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %26 = llvm.insertvalue %7, %25[7] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %27 = llvm.insertvalue %8, %26[8] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %28 = llvm.insertvalue %9, %27[9] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %29 = llvm.insertvalue %10, %28[10] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %30 = llvm.insertvalue %11, %29[11] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %31 = llvm.insertvalue %15, %30[12] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %32 = llvm.insertvalue %16, %31[13] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %33 = llvm.insertvalue %17, %32[14] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      llvm.return %33 : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
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
      %10 = llvm.add %4, %5 : i32
      %11 = llvm.add %10, %6 : i32
      %12 = llvm.add %11, %7 : i32
      %13 = llvm.add %12, %8 : i32
      %14 = llvm.add %13, %9 : i32
      %15 = llvm.extractvalue %3[1] : !llvm.struct<(ptr, ptr, i32)> 
      llvm.store %14, %15 : i32, !llvm.ptr
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
module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
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
      %21 = rocdl.workgroup.dim.x : i32
      %22 = rocdl.workgroup.dim.y : i32
      %23 = rocdl.workgroup.dim.z : i32
      %24 = rocdl.workitem.id.x : i32
      %25 = rocdl.workitem.id.y : i32
      %26 = rocdl.workitem.id.z : i32
      %27 = llvm.mul %26, %22 : i32
      %28 = llvm.add %27, %25 : i32
      %29 = llvm.mul %28, %21 : i32
      %30 = llvm.mul %21, %22 : i32
      %31 = llvm.add %29, %24 : i32
      %32 = llvm.mul %30, %23 : i32
      %33 = llvm.and %31, %19 : i32
      %34 = llvm.icmp "eq" %33, %18 : i32
      %35 = llvm.sub %31, %33 : i32
      %36 = llvm.sub %32, %35 : i32
      %37 = llvm.icmp "slt" %36, %17 : i32
      llvm.cond_br %37, ^bb1, ^bb17
    ^bb1:  // pred: ^bb0
      %38 = llvm.mlir.constant(0 : i32) : i32
      %39 = llvm.mlir.constant(-1 : i32) : i32
      %40 = rocdl.mbcnt.lo %39, %38 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %41 = rocdl.mbcnt.hi %39, %40 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %42 = llvm.mlir.constant(0 : i32) : i32
      %43 = llvm.sub %42, %36 : i32
      %44 = llvm.add %41, %36 : i32
      %45 = llvm.and %44, %43 : i32
      %46 = llvm.xor %41, %16 : i32
      %47 = llvm.icmp "slt" %46, %45 : i32
      %48 = llvm.select %47, %46, %41 : i1, i32
      %49 = llvm.mlir.constant(2 : i32) : i32
      %50 = llvm.shl %48, %49 : i32
      %51 = llvm.bitcast %20 : f32 to i32
      %52 = rocdl.ds_bpermute %50, %51 : (i32, i32) -> i32
      %53 = llvm.bitcast %52 : i32 to f32
      llvm.cond_br %47, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %54 = llvm.fadd %53, %20 : f32
      llvm.br ^bb4(%54 : f32)
    ^bb3:  // pred: ^bb1
      llvm.br ^bb4(%20 : f32)
    ^bb4(%55: f32):  // 2 preds: ^bb2, ^bb3
      %56 = llvm.mlir.constant(0 : i32) : i32
      %57 = llvm.mlir.constant(-1 : i32) : i32
      %58 = rocdl.mbcnt.lo %57, %56 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %59 = rocdl.mbcnt.hi %57, %58 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %60 = llvm.mlir.constant(0 : i32) : i32
      %61 = llvm.sub %60, %36 : i32
      %62 = llvm.add %59, %36 : i32
      %63 = llvm.and %62, %61 : i32
      %64 = llvm.xor %59, %15 : i32
      %65 = llvm.icmp "slt" %64, %63 : i32
      %66 = llvm.select %65, %64, %59 : i1, i32
      %67 = llvm.mlir.constant(2 : i32) : i32
      %68 = llvm.shl %66, %67 : i32
      %69 = llvm.bitcast %55 : f32 to i32
      %70 = rocdl.ds_bpermute %68, %69 : (i32, i32) -> i32
      %71 = llvm.bitcast %70 : i32 to f32
      llvm.cond_br %65, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      %72 = llvm.fadd %55, %71 : f32
      llvm.br ^bb7(%72 : f32)
    ^bb6:  // pred: ^bb4
      llvm.br ^bb7(%55 : f32)
    ^bb7(%73: f32):  // 2 preds: ^bb5, ^bb6
      %74 = llvm.mlir.constant(0 : i32) : i32
      %75 = llvm.mlir.constant(-1 : i32) : i32
      %76 = rocdl.mbcnt.lo %75, %74 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %77 = rocdl.mbcnt.hi %75, %76 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %78 = llvm.mlir.constant(0 : i32) : i32
      %79 = llvm.sub %78, %36 : i32
      %80 = llvm.add %77, %36 : i32
      %81 = llvm.and %80, %79 : i32
      %82 = llvm.xor %77, %14 : i32
      %83 = llvm.icmp "slt" %82, %81 : i32
      %84 = llvm.select %83, %82, %77 : i1, i32
      %85 = llvm.mlir.constant(2 : i32) : i32
      %86 = llvm.shl %84, %85 : i32
      %87 = llvm.bitcast %73 : f32 to i32
      %88 = rocdl.ds_bpermute %86, %87 : (i32, i32) -> i32
      %89 = llvm.bitcast %88 : i32 to f32
      llvm.cond_br %83, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %90 = llvm.fadd %73, %89 : f32
      llvm.br ^bb10(%90 : f32)
    ^bb9:  // pred: ^bb7
      llvm.br ^bb10(%73 : f32)
    ^bb10(%91: f32):  // 2 preds: ^bb8, ^bb9
      %92 = llvm.mlir.constant(0 : i32) : i32
      %93 = llvm.mlir.constant(-1 : i32) : i32
      %94 = rocdl.mbcnt.lo %93, %92 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %95 = rocdl.mbcnt.hi %93, %94 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %96 = llvm.mlir.constant(0 : i32) : i32
      %97 = llvm.sub %96, %36 : i32
      %98 = llvm.add %95, %36 : i32
      %99 = llvm.and %98, %97 : i32
      %100 = llvm.xor %95, %13 : i32
      %101 = llvm.icmp "slt" %100, %99 : i32
      %102 = llvm.select %101, %100, %95 : i1, i32
      %103 = llvm.mlir.constant(2 : i32) : i32
      %104 = llvm.shl %102, %103 : i32
      %105 = llvm.bitcast %91 : f32 to i32
      %106 = rocdl.ds_bpermute %104, %105 : (i32, i32) -> i32
      %107 = llvm.bitcast %106 : i32 to f32
      llvm.cond_br %101, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      %108 = llvm.fadd %91, %107 : f32
      llvm.br ^bb13(%108 : f32)
    ^bb12:  // pred: ^bb10
      llvm.br ^bb13(%91 : f32)
    ^bb13(%109: f32):  // 2 preds: ^bb11, ^bb12
      %110 = llvm.mlir.constant(0 : i32) : i32
      %111 = llvm.mlir.constant(-1 : i32) : i32
      %112 = rocdl.mbcnt.lo %111, %110 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %113 = rocdl.mbcnt.hi %111, %112 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %114 = llvm.mlir.constant(0 : i32) : i32
      %115 = llvm.sub %114, %36 : i32
      %116 = llvm.add %113, %36 : i32
      %117 = llvm.and %116, %115 : i32
      %118 = llvm.xor %113, %12 : i32
      %119 = llvm.icmp "slt" %118, %117 : i32
      %120 = llvm.select %119, %118, %113 : i1, i32
      %121 = llvm.mlir.constant(2 : i32) : i32
      %122 = llvm.shl %120, %121 : i32
      %123 = llvm.bitcast %109 : f32 to i32
      %124 = rocdl.ds_bpermute %122, %123 : (i32, i32) -> i32
      %125 = llvm.bitcast %124 : i32 to f32
      llvm.cond_br %119, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %126 = llvm.fadd %109, %125 : f32
      llvm.br ^bb16(%126 : f32)
    ^bb15:  // pred: ^bb13
      llvm.br ^bb16(%109 : f32)
    ^bb16(%127: f32):  // 2 preds: ^bb14, ^bb15
      llvm.br ^bb18(%127 : f32)
    ^bb17:  // pred: ^bb0
      %128 = llvm.mlir.constant(0 : i32) : i32
      %129 = llvm.mlir.constant(-1 : i32) : i32
      %130 = rocdl.mbcnt.lo %129, %128 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %131 = rocdl.mbcnt.hi %129, %130 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %132 = llvm.mlir.constant(0 : i32) : i32
      %133 = llvm.sub %132, %17 : i32
      %134 = llvm.add %131, %17 : i32
      %135 = llvm.and %134, %133 : i32
      %136 = llvm.xor %131, %16 : i32
      %137 = llvm.icmp "slt" %136, %135 : i32
      %138 = llvm.select %137, %136, %131 : i1, i32
      %139 = llvm.mlir.constant(2 : i32) : i32
      %140 = llvm.shl %138, %139 : i32
      %141 = llvm.bitcast %20 : f32 to i32
      %142 = rocdl.ds_bpermute %140, %141 : (i32, i32) -> i32
      %143 = llvm.bitcast %142 : i32 to f32
      %144 = llvm.fadd %143, %20 : f32
      %145 = llvm.mlir.constant(0 : i32) : i32
      %146 = llvm.mlir.constant(-1 : i32) : i32
      %147 = rocdl.mbcnt.lo %146, %145 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %148 = rocdl.mbcnt.hi %146, %147 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %149 = llvm.mlir.constant(0 : i32) : i32
      %150 = llvm.sub %149, %17 : i32
      %151 = llvm.add %148, %17 : i32
      %152 = llvm.and %151, %150 : i32
      %153 = llvm.xor %148, %15 : i32
      %154 = llvm.icmp "slt" %153, %152 : i32
      %155 = llvm.select %154, %153, %148 : i1, i32
      %156 = llvm.mlir.constant(2 : i32) : i32
      %157 = llvm.shl %155, %156 : i32
      %158 = llvm.bitcast %144 : f32 to i32
      %159 = rocdl.ds_bpermute %157, %158 : (i32, i32) -> i32
      %160 = llvm.bitcast %159 : i32 to f32
      %161 = llvm.fadd %144, %160 : f32
      %162 = llvm.mlir.constant(0 : i32) : i32
      %163 = llvm.mlir.constant(-1 : i32) : i32
      %164 = rocdl.mbcnt.lo %163, %162 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %165 = rocdl.mbcnt.hi %163, %164 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %166 = llvm.mlir.constant(0 : i32) : i32
      %167 = llvm.sub %166, %17 : i32
      %168 = llvm.add %165, %17 : i32
      %169 = llvm.and %168, %167 : i32
      %170 = llvm.xor %165, %14 : i32
      %171 = llvm.icmp "slt" %170, %169 : i32
      %172 = llvm.select %171, %170, %165 : i1, i32
      %173 = llvm.mlir.constant(2 : i32) : i32
      %174 = llvm.shl %172, %173 : i32
      %175 = llvm.bitcast %161 : f32 to i32
      %176 = rocdl.ds_bpermute %174, %175 : (i32, i32) -> i32
      %177 = llvm.bitcast %176 : i32 to f32
      %178 = llvm.fadd %161, %177 : f32
      %179 = llvm.mlir.constant(0 : i32) : i32
      %180 = llvm.mlir.constant(-1 : i32) : i32
      %181 = rocdl.mbcnt.lo %180, %179 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %182 = rocdl.mbcnt.hi %180, %181 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %183 = llvm.mlir.constant(0 : i32) : i32
      %184 = llvm.sub %183, %17 : i32
      %185 = llvm.add %182, %17 : i32
      %186 = llvm.and %185, %184 : i32
      %187 = llvm.xor %182, %13 : i32
      %188 = llvm.icmp "slt" %187, %186 : i32
      %189 = llvm.select %188, %187, %182 : i1, i32
      %190 = llvm.mlir.constant(2 : i32) : i32
      %191 = llvm.shl %189, %190 : i32
      %192 = llvm.bitcast %178 : f32 to i32
      %193 = rocdl.ds_bpermute %191, %192 : (i32, i32) -> i32
      %194 = llvm.bitcast %193 : i32 to f32
      %195 = llvm.fadd %178, %194 : f32
      %196 = llvm.mlir.constant(0 : i32) : i32
      %197 = llvm.mlir.constant(-1 : i32) : i32
      %198 = rocdl.mbcnt.lo %197, %196 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %199 = rocdl.mbcnt.hi %197, %198 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %200 = llvm.mlir.constant(0 : i32) : i32
      %201 = llvm.sub %200, %17 : i32
      %202 = llvm.add %199, %17 : i32
      %203 = llvm.and %202, %201 : i32
      %204 = llvm.xor %199, %12 : i32
      %205 = llvm.icmp "slt" %204, %203 : i32
      %206 = llvm.select %205, %204, %199 : i1, i32
      %207 = llvm.mlir.constant(2 : i32) : i32
      %208 = llvm.shl %206, %207 : i32
      %209 = llvm.bitcast %195 : f32 to i32
      %210 = rocdl.ds_bpermute %208, %209 : (i32, i32) -> i32
      %211 = llvm.bitcast %210 : i32 to f32
      %212 = llvm.fadd %195, %211 : f32
      llvm.br ^bb18(%212 : f32)
    ^bb18(%213: f32):  // 2 preds: ^bb16, ^bb17
      llvm.cond_br %34, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      %214 = llvm.sdiv %31, %17 : i32
      %215 = llvm.extractvalue %10[1] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %216 = llvm.getelementptr inbounds|nuw %215[%214] : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>, f32
      llvm.store %213, %216 : f32, !llvm.ptr<3>
      llvm.br ^bb21
    ^bb20:  // pred: ^bb18
      llvm.br ^bb21
    ^bb21:  // 2 preds: ^bb19, ^bb20
      rocdl.barrier
      %217 = llvm.add %32, %19 : i32
      %218 = llvm.sdiv %217, %17 : i32
      %219 = llvm.icmp "slt" %31, %218 : i32
      llvm.cond_br %219, ^bb22, ^bb41
    ^bb22:  // pred: ^bb21
      %220 = llvm.extractvalue %10[1] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %221 = llvm.getelementptr inbounds|nuw %220[%31] : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>, f32
      %222 = llvm.load %221 : !llvm.ptr<3> -> f32
      %223 = llvm.icmp "slt" %218, %17 : i32
      llvm.cond_br %223, ^bb23, ^bb39
    ^bb23:  // pred: ^bb22
      %224 = llvm.mlir.constant(0 : i32) : i32
      %225 = llvm.mlir.constant(-1 : i32) : i32
      %226 = rocdl.mbcnt.lo %225, %224 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %227 = rocdl.mbcnt.hi %225, %226 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %228 = llvm.mlir.constant(0 : i32) : i32
      %229 = llvm.sub %228, %218 : i32
      %230 = llvm.add %227, %218 : i32
      %231 = llvm.and %230, %229 : i32
      %232 = llvm.xor %227, %16 : i32
      %233 = llvm.icmp "slt" %232, %231 : i32
      %234 = llvm.select %233, %232, %227 : i1, i32
      %235 = llvm.mlir.constant(2 : i32) : i32
      %236 = llvm.shl %234, %235 : i32
      %237 = llvm.bitcast %222 : f32 to i32
      %238 = rocdl.ds_bpermute %236, %237 : (i32, i32) -> i32
      %239 = llvm.bitcast %238 : i32 to f32
      llvm.cond_br %233, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      %240 = llvm.fadd %222, %239 : f32
      llvm.br ^bb26(%240 : f32)
    ^bb25:  // pred: ^bb23
      llvm.br ^bb26(%222 : f32)
    ^bb26(%241: f32):  // 2 preds: ^bb24, ^bb25
      %242 = llvm.mlir.constant(0 : i32) : i32
      %243 = llvm.mlir.constant(-1 : i32) : i32
      %244 = rocdl.mbcnt.lo %243, %242 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %245 = rocdl.mbcnt.hi %243, %244 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %246 = llvm.mlir.constant(0 : i32) : i32
      %247 = llvm.sub %246, %218 : i32
      %248 = llvm.add %245, %218 : i32
      %249 = llvm.and %248, %247 : i32
      %250 = llvm.xor %245, %15 : i32
      %251 = llvm.icmp "slt" %250, %249 : i32
      %252 = llvm.select %251, %250, %245 : i1, i32
      %253 = llvm.mlir.constant(2 : i32) : i32
      %254 = llvm.shl %252, %253 : i32
      %255 = llvm.bitcast %241 : f32 to i32
      %256 = rocdl.ds_bpermute %254, %255 : (i32, i32) -> i32
      %257 = llvm.bitcast %256 : i32 to f32
      llvm.cond_br %251, ^bb27, ^bb28
    ^bb27:  // pred: ^bb26
      %258 = llvm.fadd %241, %257 : f32
      llvm.br ^bb29(%258 : f32)
    ^bb28:  // pred: ^bb26
      llvm.br ^bb29(%241 : f32)
    ^bb29(%259: f32):  // 2 preds: ^bb27, ^bb28
      %260 = llvm.mlir.constant(0 : i32) : i32
      %261 = llvm.mlir.constant(-1 : i32) : i32
      %262 = rocdl.mbcnt.lo %261, %260 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %263 = rocdl.mbcnt.hi %261, %262 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %264 = llvm.mlir.constant(0 : i32) : i32
      %265 = llvm.sub %264, %218 : i32
      %266 = llvm.add %263, %218 : i32
      %267 = llvm.and %266, %265 : i32
      %268 = llvm.xor %263, %14 : i32
      %269 = llvm.icmp "slt" %268, %267 : i32
      %270 = llvm.select %269, %268, %263 : i1, i32
      %271 = llvm.mlir.constant(2 : i32) : i32
      %272 = llvm.shl %270, %271 : i32
      %273 = llvm.bitcast %259 : f32 to i32
      %274 = rocdl.ds_bpermute %272, %273 : (i32, i32) -> i32
      %275 = llvm.bitcast %274 : i32 to f32
      llvm.cond_br %269, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      %276 = llvm.fadd %259, %275 : f32
      llvm.br ^bb32(%276 : f32)
    ^bb31:  // pred: ^bb29
      llvm.br ^bb32(%259 : f32)
    ^bb32(%277: f32):  // 2 preds: ^bb30, ^bb31
      %278 = llvm.mlir.constant(0 : i32) : i32
      %279 = llvm.mlir.constant(-1 : i32) : i32
      %280 = rocdl.mbcnt.lo %279, %278 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %281 = rocdl.mbcnt.hi %279, %280 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %282 = llvm.mlir.constant(0 : i32) : i32
      %283 = llvm.sub %282, %218 : i32
      %284 = llvm.add %281, %218 : i32
      %285 = llvm.and %284, %283 : i32
      %286 = llvm.xor %281, %13 : i32
      %287 = llvm.icmp "slt" %286, %285 : i32
      %288 = llvm.select %287, %286, %281 : i1, i32
      %289 = llvm.mlir.constant(2 : i32) : i32
      %290 = llvm.shl %288, %289 : i32
      %291 = llvm.bitcast %277 : f32 to i32
      %292 = rocdl.ds_bpermute %290, %291 : (i32, i32) -> i32
      %293 = llvm.bitcast %292 : i32 to f32
      llvm.cond_br %287, ^bb33, ^bb34
    ^bb33:  // pred: ^bb32
      %294 = llvm.fadd %277, %293 : f32
      llvm.br ^bb35(%294 : f32)
    ^bb34:  // pred: ^bb32
      llvm.br ^bb35(%277 : f32)
    ^bb35(%295: f32):  // 2 preds: ^bb33, ^bb34
      %296 = llvm.mlir.constant(0 : i32) : i32
      %297 = llvm.mlir.constant(-1 : i32) : i32
      %298 = rocdl.mbcnt.lo %297, %296 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %299 = rocdl.mbcnt.hi %297, %298 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %300 = llvm.mlir.constant(0 : i32) : i32
      %301 = llvm.sub %300, %218 : i32
      %302 = llvm.add %299, %218 : i32
      %303 = llvm.and %302, %301 : i32
      %304 = llvm.xor %299, %12 : i32
      %305 = llvm.icmp "slt" %304, %303 : i32
      %306 = llvm.select %305, %304, %299 : i1, i32
      %307 = llvm.mlir.constant(2 : i32) : i32
      %308 = llvm.shl %306, %307 : i32
      %309 = llvm.bitcast %295 : f32 to i32
      %310 = rocdl.ds_bpermute %308, %309 : (i32, i32) -> i32
      %311 = llvm.bitcast %310 : i32 to f32
      llvm.cond_br %305, ^bb36, ^bb37
    ^bb36:  // pred: ^bb35
      %312 = llvm.fadd %295, %311 : f32
      llvm.br ^bb38(%312 : f32)
    ^bb37:  // pred: ^bb35
      llvm.br ^bb38(%295 : f32)
    ^bb38(%313: f32):  // 2 preds: ^bb36, ^bb37
      llvm.br ^bb40(%313 : f32)
    ^bb39:  // pred: ^bb22
      %314 = llvm.mlir.constant(0 : i32) : i32
      %315 = llvm.mlir.constant(-1 : i32) : i32
      %316 = rocdl.mbcnt.lo %315, %314 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %317 = rocdl.mbcnt.hi %315, %316 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %318 = llvm.mlir.constant(0 : i32) : i32
      %319 = llvm.sub %318, %17 : i32
      %320 = llvm.add %317, %17 : i32
      %321 = llvm.and %320, %319 : i32
      %322 = llvm.xor %317, %16 : i32
      %323 = llvm.icmp "slt" %322, %321 : i32
      %324 = llvm.select %323, %322, %317 : i1, i32
      %325 = llvm.mlir.constant(2 : i32) : i32
      %326 = llvm.shl %324, %325 : i32
      %327 = llvm.bitcast %222 : f32 to i32
      %328 = rocdl.ds_bpermute %326, %327 : (i32, i32) -> i32
      %329 = llvm.bitcast %328 : i32 to f32
      %330 = llvm.fadd %222, %329 : f32
      %331 = llvm.mlir.constant(0 : i32) : i32
      %332 = llvm.mlir.constant(-1 : i32) : i32
      %333 = rocdl.mbcnt.lo %332, %331 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %334 = rocdl.mbcnt.hi %332, %333 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %335 = llvm.mlir.constant(0 : i32) : i32
      %336 = llvm.sub %335, %17 : i32
      %337 = llvm.add %334, %17 : i32
      %338 = llvm.and %337, %336 : i32
      %339 = llvm.xor %334, %15 : i32
      %340 = llvm.icmp "slt" %339, %338 : i32
      %341 = llvm.select %340, %339, %334 : i1, i32
      %342 = llvm.mlir.constant(2 : i32) : i32
      %343 = llvm.shl %341, %342 : i32
      %344 = llvm.bitcast %330 : f32 to i32
      %345 = rocdl.ds_bpermute %343, %344 : (i32, i32) -> i32
      %346 = llvm.bitcast %345 : i32 to f32
      %347 = llvm.fadd %330, %346 : f32
      %348 = llvm.mlir.constant(0 : i32) : i32
      %349 = llvm.mlir.constant(-1 : i32) : i32
      %350 = rocdl.mbcnt.lo %349, %348 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %351 = rocdl.mbcnt.hi %349, %350 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %352 = llvm.mlir.constant(0 : i32) : i32
      %353 = llvm.sub %352, %17 : i32
      %354 = llvm.add %351, %17 : i32
      %355 = llvm.and %354, %353 : i32
      %356 = llvm.xor %351, %14 : i32
      %357 = llvm.icmp "slt" %356, %355 : i32
      %358 = llvm.select %357, %356, %351 : i1, i32
      %359 = llvm.mlir.constant(2 : i32) : i32
      %360 = llvm.shl %358, %359 : i32
      %361 = llvm.bitcast %347 : f32 to i32
      %362 = rocdl.ds_bpermute %360, %361 : (i32, i32) -> i32
      %363 = llvm.bitcast %362 : i32 to f32
      %364 = llvm.fadd %347, %363 : f32
      %365 = llvm.mlir.constant(0 : i32) : i32
      %366 = llvm.mlir.constant(-1 : i32) : i32
      %367 = rocdl.mbcnt.lo %366, %365 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %368 = rocdl.mbcnt.hi %366, %367 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %369 = llvm.mlir.constant(0 : i32) : i32
      %370 = llvm.sub %369, %17 : i32
      %371 = llvm.add %368, %17 : i32
      %372 = llvm.and %371, %370 : i32
      %373 = llvm.xor %368, %13 : i32
      %374 = llvm.icmp "slt" %373, %372 : i32
      %375 = llvm.select %374, %373, %368 : i1, i32
      %376 = llvm.mlir.constant(2 : i32) : i32
      %377 = llvm.shl %375, %376 : i32
      %378 = llvm.bitcast %364 : f32 to i32
      %379 = rocdl.ds_bpermute %377, %378 : (i32, i32) -> i32
      %380 = llvm.bitcast %379 : i32 to f32
      %381 = llvm.fadd %364, %380 : f32
      %382 = llvm.mlir.constant(0 : i32) : i32
      %383 = llvm.mlir.constant(-1 : i32) : i32
      %384 = rocdl.mbcnt.lo %383, %382 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %385 = rocdl.mbcnt.hi %383, %384 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %386 = llvm.mlir.constant(0 : i32) : i32
      %387 = llvm.sub %386, %17 : i32
      %388 = llvm.add %385, %17 : i32
      %389 = llvm.and %388, %387 : i32
      %390 = llvm.xor %385, %12 : i32
      %391 = llvm.icmp "slt" %390, %389 : i32
      %392 = llvm.select %391, %390, %385 : i1, i32
      %393 = llvm.mlir.constant(2 : i32) : i32
      %394 = llvm.shl %392, %393 : i32
      %395 = llvm.bitcast %381 : f32 to i32
      %396 = rocdl.ds_bpermute %394, %395 : (i32, i32) -> i32
      %397 = llvm.bitcast %396 : i32 to f32
      %398 = llvm.fadd %381, %397 : f32
      llvm.br ^bb40(%398 : f32)
    ^bb40(%399: f32):  // 2 preds: ^bb38, ^bb39
      %400 = llvm.extractvalue %10[1] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %401 = llvm.getelementptr inbounds|nuw %400[%11] : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>, f32
      llvm.store %399, %401 : f32, !llvm.ptr<3>
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
      %20 = rocdl.workgroup.dim.x : i32
      %21 = rocdl.workgroup.dim.y : i32
      %22 = rocdl.workgroup.dim.z : i32
      %23 = rocdl.workitem.id.x : i32
      %24 = rocdl.workitem.id.y : i32
      %25 = rocdl.workitem.id.z : i32
      %26 = llvm.mul %25, %21 : i32
      %27 = llvm.add %26, %24 : i32
      %28 = llvm.mul %27, %20 : i32
      %29 = llvm.mul %20, %21 : i32
      %30 = llvm.add %28, %23 : i32
      %31 = llvm.mul %29, %22 : i32
      %32 = llvm.and %30, %18 : i32
      %33 = llvm.icmp "eq" %32, %17 : i32
      %34 = llvm.sub %30, %32 : i32
      %35 = llvm.sub %31, %34 : i32
      %36 = llvm.icmp "slt" %35, %16 : i32
      llvm.cond_br %36, ^bb1, ^bb22
    ^bb1:  // pred: ^bb0
      %37 = llvm.mlir.constant(0 : i32) : i32
      %38 = llvm.mlir.constant(-1 : i32) : i32
      %39 = rocdl.mbcnt.lo %38, %37 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %40 = rocdl.mbcnt.hi %38, %39 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %41 = llvm.mlir.constant(0 : i32) : i32
      %42 = llvm.sub %41, %35 : i32
      %43 = llvm.add %40, %35 : i32
      %44 = llvm.and %43, %42 : i32
      %45 = llvm.xor %40, %19 : i32
      %46 = llvm.icmp "slt" %45, %44 : i32
      %47 = llvm.select %46, %45, %40 : i1, i32
      %48 = llvm.mlir.constant(2 : i32) : i32
      %49 = llvm.shl %47, %48 : i32
      %50 = rocdl.ds_bpermute %49, %19 : (i32, i32) -> i32
      llvm.cond_br %46, ^bb2, ^bb4(%19 : i32)
    ^bb2:  // pred: ^bb1
      llvm.br ^bb3
    ^bb3:  // pred: ^bb2
      %51 = llvm.xor %50, %19 : i32
      llvm.br ^bb4(%51 : i32)
    ^bb4(%52: i32):  // 2 preds: ^bb1, ^bb3
      llvm.br ^bb5
    ^bb5:  // pred: ^bb4
      %53 = llvm.mlir.constant(0 : i32) : i32
      %54 = llvm.mlir.constant(-1 : i32) : i32
      %55 = rocdl.mbcnt.lo %54, %53 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %56 = rocdl.mbcnt.hi %54, %55 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %57 = llvm.mlir.constant(0 : i32) : i32
      %58 = llvm.sub %57, %35 : i32
      %59 = llvm.add %56, %35 : i32
      %60 = llvm.and %59, %58 : i32
      %61 = llvm.xor %56, %15 : i32
      %62 = llvm.icmp "slt" %61, %60 : i32
      %63 = llvm.select %62, %61, %56 : i1, i32
      %64 = llvm.mlir.constant(2 : i32) : i32
      %65 = llvm.shl %63, %64 : i32
      %66 = rocdl.ds_bpermute %65, %52 : (i32, i32) -> i32
      llvm.cond_br %62, ^bb6, ^bb8(%52 : i32)
    ^bb6:  // pred: ^bb5
      llvm.br ^bb7
    ^bb7:  // pred: ^bb6
      %67 = llvm.xor %52, %66 : i32
      llvm.br ^bb8(%67 : i32)
    ^bb8(%68: i32):  // 2 preds: ^bb5, ^bb7
      llvm.br ^bb9
    ^bb9:  // pred: ^bb8
      %69 = llvm.mlir.constant(0 : i32) : i32
      %70 = llvm.mlir.constant(-1 : i32) : i32
      %71 = rocdl.mbcnt.lo %70, %69 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %72 = rocdl.mbcnt.hi %70, %71 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %73 = llvm.mlir.constant(0 : i32) : i32
      %74 = llvm.sub %73, %35 : i32
      %75 = llvm.add %72, %35 : i32
      %76 = llvm.and %75, %74 : i32
      %77 = llvm.xor %72, %14 : i32
      %78 = llvm.icmp "slt" %77, %76 : i32
      %79 = llvm.select %78, %77, %72 : i1, i32
      %80 = llvm.mlir.constant(2 : i32) : i32
      %81 = llvm.shl %79, %80 : i32
      %82 = rocdl.ds_bpermute %81, %68 : (i32, i32) -> i32
      llvm.cond_br %78, ^bb10, ^bb12(%68 : i32)
    ^bb10:  // pred: ^bb9
      llvm.br ^bb11
    ^bb11:  // pred: ^bb10
      %83 = llvm.xor %68, %82 : i32
      llvm.br ^bb12(%83 : i32)
    ^bb12(%84: i32):  // 2 preds: ^bb9, ^bb11
      llvm.br ^bb13
    ^bb13:  // pred: ^bb12
      %85 = llvm.mlir.constant(0 : i32) : i32
      %86 = llvm.mlir.constant(-1 : i32) : i32
      %87 = rocdl.mbcnt.lo %86, %85 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %88 = rocdl.mbcnt.hi %86, %87 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %89 = llvm.mlir.constant(0 : i32) : i32
      %90 = llvm.sub %89, %35 : i32
      %91 = llvm.add %88, %35 : i32
      %92 = llvm.and %91, %90 : i32
      %93 = llvm.xor %88, %13 : i32
      %94 = llvm.icmp "slt" %93, %92 : i32
      %95 = llvm.select %94, %93, %88 : i1, i32
      %96 = llvm.mlir.constant(2 : i32) : i32
      %97 = llvm.shl %95, %96 : i32
      %98 = rocdl.ds_bpermute %97, %84 : (i32, i32) -> i32
      llvm.cond_br %94, ^bb14, ^bb16(%84 : i32)
    ^bb14:  // pred: ^bb13
      llvm.br ^bb15
    ^bb15:  // pred: ^bb14
      %99 = llvm.xor %84, %98 : i32
      llvm.br ^bb16(%99 : i32)
    ^bb16(%100: i32):  // 2 preds: ^bb13, ^bb15
      llvm.br ^bb17
    ^bb17:  // pred: ^bb16
      %101 = llvm.mlir.constant(0 : i32) : i32
      %102 = llvm.mlir.constant(-1 : i32) : i32
      %103 = rocdl.mbcnt.lo %102, %101 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %104 = rocdl.mbcnt.hi %102, %103 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %105 = llvm.mlir.constant(0 : i32) : i32
      %106 = llvm.sub %105, %35 : i32
      %107 = llvm.add %104, %35 : i32
      %108 = llvm.and %107, %106 : i32
      %109 = llvm.xor %104, %12 : i32
      %110 = llvm.icmp "slt" %109, %108 : i32
      %111 = llvm.select %110, %109, %104 : i1, i32
      %112 = llvm.mlir.constant(2 : i32) : i32
      %113 = llvm.shl %111, %112 : i32
      %114 = rocdl.ds_bpermute %113, %100 : (i32, i32) -> i32
      llvm.cond_br %110, ^bb18, ^bb20(%100 : i32)
    ^bb18:  // pred: ^bb17
      llvm.br ^bb19
    ^bb19:  // pred: ^bb18
      %115 = llvm.xor %100, %114 : i32
      llvm.br ^bb20(%115 : i32)
    ^bb20(%116: i32):  // 2 preds: ^bb17, ^bb19
      llvm.br ^bb21(%116 : i32)
    ^bb21(%117: i32):  // 2 preds: ^bb20, ^bb31
      llvm.br ^bb32
    ^bb22:  // pred: ^bb0
      %118 = llvm.mlir.constant(0 : i32) : i32
      %119 = llvm.mlir.constant(-1 : i32) : i32
      %120 = rocdl.mbcnt.lo %119, %118 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %121 = rocdl.mbcnt.hi %119, %120 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %122 = llvm.mlir.constant(0 : i32) : i32
      %123 = llvm.sub %122, %16 : i32
      %124 = llvm.add %121, %16 : i32
      %125 = llvm.and %124, %123 : i32
      %126 = llvm.xor %121, %19 : i32
      %127 = llvm.icmp "slt" %126, %125 : i32
      %128 = llvm.select %127, %126, %121 : i1, i32
      %129 = llvm.mlir.constant(2 : i32) : i32
      %130 = llvm.shl %128, %129 : i32
      %131 = rocdl.ds_bpermute %130, %19 : (i32, i32) -> i32
      llvm.br ^bb23
    ^bb23:  // pred: ^bb22
      %132 = llvm.xor %131, %19 : i32
      llvm.br ^bb24
    ^bb24:  // pred: ^bb23
      %133 = llvm.mlir.constant(0 : i32) : i32
      %134 = llvm.mlir.constant(-1 : i32) : i32
      %135 = rocdl.mbcnt.lo %134, %133 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %136 = rocdl.mbcnt.hi %134, %135 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %137 = llvm.mlir.constant(0 : i32) : i32
      %138 = llvm.sub %137, %16 : i32
      %139 = llvm.add %136, %16 : i32
      %140 = llvm.and %139, %138 : i32
      %141 = llvm.xor %136, %15 : i32
      %142 = llvm.icmp "slt" %141, %140 : i32
      %143 = llvm.select %142, %141, %136 : i1, i32
      %144 = llvm.mlir.constant(2 : i32) : i32
      %145 = llvm.shl %143, %144 : i32
      %146 = rocdl.ds_bpermute %145, %132 : (i32, i32) -> i32
      llvm.br ^bb25
    ^bb25:  // pred: ^bb24
      %147 = llvm.xor %132, %146 : i32
      llvm.br ^bb26
    ^bb26:  // pred: ^bb25
      %148 = llvm.mlir.constant(0 : i32) : i32
      %149 = llvm.mlir.constant(-1 : i32) : i32
      %150 = rocdl.mbcnt.lo %149, %148 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %151 = rocdl.mbcnt.hi %149, %150 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %152 = llvm.mlir.constant(0 : i32) : i32
      %153 = llvm.sub %152, %16 : i32
      %154 = llvm.add %151, %16 : i32
      %155 = llvm.and %154, %153 : i32
      %156 = llvm.xor %151, %14 : i32
      %157 = llvm.icmp "slt" %156, %155 : i32
      %158 = llvm.select %157, %156, %151 : i1, i32
      %159 = llvm.mlir.constant(2 : i32) : i32
      %160 = llvm.shl %158, %159 : i32
      %161 = rocdl.ds_bpermute %160, %147 : (i32, i32) -> i32
      llvm.br ^bb27
    ^bb27:  // pred: ^bb26
      %162 = llvm.xor %147, %161 : i32
      llvm.br ^bb28
    ^bb28:  // pred: ^bb27
      %163 = llvm.mlir.constant(0 : i32) : i32
      %164 = llvm.mlir.constant(-1 : i32) : i32
      %165 = rocdl.mbcnt.lo %164, %163 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %166 = rocdl.mbcnt.hi %164, %165 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %167 = llvm.mlir.constant(0 : i32) : i32
      %168 = llvm.sub %167, %16 : i32
      %169 = llvm.add %166, %16 : i32
      %170 = llvm.and %169, %168 : i32
      %171 = llvm.xor %166, %13 : i32
      %172 = llvm.icmp "slt" %171, %170 : i32
      %173 = llvm.select %172, %171, %166 : i1, i32
      %174 = llvm.mlir.constant(2 : i32) : i32
      %175 = llvm.shl %173, %174 : i32
      %176 = rocdl.ds_bpermute %175, %162 : (i32, i32) -> i32
      llvm.br ^bb29
    ^bb29:  // pred: ^bb28
      %177 = llvm.xor %162, %176 : i32
      llvm.br ^bb30
    ^bb30:  // pred: ^bb29
      %178 = llvm.mlir.constant(0 : i32) : i32
      %179 = llvm.mlir.constant(-1 : i32) : i32
      %180 = rocdl.mbcnt.lo %179, %178 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %181 = rocdl.mbcnt.hi %179, %180 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %182 = llvm.mlir.constant(0 : i32) : i32
      %183 = llvm.sub %182, %16 : i32
      %184 = llvm.add %181, %16 : i32
      %185 = llvm.and %184, %183 : i32
      %186 = llvm.xor %181, %12 : i32
      %187 = llvm.icmp "slt" %186, %185 : i32
      %188 = llvm.select %187, %186, %181 : i1, i32
      %189 = llvm.mlir.constant(2 : i32) : i32
      %190 = llvm.shl %188, %189 : i32
      %191 = rocdl.ds_bpermute %190, %177 : (i32, i32) -> i32
      llvm.br ^bb31
    ^bb31:  // pred: ^bb30
      %192 = llvm.xor %177, %191 : i32
      llvm.br ^bb21(%192 : i32)
    ^bb32:  // pred: ^bb21
      llvm.cond_br %33, ^bb33, ^bb34
    ^bb33:  // pred: ^bb32
      %193 = llvm.sdiv %30, %16 : i32
      %194 = llvm.extractvalue %10[1] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %195 = llvm.getelementptr inbounds|nuw %194[%193] : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>, i32
      llvm.store %117, %195 : i32, !llvm.ptr<3>
      llvm.br ^bb35
    ^bb34:  // pred: ^bb32
      llvm.br ^bb35
    ^bb35:  // 2 preds: ^bb33, ^bb34
      rocdl.barrier
      %196 = llvm.add %31, %18 : i32
      %197 = llvm.sdiv %196, %16 : i32
      %198 = llvm.icmp "slt" %30, %197 : i32
      llvm.cond_br %198, ^bb36, ^bb69
    ^bb36:  // pred: ^bb35
      %199 = llvm.extractvalue %10[1] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %200 = llvm.getelementptr inbounds|nuw %199[%30] : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>, i32
      %201 = llvm.load %200 : !llvm.ptr<3> -> i32
      %202 = llvm.icmp "slt" %197, %16 : i32
      llvm.cond_br %202, ^bb37, ^bb58
    ^bb37:  // pred: ^bb36
      %203 = llvm.mlir.constant(0 : i32) : i32
      %204 = llvm.mlir.constant(-1 : i32) : i32
      %205 = rocdl.mbcnt.lo %204, %203 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %206 = rocdl.mbcnt.hi %204, %205 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %207 = llvm.mlir.constant(0 : i32) : i32
      %208 = llvm.sub %207, %197 : i32
      %209 = llvm.add %206, %197 : i32
      %210 = llvm.and %209, %208 : i32
      %211 = llvm.xor %206, %19 : i32
      %212 = llvm.icmp "slt" %211, %210 : i32
      %213 = llvm.select %212, %211, %206 : i1, i32
      %214 = llvm.mlir.constant(2 : i32) : i32
      %215 = llvm.shl %213, %214 : i32
      %216 = rocdl.ds_bpermute %215, %201 : (i32, i32) -> i32
      llvm.cond_br %212, ^bb38, ^bb40(%201 : i32)
    ^bb38:  // pred: ^bb37
      llvm.br ^bb39
    ^bb39:  // pred: ^bb38
      %217 = llvm.xor %201, %216 : i32
      llvm.br ^bb40(%217 : i32)
    ^bb40(%218: i32):  // 2 preds: ^bb37, ^bb39
      llvm.br ^bb41
    ^bb41:  // pred: ^bb40
      %219 = llvm.mlir.constant(0 : i32) : i32
      %220 = llvm.mlir.constant(-1 : i32) : i32
      %221 = rocdl.mbcnt.lo %220, %219 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %222 = rocdl.mbcnt.hi %220, %221 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %223 = llvm.mlir.constant(0 : i32) : i32
      %224 = llvm.sub %223, %197 : i32
      %225 = llvm.add %222, %197 : i32
      %226 = llvm.and %225, %224 : i32
      %227 = llvm.xor %222, %15 : i32
      %228 = llvm.icmp "slt" %227, %226 : i32
      %229 = llvm.select %228, %227, %222 : i1, i32
      %230 = llvm.mlir.constant(2 : i32) : i32
      %231 = llvm.shl %229, %230 : i32
      %232 = rocdl.ds_bpermute %231, %218 : (i32, i32) -> i32
      llvm.cond_br %228, ^bb42, ^bb44(%218 : i32)
    ^bb42:  // pred: ^bb41
      llvm.br ^bb43
    ^bb43:  // pred: ^bb42
      %233 = llvm.xor %218, %232 : i32
      llvm.br ^bb44(%233 : i32)
    ^bb44(%234: i32):  // 2 preds: ^bb41, ^bb43
      llvm.br ^bb45
    ^bb45:  // pred: ^bb44
      %235 = llvm.mlir.constant(0 : i32) : i32
      %236 = llvm.mlir.constant(-1 : i32) : i32
      %237 = rocdl.mbcnt.lo %236, %235 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %238 = rocdl.mbcnt.hi %236, %237 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %239 = llvm.mlir.constant(0 : i32) : i32
      %240 = llvm.sub %239, %197 : i32
      %241 = llvm.add %238, %197 : i32
      %242 = llvm.and %241, %240 : i32
      %243 = llvm.xor %238, %14 : i32
      %244 = llvm.icmp "slt" %243, %242 : i32
      %245 = llvm.select %244, %243, %238 : i1, i32
      %246 = llvm.mlir.constant(2 : i32) : i32
      %247 = llvm.shl %245, %246 : i32
      %248 = rocdl.ds_bpermute %247, %234 : (i32, i32) -> i32
      llvm.cond_br %244, ^bb46, ^bb48(%234 : i32)
    ^bb46:  // pred: ^bb45
      llvm.br ^bb47
    ^bb47:  // pred: ^bb46
      %249 = llvm.xor %234, %248 : i32
      llvm.br ^bb48(%249 : i32)
    ^bb48(%250: i32):  // 2 preds: ^bb45, ^bb47
      llvm.br ^bb49
    ^bb49:  // pred: ^bb48
      %251 = llvm.mlir.constant(0 : i32) : i32
      %252 = llvm.mlir.constant(-1 : i32) : i32
      %253 = rocdl.mbcnt.lo %252, %251 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %254 = rocdl.mbcnt.hi %252, %253 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %255 = llvm.mlir.constant(0 : i32) : i32
      %256 = llvm.sub %255, %197 : i32
      %257 = llvm.add %254, %197 : i32
      %258 = llvm.and %257, %256 : i32
      %259 = llvm.xor %254, %13 : i32
      %260 = llvm.icmp "slt" %259, %258 : i32
      %261 = llvm.select %260, %259, %254 : i1, i32
      %262 = llvm.mlir.constant(2 : i32) : i32
      %263 = llvm.shl %261, %262 : i32
      %264 = rocdl.ds_bpermute %263, %250 : (i32, i32) -> i32
      llvm.cond_br %260, ^bb50, ^bb52(%250 : i32)
    ^bb50:  // pred: ^bb49
      llvm.br ^bb51
    ^bb51:  // pred: ^bb50
      %265 = llvm.xor %250, %264 : i32
      llvm.br ^bb52(%265 : i32)
    ^bb52(%266: i32):  // 2 preds: ^bb49, ^bb51
      llvm.br ^bb53
    ^bb53:  // pred: ^bb52
      %267 = llvm.mlir.constant(0 : i32) : i32
      %268 = llvm.mlir.constant(-1 : i32) : i32
      %269 = rocdl.mbcnt.lo %268, %267 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %270 = rocdl.mbcnt.hi %268, %269 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %271 = llvm.mlir.constant(0 : i32) : i32
      %272 = llvm.sub %271, %197 : i32
      %273 = llvm.add %270, %197 : i32
      %274 = llvm.and %273, %272 : i32
      %275 = llvm.xor %270, %12 : i32
      %276 = llvm.icmp "slt" %275, %274 : i32
      %277 = llvm.select %276, %275, %270 : i1, i32
      %278 = llvm.mlir.constant(2 : i32) : i32
      %279 = llvm.shl %277, %278 : i32
      %280 = rocdl.ds_bpermute %279, %266 : (i32, i32) -> i32
      llvm.cond_br %276, ^bb54, ^bb56(%266 : i32)
    ^bb54:  // pred: ^bb53
      llvm.br ^bb55
    ^bb55:  // pred: ^bb54
      %281 = llvm.xor %266, %280 : i32
      llvm.br ^bb56(%281 : i32)
    ^bb56(%282: i32):  // 2 preds: ^bb53, ^bb55
      llvm.br ^bb57(%282 : i32)
    ^bb57(%283: i32):  // 2 preds: ^bb56, ^bb67
      llvm.br ^bb68
    ^bb58:  // pred: ^bb36
      %284 = llvm.mlir.constant(0 : i32) : i32
      %285 = llvm.mlir.constant(-1 : i32) : i32
      %286 = rocdl.mbcnt.lo %285, %284 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %287 = rocdl.mbcnt.hi %285, %286 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %288 = llvm.mlir.constant(0 : i32) : i32
      %289 = llvm.sub %288, %16 : i32
      %290 = llvm.add %287, %16 : i32
      %291 = llvm.and %290, %289 : i32
      %292 = llvm.xor %287, %19 : i32
      %293 = llvm.icmp "slt" %292, %291 : i32
      %294 = llvm.select %293, %292, %287 : i1, i32
      %295 = llvm.mlir.constant(2 : i32) : i32
      %296 = llvm.shl %294, %295 : i32
      %297 = rocdl.ds_bpermute %296, %201 : (i32, i32) -> i32
      llvm.br ^bb59
    ^bb59:  // pred: ^bb58
      %298 = llvm.xor %201, %297 : i32
      llvm.br ^bb60
    ^bb60:  // pred: ^bb59
      %299 = llvm.mlir.constant(0 : i32) : i32
      %300 = llvm.mlir.constant(-1 : i32) : i32
      %301 = rocdl.mbcnt.lo %300, %299 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %302 = rocdl.mbcnt.hi %300, %301 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %303 = llvm.mlir.constant(0 : i32) : i32
      %304 = llvm.sub %303, %16 : i32
      %305 = llvm.add %302, %16 : i32
      %306 = llvm.and %305, %304 : i32
      %307 = llvm.xor %302, %15 : i32
      %308 = llvm.icmp "slt" %307, %306 : i32
      %309 = llvm.select %308, %307, %302 : i1, i32
      %310 = llvm.mlir.constant(2 : i32) : i32
      %311 = llvm.shl %309, %310 : i32
      %312 = rocdl.ds_bpermute %311, %298 : (i32, i32) -> i32
      llvm.br ^bb61
    ^bb61:  // pred: ^bb60
      %313 = llvm.xor %298, %312 : i32
      llvm.br ^bb62
    ^bb62:  // pred: ^bb61
      %314 = llvm.mlir.constant(0 : i32) : i32
      %315 = llvm.mlir.constant(-1 : i32) : i32
      %316 = rocdl.mbcnt.lo %315, %314 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %317 = rocdl.mbcnt.hi %315, %316 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %318 = llvm.mlir.constant(0 : i32) : i32
      %319 = llvm.sub %318, %16 : i32
      %320 = llvm.add %317, %16 : i32
      %321 = llvm.and %320, %319 : i32
      %322 = llvm.xor %317, %14 : i32
      %323 = llvm.icmp "slt" %322, %321 : i32
      %324 = llvm.select %323, %322, %317 : i1, i32
      %325 = llvm.mlir.constant(2 : i32) : i32
      %326 = llvm.shl %324, %325 : i32
      %327 = rocdl.ds_bpermute %326, %313 : (i32, i32) -> i32
      llvm.br ^bb63
    ^bb63:  // pred: ^bb62
      %328 = llvm.xor %313, %327 : i32
      llvm.br ^bb64
    ^bb64:  // pred: ^bb63
      %329 = llvm.mlir.constant(0 : i32) : i32
      %330 = llvm.mlir.constant(-1 : i32) : i32
      %331 = rocdl.mbcnt.lo %330, %329 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %332 = rocdl.mbcnt.hi %330, %331 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %333 = llvm.mlir.constant(0 : i32) : i32
      %334 = llvm.sub %333, %16 : i32
      %335 = llvm.add %332, %16 : i32
      %336 = llvm.and %335, %334 : i32
      %337 = llvm.xor %332, %13 : i32
      %338 = llvm.icmp "slt" %337, %336 : i32
      %339 = llvm.select %338, %337, %332 : i1, i32
      %340 = llvm.mlir.constant(2 : i32) : i32
      %341 = llvm.shl %339, %340 : i32
      %342 = rocdl.ds_bpermute %341, %328 : (i32, i32) -> i32
      llvm.br ^bb65
    ^bb65:  // pred: ^bb64
      %343 = llvm.xor %328, %342 : i32
      llvm.br ^bb66
    ^bb66:  // pred: ^bb65
      %344 = llvm.mlir.constant(0 : i32) : i32
      %345 = llvm.mlir.constant(-1 : i32) : i32
      %346 = rocdl.mbcnt.lo %345, %344 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]} : (i32, i32) -> i32
      %347 = rocdl.mbcnt.hi %345, %346 {res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]} : (i32, i32) -> i32
      %348 = llvm.mlir.constant(0 : i32) : i32
      %349 = llvm.sub %348, %16 : i32
      %350 = llvm.add %347, %16 : i32
      %351 = llvm.and %350, %349 : i32
      %352 = llvm.xor %347, %12 : i32
      %353 = llvm.icmp "slt" %352, %351 : i32
      %354 = llvm.select %353, %352, %347 : i1, i32
      %355 = llvm.mlir.constant(2 : i32) : i32
      %356 = llvm.shl %354, %355 : i32
      %357 = rocdl.ds_bpermute %356, %343 : (i32, i32) -> i32
      llvm.br ^bb67
    ^bb67:  // pred: ^bb66
      %358 = llvm.xor %343, %357 : i32
      llvm.br ^bb57(%358 : i32)
    ^bb68:  // pred: ^bb57
      %359 = llvm.extractvalue %10[1] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %360 = llvm.getelementptr inbounds|nuw %359[%11] : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>, i32
      llvm.store %283, %360 : i32, !llvm.ptr<3>
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
    llvm.func @gpu_dim_int_max_upper_bound() -> i32 attributes {llvm.emit_c_interface} {
      %0 = rocdl.workgroup.dim.x range <i32, 1, 2147483647> : i32
      llvm.return %0 : i32
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
  }
}

