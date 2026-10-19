module {
  llvm.func @check_noalias(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) {
    llvm.return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0 * 20 + d1 + 1)>
#map1 = affine_map<(d0, d1)[s0] -> (d0 * s0 + d1 + 1)>
module {
  func.func @check_strided_memref_arguments(%arg0: memref<10x20xf32, #map>, %arg1: memref<?x?xf32, #map1>, %arg2: memref<10x?xf32, #map1>) {
    llvm.return
  }
}

// -----
module {
  llvm.func @memref_index(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.insertvalue %arg0, %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.mlir.constant(0 : index) : i64
    %4 = llvm.insertvalue %3, %2[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.mlir.constant(32 : index) : i64
    %6 = llvm.insertvalue %5, %4[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %7 = llvm.mlir.constant(1 : index) : i64
    %8 = llvm.insertvalue %7, %6[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.extractvalue %8[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.return %9 : !llvm.ptr
  }
}

// -----
module {
  func.func @check_arguments(%arg0: memref<10x20xf32>, %arg1: memref<?x?xf32>, %arg2: memref<10x?xf32>) {
    llvm.return
  }
}

// -----
module {
  func.func private @hoo(memref<*xi8>) -> memref<*xi8>
  func.func @check_unranked_memref_func_call(%arg0: memref<*xi8>) -> memref<*xi8> {
    %0 = call @hoo(%arg0) : (memref<*xi8>) -> memref<*xi8>
    return %0 : memref<*xi8>
  }
}

// -----
module {
  func.func private @unsupported_memref_element_type() -> memref<42x!test.memref_element>
  func.func private @unsupported_unranked_memref_element_type() -> memref<*x!test.memref_element>
}

// -----
module {
  llvm.func @goo(f32) -> f32 attributes {sym_visibility = "private"}
  llvm.func @check_scalar_func_call(%arg0: f32) {
    %0 = llvm.call @goo(%arg0) : (f32) -> f32
    llvm.return
  }
}

// -----
module {
  llvm.func @loop_carried(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: !llvm.ptr<201>, %arg4: !llvm.ptr<201>) -> !llvm.struct<(ptr<201>, ptr<201>)> {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg4, %0[0] : !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.insertvalue %arg4, %1[1] : !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.mlir.constant(0 : index) : i64
    %4 = llvm.insertvalue %3, %2[2] : !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.mlir.constant(64 : index) : i64
    %6 = llvm.insertvalue %5, %4[3, 0] : !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)> 
    %7 = llvm.mlir.constant(1 : index) : i64
    %8 = llvm.insertvalue %7, %6[4, 0] : !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.mlir.poison : !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.insertvalue %arg3, %9[0] : !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.insertvalue %arg3, %10[1] : !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.mlir.constant(0 : index) : i64
    %13 = llvm.insertvalue %12, %11[2] : !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.mlir.constant(64 : index) : i64
    %15 = llvm.insertvalue %14, %13[3, 0] : !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.mlir.constant(1 : index) : i64
    %17 = llvm.insertvalue %16, %15[4, 0] : !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.br ^bb1(%arg0, %17, %8 : i64, !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>)
  ^bb1(%18: i64, %19: !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>, %20: !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>):  // 2 preds: ^bb0, ^bb2
    %21 = llvm.icmp "slt" %18, %arg1 : i64
    llvm.cond_br %21, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %22 = llvm.add %18, %arg2 : i64
    llvm.br ^bb1(%22, %20, %19 : i64, !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>)
  ^bb3:  // pred: ^bb1
    %23 = llvm.extractvalue %19[0] : !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)> 
    %24 = llvm.extractvalue %20[0] : !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)> 
    %25 = llvm.mlir.poison : !llvm.struct<(ptr<201>, ptr<201>)>
    %26 = llvm.insertvalue %23, %25[0] : !llvm.struct<(ptr<201>, ptr<201>)> 
    %27 = llvm.insertvalue %24, %26[1] : !llvm.struct<(ptr<201>, ptr<201>)> 
    llvm.return %27 : !llvm.struct<(ptr<201>, ptr<201>)>
  }
}

