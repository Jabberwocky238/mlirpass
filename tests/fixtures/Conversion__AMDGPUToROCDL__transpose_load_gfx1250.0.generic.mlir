"builtin.module"() ({
  "func.func"() <{function_type = (index, index, memref<128x72xf16, 3>) -> vector<8xf16>, sym_name = "transpose_load_to_rocdl_8xf16"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: memref<128x72xf16, 3>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<128x72xf16, 3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<3>
    %4 = "llvm.mlir.constant"() <{value = 72 : index}> : () -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = f16, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
    %8 = "rocdl.ds.load.tr16.b128"(%7) : (!llvm.ptr<3>) -> vector<8xf16>
    "func.return"(%8) : (vector<8xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, memref<128x128xi8, 3>) -> vector<8xi8>, sym_name = "transpose_load_to_rocdl_8xi8"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: memref<128x128xi8, 3>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<128x128xi8, 3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<3>
    %4 = "llvm.mlir.constant"() <{value = 128 : index}> : () -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
    %8 = "rocdl.ds.load.tr8.b64"(%7) : (!llvm.ptr<3>) -> vector<2xi32>
    %9 = "llvm.bitcast"(%8) : (vector<2xi32>) -> vector<8xi8>
    "func.return"(%9) : (vector<8xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, memref<128x32xi8, 3>) -> vector<16xi4>, sym_name = "transpose_load_to_rocdl_16xi4"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: memref<128x32xi8, 3>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<128x32xi8, 3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<3>
    %4 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
    %8 = "rocdl.ds.load.tr4.b64"(%7) : (!llvm.ptr<3>) -> vector<2xi32>
    %9 = "llvm.bitcast"(%8) : (vector<2xi32>) -> vector<16xi4>
    "func.return"(%9) : (vector<16xi4>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, memref<128x32xi8, 3>) -> vector<16xi6>, sym_name = "transpose_load_to_rocdl_16xi6"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: memref<128x32xi8, 3>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<128x32xi8, 3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<3>
    %4 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
    %8 = "rocdl.ds.load.tr6.b96"(%7) : (!llvm.ptr<3>) -> vector<3xi32>
    %9 = "llvm.bitcast"(%8) : (vector<3xi32>) -> vector<16xi6>
    "func.return"(%9) : (vector<16xi6>) -> ()
  }) : () -> ()
}) : () -> ()

