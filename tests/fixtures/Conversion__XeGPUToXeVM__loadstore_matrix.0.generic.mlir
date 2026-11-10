"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_kernel", targets = [#xevm.target<chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (memref<4096xi8, 3>) -> f32}> ({
    ^bb0(%arg9: memref<4096xi8, 3>):
      %420 = "memref.extract_aligned_pointer_as_index"(%arg9) : (memref<4096xi8, 3>) -> index
      %421 = "arith.constant"() <{value = 0 : index}> : () -> index
      %422 = "arith.index_castui"(%420) : (index) -> i32
      %423 = "arith.index_castui"(%421) : (index) -> i32
      %424 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %425 = "arith.muli"(%423, %424) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %426 = "arith.addi"(%422, %425) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %427 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %428 = "arith.constant"() <{value = 0 : index}> : () -> index
      %429 = "arith.constant"() <{value = 0 : index}> : () -> index
      %430 = "arith.constant"() <{value = 32 : index}> : () -> index
      %431 = "arith.muli"(%428, %430) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %432 = "arith.addi"(%431, %429) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %433 = "arith.constant"() <{value = 1 : index}> : () -> index
      %434 = "arith.muli"(%427, %433) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %435 = "arith.addi"(%434, %432) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %436 = "arith.index_castui"(%435) : (index) -> i32
      %437 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %438 = "arith.muli"(%436, %437) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %439 = "arith.addi"(%426, %438) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %440 = "llvm.inttoptr"(%439) : (i32) -> !llvm.ptr<3>
      %441 = "llvm.load"(%440) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> f32
      %442 = "arith.constant"() <{value = 0 : index}> : () -> index
      %443 = "arith.constant"() <{value = 32 : index}> : () -> index
      %444 = "arith.muli"(%428, %443) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %445 = "arith.addi"(%444, %442) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %446 = "arith.constant"() <{value = 1 : index}> : () -> index
      %447 = "arith.muli"(%427, %446) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %448 = "arith.addi"(%447, %445) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %449 = "arith.index_castui"(%448) : (index) -> i32
      %450 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %451 = "arith.muli"(%449, %450) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %452 = "arith.addi"(%426, %451) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %453 = "llvm.inttoptr"(%452) : (i32) -> !llvm.ptr<3>
      "llvm.store"(%441, %453) <{ordering = 0 : i64}> : (f32, !llvm.ptr<3>) -> ()
      "gpu.return"(%441) : (f32) -> ()
    }) {sym_name = "load_store_matrix_plain"} : () -> ()
    "gpu.func"() <{function_type = (memref<1024xi8, 3>) -> f32}> ({
    ^bb0(%arg8: memref<1024xi8, 3>):
      %384 = "arith.constant"() <{value = 0 : index}> : () -> index
      %385 = "memref.view"(%arg8, %384) : (memref<1024xi8, 3>, index) -> memref<64x32xf32, 3>
      %386 = "memref.subview"(%385) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 32, 0>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<64x32xf32, 3>) -> memref<32x32xf32, strided<[32, 1], offset: 1024>, 3>
      %387 = "memref.extract_aligned_pointer_as_index"(%386) : (memref<32x32xf32, strided<[32, 1], offset: 1024>, 3>) -> index
      %388 = "arith.constant"() <{value = 1024 : index}> : () -> index
      %389 = "arith.index_castui"(%387) : (index) -> i32
      %390 = "arith.index_castui"(%388) : (index) -> i32
      %391 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %392 = "arith.muli"(%390, %391) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %393 = "arith.addi"(%389, %392) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %394 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %395 = "arith.constant"() <{value = 0 : index}> : () -> index
      %396 = "arith.constant"() <{value = 32 : index}> : () -> index
      %397 = "arith.muli"(%384, %396) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %398 = "arith.addi"(%397, %395) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %399 = "arith.constant"() <{value = 1 : index}> : () -> index
      %400 = "arith.muli"(%394, %399) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %401 = "arith.addi"(%400, %398) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %402 = "arith.index_castui"(%401) : (index) -> i32
      %403 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %404 = "arith.muli"(%402, %403) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %405 = "arith.addi"(%393, %404) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %406 = "llvm.inttoptr"(%405) : (i32) -> !llvm.ptr<3>
      %407 = "llvm.load"(%406) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> f32
      %408 = "arith.constant"() <{value = 0 : index}> : () -> index
      %409 = "arith.constant"() <{value = 32 : index}> : () -> index
      %410 = "arith.muli"(%384, %409) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %411 = "arith.addi"(%410, %408) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %412 = "arith.constant"() <{value = 1 : index}> : () -> index
      %413 = "arith.muli"(%394, %412) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %414 = "arith.addi"(%413, %411) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %415 = "arith.index_castui"(%414) : (index) -> i32
      %416 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %417 = "arith.muli"(%415, %416) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %418 = "arith.addi"(%393, %417) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %419 = "llvm.inttoptr"(%418) : (i32) -> !llvm.ptr<3>
      "llvm.store"(%407, %419) <{ordering = 0 : i64}> : (f32, !llvm.ptr<3>) -> ()
      "gpu.return"(%407) : (f32) -> ()
    }) {sym_name = "load_store_matrix_plain_2d_input"} : () -> ()
    "gpu.func"() <{function_type = (memref<4096xi8, 3>) -> f16}> ({
    ^bb0(%arg7: memref<4096xi8, 3>):
      %322 = "memref.extract_aligned_pointer_as_index"(%arg7) : (memref<4096xi8, 3>) -> index
      %323 = "arith.constant"() <{value = 0 : index}> : () -> index
      %324 = "arith.index_castui"(%322) : (index) -> i32
      %325 = "arith.index_castui"(%323) : (index) -> i32
      %326 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %327 = "arith.muli"(%325, %326) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %328 = "arith.addi"(%324, %327) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %329 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %330 = "arith.constant"() <{value = 13 : index}> : () -> index
      %331 = "arith.constant"() <{value = 16 : index}> : () -> index
      %332 = "arith.divsi"(%330, %331) : (index, index) -> index
      %333 = "arith.constant"() <{value = 16 : index}> : () -> index
      %334 = "arith.remsi"(%330, %333) : (index, index) -> index
      %335 = "arith.constant"() <{value = 16 : index}> : () -> index
      %336 = "arith.divsi"(%329, %335) : (index, index) -> index
      %337 = "arith.constant"() <{value = 16 : index}> : () -> index
      %338 = "arith.remsi"(%329, %337) : (index, index) -> index
      %339 = "arith.constant"() <{value = 0 : index}> : () -> index
      %340 = "arith.constant"() <{value = 256 : index}> : () -> index
      %341 = "arith.muli"(%332, %340) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %342 = "arith.addi"(%341, %339) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %343 = "arith.constant"() <{value = 512 : index}> : () -> index
      %344 = "arith.muli"(%336, %343) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %345 = "arith.addi"(%344, %342) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %346 = "arith.constant"() <{value = 1 : index}> : () -> index
      %347 = "arith.muli"(%334, %346) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %348 = "arith.addi"(%347, %345) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %349 = "arith.constant"() <{value = 16 : index}> : () -> index
      %350 = "arith.muli"(%338, %349) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %351 = "arith.addi"(%350, %348) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %352 = "arith.index_castui"(%351) : (index) -> i32
      %353 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %354 = "arith.muli"(%352, %353) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %355 = "arith.addi"(%328, %354) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %356 = "llvm.inttoptr"(%355) : (i32) -> !llvm.ptr<3>
      %357 = "llvm.load"(%356) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> f16
      %358 = "arith.constant"() <{value = 16 : index}> : () -> index
      %359 = "arith.divsi"(%330, %358) : (index, index) -> index
      %360 = "arith.constant"() <{value = 16 : index}> : () -> index
      %361 = "arith.remsi"(%330, %360) : (index, index) -> index
      %362 = "arith.constant"() <{value = 16 : index}> : () -> index
      %363 = "arith.divsi"(%329, %362) : (index, index) -> index
      %364 = "arith.constant"() <{value = 16 : index}> : () -> index
      %365 = "arith.remsi"(%329, %364) : (index, index) -> index
      %366 = "arith.constant"() <{value = 0 : index}> : () -> index
      %367 = "arith.constant"() <{value = 256 : index}> : () -> index
      %368 = "arith.muli"(%359, %367) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %369 = "arith.addi"(%368, %366) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %370 = "arith.constant"() <{value = 512 : index}> : () -> index
      %371 = "arith.muli"(%363, %370) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %372 = "arith.addi"(%371, %369) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %373 = "arith.constant"() <{value = 1 : index}> : () -> index
      %374 = "arith.muli"(%361, %373) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %375 = "arith.addi"(%374, %372) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %376 = "arith.constant"() <{value = 16 : index}> : () -> index
      %377 = "arith.muli"(%365, %376) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %378 = "arith.addi"(%377, %375) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %379 = "arith.index_castui"(%378) : (index) -> i32
      %380 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %381 = "arith.muli"(%379, %380) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %382 = "arith.addi"(%328, %381) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %383 = "llvm.inttoptr"(%382) : (i32) -> !llvm.ptr<3>
      "llvm.store"(%357, %383) <{ordering = 0 : i64}> : (f16, !llvm.ptr<3>) -> ()
      "gpu.return"(%357) : (f16) -> ()
    }) {sym_name = "load_store_matrix_blocked_strided"} : () -> ()
    "gpu.func"() <{function_type = (memref<4096xi8, 3>) -> f16}> ({
    ^bb0(%arg6: memref<4096xi8, 3>):
      %260 = "memref.extract_aligned_pointer_as_index"(%arg6) : (memref<4096xi8, 3>) -> index
      %261 = "arith.constant"() <{value = 0 : index}> : () -> index
      %262 = "arith.index_castui"(%260) : (index) -> i32
      %263 = "arith.index_castui"(%261) : (index) -> i32
      %264 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %265 = "arith.muli"(%263, %264) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %266 = "arith.addi"(%262, %265) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %267 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %268 = "arith.constant"() <{value = 19 : index}> : () -> index
      %269 = "arith.constant"() <{value = 16 : index}> : () -> index
      %270 = "arith.divsi"(%268, %269) : (index, index) -> index
      %271 = "arith.constant"() <{value = 16 : index}> : () -> index
      %272 = "arith.remsi"(%268, %271) : (index, index) -> index
      %273 = "arith.constant"() <{value = 16 : index}> : () -> index
      %274 = "arith.divsi"(%267, %273) : (index, index) -> index
      %275 = "arith.constant"() <{value = 16 : index}> : () -> index
      %276 = "arith.remsi"(%267, %275) : (index, index) -> index
      %277 = "arith.constant"() <{value = 0 : index}> : () -> index
      %278 = "arith.constant"() <{value = 1024 : index}> : () -> index
      %279 = "arith.muli"(%270, %278) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %280 = "arith.addi"(%279, %277) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %281 = "arith.constant"() <{value = 256 : index}> : () -> index
      %282 = "arith.muli"(%274, %281) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %283 = "arith.addi"(%282, %280) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %284 = "arith.constant"() <{value = 16 : index}> : () -> index
      %285 = "arith.muli"(%272, %284) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %286 = "arith.addi"(%285, %283) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %287 = "arith.constant"() <{value = 1 : index}> : () -> index
      %288 = "arith.muli"(%276, %287) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %289 = "arith.addi"(%288, %286) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %290 = "arith.index_castui"(%289) : (index) -> i32
      %291 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %292 = "arith.muli"(%290, %291) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %293 = "arith.addi"(%266, %292) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %294 = "llvm.inttoptr"(%293) : (i32) -> !llvm.ptr<3>
      %295 = "llvm.load"(%294) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> f16
      %296 = "arith.constant"() <{value = 16 : index}> : () -> index
      %297 = "arith.divsi"(%268, %296) : (index, index) -> index
      %298 = "arith.constant"() <{value = 16 : index}> : () -> index
      %299 = "arith.remsi"(%268, %298) : (index, index) -> index
      %300 = "arith.constant"() <{value = 16 : index}> : () -> index
      %301 = "arith.divsi"(%267, %300) : (index, index) -> index
      %302 = "arith.constant"() <{value = 16 : index}> : () -> index
      %303 = "arith.remsi"(%267, %302) : (index, index) -> index
      %304 = "arith.constant"() <{value = 0 : index}> : () -> index
      %305 = "arith.constant"() <{value = 1024 : index}> : () -> index
      %306 = "arith.muli"(%297, %305) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %307 = "arith.addi"(%306, %304) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %308 = "arith.constant"() <{value = 256 : index}> : () -> index
      %309 = "arith.muli"(%301, %308) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %310 = "arith.addi"(%309, %307) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %311 = "arith.constant"() <{value = 16 : index}> : () -> index
      %312 = "arith.muli"(%299, %311) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %313 = "arith.addi"(%312, %310) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %314 = "arith.constant"() <{value = 1 : index}> : () -> index
      %315 = "arith.muli"(%303, %314) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %316 = "arith.addi"(%315, %313) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %317 = "arith.index_castui"(%316) : (index) -> i32
      %318 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %319 = "arith.muli"(%317, %318) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %320 = "arith.addi"(%266, %319) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %321 = "llvm.inttoptr"(%320) : (i32) -> !llvm.ptr<3>
      "llvm.store"(%295, %321) <{ordering = 0 : i64}> : (f16, !llvm.ptr<3>) -> ()
      "gpu.return"(%295) : (f16) -> ()
    }) {sym_name = "load_store_matrix_blocked_nostride"} : () -> ()
    "gpu.func"() <{function_type = (memref<4096xi8, 3>) -> vector<8xf16>}> ({
    ^bb0(%arg5: memref<4096xi8, 3>):
      %198 = "memref.extract_aligned_pointer_as_index"(%arg5) : (memref<4096xi8, 3>) -> index
      %199 = "arith.constant"() <{value = 0 : index}> : () -> index
      %200 = "arith.index_castui"(%198) : (index) -> i32
      %201 = "arith.index_castui"(%199) : (index) -> i32
      %202 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %203 = "arith.muli"(%201, %202) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %204 = "arith.addi"(%200, %203) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %205 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %206 = "arith.constant"() <{value = 16 : index}> : () -> index
      %207 = "arith.constant"() <{value = 16 : index}> : () -> index
      %208 = "arith.divsi"(%206, %207) : (index, index) -> index
      %209 = "arith.constant"() <{value = 16 : index}> : () -> index
      %210 = "arith.remsi"(%206, %209) : (index, index) -> index
      %211 = "arith.constant"() <{value = 16 : index}> : () -> index
      %212 = "arith.divsi"(%205, %211) : (index, index) -> index
      %213 = "arith.constant"() <{value = 16 : index}> : () -> index
      %214 = "arith.remsi"(%205, %213) : (index, index) -> index
      %215 = "arith.constant"() <{value = 0 : index}> : () -> index
      %216 = "arith.constant"() <{value = 256 : index}> : () -> index
      %217 = "arith.muli"(%208, %216) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %218 = "arith.addi"(%217, %215) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %219 = "arith.constant"() <{value = 512 : index}> : () -> index
      %220 = "arith.muli"(%212, %219) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %221 = "arith.addi"(%220, %218) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %222 = "arith.constant"() <{value = 1 : index}> : () -> index
      %223 = "arith.muli"(%210, %222) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %224 = "arith.addi"(%223, %221) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %225 = "arith.constant"() <{value = 16 : index}> : () -> index
      %226 = "arith.muli"(%214, %225) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %227 = "arith.addi"(%226, %224) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %228 = "arith.index_castui"(%227) : (index) -> i32
      %229 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %230 = "arith.muli"(%228, %229) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %231 = "arith.addi"(%204, %230) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %232 = "llvm.inttoptr"(%231) : (i32) -> !llvm.ptr<3>
      %233 = "llvm.load"(%232) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> vector<8xf16>
      %234 = "arith.constant"() <{value = 16 : index}> : () -> index
      %235 = "arith.divsi"(%206, %234) : (index, index) -> index
      %236 = "arith.constant"() <{value = 16 : index}> : () -> index
      %237 = "arith.remsi"(%206, %236) : (index, index) -> index
      %238 = "arith.constant"() <{value = 16 : index}> : () -> index
      %239 = "arith.divsi"(%205, %238) : (index, index) -> index
      %240 = "arith.constant"() <{value = 16 : index}> : () -> index
      %241 = "arith.remsi"(%205, %240) : (index, index) -> index
      %242 = "arith.constant"() <{value = 0 : index}> : () -> index
      %243 = "arith.constant"() <{value = 256 : index}> : () -> index
      %244 = "arith.muli"(%235, %243) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %245 = "arith.addi"(%244, %242) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %246 = "arith.constant"() <{value = 512 : index}> : () -> index
      %247 = "arith.muli"(%239, %246) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %248 = "arith.addi"(%247, %245) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %249 = "arith.constant"() <{value = 1 : index}> : () -> index
      %250 = "arith.muli"(%237, %249) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %251 = "arith.addi"(%250, %248) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %252 = "arith.constant"() <{value = 16 : index}> : () -> index
      %253 = "arith.muli"(%241, %252) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %254 = "arith.addi"(%253, %251) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %255 = "arith.index_castui"(%254) : (index) -> i32
      %256 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %257 = "arith.muli"(%255, %256) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %258 = "arith.addi"(%204, %257) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %259 = "llvm.inttoptr"(%258) : (i32) -> !llvm.ptr<3>
      "llvm.store"(%233, %259) <{ordering = 0 : i64}> : (vector<8xf16>, !llvm.ptr<3>) -> ()
      "gpu.return"(%233) : (vector<8xf16>) -> ()
    }) {sym_name = "load_store_matrix_blocked_strided_return_vector"} : () -> ()
    "gpu.func"() <{function_type = (memref<4096xi8, 3>) -> vector<8xf16>}> ({
    ^bb0(%arg4: memref<4096xi8, 3>):
      %134 = "memref.extract_aligned_pointer_as_index"(%arg4) : (memref<4096xi8, 3>) -> index
      %135 = "arith.constant"() <{value = 0 : index}> : () -> index
      %136 = "arith.index_castui"(%134) : (index) -> i32
      %137 = "arith.index_castui"(%135) : (index) -> i32
      %138 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %139 = "arith.muli"(%137, %138) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %140 = "arith.addi"(%136, %139) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %141 = "arith.constant"() <{value = 16 : index}> : () -> index
      %142 = "arith.constant"() <{value = 48 : index}> : () -> index
      %143 = "arith.constant"() <{value = 16 : index}> : () -> index
      %144 = "arith.divsi"(%141, %143) : (index, index) -> index
      %145 = "arith.constant"() <{value = 16 : index}> : () -> index
      %146 = "arith.remsi"(%141, %145) : (index, index) -> index
      %147 = "arith.constant"() <{value = 16 : index}> : () -> index
      %148 = "arith.divsi"(%142, %147) : (index, index) -> index
      %149 = "arith.constant"() <{value = 16 : index}> : () -> index
      %150 = "arith.remsi"(%142, %149) : (index, index) -> index
      %151 = "arith.constant"() <{value = 0 : index}> : () -> index
      %152 = "arith.constant"() <{value = 1024 : index}> : () -> index
      %153 = "arith.muli"(%144, %152) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %154 = "arith.addi"(%153, %151) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %155 = "arith.constant"() <{value = 256 : index}> : () -> index
      %156 = "arith.muli"(%148, %155) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %157 = "arith.addi"(%156, %154) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %158 = "arith.constant"() <{value = 16 : index}> : () -> index
      %159 = "arith.muli"(%146, %158) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %160 = "arith.addi"(%159, %157) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %161 = "arith.constant"() <{value = 1 : index}> : () -> index
      %162 = "arith.muli"(%150, %161) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %163 = "arith.addi"(%162, %160) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %164 = "arith.index_castui"(%163) : (index) -> i32
      %165 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %166 = "arith.muli"(%164, %165) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %167 = "arith.addi"(%140, %166) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %168 = "llvm.inttoptr"(%167) : (i32) -> !llvm.ptr<3>
      %169 = "xevm.blockload"(%168) : (!llvm.ptr<3>) -> vector<8xi16>
      %170 = "vector.bitcast"(%169) : (vector<8xi16>) -> vector<8xf16>
      %171 = "arith.constant"() <{value = 16 : index}> : () -> index
      %172 = "arith.divsi"(%141, %171) : (index, index) -> index
      %173 = "arith.constant"() <{value = 16 : index}> : () -> index
      %174 = "arith.remsi"(%141, %173) : (index, index) -> index
      %175 = "arith.constant"() <{value = 16 : index}> : () -> index
      %176 = "arith.divsi"(%142, %175) : (index, index) -> index
      %177 = "arith.constant"() <{value = 16 : index}> : () -> index
      %178 = "arith.remsi"(%142, %177) : (index, index) -> index
      %179 = "arith.constant"() <{value = 0 : index}> : () -> index
      %180 = "arith.constant"() <{value = 1024 : index}> : () -> index
      %181 = "arith.muli"(%172, %180) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %182 = "arith.addi"(%181, %179) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %183 = "arith.constant"() <{value = 256 : index}> : () -> index
      %184 = "arith.muli"(%176, %183) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %185 = "arith.addi"(%184, %182) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %186 = "arith.constant"() <{value = 16 : index}> : () -> index
      %187 = "arith.muli"(%174, %186) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %188 = "arith.addi"(%187, %185) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %189 = "arith.constant"() <{value = 1 : index}> : () -> index
      %190 = "arith.muli"(%178, %189) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %191 = "arith.addi"(%190, %188) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %192 = "arith.index_castui"(%191) : (index) -> i32
      %193 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %194 = "arith.muli"(%192, %193) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %195 = "arith.addi"(%140, %194) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %196 = "llvm.inttoptr"(%195) : (i32) -> !llvm.ptr<3>
      %197 = "vector.bitcast"(%170) : (vector<8xf16>) -> vector<8xi16>
      "xevm.blockstore"(%196, %197) : (!llvm.ptr<3>, vector<8xi16>) -> ()
      "gpu.return"(%170) : (vector<8xf16>) -> ()
    }) {sym_name = "load_store_matrix_blocked_subgroupblockio"} : () -> ()
    "gpu.func"() <{function_type = (!xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16]>>) -> ()}> ({
    ^bb0(%arg3: !xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16]>>):
      %69 = "builtin.unrealized_conversion_cast"(%arg3) : (!xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16]>>) -> i32
      %70 = "arith.constant"() <{value = 16 : index}> : () -> index
      %71 = "arith.constant"() <{value = 16 : index}> : () -> index
      %72 = "arith.divsi"(%70, %71) : (index, index) -> index
      %73 = "arith.constant"() <{value = 16 : index}> : () -> index
      %74 = "arith.constant"() <{value = 16 : index}> : () -> index
      %75 = "arith.remsi"(%73, %74) : (index, index) -> index
      %76 = "arith.constant"() <{value = 0 : index}> : () -> index
      %77 = "arith.constant"() <{value = 16 : index}> : () -> index
      %78 = "arith.divsi"(%76, %77) : (index, index) -> index
      %79 = "arith.constant"() <{value = 0 : index}> : () -> index
      %80 = "arith.constant"() <{value = 16 : index}> : () -> index
      %81 = "arith.remsi"(%79, %80) : (index, index) -> index
      %82 = "arith.constant"() <{value = 0 : index}> : () -> index
      %83 = "arith.constant"() <{value = 1024 : index}> : () -> index
      %84 = "arith.muli"(%72, %83) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %85 = "arith.addi"(%84, %82) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %86 = "arith.constant"() <{value = 256 : index}> : () -> index
      %87 = "arith.muli"(%78, %86) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %88 = "arith.addi"(%87, %85) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %89 = "arith.constant"() <{value = 16 : index}> : () -> index
      %90 = "arith.muli"(%75, %89) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %91 = "arith.addi"(%90, %88) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %92 = "arith.constant"() <{value = 1 : index}> : () -> index
      %93 = "arith.muli"(%81, %92) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %94 = "arith.addi"(%93, %91) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %95 = "arith.index_castui"(%94) : (index) -> i32
      %96 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %97 = "arith.muli"(%95, %96) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %98 = "arith.addi"(%69, %97) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %99 = "llvm.inttoptr"(%98) : (i32) -> !llvm.ptr<3>
      %100 = "llvm.load"(%99) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> vector<16xf16>
      %101 = "vector.shape_cast"(%100) : (vector<16xf16>) -> vector<1x16xf16>
      %102 = "arith.addf"(%101, %101) <{fastmath = #arith.fastmath<none>}> : (vector<1x16xf16>, vector<1x16xf16>) -> vector<1x16xf16>
      %103 = "vector.shape_cast"(%102) : (vector<1x16xf16>) -> vector<16xf16>
      %104 = "arith.constant"() <{value = 16 : index}> : () -> index
      %105 = "arith.constant"() <{value = 16 : index}> : () -> index
      %106 = "arith.divsi"(%104, %105) : (index, index) -> index
      %107 = "arith.constant"() <{value = 16 : index}> : () -> index
      %108 = "arith.constant"() <{value = 16 : index}> : () -> index
      %109 = "arith.remsi"(%107, %108) : (index, index) -> index
      %110 = "arith.constant"() <{value = 0 : index}> : () -> index
      %111 = "arith.constant"() <{value = 16 : index}> : () -> index
      %112 = "arith.divsi"(%110, %111) : (index, index) -> index
      %113 = "arith.constant"() <{value = 0 : index}> : () -> index
      %114 = "arith.constant"() <{value = 16 : index}> : () -> index
      %115 = "arith.remsi"(%113, %114) : (index, index) -> index
      %116 = "arith.constant"() <{value = 0 : index}> : () -> index
      %117 = "arith.constant"() <{value = 1024 : index}> : () -> index
      %118 = "arith.muli"(%106, %117) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %119 = "arith.addi"(%118, %116) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %120 = "arith.constant"() <{value = 256 : index}> : () -> index
      %121 = "arith.muli"(%112, %120) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %122 = "arith.addi"(%121, %119) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %123 = "arith.constant"() <{value = 16 : index}> : () -> index
      %124 = "arith.muli"(%109, %123) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %125 = "arith.addi"(%124, %122) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %126 = "arith.constant"() <{value = 1 : index}> : () -> index
      %127 = "arith.muli"(%115, %126) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %128 = "arith.addi"(%127, %125) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %129 = "arith.index_castui"(%128) : (index) -> i32
      %130 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %131 = "arith.muli"(%129, %130) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %132 = "arith.addi"(%69, %131) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %133 = "llvm.inttoptr"(%132) : (i32) -> !llvm.ptr<3>
      "llvm.store"(%103, %133) <{ordering = 0 : i64}> : (vector<16xf16>, !llvm.ptr<3>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "matrix_vector_materialization"} : () -> ()
    "gpu.func"() <{function_type = (memref<256x16xbf16, 3>) -> vector<1x16xbf16>}> ({
    ^bb0(%arg2: memref<256x16xbf16, 3>):
      %46 = "arith.constant"() <{value = 0 : index}> : () -> index
      %47 = "memref.subview"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 64, 0>, static_sizes = array<i64: 1, 16>, static_strides = array<i64: 1, 1>}> : (memref<256x16xbf16, 3>) -> memref<1x16xbf16, strided<[16, 1], offset: 1024>, 3>
      %48 = "memref.extract_aligned_pointer_as_index"(%47) : (memref<1x16xbf16, strided<[16, 1], offset: 1024>, 3>) -> index
      %49 = "arith.constant"() <{value = 1024 : index}> : () -> index
      %50 = "arith.index_castui"(%48) : (index) -> i32
      %51 = "arith.index_castui"(%49) : (index) -> i32
      %52 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %53 = "arith.muli"(%51, %52) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %54 = "arith.addi"(%50, %53) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %55 = "arith.constant"() <{value = 0 : index}> : () -> index
      %56 = "arith.constant"() <{value = 16 : index}> : () -> index
      %57 = "arith.muli"(%46, %56) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %58 = "arith.addi"(%57, %55) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %59 = "arith.constant"() <{value = 1 : index}> : () -> index
      %60 = "arith.muli"(%46, %59) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %61 = "arith.addi"(%60, %58) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %62 = "arith.index_castui"(%61) : (index) -> i32
      %63 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %64 = "arith.muli"(%62, %63) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %65 = "arith.addi"(%54, %64) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %66 = "llvm.inttoptr"(%65) : (i32) -> !llvm.ptr<3>
      %67 = "llvm.load"(%66) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> vector<16xbf16>
      %68 = "vector.shape_cast"(%67) : (vector<16xbf16>) -> vector<1x16xbf16>
      "gpu.return"(%68) : (vector<1x16xbf16>) -> ()
    }) {sym_name = "create_memdesc_from_subview"} : () -> ()
    "gpu.func"() <{function_type = (memref<1024xi8, 3>) -> vector<1x1xf8E8M0FNU>}> ({
    ^bb0(%arg1: memref<1024xi8, 3>):
      %22 = "memref.extract_aligned_pointer_as_index"(%arg1) : (memref<1024xi8, 3>) -> index
      %23 = "arith.constant"() <{value = 0 : index}> : () -> index
      %24 = "arith.index_castui"(%22) : (index) -> i32
      %25 = "arith.index_castui"(%23) : (index) -> i32
      %26 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %27 = "arith.muli"(%25, %26) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %28 = "arith.addi"(%24, %27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %29 = "arith.constant"() <{value = 0 : index}> : () -> index
      %30 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %31 = "arith.constant"() <{value = 0 : index}> : () -> index
      %32 = "arith.constant"() <{value = 32 : index}> : () -> index
      %33 = "arith.muli"(%29, %32) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %34 = "arith.addi"(%33, %31) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %35 = "arith.constant"() <{value = 1 : index}> : () -> index
      %36 = "arith.muli"(%30, %35) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %37 = "arith.addi"(%36, %34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %38 = "arith.index_castui"(%37) : (index) -> i32
      %39 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %40 = "arith.muli"(%38, %39) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %41 = "arith.addi"(%28, %40) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %42 = "llvm.inttoptr"(%41) : (i32) -> !llvm.ptr<3>
      %43 = "llvm.load"(%42) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> i8
      %44 = "arith.bitcast"(%43) : (i8) -> f8E8M0FNU
      %45 = "vector.broadcast"(%44) : (f8E8M0FNU) -> vector<1x1xf8E8M0FNU>
      "gpu.return"(%45) : (vector<1x1xf8E8M0FNU>) -> ()
    }) {sym_name = "load_matrix_f8e8m0_scalar"} : () -> ()
    "gpu.func"() <{function_type = (memref<1024xi8, 3>) -> vector<8xf8E8M0FNU>}> ({
    ^bb0(%arg0: memref<1024xi8, 3>):
      %0 = "memref.extract_aligned_pointer_as_index"(%arg0) : (memref<1024xi8, 3>) -> index
      %1 = "arith.constant"() <{value = 0 : index}> : () -> index
      %2 = "arith.index_castui"(%0) : (index) -> i32
      %3 = "arith.index_castui"(%1) : (index) -> i32
      %4 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %5 = "arith.muli"(%3, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %6 = "arith.addi"(%2, %5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %7 = "arith.constant"() <{value = 0 : index}> : () -> index
      %8 = "arith.constant"() <{value = 0 : index}> : () -> index
      %9 = "arith.constant"() <{value = 32 : index}> : () -> index
      %10 = "arith.muli"(%7, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %11 = "arith.addi"(%10, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %12 = "arith.constant"() <{value = 1 : index}> : () -> index
      %13 = "arith.muli"(%7, %12) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %14 = "arith.addi"(%13, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %15 = "arith.index_castui"(%14) : (index) -> i32
      %16 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %17 = "arith.muli"(%15, %16) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %18 = "arith.addi"(%6, %17) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %19 = "llvm.inttoptr"(%18) : (i32) -> !llvm.ptr<3>
      %20 = "llvm.load"(%19) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> vector<8xi8>
      %21 = "vector.bitcast"(%20) : (vector<8xi8>) -> vector<8xf8E8M0FNU>
      "gpu.return"(%21) : (vector<8xf8E8M0FNU>) -> ()
    }) {sym_name = "load_matrix_f8e8m0_vector"} : () -> ()
  }) : () -> ()
}) : () -> ()

