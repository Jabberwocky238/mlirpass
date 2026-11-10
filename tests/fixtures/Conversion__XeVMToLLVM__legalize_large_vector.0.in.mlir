"builtin.module"() <{sym_name = "test_illegal_vector"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, ptr, ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "test_illegal_vector", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: !llvm.ptr, %arg4: !llvm.ptr):
    %0 = "llvm.load"(%arg0) <{ordering = 0 : i64}> : (!llvm.ptr) -> vector<32xi16>
    %1 = "llvm.bitcast"(%0) : (vector<32xi16>) -> vector<32xf16>
    %2 = "llvm.shufflevector"(%1, %1) <{mask = array<i32: 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15>}> : (vector<32xf16>, vector<32xf16>) -> vector<16xf16>
    %3 = "llvm.shufflevector"(%1, %1) <{mask = array<i32: 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31>}> : (vector<32xf16>, vector<32xf16>) -> vector<16xf16>
    %4 = "llvm.fpext"(%2) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<16xf16>) -> vector<16xf32>
    %5 = "llvm.fpext"(%3) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<16xf16>) -> vector<16xf32>
    %6 = "llvm.shufflevector"(%4, %4) <{mask = array<i32: 0, 1, 2, 3, 4, 5, 6, 7>}> : (vector<16xf32>, vector<16xf32>) -> vector<8xf32>
    %7 = "llvm.shufflevector"(%4, %4) <{mask = array<i32: 8, 9, 10, 11, 12, 13, 14, 15>}> : (vector<16xf32>, vector<16xf32>) -> vector<8xf32>
    %8 = "llvm.bitcast"(%6) : (vector<8xf32>) -> vector<8xi32>
    "llvm.store"(%8, %arg1) <{ordering = 0 : i64}> : (vector<8xi32>, !llvm.ptr) -> ()
    %9 = "llvm.bitcast"(%7) : (vector<8xf32>) -> vector<8xi32>
    "llvm.store"(%9, %arg2) <{ordering = 0 : i64}> : (vector<8xi32>, !llvm.ptr) -> ()
    %10 = "llvm.shufflevector"(%5, %5) <{mask = array<i32: 0, 1, 2, 3, 4, 5, 6, 7>}> : (vector<16xf32>, vector<16xf32>) -> vector<8xf32>
    %11 = "llvm.shufflevector"(%5, %5) <{mask = array<i32: 8, 9, 10, 11, 12, 13, 14, 15>}> : (vector<16xf32>, vector<16xf32>) -> vector<8xf32>
    %12 = "llvm.bitcast"(%10) : (vector<8xf32>) -> vector<8xi32>
    "llvm.store"(%12, %arg3) <{ordering = 0 : i64}> : (vector<8xi32>, !llvm.ptr) -> ()
    %13 = "llvm.bitcast"(%11) : (vector<8xf32>) -> vector<8xi32>
    "llvm.store"(%13, %arg4) <{ordering = 0 : i64}> : (vector<8xi32>, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_match_fail"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "test_match_fail", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: !llvm.ptr):
    %0 = "llvm.load"(%arg0) <{ordering = 0 : i64}> : (!llvm.ptr) -> vector<4xi16>
    %1 = "llvm.load"(%arg1) <{ordering = 0 : i64}> : (!llvm.ptr) -> vector<4xi16>
    %2 = "llvm.shufflevector"(%0, %1) <{mask = array<i32: 0, 1, 2, 3, 4, 5, 6, 7>}> : (vector<4xi16>, vector<4xi16>) -> vector<8xi16>
    %3 = "llvm.shufflevector"(%0, %0) <{mask = array<i32: 0, 1, 2, 3, 4, 5, 6, 7>}> : (vector<4xi16>, vector<4xi16>) -> vector<8xi16>
    %4 = "llvm.shufflevector"(%2, %2) <{mask = array<i32: 0, 1, 2, 3, 4, 5>}> : (vector<8xi16>, vector<8xi16>) -> vector<6xi16>
    %5 = "llvm.shufflevector"(%3, %3) <{mask = array<i32: 0, 1, 2, 3, 4, 5>}> : (vector<8xi16>, vector<8xi16>) -> vector<6xi16>
    "llvm.store"(%4, %arg2) <{ordering = 0 : i64}> : (vector<6xi16>, !llvm.ptr) -> ()
    "llvm.store"(%5, %arg3) <{ordering = 0 : i64}> : (vector<6xi16>, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_non_private_addrspace"}> ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr<1>, ptr<1>, ptr<1>)>, linkage = #llvm.linkage<external>, sym_name = "test_non_private_addrspace", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr<1>, %arg1: !llvm.ptr<1>, %arg2: !llvm.ptr<1>):
    %0 = "llvm.load"(%arg0) <{ordering = 0 : i64}> : (!llvm.ptr<1>) -> vector<8xi16>
    %1 = "llvm.shufflevector"(%0, %0) <{mask = array<i32: 0, 1, 2, 3>}> : (vector<8xi16>, vector<8xi16>) -> vector<4xi16>
    %2 = "llvm.shufflevector"(%0, %0) <{mask = array<i32: 4, 5, 6, 7>}> : (vector<8xi16>, vector<8xi16>) -> vector<4xi16>
    "llvm.store"(%1, %arg1) <{ordering = 0 : i64}> : (vector<4xi16>, !llvm.ptr<1>) -> ()
    "llvm.store"(%2, %arg2) <{ordering = 0 : i64}> : (vector<4xi16>, !llvm.ptr<1>) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

