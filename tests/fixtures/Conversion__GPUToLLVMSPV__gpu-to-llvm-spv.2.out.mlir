module {
  gpu.module @builtins {
    llvm.func spir_funccc @_Z14get_num_groupsj(i32) -> i32 attributes {memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return}
    llvm.func spir_funccc @_Z12get_local_idj(i32) -> i32 attributes {memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return}
    llvm.func spir_funccc @_Z14get_local_sizej(i32) -> i32 attributes {memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return}
    llvm.func spir_funccc @_Z13get_global_idj(i32) -> i32 attributes {memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return}
    llvm.func spir_funccc @_Z12get_group_idj(i32) -> i32 attributes {memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return}
    func.func @gpu_block_id() -> (index, index, index) {
      %0 = llvm.mlir.constant(0 : i32) : i32
      %1 = llvm.call spir_funccc @_Z12get_group_idj(%0) {memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return} : (i32) -> i32
      %2 = builtin.unrealized_conversion_cast %1 : i32 to index
      %3 = llvm.mlir.constant(1 : i32) : i32
      %4 = llvm.call spir_funccc @_Z12get_group_idj(%3) {memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return} : (i32) -> i32
      %5 = builtin.unrealized_conversion_cast %4 : i32 to index
      %6 = llvm.mlir.constant(2 : i32) : i32
      %7 = llvm.call spir_funccc @_Z12get_group_idj(%6) {memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return} : (i32) -> i32
      %8 = builtin.unrealized_conversion_cast %7 : i32 to index
      return %2, %5, %8 : index, index, index
    }
    func.func @gpu_global_id() -> (index, index, index) {
      %0 = llvm.mlir.constant(0 : i32) : i32
      %1 = llvm.call spir_funccc @_Z13get_global_idj(%0) {memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return} : (i32) -> i32
      %2 = builtin.unrealized_conversion_cast %1 : i32 to index
      %3 = llvm.mlir.constant(1 : i32) : i32
      %4 = llvm.call spir_funccc @_Z13get_global_idj(%3) {memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return} : (i32) -> i32
      %5 = builtin.unrealized_conversion_cast %4 : i32 to index
      %6 = llvm.mlir.constant(2 : i32) : i32
      %7 = llvm.call spir_funccc @_Z13get_global_idj(%6) {memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return} : (i32) -> i32
      %8 = builtin.unrealized_conversion_cast %7 : i32 to index
      return %2, %5, %8 : index, index, index
    }
    func.func @gpu_block_dim() -> (index, index, index) {
      %0 = llvm.mlir.constant(0 : i32) : i32
      %1 = llvm.call spir_funccc @_Z14get_local_sizej(%0) {memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return} : (i32) -> i32
      %2 = builtin.unrealized_conversion_cast %1 : i32 to index
      %3 = llvm.mlir.constant(1 : i32) : i32
      %4 = llvm.call spir_funccc @_Z14get_local_sizej(%3) {memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return} : (i32) -> i32
      %5 = builtin.unrealized_conversion_cast %4 : i32 to index
      %6 = llvm.mlir.constant(2 : i32) : i32
      %7 = llvm.call spir_funccc @_Z14get_local_sizej(%6) {memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return} : (i32) -> i32
      %8 = builtin.unrealized_conversion_cast %7 : i32 to index
      return %2, %5, %8 : index, index, index
    }
    func.func @gpu_thread_id() -> (index, index, index) {
      %0 = llvm.mlir.constant(0 : i32) : i32
      %1 = llvm.call spir_funccc @_Z12get_local_idj(%0) {memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return} : (i32) -> i32
      %2 = builtin.unrealized_conversion_cast %1 : i32 to index
      %3 = llvm.mlir.constant(1 : i32) : i32
      %4 = llvm.call spir_funccc @_Z12get_local_idj(%3) {memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return} : (i32) -> i32
      %5 = builtin.unrealized_conversion_cast %4 : i32 to index
      %6 = llvm.mlir.constant(2 : i32) : i32
      %7 = llvm.call spir_funccc @_Z12get_local_idj(%6) {memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return} : (i32) -> i32
      %8 = builtin.unrealized_conversion_cast %7 : i32 to index
      return %2, %5, %8 : index, index, index
    }
    func.func @gpu_grid_dim() -> (index, index, index) {
      %0 = llvm.mlir.constant(0 : i32) : i32
      %1 = llvm.call spir_funccc @_Z14get_num_groupsj(%0) {memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return} : (i32) -> i32
      %2 = builtin.unrealized_conversion_cast %1 : i32 to index
      %3 = llvm.mlir.constant(1 : i32) : i32
      %4 = llvm.call spir_funccc @_Z14get_num_groupsj(%3) {memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return} : (i32) -> i32
      %5 = builtin.unrealized_conversion_cast %4 : i32 to index
      %6 = llvm.mlir.constant(2 : i32) : i32
      %7 = llvm.call spir_funccc @_Z14get_num_groupsj(%6) {memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return} : (i32) -> i32
      %8 = builtin.unrealized_conversion_cast %7 : i32 to index
      return %2, %5, %8 : index, index, index
    }
  }
}

