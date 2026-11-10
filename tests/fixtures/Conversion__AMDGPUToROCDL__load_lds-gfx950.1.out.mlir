module {
  func.func @fat_buffer_load_to_rocdl_f96(%arg0: memref<128x72xf32, #amdgpu.address_space<fat_raw_buffer>>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<128x72xf32, #amdgpu.address_space<fat_raw_buffer>> to !llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i64
    %c12 = arith.constant 12 : index
    %2 = builtin.unrealized_conversion_cast %c12 : index to i64
    %c32 = arith.constant 32 : index
    %3 = builtin.unrealized_conversion_cast %c32 : index to i64
    %alloc = memref.alloc() : memref<64x64xf32, #gpu.address_space<workgroup>>
    %4 = builtin.unrealized_conversion_cast %alloc : memref<64x64xf32, #gpu.address_space<workgroup>> to !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
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
    rocdl.load.to.lds %9, %14, 12, 0, 0 : <7>
    return
  }
}

// -----
module {
  func.func @fat_buffer_load_to_rocdl_f128(%arg0: memref<128x72xf32, #amdgpu.address_space<fat_raw_buffer>>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<128x72xf32, #amdgpu.address_space<fat_raw_buffer>> to !llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i64
    %c12 = arith.constant 12 : index
    %2 = builtin.unrealized_conversion_cast %c12 : index to i64
    %c32 = arith.constant 32 : index
    %3 = builtin.unrealized_conversion_cast %c32 : index to i64
    %alloc = memref.alloc() : memref<64x64xf32, #gpu.address_space<workgroup>>
    %4 = builtin.unrealized_conversion_cast %alloc : memref<64x64xf32, #gpu.address_space<workgroup>> to !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
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
    rocdl.load.to.lds %9, %14, 16, 0, 0 : <7>
    return
  }
}

