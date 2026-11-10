"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<vector<16xi8> (vector<16xf16>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_hftobf8_16", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<16xi8> (vector<16xf16>)>, linkage = #llvm.linkage<external>, sym_name = "truncf_f16_to_bf8", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<16xf16>):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__builtin_IB_hftobf8_16, convergent, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<vector<16xi8> (vector<16xf16>)>, linkage = #llvm.linkage<external>, sym_name = "__builtin_IB_hftobf8_16", visibility_ = 0 : i64} : (vector<16xf16>) -> vector<16xi8>
    "llvm.return"(%0) : (vector<16xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<vector<16xi8> (vector<16xf16>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_hftohf8_16", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<16xi8> (vector<16xf16>)>, linkage = #llvm.linkage<external>, sym_name = "truncf_f16_to_hf8", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<16xf16>):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__builtin_IB_hftohf8_16, convergent, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<vector<16xi8> (vector<16xf16>)>, linkage = #llvm.linkage<external>, sym_name = "__builtin_IB_hftohf8_16", visibility_ = 0 : i64} : (vector<16xf16>) -> vector<16xi8>
    "llvm.return"(%0) : (vector<16xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<vector<16xi8> (vector<16xf16>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_hftobf8_16", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<vector<16xf16> (vector<16xf32>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z14convert_half16Dv16_f", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<vector<16xf32> (vector<16xi16>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_bftof_16", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<16xi8> (vector<16xbf16>)>, linkage = #llvm.linkage<external>, sym_name = "truncf_bf16_to_bf8", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<16xbf16>):
    %0 = "llvm.bitcast"(%arg0) : (vector<16xbf16>) -> vector<16xi16>
    %1 = "llvm.call"(%0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__builtin_IB_bftof_16, convergent, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<vector<16xf32> (vector<16xi16>)>, linkage = #llvm.linkage<external>, sym_name = "__builtin_IB_bftof_16", visibility_ = 0 : i64} : (vector<16xi16>) -> vector<16xf32>
    %2 = "llvm.call"(%1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z14convert_half16Dv16_f, convergent, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<vector<16xf16> (vector<16xf32>)>, linkage = #llvm.linkage<external>, sym_name = "_Z14convert_half16Dv16_f", visibility_ = 0 : i64} : (vector<16xf32>) -> vector<16xf16>
    %3 = "llvm.call"(%2) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__builtin_IB_hftobf8_16, convergent, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<vector<16xi8> (vector<16xf16>)>, linkage = #llvm.linkage<external>, sym_name = "__builtin_IB_hftobf8_16", visibility_ = 0 : i64} : (vector<16xf16>) -> vector<16xi8>
    "llvm.return"(%3) : (vector<16xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<vector<16xi8> (vector<16xf16>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_hftohf8_16", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<vector<16xf16> (vector<16xf32>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z14convert_half16Dv16_f", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<vector<16xf32> (vector<16xi16>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_bftof_16", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<16xi8> (vector<16xbf16>)>, linkage = #llvm.linkage<external>, sym_name = "truncf_bf16_to_hf8", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<16xbf16>):
    %0 = "llvm.bitcast"(%arg0) : (vector<16xbf16>) -> vector<16xi16>
    %1 = "llvm.call"(%0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__builtin_IB_bftof_16, convergent, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<vector<16xf32> (vector<16xi16>)>, linkage = #llvm.linkage<external>, sym_name = "__builtin_IB_bftof_16", visibility_ = 0 : i64} : (vector<16xi16>) -> vector<16xf32>
    %2 = "llvm.call"(%1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z14convert_half16Dv16_f, convergent, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<vector<16xf16> (vector<16xf32>)>, linkage = #llvm.linkage<external>, sym_name = "_Z14convert_half16Dv16_f", visibility_ = 0 : i64} : (vector<16xf32>) -> vector<16xf16>
    %3 = "llvm.call"(%2) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__builtin_IB_hftohf8_16, convergent, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<vector<16xi8> (vector<16xf16>)>, linkage = #llvm.linkage<external>, sym_name = "__builtin_IB_hftohf8_16", visibility_ = 0 : i64} : (vector<16xf16>) -> vector<16xi8>
    "llvm.return"(%3) : (vector<16xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<i32 (i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_dnscl_hf16", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<8xi8> (vector<16xf16>)>, linkage = #llvm.linkage<external>, sym_name = "truncf_f16_to_e2m1", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<16xf16>):
    %0 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %1 = "llvm.mlir.constant"() <{value = 7 : i32}> : () -> i32
    %2 = "llvm.mlir.constant"() <{value = 6 : i32}> : () -> i32
    %3 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
    %4 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %5 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
    %6 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %7 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %8 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %9 = "llvm.bitcast"(%arg0) : (vector<16xf16>) -> vector<8xi32>
    %10 = "llvm.extractelement"(%9, %8) : (vector<8xi32>, i32) -> i32
    %11 = "llvm.extractelement"(%9, %6) : (vector<8xi32>, i32) -> i32
    %12 = "llvm.call"(%10, %11, %7, %8) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__builtin_IB_dnscl_hf16, convergent, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>, will_return}> {function_type = !llvm.func<i32 (i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "__builtin_IB_dnscl_hf16", visibility_ = 0 : i64} : (i32, i32, i32, i32) -> i32
    %13 = "llvm.extractelement"(%9, %7) : (vector<8xi32>, i32) -> i32
    %14 = "llvm.extractelement"(%9, %5) : (vector<8xi32>, i32) -> i32
    %15 = "llvm.call"(%13, %14, %7, %6) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__builtin_IB_dnscl_hf16, convergent, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>, will_return}> {function_type = !llvm.func<i32 (i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "__builtin_IB_dnscl_hf16", visibility_ = 0 : i64} : (i32, i32, i32, i32) -> i32
    %16 = "llvm.or"(%12, %15) : (i32, i32) -> i32
    %17 = "llvm.extractelement"(%9, %4) : (vector<8xi32>, i32) -> i32
    %18 = "llvm.extractelement"(%9, %2) : (vector<8xi32>, i32) -> i32
    %19 = "llvm.call"(%17, %18, %7, %8) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__builtin_IB_dnscl_hf16, convergent, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>, will_return}> {function_type = !llvm.func<i32 (i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "__builtin_IB_dnscl_hf16", visibility_ = 0 : i64} : (i32, i32, i32, i32) -> i32
    %20 = "llvm.extractelement"(%9, %3) : (vector<8xi32>, i32) -> i32
    %21 = "llvm.extractelement"(%9, %1) : (vector<8xi32>, i32) -> i32
    %22 = "llvm.call"(%20, %21, %7, %6) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__builtin_IB_dnscl_hf16, convergent, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>, will_return}> {function_type = !llvm.func<i32 (i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "__builtin_IB_dnscl_hf16", visibility_ = 0 : i64} : (i32, i32, i32, i32) -> i32
    %23 = "llvm.or"(%19, %22) : (i32, i32) -> i32
    %24 = "llvm.insertelement"(%0, %16, %8) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %25 = "llvm.insertelement"(%24, %23, %7) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %26 = "llvm.bitcast"(%25) : (vector<2xi32>) -> vector<8xi8>
    "llvm.return"(%26) : (vector<8xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<i32 (i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_dnscl_bf16", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<8xi8> (vector<16xbf16>)>, linkage = #llvm.linkage<external>, sym_name = "truncf_bf16_to_e2m1", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<16xbf16>):
    %0 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %1 = "llvm.mlir.constant"() <{value = 7 : i32}> : () -> i32
    %2 = "llvm.mlir.constant"() <{value = 6 : i32}> : () -> i32
    %3 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
    %4 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %5 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
    %6 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %7 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %8 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %9 = "llvm.bitcast"(%arg0) : (vector<16xbf16>) -> vector<8xi32>
    %10 = "llvm.extractelement"(%9, %8) : (vector<8xi32>, i32) -> i32
    %11 = "llvm.extractelement"(%9, %6) : (vector<8xi32>, i32) -> i32
    %12 = "llvm.call"(%10, %11, %7, %8) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__builtin_IB_dnscl_bf16, convergent, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>, will_return}> {function_type = !llvm.func<i32 (i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "__builtin_IB_dnscl_bf16", visibility_ = 0 : i64} : (i32, i32, i32, i32) -> i32
    %13 = "llvm.extractelement"(%9, %7) : (vector<8xi32>, i32) -> i32
    %14 = "llvm.extractelement"(%9, %5) : (vector<8xi32>, i32) -> i32
    %15 = "llvm.call"(%13, %14, %7, %6) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__builtin_IB_dnscl_bf16, convergent, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>, will_return}> {function_type = !llvm.func<i32 (i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "__builtin_IB_dnscl_bf16", visibility_ = 0 : i64} : (i32, i32, i32, i32) -> i32
    %16 = "llvm.or"(%12, %15) : (i32, i32) -> i32
    %17 = "llvm.extractelement"(%9, %4) : (vector<8xi32>, i32) -> i32
    %18 = "llvm.extractelement"(%9, %2) : (vector<8xi32>, i32) -> i32
    %19 = "llvm.call"(%17, %18, %7, %8) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__builtin_IB_dnscl_bf16, convergent, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>, will_return}> {function_type = !llvm.func<i32 (i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "__builtin_IB_dnscl_bf16", visibility_ = 0 : i64} : (i32, i32, i32, i32) -> i32
    %20 = "llvm.extractelement"(%9, %3) : (vector<8xi32>, i32) -> i32
    %21 = "llvm.extractelement"(%9, %1) : (vector<8xi32>, i32) -> i32
    %22 = "llvm.call"(%20, %21, %7, %6) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__builtin_IB_dnscl_bf16, convergent, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>, will_return}> {function_type = !llvm.func<i32 (i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "__builtin_IB_dnscl_bf16", visibility_ = 0 : i64} : (i32, i32, i32, i32) -> i32
    %23 = "llvm.or"(%19, %22) : (i32, i32) -> i32
    %24 = "llvm.insertelement"(%0, %16, %8) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %25 = "llvm.insertelement"(%24, %23, %7) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %26 = "llvm.bitcast"(%25) : (vector<2xi32>) -> vector<8xi8>
    "llvm.return"(%26) : (vector<8xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<vector<16xf16> (vector<16xi8>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_bf8tohf_16", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<16xf16> (vector<16xi8>)>, linkage = #llvm.linkage<external>, sym_name = "extf_bf8_to_f16", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<16xi8>):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__builtin_IB_bf8tohf_16, convergent, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<vector<16xf16> (vector<16xi8>)>, linkage = #llvm.linkage<external>, sym_name = "__builtin_IB_bf8tohf_16", visibility_ = 0 : i64} : (vector<16xi8>) -> vector<16xf16>
    "llvm.return"(%0) : (vector<16xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<vector<16xf16> (vector<16xi8>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_hf8tohf_16", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<16xf16> (vector<16xi8>)>, linkage = #llvm.linkage<external>, sym_name = "extf_f8_to_f16", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<16xi8>):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__builtin_IB_hf8tohf_16, convergent, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<vector<16xf16> (vector<16xi8>)>, linkage = #llvm.linkage<external>, sym_name = "__builtin_IB_hf8tohf_16", visibility_ = 0 : i64} : (vector<16xi8>) -> vector<16xf16>
    "llvm.return"(%0) : (vector<16xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<vector<16xi16> (vector<16xf32>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_ftobf_16", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<vector<16xf32> (vector<16xf16>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z15convert_float16Dv16_Dh", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<vector<16xf16> (vector<16xi8>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_bf8tohf_16", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<16xbf16> (vector<16xi8>)>, linkage = #llvm.linkage<external>, sym_name = "extf_bf8_to_bf16", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<16xi8>):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__builtin_IB_bf8tohf_16, convergent, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<vector<16xf16> (vector<16xi8>)>, linkage = #llvm.linkage<external>, sym_name = "__builtin_IB_bf8tohf_16", visibility_ = 0 : i64} : (vector<16xi8>) -> vector<16xf16>
    %1 = "llvm.call"(%0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z15convert_float16Dv16_Dh, convergent, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<vector<16xf32> (vector<16xf16>)>, linkage = #llvm.linkage<external>, sym_name = "_Z15convert_float16Dv16_Dh", visibility_ = 0 : i64} : (vector<16xf16>) -> vector<16xf32>
    %2 = "llvm.call"(%1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__builtin_IB_ftobf_16, convergent, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<vector<16xi16> (vector<16xf32>)>, linkage = #llvm.linkage<external>, sym_name = "__builtin_IB_ftobf_16", visibility_ = 0 : i64} : (vector<16xf32>) -> vector<16xi16>
    %3 = "llvm.bitcast"(%2) : (vector<16xi16>) -> vector<16xbf16>
    "llvm.return"(%3) : (vector<16xbf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<vector<16xi16> (vector<16xf32>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_ftobf_16", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<vector<16xf32> (vector<16xf16>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z15convert_float16Dv16_Dh", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<vector<16xf16> (vector<16xi8>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_hf8tohf_16", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<16xbf16> (vector<16xi8>)>, linkage = #llvm.linkage<external>, sym_name = "extf_f8_to_bf16", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<16xi8>):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__builtin_IB_hf8tohf_16, convergent, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<vector<16xf16> (vector<16xi8>)>, linkage = #llvm.linkage<external>, sym_name = "__builtin_IB_hf8tohf_16", visibility_ = 0 : i64} : (vector<16xi8>) -> vector<16xf16>
    %1 = "llvm.call"(%0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z15convert_float16Dv16_Dh, convergent, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<vector<16xf32> (vector<16xf16>)>, linkage = #llvm.linkage<external>, sym_name = "_Z15convert_float16Dv16_Dh", visibility_ = 0 : i64} : (vector<16xf16>) -> vector<16xf32>
    %2 = "llvm.call"(%1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__builtin_IB_ftobf_16, convergent, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<vector<16xi16> (vector<16xf32>)>, linkage = #llvm.linkage<external>, sym_name = "__builtin_IB_ftobf_16", visibility_ = 0 : i64} : (vector<16xf32>) -> vector<16xi16>
    %3 = "llvm.bitcast"(%2) : (vector<16xi16>) -> vector<16xbf16>
    "llvm.return"(%3) : (vector<16xbf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<vector<8xi32> (vector<16xi32>, vector<8xi8>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_shfl_idx4_to_fp16_8_packed", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<vector<16xi32> (i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_shfl_idx4_lut", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<16xf16> (vector<8xi8>)>, linkage = #llvm.linkage<external>, sym_name = "extf_e2m1_to_f16", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<8xi8>):
    %0 = "llvm.mlir.constant"() <{value = 7 : i32}> : () -> i32
    %1 = "llvm.call"(%0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__builtin_IB_shfl_idx4_lut, convergent, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<vector<16xi32> (i32)>, linkage = #llvm.linkage<external>, sym_name = "__builtin_IB_shfl_idx4_lut", visibility_ = 0 : i64} : (i32) -> vector<16xi32>
    %2 = "llvm.call"(%1, %arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__builtin_IB_shfl_idx4_to_fp16_8_packed, convergent, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, will_return}> {function_type = !llvm.func<vector<8xi32> (vector<16xi32>, vector<8xi8>)>, linkage = #llvm.linkage<external>, sym_name = "__builtin_IB_shfl_idx4_to_fp16_8_packed", visibility_ = 0 : i64} : (vector<16xi32>, vector<8xi8>) -> vector<8xi32>
    %3 = "llvm.bitcast"(%2) : (vector<8xi32>) -> vector<16xf16>
    "llvm.return"(%3) : (vector<16xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<vector<8xi32> (vector<16xi32>, vector<8xi8>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_shfl_idx4_to_fp16_8_packed", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<vector<16xi32> (i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_shfl_idx4_lut", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<16xbf16> (vector<8xi8>)>, linkage = #llvm.linkage<external>, sym_name = "extf_e2m1_to_bf16", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<8xi8>):
    %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "llvm.call"(%0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__builtin_IB_shfl_idx4_lut, convergent, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<vector<16xi32> (i32)>, linkage = #llvm.linkage<external>, sym_name = "__builtin_IB_shfl_idx4_lut", visibility_ = 0 : i64} : (i32) -> vector<16xi32>
    %2 = "llvm.call"(%1, %arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__builtin_IB_shfl_idx4_to_fp16_8_packed, convergent, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, will_return}> {function_type = !llvm.func<vector<8xi32> (vector<16xi32>, vector<8xi8>)>, linkage = #llvm.linkage<external>, sym_name = "__builtin_IB_shfl_idx4_to_fp16_8_packed", visibility_ = 0 : i64} : (vector<16xi32>, vector<8xi8>) -> vector<8xi32>
    %3 = "llvm.bitcast"(%2) : (vector<8xi32>) -> vector<16xbf16>
    "llvm.return"(%3) : (vector<16xbf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<vector<8xf32> (vector<8xf32>, vector<8xi16>, vector<8xi32>, i8, i8)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "__builtin_IB_sub_group16_bdpas_f_f_bf8_bf8_8_8", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<8xf32> (vector<8xi16>, vector<8xi32>, i8, i8, vector<8xf32>)>, linkage = #llvm.linkage<external>, sym_name = "mma_mx_bf8_bf8_k32_f32", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<8xi16>, %arg1: vector<8xi32>, %arg2: i8, %arg3: i8, %arg4: vector<8xf32>):
    %0 = "llvm.call"(%arg4, %arg0, %arg1, %arg2, %arg3) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__builtin_IB_sub_group16_bdpas_f_f_bf8_bf8_8_8, convergent, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 5, 0>, will_return}> {function_type = !llvm.func<vector<8xf32> (vector<8xf32>, vector<8xi16>, vector<8xi32>, i8, i8)>, linkage = #llvm.linkage<external>, sym_name = "__builtin_IB_sub_group16_bdpas_f_f_bf8_bf8_8_8", visibility_ = 0 : i64} : (vector<8xf32>, vector<8xi16>, vector<8xi32>, i8, i8) -> vector<8xf32>
    "llvm.return"(%0) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

