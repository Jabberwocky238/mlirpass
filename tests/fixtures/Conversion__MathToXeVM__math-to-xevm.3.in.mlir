"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = () -> (), sym_name = "math_ops"}> ({
    %6 = "arith.constant"() <{value = 1.000000e+00 : f16}> : () -> f16
    %7 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %8 = "arith.constant"() <{value = 1.000000e+00 : f64}> : () -> f64
    %9 = "math.exp"(%6) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %10 = "math.exp"(%7) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %11 = "math.exp"(%8) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    %12 = "math.exp"(%6) <{fastmath = #arith.fastmath<fast>}> : (f16) -> f16
    %13 = "math.exp"(%7) <{fastmath = #arith.fastmath<fast>}> : (f32) -> f32
    %14 = "math.exp"(%8) <{fastmath = #arith.fastmath<fast>}> : (f64) -> f64
    %15 = "math.exp"(%6) <{fastmath = #arith.fastmath<afn>}> : (f16) -> f16
    %16 = "math.exp"(%7) <{fastmath = #arith.fastmath<afn>}> : (f32) -> f32
    %17 = "math.exp"(%8) <{fastmath = #arith.fastmath<afn>}> : (f64) -> f64
    %18 = "math.exp"(%6) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %19 = "math.exp"(%7) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %20 = "math.exp"(%8) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    %21 = "arith.constant"() <{value = dense<1.000000e+00> : vector<2xf64>}> : () -> vector<2xf64>
    %22 = "arith.constant"() <{value = dense<1.000000e+00> : vector<3xf64>}> : () -> vector<3xf64>
    %23 = "arith.constant"() <{value = dense<1.000000e+00> : vector<4xf64>}> : () -> vector<4xf64>
    %24 = "arith.constant"() <{value = dense<1.000000e+00> : vector<8xf64>}> : () -> vector<8xf64>
    %25 = "arith.constant"() <{value = dense<1.000000e+00> : vector<16xf64>}> : () -> vector<16xf64>
    %26 = "math.exp"(%21) <{fastmath = #arith.fastmath<afn>}> : (vector<2xf64>) -> vector<2xf64>
    %27 = "math.exp"(%22) <{fastmath = #arith.fastmath<afn>}> : (vector<3xf64>) -> vector<3xf64>
    %28 = "math.exp"(%23) <{fastmath = #arith.fastmath<afn>}> : (vector<4xf64>) -> vector<4xf64>
    %29 = "math.exp"(%24) <{fastmath = #arith.fastmath<afn>}> : (vector<8xf64>) -> vector<8xf64>
    %30 = "math.exp"(%25) <{fastmath = #arith.fastmath<afn>}> : (vector<16xf64>) -> vector<16xf64>
    %31 = "arith.constant"() <{value = dense<1.000000e+00> : vector<16xf32>}> : () -> vector<16xf32>
    %32 = "arith.constant"() <{value = dense<1.000000e+00> : vector<4xf16>}> : () -> vector<4xf16>
    %33 = "math.exp"(%31) <{fastmath = #arith.fastmath<fast>}> : (vector<16xf32>) -> vector<16xf32>
    %34 = "math.exp"(%32) <{fastmath = #arith.fastmath<fast>}> : (vector<4xf16>) -> vector<4xf16>
    %35 = "arith.constant"() <{value = dense<1.000000e+00> : vector<5xf64>}> : () -> vector<5xf64>
    %36 = "arith.constant"() <{value = dense<1.000000e+00> : vector<32xf64>}> : () -> vector<32xf64>
    %37 = "math.exp"(%35) <{fastmath = #arith.fastmath<afn>}> : (vector<5xf64>) -> vector<5xf64>
    %38 = "math.exp"(%36) <{fastmath = #arith.fastmath<afn>}> : (vector<32xf64>) -> vector<32xf64>
    %39 = "math.exp"(%6) <{fastmath = #arith.fastmath<fast>}> : (f16) -> f16
    %40 = "math.exp"(%7) <{fastmath = #arith.fastmath<nnan,ninf,nsz,arcp,contract,afn>}> : (f32) -> f32
    %41 = "math.exp"(%7) <{fastmath = #arith.fastmath<reassoc,nnan,afn>}> : (f32) -> f32
    %42 = "math.cos"(%6) <{fastmath = #arith.fastmath<afn>}> : (f16) -> f16
    %43 = "math.exp2"(%7) <{fastmath = #arith.fastmath<afn>}> : (f32) -> f32
    %44 = "math.log"(%6) <{fastmath = #arith.fastmath<afn>}> : (f16) -> f16
    %45 = "math.log2"(%7) <{fastmath = #arith.fastmath<afn>}> : (f32) -> f32
    %46 = "math.log10"(%8) <{fastmath = #arith.fastmath<afn>}> : (f64) -> f64
    %47 = "math.powf"(%6, %6) <{fastmath = #arith.fastmath<afn>}> : (f16, f16) -> f16
    %48 = "math.rsqrt"(%8) <{fastmath = #arith.fastmath<afn>}> : (f64) -> f64
    %49 = "math.sin"(%6) <{fastmath = #arith.fastmath<afn>}> : (f16) -> f16
    %50 = "math.sqrt"(%7) <{fastmath = #arith.fastmath<afn>}> : (f32) -> f32
    %51 = "math.tan"(%8) <{fastmath = #arith.fastmath<afn>}> : (f64) -> f64
    %52 = "arith.constant"() <{value = 6.900000e+00 : f32}> : () -> f32
    %53 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %54 = "arith.divf"(%52, %53) <{fastmath = #arith.fastmath<afn>}> : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_gpu"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %3 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %4 = "math.exp"(%3) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %5 = "math.exp"(%3) <{fastmath = #arith.fastmath<afn>}> : (f32) -> f32
      "gpu.return"() : () -> ()
    }) {sym_name = "exp_gpu", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "exp_func"}> ({
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "math.exp"(%0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %2 = "math.exp"(%0) <{fastmath = #arith.fastmath<afn>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

