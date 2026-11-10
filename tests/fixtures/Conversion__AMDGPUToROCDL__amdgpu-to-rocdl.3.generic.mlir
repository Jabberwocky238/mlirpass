#mmra_tag = #llvm.mmra_tag<"amdgpu-synchronize-as":"local">
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8xi32, #gpu.address_space<global>>) -> memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>, sym_name = "fat_raw_buffer_cast"}> ({
  ^bb0(%arg73: memref<8xi32, #gpu.address_space<global>>):
    %406 = "builtin.unrealized_conversion_cast"(%arg73) : (memref<8xi32, #gpu.address_space<global>>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %407 = "llvm.mlir.constant"() <{value = 32 : i64}> : () -> i64
    %408 = "llvm.extractvalue"(%406) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<1>
    %409 = "llvm.extractvalue"(%406) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %410 = "llvm.extractvalue"(%406) <{position = array<i64: 3>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.array<1 x i64>
    %411 = "llvm.extractvalue"(%406) <{position = array<i64: 4>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.array<1 x i64>
    %412 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %413 = "llvm.mlir.constant"() <{value = 822243328 : i32}> : () -> i32
    %414 = "rocdl.make.buffer.rsrc"(%408, %412, %407, %413) : (!llvm.ptr<1>, i16, i64, i32) -> !llvm.ptr<7>
    %415 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %416 = "llvm.insertvalue"(%415, %414) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<7>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %417 = "llvm.insertvalue"(%416, %414) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<7>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %418 = "llvm.insertvalue"(%417, %409) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %419 = "llvm.insertvalue"(%418, %410) <{position = array<i64: 3>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.array<1 x i64>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %420 = "llvm.insertvalue"(%419, %411) <{position = array<i64: 4>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.array<1 x i64>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %421 = "builtin.unrealized_conversion_cast"(%420) : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>) -> memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>
    "func.return"(%421) : (memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i32, #gpu.address_space<global>>) -> memref<i32, #amdgpu.address_space<fat_raw_buffer>>, sym_name = "fat_raw_buffer_cast_0d"}> ({
  ^bb0(%arg72: memref<i32, #gpu.address_space<global>>):
    %394 = "builtin.unrealized_conversion_cast"(%arg72) : (memref<i32, #gpu.address_space<global>>) -> !llvm.struct<(ptr<1>, ptr<1>, i64)>
    %395 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %396 = "llvm.extractvalue"(%394) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64)>) -> !llvm.ptr<1>
    %397 = "llvm.extractvalue"(%394) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64)>) -> i64
    %398 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %399 = "llvm.mlir.constant"() <{value = 822243328 : i32}> : () -> i32
    %400 = "rocdl.make.buffer.rsrc"(%396, %398, %395, %399) : (!llvm.ptr<1>, i16, i64, i32) -> !llvm.ptr<7>
    %401 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<7>, ptr<7>, i64)>
    %402 = "llvm.insertvalue"(%401, %400) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64)>, !llvm.ptr<7>) -> !llvm.struct<(ptr<7>, ptr<7>, i64)>
    %403 = "llvm.insertvalue"(%402, %400) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64)>, !llvm.ptr<7>) -> !llvm.struct<(ptr<7>, ptr<7>, i64)>
    %404 = "llvm.insertvalue"(%403, %397) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64)>, i64) -> !llvm.struct<(ptr<7>, ptr<7>, i64)>
    %405 = "builtin.unrealized_conversion_cast"(%404) : (!llvm.struct<(ptr<7>, ptr<7>, i64)>) -> memref<i32, #amdgpu.address_space<fat_raw_buffer>>
    "func.return"(%405) : (memref<i32, #amdgpu.address_space<fat_raw_buffer>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi32, strided<[1], offset: ?>, #gpu.address_space<global>>) -> memref<?xi32, strided<[1], offset: ?>, #amdgpu.address_space<fat_raw_buffer>>, sym_name = "fat_raw_buffer_cast_dyn_size_offset"}> ({
  ^bb0(%arg71: memref<?xi32, strided<[1], offset: ?>, #gpu.address_space<global>>):
    %374 = "builtin.unrealized_conversion_cast"(%arg71) : (memref<?xi32, strided<[1], offset: ?>, #gpu.address_space<global>>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %375 = "llvm.extractvalue"(%374) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %376 = "llvm.extractvalue"(%374) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %377 = "llvm.mul"(%375, %376) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %378 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %379 = "llvm.mul"(%377, %378) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %380 = "llvm.extractvalue"(%374) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<1>
    %381 = "llvm.extractvalue"(%374) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %382 = "llvm.extractvalue"(%374) <{position = array<i64: 3>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.array<1 x i64>
    %383 = "llvm.extractvalue"(%374) <{position = array<i64: 4>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.array<1 x i64>
    %384 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %385 = "llvm.mlir.constant"() <{value = 822243328 : i32}> : () -> i32
    %386 = "rocdl.make.buffer.rsrc"(%380, %384, %379, %385) : (!llvm.ptr<1>, i16, i64, i32) -> !llvm.ptr<7>
    %387 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %388 = "llvm.insertvalue"(%387, %386) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<7>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %389 = "llvm.insertvalue"(%388, %386) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<7>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %390 = "llvm.insertvalue"(%389, %381) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %391 = "llvm.insertvalue"(%390, %382) <{position = array<i64: 3>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.array<1 x i64>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %392 = "llvm.insertvalue"(%391, %383) <{position = array<i64: 4>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.array<1 x i64>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %393 = "builtin.unrealized_conversion_cast"(%392) : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>) -> memref<?xi32, strided<[1], offset: ?>, #amdgpu.address_space<fat_raw_buffer>>
    "func.return"(%393) : (memref<?xi32, strided<[1], offset: ?>, #amdgpu.address_space<fat_raw_buffer>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi32, strided<[1], offset: ?>, #gpu.address_space<global>>) -> memref<?xi32, #amdgpu.address_space<fat_raw_buffer>>, sym_name = "fat_raw_buffer_cast_reset_offset"}> ({
  ^bb0(%arg70: memref<?xi32, strided<[1], offset: ?>, #gpu.address_space<global>>):
    %352 = "builtin.unrealized_conversion_cast"(%arg70) : (memref<?xi32, strided<[1], offset: ?>, #gpu.address_space<global>>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %353 = "llvm.extractvalue"(%352) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %354 = "llvm.extractvalue"(%352) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %355 = "llvm.mul"(%353, %354) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %356 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %357 = "llvm.mul"(%355, %356) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %358 = "llvm.extractvalue"(%352) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<1>
    %359 = "llvm.extractvalue"(%352) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %360 = "llvm.getelementptr"(%358, %359) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>
    %361 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %362 = "llvm.extractvalue"(%352) <{position = array<i64: 3>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.array<1 x i64>
    %363 = "llvm.extractvalue"(%352) <{position = array<i64: 4>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.array<1 x i64>
    %364 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %365 = "llvm.mlir.constant"() <{value = 822243328 : i32}> : () -> i32
    %366 = "rocdl.make.buffer.rsrc"(%360, %364, %357, %365) : (!llvm.ptr<1>, i16, i64, i32) -> !llvm.ptr<7>
    %367 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %368 = "llvm.insertvalue"(%367, %366) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<7>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %369 = "llvm.insertvalue"(%368, %366) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<7>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %370 = "llvm.insertvalue"(%369, %361) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %371 = "llvm.insertvalue"(%370, %362) <{position = array<i64: 3>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.array<1 x i64>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %372 = "llvm.insertvalue"(%371, %363) <{position = array<i64: 4>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.array<1 x i64>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %373 = "builtin.unrealized_conversion_cast"(%372) : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>) -> memref<?xi32, #amdgpu.address_space<fat_raw_buffer>>
    "func.return"(%373) : (memref<?xi32, #amdgpu.address_space<fat_raw_buffer>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<8xi32, #gpu.address_space<global>>) -> memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>, sym_name = "fat_raw_buffer_cast_valid_bytes"}> ({
  ^bb0(%arg69: memref<8xi32, #gpu.address_space<global>>):
    %336 = "builtin.unrealized_conversion_cast"(%arg69) : (memref<8xi32, #gpu.address_space<global>>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %337 = "arith.constant"() <{value = -1 : i64}> : () -> i64
    %338 = "llvm.extractvalue"(%336) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<1>
    %339 = "llvm.extractvalue"(%336) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %340 = "llvm.extractvalue"(%336) <{position = array<i64: 3>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.array<1 x i64>
    %341 = "llvm.extractvalue"(%336) <{position = array<i64: 4>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.array<1 x i64>
    %342 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %343 = "llvm.mlir.constant"() <{value = 822243328 : i32}> : () -> i32
    %344 = "rocdl.make.buffer.rsrc"(%338, %342, %337, %343) : (!llvm.ptr<1>, i16, i64, i32) -> !llvm.ptr<7>
    %345 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %346 = "llvm.insertvalue"(%345, %344) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<7>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %347 = "llvm.insertvalue"(%346, %344) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<7>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %348 = "llvm.insertvalue"(%347, %339) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %349 = "llvm.insertvalue"(%348, %340) <{position = array<i64: 3>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.array<1 x i64>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %350 = "llvm.insertvalue"(%349, %341) <{position = array<i64: 4>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.array<1 x i64>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %351 = "builtin.unrealized_conversion_cast"(%350) : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>) -> memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>
    "func.return"(%351) : (memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<8xi32, #gpu.address_space<global>>) -> memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>, sym_name = "fat_raw_buffer_cast_bounds_check"}> ({
  ^bb0(%arg68: memref<8xi32, #gpu.address_space<global>>):
    %320 = "builtin.unrealized_conversion_cast"(%arg68) : (memref<8xi32, #gpu.address_space<global>>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %321 = "llvm.mlir.constant"() <{value = 32 : i64}> : () -> i64
    %322 = "llvm.extractvalue"(%320) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<1>
    %323 = "llvm.extractvalue"(%320) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %324 = "llvm.extractvalue"(%320) <{position = array<i64: 3>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.array<1 x i64>
    %325 = "llvm.extractvalue"(%320) <{position = array<i64: 4>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.array<1 x i64>
    %326 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %327 = "llvm.mlir.constant"() <{value = 553807872 : i32}> : () -> i32
    %328 = "rocdl.make.buffer.rsrc"(%322, %326, %321, %327) : (!llvm.ptr<1>, i16, i64, i32) -> !llvm.ptr<7>
    %329 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %330 = "llvm.insertvalue"(%329, %328) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<7>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %331 = "llvm.insertvalue"(%330, %328) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<7>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %332 = "llvm.insertvalue"(%331, %323) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %333 = "llvm.insertvalue"(%332, %324) <{position = array<i64: 3>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.array<1 x i64>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %334 = "llvm.insertvalue"(%333, %325) <{position = array<i64: 4>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.array<1 x i64>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %335 = "builtin.unrealized_conversion_cast"(%334) : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>) -> memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>
    "func.return"(%335) : (memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64x64xi32, #gpu.address_space<global>>, i14) -> memref<64x64xi32, #amdgpu.address_space<fat_raw_buffer>>, sym_name = "fat_raw_buffer_cast_cache_swizzle"}> ({
  ^bb0(%arg66: memref<64x64xi32, #gpu.address_space<global>>, %arg67: i14):
    %304 = "builtin.unrealized_conversion_cast"(%arg66) : (memref<64x64xi32, #gpu.address_space<global>>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
    %305 = "llvm.mlir.constant"() <{value = 16384 : i64}> : () -> i64
    %306 = "llvm.extractvalue"(%304) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<1>
    %307 = "llvm.extractvalue"(%304) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %308 = "llvm.extractvalue"(%304) <{position = array<i64: 3>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.array<2 x i64>
    %309 = "llvm.extractvalue"(%304) <{position = array<i64: 4>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.array<2 x i64>
    %310 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %311 = "llvm.mlir.constant"() <{value = 822243328 : i32}> : () -> i32
    %312 = "rocdl.make.buffer.rsrc"(%306, %310, %305, %311) : (!llvm.ptr<1>, i16, i64, i32) -> !llvm.ptr<7>
    %313 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>
    %314 = "llvm.insertvalue"(%313, %312) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr<7>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>
    %315 = "llvm.insertvalue"(%314, %312) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr<7>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>
    %316 = "llvm.insertvalue"(%315, %307) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>
    %317 = "llvm.insertvalue"(%316, %308) <{position = array<i64: 3>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>, !llvm.array<2 x i64>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>
    %318 = "llvm.insertvalue"(%317, %309) <{position = array<i64: 4>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>, !llvm.array<2 x i64>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>
    %319 = "builtin.unrealized_conversion_cast"(%318) : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>) -> memref<64x64xi32, #amdgpu.address_space<fat_raw_buffer>>
    "func.return"(%319) : (memref<64x64xi32, #amdgpu.address_space<fat_raw_buffer>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i32>) -> i32, sym_name = "gpu_gcn_raw_buffer_load_scalar_i32"}> ({
  ^bb0(%arg65: memref<i32>):
    %292 = "builtin.unrealized_conversion_cast"(%arg65) : (memref<i32>) -> !llvm.struct<(ptr, ptr, i64)>
    %293 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %294 = "llvm.extractvalue"(%292) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
    %295 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %296 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %297 = "llvm.mlir.constant"() <{value = 822243328 : i32}> : () -> i32
    %298 = "rocdl.make.buffer.rsrc"(%294, %296, %295, %297) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %299 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %300 = "llvm.mul"(%299, %293) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %301 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %302 = "llvm.mul"(%301, %293) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %303 = "rocdl.raw.ptr.buffer.load"(%298, %300, %302) <{aux = 0 : i32}> : (!llvm.ptr<8>, i32, i32) -> i32
    "func.return"(%303) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64xi32>, i32) -> i32, sym_name = "gpu_gcn_raw_buffer_load_i32"}> ({
  ^bb0(%arg63: memref<64xi32>, %arg64: i32):
    %281 = "builtin.unrealized_conversion_cast"(%arg63) : (memref<64xi32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %282 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %283 = "llvm.extractvalue"(%281) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %284 = "llvm.mlir.constant"() <{value = 256 : i64}> : () -> i64
    %285 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %286 = "llvm.mlir.constant"() <{value = 822243328 : i32}> : () -> i32
    %287 = "rocdl.make.buffer.rsrc"(%283, %285, %284, %286) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %288 = "llvm.mul"(%arg64, %282) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %289 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %290 = "llvm.mul"(%289, %282) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %291 = "rocdl.raw.ptr.buffer.load"(%287, %288, %290) <{aux = 0 : i32}> : (!llvm.ptr<8>, i32, i32) -> i32
    "func.return"(%291) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16x16xi32, strided<[?, ?], offset: ?>>, i32, i32) -> i32, sym_name = "gpu_gcn_raw_buffer_load_i32_strided"}> ({
  ^bb0(%arg60: memref<16x16xi32, strided<[?, ?], offset: ?>>, %arg61: i32, %arg62: i32):
    %253 = "builtin.unrealized_conversion_cast"(%arg60) : (memref<16x16xi32, strided<[?, ?], offset: ?>>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %254 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %255 = "llvm.extractvalue"(%253) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %256 = "llvm.extractvalue"(%253) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %257 = "llvm.getelementptr"(%255, %256) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %258 = "llvm.extractvalue"(%253) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %259 = "llvm.extractvalue"(%253) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %260 = "llvm.mul"(%258, %259) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %261 = "llvm.extractvalue"(%253) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %262 = "llvm.extractvalue"(%253) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %263 = "llvm.mul"(%261, %262) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %264 = "llvm.intr.umax"(%260, %263) : (i64, i64) -> i64
    %265 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %266 = "llvm.mul"(%264, %265) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %267 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %268 = "llvm.mlir.constant"() <{value = 822243328 : i32}> : () -> i32
    %269 = "rocdl.make.buffer.rsrc"(%257, %267, %266, %268) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %270 = "llvm.extractvalue"(%253) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %271 = "llvm.trunc"(%270) <{overflowFlags = 0 : i32}> : (i64) -> i32
    %272 = "llvm.mul"(%arg61, %271) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %273 = "llvm.extractvalue"(%253) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %274 = "llvm.trunc"(%273) <{overflowFlags = 0 : i32}> : (i64) -> i32
    %275 = "llvm.mul"(%arg62, %274) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %276 = "llvm.add"(%272, %275) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %277 = "llvm.mul"(%276, %254) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %278 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %279 = "llvm.mul"(%278, %254) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %280 = "rocdl.raw.ptr.buffer.load"(%269, %277, %279) <{aux = 0 : i32}> : (!llvm.ptr<8>, i32, i32) -> i32
    "func.return"(%280) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64xi32>, i32) -> i32, sym_name = "gpu_gcn_raw_buffer_load_i32_oob_off"}> ({
  ^bb0(%arg58: memref<64xi32>, %arg59: i32):
    %242 = "builtin.unrealized_conversion_cast"(%arg58) : (memref<64xi32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %243 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %244 = "llvm.extractvalue"(%242) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %245 = "llvm.mlir.constant"() <{value = 256 : i64}> : () -> i64
    %246 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %247 = "llvm.mlir.constant"() <{value = 553807872 : i32}> : () -> i32
    %248 = "rocdl.make.buffer.rsrc"(%244, %246, %245, %247) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %249 = "llvm.mul"(%arg59, %243) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %250 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %251 = "llvm.mul"(%250, %243) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %252 = "rocdl.raw.ptr.buffer.load"(%248, %249, %251) <{aux = 0 : i32}> : (!llvm.ptr<8>, i32, i32) -> i32
    "func.return"(%252) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64xi32>, i32) -> vector<1xi32>, sym_name = "gpu_gcn_raw_buffer_load_1xi32"}> ({
  ^bb0(%arg56: memref<64xi32>, %arg57: i32):
    %230 = "builtin.unrealized_conversion_cast"(%arg56) : (memref<64xi32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %231 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %232 = "llvm.extractvalue"(%230) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %233 = "llvm.mlir.constant"() <{value = 256 : i64}> : () -> i64
    %234 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %235 = "llvm.mlir.constant"() <{value = 822243328 : i32}> : () -> i32
    %236 = "rocdl.make.buffer.rsrc"(%232, %234, %233, %235) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %237 = "llvm.mul"(%arg57, %231) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %238 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %239 = "llvm.mul"(%238, %231) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %240 = "rocdl.raw.ptr.buffer.load"(%236, %237, %239) <{aux = 0 : i32}> : (!llvm.ptr<8>, i32, i32) -> i32
    %241 = "llvm.bitcast"(%240) : (i32) -> vector<1xi32>
    "func.return"(%241) : (vector<1xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64xi32>, i32) -> vector<2xi32>, sym_name = "gpu_gcn_raw_buffer_load_2xi32"}> ({
  ^bb0(%arg54: memref<64xi32>, %arg55: i32):
    %219 = "builtin.unrealized_conversion_cast"(%arg54) : (memref<64xi32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %220 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %221 = "llvm.extractvalue"(%219) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %222 = "llvm.mlir.constant"() <{value = 256 : i64}> : () -> i64
    %223 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %224 = "llvm.mlir.constant"() <{value = 822243328 : i32}> : () -> i32
    %225 = "rocdl.make.buffer.rsrc"(%221, %223, %222, %224) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %226 = "llvm.mul"(%arg55, %220) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %227 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %228 = "llvm.mul"(%227, %220) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %229 = "rocdl.raw.ptr.buffer.load"(%225, %226, %228) <{aux = 0 : i32}> : (!llvm.ptr<8>, i32, i32) -> vector<2xi32>
    "func.return"(%229) : (vector<2xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64xi8>, i32) -> i8, sym_name = "gpu_gcn_raw_buffer_load_i8"}> ({
  ^bb0(%arg52: memref<64xi8>, %arg53: i32):
    %208 = "builtin.unrealized_conversion_cast"(%arg52) : (memref<64xi8>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %209 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %210 = "llvm.extractvalue"(%208) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %211 = "llvm.mlir.constant"() <{value = 64 : i64}> : () -> i64
    %212 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %213 = "llvm.mlir.constant"() <{value = 822243328 : i32}> : () -> i32
    %214 = "rocdl.make.buffer.rsrc"(%210, %212, %211, %213) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %215 = "llvm.mul"(%arg53, %209) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %216 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %217 = "llvm.mul"(%216, %209) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %218 = "rocdl.raw.ptr.buffer.load"(%214, %215, %217) <{aux = 0 : i32}> : (!llvm.ptr<8>, i32, i32) -> i8
    "func.return"(%218) : (i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64xi8>, i32) -> vector<2xi8>, sym_name = "gpu_gcn_raw_buffer_load_2xi8"}> ({
  ^bb0(%arg50: memref<64xi8>, %arg51: i32):
    %196 = "builtin.unrealized_conversion_cast"(%arg50) : (memref<64xi8>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %197 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %198 = "llvm.extractvalue"(%196) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %199 = "llvm.mlir.constant"() <{value = 64 : i64}> : () -> i64
    %200 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %201 = "llvm.mlir.constant"() <{value = 822243328 : i32}> : () -> i32
    %202 = "rocdl.make.buffer.rsrc"(%198, %200, %199, %201) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %203 = "llvm.mul"(%arg51, %197) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %204 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %205 = "llvm.mul"(%204, %197) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %206 = "rocdl.raw.ptr.buffer.load"(%202, %203, %205) <{aux = 0 : i32}> : (!llvm.ptr<8>, i32, i32) -> i16
    %207 = "llvm.bitcast"(%206) : (i16) -> vector<2xi8>
    "func.return"(%207) : (vector<2xi8>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64xi8>, i32) -> vector<16xi8>, sym_name = "gpu_gcn_raw_buffer_load_16xi8"}> ({
  ^bb0(%arg48: memref<64xi8>, %arg49: i32):
    %184 = "builtin.unrealized_conversion_cast"(%arg48) : (memref<64xi8>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %185 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %186 = "llvm.extractvalue"(%184) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %187 = "llvm.mlir.constant"() <{value = 64 : i64}> : () -> i64
    %188 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %189 = "llvm.mlir.constant"() <{value = 822243328 : i32}> : () -> i32
    %190 = "rocdl.make.buffer.rsrc"(%186, %188, %187, %189) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %191 = "llvm.mul"(%arg49, %185) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %192 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %193 = "llvm.mul"(%192, %185) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %194 = "rocdl.raw.ptr.buffer.load"(%190, %191, %193) <{aux = 0 : i32}> : (!llvm.ptr<8>, i32, i32) -> vector<4xi32>
    %195 = "llvm.bitcast"(%194) : (vector<4xi32>) -> vector<16xi8>
    "func.return"(%195) : (vector<16xi8>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64xf8E5M2FNUZ>, i32) -> f8E5M2FNUZ, sym_name = "gpu_gcn_raw_buffer_load_f8E5M2FNUZ"}> ({
  ^bb0(%arg46: memref<64xf8E5M2FNUZ>, %arg47: i32):
    %172 = "builtin.unrealized_conversion_cast"(%arg46) : (memref<64xf8E5M2FNUZ>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %173 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %174 = "llvm.extractvalue"(%172) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %175 = "llvm.mlir.constant"() <{value = 64 : i64}> : () -> i64
    %176 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %177 = "llvm.mlir.constant"() <{value = 822243328 : i32}> : () -> i32
    %178 = "rocdl.make.buffer.rsrc"(%174, %176, %175, %177) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %179 = "llvm.mul"(%arg47, %173) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %180 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %181 = "llvm.mul"(%180, %173) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %182 = "rocdl.raw.ptr.buffer.load"(%178, %179, %181) <{aux = 0 : i32}> : (!llvm.ptr<8>, i32, i32) -> i8
    %183 = "builtin.unrealized_conversion_cast"(%182) : (i8) -> f8E5M2FNUZ
    "func.return"(%183) : (f8E5M2FNUZ) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64xf8E4M3FNUZ>, i32) -> vector<4xf8E4M3FNUZ>, sym_name = "gpu_gcn_raw_buffer_load_4xf8E4M3FNUZ"}> ({
  ^bb0(%arg44: memref<64xf8E4M3FNUZ>, %arg45: i32):
    %159 = "builtin.unrealized_conversion_cast"(%arg44) : (memref<64xf8E4M3FNUZ>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %160 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %161 = "llvm.extractvalue"(%159) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %162 = "llvm.mlir.constant"() <{value = 64 : i64}> : () -> i64
    %163 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %164 = "llvm.mlir.constant"() <{value = 822243328 : i32}> : () -> i32
    %165 = "rocdl.make.buffer.rsrc"(%161, %163, %162, %164) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %166 = "llvm.mul"(%arg45, %160) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %167 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %168 = "llvm.mul"(%167, %160) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %169 = "rocdl.raw.ptr.buffer.load"(%165, %166, %168) <{aux = 0 : i32}> : (!llvm.ptr<8>, i32, i32) -> i32
    %170 = "llvm.bitcast"(%169) : (i32) -> vector<4xi8>
    %171 = "builtin.unrealized_conversion_cast"(%170) : (vector<4xi8>) -> vector<4xf8E4M3FNUZ>
    "func.return"(%171) : (vector<4xf8E4M3FNUZ>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, memref<i32>) -> (), sym_name = "gpu_gcn_raw_buffer_store_scalar_i32"}> ({
  ^bb0(%arg42: i32, %arg43: memref<i32>):
    %148 = "builtin.unrealized_conversion_cast"(%arg43) : (memref<i32>) -> !llvm.struct<(ptr, ptr, i64)>
    %149 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %150 = "llvm.extractvalue"(%148) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
    %151 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %152 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %153 = "llvm.mlir.constant"() <{value = 822243328 : i32}> : () -> i32
    %154 = "rocdl.make.buffer.rsrc"(%150, %152, %151, %153) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %155 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %156 = "llvm.mul"(%155, %149) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %157 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %158 = "llvm.mul"(%157, %149) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "rocdl.raw.ptr.buffer.store"(%arg42, %154, %156, %158) <{aux = 0 : i32}> : (i32, !llvm.ptr<8>, i32, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, memref<64xi32>, i32) -> (), sym_name = "gpu_gcn_raw_buffer_store_i32"}> ({
  ^bb0(%arg39: i32, %arg40: memref<64xi32>, %arg41: i32):
    %138 = "builtin.unrealized_conversion_cast"(%arg40) : (memref<64xi32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %139 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %140 = "llvm.extractvalue"(%138) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %141 = "llvm.mlir.constant"() <{value = 256 : i64}> : () -> i64
    %142 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %143 = "llvm.mlir.constant"() <{value = 822243328 : i32}> : () -> i32
    %144 = "rocdl.make.buffer.rsrc"(%140, %142, %141, %143) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %145 = "llvm.mul"(%arg41, %139) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %146 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %147 = "llvm.mul"(%146, %139) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "rocdl.raw.ptr.buffer.store"(%arg39, %144, %145, %147) <{aux = 0 : i32}> : (i32, !llvm.ptr<8>, i32, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf32>, memref<64xf32>, i32) -> (), sym_name = "gpu_gcn_raw_buffer_store_1xf32"}> ({
  ^bb0(%arg36: vector<1xf32>, %arg37: memref<64xf32>, %arg38: i32):
    %127 = "builtin.unrealized_conversion_cast"(%arg37) : (memref<64xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %128 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %129 = "llvm.bitcast"(%arg36) : (vector<1xf32>) -> f32
    %130 = "llvm.extractvalue"(%127) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %131 = "llvm.mlir.constant"() <{value = 256 : i64}> : () -> i64
    %132 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %133 = "llvm.mlir.constant"() <{value = 822243328 : i32}> : () -> i32
    %134 = "rocdl.make.buffer.rsrc"(%130, %132, %131, %133) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %135 = "llvm.mul"(%arg38, %128) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %136 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %137 = "llvm.mul"(%136, %128) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "rocdl.raw.ptr.buffer.store"(%129, %134, %135, %137) <{aux = 0 : i32}> : (f32, !llvm.ptr<8>, i32, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi8>, memref<64xi8>, i32) -> (), sym_name = "gpu_gcn_raw_buffer_store_2xi8"}> ({
  ^bb0(%arg33: vector<2xi8>, %arg34: memref<64xi8>, %arg35: i32):
    %116 = "builtin.unrealized_conversion_cast"(%arg34) : (memref<64xi8>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %117 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %118 = "llvm.bitcast"(%arg33) : (vector<2xi8>) -> i16
    %119 = "llvm.extractvalue"(%116) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %120 = "llvm.mlir.constant"() <{value = 64 : i64}> : () -> i64
    %121 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %122 = "llvm.mlir.constant"() <{value = 822243328 : i32}> : () -> i32
    %123 = "rocdl.make.buffer.rsrc"(%119, %121, %120, %122) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %124 = "llvm.mul"(%arg35, %117) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %125 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %126 = "llvm.mul"(%125, %117) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "rocdl.raw.ptr.buffer.store"(%118, %123, %124, %126) <{aux = 0 : i32}> : (i16, !llvm.ptr<8>, i32, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<16xi8>, memref<64xi8>, i32) -> (), sym_name = "gpu_gcn_raw_buffer_store_16xi8"}> ({
  ^bb0(%arg30: vector<16xi8>, %arg31: memref<64xi8>, %arg32: i32):
    %105 = "builtin.unrealized_conversion_cast"(%arg31) : (memref<64xi8>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %106 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %107 = "llvm.bitcast"(%arg30) : (vector<16xi8>) -> vector<4xi32>
    %108 = "llvm.extractvalue"(%105) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %109 = "llvm.mlir.constant"() <{value = 64 : i64}> : () -> i64
    %110 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %111 = "llvm.mlir.constant"() <{value = 822243328 : i32}> : () -> i32
    %112 = "rocdl.make.buffer.rsrc"(%108, %110, %109, %111) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %113 = "llvm.mul"(%arg32, %106) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %114 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %115 = "llvm.mul"(%114, %106) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "rocdl.raw.ptr.buffer.store"(%107, %112, %113, %115) <{aux = 0 : i32}> : (vector<4xi32>, !llvm.ptr<8>, i32, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, memref<64xf32>, i32) -> f32, sym_name = "gpu_gcn_raw_buffer_atomic_fadd_f32"}> ({
  ^bb0(%arg27: f32, %arg28: memref<64xf32>, %arg29: i32):
    %94 = "builtin.unrealized_conversion_cast"(%arg28) : (memref<64xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %95 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %96 = "llvm.extractvalue"(%94) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %97 = "llvm.mlir.constant"() <{value = 256 : i64}> : () -> i64
    %98 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %99 = "llvm.mlir.constant"() <{value = 822243328 : i32}> : () -> i32
    %100 = "rocdl.make.buffer.rsrc"(%96, %98, %97, %99) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %101 = "llvm.mul"(%arg29, %95) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %102 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %103 = "llvm.mul"(%102, %95) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %104 = "rocdl.raw.ptr.buffer.atomic.fadd"(%arg27, %100, %101, %103) <{aux = 0 : i32}> : (f32, !llvm.ptr<8>, i32, i32) -> f32
    "func.return"(%104) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf16>, memref<64xf16>, i32) -> vector<2xf16>, sym_name = "gpu_gcn_raw_buffer_atomic_fadd_v2f16"}> ({
  ^bb0(%arg24: vector<2xf16>, %arg25: memref<64xf16>, %arg26: i32):
    %83 = "builtin.unrealized_conversion_cast"(%arg25) : (memref<64xf16>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %84 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %85 = "llvm.extractvalue"(%83) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %86 = "llvm.mlir.constant"() <{value = 128 : i64}> : () -> i64
    %87 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %88 = "llvm.mlir.constant"() <{value = 822243328 : i32}> : () -> i32
    %89 = "rocdl.make.buffer.rsrc"(%85, %87, %86, %88) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %90 = "llvm.mul"(%arg26, %84) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %91 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %92 = "llvm.mul"(%91, %84) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %93 = "rocdl.raw.ptr.buffer.atomic.fadd"(%arg24, %89, %90, %92) <{aux = 0 : i32}> : (vector<2xf16>, !llvm.ptr<8>, i32, i32) -> vector<2xf16>
    "func.return"(%93) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xbf16>, memref<64xbf16>, i32) -> vector<2xbf16>, sym_name = "gpu_gcn_raw_buffer_atomic_fadd_v2bf16"}> ({
  ^bb0(%arg21: vector<2xbf16>, %arg22: memref<64xbf16>, %arg23: i32):
    %72 = "builtin.unrealized_conversion_cast"(%arg22) : (memref<64xbf16>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %73 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %74 = "llvm.extractvalue"(%72) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %75 = "llvm.mlir.constant"() <{value = 128 : i64}> : () -> i64
    %76 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %77 = "llvm.mlir.constant"() <{value = 822243328 : i32}> : () -> i32
    %78 = "rocdl.make.buffer.rsrc"(%74, %76, %75, %77) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %79 = "llvm.mul"(%arg23, %73) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %80 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %81 = "llvm.mul"(%80, %73) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %82 = "rocdl.raw.ptr.buffer.atomic.fadd"(%arg21, %78, %79, %81) <{aux = 0 : i32}> : (vector<2xbf16>, !llvm.ptr<8>, i32, i32) -> vector<2xbf16>
    "func.return"(%82) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, memref<64xf32>, i32) -> f32, sym_name = "gpu_gcn_raw_buffer_atomic_fmax_f32"}> ({
  ^bb0(%arg18: f32, %arg19: memref<64xf32>, %arg20: i32):
    %61 = "builtin.unrealized_conversion_cast"(%arg19) : (memref<64xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %62 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %63 = "llvm.extractvalue"(%61) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %64 = "llvm.mlir.constant"() <{value = 256 : i64}> : () -> i64
    %65 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %66 = "llvm.mlir.constant"() <{value = 822243328 : i32}> : () -> i32
    %67 = "rocdl.make.buffer.rsrc"(%63, %65, %64, %66) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %68 = "llvm.mul"(%arg20, %62) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %69 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %70 = "llvm.mul"(%69, %62) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %71 = "rocdl.raw.ptr.buffer.atomic.fmax"(%arg18, %67, %68, %70) <{aux = 0 : i32}> : (f32, !llvm.ptr<8>, i32, i32) -> f32
    "func.return"(%71) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, memref<64xi32>, i32) -> i32, sym_name = "gpu_gcn_raw_buffer_atomic_smax_i32"}> ({
  ^bb0(%arg15: i32, %arg16: memref<64xi32>, %arg17: i32):
    %50 = "builtin.unrealized_conversion_cast"(%arg16) : (memref<64xi32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %51 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %52 = "llvm.extractvalue"(%50) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %53 = "llvm.mlir.constant"() <{value = 256 : i64}> : () -> i64
    %54 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %55 = "llvm.mlir.constant"() <{value = 822243328 : i32}> : () -> i32
    %56 = "rocdl.make.buffer.rsrc"(%52, %54, %53, %55) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %57 = "llvm.mul"(%arg17, %51) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %58 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %59 = "llvm.mul"(%58, %51) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %60 = "rocdl.raw.ptr.buffer.atomic.smax"(%arg15, %56, %57, %59) <{aux = 0 : i32}> : (i32, !llvm.ptr<8>, i32, i32) -> i32
    "func.return"(%60) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, memref<64xi32>, i32) -> i32, sym_name = "gpu_gcn_raw_buffer_atomic_umin_i32"}> ({
  ^bb0(%arg12: i32, %arg13: memref<64xi32>, %arg14: i32):
    %39 = "builtin.unrealized_conversion_cast"(%arg13) : (memref<64xi32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %40 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %41 = "llvm.extractvalue"(%39) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %42 = "llvm.mlir.constant"() <{value = 256 : i64}> : () -> i64
    %43 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %44 = "llvm.mlir.constant"() <{value = 822243328 : i32}> : () -> i32
    %45 = "rocdl.make.buffer.rsrc"(%41, %43, %42, %44) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %46 = "llvm.mul"(%arg14, %40) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %47 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %48 = "llvm.mul"(%47, %40) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %49 = "rocdl.raw.ptr.buffer.atomic.umin"(%arg12, %45, %46, %48) <{aux = 0 : i32}> : (i32, !llvm.ptr<8>, i32, i32) -> i32
    "func.return"(%49) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, memref<64xf32>, i32) -> f32, sym_name = "amdgpu_raw_buffer_atomic_cmpswap_f32"}> ({
  ^bb0(%arg8: f32, %arg9: f32, %arg10: memref<64xf32>, %arg11: i32):
    %25 = "builtin.unrealized_conversion_cast"(%arg10) : (memref<64xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %26 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %27 = "llvm.bitcast"(%arg8) : (f32) -> i32
    %28 = "llvm.bitcast"(%arg9) : (f32) -> i32
    %29 = "llvm.extractvalue"(%25) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %30 = "llvm.mlir.constant"() <{value = 256 : i64}> : () -> i64
    %31 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %32 = "llvm.mlir.constant"() <{value = 822243328 : i32}> : () -> i32
    %33 = "rocdl.make.buffer.rsrc"(%29, %31, %30, %32) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %34 = "llvm.mul"(%arg11, %26) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %35 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %36 = "llvm.mul"(%35, %26) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %37 = "rocdl.raw.ptr.buffer.atomic.cmpswap"(%27, %28, %33, %34, %36) <{aux = 0 : i32}> : (i32, i32, !llvm.ptr<8>, i32, i32) -> i32
    %38 = "llvm.bitcast"(%37) : (i32) -> f32
    "func.return"(%38) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64, i64, memref<64xi64>, i32) -> i64, sym_name = "amdgpu_raw_buffer_atomic_cmpswap_i64"}> ({
  ^bb0(%arg4: i64, %arg5: i64, %arg6: memref<64xi64>, %arg7: i32):
    %14 = "builtin.unrealized_conversion_cast"(%arg6) : (memref<64xi64>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %15 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
    %16 = "llvm.extractvalue"(%14) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %17 = "llvm.mlir.constant"() <{value = 512 : i64}> : () -> i64
    %18 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %19 = "llvm.mlir.constant"() <{value = 822243328 : i32}> : () -> i32
    %20 = "rocdl.make.buffer.rsrc"(%16, %18, %17, %19) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %21 = "llvm.mul"(%arg7, %15) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %22 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %23 = "llvm.mul"(%22, %15) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %24 = "rocdl.raw.ptr.buffer.atomic.cmpswap"(%arg4, %arg5, %20, %21, %23) <{aux = 0 : i32}> : (i64, i64, !llvm.ptr<8>, i32, i32) -> i64
    "func.return"(%24) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf16>, vector<2xf16>, memref<64xf16>, i32) -> vector<2xf16>, sym_name = "amdgpu_raw_buffer_atomic_cmpswap_v2f16"}> ({
  ^bb0(%arg0: vector<2xf16>, %arg1: vector<2xf16>, %arg2: memref<64xf16>, %arg3: i32):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<64xf16>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %2 = "llvm.bitcast"(%arg0) : (vector<2xf16>) -> i32
    %3 = "llvm.bitcast"(%arg1) : (vector<2xf16>) -> i32
    %4 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %5 = "llvm.mlir.constant"() <{value = 128 : i64}> : () -> i64
    %6 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %7 = "llvm.mlir.constant"() <{value = 822243328 : i32}> : () -> i32
    %8 = "rocdl.make.buffer.rsrc"(%4, %6, %5, %7) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %9 = "llvm.mul"(%arg3, %1) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %10 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %11 = "llvm.mul"(%10, %1) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %12 = "rocdl.raw.ptr.buffer.atomic.cmpswap"(%2, %3, %8, %9, %11) <{aux = 0 : i32}> : (i32, i32, !llvm.ptr<8>, i32, i32) -> i32
    %13 = "llvm.bitcast"(%12) : (i32) -> vector<2xf16>
    "func.return"(%13) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "lds_barrier"}> ({
    "llvm.fence"() <{ordering = 5 : i64, syncscope = "workgroup"}> {llvm.mmra = #mmra_tag} : () -> ()
    "rocdl.s.barrier"() : () -> ()
    "llvm.fence"() <{ordering = 4 : i64, syncscope = "workgroup"}> {llvm.mmra = #mmra_tag} : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "sched_barrier"}> ({
    "rocdl.sched.barrier"() <{mask = #rocdl<sched_group_mask none>}> : () -> ()
    "rocdl.sched.barrier"() <{mask = #rocdl<sched_group_mask non_mem_non_sideeffect>}> : () -> ()
    "rocdl.sched.barrier"() <{mask = #rocdl<sched_group_mask valu|all_vmem>}> : () -> ()
    "rocdl.sched.barrier"() <{mask = #rocdl<sched_group_mask all>}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

