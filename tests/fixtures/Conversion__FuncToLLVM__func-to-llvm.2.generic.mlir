"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "empty", visibility_ = 0 : i64}> ({
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "body", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "simple_loop", visibility_ = 0 : i64}> ({
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %95 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %96 = "builtin.unrealized_conversion_cast"(%95) : (i64) -> index
    %97 = "llvm.mlir.constant"() <{value = 42 : index}> : () -> i64
    "cf.br"(%96)[^bb2] : (index) -> ()
  ^bb2(%98: index):  // 2 preds: ^bb1, ^bb3
    %99 = "builtin.unrealized_conversion_cast"(%98) : (index) -> i64
    %100 = "builtin.unrealized_conversion_cast"(%98) : (index) -> i64
    %101 = "llvm.icmp"(%100, %97) <{predicate = 2 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%101)[^bb3, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    "llvm.call"(%99) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @body, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    %102 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %103 = "llvm.add"(%100, %102) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %104 = "builtin.unrealized_conversion_cast"(%103) : (i64) -> index
    "cf.br"(%104)[^bb2] : (index) -> ()
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
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64)>, linkage = #llvm.linkage<external>, sym_name = "body_args", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i64, i32)>, linkage = #llvm.linkage<external>, sym_name = "other", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "func_args", visibility_ = 0 : i64}> ({
  ^bb0(%arg10: i32, %arg11: i32):
    %78 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %79 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %80 = "builtin.unrealized_conversion_cast"(%79) : (i64) -> index
    %81 = "llvm.mlir.constant"() <{value = 42 : index}> : () -> i64
    "cf.br"(%80)[^bb2] : (index) -> ()
  ^bb2(%82: index):  // 2 preds: ^bb1, ^bb3
    %83 = "builtin.unrealized_conversion_cast"(%82) : (index) -> i64
    %84 = "builtin.unrealized_conversion_cast"(%82) : (index) -> i64
    %85 = "llvm.icmp"(%84, %81) <{predicate = 2 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%85)[^bb3, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    %86 = "llvm.call"(%83) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @body_args, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> i64
    %87 = "llvm.call"(%86, %arg10) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @other, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i32) -> i32
    %88 = "llvm.call"(%86, %87) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @other, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i32) -> i32
    %89 = "llvm.call"(%86, %arg11) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @other, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i32) -> i32
    %90 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %91 = "llvm.add"(%84, %90) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %92 = "builtin.unrealized_conversion_cast"(%91) : (i64) -> index
    "cf.br"(%92)[^bb2] : (index) -> ()
  ^bb4:  // pred: ^bb2
    %93 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %94 = "llvm.call"(%93, %78) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @other, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i32) -> i32
    "llvm.return"(%94) : (i32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "pre", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "body2", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "post", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "imperfectly_nested_loops", visibility_ = 0 : i64}> ({
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %58 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %59 = "builtin.unrealized_conversion_cast"(%58) : (i64) -> index
    %60 = "llvm.mlir.constant"() <{value = 42 : index}> : () -> i64
    "cf.br"(%59)[^bb2] : (index) -> ()
  ^bb2(%61: index):  // 2 preds: ^bb1, ^bb7
    %62 = "builtin.unrealized_conversion_cast"(%61) : (index) -> i64
    %63 = "builtin.unrealized_conversion_cast"(%61) : (index) -> i64
    %64 = "llvm.icmp"(%63, %60) <{predicate = 2 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%64)[^bb3, ^bb8] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    "llvm.call"(%62) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @pre, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "cf.br"()[^bb4] : () -> ()
  ^bb4:  // pred: ^bb3
    %65 = "llvm.mlir.constant"() <{value = 7 : index}> : () -> i64
    %66 = "builtin.unrealized_conversion_cast"(%65) : (i64) -> index
    %67 = "llvm.mlir.constant"() <{value = 56 : index}> : () -> i64
    "cf.br"(%66)[^bb5] : (index) -> ()
  ^bb5(%68: index):  // 2 preds: ^bb4, ^bb6
    %69 = "builtin.unrealized_conversion_cast"(%68) : (index) -> i64
    %70 = "builtin.unrealized_conversion_cast"(%68) : (index) -> i64
    %71 = "llvm.icmp"(%70, %67) <{predicate = 2 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%71)[^bb6, ^bb7] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb6:  // pred: ^bb5
    "llvm.call"(%62, %69) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @body2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> ()
    %72 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %73 = "llvm.add"(%70, %72) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %74 = "builtin.unrealized_conversion_cast"(%73) : (i64) -> index
    "cf.br"(%74)[^bb5] : (index) -> ()
  ^bb7:  // pred: ^bb5
    "llvm.call"(%62) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @post, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    %75 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %76 = "llvm.add"(%63, %75) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %77 = "builtin.unrealized_conversion_cast"(%76) : (i64) -> index
    "cf.br"(%77)[^bb2] : (index) -> ()
  ^bb8:  // pred: ^bb2
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "mid", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "body3", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "more_imperfectly_nested_loops", visibility_ = 0 : i64}> ({
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %28 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %29 = "builtin.unrealized_conversion_cast"(%28) : (i64) -> index
    %30 = "llvm.mlir.constant"() <{value = 42 : index}> : () -> i64
    "cf.br"(%29)[^bb2] : (index) -> ()
  ^bb2(%31: index):  // 2 preds: ^bb1, ^bb11
    %32 = "builtin.unrealized_conversion_cast"(%31) : (index) -> i64
    %33 = "builtin.unrealized_conversion_cast"(%31) : (index) -> i64
    %34 = "llvm.icmp"(%33, %30) <{predicate = 2 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%34)[^bb3, ^bb12] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    "llvm.call"(%32) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @pre, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "cf.br"()[^bb4] : () -> ()
  ^bb4:  // pred: ^bb3
    %35 = "llvm.mlir.constant"() <{value = 7 : index}> : () -> i64
    %36 = "builtin.unrealized_conversion_cast"(%35) : (i64) -> index
    %37 = "llvm.mlir.constant"() <{value = 56 : index}> : () -> i64
    "cf.br"(%36)[^bb5] : (index) -> ()
  ^bb5(%38: index):  // 2 preds: ^bb4, ^bb6
    %39 = "builtin.unrealized_conversion_cast"(%38) : (index) -> i64
    %40 = "builtin.unrealized_conversion_cast"(%38) : (index) -> i64
    %41 = "llvm.icmp"(%40, %37) <{predicate = 2 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%41)[^bb6, ^bb7] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb6:  // pred: ^bb5
    "llvm.call"(%32, %39) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @body2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> ()
    %42 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %43 = "llvm.add"(%40, %42) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %44 = "builtin.unrealized_conversion_cast"(%43) : (i64) -> index
    "cf.br"(%44)[^bb5] : (index) -> ()
  ^bb7:  // pred: ^bb5
    "llvm.call"(%32) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mid, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "cf.br"()[^bb8] : () -> ()
  ^bb8:  // pred: ^bb7
    %45 = "llvm.mlir.constant"() <{value = 18 : index}> : () -> i64
    %46 = "builtin.unrealized_conversion_cast"(%45) : (i64) -> index
    %47 = "llvm.mlir.constant"() <{value = 37 : index}> : () -> i64
    "cf.br"(%46)[^bb9] : (index) -> ()
  ^bb9(%48: index):  // 2 preds: ^bb8, ^bb10
    %49 = "builtin.unrealized_conversion_cast"(%48) : (index) -> i64
    %50 = "builtin.unrealized_conversion_cast"(%48) : (index) -> i64
    %51 = "llvm.icmp"(%50, %47) <{predicate = 2 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%51)[^bb10, ^bb11] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb10:  // pred: ^bb9
    "llvm.call"(%32, %49) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @body3, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> ()
    %52 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
    %53 = "llvm.add"(%50, %52) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %54 = "builtin.unrealized_conversion_cast"(%53) : (i64) -> index
    "cf.br"(%54)[^bb9] : (index) -> ()
  ^bb11:  // pred: ^bb9
    "llvm.call"(%32) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @post, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    %55 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %56 = "llvm.add"(%33, %55) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %57 = "builtin.unrealized_conversion_cast"(%56) : (i64) -> index
    "cf.br"(%57)[^bb2] : (index) -> ()
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
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> ()>, linkage = #llvm.linkage<external>, sym_name = "get_memref", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(i64, f32, struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>)> ()>, linkage = #llvm.linkage<external>, sym_name = "multireturn", visibility_ = 0 : i64}> ({
    %21 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @get_i64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> i64
    %22 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @get_f32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> f32
    %23 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @get_memref, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    %24 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, f32, struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>)>
    %25 = "llvm.insertvalue"(%24, %21) <{position = array<i64: 0>}> : (!llvm.struct<(i64, f32, struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>)>, i64) -> !llvm.struct<(i64, f32, struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>)>
    %26 = "llvm.insertvalue"(%25, %22) <{position = array<i64: 1>}> : (!llvm.struct<(i64, f32, struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>)>, f32) -> !llvm.struct<(i64, f32, struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>)>
    %27 = "llvm.insertvalue"(%26, %23) <{position = array<i64: 2>}> : (!llvm.struct<(i64, f32, struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>)>, !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>) -> !llvm.struct<(i64, f32, struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>)>
    "llvm.return"(%27) : (!llvm.struct<(i64, f32, struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>)>) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "multireturn_caller", visibility_ = 0 : i64}> ({
    %12 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @multireturn, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.struct<(i64, f32, struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>)>
    %13 = "llvm.extractvalue"(%12) <{position = array<i64: 0>}> : (!llvm.struct<(i64, f32, struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>)>) -> i64
    %14 = "llvm.extractvalue"(%12) <{position = array<i64: 1>}> : (!llvm.struct<(i64, f32, struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>)>) -> f32
    %15 = "llvm.extractvalue"(%12) <{position = array<i64: 2>}> : (!llvm.struct<(i64, f32, struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>)>) -> !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    %16 = "llvm.mlir.constant"() <{value = 42 : i64}> : () -> i64
    %17 = "llvm.add"(%13, %16) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %18 = "llvm.mlir.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
    %19 = "llvm.fadd"(%14, %18) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %20 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "dfs_block_order", visibility_ = 0 : i64}> ({
  ^bb0(%arg9: i32):
    %10 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
    "cf.br"()[^bb2] : () -> ()
  ^bb1:  // pred: ^bb2
    %11 = "llvm.add"(%arg9, %10) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.return"(%11) : (i32) -> ()
  ^bb2:  // pred: ^bb0
    "cf.br"()[^bb1] : () -> ()
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
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i1)>, linkage = #llvm.linkage<external>, sym_name = "assert_test_function", visibility_ = 0 : i64}> ({
    ^bb0(%arg6: i1):
      "cf.assert"(%arg6) <{msg = "Computer says no"}> : (i1) -> ()
      "llvm.return"() : () -> ()
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
    %6 = "llvm.intr.fma"(%arg4, %arg4, %arg4) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32, f32) -> f32
    %7 = "llvm.intr.fma"(%arg5, %arg5, %arg5) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i8)>, linkage = #llvm.linkage<external>, sym_name = "switchi8", visibility_ = 0 : i64}> ({
  ^bb0(%arg3: i8):
    "cf.switch"(%arg3)[^bb1, ^bb1, ^bb2] <{case_operand_segments = array<i32: 0, 0>, case_values = dense<[42, 43]> : vector<2xi8>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i8) -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb0
    %4 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    "llvm.return"(%4) : (i32) -> ()
  ^bb2:  // pred: ^bb0
    %5 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64)>, linkage = #llvm.linkage<external>, sym_name = "index_arg", visibility_ = 0 : i64}> ({
  ^bb0(%arg2: i64):
    %1 = "builtin.unrealized_conversion_cast"(%arg2) : (i64) -> index
    "cf.br"(%1)[^bb1] : (index) -> ()
  ^bb1(%2: index):  // pred: ^bb0
    %3 = "builtin.unrealized_conversion_cast"(%2) : (index) -> i64
    "llvm.return"(%3) : (i64) -> ()
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

