"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module_0"}> ({
    "func.func"() <{function_type = () -> (index, index, index, index, index, index, index, index, index, index, index, index, index), sym_name = "gpu_index_ops"}> ({
      %151 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %152 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %153 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %154 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %155 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %156 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %157 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %158 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %159 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %160 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %161 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %162 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %163 = "gpu.lane_id"() : () -> index
      "func.return"(%151, %152, %153, %154, %155, %156, %157, %158, %159, %160, %161, %162, %163) : (index, index, index, index, index, index, index, index, index, index, index, index, index) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_1"}> ({
    "func.func"() <{function_type = (index) -> index, sym_name = "gpu_index_comp"}> ({
    ^bb0(%arg112: index):
      %150 = "arith.addi"(%arg112, %arg112) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "func.return"(%150) : (index) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_2"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %148 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %149 = "gpu.all_reduce"(%148) <{op = #gpu<all_reduce_op add>, uniform}> ({
      }) : (f32) -> f32
      "gpu.return"() : () -> ()
    }) {sym_name = "gpu_all_reduce_op", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_3"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %145 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %146 = "gpu.all_reduce"(%145) <{uniform}> ({
      ^bb0(%arg110: i32, %arg111: i32):
        %147 = "arith.xori"(%arg110, %arg111) : (i32, i32) -> i32
        "gpu.yield"(%147) : (i32) -> ()
      }) : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {sym_name = "gpu_all_reduce_region", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_4"}> ({
    "func.func"() <{function_type = () -> (f32, f32, f32, f32, i1, i1, i1, i1), sym_name = "gpu_shuffle"}> ({
      %138 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %139 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %140 = "arith.constant"() <{value = 23 : i32}> : () -> i32
      %141:2 = "gpu.shuffle"(%138, %139, %140) <{mode = #gpu<shuffle_mode xor>}> : (f32, i32, i32) -> (f32, i1)
      %142:2 = "gpu.shuffle"(%138, %139, %140) <{mode = #gpu<shuffle_mode up>}> : (f32, i32, i32) -> (f32, i1)
      %143:2 = "gpu.shuffle"(%138, %139, %140) <{mode = #gpu<shuffle_mode down>}> : (f32, i32, i32) -> (f32, i1)
      %144:2 = "gpu.shuffle"(%138, %139, %140) <{mode = #gpu<shuffle_mode idx>}> : (f32, i32, i32) -> (f32, i1)
      "func.return"(%141#0, %142#0, %143#0, %144#0, %141#1, %142#1, %143#1, %144#1) : (f32, f32, f32, f32, i1, i1, i1, i1) -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (f32, f32, f32, f32), sym_name = "gpu_shuffle_unused_pred"}> ({
      %131 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %132 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %133 = "arith.constant"() <{value = 23 : i32}> : () -> i32
      %134:2 = "gpu.shuffle"(%131, %132, %133) <{mode = #gpu<shuffle_mode xor>}> : (f32, i32, i32) -> (f32, i1)
      %135:2 = "gpu.shuffle"(%131, %132, %133) <{mode = #gpu<shuffle_mode up>}> : (f32, i32, i32) -> (f32, i1)
      %136:2 = "gpu.shuffle"(%131, %132, %133) <{mode = #gpu<shuffle_mode down>}> : (f32, i32, i32) -> (f32, i1)
      %137:2 = "gpu.shuffle"(%131, %132, %133) <{mode = #gpu<shuffle_mode idx>}> : (f32, i32, i32) -> (f32, i1)
      "func.return"(%134#0, %135#0, %136#0, %137#0) : (f32, f32, f32, f32) -> ()
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
    ^bb0(%arg108: f32, %arg109: f64):
      %129 = "math.absf"(%arg108) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %130 = "math.absf"(%arg109) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%129, %130) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_7"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_cbrt"}> ({
    ^bb0(%arg106: f32, %arg107: f64):
      %127 = "math.cbrt"(%arg106) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %128 = "math.cbrt"(%arg107) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%127, %128) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_8"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_ceil"}> ({
    ^bb0(%arg104: f32, %arg105: f64):
      %125 = "math.ceil"(%arg104) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %126 = "math.ceil"(%arg105) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%125, %126) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_9"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_floor"}> ({
    ^bb0(%arg102: f32, %arg103: f64):
      %123 = "math.floor"(%arg102) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %124 = "math.floor"(%arg103) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%123, %124) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_10"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_cos"}> ({
    ^bb0(%arg100: f32, %arg101: f64):
      %120 = "math.cos"(%arg100) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %121 = "math.cos"(%arg101) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      %122 = "math.cos"(%arg100) <{fastmath = #arith.fastmath<afn>}> : (f32) -> f32
      "func.return"(%120, %121, %122) : (f32, f64, f32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_11"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_exp"}> ({
    ^bb0(%arg98: f32, %arg99: f64):
      %117 = "math.exp"(%arg98) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %118 = "math.exp"(%arg99) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      %119 = "math.exp"(%arg98) <{fastmath = #arith.fastmath<fast>}> : (f32) -> f32
      "func.return"(%117, %118, %119) : (f32, f64, f32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_12"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_exp2"}> ({
    ^bb0(%arg96: f32, %arg97: f64):
      %115 = "math.exp2"(%arg96) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %116 = "math.exp2"(%arg97) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%115, %116) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_13"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_log"}> ({
    ^bb0(%arg94: f32, %arg95: f64):
      %112 = "math.log"(%arg94) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %113 = "math.log"(%arg95) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      %114 = "math.log"(%arg94) <{fastmath = #arith.fastmath<afn>}> : (f32) -> f32
      "func.return"(%112, %113, %114) : (f32, f64, f32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_14"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_log10"}> ({
    ^bb0(%arg92: f32, %arg93: f64):
      %109 = "math.log10"(%arg92) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %110 = "math.log10"(%arg93) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      %111 = "math.log10"(%arg92) <{fastmath = #arith.fastmath<afn>}> : (f32) -> f32
      "func.return"(%109, %110, %111) : (f32, f64, f32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_15"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_log1p"}> ({
    ^bb0(%arg90: f32, %arg91: f64):
      %107 = "math.log1p"(%arg90) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %108 = "math.log1p"(%arg91) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%107, %108) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_16"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_log2"}> ({
    ^bb0(%arg88: f32, %arg89: f64):
      %104 = "math.log2"(%arg88) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %105 = "math.log2"(%arg89) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      %106 = "math.log2"(%arg88) <{fastmath = #arith.fastmath<fast>}> : (f32) -> f32
      "func.return"(%104, %105, %106) : (f32, f64, f32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_17"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_sin"}> ({
    ^bb0(%arg86: f32, %arg87: f64):
      %101 = "math.sin"(%arg86) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %102 = "math.sin"(%arg87) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      %103 = "math.sin"(%arg86) <{fastmath = #arith.fastmath<fast>}> : (f32) -> f32
      "func.return"(%101, %102, %103) : (f32, f64, f32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_18"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64, f32), sym_name = "gpu_tan"}> ({
    ^bb0(%arg83: f16, %arg84: f32, %arg85: f64):
      %97 = "math.tan"(%arg83) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %98 = "math.tan"(%arg84) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %99 = "math.tan"(%arg85) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      %100 = "math.tan"(%arg84) <{fastmath = #arith.fastmath<fast>}> : (f32) -> f32
      "func.return"(%97, %98, %99, %100) : (f16, f32, f64, f32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_19"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_tanh"}> ({
    ^bb0(%arg80: f16, %arg81: f32, %arg82: f64):
      %94 = "math.tanh"(%arg80) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %95 = "math.tanh"(%arg81) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %96 = "math.tanh"(%arg82) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%94, %95, %96) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_20"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_rsqrt"}> ({
    ^bb0(%arg77: f16, %arg78: f32, %arg79: f64):
      %91 = "math.rsqrt"(%arg77) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %92 = "math.rsqrt"(%arg78) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %93 = "math.rsqrt"(%arg79) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%91, %92, %93) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_21"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_sqrt"}> ({
    ^bb0(%arg74: f16, %arg75: f32, %arg76: f64):
      %88 = "math.sqrt"(%arg74) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %89 = "math.sqrt"(%arg75) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %90 = "math.sqrt"(%arg76) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%88, %89, %90) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_22"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_atan"}> ({
    ^bb0(%arg71: f16, %arg72: f32, %arg73: f64):
      %85 = "math.atan"(%arg71) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %86 = "math.atan"(%arg72) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %87 = "math.atan"(%arg73) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%85, %86, %87) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_23"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_atan2"}> ({
    ^bb0(%arg68: f16, %arg69: f32, %arg70: f64):
      %82 = "math.atan2"(%arg68, %arg68) <{fastmath = #arith.fastmath<none>}> : (f16, f16) -> f16
      %83 = "math.atan2"(%arg69, %arg69) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %84 = "math.atan2"(%arg70, %arg70) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
      "func.return"(%82, %83, %84) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_24"}> ({
    "test.symbol_scope"() ({
      "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_exp"}> ({
      ^bb0(%arg66: f32, %arg67: f64):
        %79 = "math.exp"(%arg66) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        %80 = "math.exp"(%arg67) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
        %81 = "math.exp"(%arg66) <{fastmath = #arith.fastmath<afn>}> : (f32) -> f32
        "func.return"(%79, %80, %81) : (f32, f64, f32) -> ()
      }) : () -> ()
      "test.finish"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_25"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_expm1"}> ({
    ^bb0(%arg64: f32, %arg65: f64):
      %77 = "math.expm1"(%arg64) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %78 = "math.expm1"(%arg65) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%77, %78) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_26"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_pow"}> ({
    ^bb0(%arg62: f32, %arg63: f64):
      %74 = "math.powf"(%arg62, %arg62) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %75 = "math.powf"(%arg63, %arg63) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
      %76 = "math.powf"(%arg62, %arg62) <{fastmath = #arith.fastmath<fast>}> : (f32, f32) -> f32
      "func.return"(%74, %75, %76) : (f32, f64, f32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_27"}> ({
    "func.func"() <{function_type = (vector<4xf32>) -> vector<4xf32>, sym_name = "gpu_unroll"}> ({
    ^bb0(%arg61: vector<4xf32>):
      %73 = "math.exp"(%arg61) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
      "func.return"(%73) : (vector<4xf32>) -> ()
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
    ^bb0(%arg59: i32, %arg60: f32):
      "gpu.printf"(%arg59, %arg60) <{format = "Hello: %d\0A"}> : (i32, f32) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "test_printf", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_30"}> ({
    "gpu.func"() <{function_type = (i32) -> ()}> ({
    ^bb0(%arg58: i32):
      %72 = "gpu.subgroup_reduce"(%arg58) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op add>, uniform}> : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {sym_name = "subgroup_reduce_add", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (i32) -> ()}> ({
    ^bb0(%arg57: i32):
      %71 = "gpu.subgroup_reduce"(%arg57) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op minsi>, uniform}> : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {sym_name = "subgroup_reduce_minsi", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (i32) -> ()}> ({
    ^bb0(%arg56: i32):
      %70 = "gpu.subgroup_reduce"(%arg56) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op maxsi>, uniform}> : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {sym_name = "subgroup_reduce_maxsi", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (i32) -> ()}> ({
    ^bb0(%arg55: i32):
      %69 = "gpu.subgroup_reduce"(%arg55) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op and>, uniform}> : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {sym_name = "subgroup_reduce_and", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (i32) -> ()}> ({
    ^bb0(%arg54: i32):
      %68 = "gpu.subgroup_reduce"(%arg54) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op or>, uniform}> : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {sym_name = "subgroup_reduce_or", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (i32) -> ()}> ({
    ^bb0(%arg53: i32):
      %67 = "gpu.subgroup_reduce"(%arg53) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op xor>, uniform}> : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {sym_name = "subgroup_reduce_xor", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_31"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_fmod"}> ({
    ^bb0(%arg51: f32, %arg52: f64):
      %65 = "arith.remf"(%arg51, %arg51) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %66 = "arith.remf"(%arg52, %arg52) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
      "func.return"(%65, %66) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_32"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_erf"}> ({
    ^bb0(%arg49: f32, %arg50: f64):
      %63 = "math.erf"(%arg49) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %64 = "math.erf"(%arg50) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%63, %64) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_33"}> ({
    "gpu.func"() <{function_type = (!llvm.ptr) -> (), known_block_size = array<i32: 32, 4, 2>}> ({
    ^bb0(%arg48: !llvm.ptr):
      %57 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %58 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %59 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %60 = "arith.addi"(%57, %58) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %61 = "arith.addi"(%60, %59) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %62 = "arith.index_cast"(%61) : (index) -> i64
      "llvm.store"(%62, %arg48) <{ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "kernel_with_block_size", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_34"}> ({
    "gpu.func"() <{function_type = (memref<2xf32>, f32) -> (memref<2xf32>, f32)}> ({
    ^bb0(%arg46: memref<2xf32>, %arg47: f32):
      "gpu.return"(%arg46, %arg47) : (memref<2xf32>, f32) -> ()
    }) {sym_name = "memref_signature", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_35"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_acos"}> ({
    ^bb0(%arg44: f32, %arg45: f64):
      %55 = "math.acos"(%arg44) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %56 = "math.acos"(%arg45) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%55, %56) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_36"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_acosh"}> ({
    ^bb0(%arg42: f32, %arg43: f64):
      %53 = "math.acosh"(%arg42) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %54 = "math.acosh"(%arg43) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%53, %54) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_37"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_asin"}> ({
    ^bb0(%arg40: f32, %arg41: f64):
      %51 = "math.asin"(%arg40) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %52 = "math.asin"(%arg41) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%51, %52) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_38"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_asinh"}> ({
    ^bb0(%arg38: f32, %arg39: f64):
      %49 = "math.asinh"(%arg38) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %50 = "math.asinh"(%arg39) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%49, %50) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_39"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "gpu_atanh"}> ({
    ^bb0(%arg35: f16, %arg36: f32, %arg37: f64):
      %46 = "math.atanh"(%arg35) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %47 = "math.atanh"(%arg36) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %48 = "math.atanh"(%arg37) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%46, %47, %48) : (f16, f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_40"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_copysign"}> ({
    ^bb0(%arg33: f32, %arg34: f64):
      %44 = "math.copysign"(%arg33, %arg33) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %45 = "math.copysign"(%arg34, %arg34) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
      "func.return"(%44, %45) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_41"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_cosh"}> ({
    ^bb0(%arg31: f32, %arg32: f64):
      %42 = "math.cosh"(%arg31) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %43 = "math.cosh"(%arg32) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%42, %43) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_42"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_fma"}> ({
    ^bb0(%arg29: f32, %arg30: f64):
      %40 = "math.fma"(%arg29, %arg29, %arg29) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
      %41 = "math.fma"(%arg30, %arg30, %arg30) <{fastmath = #arith.fastmath<none>}> : (f64, f64, f64) -> f64
      "func.return"(%40, %41) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_43"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_round"}> ({
    ^bb0(%arg27: f32, %arg28: f64):
      %38 = "math.round"(%arg27) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %39 = "math.round"(%arg28) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%38, %39) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_44"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_roundeven"}> ({
    ^bb0(%arg25: f32, %arg26: f64):
      %36 = "math.roundeven"(%arg25) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %37 = "math.roundeven"(%arg26) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%36, %37) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_45"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_sinh"}> ({
    ^bb0(%arg23: f32, %arg24: f64):
      %34 = "math.sinh"(%arg23) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %35 = "math.sinh"(%arg24) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%34, %35) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_46"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_cosh_with_fastmath"}> ({
    ^bb0(%arg21: f32, %arg22: f64):
      %32 = "math.cosh"(%arg21) <{fastmath = #arith.fastmath<fast>}> : (f32) -> f32
      %33 = "math.cosh"(%arg22) <{fastmath = #arith.fastmath<afn>}> : (f64) -> f64
      "func.return"(%32, %33) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_47"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_sinh_with_fastmath"}> ({
    ^bb0(%arg19: f32, %arg20: f64):
      %30 = "math.sinh"(%arg19) <{fastmath = #arith.fastmath<contract>}> : (f32) -> f32
      %31 = "math.sinh"(%arg20) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%30, %31) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_48"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64, f32), sym_name = "gpu_exp_with_fastmath"}> ({
    ^bb0(%arg17: f32, %arg18: f64):
      %27 = "math.exp"(%arg17) <{fastmath = #arith.fastmath<reassoc>}> : (f32) -> f32
      %28 = "math.exp"(%arg18) <{fastmath = #arith.fastmath<contract>}> : (f64) -> f64
      %29 = "math.exp"(%arg17) <{fastmath = #arith.fastmath<ninf>}> : (f32) -> f32
      "func.return"(%27, %28, %29) : (f32, f64, f32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_49"}> ({
    "func.func"() <{function_type = () -> (index, index, index), sym_name = "explicit_id_bounds"}> ({
      %24 = "gpu.thread_id"() <{dimension = #gpu<dim x>, upper_bound = 32 : index}> : () -> index
      %25 = "gpu.block_dim"() <{dimension = #gpu<dim x>, upper_bound = 32 : index}> : () -> index
      %26 = "gpu.lane_id"() <{upper_bound = 16 : index}> : () -> index
      "func.return"(%24, %25, %26) : (index, index, index) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_50"}> ({
    "gpu.func"() <{function_type = (!llvm.ptr) -> (), known_grid_size = array<i32: 32, 4, 2>}> ({
    ^bb0(%arg16: !llvm.ptr):
      %18 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %19 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %20 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %21 = "arith.addi"(%18, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %22 = "arith.addi"(%21, %20) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %23 = "arith.index_cast"(%22) : (index) -> i64
      "llvm.store"(%23, %arg16) <{ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "kernel_with_grid_size", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_51"}> ({
    "gpu.func"() <{function_type = (i1) -> ()}> ({
    ^bb0(%arg15: i1):
      "cf.assert"(%arg15) <{msg = "assert message"}> : (i1) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "test_assert", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg14: !transform.any_op):
      %17 = "transform.structured.match"(%arg14) <{ops = ["gpu.module"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%17) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.gpu.gpu_rewrite_patterns"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.apply_conversion_patterns"(%17) <{illegal_dialects = ["gpu"], illegal_ops = ["llvm.copysign", "llvm.cos", "llvm.exp", "llvm.exp2", "llvm.fabs", "llvm.fceil", "llvm.ffloor", "llvm.frem", "llvm.log", "llvm.log10", "llvm.log2", "llvm.pow", "llvm.roundeven", "llvm.round", "llvm.sin", "llvm.sqrt"], legal_dialects = ["llvm", "memref", "nvvm", "test"], legal_ops = ["func.func", "gpu.module", "gpu.yield"], partial_conversion}> ({
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
    ^bb0(%arg13: i32):
      %16 = "math.absi"(%arg13) : (i32) -> i32
      "func.return"(%16) : (i32) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_53"}> ({
    "func.func"() <{function_type = (f32, f64, i32) -> (f32, f64), sym_name = "gpu_powi"}> ({
    ^bb0(%arg10: f32, %arg11: f64, %arg12: i32):
      %14 = "math.fpowi"(%arg10, %arg12) <{fastmath = #arith.fastmath<none>}> : (f32, i32) -> f32
      %15 = "math.fpowi"(%arg11, %arg12) <{fastmath = #arith.fastmath<none>}> : (f64, i32) -> f64
      "func.return"(%14, %15) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_54"}> ({
    "func.func"() <{function_type = (f32, f64) -> (i1, i1, i1, i1, i1, i1), sym_name = "fpclassify"}> ({
    ^bb0(%arg8: f32, %arg9: f64):
      %8 = "math.isinf"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> i1
      %9 = "math.isinf"(%arg9) <{fastmath = #arith.fastmath<none>}> : (f64) -> i1
      %10 = "math.isnan"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> i1
      %11 = "math.isnan"(%arg9) <{fastmath = #arith.fastmath<none>}> : (f64) -> i1
      %12 = "math.isfinite"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> i1
      %13 = "math.isfinite"(%arg9) <{fastmath = #arith.fastmath<none>}> : (f64) -> i1
      "func.return"(%8, %9, %10, %11, %12, %13) : (i1, i1, i1, i1, i1, i1) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_55"}> ({
    "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "gpu_erfc"}> ({
    ^bb0(%arg6: f32, %arg7: f64):
      %6 = "math.erfc"(%arg6) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %7 = "math.erfc"(%arg7) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
      "func.return"(%6, %7) : (f32, f64) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_56"}> ({
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f16, f32, f32, f64, f64), sym_name = "gpu_sincos"}> ({
    ^bb0(%arg3: f16, %arg4: f32, %arg5: f64):
      %3:2 = "math.sincos"(%arg3) <{fastmath = #arith.fastmath<none>}> : (f16) -> (f16, f16)
      %4:2 = "math.sincos"(%arg4) <{fastmath = #arith.fastmath<none>}> : (f32) -> (f32, f32)
      %5:2 = "math.sincos"(%arg5) <{fastmath = #arith.fastmath<none>}> : (f64) -> (f64, f64)
      "func.return"(%3#0, %3#1, %4#0, %4#1, %5#0, %5#1) : (f16, f16, f32, f32, f64, f64) -> ()
    }) : () -> ()
    "func.func"() <{function_type = (f16, f32, f64) -> (f16, f16, f32, f32, f64, f64), sym_name = "gpu_sincos_fastmath"}> ({
    ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
      %0:2 = "math.sincos"(%arg0) <{fastmath = #arith.fastmath<afn>}> : (f16) -> (f16, f16)
      %1:2 = "math.sincos"(%arg1) <{fastmath = #arith.fastmath<afn>}> : (f32) -> (f32, f32)
      %2:2 = "math.sincos"(%arg2) <{fastmath = #arith.fastmath<afn>}> : (f64) -> (f64, f64)
      "func.return"(%0#0, %0#1, %1#0, %1#1, %2#0, %2#1) : (f16, f16, f32, f32, f64, f64) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module_cluster_size"}> ({
    "gpu.func"() <{function_type = () -> (), known_cluster_size = array<i32: 8, 2, 4>}> ({
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "kernel_with_cluster_size", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
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

