"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> complex<f32>, sym_name = "complex_create"}> ({
  ^bb0(%arg11: f32, %arg12: f32):
    %168 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f32)>
    %169 = "llvm.insertvalue"(%168, %arg11) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    %170 = "llvm.insertvalue"(%169, %arg12) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    %171 = "builtin.unrealized_conversion_cast"(%170) : (!llvm.struct<(f32, f32)>) -> complex<f32>
    "func.return"(%171) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f64>, sym_name = "complex_constant"}> ({
    %166 = "llvm.mlir.constant"() <{value = [1.000000e+00, 2.000000e+00]}> : () -> !llvm.struct<(f64, f64)>
    %167 = "builtin.unrealized_conversion_cast"(%166) : (!llvm.struct<(f64, f64)>) -> complex<f64>
    "func.return"(%167) : (complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> (), sym_name = "complex_extract"}> ({
  ^bb0(%arg10: complex<f32>):
    %163 = "builtin.unrealized_conversion_cast"(%arg10) : (complex<f32>) -> !llvm.struct<(f32, f32)>
    %164 = "llvm.extractvalue"(%163) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %165 = "llvm.extractvalue"(%163) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "complex_addition"}> ({
    %144 = "arith.constant"() <{value = 1.200000e+00 : f64}> : () -> f64
    %145 = "arith.constant"() <{value = 3.400000e+00 : f64}> : () -> f64
    %146 = "llvm.mlir.poison"() : () -> !llvm.struct<(f64, f64)>
    %147 = "llvm.insertvalue"(%146, %144) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %148 = "llvm.insertvalue"(%147, %145) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %149 = "arith.constant"() <{value = 5.600000e+00 : f64}> : () -> f64
    %150 = "arith.constant"() <{value = 7.7999999999999998 : f64}> : () -> f64
    %151 = "llvm.mlir.poison"() : () -> !llvm.struct<(f64, f64)>
    %152 = "llvm.insertvalue"(%151, %149) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %153 = "llvm.insertvalue"(%152, %150) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %154 = "llvm.extractvalue"(%148) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>) -> f64
    %155 = "llvm.extractvalue"(%148) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>) -> f64
    %156 = "llvm.extractvalue"(%153) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>) -> f64
    %157 = "llvm.extractvalue"(%153) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>) -> f64
    %158 = "llvm.mlir.poison"() : () -> !llvm.struct<(f64, f64)>
    %159 = "llvm.fadd"(%154, %156) <{fastmathFlags = #llvm.fastmath<none>}> : (f64, f64) -> f64
    %160 = "llvm.fadd"(%155, %157) <{fastmathFlags = #llvm.fastmath<none>}> : (f64, f64) -> f64
    %161 = "llvm.insertvalue"(%158, %159) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %162 = "llvm.insertvalue"(%161, %160) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "complex_substraction"}> ({
    %125 = "arith.constant"() <{value = 1.200000e+00 : f64}> : () -> f64
    %126 = "arith.constant"() <{value = 3.400000e+00 : f64}> : () -> f64
    %127 = "llvm.mlir.poison"() : () -> !llvm.struct<(f64, f64)>
    %128 = "llvm.insertvalue"(%127, %125) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %129 = "llvm.insertvalue"(%128, %126) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %130 = "arith.constant"() <{value = 5.600000e+00 : f64}> : () -> f64
    %131 = "arith.constant"() <{value = 7.7999999999999998 : f64}> : () -> f64
    %132 = "llvm.mlir.poison"() : () -> !llvm.struct<(f64, f64)>
    %133 = "llvm.insertvalue"(%132, %130) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %134 = "llvm.insertvalue"(%133, %131) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %135 = "llvm.extractvalue"(%129) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>) -> f64
    %136 = "llvm.extractvalue"(%129) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>) -> f64
    %137 = "llvm.extractvalue"(%134) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>) -> f64
    %138 = "llvm.extractvalue"(%134) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>) -> f64
    %139 = "llvm.mlir.poison"() : () -> !llvm.struct<(f64, f64)>
    %140 = "llvm.fsub"(%135, %137) <{fastmathFlags = #llvm.fastmath<none>}> : (f64, f64) -> f64
    %141 = "llvm.fsub"(%136, %138) <{fastmathFlags = #llvm.fastmath<none>}> : (f64, f64) -> f64
    %142 = "llvm.insertvalue"(%139, %140) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %143 = "llvm.insertvalue"(%142, %141) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_div"}> ({
  ^bb0(%arg8: complex<f32>, %arg9: complex<f32>):
    %104 = "builtin.unrealized_conversion_cast"(%arg9) : (complex<f32>) -> !llvm.struct<(f32, f32)>
    %105 = "builtin.unrealized_conversion_cast"(%arg8) : (complex<f32>) -> !llvm.struct<(f32, f32)>
    %106 = "llvm.extractvalue"(%105) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %107 = "llvm.extractvalue"(%105) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %108 = "llvm.extractvalue"(%104) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %109 = "llvm.extractvalue"(%104) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %110 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f32)>
    %111 = "llvm.fmul"(%108, %108) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %112 = "llvm.fmul"(%109, %109) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %113 = "llvm.fadd"(%111, %112) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %114 = "llvm.fmul"(%106, %108) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %115 = "llvm.fmul"(%107, %109) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %116 = "llvm.fadd"(%114, %115) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %117 = "llvm.fmul"(%107, %108) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %118 = "llvm.fmul"(%106, %109) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %119 = "llvm.fsub"(%117, %118) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %120 = "llvm.fdiv"(%116, %113) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %121 = "llvm.fdiv"(%119, %113) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %122 = "llvm.insertvalue"(%110, %120) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    %123 = "llvm.insertvalue"(%122, %121) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    %124 = "builtin.unrealized_conversion_cast"(%123) : (!llvm.struct<(f32, f32)>) -> complex<f32>
    "func.return"(%124) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_mul"}> ({
  ^bb0(%arg6: complex<f32>, %arg7: complex<f32>):
    %88 = "builtin.unrealized_conversion_cast"(%arg7) : (complex<f32>) -> !llvm.struct<(f32, f32)>
    %89 = "builtin.unrealized_conversion_cast"(%arg6) : (complex<f32>) -> !llvm.struct<(f32, f32)>
    %90 = "llvm.extractvalue"(%89) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %91 = "llvm.extractvalue"(%89) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %92 = "llvm.extractvalue"(%88) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %93 = "llvm.extractvalue"(%88) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %94 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f32)>
    %95 = "llvm.fmul"(%92, %90) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %96 = "llvm.fmul"(%93, %91) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %97 = "llvm.fmul"(%91, %92) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %98 = "llvm.fmul"(%90, %93) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %99 = "llvm.fsub"(%95, %96) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %100 = "llvm.fadd"(%97, %98) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %101 = "llvm.insertvalue"(%94, %99) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    %102 = "llvm.insertvalue"(%101, %100) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    %103 = "builtin.unrealized_conversion_cast"(%102) : (!llvm.struct<(f32, f32)>) -> complex<f32>
    "func.return"(%103) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> f32, sym_name = "complex_abs"}> ({
  ^bb0(%arg5: complex<f32>):
    %81 = "builtin.unrealized_conversion_cast"(%arg5) : (complex<f32>) -> !llvm.struct<(f32, f32)>
    %82 = "llvm.extractvalue"(%81) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %83 = "llvm.extractvalue"(%81) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %84 = "llvm.fmul"(%82, %82) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %85 = "llvm.fmul"(%83, %83) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %86 = "llvm.fadd"(%84, %85) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %87 = "llvm.intr.sqrt"(%86) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    "func.return"(%87) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "complex_addition_with_fmf"}> ({
    %62 = "arith.constant"() <{value = 1.200000e+00 : f64}> : () -> f64
    %63 = "arith.constant"() <{value = 3.400000e+00 : f64}> : () -> f64
    %64 = "llvm.mlir.poison"() : () -> !llvm.struct<(f64, f64)>
    %65 = "llvm.insertvalue"(%64, %62) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %66 = "llvm.insertvalue"(%65, %63) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %67 = "arith.constant"() <{value = 5.600000e+00 : f64}> : () -> f64
    %68 = "arith.constant"() <{value = 7.7999999999999998 : f64}> : () -> f64
    %69 = "llvm.mlir.poison"() : () -> !llvm.struct<(f64, f64)>
    %70 = "llvm.insertvalue"(%69, %67) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %71 = "llvm.insertvalue"(%70, %68) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %72 = "llvm.extractvalue"(%66) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>) -> f64
    %73 = "llvm.extractvalue"(%66) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>) -> f64
    %74 = "llvm.extractvalue"(%71) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>) -> f64
    %75 = "llvm.extractvalue"(%71) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>) -> f64
    %76 = "llvm.mlir.poison"() : () -> !llvm.struct<(f64, f64)>
    %77 = "llvm.fadd"(%72, %74) <{fastmathFlags = #llvm.fastmath<reassoc>}> : (f64, f64) -> f64
    %78 = "llvm.fadd"(%73, %75) <{fastmathFlags = #llvm.fastmath<reassoc>}> : (f64, f64) -> f64
    %79 = "llvm.insertvalue"(%76, %77) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %80 = "llvm.insertvalue"(%79, %78) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "complex_substraction_with_fmf"}> ({
    %43 = "arith.constant"() <{value = 1.200000e+00 : f64}> : () -> f64
    %44 = "arith.constant"() <{value = 3.400000e+00 : f64}> : () -> f64
    %45 = "llvm.mlir.poison"() : () -> !llvm.struct<(f64, f64)>
    %46 = "llvm.insertvalue"(%45, %43) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %47 = "llvm.insertvalue"(%46, %44) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %48 = "arith.constant"() <{value = 5.600000e+00 : f64}> : () -> f64
    %49 = "arith.constant"() <{value = 7.7999999999999998 : f64}> : () -> f64
    %50 = "llvm.mlir.poison"() : () -> !llvm.struct<(f64, f64)>
    %51 = "llvm.insertvalue"(%50, %48) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %52 = "llvm.insertvalue"(%51, %49) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %53 = "llvm.extractvalue"(%47) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>) -> f64
    %54 = "llvm.extractvalue"(%47) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>) -> f64
    %55 = "llvm.extractvalue"(%52) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>) -> f64
    %56 = "llvm.extractvalue"(%52) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>) -> f64
    %57 = "llvm.mlir.poison"() : () -> !llvm.struct<(f64, f64)>
    %58 = "llvm.fsub"(%53, %55) <{fastmathFlags = #llvm.fastmath<nnan, ninf>}> : (f64, f64) -> f64
    %59 = "llvm.fsub"(%54, %56) <{fastmathFlags = #llvm.fastmath<nnan, ninf>}> : (f64, f64) -> f64
    %60 = "llvm.insertvalue"(%57, %58) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %61 = "llvm.insertvalue"(%60, %59) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_div_with_fmf"}> ({
  ^bb0(%arg3: complex<f32>, %arg4: complex<f32>):
    %22 = "builtin.unrealized_conversion_cast"(%arg4) : (complex<f32>) -> !llvm.struct<(f32, f32)>
    %23 = "builtin.unrealized_conversion_cast"(%arg3) : (complex<f32>) -> !llvm.struct<(f32, f32)>
    %24 = "llvm.extractvalue"(%23) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %25 = "llvm.extractvalue"(%23) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %26 = "llvm.extractvalue"(%22) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %27 = "llvm.extractvalue"(%22) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %28 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f32)>
    %29 = "llvm.fmul"(%26, %26) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %30 = "llvm.fmul"(%27, %27) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %31 = "llvm.fadd"(%29, %30) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %32 = "llvm.fmul"(%24, %26) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %33 = "llvm.fmul"(%25, %27) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %34 = "llvm.fadd"(%32, %33) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %35 = "llvm.fmul"(%25, %26) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %36 = "llvm.fmul"(%24, %27) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %37 = "llvm.fsub"(%35, %36) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %38 = "llvm.fdiv"(%34, %31) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %39 = "llvm.fdiv"(%37, %31) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %40 = "llvm.insertvalue"(%28, %38) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    %41 = "llvm.insertvalue"(%40, %39) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    %42 = "builtin.unrealized_conversion_cast"(%41) : (!llvm.struct<(f32, f32)>) -> complex<f32>
    "func.return"(%42) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_mul_with_fmf"}> ({
  ^bb0(%arg1: complex<f32>, %arg2: complex<f32>):
    %7 = "builtin.unrealized_conversion_cast"(%arg2) : (complex<f32>) -> !llvm.struct<(f32, f32)>
    %8 = "builtin.unrealized_conversion_cast"(%arg1) : (complex<f32>) -> !llvm.struct<(f32, f32)>
    %9 = "llvm.extractvalue"(%8) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %10 = "llvm.extractvalue"(%8) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %11 = "llvm.extractvalue"(%7) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %12 = "llvm.extractvalue"(%7) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %13 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f32)>
    %14 = "llvm.fmul"(%10, %12) <{fastmathFlags = #llvm.fastmath<contract, afn>}> : (f32, f32) -> f32
    %15 = "llvm.fneg"(%14) <{fastmathFlags = #llvm.fastmath<contract, afn>}> : (f32) -> f32
    %16 = "llvm.intr.fma"(%9, %11, %15) <{fastmathFlags = #llvm.fastmath<contract, afn>}> : (f32, f32, f32) -> f32
    %17 = "llvm.fmul"(%10, %11) <{fastmathFlags = #llvm.fastmath<contract, afn>}> : (f32, f32) -> f32
    %18 = "llvm.intr.fma"(%9, %12, %17) <{fastmathFlags = #llvm.fastmath<contract, afn>}> : (f32, f32, f32) -> f32
    %19 = "llvm.insertvalue"(%13, %16) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    %20 = "llvm.insertvalue"(%19, %18) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    %21 = "builtin.unrealized_conversion_cast"(%20) : (!llvm.struct<(f32, f32)>) -> complex<f32>
    "func.return"(%21) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> f32, sym_name = "complex_abs_with_fmf"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (complex<f32>) -> !llvm.struct<(f32, f32)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %3 = "llvm.fmul"(%1, %1) <{fastmathFlags = #llvm.fastmath<contract>}> : (f32, f32) -> f32
    %4 = "llvm.fmul"(%2, %2) <{fastmathFlags = #llvm.fastmath<contract>}> : (f32, f32) -> f32
    %5 = "llvm.fadd"(%3, %4) <{fastmathFlags = #llvm.fastmath<contract>}> : (f32, f32) -> f32
    %6 = "llvm.intr.sqrt"(%5) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    "func.return"(%6) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

