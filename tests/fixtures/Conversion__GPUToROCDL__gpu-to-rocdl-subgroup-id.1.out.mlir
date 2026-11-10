module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @subgroup_id() -> i64 attributes {llvm.emit_c_interface} {
      %0 = rocdl.wave.id : i32
      %1 = llvm.sext %0 : i32 to i64
      llvm.return %1 : i64
    }
    llvm.func @_mlir_ciface_subgroup_id() -> i64 attributes {llvm.emit_c_interface} {
      %0 = llvm.call @subgroup_id() : () -> i64
      llvm.return %0 : i64
    }
    llvm.func @subgroup_id_with_upper_bound() -> i64 attributes {llvm.emit_c_interface} {
      %0 = rocdl.wave.id range <i32, 0, 4> : i32
      %1 = llvm.sext %0 : i32 to i64
      llvm.return %1 : i64
    }
    llvm.func @_mlir_ciface_subgroup_id_with_upper_bound() -> i64 attributes {llvm.emit_c_interface} {
      %0 = llvm.call @subgroup_id_with_upper_bound() : () -> i64
      llvm.return %0 : i64
    }
    llvm.func @subgroup_id_with_workgroup_sizes() -> i64 attributes {gpu.known_block_size = array<i32: 64, 4, 1>, llvm.emit_c_interface} {
      %0 = rocdl.wave.id range <i32, 0, 4> : i32
      %1 = llvm.sext %0 : i32 to i64
      llvm.return %1 : i64
    }
    llvm.func @_mlir_ciface_subgroup_id_with_workgroup_sizes() -> i64 attributes {gpu.known_block_size = array<i32: 64, 4, 1>, llvm.emit_c_interface} {
      %0 = llvm.call @subgroup_id_with_workgroup_sizes() : () -> i64
      llvm.return %0 : i64
    }
  }
}

