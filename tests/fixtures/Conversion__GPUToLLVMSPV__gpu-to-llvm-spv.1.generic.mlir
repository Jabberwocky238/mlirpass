"builtin.module"() ({
  "gpu.module"() <{sym_name = "builtins"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z14get_num_groupsj", visibility_ = 0 : i64, will_return}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z12get_local_idj", visibility_ = 0 : i64, will_return}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z14get_local_sizej", visibility_ = 0 : i64, will_return}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z13get_global_idj", visibility_ = 0 : i64, will_return}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z12get_group_idj", visibility_ = 0 : i64, will_return}> ({
    }) : () -> ()
    "func.func"() <{function_type = () -> (index, index, index), sym_name = "gpu_block_id"}> ({
      %36 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %37 = "llvm.call"(%36) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z12get_group_idj, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> : (i32) -> i32
      %38 = "builtin.unrealized_conversion_cast"(%37) : (i32) -> index
      %39 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %40 = "llvm.call"(%39) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z12get_group_idj, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> : (i32) -> i32
      %41 = "builtin.unrealized_conversion_cast"(%40) : (i32) -> index
      %42 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %43 = "llvm.call"(%42) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z12get_group_idj, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> : (i32) -> i32
      %44 = "builtin.unrealized_conversion_cast"(%43) : (i32) -> index
      "func.return"(%38, %41, %44) : (index, index, index) -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (index, index, index), sym_name = "gpu_global_id"}> ({
      %27 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %28 = "llvm.call"(%27) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z13get_global_idj, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> : (i32) -> i32
      %29 = "builtin.unrealized_conversion_cast"(%28) : (i32) -> index
      %30 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %31 = "llvm.call"(%30) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z13get_global_idj, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> : (i32) -> i32
      %32 = "builtin.unrealized_conversion_cast"(%31) : (i32) -> index
      %33 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %34 = "llvm.call"(%33) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z13get_global_idj, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> : (i32) -> i32
      %35 = "builtin.unrealized_conversion_cast"(%34) : (i32) -> index
      "func.return"(%29, %32, %35) : (index, index, index) -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (index, index, index), sym_name = "gpu_block_dim"}> ({
      %18 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %19 = "llvm.call"(%18) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z14get_local_sizej, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> : (i32) -> i32
      %20 = "builtin.unrealized_conversion_cast"(%19) : (i32) -> index
      %21 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %22 = "llvm.call"(%21) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z14get_local_sizej, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> : (i32) -> i32
      %23 = "builtin.unrealized_conversion_cast"(%22) : (i32) -> index
      %24 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %25 = "llvm.call"(%24) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z14get_local_sizej, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> : (i32) -> i32
      %26 = "builtin.unrealized_conversion_cast"(%25) : (i32) -> index
      "func.return"(%20, %23, %26) : (index, index, index) -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (index, index, index), sym_name = "gpu_thread_id"}> ({
      %9 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %10 = "llvm.call"(%9) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z12get_local_idj, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> : (i32) -> i32
      %11 = "builtin.unrealized_conversion_cast"(%10) : (i32) -> index
      %12 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %13 = "llvm.call"(%12) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z12get_local_idj, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> : (i32) -> i32
      %14 = "builtin.unrealized_conversion_cast"(%13) : (i32) -> index
      %15 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %16 = "llvm.call"(%15) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z12get_local_idj, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> : (i32) -> i32
      %17 = "builtin.unrealized_conversion_cast"(%16) : (i32) -> index
      "func.return"(%11, %14, %17) : (index, index, index) -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (index, index, index), sym_name = "gpu_grid_dim"}> ({
      %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %1 = "llvm.call"(%0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z14get_num_groupsj, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> : (i32) -> i32
      %2 = "builtin.unrealized_conversion_cast"(%1) : (i32) -> index
      %3 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %4 = "llvm.call"(%3) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z14get_num_groupsj, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> : (i32) -> i32
      %5 = "builtin.unrealized_conversion_cast"(%4) : (i32) -> index
      %6 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
      %7 = "llvm.call"(%6) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z14get_num_groupsj, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> : (i32) -> i32
      %8 = "builtin.unrealized_conversion_cast"(%7) : (i32) -> index
      "func.return"(%2, %5, %8) : (index, index, index) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "barriers"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z7barrierj", visibility_ = 0 : i64, will_return}> ({
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "gpu_barrier"}> ({
      %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
      "llvm.call"(%0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z7barrierj, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> : (i32) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "shuffles"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<i8 (i8, i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z21sub_group_shuffle_xorcj", visibility_ = 0 : i64, will_return}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<i16 (i16, i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z22sub_group_shuffle_downsj", visibility_ = 0 : i64, will_return}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<f64 (f64, i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z22sub_group_shuffle_downdj", visibility_ = 0 : i64, will_return}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<f32 (f32, i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z20sub_group_shuffle_upfj", visibility_ = 0 : i64, will_return}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<f16 (f16, i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z20sub_group_shuffle_upDhj", visibility_ = 0 : i64, will_return}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<i64 (i64, i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z21sub_group_shuffle_xorlj", visibility_ = 0 : i64, will_return}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<i32 (i32, i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z17sub_group_shuffleij", visibility_ = 0 : i64, will_return}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<i16 (i16, i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z21sub_group_shuffle_xorsj", visibility_ = 0 : i64, will_return}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<i8 (i8, i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z17sub_group_shufflecj", visibility_ = 0 : i64, will_return}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i8, i16, i32, i64, f16, f32, f64, bf16, i1, i32)>, intel_reqd_sub_group_size = 16 : i32, linkage = #llvm.linkage<external>, sym_name = "gpu_shuffles", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    ^bb0(%arg0: i8, %arg1: i16, %arg2: i32, %arg3: i64, %arg4: f16, %arg5: f32, %arg6: f64, %arg7: bf16, %arg8: i1, %arg9: i32):
      %0 = "arith.constant"() <{value = 16 : i32}> : () -> i32
      %1 = "llvm.call"(%arg0, %arg9) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17sub_group_shufflecj, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, will_return}> : (i8, i32) -> i8
      %2 = "llvm.mlir.constant"() <{value = true}> : () -> i1
      %3 = "llvm.call"(%arg1, %arg9) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z21sub_group_shuffle_xorsj, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, will_return}> : (i16, i32) -> i16
      %4 = "llvm.mlir.constant"() <{value = true}> : () -> i1
      %5 = "llvm.call"(%arg2, %arg9) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17sub_group_shuffleij, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, will_return}> : (i32, i32) -> i32
      %6 = "llvm.mlir.constant"() <{value = true}> : () -> i1
      %7 = "llvm.call"(%arg3, %arg9) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z21sub_group_shuffle_xorlj, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, will_return}> : (i64, i32) -> i64
      %8 = "llvm.mlir.constant"() <{value = true}> : () -> i1
      %9 = "llvm.call"(%arg4, %arg9) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z20sub_group_shuffle_upDhj, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, will_return}> : (f16, i32) -> f16
      %10 = "llvm.mlir.constant"() <{value = true}> : () -> i1
      %11 = "llvm.call"(%arg5, %arg9) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z20sub_group_shuffle_upfj, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, will_return}> : (f32, i32) -> f32
      %12 = "llvm.mlir.constant"() <{value = true}> : () -> i1
      %13 = "llvm.call"(%arg6, %arg9) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z22sub_group_shuffle_downdj, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, will_return}> : (f64, i32) -> f64
      %14 = "llvm.mlir.constant"() <{value = true}> : () -> i1
      %15 = "llvm.bitcast"(%arg7) : (bf16) -> i16
      %16 = "llvm.call"(%15, %arg9) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z22sub_group_shuffle_downsj, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, will_return}> : (i16, i32) -> i16
      %17 = "llvm.bitcast"(%16) : (i16) -> bf16
      %18 = "llvm.mlir.constant"() <{value = true}> : () -> i1
      %19 = "llvm.zext"(%arg8) : (i1) -> i8
      %20 = "llvm.call"(%19, %arg9) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z21sub_group_shuffle_xorcj, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, will_return}> : (i8, i32) -> i8
      %21 = "llvm.trunc"(%20) <{overflowFlags = 0 : i32}> : (i8) -> i1
      %22 = "llvm.mlir.constant"() <{value = true}> : () -> i1
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
// -----
// -----
// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "no_kernel", visibility_ = 0 : i64}> ({
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<spir_kernelcc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "kernel_no_arg", visibility_ = 0 : i64}> ({
      "llvm.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<spir_kernelcc>, function_type = !llvm.func<void (f32, i64)>, linkage = #llvm.linkage<external>, sym_name = "kernel_with_args", visibility_ = 0 : i64}> ({
    ^bb0(%arg18: f32, %arg19: i64):
      "llvm.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<spir_kernelcc>, function_type = !llvm.func<void (i32, ptr<1>, ptr<1>, i32)>, linkage = #llvm.linkage<external>, sym_name = "kernel_with_conv_args", visibility_ = 0 : i64}> ({
    ^bb0(%arg14: i32, %arg15: !llvm.ptr<1>, %arg16: !llvm.ptr<1>, %arg17: i32):
      "llvm.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<spir_kernelcc>, function_type = !llvm.func<void (ptr<1>, ptr<1>, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "kernel_with_sized_memref", visibility_ = 0 : i64}> ({
    ^bb0(%arg9: !llvm.ptr<1>, %arg10: !llvm.ptr<1>, %arg11: i32, %arg12: i32, %arg13: i32):
      "llvm.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<spir_kernelcc>, function_type = !llvm.func<void (ptr<1>, ptr<1>, i32, i32, i32, i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "kernel_with_ND_memref", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr<1>, %arg1: !llvm.ptr<1>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
      "llvm.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<spir_kernelcc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "kernel_with_private_attributions", visibility_ = 0 : i64}> ({
      %58 = "llvm.mlir.constant"() <{value = 32 : i64}> : () -> i64
      %59 = "llvm.alloca"(%58) <{elem_type = f32}> : (i64) -> !llvm.ptr
      %60 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %61 = "llvm.insertvalue"(%60, %59) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %62 = "llvm.insertvalue"(%61, %59) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %63 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i32
      %64 = "llvm.insertvalue"(%62, %63) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %65 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i32
      %66 = "llvm.insertvalue"(%64, %65) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %67 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i32
      %68 = "llvm.insertvalue"(%66, %67) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %69 = "llvm.mlir.constant"() <{value = 16 : i64}> : () -> i64
      %70 = "llvm.alloca"(%69) <{elem_type = i16}> : (i64) -> !llvm.ptr
      %71 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %72 = "llvm.insertvalue"(%71, %70) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %73 = "llvm.insertvalue"(%72, %70) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %74 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i32
      %75 = "llvm.insertvalue"(%73, %74) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %76 = "llvm.mlir.constant"() <{value = 16 : index}> : () -> i32
      %77 = "llvm.insertvalue"(%75, %76) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %78 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i32
      %79 = "llvm.insertvalue"(%77, %78) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      "llvm.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<spir_kernelcc>, arg_attrs = [{llvm.noalias, llvm.workgroup_attribution = #llvm.mlir.workgroup_attribution<32 : i64, f32>}, {llvm.noalias, llvm.workgroup_attribution = #llvm.mlir.workgroup_attribution<16 : i64, i16>}], function_type = !llvm.func<void (ptr<3>, ptr<3>)>, linkage = #llvm.linkage<external>, sym_name = "kernel_with_workgoup_attributions", visibility_ = 0 : i64}> ({
    ^bb0(%arg2: !llvm.ptr<3>, %arg3: !llvm.ptr<3>):
      %40 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %41 = "llvm.insertvalue"(%40, %arg2) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %42 = "llvm.insertvalue"(%41, %arg2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %43 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i32
      %44 = "llvm.insertvalue"(%42, %43) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %45 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i32
      %46 = "llvm.insertvalue"(%44, %45) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %47 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i32
      %48 = "llvm.insertvalue"(%46, %47) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %49 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %50 = "llvm.insertvalue"(%49, %arg3) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %51 = "llvm.insertvalue"(%50, %arg3) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %52 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i32
      %53 = "llvm.insertvalue"(%51, %52) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %54 = "llvm.mlir.constant"() <{value = 16 : index}> : () -> i32
      %55 = "llvm.insertvalue"(%53, %54) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %56 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i32
      %57 = "llvm.insertvalue"(%55, %56) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      "llvm.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<spir_kernelcc>, arg_attrs = [{llvm.noalias, llvm.workgroup_attribution = #llvm.mlir.workgroup_attribution<8 : i64, f32>}, {llvm.noalias, llvm.workgroup_attribution = #llvm.mlir.workgroup_attribution<16 : i64, i32>}], function_type = !llvm.func<void (ptr<3>, ptr<3>)>, linkage = #llvm.linkage<external>, sym_name = "kernel_with_both_attributions", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr<3>, %arg1: !llvm.ptr<3>):
      %0 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %1 = "llvm.insertvalue"(%0, %arg0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %2 = "llvm.insertvalue"(%1, %arg0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %3 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i32
      %4 = "llvm.insertvalue"(%2, %3) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %5 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i32
      %6 = "llvm.insertvalue"(%4, %5) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %7 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i32
      %8 = "llvm.insertvalue"(%6, %7) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %9 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %10 = "llvm.insertvalue"(%9, %arg1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %11 = "llvm.insertvalue"(%10, %arg1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %12 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i32
      %13 = "llvm.insertvalue"(%11, %12) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %14 = "llvm.mlir.constant"() <{value = 16 : index}> : () -> i32
      %15 = "llvm.insertvalue"(%13, %14) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %16 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i32
      %17 = "llvm.insertvalue"(%15, %16) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %18 = "llvm.mlir.constant"() <{value = 32 : i64}> : () -> i64
      %19 = "llvm.alloca"(%18) <{elem_type = i32}> : (i64) -> !llvm.ptr
      %20 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %21 = "llvm.insertvalue"(%20, %19) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %22 = "llvm.insertvalue"(%21, %19) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %23 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i32
      %24 = "llvm.insertvalue"(%22, %23) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %25 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i32
      %26 = "llvm.insertvalue"(%24, %25) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %27 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i32
      %28 = "llvm.insertvalue"(%26, %27) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %29 = "llvm.mlir.constant"() <{value = 32 : i64}> : () -> i64
      %30 = "llvm.alloca"(%29) <{elem_type = i32}> : (i64) -> !llvm.ptr
      %31 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %32 = "llvm.insertvalue"(%31, %30) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %33 = "llvm.insertvalue"(%32, %30) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %34 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i32
      %35 = "llvm.insertvalue"(%33, %34) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %36 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i32
      %37 = "llvm.insertvalue"(%35, %36) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %38 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i32
      %39 = "llvm.insertvalue"(%37, %38) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      "llvm.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<spir_kernelcc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, reqd_work_group_size = array<i32: 128, 128, 256>, sym_name = "kernel_known_block_size", visibility_ = 0 : i64}> ({
      "llvm.return"() : () -> ()
    }) {gpu.kernel, gpu.known_block_size = array<i32: 128, 128, 256>} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<void (ptr<1>, ptr<1>, i32, ptr<3>, ptr<3>, i32, ptr, ptr, i32)>, linkage = #llvm.linkage<external>, sym_name = "address_spaces", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr<1>, %arg1: !llvm.ptr<1>, %arg2: i32, %arg3: !llvm.ptr<3>, %arg4: !llvm.ptr<3>, %arg5: i32, %arg6: !llvm.ptr, %arg7: !llvm.ptr, %arg8: i32):
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z12get_group_idj", visibility_ = 0 : i64, will_return}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<void (ptr<1>, ptr<1>, i32, ptr<1>, ptr<1>, i32, ptr<1>, ptr<1>, i32)>, linkage = #llvm.linkage<external>, sym_name = "no_address_spaces", visibility_ = 0 : i64}> ({
    ^bb0(%arg14: !llvm.ptr<1>, %arg15: !llvm.ptr<1>, %arg16: i32, %arg17: !llvm.ptr<1>, %arg18: !llvm.ptr<1>, %arg19: i32, %arg20: !llvm.ptr<1>, %arg21: !llvm.ptr<1>, %arg22: i32):
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<spir_kernelcc>, function_type = !llvm.func<void (ptr<1>, ptr<1>, i32, i32, i32, i32, i32, ptr<1>, ptr<1>, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "no_address_spaces_complex", visibility_ = 0 : i64}> ({
    ^bb0(%arg2: !llvm.ptr<1>, %arg3: !llvm.ptr<1>, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: !llvm.ptr<1>, %arg10: !llvm.ptr<1>, %arg11: i32, %arg12: i32, %arg13: i32):
      %4 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<1>, ptr<1>, i32, array<1 x i32>, array<1 x i32>)>
      %5 = "llvm.insertvalue"(%4, %arg9) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<1>, ptr<1>, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr<1>) -> !llvm.struct<(ptr<1>, ptr<1>, i32, array<1 x i32>, array<1 x i32>)>
      %6 = "llvm.insertvalue"(%5, %arg10) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr<1>) -> !llvm.struct<(ptr<1>, ptr<1>, i32, array<1 x i32>, array<1 x i32>)>
      %7 = "llvm.insertvalue"(%6, %arg11) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<1>, ptr<1>, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr<1>, ptr<1>, i32, array<1 x i32>, array<1 x i32>)>
      %8 = "llvm.insertvalue"(%7, %arg12) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<1>, ptr<1>, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr<1>, ptr<1>, i32, array<1 x i32>, array<1 x i32>)>
      %9 = "llvm.insertvalue"(%8, %arg13) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<1>, ptr<1>, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr<1>, ptr<1>, i32, array<1 x i32>, array<1 x i32>)>
      %10 = "builtin.unrealized_conversion_cast"(%9) : (!llvm.struct<(ptr<1>, ptr<1>, i32, array<1 x i32>, array<1 x i32>)>) -> memref<4xf32, 1>
      %11 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<1>, ptr<1>, i32, array<2 x i32>, array<2 x i32>)>
      %12 = "llvm.insertvalue"(%11, %arg2) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<1>, ptr<1>, i32, array<2 x i32>, array<2 x i32>)>, !llvm.ptr<1>) -> !llvm.struct<(ptr<1>, ptr<1>, i32, array<2 x i32>, array<2 x i32>)>
      %13 = "llvm.insertvalue"(%12, %arg3) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i32, array<2 x i32>, array<2 x i32>)>, !llvm.ptr<1>) -> !llvm.struct<(ptr<1>, ptr<1>, i32, array<2 x i32>, array<2 x i32>)>
      %14 = "llvm.insertvalue"(%13, %arg4) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<1>, ptr<1>, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr<1>, ptr<1>, i32, array<2 x i32>, array<2 x i32>)>
      %15 = "llvm.insertvalue"(%14, %arg5) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<1>, ptr<1>, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr<1>, ptr<1>, i32, array<2 x i32>, array<2 x i32>)>
      %16 = "llvm.insertvalue"(%15, %arg7) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<1>, ptr<1>, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr<1>, ptr<1>, i32, array<2 x i32>, array<2 x i32>)>
      %17 = "llvm.insertvalue"(%16, %arg6) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr<1>, ptr<1>, i32, array<2 x i32>, array<2 x i32>)>
      %18 = "llvm.insertvalue"(%17, %arg8) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr<1>, ptr<1>, i32, array<2 x i32>, array<2 x i32>)>
      %19 = "builtin.unrealized_conversion_cast"(%18) : (!llvm.struct<(ptr<1>, ptr<1>, i32, array<2 x i32>, array<2 x i32>)>) -> memref<2x2xf32, 1>
      "func.call"(%19, %10) <{callee = @no_address_spaces_callee}> : (memref<2x2xf32, 1>, memref<4xf32, 1>) -> ()
      "llvm.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
    "func.func"() <{function_type = (memref<2x2xf32, 1>, memref<4xf32, 1>) -> (), sym_name = "no_address_spaces_callee"}> ({
    ^bb0(%arg0: memref<2x2xf32, 1>, %arg1: memref<4xf32, 1>):
      %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %1 = "llvm.call"(%0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z12get_group_idj, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> : (i32) -> i32
      %2 = "builtin.unrealized_conversion_cast"(%1) : (i32) -> index
      %3 = "memref.load"(%arg0, %2, %2) : (memref<2x2xf32, 1>, index, index) -> f32
      "memref.store"(%3, %arg1, %2) : (f32, memref<4xf32, 1>, index) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "subgroup_operations"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z18get_sub_group_size", visibility_ = 0 : i64, will_return}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z18get_num_sub_groups", visibility_ = 0 : i64, will_return}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z22get_sub_group_local_id", visibility_ = 0 : i64, will_return}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z16get_sub_group_id", visibility_ = 0 : i64, will_return}> ({
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "gpu_subgroup"}> ({
      %0 = "llvm.call"() <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z16get_sub_group_id, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>, will_return}> : () -> i32
      %1 = "llvm.call"() <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z22get_sub_group_local_id, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>, will_return}> : () -> i32
      %2 = "llvm.call"() <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z18get_num_sub_groups, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>, will_return}> : () -> i32
      %3 = "llvm.call"() <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z18get_sub_group_size, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>, will_return}> : () -> i32
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

