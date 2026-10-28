"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xi8>, memref<?x?xi32>) -> (), sym_name = "muli"}> ({
  ^bb0(%arg11: memref<?x?xi8>, %arg12: memref<?x?xi32>):
    %207 = "builtin.unrealized_conversion_cast"(%arg12) : (memref<?x?xi32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %208 = "builtin.unrealized_conversion_cast"(%arg11) : (memref<?x?xi8>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %209 = "arith.constant"() <{value = 0 : index}> : () -> index
    %210 = "builtin.unrealized_conversion_cast"(%209) : (index) -> i64
    %211 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %212 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %213 = "llvm.call_intrinsic"(%211, %212) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tilezero.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i16, i16) -> !llvm.x86_amx
    %214 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %215 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %216 = "llvm.extractvalue"(%208) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %217 = "llvm.extractvalue"(%208) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %218 = "llvm.mul"(%210, %217) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %219 = "llvm.add"(%218, %210) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %220 = "llvm.getelementptr"(%216, %219) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %221 = "llvm.extractvalue"(%208) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %222 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %223 = "llvm.mul"(%222, %221) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %224 = "llvm.call_intrinsic"(%214, %215, %220, %223) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tileloadd64.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>}> : (i16, i16, !llvm.ptr, i64) -> !llvm.x86_amx
    %225 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %226 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %227 = "llvm.extractvalue"(%207) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %228 = "llvm.extractvalue"(%207) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %229 = "llvm.mul"(%210, %228) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %230 = "llvm.add"(%229, %210) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %231 = "llvm.getelementptr"(%227, %230) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %232 = "llvm.extractvalue"(%207) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %233 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %234 = "llvm.mul"(%233, %232) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %235 = "llvm.call_intrinsic"(%225, %226, %231, %234) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tileloadd64.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>}> : (i16, i16, !llvm.ptr, i64) -> !llvm.x86_amx
    %236 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %237 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %238 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %239 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %240 = "llvm.call_intrinsic"(%236, %239, %237, %235, %213, %224) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tdpbuud.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 6, 0>}> {isZextLhs, isZextRhs} : (i16, i16, i16, !llvm.x86_amx, !llvm.x86_amx, !llvm.x86_amx) -> !llvm.x86_amx
    %241 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %242 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %243 = "llvm.extractvalue"(%207) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %244 = "llvm.extractvalue"(%207) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %245 = "llvm.mul"(%210, %244) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %246 = "llvm.add"(%245, %210) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %247 = "llvm.getelementptr"(%243, %246) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %248 = "llvm.extractvalue"(%207) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %249 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %250 = "llvm.mul"(%249, %248) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    "llvm.call_intrinsic"(%241, %242, %247, %250, %240) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tilestored64.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 5, 0>}> : (i16, i16, !llvm.ptr, i64, !llvm.x86_amx) -> ()
    %251 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %252 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %253 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %254 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %255 = "llvm.call_intrinsic"(%251, %254, %252, %235, %213, %224) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tdpbssd.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 6, 0>}> : (i16, i16, i16, !llvm.x86_amx, !llvm.x86_amx, !llvm.x86_amx) -> !llvm.x86_amx
    %256 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %257 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %258 = "llvm.extractvalue"(%207) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %259 = "llvm.extractvalue"(%207) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %260 = "llvm.mul"(%210, %259) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %261 = "llvm.add"(%260, %210) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %262 = "llvm.getelementptr"(%258, %261) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %263 = "llvm.extractvalue"(%207) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %264 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %265 = "llvm.mul"(%264, %263) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    "llvm.call_intrinsic"(%256, %257, %262, %265, %255) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tilestored64.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 5, 0>}> : (i16, i16, !llvm.ptr, i64, !llvm.x86_amx) -> ()
    %266 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %267 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %268 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %269 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %270 = "llvm.call_intrinsic"(%266, %269, %267, %235, %213, %224) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tdpbusd.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 6, 0>}> {isZextLhs} : (i16, i16, i16, !llvm.x86_amx, !llvm.x86_amx, !llvm.x86_amx) -> !llvm.x86_amx
    %271 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %272 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %273 = "llvm.extractvalue"(%207) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %274 = "llvm.extractvalue"(%207) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %275 = "llvm.mul"(%210, %274) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %276 = "llvm.add"(%275, %210) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %277 = "llvm.getelementptr"(%273, %276) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %278 = "llvm.extractvalue"(%207) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %279 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %280 = "llvm.mul"(%279, %278) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    "llvm.call_intrinsic"(%271, %272, %277, %280, %270) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tilestored64.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 5, 0>}> : (i16, i16, !llvm.ptr, i64, !llvm.x86_amx) -> ()
    %281 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %282 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %283 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %284 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %285 = "llvm.call_intrinsic"(%281, %284, %282, %235, %213, %224) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tdpbsud.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 6, 0>}> {isZextRhs} : (i16, i16, i16, !llvm.x86_amx, !llvm.x86_amx, !llvm.x86_amx) -> !llvm.x86_amx
    %286 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %287 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %288 = "llvm.extractvalue"(%207) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %289 = "llvm.extractvalue"(%207) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %290 = "llvm.mul"(%210, %289) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %291 = "llvm.add"(%290, %210) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %292 = "llvm.getelementptr"(%288, %291) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %293 = "llvm.extractvalue"(%207) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %294 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %295 = "llvm.mul"(%294, %293) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    "llvm.call_intrinsic"(%286, %287, %292, %295, %285) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tilestored64.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 5, 0>}> : (i16, i16, !llvm.ptr, i64, !llvm.x86_amx) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xbf16>, memref<?x?xf32>) -> (), sym_name = "mulbf16"}> ({
  ^bb0(%arg9: memref<?x?xbf16>, %arg10: memref<?x?xf32>):
    %163 = "builtin.unrealized_conversion_cast"(%arg10) : (memref<?x?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %164 = "builtin.unrealized_conversion_cast"(%arg9) : (memref<?x?xbf16>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %165 = "arith.constant"() <{value = 0 : index}> : () -> index
    %166 = "builtin.unrealized_conversion_cast"(%165) : (index) -> i64
    %167 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %168 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %169 = "llvm.call_intrinsic"(%167, %168) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tilezero.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i16, i16) -> !llvm.x86_amx
    %170 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %171 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %172 = "llvm.extractvalue"(%164) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %173 = "llvm.extractvalue"(%164) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %174 = "llvm.mul"(%166, %173) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %175 = "llvm.add"(%174, %166) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %176 = "llvm.getelementptr"(%172, %175) <{elem_type = bf16, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %177 = "llvm.extractvalue"(%164) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %178 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %179 = "llvm.mul"(%178, %177) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %180 = "llvm.call_intrinsic"(%170, %171, %176, %179) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tileloadd64.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>}> : (i16, i16, !llvm.ptr, i64) -> !llvm.x86_amx
    %181 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %182 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %183 = "llvm.extractvalue"(%163) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %184 = "llvm.extractvalue"(%163) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %185 = "llvm.mul"(%166, %184) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %186 = "llvm.add"(%185, %166) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %187 = "llvm.getelementptr"(%183, %186) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %188 = "llvm.extractvalue"(%163) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %189 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %190 = "llvm.mul"(%189, %188) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %191 = "llvm.call_intrinsic"(%181, %182, %187, %190) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tileloadd64.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>}> : (i16, i16, !llvm.ptr, i64) -> !llvm.x86_amx
    %192 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %193 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %194 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %195 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %196 = "llvm.call_intrinsic"(%192, %195, %193, %191, %169, %180) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tdpbf16ps.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 6, 0>}> : (i16, i16, i16, !llvm.x86_amx, !llvm.x86_amx, !llvm.x86_amx) -> !llvm.x86_amx
    %197 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %198 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %199 = "llvm.extractvalue"(%163) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %200 = "llvm.extractvalue"(%163) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %201 = "llvm.mul"(%166, %200) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %202 = "llvm.add"(%201, %166) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %203 = "llvm.getelementptr"(%199, %202) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %204 = "llvm.extractvalue"(%163) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %205 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %206 = "llvm.mul"(%205, %204) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    "llvm.call_intrinsic"(%197, %198, %203, %206, %196) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tilestored64.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 5, 0>}> : (i16, i16, !llvm.ptr, i64, !llvm.x86_amx) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf16>, memref<?x?xf32>) -> (), sym_name = "mulfp16"}> ({
  ^bb0(%arg7: memref<?x?xf16>, %arg8: memref<?x?xf32>):
    %119 = "builtin.unrealized_conversion_cast"(%arg8) : (memref<?x?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %120 = "builtin.unrealized_conversion_cast"(%arg7) : (memref<?x?xf16>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %121 = "arith.constant"() <{value = 0 : index}> : () -> index
    %122 = "builtin.unrealized_conversion_cast"(%121) : (index) -> i64
    %123 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %124 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %125 = "llvm.call_intrinsic"(%123, %124) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tilezero.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i16, i16) -> !llvm.x86_amx
    %126 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %127 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %128 = "llvm.extractvalue"(%120) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %129 = "llvm.extractvalue"(%120) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %130 = "llvm.mul"(%122, %129) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %131 = "llvm.add"(%130, %122) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %132 = "llvm.getelementptr"(%128, %131) <{elem_type = f16, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %133 = "llvm.extractvalue"(%120) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %134 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %135 = "llvm.mul"(%134, %133) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %136 = "llvm.call_intrinsic"(%126, %127, %132, %135) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tileloadd64.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>}> : (i16, i16, !llvm.ptr, i64) -> !llvm.x86_amx
    %137 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %138 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %139 = "llvm.extractvalue"(%119) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %140 = "llvm.extractvalue"(%119) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %141 = "llvm.mul"(%122, %140) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %142 = "llvm.add"(%141, %122) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %143 = "llvm.getelementptr"(%139, %142) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %144 = "llvm.extractvalue"(%119) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %145 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %146 = "llvm.mul"(%145, %144) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %147 = "llvm.call_intrinsic"(%137, %138, %143, %146) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tileloadd64.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>}> : (i16, i16, !llvm.ptr, i64) -> !llvm.x86_amx
    %148 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %149 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %150 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %151 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %152 = "llvm.call_intrinsic"(%148, %151, %149, %147, %125, %136) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tdpfp16ps.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 6, 0>}> : (i16, i16, i16, !llvm.x86_amx, !llvm.x86_amx, !llvm.x86_amx) -> !llvm.x86_amx
    %153 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %154 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %155 = "llvm.extractvalue"(%119) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %156 = "llvm.extractvalue"(%119) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %157 = "llvm.mul"(%122, %156) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %158 = "llvm.add"(%157, %122) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %159 = "llvm.getelementptr"(%155, %158) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %160 = "llvm.extractvalue"(%119) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %161 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %162 = "llvm.mul"(%161, %160) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    "llvm.call_intrinsic"(%153, %154, %159, %162, %152) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tilestored64.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 5, 0>}> : (i16, i16, !llvm.ptr, i64, !llvm.x86_amx) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16x32xi8>, memref<32x32xbf16, strided<[64, 1]>>, memref<16x32xf32, strided<[?, 1]>>) -> (), sym_name = "strides_implicit"}> ({
  ^bb0(%arg4: memref<16x32xi8>, %arg5: memref<32x32xbf16, strided<[64, 1]>>, %arg6: memref<16x32xf32, strided<[?, 1]>>):
    %59 = "builtin.unrealized_conversion_cast"(%arg6) : (memref<16x32xf32, strided<[?, 1]>>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %60 = "builtin.unrealized_conversion_cast"(%arg5) : (memref<32x32xbf16, strided<[64, 1]>>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %61 = "builtin.unrealized_conversion_cast"(%arg4) : (memref<16x32xi8>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %62 = "arith.constant"() <{value = 0 : index}> : () -> index
    %63 = "builtin.unrealized_conversion_cast"(%62) : (index) -> i64
    %64 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %65 = "llvm.mlir.constant"() <{value = 32 : i16}> : () -> i16
    %66 = "llvm.extractvalue"(%61) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %67 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
    %68 = "llvm.mul"(%63, %67) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %69 = "llvm.add"(%68, %63) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %70 = "llvm.getelementptr"(%66, %69) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %71 = "llvm.mlir.constant"() <{value = 32 : i64}> : () -> i64
    %72 = "llvm.call_intrinsic"(%64, %65, %70, %71) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tileloadd64.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>}> : (i16, i16, !llvm.ptr, i64) -> !llvm.x86_amx
    %73 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %74 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %75 = "llvm.extractvalue"(%60) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %76 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
    %77 = "llvm.mul"(%63, %76) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %78 = "llvm.add"(%77, %63) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %79 = "llvm.getelementptr"(%75, %78) <{elem_type = bf16, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %80 = "llvm.mlir.constant"() <{value = 128 : i64}> : () -> i64
    %81 = "llvm.call_intrinsic"(%73, %74, %79, %80) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tileloadd64.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>}> : (i16, i16, !llvm.ptr, i64) -> !llvm.x86_amx
    %82 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %83 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %84 = "llvm.extractvalue"(%59) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %85 = "llvm.extractvalue"(%59) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %86 = "llvm.mul"(%63, %85) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %87 = "llvm.add"(%86, %63) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %88 = "llvm.getelementptr"(%84, %87) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %89 = "llvm.extractvalue"(%59) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %90 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %91 = "llvm.mul"(%90, %89) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %92 = "llvm.call_intrinsic"(%82, %83, %88, %91) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tileloadd64.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>}> : (i16, i16, !llvm.ptr, i64) -> !llvm.x86_amx
    %93 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %94 = "llvm.mlir.constant"() <{value = 32 : i16}> : () -> i16
    %95 = "llvm.extractvalue"(%61) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %96 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
    %97 = "llvm.mul"(%63, %96) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %98 = "llvm.add"(%97, %63) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %99 = "llvm.getelementptr"(%95, %98) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %100 = "llvm.mlir.constant"() <{value = 32 : i64}> : () -> i64
    "llvm.call_intrinsic"(%93, %94, %99, %100, %72) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tilestored64.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 5, 0>}> : (i16, i16, !llvm.ptr, i64, !llvm.x86_amx) -> ()
    %101 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %102 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %103 = "llvm.extractvalue"(%60) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %104 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
    %105 = "llvm.mul"(%63, %104) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %106 = "llvm.add"(%105, %63) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %107 = "llvm.getelementptr"(%103, %106) <{elem_type = bf16, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %108 = "llvm.mlir.constant"() <{value = 128 : i64}> : () -> i64
    "llvm.call_intrinsic"(%101, %102, %107, %108, %81) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tilestored64.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 5, 0>}> : (i16, i16, !llvm.ptr, i64, !llvm.x86_amx) -> ()
    %109 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %110 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %111 = "llvm.extractvalue"(%59) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %112 = "llvm.extractvalue"(%59) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %113 = "llvm.mul"(%63, %112) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %114 = "llvm.add"(%113, %63) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %115 = "llvm.getelementptr"(%111, %114) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %116 = "llvm.extractvalue"(%59) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %117 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %118 = "llvm.mul"(%117, %116) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    "llvm.call_intrinsic"(%109, %110, %115, %118, %92) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tilestored64.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 5, 0>}> : (i16, i16, !llvm.ptr, i64, !llvm.x86_amx) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, memref<?xi8>, memref<16x32xbf16>, memref<32x32xf32, strided<[64, 1]>>) -> (), sym_name = "strides_explicit"}> ({
  ^bb0(%arg0: index, %arg1: memref<?xi8>, %arg2: memref<16x32xbf16>, %arg3: memref<32x32xf32, strided<[64, 1]>>):
    %0 = "builtin.unrealized_conversion_cast"(%arg3) : (memref<32x32xf32, strided<[64, 1]>>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<16x32xbf16>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> i64
    %3 = "builtin.unrealized_conversion_cast"(%arg1) : (memref<?xi8>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "builtin.unrealized_conversion_cast"(%4) : (index) -> i64
    %6 = "arith.constant"() <{value = 64 : index}> : () -> index
    %7 = "builtin.unrealized_conversion_cast"(%6) : (index) -> i64
    %8 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %9 = "llvm.mlir.constant"() <{value = 32 : i16}> : () -> i16
    %10 = "llvm.extractvalue"(%3) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %11 = "llvm.getelementptr"(%10, %5) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %12 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %13 = "llvm.mul"(%12, %2) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %14 = "llvm.call_intrinsic"(%8, %9, %11, %13) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tileloadd64.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>}> : (i16, i16, !llvm.ptr, i64) -> !llvm.x86_amx
    %15 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %16 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %17 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %18 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
    %19 = "llvm.mul"(%5, %18) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %20 = "llvm.add"(%19, %5) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %21 = "llvm.getelementptr"(%17, %20) <{elem_type = bf16, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %22 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %23 = "llvm.mul"(%22, %2) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %24 = "llvm.call_intrinsic"(%15, %16, %21, %23) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tileloadd64.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>}> : (i16, i16, !llvm.ptr, i64) -> !llvm.x86_amx
    %25 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %26 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %27 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %28 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
    %29 = "llvm.mul"(%5, %28) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %30 = "llvm.add"(%29, %5) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %31 = "llvm.getelementptr"(%27, %30) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %32 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %33 = "llvm.mul"(%32, %7) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %34 = "llvm.call_intrinsic"(%25, %26, %31, %33) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tileloadd64.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>}> : (i16, i16, !llvm.ptr, i64) -> !llvm.x86_amx
    %35 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %36 = "llvm.mlir.constant"() <{value = 32 : i16}> : () -> i16
    %37 = "llvm.extractvalue"(%3) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %38 = "llvm.getelementptr"(%37, %5) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %39 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %40 = "llvm.mul"(%39, %2) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    "llvm.call_intrinsic"(%35, %36, %38, %40, %14) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tilestored64.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 5, 0>}> : (i16, i16, !llvm.ptr, i64, !llvm.x86_amx) -> ()
    %41 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %42 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %43 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %44 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
    %45 = "llvm.mul"(%5, %44) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %46 = "llvm.add"(%45, %5) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %47 = "llvm.getelementptr"(%43, %46) <{elem_type = bf16, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %48 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %49 = "llvm.mul"(%48, %2) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    "llvm.call_intrinsic"(%41, %42, %47, %49, %24) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tilestored64.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 5, 0>}> : (i16, i16, !llvm.ptr, i64, !llvm.x86_amx) -> ()
    %50 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %51 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %52 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %53 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
    %54 = "llvm.mul"(%5, %53) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %55 = "llvm.add"(%54, %5) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %56 = "llvm.getelementptr"(%52, %55) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %57 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %58 = "llvm.mul"(%57, %7) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    "llvm.call_intrinsic"(%50, %51, %56, %58, %34) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tilestored64.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 5, 0>}> : (i16, i16, !llvm.ptr, i64, !llvm.x86_amx) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

