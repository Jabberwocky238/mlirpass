"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "func_with_arg"}> ({
  ^bb0(%arg34: i32):
    %72 = "arith.addi"(%arg34, %arg34) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %73 = "builtin.unrealized_conversion_cast"(%72) : (i32) -> i64
    %74 = "builtin.unrealized_conversion_cast"(%73) : (i64) -> i32
    "func.return"(%74) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "inline_with_arg"}> ({
  ^bb0(%arg33: i32):
    %69 = "arith.addi"(%arg33, %arg33) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %70 = "builtin.unrealized_conversion_cast"(%69) : (i32) -> i64
    %71 = "builtin.unrealized_conversion_cast"(%70) : (i64) -> i32
    "func.return"(%71) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "noinline_with_arg"}> ({
  ^bb0(%arg32: i32):
    %68 = "func.call"(%arg32) <{callee = @func_with_arg, no_inline}> : (i32) -> i32
    "func.return"(%68) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, no_inline, sym_name = "non_inlinable_func_with_arg"}> ({
  ^bb0(%arg31: i32):
    %67 = "arith.addi"(%arg31, %arg31) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%67) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "noinline_with_func_arg"}> ({
  ^bb0(%arg30: i32):
    %66 = "func.call"(%arg30) <{callee = @non_inlinable_func_with_arg}> : (i32) -> i32
    "func.return"(%66) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i32, sym_name = "func_with_multi_return"}> ({
  ^bb0(%arg29: i1):
    "cf.cond_br"(%arg29)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %64 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%64) : (i32) -> ()
  ^bb2:  // pred: ^bb0
    %65 = "arith.constant"() <{value = 55 : i32}> : () -> i32
    "func.return"(%65) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "inline_with_multi_return"}> ({
    %60 = "arith.constant"() <{value = false}> : () -> i1
    "cf.cond_br"(%60)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %61 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "cf.br"(%61)[^bb3] : (i32) -> ()
  ^bb2:  // pred: ^bb0
    %62 = "arith.constant"() <{value = 55 : i32}> : () -> i32
    "cf.br"(%62)[^bb3] : (i32) -> ()
  ^bb3(%63: i32):  // 2 preds: ^bb1, ^bb2
    "func.return"(%63) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "func_with_file_locations"}> ({
  ^bb0(%arg28: i32):
    %59 = "arith.addi"(%arg28, %arg28) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%59) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "func_with_callsite_locations"}> ({
  ^bb0(%arg27: i32):
    %58 = "arith.addi"(%arg27, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%58) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "inline_func_with_file_locations"}> ({
  ^bb0(%arg26: i32):
    %56 = "arith.addi"(%arg26, %arg26) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %57 = "arith.addi"(%56, %56) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%57) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "inline_func_with_callsite_locations"}> ({
  ^bb0(%arg25: i32):
    %54 = "arith.addi"(%arg25, %arg25) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %55 = "arith.addi"(%54, %54) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%55) : (i32) -> ()
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
    %53 = "test.functional_region_op"() ({
      "test.return"() : () -> ()
    }) : () -> (() -> ())
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "no_inline_recursive"}> ({
    %52 = "test.functional_region_op"() ({
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
    %51 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%51, %51) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i16, sym_name = "inline_convert_call"}> ({
    %48 = "arith.constant"() <{value = 0 : i16}> : () -> i16
    %49 = "test.cast"(%48) : (i16) -> i32
    %50 = "test.cast"(%49) : (i32) -> i16
    "func.return"(%50) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "convert_callee_fn_multiblock"}> ({
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %47 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%47) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i16, sym_name = "inline_convert_result_multiblock"}> ({
    "cf.br"()[^bb1] {inlined_conversion} : () -> ()
  ^bb1:  // pred: ^bb0
    %44 = "arith.constant"() <{value = 0 : i32}> {inlined_conversion} : () -> i32
    "cf.br"(%44)[^bb2] : (i32) -> ()
  ^bb2(%45: i32):  // pred: ^bb1
    %46 = "test.cast"(%45) : (i32) -> i16
    "func.return"(%46) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "no_inline_convert_call"}> ({
    %41 = "arith.constant"() <{value = 0 : i16}> : () -> i16
    %42 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    "test.conversion_call_op"(%41, %42) <{callee = @convert_callee_fn_multi_arg}> : (i16, i64) -> ()
    %43:2 = "test.conversion_call_op"() <{callee = @convert_callee_fn_multi_res}> : () -> (i16, i64)
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "simplify_return_constant"}> ({
    %40 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%40) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (() -> i32), sym_name = "simplify_return_reference"}> ({
    %39 = "func.constant"() <{value = @simplify_return_constant}> : () -> (() -> i32)
    "func.return"(%39) : (() -> i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "inline_simplify"}> ({
    %37 = "func.constant"() <{value = @simplify_return_constant}> : () -> (() -> i32)
    %38 = "func.call_indirect"(%37) : (() -> i32) -> i32
    "func.return"(%38) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "no_inline_invalid_call"}> ({
    %36 = "test.conversion_call_op"() <{callee = @convert_callee_fn_multiblock}> {noinline} : () -> i32
    "func.return"(%36) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<1024xf32>, sym_name = "gpu_alloc"}> ({
    %35 = "gpu.alloc"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> memref<1024xf32>
    "func.return"(%35) : (memref<1024xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<1024xf32>, sym_name = "inline_gpu_ops"}> ({
    %34 = "gpu.alloc"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> memref<1024xf32>
    "func.return"(%34) : (memref<1024xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_block_args_location"}> ({
  ^bb0(%arg21: i32):
    "cf.br"(%arg21)[^bb1] : (i32) -> ()
  ^bb1(%33: i32):  // pred: ^bb0
    "test.foo"(%33) : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_block_args_location_callee1"}> ({
  ^bb0(%arg20: i32):
    "cf.br"(%arg20)[^bb1] : (i32) -> ()
  ^bb1(%32: i32):  // pred: ^bb0
    "test.foo"(%32) : (i32) -> ()
    "cf.br"()[^bb2] : () -> ()
  ^bb2:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_block_args_location_callee2"}> ({
  ^bb0(%arg19: i32):
    "cf.br"(%arg19)[^bb1] : (i32) -> ()
  ^bb1(%31: i32):  // pred: ^bb0
    "test.foo"(%31) : (i32) -> ()
    "cf.br"()[^bb2] : () -> ()
  ^bb2:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_multiple_blocks"}> ({
  ^bb0(%arg18: i32):
    "cf.br"(%arg18)[^bb1] : (i32) -> ()
  ^bb1(%30: i32):  // pred: ^bb0
    "test.foo"(%30) : (i32) -> ()
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
    %29 = "scf.while"(%arg13) ({
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

