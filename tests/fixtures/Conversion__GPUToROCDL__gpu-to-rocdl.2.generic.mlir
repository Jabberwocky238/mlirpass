"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i32)>, linkage = #llvm.linkage<external>, sym_name = "__ockl_get_num_groups", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i32)>, linkage = #llvm.linkage<external>, sym_name = "__ockl_get_local_size", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_index_ops", visibility_ = 0 : i64}> ({
      %1 = "rocdl.workitem.id.x"() : () -> i32
      %2 = "rocdl.workitem.id.y"() : () -> i32
      %3 = "rocdl.workitem.id.z"() : () -> i32
      %4 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ockl_get_local_size, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, res_attrs = [{llvm.range = #llvm.constant_range<i64, 1, 1025>}]}> : (i32) -> i64
      %6 = "llvm.trunc"(%5) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %7 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %8 = "llvm.call"(%7) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ockl_get_local_size, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, res_attrs = [{llvm.range = #llvm.constant_range<i64, 1, 1025>}]}> : (i32) -> i64
      %9 = "llvm.trunc"(%8) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %10 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %11 = "llvm.call"(%10) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ockl_get_local_size, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, res_attrs = [{llvm.range = #llvm.constant_range<i64, 1, 1025>}]}> : (i32) -> i64
      %12 = "llvm.trunc"(%11) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %13 = "rocdl.workgroup.id.x"() : () -> i32
      %14 = "rocdl.workgroup.id.y"() : () -> i32
      %15 = "rocdl.workgroup.id.z"() : () -> i32
      %16 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %17 = "llvm.call"(%16) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ockl_get_num_groups, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i32) -> i64
      %18 = "llvm.trunc"(%17) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %19 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %20 = "llvm.call"(%19) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ockl_get_num_groups, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i32) -> i64
      %21 = "llvm.trunc"(%20) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %22 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %23 = "llvm.call"(%22) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ockl_get_num_groups, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i32) -> i64
      %24 = "llvm.trunc"(%23) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %25 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %26 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %27 = "rocdl.mbcnt.lo"(%26, %25) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %28 = "rocdl.mbcnt.hi"(%26, %27) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %29 = "rocdl.wavefrontsize"() : () -> i32
      %30 = "rocdl.wavefrontsize"() <{range = #llvm.constant_range<i32, 64, 65>}> : () -> i32
      %31 = "llvm.mlir.poison"() : () -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %32 = "llvm.insertvalue"(%31, %1) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %33 = "llvm.insertvalue"(%32, %2) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %34 = "llvm.insertvalue"(%33, %3) <{position = array<i64: 2>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %35 = "llvm.insertvalue"(%34, %6) <{position = array<i64: 3>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %36 = "llvm.insertvalue"(%35, %9) <{position = array<i64: 4>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %37 = "llvm.insertvalue"(%36, %12) <{position = array<i64: 5>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %38 = "llvm.insertvalue"(%37, %13) <{position = array<i64: 6>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %39 = "llvm.insertvalue"(%38, %14) <{position = array<i64: 7>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %40 = "llvm.insertvalue"(%39, %15) <{position = array<i64: 8>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %41 = "llvm.insertvalue"(%40, %18) <{position = array<i64: 9>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %42 = "llvm.insertvalue"(%41, %21) <{position = array<i64: 10>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %43 = "llvm.insertvalue"(%42, %24) <{position = array<i64: 11>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %44 = "llvm.insertvalue"(%43, %28) <{position = array<i64: 12>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %45 = "llvm.insertvalue"(%44, %29) <{position = array<i64: 13>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %46 = "llvm.insertvalue"(%45, %30) <{position = array<i64: 14>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      "llvm.return"(%46) : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>) -> ()
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
      %10 = "llvm.mlir.constant"() <{value = 8 : i64}> : () -> i64
      %11 = "llvm.trunc"(%10) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %12 = "llvm.mlir.constant"() <{value = 12 : i64}> : () -> i64
      %13 = "llvm.trunc"(%12) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %14 = "llvm.mlir.constant"() <{value = 16 : i64}> : () -> i64
      %15 = "llvm.trunc"(%14) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %16 = "llvm.mlir.constant"() <{value = 20 : i64}> : () -> i64
      %17 = "llvm.trunc"(%16) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %18 = "llvm.mlir.constant"() <{value = 24 : i64}> : () -> i64
      %19 = "llvm.trunc"(%18) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %20 = "llvm.mlir.constant"() <{value = 28 : i64}> : () -> i64
      %21 = "llvm.trunc"(%20) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %22 = "llvm.add"(%4, %5) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %23 = "llvm.add"(%22, %6) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %24 = "llvm.add"(%23, %7) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %25 = "llvm.add"(%24, %8) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %26 = "llvm.add"(%25, %9) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %27 = "llvm.add"(%26, %11) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %28 = "llvm.add"(%27, %13) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %29 = "llvm.add"(%28, %15) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %30 = "llvm.add"(%29, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %31 = "llvm.add"(%30, %19) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %32 = "llvm.add"(%31, %21) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %33 = "llvm.extractvalue"(%3) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i32)>) -> !llvm.ptr
      "llvm.store"(%32, %33) <{ordering = 0 : i64}> : (i32, !llvm.ptr) -> ()
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
#mmra_tag = #llvm.mmra_tag<"amdgpu-synchronize-as":"local">
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i32)>, linkage = #llvm.linkage<external>, sym_name = "__ockl_get_local_size", visibility_ = 0 : i64}> ({
    }) : () -> ()
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
      %21 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %22 = "llvm.call"(%21) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ockl_get_local_size, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, res_attrs = [{llvm.range = #llvm.constant_range<i64, 1, 1025>}]}> : (i32) -> i64
      %23 = "llvm.trunc"(%22) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %24 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %25 = "llvm.call"(%24) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ockl_get_local_size, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, res_attrs = [{llvm.range = #llvm.constant_range<i64, 1, 1025>}]}> : (i32) -> i64
      %26 = "llvm.trunc"(%25) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %27 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %28 = "llvm.call"(%27) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ockl_get_local_size, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, res_attrs = [{llvm.range = #llvm.constant_range<i64, 1, 1025>}]}> : (i32) -> i64
      %29 = "llvm.trunc"(%28) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %30 = "rocdl.workitem.id.x"() : () -> i32
      %31 = "rocdl.workitem.id.y"() : () -> i32
      %32 = "rocdl.workitem.id.z"() : () -> i32
      %33 = "llvm.mul"(%32, %26) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %34 = "llvm.add"(%33, %31) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %35 = "llvm.mul"(%34, %23) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %36 = "llvm.mul"(%23, %26) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %37 = "llvm.add"(%35, %30) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %38 = "llvm.mul"(%36, %29) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %39 = "llvm.and"(%37, %19) : (i32, i32) -> i32
      %40 = "llvm.icmp"(%39, %18) <{predicate = 0 : i64}> : (i32, i32) -> i1
      %41 = "llvm.sub"(%37, %39) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %42 = "llvm.sub"(%38, %41) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %43 = "llvm.icmp"(%42, %17) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%43)[^bb1, ^bb17] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %44 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %45 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %46 = "rocdl.mbcnt.lo"(%45, %44) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %47 = "rocdl.mbcnt.hi"(%45, %46) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %48 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %49 = "llvm.sub"(%48, %42) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %50 = "llvm.add"(%47, %42) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %51 = "llvm.and"(%50, %49) : (i32, i32) -> i32
      %52 = "llvm.xor"(%47, %16) : (i32, i32) -> i32
      %53 = "llvm.icmp"(%52, %51) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %54 = "llvm.select"(%53, %52, %47) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %55 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %56 = "llvm.shl"(%54, %55) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %57 = "llvm.bitcast"(%20) : (f32) -> i32
      %58 = "rocdl.ds_bpermute"(%56, %57) : (i32, i32) -> i32
      %59 = "llvm.bitcast"(%58) : (i32) -> f32
      "llvm.cond_br"(%53)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      %60 = "llvm.fadd"(%59, %20) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%60)[^bb4] : (f32) -> ()
    ^bb3:  // pred: ^bb1
      "llvm.br"(%20)[^bb4] : (f32) -> ()
    ^bb4(%61: f32):  // 2 preds: ^bb2, ^bb3
      %62 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %63 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %64 = "rocdl.mbcnt.lo"(%63, %62) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %65 = "rocdl.mbcnt.hi"(%63, %64) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %66 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %67 = "llvm.sub"(%66, %42) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %68 = "llvm.add"(%65, %42) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %69 = "llvm.and"(%68, %67) : (i32, i32) -> i32
      %70 = "llvm.xor"(%65, %15) : (i32, i32) -> i32
      %71 = "llvm.icmp"(%70, %69) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %72 = "llvm.select"(%71, %70, %65) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %73 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %74 = "llvm.shl"(%72, %73) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %75 = "llvm.bitcast"(%61) : (f32) -> i32
      %76 = "rocdl.ds_bpermute"(%74, %75) : (i32, i32) -> i32
      %77 = "llvm.bitcast"(%76) : (i32) -> f32
      "llvm.cond_br"(%71)[^bb5, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb5:  // pred: ^bb4
      %78 = "llvm.fadd"(%61, %77) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%78)[^bb7] : (f32) -> ()
    ^bb6:  // pred: ^bb4
      "llvm.br"(%61)[^bb7] : (f32) -> ()
    ^bb7(%79: f32):  // 2 preds: ^bb5, ^bb6
      %80 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %81 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %82 = "rocdl.mbcnt.lo"(%81, %80) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %83 = "rocdl.mbcnt.hi"(%81, %82) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %84 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %85 = "llvm.sub"(%84, %42) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %86 = "llvm.add"(%83, %42) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %87 = "llvm.and"(%86, %85) : (i32, i32) -> i32
      %88 = "llvm.xor"(%83, %14) : (i32, i32) -> i32
      %89 = "llvm.icmp"(%88, %87) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %90 = "llvm.select"(%89, %88, %83) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %91 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %92 = "llvm.shl"(%90, %91) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %93 = "llvm.bitcast"(%79) : (f32) -> i32
      %94 = "rocdl.ds_bpermute"(%92, %93) : (i32, i32) -> i32
      %95 = "llvm.bitcast"(%94) : (i32) -> f32
      "llvm.cond_br"(%89)[^bb8, ^bb9] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb8:  // pred: ^bb7
      %96 = "llvm.fadd"(%79, %95) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%96)[^bb10] : (f32) -> ()
    ^bb9:  // pred: ^bb7
      "llvm.br"(%79)[^bb10] : (f32) -> ()
    ^bb10(%97: f32):  // 2 preds: ^bb8, ^bb9
      %98 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %99 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %100 = "rocdl.mbcnt.lo"(%99, %98) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %101 = "rocdl.mbcnt.hi"(%99, %100) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %102 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %103 = "llvm.sub"(%102, %42) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %104 = "llvm.add"(%101, %42) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %105 = "llvm.and"(%104, %103) : (i32, i32) -> i32
      %106 = "llvm.xor"(%101, %13) : (i32, i32) -> i32
      %107 = "llvm.icmp"(%106, %105) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %108 = "llvm.select"(%107, %106, %101) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %109 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %110 = "llvm.shl"(%108, %109) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %111 = "llvm.bitcast"(%97) : (f32) -> i32
      %112 = "rocdl.ds_bpermute"(%110, %111) : (i32, i32) -> i32
      %113 = "llvm.bitcast"(%112) : (i32) -> f32
      "llvm.cond_br"(%107)[^bb11, ^bb12] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb11:  // pred: ^bb10
      %114 = "llvm.fadd"(%97, %113) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%114)[^bb13] : (f32) -> ()
    ^bb12:  // pred: ^bb10
      "llvm.br"(%97)[^bb13] : (f32) -> ()
    ^bb13(%115: f32):  // 2 preds: ^bb11, ^bb12
      %116 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %117 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %118 = "rocdl.mbcnt.lo"(%117, %116) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %119 = "rocdl.mbcnt.hi"(%117, %118) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %120 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %121 = "llvm.sub"(%120, %42) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %122 = "llvm.add"(%119, %42) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %123 = "llvm.and"(%122, %121) : (i32, i32) -> i32
      %124 = "llvm.xor"(%119, %12) : (i32, i32) -> i32
      %125 = "llvm.icmp"(%124, %123) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %126 = "llvm.select"(%125, %124, %119) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %127 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %128 = "llvm.shl"(%126, %127) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %129 = "llvm.bitcast"(%115) : (f32) -> i32
      %130 = "rocdl.ds_bpermute"(%128, %129) : (i32, i32) -> i32
      %131 = "llvm.bitcast"(%130) : (i32) -> f32
      "llvm.cond_br"(%125)[^bb14, ^bb15] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb14:  // pred: ^bb13
      %132 = "llvm.fadd"(%115, %131) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%132)[^bb16] : (f32) -> ()
    ^bb15:  // pred: ^bb13
      "llvm.br"(%115)[^bb16] : (f32) -> ()
    ^bb16(%133: f32):  // 2 preds: ^bb14, ^bb15
      "llvm.br"(%133)[^bb18] : (f32) -> ()
    ^bb17:  // pred: ^bb0
      %134 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %135 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %136 = "rocdl.mbcnt.lo"(%135, %134) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %137 = "rocdl.mbcnt.hi"(%135, %136) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %138 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %139 = "llvm.sub"(%138, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %140 = "llvm.add"(%137, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %141 = "llvm.and"(%140, %139) : (i32, i32) -> i32
      %142 = "llvm.xor"(%137, %16) : (i32, i32) -> i32
      %143 = "llvm.icmp"(%142, %141) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %144 = "llvm.select"(%143, %142, %137) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %145 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %146 = "llvm.shl"(%144, %145) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %147 = "llvm.bitcast"(%20) : (f32) -> i32
      %148 = "rocdl.ds_bpermute"(%146, %147) : (i32, i32) -> i32
      %149 = "llvm.bitcast"(%148) : (i32) -> f32
      %150 = "llvm.fadd"(%149, %20) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %151 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %152 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %153 = "rocdl.mbcnt.lo"(%152, %151) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %154 = "rocdl.mbcnt.hi"(%152, %153) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %155 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %156 = "llvm.sub"(%155, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %157 = "llvm.add"(%154, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %158 = "llvm.and"(%157, %156) : (i32, i32) -> i32
      %159 = "llvm.xor"(%154, %15) : (i32, i32) -> i32
      %160 = "llvm.icmp"(%159, %158) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %161 = "llvm.select"(%160, %159, %154) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %162 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %163 = "llvm.shl"(%161, %162) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %164 = "llvm.bitcast"(%150) : (f32) -> i32
      %165 = "rocdl.ds_bpermute"(%163, %164) : (i32, i32) -> i32
      %166 = "llvm.bitcast"(%165) : (i32) -> f32
      %167 = "llvm.fadd"(%150, %166) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %168 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %169 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %170 = "rocdl.mbcnt.lo"(%169, %168) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %171 = "rocdl.mbcnt.hi"(%169, %170) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %172 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %173 = "llvm.sub"(%172, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %174 = "llvm.add"(%171, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %175 = "llvm.and"(%174, %173) : (i32, i32) -> i32
      %176 = "llvm.xor"(%171, %14) : (i32, i32) -> i32
      %177 = "llvm.icmp"(%176, %175) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %178 = "llvm.select"(%177, %176, %171) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %179 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %180 = "llvm.shl"(%178, %179) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %181 = "llvm.bitcast"(%167) : (f32) -> i32
      %182 = "rocdl.ds_bpermute"(%180, %181) : (i32, i32) -> i32
      %183 = "llvm.bitcast"(%182) : (i32) -> f32
      %184 = "llvm.fadd"(%167, %183) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %185 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %186 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %187 = "rocdl.mbcnt.lo"(%186, %185) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %188 = "rocdl.mbcnt.hi"(%186, %187) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %189 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %190 = "llvm.sub"(%189, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %191 = "llvm.add"(%188, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %192 = "llvm.and"(%191, %190) : (i32, i32) -> i32
      %193 = "llvm.xor"(%188, %13) : (i32, i32) -> i32
      %194 = "llvm.icmp"(%193, %192) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %195 = "llvm.select"(%194, %193, %188) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %196 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %197 = "llvm.shl"(%195, %196) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %198 = "llvm.bitcast"(%184) : (f32) -> i32
      %199 = "rocdl.ds_bpermute"(%197, %198) : (i32, i32) -> i32
      %200 = "llvm.bitcast"(%199) : (i32) -> f32
      %201 = "llvm.fadd"(%184, %200) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %202 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %203 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %204 = "rocdl.mbcnt.lo"(%203, %202) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %205 = "rocdl.mbcnt.hi"(%203, %204) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %206 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %207 = "llvm.sub"(%206, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %208 = "llvm.add"(%205, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %209 = "llvm.and"(%208, %207) : (i32, i32) -> i32
      %210 = "llvm.xor"(%205, %12) : (i32, i32) -> i32
      %211 = "llvm.icmp"(%210, %209) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %212 = "llvm.select"(%211, %210, %205) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %213 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %214 = "llvm.shl"(%212, %213) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %215 = "llvm.bitcast"(%201) : (f32) -> i32
      %216 = "rocdl.ds_bpermute"(%214, %215) : (i32, i32) -> i32
      %217 = "llvm.bitcast"(%216) : (i32) -> f32
      %218 = "llvm.fadd"(%201, %217) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%218)[^bb18] : (f32) -> ()
    ^bb18(%219: f32):  // 2 preds: ^bb16, ^bb17
      "llvm.cond_br"(%40)[^bb19, ^bb20] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb19:  // pred: ^bb18
      %220 = "llvm.sdiv"(%37, %17) : (i32, i32) -> i32
      %221 = "llvm.extractvalue"(%10) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>) -> !llvm.ptr<3>
      %222 = "llvm.getelementptr"(%221, %220) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>
      "llvm.store"(%219, %222) <{ordering = 0 : i64}> : (f32, !llvm.ptr<3>) -> ()
      "llvm.br"()[^bb21] : () -> ()
    ^bb20:  // pred: ^bb18
      "llvm.br"()[^bb21] : () -> ()
    ^bb21:  // 2 preds: ^bb19, ^bb20
      "llvm.fence"() <{ordering = 5 : i64, syncscope = "workgroup"}> {llvm.mmra = #mmra_tag} : () -> ()
      "rocdl.s.barrier"() : () -> ()
      "llvm.fence"() <{ordering = 4 : i64, syncscope = "workgroup"}> {llvm.mmra = #mmra_tag} : () -> ()
      %223 = "llvm.add"(%38, %19) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %224 = "llvm.sdiv"(%223, %17) : (i32, i32) -> i32
      %225 = "llvm.icmp"(%37, %224) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%225)[^bb22, ^bb41] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb22:  // pred: ^bb21
      %226 = "llvm.extractvalue"(%10) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>) -> !llvm.ptr<3>
      %227 = "llvm.getelementptr"(%226, %37) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>
      %228 = "llvm.load"(%227) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> f32
      %229 = "llvm.icmp"(%224, %17) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%229)[^bb23, ^bb39] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb23:  // pred: ^bb22
      %230 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %231 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %232 = "rocdl.mbcnt.lo"(%231, %230) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %233 = "rocdl.mbcnt.hi"(%231, %232) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %234 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %235 = "llvm.sub"(%234, %224) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %236 = "llvm.add"(%233, %224) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %237 = "llvm.and"(%236, %235) : (i32, i32) -> i32
      %238 = "llvm.xor"(%233, %16) : (i32, i32) -> i32
      %239 = "llvm.icmp"(%238, %237) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %240 = "llvm.select"(%239, %238, %233) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %241 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %242 = "llvm.shl"(%240, %241) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %243 = "llvm.bitcast"(%228) : (f32) -> i32
      %244 = "rocdl.ds_bpermute"(%242, %243) : (i32, i32) -> i32
      %245 = "llvm.bitcast"(%244) : (i32) -> f32
      "llvm.cond_br"(%239)[^bb24, ^bb25] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb24:  // pred: ^bb23
      %246 = "llvm.fadd"(%228, %245) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%246)[^bb26] : (f32) -> ()
    ^bb25:  // pred: ^bb23
      "llvm.br"(%228)[^bb26] : (f32) -> ()
    ^bb26(%247: f32):  // 2 preds: ^bb24, ^bb25
      %248 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %249 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %250 = "rocdl.mbcnt.lo"(%249, %248) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %251 = "rocdl.mbcnt.hi"(%249, %250) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %252 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %253 = "llvm.sub"(%252, %224) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %254 = "llvm.add"(%251, %224) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %255 = "llvm.and"(%254, %253) : (i32, i32) -> i32
      %256 = "llvm.xor"(%251, %15) : (i32, i32) -> i32
      %257 = "llvm.icmp"(%256, %255) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %258 = "llvm.select"(%257, %256, %251) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %259 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %260 = "llvm.shl"(%258, %259) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %261 = "llvm.bitcast"(%247) : (f32) -> i32
      %262 = "rocdl.ds_bpermute"(%260, %261) : (i32, i32) -> i32
      %263 = "llvm.bitcast"(%262) : (i32) -> f32
      "llvm.cond_br"(%257)[^bb27, ^bb28] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb27:  // pred: ^bb26
      %264 = "llvm.fadd"(%247, %263) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%264)[^bb29] : (f32) -> ()
    ^bb28:  // pred: ^bb26
      "llvm.br"(%247)[^bb29] : (f32) -> ()
    ^bb29(%265: f32):  // 2 preds: ^bb27, ^bb28
      %266 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %267 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %268 = "rocdl.mbcnt.lo"(%267, %266) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %269 = "rocdl.mbcnt.hi"(%267, %268) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %270 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %271 = "llvm.sub"(%270, %224) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %272 = "llvm.add"(%269, %224) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %273 = "llvm.and"(%272, %271) : (i32, i32) -> i32
      %274 = "llvm.xor"(%269, %14) : (i32, i32) -> i32
      %275 = "llvm.icmp"(%274, %273) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %276 = "llvm.select"(%275, %274, %269) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %277 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %278 = "llvm.shl"(%276, %277) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %279 = "llvm.bitcast"(%265) : (f32) -> i32
      %280 = "rocdl.ds_bpermute"(%278, %279) : (i32, i32) -> i32
      %281 = "llvm.bitcast"(%280) : (i32) -> f32
      "llvm.cond_br"(%275)[^bb30, ^bb31] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb30:  // pred: ^bb29
      %282 = "llvm.fadd"(%265, %281) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%282)[^bb32] : (f32) -> ()
    ^bb31:  // pred: ^bb29
      "llvm.br"(%265)[^bb32] : (f32) -> ()
    ^bb32(%283: f32):  // 2 preds: ^bb30, ^bb31
      %284 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %285 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %286 = "rocdl.mbcnt.lo"(%285, %284) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %287 = "rocdl.mbcnt.hi"(%285, %286) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %288 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %289 = "llvm.sub"(%288, %224) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %290 = "llvm.add"(%287, %224) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %291 = "llvm.and"(%290, %289) : (i32, i32) -> i32
      %292 = "llvm.xor"(%287, %13) : (i32, i32) -> i32
      %293 = "llvm.icmp"(%292, %291) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %294 = "llvm.select"(%293, %292, %287) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %295 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %296 = "llvm.shl"(%294, %295) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %297 = "llvm.bitcast"(%283) : (f32) -> i32
      %298 = "rocdl.ds_bpermute"(%296, %297) : (i32, i32) -> i32
      %299 = "llvm.bitcast"(%298) : (i32) -> f32
      "llvm.cond_br"(%293)[^bb33, ^bb34] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb33:  // pred: ^bb32
      %300 = "llvm.fadd"(%283, %299) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%300)[^bb35] : (f32) -> ()
    ^bb34:  // pred: ^bb32
      "llvm.br"(%283)[^bb35] : (f32) -> ()
    ^bb35(%301: f32):  // 2 preds: ^bb33, ^bb34
      %302 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %303 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %304 = "rocdl.mbcnt.lo"(%303, %302) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %305 = "rocdl.mbcnt.hi"(%303, %304) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %306 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %307 = "llvm.sub"(%306, %224) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %308 = "llvm.add"(%305, %224) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %309 = "llvm.and"(%308, %307) : (i32, i32) -> i32
      %310 = "llvm.xor"(%305, %12) : (i32, i32) -> i32
      %311 = "llvm.icmp"(%310, %309) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %312 = "llvm.select"(%311, %310, %305) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %313 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %314 = "llvm.shl"(%312, %313) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %315 = "llvm.bitcast"(%301) : (f32) -> i32
      %316 = "rocdl.ds_bpermute"(%314, %315) : (i32, i32) -> i32
      %317 = "llvm.bitcast"(%316) : (i32) -> f32
      "llvm.cond_br"(%311)[^bb36, ^bb37] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb36:  // pred: ^bb35
      %318 = "llvm.fadd"(%301, %317) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%318)[^bb38] : (f32) -> ()
    ^bb37:  // pred: ^bb35
      "llvm.br"(%301)[^bb38] : (f32) -> ()
    ^bb38(%319: f32):  // 2 preds: ^bb36, ^bb37
      "llvm.br"(%319)[^bb40] : (f32) -> ()
    ^bb39:  // pred: ^bb22
      %320 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %321 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %322 = "rocdl.mbcnt.lo"(%321, %320) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %323 = "rocdl.mbcnt.hi"(%321, %322) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %324 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %325 = "llvm.sub"(%324, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %326 = "llvm.add"(%323, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %327 = "llvm.and"(%326, %325) : (i32, i32) -> i32
      %328 = "llvm.xor"(%323, %16) : (i32, i32) -> i32
      %329 = "llvm.icmp"(%328, %327) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %330 = "llvm.select"(%329, %328, %323) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %331 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %332 = "llvm.shl"(%330, %331) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %333 = "llvm.bitcast"(%228) : (f32) -> i32
      %334 = "rocdl.ds_bpermute"(%332, %333) : (i32, i32) -> i32
      %335 = "llvm.bitcast"(%334) : (i32) -> f32
      %336 = "llvm.fadd"(%228, %335) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %337 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %338 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %339 = "rocdl.mbcnt.lo"(%338, %337) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %340 = "rocdl.mbcnt.hi"(%338, %339) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %341 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %342 = "llvm.sub"(%341, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %343 = "llvm.add"(%340, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %344 = "llvm.and"(%343, %342) : (i32, i32) -> i32
      %345 = "llvm.xor"(%340, %15) : (i32, i32) -> i32
      %346 = "llvm.icmp"(%345, %344) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %347 = "llvm.select"(%346, %345, %340) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %348 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %349 = "llvm.shl"(%347, %348) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %350 = "llvm.bitcast"(%336) : (f32) -> i32
      %351 = "rocdl.ds_bpermute"(%349, %350) : (i32, i32) -> i32
      %352 = "llvm.bitcast"(%351) : (i32) -> f32
      %353 = "llvm.fadd"(%336, %352) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %354 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %355 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %356 = "rocdl.mbcnt.lo"(%355, %354) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %357 = "rocdl.mbcnt.hi"(%355, %356) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %358 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %359 = "llvm.sub"(%358, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %360 = "llvm.add"(%357, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %361 = "llvm.and"(%360, %359) : (i32, i32) -> i32
      %362 = "llvm.xor"(%357, %14) : (i32, i32) -> i32
      %363 = "llvm.icmp"(%362, %361) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %364 = "llvm.select"(%363, %362, %357) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %365 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %366 = "llvm.shl"(%364, %365) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %367 = "llvm.bitcast"(%353) : (f32) -> i32
      %368 = "rocdl.ds_bpermute"(%366, %367) : (i32, i32) -> i32
      %369 = "llvm.bitcast"(%368) : (i32) -> f32
      %370 = "llvm.fadd"(%353, %369) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %371 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %372 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %373 = "rocdl.mbcnt.lo"(%372, %371) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %374 = "rocdl.mbcnt.hi"(%372, %373) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %375 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %376 = "llvm.sub"(%375, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %377 = "llvm.add"(%374, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %378 = "llvm.and"(%377, %376) : (i32, i32) -> i32
      %379 = "llvm.xor"(%374, %13) : (i32, i32) -> i32
      %380 = "llvm.icmp"(%379, %378) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %381 = "llvm.select"(%380, %379, %374) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %382 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %383 = "llvm.shl"(%381, %382) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %384 = "llvm.bitcast"(%370) : (f32) -> i32
      %385 = "rocdl.ds_bpermute"(%383, %384) : (i32, i32) -> i32
      %386 = "llvm.bitcast"(%385) : (i32) -> f32
      %387 = "llvm.fadd"(%370, %386) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      %388 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %389 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %390 = "rocdl.mbcnt.lo"(%389, %388) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %391 = "rocdl.mbcnt.hi"(%389, %390) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %392 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %393 = "llvm.sub"(%392, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %394 = "llvm.add"(%391, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %395 = "llvm.and"(%394, %393) : (i32, i32) -> i32
      %396 = "llvm.xor"(%391, %12) : (i32, i32) -> i32
      %397 = "llvm.icmp"(%396, %395) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %398 = "llvm.select"(%397, %396, %391) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %399 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %400 = "llvm.shl"(%398, %399) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %401 = "llvm.bitcast"(%387) : (f32) -> i32
      %402 = "rocdl.ds_bpermute"(%400, %401) : (i32, i32) -> i32
      %403 = "llvm.bitcast"(%402) : (i32) -> f32
      %404 = "llvm.fadd"(%387, %403) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
      "llvm.br"(%404)[^bb40] : (f32) -> ()
    ^bb40(%405: f32):  // 2 preds: ^bb38, ^bb39
      %406 = "llvm.extractvalue"(%10) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>) -> !llvm.ptr<3>
      %407 = "llvm.getelementptr"(%406, %11) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>
      "llvm.store"(%405, %407) <{ordering = 0 : i64}> : (f32, !llvm.ptr<3>) -> ()
      "llvm.br"()[^bb42] : () -> ()
    ^bb41:  // pred: ^bb21
      "llvm.br"()[^bb42] : () -> ()
    ^bb42:  // 2 preds: ^bb40, ^bb41
      "llvm.fence"() <{ordering = 5 : i64, syncscope = "workgroup"}> {llvm.mmra = #mmra_tag} : () -> ()
      "rocdl.s.barrier"() : () -> ()
      "llvm.fence"() <{ordering = 4 : i64, syncscope = "workgroup"}> {llvm.mmra = #mmra_tag} : () -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
#mmra_tag = #llvm.mmra_tag<"amdgpu-synchronize-as":"local">
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i32)>, linkage = #llvm.linkage<external>, sym_name = "__ockl_get_local_size", visibility_ = 0 : i64}> ({
    }) : () -> ()
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
      %20 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %21 = "llvm.call"(%20) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ockl_get_local_size, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, res_attrs = [{llvm.range = #llvm.constant_range<i64, 1, 1025>}]}> : (i32) -> i64
      %22 = "llvm.trunc"(%21) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %23 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %24 = "llvm.call"(%23) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ockl_get_local_size, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, res_attrs = [{llvm.range = #llvm.constant_range<i64, 1, 1025>}]}> : (i32) -> i64
      %25 = "llvm.trunc"(%24) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %26 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %27 = "llvm.call"(%26) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ockl_get_local_size, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, res_attrs = [{llvm.range = #llvm.constant_range<i64, 1, 1025>}]}> : (i32) -> i64
      %28 = "llvm.trunc"(%27) <{overflowFlags = 0 : i32}> : (i64) -> i32
      %29 = "rocdl.workitem.id.x"() : () -> i32
      %30 = "rocdl.workitem.id.y"() : () -> i32
      %31 = "rocdl.workitem.id.z"() : () -> i32
      %32 = "llvm.mul"(%31, %25) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %33 = "llvm.add"(%32, %30) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %34 = "llvm.mul"(%33, %22) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %35 = "llvm.mul"(%22, %25) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %36 = "llvm.add"(%34, %29) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %37 = "llvm.mul"(%35, %28) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %38 = "llvm.and"(%36, %18) : (i32, i32) -> i32
      %39 = "llvm.icmp"(%38, %17) <{predicate = 0 : i64}> : (i32, i32) -> i1
      %40 = "llvm.sub"(%36, %38) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %41 = "llvm.sub"(%37, %40) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %42 = "llvm.icmp"(%41, %16) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%42)[^bb1, ^bb22] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %43 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %44 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %45 = "rocdl.mbcnt.lo"(%44, %43) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %46 = "rocdl.mbcnt.hi"(%44, %45) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %47 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %48 = "llvm.sub"(%47, %41) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %49 = "llvm.add"(%46, %41) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %50 = "llvm.and"(%49, %48) : (i32, i32) -> i32
      %51 = "llvm.xor"(%46, %19) : (i32, i32) -> i32
      %52 = "llvm.icmp"(%51, %50) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %53 = "llvm.select"(%52, %51, %46) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %54 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %55 = "llvm.shl"(%53, %54) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %56 = "rocdl.ds_bpermute"(%55, %19) : (i32, i32) -> i32
      "llvm.cond_br"(%52, %19)[^bb2, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb2:  // pred: ^bb1
      "llvm.br"()[^bb3] : () -> ()
    ^bb3:  // pred: ^bb2
      %57 = "llvm.xor"(%56, %19) : (i32, i32) -> i32
      "llvm.br"(%57)[^bb4] : (i32) -> ()
    ^bb4(%58: i32):  // 2 preds: ^bb1, ^bb3
      "llvm.br"()[^bb5] : () -> ()
    ^bb5:  // pred: ^bb4
      %59 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %60 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %61 = "rocdl.mbcnt.lo"(%60, %59) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %62 = "rocdl.mbcnt.hi"(%60, %61) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %63 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %64 = "llvm.sub"(%63, %41) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %65 = "llvm.add"(%62, %41) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %66 = "llvm.and"(%65, %64) : (i32, i32) -> i32
      %67 = "llvm.xor"(%62, %15) : (i32, i32) -> i32
      %68 = "llvm.icmp"(%67, %66) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %69 = "llvm.select"(%68, %67, %62) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %70 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %71 = "llvm.shl"(%69, %70) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %72 = "rocdl.ds_bpermute"(%71, %58) : (i32, i32) -> i32
      "llvm.cond_br"(%68, %58)[^bb6, ^bb8] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb6:  // pred: ^bb5
      "llvm.br"()[^bb7] : () -> ()
    ^bb7:  // pred: ^bb6
      %73 = "llvm.xor"(%58, %72) : (i32, i32) -> i32
      "llvm.br"(%73)[^bb8] : (i32) -> ()
    ^bb8(%74: i32):  // 2 preds: ^bb5, ^bb7
      "llvm.br"()[^bb9] : () -> ()
    ^bb9:  // pred: ^bb8
      %75 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %76 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %77 = "rocdl.mbcnt.lo"(%76, %75) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %78 = "rocdl.mbcnt.hi"(%76, %77) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %79 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %80 = "llvm.sub"(%79, %41) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %81 = "llvm.add"(%78, %41) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %82 = "llvm.and"(%81, %80) : (i32, i32) -> i32
      %83 = "llvm.xor"(%78, %14) : (i32, i32) -> i32
      %84 = "llvm.icmp"(%83, %82) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %85 = "llvm.select"(%84, %83, %78) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %86 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %87 = "llvm.shl"(%85, %86) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %88 = "rocdl.ds_bpermute"(%87, %74) : (i32, i32) -> i32
      "llvm.cond_br"(%84, %74)[^bb10, ^bb12] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb10:  // pred: ^bb9
      "llvm.br"()[^bb11] : () -> ()
    ^bb11:  // pred: ^bb10
      %89 = "llvm.xor"(%74, %88) : (i32, i32) -> i32
      "llvm.br"(%89)[^bb12] : (i32) -> ()
    ^bb12(%90: i32):  // 2 preds: ^bb9, ^bb11
      "llvm.br"()[^bb13] : () -> ()
    ^bb13:  // pred: ^bb12
      %91 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %92 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %93 = "rocdl.mbcnt.lo"(%92, %91) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %94 = "rocdl.mbcnt.hi"(%92, %93) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %95 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %96 = "llvm.sub"(%95, %41) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %97 = "llvm.add"(%94, %41) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %98 = "llvm.and"(%97, %96) : (i32, i32) -> i32
      %99 = "llvm.xor"(%94, %13) : (i32, i32) -> i32
      %100 = "llvm.icmp"(%99, %98) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %101 = "llvm.select"(%100, %99, %94) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %102 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %103 = "llvm.shl"(%101, %102) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %104 = "rocdl.ds_bpermute"(%103, %90) : (i32, i32) -> i32
      "llvm.cond_br"(%100, %90)[^bb14, ^bb16] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb14:  // pred: ^bb13
      "llvm.br"()[^bb15] : () -> ()
    ^bb15:  // pred: ^bb14
      %105 = "llvm.xor"(%90, %104) : (i32, i32) -> i32
      "llvm.br"(%105)[^bb16] : (i32) -> ()
    ^bb16(%106: i32):  // 2 preds: ^bb13, ^bb15
      "llvm.br"()[^bb17] : () -> ()
    ^bb17:  // pred: ^bb16
      %107 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %108 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %109 = "rocdl.mbcnt.lo"(%108, %107) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %110 = "rocdl.mbcnt.hi"(%108, %109) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %111 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %112 = "llvm.sub"(%111, %41) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %113 = "llvm.add"(%110, %41) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %114 = "llvm.and"(%113, %112) : (i32, i32) -> i32
      %115 = "llvm.xor"(%110, %12) : (i32, i32) -> i32
      %116 = "llvm.icmp"(%115, %114) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %117 = "llvm.select"(%116, %115, %110) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %118 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %119 = "llvm.shl"(%117, %118) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %120 = "rocdl.ds_bpermute"(%119, %106) : (i32, i32) -> i32
      "llvm.cond_br"(%116, %106)[^bb18, ^bb20] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb18:  // pred: ^bb17
      "llvm.br"()[^bb19] : () -> ()
    ^bb19:  // pred: ^bb18
      %121 = "llvm.xor"(%106, %120) : (i32, i32) -> i32
      "llvm.br"(%121)[^bb20] : (i32) -> ()
    ^bb20(%122: i32):  // 2 preds: ^bb17, ^bb19
      "llvm.br"(%122)[^bb21] : (i32) -> ()
    ^bb21(%123: i32):  // 2 preds: ^bb20, ^bb31
      "llvm.br"()[^bb32] : () -> ()
    ^bb22:  // pred: ^bb0
      %124 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %125 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %126 = "rocdl.mbcnt.lo"(%125, %124) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %127 = "rocdl.mbcnt.hi"(%125, %126) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %128 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %129 = "llvm.sub"(%128, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %130 = "llvm.add"(%127, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %131 = "llvm.and"(%130, %129) : (i32, i32) -> i32
      %132 = "llvm.xor"(%127, %19) : (i32, i32) -> i32
      %133 = "llvm.icmp"(%132, %131) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %134 = "llvm.select"(%133, %132, %127) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %135 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %136 = "llvm.shl"(%134, %135) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %137 = "rocdl.ds_bpermute"(%136, %19) : (i32, i32) -> i32
      "llvm.br"()[^bb23] : () -> ()
    ^bb23:  // pred: ^bb22
      %138 = "llvm.xor"(%137, %19) : (i32, i32) -> i32
      "llvm.br"()[^bb24] : () -> ()
    ^bb24:  // pred: ^bb23
      %139 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %140 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %141 = "rocdl.mbcnt.lo"(%140, %139) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %142 = "rocdl.mbcnt.hi"(%140, %141) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %143 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %144 = "llvm.sub"(%143, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %145 = "llvm.add"(%142, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %146 = "llvm.and"(%145, %144) : (i32, i32) -> i32
      %147 = "llvm.xor"(%142, %15) : (i32, i32) -> i32
      %148 = "llvm.icmp"(%147, %146) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %149 = "llvm.select"(%148, %147, %142) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %150 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %151 = "llvm.shl"(%149, %150) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %152 = "rocdl.ds_bpermute"(%151, %138) : (i32, i32) -> i32
      "llvm.br"()[^bb25] : () -> ()
    ^bb25:  // pred: ^bb24
      %153 = "llvm.xor"(%138, %152) : (i32, i32) -> i32
      "llvm.br"()[^bb26] : () -> ()
    ^bb26:  // pred: ^bb25
      %154 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %155 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %156 = "rocdl.mbcnt.lo"(%155, %154) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %157 = "rocdl.mbcnt.hi"(%155, %156) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %158 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %159 = "llvm.sub"(%158, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %160 = "llvm.add"(%157, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %161 = "llvm.and"(%160, %159) : (i32, i32) -> i32
      %162 = "llvm.xor"(%157, %14) : (i32, i32) -> i32
      %163 = "llvm.icmp"(%162, %161) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %164 = "llvm.select"(%163, %162, %157) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %165 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %166 = "llvm.shl"(%164, %165) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %167 = "rocdl.ds_bpermute"(%166, %153) : (i32, i32) -> i32
      "llvm.br"()[^bb27] : () -> ()
    ^bb27:  // pred: ^bb26
      %168 = "llvm.xor"(%153, %167) : (i32, i32) -> i32
      "llvm.br"()[^bb28] : () -> ()
    ^bb28:  // pred: ^bb27
      %169 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %170 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %171 = "rocdl.mbcnt.lo"(%170, %169) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %172 = "rocdl.mbcnt.hi"(%170, %171) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %173 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %174 = "llvm.sub"(%173, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %175 = "llvm.add"(%172, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %176 = "llvm.and"(%175, %174) : (i32, i32) -> i32
      %177 = "llvm.xor"(%172, %13) : (i32, i32) -> i32
      %178 = "llvm.icmp"(%177, %176) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %179 = "llvm.select"(%178, %177, %172) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %180 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %181 = "llvm.shl"(%179, %180) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %182 = "rocdl.ds_bpermute"(%181, %168) : (i32, i32) -> i32
      "llvm.br"()[^bb29] : () -> ()
    ^bb29:  // pred: ^bb28
      %183 = "llvm.xor"(%168, %182) : (i32, i32) -> i32
      "llvm.br"()[^bb30] : () -> ()
    ^bb30:  // pred: ^bb29
      %184 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %185 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %186 = "rocdl.mbcnt.lo"(%185, %184) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %187 = "rocdl.mbcnt.hi"(%185, %186) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %188 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %189 = "llvm.sub"(%188, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %190 = "llvm.add"(%187, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %191 = "llvm.and"(%190, %189) : (i32, i32) -> i32
      %192 = "llvm.xor"(%187, %12) : (i32, i32) -> i32
      %193 = "llvm.icmp"(%192, %191) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %194 = "llvm.select"(%193, %192, %187) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %195 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %196 = "llvm.shl"(%194, %195) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %197 = "rocdl.ds_bpermute"(%196, %183) : (i32, i32) -> i32
      "llvm.br"()[^bb31] : () -> ()
    ^bb31:  // pred: ^bb30
      %198 = "llvm.xor"(%183, %197) : (i32, i32) -> i32
      "llvm.br"(%198)[^bb21] : (i32) -> ()
    ^bb32:  // pred: ^bb21
      "llvm.cond_br"(%39)[^bb33, ^bb34] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb33:  // pred: ^bb32
      %199 = "llvm.sdiv"(%36, %16) : (i32, i32) -> i32
      %200 = "llvm.extractvalue"(%10) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>) -> !llvm.ptr<3>
      %201 = "llvm.getelementptr"(%200, %199) <{elem_type = i32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>
      "llvm.store"(%123, %201) <{ordering = 0 : i64}> : (i32, !llvm.ptr<3>) -> ()
      "llvm.br"()[^bb35] : () -> ()
    ^bb34:  // pred: ^bb32
      "llvm.br"()[^bb35] : () -> ()
    ^bb35:  // 2 preds: ^bb33, ^bb34
      "llvm.fence"() <{ordering = 5 : i64, syncscope = "workgroup"}> {llvm.mmra = #mmra_tag} : () -> ()
      "rocdl.s.barrier"() : () -> ()
      "llvm.fence"() <{ordering = 4 : i64, syncscope = "workgroup"}> {llvm.mmra = #mmra_tag} : () -> ()
      %202 = "llvm.add"(%37, %18) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %203 = "llvm.sdiv"(%202, %16) : (i32, i32) -> i32
      %204 = "llvm.icmp"(%36, %203) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%204)[^bb36, ^bb69] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb36:  // pred: ^bb35
      %205 = "llvm.extractvalue"(%10) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>) -> !llvm.ptr<3>
      %206 = "llvm.getelementptr"(%205, %36) <{elem_type = i32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>
      %207 = "llvm.load"(%206) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> i32
      %208 = "llvm.icmp"(%203, %16) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%208)[^bb37, ^bb58] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb37:  // pred: ^bb36
      %209 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %210 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %211 = "rocdl.mbcnt.lo"(%210, %209) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %212 = "rocdl.mbcnt.hi"(%210, %211) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %213 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %214 = "llvm.sub"(%213, %203) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %215 = "llvm.add"(%212, %203) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %216 = "llvm.and"(%215, %214) : (i32, i32) -> i32
      %217 = "llvm.xor"(%212, %19) : (i32, i32) -> i32
      %218 = "llvm.icmp"(%217, %216) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %219 = "llvm.select"(%218, %217, %212) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %220 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %221 = "llvm.shl"(%219, %220) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %222 = "rocdl.ds_bpermute"(%221, %207) : (i32, i32) -> i32
      "llvm.cond_br"(%218, %207)[^bb38, ^bb40] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb38:  // pred: ^bb37
      "llvm.br"()[^bb39] : () -> ()
    ^bb39:  // pred: ^bb38
      %223 = "llvm.xor"(%207, %222) : (i32, i32) -> i32
      "llvm.br"(%223)[^bb40] : (i32) -> ()
    ^bb40(%224: i32):  // 2 preds: ^bb37, ^bb39
      "llvm.br"()[^bb41] : () -> ()
    ^bb41:  // pred: ^bb40
      %225 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %226 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %227 = "rocdl.mbcnt.lo"(%226, %225) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %228 = "rocdl.mbcnt.hi"(%226, %227) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %229 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %230 = "llvm.sub"(%229, %203) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %231 = "llvm.add"(%228, %203) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %232 = "llvm.and"(%231, %230) : (i32, i32) -> i32
      %233 = "llvm.xor"(%228, %15) : (i32, i32) -> i32
      %234 = "llvm.icmp"(%233, %232) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %235 = "llvm.select"(%234, %233, %228) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %236 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %237 = "llvm.shl"(%235, %236) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %238 = "rocdl.ds_bpermute"(%237, %224) : (i32, i32) -> i32
      "llvm.cond_br"(%234, %224)[^bb42, ^bb44] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb42:  // pred: ^bb41
      "llvm.br"()[^bb43] : () -> ()
    ^bb43:  // pred: ^bb42
      %239 = "llvm.xor"(%224, %238) : (i32, i32) -> i32
      "llvm.br"(%239)[^bb44] : (i32) -> ()
    ^bb44(%240: i32):  // 2 preds: ^bb41, ^bb43
      "llvm.br"()[^bb45] : () -> ()
    ^bb45:  // pred: ^bb44
      %241 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %242 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %243 = "rocdl.mbcnt.lo"(%242, %241) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %244 = "rocdl.mbcnt.hi"(%242, %243) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %245 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %246 = "llvm.sub"(%245, %203) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %247 = "llvm.add"(%244, %203) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %248 = "llvm.and"(%247, %246) : (i32, i32) -> i32
      %249 = "llvm.xor"(%244, %14) : (i32, i32) -> i32
      %250 = "llvm.icmp"(%249, %248) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %251 = "llvm.select"(%250, %249, %244) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %252 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %253 = "llvm.shl"(%251, %252) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %254 = "rocdl.ds_bpermute"(%253, %240) : (i32, i32) -> i32
      "llvm.cond_br"(%250, %240)[^bb46, ^bb48] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb46:  // pred: ^bb45
      "llvm.br"()[^bb47] : () -> ()
    ^bb47:  // pred: ^bb46
      %255 = "llvm.xor"(%240, %254) : (i32, i32) -> i32
      "llvm.br"(%255)[^bb48] : (i32) -> ()
    ^bb48(%256: i32):  // 2 preds: ^bb45, ^bb47
      "llvm.br"()[^bb49] : () -> ()
    ^bb49:  // pred: ^bb48
      %257 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %258 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %259 = "rocdl.mbcnt.lo"(%258, %257) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %260 = "rocdl.mbcnt.hi"(%258, %259) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %261 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %262 = "llvm.sub"(%261, %203) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %263 = "llvm.add"(%260, %203) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %264 = "llvm.and"(%263, %262) : (i32, i32) -> i32
      %265 = "llvm.xor"(%260, %13) : (i32, i32) -> i32
      %266 = "llvm.icmp"(%265, %264) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %267 = "llvm.select"(%266, %265, %260) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %268 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %269 = "llvm.shl"(%267, %268) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %270 = "rocdl.ds_bpermute"(%269, %256) : (i32, i32) -> i32
      "llvm.cond_br"(%266, %256)[^bb50, ^bb52] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb50:  // pred: ^bb49
      "llvm.br"()[^bb51] : () -> ()
    ^bb51:  // pred: ^bb50
      %271 = "llvm.xor"(%256, %270) : (i32, i32) -> i32
      "llvm.br"(%271)[^bb52] : (i32) -> ()
    ^bb52(%272: i32):  // 2 preds: ^bb49, ^bb51
      "llvm.br"()[^bb53] : () -> ()
    ^bb53:  // pred: ^bb52
      %273 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %274 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %275 = "rocdl.mbcnt.lo"(%274, %273) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %276 = "rocdl.mbcnt.hi"(%274, %275) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %277 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %278 = "llvm.sub"(%277, %203) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %279 = "llvm.add"(%276, %203) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %280 = "llvm.and"(%279, %278) : (i32, i32) -> i32
      %281 = "llvm.xor"(%276, %12) : (i32, i32) -> i32
      %282 = "llvm.icmp"(%281, %280) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %283 = "llvm.select"(%282, %281, %276) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %284 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %285 = "llvm.shl"(%283, %284) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %286 = "rocdl.ds_bpermute"(%285, %272) : (i32, i32) -> i32
      "llvm.cond_br"(%282, %272)[^bb54, ^bb56] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb54:  // pred: ^bb53
      "llvm.br"()[^bb55] : () -> ()
    ^bb55:  // pred: ^bb54
      %287 = "llvm.xor"(%272, %286) : (i32, i32) -> i32
      "llvm.br"(%287)[^bb56] : (i32) -> ()
    ^bb56(%288: i32):  // 2 preds: ^bb53, ^bb55
      "llvm.br"(%288)[^bb57] : (i32) -> ()
    ^bb57(%289: i32):  // 2 preds: ^bb56, ^bb67
      "llvm.br"()[^bb68] : () -> ()
    ^bb58:  // pred: ^bb36
      %290 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %291 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %292 = "rocdl.mbcnt.lo"(%291, %290) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %293 = "rocdl.mbcnt.hi"(%291, %292) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %294 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %295 = "llvm.sub"(%294, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %296 = "llvm.add"(%293, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %297 = "llvm.and"(%296, %295) : (i32, i32) -> i32
      %298 = "llvm.xor"(%293, %19) : (i32, i32) -> i32
      %299 = "llvm.icmp"(%298, %297) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %300 = "llvm.select"(%299, %298, %293) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %301 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %302 = "llvm.shl"(%300, %301) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %303 = "rocdl.ds_bpermute"(%302, %207) : (i32, i32) -> i32
      "llvm.br"()[^bb59] : () -> ()
    ^bb59:  // pred: ^bb58
      %304 = "llvm.xor"(%207, %303) : (i32, i32) -> i32
      "llvm.br"()[^bb60] : () -> ()
    ^bb60:  // pred: ^bb59
      %305 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %306 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %307 = "rocdl.mbcnt.lo"(%306, %305) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %308 = "rocdl.mbcnt.hi"(%306, %307) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %309 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %310 = "llvm.sub"(%309, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %311 = "llvm.add"(%308, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %312 = "llvm.and"(%311, %310) : (i32, i32) -> i32
      %313 = "llvm.xor"(%308, %15) : (i32, i32) -> i32
      %314 = "llvm.icmp"(%313, %312) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %315 = "llvm.select"(%314, %313, %308) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %316 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %317 = "llvm.shl"(%315, %316) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %318 = "rocdl.ds_bpermute"(%317, %304) : (i32, i32) -> i32
      "llvm.br"()[^bb61] : () -> ()
    ^bb61:  // pred: ^bb60
      %319 = "llvm.xor"(%304, %318) : (i32, i32) -> i32
      "llvm.br"()[^bb62] : () -> ()
    ^bb62:  // pred: ^bb61
      %320 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %321 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %322 = "rocdl.mbcnt.lo"(%321, %320) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %323 = "rocdl.mbcnt.hi"(%321, %322) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %324 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %325 = "llvm.sub"(%324, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %326 = "llvm.add"(%323, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %327 = "llvm.and"(%326, %325) : (i32, i32) -> i32
      %328 = "llvm.xor"(%323, %14) : (i32, i32) -> i32
      %329 = "llvm.icmp"(%328, %327) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %330 = "llvm.select"(%329, %328, %323) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %331 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %332 = "llvm.shl"(%330, %331) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %333 = "rocdl.ds_bpermute"(%332, %319) : (i32, i32) -> i32
      "llvm.br"()[^bb63] : () -> ()
    ^bb63:  // pred: ^bb62
      %334 = "llvm.xor"(%319, %333) : (i32, i32) -> i32
      "llvm.br"()[^bb64] : () -> ()
    ^bb64:  // pred: ^bb63
      %335 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %336 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %337 = "rocdl.mbcnt.lo"(%336, %335) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %338 = "rocdl.mbcnt.hi"(%336, %337) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %339 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %340 = "llvm.sub"(%339, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %341 = "llvm.add"(%338, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %342 = "llvm.and"(%341, %340) : (i32, i32) -> i32
      %343 = "llvm.xor"(%338, %13) : (i32, i32) -> i32
      %344 = "llvm.icmp"(%343, %342) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %345 = "llvm.select"(%344, %343, %338) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %346 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %347 = "llvm.shl"(%345, %346) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %348 = "rocdl.ds_bpermute"(%347, %334) : (i32, i32) -> i32
      "llvm.br"()[^bb65] : () -> ()
    ^bb65:  // pred: ^bb64
      %349 = "llvm.xor"(%334, %348) : (i32, i32) -> i32
      "llvm.br"()[^bb66] : () -> ()
    ^bb66:  // pred: ^bb65
      %350 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %351 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
      %352 = "rocdl.mbcnt.lo"(%351, %350) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 32>}]}> : (i32, i32) -> i32
      %353 = "rocdl.mbcnt.hi"(%351, %352) <{res_attrs = [{llvm.noundef, llvm.range = #llvm.constant_range<i32, 0, 64>}]}> : (i32, i32) -> i32
      %354 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %355 = "llvm.sub"(%354, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %356 = "llvm.add"(%353, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %357 = "llvm.and"(%356, %355) : (i32, i32) -> i32
      %358 = "llvm.xor"(%353, %12) : (i32, i32) -> i32
      %359 = "llvm.icmp"(%358, %357) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %360 = "llvm.select"(%359, %358, %353) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
      %361 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %362 = "llvm.shl"(%360, %361) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %363 = "rocdl.ds_bpermute"(%362, %349) : (i32, i32) -> i32
      "llvm.br"()[^bb67] : () -> ()
    ^bb67:  // pred: ^bb66
      %364 = "llvm.xor"(%349, %363) : (i32, i32) -> i32
      "llvm.br"(%364)[^bb57] : (i32) -> ()
    ^bb68:  // pred: ^bb57
      %365 = "llvm.extractvalue"(%10) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>) -> !llvm.ptr<3>
      %366 = "llvm.getelementptr"(%365, %11) <{elem_type = i32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>
      "llvm.store"(%289, %366) <{ordering = 0 : i64}> : (i32, !llvm.ptr<3>) -> ()
      "llvm.br"()[^bb70] : () -> ()
    ^bb69:  // pred: ^bb35
      "llvm.br"()[^bb70] : () -> ()
    ^bb70:  // 2 preds: ^bb68, ^bb69
      "llvm.fence"() <{ordering = 5 : i64, syncscope = "workgroup"}> {llvm.mmra = #mmra_tag} : () -> ()
      "rocdl.s.barrier"() : () -> ()
      "llvm.fence"() <{ordering = 4 : i64, syncscope = "workgroup"}> {llvm.mmra = #mmra_tag} : () -> ()
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
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i32)>, linkage = #llvm.linkage<external>, sym_name = "__ockl_get_local_size", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_dim_int_max_upper_bound", visibility_ = 0 : i64}> ({
      %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %2 = "llvm.call"(%1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ockl_get_local_size, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, res_attrs = [{llvm.range = #llvm.constant_range<i64, 1, 2147483648>}]}> : (i32) -> i64
      %3 = "llvm.trunc"(%2) <{overflowFlags = 0 : i32}> : (i64) -> i32
      "llvm.return"(%3) : (i32) -> ()
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
    ^bb0(%arg26: i32, %arg27: i32):
      %112 = "rocdl.readfirstlane"(%arg26) : (i32) -> i32
      %113 = "rocdl.readlane"(%arg26, %arg27) : (i32, i32) -> i32
      %114 = "llvm.mlir.poison"() : () -> !llvm.struct<(i32, i32)>
      %115 = "llvm.insertvalue"(%114, %112) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>, i32) -> !llvm.struct<(i32, i32)>
      %116 = "llvm.insertvalue"(%115, %113) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>, i32) -> !llvm.struct<(i32, i32)>
      "llvm.return"(%116) : (!llvm.struct<(i32, i32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_broadcast", visibility_ = 0 : i64}> ({
    ^bb0(%arg23: !llvm.ptr, %arg24: i32, %arg25: i32):
      %111 = "llvm.call"(%arg24, %arg25) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @broadcast, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i32, i32) -> !llvm.struct<(i32, i32)>
      "llvm.store"(%111, %arg23) <{ordering = 0 : i64}> : (!llvm.struct<(i32, i32)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(i8, i8)> (i8, i32)>, linkage = #llvm.linkage<external>, sym_name = "broadcast_i8", visibility_ = 0 : i64}> ({
    ^bb0(%arg21: i8, %arg22: i32):
      %102 = "llvm.zext"(%arg21) : (i8) -> i32
      %103 = "rocdl.readfirstlane"(%102) : (i32) -> i32
      %104 = "llvm.trunc"(%103) <{overflowFlags = 0 : i32}> : (i32) -> i8
      %105 = "llvm.zext"(%arg21) : (i8) -> i32
      %106 = "rocdl.readlane"(%105, %arg22) : (i32, i32) -> i32
      %107 = "llvm.trunc"(%106) <{overflowFlags = 0 : i32}> : (i32) -> i8
      %108 = "llvm.mlir.poison"() : () -> !llvm.struct<(i8, i8)>
      %109 = "llvm.insertvalue"(%108, %104) <{position = array<i64: 0>}> : (!llvm.struct<(i8, i8)>, i8) -> !llvm.struct<(i8, i8)>
      %110 = "llvm.insertvalue"(%109, %107) <{position = array<i64: 1>}> : (!llvm.struct<(i8, i8)>, i8) -> !llvm.struct<(i8, i8)>
      "llvm.return"(%110) : (!llvm.struct<(i8, i8)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, i8, i32)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_broadcast_i8", visibility_ = 0 : i64}> ({
    ^bb0(%arg18: !llvm.ptr, %arg19: i8, %arg20: i32):
      %101 = "llvm.call"(%arg19, %arg20) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @broadcast_i8, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i8, i32) -> !llvm.struct<(i8, i8)>
      "llvm.store"(%101, %arg18) <{ordering = 0 : i64}> : (!llvm.struct<(i8, i8)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<4xi16> (vector<4xi16>)>, linkage = #llvm.linkage<external>, sym_name = "broadcast_4xi16", visibility_ = 0 : i64}> ({
    ^bb0(%arg17: vector<4xi16>):
      %88 = "llvm.bitcast"(%arg17) : (vector<4xi16>) -> vector<2xi32>
      %89 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %90 = "llvm.extractelement"(%88, %89) : (vector<2xi32>, i32) -> i32
      %91 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %92 = "llvm.extractelement"(%88, %91) : (vector<2xi32>, i32) -> i32
      %93 = "rocdl.readfirstlane"(%90) : (i32) -> i32
      %94 = "rocdl.readfirstlane"(%92) : (i32) -> i32
      %95 = "llvm.mlir.poison"() : () -> vector<2xi32>
      %96 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %97 = "llvm.insertelement"(%95, %93, %96) : (vector<2xi32>, i32, i32) -> vector<2xi32>
      %98 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %99 = "llvm.insertelement"(%97, %94, %98) : (vector<2xi32>, i32, i32) -> vector<2xi32>
      %100 = "llvm.bitcast"(%99) : (vector<2xi32>) -> vector<4xi16>
      "llvm.return"(%100) : (vector<4xi16>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<4xi16> (vector<4xi16>)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_broadcast_4xi16", visibility_ = 0 : i64}> ({
    ^bb0(%arg16: vector<4xi16>):
      %87 = "llvm.call"(%arg16) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @broadcast_4xi16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (vector<4xi16>) -> vector<4xi16>
      "llvm.return"(%87) : (vector<4xi16>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<array<2 x vector<2xi16>> (array<2 x vector<2xi16>>)>, linkage = #llvm.linkage<external>, sym_name = "broadcast_2x2xi16", visibility_ = 0 : i64}> ({
    ^bb0(%arg15: !llvm.array<2 x vector<2xi16>>):
      %76 = "llvm.extractvalue"(%arg15) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<2xi16>>) -> vector<2xi16>
      %77 = "llvm.bitcast"(%76) : (vector<2xi16>) -> i32
      %78 = "llvm.extractvalue"(%arg15) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<2xi16>>) -> vector<2xi16>
      %79 = "llvm.bitcast"(%78) : (vector<2xi16>) -> i32
      %80 = "rocdl.readfirstlane"(%77) : (i32) -> i32
      %81 = "rocdl.readfirstlane"(%79) : (i32) -> i32
      %82 = "llvm.mlir.poison"() : () -> !llvm.array<2 x vector<2xi16>>
      %83 = "llvm.bitcast"(%80) : (i32) -> vector<2xi16>
      %84 = "llvm.insertvalue"(%82, %83) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<2xi16>>, vector<2xi16>) -> !llvm.array<2 x vector<2xi16>>
      %85 = "llvm.bitcast"(%81) : (i32) -> vector<2xi16>
      %86 = "llvm.insertvalue"(%84, %85) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<2xi16>>, vector<2xi16>) -> !llvm.array<2 x vector<2xi16>>
      "llvm.return"(%86) : (!llvm.array<2 x vector<2xi16>>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<array<2 x vector<2xi16>> (array<2 x vector<2xi16>>)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_broadcast_2x2xi16", visibility_ = 0 : i64}> ({
    ^bb0(%arg14: !llvm.array<2 x vector<2xi16>>):
      %75 = "llvm.call"(%arg14) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @broadcast_2x2xi16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.array<2 x vector<2xi16>>) -> !llvm.array<2 x vector<2xi16>>
      "llvm.return"(%75) : (!llvm.array<2 x vector<2xi16>>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> (ptr, ptr, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "broadcast_memref", visibility_ = 0 : i64}> ({
    ^bb0(%arg9: !llvm.ptr, %arg10: !llvm.ptr, %arg11: i32, %arg12: i32, %arg13: i32):
      %47 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %48 = "llvm.insertvalue"(%47, %arg9) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %49 = "llvm.insertvalue"(%48, %arg10) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %50 = "llvm.insertvalue"(%49, %arg11) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %51 = "llvm.insertvalue"(%50, %arg12) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %52 = "llvm.insertvalue"(%51, %arg13) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %53 = "llvm.extractvalue"(%52) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>) -> !llvm.ptr
      %54 = "llvm.extractvalue"(%52) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>) -> !llvm.ptr
      %55 = "llvm.extractvalue"(%52) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>) -> i32
      %56 = "llvm.extractvalue"(%52) <{position = array<i64: 3>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>) -> !llvm.array<1 x i32>
      %57 = "llvm.extractvalue"(%56) <{position = array<i64: 0>}> : (!llvm.array<1 x i32>) -> i32
      %58 = "llvm.extractvalue"(%52) <{position = array<i64: 4>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>) -> !llvm.array<1 x i32>
      %59 = "llvm.extractvalue"(%58) <{position = array<i64: 0>}> : (!llvm.array<1 x i32>) -> i32
      %60 = "rocdl.readfirstlane"(%53) : (!llvm.ptr) -> !llvm.ptr
      %61 = "rocdl.readfirstlane"(%54) : (!llvm.ptr) -> !llvm.ptr
      %62 = "rocdl.readfirstlane"(%55) : (i32) -> i32
      %63 = "rocdl.readfirstlane"(%57) : (i32) -> i32
      %64 = "rocdl.readfirstlane"(%59) : (i32) -> i32
      %65 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %66 = "llvm.insertvalue"(%65, %60) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %67 = "llvm.insertvalue"(%66, %61) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %68 = "llvm.insertvalue"(%67, %62) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %69 = "llvm.mlir.poison"() : () -> !llvm.array<1 x i32>
      %70 = "llvm.insertvalue"(%69, %63) <{position = array<i64: 0>}> : (!llvm.array<1 x i32>, i32) -> !llvm.array<1 x i32>
      %71 = "llvm.insertvalue"(%68, %70) <{position = array<i64: 3>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, !llvm.array<1 x i32>) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %72 = "llvm.mlir.poison"() : () -> !llvm.array<1 x i32>
      %73 = "llvm.insertvalue"(%72, %64) <{position = array<i64: 0>}> : (!llvm.array<1 x i32>, i32) -> !llvm.array<1 x i32>
      %74 = "llvm.insertvalue"(%71, %73) <{position = array<i64: 4>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, !llvm.array<1 x i32>) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      "llvm.return"(%74) : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_broadcast_memref", visibility_ = 0 : i64}> ({
    ^bb0(%arg7: !llvm.ptr, %arg8: !llvm.ptr):
      %40 = "llvm.load"(%arg8) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %41 = "llvm.extractvalue"(%40) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>) -> !llvm.ptr
      %42 = "llvm.extractvalue"(%40) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>) -> !llvm.ptr
      %43 = "llvm.extractvalue"(%40) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>) -> i32
      %44 = "llvm.extractvalue"(%40) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>) -> i32
      %45 = "llvm.extractvalue"(%40) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>) -> i32
      %46 = "llvm.call"(%41, %42, %43, %44, %45) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @broadcast_memref, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 5, 0>}> : (!llvm.ptr, !llvm.ptr, i32, i32, i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      "llvm.store"(%46, %arg7) <{ordering = 0 : i64}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i48 (i48)>, linkage = #llvm.linkage<external>, sym_name = "broadcast_i48", visibility_ = 0 : i64}> ({
    ^bb0(%arg6: i48):
      %25 = "llvm.zext"(%arg6) : (i48) -> i64
      %26 = "llvm.bitcast"(%25) : (i64) -> vector<2xi32>
      %27 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %28 = "llvm.extractelement"(%26, %27) : (vector<2xi32>, i32) -> i32
      %29 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %30 = "llvm.extractelement"(%26, %29) : (vector<2xi32>, i32) -> i32
      %31 = "rocdl.readfirstlane"(%28) : (i32) -> i32
      %32 = "rocdl.readfirstlane"(%30) : (i32) -> i32
      %33 = "llvm.mlir.poison"() : () -> vector<2xi32>
      %34 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %35 = "llvm.insertelement"(%33, %31, %34) : (vector<2xi32>, i32, i32) -> vector<2xi32>
      %36 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %37 = "llvm.insertelement"(%35, %32, %36) : (vector<2xi32>, i32, i32) -> vector<2xi32>
      %38 = "llvm.bitcast"(%37) : (vector<2xi32>) -> i64
      %39 = "llvm.trunc"(%38) <{overflowFlags = 0 : i32}> : (i64) -> i48
      "llvm.return"(%39) : (i48) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i48 (i48)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_broadcast_i48", visibility_ = 0 : i64}> ({
    ^bb0(%arg5: i48):
      %24 = "llvm.call"(%arg5) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @broadcast_i48, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i48) -> i48
      "llvm.return"(%24) : (i48) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<3xi16> (vector<3xi16>)>, linkage = #llvm.linkage<external>, sym_name = "broadcast_3xi16", visibility_ = 0 : i64}> ({
    ^bb0(%arg4: vector<3xi16>):
      %7 = "llvm.bitcast"(%arg4) : (vector<3xi16>) -> i48
      %8 = "llvm.zext"(%7) : (i48) -> i64
      %9 = "llvm.bitcast"(%8) : (i64) -> vector<2xi32>
      %10 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %11 = "llvm.extractelement"(%9, %10) : (vector<2xi32>, i32) -> i32
      %12 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %13 = "llvm.extractelement"(%9, %12) : (vector<2xi32>, i32) -> i32
      %14 = "rocdl.readfirstlane"(%11) : (i32) -> i32
      %15 = "rocdl.readfirstlane"(%13) : (i32) -> i32
      %16 = "llvm.mlir.poison"() : () -> vector<2xi32>
      %17 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %18 = "llvm.insertelement"(%16, %14, %17) : (vector<2xi32>, i32, i32) -> vector<2xi32>
      %19 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %20 = "llvm.insertelement"(%18, %15, %19) : (vector<2xi32>, i32, i32) -> vector<2xi32>
      %21 = "llvm.bitcast"(%20) : (vector<2xi32>) -> i64
      %22 = "llvm.trunc"(%21) <{overflowFlags = 0 : i32}> : (i64) -> i48
      %23 = "llvm.bitcast"(%22) : (i48) -> vector<3xi16>
      "llvm.return"(%23) : (vector<3xi16>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<3xi16> (vector<3xi16>)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_broadcast_3xi16", visibility_ = 0 : i64}> ({
    ^bb0(%arg3: vector<3xi16>):
      %6 = "llvm.call"(%arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @broadcast_3xi16, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (vector<3xi16>) -> vector<3xi16>
      "llvm.return"(%6) : (vector<3xi16>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(i32, i64)> (i1)>, linkage = #llvm.linkage<external>, sym_name = "ballot", visibility_ = 0 : i64}> ({
    ^bb0(%arg2: i1):
      %1 = "rocdl.ballot"(%arg2) : (i1) -> i32
      %2 = "rocdl.ballot"(%arg2) : (i1) -> i64
      %3 = "llvm.mlir.poison"() : () -> !llvm.struct<(i32, i64)>
      %4 = "llvm.insertvalue"(%3, %1) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i64)>, i32) -> !llvm.struct<(i32, i64)>
      %5 = "llvm.insertvalue"(%4, %2) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i64)>, i64) -> !llvm.struct<(i32, i64)>
      "llvm.return"(%5) : (!llvm.struct<(i32, i64)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, i1)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_ballot", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: i1):
      %0 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @ballot, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i1) -> !llvm.struct<(i32, i64)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(i32, i64)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

