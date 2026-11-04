module {
  func.func @global_load_to_rocdl_f32(%arg0: memref<128x72xf32, 1>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<128x72xf32, 1> to !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i64
    %c12 = arith.constant 12 : index
    %2 = builtin.unrealized_conversion_cast %c12 : index to i64
    %c32 = arith.constant 32 : index
    %3 = builtin.unrealized_conversion_cast %c32 : index to i64
    %alloc = memref.alloc() : memref<64x64xf32, 3>
    %4 = builtin.unrealized_conversion_cast %alloc : memref<64x64xf32, 3> to !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %5 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.mlir.constant(72 : index) : i64
    %7 = llvm.mul %2, %6 : i64
    %8 = llvm.add %7, %1 : i64
    %9 = llvm.getelementptr %5[%8] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f32
    %10 = llvm.extractvalue %4[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.mlir.constant(64 : index) : i64
    %12 = llvm.mul %3, %11 : i64
    %13 = llvm.add %12, %1 : i64
    %14 = llvm.getelementptr %10[%13] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
    rocdl.load.to.lds %9, %14, 4, 0, 0 : <1>
    return
  }
  func.func @global_load_to_rocdl_wg_mem(%arg0: memref<128x72xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<128x72xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i64
    %c12 = arith.constant 12 : index
    %2 = builtin.unrealized_conversion_cast %c12 : index to i64
    %c32 = arith.constant 32 : index
    %3 = builtin.unrealized_conversion_cast %c32 : index to i64
    %alloc = memref.alloc() : memref<64x64xf32, #gpu.address_space<workgroup>>
    %4 = builtin.unrealized_conversion_cast %alloc : memref<64x64xf32, #gpu.address_space<workgroup>> to !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %5 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.mlir.constant(72 : index) : i64
    %7 = llvm.mul %2, %6 : i64
    %8 = llvm.add %7, %1 : i64
    %9 = llvm.getelementptr %5[%8] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %10 = llvm.extractvalue %4[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.mlir.constant(64 : index) : i64
    %12 = llvm.mul %3, %11 : i64
    %13 = llvm.add %12, %1 : i64
    %14 = llvm.getelementptr %10[%13] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
    rocdl.load.to.lds %9, %14, 4, 0, 0 : !llvm.ptr
    return
  }
  func.func @global_load_to_rocdl_0d(%arg0: memref<f32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<f32> to !llvm.struct<(ptr, ptr, i64)>
    %alloc = memref.alloc() : memref<f32, #gpu.address_space<workgroup>>
    %1 = builtin.unrealized_conversion_cast %alloc : memref<f32, #gpu.address_space<workgroup>> to !llvm.struct<(ptr<3>, ptr<3>, i64)>
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(ptr<3>, ptr<3>, i64)> 
    rocdl.load.to.lds %2, %3, 4, 0, 0 : !llvm.ptr
    return
  }
  func.func @global_load_to_rocdl_i8(%arg0: memref<128x72xi8, 1>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<128x72xi8, 1> to !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i64
    %c12 = arith.constant 12 : index
    %2 = builtin.unrealized_conversion_cast %c12 : index to i64
    %c32 = arith.constant 32 : index
    %3 = builtin.unrealized_conversion_cast %c32 : index to i64
    %alloc = memref.alloc() : memref<64x64xi8, 3>
    %4 = builtin.unrealized_conversion_cast %alloc : memref<64x64xi8, 3> to !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %5 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.mlir.constant(72 : index) : i64
    %7 = llvm.mul %2, %6 : i64
    %8 = llvm.add %7, %1 : i64
    %9 = llvm.getelementptr %5[%8] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %10 = llvm.extractvalue %4[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.mlir.constant(64 : index) : i64
    %12 = llvm.mul %3, %11 : i64
    %13 = llvm.add %12, %1 : i64
    %14 = llvm.getelementptr %10[%13] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, i8
    rocdl.load.to.lds %9, %14, 1, 0, 0 : <1>
    return
  }
  func.func @global_load_to_rocdl_vec(%arg0: memref<128x72xi16, 1>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<128x72xi16, 1> to !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i64
    %c12 = arith.constant 12 : index
    %2 = builtin.unrealized_conversion_cast %c12 : index to i64
    %c32 = arith.constant 32 : index
    %3 = builtin.unrealized_conversion_cast %c32 : index to i64
    %alloc = memref.alloc() : memref<64x128xi16, 3>
    %4 = builtin.unrealized_conversion_cast %alloc : memref<64x128xi16, 3> to !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %5 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.mlir.constant(72 : index) : i64
    %7 = llvm.mul %2, %6 : i64
    %8 = llvm.add %7, %1 : i64
    %9 = llvm.getelementptr %5[%8] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i16
    %10 = llvm.extractvalue %4[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.mlir.constant(128 : index) : i64
    %12 = llvm.mul %3, %11 : i64
    %13 = llvm.add %12, %1 : i64
    %14 = llvm.getelementptr %10[%13] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, i16
    rocdl.load.to.lds %9, %14, 4, 0, 0 : <1>
    return
  }
  func.func @global_load_to_rocdl_dynamic_indices(%arg0: memref<512xi32, 1>, %arg1: index, %arg2: index) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<512xi32, 1> to !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %alloc = memref.alloc() : memref<4x64xi32, 3>
    %3 = builtin.unrealized_conversion_cast %alloc : memref<4x64xi32, 3> to !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %c0 = arith.constant 0 : index
    %4 = builtin.unrealized_conversion_cast %c0 : index to i64
    %5 = llvm.extractvalue %2[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %6 = llvm.getelementptr %5[%1] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i32
    %7 = llvm.extractvalue %3[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.mlir.constant(64 : index) : i64
    %9 = llvm.mul %0, %8 : i64
    %10 = llvm.add %9, %4 : i64
    %11 = llvm.getelementptr %7[%10] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, i32
    rocdl.load.to.lds %6, %11, 4, 0, 0 : <1>
    return
  }
  func.func @fat_buffer_load_to_rocdl_f32(%arg0: memref<128x72xf32, 7>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<128x72xf32, 7> to !llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i64
    %c12 = arith.constant 12 : index
    %2 = builtin.unrealized_conversion_cast %c12 : index to i64
    %c32 = arith.constant 32 : index
    %3 = builtin.unrealized_conversion_cast %c32 : index to i64
    %alloc = memref.alloc() : memref<64x64xf32, 3>
    %4 = builtin.unrealized_conversion_cast %alloc : memref<64x64xf32, 3> to !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %5 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.mlir.constant(72 : index) : i64
    %7 = llvm.mul %2, %6 : i64
    %8 = llvm.add %7, %1 : i64
    %9 = llvm.getelementptr %5[%8] : (!llvm.ptr<7>, i64) -> !llvm.ptr<7>, f32
    %10 = llvm.extractvalue %4[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.mlir.constant(64 : index) : i64
    %12 = llvm.mul %3, %11 : i64
    %13 = llvm.add %12, %1 : i64
    %14 = llvm.getelementptr %10[%13] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
    rocdl.load.to.lds %9, %14, 4, 0, 0 : <7>
    return
  }
}

