"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "malloc", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "redef_reserved"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024x64xf32, 1>
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2xindex, "foo">) -> (), sym_name = "bad_address_space"}> ({
  ^bb0(%arg0: memref<2xindex, "foo">):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    "memref.store"(%0, %arg0, %0) : (index, memref<2xindex, "foo">, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "invalid_int_conversion"}> ({
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32, 1 : ui64>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "issue_70160"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x32x33xi32, #gpu.address_space<workgroup>>
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.load"(%0, %2, %2, %2) : (memref<1x32x33xi32, #gpu.address_space<workgroup>>, index, index, index) -> i32
    "memref.store"(%3, %1) : (i32, memref<i32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi32>, index, i32) -> (), sym_name = "test_atomic_exch"}> ({
  ^bb0(%arg0: memref<?xi32>, %arg1: index, %arg2: i32):
    %0 = "memref.generic_atomic_rmw"(%arg0, %arg1) ({
    ^bb0(%arg3: i32):
      "memref.atomic_yield"(%arg2) : (i32) -> ()
    }) : (memref<?xi32>, index) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

