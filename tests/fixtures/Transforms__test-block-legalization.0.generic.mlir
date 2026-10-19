"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "complex_block_signature_conversion", visibility_ = 0 : i64}> ({
    %1 = "complex.constant"() <{value = [0.000000e+00, 0.000000e+00]}> : () -> complex<f64>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (complex<f64>) -> !llvm.struct<(f64, f64)>
    %3 = "arith.constant"() <{value = true}> : () -> i1
    "llvm.cond_br"(%3)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.br"(%2)[^bb3] : (!llvm.struct<(f64, f64)>) -> ()
  ^bb2:  // pred: ^bb0
    "llvm.br"(%2)[^bb3] : (!llvm.struct<(f64, f64)>) -> ()
  ^bb3(%4: !llvm.struct<(f64, f64)>):  // 2 preds: ^bb1, ^bb2
    %5 = "builtin.unrealized_conversion_cast"(%4) : (!llvm.struct<(f64, f64)>) -> complex<f64>
    "llvm.br"()[^bb4] : () -> ()
  ^bb4:  // pred: ^bb3
    "test.consumer_of_complex"(%5) : (complex<f64>) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_conversion_patterns"(%0) <{legal_dialects = ["llvm"], partial_conversion}> ({
        "transform.apply_conversion_patterns.dialect_to_llvm"() <{dialect_name = "cf"}> : () -> ()
        "transform.apply_conversion_patterns.func.func_to_llvm"() : () -> ()
        "transform.apply_conversion_patterns.scf.scf_to_control_flow"() : () -> ()
      }, {
        "transform.apply_conversion_patterns.memref.memref_to_llvm_type_converter"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

