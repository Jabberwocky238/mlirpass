module {
  llvm.func @empty() {
    llvm.return
  }
  llvm.func @body(i64) attributes {sym_visibility = "private"}
  llvm.func @simple_loop() {
    cf.br ^bb1
  ^bb1:  // pred: ^bb0
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = builtin.unrealized_conversion_cast %0 : i64 to index
    %2 = llvm.mlir.constant(42 : index) : i64
    cf.br ^bb2(%1 : index)
  ^bb2(%3: index):  // 2 preds: ^bb1, ^bb3
    %4 = builtin.unrealized_conversion_cast %3 : index to i64
    %5 = builtin.unrealized_conversion_cast %3 : index to i64
    %6 = llvm.icmp "slt" %5, %2 : i64
    cf.cond_br %6, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    llvm.call @body(%4) : (i64) -> ()
    %7 = llvm.mlir.constant(1 : index) : i64
    %8 = llvm.add %5, %7 : i64
    %9 = builtin.unrealized_conversion_cast %8 : i64 to index
    cf.br ^bb2(%9 : index)
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
  llvm.func @body_args(i64) -> i64 attributes {sym_visibility = "private"}
  llvm.func @other(i64, i32) -> i32 attributes {sym_visibility = "private"}
  llvm.func @func_args(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    cf.br ^bb1
  ^bb1:  // pred: ^bb0
    %1 = llvm.mlir.constant(0 : index) : i64
    %2 = builtin.unrealized_conversion_cast %1 : i64 to index
    %3 = llvm.mlir.constant(42 : index) : i64
    cf.br ^bb2(%2 : index)
  ^bb2(%4: index):  // 2 preds: ^bb1, ^bb3
    %5 = builtin.unrealized_conversion_cast %4 : index to i64
    %6 = builtin.unrealized_conversion_cast %4 : index to i64
    %7 = llvm.icmp "slt" %6, %3 : i64
    cf.cond_br %7, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    %8 = llvm.call @body_args(%5) : (i64) -> i64
    %9 = llvm.call @other(%8, %arg0) : (i64, i32) -> i32
    %10 = llvm.call @other(%8, %9) : (i64, i32) -> i32
    %11 = llvm.call @other(%8, %arg1) : (i64, i32) -> i32
    %12 = llvm.mlir.constant(1 : index) : i64
    %13 = llvm.add %6, %12 : i64
    %14 = builtin.unrealized_conversion_cast %13 : i64 to index
    cf.br ^bb2(%14 : index)
  ^bb4:  // pred: ^bb2
    %15 = llvm.mlir.constant(0 : index) : i64
    %16 = llvm.call @other(%15, %0) : (i64, i32) -> i32
    llvm.return %16 : i32
  }
  llvm.func @pre(i64) attributes {sym_visibility = "private"}
  llvm.func @body2(i64, i64) attributes {sym_visibility = "private"}
  llvm.func @post(i64) attributes {sym_visibility = "private"}
  llvm.func @imperfectly_nested_loops() {
    cf.br ^bb1
  ^bb1:  // pred: ^bb0
    %0 = llvm.mlir.constant(0 : index) : i64
    %1 = builtin.unrealized_conversion_cast %0 : i64 to index
    %2 = llvm.mlir.constant(42 : index) : i64
    cf.br ^bb2(%1 : index)
  ^bb2(%3: index):  // 2 preds: ^bb1, ^bb7
    %4 = builtin.unrealized_conversion_cast %3 : index to i64
    %5 = builtin.unrealized_conversion_cast %3 : index to i64
    %6 = llvm.icmp "slt" %5, %2 : i64
    cf.cond_br %6, ^bb3, ^bb8
  ^bb3:  // pred: ^bb2
    llvm.call @pre(%4) : (i64) -> ()
    cf.br ^bb4
  ^bb4:  // pred: ^bb3
    %7 = llvm.mlir.constant(7 : index) : i64
    %8 = builtin.unrealized_conversion_cast %7 : i64 to index
    %9 = llvm.mlir.constant(56 : index) : i64
    cf.br ^bb5(%8 : index)
  ^bb5(%10: index):  // 2 preds: ^bb4, ^bb6
    %11 = builtin.unrealized_conversion_cast %10 : index to i64
    %12 = builtin.unrealized_conversion_cast %10 : index to i64
    %13 = llvm.icmp "slt" %12, %9 : i64
    cf.cond_br %13, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    llvm.call @body2(%4, %11) : (i64, i64) -> ()
    %14 = llvm.mlir.constant(2 : index) : i64
    %15 = llvm.add %12, %14 : i64
    %16 = builtin.unrealized_conversion_cast %15 : i64 to index
    cf.br ^bb5(%16 : index)
  ^bb7:  // pred: ^bb5
    llvm.call @post(%4) : (i64) -> ()
    %17 = llvm.mlir.constant(1 : index) : i64
    %18 = llvm.add %5, %17 : i64
    %19 = builtin.unrealized_conversion_cast %18 : i64 to index
    cf.br ^bb2(%19 : index)
  ^bb8:  // pred: ^bb2
    llvm.return
  }
  llvm.func @mid(i64) attributes {sym_visibility = "private"}
  llvm.func @body3(i64, i64) attributes {sym_visibility = "private"}
  llvm.func @more_imperfectly_nested_loops() {
    cf.br ^bb1
  ^bb1:  // pred: ^bb0
    %0 = llvm.mlir.constant(0 : index) : i64
    %1 = builtin.unrealized_conversion_cast %0 : i64 to index
    %2 = llvm.mlir.constant(42 : index) : i64
    cf.br ^bb2(%1 : index)
  ^bb2(%3: index):  // 2 preds: ^bb1, ^bb11
    %4 = builtin.unrealized_conversion_cast %3 : index to i64
    %5 = builtin.unrealized_conversion_cast %3 : index to i64
    %6 = llvm.icmp "slt" %5, %2 : i64
    cf.cond_br %6, ^bb3, ^bb12
  ^bb3:  // pred: ^bb2
    llvm.call @pre(%4) : (i64) -> ()
    cf.br ^bb4
  ^bb4:  // pred: ^bb3
    %7 = llvm.mlir.constant(7 : index) : i64
    %8 = builtin.unrealized_conversion_cast %7 : i64 to index
    %9 = llvm.mlir.constant(56 : index) : i64
    cf.br ^bb5(%8 : index)
  ^bb5(%10: index):  // 2 preds: ^bb4, ^bb6
    %11 = builtin.unrealized_conversion_cast %10 : index to i64
    %12 = builtin.unrealized_conversion_cast %10 : index to i64
    %13 = llvm.icmp "slt" %12, %9 : i64
    cf.cond_br %13, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    llvm.call @body2(%4, %11) : (i64, i64) -> ()
    %14 = llvm.mlir.constant(2 : index) : i64
    %15 = llvm.add %12, %14 : i64
    %16 = builtin.unrealized_conversion_cast %15 : i64 to index
    cf.br ^bb5(%16 : index)
  ^bb7:  // pred: ^bb5
    llvm.call @mid(%4) : (i64) -> ()
    cf.br ^bb8
  ^bb8:  // pred: ^bb7
    %17 = llvm.mlir.constant(18 : index) : i64
    %18 = builtin.unrealized_conversion_cast %17 : i64 to index
    %19 = llvm.mlir.constant(37 : index) : i64
    cf.br ^bb9(%18 : index)
  ^bb9(%20: index):  // 2 preds: ^bb8, ^bb10
    %21 = builtin.unrealized_conversion_cast %20 : index to i64
    %22 = builtin.unrealized_conversion_cast %20 : index to i64
    %23 = llvm.icmp "slt" %22, %19 : i64
    cf.cond_br %23, ^bb10, ^bb11
  ^bb10:  // pred: ^bb9
    llvm.call @body3(%4, %21) : (i64, i64) -> ()
    %24 = llvm.mlir.constant(3 : index) : i64
    %25 = llvm.add %22, %24 : i64
    %26 = builtin.unrealized_conversion_cast %25 : i64 to index
    cf.br ^bb9(%26 : index)
  ^bb11:  // pred: ^bb9
    llvm.call @post(%4) : (i64) -> ()
    %27 = llvm.mlir.constant(1 : index) : i64
    %28 = llvm.add %5, %27 : i64
    %29 = builtin.unrealized_conversion_cast %28 : i64 to index
    cf.br ^bb2(%29 : index)
  ^bb12:  // pred: ^bb2
    llvm.return
  }
  llvm.func @get_i64() -> i64 attributes {sym_visibility = "private"}
  llvm.func @get_f32() -> f32 attributes {sym_visibility = "private"}
  llvm.func @get_c16() -> !llvm.struct<(f16, f16)> attributes {sym_visibility = "private"}
  llvm.func @get_c32() -> !llvm.struct<(f32, f32)> attributes {sym_visibility = "private"}
  llvm.func @get_c64() -> !llvm.struct<(f64, f64)> attributes {sym_visibility = "private"}
  llvm.func @get_memref() -> !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)> attributes {sym_visibility = "private"}
  llvm.func @multireturn() -> !llvm.struct<(i64, f32, struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>)> {
    %0 = llvm.call @get_i64() : () -> i64
    %1 = llvm.call @get_f32() : () -> f32
    %2 = llvm.call @get_memref() : () -> !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    %3 = llvm.mlir.poison : !llvm.struct<(i64, f32, struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>)>
    %4 = llvm.insertvalue %0, %3[0] : !llvm.struct<(i64, f32, struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(i64, f32, struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>)> 
    %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<(i64, f32, struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>)> 
    llvm.return %6 : !llvm.struct<(i64, f32, struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>)>
  }
  llvm.func @multireturn_caller() {
    %0 = llvm.call @multireturn() : () -> !llvm.struct<(i64, f32, struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(i64, f32, struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(i64, f32, struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>)> 
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(i64, f32, struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>)> 
    %4 = llvm.mlir.constant(42 : i64) : i64
    %5 = llvm.add %1, %4 : i64
    %6 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %7 = llvm.fadd %2, %6 : f32
    %8 = llvm.mlir.constant(0 : index) : i64
    llvm.return
  }
  llvm.func @dfs_block_order(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    cf.br ^bb2
  ^bb1:  // pred: ^bb2
    %1 = llvm.add %arg0, %0 : i32
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    cf.br ^bb1
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
    llvm.func @assert_test_function(%arg0: i1) {
      cf.assert %arg0, "Computer says no"
      llvm.return
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
    cf.switch %arg0 : i8, [
      default: ^bb1,
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
  llvm.func @index_arg(%arg0: i64) -> i64 {
    %0 = builtin.unrealized_conversion_cast %arg0 : i64 to index
    cf.br ^bb1(%0 : index)
  ^bb1(%1: index):  // pred: ^bb0
    %2 = builtin.unrealized_conversion_cast %1 : index to i64
    llvm.return %2 : i64
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

