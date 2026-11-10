module {
  func.func @glb_prefetch0(%arg0: memref<64x64xf16, #gpu.address_space<global>>, %arg1: i64, %arg2: i64) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<64x64xf16, #gpu.address_space<global>> to !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.mlir.constant(64 : index) : i64
    %3 = llvm.mul %arg1, %2 overflow<nsw, nuw> : i64
    %4 = llvm.add %3, %arg2 overflow<nsw, nuw> : i64
    %5 = llvm.getelementptr inbounds|nuw %1[%4] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f16
    rocdl.global.prefetch %5, gfx12<lu> : !llvm.ptr<1>
    return
  }
  func.func @glb_prefetch1(%arg0: memref<64x64xf16, #gpu.address_space<global>>, %arg1: i64, %arg2: i64) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<64x64xf16, #gpu.address_space<global>> to !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.mlir.constant(64 : index) : i64
    %3 = llvm.mul %arg1, %2 : i64
    %4 = llvm.add %3, %arg2 : i64
    %5 = llvm.getelementptr %1[%4] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f16
    rocdl.global.prefetch %5, gfx12<ht|scope_se> : !llvm.ptr<1>
    return
  }
  func.func @glb_prefetch2(%arg0: memref<64x64xf16, #gpu.address_space<global>>, %arg1: i64, %arg2: i64) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<64x64xf16, #gpu.address_space<global>> to !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.mlir.constant(64 : index) : i64
    %3 = llvm.mul %arg1, %2 : i64
    %4 = llvm.add %3, %arg2 : i64
    %5 = llvm.getelementptr %1[%4] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f16
    rocdl.global.prefetch %5, gfx12<scope_dev> : !llvm.ptr<1>
    return
  }
  func.func @glb_prefetch3(%arg0: memref<64x64xf16, #gpu.address_space<global>>, %arg1: i64, %arg2: i64) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<64x64xf16, #gpu.address_space<global>> to !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.mlir.constant(64 : index) : i64
    %3 = llvm.mul %arg1, %2 : i64
    %4 = llvm.add %3, %arg2 : i64
    %5 = llvm.getelementptr %1[%4] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f16
    rocdl.global.prefetch %5, gfx12<nt_rt|scope_se> : !llvm.ptr<1>
    return
  }
}

