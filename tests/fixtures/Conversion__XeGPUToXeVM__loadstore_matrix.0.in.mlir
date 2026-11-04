"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_kernel", targets = [#xevm.target<chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (memref<4096xi8, 3>) -> f32}> ({
    ^bb0(%arg7: memref<4096xi8, 3>):
      %28 = "xegpu.create_mem_desc"(%arg7) : (memref<4096xi8, 3>) -> !xegpu.mem_desc<32x32xf32>
      %29 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %30 = "arith.constant"() <{value = 0 : index}> : () -> index
      %31 = "xegpu.load_matrix"(%28, %30, %29) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (!xegpu.mem_desc<32x32xf32>, index, index) -> f32
      "xegpu.store_matrix"(%31, %28, %30, %29) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (f32, !xegpu.mem_desc<32x32xf32>, index, index) -> ()
      "gpu.return"(%31) : (f32) -> ()
    }) {sym_name = "load_store_matrix_plain", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (memref<1024xi8, 3>) -> f32}> ({
    ^bb0(%arg6: memref<1024xi8, 3>):
      %22 = "arith.constant"() <{value = 0 : index}> : () -> index
      %23 = "memref.view"(%arg6, %22) : (memref<1024xi8, 3>, index) -> memref<64x32xf32, 3>
      %24 = "memref.subview"(%23) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 32, 0>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<64x32xf32, 3>) -> memref<32x32xf32, strided<[32, 1], offset: 1024>, 3>
      %25 = "xegpu.create_mem_desc"(%24) : (memref<32x32xf32, strided<[32, 1], offset: 1024>, 3>) -> !xegpu.mem_desc<32x32xf32>
      %26 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %27 = "xegpu.load_matrix"(%25, %22, %26) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (!xegpu.mem_desc<32x32xf32>, index, index) -> f32
      "xegpu.store_matrix"(%27, %25, %22, %26) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (f32, !xegpu.mem_desc<32x32xf32>, index, index) -> ()
      "gpu.return"(%27) : (f32) -> ()
    }) {sym_name = "load_store_matrix_plain_2d_input", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (memref<4096xi8, 3>) -> f16}> ({
    ^bb0(%arg5: memref<4096xi8, 3>):
      %18 = "xegpu.create_mem_desc"(%arg5) : (memref<4096xi8, 3>) -> !xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16], stride = [1, 32]>>
      %19 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %20 = "arith.constant"() <{value = 13 : index}> : () -> index
      %21 = "xegpu.load_matrix"(%18, %20, %19) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (!xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16], stride = [1, 32]>>, index, index) -> f16
      "xegpu.store_matrix"(%21, %18, %20, %19) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (f16, !xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16], stride = [1, 32]>>, index, index) -> ()
      "gpu.return"(%21) : (f16) -> ()
    }) {sym_name = "load_store_matrix_blocked_strided", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (memref<4096xi8, 3>) -> f16}> ({
    ^bb0(%arg4: memref<4096xi8, 3>):
      %14 = "xegpu.create_mem_desc"(%arg4) : (memref<4096xi8, 3>) -> !xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16]>>
      %15 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %16 = "arith.constant"() <{value = 19 : index}> : () -> index
      %17 = "xegpu.load_matrix"(%14, %16, %15) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (!xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16]>>, index, index) -> f16
      "xegpu.store_matrix"(%17, %14, %16, %15) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (f16, !xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16]>>, index, index) -> ()
      "gpu.return"(%17) : (f16) -> ()
    }) {sym_name = "load_store_matrix_blocked_nostride", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (memref<4096xi8, 3>) -> vector<8xf16>}> ({
    ^bb0(%arg3: memref<4096xi8, 3>):
      %10 = "xegpu.create_mem_desc"(%arg3) : (memref<4096xi8, 3>) -> !xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16], stride = [1, 32]>>
      %11 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %12 = "arith.constant"() <{value = 16 : index}> : () -> index
      %13 = "xegpu.load_matrix"(%10, %12, %11) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (!xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16], stride = [1, 32]>>, index, index) -> vector<8xf16>
      "xegpu.store_matrix"(%13, %10, %12, %11) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (vector<8xf16>, !xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16], stride = [1, 32]>>, index, index) -> ()
      "gpu.return"(%13) : (vector<8xf16>) -> ()
    }) {sym_name = "load_store_matrix_blocked_strided_return_vector", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (memref<4096xi8, 3>) -> vector<8xf16>}> ({
    ^bb0(%arg2: memref<4096xi8, 3>):
      %6 = "xegpu.create_mem_desc"(%arg2) : (memref<4096xi8, 3>) -> !xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16]>>
      %7 = "arith.constant"() <{value = 16 : index}> : () -> index
      %8 = "arith.constant"() <{value = 48 : index}> : () -> index
      %9 = "xegpu.load_matrix"(%6, %7, %8) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>, subgroup_block_io}> : (!xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16]>>, index, index) -> vector<8xf16>
      "xegpu.store_matrix"(%9, %6, %7, %8) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>, subgroup_block_io}> : (vector<8xf16>, !xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16]>>, index, index) -> ()
      "gpu.return"(%9) : (vector<8xf16>) -> ()
    }) {sym_name = "load_store_matrix_blocked_subgroupblockio", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (!xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16]>>) -> ()}> ({
    ^bb0(%arg1: !xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16]>>):
      %4 = "xegpu.load_matrix"(%arg1) <{const_offsets = array<i64: 16, 0>}> : (!xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16]>>) -> vector<1x16xf16>
      %5 = "arith.addf"(%4, %4) <{fastmath = #arith.fastmath<none>}> : (vector<1x16xf16>, vector<1x16xf16>) -> vector<1x16xf16>
      "xegpu.store_matrix"(%5, %arg1) <{const_offsets = array<i64: 16, 0>}> : (vector<1x16xf16>, !xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16]>>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "matrix_vector_materialization", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (memref<256x16xbf16, 3>) -> vector<1x16xbf16>}> ({
    ^bb0(%arg0: memref<256x16xbf16, 3>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 64, 0>, static_sizes = array<i64: 1, 16>, static_strides = array<i64: 1, 1>}> : (memref<256x16xbf16, 3>) -> memref<1x16xbf16, strided<[16, 1], offset: 1024>, 3>
      %2 = "xegpu.create_mem_desc"(%1) : (memref<1x16xbf16, strided<[16, 1], offset: 1024>, 3>) -> !xegpu.mem_desc<1x16xbf16>
      %3 = "xegpu.load_matrix"(%2, %0, %0) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (!xegpu.mem_desc<1x16xbf16>, index, index) -> vector<1x16xbf16>
      "gpu.return"(%3) : (vector<1x16xbf16>) -> ()
    }) {sym_name = "create_memdesc_from_subview", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

