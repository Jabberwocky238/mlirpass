"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "func_with_arg"}> ({
  ^bb0(%arg34: i32):
    %51 = "arith.addi"(%arg34, %arg34) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %52 = "builtin.unrealized_conversion_cast"(%51) : (i32) -> i64
    %53 = "builtin.unrealized_conversion_cast"(%52) : (i64) -> i32
    "func.return"(%53) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "inline_with_arg"}> ({
  ^bb0(%arg33: i32):
    %50 = "func.call"(%arg33) <{callee = @func_with_arg}> : (i32) -> i32
    "func.return"(%50) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "noinline_with_arg"}> ({
  ^bb0(%arg32: i32):
    %49 = "func.call"(%arg32) <{callee = @func_with_arg, no_inline}> : (i32) -> i32
    "func.return"(%49) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, no_inline, sym_name = "non_inlinable_func_with_arg"}> ({
  ^bb0(%arg31: i32):
    %48 = "arith.addi"(%arg31, %arg31) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%48) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "noinline_with_func_arg"}> ({
  ^bb0(%arg30: i32):
    %47 = "func.call"(%arg30) <{callee = @non_inlinable_func_with_arg}> : (i32) -> i32
    "func.return"(%47) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i32, sym_name = "func_with_multi_return"}> ({
  ^bb0(%arg29: i1):
    "cf.cond_br"(%arg29)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %45 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%45) : (i32) -> ()
  ^bb2:  // pred: ^bb0
    %46 = "arith.constant"() <{value = 55 : i32}> : () -> i32
    "func.return"(%46) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "inline_with_multi_return"}> ({
    %43 = "arith.constant"() <{value = false}> : () -> i1
    %44 = "func.call"(%43) <{callee = @func_with_multi_return}> : (i1) -> i32
    "func.return"(%44) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "func_with_file_locations"}> ({
  ^bb0(%arg28: i32):
    %42 = "arith.addi"(%arg28, %arg28) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%42) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "func_with_callsite_locations"}> ({
  ^bb0(%arg27: i32):
    %41 = "arith.addi"(%arg27, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%41) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "inline_func_with_file_locations"}> ({
  ^bb0(%arg26: i32):
    %39 = "func.call"(%arg26) <{callee = @func_with_file_locations}> : (i32) -> i32
    %40 = "func.call"(%39) <{callee = @func_with_file_locations}> : (i32) -> i32
    "func.return"(%40) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "inline_func_with_callsite_locations"}> ({
  ^bb0(%arg25: i32):
    %37 = "func.call"(%arg25) <{callee = @func_with_callsite_locations}> : (i32) -> i32
    %38 = "func.call"(%37) <{callee = @func_with_callsite_locations}> : (i32) -> i32
    "func.return"(%38) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "func_external", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "no_inline_external"}> ({
    "func.call"() <{callee = @func_external}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "multilevel_func_a"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "multilevel_func_b"}> ({
    "func.call"() <{callee = @multilevel_func_a}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "inline_multilevel"}> ({
    %36 = "test.functional_region_op"() ({
      "func.call"() <{callee = @multilevel_func_b}> : () -> ()
      "test.return"() : () -> ()
    }) : () -> (() -> ())
    "func.call_indirect"(%36) : (() -> ()) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "no_inline_recursive"}> ({
    %35 = "test.functional_region_op"() ({
      "func.call"() <{callee = @no_inline_recursive}> : () -> ()
      "test.return"() : () -> ()
    }) : () -> (() -> ())
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "convert_callee_fn"}> ({
  ^bb0(%arg24: i32):
    "func.return"(%arg24) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "convert_callee_fn_multi_arg"}> ({
  ^bb0(%arg22: i32, %arg23: i32):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "convert_callee_fn_multi_res"}> ({
    %34 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%34, %34) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i16, sym_name = "inline_convert_call"}> ({
    %32 = "arith.constant"() <{value = 0 : i16}> : () -> i16
    %33 = "test.conversion_call_op"(%32) <{callee = @convert_callee_fn}> : (i16) -> i16
    "func.return"(%33) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "convert_callee_fn_multiblock"}> ({
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %31 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%31) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i16, sym_name = "inline_convert_result_multiblock"}> ({
    %30 = "test.conversion_call_op"() <{callee = @convert_callee_fn_multiblock}> : () -> i16
    "func.return"(%30) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "no_inline_convert_call"}> ({
    %27 = "arith.constant"() <{value = 0 : i16}> : () -> i16
    %28 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    "test.conversion_call_op"(%27, %28) <{callee = @convert_callee_fn_multi_arg}> : (i16, i64) -> ()
    %29:2 = "test.conversion_call_op"() <{callee = @convert_callee_fn_multi_res}> : () -> (i16, i64)
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "simplify_return_constant"}> ({
    %26 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%26) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (() -> i32), sym_name = "simplify_return_reference"}> ({
    %25 = "func.constant"() <{value = @simplify_return_constant}> : () -> (() -> i32)
    "func.return"(%25) : (() -> i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "inline_simplify"}> ({
    %23 = "func.call"() <{callee = @simplify_return_reference}> : () -> (() -> i32)
    %24 = "func.call_indirect"(%23) : (() -> i32) -> i32
    "func.return"(%24) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "no_inline_invalid_call"}> ({
    %22 = "test.conversion_call_op"() <{callee = @convert_callee_fn_multiblock}> {noinline} : () -> i32
    "func.return"(%22) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<1024xf32>, sym_name = "gpu_alloc"}> ({
    %21 = "gpu.alloc"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> memref<1024xf32>
    "func.return"(%21) : (memref<1024xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<1024xf32>, sym_name = "inline_gpu_ops"}> ({
    %20 = "func.call"() <{callee = @gpu_alloc}> : () -> memref<1024xf32>
    "func.return"(%20) : (memref<1024xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_block_args_location"}> ({
  ^bb0(%arg21: i32):
    "cf.br"(%arg21)[^bb1] : (i32) -> ()
  ^bb1(%19: i32):  // pred: ^bb0
    "test.foo"(%19) : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_block_args_location_callee1"}> ({
  ^bb0(%arg20: i32):
    "func.call"(%arg20) <{callee = @func_with_block_args_location}> : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_block_args_location_callee2"}> ({
  ^bb0(%arg19: i32):
    "func.call"(%arg19) <{callee = @func_with_block_args_location}> : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_multiple_blocks"}> ({
  ^bb0(%arg18: i32):
    "cf.br"(%arg18)[^bb1] : (i32) -> ()
  ^bb1(%18: i32):  // pred: ^bb0
    "test.foo"(%18) : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_multiple_blocks_callee1"}> ({
  ^bb0(%arg17: i32):
    "test.dummy_op"() ({
      "func.call"(%arg17) <{callee = @func_with_multiple_blocks}> : (i32) -> ()
      "test.terminator"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i1) -> (), sym_name = "func_with_multiple_blocks_callee2"}> ({
  ^bb0(%arg13: i32, %arg14: i1):
    %17 = "scf.while"(%arg13) ({
    ^bb0(%arg16: i32):
      "func.call"(%arg13) <{callee = @func_with_multiple_blocks}> : (i32) -> ()
      "scf.condition"(%arg14, %arg16) : (i1, i32) -> ()
    }, {
    ^bb0(%arg15: i32):
      "scf.yield"(%arg15) : (i32) -> ()
    }) : (i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "test.conversion_func_op"() <{arg_attrs = [{}, {test.handle_argument}], function_type = (i16, i16) -> (i16, i16), res_attrs = [{test.handle_result}, {}], sym_name = "handle_attr_callee_fn_multi_arg"}> ({
  ^bb0(%arg11: i16, %arg12: i16):
    %15 = "arith.addi"(%arg11, %arg12) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16
    %16 = "arith.subi"(%arg11, %arg12) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16
    "test.return"(%15, %16) : (i16, i16) -> ()
  }) : () -> ()
  "test.conversion_func_op"() <{arg_attrs = [{test.handle_argument}], function_type = (i32) -> i32, res_attrs = [{test.handle_result}], sym_name = "handle_attr_callee_fn"}> ({
  ^bb0(%arg10: i32):
    "test.return"(%arg10) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i16, i16) -> (i16, i16), sym_name = "inline_handle_attr_call"}> ({
  ^bb0(%arg8: i16, %arg9: i16):
    %14:2 = "test.conversion_call_op"(%arg8, %arg9) <{callee = @handle_attr_callee_fn_multi_arg}> : (i16, i16) -> (i16, i16)
    "func.return"(%14#0, %14#1) : (i16, i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i16) -> i16, sym_name = "inline_convert_and_handle_attr_call"}> ({
  ^bb0(%arg7: i16):
    %13 = "test.conversion_call_op"(%arg7) <{callee = @handle_attr_callee_fn}> : (i16) -> i16
    "func.return"(%13) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "double_square_complex"}> ({
  ^bb0(%arg6: complex<f32>):
    %11 = "complex.add"(%arg6, %arg6) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    %12 = "complex.mul"(%11, %11) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%12) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "inline_with_complex_ops"}> ({
    %7 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %8 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %9 = "complex.create"(%7, %8) : (f32, f32) -> complex<f32>
    %10 = "func.call"(%9) <{callee = @double_square_complex}> : (complex<f32>) -> complex<f32>
    "func.return"(%10) : (complex<f32>) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f16, f16)>, linkage = #llvm.linkage<external>, sym_name = "inline_test_return_arity_mismatch", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg4: f16, %arg5: f16):
    "llvm.call"(%arg4, %arg5) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @inline_test_return_arity_mismatch_callee, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (f16, f16) -> ()
    "llvm.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f16, f16)>, linkage = #llvm.linkage<external>, sym_name = "inline_test_return_arity_mismatch_callee", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg2: f16, %arg3: f16):
    %5 = "test.op_with_bitcast_type"(%arg2) : (f16) -> tensor<4xf32>
    %6 = "test.op_with_bitcast_type"(%arg3) : (f16) -> tensor<2xi32>
    "test.return"(%5, %6) : (tensor<4xf32>, tensor<2xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "inline_functional_region_multiblock"}> ({
  ^bb0(%arg0: i32):
    %0 = "test.functional_region_op"() ({
    ^bb0(%arg1: i32):
      %2 = "arith.addi"(%arg1, %arg1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "cf.br"(%2)[^bb1] : (i32) -> ()
    ^bb1(%3: i32):  // pred: ^bb0
      %4 = "arith.addi"(%3, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "test.return"(%4) : (i32) -> ()
    }) : () -> ((i32) -> i32)
    %1 = "func.call_indirect"(%0, %arg0) : ((i32) -> i32, i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

