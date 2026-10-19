"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, arg_attrs = [{}, {}, {}, {}, {}, {}, {}, {}, {}, {}], function_type = !llvm.func<void (ptr, ptr, i32, i32, i32, ptr, ptr, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "check_noalias", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: i32, %arg8: i32, %arg9: i32):
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, i32, i32, i32, i32, i32, ptr, ptr, i32, i32, i32, i32, i32, ptr, ptr, i32, i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "check_strided_memref_arguments", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: !llvm.ptr, %arg8: !llvm.ptr, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: !llvm.ptr, %arg15: !llvm.ptr, %arg16: i32, %arg17: i32, %arg18: i32, %arg19: i32, %arg20: i32):
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> (ptr, ptr, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "memref_index", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32, %arg3: i32, %arg4: i32):
    %0 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    %1 = "llvm.insertvalue"(%0, %arg0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    %2 = "llvm.insertvalue"(%1, %arg1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    %3 = "llvm.insertvalue"(%2, %arg2) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    %4 = "llvm.insertvalue"(%3, %arg3) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    %5 = "llvm.insertvalue"(%4, %arg4) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    "llvm.return"(%5) : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, i32, i32, i32, i32, i32, ptr, ptr, i32, i32, i32, i32, i32, ptr, ptr, i32, i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "check_arguments", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: !llvm.ptr, %arg8: !llvm.ptr, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: !llvm.ptr, %arg15: !llvm.ptr, %arg16: i32, %arg17: i32, %arg18: i32, %arg19: i32, %arg20: i32):
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i32)>, linkage = #llvm.linkage<external>, sym_name = "malloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "free", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(i32, ptr)> (i32, ptr)>, linkage = #llvm.linkage<external>, sym_name = "hoo", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(i32, ptr)> (i32, ptr)>, linkage = #llvm.linkage<external>, sym_name = "check_unranked_memref_func_call", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i32, %arg1: !llvm.ptr):
    %0 = "llvm.mlir.poison"() : () -> !llvm.struct<(i32, ptr)>
    %1 = "llvm.insertvalue"(%0, %arg0) <{position = array<i64: 0>}> : (!llvm.struct<(i32, ptr)>, i32) -> !llvm.struct<(i32, ptr)>
    %2 = "llvm.insertvalue"(%1, %arg1) <{position = array<i64: 1>}> : (!llvm.struct<(i32, ptr)>, !llvm.ptr) -> !llvm.struct<(i32, ptr)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 0>}> : (!llvm.struct<(i32, ptr)>) -> i32
    %4 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(i32, ptr)>) -> !llvm.ptr
    %5 = "llvm.call"(%3, %4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @hoo, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i32, !llvm.ptr) -> !llvm.struct<(i32, ptr)>
    %6 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i32
    %7 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i32
    %8 = "llvm.mlir.constant"() <{value = 4 : index}> : () -> i32
    %9 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i32
    %10 = "llvm.mul"(%7, %9) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %11 = "llvm.extractvalue"(%5) <{position = array<i64: 0>}> : (!llvm.struct<(i32, ptr)>) -> i32
    %12 = "llvm.mul"(%7, %11) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %13 = "llvm.add"(%12, %6) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %14 = "llvm.mul"(%13, %8) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %15 = "llvm.add"(%10, %14) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %16 = "llvm.alloca"(%15) <{elem_type = i8}> : (i32) -> !llvm.ptr
    %17 = "llvm.extractvalue"(%5) <{position = array<i64: 1>}> : (!llvm.struct<(i32, ptr)>) -> !llvm.ptr
    "llvm.intr.memcpy"(%16, %17, %15) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    "llvm.call"(%17) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    %18 = "llvm.mlir.poison"() : () -> !llvm.struct<(i32, ptr)>
    %19 = "llvm.extractvalue"(%5) <{position = array<i64: 0>}> : (!llvm.struct<(i32, ptr)>) -> i32
    %20 = "llvm.insertvalue"(%18, %19) <{position = array<i64: 0>}> : (!llvm.struct<(i32, ptr)>, i32) -> !llvm.struct<(i32, ptr)>
    %21 = "llvm.insertvalue"(%20, %16) <{position = array<i64: 1>}> : (!llvm.struct<(i32, ptr)>, !llvm.ptr) -> !llvm.struct<(i32, ptr)>
    %22 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i32
    %23 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i32
    %24 = "llvm.mlir.constant"() <{value = 4 : index}> : () -> i32
    %25 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i32
    %26 = "llvm.mul"(%23, %25) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %27 = "llvm.extractvalue"(%21) <{position = array<i64: 0>}> : (!llvm.struct<(i32, ptr)>) -> i32
    %28 = "llvm.mul"(%23, %27) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %29 = "llvm.add"(%28, %22) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %30 = "llvm.mul"(%29, %24) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %31 = "llvm.add"(%26, %30) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %32 = "llvm.call"(%31) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i32) -> !llvm.ptr
    %33 = "llvm.extractvalue"(%21) <{position = array<i64: 1>}> : (!llvm.struct<(i32, ptr)>) -> !llvm.ptr
    "llvm.intr.memcpy"(%32, %33, %31) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %34 = "llvm.mlir.poison"() : () -> !llvm.struct<(i32, ptr)>
    %35 = "llvm.extractvalue"(%21) <{position = array<i64: 0>}> : (!llvm.struct<(i32, ptr)>) -> i32
    %36 = "llvm.insertvalue"(%34, %35) <{position = array<i64: 0>}> : (!llvm.struct<(i32, ptr)>, i32) -> !llvm.struct<(i32, ptr)>
    %37 = "llvm.insertvalue"(%36, %32) <{position = array<i64: 1>}> : (!llvm.struct<(i32, ptr)>, !llvm.ptr) -> !llvm.struct<(i32, ptr)>
    "llvm.return"(%37) : (!llvm.struct<(i32, ptr)>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<42x!test.memref_element>, sym_name = "unsupported_memref_element_type", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<*x!test.memref_element>, sym_name = "unsupported_unranked_memref_element_type", sym_visibility = "private"}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "goo", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32)>, linkage = #llvm.linkage<external>, sym_name = "check_scalar_func_call", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @goo, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>, struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>)> (i32, i32, i32, ptr<201>, ptr<201>, i32, i32, i32, ptr<201>, ptr<201>, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "loop_carried", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr<201>, %arg4: !llvm.ptr<201>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: !llvm.ptr<201>, %arg9: !llvm.ptr<201>, %arg10: i32, %arg11: i32, %arg12: i32):
    %0 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>
    %1 = "llvm.insertvalue"(%0, %arg8) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr<201>) -> !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>
    %2 = "llvm.insertvalue"(%1, %arg9) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr<201>) -> !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>
    %3 = "llvm.insertvalue"(%2, %arg10) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>
    %4 = "llvm.insertvalue"(%3, %arg11) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>
    %5 = "llvm.insertvalue"(%4, %arg12) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>
    %6 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>
    %7 = "llvm.insertvalue"(%6, %arg3) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr<201>) -> !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>
    %8 = "llvm.insertvalue"(%7, %arg4) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr<201>) -> !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>
    %9 = "llvm.insertvalue"(%8, %arg5) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>
    %10 = "llvm.insertvalue"(%9, %arg6) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>
    %11 = "llvm.insertvalue"(%10, %arg7) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>
    "llvm.br"(%arg0, %11, %5)[^bb1] : (i32, !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>, !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>) -> ()
  ^bb1(%12: i32, %13: !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>, %14: !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>):  // 2 preds: ^bb0, ^bb2
    %15 = "llvm.icmp"(%12, %arg1) <{predicate = 2 : i64}> : (i32, i32) -> i1
    "llvm.cond_br"(%15)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %16 = "llvm.add"(%12, %arg2) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.br"(%16, %14, %13)[^bb1] : (i32, !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>, !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>) -> ()
  ^bb3:  // pred: ^bb1
    %17 = "llvm.mlir.poison"() : () -> !llvm.struct<(struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>, struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>)>
    %18 = "llvm.insertvalue"(%17, %13) <{position = array<i64: 0>}> : (!llvm.struct<(struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>, struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>)>, !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>) -> !llvm.struct<(struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>, struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>)>
    %19 = "llvm.insertvalue"(%18, %14) <{position = array<i64: 1>}> : (!llvm.struct<(struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>, struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>)>, !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>) -> !llvm.struct<(struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>, struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>)>
    "llvm.return"(%19) : (!llvm.struct<(struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>, struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>)>) -> ()
  }) : () -> ()
}) : () -> ()

