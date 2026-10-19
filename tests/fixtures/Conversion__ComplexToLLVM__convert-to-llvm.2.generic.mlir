"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> complex<f32>, sym_name = "complex_create"}> ({
  ^bb0(%arg11: f32, %arg12: f32):
    %170 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f32)>
    %171 = "llvm.insertvalue"(%170, %arg11) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    %172 = "llvm.insertvalue"(%171, %arg12) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    %173 = "builtin.unrealized_conversion_cast"(%172) : (!llvm.struct<(f32, f32)>) -> complex<f32>
    "func.return"(%173) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f64>, sym_name = "complex_constant"}> ({
    %168 = "llvm.mlir.constant"() <{value = [1.000000e+00, 2.000000e+00]}> : () -> !llvm.struct<(f64, f64)>
    %169 = "builtin.unrealized_conversion_cast"(%168) : (!llvm.struct<(f64, f64)>) -> complex<f64>
    "func.return"(%169) : (complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> (), sym_name = "complex_extract"}> ({
  ^bb0(%arg10: complex<f32>):
    %164 = "builtin.unrealized_conversion_cast"(%arg10) : (complex<f32>) -> !llvm.struct<(f32, f32)>
    %165 = "builtin.unrealized_conversion_cast"(%arg10) : (complex<f32>) -> !llvm.struct<(f32, f32)>
    %166 = "llvm.extractvalue"(%165) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %167 = "llvm.extractvalue"(%164) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "complex_addition"}> ({
    %145 = "arith.constant"() <{value = 1.200000e+00 : f64}> : () -> f64
    %146 = "arith.constant"() <{value = 3.400000e+00 : f64}> : () -> f64
    %147 = "llvm.mlir.poison"() : () -> !llvm.struct<(f64, f64)>
    %148 = "llvm.insertvalue"(%147, %145) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %149 = "llvm.insertvalue"(%148, %146) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %150 = "arith.constant"() <{value = 5.600000e+00 : f64}> : () -> f64
    %151 = "arith.constant"() <{value = 7.7999999999999998 : f64}> : () -> f64
    %152 = "llvm.mlir.poison"() : () -> !llvm.struct<(f64, f64)>
    %153 = "llvm.insertvalue"(%152, %150) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %154 = "llvm.insertvalue"(%153, %151) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %155 = "llvm.extractvalue"(%149) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>) -> f64
    %156 = "llvm.extractvalue"(%149) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>) -> f64
    %157 = "llvm.extractvalue"(%154) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>) -> f64
    %158 = "llvm.extractvalue"(%154) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>) -> f64
    %159 = "llvm.mlir.poison"() : () -> !llvm.struct<(f64, f64)>
    %160 = "llvm.fadd"(%155, %157) <{fastmathFlags = #llvm.fastmath<none>}> : (f64, f64) -> f64
    %161 = "llvm.fadd"(%156, %158) <{fastmathFlags = #llvm.fastmath<none>}> : (f64, f64) -> f64
    %162 = "llvm.insertvalue"(%159, %160) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %163 = "llvm.insertvalue"(%162, %161) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "complex_substraction"}> ({
    %126 = "arith.constant"() <{value = 1.200000e+00 : f64}> : () -> f64
    %127 = "arith.constant"() <{value = 3.400000e+00 : f64}> : () -> f64
    %128 = "llvm.mlir.poison"() : () -> !llvm.struct<(f64, f64)>
    %129 = "llvm.insertvalue"(%128, %126) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %130 = "llvm.insertvalue"(%129, %127) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %131 = "arith.constant"() <{value = 5.600000e+00 : f64}> : () -> f64
    %132 = "arith.constant"() <{value = 7.7999999999999998 : f64}> : () -> f64
    %133 = "llvm.mlir.poison"() : () -> !llvm.struct<(f64, f64)>
    %134 = "llvm.insertvalue"(%133, %131) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %135 = "llvm.insertvalue"(%134, %132) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %136 = "llvm.extractvalue"(%130) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>) -> f64
    %137 = "llvm.extractvalue"(%130) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>) -> f64
    %138 = "llvm.extractvalue"(%135) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>) -> f64
    %139 = "llvm.extractvalue"(%135) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>) -> f64
    %140 = "llvm.mlir.poison"() : () -> !llvm.struct<(f64, f64)>
    %141 = "llvm.fsub"(%136, %138) <{fastmathFlags = #llvm.fastmath<none>}> : (f64, f64) -> f64
    %142 = "llvm.fsub"(%137, %139) <{fastmathFlags = #llvm.fastmath<none>}> : (f64, f64) -> f64
    %143 = "llvm.insertvalue"(%140, %141) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %144 = "llvm.insertvalue"(%143, %142) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_div"}> ({
  ^bb0(%arg8: complex<f32>, %arg9: complex<f32>):
    %105 = "builtin.unrealized_conversion_cast"(%arg9) : (complex<f32>) -> !llvm.struct<(f32, f32)>
    %106 = "builtin.unrealized_conversion_cast"(%arg8) : (complex<f32>) -> !llvm.struct<(f32, f32)>
    %107 = "llvm.extractvalue"(%106) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %108 = "llvm.extractvalue"(%106) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %109 = "llvm.extractvalue"(%105) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %110 = "llvm.extractvalue"(%105) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %111 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f32)>
    %112 = "llvm.fmul"(%109, %109) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %113 = "llvm.fmul"(%110, %110) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %114 = "llvm.fadd"(%112, %113) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %115 = "llvm.fmul"(%107, %109) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %116 = "llvm.fmul"(%108, %110) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %117 = "llvm.fadd"(%115, %116) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %118 = "llvm.fmul"(%108, %109) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %119 = "llvm.fmul"(%107, %110) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %120 = "llvm.fsub"(%118, %119) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %121 = "llvm.fdiv"(%117, %114) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %122 = "llvm.fdiv"(%120, %114) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %123 = "llvm.insertvalue"(%111, %121) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    %124 = "llvm.insertvalue"(%123, %122) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    %125 = "builtin.unrealized_conversion_cast"(%124) : (!llvm.struct<(f32, f32)>) -> complex<f32>
    "func.return"(%125) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_mul"}> ({
  ^bb0(%arg6: complex<f32>, %arg7: complex<f32>):
    %89 = "builtin.unrealized_conversion_cast"(%arg7) : (complex<f32>) -> !llvm.struct<(f32, f32)>
    %90 = "builtin.unrealized_conversion_cast"(%arg6) : (complex<f32>) -> !llvm.struct<(f32, f32)>
    %91 = "llvm.extractvalue"(%90) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %92 = "llvm.extractvalue"(%90) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %93 = "llvm.extractvalue"(%89) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %94 = "llvm.extractvalue"(%89) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %95 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f32)>
    %96 = "llvm.fmul"(%93, %91) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %97 = "llvm.fmul"(%94, %92) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %98 = "llvm.fsub"(%96, %97) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %99 = "llvm.fmul"(%92, %93) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %100 = "llvm.fmul"(%91, %94) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %101 = "llvm.fadd"(%99, %100) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %102 = "llvm.insertvalue"(%95, %98) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    %103 = "llvm.insertvalue"(%102, %101) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    %104 = "builtin.unrealized_conversion_cast"(%103) : (!llvm.struct<(f32, f32)>) -> complex<f32>
    "func.return"(%104) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> f32, sym_name = "complex_abs"}> ({
  ^bb0(%arg5: complex<f32>):
    %82 = "builtin.unrealized_conversion_cast"(%arg5) : (complex<f32>) -> !llvm.struct<(f32, f32)>
    %83 = "llvm.extractvalue"(%82) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %84 = "llvm.extractvalue"(%82) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %85 = "llvm.fmul"(%83, %83) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %86 = "llvm.fmul"(%84, %84) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %87 = "llvm.fadd"(%85, %86) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %88 = "llvm.intr.sqrt"(%87) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    "func.return"(%88) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "complex_addition_with_fmf"}> ({
    %63 = "arith.constant"() <{value = 1.200000e+00 : f64}> : () -> f64
    %64 = "arith.constant"() <{value = 3.400000e+00 : f64}> : () -> f64
    %65 = "llvm.mlir.poison"() : () -> !llvm.struct<(f64, f64)>
    %66 = "llvm.insertvalue"(%65, %63) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %67 = "llvm.insertvalue"(%66, %64) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %68 = "arith.constant"() <{value = 5.600000e+00 : f64}> : () -> f64
    %69 = "arith.constant"() <{value = 7.7999999999999998 : f64}> : () -> f64
    %70 = "llvm.mlir.poison"() : () -> !llvm.struct<(f64, f64)>
    %71 = "llvm.insertvalue"(%70, %68) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %72 = "llvm.insertvalue"(%71, %69) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %73 = "llvm.extractvalue"(%67) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>) -> f64
    %74 = "llvm.extractvalue"(%67) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>) -> f64
    %75 = "llvm.extractvalue"(%72) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>) -> f64
    %76 = "llvm.extractvalue"(%72) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>) -> f64
    %77 = "llvm.mlir.poison"() : () -> !llvm.struct<(f64, f64)>
    %78 = "llvm.fadd"(%73, %75) <{fastmathFlags = #llvm.fastmath<reassoc>}> : (f64, f64) -> f64
    %79 = "llvm.fadd"(%74, %76) <{fastmathFlags = #llvm.fastmath<reassoc>}> : (f64, f64) -> f64
    %80 = "llvm.insertvalue"(%77, %78) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %81 = "llvm.insertvalue"(%80, %79) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "complex_substraction_with_fmf"}> ({
    %44 = "arith.constant"() <{value = 1.200000e+00 : f64}> : () -> f64
    %45 = "arith.constant"() <{value = 3.400000e+00 : f64}> : () -> f64
    %46 = "llvm.mlir.poison"() : () -> !llvm.struct<(f64, f64)>
    %47 = "llvm.insertvalue"(%46, %44) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %48 = "llvm.insertvalue"(%47, %45) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %49 = "arith.constant"() <{value = 5.600000e+00 : f64}> : () -> f64
    %50 = "arith.constant"() <{value = 7.7999999999999998 : f64}> : () -> f64
    %51 = "llvm.mlir.poison"() : () -> !llvm.struct<(f64, f64)>
    %52 = "llvm.insertvalue"(%51, %49) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %53 = "llvm.insertvalue"(%52, %50) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %54 = "llvm.extractvalue"(%48) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>) -> f64
    %55 = "llvm.extractvalue"(%48) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>) -> f64
    %56 = "llvm.extractvalue"(%53) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>) -> f64
    %57 = "llvm.extractvalue"(%53) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>) -> f64
    %58 = "llvm.mlir.poison"() : () -> !llvm.struct<(f64, f64)>
    %59 = "llvm.fsub"(%54, %56) <{fastmathFlags = #llvm.fastmath<nnan, ninf>}> : (f64, f64) -> f64
    %60 = "llvm.fsub"(%55, %57) <{fastmathFlags = #llvm.fastmath<nnan, ninf>}> : (f64, f64) -> f64
    %61 = "llvm.insertvalue"(%58, %59) <{position = array<i64: 0>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    %62 = "llvm.insertvalue"(%61, %60) <{position = array<i64: 1>}> : (!llvm.struct<(f64, f64)>, f64) -> !llvm.struct<(f64, f64)>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_div_with_fmf"}> ({
  ^bb0(%arg3: complex<f32>, %arg4: complex<f32>):
    %23 = "builtin.unrealized_conversion_cast"(%arg4) : (complex<f32>) -> !llvm.struct<(f32, f32)>
    %24 = "builtin.unrealized_conversion_cast"(%arg3) : (complex<f32>) -> !llvm.struct<(f32, f32)>
    %25 = "llvm.extractvalue"(%24) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %26 = "llvm.extractvalue"(%24) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %27 = "llvm.extractvalue"(%23) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %28 = "llvm.extractvalue"(%23) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %29 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f32)>
    %30 = "llvm.fmul"(%27, %27) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %31 = "llvm.fmul"(%28, %28) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %32 = "llvm.fadd"(%30, %31) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %33 = "llvm.fmul"(%25, %27) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %34 = "llvm.fmul"(%26, %28) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %35 = "llvm.fadd"(%33, %34) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %36 = "llvm.fmul"(%26, %27) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %37 = "llvm.fmul"(%25, %28) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %38 = "llvm.fsub"(%36, %37) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %39 = "llvm.fdiv"(%35, %32) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %40 = "llvm.fdiv"(%38, %32) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %41 = "llvm.insertvalue"(%29, %39) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    %42 = "llvm.insertvalue"(%41, %40) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    %43 = "builtin.unrealized_conversion_cast"(%42) : (!llvm.struct<(f32, f32)>) -> complex<f32>
    "func.return"(%43) : (complex<f32>) -> ()
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
    %14 = "llvm.fmul"(%11, %9) <{fastmathFlags = #llvm.fastmath<contract, afn>}> : (f32, f32) -> f32
    %15 = "llvm.fmul"(%12, %10) <{fastmathFlags = #llvm.fastmath<contract, afn>}> : (f32, f32) -> f32
    %16 = "llvm.fsub"(%14, %15) <{fastmathFlags = #llvm.fastmath<contract, afn>}> : (f32, f32) -> f32
    %17 = "llvm.fmul"(%10, %11) <{fastmathFlags = #llvm.fastmath<contract, afn>}> : (f32, f32) -> f32
    %18 = "llvm.fmul"(%9, %12) <{fastmathFlags = #llvm.fastmath<contract, afn>}> : (f32, f32) -> f32
    %19 = "llvm.fadd"(%17, %18) <{fastmathFlags = #llvm.fastmath<contract, afn>}> : (f32, f32) -> f32
    %20 = "llvm.insertvalue"(%13, %16) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    %21 = "llvm.insertvalue"(%20, %19) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    %22 = "builtin.unrealized_conversion_cast"(%21) : (!llvm.struct<(f32, f32)>) -> complex<f32>
    "func.return"(%22) : (complex<f32>) -> ()
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

