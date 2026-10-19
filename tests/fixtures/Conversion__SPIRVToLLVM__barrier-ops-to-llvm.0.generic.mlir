"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<void (i32, i32, i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z22__spirv_ControlBarrieriii", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "control_barrier", visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %2 = "llvm.mlir.constant"() <{value = 768 : i32}> : () -> i32
    "llvm.call"(%0, %1, %2) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z22__spirv_ControlBarrieriii, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>, will_return}> : (i32, i32, i32) -> ()
    %3 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %4 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %5 = "llvm.mlir.constant"() <{value = 256 : i32}> : () -> i32
    "llvm.call"(%3, %4, %5) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z22__spirv_ControlBarrieriii, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>, will_return}> : (i32, i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<void (i32, i32, i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z31__spirv_ControlBarrierWaitINTELiii", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<void (i32, i32, i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z33__spirv_ControlBarrierArriveINTELiii", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "split_barrier", visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %2 = "llvm.mlir.constant"() <{value = 768 : i32}> : () -> i32
    "llvm.call"(%0, %1, %2) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z33__spirv_ControlBarrierArriveINTELiii, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>, will_return}> : (i32, i32, i32) -> ()
    %3 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %4 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %5 = "llvm.mlir.constant"() <{value = 256 : i32}> : () -> i32
    "llvm.call"(%3, %4, %5) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z31__spirv_ControlBarrierWaitINTELiii, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>, will_return}> : (i32, i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

