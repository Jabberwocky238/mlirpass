"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "barrier_default", visibility_ = 0 : i64}> ({
      "llvm.fence"() <{ordering = 5 : i64, syncscope = "workgroup"}> : () -> ()
      "rocdl.s.barrier"() : () -> ()
      "llvm.fence"() <{ordering = 4 : i64, syncscope = "workgroup"}> : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_barrier_default", visibility_ = 0 : i64}> ({
      "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @barrier_default, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "barrier_no_fence", visibility_ = 0 : i64}> ({
      "rocdl.s.barrier"() : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_barrier_no_fence", visibility_ = 0 : i64}> ({
      "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @barrier_no_fence, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "barrier_workgroup_only", visibility_ = 0 : i64}> ({
      "llvm.fence"() <{ordering = 5 : i64, syncscope = "workgroup"}> {llvm.mmra = #llvm.mmra_tag<"amdgpu-synchronize-as":"local">} : () -> ()
      "rocdl.s.barrier"() : () -> ()
      "llvm.fence"() <{ordering = 4 : i64, syncscope = "workgroup"}> {llvm.mmra = #llvm.mmra_tag<"amdgpu-synchronize-as":"local">} : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_barrier_workgroup_only", visibility_ = 0 : i64}> ({
      "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @barrier_workgroup_only, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "barrier_global_only", visibility_ = 0 : i64}> ({
      "llvm.fence"() <{ordering = 5 : i64, syncscope = "workgroup"}> {llvm.mmra = #llvm.mmra_tag<"amdgpu-synchronize-as":"global">} : () -> ()
      "rocdl.s.barrier"() : () -> ()
      "llvm.fence"() <{ordering = 4 : i64, syncscope = "workgroup"}> {llvm.mmra = #llvm.mmra_tag<"amdgpu-synchronize-as":"global">} : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_barrier_global_only", visibility_ = 0 : i64}> ({
      "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @barrier_global_only, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "barrier_both", visibility_ = 0 : i64}> ({
      "llvm.fence"() <{ordering = 5 : i64, syncscope = "workgroup"}> : () -> ()
      "rocdl.s.barrier"() : () -> ()
      "llvm.fence"() <{ordering = 4 : i64, syncscope = "workgroup"}> : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_barrier_both", visibility_ = 0 : i64}> ({
      "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @barrier_both, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "barrier_private_only", visibility_ = 0 : i64}> ({
      "rocdl.s.barrier"() : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_barrier_private_only", visibility_ = 0 : i64}> ({
      "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @barrier_private_only, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "barrier_constant_only", visibility_ = 0 : i64}> ({
      "rocdl.s.barrier"() : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_barrier_constant_only", visibility_ = 0 : i64}> ({
      "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @barrier_constant_only, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "barrier_subgroup_scope", visibility_ = 0 : i64}> ({
      "llvm.fence"() <{ordering = 5 : i64, syncscope = "wavefront"}> : () -> ()
      "rocdl.wave.barrier"() : () -> ()
      "llvm.fence"() <{ordering = 4 : i64, syncscope = "wavefront"}> : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_barrier_subgroup_scope", visibility_ = 0 : i64}> ({
      "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @barrier_subgroup_scope, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "barrier_subgroup_scope_no_fence", visibility_ = 0 : i64}> ({
      "rocdl.wave.barrier"() : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_barrier_subgroup_scope_no_fence", visibility_ = 0 : i64}> ({
      "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @barrier_subgroup_scope_no_fence, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()
