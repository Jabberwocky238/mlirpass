module {
  llvm.func @empty() {
    llvm.return
  }
  llvm.func @body(i32) attributes {sym_visibility = "private"}
  llvm.func @simple_loop() {
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %0 = llvm.mlir.constant(1 : index) : i32
    %1 = llvm.mlir.constant(42 : index) : i32
    llvm.br ^bb2(%0 : i32)
  ^bb2(%2: i32):  // 2 preds: ^bb1, ^bb3
    %3 = llvm.icmp "slt" %2, %1 : i32
    llvm.cond_br %3, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    llvm.call @body(%2) : (i32) -> ()
    %4 = llvm.mlir.constant(1 : index) : i32
    %5 = llvm.add %2, %4 : i32
    llvm.br ^bb2(%5 : i32)
  ^bb4:  // pred: ^bb2
    llvm.return
  }
  llvm.func @simple_caller() {
    llvm.call @simple_loop() : () -> ()
    llvm.return
  }
  llvm.func @call_with_attributes() {
    llvm.call @simple_loop() {baz = [1, 2, 3, 4], foo = "bar"} : () -> ()
    llvm.return
  }
  llvm.func @ml_caller() {
    llvm.call @simple_loop() : () -> ()
    llvm.call @more_imperfectly_nested_loops() : () -> ()
    llvm.return
  }
  llvm.func @body_args(i32) -> i32 attributes {sym_visibility = "private"}
  llvm.func @other(i32, i32) -> i32 attributes {sym_visibility = "private"}
  llvm.func @func_args(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %1 = llvm.mlir.constant(0 : index) : i32
    %2 = llvm.mlir.constant(42 : index) : i32
    llvm.br ^bb2(%1 : i32)
  ^bb2(%3: i32):  // 2 preds: ^bb1, ^bb3
    %4 = llvm.icmp "slt" %3, %2 : i32
    llvm.cond_br %4, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    %5 = llvm.call @body_args(%3) : (i32) -> i32
    %6 = llvm.call @other(%5, %arg0) : (i32, i32) -> i32
    %7 = llvm.call @other(%5, %6) : (i32, i32) -> i32
    %8 = llvm.call @other(%5, %arg1) : (i32, i32) -> i32
    %9 = llvm.mlir.constant(1 : index) : i32
    %10 = llvm.add %3, %9 : i32
    llvm.br ^bb2(%10 : i32)
  ^bb4:  // pred: ^bb2
    %11 = llvm.mlir.constant(0 : index) : i32
    %12 = llvm.call @other(%11, %0) : (i32, i32) -> i32
    llvm.return %12 : i32
  }
  llvm.func @pre(i32) attributes {sym_visibility = "private"}
  llvm.func @body2(i32, i32) attributes {sym_visibility = "private"}
  llvm.func @post(i32) attributes {sym_visibility = "private"}
  llvm.func @imperfectly_nested_loops() {
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %0 = llvm.mlir.constant(0 : index) : i32
    %1 = llvm.mlir.constant(42 : index) : i32
    llvm.br ^bb2(%0 : i32)
  ^bb2(%2: i32):  // 2 preds: ^bb1, ^bb7
    %3 = llvm.icmp "slt" %2, %1 : i32
    llvm.cond_br %3, ^bb3, ^bb8
  ^bb3:  // pred: ^bb2
    llvm.call @pre(%2) : (i32) -> ()
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    %4 = llvm.mlir.constant(7 : index) : i32
    %5 = llvm.mlir.constant(56 : index) : i32
    llvm.br ^bb5(%4 : i32)
  ^bb5(%6: i32):  // 2 preds: ^bb4, ^bb6
    %7 = llvm.icmp "slt" %6, %5 : i32
    llvm.cond_br %7, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    llvm.call @body2(%2, %6) : (i32, i32) -> ()
    %8 = llvm.mlir.constant(2 : index) : i32
    %9 = llvm.add %6, %8 : i32
    llvm.br ^bb5(%9 : i32)
  ^bb7:  // pred: ^bb5
    llvm.call @post(%2) : (i32) -> ()
    %10 = llvm.mlir.constant(1 : index) : i32
    %11 = llvm.add %2, %10 : i32
    llvm.br ^bb2(%11 : i32)
  ^bb8:  // pred: ^bb2
    llvm.return
  }
  llvm.func @mid(i32) attributes {sym_visibility = "private"}
  llvm.func @body3(i32, i32) attributes {sym_visibility = "private"}
  llvm.func @more_imperfectly_nested_loops() {
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %0 = llvm.mlir.constant(0 : index) : i32
    %1 = llvm.mlir.constant(42 : index) : i32
    llvm.br ^bb2(%0 : i32)
  ^bb2(%2: i32):  // 2 preds: ^bb1, ^bb11
    %3 = llvm.icmp "slt" %2, %1 : i32
    llvm.cond_br %3, ^bb3, ^bb12
  ^bb3:  // pred: ^bb2
    llvm.call @pre(%2) : (i32) -> ()
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    %4 = llvm.mlir.constant(7 : index) : i32
    %5 = llvm.mlir.constant(56 : index) : i32
    llvm.br ^bb5(%4 : i32)
  ^bb5(%6: i32):  // 2 preds: ^bb4, ^bb6
    %7 = llvm.icmp "slt" %6, %5 : i32
    llvm.cond_br %7, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    llvm.call @body2(%2, %6) : (i32, i32) -> ()
    %8 = llvm.mlir.constant(2 : index) : i32
    %9 = llvm.add %6, %8 : i32
    llvm.br ^bb5(%9 : i32)
  ^bb7:  // pred: ^bb5
    llvm.call @mid(%2) : (i32) -> ()
    llvm.br ^bb8
  ^bb8:  // pred: ^bb7
    %10 = llvm.mlir.constant(18 : index) : i32
    %11 = llvm.mlir.constant(37 : index) : i32
    llvm.br ^bb9(%10 : i32)
  ^bb9(%12: i32):  // 2 preds: ^bb8, ^bb10
    %13 = llvm.icmp "slt" %12, %11 : i32
    llvm.cond_br %13, ^bb10, ^bb11
  ^bb10:  // pred: ^bb9
    llvm.call @body3(%2, %12) : (i32, i32) -> ()
    %14 = llvm.mlir.constant(3 : index) : i32
    %15 = llvm.add %12, %14 : i32
    llvm.br ^bb9(%15 : i32)
  ^bb11:  // pred: ^bb9
    llvm.call @post(%2) : (i32) -> ()
    %16 = llvm.mlir.constant(1 : index) : i32
    %17 = llvm.add %2, %16 : i32
    llvm.br ^bb2(%17 : i32)
  ^bb12:  // pred: ^bb2
    llvm.return
  }
  llvm.func @get_i64() -> i64 attributes {sym_visibility = "private"}
  llvm.func @get_f32() -> f32 attributes {sym_visibility = "private"}
  llvm.func @get_c16() -> !llvm.struct<(f16, f16)> attributes {sym_visibility = "private"}
  llvm.func @get_c32() -> !llvm.struct<(f32, f32)> attributes {sym_visibility = "private"}
  llvm.func @get_c64() -> !llvm.struct<(f64, f64)> attributes {sym_visibility = "private"}
  llvm.func @get_memref() -> !llvm.struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)> attributes {sym_visibility = "private"}
  llvm.func @multireturn() -> !llvm.struct<(i64, f32, struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)>)> {
    %0 = llvm.call @get_i64() : () -> i64
    %1 = llvm.call @get_f32() : () -> f32
    %2 = llvm.call @get_memref() : () -> !llvm.struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)>
    %3 = llvm.mlir.poison : !llvm.struct<(i64, f32, struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)>)>
    %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(i64, f32, struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(i64, f32, struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)>)> 
    %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(i64, f32, struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)>)> 
    llvm.return %6 : !llvm.struct<(i64, f32, struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)>)>
  }
  llvm.func @multireturn_caller() {
    %0 = llvm.call @multireturn() : () -> !llvm.struct<(i64, f32, struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(i64, f32, struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)>)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(i64, f32, struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)>)> 
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(i64, f32, struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)>)> 
    %4 = llvm.mlir.constant(42 : i64) : i64
    %5 = llvm.add %1, %4 : i64
    %6 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %7 = llvm.fadd %2, %6 : f32
    %8 = llvm.mlir.constant(0 : index) : i32
    llvm.return
  }
  llvm.func @dfs_block_order(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    llvm.br ^bb2
  ^bb1:  // pred: ^bb2
    %1 = llvm.add %arg0, %0 : i32
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.br ^bb1
  }
  llvm.func @ceilf(%arg0: f32) {
    %0 = llvm.intr.ceil(%arg0) : (f32) -> f32
    llvm.return
  }
  llvm.func @floorf(%arg0: f32) {
    %0 = llvm.intr.floor(%arg0) : (f32) -> f32
    llvm.return
  }
  module {
    llvm.func @abort()
    llvm.func @puts(!llvm.ptr)
    llvm.mlir.global private constant @assert_msg(dense<[67, 111, 109, 112, 117, 116, 101, 114, 32, 115, 97, 121, 115, 32, 110, 111, 0]> : tensor<17xi8>) {addr_space = 0 : i32} : !llvm.array<17 x i8>
    llvm.func @assert_test_function(%arg0: i1) {
      llvm.cond_br %arg0, ^bb1, ^bb2
    ^bb1:  // pred: ^bb0
      llvm.return
    ^bb2:  // pred: ^bb0
      %0 = llvm.mlir.addressof @assert_msg : !llvm.ptr
      %1 = llvm.getelementptr %0[0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<17 x i8>
      llvm.call @puts(%1) : (!llvm.ptr) -> ()
      llvm.call @abort() : () -> ()
      llvm.unreachable
    }
  }
  llvm.func @call_zero_result_func() {
    llvm.call @zero_result_func() : () -> ()
    llvm.return
  }
  llvm.func @zero_result_func() attributes {sym_visibility = "private"}
  llvm.func @fmaf(%arg0: f32, %arg1: vector<4xf32>) {
    %0 = llvm.intr.fma(%arg0, %arg0, %arg0) : (f32, f32, f32) -> f32
    %1 = llvm.intr.fma(%arg1, %arg1, %arg1) : (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    llvm.return
  }
  llvm.func @switchi8(%arg0: i8) -> i32 {
    llvm.switch %arg0 : i8, ^bb1 [
      42: ^bb1,
      43: ^bb2
    ]
  ^bb1:  // 2 preds: ^bb0, ^bb0
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.return %0 : i32
  ^bb2:  // pred: ^bb0
    %1 = llvm.mlir.constant(42 : i32) : i32
    llvm.return %1 : i32
  }
  llvm.func @index_arg(%arg0: i32) -> i32 {
    llvm.br ^bb1(%arg0 : i32)
  ^bb1(%0: i32):  // pred: ^bb0
    llvm.return %0 : i32
  }
  func.func @non_convertible_arg_type(%arg0: vector<1xtf32>) {
    llvm.return
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_conversion_patterns to %0 {
        transform.apply_conversion_patterns.dialect_to_llvm "math"
        transform.apply_conversion_patterns.dialect_to_llvm "arith"
        transform.apply_conversion_patterns.dialect_to_llvm "cf"
        transform.apply_conversion_patterns.func.func_to_llvm
      } with type_converter {
        transform.apply_conversion_patterns.memref.memref_to_llvm_type_converter {index_bitwidth = 32 : i64, use_opaque_pointers = true}
      } {legal_dialects = ["llvm"], partial_conversion} : !transform.any_op
      transform.yield 
    }
  }
}

