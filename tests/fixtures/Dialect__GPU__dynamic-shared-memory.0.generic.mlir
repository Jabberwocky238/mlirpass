"builtin.module"() ({
  "gpu.module"() <{sym_name = "modules"}> ({
    "llvm.mlir.global"() <{addr_space = 3 : i32, alignment = 16 : i64, global_type = !llvm.array<0 x i8>, linkage = #llvm.linkage<internal>, sym_name = "__dynamic_shmem__3", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.mlir.global"() <{addr_space = 3 : i32, alignment = 4 : i64, global_type = !llvm.array<0 x i8>, linkage = #llvm.linkage<internal>, sym_name = "__dynamic_shmem__0", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.mlir.global"() <{addr_space = 3 : i32, alignment = 4 : i64, global_type = !llvm.array<0 x i8>, linkage = #llvm.linkage<internal>, sym_name = "__dynamic_shmem__1", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.mlir.global"() <{addr_space = 0 : i32, alignment = 16 : i64, global_type = !llvm.array<0 x i8>, linkage = #llvm.linkage<internal>, sym_name = "__dynamic_shmem__2", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "dynamic_shared_memory_kernel", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: i64):
      %30 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
      %31 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
      %32 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %33 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %34 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %35 = "llvm.mlir.addressof"() <{global_name = @__dynamic_shmem__3}> : () -> !llvm.ptr<3>
      %36 = "llvm.insertvalue"(%32, %35) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %37 = "llvm.getelementptr"(%35) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 8192>}> : (!llvm.ptr<3>) -> !llvm.ptr<3>
      %38 = "llvm.insertvalue"(%36, %37) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %39 = "llvm.insertvalue"(%38, %34) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %40 = "llvm.insertvalue"(%39, %31) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %41 = "llvm.insertvalue"(%40, %33) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %42 = "llvm.insertvalue"(%41, %30) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %43 = "llvm.insertvalue"(%42, %31) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %44 = "builtin.unrealized_conversion_cast"(%43) : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>) -> memref<32x64xf32, #gpu.address_space<workgroup>>
      "test.use.shared.memory"(%44) : (memref<32x64xf32, #gpu.address_space<workgroup>>) -> ()
      %45 = "llvm.getelementptr"(%35) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 16384>}> : (!llvm.ptr<3>) -> !llvm.ptr<3>
      %46 = "llvm.insertvalue"(%36, %45) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %47 = "llvm.insertvalue"(%46, %34) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %48 = "llvm.insertvalue"(%47, %31) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %49 = "llvm.insertvalue"(%48, %33) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %50 = "llvm.insertvalue"(%49, %30) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %51 = "llvm.insertvalue"(%50, %31) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %52 = "builtin.unrealized_conversion_cast"(%51) : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>) -> memref<32x64xf32, #gpu.address_space<workgroup>>
      "test.use.shared.memory"(%52) : (memref<32x64xf32, #gpu.address_space<workgroup>>) -> ()
      "llvm.return"() : () -> ()
    }) {gpu.kernel, gpu.known_block_size = array<i32: 1, 1, 1>, gpu.known_grid_size = array<i32: 1, 1, 1>, nvvm.kernel} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_device_function", visibility_ = 0 : i64}> ({
      %15 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
      %16 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
      %17 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %18 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %19 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %20 = "llvm.mlir.addressof"() <{global_name = @__dynamic_shmem__3}> : () -> !llvm.ptr<3>
      %21 = "llvm.insertvalue"(%17, %20) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %22 = "llvm.getelementptr"(%20) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 8192>}> : (!llvm.ptr<3>) -> !llvm.ptr<3>
      %23 = "llvm.insertvalue"(%21, %22) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %24 = "llvm.insertvalue"(%23, %19) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %25 = "llvm.insertvalue"(%24, %16) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %26 = "llvm.insertvalue"(%25, %18) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %27 = "llvm.insertvalue"(%26, %15) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %28 = "llvm.insertvalue"(%27, %16) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %29 = "builtin.unrealized_conversion_cast"(%28) : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>) -> memref<32x64xf32, #gpu.address_space<workgroup>>
      "test.use.shared.memory"(%29) : (memref<32x64xf32, #gpu.address_space<workgroup>>) -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "func_device_function", visibility_ = 0 : i64}> ({
      %0 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
      %1 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
      %2 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %3 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
      %4 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
      %5 = "llvm.mlir.addressof"() <{global_name = @__dynamic_shmem__3}> : () -> !llvm.ptr<3>
      %6 = "llvm.insertvalue"(%2, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %7 = "llvm.getelementptr"(%5) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 8192>}> : (!llvm.ptr<3>) -> !llvm.ptr<3>
      %8 = "llvm.insertvalue"(%6, %7) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %9 = "llvm.insertvalue"(%8, %4) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %10 = "llvm.insertvalue"(%9, %1) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %11 = "llvm.insertvalue"(%10, %3) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %12 = "llvm.insertvalue"(%11, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %13 = "llvm.insertvalue"(%12, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
      %14 = "builtin.unrealized_conversion_cast"(%13) : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>) -> memref<32x64xf32, #gpu.address_space<workgroup>>
      "test.use.shared.memory"(%14) : (memref<32x64xf32, #gpu.address_space<workgroup>>) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_func_device_function", visibility_ = 0 : i64}> ({
      "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @func_device_function, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
}) : () -> ()

