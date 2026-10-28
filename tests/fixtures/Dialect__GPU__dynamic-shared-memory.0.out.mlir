module {
  gpu.module @modules {
    llvm.mlir.global internal @__dynamic_shmem__3() {addr_space = 3 : i32, alignment = 16 : i64} : !llvm.array<0 x i8>
    llvm.mlir.global internal @__dynamic_shmem__0() {addr_space = 3 : i32, alignment = 4 : i64} : !llvm.array<0 x i8>
    llvm.mlir.global internal @__dynamic_shmem__1() {addr_space = 3 : i32, alignment = 4 : i64} : !llvm.array<0 x i8>
    llvm.mlir.global internal @__dynamic_shmem__2() {addr_space = 0 : i32, alignment = 16 : i64} : !llvm.array<0 x i8>
    llvm.func @dynamic_shared_memory_kernel(%arg0: i64) attributes {gpu.kernel, gpu.known_block_size = array<i32: 1, 1, 1>, gpu.known_grid_size = array<i32: 1, 1, 1>, nvvm.kernel} {
      %0 = llvm.mlir.constant(32 : index) : i64
      %1 = llvm.mlir.constant(64 : index) : i64
      %2 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %3 = llvm.mlir.constant(1 : index) : i64
      %4 = llvm.mlir.constant(0 : index) : i64
      %5 = llvm.mlir.addressof @__dynamic_shmem__3 : !llvm.ptr<3>
      %6 = llvm.insertvalue %5, %2[0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %7 = llvm.getelementptr %5[8192] : (!llvm.ptr<3>) -> !llvm.ptr<3>, i8
      %8 = llvm.insertvalue %7, %6[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %9 = llvm.insertvalue %4, %8[2] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %10 = llvm.insertvalue %1, %9[3, 1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %11 = llvm.insertvalue %3, %10[4, 1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %12 = llvm.insertvalue %0, %11[3, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %13 = llvm.insertvalue %1, %12[4, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %14 = builtin.unrealized_conversion_cast %13 : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> to memref<32x64xf32, #gpu.address_space<workgroup>>
      "test.use.shared.memory"(%14) : (memref<32x64xf32, #gpu.address_space<workgroup>>) -> ()
      %15 = llvm.getelementptr %5[16384] : (!llvm.ptr<3>) -> !llvm.ptr<3>, i8
      %16 = llvm.insertvalue %15, %6[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %17 = llvm.insertvalue %4, %16[2] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %18 = llvm.insertvalue %1, %17[3, 1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %19 = llvm.insertvalue %3, %18[4, 1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %20 = llvm.insertvalue %0, %19[3, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %21 = llvm.insertvalue %1, %20[4, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %22 = builtin.unrealized_conversion_cast %21 : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> to memref<32x64xf32, #gpu.address_space<workgroup>>
      "test.use.shared.memory"(%22) : (memref<32x64xf32, #gpu.address_space<workgroup>>) -> ()
      llvm.return
    }
    llvm.func @gpu_device_function() {
      %0 = llvm.mlir.constant(32 : index) : i64
      %1 = llvm.mlir.constant(64 : index) : i64
      %2 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %3 = llvm.mlir.constant(1 : index) : i64
      %4 = llvm.mlir.constant(0 : index) : i64
      %5 = llvm.mlir.addressof @__dynamic_shmem__3 : !llvm.ptr<3>
      %6 = llvm.insertvalue %5, %2[0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %7 = llvm.getelementptr %5[8192] : (!llvm.ptr<3>) -> !llvm.ptr<3>, i8
      %8 = llvm.insertvalue %7, %6[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %9 = llvm.insertvalue %4, %8[2] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %10 = llvm.insertvalue %1, %9[3, 1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %11 = llvm.insertvalue %3, %10[4, 1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %12 = llvm.insertvalue %0, %11[3, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %13 = llvm.insertvalue %1, %12[4, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %14 = builtin.unrealized_conversion_cast %13 : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> to memref<32x64xf32, #gpu.address_space<workgroup>>
      "test.use.shared.memory"(%14) : (memref<32x64xf32, #gpu.address_space<workgroup>>) -> ()
      llvm.return
    }
    llvm.func @func_device_function() attributes {llvm.emit_c_interface} {
      %0 = llvm.mlir.constant(32 : index) : i64
      %1 = llvm.mlir.constant(64 : index) : i64
      %2 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %3 = llvm.mlir.constant(1 : index) : i64
      %4 = llvm.mlir.constant(0 : index) : i64
      %5 = llvm.mlir.addressof @__dynamic_shmem__3 : !llvm.ptr<3>
      %6 = llvm.insertvalue %5, %2[0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %7 = llvm.getelementptr %5[8192] : (!llvm.ptr<3>) -> !llvm.ptr<3>, i8
      %8 = llvm.insertvalue %7, %6[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %9 = llvm.insertvalue %4, %8[2] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %10 = llvm.insertvalue %1, %9[3, 1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %11 = llvm.insertvalue %3, %10[4, 1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %12 = llvm.insertvalue %0, %11[3, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %13 = llvm.insertvalue %1, %12[4, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
      %14 = builtin.unrealized_conversion_cast %13 : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> to memref<32x64xf32, #gpu.address_space<workgroup>>
      "test.use.shared.memory"(%14) : (memref<32x64xf32, #gpu.address_space<workgroup>>) -> ()
      llvm.return
    }
    llvm.func @_mlir_ciface_func_device_function() attributes {llvm.emit_c_interface} {
      llvm.call @func_device_function() : () -> ()
      llvm.return
    }
  }
}

