"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "convert_i32_u_to_f32"}> ({
    %14 = "arith.constant"() <{value = 10 : i32}> : () -> i32
    %15 = "arith.uitofp"(%14) : (i32) -> f32
    "func.return"(%15) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "convert_i32_s_to_f32"}> ({
    %12 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    %13 = "arith.sitofp"(%12) : (i32) -> f32
    "func.return"(%13) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "convert_i64_u_to_f32"}> ({
    %10 = "arith.constant"() <{value = 17 : i64}> : () -> i64
    %11 = "arith.uitofp"(%10) : (i64) -> f32
    "func.return"(%11) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "convert_i64s_to_f32"}> ({
    %8 = "arith.constant"() <{value = 10 : i64}> : () -> i64
    %9 = "arith.sitofp"(%8) : (i64) -> f32
    "func.return"(%9) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f64, sym_name = "convert_i32_u_to_f64"}> ({
    %6 = "arith.constant"() <{value = 10 : i32}> : () -> i32
    %7 = "arith.uitofp"(%6) : (i32) -> f64
    "func.return"(%7) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f64, sym_name = "convert_i32_s_to_f64"}> ({
    %4 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    %5 = "arith.sitofp"(%4) : (i32) -> f64
    "func.return"(%5) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f64, sym_name = "convert_i64_u_to_f64"}> ({
    %2 = "arith.constant"() <{value = 17 : i64}> : () -> i64
    %3 = "arith.uitofp"(%2) : (i64) -> f64
    "func.return"(%3) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f64, sym_name = "convert_i64s_to_f64"}> ({
    %0 = "arith.constant"() <{value = 10 : i64}> : () -> i64
    %1 = "arith.sitofp"(%0) : (i64) -> f64
    "func.return"(%1) : (f64) -> ()
  }) : () -> ()
}) : () -> ()

