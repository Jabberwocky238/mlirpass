"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_kernel", targets = [#xevm.target<chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (memref<4096xi8, 3>) -> f32}> ({
    ^bb0(%arg7: memref<4096xi8, 3>):
      %374 = "memref.extract_aligned_pointer_as_index"(%arg7) : (memref<4096xi8, 3>) -> index
      %375 = "arith.constant"() <{value = 0 : index}> : () -> index
      %376 = "arith.index_castui"(%374) : (index) -> i32
      %377 = "arith.index_castui"(%375) : (index) -> i32
      %378 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %379 = "arith.muli"(%377, %378) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %380 = "arith.addi"(%376, %379) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %381 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %382 = "arith.constant"() <{value = 0 : index}> : () -> index
      %383 = "arith.constant"() <{value = 0 : index}> : () -> index
      %384 = "arith.constant"() <{value = 32 : index}> : () -> index
      %385 = "arith.muli"(%382, %384) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %386 = "arith.addi"(%385, %383) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %387 = "arith.constant"() <{value = 1 : index}> : () -> index
      %388 = "arith.muli"(%381, %387) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %389 = "arith.addi"(%388, %386) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %390 = "arith.index_castui"(%389) : (index) -> i32
      %391 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %392 = "arith.muli"(%390, %391) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %393 = "arith.addi"(%380, %392) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %394 = "llvm.inttoptr"(%393) : (i32) -> !llvm.ptr<3>
      %395 = "llvm.load"(%394) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> f32
      %396 = "arith.constant"() <{value = 0 : index}> : () -> index
      %397 = "arith.constant"() <{value = 32 : index}> : () -> index
      %398 = "arith.muli"(%382, %397) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %399 = "arith.addi"(%398, %396) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %400 = "arith.constant"() <{value = 1 : index}> : () -> index
      %401 = "arith.muli"(%381, %400) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %402 = "arith.addi"(%401, %399) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %403 = "arith.index_castui"(%402) : (index) -> i32
      %404 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %405 = "arith.muli"(%403, %404) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %406 = "arith.addi"(%380, %405) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %407 = "llvm.inttoptr"(%406) : (i32) -> !llvm.ptr<3>
      "llvm.store"(%395, %407) <{ordering = 0 : i64}> : (f32, !llvm.ptr<3>) -> ()
      "gpu.return"(%395) : (f32) -> ()
    }) {sym_name = "load_store_matrix_plain", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (memref<1024xi8, 3>) -> f32}> ({
    ^bb0(%arg6: memref<1024xi8, 3>):
      %338 = "arith.constant"() <{value = 0 : index}> : () -> index
      %339 = "memref.view"(%arg6, %338) : (memref<1024xi8, 3>, index) -> memref<64x32xf32, 3>
      %340 = "memref.subview"(%339) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 32, 0>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<64x32xf32, 3>) -> memref<32x32xf32, strided<[32, 1], offset: 1024>, 3>
      %341 = "memref.extract_aligned_pointer_as_index"(%340) : (memref<32x32xf32, strided<[32, 1], offset: 1024>, 3>) -> index
      %342 = "arith.constant"() <{value = 1024 : index}> : () -> index
      %343 = "arith.index_castui"(%341) : (index) -> i32
      %344 = "arith.index_castui"(%342) : (index) -> i32
      %345 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %346 = "arith.muli"(%344, %345) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %347 = "arith.addi"(%343, %346) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %348 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %349 = "arith.constant"() <{value = 0 : index}> : () -> index
      %350 = "arith.constant"() <{value = 32 : index}> : () -> index
      %351 = "arith.muli"(%338, %350) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %352 = "arith.addi"(%351, %349) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %353 = "arith.constant"() <{value = 1 : index}> : () -> index
      %354 = "arith.muli"(%348, %353) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %355 = "arith.addi"(%354, %352) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %356 = "arith.index_castui"(%355) : (index) -> i32
      %357 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %358 = "arith.muli"(%356, %357) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %359 = "arith.addi"(%347, %358) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %360 = "llvm.inttoptr"(%359) : (i32) -> !llvm.ptr<3>
      %361 = "llvm.load"(%360) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> f32
      %362 = "arith.constant"() <{value = 0 : index}> : () -> index
      %363 = "arith.constant"() <{value = 32 : index}> : () -> index
      %364 = "arith.muli"(%338, %363) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %365 = "arith.addi"(%364, %362) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %366 = "arith.constant"() <{value = 1 : index}> : () -> index
      %367 = "arith.muli"(%348, %366) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %368 = "arith.addi"(%367, %365) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %369 = "arith.index_castui"(%368) : (index) -> i32
      %370 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %371 = "arith.muli"(%369, %370) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %372 = "arith.addi"(%347, %371) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %373 = "llvm.inttoptr"(%372) : (i32) -> !llvm.ptr<3>
      "llvm.store"(%361, %373) <{ordering = 0 : i64}> : (f32, !llvm.ptr<3>) -> ()
      "gpu.return"(%361) : (f32) -> ()
    }) {sym_name = "load_store_matrix_plain_2d_input", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (memref<4096xi8, 3>) -> f16}> ({
    ^bb0(%arg5: memref<4096xi8, 3>):
      %276 = "memref.extract_aligned_pointer_as_index"(%arg5) : (memref<4096xi8, 3>) -> index
      %277 = "arith.constant"() <{value = 0 : index}> : () -> index
      %278 = "arith.index_castui"(%276) : (index) -> i32
      %279 = "arith.index_castui"(%277) : (index) -> i32
      %280 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %281 = "arith.muli"(%279, %280) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %282 = "arith.addi"(%278, %281) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %283 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %284 = "arith.constant"() <{value = 13 : index}> : () -> index
      %285 = "arith.constant"() <{value = 16 : index}> : () -> index
      %286 = "arith.divsi"(%284, %285) : (index, index) -> index
      %287 = "arith.constant"() <{value = 16 : index}> : () -> index
      %288 = "arith.remsi"(%284, %287) : (index, index) -> index
      %289 = "arith.constant"() <{value = 16 : index}> : () -> index
      %290 = "arith.divsi"(%283, %289) : (index, index) -> index
      %291 = "arith.constant"() <{value = 16 : index}> : () -> index
      %292 = "arith.remsi"(%283, %291) : (index, index) -> index
      %293 = "arith.constant"() <{value = 0 : index}> : () -> index
      %294 = "arith.constant"() <{value = 256 : index}> : () -> index
      %295 = "arith.muli"(%286, %294) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %296 = "arith.addi"(%295, %293) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %297 = "arith.constant"() <{value = 512 : index}> : () -> index
      %298 = "arith.muli"(%290, %297) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %299 = "arith.addi"(%298, %296) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %300 = "arith.constant"() <{value = 1 : index}> : () -> index
      %301 = "arith.muli"(%288, %300) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %302 = "arith.addi"(%301, %299) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %303 = "arith.constant"() <{value = 16 : index}> : () -> index
      %304 = "arith.muli"(%292, %303) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %305 = "arith.addi"(%304, %302) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %306 = "arith.index_castui"(%305) : (index) -> i32
      %307 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %308 = "arith.muli"(%306, %307) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %309 = "arith.addi"(%282, %308) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %310 = "llvm.inttoptr"(%309) : (i32) -> !llvm.ptr<3>
      %311 = "llvm.load"(%310) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> f16
      %312 = "arith.constant"() <{value = 16 : index}> : () -> index
      %313 = "arith.divsi"(%284, %312) : (index, index) -> index
      %314 = "arith.constant"() <{value = 16 : index}> : () -> index
      %315 = "arith.remsi"(%284, %314) : (index, index) -> index
      %316 = "arith.constant"() <{value = 16 : index}> : () -> index
      %317 = "arith.divsi"(%283, %316) : (index, index) -> index
      %318 = "arith.constant"() <{value = 16 : index}> : () -> index
      %319 = "arith.remsi"(%283, %318) : (index, index) -> index
      %320 = "arith.constant"() <{value = 0 : index}> : () -> index
      %321 = "arith.constant"() <{value = 256 : index}> : () -> index
      %322 = "arith.muli"(%313, %321) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %323 = "arith.addi"(%322, %320) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %324 = "arith.constant"() <{value = 512 : index}> : () -> index
      %325 = "arith.muli"(%317, %324) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %326 = "arith.addi"(%325, %323) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %327 = "arith.constant"() <{value = 1 : index}> : () -> index
      %328 = "arith.muli"(%315, %327) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %329 = "arith.addi"(%328, %326) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %330 = "arith.constant"() <{value = 16 : index}> : () -> index
      %331 = "arith.muli"(%319, %330) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %332 = "arith.addi"(%331, %329) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %333 = "arith.index_castui"(%332) : (index) -> i32
      %334 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %335 = "arith.muli"(%333, %334) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %336 = "arith.addi"(%282, %335) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %337 = "llvm.inttoptr"(%336) : (i32) -> !llvm.ptr<3>
      "llvm.store"(%311, %337) <{ordering = 0 : i64}> : (f16, !llvm.ptr<3>) -> ()
      "gpu.return"(%311) : (f16) -> ()
    }) {sym_name = "load_store_matrix_blocked_strided", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (memref<4096xi8, 3>) -> f16}> ({
    ^bb0(%arg4: memref<4096xi8, 3>):
      %214 = "memref.extract_aligned_pointer_as_index"(%arg4) : (memref<4096xi8, 3>) -> index
      %215 = "arith.constant"() <{value = 0 : index}> : () -> index
      %216 = "arith.index_castui"(%214) : (index) -> i32
      %217 = "arith.index_castui"(%215) : (index) -> i32
      %218 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %219 = "arith.muli"(%217, %218) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %220 = "arith.addi"(%216, %219) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %221 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %222 = "arith.constant"() <{value = 19 : index}> : () -> index
      %223 = "arith.constant"() <{value = 16 : index}> : () -> index
      %224 = "arith.divsi"(%222, %223) : (index, index) -> index
      %225 = "arith.constant"() <{value = 16 : index}> : () -> index
      %226 = "arith.remsi"(%222, %225) : (index, index) -> index
      %227 = "arith.constant"() <{value = 16 : index}> : () -> index
      %228 = "arith.divsi"(%221, %227) : (index, index) -> index
      %229 = "arith.constant"() <{value = 16 : index}> : () -> index
      %230 = "arith.remsi"(%221, %229) : (index, index) -> index
      %231 = "arith.constant"() <{value = 0 : index}> : () -> index
      %232 = "arith.constant"() <{value = 1024 : index}> : () -> index
      %233 = "arith.muli"(%224, %232) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %234 = "arith.addi"(%233, %231) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %235 = "arith.constant"() <{value = 256 : index}> : () -> index
      %236 = "arith.muli"(%228, %235) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %237 = "arith.addi"(%236, %234) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %238 = "arith.constant"() <{value = 16 : index}> : () -> index
      %239 = "arith.muli"(%226, %238) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %240 = "arith.addi"(%239, %237) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %241 = "arith.constant"() <{value = 1 : index}> : () -> index
      %242 = "arith.muli"(%230, %241) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %243 = "arith.addi"(%242, %240) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %244 = "arith.index_castui"(%243) : (index) -> i32
      %245 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %246 = "arith.muli"(%244, %245) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %247 = "arith.addi"(%220, %246) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %248 = "llvm.inttoptr"(%247) : (i32) -> !llvm.ptr<3>
      %249 = "llvm.load"(%248) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> f16
      %250 = "arith.constant"() <{value = 16 : index}> : () -> index
      %251 = "arith.divsi"(%222, %250) : (index, index) -> index
      %252 = "arith.constant"() <{value = 16 : index}> : () -> index
      %253 = "arith.remsi"(%222, %252) : (index, index) -> index
      %254 = "arith.constant"() <{value = 16 : index}> : () -> index
      %255 = "arith.divsi"(%221, %254) : (index, index) -> index
      %256 = "arith.constant"() <{value = 16 : index}> : () -> index
      %257 = "arith.remsi"(%221, %256) : (index, index) -> index
      %258 = "arith.constant"() <{value = 0 : index}> : () -> index
      %259 = "arith.constant"() <{value = 1024 : index}> : () -> index
      %260 = "arith.muli"(%251, %259) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %261 = "arith.addi"(%260, %258) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %262 = "arith.constant"() <{value = 256 : index}> : () -> index
      %263 = "arith.muli"(%255, %262) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %264 = "arith.addi"(%263, %261) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %265 = "arith.constant"() <{value = 16 : index}> : () -> index
      %266 = "arith.muli"(%253, %265) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %267 = "arith.addi"(%266, %264) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %268 = "arith.constant"() <{value = 1 : index}> : () -> index
      %269 = "arith.muli"(%257, %268) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %270 = "arith.addi"(%269, %267) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %271 = "arith.index_castui"(%270) : (index) -> i32
      %272 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %273 = "arith.muli"(%271, %272) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %274 = "arith.addi"(%220, %273) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %275 = "llvm.inttoptr"(%274) : (i32) -> !llvm.ptr<3>
      "llvm.store"(%249, %275) <{ordering = 0 : i64}> : (f16, !llvm.ptr<3>) -> ()
      "gpu.return"(%249) : (f16) -> ()
    }) {sym_name = "load_store_matrix_blocked_nostride", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (memref<4096xi8, 3>) -> vector<8xf16>}> ({
    ^bb0(%arg3: memref<4096xi8, 3>):
      %152 = "memref.extract_aligned_pointer_as_index"(%arg3) : (memref<4096xi8, 3>) -> index
      %153 = "arith.constant"() <{value = 0 : index}> : () -> index
      %154 = "arith.index_castui"(%152) : (index) -> i32
      %155 = "arith.index_castui"(%153) : (index) -> i32
      %156 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %157 = "arith.muli"(%155, %156) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %158 = "arith.addi"(%154, %157) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %159 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %160 = "arith.constant"() <{value = 16 : index}> : () -> index
      %161 = "arith.constant"() <{value = 16 : index}> : () -> index
      %162 = "arith.divsi"(%160, %161) : (index, index) -> index
      %163 = "arith.constant"() <{value = 16 : index}> : () -> index
      %164 = "arith.remsi"(%160, %163) : (index, index) -> index
      %165 = "arith.constant"() <{value = 16 : index}> : () -> index
      %166 = "arith.divsi"(%159, %165) : (index, index) -> index
      %167 = "arith.constant"() <{value = 16 : index}> : () -> index
      %168 = "arith.remsi"(%159, %167) : (index, index) -> index
      %169 = "arith.constant"() <{value = 0 : index}> : () -> index
      %170 = "arith.constant"() <{value = 256 : index}> : () -> index
      %171 = "arith.muli"(%162, %170) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %172 = "arith.addi"(%171, %169) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %173 = "arith.constant"() <{value = 512 : index}> : () -> index
      %174 = "arith.muli"(%166, %173) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %175 = "arith.addi"(%174, %172) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %176 = "arith.constant"() <{value = 1 : index}> : () -> index
      %177 = "arith.muli"(%164, %176) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %178 = "arith.addi"(%177, %175) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %179 = "arith.constant"() <{value = 16 : index}> : () -> index
      %180 = "arith.muli"(%168, %179) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %181 = "arith.addi"(%180, %178) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %182 = "arith.index_castui"(%181) : (index) -> i32
      %183 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %184 = "arith.muli"(%182, %183) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %185 = "arith.addi"(%158, %184) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %186 = "llvm.inttoptr"(%185) : (i32) -> !llvm.ptr<3>
      %187 = "llvm.load"(%186) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> vector<8xf16>
      %188 = "arith.constant"() <{value = 16 : index}> : () -> index
      %189 = "arith.divsi"(%160, %188) : (index, index) -> index
      %190 = "arith.constant"() <{value = 16 : index}> : () -> index
      %191 = "arith.remsi"(%160, %190) : (index, index) -> index
      %192 = "arith.constant"() <{value = 16 : index}> : () -> index
      %193 = "arith.divsi"(%159, %192) : (index, index) -> index
      %194 = "arith.constant"() <{value = 16 : index}> : () -> index
      %195 = "arith.remsi"(%159, %194) : (index, index) -> index
      %196 = "arith.constant"() <{value = 0 : index}> : () -> index
      %197 = "arith.constant"() <{value = 256 : index}> : () -> index
      %198 = "arith.muli"(%189, %197) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %199 = "arith.addi"(%198, %196) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %200 = "arith.constant"() <{value = 512 : index}> : () -> index
      %201 = "arith.muli"(%193, %200) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %202 = "arith.addi"(%201, %199) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %203 = "arith.constant"() <{value = 1 : index}> : () -> index
      %204 = "arith.muli"(%191, %203) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %205 = "arith.addi"(%204, %202) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %206 = "arith.constant"() <{value = 16 : index}> : () -> index
      %207 = "arith.muli"(%195, %206) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %208 = "arith.addi"(%207, %205) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %209 = "arith.index_castui"(%208) : (index) -> i32
      %210 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %211 = "arith.muli"(%209, %210) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %212 = "arith.addi"(%158, %211) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %213 = "llvm.inttoptr"(%212) : (i32) -> !llvm.ptr<3>
      "llvm.store"(%187, %213) <{ordering = 0 : i64}> : (vector<8xf16>, !llvm.ptr<3>) -> ()
      "gpu.return"(%187) : (vector<8xf16>) -> ()
    }) {sym_name = "load_store_matrix_blocked_strided_return_vector", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (memref<4096xi8, 3>) -> vector<8xf16>}> ({
    ^bb0(%arg2: memref<4096xi8, 3>):
      %88 = "memref.extract_aligned_pointer_as_index"(%arg2) : (memref<4096xi8, 3>) -> index
      %89 = "arith.constant"() <{value = 0 : index}> : () -> index
      %90 = "arith.index_castui"(%88) : (index) -> i32
      %91 = "arith.index_castui"(%89) : (index) -> i32
      %92 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %93 = "arith.muli"(%91, %92) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %94 = "arith.addi"(%90, %93) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %95 = "arith.constant"() <{value = 16 : index}> : () -> index
      %96 = "arith.constant"() <{value = 48 : index}> : () -> index
      %97 = "arith.constant"() <{value = 16 : index}> : () -> index
      %98 = "arith.divsi"(%95, %97) : (index, index) -> index
      %99 = "arith.constant"() <{value = 16 : index}> : () -> index
      %100 = "arith.remsi"(%95, %99) : (index, index) -> index
      %101 = "arith.constant"() <{value = 16 : index}> : () -> index
      %102 = "arith.divsi"(%96, %101) : (index, index) -> index
      %103 = "arith.constant"() <{value = 16 : index}> : () -> index
      %104 = "arith.remsi"(%96, %103) : (index, index) -> index
      %105 = "arith.constant"() <{value = 0 : index}> : () -> index
      %106 = "arith.constant"() <{value = 1024 : index}> : () -> index
      %107 = "arith.muli"(%98, %106) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %108 = "arith.addi"(%107, %105) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %109 = "arith.constant"() <{value = 256 : index}> : () -> index
      %110 = "arith.muli"(%102, %109) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %111 = "arith.addi"(%110, %108) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %112 = "arith.constant"() <{value = 16 : index}> : () -> index
      %113 = "arith.muli"(%100, %112) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %114 = "arith.addi"(%113, %111) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %115 = "arith.constant"() <{value = 1 : index}> : () -> index
      %116 = "arith.muli"(%104, %115) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %117 = "arith.addi"(%116, %114) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %118 = "arith.index_castui"(%117) : (index) -> i32
      %119 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %120 = "arith.muli"(%118, %119) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %121 = "arith.addi"(%94, %120) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %122 = "llvm.inttoptr"(%121) : (i32) -> !llvm.ptr<3>
      %123 = "xevm.blockload"(%122) : (!llvm.ptr<3>) -> vector<8xi16>
      %124 = "vector.bitcast"(%123) : (vector<8xi16>) -> vector<8xf16>
      %125 = "arith.constant"() <{value = 16 : index}> : () -> index
      %126 = "arith.divsi"(%95, %125) : (index, index) -> index
      %127 = "arith.constant"() <{value = 16 : index}> : () -> index
      %128 = "arith.remsi"(%95, %127) : (index, index) -> index
      %129 = "arith.constant"() <{value = 16 : index}> : () -> index
      %130 = "arith.divsi"(%96, %129) : (index, index) -> index
      %131 = "arith.constant"() <{value = 16 : index}> : () -> index
      %132 = "arith.remsi"(%96, %131) : (index, index) -> index
      %133 = "arith.constant"() <{value = 0 : index}> : () -> index
      %134 = "arith.constant"() <{value = 1024 : index}> : () -> index
      %135 = "arith.muli"(%126, %134) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %136 = "arith.addi"(%135, %133) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %137 = "arith.constant"() <{value = 256 : index}> : () -> index
      %138 = "arith.muli"(%130, %137) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %139 = "arith.addi"(%138, %136) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %140 = "arith.constant"() <{value = 16 : index}> : () -> index
      %141 = "arith.muli"(%128, %140) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %142 = "arith.addi"(%141, %139) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %143 = "arith.constant"() <{value = 1 : index}> : () -> index
      %144 = "arith.muli"(%132, %143) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %145 = "arith.addi"(%144, %142) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %146 = "arith.index_castui"(%145) : (index) -> i32
      %147 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %148 = "arith.muli"(%146, %147) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %149 = "arith.addi"(%94, %148) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %150 = "llvm.inttoptr"(%149) : (i32) -> !llvm.ptr<3>
      %151 = "vector.bitcast"(%124) : (vector<8xf16>) -> vector<8xi16>
      "xevm.blockstore"(%150, %151) : (!llvm.ptr<3>, vector<8xi16>) -> ()
      "gpu.return"(%124) : (vector<8xf16>) -> ()
    }) {sym_name = "load_store_matrix_blocked_subgroupblockio", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (!xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16]>>) -> ()}> ({
    ^bb0(%arg1: !xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16]>>):
      %23 = "builtin.unrealized_conversion_cast"(%arg1) : (!xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16]>>) -> i32
      %24 = "arith.constant"() <{value = 16 : index}> : () -> index
      %25 = "arith.constant"() <{value = 16 : index}> : () -> index
      %26 = "arith.divsi"(%24, %25) : (index, index) -> index
      %27 = "arith.constant"() <{value = 16 : index}> : () -> index
      %28 = "arith.constant"() <{value = 16 : index}> : () -> index
      %29 = "arith.remsi"(%27, %28) : (index, index) -> index
      %30 = "arith.constant"() <{value = 0 : index}> : () -> index
      %31 = "arith.constant"() <{value = 16 : index}> : () -> index
      %32 = "arith.divsi"(%30, %31) : (index, index) -> index
      %33 = "arith.constant"() <{value = 0 : index}> : () -> index
      %34 = "arith.constant"() <{value = 16 : index}> : () -> index
      %35 = "arith.remsi"(%33, %34) : (index, index) -> index
      %36 = "arith.constant"() <{value = 0 : index}> : () -> index
      %37 = "arith.constant"() <{value = 1024 : index}> : () -> index
      %38 = "arith.muli"(%26, %37) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %39 = "arith.addi"(%38, %36) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %40 = "arith.constant"() <{value = 256 : index}> : () -> index
      %41 = "arith.muli"(%32, %40) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %42 = "arith.addi"(%41, %39) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %43 = "arith.constant"() <{value = 16 : index}> : () -> index
      %44 = "arith.muli"(%29, %43) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %45 = "arith.addi"(%44, %42) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %46 = "arith.constant"() <{value = 1 : index}> : () -> index
      %47 = "arith.muli"(%35, %46) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %48 = "arith.addi"(%47, %45) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %49 = "arith.index_castui"(%48) : (index) -> i32
      %50 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %51 = "arith.muli"(%49, %50) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %52 = "arith.addi"(%23, %51) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %53 = "llvm.inttoptr"(%52) : (i32) -> !llvm.ptr<3>
      %54 = "llvm.load"(%53) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> vector<16xf16>
      %55 = "vector.shape_cast"(%54) : (vector<16xf16>) -> vector<1x16xf16>
      %56 = "arith.addf"(%55, %55) <{fastmath = #arith.fastmath<none>}> : (vector<1x16xf16>, vector<1x16xf16>) -> vector<1x16xf16>
      %57 = "vector.shape_cast"(%56) : (vector<1x16xf16>) -> vector<16xf16>
      %58 = "arith.constant"() <{value = 16 : index}> : () -> index
      %59 = "arith.constant"() <{value = 16 : index}> : () -> index
      %60 = "arith.divsi"(%58, %59) : (index, index) -> index
      %61 = "arith.constant"() <{value = 16 : index}> : () -> index
      %62 = "arith.constant"() <{value = 16 : index}> : () -> index
      %63 = "arith.remsi"(%61, %62) : (index, index) -> index
      %64 = "arith.constant"() <{value = 0 : index}> : () -> index
      %65 = "arith.constant"() <{value = 16 : index}> : () -> index
      %66 = "arith.divsi"(%64, %65) : (index, index) -> index
      %67 = "arith.constant"() <{value = 0 : index}> : () -> index
      %68 = "arith.constant"() <{value = 16 : index}> : () -> index
      %69 = "arith.remsi"(%67, %68) : (index, index) -> index
      %70 = "arith.constant"() <{value = 0 : index}> : () -> index
      %71 = "arith.constant"() <{value = 1024 : index}> : () -> index
      %72 = "arith.muli"(%60, %71) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %73 = "arith.addi"(%72, %70) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %74 = "arith.constant"() <{value = 256 : index}> : () -> index
      %75 = "arith.muli"(%66, %74) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %76 = "arith.addi"(%75, %73) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %77 = "arith.constant"() <{value = 16 : index}> : () -> index
      %78 = "arith.muli"(%63, %77) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %79 = "arith.addi"(%78, %76) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %80 = "arith.constant"() <{value = 1 : index}> : () -> index
      %81 = "arith.muli"(%69, %80) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %82 = "arith.addi"(%81, %79) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %83 = "arith.index_castui"(%82) : (index) -> i32
      %84 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %85 = "arith.muli"(%83, %84) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %86 = "arith.addi"(%23, %85) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %87 = "llvm.inttoptr"(%86) : (i32) -> !llvm.ptr<3>
      "llvm.store"(%57, %87) <{ordering = 0 : i64}> : (vector<16xf16>, !llvm.ptr<3>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "matrix_vector_materialization", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (memref<256x16xbf16, 3>) -> vector<1x16xbf16>}> ({
    ^bb0(%arg0: memref<256x16xbf16, 3>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 64, 0>, static_sizes = array<i64: 1, 16>, static_strides = array<i64: 1, 1>}> : (memref<256x16xbf16, 3>) -> memref<1x16xbf16, strided<[16, 1], offset: 1024>, 3>
      %2 = "memref.extract_aligned_pointer_as_index"(%1) : (memref<1x16xbf16, strided<[16, 1], offset: 1024>, 3>) -> index
      %3 = "arith.constant"() <{value = 1024 : index}> : () -> index
      %4 = "arith.index_castui"(%2) : (index) -> i32
      %5 = "arith.index_castui"(%3) : (index) -> i32
      %6 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %7 = "arith.muli"(%5, %6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %8 = "arith.addi"(%4, %7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %9 = "arith.constant"() <{value = 0 : index}> : () -> index
      %10 = "arith.constant"() <{value = 16 : index}> : () -> index
      %11 = "arith.muli"(%0, %10) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %12 = "arith.addi"(%11, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %13 = "arith.constant"() <{value = 1 : index}> : () -> index
      %14 = "arith.muli"(%0, %13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %15 = "arith.addi"(%14, %12) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %16 = "arith.index_castui"(%15) : (index) -> i32
      %17 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %18 = "arith.muli"(%16, %17) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %19 = "arith.addi"(%8, %18) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %20 = "llvm.inttoptr"(%19) : (i32) -> !llvm.ptr<3>
      %21 = "llvm.load"(%20) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> vector<16xbf16>
      %22 = "vector.shape_cast"(%21) : (vector<16xbf16>) -> vector<1x16xbf16>
      "gpu.return"(%22) : (vector<1x16xbf16>) -> ()
    }) {sym_name = "create_memdesc_from_subview", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

