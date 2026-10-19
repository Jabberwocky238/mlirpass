"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "second_order_arg", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr ()>, linkage = #llvm.linkage<external>, sym_name = "second_order_result", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(ptr, ptr, ptr)> ()>, linkage = #llvm.linkage<external>, sym_name = "second_order_multi_result", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "memref_call_conv", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "memref_call_conv_nested", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (ptr)>, linkage = #llvm.linkage<external>, sym_name = "pass_through", visibility_ = 0 : i64}> ({
  ^bb0(%arg4: !llvm.ptr):
    "llvm.br"(%arg4)[^bb1] : (!llvm.ptr) -> ()
  ^bb1(%2: !llvm.ptr):  // pred: ^bb0
    "llvm.return"(%2) : (!llvm.ptr) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<extern_weak>, sym_name = "llvmlinkage", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, sym_name = "llvmreadnone", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "body", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "indirect_const_call", visibility_ = 0 : i64}> ({
  ^bb0(%arg3: i32):
    %1 = "llvm.mlir.addressof"() <{global_name = @body}> : () -> !llvm.ptr
    "llvm.call"(%1, %arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, i32) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (ptr, f32)>, linkage = #llvm.linkage<external>, sym_name = "indirect_call", visibility_ = 0 : i64}> ({
  ^bb0(%arg1: !llvm.ptr, %arg2: f32):
    %0 = "llvm.call"(%arg1, %arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, f32) -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, ...)>, linkage = #llvm.linkage<external>, sym_name = "variadic_func", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i32):
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "target_cpu", sym_visibility = "private", target_cpu = "gfx90a", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "target_features", sym_visibility = "private", target_features = #llvm.target_features<["+sme", "+sve"]>, visibility_ = 0 : i64}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "private_callee", sym_visibility = "private", visibility_ = 0 : i64}> ({
  ^bb0(%arg1: f32):
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "caller_private_callee", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @private_callee, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "badllvmlinkage", sym_visibility = "private"}> ({
  }) {llvm.linkage = 3 : i64} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "variadic_func"}> ({
  ^bb0(%arg0: i32):
    "llvm.return"() : () -> ()
  }) {func.varargs = true, llvm.emit_c_interface} : () -> ()
}) : () -> ()

