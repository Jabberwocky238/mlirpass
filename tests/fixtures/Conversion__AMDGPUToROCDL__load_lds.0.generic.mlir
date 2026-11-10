"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x72xf32, #gpu.address_space<global>>) -> (), sym_name = "global_load_to_rocdl_f32"}> ({
  ^bb0(%arg10: memref<128x72xf32, #gpu.address_space<global>>):
    %133 = "builtin.unrealized_conversion_cast"(%arg10) : (memref<128x72xf32, #gpu.address_space<global>>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
    %134 = "arith.constant"() <{value = 0 : index}> : () -> index
    %135 = "builtin.unrealized_conversion_cast"(%134) : (index) -> i64
    %136 = "arith.constant"() <{value = 12 : index}> : () -> index
    %137 = "builtin.unrealized_conversion_cast"(%136) : (index) -> i64
    %138 = "arith.constant"() <{value = 32 : index}> : () -> index
    %139 = "builtin.unrealized_conversion_cast"(%138) : (index) -> i64
    %140 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xf32, #gpu.address_space<workgroup>>
    %141 = "builtin.unrealized_conversion_cast"(%140) : (memref<64x64xf32, #gpu.address_space<workgroup>>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %142 = "llvm.extractvalue"(%133) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<1>
    %143 = "llvm.mlir.constant"() <{value = 72 : index}> : () -> i64
    %144 = "llvm.mul"(%137, %143) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %145 = "llvm.add"(%144, %135) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %146 = "llvm.getelementptr"(%142, %145) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>
    %147 = "llvm.extractvalue"(%141) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<3>
    %148 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
    %149 = "llvm.mul"(%139, %148) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %150 = "llvm.add"(%149, %135) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %151 = "llvm.getelementptr"(%147, %150) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
    "rocdl.load.to.lds"(%146, %151) <{aux = 0 : i32, offset = 0 : i32, size = 4 : i32}> : (!llvm.ptr<1>, !llvm.ptr<3>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<128x72xf32>) -> (), sym_name = "global_load_to_rocdl_wg_mem"}> ({
  ^bb0(%arg9: memref<128x72xf32>):
    %114 = "builtin.unrealized_conversion_cast"(%arg9) : (memref<128x72xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %115 = "arith.constant"() <{value = 0 : index}> : () -> index
    %116 = "builtin.unrealized_conversion_cast"(%115) : (index) -> i64
    %117 = "arith.constant"() <{value = 12 : index}> : () -> index
    %118 = "builtin.unrealized_conversion_cast"(%117) : (index) -> i64
    %119 = "arith.constant"() <{value = 32 : index}> : () -> index
    %120 = "builtin.unrealized_conversion_cast"(%119) : (index) -> i64
    %121 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xf32, #gpu.address_space<workgroup>>
    %122 = "builtin.unrealized_conversion_cast"(%121) : (memref<64x64xf32, #gpu.address_space<workgroup>>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %123 = "llvm.extractvalue"(%114) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %124 = "llvm.mlir.constant"() <{value = 72 : index}> : () -> i64
    %125 = "llvm.mul"(%118, %124) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %126 = "llvm.add"(%125, %116) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %127 = "llvm.getelementptr"(%123, %126) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %128 = "llvm.extractvalue"(%122) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<3>
    %129 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
    %130 = "llvm.mul"(%120, %129) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %131 = "llvm.add"(%130, %116) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %132 = "llvm.getelementptr"(%128, %131) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
    "rocdl.load.to.lds"(%127, %132) <{aux = 0 : i32, offset = 0 : i32, size = 4 : i32}> : (!llvm.ptr, !llvm.ptr<3>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32>) -> (), sym_name = "global_load_to_rocdl_0d"}> ({
  ^bb0(%arg8: memref<f32>):
    %109 = "builtin.unrealized_conversion_cast"(%arg8) : (memref<f32>) -> !llvm.struct<(ptr, ptr, i64)>
    %110 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32, #gpu.address_space<workgroup>>
    %111 = "builtin.unrealized_conversion_cast"(%110) : (memref<f32, #gpu.address_space<workgroup>>) -> !llvm.struct<(ptr<3>, ptr<3>, i64)>
    %112 = "llvm.extractvalue"(%109) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
    %113 = "llvm.extractvalue"(%111) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64)>) -> !llvm.ptr<3>
    "rocdl.load.to.lds"(%112, %113) <{aux = 0 : i32, offset = 0 : i32, size = 4 : i32}> : (!llvm.ptr, !llvm.ptr<3>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<128x72xi8, #gpu.address_space<global>>) -> (), sym_name = "global_load_to_rocdl_i8"}> ({
  ^bb0(%arg7: memref<128x72xi8, #gpu.address_space<global>>):
    %90 = "builtin.unrealized_conversion_cast"(%arg7) : (memref<128x72xi8, #gpu.address_space<global>>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
    %91 = "arith.constant"() <{value = 0 : index}> : () -> index
    %92 = "builtin.unrealized_conversion_cast"(%91) : (index) -> i64
    %93 = "arith.constant"() <{value = 12 : index}> : () -> index
    %94 = "builtin.unrealized_conversion_cast"(%93) : (index) -> i64
    %95 = "arith.constant"() <{value = 32 : index}> : () -> index
    %96 = "builtin.unrealized_conversion_cast"(%95) : (index) -> i64
    %97 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xi8, #gpu.address_space<workgroup>>
    %98 = "builtin.unrealized_conversion_cast"(%97) : (memref<64x64xi8, #gpu.address_space<workgroup>>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %99 = "llvm.extractvalue"(%90) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<1>
    %100 = "llvm.mlir.constant"() <{value = 72 : index}> : () -> i64
    %101 = "llvm.mul"(%94, %100) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %102 = "llvm.add"(%101, %92) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %103 = "llvm.getelementptr"(%99, %102) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>
    %104 = "llvm.extractvalue"(%98) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<3>
    %105 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
    %106 = "llvm.mul"(%96, %105) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %107 = "llvm.add"(%106, %92) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %108 = "llvm.getelementptr"(%104, %107) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
    "rocdl.load.to.lds"(%103, %108) <{aux = 0 : i32, offset = 0 : i32, size = 1 : i32}> : (!llvm.ptr<1>, !llvm.ptr<3>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<128x72xi16, #gpu.address_space<global>>) -> (), sym_name = "global_load_to_rocdl_vec"}> ({
  ^bb0(%arg6: memref<128x72xi16, #gpu.address_space<global>>):
    %71 = "builtin.unrealized_conversion_cast"(%arg6) : (memref<128x72xi16, #gpu.address_space<global>>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
    %72 = "arith.constant"() <{value = 0 : index}> : () -> index
    %73 = "builtin.unrealized_conversion_cast"(%72) : (index) -> i64
    %74 = "arith.constant"() <{value = 12 : index}> : () -> index
    %75 = "builtin.unrealized_conversion_cast"(%74) : (index) -> i64
    %76 = "arith.constant"() <{value = 32 : index}> : () -> index
    %77 = "builtin.unrealized_conversion_cast"(%76) : (index) -> i64
    %78 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x128xi16, #gpu.address_space<workgroup>>
    %79 = "builtin.unrealized_conversion_cast"(%78) : (memref<64x128xi16, #gpu.address_space<workgroup>>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %80 = "llvm.extractvalue"(%71) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<1>
    %81 = "llvm.mlir.constant"() <{value = 72 : index}> : () -> i64
    %82 = "llvm.mul"(%75, %81) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %83 = "llvm.add"(%82, %73) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %84 = "llvm.getelementptr"(%80, %83) <{elem_type = i16, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>
    %85 = "llvm.extractvalue"(%79) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<3>
    %86 = "llvm.mlir.constant"() <{value = 128 : index}> : () -> i64
    %87 = "llvm.mul"(%77, %86) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %88 = "llvm.add"(%87, %73) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %89 = "llvm.getelementptr"(%85, %88) <{elem_type = i16, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
    "rocdl.load.to.lds"(%84, %89) <{aux = 0 : i32, offset = 0 : i32, size = 4 : i32}> : (!llvm.ptr<1>, !llvm.ptr<3>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<512xi32, #gpu.address_space<global>>, index, index) -> (), sym_name = "global_load_to_rocdl_dynamic_indices"}> ({
  ^bb0(%arg3: memref<512xi32, #gpu.address_space<global>>, %arg4: index, %arg5: index):
    %57 = "builtin.unrealized_conversion_cast"(%arg5) : (index) -> i64
    %58 = "builtin.unrealized_conversion_cast"(%arg4) : (index) -> i64
    %59 = "builtin.unrealized_conversion_cast"(%arg3) : (memref<512xi32, #gpu.address_space<global>>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %60 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x64xi32, #gpu.address_space<workgroup>>
    %61 = "builtin.unrealized_conversion_cast"(%60) : (memref<4x64xi32, #gpu.address_space<workgroup>>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %62 = "arith.constant"() <{value = 0 : index}> : () -> index
    %63 = "builtin.unrealized_conversion_cast"(%62) : (index) -> i64
    %64 = "llvm.extractvalue"(%59) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<1>
    %65 = "llvm.getelementptr"(%64, %58) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>
    %66 = "llvm.extractvalue"(%61) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<3>
    %67 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
    %68 = "llvm.mul"(%57, %67) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %69 = "llvm.add"(%68, %63) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %70 = "llvm.getelementptr"(%66, %69) <{elem_type = i32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
    "rocdl.load.to.lds"(%65, %70) <{aux = 0 : i32, offset = 0 : i32, size = 4 : i32}> : (!llvm.ptr<1>, !llvm.ptr<3>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<128x72xf32, #amdgpu.address_space<fat_raw_buffer>>) -> (), sym_name = "fat_buffer_load_to_rocdl_f32"}> ({
  ^bb0(%arg2: memref<128x72xf32, #amdgpu.address_space<fat_raw_buffer>>):
    %38 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<128x72xf32, #amdgpu.address_space<fat_raw_buffer>>) -> !llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>
    %39 = "arith.constant"() <{value = 0 : index}> : () -> index
    %40 = "builtin.unrealized_conversion_cast"(%39) : (index) -> i64
    %41 = "arith.constant"() <{value = 12 : index}> : () -> index
    %42 = "builtin.unrealized_conversion_cast"(%41) : (index) -> i64
    %43 = "arith.constant"() <{value = 32 : index}> : () -> index
    %44 = "builtin.unrealized_conversion_cast"(%43) : (index) -> i64
    %45 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xf32, #gpu.address_space<workgroup>>
    %46 = "builtin.unrealized_conversion_cast"(%45) : (memref<64x64xf32, #gpu.address_space<workgroup>>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %47 = "llvm.extractvalue"(%38) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<7>, ptr<7>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<7>
    %48 = "llvm.mlir.constant"() <{value = 72 : index}> : () -> i64
    %49 = "llvm.mul"(%42, %48) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %50 = "llvm.add"(%49, %40) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %51 = "llvm.getelementptr"(%47, %50) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<7>, i64) -> !llvm.ptr<7>
    %52 = "llvm.extractvalue"(%46) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<3>
    %53 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
    %54 = "llvm.mul"(%44, %53) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %55 = "llvm.add"(%54, %40) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %56 = "llvm.getelementptr"(%52, %55) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
    "rocdl.load.to.lds"(%51, %56) <{aux = 0 : i32, offset = 0 : i32, size = 4 : i32}> : (!llvm.ptr<7>, !llvm.ptr<3>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<128x72xf32, #gpu.address_space<global>>) -> (), sym_name = "global_load_to_rocdl_async_f32"}> ({
  ^bb0(%arg1: memref<128x72xf32, #gpu.address_space<global>>):
    %19 = "builtin.unrealized_conversion_cast"(%arg1) : (memref<128x72xf32, #gpu.address_space<global>>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
    %20 = "arith.constant"() <{value = 0 : index}> : () -> index
    %21 = "builtin.unrealized_conversion_cast"(%20) : (index) -> i64
    %22 = "arith.constant"() <{value = 12 : index}> : () -> index
    %23 = "builtin.unrealized_conversion_cast"(%22) : (index) -> i64
    %24 = "arith.constant"() <{value = 32 : index}> : () -> index
    %25 = "builtin.unrealized_conversion_cast"(%24) : (index) -> i64
    %26 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xf32, #gpu.address_space<workgroup>>
    %27 = "builtin.unrealized_conversion_cast"(%26) : (memref<64x64xf32, #gpu.address_space<workgroup>>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %28 = "llvm.extractvalue"(%19) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<1>
    %29 = "llvm.mlir.constant"() <{value = 72 : index}> : () -> i64
    %30 = "llvm.mul"(%23, %29) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %31 = "llvm.add"(%30, %21) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %32 = "llvm.getelementptr"(%28, %31) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>
    %33 = "llvm.extractvalue"(%27) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<3>
    %34 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
    %35 = "llvm.mul"(%25, %34) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %36 = "llvm.add"(%35, %21) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %37 = "llvm.getelementptr"(%33, %36) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
    "rocdl.load.async.to.lds"(%32, %37) <{aux = 0 : i32, offset = 0 : i32, size = 4 : i32}> : (!llvm.ptr<1>, !llvm.ptr<3>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<128x72xf32, #amdgpu.address_space<fat_raw_buffer>>) -> (), sym_name = "global_load_to_rocdl_async_f32_fat_raw_buffer"}> ({
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
    "rocdl.load.async.to.lds"(%13, %18) <{aux = 0 : i32, offset = 0 : i32, size = 4 : i32}> : (!llvm.ptr<7>, !llvm.ptr<3>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

