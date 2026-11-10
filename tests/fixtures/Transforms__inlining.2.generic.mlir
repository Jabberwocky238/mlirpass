"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "func_with_arg"}> ({
  ^bb0(%arg34: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":8:26)):
    %72 = "arith.addi"(%arg34, %arg34) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":9:8)
    %73 = "builtin.unrealized_conversion_cast"(%72) : (i32) -> i64 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":10:8)
    %74 = "builtin.unrealized_conversion_cast"(%73) : (i64) -> i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":11:8)
    "func.return"(%74) : (i32) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":12:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":8:1)
  "func.func"() <{function_type = (i32) -> i32, sym_name = "inline_with_arg"}> ({
  ^bb0(%arg33: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":16:28)):
    %69 = "arith.addi"(%arg33, %arg33) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32 loc(callsite("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":9:8 at "/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":22:8))
    %70 = "builtin.unrealized_conversion_cast"(%69) : (i32) -> i64 loc(callsite("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":10:8 at "/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":22:8))
    %71 = "builtin.unrealized_conversion_cast"(%70) : (i64) -> i32 loc(callsite("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":11:8 at "/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":22:8))
    "func.return"(%71) : (i32) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":23:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":16:1)
  "func.func"() <{function_type = (i32) -> i32, sym_name = "noinline_with_arg"}> ({
  ^bb0(%arg32: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":27:30)):
    %68 = "func.call"(%arg32) <{callee = @func_with_arg, no_inline}> : (i32) -> i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":31:8)
    "func.return"(%68) : (i32) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":32:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":27:1)
  "func.func"() <{function_type = (i32) -> i32, no_inline, sym_name = "non_inlinable_func_with_arg"}> ({
  ^bb0(%arg31: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":35:40)):
    %67 = "arith.addi"(%arg31, %arg31) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":36:8)
    "func.return"(%67) : (i32) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":37:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":35:1)
  "func.func"() <{function_type = (i32) -> i32, sym_name = "noinline_with_func_arg"}> ({
  ^bb0(%arg30: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":41:35)):
    %66 = "func.call"(%arg30) <{callee = @non_inlinable_func_with_arg}> : (i32) -> i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":45:8)
    "func.return"(%66) : (i32) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":46:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":41:1)
  "func.func"() <{function_type = (i1) -> i32, sym_name = "func_with_multi_return"}> ({
  ^bb0(%arg29: i1 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":50:35)):
    "cf.cond_br"(%arg29)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":51:3)
  ^bb1:  // pred: ^bb0
    %64 = "arith.constant"() <{value = 0 : i32}> : () -> i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":54:14)
    "func.return"(%64) : (i32) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":55:3)
  ^bb2:  // pred: ^bb0
    %65 = "arith.constant"() <{value = 55 : i32}> : () -> i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":58:15)
    "func.return"(%65) : (i32) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":59:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":50:1)
  "func.func"() <{function_type = () -> i32, sym_name = "inline_with_multi_return"}> ({
    %60 = "arith.constant"() <{value = false}> : () -> i1 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":75:12)
    "cf.cond_br"(%60)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> () loc(callsite("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":51:3 at "/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":76:8))
  ^bb1:  // pred: ^bb0
    %61 = "arith.constant"() <{value = 0 : i32}> : () -> i32 loc(callsite("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":54:14 at "/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":76:8))
    "cf.br"(%61)[^bb3] : (i32) -> () loc(callsite("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":55:3 at "/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":76:8))
  ^bb2:  // pred: ^bb0
    %62 = "arith.constant"() <{value = 55 : i32}> : () -> i32 loc(callsite("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":58:15 at "/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":76:8))
    "cf.br"(%62)[^bb3] : (i32) -> () loc(callsite("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":59:3 at "/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":76:8))
  ^bb3(%63: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":76:8)):  // 2 preds: ^bb1, ^bb2
    "func.return"(%63) : (i32) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":77:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":63:1)
  "func.func"() <{function_type = (i32) -> i32, sym_name = "func_with_file_locations"}> ({
  ^bb0(%arg28: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":86:37)):
    %59 = "arith.addi"(%arg28, %arg28) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32 loc("mysource.cc":10:8)
    "func.return"(%59) : (i32) -> () loc("mysource.cc":11:2)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":86:1)
  "func.func"() <{function_type = (i32) -> i32, sym_name = "func_with_callsite_locations"}> ({
  ^bb0(%arg27: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":92:41)):
    %58 = "arith.addi"(%arg27, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32 loc(callsite("mysource1.cc":10:8 at callsite("mysource2.cc":13:6 at "mysource3.cc":16:2)))
    "func.return"(%58) : (i32) -> () loc(callsite("mysource1.cc":10:8 at callsite("mysource2.cc":13:6 at "mysource3.cc":16:2)))
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":92:1)
  "func.func"() <{function_type = (i32) -> i32, sym_name = "inline_func_with_file_locations"}> ({
  ^bb0(%arg26: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":98:44)):
    %56 = "arith.addi"(%arg26, %arg26) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32 loc(callsite("mysource.cc":10:8 at "mysource.cc":55:14))
    %57 = "arith.addi"(%56, %56) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32 loc(callsite("mysource.cc":10:8 at callsite("mysource1.cc":10:8 at callsite("mysource2.cc":13:6 at "mysource3.cc":16:2))))
    "func.return"(%57) : (i32) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":108:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":98:1)
  "func.func"() <{function_type = (i32) -> i32, sym_name = "inline_func_with_callsite_locations"}> ({
  ^bb0(%arg25: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":112:48)):
    %54 = "arith.addi"(%arg25, %arg25) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32 loc(callsite("mysource1.cc":10:8 at callsite("mysource2.cc":13:6 at callsite("mysource3.cc":16:2 at "mysource.cc":10:8))))
    %55 = "arith.addi"(%54, %54) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32 loc(callsite("mysource1.cc":10:8 at callsite("mysource2.cc":13:6 at callsite("mysource3.cc":16:2 at callsite("mysource4.cc":55:4 at callsite("mysource5.cc":25:8 at "mysource6.cc":32:4))))))
    "func.return"(%55) : (i32) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":124:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":112:1)
  "func.func"() <{function_type = () -> (), sym_name = "func_external", sym_visibility = "private"}> ({
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":128:1)
  "func.func"() <{function_type = () -> (), sym_name = "no_inline_external"}> ({
    "func.call"() <{callee = @func_external}> : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":133:3)
    "func.return"() : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":134:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":131:1)
  "func.func"() <{function_type = () -> (), sym_name = "multilevel_func_a"}> ({
    "func.return"() : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":139:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":138:1)
  "func.func"() <{function_type = () -> (), sym_name = "multilevel_func_b"}> ({
    "func.return"() : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":143:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":141:1)
  "func.func"() <{function_type = () -> (), sym_name = "inline_multilevel"}> ({
    %53 = "test.functional_region_op"() ({
      "test.return"() : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":151:5)
    }) : () -> (() -> ()) loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":149:9)
    "func.return"() : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":155:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":147:1)
  "func.func"() <{function_type = () -> (), sym_name = "no_inline_recursive"}> ({
    %52 = "test.functional_region_op"() ({
      "func.call"() <{callee = @no_inline_recursive}> : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":164:5)
      "test.return"() : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":165:5)
    }) : () -> (() -> ()) loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":163:9)
    "func.return"() : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":167:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":160:1)
  "func.func"() <{function_type = (i32) -> i32, sym_name = "convert_callee_fn"}> ({
  ^bb0(%arg24: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":171:30)):
    "func.return"(%arg24) : (i32) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":172:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":171:1)
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "convert_callee_fn_multi_arg"}> ({
  ^bb0(%arg22: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":174:40), %arg23: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":174:50)):
    "func.return"() : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":175:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":174:1)
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "convert_callee_fn_multi_res"}> ({
    %51 = "arith.constant"() <{value = 0 : i32}> : () -> i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":178:10)
    "func.return"(%51, %51) : (i32, i32) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":179:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":177:1)
  "func.func"() <{function_type = () -> i16, sym_name = "inline_convert_call"}> ({
    %48 = "arith.constant"() <{value = 0 : i16}> : () -> i16 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":185:17)
    %49 = "test.cast"(%48) : (i16) -> i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":190:10)
    %50 = "test.cast"(%49) : (i32) -> i16 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":190:10)
    "func.return"(%50) : (i16) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":191:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":183:1)
  "func.func"() <{function_type = () -> i32, sym_name = "convert_callee_fn_multiblock"}> ({
    "cf.br"()[^bb1] : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":195:3)
  ^bb1:  // pred: ^bb0
    %47 = "arith.constant"() <{value = 0 : i32}> : () -> i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":197:8)
    "func.return"(%47) : (i32) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":198:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":194:1)
  "func.func"() <{function_type = () -> i16, sym_name = "inline_convert_result_multiblock"}> ({
    "cf.br"()[^bb1] {inlined_conversion} : () -> () loc(callsite("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":195:3 at "/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":211:10))
  ^bb1:  // pred: ^bb0
    %44 = "arith.constant"() <{value = 0 : i32}> {inlined_conversion} : () -> i32 loc(callsite("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":197:8 at "/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":211:10))
    "cf.br"(%44)[^bb2] : (i32) -> () loc(callsite("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":198:3 at "/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":211:10))
  ^bb2(%45: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":211:10)):  // pred: ^bb1
    %46 = "test.cast"(%45) : (i32) -> i16 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":211:10)
    "func.return"(%46) : (i16) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":212:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":202:1)
  "func.func"() <{function_type = () -> (), sym_name = "no_inline_convert_call"}> ({
    %41 = "arith.constant"() <{value = 0 : i16}> : () -> i16 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":218:21)
    %42 = "arith.constant"() <{value = 0 : i64}> : () -> i64 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":219:21)
    "test.conversion_call_op"(%41, %42) <{callee = @convert_callee_fn_multi_arg}> : (i16, i64) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":220:3)
    %43:2 = "test.conversion_call_op"() <{callee = @convert_callee_fn_multi_res}> : () -> (i16, i64) loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":223:14)
    "func.return"() : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":224:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":216:1)
  "func.func"() <{function_type = () -> i32, sym_name = "simplify_return_constant"}> ({
    %40 = "arith.constant"() <{value = 0 : i32}> : () -> i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":229:10)
    "func.return"(%40) : (i32) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":230:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":228:1)
  "func.func"() <{function_type = () -> (() -> i32), sym_name = "simplify_return_reference"}> ({
    %39 = "func.constant"() <{value = @simplify_return_constant}> : () -> (() -> i32) loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":234:10)
    "func.return"(%39) : (() -> i32) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":235:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":233:1)
  "func.func"() <{function_type = () -> i32, sym_name = "inline_simplify"}> ({
    %37 = "func.constant"() <{value = @simplify_return_constant}> : () -> (() -> i32) loc(callsite("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":234:10 at "/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":242:9))
    %38 = "func.call_indirect"(%37) : (() -> i32) -> i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":243:10)
    "func.return"(%38) : (i32) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":244:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":239:1)
  "func.func"() <{function_type = () -> i32, sym_name = "no_inline_invalid_call"}> ({
    %36 = "test.conversion_call_op"() <{callee = @convert_callee_fn_multiblock}> {noinline} : () -> i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":249:10)
    "func.return"(%36) : (i32) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":250:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":248:1)
  "func.func"() <{function_type = () -> memref<1024xf32>, sym_name = "gpu_alloc"}> ({
    %35 = "gpu.alloc"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> memref<1024xf32> loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":254:8)
    "func.return"(%35) : (memref<1024xf32>) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":255:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":253:1)
  "func.func"() <{function_type = () -> memref<1024xf32>, sym_name = "inline_gpu_ops"}> ({
    %34 = "gpu.alloc"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> memref<1024xf32> loc(callsite("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":254:8 at "/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":261:8))
    "func.return"(%34) : (memref<1024xf32>) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":262:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":259:1)
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_block_args_location"}> ({
  ^bb0(%arg21: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":267:42)):
    "cf.br"(%arg21)[^bb1] : (i32) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":268:3)
  ^bb1(%33: i32 loc("foo")):  // pred: ^bb0
    "test.foo"(%33) : (i32) -> () loc("bar")
    "func.return"() : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":271:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":267:1)
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_block_args_location_callee1"}> ({
  ^bb0(%arg20: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":277:50)):
    "cf.br"(%arg20)[^bb1] : (i32) -> () loc(callsite("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":268:3 at "bar"))
  ^bb1(%32: i32 loc(callsite("foo" at "bar"))):  // pred: ^bb0
    "test.foo"(%32) : (i32) -> () loc(callsite("bar" at "bar"))
    "cf.br"()[^bb2] : () -> () loc(callsite("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":271:3 at "bar"))
  ^bb2:  // pred: ^bb1
    "func.return"() : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":279:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":277:1)
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_block_args_location_callee2"}> ({
  ^bb0(%arg19: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":283:50)):
    "cf.br"(%arg19)[^bb1] : (i32) -> () loc(callsite("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":268:3 at "/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":284:3))
  ^bb1(%31: i32 loc(callsite("foo" at "/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":284:3))):  // pred: ^bb0
    "test.foo"(%31) : (i32) -> () loc(callsite("bar" at "/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":284:3))
    "cf.br"()[^bb2] : () -> () loc(callsite("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":271:3 at "/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":284:3))
  ^bb2:  // pred: ^bb1
    "func.return"() : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":285:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":283:1)
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_multiple_blocks"}> ({
  ^bb0(%arg18: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":288:38)):
    "cf.br"(%arg18)[^bb1] : (i32) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":289:3)
  ^bb1(%30: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":290:6)):  // pred: ^bb0
    "test.foo"(%30) : (i32) -> () loc("bar")
    "func.return"() : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":292:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":288:1)
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_multiple_blocks_callee1"}> ({
  ^bb0(%arg17: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":296:46)):
    "test.dummy_op"() ({
      "func.call"(%arg17) <{callee = @func_with_multiple_blocks}> : (i32) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":301:5)
      "test.terminator"() : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":302:5)
    }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":297:3)
    "func.return"() : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":304:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":296:1)
  "func.func"() <{function_type = (i32, i1) -> (), sym_name = "func_with_multiple_blocks_callee2"}> ({
  ^bb0(%arg13: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":308:46), %arg14: i1 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":308:59)):
    %29 = "scf.while"(%arg13) ({
    ^bb0(%arg16: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":309:19)):
      "func.call"(%arg13) <{callee = @func_with_multiple_blocks}> : (i32) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":313:5)
      "scf.condition"(%arg14, %arg16) : (i1, i32) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":314:5)
    }, {
    ^bb0(%arg15: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":316:8)):
      "scf.yield"(%arg15) : (i32) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":317:5)
    }) : (i32) -> i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":309:8)
    "func.return"() : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":319:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":308:1)
  "test.conversion_func_op"() <{arg_attrs = [{}, {test.handle_argument}], function_type = (i16, i16) -> (i16, i16), res_attrs = [{test.handle_result}, {}], sym_name = "handle_attr_callee_fn_multi_arg"}> ({
  ^bb0(%arg11: i16 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":323:58), %arg12: i16 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":323:71)):
    %27 = "arith.addi"(%arg11, %arg12) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":324:8)
    %28 = "arith.subi"(%arg11, %arg12) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":325:8)
    "test.return"(%27, %28) : (i16, i16) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":326:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":323:1)
  "test.conversion_func_op"() <{arg_attrs = [{test.handle_argument}], function_type = (i32) -> i32, res_attrs = [{test.handle_result}], sym_name = "handle_attr_callee_fn"}> ({
  ^bb0(%arg10: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":328:48)):
    "test.return"(%arg10) : (i32) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":329:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":328:1)
  "func.func"() <{function_type = (i16, i16) -> (i16, i16), sym_name = "inline_handle_attr_call"}> ({
  ^bb0(%arg8: i16 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":335:36), %arg9: i16 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":335:49)):
    %23 = "test.type_changer"(%arg9) : (i16) -> i16 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":342:18)
    %24 = "arith.addi"(%arg8, %23) <{overflowFlags = #arith.overflow<none>}> {inlined_conversion} : (i16, i16) -> i16 loc(callsite("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":324:8 at "/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":342:18))
    %25 = "arith.subi"(%arg8, %23) <{overflowFlags = #arith.overflow<none>}> {inlined_conversion} : (i16, i16) -> i16 loc(callsite("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":325:8 at "/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":342:18))
    %26 = "test.type_changer"(%24) : (i16) -> i16 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":342:18)
    "func.return"(%26, %25) : (i16, i16) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":343:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":335:1)
  "func.func"() <{function_type = (i16) -> i16, sym_name = "inline_convert_and_handle_attr_call"}> ({
  ^bb0(%arg7: i16 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":348:48)):
    %19 = "test.cast"(%arg7) : (i16) -> i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":355:10)
    %20 = "test.type_changer"(%19) : (i32) -> i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":355:10)
    %21 = "test.type_changer"(%20) : (i32) -> i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":355:10)
    %22 = "test.cast"(%21) : (i32) -> i16 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":355:10)
    "func.return"(%22) : (i16) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":356:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":348:1)
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "double_square_complex"}> ({
  ^bb0(%arg6: complex<f32> loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":360:34)):
    %17 = "complex.add"(%arg6, %arg6) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32> loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":361:13)
    %18 = "complex.mul"(%17, %17) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32> loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":362:13)
    "func.return"(%18) : (complex<f32>) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":363:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":360:1)
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "inline_with_complex_ops"}> ({
    %12 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":368:9)
    %13 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":369:9)
    %14 = "complex.create"(%12, %13) : (f32, f32) -> complex<f32> loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":370:8)
    %15 = "complex.add"(%14, %14) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32> loc(callsite("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":361:13 at "/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":375:8))
    %16 = "complex.mul"(%15, %15) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32> loc(callsite("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":362:13 at "/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":375:8))
    "func.return"(%16) : (complex<f32>) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":376:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":367:1)
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f16, f16)>, linkage = #llvm.linkage<external>, sym_name = "inline_test_return_arity_mismatch", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg4: f16 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":387:46), %arg5: f16 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":387:58)):
    %10 = "test.op_with_bitcast_type"(%arg4) : (f16) -> tensor<4xf32> loc(callsite("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":396:8 at "/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":392:3))
    %11 = "test.op_with_bitcast_type"(%arg5) : (f16) -> tensor<2xi32> loc(callsite("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":397:8 at "/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":392:3))
    "llvm.return"() : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":393:3)
  }) {llvm.emit_c_interface} : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":387:1)
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f16, f16)>, linkage = #llvm.linkage<external>, sym_name = "inline_test_return_arity_mismatch_callee", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg2: f16 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":395:53), %arg3: f16 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":395:65)):
    %8 = "test.op_with_bitcast_type"(%arg2) : (f16) -> tensor<4xf32> loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":396:8)
    %9 = "test.op_with_bitcast_type"(%arg3) : (f16) -> tensor<2xi32> loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":397:8)
    "test.return"(%8, %9) : (tensor<4xf32>, tensor<2xi32>) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":398:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":395:1)
  "func.func"() <{function_type = (i32) -> i32, sym_name = "inline_functional_region_multiblock"}> ({
  ^bb0(%arg0: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":406:48)):
    %0 = "test.functional_region_op"() ({
    ^bb0(%arg1: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":413:8)):
      %5 = "arith.addi"(%arg1, %arg1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":414:10)
      "cf.br"(%5)[^bb1] : (i32) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":415:5)
    ^bb1(%6: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":416:8)):  // pred: ^bb0
      %7 = "arith.addi"(%6, %6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":417:10)
      "test.return"(%7) : (i32) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":418:5)
    }) : () -> ((i32) -> i32) loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":412:9)
    %1 = "arith.addi"(%arg0, %arg0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32 loc(callsite("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":414:10 at "/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":420:8))
    "cf.br"(%1)[^bb1] : (i32) -> () loc(callsite("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":415:5 at "/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":420:8))
  ^bb1(%2: i32 loc(callsite("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":416:8 at "/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":420:8))):  // pred: ^bb0
    %3 = "arith.addi"(%2, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32 loc(callsite("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":417:10 at "/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":420:8))
    "cf.br"(%3)[^bb2] : (i32) -> () loc(callsite("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":418:5 at "/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":420:8))
  ^bb2(%4: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":420:8)):  // pred: ^bb1
    "func.return"(%4) : (i32) -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":421:3)
  }) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":406:1)
}) : () -> () loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Transforms/inlining.mlir":0:0)
