"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "func_with_arg"}> ({
  ^bb0(%arg28: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":8:26)):
    %60 = "arith.addi"(%arg28, %arg28) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":9:8)
    %61 = "builtin.unrealized_conversion_cast"(%60) : (i32) -> i64 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":10:8)
    %62 = "builtin.unrealized_conversion_cast"(%61) : (i64) -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":11:8)
    "func.return"(%62) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":12:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":8:1)
  "func.func"() <{function_type = (i32) -> i32, sym_name = "inline_with_arg"}> ({
  ^bb0(%arg27: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":16:28)):
    %57 = "arith.addi"(%arg27, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32 loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":9:8 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":22:8))
    %58 = "builtin.unrealized_conversion_cast"(%57) : (i32) -> i64 loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":10:8 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":22:8))
    %59 = "builtin.unrealized_conversion_cast"(%58) : (i64) -> i32 loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":11:8 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":22:8))
    "func.return"(%59) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":23:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":16:1)
  "func.func"() <{function_type = (i32) -> i32, sym_name = "noinline_with_arg"}> ({
  ^bb0(%arg26: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":27:30)):
    %56 = "func.call"(%arg26) <{callee = @func_with_arg, no_inline}> : (i32) -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":31:8)
    "func.return"(%56) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":32:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":27:1)
  "func.func"() <{function_type = (i32) -> i32, no_inline, sym_name = "non_inlinable_func_with_arg"}> ({
  ^bb0(%arg25: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":35:40)):
    %55 = "arith.addi"(%arg25, %arg25) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":36:8)
    "func.return"(%55) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":37:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":35:1)
  "func.func"() <{function_type = (i32) -> i32, sym_name = "noinline_with_func_arg"}> ({
  ^bb0(%arg24: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":41:35)):
    %54 = "func.call"(%arg24) <{callee = @non_inlinable_func_with_arg}> : (i32) -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":45:8)
    "func.return"(%54) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":46:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":41:1)
  "func.func"() <{function_type = (i1) -> i32, sym_name = "func_with_multi_return"}> ({
  ^bb0(%arg23: i1 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":50:35)):
    "cf.cond_br"(%arg23)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":51:3)
  ^bb1:  // pred: ^bb0
    %52 = "arith.constant"() <{value = 0 : i32}> : () -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":54:14)
    "func.return"(%52) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":55:3)
  ^bb2:  // pred: ^bb0
    %53 = "arith.constant"() <{value = 55 : i32}> : () -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":58:15)
    "func.return"(%53) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":59:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":50:1)
  "func.func"() <{function_type = () -> i32, sym_name = "inline_with_multi_return"}> ({
    %48 = "arith.constant"() <{value = false}> : () -> i1 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":75:12)
    "cf.cond_br"(%48)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> () loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":51:3 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":76:8))
  ^bb1:  // pred: ^bb0
    %49 = "arith.constant"() <{value = 0 : i32}> : () -> i32 loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":54:14 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":76:8))
    "cf.br"(%49)[^bb3] : (i32) -> () loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":55:3 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":76:8))
  ^bb2:  // pred: ^bb0
    %50 = "arith.constant"() <{value = 55 : i32}> : () -> i32 loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":58:15 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":76:8))
    "cf.br"(%50)[^bb3] : (i32) -> () loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":59:3 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":76:8))
  ^bb3(%51: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":76:8)):  // 2 preds: ^bb1, ^bb2
    "func.return"(%51) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":77:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":63:1)
  "func.func"() <{function_type = (i32) -> i32, sym_name = "func_with_file_locations"}> ({
  ^bb0(%arg22: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":86:37)):
    %47 = "arith.addi"(%arg22, %arg22) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32 loc("mysource.cc":10:8)
    "func.return"(%47) : (i32) -> () loc("mysource.cc":11:2)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":86:1)
  "func.func"() <{function_type = (i32) -> i32, sym_name = "func_with_callsite_locations"}> ({
  ^bb0(%arg21: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":92:41)):
    %46 = "arith.addi"(%arg21, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32 loc(callsite("mysource1.cc":10:8 at callsite("mysource2.cc":13:6 at "mysource3.cc":16:2)))
    "func.return"(%46) : (i32) -> () loc(callsite("mysource1.cc":10:8 at callsite("mysource2.cc":13:6 at "mysource3.cc":16:2)))
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":92:1)
  "func.func"() <{function_type = (i32) -> i32, sym_name = "inline_func_with_file_locations"}> ({
  ^bb0(%arg20: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":98:44)):
    %44 = "arith.addi"(%arg20, %arg20) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32 loc(callsite("mysource.cc":10:8 at "mysource.cc":55:14))
    %45 = "arith.addi"(%44, %44) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32 loc(callsite("mysource.cc":10:8 at callsite("mysource1.cc":10:8 at callsite("mysource2.cc":13:6 at "mysource3.cc":16:2))))
    "func.return"(%45) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":108:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":98:1)
  "func.func"() <{function_type = (i32) -> i32, sym_name = "inline_func_with_callsite_locations"}> ({
  ^bb0(%arg19: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":112:48)):
    %42 = "arith.addi"(%arg19, %arg19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32 loc(callsite("mysource1.cc":10:8 at callsite("mysource2.cc":13:6 at callsite("mysource3.cc":16:2 at "mysource.cc":10:8))))
    %43 = "arith.addi"(%42, %42) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32 loc(callsite("mysource1.cc":10:8 at callsite("mysource2.cc":13:6 at callsite("mysource3.cc":16:2 at callsite("mysource4.cc":55:4 at callsite("mysource5.cc":25:8 at "mysource6.cc":32:4))))))
    "func.return"(%43) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":124:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":112:1)
  "func.func"() <{function_type = () -> (), sym_name = "func_external", sym_visibility = "private"}> ({
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":128:1)
  "func.func"() <{function_type = () -> (), sym_name = "no_inline_external"}> ({
    "func.call"() <{callee = @func_external}> : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":133:3)
    "func.return"() : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":134:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":131:1)
  "func.func"() <{function_type = () -> (), sym_name = "multilevel_func_a"}> ({
    "func.return"() : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":139:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":138:1)
  "func.func"() <{function_type = () -> (), sym_name = "multilevel_func_b"}> ({
    "func.return"() : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":143:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":141:1)
  "func.func"() <{function_type = () -> (), sym_name = "inline_multilevel"}> ({
    %41 = "test.functional_region_op"() ({
      "test.return"() : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":151:5)
    }) : () -> (() -> ()) loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":149:9)
    "func.return"() : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":155:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":147:1)
  "func.func"() <{function_type = () -> (), sym_name = "no_inline_recursive"}> ({
    %40 = "test.functional_region_op"() ({
      "func.call"() <{callee = @no_inline_recursive}> : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":164:5)
      "test.return"() : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":165:5)
    }) : () -> (() -> ()) loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":163:9)
    "func.return"() : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":167:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":160:1)
  "func.func"() <{function_type = (i32) -> i32, sym_name = "convert_callee_fn"}> ({
  ^bb0(%arg18: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":171:30)):
    "func.return"(%arg18) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":172:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":171:1)
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "convert_callee_fn_multi_arg"}> ({
  ^bb0(%arg16: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":174:40), %arg17: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":174:50)):
    "func.return"() : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":175:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":174:1)
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "convert_callee_fn_multi_res"}> ({
    %39 = "arith.constant"() <{value = 0 : i32}> : () -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":178:10)
    "func.return"(%39, %39) : (i32, i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":179:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":177:1)
  "func.func"() <{function_type = () -> i16, sym_name = "inline_convert_call"}> ({
    %36 = "arith.constant"() <{value = 0 : i16}> : () -> i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":185:17)
    %37 = "test.cast"(%36) : (i16) -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":190:10)
    %38 = "test.cast"(%37) : (i32) -> i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":190:10)
    "func.return"(%38) : (i16) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":191:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":183:1)
  "func.func"() <{function_type = () -> i32, sym_name = "convert_callee_fn_multiblock"}> ({
    "cf.br"()[^bb1] : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":195:3)
  ^bb1:  // pred: ^bb0
    %35 = "arith.constant"() <{value = 0 : i32}> : () -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":197:8)
    "func.return"(%35) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":198:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":194:1)
  "func.func"() <{function_type = () -> i16, sym_name = "inline_convert_result_multiblock"}> ({
    "cf.br"()[^bb1] {inlined_conversion} : () -> () loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":195:3 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":211:10))
  ^bb1:  // pred: ^bb0
    %32 = "arith.constant"() <{value = 0 : i32}> {inlined_conversion} : () -> i32 loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":197:8 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":211:10))
    "cf.br"(%32)[^bb2] : (i32) -> () loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":198:3 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":211:10))
  ^bb2(%33: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":211:10)):  // pred: ^bb1
    %34 = "test.cast"(%33) : (i32) -> i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":211:10)
    "func.return"(%34) : (i16) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":212:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":202:1)
  "func.func"() <{function_type = () -> (), sym_name = "no_inline_convert_call"}> ({
    %29 = "arith.constant"() <{value = 0 : i16}> : () -> i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":218:21)
    %30 = "arith.constant"() <{value = 0 : i64}> : () -> i64 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":219:21)
    "test.conversion_call_op"(%29, %30) <{callee = @convert_callee_fn_multi_arg}> : (i16, i64) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":220:3)
    %31:2 = "test.conversion_call_op"() <{callee = @convert_callee_fn_multi_res}> : () -> (i16, i64) loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":223:14)
    "func.return"() : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":224:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":216:1)
  "func.func"() <{function_type = () -> i32, sym_name = "simplify_return_constant"}> ({
    %28 = "arith.constant"() <{value = 0 : i32}> : () -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":229:10)
    "func.return"(%28) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":230:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":228:1)
  "func.func"() <{function_type = () -> (() -> i32), sym_name = "simplify_return_reference"}> ({
    %27 = "func.constant"() <{value = @simplify_return_constant}> : () -> (() -> i32) loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":234:10)
    "func.return"(%27) : (() -> i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":235:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":233:1)
  "func.func"() <{function_type = () -> i32, sym_name = "inline_simplify"}> ({
    %25 = "func.constant"() <{value = @simplify_return_constant}> : () -> (() -> i32) loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":234:10 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":242:9))
    %26 = "func.call_indirect"(%25) : (() -> i32) -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":243:10)
    "func.return"(%26) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":244:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":239:1)
  "func.func"() <{function_type = () -> i32, sym_name = "no_inline_invalid_call"}> ({
    %24 = "test.conversion_call_op"() <{callee = @convert_callee_fn_multiblock}> {noinline} : () -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":249:10)
    "func.return"(%24) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":250:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":248:1)
  "func.func"() <{function_type = () -> memref<1024xf32>, sym_name = "gpu_alloc"}> ({
    %23 = "gpu.alloc"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> memref<1024xf32> loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":254:8)
    "func.return"(%23) : (memref<1024xf32>) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":255:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":253:1)
  "func.func"() <{function_type = () -> memref<1024xf32>, sym_name = "inline_gpu_ops"}> ({
    %22 = "gpu.alloc"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> memref<1024xf32> loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":254:8 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":261:8))
    "func.return"(%22) : (memref<1024xf32>) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":262:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":259:1)
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_block_args_location"}> ({
  ^bb0(%arg15: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":267:42)):
    "cf.br"(%arg15)[^bb1] : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":268:3)
  ^bb1(%21: i32 loc("foo")):  // pred: ^bb0
    "test.foo"(%21) : (i32) -> () loc("bar")
    "func.return"() : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":271:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":267:1)
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_block_args_location_callee1"}> ({
  ^bb0(%arg14: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":277:50)):
    "cf.br"(%arg14)[^bb1] : (i32) -> () loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":268:3 at "bar"))
  ^bb1(%20: i32 loc(callsite("foo" at "bar"))):  // pred: ^bb0
    "test.foo"(%20) : (i32) -> () loc(callsite("bar" at "bar"))
    "cf.br"()[^bb2] : () -> () loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":271:3 at "bar"))
  ^bb2:  // pred: ^bb1
    "func.return"() : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":279:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":277:1)
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_block_args_location_callee2"}> ({
  ^bb0(%arg13: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":283:50)):
    "cf.br"(%arg13)[^bb1] : (i32) -> () loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":268:3 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":284:3))
  ^bb1(%19: i32 loc(callsite("foo" at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":284:3))):  // pred: ^bb0
    "test.foo"(%19) : (i32) -> () loc(callsite("bar" at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":284:3))
    "cf.br"()[^bb2] : () -> () loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":271:3 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":284:3))
  ^bb2:  // pred: ^bb1
    "func.return"() : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":285:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":283:1)
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_multiple_blocks"}> ({
  ^bb0(%arg12: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":288:38)):
    "cf.br"(%arg12)[^bb1] : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":289:3)
  ^bb1(%18: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":290:6)):  // pred: ^bb0
    "test.foo"(%18) : (i32) -> () loc("bar")
    "func.return"() : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":292:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":288:1)
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_multiple_blocks_callee1"}> ({
  ^bb0(%arg11: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":296:46)):
    "test.dummy_op"() ({
      "func.call"(%arg11) <{callee = @func_with_multiple_blocks}> : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":301:5)
      "test.terminator"() : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":302:5)
    }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":297:3)
    "func.return"() : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":304:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":296:1)
  "func.func"() <{function_type = (i32, i1) -> (), sym_name = "func_with_multiple_blocks_callee2"}> ({
  ^bb0(%arg7: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":308:46), %arg8: i1 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":308:59)):
    %17 = "scf.while"(%arg7) ({
    ^bb0(%arg10: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":309:19)):
      "func.call"(%arg7) <{callee = @func_with_multiple_blocks}> : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":313:5)
      "scf.condition"(%arg8, %arg10) : (i1, i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":314:5)
    }, {
    ^bb0(%arg9: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":316:8)):
      "scf.yield"(%arg9) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":317:5)
    }) : (i32) -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":309:8)
    "func.return"() : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":319:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":308:1)
  "test.conversion_func_op"() <{arg_attrs = [{}, {test.handle_argument}], function_type = (i16, i16) -> (i16, i16), res_attrs = [{test.handle_result}, {}], sym_name = "handle_attr_callee_fn_multi_arg"}> ({
  ^bb0(%arg5: i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":323:58), %arg6: i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":323:71)):
    %15 = "arith.addi"(%arg5, %arg6) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":324:8)
    %16 = "arith.subi"(%arg5, %arg6) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":325:8)
    "test.return"(%15, %16) : (i16, i16) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":326:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":323:1)
  "test.conversion_func_op"() <{arg_attrs = [{test.handle_argument}], function_type = (i32) -> i32, res_attrs = [{test.handle_result}], sym_name = "handle_attr_callee_fn"}> ({
  ^bb0(%arg4: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":328:48)):
    "test.return"(%arg4) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":329:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":328:1)
  "func.func"() <{function_type = (i16, i16) -> (i16, i16), sym_name = "inline_handle_attr_call"}> ({
  ^bb0(%arg2: i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":335:36), %arg3: i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":335:49)):
    %11 = "test.type_changer"(%arg3) : (i16) -> i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":342:18)
    %12 = "arith.addi"(%arg2, %11) <{overflowFlags = #arith.overflow<none>}> {inlined_conversion} : (i16, i16) -> i16 loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":324:8 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":342:18))
    %13 = "arith.subi"(%arg2, %11) <{overflowFlags = #arith.overflow<none>}> {inlined_conversion} : (i16, i16) -> i16 loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":325:8 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":342:18))
    %14 = "test.type_changer"(%12) : (i16) -> i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":342:18)
    "func.return"(%14, %13) : (i16, i16) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":343:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":335:1)
  "func.func"() <{function_type = (i16) -> i16, sym_name = "inline_convert_and_handle_attr_call"}> ({
  ^bb0(%arg1: i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":348:48)):
    %7 = "test.cast"(%arg1) : (i16) -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":355:10)
    %8 = "test.type_changer"(%7) : (i32) -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":355:10)
    %9 = "test.type_changer"(%8) : (i32) -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":355:10)
    %10 = "test.cast"(%9) : (i32) -> i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":355:10)
    "func.return"(%10) : (i16) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":356:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":348:1)
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "double_square_complex"}> ({
  ^bb0(%arg0: complex<f32> loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":360:34)):
    %5 = "complex.add"(%arg0, %arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32> loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":361:13)
    %6 = "complex.mul"(%5, %5) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32> loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":362:13)
    "func.return"(%6) : (complex<f32>) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":363:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":360:1)
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "inline_with_complex_ops"}> ({
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":368:9)
    %1 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":369:9)
    %2 = "complex.create"(%0, %1) : (f32, f32) -> complex<f32> loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":370:8)
    %3 = "complex.add"(%2, %2) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32> loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":361:13 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":375:8))
    %4 = "complex.mul"(%3, %3) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32> loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":362:13 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":375:8))
    "func.return"(%4) : (complex<f32>) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":376:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":367:1)
}) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":0:0)
