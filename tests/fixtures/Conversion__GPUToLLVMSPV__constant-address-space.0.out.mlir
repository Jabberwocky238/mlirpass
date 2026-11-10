module {
  gpu.module @kernels {
    llvm.func spir_kernelcc @constant_load(%arg0: !llvm.ptr<2>, %arg1: !llvm.ptr<2>, %arg2: i32, %arg3: i32, %arg4: i32) attributes {gpu.kernel} {
      %0 = llvm.mlir.poison : !llvm.struct<(ptr<2>, ptr<2>, i32, array<1 x i32>, array<1 x i32>)>
      %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr<2>, ptr<2>, i32, array<1 x i32>, array<1 x i32>)> 
      %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr<2>, ptr<2>, i32, array<1 x i32>, array<1 x i32>)> 
      %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr<2>, ptr<2>, i32, array<1 x i32>, array<1 x i32>)> 
      %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr<2>, ptr<2>, i32, array<1 x i32>, array<1 x i32>)> 
      %5 = llvm.insertvalue %arg4, %4[4, 0] : !llvm.struct<(ptr<2>, ptr<2>, i32, array<1 x i32>, array<1 x i32>)> 
      %6 = builtin.unrealized_conversion_cast %5 : !llvm.struct<(ptr<2>, ptr<2>, i32, array<1 x i32>, array<1 x i32>)> to memref<16xf32, #gpu.address_space<constant>>
      %c0 = arith.constant 0 : index
      %7 = memref.load %6[%c0] : memref<16xf32, #gpu.address_space<constant>>
      llvm.return
    }
    llvm.func spir_funccc @all_address_spaces(%arg0: !llvm.ptr<1>, %arg1: !llvm.ptr<1>, %arg2: i32, %arg3: !llvm.ptr<3>, %arg4: !llvm.ptr<3>, %arg5: i32, %arg6: !llvm.ptr, %arg7: !llvm.ptr, %arg8: i32, %arg9: !llvm.ptr<2>, %arg10: !llvm.ptr<2>, %arg11: i32) {
      llvm.return
    }
  }
}

