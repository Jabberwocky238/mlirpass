"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.mlir.global"() <{addr_space = 0 : i32, constant, global_type = !llvm.array<11 x i8>, linkage = #llvm.linkage<internal>, sym_name = "printfFormat_1", value = "Hello: %d\0A\00", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i32, i64, i64, i64, i64, i64, i64, i64, i32)>, linkage = #llvm.linkage<external>, sym_name = "__ockl_printf_append_args", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.mlir.global"() <{addr_space = 0 : i32, constant, global_type = !llvm.array<14 x i8>, linkage = #llvm.linkage<internal>, sym_name = "printfFormat_0", value = "Hello, world\0A\00", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, ptr, i64, i32)>, linkage = #llvm.linkage<external>, sym_name = "__ockl_printf_append_string_n", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64)>, linkage = #llvm.linkage<external>, sym_name = "__ockl_printf_begin", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "test_const_printf", visibility_ = 0 : i64}> ({
      %11 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
      %12 = "llvm.call"(%11) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ockl_printf_begin, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> i64
      %13 = "llvm.mlir.addressof"() <{global_name = @printfFormat_0}> : () -> !llvm.ptr
      %14 = "llvm.getelementptr"(%13) <{elem_type = !llvm.array<14 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %15 = "llvm.mlir.constant"() <{value = 14 : i64}> : () -> i64
      %16 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %17 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %18 = "llvm.call"(%12, %14, %15, %16) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ockl_printf_append_string_n, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>}> : (i64, !llvm.ptr, i64, i32) -> i64
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "test_printf", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: i32):
      %0 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
      %1 = "llvm.call"(%0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ockl_printf_begin, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> i64
      %2 = "llvm.mlir.addressof"() <{global_name = @printfFormat_1}> : () -> !llvm.ptr
      %3 = "llvm.getelementptr"(%2) <{elem_type = !llvm.array<11 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
      %4 = "llvm.mlir.constant"() <{value = 11 : i64}> : () -> i64
      %5 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %6 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %7 = "llvm.call"(%1, %3, %4, %6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ockl_printf_append_string_n, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>}> : (i64, !llvm.ptr, i64, i32) -> i64
      %8 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %9 = "llvm.zext"(%arg0) : (i32) -> i64
      %10 = "llvm.call"(%7, %8, %9, %0, %0, %0, %0, %0, %0, %5) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ockl_printf_append_args, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 10, 0>}> : (i64, i32, i64, i64, i64, i64, i64, i64, i64, i32) -> i64
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "fake_gpu_module_for_test"}> ({
    "builtin.module"() <{sym_name = "test_module"}> ({
      "llvm.mlir.global"() <{addr_space = 0 : i32, constant, global_type = !llvm.array<11 x i8>, linkage = #llvm.linkage<internal>, sym_name = "printfFormat_0", value = "Hello: %d\0A\00", visibility_ = 0 : i64}> ({
      }) : () -> ()
      "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, ptr, i64, i32)>, linkage = #llvm.linkage<external>, sym_name = "__ockl_printf_append_string_n", visibility_ = 0 : i64}> ({
      }) : () -> ()
      "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i32, i64, i64, i64, i64, i64, i64, i64, i32)>, linkage = #llvm.linkage<external>, sym_name = "__ockl_printf_append_args", visibility_ = 0 : i64}> ({
      }) : () -> ()
      "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64)>, linkage = #llvm.linkage<external>, sym_name = "__ockl_printf_begin", visibility_ = 0 : i64}> ({
      }) : () -> ()
      "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "test_printf", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
      ^bb0(%arg0: i32):
        %0 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
        %1 = "llvm.call"(%0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ockl_printf_begin, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> i64
        %2 = "llvm.mlir.addressof"() <{global_name = @printfFormat_0}> : () -> !llvm.ptr
        %3 = "llvm.getelementptr"(%2) <{elem_type = !llvm.array<11 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
        %4 = "llvm.mlir.constant"() <{value = 11 : i64}> : () -> i64
        %5 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
        %6 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
        %7 = "llvm.call"(%1, %3, %4, %6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ockl_printf_append_string_n, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>}> : (i64, !llvm.ptr, i64, i32) -> i64
        %8 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
        %9 = "llvm.zext"(%arg0) : (i32) -> i64
        %10 = "llvm.call"(%7, %8, %9, %0, %0, %0, %0, %0, %0, %5) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__ockl_printf_append_args, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 10, 0>}> : (i64, i32, i64, i64, i64, i64, i64, i64, i64, i32) -> i64
        "llvm.return"() : () -> ()
      }) : () -> ()
    }) : () -> ()
  }) {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} : () -> ()
}) : () -> ()

