"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "func_with_arg"}> ({
  ^bb0(%arg28: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":8:26)):
    %44 = "arith.addi"(%arg28, %arg28) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":9:8)
    %45 = "builtin.unrealized_conversion_cast"(%44) : (i32) -> i64 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":10:8)
    %46 = "builtin.unrealized_conversion_cast"(%45) : (i64) -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":11:8)
    "func.return"(%46) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":12:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":8:1)
  "func.func"() <{function_type = (i32) -> i32, sym_name = "inline_with_arg"}> ({
  ^bb0(%arg27: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":16:28)):
    %43 = "func.call"(%arg27) <{callee = @func_with_arg}> : (i32) -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":22:8)
    "func.return"(%43) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":23:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":16:1)
  "func.func"() <{function_type = (i32) -> i32, sym_name = "noinline_with_arg"}> ({
  ^bb0(%arg26: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":27:30)):
    %42 = "func.call"(%arg26) <{callee = @func_with_arg, no_inline}> : (i32) -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":31:8)
    "func.return"(%42) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":32:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":27:1)
  "func.func"() <{function_type = (i32) -> i32, no_inline, sym_name = "non_inlinable_func_with_arg"}> ({
  ^bb0(%arg25: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":35:40)):
    %41 = "arith.addi"(%arg25, %arg25) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":36:8)
    "func.return"(%41) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":37:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":35:1)
  "func.func"() <{function_type = (i32) -> i32, sym_name = "noinline_with_func_arg"}> ({
  ^bb0(%arg24: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":41:35)):
    %40 = "func.call"(%arg24) <{callee = @non_inlinable_func_with_arg}> : (i32) -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":45:8)
    "func.return"(%40) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":46:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":41:1)
  "func.func"() <{function_type = (i1) -> i32, sym_name = "func_with_multi_return"}> ({
  ^bb0(%arg23: i1 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":50:35)):
    "cf.cond_br"(%arg23)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":51:3)
  ^bb1:  // pred: ^bb0
    %38 = "arith.constant"() <{value = 0 : i32}> : () -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":54:14)
    "func.return"(%38) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":55:3)
  ^bb2:  // pred: ^bb0
    %39 = "arith.constant"() <{value = 55 : i32}> : () -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":58:15)
    "func.return"(%39) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":59:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":50:1)
  "func.func"() <{function_type = () -> i32, sym_name = "inline_with_multi_return"}> ({
    %36 = "arith.constant"() <{value = false}> : () -> i1 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":75:12)
    %37 = "func.call"(%36) <{callee = @func_with_multi_return}> : (i1) -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":76:8)
    "func.return"(%37) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":77:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":63:1)
  "func.func"() <{function_type = (i32) -> i32, sym_name = "func_with_file_locations"}> ({
  ^bb0(%arg22: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":86:37)):
    %35 = "arith.addi"(%arg22, %arg22) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32 loc("mysource.cc":10:8)
    "func.return"(%35) : (i32) -> () loc("mysource.cc":11:2)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":86:1)
  "func.func"() <{function_type = (i32) -> i32, sym_name = "func_with_callsite_locations"}> ({
  ^bb0(%arg21: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":92:41)):
    %34 = "arith.addi"(%arg21, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32 loc(callsite("mysource1.cc":10:8 at callsite("mysource2.cc":13:6 at "mysource3.cc":16:2)))
    "func.return"(%34) : (i32) -> () loc(callsite("mysource1.cc":10:8 at callsite("mysource2.cc":13:6 at "mysource3.cc":16:2)))
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":92:1)
  "func.func"() <{function_type = (i32) -> i32, sym_name = "inline_func_with_file_locations"}> ({
  ^bb0(%arg20: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":98:44)):
    %32 = "func.call"(%arg20) <{callee = @func_with_file_locations}> : (i32) -> i32 loc("mysource.cc":55:14)
    %33 = "func.call"(%32) <{callee = @func_with_file_locations}> : (i32) -> i32 loc(callsite("mysource1.cc":10:8 at callsite("mysource2.cc":13:6 at "mysource3.cc":16:2)))
    "func.return"(%33) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":108:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":98:1)
  "func.func"() <{function_type = (i32) -> i32, sym_name = "inline_func_with_callsite_locations"}> ({
  ^bb0(%arg19: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":112:48)):
    %30 = "func.call"(%arg19) <{callee = @func_with_callsite_locations}> : (i32) -> i32 loc("mysource.cc":10:8)
    %31 = "func.call"(%30) <{callee = @func_with_callsite_locations}> : (i32) -> i32 loc(callsite("mysource4.cc":55:4 at callsite("mysource5.cc":25:8 at "mysource6.cc":32:4)))
    "func.return"(%31) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":124:3)
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
    "func.call"() <{callee = @multilevel_func_a}> : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":142:3)
    "func.return"() : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":143:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":141:1)
  "func.func"() <{function_type = () -> (), sym_name = "inline_multilevel"}> ({
    %29 = "test.functional_region_op"() ({
      "func.call"() <{callee = @multilevel_func_b}> : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":150:5)
      "test.return"() : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":151:5)
    }) : () -> (() -> ()) loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":149:9)
    "func.call_indirect"(%29) : (() -> ()) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":154:3)
    "func.return"() : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":155:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":147:1)
  "func.func"() <{function_type = () -> (), sym_name = "no_inline_recursive"}> ({
    %28 = "test.functional_region_op"() ({
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
    %27 = "arith.constant"() <{value = 0 : i32}> : () -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":178:10)
    "func.return"(%27, %27) : (i32, i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":179:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":177:1)
  "func.func"() <{function_type = () -> i16, sym_name = "inline_convert_call"}> ({
    %25 = "arith.constant"() <{value = 0 : i16}> : () -> i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":185:17)
    %26 = "test.conversion_call_op"(%25) <{callee = @convert_callee_fn}> : (i16) -> i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":190:10)
    "func.return"(%26) : (i16) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":191:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":183:1)
  "func.func"() <{function_type = () -> i32, sym_name = "convert_callee_fn_multiblock"}> ({
    "cf.br"()[^bb1] : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":195:3)
  ^bb1:  // pred: ^bb0
    %24 = "arith.constant"() <{value = 0 : i32}> : () -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":197:8)
    "func.return"(%24) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":198:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":194:1)
  "func.func"() <{function_type = () -> i16, sym_name = "inline_convert_result_multiblock"}> ({
    %23 = "test.conversion_call_op"() <{callee = @convert_callee_fn_multiblock}> : () -> i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":211:10)
    "func.return"(%23) : (i16) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":212:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":202:1)
  "func.func"() <{function_type = () -> (), sym_name = "no_inline_convert_call"}> ({
    %20 = "arith.constant"() <{value = 0 : i16}> : () -> i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":218:21)
    %21 = "arith.constant"() <{value = 0 : i64}> : () -> i64 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":219:21)
    "test.conversion_call_op"(%20, %21) <{callee = @convert_callee_fn_multi_arg}> : (i16, i64) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":220:3)
    %22:2 = "test.conversion_call_op"() <{callee = @convert_callee_fn_multi_res}> : () -> (i16, i64) loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":223:14)
    "func.return"() : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":224:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":216:1)
  "func.func"() <{function_type = () -> i32, sym_name = "simplify_return_constant"}> ({
    %19 = "arith.constant"() <{value = 0 : i32}> : () -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":229:10)
    "func.return"(%19) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":230:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":228:1)
  "func.func"() <{function_type = () -> (() -> i32), sym_name = "simplify_return_reference"}> ({
    %18 = "func.constant"() <{value = @simplify_return_constant}> : () -> (() -> i32) loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":234:10)
    "func.return"(%18) : (() -> i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":235:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":233:1)
  "func.func"() <{function_type = () -> i32, sym_name = "inline_simplify"}> ({
    %16 = "func.call"() <{callee = @simplify_return_reference}> : () -> (() -> i32) loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":242:9)
    %17 = "func.call_indirect"(%16) : (() -> i32) -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":243:10)
    "func.return"(%17) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":244:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":239:1)
  "func.func"() <{function_type = () -> i32, sym_name = "no_inline_invalid_call"}> ({
    %15 = "test.conversion_call_op"() <{callee = @convert_callee_fn_multiblock}> {noinline} : () -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":249:10)
    "func.return"(%15) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":250:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":248:1)
  "func.func"() <{function_type = () -> memref<1024xf32>, sym_name = "gpu_alloc"}> ({
    %14 = "gpu.alloc"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> memref<1024xf32> loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":254:8)
    "func.return"(%14) : (memref<1024xf32>) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":255:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":253:1)
  "func.func"() <{function_type = () -> memref<1024xf32>, sym_name = "inline_gpu_ops"}> ({
    %13 = "func.call"() <{callee = @gpu_alloc}> : () -> memref<1024xf32> loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":261:8)
    "func.return"(%13) : (memref<1024xf32>) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":262:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":259:1)
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_block_args_location"}> ({
  ^bb0(%arg15: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":267:42)):
    "cf.br"(%arg15)[^bb1] : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":268:3)
  ^bb1(%12: i32 loc("foo")):  // pred: ^bb0
    "test.foo"(%12) : (i32) -> () loc("bar")
    "func.return"() : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":271:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":267:1)
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_block_args_location_callee1"}> ({
  ^bb0(%arg14: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":277:50)):
    "func.call"(%arg14) <{callee = @func_with_block_args_location}> : (i32) -> () loc("bar")
    "func.return"() : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":279:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":277:1)
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_block_args_location_callee2"}> ({
  ^bb0(%arg13: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":283:50)):
    "func.call"(%arg13) <{callee = @func_with_block_args_location}> : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":284:3)
    "func.return"() : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":285:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":283:1)
  "func.func"() <{function_type = (i32) -> (), sym_name = "func_with_multiple_blocks"}> ({
  ^bb0(%arg12: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":288:38)):
    "cf.br"(%arg12)[^bb1] : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":289:3)
  ^bb1(%11: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":290:6)):  // pred: ^bb0
    "test.foo"(%11) : (i32) -> () loc("bar")
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
    %10 = "scf.while"(%arg7) ({
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
    %8 = "arith.addi"(%arg5, %arg6) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":324:8)
    %9 = "arith.subi"(%arg5, %arg6) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":325:8)
    "test.return"(%8, %9) : (i16, i16) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":326:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":323:1)
  "test.conversion_func_op"() <{arg_attrs = [{test.handle_argument}], function_type = (i32) -> i32, res_attrs = [{test.handle_result}], sym_name = "handle_attr_callee_fn"}> ({
  ^bb0(%arg4: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":328:48)):
    "test.return"(%arg4) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":329:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":328:1)
  "func.func"() <{function_type = (i16, i16) -> (i16, i16), sym_name = "inline_handle_attr_call"}> ({
  ^bb0(%arg2: i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":335:36), %arg3: i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":335:49)):
    %7:2 = "test.conversion_call_op"(%arg2, %arg3) <{callee = @handle_attr_callee_fn_multi_arg}> : (i16, i16) -> (i16, i16) loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":342:18)
    "func.return"(%7#0, %7#1) : (i16, i16) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":343:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":335:1)
  "func.func"() <{function_type = (i16) -> i16, sym_name = "inline_convert_and_handle_attr_call"}> ({
  ^bb0(%arg1: i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":348:48)):
    %6 = "test.conversion_call_op"(%arg1) <{callee = @handle_attr_callee_fn}> : (i16) -> i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":355:10)
    "func.return"(%6) : (i16) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":356:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":348:1)
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "double_square_complex"}> ({
  ^bb0(%arg0: complex<f32> loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":360:34)):
    %4 = "complex.add"(%arg0, %arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32> loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":361:13)
    %5 = "complex.mul"(%4, %4) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32> loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":362:13)
    "func.return"(%5) : (complex<f32>) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":363:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":360:1)
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "inline_with_complex_ops"}> ({
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":368:9)
    %1 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":369:9)
    %2 = "complex.create"(%0, %1) : (f32, f32) -> complex<f32> loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":370:8)
    %3 = "func.call"(%2) <{callee = @double_square_complex}> : (complex<f32>) -> complex<f32> loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":375:8)
    "func.return"(%3) : (complex<f32>) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":376:3)
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":367:1)
}) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":0:0)
