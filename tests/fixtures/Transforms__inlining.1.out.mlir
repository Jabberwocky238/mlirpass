module {
  func.func @func_with_arg(%arg0: i32) -> i32 {
    %0 = arith.addi %arg0, %arg0 : i32
    %1 = builtin.unrealized_conversion_cast %0 : i32 to i64
    %2 = builtin.unrealized_conversion_cast %1 : i64 to i32
    return %2 : i32
  }
  func.func @inline_with_arg(%arg0: i32) -> i32 {
    %0 = arith.addi %arg0, %arg0 : i32
    %1 = builtin.unrealized_conversion_cast %0 : i32 to i64
    %2 = builtin.unrealized_conversion_cast %1 : i64 to i32
    return %2 : i32
  }
  func.func @noinline_with_arg(%arg0: i32) -> i32 {
    %0 = call @func_with_arg(%arg0) {no_inline} : (i32) -> i32
    return %0 : i32
  }
  func.func @non_inlinable_func_with_arg(%arg0: i32) -> i32 attributes {no_inline} {
    %0 = arith.addi %arg0, %arg0 : i32
    return %0 : i32
  }
  func.func @noinline_with_func_arg(%arg0: i32) -> i32 {
    %0 = call @non_inlinable_func_with_arg(%arg0) : (i32) -> i32
    return %0 : i32
  }
  func.func @func_with_multi_return(%arg0: i1) -> i32 {
    cf.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %c0_i32 = arith.constant 0 : i32
    return %c0_i32 : i32
  ^bb2:  // pred: ^bb0
    %c55_i32 = arith.constant 55 : i32
    return %c55_i32 : i32
  }
  func.func @inline_with_multi_return() -> i32 {
    %false = arith.constant false
    cf.cond_br %false, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %c0_i32 = arith.constant 0 : i32
    cf.br ^bb3(%c0_i32 : i32)
  ^bb2:  // pred: ^bb0
    %c55_i32 = arith.constant 55 : i32
    cf.br ^bb3(%c55_i32 : i32)
  ^bb3(%0: i32):  // 2 preds: ^bb1, ^bb2
    return %0 : i32
  }
  func.func @func_with_file_locations(%arg0: i32) -> i32 {
    %0 = arith.addi %arg0, %arg0 : i32
    return %0 : i32
  }
  func.func @func_with_callsite_locations(%arg0: i32) -> i32 {
    %0 = arith.addi %arg0, %arg0 : i32
    return %0 : i32
  }
  func.func @inline_func_with_file_locations(%arg0: i32) -> i32 {
    %0 = arith.addi %arg0, %arg0 : i32
    %1 = arith.addi %0, %0 : i32
    return %1 : i32
  }
  func.func @inline_func_with_callsite_locations(%arg0: i32) -> i32 {
    %0 = arith.addi %arg0, %arg0 : i32
    %1 = arith.addi %0, %0 : i32
    return %1 : i32
  }
  func.func private @func_external()
  func.func @no_inline_external() {
    call @func_external() : () -> ()
    return
  }
  func.func @multilevel_func_a() {
    return
  }
  func.func @multilevel_func_b() {
    return
  }
  func.func @inline_multilevel() {
    %0 = "test.functional_region_op"() ({
      "test.return"() : () -> ()
    }) : () -> (() -> ())
    return
  }
  func.func @no_inline_recursive() {
    %0 = "test.functional_region_op"() ({
      func.call @no_inline_recursive() : () -> ()
      "test.return"() : () -> ()
    }) : () -> (() -> ())
    return
  }
  func.func @convert_callee_fn(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
  func.func @convert_callee_fn_multi_arg(%arg0: i32, %arg1: i32) {
    return
  }
  func.func @convert_callee_fn_multi_res() -> (i32, i32) {
    %c0_i32 = arith.constant 0 : i32
    return %c0_i32, %c0_i32 : i32, i32
  }
  func.func @inline_convert_call() -> i16 {
    %c0_i16 = arith.constant 0 : i16
    %0 = "test.cast"(%c0_i16) : (i16) -> i32
    %1 = "test.cast"(%0) : (i32) -> i16
    return %1 : i16
  }
  func.func @convert_callee_fn_multiblock() -> i32 {
    cf.br ^bb1
  ^bb1:  // pred: ^bb0
    %c0_i32 = arith.constant 0 : i32
    return %c0_i32 : i32
  }
  func.func @inline_convert_result_multiblock() -> i16 {
    cf.br ^bb1 {inlined_conversion}
  ^bb1:  // pred: ^bb0
    %c0_i32 = arith.constant {inlined_conversion} 0 : i32
    cf.br ^bb2(%c0_i32 : i32)
  ^bb2(%0: i32):  // pred: ^bb1
    %1 = "test.cast"(%0) : (i32) -> i16
    return %1 : i16
  }
  func.func @no_inline_convert_call() {
    %c0_i16 = arith.constant 0 : i16
    %c0_i64 = arith.constant 0 : i64
    "test.conversion_call_op"(%c0_i16, %c0_i64) <{callee = @convert_callee_fn_multi_arg}> : (i16, i64) -> ()
    %0:2 = "test.conversion_call_op"() <{callee = @convert_callee_fn_multi_res}> : () -> (i16, i64)
    return
  }
  func.func @simplify_return_constant() -> i32 {
    %c0_i32 = arith.constant 0 : i32
    return %c0_i32 : i32
  }
  func.func @simplify_return_reference() -> (() -> i32) {
    %f = constant @simplify_return_constant : () -> i32
    return %f : () -> i32
  }
  func.func @inline_simplify() -> i32 {
    %f = constant @simplify_return_constant : () -> i32
    %0 = call_indirect %f() : () -> i32
    return %0 : i32
  }
  func.func @no_inline_invalid_call() -> i32 {
    %0 = "test.conversion_call_op"() <{callee = @convert_callee_fn_multiblock}> {noinline} : () -> i32
    return %0 : i32
  }
  func.func @gpu_alloc() -> memref<1024xf32> {
    %memref = gpu.alloc  () : memref<1024xf32>
    return %memref : memref<1024xf32>
  }
  func.func @inline_gpu_ops() -> memref<1024xf32> {
    %memref = gpu.alloc  () : memref<1024xf32>
    return %memref : memref<1024xf32>
  }
  func.func @func_with_block_args_location(%arg0: i32) {
    cf.br ^bb1(%arg0 : i32)
  ^bb1(%0: i32):  // pred: ^bb0
    "test.foo"(%0) : (i32) -> ()
    return
  }
  func.func @func_with_block_args_location_callee1(%arg0: i32) {
    cf.br ^bb1(%arg0 : i32)
  ^bb1(%0: i32):  // pred: ^bb0
    "test.foo"(%0) : (i32) -> ()
    cf.br ^bb2
  ^bb2:  // pred: ^bb1
    return
  }
  func.func @func_with_block_args_location_callee2(%arg0: i32) {
    cf.br ^bb1(%arg0 : i32)
  ^bb1(%0: i32):  // pred: ^bb0
    "test.foo"(%0) : (i32) -> ()
    cf.br ^bb2
  ^bb2:  // pred: ^bb1
    return
  }
  func.func @func_with_multiple_blocks(%arg0: i32) {
    cf.br ^bb1(%arg0 : i32)
  ^bb1(%0: i32):  // pred: ^bb0
    "test.foo"(%0) : (i32) -> ()
    return
  }
  func.func @func_with_multiple_blocks_callee1(%arg0: i32) {
    "test.dummy_op"() ({
      func.call @func_with_multiple_blocks(%arg0) : (i32) -> ()
      "test.terminator"() : () -> ()
    }) : () -> ()
    return
  }
  func.func @func_with_multiple_blocks_callee2(%arg0: i32, %arg1: i1) {
    %0 = scf.while (%arg2 = %arg0) : (i32) -> i32 {
      func.call @func_with_multiple_blocks(%arg0) : (i32) -> ()
      scf.condition(%arg1) %arg2 : i32
    } do {
    ^bb0(%arg2: i32):
      scf.yield %arg2 : i32
    }
    return
  }
  test.conversion_func_op @handle_attr_callee_fn_multi_arg(%arg0: i16, %arg1: i16 {test.handle_argument}) -> (i16 {test.handle_result}, i16) {
    %0 = arith.addi %arg0, %arg1 : i16
    %1 = arith.subi %arg0, %arg1 : i16
    "test.return"(%0, %1) : (i16, i16) -> ()
  }
  test.conversion_func_op @handle_attr_callee_fn(%arg0: i32 {test.handle_argument}) -> (i32 {test.handle_result}) {
    "test.return"(%arg0) : (i32) -> ()
  }
  func.func @inline_handle_attr_call(%arg0: i16, %arg1: i16) -> (i16, i16) {
    %0 = "test.type_changer"(%arg1) : (i16) -> i16
    %1 = arith.addi %arg0, %0 {inlined_conversion} : i16
    %2 = arith.subi %arg0, %0 {inlined_conversion} : i16
    %3 = "test.type_changer"(%1) : (i16) -> i16
    return %3, %2 : i16, i16
  }
  func.func @inline_convert_and_handle_attr_call(%arg0: i16) -> i16 {
    %0 = "test.cast"(%arg0) : (i16) -> i32
    %1 = "test.type_changer"(%0) : (i32) -> i32
    %2 = "test.type_changer"(%1) : (i32) -> i32
    %3 = "test.cast"(%2) : (i32) -> i16
    return %3 : i16
  }
  func.func @double_square_complex(%arg0: complex<f32>) -> complex<f32> {
    %0 = complex.add %arg0, %arg0 : complex<f32>
    %1 = complex.mul %0, %0 : complex<f32>
    return %1 : complex<f32>
  }
  func.func @inline_with_complex_ops() -> complex<f32> {
    %cst = arith.constant 1.000000e+00 : f32
    %cst_0 = arith.constant 2.000000e+00 : f32
    %0 = complex.create %cst, %cst_0 : complex<f32>
    %1 = complex.add %0, %0 : complex<f32>
    %2 = complex.mul %1, %1 : complex<f32>
    return %2 : complex<f32>
  }
}

