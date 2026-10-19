module {
  func.func @func_with_arg(%arg0: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":8:26)) -> i32 {
    %0 = arith.addi %arg0, %arg0 : i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":9:8)
    %1 = builtin.unrealized_conversion_cast %0 : i32 to i64 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":10:8)
    %2 = builtin.unrealized_conversion_cast %1 : i64 to i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":11:8)
    return %2 : i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":12:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":8:1)
  func.func @inline_with_arg(%arg0: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":16:28)) -> i32 {
    %0 = arith.addi %arg0, %arg0 : i32 loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":9:8 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":22:8))
    %1 = builtin.unrealized_conversion_cast %0 : i32 to i64 loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":10:8 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":22:8))
    %2 = builtin.unrealized_conversion_cast %1 : i64 to i32 loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":11:8 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":22:8))
    return %2 : i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":23:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":16:1)
  func.func @noinline_with_arg(%arg0: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":27:30)) -> i32 {
    %0 = call @func_with_arg(%arg0) {no_inline} : (i32) -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":31:8)
    return %0 : i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":32:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":27:1)
  func.func @non_inlinable_func_with_arg(%arg0: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":35:40)) -> i32 attributes {no_inline} {
    %0 = arith.addi %arg0, %arg0 : i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":36:8)
    return %0 : i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":37:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":35:1)
  func.func @noinline_with_func_arg(%arg0: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":41:35)) -> i32 {
    %0 = call @non_inlinable_func_with_arg(%arg0) : (i32) -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":45:8)
    return %0 : i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":46:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":41:1)
  func.func @func_with_multi_return(%arg0: i1 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":50:35)) -> i32 {
    cf.cond_br %arg0, ^bb1, ^bb2 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":51:3)
  ^bb1:  // pred: ^bb0
    %c0_i32 = arith.constant 0 : i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":54:14)
    return %c0_i32 : i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":55:3)
  ^bb2:  // pred: ^bb0
    %c55_i32 = arith.constant 55 : i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":58:15)
    return %c55_i32 : i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":59:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":50:1)
  func.func @inline_with_multi_return() -> i32 {
    %false = arith.constant false loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":75:12)
    cf.cond_br %false, ^bb1, ^bb2 loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":51:3 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":76:8))
  ^bb1:  // pred: ^bb0
    %c0_i32 = arith.constant 0 : i32 loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":54:14 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":76:8))
    cf.br ^bb3(%c0_i32 : i32) loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":55:3 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":76:8))
  ^bb2:  // pred: ^bb0
    %c55_i32 = arith.constant 55 : i32 loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":58:15 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":76:8))
    cf.br ^bb3(%c55_i32 : i32) loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":59:3 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":76:8))
  ^bb3(%0: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":76:8)):  // 2 preds: ^bb1, ^bb2
    return %0 : i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":77:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":63:1)
  func.func @func_with_file_locations(%arg0: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":86:37)) -> i32 {
    %0 = arith.addi %arg0, %arg0 : i32 loc("mysource.cc":10:8)
    return %0 : i32 loc("mysource.cc":11:2)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":86:1)
  func.func @func_with_callsite_locations(%arg0: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":92:41)) -> i32 {
    %0 = arith.addi %arg0, %arg0 : i32 loc(callsite("mysource1.cc":10:8 at callsite("mysource2.cc":13:6 at "mysource3.cc":16:2)))
    return %0 : i32 loc(callsite("mysource1.cc":10:8 at callsite("mysource2.cc":13:6 at "mysource3.cc":16:2)))
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":92:1)
  func.func @inline_func_with_file_locations(%arg0: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":98:44)) -> i32 {
    %0 = arith.addi %arg0, %arg0 : i32 loc(callsite("mysource.cc":10:8 at "mysource.cc":55:14))
    %1 = arith.addi %0, %0 : i32 loc(callsite("mysource.cc":10:8 at callsite("mysource1.cc":10:8 at callsite("mysource2.cc":13:6 at "mysource3.cc":16:2))))
    return %1 : i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":108:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":98:1)
  func.func @inline_func_with_callsite_locations(%arg0: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":112:48)) -> i32 {
    %0 = arith.addi %arg0, %arg0 : i32 loc(callsite("mysource1.cc":10:8 at callsite("mysource2.cc":13:6 at callsite("mysource3.cc":16:2 at "mysource.cc":10:8))))
    %1 = arith.addi %0, %0 : i32 loc(callsite("mysource1.cc":10:8 at callsite("mysource2.cc":13:6 at callsite("mysource3.cc":16:2 at callsite("mysource4.cc":55:4 at callsite("mysource5.cc":25:8 at "mysource6.cc":32:4))))))
    return %1 : i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":124:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":112:1)
  func.func private @func_external() loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":128:1)
  func.func @no_inline_external() {
    call @func_external() : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":133:3)
    return loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":134:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":131:1)
  func.func @multilevel_func_a() {
    return loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":139:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":138:1)
  func.func @multilevel_func_b() {
    return loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":143:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":141:1)
  func.func @inline_multilevel() {
    %0 = "test.functional_region_op"() ({
      "test.return"() : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":151:5)
    }) : () -> (() -> ()) loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":149:9)
    return loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":155:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":147:1)
  func.func @no_inline_recursive() {
    %0 = "test.functional_region_op"() ({
      func.call @no_inline_recursive() : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":164:5)
      "test.return"() : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":165:5)
    }) : () -> (() -> ()) loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":163:9)
    return loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":167:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":160:1)
  func.func @convert_callee_fn(%arg0: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":171:30)) -> i32 {
    return %arg0 : i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":172:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":171:1)
  func.func @convert_callee_fn_multi_arg(%arg0: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":174:40), %arg1: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":174:50)) {
    return loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":175:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":174:1)
  func.func @convert_callee_fn_multi_res() -> (i32, i32) {
    %c0_i32 = arith.constant 0 : i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":178:10)
    return %c0_i32, %c0_i32 : i32, i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":179:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":177:1)
  func.func @inline_convert_call() -> i16 {
    %c0_i16 = arith.constant 0 : i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":185:17)
    %0 = "test.cast"(%c0_i16) : (i16) -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":190:10)
    %1 = "test.cast"(%0) : (i32) -> i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":190:10)
    return %1 : i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":191:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":183:1)
  func.func @convert_callee_fn_multiblock() -> i32 {
    cf.br ^bb1 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":195:3)
  ^bb1:  // pred: ^bb0
    %c0_i32 = arith.constant 0 : i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":197:8)
    return %c0_i32 : i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":198:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":194:1)
  func.func @inline_convert_result_multiblock() -> i16 {
    cf.br ^bb1 {inlined_conversion} loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":195:3 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":211:10))
  ^bb1:  // pred: ^bb0
    %c0_i32 = arith.constant {inlined_conversion} 0 : i32 loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":197:8 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":211:10))
    cf.br ^bb2(%c0_i32 : i32) loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":198:3 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":211:10))
  ^bb2(%0: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":211:10)):  // pred: ^bb1
    %1 = "test.cast"(%0) : (i32) -> i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":211:10)
    return %1 : i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":212:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":202:1)
  func.func @no_inline_convert_call() {
    %c0_i16 = arith.constant 0 : i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":218:21)
    %c0_i64 = arith.constant 0 : i64 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":219:21)
    "test.conversion_call_op"(%c0_i16, %c0_i64) <{callee = @convert_callee_fn_multi_arg}> : (i16, i64) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":220:3)
    %0:2 = "test.conversion_call_op"() <{callee = @convert_callee_fn_multi_res}> : () -> (i16, i64) loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":223:14)
    return loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":224:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":216:1)
  func.func @simplify_return_constant() -> i32 {
    %c0_i32 = arith.constant 0 : i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":229:10)
    return %c0_i32 : i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":230:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":228:1)
  func.func @simplify_return_reference() -> (() -> i32) {
    %f = constant @simplify_return_constant : () -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":234:10)
    return %f : () -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":235:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":233:1)
  func.func @inline_simplify() -> i32 {
    %f = constant @simplify_return_constant : () -> i32 loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":234:10 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":242:9))
    %0 = call_indirect %f() : () -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":243:10)
    return %0 : i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":244:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":239:1)
  func.func @no_inline_invalid_call() -> i32 {
    %0 = "test.conversion_call_op"() <{callee = @convert_callee_fn_multiblock}> {noinline} : () -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":249:10)
    return %0 : i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":250:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":248:1)
  func.func @gpu_alloc() -> memref<1024xf32> {
    %memref = gpu.alloc  () : memref<1024xf32> loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":254:8)
    return %memref : memref<1024xf32> loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":255:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":253:1)
  func.func @inline_gpu_ops() -> memref<1024xf32> {
    %memref = gpu.alloc  () : memref<1024xf32> loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":254:8 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":261:8))
    return %memref : memref<1024xf32> loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":262:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":259:1)
  func.func @func_with_block_args_location(%arg0: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":267:42)) {
    cf.br ^bb1(%arg0 : i32) loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":268:3)
  ^bb1(%0: i32 loc("foo")):  // pred: ^bb0
    "test.foo"(%0) : (i32) -> () loc("bar")
    return loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":271:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":267:1)
  func.func @func_with_block_args_location_callee1(%arg0: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":277:50)) {
    cf.br ^bb1(%arg0 : i32) loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":268:3 at "bar"))
  ^bb1(%0: i32 loc(callsite("foo" at "bar"))):  // pred: ^bb0
    "test.foo"(%0) : (i32) -> () loc(callsite("bar" at "bar"))
    cf.br ^bb2 loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":271:3 at "bar"))
  ^bb2:  // pred: ^bb1
    return loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":279:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":277:1)
  func.func @func_with_block_args_location_callee2(%arg0: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":283:50)) {
    cf.br ^bb1(%arg0 : i32) loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":268:3 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":284:3))
  ^bb1(%0: i32 loc(callsite("foo" at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":284:3))):  // pred: ^bb0
    "test.foo"(%0) : (i32) -> () loc(callsite("bar" at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":284:3))
    cf.br ^bb2 loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":271:3 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":284:3))
  ^bb2:  // pred: ^bb1
    return loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":285:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":283:1)
  func.func @func_with_multiple_blocks(%arg0: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":288:38)) {
    cf.br ^bb1(%arg0 : i32) loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":289:3)
  ^bb1(%0: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":290:6)):  // pred: ^bb0
    "test.foo"(%0) : (i32) -> () loc("bar")
    return loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":292:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":288:1)
  func.func @func_with_multiple_blocks_callee1(%arg0: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":296:46)) {
    "test.dummy_op"() ({
      func.call @func_with_multiple_blocks(%arg0) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":301:5)
      "test.terminator"() : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":302:5)
    }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":297:3)
    return loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":304:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":296:1)
  func.func @func_with_multiple_blocks_callee2(%arg0: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":308:46), %arg1: i1 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":308:59)) {
    %0 = scf.while (%arg2 = %arg0) : (i32) -> i32 {
      func.call @func_with_multiple_blocks(%arg0) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":313:5)
      scf.condition(%arg1) %arg2 : i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":314:5)
    } do {
    ^bb0(%arg2: i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":316:8)):
      scf.yield %arg2 : i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":317:5)
    } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":309:8)
    return loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":319:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":308:1)
  test.conversion_func_op @handle_attr_callee_fn_multi_arg(%arg0: i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":323:58), %arg1: i16 {test.handle_argument} loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":323:71)) -> (i16 {test.handle_result}, i16) {
    %0 = arith.addi %arg0, %arg1 : i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":324:8)
    %1 = arith.subi %arg0, %arg1 : i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":325:8)
    "test.return"(%0, %1) : (i16, i16) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":326:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":323:1)
  test.conversion_func_op @handle_attr_callee_fn(%arg0: i32 {test.handle_argument} loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":328:48)) -> (i32 {test.handle_result}) {
    "test.return"(%arg0) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":329:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":328:1)
  func.func @inline_handle_attr_call(%arg0: i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":335:36), %arg1: i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":335:49)) -> (i16, i16) {
    %0 = "test.type_changer"(%arg1) : (i16) -> i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":342:18)
    %1 = arith.addi %arg0, %0 {inlined_conversion} : i16 loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":324:8 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":342:18))
    %2 = arith.subi %arg0, %0 {inlined_conversion} : i16 loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":325:8 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":342:18))
    %3 = "test.type_changer"(%1) : (i16) -> i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":342:18)
    return %3, %2 : i16, i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":343:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":335:1)
  func.func @inline_convert_and_handle_attr_call(%arg0: i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":348:48)) -> i16 {
    %0 = "test.cast"(%arg0) : (i16) -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":355:10)
    %1 = "test.type_changer"(%0) : (i32) -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":355:10)
    %2 = "test.type_changer"(%1) : (i32) -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":355:10)
    %3 = "test.cast"(%2) : (i32) -> i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":355:10)
    return %3 : i16 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":356:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":348:1)
  func.func @double_square_complex(%arg0: complex<f32> loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":360:34)) -> complex<f32> {
    %0 = complex.add %arg0, %arg0 : complex<f32> loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":361:13)
    %1 = complex.mul %0, %0 : complex<f32> loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":362:13)
    return %1 : complex<f32> loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":363:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":360:1)
  func.func @inline_with_complex_ops() -> complex<f32> {
    %cst = arith.constant 1.000000e+00 : f32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":368:9)
    %cst_0 = arith.constant 2.000000e+00 : f32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":369:9)
    %0 = complex.create %cst, %cst_0 : complex<f32> loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":370:8)
    %1 = complex.add %0, %0 : complex<f32> loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":361:13 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":375:8))
    %2 = complex.mul %1, %1 : complex<f32> loc(callsite("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":362:13 at "/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":375:8))
    return %2 : complex<f32> loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":376:3)
  } loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":367:1)
} loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/inlining.mlir":0:0)
