"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module_0"}> ({
    "func.func"() <{function_type = () -> (index, index, index, index, index, index, index, index, index, index, index, index, index), sym_name = "gpu_index_ops"}> ({
      %168 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %169 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %170 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %171 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %172 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %173 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %174 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %175 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %176 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %177 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %178 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %179 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %180 = "gpu.lane_id"() : () -> index
      "func.return"(%168, %169, %170, %171, %172, %173, %174, %175, %176, %177, %178, %179, %180) : (index, index, index, index, index, index, index, index, index, index, index, index, index) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_1"}> ({
    "func.func"() <{function_type = (index) -> index, sym_name = "gpu_index_comp"}> ({
    ^bb0(%arg122: index):
      %167 = "arith.addi"(%arg122, %arg122) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "func.return"(%167) : (index) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_2"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %165 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %166 = "gpu.all_reduce"(%165) <{op = #gpu<all_reduce_op add>, uniform}> ({
      }) : (f32) -> f32
      "gpu.return"() : () -> ()
    }) {sym_name = "gpu_all_reduce_op"} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_3"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %162 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %163 = "gpu.all_reduce"(%162) <{uniform}> ({
      ^bb0(%arg120: i32, %arg121: i32):
        %164 = "arith.xori"(%arg120, %arg121) : (i32, i32) -> i32
        "gpu.yield"(%164) : (i32) -> ()
      }) : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {sym_name = "gpu_all_reduce_region"} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_4"}> ({
    "func.func"() <{function_type = () -> (f32, f32, f32, f32, i1, i1, i1, i1), sym_name = "gpu_shuffle"}> ({
      %155 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %156 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %157 = "arith.constant"() <{value = 23 : i32}> : () -> i32
      %158:2 = "gpu.shuffle"(%155, %156, %157) <{mode = #gpu<shuffle_mode xor>}> : (f32, i32, i32) -> (f32, i1)
      %159:2 = "gpu.shuffle"(%155, %156, %157) <{mode = #gpu<shuffle_mode up>}> : (f32, i32, i32) -> (f32, i1)
      %160:2 = "gpu.shuffle"(%155, %156, %157) <{mode = #gpu<shuffle_mode down>}> : (f32, i32, i32) -> (f32, i1)
      %161:2 = "gpu.shuffle"(%155, %156, %157) <{mode = #gpu<shuffle_mode idx>}> : (f32, i32, i32) -> (f32, i1)
      "func.return"(%158#0, %159#0, %160#0, %161#0, %158#1, %159#1, %160#1, %161#1) : (f32, f32, f32, f32, i1, i1, i1, i1) -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (f32, f32, f32, f32), sym_name = "gpu_shuffle_unused_pred"}> ({
      %148 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %149 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %150 = "arith.constant"() <{value = 23 : i32}> : () -> i32
      %151:2 = "gpu.shuffle"(%148, %149, %150) <{mode = #gpu<shuffle_mode xor>}> : (f32, i32, i32) -> (f32, i1)
      %152:2 = "gpu.shuffle"(%148, %149, %150) <{mode = #gpu<shuffle_mode up>}> : (f32, i32, i32) -> (f32, i1)
      %153:2 = "gpu.shuffle"(%148, %149, %150) <{mode = #gpu<shuffle_mode down>}> : (f32, i32, i32) -> (f32, i1)
      %154:2 = "gpu.shuffle"(%148, %149, %150) <{mode = #gpu<shuffle_mode idx>}> : (f32, i32, i32) -> (f32, i1)
      "func.return"(%151#0, %152#0, %153#0, %154#0) : (f32, f32, f32, f32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_5"}> ({
    "func.func"() <{function_type = () -> (), sym_name = "gpu_sync"}> ({
      "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "gpu_sync_subgroup"}> ({
      "gpu.barrier"() <{scope = #gpu.barrier_scope<subgroup>}> : () -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (i32) -> (), sym_name = "gpu_named_barriers"}> ({
    ^bb0(%arg119: i32):
      %145 = "gpu.initialize_named_barrier"(%arg119) : (i32) -> !gpu.named_barrier
      %146 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %147 = "gpu.initialize_named_barrier"(%146) : (i32) -> !gpu.named_barrier
      "gpu.barrier"(%145) <{scope = #gpu.barrier_scope<workgroup>}> : (!gpu.named_barrier) -> ()
      "gpu.barrier"(%147) <{scope = #gpu.barrier_scope<workgroup>}> : (!gpu.named_barrier) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (!gpu.named_barrier) -> (), sym_name = "gpu_named_barrier_arg"}> ({
    ^bb0(%arg118: !gpu.named_barrier):
      "gpu.barrier"(%arg118) <{scope = #gpu.barrier_scope<workgroup>}> : (!gpu.named_barrier) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_6"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_fabs"}> ({
    ^bb0(%arg116: f32, %arg117: f64):
      %143 = "math.absf"(%arg116) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %144 = "math.absf"(%arg117) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%143, %144) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_7"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_cbrt"}> ({
    ^bb0(%arg114: f32, %arg115: f64):
      %141 = "math.cbrt"(%arg114) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %142 = "math.cbrt"(%arg115) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%141, %142) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_8"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_ceil"}> ({
    ^bb0(%arg112: f32, %arg113: f64):
      %139 = "math.ceil"(%arg112) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %140 = "math.ceil"(%arg113) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%139, %140) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_9"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_floor"}> ({
    ^bb0(%arg110: f32, %arg111: f64):
      %137 = "math.floor"(%arg110) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %138 = "math.floor"(%arg111) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%137, %138) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_10"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_cos"}> ({
    ^bb0(%arg108: f32, %arg109: f64):
      %134 = "math.cos"(%arg108) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %135 = "math.cos"(%arg109) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      %136 = "math.cos"(%arg108) <{fastmath = #arith.fastmath<afn>}> : (f32) -> f32
      "func.return"(%134, %135, %136) : (f32, f64, f32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_11"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_exp"}> ({
    ^bb0(%arg106: f32, %arg107: f64):
      %131 = "math.exp"(%arg106) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %132 = "math.exp"(%arg107) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      %133 = "math.exp"(%arg106) <{fastmath = #arith.fastmath<fast>}> : (f32) -> f32
      "func.return"(%131, %132, %133) : (f32, f64, f32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_12"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_exp2"}> ({
    ^bb0(%arg104: f32, %arg105: f64):
      %129 = "math.exp2"(%arg104) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %130 = "math.exp2"(%arg105) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%129, %130) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_13"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_log"}> ({
    ^bb0(%arg102: f32, %arg103: f64):
      %126 = "math.log"(%arg102) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %127 = "math.log"(%arg103) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      %128 = "math.log"(%arg102) <{fastmath = #arith.fastmath<afn>}> : (f32) -> f32
      "func.return"(%126, %127, %128) : (f32, f64, f32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_14"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_log10"}> ({
    ^bb0(%arg100: f32, %arg101: f64):
      %123 = "math.log10"(%arg100) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %124 = "math.log10"(%arg101) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      %125 = "math.log10"(%arg100) <{fastmath = #arith.fastmath<afn>}> : (f32) -> f32
      "func.return"(%123, %124, %125) : (f32, f64, f32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_15"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_log1p"}> ({
    ^bb0(%arg98: f32, %arg99: f64):
      %121 = "math.log1p"(%arg98) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %122 = "math.log1p"(%arg99) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%121, %122) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_16"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_log2"}> ({
    ^bb0(%arg96: f32, %arg97: f64):
      %118 = "math.log2"(%arg96) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %119 = "math.log2"(%arg97) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      %120 = "math.log2"(%arg96) <{fastmath = #arith.fastmath<fast>}> : (f32) -> f32
      "func.return"(%118, %119, %120) : (f32, f64, f32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_17"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_sin"}> ({
    ^bb0(%arg94: f32, %arg95: f64):
      %115 = "math.sin"(%arg94) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %116 = "math.sin"(%arg95) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      %117 = "math.sin"(%arg94) <{fastmath = #arith.fastmath<fast>}> : (f32) -> f32
      "func.return"(%115, %116, %117) : (f32, f64, f32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_18"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64, f32), sym_name = "gpu_tan"}> ({
    ^bb0(%arg91: f16, %arg92: f32, %arg93: f64):
      %111 = "math.tan"(%arg91) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %112 = "math.tan"(%arg92) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %113 = "math.tan"(%arg93) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      %114 = "math.tan"(%arg92) <{fastmath = #arith.fastmath<fast>}> : (f32) -> f32
      "func.return"(%111, %112, %113, %114) : (f16, f32, f64, f32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_19"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_tanh"}> ({
    ^bb0(%arg88: f16, %arg89: f32, %arg90: f64):
      %108 = "math.tanh"(%arg88) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %109 = "math.tanh"(%arg89) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %110 = "math.tanh"(%arg90) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%108, %109, %110) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_20"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_rsqrt"}> ({
    ^bb0(%arg85: f16, %arg86: f32, %arg87: f64):
      %105 = "math.rsqrt"(%arg85) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %106 = "math.rsqrt"(%arg86) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %107 = "math.rsqrt"(%arg87) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%105, %106, %107) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_21"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_sqrt"}> ({
    ^bb0(%arg82: f16, %arg83: f32, %arg84: f64):
      %102 = "math.sqrt"(%arg82) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %103 = "math.sqrt"(%arg83) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %104 = "math.sqrt"(%arg84) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%102, %103, %104) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_22"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_atan"}> ({
    ^bb0(%arg79: f16, %arg80: f32, %arg81: f64):
      %99 = "math.atan"(%arg79) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %100 = "math.atan"(%arg80) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %101 = "math.atan"(%arg81) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%99, %100, %101) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_23"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_atan2"}> ({
    ^bb0(%arg76: f16, %arg77: f32, %arg78: f64):
      %96 = "math.atan2"(%arg76, %arg76) <{fastmath = #arith.fastmath<none>}> : (f16, f16) -> f16
      %97 = "math.atan2"(%arg77, %arg77) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %98 = "math.atan2"(%arg78, %arg78) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
      "func.return"(%96, %97, %98) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_24"}> ({
    "test.symbol_scope"() ({
      "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_exp"}> ({
      ^bb0(%arg74: f32, %arg75: f64):
        %93 = "math.exp"(%arg74) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        %94 = "math.exp"(%arg75) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
        %95 = "math.exp"(%arg74) <{fastmath = #arith.fastmath<afn>}> : (f32) -> f32
        "func.return"(%93, %94, %95) : (f32, f64, f32) -> ()
      }) : () -> ()
      "test.finish"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_25"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_expm1"}> ({
    ^bb0(%arg72: f32, %arg73: f64):
      %91 = "math.expm1"(%arg72) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %92 = "math.expm1"(%arg73) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%91, %92) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_26"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_pow"}> ({
    ^bb0(%arg70: f32, %arg71: f64):
      %88 = "math.powf"(%arg70, %arg70) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %89 = "math.powf"(%arg71, %arg71) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
      %90 = "math.powf"(%arg70, %arg70) <{fastmath = #arith.fastmath<fast>}> : (f32, f32) -> f32
      "func.return"(%88, %89, %90) : (f32, f64, f32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_27"}> ({
    "func.func"() <{function_type = (vector<4xf32>) -> vector<4xf32>, sym_name = "gpu_unroll"}> ({
    ^bb0(%arg69: vector<4xf32>):
      %87 = "math.exp"(%arg69) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
      "func.return"(%87) : (vector<4xf32>) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_28"}> ({
    "gpu.func"() <{function_type = () -> (), kernel}> ({
      "gpu.return"() : () -> ()
    }) {sym_name = "kernel_func"} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_29"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      "gpu.printf"() <{format = "Hello, world\0A"}> : () -> ()
      "gpu.printf"() <{format = "Hello, world\0A"}> : () -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "test_const_printf"} : () -> ()
    "gpu.func"() <{function_type = (i32, f32) -> ()}> ({
    ^bb0(%arg67: i32, %arg68: f32):
      "gpu.printf"(%arg67, %arg68) <{format = "Hello: %d\0A"}> : (i32, f32) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "test_printf"} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_30"}> ({
    "gpu.func"() <{function_type = (i32, memref<i32>) -> ()}> ({
    ^bb0(%arg65: i32, %arg66: memref<i32>):
      %86 = "gpu.subgroup_reduce"(%arg65) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op add>, uniform}> : (i32) -> i32
      "memref.store"(%86, %arg66) : (i32, memref<i32>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "subgroup_reduce_add"} : () -> ()
    "gpu.func"() <{function_type = (i32, memref<i32>) -> ()}> ({
    ^bb0(%arg63: i32, %arg64: memref<i32>):
      %85 = "gpu.subgroup_reduce"(%arg63) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op minsi>, uniform}> : (i32) -> i32
      "memref.store"(%85, %arg64) : (i32, memref<i32>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "subgroup_reduce_minsi"} : () -> ()
    "gpu.func"() <{function_type = (i32, memref<i32>) -> ()}> ({
    ^bb0(%arg61: i32, %arg62: memref<i32>):
      %84 = "gpu.subgroup_reduce"(%arg61) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op maxsi>, uniform}> : (i32) -> i32
      "memref.store"(%84, %arg62) : (i32, memref<i32>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "subgroup_reduce_maxsi"} : () -> ()
    "gpu.func"() <{function_type = (i32, memref<i32>) -> ()}> ({
    ^bb0(%arg59: i32, %arg60: memref<i32>):
      %83 = "gpu.subgroup_reduce"(%arg59) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op and>, uniform}> : (i32) -> i32
      "memref.store"(%83, %arg60) : (i32, memref<i32>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "subgroup_reduce_and"} : () -> ()
    "gpu.func"() <{function_type = (i32, memref<i32>) -> ()}> ({
    ^bb0(%arg57: i32, %arg58: memref<i32>):
      %82 = "gpu.subgroup_reduce"(%arg57) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op or>, uniform}> : (i32) -> i32
      "memref.store"(%82, %arg58) : (i32, memref<i32>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "subgroup_reduce_or"} : () -> ()
    "gpu.func"() <{function_type = (i32, memref<i32>) -> ()}> ({
    ^bb0(%arg55: i32, %arg56: memref<i32>):
      %81 = "gpu.subgroup_reduce"(%arg55) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op xor>, uniform}> : (i32) -> i32
      "memref.store"(%81, %arg56) : (i32, memref<i32>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "subgroup_reduce_xor"} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_31"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_fmod"}> ({
    ^bb0(%arg53: f32, %arg54: f64):
      %79 = "arith.remf"(%arg53, %arg53) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %80 = "arith.remf"(%arg54, %arg54) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
      "func.return"(%79, %80) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_32"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_erf"}> ({
    ^bb0(%arg51: f32, %arg52: f64):
      %77 = "math.erf"(%arg51) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %78 = "math.erf"(%arg52) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%77, %78) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_33"}> ({
    "gpu.func"() <{function_type = (!llvm.ptr) -> (), kernel, known_block_size = array<i32: 32, 4, 2>}> ({
    ^bb0(%arg50: !llvm.ptr):
      %71 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %72 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %73 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %74 = "arith.addi"(%71, %72) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %75 = "arith.addi"(%74, %73) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %76 = "arith.index_cast"(%75) : (index) -> i64
      "llvm.store"(%76, %arg50) <{ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "kernel_with_block_size"} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_34"}> ({
    "gpu.func"() <{function_type = (memref<2xf32>, f32) -> (memref<2xf32>, f32)}> ({
    ^bb0(%arg48: memref<2xf32>, %arg49: f32):
      "gpu.return"(%arg48, %arg49) : (memref<2xf32>, f32) -> ()
    }) {sym_name = "memref_signature"} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_35"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_acos"}> ({
    ^bb0(%arg46: f32, %arg47: f64):
      %69 = "math.acos"(%arg46) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %70 = "math.acos"(%arg47) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%69, %70) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_36"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_acosh"}> ({
    ^bb0(%arg44: f32, %arg45: f64):
      %67 = "math.acosh"(%arg44) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %68 = "math.acosh"(%arg45) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%67, %68) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_37"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_asin"}> ({
    ^bb0(%arg42: f32, %arg43: f64):
      %65 = "math.asin"(%arg42) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %66 = "math.asin"(%arg43) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%65, %66) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_38"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_asinh"}> ({
    ^bb0(%arg40: f32, %arg41: f64):
      %63 = "math.asinh"(%arg40) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %64 = "math.asinh"(%arg41) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%63, %64) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_39"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_atanh"}> ({
    ^bb0(%arg37: f16, %arg38: f32, %arg39: f64):
      %60 = "math.atanh"(%arg37) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %61 = "math.atanh"(%arg38) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %62 = "math.atanh"(%arg39) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%60, %61, %62) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_40"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_copysign"}> ({
    ^bb0(%arg35: f32, %arg36: f64):
      %58 = "math.copysign"(%arg35, %arg35) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %59 = "math.copysign"(%arg36, %arg36) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
      "func.return"(%58, %59) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_41"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_cosh"}> ({
    ^bb0(%arg33: f32, %arg34: f64):
      %56 = "math.cosh"(%arg33) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %57 = "math.cosh"(%arg34) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%56, %57) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_42"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_fma"}> ({
    ^bb0(%arg31: f32, %arg32: f64):
      %54 = "math.fma"(%arg31, %arg31, %arg31) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
      %55 = "math.fma"(%arg32, %arg32, %arg32) <{fastmath = #arith.fastmath<none>}> : (f64, f64, f64) -> f64
      "func.return"(%54, %55) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_43"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_round"}> ({
    ^bb0(%arg29: f32, %arg30: f64):
      %52 = "math.round"(%arg29) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %53 = "math.round"(%arg30) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%52, %53) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_44"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_roundeven"}> ({
    ^bb0(%arg27: f32, %arg28: f64):
      %50 = "math.roundeven"(%arg27) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %51 = "math.roundeven"(%arg28) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%50, %51) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_45"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_sinh"}> ({
    ^bb0(%arg25: f32, %arg26: f64):
      %48 = "math.sinh"(%arg25) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %49 = "math.sinh"(%arg26) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%48, %49) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_46"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_cosh_with_fastmath"}> ({
    ^bb0(%arg23: f32, %arg24: f64):
      %46 = "math.cosh"(%arg23) <{fastmath = #arith.fastmath<fast>}> : (f32) -> f32
      %47 = "math.cosh"(%arg24) <{fastmath = #arith.fastmath<afn>}> : (f64) -> f64
      "func.return"(%46, %47) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_47"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_sinh_with_fastmath"}> ({
    ^bb0(%arg21: f32, %arg22: f64):
      %44 = "math.sinh"(%arg21) <{fastmath = #arith.fastmath<contract>}> : (f32) -> f32
      %45 = "math.sinh"(%arg22) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%44, %45) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_48"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_exp_with_fastmath"}> ({
    ^bb0(%arg19: f32, %arg20: f64):
      %41 = "math.exp"(%arg19) <{fastmath = #arith.fastmath<reassoc>}> : (f32) -> f32
      %42 = "math.exp"(%arg20) <{fastmath = #arith.fastmath<contract>}> : (f64) -> f64
      %43 = "math.exp"(%arg19) <{fastmath = #arith.fastmath<ninf>}> : (f32) -> f32
      "func.return"(%41, %42, %43) : (f32, f64, f32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_49"}> ({
    "func.func"() <{function_type = () -> (index, index, index), sym_name = "explicit_id_bounds"}> ({
      %38 = "gpu.thread_id"() <{dimension = #gpu<dim x>, upper_bound = 32 : index}> : () -> index
      %39 = "gpu.block_dim"() <{dimension = #gpu<dim x>, upper_bound = 32 : index}> : () -> index
      %40 = "gpu.lane_id"() <{upper_bound = 16 : index}> : () -> index
      "func.return"(%38, %39, %40) : (index, index, index) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_50"}> ({
    "gpu.func"() <{function_type = (!llvm.ptr) -> (), kernel, known_grid_size = array<i32: 32, 4, 2>}> ({
    ^bb0(%arg18: !llvm.ptr):
      %32 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %33 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %34 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %35 = "arith.addi"(%32, %33) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %36 = "arith.addi"(%35, %34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %37 = "arith.index_cast"(%36) : (index) -> i64
      "llvm.store"(%37, %arg18) <{ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "kernel_with_grid_size"} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_51"}> ({
    "gpu.func"() <{function_type = (i1) -> (), kernel}> ({
    ^bb0(%arg17: i1):
      "cf.assert"(%arg17) <{msg = "assert message"}> : (i1) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "test_assert"} : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg16: !transform.any_op):
      %31 = "transform.structured.match"(%arg16) <{ops = ["gpu.module"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%31) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.gpu.gpu_rewrite_patterns"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.apply_conversion_patterns"(%31) <{illegal_dialects = ["gpu"], illegal_ops = ["llvm.copysign", "llvm.cos", "llvm.exp", "llvm.exp2", "llvm.fabs", "llvm.fceil", "llvm.ffloor", "llvm.frem", "llvm.log", "llvm.log10", "llvm.log2", "llvm.pow", "llvm.roundeven", "llvm.round", "llvm.sin", "llvm.sqrt"], legal_dialects = ["llvm", "memref", "nvvm", "test"], legal_ops = ["gpu.module", "gpu.yield"], partial_conversion}> ({
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
    ^bb0(%arg15: i32):
      %30 = "math.absi"(%arg15) : (i32) -> i32
      "func.return"(%30) : (i32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_53"}> ({
    "func.func"() <{function_type = (f32, f64, i32) -> (f32, f64), sym_name = "gpu_powi"}> ({
    ^bb0(%arg12: f32, %arg13: f64, %arg14: i32):
      %28 = "math.fpowi"(%arg12, %arg14) <{fastmath = #arith.fastmath<none>}> : (f32, i32) -> f32
      %29 = "math.fpowi"(%arg13, %arg14) <{fastmath = #arith.fastmath<none>}> : (f64, i32) -> f64
      "func.return"(%28, %29) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_54"}> ({
    "func.func"() <{function_type = (f32, f64) -> (i1, i1, i1, i1, i1, i1), sym_name = "fpclassify"}> ({
    ^bb0(%arg10: f32, %arg11: f64):
      %22 = "math.isinf"(%arg10) <{fastmath = #arith.fastmath<none>}> : (f32) -> i1
      %23 = "math.isinf"(%arg11) <{fastmath = #arith.fastmath<none>}> : (f64) -> i1
      %24 = "math.isnan"(%arg10) <{fastmath = #arith.fastmath<none>}> : (f32) -> i1
      %25 = "math.isnan"(%arg11) <{fastmath = #arith.fastmath<none>}> : (f64) -> i1
      %26 = "math.isfinite"(%arg10) <{fastmath = #arith.fastmath<none>}> : (f32) -> i1
      %27 = "math.isfinite"(%arg11) <{fastmath = #arith.fastmath<none>}> : (f64) -> i1
      "func.return"(%22, %23, %24, %25, %26, %27) : (i1, i1, i1, i1, i1, i1) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_55"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_erfc"}> ({
    ^bb0(%arg8: f32, %arg9: f64):
      %20 = "math.erfc"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %21 = "math.erfc"(%arg9) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%20, %21) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_56"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f16, f32, f32, f64, f64), sym_name = "gpu_sincos"}> ({
    ^bb0(%arg5: f16, %arg6: f32, %arg7: f64):
      %17:2 = "math.sincos"(%arg5) <{fastmath = #arith.fastmath<none>}> : (f16) -> (f16, f16)
      %18:2 = "math.sincos"(%arg6) <{fastmath = #arith.fastmath<none>}> : (f32) -> (f32, f32)
      %19:2 = "math.sincos"(%arg7) <{fastmath = #arith.fastmath<none>}> : (f64) -> (f64, f64)
      "func.return"(%17#0, %17#1, %18#0, %18#1, %19#0, %19#1) : (f16, f16, f32, f32, f64, f64) -> ()
    }) : () -> ()
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f16, f32, f32, f64, f64), sym_name = "gpu_sincos_fastmath"}> ({
    ^bb0(%arg2: f16, %arg3: f32, %arg4: f64):
      %14:2 = "math.sincos"(%arg2) <{fastmath = #arith.fastmath<afn>}> : (f16) -> (f16, f16)
      %15:2 = "math.sincos"(%arg3) <{fastmath = #arith.fastmath<afn>}> : (f32) -> (f32, f32)
      %16:2 = "math.sincos"(%arg4) <{fastmath = #arith.fastmath<afn>}> : (f64) -> (f64, f64)
      "func.return"(%14#0, %14#1, %15#0, %15#1, %16#0, %16#1) : (f16, f16, f32, f32, f64, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_cluster_size"}> ({
    "gpu.func"() <{function_type = () -> (), kernel, known_cluster_size = array<i32: 8, 2, 4>}> ({
      "gpu.return"() : () -> ()
    }) {sym_name = "kernel_with_cluster_size"} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_cluster_block_ops"}> ({
    "gpu.func"() <{function_type = (!llvm.ptr) -> (), kernel, known_cluster_size = array<i32: 8, 4, 2>}> ({
    ^bb0(%arg1: !llvm.ptr):
      %2 = "gpu.cluster_block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %3 = "gpu.cluster_block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %4 = "gpu.cluster_block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %5 = "gpu.cluster_dim_blocks"() <{dimension = #gpu<dim x>}> : () -> index
      %6 = "gpu.cluster_dim_blocks"() <{dimension = #gpu<dim y>}> : () -> index
      %7 = "gpu.cluster_dim_blocks"() <{dimension = #gpu<dim z>}> : () -> index
      %8 = "arith.addi"(%2, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %9 = "arith.addi"(%8, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %10 = "arith.addi"(%9, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %11 = "arith.addi"(%10, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %12 = "arith.addi"(%11, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %13 = "arith.index_cast"(%12) : (index) -> i64
      "llvm.store"(%13, %arg1) <{ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "kernel_with_cluster_size"} : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "gpu.module"() <{sym_name = "kernels"}> ({
      "gpu.func"() <{function_type = (i1) -> (i32, i64)}> ({
      ^bb0(%arg0: i1):
        %0 = "gpu.ballot"(%arg0) : (i1) -> i32
        %1 = "gpu.ballot"(%arg0) : (i1) -> i64
        "gpu.return"(%0, %1) : (i32, i64) -> ()
      }) {sym_name = "gpu_ballot"} : () -> ()
    }) : () -> ()
  }) {gpu.container_module} : () -> ()
}) : () -> ()

