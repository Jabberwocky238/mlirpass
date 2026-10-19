module {
  llvm.func @malloc(i64) -> !llvm.ptr
  func.func @view(%arg0: index, %arg1: index, %arg2: index) {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %3 = llvm.mlir.constant(2048 : index) : i64
    %4 = llvm.mlir.constant(1 : index) : i64
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.getelementptr %5[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %7 = llvm.ptrtoint %6 : !llvm.ptr to i64
    %8 = llvm.call @malloc(%7) : (i64) -> !llvm.ptr
    %9 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.insertvalue %8, %9[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.insertvalue %8, %10[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.mlir.constant(0 : index) : i64
    %13 = llvm.insertvalue %12, %11[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.insertvalue %3, %13[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.insertvalue %4, %14[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %17 = llvm.extractvalue %15[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %18 = llvm.insertvalue %17, %16[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %19 = llvm.extractvalue %15[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %20 = llvm.getelementptr %19[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %21 = llvm.insertvalue %20, %18[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %22 = llvm.mlir.constant(0 : index) : i64
    %23 = llvm.insertvalue %22, %21[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %24 = llvm.insertvalue %0, %23[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %25 = llvm.mlir.constant(1 : index) : i64
    %26 = llvm.insertvalue %25, %24[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %27 = llvm.insertvalue %1, %26[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %28 = llvm.mul %25, %0 : i64
    %29 = llvm.insertvalue %28, %27[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %30 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %31 = llvm.extractvalue %15[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %32 = llvm.insertvalue %31, %30[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %33 = llvm.extractvalue %15[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %34 = llvm.getelementptr %33[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %35 = llvm.insertvalue %34, %32[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %36 = llvm.mlir.constant(0 : index) : i64
    %37 = llvm.insertvalue %36, %35[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %38 = llvm.insertvalue %0, %37[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %39 = llvm.mlir.constant(1 : index) : i64
    %40 = llvm.insertvalue %39, %38[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %41 = llvm.mlir.constant(4 : index) : i64
    %42 = llvm.insertvalue %41, %40[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %43 = llvm.mul %39, %0 : i64
    %44 = llvm.insertvalue %43, %42[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %45 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %46 = llvm.extractvalue %15[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %47 = llvm.insertvalue %46, %45[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %48 = llvm.extractvalue %15[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %49 = llvm.getelementptr %48[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %50 = llvm.insertvalue %49, %47[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %51 = llvm.mlir.constant(0 : index) : i64
    %52 = llvm.insertvalue %51, %50[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %53 = llvm.mlir.constant(4 : index) : i64
    %54 = llvm.insertvalue %53, %52[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %55 = llvm.mlir.constant(1 : index) : i64
    %56 = llvm.insertvalue %55, %54[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %57 = llvm.mlir.constant(64 : index) : i64
    %58 = llvm.insertvalue %57, %56[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %59 = llvm.mlir.constant(4 : index) : i64
    %60 = llvm.insertvalue %59, %58[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %61 = llvm.mlir.constant(2048 : index) : i64
    %62 = llvm.mlir.constant(1 : index) : i64
    %63 = llvm.mlir.zero : !llvm.ptr
    %64 = llvm.getelementptr %63[%61] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %65 = llvm.ptrtoint %64 : !llvm.ptr to i64
    %66 = llvm.call @malloc(%65) : (i64) -> !llvm.ptr
    %67 = llvm.addrspacecast %66 : !llvm.ptr to !llvm.ptr<4>
    %68 = llvm.mlir.poison : !llvm.struct<(ptr<4>, ptr<4>, i64, array<1 x i64>, array<1 x i64>)>
    %69 = llvm.insertvalue %67, %68[0] : !llvm.struct<(ptr<4>, ptr<4>, i64, array<1 x i64>, array<1 x i64>)> 
    %70 = llvm.insertvalue %67, %69[1] : !llvm.struct<(ptr<4>, ptr<4>, i64, array<1 x i64>, array<1 x i64>)> 
    %71 = llvm.mlir.constant(0 : index) : i64
    %72 = llvm.insertvalue %71, %70[2] : !llvm.struct<(ptr<4>, ptr<4>, i64, array<1 x i64>, array<1 x i64>)> 
    %73 = llvm.insertvalue %61, %72[3, 0] : !llvm.struct<(ptr<4>, ptr<4>, i64, array<1 x i64>, array<1 x i64>)> 
    %74 = llvm.insertvalue %62, %73[4, 0] : !llvm.struct<(ptr<4>, ptr<4>, i64, array<1 x i64>, array<1 x i64>)> 
    %75 = llvm.mlir.poison : !llvm.struct<(ptr<4>, ptr<4>, i64, array<2 x i64>, array<2 x i64>)>
    %76 = llvm.extractvalue %74[0] : !llvm.struct<(ptr<4>, ptr<4>, i64, array<1 x i64>, array<1 x i64>)> 
    %77 = llvm.insertvalue %76, %75[0] : !llvm.struct<(ptr<4>, ptr<4>, i64, array<2 x i64>, array<2 x i64>)> 
    %78 = llvm.extractvalue %74[1] : !llvm.struct<(ptr<4>, ptr<4>, i64, array<1 x i64>, array<1 x i64>)> 
    %79 = llvm.getelementptr %78[%2] : (!llvm.ptr<4>, i64) -> !llvm.ptr<4>, i8
    %80 = llvm.insertvalue %79, %77[1] : !llvm.struct<(ptr<4>, ptr<4>, i64, array<2 x i64>, array<2 x i64>)> 
    %81 = llvm.mlir.constant(0 : index) : i64
    %82 = llvm.insertvalue %81, %80[2] : !llvm.struct<(ptr<4>, ptr<4>, i64, array<2 x i64>, array<2 x i64>)> 
    %83 = llvm.mlir.constant(4 : index) : i64
    %84 = llvm.insertvalue %83, %82[3, 1] : !llvm.struct<(ptr<4>, ptr<4>, i64, array<2 x i64>, array<2 x i64>)> 
    %85 = llvm.mlir.constant(1 : index) : i64
    %86 = llvm.insertvalue %85, %84[4, 1] : !llvm.struct<(ptr<4>, ptr<4>, i64, array<2 x i64>, array<2 x i64>)> 
    %87 = llvm.mlir.constant(64 : index) : i64
    %88 = llvm.insertvalue %87, %86[3, 0] : !llvm.struct<(ptr<4>, ptr<4>, i64, array<2 x i64>, array<2 x i64>)> 
    %89 = llvm.mlir.constant(4 : index) : i64
    %90 = llvm.insertvalue %89, %88[4, 0] : !llvm.struct<(ptr<4>, ptr<4>, i64, array<2 x i64>, array<2 x i64>)> 
    return
  }
}

// -----
module {
  func.func @view_empty_memref(%arg0: index, %arg1: memref<0xi8>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : memref<0xi8> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.insertvalue %3, %2[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %6 = llvm.getelementptr %5[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %7 = llvm.insertvalue %6, %4[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.mlir.constant(0 : index) : i64
    %9 = llvm.insertvalue %8, %7[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %10 = llvm.mlir.constant(4 : index) : i64
    %11 = llvm.insertvalue %10, %9[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %12 = llvm.mlir.constant(1 : index) : i64
    %13 = llvm.insertvalue %12, %11[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = llvm.mlir.constant(0 : index) : i64
    %15 = llvm.insertvalue %14, %13[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %16 = llvm.mlir.constant(4 : index) : i64
    %17 = llvm.insertvalue %16, %15[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    return
  }
}

// -----
module {
  func.func @view_memref_as_rank0(%arg0: index, %arg1: memref<2xi8>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : memref<2xi8> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64)>
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.insertvalue %3, %2[0] : !llvm.struct<(ptr, ptr, i64)> 
    %5 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %6 = llvm.getelementptr %5[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %7 = llvm.insertvalue %6, %4[1] : !llvm.struct<(ptr, ptr, i64)> 
    %8 = llvm.mlir.constant(0 : index) : i64
    %9 = llvm.insertvalue %8, %7[2] : !llvm.struct<(ptr, ptr, i64)> 
    return
  }
}

// -----
module {
  func.func @subview(%arg0: memref<64x4xf32, strided<[4, 1]>>, %arg1: index, %arg2: index, %arg3: index) {
    %subview = memref.subview %arg0[%arg1, %arg2] [%arg1, %arg2] [%arg1, %arg2] : memref<64x4xf32, strided<[4, 1]>> to memref<?x?xf32, strided<[?, ?], offset: ?>>
    return
  }
}

// -----
module {
  func.func @assume_alignment(%arg0: memref<4x4xf16>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<4x4xf16> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(16 : index) : i64
    llvm.intr.assume %2 ["align"(%1, %3 : !llvm.ptr, i64)] : i1
    return
  }
}

// -----
module {
  func.func @distinct_objects(%arg0: memref<?xf16>, %arg1: memref<?xf32>, %arg2: memref<?xf64>) -> (memref<?xf16>, memref<?xf32>, memref<?xf64>) {
    %0 = builtin.unrealized_conversion_cast %arg2 : memref<?xf64> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = builtin.unrealized_conversion_cast %arg1 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<?xf16> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %6 = llvm.mlir.constant(true) : i1
    llvm.intr.assume %6 ["separate_storage"(%3, %4 : !llvm.ptr, !llvm.ptr)] : i1
    llvm.intr.assume %6 ["separate_storage"(%3, %5 : !llvm.ptr, !llvm.ptr)] : i1
    llvm.intr.assume %6 ["separate_storage"(%4, %5 : !llvm.ptr, !llvm.ptr)] : i1
    return %arg0, %arg1, %arg2 : memref<?xf16>, memref<?xf32>, memref<?xf64>
  }
}

// -----
module {
  func.func @distinct_objects_noop(%arg0: memref<?xf16>) -> memref<?xf16> {
    return %arg0 : memref<?xf16>
  }
}

// -----
module {
  func.func @assume_alignment_w_offset(%arg0: memref<4x4xf16, strided<[?, ?], offset: ?>>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<4x4xf16, strided<[?, ?], offset: ?>> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.extractvalue %0[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.getelementptr %1[%2] : (!llvm.ptr, i64) -> !llvm.ptr, f16
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.mlir.constant(16 : index) : i64
    llvm.intr.assume %4 ["align"(%3, %5 : !llvm.ptr, i64)] : i1
    return
  }
}

// -----
module {
  func.func @dim_of_unranked(%arg0: memref<*xi32>) -> index {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<*xi32> to !llvm.struct<(i64, ptr)>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i64
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(i64, ptr)> 
    %3 = llvm.getelementptr %2[0, 2] : (!llvm.ptr) -> !llvm.ptr, !llvm.struct<(ptr, ptr, i64)>
    %4 = llvm.mlir.constant(1 : index) : i64
    %5 = llvm.add %4, %1 : i64
    %6 = llvm.getelementptr %3[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %7 = llvm.load %6 : !llvm.ptr -> i64
    %8 = builtin.unrealized_conversion_cast %7 : i64 to index
    return %8 : index
  }
}

// -----
module {
  llvm.func @malloc(i64) -> !llvm.ptr
  func.func @address_space(%arg0: memref<32xf32, 7>) {
    %0 = llvm.mlir.constant(32 : index) : i64
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i64
    %5 = llvm.call @malloc(%4) : (i64) -> !llvm.ptr
    %6 = llvm.addrspacecast %5 : !llvm.ptr to !llvm.ptr<5>
    %7 = llvm.mlir.poison : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.insertvalue %6, %8[1] : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.mlir.constant(0 : index) : i64
    %11 = llvm.insertvalue %10, %9[2] : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.insertvalue %0, %11[3, 0] : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.insertvalue %1, %12[4, 0] : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)> 
    %c7 = arith.constant 7 : index
    %14 = builtin.unrealized_conversion_cast %c7 : index to i64
    %15 = llvm.extractvalue %13[1] : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.getelementptr inbounds|nuw %15[%14] : (!llvm.ptr<5>, i64) -> !llvm.ptr<5>, f32
    %17 = llvm.load %16 : !llvm.ptr<5> -> f32
    return
  }
}

// -----
module {
  func.func @transpose(%arg0: memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>> to !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %1 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %2 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %3 = llvm.insertvalue %2, %1[0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %4 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %5 = llvm.insertvalue %4, %3[1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %6 = llvm.extractvalue %0[2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %7 = llvm.insertvalue %6, %5[2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %8 = llvm.extractvalue %0[3, 2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %9 = llvm.insertvalue %8, %7[3, 0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %10 = llvm.extractvalue %0[4, 2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %11 = llvm.insertvalue %10, %9[4, 0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %12 = llvm.extractvalue %0[3, 0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %13 = llvm.insertvalue %12, %11[3, 1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %14 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %15 = llvm.insertvalue %14, %13[4, 1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %16 = llvm.extractvalue %0[3, 1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %17 = llvm.insertvalue %16, %15[3, 2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %18 = llvm.extractvalue %0[4, 1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %19 = llvm.insertvalue %18, %17[4, 2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    return
  }
}

// -----
module {
  llvm.mlir.global external @gv0() {addr_space = 0 : i32} : !llvm.array<2 x f32> {
    %0 = llvm.mlir.undef : !llvm.array<2 x f32>
    llvm.return %0 : !llvm.array<2 x f32>
  }
  llvm.mlir.global private @gv1() {addr_space = 0 : i32} : !llvm.array<2 x f32>
  llvm.mlir.global external @gv2(dense<[[0.000000e+00, 1.000000e+00, 2.000000e+00], [3.000000e+00, 4.000000e+00, 5.000000e+00]]> : tensor<2x3xf32>) {addr_space = 0 : i32} : !llvm.array<2 x array<3 x f32>>
  func.func @get_gv0_memref() {
    %0 = llvm.mlir.constant(2 : index) : i64
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i64
    %5 = llvm.mlir.addressof @gv0 : !llvm.ptr
    %6 = llvm.getelementptr %5[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x f32>
    %7 = llvm.mlir.constant(3735928559 : index) : i64
    %8 = llvm.inttoptr %7 : i64 to !llvm.ptr
    %9 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.insertvalue %8, %9[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.insertvalue %6, %10[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.mlir.constant(0 : index) : i64
    %13 = llvm.insertvalue %12, %11[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.insertvalue %0, %13[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.insertvalue %1, %14[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    return
  }
  func.func @get_gv2_memref() {
    %0 = llvm.mlir.constant(2 : index) : i64
    %1 = llvm.mlir.constant(3 : index) : i64
    %2 = llvm.mlir.constant(1 : index) : i64
    %3 = llvm.mlir.constant(6 : index) : i64
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.getelementptr %4[%3] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %6 = llvm.ptrtoint %5 : !llvm.ptr to i64
    %7 = llvm.mlir.addressof @gv2 : !llvm.ptr
    %8 = llvm.getelementptr %7[0, 0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x array<3 x f32>>
    %9 = llvm.mlir.constant(3735928559 : index) : i64
    %10 = llvm.inttoptr %9 : i64 to !llvm.ptr
    %11 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %12 = llvm.insertvalue %10, %11[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.insertvalue %8, %12[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = llvm.mlir.constant(0 : index) : i64
    %15 = llvm.insertvalue %14, %13[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %16 = llvm.insertvalue %0, %15[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %17 = llvm.insertvalue %1, %16[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %18 = llvm.insertvalue %1, %17[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %19 = llvm.insertvalue %2, %18[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    return
  }
  llvm.mlir.global external @gv3(1.000000e+00 : f32) {addr_space = 0 : i32} : f32
  func.func @get_gv3_memref() {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.getelementptr %1[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i64
    %4 = llvm.mlir.addressof @gv3 : !llvm.ptr
    %5 = llvm.getelementptr %4[0] : (!llvm.ptr) -> !llvm.ptr, f32
    %6 = llvm.mlir.constant(3735928559 : index) : i64
    %7 = llvm.inttoptr %6 : i64 to !llvm.ptr
    %8 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64)>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.struct<(ptr, ptr, i64)> 
    %10 = llvm.insertvalue %5, %9[1] : !llvm.struct<(ptr, ptr, i64)> 
    %11 = llvm.mlir.constant(0 : index) : i64
    %12 = llvm.insertvalue %11, %10[2] : !llvm.struct<(ptr, ptr, i64)> 
    return
  }
  llvm.mlir.global private @gv4(1.000000e+00 : f32) {addr_space = 0 : i32, alignment = 64 : i64} : f32
}

// -----
module {
  func.func @expand_shape_static(%arg0: memref<3x4x5xf32>) -> memref<1x3x4x1x5xf32> {
    %expand_shape = memref.expand_shape %arg0 [[0, 1], [2], [3, 4]] output_shape [1, 3, 4, 1, 5] : memref<3x4x5xf32> into memref<1x3x4x1x5xf32>
    return %expand_shape : memref<1x3x4x1x5xf32>
  }
}

// -----
module {
  func.func @collapse_shape_static(%arg0: memref<1x3x4x1x5xf32>) -> memref<3x4x5xf32> {
    %collapse_shape = memref.collapse_shape %arg0 [[0, 1], [2], [3, 4]] : memref<1x3x4x1x5xf32> into memref<3x4x5xf32>
    return %collapse_shape : memref<3x4x5xf32>
  }
}

// -----
module {
  func.func @rank_of_unranked(%arg0: memref<*xi32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<*xi32> to !llvm.struct<(i64, ptr)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(i64, ptr)> 
    return
  }
}

// -----
module {
  func.func @rank_of_ranked(%arg0: memref<?xi32>) {
    %0 = llvm.mlir.constant(1 : index) : i64
    return
  }
}

// -----
module {
  func.func @atomic_rmw(%arg0: memref<10xi32>, %arg1: i32, %arg2: memref<10xf32>, %arg3: f32, %arg4: index) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<10xi32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = builtin.unrealized_conversion_cast %arg4 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg2 : memref<10xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.getelementptr %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %5 = llvm.atomicrmw xchg %4, %arg3 acq_rel : !llvm.ptr, f32
    %6 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %7 = llvm.getelementptr %6[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %8 = llvm.atomicrmw add %7, %arg1 acq_rel : !llvm.ptr, i32
    %9 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.getelementptr %9[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %11 = llvm.atomicrmw max %10, %arg1 acq_rel : !llvm.ptr, i32
    %12 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.getelementptr %12[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %14 = llvm.atomicrmw min %13, %arg1 acq_rel : !llvm.ptr, i32
    %15 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.getelementptr %15[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %17 = llvm.atomicrmw umax %16, %arg1 acq_rel : !llvm.ptr, i32
    %18 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %19 = llvm.getelementptr %18[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %20 = llvm.atomicrmw umin %19, %arg1 acq_rel : !llvm.ptr, i32
    %21 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %22 = llvm.getelementptr %21[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %23 = llvm.atomicrmw fadd %22, %arg3 acq_rel : !llvm.ptr, f32
    %24 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %25 = llvm.getelementptr %24[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %26 = llvm.atomicrmw fmaximum %25, %arg3 acq_rel : !llvm.ptr, f32
    %27 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %28 = llvm.getelementptr %27[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %29 = llvm.atomicrmw fmax %28, %arg3 acq_rel : !llvm.ptr, f32
    %30 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %31 = llvm.getelementptr %30[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %32 = llvm.atomicrmw fminimum %31, %arg3 acq_rel : !llvm.ptr, f32
    %33 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %34 = llvm.getelementptr %33[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %35 = llvm.atomicrmw fmin %34, %arg3 acq_rel : !llvm.ptr, f32
    %36 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %37 = llvm.getelementptr %36[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %38 = llvm.atomicrmw _or %37, %arg1 acq_rel : !llvm.ptr, i32
    %39 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %40 = llvm.getelementptr %39[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %41 = llvm.atomicrmw _and %40, %arg1 acq_rel : !llvm.ptr, i32
    %42 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %43 = llvm.getelementptr %42[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %44 = llvm.atomicrmw _xor %43, %arg1 acq_rel : !llvm.ptr, i32
    return
  }
}

// -----
module {
  func.func @atomic_rmw_with_offset(%arg0: memref<10xi32, strided<[1], offset: 5>>, %arg1: i32, %arg2: index) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<10xi32, strided<[1], offset: 5>> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.mlir.constant(5 : index) : i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %5 = llvm.getelementptr %4[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %6 = llvm.atomicrmw _and %5, %arg1 acq_rel : !llvm.ptr, i32
    return
  }
}

// -----
module {
  llvm.func @generic_atomic_rmw() {
    %0 = "test.foo"() : () -> memref<10xi32>
    %1 = builtin.unrealized_conversion_cast %0 : memref<10xi32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = "test.foo"() : () -> index
    %3 = builtin.unrealized_conversion_cast %2 : index to i64
    %4 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.getelementptr %4[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %6 = llvm.load %5 : !llvm.ptr -> i32
    llvm.br ^bb1(%6 : i32)
  ^bb1(%7: i32):  // 2 preds: ^bb0, ^bb1
    %8 = llvm.cmpxchg %5, %7, %7 acq_rel monotonic : !llvm.ptr, i32
    %9 = llvm.extractvalue %8[0] : !llvm.struct<(i32, i1)> 
    %10 = llvm.extractvalue %8[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %10, ^bb2, ^bb1(%9 : i32)
  ^bb2:  // pred: ^bb1
    llvm.return
  }
}

// -----
module {
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.func @generic_atomic_rmw_in_alloca_scope() {
    %c1 = arith.constant 1 : index
    %0 = builtin.unrealized_conversion_cast %c1 : index to i64
    %1 = llvm.mlir.constant(2 : index) : i64
    %2 = llvm.mlir.constant(3 : index) : i64
    %3 = llvm.mlir.constant(1 : index) : i64
    %4 = llvm.mlir.constant(6 : index) : i64
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.getelementptr %5[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %7 = llvm.ptrtoint %6 : !llvm.ptr to i64
    %8 = llvm.call @malloc(%7) : (i64) -> !llvm.ptr
    %9 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %10 = llvm.insertvalue %8, %9[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.insertvalue %8, %10[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %12 = llvm.mlir.constant(0 : index) : i64
    %13 = llvm.insertvalue %12, %11[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = llvm.insertvalue %1, %13[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %15 = llvm.insertvalue %2, %14[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %16 = llvm.insertvalue %2, %15[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %17 = llvm.insertvalue %3, %16[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %18 = llvm.intr.stacksave : !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %19 = llvm.extractvalue %17[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %20 = llvm.mlir.constant(3 : index) : i64
    %21 = llvm.mul %0, %20 : i64
    %22 = llvm.add %21, %0 : i64
    %23 = llvm.getelementptr %19[%22] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %24 = llvm.load %23 : !llvm.ptr -> i32
    llvm.br ^bb2(%24 : i32)
  ^bb2(%25: i32):  // 2 preds: ^bb1, ^bb2
    %26 = llvm.cmpxchg %23, %25, %25 acq_rel monotonic : !llvm.ptr, i32
    %27 = llvm.extractvalue %26[0] : !llvm.struct<(i32, i1)> 
    %28 = llvm.extractvalue %26[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %28, ^bb3, ^bb2(%27 : i32)
  ^bb3:  // pred: ^bb2
    llvm.intr.stackrestore %18 : !llvm.ptr
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    llvm.return
  }
}

// -----
module {
  llvm.func @malloc(i64) -> !llvm.ptr
  func.func @memref_copy_ranked() {
    %0 = llvm.mlir.constant(2 : index) : i64
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i64
    %5 = llvm.call @malloc(%4) : (i64) -> !llvm.ptr
    %6 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %7 = llvm.insertvalue %5, %6[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %8 = llvm.insertvalue %5, %7[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.mlir.constant(0 : index) : i64
    %10 = llvm.insertvalue %9, %8[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.insertvalue %0, %10[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.insertvalue %1, %11[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.mlir.constant(2 : index) : i64
    %14 = llvm.mlir.constant(1 : index) : i64
    %15 = llvm.mlir.zero : !llvm.ptr
    %16 = llvm.getelementptr %15[%13] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %17 = llvm.ptrtoint %16 : !llvm.ptr to i64
    %18 = llvm.call @malloc(%17) : (i64) -> !llvm.ptr
    %19 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %20 = llvm.insertvalue %18, %19[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %21 = llvm.insertvalue %18, %20[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %22 = llvm.mlir.constant(0 : index) : i64
    %23 = llvm.insertvalue %22, %21[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %24 = llvm.insertvalue %13, %23[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %25 = llvm.insertvalue %14, %24[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %26 = llvm.mlir.constant(1 : index) : i64
    %27 = llvm.extractvalue %12[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %28 = llvm.mul %26, %27 : i64
    %29 = llvm.mlir.zero : !llvm.ptr
    %30 = llvm.getelementptr %29[1] : (!llvm.ptr) -> !llvm.ptr, f32
    %31 = llvm.ptrtoint %30 : !llvm.ptr to i64
    %32 = llvm.mul %28, %31 : i64
    %33 = llvm.extractvalue %12[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %34 = llvm.extractvalue %12[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %35 = llvm.getelementptr %33[%34] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %36 = llvm.extractvalue %25[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %37 = llvm.extractvalue %25[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %38 = llvm.getelementptr %36[%37] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    "llvm.intr.memcpy"(%38, %35, %32) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    return
  }
}

// -----
module {
  llvm.func @malloc(i64) -> !llvm.ptr
  func.func @memref_copy_contiguous(%arg0: memref<16x4xi32>, %arg1: index) {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.constant(2 : index) : i64
    %2 = llvm.mlir.constant(1 : index) : i64
    %3 = llvm.mlir.constant(2 : index) : i64
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.getelementptr %4[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
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
    %subview = memref.subview %arg0[%arg1, 0] [1, 2] [1, 1] : memref<16x4xi32> to memref<1x2xi32, strided<[4, 1], offset: ?>>
    %17 = builtin.unrealized_conversion_cast %subview : memref<1x2xi32, strided<[4, 1], offset: ?>> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %18 = llvm.mlir.constant(1 : index) : i64
    %19 = llvm.extractvalue %17[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %20 = llvm.mul %18, %19 : i64
    %21 = llvm.extractvalue %17[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %22 = llvm.mul %20, %21 : i64
    %23 = llvm.mlir.zero : !llvm.ptr
    %24 = llvm.getelementptr %23[1] : (!llvm.ptr) -> !llvm.ptr, i32
    %25 = llvm.ptrtoint %24 : !llvm.ptr to i64
    %26 = llvm.mul %22, %25 : i64
    %27 = llvm.extractvalue %17[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %28 = llvm.extractvalue %17[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %29 = llvm.getelementptr %27[%28] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %30 = llvm.extractvalue %16[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %31 = llvm.extractvalue %16[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %32 = llvm.getelementptr %30[%31] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    "llvm.intr.memcpy"(%32, %29, %26) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    return
  }
}

// -----
module {
  llvm.func @malloc(i64) -> !llvm.ptr
  func.func @memref_copy_0d_offset(%arg0: memref<2xi32>) {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.getelementptr %1[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i64
    %4 = llvm.call @malloc(%3) : (i64) -> !llvm.ptr
    %5 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64)>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.struct<(ptr, ptr, i64)> 
    %7 = llvm.insertvalue %4, %6[1] : !llvm.struct<(ptr, ptr, i64)> 
    %8 = llvm.mlir.constant(0 : index) : i64
    %9 = llvm.insertvalue %8, %7[2] : !llvm.struct<(ptr, ptr, i64)> 
    %subview = memref.subview %arg0[1] [1] [1] : memref<2xi32> to memref<1xi32, strided<[1], offset: 1>>
    %collapse_shape = memref.collapse_shape %subview [] : memref<1xi32, strided<[1], offset: 1>> into memref<i32, strided<[], offset: 1>>
    %10 = builtin.unrealized_conversion_cast %collapse_shape : memref<i32, strided<[], offset: 1>> to !llvm.struct<(ptr, ptr, i64)>
    %11 = llvm.mlir.constant(1 : index) : i64
    %12 = llvm.mlir.zero : !llvm.ptr
    %13 = llvm.getelementptr %12[1] : (!llvm.ptr) -> !llvm.ptr, i32
    %14 = llvm.ptrtoint %13 : !llvm.ptr to i64
    %15 = llvm.mul %11, %14 : i64
    %16 = llvm.extractvalue %10[1] : !llvm.struct<(ptr, ptr, i64)> 
    %17 = llvm.extractvalue %10[2] : !llvm.struct<(ptr, ptr, i64)> 
    %18 = llvm.getelementptr %16[%17] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %19 = llvm.extractvalue %9[1] : !llvm.struct<(ptr, ptr, i64)> 
    %20 = llvm.extractvalue %9[2] : !llvm.struct<(ptr, ptr, i64)> 
    %21 = llvm.getelementptr %19[%20] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    "llvm.intr.memcpy"(%21, %18, %15) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    return
  }
}

// -----
module {
  llvm.func @memrefCopy(i64, !llvm.ptr, !llvm.ptr)
  llvm.func @malloc(i64) -> !llvm.ptr
  func.func @memref_copy_noncontiguous(%arg0: memref<16x2xi32>, %arg1: index) {
    %0 = llvm.mlir.constant(2 : index) : i64
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.constant(1 : index) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.getelementptr %3[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %5 = llvm.ptrtoint %4 : !llvm.ptr to i64
    %6 = llvm.call @malloc(%5) : (i64) -> !llvm.ptr
    %7 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %9 = llvm.insertvalue %6, %8[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %10 = llvm.mlir.constant(0 : index) : i64
    %11 = llvm.insertvalue %10, %9[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %12 = llvm.insertvalue %0, %11[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.insertvalue %1, %12[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = llvm.insertvalue %1, %13[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %15 = llvm.insertvalue %2, %14[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %subview = memref.subview %arg0[%arg1, 0] [2, 1] [1, 1] : memref<16x2xi32> to memref<2x1xi32, strided<[2, 1], offset: ?>>
    %16 = builtin.unrealized_conversion_cast %subview : memref<2x1xi32, strided<[2, 1], offset: ?>> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %17 = llvm.intr.stacksave : !llvm.ptr
    %18 = llvm.mlir.constant(2 : i64) : i64
    %19 = llvm.mlir.constant(1 : index) : i64
    %20 = llvm.alloca %19 x !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> : (i64) -> !llvm.ptr
    llvm.store %16, %20 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr
    %21 = llvm.mlir.poison : !llvm.struct<(i64, ptr)>
    %22 = llvm.insertvalue %18, %21[0] : !llvm.struct<(i64, ptr)> 
    %23 = llvm.insertvalue %20, %22[1] : !llvm.struct<(i64, ptr)> 
    %24 = llvm.mlir.constant(2 : i64) : i64
    %25 = llvm.mlir.constant(1 : index) : i64
    %26 = llvm.alloca %25 x !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> : (i64) -> !llvm.ptr
    llvm.store %15, %26 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr
    %27 = llvm.mlir.poison : !llvm.struct<(i64, ptr)>
    %28 = llvm.insertvalue %24, %27[0] : !llvm.struct<(i64, ptr)> 
    %29 = llvm.insertvalue %26, %28[1] : !llvm.struct<(i64, ptr)> 
    %30 = llvm.mlir.constant(1 : index) : i64
    %31 = llvm.alloca %30 x !llvm.struct<(i64, ptr)> : (i64) -> !llvm.ptr
    llvm.store %23, %31 : !llvm.struct<(i64, ptr)>, !llvm.ptr
    %32 = llvm.alloca %30 x !llvm.struct<(i64, ptr)> : (i64) -> !llvm.ptr
    llvm.store %29, %32 : !llvm.struct<(i64, ptr)>, !llvm.ptr
    %33 = llvm.mlir.zero : !llvm.ptr
    %34 = llvm.getelementptr %33[1] : (!llvm.ptr) -> !llvm.ptr, i32
    %35 = llvm.ptrtoint %34 : !llvm.ptr to i64
    llvm.call @memrefCopy(%35, %31, %32) : (i64, !llvm.ptr, !llvm.ptr) -> ()
    llvm.intr.stackrestore %17 : !llvm.ptr
    return
  }
}

// -----
module {
  llvm.func @memrefCopy(i64, !llvm.ptr, !llvm.ptr)
  llvm.func @malloc(i64) -> !llvm.ptr
  func.func @memref_copy_unranked() {
    %0 = llvm.mlir.constant(2 : index) : i64
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i1
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i64
    %5 = llvm.call @malloc(%4) : (i64) -> !llvm.ptr
    %6 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %7 = llvm.insertvalue %5, %6[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %8 = llvm.insertvalue %5, %7[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.mlir.constant(0 : index) : i64
    %10 = llvm.insertvalue %9, %8[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.insertvalue %0, %10[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.insertvalue %1, %11[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.mlir.constant(1 : index) : i64
    %14 = llvm.alloca %13 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> : (i64) -> !llvm.ptr
    llvm.store %12, %14 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    %15 = llvm.mlir.constant(1 : index) : i64
    %16 = llvm.mlir.poison : !llvm.struct<(i64, ptr)>
    %17 = llvm.insertvalue %15, %16[0] : !llvm.struct<(i64, ptr)> 
    %18 = llvm.insertvalue %14, %17[1] : !llvm.struct<(i64, ptr)> 
    %19 = llvm.mlir.constant(2 : index) : i64
    %20 = llvm.mlir.constant(1 : index) : i64
    %21 = llvm.mlir.zero : !llvm.ptr
    %22 = llvm.getelementptr %21[%19] : (!llvm.ptr, i64) -> !llvm.ptr, i1
    %23 = llvm.ptrtoint %22 : !llvm.ptr to i64
    %24 = llvm.call @malloc(%23) : (i64) -> !llvm.ptr
    %25 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %26 = llvm.insertvalue %24, %25[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %27 = llvm.insertvalue %24, %26[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %28 = llvm.mlir.constant(0 : index) : i64
    %29 = llvm.insertvalue %28, %27[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %30 = llvm.insertvalue %19, %29[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %31 = llvm.insertvalue %20, %30[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %32 = llvm.mlir.constant(1 : index) : i64
    %33 = llvm.alloca %32 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> : (i64) -> !llvm.ptr
    llvm.store %31, %33 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    %34 = llvm.mlir.constant(1 : index) : i64
    %35 = llvm.mlir.poison : !llvm.struct<(i64, ptr)>
    %36 = llvm.insertvalue %34, %35[0] : !llvm.struct<(i64, ptr)> 
    %37 = llvm.insertvalue %33, %36[1] : !llvm.struct<(i64, ptr)> 
    %38 = llvm.intr.stacksave : !llvm.ptr
    %39 = llvm.mlir.constant(1 : index) : i64
    %40 = llvm.alloca %39 x !llvm.struct<(i64, ptr)> : (i64) -> !llvm.ptr
    llvm.store %18, %40 : !llvm.struct<(i64, ptr)>, !llvm.ptr
    %41 = llvm.alloca %39 x !llvm.struct<(i64, ptr)> : (i64) -> !llvm.ptr
    llvm.store %37, %41 : !llvm.struct<(i64, ptr)>, !llvm.ptr
    %42 = llvm.mlir.zero : !llvm.ptr
    %43 = llvm.getelementptr %42[1] : (!llvm.ptr) -> !llvm.ptr, i1
    %44 = llvm.ptrtoint %43 : !llvm.ptr to i64
    llvm.call @memrefCopy(%44, %40, %41) : (i64, !llvm.ptr, !llvm.ptr) -> ()
    llvm.intr.stackrestore %38 : !llvm.ptr
    return
  }
}

// -----
module {
  func.func @extract_aligned_pointer_as_index(%arg0: memref<?xf32>) -> index {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = builtin.unrealized_conversion_cast %2 : i64 to index
    return %3 : index
  }
}

// -----
module {
  func.func @extract_aligned_pointer_as_index_unranked(%arg0: memref<*xf32>) -> index {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<*xf32> to !llvm.struct<(i64, ptr)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i64, ptr)> 
    %2 = llvm.getelementptr %1[1] : (!llvm.ptr) -> !llvm.ptr, !llvm.ptr
    %3 = llvm.load %2 : !llvm.ptr -> !llvm.ptr
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i64
    %5 = builtin.unrealized_conversion_cast %4 : i64 to index
    return %5 : index
  }
}

// -----
module {
  func.func @extract_strided_metadata(%arg0: memref<?x?xf32, strided<[?, ?], offset: ?>>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?x?xf32, strided<[?, ?], offset: ?>> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64)>
    %4 = llvm.insertvalue %1, %3[0] : !llvm.struct<(ptr, ptr, i64)> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.struct<(ptr, ptr, i64)> 
    %6 = llvm.mlir.constant(0 : index) : i64
    %7 = llvm.insertvalue %6, %5[2] : !llvm.struct<(ptr, ptr, i64)> 
    %8 = llvm.extractvalue %0[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %9 = llvm.extractvalue %0[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %10 = llvm.extractvalue %0[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %12 = llvm.extractvalue %0[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    return
  }
}

// -----
module {
  func.func @load_non_temporal(%arg0: memref<32xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<32xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c7 = arith.constant 7 : index
    %1 = builtin.unrealized_conversion_cast %c7 : index to i64
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.getelementptr inbounds|nuw %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %4 = llvm.load %3 {nontemporal} : !llvm.ptr -> f32
    return
  }
}

// -----
module {
  func.func @load_with_alignment(%arg0: memref<32xf32>, %arg1: index) {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<32xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.getelementptr inbounds|nuw %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %4 = llvm.load %3 {alignment = 32 : i64} : !llvm.ptr -> f32
    return
  }
}

// -----
module {
  func.func @store_non_temporal(%arg0: memref<32xf32>, %arg1: memref<32xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<32xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<32xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c7 = arith.constant 7 : index
    %2 = builtin.unrealized_conversion_cast %c7 : index to i64
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.getelementptr inbounds|nuw %3[%2] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %5 = llvm.load %4 {nontemporal} : !llvm.ptr -> f32
    %6 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %7 = llvm.getelementptr inbounds|nuw %6[%2] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %5, %7 {nontemporal} : f32, !llvm.ptr
    return
  }
}

// -----
module {
  func.func @store_with_alignment(%arg0: memref<32xf32>, %arg1: f32, %arg2: index) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<32xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.getelementptr inbounds|nuw %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %arg1, %3 {alignment = 32 : i64} : f32, !llvm.ptr
    return
  }
}

// -----
module {
  func.func @alloca_unconvertable_memory_space() {
    %alloca = memref.alloca() : memref<1x32x33xi32, #spirv.storage_class<StorageBuffer>>
    return
  }
}

