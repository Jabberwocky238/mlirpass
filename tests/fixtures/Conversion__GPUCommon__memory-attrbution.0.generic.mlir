"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32)>, linkage = #llvm.linkage<external>, sym_name = "private", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: f32):
      %0 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
      %1 = "llvm.alloca"(%0) <{elem_type = f32}> : (i64) -> !llvm.ptr
      %2 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %3 = "llvm.insertvalue"(%2, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %4 = "llvm.insertvalue"(%3, %1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %5 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %6 = "llvm.insertvalue"(%4, %5) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %7 = "llvm.mlir.constant"() <{value = 4 : index}> : () -> i64
      %8 = "llvm.insertvalue"(%6, %7) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %9 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %11 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %12 = "llvm.extractvalue"(%10) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
      %13 = "llvm.getelementptr"(%12, %11) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
      "llvm.store"(%arg0, %13) <{ordering = 0 : i64}> : (f32, !llvm.ptr) -> ()
      "terminator"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "llvm.mlir.global"() <{addr_space = 3 : i32, global_type = !llvm.array<4 x f32>, linkage = #llvm.linkage<internal>, sym_name = "__wg_workgroup_0", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32)>, linkage = #llvm.linkage<external>, sym_name = "workgroup", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: f32):
      %0 = "llvm.mlir.addressof"() <{global_name = @__wg_workgroup_0}> : () -> !llvm.ptr<3>
      %1 = "llvm.getelementptr"(%0) <{elem_type = !llvm.array<4 x f32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr<3>) -> !llvm.ptr<3>
      %2 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %3 = "llvm.insertvalue"(%2, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %4 = "llvm.insertvalue"(%3, %1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %5 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %6 = "llvm.insertvalue"(%4, %5) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %7 = "llvm.mlir.constant"() <{value = 4 : index}> : () -> i64
      %8 = "llvm.insertvalue"(%6, %7) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %9 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %11 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %12 = "llvm.extractvalue"(%10) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %13 = "llvm.getelementptr"(%12, %11) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      "llvm.store"(%arg0, %13) <{ordering = 0 : i64}> : (f32, !llvm.ptr<3>) -> ()
      "terminator"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "llvm.mlir.global"() <{addr_space = 3 : i32, global_type = !llvm.array<48 x f32>, linkage = #llvm.linkage<internal>, sym_name = "__wg_workgroup3d_0", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32)>, linkage = #llvm.linkage<external>, sym_name = "workgroup3d", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: f32):
      %0 = "llvm.mlir.addressof"() <{global_name = @__wg_workgroup3d_0}> : () -> !llvm.ptr<3>
      %1 = "llvm.getelementptr"(%0) <{elem_type = !llvm.array<48 x f32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr<3>) -> !llvm.ptr<3>
      %2 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)>
      %3 = "llvm.insertvalue"(%2, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)>
      %4 = "llvm.insertvalue"(%3, %1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)>
      %5 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %6 = "llvm.insertvalue"(%4, %5) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)>
      %7 = "llvm.mlir.constant"() <{value = 4 : index}> : () -> i64
      %8 = "llvm.insertvalue"(%6, %7) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)>
      %9 = "llvm.mlir.constant"() <{value = 12 : index}> : () -> i64
      %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)>
      %11 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
      %12 = "llvm.insertvalue"(%10, %11) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)>
      %13 = "llvm.mlir.constant"() <{value = 6 : index}> : () -> i64
      %14 = "llvm.insertvalue"(%12, %13) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)>
      %15 = "llvm.mlir.constant"() <{value = 6 : index}> : () -> i64
      %16 = "llvm.insertvalue"(%14, %15) <{position = array<i64: 3, 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)>
      %17 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %18 = "llvm.insertvalue"(%16, %17) <{position = array<i64: 4, 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)>
      %19 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %20 = "llvm.extractvalue"(%18) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)>) -> !llvm.ptr<3>
      %21 = "llvm.mlir.constant"() <{value = 12 : index}> : () -> i64
      %22 = "llvm.mul"(%19, %21) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
      %23 = "llvm.mlir.constant"() <{value = 6 : index}> : () -> i64
      %24 = "llvm.mul"(%19, %23) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
      %25 = "llvm.add"(%22, %24) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
      %26 = "llvm.add"(%25, %19) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
      %27 = "llvm.getelementptr"(%20, %26) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      "llvm.store"(%arg0, %27) <{ordering = 0 : i64}> : (f32, !llvm.ptr<3>) -> ()
      "terminator"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "llvm.mlir.global"() <{addr_space = 3 : i32, global_type = !llvm.array<1 x f32>, linkage = #llvm.linkage<internal>, sym_name = "__wg_multiple_0", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.mlir.global"() <{addr_space = 3 : i32, global_type = !llvm.array<2 x f32>, linkage = #llvm.linkage<internal>, sym_name = "__wg_multiple_1", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32)>, linkage = #llvm.linkage<external>, sym_name = "multiple", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: f32):
      %0 = "llvm.mlir.addressof"() <{global_name = @__wg_multiple_0}> : () -> !llvm.ptr<3>
      %1 = "llvm.getelementptr"(%0) <{elem_type = !llvm.array<1 x f32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr<3>) -> !llvm.ptr<3>
      %2 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %3 = "llvm.insertvalue"(%2, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %4 = "llvm.insertvalue"(%3, %1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %5 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %6 = "llvm.insertvalue"(%4, %5) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %7 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %8 = "llvm.insertvalue"(%6, %7) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %9 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %11 = "llvm.mlir.addressof"() <{global_name = @__wg_multiple_1}> : () -> !llvm.ptr<3>
      %12 = "llvm.getelementptr"(%11) <{elem_type = !llvm.array<2 x f32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr<3>) -> !llvm.ptr<3>
      %13 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %14 = "llvm.insertvalue"(%13, %12) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %15 = "llvm.insertvalue"(%14, %12) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %16 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %17 = "llvm.insertvalue"(%15, %16) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %18 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
      %19 = "llvm.insertvalue"(%17, %18) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %20 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %21 = "llvm.insertvalue"(%19, %20) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %22 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
      %23 = "llvm.alloca"(%22) <{elem_type = f32}> : (i64) -> !llvm.ptr
      %24 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %25 = "llvm.insertvalue"(%24, %23) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %26 = "llvm.insertvalue"(%25, %23) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %27 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %28 = "llvm.insertvalue"(%26, %27) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %29 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
      %30 = "llvm.insertvalue"(%28, %29) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %31 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %32 = "llvm.insertvalue"(%30, %31) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %33 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
      %34 = "llvm.alloca"(%33) <{elem_type = f32}> : (i64) -> !llvm.ptr
      %35 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %36 = "llvm.insertvalue"(%35, %34) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %37 = "llvm.insertvalue"(%36, %34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %38 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %39 = "llvm.insertvalue"(%37, %38) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %40 = "llvm.mlir.constant"() <{value = 4 : index}> : () -> i64
      %41 = "llvm.insertvalue"(%39, %40) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %42 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %43 = "llvm.insertvalue"(%41, %42) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %44 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %45 = "llvm.extractvalue"(%10) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %46 = "llvm.getelementptr"(%45, %44) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      "llvm.store"(%arg0, %46) <{ordering = 0 : i64}> : (f32, !llvm.ptr<3>) -> ()
      %47 = "llvm.extractvalue"(%21) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %48 = "llvm.getelementptr"(%47, %44) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      "llvm.store"(%arg0, %48) <{ordering = 0 : i64}> : (f32, !llvm.ptr<3>) -> ()
      %49 = "llvm.extractvalue"(%32) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
      %50 = "llvm.getelementptr"(%49, %44) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
      "llvm.store"(%arg0, %50) <{ordering = 0 : i64}> : (f32, !llvm.ptr) -> ()
      %51 = "llvm.extractvalue"(%43) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
      %52 = "llvm.getelementptr"(%51, %44) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
      "llvm.store"(%arg0, %52) <{ordering = 0 : i64}> : (f32, !llvm.ptr) -> ()
      "terminator"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "llvm.mlir.global"() <{addr_space = 3 : i32, alignment = 8 : i64, global_type = !llvm.array<48 x f32>, linkage = #llvm.linkage<internal>, sym_name = "__wg_explicitAlign_0", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "explicitAlign", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: i64):
      %0 = "llvm.mlir.addressof"() <{global_name = @__wg_explicitAlign_0}> : () -> !llvm.ptr<3>
      %1 = "llvm.getelementptr"(%0) <{elem_type = !llvm.array<48 x f32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr<3>) -> !llvm.ptr<3>
      %2 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %3 = "llvm.insertvalue"(%2, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %4 = "llvm.insertvalue"(%3, %1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %5 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %6 = "llvm.insertvalue"(%4, %5) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %7 = "llvm.mlir.constant"() <{value = 48 : index}> : () -> i64
      %8 = "llvm.insertvalue"(%6, %7) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %9 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %11 = "llvm.mlir.constant"() <{value = 48 : i64}> : () -> i64
      %12 = "llvm.alloca"(%11) <{alignment = 4 : i64, elem_type = f32}> : (i64) -> !llvm.ptr
      %13 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %14 = "llvm.insertvalue"(%13, %12) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %15 = "llvm.insertvalue"(%14, %12) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %16 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %17 = "llvm.insertvalue"(%15, %16) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %18 = "llvm.mlir.constant"() <{value = 48 : index}> : () -> i64
      %19 = "llvm.insertvalue"(%17, %18) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %20 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %21 = "llvm.insertvalue"(%19, %20) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %22 = "llvm.extractvalue"(%10) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %23 = "llvm.getelementptr"(%22, %arg0) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      %24 = "llvm.load"(%23) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> f32
      %25 = "llvm.extractvalue"(%21) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
      %26 = "llvm.getelementptr"(%25, %arg0) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
      "llvm.store"(%24, %26) <{ordering = 0 : i64}> : (f32, !llvm.ptr) -> ()
      "terminator"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

