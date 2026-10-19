"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<?xf32>, sym_name = "tensor_load_of_buffer_cast"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<?xf32>) -> memref<?xf32>
    %1 = "bufferization.to_tensor"(%0) : (memref<?xf32>) -> tensor<?xf32>
    "func.return"(%1) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> memref<?xf32>, sym_name = "buffer_cast_of_tensor_load"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %0 = "bufferization.to_tensor"(%arg0) : (memref<?xf32>) -> tensor<?xf32>
    %1 = "bufferization.to_buffer"(%0) : (tensor<?xf32>) -> memref<?xf32>
    "func.return"(%1) : (memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, 2>) -> memref<?xf32, 7>, sym_name = "canonicalize_buffer_cast_of_tensor_load_different_address_space"}> ({
  ^bb0(%arg0: memref<?xf32, 2>):
    %0 = "bufferization.to_tensor"(%arg0) : (memref<?xf32, 2>) -> tensor<?xf32, 7 : i64>
    %1 = "bufferization.to_buffer"(%0) : (tensor<?xf32, 7 : i64>) -> memref<?xf32, 7>
    "func.return"(%1) : (memref<?xf32, 7>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[1], offset: 3>>) -> memref<?xf32, strided<[1], offset: ?>>, sym_name = "canonicalize_buffer_cast_of_tensor_load"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[1], offset: 3>>):
    %0 = "bufferization.to_tensor"(%arg0) : (memref<?xf32, strided<[1], offset: 3>>) -> tensor<?xf32>
    %1 = "bufferization.to_buffer"(%0) : (tensor<?xf32>) -> memref<?xf32, strided<[1], offset: ?>>
    "func.return"(%1) : (memref<?xf32, strided<[1], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[1], offset: ?>>) -> memref<?xf32, strided<[1], offset: 3>>, sym_name = "canonicalize_buffer_cast_of_tensor_load_to_copy"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[1], offset: ?>>):
    %0 = "bufferization.to_tensor"(%arg0) : (memref<?xf32, strided<[1], offset: ?>>) -> tensor<?xf32>
    %1 = "bufferization.to_buffer"(%0) : (tensor<?xf32>) -> memref<?xf32, strided<[1], offset: 3>>
    "func.return"(%1) : (memref<?xf32, strided<[1], offset: 3>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> index, sym_name = "dim_of_tensor_load"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "bufferization.to_tensor"(%arg0) : (memref<?xf32>) -> tensor<?xf32>
    %2 = "tensor.dim"(%1, %0) : (tensor<?xf32>, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> memref<?xf32>, sym_name = "clone_before_dealloc"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %0 = "bufferization.clone"(%arg0) : (memref<?xf32>) -> memref<?xf32>
    "memref.dealloc"(%arg0) : (memref<?xf32>) -> ()
    "func.return"(%0) : (memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> memref<?xf32>, sym_name = "clone_before_dealloc"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %0 = "bufferization.clone"(%arg0) : (memref<?xf32>) -> memref<?xf32>
    "use"(%0) : (memref<?xf32>) -> ()
    "memref.dealloc"(%0) : (memref<?xf32>) -> ()
    "func.return"(%arg0) : (memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> memref<32xf32>, sym_name = "clone_after_cast"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %0 = "memref.cast"(%arg0) : (memref<?xf32>) -> memref<32xf32>
    %1 = "bufferization.clone"(%0) : (memref<32xf32>) -> memref<32xf32>
    "func.return"(%1) : (memref<32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> memref<32xf32>, sym_name = "clone_and_cast"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %0 = "bufferization.clone"(%arg0) : (memref<?xf32>) -> memref<32xf32>
    "memref.dealloc"(%arg0) : (memref<?xf32>) -> ()
    "func.return"(%0) : (memref<32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32, strided<[2]>>) -> memref<32xf32>, sym_name = "clone_incompatible"}> ({
  ^bb0(%arg0: memref<32xf32, strided<[2]>>):
    %0 = "bufferization.clone"(%arg0) : (memref<32xf32, strided<[2]>>) -> memref<32xf32>
    "memref.dealloc"(%arg0) : (memref<32xf32, strided<[2]>>) -> ()
    "func.return"(%0) : (memref<32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> (), sym_name = "alias_is_freed"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %0 = "memref.cast"(%arg0) : (memref<?xf32>) -> memref<32xf32>
    %1 = "bufferization.clone"(%0) : (memref<32xf32>) -> memref<32xf32>
    "memref.dealloc"(%arg0) : (memref<?xf32>) -> ()
    "use"(%1) : (memref<32xf32>) -> ()
    "memref.dealloc"(%1) : (memref<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> memref<?xf32>, sym_name = "clone_multiple_dealloc_of_source"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %0 = "bufferization.clone"(%arg0) : (memref<?xf32>) -> memref<?xf32>
    "if_else"() ({
      "memref.dealloc"(%arg0) : (memref<?xf32>) -> ()
    }, {
      "memref.dealloc"(%arg0) : (memref<?xf32>) -> ()
    }) : () -> ()
    "func.return"(%0) : (memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> memref<?xf32>, sym_name = "clone_multiple_dealloc_of_clone"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %0 = "bufferization.clone"(%arg0) : (memref<?xf32>) -> memref<?xf32>
    "use"(%0) : (memref<?xf32>) -> ()
    "if_else"() ({
      "memref.dealloc"(%0) : (memref<?xf32>) -> ()
    }, {
      "memref.dealloc"(%0) : (memref<?xf32>) -> ()
    }) : () -> ()
    "func.return"(%arg0) : (memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> (), sym_name = "clone_and_realloc"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %0 = "bufferization.clone"(%arg0) : (memref<?xf32>) -> memref<32xf32>
    "use"(%0) : (memref<32xf32>) -> ()
    %1 = "memref.realloc"(%0) : (memref<32xf32>) -> memref<64xf32>
    "memref.dealloc"(%1) : (memref<64xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> memref<32xf32>, sym_name = "clone_and_preceding_dealloc"}> ({
  ^bb0(%arg0: memref<?xf32>):
    "memref.dealloc"(%arg0) : (memref<?xf32>) -> ()
    %0 = "bufferization.clone"(%arg0) : (memref<?xf32>) -> memref<32xf32>
    "func.return"(%0) : (memref<32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x6x16x32xi8>) -> memref<?x?x16x32xi8>, sym_name = "tensor_cast_to_buffer"}> ({
  ^bb0(%arg1: tensor<4x6x16x32xi8>):
    %2 = "tensor.cast"(%arg1) : (tensor<4x6x16x32xi8>) -> tensor<?x?x16x32xi8>
    %3 = "bufferization.to_buffer"(%2) <{read_only}> : (tensor<?x?x16x32xi8>) -> memref<?x?x16x32xi8>
    "func.return"(%3) : (memref<?x?x16x32xi8>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x6x16x32xi8>) -> memref<*xi8>, sym_name = "tensor_cast_to_unranked_buffer"}> ({
  ^bb0(%arg0: tensor<4x6x16x32xi8>):
    %0 = "tensor.cast"(%arg0) : (tensor<4x6x16x32xi8>) -> tensor<*xi8>
    %1 = "bufferization.to_buffer"(%0) <{read_only}> : (tensor<*xi8>) -> memref<*xi8>
    "func.return"(%1) : (memref<*xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x6x16x32xi8>) -> memref<?x?x16x32xi8, strided<[?, ?, ?, 1], offset: ?>, 1>, sym_name = "tensor_cast_to_buffer_layout_and_memspace"}> ({
  ^bb0(%arg0: tensor<4x6x16x32xi8>):
    %0 = "tensor.cast"(%arg0) : (tensor<4x6x16x32xi8>) -> tensor<?x?x16x32xi8>
    %1 = "bufferization.to_buffer"(%0) : (tensor<?x?x16x32xi8>) -> memref<?x?x16x32xi8, strided<[?, ?, ?, 1], offset: ?>, 1>
    "func.return"(%1) : (memref<?x?x16x32xi8, strided<[?, ?, ?, 1], offset: ?>, 1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, tensor<?x?xf32>) -> f32, sym_name = "load_from_buffer_cast"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: tensor<?x?xf32>):
    %0 = "bufferization.to_buffer"(%arg2) : (tensor<?x?xf32>) -> memref<?x?xf32>
    %1 = "memref.load"(%0, %arg0, %arg1) : (memref<?x?xf32>, index, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<4x5x?xf32>, sym_name = "alloc_tensor_canonicalize"}> ({
    %0 = "arith.constant"() <{value = 6 : index}> : () -> index
    %1 = "bufferization.alloc_tensor"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (index) -> tensor<4x5x?xf32>
    "func.return"(%1) : (tensor<4x5x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xindex>) -> memref<*xf32>, sym_name = "dealloc_canonicalize_clone_removal"}> ({
  ^bb0(%arg0: memref<?xindex>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "memref.alloc"(%0) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    %2 = "memref.reshape"(%1, %arg0) : (memref<?xf32>, memref<?xindex>) -> memref<*xf32>
    %3 = "bufferization.clone"(%2) : (memref<*xf32>) -> memref<*xf32>
    "memref.dealloc"(%1) : (memref<?xf32>) -> ()
    "func.return"(%3) : (memref<*xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2xi32>, i1, i1, memref<2xi32>, memref<2xi32>, memref<2xi32>) -> (i1, i1, i1), sym_name = "dealloc_canonicalize_duplicates"}> ({
  ^bb0(%arg0: memref<2xi32>, %arg1: i1, %arg2: i1, %arg3: memref<2xi32>, %arg4: memref<2xi32>, %arg5: memref<2xi32>):
    %0:3 = "bufferization.dealloc"(%arg4, %arg0, %arg0, %arg1, %arg1, %arg1, %arg3, %arg5, %arg3) <{operandSegmentSizes = array<i32: 3, 3, 3>}> : (memref<2xi32>, memref<2xi32>, memref<2xi32>, i1, i1, i1, memref<2xi32>, memref<2xi32>, memref<2xi32>) -> (i1, i1, i1)
    "bufferization.dealloc"(%arg0, %arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 2, 2, 0>}> : (memref<2xi32>, memref<2xi32>, i1, i1) -> ()
    "func.return"(%0#0, %0#1, %0#2) : (i1, i1, i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2xi32>, i1, memref<2xi32>) -> i1, sym_name = "dealloc_erase_empty"}> ({
  ^bb0(%arg0: memref<2xi32>, %arg1: i1, %arg2: memref<2xi32>):
    "bufferization.dealloc"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> ()
    %0 = "bufferization.dealloc"(%arg0) <{operandSegmentSizes = array<i32: 0, 0, 1>}> : (memref<2xi32>) -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2xi32>, memref<2xi32>, i1) -> (), sym_name = "dealloc_always_false_condition"}> ({
  ^bb0(%arg0: memref<2xi32>, %arg1: memref<2xi32>, %arg2: i1):
    %0 = "arith.constant"() <{value = false}> : () -> i1
    "bufferization.dealloc"(%arg0, %arg1, %0, %arg2) <{operandSegmentSizes = array<i32: 2, 2, 0>}> : (memref<2xi32>, memref<2xi32>, i1, i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2xi32>, i1, i1, memref<2xi32>) -> memref<2xi32>, sym_name = "dealloc_base_memref_extract_of_alloc"}> ({
  ^bb0(%arg0: memref<2xi32>, %arg1: i1, %arg2: i1, %arg3: memref<2xi32>):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xi32>
    %1:4 = "memref.extract_strided_metadata"(%0) : (memref<2xi32>) -> (memref<i32>, index, index, index)
    %2:4 = "memref.extract_strided_metadata"(%arg3) : (memref<2xi32>) -> (memref<i32>, index, index, index)
    "bufferization.dealloc"(%1#0, %arg0, %2#0, %arg1, %arg2, %arg2) <{operandSegmentSizes = array<i32: 3, 3, 0>}> : (memref<i32>, memref<2xi32>, memref<i32>, i1, i1, i1) -> ()
    "func.return"(%0) : (memref<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2xi32>) -> (), sym_name = "dealloc_base_memref_extract_of_alloc"}> ({
  ^bb0(%arg0: memref<2xi32>):
    %0 = "arith.constant"() <{value = true}> : () -> i1
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xi32>
    "bufferization.dealloc"(%1, %arg0, %0, %0) <{operandSegmentSizes = array<i32: 2, 2, 0>}> : (memref<2xi32>, memref<2xi32>, i1, i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<?x?x?xf16>, sym_name = "negative_input"}> ({
    %0 = "index.constant"() <{value = 27 : index}> : () -> index
    %1 = "index.constant"() <{value = -3 : index}> : () -> index
    %2 = "arith.constant"() <{value = 10 : index}> : () -> index
    %3 = "bufferization.alloc_tensor"(%2, %1, %0) <{operandSegmentSizes = array<i32: 3, 0, 0>}> : (index, index, index) -> tensor<?x?x?xf16>
    "func.return"(%3) : (tensor<?x?x?xf16>) -> ()
  }) : () -> ()
}) : () -> ()

