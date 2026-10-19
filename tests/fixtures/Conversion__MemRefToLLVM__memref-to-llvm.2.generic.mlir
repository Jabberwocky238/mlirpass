"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64)>, linkage = #llvm.linkage<external>, sym_name = "malloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "view"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %3 = "llvm.mlir.constant"() <{value = 2048 : index}> : () -> i64
    %4 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %5 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %6 = "llvm.getelementptr"(%5, %3) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %7 = "llvm.ptrtoint"(%6) : (!llvm.ptr) -> i64
    %8 = "llvm.call"(%7) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %9 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %10 = "llvm.insertvalue"(%9, %8) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %11 = "llvm.insertvalue"(%10, %8) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %12 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %13 = "llvm.insertvalue"(%11, %12) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %14 = "llvm.insertvalue"(%13, %3) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %15 = "llvm.insertvalue"(%14, %4) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %16 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %17 = "llvm.extractvalue"(%15) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %18 = "llvm.insertvalue"(%16, %17) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %19 = "llvm.extractvalue"(%15) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %20 = "llvm.getelementptr"(%19, %2) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %21 = "llvm.insertvalue"(%18, %20) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %22 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %23 = "llvm.insertvalue"(%21, %22) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %24 = "llvm.insertvalue"(%23, %0) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %25 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %26 = "llvm.insertvalue"(%24, %25) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %27 = "llvm.insertvalue"(%26, %1) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %28 = "llvm.mul"(%25, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %29 = "llvm.insertvalue"(%27, %28) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %30 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %31 = "llvm.extractvalue"(%15) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %32 = "llvm.insertvalue"(%30, %31) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %33 = "llvm.extractvalue"(%15) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %34 = "llvm.getelementptr"(%33, %2) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %35 = "llvm.insertvalue"(%32, %34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %36 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %37 = "llvm.insertvalue"(%35, %36) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %38 = "llvm.insertvalue"(%37, %0) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %39 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %40 = "llvm.insertvalue"(%38, %39) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %41 = "llvm.mlir.constant"() <{value = 4 : index}> : () -> i64
    %42 = "llvm.insertvalue"(%40, %41) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %43 = "llvm.mul"(%39, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %44 = "llvm.insertvalue"(%42, %43) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %45 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %46 = "llvm.extractvalue"(%15) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %47 = "llvm.insertvalue"(%45, %46) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %48 = "llvm.extractvalue"(%15) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %49 = "llvm.getelementptr"(%48, %2) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %50 = "llvm.insertvalue"(%47, %49) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %51 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %52 = "llvm.insertvalue"(%50, %51) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %53 = "llvm.mlir.constant"() <{value = 4 : index}> : () -> i64
    %54 = "llvm.insertvalue"(%52, %53) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %55 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %56 = "llvm.insertvalue"(%54, %55) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %57 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
    %58 = "llvm.insertvalue"(%56, %57) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %59 = "llvm.mlir.constant"() <{value = 4 : index}> : () -> i64
    %60 = "llvm.insertvalue"(%58, %59) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %61 = "llvm.mlir.constant"() <{value = 2048 : index}> : () -> i64
    %62 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %63 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %64 = "llvm.getelementptr"(%63, %61) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %65 = "llvm.ptrtoint"(%64) : (!llvm.ptr) -> i64
    %66 = "llvm.call"(%65) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %67 = "llvm.addrspacecast"(%66) : (!llvm.ptr) -> !llvm.ptr<4>
    %68 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<4>, ptr<4>, i64, array<1 x i64>, array<1 x i64>)>
    %69 = "llvm.insertvalue"(%68, %67) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<4>, ptr<4>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<4>) -> !llvm.struct<(ptr<4>, ptr<4>, i64, array<1 x i64>, array<1 x i64>)>
    %70 = "llvm.insertvalue"(%69, %67) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<4>, ptr<4>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<4>) -> !llvm.struct<(ptr<4>, ptr<4>, i64, array<1 x i64>, array<1 x i64>)>
    %71 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %72 = "llvm.insertvalue"(%70, %71) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<4>, ptr<4>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<4>, ptr<4>, i64, array<1 x i64>, array<1 x i64>)>
    %73 = "llvm.insertvalue"(%72, %61) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<4>, ptr<4>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<4>, ptr<4>, i64, array<1 x i64>, array<1 x i64>)>
    %74 = "llvm.insertvalue"(%73, %62) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<4>, ptr<4>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<4>, ptr<4>, i64, array<1 x i64>, array<1 x i64>)>
    %75 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<4>, ptr<4>, i64, array<2 x i64>, array<2 x i64>)>
    %76 = "llvm.extractvalue"(%74) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<4>, ptr<4>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<4>
    %77 = "llvm.insertvalue"(%75, %76) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<4>, ptr<4>, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr<4>) -> !llvm.struct<(ptr<4>, ptr<4>, i64, array<2 x i64>, array<2 x i64>)>
    %78 = "llvm.extractvalue"(%74) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<4>, ptr<4>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<4>
    %79 = "llvm.getelementptr"(%78, %2) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<4>, i64) -> !llvm.ptr<4>
    %80 = "llvm.insertvalue"(%77, %79) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<4>, ptr<4>, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr<4>) -> !llvm.struct<(ptr<4>, ptr<4>, i64, array<2 x i64>, array<2 x i64>)>
    %81 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %82 = "llvm.insertvalue"(%80, %81) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<4>, ptr<4>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<4>, ptr<4>, i64, array<2 x i64>, array<2 x i64>)>
    %83 = "llvm.mlir.constant"() <{value = 4 : index}> : () -> i64
    %84 = "llvm.insertvalue"(%82, %83) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr<4>, ptr<4>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<4>, ptr<4>, i64, array<2 x i64>, array<2 x i64>)>
    %85 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %86 = "llvm.insertvalue"(%84, %85) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr<4>, ptr<4>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<4>, ptr<4>, i64, array<2 x i64>, array<2 x i64>)>
    %87 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
    %88 = "llvm.insertvalue"(%86, %87) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<4>, ptr<4>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<4>, ptr<4>, i64, array<2 x i64>, array<2 x i64>)>
    %89 = "llvm.mlir.constant"() <{value = 4 : index}> : () -> i64
    %90 = "llvm.insertvalue"(%88, %89) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<4>, ptr<4>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<4>, ptr<4>, i64, array<2 x i64>, array<2 x i64>)>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, memref<0xi8>) -> (), sym_name = "view_empty_memref"}> ({
  ^bb0(%arg0: index, %arg1: memref<0xi8>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (memref<0xi8>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %4 = "llvm.insertvalue"(%2, %3) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %5 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %6 = "llvm.getelementptr"(%5, %0) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %7 = "llvm.insertvalue"(%4, %6) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %8 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %9 = "llvm.insertvalue"(%7, %8) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %10 = "llvm.mlir.constant"() <{value = 4 : index}> : () -> i64
    %11 = "llvm.insertvalue"(%9, %10) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %12 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %13 = "llvm.insertvalue"(%11, %12) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %14 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %15 = "llvm.insertvalue"(%13, %14) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %16 = "llvm.mlir.constant"() <{value = 4 : index}> : () -> i64
    %17 = "llvm.insertvalue"(%15, %16) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, memref<2xi8>) -> (), sym_name = "view_memref_as_rank0"}> ({
  ^bb0(%arg0: index, %arg1: memref<2xi8>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (memref<2xi8>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %3 = "llvm.extractvalue"(%1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %4 = "llvm.insertvalue"(%2, %3) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %5 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %6 = "llvm.getelementptr"(%5, %0) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %7 = "llvm.insertvalue"(%4, %6) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %8 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %9 = "llvm.insertvalue"(%7, %8) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<64x4xf32, strided<[4, 1]>>, index, index, index) -> (), sym_name = "subview"}> ({
  ^bb0(%arg0: memref<64x4xf32, strided<[4, 1]>>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "memref.subview"(%arg0, %arg1, %arg2, %arg1, %arg2, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 2, 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (memref<64x4xf32, strided<[4, 1]>>, index, index, index, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x4xf16>) -> (), sym_name = "assume_alignment"}> ({
  ^bb0(%arg0: memref<4x4xf16>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<4x4xf16>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    %3 = "llvm.mlir.constant"() <{value = 16 : index}> : () -> i64
    "llvm.intr.assume"(%2, %1, %3) <{op_bundle_sizes = array<i32: 2>, op_bundle_tags = ["align"]}> : (i1, !llvm.ptr, i64) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf16>, memref<?xf32>, memref<?xf64>) -> (memref<?xf16>, memref<?xf32>, memref<?xf64>), sym_name = "distinct_objects"}> ({
  ^bb0(%arg0: memref<?xf16>, %arg1: memref<?xf32>, %arg2: memref<?xf64>):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<?xf64>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf16>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %4 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %5 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %6 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    "llvm.intr.assume"(%6, %3, %4) <{op_bundle_sizes = array<i32: 2>, op_bundle_tags = ["separate_storage"]}> : (i1, !llvm.ptr, !llvm.ptr) -> ()
    "llvm.intr.assume"(%6, %3, %5) <{op_bundle_sizes = array<i32: 2>, op_bundle_tags = ["separate_storage"]}> : (i1, !llvm.ptr, !llvm.ptr) -> ()
    "llvm.intr.assume"(%6, %4, %5) <{op_bundle_sizes = array<i32: 2>, op_bundle_tags = ["separate_storage"]}> : (i1, !llvm.ptr, !llvm.ptr) -> ()
    "func.return"(%arg0, %arg1, %arg2) : (memref<?xf16>, memref<?xf32>, memref<?xf64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf16>) -> memref<?xf16>, sym_name = "distinct_objects_noop"}> ({
  ^bb0(%arg0: memref<?xf16>):
    "func.return"(%arg0) : (memref<?xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x4xf16, strided<[?, ?], offset: ?>>) -> (), sym_name = "assume_alignment_w_offset"}> ({
  ^bb0(%arg0: memref<4x4xf16, strided<[?, ?], offset: ?>>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<4x4xf16, strided<[?, ?], offset: ?>>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %3 = "llvm.getelementptr"(%1, %2) <{elem_type = f16, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %4 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    %5 = "llvm.mlir.constant"() <{value = 16 : index}> : () -> i64
    "llvm.intr.assume"(%4, %3, %5) <{op_bundle_sizes = array<i32: 2>, op_bundle_tags = ["align"]}> : (i1, !llvm.ptr, i64) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xi32>) -> index, sym_name = "dim_of_unranked"}> ({
  ^bb0(%arg0: memref<*xi32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<*xi32>) -> !llvm.struct<(i64, ptr)>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i64
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>) -> !llvm.ptr
    %4 = "llvm.getelementptr"(%3) <{elem_type = !llvm.struct<(ptr, ptr, i64)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 2>}> : (!llvm.ptr) -> !llvm.ptr
    %5 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %6 = "llvm.add"(%5, %2) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%4, %6) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %8 = "llvm.load"(%7) <{ordering = 0 : i64}> : (!llvm.ptr) -> i64
    %9 = "builtin.unrealized_conversion_cast"(%8) : (i64) -> index
    "func.return"(%9) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64)>, linkage = #llvm.linkage<external>, sym_name = "malloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<32xf32, 7>) -> (), sym_name = "address_space"}> ({
  ^bb0(%arg0: memref<32xf32, 7>):
    %0 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
    %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
    %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %6 = "llvm.addrspacecast"(%5) : (!llvm.ptr) -> !llvm.ptr<5>
    %7 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)>
    %8 = "llvm.insertvalue"(%7, %6) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<5>) -> !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)>
    %9 = "llvm.insertvalue"(%8, %6) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<5>) -> !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %11 = "llvm.insertvalue"(%9, %10) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)>
    %12 = "llvm.insertvalue"(%11, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)>
    %13 = "llvm.insertvalue"(%12, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)>
    %14 = "arith.constant"() <{value = 7 : index}> : () -> index
    %15 = "builtin.unrealized_conversion_cast"(%14) : (index) -> i64
    %16 = "llvm.extractvalue"(%13) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<5>, ptr<5>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<5>
    %17 = "llvm.getelementptr"(%16, %15) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<5>, i64) -> !llvm.ptr<5>
    %18 = "llvm.load"(%17) <{ordering = 0 : i64}> : (!llvm.ptr<5>) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) -> (), sym_name = "transpose"}> ({
  ^bb0(%arg0: memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %1 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> !llvm.ptr
    %3 = "llvm.insertvalue"(%1, %2) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %4 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> !llvm.ptr
    %5 = "llvm.insertvalue"(%3, %4) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %6 = "llvm.extractvalue"(%0) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> i64
    %7 = "llvm.insertvalue"(%5, %6) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %8 = "llvm.extractvalue"(%0) <{position = array<i64: 3, 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> i64
    %9 = "llvm.insertvalue"(%7, %8) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %10 = "llvm.extractvalue"(%0) <{position = array<i64: 4, 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> i64
    %11 = "llvm.insertvalue"(%9, %10) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %12 = "llvm.extractvalue"(%0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> i64
    %13 = "llvm.insertvalue"(%11, %12) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %14 = "llvm.extractvalue"(%0) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> i64
    %15 = "llvm.insertvalue"(%13, %14) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %16 = "llvm.extractvalue"(%0) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> i64
    %17 = "llvm.insertvalue"(%15, %16) <{position = array<i64: 3, 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %18 = "llvm.extractvalue"(%0) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> i64
    %19 = "llvm.insertvalue"(%17, %18) <{position = array<i64: 4, 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.mlir.global"() <{addr_space = 0 : i32, global_type = !llvm.array<2 x f32>, linkage = #llvm.linkage<external>, sym_name = "gv0", visibility_ = 0 : i64}> ({
    %49 = "llvm.mlir.undef"() : () -> !llvm.array<2 x f32>
    "llvm.return"(%49) : (!llvm.array<2 x f32>) -> ()
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 0 : i32, global_type = !llvm.array<2 x f32>, linkage = #llvm.linkage<private>, sym_name = "gv1", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 0 : i32, global_type = !llvm.array<2 x array<3 x f32>>, linkage = #llvm.linkage<external>, sym_name = "gv2", value = dense<[[0.000000e+00, 1.000000e+00, 2.000000e+00], [3.000000e+00, 4.000000e+00, 5.000000e+00]]> : tensor<2x3xf32>, visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "get_gv0_memref"}> ({
    %33 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %34 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %35 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %36 = "llvm.getelementptr"(%35, %33) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %37 = "llvm.ptrtoint"(%36) : (!llvm.ptr) -> i64
    %38 = "llvm.mlir.addressof"() <{global_name = @gv0}> : () -> !llvm.ptr
    %39 = "llvm.getelementptr"(%38) <{elem_type = !llvm.array<2 x f32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
    %40 = "llvm.mlir.constant"() <{value = 3735928559 : index}> : () -> i64
    %41 = "llvm.inttoptr"(%40) : (i64) -> !llvm.ptr
    %42 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %43 = "llvm.insertvalue"(%42, %41) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %44 = "llvm.insertvalue"(%43, %39) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %45 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %46 = "llvm.insertvalue"(%44, %45) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %47 = "llvm.insertvalue"(%46, %33) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %48 = "llvm.insertvalue"(%47, %34) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "get_gv2_memref"}> ({
    %13 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %14 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
    %15 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %16 = "llvm.mlir.constant"() <{value = 6 : index}> : () -> i64
    %17 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %18 = "llvm.getelementptr"(%17, %16) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %19 = "llvm.ptrtoint"(%18) : (!llvm.ptr) -> i64
    %20 = "llvm.mlir.addressof"() <{global_name = @gv2}> : () -> !llvm.ptr
    %21 = "llvm.getelementptr"(%20) <{elem_type = !llvm.array<2 x array<3 x f32>>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
    %22 = "llvm.mlir.constant"() <{value = 3735928559 : index}> : () -> i64
    %23 = "llvm.inttoptr"(%22) : (i64) -> !llvm.ptr
    %24 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %25 = "llvm.insertvalue"(%24, %23) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %26 = "llvm.insertvalue"(%25, %21) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %27 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %28 = "llvm.insertvalue"(%26, %27) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %29 = "llvm.insertvalue"(%28, %13) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %30 = "llvm.insertvalue"(%29, %14) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %31 = "llvm.insertvalue"(%30, %14) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %32 = "llvm.insertvalue"(%31, %15) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    "func.return"() : () -> ()
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 0 : i32, global_type = f32, linkage = #llvm.linkage<external>, sym_name = "gv3", value = 1.000000e+00 : f32, visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "get_gv3_memref"}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %1 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %2 = "llvm.getelementptr"(%1, %0) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %3 = "llvm.ptrtoint"(%2) : (!llvm.ptr) -> i64
    %4 = "llvm.mlir.addressof"() <{global_name = @gv3}> : () -> !llvm.ptr
    %5 = "llvm.getelementptr"(%4) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0>}> : (!llvm.ptr) -> !llvm.ptr
    %6 = "llvm.mlir.constant"() <{value = 3735928559 : index}> : () -> i64
    %7 = "llvm.inttoptr"(%6) : (i64) -> !llvm.ptr
    %8 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %9 = "llvm.insertvalue"(%8, %7) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %10 = "llvm.insertvalue"(%9, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %11 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %12 = "llvm.insertvalue"(%10, %11) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
    "func.return"() : () -> ()
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 0 : i32, alignment = 64 : i64, global_type = f32, linkage = #llvm.linkage<private>, sym_name = "gv4", value = 1.000000e+00 : f32, visibility_ = 0 : i64}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<3x4x5xf32>) -> memref<1x3x4x1x5xf32>, sym_name = "expand_shape_static"}> ({
  ^bb0(%arg0: memref<3x4x5xf32>):
    %0 = "memref.expand_shape"(%arg0) <{reassociation = [[0, 1], [2], [3, 4]], static_output_shape = array<i64: 1, 3, 4, 1, 5>}> : (memref<3x4x5xf32>) -> memref<1x3x4x1x5xf32>
    "func.return"(%0) : (memref<1x3x4x1x5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x3x4x1x5xf32>) -> memref<3x4x5xf32>, sym_name = "collapse_shape_static"}> ({
  ^bb0(%arg0: memref<1x3x4x1x5xf32>):
    %0 = "memref.collapse_shape"(%arg0) <{reassociation = [[0, 1], [2], [3, 4]]}> : (memref<1x3x4x1x5xf32>) -> memref<3x4x5xf32>
    "func.return"(%0) : (memref<3x4x5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xi32>) -> (), sym_name = "rank_of_unranked"}> ({
  ^bb0(%arg0: memref<*xi32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<*xi32>) -> !llvm.struct<(i64, ptr)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>) -> i64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi32>) -> (), sym_name = "rank_of_ranked"}> ({
  ^bb0(%arg0: memref<?xi32>):
    %0 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10xi32>, i32, memref<10xf32>, f32, index) -> (), sym_name = "atomic_rmw"}> ({
  ^bb0(%arg0: memref<10xi32>, %arg1: i32, %arg2: memref<10xf32>, %arg3: f32, %arg4: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<10xi32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "builtin.unrealized_conversion_cast"(%arg4) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<10xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %4 = "llvm.getelementptr"(%3, %1) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %5 = "llvm.atomicrmw"(%4, %arg3) <{bin_op = 0 : i64, ordering = 6 : i64}> : (!llvm.ptr, f32) -> f32
    %6 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %7 = "llvm.getelementptr"(%6, %1) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %8 = "llvm.atomicrmw"(%7, %arg1) <{bin_op = 1 : i64, ordering = 6 : i64}> : (!llvm.ptr, i32) -> i32
    %9 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %10 = "llvm.getelementptr"(%9, %1) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %11 = "llvm.atomicrmw"(%10, %arg1) <{bin_op = 7 : i64, ordering = 6 : i64}> : (!llvm.ptr, i32) -> i32
    %12 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %13 = "llvm.getelementptr"(%12, %1) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %14 = "llvm.atomicrmw"(%13, %arg1) <{bin_op = 8 : i64, ordering = 6 : i64}> : (!llvm.ptr, i32) -> i32
    %15 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %16 = "llvm.getelementptr"(%15, %1) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %17 = "llvm.atomicrmw"(%16, %arg1) <{bin_op = 9 : i64, ordering = 6 : i64}> : (!llvm.ptr, i32) -> i32
    %18 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %19 = "llvm.getelementptr"(%18, %1) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %20 = "llvm.atomicrmw"(%19, %arg1) <{bin_op = 10 : i64, ordering = 6 : i64}> : (!llvm.ptr, i32) -> i32
    %21 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %22 = "llvm.getelementptr"(%21, %1) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %23 = "llvm.atomicrmw"(%22, %arg3) <{bin_op = 11 : i64, ordering = 6 : i64}> : (!llvm.ptr, f32) -> f32
    %24 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %25 = "llvm.getelementptr"(%24, %1) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %26 = "llvm.atomicrmw"(%25, %arg3) <{bin_op = 19 : i64, ordering = 6 : i64}> : (!llvm.ptr, f32) -> f32
    %27 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %28 = "llvm.getelementptr"(%27, %1) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %29 = "llvm.atomicrmw"(%28, %arg3) <{bin_op = 13 : i64, ordering = 6 : i64}> : (!llvm.ptr, f32) -> f32
    %30 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %31 = "llvm.getelementptr"(%30, %1) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %32 = "llvm.atomicrmw"(%31, %arg3) <{bin_op = 20 : i64, ordering = 6 : i64}> : (!llvm.ptr, f32) -> f32
    %33 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %34 = "llvm.getelementptr"(%33, %1) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %35 = "llvm.atomicrmw"(%34, %arg3) <{bin_op = 14 : i64, ordering = 6 : i64}> : (!llvm.ptr, f32) -> f32
    %36 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %37 = "llvm.getelementptr"(%36, %1) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %38 = "llvm.atomicrmw"(%37, %arg1) <{bin_op = 5 : i64, ordering = 6 : i64}> : (!llvm.ptr, i32) -> i32
    %39 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %40 = "llvm.getelementptr"(%39, %1) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %41 = "llvm.atomicrmw"(%40, %arg1) <{bin_op = 3 : i64, ordering = 6 : i64}> : (!llvm.ptr, i32) -> i32
    %42 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %43 = "llvm.getelementptr"(%42, %1) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %44 = "llvm.atomicrmw"(%43, %arg1) <{bin_op = 6 : i64, ordering = 6 : i64}> : (!llvm.ptr, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10xi32, strided<[1], offset: 5>>, i32, index) -> (), sym_name = "atomic_rmw_with_offset"}> ({
  ^bb0(%arg0: memref<10xi32, strided<[1], offset: 5>>, %arg1: i32, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<10xi32, strided<[1], offset: 5>>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %3 = "llvm.mlir.constant"() <{value = 5 : index}> : () -> i64
    %4 = "llvm.getelementptr"(%2, %3) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %5 = "llvm.getelementptr"(%4, %0) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %6 = "llvm.atomicrmw"(%5, %arg1) <{bin_op = 3 : i64, ordering = 6 : i64}> : (!llvm.ptr, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "generic_atomic_rmw", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "test.foo"() : () -> memref<10xi32>
    %1 = "builtin.unrealized_conversion_cast"(%0) : (memref<10xi32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = "test.foo"() : () -> index
    %3 = "builtin.unrealized_conversion_cast"(%2) : (index) -> i64
    %4 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %5 = "llvm.getelementptr"(%4, %3) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %6 = "llvm.load"(%5) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.br"(%6)[^bb1] : (i32) -> ()
  ^bb1(%7: i32):  // 2 preds: ^bb0, ^bb1
    %8 = "llvm.cmpxchg"(%5, %7, %7) <{failure_ordering = 2 : i64, success_ordering = 6 : i64}> : (!llvm.ptr, i32, i32) -> !llvm.struct<(i32, i1)>
    %9 = "llvm.extractvalue"(%8) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
    %10 = "llvm.extractvalue"(%8) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
    "llvm.cond_br"(%10, %9)[^bb2, ^bb1] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
  ^bb2:  // pred: ^bb1
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64)>, linkage = #llvm.linkage<external>, sym_name = "malloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "generic_atomic_rmw_in_alloca_scope", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "builtin.unrealized_conversion_cast"(%0) : (index) -> i64
    %2 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %3 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
    %4 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %5 = "llvm.mlir.constant"() <{value = 6 : index}> : () -> i64
    %6 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %7 = "llvm.getelementptr"(%6, %5) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %8 = "llvm.ptrtoint"(%7) : (!llvm.ptr) -> i64
    %9 = "llvm.call"(%8) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %10 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %11 = "llvm.insertvalue"(%10, %9) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %12 = "llvm.insertvalue"(%11, %9) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %13 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %14 = "llvm.insertvalue"(%12, %13) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %15 = "llvm.insertvalue"(%14, %2) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %16 = "llvm.insertvalue"(%15, %3) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %17 = "llvm.insertvalue"(%16, %3) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %18 = "llvm.insertvalue"(%17, %4) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %19 = "llvm.intr.stacksave"() : () -> !llvm.ptr
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %20 = "llvm.extractvalue"(%18) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %21 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
    %22 = "llvm.mul"(%1, %21) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %23 = "llvm.add"(%22, %1) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %24 = "llvm.getelementptr"(%20, %23) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %25 = "llvm.load"(%24) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.br"(%25)[^bb2] : (i32) -> ()
  ^bb2(%26: i32):  // 2 preds: ^bb1, ^bb2
    %27 = "llvm.cmpxchg"(%24, %26, %26) <{failure_ordering = 2 : i64, success_ordering = 6 : i64}> : (!llvm.ptr, i32, i32) -> !llvm.struct<(i32, i1)>
    %28 = "llvm.extractvalue"(%27) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
    %29 = "llvm.extractvalue"(%27) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
    "llvm.cond_br"(%29, %28)[^bb3, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
  ^bb3:  // pred: ^bb2
    "llvm.intr.stackrestore"(%19) : (!llvm.ptr) -> ()
    "llvm.br"()[^bb4] : () -> ()
  ^bb4:  // pred: ^bb3
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64)>, linkage = #llvm.linkage<external>, sym_name = "malloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "memref_copy_ranked"}> ({
    %0 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
    %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %6 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %13 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %14 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %15 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %16 = "llvm.getelementptr"(%15, %13) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %17 = "llvm.ptrtoint"(%16) : (!llvm.ptr) -> i64
    %18 = "llvm.call"(%17) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %19 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %20 = "llvm.insertvalue"(%19, %18) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %21 = "llvm.insertvalue"(%20, %18) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %22 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %23 = "llvm.insertvalue"(%21, %22) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %24 = "llvm.insertvalue"(%23, %13) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %25 = "llvm.insertvalue"(%24, %14) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %26 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %27 = "llvm.extractvalue"(%12) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %28 = "llvm.mul"(%26, %27) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %29 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %30 = "llvm.getelementptr"(%29) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %31 = "llvm.ptrtoint"(%30) : (!llvm.ptr) -> i64
    %32 = "llvm.mul"(%28, %31) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %33 = "llvm.extractvalue"(%12) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %34 = "llvm.extractvalue"(%12) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %35 = "llvm.getelementptr"(%33, %34) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %36 = "llvm.extractvalue"(%25) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %37 = "llvm.extractvalue"(%25) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %38 = "llvm.getelementptr"(%36, %37) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.memcpy"(%38, %35, %32) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64)>, linkage = #llvm.linkage<external>, sym_name = "malloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<16x4xi32>, index) -> (), sym_name = "memref_copy_contiguous"}> ({
  ^bb0(%arg0: memref<16x4xi32>, %arg1: index):
    %0 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %1 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %2 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %3 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %4 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %5 = "llvm.getelementptr"(%4, %3) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %6 = "llvm.ptrtoint"(%5) : (!llvm.ptr) -> i64
    %7 = "llvm.call"(%6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %8 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %9 = "llvm.insertvalue"(%8, %7) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %10 = "llvm.insertvalue"(%9, %7) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %11 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %12 = "llvm.insertvalue"(%10, %11) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %13 = "llvm.insertvalue"(%12, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %14 = "llvm.insertvalue"(%13, %1) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %15 = "llvm.insertvalue"(%14, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %16 = "llvm.insertvalue"(%15, %2) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %17 = "memref.subview"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 1, 2>, static_strides = array<i64: 1, 1>}> : (memref<16x4xi32>, index) -> memref<1x2xi32, strided<[4, 1], offset: ?>>
    %18 = "builtin.unrealized_conversion_cast"(%17) : (memref<1x2xi32, strided<[4, 1], offset: ?>>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %19 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %20 = "llvm.extractvalue"(%18) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %21 = "llvm.mul"(%19, %20) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %22 = "llvm.extractvalue"(%18) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %23 = "llvm.mul"(%21, %22) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %24 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %25 = "llvm.getelementptr"(%24) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %26 = "llvm.ptrtoint"(%25) : (!llvm.ptr) -> i64
    %27 = "llvm.mul"(%23, %26) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %28 = "llvm.extractvalue"(%18) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %29 = "llvm.extractvalue"(%18) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %30 = "llvm.getelementptr"(%28, %29) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %31 = "llvm.extractvalue"(%16) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %32 = "llvm.extractvalue"(%16) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %33 = "llvm.getelementptr"(%31, %32) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.memcpy"(%33, %30, %27) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64)>, linkage = #llvm.linkage<external>, sym_name = "malloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<2xi32>) -> (), sym_name = "memref_copy_0d_offset"}> ({
  ^bb0(%arg0: memref<2xi32>):
    %0 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %1 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %2 = "llvm.getelementptr"(%1, %0) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %3 = "llvm.ptrtoint"(%2) : (!llvm.ptr) -> i64
    %4 = "llvm.call"(%3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %5 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %6 = "llvm.insertvalue"(%5, %4) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %7 = "llvm.insertvalue"(%6, %4) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %8 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %9 = "llvm.insertvalue"(%7, %8) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
    %10 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 1>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<2xi32>) -> memref<1xi32, strided<[1], offset: 1>>
    %11 = "memref.collapse_shape"(%10) <{reassociation = []}> : (memref<1xi32, strided<[1], offset: 1>>) -> memref<i32, strided<[], offset: 1>>
    %12 = "builtin.unrealized_conversion_cast"(%11) : (memref<i32, strided<[], offset: 1>>) -> !llvm.struct<(ptr, ptr, i64)>
    %13 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %14 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %15 = "llvm.getelementptr"(%14) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %16 = "llvm.ptrtoint"(%15) : (!llvm.ptr) -> i64
    %17 = "llvm.mul"(%13, %16) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %18 = "llvm.extractvalue"(%12) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
    %19 = "llvm.extractvalue"(%12) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>) -> i64
    %20 = "llvm.getelementptr"(%18, %19) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %21 = "llvm.extractvalue"(%9) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
    %22 = "llvm.extractvalue"(%9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>) -> i64
    %23 = "llvm.getelementptr"(%21, %22) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.memcpy"(%23, %20, %17) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64, ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "memrefCopy", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64)>, linkage = #llvm.linkage<external>, sym_name = "malloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<16x2xi32>, index) -> (), sym_name = "memref_copy_noncontiguous"}> ({
  ^bb0(%arg0: memref<16x2xi32>, %arg1: index):
    %0 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %2 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %3 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %4 = "llvm.getelementptr"(%3, %0) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %5 = "llvm.ptrtoint"(%4) : (!llvm.ptr) -> i64
    %6 = "llvm.call"(%5) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %7 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %8 = "llvm.insertvalue"(%7, %6) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %9 = "llvm.insertvalue"(%8, %6) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %10 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %11 = "llvm.insertvalue"(%9, %10) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %12 = "llvm.insertvalue"(%11, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %13 = "llvm.insertvalue"(%12, %1) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %14 = "llvm.insertvalue"(%13, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %15 = "llvm.insertvalue"(%14, %2) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %16 = "memref.subview"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 2, 1>, static_strides = array<i64: 1, 1>}> : (memref<16x2xi32>, index) -> memref<2x1xi32, strided<[2, 1], offset: ?>>
    %17 = "builtin.unrealized_conversion_cast"(%16) : (memref<2x1xi32, strided<[2, 1], offset: ?>>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %18 = "llvm.intr.stacksave"() : () -> !llvm.ptr
    %19 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %20 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %21 = "llvm.alloca"(%20) <{elem_type = !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>}> : (i64) -> !llvm.ptr
    "llvm.store"(%17, %21) <{ordering = 0 : i64}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> ()
    %22 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, ptr)>
    %23 = "llvm.insertvalue"(%22, %19) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>, i64) -> !llvm.struct<(i64, ptr)>
    %24 = "llvm.insertvalue"(%23, %21) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>, !llvm.ptr) -> !llvm.struct<(i64, ptr)>
    %25 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %26 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %27 = "llvm.alloca"(%26) <{elem_type = !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>}> : (i64) -> !llvm.ptr
    "llvm.store"(%15, %27) <{ordering = 0 : i64}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> ()
    %28 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, ptr)>
    %29 = "llvm.insertvalue"(%28, %25) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>, i64) -> !llvm.struct<(i64, ptr)>
    %30 = "llvm.insertvalue"(%29, %27) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>, !llvm.ptr) -> !llvm.struct<(i64, ptr)>
    %31 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %32 = "llvm.alloca"(%31) <{elem_type = !llvm.struct<(i64, ptr)>}> : (i64) -> !llvm.ptr
    "llvm.store"(%24, %32) <{ordering = 0 : i64}> : (!llvm.struct<(i64, ptr)>, !llvm.ptr) -> ()
    %33 = "llvm.alloca"(%31) <{elem_type = !llvm.struct<(i64, ptr)>}> : (i64) -> !llvm.ptr
    "llvm.store"(%30, %33) <{ordering = 0 : i64}> : (!llvm.struct<(i64, ptr)>, !llvm.ptr) -> ()
    %34 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %35 = "llvm.getelementptr"(%34) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %36 = "llvm.ptrtoint"(%35) : (!llvm.ptr) -> i64
    "llvm.call"(%36, %32, %33) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @memrefCopy, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (i64, !llvm.ptr, !llvm.ptr) -> ()
    "llvm.intr.stackrestore"(%18) : (!llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64, ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "memrefCopy", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64)>, linkage = #llvm.linkage<external>, sym_name = "malloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "memref_copy_unranked"}> ({
    %0 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %3 = "llvm.getelementptr"(%2, %0) <{elem_type = i1, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
    %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %6 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %13 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %14 = "llvm.alloca"(%13) <{elem_type = !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>}> : (i64) -> !llvm.ptr
    "llvm.store"(%12, %14) <{ordering = 0 : i64}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> ()
    %15 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %16 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, ptr)>
    %17 = "llvm.insertvalue"(%16, %15) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>, i64) -> !llvm.struct<(i64, ptr)>
    %18 = "llvm.insertvalue"(%17, %14) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>, !llvm.ptr) -> !llvm.struct<(i64, ptr)>
    %19 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %20 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %21 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %22 = "llvm.getelementptr"(%21, %19) <{elem_type = i1, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %23 = "llvm.ptrtoint"(%22) : (!llvm.ptr) -> i64
    %24 = "llvm.call"(%23) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %25 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %26 = "llvm.insertvalue"(%25, %24) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %27 = "llvm.insertvalue"(%26, %24) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %28 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %29 = "llvm.insertvalue"(%27, %28) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %30 = "llvm.insertvalue"(%29, %19) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %31 = "llvm.insertvalue"(%30, %20) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %32 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %33 = "llvm.alloca"(%32) <{elem_type = !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>}> : (i64) -> !llvm.ptr
    "llvm.store"(%31, %33) <{ordering = 0 : i64}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> ()
    %34 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %35 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, ptr)>
    %36 = "llvm.insertvalue"(%35, %34) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>, i64) -> !llvm.struct<(i64, ptr)>
    %37 = "llvm.insertvalue"(%36, %33) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>, !llvm.ptr) -> !llvm.struct<(i64, ptr)>
    %38 = "llvm.intr.stacksave"() : () -> !llvm.ptr
    %39 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %40 = "llvm.alloca"(%39) <{elem_type = !llvm.struct<(i64, ptr)>}> : (i64) -> !llvm.ptr
    "llvm.store"(%18, %40) <{ordering = 0 : i64}> : (!llvm.struct<(i64, ptr)>, !llvm.ptr) -> ()
    %41 = "llvm.alloca"(%39) <{elem_type = !llvm.struct<(i64, ptr)>}> : (i64) -> !llvm.ptr
    "llvm.store"(%37, %41) <{ordering = 0 : i64}> : (!llvm.struct<(i64, ptr)>, !llvm.ptr) -> ()
    %42 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %43 = "llvm.getelementptr"(%42) <{elem_type = i1, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %44 = "llvm.ptrtoint"(%43) : (!llvm.ptr) -> i64
    "llvm.call"(%44, %40, %41) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @memrefCopy, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (i64, !llvm.ptr, !llvm.ptr) -> ()
    "llvm.intr.stackrestore"(%38) : (!llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> index, sym_name = "extract_aligned_pointer_as_index"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %2 = "llvm.ptrtoint"(%1) : (!llvm.ptr) -> i64
    %3 = "builtin.unrealized_conversion_cast"(%2) : (i64) -> index
    "func.return"(%3) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xf32>) -> index, sym_name = "extract_aligned_pointer_as_index_unranked"}> ({
  ^bb0(%arg0: memref<*xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<*xf32>) -> !llvm.struct<(i64, ptr)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>) -> !llvm.ptr
    %2 = "llvm.getelementptr"(%1) <{elem_type = !llvm.ptr, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %3 = "llvm.load"(%2) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.ptr
    %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
    %5 = "builtin.unrealized_conversion_cast"(%4) : (i64) -> index
    "func.return"(%5) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32, strided<[?, ?], offset: ?>>) -> (), sym_name = "extract_strided_metadata"}> ({
  ^bb0(%arg0: memref<?x?xf32, strided<[?, ?], offset: ?>>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?x?xf32, strided<[?, ?], offset: ?>>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %3 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %4 = "llvm.insertvalue"(%3, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %5 = "llvm.insertvalue"(%4, %2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %6 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %7 = "llvm.insertvalue"(%5, %6) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
    %8 = "llvm.extractvalue"(%0) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %9 = "llvm.extractvalue"(%0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %10 = "llvm.extractvalue"(%0) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %11 = "llvm.extractvalue"(%0) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %12 = "llvm.extractvalue"(%0) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>) -> (), sym_name = "load_non_temporal"}> ({
  ^bb0(%arg0: memref<32xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<32xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "arith.constant"() <{value = 7 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i64
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %4 = "llvm.getelementptr"(%3, %2) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %5 = "llvm.load"(%4) <{nontemporal, ordering = 0 : i64}> : (!llvm.ptr) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>, index) -> (), sym_name = "load_with_alignment"}> ({
  ^bb0(%arg0: memref<32xf32>, %arg1: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<32xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %4 = "llvm.load"(%3) <{alignment = 32 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>, memref<32xf32>) -> (), sym_name = "store_non_temporal"}> ({
  ^bb0(%arg0: memref<32xf32>, %arg1: memref<32xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (memref<32xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<32xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = "arith.constant"() <{value = 7 : index}> : () -> index
    %3 = "builtin.unrealized_conversion_cast"(%2) : (index) -> i64
    %4 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %5 = "llvm.getelementptr"(%4, %3) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %6 = "llvm.load"(%5) <{nontemporal, ordering = 0 : i64}> : (!llvm.ptr) -> f32
    %7 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %8 = "llvm.getelementptr"(%7, %3) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.store"(%6, %8) <{nontemporal, ordering = 0 : i64}> : (f32, !llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>, f32, index) -> (), sym_name = "store_with_alignment"}> ({
  ^bb0(%arg0: memref<32xf32>, %arg1: f32, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<32xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.store"(%arg1, %3) <{alignment = 32 : i64, ordering = 0 : i64}> : (f32, !llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "alloca_unconvertable_memory_space"}> ({
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x32x33xi32, #spirv.storage_class<StorageBuffer>>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

