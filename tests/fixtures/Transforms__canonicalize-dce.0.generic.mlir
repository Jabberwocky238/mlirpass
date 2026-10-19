"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "f"}> ({
  ^bb0(%arg0: f32):
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "f"}> ({
  ^bb0(%arg0: f32):
    "test.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "f"}> ({
  ^bb0(%arg0: f32):
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb1
    "cf.br"()[^bb1] : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "f"}> ({
  ^bb0(%arg0: f32):
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb1
    "cf.br"()[^bb1] : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, i1) -> (), sym_name = "f"}> ({
  ^bb0(%arg0: f32, %arg1: i1):
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "f"}> ({
  ^bb0(%arg0: f32):
    "test.region"() ({
    ^bb0:
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> f32, sym_name = "f"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.addf"(%arg0, %arg0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "f"}> ({
  ^bb0(%arg0: f32):
    "foo.print"(%arg0) : (f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "f"}> ({
  ^bb0(%arg0: f32):
    "foo.has_region"() ({
      "foo.return"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xf32>, tensor<2xf32>, tensor<3xf32>, tensor<4xf32>, tensor<5xf32>) -> (), sym_name = "f"}> ({
  ^bb0(%arg0: tensor<1xf32>, %arg1: tensor<2xf32>, %arg2: tensor<3xf32>, %arg3: tensor<4xf32>, %arg4: tensor<5xf32>):
    "test.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    "foo.print"(%arg1) : (tensor<2xf32>) -> ()
    "foo.print"(%arg3) : (tensor<4xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "f"}> ({
    "test.graph_region"() ({
      "test.terminator"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "f"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

