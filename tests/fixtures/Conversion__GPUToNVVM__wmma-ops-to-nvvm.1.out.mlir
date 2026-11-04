module {
  gpu.module @test_module {
    llvm.func @gpu_wmma_load_op() -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> attributes {llvm.emit_c_interface} {
      %0 = llvm.mlir.constant(16 : index) : i64
      %1 = llvm.mlir.constant(32 : index) : i64
      %2 = llvm.mlir.constant(32 : index) : i64
      %3 = llvm.mlir.constant(1 : index) : i64
      %4 = llvm.mlir.constant(1024 : index) : i64
      %5 = llvm.alloca %4 x f16 {alignment = 32 : i64} : (i64) -> !llvm.ptr<3>
      %6 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %7 = llvm.insertvalue %5, %6[0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %8 = llvm.insertvalue %5, %7[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %9 = llvm.mlir.constant(0 : index) : i64
      %10 = llvm.insertvalue %9, %8[2] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %11 = llvm.insertvalue %1, %10[3, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %12 = llvm.insertvalue %2, %11[3, 1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %13 = llvm.insertvalue %2, %12[4, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %14 = llvm.insertvalue %3, %13[4, 1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %15 = llvm.extractvalue %14[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %16 = llvm.mlir.constant(32 : index) : i64
      %17 = llvm.mul %0, %16 : i64
      %18 = llvm.add %17, %0 : i64
      %19 = llvm.getelementptr %15[%18] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f16
      %20 = llvm.mlir.constant(32 : index) : i32
      %21 = nvvm.wmma.load %19, %20 {eltype = #nvvm.mma_type<f16>, frag = #nvvm.mma_frag<a>, k = 16 : i32, layout = #nvvm.mma_layout<col>, m = 16 : i32, n = 16 : i32} : (!llvm.ptr<3>) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      llvm.return %21 : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
    }
    llvm.func @_mlir_ciface_gpu_wmma_load_op(%arg0: !llvm.ptr) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_wmma_load_op() : () -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      llvm.store %0, %arg0 : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module {
    llvm.func @gpu_wmma_int8_load_op() -> !llvm.struct<(i32, i32)> attributes {llvm.emit_c_interface} {
      %0 = llvm.mlir.constant(16 : index) : i64
      %1 = llvm.mlir.constant(32 : index) : i64
      %2 = llvm.mlir.constant(32 : index) : i64
      %3 = llvm.mlir.constant(1 : index) : i64
      %4 = llvm.mlir.constant(1024 : index) : i64
      %5 = llvm.alloca %4 x i8 {alignment = 32 : i64} : (i64) -> !llvm.ptr<3>
      %6 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %7 = llvm.insertvalue %5, %6[0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %8 = llvm.insertvalue %5, %7[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %9 = llvm.mlir.constant(0 : index) : i64
      %10 = llvm.insertvalue %9, %8[2] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %11 = llvm.insertvalue %1, %10[3, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %12 = llvm.insertvalue %2, %11[3, 1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %13 = llvm.insertvalue %2, %12[4, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %14 = llvm.insertvalue %3, %13[4, 1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %15 = llvm.extractvalue %14[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %16 = llvm.mlir.constant(32 : index) : i64
      %17 = llvm.mul %0, %16 : i64
      %18 = llvm.add %17, %0 : i64
      %19 = llvm.getelementptr %15[%18] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, i8
      %20 = llvm.mlir.constant(32 : index) : i32
      %21 = nvvm.wmma.load %19, %20 {eltype = #nvvm.mma_type<s8>, frag = #nvvm.mma_frag<a>, k = 16 : i32, layout = #nvvm.mma_layout<col>, m = 16 : i32, n = 16 : i32} : (!llvm.ptr<3>) -> !llvm.struct<(i32, i32)>
      llvm.return %21 : !llvm.struct<(i32, i32)>
    }
    llvm.func @_mlir_ciface_gpu_wmma_int8_load_op(%arg0: !llvm.ptr) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_wmma_int8_load_op() : () -> !llvm.struct<(i32, i32)>
      llvm.store %0, %arg0 : !llvm.struct<(i32, i32)>, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module {
    llvm.func @gpu_wmma_f64_load_op() -> f64 attributes {llvm.emit_c_interface} {
      %0 = llvm.mlir.constant(16 : index) : i64
      %1 = llvm.mlir.constant(32 : index) : i64
      %2 = llvm.mlir.constant(32 : index) : i64
      %3 = llvm.mlir.constant(1 : index) : i64
      %4 = llvm.mlir.constant(1024 : index) : i64
      %5 = llvm.alloca %4 x f64 {alignment = 32 : i64} : (i64) -> !llvm.ptr<3>
      %6 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %7 = llvm.insertvalue %5, %6[0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %8 = llvm.insertvalue %5, %7[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %9 = llvm.mlir.constant(0 : index) : i64
      %10 = llvm.insertvalue %9, %8[2] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %11 = llvm.insertvalue %1, %10[3, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %12 = llvm.insertvalue %2, %11[3, 1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %13 = llvm.insertvalue %2, %12[4, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %14 = llvm.insertvalue %3, %13[4, 1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %15 = llvm.extractvalue %14[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %16 = llvm.mlir.constant(32 : index) : i64
      %17 = llvm.mul %0, %16 : i64
      %18 = llvm.add %17, %0 : i64
      %19 = llvm.getelementptr %15[%18] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f64
      %20 = llvm.mlir.constant(32 : index) : i32
      %21 = nvvm.wmma.load %19, %20 {eltype = #nvvm.mma_type<f64>, frag = #nvvm.mma_frag<a>, k = 4 : i32, layout = #nvvm.mma_layout<row>, m = 8 : i32, n = 8 : i32} : (!llvm.ptr<3>) -> f64
      llvm.return %21 : f64
    }
    llvm.func @_mlir_ciface_gpu_wmma_f64_load_op() -> f64 attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_wmma_f64_load_op() : () -> f64
      llvm.return %0 : f64
    }
  }
}

// -----
module {
  gpu.module @test_module {
    llvm.func @gpu_wmma_store_op(%arg0: !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) attributes {llvm.emit_c_interface} {
      %0 = llvm.mlir.constant(16 : index) : i64
      %1 = llvm.mlir.constant(32 : index) : i64
      %2 = llvm.mlir.constant(32 : index) : i64
      %3 = llvm.mlir.constant(1 : index) : i64
      %4 = llvm.mlir.constant(1024 : index) : i64
      %5 = llvm.alloca %4 x f16 {alignment = 32 : i64} : (i64) -> !llvm.ptr<3>
      %6 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %7 = llvm.insertvalue %5, %6[0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %8 = llvm.insertvalue %5, %7[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %9 = llvm.mlir.constant(0 : index) : i64
      %10 = llvm.insertvalue %9, %8[2] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %11 = llvm.insertvalue %1, %10[3, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %12 = llvm.insertvalue %2, %11[3, 1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %13 = llvm.insertvalue %2, %12[4, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %14 = llvm.insertvalue %3, %13[4, 1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %15 = llvm.extractvalue %arg0[0] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %16 = llvm.extractvalue %arg0[1] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %17 = llvm.extractvalue %arg0[2] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %18 = llvm.extractvalue %arg0[3] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %19 = llvm.extractvalue %14[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %20 = llvm.mlir.constant(32 : index) : i64
      %21 = llvm.mul %0, %20 : i64
      %22 = llvm.add %21, %0 : i64
      %23 = llvm.getelementptr %19[%22] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f16
      %24 = llvm.mlir.constant(32 : index) : i32
      nvvm.wmma.store %23, %24, %15, %16, %17, %18 {eltype = #nvvm.mma_type<f16>, k = 16 : i32, layout = #nvvm.mma_layout<col>, m = 16 : i32, n = 16 : i32} : !llvm.ptr<3>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>
      llvm.return
    }
    llvm.func @_mlir_ciface_gpu_wmma_store_op(%arg0: !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) attributes {llvm.emit_c_interface} {
      llvm.call @gpu_wmma_store_op(%arg0) : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> ()
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module {
    llvm.func @gpu_wmma_mma_op(%arg0: !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, %arg1: !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, %arg2: !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> attributes {llvm.emit_c_interface} {
      %0 = llvm.extractvalue %arg0[0] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %1 = llvm.extractvalue %arg0[1] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %2 = llvm.extractvalue %arg0[2] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %3 = llvm.extractvalue %arg0[3] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %4 = llvm.extractvalue %arg0[4] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %5 = llvm.extractvalue %arg0[5] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %6 = llvm.extractvalue %arg0[6] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %7 = llvm.extractvalue %arg0[7] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %8 = llvm.extractvalue %arg1[0] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %9 = llvm.extractvalue %arg1[1] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %10 = llvm.extractvalue %arg1[2] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %11 = llvm.extractvalue %arg1[3] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %12 = llvm.extractvalue %arg1[4] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %13 = llvm.extractvalue %arg1[5] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %14 = llvm.extractvalue %arg1[6] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %15 = llvm.extractvalue %arg1[7] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %16 = llvm.extractvalue %arg2[0] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %17 = llvm.extractvalue %arg2[1] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %18 = llvm.extractvalue %arg2[2] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %19 = llvm.extractvalue %arg2[3] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %20 = nvvm.wmma.mma %0, %1, %2, %3, %4, %5, %6, %7, %8, %9, %10, %11, %12, %13, %14, %15, %16, %17, %18, %19 {eltypeA = #nvvm.mma_type<f16>, eltypeB = #nvvm.mma_type<f16>, k = 16 : i32, layoutA = #nvvm.mma_layout<col>, layoutB = #nvvm.mma_layout<row>, m = 16 : i32, n = 16 : i32} : (vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      llvm.return %20 : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
    }
    llvm.func @_mlir_ciface_gpu_wmma_mma_op(%arg0: !llvm.ptr, %arg1: !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, %arg2: !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, %arg3: !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_wmma_mma_op(%arg1, %arg2, %arg3) : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      llvm.store %0, %arg0 : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module {
    llvm.func @gpu_wmma_mma_int8_op(%arg0: !llvm.struct<(i32, i32, i32, i32)>, %arg1: !llvm.struct<(i32)>, %arg2: !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)>) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)> attributes {llvm.emit_c_interface} {
      %0 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32, i32, i32)> 
      %1 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, i32, i32, i32)> 
      %2 = llvm.extractvalue %arg0[2] : !llvm.struct<(i32, i32, i32, i32)> 
      %3 = llvm.extractvalue %arg0[3] : !llvm.struct<(i32, i32, i32, i32)> 
      %4 = llvm.extractvalue %arg1[0] : !llvm.struct<(i32)> 
      %5 = llvm.extractvalue %arg2[0] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)> 
      %6 = llvm.extractvalue %arg2[1] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)> 
      %7 = llvm.extractvalue %arg2[2] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)> 
      %8 = llvm.extractvalue %arg2[3] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)> 
      %9 = llvm.extractvalue %arg2[4] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)> 
      %10 = llvm.extractvalue %arg2[5] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)> 
      %11 = llvm.extractvalue %arg2[6] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)> 
      %12 = llvm.extractvalue %arg2[7] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)> 
      %13 = nvvm.wmma.mma %0, %1, %2, %3, %4, %5, %6, %7, %8, %9, %10, %11, %12 {eltypeA = #nvvm.mma_type<s8>, eltypeB = #nvvm.mma_type<s32>, k = 16 : i32, layoutA = #nvvm.mma_layout<col>, layoutB = #nvvm.mma_layout<row>, m = 32 : i32, n = 8 : i32} : (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)>
      llvm.return %13 : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)>
    }
    llvm.func @_mlir_ciface_gpu_wmma_mma_int8_op(%arg0: !llvm.ptr, %arg1: !llvm.struct<(i32, i32, i32, i32)>, %arg2: !llvm.struct<(i32)>, %arg3: !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)>) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_wmma_mma_int8_op(%arg1, %arg2, %arg3) : (!llvm.struct<(i32, i32, i32, i32)>, !llvm.struct<(i32)>, !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)>) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)>
      llvm.store %0, %arg0 : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)>, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module {
    llvm.func @gpu_wmma_mma_loop_op(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: !llvm.ptr, %arg8: !llvm.ptr, %arg9: i64, %arg10: i64, %arg11: i64, %arg12: i64, %arg13: i64, %arg14: !llvm.ptr, %arg15: !llvm.ptr, %arg16: i64, %arg17: i64, %arg18: i64, %arg19: i64, %arg20: i64) attributes {llvm.emit_c_interface} {
      %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
      %1 = llvm.insertvalue %arg14, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %2 = llvm.insertvalue %arg15, %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %3 = llvm.insertvalue %arg16, %2[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %4 = llvm.insertvalue %arg17, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %5 = llvm.insertvalue %arg19, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %6 = llvm.insertvalue %arg18, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %7 = llvm.insertvalue %arg20, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %8 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
      %9 = llvm.insertvalue %arg7, %8[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %10 = llvm.insertvalue %arg8, %9[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %11 = llvm.insertvalue %arg9, %10[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %12 = llvm.insertvalue %arg10, %11[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %13 = llvm.insertvalue %arg12, %12[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %14 = llvm.insertvalue %arg11, %13[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %15 = llvm.insertvalue %arg13, %14[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %16 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
      %17 = llvm.insertvalue %arg0, %16[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %18 = llvm.insertvalue %arg1, %17[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %19 = llvm.insertvalue %arg2, %18[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %20 = llvm.insertvalue %arg3, %19[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %21 = llvm.insertvalue %arg5, %20[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %22 = llvm.insertvalue %arg4, %21[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %23 = llvm.insertvalue %arg6, %22[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %24 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
      %25 = llvm.insertvalue %arg14, %24[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %26 = llvm.insertvalue %arg15, %25[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %27 = llvm.insertvalue %arg16, %26[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %28 = llvm.insertvalue %arg17, %27[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %29 = llvm.insertvalue %arg19, %28[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %30 = llvm.insertvalue %arg18, %29[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %31 = llvm.insertvalue %arg20, %30[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %32 = llvm.mlir.constant(0 : index) : i64
      %33 = llvm.mlir.constant(128 : index) : i64
      %34 = llvm.mlir.constant(32 : index) : i64
      %35 = llvm.extractvalue %31[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %36 = llvm.mlir.constant(128 : index) : i64
      %37 = llvm.mul %32, %36 : i64
      %38 = llvm.add %37, %32 : i64
      %39 = llvm.getelementptr %35[%38] : (!llvm.ptr, i64) -> !llvm.ptr, f16
      %40 = llvm.mlir.constant(128 : index) : i32
      %41 = nvvm.wmma.load %39, %40 {eltype = #nvvm.mma_type<f16>, frag = #nvvm.mma_frag<c>, k = 16 : i32, layout = #nvvm.mma_layout<row>, m = 16 : i32, n = 16 : i32} : (!llvm.ptr) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      llvm.br ^bb1(%32, %41 : i64, !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>)
    ^bb1(%42: i64, %43: !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>):  // 2 preds: ^bb0, ^bb2
      %44 = llvm.icmp "slt" %42, %33 : i64
      llvm.cond_br %44, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %45 = llvm.extractvalue %23[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %46 = llvm.mlir.constant(128 : index) : i64
      %47 = llvm.mul %32, %46 : i64
      %48 = llvm.add %47, %42 : i64
      %49 = llvm.getelementptr %45[%48] : (!llvm.ptr, i64) -> !llvm.ptr, f16
      %50 = llvm.mlir.constant(128 : index) : i32
      %51 = nvvm.wmma.load %49, %50 {eltype = #nvvm.mma_type<f16>, frag = #nvvm.mma_frag<a>, k = 16 : i32, layout = #nvvm.mma_layout<row>, m = 16 : i32, n = 16 : i32} : (!llvm.ptr) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      %52 = llvm.extractvalue %15[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %53 = llvm.mlir.constant(128 : index) : i64
      %54 = llvm.mul %42, %53 : i64
      %55 = llvm.add %54, %32 : i64
      %56 = llvm.getelementptr %52[%55] : (!llvm.ptr, i64) -> !llvm.ptr, f16
      %57 = llvm.mlir.constant(128 : index) : i32
      %58 = nvvm.wmma.load %56, %57 {eltype = #nvvm.mma_type<f16>, frag = #nvvm.mma_frag<b>, k = 16 : i32, layout = #nvvm.mma_layout<row>, m = 16 : i32, n = 16 : i32} : (!llvm.ptr) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      %59 = llvm.extractvalue %51[0] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %60 = llvm.extractvalue %51[1] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %61 = llvm.extractvalue %51[2] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %62 = llvm.extractvalue %51[3] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %63 = llvm.extractvalue %51[4] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %64 = llvm.extractvalue %51[5] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %65 = llvm.extractvalue %51[6] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %66 = llvm.extractvalue %51[7] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %67 = llvm.extractvalue %58[0] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %68 = llvm.extractvalue %58[1] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %69 = llvm.extractvalue %58[2] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %70 = llvm.extractvalue %58[3] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %71 = llvm.extractvalue %58[4] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %72 = llvm.extractvalue %58[5] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %73 = llvm.extractvalue %58[6] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %74 = llvm.extractvalue %58[7] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %75 = llvm.extractvalue %43[0] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %76 = llvm.extractvalue %43[1] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %77 = llvm.extractvalue %43[2] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %78 = llvm.extractvalue %43[3] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %79 = nvvm.wmma.mma %59, %60, %61, %62, %63, %64, %65, %66, %67, %68, %69, %70, %71, %72, %73, %74, %75, %76, %77, %78 {eltypeA = #nvvm.mma_type<f16>, eltypeB = #nvvm.mma_type<f16>, k = 16 : i32, layoutA = #nvvm.mma_layout<row>, layoutB = #nvvm.mma_layout<row>, m = 16 : i32, n = 16 : i32} : (vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      %80 = llvm.add %42, %34 : i64
      llvm.br ^bb1(%80, %79 : i64, !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>)
    ^bb3:  // pred: ^bb1
      %81 = llvm.extractvalue %43[0] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %82 = llvm.extractvalue %43[1] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %83 = llvm.extractvalue %43[2] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %84 = llvm.extractvalue %43[3] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %85 = llvm.extractvalue %7[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %86 = llvm.mlir.constant(128 : index) : i64
      %87 = llvm.mul %32, %86 : i64
      %88 = llvm.add %87, %32 : i64
      %89 = llvm.getelementptr %85[%88] : (!llvm.ptr, i64) -> !llvm.ptr, f16
      %90 = llvm.mlir.constant(128 : index) : i32
      nvvm.wmma.store %89, %90, %81, %82, %83, %84 {eltype = #nvvm.mma_type<f16>, k = 16 : i32, layout = #nvvm.mma_layout<row>, m = 16 : i32, n = 16 : i32} : !llvm.ptr, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>
      llvm.return
    }
    llvm.func @_mlir_ciface_gpu_wmma_mma_loop_op(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr) attributes {llvm.emit_c_interface} {
      %0 = llvm.load %arg0 : !llvm.ptr -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
      %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %4 = llvm.extractvalue %0[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %5 = llvm.extractvalue %0[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %6 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %7 = llvm.extractvalue %0[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %8 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
      %9 = llvm.extractvalue %8[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %10 = llvm.extractvalue %8[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %11 = llvm.extractvalue %8[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %12 = llvm.extractvalue %8[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %13 = llvm.extractvalue %8[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %14 = llvm.extractvalue %8[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %15 = llvm.extractvalue %8[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %16 = llvm.load %arg2 : !llvm.ptr -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
      %17 = llvm.extractvalue %16[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %18 = llvm.extractvalue %16[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %19 = llvm.extractvalue %16[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %20 = llvm.extractvalue %16[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %21 = llvm.extractvalue %16[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %22 = llvm.extractvalue %16[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %23 = llvm.extractvalue %16[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      llvm.call @gpu_wmma_mma_loop_op(%1, %2, %3, %4, %5, %6, %7, %9, %10, %11, %12, %13, %14, %15, %17, %18, %19, %20, %21, %22, %23) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64, !llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64, !llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> ()
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module {
    llvm.func @gpu_wmma_constant_op() -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> attributes {llvm.emit_c_interface} {
      %0 = llvm.mlir.constant(1.000000e+00 : f16) : f16
      %1 = llvm.mlir.poison : vector<2xf16>
      %2 = llvm.mlir.constant(0 : i32) : i32
      %3 = llvm.insertelement %0, %1[%2 : i32] : vector<2xf16>
      %4 = llvm.mlir.constant(1 : i32) : i32
      %5 = llvm.insertelement %0, %3[%4 : i32] : vector<2xf16>
      %6 = llvm.mlir.poison : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      %7 = llvm.insertvalue %5, %6[0] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %8 = llvm.insertvalue %5, %7[1] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %9 = llvm.insertvalue %5, %8[2] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %10 = llvm.insertvalue %5, %9[3] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      llvm.return %10 : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
    }
    llvm.func @_mlir_ciface_gpu_wmma_constant_op(%arg0: !llvm.ptr) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_wmma_constant_op() : () -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      llvm.store %0, %arg0 : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @test_module {
    llvm.func @gpu_wmma_elementwise(%arg0: !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, %arg1: !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> attributes {llvm.emit_c_interface} {
      %0 = llvm.mlir.poison : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %2 = llvm.extractvalue %arg1[0] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %3 = llvm.fadd %1, %2 : vector<2xf16>
      %4 = llvm.insertvalue %3, %0[0] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %5 = llvm.extractvalue %arg0[1] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %6 = llvm.extractvalue %arg1[1] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %7 = llvm.fadd %5, %6 : vector<2xf16>
      %8 = llvm.insertvalue %7, %4[1] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %9 = llvm.extractvalue %arg0[2] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %10 = llvm.extractvalue %arg1[2] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %11 = llvm.fadd %9, %10 : vector<2xf16>
      %12 = llvm.insertvalue %11, %8[2] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %13 = llvm.extractvalue %arg0[3] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %14 = llvm.extractvalue %arg1[3] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %15 = llvm.fadd %13, %14 : vector<2xf16>
      %16 = llvm.insertvalue %15, %12[3] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %17 = llvm.mlir.poison : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      %18 = llvm.extractvalue %16[0] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %19 = llvm.extractvalue %arg1[0] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %20 = llvm.fcmp "ogt" %18, %19 : vector<2xf16>
      %21 = llvm.select %20, %18, %19 : vector<2xi1>, vector<2xf16>
      %22 = llvm.fcmp "uno" %18, %19 : vector<2xf16>
      %23 = llvm.mlir.constant(0x7E00 : f16) : vector<2xf16>
      %24 = llvm.select %22, %23, %21 : vector<2xi1>, vector<2xf16>
      %25 = llvm.insertvalue %24, %17[0] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %26 = llvm.extractvalue %16[1] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %27 = llvm.extractvalue %arg1[1] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %28 = llvm.fcmp "ogt" %26, %27 : vector<2xf16>
      %29 = llvm.select %28, %26, %27 : vector<2xi1>, vector<2xf16>
      %30 = llvm.fcmp "uno" %26, %27 : vector<2xf16>
      %31 = llvm.mlir.constant(0x7E00 : f16) : vector<2xf16>
      %32 = llvm.select %30, %31, %29 : vector<2xi1>, vector<2xf16>
      %33 = llvm.insertvalue %32, %25[1] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %34 = llvm.extractvalue %16[2] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %35 = llvm.extractvalue %arg1[2] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %36 = llvm.fcmp "ogt" %34, %35 : vector<2xf16>
      %37 = llvm.select %36, %34, %35 : vector<2xi1>, vector<2xf16>
      %38 = llvm.fcmp "uno" %34, %35 : vector<2xf16>
      %39 = llvm.mlir.constant(0x7E00 : f16) : vector<2xf16>
      %40 = llvm.select %38, %39, %37 : vector<2xi1>, vector<2xf16>
      %41 = llvm.insertvalue %40, %33[2] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %42 = llvm.extractvalue %16[3] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %43 = llvm.extractvalue %arg1[3] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %44 = llvm.fcmp "ogt" %42, %43 : vector<2xf16>
      %45 = llvm.select %44, %42, %43 : vector<2xi1>, vector<2xf16>
      %46 = llvm.fcmp "uno" %42, %43 : vector<2xf16>
      %47 = llvm.mlir.constant(0x7E00 : f16) : vector<2xf16>
      %48 = llvm.select %46, %47, %45 : vector<2xi1>, vector<2xf16>
      %49 = llvm.insertvalue %48, %41[3] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      llvm.return %49 : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
    }
    llvm.func @_mlir_ciface_gpu_wmma_elementwise(%arg0: !llvm.ptr, %arg1: !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, %arg2: !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_wmma_elementwise(%arg1, %arg2) : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      llvm.store %0, %arg0 : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, !llvm.ptr
      llvm.return
    }
  }
}

