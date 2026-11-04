"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, f32) -> vector<4xf8E4M3FN>, sym_name = "packed_scaled_trunc_f8e4m3_f32"}> ({
  ^bb0(%arg88: vector<2xf32>, %arg89: f32):
    %274 = "llvm.mlir.zero"() : () -> vector<2xi16>
    %275 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %276 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %277 = "llvm.extractelement"(%arg88, %275) : (vector<2xf32>, i32) -> f32
    %278 = "llvm.extractelement"(%arg88, %276) : (vector<2xf32>, i32) -> f32
    %279 = "rocdl.cvt.scalef32.pk.fp8.f32"(%274, %277, %278, %arg89) <{dstLoHiSel = false}> : (vector<2xi16>, f32, f32, f32) -> vector<2xi16>
    %280 = "llvm.bitcast"(%279) : (vector<2xi16>) -> vector<4xi8>
    %281 = "builtin.unrealized_conversion_cast"(%280) : (vector<4xi8>) -> vector<4xf8E4M3FN>
    "func.return"(%281) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf32>, f32) -> vector<4xf8E4M3FN>, sym_name = "packed_scaled_trunc_f8e4m3_f32_vec1"}> ({
  ^bb0(%arg86: vector<1xf32>, %arg87: f32):
    %262 = "llvm.mlir.zero"() : () -> vector<2xi16>
    %263 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %264 = "llvm.extractelement"(%arg86, %263) : (vector<1xf32>, i32) -> f32
    %265 = "llvm.mlir.zero"() : () -> vector<2xf32>
    %266 = "llvm.insertelement"(%265, %264, %263) : (vector<2xf32>, f32, i32) -> vector<2xf32>
    %267 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %268 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %269 = "llvm.extractelement"(%266, %267) : (vector<2xf32>, i32) -> f32
    %270 = "llvm.extractelement"(%266, %268) : (vector<2xf32>, i32) -> f32
    %271 = "rocdl.cvt.scalef32.pk.fp8.f32"(%262, %269, %270, %arg87) <{dstLoHiSel = false}> : (vector<2xi16>, f32, f32, f32) -> vector<2xi16>
    %272 = "llvm.bitcast"(%271) : (vector<2xi16>) -> vector<4xi8>
    %273 = "builtin.unrealized_conversion_cast"(%272) : (vector<4xi8>) -> vector<4xf8E4M3FN>
    "func.return"(%273) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<4xf8E4M3FN>, f32) -> vector<4xf8E4M3FN>, sym_name = "packed_scaled_trunc_into_f8e4m3_f32"}> ({
  ^bb0(%arg83: vector<2xf32>, %arg84: vector<4xf8E4M3FN>, %arg85: f32):
    %253 = "builtin.unrealized_conversion_cast"(%arg84) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %254 = "llvm.bitcast"(%253) : (vector<4xi8>) -> vector<2xi16>
    %255 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %256 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %257 = "llvm.extractelement"(%arg83, %255) : (vector<2xf32>, i32) -> f32
    %258 = "llvm.extractelement"(%arg83, %256) : (vector<2xf32>, i32) -> f32
    %259 = "rocdl.cvt.scalef32.pk.fp8.f32"(%254, %257, %258, %arg85) <{dstLoHiSel = false}> : (vector<2xi16>, f32, f32, f32) -> vector<2xi16>
    %260 = "llvm.bitcast"(%259) : (vector<2xi16>) -> vector<4xi8>
    %261 = "builtin.unrealized_conversion_cast"(%260) : (vector<4xi8>) -> vector<4xf8E4M3FN>
    "func.return"(%261) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf32>, vector<4xf8E4M3FN>, f32) -> vector<4xf8E4M3FN>, sym_name = "packed_scaled_trunc_into_f8e4m3_f32_vec1"}> ({
  ^bb0(%arg80: vector<1xf32>, %arg81: vector<4xf8E4M3FN>, %arg82: f32):
    %240 = "builtin.unrealized_conversion_cast"(%arg81) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %241 = "llvm.bitcast"(%240) : (vector<4xi8>) -> vector<2xi16>
    %242 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %243 = "llvm.extractelement"(%arg80, %242) : (vector<1xf32>, i32) -> f32
    %244 = "llvm.mlir.zero"() : () -> vector<2xf32>
    %245 = "llvm.insertelement"(%244, %243, %242) : (vector<2xf32>, f32, i32) -> vector<2xf32>
    %246 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %247 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %248 = "llvm.extractelement"(%245, %246) : (vector<2xf32>, i32) -> f32
    %249 = "llvm.extractelement"(%245, %247) : (vector<2xf32>, i32) -> f32
    %250 = "rocdl.cvt.scalef32.pk.fp8.f32"(%241, %248, %249, %arg82) <{dstLoHiSel = false}> : (vector<2xi16>, f32, f32, f32) -> vector<2xi16>
    %251 = "llvm.bitcast"(%250) : (vector<2xi16>) -> vector<4xi8>
    %252 = "builtin.unrealized_conversion_cast"(%251) : (vector<4xi8>) -> vector<4xf8E4M3FN>
    "func.return"(%252) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf16>, f32) -> vector<4xf8E4M3FN>, sym_name = "packed_scaled_trunc_f8e4m3_f16"}> ({
  ^bb0(%arg78: vector<2xf16>, %arg79: f32):
    %236 = "llvm.mlir.zero"() : () -> vector<2xi16>
    %237 = "rocdl.cvt.scalef32.pk.fp8.f16"(%236, %arg78, %arg79) <{dstLoHiSel = false}> : (vector<2xi16>, vector<2xf16>, f32) -> vector<2xi16>
    %238 = "llvm.bitcast"(%237) : (vector<2xi16>) -> vector<4xi8>
    %239 = "builtin.unrealized_conversion_cast"(%238) : (vector<4xi8>) -> vector<4xf8E4M3FN>
    "func.return"(%239) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf16>, f32) -> vector<4xf8E4M3FN>, sym_name = "packed_scaled_trunc_f8e4m3_f16_vec1"}> ({
  ^bb0(%arg76: vector<1xf16>, %arg77: f32):
    %228 = "llvm.mlir.zero"() : () -> vector<2xi16>
    %229 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %230 = "llvm.extractelement"(%arg76, %229) : (vector<1xf16>, i32) -> f16
    %231 = "llvm.mlir.zero"() : () -> vector<2xf16>
    %232 = "llvm.insertelement"(%231, %230, %229) : (vector<2xf16>, f16, i32) -> vector<2xf16>
    %233 = "rocdl.cvt.scalef32.pk.fp8.f16"(%228, %232, %arg77) <{dstLoHiSel = false}> : (vector<2xi16>, vector<2xf16>, f32) -> vector<2xi16>
    %234 = "llvm.bitcast"(%233) : (vector<2xi16>) -> vector<4xi8>
    %235 = "builtin.unrealized_conversion_cast"(%234) : (vector<4xi8>) -> vector<4xf8E4M3FN>
    "func.return"(%235) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf16>, vector<4xf8E4M3FN>, f32) -> vector<4xf8E4M3FN>, sym_name = "packed_scaled_trunc_into_f8e4m3_f16"}> ({
  ^bb0(%arg73: vector<2xf16>, %arg74: vector<4xf8E4M3FN>, %arg75: f32):
    %223 = "builtin.unrealized_conversion_cast"(%arg74) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %224 = "llvm.bitcast"(%223) : (vector<4xi8>) -> vector<2xi16>
    %225 = "rocdl.cvt.scalef32.pk.fp8.f16"(%224, %arg73, %arg75) <{dstLoHiSel = false}> : (vector<2xi16>, vector<2xf16>, f32) -> vector<2xi16>
    %226 = "llvm.bitcast"(%225) : (vector<2xi16>) -> vector<4xi8>
    %227 = "builtin.unrealized_conversion_cast"(%226) : (vector<4xi8>) -> vector<4xf8E4M3FN>
    "func.return"(%227) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf16>, vector<4xf8E4M3FN>, f32) -> vector<4xf8E4M3FN>, sym_name = "packed_scaled_trunc_into_f8e4m3_f16_vec1"}> ({
  ^bb0(%arg70: vector<1xf16>, %arg71: vector<4xf8E4M3FN>, %arg72: f32):
    %214 = "builtin.unrealized_conversion_cast"(%arg71) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %215 = "llvm.bitcast"(%214) : (vector<4xi8>) -> vector<2xi16>
    %216 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %217 = "llvm.extractelement"(%arg70, %216) : (vector<1xf16>, i32) -> f16
    %218 = "llvm.mlir.zero"() : () -> vector<2xf16>
    %219 = "llvm.insertelement"(%218, %217, %216) : (vector<2xf16>, f16, i32) -> vector<2xf16>
    %220 = "rocdl.cvt.scalef32.pk.fp8.f16"(%215, %219, %arg72) <{dstLoHiSel = false}> : (vector<2xi16>, vector<2xf16>, f32) -> vector<2xi16>
    %221 = "llvm.bitcast"(%220) : (vector<2xi16>) -> vector<4xi8>
    %222 = "builtin.unrealized_conversion_cast"(%221) : (vector<4xi8>) -> vector<4xf8E4M3FN>
    "func.return"(%222) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xbf16>, f32) -> vector<4xf8E4M3FN>, sym_name = "packed_scaled_trunc_f8e4m3_bf16"}> ({
  ^bb0(%arg68: vector<2xbf16>, %arg69: f32):
    %210 = "llvm.mlir.zero"() : () -> vector<2xi16>
    %211 = "rocdl.cvt.scalef32.pk.fp8.bf16"(%210, %arg68, %arg69) <{dstLoHiSel = false}> : (vector<2xi16>, vector<2xbf16>, f32) -> vector<2xi16>
    %212 = "llvm.bitcast"(%211) : (vector<2xi16>) -> vector<4xi8>
    %213 = "builtin.unrealized_conversion_cast"(%212) : (vector<4xi8>) -> vector<4xf8E4M3FN>
    "func.return"(%213) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xbf16>, f32) -> vector<4xf8E4M3FN>, sym_name = "packed_scaled_trunc_f8e4m3_bf16_vec1"}> ({
  ^bb0(%arg66: vector<1xbf16>, %arg67: f32):
    %202 = "llvm.mlir.zero"() : () -> vector<2xi16>
    %203 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %204 = "llvm.extractelement"(%arg66, %203) : (vector<1xbf16>, i32) -> bf16
    %205 = "llvm.mlir.zero"() : () -> vector<2xbf16>
    %206 = "llvm.insertelement"(%205, %204, %203) : (vector<2xbf16>, bf16, i32) -> vector<2xbf16>
    %207 = "rocdl.cvt.scalef32.pk.fp8.bf16"(%202, %206, %arg67) <{dstLoHiSel = false}> : (vector<2xi16>, vector<2xbf16>, f32) -> vector<2xi16>
    %208 = "llvm.bitcast"(%207) : (vector<2xi16>) -> vector<4xi8>
    %209 = "builtin.unrealized_conversion_cast"(%208) : (vector<4xi8>) -> vector<4xf8E4M3FN>
    "func.return"(%209) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xbf16>, vector<4xf8E4M3FN>, f32) -> vector<4xf8E4M3FN>, sym_name = "packed_scaled_trunc_into_f8e4m3_bf16"}> ({
  ^bb0(%arg63: vector<2xbf16>, %arg64: vector<4xf8E4M3FN>, %arg65: f32):
    %197 = "builtin.unrealized_conversion_cast"(%arg64) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %198 = "llvm.bitcast"(%197) : (vector<4xi8>) -> vector<2xi16>
    %199 = "rocdl.cvt.scalef32.pk.fp8.bf16"(%198, %arg63, %arg65) <{dstLoHiSel = false}> : (vector<2xi16>, vector<2xbf16>, f32) -> vector<2xi16>
    %200 = "llvm.bitcast"(%199) : (vector<2xi16>) -> vector<4xi8>
    %201 = "builtin.unrealized_conversion_cast"(%200) : (vector<4xi8>) -> vector<4xf8E4M3FN>
    "func.return"(%201) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xbf16>, vector<4xf8E4M3FN>, f32) -> vector<4xf8E4M3FN>, sym_name = "packed_scaled_trunc_into_f8e4m3_bf16_vec1"}> ({
  ^bb0(%arg60: vector<1xbf16>, %arg61: vector<4xf8E4M3FN>, %arg62: f32):
    %188 = "builtin.unrealized_conversion_cast"(%arg61) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %189 = "llvm.bitcast"(%188) : (vector<4xi8>) -> vector<2xi16>
    %190 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %191 = "llvm.extractelement"(%arg60, %190) : (vector<1xbf16>, i32) -> bf16
    %192 = "llvm.mlir.zero"() : () -> vector<2xbf16>
    %193 = "llvm.insertelement"(%192, %191, %190) : (vector<2xbf16>, bf16, i32) -> vector<2xbf16>
    %194 = "rocdl.cvt.scalef32.pk.fp8.bf16"(%189, %193, %arg62) <{dstLoHiSel = false}> : (vector<2xi16>, vector<2xbf16>, f32) -> vector<2xi16>
    %195 = "llvm.bitcast"(%194) : (vector<2xi16>) -> vector<4xi8>
    %196 = "builtin.unrealized_conversion_cast"(%195) : (vector<4xi8>) -> vector<4xf8E4M3FN>
    "func.return"(%196) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, f32) -> vector<4xf8E5M2>, sym_name = "packed_scaled_trunc_f8e5m2_f32"}> ({
  ^bb0(%arg58: vector<2xf32>, %arg59: f32):
    %180 = "llvm.mlir.zero"() : () -> vector<2xi16>
    %181 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %182 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %183 = "llvm.extractelement"(%arg58, %181) : (vector<2xf32>, i32) -> f32
    %184 = "llvm.extractelement"(%arg58, %182) : (vector<2xf32>, i32) -> f32
    %185 = "rocdl.cvt.scalef32.pk.bf8.f32"(%180, %183, %184, %arg59) <{dstLoHiSel = false}> : (vector<2xi16>, f32, f32, f32) -> vector<2xi16>
    %186 = "llvm.bitcast"(%185) : (vector<2xi16>) -> vector<4xi8>
    %187 = "builtin.unrealized_conversion_cast"(%186) : (vector<4xi8>) -> vector<4xf8E5M2>
    "func.return"(%187) : (vector<4xf8E5M2>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf32>, f32) -> vector<4xf8E5M2>, sym_name = "packed_scaled_trunc_f8e5m2_f32_vec1"}> ({
  ^bb0(%arg56: vector<1xf32>, %arg57: f32):
    %168 = "llvm.mlir.zero"() : () -> vector<2xi16>
    %169 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %170 = "llvm.extractelement"(%arg56, %169) : (vector<1xf32>, i32) -> f32
    %171 = "llvm.mlir.zero"() : () -> vector<2xf32>
    %172 = "llvm.insertelement"(%171, %170, %169) : (vector<2xf32>, f32, i32) -> vector<2xf32>
    %173 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %174 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %175 = "llvm.extractelement"(%172, %173) : (vector<2xf32>, i32) -> f32
    %176 = "llvm.extractelement"(%172, %174) : (vector<2xf32>, i32) -> f32
    %177 = "rocdl.cvt.scalef32.pk.bf8.f32"(%168, %175, %176, %arg57) <{dstLoHiSel = false}> : (vector<2xi16>, f32, f32, f32) -> vector<2xi16>
    %178 = "llvm.bitcast"(%177) : (vector<2xi16>) -> vector<4xi8>
    %179 = "builtin.unrealized_conversion_cast"(%178) : (vector<4xi8>) -> vector<4xf8E5M2>
    "func.return"(%179) : (vector<4xf8E5M2>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<4xf8E5M2>, f32) -> vector<4xf8E5M2>, sym_name = "packed_scaled_trunc_into_f8e5m2_f32"}> ({
  ^bb0(%arg53: vector<2xf32>, %arg54: vector<4xf8E5M2>, %arg55: f32):
    %159 = "builtin.unrealized_conversion_cast"(%arg54) : (vector<4xf8E5M2>) -> vector<4xi8>
    %160 = "llvm.bitcast"(%159) : (vector<4xi8>) -> vector<2xi16>
    %161 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %162 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %163 = "llvm.extractelement"(%arg53, %161) : (vector<2xf32>, i32) -> f32
    %164 = "llvm.extractelement"(%arg53, %162) : (vector<2xf32>, i32) -> f32
    %165 = "rocdl.cvt.scalef32.pk.bf8.f32"(%160, %163, %164, %arg55) <{dstLoHiSel = false}> : (vector<2xi16>, f32, f32, f32) -> vector<2xi16>
    %166 = "llvm.bitcast"(%165) : (vector<2xi16>) -> vector<4xi8>
    %167 = "builtin.unrealized_conversion_cast"(%166) : (vector<4xi8>) -> vector<4xf8E5M2>
    "func.return"(%167) : (vector<4xf8E5M2>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf32>, vector<4xf8E5M2>, f32) -> vector<4xf8E5M2>, sym_name = "packed_scaled_trunc_into_f8e5m2_f32_vec1"}> ({
  ^bb0(%arg50: vector<1xf32>, %arg51: vector<4xf8E5M2>, %arg52: f32):
    %146 = "builtin.unrealized_conversion_cast"(%arg51) : (vector<4xf8E5M2>) -> vector<4xi8>
    %147 = "llvm.bitcast"(%146) : (vector<4xi8>) -> vector<2xi16>
    %148 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %149 = "llvm.extractelement"(%arg50, %148) : (vector<1xf32>, i32) -> f32
    %150 = "llvm.mlir.zero"() : () -> vector<2xf32>
    %151 = "llvm.insertelement"(%150, %149, %148) : (vector<2xf32>, f32, i32) -> vector<2xf32>
    %152 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %153 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %154 = "llvm.extractelement"(%151, %152) : (vector<2xf32>, i32) -> f32
    %155 = "llvm.extractelement"(%151, %153) : (vector<2xf32>, i32) -> f32
    %156 = "rocdl.cvt.scalef32.pk.bf8.f32"(%147, %154, %155, %arg52) <{dstLoHiSel = false}> : (vector<2xi16>, f32, f32, f32) -> vector<2xi16>
    %157 = "llvm.bitcast"(%156) : (vector<2xi16>) -> vector<4xi8>
    %158 = "builtin.unrealized_conversion_cast"(%157) : (vector<4xi8>) -> vector<4xf8E5M2>
    "func.return"(%158) : (vector<4xf8E5M2>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf16>, f32) -> vector<4xf8E5M2>, sym_name = "packed_scaled_trunc_f8e5m2_f16"}> ({
  ^bb0(%arg48: vector<2xf16>, %arg49: f32):
    %142 = "llvm.mlir.zero"() : () -> vector<2xi16>
    %143 = "rocdl.cvt.scalef32.pk.bf8.f16"(%142, %arg48, %arg49) <{dstLoHiSel = false}> : (vector<2xi16>, vector<2xf16>, f32) -> vector<2xi16>
    %144 = "llvm.bitcast"(%143) : (vector<2xi16>) -> vector<4xi8>
    %145 = "builtin.unrealized_conversion_cast"(%144) : (vector<4xi8>) -> vector<4xf8E5M2>
    "func.return"(%145) : (vector<4xf8E5M2>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf16>, f32) -> vector<4xf8E5M2>, sym_name = "packed_scaled_trunc_f8e5m2_f16_vec1"}> ({
  ^bb0(%arg46: vector<1xf16>, %arg47: f32):
    %134 = "llvm.mlir.zero"() : () -> vector<2xi16>
    %135 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %136 = "llvm.extractelement"(%arg46, %135) : (vector<1xf16>, i32) -> f16
    %137 = "llvm.mlir.zero"() : () -> vector<2xf16>
    %138 = "llvm.insertelement"(%137, %136, %135) : (vector<2xf16>, f16, i32) -> vector<2xf16>
    %139 = "rocdl.cvt.scalef32.pk.bf8.f16"(%134, %138, %arg47) <{dstLoHiSel = false}> : (vector<2xi16>, vector<2xf16>, f32) -> vector<2xi16>
    %140 = "llvm.bitcast"(%139) : (vector<2xi16>) -> vector<4xi8>
    %141 = "builtin.unrealized_conversion_cast"(%140) : (vector<4xi8>) -> vector<4xf8E5M2>
    "func.return"(%141) : (vector<4xf8E5M2>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf16>, vector<4xf8E5M2>, f32) -> vector<4xf8E5M2>, sym_name = "packed_scaled_trunc_into_f8e5m2_f16"}> ({
  ^bb0(%arg43: vector<2xf16>, %arg44: vector<4xf8E5M2>, %arg45: f32):
    %129 = "builtin.unrealized_conversion_cast"(%arg44) : (vector<4xf8E5M2>) -> vector<4xi8>
    %130 = "llvm.bitcast"(%129) : (vector<4xi8>) -> vector<2xi16>
    %131 = "rocdl.cvt.scalef32.pk.bf8.f16"(%130, %arg43, %arg45) <{dstLoHiSel = false}> : (vector<2xi16>, vector<2xf16>, f32) -> vector<2xi16>
    %132 = "llvm.bitcast"(%131) : (vector<2xi16>) -> vector<4xi8>
    %133 = "builtin.unrealized_conversion_cast"(%132) : (vector<4xi8>) -> vector<4xf8E5M2>
    "func.return"(%133) : (vector<4xf8E5M2>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf16>, vector<4xf8E5M2>, f32) -> vector<4xf8E5M2>, sym_name = "packed_scaled_trunc_into_f8e5m2_f16_vec1"}> ({
  ^bb0(%arg40: vector<1xf16>, %arg41: vector<4xf8E5M2>, %arg42: f32):
    %120 = "builtin.unrealized_conversion_cast"(%arg41) : (vector<4xf8E5M2>) -> vector<4xi8>
    %121 = "llvm.bitcast"(%120) : (vector<4xi8>) -> vector<2xi16>
    %122 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %123 = "llvm.extractelement"(%arg40, %122) : (vector<1xf16>, i32) -> f16
    %124 = "llvm.mlir.zero"() : () -> vector<2xf16>
    %125 = "llvm.insertelement"(%124, %123, %122) : (vector<2xf16>, f16, i32) -> vector<2xf16>
    %126 = "rocdl.cvt.scalef32.pk.bf8.f16"(%121, %125, %arg42) <{dstLoHiSel = false}> : (vector<2xi16>, vector<2xf16>, f32) -> vector<2xi16>
    %127 = "llvm.bitcast"(%126) : (vector<2xi16>) -> vector<4xi8>
    %128 = "builtin.unrealized_conversion_cast"(%127) : (vector<4xi8>) -> vector<4xf8E5M2>
    "func.return"(%128) : (vector<4xf8E5M2>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xbf16>, f32) -> vector<4xf8E5M2>, sym_name = "packed_scaled_trunc_f8e5m2_bf16"}> ({
  ^bb0(%arg38: vector<2xbf16>, %arg39: f32):
    %116 = "llvm.mlir.zero"() : () -> vector<2xi16>
    %117 = "rocdl.cvt.scalef32.pk.bf8.bf16"(%116, %arg38, %arg39) <{dstLoHiSel = false}> : (vector<2xi16>, vector<2xbf16>, f32) -> vector<2xi16>
    %118 = "llvm.bitcast"(%117) : (vector<2xi16>) -> vector<4xi8>
    %119 = "builtin.unrealized_conversion_cast"(%118) : (vector<4xi8>) -> vector<4xf8E5M2>
    "func.return"(%119) : (vector<4xf8E5M2>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xbf16>, f32) -> vector<4xf8E5M2>, sym_name = "packed_scaled_trunc_f8e5m2_bf16_vec1"}> ({
  ^bb0(%arg36: vector<1xbf16>, %arg37: f32):
    %108 = "llvm.mlir.zero"() : () -> vector<2xi16>
    %109 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %110 = "llvm.extractelement"(%arg36, %109) : (vector<1xbf16>, i32) -> bf16
    %111 = "llvm.mlir.zero"() : () -> vector<2xbf16>
    %112 = "llvm.insertelement"(%111, %110, %109) : (vector<2xbf16>, bf16, i32) -> vector<2xbf16>
    %113 = "rocdl.cvt.scalef32.pk.bf8.bf16"(%108, %112, %arg37) <{dstLoHiSel = false}> : (vector<2xi16>, vector<2xbf16>, f32) -> vector<2xi16>
    %114 = "llvm.bitcast"(%113) : (vector<2xi16>) -> vector<4xi8>
    %115 = "builtin.unrealized_conversion_cast"(%114) : (vector<4xi8>) -> vector<4xf8E5M2>
    "func.return"(%115) : (vector<4xf8E5M2>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xbf16>, vector<4xf8E5M2>, f32) -> vector<4xf8E5M2>, sym_name = "packed_scaled_trunc_into_f8e5m2_bf16"}> ({
  ^bb0(%arg33: vector<2xbf16>, %arg34: vector<4xf8E5M2>, %arg35: f32):
    %103 = "builtin.unrealized_conversion_cast"(%arg34) : (vector<4xf8E5M2>) -> vector<4xi8>
    %104 = "llvm.bitcast"(%103) : (vector<4xi8>) -> vector<2xi16>
    %105 = "rocdl.cvt.scalef32.pk.bf8.bf16"(%104, %arg33, %arg35) <{dstLoHiSel = false}> : (vector<2xi16>, vector<2xbf16>, f32) -> vector<2xi16>
    %106 = "llvm.bitcast"(%105) : (vector<2xi16>) -> vector<4xi8>
    %107 = "builtin.unrealized_conversion_cast"(%106) : (vector<4xi8>) -> vector<4xf8E5M2>
    "func.return"(%107) : (vector<4xf8E5M2>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xbf16>, vector<4xf8E5M2>, f32) -> vector<4xf8E5M2>, sym_name = "packed_scaled_trunc_into_f8e5m2_bf16_vec1"}> ({
  ^bb0(%arg30: vector<1xbf16>, %arg31: vector<4xf8E5M2>, %arg32: f32):
    %94 = "builtin.unrealized_conversion_cast"(%arg31) : (vector<4xf8E5M2>) -> vector<4xi8>
    %95 = "llvm.bitcast"(%94) : (vector<4xi8>) -> vector<2xi16>
    %96 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %97 = "llvm.extractelement"(%arg30, %96) : (vector<1xbf16>, i32) -> bf16
    %98 = "llvm.mlir.zero"() : () -> vector<2xbf16>
    %99 = "llvm.insertelement"(%98, %97, %96) : (vector<2xbf16>, bf16, i32) -> vector<2xbf16>
    %100 = "rocdl.cvt.scalef32.pk.bf8.bf16"(%95, %99, %arg32) <{dstLoHiSel = false}> : (vector<2xi16>, vector<2xbf16>, f32) -> vector<2xi16>
    %101 = "llvm.bitcast"(%100) : (vector<2xi16>) -> vector<4xi8>
    %102 = "builtin.unrealized_conversion_cast"(%101) : (vector<4xi8>) -> vector<4xf8E5M2>
    "func.return"(%102) : (vector<4xf8E5M2>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, f32) -> vector<8xf4E2M1FN>, sym_name = "packed_scaled_trunc_f4e2m1_f32"}> ({
  ^bb0(%arg28: vector<2xf32>, %arg29: f32):
    %86 = "llvm.mlir.zero"() : () -> i32
    %87 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %88 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %89 = "llvm.extractelement"(%arg28, %87) : (vector<2xf32>, i32) -> f32
    %90 = "llvm.extractelement"(%arg28, %88) : (vector<2xf32>, i32) -> f32
    %91 = "rocdl.cvt.scalef32.pk.fp4.f32"(%86, %89, %90, %arg29) <{dstSelIndex = 0 : i32}> : (i32, f32, f32, f32) -> i32
    %92 = "llvm.bitcast"(%91) : (i32) -> vector<8xi4>
    %93 = "builtin.unrealized_conversion_cast"(%92) : (vector<8xi4>) -> vector<8xf4E2M1FN>
    "func.return"(%93) : (vector<8xf4E2M1FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf32>, f32) -> vector<8xf4E2M1FN>, sym_name = "packed_scaled_trunc_f4e2m1_f32_vec1"}> ({
  ^bb0(%arg26: vector<1xf32>, %arg27: f32):
    %74 = "llvm.mlir.zero"() : () -> i32
    %75 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %76 = "llvm.extractelement"(%arg26, %75) : (vector<1xf32>, i32) -> f32
    %77 = "llvm.mlir.zero"() : () -> vector<2xf32>
    %78 = "llvm.insertelement"(%77, %76, %75) : (vector<2xf32>, f32, i32) -> vector<2xf32>
    %79 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %80 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %81 = "llvm.extractelement"(%78, %79) : (vector<2xf32>, i32) -> f32
    %82 = "llvm.extractelement"(%78, %80) : (vector<2xf32>, i32) -> f32
    %83 = "rocdl.cvt.scalef32.pk.fp4.f32"(%74, %81, %82, %arg27) <{dstSelIndex = 0 : i32}> : (i32, f32, f32, f32) -> i32
    %84 = "llvm.bitcast"(%83) : (i32) -> vector<8xi4>
    %85 = "builtin.unrealized_conversion_cast"(%84) : (vector<8xi4>) -> vector<8xf4E2M1FN>
    "func.return"(%85) : (vector<8xf4E2M1FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<8xf4E2M1FN>, f32) -> vector<8xf4E2M1FN>, sym_name = "packed_scaled_trunc_into_f4e2m1_f32"}> ({
  ^bb0(%arg23: vector<2xf32>, %arg24: vector<8xf4E2M1FN>, %arg25: f32):
    %65 = "builtin.unrealized_conversion_cast"(%arg24) : (vector<8xf4E2M1FN>) -> vector<8xi4>
    %66 = "llvm.bitcast"(%65) : (vector<8xi4>) -> i32
    %67 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %68 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %69 = "llvm.extractelement"(%arg23, %67) : (vector<2xf32>, i32) -> f32
    %70 = "llvm.extractelement"(%arg23, %68) : (vector<2xf32>, i32) -> f32
    %71 = "rocdl.cvt.scalef32.pk.fp4.f32"(%66, %69, %70, %arg25) <{dstSelIndex = 0 : i32}> : (i32, f32, f32, f32) -> i32
    %72 = "llvm.bitcast"(%71) : (i32) -> vector<8xi4>
    %73 = "builtin.unrealized_conversion_cast"(%72) : (vector<8xi4>) -> vector<8xf4E2M1FN>
    "func.return"(%73) : (vector<8xf4E2M1FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf32>, vector<8xf4E2M1FN>, f32) -> vector<8xf4E2M1FN>, sym_name = "packed_scaled_trunc_into_f4e2m1_f32_vec1"}> ({
  ^bb0(%arg20: vector<1xf32>, %arg21: vector<8xf4E2M1FN>, %arg22: f32):
    %52 = "builtin.unrealized_conversion_cast"(%arg21) : (vector<8xf4E2M1FN>) -> vector<8xi4>
    %53 = "llvm.bitcast"(%52) : (vector<8xi4>) -> i32
    %54 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %55 = "llvm.extractelement"(%arg20, %54) : (vector<1xf32>, i32) -> f32
    %56 = "llvm.mlir.zero"() : () -> vector<2xf32>
    %57 = "llvm.insertelement"(%56, %55, %54) : (vector<2xf32>, f32, i32) -> vector<2xf32>
    %58 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %59 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %60 = "llvm.extractelement"(%57, %58) : (vector<2xf32>, i32) -> f32
    %61 = "llvm.extractelement"(%57, %59) : (vector<2xf32>, i32) -> f32
    %62 = "rocdl.cvt.scalef32.pk.fp4.f32"(%53, %60, %61, %arg22) <{dstSelIndex = 0 : i32}> : (i32, f32, f32, f32) -> i32
    %63 = "llvm.bitcast"(%62) : (i32) -> vector<8xi4>
    %64 = "builtin.unrealized_conversion_cast"(%63) : (vector<8xi4>) -> vector<8xf4E2M1FN>
    "func.return"(%64) : (vector<8xf4E2M1FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf16>, f32) -> vector<8xf4E2M1FN>, sym_name = "packed_scaled_trunc_f4e2m1_f16"}> ({
  ^bb0(%arg18: vector<2xf16>, %arg19: f32):
    %48 = "llvm.mlir.zero"() : () -> i32
    %49 = "rocdl.cvt.scalef32.pk.fp4.f16"(%48, %arg18, %arg19) <{dstSelIndex = 0 : i32}> : (i32, vector<2xf16>, f32) -> i32
    %50 = "llvm.bitcast"(%49) : (i32) -> vector<8xi4>
    %51 = "builtin.unrealized_conversion_cast"(%50) : (vector<8xi4>) -> vector<8xf4E2M1FN>
    "func.return"(%51) : (vector<8xf4E2M1FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf16>, f32) -> vector<8xf4E2M1FN>, sym_name = "packed_scaled_trunc_f4e2m1_f16_vec1"}> ({
  ^bb0(%arg16: vector<1xf16>, %arg17: f32):
    %40 = "llvm.mlir.zero"() : () -> i32
    %41 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %42 = "llvm.extractelement"(%arg16, %41) : (vector<1xf16>, i32) -> f16
    %43 = "llvm.mlir.zero"() : () -> vector<2xf16>
    %44 = "llvm.insertelement"(%43, %42, %41) : (vector<2xf16>, f16, i32) -> vector<2xf16>
    %45 = "rocdl.cvt.scalef32.pk.fp4.f16"(%40, %44, %arg17) <{dstSelIndex = 0 : i32}> : (i32, vector<2xf16>, f32) -> i32
    %46 = "llvm.bitcast"(%45) : (i32) -> vector<8xi4>
    %47 = "builtin.unrealized_conversion_cast"(%46) : (vector<8xi4>) -> vector<8xf4E2M1FN>
    "func.return"(%47) : (vector<8xf4E2M1FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf16>, vector<8xf4E2M1FN>, f32) -> vector<8xf4E2M1FN>, sym_name = "packed_scaled_trunc_into_f4e2m1_f16"}> ({
  ^bb0(%arg13: vector<2xf16>, %arg14: vector<8xf4E2M1FN>, %arg15: f32):
    %35 = "builtin.unrealized_conversion_cast"(%arg14) : (vector<8xf4E2M1FN>) -> vector<8xi4>
    %36 = "llvm.bitcast"(%35) : (vector<8xi4>) -> i32
    %37 = "rocdl.cvt.scalef32.pk.fp4.f16"(%36, %arg13, %arg15) <{dstSelIndex = 0 : i32}> : (i32, vector<2xf16>, f32) -> i32
    %38 = "llvm.bitcast"(%37) : (i32) -> vector<8xi4>
    %39 = "builtin.unrealized_conversion_cast"(%38) : (vector<8xi4>) -> vector<8xf4E2M1FN>
    "func.return"(%39) : (vector<8xf4E2M1FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf16>, vector<8xf4E2M1FN>, f32) -> vector<8xf4E2M1FN>, sym_name = "packed_scaled_trunc_into_f4e2m1_f16_vec1"}> ({
  ^bb0(%arg10: vector<1xf16>, %arg11: vector<8xf4E2M1FN>, %arg12: f32):
    %26 = "builtin.unrealized_conversion_cast"(%arg11) : (vector<8xf4E2M1FN>) -> vector<8xi4>
    %27 = "llvm.bitcast"(%26) : (vector<8xi4>) -> i32
    %28 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %29 = "llvm.extractelement"(%arg10, %28) : (vector<1xf16>, i32) -> f16
    %30 = "llvm.mlir.zero"() : () -> vector<2xf16>
    %31 = "llvm.insertelement"(%30, %29, %28) : (vector<2xf16>, f16, i32) -> vector<2xf16>
    %32 = "rocdl.cvt.scalef32.pk.fp4.f16"(%27, %31, %arg12) <{dstSelIndex = 0 : i32}> : (i32, vector<2xf16>, f32) -> i32
    %33 = "llvm.bitcast"(%32) : (i32) -> vector<8xi4>
    %34 = "builtin.unrealized_conversion_cast"(%33) : (vector<8xi4>) -> vector<8xf4E2M1FN>
    "func.return"(%34) : (vector<8xf4E2M1FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xbf16>, f32) -> vector<8xf4E2M1FN>, sym_name = "packed_scaled_trunc_f4e2m1_bf16"}> ({
  ^bb0(%arg8: vector<2xbf16>, %arg9: f32):
    %22 = "llvm.mlir.zero"() : () -> i32
    %23 = "rocdl.cvt.scalef32.pk.fp4.bf16"(%22, %arg8, %arg9) <{dstSelIndex = 0 : i32}> : (i32, vector<2xbf16>, f32) -> i32
    %24 = "llvm.bitcast"(%23) : (i32) -> vector<8xi4>
    %25 = "builtin.unrealized_conversion_cast"(%24) : (vector<8xi4>) -> vector<8xf4E2M1FN>
    "func.return"(%25) : (vector<8xf4E2M1FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xbf16>, f32) -> vector<8xf4E2M1FN>, sym_name = "packed_scaled_trunc_f4e2m1_bf16_vec1"}> ({
  ^bb0(%arg6: vector<1xbf16>, %arg7: f32):
    %14 = "llvm.mlir.zero"() : () -> i32
    %15 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %16 = "llvm.extractelement"(%arg6, %15) : (vector<1xbf16>, i32) -> bf16
    %17 = "llvm.mlir.zero"() : () -> vector<2xbf16>
    %18 = "llvm.insertelement"(%17, %16, %15) : (vector<2xbf16>, bf16, i32) -> vector<2xbf16>
    %19 = "rocdl.cvt.scalef32.pk.fp4.bf16"(%14, %18, %arg7) <{dstSelIndex = 0 : i32}> : (i32, vector<2xbf16>, f32) -> i32
    %20 = "llvm.bitcast"(%19) : (i32) -> vector<8xi4>
    %21 = "builtin.unrealized_conversion_cast"(%20) : (vector<8xi4>) -> vector<8xf4E2M1FN>
    "func.return"(%21) : (vector<8xf4E2M1FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xbf16>, vector<8xf4E2M1FN>, f32) -> vector<8xf4E2M1FN>, sym_name = "packed_scaled_trunc_into_f4e2m1_bf16"}> ({
  ^bb0(%arg3: vector<2xbf16>, %arg4: vector<8xf4E2M1FN>, %arg5: f32):
    %9 = "builtin.unrealized_conversion_cast"(%arg4) : (vector<8xf4E2M1FN>) -> vector<8xi4>
    %10 = "llvm.bitcast"(%9) : (vector<8xi4>) -> i32
    %11 = "rocdl.cvt.scalef32.pk.fp4.bf16"(%10, %arg3, %arg5) <{dstSelIndex = 0 : i32}> : (i32, vector<2xbf16>, f32) -> i32
    %12 = "llvm.bitcast"(%11) : (i32) -> vector<8xi4>
    %13 = "builtin.unrealized_conversion_cast"(%12) : (vector<8xi4>) -> vector<8xf4E2M1FN>
    "func.return"(%13) : (vector<8xf4E2M1FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xbf16>, vector<8xf4E2M1FN>, f32) -> vector<8xf4E2M1FN>, sym_name = "packed_scaled_trunc_into_f4e2m1_bf16_vec1"}> ({
  ^bb0(%arg0: vector<1xbf16>, %arg1: vector<8xf4E2M1FN>, %arg2: f32):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<8xf4E2M1FN>) -> vector<8xi4>
    %1 = "llvm.bitcast"(%0) : (vector<8xi4>) -> i32
    %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "llvm.extractelement"(%arg0, %2) : (vector<1xbf16>, i32) -> bf16
    %4 = "llvm.mlir.zero"() : () -> vector<2xbf16>
    %5 = "llvm.insertelement"(%4, %3, %2) : (vector<2xbf16>, bf16, i32) -> vector<2xbf16>
    %6 = "rocdl.cvt.scalef32.pk.fp4.bf16"(%1, %5, %arg2) <{dstSelIndex = 0 : i32}> : (i32, vector<2xbf16>, f32) -> i32
    %7 = "llvm.bitcast"(%6) : (i32) -> vector<8xi4>
    %8 = "builtin.unrealized_conversion_cast"(%7) : (vector<8xi4>) -> vector<8xf4E2M1FN>
    "func.return"(%8) : (vector<8xf4E2M1FN>) -> ()
  }) : () -> ()
}) : () -> ()

