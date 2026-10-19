module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
  llvm.func @malloc(i64) -> !llvm.ptr
  gpu.binary @kernels  [#gpu.object<#spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>, "">]
  llvm.func @main() attributes {llvm.emit_c_interface} {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %2 = llvm.mlir.constant(1 : index) : i64
    %3 = builtin.unrealized_conversion_cast %0 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<8xf32>
    %4 = builtin.unrealized_conversion_cast %1 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> to memref<8x8xi32>
    %5 = builtin.unrealized_conversion_cast %1 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> to memref<4x12xi8>
    %6 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %7 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %9 = llvm.mlir.constant(32 : index) : i64
    %10 = llvm.mlir.constant(256 : index) : i64
    %11 = llvm.mlir.constant(48 : index) : i64
    gpu.launch_func  @kernels::@kernel_add blocks in (%2, %2, %2) threads in (%2, %2, %2) : i64 args(%6 : !llvm.ptr, %9 : i64, %7 : !llvm.ptr, %10 : i64, %8 : !llvm.ptr, %11 : i64)
    llvm.return
  }
  llvm.func @_mlir_ciface_main() attributes {llvm.emit_c_interface} {
    llvm.call @main() : () -> ()
    llvm.return
  }
}

