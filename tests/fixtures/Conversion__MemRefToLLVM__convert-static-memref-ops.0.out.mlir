module {
  llvm.func @malloc(i64) -> !llvm.ptr
  func.func @zero_d_alloc() -> memref<f32> {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.getelementptr %1[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i64
    %4 = llvm.call @malloc(%3) : (i64) -> !llvm.ptr
    %5 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64)>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.struct<(ptr, ptr, i64)> 
    %7 = llvm.insertvalue %4, %6[1] : !llvm.struct<(ptr, ptr, i64)> 
    %8 = llvm.mlir.constant(0 : index) : i64
    %9 = llvm.insertvalue %8, %7[2] : !llvm.struct<(ptr, ptr, i64)> 
    %10 = builtin.unrealized_conversion_cast %9 : !llvm.struct<(ptr, ptr, i64)> to memref<f32>
    return %10 : memref<f32>
  }
}

// -----
module {
  llvm.func @free(!llvm.ptr)
  func.func @zero_d_dealloc(%arg0: memref<f32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<f32> to !llvm.struct<(ptr, ptr, i64)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i64)> 
    llvm.call @free(%1) : (!llvm.ptr) -> ()
    return
  }
}

// -----
module {
  llvm.func @malloc(i64) -> !llvm.ptr
  func.func @aligned_1d_alloc() -> memref<42xf32> {
    %0 = llvm.mlir.constant(42 : index) : i64
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i64
    %5 = llvm.mlir.constant(8 : index) : i64
    %6 = llvm.add %4, %5 : i64
    %7 = llvm.call @malloc(%6) : (i64) -> !llvm.ptr
    %8 = llvm.ptrtoint %7 : !llvm.ptr to i64
    %9 = llvm.mlir.constant(1 : index) : i64
    %10 = llvm.sub %5, %9 : i64
    %11 = llvm.add %8, %10 : i64
    %12 = llvm.urem %11, %5 : i64
    %13 = llvm.sub %11, %12 : i64
    %14 = llvm.inttoptr %13 : i64 to !llvm.ptr
    %15 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %16 = llvm.insertvalue %7, %15[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %17 = llvm.insertvalue %14, %16[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %18 = llvm.mlir.constant(0 : index) : i64
    %19 = llvm.insertvalue %18, %17[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %20 = llvm.insertvalue %0, %19[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %21 = llvm.insertvalue %1, %20[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %22 = builtin.unrealized_conversion_cast %21 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<42xf32>
    return %22 : memref<42xf32>
  }
}

// -----
module {
  llvm.func @malloc(i64) -> !llvm.ptr
  func.func @static_alloc() -> memref<32x18xf32> {
    %0 = llvm.mlir.constant(32 : index) : i64
    %1 = llvm.mlir.constant(18 : index) : i64
    %2 = llvm.mlir.constant(1 : index) : i64
    %3 = llvm.mlir.constant(576 : index) : i64
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.getelementptr %4[%3] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %6 = llvm.ptrtoint %5 : !llvm.ptr to i64
    %7 = llvm.call @malloc(%6) : (i64) -> !llvm.ptr
    %8 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %10 = llvm.insertvalue %7, %9[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.mlir.constant(0 : index) : i64
    %12 = llvm.insertvalue %11, %10[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.insertvalue %0, %12[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = llvm.insertvalue %1, %13[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %15 = llvm.insertvalue %1, %14[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %16 = llvm.insertvalue %2, %15[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %17 = builtin.unrealized_conversion_cast %16 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> to memref<32x18xf32>
    return %17 : memref<32x18xf32>
  }
}

// -----
module {
  func.func @static_alloca() -> memref<32x18xf32> {
    %0 = llvm.mlir.constant(32 : index) : i64
    %1 = llvm.mlir.constant(18 : index) : i64
    %2 = llvm.mlir.constant(1 : index) : i64
    %3 = llvm.mlir.constant(576 : index) : i64
    %4 = llvm.alloca %3 x f32 : (i64) -> !llvm.ptr
    %5 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.insertvalue %4, %6[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.mlir.constant(0 : index) : i64
    %9 = llvm.insertvalue %8, %7[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %10 = llvm.insertvalue %0, %9[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.insertvalue %1, %10[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %12 = llvm.insertvalue %1, %11[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.insertvalue %2, %12[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = builtin.unrealized_conversion_cast %13 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> to memref<32x18xf32>
    %15 = llvm.mlir.constant(32 : index) : i64
    %16 = llvm.mlir.constant(18 : index) : i64
    %17 = llvm.mlir.constant(1 : index) : i64
    %18 = llvm.mlir.constant(576 : index) : i64
    %19 = llvm.alloca %18 x f32 {alignment = 32 : i64} : (i64) -> !llvm.ptr
    %20 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %21 = llvm.insertvalue %19, %20[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %22 = llvm.insertvalue %19, %21[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %23 = llvm.mlir.constant(0 : index) : i64
    %24 = llvm.insertvalue %23, %22[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %25 = llvm.insertvalue %15, %24[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %26 = llvm.insertvalue %16, %25[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %27 = llvm.insertvalue %16, %26[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %28 = llvm.insertvalue %17, %27[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    return %14 : memref<32x18xf32>
  }
}

// -----
module {
  func.func @static_alloca_zero() -> memref<32x0x18xf32> {
    %0 = llvm.mlir.constant(32 : index) : i64
    %1 = llvm.mlir.constant(0 : index) : i64
    %2 = llvm.mlir.constant(18 : index) : i64
    %3 = llvm.mlir.constant(1 : index) : i64
    %4 = llvm.mlir.constant(0 : index) : i64
    %5 = llvm.mlir.constant(0 : index) : i64
    %6 = llvm.alloca %5 x f32 : (i64) -> !llvm.ptr
    %7 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %9 = llvm.insertvalue %6, %8[1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %10 = llvm.mlir.constant(0 : index) : i64
    %11 = llvm.insertvalue %10, %9[2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %12 = llvm.insertvalue %0, %11[3, 0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %13 = llvm.insertvalue %1, %12[3, 1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %14 = llvm.insertvalue %2, %13[3, 2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %15 = llvm.insertvalue %4, %14[4, 0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %16 = llvm.insertvalue %2, %15[4, 1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %17 = llvm.insertvalue %3, %16[4, 2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %18 = builtin.unrealized_conversion_cast %17 : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> to memref<32x0x18xf32>
    return %18 : memref<32x0x18xf32>
  }
}

// -----
module {
  llvm.func @free(!llvm.ptr)
  func.func @static_dealloc(%arg0: memref<10x8xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<10x8xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%1) : (!llvm.ptr) -> ()
    return
  }
}

// -----
module {
  func.func @zero_d_load(%arg0: memref<f32>) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<f32> to !llvm.struct<(ptr, ptr, i64)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64)> 
    %2 = llvm.load %1 : !llvm.ptr -> f32
    return %2 : f32
  }
}

// -----
module {
  func.func @static_load(%arg0: memref<10x42xf32>, %arg1: index, %arg2: index) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<10x42xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(42 : index) : i64
    %5 = llvm.mul %1, %4 overflow<nsw, nuw> : i64
    %6 = llvm.add %5, %0 overflow<nsw, nuw> : i64
    %7 = llvm.getelementptr inbounds|nuw %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %8 = llvm.load %7 : !llvm.ptr -> f32
    return
  }
}

// -----
module {
  func.func @zero_d_store(%arg0: memref<f32>, %arg1: f32) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<f32> to !llvm.struct<(ptr, ptr, i64)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64)> 
    llvm.store %arg1, %1 : f32, !llvm.ptr
    return
  }
}

// -----
module {
  func.func @static_store(%arg0: memref<10x42xf32>, %arg1: index, %arg2: index, %arg3: f32) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<10x42xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(42 : index) : i64
    %5 = llvm.mul %1, %4 overflow<nsw, nuw> : i64
    %6 = llvm.add %5, %0 overflow<nsw, nuw> : i64
    %7 = llvm.getelementptr inbounds|nuw %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %arg3, %7 : f32, !llvm.ptr
    return
  }
}

// -----
module {
  func.func @static_memref_dim(%arg0: memref<42x32x15x13x27xf32>) {
    %c0 = arith.constant 0 : index
    %0 = llvm.mlir.constant(42 : index) : i64
    %c1 = arith.constant 1 : index
    %1 = llvm.mlir.constant(32 : index) : i64
    %c2 = arith.constant 2 : index
    %2 = llvm.mlir.constant(15 : index) : i64
    %c3 = arith.constant 3 : index
    %3 = llvm.mlir.constant(13 : index) : i64
    %c4 = arith.constant 4 : index
    %4 = llvm.mlir.constant(27 : index) : i64
    return
  }
}

// -----
module {
  func.func @static_out_of_bound_memref_dim(%arg0: memref<42x32x15x13x27xf32>) -> index {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<42x32x15x13x27xf32> to !llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>
    %c-7 = arith.constant -7 : index
    %1 = builtin.unrealized_conversion_cast %c-7 : index to i64
    %2 = llvm.mlir.constant(1 : index) : i64
    %3 = llvm.extractvalue %0[3] : !llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)> 
    %4 = llvm.alloca %2 x !llvm.array<5 x i64> : (i64) -> !llvm.ptr
    llvm.store %3, %4 : !llvm.array<5 x i64>, !llvm.ptr
    %5 = llvm.getelementptr %4[0, %1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.array<5 x i64>
    %6 = llvm.load %5 : !llvm.ptr -> i64
    %7 = builtin.unrealized_conversion_cast %6 : i64 to index
    return %7 : index
  }
}

// -----
module attributes {dlti.dl_spec = #dlti.dl_spec<index = 32 : i64>} {
  llvm.func @malloc(i32) -> !llvm.ptr
  func.func @address() {
    %c1 = arith.constant 1 : index
    %0 = builtin.unrealized_conversion_cast %c1 : index to i32
    %1 = llvm.mlir.constant(1 : index) : i32
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i32) -> !llvm.ptr, vector<2xf32>
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i32
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.getelementptr %5[1] : (!llvm.ptr) -> !llvm.ptr, vector<2xf32>
    %7 = llvm.ptrtoint %6 : !llvm.ptr to i32
    %8 = llvm.add %4, %7 : i32
    %9 = llvm.call @malloc(%8) : (i32) -> !llvm.ptr
    %10 = llvm.ptrtoint %9 : !llvm.ptr to i32
    %11 = llvm.mlir.constant(1 : index) : i32
    %12 = llvm.sub %7, %11 : i32
    %13 = llvm.add %10, %12 : i32
    %14 = llvm.urem %13, %7 : i32
    %15 = llvm.sub %13, %14 : i32
    %16 = llvm.inttoptr %15 : i32 to !llvm.ptr
    %17 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    %18 = llvm.insertvalue %9, %17[0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    %19 = llvm.insertvalue %16, %18[1] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    %20 = llvm.mlir.constant(0 : index) : i32
    %21 = llvm.insertvalue %20, %19[2] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    %22 = llvm.insertvalue %0, %21[3, 0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    %23 = llvm.insertvalue %1, %22[4, 0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    return
  }
}

// -----
module {
  llvm.mlir.global private constant @__constant_3xi64(dense<[2, 6, 20]> : tensor<3xi64>) {addr_space = 0 : i32} : !llvm.array<3 x i64>
  func.func @memref.reshape(%arg0: memref<4x5x6xf32>) -> memref<2x6x20xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<4x5x6xf32> to !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %1 = llvm.mlir.constant(3 : index) : i64
    %2 = llvm.mlir.constant(1 : index) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.getelementptr %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %5 = llvm.ptrtoint %4 : !llvm.ptr to i64
    %6 = llvm.mlir.addressof @__constant_3xi64 : !llvm.ptr
    %7 = llvm.getelementptr %6[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<3 x i64>
    %8 = llvm.mlir.constant(3735928559 : index) : i64
    %9 = llvm.inttoptr %8 : i64 to !llvm.ptr
    %10 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %11 = llvm.insertvalue %9, %10[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.insertvalue %7, %11[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.mlir.constant(0 : index) : i64
    %14 = llvm.insertvalue %13, %12[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.insertvalue %1, %14[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.insertvalue %2, %15[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %17 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %18 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %19 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %20 = llvm.insertvalue %18, %17[0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %21 = llvm.insertvalue %19, %20[1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %22 = llvm.mlir.constant(0 : index) : i64
    %23 = llvm.insertvalue %22, %21[2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %24 = llvm.mlir.constant(1 : index) : i64
    %25 = llvm.mlir.constant(20 : index) : i64
    %26 = llvm.insertvalue %25, %23[3, 2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %27 = llvm.insertvalue %24, %26[4, 2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %28 = llvm.mul %24, %25 : i64
    %29 = llvm.mlir.constant(20 : index) : i64
    %30 = llvm.mlir.constant(6 : index) : i64
    %31 = llvm.insertvalue %30, %27[3, 1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %32 = llvm.insertvalue %29, %31[4, 1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %33 = llvm.mul %29, %30 : i64
    %34 = llvm.mlir.constant(120 : index) : i64
    %35 = llvm.mlir.constant(2 : index) : i64
    %36 = llvm.insertvalue %35, %32[3, 0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %37 = llvm.insertvalue %34, %36[4, 0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %38 = builtin.unrealized_conversion_cast %37 : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> to memref<2x6x20xf32>
    %39 = llvm.mul %34, %35 : i64
    return %38 : memref<2x6x20xf32>
  }
}

// -----
module {
  func.func @memref.reshape.dynamic.dim(%arg0: memref<?x?x?xf32>, %arg1: memref<4xi64>) -> memref<?x?x12x32xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<4xi64> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?x?x?xf32> to !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %2 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %4 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %5 = llvm.insertvalue %3, %2[0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %6 = llvm.insertvalue %4, %5[1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %7 = llvm.mlir.constant(0 : index) : i64
    %8 = llvm.insertvalue %7, %6[2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %9 = llvm.mlir.constant(1 : index) : i64
    %10 = llvm.mlir.constant(32 : index) : i64
    %11 = llvm.insertvalue %10, %8[3, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %12 = llvm.insertvalue %9, %11[4, 3] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %13 = llvm.mul %9, %10 : i64
    %14 = llvm.mlir.constant(32 : index) : i64
    %15 = llvm.mlir.constant(12 : index) : i64
    %16 = llvm.insertvalue %15, %12[3, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %17 = llvm.insertvalue %14, %16[4, 2] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %18 = llvm.mul %14, %15 : i64
    %19 = llvm.mlir.constant(384 : index) : i64
    %20 = llvm.mlir.constant(1 : index) : i64
    %21 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %22 = llvm.getelementptr inbounds|nuw %21[%20] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %23 = llvm.load %22 : !llvm.ptr -> i64
    %24 = llvm.insertvalue %23, %17[3, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %25 = llvm.insertvalue %19, %24[4, 1] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %26 = llvm.mul %19, %23 : i64
    %27 = llvm.mlir.constant(0 : index) : i64
    %28 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %29 = llvm.getelementptr inbounds|nuw %28[%27] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %30 = llvm.load %29 : !llvm.ptr -> i64
    %31 = llvm.insertvalue %30, %25[3, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %32 = llvm.insertvalue %26, %31[4, 0] : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> 
    %33 = builtin.unrealized_conversion_cast %32 : !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> to memref<?x?x12x32xf32>
    %34 = llvm.mul %26, %30 : i64
    return %33 : memref<?x?x12x32xf32>
  }
}

// -----
module {
  func.func @memref.reshape_index(%arg0: memref<?x?xi32>, %arg1: memref<1xindex>) -> memref<?xi32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<1xindex> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?x?xi32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %2 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.insertvalue %3, %2[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %6 = llvm.insertvalue %4, %5[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %7 = llvm.mlir.constant(0 : index) : i64
    %8 = llvm.insertvalue %7, %6[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.mlir.constant(1 : index) : i64
    %10 = llvm.mlir.constant(0 : index) : i64
    %11 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.getelementptr inbounds|nuw %11[%10] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %13 = llvm.load %12 : !llvm.ptr -> i64
    %14 = builtin.unrealized_conversion_cast %13 : i64 to index
    %15 = builtin.unrealized_conversion_cast %14 : index to i64
    %16 = llvm.insertvalue %15, %8[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %17 = llvm.insertvalue %9, %16[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %18 = builtin.unrealized_conversion_cast %17 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<?xi32>
    %19 = llvm.mul %9, %15 : i64
    return %18 : memref<?xi32>
  }
  func.func @memref_memory_space_cast(%arg0: memref<?xf32>) -> memref<?xf32, 1> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.extractvalue %0[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %6 = llvm.addrspacecast %1 : !llvm.ptr to !llvm.ptr<1>
    %7 = llvm.addrspacecast %2 : !llvm.ptr to !llvm.ptr<1>
    %8 = llvm.mlir.poison : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.insertvalue %6, %8[0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.insertvalue %7, %9[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.insertvalue %3, %10[2] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.insertvalue %4, %11[3, 0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.insertvalue %5, %12[4, 0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = builtin.unrealized_conversion_cast %13 : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> to memref<?xf32, 1>
    return %14 : memref<?xf32, 1>
  }
}

