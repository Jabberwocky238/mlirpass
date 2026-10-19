module {
  gpu.module @kernel attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @private(%arg0: f32) {
      %0 = llvm.mlir.constant(4 : i64) : i64
      %1 = llvm.alloca %0 x f32 : (i64) -> !llvm.ptr<5>
      %2 = llvm.mlir.poison : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)>
      %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)> 
      %5 = llvm.mlir.constant(0 : index) : i64
      %6 = llvm.insertvalue %5, %4[2] : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)> 
      %7 = llvm.mlir.constant(4 : index) : i64
      %8 = llvm.insertvalue %7, %6[3, 0] : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)> 
      %9 = llvm.mlir.constant(1 : index) : i64
      %10 = llvm.insertvalue %9, %8[4, 0] : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)> 
      %11 = llvm.mlir.constant(0 : index) : i64
      %12 = llvm.extractvalue %10[1] : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)> 
      %13 = llvm.getelementptr inbounds|nuw %12[%11] : (!llvm.ptr<5>, i64) -> !llvm.ptr<5>, f32
      llvm.store %arg0, %13 : f32, !llvm.ptr<5>
      "terminator"() : () -> ()
    }
  }
}

// -----
module {
  gpu.module @kernel attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.mlir.global internal @__wg_workgroup_0() {addr_space = 3 : i32} : !llvm.array<4 x f32>
    llvm.func @workgroup(%arg0: f32) {
      %0 = llvm.mlir.addressof @__wg_workgroup_0 : !llvm.ptr<3>
      %1 = llvm.getelementptr %0[0, 0] : (!llvm.ptr<3>) -> !llvm.ptr<3>, !llvm.array<4 x f32>
      %2 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %5 = llvm.mlir.constant(0 : index) : i64
      %6 = llvm.insertvalue %5, %4[2] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %7 = llvm.mlir.constant(4 : index) : i64
      %8 = llvm.insertvalue %7, %6[3, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %9 = llvm.mlir.constant(1 : index) : i64
      %10 = llvm.insertvalue %9, %8[4, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %11 = llvm.mlir.constant(0 : index) : i64
      %12 = llvm.extractvalue %10[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %13 = llvm.getelementptr inbounds|nuw %12[%11] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
      llvm.store %arg0, %13 : f32, !llvm.ptr<3>
      "terminator"() : () -> ()
    }
  }
}

// -----
module {
  gpu.module @kernel attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.mlir.global internal @__wg_workgroup3d_0() {addr_space = 3 : i32} : !llvm.array<48 x f32>
    llvm.func @workgroup3d(%arg0: f32) {
      %0 = llvm.mlir.addressof @__wg_workgroup3d_0 : !llvm.ptr<3>
      %1 = llvm.getelementptr %0[0, 0] : (!llvm.ptr<3>) -> !llvm.ptr<3>, !llvm.array<48 x f32>
      %2 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)>
      %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)> 
      %5 = llvm.mlir.constant(0 : index) : i64
      %6 = llvm.insertvalue %5, %4[2] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)> 
      %7 = llvm.mlir.constant(4 : index) : i64
      %8 = llvm.insertvalue %7, %6[3, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)> 
      %9 = llvm.mlir.constant(12 : index) : i64
      %10 = llvm.insertvalue %9, %8[4, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)> 
      %11 = llvm.mlir.constant(2 : index) : i64
      %12 = llvm.insertvalue %11, %10[3, 1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)> 
      %13 = llvm.mlir.constant(6 : index) : i64
      %14 = llvm.insertvalue %13, %12[4, 1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)> 
      %15 = llvm.mlir.constant(6 : index) : i64
      %16 = llvm.insertvalue %15, %14[3, 2] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)> 
      %17 = llvm.mlir.constant(1 : index) : i64
      %18 = llvm.insertvalue %17, %16[4, 2] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)> 
      %19 = llvm.mlir.constant(0 : index) : i64
      %20 = llvm.extractvalue %18[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)> 
      %21 = llvm.mlir.constant(12 : index) : i64
      %22 = llvm.mul %19, %21 overflow<nsw, nuw> : i64
      %23 = llvm.mlir.constant(6 : index) : i64
      %24 = llvm.mul %19, %23 overflow<nsw, nuw> : i64
      %25 = llvm.add %22, %24 overflow<nsw, nuw> : i64
      %26 = llvm.add %25, %19 overflow<nsw, nuw> : i64
      %27 = llvm.getelementptr inbounds|nuw %20[%26] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
      llvm.store %arg0, %27 : f32, !llvm.ptr<3>
      "terminator"() : () -> ()
    }
  }
}

