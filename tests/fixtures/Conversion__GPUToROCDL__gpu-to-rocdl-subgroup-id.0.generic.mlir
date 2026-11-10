"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i32)>, linkage = #llvm.linkage<external>, sym_name = "__ockl_get_local_size", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 ()>, linkage = #llvm.linkage<external>, sym_name = "subgroup_id", visibility_ = 0 : i64}> ({
      %33 = "rocdl.workitem.id.x"() : () -> i32
      %34 = "rocdl.workitem.id.y"() : () -> i32
      %35 = "rocdl.workitem.id.z"() : () -> i32
      %36 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %37 = "llvm.call"(%36) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ockl_get_local_size, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, res_attrs = [{llvm.range = #llvm.constant_range<i64, 1, 1025>}]}> : (i32) -> i64
      %38 = "llvm.trunc"(%37) <{overflowFlags = 3 : i32}> : (i64) -> i32
      %39 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %40 = "llvm.call"(%39) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ockl_get_local_size, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, res_attrs = [{llvm.range = #llvm.constant_range<i64, 1, 1025>}]}> : (i32) -> i64
      %41 = "llvm.trunc"(%40) <{overflowFlags = 3 : i32}> : (i64) -> i32
      %42 = "llvm.mul"(%41, %35) <{overflowFlags = 3 : i32}> : (i32, i32) -> i32
      %43 = "llvm.add"(%34, %42) <{overflowFlags = 3 : i32}> : (i32, i32) -> i32
      %44 = "llvm.mul"(%38, %43) <{overflowFlags = 3 : i32}> : (i32, i32) -> i32
      %45 = "llvm.add"(%33, %44) <{overflowFlags = 3 : i32}> : (i32, i32) -> i32
      %46 = "rocdl.wavefrontsize"() : () -> i32
      %47 = "llvm.udiv"(%45, %46) : (i32, i32) -> i32
      %48 = "llvm.sext"(%47) : (i32) -> i64
      "llvm.return"(%48) : (i64) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 ()>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_subgroup_id", visibility_ = 0 : i64}> ({
      %32 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @subgroup_id, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> i64
      "llvm.return"(%32) : (i64) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 ()>, linkage = #llvm.linkage<external>, sym_name = "subgroup_id_with_upper_bound", visibility_ = 0 : i64}> ({
      %16 = "rocdl.workitem.id.x"() : () -> i32
      %17 = "rocdl.workitem.id.y"() : () -> i32
      %18 = "rocdl.workitem.id.z"() : () -> i32
      %19 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %20 = "llvm.call"(%19) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ockl_get_local_size, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, res_attrs = [{llvm.range = #llvm.constant_range<i64, 1, 1025>}]}> : (i32) -> i64
      %21 = "llvm.trunc"(%20) <{overflowFlags = 3 : i32}> : (i64) -> i32
      %22 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %23 = "llvm.call"(%22) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ockl_get_local_size, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, res_attrs = [{llvm.range = #llvm.constant_range<i64, 1, 1025>}]}> : (i32) -> i64
      %24 = "llvm.trunc"(%23) <{overflowFlags = 3 : i32}> : (i64) -> i32
      %25 = "llvm.mul"(%24, %18) <{overflowFlags = 3 : i32}> : (i32, i32) -> i32
      %26 = "llvm.add"(%17, %25) <{overflowFlags = 3 : i32}> : (i32, i32) -> i32
      %27 = "llvm.mul"(%21, %26) <{overflowFlags = 3 : i32}> : (i32, i32) -> i32
      %28 = "llvm.add"(%16, %27) <{overflowFlags = 3 : i32}> : (i32, i32) -> i32
      %29 = "rocdl.wavefrontsize"() : () -> i32
      %30 = "llvm.udiv"(%28, %29) : (i32, i32) -> i32
      %31 = "llvm.sext"(%30) : (i32) -> i64
      "llvm.return"(%31) : (i64) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 ()>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_subgroup_id_with_upper_bound", visibility_ = 0 : i64}> ({
      %15 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @subgroup_id_with_upper_bound, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> i64
      "llvm.return"(%15) : (i64) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 ()>, linkage = #llvm.linkage<external>, sym_name = "subgroup_id_with_workgroup_sizes", visibility_ = 0 : i64}> ({
      %1 = "rocdl.workitem.id.x"() <{range = #llvm.constant_range<i32, 0, 64>}> : () -> i32
      %2 = "rocdl.workitem.id.y"() <{range = #llvm.constant_range<i32, 0, 4>}> : () -> i32
      %3 = "rocdl.workitem.id.z"() <{range = #llvm.constant_range<i32, 0, 1>}> : () -> i32
      %4 = "llvm.mlir.constant"() <{value = 64 : i64}> : () -> i64
      %5 = "llvm.trunc"(%4) <{overflowFlags = 3 : i32}> : (i64) -> i32
      %6 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
      %7 = "llvm.trunc"(%6) <{overflowFlags = 3 : i32}> : (i64) -> i32
      %8 = "llvm.mul"(%7, %3) <{overflowFlags = 3 : i32}> : (i32, i32) -> i32
      %9 = "llvm.add"(%2, %8) <{overflowFlags = 3 : i32}> : (i32, i32) -> i32
      %10 = "llvm.mul"(%5, %9) <{overflowFlags = 3 : i32}> : (i32, i32) -> i32
      %11 = "llvm.add"(%1, %10) <{overflowFlags = 3 : i32}> : (i32, i32) -> i32
      %12 = "rocdl.wavefrontsize"() : () -> i32
      %13 = "llvm.udiv"(%11, %12) : (i32, i32) -> i32
      %14 = "llvm.sext"(%13) : (i32) -> i64
      "llvm.return"(%14) : (i64) -> ()
    }) {gpu.known_block_size = array<i32: 64, 4, 1>, llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 ()>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_subgroup_id_with_workgroup_sizes", visibility_ = 0 : i64}> ({
      %0 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @subgroup_id_with_workgroup_sizes, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> i64
      "llvm.return"(%0) : (i64) -> ()
    }) {gpu.known_block_size = array<i32: 64, 4, 1>, llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

