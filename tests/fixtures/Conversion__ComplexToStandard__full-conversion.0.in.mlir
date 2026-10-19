"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> f32, sym_name = "complex_abs"}> ({
  ^bb0(%arg4: complex<f32>):
    %2 = "complex.abs"(%arg4) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> i1, sym_name = "complex_eq"}> ({
  ^bb0(%arg2: complex<f32>, %arg3: complex<f32>):
    %1 = "complex.eq"(%arg2, %arg3) : (complex<f32>, complex<f32>) -> i1
    "func.return"(%1) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> i1, sym_name = "complex_neq"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "complex.neq"(%arg0, %arg1) : (complex<f32>, complex<f32>) -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

