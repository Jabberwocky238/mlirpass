module {
  llvm.func @aligned_alloc(i64, i64) -> !llvm.ptr
  func.func @mixed_alloc(%arg0: index, %arg1: index) -> memref<?x42x?xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %2 = llvm.mlir.constant(42 : index) : i64
    %3 = llvm.mlir.constant(1 : index) : i64
    %4 = llvm.mul %0, %2 : i64
    %5 = llvm.mul %4, %1 : i64
    %6 = llvm.mlir.zero : !llvm.ptr
    %7 = llvm.getelementptr %6[%5] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %8 = llvm.ptrtoint %7 : !llvm.ptr to i64
    %9 = llvm.mlir.constant(16 : index) : i64
    %10 = llvm.mlir.constant(1 : index) : i64
    %11 = llvm.sub %9, %10 : i64
    %12 = llvm.add %8, %11 : i64
    %13 = llvm.urem %12, %9 : i64
    %14 = llvm.sub %12, %13 : i64
    %15 = llvm.call @aligned_alloc(%9, %14) : (i64, i64) -> !llvm.ptr
    %16 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %17 = llvm.insertvalue %15, %16[0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %18 = llvm.insertvalue %15, %17[1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %19 = llvm.mlir.constant(0 : index) : i64
    %20 = llvm.insertvalue %19, %18[2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %21 = llvm.insertvalue %1, %20[3, 0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %22 = llvm.insertvalue %2, %21[3, 1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %23 = llvm.insertvalue %0, %22[3, 2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %24 = llvm.insertvalue %4, %23[4, 0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %25 = llvm.insertvalue %0, %24[4, 1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %26 = llvm.insertvalue %3, %25[4, 2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %27 = builtin.unrealized_conversion_cast %26 : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> to memref<?x42x?xf32>
    return %27 : memref<?x42x?xf32>
  }
}

// -----
module {
  llvm.func @free(!llvm.ptr)
  func.func @mixed_dealloc(%arg0: memref<?x42x?xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?x42x?xf32> to !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    llvm.call @free(%1) : (!llvm.ptr) -> ()
    return
  }
}

// -----
module {
  llvm.func @free(!llvm.ptr)
  func.func @unranked_dealloc(%arg0: memref<*xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<*xf32> to !llvm.struct<(i64, ptr)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i64, ptr)> 
    %2 = llvm.load %1 : !llvm.ptr -> !llvm.ptr
    llvm.call @free(%2) : (!llvm.ptr) -> ()
    return
  }
}

// -----
module {
  llvm.func @aligned_alloc(i64, i64) -> !llvm.ptr
  func.func @dynamic_alloc(%arg0: index, %arg1: index) -> memref<?x?xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %2 = llvm.mlir.constant(1 : index) : i64
    %3 = llvm.mul %0, %1 : i64
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.getelementptr %4[%3] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %6 = llvm.ptrtoint %5 : !llvm.ptr to i64
    %7 = llvm.mlir.constant(16 : index) : i64
    %8 = llvm.mlir.constant(1 : index) : i64
    %9 = llvm.sub %7, %8 : i64
    %10 = llvm.add %6, %9 : i64
    %11 = llvm.urem %10, %7 : i64
    %12 = llvm.sub %10, %11 : i64
    %13 = llvm.call @aligned_alloc(%7, %12) : (i64, i64) -> !llvm.ptr
    %14 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %15 = llvm.insertvalue %13, %14[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %16 = llvm.insertvalue %13, %15[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %17 = llvm.mlir.constant(0 : index) : i64
    %18 = llvm.insertvalue %17, %16[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %19 = llvm.insertvalue %1, %18[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %20 = llvm.insertvalue %0, %19[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %21 = llvm.insertvalue %0, %20[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %22 = llvm.insertvalue %2, %21[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %23 = builtin.unrealized_conversion_cast %22 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> to memref<?x?xf32>
    return %23 : memref<?x?xf32>
  }
}

// -----
module {
  func.func @dynamic_alloca(%arg0: index, %arg1: index) -> memref<?x?xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %2 = llvm.mlir.constant(1 : index) : i64
    %3 = llvm.mul %0, %1 : i64
    %4 = llvm.alloca %3 x f32 : (i64) -> !llvm.ptr
    %5 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.insertvalue %4, %6[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.mlir.constant(0 : index) : i64
    %9 = llvm.insertvalue %8, %7[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %10 = llvm.insertvalue %1, %9[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.insertvalue %0, %10[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %12 = llvm.insertvalue %0, %11[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.insertvalue %2, %12[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = builtin.unrealized_conversion_cast %13 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> to memref<?x?xf32>
    %15 = llvm.mlir.constant(1 : index) : i64
    %16 = llvm.mul %0, %1 : i64
    %17 = llvm.alloca %16 x f32 {alignment = 32 : i64} : (i64) -> !llvm.ptr
    %18 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %19 = llvm.insertvalue %17, %18[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %20 = llvm.insertvalue %17, %19[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %21 = llvm.mlir.constant(0 : index) : i64
    %22 = llvm.insertvalue %21, %20[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %23 = llvm.insertvalue %1, %22[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %24 = llvm.insertvalue %0, %23[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %25 = llvm.insertvalue %0, %24[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %26 = llvm.insertvalue %15, %25[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    return %14 : memref<?x?xf32>
  }
}

// -----
module {
  llvm.func @free(!llvm.ptr)
  func.func @dynamic_dealloc(%arg0: memref<?x?xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?x?xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%1) : (!llvm.ptr) -> ()
    return
  }
}

// -----
module {
  llvm.func @aligned_alloc(i64, i64) -> !llvm.ptr
  func.func @stdlib_aligned_alloc(%arg0: index) -> memref<32x18xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %1 = llvm.mlir.constant(32 : index) : i64
    %2 = llvm.mlir.constant(18 : index) : i64
    %3 = llvm.mlir.constant(1 : index) : i64
    %4 = llvm.mlir.constant(576 : index) : i64
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.getelementptr %5[%4] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %7 = llvm.ptrtoint %6 : !llvm.ptr to i64
    %8 = llvm.mlir.constant(32 : index) : i64
    %9 = llvm.call @aligned_alloc(%8, %7) : (i64, i64) -> !llvm.ptr
    %10 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %11 = llvm.insertvalue %9, %10[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %12 = llvm.insertvalue %9, %11[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.mlir.constant(0 : index) : i64
    %14 = llvm.insertvalue %13, %12[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %15 = llvm.insertvalue %1, %14[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %16 = llvm.insertvalue %2, %15[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %17 = llvm.insertvalue %2, %16[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %18 = llvm.insertvalue %3, %17[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %19 = builtin.unrealized_conversion_cast %18 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> to memref<32x18xf32>
    %20 = llvm.mlir.constant(4096 : index) : i64
    %21 = llvm.mlir.constant(1 : index) : i64
    %22 = llvm.mlir.zero : !llvm.ptr
    %23 = llvm.getelementptr %22[%20] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %24 = llvm.ptrtoint %23 : !llvm.ptr to i64
    %25 = llvm.mlir.constant(64 : index) : i64
    %26 = llvm.call @aligned_alloc(%25, %24) : (i64, i64) -> !llvm.ptr
    %27 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %28 = llvm.insertvalue %26, %27[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %29 = llvm.insertvalue %26, %28[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %30 = llvm.mlir.constant(0 : index) : i64
    %31 = llvm.insertvalue %30, %29[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %32 = llvm.insertvalue %20, %31[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %33 = llvm.insertvalue %21, %32[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %34 = llvm.mlir.constant(4096 : index) : i64
    %35 = llvm.mlir.constant(1 : index) : i64
    %36 = llvm.mlir.zero : !llvm.ptr
    %37 = llvm.getelementptr %36[%34] : (!llvm.ptr, i64) -> !llvm.ptr, vector<8xf32>
    %38 = llvm.ptrtoint %37 : !llvm.ptr to i64
    %39 = llvm.mlir.constant(32 : index) : i64
    %40 = llvm.call @aligned_alloc(%39, %38) : (i64, i64) -> !llvm.ptr
    %41 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %42 = llvm.insertvalue %40, %41[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %43 = llvm.insertvalue %40, %42[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %44 = llvm.mlir.constant(0 : index) : i64
    %45 = llvm.insertvalue %44, %43[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %46 = llvm.insertvalue %34, %45[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %47 = llvm.insertvalue %35, %46[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %48 = llvm.mlir.constant(4096 : index) : i64
    %49 = llvm.mlir.constant(1 : index) : i64
    %50 = llvm.mlir.zero : !llvm.ptr
    %51 = llvm.getelementptr %50[%48] : (!llvm.ptr, i64) -> !llvm.ptr, vector<2xf32>
    %52 = llvm.ptrtoint %51 : !llvm.ptr to i64
    %53 = llvm.mlir.constant(16 : index) : i64
    %54 = llvm.call @aligned_alloc(%53, %52) : (i64, i64) -> !llvm.ptr
    %55 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %56 = llvm.insertvalue %54, %55[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %57 = llvm.insertvalue %54, %56[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %58 = llvm.mlir.constant(0 : index) : i64
    %59 = llvm.insertvalue %58, %57[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %60 = llvm.insertvalue %48, %59[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %61 = llvm.insertvalue %49, %60[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %62 = llvm.mlir.constant(1024 : index) : i64
    %63 = llvm.mlir.constant(1 : index) : i64
    %64 = llvm.mlir.zero : !llvm.ptr
    %65 = llvm.getelementptr %64[%62] : (!llvm.ptr, i64) -> !llvm.ptr, vector<4xf32>
    %66 = llvm.ptrtoint %65 : !llvm.ptr to i64
    %67 = llvm.mlir.constant(8 : index) : i64
    %68 = llvm.call @aligned_alloc(%67, %66) : (i64, i64) -> !llvm.ptr
    %69 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %70 = llvm.insertvalue %68, %69[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %71 = llvm.insertvalue %68, %70[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %72 = llvm.mlir.constant(0 : index) : i64
    %73 = llvm.insertvalue %72, %71[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %74 = llvm.insertvalue %62, %73[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %75 = llvm.insertvalue %63, %74[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %76 = llvm.mlir.constant(100 : index) : i64
    %77 = llvm.mlir.constant(1 : index) : i64
    %78 = llvm.mlir.zero : !llvm.ptr
    %79 = llvm.getelementptr %78[%76] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %80 = llvm.ptrtoint %79 : !llvm.ptr to i64
    %81 = llvm.mlir.constant(32 : index) : i64
    %82 = llvm.mlir.constant(1 : index) : i64
    %83 = llvm.sub %81, %82 : i64
    %84 = llvm.add %80, %83 : i64
    %85 = llvm.urem %84, %81 : i64
    %86 = llvm.sub %84, %85 : i64
    %87 = llvm.call @aligned_alloc(%81, %86) : (i64, i64) -> !llvm.ptr
    %88 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %89 = llvm.insertvalue %87, %88[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %90 = llvm.insertvalue %87, %89[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %91 = llvm.mlir.constant(0 : index) : i64
    %92 = llvm.insertvalue %91, %90[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %93 = llvm.insertvalue %76, %92[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %94 = llvm.insertvalue %77, %93[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %95 = llvm.mlir.constant(1 : index) : i64
    %96 = llvm.mlir.zero : !llvm.ptr
    %97 = llvm.getelementptr %96[%0] : (!llvm.ptr, i64) -> !llvm.ptr, vector<18xf32>
    %98 = llvm.ptrtoint %97 : !llvm.ptr to i64
    %99 = llvm.mlir.constant(128 : index) : i64
    %100 = llvm.call @aligned_alloc(%99, %98) : (i64, i64) -> !llvm.ptr
    %101 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %102 = llvm.insertvalue %100, %101[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %103 = llvm.insertvalue %100, %102[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %104 = llvm.mlir.constant(0 : index) : i64
    %105 = llvm.insertvalue %104, %103[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %106 = llvm.insertvalue %0, %105[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %107 = llvm.insertvalue %95, %106[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    return %19 : memref<32x18xf32>
  }
}

// -----
module {
  func.func @mixed_load(%arg0: memref<42x?xf32>, %arg1: index, %arg2: index) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<42x?xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.extractvalue %2[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.mul %1, %4 overflow<nsw, nuw> : i64
    %6 = llvm.add %5, %0 overflow<nsw, nuw> : i64
    %7 = llvm.getelementptr inbounds|nuw %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %8 = llvm.load %7 : !llvm.ptr -> f32
    return
  }
}

// -----
module {
  func.func @dynamic_load(%arg0: memref<?x?xf32>, %arg1: index, %arg2: index) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<?x?xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.extractvalue %2[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.mul %1, %4 overflow<nsw, nuw> : i64
    %6 = llvm.add %5, %0 overflow<nsw, nuw> : i64
    %7 = llvm.getelementptr inbounds|nuw %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %8 = llvm.load %7 : !llvm.ptr -> f32
    return
  }
}

// -----
module {
  func.func @prefetch(%arg0: memref<?x?xf32>, %arg1: index, %arg2: index) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<?x?xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.extractvalue %2[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.mul %1, %4 : i64
    %6 = llvm.add %5, %0 : i64
    %7 = llvm.getelementptr %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    "llvm.intr.prefetch"(%7) <{cache = 1 : i32, hint = 3 : i32, rw = 1 : i32}> : (!llvm.ptr) -> ()
    %8 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %9 = llvm.extractvalue %2[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %10 = llvm.mul %1, %9 : i64
    %11 = llvm.add %10, %0 : i64
    %12 = llvm.getelementptr %8[%11] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    "llvm.intr.prefetch"(%12) <{cache = 1 : i32, hint = 0 : i32, rw = 0 : i32}> : (!llvm.ptr) -> ()
    %13 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = llvm.extractvalue %2[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %15 = llvm.mul %1, %14 : i64
    %16 = llvm.add %15, %0 : i64
    %17 = llvm.getelementptr %13[%16] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    "llvm.intr.prefetch"(%17) <{cache = 0 : i32, hint = 2 : i32, rw = 0 : i32}> : (!llvm.ptr) -> ()
    return
  }
}

// -----
module {
  func.func @dynamic_store(%arg0: memref<?x?xf32>, %arg1: index, %arg2: index, %arg3: f32) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<?x?xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.extractvalue %2[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.mul %1, %4 overflow<nsw, nuw> : i64
    %6 = llvm.add %5, %0 overflow<nsw, nuw> : i64
    %7 = llvm.getelementptr inbounds|nuw %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %arg3, %7 : f32, !llvm.ptr
    return
  }
}

// -----
module {
  func.func @mixed_store(%arg0: memref<42x?xf32>, %arg1: index, %arg2: index, %arg3: f32) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<42x?xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.extractvalue %2[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.mul %1, %4 overflow<nsw, nuw> : i64
    %6 = llvm.add %5, %0 overflow<nsw, nuw> : i64
    %7 = llvm.getelementptr inbounds|nuw %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %arg3, %7 : f32, !llvm.ptr
    return
  }
}

// -----
module attributes {dlti.dl_spec = #dlti.dl_spec<!llvm.ptr = dense<64> : vector<3xi64>, !llvm.ptr<1> = dense<32> : vector<3xi64>>} {
  func.func @memref_memory_space_cast(%arg0: memref<*xf32>) -> memref<*xf32, 1> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<*xf32> to !llvm.struct<(i64, ptr)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(i64, ptr)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(i64, ptr)> 
    %3 = llvm.mlir.poison : !llvm.struct<(i64, ptr)>
    %4 = llvm.insertvalue %1, %3[0] : !llvm.struct<(i64, ptr)> 
    %5 = llvm.mlir.constant(1 : index) : i64
    %6 = llvm.mlir.constant(2 : index) : i64
    %7 = llvm.mlir.constant(8 : index) : i64
    %8 = llvm.mlir.constant(8 : index) : i64
    %9 = llvm.mul %6, %8 : i64
    %10 = llvm.extractvalue %4[0] : !llvm.struct<(i64, ptr)> 
    %11 = llvm.mul %6, %10 : i64
    %12 = llvm.add %11, %5 : i64
    %13 = llvm.mul %12, %7 : i64
    %14 = llvm.add %9, %13 : i64
    %15 = llvm.alloca %14 x i8 : (i64) -> !llvm.ptr
    %16 = llvm.insertvalue %15, %4[1] : !llvm.struct<(i64, ptr)> 
    %17 = builtin.unrealized_conversion_cast %16 : !llvm.struct<(i64, ptr)> to memref<*xf32, 1>
    %18 = llvm.load %2 : !llvm.ptr -> !llvm.ptr
    %19 = llvm.getelementptr %2[1] : (!llvm.ptr) -> !llvm.ptr, !llvm.ptr
    %20 = llvm.load %19 : !llvm.ptr -> !llvm.ptr
    %21 = llvm.addrspacecast %18 : !llvm.ptr to !llvm.ptr<1>
    %22 = llvm.addrspacecast %20 : !llvm.ptr to !llvm.ptr<1>
    llvm.store %21, %15 : !llvm.ptr<1>, !llvm.ptr
    %23 = llvm.getelementptr %15[1] : (!llvm.ptr) -> !llvm.ptr, !llvm.ptr<1>
    llvm.store %22, %23 : !llvm.ptr<1>, !llvm.ptr
    %24 = llvm.getelementptr %2[2] : (!llvm.ptr) -> !llvm.ptr, !llvm.ptr
    %25 = llvm.getelementptr %15[2] : (!llvm.ptr) -> !llvm.ptr, !llvm.ptr<1>
    %26 = llvm.mlir.constant(16 : index) : i64
    %27 = llvm.sub %14, %26 : i64
    "llvm.intr.memcpy"(%25, %24, %27) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    return %17 : memref<*xf32, 1>
  }
}

// -----
module {
  func.func @memref_cast_static_to_dynamic(%arg0: memref<10x42xf32>) {
    return
  }
}

// -----
module {
  func.func @memref_cast_static_to_mixed(%arg0: memref<10x42xf32>) {
    return
  }
}

// -----
module {
  func.func @memref_cast_dynamic_to_static(%arg0: memref<?x?xf32>) {
    return
  }
}

// -----
module {
  func.func @memref_cast_dynamic_to_mixed(%arg0: memref<?x?xf32>) {
    return
  }
}

// -----
module {
  func.func @memref_cast_mixed_to_dynamic(%arg0: memref<42x?xf32>) {
    return
  }
}

// -----
module {
  func.func @memref_cast_mixed_to_static(%arg0: memref<42x?xf32>) {
    return
  }
}

// -----
module {
  func.func @memref_cast_mixed_to_mixed(%arg0: memref<42x?xf32>) {
    return
  }
}

// -----
module {
  func.func @memref_cast_ranked_to_unranked(%arg0: memref<42x2x?xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<42x2x?xf32> to !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.alloca %1 x !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> : (i64) -> !llvm.ptr
    llvm.store %0, %2 : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, !llvm.ptr
    %3 = llvm.mlir.constant(3 : index) : i64
    %4 = llvm.mlir.poison : !llvm.struct<(i64, ptr)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<(i64, ptr)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<(i64, ptr)> 
    return
  }
}

// -----
module {
  func.func @memref_cast_unranked_to_ranked(%arg0: memref<*xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<*xf32> to !llvm.struct<(i64, ptr)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i64, ptr)> 
    %2 = llvm.load %1 : !llvm.ptr -> !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    return
  }
}

// -----
module {
  func.func @mixed_memref_dim(%arg0: memref<42x?x?x13x?xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<42x?x?x13x?xf32> to !llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>
    %c0 = arith.constant 0 : index
    %1 = llvm.mlir.constant(42 : index) : i64
    %c1 = arith.constant 1 : index
    %2 = llvm.extractvalue %0[3, 1] : !llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)> 
    %c2 = arith.constant 2 : index
    %3 = llvm.extractvalue %0[3, 2] : !llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)> 
    %c3 = arith.constant 3 : index
    %4 = llvm.mlir.constant(13 : index) : i64
    %c4 = arith.constant 4 : index
    %5 = llvm.extractvalue %0[3, 4] : !llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)> 
    return
  }
}

// -----
module {
  func.func @memref_dim_with_dyn_index(%arg0: memref<3x?xf32>, %arg1: index) -> index {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<3x?xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %2 = llvm.mlir.constant(1 : index) : i64
    %3 = llvm.extractvalue %1[3] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.alloca %2 x !llvm.array<2 x i64> : (i64) -> !llvm.ptr
    llvm.store %3, %4 : !llvm.array<2 x i64>, !llvm.ptr
    %5 = llvm.getelementptr %4[0, %0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.array<2 x i64>
    %6 = llvm.load %5 : !llvm.ptr -> i64
    %7 = builtin.unrealized_conversion_cast %6 : i64 to index
    return %7 : index
  }
}

// -----
module {
  func.func @memref_reinterpret_cast_ranked_to_static_shape(%arg0: memref<2x3xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<2x3xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %2 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.insertvalue %2, %1[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.insertvalue %3, %4[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.mlir.constant(0 : index) : i64
    %7 = llvm.insertvalue %6, %5[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.mlir.constant(6 : index) : i64
    %9 = llvm.insertvalue %8, %7[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %10 = llvm.mlir.constant(1 : index) : i64
    %11 = llvm.insertvalue %10, %9[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %12 = llvm.mlir.constant(1 : index) : i64
    %13 = llvm.insertvalue %12, %11[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = llvm.mlir.constant(1 : index) : i64
    %15 = llvm.insertvalue %14, %13[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    return
  }
}

// -----
module {
  func.func @memref_reinterpret_cast_unranked_to_dynamic_shape(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: memref<*xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg4 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg3 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %3 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %4 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %5 = builtin.unrealized_conversion_cast %arg5 : memref<*xf32> to !llvm.struct<(i64, ptr)>
    %6 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %7 = llvm.extractvalue %5[1] : !llvm.struct<(i64, ptr)> 
    %8 = llvm.load %7 : !llvm.ptr -> !llvm.ptr
    %9 = llvm.getelementptr %7[1] : (!llvm.ptr) -> !llvm.ptr, !llvm.ptr
    %10 = llvm.load %9 : !llvm.ptr -> !llvm.ptr
    %11 = llvm.insertvalue %8, %6[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %12 = llvm.insertvalue %10, %11[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.insertvalue %4, %12[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = llvm.insertvalue %3, %13[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %15 = llvm.insertvalue %1, %14[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %16 = llvm.insertvalue %2, %15[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %17 = llvm.insertvalue %0, %16[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    return
  }
}

// -----
module {
  func.func @memref_reshape(%arg0: memref<2x3xf32>, %arg1: memref<?xindex>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<?xindex> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<2x3xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %2 = llvm.extractvalue %0[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.mlir.poison : !llvm.struct<(i64, ptr)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<(i64, ptr)> 
    %5 = llvm.mlir.constant(1 : index) : i64
    %6 = llvm.mlir.constant(2 : index) : i64
    %7 = llvm.mlir.constant(8 : index) : i64
    %8 = llvm.mlir.constant(8 : index) : i64
    %9 = llvm.mul %6, %8 : i64
    %10 = llvm.extractvalue %4[0] : !llvm.struct<(i64, ptr)> 
    %11 = llvm.mul %6, %10 : i64
    %12 = llvm.add %11, %5 : i64
    %13 = llvm.mul %12, %7 : i64
    %14 = llvm.add %9, %13 : i64
    %15 = llvm.alloca %14 x i8 : (i64) -> !llvm.ptr
    %16 = llvm.insertvalue %15, %4[1] : !llvm.struct<(i64, ptr)> 
    %17 = llvm.extractvalue %1[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %18 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %19 = llvm.extractvalue %1[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.store %17, %15 : !llvm.ptr, !llvm.ptr
    %20 = llvm.getelementptr %15[1] : (!llvm.ptr) -> !llvm.ptr, !llvm.ptr
    llvm.store %18, %20 : !llvm.ptr, !llvm.ptr
    %21 = llvm.getelementptr %15[2] : (!llvm.ptr) -> !llvm.ptr, !llvm.ptr
    llvm.store %19, %21 : i64, !llvm.ptr
    %22 = llvm.getelementptr %15[0, 3] : (!llvm.ptr) -> !llvm.ptr, !llvm.struct<(ptr, ptr, i64, i64)>
    %23 = llvm.getelementptr %22[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %24 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %25 = llvm.mlir.constant(1 : index) : i64
    %26 = llvm.sub %2, %25 : i64
    llvm.br ^bb1(%26, %25 : i64, i64)
  ^bb1(%27: i64, %28: i64):  // 2 preds: ^bb0, ^bb2
    %29 = llvm.mlir.constant(0 : index) : i64
    %30 = llvm.icmp "sge" %27, %29 : i64
    llvm.cond_br %30, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %31 = llvm.getelementptr %24[%27] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %32 = llvm.load %31 : !llvm.ptr -> i64
    %33 = llvm.getelementptr %22[%27] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %32, %33 : i64, !llvm.ptr
    %34 = llvm.getelementptr %23[%27] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %28, %34 : i64, !llvm.ptr
    %35 = llvm.mul %28, %32 : i64
    %36 = llvm.sub %27, %25 : i64
    llvm.br ^bb1(%36, %35 : i64, i64)
  ^bb3:  // pred: ^bb1
    return
  }
}

// -----
module {
  llvm.func @aligned_alloc(i64, i64) -> !llvm.ptr
  func.func @memref_of_memref() {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i64
    %5 = llvm.mlir.constant(64 : index) : i64
    %6 = llvm.mlir.constant(1 : index) : i64
    %7 = llvm.sub %5, %6 : i64
    %8 = llvm.add %4, %7 : i64
    %9 = llvm.urem %8, %5 : i64
    %10 = llvm.sub %8, %9 : i64
    %11 = llvm.call @aligned_alloc(%5, %10) : (i64, i64) -> !llvm.ptr
    %12 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %13 = llvm.insertvalue %11, %12[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.insertvalue %11, %13[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.mlir.constant(0 : index) : i64
    %16 = llvm.insertvalue %15, %14[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %17 = llvm.insertvalue %0, %16[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %18 = llvm.insertvalue %1, %17[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    return
  }
}

// -----
module attributes {dlti.dl_spec = #dlti.dl_spec<index = 32 : i64>} {
  llvm.func @aligned_alloc(i32, i32) -> !llvm.ptr
  func.func @memref_of_memref_32() {
    %0 = llvm.mlir.constant(1 : index) : i32
    %1 = llvm.mlir.constant(1 : index) : i32
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i32
    %5 = llvm.mlir.constant(32 : index) : i32
    %6 = llvm.mlir.constant(1 : index) : i32
    %7 = llvm.sub %5, %6 : i32
    %8 = llvm.add %4, %7 : i32
    %9 = llvm.urem %8, %5 : i32
    %10 = llvm.sub %8, %9 : i32
    %11 = llvm.call @aligned_alloc(%5, %10) : (i32, i32) -> !llvm.ptr
    %12 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    %13 = llvm.insertvalue %11, %12[0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    %14 = llvm.insertvalue %11, %13[1] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    %15 = llvm.mlir.constant(0 : index) : i32
    %16 = llvm.insertvalue %15, %14[2] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    %17 = llvm.insertvalue %0, %16[3, 0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    %18 = llvm.insertvalue %1, %17[4, 0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    return
  }
}

// -----
module {
  llvm.func @aligned_alloc(i64, i64) -> !llvm.ptr
  func.func @memref_of_memref_of_memref() {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i64
    %5 = llvm.mlir.constant(64 : index) : i64
    %6 = llvm.mlir.constant(1 : index) : i64
    %7 = llvm.sub %5, %6 : i64
    %8 = llvm.add %4, %7 : i64
    %9 = llvm.urem %8, %5 : i64
    %10 = llvm.sub %8, %9 : i64
    %11 = llvm.call @aligned_alloc(%5, %10) : (i64, i64) -> !llvm.ptr
    %12 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %13 = llvm.insertvalue %11, %12[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.insertvalue %11, %13[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.mlir.constant(0 : index) : i64
    %16 = llvm.insertvalue %15, %14[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %17 = llvm.insertvalue %0, %16[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %18 = llvm.insertvalue %1, %17[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    return
  }
}

// -----
module {
  llvm.func @aligned_alloc(i64, i64) -> !llvm.ptr
  func.func @ranked_unranked() {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<(i64, ptr)>
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i64
    %5 = llvm.mlir.constant(16 : index) : i64
    %6 = llvm.call @aligned_alloc(%5, %4) : (i64, i64) -> !llvm.ptr
    %7 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.insertvalue %6, %8[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.mlir.constant(0 : index) : i64
    %11 = llvm.insertvalue %10, %9[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.insertvalue %0, %11[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.insertvalue %1, %12[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.mlir.constant(1 : index) : i64
    %15 = llvm.alloca %14 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> : (i64) -> !llvm.ptr
    llvm.store %13, %15 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    %16 = llvm.mlir.constant(1 : index) : i64
    %17 = llvm.mlir.poison : !llvm.struct<(i64, ptr)>
    %18 = llvm.insertvalue %16, %17[0] : !llvm.struct<(i64, ptr)> 
    %19 = llvm.insertvalue %15, %18[1] : !llvm.struct<(i64, ptr)> 
    return
  }
}

