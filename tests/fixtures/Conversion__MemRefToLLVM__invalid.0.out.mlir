module {
  llvm.func @malloc(i64)
  func.func @redef_reserved() {
    %alloc = memref.alloc() : memref<1024x64xf32, 1>
    llvm.return
  }
}

// -----
module {
  func.func @bad_address_space(%arg0: memref<2xindex, "foo">) {
    %c0 = arith.constant 0 : index
    memref.store %c0, %arg0[%c0] : memref<2xindex, "foo">
    return
  }
}

// -----
module {
  func.func @invalid_int_conversion() {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<10xf32, 1 : ui64>
    return
  }
}

// -----
module {
  llvm.func @malloc(i64) -> !llvm.ptr
  func.func @issue_70160() {
    %alloc = memref.alloc() : memref<1x32x33xi32, #gpu.address_space<workgroup>>
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
    %c0 = arith.constant 0 : index
    %10 = memref.load %alloc[%c0, %c0, %c0] : memref<1x32x33xi32, #gpu.address_space<workgroup>>
    %11 = llvm.extractvalue %9[1] : !llvm.struct<(ptr, ptr, i64)> 
    llvm.store %10, %11 : i32, !llvm.ptr
    return
  }
}

// -----
module {
  func.func @test_atomic_exch(%arg0: memref<?xi32>, %arg1: index, %arg2: i32) {
    %0 = memref.generic_atomic_rmw %arg0[%arg1] : memref<?xi32> {
    ^bb0(%arg3: i32):
      memref.atomic_yield %arg2 : i32
    }
    return
  }
}

