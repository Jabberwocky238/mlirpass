"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, index) -> tensor<3xf32, 1 : i64>, sym_name = "from_elements"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: index):
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3xf32, 1>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 2 : index}> : () -> index
    "memref.store"(%arg0, %0, %1) <{nontemporal = false}> : (f32, memref<3xf32, 1>, index) -> ()
    "memref.store"(%arg0, %0, %2) <{nontemporal = false}> : (f32, memref<3xf32, 1>, index) -> ()
    "memref.store"(%arg0, %0, %3) <{nontemporal = false}> : (f32, memref<3xf32, 1>, index) -> ()
    "memref.store"(%arg1, %0, %arg2) <{nontemporal = false}> : (f32, memref<3xf32, 1>, index) -> ()
    %4 = "bufferization.to_tensor"(%0) : (memref<3xf32, 1>) -> tensor<3xf32, 1 : i64>
    "func.return"(%4) : (tensor<3xf32, 1 : i64>) -> ()
  }) : () -> ()
}) : () -> ()

