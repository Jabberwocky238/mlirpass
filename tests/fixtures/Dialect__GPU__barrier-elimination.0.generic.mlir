"builtin.module"() ({
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg23: !transform.any_op):
      %33 = "transform.structured.match"(%arg23) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%33) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.gpu.eliminate_barriers"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index) -> (), sym_name = "read_read_write"}> ({
  ^bb0(%arg21: memref<?xf32>, %arg22: index):
    %30 = "memref.load"(%arg21, %arg22) : (memref<?xf32>, index) -> f32
    %31 = "memref.load"(%arg21, %arg22) : (memref<?xf32>, index) -> f32
    %32 = "arith.addf"(%30, %31) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "gpu.barrier"() : () -> ()
    "memref.store"(%32, %arg21, %arg22) : (f32, memref<?xf32>, index) -> ()
    "func.return"() : () -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index, f32) -> f32, sym_name = "write_read_read"}> ({
  ^bb0(%arg18: memref<?xf32>, %arg19: index, %arg20: f32):
    "memref.store"(%arg20, %arg18, %arg19) : (f32, memref<?xf32>, index) -> ()
    "gpu.barrier"() : () -> ()
    %27 = "memref.load"(%arg18, %arg19) : (memref<?xf32>, index) -> f32
    %28 = "memref.load"(%arg18, %arg19) : (memref<?xf32>, index) -> f32
    %29 = "arith.addf"(%27, %28) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%29) : (f32) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, f32) -> (), sym_name = "write_in_a_loop"}> ({
  ^bb0(%arg15: memref<?xf32>, %arg16: f32):
    %24 = "arith.constant"() <{value = 0 : index}> : () -> index
    %25 = "arith.constant"() <{value = 42 : index}> : () -> index
    %26 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%24, %25, %26) ({
    ^bb0(%arg17: index):
      "memref.store"(%arg16, %arg15, %arg17) : (f32, memref<?xf32>, index) -> ()
      "gpu.barrier"() : () -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, f32) -> (), sym_name = "read_read_write_loop"}> ({
  ^bb0(%arg12: memref<?xf32>, %arg13: f32):
    %18 = "arith.constant"() <{value = 0 : index}> : () -> index
    %19 = "arith.constant"() <{value = 42 : index}> : () -> index
    %20 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%18, %19, %20) ({
    ^bb0(%arg14: index):
      %21 = "memref.load"(%arg12, %arg14) : (memref<?xf32>, index) -> f32
      "gpu.barrier"() : () -> ()
      %22 = "memref.load"(%arg12, %arg14) : (memref<?xf32>, index) -> f32
      %23 = "arith.addf"(%21, %22) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "gpu.barrier"() : () -> ()
      "memref.store"(%23, %arg12, %arg14) : (f32, memref<?xf32>, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, f32) -> (), sym_name = "read_read_write_loop_trailing_sync"}> ({
  ^bb0(%arg9: memref<?xf32>, %arg10: f32):
    %12 = "arith.constant"() <{value = 0 : index}> : () -> index
    %13 = "arith.constant"() <{value = 42 : index}> : () -> index
    %14 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%12, %13, %14) ({
    ^bb0(%arg11: index):
      %15 = "memref.load"(%arg9, %arg11) : (memref<?xf32>, index) -> f32
      %16 = "memref.load"(%arg9, %arg11) : (memref<?xf32>, index) -> f32
      %17 = "arith.addf"(%15, %16) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "gpu.barrier"() : () -> ()
      "memref.store"(%17, %arg9, %arg11) : (f32, memref<?xf32>, index) -> ()
      "gpu.barrier"() : () -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (index, f32) -> (memref<42xf32>, memref<10xf32>), sym_name = "write_write_noalias"}> ({
  ^bb0(%arg7: index, %arg8: f32):
    %10 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<42xf32>
    %11 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    "memref.store"(%arg8, %10, %arg7) : (f32, memref<42xf32>, index) -> ()
    "memref.store"(%arg8, %11, %arg7) : (f32, memref<10xf32>, index) -> ()
    "func.return"(%10, %11) : (memref<42xf32>, memref<10xf32>) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (index, f32, memref<?xf32>) -> memref<42xf32>, sym_name = "write_write_alloc_arg_noalias"}> ({
  ^bb0(%arg4: index, %arg5: f32, %arg6: memref<?xf32>):
    %9 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<42xf32>
    "memref.store"(%arg5, %9, %arg4) : (f32, memref<42xf32>, index) -> ()
    "memref.store"(%arg5, %arg6, %arg4) : (f32, memref<?xf32>, index) -> ()
    "func.return"(%9) : (memref<42xf32>) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index, f32) -> f32, sym_name = "repeated_barrier"}> ({
  ^bb0(%arg1: memref<?xf32>, %arg2: index, %arg3: f32):
    %8 = "memref.load"(%arg1, %arg2) : (memref<?xf32>, index) -> f32
    "gpu.barrier"() : () -> ()
    "memref.store"(%arg3, %arg1, %arg2) : (f32, memref<?xf32>, index) -> ()
    "func.return"(%8) : (f32) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (f32) -> (f32, f32, f32, f32, f32), sym_name = "symmetric_stop"}> ({
  ^bb0(%arg0: f32):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    %2 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    "memref.store"(%arg0, %0) : (f32, memref<f32>) -> ()
    "gpu.barrier"() : () -> ()
    %3 = "memref.load"(%0) : (memref<f32>) -> f32
    "memref.store"(%arg0, %1) : (f32, memref<f32>) -> ()
    %4 = "memref.load"(%0) : (memref<f32>) -> f32
    "memref.store"(%arg0, %2) : (f32, memref<f32>) -> ()
    "gpu.barrier"() : () -> ()
    %5 = "memref.load"(%0) : (memref<f32>) -> f32
    %6 = "memref.load"(%1) : (memref<f32>) -> f32
    %7 = "memref.load"(%2) : (memref<f32>) -> f32
    "func.return"(%3, %4, %5, %6, %7) : (f32, f32, f32, f32, f32) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "nested_loop_barrier_only"}> ({
    "func.return"() : () -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
}) : () -> ()

