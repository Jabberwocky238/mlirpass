"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(ptr, ptr, i64)> ()>, linkage = #llvm.linkage<private>, res_attrs = [{test.returnOne}], sym_name = "res_attrs_with_memref_return", sym_visibility = "private", visibility_ = 0 : i64}> ({
    %44 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %45 = "llvm.alloca"(%44) <{elem_type = !llvm.struct<(ptr, ptr, i64)>}> : (i64) -> !llvm.ptr
    "llvm.call"(%45) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_mlir_ciface_res_attrs_with_memref_return, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    %46 = "llvm.load"(%45) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    "llvm.return"(%46) : (!llvm.struct<(ptr, ptr, i64)>) -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_res_attrs_with_memref_return", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 ()>, linkage = #llvm.linkage<private>, res_attrs = [{test.returnOne = 1 : i64}], sym_name = "res_attrs_with_value_return", sym_visibility = "private", visibility_ = 0 : i64}> ({
    %43 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_mlir_ciface_res_attrs_with_value_return, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> f32
    "llvm.return"(%43) : (f32) -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 ()>, linkage = #llvm.linkage<external>, res_attrs = [{test.returnOne = 1 : i64}], sym_name = "_mlir_ciface_res_attrs_with_value_return", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(struct<(ptr, ptr, i64)>, f32)> ()>, linkage = #llvm.linkage<private>, sym_name = "multiple_return", sym_visibility = "private", visibility_ = 0 : i64}> ({
    %40 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %41 = "llvm.alloca"(%40) <{elem_type = !llvm.struct<(struct<(ptr, ptr, i64)>, f32)>}> : (i64) -> !llvm.ptr
    "llvm.call"(%41) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_mlir_ciface_multiple_return, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    %42 = "llvm.load"(%41) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.struct<(struct<(ptr, ptr, i64)>, f32)>
    "llvm.return"(%42) : (!llvm.struct<(struct<(ptr, ptr, i64)>, f32)>) -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_multiple_return", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(struct<(ptr, ptr, i64)>, i64, f32)> ()>, linkage = #llvm.linkage<private>, sym_name = "multiple_return_missing_res_attr", sym_visibility = "private", visibility_ = 0 : i64}> ({
    %37 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %38 = "llvm.alloca"(%37) <{elem_type = !llvm.struct<(struct<(ptr, ptr, i64)>, i64, f32)>}> : (i64) -> !llvm.ptr
    "llvm.call"(%38) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_mlir_ciface_multiple_return_missing_res_attr, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    %39 = "llvm.load"(%38) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.struct<(struct<(ptr, ptr, i64)>, i64, f32)>
    "llvm.return"(%39) : (!llvm.struct<(struct<(ptr, ptr, i64)>, i64, f32)>) -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_multiple_return_missing_res_attr", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, arg_attrs = [{}, {}, {}], function_type = !llvm.func<struct<(ptr, ptr, i64)> (ptr, ptr, i64)>, linkage = #llvm.linkage<private>, sym_name = "one_arg_attr_no_res_attrs_with_memref_return", sym_visibility = "private", visibility_ = 0 : i64}> ({
  ^bb0(%arg11: !llvm.ptr, %arg12: !llvm.ptr, %arg13: i64):
    %28 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %29 = "llvm.alloca"(%28) <{elem_type = !llvm.struct<(ptr, ptr, i64)>}> : (i64) -> !llvm.ptr
    %30 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %31 = "llvm.insertvalue"(%30, %arg11) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %32 = "llvm.insertvalue"(%31, %arg12) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %33 = "llvm.insertvalue"(%32, %arg13) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
    %34 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %35 = "llvm.alloca"(%34) <{elem_type = !llvm.struct<(ptr, ptr, i64)>}> : (i64) -> !llvm.ptr
    "llvm.store"(%33, %35) <{ordering = 0 : i64}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> ()
    "llvm.call"(%29, %35) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_mlir_ciface_one_arg_attr_no_res_attrs_with_memref_return, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> ()
    %36 = "llvm.load"(%29) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    "llvm.return"(%36) : (!llvm.struct<(ptr, ptr, i64)>) -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, arg_attrs = [{}, {test.argOne = 1 : i64}], function_type = !llvm.func<void (ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_one_arg_attr_no_res_attrs_with_memref_return", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, arg_attrs = [{}, {}, {}], function_type = !llvm.func<struct<(ptr, ptr, i64)> (ptr, ptr, i64)>, linkage = #llvm.linkage<private>, res_attrs = [{test.returnOne = 1 : i64}], sym_name = "one_arg_attr_one_res_attr_with_memref_return", sym_visibility = "private", visibility_ = 0 : i64}> ({
  ^bb0(%arg8: !llvm.ptr, %arg9: !llvm.ptr, %arg10: i64):
    %19 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %20 = "llvm.alloca"(%19) <{elem_type = !llvm.struct<(ptr, ptr, i64)>}> : (i64) -> !llvm.ptr
    %21 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %22 = "llvm.insertvalue"(%21, %arg8) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %23 = "llvm.insertvalue"(%22, %arg9) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %24 = "llvm.insertvalue"(%23, %arg10) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
    %25 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %26 = "llvm.alloca"(%25) <{elem_type = !llvm.struct<(ptr, ptr, i64)>}> : (i64) -> !llvm.ptr
    "llvm.store"(%24, %26) <{ordering = 0 : i64}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> ()
    "llvm.call"(%20, %26) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_mlir_ciface_one_arg_attr_one_res_attr_with_memref_return, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> ()
    %27 = "llvm.load"(%20) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    "llvm.return"(%27) : (!llvm.struct<(ptr, ptr, i64)>) -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, arg_attrs = [{}, {test.argOne = 1 : i64}], function_type = !llvm.func<void (ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_one_arg_attr_one_res_attr_with_memref_return", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, arg_attrs = [{}, {}, {}], function_type = !llvm.func<f32 (ptr, ptr, i64)>, linkage = #llvm.linkage<private>, res_attrs = [{test.returnOne = 1 : i64}], sym_name = "one_arg_attr_one_res_attr_with_value_return", sym_visibility = "private", visibility_ = 0 : i64}> ({
  ^bb0(%arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: i64):
    %12 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %13 = "llvm.insertvalue"(%12, %arg5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %14 = "llvm.insertvalue"(%13, %arg6) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %15 = "llvm.insertvalue"(%14, %arg7) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
    %16 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %17 = "llvm.alloca"(%16) <{elem_type = !llvm.struct<(ptr, ptr, i64)>}> : (i64) -> !llvm.ptr
    "llvm.store"(%15, %17) <{ordering = 0 : i64}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> ()
    %18 = "llvm.call"(%17) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_mlir_ciface_one_arg_attr_one_res_attr_with_value_return, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> f32
    "llvm.return"(%18) : (f32) -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, arg_attrs = [{test.argOne = 1 : i64}], function_type = !llvm.func<f32 (ptr)>, linkage = #llvm.linkage<external>, res_attrs = [{test.returnOne = 1 : i64}], sym_name = "_mlir_ciface_one_arg_attr_one_res_attr_with_value_return", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, arg_attrs = [{}, {}, {}, {}, {test.argTwo = 2 : i64}], function_type = !llvm.func<struct<(f32, struct<(ptr, ptr, i64)>, i32)> (ptr, ptr, i64, f32, i32)>, linkage = #llvm.linkage<private>, sym_name = "multiple_arg_attr_multiple_res_attr", sym_visibility = "private", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: f32, %arg4: i32):
    %3 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %4 = "llvm.alloca"(%3) <{elem_type = !llvm.struct<(f32, struct<(ptr, ptr, i64)>, i32)>}> : (i64) -> !llvm.ptr
    %5 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %6 = "llvm.insertvalue"(%5, %arg0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %7 = "llvm.insertvalue"(%6, %arg1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %8 = "llvm.insertvalue"(%7, %arg2) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
    %9 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %10 = "llvm.alloca"(%9) <{elem_type = !llvm.struct<(ptr, ptr, i64)>}> : (i64) -> !llvm.ptr
    "llvm.store"(%8, %10) <{ordering = 0 : i64}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> ()
    "llvm.call"(%4, %10, %arg3, %arg4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_mlir_ciface_multiple_arg_attr_multiple_res_attr, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>}> : (!llvm.ptr, !llvm.ptr, f32, i32) -> ()
    %11 = "llvm.load"(%4) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.struct<(f32, struct<(ptr, ptr, i64)>, i32)>
    "llvm.return"(%11) : (!llvm.struct<(f32, struct<(ptr, ptr, i64)>, i32)>) -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, arg_attrs = [{}, {test.argZero = 0 : i64}, {}, {test.argTwo = 2 : i64}], function_type = !llvm.func<void (ptr, ptr, f32, i32)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_multiple_arg_attr_multiple_res_attr", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(ptr, ptr, i64)> ()>, linkage = #llvm.linkage<private>, res_attrs = [{test.returnOne}], sym_name = "drop_linkage_attr", sym_visibility = "private", visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.struct<(ptr, ptr, i64)>}> : (i64) -> !llvm.ptr
    "llvm.call"(%1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_mlir_ciface_drop_linkage_attr, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    %2 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    "llvm.return"(%2) : (!llvm.struct<(ptr, ptr, i64)>) -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_drop_linkage_attr", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) {llvm.emit_c_interface} : () -> ()
}) : () -> ()

