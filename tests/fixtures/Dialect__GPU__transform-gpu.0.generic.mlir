"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x32xf32>, memref<2x32xf32>, memref<32xf32>, f32, !gpu.async.token) -> memref<2x32xf32>, sym_name = "blocks_3d"}> ({
  ^bb0(%arg1: memref<2x32xf32>, %arg2: memref<2x32xf32>, %arg3: memref<32xf32>, %arg4: f32, %arg5: !gpu.async.token):
    %2 = "arith.constant"() <{value = 9 : index}> : () -> index
    %3 = "arith.constant"() <{value = 7 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "arith.constant"() <{value = 12 : index}> : () -> index
    %6 = "gpu.launch"(%arg5, %5, %2, %4, %4, %4, %4) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: index, %arg17: index):
      %7 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %8 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %9 = "arith.cmpi"(%7, %3) <{predicate = 6 : i64}> : (index, index) -> i1
      "scf.if"(%9) ({
        %10 = "memref.load"(%arg1, %7, %8) : (memref<2x32xf32>, index, index) -> f32
        %11 = "memref.load"(%arg2, %7, %8) : (memref<2x32xf32>, index, index) -> f32
        %12 = "math.fma"(%arg4, %10, %11) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
        "memref.store"(%12, %arg2, %7, %8) : (f32, memref<2x32xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (!gpu.async.token, index, index, index, index, index, index) -> !gpu.async.token
    "func.return"(%arg2) : (memref<2x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["gpu.launch"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.gpu.map_forall_to_blocks"(%0) <{grid_dims = array<i64: 12, 9, 1>}> : (!transform.any_op) -> !transform.any_op
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 floordiv 128)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x32xf32>, memref<2x32xf32>, memref<32xf32>, f32, !gpu.async.token) -> memref<2x32xf32>, sym_name = "warpgroup_3d"}> ({
  ^bb0(%arg1: memref<2x32xf32>, %arg2: memref<2x32xf32>, %arg3: memref<32xf32>, %arg4: f32, %arg5: !gpu.async.token):
    %2 = "arith.constant"() <{value = 384 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 512 : index}> : () -> index
    %5 = "arith.constant"() <{value = 2 : index}> : () -> index
    %6 = "gpu.launch"(%arg5, %3, %3, %3, %4, %5, %3) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: index, %arg17: index):
      %7 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %8 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %9 = "affine.apply"(%7) <{map = #map}> : (index) -> index
      %10 = "arith.cmpi"(%7, %2) <{predicate = 6 : i64}> : (index, index) -> i1
      %11 = "arith.cmpi"(%8, %3) <{predicate = 6 : i64}> : (index, index) -> i1
      %12 = "arith.andi"(%10, %11) : (i1, i1) -> i1
      "scf.if"(%12) ({
        %13 = "memref.load"(%arg1, %9, %8) : (memref<2x32xf32>, index, index) -> f32
        %14 = "memref.load"(%arg2, %9, %8) : (memref<2x32xf32>, index, index) -> f32
        %15 = "math.fma"(%arg4, %13, %14) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
        "memref.store"(%15, %arg2, %9, %8) : (f32, memref<2x32xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "gpu.barrier"() : () -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (!gpu.async.token, index, index, index, index, index, index) -> !gpu.async.token
    "func.return"(%arg2) : (memref<2x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["gpu.launch"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.gpu.map_nested_forall_to_threads"(%0) <{block_dims = array<i64: 512, 2, 1>, sync_after_distribute = true, warp_size = 32 : i64}> : (!transform.any_op) -> !transform.any_op
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 floordiv 16)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x32xf32>, memref<2x32xf32>, memref<32xf32>, f32, !gpu.async.token) -> memref<2x32xf32>, sym_name = "warp_3d"}> ({
  ^bb0(%arg1: memref<2x32xf32>, %arg2: memref<2x32xf32>, %arg3: memref<32xf32>, %arg4: f32, %arg5: !gpu.async.token):
    %2 = "arith.constant"() <{value = 32 : index}> : () -> index
    %3 = "arith.constant"() <{value = 3 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "arith.constant"() <{value = 64 : index}> : () -> index
    %6 = "arith.constant"() <{value = 4 : index}> : () -> index
    %7 = "gpu.launch"(%arg5, %4, %4, %4, %5, %6, %3) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: index, %arg17: index):
      %8 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %9 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %10 = "affine.apply"(%8) <{map = #map}> : (index) -> index
      %11 = "arith.cmpi"(%8, %2) <{predicate = 6 : i64}> : (index, index) -> i1
      %12 = "arith.cmpi"(%9, %3) <{predicate = 6 : i64}> : (index, index) -> i1
      %13 = "arith.andi"(%11, %12) : (i1, i1) -> i1
      "scf.if"(%13) ({
        %14 = "memref.load"(%arg1, %10, %9) : (memref<2x32xf32>, index, index) -> f32
        %15 = "memref.load"(%arg2, %10, %9) : (memref<2x32xf32>, index, index) -> f32
        %16 = "math.fma"(%arg4, %14, %15) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
        "memref.store"(%16, %arg2, %10, %9) : (f32, memref<2x32xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "gpu.barrier"() : () -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (!gpu.async.token, index, index, index, index, index, index) -> !gpu.async.token
    "func.return"(%arg2) : (memref<2x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["gpu.launch"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.gpu.map_nested_forall_to_threads"(%0) <{block_dims = array<i64: 64, 4, 3>, sync_after_distribute = true, warp_size = 16 : i64}> : (!transform.any_op) -> !transform.any_op
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x32xf32>, memref<2x32xf32>, memref<32xf32>, f32, !gpu.async.token) -> memref<2x32xf32>, sym_name = "threads_3d"}> ({
  ^bb0(%arg1: memref<2x32xf32>, %arg2: memref<2x32xf32>, %arg3: memref<32xf32>, %arg4: f32, %arg5: !gpu.async.token):
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 12 : index}> : () -> index
    %4 = "arith.constant"() <{value = 9 : index}> : () -> index
    %5 = "arith.constant"() <{value = 7 : index}> : () -> index
    %6 = "gpu.launch"(%arg5, %2, %2, %2, %3, %4, %2) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: index, %arg17: index):
      %7 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %8 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %9 = "arith.cmpi"(%7, %4) <{predicate = 6 : i64}> : (index, index) -> i1
      %10 = "arith.cmpi"(%8, %5) <{predicate = 6 : i64}> : (index, index) -> i1
      %11 = "arith.andi"(%9, %10) : (i1, i1) -> i1
      "scf.if"(%11) ({
        %15 = "memref.load"(%arg1, %8, %7) : (memref<2x32xf32>, index, index) -> f32
        %16 = "memref.load"(%arg2, %8, %7) : (memref<2x32xf32>, index, index) -> f32
        %17 = "math.fma"(%arg4, %15, %16) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
        "memref.store"(%17, %arg2, %8, %7) : (f32, memref<2x32xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "gpu.barrier"() : () -> ()
      %12 = "arith.cmpi"(%8, %2) <{predicate = 6 : i64}> : (index, index) -> i1
      "scf.if"(%12) ({
        %13 = "memref.load"(%arg3, %7) : (memref<32xf32>, index) -> f32
        %14 = "arith.addf"(%arg4, %13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "memref.store"(%14, %arg3, %7) : (f32, memref<32xf32>, index) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "gpu.barrier"() : () -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (!gpu.async.token, index, index, index, index, index, index) -> !gpu.async.token
    "func.return"(%arg2) : (memref<2x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["gpu.launch"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.gpu.map_nested_forall_to_threads"(%0) <{block_dims = array<i64: 12, 9, 1>, sync_after_distribute = true, warp_size = 32 : i64}> : (!transform.any_op) -> !transform.any_op
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32x64x4x32xf32>, memref<32x64x4x32xf32>, f32) -> memref<32x64x4x32xf32>, sym_name = "saxpy4d"}> ({
  ^bb0(%arg1: memref<32x64x4x32xf32>, %arg2: memref<32x64x4x32xf32>, %arg3: f32):
    %3 = "arith.constant"() <{value = 32 : index}> : () -> index
    %4 = "arith.constant"() <{value = 64 : index}> : () -> index
    %5 = "arith.constant"() <{value = 4 : index}> : () -> index
    %6 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch"(%3, %4, %6, %3, %5, %6) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index):
      %7 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %8 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %9 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %10 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %11 = "memref.load"(%arg1, %7, %8, %10, %9) : (memref<32x64x4x32xf32>, index, index, index, index) -> f32
      %12 = "memref.load"(%arg2, %7, %8, %10, %9) : (memref<32x64x4x32xf32>, index, index, index, index) -> f32
      %13 = "math.fma"(%arg3, %11, %12) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
      "memref.store"(%13, %arg2, %7, %8, %10, %9) : (f32, memref<32x64x4x32xf32>, index, index, index, index) -> ()
      "gpu.barrier"() : () -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"(%arg2) : (memref<32x64x4x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.gpu.map_forall_to_blocks"(%0) <{generate_gpu_launch}> : (!transform.any_op) -> !transform.any_op
      %2 = "transform.gpu.map_nested_forall_to_threads"(%1) <{block_dims = array<i64: 32, 4, 1>, sync_after_distribute = true, warp_size = 32 : i64}> : (!transform.any_op) -> !transform.any_op
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x32xf32>, memref<2x32xf32>, memref<32xf32>, f32, !gpu.async.token) -> memref<2x32xf32>, sym_name = "saxpy2d_no_barrier"}> ({
  ^bb0(%arg1: memref<2x32xf32>, %arg2: memref<2x32xf32>, %arg3: memref<32xf32>, %arg4: f32, %arg5: !gpu.async.token):
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 12 : index}> : () -> index
    %4 = "arith.constant"() <{value = 9 : index}> : () -> index
    %5 = "arith.constant"() <{value = 7 : index}> : () -> index
    %6 = "gpu.launch"(%arg5, %2, %2, %2, %3, %4, %2) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: index, %arg17: index):
      %7 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %8 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %9 = "arith.cmpi"(%7, %4) <{predicate = 6 : i64}> : (index, index) -> i1
      %10 = "arith.cmpi"(%8, %5) <{predicate = 6 : i64}> : (index, index) -> i1
      %11 = "arith.andi"(%9, %10) : (i1, i1) -> i1
      "scf.if"(%11) ({
        %12 = "memref.load"(%arg1, %8, %7) : (memref<2x32xf32>, index, index) -> f32
        %13 = "memref.load"(%arg2, %8, %7) : (memref<2x32xf32>, index, index) -> f32
        %14 = "math.fma"(%arg4, %12, %13) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
        "memref.store"(%14, %arg2, %8, %7) : (f32, memref<2x32xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (!gpu.async.token, index, index, index, index, index, index) -> !gpu.async.token
    "func.return"(%arg2) : (memref<2x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["gpu.launch"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.gpu.map_nested_forall_to_threads"(%0) <{block_dims = array<i64: 12, 9, 1>, sync_after_distribute = false, warp_size = 32 : i64}> : (!transform.any_op) -> !transform.any_op
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32x32xf32>, memref<32x32xf32>, !gpu.async.token) -> memref<32x32xf32>, sym_name = "saxpy2d_singleloop"}> ({
  ^bb0(%arg1: memref<32x32xf32>, %arg2: memref<32x32xf32>, %arg3: !gpu.async.token):
    %2 = "arith.constant"() <{value = 32 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "gpu.launch"(%arg3, %3, %3, %3, %2, %3, %3) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index):
      %5 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %6 = "memref.load"(%arg1, %5, %5) : (memref<32x32xf32>, index, index) -> f32
      %7 = "memref.load"(%arg2, %5, %5) : (memref<32x32xf32>, index, index) -> f32
      %8 = "arith.mulf"(%6, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "memref.store"(%8, %arg2, %5, %5) : (f32, memref<32x32xf32>, index, index) -> ()
      "gpu.barrier"() : () -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (!gpu.async.token, index, index, index, index, index, index) -> !gpu.async.token
    "func.return"(%arg2) : (memref<32x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["gpu.launch"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.gpu.map_nested_forall_to_threads"(%0) <{block_dims = array<i64: 32, 1, 1>, sync_after_distribute = true, warp_size = 32 : i64}> : (!transform.any_op) -> !transform.any_op
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<3x2x32xf32>, memref<3x2x32xf32>, memref<32xf32>, f32, !gpu.async.token) -> memref<3x2x32xf32>, sym_name = "saxpy3d_fold_id_z"}> ({
  ^bb0(%arg1: memref<3x2x32xf32>, %arg2: memref<3x2x32xf32>, %arg3: memref<32xf32>, %arg4: f32, %arg5: !gpu.async.token):
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 12 : index}> : () -> index
    %5 = "arith.constant"() <{value = 9 : index}> : () -> index
    %6 = "arith.constant"() <{value = 7 : index}> : () -> index
    %7 = "gpu.launch"(%arg5, %3, %3, %3, %4, %5, %3) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: index, %arg17: index):
      %8 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %9 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %10 = "arith.cmpi"(%8, %5) <{predicate = 6 : i64}> : (index, index) -> i1
      %11 = "arith.cmpi"(%9, %6) <{predicate = 6 : i64}> : (index, index) -> i1
      %12 = "arith.andi"(%10, %11) : (i1, i1) -> i1
      "scf.if"(%12) ({
        %13 = "memref.load"(%arg1, %2, %9, %8) : (memref<3x2x32xf32>, index, index, index) -> f32
        %14 = "memref.load"(%arg2, %2, %9, %8) : (memref<3x2x32xf32>, index, index, index) -> f32
        %15 = "math.fma"(%arg4, %13, %14) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
        "memref.store"(%15, %arg2, %2, %9, %8) : (f32, memref<3x2x32xf32>, index, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (!gpu.async.token, index, index, index, index, index, index) -> !gpu.async.token
    "func.return"(%arg2) : (memref<3x2x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["gpu.launch"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.gpu.map_nested_forall_to_threads"(%0) <{block_dims = array<i64: 12, 9, 1>, sync_after_distribute = false, warp_size = 32 : i64}> : (!transform.any_op) -> !transform.any_op
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1, s2] -> (s0 + s1 * 32 + s2 * 256)>
#map1 = affine_map<()[s0, s1] -> (((s0 + s1 * 32) floordiv 128) mod 2)>
#map2 = affine_map<()[s0, s1, s2] -> (s2 + ((s0 + s1 * 32) floordiv 128) floordiv 2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x32xf32>, memref<2x32xf32>, memref<32xf32>, f32, !gpu.async.token) -> memref<2x32xf32>, sym_name = "warpgroup_linear"}> ({
  ^bb0(%arg1: memref<2x32xf32>, %arg2: memref<2x32xf32>, %arg3: memref<32xf32>, %arg4: f32, %arg5: !gpu.async.token):
    %2 = "arith.constant"() <{value = 768 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 32 : index}> : () -> index
    %5 = "arith.constant"() <{value = 8 : index}> : () -> index
    %6 = "arith.constant"() <{value = 4 : index}> : () -> index
    %7 = "gpu.launch"(%arg5, %3, %3, %3, %4, %5, %6) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: index, %arg17: index):
      %8 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %9 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %10 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %11 = "affine.apply"(%8, %9, %10) <{map = #map}> : (index, index, index) -> index
      %12 = "affine.apply"(%8, %9) <{map = #map1}> : (index, index) -> index
      %13 = "affine.apply"(%8, %9, %10) <{map = #map2}> : (index, index, index) -> index
      %14 = "arith.cmpi"(%11, %2) <{predicate = 6 : i64}> : (index, index) -> i1
      "scf.if"(%14) ({
        %15 = "memref.load"(%arg1, %12, %13) : (memref<2x32xf32>, index, index) -> f32
        %16 = "memref.load"(%arg2, %12, %13) : (memref<2x32xf32>, index, index) -> f32
        %17 = "math.fma"(%arg4, %15, %16) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
        "memref.store"(%17, %arg2, %12, %13) : (f32, memref<2x32xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "gpu.barrier"() : () -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (!gpu.async.token, index, index, index, index, index, index) -> !gpu.async.token
    "func.return"(%arg2) : (memref<2x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["gpu.launch"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.gpu.map_nested_forall_to_threads"(%0) <{block_dims = array<i64: 32, 8, 4>, sync_after_distribute = true, warp_size = 32 : i64}> : (!transform.any_op) -> !transform.any_op
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1, s2] -> (s0 + s1 * 32 + s2 * 256)>
#map1 = affine_map<()[s0, s1, s2] -> ((s1 + s2 * 8 + s0 floordiv 32) mod 2)>
#map2 = affine_map<()[s0, s1, s2] -> ((s1 + s2 * 8 + s0 floordiv 32) floordiv 2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x32xf32>, memref<2x32xf32>, memref<32xf32>, f32, !gpu.async.token) -> memref<2x32xf32>, sym_name = "warp_linear"}> ({
  ^bb0(%arg1: memref<2x32xf32>, %arg2: memref<2x32xf32>, %arg3: memref<32xf32>, %arg4: f32, %arg5: !gpu.async.token):
    %2 = "arith.constant"() <{value = 192 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 32 : index}> : () -> index
    %5 = "arith.constant"() <{value = 8 : index}> : () -> index
    %6 = "arith.constant"() <{value = 4 : index}> : () -> index
    %7 = "gpu.launch"(%arg5, %3, %3, %3, %4, %5, %6) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: index, %arg17: index):
      %8 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %9 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %10 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %11 = "affine.apply"(%8, %9, %10) <{map = #map}> : (index, index, index) -> index
      %12 = "affine.apply"(%8, %9, %10) <{map = #map1}> : (index, index, index) -> index
      %13 = "affine.apply"(%8, %9, %10) <{map = #map2}> : (index, index, index) -> index
      %14 = "arith.cmpi"(%11, %2) <{predicate = 6 : i64}> : (index, index) -> i1
      "scf.if"(%14) ({
        %15 = "memref.load"(%arg1, %12, %13) : (memref<2x32xf32>, index, index) -> f32
        %16 = "memref.load"(%arg2, %12, %13) : (memref<2x32xf32>, index, index) -> f32
        %17 = "math.fma"(%arg4, %15, %16) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
        "memref.store"(%17, %arg2, %12, %13) : (f32, memref<2x32xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "gpu.barrier"() : () -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (!gpu.async.token, index, index, index, index, index, index) -> !gpu.async.token
    "func.return"(%arg2) : (memref<2x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["gpu.launch"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.gpu.map_nested_forall_to_threads"(%0) <{block_dims = array<i64: 32, 8, 4>, sync_after_distribute = true, warp_size = 32 : i64}> : (!transform.any_op) -> !transform.any_op
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1 * 18)>
#map1 = affine_map<()[s0, s1] -> (((s0 + s1 * 18) floordiv 32) mod 3)>
#map2 = affine_map<()[s0, s1] -> ((((s0 + s1 * 18) floordiv 32) mod 6) floordiv 3)>
#map3 = affine_map<()[s0, s1] -> ((s0 + s1 * 18) mod 10)>
#map4 = affine_map<()[s0, s1] -> ((s0 + s1 * 18) floordiv 10)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x32xf32>, memref<2x32xf32>, memref<32xf32>, f32, !gpu.async.token) -> memref<2x32xf32>, sym_name = "map_multi_level_linear"}> ({
  ^bb0(%arg1: memref<2x32xf32>, %arg2: memref<2x32xf32>, %arg3: memref<32xf32>, %arg4: f32, %arg5: !gpu.async.token):
    %2 = "arith.constant"() <{value = 20 : index}> : () -> index
    %3 = "arith.constant"() <{value = 192 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "arith.constant"() <{value = 18 : index}> : () -> index
    %6 = "arith.constant"() <{value = 11 : index}> : () -> index
    %7 = "arith.constant"() <{value = 9 : index}> : () -> index
    %8 = "arith.constant"() <{value = 7 : index}> : () -> index
    %9 = "gpu.launch"(%arg5, %4, %4, %4, %5, %6, %4) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: index, %arg17: index):
      %10 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %11 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %12 = "arith.cmpi"(%10, %7) <{predicate = 6 : i64}> : (index, index) -> i1
      %13 = "arith.cmpi"(%11, %8) <{predicate = 6 : i64}> : (index, index) -> i1
      %14 = "arith.andi"(%12, %13) : (i1, i1) -> i1
      "scf.if"(%14) ({
        %26 = "memref.load"(%arg1, %11, %10) : (memref<2x32xf32>, index, index) -> f32
        %27 = "memref.load"(%arg2, %11, %10) : (memref<2x32xf32>, index, index) -> f32
        %28 = "math.fma"(%arg4, %26, %27) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
        "memref.store"(%28, %arg2, %11, %10) : (f32, memref<2x32xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "gpu.barrier"() : () -> ()
      %15 = "affine.apply"(%10, %11) <{map = #map}> : (index, index) -> index
      %16 = "affine.apply"(%10, %11) <{map = #map1}> : (index, index) -> index
      %17 = "affine.apply"(%10, %11) <{map = #map2}> : (index, index) -> index
      %18 = "arith.cmpi"(%15, %3) <{predicate = 6 : i64}> : (index, index) -> i1
      "scf.if"(%18) ({
        %24 = "memref.load"(%arg1, %16, %17) : (memref<2x32xf32>, index, index) -> f32
        %25 = "arith.addf"(%arg4, %24) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "memref.store"(%25, %arg2, %16, %17) : (f32, memref<2x32xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "gpu.barrier"() : () -> ()
      %19 = "affine.apply"(%10, %11) <{map = #map3}> : (index, index) -> index
      %20 = "affine.apply"(%10, %11) <{map = #map4}> : (index, index) -> index
      %21 = "arith.cmpi"(%15, %2) <{predicate = 6 : i64}> : (index, index) -> i1
      "scf.if"(%21) ({
        %22 = "memref.load"(%arg3, %19) : (memref<32xf32>, index) -> f32
        %23 = "arith.addf"(%arg4, %22) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "memref.store"(%23, %arg3, %20) : (f32, memref<32xf32>, index) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "gpu.barrier"() : () -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (!gpu.async.token, index, index, index, index, index, index) -> !gpu.async.token
    "func.return"(%arg2) : (memref<2x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["gpu.launch"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.gpu.map_nested_forall_to_threads"(%0) <{block_dims = array<i64: 18, 11, 1>, sync_after_distribute = true, warp_size = 32 : i64}> : (!transform.any_op) -> !transform.any_op
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1, s2] -> (s0 + s1 * 12 + s2 * 108)>
#map1 = affine_map<()[s0, s1, s2] -> ((s0 + s1 * 12 + s2 * 108) mod 7)>
#map2 = affine_map<()[s0, s1, s2] -> ((s0 + s1 * 12 + s2 * 108) floordiv 7)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x32xf32>, memref<2x32xf32>, memref<32xf32>, f32, !gpu.async.token) -> memref<2x32xf32>, sym_name = "block_linear_existing_launch"}> ({
  ^bb0(%arg1: memref<2x32xf32>, %arg2: memref<2x32xf32>, %arg3: memref<32xf32>, %arg4: f32, %arg5: !gpu.async.token):
    %2 = "arith.constant"() <{value = 63 : index}> : () -> index
    %3 = "arith.constant"() <{value = 9 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "arith.constant"() <{value = 12 : index}> : () -> index
    %6 = "gpu.launch"(%arg5, %5, %3, %4, %4, %4, %4) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: index, %arg17: index):
      %7 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %8 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %9 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %10 = "affine.apply"(%7, %8, %9) <{map = #map}> : (index, index, index) -> index
      %11 = "affine.apply"(%7, %8, %9) <{map = #map1}> : (index, index, index) -> index
      %12 = "affine.apply"(%7, %8, %9) <{map = #map2}> : (index, index, index) -> index
      %13 = "arith.cmpi"(%10, %2) <{predicate = 6 : i64}> : (index, index) -> i1
      "scf.if"(%13) ({
        %14 = "memref.load"(%arg1, %11, %12) : (memref<2x32xf32>, index, index) -> f32
        %15 = "memref.load"(%arg2, %11, %12) : (memref<2x32xf32>, index, index) -> f32
        %16 = "math.fma"(%arg4, %14, %15) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
        "memref.store"(%16, %arg2, %11, %12) : (f32, memref<2x32xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (!gpu.async.token, index, index, index, index, index, index) -> !gpu.async.token
    "func.return"(%arg2) : (memref<2x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["gpu.launch"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.gpu.map_forall_to_blocks"(%0) <{grid_dims = array<i64: 12, 9, 1>}> : (!transform.any_op) -> !transform.any_op
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 mod 7)>
#map1 = affine_map<()[s0, s1, s2] -> (s1 + s2 * 9 + s0 floordiv 7)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x32xf32>, memref<2x32xf32>, memref<32xf32>, f32, !gpu.async.token) -> memref<2x32xf32>, sym_name = "block_linear_generate_launch"}> ({
  ^bb0(%arg1: memref<2x32xf32>, %arg2: memref<2x32xf32>, %arg3: memref<32xf32>, %arg4: f32, %arg5: !gpu.async.token):
    %2 = "arith.constant"() <{value = 9 : index}> : () -> index
    %3 = "arith.constant"() <{value = 7 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch"(%3, %2, %4, %4, %4, %4) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: index, %arg17: index):
      %5 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %6 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %7 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %8 = "affine.apply"(%5) <{map = #map}> : (index) -> index
      %9 = "affine.apply"(%5, %6, %7) <{map = #map1}> : (index, index, index) -> index
      %10 = "memref.load"(%arg1, %8, %9) : (memref<2x32xf32>, index, index) -> f32
      %11 = "memref.load"(%arg2, %8, %9) : (memref<2x32xf32>, index, index) -> f32
      %12 = "math.fma"(%arg4, %10, %11) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
      "memref.store"(%12, %arg2, %8, %9) : (f32, memref<2x32xf32>, index, index) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"(%arg2) : (memref<2x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.gpu.map_forall_to_blocks"(%0) <{generate_gpu_launch}> : (!transform.any_op) -> !transform.any_op
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 * 128)>
#map1 = affine_map<()[s0, s1, s2] -> (s2 * 32 + ((s0 + s1 * 4) floordiv 32) * 32)>
#map2 = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128xf32>) -> memref<128xf32>, sym_name = "simple_fill"}> ({
  ^bb0(%arg1: memref<128xf32>):
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = dense<0.000000e+00> : vector<32xf32>}> : () -> vector<32xf32>
    %5 = "arith.constant"() <{value = 1 : index}> : () -> index
    %6 = "arith.constant"() <{value = 4 : index}> : () -> index
    %7 = "arith.constant"() <{value = 8 : index}> : () -> index
    "gpu.launch"(%5, %5, %5, %6, %7, %6) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index):
      %8 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %9 = "affine.apply"(%8) <{map = #map}> : (index) -> index
      %10 = "memref.subview"(%arg1, %9) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (memref<128xf32>, index) -> memref<128xf32, strided<[1], offset: ?>>
      %11 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %12 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %13 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %14 = "affine.apply"(%11, %12, %13) <{map = #map1}> : (index, index, index) -> index
      %15 = "memref.subview"(%10, %14) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 32>, static_strides = array<i64: 1>}> : (memref<128xf32, strided<[1], offset: ?>>, index) -> memref<32xf32, strided<[1], offset: ?>>
      "vector.transfer_write"(%4, %15, %3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map2}> : (vector<32xf32>, memref<32xf32, strided<[1], offset: ?>>, index) -> ()
      "gpu.barrier"() : () -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"(%arg1) : (memref<128xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.gpu.map_forall_to_blocks"(%0) <{generate_gpu_launch}> : (!transform.any_op) -> !transform.any_op
      %2 = "transform.gpu.map_nested_forall_to_threads"(%1) <{block_dims = array<i64: 4, 8, 4>, sync_after_distribute = true, warp_size = 32 : i64}> : (!transform.any_op) -> !transform.any_op
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 * 128)>
#map1 = affine_map<()[s0, s1] -> ((s0 + s1 * 73) mod 32)>
#map2 = affine_map<()[s0, s1] -> (s0 * 32 + s1 * 2336 - ((s0 + s1 * 73) floordiv 2) * 64)>
#map3 = affine_map<()[s0, s1] -> ((((s0 + s1 * 73) mod 32) floordiv 2) * 32)>
#map4 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x256xf32>) -> memref<128x256xf32>, sym_name = "simple_fill"}> ({
  ^bb0(%arg1: memref<128x256xf32>):
    %3 = "arith.constant"() <{value = 6 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "arith.constant"() <{value = dense<0.000000e+00> : vector<16x32xf32>}> : () -> vector<16x32xf32>
    %6 = "arith.constant"() <{value = 1 : index}> : () -> index
    %7 = "arith.constant"() <{value = 73 : index}> : () -> index
    %8 = "arith.constant"() <{value = 5 : index}> : () -> index
    "gpu.launch"(%6, %6, %6, %7, %8, %6) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index):
      %9 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %10 = "affine.apply"(%9) <{map = #map}> : (index) -> index
      %11 = "memref.subview"(%arg1, %10) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 128, 256>, static_strides = array<i64: 1, 1>}> : (memref<128x256xf32>, index) -> memref<128x256xf32, strided<[256, 1], offset: ?>>
      %12 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %13 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %14 = "affine.apply"(%12, %13) <{map = #map1}> : (index, index) -> index
      %15 = "arith.cmpi"(%14, %3) <{predicate = 6 : i64}> : (index, index) -> i1
      "scf.if"(%15) ({
        %16 = "affine.apply"(%12, %13) <{map = #map2}> : (index, index) -> index
        %17 = "affine.apply"(%12, %13) <{map = #map3}> : (index, index) -> index
        %18 = "memref.subview"(%11, %16, %17) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 16, 32>, static_strides = array<i64: 1, 1>}> : (memref<128x256xf32, strided<[256, 1], offset: ?>>, index, index) -> memref<16x32xf32, strided<[256, 1], offset: ?>>
        "vector.transfer_write"(%5, %18, %4, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map4}> : (vector<16x32xf32>, memref<16x32xf32, strided<[256, 1], offset: ?>>, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "gpu.barrier"() : () -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"(%arg1) : (memref<128x256xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.gpu.map_forall_to_blocks"(%0) <{generate_gpu_launch}> : (!transform.any_op) -> !transform.any_op
      %2 = "transform.gpu.map_nested_forall_to_threads"(%1) <{block_dims = array<i64: 73, 5, 1>, sync_after_distribute = true, warp_size = 32 : i64}> : (!transform.any_op) -> !transform.any_op
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 * 128)>
#map1 = affine_map<()[s0, s1] -> ((s0 + s1 * 73) floordiv 32)>
#map2 = affine_map<()[s0] -> (s0 * 32 - (s0 floordiv 2) * 64)>
#map3 = affine_map<()[s0] -> ((s0 floordiv 2) * 32)>
#map4 = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128xf32>) -> memref<128xf32>, sym_name = "simple_fill"}> ({
  ^bb0(%arg1: memref<128xf32>):
    %3 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %4 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %5 = "arith.constant"() <{value = 753 : i64}> : () -> i64
    %6 = "arith.constant"() <{value = 0 : index}> : () -> index
    %7 = "arith.constant"() <{value = dense<0.000000e+00> : vector<32xf32>}> : () -> vector<32xf32>
    %8 = "arith.constant"() <{value = 1 : index}> : () -> index
    %9 = "arith.constant"() <{value = 73 : index}> : () -> index
    %10 = "arith.constant"() <{value = 5 : index}> : () -> index
    "gpu.launch"(%8, %8, %8, %9, %10, %8) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index):
      %11 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %12 = "affine.apply"(%11) <{map = #map}> : (index) -> index
      %13 = "memref.subview"(%arg1, %12) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (memref<128xf32>, index) -> memref<128xf32, strided<[1], offset: ?>>
      %14 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %15 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %16 = "affine.apply"(%14, %15) <{map = #map1}> : (index, index) -> index
      %17 = "arith.index_castui"(%16) : (index) -> i64
      %18 = "arith.shli"(%4, %17) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %19 = "arith.subi"(%18, %4) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %20 = "arith.andi"(%19, %5) : (i64, i64) -> i64
      %21 = "math.ctpop"(%20) : (i64) -> i64
      %22 = "arith.index_castui"(%21) : (i64) -> index
      %23 = "arith.andi"(%18, %5) : (i64, i64) -> i64
      %24 = "arith.cmpi"(%23, %3) <{predicate = 1 : i64}> : (i64, i64) -> i1
      "scf.if"(%24) ({
        %25 = "affine.apply"(%22) <{map = #map2}> : (index) -> index
        %26 = "affine.apply"(%22) <{map = #map3}> : (index) -> index
        %27 = "memref.subview"(%13, %25, %26) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<128xf32, strided<[1], offset: ?>>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
        "vector.transfer_write"(%7, %27, %6) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map4}> : (vector<32xf32>, memref<?xf32, strided<[1], offset: ?>>, index) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "gpu.barrier"() : () -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"(%arg1) : (memref<128xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.gpu.map_forall_to_blocks"(%0) <{generate_gpu_launch}> : (!transform.any_op) -> !transform.any_op
      %2 = "transform.gpu.map_nested_forall_to_threads"(%1) <{block_dims = array<i64: 73, 5, 1>, sync_after_distribute = true, warp_size = 32 : i64}> : (!transform.any_op) -> !transform.any_op
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

