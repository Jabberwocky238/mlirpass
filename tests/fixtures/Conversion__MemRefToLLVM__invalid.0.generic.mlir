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
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64)>, linkage = #llvm.linkage<external>, sym_name = "malloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "issue_70160"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x32x33xi32, #gpu.address_space<workgroup>>
    %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %3 = "llvm.getelementptr"(%2, %1) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
    %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %6 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
    %11 = "arith.constant"() <{value = 0 : index}> : () -> index
    %12 = "memref.load"(%0, %11, %11, %11) : (memref<1x32x33xi32, #gpu.address_space<workgroup>>, index, index, index) -> i32
    %13 = "llvm.extractvalue"(%10) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
    "llvm.store"(%12, %13) <{ordering = 0 : i64}> : (i32, !llvm.ptr) -> ()
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

