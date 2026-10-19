"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<i32 (i32, i32, i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z17__spirv_GroupSMaxiij", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<i32 (i32, i32, i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z17__spirv_GroupUMaxiij", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<f32 (i32, i32, f32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z17__spirv_GroupFMaxiif", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<i32 (i32, i32, i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z17__spirv_GroupSMiniij", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<i32 (i32, i32, i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z17__spirv_GroupUMiniij", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<f32 (i32, i32, f32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z17__spirv_GroupFMiniif", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<f32 (i32, i32, f32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z17__spirv_GroupFAddiif", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<i32 (i32, i32, i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z17__spirv_GroupIAddiij", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "group_reduce_iadd", visibility_ = 0 : i64}> ({
  ^bb0(%arg24: i32):
    %72 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %73 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %74 = "llvm.call"(%72, %73, %arg24) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_GroupIAddiij, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>, will_return}> : (i32, i32, i32) -> i32
    "llvm.return"(%74) : (i32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "group_reduce_fadd", visibility_ = 0 : i64}> ({
  ^bb0(%arg23: f32):
    %69 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %70 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %71 = "llvm.call"(%69, %70, %arg23) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_GroupFAddiif, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>, will_return}> : (i32, i32, f32) -> f32
    "llvm.return"(%71) : (f32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "group_reduce_fmin", visibility_ = 0 : i64}> ({
  ^bb0(%arg22: f32):
    %66 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %67 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %68 = "llvm.call"(%66, %67, %arg22) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_GroupFMiniif, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>, will_return}> : (i32, i32, f32) -> f32
    "llvm.return"(%68) : (f32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "group_reduce_umin", visibility_ = 0 : i64}> ({
  ^bb0(%arg21: i32):
    %63 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %64 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %65 = "llvm.call"(%63, %64, %arg21) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_GroupUMiniij, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>, will_return}> : (i32, i32, i32) -> i32
    "llvm.return"(%65) : (i32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "group_reduce_smin", visibility_ = 0 : i64}> ({
  ^bb0(%arg20: i32):
    %60 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %61 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %62 = "llvm.call"(%60, %61, %arg20) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_GroupSMiniij, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>, will_return}> : (i32, i32, i32) -> i32
    "llvm.return"(%62) : (i32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "group_reduce_fmax", visibility_ = 0 : i64}> ({
  ^bb0(%arg19: f32):
    %57 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %58 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %59 = "llvm.call"(%57, %58, %arg19) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_GroupFMaxiif, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>, will_return}> : (i32, i32, f32) -> f32
    "llvm.return"(%59) : (f32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "group_reduce_umax", visibility_ = 0 : i64}> ({
  ^bb0(%arg18: i32):
    %54 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %55 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %56 = "llvm.call"(%54, %55, %arg18) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_GroupUMaxiij, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>, will_return}> : (i32, i32, i32) -> i32
    "llvm.return"(%56) : (i32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "group_reduce_smax", visibility_ = 0 : i64}> ({
  ^bb0(%arg17: i32):
    %51 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %52 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %53 = "llvm.call"(%51, %52, %arg17) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_GroupSMaxiij, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>, will_return}> : (i32, i32, i32) -> i32
    "llvm.return"(%53) : (i32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "group_inclusive_scan_iadd", visibility_ = 0 : i64}> ({
  ^bb0(%arg16: i32):
    %48 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %49 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %50 = "llvm.call"(%48, %49, %arg16) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_GroupIAddiij, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>, will_return}> : (i32, i32, i32) -> i32
    "llvm.return"(%50) : (i32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "group_inclusive_scan_fadd", visibility_ = 0 : i64}> ({
  ^bb0(%arg15: f32):
    %45 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %46 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %47 = "llvm.call"(%45, %46, %arg15) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_GroupFAddiif, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>, will_return}> : (i32, i32, f32) -> f32
    "llvm.return"(%47) : (f32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "group_inclusive_scan_fmin", visibility_ = 0 : i64}> ({
  ^bb0(%arg14: f32):
    %42 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %43 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %44 = "llvm.call"(%42, %43, %arg14) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_GroupFMiniif, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>, will_return}> : (i32, i32, f32) -> f32
    "llvm.return"(%44) : (f32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "group_inclusive_scan_umin", visibility_ = 0 : i64}> ({
  ^bb0(%arg13: i32):
    %39 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %40 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %41 = "llvm.call"(%39, %40, %arg13) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_GroupUMiniij, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>, will_return}> : (i32, i32, i32) -> i32
    "llvm.return"(%41) : (i32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "group_inclusive_scan_smin", visibility_ = 0 : i64}> ({
  ^bb0(%arg12: i32):
    %36 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %37 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %38 = "llvm.call"(%36, %37, %arg12) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_GroupSMiniij, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>, will_return}> : (i32, i32, i32) -> i32
    "llvm.return"(%38) : (i32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "group_inclusive_scan_fmax", visibility_ = 0 : i64}> ({
  ^bb0(%arg11: f32):
    %33 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %34 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %35 = "llvm.call"(%33, %34, %arg11) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_GroupFMaxiif, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>, will_return}> : (i32, i32, f32) -> f32
    "llvm.return"(%35) : (f32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "group_inclusive_scan_umax", visibility_ = 0 : i64}> ({
  ^bb0(%arg10: i32):
    %30 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %31 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %32 = "llvm.call"(%30, %31, %arg10) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_GroupUMaxiij, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>, will_return}> : (i32, i32, i32) -> i32
    "llvm.return"(%32) : (i32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "group_inclusive_scan_smax", visibility_ = 0 : i64}> ({
  ^bb0(%arg9: i32):
    %27 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %28 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %29 = "llvm.call"(%27, %28, %arg9) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_GroupSMaxiij, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>, will_return}> : (i32, i32, i32) -> i32
    "llvm.return"(%29) : (i32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "group_exclusive_scan_iadd", visibility_ = 0 : i64}> ({
  ^bb0(%arg8: i32):
    %24 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %25 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %26 = "llvm.call"(%24, %25, %arg8) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_GroupIAddiij, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>, will_return}> : (i32, i32, i32) -> i32
    "llvm.return"(%26) : (i32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "group_exclusive_scan_fadd", visibility_ = 0 : i64}> ({
  ^bb0(%arg7: f32):
    %21 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %22 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %23 = "llvm.call"(%21, %22, %arg7) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_GroupFAddiif, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>, will_return}> : (i32, i32, f32) -> f32
    "llvm.return"(%23) : (f32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "group_exclusive_scan_fmin", visibility_ = 0 : i64}> ({
  ^bb0(%arg6: f32):
    %18 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %19 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %20 = "llvm.call"(%18, %19, %arg6) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_GroupFMiniif, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>, will_return}> : (i32, i32, f32) -> f32
    "llvm.return"(%20) : (f32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "group_exclusive_scan_umin", visibility_ = 0 : i64}> ({
  ^bb0(%arg5: i32):
    %15 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %16 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %17 = "llvm.call"(%15, %16, %arg5) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_GroupUMiniij, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>, will_return}> : (i32, i32, i32) -> i32
    "llvm.return"(%17) : (i32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "group_exclusive_scan_smin", visibility_ = 0 : i64}> ({
  ^bb0(%arg4: i32):
    %12 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %13 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %14 = "llvm.call"(%12, %13, %arg4) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_GroupSMiniij, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>, will_return}> : (i32, i32, i32) -> i32
    "llvm.return"(%14) : (i32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "group_exclusive_scan_fmax", visibility_ = 0 : i64}> ({
  ^bb0(%arg3: f32):
    %9 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %10 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %11 = "llvm.call"(%9, %10, %arg3) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_GroupFMaxiif, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>, will_return}> : (i32, i32, f32) -> f32
    "llvm.return"(%11) : (f32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "group_exclusive_scan_umax", visibility_ = 0 : i64}> ({
  ^bb0(%arg2: i32):
    %6 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %7 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %8 = "llvm.call"(%6, %7, %arg2) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_GroupUMaxiij, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>, will_return}> : (i32, i32, i32) -> i32
    "llvm.return"(%8) : (i32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "group_exclusive_scan_smax", visibility_ = 0 : i64}> ({
  ^bb0(%arg1: i32):
    %3 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %4 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %5 = "llvm.call"(%3, %4, %arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_GroupSMaxiij, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>, will_return}> : (i32, i32, i32) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "subgroup_exclusive_scan_smax", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i32):
    %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %2 = "llvm.call"(%0, %1, %arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z17__spirv_GroupSMaxiij, convergent, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>, will_return}> : (i32, i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

