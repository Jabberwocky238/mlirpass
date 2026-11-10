"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "i32.reinterpret_f32"}> ({
    %6 = "arith.constant"() <{value = -1.000000e+00 : f32}> : () -> f32
    %7 = "arith.bitcast"(%6) : (f32) -> i32
    "func.return"(%7) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "i64.reinterpret_f64"}> ({
    %4 = "arith.constant"() <{value = -1.000000e+00 : f64}> : () -> f64
    %5 = "arith.bitcast"(%4) : (f64) -> i64
    "func.return"(%5) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "f32.reinterpret_i32"}> ({
    %2 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %3 = "arith.bitcast"(%2) : (i32) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f64, sym_name = "f64.reinterpret_i64"}> ({
    %0 = "arith.constant"() <{value = -1 : i64}> : () -> i64
    %1 = "arith.bitcast"(%0) : (i64) -> f64
    "func.return"(%1) : (f64) -> ()
  }) : () -> ()
}) : () -> ()

