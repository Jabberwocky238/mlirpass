"builtin.module"() ({
  "func.func"() <{function_type = (index, index, memref<128x256xf16, #gpu.address_space<global>>) -> vector<8xf16>, sym_name = "global_transpose_load_8xf16"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: memref<128x256xf16, #gpu.address_space<global>>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<128x256xf16, #gpu.address_space<global>>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<1>
    %4 = "llvm.mlir.constant"() <{value = 256 : index}> : () -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = f16, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>
    %8 = "rocdl.global.load.tr.b128"(%7) : (!llvm.ptr<1>) -> vector<8xf16>
    "func.return"(%8) : (vector<8xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, memref<128x256xi8, #gpu.address_space<global>>) -> vector<8xi8>, sym_name = "global_transpose_load_8xi8"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: memref<128x256xi8, #gpu.address_space<global>>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<128x256xi8, #gpu.address_space<global>>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<1>
    %4 = "llvm.mlir.constant"() <{value = 256 : index}> : () -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = i8, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>
    %8 = "rocdl.global.load.tr.b64"(%7) : (!llvm.ptr<1>) -> vector<2xi32>
    %9 = "llvm.bitcast"(%8) : (vector<2xi32>) -> vector<8xi8>
    "func.return"(%9) : (vector<8xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
// -----
