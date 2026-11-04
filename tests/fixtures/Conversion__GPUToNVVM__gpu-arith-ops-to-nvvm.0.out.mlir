module {
  gpu.module @test_module_54 {
    llvm.func @__nv_fmaxf(f32, f32) -> f32
    llvm.func @__nv_fminf(f32, f32) -> f32
    llvm.func @__nv_fmax(f64, f64) -> f64
    llvm.func @__nv_fmin(f64, f64) -> f64
    llvm.func @gpu_fminmax(%arg0: f32, %arg1: f32, %arg2: f64, %arg3: f64) -> !llvm.struct<(f32, f32, f64, f64)> attributes {llvm.emit_c_interface} {
      %0 = llvm.call @__nv_fmaxf(%arg0, %arg1) : (f32, f32) -> f32
      %1 = llvm.call @__nv_fminf(%arg0, %arg1) : (f32, f32) -> f32
      %2 = llvm.call @__nv_fmax(%arg2, %arg3) : (f64, f64) -> f64
      %3 = llvm.call @__nv_fmin(%arg2, %arg3) : (f64, f64) -> f64
      %4 = llvm.mlir.poison : !llvm.struct<(f32, f32, f64, f64)>
      %5 = llvm.insertvalue %0, %4[0] : !llvm.struct<(f32, f32, f64, f64)> 
      %6 = llvm.insertvalue %1, %5[1] : !llvm.struct<(f32, f32, f64, f64)> 
      %7 = llvm.insertvalue %2, %6[2] : !llvm.struct<(f32, f32, f64, f64)> 
      %8 = llvm.insertvalue %3, %7[3] : !llvm.struct<(f32, f32, f64, f64)> 
      llvm.return %8 : !llvm.struct<(f32, f32, f64, f64)>
    }
    llvm.func @_mlir_ciface_gpu_fminmax(%arg0: !llvm.ptr, %arg1: f32, %arg2: f32, %arg3: f64, %arg4: f64) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_fminmax(%arg1, %arg2, %arg3, %arg4) : (f32, f32, f64, f64) -> !llvm.struct<(f32, f32, f64, f64)>
      llvm.store %0, %arg0 : !llvm.struct<(f32, f32, f64, f64)>, !llvm.ptr
      llvm.return
    }
  }
}

