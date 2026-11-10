"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "named_barrier", visibility_ = 0 : i64}> ({
      %7 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
      %8 = "llvm.mlir.addressof"() <{global_name = @__named_barrier}> : () -> !llvm.ptr<3>
      "rocdl.s.barrier.init"(%8) <{memberCnt = 4 : i32}> : (!llvm.ptr<3>) -> ()
      "llvm.fence"() <{ordering = 5 : i64, syncscope = "workgroup"}> : () -> ()
      "rocdl.s.barrier.join"(%8) : (!llvm.ptr<3>) -> ()
      "rocdl.s.barrier.signal.var"(%8) <{memberCnt = 0 : i32}> : (!llvm.ptr<3>) -> ()
      "rocdl.s.barrier.wait"() <{id = 1 : i16}> : () -> ()
      "llvm.fence"() <{ordering = 4 : i64, syncscope = "workgroup"}> : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_named_barrier", visibility_ = 0 : i64}> ({
      "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @named_barrier, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "two_named_barriers", visibility_ = 0 : i64}> ({
      %3 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
      %4 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
      %5 = "llvm.mlir.addressof"() <{global_name = @__named_barrier_0}> : () -> !llvm.ptr<3>
      "rocdl.s.barrier.init"(%5) <{memberCnt = 4 : i32}> : (!llvm.ptr<3>) -> ()
      %6 = "llvm.mlir.addressof"() <{global_name = @__named_barrier_1}> : () -> !llvm.ptr<3>
      "rocdl.s.barrier.init"(%6) <{memberCnt = 8 : i32}> : (!llvm.ptr<3>) -> ()
      "llvm.fence"() <{ordering = 5 : i64, syncscope = "workgroup"}> : () -> ()
      "rocdl.s.barrier.join"(%5) : (!llvm.ptr<3>) -> ()
      "rocdl.s.barrier.signal.var"(%5) <{memberCnt = 0 : i32}> : (!llvm.ptr<3>) -> ()
      "rocdl.s.barrier.wait"() <{id = 1 : i16}> : () -> ()
      "llvm.fence"() <{ordering = 4 : i64, syncscope = "workgroup"}> : () -> ()
      "llvm.fence"() <{ordering = 5 : i64, syncscope = "workgroup"}> : () -> ()
      "rocdl.s.barrier.join"(%6) : (!llvm.ptr<3>) -> ()
      "rocdl.s.barrier.signal.var"(%6) <{memberCnt = 0 : i32}> : (!llvm.ptr<3>) -> ()
      "rocdl.s.barrier.wait"() <{id = 1 : i16}> : () -> ()
      "llvm.fence"() <{ordering = 4 : i64, syncscope = "workgroup"}> : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_two_named_barriers", visibility_ = 0 : i64}> ({
      "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @two_named_barriers, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "cluster_scope", visibility_ = 0 : i64}> ({
      "llvm.fence"() <{ordering = 5 : i64, syncscope = "cluster"}> : () -> ()
      "rocdl.s.barrier.signal"() <{id = -3 : i32}> : () -> ()
      "rocdl.s.barrier.wait"() <{id = -3 : i16}> : () -> ()
      "llvm.fence"() <{ordering = 4 : i64, syncscope = "cluster"}> : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_cluster_scope", visibility_ = 0 : i64}> ({
      "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @cluster_scope, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.mlir.global"() <{addr_space = 3 : i32, global_type = !llvm.target<"amdgcn.named.barrier", 0>, linkage = #llvm.linkage<internal>, sym_name = "__named_barrier", visibility_ = 0 : i64}> ({
      %2 = "llvm.mlir.poison"() : () -> !llvm.target<"amdgcn.named.barrier", 0>
      "llvm.return"(%2) : (!llvm.target<"amdgcn.named.barrier", 0>) -> ()
    }) : () -> ()
    "llvm.mlir.global"() <{addr_space = 3 : i32, global_type = !llvm.target<"amdgcn.named.barrier", 0>, linkage = #llvm.linkage<internal>, sym_name = "__named_barrier_0", visibility_ = 0 : i64}> ({
      %1 = "llvm.mlir.poison"() : () -> !llvm.target<"amdgcn.named.barrier", 0>
      "llvm.return"(%1) : (!llvm.target<"amdgcn.named.barrier", 0>) -> ()
    }) : () -> ()
    "llvm.mlir.global"() <{addr_space = 3 : i32, global_type = !llvm.target<"amdgcn.named.barrier", 0>, linkage = #llvm.linkage<internal>, sym_name = "__named_barrier_1", visibility_ = 0 : i64}> ({
      %0 = "llvm.mlir.poison"() : () -> !llvm.target<"amdgcn.named.barrier", 0>
      "llvm.return"(%0) : (!llvm.target<"amdgcn.named.barrier", 0>) -> ()
    }) : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()
