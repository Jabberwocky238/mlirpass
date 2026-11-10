"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<8xi16> (ptr<1>, i32, i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "blockload2d", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "xevm.blockload2d"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5) <{elem_size_in_bits = 16 : i32, pack_register = false, tile_height = 8 : i32, tile_width = 16 : i32, transpose = false, v_blocks = 1 : i32}> : (!llvm.ptr<1>, i32, i32, i32, i32, i32) -> vector<8xi16>
    "llvm.return"(%0) : (vector<8xi16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<8xi16> (ptr<1>, i32, i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "blockload2d_8bit_32column", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "xevm.blockload2d"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5) <{elem_size_in_bits = 8 : i32, pack_register = false, tile_height = 8 : i32, tile_width = 32 : i32, transpose = false, v_blocks = 1 : i32}> : (!llvm.ptr<1>, i32, i32, i32, i32, i32) -> vector<8xi16>
    "llvm.return"(%0) : (vector<8xi16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<8xi16> (ptr<1>, i32, i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "blockload2d_default_cache_control", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "xevm.blockload2d"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5) <{cache_control = #xevm.load_cache_control<Use_Default>, elem_size_in_bits = 16 : i32, pack_register = false, tile_height = 8 : i32, tile_width = 16 : i32, transpose = false, v_blocks = 1 : i32}> : (!llvm.ptr<1>, i32, i32, i32, i32, i32) -> vector<8xi16>
    "llvm.return"(%0) : (vector<8xi16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<8xi16> (ptr<1>, i32, i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "blockload2d_cache_control", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "xevm.blockload2d"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5) <{cache_control = #xevm.load_cache_control<L1uc_L2uc_L3uc>, elem_size_in_bits = 16 : i32, pack_register = false, tile_height = 8 : i32, tile_width = 16 : i32, transpose = false, v_blocks = 1 : i32}> : (!llvm.ptr<1>, i32, i32, i32, i32, i32) -> vector<8xi16>
    "llvm.return"(%0) : (vector<8xi16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<16xi16> (ptr<1>, i32, i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "blockload2d_v_blocks", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "xevm.blockload2d"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5) <{elem_size_in_bits = 16 : i32, pack_register = false, tile_height = 8 : i32, tile_width = 16 : i32, transpose = false, v_blocks = 2 : i32}> : (!llvm.ptr<1>, i32, i32, i32, i32, i32) -> vector<16xi16>
    "llvm.return"(%0) : (vector<16xi16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<8xi32> (ptr<1>, i32, i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "blockload2d_pack_register", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "xevm.blockload2d"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5) <{elem_size_in_bits = 16 : i32, pack_register = true, tile_height = 16 : i32, tile_width = 16 : i32, transpose = false, v_blocks = 1 : i32}> : (!llvm.ptr<1>, i32, i32, i32, i32, i32) -> vector<8xi32>
    "llvm.return"(%0) : (vector<8xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<8xi32> (ptr<1>, i32, i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "blockload2d_transpose", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "xevm.blockload2d"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5) <{elem_size_in_bits = 32 : i32, pack_register = false, tile_height = 16 : i32, tile_width = 8 : i32, transpose = true, v_blocks = 1 : i32}> : (!llvm.ptr<1>, i32, i32, i32, i32, i32) -> vector<8xi32>
    "llvm.return"(%0) : (vector<8xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr<1>, i32, i32, i32, i32, i32, vector<8xi32>)>, linkage = #llvm.linkage<external>, sym_name = "blockstore2d", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: vector<8xi32>):
    "xevm.blockstore2d"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6) <{elem_size_in_bits = 32 : i32, tile_height = 8 : i32, tile_width = 16 : i32}> : (!llvm.ptr<1>, i32, i32, i32, i32, i32, vector<8xi32>) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr<1>, i32, i32, i32, i32, i32, vector<8xi32>)>, linkage = #llvm.linkage<external>, sym_name = "blockstore2d_cache_control", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: vector<8xi32>):
    "xevm.blockstore2d"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6) <{cache_control = #xevm.store_cache_control<L1wt_L2uc_L3wb>, elem_size_in_bits = 32 : i32, tile_height = 8 : i32, tile_width = 16 : i32}> : (!llvm.ptr<1>, i32, i32, i32, i32, i32, vector<8xi32>) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr<1>, i32, i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "blockprefetch2d", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32):
    "xevm.blockprefetch2d"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5) <{cache_control = #xevm.load_cache_control<L1uc_L2uc_L3uc>, elem_size_in_bits = 8 : i32, tile_height = 8 : i32, tile_width = 32 : i32, v_blocks = 1 : i32}> : (!llvm.ptr<1>, i32, i32, i32, i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<8xf32> (vector<8xf32>, vector<8xi16>, vector<8xi32>)>, linkage = #llvm.linkage<external>, sym_name = "mma", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<8xf32>, %arg1: vector<8xi16>, %arg2: vector<8xi32>):
    %0 = "xevm.mma"(%arg1, %arg2, %arg0) <{shape = #xevm.mma_shape<m = 8, n = 16, k = 16>, types = #xevm.mma_types<d = f32, a = f16, b = f16, c = f32>}> : (vector<8xi16>, vector<8xi32>, vector<8xf32>) -> vector<8xf32>
    "llvm.return"(%0) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "memfence", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    "xevm.memfence"() <{addrspace = #xevm.addr_space<global>, scope = #xevm.mem_scope<workgroup>}> : () -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr<1>)>, linkage = #llvm.linkage<external>, sym_name = "prefetch", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>):
    "xevm.prefetch"(%arg0) <{cache_control = #xevm.load_cache_control<L1uc_L2uc_L3uc>}> : (!llvm.ptr<1>) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (ptr<1>)>, linkage = #llvm.linkage<external>, sym_name = "llvm.load", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>):
    %0 = "llvm.load"(%arg0) <{ordering = 0 : i64}> {cache_control = #xevm.load_cache_control<L1uc_L2uc_L3uc>} : (!llvm.ptr<1>) -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr<1>, i32)>, linkage = #llvm.linkage<external>, sym_name = "llvm.store", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>, %arg1: i32):
    "llvm.store"(%arg1, %arg0) <{ordering = 0 : i64}> {cache_control = #xevm.store_cache_control<L1wt_L2uc_L3wb>} : (i32, !llvm.ptr<1>) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<8xi16> (ptr<1>)>, linkage = #llvm.linkage<external>, sym_name = "blockload_as1", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>):
    %0 = "xevm.blockload"(%arg0) <{cache_control = #xevm.load_cache_control<L1uc_L2uc_L3uc>}> : (!llvm.ptr<1>) -> vector<8xi16>
    "llvm.return"(%0) : (vector<8xi16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<16xi8> (ptr<3>)>, linkage = #llvm.linkage<external>, sym_name = "blockload_as3", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<3>):
    %0 = "xevm.blockload"(%arg0) <{cache_control = #xevm.load_cache_control<L1uc_L2uc_L3uc>}> : (!llvm.ptr<3>) -> vector<16xi8>
    "llvm.return"(%0) : (vector<16xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i8 (ptr<3>)>, linkage = #llvm.linkage<external>, sym_name = "blockload_scalar", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<3>):
    %0 = "xevm.blockload"(%arg0) <{cache_control = #xevm.load_cache_control<L1uc_L2uc_L3uc>}> : (!llvm.ptr<3>) -> i8
    "llvm.return"(%0) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr<1>, vector<8xi32>)>, linkage = #llvm.linkage<external>, sym_name = "blockstore_as1", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>, %arg1: vector<8xi32>):
    "xevm.blockstore"(%arg0, %arg1) <{cache_control = #xevm.store_cache_control<L1wt_L2uc_L3wb>}> : (!llvm.ptr<1>, vector<8xi32>) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr<3>, vector<2xi64>)>, linkage = #llvm.linkage<external>, sym_name = "blockstore_as3", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<3>, %arg1: vector<2xi64>):
    "xevm.blockstore"(%arg0, %arg1) <{cache_control = #xevm.store_cache_control<L1wt_L2uc_L3wb>}> : (!llvm.ptr<3>, vector<2xi64>) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr<3>, i64)>, linkage = #llvm.linkage<external>, sym_name = "blockstore_scalar", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<3>, %arg1: i64):
    "xevm.blockstore"(%arg0, %arg1) <{cache_control = #xevm.store_cache_control<L1wt_L2uc_L3wb>}> : (!llvm.ptr<3>, i64) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "local_id.x", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "xevm.local_id.x"() : () -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "local_id.y", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "xevm.local_id.y"() : () -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "local_id.z", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "xevm.local_id.z"() : () -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "local_size.x", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "xevm.local_size.x"() : () -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "local_size.y", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "xevm.local_size.y"() : () -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "local_size.z", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "xevm.local_size.z"() : () -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "group_id.x", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "xevm.group_id.x"() : () -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "group_id.y", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "xevm.group_id.y"() : () -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "group_id.z", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "xevm.group_id.z"() : () -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "group_count.x", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "xevm.group_count.x"() : () -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "group_count.y", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "xevm.group_count.y"() : () -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "group_count.z", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "xevm.group_count.z"() : () -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "lane_id", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "xevm.lane_id"() : () -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "subgroup_size", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "xevm.subgroup_size"() : () -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "subgroup_id", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "xevm.subgroup_id"() : () -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

