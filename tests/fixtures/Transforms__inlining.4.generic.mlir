"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "func_with_arg"}> ({
  ^bb0(%arg32: i32):
    %60 = "arith.addi"(%arg32, %arg32) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%60) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "inline_with_arg"}> ({
  ^bb0(%arg31: i32):
    %59 = "arith.addi"(%arg31, %arg31) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%59) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "noinline_with_arg"}> ({
  ^bb0(%arg30: i32):
    %58 = "func.call"(%arg30) <{callee = @func_with_arg, no_inline}> : (i32) -> i32
    "func.return"(%58) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, no_inline, sym_name = "non_inlinable_func_with_arg"}> ({
  ^bb0(%arg29: i32):
    %57 = "arith.addi"(%arg29, %arg29) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%57) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "noinline_with_func_arg"}> ({
  ^bb0(%arg28: i32):
    %56 = "func.call"(%arg28) <{callee = @non_inlinable_func_with_arg}> : (i32) -> i32
    "func.return"(%56) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i32, sym_name = "func_with_multi_return"}> ({
  ^bb0(%arg27: i1):
    %54 = "arith.constant"() <{value = 55 : i32}> : () -> i32
    %55 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "cf.cond_br"(%arg27)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"(%55) : (i32) -> ()
  ^bb2:  // pred: ^bb0
    "func.return"(%54) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "inline_with_multi_return"}> ({
    %53 = "arith.constant"() <{value = 55 : i32}> : () -> i32
    "func.return"(%53) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "func_with_file_locations"}> ({
  ^bb0(%arg26: i32):
    %52 = "arith.addi"(%arg26, %arg26) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%52) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "func_with_callsite_locations"}> ({
  ^bb0(%arg25: i32):
    %51 = "arith.addi"(%arg25, %arg25) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%51) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "inline_func_with_file_locations"}> ({
  ^bb0(%arg24: i32):
    %49 = "arith.addi"(%arg24, %arg24) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %50 = "arith.addi"(%49, %49) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%50) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "inline_func_with_callsite_locations"}> ({
  ^bb0(%arg23: i32):
    %47 = "arith.addi"(%arg23, %arg23) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %48 = "arith.addi"(%47, %47) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%48) : (i32) -> ()
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
    %46 = "test.functional_region_op"() ({
      "test.return"() : () -> ()
    }) : () -> (() -> ())
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "no_inline_recursive"}> ({
    %45 = "test.functional_region_op"() ({
      "func.call"() <{callee = @no_inline_recursive}> : () -> ()
      "test.return"() : () -> ()
    }) : () -> (() -> ())
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "convert_callee_fn"}> ({
  ^bb0(%arg22: i32):
    "func.return"(%arg22) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "convert_callee_fn_multi_arg"}> ({
  ^bb0(%arg20: i32, %arg21: i32):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "convert_callee_fn_multi_res"}> ({
    %44 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%44, %44) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i16, sym_name = "inline_convert_call"}> ({
    %41 = "arith.constant"() <{value = 0 : i16}> : () -> i16
    %42 = "test.cast"(%41) : (i16) -> i32
    %43 = "test.cast"(%42) : (i32) -> i16
    "func.return"(%43) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "convert_callee_fn_multiblock"}> ({
    %40 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%40) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i16, sym_name = "inline_convert_result_multiblock"}> ({
    %38 = "arith.constant"() <{value = 0 : i32}> {inlined_conversion} : () -> i32
    %39 = "test.cast"(%38) : (i32) -> i16
    "func.return"(%39) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "no_inline_convert_call"}> ({
    %35 = "arith.constant"() <{value = 0 : i16}> : () -> i16
    %36 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    "test.conversion_call_op"(%35, %36) <{callee = @convert_callee_fn_multi_arg}> : (i16, i64) -> ()
    %37:2 = "test.conversion_call_op"() <{callee = @convert_callee_fn_multi_res}> : () -> (i16, i64)
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "simplify_return_constant"}> ({
    %34 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%34) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (() -> i32), sym_name = "simplify_return_reference"}> ({
    %33 = "func.constant"() <{value = @simplify_return_constant}> : () -> (() -> i32)
    "func.return"(%33) : (() -> i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "inline_simplify"}> ({
    %32 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%32) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "no_inline_invalid_call"}> ({
    %31 = "test.conversion_call_op"() <{callee = @convert_callee_fn_multiblock}> {noinline} : () -> i32
    "func.return"(%31) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<1024xf32>, sym_name = "gpu_alloc"}> ({
    %30 = "gpu.alloc"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> memref<1024xf32>
    "func.return"(%30) : (memref<1024xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<1024xf32>, sym_name = "inline_gpu_ops"}> ({
    %29 = "gpu.alloc"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> memref<1024xf32>
    "func.return"(%29) : (memref<1024xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_block_args_location"}> ({
  ^bb0(%arg19: i32):
    "test.foo"(%arg19) : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_block_args_location_callee1"}> ({
  ^bb0(%arg18: i32):
    "test.foo"(%arg18) : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_block_args_location_callee2"}> ({
  ^bb0(%arg17: i32):
    "test.foo"(%arg17) : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_multiple_blocks"}> ({
  ^bb0(%arg16: i32):
    "test.foo"(%arg16) : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_multiple_blocks_callee1"}> ({
  ^bb0(%arg15: i32):
    "test.dummy_op"() ({
      "test.foo"(%arg15) : (i32) -> ()
      "test.terminator"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i1) -> (), sym_name = "func_with_multiple_blocks_callee2"}> ({
  ^bb0(%arg13: i32, %arg14: i1):
    "scf.while"() ({
      "test.foo"(%arg13) : (i32) -> ()
      "scf.condition"(%arg14) : (i1) -> ()
    }, {
      "scf.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "test.conversion_func_op"() <{arg_attrs = [{}, {test.handle_argument}], function_type = (i16, i16) -> (i16, i16), res_attrs = [{test.handle_result}, {}], sym_name = "handle_attr_callee_fn_multi_arg"}> ({
  ^bb0(%arg11: i16, %arg12: i16):
    %27 = "arith.addi"(%arg11, %arg12) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16
    %28 = "arith.subi"(%arg11, %arg12) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16
    "test.return"(%27, %28) : (i16, i16) -> ()
  }) : () -> ()
  "test.conversion_func_op"() <{arg_attrs = [{test.handle_argument}], function_type = (i32) -> i32, res_attrs = [{test.handle_result}], sym_name = "handle_attr_callee_fn"}> ({
  ^bb0(%arg10: i32):
    "test.return"(%arg10) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i16, i16) -> (i16, i16), sym_name = "inline_handle_attr_call"}> ({
  ^bb0(%arg8: i16, %arg9: i16):
    %23 = "test.type_changer"(%arg9) : (i16) -> i16
    %24 = "arith.addi"(%arg8, %23) <{overflowFlags = #arith.overflow<none>}> {inlined_conversion} : (i16, i16) -> i16
    %25 = "arith.subi"(%arg8, %23) <{overflowFlags = #arith.overflow<none>}> {inlined_conversion} : (i16, i16) -> i16
    %26 = "test.type_changer"(%24) : (i16) -> i16
    "func.return"(%26, %25) : (i16, i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i16) -> i16, sym_name = "inline_convert_and_handle_attr_call"}> ({
  ^bb0(%arg7: i16):
    %19 = "test.cast"(%arg7) : (i16) -> i32
    %20 = "test.type_changer"(%19) : (i32) -> i32
    %21 = "test.type_changer"(%20) : (i32) -> i32
    %22 = "test.cast"(%21) : (i32) -> i16
    "func.return"(%22) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "double_square_complex"}> ({
  ^bb0(%arg6: complex<f32>):
    %17 = "complex.add"(%arg6, %arg6) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    %18 = "complex.mul"(%17, %17) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%18) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "inline_with_complex_ops"}> ({
    %12 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %13 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %14 = "complex.create"(%12, %13) : (f32, f32) -> complex<f32>
    %15 = "complex.add"(%14, %14) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    %16 = "complex.mul"(%15, %15) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%16) : (complex<f32>) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f16, f16)>, linkage = #llvm.linkage<external>, sym_name = "inline_test_return_arity_mismatch", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg4: f16, %arg5: f16):
    %10 = "test.op_with_bitcast_type"(%arg4) : (f16) -> tensor<4xf32>
    %11 = "test.op_with_bitcast_type"(%arg5) : (f16) -> tensor<2xi32>
    "llvm.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f16, f16)>, linkage = #llvm.linkage<external>, sym_name = "inline_test_return_arity_mismatch_callee", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg2: f16, %arg3: f16):
    %8 = "test.op_with_bitcast_type"(%arg2) : (f16) -> tensor<4xf32>
    %9 = "test.op_with_bitcast_type"(%arg3) : (f16) -> tensor<2xi32>
    "test.return"(%8, %9) : (tensor<4xf32>, tensor<2xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "inline_functional_region_multiblock"}> ({
  ^bb0(%arg0: i32):
    %0 = "test.functional_region_op"() ({
    ^bb0(%arg1: i32):
      %5 = "arith.addi"(%arg1, %arg1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "cf.br"(%5)[^bb1] : (i32) -> ()
    ^bb1(%6: i32):  // pred: ^bb0
      %7 = "arith.addi"(%6, %6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "test.return"(%7) : (i32) -> ()
    }) : () -> ((i32) -> i32)
    %1 = "arith.addi"(%arg0, %arg0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "cf.br"(%1)[^bb1] : (i32) -> ()
  ^bb1(%2: i32):  // pred: ^bb0
    %3 = "arith.addi"(%2, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "cf.br"(%3)[^bb2] : (i32) -> ()
  ^bb2(%4: i32):  // pred: ^bb1
    "func.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

