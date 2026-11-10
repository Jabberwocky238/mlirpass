#mmra_tag = #llvm.mmra_tag<"amdgpu-synchronize-as":"local">
module {
  func.func @fat_raw_buffer_cast(%arg0: memref<8xi32, #gpu.address_space<global>>) -> memref<8xi32, #amdgpu.address_space<fat_raw_buffer>> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<8xi32, #gpu.address_space<global>> to !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.extractvalue %0[3] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.extractvalue %0[4] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %6 = llvm.mlir.constant(0 : i16) : i16
    %7 = llvm.mlir.constant(159744 : i32) : i32
    %8 = rocdl.make.buffer.rsrc %2, %6, %1, %7 : <1> to <7>
    %9 = llvm.mlir.poison : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.insertvalue %8, %9[0] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.insertvalue %8, %10[1] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.insertvalue %3, %11[2] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.insertvalue %4, %12[3] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.insertvalue %5, %13[4] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = builtin.unrealized_conversion_cast %14 : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)> to memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>
    return %15 : memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>
  }
  func.func @fat_raw_buffer_cast_0d(%arg0: memref<i32, #gpu.address_space<global>>) -> memref<i32, #amdgpu.address_space<fat_raw_buffer>> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<i32, #gpu.address_space<global>> to !llvm.struct<(ptr<1>, ptr<1>, i64)>
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<1>, ptr<1>, i64)> 
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr<1>, ptr<1>, i64)> 
    %4 = llvm.mlir.constant(0 : i16) : i16
    %5 = llvm.mlir.constant(159744 : i32) : i32
    %6 = rocdl.make.buffer.rsrc %2, %4, %1, %5 : <1> to <7>
    %7 = llvm.mlir.poison : !llvm.struct<(ptr<7>, ptr<7>, i64)>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.struct<(ptr<7>, ptr<7>, i64)> 
    %9 = llvm.insertvalue %6, %8[1] : !llvm.struct<(ptr<7>, ptr<7>, i64)> 
    %10 = llvm.insertvalue %3, %9[2] : !llvm.struct<(ptr<7>, ptr<7>, i64)> 
    %11 = builtin.unrealized_conversion_cast %10 : !llvm.struct<(ptr<7>, ptr<7>, i64)> to memref<i32, #amdgpu.address_space<fat_raw_buffer>>
    return %11 : memref<i32, #amdgpu.address_space<fat_raw_buffer>>
  }
  func.func @fat_raw_buffer_cast_dyn_size_offset(%arg0: memref<?xi32, strided<[1], offset: ?>, #gpu.address_space<global>>) -> memref<?xi32, strided<[1], offset: ?>, #amdgpu.address_space<fat_raw_buffer>> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xi32, strided<[1], offset: ?>, #gpu.address_space<global>> to !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.extractvalue %0[3, 0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.mul %1, %2 : i64
    %4 = llvm.mlir.constant(4 : i64) : i64
    %5 = llvm.mul %3, %4 : i64
    %6 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %7 = llvm.extractvalue %0[2] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %8 = llvm.extractvalue %0[3] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.extractvalue %0[4] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.mlir.constant(0 : i16) : i16
    %11 = llvm.mlir.constant(159744 : i32) : i32
    %12 = rocdl.make.buffer.rsrc %6, %10, %5, %11 : <1> to <7>
    %13 = llvm.mlir.poison : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %14 = llvm.insertvalue %12, %13[0] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.insertvalue %12, %14[1] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.insertvalue %7, %15[2] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)> 
    %17 = llvm.insertvalue %8, %16[3] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)> 
    %18 = llvm.insertvalue %9, %17[4] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)> 
    %19 = builtin.unrealized_conversion_cast %18 : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)> to memref<?xi32, strided<[1], offset: ?>, #amdgpu.address_space<fat_raw_buffer>>
    return %19 : memref<?xi32, strided<[1], offset: ?>, #amdgpu.address_space<fat_raw_buffer>>
  }
  func.func @fat_raw_buffer_cast_reset_offset(%arg0: memref<?xi32, strided<[1], offset: ?>, #gpu.address_space<global>>) -> memref<?xi32, #amdgpu.address_space<fat_raw_buffer>> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xi32, strided<[1], offset: ?>, #gpu.address_space<global>> to !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.extractvalue %0[3, 0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.mul %1, %2 : i64
    %4 = llvm.mlir.constant(4 : i64) : i64
    %5 = llvm.mul %3, %4 : i64
    %6 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %7 = llvm.extractvalue %0[2] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %8 = llvm.getelementptr %6[%7] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i32
    %9 = llvm.mlir.constant(0 : index) : i64
    %10 = llvm.extractvalue %0[3] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.extractvalue %0[4] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.mlir.constant(0 : i16) : i16
    %13 = llvm.mlir.constant(159744 : i32) : i32
    %14 = rocdl.make.buffer.rsrc %8, %12, %5, %13 : <1> to <7>
    %15 = llvm.mlir.poison : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %16 = llvm.insertvalue %14, %15[0] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)> 
    %17 = llvm.insertvalue %14, %16[1] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)> 
    %18 = llvm.insertvalue %9, %17[2] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)> 
    %19 = llvm.insertvalue %10, %18[3] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)> 
    %20 = llvm.insertvalue %11, %19[4] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)> 
    %21 = builtin.unrealized_conversion_cast %20 : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)> to memref<?xi32, #amdgpu.address_space<fat_raw_buffer>>
    return %21 : memref<?xi32, #amdgpu.address_space<fat_raw_buffer>>
  }
  func.func @fat_raw_buffer_cast_valid_bytes(%arg0: memref<8xi32, #gpu.address_space<global>>) -> memref<8xi32, #amdgpu.address_space<fat_raw_buffer>> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<8xi32, #gpu.address_space<global>> to !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %c-1_i64 = arith.constant -1 : i64
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.extractvalue %0[2] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.extractvalue %0[3] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.extractvalue %0[4] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.mlir.constant(0 : i16) : i16
    %6 = llvm.mlir.constant(159744 : i32) : i32
    %7 = rocdl.make.buffer.rsrc %1, %5, %c-1_i64, %6 : <1> to <7>
    %8 = llvm.mlir.poison : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.insertvalue %7, %9[1] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.insertvalue %2, %10[2] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.insertvalue %3, %11[3] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.insertvalue %4, %12[4] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = builtin.unrealized_conversion_cast %13 : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)> to memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>
    return %14 : memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>
  }
  func.func @fat_raw_buffer_cast_bounds_check(%arg0: memref<8xi32, #gpu.address_space<global>>) -> memref<8xi32, #amdgpu.address_space<fat_raw_buffer>> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<8xi32, #gpu.address_space<global>> to !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.extractvalue %0[3] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.extractvalue %0[4] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %6 = llvm.mlir.constant(0 : i16) : i16
    %7 = llvm.mlir.constant(159744 : i32) : i32
    %8 = rocdl.make.buffer.rsrc %2, %6, %1, %7 : <1> to <7>
    %9 = llvm.mlir.poison : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.insertvalue %8, %9[0] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.insertvalue %8, %10[1] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.insertvalue %3, %11[2] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.insertvalue %4, %12[3] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.insertvalue %5, %13[4] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = builtin.unrealized_conversion_cast %14 : !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)> to memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>
    return %15 : memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>
  }
  func.func @fat_raw_buffer_cast_cache_swizzle(%arg0: memref<64x64xi32, #gpu.address_space<global>>, %arg1: i14) -> memref<64x64xi32, #amdgpu.address_space<fat_raw_buffer>> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<64x64xi32, #gpu.address_space<global>> to !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.mlir.constant(16384 : i64) : i64
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.extractvalue %0[3] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.extractvalue %0[4] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.zext %arg1 : i14 to i16
    %7 = llvm.mlir.constant(16384 : i16) : i16
    %8 = llvm.or disjoint %6, %7 : i16
    %9 = llvm.mlir.constant(159744 : i32) : i32
    %10 = rocdl.make.buffer.rsrc %2, %8, %1, %9 : <1> to <7>
    %11 = llvm.mlir.poison : !llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>
    %12 = llvm.insertvalue %10, %11[0] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.insertvalue %10, %12[1] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = llvm.insertvalue %3, %13[2] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)> 
    %15 = llvm.insertvalue %4, %14[3] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)> 
    %16 = llvm.insertvalue %5, %15[4] : !llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)> 
    %17 = builtin.unrealized_conversion_cast %16 : !llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)> to memref<64x64xi32, #amdgpu.address_space<fat_raw_buffer>>
    return %17 : memref<64x64xi32, #amdgpu.address_space<fat_raw_buffer>>
  }
  func.func @gpu_gcn_raw_buffer_load_scalar_i32(%arg0: memref<i32>) -> i32 {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<i32> to !llvm.struct<(ptr, ptr, i64)>
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64)> 
    %3 = llvm.mlir.constant(4 : i64) : i64
    %4 = llvm.mlir.constant(0 : i16) : i16
    %5 = llvm.mlir.constant(159744 : i32) : i32
    %6 = rocdl.make.buffer.rsrc %2, %4, %3, %5 : !llvm.ptr to <8>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.mul %7, %1 : i32
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.mul %9, %1 : i32
    %11 = rocdl.raw.ptr.buffer.load %6, %8, %10, 0 : i32
    return %11 : i32
  }
  func.func @gpu_gcn_raw_buffer_load_i32(%arg0: memref<64xi32>, %arg1: i32) -> i32 {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<64xi32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.mlir.constant(256 : i64) : i64
    %4 = llvm.mlir.constant(0 : i16) : i16
    %5 = llvm.mlir.constant(159744 : i32) : i32
    %6 = rocdl.make.buffer.rsrc %2, %4, %3, %5 : !llvm.ptr to <8>
    %7 = llvm.mul %arg1, %1 : i32
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mul %8, %1 : i32
    %10 = rocdl.raw.ptr.buffer.load %6, %7, %9, 0 : i32
    return %10 : i32
  }
  func.func @gpu_gcn_raw_buffer_load_i32_strided(%arg0: memref<16x16xi32, strided<[?, ?], offset: ?>>, %arg1: i32, %arg2: i32) -> i32 {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<16x16xi32, strided<[?, ?], offset: ?>> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %5 = llvm.extractvalue %0[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.mul %5, %6 : i64
    %8 = llvm.extractvalue %0[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %9 = llvm.extractvalue %0[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %10 = llvm.mul %8, %9 : i64
    %11 = llvm.intr.umax(%7, %10) : (i64, i64) -> i64
    %12 = llvm.mlir.constant(4 : i64) : i64
    %13 = llvm.mul %11, %12 : i64
    %14 = llvm.mlir.constant(0 : i16) : i16
    %15 = llvm.mlir.constant(159744 : i32) : i32
    %16 = rocdl.make.buffer.rsrc %4, %14, %13, %15 : !llvm.ptr to <8>
    %17 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %18 = llvm.trunc %17 : i64 to i32
    %19 = llvm.mul %arg1, %18 : i32
    %20 = llvm.extractvalue %0[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %21 = llvm.trunc %20 : i64 to i32
    %22 = llvm.mul %arg2, %21 : i32
    %23 = llvm.add %19, %22 : i32
    %24 = llvm.mul %23, %1 : i32
    %25 = llvm.mlir.constant(0 : i32) : i32
    %26 = llvm.mul %25, %1 : i32
    %27 = rocdl.raw.ptr.buffer.load %16, %24, %26, 0 : i32
    return %27 : i32
  }
  func.func @gpu_gcn_raw_buffer_load_i32_oob_off(%arg0: memref<64xi32>, %arg1: i32) -> i32 {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<64xi32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.mlir.constant(256 : i64) : i64
    %4 = llvm.mlir.constant(0 : i16) : i16
    %5 = llvm.mlir.constant(159744 : i32) : i32
    %6 = rocdl.make.buffer.rsrc %2, %4, %3, %5 : !llvm.ptr to <8>
    %7 = llvm.mul %arg1, %1 : i32
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mul %8, %1 : i32
    %10 = rocdl.raw.ptr.buffer.load %6, %7, %9, 0 : i32
    return %10 : i32
  }
  func.func @gpu_gcn_raw_buffer_load_1xi32(%arg0: memref<64xi32>, %arg1: i32) -> vector<1xi32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<64xi32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.mlir.constant(256 : i64) : i64
    %4 = llvm.mlir.constant(0 : i16) : i16
    %5 = llvm.mlir.constant(159744 : i32) : i32
    %6 = rocdl.make.buffer.rsrc %2, %4, %3, %5 : !llvm.ptr to <8>
    %7 = llvm.mul %arg1, %1 : i32
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mul %8, %1 : i32
    %10 = rocdl.raw.ptr.buffer.load %6, %7, %9, 0 : i32
    %11 = llvm.bitcast %10 : i32 to vector<1xi32>
    return %11 : vector<1xi32>
  }
  func.func @gpu_gcn_raw_buffer_load_2xi32(%arg0: memref<64xi32>, %arg1: i32) -> vector<2xi32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<64xi32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.mlir.constant(256 : i64) : i64
    %4 = llvm.mlir.constant(0 : i16) : i16
    %5 = llvm.mlir.constant(159744 : i32) : i32
    %6 = rocdl.make.buffer.rsrc %2, %4, %3, %5 : !llvm.ptr to <8>
    %7 = llvm.mul %arg1, %1 : i32
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mul %8, %1 : i32
    %10 = rocdl.raw.ptr.buffer.load %6, %7, %9, 0 : vector<2xi32>
    return %10 : vector<2xi32>
  }
  func.func @gpu_gcn_raw_buffer_load_i8(%arg0: memref<64xi8>, %arg1: i32) -> i8 {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<64xi8> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.mlir.constant(64 : i64) : i64
    %4 = llvm.mlir.constant(0 : i16) : i16
    %5 = llvm.mlir.constant(159744 : i32) : i32
    %6 = rocdl.make.buffer.rsrc %2, %4, %3, %5 : !llvm.ptr to <8>
    %7 = llvm.mul %arg1, %1 : i32
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mul %8, %1 : i32
    %10 = rocdl.raw.ptr.buffer.load %6, %7, %9, 0 : i8
    return %10 : i8
  }
  func.func @gpu_gcn_raw_buffer_load_2xi8(%arg0: memref<64xi8>, %arg1: i32) -> vector<2xi8> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<64xi8> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.mlir.constant(64 : i64) : i64
    %4 = llvm.mlir.constant(0 : i16) : i16
    %5 = llvm.mlir.constant(159744 : i32) : i32
    %6 = rocdl.make.buffer.rsrc %2, %4, %3, %5 : !llvm.ptr to <8>
    %7 = llvm.mul %arg1, %1 : i32
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mul %8, %1 : i32
    %10 = rocdl.raw.ptr.buffer.load %6, %7, %9, 0 : i16
    %11 = llvm.bitcast %10 : i16 to vector<2xi8>
    return %11 : vector<2xi8>
  }
  func.func @gpu_gcn_raw_buffer_load_16xi8(%arg0: memref<64xi8>, %arg1: i32) -> vector<16xi8> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<64xi8> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.mlir.constant(64 : i64) : i64
    %4 = llvm.mlir.constant(0 : i16) : i16
    %5 = llvm.mlir.constant(159744 : i32) : i32
    %6 = rocdl.make.buffer.rsrc %2, %4, %3, %5 : !llvm.ptr to <8>
    %7 = llvm.mul %arg1, %1 : i32
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mul %8, %1 : i32
    %10 = rocdl.raw.ptr.buffer.load %6, %7, %9, 0 : vector<4xi32>
    %11 = llvm.bitcast %10 : vector<4xi32> to vector<16xi8>
    return %11 : vector<16xi8>
  }
  func.func @gpu_gcn_raw_buffer_load_f8E5M2FNUZ(%arg0: memref<64xf8E5M2FNUZ>, %arg1: i32) -> f8E5M2FNUZ {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<64xf8E5M2FNUZ> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.mlir.constant(64 : i64) : i64
    %4 = llvm.mlir.constant(0 : i16) : i16
    %5 = llvm.mlir.constant(159744 : i32) : i32
    %6 = rocdl.make.buffer.rsrc %2, %4, %3, %5 : !llvm.ptr to <8>
    %7 = llvm.mul %arg1, %1 : i32
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mul %8, %1 : i32
    %10 = rocdl.raw.ptr.buffer.load %6, %7, %9, 0 : i8
    %11 = builtin.unrealized_conversion_cast %10 : i8 to f8E5M2FNUZ
    return %11 : f8E5M2FNUZ
  }
  func.func @gpu_gcn_raw_buffer_load_4xf8E4M3FNUZ(%arg0: memref<64xf8E4M3FNUZ>, %arg1: i32) -> vector<4xf8E4M3FNUZ> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<64xf8E4M3FNUZ> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.mlir.constant(64 : i64) : i64
    %4 = llvm.mlir.constant(0 : i16) : i16
    %5 = llvm.mlir.constant(159744 : i32) : i32
    %6 = rocdl.make.buffer.rsrc %2, %4, %3, %5 : !llvm.ptr to <8>
    %7 = llvm.mul %arg1, %1 : i32
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mul %8, %1 : i32
    %10 = rocdl.raw.ptr.buffer.load %6, %7, %9, 0 : i32
    %11 = llvm.bitcast %10 : i32 to vector<4xi8>
    %12 = builtin.unrealized_conversion_cast %11 : vector<4xi8> to vector<4xf8E4M3FNUZ>
    return %12 : vector<4xf8E4M3FNUZ>
  }
  func.func @gpu_gcn_raw_buffer_store_scalar_i32(%arg0: i32, %arg1: memref<i32>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<i32> to !llvm.struct<(ptr, ptr, i64)>
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64)> 
    %3 = llvm.mlir.constant(4 : i64) : i64
    %4 = llvm.mlir.constant(0 : i16) : i16
    %5 = llvm.mlir.constant(159744 : i32) : i32
    %6 = rocdl.make.buffer.rsrc %2, %4, %3, %5 : !llvm.ptr to <8>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.mul %7, %1 : i32
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.mul %9, %1 : i32
    rocdl.raw.ptr.buffer.store %arg0, %6, %8, %10, 0 : i32
    return
  }
  func.func @gpu_gcn_raw_buffer_store_i32(%arg0: i32, %arg1: memref<64xi32>, %arg2: i32) {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<64xi32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.mlir.constant(256 : i64) : i64
    %4 = llvm.mlir.constant(0 : i16) : i16
    %5 = llvm.mlir.constant(159744 : i32) : i32
    %6 = rocdl.make.buffer.rsrc %2, %4, %3, %5 : !llvm.ptr to <8>
    %7 = llvm.mul %arg2, %1 : i32
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mul %8, %1 : i32
    rocdl.raw.ptr.buffer.store %arg0, %6, %7, %9, 0 : i32
    return
  }
  func.func @gpu_gcn_raw_buffer_store_1xf32(%arg0: vector<1xf32>, %arg1: memref<64xf32>, %arg2: i32) {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<64xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.bitcast %arg0 : vector<1xf32> to f32
    %3 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.mlir.constant(256 : i64) : i64
    %5 = llvm.mlir.constant(0 : i16) : i16
    %6 = llvm.mlir.constant(159744 : i32) : i32
    %7 = rocdl.make.buffer.rsrc %3, %5, %4, %6 : !llvm.ptr to <8>
    %8 = llvm.mul %arg2, %1 : i32
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.mul %9, %1 : i32
    rocdl.raw.ptr.buffer.store %2, %7, %8, %10, 0 : f32
    return
  }
  func.func @gpu_gcn_raw_buffer_store_2xi8(%arg0: vector<2xi8>, %arg1: memref<64xi8>, %arg2: i32) {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<64xi8> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.bitcast %arg0 : vector<2xi8> to i16
    %3 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.mlir.constant(64 : i64) : i64
    %5 = llvm.mlir.constant(0 : i16) : i16
    %6 = llvm.mlir.constant(159744 : i32) : i32
    %7 = rocdl.make.buffer.rsrc %3, %5, %4, %6 : !llvm.ptr to <8>
    %8 = llvm.mul %arg2, %1 : i32
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.mul %9, %1 : i32
    rocdl.raw.ptr.buffer.store %2, %7, %8, %10, 0 : i16
    return
  }
  func.func @gpu_gcn_raw_buffer_store_16xi8(%arg0: vector<16xi8>, %arg1: memref<64xi8>, %arg2: i32) {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<64xi8> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.bitcast %arg0 : vector<16xi8> to vector<4xi32>
    %3 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.mlir.constant(64 : i64) : i64
    %5 = llvm.mlir.constant(0 : i16) : i16
    %6 = llvm.mlir.constant(159744 : i32) : i32
    %7 = rocdl.make.buffer.rsrc %3, %5, %4, %6 : !llvm.ptr to <8>
    %8 = llvm.mul %arg2, %1 : i32
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.mul %9, %1 : i32
    rocdl.raw.ptr.buffer.store %2, %7, %8, %10, 0 : vector<4xi32>
    return
  }
  func.func @gpu_gcn_raw_buffer_atomic_fadd_f32(%arg0: f32, %arg1: memref<64xf32>, %arg2: i32) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<64xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.mlir.constant(256 : i64) : i64
    %4 = llvm.mlir.constant(0 : i16) : i16
    %5 = llvm.mlir.constant(159744 : i32) : i32
    %6 = rocdl.make.buffer.rsrc %2, %4, %3, %5 : !llvm.ptr to <8>
    %7 = llvm.mul %arg2, %1 : i32
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mul %8, %1 : i32
    %10 = rocdl.raw.ptr.buffer.atomic.fadd %arg0, %6, %7, %9, 0 : f32
    return %10 : f32
  }
  func.func @gpu_gcn_raw_buffer_atomic_fadd_v2f16(%arg0: vector<2xf16>, %arg1: memref<64xf16>, %arg2: i32) -> vector<2xf16> {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<64xf16> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.mlir.constant(128 : i64) : i64
    %4 = llvm.mlir.constant(0 : i16) : i16
    %5 = llvm.mlir.constant(159744 : i32) : i32
    %6 = rocdl.make.buffer.rsrc %2, %4, %3, %5 : !llvm.ptr to <8>
    %7 = llvm.mul %arg2, %1 : i32
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mul %8, %1 : i32
    %10 = rocdl.raw.ptr.buffer.atomic.fadd %arg0, %6, %7, %9, 0 : vector<2xf16>
    return %10 : vector<2xf16>
  }
  func.func @gpu_gcn_raw_buffer_atomic_fadd_v2bf16(%arg0: vector<2xbf16>, %arg1: memref<64xbf16>, %arg2: i32) -> vector<2xbf16> {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<64xbf16> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.mlir.constant(128 : i64) : i64
    %4 = llvm.mlir.constant(0 : i16) : i16
    %5 = llvm.mlir.constant(159744 : i32) : i32
    %6 = rocdl.make.buffer.rsrc %2, %4, %3, %5 : !llvm.ptr to <8>
    %7 = llvm.mul %arg2, %1 : i32
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mul %8, %1 : i32
    %10 = rocdl.raw.ptr.buffer.atomic.fadd %arg0, %6, %7, %9, 0 : vector<2xbf16>
    return %10 : vector<2xbf16>
  }
  func.func @gpu_gcn_raw_buffer_atomic_fmax_f32(%arg0: f32, %arg1: memref<64xf32>, %arg2: i32) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<64xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.mlir.constant(256 : i64) : i64
    %4 = llvm.mlir.constant(0 : i16) : i16
    %5 = llvm.mlir.constant(159744 : i32) : i32
    %6 = rocdl.make.buffer.rsrc %2, %4, %3, %5 : !llvm.ptr to <8>
    %7 = llvm.mul %arg2, %1 : i32
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mul %8, %1 : i32
    %10 = rocdl.raw.ptr.buffer.atomic.fmax %arg0, %6, %7, %9, 0 : f32
    return %10 : f32
  }
  func.func @gpu_gcn_raw_buffer_atomic_smax_i32(%arg0: i32, %arg1: memref<64xi32>, %arg2: i32) -> i32 {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<64xi32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.mlir.constant(256 : i64) : i64
    %4 = llvm.mlir.constant(0 : i16) : i16
    %5 = llvm.mlir.constant(159744 : i32) : i32
    %6 = rocdl.make.buffer.rsrc %2, %4, %3, %5 : !llvm.ptr to <8>
    %7 = llvm.mul %arg2, %1 : i32
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mul %8, %1 : i32
    %10 = rocdl.raw.ptr.buffer.atomic.smax %arg0, %6, %7, %9, 0 : i32
    return %10 : i32
  }
  func.func @gpu_gcn_raw_buffer_atomic_umin_i32(%arg0: i32, %arg1: memref<64xi32>, %arg2: i32) -> i32 {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<64xi32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.mlir.constant(256 : i64) : i64
    %4 = llvm.mlir.constant(0 : i16) : i16
    %5 = llvm.mlir.constant(159744 : i32) : i32
    %6 = rocdl.make.buffer.rsrc %2, %4, %3, %5 : !llvm.ptr to <8>
    %7 = llvm.mul %arg2, %1 : i32
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mul %8, %1 : i32
    %10 = rocdl.raw.ptr.buffer.atomic.umin %arg0, %6, %7, %9, 0 : i32
    return %10 : i32
  }
  func.func @amdgpu_raw_buffer_atomic_cmpswap_f32(%arg0: f32, %arg1: f32, %arg2: memref<64xf32>, %arg3: i32) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg2 : memref<64xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.bitcast %arg0 : f32 to i32
    %3 = llvm.bitcast %arg1 : f32 to i32
    %4 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.mlir.constant(256 : i64) : i64
    %6 = llvm.mlir.constant(0 : i16) : i16
    %7 = llvm.mlir.constant(159744 : i32) : i32
    %8 = rocdl.make.buffer.rsrc %4, %6, %5, %7 : !llvm.ptr to <8>
    %9 = llvm.mul %arg3, %1 : i32
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.mul %10, %1 : i32
    %12 = rocdl.raw.ptr.buffer.atomic.cmpswap %2, %3, %8, %9, %11, 0 : i32
    %13 = llvm.bitcast %12 : i32 to f32
    return %13 : f32
  }
  func.func @amdgpu_raw_buffer_atomic_cmpswap_i64(%arg0: i64, %arg1: i64, %arg2: memref<64xi64>, %arg3: i32) -> i64 {
    %0 = builtin.unrealized_conversion_cast %arg2 : memref<64xi64> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.mlir.constant(512 : i64) : i64
    %4 = llvm.mlir.constant(0 : i16) : i16
    %5 = llvm.mlir.constant(159744 : i32) : i32
    %6 = rocdl.make.buffer.rsrc %2, %4, %3, %5 : !llvm.ptr to <8>
    %7 = llvm.mul %arg3, %1 : i32
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mul %8, %1 : i32
    %10 = rocdl.raw.ptr.buffer.atomic.cmpswap %arg0, %arg1, %6, %7, %9, 0 : i64
    return %10 : i64
  }
  func.func @amdgpu_raw_buffer_atomic_cmpswap_v2f16(%arg0: vector<2xf16>, %arg1: vector<2xf16>, %arg2: memref<64xf16>, %arg3: i32) -> vector<2xf16> {
    %0 = builtin.unrealized_conversion_cast %arg2 : memref<64xf16> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.bitcast %arg0 : vector<2xf16> to i32
    %3 = llvm.bitcast %arg1 : vector<2xf16> to i32
    %4 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.mlir.constant(128 : i64) : i64
    %6 = llvm.mlir.constant(0 : i16) : i16
    %7 = llvm.mlir.constant(159744 : i32) : i32
    %8 = rocdl.make.buffer.rsrc %4, %6, %5, %7 : !llvm.ptr to <8>
    %9 = llvm.mul %arg3, %1 : i32
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.mul %10, %1 : i32
    %12 = rocdl.raw.ptr.buffer.atomic.cmpswap %2, %3, %8, %9, %11, 0 : i32
    %13 = llvm.bitcast %12 : i32 to vector<2xf16>
    return %13 : vector<2xf16>
  }
  func.func @lds_barrier() {
    llvm.fence syncscope("workgroup") release {llvm.mmra = #mmra_tag}
    rocdl.s.barrier
    llvm.fence syncscope("workgroup") acquire {llvm.mmra = #mmra_tag}
    return
  }
  func.func @sched_barrier() {
    rocdl.sched.barrier none
    rocdl.sched.barrier non_mem_non_sideeffect
    rocdl.sched.barrier valu|all_vmem
    rocdl.sched.barrier all
    return
  }
}

