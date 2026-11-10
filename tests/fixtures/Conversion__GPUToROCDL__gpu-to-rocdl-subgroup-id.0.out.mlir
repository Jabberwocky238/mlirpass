module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @__ockl_get_local_size(i32) -> i64
    llvm.func @subgroup_id() -> i64 attributes {llvm.emit_c_interface} {
      %0 = rocdl.workitem.id.x : i32
      %1 = rocdl.workitem.id.y : i32
      %2 = rocdl.workitem.id.z : i32
      %3 = llvm.mlir.constant(0 : i32) : i32
      %4 = llvm.call @__ockl_get_local_size(%3) : (i32) -> (i64 {llvm.range = #llvm.constant_range<i64, 1, 1025>})
      %5 = llvm.trunc %4 overflow<nsw, nuw> : i64 to i32
      %6 = llvm.mlir.constant(1 : i32) : i32
      %7 = llvm.call @__ockl_get_local_size(%6) : (i32) -> (i64 {llvm.range = #llvm.constant_range<i64, 1, 1025>})
      %8 = llvm.trunc %7 overflow<nsw, nuw> : i64 to i32
      %9 = llvm.mul %8, %2 overflow<nsw, nuw> : i32
      %10 = llvm.add %1, %9 overflow<nsw, nuw> : i32
      %11 = llvm.mul %5, %10 overflow<nsw, nuw> : i32
      %12 = llvm.add %0, %11 overflow<nsw, nuw> : i32
      %13 = rocdl.wavefrontsize : i32
      %14 = llvm.udiv %12, %13 : i32
      %15 = llvm.sext %14 : i32 to i64
      llvm.return %15 : i64
    }
    llvm.func @_mlir_ciface_subgroup_id() -> i64 attributes {llvm.emit_c_interface} {
      %0 = llvm.call @subgroup_id() : () -> i64
      llvm.return %0 : i64
    }
    llvm.func @subgroup_id_with_upper_bound() -> i64 attributes {llvm.emit_c_interface} {
      %0 = rocdl.workitem.id.x : i32
      %1 = rocdl.workitem.id.y : i32
      %2 = rocdl.workitem.id.z : i32
      %3 = llvm.mlir.constant(0 : i32) : i32
      %4 = llvm.call @__ockl_get_local_size(%3) : (i32) -> (i64 {llvm.range = #llvm.constant_range<i64, 1, 1025>})
      %5 = llvm.trunc %4 overflow<nsw, nuw> : i64 to i32
      %6 = llvm.mlir.constant(1 : i32) : i32
      %7 = llvm.call @__ockl_get_local_size(%6) : (i32) -> (i64 {llvm.range = #llvm.constant_range<i64, 1, 1025>})
      %8 = llvm.trunc %7 overflow<nsw, nuw> : i64 to i32
      %9 = llvm.mul %8, %2 overflow<nsw, nuw> : i32
      %10 = llvm.add %1, %9 overflow<nsw, nuw> : i32
      %11 = llvm.mul %5, %10 overflow<nsw, nuw> : i32
      %12 = llvm.add %0, %11 overflow<nsw, nuw> : i32
      %13 = rocdl.wavefrontsize : i32
      %14 = llvm.udiv %12, %13 : i32
      %15 = llvm.sext %14 : i32 to i64
      llvm.return %15 : i64
    }
    llvm.func @_mlir_ciface_subgroup_id_with_upper_bound() -> i64 attributes {llvm.emit_c_interface} {
      %0 = llvm.call @subgroup_id_with_upper_bound() : () -> i64
      llvm.return %0 : i64
    }
    llvm.func @subgroup_id_with_workgroup_sizes() -> i64 attributes {gpu.known_block_size = array<i32: 64, 4, 1>, llvm.emit_c_interface} {
      %0 = rocdl.workitem.id.x range <i32, 0, 64> : i32
      %1 = rocdl.workitem.id.y range <i32, 0, 4> : i32
      %2 = rocdl.workitem.id.z range <i32, 0, 1> : i32
      %3 = llvm.mlir.constant(64 : i64) : i64
      %4 = llvm.trunc %3 overflow<nsw, nuw> : i64 to i32
      %5 = llvm.mlir.constant(4 : i64) : i64
      %6 = llvm.trunc %5 overflow<nsw, nuw> : i64 to i32
      %7 = llvm.mul %6, %2 overflow<nsw, nuw> : i32
      %8 = llvm.add %1, %7 overflow<nsw, nuw> : i32
      %9 = llvm.mul %4, %8 overflow<nsw, nuw> : i32
      %10 = llvm.add %0, %9 overflow<nsw, nuw> : i32
      %11 = rocdl.wavefrontsize : i32
      %12 = llvm.udiv %10, %11 : i32
      %13 = llvm.sext %12 : i32 to i64
      llvm.return %13 : i64
    }
    llvm.func @_mlir_ciface_subgroup_id_with_workgroup_sizes() -> i64 attributes {gpu.known_block_size = array<i32: 64, 4, 1>, llvm.emit_c_interface} {
      %0 = llvm.call @subgroup_id_with_workgroup_sizes() : () -> i64
      llvm.return %0 : i64
    }
  }
}

