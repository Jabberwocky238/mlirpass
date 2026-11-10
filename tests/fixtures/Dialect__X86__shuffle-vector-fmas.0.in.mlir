"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x1x1xbf16>, memref<1x1x1xbf16>, memref<1x8x2xbf16>, memref<1x1x1xbf16>, memref<1x1x1xbf16>, memref<1x8x2xbf16>, vector<8xf32>) -> vector<8xf32>, sym_name = "shuffle_fma_with_rhs_as_even.index_to_f32"}> ({
  ^bb0(%arg1: memref<1x1x1xbf16>, %arg2: memref<1x1x1xbf16>, %arg3: memref<1x8x2xbf16>, %arg4: memref<1x1x1xbf16>, %arg5: memref<1x1x1xbf16>, %arg6: memref<1x8x2xbf16>, %arg7: vector<8xf32>):
    %1 = "x86.avx.bcst_to_f32.packed"(%arg1) : (memref<1x1x1xbf16>) -> vector<8xf32>
    %2 = "x86.avx.cvt.packed.odd.indexed_to_f32"(%arg3) : (memref<1x8x2xbf16>) -> vector<8xf32>
    %3 = "vector.fma"(%1, %2, %arg7) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %4 = "x86.avx.bcst_to_f32.packed"(%arg2) : (memref<1x1x1xbf16>) -> vector<8xf32>
    %5 = "x86.avx.cvt.packed.even.indexed_to_f32"(%arg3) : (memref<1x8x2xbf16>) -> vector<8xf32>
    %6 = "vector.fma"(%4, %5, %3) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %7 = "x86.avx.bcst_to_f32.packed"(%arg4) : (memref<1x1x1xbf16>) -> vector<8xf32>
    %8 = "x86.avx.cvt.packed.odd.indexed_to_f32"(%arg6) : (memref<1x8x2xbf16>) -> vector<8xf32>
    %9 = "vector.fma"(%7, %8, %arg7) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %10 = "x86.avx.bcst_to_f32.packed"(%arg5) : (memref<1x1x1xbf16>) -> vector<8xf32>
    %11 = "x86.avx.cvt.packed.even.indexed_to_f32"(%arg6) : (memref<1x8x2xbf16>) -> vector<8xf32>
    %12 = "vector.fma"(%10, %11, %9) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %13 = "vector.fma"(%6, %12, %arg7) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    "func.return"(%13) : (vector<8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.shuffle_vector_fma_ops"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x1x1xbf16>, memref<1x1x1xbf16>, memref<1x8x2xbf16>, memref<1x1x1xbf16>, memref<1x1x1xbf16>, memref<1x8x2xbf16>, vector<8xf32>) -> vector<8xf32>, sym_name = "shuffle_fma_with_lhs_as_even.index_to_f32"}> ({
  ^bb0(%arg1: memref<1x1x1xbf16>, %arg2: memref<1x1x1xbf16>, %arg3: memref<1x8x2xbf16>, %arg4: memref<1x1x1xbf16>, %arg5: memref<1x1x1xbf16>, %arg6: memref<1x8x2xbf16>, %arg7: vector<8xf32>):
    %1 = "x86.avx.bcst_to_f32.packed"(%arg1) : (memref<1x1x1xbf16>) -> vector<8xf32>
    %2 = "x86.avx.cvt.packed.odd.indexed_to_f32"(%arg3) : (memref<1x8x2xbf16>) -> vector<8xf32>
    %3 = "vector.fma"(%1, %2, %arg7) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %4 = "x86.avx.bcst_to_f32.packed"(%arg2) : (memref<1x1x1xbf16>) -> vector<8xf32>
    %5 = "x86.avx.cvt.packed.even.indexed_to_f32"(%arg3) : (memref<1x8x2xbf16>) -> vector<8xf32>
    %6 = "vector.fma"(%5, %4, %3) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %7 = "x86.avx.bcst_to_f32.packed"(%arg4) : (memref<1x1x1xbf16>) -> vector<8xf32>
    %8 = "x86.avx.cvt.packed.odd.indexed_to_f32"(%arg6) : (memref<1x8x2xbf16>) -> vector<8xf32>
    %9 = "vector.fma"(%7, %8, %arg7) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %10 = "x86.avx.bcst_to_f32.packed"(%arg5) : (memref<1x1x1xbf16>) -> vector<8xf32>
    %11 = "x86.avx.cvt.packed.even.indexed_to_f32"(%arg6) : (memref<1x8x2xbf16>) -> vector<8xf32>
    %12 = "vector.fma"(%10, %11, %9) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %13 = "vector.fma"(%6, %12, %arg7) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    "func.return"(%13) : (vector<8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.shuffle_vector_fma_ops"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x1x1xbf16>, memref<1x1x1xbf16>, memref<1x8x2xbf16>, memref<1x1x1xbf16>, memref<1x1x1xbf16>, memref<1x8x2xbf16>, vector<8xf32>) -> vector<1x8xf32>, sym_name = "shuffle_fma_with_shape_cast"}> ({
  ^bb0(%arg1: memref<1x1x1xbf16>, %arg2: memref<1x1x1xbf16>, %arg3: memref<1x8x2xbf16>, %arg4: memref<1x1x1xbf16>, %arg5: memref<1x1x1xbf16>, %arg6: memref<1x8x2xbf16>, %arg7: vector<8xf32>):
    %1 = "x86.avx.bcst_to_f32.packed"(%arg1) : (memref<1x1x1xbf16>) -> vector<8xf32>
    %2 = "x86.avx.cvt.packed.odd.indexed_to_f32"(%arg3) : (memref<1x8x2xbf16>) -> vector<8xf32>
    %3 = "vector.fma"(%1, %2, %arg7) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %4 = "x86.avx.bcst_to_f32.packed"(%arg2) : (memref<1x1x1xbf16>) -> vector<8xf32>
    %5 = "x86.avx.cvt.packed.even.indexed_to_f32"(%arg3) : (memref<1x8x2xbf16>) -> vector<8xf32>
    %6 = "vector.fma"(%4, %5, %3) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %7 = "vector.shape_cast"(%6) : (vector<8xf32>) -> vector<1x8xf32>
    %8 = "x86.avx.bcst_to_f32.packed"(%arg4) : (memref<1x1x1xbf16>) -> vector<8xf32>
    %9 = "x86.avx.cvt.packed.odd.indexed_to_f32"(%arg6) : (memref<1x8x2xbf16>) -> vector<8xf32>
    %10 = "vector.fma"(%8, %9, %arg7) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %11 = "x86.avx.bcst_to_f32.packed"(%arg5) : (memref<1x1x1xbf16>) -> vector<8xf32>
    %12 = "x86.avx.cvt.packed.even.indexed_to_f32"(%arg6) : (memref<1x8x2xbf16>) -> vector<8xf32>
    %13 = "vector.fma"(%11, %12, %10) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %14 = "vector.shape_cast"(%13) : (vector<8xf32>) -> vector<1x8xf32>
    %15 = "arith.addf"(%7, %14) <{fastmath = #arith.fastmath<none>}> : (vector<1x8xf32>, vector<1x8xf32>) -> vector<1x8xf32>
    "func.return"(%15) : (vector<1x8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.shuffle_vector_fma_ops"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x1x1xbf16>, memref<1x1x1xbf16>, memref<1x8x2xbf16>, memref<1x1x1xbf16>, memref<1x8x2xbf16>, vector<8xf32>) -> vector<8xf32>, sym_name = "negative_fma_operand_has_multiple_consumer"}> ({
  ^bb0(%arg1: memref<1x1x1xbf16>, %arg2: memref<1x1x1xbf16>, %arg3: memref<1x8x2xbf16>, %arg4: memref<1x1x1xbf16>, %arg5: memref<1x8x2xbf16>, %arg6: vector<8xf32>):
    %1 = "x86.avx.bcst_to_f32.packed"(%arg1) : (memref<1x1x1xbf16>) -> vector<8xf32>
    %2 = "x86.avx.cvt.packed.odd.indexed_to_f32"(%arg3) : (memref<1x8x2xbf16>) -> vector<8xf32>
    %3 = "vector.fma"(%1, %2, %arg6) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %4 = "x86.avx.bcst_to_f32.packed"(%arg2) : (memref<1x1x1xbf16>) -> vector<8xf32>
    %5 = "x86.avx.cvt.packed.even.indexed_to_f32"(%arg3) : (memref<1x8x2xbf16>) -> vector<8xf32>
    %6 = "vector.fma"(%4, %5, %3) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %7 = "x86.avx.cvt.packed.odd.indexed_to_f32"(%arg5) : (memref<1x8x2xbf16>) -> vector<8xf32>
    %8 = "vector.fma"(%4, %7, %arg6) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %9 = "x86.avx.bcst_to_f32.packed"(%arg4) : (memref<1x1x1xbf16>) -> vector<8xf32>
    %10 = "x86.avx.cvt.packed.even.indexed_to_f32"(%arg5) : (memref<1x8x2xbf16>) -> vector<8xf32>
    %11 = "vector.fma"(%9, %10, %8) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %12 = "vector.fma"(%6, %11, %arg6) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    "func.return"(%12) : (vector<8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.shuffle_vector_fma_ops"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x1x1xbf16>, memref<1x1x1xbf16>, memref<1x8x2xbf16>, memref<1x1x1xbf16>, memref<1x1x1xbf16>, memref<1x8x2xbf16>, vector<8xf32>) -> vector<8xf32>, sym_name = "negative_fma_has_multiple_consumer"}> ({
  ^bb0(%arg1: memref<1x1x1xbf16>, %arg2: memref<1x1x1xbf16>, %arg3: memref<1x8x2xbf16>, %arg4: memref<1x1x1xbf16>, %arg5: memref<1x1x1xbf16>, %arg6: memref<1x8x2xbf16>, %arg7: vector<8xf32>):
    %1 = "x86.avx.bcst_to_f32.packed"(%arg1) : (memref<1x1x1xbf16>) -> vector<8xf32>
    %2 = "x86.avx.cvt.packed.odd.indexed_to_f32"(%arg3) : (memref<1x8x2xbf16>) -> vector<8xf32>
    %3 = "vector.fma"(%1, %2, %arg7) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %4 = "x86.avx.bcst_to_f32.packed"(%arg2) : (memref<1x1x1xbf16>) -> vector<8xf32>
    %5 = "x86.avx.cvt.packed.even.indexed_to_f32"(%arg3) : (memref<1x8x2xbf16>) -> vector<8xf32>
    %6 = "vector.fma"(%4, %5, %3) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %7 = "x86.avx.bcst_to_f32.packed"(%arg4) : (memref<1x1x1xbf16>) -> vector<8xf32>
    %8 = "x86.avx.cvt.packed.odd.indexed_to_f32"(%arg6) : (memref<1x8x2xbf16>) -> vector<8xf32>
    %9 = "vector.fma"(%7, %8, %6) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %10 = "x86.avx.bcst_to_f32.packed"(%arg5) : (memref<1x1x1xbf16>) -> vector<8xf32>
    %11 = "x86.avx.cvt.packed.even.indexed_to_f32"(%arg6) : (memref<1x8x2xbf16>) -> vector<8xf32>
    %12 = "vector.fma"(%10, %11, %9) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %13 = "vector.fma"(%6, %12, %arg7) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    "func.return"(%13) : (vector<8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.shuffle_vector_fma_ops"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x1x1xbf16>, memref<1x1x1xbf16>, memref<1x8x2xbf16>, memref<1x1x1xbf16>, memref<1x1x1xbf16>, memref<1x8x2xbf16>, vector<8xf32>, i1) -> vector<8xf32>, sym_name = "negative_no_shuffle_outside_block"}> ({
  ^bb0(%arg1: memref<1x1x1xbf16>, %arg2: memref<1x1x1xbf16>, %arg3: memref<1x8x2xbf16>, %arg4: memref<1x1x1xbf16>, %arg5: memref<1x1x1xbf16>, %arg6: memref<1x8x2xbf16>, %arg7: vector<8xf32>, %arg8: i1):
    %1 = "x86.avx.bcst_to_f32.packed"(%arg1) : (memref<1x1x1xbf16>) -> vector<8xf32>
    %2 = "x86.avx.cvt.packed.odd.indexed_to_f32"(%arg3) : (memref<1x8x2xbf16>) -> vector<8xf32>
    %3 = "vector.fma"(%1, %2, %arg7) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %4 = "x86.avx.bcst_to_f32.packed"(%arg2) : (memref<1x1x1xbf16>) -> vector<8xf32>
    %5 = "x86.avx.cvt.packed.even.indexed_to_f32"(%arg3) : (memref<1x8x2xbf16>) -> vector<8xf32>
    %6 = "vector.fma"(%4, %5, %3) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %7 = "scf.if"(%arg8) ({
      %15 = "x86.avx.bcst_to_f32.packed"(%arg4) : (memref<1x1x1xbf16>) -> vector<8xf32>
      %16 = "x86.avx.cvt.packed.odd.indexed_to_f32"(%arg6) : (memref<1x8x2xbf16>) -> vector<8xf32>
      %17 = "vector.fma"(%15, %16, %arg7) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
      %18 = "x86.avx.bcst_to_f32.packed"(%arg5) : (memref<1x1x1xbf16>) -> vector<8xf32>
      %19 = "x86.avx.cvt.packed.even.indexed_to_f32"(%arg6) : (memref<1x8x2xbf16>) -> vector<8xf32>
      %20 = "vector.fma"(%18, %19, %17) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
      %21 = "vector.fma"(%6, %20, %arg7) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
      "scf.yield"(%21) : (vector<8xf32>) -> ()
    }, {
      %8 = "x86.avx.bcst_to_f32.packed"(%arg4) : (memref<1x1x1xbf16>) -> vector<8xf32>
      %9 = "x86.avx.cvt.packed.odd.indexed_to_f32"(%arg6) : (memref<1x8x2xbf16>) -> vector<8xf32>
      %10 = "vector.fma"(%8, %9, %arg7) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
      %11 = "x86.avx.bcst_to_f32.packed"(%arg5) : (memref<1x1x1xbf16>) -> vector<8xf32>
      %12 = "x86.avx.cvt.packed.even.indexed_to_f32"(%arg6) : (memref<1x8x2xbf16>) -> vector<8xf32>
      %13 = "vector.fma"(%11, %12, %10) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
      %14 = "vector.fma"(%6, %13, %arg7) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
      "scf.yield"(%14) : (vector<8xf32>) -> ()
    }) : (i1) -> vector<8xf32>
    "func.return"(%7) : (vector<8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.shuffle_vector_fma_ops"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

