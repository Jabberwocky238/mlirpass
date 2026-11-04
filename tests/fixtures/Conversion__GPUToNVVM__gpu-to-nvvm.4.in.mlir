"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module_0"}> ({
    "func.func"() <{function_type = () -> (index, index, index, index, index, index, index, index, index, index, index, index, index), sym_name = "gpu_index_ops"}> ({
      %163 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %164 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %165 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %166 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %167 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %168 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %169 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %170 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %171 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %172 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %173 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %174 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %175 = "gpu.lane_id"() : () -> index
      "func.return"(%163, %164, %165, %166, %167, %168, %169, %170, %171, %172, %173, %174, %175) : (index, index, index, index, index, index, index, index, index, index, index, index, index) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_1"}> ({
    "func.func"() <{function_type = (index) -> index, sym_name = "gpu_index_comp"}> ({
    ^bb0(%arg113: index):
      %162 = "arith.addi"(%arg113, %arg113) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "func.return"(%162) : (index) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_2"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %160 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %161 = "gpu.all_reduce"(%160) <{op = #gpu<all_reduce_op add>, uniform}> ({
      }) : (f32) -> f32
      "gpu.return"() : () -> ()
    }) {sym_name = "gpu_all_reduce_op", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_3"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %157 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %158 = "gpu.all_reduce"(%157) <{uniform}> ({
      ^bb0(%arg111: i32, %arg112: i32):
        %159 = "arith.xori"(%arg111, %arg112) : (i32, i32) -> i32
        "gpu.yield"(%159) : (i32) -> ()
      }) : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {sym_name = "gpu_all_reduce_region", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_4"}> ({
    "func.func"() <{function_type = () -> (f32, f32, f32, f32, i1, i1, i1, i1), sym_name = "gpu_shuffle"}> ({
      %150 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %151 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %152 = "arith.constant"() <{value = 23 : i32}> : () -> i32
      %153:2 = "gpu.shuffle"(%150, %151, %152) <{mode = #gpu<shuffle_mode xor>}> : (f32, i32, i32) -> (f32, i1)
      %154:2 = "gpu.shuffle"(%150, %151, %152) <{mode = #gpu<shuffle_mode up>}> : (f32, i32, i32) -> (f32, i1)
      %155:2 = "gpu.shuffle"(%150, %151, %152) <{mode = #gpu<shuffle_mode down>}> : (f32, i32, i32) -> (f32, i1)
      %156:2 = "gpu.shuffle"(%150, %151, %152) <{mode = #gpu<shuffle_mode idx>}> : (f32, i32, i32) -> (f32, i1)
      "func.return"(%153#0, %154#0, %155#0, %156#0, %153#1, %154#1, %155#1, %156#1) : (f32, f32, f32, f32, i1, i1, i1, i1) -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (f32, f32, f32, f32), sym_name = "gpu_shuffle_unused_pred"}> ({
      %143 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %144 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %145 = "arith.constant"() <{value = 23 : i32}> : () -> i32
      %146:2 = "gpu.shuffle"(%143, %144, %145) <{mode = #gpu<shuffle_mode xor>}> : (f32, i32, i32) -> (f32, i1)
      %147:2 = "gpu.shuffle"(%143, %144, %145) <{mode = #gpu<shuffle_mode up>}> : (f32, i32, i32) -> (f32, i1)
      %148:2 = "gpu.shuffle"(%143, %144, %145) <{mode = #gpu<shuffle_mode down>}> : (f32, i32, i32) -> (f32, i1)
      %149:2 = "gpu.shuffle"(%143, %144, %145) <{mode = #gpu<shuffle_mode idx>}> : (f32, i32, i32) -> (f32, i1)
      "func.return"(%146#0, %147#0, %148#0, %149#0) : (f32, f32, f32, f32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_5"}> ({
    "func.func"() <{function_type = () -> (), sym_name = "gpu_sync"}> ({
      "gpu.barrier"() : () -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_6"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_fabs"}> ({
    ^bb0(%arg109: f32, %arg110: f64):
      %141 = "math.absf"(%arg109) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %142 = "math.absf"(%arg110) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%141, %142) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_7"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_cbrt"}> ({
    ^bb0(%arg107: f32, %arg108: f64):
      %139 = "math.cbrt"(%arg107) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %140 = "math.cbrt"(%arg108) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%139, %140) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_8"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_ceil"}> ({
    ^bb0(%arg105: f32, %arg106: f64):
      %137 = "math.ceil"(%arg105) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %138 = "math.ceil"(%arg106) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%137, %138) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_9"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_floor"}> ({
    ^bb0(%arg103: f32, %arg104: f64):
      %135 = "math.floor"(%arg103) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %136 = "math.floor"(%arg104) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%135, %136) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_10"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_cos"}> ({
    ^bb0(%arg101: f32, %arg102: f64):
      %132 = "math.cos"(%arg101) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %133 = "math.cos"(%arg102) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      %134 = "math.cos"(%arg101) <{fastmath = #arith.fastmath<afn>}> : (f32) -> f32
      "func.return"(%132, %133, %134) : (f32, f64, f32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_11"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_exp"}> ({
    ^bb0(%arg99: f32, %arg100: f64):
      %129 = "math.exp"(%arg99) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %130 = "math.exp"(%arg100) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      %131 = "math.exp"(%arg99) <{fastmath = #arith.fastmath<fast>}> : (f32) -> f32
      "func.return"(%129, %130, %131) : (f32, f64, f32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_12"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_exp2"}> ({
    ^bb0(%arg97: f32, %arg98: f64):
      %127 = "math.exp2"(%arg97) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %128 = "math.exp2"(%arg98) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%127, %128) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_13"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_log"}> ({
    ^bb0(%arg95: f32, %arg96: f64):
      %124 = "math.log"(%arg95) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %125 = "math.log"(%arg96) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      %126 = "math.log"(%arg95) <{fastmath = #arith.fastmath<afn>}> : (f32) -> f32
      "func.return"(%124, %125, %126) : (f32, f64, f32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_14"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_log10"}> ({
    ^bb0(%arg93: f32, %arg94: f64):
      %121 = "math.log10"(%arg93) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %122 = "math.log10"(%arg94) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      %123 = "math.log10"(%arg93) <{fastmath = #arith.fastmath<afn>}> : (f32) -> f32
      "func.return"(%121, %122, %123) : (f32, f64, f32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_15"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_log1p"}> ({
    ^bb0(%arg91: f32, %arg92: f64):
      %119 = "math.log1p"(%arg91) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %120 = "math.log1p"(%arg92) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%119, %120) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_16"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_log2"}> ({
    ^bb0(%arg89: f32, %arg90: f64):
      %116 = "math.log2"(%arg89) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %117 = "math.log2"(%arg90) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      %118 = "math.log2"(%arg89) <{fastmath = #arith.fastmath<fast>}> : (f32) -> f32
      "func.return"(%116, %117, %118) : (f32, f64, f32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_17"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_sin"}> ({
    ^bb0(%arg87: f32, %arg88: f64):
      %113 = "math.sin"(%arg87) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %114 = "math.sin"(%arg88) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      %115 = "math.sin"(%arg87) <{fastmath = #arith.fastmath<fast>}> : (f32) -> f32
      "func.return"(%113, %114, %115) : (f32, f64, f32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_18"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64, f32), sym_name = "gpu_tan"}> ({
    ^bb0(%arg84: f16, %arg85: f32, %arg86: f64):
      %109 = "math.tan"(%arg84) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %110 = "math.tan"(%arg85) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %111 = "math.tan"(%arg86) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      %112 = "math.tan"(%arg85) <{fastmath = #arith.fastmath<fast>}> : (f32) -> f32
      "func.return"(%109, %110, %111, %112) : (f16, f32, f64, f32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_19"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_tanh"}> ({
    ^bb0(%arg81: f16, %arg82: f32, %arg83: f64):
      %106 = "math.tanh"(%arg81) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %107 = "math.tanh"(%arg82) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %108 = "math.tanh"(%arg83) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%106, %107, %108) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_20"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_rsqrt"}> ({
    ^bb0(%arg78: f16, %arg79: f32, %arg80: f64):
      %103 = "math.rsqrt"(%arg78) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %104 = "math.rsqrt"(%arg79) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %105 = "math.rsqrt"(%arg80) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%103, %104, %105) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_21"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_sqrt"}> ({
    ^bb0(%arg75: f16, %arg76: f32, %arg77: f64):
      %100 = "math.sqrt"(%arg75) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %101 = "math.sqrt"(%arg76) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %102 = "math.sqrt"(%arg77) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%100, %101, %102) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_22"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_atan"}> ({
    ^bb0(%arg72: f16, %arg73: f32, %arg74: f64):
      %97 = "math.atan"(%arg72) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %98 = "math.atan"(%arg73) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %99 = "math.atan"(%arg74) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%97, %98, %99) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_23"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_atan2"}> ({
    ^bb0(%arg69: f16, %arg70: f32, %arg71: f64):
      %94 = "math.atan2"(%arg69, %arg69) <{fastmath = #arith.fastmath<none>}> : (f16, f16) -> f16
      %95 = "math.atan2"(%arg70, %arg70) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %96 = "math.atan2"(%arg71, %arg71) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
      "func.return"(%94, %95, %96) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_24"}> ({
    "test.symbol_scope"() ({
      "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_exp"}> ({
      ^bb0(%arg67: f32, %arg68: f64):
        %91 = "math.exp"(%arg67) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        %92 = "math.exp"(%arg68) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
        %93 = "math.exp"(%arg67) <{fastmath = #arith.fastmath<afn>}> : (f32) -> f32
        "func.return"(%91, %92, %93) : (f32, f64, f32) -> ()
      }) : () -> ()
      "test.finish"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_25"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_expm1"}> ({
    ^bb0(%arg65: f32, %arg66: f64):
      %89 = "math.expm1"(%arg65) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %90 = "math.expm1"(%arg66) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%89, %90) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_26"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_pow"}> ({
    ^bb0(%arg63: f32, %arg64: f64):
      %86 = "math.powf"(%arg63, %arg63) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %87 = "math.powf"(%arg64, %arg64) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
      %88 = "math.powf"(%arg63, %arg63) <{fastmath = #arith.fastmath<fast>}> : (f32, f32) -> f32
      "func.return"(%86, %87, %88) : (f32, f64, f32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_27"}> ({
    "func.func"() <{function_type = (vector<4xf32>) -> vector<4xf32>, sym_name = "gpu_unroll"}> ({
    ^bb0(%arg62: vector<4xf32>):
      %85 = "math.exp"(%arg62) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
      "func.return"(%85) : (vector<4xf32>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_28"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "kernel_func", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_29"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      "gpu.printf"() <{format = "Hello, world\0A"}> : () -> ()
      "gpu.printf"() <{format = "Hello, world\0A"}> : () -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "test_const_printf", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (i32, f32) -> ()}> ({
    ^bb0(%arg60: i32, %arg61: f32):
      "gpu.printf"(%arg60, %arg61) <{format = "Hello: %d\0A"}> : (i32, f32) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "test_printf", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_30"}> ({
    "gpu.func"() <{function_type = (i32) -> ()}> ({
    ^bb0(%arg59: i32):
      %84 = "gpu.subgroup_reduce"(%arg59) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op add>, uniform}> : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {sym_name = "subgroup_reduce_add", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (i32) -> ()}> ({
    ^bb0(%arg58: i32):
      %83 = "gpu.subgroup_reduce"(%arg58) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op minsi>, uniform}> : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {sym_name = "subgroup_reduce_minsi", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (i32) -> ()}> ({
    ^bb0(%arg57: i32):
      %82 = "gpu.subgroup_reduce"(%arg57) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op maxsi>, uniform}> : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {sym_name = "subgroup_reduce_maxsi", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (i32) -> ()}> ({
    ^bb0(%arg56: i32):
      %81 = "gpu.subgroup_reduce"(%arg56) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op and>, uniform}> : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {sym_name = "subgroup_reduce_and", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (i32) -> ()}> ({
    ^bb0(%arg55: i32):
      %80 = "gpu.subgroup_reduce"(%arg55) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op or>, uniform}> : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {sym_name = "subgroup_reduce_or", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (i32) -> ()}> ({
    ^bb0(%arg54: i32):
      %79 = "gpu.subgroup_reduce"(%arg54) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op xor>, uniform}> : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {sym_name = "subgroup_reduce_xor", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_31"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_fmod"}> ({
    ^bb0(%arg52: f32, %arg53: f64):
      %77 = "arith.remf"(%arg52, %arg52) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %78 = "arith.remf"(%arg53, %arg53) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
      "func.return"(%77, %78) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_32"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_erf"}> ({
    ^bb0(%arg50: f32, %arg51: f64):
      %75 = "math.erf"(%arg50) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %76 = "math.erf"(%arg51) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%75, %76) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_33"}> ({
    "gpu.func"() <{function_type = (!llvm.ptr) -> (), known_block_size = array<i32: 32, 4, 2>}> ({
    ^bb0(%arg49: !llvm.ptr):
      %69 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %70 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %71 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %72 = "arith.addi"(%69, %70) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %73 = "arith.addi"(%72, %71) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %74 = "arith.index_cast"(%73) : (index) -> i64
      "llvm.store"(%74, %arg49) <{ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "kernel_with_block_size", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_34"}> ({
    "gpu.func"() <{function_type = (memref<2xf32>, f32) -> (memref<2xf32>, f32)}> ({
    ^bb0(%arg47: memref<2xf32>, %arg48: f32):
      "gpu.return"(%arg47, %arg48) : (memref<2xf32>, f32) -> ()
    }) {sym_name = "memref_signature", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_35"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_acos"}> ({
    ^bb0(%arg45: f32, %arg46: f64):
      %67 = "math.acos"(%arg45) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %68 = "math.acos"(%arg46) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%67, %68) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_36"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_acosh"}> ({
    ^bb0(%arg43: f32, %arg44: f64):
      %65 = "math.acosh"(%arg43) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %66 = "math.acosh"(%arg44) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%65, %66) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_37"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_asin"}> ({
    ^bb0(%arg41: f32, %arg42: f64):
      %63 = "math.asin"(%arg41) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %64 = "math.asin"(%arg42) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%63, %64) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_38"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_asinh"}> ({
    ^bb0(%arg39: f32, %arg40: f64):
      %61 = "math.asinh"(%arg39) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %62 = "math.asinh"(%arg40) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%61, %62) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_39"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_atanh"}> ({
    ^bb0(%arg36: f16, %arg37: f32, %arg38: f64):
      %58 = "math.atanh"(%arg36) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %59 = "math.atanh"(%arg37) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %60 = "math.atanh"(%arg38) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%58, %59, %60) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_40"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_copysign"}> ({
    ^bb0(%arg34: f32, %arg35: f64):
      %56 = "math.copysign"(%arg34, %arg34) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %57 = "math.copysign"(%arg35, %arg35) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
      "func.return"(%56, %57) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_41"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_cosh"}> ({
    ^bb0(%arg32: f32, %arg33: f64):
      %54 = "math.cosh"(%arg32) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %55 = "math.cosh"(%arg33) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%54, %55) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_42"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_fma"}> ({
    ^bb0(%arg30: f32, %arg31: f64):
      %52 = "math.fma"(%arg30, %arg30, %arg30) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
      %53 = "math.fma"(%arg31, %arg31, %arg31) <{fastmath = #arith.fastmath<none>}> : (f64, f64, f64) -> f64
      "func.return"(%52, %53) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_43"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_round"}> ({
    ^bb0(%arg28: f32, %arg29: f64):
      %50 = "math.round"(%arg28) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %51 = "math.round"(%arg29) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%50, %51) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_44"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_roundeven"}> ({
    ^bb0(%arg26: f32, %arg27: f64):
      %48 = "math.roundeven"(%arg26) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %49 = "math.roundeven"(%arg27) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%48, %49) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_45"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_sinh"}> ({
    ^bb0(%arg24: f32, %arg25: f64):
      %46 = "math.sinh"(%arg24) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %47 = "math.sinh"(%arg25) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%46, %47) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_46"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_cosh_with_fastmath"}> ({
    ^bb0(%arg22: f32, %arg23: f64):
      %44 = "math.cosh"(%arg22) <{fastmath = #arith.fastmath<fast>}> : (f32) -> f32
      %45 = "math.cosh"(%arg23) <{fastmath = #arith.fastmath<afn>}> : (f64) -> f64
      "func.return"(%44, %45) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_47"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_sinh_with_fastmath"}> ({
    ^bb0(%arg20: f32, %arg21: f64):
      %42 = "math.sinh"(%arg20) <{fastmath = #arith.fastmath<contract>}> : (f32) -> f32
      %43 = "math.sinh"(%arg21) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%42, %43) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_48"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_exp_with_fastmath"}> ({
    ^bb0(%arg18: f32, %arg19: f64):
      %39 = "math.exp"(%arg18) <{fastmath = #arith.fastmath<reassoc>}> : (f32) -> f32
      %40 = "math.exp"(%arg19) <{fastmath = #arith.fastmath<contract>}> : (f64) -> f64
      %41 = "math.exp"(%arg18) <{fastmath = #arith.fastmath<ninf>}> : (f32) -> f32
      "func.return"(%39, %40, %41) : (f32, f64, f32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_49"}> ({
    "func.func"() <{function_type = () -> (index, index, index), sym_name = "explicit_id_bounds"}> ({
      %36 = "gpu.thread_id"() <{dimension = #gpu<dim x>, upper_bound = 32 : index}> : () -> index
      %37 = "gpu.block_dim"() <{dimension = #gpu<dim x>, upper_bound = 32 : index}> : () -> index
      %38 = "gpu.lane_id"() <{upper_bound = 16 : index}> : () -> index
      "func.return"(%36, %37, %38) : (index, index, index) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_50"}> ({
    "gpu.func"() <{function_type = (!llvm.ptr) -> (), known_grid_size = array<i32: 32, 4, 2>}> ({
    ^bb0(%arg17: !llvm.ptr):
      %30 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %31 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %32 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %33 = "arith.addi"(%30, %31) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %34 = "arith.addi"(%33, %32) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %35 = "arith.index_cast"(%34) : (index) -> i64
      "llvm.store"(%35, %arg17) <{ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "kernel_with_grid_size", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_51"}> ({
    "gpu.func"() <{function_type = (i1) -> ()}> ({
    ^bb0(%arg16: i1):
      "cf.assert"(%arg16) <{msg = "assert message"}> : (i1) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "test_assert", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg15: !transform.any_op):
      %29 = "transform.structured.match"(%arg15) <{ops = ["gpu.module"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%29) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.gpu.gpu_rewrite_patterns"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.apply_conversion_patterns"(%29) <{illegal_dialects = ["gpu"], illegal_ops = ["llvm.copysign", "llvm.cos", "llvm.exp", "llvm.exp2", "llvm.fabs", "llvm.fceil", "llvm.ffloor", "llvm.frem", "llvm.log", "llvm.log10", "llvm.log2", "llvm.pow", "llvm.roundeven", "llvm.round", "llvm.sin", "llvm.sqrt"], legal_dialects = ["llvm", "memref", "nvvm", "test"], legal_ops = ["func.func", "gpu.module", "gpu.yield"], partial_conversion}> ({
        "transform.apply_conversion_patterns.dialect_to_llvm"() <{dialect_name = "arith"}> : () -> ()
        "transform.apply_conversion_patterns.dialect_to_llvm"() <{dialect_name = "cf"}> : () -> ()
        "transform.apply_conversion_patterns.vector.vector_to_llvm"() <{force_32bit_vector_indices = true, reassociate_fp_reductions = false, use_vector_alignment = false}> : () -> ()
        "transform.apply_conversion_patterns.func.func_to_llvm"() : () -> ()
        "transform.apply_conversion_patterns.dialect_to_llvm"() <{dialect_name = "memref"}> : () -> ()
        "transform.apply_conversion_patterns.gpu.gpu_to_nvvm"() <{benefit = 10 : i16}> : () -> ()
        "transform.apply_conversion_patterns.gpu.gpu_wmma_to_nvvm"() : () -> ()
        "transform.apply_conversion_patterns.gpu.gpu_subgroup_reduce_to_nvvm"() : () -> ()
        "transform.apply_conversion_patterns.nvgpu.nvgpu_to_nvvm"() : () -> ()
      }, {
        "transform.apply_conversion_patterns.memref.memref_to_llvm_type_converter"() <{index_bitwidth = 64 : i64, use_bare_ptr_call_conv = false}> : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
  "gpu.module"() <{sym_name = "test_module_52"}> ({
    "func.func"() <{function_type = (i32) -> i32, sym_name = "gpu_abs"}> ({
    ^bb0(%arg14: i32):
      %28 = "math.absi"(%arg14) : (i32) -> i32
      "func.return"(%28) : (i32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_53"}> ({
    "func.func"() <{function_type = (f32, f64, i32) -> (f32, f64), sym_name = "gpu_powi"}> ({
    ^bb0(%arg11: f32, %arg12: f64, %arg13: i32):
      %26 = "math.fpowi"(%arg11, %arg13) <{fastmath = #arith.fastmath<none>}> : (f32, i32) -> f32
      %27 = "math.fpowi"(%arg12, %arg13) <{fastmath = #arith.fastmath<none>}> : (f64, i32) -> f64
      "func.return"(%26, %27) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_54"}> ({
    "func.func"() <{function_type = (f32, f64) -> (i1, i1, i1, i1, i1, i1), sym_name = "fpclassify"}> ({
    ^bb0(%arg9: f32, %arg10: f64):
      %20 = "math.isinf"(%arg9) <{fastmath = #arith.fastmath<none>}> : (f32) -> i1
      %21 = "math.isinf"(%arg10) <{fastmath = #arith.fastmath<none>}> : (f64) -> i1
      %22 = "math.isnan"(%arg9) <{fastmath = #arith.fastmath<none>}> : (f32) -> i1
      %23 = "math.isnan"(%arg10) <{fastmath = #arith.fastmath<none>}> : (f64) -> i1
      %24 = "math.isfinite"(%arg9) <{fastmath = #arith.fastmath<none>}> : (f32) -> i1
      %25 = "math.isfinite"(%arg10) <{fastmath = #arith.fastmath<none>}> : (f64) -> i1
      "func.return"(%20, %21, %22, %23, %24, %25) : (i1, i1, i1, i1, i1, i1) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_55"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_erfc"}> ({
    ^bb0(%arg7: f32, %arg8: f64):
      %18 = "math.erfc"(%arg7) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %19 = "math.erfc"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%18, %19) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_56"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f16, f32, f32, f64, f64), sym_name = "gpu_sincos"}> ({
    ^bb0(%arg4: f16, %arg5: f32, %arg6: f64):
      %15:2 = "math.sincos"(%arg4) <{fastmath = #arith.fastmath<none>}> : (f16) -> (f16, f16)
      %16:2 = "math.sincos"(%arg5) <{fastmath = #arith.fastmath<none>}> : (f32) -> (f32, f32)
      %17:2 = "math.sincos"(%arg6) <{fastmath = #arith.fastmath<none>}> : (f64) -> (f64, f64)
      "func.return"(%15#0, %15#1, %16#0, %16#1, %17#0, %17#1) : (f16, f16, f32, f32, f64, f64) -> ()
    }) : () -> ()
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f16, f32, f32, f64, f64), sym_name = "gpu_sincos_fastmath"}> ({
    ^bb0(%arg1: f16, %arg2: f32, %arg3: f64):
      %12:2 = "math.sincos"(%arg1) <{fastmath = #arith.fastmath<afn>}> : (f16) -> (f16, f16)
      %13:2 = "math.sincos"(%arg2) <{fastmath = #arith.fastmath<afn>}> : (f32) -> (f32, f32)
      %14:2 = "math.sincos"(%arg3) <{fastmath = #arith.fastmath<afn>}> : (f64) -> (f64, f64)
      "func.return"(%12#0, %12#1, %13#0, %13#1, %14#0, %14#1) : (f16, f16, f32, f32, f64, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_cluster_size"}> ({
    "gpu.func"() <{function_type = () -> (), known_cluster_size = array<i32: 8, 2, 4>}> ({
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "kernel_with_cluster_size", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_cluster_block_ops"}> ({
    "gpu.func"() <{function_type = (!llvm.ptr) -> (), known_cluster_size = array<i32: 8, 4, 2>}> ({
    ^bb0(%arg0: !llvm.ptr):
      %0 = "gpu.cluster_block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "gpu.cluster_block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %2 = "gpu.cluster_block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %3 = "gpu.cluster_dim_blocks"() <{dimension = #gpu<dim x>}> : () -> index
      %4 = "gpu.cluster_dim_blocks"() <{dimension = #gpu<dim y>}> : () -> index
      %5 = "gpu.cluster_dim_blocks"() <{dimension = #gpu<dim z>}> : () -> index
      %6 = "arith.addi"(%0, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %7 = "arith.addi"(%6, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %8 = "arith.addi"(%7, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %9 = "arith.addi"(%8, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %10 = "arith.addi"(%9, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %11 = "arith.index_cast"(%10) : (index) -> i64
      "llvm.store"(%11, %arg0) <{ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "kernel_with_cluster_size", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

