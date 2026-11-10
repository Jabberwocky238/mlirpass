module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @barrier_default() attributes {llvm.emit_c_interface} {
      llvm.fence syncscope("workgroup") release
      rocdl.s.barrier.signal id = -1
      rocdl.s.barrier.wait id = -1
      llvm.fence syncscope("workgroup") acquire
      llvm.return
    }
    llvm.func @_mlir_ciface_barrier_default() attributes {llvm.emit_c_interface} {
      llvm.call @barrier_default() : () -> ()
      llvm.return
    }
    llvm.func @barrier_no_fence() attributes {llvm.emit_c_interface} {
      rocdl.s.barrier.signal id = -1
      rocdl.s.barrier.wait id = -1
      llvm.return
    }
    llvm.func @_mlir_ciface_barrier_no_fence() attributes {llvm.emit_c_interface} {
      llvm.call @barrier_no_fence() : () -> ()
      llvm.return
    }
    llvm.func @barrier_workgroup_only() attributes {llvm.emit_c_interface} {
      llvm.fence syncscope("workgroup") release {llvm.mmra = #llvm.mmra_tag<"amdgpu-synchronize-as":"local">}
      rocdl.s.barrier.signal id = -1
      rocdl.s.barrier.wait id = -1
      llvm.fence syncscope("workgroup") acquire {llvm.mmra = #llvm.mmra_tag<"amdgpu-synchronize-as":"local">}
      llvm.return
    }
    llvm.func @_mlir_ciface_barrier_workgroup_only() attributes {llvm.emit_c_interface} {
      llvm.call @barrier_workgroup_only() : () -> ()
      llvm.return
    }
    llvm.func @barrier_global_only() attributes {llvm.emit_c_interface} {
      llvm.fence syncscope("workgroup") release {llvm.mmra = #llvm.mmra_tag<"amdgpu-synchronize-as":"global">}
      rocdl.s.barrier.signal id = -1
      rocdl.s.barrier.wait id = -1
      llvm.fence syncscope("workgroup") acquire {llvm.mmra = #llvm.mmra_tag<"amdgpu-synchronize-as":"global">}
      llvm.return
    }
    llvm.func @_mlir_ciface_barrier_global_only() attributes {llvm.emit_c_interface} {
      llvm.call @barrier_global_only() : () -> ()
      llvm.return
    }
    llvm.func @barrier_both() attributes {llvm.emit_c_interface} {
      llvm.fence syncscope("workgroup") release
      rocdl.s.barrier.signal id = -1
      rocdl.s.barrier.wait id = -1
      llvm.fence syncscope("workgroup") acquire
      llvm.return
    }
    llvm.func @_mlir_ciface_barrier_both() attributes {llvm.emit_c_interface} {
      llvm.call @barrier_both() : () -> ()
      llvm.return
    }
    llvm.func @barrier_private_only() attributes {llvm.emit_c_interface} {
      rocdl.s.barrier.signal id = -1
      rocdl.s.barrier.wait id = -1
      llvm.return
    }
    llvm.func @_mlir_ciface_barrier_private_only() attributes {llvm.emit_c_interface} {
      llvm.call @barrier_private_only() : () -> ()
      llvm.return
    }
    llvm.func @barrier_constant_only() attributes {llvm.emit_c_interface} {
      rocdl.s.barrier.signal id = -1
      rocdl.s.barrier.wait id = -1
      llvm.return
    }
    llvm.func @_mlir_ciface_barrier_constant_only() attributes {llvm.emit_c_interface} {
      llvm.call @barrier_constant_only() : () -> ()
      llvm.return
    }
    llvm.func @barrier_subgroup_scope() attributes {llvm.emit_c_interface} {
      llvm.fence syncscope("wavefront") release
      rocdl.wave.barrier
      llvm.fence syncscope("wavefront") acquire
      llvm.return
    }
    llvm.func @_mlir_ciface_barrier_subgroup_scope() attributes {llvm.emit_c_interface} {
      llvm.call @barrier_subgroup_scope() : () -> ()
      llvm.return
    }
    llvm.func @barrier_subgroup_scope_no_fence() attributes {llvm.emit_c_interface} {
      rocdl.wave.barrier
      llvm.return
    }
    llvm.func @_mlir_ciface_barrier_subgroup_scope_no_fence() attributes {llvm.emit_c_interface} {
      llvm.call @barrier_subgroup_scope_no_fence() : () -> ()
      llvm.return
    }
  }
}
