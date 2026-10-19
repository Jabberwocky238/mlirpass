"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, arg_attrs = [{llvm.noalias}, {llvm.noalias}], function_type = !llvm.func<void (ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "check_noalias", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr, %arg1: !llvm.ptr):
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0 * 20 + d1 + 1)>
#map1 = affine_map<(d0, d1)[s0] -> (d0 * s0 + d1 + 1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10x20xf32, #map>, memref<?x?xf32, #map1>, memref<10x?xf32, #map1>) -> (), sym_name = "check_strided_memref_arguments"}> ({
  ^bb0(%arg0: memref<10x20xf32, #map>, %arg1: memref<?x?xf32, #map1>, %arg2: memref<10x?xf32, #map1>):
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (ptr)>, linkage = #llvm.linkage<external>, sym_name = "memref_index", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "llvm.insertvalue"(%0, %arg0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = "llvm.insertvalue"(%1, %arg0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %3 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %4 = "llvm.insertvalue"(%2, %3) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %5 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
    %6 = "llvm.insertvalue"(%4, %5) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %7 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %8 = "llvm.insertvalue"(%6, %7) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %9 = "llvm.extractvalue"(%8) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    "llvm.return"(%9) : (!llvm.ptr) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10x20xf32>, memref<?x?xf32>, memref<10x?xf32>) -> (), sym_name = "check_arguments"}> ({
  ^bb0(%arg0: memref<10x20xf32>, %arg1: memref<?x?xf32>, %arg2: memref<10x?xf32>):
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xi8>) -> memref<*xi8>, sym_name = "hoo", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<*xi8>) -> memref<*xi8>, sym_name = "check_unranked_memref_func_call"}> ({
  ^bb0(%arg0: memref<*xi8>):
    %0 = "func.call"(%arg0) <{callee = @hoo}> : (memref<*xi8>) -> memref<*xi8>
    "func.return"(%0) : (memref<*xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<42x!test.memref_element>, sym_name = "unsupported_memref_element_type", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<*x!test.memref_element>, sym_name = "unsupported_unranked_memref_element_type", sym_visibility = "private"}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "goo", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32)>, linkage = #llvm.linkage<external>, sym_name = "check_scalar_func_call", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @goo, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(ptr<201>, ptr<201>)> (i64, i64, i64, ptr<201>, ptr<201>)>, linkage = #llvm.linkage<external>, sym_name = "loop_carried", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: !llvm.ptr<201>, %arg4: !llvm.ptr<201>):
    %0 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "llvm.insertvalue"(%0, %arg4) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<201>) -> !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>
    %2 = "llvm.insertvalue"(%1, %arg4) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<201>) -> !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>
    %3 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %4 = "llvm.insertvalue"(%2, %3) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>
    %5 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
    %6 = "llvm.insertvalue"(%4, %5) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>
    %7 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %8 = "llvm.insertvalue"(%6, %7) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>
    %9 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = "llvm.insertvalue"(%9, %arg3) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<201>) -> !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>
    %11 = "llvm.insertvalue"(%10, %arg3) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<201>) -> !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>
    %12 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %13 = "llvm.insertvalue"(%11, %12) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>
    %14 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
    %15 = "llvm.insertvalue"(%13, %14) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>
    %16 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %17 = "llvm.insertvalue"(%15, %16) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>
    "llvm.br"(%arg0, %17, %8)[^bb1] : (i64, !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>) -> ()
  ^bb1(%18: i64, %19: !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>, %20: !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>):  // 2 preds: ^bb0, ^bb2
    %21 = "llvm.icmp"(%18, %arg1) <{predicate = 2 : i64}> : (i64, i64) -> i1
    "llvm.cond_br"(%21)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %22 = "llvm.add"(%18, %arg2) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    "llvm.br"(%22, %20, %19)[^bb1] : (i64, !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>) -> ()
  ^bb3:  // pred: ^bb1
    %23 = "llvm.extractvalue"(%19) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<201>
    %24 = "llvm.extractvalue"(%20) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<201>
    %25 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<201>, ptr<201>)>
    %26 = "llvm.insertvalue"(%25, %23) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<201>, ptr<201>)>, !llvm.ptr<201>) -> !llvm.struct<(ptr<201>, ptr<201>)>
    %27 = "llvm.insertvalue"(%26, %24) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<201>, ptr<201>)>, !llvm.ptr<201>) -> !llvm.struct<(ptr<201>, ptr<201>)>
    "llvm.return"(%27) : (!llvm.struct<(ptr<201>, ptr<201>)>) -> ()
  }) : () -> ()
}) : () -> ()