// -----
module {
  gpu.module @barriers {
    llvm.func spir_funccc @_Z7barrierj(i32) attributes {convergent, no_unwind, will_return}
    func.func @gpu_barrier() {
      %0 = llvm.mlir.constant(3 : i32) : i32
      llvm.call spir_funccc @_Z7barrierj(%0) {convergent, no_unwind, will_return} : (i32) -> ()
      return
    }
  }
}

// -----
module {
  gpu.module @shuffles {
    llvm.func spir_funccc @_Z21sub_group_shuffle_xorcj(i8, i32) -> i8 attributes {convergent, no_unwind, will_return}
    llvm.func spir_funccc @_Z22sub_group_shuffle_downsj(i16, i32) -> i16 attributes {convergent, no_unwind, will_return}
    llvm.func spir_funccc @_Z22sub_group_shuffle_downdj(f64, i32) -> f64 attributes {convergent, no_unwind, will_return}
    llvm.func spir_funccc @_Z20sub_group_shuffle_upfj(f32, i32) -> f32 attributes {convergent, no_unwind, will_return}
    llvm.func spir_funccc @_Z20sub_group_shuffle_upDhj(f16, i32) -> f16 attributes {convergent, no_unwind, will_return}
    llvm.func spir_funccc @_Z21sub_group_shuffle_xorlj(i64, i32) -> i64 attributes {convergent, no_unwind, will_return}
    llvm.func spir_funccc @_Z17sub_group_shuffleij(i32, i32) -> i32 attributes {convergent, no_unwind, will_return}
    llvm.func spir_funccc @_Z21sub_group_shuffle_xorsj(i16, i32) -> i16 attributes {convergent, no_unwind, will_return}
    llvm.func spir_funccc @_Z17sub_group_shufflecj(i8, i32) -> i8 attributes {convergent, no_unwind, will_return}
    llvm.func @gpu_shuffles(%arg0: i8, %arg1: i16, %arg2: i32, %arg3: i64, %arg4: f16, %arg5: f32, %arg6: f64, %arg7: bf16, %arg8: i1, %arg9: i32) attributes {intel_reqd_sub_group_size = 16 : i32} {
      %c16_i32 = arith.constant 16 : i32
      %0 = llvm.call spir_funccc @_Z17sub_group_shufflecj(%arg0, %arg9) {convergent, no_unwind, will_return} : (i8, i32) -> i8
      %1 = llvm.mlir.constant(true) : i1
      %2 = llvm.call spir_funccc @_Z21sub_group_shuffle_xorsj(%arg1, %arg9) {convergent, no_unwind, will_return} : (i16, i32) -> i16
      %3 = llvm.mlir.constant(true) : i1
      %4 = llvm.call spir_funccc @_Z17sub_group_shuffleij(%arg2, %arg9) {convergent, no_unwind, will_return} : (i32, i32) -> i32
      %5 = llvm.mlir.constant(true) : i1
      %6 = llvm.call spir_funccc @_Z21sub_group_shuffle_xorlj(%arg3, %arg9) {convergent, no_unwind, will_return} : (i64, i32) -> i64
      %7 = llvm.mlir.constant(true) : i1
      %8 = llvm.call spir_funccc @_Z20sub_group_shuffle_upDhj(%arg4, %arg9) {convergent, no_unwind, will_return} : (f16, i32) -> f16
      %9 = llvm.mlir.constant(true) : i1
      %10 = llvm.call spir_funccc @_Z20sub_group_shuffle_upfj(%arg5, %arg9) {convergent, no_unwind, will_return} : (f32, i32) -> f32
      %11 = llvm.mlir.constant(true) : i1
      %12 = llvm.call spir_funccc @_Z22sub_group_shuffle_downdj(%arg6, %arg9) {convergent, no_unwind, will_return} : (f64, i32) -> f64
      %13 = llvm.mlir.constant(true) : i1
      %14 = llvm.bitcast %arg7 : bf16 to i16
      %15 = llvm.call spir_funccc @_Z22sub_group_shuffle_downsj(%14, %arg9) {convergent, no_unwind, will_return} : (i16, i32) -> i16
      %16 = llvm.bitcast %15 : i16 to bf16
      %17 = llvm.mlir.constant(true) : i1
      %18 = llvm.zext %arg8 : i1 to i8
      %19 = llvm.call spir_funccc @_Z21sub_group_shuffle_xorcj(%18, %arg9) {convergent, no_unwind, will_return} : (i8, i32) -> i8
      %20 = llvm.trunc %19 : i8 to i1
      %21 = llvm.mlir.constant(true) : i1
      llvm.return
    }
  }
}

