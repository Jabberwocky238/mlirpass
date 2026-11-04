"builtin.module"() ({
^bb0:
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "shape_assuming"}> ({
    %0 = "shape.const_witness"() <{passing = true}> : () -> !shape.witness
    %1 = "shape.assuming"(%0) ({
      %3 = "test.source"() : () -> tensor<2xf16>
      %4 = "bufferization.to_buffer"(%3) : (tensor<2xf16>) -> memref<2xf16>
      "shape.assuming_yield"(%4) : (memref<2xf16>) -> ()
    }) : (!shape.witness) -> memref<2xf16>
    %2 = "bufferization.to_tensor"(%1) : (memref<2xf16>) -> tensor<2xf16>
    "test.sink"(%2) : (tensor<2xf16>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

