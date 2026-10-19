"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "empty"}> ({
    "memref.alloca_scope"() ({
      "memref.alloca_scope.return"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> (), sym_name = "returns_nothing"}> ({
  ^bb0(%arg2: f32):
    %8 = "arith.constant"() <{value = 1.000000e+01 : f32}> : () -> f32
    "memref.alloca_scope"() ({
      %9 = "arith.addf"(%8, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "memref.alloca_scope.return"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "returns_one_value"}> ({
  ^bb0(%arg1: f32):
    %5 = "arith.constant"() <{value = 1.000000e+01 : f32}> : () -> f32
    %6 = "memref.alloca_scope"() ({
      %7 = "arith.addf"(%5, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "memref.alloca_scope.return"(%7) : (f32) -> ()
    }) : () -> f32
    "func.return"(%6) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "returns_multiple_values"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.constant"() <{value = 1.000000e+01 : f32}> : () -> f32
    %1:2 = "memref.alloca_scope"() ({
      %3 = "arith.addf"(%0, %arg0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %4 = "arith.subf"(%0, %arg0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "memref.alloca_scope.return"(%3, %4) : (f32, f32) -> ()
    }) : () -> (f32, f32)
    %2 = "arith.addf"(%1#0, %1#1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

