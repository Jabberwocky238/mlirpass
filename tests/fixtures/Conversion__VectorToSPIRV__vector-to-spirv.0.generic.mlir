"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf16>) -> (vector<4xf16>, vector<1xf32>), sym_name = "bitcast"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<2xf16>):
    %0 = "spirv.Bitcast"(%arg0) : (vector<2xf32>) -> vector<4xf16>
    %1 = "spirv.Bitcast"(%arg1) : (vector<2xf16>) -> f32
    %2 = "builtin.unrealized_conversion_cast"(%1) : (f32) -> vector<1xf32>
    "func.return"(%0, %2) : (vector<4xf16>, vector<1xf32>) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Float16], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf16>) -> (vector<4xf16>, vector<1xf32>), sym_name = "bitcast"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<2xf16>):
    %0 = "vector.bitcast"(%arg0) : (vector<2xf32>) -> vector<4xf16>
    %1 = "vector.bitcast"(%arg1) : (vector<2xf16>) -> vector<1xf32>
    "func.return"(%0, %1) : (vector<4xf16>, vector<1xf32>) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>, sym_name = "cl_fma"}> ({
  ^bb0(%arg15: vector<4xf32>, %arg16: vector<4xf32>, %arg17: vector<4xf32>):
    %41 = "spirv.CL.fma"(%arg15, %arg16, %arg17) : (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"(%41) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf32>, vector<1xf32>, vector<1xf32>) -> vector<1xf32>, sym_name = "cl_fma_size1_vector"}> ({
  ^bb0(%arg12: vector<1xf32>, %arg13: vector<1xf32>, %arg14: vector<1xf32>):
    %36 = "builtin.unrealized_conversion_cast"(%arg14) : (vector<1xf32>) -> f32
    %37 = "builtin.unrealized_conversion_cast"(%arg13) : (vector<1xf32>) -> f32
    %38 = "builtin.unrealized_conversion_cast"(%arg12) : (vector<1xf32>) -> f32
    %39 = "spirv.CL.fma"(%38, %37, %36) : (f32, f32, f32) -> f32
    %40 = "builtin.unrealized_conversion_cast"(%39) : (f32) -> vector<1xf32>
    "func.return"(%40) : (vector<1xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf32>, f32) -> f32, sym_name = "cl_reduction_maximumf"}> ({
  ^bb0(%arg10: vector<3xf32>, %arg11: f32):
    %30 = "spirv.CompositeExtract"(%arg10) <{indices = [0 : i32]}> : (vector<3xf32>) -> f32
    %31 = "spirv.CompositeExtract"(%arg10) <{indices = [1 : i32]}> : (vector<3xf32>) -> f32
    %32 = "spirv.CompositeExtract"(%arg10) <{indices = [2 : i32]}> : (vector<3xf32>) -> f32
    %33 = "spirv.CL.fmax"(%30, %31) : (f32, f32) -> f32
    %34 = "spirv.CL.fmax"(%33, %32) : (f32, f32) -> f32
    %35 = "spirv.CL.fmax"(%34, %arg11) : (f32, f32) -> f32
    "func.return"(%35) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf32>, f32) -> f32, sym_name = "cl_reduction_minimumf"}> ({
  ^bb0(%arg8: vector<3xf32>, %arg9: f32):
    %24 = "spirv.CompositeExtract"(%arg8) <{indices = [0 : i32]}> : (vector<3xf32>) -> f32
    %25 = "spirv.CompositeExtract"(%arg8) <{indices = [1 : i32]}> : (vector<3xf32>) -> f32
    %26 = "spirv.CompositeExtract"(%arg8) <{indices = [2 : i32]}> : (vector<3xf32>) -> f32
    %27 = "spirv.CL.fmin"(%24, %25) : (f32, f32) -> f32
    %28 = "spirv.CL.fmin"(%27, %26) : (f32, f32) -> f32
    %29 = "spirv.CL.fmin"(%28, %arg9) : (f32, f32) -> f32
    "func.return"(%29) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi32>, i32) -> i32, sym_name = "cl_reduction_maxsi"}> ({
  ^bb0(%arg6: vector<3xi32>, %arg7: i32):
    %18 = "spirv.CompositeExtract"(%arg6) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
    %19 = "spirv.CompositeExtract"(%arg6) <{indices = [1 : i32]}> : (vector<3xi32>) -> i32
    %20 = "spirv.CompositeExtract"(%arg6) <{indices = [2 : i32]}> : (vector<3xi32>) -> i32
    %21 = "spirv.CL.s_max"(%18, %19) : (i32, i32) -> i32
    %22 = "spirv.CL.s_max"(%21, %20) : (i32, i32) -> i32
    %23 = "spirv.CL.s_max"(%22, %arg7) : (i32, i32) -> i32
    "func.return"(%23) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi32>, i32) -> i32, sym_name = "cl_reduction_minsi"}> ({
  ^bb0(%arg4: vector<3xi32>, %arg5: i32):
    %12 = "spirv.CompositeExtract"(%arg4) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
    %13 = "spirv.CompositeExtract"(%arg4) <{indices = [1 : i32]}> : (vector<3xi32>) -> i32
    %14 = "spirv.CompositeExtract"(%arg4) <{indices = [2 : i32]}> : (vector<3xi32>) -> i32
    %15 = "spirv.CL.s_min"(%12, %13) : (i32, i32) -> i32
    %16 = "spirv.CL.s_min"(%15, %14) : (i32, i32) -> i32
    %17 = "spirv.CL.s_min"(%16, %arg5) : (i32, i32) -> i32
    "func.return"(%17) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi32>, i32) -> i32, sym_name = "cl_reduction_maxui"}> ({
  ^bb0(%arg2: vector<3xi32>, %arg3: i32):
    %6 = "spirv.CompositeExtract"(%arg2) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
    %7 = "spirv.CompositeExtract"(%arg2) <{indices = [1 : i32]}> : (vector<3xi32>) -> i32
    %8 = "spirv.CompositeExtract"(%arg2) <{indices = [2 : i32]}> : (vector<3xi32>) -> i32
    %9 = "spirv.CL.u_max"(%6, %7) : (i32, i32) -> i32
    %10 = "spirv.CL.u_max"(%9, %8) : (i32, i32) -> i32
    %11 = "spirv.CL.u_max"(%10, %arg3) : (i32, i32) -> i32
    "func.return"(%11) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi32>, i32) -> i32, sym_name = "cl_reduction_minui"}> ({
  ^bb0(%arg0: vector<3xi32>, %arg1: i32):
    %0 = "spirv.CompositeExtract"(%arg0) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
    %1 = "spirv.CompositeExtract"(%arg0) <{indices = [1 : i32]}> : (vector<3xi32>) -> i32
    %2 = "spirv.CompositeExtract"(%arg0) <{indices = [2 : i32]}> : (vector<3xi32>) -> i32
    %3 = "spirv.CL.u_min"(%0, %1) : (i32, i32) -> i32
    %4 = "spirv.CL.u_min"(%3, %2) : (i32, i32) -> i32
    %5 = "spirv.CL.u_min"(%4, %arg1) : (i32, i32) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (vector<4xf32>, vector<2xf32>), sym_name = "broadcast"}> ({
  ^bb0(%arg0: f32):
    %0 = "spirv.CompositeConstruct"(%arg0, %arg0, %arg0, %arg0) : (f32, f32, f32, f32) -> vector<4xf32>
    %1 = "spirv.CompositeConstruct"(%arg0, %arg0) : (f32, f32) -> vector<2xf32>
    "func.return"(%0, %1) : (vector<4xf32>, vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> vector<4xindex>, sym_name = "broadcast_index"}> ({
  ^bb0(%arg0: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> i32
    %1 = "spirv.CompositeConstruct"(%0, %0, %0, %0) : (i32, i32, i32, i32) -> vector<4xi32>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (vector<4xi32>) -> vector<4xindex>
    "func.return"(%2) : (vector<4xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>) -> (vector<1xf32>, f32), sym_name = "extract"}> ({
  ^bb0(%arg0: vector<2xf32>):
    %0 = "spirv.CompositeExtract"(%arg0) <{indices = [0 : i32]}> : (vector<2xf32>) -> f32
    %1 = "builtin.unrealized_conversion_cast"(%0) : (f32) -> vector<1xf32>
    %2 = "spirv.CompositeExtract"(%arg0) <{indices = [1 : i32]}> : (vector<2xf32>) -> f32
    "func.return"(%1, %2) : (vector<1xf32>, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> f32, sym_name = "extract_poison_idx"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "spirv.Undef"() : () -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>) -> f32, sym_name = "extract_size1_vector"}> ({
  ^bb0(%arg0: vector<1xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<1xf32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>, index) -> f32, sym_name = "extract_size1_vector_dynamic"}> ({
  ^bb0(%arg0: vector<1xf32>, %arg1: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<1xf32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>, index) -> f32, sym_name = "extract_dynamic"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i32
    %1 = "spirv.Constant"() <{value = 3 : i32}> : () -> i32
    %2 = "spirv.BitwiseAnd"(%0, %1) : (i32, i32) -> i32
    %3 = "spirv.VectorExtractDynamic"(%arg0, %2) : (vector<4xf32>, i32) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xf32>, index) -> f32, sym_name = "extract_dynamic_non_pow2"}> ({
  ^bb0(%arg0: vector<3xf32>, %arg1: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i32
    %1 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    %2 = "spirv.IEqual"(%0, %1) : (i32, i32) -> i1
    %3 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %4 = "spirv.Select"(%2, %3, %0) : (i1, i32, i32) -> i32
    %5 = "spirv.VectorExtractDynamic"(%arg0, %4) : (vector<3xf32>, i32) -> f32
    "func.return"(%5) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> f32, sym_name = "extract_dynamic_cst"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "spirv.CompositeExtract"(%arg0) <{indices = [1 : i32]}> : (vector<4xf32>) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>) -> f32, sym_name = "to_elements_one_element"}> ({
  ^bb0(%arg2: vector<1xf32>):
    %6 = "builtin.unrealized_conversion_cast"(%arg2) : (vector<1xf32>) -> f32
    "func.return"(%6) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> (f32, f32, f32, f32), sym_name = "to_elements_no_dead_elements"}> ({
  ^bb0(%arg1: vector<4xf32>):
    %2 = "spirv.CompositeExtract"(%arg1) <{indices = [0 : i32]}> : (vector<4xf32>) -> f32
    %3 = "spirv.CompositeExtract"(%arg1) <{indices = [1 : i32]}> : (vector<4xf32>) -> f32
    %4 = "spirv.CompositeExtract"(%arg1) <{indices = [2 : i32]}> : (vector<4xf32>) -> f32
    %5 = "spirv.CompositeExtract"(%arg1) <{indices = [3 : i32]}> : (vector<4xf32>) -> f32
    "func.return"(%2, %3, %4, %5) : (f32, f32, f32, f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> (f32, f32), sym_name = "to_elements_dead_elements"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "spirv.CompositeExtract"(%arg0) <{indices = [1 : i32]}> : (vector<4xf32>) -> f32
    %1 = "spirv.CompositeExtract"(%arg0) <{indices = [3 : i32]}> : (vector<4xf32>) -> f32
    "func.return"(%0, %1) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<f32>, sym_name = "from_elements_0d_f32"}> ({
  ^bb0(%arg7: f32):
    %7 = "builtin.unrealized_conversion_cast"(%arg7) : (f32) -> vector<f32>
    "func.return"(%7) : (vector<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> vector<1xf32>, sym_name = "from_elements_1xf32"}> ({
  ^bb0(%arg6: f32):
    %6 = "builtin.unrealized_conversion_cast"(%arg6) : (f32) -> vector<1xf32>
    "func.return"(%6) : (vector<1xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, f32) -> vector<3xf32>, sym_name = "from_elements_3xf32"}> ({
  ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
    %5 = "spirv.CompositeConstruct"(%arg3, %arg4, %arg5) : (f32, f32, f32) -> vector<3xf32>
    "func.return"(%5) : (vector<3xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8, i8) -> vector<3xi8>, sym_name = "from_elements_3xi8"}> ({
  ^bb0(%arg0: i8, %arg1: i8, %arg2: i8):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (i8) -> i32
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (i8) -> i32
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (i8) -> i32
    %3 = "spirv.CompositeConstruct"(%2, %1, %0) : (i32, i32, i32) -> vector<3xi32>
    %4 = "builtin.unrealized_conversion_cast"(%3) : (vector<3xi32>) -> vector<3xi8>
    "func.return"(%4) : (vector<3xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>, f32) -> vector<4xf32>, sym_name = "insert"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: f32):
    %0 = "spirv.CompositeInsert"(%arg1, %arg0) <{indices = [2 : i32]}> : (f32, vector<4xf32>) -> vector<4xf32>
    "func.return"(%0) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>, f32) -> vector<4xf32>, sym_name = "insert_poison_idx"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: f32):
    %0 = "spirv.Undef"() : () -> vector<4xf32>
    "func.return"(%0) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xindex>, index) -> vector<4xindex>, sym_name = "insert_index_vector"}> ({
  ^bb0(%arg0: vector<4xindex>, %arg1: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<4xindex>) -> vector<4xi32>
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i32
    %2 = "spirv.CompositeInsert"(%1, %0) <{indices = [2 : i32]}> : (i32, vector<4xi32>) -> vector<4xi32>
    %3 = "builtin.unrealized_conversion_cast"(%2) : (vector<4xi32>) -> vector<4xindex>
    "func.return"(%3) : (vector<4xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>, f32) -> vector<1xf32>, sym_name = "insert_size1_vector"}> ({
  ^bb0(%arg0: vector<1xf32>, %arg1: f32):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (f32) -> vector<1xf32>
    "func.return"(%0) : (vector<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>, f32, index) -> vector<1xf32>, sym_name = "insert_size1_vector_dynamic"}> ({
  ^bb0(%arg0: vector<1xf32>, %arg1: f32, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (f32) -> vector<1xf32>
    "func.return"(%0) : (vector<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, vector<4xf32>, index) -> vector<4xf32>, sym_name = "insert_dynamic"}> ({
  ^bb0(%arg0: f32, %arg1: vector<4xf32>, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i32
    %1 = "spirv.Constant"() <{value = 3 : i32}> : () -> i32
    %2 = "spirv.BitwiseAnd"(%0, %1) : (i32, i32) -> i32
    %3 = "spirv.VectorInsertDynamic"(%arg1, %arg0, %2) : (vector<4xf32>, f32, i32) -> vector<4xf32>
    "func.return"(%3) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, vector<3xf32>, index) -> vector<3xf32>, sym_name = "insert_dynamic_non_pow2"}> ({
  ^bb0(%arg0: f32, %arg1: vector<3xf32>, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i32
    %1 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    %2 = "spirv.IEqual"(%0, %1) : (i32, i32) -> i1
    %3 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %4 = "spirv.Select"(%2, %3, %0) : (i1, i32, i32) -> i32
    %5 = "spirv.VectorInsertDynamic"(%arg1, %arg0, %4) : (vector<3xf32>, f32, i32) -> vector<3xf32>
    "func.return"(%5) : (vector<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, vector<4xf32>) -> vector<4xf32>, sym_name = "insert_dynamic_cst"}> ({
  ^bb0(%arg0: f32, %arg1: vector<4xf32>):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "spirv.CompositeInsert"(%arg0, %arg1) <{indices = [2 : i32]}> : (f32, vector<4xf32>) -> vector<4xf32>
    "func.return"(%1) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> (vector<2xf32>, vector<1xf32>), sym_name = "extract_strided_slice"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "spirv.VectorShuffle"(%arg0, %arg0) <{components = [1 : i32, 2 : i32]}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
    %1 = "spirv.CompositeExtract"(%arg0) <{indices = [1 : i32]}> : (vector<4xf32>) -> f32
    %2 = "builtin.unrealized_conversion_cast"(%1) : (f32) -> vector<1xf32>
    "func.return"(%0, %2) : (vector<2xf32>, vector<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, vector<4xf32>) -> vector<4xf32>, sym_name = "insert_strided_slice"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<4xf32>):
    %0 = "spirv.VectorShuffle"(%arg1, %arg0) <{components = [0 : i32, 4 : i32, 5 : i32, 3 : i32]}> : (vector<4xf32>, vector<2xf32>) -> vector<4xf32>
    "func.return"(%0) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>, vector<3xf32>) -> vector<3xf32>, sym_name = "insert_size1_vector"}> ({
  ^bb0(%arg0: vector<1xf32>, %arg1: vector<3xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<1xf32>) -> f32
    %1 = "spirv.CompositeInsert"(%0, %arg1) <{indices = [2 : i32]}> : (f32, vector<3xf32>) -> vector<3xf32>
    "func.return"(%1) : (vector<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>, sym_name = "fma"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xf32>):
    %0 = "spirv.GL.Fma"(%arg0, %arg1, %arg2) : (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"(%0) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>, vector<1xf32>, vector<1xf32>) -> vector<1xf32>, sym_name = "fma_size1_vector"}> ({
  ^bb0(%arg0: vector<1xf32>, %arg1: vector<1xf32>, %arg2: vector<1xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (vector<1xf32>) -> f32
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<1xf32>) -> f32
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<1xf32>) -> f32
    %3 = "spirv.GL.Fma"(%2, %1, %0) : (f32, f32, f32) -> f32
    %4 = "builtin.unrealized_conversion_cast"(%3) : (f32) -> vector<1xf32>
    "func.return"(%4) : (vector<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<4xf32>, sym_name = "splat"}> ({
  ^bb0(%arg0: f32):
    %0 = "spirv.CompositeConstruct"(%arg0, %arg0, %arg0, %arg0) : (f32, f32, f32, f32) -> vector<4xf32>
    "func.return"(%0) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<1xf32>, sym_name = "splat_size1_vector"}> ({
  ^bb0(%arg0: f32):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (f32) -> vector<1xf32>
    "func.return"(%0) : (vector<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>, vector<1xf32>) -> vector<4xf32>, sym_name = "shuffle"}> ({
  ^bb0(%arg0: vector<1xf32>, %arg1: vector<1xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<1xf32>) -> f32
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<1xf32>) -> f32
    %2 = "spirv.CompositeConstruct"(%1, %0, %0, %1) : (f32, f32, f32, f32) -> vector<4xf32>
    "func.return"(%2) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xindex>, vector<1xindex>) -> vector<4xindex>, sym_name = "shuffle_index_vector"}> ({
  ^bb0(%arg0: vector<1xindex>, %arg1: vector<1xindex>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<1xindex>) -> i32
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<1xindex>) -> i32
    %2 = "spirv.CompositeConstruct"(%1, %0, %0, %1) : (i32, i32, i32, i32) -> vector<4xi32>
    %3 = "builtin.unrealized_conversion_cast"(%2) : (vector<4xi32>) -> vector<4xindex>
    "func.return"(%3) : (vector<4xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xf32>, vector<3xf32>) -> vector<4xf32>, sym_name = "shuffle"}> ({
  ^bb0(%arg0: vector<3xf32>, %arg1: vector<3xf32>):
    %0 = "spirv.VectorShuffle"(%arg0, %arg1) <{components = [3 : i32, 2 : i32, 5 : i32, 1 : i32]}> : (vector<3xf32>, vector<3xf32>) -> vector<4xf32>
    "func.return"(%0) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x16xf32>, vector<1x16xf32>) -> vector<3x16xf32>, sym_name = "shuffle"}> ({
  ^bb0(%arg0: vector<2x16xf32>, %arg1: vector<1x16xf32>):
    %0 = "vector.shuffle"(%arg0, %arg1) <{mask = array<i64: 0, 1, 2>}> : (vector<2x16xf32>, vector<1x16xf32>) -> vector<3x16xf32>
    "func.return"(%0) : (vector<3x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xi32>, vector<3xi32>) -> vector<3xi32>, sym_name = "shuffle"}> ({
  ^bb0(%arg0: vector<1xi32>, %arg1: vector<3xi32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<1xi32>) -> i32
    %1 = "spirv.CompositeExtract"(%arg1) <{indices = [1 : i32]}> : (vector<3xi32>) -> i32
    %2 = "spirv.CompositeExtract"(%arg1) <{indices = [2 : i32]}> : (vector<3xi32>) -> i32
    %3 = "spirv.CompositeConstruct"(%0, %1, %2) : (i32, i32, i32) -> vector<3xi32>
    "func.return"(%3) : (vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xi32>, vector<1xi32>) -> vector<3xi32>, sym_name = "shuffle"}> ({
  ^bb0(%arg0: vector<3xi32>, %arg1: vector<1xi32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<1xi32>) -> i32
    %1 = "spirv.CompositeExtract"(%arg0) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
    %2 = "spirv.CompositeExtract"(%arg0) <{indices = [2 : i32]}> : (vector<3xi32>) -> i32
    %3 = "spirv.CompositeConstruct"(%1, %2, %0) : (i32, i32, i32) -> vector<3xi32>
    "func.return"(%3) : (vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xi32>, vector<1xi32>) -> vector<2xi32>, sym_name = "shuffle"}> ({
  ^bb0(%arg0: vector<1xi32>, %arg1: vector<1xi32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<1xi32>) -> i32
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<1xi32>) -> i32
    %2 = "spirv.CompositeConstruct"(%1, %0) : (i32, i32) -> vector<2xi32>
    "func.return"(%2) : (vector<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi32>, vector<4xi32>) -> vector<1xi32>, sym_name = "shuffle"}> ({
  ^bb0(%arg0: vector<4xi32>, %arg1: vector<4xi32>):
    %0 = "spirv.CompositeExtract"(%arg0) <{indices = [0 : i32]}> : (vector<4xi32>) -> i32
    %1 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> vector<1xi32>
    "func.return"(%1) : (vector<1xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi32>, vector<4xi32>) -> vector<1xi32>, sym_name = "shuffle"}> ({
  ^bb0(%arg0: vector<4xi32>, %arg1: vector<4xi32>):
    %0 = "spirv.CompositeExtract"(%arg1) <{indices = [1 : i32]}> : (vector<4xi32>) -> i32
    %1 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> vector<1xi32>
    "func.return"(%1) : (vector<1xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi32>, vector<4xi32>) -> vector<4xi32>, sym_name = "shuffle"}> ({
  ^bb0(%arg0: vector<4xi32>, %arg1: vector<4xi32>):
    %0 = "spirv.VectorShuffle"(%arg0, %arg1) <{components = [1 : i32, -1 : i32, 5 : i32, -1 : i32]}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"(%0) : (vector<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf32>) -> vector<4xf32>, sym_name = "interleave"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<2xf32>):
    %0 = "spirv.VectorShuffle"(%arg0, %arg1) <{components = [0 : i32, 2 : i32, 1 : i32, 3 : i32]}> : (vector<2xf32>, vector<2xf32>) -> vector<4xf32>
    "func.return"(%0) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>, vector<1xf32>) -> vector<2xf32>, sym_name = "interleave_size1"}> ({
  ^bb0(%arg0: vector<1xf32>, %arg1: vector<1xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<1xf32>) -> f32
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<1xf32>) -> f32
    %2 = "spirv.CompositeConstruct"(%1, %0) : (f32, f32) -> vector<2xf32>
    "func.return"(%2) : (vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> (vector<2xf32>, vector<2xf32>), sym_name = "deinterleave"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "spirv.VectorShuffle"(%arg0, %arg0) <{components = [0 : i32, 2 : i32]}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
    %1 = "spirv.VectorShuffle"(%arg0, %arg0) <{components = [1 : i32, 3 : i32]}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
    "func.return"(%0, %1) : (vector<2xf32>, vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>) -> (vector<1xf32>, vector<1xf32>), sym_name = "deinterleave_scalar"}> ({
  ^bb0(%arg0: vector<2xf32>):
    %0 = "spirv.CompositeExtract"(%arg0) <{indices = [0 : i32]}> : (vector<2xf32>) -> f32
    %1 = "builtin.unrealized_conversion_cast"(%0) : (f32) -> vector<1xf32>
    %2 = "spirv.CompositeExtract"(%arg0) <{indices = [1 : i32]}> : (vector<2xf32>) -> f32
    %3 = "builtin.unrealized_conversion_cast"(%2) : (f32) -> vector<1xf32>
    "func.return"(%1, %3) : (vector<1xf32>, vector<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi32>) -> i32, sym_name = "reduction_add"}> ({
  ^bb0(%arg0: vector<4xi32>):
    %0 = "spirv.CompositeExtract"(%arg0) <{indices = [0 : i32]}> : (vector<4xi32>) -> i32
    %1 = "spirv.CompositeExtract"(%arg0) <{indices = [1 : i32]}> : (vector<4xi32>) -> i32
    %2 = "spirv.CompositeExtract"(%arg0) <{indices = [2 : i32]}> : (vector<4xi32>) -> i32
    %3 = "spirv.CompositeExtract"(%arg0) <{indices = [3 : i32]}> : (vector<4xi32>) -> i32
    %4 = "spirv.IAdd"(%0, %1) : (i32, i32) -> i32
    %5 = "spirv.IAdd"(%4, %2) : (i32, i32) -> i32
    %6 = "spirv.IAdd"(%5, %3) : (i32, i32) -> i32
    "func.return"(%6) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>) -> f32, sym_name = "reduction_addf_mulf"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: vector<4xf32>):
    %0 = "arith.mulf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %1 = "spirv.Dot"(%arg0, %arg1) : (vector<4xf32>, vector<4xf32>) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>, f32) -> f32, sym_name = "reduction_addf_acc_mulf"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: f32):
    %0 = "arith.mulf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %1 = "spirv.Dot"(%arg0, %arg1) : (vector<4xf32>, vector<4xf32>) -> f32
    %2 = "spirv.FAdd"(%arg2, %1) : (f32, f32) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> f32, sym_name = "reduction_addf_mulf"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "spirv.Constant"() <{value = dense<1.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %1 = "spirv.Dot"(%arg0, %0) : (vector<4xf32>, vector<4xf32>) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>, f32) -> f32, sym_name = "reduction_addf_acc"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: f32):
    %0 = "spirv.Constant"() <{value = dense<1.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %1 = "spirv.Dot"(%arg0, %0) : (vector<4xf32>, vector<4xf32>) -> f32
    %2 = "spirv.FAdd"(%arg1, %1) : (f32, f32) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>) -> f32, sym_name = "reduction_addf_one_elem"}> ({
  ^bb0(%arg0: vector<1xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<1xf32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>, f32) -> f32, sym_name = "reduction_addf_one_elem_acc"}> ({
  ^bb0(%arg0: vector<1xf32>, %arg1: f32):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<1xf32>) -> f32
    %1 = "spirv.FAdd"(%arg1, %0) : (f32, f32) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xf32>, f32) -> f32, sym_name = "reduction_mul"}> ({
  ^bb0(%arg0: vector<3xf32>, %arg1: f32):
    %0 = "spirv.CompositeExtract"(%arg0) <{indices = [0 : i32]}> : (vector<3xf32>) -> f32
    %1 = "spirv.CompositeExtract"(%arg0) <{indices = [1 : i32]}> : (vector<3xf32>) -> f32
    %2 = "spirv.CompositeExtract"(%arg0) <{indices = [2 : i32]}> : (vector<3xf32>) -> f32
    %3 = "spirv.FMul"(%0, %1) : (f32, f32) -> f32
    %4 = "spirv.FMul"(%3, %2) : (f32, f32) -> f32
    %5 = "spirv.FMul"(%4, %arg1) : (f32, f32) -> f32
    "func.return"(%5) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xf32>, f32) -> f32, sym_name = "reduction_maximumf"}> ({
  ^bb0(%arg0: vector<3xf32>, %arg1: f32):
    %0 = "spirv.CompositeExtract"(%arg0) <{indices = [0 : i32]}> : (vector<3xf32>) -> f32
    %1 = "spirv.CompositeExtract"(%arg0) <{indices = [1 : i32]}> : (vector<3xf32>) -> f32
    %2 = "spirv.CompositeExtract"(%arg0) <{indices = [2 : i32]}> : (vector<3xf32>) -> f32
    %3 = "spirv.GL.FMax"(%0, %1) : (f32, f32) -> f32
    %4 = "spirv.GL.FMax"(%3, %2) : (f32, f32) -> f32
    %5 = "spirv.GL.FMax"(%4, %arg1) : (f32, f32) -> f32
    "func.return"(%5) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xf32>, f32) -> f32, sym_name = "reduction_minimumf"}> ({
  ^bb0(%arg0: vector<3xf32>, %arg1: f32):
    %0 = "spirv.CompositeExtract"(%arg0) <{indices = [0 : i32]}> : (vector<3xf32>) -> f32
    %1 = "spirv.CompositeExtract"(%arg0) <{indices = [1 : i32]}> : (vector<3xf32>) -> f32
    %2 = "spirv.CompositeExtract"(%arg0) <{indices = [2 : i32]}> : (vector<3xf32>) -> f32
    %3 = "spirv.GL.FMin"(%0, %1) : (f32, f32) -> f32
    %4 = "spirv.GL.FMin"(%3, %2) : (f32, f32) -> f32
    %5 = "spirv.GL.FMin"(%4, %arg1) : (f32, f32) -> f32
    "func.return"(%5) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xi32>, i32) -> i32, sym_name = "reduction_maxsi"}> ({
  ^bb0(%arg0: vector<3xi32>, %arg1: i32):
    %0 = "spirv.CompositeExtract"(%arg0) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
    %1 = "spirv.CompositeExtract"(%arg0) <{indices = [1 : i32]}> : (vector<3xi32>) -> i32
    %2 = "spirv.CompositeExtract"(%arg0) <{indices = [2 : i32]}> : (vector<3xi32>) -> i32
    %3 = "spirv.GL.SMax"(%0, %1) : (i32, i32) -> i32
    %4 = "spirv.GL.SMax"(%3, %2) : (i32, i32) -> i32
    %5 = "spirv.GL.SMax"(%4, %arg1) : (i32, i32) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xi32>, i32) -> i32, sym_name = "reduction_minsi"}> ({
  ^bb0(%arg0: vector<3xi32>, %arg1: i32):
    %0 = "spirv.CompositeExtract"(%arg0) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
    %1 = "spirv.CompositeExtract"(%arg0) <{indices = [1 : i32]}> : (vector<3xi32>) -> i32
    %2 = "spirv.CompositeExtract"(%arg0) <{indices = [2 : i32]}> : (vector<3xi32>) -> i32
    %3 = "spirv.GL.SMin"(%0, %1) : (i32, i32) -> i32
    %4 = "spirv.GL.SMin"(%3, %2) : (i32, i32) -> i32
    %5 = "spirv.GL.SMin"(%4, %arg1) : (i32, i32) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xi32>, i32) -> i32, sym_name = "reduction_maxui"}> ({
  ^bb0(%arg0: vector<3xi32>, %arg1: i32):
    %0 = "spirv.CompositeExtract"(%arg0) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
    %1 = "spirv.CompositeExtract"(%arg0) <{indices = [1 : i32]}> : (vector<3xi32>) -> i32
    %2 = "spirv.CompositeExtract"(%arg0) <{indices = [2 : i32]}> : (vector<3xi32>) -> i32
    %3 = "spirv.GL.UMax"(%0, %1) : (i32, i32) -> i32
    %4 = "spirv.GL.UMax"(%3, %2) : (i32, i32) -> i32
    %5 = "spirv.GL.UMax"(%4, %arg1) : (i32, i32) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xi32>, i32) -> i32, sym_name = "reduction_minui"}> ({
  ^bb0(%arg0: vector<3xi32>, %arg1: i32):
    %0 = "spirv.CompositeExtract"(%arg0) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
    %1 = "spirv.CompositeExtract"(%arg0) <{indices = [1 : i32]}> : (vector<3xi32>) -> i32
    %2 = "spirv.CompositeExtract"(%arg0) <{indices = [2 : i32]}> : (vector<3xi32>) -> i32
    %3 = "spirv.GL.UMin"(%0, %1) : (i32, i32) -> i32
    %4 = "spirv.GL.UMin"(%3, %2) : (i32, i32) -> i32
    %5 = "spirv.GL.UMin"(%4, %arg1) : (i32, i32) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xbf16>, vector<4xbf16>) -> bf16, sym_name = "reduction_bf16_addf_mulf"}> ({
  ^bb0(%arg0: vector<4xbf16>, %arg1: vector<4xbf16>):
    %0 = "arith.mulf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (vector<4xbf16>, vector<4xbf16>) -> vector<4xbf16>
    %1 = "spirv.Dot"(%arg0, %arg1) : (vector<4xbf16>, vector<4xbf16>) -> bf16
    "func.return"(%1) : (bf16) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [BFloat16DotProductKHR], [SPV_KHR_bfloat16]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>) -> vector<2xf32>, sym_name = "shape_cast_same_type"}> ({
  ^bb0(%arg0: vector<2xf32>):
    "func.return"(%arg0) : (vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>) -> vector<1xf32>, sym_name = "shape_cast_size1_vector"}> ({
  ^bb0(%arg0: vector<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<f32>) -> f32
    %1 = "builtin.unrealized_conversion_cast"(%0) : (f32) -> vector<1xf32>
    "func.return"(%1) : (vector<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<4xindex>, sym_name = "step"}> ({
    %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %1 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %2 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    %3 = "spirv.Constant"() <{value = 3 : i32}> : () -> i32
    %4 = "spirv.CompositeConstruct"(%0, %1, %2, %3) : (i32, i32, i32, i32) -> vector<4xi32>
    %5 = "builtin.unrealized_conversion_cast"(%4) : (vector<4xi32>) -> vector<4xindex>
    "func.return"(%5) : (vector<4xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<1xindex>, sym_name = "step_size1"}> ({
    %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %1 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> vector<1xindex>
    "func.return"(%1) : (vector<1xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4xf32, #spirv.storage_class<StorageBuffer>>) -> vector<4xf32>, sym_name = "vector_load"}> ({
  ^bb0(%arg11: memref<4xf32, #spirv.storage_class<StorageBuffer>>):
    %70 = "builtin.unrealized_conversion_cast"(%arg11) : (memref<4xf32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, StorageBuffer>
    %71 = "arith.constant"() <{value = 0 : index}> : () -> index
    %72 = "builtin.unrealized_conversion_cast"(%71) : (index) -> i32
    %73 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %74 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %75 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %76 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %77 = "spirv.AccessChain"(%70, %74, %72) : (!spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    %78 = "spirv.Bitcast"(%77) : (!spirv.ptr<f32, StorageBuffer>) -> !spirv.ptr<vector<4xf32>, StorageBuffer>
    %79 = "spirv.Load"(%78) : (!spirv.ptr<vector<4xf32>, StorageBuffer>) -> vector<4xf32>
    "func.return"(%79) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xf32, #spirv.storage_class<StorageBuffer>>) -> vector<1xf32>, sym_name = "vector_load_single_elem"}> ({
  ^bb0(%arg10: memref<4xf32, #spirv.storage_class<StorageBuffer>>):
    %60 = "builtin.unrealized_conversion_cast"(%arg10) : (memref<4xf32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, StorageBuffer>
    %61 = "arith.constant"() <{value = 0 : index}> : () -> index
    %62 = "builtin.unrealized_conversion_cast"(%61) : (index) -> i32
    %63 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %64 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %65 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %66 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %67 = "spirv.AccessChain"(%60, %64, %62) : (!spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    %68 = "spirv.Load"(%67) : (!spirv.ptr<f32, StorageBuffer>) -> f32
    %69 = "builtin.unrealized_conversion_cast"(%68) : (f32) -> vector<1xf32>
    "func.return"(%69) : (vector<1xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xf32, #spirv.storage_class<StorageBuffer>>) -> vector<4xf32>, sym_name = "vector_load_aligned"}> ({
  ^bb0(%arg9: memref<4xf32, #spirv.storage_class<StorageBuffer>>):
    %51 = "builtin.unrealized_conversion_cast"(%arg9) : (memref<4xf32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, StorageBuffer>
    %52 = "arith.constant"() <{value = 0 : index}> : () -> index
    %53 = "builtin.unrealized_conversion_cast"(%52) : (index) -> i32
    %54 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %55 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %56 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %57 = "spirv.AccessChain"(%51, %54, %53) : (!spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    %58 = "spirv.Bitcast"(%57) : (!spirv.ptr<f32, StorageBuffer>) -> !spirv.ptr<vector<4xf32>, StorageBuffer>
    %59 = "spirv.Load"(%58) <{alignment = 8 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<vector<4xf32>, StorageBuffer>) -> vector<4xf32>
    "func.return"(%59) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4x4xf32, #spirv.storage_class<StorageBuffer>>) -> vector<4xf32>, sym_name = "vector_load_2d"}> ({
  ^bb0(%arg8: memref<4x4xf32, #spirv.storage_class<StorageBuffer>>):
    %37 = "builtin.unrealized_conversion_cast"(%arg8) : (memref<4x4xf32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<16 x f32, stride=4> [0])>, StorageBuffer>
    %38 = "arith.constant"() <{value = 0 : index}> : () -> index
    %39 = "builtin.unrealized_conversion_cast"(%38) : (index) -> i32
    %40 = "arith.constant"() <{value = 1 : index}> : () -> index
    %41 = "builtin.unrealized_conversion_cast"(%40) : (index) -> i32
    %42 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %43 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %44 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %45 = "spirv.IMul"(%39, %44) : (i32, i32) -> i32
    %46 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %47 = "spirv.IAdd"(%41, %45) : (i32, i32) -> i32
    %48 = "spirv.AccessChain"(%37, %42, %47) : (!spirv.ptr<!spirv.struct<(!spirv.array<16 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    %49 = "spirv.Bitcast"(%48) : (!spirv.ptr<f32, StorageBuffer>) -> !spirv.ptr<vector<4xf32>, StorageBuffer>
    %50 = "spirv.Load"(%49) : (!spirv.ptr<vector<4xf32>, StorageBuffer>) -> vector<4xf32>
    "func.return"(%50) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xf32, #spirv.storage_class<StorageBuffer>>, vector<4xf32>) -> (), sym_name = "vector_store"}> ({
  ^bb0(%arg6: memref<4xf32, #spirv.storage_class<StorageBuffer>>, %arg7: vector<4xf32>):
    %29 = "builtin.unrealized_conversion_cast"(%arg6) : (memref<4xf32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, StorageBuffer>
    %30 = "arith.constant"() <{value = 0 : index}> : () -> index
    %31 = "builtin.unrealized_conversion_cast"(%30) : (index) -> i32
    %32 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %33 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %34 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %35 = "spirv.AccessChain"(%29, %32, %31) : (!spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    %36 = "spirv.Bitcast"(%35) : (!spirv.ptr<f32, StorageBuffer>) -> !spirv.ptr<vector<4xf32>, StorageBuffer>
    "spirv.Store"(%36, %arg7) : (!spirv.ptr<vector<4xf32>, StorageBuffer>, vector<4xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xf32, #spirv.storage_class<StorageBuffer>>, vector<4xf32>) -> (), sym_name = "vector_store_aligned"}> ({
  ^bb0(%arg4: memref<4xf32, #spirv.storage_class<StorageBuffer>>, %arg5: vector<4xf32>):
    %21 = "builtin.unrealized_conversion_cast"(%arg4) : (memref<4xf32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, StorageBuffer>
    %22 = "arith.constant"() <{value = 0 : index}> : () -> index
    %23 = "builtin.unrealized_conversion_cast"(%22) : (index) -> i32
    %24 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %25 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %26 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %27 = "spirv.AccessChain"(%21, %24, %23) : (!spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    %28 = "spirv.Bitcast"(%27) : (!spirv.ptr<f32, StorageBuffer>) -> !spirv.ptr<vector<4xf32>, StorageBuffer>
    "spirv.Store"(%28, %arg5) <{alignment = 8 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<vector<4xf32>, StorageBuffer>, vector<4xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xf32, #spirv.storage_class<StorageBuffer>>, vector<1xf32>) -> (), sym_name = "vector_store_single_elem"}> ({
  ^bb0(%arg2: memref<4xf32, #spirv.storage_class<StorageBuffer>>, %arg3: vector<1xf32>):
    %13 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<4xf32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, StorageBuffer>
    %14 = "builtin.unrealized_conversion_cast"(%arg3) : (vector<1xf32>) -> f32
    %15 = "arith.constant"() <{value = 0 : index}> : () -> index
    %16 = "builtin.unrealized_conversion_cast"(%15) : (index) -> i32
    %17 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %18 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %19 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %20 = "spirv.AccessChain"(%13, %17, %16) : (!spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    "spirv.Store"(%20, %14) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4x4xf32, #spirv.storage_class<StorageBuffer>>, vector<4xf32>) -> (), sym_name = "vector_store_2d"}> ({
  ^bb0(%arg0: memref<4x4xf32, #spirv.storage_class<StorageBuffer>>, %arg1: vector<4xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<4x4xf32, #spirv.storage_class<StorageBuffer>>) -> !spirv.ptr<!spirv.struct<(!spirv.array<16 x f32, stride=4> [0])>, StorageBuffer>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i32
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "builtin.unrealized_conversion_cast"(%3) : (index) -> i32
    %5 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %6 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %7 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %8 = "spirv.IMul"(%2, %7) : (i32, i32) -> i32
    %9 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %10 = "spirv.IAdd"(%4, %8) : (i32, i32) -> i32
    %11 = "spirv.AccessChain"(%0, %5, %10) : (!spirv.ptr<!spirv.struct<(!spirv.array<16 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    %12 = "spirv.Bitcast"(%11) : (!spirv.ptr<f32, StorageBuffer>) -> !spirv.ptr<vector<4xf32>, StorageBuffer>
    "spirv.Store"(%12, %arg1) : (!spirv.ptr<vector<4xf32>, StorageBuffer>, vector<4xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4xf32, #spirv.storage_class<StorageBuffer>>) -> vector<4xf32>, sym_name = "vector_load"}> ({
  ^bb0(%arg0: memref<4xf32, #spirv.storage_class<StorageBuffer>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.load"(%arg0, %0) : (memref<4xf32, #spirv.storage_class<StorageBuffer>>, index) -> vector<4xf32>
    "func.return"(%1) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

