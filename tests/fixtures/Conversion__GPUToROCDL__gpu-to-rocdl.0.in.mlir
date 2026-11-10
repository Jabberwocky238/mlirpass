"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = () -> (index, index, index, index, index, index, index, index, index, index, index, index, index, index, index), sym_name = "gpu_index_ops"}> ({
      %0 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %2 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %3 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %4 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %5 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %6 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %7 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %8 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %9 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %10 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %11 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %12 = "gpu.lane_id"() : () -> index
      %13 = "gpu.subgroup_size"() : () -> index
      %14 = "gpu.subgroup_size"() <{upper_bound = 64 : index}> : () -> index
      "func.return"(%0, %1, %2, %3, %4, %5, %6, %7, %8, %9, %10, %11, %12, %13, %14) : (index, index, index, index, index, index, index, index, index, index, index, index, index, index, index) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "gpu.func"() <{function_type = (memref<i32>) -> (), kernel, known_block_size = array<i32: 8, 12, 16>, known_grid_size = array<i32: 20, 24, 28>}> ({
    ^bb0(%arg0: memref<i32>):
      %0 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %2 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %3 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %4 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %5 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %6 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %7 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %8 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %9 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %10 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %11 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %12 = "arith.addi"(%0, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %13 = "arith.addi"(%12, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %14 = "arith.addi"(%13, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %15 = "arith.addi"(%14, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %16 = "arith.addi"(%15, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %17 = "arith.addi"(%16, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %18 = "arith.addi"(%17, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %19 = "arith.addi"(%18, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %20 = "arith.addi"(%19, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %21 = "arith.addi"(%20, %10) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %22 = "arith.addi"(%21, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %23 = "arith.index_cast"(%22) : (index) -> i32
      "memref.store"(%23, %arg0) : (i32, memref<i32>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "gpu_index_ops_range"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (index) -> index, sym_name = "gpu_index_comp"}> ({
    ^bb0(%arg0: index):
      %0 = "arith.addi"(%arg0, %arg0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "func.return"(%0) : (index) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_sqrt"}> ({
    ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
      %0 = "math.sqrt"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %1 = "math.sqrt"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %2 = "math.sqrt"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_fabs"}> ({
    ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
      %0 = "math.absf"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %1 = "math.absf"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %2 = "math.absf"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_exp"}> ({
    ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
      %0 = "math.exp"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %1 = "math.exp"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %2 = "math.exp"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_log"}> ({
    ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
      %0 = "math.log"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %1 = "math.log"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %2 = "math.log"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_cbrt"}> ({
    ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
      %0 = "math.cbrt"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %1 = "math.cbrt"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %2 = "math.cbrt"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_ceil"}> ({
    ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
      %0 = "math.ceil"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %1 = "math.ceil"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %2 = "math.ceil"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_floor"}> ({
    ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
      %0 = "math.floor"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %1 = "math.floor"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %2 = "math.floor"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_cos"}> ({
    ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
      %0 = "math.cos"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %1 = "math.cos"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %2 = "math.cos"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_exp2"}> ({
    ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
      %0 = "math.exp2"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %1 = "math.exp2"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %2 = "math.exp2"(%1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %3 = "math.exp2"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%0, %2, %3) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "test.symbol_scope"() ({
      "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_sin"}> ({
      ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
        %0 = "math.sin"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
        %1 = "math.sin"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        %2 = "math.sin"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
        "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
      }) : () -> ()
      "test.finish"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_expm1"}> ({
    ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
      %0 = "math.expm1"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %1 = "math.expm1"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %2 = "math.expm1"(%1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %3 = "math.expm1"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%0, %2, %3) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (f16, f64) -> (f16, f64), sym_name = "gpu_log"}> ({
    ^bb0(%arg0: f16, %arg1: f64):
      %0 = "math.log"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %1 = "math.log"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%0, %1) : (f16, f64) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_log1p"}> ({
    ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
      %0 = "math.log1p"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %1 = "math.log1p"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %2 = "math.log1p"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_log10"}> ({
    ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
      %0 = "math.log10"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %1 = "math.log10"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %2 = "math.log10"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_log2"}> ({
    ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
      %0 = "math.log2"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %1 = "math.log2"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %2 = "math.log2"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_rsqrt"}> ({
    ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
      %0 = "math.rsqrt"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %1 = "math.rsqrt"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %2 = "math.rsqrt"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_tan"}> ({
    ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
      %0 = "math.tan"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %1 = "math.tan"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %2 = "math.tan"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_tanh"}> ({
    ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
      %0 = "math.tanh"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %1 = "math.tanh"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %2 = "math.tanh"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_atan"}> ({
    ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
      %0 = "math.atan"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %1 = "math.atan"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %2 = "math.atan"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_atan2"}> ({
    ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
      %0 = "math.atan2"(%arg0, %arg0) <{fastmath = #arith.fastmath<none>}> : (f16, f16) -> f16
      %1 = "math.atan2"(%arg1, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %2 = "math.atan2"(%arg2, %arg2) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
      "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_pow"}> ({
    ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
      %0 = "math.powf"(%arg0, %arg0) <{fastmath = #arith.fastmath<none>}> : (f16, f16) -> f16
      %1 = "math.powf"(%arg1, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %2 = "math.powf"(%arg2, %arg2) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
      "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_erf"}> ({
    ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
      %0 = "math.erf"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %1 = "math.erf"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %2 = "math.erf"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (vector<4xf32>) -> vector<4xf32>, sym_name = "gpu_unroll"}> ({
    ^bb0(%arg0: vector<4xf32>):
      %0 = "math.sin"(%arg0) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
      "func.return"(%0) : (vector<4xf32>) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (bf16) -> bf16, sym_name = "bf16_id"}> ({
    ^bb0(%arg1: bf16):
      "func.return"(%arg1) : (bf16) -> ()
    }) : () -> ()
    "func.func"() <{function_type = (vector<4xbf16>) -> vector<4xbf16>, sym_name = "bf16x4_id"}> ({
    ^bb0(%arg0: vector<4xbf16>):
      "func.return"(%arg0) : (vector<4xbf16>) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "gpu.func"() <{function_type = () -> (), kernel}> ({
      "gpu.return"() : () -> ()
    }) {sym_name = "kernel_func"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "module"}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xf32>) -> vector<4xf32>, sym_name = "spirv_sin"}> ({
    ^bb0(%arg0: vector<4xf32>):
      %0 = "math.sin"(%arg0) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
      "spirv.ReturnValue"(%0) : (vector<4xf32>) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %1 = "gpu.all_reduce"(%0) <{op = #gpu<all_reduce_op add>, uniform}> ({
      }) : (f32) -> f32
      "gpu.return"() : () -> ()
    }) {sym_name = "gpu_all_reduce_op"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %1 = "gpu.all_reduce"(%0) <{uniform}> ({
      ^bb0(%arg0: i32, %arg1: i32):
        %2 = "arith.xori"(%arg0, %arg1) : (i32, i32) -> i32
        "gpu.yield"(%2) : (i32) -> ()
      }) : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {sym_name = "gpu_all_reduce_region"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_fmod"}> ({
    ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
      %0 = "arith.remf"(%arg0, %arg0) <{fastmath = #arith.fastmath<none>}> : (f16, f16) -> f16
      %1 = "arith.remf"(%arg1, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %2 = "arith.remf"(%arg2, %arg2) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
      "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = () -> (f32, f32, f32, f32), sym_name = "gpu_shuffle"}> ({
      %9 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %10 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %11 = "arith.constant"() <{value = 23 : i32}> : () -> i32
      %12:2 = "gpu.shuffle"(%9, %10, %11) <{mode = #gpu<shuffle_mode xor>}> : (f32, i32, i32) -> (f32, i1)
      %13:2 = "gpu.shuffle"(%9, %10, %11) <{mode = #gpu<shuffle_mode idx>}> : (f32, i32, i32) -> (f32, i1)
      %14:2 = "gpu.shuffle"(%9, %10, %11) <{mode = #gpu<shuffle_mode up>}> : (f32, i32, i32) -> (f32, i1)
      %15:2 = "gpu.shuffle"(%9, %10, %11) <{mode = #gpu<shuffle_mode down>}> : (f32, i32, i32) -> (f32, i1)
      "func.return"(%12#0, %13#0, %14#0, %15#0) : (f32, f32, f32, f32) -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (f32, f32, f32), sym_name = "gpu_shuffle_promote"}> ({
      %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %2 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %3 = "arith.constant"() <{value = 16 : i32}> : () -> i32
      %4 = "arith.constant"() <{value = 32 : i32}> : () -> i32
      %5 = "arith.constant"() <{value = 64 : i32}> : () -> i32
      %6:2 = "gpu.shuffle"(%1, %2, %5) <{mode = #gpu<shuffle_mode xor>}> : (f32, i32, i32) -> (f32, i1)
      %7:2 = "gpu.shuffle"(%1, %3, %5) <{mode = #gpu<shuffle_mode xor>}> : (f32, i32, i32) -> (f32, i1)
      %8:2 = "gpu.shuffle"(%1, %4, %5) <{mode = #gpu<shuffle_mode xor>}> : (f32, i32, i32) -> (f32, i1)
      "func.return"(%6#0, %7#0, %8#0) : (f32, f32, f32) -> ()
    }) : () -> ()
    "func.func"() <{function_type = (vector<4xf16>, i32, i32) -> vector<4xf16>, sym_name = "gpu_shuffle_vec"}> ({
    ^bb0(%arg0: vector<4xf16>, %arg1: i32, %arg2: i32):
      %0:2 = "gpu.shuffle"(%arg0, %arg1, %arg2) <{mode = #gpu<shuffle_mode xor>}> : (vector<4xf16>, i32, i32) -> (vector<4xf16>, i1)
      "func.return"(%0#0) : (vector<4xf16>) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_custom_data_layout"}> ({
  ^bb0:
  }) {llvm.data_layout = "e"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = () -> index, sym_name = "gpu_dim_int_max_upper_bound"}> ({
      %0 = "gpu.block_dim"() <{dimension = #gpu<dim x>, upper_bound = 2147483647 : index}> : () -> index
      "func.return"(%0) : (index) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (index, i32) -> (index, index), sym_name = "broadcast"}> ({
    ^bb0(%arg8: index, %arg9: i32):
      %9 = "gpu.subgroup_broadcast"(%arg8) <{broadcast_type = #gpu<broadcast first_active_lane>}> : (index) -> index
      %10 = "gpu.subgroup_broadcast"(%arg8, %arg9) <{broadcast_type = #gpu<broadcast specific_lane>}> : (index, i32) -> index
      "func.return"(%9, %10) : (index, index) -> ()
    }) : () -> ()
    "func.func"() <{function_type = (i8, i32) -> (i8, i8), sym_name = "broadcast_i8"}> ({
    ^bb0(%arg6: i8, %arg7: i32):
      %7 = "gpu.subgroup_broadcast"(%arg6) <{broadcast_type = #gpu<broadcast first_active_lane>}> : (i8) -> i8
      %8 = "gpu.subgroup_broadcast"(%arg6, %arg7) <{broadcast_type = #gpu<broadcast specific_lane>}> : (i8, i32) -> i8
      "func.return"(%7, %8) : (i8, i8) -> ()
    }) : () -> ()
    "func.func"() <{function_type = (vector<4xi16>) -> vector<4xi16>, sym_name = "broadcast_4xi16"}> ({
    ^bb0(%arg5: vector<4xi16>):
      %6 = "gpu.subgroup_broadcast"(%arg5) <{broadcast_type = #gpu<broadcast first_active_lane>}> : (vector<4xi16>) -> vector<4xi16>
      "func.return"(%6) : (vector<4xi16>) -> ()
    }) : () -> ()
    "func.func"() <{function_type = (vector<2x2xi16>) -> vector<2x2xi16>, sym_name = "broadcast_2x2xi16"}> ({
    ^bb0(%arg4: vector<2x2xi16>):
      %5 = "gpu.subgroup_broadcast"(%arg4) <{broadcast_type = #gpu<broadcast first_active_lane>}> : (vector<2x2xi16>) -> vector<2x2xi16>
      "func.return"(%5) : (vector<2x2xi16>) -> ()
    }) : () -> ()
    "func.func"() <{function_type = (memref<?xi32>) -> memref<?xi32>, sym_name = "broadcast_memref"}> ({
    ^bb0(%arg3: memref<?xi32>):
      %4 = "gpu.subgroup_broadcast"(%arg3) <{broadcast_type = #gpu<broadcast first_active_lane>}> : (memref<?xi32>) -> memref<?xi32>
      "func.return"(%4) : (memref<?xi32>) -> ()
    }) : () -> ()
    "func.func"() <{function_type = (i48) -> i48, sym_name = "broadcast_i48"}> ({
    ^bb0(%arg2: i48):
      %3 = "gpu.subgroup_broadcast"(%arg2) <{broadcast_type = #gpu<broadcast first_active_lane>}> : (i48) -> i48
      "func.return"(%3) : (i48) -> ()
    }) : () -> ()
    "func.func"() <{function_type = (vector<3xi16>) -> vector<3xi16>, sym_name = "broadcast_3xi16"}> ({
    ^bb0(%arg1: vector<3xi16>):
      %2 = "gpu.subgroup_broadcast"(%arg1) <{broadcast_type = #gpu<broadcast first_active_lane>}> : (vector<3xi16>) -> vector<3xi16>
      "func.return"(%2) : (vector<3xi16>) -> ()
    }) : () -> ()
    "func.func"() <{function_type = (i1) -> (i32, i64), sym_name = "ballot"}> ({
    ^bb0(%arg0: i1):
      %0 = "gpu.ballot"(%arg0) : (i1) -> i32
      %1 = "gpu.ballot"(%arg0) : (i1) -> i64
      "func.return"(%0, %1) : (i32, i64) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

