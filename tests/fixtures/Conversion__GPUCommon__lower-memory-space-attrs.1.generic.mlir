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
      "llvm.return"() : () -> ()
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
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (ptr<1>, ptr<1>, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "nested_memref", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr<1>, %arg1: !llvm.ptr<1>, %arg2: i64, %arg3: i64, %arg4: i64):
      %0 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
      %1 = "llvm.insertvalue"(%0, %arg0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<1>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
      %2 = "llvm.insertvalue"(%1, %arg1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<1>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
      %3 = "llvm.insertvalue"(%2, %arg2) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
      %4 = "llvm.insertvalue"(%3, %arg3) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
      %5 = "llvm.insertvalue"(%4, %arg4) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
      %6 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %7 = "llvm.extractvalue"(%5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<1>
      %8 = "llvm.getelementptr"(%7, %6) <{elem_type = !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>
      %9 = "llvm.load"(%8) <{ordering = 0 : i64}> : (!llvm.ptr<1>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
      %10 = "llvm.extractvalue"(%9) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<1>
      %11 = "llvm.getelementptr"(%10, %6) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>
      %12 = "llvm.load"(%11) <{ordering = 0 : i64}> : (!llvm.ptr<1>) -> f32
      "llvm.return"(%12) : (f32) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "llvm.mlir.global"() <{addr_space = 3 : i32, alignment = 16 : i64, global_type = !llvm.array<0 x i8>, linkage = #llvm.linkage<internal>, sym_name = "__dynamic_shmem__0", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "dynamic_shmem_with_vector", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64):
      %0 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %1 = "llvm.insertvalue"(%0, %arg0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %2 = "llvm.insertvalue"(%1, %arg1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %3 = "llvm.insertvalue"(%2, %arg2) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %4 = "llvm.insertvalue"(%3, %arg3) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %5 = "llvm.insertvalue"(%4, %arg4) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %6 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %7 = "llvm.mlir.addressof"() <{global_name = @__dynamic_shmem__0}> : () -> !llvm.ptr<3>
      %8 = "llvm.getelementptr"(%7) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0>}> : (!llvm.ptr<3>) -> !llvm.ptr<3>
      %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %10 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %11 = "llvm.mlir.zero"() : () -> !llvm.ptr
      %12 = "llvm.getelementptr"(%11, %9) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
      %13 = "llvm.ptrtoint"(%12) : (!llvm.ptr) -> i64
      %14 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %15 = "llvm.insertvalue"(%14, %8) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %16 = "llvm.insertvalue"(%15, %8) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %18 = "llvm.insertvalue"(%16, %17) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %19 = "llvm.insertvalue"(%18, %9) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %20 = "llvm.insertvalue"(%19, %10) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %21 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %22 = "llvm.extractvalue"(%20) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %23 = "llvm.insertvalue"(%21, %22) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %24 = "llvm.extractvalue"(%20) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %25 = "llvm.getelementptr"(%24, %6) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      %26 = "llvm.insertvalue"(%23, %25) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %27 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %28 = "llvm.insertvalue"(%26, %27) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %29 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %30 = "llvm.insertvalue"(%28, %29) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %31 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %32 = "llvm.insertvalue"(%30, %31) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %33 = "llvm.extractvalue"(%32) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %34 = "llvm.getelementptr"(%33, %6) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      %35 = "llvm.load"(%34) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr<3>) -> vector<1xf32>
      %36 = "llvm.extractvalue"(%5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
      %37 = "llvm.getelementptr"(%36, %6) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
      "llvm.store"(%35, %37) <{alignment = 4 : i64, ordering = 0 : i64}> : (vector<1xf32>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "llvm.mlir.global"() <{addr_space = 3 : i32, alignment = 16 : i64, global_type = !llvm.array<0 x i8>, linkage = #llvm.linkage<internal>, sym_name = "__dynamic_shmem__0", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32)>, linkage = #llvm.linkage<external>, sym_name = "dynamic_shmem", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: f32):
      %0 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %1 = "llvm.mlir.addressof"() <{global_name = @__dynamic_shmem__0}> : () -> !llvm.ptr<3>
      %2 = "llvm.getelementptr"(%1) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0>}> : (!llvm.ptr<3>) -> !llvm.ptr<3>
      %3 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %4 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %5 = "llvm.mlir.zero"() : () -> !llvm.ptr
      %6 = "llvm.getelementptr"(%5, %3) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
      %7 = "llvm.ptrtoint"(%6) : (!llvm.ptr) -> i64
      %8 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %9 = "llvm.insertvalue"(%8, %2) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %10 = "llvm.insertvalue"(%9, %2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %11 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %12 = "llvm.insertvalue"(%10, %11) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %13 = "llvm.insertvalue"(%12, %3) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %14 = "llvm.insertvalue"(%13, %4) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %15 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %16 = "llvm.extractvalue"(%14) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %17 = "llvm.insertvalue"(%15, %16) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %18 = "llvm.extractvalue"(%14) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %19 = "llvm.getelementptr"(%18, %0) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      %20 = "llvm.insertvalue"(%17, %19) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %21 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %22 = "llvm.insertvalue"(%20, %21) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %23 = "llvm.mlir.constant"() <{value = 4 : index}> : () -> i64
      %24 = "llvm.insertvalue"(%22, %23) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %25 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %26 = "llvm.insertvalue"(%24, %25) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
      %27 = "llvm.extractvalue"(%26) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
      %28 = "llvm.getelementptr"(%27, %0) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
      "llvm.store"(%arg0, %28) <{ordering = 0 : i64}> : (f32, !llvm.ptr<3>) -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

