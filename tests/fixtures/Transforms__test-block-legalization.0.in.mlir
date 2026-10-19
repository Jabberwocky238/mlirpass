"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "complex_block_signature_conversion"}> ({
    %1 = "complex.constant"() <{value = [0.000000e+00, 0.000000e+00]}> : () -> complex<f64>
    %2 = "arith.constant"() <{value = true}> : () -> i1
    %3 = "scf.if"(%2) ({
      "scf.yield"(%1) : (complex<f64>) -> ()
    }, {
      "scf.yield"(%1) : (complex<f64>) -> ()
    }) : (i1) -> complex<f64>
    "test.consumer_of_complex"(%3) : (complex<f64>) -> ()
    "func.return"() : () -> ()
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

