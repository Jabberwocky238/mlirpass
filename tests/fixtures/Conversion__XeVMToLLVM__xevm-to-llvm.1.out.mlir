module {
  llvm.func spir_funccc @_Z41intel_sub_group_2d_block_read_16b_8r16x1cPU3AS1viiiDv2_iPt(!llvm.ptr<1> {llvm.nonnull, llvm.readonly}, i32, i32, i32, vector<2xi32>, !llvm.ptr {llvm.nonnull, llvm.writeonly}) attributes {no_unwind, will_return}
  llvm.func @blockload2d(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32) -> vector<8xi16> {
    %0 = llvm.mlir.undef : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg4, %0[%1 : i32] : vector<2xi32>
    %4 = llvm.insertelement %arg5, %3[%2 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(8 : i32) : i32
    %6 = llvm.alloca %5 x i16 : (i32) -> !llvm.ptr
    llvm.call spir_funccc @_Z41intel_sub_group_2d_block_read_16b_8r16x1cPU3AS1viiiDv2_iPt(%arg0, %arg1, %arg2, %arg3, %4, %6) {function_type = !llvm.func<void (ptr<1>, i32, i32, i32, vector<2xi32>, ptr)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z41intel_sub_group_2d_block_read_16b_8r16x1cPU3AS1viiiDv2_iPt", visibility_ = 0 : i64, will_return} : (!llvm.ptr<1> {llvm.nonnull, llvm.readonly}, i32, i32, i32, vector<2xi32>, !llvm.ptr {llvm.nonnull, llvm.writeonly}) -> ()
    %7 = llvm.load %6 : !llvm.ptr -> vector<8xi16>
    llvm.return %7 : vector<8xi16>
  }
}

// -----
module {
  llvm.func spir_funccc @_Z41intel_sub_group_2d_block_read_16b_8r16x1cPU3AS1viiiDv2_iPt(!llvm.ptr<1> {llvm.nonnull, llvm.readonly}, i32, i32, i32, vector<2xi32>, !llvm.ptr {llvm.nonnull, llvm.writeonly}) attributes {no_unwind, will_return}
  llvm.func @blockload2d_cache_control(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32) -> vector<8xi16> {
    %0 = llvm.mlir.undef : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg4, %0[%1 : i32] : vector<2xi32>
    %4 = llvm.insertelement %arg5, %3[%2 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(8 : i32) : i32
    %6 = llvm.alloca %5 x i16 : (i32) -> !llvm.ptr
    llvm.call spir_funccc @_Z41intel_sub_group_2d_block_read_16b_8r16x1cPU3AS1viiiDv2_iPt(%arg0, %arg1, %arg2, %arg3, %4, %6) {function_type = !llvm.func<void (ptr<1>, i32, i32, i32, vector<2xi32>, ptr)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z41intel_sub_group_2d_block_read_16b_8r16x1cPU3AS1viiiDv2_iPt", visibility_ = 0 : i64, will_return, xevm.DecorationCacheControl = [[6442 : i32, 0 : i32, 1 : i32, 0 : i32], [6442 : i32, 1 : i32, 1 : i32, 0 : i32]]} : (!llvm.ptr<1> {llvm.nonnull, llvm.readonly}, i32, i32, i32, vector<2xi32>, !llvm.ptr {llvm.nonnull, llvm.writeonly}) -> ()
    %7 = llvm.load %6 : !llvm.ptr -> vector<8xi16>
    llvm.return %7 : vector<8xi16>
  }
}

// -----
module {
  llvm.func spir_funccc @_Z41intel_sub_group_2d_block_read_16b_8r16x2cPU3AS1viiiDv2_iPt(!llvm.ptr<1> {llvm.nonnull, llvm.readonly}, i32, i32, i32, vector<2xi32>, !llvm.ptr {llvm.nonnull, llvm.writeonly}) attributes {no_unwind, will_return}
  llvm.func @blockload2d_v_blocks(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32) -> vector<16xi16> {
    %0 = llvm.mlir.undef : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg4, %0[%1 : i32] : vector<2xi32>
    %4 = llvm.insertelement %arg5, %3[%2 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(16 : i32) : i32
    %6 = llvm.alloca %5 x i16 : (i32) -> !llvm.ptr
    llvm.call spir_funccc @_Z41intel_sub_group_2d_block_read_16b_8r16x2cPU3AS1viiiDv2_iPt(%arg0, %arg1, %arg2, %arg3, %4, %6) {function_type = !llvm.func<void (ptr<1>, i32, i32, i32, vector<2xi32>, ptr)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z41intel_sub_group_2d_block_read_16b_8r16x2cPU3AS1viiiDv2_iPt", visibility_ = 0 : i64, will_return} : (!llvm.ptr<1> {llvm.nonnull, llvm.readonly}, i32, i32, i32, vector<2xi32>, !llvm.ptr {llvm.nonnull, llvm.writeonly}) -> ()
    %7 = llvm.load %6 : !llvm.ptr -> vector<16xi16>
    llvm.return %7 : vector<16xi16>
  }
}

// -----
module {
  llvm.func spir_funccc @_Z52intel_sub_group_2d_block_read_transform_16b_16r16x1cPU3AS1viiiDv2_iPj(!llvm.ptr<1> {llvm.nonnull, llvm.readonly}, i32, i32, i32, vector<2xi32>, !llvm.ptr {llvm.nonnull, llvm.writeonly}) attributes {no_unwind, will_return}
  llvm.func @blockload2d_pack_register(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32) -> vector<8xi32> {
    %0 = llvm.mlir.undef : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg4, %0[%1 : i32] : vector<2xi32>
    %4 = llvm.insertelement %arg5, %3[%2 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(8 : i32) : i32
    %6 = llvm.alloca %5 x i32 : (i32) -> !llvm.ptr
    llvm.call spir_funccc @_Z52intel_sub_group_2d_block_read_transform_16b_16r16x1cPU3AS1viiiDv2_iPj(%arg0, %arg1, %arg2, %arg3, %4, %6) {function_type = !llvm.func<void (ptr<1>, i32, i32, i32, vector<2xi32>, ptr)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z52intel_sub_group_2d_block_read_transform_16b_16r16x1cPU3AS1viiiDv2_iPj", visibility_ = 0 : i64, will_return} : (!llvm.ptr<1> {llvm.nonnull, llvm.readonly}, i32, i32, i32, vector<2xi32>, !llvm.ptr {llvm.nonnull, llvm.writeonly}) -> ()
    %7 = llvm.load %6 : !llvm.ptr -> vector<8xi32>
    llvm.return %7 : vector<8xi32>
  }
}

// -----
module {
  llvm.func spir_funccc @_Z51intel_sub_group_2d_block_read_transpose_32b_16r8x1cPU3AS1viiiDv2_iPj(!llvm.ptr<1> {llvm.nonnull, llvm.readonly}, i32, i32, i32, vector<2xi32>, !llvm.ptr {llvm.nonnull, llvm.writeonly}) attributes {no_unwind, will_return}
  llvm.func @blockload2d_transpose(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32) -> vector<8xi32> {
    %0 = llvm.mlir.undef : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg4, %0[%1 : i32] : vector<2xi32>
    %4 = llvm.insertelement %arg5, %3[%2 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(8 : i32) : i32
    %6 = llvm.alloca %5 x i32 : (i32) -> !llvm.ptr
    llvm.call spir_funccc @_Z51intel_sub_group_2d_block_read_transpose_32b_16r8x1cPU3AS1viiiDv2_iPj(%arg0, %arg1, %arg2, %arg3, %4, %6) {function_type = !llvm.func<void (ptr<1>, i32, i32, i32, vector<2xi32>, ptr)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z51intel_sub_group_2d_block_read_transpose_32b_16r8x1cPU3AS1viiiDv2_iPj", visibility_ = 0 : i64, will_return} : (!llvm.ptr<1> {llvm.nonnull, llvm.readonly}, i32, i32, i32, vector<2xi32>, !llvm.ptr {llvm.nonnull, llvm.writeonly}) -> ()
    %7 = llvm.load %6 : !llvm.ptr -> vector<8xi32>
    llvm.return %7 : vector<8xi32>
  }
}

// -----
module {
  llvm.func spir_funccc @_Z42intel_sub_group_2d_block_write_32b_8r16x1cPU3AS1viiiDv2_iPj(!llvm.ptr<1> {llvm.nonnull, llvm.writeonly}, i32, i32, i32, vector<2xi32>, !llvm.ptr {llvm.nonnull, llvm.readonly}) attributes {no_unwind, will_return}
  llvm.func @blockstore2d(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: vector<8xi32>) {
    %0 = llvm.mlir.undef : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg4, %0[%1 : i32] : vector<2xi32>
    %4 = llvm.insertelement %arg5, %3[%2 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(8 : i32) : i32
    %6 = llvm.alloca %5 x i32 : (i32) -> !llvm.ptr
    llvm.store %arg6, %6 : vector<8xi32>, !llvm.ptr
    llvm.call spir_funccc @_Z42intel_sub_group_2d_block_write_32b_8r16x1cPU3AS1viiiDv2_iPj(%arg0, %arg1, %arg2, %arg3, %4, %6) {function_type = !llvm.func<void (ptr<1>, i32, i32, i32, vector<2xi32>, ptr)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z42intel_sub_group_2d_block_write_32b_8r16x1cPU3AS1viiiDv2_iPj", visibility_ = 0 : i64, will_return} : (!llvm.ptr<1> {llvm.nonnull, llvm.writeonly}, i32, i32, i32, vector<2xi32>, !llvm.ptr {llvm.nonnull, llvm.readonly}) -> ()
    llvm.return
  }
}

// -----
module {
  llvm.func spir_funccc @_Z42intel_sub_group_2d_block_write_32b_8r16x1cPU3AS1viiiDv2_iPj(!llvm.ptr<1> {llvm.nonnull, llvm.writeonly}, i32, i32, i32, vector<2xi32>, !llvm.ptr {llvm.nonnull, llvm.readonly}) attributes {no_unwind, will_return}
  llvm.func @blockstore2d_cache_control(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: vector<8xi32>) {
    %0 = llvm.mlir.undef : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg4, %0[%1 : i32] : vector<2xi32>
    %4 = llvm.insertelement %arg5, %3[%2 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(8 : i32) : i32
    %6 = llvm.alloca %5 x i32 : (i32) -> !llvm.ptr
    llvm.store %arg6, %6 : vector<8xi32>, !llvm.ptr
    llvm.call spir_funccc @_Z42intel_sub_group_2d_block_write_32b_8r16x1cPU3AS1viiiDv2_iPj(%arg0, %arg1, %arg2, %arg3, %4, %6) {function_type = !llvm.func<void (ptr<1>, i32, i32, i32, vector<2xi32>, ptr)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z42intel_sub_group_2d_block_write_32b_8r16x1cPU3AS1viiiDv2_iPj", visibility_ = 0 : i64, will_return, xevm.DecorationCacheControl = [[6443 : i32, 0 : i32, 2 : i32, 0 : i32], [6443 : i32, 1 : i32, 2 : i32, 0 : i32]]} : (!llvm.ptr<1> {llvm.nonnull, llvm.writeonly}, i32, i32, i32, vector<2xi32>, !llvm.ptr {llvm.nonnull, llvm.readonly}) -> ()
    llvm.return
  }
}

// -----
module {
  llvm.func spir_funccc @_Z44intel_sub_group_2d_block_prefetch_8b_8r32x1cPU3AS1viiiDv2_i(!llvm.ptr<1> {llvm.nonnull}, i32, i32, i32, vector<2xi32>) attributes {memory_effects = #llvm.memory_effects<other = none, argMem = read, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind}
  llvm.func @blockprefetch2d(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32) {
    %0 = llvm.mlir.undef : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg4, %0[%1 : i32] : vector<2xi32>
    %4 = llvm.insertelement %arg5, %3[%2 : i32] : vector<2xi32>
    llvm.call spir_funccc @_Z44intel_sub_group_2d_block_prefetch_8b_8r32x1cPU3AS1viiiDv2_i(%arg0, %arg1, %arg2, %arg3, %4) {function_type = !llvm.func<void (ptr<1>, i32, i32, i32, vector<2xi32>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = read, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z44intel_sub_group_2d_block_prefetch_8b_8r32x1cPU3AS1viiiDv2_i", visibility_ = 0 : i64, xevm.DecorationCacheControl = [[6442 : i32, 0 : i32, 1 : i32, 0 : i32], [6442 : i32, 1 : i32, 1 : i32, 0 : i32]]} : (!llvm.ptr<1> {llvm.nonnull}, i32, i32, i32, vector<2xi32>) -> ()
    llvm.return
  }
}

// -----
module {
  llvm.func spir_funccc @_Z38intel_sub_group_f16_f16_matrix_mad_k16Dv8_sDv8_iDv8_f(vector<8xi16>, vector<8xi32>, vector<8xf32>) -> vector<8xf32> attributes {convergent, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return}
  llvm.func @mma(%arg0: vector<8xf32>, %arg1: vector<8xi16>, %arg2: vector<8xi32>) -> vector<8xf32> {
    %0 = llvm.call spir_funccc @_Z38intel_sub_group_f16_f16_matrix_mad_k16Dv8_sDv8_iDv8_f(%arg1, %arg2, %arg0) {convergent, function_type = !llvm.func<vector<8xf32> (vector<8xi16>, vector<8xi32>, vector<8xf32>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z38intel_sub_group_f16_f16_matrix_mad_k16Dv8_sDv8_iDv8_f", visibility_ = 0 : i64, will_return} : (vector<8xi16>, vector<8xi32>, vector<8xf32>) -> vector<8xf32>
    llvm.return %0 : vector<8xf32>
  }
}

// -----
module {
  llvm.func spir_funccc @_Z22atomic_work_item_fenceiii(i32, i32, i32) attributes {no_unwind}
  llvm.func @memfence() {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    llvm.call spir_funccc @_Z22atomic_work_item_fenceiii(%2, %0, %1) {function_type = !llvm.func<void (i32, i32, i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z22atomic_work_item_fenceiii", visibility_ = 0 : i64} : (i32, i32, i32) -> ()
    llvm.return
  }
}

// -----
module {
  llvm.func spir_funccc @_Z8prefetchPU3AS1Kcm(!llvm.ptr<1>, i64) attributes {memory_effects = #llvm.memory_effects<other = none, argMem = read, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind}
  llvm.func @prefetch(%arg0: !llvm.ptr<1>) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    llvm.call spir_funccc @_Z8prefetchPU3AS1Kcm(%arg0, %0) {function_type = !llvm.func<void (ptr<1>, i64)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = read, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z8prefetchPU3AS1Kcm", visibility_ = 0 : i64, xevm.DecorationCacheControl = [[6442 : i32, 0 : i32, 1 : i32, 0 : i32], [6442 : i32, 1 : i32, 1 : i32, 0 : i32]]} : (!llvm.ptr<1>, i64) -> ()
    llvm.return
  }
}

// -----
module {
  llvm.func @llvm.load(%arg0: !llvm.ptr<1>) -> i32 {
    %0 = llvm.load %arg0 {xevm.DecorationCacheControl = [[6442 : i32, 0 : i32, 1 : i32, 0 : i32], [6442 : i32, 1 : i32, 1 : i32, 0 : i32]]} : !llvm.ptr<1> -> i32
    llvm.return %0 : i32
  }
}

// -----
module {
  llvm.func @llvm.store(%arg0: !llvm.ptr<1>, %arg1: i32) {
    llvm.store %arg1, %arg0 {xevm.DecorationCacheControl = [[6443 : i32, 0 : i32, 2 : i32, 0 : i32], [6443 : i32, 1 : i32, 2 : i32, 0 : i32]]} : i32, !llvm.ptr<1>
    llvm.return
  }
}

// -----
module {
  llvm.func spir_funccc @_Z30intel_sub_group_block_read_us8PU3AS1t(!llvm.ptr<1>) -> vector<8xi16> attributes {no_unwind, will_return}
  llvm.func @blockload_as1(%arg0: !llvm.ptr<1>) -> vector<8xi16> {
    %0 = llvm.call spir_funccc @_Z30intel_sub_group_block_read_us8PU3AS1t(%arg0) {function_type = !llvm.func<vector<8xi16> (ptr<1>)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z30intel_sub_group_block_read_us8PU3AS1t", visibility_ = 0 : i64, will_return, xevm.DecorationCacheControl = [[6442 : i32, 0 : i32, 1 : i32, 0 : i32], [6442 : i32, 1 : i32, 1 : i32, 0 : i32]]} : (!llvm.ptr<1>) -> vector<8xi16>
    llvm.return %0 : vector<8xi16>
  }
}

// -----
module {
  llvm.func spir_funccc @_Z31intel_sub_group_block_read_uc16PU3AS3h(!llvm.ptr<3>) -> vector<16xi8> attributes {no_unwind, will_return}
  llvm.func @blockload_as3(%arg0: !llvm.ptr<3>) -> vector<16xi8> {
    %0 = llvm.call spir_funccc @_Z31intel_sub_group_block_read_uc16PU3AS3h(%arg0) {function_type = !llvm.func<vector<16xi8> (ptr<3>)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z31intel_sub_group_block_read_uc16PU3AS3h", visibility_ = 0 : i64, will_return, xevm.DecorationCacheControl = [[6442 : i32, 0 : i32, 1 : i32, 0 : i32], [6442 : i32, 1 : i32, 1 : i32, 0 : i32]]} : (!llvm.ptr<3>) -> vector<16xi8>
    llvm.return %0 : vector<16xi8>
  }
}

// -----
module {
  llvm.func spir_funccc @_Z29intel_sub_group_block_read_ucPU3AS3h(!llvm.ptr<3>) -> i8 attributes {no_unwind, will_return}
  llvm.func @blockload_scalar(%arg0: !llvm.ptr<3>) -> i8 {
    %0 = llvm.call spir_funccc @_Z29intel_sub_group_block_read_ucPU3AS3h(%arg0) {function_type = !llvm.func<i8 (ptr<3>)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z29intel_sub_group_block_read_ucPU3AS3h", visibility_ = 0 : i64, will_return, xevm.DecorationCacheControl = [[6442 : i32, 0 : i32, 1 : i32, 0 : i32], [6442 : i32, 1 : i32, 1 : i32, 0 : i32]]} : (!llvm.ptr<3>) -> i8
    llvm.return %0 : i8
  }
}

// -----
module {
  llvm.func spir_funccc @_Z31intel_sub_group_block_write_ui8PU3AS1jDv8_j(!llvm.ptr<1>, vector<8xi32>) attributes {no_unwind, will_return}
  llvm.func @blockstore_as1(%arg0: !llvm.ptr<1>, %arg1: vector<8xi32>) {
    llvm.call spir_funccc @_Z31intel_sub_group_block_write_ui8PU3AS1jDv8_j(%arg0, %arg1) {function_type = !llvm.func<void (ptr<1>, vector<8xi32>)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z31intel_sub_group_block_write_ui8PU3AS1jDv8_j", visibility_ = 0 : i64, will_return, xevm.DecorationCacheControl = [[6443 : i32, 0 : i32, 2 : i32, 0 : i32], [6443 : i32, 1 : i32, 2 : i32, 0 : i32]]} : (!llvm.ptr<1>, vector<8xi32>) -> ()
    llvm.return
  }
}

// -----
module {
  llvm.func spir_funccc @_Z31intel_sub_group_block_write_ul2PU3AS3mDv2_m(!llvm.ptr<3>, vector<2xi64>) attributes {no_unwind, will_return}
  llvm.func @blockstore_as3(%arg0: !llvm.ptr<3>, %arg1: vector<2xi64>) {
    llvm.call spir_funccc @_Z31intel_sub_group_block_write_ul2PU3AS3mDv2_m(%arg0, %arg1) {function_type = !llvm.func<void (ptr<3>, vector<2xi64>)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z31intel_sub_group_block_write_ul2PU3AS3mDv2_m", visibility_ = 0 : i64, will_return, xevm.DecorationCacheControl = [[6443 : i32, 0 : i32, 2 : i32, 0 : i32], [6443 : i32, 1 : i32, 2 : i32, 0 : i32]]} : (!llvm.ptr<3>, vector<2xi64>) -> ()
    llvm.return
  }
}

// -----
module {
  llvm.func spir_funccc @_Z30intel_sub_group_block_write_ulPU3AS3mm(!llvm.ptr<3>, i64) attributes {no_unwind, will_return}
  llvm.func @blockstore_scalar(%arg0: !llvm.ptr<3>, %arg1: i64) {
    llvm.call spir_funccc @_Z30intel_sub_group_block_write_ulPU3AS3mm(%arg0, %arg1) {function_type = !llvm.func<void (ptr<3>, i64)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z30intel_sub_group_block_write_ulPU3AS3mm", visibility_ = 0 : i64, will_return, xevm.DecorationCacheControl = [[6443 : i32, 0 : i32, 2 : i32, 0 : i32], [6443 : i32, 1 : i32, 2 : i32, 0 : i32]]} : (!llvm.ptr<3>, i64) -> ()
    llvm.return
  }
}

// -----
module {
  llvm.func spir_funccc @_Z12get_local_idj(i32) -> i32 attributes {no_unwind, will_return}
  llvm.func @local_id.x() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call spir_funccc @_Z12get_local_idj(%0) {function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z12get_local_idj", visibility_ = 0 : i64, will_return} : (i32) -> i32
    llvm.return %1 : i32
  }
}

// -----
module {
  llvm.func spir_funccc @_Z12get_local_idj(i32) -> i32 attributes {no_unwind, will_return}
  llvm.func @local_id.y() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.call spir_funccc @_Z12get_local_idj(%0) {function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z12get_local_idj", visibility_ = 0 : i64, will_return} : (i32) -> i32
    llvm.return %1 : i32
  }
}

// -----
module {
  llvm.func spir_funccc @_Z12get_local_idj(i32) -> i32 attributes {no_unwind, will_return}
  llvm.func @local_id.z() -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.call spir_funccc @_Z12get_local_idj(%0) {function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z12get_local_idj", visibility_ = 0 : i64, will_return} : (i32) -> i32
    llvm.return %1 : i32
  }
}

// -----
module {
  llvm.func spir_funccc @_Z14get_local_sizej(i32) -> i32 attributes {no_unwind, will_return}
  llvm.func @local_size.x() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call spir_funccc @_Z14get_local_sizej(%0) {function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z14get_local_sizej", visibility_ = 0 : i64, will_return} : (i32) -> i32
    llvm.return %1 : i32
  }
}

// -----
module {
  llvm.func spir_funccc @_Z14get_local_sizej(i32) -> i32 attributes {no_unwind, will_return}
  llvm.func @local_size.y() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.call spir_funccc @_Z14get_local_sizej(%0) {function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z14get_local_sizej", visibility_ = 0 : i64, will_return} : (i32) -> i32
    llvm.return %1 : i32
  }
}

// -----
module {
  llvm.func spir_funccc @_Z14get_local_sizej(i32) -> i32 attributes {no_unwind, will_return}
  llvm.func @local_size.z() -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.call spir_funccc @_Z14get_local_sizej(%0) {function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z14get_local_sizej", visibility_ = 0 : i64, will_return} : (i32) -> i32
    llvm.return %1 : i32
  }
}

// -----
module {
  llvm.func spir_funccc @_Z12get_group_idj(i32) -> i32 attributes {no_unwind, will_return}
  llvm.func @group_id.x() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call spir_funccc @_Z12get_group_idj(%0) {function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z12get_group_idj", visibility_ = 0 : i64, will_return} : (i32) -> i32
    llvm.return %1 : i32
  }
}

// -----
module {
  llvm.func spir_funccc @_Z12get_group_idj(i32) -> i32 attributes {no_unwind, will_return}
  llvm.func @group_id.y() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.call spir_funccc @_Z12get_group_idj(%0) {function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z12get_group_idj", visibility_ = 0 : i64, will_return} : (i32) -> i32
    llvm.return %1 : i32
  }
}

// -----
module {
  llvm.func spir_funccc @_Z12get_group_idj(i32) -> i32 attributes {no_unwind, will_return}
  llvm.func @group_id.z() -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.call spir_funccc @_Z12get_group_idj(%0) {function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z12get_group_idj", visibility_ = 0 : i64, will_return} : (i32) -> i32
    llvm.return %1 : i32
  }
}

// -----
module {
  llvm.func spir_funccc @_Z14get_num_groupsj(i32) -> i32 attributes {no_unwind, will_return}
  llvm.func @group_count.x() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call spir_funccc @_Z14get_num_groupsj(%0) {function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z14get_num_groupsj", visibility_ = 0 : i64, will_return} : (i32) -> i32
    llvm.return %1 : i32
  }
}

// -----
module {
  llvm.func spir_funccc @_Z14get_num_groupsj(i32) -> i32 attributes {no_unwind, will_return}
  llvm.func @group_count.y() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.call spir_funccc @_Z14get_num_groupsj(%0) {function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z14get_num_groupsj", visibility_ = 0 : i64, will_return} : (i32) -> i32
    llvm.return %1 : i32
  }
}

// -----
module {
  llvm.func spir_funccc @_Z14get_num_groupsj(i32) -> i32 attributes {no_unwind, will_return}
  llvm.func @group_count.z() -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.call spir_funccc @_Z14get_num_groupsj(%0) {function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z14get_num_groupsj", visibility_ = 0 : i64, will_return} : (i32) -> i32
    llvm.return %1 : i32
  }
}

// -----
module {
  llvm.func spir_funccc @_Z22get_sub_group_local_id() -> i32 attributes {no_unwind, will_return}
  llvm.func @lane_id() -> i32 {
    %0 = llvm.call spir_funccc @_Z22get_sub_group_local_id() {function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z22get_sub_group_local_id", visibility_ = 0 : i64, will_return} : () -> i32
    llvm.return %0 : i32
  }
}

// -----
module {
  llvm.func spir_funccc @_Z18get_sub_group_size() -> i32 attributes {no_unwind, will_return}
  llvm.func @subgroup_size() -> i32 {
    %0 = llvm.call spir_funccc @_Z18get_sub_group_size() {function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z18get_sub_group_size", visibility_ = 0 : i64, will_return} : () -> i32
    llvm.return %0 : i32
  }
}

// -----
module {
  llvm.func spir_funccc @_Z16get_sub_group_id() -> i32 attributes {no_unwind, will_return}
  llvm.func @subgroup_id() -> i32 {
    %0 = llvm.call spir_funccc @_Z16get_sub_group_id() {function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z16get_sub_group_id", visibility_ = 0 : i64, will_return} : () -> i32
    llvm.return %0 : i32
  }
}

