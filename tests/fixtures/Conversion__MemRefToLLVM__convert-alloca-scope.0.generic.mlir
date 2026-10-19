"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "empty"}> ({
    %14 = "llvm.intr.stacksave"() : () -> !llvm.ptr
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    "llvm.intr.stackrestore"(%14) : (!llvm.ptr) -> ()
    "llvm.br"()[^bb2] : () -> ()
  ^bb2:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> (), sym_name = "returns_nothing"}> ({
  ^bb0(%arg2: f32):
    %11 = "arith.constant"() <{value = 1.000000e+01 : f32}> : () -> f32
    %12 = "llvm.intr.stacksave"() : () -> !llvm.ptr
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %13 = "arith.addf"(%arg2, %11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "llvm.intr.stackrestore"(%12) : (!llvm.ptr) -> ()
    "llvm.br"()[^bb2] : () -> ()
  ^bb2:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "returns_one_value"}> ({
  ^bb0(%arg1: f32):
    %7 = "arith.constant"() <{value = 1.000000e+01 : f32}> : () -> f32
    %8 = "llvm.intr.stacksave"() : () -> !llvm.ptr
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %9 = "arith.addf"(%arg1, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "llvm.intr.stackrestore"(%8) : (!llvm.ptr) -> ()
    "llvm.br"(%9)[^bb2] : (f32) -> ()
  ^bb2(%10: f32):  // pred: ^bb1
    "llvm.br"()[^bb3] : () -> ()
  ^bb3:  // pred: ^bb2
    "func.return"(%10) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "returns_multiple_values"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.constant"() <{value = 1.000000e+01 : f32}> : () -> f32
    %1 = "llvm.intr.stacksave"() : () -> !llvm.ptr
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %2 = "arith.addf"(%arg0, %0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %3 = "arith.subf"(%0, %arg0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "llvm.intr.stackrestore"(%1) : (!llvm.ptr) -> ()
    "llvm.br"(%2, %3)[^bb2] : (f32, f32) -> ()
  ^bb2(%4: f32, %5: f32):  // pred: ^bb1
    "llvm.br"()[^bb3] : () -> ()
  ^bb3:  // pred: ^bb2
    %6 = "arith.addf"(%4, %5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%6) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

