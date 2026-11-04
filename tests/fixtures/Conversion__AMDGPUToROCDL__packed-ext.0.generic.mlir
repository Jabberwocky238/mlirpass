"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf8E4M3FN>, f32) -> vector<2xf32>, sym_name = "scaled_ext_full_f8e4m3_f32"}> ({
  ^bb0(%arg70: vector<4xf8E4M3FN>, %arg71: f32):
    %272 = "builtin.unrealized_conversion_cast"(%arg70) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %273 = "llvm.bitcast"(%272) : (vector<4xi8>) -> i32
    %274 = "rocdl.cvt.scalef32.pk.f32.fp8"(%273, %arg71) <{srcLoHiSel = false}> : (i32, f32) -> vector<2xf32>
    "func.return"(%274) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E4M3FN>, f32) -> vector<2xf16>, sym_name = "scaled_ext_full_f8e4m3_f16"}> ({
  ^bb0(%arg68: vector<4xf8E4M3FN>, %arg69: f32):
    %269 = "builtin.unrealized_conversion_cast"(%arg68) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %270 = "llvm.bitcast"(%269) : (vector<4xi8>) -> i32
    %271 = "rocdl.cvt.scalef32.pk.f16.fp8"(%270, %arg69) <{srcLoHiSel = false}> : (i32, f32) -> vector<2xf16>
    "func.return"(%271) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E4M3FN>, f32) -> vector<2xbf16>, sym_name = "scaled_ext_full_f8e4m3_bf16"}> ({
  ^bb0(%arg66: vector<4xf8E4M3FN>, %arg67: f32):
    %266 = "builtin.unrealized_conversion_cast"(%arg66) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %267 = "llvm.bitcast"(%266) : (vector<4xi8>) -> i32
    %268 = "rocdl.cvt.scalef32.pk.bf16.fp8"(%267, %arg67) <{srcLoHiSel = false}> : (i32, f32) -> vector<2xbf16>
    "func.return"(%268) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf8E4M3FN>, f32) -> vector<2xf32>, sym_name = "scaled_ext_half_f8e4m3_f32"}> ({
  ^bb0(%arg64: vector<2xf8E4M3FN>, %arg65: f32):
    %256 = "builtin.unrealized_conversion_cast"(%arg64) : (vector<2xf8E4M3FN>) -> vector<2xi8>
    %257 = "llvm.mlir.zero"() : () -> vector<4xi8>
    %258 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %259 = "llvm.extractelement"(%256, %258) : (vector<2xi8>, i32) -> i8
    %260 = "llvm.insertelement"(%257, %259, %258) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %261 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %262 = "llvm.extractelement"(%256, %261) : (vector<2xi8>, i32) -> i8
    %263 = "llvm.insertelement"(%260, %262, %261) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %264 = "llvm.bitcast"(%263) : (vector<4xi8>) -> i32
    %265 = "rocdl.cvt.scalef32.pk.f32.fp8"(%264, %arg65) <{srcLoHiSel = false}> : (i32, f32) -> vector<2xf32>
    "func.return"(%265) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf8E4M3FN>, f32) -> vector<2xf16>, sym_name = "scaled_ext_half_f8e4m3_f16"}> ({
  ^bb0(%arg62: vector<2xf8E4M3FN>, %arg63: f32):
    %246 = "builtin.unrealized_conversion_cast"(%arg62) : (vector<2xf8E4M3FN>) -> vector<2xi8>
    %247 = "llvm.mlir.zero"() : () -> vector<4xi8>
    %248 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %249 = "llvm.extractelement"(%246, %248) : (vector<2xi8>, i32) -> i8
    %250 = "llvm.insertelement"(%247, %249, %248) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %251 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %252 = "llvm.extractelement"(%246, %251) : (vector<2xi8>, i32) -> i8
    %253 = "llvm.insertelement"(%250, %252, %251) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %254 = "llvm.bitcast"(%253) : (vector<4xi8>) -> i32
    %255 = "rocdl.cvt.scalef32.pk.f16.fp8"(%254, %arg63) <{srcLoHiSel = false}> : (i32, f32) -> vector<2xf16>
    "func.return"(%255) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf8E4M3FN>, f32) -> vector<2xbf16>, sym_name = "scaled_ext_half_f8e4m3_bf16"}> ({
  ^bb0(%arg60: vector<2xf8E4M3FN>, %arg61: f32):
    %236 = "builtin.unrealized_conversion_cast"(%arg60) : (vector<2xf8E4M3FN>) -> vector<2xi8>
    %237 = "llvm.mlir.zero"() : () -> vector<4xi8>
    %238 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %239 = "llvm.extractelement"(%236, %238) : (vector<2xi8>, i32) -> i8
    %240 = "llvm.insertelement"(%237, %239, %238) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %241 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %242 = "llvm.extractelement"(%236, %241) : (vector<2xi8>, i32) -> i8
    %243 = "llvm.insertelement"(%240, %242, %241) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %244 = "llvm.bitcast"(%243) : (vector<4xi8>) -> i32
    %245 = "rocdl.cvt.scalef32.pk.bf16.fp8"(%244, %arg61) <{srcLoHiSel = false}> : (i32, f32) -> vector<2xbf16>
    "func.return"(%245) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf8E4M3FN>, f32) -> vector<2xf32>, sym_name = "scaled_ext_scalar_f8e4m3_f32"}> ({
  ^bb0(%arg58: vector<2xf8E4M3FN>, %arg59: f32):
    %226 = "builtin.unrealized_conversion_cast"(%arg58) : (vector<2xf8E4M3FN>) -> vector<2xi8>
    %227 = "llvm.mlir.zero"() : () -> vector<4xi8>
    %228 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %229 = "llvm.extractelement"(%226, %228) : (vector<2xi8>, i32) -> i8
    %230 = "llvm.insertelement"(%227, %229, %228) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %231 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %232 = "llvm.extractelement"(%226, %231) : (vector<2xi8>, i32) -> i8
    %233 = "llvm.insertelement"(%230, %232, %231) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %234 = "llvm.bitcast"(%233) : (vector<4xi8>) -> i32
    %235 = "rocdl.cvt.scalef32.pk.f32.fp8"(%234, %arg59) <{srcLoHiSel = false}> : (i32, f32) -> vector<2xf32>
    "func.return"(%235) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf8E4M3FN>, f32) -> vector<2xf16>, sym_name = "scaled_ext_scalar_f8e4m3_f16"}> ({
  ^bb0(%arg56: vector<2xf8E4M3FN>, %arg57: f32):
    %216 = "builtin.unrealized_conversion_cast"(%arg56) : (vector<2xf8E4M3FN>) -> vector<2xi8>
    %217 = "llvm.mlir.zero"() : () -> vector<4xi8>
    %218 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %219 = "llvm.extractelement"(%216, %218) : (vector<2xi8>, i32) -> i8
    %220 = "llvm.insertelement"(%217, %219, %218) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %221 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %222 = "llvm.extractelement"(%216, %221) : (vector<2xi8>, i32) -> i8
    %223 = "llvm.insertelement"(%220, %222, %221) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %224 = "llvm.bitcast"(%223) : (vector<4xi8>) -> i32
    %225 = "rocdl.cvt.scalef32.pk.f16.fp8"(%224, %arg57) <{srcLoHiSel = false}> : (i32, f32) -> vector<2xf16>
    "func.return"(%225) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf8E4M3FN>, f32) -> vector<2xbf16>, sym_name = "scaled_ext_scalar_f8e4m3_bf16"}> ({
  ^bb0(%arg54: vector<2xf8E4M3FN>, %arg55: f32):
    %206 = "builtin.unrealized_conversion_cast"(%arg54) : (vector<2xf8E4M3FN>) -> vector<2xi8>
    %207 = "llvm.mlir.zero"() : () -> vector<4xi8>
    %208 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %209 = "llvm.extractelement"(%206, %208) : (vector<2xi8>, i32) -> i8
    %210 = "llvm.insertelement"(%207, %209, %208) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %211 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %212 = "llvm.extractelement"(%206, %211) : (vector<2xi8>, i32) -> i8
    %213 = "llvm.insertelement"(%210, %212, %211) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %214 = "llvm.bitcast"(%213) : (vector<4xi8>) -> i32
    %215 = "rocdl.cvt.scalef32.pk.bf16.fp8"(%214, %arg55) <{srcLoHiSel = false}> : (i32, f32) -> vector<2xbf16>
    "func.return"(%215) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E5M2>, f32) -> vector<2xf32>, sym_name = "scaled_ext_full_f8e5m2_f32"}> ({
  ^bb0(%arg52: vector<4xf8E5M2>, %arg53: f32):
    %203 = "builtin.unrealized_conversion_cast"(%arg52) : (vector<4xf8E5M2>) -> vector<4xi8>
    %204 = "llvm.bitcast"(%203) : (vector<4xi8>) -> i32
    %205 = "rocdl.cvt.scalef32.pk.f32.bf8"(%204, %arg53) <{srcLoHiSel = false}> : (i32, f32) -> vector<2xf32>
    "func.return"(%205) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E5M2>, f32) -> vector<2xf16>, sym_name = "scaled_ext_full_f8e5m2_f16"}> ({
  ^bb0(%arg50: vector<4xf8E5M2>, %arg51: f32):
    %200 = "builtin.unrealized_conversion_cast"(%arg50) : (vector<4xf8E5M2>) -> vector<4xi8>
    %201 = "llvm.bitcast"(%200) : (vector<4xi8>) -> i32
    %202 = "rocdl.cvt.scalef32.pk.f16.bf8"(%201, %arg51) <{srcLoHiSel = false}> : (i32, f32) -> vector<2xf16>
    "func.return"(%202) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E5M2>, f32) -> vector<2xbf16>, sym_name = "scaled_ext_full_f8e5m2_bf16"}> ({
  ^bb0(%arg48: vector<4xf8E5M2>, %arg49: f32):
    %197 = "builtin.unrealized_conversion_cast"(%arg48) : (vector<4xf8E5M2>) -> vector<4xi8>
    %198 = "llvm.bitcast"(%197) : (vector<4xi8>) -> i32
    %199 = "rocdl.cvt.scalef32.pk.bf16.bf8"(%198, %arg49) <{srcLoHiSel = false}> : (i32, f32) -> vector<2xbf16>
    "func.return"(%199) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf8E5M2>, f32) -> vector<2xf32>, sym_name = "scaled_ext_half_f8e5m2_f32"}> ({
  ^bb0(%arg46: vector<2xf8E5M2>, %arg47: f32):
    %187 = "builtin.unrealized_conversion_cast"(%arg46) : (vector<2xf8E5M2>) -> vector<2xi8>
    %188 = "llvm.mlir.zero"() : () -> vector<4xi8>
    %189 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %190 = "llvm.extractelement"(%187, %189) : (vector<2xi8>, i32) -> i8
    %191 = "llvm.insertelement"(%188, %190, %189) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %192 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %193 = "llvm.extractelement"(%187, %192) : (vector<2xi8>, i32) -> i8
    %194 = "llvm.insertelement"(%191, %193, %192) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %195 = "llvm.bitcast"(%194) : (vector<4xi8>) -> i32
    %196 = "rocdl.cvt.scalef32.pk.f32.bf8"(%195, %arg47) <{srcLoHiSel = false}> : (i32, f32) -> vector<2xf32>
    "func.return"(%196) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf8E5M2>, f32) -> vector<2xf16>, sym_name = "scaled_ext_half_f8e5m2_f16"}> ({
  ^bb0(%arg44: vector<2xf8E5M2>, %arg45: f32):
    %177 = "builtin.unrealized_conversion_cast"(%arg44) : (vector<2xf8E5M2>) -> vector<2xi8>
    %178 = "llvm.mlir.zero"() : () -> vector<4xi8>
    %179 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %180 = "llvm.extractelement"(%177, %179) : (vector<2xi8>, i32) -> i8
    %181 = "llvm.insertelement"(%178, %180, %179) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %182 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %183 = "llvm.extractelement"(%177, %182) : (vector<2xi8>, i32) -> i8
    %184 = "llvm.insertelement"(%181, %183, %182) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %185 = "llvm.bitcast"(%184) : (vector<4xi8>) -> i32
    %186 = "rocdl.cvt.scalef32.pk.f16.bf8"(%185, %arg45) <{srcLoHiSel = false}> : (i32, f32) -> vector<2xf16>
    "func.return"(%186) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf8E5M2>, f32) -> vector<2xbf16>, sym_name = "scaled_ext_half_f8e5m2_bf16"}> ({
  ^bb0(%arg42: vector<2xf8E5M2>, %arg43: f32):
    %167 = "builtin.unrealized_conversion_cast"(%arg42) : (vector<2xf8E5M2>) -> vector<2xi8>
    %168 = "llvm.mlir.zero"() : () -> vector<4xi8>
    %169 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %170 = "llvm.extractelement"(%167, %169) : (vector<2xi8>, i32) -> i8
    %171 = "llvm.insertelement"(%168, %170, %169) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %172 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %173 = "llvm.extractelement"(%167, %172) : (vector<2xi8>, i32) -> i8
    %174 = "llvm.insertelement"(%171, %173, %172) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %175 = "llvm.bitcast"(%174) : (vector<4xi8>) -> i32
    %176 = "rocdl.cvt.scalef32.pk.bf16.bf8"(%175, %arg43) <{srcLoHiSel = false}> : (i32, f32) -> vector<2xbf16>
    "func.return"(%176) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf8E5M2>, f32) -> vector<2xf32>, sym_name = "scaled_ext_scalar_f8e5m2_f32"}> ({
  ^bb0(%arg40: vector<2xf8E5M2>, %arg41: f32):
    %157 = "builtin.unrealized_conversion_cast"(%arg40) : (vector<2xf8E5M2>) -> vector<2xi8>
    %158 = "llvm.mlir.zero"() : () -> vector<4xi8>
    %159 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %160 = "llvm.extractelement"(%157, %159) : (vector<2xi8>, i32) -> i8
    %161 = "llvm.insertelement"(%158, %160, %159) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %162 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %163 = "llvm.extractelement"(%157, %162) : (vector<2xi8>, i32) -> i8
    %164 = "llvm.insertelement"(%161, %163, %162) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %165 = "llvm.bitcast"(%164) : (vector<4xi8>) -> i32
    %166 = "rocdl.cvt.scalef32.pk.f32.bf8"(%165, %arg41) <{srcLoHiSel = false}> : (i32, f32) -> vector<2xf32>
    "func.return"(%166) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf8E5M2>, f32) -> vector<2xf16>, sym_name = "scaled_ext_scalar_f8e5m2_f16"}> ({
  ^bb0(%arg38: vector<2xf8E5M2>, %arg39: f32):
    %147 = "builtin.unrealized_conversion_cast"(%arg38) : (vector<2xf8E5M2>) -> vector<2xi8>
    %148 = "llvm.mlir.zero"() : () -> vector<4xi8>
    %149 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %150 = "llvm.extractelement"(%147, %149) : (vector<2xi8>, i32) -> i8
    %151 = "llvm.insertelement"(%148, %150, %149) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %152 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %153 = "llvm.extractelement"(%147, %152) : (vector<2xi8>, i32) -> i8
    %154 = "llvm.insertelement"(%151, %153, %152) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %155 = "llvm.bitcast"(%154) : (vector<4xi8>) -> i32
    %156 = "rocdl.cvt.scalef32.pk.f16.bf8"(%155, %arg39) <{srcLoHiSel = false}> : (i32, f32) -> vector<2xf16>
    "func.return"(%156) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf8E5M2>, f32) -> vector<2xbf16>, sym_name = "scaled_ext_scalar_f8e5m2_bf16"}> ({
  ^bb0(%arg36: vector<2xf8E5M2>, %arg37: f32):
    %137 = "builtin.unrealized_conversion_cast"(%arg36) : (vector<2xf8E5M2>) -> vector<2xi8>
    %138 = "llvm.mlir.zero"() : () -> vector<4xi8>
    %139 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %140 = "llvm.extractelement"(%137, %139) : (vector<2xi8>, i32) -> i8
    %141 = "llvm.insertelement"(%138, %140, %139) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %142 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %143 = "llvm.extractelement"(%137, %142) : (vector<2xi8>, i32) -> i8
    %144 = "llvm.insertelement"(%141, %143, %142) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %145 = "llvm.bitcast"(%144) : (vector<4xi8>) -> i32
    %146 = "rocdl.cvt.scalef32.pk.bf16.bf8"(%145, %arg37) <{srcLoHiSel = false}> : (i32, f32) -> vector<2xbf16>
    "func.return"(%146) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf4E2M1FN>, f32) -> vector<2xf32>, sym_name = "scaled_ext_full_f4e2m1_f32"}> ({
  ^bb0(%arg34: vector<8xf4E2M1FN>, %arg35: f32):
    %134 = "builtin.unrealized_conversion_cast"(%arg34) : (vector<8xf4E2M1FN>) -> vector<8xi4>
    %135 = "llvm.bitcast"(%134) : (vector<8xi4>) -> i32
    %136 = "rocdl.cvt.scalef32.pk.f32.fp4"(%135, %arg35) <{srcSelIndex = 0 : i32}> : (i32, f32) -> vector<2xf32>
    "func.return"(%136) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf4E2M1FN>, f32) -> vector<2xf16>, sym_name = "scaled_ext_full_f4e2m1_f16"}> ({
  ^bb0(%arg32: vector<8xf4E2M1FN>, %arg33: f32):
    %131 = "builtin.unrealized_conversion_cast"(%arg32) : (vector<8xf4E2M1FN>) -> vector<8xi4>
    %132 = "llvm.bitcast"(%131) : (vector<8xi4>) -> i32
    %133 = "rocdl.cvt.scalef32.pk.f16.fp4"(%132, %arg33) <{srcSelIndex = 0 : i32}> : (i32, f32) -> vector<2xf16>
    "func.return"(%133) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf4E2M1FN>, f32) -> vector<2xbf16>, sym_name = "scaled_ext_full_f4e2m1_bf16"}> ({
  ^bb0(%arg30: vector<8xf4E2M1FN>, %arg31: f32):
    %128 = "builtin.unrealized_conversion_cast"(%arg30) : (vector<8xf4E2M1FN>) -> vector<8xi4>
    %129 = "llvm.bitcast"(%128) : (vector<8xi4>) -> i32
    %130 = "rocdl.cvt.scalef32.pk.bf16.fp4"(%129, %arg31) <{srcSelIndex = 0 : i32}> : (i32, f32) -> vector<2xbf16>
    "func.return"(%130) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf4E2M1FN>, f32) -> vector<2xf32>, sym_name = "scaled_ext_half_f4e2m1_f32"}> ({
  ^bb0(%arg28: vector<8xf4E2M1FN>, %arg29: f32):
    %125 = "builtin.unrealized_conversion_cast"(%arg28) : (vector<8xf4E2M1FN>) -> vector<8xi4>
    %126 = "llvm.bitcast"(%125) : (vector<8xi4>) -> i32
    %127 = "rocdl.cvt.scalef32.pk.f32.fp4"(%126, %arg29) <{srcSelIndex = 0 : i32}> : (i32, f32) -> vector<2xf32>
    "func.return"(%127) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf4E2M1FN>, f32) -> vector<2xf16>, sym_name = "scaled_ext_half_f4e2m1_f16"}> ({
  ^bb0(%arg26: vector<4xf4E2M1FN>, %arg27: f32):
    %109 = "builtin.unrealized_conversion_cast"(%arg26) : (vector<4xf4E2M1FN>) -> vector<4xi4>
    %110 = "llvm.mlir.zero"() : () -> vector<8xi4>
    %111 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %112 = "llvm.extractelement"(%109, %111) : (vector<4xi4>, i32) -> i4
    %113 = "llvm.insertelement"(%110, %112, %111) : (vector<8xi4>, i4, i32) -> vector<8xi4>
    %114 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %115 = "llvm.extractelement"(%109, %114) : (vector<4xi4>, i32) -> i4
    %116 = "llvm.insertelement"(%113, %115, %114) : (vector<8xi4>, i4, i32) -> vector<8xi4>
    %117 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %118 = "llvm.extractelement"(%109, %117) : (vector<4xi4>, i32) -> i4
    %119 = "llvm.insertelement"(%116, %118, %117) : (vector<8xi4>, i4, i32) -> vector<8xi4>
    %120 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
    %121 = "llvm.extractelement"(%109, %120) : (vector<4xi4>, i32) -> i4
    %122 = "llvm.insertelement"(%119, %121, %120) : (vector<8xi4>, i4, i32) -> vector<8xi4>
    %123 = "llvm.bitcast"(%122) : (vector<8xi4>) -> i32
    %124 = "rocdl.cvt.scalef32.pk.f16.fp4"(%123, %arg27) <{srcSelIndex = 0 : i32}> : (i32, f32) -> vector<2xf16>
    "func.return"(%124) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf4E2M1FN>, f32) -> vector<2xbf16>, sym_name = "scaled_ext_half_f4e2m1_bf16"}> ({
  ^bb0(%arg24: vector<4xf4E2M1FN>, %arg25: f32):
    %93 = "builtin.unrealized_conversion_cast"(%arg24) : (vector<4xf4E2M1FN>) -> vector<4xi4>
    %94 = "llvm.mlir.zero"() : () -> vector<8xi4>
    %95 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %96 = "llvm.extractelement"(%93, %95) : (vector<4xi4>, i32) -> i4
    %97 = "llvm.insertelement"(%94, %96, %95) : (vector<8xi4>, i4, i32) -> vector<8xi4>
    %98 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %99 = "llvm.extractelement"(%93, %98) : (vector<4xi4>, i32) -> i4
    %100 = "llvm.insertelement"(%97, %99, %98) : (vector<8xi4>, i4, i32) -> vector<8xi4>
    %101 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %102 = "llvm.extractelement"(%93, %101) : (vector<4xi4>, i32) -> i4
    %103 = "llvm.insertelement"(%100, %102, %101) : (vector<8xi4>, i4, i32) -> vector<8xi4>
    %104 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
    %105 = "llvm.extractelement"(%93, %104) : (vector<4xi4>, i32) -> i4
    %106 = "llvm.insertelement"(%103, %105, %104) : (vector<8xi4>, i4, i32) -> vector<8xi4>
    %107 = "llvm.bitcast"(%106) : (vector<8xi4>) -> i32
    %108 = "rocdl.cvt.scalef32.pk.bf16.fp4"(%107, %arg25) <{srcSelIndex = 0 : i32}> : (i32, f32) -> vector<2xbf16>
    "func.return"(%108) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf4E2M1FN>, f32) -> vector<2xf32>, sym_name = "scaled_ext_scalar_f4e2m1_f32"}> ({
  ^bb0(%arg22: vector<2xf4E2M1FN>, %arg23: f32):
    %83 = "builtin.unrealized_conversion_cast"(%arg22) : (vector<2xf4E2M1FN>) -> vector<2xi4>
    %84 = "llvm.mlir.zero"() : () -> vector<8xi4>
    %85 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %86 = "llvm.extractelement"(%83, %85) : (vector<2xi4>, i32) -> i4
    %87 = "llvm.insertelement"(%84, %86, %85) : (vector<8xi4>, i4, i32) -> vector<8xi4>
    %88 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %89 = "llvm.extractelement"(%83, %88) : (vector<2xi4>, i32) -> i4
    %90 = "llvm.insertelement"(%87, %89, %88) : (vector<8xi4>, i4, i32) -> vector<8xi4>
    %91 = "llvm.bitcast"(%90) : (vector<8xi4>) -> i32
    %92 = "rocdl.cvt.scalef32.pk.f32.fp4"(%91, %arg23) <{srcSelIndex = 0 : i32}> : (i32, f32) -> vector<2xf32>
    "func.return"(%92) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf4E2M1FN>, f32) -> vector<2xf16>, sym_name = "scaled_ext_scalar_f4e2m1_f16"}> ({
  ^bb0(%arg20: vector<2xf4E2M1FN>, %arg21: f32):
    %73 = "builtin.unrealized_conversion_cast"(%arg20) : (vector<2xf4E2M1FN>) -> vector<2xi4>
    %74 = "llvm.mlir.zero"() : () -> vector<8xi4>
    %75 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %76 = "llvm.extractelement"(%73, %75) : (vector<2xi4>, i32) -> i4
    %77 = "llvm.insertelement"(%74, %76, %75) : (vector<8xi4>, i4, i32) -> vector<8xi4>
    %78 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %79 = "llvm.extractelement"(%73, %78) : (vector<2xi4>, i32) -> i4
    %80 = "llvm.insertelement"(%77, %79, %78) : (vector<8xi4>, i4, i32) -> vector<8xi4>
    %81 = "llvm.bitcast"(%80) : (vector<8xi4>) -> i32
    %82 = "rocdl.cvt.scalef32.pk.f16.fp4"(%81, %arg21) <{srcSelIndex = 0 : i32}> : (i32, f32) -> vector<2xf16>
    "func.return"(%82) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf4E2M1FN>, f32) -> vector<2xbf16>, sym_name = "scaled_ext_scalar_f4e2m1_bf16"}> ({
  ^bb0(%arg18: vector<2xf4E2M1FN>, %arg19: f32):
    %63 = "builtin.unrealized_conversion_cast"(%arg18) : (vector<2xf4E2M1FN>) -> vector<2xi4>
    %64 = "llvm.mlir.zero"() : () -> vector<8xi4>
    %65 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %66 = "llvm.extractelement"(%63, %65) : (vector<2xi4>, i32) -> i4
    %67 = "llvm.insertelement"(%64, %66, %65) : (vector<8xi4>, i4, i32) -> vector<8xi4>
    %68 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %69 = "llvm.extractelement"(%63, %68) : (vector<2xi4>, i32) -> i4
    %70 = "llvm.insertelement"(%67, %69, %68) : (vector<8xi4>, i4, i32) -> vector<8xi4>
    %71 = "llvm.bitcast"(%70) : (vector<8xi4>) -> i32
    %72 = "rocdl.cvt.scalef32.pk.bf16.fp4"(%71, %arg19) <{srcSelIndex = 0 : i32}> : (i32, f32) -> vector<2xbf16>
    "func.return"(%72) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf8E4M3FN>, f32) -> vector<2xf32>, sym_name = "scaled_ext_one_f8e4m3_f32"}> ({
  ^bb0(%arg16: vector<1xf8E4M3FN>, %arg17: f32):
    %56 = "builtin.unrealized_conversion_cast"(%arg16) : (vector<1xf8E4M3FN>) -> vector<1xi8>
    %57 = "llvm.mlir.zero"() : () -> vector<4xi8>
    %58 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %59 = "llvm.extractelement"(%56, %58) : (vector<1xi8>, i32) -> i8
    %60 = "llvm.insertelement"(%57, %59, %58) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %61 = "llvm.bitcast"(%60) : (vector<4xi8>) -> i32
    %62 = "rocdl.cvt.scalef32.pk.f32.fp8"(%61, %arg17) <{srcLoHiSel = false}> : (i32, f32) -> vector<2xf32>
    "func.return"(%62) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf8E4M3FN>, f32) -> vector<2xf16>, sym_name = "scaled_ext_one_f8e4m3_f16"}> ({
  ^bb0(%arg14: vector<1xf8E4M3FN>, %arg15: f32):
    %49 = "builtin.unrealized_conversion_cast"(%arg14) : (vector<1xf8E4M3FN>) -> vector<1xi8>
    %50 = "llvm.mlir.zero"() : () -> vector<4xi8>
    %51 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %52 = "llvm.extractelement"(%49, %51) : (vector<1xi8>, i32) -> i8
    %53 = "llvm.insertelement"(%50, %52, %51) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %54 = "llvm.bitcast"(%53) : (vector<4xi8>) -> i32
    %55 = "rocdl.cvt.scalef32.pk.f16.fp8"(%54, %arg15) <{srcLoHiSel = false}> : (i32, f32) -> vector<2xf16>
    "func.return"(%55) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf8E4M3FN>, f32) -> vector<2xbf16>, sym_name = "scaled_ext_one_f8e4m3_bf16"}> ({
  ^bb0(%arg12: vector<1xf8E4M3FN>, %arg13: f32):
    %42 = "builtin.unrealized_conversion_cast"(%arg12) : (vector<1xf8E4M3FN>) -> vector<1xi8>
    %43 = "llvm.mlir.zero"() : () -> vector<4xi8>
    %44 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %45 = "llvm.extractelement"(%42, %44) : (vector<1xi8>, i32) -> i8
    %46 = "llvm.insertelement"(%43, %45, %44) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %47 = "llvm.bitcast"(%46) : (vector<4xi8>) -> i32
    %48 = "rocdl.cvt.scalef32.pk.bf16.fp8"(%47, %arg13) <{srcLoHiSel = false}> : (i32, f32) -> vector<2xbf16>
    "func.return"(%48) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf8E5M2>, f32) -> vector<2xf32>, sym_name = "scaled_ext_one_f8e5m2_f32"}> ({
  ^bb0(%arg10: vector<1xf8E5M2>, %arg11: f32):
    %35 = "builtin.unrealized_conversion_cast"(%arg10) : (vector<1xf8E5M2>) -> vector<1xi8>
    %36 = "llvm.mlir.zero"() : () -> vector<4xi8>
    %37 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %38 = "llvm.extractelement"(%35, %37) : (vector<1xi8>, i32) -> i8
    %39 = "llvm.insertelement"(%36, %38, %37) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %40 = "llvm.bitcast"(%39) : (vector<4xi8>) -> i32
    %41 = "rocdl.cvt.scalef32.pk.f32.bf8"(%40, %arg11) <{srcLoHiSel = false}> : (i32, f32) -> vector<2xf32>
    "func.return"(%41) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf8E5M2>, f32) -> vector<2xf16>, sym_name = "scaled_ext_one_f8e5m2_f16"}> ({
  ^bb0(%arg8: vector<1xf8E5M2>, %arg9: f32):
    %28 = "builtin.unrealized_conversion_cast"(%arg8) : (vector<1xf8E5M2>) -> vector<1xi8>
    %29 = "llvm.mlir.zero"() : () -> vector<4xi8>
    %30 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %31 = "llvm.extractelement"(%28, %30) : (vector<1xi8>, i32) -> i8
    %32 = "llvm.insertelement"(%29, %31, %30) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %33 = "llvm.bitcast"(%32) : (vector<4xi8>) -> i32
    %34 = "rocdl.cvt.scalef32.pk.f16.bf8"(%33, %arg9) <{srcLoHiSel = false}> : (i32, f32) -> vector<2xf16>
    "func.return"(%34) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf8E5M2>, f32) -> vector<2xbf16>, sym_name = "scaled_ext_one_f8e5m2_bf16"}> ({
  ^bb0(%arg6: vector<1xf8E5M2>, %arg7: f32):
    %21 = "builtin.unrealized_conversion_cast"(%arg6) : (vector<1xf8E5M2>) -> vector<1xi8>
    %22 = "llvm.mlir.zero"() : () -> vector<4xi8>
    %23 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %24 = "llvm.extractelement"(%21, %23) : (vector<1xi8>, i32) -> i8
    %25 = "llvm.insertelement"(%22, %24, %23) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %26 = "llvm.bitcast"(%25) : (vector<4xi8>) -> i32
    %27 = "rocdl.cvt.scalef32.pk.bf16.bf8"(%26, %arg7) <{srcLoHiSel = false}> : (i32, f32) -> vector<2xbf16>
    "func.return"(%27) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf4E2M1FN>, f32) -> vector<2xf32>, sym_name = "scaled_ext_one_f4e2m1_f32"}> ({
  ^bb0(%arg4: vector<1xf4E2M1FN>, %arg5: f32):
    %14 = "builtin.unrealized_conversion_cast"(%arg4) : (vector<1xf4E2M1FN>) -> vector<1xi4>
    %15 = "llvm.mlir.zero"() : () -> vector<8xi4>
    %16 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %17 = "llvm.extractelement"(%14, %16) : (vector<1xi4>, i32) -> i4
    %18 = "llvm.insertelement"(%15, %17, %16) : (vector<8xi4>, i4, i32) -> vector<8xi4>
    %19 = "llvm.bitcast"(%18) : (vector<8xi4>) -> i32
    %20 = "rocdl.cvt.scalef32.pk.f32.fp4"(%19, %arg5) <{srcSelIndex = 0 : i32}> : (i32, f32) -> vector<2xf32>
    "func.return"(%20) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf4E2M1FN>, f32) -> vector<2xf16>, sym_name = "scaled_ext_one_f4e2m1_f16"}> ({
  ^bb0(%arg2: vector<1xf4E2M1FN>, %arg3: f32):
    %7 = "builtin.unrealized_conversion_cast"(%arg2) : (vector<1xf4E2M1FN>) -> vector<1xi4>
    %8 = "llvm.mlir.zero"() : () -> vector<8xi4>
    %9 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %10 = "llvm.extractelement"(%7, %9) : (vector<1xi4>, i32) -> i4
    %11 = "llvm.insertelement"(%8, %10, %9) : (vector<8xi4>, i4, i32) -> vector<8xi4>
    %12 = "llvm.bitcast"(%11) : (vector<8xi4>) -> i32
    %13 = "rocdl.cvt.scalef32.pk.f16.fp4"(%12, %arg3) <{srcSelIndex = 0 : i32}> : (i32, f32) -> vector<2xf16>
    "func.return"(%13) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf4E2M1FN>, f32) -> vector<2xbf16>, sym_name = "scaled_ext_one_f4e2m1_bf16"}> ({
  ^bb0(%arg0: vector<1xf4E2M1FN>, %arg1: f32):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<1xf4E2M1FN>) -> vector<1xi4>
    %1 = "llvm.mlir.zero"() : () -> vector<8xi4>
    %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "llvm.extractelement"(%0, %2) : (vector<1xi4>, i32) -> i4
    %4 = "llvm.insertelement"(%1, %3, %2) : (vector<8xi4>, i4, i32) -> vector<8xi4>
    %5 = "llvm.bitcast"(%4) : (vector<8xi4>) -> i32
    %6 = "rocdl.cvt.scalef32.pk.bf16.fp4"(%5, %arg1) <{srcSelIndex = 0 : i32}> : (i32, f32) -> vector<2xbf16>
    "func.return"(%6) : (vector<2xbf16>) -> ()
  }) : () -> ()
}) : () -> ()

