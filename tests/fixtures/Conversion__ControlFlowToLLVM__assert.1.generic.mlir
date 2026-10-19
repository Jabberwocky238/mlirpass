"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "abort", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "puts", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 0 : i32, constant, global_type = !llvm.array<14 x i8>, linkage = #llvm.linkage<private>, sym_name = "assert_msg", value = dense<[97, 115, 115, 101, 114, 116, 105, 111, 110, 32, 102, 111, 111, 0]> : tensor<14xi8>, visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
    %0 = "arith.constant"() <{value = false}> : () -> i1
    "llvm.cond_br"(%0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"() : () -> ()
  ^bb2:  // pred: ^bb0
    %1 = "llvm.mlir.addressof"() <{global_name = @assert_msg}> : () -> !llvm.ptr
    %2 = "llvm.getelementptr"(%1) <{elem_type = !llvm.array<14 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0>}> : (!llvm.ptr) -> !llvm.ptr
    "llvm.call"(%2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @puts, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @abort, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
    "llvm.unreachable"() : () -> ()
  }) : () -> ()
}) : () -> ()

