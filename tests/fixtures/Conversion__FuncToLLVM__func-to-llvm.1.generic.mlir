"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "empty", visibility_ = 0 : i64}> ({
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "body", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "simple_loop", visibility_ = 0 : i64}> ({
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %71 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i32
    %72 = "llvm.mlir.constant"() <{value = 42 : index}> : () -> i32
    "llvm.br"(%71)[^bb2] : (i32) -> ()
  ^bb2(%73: i32):  // 2 preds: ^bb1, ^bb3
    %74 = "llvm.icmp"(%73, %72) <{predicate = 2 : i64}> : (i32, i32) -> i1
    "llvm.cond_br"(%74)[^bb3, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    "llvm.call"(%73) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @body, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i32) -> ()
    %75 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i32
    %76 = "llvm.add"(%73, %75) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.br"(%76)[^bb2] : (i32) -> ()
  ^bb4:  // pred: ^bb2
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "simple_caller", visibility_ = 0 : i64}> ({
    "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @simple_loop, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "call_with_attributes", visibility_ = 0 : i64}> ({
    "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @simple_loop, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> {baz = [1, 2, 3, 4], foo = "bar"} : () -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "ml_caller", visibility_ = 0 : i64}> ({
    "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @simple_loop, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
    "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @more_imperfectly_nested_loops, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "body_args", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "other", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "func_args", visibility_ = 0 : i64}> ({
  ^bb0(%arg10: i32, %arg11: i32):
    %58 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %59 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i32
    %60 = "llvm.mlir.constant"() <{value = 42 : index}> : () -> i32
    "llvm.br"(%59)[^bb2] : (i32) -> ()
  ^bb2(%61: i32):  // 2 preds: ^bb1, ^bb3
    %62 = "llvm.icmp"(%61, %60) <{predicate = 2 : i64}> : (i32, i32) -> i1
    "llvm.cond_br"(%62)[^bb3, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    %63 = "llvm.call"(%61) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @body_args, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i32) -> i32
    %64 = "llvm.call"(%63, %arg10) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @other, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i32, i32) -> i32
    %65 = "llvm.call"(%63, %64) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @other, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i32, i32) -> i32
    %66 = "llvm.call"(%63, %arg11) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @other, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i32, i32) -> i32
    %67 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i32
    %68 = "llvm.add"(%61, %67) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.br"(%68)[^bb2] : (i32) -> ()
  ^bb4:  // pred: ^bb2
    %69 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i32
    %70 = "llvm.call"(%69, %58) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @other, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i32, i32) -> i32
    "llvm.return"(%70) : (i32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "pre", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "body2", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "post", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "imperfectly_nested_loops", visibility_ = 0 : i64}> ({
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %46 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i32
    %47 = "llvm.mlir.constant"() <{value = 42 : index}> : () -> i32
    "llvm.br"(%46)[^bb2] : (i32) -> ()
  ^bb2(%48: i32):  // 2 preds: ^bb1, ^bb7
    %49 = "llvm.icmp"(%48, %47) <{predicate = 2 : i64}> : (i32, i32) -> i1
    "llvm.cond_br"(%49)[^bb3, ^bb8] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    "llvm.call"(%48) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @pre, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i32) -> ()
    "llvm.br"()[^bb4] : () -> ()
  ^bb4:  // pred: ^bb3
    %50 = "llvm.mlir.constant"() <{value = 7 : index}> : () -> i32
    %51 = "llvm.mlir.constant"() <{value = 56 : index}> : () -> i32
    "llvm.br"(%50)[^bb5] : (i32) -> ()
  ^bb5(%52: i32):  // 2 preds: ^bb4, ^bb6
    %53 = "llvm.icmp"(%52, %51) <{predicate = 2 : i64}> : (i32, i32) -> i1
    "llvm.cond_br"(%53)[^bb6, ^bb7] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb6:  // pred: ^bb5
    "llvm.call"(%48, %52) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @body2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i32, i32) -> ()
    %54 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i32
    %55 = "llvm.add"(%52, %54) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.br"(%55)[^bb5] : (i32) -> ()
  ^bb7:  // pred: ^bb5
    "llvm.call"(%48) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @post, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i32) -> ()
    %56 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i32
    %57 = "llvm.add"(%48, %56) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.br"(%57)[^bb2] : (i32) -> ()
  ^bb8:  // pred: ^bb2
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "mid", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "body3", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "more_imperfectly_nested_loops", visibility_ = 0 : i64}> ({
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %28 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i32
    %29 = "llvm.mlir.constant"() <{value = 42 : index}> : () -> i32
    "llvm.br"(%28)[^bb2] : (i32) -> ()
  ^bb2(%30: i32):  // 2 preds: ^bb1, ^bb11
    %31 = "llvm.icmp"(%30, %29) <{predicate = 2 : i64}> : (i32, i32) -> i1
    "llvm.cond_br"(%31)[^bb3, ^bb12] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    "llvm.call"(%30) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @pre, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i32) -> ()
    "llvm.br"()[^bb4] : () -> ()
  ^bb4:  // pred: ^bb3
    %32 = "llvm.mlir.constant"() <{value = 7 : index}> : () -> i32
    %33 = "llvm.mlir.constant"() <{value = 56 : index}> : () -> i32
    "llvm.br"(%32)[^bb5] : (i32) -> ()
  ^bb5(%34: i32):  // 2 preds: ^bb4, ^bb6
    %35 = "llvm.icmp"(%34, %33) <{predicate = 2 : i64}> : (i32, i32) -> i1
    "llvm.cond_br"(%35)[^bb6, ^bb7] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb6:  // pred: ^bb5
    "llvm.call"(%30, %34) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @body2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i32, i32) -> ()
    %36 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i32
    %37 = "llvm.add"(%34, %36) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.br"(%37)[^bb5] : (i32) -> ()
  ^bb7:  // pred: ^bb5
    "llvm.call"(%30) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mid, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i32) -> ()
    "llvm.br"()[^bb8] : () -> ()
  ^bb8:  // pred: ^bb7
    %38 = "llvm.mlir.constant"() <{value = 18 : index}> : () -> i32
    %39 = "llvm.mlir.constant"() <{value = 37 : index}> : () -> i32
    "llvm.br"(%38)[^bb9] : (i32) -> ()
  ^bb9(%40: i32):  // 2 preds: ^bb8, ^bb10
    %41 = "llvm.icmp"(%40, %39) <{predicate = 2 : i64}> : (i32, i32) -> i1
    "llvm.cond_br"(%41)[^bb10, ^bb11] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb10:  // pred: ^bb9
    "llvm.call"(%30, %40) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @body3, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i32, i32) -> ()
    %42 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i32
    %43 = "llvm.add"(%40, %42) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.br"(%43)[^bb9] : (i32) -> ()
  ^bb11:  // pred: ^bb9
    "llvm.call"(%30) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @post, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i32) -> ()
    %44 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i32
    %45 = "llvm.add"(%30, %44) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.br"(%45)[^bb2] : (i32) -> ()
  ^bb12:  // pred: ^bb2
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 ()>, linkage = #llvm.linkage<external>, sym_name = "get_i64", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 ()>, linkage = #llvm.linkage<external>, sym_name = "get_f32", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f16, f16)> ()>, linkage = #llvm.linkage<external>, sym_name = "get_c16", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f32)> ()>, linkage = #llvm.linkage<external>, sym_name = "get_c32", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f64, f64)> ()>, linkage = #llvm.linkage<external>, sym_name = "get_c64", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)> ()>, linkage = #llvm.linkage<external>, sym_name = "get_memref", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(i64, f32, struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)>)> ()>, linkage = #llvm.linkage<external>, sym_name = "multireturn", visibility_ = 0 : i64}> ({
    %21 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @get_i64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> i64
    %22 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @get_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> f32
    %23 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @get_memref, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)>
    %24 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, f32, struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)>)>
    %25 = "llvm.insertvalue"(%24, %21) <{position = array<i64: 0>}> : (!llvm.struct<(i64, f32, struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)>)>, i64) -> !llvm.struct<(i64, f32, struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)>)>
    %26 = "llvm.insertvalue"(%25, %22) <{position = array<i64: 1>}> : (!llvm.struct<(i64, f32, struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)>)>, f32) -> !llvm.struct<(i64, f32, struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)>)>
    %27 = "llvm.insertvalue"(%26, %23) <{position = array<i64: 2>}> : (!llvm.struct<(i64, f32, struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)>)>, !llvm.struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)>) -> !llvm.struct<(i64, f32, struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)>)>
    "llvm.return"(%27) : (!llvm.struct<(i64, f32, struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)>)>) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "multireturn_caller", visibility_ = 0 : i64}> ({
    %12 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @multireturn, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.struct<(i64, f32, struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)>)>
    %13 = "llvm.extractvalue"(%12) <{position = array<i64: 0>}> : (!llvm.struct<(i64, f32, struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)>)>) -> i64
    %14 = "llvm.extractvalue"(%12) <{position = array<i64: 1>}> : (!llvm.struct<(i64, f32, struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)>)>) -> f32
    %15 = "llvm.extractvalue"(%12) <{position = array<i64: 2>}> : (!llvm.struct<(i64, f32, struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)>)>) -> !llvm.struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)>
    %16 = "llvm.mlir.constant"() <{value = 42 : i64}> : () -> i64
    %17 = "llvm.add"(%13, %16) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %18 = "llvm.mlir.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
    %19 = "llvm.fadd"(%14, %18) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %20 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "dfs_block_order", visibility_ = 0 : i64}> ({
  ^bb0(%arg9: i32):
    %10 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
    "llvm.br"()[^bb2] : () -> ()
  ^bb1:  // pred: ^bb2
    %11 = "llvm.add"(%arg9, %10) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.return"(%11) : (i32) -> ()
  ^bb2:  // pred: ^bb0
    "llvm.br"()[^bb1] : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32)>, linkage = #llvm.linkage<external>, sym_name = "ceilf", visibility_ = 0 : i64}> ({
  ^bb0(%arg8: f32):
    %9 = "llvm.intr.ceil"(%arg8) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32)>, linkage = #llvm.linkage<external>, sym_name = "floorf", visibility_ = 0 : i64}> ({
  ^bb0(%arg7: f32):
    %8 = "llvm.intr.floor"(%arg7) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "abort", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "puts", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.mlir.global"() <{addr_space = 0 : i32, constant, global_type = !llvm.array<17 x i8>, linkage = #llvm.linkage<private>, sym_name = "assert_msg", value = dense<[67, 111, 109, 112, 117, 116, 101, 114, 32, 115, 97, 121, 115, 32, 110, 111, 0]> : tensor<17xi8>, visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i1)>, linkage = #llvm.linkage<external>, sym_name = "assert_test_function", visibility_ = 0 : i64}> ({
    ^bb0(%arg6: i1):
      "llvm.cond_br"(%arg6)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "llvm.return"() : () -> ()
    ^bb2:  // pred: ^bb0
      %6 = "llvm.mlir.addressof"() <{global_name = @assert_msg}> : () -> !llvm.ptr
      %7 = "llvm.getelementptr"(%6) <{elem_type = !llvm.array<17 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0>}> : (!llvm.ptr) -> !llvm.ptr
      "llvm.call"(%7) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @puts, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
      "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @abort, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
      "llvm.unreachable"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "call_zero_result_func", visibility_ = 0 : i64}> ({
    "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @zero_result_func, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "zero_result_func", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<4xf32>)>, linkage = #llvm.linkage<external>, sym_name = "fmaf", visibility_ = 0 : i64}> ({
  ^bb0(%arg4: f32, %arg5: vector<4xf32>):
    %4 = "llvm.intr.fma"(%arg4, %arg4, %arg4) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32, f32) -> f32
    %5 = "llvm.intr.fma"(%arg5, %arg5, %arg5) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i8)>, linkage = #llvm.linkage<external>, sym_name = "switchi8", visibility_ = 0 : i64}> ({
  ^bb0(%arg3: i8):
    "llvm.switch"(%arg3)[^bb1, ^bb1, ^bb2] <{case_operand_segments = array<i32: 0, 0>, case_values = dense<[42, 43]> : vector<2xi8>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i8) -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb0
    %2 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    "llvm.return"(%2) : (i32) -> ()
  ^bb2:  // pred: ^bb0
    %3 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "index_arg", visibility_ = 0 : i64}> ({
  ^bb0(%arg2: i32):
    "llvm.br"(%arg2)[^bb1] : (i32) -> ()
  ^bb1(%1: i32):  // pred: ^bb0
    "llvm.return"(%1) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xtf32>) -> (), sym_name = "non_convertible_arg_type"}> ({
  ^bb0(%arg1: vector<1xtf32>):
    "llvm.return"() : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_conversion_patterns"(%0) <{legal_dialects = ["llvm"], partial_conversion}> ({
        "transform.apply_conversion_patterns.dialect_to_llvm"() <{dialect_name = "math"}> : () -> ()
        "transform.apply_conversion_patterns.dialect_to_llvm"() <{dialect_name = "arith"}> : () -> ()
        "transform.apply_conversion_patterns.dialect_to_llvm"() <{dialect_name = "cf"}> : () -> ()
        "transform.apply_conversion_patterns.func.func_to_llvm"() : () -> ()
      }, {
        "transform.apply_conversion_patterns.memref.memref_to_llvm_type_converter"() <{index_bitwidth = 32 : i64}> {use_opaque_pointers = true} : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

