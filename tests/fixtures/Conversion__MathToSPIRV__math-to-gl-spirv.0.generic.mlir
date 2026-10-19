"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "float32_unary_scalar"}> ({
  ^bb0(%arg17: f32):
    %128 = "spirv.GL.Atan"(%arg17) : (f32) -> f32
    %129 = "spirv.GL.Cos"(%arg17) : (f32) -> f32
    %130 = "spirv.GL.Exp"(%arg17) : (f32) -> f32
    %131 = "spirv.GL.Exp"(%arg17) : (f32) -> f32
    %132 = "spirv.Constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %133 = "spirv.FSub"(%131, %132) : (f32, f32) -> f32
    %134 = "spirv.GL.Log"(%arg17) : (f32) -> f32
    %135 = "spirv.Constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %136 = "spirv.FAdd"(%135, %arg17) : (f32, f32) -> f32
    %137 = "spirv.GL.Log"(%136) : (f32) -> f32
    %138 = "spirv.Constant"() <{value = 1.44269502 : f32}> : () -> f32
    %139 = "spirv.GL.Log"(%arg17) : (f32) -> f32
    %140 = "spirv.FMul"(%139, %138) : (f32, f32) -> f32
    %141 = "spirv.Constant"() <{value = 0.434294492 : f32}> : () -> f32
    %142 = "spirv.GL.Log"(%arg17) : (f32) -> f32
    %143 = "spirv.FMul"(%142, %141) : (f32, f32) -> f32
    %144 = "spirv.GL.RoundEven"(%arg17) : (f32) -> f32
    %145 = "spirv.GL.InverseSqrt"(%arg17) : (f32) -> f32
    %146 = "spirv.GL.Sqrt"(%arg17) : (f32) -> f32
    %147 = "spirv.GL.Tanh"(%arg17) : (f32) -> f32
    %148 = "spirv.GL.Sin"(%arg17) : (f32) -> f32
    %149 = "spirv.GL.FAbs"(%arg17) : (f32) -> f32
    %150 = "spirv.GL.Ceil"(%arg17) : (f32) -> f32
    %151 = "spirv.GL.Floor"(%arg17) : (f32) -> f32
    %152 = "spirv.GL.Tan"(%arg17) : (f32) -> f32
    %153 = "spirv.GL.Asin"(%arg17) : (f32) -> f32
    %154 = "spirv.GL.Acos"(%arg17) : (f32) -> f32
    %155 = "spirv.GL.Sinh"(%arg17) : (f32) -> f32
    %156 = "spirv.GL.Cosh"(%arg17) : (f32) -> f32
    %157 = "spirv.GL.Asinh"(%arg17) : (f32) -> f32
    %158 = "spirv.GL.Acosh"(%arg17) : (f32) -> f32
    %159 = "spirv.GL.Atanh"(%arg17) : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf32>) -> (), sym_name = "float32_unary_vector"}> ({
  ^bb0(%arg16: vector<3xf32>):
    %99 = "spirv.GL.Atan"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %100 = "spirv.GL.Cos"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %101 = "spirv.GL.Exp"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %102 = "spirv.GL.Exp"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %103 = "spirv.Constant"() <{value = dense<1.000000e+00> : vector<3xf32>}> : () -> vector<3xf32>
    %104 = "spirv.FSub"(%102, %103) : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %105 = "spirv.GL.Log"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %106 = "spirv.Constant"() <{value = dense<1.000000e+00> : vector<3xf32>}> : () -> vector<3xf32>
    %107 = "spirv.FAdd"(%106, %arg16) : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %108 = "spirv.GL.Log"(%107) : (vector<3xf32>) -> vector<3xf32>
    %109 = "spirv.Constant"() <{value = dense<1.44269502> : vector<3xf32>}> : () -> vector<3xf32>
    %110 = "spirv.GL.Log"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %111 = "spirv.FMul"(%110, %109) : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %112 = "spirv.Constant"() <{value = dense<0.434294492> : vector<3xf32>}> : () -> vector<3xf32>
    %113 = "spirv.GL.Log"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %114 = "spirv.FMul"(%113, %112) : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %115 = "spirv.GL.RoundEven"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %116 = "spirv.GL.InverseSqrt"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %117 = "spirv.GL.Sqrt"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %118 = "spirv.GL.Tanh"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %119 = "spirv.GL.Sin"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %120 = "spirv.GL.Tan"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %121 = "spirv.GL.Asin"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %122 = "spirv.GL.Acos"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %123 = "spirv.GL.Sinh"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %124 = "spirv.GL.Cosh"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %125 = "spirv.GL.Asinh"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %126 = "spirv.GL.Acosh"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %127 = "spirv.GL.Atanh"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, f32) -> (), sym_name = "float32_ternary_scalar"}> ({
  ^bb0(%arg13: f32, %arg14: f32, %arg15: f32):
    %98 = "spirv.GL.Fma"(%arg13, %arg14, %arg15) : (f32, f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> (), sym_name = "float32_ternary_vector"}> ({
  ^bb0(%arg10: vector<4xf32>, %arg11: vector<4xf32>, %arg12: vector<4xf32>):
    %97 = "spirv.GL.Fma"(%arg10, %arg11, %arg12) : (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "int_unary"}> ({
  ^bb0(%arg9: i32):
    %96 = "spirv.GL.SAbs"(%arg9) : (i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "ctlz_scalar"}> ({
  ^bb0(%arg8: i32):
    %88 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %89 = "spirv.Constant"() <{value = 31 : i32}> : () -> i32
    %90 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
    %91 = "spirv.GL.FindUMsb"(%arg8) : (i32) -> i32
    %92 = "spirv.ISub"(%89, %91) : (i32, i32) -> i32
    %93 = "spirv.ISub"(%90, %arg8) : (i32, i32) -> i32
    %94 = "spirv.ULessThanEqual"(%arg8, %88) : (i32, i32) -> i1
    %95 = "spirv.Select"(%94, %93, %92) : (i1, i32, i32) -> i32
    "func.return"(%95) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xi32>) -> vector<1xi32>, sym_name = "ctlz_vector1"}> ({
  ^bb0(%arg7: vector<1xi32>):
    %78 = "builtin.unrealized_conversion_cast"(%arg7) : (vector<1xi32>) -> i32
    %79 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %80 = "spirv.Constant"() <{value = 31 : i32}> : () -> i32
    %81 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
    %82 = "spirv.GL.FindUMsb"(%78) : (i32) -> i32
    %83 = "spirv.ISub"(%80, %82) : (i32, i32) -> i32
    %84 = "spirv.ISub"(%81, %78) : (i32, i32) -> i32
    %85 = "spirv.ULessThanEqual"(%78, %79) : (i32, i32) -> i1
    %86 = "spirv.Select"(%85, %84, %83) : (i1, i32, i32) -> i32
    %87 = "builtin.unrealized_conversion_cast"(%86) : (i32) -> vector<1xi32>
    "func.return"(%87) : (vector<1xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi32>) -> vector<2xi32>, sym_name = "ctlz_vector2"}> ({
  ^bb0(%arg6: vector<2xi32>):
    %70 = "spirv.Constant"() <{value = dense<1> : vector<2xi32>}> : () -> vector<2xi32>
    %71 = "spirv.Constant"() <{value = dense<31> : vector<2xi32>}> : () -> vector<2xi32>
    %72 = "spirv.Constant"() <{value = dense<32> : vector<2xi32>}> : () -> vector<2xi32>
    %73 = "spirv.GL.FindUMsb"(%arg6) : (vector<2xi32>) -> vector<2xi32>
    %74 = "spirv.ISub"(%71, %73) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %75 = "spirv.ISub"(%72, %arg6) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %76 = "spirv.ULessThanEqual"(%arg6, %70) : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
    %77 = "spirv.Select"(%76, %75, %74) : (vector<2xi1>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "func.return"(%77) : (vector<2xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "powf_scalar"}> ({
  ^bb0(%arg4: f32, %arg5: f32):
    %53 = "spirv.Constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %54 = "spirv.FOrdLessThan"(%arg4, %53) : (f32, f32) -> i1
    %55 = "spirv.Constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %56 = "spirv.FRem"(%arg5, %55) : (f32, f32) -> f32
    %57 = "spirv.FOrdNotEqual"(%56, %53) : (f32, f32) -> i1
    %58 = "spirv.LogicalAnd"(%57, %54) : (i1, i1) -> i1
    %59 = "spirv.Constant"() <{value = 0x7FC00000 : f32}> : () -> f32
    %60 = "spirv.Select"(%58, %59, %arg4) : (i1, f32, f32) -> f32
    %61 = "spirv.GL.FAbs"(%60) : (f32) -> f32
    %62 = "spirv.ConvertFToS"(%arg5) : (f32) -> i32
    %63 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %64 = "spirv.BitwiseAnd"(%62, %63) : (i32, i32) -> i32
    %65 = "spirv.IEqual"(%64, %63) : (i32, i32) -> i1
    %66 = "spirv.GL.Pow"(%61, %arg5) : (f32, f32) -> f32
    %67 = "spirv.FNegate"(%66) : (f32) -> f32
    %68 = "spirv.LogicalAnd"(%54, %65) : (i1, i1) -> i1
    %69 = "spirv.Select"(%68, %67, %66) : (i1, f32, f32) -> f32
    "func.return"(%69) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>) -> vector<4xf32>, sym_name = "powf_vector"}> ({
  ^bb0(%arg2: vector<4xf32>, %arg3: vector<4xf32>):
    %36 = "spirv.Constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %37 = "spirv.FOrdLessThan"(%arg2, %36) : (vector<4xf32>, vector<4xf32>) -> vector<4xi1>
    %38 = "spirv.Constant"() <{value = dense<1.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %39 = "spirv.FRem"(%arg3, %38) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %40 = "spirv.FOrdNotEqual"(%39, %36) : (vector<4xf32>, vector<4xf32>) -> vector<4xi1>
    %41 = "spirv.LogicalAnd"(%40, %37) : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    %42 = "spirv.Constant"() <{value = dense<0x7FC00000> : vector<4xf32>}> : () -> vector<4xf32>
    %43 = "spirv.Select"(%41, %42, %arg2) : (vector<4xi1>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %44 = "spirv.GL.FAbs"(%43) : (vector<4xf32>) -> vector<4xf32>
    %45 = "spirv.ConvertFToS"(%arg3) : (vector<4xf32>) -> vector<4xi32>
    %46 = "spirv.Constant"() <{value = dense<1> : vector<4xi32>}> : () -> vector<4xi32>
    %47 = "spirv.BitwiseAnd"(%45, %46) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %48 = "spirv.IEqual"(%47, %46) : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
    %49 = "spirv.GL.Pow"(%44, %arg3) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %50 = "spirv.FNegate"(%49) : (vector<4xf32>) -> vector<4xf32>
    %51 = "spirv.LogicalAnd"(%37, %48) : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    %52 = "spirv.Select"(%51, %50, %49) : (vector<4xi1>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"(%52) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "round_scalar"}> ({
  ^bb0(%arg1: f32):
    %19 = "spirv.Constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %20 = "spirv.Constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %21 = "spirv.Constant"() <{value = 5.000000e-01 : f32}> : () -> f32
    %22 = "spirv.GL.FAbs"(%arg1) : (f32) -> f32
    %23 = "spirv.GL.Floor"(%22) : (f32) -> f32
    %24 = "spirv.FSub"(%22, %23) : (f32, f32) -> f32
    %25 = "spirv.FOrdGreaterThanEqual"(%24, %21) : (f32, f32) -> i1
    %26 = "spirv.Select"(%25, %20, %19) : (i1, f32, f32) -> f32
    %27 = "spirv.FAdd"(%23, %26) : (f32, f32) -> f32
    %28 = "spirv.Constant"() <{value = -2147483648 : i32}> : () -> i32
    %29 = "spirv.Constant"() <{value = 2147483647 : i32}> : () -> i32
    %30 = "spirv.Bitcast"(%27) : (f32) -> i32
    %31 = "spirv.Bitcast"(%arg1) : (f32) -> i32
    %32 = "spirv.BitwiseAnd"(%30, %29) : (i32, i32) -> i32
    %33 = "spirv.BitwiseAnd"(%31, %28) : (i32, i32) -> i32
    %34 = "spirv.BitwiseOr"(%32, %33) : (i32, i32) -> i32
    %35 = "spirv.Bitcast"(%34) : (i32) -> f32
    "func.return"(%35) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> vector<4xf32>, sym_name = "round_vector"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "spirv.Constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %1 = "spirv.Constant"() <{value = dense<1.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %2 = "spirv.Constant"() <{value = dense<5.000000e-01> : vector<4xf32>}> : () -> vector<4xf32>
    %3 = "spirv.GL.FAbs"(%arg0) : (vector<4xf32>) -> vector<4xf32>
    %4 = "spirv.GL.Floor"(%3) : (vector<4xf32>) -> vector<4xf32>
    %5 = "spirv.FSub"(%3, %4) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %6 = "spirv.FOrdGreaterThanEqual"(%5, %2) : (vector<4xf32>, vector<4xf32>) -> vector<4xi1>
    %7 = "spirv.Select"(%6, %1, %0) : (vector<4xi1>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %8 = "spirv.FAdd"(%4, %7) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %9 = "spirv.Constant"() <{value = -2147483648 : i32}> : () -> i32
    %10 = "spirv.Constant"() <{value = 2147483647 : i32}> : () -> i32
    %11 = "spirv.CompositeConstruct"(%9, %9, %9, %9) : (i32, i32, i32, i32) -> vector<4xi32>
    %12 = "spirv.CompositeConstruct"(%10, %10, %10, %10) : (i32, i32, i32, i32) -> vector<4xi32>
    %13 = "spirv.Bitcast"(%8) : (vector<4xf32>) -> vector<4xi32>
    %14 = "spirv.Bitcast"(%arg0) : (vector<4xf32>) -> vector<4xi32>
    %15 = "spirv.BitwiseAnd"(%13, %12) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %16 = "spirv.BitwiseAnd"(%14, %11) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %17 = "spirv.BitwiseOr"(%15, %16) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %18 = "spirv.Bitcast"(%17) : (vector<4xi32>) -> vector<4xf32>
    "func.return"(%18) : (vector<4xf32>) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64) -> i64, sym_name = "ctlz_scalar"}> ({
  ^bb0(%arg1: i64):
    %1 = "math.ctlz"(%arg1) : (i64) -> i64
    "func.return"(%1) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi16>) -> vector<2xi16>, sym_name = "ctlz_vector2"}> ({
  ^bb0(%arg0: vector<2xi16>):
    %0 = "math.ctlz"(%arg0) : (vector<2xi16>) -> vector<2xi16>
    "func.return"(%0) : (vector<2xi16>) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64, Int16], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xf32>) -> (), sym_name = "vector_2d"}> ({
  ^bb0(%arg1: vector<2x2xf32>):
    %7 = "math.atan"(%arg1) <{fastmath = #arith.fastmath<none>}> : (vector<2x2xf32>) -> vector<2x2xf32>
    %8 = "math.cos"(%arg1) <{fastmath = #arith.fastmath<none>}> : (vector<2x2xf32>) -> vector<2x2xf32>
    %9 = "math.exp"(%arg1) <{fastmath = #arith.fastmath<none>}> : (vector<2x2xf32>) -> vector<2x2xf32>
    %10 = "math.absf"(%arg1) <{fastmath = #arith.fastmath<none>}> : (vector<2x2xf32>) -> vector<2x2xf32>
    %11 = "math.ceil"(%arg1) <{fastmath = #arith.fastmath<none>}> : (vector<2x2xf32>) -> vector<2x2xf32>
    %12 = "math.floor"(%arg1) <{fastmath = #arith.fastmath<none>}> : (vector<2x2xf32>) -> vector<2x2xf32>
    %13 = "math.powf"(%arg1, %arg1) <{fastmath = #arith.fastmath<none>}> : (vector<2x2xf32>, vector<2x2xf32>) -> vector<2x2xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<2xf32>) -> (), sym_name = "tensor_1d"}> ({
  ^bb0(%arg0: tensor<2xf32>):
    %0 = "math.atan"(%arg0) <{fastmath = #arith.fastmath<none>}> : (tensor<2xf32>) -> tensor<2xf32>
    %1 = "math.cos"(%arg0) <{fastmath = #arith.fastmath<none>}> : (tensor<2xf32>) -> tensor<2xf32>
    %2 = "math.exp"(%arg0) <{fastmath = #arith.fastmath<none>}> : (tensor<2xf32>) -> tensor<2xf32>
    %3 = "math.absf"(%arg0) <{fastmath = #arith.fastmath<none>}> : (tensor<2xf32>) -> tensor<2xf32>
    %4 = "math.ceil"(%arg0) <{fastmath = #arith.fastmath<none>}> : (tensor<2xf32>) -> tensor<2xf32>
    %5 = "math.floor"(%arg0) <{fastmath = #arith.fastmath<none>}> : (tensor<2xf32>) -> tensor<2xf32>
    %6 = "math.powf"(%arg0, %arg0) <{fastmath = #arith.fastmath<none>}> : (tensor<2xf32>, tensor<2xf32>) -> tensor<2xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], []>, #spirv.resource_limits<>>} : () -> ()