// -----
// -----
// -----
// -----
module {
  gpu.module @kernels {
    llvm.func spir_funccc @no_kernel() {
      llvm.return
    }
    llvm.func spir_kernelcc @kernel_no_arg() attributes {gpu.kernel} {
      llvm.return
    }
    llvm.func spir_kernelcc @kernel_with_args(%arg0: f32, %arg1: i64) attributes {gpu.kernel} {
      llvm.return
    }
    llvm.func spir_kernelcc @kernel_with_conv_args(%arg0: i32, %arg1: !llvm.ptr<1>, %arg2: !llvm.ptr<1>, %arg3: i32) attributes {gpu.kernel} {
      llvm.return
    }
    llvm.func spir_kernelcc @kernel_with_sized_memref(%arg0: !llvm.ptr<1>, %arg1: !llvm.ptr<1>, %arg2: i32, %arg3: i32, %arg4: i32) attributes {gpu.kernel} {
      llvm.return
    }
    llvm.func spir_kernelcc @kernel_with_ND_memref(%arg0: !llvm.ptr<1>, %arg1: !llvm.ptr<1>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32) attributes {gpu.kernel} {
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @kernels {
    llvm.func spir_kernelcc @kernel_with_private_attributions() attributes {gpu.kernel} {
      %0 = llvm.mlir.constant(32 : i64) : i64
      %1 = llvm.alloca %0 x f32 : (i64) -> !llvm.ptr
      %2 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %5 = llvm.mlir.constant(0 : index) : i32
      %6 = llvm.insertvalue %5, %4[2] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %7 = llvm.mlir.constant(32 : index) : i32
      %8 = llvm.insertvalue %7, %6[3, 0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %9 = llvm.mlir.constant(1 : index) : i32
      %10 = llvm.insertvalue %9, %8[4, 0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %11 = llvm.mlir.constant(16 : i64) : i64
      %12 = llvm.alloca %11 x i16 : (i64) -> !llvm.ptr
      %13 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %14 = llvm.insertvalue %12, %13[0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %15 = llvm.insertvalue %12, %14[1] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %16 = llvm.mlir.constant(0 : index) : i32
      %17 = llvm.insertvalue %16, %15[2] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %18 = llvm.mlir.constant(16 : index) : i32
      %19 = llvm.insertvalue %18, %17[3, 0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %20 = llvm.mlir.constant(1 : index) : i32
      %21 = llvm.insertvalue %20, %19[4, 0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      llvm.return
    }
    llvm.func spir_kernelcc @kernel_with_workgoup_attributions(%arg0: !llvm.ptr<3> {llvm.noalias, llvm.workgroup_attribution = #llvm.mlir.workgroup_attribution<32 : i64, f32>}, %arg1: !llvm.ptr<3> {llvm.noalias, llvm.workgroup_attribution = #llvm.mlir.workgroup_attribution<16 : i64, i16>}) attributes {gpu.kernel} {
      %0 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %2 = llvm.insertvalue %arg0, %1[1] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %3 = llvm.mlir.constant(0 : index) : i32
      %4 = llvm.insertvalue %3, %2[2] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %5 = llvm.mlir.constant(32 : index) : i32
      %6 = llvm.insertvalue %5, %4[3, 0] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %7 = llvm.mlir.constant(1 : index) : i32
      %8 = llvm.insertvalue %7, %6[4, 0] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %9 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %10 = llvm.insertvalue %arg1, %9[0] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %11 = llvm.insertvalue %arg1, %10[1] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %12 = llvm.mlir.constant(0 : index) : i32
      %13 = llvm.insertvalue %12, %11[2] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %14 = llvm.mlir.constant(16 : index) : i32
      %15 = llvm.insertvalue %14, %13[3, 0] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %16 = llvm.mlir.constant(1 : index) : i32
      %17 = llvm.insertvalue %16, %15[4, 0] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      llvm.return
    }
    llvm.func spir_kernelcc @kernel_with_both_attributions(%arg0: !llvm.ptr<3> {llvm.noalias, llvm.workgroup_attribution = #llvm.mlir.workgroup_attribution<8 : i64, f32>}, %arg1: !llvm.ptr<3> {llvm.noalias, llvm.workgroup_attribution = #llvm.mlir.workgroup_attribution<16 : i64, i32>}) attributes {gpu.kernel} {
      %0 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %2 = llvm.insertvalue %arg0, %1[1] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %3 = llvm.mlir.constant(0 : index) : i32
      %4 = llvm.insertvalue %3, %2[2] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %5 = llvm.mlir.constant(8 : index) : i32
      %6 = llvm.insertvalue %5, %4[3, 0] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %7 = llvm.mlir.constant(1 : index) : i32
      %8 = llvm.insertvalue %7, %6[4, 0] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %9 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)>
      %10 = llvm.insertvalue %arg1, %9[0] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %11 = llvm.insertvalue %arg1, %10[1] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %12 = llvm.mlir.constant(0 : index) : i32
      %13 = llvm.insertvalue %12, %11[2] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %14 = llvm.mlir.constant(16 : index) : i32
      %15 = llvm.insertvalue %14, %13[3, 0] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %16 = llvm.mlir.constant(1 : index) : i32
      %17 = llvm.insertvalue %16, %15[4, 0] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<1 x i32>, array<1 x i32>)> 
      %18 = llvm.mlir.constant(32 : i64) : i64
      %19 = llvm.alloca %18 x i32 : (i64) -> !llvm.ptr
      %20 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %21 = llvm.insertvalue %19, %20[0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %22 = llvm.insertvalue %19, %21[1] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %23 = llvm.mlir.constant(0 : index) : i32
      %24 = llvm.insertvalue %23, %22[2] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %25 = llvm.mlir.constant(32 : index) : i32
      %26 = llvm.insertvalue %25, %24[3, 0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %27 = llvm.mlir.constant(1 : index) : i32
      %28 = llvm.insertvalue %27, %26[4, 0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %29 = llvm.mlir.constant(32 : i64) : i64
      %30 = llvm.alloca %29 x i32 : (i64) -> !llvm.ptr
      %31 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
      %32 = llvm.insertvalue %30, %31[0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %33 = llvm.insertvalue %30, %32[1] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %34 = llvm.mlir.constant(0 : index) : i32
      %35 = llvm.insertvalue %34, %33[2] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %36 = llvm.mlir.constant(32 : index) : i32
      %37 = llvm.insertvalue %36, %35[3, 0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      %38 = llvm.mlir.constant(1 : index) : i32
      %39 = llvm.insertvalue %38, %37[4, 0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
      llvm.return
    }
    llvm.func spir_kernelcc @kernel_known_block_size() attributes {gpu.kernel, gpu.known_block_size = array<i32: 128, 128, 256>, reqd_work_group_size = array<i32: 128, 128, 256>} {
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @kernels {
    llvm.func spir_funccc @address_spaces(%arg0: !llvm.ptr<1>, %arg1: !llvm.ptr<1>, %arg2: i32, %arg3: !llvm.ptr<3>, %arg4: !llvm.ptr<3>, %arg5: i32, %arg6: !llvm.ptr, %arg7: !llvm.ptr, %arg8: i32) {
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @kernels {
    llvm.func spir_funccc @_Z12get_group_idj(i32) -> i32 attributes {memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return}
    llvm.func spir_funccc @no_address_spaces(%arg0: !llvm.ptr<1>, %arg1: !llvm.ptr<1>, %arg2: i32, %arg3: !llvm.ptr<1>, %arg4: !llvm.ptr<1>, %arg5: i32, %arg6: !llvm.ptr<1>, %arg7: !llvm.ptr<1>, %arg8: i32) {
      llvm.return
    }
    llvm.func spir_kernelcc @no_address_spaces_complex(%arg0: !llvm.ptr<1>, %arg1: !llvm.ptr<1>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: !llvm.ptr<1>, %arg8: !llvm.ptr<1>, %arg9: i32, %arg10: i32, %arg11: i32) attributes {gpu.kernel} {
      %0 = llvm.mlir.poison : !llvm.struct<(ptr<1>, ptr<1>, i32, array<1 x i32>, array<1 x i32>)>
      %1 = llvm.insertvalue %arg7, %0[0] : !llvm.struct<(ptr<1>, ptr<1>, i32, array<1 x i32>, array<1 x i32>)> 
      %2 = llvm.insertvalue %arg8, %1[1] : !llvm.struct<(ptr<1>, ptr<1>, i32, array<1 x i32>, array<1 x i32>)> 
      %3 = llvm.insertvalue %arg9, %2[2] : !llvm.struct<(ptr<1>, ptr<1>, i32, array<1 x i32>, array<1 x i32>)> 
      %4 = llvm.insertvalue %arg10, %3[3, 0] : !llvm.struct<(ptr<1>, ptr<1>, i32, array<1 x i32>, array<1 x i32>)> 
      %5 = llvm.insertvalue %arg11, %4[4, 0] : !llvm.struct<(ptr<1>, ptr<1>, i32, array<1 x i32>, array<1 x i32>)> 
      %6 = builtin.unrealized_conversion_cast %5 : !llvm.struct<(ptr<1>, ptr<1>, i32, array<1 x i32>, array<1 x i32>)> to memref<4xf32, 1>
      %7 = llvm.mlir.poison : !llvm.struct<(ptr<1>, ptr<1>, i32, array<2 x i32>, array<2 x i32>)>
      %8 = llvm.insertvalue %arg0, %7[0] : !llvm.struct<(ptr<1>, ptr<1>, i32, array<2 x i32>, array<2 x i32>)> 
      %9 = llvm.insertvalue %arg1, %8[1] : !llvm.struct<(ptr<1>, ptr<1>, i32, array<2 x i32>, array<2 x i32>)> 
      %10 = llvm.insertvalue %arg2, %9[2] : !llvm.struct<(ptr<1>, ptr<1>, i32, array<2 x i32>, array<2 x i32>)> 
      %11 = llvm.insertvalue %arg3, %10[3, 0] : !llvm.struct<(ptr<1>, ptr<1>, i32, array<2 x i32>, array<2 x i32>)> 
      %12 = llvm.insertvalue %arg5, %11[4, 0] : !llvm.struct<(ptr<1>, ptr<1>, i32, array<2 x i32>, array<2 x i32>)> 
      %13 = llvm.insertvalue %arg4, %12[3, 1] : !llvm.struct<(ptr<1>, ptr<1>, i32, array<2 x i32>, array<2 x i32>)> 
      %14 = llvm.insertvalue %arg6, %13[4, 1] : !llvm.struct<(ptr<1>, ptr<1>, i32, array<2 x i32>, array<2 x i32>)> 
      %15 = builtin.unrealized_conversion_cast %14 : !llvm.struct<(ptr<1>, ptr<1>, i32, array<2 x i32>, array<2 x i32>)> to memref<2x2xf32, 1>
      func.call @no_address_spaces_callee(%15, %6) : (memref<2x2xf32, 1>, memref<4xf32, 1>) -> ()
      llvm.return
    }
    func.func @no_address_spaces_callee(%arg0: memref<2x2xf32, 1>, %arg1: memref<4xf32, 1>) {
      %0 = llvm.mlir.constant(0 : i32) : i32
      %1 = llvm.call spir_funccc @_Z12get_group_idj(%0) {memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, no_unwind, will_return} : (i32) -> i32
      %2 = builtin.unrealized_conversion_cast %1 : i32 to index
      %3 = memref.load %arg0[%2, %2] : memref<2x2xf32, 1>
      memref.store %3, %arg1[%2] : memref<4xf32, 1>
      return
    }
  }
}

// -----
module {
  gpu.module @subgroup_operations {
    llvm.func spir_funccc @_Z18get_sub_group_size() -> i32 attributes {no_unwind, will_return}
    llvm.func spir_funccc @_Z18get_num_sub_groups() -> i32 attributes {no_unwind, will_return}
    llvm.func spir_funccc @_Z22get_sub_group_local_id() -> i32 attributes {no_unwind, will_return}
    llvm.func spir_funccc @_Z16get_sub_group_id() -> i32 attributes {no_unwind, will_return}
    func.func @gpu_subgroup() {
      %0 = llvm.call spir_funccc @_Z16get_sub_group_id() {no_unwind, will_return} : () -> i32
      %1 = llvm.call spir_funccc @_Z22get_sub_group_local_id() {no_unwind, will_return} : () -> i32
      %2 = llvm.call spir_funccc @_Z18get_num_sub_groups() {no_unwind, will_return} : () -> i32
      %3 = llvm.call spir_funccc @_Z18get_sub_group_size() {no_unwind, will_return} : () -> i32
      return
    }
  }
}

