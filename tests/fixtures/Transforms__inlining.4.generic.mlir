"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "func_with_arg"}> ({
  ^bb0(%arg26: i32):
    %48 = "arith.addi"(%arg26, %arg26) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%48) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "inline_with_arg"}> ({
  ^bb0(%arg25: i32):
    %47 = "arith.addi"(%arg25, %arg25) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%47) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "noinline_with_arg"}> ({
  ^bb0(%arg24: i32):
    %46 = "func.call"(%arg24) <{callee = @func_with_arg, no_inline}> : (i32) -> i32
    "func.return"(%46) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, no_inline, sym_name = "non_inlinable_func_with_arg"}> ({
  ^bb0(%arg23: i32):
    %45 = "arith.addi"(%arg23, %arg23) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%45) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "noinline_with_func_arg"}> ({
  ^bb0(%arg22: i32):
    %44 = "func.call"(%arg22) <{callee = @non_inlinable_func_with_arg}> : (i32) -> i32
    "func.return"(%44) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i32, sym_name = "func_with_multi_return"}> ({
  ^bb0(%arg21: i1):
    %42 = "arith.constant"() <{value = 55 : i32}> : () -> i32
    %43 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "cf.cond_br"(%arg21)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"(%43) : (i32) -> ()
  ^bb2:  // pred: ^bb0
    "func.return"(%42) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "inline_with_multi_return"}> ({
    %41 = "arith.constant"() <{value = 55 : i32}> : () -> i32
    "func.return"(%41) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "func_with_file_locations"}> ({
  ^bb0(%arg20: i32):
    %40 = "arith.addi"(%arg20, %arg20) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%40) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "func_with_callsite_locations"}> ({
  ^bb0(%arg19: i32):
    %39 = "arith.addi"(%arg19, %arg19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%39) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "inline_func_with_file_locations"}> ({
  ^bb0(%arg18: i32):
    %37 = "arith.addi"(%arg18, %arg18) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %38 = "arith.addi"(%37, %37) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%38) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "inline_func_with_callsite_locations"}> ({
  ^bb0(%arg17: i32):
    %35 = "arith.addi"(%arg17, %arg17) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %36 = "arith.addi"(%35, %35) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%36) : (i32) -> ()
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
    %34 = "test.functional_region_op"() ({
      "test.return"() : () -> ()
    }) : () -> (() -> ())
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "no_inline_recursive"}> ({
    %33 = "test.functional_region_op"() ({
      "func.call"() <{callee = @no_inline_recursive}> : () -> ()
      "test.return"() : () -> ()
    }) : () -> (() -> ())
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "convert_callee_fn"}> ({
  ^bb0(%arg16: i32):
    "func.return"(%arg16) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "convert_callee_fn_multi_arg"}> ({
  ^bb0(%arg14: i32, %arg15: i32):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "convert_callee_fn_multi_res"}> ({
    %32 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%32, %32) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i16, sym_name = "inline_convert_call"}> ({
    %29 = "arith.constant"() <{value = 0 : i16}> : () -> i16
    %30 = "test.cast"(%29) : (i16) -> i32
    %31 = "test.cast"(%30) : (i32) -> i16
    "func.return"(%31) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "convert_callee_fn_multiblock"}> ({
    %28 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%28) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i16, sym_name = "inline_convert_result_multiblock"}> ({
    %26 = "arith.constant"() <{value = 0 : i32}> {inlined_conversion} : () -> i32
    %27 = "test.cast"(%26) : (i32) -> i16
    "func.return"(%27) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "no_inline_convert_call"}> ({
    %23 = "arith.constant"() <{value = 0 : i16}> : () -> i16
    %24 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    "test.conversion_call_op"(%23, %24) <{callee = @convert_callee_fn_multi_arg}> : (i16, i64) -> ()
    %25:2 = "test.conversion_call_op"() <{callee = @convert_callee_fn_multi_res}> : () -> (i16, i64)
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "simplify_return_constant"}> ({
    %22 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%22) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (() -> i32), sym_name = "simplify_return_reference"}> ({
    %21 = "func.constant"() <{value = @simplify_return_constant}> : () -> (() -> i32)
    "func.return"(%21) : (() -> i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "inline_simplify"}> ({
    %20 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%20) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "no_inline_invalid_call"}> ({
    %19 = "test.conversion_call_op"() <{callee = @convert_callee_fn_multiblock}> {noinline} : () -> i32
    "func.return"(%19) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<1024xf32>, sym_name = "gpu_alloc"}> ({
    %18 = "gpu.alloc"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> memref<1024xf32>
    "func.return"(%18) : (memref<1024xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<1024xf32>, sym_name = "inline_gpu_ops"}> ({
    %17 = "gpu.alloc"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> memref<1024xf32>
    "func.return"(%17) : (memref<1024xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_block_args_location"}> ({
  ^bb0(%arg13: i32):
    "test.foo"(%arg13) : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_block_args_location_callee1"}> ({
  ^bb0(%arg12: i32):
    "test.foo"(%arg12) : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_block_args_location_callee2"}> ({
  ^bb0(%arg11: i32):
    "test.foo"(%arg11) : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_multiple_blocks"}> ({
  ^bb0(%arg10: i32):
    "test.foo"(%arg10) : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_multiple_blocks_callee1"}> ({
  ^bb0(%arg9: i32):
    "test.dummy_op"() ({
      "test.foo"(%arg9) : (i32) -> ()
      "test.terminator"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i1) -> (), sym_name = "func_with_multiple_blocks_callee2"}> ({
  ^bb0(%arg7: i32, %arg8: i1):
    "scf.while"() ({
      "test.foo"(%arg7) : (i32) -> ()
      "scf.condition"(%arg8) : (i1) -> ()
    }, {
      "scf.yield"() : () -> ()
    }) : () -> ()
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

