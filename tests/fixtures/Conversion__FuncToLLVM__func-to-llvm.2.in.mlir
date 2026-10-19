"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "empty"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "body", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "simple_loop"}> ({
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %62 = "arith.constant"() <{value = 1 : index}> : () -> index
    %63 = "arith.constant"() <{value = 42 : index}> : () -> index
    "cf.br"(%62)[^bb2] : (index) -> ()
  ^bb2(%64: index):  // 2 preds: ^bb1, ^bb3
    %65 = "arith.cmpi"(%64, %63) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%65)[^bb3, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    "func.call"(%64) <{callee = @body}> : (index) -> ()
    %66 = "arith.constant"() <{value = 1 : index}> : () -> index
    %67 = "arith.addi"(%64, %66) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%67)[^bb2] : (index) -> ()
  ^bb4:  // pred: ^bb2
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "simple_caller"}> ({
    "func.call"() <{callee = @simple_loop}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "call_with_attributes"}> ({
    "func.call"() <{callee = @simple_loop}> {baz = [1, 2, 3, 4], foo = "bar"} : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "ml_caller"}> ({
    "func.call"() <{callee = @simple_loop}> : () -> ()
    "func.call"() <{callee = @more_imperfectly_nested_loops}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "body_args", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index, i32) -> i32, sym_name = "other", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "func_args"}> ({
  ^bb0(%arg10: i32, %arg11: i32):
    %49 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %50 = "arith.constant"() <{value = 0 : index}> : () -> index
    %51 = "arith.constant"() <{value = 42 : index}> : () -> index
    "cf.br"(%50)[^bb2] : (index) -> ()
  ^bb2(%52: index):  // 2 preds: ^bb1, ^bb3
    %53 = "arith.cmpi"(%52, %51) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%53)[^bb3, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    %54 = "func.call"(%52) <{callee = @body_args}> : (index) -> index
    %55 = "func.call"(%54, %arg10) <{callee = @other}> : (index, i32) -> i32
    %56 = "func.call"(%54, %55) <{callee = @other}> : (index, i32) -> i32
    %57 = "func.call"(%54, %arg11) <{callee = @other}> : (index, i32) -> i32
    %58 = "arith.constant"() <{value = 1 : index}> : () -> index
    %59 = "arith.addi"(%52, %58) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%59)[^bb2] : (index) -> ()
  ^bb4:  // pred: ^bb2
    %60 = "arith.constant"() <{value = 0 : index}> : () -> index
    %61 = "func.call"(%60, %49) <{callee = @other}> : (index, i32) -> i32
    "func.return"(%61) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "pre", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> (), sym_name = "body2", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "post", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "imperfectly_nested_loops"}> ({
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %37 = "arith.constant"() <{value = 0 : index}> : () -> index
    %38 = "arith.constant"() <{value = 42 : index}> : () -> index
    "cf.br"(%37)[^bb2] : (index) -> ()
  ^bb2(%39: index):  // 2 preds: ^bb1, ^bb7
    %40 = "arith.cmpi"(%39, %38) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%40)[^bb3, ^bb8] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    "func.call"(%39) <{callee = @pre}> : (index) -> ()
    "cf.br"()[^bb4] : () -> ()
  ^bb4:  // pred: ^bb3
    %41 = "arith.constant"() <{value = 7 : index}> : () -> index
    %42 = "arith.constant"() <{value = 56 : index}> : () -> index
    "cf.br"(%41)[^bb5] : (index) -> ()
  ^bb5(%43: index):  // 2 preds: ^bb4, ^bb6
    %44 = "arith.cmpi"(%43, %42) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%44)[^bb6, ^bb7] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb6:  // pred: ^bb5
    "func.call"(%39, %43) <{callee = @body2}> : (index, index) -> ()
    %45 = "arith.constant"() <{value = 2 : index}> : () -> index
    %46 = "arith.addi"(%43, %45) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%46)[^bb5] : (index) -> ()
  ^bb7:  // pred: ^bb5
    "func.call"(%39) <{callee = @post}> : (index) -> ()
    %47 = "arith.constant"() <{value = 1 : index}> : () -> index
    %48 = "arith.addi"(%39, %47) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%48)[^bb2] : (index) -> ()
  ^bb8:  // pred: ^bb2
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "mid", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> (), sym_name = "body3", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "more_imperfectly_nested_loops"}> ({
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %19 = "arith.constant"() <{value = 0 : index}> : () -> index
    %20 = "arith.constant"() <{value = 42 : index}> : () -> index
    "cf.br"(%19)[^bb2] : (index) -> ()
  ^bb2(%21: index):  // 2 preds: ^bb1, ^bb11
    %22 = "arith.cmpi"(%21, %20) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%22)[^bb3, ^bb12] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    "func.call"(%21) <{callee = @pre}> : (index) -> ()
    "cf.br"()[^bb4] : () -> ()
  ^bb4:  // pred: ^bb3
    %23 = "arith.constant"() <{value = 7 : index}> : () -> index
    %24 = "arith.constant"() <{value = 56 : index}> : () -> index
    "cf.br"(%23)[^bb5] : (index) -> ()
  ^bb5(%25: index):  // 2 preds: ^bb4, ^bb6
    %26 = "arith.cmpi"(%25, %24) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%26)[^bb6, ^bb7] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb6:  // pred: ^bb5
    "func.call"(%21, %25) <{callee = @body2}> : (index, index) -> ()
    %27 = "arith.constant"() <{value = 2 : index}> : () -> index
    %28 = "arith.addi"(%25, %27) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%28)[^bb5] : (index) -> ()
  ^bb7:  // pred: ^bb5
    "func.call"(%21) <{callee = @mid}> : (index) -> ()
    "cf.br"()[^bb8] : () -> ()
  ^bb8:  // pred: ^bb7
    %29 = "arith.constant"() <{value = 18 : index}> : () -> index
    %30 = "arith.constant"() <{value = 37 : index}> : () -> index
    "cf.br"(%29)[^bb9] : (index) -> ()
  ^bb9(%31: index):  // 2 preds: ^bb8, ^bb10
    %32 = "arith.cmpi"(%31, %30) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%32)[^bb10, ^bb11] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb10:  // pred: ^bb9
    "func.call"(%21, %31) <{callee = @body3}> : (index, index) -> ()
    %33 = "arith.constant"() <{value = 3 : index}> : () -> index
    %34 = "arith.addi"(%31, %33) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%34)[^bb9] : (index) -> ()
  ^bb11:  // pred: ^bb9
    "func.call"(%21) <{callee = @post}> : (index) -> ()
    %35 = "arith.constant"() <{value = 1 : index}> : () -> index
    %36 = "arith.addi"(%21, %35) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "cf.br"(%36)[^bb2] : (index) -> ()
  ^bb12:  // pred: ^bb2
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "get_i64", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "get_f32", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f16>, sym_name = "get_c16", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "get_c32", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f64>, sym_name = "get_c64", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<42x?x10x?xf32>, sym_name = "get_memref", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (i64, f32, memref<42x?x10x?xf32>), sym_name = "multireturn"}> ({
    %16 = "func.call"() <{callee = @get_i64}> : () -> i64
    %17 = "func.call"() <{callee = @get_f32}> : () -> f32
    %18 = "func.call"() <{callee = @get_memref}> : () -> memref<42x?x10x?xf32>
    "func.return"(%16, %17, %18) : (i64, f32, memref<42x?x10x?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "multireturn_caller"}> ({
    %10:3 = "func.call"() <{callee = @multireturn}> : () -> (i64, f32, memref<42x?x10x?xf32>)
    %11 = "arith.constant"() <{value = 42 : i64}> : () -> i64
    %12 = "arith.addi"(%10#0, %11) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %13 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
    %14 = "arith.addf"(%10#1, %13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %15 = "arith.constant"() <{value = 0 : index}> : () -> index
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "dfs_block_order"}> ({
  ^bb0(%arg9: i32):
    %8 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    "cf.br"()[^bb2] : () -> ()
  ^bb1:  // pred: ^bb2
    %9 = "arith.addi"(%arg9, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%9) : (i32) -> ()
  ^bb2:  // pred: ^bb0
    "cf.br"()[^bb1] : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> (), sym_name = "ceilf"}> ({
  ^bb0(%arg8: f32):
    %7 = "math.ceil"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> (), sym_name = "floorf"}> ({
  ^bb0(%arg7: f32):
    %6 = "math.floor"(%arg7) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "func.func"() <{function_type = (i1) -> (), sym_name = "assert_test_function"}> ({
    ^bb0(%arg6: i1):
      "cf.assert"(%arg6) <{msg = "Computer says no"}> : (i1) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "call_zero_result_func"}> ({
    "func.call"() <{callee = @zero_result_func}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "zero_result_func", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, vector<4xf32>) -> (), sym_name = "fmaf"}> ({
  ^bb0(%arg4: f32, %arg5: vector<4xf32>):
    %4 = "math.fma"(%arg4, %arg4, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
    %5 = "math.fma"(%arg5, %arg5, %arg5) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> i32, sym_name = "switchi8"}> ({
  ^bb0(%arg3: i8):
    "cf.switch"(%arg3)[^bb1, ^bb1, ^bb2] <{case_operand_segments = array<i32: 0, 0>, case_values = dense<[42, 43]> : vector<2xi8>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i8) -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb0
    %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "func.return"(%2) : (i32) -> ()
  ^bb2:  // pred: ^bb0
    %3 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "index_arg"}> ({
  ^bb0(%arg2: index):
    "cf.br"(%arg2)[^bb1] : (index) -> ()
  ^bb1(%1: index):  // pred: ^bb0
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xtf32>) -> (), sym_name = "non_convertible_arg_type"}> ({
  ^bb0(%arg1: vector<1xtf32>):
    "func.return"() : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_conversion_patterns"(%0) <{legal_dialects = ["llvm"], partial_conversion}> ({
        "transform.apply_conversion_patterns.dialect_to_llvm"() <{dialect_name = "math"}> : () -> ()
        "transform.apply_conversion_patterns.dialect_to_llvm"() <{dialect_name = "arith"}> : () -> ()
        "transform.apply_conversion_patterns.dialect_to_llvm"() <{dialect_name = "cf"}> : () -> ()
        "transform.apply_conversion_patterns.func.func_to_llvm"() : () -> ()
      }, {
        "transform.apply_conversion_patterns.memref.memref_to_llvm_type_converter"() <{index_bitwidth = 32 : i64}> {use_opaque_pointers = true} : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

