module {
  llvm.func @malloc(i64) -> !llvm.ptr
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
    %9 = llvm.call @malloc(%8) : (i64) -> !llvm.ptr
    %10 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %11 = llvm.insertvalue %9, %10[0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %12 = llvm.insertvalue %9, %11[1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %13 = llvm.mlir.constant(0 : index) : i64
    %14 = llvm.insertvalue %13, %12[2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %15 = llvm.insertvalue %1, %14[3, 0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %16 = llvm.insertvalue %2, %15[3, 1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %17 = llvm.insertvalue %0, %16[3, 2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %18 = llvm.insertvalue %4, %17[4, 0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %19 = llvm.insertvalue %0, %18[4, 1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %20 = llvm.insertvalue %3, %19[4, 2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %21 = builtin.unrealized_conversion_cast %20 : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> to memref<?x42x?xf32>
    return %21 : memref<?x42x?xf32>
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
  llvm.func @malloc(i64) -> !llvm.ptr
  func.func @dynamic_alloc(%arg0: index, %arg1: index) -> memref<?x?xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %2 = llvm.mlir.constant(1 : index) : i64
    %3 = llvm.mul %0, %1 : i64
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.getelementptr %4[%3] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %6 = llvm.ptrtoint %5 : !llvm.ptr to i64
    %7 = llvm.call @malloc(%6) : (i64) -> !llvm.ptr
    %8 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %10 = llvm.insertvalue %7, %9[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.mlir.constant(0 : index) : i64
    %12 = llvm.insertvalue %11, %10[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.insertvalue %1, %12[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = llvm.insertvalue %0, %13[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %15 = llvm.insertvalue %0, %14[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %16 = llvm.insertvalue %2, %15[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %17 = builtin.unrealized_conversion_cast %16 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> to memref<?x?xf32>
    return %17 : memref<?x?xf32>
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
  llvm.func @malloc(i64) -> !llvm.ptr
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
    %9 = llvm.add %7, %8 : i64
    %10 = llvm.call @malloc(%9) : (i64) -> !llvm.ptr
    %11 = llvm.ptrtoint %10 : !llvm.ptr to i64
    %12 = llvm.mlir.constant(1 : index) : i64
    %13 = llvm.sub %8, %12 : i64
    %14 = llvm.add %11, %13 : i64
    %15 = llvm.urem %14, %8 : i64
    %16 = llvm.sub %14, %15 : i64
    %17 = llvm.inttoptr %16 : i64 to !llvm.ptr
    %18 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %19 = llvm.insertvalue %10, %18[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %20 = llvm.insertvalue %17, %19[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %21 = llvm.mlir.constant(0 : index) : i64
    %22 = llvm.insertvalue %21, %20[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %23 = llvm.insertvalue %1, %22[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %24 = llvm.insertvalue %2, %23[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %25 = llvm.insertvalue %2, %24[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %26 = llvm.insertvalue %3, %25[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %27 = builtin.unrealized_conversion_cast %26 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> to memref<32x18xf32>
    %28 = llvm.mlir.constant(4096 : index) : i64
    %29 = llvm.mlir.constant(1 : index) : i64
    %30 = llvm.mlir.zero : !llvm.ptr
    %31 = llvm.getelementptr %30[%28] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %32 = llvm.ptrtoint %31 : !llvm.ptr to i64
    %33 = llvm.mlir.constant(64 : index) : i64
    %34 = llvm.add %32, %33 : i64
    %35 = llvm.call @malloc(%34) : (i64) -> !llvm.ptr
    %36 = llvm.ptrtoint %35 : !llvm.ptr to i64
    %37 = llvm.mlir.constant(1 : index) : i64
    %38 = llvm.sub %33, %37 : i64
    %39 = llvm.add %36, %38 : i64
    %40 = llvm.urem %39, %33 : i64
    %41 = llvm.sub %39, %40 : i64
    %42 = llvm.inttoptr %41 : i64 to !llvm.ptr
    %43 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %44 = llvm.insertvalue %35, %43[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %45 = llvm.insertvalue %42, %44[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %46 = llvm.mlir.constant(0 : index) : i64
    %47 = llvm.insertvalue %46, %45[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %48 = llvm.insertvalue %28, %47[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %49 = llvm.insertvalue %29, %48[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %50 = llvm.mlir.constant(4096 : index) : i64
    %51 = llvm.mlir.constant(1 : index) : i64
    %52 = llvm.mlir.zero : !llvm.ptr
    %53 = llvm.getelementptr %52[%50] : (!llvm.ptr, i64) -> !llvm.ptr, vector<8xf32>
    %54 = llvm.ptrtoint %53 : !llvm.ptr to i64
    %55 = llvm.mlir.zero : !llvm.ptr
    %56 = llvm.getelementptr %55[1] : (!llvm.ptr) -> !llvm.ptr, vector<8xf32>
    %57 = llvm.ptrtoint %56 : !llvm.ptr to i64
    %58 = llvm.add %54, %57 : i64
    %59 = llvm.call @malloc(%58) : (i64) -> !llvm.ptr
    %60 = llvm.ptrtoint %59 : !llvm.ptr to i64
    %61 = llvm.mlir.constant(1 : index) : i64
    %62 = llvm.sub %57, %61 : i64
    %63 = llvm.add %60, %62 : i64
    %64 = llvm.urem %63, %57 : i64
    %65 = llvm.sub %63, %64 : i64
    %66 = llvm.inttoptr %65 : i64 to !llvm.ptr
    %67 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %68 = llvm.insertvalue %59, %67[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %69 = llvm.insertvalue %66, %68[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %70 = llvm.mlir.constant(0 : index) : i64
    %71 = llvm.insertvalue %70, %69[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %72 = llvm.insertvalue %50, %71[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %73 = llvm.insertvalue %51, %72[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %74 = llvm.mlir.constant(4096 : index) : i64
    %75 = llvm.mlir.constant(1 : index) : i64
    %76 = llvm.mlir.zero : !llvm.ptr
    %77 = llvm.getelementptr %76[%74] : (!llvm.ptr, i64) -> !llvm.ptr, vector<2xf32>
    %78 = llvm.ptrtoint %77 : !llvm.ptr to i64
    %79 = llvm.mlir.zero : !llvm.ptr
    %80 = llvm.getelementptr %79[1] : (!llvm.ptr) -> !llvm.ptr, vector<2xf32>
    %81 = llvm.ptrtoint %80 : !llvm.ptr to i64
    %82 = llvm.add %78, %81 : i64
    %83 = llvm.call @malloc(%82) : (i64) -> !llvm.ptr
    %84 = llvm.ptrtoint %83 : !llvm.ptr to i64
    %85 = llvm.mlir.constant(1 : index) : i64
    %86 = llvm.sub %81, %85 : i64
    %87 = llvm.add %84, %86 : i64
    %88 = llvm.urem %87, %81 : i64
    %89 = llvm.sub %87, %88 : i64
    %90 = llvm.inttoptr %89 : i64 to !llvm.ptr
    %91 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %92 = llvm.insertvalue %83, %91[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %93 = llvm.insertvalue %90, %92[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %94 = llvm.mlir.constant(0 : index) : i64
    %95 = llvm.insertvalue %94, %93[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %96 = llvm.insertvalue %74, %95[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %97 = llvm.insertvalue %75, %96[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %98 = llvm.mlir.constant(1024 : index) : i64
    %99 = llvm.mlir.constant(1 : index) : i64
    %100 = llvm.mlir.zero : !llvm.ptr
    %101 = llvm.getelementptr %100[%98] : (!llvm.ptr, i64) -> !llvm.ptr, vector<4xf32>
    %102 = llvm.ptrtoint %101 : !llvm.ptr to i64
    %103 = llvm.mlir.constant(8 : index) : i64
    %104 = llvm.add %102, %103 : i64
    %105 = llvm.call @malloc(%104) : (i64) -> !llvm.ptr
    %106 = llvm.ptrtoint %105 : !llvm.ptr to i64
    %107 = llvm.mlir.constant(1 : index) : i64
    %108 = llvm.sub %103, %107 : i64
    %109 = llvm.add %106, %108 : i64
    %110 = llvm.urem %109, %103 : i64
    %111 = llvm.sub %109, %110 : i64
    %112 = llvm.inttoptr %111 : i64 to !llvm.ptr
    %113 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %114 = llvm.insertvalue %105, %113[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %115 = llvm.insertvalue %112, %114[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %116 = llvm.mlir.constant(0 : index) : i64
    %117 = llvm.insertvalue %116, %115[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %118 = llvm.insertvalue %98, %117[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %119 = llvm.insertvalue %99, %118[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %120 = llvm.mlir.constant(100 : index) : i64
    %121 = llvm.mlir.constant(1 : index) : i64
    %122 = llvm.mlir.zero : !llvm.ptr
    %123 = llvm.getelementptr %122[%120] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %124 = llvm.ptrtoint %123 : !llvm.ptr to i64
    %125 = llvm.mlir.constant(32 : index) : i64
    %126 = llvm.add %124, %125 : i64
    %127 = llvm.call @malloc(%126) : (i64) -> !llvm.ptr
    %128 = llvm.ptrtoint %127 : !llvm.ptr to i64
    %129 = llvm.mlir.constant(1 : index) : i64
    %130 = llvm.sub %125, %129 : i64
    %131 = llvm.add %128, %130 : i64
    %132 = llvm.urem %131, %125 : i64
    %133 = llvm.sub %131, %132 : i64
    %134 = llvm.inttoptr %133 : i64 to !llvm.ptr
    %135 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %136 = llvm.insertvalue %127, %135[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %137 = llvm.insertvalue %134, %136[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %138 = llvm.mlir.constant(0 : index) : i64
    %139 = llvm.insertvalue %138, %137[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %140 = llvm.insertvalue %120, %139[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %141 = llvm.insertvalue %121, %140[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %142 = llvm.mlir.constant(1 : index) : i64
    %143 = llvm.mlir.zero : !llvm.ptr
    %144 = llvm.getelementptr %143[%0] : (!llvm.ptr, i64) -> !llvm.ptr, vector<18xf32>
    %145 = llvm.ptrtoint %144 : !llvm.ptr to i64
    %146 = llvm.mlir.zero : !llvm.ptr
    %147 = llvm.getelementptr %146[1] : (!llvm.ptr) -> !llvm.ptr, vector<18xf32>
    %148 = llvm.ptrtoint %147 : !llvm.ptr to i64
    %149 = llvm.add %145, %148 : i64
    %150 = llvm.call @malloc(%149) : (i64) -> !llvm.ptr
    %151 = llvm.ptrtoint %150 : !llvm.ptr to i64
    %152 = llvm.mlir.constant(1 : index) : i64
    %153 = llvm.sub %148, %152 : i64
    %154 = llvm.add %151, %153 : i64
    %155 = llvm.urem %154, %148 : i64
    %156 = llvm.sub %154, %155 : i64
    %157 = llvm.inttoptr %156 : i64 to !llvm.ptr
    %158 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %159 = llvm.insertvalue %150, %158[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %160 = llvm.insertvalue %157, %159[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %161 = llvm.mlir.constant(0 : index) : i64
    %162 = llvm.insertvalue %161, %160[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %163 = llvm.insertvalue %0, %162[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %164 = llvm.insertvalue %142, %163[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    return %27 : memref<32x18xf32>
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
  llvm.func @malloc(i64) -> !llvm.ptr
  func.func @memref_of_memref() {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i64
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.getelementptr %5[1] : (!llvm.ptr) -> !llvm.ptr, !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %7 = llvm.ptrtoint %6 : !llvm.ptr to i64
    %8 = llvm.add %4, %7 : i64
    %9 = llvm.call @malloc(%8) : (i64) -> !llvm.ptr
    %10 = llvm.ptrtoint %9 : !llvm.ptr to i64
    %11 = llvm.mlir.constant(1 : index) : i64
    %12 = llvm.sub %7, %11 : i64
    %13 = llvm.add %10, %12 : i64
    %14 = llvm.urem %13, %7 : i64
    %15 = llvm.sub %13, %14 : i64
    %16 = llvm.inttoptr %15 : i64 to !llvm.ptr
    %17 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %18 = llvm.insertvalue %9, %17[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %19 = llvm.insertvalue %16, %18[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %20 = llvm.mlir.constant(0 : index) : i64
    %21 = llvm.insertvalue %20, %19[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %22 = llvm.insertvalue %0, %21[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %23 = llvm.insertvalue %1, %22[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    return
  }
}

// -----
module attributes {dlti.dl_spec = #dlti.dl_spec<index = 32 : i64>} {
  llvm.func @malloc(i32) -> !llvm.ptr
  func.func @memref_of_memref_32() {
    %0 = llvm.mlir.constant(1 : index) : i32
    %1 = llvm.mlir.constant(1 : index) : i32
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i32
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.getelementptr %5[1] : (!llvm.ptr) -> !llvm.ptr, !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
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
  llvm.func @malloc(i64) -> !llvm.ptr
  func.func @memref_of_memref_of_memref() {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i64
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.getelementptr %5[1] : (!llvm.ptr) -> !llvm.ptr, !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %7 = llvm.ptrtoint %6 : !llvm.ptr to i64
    %8 = llvm.add %4, %7 : i64
    %9 = llvm.call @malloc(%8) : (i64) -> !llvm.ptr
    %10 = llvm.ptrtoint %9 : !llvm.ptr to i64
    %11 = llvm.mlir.constant(1 : index) : i64
    %12 = llvm.sub %7, %11 : i64
    %13 = llvm.add %10, %12 : i64
    %14 = llvm.urem %13, %7 : i64
    %15 = llvm.sub %13, %14 : i64
    %16 = llvm.inttoptr %15 : i64 to !llvm.ptr
    %17 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %18 = llvm.insertvalue %9, %17[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %19 = llvm.insertvalue %16, %18[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %20 = llvm.mlir.constant(0 : index) : i64
    %21 = llvm.insertvalue %20, %19[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %22 = llvm.insertvalue %0, %21[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %23 = llvm.insertvalue %1, %22[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    return
  }
}

// -----
module {
  llvm.func @malloc(i64) -> !llvm.ptr
  func.func @ranked_unranked() {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<(i64, ptr)>
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i64
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.getelementptr %5[1] : (!llvm.ptr) -> !llvm.ptr, !llvm.struct<(i64, ptr)>
    %7 = llvm.ptrtoint %6 : !llvm.ptr to i64
    %8 = llvm.add %4, %7 : i64
    %9 = llvm.call @malloc(%8) : (i64) -> !llvm.ptr
    %10 = llvm.ptrtoint %9 : !llvm.ptr to i64
    %11 = llvm.mlir.constant(1 : index) : i64
    %12 = llvm.sub %7, %11 : i64
    %13 = llvm.add %10, %12 : i64
    %14 = llvm.urem %13, %7 : i64
    %15 = llvm.sub %13, %14 : i64
    %16 = llvm.inttoptr %15 : i64 to !llvm.ptr
    %17 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %18 = llvm.insertvalue %9, %17[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %19 = llvm.insertvalue %16, %18[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %20 = llvm.mlir.constant(0 : index) : i64
    %21 = llvm.insertvalue %20, %19[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %22 = llvm.insertvalue %0, %21[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %23 = llvm.insertvalue %1, %22[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %24 = llvm.mlir.constant(1 : index) : i64
    %25 = llvm.alloca %24 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> : (i64) -> !llvm.ptr
    llvm.store %23, %25 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    %26 = llvm.mlir.constant(1 : index) : i64
    %27 = llvm.mlir.poison : !llvm.struct<(i64, ptr)>
    %28 = llvm.insertvalue %26, %27[0] : !llvm.struct<(i64, ptr)> 
    %29 = llvm.insertvalue %25, %28[1] : !llvm.struct<(i64, ptr)> 
    return
  }
}

