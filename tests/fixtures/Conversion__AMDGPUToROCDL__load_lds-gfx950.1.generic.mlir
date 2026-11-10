"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x72xf32, #amdgpu.address_space<fat_raw_buffer>>) -> (), sym_name = "fat_buffer_load_to_rocdl_f96"}> ({
  ^bb0(%arg0: memref<128x72xf32, #amdgpu.address_space<fat_raw_buffer>>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<128x72xf32, #amdgpu.address_space<fat_raw_buffer>>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i64
    %3 = "arith.constant"() <{value = 12 : index}> : () -> index
    %4 = "builtin.unrealized_conversion_cast"(%3) : (index) -> i64
    %5 = "arith.constant"() <{value = 32 : index}> : () -> index
    %6 = "builtin.unrealized_conversion_cast"(%5) : (index) -> i64
    %7 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xf32, #gpu.address_space<workgroup>>
    %8 = "builtin.unrealized_conversion_cast"(%7) : (memref<64x64xf32, #gpu.address_space<workgroup>>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %9 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<7>
    %10 = "llvm.mlir.constant"() <{value = 72 : index}> : () -> i64
    %11 = "llvm.mul"(%4, %10) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %12 = "llvm.add"(%11, %2) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %13 = "llvm.getelementptr"(%9, %12) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<7>, i64) -> !llvm.ptr<7>
    %14 = "llvm.extractvalue"(%8) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<3>
    %15 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
    %16 = "llvm.mul"(%6, %15) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %17 = "llvm.add"(%16, %2) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %18 = "llvm.getelementptr"(%14, %17) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
    "rocdl.load.to.lds"(%13, %18) <{aux = 0 : i32, offset = 0 : i32, size = 12 : i32}> : (!llvm.ptr<7>, !llvm.ptr<3>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x72xf32, #amdgpu.address_space<fat_raw_buffer>>) -> (), sym_name = "fat_buffer_load_to_rocdl_f128"}> ({
  ^bb0(%arg0: memref<128x72xf32, #amdgpu.address_space<fat_raw_buffer>>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<128x72xf32, #amdgpu.address_space<fat_raw_buffer>>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i64
    %3 = "arith.constant"() <{value = 12 : index}> : () -> index
    %4 = "builtin.unrealized_conversion_cast"(%3) : (index) -> i64
    %5 = "arith.constant"() <{value = 32 : index}> : () -> index
    %6 = "builtin.unrealized_conversion_cast"(%5) : (index) -> i64
    %7 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xf32, #gpu.address_space<workgroup>>
    %8 = "builtin.unrealized_conversion_cast"(%7) : (memref<64x64xf32, #gpu.address_space<workgroup>>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %9 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<7>
    %10 = "llvm.mlir.constant"() <{value = 72 : index}> : () -> i64
    %11 = "llvm.mul"(%4, %10) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %12 = "llvm.add"(%11, %2) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %13 = "llvm.getelementptr"(%9, %12) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<7>, i64) -> !llvm.ptr<7>
    %14 = "llvm.extractvalue"(%8) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<3>
    %15 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
    %16 = "llvm.mul"(%6, %15) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %17 = "llvm.add"(%16, %2) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %18 = "llvm.getelementptr"(%14, %17) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
    "rocdl.load.to.lds"(%13, %18) <{aux = 0 : i32, offset = 0 : i32, size = 16 : i32}> : (!llvm.ptr<7>, !llvm.ptr<3>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

