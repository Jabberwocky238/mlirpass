"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x32xf32>, memref<2x32xf32>, memref<32xf32>, f32, !gpu.async.token) -> memref<2x32xf32>, sym_name = "blocks_3d"}> ({
  ^bb0(%arg1: memref<2x32xf32>, %arg2: memref<2x32xf32>, %arg3: memref<32xf32>, %arg4: f32, %arg5: !gpu.async.token):
    %2 = "arith.constant"() <{value = 9 : index}> : () -> index
    %3 = "arith.constant"() <{value = 7 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "gpu.launch"(%arg5, %4, %4, %4, %4, %4, %4) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: index, %arg17: index):
      "scf.forall"(%3, %2) <{mapping = [#gpu.block<x>, #gpu.block<y>], operandSegmentSizes = array<i32: 0, 2, 0, 0>, staticLowerBound = array<i64: 0, 0>, staticStep = array<i64: 1, 1>, staticUpperBound = array<i64: -9223372036854775808, -9223372036854775808>}> ({
      ^bb0(%arg18: index, %arg19: index):
        %6 = "memref.load"(%arg1, %arg18, %arg19) : (memref<2x32xf32>, index, index) -> f32
        %7 = "memref.load"(%arg2, %arg18, %arg19) : (memref<2x32xf32>, index, index) -> f32
        %8 = "math.fma"(%arg4, %6, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
        "memref.store"(%8, %arg2, %arg18, %arg19) : (f32, memref<2x32xf32>, index, index) -> ()
        "scf.forall.in_parallel"() ({
        ^bb0:
        }) : () -> ()
      }) : (index, index) -> ()
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
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x32xf32>, memref<2x32xf32>, memref<32xf32>, f32, !gpu.async.token) -> memref<2x32xf32>, sym_name = "warpgroup_3d"}> ({
  ^bb0(%arg1: memref<2x32xf32>, %arg2: memref<2x32xf32>, %arg3: memref<32xf32>, %arg4: f32, %arg5: !gpu.async.token):
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 3 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "gpu.launch"(%arg5, %4, %4, %4, %4, %4, %4) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: index, %arg17: index):
      "scf.forall"(%3, %2) <{mapping = [#gpu.warpgroup<x>, #gpu.warpgroup<y>], operandSegmentSizes = array<i32: 0, 2, 0, 0>, staticLowerBound = array<i64: 0, 0>, staticStep = array<i64: 1, 1>, staticUpperBound = array<i64: -9223372036854775808, -9223372036854775808>}> ({
      ^bb0(%arg18: index, %arg19: index):
        %6 = "memref.load"(%arg1, %arg18, %arg19) : (memref<2x32xf32>, index, index) -> f32
        %7 = "memref.load"(%arg2, %arg18, %arg19) : (memref<2x32xf32>, index, index) -> f32
        %8 = "math.fma"(%arg4, %6, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
        "memref.store"(%8, %arg2, %arg18, %arg19) : (f32, memref<2x32xf32>, index, index) -> ()
        "scf.forall.in_parallel"() ({
        ^bb0:
        }) : () -> ()
      }) : (index, index) -> ()
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
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x32xf32>, memref<2x32xf32>, memref<32xf32>, f32, !gpu.async.token) -> memref<2x32xf32>, sym_name = "warp_3d"}> ({
  ^bb0(%arg1: memref<2x32xf32>, %arg2: memref<2x32xf32>, %arg3: memref<32xf32>, %arg4: f32, %arg5: !gpu.async.token):
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "arith.constant"() <{value = 3 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "gpu.launch"(%arg5, %4, %4, %4, %4, %4, %4) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: index, %arg17: index):
      "scf.forall"(%2, %3, %3) <{mapping = [#gpu.warp<x>, #gpu.warp<y>, #gpu.warp<z>], operandSegmentSizes = array<i32: 0, 3, 0, 0>, staticLowerBound = array<i64: 0, 0, 0>, staticStep = array<i64: 1, 1, 1>, staticUpperBound = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> ({
      ^bb0(%arg18: index, %arg19: index, %arg20: index):
        %6 = "memref.load"(%arg1, %arg18, %arg19) : (memref<2x32xf32>, index, index) -> f32
        %7 = "memref.load"(%arg2, %arg18, %arg19) : (memref<2x32xf32>, index, index) -> f32
        %8 = "math.fma"(%arg4, %6, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
        "memref.store"(%8, %arg2, %arg18, %arg19) : (f32, memref<2x32xf32>, index, index) -> ()
        "scf.forall.in_parallel"() ({
        ^bb0:
        }) : () -> ()
      }) : (index, index, index) -> ()
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
    %6 = "gpu.launch"(%arg5, %2, %2, %2, %2, %2, %2) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: index, %arg17: index):
      "scf.forall"(%5, %4) <{mapping = [#gpu.thread<y>, #gpu.thread<x>], operandSegmentSizes = array<i32: 0, 2, 0, 0>, staticLowerBound = array<i64: 0, 0>, staticStep = array<i64: 1, 1>, staticUpperBound = array<i64: -9223372036854775808, -9223372036854775808>}> ({
      ^bb0(%arg19: index, %arg20: index):
        %9 = "memref.load"(%arg1, %arg19, %arg20) : (memref<2x32xf32>, index, index) -> f32
        %10 = "memref.load"(%arg2, %arg19, %arg20) : (memref<2x32xf32>, index, index) -> f32
        %11 = "math.fma"(%arg4, %9, %10) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
        "memref.store"(%11, %arg2, %arg19, %arg20) : (f32, memref<2x32xf32>, index, index) -> ()
        "scf.forall.in_parallel"() ({
        ^bb0:
        }) : () -> ()
      }) : (index, index) -> ()
      "scf.forall"(%3) <{mapping = [#gpu.thread<x>], operandSegmentSizes = array<i32: 0, 1, 0, 0>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
      ^bb0(%arg18: index):
        %7 = "memref.load"(%arg3, %arg18) : (memref<32xf32>, index) -> f32
        %8 = "arith.addf"(%arg4, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "memref.store"(%8, %arg3, %arg18) : (f32, memref<32xf32>, index) -> ()
        "scf.forall.in_parallel"() ({
        ^bb0:
        }) : () -> ()
      }) : (index) -> ()
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
    "scf.forall"(%3, %4) <{mapping = [#gpu.block<x>, #gpu.block<y>], operandSegmentSizes = array<i32: 0, 2, 0, 0>, staticLowerBound = array<i64: 0, 0>, staticStep = array<i64: 1, 1>, staticUpperBound = array<i64: -9223372036854775808, -9223372036854775808>}> ({
    ^bb0(%arg4: index, %arg5: index):
      "scf.forall"(%5, %3) <{mapping = [#gpu.thread<y>, #gpu.thread<x>], operandSegmentSizes = array<i32: 0, 2, 0, 0>, staticLowerBound = array<i64: 0, 0>, staticStep = array<i64: 1, 1>, staticUpperBound = array<i64: -9223372036854775808, -9223372036854775808>}> ({
      ^bb0(%arg6: index, %arg7: index):
        %6 = "memref.load"(%arg1, %arg4, %arg5, %arg6, %arg7) : (memref<32x64x4x32xf32>, index, index, index, index) -> f32
        %7 = "memref.load"(%arg2, %arg4, %arg5, %arg6, %arg7) : (memref<32x64x4x32xf32>, index, index, index, index) -> f32
        %8 = "math.fma"(%arg3, %6, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
        "memref.store"(%8, %arg2, %arg4, %arg5, %arg6, %arg7) : (f32, memref<32x64x4x32xf32>, index, index, index, index) -> ()
        "scf.forall.in_parallel"() ({
        ^bb0:
        }) : () -> ()
      }) : (index, index) -> ()
      "scf.forall.in_parallel"() ({
      ^bb0:
      }) : () -> ()
    }) : (index, index) -> ()
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
    %6 = "gpu.launch"(%arg5, %2, %2, %2, %2, %2, %2) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: index, %arg17: index):
      "scf.forall"(%5, %4) <{mapping = [#gpu.thread<y>, #gpu.thread<x>], operandSegmentSizes = array<i32: 0, 2, 0, 0>, staticLowerBound = array<i64: 0, 0>, staticStep = array<i64: 1, 1>, staticUpperBound = array<i64: -9223372036854775808, -9223372036854775808>}> ({
      ^bb0(%arg18: index, %arg19: index):
        %7 = "memref.load"(%arg1, %arg18, %arg19) : (memref<2x32xf32>, index, index) -> f32
        %8 = "memref.load"(%arg2, %arg18, %arg19) : (memref<2x32xf32>, index, index) -> f32
        %9 = "math.fma"(%arg4, %7, %8) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
        "memref.store"(%9, %arg2, %arg18, %arg19) : (f32, memref<2x32xf32>, index, index) -> ()
        "scf.forall.in_parallel"() ({
        ^bb0:
        }) : () -> ()
      }) : (index, index) -> ()
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
    %4 = "gpu.launch"(%arg3, %3, %3, %3, %3, %3, %3) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index):
      "scf.forall"(%2) <{mapping = [#gpu.thread<x>], operandSegmentSizes = array<i32: 0, 1, 0, 0>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
      ^bb0(%arg16: index):
        %5 = "memref.load"(%arg1, %arg16, %arg16) : (memref<32x32xf32>, index, index) -> f32
        %6 = "memref.load"(%arg2, %arg16, %arg16) : (memref<32x32xf32>, index, index) -> f32
        %7 = "arith.mulf"(%5, %6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "memref.store"(%7, %arg2, %arg16, %arg16) : (f32, memref<32x32xf32>, index, index) -> ()
        "scf.forall.in_parallel"() ({
        ^bb0:
        }) : () -> ()
      }) : (index) -> ()
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
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 12 : index}> : () -> index
    %4 = "arith.constant"() <{value = 9 : index}> : () -> index
    %5 = "arith.constant"() <{value = 7 : index}> : () -> index
    %6 = "gpu.launch"(%arg5, %2, %2, %2, %2, %2, %2) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: index, %arg17: index):
      "scf.forall"(%2, %5, %4) <{mapping = [#gpu.thread<z>, #gpu.thread<y>, #gpu.thread<x>], operandSegmentSizes = array<i32: 0, 3, 0, 0>, staticLowerBound = array<i64: 0, 0, 0>, staticStep = array<i64: 1, 1, 1>, staticUpperBound = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> ({
      ^bb0(%arg18: index, %arg19: index, %arg20: index):
        %7 = "memref.load"(%arg1, %arg18, %arg19, %arg20) : (memref<3x2x32xf32>, index, index, index) -> f32
        %8 = "memref.load"(%arg2, %arg18, %arg19, %arg20) : (memref<3x2x32xf32>, index, index, index) -> f32
        %9 = "math.fma"(%arg4, %7, %8) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
        "memref.store"(%9, %arg2, %arg18, %arg19, %arg20) : (f32, memref<3x2x32xf32>, index, index, index) -> ()
        "scf.forall.in_parallel"() ({
        ^bb0:
        }) : () -> ()
      }) : (index, index, index) -> ()
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
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x32xf32>, memref<2x32xf32>, memref<32xf32>, f32, !gpu.async.token) -> memref<2x32xf32>, sym_name = "warpgroup_linear"}> ({
  ^bb0(%arg1: memref<2x32xf32>, %arg2: memref<2x32xf32>, %arg3: memref<32xf32>, %arg4: f32, %arg5: !gpu.async.token):
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "arith.constant"() <{value = 3 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "gpu.launch"(%arg5, %4, %4, %4, %4, %4, %4) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: index, %arg17: index):
      "scf.forall"(%2, %3) <{mapping = [#gpu.warpgroup<linear_dim_0>, #gpu.warpgroup<linear_dim_1>], operandSegmentSizes = array<i32: 0, 2, 0, 0>, staticLowerBound = array<i64: 0, 0>, staticStep = array<i64: 1, 1>, staticUpperBound = array<i64: -9223372036854775808, -9223372036854775808>}> ({
      ^bb0(%arg18: index, %arg19: index):
        %6 = "memref.load"(%arg1, %arg18, %arg19) : (memref<2x32xf32>, index, index) -> f32
        %7 = "memref.load"(%arg2, %arg18, %arg19) : (memref<2x32xf32>, index, index) -> f32
        %8 = "math.fma"(%arg4, %6, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
        "memref.store"(%8, %arg2, %arg18, %arg19) : (f32, memref<2x32xf32>, index, index) -> ()
        "scf.forall.in_parallel"() ({
        ^bb0:
        }) : () -> ()
      }) : (index, index) -> ()
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
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x32xf32>, memref<2x32xf32>, memref<32xf32>, f32, !gpu.async.token) -> memref<2x32xf32>, sym_name = "warp_linear"}> ({
  ^bb0(%arg1: memref<2x32xf32>, %arg2: memref<2x32xf32>, %arg3: memref<32xf32>, %arg4: f32, %arg5: !gpu.async.token):
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "arith.constant"() <{value = 3 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "gpu.launch"(%arg5, %4, %4, %4, %4, %4, %4) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: index, %arg17: index):
      "scf.forall"(%2, %3) <{mapping = [#gpu.warp<linear_dim_0>, #gpu.warp<linear_dim_1>], operandSegmentSizes = array<i32: 0, 2, 0, 0>, staticLowerBound = array<i64: 0, 0>, staticStep = array<i64: 1, 1>, staticUpperBound = array<i64: -9223372036854775808, -9223372036854775808>}> ({
      ^bb0(%arg18: index, %arg19: index):
        %6 = "memref.load"(%arg1, %arg18, %arg19) : (memref<2x32xf32>, index, index) -> f32
        %7 = "memref.load"(%arg2, %arg18, %arg19) : (memref<2x32xf32>, index, index) -> f32
        %8 = "math.fma"(%arg4, %6, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
        "memref.store"(%8, %arg2, %arg18, %arg19) : (f32, memref<2x32xf32>, index, index) -> ()
        "scf.forall.in_parallel"() ({
        ^bb0:
        }) : () -> ()
      }) : (index, index) -> ()
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
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x32xf32>, memref<2x32xf32>, memref<32xf32>, f32, !gpu.async.token) -> memref<2x32xf32>, sym_name = "map_multi_level_linear"}> ({
  ^bb0(%arg1: memref<2x32xf32>, %arg2: memref<2x32xf32>, %arg3: memref<32xf32>, %arg4: f32, %arg5: !gpu.async.token):
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 10 : index}> : () -> index
    %4 = "arith.constant"() <{value = 9 : index}> : () -> index
    %5 = "arith.constant"() <{value = 7 : index}> : () -> index
    %6 = "arith.constant"() <{value = 1 : index}> : () -> index
    %7 = "arith.constant"() <{value = 2 : index}> : () -> index
    %8 = "arith.constant"() <{value = 3 : index}> : () -> index
    %9 = "gpu.launch"(%arg5, %2, %2, %2, %2, %2, %2) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: index, %arg17: index):
      "scf.forall"(%5, %4) <{mapping = [#gpu.thread<y>, #gpu.thread<x>], operandSegmentSizes = array<i32: 0, 2, 0, 0>, staticLowerBound = array<i64: 0, 0>, staticStep = array<i64: 1, 1>, staticUpperBound = array<i64: -9223372036854775808, -9223372036854775808>}> ({
      ^bb0(%arg23: index, %arg24: index):
        %14 = "memref.load"(%arg1, %arg23, %arg24) : (memref<2x32xf32>, index, index) -> f32
        %15 = "memref.load"(%arg2, %arg23, %arg24) : (memref<2x32xf32>, index, index) -> f32
        %16 = "math.fma"(%arg4, %14, %15) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
        "memref.store"(%16, %arg2, %arg23, %arg24) : (f32, memref<2x32xf32>, index, index) -> ()
        "scf.forall.in_parallel"() ({
        ^bb0:
        }) : () -> ()
      }) : (index, index) -> ()
      "scf.forall"(%8, %7, %6) <{mapping = [#gpu.warp<linear_dim_0>, #gpu.warp<linear_dim_1>, #gpu.warp<linear_dim_2>], operandSegmentSizes = array<i32: 0, 3, 0, 0>, staticLowerBound = array<i64: 0, 0, 0>, staticStep = array<i64: 1, 1, 1>, staticUpperBound = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> ({
      ^bb0(%arg20: index, %arg21: index, %arg22: index):
        %12 = "memref.load"(%arg1, %arg20, %arg21) : (memref<2x32xf32>, index, index) -> f32
        %13 = "arith.addf"(%arg4, %12) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "memref.store"(%13, %arg2, %arg20, %arg21) : (f32, memref<2x32xf32>, index, index) -> ()
        "scf.forall.in_parallel"() ({
        ^bb0:
        }) : () -> ()
      }) : (index, index, index) -> ()
      "scf.forall"(%3, %7) <{mapping = [#gpu.thread<linear_dim_0>, #gpu.thread<linear_dim_1>], operandSegmentSizes = array<i32: 0, 2, 0, 0>, staticLowerBound = array<i64: 0, 0>, staticStep = array<i64: 1, 1>, staticUpperBound = array<i64: -9223372036854775808, -9223372036854775808>}> ({
      ^bb0(%arg18: index, %arg19: index):
        %10 = "memref.load"(%arg3, %arg18) : (memref<32xf32>, index) -> f32
        %11 = "arith.addf"(%arg4, %10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "memref.store"(%11, %arg3, %arg19) : (f32, memref<32xf32>, index) -> ()
        "scf.forall.in_parallel"() ({
        ^bb0:
        }) : () -> ()
      }) : (index, index) -> ()
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
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x32xf32>, memref<2x32xf32>, memref<32xf32>, f32, !gpu.async.token) -> memref<2x32xf32>, sym_name = "block_linear_existing_launch"}> ({
  ^bb0(%arg1: memref<2x32xf32>, %arg2: memref<2x32xf32>, %arg3: memref<32xf32>, %arg4: f32, %arg5: !gpu.async.token):
    %2 = "arith.constant"() <{value = 9 : index}> : () -> index
    %3 = "arith.constant"() <{value = 7 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "gpu.launch"(%arg5, %4, %4, %4, %4, %4, %4) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: index, %arg17: index):
      "scf.forall"(%3, %2) <{mapping = [#gpu.block<linear_dim_0>, #gpu.block<linear_dim_1>], operandSegmentSizes = array<i32: 0, 2, 0, 0>, staticLowerBound = array<i64: 0, 0>, staticStep = array<i64: 1, 1>, staticUpperBound = array<i64: -9223372036854775808, -9223372036854775808>}> ({
      ^bb0(%arg18: index, %arg19: index):
        %6 = "memref.load"(%arg1, %arg18, %arg19) : (memref<2x32xf32>, index, index) -> f32
        %7 = "memref.load"(%arg2, %arg18, %arg19) : (memref<2x32xf32>, index, index) -> f32
        %8 = "math.fma"(%arg4, %6, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
        "memref.store"(%8, %arg2, %arg18, %arg19) : (f32, memref<2x32xf32>, index, index) -> ()
        "scf.forall.in_parallel"() ({
        ^bb0:
        }) : () -> ()
      }) : (index, index) -> ()
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
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x32xf32>, memref<2x32xf32>, memref<32xf32>, f32, !gpu.async.token) -> memref<2x32xf32>, sym_name = "block_linear_generate_launch"}> ({
  ^bb0(%arg1: memref<2x32xf32>, %arg2: memref<2x32xf32>, %arg3: memref<32xf32>, %arg4: f32, %arg5: !gpu.async.token):
    %2 = "arith.constant"() <{value = 9 : index}> : () -> index
    %3 = "arith.constant"() <{value = 7 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.forall"(%3, %2) <{mapping = [#gpu.block<linear_dim_0>, #gpu.block<linear_dim_1>], operandSegmentSizes = array<i32: 0, 2, 0, 0>, staticLowerBound = array<i64: 0, 0>, staticStep = array<i64: 1, 1>, staticUpperBound = array<i64: -9223372036854775808, -9223372036854775808>}> ({
    ^bb0(%arg6: index, %arg7: index):
      %5 = "memref.load"(%arg1, %arg6, %arg7) : (memref<2x32xf32>, index, index) -> f32
      %6 = "memref.load"(%arg2, %arg6, %arg7) : (memref<2x32xf32>, index, index) -> f32
      %7 = "math.fma"(%arg4, %5, %6) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
      "memref.store"(%7, %arg2, %arg6, %arg7) : (f32, memref<2x32xf32>, index, index) -> ()
      "scf.forall.in_parallel"() ({
      ^bb0:
      }) : () -> ()
    }) : (index, index) -> ()
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
#map = affine_map<(d0) -> (d0 * 128)>
#map1 = affine_map<(d0) -> (d0 * 32)>
#map2 = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128xf32>) -> memref<128xf32>, sym_name = "simple_fill"}> ({
  ^bb0(%arg1: memref<128xf32>):
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = dense<0.000000e+00> : vector<32xf32>}> : () -> vector<32xf32>
    "scf.forall"() <{mapping = [#gpu.block<x>], operandSegmentSizes = array<i32: 0, 0, 0, 0>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: 1>}> ({
    ^bb0(%arg2: index):
      %5 = "affine.apply"(%arg2) <{map = #map}> : (index) -> index
      %6 = "memref.subview"(%arg1, %5) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (memref<128xf32>, index) -> memref<128xf32, strided<[1], offset: ?>>
      "scf.forall"() <{mapping = [#gpu.warp<linear_dim_0>], operandSegmentSizes = array<i32: 0, 0, 0, 0>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: 4>}> ({
      ^bb0(%arg3: index):
        %7 = "affine.apply"(%arg3) <{map = #map1}> : (index) -> index
        %8 = "memref.subview"(%6, %7) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 32>, static_strides = array<i64: 1>}> : (memref<128xf32, strided<[1], offset: ?>>, index) -> memref<32xf32, strided<[1], offset: ?>>
        "vector.transfer_write"(%4, %8, %3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map2}> : (vector<32xf32>, memref<32xf32, strided<[1], offset: ?>>, index) -> ()
        "memref.copy"(%8, %8) : (memref<32xf32, strided<[1], offset: ?>>, memref<32xf32, strided<[1], offset: ?>>) -> ()
        "scf.forall.in_parallel"() ({
        ^bb0:
        }) : () -> ()
      }) : () -> ()
      "memref.copy"(%6, %6) : (memref<128xf32, strided<[1], offset: ?>>, memref<128xf32, strided<[1], offset: ?>>) -> ()
      "scf.forall.in_parallel"() ({
      ^bb0:
      }) : () -> ()
    }) : () -> ()
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
#map = affine_map<(d0) -> (d0 * 128)>
#map1 = affine_map<(d0) -> (d0 * 32)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x256xf32>) -> memref<128x256xf32>, sym_name = "simple_fill"}> ({
  ^bb0(%arg1: memref<128x256xf32>):
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = dense<0.000000e+00> : vector<16x32xf32>}> : () -> vector<16x32xf32>
    "scf.forall"() <{mapping = [#gpu.block<x>], operandSegmentSizes = array<i32: 0, 0, 0, 0>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: 1>}> ({
    ^bb0(%arg2: index):
      %5 = "affine.apply"(%arg2) <{map = #map}> : (index) -> index
      %6 = "memref.subview"(%arg1, %5) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 128, 256>, static_strides = array<i64: 1, 1>}> : (memref<128x256xf32>, index) -> memref<128x256xf32, strided<[256, 1], offset: ?>>
      "scf.forall"() <{mapping = [#gpu.lane<linear_dim_0>, #gpu.lane<linear_dim_1>], operandSegmentSizes = array<i32: 0, 0, 0, 0>, staticLowerBound = array<i64: 0, 0>, staticStep = array<i64: 1, 1>, staticUpperBound = array<i64: 2, 3>}> ({
      ^bb0(%arg3: index, %arg4: index):
        %7 = "affine.apply"(%arg3) <{map = #map1}> : (index) -> index
        %8 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
        %9 = "memref.subview"(%6, %7, %8) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 16, 32>, static_strides = array<i64: 1, 1>}> : (memref<128x256xf32, strided<[256, 1], offset: ?>>, index, index) -> memref<16x32xf32, strided<[256, 1], offset: ?>>
        "vector.transfer_write"(%4, %9, %3, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map2}> : (vector<16x32xf32>, memref<16x32xf32, strided<[256, 1], offset: ?>>, index, index) -> ()
        "scf.forall.in_parallel"() ({
        ^bb0:
        }) : () -> ()
      }) : () -> ()
      "scf.forall.in_parallel"() ({
      ^bb0:
      }) : () -> ()
    }) : () -> ()
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
#map = affine_map<(d0) -> (d0 * 128)>
#map1 = affine_map<(d0) -> (d0 * 32)>
#map2 = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128xf32>) -> memref<128xf32>, sym_name = "simple_fill"}> ({
  ^bb0(%arg1: memref<128xf32>):
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = dense<0.000000e+00> : vector<32xf32>}> : () -> vector<32xf32>
    "scf.forall"() <{mapping = [#gpu.block<x>], operandSegmentSizes = array<i32: 0, 0, 0, 0>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: 1>}> ({
    ^bb0(%arg2: index):
      %5 = "affine.apply"(%arg2) <{map = #map}> : (index) -> index
      %6 = "memref.subview"(%arg1, %5) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (memref<128xf32>, index) -> memref<128xf32, strided<[1], offset: ?>>
      "scf.forall"() <{mapping = [#gpu.warp<linear_dim_0>, #gpu.warp<linear_dim_1>, #gpu.mask<753>], operandSegmentSizes = array<i32: 0, 0, 0, 0>, staticLowerBound = array<i64: 0, 0>, staticStep = array<i64: 1, 1>, staticUpperBound = array<i64: 2, 3>}> ({
      ^bb0(%arg3: index, %arg4: index):
        %7 = "affine.apply"(%arg3) <{map = #map1}> : (index) -> index
        %8 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
        %9 = "memref.subview"(%6, %7, %8) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<128xf32, strided<[1], offset: ?>>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
        "vector.transfer_write"(%4, %9, %3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map2}> : (vector<32xf32>, memref<?xf32, strided<[1], offset: ?>>, index) -> ()
        "scf.forall.in_parallel"() ({
        ^bb0:
        }) : () -> ()
      }) : () -> ()
      "memref.copy"(%6, %6) : (memref<128xf32, strided<[1], offset: ?>>, memref<128xf32, strided<[1], offset: ?>>) -> ()
      "scf.forall.in_parallel"() ({
      ^bb0:
      }) : () -> ()
    }) : () -> ()
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

