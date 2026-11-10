"builtin.module"() ({
  "wasmssa.func"() <{functionType = (i32, i32) -> i32, sym_name = "div_i32_si"}> ({
  ^bb0(%arg10: !wasmssa<local ref to i32>, %arg11: !wasmssa<local ref to i32>):
    %15 = "wasmssa.local_get"(%arg10) : (!wasmssa<local ref to i32>) -> i32
    %16 = "wasmssa.local_get"(%arg11) : (!wasmssa<local ref to i32>) -> i32
    %17 = "wasmssa.div_si"(%15, %16) : (i32, i32) -> i32
    "wasmssa.return"(%17) : (i32) -> ()
  }) : () -> ()
  "wasmssa.func"() <{functionType = (i64, i64) -> i64, sym_name = "div_i64_si"}> ({
  ^bb0(%arg8: !wasmssa<local ref to i64>, %arg9: !wasmssa<local ref to i64>):
    %12 = "wasmssa.local_get"(%arg8) : (!wasmssa<local ref to i64>) -> i64
    %13 = "wasmssa.local_get"(%arg9) : (!wasmssa<local ref to i64>) -> i64
    %14 = "wasmssa.div_si"(%12, %13) : (i64, i64) -> i64
    "wasmssa.return"(%14) : (i64) -> ()
  }) : () -> ()
  "wasmssa.func"() <{functionType = (i32, i32) -> i32, sym_name = "div_i32_ui"}> ({
  ^bb0(%arg6: !wasmssa<local ref to i32>, %arg7: !wasmssa<local ref to i32>):
    %9 = "wasmssa.local_get"(%arg6) : (!wasmssa<local ref to i32>) -> i32
    %10 = "wasmssa.local_get"(%arg7) : (!wasmssa<local ref to i32>) -> i32
    %11 = "wasmssa.div_ui"(%9, %10) : (i32, i32) -> i32
    "wasmssa.return"(%11) : (i32) -> ()
  }) : () -> ()
  "wasmssa.func"() <{functionType = (i64, i64) -> i64, sym_name = "div_i64_ui"}> ({
  ^bb0(%arg4: !wasmssa<local ref to i64>, %arg5: !wasmssa<local ref to i64>):
    %6 = "wasmssa.local_get"(%arg4) : (!wasmssa<local ref to i64>) -> i64
    %7 = "wasmssa.local_get"(%arg5) : (!wasmssa<local ref to i64>) -> i64
    %8 = "wasmssa.div_ui"(%6, %7) : (i64, i64) -> i64
    "wasmssa.return"(%8) : (i64) -> ()
  }) : () -> ()
  "wasmssa.func"() <{functionType = (f32, f32) -> f32, sym_name = "div_f32"}> ({
  ^bb0(%arg2: !wasmssa<local ref to f32>, %arg3: !wasmssa<local ref to f32>):
    %3 = "wasmssa.local_get"(%arg2) : (!wasmssa<local ref to f32>) -> f32
    %4 = "wasmssa.local_get"(%arg3) : (!wasmssa<local ref to f32>) -> f32
    %5 = "wasmssa.div"(%3, %4) : (f32, f32) -> f32
    "wasmssa.return"(%5) : (f32) -> ()
  }) : () -> ()
  "wasmssa.func"() <{functionType = (f64, f64) -> f64, sym_name = "div_f64"}> ({
  ^bb0(%arg0: !wasmssa<local ref to f64>, %arg1: !wasmssa<local ref to f64>):
    %0 = "wasmssa.local_get"(%arg0) : (!wasmssa<local ref to f64>) -> f64
    %1 = "wasmssa.local_get"(%arg1) : (!wasmssa<local ref to f64>) -> f64
    %2 = "wasmssa.div"(%0, %1) : (f64, f64) -> f64
    "wasmssa.return"(%2) : (f64) -> ()
  }) : () -> ()
}) : () -> ()

