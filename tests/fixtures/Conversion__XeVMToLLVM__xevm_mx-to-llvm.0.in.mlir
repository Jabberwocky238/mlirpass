"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<16xi8> (vector<16xf16>)>, linkage = #llvm.linkage<external>, sym_name = "truncf_f16_to_bf8", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<16xf16>):
    %0 = "xevm.truncf"(%arg0) <{dst_etype = #xevm<dst_etype dst_etype = bf8>, src_etype = #xevm<src_etype src_etype = f16>}> : (vector<16xf16>) -> vector<16xi8>
    "llvm.return"(%0) : (vector<16xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<16xi8> (vector<16xf16>)>, linkage = #llvm.linkage<external>, sym_name = "truncf_f16_to_hf8", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<16xf16>):
    %0 = "xevm.truncf"(%arg0) <{dst_etype = #xevm<dst_etype dst_etype = f8>, src_etype = #xevm<src_etype src_etype = f16>}> : (vector<16xf16>) -> vector<16xi8>
    "llvm.return"(%0) : (vector<16xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<16xi8> (vector<16xbf16>)>, linkage = #llvm.linkage<external>, sym_name = "truncf_bf16_to_bf8", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<16xbf16>):
    %0 = "xevm.truncf"(%arg0) <{dst_etype = #xevm<dst_etype dst_etype = bf8>, src_etype = #xevm<src_etype src_etype = bf16>}> : (vector<16xbf16>) -> vector<16xi8>
    "llvm.return"(%0) : (vector<16xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<16xi8> (vector<16xbf16>)>, linkage = #llvm.linkage<external>, sym_name = "truncf_bf16_to_hf8", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<16xbf16>):
    %0 = "xevm.truncf"(%arg0) <{dst_etype = #xevm<dst_etype dst_etype = f8>, src_etype = #xevm<src_etype src_etype = bf16>}> : (vector<16xbf16>) -> vector<16xi8>
    "llvm.return"(%0) : (vector<16xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<8xi8> (vector<16xf16>)>, linkage = #llvm.linkage<external>, sym_name = "truncf_f16_to_e2m1", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<16xf16>):
    %0 = "xevm.truncf"(%arg0) <{dst_etype = #xevm<dst_etype dst_etype = e2m1>, src_etype = #xevm<src_etype src_etype = f16>}> : (vector<16xf16>) -> vector<8xi8>
    "llvm.return"(%0) : (vector<8xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<8xi8> (vector<16xbf16>)>, linkage = #llvm.linkage<external>, sym_name = "truncf_bf16_to_e2m1", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<16xbf16>):
    %0 = "xevm.truncf"(%arg0) <{dst_etype = #xevm<dst_etype dst_etype = e2m1>, src_etype = #xevm<src_etype src_etype = bf16>}> : (vector<16xbf16>) -> vector<8xi8>
    "llvm.return"(%0) : (vector<8xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<16xf16> (vector<16xi8>)>, linkage = #llvm.linkage<external>, sym_name = "extf_bf8_to_f16", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<16xi8>):
    %0 = "xevm.extf"(%arg0) <{dst_etype = #xevm<ext_dst_etype dst_etype = f16>, src_etype = #xevm<ext_src_etype src_etype = bf8>}> : (vector<16xi8>) -> vector<16xf16>
    "llvm.return"(%0) : (vector<16xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<16xf16> (vector<16xi8>)>, linkage = #llvm.linkage<external>, sym_name = "extf_f8_to_f16", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<16xi8>):
    %0 = "xevm.extf"(%arg0) <{dst_etype = #xevm<ext_dst_etype dst_etype = f16>, src_etype = #xevm<ext_src_etype src_etype = f8>}> : (vector<16xi8>) -> vector<16xf16>
    "llvm.return"(%0) : (vector<16xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<16xbf16> (vector<16xi8>)>, linkage = #llvm.linkage<external>, sym_name = "extf_bf8_to_bf16", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<16xi8>):
    %0 = "xevm.extf"(%arg0) <{dst_etype = #xevm<ext_dst_etype dst_etype = bf16>, src_etype = #xevm<ext_src_etype src_etype = bf8>}> : (vector<16xi8>) -> vector<16xbf16>
    "llvm.return"(%0) : (vector<16xbf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<16xbf16> (vector<16xi8>)>, linkage = #llvm.linkage<external>, sym_name = "extf_f8_to_bf16", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<16xi8>):
    %0 = "xevm.extf"(%arg0) <{dst_etype = #xevm<ext_dst_etype dst_etype = bf16>, src_etype = #xevm<ext_src_etype src_etype = f8>}> : (vector<16xi8>) -> vector<16xbf16>
    "llvm.return"(%0) : (vector<16xbf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<16xf16> (vector<8xi8>)>, linkage = #llvm.linkage<external>, sym_name = "extf_e2m1_to_f16", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<8xi8>):
    %0 = "xevm.extf"(%arg0) <{dst_etype = #xevm<ext_dst_etype dst_etype = f16>, src_etype = #xevm<ext_src_etype src_etype = e2m1>}> : (vector<8xi8>) -> vector<16xf16>
    "llvm.return"(%0) : (vector<16xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<16xbf16> (vector<8xi8>)>, linkage = #llvm.linkage<external>, sym_name = "extf_e2m1_to_bf16", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<8xi8>):
    %0 = "xevm.extf"(%arg0) <{dst_etype = #xevm<ext_dst_etype dst_etype = bf16>, src_etype = #xevm<ext_src_etype src_etype = e2m1>}> : (vector<8xi8>) -> vector<16xbf16>
    "llvm.return"(%0) : (vector<16xbf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<8xf32> (vector<8xi16>, vector<8xi32>, i8, i8, vector<8xf32>)>, linkage = #llvm.linkage<external>, sym_name = "mma_mx_bf8_bf8_k32_f32", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<8xi16>, %arg1: vector<8xi32>, %arg2: i8, %arg3: i8, %arg4: vector<8xf32>):
    %0 = "xevm.mma_mx"(%arg0, %arg1, %arg2, %arg3, %arg4) <{shape = #xevm.mma_shape<m = 8, n = 16, k = 32>, types = #xevm.mma_types<d = f32, a = bf8, b = bf8, c = f32>}> : (vector<8xi16>, vector<8xi32>, i8, i8, vector<8xf32>) -> vector<8xf32>
    "llvm.return"(%0) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

