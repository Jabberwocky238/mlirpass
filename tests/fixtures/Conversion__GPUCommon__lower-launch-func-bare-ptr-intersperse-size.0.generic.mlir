"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64)>, linkage = #llvm.linkage<external>, sym_name = "malloc", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  }) : () -> ()
  "gpu.binary"() <{objects = [#gpu.object<#spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>, "">], offloadingHandler = #gpu.select_object, sym_name = "kernels"}> : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %2 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %3 = "builtin.unrealized_conversion_cast"(%0) : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> memref<8xf32>
    %4 = "builtin.unrealized_conversion_cast"(%1) : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> memref<8x8xi32>
    %5 = "builtin.unrealized_conversion_cast"(%1) : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> memref<4x12xi8>
    %6 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %7 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %8 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %9 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
    %10 = "llvm.mlir.constant"() <{value = 256 : index}> : () -> i64
    %11 = "llvm.mlir.constant"() <{value = 48 : index}> : () -> i64
    "gpu.launch_func"(%2, %2, %2, %2, %2, %2, %6, %9, %7, %10, %8, %11) <{kernel = @kernels::@kernel_add, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 6, 0>}> : (i64, i64, i64, i64, i64, i64, !llvm.ptr, i64, !llvm.ptr, i64, !llvm.ptr, i64) -> ()
    "llvm.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_main", visibility_ = 0 : i64}> ({
    "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @main, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
    "llvm.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

