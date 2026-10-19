"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "access_chain", visibility_ = 0 : i64}> ({
    %49 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %50 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %51 = "llvm.alloca"(%50) <{elem_type = !llvm.struct<packed (f32, array<4 x f32>)>}> : (i32) -> !llvm.ptr
    %52 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %53 = "llvm.getelementptr"(%51, %52, %49) <{elem_type = !llvm.struct<packed (f32, array<4 x f32>)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648, 1, -2147483648>}> : (!llvm.ptr, i32, i32) -> !llvm.ptr
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "access_chain_array", visibility_ = 0 : i64}> ({
  ^bb0(%arg5: i32):
    %44 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %45 = "llvm.alloca"(%44) <{elem_type = !llvm.array<4 x array<4 x f32>>}> : (i32) -> !llvm.ptr
    %46 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %47 = "llvm.getelementptr"(%45, %46, %arg5) <{elem_type = !llvm.array<4 x array<4 x f32>>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648, -2147483648>}> : (!llvm.ptr, i32, i32) -> !llvm.ptr
    %48 = "llvm.load"(%47) <{ordering = 0 : i64, volatile_}> : (!llvm.ptr) -> !llvm.array<4 x f32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "llvm.mlir.global"() <{addr_space = 0 : i32, constant, global_type = f32, linkage = #llvm.linkage<external>, sym_name = "var", visibility_ = 0 : i64}> ({
    }) : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "llvm.mlir.global"() <{addr_space = 0 : i32, global_type = !llvm.struct<packed (f32, array<10 x f32>)>, linkage = #llvm.linkage<private>, sym_name = "struct", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "func", visibility_ = 0 : i64}> ({
      %43 = "llvm.mlir.addressof"() <{global_name = @struct}> : () -> !llvm.ptr
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "llvm.mlir.global"() <{addr_space = 0 : i32, global_type = i32, linkage = #llvm.linkage<external>, sym_name = "bar_descriptor_set0_binding0", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "foo", visibility_ = 0 : i64}> ({
      %42 = "llvm.mlir.addressof"() <{global_name = @bar_descriptor_set0_binding0}> : () -> !llvm.ptr
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "name"}> ({
    "llvm.mlir.global"() <{addr_space = 0 : i32, global_type = i32, linkage = #llvm.linkage<external>, sym_name = "name_bar_descriptor_set0_binding0", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "foo", visibility_ = 0 : i64}> ({
      %41 = "llvm.mlir.addressof"() <{global_name = @name_bar_descriptor_set0_binding0}> : () -> !llvm.ptr
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "llvm.mlir.global"() <{addr_space = 0 : i32, global_type = i32, linkage = #llvm.linkage<external>, sym_name = "bar", visibility_ = 0 : i64}> ({
    }) {location = 1 : i32} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "foo", visibility_ = 0 : i64}> ({
      %40 = "llvm.mlir.addressof"() <{global_name = @bar}> : () -> !llvm.ptr
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "llvm.mlir.global"() <{addr_space = 0 : i32, constant, global_type = f32, linkage = #llvm.linkage<external>, sym_name = "bar", visibility_ = 0 : i64}> ({
    }) {location = 3 : i32} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "foo", visibility_ = 0 : i64}> ({
      %39 = "llvm.mlir.addressof"() <{global_name = @bar}> : () -> !llvm.ptr
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "load", visibility_ = 0 : i64}> ({
    %36 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %37 = "llvm.alloca"(%36) <{elem_type = f32}> : (i32) -> !llvm.ptr
    %38 = "llvm.load"(%37) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "load_none", visibility_ = 0 : i64}> ({
    %33 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %34 = "llvm.alloca"(%33) <{elem_type = f32}> : (i32) -> !llvm.ptr
    %35 = "llvm.load"(%34) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "load_with_alignment", visibility_ = 0 : i64}> ({
    %30 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %31 = "llvm.alloca"(%30) <{elem_type = f32}> : (i32) -> !llvm.ptr
    %32 = "llvm.load"(%31) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "load_volatile", visibility_ = 0 : i64}> ({
    %27 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %28 = "llvm.alloca"(%27) <{elem_type = f32}> : (i32) -> !llvm.ptr
    %29 = "llvm.load"(%28) <{ordering = 0 : i64, volatile_}> : (!llvm.ptr) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "load_nontemporal", visibility_ = 0 : i64}> ({
    %24 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %25 = "llvm.alloca"(%24) <{elem_type = f32}> : (i32) -> !llvm.ptr
    %26 = "llvm.load"(%25) <{nontemporal, ordering = 0 : i64}> : (!llvm.ptr) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32)>, linkage = #llvm.linkage<external>, sym_name = "store", visibility_ = 0 : i64}> ({
  ^bb0(%arg4: f32):
    %22 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %23 = "llvm.alloca"(%22) <{elem_type = f32}> : (i32) -> !llvm.ptr
    "llvm.store"(%arg4, %23) <{ordering = 0 : i64}> : (f32, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (struct<packed (f64)>)>, linkage = #llvm.linkage<external>, sym_name = "store_composite", visibility_ = 0 : i64}> ({
  ^bb0(%arg3: !llvm.struct<packed (f64)>):
    %20 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %21 = "llvm.alloca"(%20) <{elem_type = !llvm.struct<packed (f64)>}> : (i32) -> !llvm.ptr
    "llvm.store"(%arg3, %21) <{ordering = 0 : i64}> : (!llvm.struct<packed (f64)>, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32)>, linkage = #llvm.linkage<external>, sym_name = "store_with_alignment", visibility_ = 0 : i64}> ({
  ^bb0(%arg2: f32):
    %18 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %19 = "llvm.alloca"(%18) <{elem_type = f32}> : (i32) -> !llvm.ptr
    "llvm.store"(%arg2, %19) <{alignment = 4 : i64, ordering = 0 : i64}> : (f32, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32)>, linkage = #llvm.linkage<external>, sym_name = "store_volatile", visibility_ = 0 : i64}> ({
  ^bb0(%arg1: f32):
    %16 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %17 = "llvm.alloca"(%16) <{elem_type = f32}> : (i32) -> !llvm.ptr
    "llvm.store"(%arg1, %17) <{ordering = 0 : i64, volatile_}> : (f32, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32)>, linkage = #llvm.linkage<external>, sym_name = "store_nontemporal", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: f32):
    %14 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %15 = "llvm.alloca"(%14) <{elem_type = f32}> : (i32) -> !llvm.ptr
    "llvm.store"(%arg0, %15) <{nontemporal, ordering = 0 : i64}> : (f32, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "variable_scalar", visibility_ = 0 : i64}> ({
    %10 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %11 = "llvm.alloca"(%10) <{elem_type = f32}> : (i32) -> !llvm.ptr
    %12 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %13 = "llvm.alloca"(%12) <{elem_type = i8}> : (i32) -> !llvm.ptr
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "variable_scalar_with_initialization", visibility_ = 0 : i64}> ({
    %7 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %8 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %9 = "llvm.alloca"(%8) <{elem_type = i64}> : (i32) -> !llvm.ptr
    "llvm.store"(%7, %9) <{ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "variable_vector", visibility_ = 0 : i64}> ({
    %5 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %6 = "llvm.alloca"(%5) <{elem_type = vector<3xf32>}> : (i32) -> !llvm.ptr
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "variable_vector_with_initialization", visibility_ = 0 : i64}> ({
    %2 = "llvm.mlir.constant"() <{value = dense<false> : vector<3xi1>}> : () -> vector<3xi1>
    %3 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %4 = "llvm.alloca"(%3) <{elem_type = vector<3xi1>}> : (i32) -> !llvm.ptr
    "llvm.store"(%2, %4) <{ordering = 0 : i64}> : (vector<3xi1>, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "variable_array", visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.array<10 x i32>}> : (i32) -> !llvm.ptr
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

