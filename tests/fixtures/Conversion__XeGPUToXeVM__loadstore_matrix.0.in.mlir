"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_kernel", targets = [#xevm.target<chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (memref<4096xi8, 3>) -> f32}> ({
    ^bb0(%arg9: memref<4096xi8, 3>):
      %35 = "xegpu.create_mem_desc"(%arg9) : (memref<4096xi8, 3>) -> !xegpu.mem_desc<32x32xf32>
      %36 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %37 = "arith.constant"() <{value = 0 : index}> : () -> index
      %38 = "xegpu.load_matrix"(%35, %37, %36) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (!xegpu.mem_desc<32x32xf32>, index, index) -> f32
      "xegpu.store_matrix"(%38, %35, %37, %36) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (f32, !xegpu.mem_desc<32x32xf32>, index, index) -> ()
      "gpu.return"(%38) : (f32) -> ()
    }) {sym_name = "load_store_matrix_plain"} : () -> ()
    "gpu.func"() <{function_type = (memref<1024xi8, 3>) -> f32}> ({
    ^bb0(%arg8: memref<1024xi8, 3>):
      %29 = "arith.constant"() <{value = 0 : index}> : () -> index
      %30 = "memref.view"(%arg8, %29) : (memref<1024xi8, 3>, index) -> memref<64x32xf32, 3>
      %31 = "memref.subview"(%30) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 32, 0>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<64x32xf32, 3>) -> memref<32x32xf32, strided<[32, 1], offset: 1024>, 3>
      %32 = "xegpu.create_mem_desc"(%31) : (memref<32x32xf32, strided<[32, 1], offset: 1024>, 3>) -> !xegpu.mem_desc<32x32xf32>
      %33 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %34 = "xegpu.load_matrix"(%32, %29, %33) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (!xegpu.mem_desc<32x32xf32>, index, index) -> f32
      "xegpu.store_matrix"(%34, %32, %29, %33) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (f32, !xegpu.mem_desc<32x32xf32>, index, index) -> ()
      "gpu.return"(%34) : (f32) -> ()
    }) {sym_name = "load_store_matrix_plain_2d_input"} : () -> ()
    "gpu.func"() <{function_type = (memref<4096xi8, 3>) -> f16}> ({
    ^bb0(%arg7: memref<4096xi8, 3>):
      %25 = "xegpu.create_mem_desc"(%arg7) : (memref<4096xi8, 3>) -> !xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16], stride = [1, 32]>>
      %26 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %27 = "arith.constant"() <{value = 13 : index}> : () -> index
      %28 = "xegpu.load_matrix"(%25, %27, %26) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (!xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16], stride = [1, 32]>>, index, index) -> f16
      "xegpu.store_matrix"(%28, %25, %27, %26) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (f16, !xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16], stride = [1, 32]>>, index, index) -> ()
      "gpu.return"(%28) : (f16) -> ()
    }) {sym_name = "load_store_matrix_blocked_strided"} : () -> ()
    "gpu.func"() <{function_type = (memref<4096xi8, 3>) -> f16}> ({
    ^bb0(%arg6: memref<4096xi8, 3>):
      %21 = "xegpu.create_mem_desc"(%arg6) : (memref<4096xi8, 3>) -> !xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16]>>
      %22 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %23 = "arith.constant"() <{value = 19 : index}> : () -> index
      %24 = "xegpu.load_matrix"(%21, %23, %22) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (!xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16]>>, index, index) -> f16
      "xegpu.store_matrix"(%24, %21, %23, %22) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (f16, !xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16]>>, index, index) -> ()
      "gpu.return"(%24) : (f16) -> ()
    }) {sym_name = "load_store_matrix_blocked_nostride"} : () -> ()
    "gpu.func"() <{function_type = (memref<4096xi8, 3>) -> vector<8xf16>}> ({
    ^bb0(%arg5: memref<4096xi8, 3>):
      %17 = "xegpu.create_mem_desc"(%arg5) : (memref<4096xi8, 3>) -> !xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16], stride = [1, 32]>>
      %18 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %19 = "arith.constant"() <{value = 16 : index}> : () -> index
      %20 = "xegpu.load_matrix"(%17, %19, %18) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (!xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16], stride = [1, 32]>>, index, index) -> vector<8xf16>
      "xegpu.store_matrix"(%20, %17, %19, %18) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (vector<8xf16>, !xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16], stride = [1, 32]>>, index, index) -> ()
      "gpu.return"(%20) : (vector<8xf16>) -> ()
    }) {sym_name = "load_store_matrix_blocked_strided_return_vector"} : () -> ()
    "gpu.func"() <{function_type = (memref<4096xi8, 3>) -> vector<8xf16>}> ({
    ^bb0(%arg4: memref<4096xi8, 3>):
      %13 = "xegpu.create_mem_desc"(%arg4) : (memref<4096xi8, 3>) -> !xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16]>>
      %14 = "arith.constant"() <{value = 16 : index}> : () -> index
      %15 = "arith.constant"() <{value = 48 : index}> : () -> index
      %16 = "xegpu.load_matrix"(%13, %14, %15) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>, subgroup_block_io}> : (!xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16]>>, index, index) -> vector<8xf16>
      "xegpu.store_matrix"(%16, %13, %14, %15) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>, subgroup_block_io}> : (vector<8xf16>, !xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16]>>, index, index) -> ()
      "gpu.return"(%16) : (vector<8xf16>) -> ()
    }) {sym_name = "load_store_matrix_blocked_subgroupblockio"} : () -> ()
    "gpu.func"() <{function_type = (!xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16]>>) -> ()}> ({
    ^bb0(%arg3: !xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16]>>):
      %11 = "xegpu.load_matrix"(%arg3) <{const_offsets = array<i64: 16, 0>}> : (!xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16]>>) -> vector<1x16xf16>
      %12 = "arith.addf"(%11, %11) <{fastmath = #arith.fastmath<none>}> : (vector<1x16xf16>, vector<1x16xf16>) -> vector<1x16xf16>
      "xegpu.store_matrix"(%12, %arg3) <{const_offsets = array<i64: 16, 0>}> : (vector<1x16xf16>, !xegpu.mem_desc<32x64xf16, #xegpu.mem_layout<block = [16, 16]>>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "matrix_vector_materialization"} : () -> ()
    "gpu.func"() <{function_type = (memref<256x16xbf16, 3>) -> vector<1x16xbf16>}> ({
    ^bb0(%arg2: memref<256x16xbf16, 3>):
      %7 = "arith.constant"() <{value = 0 : index}> : () -> index
      %8 = "memref.subview"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 64, 0>, static_sizes = array<i64: 1, 16>, static_strides = array<i64: 1, 1>}> : (memref<256x16xbf16, 3>) -> memref<1x16xbf16, strided<[16, 1], offset: 1024>, 3>
      %9 = "xegpu.create_mem_desc"(%8) : (memref<1x16xbf16, strided<[16, 1], offset: 1024>, 3>) -> !xegpu.mem_desc<1x16xbf16>
      %10 = "xegpu.load_matrix"(%9, %7, %7) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (!xegpu.mem_desc<1x16xbf16>, index, index) -> vector<1x16xbf16>
      "gpu.return"(%10) : (vector<1x16xbf16>) -> ()
    }) {sym_name = "create_memdesc_from_subview"} : () -> ()
    "gpu.func"() <{function_type = (memref<1024xi8, 3>) -> vector<1x1xf8E8M0FNU>}> ({
    ^bb0(%arg1: memref<1024xi8, 3>):
      %3 = "arith.constant"() <{value = 0 : index}> : () -> index
      %4 = "xegpu.create_mem_desc"(%arg1) : (memref<1024xi8, 3>) -> !xegpu.mem_desc<32x32xf8E8M0FNU>
      %5 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %6 = "xegpu.load_matrix"(%4, %3, %5) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (!xegpu.mem_desc<32x32xf8E8M0FNU>, index, index) -> vector<1x1xf8E8M0FNU>
      "gpu.return"(%6) : (vector<1x1xf8E8M0FNU>) -> ()
    }) {sym_name = "load_matrix_f8e8m0_scalar"} : () -> ()
    "gpu.func"() <{function_type = (memref<1024xi8, 3>) -> vector<8xf8E8M0FNU>}> ({
    ^bb0(%arg0: memref<1024xi8, 3>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "xegpu.create_mem_desc"(%arg0) : (memref<1024xi8, 3>) -> !xegpu.mem_desc<32x32xf8E8M0FNU>
      %2 = "xegpu.load_matrix"(%1, %0, %0) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (!xegpu.mem_desc<32x32xf8E8M0FNU>, index, index) -> vector<8xf8E8M0FNU>
      "gpu.return"(%2) : (vector<8xf8E8M0FNU>) -> ()
    }) {sym_name = "load_matrix_f8e8m0_vector"} : () -> ()
  }) : () -> ()
}) : () -> ()

