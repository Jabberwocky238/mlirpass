"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x72xf32, 1>) -> (), sym_name = "global_load_to_rocdl_f32"}> ({
  ^bb0(%arg8: memref<128x72xf32, 1>):
    %95 = "builtin.unrealized_conversion_cast"(%arg8) : (memref<128x72xf32, 1>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
    %96 = "arith.constant"() <{value = 0 : index}> : () -> index
    %97 = "builtin.unrealized_conversion_cast"(%96) : (index) -> i64
    %98 = "arith.constant"() <{value = 12 : index}> : () -> index
    %99 = "builtin.unrealized_conversion_cast"(%98) : (index) -> i64
    %100 = "arith.constant"() <{value = 32 : index}> : () -> index
    %101 = "builtin.unrealized_conversion_cast"(%100) : (index) -> i64
    %102 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xf32, 3>
    %103 = "builtin.unrealized_conversion_cast"(%102) : (memref<64x64xf32, 3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %104 = "llvm.extractvalue"(%95) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<1>
    %105 = "llvm.mlir.constant"() <{value = 72 : index}> : () -> i64
    %106 = "llvm.mul"(%99, %105) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %107 = "llvm.add"(%106, %97) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %108 = "llvm.getelementptr"(%104, %107) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>
    %109 = "llvm.extractvalue"(%103) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<3>
    %110 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
    %111 = "llvm.mul"(%101, %110) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %112 = "llvm.add"(%111, %97) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %113 = "llvm.getelementptr"(%109, %112) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
    "rocdl.load.to.lds"(%108, %113) <{aux = 0 : i32, offset = 0 : i32, size = 4 : i32}> : (!llvm.ptr<1>, !llvm.ptr<3>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<128x72xf32>) -> (), sym_name = "global_load_to_rocdl_wg_mem"}> ({
  ^bb0(%arg7: memref<128x72xf32>):
    %76 = "builtin.unrealized_conversion_cast"(%arg7) : (memref<128x72xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %77 = "arith.constant"() <{value = 0 : index}> : () -> index
    %78 = "builtin.unrealized_conversion_cast"(%77) : (index) -> i64
    %79 = "arith.constant"() <{value = 12 : index}> : () -> index
    %80 = "builtin.unrealized_conversion_cast"(%79) : (index) -> i64
    %81 = "arith.constant"() <{value = 32 : index}> : () -> index
    %82 = "builtin.unrealized_conversion_cast"(%81) : (index) -> i64
    %83 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xf32, #gpu.address_space<workgroup>>
    %84 = "builtin.unrealized_conversion_cast"(%83) : (memref<64x64xf32, #gpu.address_space<workgroup>>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %85 = "llvm.extractvalue"(%76) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %86 = "llvm.mlir.constant"() <{value = 72 : index}> : () -> i64
    %87 = "llvm.mul"(%80, %86) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %88 = "llvm.add"(%87, %78) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %89 = "llvm.getelementptr"(%85, %88) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %90 = "llvm.extractvalue"(%84) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<3>
    %91 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
    %92 = "llvm.mul"(%82, %91) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %93 = "llvm.add"(%92, %78) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %94 = "llvm.getelementptr"(%90, %93) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
    "rocdl.load.to.lds"(%89, %94) <{aux = 0 : i32, offset = 0 : i32, size = 4 : i32}> : (!llvm.ptr, !llvm.ptr<3>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32>) -> (), sym_name = "global_load_to_rocdl_0d"}> ({
  ^bb0(%arg6: memref<f32>):
    %71 = "builtin.unrealized_conversion_cast"(%arg6) : (memref<f32>) -> !llvm.struct<(ptr, ptr, i64)>
    %72 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32, #gpu.address_space<workgroup>>
    %73 = "builtin.unrealized_conversion_cast"(%72) : (memref<f32, #gpu.address_space<workgroup>>) -> !llvm.struct<(ptr<3>, ptr<3>, i64)>
    %74 = "llvm.extractvalue"(%71) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
    %75 = "llvm.extractvalue"(%73) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64)>) -> !llvm.ptr<3>
    "rocdl.load.to.lds"(%74, %75) <{aux = 0 : i32, offset = 0 : i32, size = 4 : i32}> : (!llvm.ptr, !llvm.ptr<3>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<128x72xi8, 1>) -> (), sym_name = "global_load_to_rocdl_i8"}> ({
  ^bb0(%arg5: memref<128x72xi8, 1>):
    %52 = "builtin.unrealized_conversion_cast"(%arg5) : (memref<128x72xi8, 1>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
    %53 = "arith.constant"() <{value = 0 : index}> : () -> index
    %54 = "builtin.unrealized_conversion_cast"(%53) : (index) -> i64
    %55 = "arith.constant"() <{value = 12 : index}> : () -> index
    %56 = "builtin.unrealized_conversion_cast"(%55) : (index) -> i64
    %57 = "arith.constant"() <{value = 32 : index}> : () -> index
    %58 = "builtin.unrealized_conversion_cast"(%57) : (index) -> i64
    %59 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xi8, 3>
    %60 = "builtin.unrealized_conversion_cast"(%59) : (memref<64x64xi8, 3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %61 = "llvm.extractvalue"(%52) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<1>
    %62 = "llvm.mlir.constant"() <{value = 72 : index}> : () -> i64
    %63 = "llvm.mul"(%56, %62) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %64 = "llvm.add"(%63, %54) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %65 = "llvm.getelementptr"(%61, %64) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>
    %66 = "llvm.extractvalue"(%60) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<3>
    %67 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
    %68 = "llvm.mul"(%58, %67) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %69 = "llvm.add"(%68, %54) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %70 = "llvm.getelementptr"(%66, %69) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
    "rocdl.load.to.lds"(%65, %70) <{aux = 0 : i32, offset = 0 : i32, size = 1 : i32}> : (!llvm.ptr<1>, !llvm.ptr<3>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<128x72xi16, 1>) -> (), sym_name = "global_load_to_rocdl_vec"}> ({
  ^bb0(%arg4: memref<128x72xi16, 1>):
    %33 = "builtin.unrealized_conversion_cast"(%arg4) : (memref<128x72xi16, 1>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
    %34 = "arith.constant"() <{value = 0 : index}> : () -> index
    %35 = "builtin.unrealized_conversion_cast"(%34) : (index) -> i64
    %36 = "arith.constant"() <{value = 12 : index}> : () -> index
    %37 = "builtin.unrealized_conversion_cast"(%36) : (index) -> i64
    %38 = "arith.constant"() <{value = 32 : index}> : () -> index
    %39 = "builtin.unrealized_conversion_cast"(%38) : (index) -> i64
    %40 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x128xi16, 3>
    %41 = "builtin.unrealized_conversion_cast"(%40) : (memref<64x128xi16, 3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %42 = "llvm.extractvalue"(%33) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<1>
    %43 = "llvm.mlir.constant"() <{value = 72 : index}> : () -> i64
    %44 = "llvm.mul"(%37, %43) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %45 = "llvm.add"(%44, %35) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %46 = "llvm.getelementptr"(%42, %45) <{elem_type = i16, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>
    %47 = "llvm.extractvalue"(%41) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<3>
    %48 = "llvm.mlir.constant"() <{value = 128 : index}> : () -> i64
    %49 = "llvm.mul"(%39, %48) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %50 = "llvm.add"(%49, %35) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %51 = "llvm.getelementptr"(%47, %50) <{elem_type = i16, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
    "rocdl.load.to.lds"(%46, %51) <{aux = 0 : i32, offset = 0 : i32, size = 4 : i32}> : (!llvm.ptr<1>, !llvm.ptr<3>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<512xi32, 1>, index, index) -> (), sym_name = "global_load_to_rocdl_dynamic_indices"}> ({
  ^bb0(%arg1: memref<512xi32, 1>, %arg2: index, %arg3: index):
    %19 = "builtin.unrealized_conversion_cast"(%arg3) : (index) -> i64
    %20 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %21 = "builtin.unrealized_conversion_cast"(%arg1) : (memref<512xi32, 1>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %22 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x64xi32, 3>
    %23 = "builtin.unrealized_conversion_cast"(%22) : (memref<4x64xi32, 3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %24 = "arith.constant"() <{value = 0 : index}> : () -> index
    %25 = "builtin.unrealized_conversion_cast"(%24) : (index) -> i64
    %26 = "llvm.extractvalue"(%21) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<1>
    %27 = "llvm.getelementptr"(%26, %20) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>
    %28 = "llvm.extractvalue"(%23) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<3>
    %29 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
    %30 = "llvm.mul"(%19, %29) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %31 = "llvm.add"(%30, %25) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %32 = "llvm.getelementptr"(%28, %31) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
    "rocdl.load.to.lds"(%27, %32) <{aux = 0 : i32, offset = 0 : i32, size = 4 : i32}> : (!llvm.ptr<1>, !llvm.ptr<3>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<128x72xf32, 7>) -> (), sym_name = "fat_buffer_load_to_rocdl_f32"}> ({
  ^bb0(%arg0: memref<128x72xf32, 7>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<128x72xf32, 7>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i64
    %3 = "arith.constant"() <{value = 12 : index}> : () -> index
    %4 = "builtin.unrealized_conversion_cast"(%3) : (index) -> i64
    %5 = "arith.constant"() <{value = 32 : index}> : () -> index
    %6 = "builtin.unrealized_conversion_cast"(%5) : (index) -> i64
    %7 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xf32, 3>
    %8 = "builtin.unrealized_conversion_cast"(%7) : (memref<64x64xf32, 3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
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
    "rocdl.load.to.lds"(%13, %18) <{aux = 0 : i32, offset = 0 : i32, size = 4 : i32}> : (!llvm.ptr<7>, !llvm.ptr<3>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

