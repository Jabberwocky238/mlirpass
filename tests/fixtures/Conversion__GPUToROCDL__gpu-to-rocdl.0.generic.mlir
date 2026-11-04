"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)> ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_index_ops", visibility_ = 0 : i64}> ({
      %1 = "rocdl.workitem.id.x"() : () -> i32
      %2 = "llvm.sext"(%1) : (i32) -> i64
      %3 = "rocdl.workitem.id.y"() : () -> i32
      %4 = "llvm.sext"(%3) : (i32) -> i64
      %5 = "rocdl.workitem.id.z"() : () -> i32
      %6 = "llvm.sext"(%5) : (i32) -> i64
      %7 = "rocdl.workgroup.dim.x"() : () -> i32
      %8 = "llvm.sext"(%7) : (i32) -> i64
      %9 = "rocdl.workgroup.dim.y"() : () -> i32
      %10 = "llvm.sext"(%9) : (i32) -> i64
      %11 = "rocdl.workgroup.dim.z"() : () -> i32
      %12 = "llvm.sext"(%11) : (i32) -> i64
      %13 = "rocdl.workgroup.id.x"() : () -> i32
      %14 = "llvm.sext"(%13) : (i32) -> i64
      %15 = "rocdl.workgroup.id.y"() : () -> i32
      %16 = "llvm.sext"(%15) : (i32) -> i64
      %17 = "rocdl.workgroup.id.z"() : () -> i32
      %18 = "llvm.sext"(%17) : (i32) -> i64
      %19 = "rocdl.grid.dim.x"() : () -> i32
      %20 = "llvm.sext"(%19) : (i32) -> i64
      %21 = "rocdl.grid.dim.y"() : () -> i32
      %22 = "llvm.sext"(%21) : (i32) -> i64
      %23 = "rocdl.grid.dim.z"() : () -> i32
      %24 = "llvm.sext"(%23) : (i32) -> i64
      %25 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %26 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %27 = "rocdl.mbcnt.lo"(%26, %25) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %28 = "rocdl.mbcnt.hi"(%26, %27) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %29 = "llvm.sext"(%28) : (i32) -> i64
      %30 = "rocdl.wavefrontsize"() : () -> i32
      %31 = "llvm.sext"(%30) : (i32) -> i64
      %32 = "rocdl.wavefrontsize"() <{range = #llvm.constant_range<i32, 64, 65>}> : () -> i32
      %33 = "llvm.sext"(%32) : (i32) -> i64
      %34 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %35 = "llvm.insertvalue"(%34, %2) <{position = array<i64: 0>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %36 = "llvm.insertvalue"(%35, %4) <{position = array<i64: 1>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %37 = "llvm.insertvalue"(%36, %6) <{position = array<i64: 2>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %38 = "llvm.insertvalue"(%37, %8) <{position = array<i64: 3>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %39 = "llvm.insertvalue"(%38, %10) <{position = array<i64: 4>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %40 = "llvm.insertvalue"(%39, %12) <{position = array<i64: 5>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %41 = "llvm.insertvalue"(%40, %14) <{position = array<i64: 6>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %42 = "llvm.insertvalue"(%41, %16) <{position = array<i64: 7>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %43 = "llvm.insertvalue"(%42, %18) <{position = array<i64: 8>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %44 = "llvm.insertvalue"(%43, %20) <{position = array<i64: 9>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %45 = "llvm.insertvalue"(%44, %22) <{position = array<i64: 10>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %46 = "llvm.insertvalue"(%45, %24) <{position = array<i64: 11>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %47 = "llvm.insertvalue"(%46, %29) <{position = array<i64: 12>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %48 = "llvm.insertvalue"(%47, %31) <{position = array<i64: 13>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      %49 = "llvm.insertvalue"(%48, %33) <{position = array<i64: 14>}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      "llvm.return"(%49) : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_index_ops", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr):
      %0 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_index_ops, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, i64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_index_ops_range", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64):
      %0 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
      %1 = "llvm.insertvalue"(%0, %arg0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %2 = "llvm.insertvalue"(%1, %arg1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
      %3 = "llvm.insertvalue"(%2, %arg2) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
      %4 = "rocdl.workitem.id.x"() <{range = #llvm.constant_range<i32, 0, 8>}> : () -> i32
      %5 = "llvm.sext"(%4) : (i32) -> i64
      %6 = "rocdl.workitem.id.y"() <{range = #llvm.constant_range<i32, 0, 12>}> : () -> i32
      %7 = "llvm.sext"(%6) : (i32) -> i64
      %8 = "rocdl.workitem.id.z"() <{range = #llvm.constant_range<i32, 0, 16>}> : () -> i32
      %9 = "llvm.sext"(%8) : (i32) -> i64
      %10 = "rocdl.workgroup.id.x"() <{range = #llvm.constant_range<i32, 0, 20>}> : () -> i32
      %11 = "llvm.sext"(%10) : (i32) -> i64
      %12 = "rocdl.workgroup.id.y"() <{range = #llvm.constant_range<i32, 0, 24>}> : () -> i32
      %13 = "llvm.sext"(%12) : (i32) -> i64
      %14 = "rocdl.workgroup.id.z"() <{range = #llvm.constant_range<i32, 0, 28>}> : () -> i32
      %15 = "llvm.sext"(%14) : (i32) -> i64
      %16 = "llvm.add"(%5, %7) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %17 = "llvm.add"(%16, %9) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %18 = "llvm.add"(%17, %11) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %19 = "llvm.add"(%18, %13) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %20 = "llvm.add"(%19, %15) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %21 = "llvm.trunc"(%20) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %22 = "llvm.extractvalue"(%3) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
      "llvm.store"(%21, %22) <{ordering = 0 : i64}> : (i32, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {gpu.kernel, gpu.known_block_size = array<i32: 8, 12, 16>, gpu.known_grid_size = array<i32: 20, 24, 28>, rocdl.flat_work_group_size = "1536,1536", rocdl.kernel, rocdl.reqd_work_group_size = array<i32: 8, 12, 16>} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64)>, linkage = #llvm.linkage<external>, sym_name = "gpu_index_comp", visibility_ = 0 : i64}> ({
    ^bb0(%arg1: i64):
      %1 = "llvm.add"(%arg1, %arg1) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      "llvm.return"(%1) : (i64) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_index_comp", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: i64):
      %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_index_comp, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> i64
      "llvm.return"(%0) : (i64) -> ()
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
      %2 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
      %3 = "llvm.extractelement"(%arg1, %2) : (vector<4xf32>, i64) -> f32
      %4 = "llvm.call"(%3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %5 = "llvm.insertelement"(%1, %4, %2) : (vector<4xf32>, f32, i64) -> vector<4xf32>
      %6 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
      %7 = "llvm.extractelement"(%arg1, %6) : (vector<4xf32>, i64) -> f32
      %8 = "llvm.call"(%7) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %9 = "llvm.insertelement"(%5, %8, %6) : (vector<4xf32>, f32, i64) -> vector<4xf32>
      %10 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
      %11 = "llvm.extractelement"(%arg1, %10) : (vector<4xf32>, i64) -> f32
      %12 = "llvm.call"(%11) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %13 = "llvm.insertelement"(%9, %12, %10) : (vector<4xf32>, f32, i64) -> vector<4xf32>
      %14 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
      %15 = "llvm.extractelement"(%arg1, %14) : (vector<4xf32>, i64) -> f32
      %16 = "llvm.call"(%15) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %17 = "llvm.insertelement"(%13, %16, %14) : (vector<4xf32>, f32, i64) -> vector<4xf32>
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
      %1 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
      %2 = "llvm.extractelement"(%arg0, %1) : (vector<4xf32>, i64) -> f32
      %3 = "llvm.call"(%2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %4 = "llvm.insertelement"(%0, %3, %1) : (vector<4xf32>, f32, i64) -> vector<4xf32>
      %5 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
      %6 = "llvm.extractelement"(%arg0, %5) : (vector<4xf32>, i64) -> f32
      %7 = "llvm.call"(%6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %8 = "llvm.insertelement"(%4, %7, %5) : (vector<4xf32>, f32, i64) -> vector<4xf32>
      %9 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
      %10 = "llvm.extractelement"(%arg0, %9) : (vector<4xf32>, i64) -> f32
      %11 = "llvm.call"(%10) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %12 = "llvm.insertelement"(%8, %11, %9) : (vector<4xf32>, f32, i64) -> vector<4xf32>
      %13 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
      %14 = "llvm.extractelement"(%arg0, %13) : (vector<4xf32>, i64) -> f32
      %15 = "llvm.call"(%14) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ocml_sin_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
      %16 = "llvm.insertelement"(%12, %15, %13) : (vector<4xf32>, f32, i64) -> vector<4xf32>
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
      %2 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %3 = "llvm.insertvalue"(%2, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %4 = "llvm.insertvalue"(%3, %1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %5 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %6 = "llvm.insertvalue"(%4, %5) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %7 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
      %8 = "llvm.insertvalue"(%6, %7) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %9 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %11 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
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
      %22 = "llvm.sext"(%21) : (i32) -> i64
      %23 = "llvm.trunc"(%22) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %24 = "rocdl.workgroup.dim.y"() : () -> i32
      %25 = "llvm.sext"(%24) : (i32) -> i64
      %26 = "llvm.trunc"(%25) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %27 = "rocdl.workgroup.dim.z"() : () -> i32
      %28 = "llvm.sext"(%27) : (i32) -> i64
      %29 = "llvm.trunc"(%28) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %30 = "rocdl.workitem.id.x"() : () -> i32
      %31 = "llvm.sext"(%30) : (i32) -> i64
      %32 = "llvm.trunc"(%31) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %33 = "rocdl.workitem.id.y"() : () -> i32
      %34 = "llvm.sext"(%33) : (i32) -> i64
      %35 = "llvm.trunc"(%34) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %36 = "rocdl.workitem.id.z"() : () -> i32
      %37 = "llvm.sext"(%36) : (i32) -> i64
      %38 = "llvm.trunc"(%37) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %39 = "llvm.mul"(%38, %26) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %40 = "llvm.add"(%39, %35) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %41 = "llvm.mul"(%40, %23) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %42 = "llvm.mul"(%23, %26) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %43 = "llvm.add"(%41, %32) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %44 = "llvm.mul"(%42, %29) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %45 = "llvm.and"(%43, %19) : (i32, i32) -> i32
      %46 = "llvm.icmp"(%45, %18) <{predicate = 0 : i64}> : (i32, i32) -> i1
      %47 = "llvm.sub"(%43, %45) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %48 = "llvm.sub"(%44, %47) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %49 = "llvm.icmp"(%48, %17) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%49)[^bb1, ^bb17] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %50 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %51 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %52 = "rocdl.mbcnt.lo"(%51, %50) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %53 = "rocdl.mbcnt.hi"(%51, %52) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %54 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %55 = "llvm.sub"(%54, %48) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %56 = "llvm.add"(%53, %48) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %57 = "llvm.and"(%56, %55) : (i32, i32) -> i32
      %58 = "llvm.xor"(%53, %16) : (i32, i32) -> i32
      %59 = "llvm.icmp"(%58, %57) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %60 = "llvm.select"(%59, %58, %53) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %61 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %62 = "llvm.shl"(%60, %61) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %63 = "llvm.bitcast"(%20) : (f32) -> i32
      %64 = "rocdl.ds_bpermute"(%62, %63) : (i32, i32) -> i32
      %65 = "llvm.bitcast"(%64) : (i32) -> f32
      "llvm.cond_br"(%59)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      %66 = "llvm.fadd"(%65, %20) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%66)[^bb4] : (f32) -> ()
    ^bb3:  // pred: ^bb1
      "llvm.br"(%20)[^bb4] : (f32) -> ()
    ^bb4(%67: f32):  // 2 preds: ^bb2, ^bb3
      %68 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %69 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %70 = "rocdl.mbcnt.lo"(%69, %68) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %71 = "rocdl.mbcnt.hi"(%69, %70) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %72 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %73 = "llvm.sub"(%72, %48) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %74 = "llvm.add"(%71, %48) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %75 = "llvm.and"(%74, %73) : (i32, i32) -> i32
      %76 = "llvm.xor"(%71, %15) : (i32, i32) -> i32
      %77 = "llvm.icmp"(%76, %75) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %78 = "llvm.select"(%77, %76, %71) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %79 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %80 = "llvm.shl"(%78, %79) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %81 = "llvm.bitcast"(%67) : (f32) -> i32
      %82 = "rocdl.ds_bpermute"(%80, %81) : (i32, i32) -> i32
      %83 = "llvm.bitcast"(%82) : (i32) -> f32
      "llvm.cond_br"(%77)[^bb5, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb5:  // pred: ^bb4
      %84 = "llvm.fadd"(%67, %83) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%84)[^bb7] : (f32) -> ()
    ^bb6:  // pred: ^bb4
      "llvm.br"(%67)[^bb7] : (f32) -> ()
    ^bb7(%85: f32):  // 2 preds: ^bb5, ^bb6
      %86 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %87 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %88 = "rocdl.mbcnt.lo"(%87, %86) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %89 = "rocdl.mbcnt.hi"(%87, %88) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %90 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %91 = "llvm.sub"(%90, %48) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %92 = "llvm.add"(%89, %48) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %93 = "llvm.and"(%92, %91) : (i32, i32) -> i32
      %94 = "llvm.xor"(%89, %14) : (i32, i32) -> i32
      %95 = "llvm.icmp"(%94, %93) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %96 = "llvm.select"(%95, %94, %89) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %97 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %98 = "llvm.shl"(%96, %97) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %99 = "llvm.bitcast"(%85) : (f32) -> i32
      %100 = "rocdl.ds_bpermute"(%98, %99) : (i32, i32) -> i32
      %101 = "llvm.bitcast"(%100) : (i32) -> f32
      "llvm.cond_br"(%95)[^bb8, ^bb9] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb8:  // pred: ^bb7
      %102 = "llvm.fadd"(%85, %101) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%102)[^bb10] : (f32) -> ()
    ^bb9:  // pred: ^bb7
      "llvm.br"(%85)[^bb10] : (f32) -> ()
    ^bb10(%103: f32):  // 2 preds: ^bb8, ^bb9
      %104 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %105 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %106 = "rocdl.mbcnt.lo"(%105, %104) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %107 = "rocdl.mbcnt.hi"(%105, %106) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %108 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %109 = "llvm.sub"(%108, %48) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %110 = "llvm.add"(%107, %48) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %111 = "llvm.and"(%110, %109) : (i32, i32) -> i32
      %112 = "llvm.xor"(%107, %13) : (i32, i32) -> i32
      %113 = "llvm.icmp"(%112, %111) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %114 = "llvm.select"(%113, %112, %107) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %115 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %116 = "llvm.shl"(%114, %115) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %117 = "llvm.bitcast"(%103) : (f32) -> i32
      %118 = "rocdl.ds_bpermute"(%116, %117) : (i32, i32) -> i32
      %119 = "llvm.bitcast"(%118) : (i32) -> f32
      "llvm.cond_br"(%113)[^bb11, ^bb12] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb11:  // pred: ^bb10
      %120 = "llvm.fadd"(%103, %119) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%120)[^bb13] : (f32) -> ()
    ^bb12:  // pred: ^bb10
      "llvm.br"(%103)[^bb13] : (f32) -> ()
    ^bb13(%121: f32):  // 2 preds: ^bb11, ^bb12
      %122 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %123 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %124 = "rocdl.mbcnt.lo"(%123, %122) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %125 = "rocdl.mbcnt.hi"(%123, %124) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %126 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %127 = "llvm.sub"(%126, %48) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %128 = "llvm.add"(%125, %48) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %129 = "llvm.and"(%128, %127) : (i32, i32) -> i32
      %130 = "llvm.xor"(%125, %12) : (i32, i32) -> i32
      %131 = "llvm.icmp"(%130, %129) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %132 = "llvm.select"(%131, %130, %125) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %133 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %134 = "llvm.shl"(%132, %133) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %135 = "llvm.bitcast"(%121) : (f32) -> i32
      %136 = "rocdl.ds_bpermute"(%134, %135) : (i32, i32) -> i32
      %137 = "llvm.bitcast"(%136) : (i32) -> f32
      "llvm.cond_br"(%131)[^bb14, ^bb15] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb14:  // pred: ^bb13
      %138 = "llvm.fadd"(%121, %137) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%138)[^bb16] : (f32) -> ()
    ^bb15:  // pred: ^bb13
      "llvm.br"(%121)[^bb16] : (f32) -> ()
    ^bb16(%139: f32):  // 2 preds: ^bb14, ^bb15
      "llvm.br"(%139)[^bb18] : (f32) -> ()
    ^bb17:  // pred: ^bb0
      %140 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %141 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %142 = "rocdl.mbcnt.lo"(%141, %140) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %143 = "rocdl.mbcnt.hi"(%141, %142) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %144 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %145 = "llvm.sub"(%144, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %146 = "llvm.add"(%143, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %147 = "llvm.and"(%146, %145) : (i32, i32) -> i32
      %148 = "llvm.xor"(%143, %16) : (i32, i32) -> i32
      %149 = "llvm.icmp"(%148, %147) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %150 = "llvm.select"(%149, %148, %143) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %151 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %152 = "llvm.shl"(%150, %151) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %153 = "llvm.bitcast"(%20) : (f32) -> i32
      %154 = "rocdl.ds_bpermute"(%152, %153) : (i32, i32) -> i32
      %155 = "llvm.bitcast"(%154) : (i32) -> f32
      %156 = "llvm.fadd"(%155, %20) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %157 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %158 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %159 = "rocdl.mbcnt.lo"(%158, %157) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %160 = "rocdl.mbcnt.hi"(%158, %159) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %161 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %162 = "llvm.sub"(%161, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %163 = "llvm.add"(%160, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %164 = "llvm.and"(%163, %162) : (i32, i32) -> i32
      %165 = "llvm.xor"(%160, %15) : (i32, i32) -> i32
      %166 = "llvm.icmp"(%165, %164) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %167 = "llvm.select"(%166, %165, %160) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %168 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %169 = "llvm.shl"(%167, %168) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %170 = "llvm.bitcast"(%156) : (f32) -> i32
      %171 = "rocdl.ds_bpermute"(%169, %170) : (i32, i32) -> i32
      %172 = "llvm.bitcast"(%171) : (i32) -> f32
      %173 = "llvm.fadd"(%156, %172) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %174 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %175 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %176 = "rocdl.mbcnt.lo"(%175, %174) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %177 = "rocdl.mbcnt.hi"(%175, %176) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %178 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %179 = "llvm.sub"(%178, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %180 = "llvm.add"(%177, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %181 = "llvm.and"(%180, %179) : (i32, i32) -> i32
      %182 = "llvm.xor"(%177, %14) : (i32, i32) -> i32
      %183 = "llvm.icmp"(%182, %181) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %184 = "llvm.select"(%183, %182, %177) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %185 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %186 = "llvm.shl"(%184, %185) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %187 = "llvm.bitcast"(%173) : (f32) -> i32
      %188 = "rocdl.ds_bpermute"(%186, %187) : (i32, i32) -> i32
      %189 = "llvm.bitcast"(%188) : (i32) -> f32
      %190 = "llvm.fadd"(%173, %189) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %191 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %192 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %193 = "rocdl.mbcnt.lo"(%192, %191) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %194 = "rocdl.mbcnt.hi"(%192, %193) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %195 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %196 = "llvm.sub"(%195, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %197 = "llvm.add"(%194, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %198 = "llvm.and"(%197, %196) : (i32, i32) -> i32
      %199 = "llvm.xor"(%194, %13) : (i32, i32) -> i32
      %200 = "llvm.icmp"(%199, %198) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %201 = "llvm.select"(%200, %199, %194) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %202 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %203 = "llvm.shl"(%201, %202) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %204 = "llvm.bitcast"(%190) : (f32) -> i32
      %205 = "rocdl.ds_bpermute"(%203, %204) : (i32, i32) -> i32
      %206 = "llvm.bitcast"(%205) : (i32) -> f32
      %207 = "llvm.fadd"(%190, %206) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %208 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %209 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %210 = "rocdl.mbcnt.lo"(%209, %208) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %211 = "rocdl.mbcnt.hi"(%209, %210) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %212 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %213 = "llvm.sub"(%212, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %214 = "llvm.add"(%211, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %215 = "llvm.and"(%214, %213) : (i32, i32) -> i32
      %216 = "llvm.xor"(%211, %12) : (i32, i32) -> i32
      %217 = "llvm.icmp"(%216, %215) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %218 = "llvm.select"(%217, %216, %211) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %219 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %220 = "llvm.shl"(%218, %219) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %221 = "llvm.bitcast"(%207) : (f32) -> i32
      %222 = "rocdl.ds_bpermute"(%220, %221) : (i32, i32) -> i32
      %223 = "llvm.bitcast"(%222) : (i32) -> f32
      %224 = "llvm.fadd"(%207, %223) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%224)[^bb18] : (f32) -> ()
    ^bb18(%225: f32):  // 2 preds: ^bb16, ^bb17
      "llvm.cond_br"(%46)[^bb19, ^bb20] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb19:  // pred: ^bb18
      %226 = "llvm.sdiv"(%43, %17) : (i32, i32) -> i32
      %227 = "llvm.sext"(%226) : (i32) -> i64
      %228 = "llvm.extractvalue"(%10) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %229 = "llvm.getelementptr"(%228, %227) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      "llvm.store"(%225, %229) <{ordering = 0 : i64}> : (f32, !llvm.ptr<3>) -> ()
      "llvm.br"()[^bb21] : () -> ()
    ^bb20:  // pred: ^bb18
      "llvm.br"()[^bb21] : () -> ()
    ^bb21:  // 2 preds: ^bb19, ^bb20
      "rocdl.barrier"() : () -> ()
      %230 = "llvm.add"(%44, %19) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %231 = "llvm.sdiv"(%230, %17) : (i32, i32) -> i32
      %232 = "llvm.icmp"(%43, %231) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%232)[^bb22, ^bb41] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb22:  // pred: ^bb21
      %233 = "llvm.sext"(%43) : (i32) -> i64
      %234 = "llvm.extractvalue"(%10) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %235 = "llvm.getelementptr"(%234, %233) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      %236 = "llvm.load"(%235) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> f32
      %237 = "llvm.icmp"(%231, %17) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%237)[^bb23, ^bb39] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb23:  // pred: ^bb22
      %238 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %239 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %240 = "rocdl.mbcnt.lo"(%239, %238) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %241 = "rocdl.mbcnt.hi"(%239, %240) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %242 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %243 = "llvm.sub"(%242, %231) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %244 = "llvm.add"(%241, %231) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %245 = "llvm.and"(%244, %243) : (i32, i32) -> i32
      %246 = "llvm.xor"(%241, %16) : (i32, i32) -> i32
      %247 = "llvm.icmp"(%246, %245) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %248 = "llvm.select"(%247, %246, %241) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %249 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %250 = "llvm.shl"(%248, %249) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %251 = "llvm.bitcast"(%236) : (f32) -> i32
      %252 = "rocdl.ds_bpermute"(%250, %251) : (i32, i32) -> i32
      %253 = "llvm.bitcast"(%252) : (i32) -> f32
      "llvm.cond_br"(%247)[^bb24, ^bb25] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb24:  // pred: ^bb23
      %254 = "llvm.fadd"(%236, %253) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%254)[^bb26] : (f32) -> ()
    ^bb25:  // pred: ^bb23
      "llvm.br"(%236)[^bb26] : (f32) -> ()
    ^bb26(%255: f32):  // 2 preds: ^bb24, ^bb25
      %256 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %257 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %258 = "rocdl.mbcnt.lo"(%257, %256) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %259 = "rocdl.mbcnt.hi"(%257, %258) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %260 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %261 = "llvm.sub"(%260, %231) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %262 = "llvm.add"(%259, %231) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %263 = "llvm.and"(%262, %261) : (i32, i32) -> i32
      %264 = "llvm.xor"(%259, %15) : (i32, i32) -> i32
      %265 = "llvm.icmp"(%264, %263) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %266 = "llvm.select"(%265, %264, %259) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %267 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %268 = "llvm.shl"(%266, %267) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %269 = "llvm.bitcast"(%255) : (f32) -> i32
      %270 = "rocdl.ds_bpermute"(%268, %269) : (i32, i32) -> i32
      %271 = "llvm.bitcast"(%270) : (i32) -> f32
      "llvm.cond_br"(%265)[^bb27, ^bb28] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb27:  // pred: ^bb26
      %272 = "llvm.fadd"(%255, %271) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%272)[^bb29] : (f32) -> ()
    ^bb28:  // pred: ^bb26
      "llvm.br"(%255)[^bb29] : (f32) -> ()
    ^bb29(%273: f32):  // 2 preds: ^bb27, ^bb28
      %274 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %275 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %276 = "rocdl.mbcnt.lo"(%275, %274) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %277 = "rocdl.mbcnt.hi"(%275, %276) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %278 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %279 = "llvm.sub"(%278, %231) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %280 = "llvm.add"(%277, %231) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %281 = "llvm.and"(%280, %279) : (i32, i32) -> i32
      %282 = "llvm.xor"(%277, %14) : (i32, i32) -> i32
      %283 = "llvm.icmp"(%282, %281) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %284 = "llvm.select"(%283, %282, %277) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %285 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %286 = "llvm.shl"(%284, %285) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %287 = "llvm.bitcast"(%273) : (f32) -> i32
      %288 = "rocdl.ds_bpermute"(%286, %287) : (i32, i32) -> i32
      %289 = "llvm.bitcast"(%288) : (i32) -> f32
      "llvm.cond_br"(%283)[^bb30, ^bb31] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb30:  // pred: ^bb29
      %290 = "llvm.fadd"(%273, %289) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%290)[^bb32] : (f32) -> ()
    ^bb31:  // pred: ^bb29
      "llvm.br"(%273)[^bb32] : (f32) -> ()
    ^bb32(%291: f32):  // 2 preds: ^bb30, ^bb31
      %292 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %293 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %294 = "rocdl.mbcnt.lo"(%293, %292) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %295 = "rocdl.mbcnt.hi"(%293, %294) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %296 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %297 = "llvm.sub"(%296, %231) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %298 = "llvm.add"(%295, %231) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %299 = "llvm.and"(%298, %297) : (i32, i32) -> i32
      %300 = "llvm.xor"(%295, %13) : (i32, i32) -> i32
      %301 = "llvm.icmp"(%300, %299) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %302 = "llvm.select"(%301, %300, %295) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %303 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %304 = "llvm.shl"(%302, %303) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %305 = "llvm.bitcast"(%291) : (f32) -> i32
      %306 = "rocdl.ds_bpermute"(%304, %305) : (i32, i32) -> i32
      %307 = "llvm.bitcast"(%306) : (i32) -> f32
      "llvm.cond_br"(%301)[^bb33, ^bb34] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb33:  // pred: ^bb32
      %308 = "llvm.fadd"(%291, %307) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%308)[^bb35] : (f32) -> ()
    ^bb34:  // pred: ^bb32
      "llvm.br"(%291)[^bb35] : (f32) -> ()
    ^bb35(%309: f32):  // 2 preds: ^bb33, ^bb34
      %310 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %311 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %312 = "rocdl.mbcnt.lo"(%311, %310) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %313 = "rocdl.mbcnt.hi"(%311, %312) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %314 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %315 = "llvm.sub"(%314, %231) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %316 = "llvm.add"(%313, %231) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %317 = "llvm.and"(%316, %315) : (i32, i32) -> i32
      %318 = "llvm.xor"(%313, %12) : (i32, i32) -> i32
      %319 = "llvm.icmp"(%318, %317) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %320 = "llvm.select"(%319, %318, %313) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %321 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %322 = "llvm.shl"(%320, %321) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %323 = "llvm.bitcast"(%309) : (f32) -> i32
      %324 = "rocdl.ds_bpermute"(%322, %323) : (i32, i32) -> i32
      %325 = "llvm.bitcast"(%324) : (i32) -> f32
      "llvm.cond_br"(%319)[^bb36, ^bb37] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb36:  // pred: ^bb35
      %326 = "llvm.fadd"(%309, %325) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%326)[^bb38] : (f32) -> ()
    ^bb37:  // pred: ^bb35
      "llvm.br"(%309)[^bb38] : (f32) -> ()
    ^bb38(%327: f32):  // 2 preds: ^bb36, ^bb37
      "llvm.br"(%327)[^bb40] : (f32) -> ()
    ^bb39:  // pred: ^bb22
      %328 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %329 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %330 = "rocdl.mbcnt.lo"(%329, %328) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %331 = "rocdl.mbcnt.hi"(%329, %330) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %332 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %333 = "llvm.sub"(%332, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %334 = "llvm.add"(%331, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %335 = "llvm.and"(%334, %333) : (i32, i32) -> i32
      %336 = "llvm.xor"(%331, %16) : (i32, i32) -> i32
      %337 = "llvm.icmp"(%336, %335) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %338 = "llvm.select"(%337, %336, %331) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %339 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %340 = "llvm.shl"(%338, %339) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %341 = "llvm.bitcast"(%236) : (f32) -> i32
      %342 = "rocdl.ds_bpermute"(%340, %341) : (i32, i32) -> i32
      %343 = "llvm.bitcast"(%342) : (i32) -> f32
      %344 = "llvm.fadd"(%236, %343) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %345 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %346 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %347 = "rocdl.mbcnt.lo"(%346, %345) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %348 = "rocdl.mbcnt.hi"(%346, %347) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %349 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %350 = "llvm.sub"(%349, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %351 = "llvm.add"(%348, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %352 = "llvm.and"(%351, %350) : (i32, i32) -> i32
      %353 = "llvm.xor"(%348, %15) : (i32, i32) -> i32
      %354 = "llvm.icmp"(%353, %352) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %355 = "llvm.select"(%354, %353, %348) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %356 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %357 = "llvm.shl"(%355, %356) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %358 = "llvm.bitcast"(%344) : (f32) -> i32
      %359 = "rocdl.ds_bpermute"(%357, %358) : (i32, i32) -> i32
      %360 = "llvm.bitcast"(%359) : (i32) -> f32
      %361 = "llvm.fadd"(%344, %360) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %362 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %363 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %364 = "rocdl.mbcnt.lo"(%363, %362) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %365 = "rocdl.mbcnt.hi"(%363, %364) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %366 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %367 = "llvm.sub"(%366, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %368 = "llvm.add"(%365, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %369 = "llvm.and"(%368, %367) : (i32, i32) -> i32
      %370 = "llvm.xor"(%365, %14) : (i32, i32) -> i32
      %371 = "llvm.icmp"(%370, %369) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %372 = "llvm.select"(%371, %370, %365) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %373 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %374 = "llvm.shl"(%372, %373) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %375 = "llvm.bitcast"(%361) : (f32) -> i32
      %376 = "rocdl.ds_bpermute"(%374, %375) : (i32, i32) -> i32
      %377 = "llvm.bitcast"(%376) : (i32) -> f32
      %378 = "llvm.fadd"(%361, %377) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %379 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %380 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %381 = "rocdl.mbcnt.lo"(%380, %379) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %382 = "rocdl.mbcnt.hi"(%380, %381) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %383 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %384 = "llvm.sub"(%383, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %385 = "llvm.add"(%382, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %386 = "llvm.and"(%385, %384) : (i32, i32) -> i32
      %387 = "llvm.xor"(%382, %13) : (i32, i32) -> i32
      %388 = "llvm.icmp"(%387, %386) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %389 = "llvm.select"(%388, %387, %382) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %390 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %391 = "llvm.shl"(%389, %390) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %392 = "llvm.bitcast"(%378) : (f32) -> i32
      %393 = "rocdl.ds_bpermute"(%391, %392) : (i32, i32) -> i32
      %394 = "llvm.bitcast"(%393) : (i32) -> f32
      %395 = "llvm.fadd"(%378, %394) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %396 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %397 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %398 = "rocdl.mbcnt.lo"(%397, %396) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %399 = "rocdl.mbcnt.hi"(%397, %398) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %400 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %401 = "llvm.sub"(%400, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %402 = "llvm.add"(%399, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %403 = "llvm.and"(%402, %401) : (i32, i32) -> i32
      %404 = "llvm.xor"(%399, %12) : (i32, i32) -> i32
      %405 = "llvm.icmp"(%404, %403) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %406 = "llvm.select"(%405, %404, %399) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %407 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %408 = "llvm.shl"(%406, %407) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %409 = "llvm.bitcast"(%395) : (f32) -> i32
      %410 = "rocdl.ds_bpermute"(%408, %409) : (i32, i32) -> i32
      %411 = "llvm.bitcast"(%410) : (i32) -> f32
      %412 = "llvm.fadd"(%395, %411) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%412)[^bb40] : (f32) -> ()
    ^bb40(%413: f32):  // 2 preds: ^bb38, ^bb39
      %414 = "llvm.extractvalue"(%10) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %415 = "llvm.getelementptr"(%414, %11) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      "llvm.store"(%413, %415) <{ordering = 0 : i64}> : (f32, !llvm.ptr<3>) -> ()
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
      %2 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %3 = "llvm.insertvalue"(%2, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %4 = "llvm.insertvalue"(%3, %1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %5 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %6 = "llvm.insertvalue"(%4, %5) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %7 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
      %8 = "llvm.insertvalue"(%6, %7) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %9 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %11 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %12 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
      %13 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
      %14 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
      %15 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %16 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %17 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %18 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
      %19 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %20 = "rocdl.workgroup.dim.x"() : () -> i32
      %21 = "llvm.sext"(%20) : (i32) -> i64
      %22 = "llvm.trunc"(%21) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %23 = "rocdl.workgroup.dim.y"() : () -> i32
      %24 = "llvm.sext"(%23) : (i32) -> i64
      %25 = "llvm.trunc"(%24) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %26 = "rocdl.workgroup.dim.z"() : () -> i32
      %27 = "llvm.sext"(%26) : (i32) -> i64
      %28 = "llvm.trunc"(%27) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %29 = "rocdl.workitem.id.x"() : () -> i32
      %30 = "llvm.sext"(%29) : (i32) -> i64
      %31 = "llvm.trunc"(%30) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %32 = "rocdl.workitem.id.y"() : () -> i32
      %33 = "llvm.sext"(%32) : (i32) -> i64
      %34 = "llvm.trunc"(%33) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %35 = "rocdl.workitem.id.z"() : () -> i32
      %36 = "llvm.sext"(%35) : (i32) -> i64
      %37 = "llvm.trunc"(%36) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %38 = "llvm.mul"(%37, %25) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %39 = "llvm.add"(%38, %34) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %40 = "llvm.mul"(%39, %22) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %41 = "llvm.mul"(%22, %25) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %42 = "llvm.add"(%40, %31) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %43 = "llvm.mul"(%41, %28) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %44 = "llvm.and"(%42, %18) : (i32, i32) -> i32
      %45 = "llvm.icmp"(%44, %17) <{predicate = 0 : i64}> : (i32, i32) -> i1
      %46 = "llvm.sub"(%42, %44) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %47 = "llvm.sub"(%43, %46) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %48 = "llvm.icmp"(%47, %16) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%48)[^bb1, ^bb22] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %49 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %50 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %51 = "rocdl.mbcnt.lo"(%50, %49) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %52 = "rocdl.mbcnt.hi"(%50, %51) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %53 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %54 = "llvm.sub"(%53, %47) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %55 = "llvm.add"(%52, %47) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %56 = "llvm.and"(%55, %54) : (i32, i32) -> i32
      %57 = "llvm.xor"(%52, %19) : (i32, i32) -> i32
      %58 = "llvm.icmp"(%57, %56) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %59 = "llvm.select"(%58, %57, %52) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %60 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %61 = "llvm.shl"(%59, %60) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %62 = "rocdl.ds_bpermute"(%61, %19) : (i32, i32) -> i32
      "llvm.cond_br"(%58, %19)[^bb2, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb2:  // pred: ^bb1
      "llvm.br"()[^bb3] : () -> ()
    ^bb3:  // pred: ^bb2
      %63 = "llvm.xor"(%62, %19) : (i32, i32) -> i32
      "llvm.br"(%63)[^bb4] : (i32) -> ()
    ^bb4(%64: i32):  // 2 preds: ^bb1, ^bb3
      "llvm.br"()[^bb5] : () -> ()
    ^bb5:  // pred: ^bb4
      %65 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %66 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %67 = "rocdl.mbcnt.lo"(%66, %65) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %68 = "rocdl.mbcnt.hi"(%66, %67) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %69 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %70 = "llvm.sub"(%69, %47) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %71 = "llvm.add"(%68, %47) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %72 = "llvm.and"(%71, %70) : (i32, i32) -> i32
      %73 = "llvm.xor"(%68, %15) : (i32, i32) -> i32
      %74 = "llvm.icmp"(%73, %72) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %75 = "llvm.select"(%74, %73, %68) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %76 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %77 = "llvm.shl"(%75, %76) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %78 = "rocdl.ds_bpermute"(%77, %64) : (i32, i32) -> i32
      "llvm.cond_br"(%74, %64)[^bb6, ^bb8] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb6:  // pred: ^bb5
      "llvm.br"()[^bb7] : () -> ()
    ^bb7:  // pred: ^bb6
      %79 = "llvm.xor"(%64, %78) : (i32, i32) -> i32
      "llvm.br"(%79)[^bb8] : (i32) -> ()
    ^bb8(%80: i32):  // 2 preds: ^bb5, ^bb7
      "llvm.br"()[^bb9] : () -> ()
    ^bb9:  // pred: ^bb8
      %81 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %82 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %83 = "rocdl.mbcnt.lo"(%82, %81) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %84 = "rocdl.mbcnt.hi"(%82, %83) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %85 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %86 = "llvm.sub"(%85, %47) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %87 = "llvm.add"(%84, %47) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %88 = "llvm.and"(%87, %86) : (i32, i32) -> i32
      %89 = "llvm.xor"(%84, %14) : (i32, i32) -> i32
      %90 = "llvm.icmp"(%89, %88) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %91 = "llvm.select"(%90, %89, %84) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %92 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %93 = "llvm.shl"(%91, %92) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %94 = "rocdl.ds_bpermute"(%93, %80) : (i32, i32) -> i32
      "llvm.cond_br"(%90, %80)[^bb10, ^bb12] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb10:  // pred: ^bb9
      "llvm.br"()[^bb11] : () -> ()
    ^bb11:  // pred: ^bb10
      %95 = "llvm.xor"(%80, %94) : (i32, i32) -> i32
      "llvm.br"(%95)[^bb12] : (i32) -> ()
    ^bb12(%96: i32):  // 2 preds: ^bb9, ^bb11
      "llvm.br"()[^bb13] : () -> ()
    ^bb13:  // pred: ^bb12
      %97 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %98 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %99 = "rocdl.mbcnt.lo"(%98, %97) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %100 = "rocdl.mbcnt.hi"(%98, %99) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %101 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %102 = "llvm.sub"(%101, %47) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %103 = "llvm.add"(%100, %47) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %104 = "llvm.and"(%103, %102) : (i32, i32) -> i32
      %105 = "llvm.xor"(%100, %13) : (i32, i32) -> i32
      %106 = "llvm.icmp"(%105, %104) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %107 = "llvm.select"(%106, %105, %100) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %108 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %109 = "llvm.shl"(%107, %108) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %110 = "rocdl.ds_bpermute"(%109, %96) : (i32, i32) -> i32
      "llvm.cond_br"(%106, %96)[^bb14, ^bb16] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb14:  // pred: ^bb13
      "llvm.br"()[^bb15] : () -> ()
    ^bb15:  // pred: ^bb14
      %111 = "llvm.xor"(%96, %110) : (i32, i32) -> i32
      "llvm.br"(%111)[^bb16] : (i32) -> ()
    ^bb16(%112: i32):  // 2 preds: ^bb13, ^bb15
      "llvm.br"()[^bb17] : () -> ()
    ^bb17:  // pred: ^bb16
      %113 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %114 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %115 = "rocdl.mbcnt.lo"(%114, %113) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %116 = "rocdl.mbcnt.hi"(%114, %115) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %117 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %118 = "llvm.sub"(%117, %47) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %119 = "llvm.add"(%116, %47) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %120 = "llvm.and"(%119, %118) : (i32, i32) -> i32
      %121 = "llvm.xor"(%116, %12) : (i32, i32) -> i32
      %122 = "llvm.icmp"(%121, %120) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %123 = "llvm.select"(%122, %121, %116) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %124 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %125 = "llvm.shl"(%123, %124) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %126 = "rocdl.ds_bpermute"(%125, %112) : (i32, i32) -> i32
      "llvm.cond_br"(%122, %112)[^bb18, ^bb20] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb18:  // pred: ^bb17
      "llvm.br"()[^bb19] : () -> ()
    ^bb19:  // pred: ^bb18
      %127 = "llvm.xor"(%112, %126) : (i32, i32) -> i32
      "llvm.br"(%127)[^bb20] : (i32) -> ()
    ^bb20(%128: i32):  // 2 preds: ^bb17, ^bb19
      "llvm.br"(%128)[^bb21] : (i32) -> ()
    ^bb21(%129: i32):  // 2 preds: ^bb20, ^bb31
      "llvm.br"()[^bb32] : () -> ()
    ^bb22:  // pred: ^bb0
      %130 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %131 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %132 = "rocdl.mbcnt.lo"(%131, %130) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %133 = "rocdl.mbcnt.hi"(%131, %132) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %134 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %135 = "llvm.sub"(%134, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %136 = "llvm.add"(%133, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %137 = "llvm.and"(%136, %135) : (i32, i32) -> i32
      %138 = "llvm.xor"(%133, %19) : (i32, i32) -> i32
      %139 = "llvm.icmp"(%138, %137) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %140 = "llvm.select"(%139, %138, %133) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %141 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %142 = "llvm.shl"(%140, %141) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %143 = "rocdl.ds_bpermute"(%142, %19) : (i32, i32) -> i32
      "llvm.br"()[^bb23] : () -> ()
    ^bb23:  // pred: ^bb22
      %144 = "llvm.xor"(%143, %19) : (i32, i32) -> i32
      "llvm.br"()[^bb24] : () -> ()
    ^bb24:  // pred: ^bb23
      %145 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %146 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %147 = "rocdl.mbcnt.lo"(%146, %145) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %148 = "rocdl.mbcnt.hi"(%146, %147) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %149 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %150 = "llvm.sub"(%149, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %151 = "llvm.add"(%148, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %152 = "llvm.and"(%151, %150) : (i32, i32) -> i32
      %153 = "llvm.xor"(%148, %15) : (i32, i32) -> i32
      %154 = "llvm.icmp"(%153, %152) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %155 = "llvm.select"(%154, %153, %148) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %156 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %157 = "llvm.shl"(%155, %156) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %158 = "rocdl.ds_bpermute"(%157, %144) : (i32, i32) -> i32
      "llvm.br"()[^bb25] : () -> ()
    ^bb25:  // pred: ^bb24
      %159 = "llvm.xor"(%144, %158) : (i32, i32) -> i32
      "llvm.br"()[^bb26] : () -> ()
    ^bb26:  // pred: ^bb25
      %160 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %161 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %162 = "rocdl.mbcnt.lo"(%161, %160) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %163 = "rocdl.mbcnt.hi"(%161, %162) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %164 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %165 = "llvm.sub"(%164, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %166 = "llvm.add"(%163, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %167 = "llvm.and"(%166, %165) : (i32, i32) -> i32
      %168 = "llvm.xor"(%163, %14) : (i32, i32) -> i32
      %169 = "llvm.icmp"(%168, %167) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %170 = "llvm.select"(%169, %168, %163) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %171 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %172 = "llvm.shl"(%170, %171) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %173 = "rocdl.ds_bpermute"(%172, %159) : (i32, i32) -> i32
      "llvm.br"()[^bb27] : () -> ()
    ^bb27:  // pred: ^bb26
      %174 = "llvm.xor"(%159, %173) : (i32, i32) -> i32
      "llvm.br"()[^bb28] : () -> ()
    ^bb28:  // pred: ^bb27
      %175 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %176 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %177 = "rocdl.mbcnt.lo"(%176, %175) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %178 = "rocdl.mbcnt.hi"(%176, %177) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %179 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %180 = "llvm.sub"(%179, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %181 = "llvm.add"(%178, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %182 = "llvm.and"(%181, %180) : (i32, i32) -> i32
      %183 = "llvm.xor"(%178, %13) : (i32, i32) -> i32
      %184 = "llvm.icmp"(%183, %182) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %185 = "llvm.select"(%184, %183, %178) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %186 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %187 = "llvm.shl"(%185, %186) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %188 = "rocdl.ds_bpermute"(%187, %174) : (i32, i32) -> i32
      "llvm.br"()[^bb29] : () -> ()
    ^bb29:  // pred: ^bb28
      %189 = "llvm.xor"(%174, %188) : (i32, i32) -> i32
      "llvm.br"()[^bb30] : () -> ()
    ^bb30:  // pred: ^bb29
      %190 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %191 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %192 = "rocdl.mbcnt.lo"(%191, %190) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %193 = "rocdl.mbcnt.hi"(%191, %192) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %194 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %195 = "llvm.sub"(%194, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %196 = "llvm.add"(%193, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %197 = "llvm.and"(%196, %195) : (i32, i32) -> i32
      %198 = "llvm.xor"(%193, %12) : (i32, i32) -> i32
      %199 = "llvm.icmp"(%198, %197) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %200 = "llvm.select"(%199, %198, %193) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %201 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %202 = "llvm.shl"(%200, %201) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %203 = "rocdl.ds_bpermute"(%202, %189) : (i32, i32) -> i32
      "llvm.br"()[^bb31] : () -> ()
    ^bb31:  // pred: ^bb30
      %204 = "llvm.xor"(%189, %203) : (i32, i32) -> i32
      "llvm.br"(%204)[^bb21] : (i32) -> ()
    ^bb32:  // pred: ^bb21
      "llvm.cond_br"(%45)[^bb33, ^bb34] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb33:  // pred: ^bb32
      %205 = "llvm.sdiv"(%42, %16) : (i32, i32) -> i32
      %206 = "llvm.sext"(%205) : (i32) -> i64
      %207 = "llvm.extractvalue"(%10) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %208 = "llvm.getelementptr"(%207, %206) <{elem_type = i32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      "llvm.store"(%129, %208) <{ordering = 0 : i64}> : (i32, !llvm.ptr<3>) -> ()
      "llvm.br"()[^bb35] : () -> ()
    ^bb34:  // pred: ^bb32
      "llvm.br"()[^bb35] : () -> ()
    ^bb35:  // 2 preds: ^bb33, ^bb34
      "rocdl.barrier"() : () -> ()
      %209 = "llvm.add"(%43, %18) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %210 = "llvm.sdiv"(%209, %16) : (i32, i32) -> i32
      %211 = "llvm.icmp"(%42, %210) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%211)[^bb36, ^bb69] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb36:  // pred: ^bb35
      %212 = "llvm.sext"(%42) : (i32) -> i64
      %213 = "llvm.extractvalue"(%10) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %214 = "llvm.getelementptr"(%213, %212) <{elem_type = i32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      %215 = "llvm.load"(%214) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> i32
      %216 = "llvm.icmp"(%210, %16) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%216)[^bb37, ^bb58] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb37:  // pred: ^bb36
      %217 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %218 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %219 = "rocdl.mbcnt.lo"(%218, %217) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %220 = "rocdl.mbcnt.hi"(%218, %219) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %221 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %222 = "llvm.sub"(%221, %210) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %223 = "llvm.add"(%220, %210) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %224 = "llvm.and"(%223, %222) : (i32, i32) -> i32
      %225 = "llvm.xor"(%220, %19) : (i32, i32) -> i32
      %226 = "llvm.icmp"(%225, %224) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %227 = "llvm.select"(%226, %225, %220) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %228 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %229 = "llvm.shl"(%227, %228) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %230 = "rocdl.ds_bpermute"(%229, %215) : (i32, i32) -> i32
      "llvm.cond_br"(%226, %215)[^bb38, ^bb40] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb38:  // pred: ^bb37
      "llvm.br"()[^bb39] : () -> ()
    ^bb39:  // pred: ^bb38
      %231 = "llvm.xor"(%215, %230) : (i32, i32) -> i32
      "llvm.br"(%231)[^bb40] : (i32) -> ()
    ^bb40(%232: i32):  // 2 preds: ^bb37, ^bb39
      "llvm.br"()[^bb41] : () -> ()
    ^bb41:  // pred: ^bb40
      %233 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %234 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %235 = "rocdl.mbcnt.lo"(%234, %233) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %236 = "rocdl.mbcnt.hi"(%234, %235) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %237 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %238 = "llvm.sub"(%237, %210) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %239 = "llvm.add"(%236, %210) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %240 = "llvm.and"(%239, %238) : (i32, i32) -> i32
      %241 = "llvm.xor"(%236, %15) : (i32, i32) -> i32
      %242 = "llvm.icmp"(%241, %240) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %243 = "llvm.select"(%242, %241, %236) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %244 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %245 = "llvm.shl"(%243, %244) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %246 = "rocdl.ds_bpermute"(%245, %232) : (i32, i32) -> i32
      "llvm.cond_br"(%242, %232)[^bb42, ^bb44] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb42:  // pred: ^bb41
      "llvm.br"()[^bb43] : () -> ()
    ^bb43:  // pred: ^bb42
      %247 = "llvm.xor"(%232, %246) : (i32, i32) -> i32
      "llvm.br"(%247)[^bb44] : (i32) -> ()
    ^bb44(%248: i32):  // 2 preds: ^bb41, ^bb43
      "llvm.br"()[^bb45] : () -> ()
    ^bb45:  // pred: ^bb44
      %249 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %250 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %251 = "rocdl.mbcnt.lo"(%250, %249) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %252 = "rocdl.mbcnt.hi"(%250, %251) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %253 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %254 = "llvm.sub"(%253, %210) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %255 = "llvm.add"(%252, %210) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %256 = "llvm.and"(%255, %254) : (i32, i32) -> i32
      %257 = "llvm.xor"(%252, %14) : (i32, i32) -> i32
      %258 = "llvm.icmp"(%257, %256) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %259 = "llvm.select"(%258, %257, %252) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %260 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %261 = "llvm.shl"(%259, %260) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %262 = "rocdl.ds_bpermute"(%261, %248) : (i32, i32) -> i32
      "llvm.cond_br"(%258, %248)[^bb46, ^bb48] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb46:  // pred: ^bb45
      "llvm.br"()[^bb47] : () -> ()
    ^bb47:  // pred: ^bb46
      %263 = "llvm.xor"(%248, %262) : (i32, i32) -> i32
      "llvm.br"(%263)[^bb48] : (i32) -> ()
    ^bb48(%264: i32):  // 2 preds: ^bb45, ^bb47
      "llvm.br"()[^bb49] : () -> ()
    ^bb49:  // pred: ^bb48
      %265 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %266 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %267 = "rocdl.mbcnt.lo"(%266, %265) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %268 = "rocdl.mbcnt.hi"(%266, %267) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %269 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %270 = "llvm.sub"(%269, %210) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %271 = "llvm.add"(%268, %210) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %272 = "llvm.and"(%271, %270) : (i32, i32) -> i32
      %273 = "llvm.xor"(%268, %13) : (i32, i32) -> i32
      %274 = "llvm.icmp"(%273, %272) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %275 = "llvm.select"(%274, %273, %268) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %276 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %277 = "llvm.shl"(%275, %276) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %278 = "rocdl.ds_bpermute"(%277, %264) : (i32, i32) -> i32
      "llvm.cond_br"(%274, %264)[^bb50, ^bb52] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb50:  // pred: ^bb49
      "llvm.br"()[^bb51] : () -> ()
    ^bb51:  // pred: ^bb50
      %279 = "llvm.xor"(%264, %278) : (i32, i32) -> i32
      "llvm.br"(%279)[^bb52] : (i32) -> ()
    ^bb52(%280: i32):  // 2 preds: ^bb49, ^bb51
      "llvm.br"()[^bb53] : () -> ()
    ^bb53:  // pred: ^bb52
      %281 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %282 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %283 = "rocdl.mbcnt.lo"(%282, %281) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %284 = "rocdl.mbcnt.hi"(%282, %283) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %285 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %286 = "llvm.sub"(%285, %210) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %287 = "llvm.add"(%284, %210) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %288 = "llvm.and"(%287, %286) : (i32, i32) -> i32
      %289 = "llvm.xor"(%284, %12) : (i32, i32) -> i32
      %290 = "llvm.icmp"(%289, %288) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %291 = "llvm.select"(%290, %289, %284) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %292 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %293 = "llvm.shl"(%291, %292) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %294 = "rocdl.ds_bpermute"(%293, %280) : (i32, i32) -> i32
      "llvm.cond_br"(%290, %280)[^bb54, ^bb56] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb54:  // pred: ^bb53
      "llvm.br"()[^bb55] : () -> ()
    ^bb55:  // pred: ^bb54
      %295 = "llvm.xor"(%280, %294) : (i32, i32) -> i32
      "llvm.br"(%295)[^bb56] : (i32) -> ()
    ^bb56(%296: i32):  // 2 preds: ^bb53, ^bb55
      "llvm.br"(%296)[^bb57] : (i32) -> ()
    ^bb57(%297: i32):  // 2 preds: ^bb56, ^bb67
      "llvm.br"()[^bb68] : () -> ()
    ^bb58:  // pred: ^bb36
      %298 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %299 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %300 = "rocdl.mbcnt.lo"(%299, %298) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %301 = "rocdl.mbcnt.hi"(%299, %300) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %302 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %303 = "llvm.sub"(%302, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %304 = "llvm.add"(%301, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %305 = "llvm.and"(%304, %303) : (i32, i32) -> i32
      %306 = "llvm.xor"(%301, %19) : (i32, i32) -> i32
      %307 = "llvm.icmp"(%306, %305) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %308 = "llvm.select"(%307, %306, %301) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %309 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %310 = "llvm.shl"(%308, %309) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %311 = "rocdl.ds_bpermute"(%310, %215) : (i32, i32) -> i32
      "llvm.br"()[^bb59] : () -> ()
    ^bb59:  // pred: ^bb58
      %312 = "llvm.xor"(%215, %311) : (i32, i32) -> i32
      "llvm.br"()[^bb60] : () -> ()
    ^bb60:  // pred: ^bb59
      %313 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %314 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %315 = "rocdl.mbcnt.lo"(%314, %313) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %316 = "rocdl.mbcnt.hi"(%314, %315) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %317 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %318 = "llvm.sub"(%317, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %319 = "llvm.add"(%316, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %320 = "llvm.and"(%319, %318) : (i32, i32) -> i32
      %321 = "llvm.xor"(%316, %15) : (i32, i32) -> i32
      %322 = "llvm.icmp"(%321, %320) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %323 = "llvm.select"(%322, %321, %316) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %324 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %325 = "llvm.shl"(%323, %324) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %326 = "rocdl.ds_bpermute"(%325, %312) : (i32, i32) -> i32
      "llvm.br"()[^bb61] : () -> ()
    ^bb61:  // pred: ^bb60
      %327 = "llvm.xor"(%312, %326) : (i32, i32) -> i32
      "llvm.br"()[^bb62] : () -> ()
    ^bb62:  // pred: ^bb61
      %328 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %329 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %330 = "rocdl.mbcnt.lo"(%329, %328) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %331 = "rocdl.mbcnt.hi"(%329, %330) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %332 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %333 = "llvm.sub"(%332, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %334 = "llvm.add"(%331, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %335 = "llvm.and"(%334, %333) : (i32, i32) -> i32
      %336 = "llvm.xor"(%331, %14) : (i32, i32) -> i32
      %337 = "llvm.icmp"(%336, %335) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %338 = "llvm.select"(%337, %336, %331) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %339 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %340 = "llvm.shl"(%338, %339) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %341 = "rocdl.ds_bpermute"(%340, %327) : (i32, i32) -> i32
      "llvm.br"()[^bb63] : () -> ()
    ^bb63:  // pred: ^bb62
      %342 = "llvm.xor"(%327, %341) : (i32, i32) -> i32
      "llvm.br"()[^bb64] : () -> ()
    ^bb64:  // pred: ^bb63
      %343 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %344 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %345 = "rocdl.mbcnt.lo"(%344, %343) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %346 = "rocdl.mbcnt.hi"(%344, %345) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %347 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %348 = "llvm.sub"(%347, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %349 = "llvm.add"(%346, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %350 = "llvm.and"(%349, %348) : (i32, i32) -> i32
      %351 = "llvm.xor"(%346, %13) : (i32, i32) -> i32
      %352 = "llvm.icmp"(%351, %350) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %353 = "llvm.select"(%352, %351, %346) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %354 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %355 = "llvm.shl"(%353, %354) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %356 = "rocdl.ds_bpermute"(%355, %342) : (i32, i32) -> i32
      "llvm.br"()[^bb65] : () -> ()
    ^bb65:  // pred: ^bb64
      %357 = "llvm.xor"(%342, %356) : (i32, i32) -> i32
      "llvm.br"()[^bb66] : () -> ()
    ^bb66:  // pred: ^bb65
      %358 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %359 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %360 = "rocdl.mbcnt.lo"(%359, %358) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %361 = "rocdl.mbcnt.hi"(%359, %360) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %362 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %363 = "llvm.sub"(%362, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %364 = "llvm.add"(%361, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %365 = "llvm.and"(%364, %363) : (i32, i32) -> i32
      %366 = "llvm.xor"(%361, %12) : (i32, i32) -> i32
      %367 = "llvm.icmp"(%366, %365) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %368 = "llvm.select"(%367, %366, %361) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %369 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %370 = "llvm.shl"(%368, %369) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %371 = "rocdl.ds_bpermute"(%370, %357) : (i32, i32) -> i32
      "llvm.br"()[^bb67] : () -> ()
    ^bb67:  // pred: ^bb66
      %372 = "llvm.xor"(%357, %371) : (i32, i32) -> i32
      "llvm.br"(%372)[^bb57] : (i32) -> ()
    ^bb68:  // pred: ^bb57
      %373 = "llvm.extractvalue"(%10) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %374 = "llvm.getelementptr"(%373, %11) <{elem_type = i32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      "llvm.store"(%297, %374) <{ordering = 0 : i64}> : (i32, !llvm.ptr<3>) -> ()
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
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_dim_int_max_upper_bound", visibility_ = 0 : i64}> ({
      %1 = "rocdl.workgroup.dim.x"() <{range = #llvm.constant_range<i32, 1, 2147483647>}> : () -> i32
      %2 = "llvm.sext"(%1) : (i32) -> i64
      "llvm.return"(%2) : (i64) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 ()>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_dim_int_max_upper_bound", visibility_ = 0 : i64}> ({
      %0 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_dim_int_max_upper_bound, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> i64
      "llvm.return"(%0) : (i64) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(i64, i64)> (i64, i32)>, linkage = #llvm.linkage<external>, sym_name = "broadcast", visibility_ = 0 : i64}> ({
    ^bb0(%arg10: i64, %arg11: i32):
      %25 = "rocdl.readfirstlane"(%arg10) : (i64) -> i64
      %26 = "rocdl.readlane"(%arg10, %arg11) : (i64, i32) -> i64
      %27 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, i64)>
      %28 = "llvm.insertvalue"(%27, %25) <{position = array<i64: 0>}> : (!llvm.struct<(i64, i64)>, i64) -> !llvm.struct<(i64, i64)>
      %29 = "llvm.insertvalue"(%28, %26) <{position = array<i64: 1>}> : (!llvm.struct<(i64, i64)>, i64) -> !llvm.struct<(i64, i64)>
      "llvm.return"(%29) : (!llvm.struct<(i64, i64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, i64, i32)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_broadcast", visibility_ = 0 : i64}> ({
    ^bb0(%arg7: !llvm.ptr, %arg8: i64, %arg9: i32):
      %24 = "llvm.call"(%arg8, %arg9) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @broadcast, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i32) -> !llvm.struct<(i64, i64)>
      "llvm.store"(%24, %arg7) <{ordering = 0 : i64}> : (!llvm.struct<(i64, i64)>, !llvm.ptr) -> ()
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

