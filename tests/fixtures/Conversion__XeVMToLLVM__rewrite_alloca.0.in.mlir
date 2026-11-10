"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr<3> ()>, linkage = #llvm.linkage<external>, sym_name = "test_with_parent_module", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 10 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = i32}> : (i32) -> !llvm.ptr<3>
    %2 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = i32}> : (i32) -> !llvm.ptr<3>
    %3 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = i32}> : (i32) -> !llvm.ptr<3>
    %4 = "llvm.load"(%2) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> i32
    %5 = "llvm.load"(%3) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> i32
    %6 = "llvm.add"(%4, %5) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.store"(%6, %1) <{ordering = 0 : i64}> : (i32, !llvm.ptr<3>) -> ()
    "llvm.return"(%1) : (!llvm.ptr<3>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr<3> ()>, linkage = #llvm.linkage<external>, sym_name = "test_with_parent_gpu_module", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
      %0 = "llvm.mlir.constant"() <{value = 10 : i32}> : () -> i32
      %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = i32}> : (i32) -> !llvm.ptr<3>
      %2 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = i32}> : (i32) -> !llvm.ptr<3>
      %3 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = i32}> : (i32) -> !llvm.ptr<3>
      %4 = "llvm.load"(%2) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> i32
      %5 = "llvm.load"(%3) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> i32
      %6 = "llvm.add"(%4, %5) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      "llvm.store"(%6, %1) <{ordering = 0 : i64}> : (i32, !llvm.ptr<3>) -> ()
      "llvm.return"(%1) : (!llvm.ptr<3>) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr ()>, linkage = #llvm.linkage<external>, sym_name = "test_with_default_addr_space", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 10 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = i32}> : (i32) -> !llvm.ptr
    %2 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = i32}> : (i32) -> !llvm.ptr
    %3 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = i32}> : (i32) -> !llvm.ptr
    %4 = "llvm.load"(%2) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    %5 = "llvm.load"(%3) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    %6 = "llvm.add"(%4, %5) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.store"(%6, %1) <{ordering = 0 : i64}> : (i32, !llvm.ptr) -> ()
    "llvm.return"(%1) : (!llvm.ptr) -> ()
  }) : () -> ()
}) : () -> ()

