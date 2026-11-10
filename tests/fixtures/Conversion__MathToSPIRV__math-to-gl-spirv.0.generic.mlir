"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "float32_unary_scalar"}> ({
  ^bb0(%arg39: f32):
    %185 = "spirv.GL.Atan"(%arg39) : (f32) -> f32
    %186 = "spirv.GL.Cos"(%arg39) : (f32) -> f32
    %187 = "spirv.GL.Exp"(%arg39) : (f32) -> f32
    %188 = "spirv.GL.Exp2"(%arg39) : (f32) -> f32
    %189 = "spirv.GL.Exp"(%arg39) : (f32) -> f32
    %190 = "spirv.Constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %191 = "spirv.FSub"(%189, %190) : (f32, f32) -> f32
    %192 = "spirv.GL.Log"(%arg39) : (f32) -> f32
    %193 = "spirv.Constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %194 = "spirv.FAdd"(%193, %arg39) : (f32, f32) -> f32
    %195 = "spirv.GL.Log"(%194) : (f32) -> f32
    %196 = "spirv.GL.Log2"(%arg39) : (f32) -> f32
    %197 = "spirv.Constant"() <{value = 0.434294492 : f32}> : () -> f32
    %198 = "spirv.GL.Log"(%arg39) : (f32) -> f32
    %199 = "spirv.FMul"(%198, %197) : (f32, f32) -> f32
    %200 = "spirv.GL.RoundEven"(%arg39) : (f32) -> f32
    %201 = "spirv.GL.InverseSqrt"(%arg39) : (f32) -> f32
    %202 = "spirv.GL.Sqrt"(%arg39) : (f32) -> f32
    %203 = "spirv.GL.Tanh"(%arg39) : (f32) -> f32
    %204 = "spirv.GL.Sin"(%arg39) : (f32) -> f32
    %205 = "spirv.GL.FAbs"(%arg39) : (f32) -> f32
    %206 = "spirv.GL.Ceil"(%arg39) : (f32) -> f32
    %207 = "spirv.GL.Floor"(%arg39) : (f32) -> f32
    %208 = "spirv.GL.Tan"(%arg39) : (f32) -> f32
    %209 = "spirv.GL.Asin"(%arg39) : (f32) -> f32
    %210 = "spirv.GL.Acos"(%arg39) : (f32) -> f32
    %211 = "spirv.GL.Sinh"(%arg39) : (f32) -> f32
    %212 = "spirv.GL.Cosh"(%arg39) : (f32) -> f32
    %213 = "spirv.GL.Asinh"(%arg39) : (f32) -> f32
    %214 = "spirv.GL.Acosh"(%arg39) : (f32) -> f32
    %215 = "spirv.GL.Atanh"(%arg39) : (f32) -> f32
    %216 = "spirv.GL.Trunc"(%arg39) : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf32>) -> (), sym_name = "float32_unary_vector"}> ({
  ^bb0(%arg38: vector<3xf32>):
    %156 = "spirv.GL.Atan"(%arg38) : (vector<3xf32>) -> vector<3xf32>
    %157 = "spirv.GL.Cos"(%arg38) : (vector<3xf32>) -> vector<3xf32>
    %158 = "spirv.GL.Exp"(%arg38) : (vector<3xf32>) -> vector<3xf32>
    %159 = "spirv.GL.Exp2"(%arg38) : (vector<3xf32>) -> vector<3xf32>
    %160 = "spirv.GL.Exp"(%arg38) : (vector<3xf32>) -> vector<3xf32>
    %161 = "spirv.Constant"() <{value = dense<1.000000e+00> : vector<3xf32>}> : () -> vector<3xf32>
    %162 = "spirv.FSub"(%160, %161) : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %163 = "spirv.GL.Log"(%arg38) : (vector<3xf32>) -> vector<3xf32>
    %164 = "spirv.Constant"() <{value = dense<1.000000e+00> : vector<3xf32>}> : () -> vector<3xf32>
    %165 = "spirv.FAdd"(%164, %arg38) : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %166 = "spirv.GL.Log"(%165) : (vector<3xf32>) -> vector<3xf32>
    %167 = "spirv.GL.Log2"(%arg38) : (vector<3xf32>) -> vector<3xf32>
    %168 = "spirv.Constant"() <{value = dense<0.434294492> : vector<3xf32>}> : () -> vector<3xf32>
    %169 = "spirv.GL.Log"(%arg38) : (vector<3xf32>) -> vector<3xf32>
    %170 = "spirv.FMul"(%169, %168) : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %171 = "spirv.GL.RoundEven"(%arg38) : (vector<3xf32>) -> vector<3xf32>
    %172 = "spirv.GL.InverseSqrt"(%arg38) : (vector<3xf32>) -> vector<3xf32>
    %173 = "spirv.GL.Sqrt"(%arg38) : (vector<3xf32>) -> vector<3xf32>
    %174 = "spirv.GL.Tanh"(%arg38) : (vector<3xf32>) -> vector<3xf32>
    %175 = "spirv.GL.Sin"(%arg38) : (vector<3xf32>) -> vector<3xf32>
    %176 = "spirv.GL.Tan"(%arg38) : (vector<3xf32>) -> vector<3xf32>
    %177 = "spirv.GL.Asin"(%arg38) : (vector<3xf32>) -> vector<3xf32>
    %178 = "spirv.GL.Acos"(%arg38) : (vector<3xf32>) -> vector<3xf32>
    %179 = "spirv.GL.Sinh"(%arg38) : (vector<3xf32>) -> vector<3xf32>
    %180 = "spirv.GL.Cosh"(%arg38) : (vector<3xf32>) -> vector<3xf32>
    %181 = "spirv.GL.Asinh"(%arg38) : (vector<3xf32>) -> vector<3xf32>
    %182 = "spirv.GL.Acosh"(%arg38) : (vector<3xf32>) -> vector<3xf32>
    %183 = "spirv.GL.Atanh"(%arg38) : (vector<3xf32>) -> vector<3xf32>
    %184 = "spirv.GL.Trunc"(%arg38) : (vector<3xf32>) -> vector<3xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, f32) -> (), sym_name = "float32_ternary_scalar"}> ({
  ^bb0(%arg35: f32, %arg36: f32, %arg37: f32):
    %155 = "spirv.GL.Fma"(%arg35, %arg36, %arg37) : (f32, f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> (), sym_name = "float32_ternary_vector"}> ({
  ^bb0(%arg32: vector<4xf32>, %arg33: vector<4xf32>, %arg34: vector<4xf32>):
    %154 = "spirv.GL.Fma"(%arg32, %arg33, %arg34) : (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "float32_binary_scalar"}> ({
  ^bb0(%arg30: f32, %arg31: f32):
    %153 = "spirv.GL.Atan2"(%arg30, %arg31) : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf32>, vector<3xf32>) -> (), sym_name = "float32_binary_vector"}> ({
  ^bb0(%arg28: vector<3xf32>, %arg29: vector<3xf32>):
    %152 = "spirv.GL.Atan2"(%arg28, %arg29) : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, f32) -> (), sym_name = "float32_clamp_scalar"}> ({
  ^bb0(%arg25: f32, %arg26: f32, %arg27: f32):
    %151 = "spirv.GL.FClamp"(%arg25, %arg26, %arg27) : (f32, f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> (), sym_name = "float32_clamp_vector"}> ({
  ^bb0(%arg22: vector<4xf32>, %arg23: vector<4xf32>, %arg24: vector<4xf32>):
    %150 = "spirv.GL.FClamp"(%arg22, %arg23, %arg24) : (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "int_unary"}> ({
  ^bb0(%arg21: i32):
    %149 = "spirv.GL.SAbs"(%arg21) : (i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "ctlz_scalar"}> ({
  ^bb0(%arg20: i32):
    %141 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %142 = "spirv.Constant"() <{value = 31 : i32}> : () -> i32
    %143 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
    %144 = "spirv.GL.FindUMsb"(%arg20) : (i32) -> i32
    %145 = "spirv.ISub"(%142, %144) : (i32, i32) -> i32
    %146 = "spirv.ISub"(%143, %arg20) : (i32, i32) -> i32
    %147 = "spirv.ULessThanEqual"(%arg20, %141) : (i32, i32) -> i1
    %148 = "spirv.Select"(%147, %146, %145) : (i1, i32, i32) -> i32
    "func.return"(%148) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xi32>) -> vector<1xi32>, sym_name = "ctlz_vector1"}> ({
  ^bb0(%arg19: vector<1xi32>):
    %131 = "builtin.unrealized_conversion_cast"(%arg19) : (vector<1xi32>) -> i32
    %132 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %133 = "spirv.Constant"() <{value = 31 : i32}> : () -> i32
    %134 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
    %135 = "spirv.GL.FindUMsb"(%131) : (i32) -> i32
    %136 = "spirv.ISub"(%133, %135) : (i32, i32) -> i32
    %137 = "spirv.ISub"(%134, %131) : (i32, i32) -> i32
    %138 = "spirv.ULessThanEqual"(%131, %132) : (i32, i32) -> i1
    %139 = "spirv.Select"(%138, %137, %136) : (i1, i32, i32) -> i32
    %140 = "builtin.unrealized_conversion_cast"(%139) : (i32) -> vector<1xi32>
    "func.return"(%140) : (vector<1xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi32>) -> vector<2xi32>, sym_name = "ctlz_vector2"}> ({
  ^bb0(%arg18: vector<2xi32>):
    %123 = "spirv.Constant"() <{value = dense<1> : vector<2xi32>}> : () -> vector<2xi32>
    %124 = "spirv.Constant"() <{value = dense<31> : vector<2xi32>}> : () -> vector<2xi32>
    %125 = "spirv.Constant"() <{value = dense<32> : vector<2xi32>}> : () -> vector<2xi32>
    %126 = "spirv.GL.FindUMsb"(%arg18) : (vector<2xi32>) -> vector<2xi32>
    %127 = "spirv.ISub"(%124, %126) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %128 = "spirv.ISub"(%125, %arg18) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %129 = "spirv.ULessThanEqual"(%arg18, %123) : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
    %130 = "spirv.Select"(%129, %128, %127) : (vector<2xi1>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "func.return"(%130) : (vector<2xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "cttz_scalar"}> ({
  ^bb0(%arg17: i32):
    %118 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %119 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
    %120 = "spirv.GL.FindILsb"(%arg17) : (i32) -> i32
    %121 = "spirv.IEqual"(%arg17, %118) : (i32, i32) -> i1
    %122 = "spirv.Select"(%121, %119, %120) : (i1, i32, i32) -> i32
    "func.return"(%122) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi32>) -> vector<2xi32>, sym_name = "cttz_vector"}> ({
  ^bb0(%arg16: vector<2xi32>):
    %113 = "spirv.Constant"() <{value = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
    %114 = "spirv.Constant"() <{value = dense<32> : vector<2xi32>}> : () -> vector<2xi32>
    %115 = "spirv.GL.FindILsb"(%arg16) : (vector<2xi32>) -> vector<2xi32>
    %116 = "spirv.IEqual"(%arg16, %113) : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
    %117 = "spirv.Select"(%116, %114, %115) : (vector<2xi1>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "func.return"(%117) : (vector<2xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "powf_scalar"}> ({
  ^bb0(%arg14: f32, %arg15: f32):
    %110 = "spirv.GL.Log"(%arg14) : (f32) -> f32
    %111 = "spirv.FMul"(%arg15, %110) : (f32, f32) -> f32
    %112 = "spirv.GL.Exp"(%111) : (f32) -> f32
    "func.return"(%112) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>) -> vector<4xf32>, sym_name = "powf_vector"}> ({
  ^bb0(%arg12: vector<4xf32>, %arg13: vector<4xf32>):
    %107 = "spirv.GL.Log"(%arg12) : (vector<4xf32>) -> vector<4xf32>
    %108 = "spirv.FMul"(%arg13, %107) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %109 = "spirv.GL.Exp"(%108) : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%109) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "powf_const_odd_int_exp"}> ({
  ^bb0(%arg11: f32):
    %100 = "arith.constant"() <{value = 3.000000e+00 : f32}> : () -> f32
    %101 = "spirv.GL.FAbs"(%arg11) : (f32) -> f32
    %102 = "spirv.GL.Pow"(%101, %100) : (f32, f32) -> f32
    %103 = "spirv.Constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %104 = "spirv.FOrdLessThan"(%arg11, %103) : (f32, f32) -> i1
    %105 = "spirv.FNegate"(%102) : (f32) -> f32
    %106 = "spirv.Select"(%104, %105, %102) : (i1, f32, f32) -> f32
    "func.return"(%106) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "powf_const_even_int_exp"}> ({
  ^bb0(%arg10: f32):
    %97 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    %98 = "spirv.GL.FAbs"(%arg10) : (f32) -> f32
    %99 = "spirv.GL.Pow"(%98, %97) : (f32, f32) -> f32
    "func.return"(%99) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "powf_const_frac_exp"}> ({
  ^bb0(%arg9: f32):
    %93 = "arith.constant"() <{value = 2.500000e+00 : f32}> : () -> f32
    %94 = "spirv.GL.Log"(%arg9) : (f32) -> f32
    %95 = "spirv.FMul"(%93, %94) : (f32, f32) -> f32
    %96 = "spirv.GL.Exp"(%95) : (f32) -> f32
    "func.return"(%96) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> vector<4xf32>, sym_name = "powf_const_odd_int_exp_vector"}> ({
  ^bb0(%arg8: vector<4xf32>):
    %86 = "arith.constant"() <{value = dense<3.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %87 = "spirv.GL.FAbs"(%arg8) : (vector<4xf32>) -> vector<4xf32>
    %88 = "spirv.GL.Pow"(%87, %86) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %89 = "spirv.Constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %90 = "spirv.FOrdLessThan"(%arg8, %89) : (vector<4xf32>, vector<4xf32>) -> vector<4xi1>
    %91 = "spirv.FNegate"(%88) : (vector<4xf32>) -> vector<4xf32>
    %92 = "spirv.Select"(%90, %91, %88) : (vector<4xi1>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"(%92) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> vector<4xf32>, sym_name = "powf_const_mixed_int_exp_vector"}> ({
  ^bb0(%arg7: vector<4xf32>):
    %77 = "arith.constant"() <{value = dense<[3.000000e+00, 2.000000e+00, 5.000000e+00, 4.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %78 = "spirv.GL.FAbs"(%arg7) : (vector<4xf32>) -> vector<4xf32>
    %79 = "spirv.GL.Pow"(%78, %77) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %80 = "spirv.Constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %81 = "spirv.FOrdLessThan"(%arg7, %80) : (vector<4xf32>, vector<4xf32>) -> vector<4xi1>
    %82 = "spirv.FNegate"(%79) : (vector<4xf32>) -> vector<4xf32>
    %83 = "spirv.Constant"() <{value = dense<[true, false, true, false]> : vector<4xi1>}> : () -> vector<4xi1>
    %84 = "spirv.LogicalAnd"(%81, %83) : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    %85 = "spirv.Select"(%84, %82, %79) : (vector<4xi1>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"(%85) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, i32) -> f32, sym_name = "fpowi_scalar"}> ({
  ^bb0(%arg5: f32, %arg6: i32):
    %66 = "spirv.ConvertSToF"(%arg6) : (i32) -> f32
    %67 = "spirv.GL.FAbs"(%arg5) : (f32) -> f32
    %68 = "spirv.GL.Pow"(%67, %66) : (f32, f32) -> f32
    %69 = "spirv.Constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %70 = "spirv.FOrdLessThan"(%arg5, %69) : (f32, f32) -> i1
    %71 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %72 = "spirv.BitwiseAnd"(%arg6, %71) : (i32, i32) -> i32
    %73 = "spirv.IEqual"(%72, %71) : (i32, i32) -> i1
    %74 = "spirv.LogicalAnd"(%70, %73) : (i1, i1) -> i1
    %75 = "spirv.FNegate"(%68) : (f32) -> f32
    %76 = "spirv.Select"(%74, %75, %68) : (i1, f32, f32) -> f32
    "func.return"(%76) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<4xi32>) -> vector<4xf32>, sym_name = "fpowi_vector"}> ({
  ^bb0(%arg3: vector<4xf32>, %arg4: vector<4xi32>):
    %55 = "spirv.ConvertSToF"(%arg4) : (vector<4xi32>) -> vector<4xf32>
    %56 = "spirv.GL.FAbs"(%arg3) : (vector<4xf32>) -> vector<4xf32>
    %57 = "spirv.GL.Pow"(%56, %55) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %58 = "spirv.Constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %59 = "spirv.FOrdLessThan"(%arg3, %58) : (vector<4xf32>, vector<4xf32>) -> vector<4xi1>
    %60 = "spirv.Constant"() <{value = dense<1> : vector<4xi32>}> : () -> vector<4xi32>
    %61 = "spirv.BitwiseAnd"(%arg4, %60) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %62 = "spirv.IEqual"(%61, %60) : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
    %63 = "spirv.LogicalAnd"(%59, %62) : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    %64 = "spirv.FNegate"(%57) : (vector<4xf32>) -> vector<4xf32>
    %65 = "spirv.Select"(%63, %64, %57) : (vector<4xi1>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"(%65) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "round_scalar"}> ({
  ^bb0(%arg2: f32):
    %38 = "spirv.Constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %39 = "spirv.Constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %40 = "spirv.Constant"() <{value = 5.000000e-01 : f32}> : () -> f32
    %41 = "spirv.GL.FAbs"(%arg2) : (f32) -> f32
    %42 = "spirv.GL.Floor"(%41) : (f32) -> f32
    %43 = "spirv.FSub"(%41, %42) : (f32, f32) -> f32
    %44 = "spirv.FOrdGreaterThanEqual"(%43, %40) : (f32, f32) -> i1
    %45 = "spirv.Select"(%44, %39, %38) : (i1, f32, f32) -> f32
    %46 = "spirv.FAdd"(%42, %45) : (f32, f32) -> f32
    %47 = "spirv.Constant"() <{value = -2147483648 : i32}> : () -> i32
    %48 = "spirv.Constant"() <{value = 2147483647 : i32}> : () -> i32
    %49 = "spirv.Bitcast"(%46) : (f32) -> i32
    %50 = "spirv.Bitcast"(%arg2) : (f32) -> i32
    %51 = "spirv.BitwiseAnd"(%49, %48) : (i32, i32) -> i32
    %52 = "spirv.BitwiseAnd"(%50, %47) : (i32, i32) -> i32
    %53 = "spirv.BitwiseOr"(%51, %52) : (i32, i32) -> i32
    %54 = "spirv.Bitcast"(%53) : (i32) -> f32
    "func.return"(%54) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> vector<4xf32>, sym_name = "round_vector"}> ({
  ^bb0(%arg1: vector<4xf32>):
    %19 = "spirv.Constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %20 = "spirv.Constant"() <{value = dense<1.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %21 = "spirv.Constant"() <{value = dense<5.000000e-01> : vector<4xf32>}> : () -> vector<4xf32>
    %22 = "spirv.GL.FAbs"(%arg1) : (vector<4xf32>) -> vector<4xf32>
    %23 = "spirv.GL.Floor"(%22) : (vector<4xf32>) -> vector<4xf32>
    %24 = "spirv.FSub"(%22, %23) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %25 = "spirv.FOrdGreaterThanEqual"(%24, %21) : (vector<4xf32>, vector<4xf32>) -> vector<4xi1>
    %26 = "spirv.Select"(%25, %20, %19) : (vector<4xi1>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %27 = "spirv.FAdd"(%23, %26) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %28 = "spirv.Constant"() <{value = -2147483648 : i32}> : () -> i32
    %29 = "spirv.Constant"() <{value = 2147483647 : i32}> : () -> i32
    %30 = "spirv.CompositeConstruct"(%28, %28, %28, %28) : (i32, i32, i32, i32) -> vector<4xi32>
    %31 = "spirv.CompositeConstruct"(%29, %29, %29, %29) : (i32, i32, i32, i32) -> vector<4xi32>
    %32 = "spirv.Bitcast"(%27) : (vector<4xf32>) -> vector<4xi32>
    %33 = "spirv.Bitcast"(%arg1) : (vector<4xf32>) -> vector<4xi32>
    %34 = "spirv.BitwiseAnd"(%32, %31) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %35 = "spirv.BitwiseAnd"(%33, %30) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %36 = "spirv.BitwiseOr"(%34, %35) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %37 = "spirv.Bitcast"(%36) : (vector<4xi32>) -> vector<4xf32>
    "func.return"(%37) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf32>) -> vector<1xf32>, sym_name = "round_vector_unit_dim"}> ({
  ^bb0(%arg0: vector<1xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<1xf32>) -> f32
    %1 = "spirv.Constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "spirv.Constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "spirv.Constant"() <{value = 5.000000e-01 : f32}> : () -> f32
    %4 = "spirv.GL.FAbs"(%0) : (f32) -> f32
    %5 = "spirv.GL.Floor"(%4) : (f32) -> f32
    %6 = "spirv.FSub"(%4, %5) : (f32, f32) -> f32
    %7 = "spirv.FOrdGreaterThanEqual"(%6, %3) : (f32, f32) -> i1
    %8 = "spirv.Select"(%7, %2, %1) : (i1, f32, f32) -> f32
    %9 = "spirv.FAdd"(%5, %8) : (f32, f32) -> f32
    %10 = "spirv.Constant"() <{value = -2147483648 : i32}> : () -> i32
    %11 = "spirv.Constant"() <{value = 2147483647 : i32}> : () -> i32
    %12 = "spirv.Bitcast"(%9) : (f32) -> i32
    %13 = "spirv.Bitcast"(%0) : (f32) -> i32
    %14 = "spirv.BitwiseAnd"(%12, %11) : (i32, i32) -> i32
    %15 = "spirv.BitwiseAnd"(%13, %10) : (i32, i32) -> i32
    %16 = "spirv.BitwiseOr"(%14, %15) : (i32, i32) -> i32
    %17 = "spirv.Bitcast"(%16) : (i32) -> f32
    %18 = "builtin.unrealized_conversion_cast"(%17) : (f32) -> vector<1xf32>
    "func.return"(%18) : (vector<1xf32>) -> ()
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

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "sincos_scalar"}> ({
  ^bb0(%arg1: f32):
    %2 = "spirv.GL.Sin"(%arg1) : (f32) -> f32
    %3 = "spirv.GL.Cos"(%arg1) : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf32>) -> (), sym_name = "sincos_vector"}> ({
  ^bb0(%arg0: vector<3xf32>):
    %0 = "spirv.GL.Sin"(%arg0) : (vector<3xf32>) -> vector<3xf32>
    %1 = "spirv.GL.Cos"(%arg0) : (vector<3xf32>) -> vector<3xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], []>, #spirv.resource_limits<>>} : () -> ()

