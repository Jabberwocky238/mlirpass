"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_index_ops", visibility_ = 0 : i64}> ({
      %1 = "rocdl.workitem.id.x"() : () -> i32
      %2 = "rocdl.workitem.id.y"() : () -> i32
      %3 = "rocdl.workitem.id.z"() : () -> i32
      %4 = "rocdl.workgroup.dim.x"() : () -> i32
      %5 = "rocdl.workgroup.dim.y"() : () -> i32
      %6 = "rocdl.workgroup.dim.z"() : () -> i32
      %7 = "rocdl.workgroup.id.x"() : () -> i32
      %8 = "rocdl.workgroup.id.y"() : () -> i32
      %9 = "rocdl.workgroup.id.z"() : () -> i32
      %10 = "rocdl.grid.dim.x"() : () -> i32
      %11 = "rocdl.grid.dim.y"() : () -> i32
      %12 = "rocdl.grid.dim.z"() : () -> i32
      %13 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %14 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %15 = "rocdl.mbcnt.lo"(%14, %13) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %16 = "rocdl.mbcnt.hi"(%14, %15) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %17 = "rocdl.wavefrontsize"() : () -> i32
      %18 = "rocdl.wavefrontsize"() <{range = #llvm.constant_range<i32, 64, 65>}> : () -> i32
      %19 = "llvm.mlir.poison"() : () -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %20 = "llvm.insertvalue"(%19, %1) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %21 = "llvm.insertvalue"(%20, %2) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %22 = "llvm.insertvalue"(%21, %3) <{position = array<i64: 2>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %23 = "llvm.insertvalue"(%22, %4) <{position = array<i64: 3>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %24 = "llvm.insertvalue"(%23, %5) <{position = array<i64: 4>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %25 = "llvm.insertvalue"(%24, %6) <{position = array<i64: 5>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %26 = "llvm.insertvalue"(%25, %7) <{position = array<i64: 6>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %27 = "llvm.insertvalue"(%26, %8) <{position = array<i64: 7>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %28 = "llvm.insertvalue"(%27, %9) <{position = array<i64: 8>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %29 = "llvm.insertvalue"(%28, %10) <{position = array<i64: 9>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %30 = "llvm.insertvalue"(%29, %11) <{position = array<i64: 10>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %31 = "llvm.insertvalue"(%30, %12) <{position = array<i64: 11>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %32 = "llvm.insertvalue"(%31, %16) <{position = array<i64: 12>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %33 = "llvm.insertvalue"(%32, %17) <{position = array<i64: 13>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %34 = "llvm.insertvalue"(%33, %18) <{position = array<i64: 14>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      "llvm.return"(%34) : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_index_ops", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr):
      %0 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_index_ops, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, i32)>, linkage = #llvm.linkage<external>, sym_name = "gpu_index_ops_range", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32):
      %0 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i32)>
      %1 = "llvm.insertvalue"(%0, %arg0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i32)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i32)>
      %2 = "llvm.insertvalue"(%1, %arg1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i32)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i32)>
      %3 = "llvm.insertvalue"(%2, %arg2) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i32)>, i32) -> !llvm.struct<(ptr, ptr, i32)>
      %4 = "rocdl.workitem.id.x"() <{range = #llvm.constant_range<i32, 0, 8>}> : () -> i32
      %5 = "rocdl.workitem.id.y"() <{range = #llvm.constant_range<i32, 0, 12>}> : () -> i32
      %6 = "rocdl.workitem.id.z"() <{range = #llvm.constant_range<i32, 0, 16>}> : () -> i32
      %7 = "rocdl.workgroup.id.x"() <{range = #llvm.constant_range<i32, 0, 20>}> : () -> i32
      %8 = "rocdl.workgroup.id.y"() <{range = #llvm.constant_range<i32, 0, 24>}> : () -> i32
      %9 = "rocdl.workgroup.id.z"() <{range = #llvm.constant_range<i32, 0, 28>}> : () -> i32
      %10 = "llvm.add"(%4, %5) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %11 = "llvm.add"(%10, %6) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %12 = "llvm.add"(%11, %7) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %13 = "llvm.add"(%12, %8) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %14 = "llvm.add"(%13, %9) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %15 = "llvm.extractvalue"(%3) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i32)>) -> !llvm.ptr
      "llvm.store"(%14, %15) <{ordering = 0 : i64}> : (i32, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {gpu.kernel, gpu.known_block_size = array<i32: 8, 12, 16>, gpu.known_grid_size = array<i32: 20, 24, 28>, rocdl.flat_work_group_size = "1536,1536", rocdl.kernel, rocdl.reqd_work_group_size = array<i32: 8, 12, 16>} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "gpu_index_comp", visibility_ = 0 : i64}> ({
    ^bb0(%arg1: i32):
      %1 = "llvm.add"(%arg1, %arg1) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      "llvm.return"(%1) : (i32) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_index_comp", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: i32):
      %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_index_comp, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i32) -> i32
      "llvm.return"(%0) : (i32) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_sync", visibility_ = 0 : i64}> ({
      "rocdl.barrier"() : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_sync", visibility_ = 0 : i64}> ({
      "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_sync, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_sqrt", visibility_ = 0 : i64}> ({
    ^bb0(%arg4: f16, %arg5: f32, %arg6: f64):
      %1 = "llvm.intr.sqrt"(%arg4) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f16
      %2 = "llvm.intr.sqrt"(%arg5) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
      %3 = "llvm.intr.sqrt"(%arg6) <{fastmathFlags = #llvm.fastmath<none>}> : (f64) -> f64
      %4 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %5 = "llvm.insertvalue"(%4, %1) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %6 = "llvm.insertvalue"(%5, %2) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %7 = "llvm.insertvalue"(%6, %3) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%7) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_sqrt", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64):
      %0 = "llvm.call"(%arg1, %arg2, %arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_sqrt, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_fabs", visibility_ = 0 : i64}> ({
    ^bb0(%arg4: f16, %arg5: f32, %arg6: f64):
      %1 = "llvm.intr.fabs"(%arg4) <{fastmathFlags = #llvm.fastmath<none>}> : (f16) -> f16
      %2 = "llvm.intr.fabs"(%arg5) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
      %3 = "llvm.intr.fabs"(%arg6) <{fastmathFlags = #llvm.fastmath<none>}> : (f64) -> f64
      %4 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %5 = "llvm.insertvalue"(%4, %1) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %6 = "llvm.insertvalue"(%5, %2) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %7 = "llvm.insertvalue"(%6, %3) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%7) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_fabs", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64):
      %0 = "llvm.call"(%arg1, %arg2, %arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_fabs, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_exp_f16", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_exp_f64", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_exp", visibility_ = 0 : i64}> ({
    ^bb0(%arg4: f16, %arg5: f32, %arg6: f64):
      %1 = "llvm.call"(%arg4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_exp_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
      %2 = "llvm.intr.exp"(%arg5) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
      %3 = "llvm.call"(%arg6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_exp_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %4 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %5 = "llvm.insertvalue"(%4, %1) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %6 = "llvm.insertvalue"(%5, %2) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %7 = "llvm.insertvalue"(%6, %3) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%7) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_exp", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64):
      %0 = "llvm.call"(%arg1, %arg2, %arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_exp, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_log_f16", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_log_f64", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_log", visibility_ = 0 : i64}> ({
    ^bb0(%arg4: f16, %arg5: f32, %arg6: f64):
      %1 = "llvm.call"(%arg4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_log_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
      %2 = "llvm.intr.log"(%arg5) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
      %3 = "llvm.call"(%arg6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_log_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %4 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %5 = "llvm.insertvalue"(%4, %1) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %6 = "llvm.insertvalue"(%5, %2) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %7 = "llvm.insertvalue"(%6, %3) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%7) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_log", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64):
      %0 = "llvm.call"(%arg1, %arg2, %arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_log, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_cbrt_f16", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_cbrt_f32", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_cbrt_f64", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_cbrt", visibility_ = 0 : i64}> ({
    ^bb0(%arg4: f16, %arg5: f32, %arg6: f64):
      %1 = "llvm.call"(%arg4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_cbrt_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
      %2 = "llvm.call"(%arg5) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_cbrt_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %3 = "llvm.call"(%arg6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_cbrt_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %4 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %5 = "llvm.insertvalue"(%4, %1) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %6 = "llvm.insertvalue"(%5, %2) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %7 = "llvm.insertvalue"(%6, %3) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%7) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_cbrt", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64):
      %0 = "llvm.call"(%arg1, %arg2, %arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_cbrt, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_ceil_f16", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_ceil_f32", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_ceil_f64", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_ceil", visibility_ = 0 : i64}> ({
    ^bb0(%arg4: f16, %arg5: f32, %arg6: f64):
      %1 = "llvm.call"(%arg4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_ceil_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
      %2 = "llvm.call"(%arg5) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_ceil_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %3 = "llvm.call"(%arg6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_ceil_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %4 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %5 = "llvm.insertvalue"(%4, %1) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %6 = "llvm.insertvalue"(%5, %2) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %7 = "llvm.insertvalue"(%6, %3) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%7) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_ceil", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64):
      %0 = "llvm.call"(%arg1, %arg2, %arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_ceil, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_floor_f16", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_floor_f32", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_floor_f64", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_floor", visibility_ = 0 : i64}> ({
    ^bb0(%arg4: f16, %arg5: f32, %arg6: f64):
      %1 = "llvm.call"(%arg4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_floor_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
      %2 = "llvm.call"(%arg5) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_floor_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %3 = "llvm.call"(%arg6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_floor_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %4 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %5 = "llvm.insertvalue"(%4, %1) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %6 = "llvm.insertvalue"(%5, %2) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %7 = "llvm.insertvalue"(%6, %3) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%7) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_floor", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64):
      %0 = "llvm.call"(%arg1, %arg2, %arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_floor, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_cos_f16", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_cos_f32", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_cos_f64", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_cos", visibility_ = 0 : i64}> ({
    ^bb0(%arg4: f16, %arg5: f32, %arg6: f64):
      %1 = "llvm.call"(%arg4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_cos_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
      %2 = "llvm.call"(%arg5) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_cos_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %3 = "llvm.call"(%arg6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_cos_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %4 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %5 = "llvm.insertvalue"(%4, %1) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %6 = "llvm.insertvalue"(%5, %2) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %7 = "llvm.insertvalue"(%6, %3) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%7) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_cos", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64):
      %0 = "llvm.call"(%arg1, %arg2, %arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_cos, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_exp2_f16", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_exp2_f32", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_exp2_f64", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_exp2", visibility_ = 0 : i64}> ({
    ^bb0(%arg4: f16, %arg5: f32, %arg6: f64):
      %1 = "llvm.call"(%arg4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_exp2_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
      %2 = "llvm.call"(%arg5) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_exp2_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %3 = "llvm.call"(%2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_exp2_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %4 = "llvm.call"(%arg6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_exp2_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %5 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %6 = "llvm.insertvalue"(%5, %1) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %7 = "llvm.insertvalue"(%6, %3) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %8 = "llvm.insertvalue"(%7, %4) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%8) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_exp2", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64):
      %0 = "llvm.call"(%arg1, %arg2, %arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_exp2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "test.symbol_scope"() ({
      "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_sin_f16", visibility_ = 0 : i64}> ({
      }) : () -> ()
      "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_sin_f32", visibility_ = 0 : i64}> ({
      }) : () -> ()
      "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_sin_f64", visibility_ = 0 : i64}> ({
      }) : () -> ()
      "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_sin", visibility_ = 0 : i64}> ({
      ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
        %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
        %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
        %2 = "llvm.call"(%arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
        %3 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
        %4 = "llvm.insertvalue"(%3, %0) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
        %5 = "llvm.insertvalue"(%4, %1) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
        %6 = "llvm.insertvalue"(%5, %2) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
        "llvm.return"(%6) : (!llvm.struct<(f16, f32, f64)>) -> ()
      }) : () -> ()
      "test.finish"() : () -> ()
    }) : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_expm1_f16", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_expm1_f32", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_expm1_f64", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_expm1", visibility_ = 0 : i64}> ({
    ^bb0(%arg4: f16, %arg5: f32, %arg6: f64):
      %1 = "llvm.call"(%arg4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_expm1_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
      %2 = "llvm.call"(%arg5) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_expm1_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %3 = "llvm.call"(%2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_expm1_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %4 = "llvm.call"(%arg6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_expm1_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %5 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %6 = "llvm.insertvalue"(%5, %1) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %7 = "llvm.insertvalue"(%6, %3) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %8 = "llvm.insertvalue"(%7, %4) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%8) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_expm1", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64):
      %0 = "llvm.call"(%arg1, %arg2, %arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_expm1, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_log_f16", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_log_f64", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f64)> (f16, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_log", visibility_ = 0 : i64}> ({
    ^bb0(%arg3: f16, %arg4: f64):
      %1 = "llvm.call"(%arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_log_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
      %2 = "llvm.call"(%arg4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_log_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %3 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f64)>
      %4 = "llvm.insertvalue"(%3, %1) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f64)>, f16) -> !llvm.struct<(f16, f64)>
      %5 = "llvm.insertvalue"(%4, %2) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f64)>, f64) -> !llvm.struct<(f16, f64)>
      "llvm.return"(%5) : (!llvm.struct<(f16, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_log", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: f16, %arg2: f64):
      %0 = "llvm.call"(%arg1, %arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_log, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f16, f64) -> !llvm.struct<(f16, f64)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_log1p_f16", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_log1p_f32", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_log1p_f64", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_log1p", visibility_ = 0 : i64}> ({
    ^bb0(%arg4: f16, %arg5: f32, %arg6: f64):
      %1 = "llvm.call"(%arg4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_log1p_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
      %2 = "llvm.call"(%arg5) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_log1p_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %3 = "llvm.call"(%arg6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_log1p_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %4 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %5 = "llvm.insertvalue"(%4, %1) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %6 = "llvm.insertvalue"(%5, %2) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %7 = "llvm.insertvalue"(%6, %3) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%7) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_log1p", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64):
      %0 = "llvm.call"(%arg1, %arg2, %arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_log1p, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_log10_f16", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_log10_f32", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_log10_f64", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_log10", visibility_ = 0 : i64}> ({
    ^bb0(%arg4: f16, %arg5: f32, %arg6: f64):
      %1 = "llvm.call"(%arg4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_log10_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
      %2 = "llvm.call"(%arg5) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_log10_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %3 = "llvm.call"(%arg6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_log10_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %4 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %5 = "llvm.insertvalue"(%4, %1) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %6 = "llvm.insertvalue"(%5, %2) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %7 = "llvm.insertvalue"(%6, %3) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%7) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_log10", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64):
      %0 = "llvm.call"(%arg1, %arg2, %arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_log10, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_log2_f16", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_log2_f32", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_log2_f64", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_log2", visibility_ = 0 : i64}> ({
    ^bb0(%arg4: f16, %arg5: f32, %arg6: f64):
      %1 = "llvm.call"(%arg4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_log2_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
      %2 = "llvm.call"(%arg5) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_log2_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %3 = "llvm.call"(%arg6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_log2_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %4 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %5 = "llvm.insertvalue"(%4, %1) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %6 = "llvm.insertvalue"(%5, %2) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %7 = "llvm.insertvalue"(%6, %3) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%7) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_log2", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64):
      %0 = "llvm.call"(%arg1, %arg2, %arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_log2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_rsqrt_f16", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_rsqrt_f32", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_rsqrt_f64", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_rsqrt", visibility_ = 0 : i64}> ({
    ^bb0(%arg4: f16, %arg5: f32, %arg6: f64):
      %1 = "llvm.call"(%arg4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_rsqrt_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
      %2 = "llvm.call"(%arg5) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_rsqrt_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %3 = "llvm.call"(%arg6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_rsqrt_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %4 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %5 = "llvm.insertvalue"(%4, %1) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %6 = "llvm.insertvalue"(%5, %2) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %7 = "llvm.insertvalue"(%6, %3) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%7) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_rsqrt", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64):
      %0 = "llvm.call"(%arg1, %arg2, %arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_rsqrt, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_tan_f16", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_tan_f32", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_tan_f64", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_tan", visibility_ = 0 : i64}> ({
    ^bb0(%arg4: f16, %arg5: f32, %arg6: f64):
      %1 = "llvm.call"(%arg4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_tan_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
      %2 = "llvm.call"(%arg5) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_tan_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %3 = "llvm.call"(%arg6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_tan_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %4 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %5 = "llvm.insertvalue"(%4, %1) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %6 = "llvm.insertvalue"(%5, %2) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %7 = "llvm.insertvalue"(%6, %3) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%7) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_tan", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64):
      %0 = "llvm.call"(%arg1, %arg2, %arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_tan, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_tanh_f16", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_tanh_f32", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_tanh_f64", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_tanh", visibility_ = 0 : i64}> ({
    ^bb0(%arg4: f16, %arg5: f32, %arg6: f64):
      %1 = "llvm.call"(%arg4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_tanh_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
      %2 = "llvm.call"(%arg5) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_tanh_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %3 = "llvm.call"(%arg6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_tanh_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %4 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %5 = "llvm.insertvalue"(%4, %1) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %6 = "llvm.insertvalue"(%5, %2) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %7 = "llvm.insertvalue"(%6, %3) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%7) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_tanh", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64):
      %0 = "llvm.call"(%arg1, %arg2, %arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_tanh, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_atan_f16", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_atan_f32", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_atan_f64", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_atan", visibility_ = 0 : i64}> ({
    ^bb0(%arg4: f16, %arg5: f32, %arg6: f64):
      %1 = "llvm.call"(%arg4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_atan_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
      %2 = "llvm.call"(%arg5) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_atan_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %3 = "llvm.call"(%arg6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_atan_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %4 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %5 = "llvm.insertvalue"(%4, %1) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %6 = "llvm.insertvalue"(%5, %2) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %7 = "llvm.insertvalue"(%6, %3) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%7) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_atan", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64):
      %0 = "llvm.call"(%arg1, %arg2, %arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_atan, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16, f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_atan2_f16", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_atan2_f32", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_atan2_f64", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_atan2", visibility_ = 0 : i64}> ({
    ^bb0(%arg4: f16, %arg5: f32, %arg6: f64):
      %1 = "llvm.call"(%arg4, %arg4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_atan2_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f16, f16) -> f16
      %2 = "llvm.call"(%arg5, %arg5) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_atan2_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %3 = "llvm.call"(%arg6, %arg6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_atan2_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
      %4 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %5 = "llvm.insertvalue"(%4, %1) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %6 = "llvm.insertvalue"(%5, %2) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %7 = "llvm.insertvalue"(%6, %3) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%7) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_atan2", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64):
      %0 = "llvm.call"(%arg1, %arg2, %arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_atan2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16, f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_pow_f16", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_pow_f32", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_pow_f64", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_pow", visibility_ = 0 : i64}> ({
    ^bb0(%arg4: f16, %arg5: f32, %arg6: f64):
      %1 = "llvm.call"(%arg4, %arg4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_pow_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f16, f16) -> f16
      %2 = "llvm.call"(%arg5, %arg5) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_pow_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %3 = "llvm.call"(%arg6, %arg6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_pow_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
      %4 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %5 = "llvm.insertvalue"(%4, %1) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %6 = "llvm.insertvalue"(%5, %2) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %7 = "llvm.insertvalue"(%6, %3) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%7) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_pow", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64):
      %0 = "llvm.call"(%arg1, %arg2, %arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_pow, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_erf_f16", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_erf_f32", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_erf_f64", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_erf", visibility_ = 0 : i64}> ({
    ^bb0(%arg4: f16, %arg5: f32, %arg6: f64):
      %1 = "llvm.call"(%arg4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_erf_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f16) -> f16
      %2 = "llvm.call"(%arg5) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_erf_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %3 = "llvm.call"(%arg6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_erf_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> f64
      %4 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %5 = "llvm.insertvalue"(%4, %1) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %6 = "llvm.insertvalue"(%5, %2) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %7 = "llvm.insertvalue"(%6, %3) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%7) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_erf", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64):
      %0 = "llvm.call"(%arg1, %arg2, %arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_erf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_sin_f32", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<4xf32> (vector<4xf32>)>, linkage = #llvm.linkage<external>, sym_name = "gpu_unroll", visibility_ = 0 : i64}> ({
    ^bb0(%arg1: vector<4xf32>):
      %1 = "llvm.mlir.poison"() : () -> vector<4xf32>
      %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %3 = "llvm.extractelement"(%arg1, %2) : (vector<4xf32>, i32) -> f32
      %4 = "llvm.call"(%3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %5 = "llvm.insertelement"(%1, %4, %2) : (vector<4xf32>, f32, i32) -> vector<4xf32>
      %6 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %7 = "llvm.extractelement"(%arg1, %6) : (vector<4xf32>, i32) -> f32
      %8 = "llvm.call"(%7) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %9 = "llvm.insertelement"(%5, %8, %6) : (vector<4xf32>, f32, i32) -> vector<4xf32>
      %10 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %11 = "llvm.extractelement"(%arg1, %10) : (vector<4xf32>, i32) -> f32
      %12 = "llvm.call"(%11) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %13 = "llvm.insertelement"(%9, %12, %10) : (vector<4xf32>, f32, i32) -> vector<4xf32>
      %14 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
      %15 = "llvm.extractelement"(%arg1, %14) : (vector<4xf32>, i32) -> f32
      %16 = "llvm.call"(%15) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %17 = "llvm.insertelement"(%13, %16, %14) : (vector<4xf32>, f32, i32) -> vector<4xf32>
      "llvm.return"(%17) : (vector<4xf32>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<4xf32> (vector<4xf32>)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_unroll", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: vector<4xf32>):
      %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_unroll, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (vector<4xf32>) -> vector<4xf32>
      "llvm.return"(%0) : (vector<4xf32>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<bf16 (bf16)>, linkage = #llvm.linkage<external>, sym_name = "bf16_id", visibility_ = 0 : i64}> ({
    ^bb0(%arg3: bf16):
      "llvm.return"(%arg3) : (bf16) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<bf16 (bf16)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_bf16_id", visibility_ = 0 : i64}> ({
    ^bb0(%arg2: bf16):
      %1 = "llvm.call"(%arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @bf16_id, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (bf16) -> bf16
      "llvm.return"(%1) : (bf16) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<4xbf16> (vector<4xbf16>)>, linkage = #llvm.linkage<external>, sym_name = "bf16x4_id", visibility_ = 0 : i64}> ({
    ^bb0(%arg1: vector<4xbf16>):
      "llvm.return"(%arg1) : (vector<4xbf16>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<4xbf16> (vector<4xbf16>)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_bf16x4_id", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: vector<4xbf16>):
      %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @bf16x4_id, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (vector<4xbf16>) -> vector<4xbf16>
      "llvm.return"(%0) : (vector<4xbf16>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "kernel_func", visibility_ = 0 : i64}> ({
      "llvm.return"() : () -> ()
    }) {gpu.kernel, rocdl.kernel} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_sin_f32", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xf32>) -> vector<4xf32>, sym_name = "spirv_sin"}> ({
    ^bb0(%arg0: vector<4xf32>):
      %0 = "llvm.mlir.poison"() : () -> vector<4xf32>
      %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %2 = "llvm.extractelement"(%arg0, %1) : (vector<4xf32>, i32) -> f32
      %3 = "llvm.call"(%2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %4 = "llvm.insertelement"(%0, %3, %1) : (vector<4xf32>, f32, i32) -> vector<4xf32>
      %5 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %6 = "llvm.extractelement"(%arg0, %5) : (vector<4xf32>, i32) -> f32
      %7 = "llvm.call"(%6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %8 = "llvm.insertelement"(%4, %7, %5) : (vector<4xf32>, f32, i32) -> vector<4xf32>
      %9 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %10 = "llvm.extractelement"(%arg0, %9) : (vector<4xf32>, i32) -> f32
      %11 = "llvm.call"(%10) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %12 = "llvm.insertelement"(%8, %11, %9) : (vector<4xf32>, f32, i32) -> vector<4xf32>
      %13 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
      %14 = "llvm.extractelement"(%arg0, %13) : (vector<4xf32>, i32) -> f32
      %15 = "llvm.call"(%14) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %16 = "llvm.insertelement"(%12, %15, %13) : (vector<4xf32>, f32, i32) -> vector<4xf32>
      "spirv.ReturnValue"(%16) : (vector<4xf32>) -> ()
    }) : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.mlir.global"() <{addr_space = 3 : i32, global_type = !llvm.array<32 x f32>, linkage = #llvm.linkage<internal>, sym_name = "__wg_gpu_all_reduce_op_0", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_all_reduce_op", visibility_ = 0 : i64}> ({
      %0 = "llvm.mlir.addressof"() <{global_name = @__wg_gpu_all_reduce_op_0}> : () -> !llvm.ptr<3>
      %1 = "llvm.getelementptr"(%0) <{elem_type = !llvm.array<32 x f32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr<3>) -> !llvm.ptr<3>
      %2 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %3 = "llvm.insertvalue"(%2, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %4 = "llvm.insertvalue"(%3, %1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %5 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i32
      %6 = "llvm.insertvalue"(%4, %5) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %7 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i32
      %8 = "llvm.insertvalue"(%6, %7) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %9 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i32
      %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %11 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i32
      %12 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
      %13 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
      %14 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
      %15 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %16 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %17 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %18 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %19 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
      %20 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %21 = "rocdl.workgroup.dim.x"() : () -> i32
      %22 = "rocdl.workgroup.dim.y"() : () -> i32
      %23 = "rocdl.workgroup.dim.z"() : () -> i32
      %24 = "rocdl.workitem.id.x"() : () -> i32
      %25 = "rocdl.workitem.id.y"() : () -> i32
      %26 = "rocdl.workitem.id.z"() : () -> i32
      %27 = "llvm.mul"(%26, %22) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %28 = "llvm.add"(%27, %25) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %29 = "llvm.mul"(%28, %21) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %30 = "llvm.mul"(%21, %22) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %31 = "llvm.add"(%29, %24) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %32 = "llvm.mul"(%30, %23) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %33 = "llvm.and"(%31, %19) : (i32, i32) -> i32
      %34 = "llvm.icmp"(%33, %18) <{predicate = 0 : i64}> : (i32, i32) -> i1
      %35 = "llvm.sub"(%31, %33) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %36 = "llvm.sub"(%32, %35) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %37 = "llvm.icmp"(%36, %17) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%37)[^bb1, ^bb17] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %38 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %39 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %40 = "rocdl.mbcnt.lo"(%39, %38) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %41 = "rocdl.mbcnt.hi"(%39, %40) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %42 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %43 = "llvm.sub"(%42, %36) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %44 = "llvm.add"(%41, %36) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %45 = "llvm.and"(%44, %43) : (i32, i32) -> i32
      %46 = "llvm.xor"(%41, %16) : (i32, i32) -> i32
      %47 = "llvm.icmp"(%46, %45) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %48 = "llvm.select"(%47, %46, %41) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %49 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %50 = "llvm.shl"(%48, %49) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %51 = "llvm.bitcast"(%20) : (f32) -> i32
      %52 = "rocdl.ds_bpermute"(%50, %51) : (i32, i32) -> i32
      %53 = "llvm.bitcast"(%52) : (i32) -> f32
      "llvm.cond_br"(%47)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      %54 = "llvm.fadd"(%53, %20) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%54)[^bb4] : (f32) -> ()
    ^bb3:  // pred: ^bb1
      "llvm.br"(%20)[^bb4] : (f32) -> ()
    ^bb4(%55: f32):  // 2 preds: ^bb2, ^bb3
      %56 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %57 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %58 = "rocdl.mbcnt.lo"(%57, %56) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %59 = "rocdl.mbcnt.hi"(%57, %58) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %60 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %61 = "llvm.sub"(%60, %36) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %62 = "llvm.add"(%59, %36) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %63 = "llvm.and"(%62, %61) : (i32, i32) -> i32
      %64 = "llvm.xor"(%59, %15) : (i32, i32) -> i32
      %65 = "llvm.icmp"(%64, %63) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %66 = "llvm.select"(%65, %64, %59) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %67 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %68 = "llvm.shl"(%66, %67) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %69 = "llvm.bitcast"(%55) : (f32) -> i32
      %70 = "rocdl.ds_bpermute"(%68, %69) : (i32, i32) -> i32
      %71 = "llvm.bitcast"(%70) : (i32) -> f32
      "llvm.cond_br"(%65)[^bb5, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb5:  // pred: ^bb4
      %72 = "llvm.fadd"(%55, %71) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%72)[^bb7] : (f32) -> ()
    ^bb6:  // pred: ^bb4
      "llvm.br"(%55)[^bb7] : (f32) -> ()
    ^bb7(%73: f32):  // 2 preds: ^bb5, ^bb6
      %74 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %75 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %76 = "rocdl.mbcnt.lo"(%75, %74) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %77 = "rocdl.mbcnt.hi"(%75, %76) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %78 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %79 = "llvm.sub"(%78, %36) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %80 = "llvm.add"(%77, %36) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %81 = "llvm.and"(%80, %79) : (i32, i32) -> i32
      %82 = "llvm.xor"(%77, %14) : (i32, i32) -> i32
      %83 = "llvm.icmp"(%82, %81) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %84 = "llvm.select"(%83, %82, %77) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %85 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %86 = "llvm.shl"(%84, %85) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %87 = "llvm.bitcast"(%73) : (f32) -> i32
      %88 = "rocdl.ds_bpermute"(%86, %87) : (i32, i32) -> i32
      %89 = "llvm.bitcast"(%88) : (i32) -> f32
      "llvm.cond_br"(%83)[^bb8, ^bb9] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb8:  // pred: ^bb7
      %90 = "llvm.fadd"(%73, %89) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%90)[^bb10] : (f32) -> ()
    ^bb9:  // pred: ^bb7
      "llvm.br"(%73)[^bb10] : (f32) -> ()
    ^bb10(%91: f32):  // 2 preds: ^bb8, ^bb9
      %92 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %93 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %94 = "rocdl.mbcnt.lo"(%93, %92) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %95 = "rocdl.mbcnt.hi"(%93, %94) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %96 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %97 = "llvm.sub"(%96, %36) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %98 = "llvm.add"(%95, %36) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %99 = "llvm.and"(%98, %97) : (i32, i32) -> i32
      %100 = "llvm.xor"(%95, %13) : (i32, i32) -> i32
      %101 = "llvm.icmp"(%100, %99) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %102 = "llvm.select"(%101, %100, %95) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %103 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %104 = "llvm.shl"(%102, %103) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %105 = "llvm.bitcast"(%91) : (f32) -> i32
      %106 = "rocdl.ds_bpermute"(%104, %105) : (i32, i32) -> i32
      %107 = "llvm.bitcast"(%106) : (i32) -> f32
      "llvm.cond_br"(%101)[^bb11, ^bb12] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb11:  // pred: ^bb10
      %108 = "llvm.fadd"(%91, %107) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%108)[^bb13] : (f32) -> ()
    ^bb12:  // pred: ^bb10
      "llvm.br"(%91)[^bb13] : (f32) -> ()
    ^bb13(%109: f32):  // 2 preds: ^bb11, ^bb12
      %110 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %111 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %112 = "rocdl.mbcnt.lo"(%111, %110) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %113 = "rocdl.mbcnt.hi"(%111, %112) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %114 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %115 = "llvm.sub"(%114, %36) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %116 = "llvm.add"(%113, %36) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %117 = "llvm.and"(%116, %115) : (i32, i32) -> i32
      %118 = "llvm.xor"(%113, %12) : (i32, i32) -> i32
      %119 = "llvm.icmp"(%118, %117) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %120 = "llvm.select"(%119, %118, %113) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %121 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %122 = "llvm.shl"(%120, %121) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %123 = "llvm.bitcast"(%109) : (f32) -> i32
      %124 = "rocdl.ds_bpermute"(%122, %123) : (i32, i32) -> i32
      %125 = "llvm.bitcast"(%124) : (i32) -> f32
      "llvm.cond_br"(%119)[^bb14, ^bb15] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb14:  // pred: ^bb13
      %126 = "llvm.fadd"(%109, %125) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%126)[^bb16] : (f32) -> ()
    ^bb15:  // pred: ^bb13
      "llvm.br"(%109)[^bb16] : (f32) -> ()
    ^bb16(%127: f32):  // 2 preds: ^bb14, ^bb15
      "llvm.br"(%127)[^bb18] : (f32) -> ()
    ^bb17:  // pred: ^bb0
      %128 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %129 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %130 = "rocdl.mbcnt.lo"(%129, %128) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %131 = "rocdl.mbcnt.hi"(%129, %130) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %132 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %133 = "llvm.sub"(%132, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %134 = "llvm.add"(%131, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %135 = "llvm.and"(%134, %133) : (i32, i32) -> i32
      %136 = "llvm.xor"(%131, %16) : (i32, i32) -> i32
      %137 = "llvm.icmp"(%136, %135) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %138 = "llvm.select"(%137, %136, %131) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %139 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %140 = "llvm.shl"(%138, %139) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %141 = "llvm.bitcast"(%20) : (f32) -> i32
      %142 = "rocdl.ds_bpermute"(%140, %141) : (i32, i32) -> i32
      %143 = "llvm.bitcast"(%142) : (i32) -> f32
      %144 = "llvm.fadd"(%143, %20) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %145 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %146 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %147 = "rocdl.mbcnt.lo"(%146, %145) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %148 = "rocdl.mbcnt.hi"(%146, %147) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %149 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %150 = "llvm.sub"(%149, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %151 = "llvm.add"(%148, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %152 = "llvm.and"(%151, %150) : (i32, i32) -> i32
      %153 = "llvm.xor"(%148, %15) : (i32, i32) -> i32
      %154 = "llvm.icmp"(%153, %152) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %155 = "llvm.select"(%154, %153, %148) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %156 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %157 = "llvm.shl"(%155, %156) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %158 = "llvm.bitcast"(%144) : (f32) -> i32
      %159 = "rocdl.ds_bpermute"(%157, %158) : (i32, i32) -> i32
      %160 = "llvm.bitcast"(%159) : (i32) -> f32
      %161 = "llvm.fadd"(%144, %160) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %162 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %163 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %164 = "rocdl.mbcnt.lo"(%163, %162) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %165 = "rocdl.mbcnt.hi"(%163, %164) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %166 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %167 = "llvm.sub"(%166, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %168 = "llvm.add"(%165, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %169 = "llvm.and"(%168, %167) : (i32, i32) -> i32
      %170 = "llvm.xor"(%165, %14) : (i32, i32) -> i32
      %171 = "llvm.icmp"(%170, %169) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %172 = "llvm.select"(%171, %170, %165) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %173 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %174 = "llvm.shl"(%172, %173) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %175 = "llvm.bitcast"(%161) : (f32) -> i32
      %176 = "rocdl.ds_bpermute"(%174, %175) : (i32, i32) -> i32
      %177 = "llvm.bitcast"(%176) : (i32) -> f32
      %178 = "llvm.fadd"(%161, %177) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %179 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %180 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %181 = "rocdl.mbcnt.lo"(%180, %179) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %182 = "rocdl.mbcnt.hi"(%180, %181) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %183 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %184 = "llvm.sub"(%183, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %185 = "llvm.add"(%182, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %186 = "llvm.and"(%185, %184) : (i32, i32) -> i32
      %187 = "llvm.xor"(%182, %13) : (i32, i32) -> i32
      %188 = "llvm.icmp"(%187, %186) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %189 = "llvm.select"(%188, %187, %182) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %190 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %191 = "llvm.shl"(%189, %190) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %192 = "llvm.bitcast"(%178) : (f32) -> i32
      %193 = "rocdl.ds_bpermute"(%191, %192) : (i32, i32) -> i32
      %194 = "llvm.bitcast"(%193) : (i32) -> f32
      %195 = "llvm.fadd"(%178, %194) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %196 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %197 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %198 = "rocdl.mbcnt.lo"(%197, %196) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %199 = "rocdl.mbcnt.hi"(%197, %198) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %200 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %201 = "llvm.sub"(%200, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %202 = "llvm.add"(%199, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %203 = "llvm.and"(%202, %201) : (i32, i32) -> i32
      %204 = "llvm.xor"(%199, %12) : (i32, i32) -> i32
      %205 = "llvm.icmp"(%204, %203) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %206 = "llvm.select"(%205, %204, %199) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %207 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %208 = "llvm.shl"(%206, %207) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %209 = "llvm.bitcast"(%195) : (f32) -> i32
      %210 = "rocdl.ds_bpermute"(%208, %209) : (i32, i32) -> i32
      %211 = "llvm.bitcast"(%210) : (i32) -> f32
      %212 = "llvm.fadd"(%195, %211) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%212)[^bb18] : (f32) -> ()
    ^bb18(%213: f32):  // 2 preds: ^bb16, ^bb17
      "llvm.cond_br"(%34)[^bb19, ^bb20] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb19:  // pred: ^bb18
      %214 = "llvm.sdiv"(%31, %17) : (i32, i32) -> i32
      %215 = "llvm.extractvalue"(%10) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>) -> !llvm.ptr<3>
      %216 = "llvm.getelementptr"(%215, %214) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>
      "llvm.store"(%213, %216) <{ordering = 0 : i64}> : (f32, !llvm.ptr<3>) -> ()
      "llvm.br"()[^bb21] : () -> ()
    ^bb20:  // pred: ^bb18
      "llvm.br"()[^bb21] : () -> ()
    ^bb21:  // 2 preds: ^bb19, ^bb20
      "rocdl.barrier"() : () -> ()
      %217 = "llvm.add"(%32, %19) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %218 = "llvm.sdiv"(%217, %17) : (i32, i32) -> i32
      %219 = "llvm.icmp"(%31, %218) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%219)[^bb22, ^bb41] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb22:  // pred: ^bb21
      %220 = "llvm.extractvalue"(%10) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>) -> !llvm.ptr<3>
      %221 = "llvm.getelementptr"(%220, %31) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>
      %222 = "llvm.load"(%221) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> f32
      %223 = "llvm.icmp"(%218, %17) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%223)[^bb23, ^bb39] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb23:  // pred: ^bb22
      %224 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %225 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %226 = "rocdl.mbcnt.lo"(%225, %224) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %227 = "rocdl.mbcnt.hi"(%225, %226) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %228 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %229 = "llvm.sub"(%228, %218) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %230 = "llvm.add"(%227, %218) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %231 = "llvm.and"(%230, %229) : (i32, i32) -> i32
      %232 = "llvm.xor"(%227, %16) : (i32, i32) -> i32
      %233 = "llvm.icmp"(%232, %231) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %234 = "llvm.select"(%233, %232, %227) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %235 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %236 = "llvm.shl"(%234, %235) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %237 = "llvm.bitcast"(%222) : (f32) -> i32
      %238 = "rocdl.ds_bpermute"(%236, %237) : (i32, i32) -> i32
      %239 = "llvm.bitcast"(%238) : (i32) -> f32
      "llvm.cond_br"(%233)[^bb24, ^bb25] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb24:  // pred: ^bb23
      %240 = "llvm.fadd"(%222, %239) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%240)[^bb26] : (f32) -> ()
    ^bb25:  // pred: ^bb23
      "llvm.br"(%222)[^bb26] : (f32) -> ()
    ^bb26(%241: f32):  // 2 preds: ^bb24, ^bb25
      %242 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %243 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %244 = "rocdl.mbcnt.lo"(%243, %242) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %245 = "rocdl.mbcnt.hi"(%243, %244) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %246 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %247 = "llvm.sub"(%246, %218) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %248 = "llvm.add"(%245, %218) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %249 = "llvm.and"(%248, %247) : (i32, i32) -> i32
      %250 = "llvm.xor"(%245, %15) : (i32, i32) -> i32
      %251 = "llvm.icmp"(%250, %249) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %252 = "llvm.select"(%251, %250, %245) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %253 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %254 = "llvm.shl"(%252, %253) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %255 = "llvm.bitcast"(%241) : (f32) -> i32
      %256 = "rocdl.ds_bpermute"(%254, %255) : (i32, i32) -> i32
      %257 = "llvm.bitcast"(%256) : (i32) -> f32
      "llvm.cond_br"(%251)[^bb27, ^bb28] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb27:  // pred: ^bb26
      %258 = "llvm.fadd"(%241, %257) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%258)[^bb29] : (f32) -> ()
    ^bb28:  // pred: ^bb26
      "llvm.br"(%241)[^bb29] : (f32) -> ()
    ^bb29(%259: f32):  // 2 preds: ^bb27, ^bb28
      %260 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %261 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %262 = "rocdl.mbcnt.lo"(%261, %260) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %263 = "rocdl.mbcnt.hi"(%261, %262) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %264 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %265 = "llvm.sub"(%264, %218) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %266 = "llvm.add"(%263, %218) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %267 = "llvm.and"(%266, %265) : (i32, i32) -> i32
      %268 = "llvm.xor"(%263, %14) : (i32, i32) -> i32
      %269 = "llvm.icmp"(%268, %267) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %270 = "llvm.select"(%269, %268, %263) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %271 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %272 = "llvm.shl"(%270, %271) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %273 = "llvm.bitcast"(%259) : (f32) -> i32
      %274 = "rocdl.ds_bpermute"(%272, %273) : (i32, i32) -> i32
      %275 = "llvm.bitcast"(%274) : (i32) -> f32
      "llvm.cond_br"(%269)[^bb30, ^bb31] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb30:  // pred: ^bb29
      %276 = "llvm.fadd"(%259, %275) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%276)[^bb32] : (f32) -> ()
    ^bb31:  // pred: ^bb29
      "llvm.br"(%259)[^bb32] : (f32) -> ()
    ^bb32(%277: f32):  // 2 preds: ^bb30, ^bb31
      %278 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %279 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %280 = "rocdl.mbcnt.lo"(%279, %278) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %281 = "rocdl.mbcnt.hi"(%279, %280) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %282 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %283 = "llvm.sub"(%282, %218) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %284 = "llvm.add"(%281, %218) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %285 = "llvm.and"(%284, %283) : (i32, i32) -> i32
      %286 = "llvm.xor"(%281, %13) : (i32, i32) -> i32
      %287 = "llvm.icmp"(%286, %285) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %288 = "llvm.select"(%287, %286, %281) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %289 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %290 = "llvm.shl"(%288, %289) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %291 = "llvm.bitcast"(%277) : (f32) -> i32
      %292 = "rocdl.ds_bpermute"(%290, %291) : (i32, i32) -> i32
      %293 = "llvm.bitcast"(%292) : (i32) -> f32
      "llvm.cond_br"(%287)[^bb33, ^bb34] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb33:  // pred: ^bb32
      %294 = "llvm.fadd"(%277, %293) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%294)[^bb35] : (f32) -> ()
    ^bb34:  // pred: ^bb32
      "llvm.br"(%277)[^bb35] : (f32) -> ()
    ^bb35(%295: f32):  // 2 preds: ^bb33, ^bb34
      %296 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %297 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %298 = "rocdl.mbcnt.lo"(%297, %296) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %299 = "rocdl.mbcnt.hi"(%297, %298) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %300 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %301 = "llvm.sub"(%300, %218) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %302 = "llvm.add"(%299, %218) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %303 = "llvm.and"(%302, %301) : (i32, i32) -> i32
      %304 = "llvm.xor"(%299, %12) : (i32, i32) -> i32
      %305 = "llvm.icmp"(%304, %303) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %306 = "llvm.select"(%305, %304, %299) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %307 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %308 = "llvm.shl"(%306, %307) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %309 = "llvm.bitcast"(%295) : (f32) -> i32
      %310 = "rocdl.ds_bpermute"(%308, %309) : (i32, i32) -> i32
      %311 = "llvm.bitcast"(%310) : (i32) -> f32
      "llvm.cond_br"(%305)[^bb36, ^bb37] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb36:  // pred: ^bb35
      %312 = "llvm.fadd"(%295, %311) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%312)[^bb38] : (f32) -> ()
    ^bb37:  // pred: ^bb35
      "llvm.br"(%295)[^bb38] : (f32) -> ()
    ^bb38(%313: f32):  // 2 preds: ^bb36, ^bb37
      "llvm.br"(%313)[^bb40] : (f32) -> ()
    ^bb39:  // pred: ^bb22
      %314 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %315 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %316 = "rocdl.mbcnt.lo"(%315, %314) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %317 = "rocdl.mbcnt.hi"(%315, %316) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %318 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %319 = "llvm.sub"(%318, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %320 = "llvm.add"(%317, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %321 = "llvm.and"(%320, %319) : (i32, i32) -> i32
      %322 = "llvm.xor"(%317, %16) : (i32, i32) -> i32
      %323 = "llvm.icmp"(%322, %321) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %324 = "llvm.select"(%323, %322, %317) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %325 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %326 = "llvm.shl"(%324, %325) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %327 = "llvm.bitcast"(%222) : (f32) -> i32
      %328 = "rocdl.ds_bpermute"(%326, %327) : (i32, i32) -> i32
      %329 = "llvm.bitcast"(%328) : (i32) -> f32
      %330 = "llvm.fadd"(%222, %329) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %331 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %332 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %333 = "rocdl.mbcnt.lo"(%332, %331) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %334 = "rocdl.mbcnt.hi"(%332, %333) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %335 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %336 = "llvm.sub"(%335, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %337 = "llvm.add"(%334, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %338 = "llvm.and"(%337, %336) : (i32, i32) -> i32
      %339 = "llvm.xor"(%334, %15) : (i32, i32) -> i32
      %340 = "llvm.icmp"(%339, %338) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %341 = "llvm.select"(%340, %339, %334) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %342 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %343 = "llvm.shl"(%341, %342) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %344 = "llvm.bitcast"(%330) : (f32) -> i32
      %345 = "rocdl.ds_bpermute"(%343, %344) : (i32, i32) -> i32
      %346 = "llvm.bitcast"(%345) : (i32) -> f32
      %347 = "llvm.fadd"(%330, %346) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %348 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %349 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %350 = "rocdl.mbcnt.lo"(%349, %348) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %351 = "rocdl.mbcnt.hi"(%349, %350) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %352 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %353 = "llvm.sub"(%352, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %354 = "llvm.add"(%351, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %355 = "llvm.and"(%354, %353) : (i32, i32) -> i32
      %356 = "llvm.xor"(%351, %14) : (i32, i32) -> i32
      %357 = "llvm.icmp"(%356, %355) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %358 = "llvm.select"(%357, %356, %351) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %359 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %360 = "llvm.shl"(%358, %359) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %361 = "llvm.bitcast"(%347) : (f32) -> i32
      %362 = "rocdl.ds_bpermute"(%360, %361) : (i32, i32) -> i32
      %363 = "llvm.bitcast"(%362) : (i32) -> f32
      %364 = "llvm.fadd"(%347, %363) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %365 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %366 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %367 = "rocdl.mbcnt.lo"(%366, %365) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %368 = "rocdl.mbcnt.hi"(%366, %367) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %369 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %370 = "llvm.sub"(%369, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %371 = "llvm.add"(%368, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %372 = "llvm.and"(%371, %370) : (i32, i32) -> i32
      %373 = "llvm.xor"(%368, %13) : (i32, i32) -> i32
      %374 = "llvm.icmp"(%373, %372) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %375 = "llvm.select"(%374, %373, %368) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %376 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %377 = "llvm.shl"(%375, %376) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %378 = "llvm.bitcast"(%364) : (f32) -> i32
      %379 = "rocdl.ds_bpermute"(%377, %378) : (i32, i32) -> i32
      %380 = "llvm.bitcast"(%379) : (i32) -> f32
      %381 = "llvm.fadd"(%364, %380) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %382 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %383 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %384 = "rocdl.mbcnt.lo"(%383, %382) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %385 = "rocdl.mbcnt.hi"(%383, %384) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %386 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %387 = "llvm.sub"(%386, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %388 = "llvm.add"(%385, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %389 = "llvm.and"(%388, %387) : (i32, i32) -> i32
      %390 = "llvm.xor"(%385, %12) : (i32, i32) -> i32
      %391 = "llvm.icmp"(%390, %389) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %392 = "llvm.select"(%391, %390, %385) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %393 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %394 = "llvm.shl"(%392, %393) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %395 = "llvm.bitcast"(%381) : (f32) -> i32
      %396 = "rocdl.ds_bpermute"(%394, %395) : (i32, i32) -> i32
      %397 = "llvm.bitcast"(%396) : (i32) -> f32
      %398 = "llvm.fadd"(%381, %397) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%398)[^bb40] : (f32) -> ()
    ^bb40(%399: f32):  // 2 preds: ^bb38, ^bb39
      %400 = "llvm.extractvalue"(%10) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>) -> !llvm.ptr<3>
      %401 = "llvm.getelementptr"(%400, %11) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>
      "llvm.store"(%399, %401) <{ordering = 0 : i64}> : (f32, !llvm.ptr<3>) -> ()
      "llvm.br"()[^bb42] : () -> ()
    ^bb41:  // pred: ^bb21
      "llvm.br"()[^bb42] : () -> ()
    ^bb42:  // 2 preds: ^bb40, ^bb41
      "rocdl.barrier"() : () -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.mlir.global"() <{addr_space = 3 : i32, global_type = !llvm.array<32 x i32>, linkage = #llvm.linkage<internal>, sym_name = "__wg_gpu_all_reduce_region_0", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_all_reduce_region", visibility_ = 0 : i64}> ({
      %0 = "llvm.mlir.addressof"() <{global_name = @__wg_gpu_all_reduce_region_0}> : () -> !llvm.ptr<3>
      %1 = "llvm.getelementptr"(%0) <{elem_type = !llvm.array<32 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr<3>) -> !llvm.ptr<3>
      %2 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %3 = "llvm.insertvalue"(%2, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %4 = "llvm.insertvalue"(%3, %1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %5 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i32
      %6 = "llvm.insertvalue"(%4, %5) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %7 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i32
      %8 = "llvm.insertvalue"(%6, %7) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %9 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i32
      %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %11 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i32
      %12 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
      %13 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
      %14 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
      %15 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %16 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %17 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %18 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
      %19 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %20 = "rocdl.workgroup.dim.x"() : () -> i32
      %21 = "rocdl.workgroup.dim.y"() : () -> i32
      %22 = "rocdl.workgroup.dim.z"() : () -> i32
      %23 = "rocdl.workitem.id.x"() : () -> i32
      %24 = "rocdl.workitem.id.y"() : () -> i32
      %25 = "rocdl.workitem.id.z"() : () -> i32
      %26 = "llvm.mul"(%25, %21) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %27 = "llvm.add"(%26, %24) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %28 = "llvm.mul"(%27, %20) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %29 = "llvm.mul"(%20, %21) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %30 = "llvm.add"(%28, %23) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %31 = "llvm.mul"(%29, %22) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %32 = "llvm.and"(%30, %18) : (i32, i32) -> i32
      %33 = "llvm.icmp"(%32, %17) <{predicate = 0 : i64}> : (i32, i32) -> i1
      %34 = "llvm.sub"(%30, %32) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %35 = "llvm.sub"(%31, %34) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %36 = "llvm.icmp"(%35, %16) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%36)[^bb1, ^bb22] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %37 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %38 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %39 = "rocdl.mbcnt.lo"(%38, %37) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %40 = "rocdl.mbcnt.hi"(%38, %39) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %41 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %42 = "llvm.sub"(%41, %35) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %43 = "llvm.add"(%40, %35) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %44 = "llvm.and"(%43, %42) : (i32, i32) -> i32
      %45 = "llvm.xor"(%40, %19) : (i32, i32) -> i32
      %46 = "llvm.icmp"(%45, %44) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %47 = "llvm.select"(%46, %45, %40) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %48 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %49 = "llvm.shl"(%47, %48) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %50 = "rocdl.ds_bpermute"(%49, %19) : (i32, i32) -> i32
      "llvm.cond_br"(%46, %19)[^bb2, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb2:  // pred: ^bb1
      "llvm.br"()[^bb3] : () -> ()
    ^bb3:  // pred: ^bb2
      %51 = "llvm.xor"(%50, %19) : (i32, i32) -> i32
      "llvm.br"(%51)[^bb4] : (i32) -> ()
    ^bb4(%52: i32):  // 2 preds: ^bb1, ^bb3
      "llvm.br"()[^bb5] : () -> ()
    ^bb5:  // pred: ^bb4
      %53 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %54 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %55 = "rocdl.mbcnt.lo"(%54, %53) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %56 = "rocdl.mbcnt.hi"(%54, %55) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %57 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %58 = "llvm.sub"(%57, %35) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %59 = "llvm.add"(%56, %35) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %60 = "llvm.and"(%59, %58) : (i32, i32) -> i32
      %61 = "llvm.xor"(%56, %15) : (i32, i32) -> i32
      %62 = "llvm.icmp"(%61, %60) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %63 = "llvm.select"(%62, %61, %56) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %64 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %65 = "llvm.shl"(%63, %64) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %66 = "rocdl.ds_bpermute"(%65, %52) : (i32, i32) -> i32
      "llvm.cond_br"(%62, %52)[^bb6, ^bb8] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb6:  // pred: ^bb5
      "llvm.br"()[^bb7] : () -> ()
    ^bb7:  // pred: ^bb6
      %67 = "llvm.xor"(%52, %66) : (i32, i32) -> i32
      "llvm.br"(%67)[^bb8] : (i32) -> ()
    ^bb8(%68: i32):  // 2 preds: ^bb5, ^bb7
      "llvm.br"()[^bb9] : () -> ()
    ^bb9:  // pred: ^bb8
      %69 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %70 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %71 = "rocdl.mbcnt.lo"(%70, %69) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %72 = "rocdl.mbcnt.hi"(%70, %71) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %73 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %74 = "llvm.sub"(%73, %35) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %75 = "llvm.add"(%72, %35) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %76 = "llvm.and"(%75, %74) : (i32, i32) -> i32
      %77 = "llvm.xor"(%72, %14) : (i32, i32) -> i32
      %78 = "llvm.icmp"(%77, %76) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %79 = "llvm.select"(%78, %77, %72) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %80 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %81 = "llvm.shl"(%79, %80) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %82 = "rocdl.ds_bpermute"(%81, %68) : (i32, i32) -> i32
      "llvm.cond_br"(%78, %68)[^bb10, ^bb12] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb10:  // pred: ^bb9
      "llvm.br"()[^bb11] : () -> ()
    ^bb11:  // pred: ^bb10
      %83 = "llvm.xor"(%68, %82) : (i32, i32) -> i32
      "llvm.br"(%83)[^bb12] : (i32) -> ()
    ^bb12(%84: i32):  // 2 preds: ^bb9, ^bb11
      "llvm.br"()[^bb13] : () -> ()
    ^bb13:  // pred: ^bb12
      %85 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %86 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %87 = "rocdl.mbcnt.lo"(%86, %85) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %88 = "rocdl.mbcnt.hi"(%86, %87) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %89 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %90 = "llvm.sub"(%89, %35) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %91 = "llvm.add"(%88, %35) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %92 = "llvm.and"(%91, %90) : (i32, i32) -> i32
      %93 = "llvm.xor"(%88, %13) : (i32, i32) -> i32
      %94 = "llvm.icmp"(%93, %92) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %95 = "llvm.select"(%94, %93, %88) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %96 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %97 = "llvm.shl"(%95, %96) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %98 = "rocdl.ds_bpermute"(%97, %84) : (i32, i32) -> i32
      "llvm.cond_br"(%94, %84)[^bb14, ^bb16] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb14:  // pred: ^bb13
      "llvm.br"()[^bb15] : () -> ()
    ^bb15:  // pred: ^bb14
      %99 = "llvm.xor"(%84, %98) : (i32, i32) -> i32
      "llvm.br"(%99)[^bb16] : (i32) -> ()
    ^bb16(%100: i32):  // 2 preds: ^bb13, ^bb15
      "llvm.br"()[^bb17] : () -> ()
    ^bb17:  // pred: ^bb16
      %101 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %102 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %103 = "rocdl.mbcnt.lo"(%102, %101) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %104 = "rocdl.mbcnt.hi"(%102, %103) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %105 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %106 = "llvm.sub"(%105, %35) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %107 = "llvm.add"(%104, %35) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %108 = "llvm.and"(%107, %106) : (i32, i32) -> i32
      %109 = "llvm.xor"(%104, %12) : (i32, i32) -> i32
      %110 = "llvm.icmp"(%109, %108) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %111 = "llvm.select"(%110, %109, %104) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %112 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %113 = "llvm.shl"(%111, %112) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %114 = "rocdl.ds_bpermute"(%113, %100) : (i32, i32) -> i32
      "llvm.cond_br"(%110, %100)[^bb18, ^bb20] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb18:  // pred: ^bb17
      "llvm.br"()[^bb19] : () -> ()
    ^bb19:  // pred: ^bb18
      %115 = "llvm.xor"(%100, %114) : (i32, i32) -> i32
      "llvm.br"(%115)[^bb20] : (i32) -> ()
    ^bb20(%116: i32):  // 2 preds: ^bb17, ^bb19
      "llvm.br"(%116)[^bb21] : (i32) -> ()
    ^bb21(%117: i32):  // 2 preds: ^bb20, ^bb31
      "llvm.br"()[^bb32] : () -> ()
    ^bb22:  // pred: ^bb0
      %118 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %119 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %120 = "rocdl.mbcnt.lo"(%119, %118) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %121 = "rocdl.mbcnt.hi"(%119, %120) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %122 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %123 = "llvm.sub"(%122, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %124 = "llvm.add"(%121, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %125 = "llvm.and"(%124, %123) : (i32, i32) -> i32
      %126 = "llvm.xor"(%121, %19) : (i32, i32) -> i32
      %127 = "llvm.icmp"(%126, %125) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %128 = "llvm.select"(%127, %126, %121) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %129 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %130 = "llvm.shl"(%128, %129) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %131 = "rocdl.ds_bpermute"(%130, %19) : (i32, i32) -> i32
      "llvm.br"()[^bb23] : () -> ()
    ^bb23:  // pred: ^bb22
      %132 = "llvm.xor"(%131, %19) : (i32, i32) -> i32
      "llvm.br"()[^bb24] : () -> ()
    ^bb24:  // pred: ^bb23
      %133 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %134 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %135 = "rocdl.mbcnt.lo"(%134, %133) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %136 = "rocdl.mbcnt.hi"(%134, %135) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %137 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %138 = "llvm.sub"(%137, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %139 = "llvm.add"(%136, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %140 = "llvm.and"(%139, %138) : (i32, i32) -> i32
      %141 = "llvm.xor"(%136, %15) : (i32, i32) -> i32
      %142 = "llvm.icmp"(%141, %140) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %143 = "llvm.select"(%142, %141, %136) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %144 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %145 = "llvm.shl"(%143, %144) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %146 = "rocdl.ds_bpermute"(%145, %132) : (i32, i32) -> i32
      "llvm.br"()[^bb25] : () -> ()
    ^bb25:  // pred: ^bb24
      %147 = "llvm.xor"(%132, %146) : (i32, i32) -> i32
      "llvm.br"()[^bb26] : () -> ()
    ^bb26:  // pred: ^bb25
      %148 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %149 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %150 = "rocdl.mbcnt.lo"(%149, %148) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %151 = "rocdl.mbcnt.hi"(%149, %150) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %152 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %153 = "llvm.sub"(%152, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %154 = "llvm.add"(%151, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %155 = "llvm.and"(%154, %153) : (i32, i32) -> i32
      %156 = "llvm.xor"(%151, %14) : (i32, i32) -> i32
      %157 = "llvm.icmp"(%156, %155) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %158 = "llvm.select"(%157, %156, %151) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %159 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %160 = "llvm.shl"(%158, %159) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %161 = "rocdl.ds_bpermute"(%160, %147) : (i32, i32) -> i32
      "llvm.br"()[^bb27] : () -> ()
    ^bb27:  // pred: ^bb26
      %162 = "llvm.xor"(%147, %161) : (i32, i32) -> i32
      "llvm.br"()[^bb28] : () -> ()
    ^bb28:  // pred: ^bb27
      %163 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %164 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %165 = "rocdl.mbcnt.lo"(%164, %163) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %166 = "rocdl.mbcnt.hi"(%164, %165) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %167 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %168 = "llvm.sub"(%167, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %169 = "llvm.add"(%166, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %170 = "llvm.and"(%169, %168) : (i32, i32) -> i32
      %171 = "llvm.xor"(%166, %13) : (i32, i32) -> i32
      %172 = "llvm.icmp"(%171, %170) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %173 = "llvm.select"(%172, %171, %166) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %174 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %175 = "llvm.shl"(%173, %174) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %176 = "rocdl.ds_bpermute"(%175, %162) : (i32, i32) -> i32
      "llvm.br"()[^bb29] : () -> ()
    ^bb29:  // pred: ^bb28
      %177 = "llvm.xor"(%162, %176) : (i32, i32) -> i32
      "llvm.br"()[^bb30] : () -> ()
    ^bb30:  // pred: ^bb29
      %178 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %179 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %180 = "rocdl.mbcnt.lo"(%179, %178) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %181 = "rocdl.mbcnt.hi"(%179, %180) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %182 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %183 = "llvm.sub"(%182, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %184 = "llvm.add"(%181, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %185 = "llvm.and"(%184, %183) : (i32, i32) -> i32
      %186 = "llvm.xor"(%181, %12) : (i32, i32) -> i32
      %187 = "llvm.icmp"(%186, %185) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %188 = "llvm.select"(%187, %186, %181) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %189 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %190 = "llvm.shl"(%188, %189) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %191 = "rocdl.ds_bpermute"(%190, %177) : (i32, i32) -> i32
      "llvm.br"()[^bb31] : () -> ()
    ^bb31:  // pred: ^bb30
      %192 = "llvm.xor"(%177, %191) : (i32, i32) -> i32
      "llvm.br"(%192)[^bb21] : (i32) -> ()
    ^bb32:  // pred: ^bb21
      "llvm.cond_br"(%33)[^bb33, ^bb34] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb33:  // pred: ^bb32
      %193 = "llvm.sdiv"(%30, %16) : (i32, i32) -> i32
      %194 = "llvm.extractvalue"(%10) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>) -> !llvm.ptr<3>
      %195 = "llvm.getelementptr"(%194, %193) <{elem_type = i32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>
      "llvm.store"(%117, %195) <{ordering = 0 : i64}> : (i32, !llvm.ptr<3>) -> ()
      "llvm.br"()[^bb35] : () -> ()
    ^bb34:  // pred: ^bb32
      "llvm.br"()[^bb35] : () -> ()
    ^bb35:  // 2 preds: ^bb33, ^bb34
      "rocdl.barrier"() : () -> ()
      %196 = "llvm.add"(%31, %18) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %197 = "llvm.sdiv"(%196, %16) : (i32, i32) -> i32
      %198 = "llvm.icmp"(%30, %197) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%198)[^bb36, ^bb69] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb36:  // pred: ^bb35
      %199 = "llvm.extractvalue"(%10) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>) -> !llvm.ptr<3>
      %200 = "llvm.getelementptr"(%199, %30) <{elem_type = i32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>
      %201 = "llvm.load"(%200) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> i32
      %202 = "llvm.icmp"(%197, %16) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%202)[^bb37, ^bb58] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb37:  // pred: ^bb36
      %203 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %204 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %205 = "rocdl.mbcnt.lo"(%204, %203) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %206 = "rocdl.mbcnt.hi"(%204, %205) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %207 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %208 = "llvm.sub"(%207, %197) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %209 = "llvm.add"(%206, %197) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %210 = "llvm.and"(%209, %208) : (i32, i32) -> i32
      %211 = "llvm.xor"(%206, %19) : (i32, i32) -> i32
      %212 = "llvm.icmp"(%211, %210) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %213 = "llvm.select"(%212, %211, %206) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %214 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %215 = "llvm.shl"(%213, %214) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %216 = "rocdl.ds_bpermute"(%215, %201) : (i32, i32) -> i32
      "llvm.cond_br"(%212, %201)[^bb38, ^bb40] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb38:  // pred: ^bb37
      "llvm.br"()[^bb39] : () -> ()
    ^bb39:  // pred: ^bb38
      %217 = "llvm.xor"(%201, %216) : (i32, i32) -> i32
      "llvm.br"(%217)[^bb40] : (i32) -> ()
    ^bb40(%218: i32):  // 2 preds: ^bb37, ^bb39
      "llvm.br"()[^bb41] : () -> ()
    ^bb41:  // pred: ^bb40
      %219 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %220 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %221 = "rocdl.mbcnt.lo"(%220, %219) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %222 = "rocdl.mbcnt.hi"(%220, %221) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %223 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %224 = "llvm.sub"(%223, %197) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %225 = "llvm.add"(%222, %197) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %226 = "llvm.and"(%225, %224) : (i32, i32) -> i32
      %227 = "llvm.xor"(%222, %15) : (i32, i32) -> i32
      %228 = "llvm.icmp"(%227, %226) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %229 = "llvm.select"(%228, %227, %222) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %230 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %231 = "llvm.shl"(%229, %230) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %232 = "rocdl.ds_bpermute"(%231, %218) : (i32, i32) -> i32
      "llvm.cond_br"(%228, %218)[^bb42, ^bb44] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb42:  // pred: ^bb41
      "llvm.br"()[^bb43] : () -> ()
    ^bb43:  // pred: ^bb42
      %233 = "llvm.xor"(%218, %232) : (i32, i32) -> i32
      "llvm.br"(%233)[^bb44] : (i32) -> ()
    ^bb44(%234: i32):  // 2 preds: ^bb41, ^bb43
      "llvm.br"()[^bb45] : () -> ()
    ^bb45:  // pred: ^bb44
      %235 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %236 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %237 = "rocdl.mbcnt.lo"(%236, %235) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %238 = "rocdl.mbcnt.hi"(%236, %237) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %239 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %240 = "llvm.sub"(%239, %197) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %241 = "llvm.add"(%238, %197) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %242 = "llvm.and"(%241, %240) : (i32, i32) -> i32
      %243 = "llvm.xor"(%238, %14) : (i32, i32) -> i32
      %244 = "llvm.icmp"(%243, %242) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %245 = "llvm.select"(%244, %243, %238) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %246 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %247 = "llvm.shl"(%245, %246) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %248 = "rocdl.ds_bpermute"(%247, %234) : (i32, i32) -> i32
      "llvm.cond_br"(%244, %234)[^bb46, ^bb48] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb46:  // pred: ^bb45
      "llvm.br"()[^bb47] : () -> ()
    ^bb47:  // pred: ^bb46
      %249 = "llvm.xor"(%234, %248) : (i32, i32) -> i32
      "llvm.br"(%249)[^bb48] : (i32) -> ()
    ^bb48(%250: i32):  // 2 preds: ^bb45, ^bb47
      "llvm.br"()[^bb49] : () -> ()
    ^bb49:  // pred: ^bb48
      %251 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %252 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %253 = "rocdl.mbcnt.lo"(%252, %251) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %254 = "rocdl.mbcnt.hi"(%252, %253) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %255 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %256 = "llvm.sub"(%255, %197) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %257 = "llvm.add"(%254, %197) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %258 = "llvm.and"(%257, %256) : (i32, i32) -> i32
      %259 = "llvm.xor"(%254, %13) : (i32, i32) -> i32
      %260 = "llvm.icmp"(%259, %258) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %261 = "llvm.select"(%260, %259, %254) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %262 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %263 = "llvm.shl"(%261, %262) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %264 = "rocdl.ds_bpermute"(%263, %250) : (i32, i32) -> i32
      "llvm.cond_br"(%260, %250)[^bb50, ^bb52] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb50:  // pred: ^bb49
      "llvm.br"()[^bb51] : () -> ()
    ^bb51:  // pred: ^bb50
      %265 = "llvm.xor"(%250, %264) : (i32, i32) -> i32
      "llvm.br"(%265)[^bb52] : (i32) -> ()
    ^bb52(%266: i32):  // 2 preds: ^bb49, ^bb51
      "llvm.br"()[^bb53] : () -> ()
    ^bb53:  // pred: ^bb52
      %267 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %268 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %269 = "rocdl.mbcnt.lo"(%268, %267) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %270 = "rocdl.mbcnt.hi"(%268, %269) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %271 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %272 = "llvm.sub"(%271, %197) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %273 = "llvm.add"(%270, %197) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %274 = "llvm.and"(%273, %272) : (i32, i32) -> i32
      %275 = "llvm.xor"(%270, %12) : (i32, i32) -> i32
      %276 = "llvm.icmp"(%275, %274) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %277 = "llvm.select"(%276, %275, %270) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %278 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %279 = "llvm.shl"(%277, %278) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %280 = "rocdl.ds_bpermute"(%279, %266) : (i32, i32) -> i32
      "llvm.cond_br"(%276, %266)[^bb54, ^bb56] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb54:  // pred: ^bb53
      "llvm.br"()[^bb55] : () -> ()
    ^bb55:  // pred: ^bb54
      %281 = "llvm.xor"(%266, %280) : (i32, i32) -> i32
      "llvm.br"(%281)[^bb56] : (i32) -> ()
    ^bb56(%282: i32):  // 2 preds: ^bb53, ^bb55
      "llvm.br"(%282)[^bb57] : (i32) -> ()
    ^bb57(%283: i32):  // 2 preds: ^bb56, ^bb67
      "llvm.br"()[^bb68] : () -> ()
    ^bb58:  // pred: ^bb36
      %284 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %285 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %286 = "rocdl.mbcnt.lo"(%285, %284) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %287 = "rocdl.mbcnt.hi"(%285, %286) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %288 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %289 = "llvm.sub"(%288, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %290 = "llvm.add"(%287, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %291 = "llvm.and"(%290, %289) : (i32, i32) -> i32
      %292 = "llvm.xor"(%287, %19) : (i32, i32) -> i32
      %293 = "llvm.icmp"(%292, %291) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %294 = "llvm.select"(%293, %292, %287) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %295 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %296 = "llvm.shl"(%294, %295) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %297 = "rocdl.ds_bpermute"(%296, %201) : (i32, i32) -> i32
      "llvm.br"()[^bb59] : () -> ()
    ^bb59:  // pred: ^bb58
      %298 = "llvm.xor"(%201, %297) : (i32, i32) -> i32
      "llvm.br"()[^bb60] : () -> ()
    ^bb60:  // pred: ^bb59
      %299 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %300 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %301 = "rocdl.mbcnt.lo"(%300, %299) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %302 = "rocdl.mbcnt.hi"(%300, %301) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %303 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %304 = "llvm.sub"(%303, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %305 = "llvm.add"(%302, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %306 = "llvm.and"(%305, %304) : (i32, i32) -> i32
      %307 = "llvm.xor"(%302, %15) : (i32, i32) -> i32
      %308 = "llvm.icmp"(%307, %306) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %309 = "llvm.select"(%308, %307, %302) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %310 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %311 = "llvm.shl"(%309, %310) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %312 = "rocdl.ds_bpermute"(%311, %298) : (i32, i32) -> i32
      "llvm.br"()[^bb61] : () -> ()
    ^bb61:  // pred: ^bb60
      %313 = "llvm.xor"(%298, %312) : (i32, i32) -> i32
      "llvm.br"()[^bb62] : () -> ()
    ^bb62:  // pred: ^bb61
      %314 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %315 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %316 = "rocdl.mbcnt.lo"(%315, %314) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %317 = "rocdl.mbcnt.hi"(%315, %316) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %318 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %319 = "llvm.sub"(%318, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %320 = "llvm.add"(%317, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %321 = "llvm.and"(%320, %319) : (i32, i32) -> i32
      %322 = "llvm.xor"(%317, %14) : (i32, i32) -> i32
      %323 = "llvm.icmp"(%322, %321) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %324 = "llvm.select"(%323, %322, %317) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %325 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %326 = "llvm.shl"(%324, %325) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %327 = "rocdl.ds_bpermute"(%326, %313) : (i32, i32) -> i32
      "llvm.br"()[^bb63] : () -> ()
    ^bb63:  // pred: ^bb62
      %328 = "llvm.xor"(%313, %327) : (i32, i32) -> i32
      "llvm.br"()[^bb64] : () -> ()
    ^bb64:  // pred: ^bb63
      %329 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %330 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %331 = "rocdl.mbcnt.lo"(%330, %329) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %332 = "rocdl.mbcnt.hi"(%330, %331) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %333 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %334 = "llvm.sub"(%333, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %335 = "llvm.add"(%332, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %336 = "llvm.and"(%335, %334) : (i32, i32) -> i32
      %337 = "llvm.xor"(%332, %13) : (i32, i32) -> i32
      %338 = "llvm.icmp"(%337, %336) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %339 = "llvm.select"(%338, %337, %332) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %340 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %341 = "llvm.shl"(%339, %340) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %342 = "rocdl.ds_bpermute"(%341, %328) : (i32, i32) -> i32
      "llvm.br"()[^bb65] : () -> ()
    ^bb65:  // pred: ^bb64
      %343 = "llvm.xor"(%328, %342) : (i32, i32) -> i32
      "llvm.br"()[^bb66] : () -> ()
    ^bb66:  // pred: ^bb65
      %344 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %345 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %346 = "rocdl.mbcnt.lo"(%345, %344) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %347 = "rocdl.mbcnt.hi"(%345, %346) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %348 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %349 = "llvm.sub"(%348, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %350 = "llvm.add"(%347, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %351 = "llvm.and"(%350, %349) : (i32, i32) -> i32
      %352 = "llvm.xor"(%347, %12) : (i32, i32) -> i32
      %353 = "llvm.icmp"(%352, %351) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %354 = "llvm.select"(%353, %352, %347) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %355 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %356 = "llvm.shl"(%354, %355) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %357 = "rocdl.ds_bpermute"(%356, %343) : (i32, i32) -> i32
      "llvm.br"()[^bb67] : () -> ()
    ^bb67:  // pred: ^bb66
      %358 = "llvm.xor"(%343, %357) : (i32, i32) -> i32
      "llvm.br"(%358)[^bb57] : (i32) -> ()
    ^bb68:  // pred: ^bb57
      %359 = "llvm.extractvalue"(%10) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>) -> !llvm.ptr<3>
      %360 = "llvm.getelementptr"(%359, %11) <{elem_type = i32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>
      "llvm.store"(%283, %360) <{ordering = 0 : i64}> : (i32, !llvm.ptr<3>) -> ()
      "llvm.br"()[^bb70] : () -> ()
    ^bb69:  // pred: ^bb35
      "llvm.br"()[^bb70] : () -> ()
    ^bb70:  // 2 preds: ^bb68, ^bb69
      "rocdl.barrier"() : () -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f16 (f16, f16)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_fmod_f16", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_fmod_f32", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (f64, f64)>, linkage = #llvm.linkage<external>, sym_name = "__ocml_fmod_f64", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f32, f64)> (f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_fmod", visibility_ = 0 : i64}> ({
    ^bb0(%arg4: f16, %arg5: f32, %arg6: f64):
      %1 = "llvm.call"(%arg4, %arg4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_fmod_f16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f16, f16) -> f16
      %2 = "llvm.call"(%arg5, %arg5) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_fmod_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f32, f32) -> f32
      %3 = "llvm.call"(%arg6, %arg6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_fmod_f64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f64, f64) -> f64
      %4 = "llvm.mlir.poison"() : () -> !llvm.struct<(f16, f32, f64)>
      %5 = "llvm.insertvalue"(%4, %1) <{position = array<i64: 0>}> : (!llvm.struct<(f16, f32, f64)>, f16) -> !llvm.struct<(f16, f32, f64)>
      %6 = "llvm.insertvalue"(%5, %2) <{position = array<i64: 1>}> : (!llvm.struct<(f16, f32, f64)>, f32) -> !llvm.struct<(f16, f32, f64)>
      %7 = "llvm.insertvalue"(%6, %3) <{position = array<i64: 2>}> : (!llvm.struct<(f16, f32, f64)>, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.return"(%7) : (!llvm.struct<(f16, f32, f64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, f16, f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_fmod", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: f16, %arg2: f32, %arg3: f64):
      %0 = "llvm.call"(%arg1, %arg2, %arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_fmod, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (f16, f32, f64) -> !llvm.struct<(f16, f32, f64)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(f16, f32, f64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f32, f32, f32)> ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_shuffle", visibility_ = 0 : i64}> ({
      %52 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %53 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
      %54 = "llvm.mlir.constant"() <{value = 23 : i32}> : () -> i32
      %55 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %56 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %57 = "rocdl.mbcnt.lo"(%56, %55) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %58 = "rocdl.mbcnt.hi"(%56, %57) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %59 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %60 = "llvm.sub"(%59, %54) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %61 = "llvm.add"(%58, %54) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %62 = "llvm.and"(%61, %60) : (i32, i32) -> i32
      %63 = "llvm.xor"(%58, %53) : (i32, i32) -> i32
      %64 = "llvm.icmp"(%63, %62) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %65 = "llvm.select"(%64, %63, %58) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %66 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %67 = "llvm.shl"(%65, %66) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %68 = "llvm.bitcast"(%52) : (f32) -> i32
      %69 = "rocdl.ds_bpermute"(%67, %68) : (i32, i32) -> i32
      %70 = "llvm.bitcast"(%69) : (i32) -> f32
      %71 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %72 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %73 = "rocdl.mbcnt.lo"(%72, %71) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %74 = "rocdl.mbcnt.hi"(%72, %73) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %75 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %76 = "llvm.sub"(%75, %54) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %77 = "llvm.add"(%74, %54) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %78 = "llvm.and"(%77, %76) : (i32, i32) -> i32
      %79 = "llvm.icmp"(%53, %78) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %80 = "llvm.select"(%79, %53, %74) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %81 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %82 = "llvm.shl"(%80, %81) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %83 = "llvm.bitcast"(%52) : (f32) -> i32
      %84 = "rocdl.ds_bpermute"(%82, %83) : (i32, i32) -> i32
      %85 = "llvm.bitcast"(%84) : (i32) -> f32
      %86 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %87 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %88 = "rocdl.mbcnt.lo"(%87, %86) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %89 = "rocdl.mbcnt.hi"(%87, %88) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %90 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %91 = "llvm.sub"(%90, %54) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %92 = "llvm.add"(%89, %54) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %93 = "llvm.and"(%92, %91) : (i32, i32) -> i32
      %94 = "llvm.sub"(%89, %53) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %95 = "llvm.icmp"(%94, %93) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %96 = "llvm.select"(%95, %94, %89) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %97 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %98 = "llvm.shl"(%96, %97) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %99 = "llvm.bitcast"(%52) : (f32) -> i32
      %100 = "rocdl.ds_bpermute"(%98, %99) : (i32, i32) -> i32
      %101 = "llvm.bitcast"(%100) : (i32) -> f32
      %102 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %103 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %104 = "rocdl.mbcnt.lo"(%103, %102) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %105 = "rocdl.mbcnt.hi"(%103, %104) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %106 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %107 = "llvm.sub"(%106, %54) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %108 = "llvm.add"(%105, %54) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %109 = "llvm.and"(%108, %107) : (i32, i32) -> i32
      %110 = "llvm.add"(%105, %53) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %111 = "llvm.icmp"(%110, %109) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %112 = "llvm.select"(%111, %110, %105) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %113 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %114 = "llvm.shl"(%112, %113) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %115 = "llvm.bitcast"(%52) : (f32) -> i32
      %116 = "rocdl.ds_bpermute"(%114, %115) : (i32, i32) -> i32
      %117 = "llvm.bitcast"(%116) : (i32) -> f32
      %118 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f32, f32, f32)>
      %119 = "llvm.insertvalue"(%118, %70) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32, f32)>
      %120 = "llvm.insertvalue"(%119, %85) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32, f32)>
      %121 = "llvm.insertvalue"(%120, %101) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32, f32)>
      %122 = "llvm.insertvalue"(%121, %117) <{position = array<i64: 3>}> : (!llvm.struct<(f32, f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32, f32)>
      "llvm.return"(%122) : (!llvm.struct<(f32, f32, f32, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_shuffle", visibility_ = 0 : i64}> ({
    ^bb0(%arg7: !llvm.ptr):
      %51 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_shuffle, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.struct<(f32, f32, f32, f32)>
      "llvm.store"(%51, %arg7) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f32, f32, f32)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f32, f32)> ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_shuffle_promote", visibility_ = 0 : i64}> ({
      %28 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %29 = "llvm.bitcast"(%28) : (f32) -> i32
      %30 = "llvm.mlir.constant"() <{value = 4127 : i32}> : () -> i32
      %31 = "rocdl.ds_swizzle"(%29, %30) : (i32, i32) -> i32
      %32 = "llvm.bitcast"(%31) : (i32) -> f32
      %33 = "llvm.bitcast"(%28) : (f32) -> i32
      %34 = "rocdl.permlane16.swap"(%33, %33) <{boundControl = false, fi = false}> : (i32, i32) -> !llvm.struct<(i32, i32)>
      %35 = "llvm.extractvalue"(%34) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>) -> i32
      %36 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>) -> i32
      %37 = "llvm.icmp"(%35, %33) <{predicate = 0 : i64}> : (i32, i32) -> i1
      %38 = "llvm.select"(%37, %36, %35) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %39 = "llvm.bitcast"(%38) : (i32) -> f32
      %40 = "llvm.bitcast"(%28) : (f32) -> i32
      %41 = "rocdl.permlane32.swap"(%40, %40) <{boundControl = false, fi = false}> : (i32, i32) -> !llvm.struct<(i32, i32)>
      %42 = "llvm.extractvalue"(%41) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>) -> i32
      %43 = "llvm.extractvalue"(%41) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>) -> i32
      %44 = "llvm.icmp"(%42, %40) <{predicate = 0 : i64}> : (i32, i32) -> i1
      %45 = "llvm.select"(%44, %43, %42) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %46 = "llvm.bitcast"(%45) : (i32) -> f32
      %47 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f32, f32)>
      %48 = "llvm.insertvalue"(%47, %32) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32)>
      %49 = "llvm.insertvalue"(%48, %39) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32)>
      %50 = "llvm.insertvalue"(%49, %46) <{position = array<i64: 2>}> : (!llvm.struct<(f32, f32, f32)>, f32) -> !llvm.struct<(f32, f32, f32)>
      "llvm.return"(%50) : (!llvm.struct<(f32, f32, f32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_shuffle_promote", visibility_ = 0 : i64}> ({
    ^bb0(%arg6: !llvm.ptr):
      %27 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_shuffle_promote, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.struct<(f32, f32, f32)>
      "llvm.store"(%27, %arg6) <{ordering = 0 : i64}> : (!llvm.struct<(f32, f32, f32)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<4xf16> (vector<4xf16>, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "gpu_shuffle_vec", visibility_ = 0 : i64}> ({
    ^bb0(%arg3: vector<4xf16>, %arg4: i32, %arg5: i32):
      %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %2 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %3 = "rocdl.mbcnt.lo"(%2, %1) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %4 = "rocdl.mbcnt.hi"(%2, %3) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %5 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %6 = "llvm.sub"(%5, %arg5) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %7 = "llvm.add"(%4, %arg5) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %8 = "llvm.and"(%7, %6) : (i32, i32) -> i32
      %9 = "llvm.xor"(%4, %arg4) : (i32, i32) -> i32
      %10 = "llvm.icmp"(%9, %8) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %11 = "llvm.select"(%10, %9, %4) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %12 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %13 = "llvm.shl"(%11, %12) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %14 = "llvm.bitcast"(%arg3) : (vector<4xf16>) -> vector<2xi32>
      %15 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %16 = "llvm.extractelement"(%14, %15) : (vector<2xi32>, i32) -> i32
      %17 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %18 = "llvm.extractelement"(%14, %17) : (vector<2xi32>, i32) -> i32
      %19 = "rocdl.ds_bpermute"(%13, %16) : (i32, i32) -> i32
      %20 = "rocdl.ds_bpermute"(%13, %18) : (i32, i32) -> i32
      %21 = "llvm.mlir.poison"() : () -> vector<2xi32>
      %22 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %23 = "llvm.insertelement"(%21, %19, %22) : (vector<2xi32>, i32, i32) -> vector<2xi32>
      %24 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %25 = "llvm.insertelement"(%23, %20, %24) : (vector<2xi32>, i32, i32) -> vector<2xi32>
      %26 = "llvm.bitcast"(%25) : (vector<2xi32>) -> vector<4xf16>
      "llvm.return"(%26) : (vector<4xf16>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<4xf16> (vector<4xf16>, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_shuffle_vec", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: vector<4xf16>, %arg1: i32, %arg2: i32):
      %0 = "llvm.call"(%arg0, %arg1, %arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_shuffle_vec, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (vector<4xf16>, i32, i32) -> vector<4xf16>
      "llvm.return"(%0) : (vector<4xf16>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_custom_data_layout"}> ({
  ^bb0:
  }) {llvm.data_layout = "e"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_dim_int_max_upper_bound", visibility_ = 0 : i64}> ({
      %1 = "rocdl.workgroup.dim.x"() <{range = #llvm.constant_range<i32, 1, 2147483647>}> : () -> i32
      "llvm.return"(%1) : (i32) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_dim_int_max_upper_bound", visibility_ = 0 : i64}> ({
      %0 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_dim_int_max_upper_bound, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> i32
      "llvm.return"(%0) : (i32) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(i32, i32)> (i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "broadcast", visibility_ = 0 : i64}> ({
    ^bb0(%arg10: i32, %arg11: i32):
      %25 = "rocdl.readfirstlane"(%arg10) : (i32) -> i32
      %26 = "rocdl.readlane"(%arg10, %arg11) : (i32, i32) -> i32
      %27 = "llvm.mlir.poison"() : () -> !llvm.struct<(i32, i32)>
      %28 = "llvm.insertvalue"(%27, %25) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>, i32) -> !llvm.struct<(i32, i32)>
      %29 = "llvm.insertvalue"(%28, %26) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>, i32) -> !llvm.struct<(i32, i32)>
      "llvm.return"(%29) : (!llvm.struct<(i32, i32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_broadcast", visibility_ = 0 : i64}> ({
    ^bb0(%arg7: !llvm.ptr, %arg8: i32, %arg9: i32):
      %24 = "llvm.call"(%arg8, %arg9) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @broadcast, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i32, i32) -> !llvm.struct<(i32, i32)>
      "llvm.store"(%24, %arg7) <{ordering = 0 : i64}> : (!llvm.struct<(i32, i32)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(i8, i8)> (i8, i32)>, linkage = #llvm.linkage<external>, sym_name = "broadcast_i8", visibility_ = 0 : i64}> ({
    ^bb0(%arg5: i8, %arg6: i32):
      %15 = "llvm.zext"(%arg5) : (i8) -> i32
      %16 = "rocdl.readfirstlane"(%15) : (i32) -> i32
      %17 = "llvm.trunc"(%16) <{overflowFlags = 0 : i32}> : (i32) -> i8
      %18 = "llvm.zext"(%arg5) : (i8) -> i32
      %19 = "rocdl.readlane"(%18, %arg6) : (i32, i32) -> i32
      %20 = "llvm.trunc"(%19) <{overflowFlags = 0 : i32}> : (i32) -> i8
      %21 = "llvm.mlir.poison"() : () -> !llvm.struct<(i8, i8)>
      %22 = "llvm.insertvalue"(%21, %17) <{position = array<i64: 0>}> : (!llvm.struct<(i8, i8)>, i8) -> !llvm.struct<(i8, i8)>
      %23 = "llvm.insertvalue"(%22, %20) <{position = array<i64: 1>}> : (!llvm.struct<(i8, i8)>, i8) -> !llvm.struct<(i8, i8)>
      "llvm.return"(%23) : (!llvm.struct<(i8, i8)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, i8, i32)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_broadcast_i8", visibility_ = 0 : i64}> ({
    ^bb0(%arg2: !llvm.ptr, %arg3: i8, %arg4: i32):
      %14 = "llvm.call"(%arg3, %arg4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @broadcast_i8, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i8, i32) -> !llvm.struct<(i8, i8)>
      "llvm.store"(%14, %arg2) <{ordering = 0 : i64}> : (!llvm.struct<(i8, i8)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<4xi16> (vector<4xi16>)>, linkage = #llvm.linkage<external>, sym_name = "broadcast_4xi16", visibility_ = 0 : i64}> ({
    ^bb0(%arg1: vector<4xi16>):
      %1 = "llvm.bitcast"(%arg1) : (vector<4xi16>) -> vector<2xi32>
      %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %3 = "llvm.extractelement"(%1, %2) : (vector<2xi32>, i32) -> i32
      %4 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %5 = "llvm.extractelement"(%1, %4) : (vector<2xi32>, i32) -> i32
      %6 = "rocdl.readfirstlane"(%3) : (i32) -> i32
      %7 = "rocdl.readfirstlane"(%5) : (i32) -> i32
      %8 = "llvm.mlir.poison"() : () -> vector<2xi32>
      %9 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %10 = "llvm.insertelement"(%8, %6, %9) : (vector<2xi32>, i32, i32) -> vector<2xi32>
      %11 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %12 = "llvm.insertelement"(%10, %7, %11) : (vector<2xi32>, i32, i32) -> vector<2xi32>
      %13 = "llvm.bitcast"(%12) : (vector<2xi32>) -> vector<4xi16>
      "llvm.return"(%13) : (vector<4xi16>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<4xi16> (vector<4xi16>)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_broadcast_4xi16", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: vector<4xi16>):
      %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @broadcast_4xi16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (vector<4xi16>) -> vector<4xi16>
      "llvm.return"(%0) : (vector<4xi16>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

