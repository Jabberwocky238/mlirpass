module {
  gpu.module @test_module attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @named_barrier() attributes {llvm.emit_c_interface} {
      %0 = llvm.mlir.constant(4 : i32) : i32
      %1 = llvm.mlir.addressof @__named_barrier : !llvm.ptr<3>
      rocdl.s.barrier.init %1 member_cnt = 4 : !llvm.ptr<3>
      llvm.fence syncscope("workgroup") release
      rocdl.s.barrier.join %1 : !llvm.ptr<3>
      rocdl.s.barrier.signal.var %1 member_cnt = 0 : !llvm.ptr<3>
      rocdl.s.barrier.wait id = 1
      llvm.fence syncscope("workgroup") acquire
      llvm.return
    }
    llvm.func @_mlir_ciface_named_barrier() attributes {llvm.emit_c_interface} {
      llvm.call @named_barrier() : () -> ()
      llvm.return
    }
    llvm.func @two_named_barriers() attributes {llvm.emit_c_interface} {
      %0 = llvm.mlir.constant(4 : i32) : i32
      %1 = llvm.mlir.constant(8 : i32) : i32
      %2 = llvm.mlir.addressof @__named_barrier_0 : !llvm.ptr<3>
      rocdl.s.barrier.init %2 member_cnt = 4 : !llvm.ptr<3>
      %3 = llvm.mlir.addressof @__named_barrier_1 : !llvm.ptr<3>
      rocdl.s.barrier.init %3 member_cnt = 8 : !llvm.ptr<3>
      llvm.fence syncscope("workgroup") release
      rocdl.s.barrier.join %2 : !llvm.ptr<3>
      rocdl.s.barrier.signal.var %2 member_cnt = 0 : !llvm.ptr<3>
      rocdl.s.barrier.wait id = 1
      llvm.fence syncscope("workgroup") acquire
      llvm.fence syncscope("workgroup") release
      rocdl.s.barrier.join %3 : !llvm.ptr<3>
      rocdl.s.barrier.signal.var %3 member_cnt = 0 : !llvm.ptr<3>
      rocdl.s.barrier.wait id = 1
      llvm.fence syncscope("workgroup") acquire
      llvm.return
    }
    llvm.func @_mlir_ciface_two_named_barriers() attributes {llvm.emit_c_interface} {
      llvm.call @two_named_barriers() : () -> ()
      llvm.return
    }
    llvm.func @cluster_scope() attributes {llvm.emit_c_interface} {
      llvm.fence syncscope("cluster") release
      rocdl.s.barrier.signal id = -3
      rocdl.s.barrier.wait id = -3
      llvm.fence syncscope("cluster") acquire
      llvm.return
    }
    llvm.func @_mlir_ciface_cluster_scope() attributes {llvm.emit_c_interface} {
      llvm.call @cluster_scope() : () -> ()
      llvm.return
    }
    llvm.mlir.global internal @__named_barrier() {addr_space = 3 : i32} : !llvm.target<"amdgcn.named.barrier", 0> {
      %0 = llvm.mlir.poison : !llvm.target<"amdgcn.named.barrier", 0>
      llvm.return %0 : !llvm.target<"amdgcn.named.barrier", 0>
    }
    llvm.mlir.global internal @__named_barrier_0() {addr_space = 3 : i32} : !llvm.target<"amdgcn.named.barrier", 0> {
      %0 = llvm.mlir.poison : !llvm.target<"amdgcn.named.barrier", 0>
      llvm.return %0 : !llvm.target<"amdgcn.named.barrier", 0>
    }
    llvm.mlir.global internal @__named_barrier_1() {addr_space = 3 : i32} : !llvm.target<"amdgcn.named.barrier", 0> {
      %0 = llvm.mlir.poison : !llvm.target<"amdgcn.named.barrier", 0>
      llvm.return %0 : !llvm.target<"amdgcn.named.barrier", 0>
    }
  }
}
