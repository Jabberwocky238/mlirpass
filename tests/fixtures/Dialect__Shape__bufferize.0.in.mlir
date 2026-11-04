"builtin.module"() ({
^bb0:
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "shape_assuming"}> ({
    %0 = "shape.const_witness"() <{passing = true}> : () -> !shape.witness
    %1 = "shape.assuming"(%0) ({
      %2 = "test.source"() : () -> tensor<2xf16>
      "shape.assuming_yield"(%2) : (tensor<2xf16>) -> ()
    }) : (!shape.witness) -> tensor<2xf16>
    "test.sink"(%1) : (tensor<2xf16>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

