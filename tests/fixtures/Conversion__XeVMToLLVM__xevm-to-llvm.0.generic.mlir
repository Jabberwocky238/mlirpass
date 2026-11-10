"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, arg_attrs = [{llvm.nonnull, llvm.readonly}, {}, {}, {}, {}, {llvm.nonnull, llvm.writeonly}], function_type = !llvm.func<void (ptr<1>, i32, i32, i32, vector<2xi32>, ptr)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z41intel_sub_group_2d_block_read_16b_8r16x1cPU3AS1viiiDv2_iPt", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<8xi16> (ptr<1>, i32, i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "blockload2d", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
    %1 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %4 = "llvm.insertelement"(%1, %arg4, %2) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %5 = "llvm.insertelement"(%4, %arg5, %3) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %6 = "llvm.alloca"(%0) <{elem_type = i16}> : (i32) -> !llvm.ptr
    "llvm.call"(%arg0, %arg1, %arg2, %arg3, %5, %6) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, arg_attrs = [{llvm.nonnull, llvm.readonly}, {}, {}, {}, {}, {llvm.nonnull, llvm.writeonly}], callee = @_Z41intel_sub_group_2d_block_read_16b_8r16x1cPU3AS1viiiDv2_iPt, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 6, 0>, will_return}> {function_type = !llvm.func<void (ptr<1>, i32, i32, i32, vector<2xi32>, ptr)>, linkage = #llvm.linkage<external>, sym_name = "_Z41intel_sub_group_2d_block_read_16b_8r16x1cPU3AS1viiiDv2_iPt", visibility_ = 0 : i64} : (!llvm.ptr<1>, i32, i32, i32, vector<2xi32>, !llvm.ptr) -> ()
    %7 = "llvm.load"(%6) <{ordering = 0 : i64}> : (!llvm.ptr) -> vector<8xi16>
    "llvm.return"(%7) : (vector<8xi16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, arg_attrs = [{llvm.nonnull, llvm.readonly}, {}, {}, {}, {}, {llvm.nonnull, llvm.writeonly}], function_type = !llvm.func<void (ptr<1>, i32, i32, i32, vector<2xi32>, ptr)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z40intel_sub_group_2d_block_read_8b_8r32x1cPU3AS1viiiDv2_iPt", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<8xi16> (ptr<1>, i32, i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "blockload2d_8bit_32column", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %1 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %4 = "llvm.insertelement"(%1, %arg4, %2) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %5 = "llvm.insertelement"(%4, %arg5, %3) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %6 = "llvm.alloca"(%0) <{elem_type = i16}> : (i32) -> !llvm.ptr
    "llvm.call"(%arg0, %arg1, %arg2, %arg3, %5, %6) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, arg_attrs = [{llvm.nonnull, llvm.readonly}, {}, {}, {}, {}, {llvm.nonnull, llvm.writeonly}], callee = @_Z40intel_sub_group_2d_block_read_8b_8r32x1cPU3AS1viiiDv2_iPt, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 6, 0>, will_return}> {function_type = !llvm.func<void (ptr<1>, i32, i32, i32, vector<2xi32>, ptr)>, linkage = #llvm.linkage<external>, sym_name = "_Z40intel_sub_group_2d_block_read_8b_8r32x1cPU3AS1viiiDv2_iPt", visibility_ = 0 : i64} : (!llvm.ptr<1>, i32, i32, i32, vector<2xi32>, !llvm.ptr) -> ()
    %7 = "llvm.load"(%6) <{ordering = 0 : i64}> : (!llvm.ptr) -> vector<8xi16>
    "llvm.return"(%7) : (vector<8xi16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, arg_attrs = [{llvm.nonnull, llvm.readonly}, {}, {}, {}, {}, {llvm.nonnull, llvm.writeonly}], function_type = !llvm.func<void (ptr<1>, i32, i32, i32, vector<2xi32>, ptr)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z41intel_sub_group_2d_block_read_16b_8r16x1cPU3AS1viiiDv2_iPt", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<8xi16> (ptr<1>, i32, i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "blockload2d_default_cache_control", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
    %1 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %4 = "llvm.insertelement"(%1, %arg4, %2) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %5 = "llvm.insertelement"(%4, %arg5, %3) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %6 = "llvm.alloca"(%0) <{elem_type = i16}> : (i32) -> !llvm.ptr
    "llvm.call"(%arg0, %arg1, %arg2, %arg3, %5, %6) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, arg_attrs = [{llvm.nonnull, llvm.readonly}, {}, {}, {}, {}, {llvm.nonnull, llvm.writeonly}], callee = @_Z41intel_sub_group_2d_block_read_16b_8r16x1cPU3AS1viiiDv2_iPt, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 6, 0>, will_return}> {function_type = !llvm.func<void (ptr<1>, i32, i32, i32, vector<2xi32>, ptr)>, linkage = #llvm.linkage<external>, sym_name = "_Z41intel_sub_group_2d_block_read_16b_8r16x1cPU3AS1viiiDv2_iPt", visibility_ = 0 : i64} : (!llvm.ptr<1>, i32, i32, i32, vector<2xi32>, !llvm.ptr) -> ()
    %7 = "llvm.load"(%6) <{ordering = 0 : i64}> : (!llvm.ptr) -> vector<8xi16>
    "llvm.return"(%7) : (vector<8xi16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, arg_attrs = [{llvm.nonnull, llvm.readonly}, {}, {}, {}, {}, {llvm.nonnull, llvm.writeonly}], function_type = !llvm.func<void (ptr<1>, i32, i32, i32, vector<2xi32>, ptr)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z41intel_sub_group_2d_block_read_16b_8r16x1cPU3AS1viiiDv2_iPt", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<13 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.cachecontrol.2", unnamed_addr = 2 : i64, value = "{6442:\221,0\22}\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<13 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.cachecontrol.1", unnamed_addr = 2 : i64, value = "{6442:\220,0\22}\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<1 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.file.0", unnamed_addr = 2 : i64, value = "\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<8xi16> (ptr<1>, i32, i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "blockload2d_cache_control", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
    %1 = "llvm.mlir.addressof"() <{global_name = @".str.cachecontrol.2"}> : () -> !llvm.ptr<1>
    %2 = "llvm.mlir.addressof"() <{global_name = @".str.cachecontrol.1"}> : () -> !llvm.ptr<1>
    %3 = "llvm.mlir.zero"() : () -> !llvm.ptr<1>
    %4 = "llvm.mlir.addressof"() <{global_name = @".str.file.0"}> : () -> !llvm.ptr<1>
    %5 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %6 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %7 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %8 = "llvm.insertelement"(%5, %arg4, %6) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %9 = "llvm.insertelement"(%8, %arg5, %7) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %10 = "llvm.intr.ptr.annotation"(%arg0, %2, %4, %6, %3) : (!llvm.ptr<1>, !llvm.ptr<1>, !llvm.ptr<1>, i32, !llvm.ptr<1>) -> !llvm.ptr<1>
    %11 = "llvm.intr.ptr.annotation"(%10, %1, %4, %6, %3) : (!llvm.ptr<1>, !llvm.ptr<1>, !llvm.ptr<1>, i32, !llvm.ptr<1>) -> !llvm.ptr<1>
    %12 = "llvm.alloca"(%0) <{elem_type = i16}> : (i32) -> !llvm.ptr
    "llvm.call"(%11, %arg1, %arg2, %arg3, %9, %12) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, arg_attrs = [{llvm.nonnull, llvm.readonly}, {}, {}, {}, {}, {llvm.nonnull, llvm.writeonly}], callee = @_Z41intel_sub_group_2d_block_read_16b_8r16x1cPU3AS1viiiDv2_iPt, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 6, 0>, will_return}> {function_type = !llvm.func<void (ptr<1>, i32, i32, i32, vector<2xi32>, ptr)>, linkage = #llvm.linkage<external>, sym_name = "_Z41intel_sub_group_2d_block_read_16b_8r16x1cPU3AS1viiiDv2_iPt", visibility_ = 0 : i64} : (!llvm.ptr<1>, i32, i32, i32, vector<2xi32>, !llvm.ptr) -> ()
    %13 = "llvm.load"(%12) <{ordering = 0 : i64}> : (!llvm.ptr) -> vector<8xi16>
    "llvm.return"(%13) : (vector<8xi16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, arg_attrs = [{llvm.nonnull, llvm.readonly}, {}, {}, {}, {}, {llvm.nonnull, llvm.writeonly}], function_type = !llvm.func<void (ptr<1>, i32, i32, i32, vector<2xi32>, ptr)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z41intel_sub_group_2d_block_read_16b_8r16x2cPU3AS1viiiDv2_iPt", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<16xi16> (ptr<1>, i32, i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "blockload2d_v_blocks", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
    %1 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %4 = "llvm.insertelement"(%1, %arg4, %2) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %5 = "llvm.insertelement"(%4, %arg5, %3) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %6 = "llvm.alloca"(%0) <{elem_type = i16}> : (i32) -> !llvm.ptr
    "llvm.call"(%arg0, %arg1, %arg2, %arg3, %5, %6) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, arg_attrs = [{llvm.nonnull, llvm.readonly}, {}, {}, {}, {}, {llvm.nonnull, llvm.writeonly}], callee = @_Z41intel_sub_group_2d_block_read_16b_8r16x2cPU3AS1viiiDv2_iPt, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 6, 0>, will_return}> {function_type = !llvm.func<void (ptr<1>, i32, i32, i32, vector<2xi32>, ptr)>, linkage = #llvm.linkage<external>, sym_name = "_Z41intel_sub_group_2d_block_read_16b_8r16x2cPU3AS1viiiDv2_iPt", visibility_ = 0 : i64} : (!llvm.ptr<1>, i32, i32, i32, vector<2xi32>, !llvm.ptr) -> ()
    %7 = "llvm.load"(%6) <{ordering = 0 : i64}> : (!llvm.ptr) -> vector<16xi16>
    "llvm.return"(%7) : (vector<16xi16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, arg_attrs = [{llvm.nonnull, llvm.readonly}, {}, {}, {}, {}, {llvm.nonnull, llvm.writeonly}], function_type = !llvm.func<void (ptr<1>, i32, i32, i32, vector<2xi32>, ptr)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z52intel_sub_group_2d_block_read_transform_16b_16r16x1cPU3AS1viiiDv2_iPj", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<8xi32> (ptr<1>, i32, i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "blockload2d_pack_register", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
    %1 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %4 = "llvm.insertelement"(%1, %arg4, %2) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %5 = "llvm.insertelement"(%4, %arg5, %3) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %6 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    "llvm.call"(%arg0, %arg1, %arg2, %arg3, %5, %6) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, arg_attrs = [{llvm.nonnull, llvm.readonly}, {}, {}, {}, {}, {llvm.nonnull, llvm.writeonly}], callee = @_Z52intel_sub_group_2d_block_read_transform_16b_16r16x1cPU3AS1viiiDv2_iPj, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 6, 0>, will_return}> {function_type = !llvm.func<void (ptr<1>, i32, i32, i32, vector<2xi32>, ptr)>, linkage = #llvm.linkage<external>, sym_name = "_Z52intel_sub_group_2d_block_read_transform_16b_16r16x1cPU3AS1viiiDv2_iPj", visibility_ = 0 : i64} : (!llvm.ptr<1>, i32, i32, i32, vector<2xi32>, !llvm.ptr) -> ()
    %7 = "llvm.load"(%6) <{ordering = 0 : i64}> : (!llvm.ptr) -> vector<8xi32>
    "llvm.return"(%7) : (vector<8xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, arg_attrs = [{llvm.nonnull, llvm.readonly}, {}, {}, {}, {}, {llvm.nonnull, llvm.writeonly}], function_type = !llvm.func<void (ptr<1>, i32, i32, i32, vector<2xi32>, ptr)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z51intel_sub_group_2d_block_read_transpose_32b_16r8x1cPU3AS1viiiDv2_iPj", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<8xi32> (ptr<1>, i32, i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "blockload2d_transpose", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
    %1 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %4 = "llvm.insertelement"(%1, %arg4, %2) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %5 = "llvm.insertelement"(%4, %arg5, %3) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %6 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    "llvm.call"(%arg0, %arg1, %arg2, %arg3, %5, %6) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, arg_attrs = [{llvm.nonnull, llvm.readonly}, {}, {}, {}, {}, {llvm.nonnull, llvm.writeonly}], callee = @_Z51intel_sub_group_2d_block_read_transpose_32b_16r8x1cPU3AS1viiiDv2_iPj, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 6, 0>, will_return}> {function_type = !llvm.func<void (ptr<1>, i32, i32, i32, vector<2xi32>, ptr)>, linkage = #llvm.linkage<external>, sym_name = "_Z51intel_sub_group_2d_block_read_transpose_32b_16r8x1cPU3AS1viiiDv2_iPj", visibility_ = 0 : i64} : (!llvm.ptr<1>, i32, i32, i32, vector<2xi32>, !llvm.ptr) -> ()
    %7 = "llvm.load"(%6) <{ordering = 0 : i64}> : (!llvm.ptr) -> vector<8xi32>
    "llvm.return"(%7) : (vector<8xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, arg_attrs = [{llvm.nonnull, llvm.writeonly}, {}, {}, {}, {}, {llvm.nonnull, llvm.readonly}], function_type = !llvm.func<void (ptr<1>, i32, i32, i32, vector<2xi32>, ptr)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z42intel_sub_group_2d_block_write_32b_8r16x1cPU3AS1viiiDv2_iPj", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr<1>, i32, i32, i32, i32, i32, vector<8xi32>)>, linkage = #llvm.linkage<external>, sym_name = "blockstore2d", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: vector<8xi32>):
    %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
    %1 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %4 = "llvm.insertelement"(%1, %arg4, %2) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %5 = "llvm.insertelement"(%4, %arg5, %3) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %6 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    "llvm.store"(%arg6, %6) <{ordering = 0 : i64}> : (vector<8xi32>, !llvm.ptr) -> ()
    "llvm.call"(%arg0, %arg1, %arg2, %arg3, %5, %6) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, arg_attrs = [{llvm.nonnull, llvm.writeonly}, {}, {}, {}, {}, {llvm.nonnull, llvm.readonly}], callee = @_Z42intel_sub_group_2d_block_write_32b_8r16x1cPU3AS1viiiDv2_iPj, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 6, 0>, will_return}> {function_type = !llvm.func<void (ptr<1>, i32, i32, i32, vector<2xi32>, ptr)>, linkage = #llvm.linkage<external>, sym_name = "_Z42intel_sub_group_2d_block_write_32b_8r16x1cPU3AS1viiiDv2_iPj", visibility_ = 0 : i64} : (!llvm.ptr<1>, i32, i32, i32, vector<2xi32>, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, arg_attrs = [{llvm.nonnull, llvm.writeonly}, {}, {}, {}, {}, {llvm.nonnull, llvm.readonly}], function_type = !llvm.func<void (ptr<1>, i32, i32, i32, vector<2xi32>, ptr)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z42intel_sub_group_2d_block_write_32b_8r16x1cPU3AS1viiiDv2_iPj", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<13 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.cachecontrol.5", unnamed_addr = 2 : i64, value = "{6443:\221,2\22}\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<13 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.cachecontrol.4", unnamed_addr = 2 : i64, value = "{6443:\220,1\22}\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<1 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.file.3", unnamed_addr = 2 : i64, value = "\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr<1>, i32, i32, i32, i32, i32, vector<8xi32>)>, linkage = #llvm.linkage<external>, sym_name = "blockstore2d_cache_control", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: vector<8xi32>):
    %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
    %1 = "llvm.mlir.addressof"() <{global_name = @".str.cachecontrol.5"}> : () -> !llvm.ptr<1>
    %2 = "llvm.mlir.addressof"() <{global_name = @".str.cachecontrol.4"}> : () -> !llvm.ptr<1>
    %3 = "llvm.mlir.zero"() : () -> !llvm.ptr<1>
    %4 = "llvm.mlir.addressof"() <{global_name = @".str.file.3"}> : () -> !llvm.ptr<1>
    %5 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %6 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %7 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %8 = "llvm.insertelement"(%5, %arg4, %6) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %9 = "llvm.insertelement"(%8, %arg5, %7) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %10 = "llvm.intr.ptr.annotation"(%arg0, %2, %4, %6, %3) : (!llvm.ptr<1>, !llvm.ptr<1>, !llvm.ptr<1>, i32, !llvm.ptr<1>) -> !llvm.ptr<1>
    %11 = "llvm.intr.ptr.annotation"(%10, %1, %4, %6, %3) : (!llvm.ptr<1>, !llvm.ptr<1>, !llvm.ptr<1>, i32, !llvm.ptr<1>) -> !llvm.ptr<1>
    %12 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    "llvm.store"(%arg6, %12) <{ordering = 0 : i64}> : (vector<8xi32>, !llvm.ptr) -> ()
    "llvm.call"(%11, %arg1, %arg2, %arg3, %9, %12) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, arg_attrs = [{llvm.nonnull, llvm.writeonly}, {}, {}, {}, {}, {llvm.nonnull, llvm.readonly}], callee = @_Z42intel_sub_group_2d_block_write_32b_8r16x1cPU3AS1viiiDv2_iPj, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 6, 0>, will_return}> {function_type = !llvm.func<void (ptr<1>, i32, i32, i32, vector<2xi32>, ptr)>, linkage = #llvm.linkage<external>, sym_name = "_Z42intel_sub_group_2d_block_write_32b_8r16x1cPU3AS1viiiDv2_iPj", visibility_ = 0 : i64} : (!llvm.ptr<1>, i32, i32, i32, vector<2xi32>, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, arg_attrs = [{llvm.nonnull}, {}, {}, {}, {}], function_type = !llvm.func<void (ptr<1>, i32, i32, i32, vector<2xi32>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = read, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z44intel_sub_group_2d_block_prefetch_8b_8r32x1cPU3AS1viiiDv2_i", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<13 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.cachecontrol.8", unnamed_addr = 2 : i64, value = "{6442:\221,0\22}\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<13 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.cachecontrol.7", unnamed_addr = 2 : i64, value = "{6442:\220,0\22}\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<1 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.file.6", unnamed_addr = 2 : i64, value = "\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr<1>, i32, i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "blockprefetch2d", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "llvm.mlir.addressof"() <{global_name = @".str.cachecontrol.8"}> : () -> !llvm.ptr<1>
    %1 = "llvm.mlir.addressof"() <{global_name = @".str.cachecontrol.7"}> : () -> !llvm.ptr<1>
    %2 = "llvm.mlir.zero"() : () -> !llvm.ptr<1>
    %3 = "llvm.mlir.addressof"() <{global_name = @".str.file.6"}> : () -> !llvm.ptr<1>
    %4 = "llvm.mlir.undef"() : () -> vector<2xi32>
    %5 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %6 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %7 = "llvm.insertelement"(%4, %arg4, %5) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %8 = "llvm.insertelement"(%7, %arg5, %6) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %9 = "llvm.intr.ptr.annotation"(%arg0, %1, %3, %5, %2) : (!llvm.ptr<1>, !llvm.ptr<1>, !llvm.ptr<1>, i32, !llvm.ptr<1>) -> !llvm.ptr<1>
    %10 = "llvm.intr.ptr.annotation"(%9, %0, %3, %5, %2) : (!llvm.ptr<1>, !llvm.ptr<1>, !llvm.ptr<1>, i32, !llvm.ptr<1>) -> !llvm.ptr<1>
    "llvm.call"(%10, %arg1, %arg2, %arg3, %8) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, arg_attrs = [{llvm.nonnull}, {}, {}, {}, {}], callee = @_Z44intel_sub_group_2d_block_prefetch_8b_8r32x1cPU3AS1viiiDv2_i, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = read, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 5, 0>}> {function_type = !llvm.func<void (ptr<1>, i32, i32, i32, vector<2xi32>)>, linkage = #llvm.linkage<external>, sym_name = "_Z44intel_sub_group_2d_block_prefetch_8b_8r32x1cPU3AS1viiiDv2_i", visibility_ = 0 : i64} : (!llvm.ptr<1>, i32, i32, i32, vector<2xi32>) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, convergent, function_type = !llvm.func<vector<8xf32> (vector<8xi16>, vector<8xi32>, vector<8xf32>)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z38intel_sub_group_f16_f16_matrix_mad_k16Dv8_sDv8_iDv8_f", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<8xf32> (vector<8xf32>, vector<8xi16>, vector<8xi32>)>, linkage = #llvm.linkage<external>, sym_name = "mma", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<8xf32>, %arg1: vector<8xi16>, %arg2: vector<8xi32>):
    %0 = "llvm.call"(%arg1, %arg2, %arg0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z38intel_sub_group_f16_f16_matrix_mad_k16Dv8_sDv8_iDv8_f, convergent, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>, will_return}> {function_type = !llvm.func<vector<8xf32> (vector<8xi16>, vector<8xi32>, vector<8xf32>)>, linkage = #llvm.linkage<external>, sym_name = "_Z38intel_sub_group_f16_f16_matrix_mad_k16Dv8_sDv8_iDv8_f", visibility_ = 0 : i64} : (vector<8xi16>, vector<8xi32>, vector<8xf32>) -> vector<8xf32>
    "llvm.return"(%0) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<void (i32, i32, i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z22atomic_work_item_fenceiii", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "memfence", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    "llvm.call"(%2, %0, %1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z22atomic_work_item_fenceiii, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> {function_type = !llvm.func<void (i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "_Z22atomic_work_item_fenceiii", visibility_ = 0 : i64} : (i32, i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<void (ptr<1>, i64)>, linkage = #llvm.linkage<external>, memory_effects = #llvm.memory_effects<other = none, argMem = read, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, sym_name = "_Z8prefetchPU3AS1Kcm", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<13 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.cachecontrol.11", unnamed_addr = 2 : i64, value = "{6442:\221,0\22}\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<13 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.cachecontrol.10", unnamed_addr = 2 : i64, value = "{6442:\220,0\22}\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<1 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.file.9", unnamed_addr = 2 : i64, value = "\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr<1>)>, linkage = #llvm.linkage<external>, sym_name = "prefetch", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>):
    %0 = "llvm.mlir.addressof"() <{global_name = @".str.cachecontrol.11"}> : () -> !llvm.ptr<1>
    %1 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %2 = "llvm.mlir.addressof"() <{global_name = @".str.file.9"}> : () -> !llvm.ptr<1>
    %3 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "llvm.mlir.zero"() : () -> !llvm.ptr<1>
    %5 = "llvm.mlir.addressof"() <{global_name = @".str.cachecontrol.10"}> : () -> !llvm.ptr<1>
    %6 = "llvm.intr.ptr.annotation"(%arg0, %5, %2, %3, %4) : (!llvm.ptr<1>, !llvm.ptr<1>, !llvm.ptr<1>, i32, !llvm.ptr<1>) -> !llvm.ptr<1>
    %7 = "llvm.intr.ptr.annotation"(%6, %0, %2, %3, %4) : (!llvm.ptr<1>, !llvm.ptr<1>, !llvm.ptr<1>, i32, !llvm.ptr<1>) -> !llvm.ptr<1>
    "llvm.call"(%7, %1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z8prefetchPU3AS1Kcm, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = read, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> {function_type = !llvm.func<void (ptr<1>, i64)>, linkage = #llvm.linkage<external>, sym_name = "_Z8prefetchPU3AS1Kcm", visibility_ = 0 : i64} : (!llvm.ptr<1>, i64) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<13 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.cachecontrol.14", unnamed_addr = 2 : i64, value = "{6442:\221,0\22}\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<13 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.cachecontrol.13", unnamed_addr = 2 : i64, value = "{6442:\220,0\22}\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<1 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.file.12", unnamed_addr = 2 : i64, value = "\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (ptr<1>)>, linkage = #llvm.linkage<external>, sym_name = "llvm.load", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>):
    %0 = "llvm.mlir.addressof"() <{global_name = @".str.cachecontrol.14"}> : () -> !llvm.ptr<1>
    %1 = "llvm.mlir.addressof"() <{global_name = @".str.file.12"}> : () -> !llvm.ptr<1>
    %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "llvm.mlir.zero"() : () -> !llvm.ptr<1>
    %4 = "llvm.mlir.addressof"() <{global_name = @".str.cachecontrol.13"}> : () -> !llvm.ptr<1>
    %5 = "llvm.intr.ptr.annotation"(%arg0, %4, %1, %2, %3) : (!llvm.ptr<1>, !llvm.ptr<1>, !llvm.ptr<1>, i32, !llvm.ptr<1>) -> !llvm.ptr<1>
    %6 = "llvm.intr.ptr.annotation"(%5, %0, %1, %2, %3) : (!llvm.ptr<1>, !llvm.ptr<1>, !llvm.ptr<1>, i32, !llvm.ptr<1>) -> !llvm.ptr<1>
    %7 = "llvm.load"(%6) <{ordering = 0 : i64}> : (!llvm.ptr<1>) -> i32
    "llvm.return"(%7) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<13 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.cachecontrol.17", unnamed_addr = 2 : i64, value = "{6443:\221,2\22}\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<13 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.cachecontrol.16", unnamed_addr = 2 : i64, value = "{6443:\220,1\22}\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<1 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.file.15", unnamed_addr = 2 : i64, value = "\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr<1>, i32)>, linkage = #llvm.linkage<external>, sym_name = "llvm.store", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>, %arg1: i32):
    %0 = "llvm.mlir.addressof"() <{global_name = @".str.cachecontrol.17"}> : () -> !llvm.ptr<1>
    %1 = "llvm.mlir.addressof"() <{global_name = @".str.file.15"}> : () -> !llvm.ptr<1>
    %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "llvm.mlir.zero"() : () -> !llvm.ptr<1>
    %4 = "llvm.mlir.addressof"() <{global_name = @".str.cachecontrol.16"}> : () -> !llvm.ptr<1>
    %5 = "llvm.intr.ptr.annotation"(%arg0, %4, %1, %2, %3) : (!llvm.ptr<1>, !llvm.ptr<1>, !llvm.ptr<1>, i32, !llvm.ptr<1>) -> !llvm.ptr<1>
    %6 = "llvm.intr.ptr.annotation"(%5, %0, %1, %2, %3) : (!llvm.ptr<1>, !llvm.ptr<1>, !llvm.ptr<1>, i32, !llvm.ptr<1>) -> !llvm.ptr<1>
    "llvm.store"(%arg1, %6) <{ordering = 0 : i64}> : (i32, !llvm.ptr<1>) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<vector<8xi16> (ptr<1>)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z30intel_sub_group_block_read_us8PU3AS1t", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<13 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.cachecontrol.20", unnamed_addr = 2 : i64, value = "{6442:\221,0\22}\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<13 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.cachecontrol.19", unnamed_addr = 2 : i64, value = "{6442:\220,0\22}\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<1 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.file.18", unnamed_addr = 2 : i64, value = "\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<8xi16> (ptr<1>)>, linkage = #llvm.linkage<external>, sym_name = "blockload_as1", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>):
    %0 = "llvm.mlir.addressof"() <{global_name = @".str.cachecontrol.20"}> : () -> !llvm.ptr<1>
    %1 = "llvm.mlir.addressof"() <{global_name = @".str.file.18"}> : () -> !llvm.ptr<1>
    %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "llvm.mlir.zero"() : () -> !llvm.ptr<1>
    %4 = "llvm.mlir.addressof"() <{global_name = @".str.cachecontrol.19"}> : () -> !llvm.ptr<1>
    %5 = "llvm.intr.ptr.annotation"(%arg0, %4, %1, %2, %3) : (!llvm.ptr<1>, !llvm.ptr<1>, !llvm.ptr<1>, i32, !llvm.ptr<1>) -> !llvm.ptr<1>
    %6 = "llvm.intr.ptr.annotation"(%5, %0, %1, %2, %3) : (!llvm.ptr<1>, !llvm.ptr<1>, !llvm.ptr<1>, i32, !llvm.ptr<1>) -> !llvm.ptr<1>
    %7 = "llvm.call"(%6) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z30intel_sub_group_block_read_us8PU3AS1t, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<vector<8xi16> (ptr<1>)>, linkage = #llvm.linkage<external>, sym_name = "_Z30intel_sub_group_block_read_us8PU3AS1t", visibility_ = 0 : i64} : (!llvm.ptr<1>) -> vector<8xi16>
    "llvm.return"(%7) : (vector<8xi16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<vector<16xi8> (ptr<3>)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z31intel_sub_group_block_read_uc16PU3AS3h", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<13 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.cachecontrol.23", unnamed_addr = 2 : i64, value = "{6442:\221,0\22}\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<13 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.cachecontrol.22", unnamed_addr = 2 : i64, value = "{6442:\220,0\22}\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<1 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.file.21", unnamed_addr = 2 : i64, value = "\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<16xi8> (ptr<3>)>, linkage = #llvm.linkage<external>, sym_name = "blockload_as3", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<3>):
    %0 = "llvm.mlir.addressof"() <{global_name = @".str.cachecontrol.23"}> : () -> !llvm.ptr<1>
    %1 = "llvm.mlir.addressof"() <{global_name = @".str.file.21"}> : () -> !llvm.ptr<1>
    %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "llvm.mlir.zero"() : () -> !llvm.ptr<1>
    %4 = "llvm.mlir.addressof"() <{global_name = @".str.cachecontrol.22"}> : () -> !llvm.ptr<1>
    %5 = "llvm.intr.ptr.annotation"(%arg0, %4, %1, %2, %3) : (!llvm.ptr<3>, !llvm.ptr<1>, !llvm.ptr<1>, i32, !llvm.ptr<1>) -> !llvm.ptr<3>
    %6 = "llvm.intr.ptr.annotation"(%5, %0, %1, %2, %3) : (!llvm.ptr<3>, !llvm.ptr<1>, !llvm.ptr<1>, i32, !llvm.ptr<1>) -> !llvm.ptr<3>
    %7 = "llvm.call"(%6) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z31intel_sub_group_block_read_uc16PU3AS3h, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<vector<16xi8> (ptr<3>)>, linkage = #llvm.linkage<external>, sym_name = "_Z31intel_sub_group_block_read_uc16PU3AS3h", visibility_ = 0 : i64} : (!llvm.ptr<3>) -> vector<16xi8>
    "llvm.return"(%7) : (vector<16xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<i8 (ptr<3>)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z29intel_sub_group_block_read_ucPU3AS3h", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<13 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.cachecontrol.26", unnamed_addr = 2 : i64, value = "{6442:\221,0\22}\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<13 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.cachecontrol.25", unnamed_addr = 2 : i64, value = "{6442:\220,0\22}\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<1 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.file.24", unnamed_addr = 2 : i64, value = "\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i8 (ptr<3>)>, linkage = #llvm.linkage<external>, sym_name = "blockload_scalar", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<3>):
    %0 = "llvm.mlir.addressof"() <{global_name = @".str.cachecontrol.26"}> : () -> !llvm.ptr<1>
    %1 = "llvm.mlir.addressof"() <{global_name = @".str.file.24"}> : () -> !llvm.ptr<1>
    %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "llvm.mlir.zero"() : () -> !llvm.ptr<1>
    %4 = "llvm.mlir.addressof"() <{global_name = @".str.cachecontrol.25"}> : () -> !llvm.ptr<1>
    %5 = "llvm.intr.ptr.annotation"(%arg0, %4, %1, %2, %3) : (!llvm.ptr<3>, !llvm.ptr<1>, !llvm.ptr<1>, i32, !llvm.ptr<1>) -> !llvm.ptr<3>
    %6 = "llvm.intr.ptr.annotation"(%5, %0, %1, %2, %3) : (!llvm.ptr<3>, !llvm.ptr<1>, !llvm.ptr<1>, i32, !llvm.ptr<1>) -> !llvm.ptr<3>
    %7 = "llvm.call"(%6) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z29intel_sub_group_block_read_ucPU3AS3h, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<i8 (ptr<3>)>, linkage = #llvm.linkage<external>, sym_name = "_Z29intel_sub_group_block_read_ucPU3AS3h", visibility_ = 0 : i64} : (!llvm.ptr<3>) -> i8
    "llvm.return"(%7) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<void (ptr<1>, vector<8xi32>)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z31intel_sub_group_block_write_ui8PU3AS1jDv8_j", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<13 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.cachecontrol.29", unnamed_addr = 2 : i64, value = "{6443:\221,2\22}\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<13 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.cachecontrol.28", unnamed_addr = 2 : i64, value = "{6443:\220,1\22}\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<1 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.file.27", unnamed_addr = 2 : i64, value = "\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr<1>, vector<8xi32>)>, linkage = #llvm.linkage<external>, sym_name = "blockstore_as1", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>, %arg1: vector<8xi32>):
    %0 = "llvm.mlir.addressof"() <{global_name = @".str.cachecontrol.29"}> : () -> !llvm.ptr<1>
    %1 = "llvm.mlir.addressof"() <{global_name = @".str.file.27"}> : () -> !llvm.ptr<1>
    %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "llvm.mlir.zero"() : () -> !llvm.ptr<1>
    %4 = "llvm.mlir.addressof"() <{global_name = @".str.cachecontrol.28"}> : () -> !llvm.ptr<1>
    %5 = "llvm.intr.ptr.annotation"(%arg0, %4, %1, %2, %3) : (!llvm.ptr<1>, !llvm.ptr<1>, !llvm.ptr<1>, i32, !llvm.ptr<1>) -> !llvm.ptr<1>
    %6 = "llvm.intr.ptr.annotation"(%5, %0, %1, %2, %3) : (!llvm.ptr<1>, !llvm.ptr<1>, !llvm.ptr<1>, i32, !llvm.ptr<1>) -> !llvm.ptr<1>
    "llvm.call"(%6, %arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z31intel_sub_group_block_write_ui8PU3AS1jDv8_j, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, will_return}> {function_type = !llvm.func<void (ptr<1>, vector<8xi32>)>, linkage = #llvm.linkage<external>, sym_name = "_Z31intel_sub_group_block_write_ui8PU3AS1jDv8_j", visibility_ = 0 : i64} : (!llvm.ptr<1>, vector<8xi32>) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<void (ptr<3>, vector<2xi64>)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z31intel_sub_group_block_write_ul2PU3AS3mDv2_m", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<13 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.cachecontrol.32", unnamed_addr = 2 : i64, value = "{6443:\221,2\22}\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<13 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.cachecontrol.31", unnamed_addr = 2 : i64, value = "{6443:\220,1\22}\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<1 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.file.30", unnamed_addr = 2 : i64, value = "\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr<3>, vector<2xi64>)>, linkage = #llvm.linkage<external>, sym_name = "blockstore_as3", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<3>, %arg1: vector<2xi64>):
    %0 = "llvm.mlir.addressof"() <{global_name = @".str.cachecontrol.32"}> : () -> !llvm.ptr<1>
    %1 = "llvm.mlir.addressof"() <{global_name = @".str.file.30"}> : () -> !llvm.ptr<1>
    %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "llvm.mlir.zero"() : () -> !llvm.ptr<1>
    %4 = "llvm.mlir.addressof"() <{global_name = @".str.cachecontrol.31"}> : () -> !llvm.ptr<1>
    %5 = "llvm.intr.ptr.annotation"(%arg0, %4, %1, %2, %3) : (!llvm.ptr<3>, !llvm.ptr<1>, !llvm.ptr<1>, i32, !llvm.ptr<1>) -> !llvm.ptr<3>
    %6 = "llvm.intr.ptr.annotation"(%5, %0, %1, %2, %3) : (!llvm.ptr<3>, !llvm.ptr<1>, !llvm.ptr<1>, i32, !llvm.ptr<1>) -> !llvm.ptr<3>
    "llvm.call"(%6, %arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z31intel_sub_group_block_write_ul2PU3AS3mDv2_m, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, will_return}> {function_type = !llvm.func<void (ptr<3>, vector<2xi64>)>, linkage = #llvm.linkage<external>, sym_name = "_Z31intel_sub_group_block_write_ul2PU3AS3mDv2_m", visibility_ = 0 : i64} : (!llvm.ptr<3>, vector<2xi64>) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<void (ptr<3>, i64)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z30intel_sub_group_block_write_ulPU3AS3mm", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<13 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.cachecontrol.35", unnamed_addr = 2 : i64, value = "{6443:\221,2\22}\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<13 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.cachecontrol.34", unnamed_addr = 2 : i64, value = "{6443:\220,1\22}\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 1 : i32, alignment = 1 : i64, constant, global_type = !llvm.array<1 x i8>, linkage = #llvm.linkage<private>, section = "llvm.metadata", sym_name = ".str.file.33", unnamed_addr = 2 : i64, value = "\00", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr<3>, i64)>, linkage = #llvm.linkage<external>, sym_name = "blockstore_scalar", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<3>, %arg1: i64):
    %0 = "llvm.mlir.addressof"() <{global_name = @".str.cachecontrol.35"}> : () -> !llvm.ptr<1>
    %1 = "llvm.mlir.addressof"() <{global_name = @".str.file.33"}> : () -> !llvm.ptr<1>
    %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "llvm.mlir.zero"() : () -> !llvm.ptr<1>
    %4 = "llvm.mlir.addressof"() <{global_name = @".str.cachecontrol.34"}> : () -> !llvm.ptr<1>
    %5 = "llvm.intr.ptr.annotation"(%arg0, %4, %1, %2, %3) : (!llvm.ptr<3>, !llvm.ptr<1>, !llvm.ptr<1>, i32, !llvm.ptr<1>) -> !llvm.ptr<3>
    %6 = "llvm.intr.ptr.annotation"(%5, %0, %1, %2, %3) : (!llvm.ptr<3>, !llvm.ptr<1>, !llvm.ptr<1>, i32, !llvm.ptr<1>) -> !llvm.ptr<3>
    "llvm.call"(%6, %arg1) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z30intel_sub_group_block_write_ulPU3AS3mm, fastmathFlags = #llvm.fastmath<none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>, will_return}> {function_type = !llvm.func<void (ptr<3>, i64)>, linkage = #llvm.linkage<external>, sym_name = "_Z30intel_sub_group_block_write_ulPU3AS3mm", visibility_ = 0 : i64} : (!llvm.ptr<3>, i64) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z12get_local_idj", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "local_id.x", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "llvm.call"(%0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z12get_local_idj, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "_Z12get_local_idj", visibility_ = 0 : i64} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z12get_local_idj", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "local_id.y", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.call"(%0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z12get_local_idj, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "_Z12get_local_idj", visibility_ = 0 : i64} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z12get_local_idj", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "local_id.z", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %1 = "llvm.call"(%0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z12get_local_idj, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "_Z12get_local_idj", visibility_ = 0 : i64} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z14get_local_sizej", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "local_size.x", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "llvm.call"(%0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z14get_local_sizej, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "_Z14get_local_sizej", visibility_ = 0 : i64} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z14get_local_sizej", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "local_size.y", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.call"(%0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z14get_local_sizej, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "_Z14get_local_sizej", visibility_ = 0 : i64} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z14get_local_sizej", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "local_size.z", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %1 = "llvm.call"(%0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z14get_local_sizej, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "_Z14get_local_sizej", visibility_ = 0 : i64} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z12get_group_idj", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "group_id.x", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "llvm.call"(%0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z12get_group_idj, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "_Z12get_group_idj", visibility_ = 0 : i64} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z12get_group_idj", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "group_id.y", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.call"(%0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z12get_group_idj, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "_Z12get_group_idj", visibility_ = 0 : i64} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z12get_group_idj", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "group_id.z", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %1 = "llvm.call"(%0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z12get_group_idj, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "_Z12get_group_idj", visibility_ = 0 : i64} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z14get_num_groupsj", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "group_count.x", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "llvm.call"(%0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z14get_num_groupsj, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "_Z14get_num_groupsj", visibility_ = 0 : i64} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z14get_num_groupsj", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "group_count.y", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.call"(%0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z14get_num_groupsj, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "_Z14get_num_groupsj", visibility_ = 0 : i64} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z14get_num_groupsj", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "group_count.z", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %1 = "llvm.call"(%0) <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z14get_num_groupsj, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>, will_return}> {function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "_Z14get_num_groupsj", visibility_ = 0 : i64} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z22get_sub_group_local_id", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "lane_id", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.call"() <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z22get_sub_group_local_id, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>, will_return}> {function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "_Z22get_sub_group_local_id", visibility_ = 0 : i64} : () -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z18get_sub_group_size", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "subgroup_size", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.call"() <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z18get_sub_group_size, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>, will_return}> {function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "_Z18get_sub_group_size", visibility_ = 0 : i64} : () -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<spir_funccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, no_unwind, sym_name = "_Z16get_sub_group_id", visibility_ = 0 : i64, will_return}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "subgroup_id", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.call"() <{CConv = #llvm.cconv<spir_funccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_Z16get_sub_group_id, fastmathFlags = #llvm.fastmath<none>, memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>, will_return}> {function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "_Z16get_sub_group_id", visibility_ = 0 : i64} : () -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