// -----
module {
  gpu.module @kernel attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.mlir.global internal @__wg_multiple_0() {addr_space = 3 : i32} : !llvm.array<1 x f32>
    llvm.mlir.global internal @__wg_multiple_1() {addr_space = 3 : i32} : !llvm.array<2 x f32>
    llvm.func @multiple(%arg0: f32) {
      %0 = llvm.mlir.addressof @__wg_multiple_0 : !llvm.ptr<3>
      %1 = llvm.getelementptr %0[0, 0] : (!llvm.ptr<3>) -> !llvm.ptr<3>, !llvm.array<1 x f32>
      %2 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %5 = llvm.mlir.constant(0 : index) : i64
      %6 = llvm.insertvalue %5, %4[2] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %7 = llvm.mlir.constant(1 : index) : i64
      %8 = llvm.insertvalue %7, %6[3, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %9 = llvm.mlir.constant(1 : index) : i64
      %10 = llvm.insertvalue %9, %8[4, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %11 = llvm.mlir.addressof @__wg_multiple_1 : !llvm.ptr<3>
      %12 = llvm.getelementptr %11[0, 0] : (!llvm.ptr<3>) -> !llvm.ptr<3>, !llvm.array<2 x f32>
      %13 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %14 = llvm.insertvalue %12, %13[0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %15 = llvm.insertvalue %12, %14[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %16 = llvm.mlir.constant(0 : index) : i64
      %17 = llvm.insertvalue %16, %15[2] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %18 = llvm.mlir.constant(2 : index) : i64
      %19 = llvm.insertvalue %18, %17[3, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %20 = llvm.mlir.constant(1 : index) : i64
      %21 = llvm.insertvalue %20, %19[4, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %22 = llvm.mlir.constant(3 : i64) : i64
      %23 = llvm.alloca %22 x f32 : (i64) -> !llvm.ptr<5>
      %24 = llvm.mlir.poison : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)>
      %25 = llvm.insertvalue %23, %24[0] : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)> 
      %26 = llvm.insertvalue %23, %25[1] : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)> 
      %27 = llvm.mlir.constant(0 : index) : i64
      %28 = llvm.insertvalue %27, %26[2] : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)> 
      %29 = llvm.mlir.constant(3 : index) : i64
      %30 = llvm.insertvalue %29, %28[3, 0] : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)> 
      %31 = llvm.mlir.constant(1 : index) : i64
      %32 = llvm.insertvalue %31, %30[4, 0] : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)> 
      %33 = llvm.mlir.constant(4 : i64) : i64
      %34 = llvm.alloca %33 x f32 : (i64) -> !llvm.ptr<5>
      %35 = llvm.mlir.poison : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)>
      %36 = llvm.insertvalue %34, %35[0] : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)> 
      %37 = llvm.insertvalue %34, %36[1] : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)> 
      %38 = llvm.mlir.constant(0 : index) : i64
      %39 = llvm.insertvalue %38, %37[2] : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)> 
      %40 = llvm.mlir.constant(4 : index) : i64
      %41 = llvm.insertvalue %40, %39[3, 0] : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)> 
      %42 = llvm.mlir.constant(1 : index) : i64
      %43 = llvm.insertvalue %42, %41[4, 0] : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)> 
      %44 = llvm.mlir.constant(0 : index) : i64
      %45 = llvm.extractvalue %10[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %46 = llvm.getelementptr inbounds|nuw %45[%44] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
      llvm.store %arg0, %46 : f32, !llvm.ptr<3>
      %47 = llvm.extractvalue %21[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %48 = llvm.getelementptr inbounds|nuw %47[%44] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
      llvm.store %arg0, %48 : f32, !llvm.ptr<3>
      %49 = llvm.extractvalue %32[1] : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)> 
      %50 = llvm.getelementptr inbounds|nuw %49[%44] : (!llvm.ptr<5>, i64) -> !llvm.ptr<5>, f32
      llvm.store %arg0, %50 : f32, !llvm.ptr<5>
      %51 = llvm.extractvalue %43[1] : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)> 
      %52 = llvm.getelementptr inbounds|nuw %51[%44] : (!llvm.ptr<5>, i64) -> !llvm.ptr<5>, f32
      llvm.store %arg0, %52 : f32, !llvm.ptr<5>
      "terminator"() : () -> ()
    }
  }
}

// -----
module {
  gpu.module @kernel attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.mlir.global internal @__wg_explicitAlign_0() {addr_space = 3 : i32, alignment = 8 : i64} : !llvm.array<48 x f32>
    llvm.func @explicitAlign(%arg0: i64) {
      %0 = llvm.mlir.addressof @__wg_explicitAlign_0 : !llvm.ptr<3>
      %1 = llvm.getelementptr %0[0, 0] : (!llvm.ptr<3>) -> !llvm.ptr<3>, !llvm.array<48 x f32>
      %2 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %5 = llvm.mlir.constant(0 : index) : i64
      %6 = llvm.insertvalue %5, %4[2] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %7 = llvm.mlir.constant(48 : index) : i64
      %8 = llvm.insertvalue %7, %6[3, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %9 = llvm.mlir.constant(1 : index) : i64
      %10 = llvm.insertvalue %9, %8[4, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %11 = llvm.mlir.constant(48 : i64) : i64
      %12 = llvm.alloca %11 x f32 {alignment = 4 : i64} : (i64) -> !llvm.ptr<5>
      %13 = llvm.mlir.poison : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)>
      %14 = llvm.insertvalue %12, %13[0] : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)> 
      %15 = llvm.insertvalue %12, %14[1] : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)> 
      %16 = llvm.mlir.constant(0 : index) : i64
      %17 = llvm.insertvalue %16, %15[2] : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)> 
      %18 = llvm.mlir.constant(48 : index) : i64
      %19 = llvm.insertvalue %18, %17[3, 0] : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)> 
      %20 = llvm.mlir.constant(1 : index) : i64
      %21 = llvm.insertvalue %20, %19[4, 0] : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)> 
      %22 = llvm.extractvalue %10[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %23 = llvm.getelementptr inbounds|nuw %22[%arg0] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
      %24 = llvm.load %23 : !llvm.ptr<3> -> f32
      %25 = llvm.extractvalue %21[1] : !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)> 
      %26 = llvm.getelementptr inbounds|nuw %25[%arg0] : (!llvm.ptr<5>, i64) -> !llvm.ptr<5>, f32
      llvm.store %24, %26 : f32, !llvm.ptr<5>
      "terminator"() : () -> ()
    }
  }
}

