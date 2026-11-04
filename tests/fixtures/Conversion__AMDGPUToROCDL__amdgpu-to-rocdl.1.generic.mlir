#mmra_tag = #llvm.mmra_tag<"amdgpu-synchronize-as":"local">
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8xi32, 1>) -> memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>, sym_name = "fat_raw_buffer_cast"}> ({
  ^bb0(%arg73: memref<8xi32, 1>):
    %425 = "builtin.unrealized_conversion_cast"(%arg73) : (memref<8xi32, 1>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %426 = "llvm.mlir.constant"() <{value = 32 : i64}> : () -> i64
    %427 = "llvm.extractvalue"(%425) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<1>
    %428 = "llvm.extractvalue"(%425) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %429 = "llvm.extractvalue"(%425) <{position = array<i64: 3>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.array<1 x i64>
    %430 = "llvm.extractvalue"(%425) <{position = array<i64: 4>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.array<1 x i64>
    %431 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %432 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %433 = "rocdl.make.buffer.rsrc"(%427, %431, %426, %432) : (!llvm.ptr<1>, i16, i64, i32) -> !llvm.ptr<7>
    %434 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %435 = "llvm.insertvalue"(%434, %433) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<7>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %436 = "llvm.insertvalue"(%435, %433) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<7>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %437 = "llvm.insertvalue"(%436, %428) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %438 = "llvm.insertvalue"(%437, %429) <{position = array<i64: 3>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.array<1 x i64>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %439 = "llvm.insertvalue"(%438, %430) <{position = array<i64: 4>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.array<1 x i64>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %440 = "builtin.unrealized_conversion_cast"(%439) : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>) -> memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>
    "func.return"(%440) : (memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i32, 1>) -> memref<i32, #amdgpu.address_space<fat_raw_buffer>>, sym_name = "fat_raw_buffer_cast_0d"}> ({
  ^bb0(%arg72: memref<i32, 1>):
    %413 = "builtin.unrealized_conversion_cast"(%arg72) : (memref<i32, 1>) -> !llvm.struct<(ptr<1>, ptr<1>, i64)>
    %414 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %415 = "llvm.extractvalue"(%413) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64)>) -> !llvm.ptr<1>
    %416 = "llvm.extractvalue"(%413) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64)>) -> i64
    %417 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %418 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %419 = "rocdl.make.buffer.rsrc"(%415, %417, %414, %418) : (!llvm.ptr<1>, i16, i64, i32) -> !llvm.ptr<7>
    %420 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<7>, ptr<7>, i64)>
    %421 = "llvm.insertvalue"(%420, %419) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64)>, !llvm.ptr<7>) -> !llvm.struct<(ptr<7>, ptr<7>, i64)>
    %422 = "llvm.insertvalue"(%421, %419) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64)>, !llvm.ptr<7>) -> !llvm.struct<(ptr<7>, ptr<7>, i64)>
    %423 = "llvm.insertvalue"(%422, %416) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64)>, i64) -> !llvm.struct<(ptr<7>, ptr<7>, i64)>
    %424 = "builtin.unrealized_conversion_cast"(%423) : (!llvm.struct<(ptr<7>, ptr<7>, i64)>) -> memref<i32, #amdgpu.address_space<fat_raw_buffer>>
    "func.return"(%424) : (memref<i32, #amdgpu.address_space<fat_raw_buffer>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi32, strided<[1], offset: ?>, 1>) -> memref<?xi32, strided<[1], offset: ?>, #amdgpu.address_space<fat_raw_buffer>>, sym_name = "fat_raw_buffer_cast_dyn_size_offset"}> ({
  ^bb0(%arg71: memref<?xi32, strided<[1], offset: ?>, 1>):
    %393 = "builtin.unrealized_conversion_cast"(%arg71) : (memref<?xi32, strided<[1], offset: ?>, 1>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %394 = "llvm.extractvalue"(%393) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %395 = "llvm.extractvalue"(%393) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %396 = "llvm.mul"(%394, %395) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %397 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %398 = "llvm.mul"(%396, %397) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %399 = "llvm.extractvalue"(%393) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<1>
    %400 = "llvm.extractvalue"(%393) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %401 = "llvm.extractvalue"(%393) <{position = array<i64: 3>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.array<1 x i64>
    %402 = "llvm.extractvalue"(%393) <{position = array<i64: 4>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.array<1 x i64>
    %403 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %404 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %405 = "rocdl.make.buffer.rsrc"(%399, %403, %398, %404) : (!llvm.ptr<1>, i16, i64, i32) -> !llvm.ptr<7>
    %406 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %407 = "llvm.insertvalue"(%406, %405) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<7>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %408 = "llvm.insertvalue"(%407, %405) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<7>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %409 = "llvm.insertvalue"(%408, %400) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %410 = "llvm.insertvalue"(%409, %401) <{position = array<i64: 3>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.array<1 x i64>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %411 = "llvm.insertvalue"(%410, %402) <{position = array<i64: 4>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.array<1 x i64>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %412 = "builtin.unrealized_conversion_cast"(%411) : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>) -> memref<?xi32, strided<[1], offset: ?>, #amdgpu.address_space<fat_raw_buffer>>
    "func.return"(%412) : (memref<?xi32, strided<[1], offset: ?>, #amdgpu.address_space<fat_raw_buffer>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi32, strided<[1], offset: ?>, 1>) -> memref<?xi32, #amdgpu.address_space<fat_raw_buffer>>, sym_name = "fat_raw_buffer_cast_reset_offset"}> ({
  ^bb0(%arg70: memref<?xi32, strided<[1], offset: ?>, 1>):
    %371 = "builtin.unrealized_conversion_cast"(%arg70) : (memref<?xi32, strided<[1], offset: ?>, 1>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %372 = "llvm.extractvalue"(%371) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %373 = "llvm.extractvalue"(%371) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %374 = "llvm.mul"(%372, %373) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %375 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %376 = "llvm.mul"(%374, %375) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %377 = "llvm.extractvalue"(%371) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<1>
    %378 = "llvm.extractvalue"(%371) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %379 = "llvm.getelementptr"(%377, %378) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>
    %380 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %381 = "llvm.extractvalue"(%371) <{position = array<i64: 3>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.array<1 x i64>
    %382 = "llvm.extractvalue"(%371) <{position = array<i64: 4>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.array<1 x i64>
    %383 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %384 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %385 = "rocdl.make.buffer.rsrc"(%379, %383, %376, %384) : (!llvm.ptr<1>, i16, i64, i32) -> !llvm.ptr<7>
    %386 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %387 = "llvm.insertvalue"(%386, %385) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<7>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %388 = "llvm.insertvalue"(%387, %385) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<7>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %389 = "llvm.insertvalue"(%388, %380) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %390 = "llvm.insertvalue"(%389, %381) <{position = array<i64: 3>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.array<1 x i64>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %391 = "llvm.insertvalue"(%390, %382) <{position = array<i64: 4>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.array<1 x i64>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %392 = "builtin.unrealized_conversion_cast"(%391) : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>) -> memref<?xi32, #amdgpu.address_space<fat_raw_buffer>>
    "func.return"(%392) : (memref<?xi32, #amdgpu.address_space<fat_raw_buffer>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<8xi32, 1>) -> memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>, sym_name = "fat_raw_buffer_cast_valid_bytes"}> ({
  ^bb0(%arg69: memref<8xi32, 1>):
    %355 = "builtin.unrealized_conversion_cast"(%arg69) : (memref<8xi32, 1>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %356 = "arith.constant"() <{value = -1 : i64}> : () -> i64
    %357 = "llvm.extractvalue"(%355) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<1>
    %358 = "llvm.extractvalue"(%355) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %359 = "llvm.extractvalue"(%355) <{position = array<i64: 3>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.array<1 x i64>
    %360 = "llvm.extractvalue"(%355) <{position = array<i64: 4>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.array<1 x i64>
    %361 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %362 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %363 = "rocdl.make.buffer.rsrc"(%357, %361, %356, %362) : (!llvm.ptr<1>, i16, i64, i32) -> !llvm.ptr<7>
    %364 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %365 = "llvm.insertvalue"(%364, %363) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<7>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %366 = "llvm.insertvalue"(%365, %363) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<7>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %367 = "llvm.insertvalue"(%366, %358) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %368 = "llvm.insertvalue"(%367, %359) <{position = array<i64: 3>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.array<1 x i64>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %369 = "llvm.insertvalue"(%368, %360) <{position = array<i64: 4>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.array<1 x i64>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %370 = "builtin.unrealized_conversion_cast"(%369) : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>) -> memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>
    "func.return"(%370) : (memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<8xi32, 1>) -> memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>, sym_name = "fat_raw_buffer_cast_bounds_check"}> ({
  ^bb0(%arg68: memref<8xi32, 1>):
    %339 = "builtin.unrealized_conversion_cast"(%arg68) : (memref<8xi32, 1>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %340 = "llvm.mlir.constant"() <{value = 32 : i64}> : () -> i64
    %341 = "llvm.extractvalue"(%339) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<1>
    %342 = "llvm.extractvalue"(%339) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %343 = "llvm.extractvalue"(%339) <{position = array<i64: 3>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.array<1 x i64>
    %344 = "llvm.extractvalue"(%339) <{position = array<i64: 4>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.array<1 x i64>
    %345 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %346 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %347 = "rocdl.make.buffer.rsrc"(%341, %345, %340, %346) : (!llvm.ptr<1>, i16, i64, i32) -> !llvm.ptr<7>
    %348 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %349 = "llvm.insertvalue"(%348, %347) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<7>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %350 = "llvm.insertvalue"(%349, %347) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<7>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %351 = "llvm.insertvalue"(%350, %342) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %352 = "llvm.insertvalue"(%351, %343) <{position = array<i64: 3>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.array<1 x i64>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %353 = "llvm.insertvalue"(%352, %344) <{position = array<i64: 4>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.array<1 x i64>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>
    %354 = "builtin.unrealized_conversion_cast"(%353) : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<1 x i64>, array<1 x i64>)>) -> memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>
    "func.return"(%354) : (memref<8xi32, #amdgpu.address_space<fat_raw_buffer>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64x64xi32, 1>, i14) -> memref<64x64xi32, #amdgpu.address_space<fat_raw_buffer>>, sym_name = "fat_raw_buffer_cast_cache_swizzle"}> ({
  ^bb0(%arg66: memref<64x64xi32, 1>, %arg67: i14):
    %323 = "builtin.unrealized_conversion_cast"(%arg66) : (memref<64x64xi32, 1>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
    %324 = "llvm.mlir.constant"() <{value = 16384 : i64}> : () -> i64
    %325 = "llvm.extractvalue"(%323) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<1>
    %326 = "llvm.extractvalue"(%323) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %327 = "llvm.extractvalue"(%323) <{position = array<i64: 3>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.array<2 x i64>
    %328 = "llvm.extractvalue"(%323) <{position = array<i64: 4>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.array<2 x i64>
    %329 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %330 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %331 = "rocdl.make.buffer.rsrc"(%325, %329, %324, %330) : (!llvm.ptr<1>, i16, i64, i32) -> !llvm.ptr<7>
    %332 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>
    %333 = "llvm.insertvalue"(%332, %331) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr<7>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>
    %334 = "llvm.insertvalue"(%333, %331) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr<7>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>
    %335 = "llvm.insertvalue"(%334, %326) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>
    %336 = "llvm.insertvalue"(%335, %327) <{position = array<i64: 3>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>, !llvm.array<2 x i64>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>
    %337 = "llvm.insertvalue"(%336, %328) <{position = array<i64: 4>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>, !llvm.array<2 x i64>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>
    %338 = "builtin.unrealized_conversion_cast"(%337) : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>) -> memref<64x64xi32, #amdgpu.address_space<fat_raw_buffer>>
    "func.return"(%338) : (memref<64x64xi32, #amdgpu.address_space<fat_raw_buffer>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i32>) -> i32, sym_name = "gpu_gcn_raw_buffer_load_scalar_i32"}> ({
  ^bb0(%arg65: memref<i32>):
    %310 = "builtin.unrealized_conversion_cast"(%arg65) : (memref<i32>) -> !llvm.struct<(ptr, ptr, i64)>
    %311 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %312 = "llvm.extractvalue"(%310) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
    %313 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %314 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %315 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %316 = "rocdl.make.buffer.rsrc"(%312, %314, %313, %315) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %317 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %318 = "llvm.mul"(%317, %311) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %319 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %320 = "llvm.mul"(%319, %311) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %321 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %322 = "rocdl.raw.ptr.buffer.load"(%316, %318, %320, %321) : (!llvm.ptr<8>, i32, i32, i32) -> i32
    "func.return"(%322) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64xi32>, i32) -> i32, sym_name = "gpu_gcn_raw_buffer_load_i32"}> ({
  ^bb0(%arg63: memref<64xi32>, %arg64: i32):
    %298 = "builtin.unrealized_conversion_cast"(%arg63) : (memref<64xi32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %299 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %300 = "llvm.extractvalue"(%298) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %301 = "llvm.mlir.constant"() <{value = 256 : i64}> : () -> i64
    %302 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %303 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %304 = "rocdl.make.buffer.rsrc"(%300, %302, %301, %303) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %305 = "llvm.mul"(%arg64, %299) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %306 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %307 = "llvm.mul"(%306, %299) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %308 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %309 = "rocdl.raw.ptr.buffer.load"(%304, %305, %307, %308) : (!llvm.ptr<8>, i32, i32, i32) -> i32
    "func.return"(%309) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16x16xi32, strided<[?, ?], offset: ?>>, i32, i32) -> i32, sym_name = "gpu_gcn_raw_buffer_load_i32_strided"}> ({
  ^bb0(%arg60: memref<16x16xi32, strided<[?, ?], offset: ?>>, %arg61: i32, %arg62: i32):
    %269 = "builtin.unrealized_conversion_cast"(%arg60) : (memref<16x16xi32, strided<[?, ?], offset: ?>>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %270 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %271 = "llvm.extractvalue"(%269) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %272 = "llvm.extractvalue"(%269) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %273 = "llvm.getelementptr"(%271, %272) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %274 = "llvm.extractvalue"(%269) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %275 = "llvm.extractvalue"(%269) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %276 = "llvm.mul"(%274, %275) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %277 = "llvm.extractvalue"(%269) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %278 = "llvm.extractvalue"(%269) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %279 = "llvm.mul"(%277, %278) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %280 = "llvm.intr.umax"(%276, %279) : (i64, i64) -> i64
    %281 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %282 = "llvm.mul"(%280, %281) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %283 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %284 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %285 = "rocdl.make.buffer.rsrc"(%273, %283, %282, %284) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %286 = "llvm.extractvalue"(%269) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %287 = "llvm.trunc"(%286) <{overflowFlags = 0 : i32}> : (i64) -> i32
    %288 = "llvm.mul"(%arg61, %287) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %289 = "llvm.extractvalue"(%269) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %290 = "llvm.trunc"(%289) <{overflowFlags = 0 : i32}> : (i64) -> i32
    %291 = "llvm.mul"(%arg62, %290) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %292 = "llvm.add"(%288, %291) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %293 = "llvm.mul"(%292, %270) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %294 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %295 = "llvm.mul"(%294, %270) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %296 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %297 = "rocdl.raw.ptr.buffer.load"(%285, %293, %295, %296) : (!llvm.ptr<8>, i32, i32, i32) -> i32
    "func.return"(%297) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64xi32>, i32) -> i32, sym_name = "gpu_gcn_raw_buffer_load_i32_oob_off"}> ({
  ^bb0(%arg58: memref<64xi32>, %arg59: i32):
    %257 = "builtin.unrealized_conversion_cast"(%arg58) : (memref<64xi32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %258 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %259 = "llvm.extractvalue"(%257) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %260 = "llvm.mlir.constant"() <{value = 256 : i64}> : () -> i64
    %261 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %262 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %263 = "rocdl.make.buffer.rsrc"(%259, %261, %260, %262) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %264 = "llvm.mul"(%arg59, %258) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %265 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %266 = "llvm.mul"(%265, %258) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %267 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %268 = "rocdl.raw.ptr.buffer.load"(%263, %264, %266, %267) : (!llvm.ptr<8>, i32, i32, i32) -> i32
    "func.return"(%268) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64xi32>, i32) -> vector<1xi32>, sym_name = "gpu_gcn_raw_buffer_load_1xi32"}> ({
  ^bb0(%arg56: memref<64xi32>, %arg57: i32):
    %244 = "builtin.unrealized_conversion_cast"(%arg56) : (memref<64xi32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %245 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %246 = "llvm.extractvalue"(%244) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %247 = "llvm.mlir.constant"() <{value = 256 : i64}> : () -> i64
    %248 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %249 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %250 = "rocdl.make.buffer.rsrc"(%246, %248, %247, %249) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %251 = "llvm.mul"(%arg57, %245) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %252 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %253 = "llvm.mul"(%252, %245) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %254 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %255 = "rocdl.raw.ptr.buffer.load"(%250, %251, %253, %254) : (!llvm.ptr<8>, i32, i32, i32) -> i32
    %256 = "llvm.bitcast"(%255) : (i32) -> vector<1xi32>
    "func.return"(%256) : (vector<1xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64xi32>, i32) -> vector<2xi32>, sym_name = "gpu_gcn_raw_buffer_load_2xi32"}> ({
  ^bb0(%arg54: memref<64xi32>, %arg55: i32):
    %232 = "builtin.unrealized_conversion_cast"(%arg54) : (memref<64xi32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %233 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %234 = "llvm.extractvalue"(%232) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %235 = "llvm.mlir.constant"() <{value = 256 : i64}> : () -> i64
    %236 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %237 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %238 = "rocdl.make.buffer.rsrc"(%234, %236, %235, %237) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %239 = "llvm.mul"(%arg55, %233) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %240 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %241 = "llvm.mul"(%240, %233) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %242 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %243 = "rocdl.raw.ptr.buffer.load"(%238, %239, %241, %242) : (!llvm.ptr<8>, i32, i32, i32) -> vector<2xi32>
    "func.return"(%243) : (vector<2xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64xi8>, i32) -> i8, sym_name = "gpu_gcn_raw_buffer_load_i8"}> ({
  ^bb0(%arg52: memref<64xi8>, %arg53: i32):
    %220 = "builtin.unrealized_conversion_cast"(%arg52) : (memref<64xi8>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %221 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %222 = "llvm.extractvalue"(%220) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %223 = "llvm.mlir.constant"() <{value = 64 : i64}> : () -> i64
    %224 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %225 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %226 = "rocdl.make.buffer.rsrc"(%222, %224, %223, %225) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %227 = "llvm.mul"(%arg53, %221) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %228 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %229 = "llvm.mul"(%228, %221) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %230 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %231 = "rocdl.raw.ptr.buffer.load"(%226, %227, %229, %230) : (!llvm.ptr<8>, i32, i32, i32) -> i8
    "func.return"(%231) : (i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64xi8>, i32) -> vector<2xi8>, sym_name = "gpu_gcn_raw_buffer_load_2xi8"}> ({
  ^bb0(%arg50: memref<64xi8>, %arg51: i32):
    %207 = "builtin.unrealized_conversion_cast"(%arg50) : (memref<64xi8>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %208 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %209 = "llvm.extractvalue"(%207) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %210 = "llvm.mlir.constant"() <{value = 64 : i64}> : () -> i64
    %211 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %212 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %213 = "rocdl.make.buffer.rsrc"(%209, %211, %210, %212) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %214 = "llvm.mul"(%arg51, %208) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %215 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %216 = "llvm.mul"(%215, %208) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %217 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %218 = "rocdl.raw.ptr.buffer.load"(%213, %214, %216, %217) : (!llvm.ptr<8>, i32, i32, i32) -> i16
    %219 = "llvm.bitcast"(%218) : (i16) -> vector<2xi8>
    "func.return"(%219) : (vector<2xi8>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64xi8>, i32) -> vector<16xi8>, sym_name = "gpu_gcn_raw_buffer_load_16xi8"}> ({
  ^bb0(%arg48: memref<64xi8>, %arg49: i32):
    %194 = "builtin.unrealized_conversion_cast"(%arg48) : (memref<64xi8>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %195 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %196 = "llvm.extractvalue"(%194) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %197 = "llvm.mlir.constant"() <{value = 64 : i64}> : () -> i64
    %198 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %199 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %200 = "rocdl.make.buffer.rsrc"(%196, %198, %197, %199) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %201 = "llvm.mul"(%arg49, %195) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %202 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %203 = "llvm.mul"(%202, %195) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %204 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %205 = "rocdl.raw.ptr.buffer.load"(%200, %201, %203, %204) : (!llvm.ptr<8>, i32, i32, i32) -> vector<4xi32>
    %206 = "llvm.bitcast"(%205) : (vector<4xi32>) -> vector<16xi8>
    "func.return"(%206) : (vector<16xi8>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64xf8E5M2FNUZ>, i32) -> f8E5M2FNUZ, sym_name = "gpu_gcn_raw_buffer_load_f8E5M2FNUZ"}> ({
  ^bb0(%arg46: memref<64xf8E5M2FNUZ>, %arg47: i32):
    %181 = "builtin.unrealized_conversion_cast"(%arg46) : (memref<64xf8E5M2FNUZ>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %182 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %183 = "llvm.extractvalue"(%181) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %184 = "llvm.mlir.constant"() <{value = 64 : i64}> : () -> i64
    %185 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %186 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %187 = "rocdl.make.buffer.rsrc"(%183, %185, %184, %186) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %188 = "llvm.mul"(%arg47, %182) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %189 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %190 = "llvm.mul"(%189, %182) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %191 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %192 = "rocdl.raw.ptr.buffer.load"(%187, %188, %190, %191) : (!llvm.ptr<8>, i32, i32, i32) -> i8
    %193 = "builtin.unrealized_conversion_cast"(%192) : (i8) -> f8E5M2FNUZ
    "func.return"(%193) : (f8E5M2FNUZ) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64xf8E4M3FNUZ>, i32) -> vector<4xf8E4M3FNUZ>, sym_name = "gpu_gcn_raw_buffer_load_4xf8E4M3FNUZ"}> ({
  ^bb0(%arg44: memref<64xf8E4M3FNUZ>, %arg45: i32):
    %167 = "builtin.unrealized_conversion_cast"(%arg44) : (memref<64xf8E4M3FNUZ>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %168 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %169 = "llvm.extractvalue"(%167) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %170 = "llvm.mlir.constant"() <{value = 64 : i64}> : () -> i64
    %171 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %172 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %173 = "rocdl.make.buffer.rsrc"(%169, %171, %170, %172) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %174 = "llvm.mul"(%arg45, %168) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %175 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %176 = "llvm.mul"(%175, %168) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %177 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %178 = "rocdl.raw.ptr.buffer.load"(%173, %174, %176, %177) : (!llvm.ptr<8>, i32, i32, i32) -> i32
    %179 = "llvm.bitcast"(%178) : (i32) -> vector<4xi8>
    %180 = "builtin.unrealized_conversion_cast"(%179) : (vector<4xi8>) -> vector<4xf8E4M3FNUZ>
    "func.return"(%180) : (vector<4xf8E4M3FNUZ>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, memref<i32>) -> (), sym_name = "gpu_gcn_raw_buffer_store_scalar_i32"}> ({
  ^bb0(%arg42: i32, %arg43: memref<i32>):
    %155 = "builtin.unrealized_conversion_cast"(%arg43) : (memref<i32>) -> !llvm.struct<(ptr, ptr, i64)>
    %156 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %157 = "llvm.extractvalue"(%155) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
    %158 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %159 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %160 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %161 = "rocdl.make.buffer.rsrc"(%157, %159, %158, %160) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %162 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %163 = "llvm.mul"(%162, %156) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %164 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %165 = "llvm.mul"(%164, %156) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %166 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    "rocdl.raw.ptr.buffer.store"(%arg42, %161, %163, %165, %166) : (i32, !llvm.ptr<8>, i32, i32, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, memref<64xi32>, i32) -> (), sym_name = "gpu_gcn_raw_buffer_store_i32"}> ({
  ^bb0(%arg39: i32, %arg40: memref<64xi32>, %arg41: i32):
    %144 = "builtin.unrealized_conversion_cast"(%arg40) : (memref<64xi32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %145 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %146 = "llvm.extractvalue"(%144) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %147 = "llvm.mlir.constant"() <{value = 256 : i64}> : () -> i64
    %148 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %149 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %150 = "rocdl.make.buffer.rsrc"(%146, %148, %147, %149) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %151 = "llvm.mul"(%arg41, %145) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %152 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %153 = "llvm.mul"(%152, %145) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %154 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    "rocdl.raw.ptr.buffer.store"(%arg39, %150, %151, %153, %154) : (i32, !llvm.ptr<8>, i32, i32, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf32>, memref<64xf32>, i32) -> (), sym_name = "gpu_gcn_raw_buffer_store_1xf32"}> ({
  ^bb0(%arg36: vector<1xf32>, %arg37: memref<64xf32>, %arg38: i32):
    %132 = "builtin.unrealized_conversion_cast"(%arg37) : (memref<64xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %133 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %134 = "llvm.bitcast"(%arg36) : (vector<1xf32>) -> f32
    %135 = "llvm.extractvalue"(%132) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %136 = "llvm.mlir.constant"() <{value = 256 : i64}> : () -> i64
    %137 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %138 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %139 = "rocdl.make.buffer.rsrc"(%135, %137, %136, %138) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %140 = "llvm.mul"(%arg38, %133) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %141 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %142 = "llvm.mul"(%141, %133) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %143 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    "rocdl.raw.ptr.buffer.store"(%134, %139, %140, %142, %143) : (f32, !llvm.ptr<8>, i32, i32, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi8>, memref<64xi8>, i32) -> (), sym_name = "gpu_gcn_raw_buffer_store_2xi8"}> ({
  ^bb0(%arg33: vector<2xi8>, %arg34: memref<64xi8>, %arg35: i32):
    %120 = "builtin.unrealized_conversion_cast"(%arg34) : (memref<64xi8>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %121 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %122 = "llvm.bitcast"(%arg33) : (vector<2xi8>) -> i16
    %123 = "llvm.extractvalue"(%120) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %124 = "llvm.mlir.constant"() <{value = 64 : i64}> : () -> i64
    %125 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %126 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %127 = "rocdl.make.buffer.rsrc"(%123, %125, %124, %126) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %128 = "llvm.mul"(%arg35, %121) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %129 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %130 = "llvm.mul"(%129, %121) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %131 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    "rocdl.raw.ptr.buffer.store"(%122, %127, %128, %130, %131) : (i16, !llvm.ptr<8>, i32, i32, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<16xi8>, memref<64xi8>, i32) -> (), sym_name = "gpu_gcn_raw_buffer_store_16xi8"}> ({
  ^bb0(%arg30: vector<16xi8>, %arg31: memref<64xi8>, %arg32: i32):
    %108 = "builtin.unrealized_conversion_cast"(%arg31) : (memref<64xi8>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %109 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %110 = "llvm.bitcast"(%arg30) : (vector<16xi8>) -> vector<4xi32>
    %111 = "llvm.extractvalue"(%108) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %112 = "llvm.mlir.constant"() <{value = 64 : i64}> : () -> i64
    %113 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %114 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %115 = "rocdl.make.buffer.rsrc"(%111, %113, %112, %114) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %116 = "llvm.mul"(%arg32, %109) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %117 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %118 = "llvm.mul"(%117, %109) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %119 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    "rocdl.raw.ptr.buffer.store"(%110, %115, %116, %118, %119) : (vector<4xi32>, !llvm.ptr<8>, i32, i32, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, memref<64xf32>, i32) -> (), sym_name = "gpu_gcn_raw_buffer_atomic_fadd_f32"}> ({
  ^bb0(%arg27: f32, %arg28: memref<64xf32>, %arg29: i32):
    %97 = "builtin.unrealized_conversion_cast"(%arg28) : (memref<64xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %98 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %99 = "llvm.extractvalue"(%97) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %100 = "llvm.mlir.constant"() <{value = 256 : i64}> : () -> i64
    %101 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %102 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %103 = "rocdl.make.buffer.rsrc"(%99, %101, %100, %102) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %104 = "llvm.mul"(%arg29, %98) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %105 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %106 = "llvm.mul"(%105, %98) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %107 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    "rocdl.raw.ptr.buffer.atomic.fadd"(%arg27, %103, %104, %106, %107) : (f32, !llvm.ptr<8>, i32, i32, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf16>, memref<64xf16>, i32) -> (), sym_name = "gpu_gcn_raw_buffer_atomic_fadd_v2f16"}> ({
  ^bb0(%arg24: vector<2xf16>, %arg25: memref<64xf16>, %arg26: i32):
    %86 = "builtin.unrealized_conversion_cast"(%arg25) : (memref<64xf16>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %87 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %88 = "llvm.extractvalue"(%86) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %89 = "llvm.mlir.constant"() <{value = 128 : i64}> : () -> i64
    %90 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %91 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %92 = "rocdl.make.buffer.rsrc"(%88, %90, %89, %91) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %93 = "llvm.mul"(%arg26, %87) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %94 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %95 = "llvm.mul"(%94, %87) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %96 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    "rocdl.raw.ptr.buffer.atomic.fadd"(%arg24, %92, %93, %95, %96) : (vector<2xf16>, !llvm.ptr<8>, i32, i32, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xbf16>, memref<64xbf16>, i32) -> (), sym_name = "gpu_gcn_raw_buffer_atomic_fadd_v2bf16"}> ({
  ^bb0(%arg21: vector<2xbf16>, %arg22: memref<64xbf16>, %arg23: i32):
    %75 = "builtin.unrealized_conversion_cast"(%arg22) : (memref<64xbf16>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %76 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %77 = "llvm.extractvalue"(%75) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %78 = "llvm.mlir.constant"() <{value = 128 : i64}> : () -> i64
    %79 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %80 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %81 = "rocdl.make.buffer.rsrc"(%77, %79, %78, %80) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %82 = "llvm.mul"(%arg23, %76) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %83 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %84 = "llvm.mul"(%83, %76) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %85 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    "rocdl.raw.ptr.buffer.atomic.fadd"(%arg21, %81, %82, %84, %85) : (vector<2xbf16>, !llvm.ptr<8>, i32, i32, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, memref<64xf32>, i32) -> (), sym_name = "gpu_gcn_raw_buffer_atomic_fmax_f32"}> ({
  ^bb0(%arg18: f32, %arg19: memref<64xf32>, %arg20: i32):
    %64 = "builtin.unrealized_conversion_cast"(%arg19) : (memref<64xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %65 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %66 = "llvm.extractvalue"(%64) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %67 = "llvm.mlir.constant"() <{value = 256 : i64}> : () -> i64
    %68 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %69 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %70 = "rocdl.make.buffer.rsrc"(%66, %68, %67, %69) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %71 = "llvm.mul"(%arg20, %65) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %72 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %73 = "llvm.mul"(%72, %65) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %74 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    "rocdl.raw.ptr.buffer.atomic.fmax"(%arg18, %70, %71, %73, %74) : (f32, !llvm.ptr<8>, i32, i32, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, memref<64xi32>, i32) -> (), sym_name = "gpu_gcn_raw_buffer_atomic_smax_i32"}> ({
  ^bb0(%arg15: i32, %arg16: memref<64xi32>, %arg17: i32):
    %53 = "builtin.unrealized_conversion_cast"(%arg16) : (memref<64xi32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %54 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %55 = "llvm.extractvalue"(%53) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %56 = "llvm.mlir.constant"() <{value = 256 : i64}> : () -> i64
    %57 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %58 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %59 = "rocdl.make.buffer.rsrc"(%55, %57, %56, %58) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %60 = "llvm.mul"(%arg17, %54) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %61 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %62 = "llvm.mul"(%61, %54) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %63 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    "rocdl.raw.ptr.buffer.atomic.smax"(%arg15, %59, %60, %62, %63) : (i32, !llvm.ptr<8>, i32, i32, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, memref<64xi32>, i32) -> (), sym_name = "gpu_gcn_raw_buffer_atomic_umin_i32"}> ({
  ^bb0(%arg12: i32, %arg13: memref<64xi32>, %arg14: i32):
    %42 = "builtin.unrealized_conversion_cast"(%arg13) : (memref<64xi32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %43 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %44 = "llvm.extractvalue"(%42) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %45 = "llvm.mlir.constant"() <{value = 256 : i64}> : () -> i64
    %46 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %47 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %48 = "rocdl.make.buffer.rsrc"(%44, %46, %45, %47) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %49 = "llvm.mul"(%arg14, %43) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %50 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %51 = "llvm.mul"(%50, %43) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %52 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    "rocdl.raw.ptr.buffer.atomic.umin"(%arg12, %48, %49, %51, %52) : (i32, !llvm.ptr<8>, i32, i32, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, memref<64xf32>, i32) -> f32, sym_name = "amdgpu_raw_buffer_atomic_cmpswap_f32"}> ({
  ^bb0(%arg8: f32, %arg9: f32, %arg10: memref<64xf32>, %arg11: i32):
    %27 = "builtin.unrealized_conversion_cast"(%arg10) : (memref<64xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %28 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %29 = "llvm.bitcast"(%arg8) : (f32) -> i32
    %30 = "llvm.bitcast"(%arg9) : (f32) -> i32
    %31 = "llvm.extractvalue"(%27) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %32 = "llvm.mlir.constant"() <{value = 256 : i64}> : () -> i64
    %33 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %34 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %35 = "rocdl.make.buffer.rsrc"(%31, %33, %32, %34) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %36 = "llvm.mul"(%arg11, %28) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %37 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %38 = "llvm.mul"(%37, %28) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %39 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %40 = "rocdl.raw.ptr.buffer.atomic.cmpswap"(%29, %30, %35, %36, %38, %39) : (i32, i32, !llvm.ptr<8>, i32, i32, i32) -> i32
    %41 = "llvm.bitcast"(%40) : (i32) -> f32
    "func.return"(%41) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64, i64, memref<64xi64>, i32) -> i64, sym_name = "amdgpu_raw_buffer_atomic_cmpswap_i64"}> ({
  ^bb0(%arg4: i64, %arg5: i64, %arg6: memref<64xi64>, %arg7: i32):
    %15 = "builtin.unrealized_conversion_cast"(%arg6) : (memref<64xi64>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %16 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
    %17 = "llvm.extractvalue"(%15) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %18 = "llvm.mlir.constant"() <{value = 512 : i64}> : () -> i64
    %19 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %20 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %21 = "rocdl.make.buffer.rsrc"(%17, %19, %18, %20) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %22 = "llvm.mul"(%arg7, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %23 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %24 = "llvm.mul"(%23, %16) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %25 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %26 = "rocdl.raw.ptr.buffer.atomic.cmpswap"(%arg4, %arg5, %21, %22, %24, %25) : (i64, i64, !llvm.ptr<8>, i32, i32, i32) -> i64
    "func.return"(%26) : (i64) -> ()
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
    %7 = "llvm.mlir.constant"() <{value = 159744 : i32}> : () -> i32
    %8 = "rocdl.make.buffer.rsrc"(%4, %6, %5, %7) : (!llvm.ptr, i16, i64, i32) -> !llvm.ptr<8>
    %9 = "llvm.mul"(%arg3, %1) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %10 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %11 = "llvm.mul"(%10, %1) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %12 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %13 = "rocdl.raw.ptr.buffer.atomic.cmpswap"(%2, %3, %8, %9, %11, %12) : (i32, i32, !llvm.ptr<8>, i32, i32, i32) -> i32
    %14 = "llvm.bitcast"(%13) : (i32) -> vector<2xf16>
    "func.return"(%14) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "lds_barrier"}> ({
    "llvm.fence"() <{ordering = 5 : i64, syncscope = "workgroup"}> {llvm.mmra = #mmra_tag} : () -> ()
    "rocdl.s.barrier"() : () -> ()
    "llvm.fence"() <{ordering = 4 : i64, syncscope = "workgroup"}> {llvm.mmra = #mmra_tag} : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "sched_barrier"}> ({
    "rocdl.sched.barrier"() <{mask = 0 : i32}> : () -> ()
    "rocdl.sched.barrier"() <{mask = 1 : i32}> : () -> ()
    "rocdl.sched.barrier"() <{mask = 2 : i32}> : () -> ()
    "rocdl.sched.barrier"() <{mask = 4 : i32}> : () -> ()
    "rocdl.sched.barrier"() <{mask = 8 : i32}> : () -> ()
    "rocdl.sched.barrier"() <{mask = 16 : i32}> : () -> ()
    "rocdl.sched.barrier"() <{mask = 32 : i32}> : () -> ()
    "rocdl.sched.barrier"() <{mask = 64 : i32}> : () -> ()
    "rocdl.sched.barrier"() <{mask = 128 : i32}> : () -> ()
    "rocdl.sched.barrier"() <{mask = 256 : i32}> : () -> ()
    "rocdl.sched.barrier"() <{mask = 512 : i32}> : () -> ()
    "rocdl.sched.barrier"() <{mask = 1024 : i32}> : () -> ()
    "rocdl.sched.barrier"() <{mask = 18 : i32}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

