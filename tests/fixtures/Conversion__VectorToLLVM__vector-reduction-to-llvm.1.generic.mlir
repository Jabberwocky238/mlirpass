"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>) -> f32, sym_name = "reduce_add_f32"}> ({
  ^bb0(%arg0: vector<16xf32>):
    %0 = "llvm.mlir.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "llvm.intr.vector.reduce.fadd"(%0, %arg0) <{fastmathFlags = #llvm.fastmath<reassoc>}> : (f32, vector<16xf32>) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>) -> f32, sym_name = "reduce_add_f32_always_reassoc"}> ({
  ^bb0(%arg0: vector<16xf32>):
    %0 = "llvm.mlir.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "llvm.intr.vector.reduce.fadd"(%0, %arg0) <{fastmathFlags = #llvm.fastmath<reassoc>}> : (f32, vector<16xf32>) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>) -> f32, sym_name = "reduce_mul_f32"}> ({
  ^bb0(%arg0: vector<16xf32>):
    %0 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "llvm.intr.vector.reduce.fmul"(%0, %arg0) <{fastmathFlags = #llvm.fastmath<nnan, ninf, reassoc>}> : (f32, vector<16xf32>) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>, vector<16xi1>) -> f32, sym_name = "masked_reduce_add_f32"}> ({
  ^bb0(%arg0: vector<16xf32>, %arg1: vector<16xi1>):
    %0 = "llvm.mlir.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
    %2 = "llvm.intr.vp.reduce.fadd"(%0, %arg0, %arg1, %1) : (f32, vector<16xf32>, vector<16xi1>, i32) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xf32>, vector<[16]xi1>) -> f32, sym_name = "masked_reduce_add_f32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xf32>, %arg1: vector<[16]xi1>):
    %0 = "llvm.mlir.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
    %2 = "llvm.intr.vscale"() : () -> i64
    %3 = "builtin.unrealized_conversion_cast"(%2) : (i64) -> index
    %4 = "arith.index_cast"(%3) : (index) -> i32
    %5 = "arith.muli"(%1, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %6 = "llvm.intr.vp.reduce.fadd"(%0, %arg0, %arg1, %5) : (f32, vector<[16]xf32>, vector<[16]xi1>, i32) -> f32
    "func.return"(%6) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>, vector<16xi1>) -> f32, sym_name = "masked_reduce_mul_f32"}> ({
  ^bb0(%arg0: vector<16xf32>, %arg1: vector<16xi1>):
    %0 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
    %2 = "llvm.intr.vp.reduce.fmul"(%0, %arg0, %arg1, %1) : (f32, vector<16xf32>, vector<16xi1>, i32) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>, vector<16xi1>) -> f32, sym_name = "masked_reduce_minf_f32"}> ({
  ^bb0(%arg0: vector<16xf32>, %arg1: vector<16xi1>):
    %0 = "llvm.mlir.constant"() <{value = 0xFFC00000 : f32}> : () -> f32
    %1 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
    %2 = "llvm.intr.vp.reduce.fmin"(%0, %arg0, %arg1, %1) : (f32, vector<16xf32>, vector<16xi1>, i32) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xf32>, vector<[16]xi1>) -> f32, sym_name = "masked_reduce_minf_f32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xf32>, %arg1: vector<[16]xi1>):
    %0 = "llvm.mlir.constant"() <{value = 0xFFC00000 : f32}> : () -> f32
    %1 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
    %2 = "llvm.intr.vscale"() : () -> i64
    %3 = "builtin.unrealized_conversion_cast"(%2) : (i64) -> index
    %4 = "arith.index_cast"(%3) : (index) -> i32
    %5 = "arith.muli"(%1, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %6 = "llvm.intr.vp.reduce.fmin"(%0, %arg0, %arg1, %5) : (f32, vector<[16]xf32>, vector<[16]xi1>, i32) -> f32
    "func.return"(%6) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>, vector<16xi1>) -> f32, sym_name = "masked_reduce_maxf_f32"}> ({
  ^bb0(%arg0: vector<16xf32>, %arg1: vector<16xi1>):
    %0 = "llvm.mlir.constant"() <{value = 0x7FC00000 : f32}> : () -> f32
    %1 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
    %2 = "llvm.intr.vp.reduce.fmax"(%0, %arg0, %arg1, %1) : (f32, vector<16xf32>, vector<16xi1>, i32) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>, vector<16xi1>) -> f32, sym_name = "masked_reduce_maximumf_f32"}> ({
  ^bb0(%arg0: vector<16xf32>, %arg1: vector<16xi1>):
    %0 = "llvm.mlir.constant"() <{value = dense<-1.401300e-45> : vector<16xf32>}> : () -> vector<16xf32>
    %1 = "llvm.select"(%arg1, %arg0, %0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<16xi1>, vector<16xf32>, vector<16xf32>) -> vector<16xf32>
    %2 = "llvm.intr.vector.reduce.fmaximum"(%1) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<16xf32>) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>, vector<16xi1>) -> f32, sym_name = "masked_reduce_minimumf_f32"}> ({
  ^bb0(%arg0: vector<16xf32>, %arg1: vector<16xi1>):
    %0 = "llvm.mlir.constant"() <{value = dense<3.40282347E+38> : vector<16xf32>}> : () -> vector<16xf32>
    %1 = "llvm.select"(%arg1, %arg0, %0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<16xi1>, vector<16xf32>, vector<16xf32>) -> vector<16xf32>
    %2 = "llvm.intr.vector.reduce.fminimum"(%1) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<16xf32>) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32xi8>, vector<32xi1>) -> i8, sym_name = "masked_reduce_add_i8"}> ({
  ^bb0(%arg0: vector<32xi8>, %arg1: vector<32xi1>):
    %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
    %1 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
    %2 = "llvm.intr.vp.reduce.add"(%0, %arg0, %arg1, %1) : (i8, vector<32xi8>, vector<32xi1>, i32) -> i8
    "func.return"(%2) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[32]xi8>, vector<[32]xi1>) -> i8, sym_name = "masked_reduce_add_i8_scalable"}> ({
  ^bb0(%arg0: vector<[32]xi8>, %arg1: vector<[32]xi1>):
    %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
    %1 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
    %2 = "llvm.intr.vscale"() : () -> i64
    %3 = "builtin.unrealized_conversion_cast"(%2) : (i64) -> index
    %4 = "arith.index_cast"(%3) : (index) -> i32
    %5 = "arith.muli"(%1, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %6 = "llvm.intr.vp.reduce.add"(%0, %arg0, %arg1, %5) : (i8, vector<[32]xi8>, vector<[32]xi1>, i32) -> i8
    "func.return"(%6) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32xi8>, vector<32xi1>) -> i8, sym_name = "masked_reduce_mul_i8"}> ({
  ^bb0(%arg0: vector<32xi8>, %arg1: vector<32xi1>):
    %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
    %1 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
    %2 = "llvm.intr.vp.reduce.mul"(%0, %arg0, %arg1, %1) : (i8, vector<32xi8>, vector<32xi1>, i32) -> i8
    "func.return"(%2) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32xi8>, vector<32xi1>) -> i8, sym_name = "masked_reduce_minui_i8"}> ({
  ^bb0(%arg0: vector<32xi8>, %arg1: vector<32xi1>):
    %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
    %1 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
    %2 = "llvm.intr.vp.reduce.umin"(%0, %arg0, %arg1, %1) : (i8, vector<32xi8>, vector<32xi1>, i32) -> i8
    "func.return"(%2) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[32]xi8>, vector<[32]xi1>) -> i8, sym_name = "masked_reduce_minui_i8_scalable"}> ({
  ^bb0(%arg0: vector<[32]xi8>, %arg1: vector<[32]xi1>):
    %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
    %1 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
    %2 = "llvm.intr.vscale"() : () -> i64
    %3 = "builtin.unrealized_conversion_cast"(%2) : (i64) -> index
    %4 = "arith.index_cast"(%3) : (index) -> i32
    %5 = "arith.muli"(%1, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %6 = "llvm.intr.vp.reduce.umin"(%0, %arg0, %arg1, %5) : (i8, vector<[32]xi8>, vector<[32]xi1>, i32) -> i8
    "func.return"(%6) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32xi8>, vector<32xi1>) -> i8, sym_name = "masked_reduce_maxui_i8"}> ({
  ^bb0(%arg0: vector<32xi8>, %arg1: vector<32xi1>):
    %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
    %1 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
    %2 = "llvm.intr.vp.reduce.umax"(%0, %arg0, %arg1, %1) : (i8, vector<32xi8>, vector<32xi1>, i32) -> i8
    "func.return"(%2) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32xi8>, vector<32xi1>) -> i8, sym_name = "masked_reduce_minsi_i8"}> ({
  ^bb0(%arg0: vector<32xi8>, %arg1: vector<32xi1>):
    %0 = "llvm.mlir.constant"() <{value = 127 : i8}> : () -> i8
    %1 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
    %2 = "llvm.intr.vp.reduce.smin"(%0, %arg0, %arg1, %1) : (i8, vector<32xi8>, vector<32xi1>, i32) -> i8
    "func.return"(%2) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32xi8>, vector<32xi1>) -> i8, sym_name = "masked_reduce_maxsi_i8"}> ({
  ^bb0(%arg0: vector<32xi8>, %arg1: vector<32xi1>):
    %0 = "llvm.mlir.constant"() <{value = -128 : i8}> : () -> i8
    %1 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
    %2 = "llvm.intr.vp.reduce.smax"(%0, %arg0, %arg1, %1) : (i8, vector<32xi8>, vector<32xi1>, i32) -> i8
    "func.return"(%2) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[32]xi8>, vector<[32]xi1>) -> i8, sym_name = "masked_reduce_maxsi_i8_scalable"}> ({
  ^bb0(%arg0: vector<[32]xi8>, %arg1: vector<[32]xi1>):
    %0 = "llvm.mlir.constant"() <{value = -128 : i8}> : () -> i8
    %1 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
    %2 = "llvm.intr.vscale"() : () -> i64
    %3 = "builtin.unrealized_conversion_cast"(%2) : (i64) -> index
    %4 = "arith.index_cast"(%3) : (index) -> i32
    %5 = "arith.muli"(%1, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %6 = "llvm.intr.vp.reduce.smax"(%0, %arg0, %arg1, %5) : (i8, vector<[32]xi8>, vector<[32]xi1>, i32) -> i8
    "func.return"(%6) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32xi8>, vector<32xi1>) -> i8, sym_name = "masked_reduce_or_i8"}> ({
  ^bb0(%arg0: vector<32xi8>, %arg1: vector<32xi1>):
    %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
    %1 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
    %2 = "llvm.intr.vp.reduce.or"(%0, %arg0, %arg1, %1) : (i8, vector<32xi8>, vector<32xi1>, i32) -> i8
    "func.return"(%2) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32xi8>, vector<32xi1>) -> i8, sym_name = "masked_reduce_and_i8"}> ({
  ^bb0(%arg0: vector<32xi8>, %arg1: vector<32xi1>):
    %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
    %1 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
    %2 = "llvm.intr.vp.reduce.and"(%0, %arg0, %arg1, %1) : (i8, vector<32xi8>, vector<32xi1>, i32) -> i8
    "func.return"(%2) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32xi8>, vector<32xi1>) -> i8, sym_name = "masked_reduce_xor_i8"}> ({
  ^bb0(%arg0: vector<32xi8>, %arg1: vector<32xi1>):
    %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
    %1 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
    %2 = "llvm.intr.vp.reduce.xor"(%0, %arg0, %arg1, %1) : (i8, vector<32xi8>, vector<32xi1>, i32) -> i8
    "func.return"(%2) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[32]xi8>, vector<[32]xi1>) -> i8, sym_name = "masked_reduce_xor_i8_scalable"}> ({
  ^bb0(%arg0: vector<[32]xi8>, %arg1: vector<[32]xi1>):
    %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
    %1 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
    %2 = "llvm.intr.vscale"() : () -> i64
    %3 = "builtin.unrealized_conversion_cast"(%2) : (i64) -> index
    %4 = "arith.index_cast"(%3) : (index) -> i32
    %5 = "arith.muli"(%1, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %6 = "llvm.intr.vp.reduce.xor"(%0, %arg0, %arg1, %5) : (i8, vector<[32]xi8>, vector<[32]xi1>, i32) -> i8
    "func.return"(%6) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

