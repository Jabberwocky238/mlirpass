"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 (i32)>, linkage = #llvm.linkage<external>, sym_name = "fold_icmp_eq", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i32):
    %0 = "llvm.icmp"(%arg0, %arg0) <{predicate = 0 : i64}> : (i32, i32) -> i1
    "llvm.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<2xi1> (vector<2xi32>)>, linkage = #llvm.linkage<external>, sym_name = "fold_icmp_ne", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<2xi32>):
    %0 = "llvm.icmp"(%arg0, %arg0) <{predicate = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
    "llvm.return"(%0) : (vector<2xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 ()>, linkage = #llvm.linkage<external>, sym_name = "fold_icmp_alloca", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %1 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %2 = "llvm.alloca"(%1) <{elem_type = i32}> : (i64) -> !llvm.ptr
    %3 = "llvm.icmp"(%0, %2) <{predicate = 1 : i64}> : (!llvm.ptr, !llvm.ptr) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "fold_extractvalue", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "llvm.mlir.undef"() : () -> !llvm.struct<(i32, i32)>
    %3 = "llvm.insertvalue"(%2, %0) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>, i32) -> !llvm.struct<(i32, i32)>
    %4 = "llvm.insertvalue"(%3, %1) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>, i32) -> !llvm.struct<(i32, i32)>
    %5 = "llvm.extractvalue"(%4) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>) -> i32
    %6 = "llvm.extractvalue"(%4) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>) -> i32
    %7 = "llvm.add"(%5, %6) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.return"(%7) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "fold_extractvalue", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):
    %0 = "llvm.mlir.undef"() : () -> !llvm.struct<(struct<(i32, i32, i32)>, struct<(i32, i32)>)>
    %1 = "llvm.mlir.undef"() : () -> !llvm.struct<(i32, i32, i32)>
    %2 = "llvm.insertvalue"(%1, %arg0) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32)>
    %3 = "llvm.insertvalue"(%2, %arg0) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32)>
    %4 = "llvm.insertvalue"(%3, %arg0) <{position = array<i64: 2>}> : (!llvm.struct<(i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32)>
    %5 = "llvm.insertvalue"(%0, %4) <{position = array<i64: 0>}> : (!llvm.struct<(struct<(i32, i32, i32)>, struct<(i32, i32)>)>, !llvm.struct<(i32, i32, i32)>) -> !llvm.struct<(struct<(i32, i32, i32)>, struct<(i32, i32)>)>
    %6 = "llvm.extractvalue"(%5) <{position = array<i64: 0, 0>}> : (!llvm.struct<(struct<(i32, i32, i32)>, struct<(i32, i32)>)>) -> i32
    "llvm.return"(%6) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (array<4 x f32>)>, linkage = #llvm.linkage<external>, sym_name = "no_fold_extractvalue", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.array<4 x f32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "llvm.mlir.undef"() : () -> !llvm.array<4 x array<4 x f32>>
    %2 = "llvm.insertvalue"(%1, %0) <{position = array<i64: 0, 0>}> : (!llvm.array<4 x array<4 x f32>>, f32) -> !llvm.array<4 x array<4 x f32>>
    %3 = "llvm.insertvalue"(%2, %arg0) <{position = array<i64: 0>}> : (!llvm.array<4 x array<4 x f32>>, !llvm.array<4 x f32>) -> !llvm.array<4 x array<4 x f32>>
    %4 = "llvm.extractvalue"(%3) <{position = array<i64: 0, 0>}> : (!llvm.array<4 x array<4 x f32>>) -> f32
    "llvm.return"(%4) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (array<4 x f32>)>, linkage = #llvm.linkage<external>, sym_name = "fold_unrelated_extractvalue", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.array<4 x f32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "llvm.insertvalue"(%arg0, %0) <{position = array<i64: 0>}> : (!llvm.array<4 x f32>, f32) -> !llvm.array<4 x f32>
    %2 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.array<4 x f32>) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr<1> (struct<(i64, array<1 x ptr<1>>)>)>, linkage = #llvm.linkage<external>, sym_name = "fold_extract_extractvalue", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.struct<(i64, array<1 x ptr<1>>)>):
    %0 = "llvm.extractvalue"(%arg0) <{position = array<i64: 1>}> : (!llvm.struct<(i64, array<1 x ptr<1>>)>) -> !llvm.array<1 x ptr<1>>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.array<1 x ptr<1>>) -> !llvm.ptr<1>
    "llvm.return"(%1) : (!llvm.ptr<1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 ()>, linkage = #llvm.linkage<external>, sym_name = "fold_extract_const_array", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = dense<[-8.900000e+01, 5.000000e-01]> : tensor<2xf64>}> : () -> !llvm.array<2 x f64>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.array<2 x f64>) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "fold_extract_const_struct", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = [1 : i16, 2 : i32]}> : () -> !llvm.struct<(i16, i32)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(i16, i32)>) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 ()>, linkage = #llvm.linkage<external>, sym_name = "fold_extract_splat", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = dense<-8.900000e+01> : tensor<2xf64>}> : () -> !llvm.array<2 x f64>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.array<2 x f64>) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "fold_extract_splat_nested", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = dense<(0,1)> : tensor<2xcomplex<i32>>}> : () -> !llvm.array<2 x struct<(i32, i32)>>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 1, 1>}> : (!llvm.array<2 x struct<(i32, i32)>>) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 ()>, linkage = #llvm.linkage<external>, sym_name = "fold_extract_sparse", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = sparse<0, 4.200000e+01> : tensor<4xf32>}> : () -> !llvm.array<4 x f32>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.array<4 x f32>) -> f32
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.array<4 x f32>) -> f32
    %3 = "llvm.fadd"(%1, %2) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    "llvm.return"(%3) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "fold_zero", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.zero"() : () -> !llvm.struct<(i16, i32)>
    %1 = "llvm.mlir.undef"() : () -> !llvm.array<2 x struct<(i16, i32)>>
    %2 = "llvm.insertvalue"(%1, %0) <{position = array<i64: 0>}> : (!llvm.array<2 x struct<(i16, i32)>>, !llvm.struct<(i16, i32)>) -> !llvm.array<2 x struct<(i16, i32)>>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 0, 1>}> : (!llvm.array<2 x struct<(i16, i32)>>) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (struct<(i16, i32)>)>, linkage = #llvm.linkage<external>, sym_name = "use_struct", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "fold_undef", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.undef"() : () -> !llvm.struct<(i8, struct<(i16, i32)>)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(i8, struct<(i16, i32)>)>) -> !llvm.struct<(i16, i32)>
    "llvm.call"(%1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @use_struct, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.struct<(i16, i32)>) -> ()
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 1, 1>}> : (!llvm.struct<(i8, struct<(i16, i32)>)>) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (array<8 x f32>)>, linkage = #llvm.linkage<external>, sym_name = "use_array", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 ()>, linkage = #llvm.linkage<external>, sym_name = "fold_poison", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.poison"() : () -> !llvm.array<2 x array<8 x f32>>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.array<2 x array<8 x f32>>) -> !llvm.array<8 x f32>
    "llvm.call"(%1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @use_array, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.array<8 x f32>) -> ()
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 1, 1>}> : (!llvm.array<2 x array<8 x f32>>) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (ptr)>, linkage = #llvm.linkage<external>, sym_name = "fold_bitcast", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "llvm.bitcast"(%arg0) : (!llvm.ptr) -> !llvm.ptr
    "llvm.return"(%0) : (!llvm.ptr) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "fold_bitcast2", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i32):
    %0 = "llvm.bitcast"(%arg0) : (i32) -> f32
    %1 = "llvm.bitcast"(%0) : (f32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<2xi16> (i32)>, linkage = #llvm.linkage<external>, sym_name = "fold_bitcast_chain", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i32):
    %0 = "llvm.bitcast"(%arg0) : (i32) -> f32
    %1 = "llvm.bitcast"(%0) : (f32) -> vector<2xi16>
    "llvm.return"(%1) : (vector<2xi16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (ptr)>, linkage = #llvm.linkage<external>, sym_name = "fold_addrcast", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "llvm.addrspacecast"(%arg0) : (!llvm.ptr) -> !llvm.ptr
    "llvm.return"(%0) : (!llvm.ptr) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (ptr)>, linkage = #llvm.linkage<external>, sym_name = "fold_addrcast2", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "llvm.addrspacecast"(%arg0) : (!llvm.ptr) -> !llvm.ptr<5>
    %1 = "llvm.addrspacecast"(%0) : (!llvm.ptr<5>) -> !llvm.ptr
    "llvm.return"(%1) : (!llvm.ptr) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr<2> (ptr)>, linkage = #llvm.linkage<external>, sym_name = "fold_addrcast_chain", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "llvm.addrspacecast"(%arg0) : (!llvm.ptr) -> !llvm.ptr<1>
    %1 = "llvm.addrspacecast"(%0) : (!llvm.ptr<1>) -> !llvm.ptr<2>
    "llvm.return"(%1) : (!llvm.ptr<2>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (ptr)>, linkage = #llvm.linkage<external>, sym_name = "fold_gep", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "llvm.getelementptr"(%arg0, %0) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i32) -> !llvm.ptr
    "llvm.return"(%1) : (!llvm.ptr) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (ptr)>, linkage = #llvm.linkage<external>, sym_name = "fold_gep_neg", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "llvm.getelementptr"(%arg0, %0) <{elem_type = !llvm.struct<(i32, i32)>, noWrapFlags = 3 : i32, rawConstantIndices = array<i32: -2147483648, 1>}> : (!llvm.ptr, i32) -> !llvm.ptr
    "llvm.return"(%1) : (!llvm.ptr) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (ptr)>, linkage = #llvm.linkage<external>, sym_name = "fold_gep_canon", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %1 = "llvm.getelementptr"(%arg0, %0) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i32) -> !llvm.ptr
    "llvm.return"(%1) : (!llvm.ptr) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<1xf32> (vector<1xf32>, vector<1xf32>)>, linkage = #llvm.linkage<external>, sym_name = "fold_shufflevector", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<1xf32>, %arg1: vector<1xf32>):
    %0 = "llvm.shufflevector"(%arg0, %arg1) <{mask = array<i32: 0>}> : (vector<1xf32>, vector<1xf32>) -> vector<1xf32>
    "llvm.return"(%0) : (vector<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "llvm_constant", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 40 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
    %2 = "arith.addi"(%0, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "load_dce", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "llvm.load"(%arg0) <{ordering = 0 : i64}> : (!llvm.ptr) -> i8
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.mlir.global"() <{addr_space = 0 : i32, global_type = !llvm.ptr, linkage = #llvm.linkage<external>, sym_name = "fp", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "addr_dce", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "llvm.mlir.addressof"() <{global_name = @fp}> : () -> !llvm.ptr
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "alloca_dce", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %1 = "llvm.alloca"(%0) <{elem_type = i32}> : (i64) -> !llvm.ptr
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "volatile_load", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "llvm.load"(%arg0) <{ordering = 0 : i64, volatile_}> : (!llvm.ptr) -> i8
    %1 = "llvm.load"(%arg0) <{alignment = 1 : i64, ordering = 2 : i64}> : (!llvm.ptr) -> i8
    %2 = "llvm.load"(%arg0) <{alignment = 1 : i64, ordering = 1 : i64}> : (!llvm.ptr) -> i8
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "inline_asm_side_effects", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i32):
    "llvm.inline_asm"(%arg0) <{asm_string = "pure inline asm", constraints = "r", tail_call_kind = #llvm.tailcallkind<none>}> : (i32) -> ()
    "llvm.inline_asm"(%arg0) <{asm_string = "inline asm with side effects", constraints = "r", has_side_effects, tail_call_kind = #llvm.tailcallkind<none>}> : (i32) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

