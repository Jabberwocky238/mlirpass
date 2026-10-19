"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "simple_std_for_loop"}> ({
  ^bb0(%arg90: index, %arg91: index, %arg92: index):
    "scf.for"(%arg90, %arg91, %arg92) ({
    ^bb0(%arg93: index):
      %71 = "arith.constant"() <{value = 1 : index}> : () -> index
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "unsigned_loop"}> ({
  ^bb0(%arg86: index, %arg87: index, %arg88: index):
    "scf.for"(%arg86, %arg87, %arg88) <{unsignedCmp}> ({
    ^bb0(%arg89: index):
      %70 = "arith.constant"() <{value = 1 : index}> : () -> index
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "simple_std_2_for_loops"}> ({
  ^bb0(%arg81: index, %arg82: index, %arg83: index):
    "scf.for"(%arg81, %arg82, %arg83) ({
    ^bb0(%arg84: index):
      %68 = "arith.constant"() <{value = 1 : index}> : () -> index
      "scf.for"(%arg81, %arg82, %arg83) ({
      ^bb0(%arg85: index):
        %69 = "arith.constant"() <{value = 1 : index}> : () -> index
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "simple_std_if"}> ({
  ^bb0(%arg80: i1):
    "scf.if"(%arg80) ({
      %67 = "arith.constant"() <{value = 1 : index}> : () -> index
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "simple_std_if_else"}> ({
  ^bb0(%arg79: i1):
    "scf.if"(%arg79) ({
      %66 = "arith.constant"() <{value = 1 : index}> : () -> index
      "scf.yield"() : () -> ()
    }, {
      %65 = "arith.constant"() <{value = 1 : index}> : () -> index
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "simple_std_2_ifs"}> ({
  ^bb0(%arg78: i1):
    "scf.if"(%arg78) ({
      %62 = "arith.constant"() <{value = 1 : index}> : () -> index
      "scf.if"(%arg78) ({
        %64 = "arith.constant"() <{value = 1 : index}> : () -> index
        "scf.yield"() : () -> ()
      }, {
        %63 = "arith.constant"() <{value = 1 : index}> : () -> index
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index, i1) -> (), sym_name = "simple_std_for_loop_with_2_ifs"}> ({
  ^bb0(%arg73: index, %arg74: index, %arg75: index, %arg76: i1):
    "scf.for"(%arg73, %arg74, %arg75) ({
    ^bb0(%arg77: index):
      %58 = "arith.constant"() <{value = 1 : index}> : () -> index
      "scf.if"(%arg76) ({
        %59 = "arith.constant"() <{value = 1 : index}> : () -> index
        "scf.if"(%arg76) ({
          %61 = "arith.constant"() <{value = 1 : index}> : () -> index
          "scf.yield"() : () -> ()
        }, {
          %60 = "arith.constant"() <{value = 1 : index}> : () -> index
          "scf.yield"() : () -> ()
        }) : (i1) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (i1, i1), sym_name = "simple_if_yield"}> ({
  ^bb0(%arg72: i1):
    %53:2 = "scf.if"(%arg72) ({
      %56 = "arith.constant"() <{value = false}> : () -> i1
      %57 = "arith.constant"() <{value = true}> : () -> i1
      "scf.yield"(%56, %57) : (i1, i1) -> ()
    }, {
      %54 = "arith.constant"() <{value = false}> : () -> i1
      %55 = "arith.constant"() <{value = true}> : () -> i1
      "scf.yield"(%55, %54) : (i1, i1) -> ()
    }) : (i1) -> (i1, i1)
    "func.return"(%53#0, %53#1) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> index, sym_name = "nested_if_yield"}> ({
  ^bb0(%arg71: i1):
    %45 = "scf.if"(%arg71) ({
      %52 = "arith.constant"() <{value = true}> : () -> i1
      "scf.yield"(%52) : (i1) -> ()
    }, {
      %51 = "arith.constant"() <{value = false}> : () -> i1
      "scf.yield"(%51) : (i1) -> ()
    }) : (i1) -> i1
    %46 = "scf.if"(%45) ({
      %48 = "scf.if"(%arg71) ({
        %50 = "arith.constant"() <{value = 40 : index}> : () -> index
        "scf.yield"(%50) : (index) -> ()
      }, {
        %49 = "arith.constant"() <{value = 41 : index}> : () -> index
        "scf.yield"(%49) : (index) -> ()
      }) : (i1) -> index
      "scf.yield"(%48) : (index) -> ()
    }, {
      %47 = "arith.constant"() <{value = 42 : index}> : () -> index
      "scf.yield"(%47) : (index) -> ()
    }) : (i1) -> index
    "func.return"(%46) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index, index, index) -> (), sym_name = "parallel_loop"}> ({
  ^bb0(%arg64: index, %arg65: index, %arg66: index, %arg67: index, %arg68: index):
    %43 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.parallel"(%arg64, %arg65, %arg66, %arg67, %arg68, %43) <{operandSegmentSizes = array<i32: 2, 2, 2, 0>}> ({
    ^bb0(%arg69: index, %arg70: index):
      %44 = "arith.constant"() <{value = 1 : index}> : () -> index
      "scf.reduce"() : () -> ()
    }) : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> (f32, f32), sym_name = "for_yield"}> ({
  ^bb0(%arg58: index, %arg59: index, %arg60: index):
    %39 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %40 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %41:2 = "scf.for"(%arg58, %arg59, %arg60, %39, %40) ({
    ^bb0(%arg61: index, %arg62: f32, %arg63: f32):
      %42 = "arith.addf"(%arg62, %arg63) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "scf.yield"(%42, %42) : (f32, f32) -> ()
    }) : (index, index, index, f32, f32) -> (f32, f32)
    "func.return"(%41#0, %41#1) : (f32, f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> f32, sym_name = "nested_for_yield"}> ({
  ^bb0(%arg51: index, %arg52: index, %arg53: index):
    %35 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %36 = "scf.for"(%arg51, %arg52, %arg53, %35) ({
    ^bb0(%arg54: index, %arg55: f32):
      %37 = "scf.for"(%arg51, %arg52, %arg53, %arg55) ({
      ^bb0(%arg56: index, %arg57: f32):
        %38 = "arith.addf"(%arg57, %arg57) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "scf.yield"(%38) : (f32) -> ()
      }) : (index, index, index, f32) -> f32
      "scf.yield"(%37) : (f32) -> ()
    }) : (index, index, index, f32) -> f32
    "func.return"(%36) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "generate", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index, f32) -> f32, sym_name = "simple_parallel_reduce_loop"}> ({
  ^bb0(%arg44: index, %arg45: index, %arg46: index, %arg47: f32):
    %32 = "scf.parallel"(%arg44, %arg45, %arg46, %arg47) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>}> ({
    ^bb0(%arg48: index):
      %33 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
      "scf.reduce"(%33) ({
      ^bb0(%arg49: f32, %arg50: f32):
        %34 = "arith.mulf"(%arg49, %arg50) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "scf.reduce.return"(%34) : (f32) -> ()
      }) : (f32) -> ()
    }) : (index, index, index, f32) -> f32
    "func.return"(%32) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index, index, index, f32) -> (f32, i64), sym_name = "parallel_reduce_loop"}> ({
  ^bb0(%arg32: index, %arg33: index, %arg34: index, %arg35: index, %arg36: index, %arg37: f32):
    %25 = "arith.constant"() <{value = 1 : index}> : () -> index
    %26 = "arith.constant"() <{value = 42 : i64}> : () -> i64
    %27:2 = "scf.parallel"(%arg32, %arg33, %arg34, %arg35, %arg36, %25, %arg37, %26) <{operandSegmentSizes = array<i32: 2, 2, 2, 2>}> ({
    ^bb0(%arg38: index, %arg39: index):
      %28 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
      %29 = "func.call"() <{callee = @generate}> : () -> i64
      "scf.reduce"(%28, %29) ({
      ^bb0(%arg42: f32, %arg43: f32):
        %31 = "arith.addf"(%arg42, %arg43) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "scf.reduce.return"(%31) : (f32) -> ()
      }, {
      ^bb0(%arg40: i64, %arg41: i64):
        %30 = "arith.ori"(%arg40, %arg41) : (i64, i64) -> i64
        "scf.reduce.return"(%30) : (i64) -> ()
      }) : (f32, i64) -> ()
    }) : (index, index, index, index, index, index, f32, i64) -> (f32, i64)
    "func.return"(%27#0, %27#1) : (f32, i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "unknown_op_inside_loop"}> ({
  ^bb0(%arg28: index, %arg29: index, %arg30: index):
    "scf.for"(%arg28, %arg29, %arg30) ({
    ^bb0(%arg31: index):
      "unknown.op"() : () -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "minimal_while"}> ({
    %24 = "test.make_condition"() : () -> i1
    "scf.while"() ({
      "scf.condition"(%24) : (i1) -> ()
    }, {
      "test.some_payload"() : () -> ()
      "scf.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> (), sym_name = "do_while"}> ({
  ^bb0(%arg25: f32):
    %22 = "scf.while"(%arg25) ({
    ^bb0(%arg27: f32):
      %23 = "test.make_condition"() : () -> i1
      "scf.condition"(%23, %arg27) : (i1, f32) -> ()
    }, {
    ^bb0(%arg26: f32):
      "scf.yield"(%arg26) : (f32) -> ()
    }) : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, f32) -> (), sym_name = "while_values"}> ({
  ^bb0(%arg19: i32, %arg20: f32):
    %16 = "test.make_condition"() : () -> i1
    %17 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %18 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %19:2 = "scf.while"(%arg19, %arg20) ({
    ^bb0(%arg23: i32, %arg24: f32):
      %20 = "arith.extui"(%arg19) : (i32) -> i64
      %21 = "arith.extf"(%arg24) : (f32) -> f64
      "scf.condition"(%16, %20, %21) : (i1, i64, f64) -> ()
    }, {
    ^bb0(%arg21: i64, %arg22: f64):
      "scf.yield"(%17, %18) : (i32, f32) -> ()
    }) : (i32, f32) -> (i64, f64)
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> i64, sym_name = "nested_while_ops"}> ({
  ^bb0(%arg12: f32):
    %8 = "scf.while"(%arg12) ({
    ^bb0(%arg16: f32):
      %12 = "test.outer_before_pre"() : () -> i1
      %13 = "scf.while"(%arg16) ({
      ^bb0(%arg18: f32):
        %15:2 = "test.inner_before"(%arg18) : (f32) -> (i1, i64)
        "scf.condition"(%15#0, %15#1) : (i1, i64) -> ()
      }, {
      ^bb0(%arg17: i64):
        %14 = "test.inner_after"(%arg17) : (i64) -> f32
        "scf.yield"(%14) : (f32) -> ()
      }) : (f32) -> i64
      "test.outer_before_post"() : () -> ()
      "scf.condition"(%12, %13) : (i1, i64) -> ()
    }, {
    ^bb0(%arg13: i64):
      "test.outer_after_pre"(%arg13) : (i64) -> ()
      %9 = "scf.while"(%arg13) ({
      ^bb0(%arg15: i64):
        %11:2 = "test.inner2_before"(%arg15) : (i64) -> (i1, f32)
        "scf.condition"(%11#0, %11#1) : (i1, f32) -> ()
      }, {
      ^bb0(%arg14: f32):
        %10 = "test.inner2_after"(%arg14) : (f32) -> i64
        "scf.yield"(%10) : (i64) -> ()
      }) : (i64) -> f32
      "test.outer_after_post"() : () -> ()
      "scf.yield"(%9) : (f32) -> ()
    }) : (f32) -> i64
    "func.return"(%8) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index, i1, i1) -> (), sym_name = "ifs_in_parallel"}> ({
  ^bb0(%arg6: index, %arg7: index, %arg8: index, %arg9: i1, %arg10: i1):
    "scf.parallel"(%arg6, %arg7, %arg8) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> ({
    ^bb0(%arg11: index):
      "scf.if"(%arg9) ({
        %5 = "scf.if"(%arg10) ({
          %7 = "test.if2"() : () -> index
          "scf.yield"(%7) : (index) -> ()
        }, {
          %6 = "test.else2"() : () -> index
          "scf.yield"(%6) : (index) -> ()
        }) : (i1) -> index
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "scf.reduce"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "func_execute_region_elim_multi_yield"}> ({
    "test.foo"() : () -> ()
    %1 = "scf.execute_region"() ({
      %2 = "test.cmp"() : () -> i1
      "cf.cond_br"(%2)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %3 = "test.val1"() : () -> i64
      "scf.yield"(%3) : (i64) -> ()
    ^bb2:  // pred: ^bb0
      %4 = "test.val2"() : () -> i64
      "scf.yield"(%4) : (i64) -> ()
    }) : () -> i64
    "test.bar"(%1) : (i64) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, i32, i32, i32) -> i32, sym_name = "index_switch"}> ({
  ^bb0(%arg2: index, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "scf.index_switch"(%arg2) <{cases = array<i64: 0, 1>}> ({
      "scf.yield"(%arg5) : (i32) -> ()
    }, {
      "scf.yield"(%arg3) : (i32) -> ()
    }, {
      "scf.yield"(%arg4) : (i32) -> ()
    }) : (index) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "forall"}> ({
  ^bb0(%arg0: index):
    "scf.forall"(%arg0) <{operandSegmentSizes = array<i32: 0, 1, 0, 0>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg1: index):
      "test.foo"(%arg1) : (index) -> ()
      "scf.forall.in_parallel"() ({
      ^bb0:
      }) : () -> ()
    }) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#loop_unroll = #llvm.loop_unroll<full = true>
#loop_unroll1 = #llvm.loop_unroll<disable = true>
#loop_annotation = #llvm.loop_annotation<unroll = #loop_unroll>
#loop_annotation1 = #llvm.loop_annotation<unroll = #loop_unroll1>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "simple_std_for_loops_annotation"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    "scf.for"(%arg0, %arg1, %arg2) ({
    ^bb0(%arg3: index):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "arith.constant"() <{value = 1 : index}> : () -> index
      %2 = "arith.constant"() <{value = 4 : index}> : () -> index
      "scf.for"(%0, %2, %1) ({
      ^bb0(%arg4: index):
        %3 = "arith.constant"() <{value = 1 : index}> : () -> index
        "scf.yield"() : () -> ()
      }) {llvm.loop_annotation = #loop_annotation} : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) {llvm.loop_annotation = #loop_annotation1} : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#loop_unroll = #llvm.loop_unroll<disable = true>
#loop_annotation = #llvm.loop_annotation<unroll = #loop_unroll>
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (), sym_name = "simple_while_loops_annotation"}> ({
  ^bb0(%arg0: i1):
    "scf.while"() ({
      "scf.condition"(%arg0) : (i1) -> ()
    }, {
      "scf.yield"() : () -> ()
    }) {llvm.loop_annotation = #loop_annotation} : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#loop_unroll = #llvm.loop_unroll<disable = true>
#loop_annotation = #llvm.loop_annotation<unroll = #loop_unroll>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "do_while_loops_annotation"}> ({
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "scf.while"(%0) ({
    ^bb0(%arg1: i32):
      %2 = "test.make_condition"() : () -> i1
      "scf.condition"(%2, %0) : (i1, i32) -> ()
    }, {
    ^bb0(%arg0: i32):
      "scf.yield"(%0) : (i32) -> ()
    }) {llvm.loop_annotation = #loop_annotation} : (i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

