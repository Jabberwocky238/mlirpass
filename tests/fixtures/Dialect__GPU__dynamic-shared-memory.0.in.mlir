"builtin.module"() ({
  "gpu.module"() <{sym_name = "modules"}> ({
    "llvm.mlir.global"() <{addr_space = 3 : i32, alignment = 4 : i64, global_type = !llvm.array<0 x i8>, linkage = #llvm.linkage<internal>, sym_name = "__dynamic_shmem__0", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.mlir.global"() <{addr_space = 3 : i32, alignment = 4 : i64, global_type = !llvm.array<0 x i8>, linkage = #llvm.linkage<internal>, sym_name = "__dynamic_shmem__1", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.mlir.global"() <{addr_space = 0 : i32, alignment = 16 : i64, global_type = !llvm.array<0 x i8>, linkage = #llvm.linkage<internal>, sym_name = "__dynamic_shmem__2", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    }) : () -> ()
    "gpu.func"() <{function_type = (index) -> ()}> ({
    ^bb0(%arg0: index):
      %6 = "arith.constant"() <{value = 1 : index}> : () -> index
      %7 = "arith.constant"() <{value = 8192 : index}> : () -> index
      %8 = "arith.constant"() <{value = 16384 : index}> : () -> index
      %9 = "gpu.dynamic_shared_memory"() : () -> memref<?xi8, #gpu.address_space<workgroup>>
      %10 = "gpu.dynamic_shared_memory"() : () -> memref<?xi8, #gpu.address_space<workgroup>>
      %11 = "memref.view"(%9, %7) : (memref<?xi8, #gpu.address_space<workgroup>>, index) -> memref<32x64xf32, #gpu.address_space<workgroup>>
      "test.use.shared.memory"(%11) : (memref<32x64xf32, #gpu.address_space<workgroup>>) -> ()
      %12 = "memref.view"(%9, %8) : (memref<?xi8, #gpu.address_space<workgroup>>, index) -> memref<32x64xf32, #gpu.address_space<workgroup>>
      "test.use.shared.memory"(%12) : (memref<32x64xf32, #gpu.address_space<workgroup>>) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, gpu.known_block_size = array<i32: 1, 1, 1>, gpu.known_grid_size = array<i32: 1, 1, 1>, sym_name = "dynamic_shared_memory_kernel", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = () -> ()}> ({
      %3 = "arith.constant"() <{value = 8192 : index}> : () -> index
      %4 = "gpu.dynamic_shared_memory"() : () -> memref<?xi8, #gpu.address_space<workgroup>>
      %5 = "memref.view"(%4, %3) : (memref<?xi8, #gpu.address_space<workgroup>>, index) -> memref<32x64xf32, #gpu.address_space<workgroup>>
      "test.use.shared.memory"(%5) : (memref<32x64xf32, #gpu.address_space<workgroup>>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "gpu_device_function", workgroup_attributions = 0 : i64} : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "func_device_function"}> ({
      %0 = "arith.constant"() <{value = 8192 : index}> : () -> index
      %1 = "gpu.dynamic_shared_memory"() : () -> memref<?xi8, #gpu.address_space<workgroup>>
      %2 = "memref.view"(%1, %0) : (memref<?xi8, #gpu.address_space<workgroup>>, index) -> memref<32x64xf32, #gpu.address_space<workgroup>>
      "test.use.shared.memory"(%2) : (memref<32x64xf32, #gpu.address_space<workgroup>>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

