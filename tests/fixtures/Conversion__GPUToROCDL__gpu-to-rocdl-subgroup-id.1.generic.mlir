"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 ()>, linkage = #llvm.linkage<external>, sym_name = "subgroup_id", visibility_ = 0 : i64}> ({
      %7 = "rocdl.wave.id"() : () -> i32
      %8 = "llvm.sext"(%7) : (i32) -> i64
      "llvm.return"(%8) : (i64) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 ()>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_subgroup_id", visibility_ = 0 : i64}> ({
      %6 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @subgroup_id, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> i64
      "llvm.return"(%6) : (i64) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 ()>, linkage = #llvm.linkage<external>, sym_name = "subgroup_id_with_upper_bound", visibility_ = 0 : i64}> ({
      %4 = "rocdl.wave.id"() <{range = #llvm.constant_range<i32, 0, 4>}> : () -> i32
      %5 = "llvm.sext"(%4) : (i32) -> i64
      "llvm.return"(%5) : (i64) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 ()>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_subgroup_id_with_upper_bound", visibility_ = 0 : i64}> ({
      %3 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @subgroup_id_with_upper_bound, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> i64
      "llvm.return"(%3) : (i64) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 ()>, linkage = #llvm.linkage<external>, sym_name = "subgroup_id_with_workgroup_sizes", visibility_ = 0 : i64}> ({
      %1 = "rocdl.wave.id"() <{range = #llvm.constant_range<i32, 0, 4>}> : () -> i32
      %2 = "llvm.sext"(%1) : (i32) -> i64
      "llvm.return"(%2) : (i64) -> ()
    }) {gpu.known_block_size = array<i32: 64, 4, 1>, llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 ()>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_subgroup_id_with_workgroup_sizes", visibility_ = 0 : i64}> ({
      %0 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @subgroup_id_with_workgroup_sizes, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> i64
      "llvm.return"(%0) : (i64) -> ()
    }) {gpu.known_block_size = array<i32: 64, 4, 1>, llvm.emit_c_interface} : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

