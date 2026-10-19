"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "func_with_arg"}> ({
  ^bb0(%arg28: i32):
    %44 = "arith.addi"(%arg28, %arg28) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %45 = "builtin.unrealized_conversion_cast"(%44) : (i32) -> i64
    %46 = "builtin.unrealized_conversion_cast"(%45) : (i64) -> i32
    "func.return"(%46) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "inline_with_arg"}> ({
  ^bb0(%arg27: i32):
    %43 = "func.call"(%arg27) <{callee = @func_with_arg}> : (i32) -> i32
    "func.return"(%43) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "noinline_with_arg"}> ({
  ^bb0(%arg26: i32):
    %42 = "func.call"(%arg26) <{callee = @func_with_arg, no_inline}> : (i32) -> i32
    "func.return"(%42) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, no_inline, sym_name = "non_inlinable_func_with_arg"}> ({
  ^bb0(%arg25: i32):
    %41 = "arith.addi"(%arg25, %arg25) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%41) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "noinline_with_func_arg"}> ({
  ^bb0(%arg24: i32):
    %40 = "func.call"(%arg24) <{callee = @non_inlinable_func_with_arg}> : (i32) -> i32
    "func.return"(%40) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i32, sym_name = "func_with_multi_return"}> ({
  ^bb0(%arg23: i1):
    "cf.cond_br"(%arg23)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %38 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%38) : (i32) -> ()
  ^bb2:  // pred: ^bb0
    %39 = "arith.constant"() <{value = 55 : i32}> : () -> i32
    "func.return"(%39) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "inline_with_multi_return"}> ({
    %36 = "arith.constant"() <{value = false}> : () -> i1
    %37 = "func.call"(%36) <{callee = @func_with_multi_return}> : (i1) -> i32
    "func.return"(%37) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "func_with_file_locations"}> ({
  ^bb0(%arg22: i32):
    %35 = "arith.addi"(%arg22, %arg22) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%35) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "func_with_callsite_locations"}> ({
  ^bb0(%arg21: i32):
    %34 = "arith.addi"(%arg21, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%34) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "inline_func_with_file_locations"}> ({
  ^bb0(%arg20: i32):
    %32 = "func.call"(%arg20) <{callee = @func_with_file_locations}> : (i32) -> i32
    %33 = "func.call"(%32) <{callee = @func_with_file_locations}> : (i32) -> i32
    "func.return"(%33) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "inline_func_with_callsite_locations"}> ({
  ^bb0(%arg19: i32):
    %30 = "func.call"(%arg19) <{callee = @func_with_callsite_locations}> : (i32) -> i32
    %31 = "func.call"(%30) <{callee = @func_with_callsite_locations}> : (i32) -> i32
    "func.return"(%31) : (i32) -> ()
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
    %29 = "test.functional_region_op"() ({
      "func.call"() <{callee = @multilevel_func_b}> : () -> ()
      "test.return"() : () -> ()
    }) : () -> (() -> ())
    "func.call_indirect"(%29) : (() -> ()) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "no_inline_recursive"}> ({
    %28 = "test.functional_region_op"() ({
      "func.call"() <{callee = @no_inline_recursive}> : () -> ()
      "test.return"() : () -> ()
    }) : () -> (() -> ())
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "convert_callee_fn"}> ({
  ^bb0(%arg18: i32):
    "func.return"(%arg18) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "convert_callee_fn_multi_arg"}> ({
  ^bb0(%arg16: i32, %arg17: i32):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "convert_callee_fn_multi_res"}> ({
    %27 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%27, %27) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i16, sym_name = "inline_convert_call"}> ({
    %25 = "arith.constant"() <{value = 0 : i16}> : () -> i16
    %26 = "test.conversion_call_op"(%25) <{callee = @convert_callee_fn}> : (i16) -> i16
    "func.return"(%26) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "convert_callee_fn_multiblock"}> ({
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %24 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%24) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i16, sym_name = "inline_convert_result_multiblock"}> ({
    %23 = "test.conversion_call_op"() <{callee = @convert_callee_fn_multiblock}> : () -> i16
    "func.return"(%23) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "no_inline_convert_call"}> ({
    %20 = "arith.constant"() <{value = 0 : i16}> : () -> i16
    %21 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    "test.conversion_call_op"(%20, %21) <{callee = @convert_callee_fn_multi_arg}> : (i16, i64) -> ()
    %22:2 = "test.conversion_call_op"() <{callee = @convert_callee_fn_multi_res}> : () -> (i16, i64)
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "simplify_return_constant"}> ({
    %19 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%19) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (() -> i32), sym_name = "simplify_return_reference"}> ({
    %18 = "func.constant"() <{value = @simplify_return_constant}> : () -> (() -> i32)
    "func.return"(%18) : (() -> i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "inline_simplify"}> ({
    %16 = "func.call"() <{callee = @simplify_return_reference}> : () -> (() -> i32)
    %17 = "func.call_indirect"(%16) : (() -> i32) -> i32
    "func.return"(%17) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "no_inline_invalid_call"}> ({
    %15 = "test.conversion_call_op"() <{callee = @convert_callee_fn_multiblock}> {noinline} : () -> i32
    "func.return"(%15) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<1024xf32>, sym_name = "gpu_alloc"}> ({
    %14 = "gpu.alloc"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> memref<1024xf32>
    "func.return"(%14) : (memref<1024xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<1024xf32>, sym_name = "inline_gpu_ops"}> ({
    %13 = "func.call"() <{callee = @gpu_alloc}> : () -> memref<1024xf32>
    "func.return"(%13) : (memref<1024xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_block_args_location"}> ({
  ^bb0(%arg15: i32):
    "cf.br"(%arg15)[^bb1] : (i32) -> ()
  ^bb1(%12: i32):  // pred: ^bb0
    "test.foo"(%12) : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_block_args_location_callee1"}> ({
  ^bb0(%arg14: i32):
    "func.call"(%arg14) <{callee = @func_with_block_args_location}> : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_block_args_location_callee2"}> ({
  ^bb0(%arg13: i32):
    "func.call"(%arg13) <{callee = @func_with_block_args_location}> : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_multiple_blocks"}> ({
  ^bb0(%arg12: i32):
    "cf.br"(%arg12)[^bb1] : (i32) -> ()
  ^bb1(%11: i32):  // pred: ^bb0
    "test.foo"(%11) : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_multiple_blocks_callee1"}> ({
  ^bb0(%arg11: i32):
    "test.dummy_op"() ({
      "func.call"(%arg11) <{callee = @func_with_multiple_blocks}> : (i32) -> ()
      "test.terminator"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i1) -> (), sym_name = "func_with_multiple_blocks_callee2"}> ({
  ^bb0(%arg7: i32, %arg8: i1):
    %10 = "scf.while"(%arg7) ({
    ^bb0(%arg10: i32):
      "func.call"(%arg7) <{callee = @func_with_multiple_blocks}> : (i32) -> ()
      "scf.condition"(%arg8, %arg10) : (i1, i32) -> ()
    }, {
    ^bb0(%arg9: i32):
      "scf.yield"(%arg9) : (i32) -> ()
    }) : (i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "test.conversion_func_op"() <{arg_attrs = [{}, {test.handle_argument}], function_type = (i16, i16) -> (i16, i16), res_attrs = [{test.handle_result}, {}], sym_name = "handle_attr_callee_fn_multi_arg"}> ({
  ^bb0(%arg5: i16, %arg6: i16):
    %8 = "arith.addi"(%arg5, %arg6) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16
    %9 = "arith.subi"(%arg5, %arg6) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16
    "test.return"(%8, %9) : (i16, i16) -> ()
  }) : () -> ()
  "test.conversion_func_op"() <{arg_attrs = [{test.handle_argument}], function_type = (i32) -> i32, res_attrs = [{test.handle_result}], sym_name = "handle_attr_callee_fn"}> ({
  ^bb0(%arg4: i32):
    "test.return"(%arg4) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i16, i16) -> (i16, i16), sym_name = "inline_handle_attr_call"}> ({
  ^bb0(%arg2: i16, %arg3: i16):
    %7:2 = "test.conversion_call_op"(%arg2, %arg3) <{callee = @handle_attr_callee_fn_multi_arg}> : (i16, i16) -> (i16, i16)
    "func.return"(%7#0, %7#1) : (i16, i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i16) -> i16, sym_name = "inline_convert_and_handle_attr_call"}> ({
  ^bb0(%arg1: i16):
    %6 = "test.conversion_call_op"(%arg1) <{callee = @handle_attr_callee_fn}> : (i16) -> i16
    "func.return"(%6) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "double_square_complex"}> ({
  ^bb0(%arg0: complex<f32>):
    %4 = "complex.add"(%arg0, %arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    %5 = "complex.mul"(%4, %4) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%5) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "inline_with_complex_ops"}> ({
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %2 = "complex.create"(%0, %1) : (f32, f32) -> complex<f32>
    %3 = "func.call"(%2) <{callee = @double_square_complex}> : (complex<f32>) -> complex<f32>
    "func.return"(%3) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

