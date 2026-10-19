module {
  llvm.func @complex_block_signature_conversion() {
    %cst = complex.constant [0.000000e+00, 0.000000e+00] : complex<f64>
    %0 = builtin.unrealized_conversion_cast %cst : complex<f64> to !llvm.struct<(f64, f64)>
    %true = arith.constant true
    llvm.cond_br %true, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%0 : !llvm.struct<(f64, f64)>)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : !llvm.struct<(f64, f64)>)
  ^bb3(%1: !llvm.struct<(f64, f64)>):  // 2 preds: ^bb1, ^bb2
    %2 = builtin.unrealized_conversion_cast %1 : !llvm.struct<(f64, f64)> to complex<f64>
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    "test.consumer_of_complex"(%2) : (complex<f64>) -> ()
    llvm.return
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_conversion_patterns to %0 {
        transform.apply_conversion_patterns.dialect_to_llvm "cf"
        transform.apply_conversion_patterns.func.func_to_llvm
        transform.apply_conversion_patterns.scf.scf_to_control_flow
      } with type_converter {
        transform.apply_conversion_patterns.memref.memref_to_llvm_type_converter
      } {legal_dialects = ["llvm"], partial_conversion} : !transform.any_op
      transform.yield 
    }
  }
}

