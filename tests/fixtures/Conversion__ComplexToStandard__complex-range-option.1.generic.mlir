"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_div"}> ({
  ^bb0(%arg2: complex<f32>, %arg3: complex<f32>):
    %16 = "complex.re"(%arg2) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %17 = "complex.im"(%arg2) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %18 = "complex.re"(%arg3) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %19 = "complex.im"(%arg3) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %20 = "arith.mulf"(%18, %18) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %21 = "arith.mulf"(%19, %19) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %22 = "arith.addf"(%20, %21) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %23 = "arith.mulf"(%16, %18) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %24 = "arith.mulf"(%17, %19) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %25 = "arith.addf"(%23, %24) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %26 = "arith.mulf"(%17, %18) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %27 = "arith.mulf"(%16, %19) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %28 = "arith.subf"(%26, %27) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %29 = "arith.divf"(%25, %22) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %30 = "arith.divf"(%28, %22) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %31 = "complex.create"(%29, %30) : (f32, f32) -> complex<f32>
    "func.return"(%31) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_div_with_fmf"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "complex.re"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %3 = "complex.im"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %4 = "arith.mulf"(%2, %2) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %5 = "arith.mulf"(%3, %3) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %6 = "arith.addf"(%4, %5) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %7 = "arith.mulf"(%0, %2) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %8 = "arith.mulf"(%1, %3) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %9 = "arith.addf"(%7, %8) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %10 = "arith.mulf"(%1, %2) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %11 = "arith.mulf"(%0, %3) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %12 = "arith.subf"(%10, %11) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %13 = "arith.divf"(%9, %6) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %14 = "arith.divf"(%12, %6) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %15 = "complex.create"(%13, %14) : (f32, f32) -> complex<f32>
    "func.return"(%15) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

