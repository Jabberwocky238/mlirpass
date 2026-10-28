"builtin.module"() ({
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg25: !transform.any_op):
      %36 = "transform.structured.match"(%arg25) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%36) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.gpu.eliminate_barriers"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index) -> (), sym_name = "read_read_write"}> ({
  ^bb0(%arg23: memref<?xf32>, %arg24: index):
    %33 = "memref.load"(%arg23, %arg24) : (memref<?xf32>, index) -> f32
    "gpu.barrier"() : () -> ()
    %34 = "memref.load"(%arg23, %arg24) : (memref<?xf32>, index) -> f32
    %35 = "arith.addf"(%33, %34) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "gpu.barrier"() : () -> ()
    "memref.store"(%35, %arg23, %arg24) : (f32, memref<?xf32>, index) -> ()
    "func.return"() : () -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index, f32) -> f32, sym_name = "write_read_read"}> ({
  ^bb0(%arg20: memref<?xf32>, %arg21: index, %arg22: f32):
    "memref.store"(%arg22, %arg20, %arg21) : (f32, memref<?xf32>, index) -> ()
    "gpu.barrier"() : () -> ()
    %30 = "memref.load"(%arg20, %arg21) : (memref<?xf32>, index) -> f32
    "gpu.barrier"() : () -> ()
    %31 = "memref.load"(%arg20, %arg21) : (memref<?xf32>, index) -> f32
    %32 = "arith.addf"(%30, %31) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%32) : (f32) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, f32) -> (), sym_name = "write_in_a_loop"}> ({
  ^bb0(%arg17: memref<?xf32>, %arg18: f32):
    %27 = "arith.constant"() <{value = 0 : index}> : () -> index
    %28 = "arith.constant"() <{value = 42 : index}> : () -> index
    %29 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%27, %28, %29) ({
    ^bb0(%arg19: index):
      "memref.store"(%arg18, %arg17, %arg19) : (f32, memref<?xf32>, index) -> ()
      "gpu.barrier"() : () -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, f32) -> (), sym_name = "read_read_write_loop"}> ({
  ^bb0(%arg14: memref<?xf32>, %arg15: f32):
    %21 = "arith.constant"() <{value = 0 : index}> : () -> index
    %22 = "arith.constant"() <{value = 42 : index}> : () -> index
    %23 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%21, %22, %23) ({
    ^bb0(%arg16: index):
      %24 = "memref.load"(%arg14, %arg16) : (memref<?xf32>, index) -> f32
      "gpu.barrier"() : () -> ()
      %25 = "memref.load"(%arg14, %arg16) : (memref<?xf32>, index) -> f32
      %26 = "arith.addf"(%24, %25) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "gpu.barrier"() : () -> ()
      "memref.store"(%26, %arg14, %arg16) : (f32, memref<?xf32>, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, f32) -> (), sym_name = "read_read_write_loop_trailing_sync"}> ({
  ^bb0(%arg11: memref<?xf32>, %arg12: f32):
    %15 = "arith.constant"() <{value = 0 : index}> : () -> index
    %16 = "arith.constant"() <{value = 42 : index}> : () -> index
    %17 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%15, %16, %17) ({
    ^bb0(%arg13: index):
      %18 = "memref.load"(%arg11, %arg13) : (memref<?xf32>, index) -> f32
      "gpu.barrier"() : () -> ()
      %19 = "memref.load"(%arg11, %arg13) : (memref<?xf32>, index) -> f32
      %20 = "arith.addf"(%18, %19) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "gpu.barrier"() : () -> ()
      "memref.store"(%20, %arg11, %arg13) : (f32, memref<?xf32>, index) -> ()
      "gpu.barrier"() : () -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (index, f32) -> (memref<42xf32>, memref<10xf32>), sym_name = "write_write_noalias"}> ({
  ^bb0(%arg9: index, %arg10: f32):
    %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<42xf32>
    %14 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    "memref.store"(%arg10, %13, %arg9) : (f32, memref<42xf32>, index) -> ()
    "gpu.barrier"() : () -> ()
    "memref.store"(%arg10, %14, %arg9) : (f32, memref<10xf32>, index) -> ()
    "func.return"(%13, %14) : (memref<42xf32>, memref<10xf32>) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (index, f32, memref<?xf32>) -> memref<42xf32>, sym_name = "write_write_alloc_arg_noalias"}> ({
  ^bb0(%arg6: index, %arg7: f32, %arg8: memref<?xf32>):
    %12 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<42xf32>
    "memref.store"(%arg7, %12, %arg6) : (f32, memref<42xf32>, index) -> ()
    "gpu.barrier"() : () -> ()
    "memref.store"(%arg7, %arg8, %arg6) : (f32, memref<?xf32>, index) -> ()
    "func.return"(%12) : (memref<42xf32>) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index, f32) -> f32, sym_name = "repeated_barrier"}> ({
  ^bb0(%arg3: memref<?xf32>, %arg4: index, %arg5: f32):
    %11 = "memref.load"(%arg3, %arg4) : (memref<?xf32>, index) -> f32
    "gpu.barrier"() : () -> ()
    "gpu.barrier"() : () -> ()
    "memref.store"(%arg5, %arg3, %arg4) : (f32, memref<?xf32>, index) -> ()
    "func.return"(%11) : (f32) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = (f32) -> (f32, f32, f32, f32, f32), sym_name = "symmetric_stop"}> ({
  ^bb0(%arg2: f32):
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    %4 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    %5 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    "memref.store"(%arg2, %3) : (f32, memref<f32>) -> ()
    "gpu.barrier"() : () -> ()
    %6 = "memref.load"(%3) : (memref<f32>) -> f32
    "memref.store"(%arg2, %4) : (f32, memref<f32>) -> ()
    "gpu.barrier"() : () -> ()
    %7 = "memref.load"(%3) : (memref<f32>) -> f32
    "memref.store"(%arg2, %5) : (f32, memref<f32>) -> ()
    "gpu.barrier"() : () -> ()
    %8 = "memref.load"(%3) : (memref<f32>) -> f32
    %9 = "memref.load"(%4) : (memref<f32>) -> f32
    %10 = "memref.load"(%5) : (memref<f32>) -> f32
    "func.return"(%6, %7, %8, %9, %10) : (f32, f32, f32, f32, f32) -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "nested_loop_barrier_only"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 42 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%0, %1, %2) ({
    ^bb0(%arg0: index):
      "scf.for"(%0, %1, %2) ({
      ^bb0(%arg1: index):
        "gpu.barrier"() : () -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) {__parallel_region_boundary_for_test} : () -> ()
}) : () -> ()

