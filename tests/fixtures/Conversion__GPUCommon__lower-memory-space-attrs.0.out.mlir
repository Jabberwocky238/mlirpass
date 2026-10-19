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
      llvm.return
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
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @kernel attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @nested_memref(%arg0: !llvm.ptr<1>, %arg1: !llvm.ptr<1>, %arg2: i64, %arg3: i64, %arg4: i64) -> f32 {
      %0 = llvm.mlir.poison : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
      %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
      %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
      %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
      %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
      %5 = llvm.insertvalue %arg4, %4[4, 0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
      %6 = llvm.mlir.constant(0 : index) : i64
      %7 = llvm.extractvalue %5[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
      %8 = llvm.getelementptr inbounds|nuw %7[%6] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
      %9 = llvm.load %8 : !llvm.ptr<1> -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
      %10 = llvm.extractvalue %9[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
      %11 = llvm.getelementptr inbounds|nuw %10[%6] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f32
      %12 = llvm.load %11 : !llvm.ptr<1> -> f32
      llvm.return %12 : f32
    }
  }
}

// -----
module {
  gpu.module @kernel attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.mlir.global internal @__dynamic_shmem__0() {addr_space = 3 : i32} : !llvm.array<0 x i8>
    llvm.func @dynamic_shmem_with_vector(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64) {
      %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %5 = llvm.insertvalue %arg4, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %6 = llvm.mlir.constant(0 : index) : i64
      %7 = llvm.mlir.addressof @__dynamic_shmem__0 : !llvm.ptr<3>
      %8 = llvm.getelementptr %7[0] : (!llvm.ptr<3>) -> !llvm.ptr<3>, i8
      %9 = llvm.mlir.constant(0 : index) : i64
      %10 = llvm.mlir.constant(1 : index) : i64
      %11 = llvm.mlir.zero : !llvm.ptr
      %12 = llvm.getelementptr %11[%9] : (!llvm.ptr, i64) -> !llvm.ptr, i8
      %13 = llvm.ptrtoint %12 : !llvm.ptr to i64
      %14 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %15 = llvm.insertvalue %8, %14[0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %16 = llvm.insertvalue %8, %15[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %17 = llvm.mlir.constant(0 : index) : i64
      %18 = llvm.insertvalue %17, %16[2] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %19 = llvm.insertvalue %9, %18[3, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %20 = llvm.insertvalue %10, %19[4, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %21 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %22 = llvm.extractvalue %20[0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %23 = llvm.insertvalue %22, %21[0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %24 = llvm.extractvalue %20[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %25 = llvm.getelementptr %24[%6] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, i8
      %26 = llvm.insertvalue %25, %23[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %27 = llvm.mlir.constant(0 : index) : i64
      %28 = llvm.insertvalue %27, %26[2] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %29 = llvm.mlir.constant(1 : index) : i64
      %30 = llvm.insertvalue %29, %28[3, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %31 = llvm.mlir.constant(1 : index) : i64
      %32 = llvm.insertvalue %31, %30[4, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %33 = llvm.extractvalue %32[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %34 = llvm.getelementptr %33[%6] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
      %35 = llvm.load %34 {alignment = 4 : i64} : !llvm.ptr<3> -> vector<1xf32>
      %36 = llvm.extractvalue %5[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %37 = llvm.getelementptr %36[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
      llvm.store %35, %37 {alignment = 4 : i64} : vector<1xf32>, !llvm.ptr
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @kernel attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.mlir.global internal @__dynamic_shmem__0() {addr_space = 3 : i32} : !llvm.array<0 x i8>
    llvm.func @dynamic_shmem(%arg0: f32) {
      %0 = llvm.mlir.constant(0 : index) : i64
      %1 = llvm.mlir.addressof @__dynamic_shmem__0 : !llvm.ptr<3>
      %2 = llvm.getelementptr %1[0] : (!llvm.ptr<3>) -> !llvm.ptr<3>, i8
      %3 = llvm.mlir.constant(0 : index) : i64
      %4 = llvm.mlir.constant(1 : index) : i64
      %5 = llvm.mlir.zero : !llvm.ptr
      %6 = llvm.getelementptr %5[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
      %7 = llvm.ptrtoint %6 : !llvm.ptr to i64
      %8 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %9 = llvm.insertvalue %2, %8[0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %10 = llvm.insertvalue %2, %9[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %11 = llvm.mlir.constant(0 : index) : i64
      %12 = llvm.insertvalue %11, %10[2] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %13 = llvm.insertvalue %3, %12[3, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %14 = llvm.insertvalue %4, %13[4, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %15 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %16 = llvm.extractvalue %14[0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %17 = llvm.insertvalue %16, %15[0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %18 = llvm.extractvalue %14[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %19 = llvm.getelementptr %18[%0] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, i8
      %20 = llvm.insertvalue %19, %17[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %21 = llvm.mlir.constant(0 : index) : i64
      %22 = llvm.insertvalue %21, %20[2] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %23 = llvm.mlir.constant(4 : index) : i64
      %24 = llvm.insertvalue %23, %22[3, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %25 = llvm.mlir.constant(1 : index) : i64
      %26 = llvm.insertvalue %25, %24[4, 0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %27 = llvm.extractvalue %26[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
      %28 = llvm.getelementptr inbounds|nuw %27[%0] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
      llvm.store %arg0, %28 : f32, !llvm.ptr<3>
      llvm.return
    }
  }
}

