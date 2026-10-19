"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(ptr, ptr, i64)> ()>, linkage = #llvm.linkage<external>, res_attrs = [{test.returnOne}], sym_name = "res_attrs_with_memref_return", visibility_ = 0 : i64}> ({
    %55 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    %56 = "builtin.unrealized_conversion_cast"(%55) : (memref<f32>) -> !llvm.struct<(ptr, ptr, i64)>
    "llvm.return"(%56) : (!llvm.struct<(ptr, ptr, i64)>) -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_res_attrs_with_memref_return", visibility_ = 0 : i64}> ({
  ^bb0(%arg26: !llvm.ptr):
    %54 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @res_attrs_with_memref_return, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.struct<(ptr, ptr, i64)>
    "llvm.store"(%54, %arg26) <{ordering = 0 : i64}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 ()>, linkage = #llvm.linkage<external>, res_attrs = [{test.returnOne = 1 : i64}], sym_name = "res_attrs_with_value_return", visibility_ = 0 : i64}> ({
    %53 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    "llvm.return"(%53) : (f32) -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 ()>, linkage = #llvm.linkage<external>, res_attrs = [{test.returnOne = 1 : i64}], sym_name = "_mlir_ciface_res_attrs_with_value_return", visibility_ = 0 : i64}> ({
    %52 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @res_attrs_with_value_return, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> f32
    "llvm.return"(%52) : (f32) -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(struct<(ptr, ptr, i64)>, f32)> ()>, linkage = #llvm.linkage<external>, sym_name = "multiple_return", visibility_ = 0 : i64}> ({
    %46 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    %47 = "builtin.unrealized_conversion_cast"(%46) : (memref<f32>) -> !llvm.struct<(ptr, ptr, i64)>
    %48 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %49 = "llvm.mlir.poison"() : () -> !llvm.struct<(struct<(ptr, ptr, i64)>, f32)>
    %50 = "llvm.insertvalue"(%49, %47) <{position = array<i64: 0>}> : (!llvm.struct<(struct<(ptr, ptr, i64)>, f32)>, !llvm.struct<(ptr, ptr, i64)>) -> !llvm.struct<(struct<(ptr, ptr, i64)>, f32)>
    %51 = "llvm.insertvalue"(%50, %48) <{position = array<i64: 1>}> : (!llvm.struct<(struct<(ptr, ptr, i64)>, f32)>, f32) -> !llvm.struct<(struct<(ptr, ptr, i64)>, f32)>
    "llvm.return"(%51) : (!llvm.struct<(struct<(ptr, ptr, i64)>, f32)>) -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_multiple_return", visibility_ = 0 : i64}> ({
  ^bb0(%arg25: !llvm.ptr):
    %45 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @multiple_return, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.struct<(struct<(ptr, ptr, i64)>, f32)>
    "llvm.store"(%45, %arg25) <{ordering = 0 : i64}> : (!llvm.struct<(struct<(ptr, ptr, i64)>, f32)>, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(struct<(ptr, ptr, i64)>, i64, f32)> ()>, linkage = #llvm.linkage<external>, sym_name = "multiple_return_missing_res_attr", visibility_ = 0 : i64}> ({
    %37 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    %38 = "builtin.unrealized_conversion_cast"(%37) : (memref<f32>) -> !llvm.struct<(ptr, ptr, i64)>
    %39 = "arith.constant"() <{value = 2 : i64}> : () -> i64
    %40 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %41 = "llvm.mlir.poison"() : () -> !llvm.struct<(struct<(ptr, ptr, i64)>, i64, f32)>
    %42 = "llvm.insertvalue"(%41, %38) <{position = array<i64: 0>}> : (!llvm.struct<(struct<(ptr, ptr, i64)>, i64, f32)>, !llvm.struct<(ptr, ptr, i64)>) -> !llvm.struct<(struct<(ptr, ptr, i64)>, i64, f32)>
    %43 = "llvm.insertvalue"(%42, %39) <{position = array<i64: 1>}> : (!llvm.struct<(struct<(ptr, ptr, i64)>, i64, f32)>, i64) -> !llvm.struct<(struct<(ptr, ptr, i64)>, i64, f32)>
    %44 = "llvm.insertvalue"(%43, %40) <{position = array<i64: 2>}> : (!llvm.struct<(struct<(ptr, ptr, i64)>, i64, f32)>, f32) -> !llvm.struct<(struct<(ptr, ptr, i64)>, i64, f32)>
    "llvm.return"(%44) : (!llvm.struct<(struct<(ptr, ptr, i64)>, i64, f32)>) -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_multiple_return_missing_res_attr", visibility_ = 0 : i64}> ({
  ^bb0(%arg24: !llvm.ptr):
    %36 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @multiple_return_missing_res_attr, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.struct<(struct<(ptr, ptr, i64)>, i64, f32)>
    "llvm.store"(%36, %arg24) <{ordering = 0 : i64}> : (!llvm.struct<(struct<(ptr, ptr, i64)>, i64, f32)>, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, arg_attrs = [{}, {}, {}], function_type = !llvm.func<struct<(ptr, ptr, i64)> (ptr, ptr, i64)>, linkage = #llvm.linkage<external>, sym_name = "one_arg_attr_no_res_attrs_with_memref_return", visibility_ = 0 : i64}> ({
  ^bb0(%arg21: !llvm.ptr, %arg22: !llvm.ptr, %arg23: i64):
    %34 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    %35 = "builtin.unrealized_conversion_cast"(%34) : (memref<f32>) -> !llvm.struct<(ptr, ptr, i64)>
    "llvm.return"(%35) : (!llvm.struct<(ptr, ptr, i64)>) -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, arg_attrs = [{}, {test.argOne = 1 : i64}], function_type = !llvm.func<void (ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_one_arg_attr_no_res_attrs_with_memref_return", visibility_ = 0 : i64}> ({
  ^bb0(%arg19: !llvm.ptr, %arg20: !llvm.ptr):
    %29 = "llvm.load"(%arg20) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %30 = "llvm.extractvalue"(%29) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
    %31 = "llvm.extractvalue"(%29) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
    %32 = "llvm.extractvalue"(%29) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>) -> i64
    %33 = "llvm.call"(%30, %31, %32) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @one_arg_attr_no_res_attrs_with_memref_return, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.struct<(ptr, ptr, i64)>
    "llvm.store"(%33, %arg19) <{ordering = 0 : i64}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, arg_attrs = [{}, {}, {}], function_type = !llvm.func<struct<(ptr, ptr, i64)> (ptr, ptr, i64)>, linkage = #llvm.linkage<external>, res_attrs = [{test.returnOne = 1 : i64}], sym_name = "one_arg_attr_one_res_attr_with_memref_return", visibility_ = 0 : i64}> ({
  ^bb0(%arg16: !llvm.ptr, %arg17: !llvm.ptr, %arg18: i64):
    %27 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    %28 = "builtin.unrealized_conversion_cast"(%27) : (memref<f32>) -> !llvm.struct<(ptr, ptr, i64)>
    "llvm.return"(%28) : (!llvm.struct<(ptr, ptr, i64)>) -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, arg_attrs = [{}, {test.argOne = 1 : i64}], function_type = !llvm.func<void (ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_one_arg_attr_one_res_attr_with_memref_return", visibility_ = 0 : i64}> ({
  ^bb0(%arg14: !llvm.ptr, %arg15: !llvm.ptr):
    %22 = "llvm.load"(%arg15) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %23 = "llvm.extractvalue"(%22) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
    %24 = "llvm.extractvalue"(%22) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
    %25 = "llvm.extractvalue"(%22) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>) -> i64
    %26 = "llvm.call"(%23, %24, %25) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @one_arg_attr_one_res_attr_with_memref_return, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.struct<(ptr, ptr, i64)>
    "llvm.store"(%26, %arg14) <{ordering = 0 : i64}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, arg_attrs = [{}, {}, {}], function_type = !llvm.func<f32 (ptr, ptr, i64)>, linkage = #llvm.linkage<external>, res_attrs = [{test.returnOne = 1 : i64}], sym_name = "one_arg_attr_one_res_attr_with_value_return", visibility_ = 0 : i64}> ({
  ^bb0(%arg11: !llvm.ptr, %arg12: !llvm.ptr, %arg13: i64):
    %21 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    "llvm.return"(%21) : (f32) -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, arg_attrs = [{test.argOne = 1 : i64}], function_type = !llvm.func<f32 (ptr)>, linkage = #llvm.linkage<external>, res_attrs = [{test.returnOne = 1 : i64}], sym_name = "_mlir_ciface_one_arg_attr_one_res_attr_with_value_return", visibility_ = 0 : i64}> ({
  ^bb0(%arg10: !llvm.ptr):
    %16 = "llvm.load"(%arg10) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %17 = "llvm.extractvalue"(%16) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
    %18 = "llvm.extractvalue"(%16) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
    %19 = "llvm.extractvalue"(%16) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>) -> i64
    %20 = "llvm.call"(%17, %18, %19) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @one_arg_attr_one_res_attr_with_value_return, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (!llvm.ptr, !llvm.ptr, i64) -> f32
    "llvm.return"(%20) : (f32) -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, arg_attrs = [{}, {}, {}, {}, {test.argTwo = 2 : i64}], function_type = !llvm.func<struct<(f32, struct<(ptr, ptr, i64)>, i32)> (ptr, ptr, i64, f32, i32)>, linkage = #llvm.linkage<external>, sym_name = "multiple_arg_attr_multiple_res_attr", visibility_ = 0 : i64}> ({
  ^bb0(%arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: i64, %arg8: f32, %arg9: i32):
    %8 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %9 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    %10 = "builtin.unrealized_conversion_cast"(%9) : (memref<i32>) -> !llvm.struct<(ptr, ptr, i64)>
    %11 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %12 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, struct<(ptr, ptr, i64)>, i32)>
    %13 = "llvm.insertvalue"(%12, %8) <{position = array<i64: 0>}> : (!llvm.struct<(f32, struct<(ptr, ptr, i64)>, i32)>, f32) -> !llvm.struct<(f32, struct<(ptr, ptr, i64)>, i32)>
    %14 = "llvm.insertvalue"(%13, %10) <{position = array<i64: 1>}> : (!llvm.struct<(f32, struct<(ptr, ptr, i64)>, i32)>, !llvm.struct<(ptr, ptr, i64)>) -> !llvm.struct<(f32, struct<(ptr, ptr, i64)>, i32)>
    %15 = "llvm.insertvalue"(%14, %11) <{position = array<i64: 2>}> : (!llvm.struct<(f32, struct<(ptr, ptr, i64)>, i32)>, i32) -> !llvm.struct<(f32, struct<(ptr, ptr, i64)>, i32)>
    "llvm.return"(%15) : (!llvm.struct<(f32, struct<(ptr, ptr, i64)>, i32)>) -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, arg_attrs = [{}, {test.argZero = 0 : i64}, {}, {test.argTwo = 2 : i64}], function_type = !llvm.func<void (ptr, ptr, f32, i32)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_multiple_arg_attr_multiple_res_attr", visibility_ = 0 : i64}> ({
  ^bb0(%arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: f32, %arg4: i32):
    %3 = "llvm.load"(%arg2) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %4 = "llvm.extractvalue"(%3) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
    %5 = "llvm.extractvalue"(%3) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
    %6 = "llvm.extractvalue"(%3) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>) -> i64
    %7 = "llvm.call"(%4, %5, %6, %arg3, %arg4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @multiple_arg_attr_multiple_res_attr, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 5, 0>}> : (!llvm.ptr, !llvm.ptr, i64, f32, i32) -> !llvm.struct<(f32, struct<(ptr, ptr, i64)>, i32)>
    "llvm.store"(%7, %arg1) <{ordering = 0 : i64}> : (!llvm.struct<(f32, struct<(ptr, ptr, i64)>, i32)>, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(ptr, ptr, i64)> ()>, linkage = #llvm.linkage<external>, res_attrs = [{test.returnOne}], sym_name = "drop_linkage_attr", visibility_ = 0 : i64}> ({
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (memref<f32>) -> !llvm.struct<(ptr, ptr, i64)>
    "llvm.return"(%2) : (!llvm.struct<(ptr, ptr, i64)>) -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_drop_linkage_attr", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @drop_linkage_attr, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.struct<(ptr, ptr, i64)>
    "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
}) : () -> ()

