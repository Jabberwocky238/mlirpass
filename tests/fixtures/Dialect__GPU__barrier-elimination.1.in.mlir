"builtin.module"() ({
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg56: !transform.any_op):
      %59 = "transform.structured.match"(%arg56) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%59) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.gpu.eliminate_barriers"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index) -> (), sym_name = "read_read_write"}> ({
  ^bb0(%arg54: memref<?xf32>, %arg55: index):
    %56 = "memref.load"(%arg54, %arg55) : (memref<?xf32>, index) -> f32
    "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    %57 = "memref.load"(%arg54, %arg55) : (memref<?xf32>, index) -> f32
    %58 = "arith.addf"(%56, %57) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    "memref.store"(%58, %arg54, %arg55) : (f32, memref<?xf32>, index) -> ()
    "func.return"() : () -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index, f32) -> f32, sym_name = "write_read_read"}> ({
  ^bb0(%arg51: memref<?xf32>, %arg52: index, %arg53: f32):
    "memref.store"(%arg53, %arg51, %arg52) : (f32, memref<?xf32>, index) -> ()
    "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    %53 = "memref.load"(%arg51, %arg52) : (memref<?xf32>, index) -> f32
    "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    %54 = "memref.load"(%arg51, %arg52) : (memref<?xf32>, index) -> f32
    %55 = "arith.addf"(%53, %54) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%55) : (f32) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, f32) -> (), sym_name = "write_in_a_loop"}> ({
  ^bb0(%arg48: memref<?xf32>, %arg49: f32):
    %50 = "arith.constant"() <{value = 0 : index}> : () -> index
    %51 = "arith.constant"() <{value = 42 : index}> : () -> index
    %52 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%50, %51, %52) ({
    ^bb0(%arg50: index):
      "memref.store"(%arg49, %arg48, %arg50) : (f32, memref<?xf32>, index) -> ()
      "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, f32) -> (), sym_name = "read_read_write_loop"}> ({
  ^bb0(%arg45: memref<?xf32>, %arg46: f32):
    %44 = "arith.constant"() <{value = 0 : index}> : () -> index
    %45 = "arith.constant"() <{value = 42 : index}> : () -> index
    %46 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%44, %45, %46) ({
    ^bb0(%arg47: index):
      %47 = "memref.load"(%arg45, %arg47) : (memref<?xf32>, index) -> f32
      "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
      %48 = "memref.load"(%arg45, %arg47) : (memref<?xf32>, index) -> f32
      %49 = "arith.addf"(%47, %48) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
      "memref.store"(%49, %arg45, %arg47) : (f32, memref<?xf32>, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, f32) -> (), sym_name = "read_read_write_loop_trailing_sync"}> ({
  ^bb0(%arg42: memref<?xf32>, %arg43: f32):
    %38 = "arith.constant"() <{value = 0 : index}> : () -> index
    %39 = "arith.constant"() <{value = 42 : index}> : () -> index
    %40 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%38, %39, %40) ({
    ^bb0(%arg44: index):
      %41 = "memref.load"(%arg42, %arg44) : (memref<?xf32>, index) -> f32
      "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
      %42 = "memref.load"(%arg42, %arg44) : (memref<?xf32>, index) -> f32
      %43 = "arith.addf"(%41, %42) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
      "memref.store"(%43, %arg42, %arg44) : (f32, memref<?xf32>, index) -> ()
      "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, f32) -> (), sym_name = "read_read_write_loop_trailing_sync_non_memory_barrier"}> ({
  ^bb0(%arg39: memref<?xf32>, %arg40: f32):
    %32 = "arith.constant"() <{value = 0 : index}> : () -> index
    %33 = "arith.constant"() <{value = 42 : index}> : () -> index
    %34 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%32, %33, %34) ({
    ^bb0(%arg41: index):
      %35 = "memref.load"(%arg39, %arg41) : (memref<?xf32>, index) -> f32
      "gpu.barrier"() <{address_spaces = [], scope = #gpu.barrier_scope<workgroup>}> : () -> ()
      "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
      %36 = "memref.load"(%arg39, %arg41) : (memref<?xf32>, index) -> f32
      %37 = "arith.addf"(%35, %36) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
      "memref.store"(%37, %arg39, %arg41) : (f32, memref<?xf32>, index) -> ()
      "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (index, f32) -> (memref<42xf32>, memref<10xf32>), sym_name = "write_write_noalias"}> ({
  ^bb0(%arg37: index, %arg38: f32):
    %30 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<42xf32>
    %31 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    "memref.store"(%arg38, %30, %arg37) : (f32, memref<42xf32>, index) -> ()
    "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    "memref.store"(%arg38, %31, %arg37) : (f32, memref<10xf32>, index) -> ()
    "func.return"(%30, %31) : (memref<42xf32>, memref<10xf32>) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (index, f32, memref<?xf32>) -> memref<42xf32>, sym_name = "write_write_alloc_arg_noalias"}> ({
  ^bb0(%arg34: index, %arg35: f32, %arg36: memref<?xf32>):
    %29 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<42xf32>
    "memref.store"(%arg35, %29, %arg34) : (f32, memref<42xf32>, index) -> ()
    "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    "memref.store"(%arg35, %arg36, %arg34) : (f32, memref<?xf32>, index) -> ()
    "func.return"(%29) : (memref<42xf32>) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index, f32) -> f32, sym_name = "repeated_barrier"}> ({
  ^bb0(%arg31: memref<?xf32>, %arg32: index, %arg33: f32):
    %28 = "memref.load"(%arg31, %arg32) : (memref<?xf32>, index) -> f32
    "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    "memref.store"(%arg33, %arg31, %arg32) : (f32, memref<?xf32>, index) -> ()
    "func.return"(%28) : (f32) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (f32) -> (f32, f32, f32, f32, f32), sym_name = "symmetric_stop"}> ({
  ^bb0(%arg30: f32):
    %20 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    %21 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    %22 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    "memref.store"(%arg30, %20) : (f32, memref<f32>) -> ()
    "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    %23 = "memref.load"(%20) : (memref<f32>) -> f32
    "memref.store"(%arg30, %21) : (f32, memref<f32>) -> ()
    "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    %24 = "memref.load"(%20) : (memref<f32>) -> f32
    "memref.store"(%arg30, %22) : (f32, memref<f32>) -> ()
    "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    %25 = "memref.load"(%20) : (memref<f32>) -> f32
    %26 = "memref.load"(%21) : (memref<f32>) -> f32
    %27 = "memref.load"(%22) : (memref<f32>) -> f32
    "func.return"(%23, %24, %25, %26, %27) : (f32, f32, f32, f32, f32) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "nested_loop_barrier_only"}> ({
    %17 = "arith.constant"() <{value = 0 : index}> : () -> index
    %18 = "arith.constant"() <{value = 42 : index}> : () -> index
    %19 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%17, %18, %19) ({
    ^bb0(%arg28: index):
      "scf.for"(%17, %18, %19) ({
      ^bb0(%arg29: index):
        "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32, #gpu.address_space<global>>, index, f32) -> f32, sym_name = "workgroup_barrier_global_memory"}> ({
  ^bb0(%arg25: memref<?xf32, #gpu.address_space<global>>, %arg26: index, %arg27: f32):
    "memref.store"(%arg27, %arg25, %arg26) : (f32, memref<?xf32, #gpu.address_space<global>>, index) -> ()
    "gpu.barrier"() <{address_spaces = [#gpu.address_space<workgroup>], scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    %16 = "memref.load"(%arg25, %arg26) : (memref<?xf32, #gpu.address_space<global>>, index) -> f32
    "func.return"(%16) : (f32) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32, #gpu.address_space<workgroup>>, index, f32) -> f32, sym_name = "workgroup_barrier_workgroup_memory"}> ({
  ^bb0(%arg22: memref<?xf32, #gpu.address_space<workgroup>>, %arg23: index, %arg24: f32):
    "memref.store"(%arg24, %arg22, %arg23) : (f32, memref<?xf32, #gpu.address_space<workgroup>>, index) -> ()
    "gpu.barrier"() <{address_spaces = [#gpu.address_space<workgroup>], scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    %15 = "memref.load"(%arg22, %arg23) : (memref<?xf32, #gpu.address_space<workgroup>>, index) -> f32
    "func.return"(%15) : (f32) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32, #gpu.address_space<global>>, index, f32) -> f32, sym_name = "non_overlapping_barriers"}> ({
  ^bb0(%arg19: memref<?xf32, #gpu.address_space<global>>, %arg20: index, %arg21: f32):
    "memref.store"(%arg21, %arg19, %arg20) : (f32, memref<?xf32, #gpu.address_space<global>>, index) -> ()
    "gpu.barrier"() <{address_spaces = [#gpu.address_space<global>], scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    "gpu.barrier"() <{address_spaces = [#gpu.address_space<workgroup>], scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    %14 = "memref.load"(%arg19, %arg20) : (memref<?xf32, #gpu.address_space<global>>, index) -> f32
    "func.return"(%14) : (f32) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index, f32) -> f32, sym_name = "unknown_address_space"}> ({
  ^bb0(%arg16: memref<?xf32>, %arg17: index, %arg18: f32):
    "memref.store"(%arg18, %arg16, %arg17) : (f32, memref<?xf32>, index) -> ()
    "gpu.barrier"() <{address_spaces = [#gpu.address_space<workgroup>], scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    %13 = "memref.load"(%arg16, %arg17) : (memref<?xf32>, index) -> f32
    "func.return"(%13) : (f32) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32, #gpu.address_space<global>>, memref<?xf32, #gpu.address_space<workgroup>>, index, f32) -> f32, sym_name = "mixed_address_spaces"}> ({
  ^bb0(%arg12: memref<?xf32, #gpu.address_space<global>>, %arg13: memref<?xf32, #gpu.address_space<workgroup>>, %arg14: index, %arg15: f32):
    "memref.store"(%arg15, %arg12, %arg14) : (f32, memref<?xf32, #gpu.address_space<global>>, index) -> ()
    "memref.store"(%arg15, %arg13, %arg14) : (f32, memref<?xf32, #gpu.address_space<workgroup>>, index) -> ()
    "gpu.barrier"() <{address_spaces = [#gpu.address_space<global>, #gpu.address_space<workgroup>], scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    %10 = "memref.load"(%arg12, %arg14) : (memref<?xf32, #gpu.address_space<global>>, index) -> f32
    %11 = "memref.load"(%arg13, %arg14) : (memref<?xf32, #gpu.address_space<workgroup>>, index) -> f32
    %12 = "arith.addf"(%10, %11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%12) : (f32) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32, #gpu.address_space<global>>, index, f32) -> f32, sym_name = "full_barrier_with_global_conflict"}> ({
  ^bb0(%arg9: memref<?xf32, #gpu.address_space<global>>, %arg10: index, %arg11: f32):
    "memref.store"(%arg11, %arg9, %arg10) : (f32, memref<?xf32, #gpu.address_space<global>>, index) -> ()
    "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    %9 = "memref.load"(%arg9, %arg10) : (memref<?xf32, #gpu.address_space<global>>, index) -> f32
    "func.return"(%9) : (f32) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "barrier_fencing_nothing_removed"}> ({
    "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
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
      "gpu.barrier"() <{address_spaces = [#gpu.address_space<workgroup>], scope = #gpu.barrier_scope<workgroup>}> : () -> ()
      %7 = "memref.load"(%arg6, %arg8) : (memref<?xf32, #gpu.address_space<global>>, index) -> f32
      %8 = "arith.addf"(%7, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "gpu.barrier"() <{address_spaces = [#gpu.address_space<workgroup>], scope = #gpu.barrier_scope<workgroup>}> : () -> ()
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
    "gpu.barrier"() <{address_spaces = [#gpu.address_space<workgroup>], scope = #gpu.barrier_scope<workgroup>}> : () -> ()
    %0 = "amdgpu.fat_raw_buffer_cast"(%arg0) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 0, 0>}> : (memref<?xf32, #gpu.address_space<global>>) -> memref<?xf32, #amdgpu.address_space<fat_raw_buffer>>
    %1 = "memref.load"(%0, %arg1) : (memref<?xf32, #amdgpu.address_space<fat_raw_buffer>>, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
}) : () -> ()

