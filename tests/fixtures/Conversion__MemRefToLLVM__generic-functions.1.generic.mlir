"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_memref_to_llvm_aligned_alloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<f32>, sym_name = "zero_d_alloc"}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %1 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %2 = "llvm.getelementptr"(%1, %0) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %3 = "llvm.ptrtoint"(%2) : (!llvm.ptr) -> i64
    %4 = "llvm.mlir.constant"() <{value = 16 : index}> : () -> i64
    %5 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %6 = "llvm.sub"(%4, %5) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.add"(%3, %6) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %8 = "llvm.urem"(%7, %4) : (i64, i64) -> i64
    %9 = "llvm.sub"(%7, %8) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %10 = "llvm.call"(%4, %9) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_mlir_memref_to_llvm_aligned_alloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> !llvm.ptr
    %11 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %12 = "llvm.insertvalue"(%11, %10) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %13 = "llvm.insertvalue"(%12, %10) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %14 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %15 = "llvm.insertvalue"(%13, %14) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
    %16 = "builtin.unrealized_conversion_cast"(%15) : (!llvm.struct<(ptr, ptr, i64)>) -> memref<f32>
    "func.return"(%16) : (memref<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_memref_to_llvm_free", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32>) -> (), sym_name = "dealloc"}> ({
  ^bb0(%arg0: memref<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<f32>) -> !llvm.struct<(ptr, ptr, i64)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
    "llvm.call"(%1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_mlir_memref_to_llvm_free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

