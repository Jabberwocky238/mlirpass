"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "func_with_arg"}> ({
  ^bb0(%arg28: i32):
    %60 = "arith.addi"(%arg28, %arg28) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %61 = "builtin.unrealized_conversion_cast"(%60) : (i32) -> i64
    %62 = "builtin.unrealized_conversion_cast"(%61) : (i64) -> i32
    "func.return"(%62) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "inline_with_arg"}> ({
  ^bb0(%arg27: i32):
    %57 = "arith.addi"(%arg27, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %58 = "builtin.unrealized_conversion_cast"(%57) : (i32) -> i64
    %59 = "builtin.unrealized_conversion_cast"(%58) : (i64) -> i32
    "func.return"(%59) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "noinline_with_arg"}> ({
  ^bb0(%arg26: i32):
    %56 = "func.call"(%arg26) <{callee = @func_with_arg, no_inline}> : (i32) -> i32
    "func.return"(%56) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, no_inline, sym_name = "non_inlinable_func_with_arg"}> ({
  ^bb0(%arg25: i32):
    %55 = "arith.addi"(%arg25, %arg25) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%55) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "noinline_with_func_arg"}> ({
  ^bb0(%arg24: i32):
    %54 = "func.call"(%arg24) <{callee = @non_inlinable_func_with_arg}> : (i32) -> i32
    "func.return"(%54) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i32, sym_name = "func_with_multi_return"}> ({
  ^bb0(%arg23: i1):
    "cf.cond_br"(%arg23)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %52 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%52) : (i32) -> ()
  ^bb2:  // pred: ^bb0
    %53 = "arith.constant"() <{value = 55 : i32}> : () -> i32
    "func.return"(%53) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "inline_with_multi_return"}> ({
    %48 = "arith.constant"() <{value = false}> : () -> i1
    "cf.cond_br"(%48)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %49 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "cf.br"(%49)[^bb3] : (i32) -> ()
  ^bb2:  // pred: ^bb0
    %50 = "arith.constant"() <{value = 55 : i32}> : () -> i32
    "cf.br"(%50)[^bb3] : (i32) -> ()
  ^bb3(%51: i32):  // 2 preds: ^bb1, ^bb2
    "func.return"(%51) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "func_with_file_locations"}> ({
  ^bb0(%arg22: i32):
    %47 = "arith.addi"(%arg22, %arg22) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%47) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "func_with_callsite_locations"}> ({
  ^bb0(%arg21: i32):
    %46 = "arith.addi"(%arg21, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%46) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "inline_func_with_file_locations"}> ({
  ^bb0(%arg20: i32):
    %44 = "arith.addi"(%arg20, %arg20) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %45 = "arith.addi"(%44, %44) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%45) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "inline_func_with_callsite_locations"}> ({
  ^bb0(%arg19: i32):
    %42 = "arith.addi"(%arg19, %arg19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %43 = "arith.addi"(%42, %42) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%43) : (i32) -> ()
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
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "inline_multilevel"}> ({
    %41 = "test.functional_region_op"() ({
      "test.return"() : () -> ()
    }) : () -> (() -> ())
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "no_inline_recursive"}> ({
    %40 = "test.functional_region_op"() ({
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
    %39 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%39, %39) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i16, sym_name = "inline_convert_call"}> ({
    %36 = "arith.constant"() <{value = 0 : i16}> : () -> i16
    %37 = "test.cast"(%36) : (i16) -> i32
    %38 = "test.cast"(%37) : (i32) -> i16
    "func.return"(%38) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "convert_callee_fn_multiblock"}> ({
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %35 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%35) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i16, sym_name = "inline_convert_result_multiblock"}> ({
    "cf.br"()[^bb1] {inlined_conversion} : () -> ()
  ^bb1:  // pred: ^bb0
    %32 = "arith.constant"() <{value = 0 : i32}> {inlined_conversion} : () -> i32
    "cf.br"(%32)[^bb2] : (i32) -> ()
  ^bb2(%33: i32):  // pred: ^bb1
    %34 = "test.cast"(%33) : (i32) -> i16
    "func.return"(%34) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "no_inline_convert_call"}> ({
    %29 = "arith.constant"() <{value = 0 : i16}> : () -> i16
    %30 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    "test.conversion_call_op"(%29, %30) <{callee = @convert_callee_fn_multi_arg}> : (i16, i64) -> ()
    %31:2 = "test.conversion_call_op"() <{callee = @convert_callee_fn_multi_res}> : () -> (i16, i64)
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "simplify_return_constant"}> ({
    %28 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%28) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (() -> i32), sym_name = "simplify_return_reference"}> ({
    %27 = "func.constant"() <{value = @simplify_return_constant}> : () -> (() -> i32)
    "func.return"(%27) : (() -> i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "inline_simplify"}> ({
    %25 = "func.constant"() <{value = @simplify_return_constant}> : () -> (() -> i32)
    %26 = "func.call_indirect"(%25) : (() -> i32) -> i32
    "func.return"(%26) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "no_inline_invalid_call"}> ({
    %24 = "test.conversion_call_op"() <{callee = @convert_callee_fn_multiblock}> {noinline} : () -> i32
    "func.return"(%24) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<1024xf32>, sym_name = "gpu_alloc"}> ({
    %23 = "gpu.alloc"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> memref<1024xf32>
    "func.return"(%23) : (memref<1024xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<1024xf32>, sym_name = "inline_gpu_ops"}> ({
    %22 = "gpu.alloc"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> memref<1024xf32>
    "func.return"(%22) : (memref<1024xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_block_args_location"}> ({
  ^bb0(%arg15: i32):
    "cf.br"(%arg15)[^bb1] : (i32) -> ()
  ^bb1(%21: i32):  // pred: ^bb0
    "test.foo"(%21) : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_block_args_location_callee1"}> ({
  ^bb0(%arg14: i32):
    "cf.br"(%arg14)[^bb1] : (i32) -> ()
  ^bb1(%20: i32):  // pred: ^bb0
    "test.foo"(%20) : (i32) -> ()
    "cf.br"()[^bb2] : () -> ()
  ^bb2:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_block_args_location_callee2"}> ({
  ^bb0(%arg13: i32):
    "cf.br"(%arg13)[^bb1] : (i32) -> ()
  ^bb1(%19: i32):  // pred: ^bb0
    "test.foo"(%19) : (i32) -> ()
    "cf.br"()[^bb2] : () -> ()
  ^bb2:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_multiple_blocks"}> ({
  ^bb0(%arg12: i32):
    "cf.br"(%arg12)[^bb1] : (i32) -> ()
  ^bb1(%18: i32):  // pred: ^bb0
    "test.foo"(%18) : (i32) -> ()
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
    %17 = "scf.while"(%arg7) ({
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
    %15 = "arith.addi"(%arg5, %arg6) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16
    %16 = "arith.subi"(%arg5, %arg6) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16
    "test.return"(%15, %16) : (i16, i16) -> ()
  }) : () -> ()
  "test.conversion_func_op"() <{arg_attrs = [{test.handle_argument}], function_type = (i32) -> i32, res_attrs = [{test.handle_result}], sym_name = "handle_attr_callee_fn"}> ({
  ^bb0(%arg4: i32):
    "test.return"(%arg4) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i16, i16) -> (i16, i16), sym_name = "inline_handle_attr_call"}> ({
  ^bb0(%arg2: i16, %arg3: i16):
    %11 = "test.type_changer"(%arg3) : (i16) -> i16
    %12 = "arith.addi"(%arg2, %11) <{overflowFlags = #arith.overflow<none>}> {inlined_conversion} : (i16, i16) -> i16
    %13 = "arith.subi"(%arg2, %11) <{overflowFlags = #arith.overflow<none>}> {inlined_conversion} : (i16, i16) -> i16
    %14 = "test.type_changer"(%12) : (i16) -> i16
    "func.return"(%14, %13) : (i16, i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i16) -> i16, sym_name = "inline_convert_and_handle_attr_call"}> ({
  ^bb0(%arg1: i16):
    %7 = "test.cast"(%arg1) : (i16) -> i32
    %8 = "test.type_changer"(%7) : (i32) -> i32
    %9 = "test.type_changer"(%8) : (i32) -> i32
    %10 = "test.cast"(%9) : (i32) -> i16
    "func.return"(%10) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "double_square_complex"}> ({
  ^bb0(%arg0: complex<f32>):
    %5 = "complex.add"(%arg0, %arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    %6 = "complex.mul"(%5, %5) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%6) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "inline_with_complex_ops"}> ({
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %2 = "complex.create"(%0, %1) : (f32, f32) -> complex<f32>
    %3 = "complex.add"(%2, %2) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    %4 = "complex.mul"(%3, %3) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%4) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

