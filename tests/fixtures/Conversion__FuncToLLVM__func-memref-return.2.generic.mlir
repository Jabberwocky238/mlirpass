"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (ptr)>, linkage = #llvm.linkage<external>, sym_name = "check_static_return", visibility_ = 0 : i64}> ({
  ^bb0(%arg7: !llvm.ptr):
    %37 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %38 = "llvm.insertvalue"(%37, %arg7) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %39 = "llvm.insertvalue"(%38, %arg7) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %40 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %41 = "llvm.insertvalue"(%39, %40) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %42 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
    %43 = "llvm.insertvalue"(%41, %42) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %44 = "llvm.mlir.constant"() <{value = 18 : index}> : () -> i64
    %45 = "llvm.insertvalue"(%43, %44) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %46 = "llvm.mlir.constant"() <{value = 18 : index}> : () -> i64
    %47 = "llvm.insertvalue"(%45, %46) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %48 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %49 = "llvm.insertvalue"(%47, %48) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %50 = "llvm.extractvalue"(%49) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    "llvm.return"(%50) : (!llvm.ptr) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (ptr)>, linkage = #llvm.linkage<external>, sym_name = "check_static_return_with_offset", visibility_ = 0 : i64}> ({
  ^bb0(%arg6: !llvm.ptr):
    %23 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %24 = "llvm.insertvalue"(%23, %arg6) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %25 = "llvm.insertvalue"(%24, %arg6) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %26 = "llvm.mlir.constant"() <{value = 7 : index}> : () -> i64
    %27 = "llvm.insertvalue"(%25, %26) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %28 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
    %29 = "llvm.insertvalue"(%27, %28) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %30 = "llvm.mlir.constant"() <{value = 22 : index}> : () -> i64
    %31 = "llvm.insertvalue"(%29, %30) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %32 = "llvm.mlir.constant"() <{value = 18 : index}> : () -> i64
    %33 = "llvm.insertvalue"(%31, %32) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %34 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %35 = "llvm.insertvalue"(%33, %34) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %36 = "llvm.extractvalue"(%35) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    "llvm.return"(%36) : (!llvm.ptr) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (ptr)>, linkage = #llvm.linkage<external>, sym_name = "foo", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (ptr)>, linkage = #llvm.linkage<external>, sym_name = "check_memref_func_call", visibility_ = 0 : i64}> ({
  ^bb0(%arg5: !llvm.ptr):
    %2 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %3 = "llvm.insertvalue"(%2, %arg5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %4 = "llvm.insertvalue"(%3, %arg5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %5 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %6 = "llvm.insertvalue"(%4, %5) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %7 = "llvm.mlir.constant"() <{value = 10 : index}> : () -> i64
    %8 = "llvm.insertvalue"(%6, %7) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %9 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %11 = "llvm.extractvalue"(%10) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %12 = "llvm.call"(%11) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @foo, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> !llvm.ptr
    %13 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %14 = "llvm.insertvalue"(%13, %12) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %15 = "llvm.insertvalue"(%14, %12) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %16 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %17 = "llvm.insertvalue"(%15, %16) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %18 = "llvm.mlir.constant"() <{value = 20 : index}> : () -> i64
    %19 = "llvm.insertvalue"(%17, %18) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %20 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %21 = "llvm.insertvalue"(%19, %20) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %22 = "llvm.extractvalue"(%21) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    "llvm.return"(%22) : (!llvm.ptr) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi8>) -> memref<?xi8>, sym_name = "check_return"}> ({
  ^bb0(%arg4: memref<?xi8>):
    %1 = "builtin.unrealized_conversion_cast"(%arg4) : (memref<?xi8>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    "llvm.return"(%1) : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>) -> (memref<?xf32>, memref<?xf32>), sym_name = "unconvertible_multiresult"}> ({
  ^bb0(%arg2: memref<?xf32>, %arg3: memref<?xf32>):
    "func.return"(%arg2, %arg3) : (memref<?xf32>, memref<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<*xi32>) -> (), sym_name = "unranked_memref"}> ({
  ^bb0(%arg1: memref<*xi32>):
    "func.call"(%arg1) <{callee = @printMemrefI32}> : (memref<*xi32>) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<*xi32>) -> (), sym_name = "printMemrefI32", sym_visibility = "private"}> ({
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_conversion_patterns"(%0) <{legal_dialects = ["llvm"], partial_conversion}> ({
        "transform.apply_conversion_patterns.func.func_to_llvm"() : () -> ()
      }, {
        "transform.apply_conversion_patterns.memref.memref_to_llvm_type_converter"() <{use_bare_ptr_call_conv = true}> {use_opaque_pointers = true} : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

