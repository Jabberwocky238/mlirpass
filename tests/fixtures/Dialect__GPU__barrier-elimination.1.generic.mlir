"builtin.module"() ({
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg54: !transform.any_op):
      %55 = "transform.structured.match"(%arg54) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%55) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.gpu.eliminate_barriers"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index) -> (), sym_name = "read_read_write"}> ({
  ^bb0(%arg52: memref<?xf32>, %arg53: index):
    %52 = "memref.load"(%arg52, %arg53) : (memref<?xf32>, index) -> f32
    %53 = "memref.load"(%arg52, %arg53) : (memref<?xf32>, index) -> f32
    %54 = "arith.addf"(%52, %53) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    "memref.store"(%54, %arg52, %arg53) : (f32, memref<?xf32>, index) -> ()
    "func.return"() : () -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index, f32) -> f32, sym_name = "write_read_read"}> ({
  ^bb0(%arg49: memref<?xf32>, %arg50: index, %arg51: f32):
    "memref.store"(%arg51, %arg49, %arg50) : (f32, memref<?xf32>, index) -> ()
    "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    %49 = "memref.load"(%arg49, %arg50) : (memref<?xf32>, index) -> f32
    %50 = "memref.load"(%arg49, %arg50) : (memref<?xf32>, index) -> f32
    %51 = "arith.addf"(%49, %50) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%51) : (f32) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, f32) -> (), sym_name = "write_in_a_loop"}> ({
  ^bb0(%arg46: memref<?xf32>, %arg47: f32):
    %46 = "arith.constant"() <{value = 0 : index}> : () -> index
    %47 = "arith.constant"() <{value = 42 : index}> : () -> index
    %48 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%46, %47, %48) ({
    ^bb0(%arg48: index):
      "memref.store"(%arg47, %arg46, %arg48) : (f32, memref<?xf32>, index) -> ()
      "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, f32) -> (), sym_name = "read_read_write_loop"}> ({
  ^bb0(%arg43: memref<?xf32>, %arg44: f32):
    %40 = "arith.constant"() <{value = 0 : index}> : () -> index
    %41 = "arith.constant"() <{value = 42 : index}> : () -> index
    %42 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%40, %41, %42) ({
    ^bb0(%arg45: index):
      %43 = "memref.load"(%arg43, %arg45) : (memref<?xf32>, index) -> f32
      "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
      %44 = "memref.load"(%arg43, %arg45) : (memref<?xf32>, index) -> f32
      %45 = "arith.addf"(%43, %44) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
      "memref.store"(%45, %arg43, %arg45) : (f32, memref<?xf32>, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, f32) -> (), sym_name = "read_read_write_loop_trailing_sync"}> ({
  ^bb0(%arg40: memref<?xf32>, %arg41: f32):
    %34 = "arith.constant"() <{value = 0 : index}> : () -> index
    %35 = "arith.constant"() <{value = 42 : index}> : () -> index
    %36 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%34, %35, %36) ({
    ^bb0(%arg42: index):
      %37 = "memref.load"(%arg40, %arg42) : (memref<?xf32>, index) -> f32
      %38 = "memref.load"(%arg40, %arg42) : (memref<?xf32>, index) -> f32
      %39 = "arith.addf"(%37, %38) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
      "memref.store"(%39, %arg40, %arg42) : (f32, memref<?xf32>, index) -> ()
      "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, f32) -> (), sym_name = "read_read_write_loop_trailing_sync_non_memory_barrier"}> ({
  ^bb0(%arg37: memref<?xf32>, %arg38: f32):
    %28 = "arith.constant"() <{value = 0 : index}> : () -> index
    %29 = "arith.constant"() <{value = 42 : index}> : () -> index
    %30 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%28, %29, %30) ({
    ^bb0(%arg39: index):
      %31 = "memref.load"(%arg37, %arg39) : (memref<?xf32>, index) -> f32
      "gpu.barrier"() <{address_spaces = [], scope = #gpu.barrier_scope<workgroup>}> : () -> ()
      %32 = "memref.load"(%arg37, %arg39) : (memref<?xf32>, index) -> f32
      %33 = "arith.addf"(%31, %32) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
      "memref.store"(%33, %arg37, %arg39) : (f32, memref<?xf32>, index) -> ()
      "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (index, f32) -> (memref<42xf32>, memref<10xf32>), sym_name = "write_write_noalias"}> ({
  ^bb0(%arg35: index, %arg36: f32):
    %26 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<42xf32>
    %27 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    "memref.store"(%arg36, %26, %arg35) : (f32, memref<42xf32>, index) -> ()
    "memref.store"(%arg36, %27, %arg35) : (f32, memref<10xf32>, index) -> ()
    "func.return"(%26, %27) : (memref<42xf32>, memref<10xf32>) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (index, f32, memref<?xf32>) -> memref<42xf32>, sym_name = "write_write_alloc_arg_noalias"}> ({
  ^bb0(%arg32: index, %arg33: f32, %arg34: memref<?xf32>):
    %25 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<42xf32>
    "memref.store"(%arg33, %25, %arg32) : (f32, memref<42xf32>, index) -> ()
    "memref.store"(%arg33, %arg34, %arg32) : (f32, memref<?xf32>, index) -> ()
    "func.return"(%25) : (memref<42xf32>) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index, f32) -> f32, sym_name = "repeated_barrier"}> ({
  ^bb0(%arg29: memref<?xf32>, %arg30: index, %arg31: f32):
    %24 = "memref.load"(%arg29, %arg30) : (memref<?xf32>, index) -> f32
    "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    "memref.store"(%arg31, %arg29, %arg30) : (f32, memref<?xf32>, index) -> ()
    "func.return"(%24) : (f32) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (f32) -> (f32, f32, f32, f32, f32), sym_name = "symmetric_stop"}> ({
  ^bb0(%arg28: f32):
    %16 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    %17 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    %18 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    "memref.store"(%arg28, %16) : (f32, memref<f32>) -> ()
    "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    %19 = "memref.load"(%16) : (memref<f32>) -> f32
    "memref.store"(%arg28, %17) : (f32, memref<f32>) -> ()
    %20 = "memref.load"(%16) : (memref<f32>) -> f32
    "memref.store"(%arg28, %18) : (f32, memref<f32>) -> ()
    "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    %21 = "memref.load"(%16) : (memref<f32>) -> f32
    %22 = "memref.load"(%17) : (memref<f32>) -> f32
    %23 = "memref.load"(%18) : (memref<f32>) -> f32
    "func.return"(%19, %20, %21, %22, %23) : (f32, f32, f32, f32, f32) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "nested_loop_barrier_only"}> ({
    "func.return"() : () -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32, #gpu.address_space<global>>, index, f32) -> f32, sym_name = "workgroup_barrier_global_memory"}> ({
  ^bb0(%arg25: memref<?xf32, #gpu.address_space<global>>, %arg26: index, %arg27: f32):
    "memref.store"(%arg27, %arg25, %arg26) : (f32, memref<?xf32, #gpu.address_space<global>>, index) -> ()
    %15 = "memref.load"(%arg25, %arg26) : (memref<?xf32, #gpu.address_space<global>>, index) -> f32
    "func.return"(%15) : (f32) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32, #gpu.address_space<workgroup>>, index, f32) -> f32, sym_name = "workgroup_barrier_workgroup_memory"}> ({
  ^bb0(%arg22: memref<?xf32, #gpu.address_space<workgroup>>, %arg23: index, %arg24: f32):
    "memref.store"(%arg24, %arg22, %arg23) : (f32, memref<?xf32, #gpu.address_space<workgroup>>, index) -> ()
    "gpu.barrier"() <{address_spaces = [#gpu.address_space<workgroup>], scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    %14 = "memref.load"(%arg22, %arg23) : (memref<?xf32, #gpu.address_space<workgroup>>, index) -> f32
    "func.return"(%14) : (f32) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32, #gpu.address_space<global>>, index, f32) -> f32, sym_name = "non_overlapping_barriers"}> ({
  ^bb0(%arg19: memref<?xf32, #gpu.address_space<global>>, %arg20: index, %arg21: f32):
    "memref.store"(%arg21, %arg19, %arg20) : (f32, memref<?xf32, #gpu.address_space<global>>, index) -> ()
    "gpu.barrier"() <{address_spaces = [#gpu.address_space<global>], scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    %13 = "memref.load"(%arg19, %arg20) : (memref<?xf32, #gpu.address_space<global>>, index) -> f32
    "func.return"(%13) : (f32) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index, f32) -> f32, sym_name = "unknown_address_space"}> ({
  ^bb0(%arg16: memref<?xf32>, %arg17: index, %arg18: f32):
    "memref.store"(%arg18, %arg16, %arg17) : (f32, memref<?xf32>, index) -> ()
    "gpu.barrier"() <{address_spaces = [#gpu.address_space<workgroup>], scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    %12 = "memref.load"(%arg16, %arg17) : (memref<?xf32>, index) -> f32
    "func.return"(%12) : (f32) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32, #gpu.address_space<global>>, memref<?xf32, #gpu.address_space<workgroup>>, index, f32) -> f32, sym_name = "mixed_address_spaces"}> ({
  ^bb0(%arg12: memref<?xf32, #gpu.address_space<global>>, %arg13: memref<?xf32, #gpu.address_space<workgroup>>, %arg14: index, %arg15: f32):
    "memref.store"(%arg15, %arg12, %arg14) : (f32, memref<?xf32, #gpu.address_space<global>>, index) -> ()
    "memref.store"(%arg15, %arg13, %arg14) : (f32, memref<?xf32, #gpu.address_space<workgroup>>, index) -> ()
    "gpu.barrier"() <{address_spaces = [#gpu.address_space<global>, #gpu.address_space<workgroup>], scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    %9 = "memref.load"(%arg12, %arg14) : (memref<?xf32, #gpu.address_space<global>>, index) -> f32
    %10 = "memref.load"(%arg13, %arg14) : (memref<?xf32, #gpu.address_space<workgroup>>, index) -> f32
    %11 = "arith.addf"(%9, %10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%11) : (f32) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32, #gpu.address_space<global>>, index, f32) -> f32, sym_name = "full_barrier_with_global_conflict"}> ({
  ^bb0(%arg9: memref<?xf32, #gpu.address_space<global>>, %arg10: index, %arg11: f32):
    "memref.store"(%arg11, %arg9, %arg10) : (f32, memref<?xf32, #gpu.address_space<global>>, index) -> ()
    "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    %8 = "memref.load"(%arg9, %arg10) : (memref<?xf32, #gpu.address_space<global>>, index) -> f32
    "func.return"(%8) : (f32) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "barrier_fencing_nothing_removed"}> ({
    "func.return"() : () -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "non_workgroup_barrier_retained"}> ({
    "gpu.barrier"() <{scope = #gpu.barrier_scope<subgroup>}> : () -> ()
    "func.return"() : () -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "empty_barrrier_retained"}> ({
    "gpu.barrier"() <{address_spaces = [], scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    "func.return"() : () -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32, #gpu.address_space<global>>, f32) -> (), sym_name = "read_write_loop_no_workgroup"}> ({
  ^bb0(%arg6: memref<?xf32, #gpu.address_space<global>>, %arg7: f32):
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "arith.constant"() <{value = 42 : index}> : () -> index
    %6 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%4, %5, %6) ({
    ^bb0(%arg8: index):
      %7 = "memref.load"(%arg6, %arg8) : (memref<?xf32, #gpu.address_space<global>>, index) -> f32
      "memref.store"(%7, %arg6, %arg8) : (f32, memref<?xf32, #gpu.address_space<global>>, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32, #gpu.address_space<global>>, index, f32) -> f32, sym_name = "global_barrier_buffer_cast"}> ({
  ^bb0(%arg3: memref<?xf32, #gpu.address_space<global>>, %arg4: index, %arg5: f32):
    "memref.store"(%arg5, %arg3, %arg4) : (f32, memref<?xf32, #gpu.address_space<global>>, index) -> ()
    "gpu.barrier"() <{address_spaces = [#gpu.address_space<global>], scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    %2 = "amdgpu.fat_raw_buffer_cast"(%arg3) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 0, 0>}> : (memref<?xf32, #gpu.address_space<global>>) -> memref<?xf32, #amdgpu.address_space<fat_raw_buffer>>
    %3 = "memref.load"(%2, %arg4) : (memref<?xf32, #amdgpu.address_space<fat_raw_buffer>>, index) -> f32
    "func.return"(%3) : (f32) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32, #gpu.address_space<global>>, index, f32) -> f32, sym_name = "workgroup_barrier_buffer_cast"}> ({
  ^bb0(%arg0: memref<?xf32, #gpu.address_space<global>>, %arg1: index, %arg2: f32):
    "memref.store"(%arg2, %arg0, %arg1) : (f32, memref<?xf32, #gpu.address_space<global>>, index) -> ()
    %0 = "amdgpu.fat_raw_buffer_cast"(%arg0) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 0, 0>}> : (memref<?xf32, #gpu.address_space<global>>) -> memref<?xf32, #amdgpu.address_space<fat_raw_buffer>>
    %1 = "memref.load"(%0, %arg1) : (memref<?xf32, #amdgpu.address_space<fat_raw_buffer>>, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
}) : () -> ()

