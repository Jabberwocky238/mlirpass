"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf16>) -> (vector<4xf16>, vector<1xf32>), sym_name = "bitcast"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<2xf16>):
    %0 = "vector.bitcast"(%arg0) : (vector<2xf32>) -> vector<4xf16>
    %1 = "vector.bitcast"(%arg1) : (vector<2xf16>) -> vector<1xf32>
    "func.return"(%0, %1) : (vector<4xf16>, vector<1xf32>) -> ()
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
    %7 = "vector.fma"(%arg15, %arg16, %arg17) : (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"(%7) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf32>, vector<1xf32>, vector<1xf32>) -> vector<1xf32>, sym_name = "cl_fma_size1_vector"}> ({
  ^bb0(%arg12: vector<1xf32>, %arg13: vector<1xf32>, %arg14: vector<1xf32>):
    %6 = "vector.fma"(%arg12, %arg13, %arg14) : (vector<1xf32>, vector<1xf32>, vector<1xf32>) -> vector<1xf32>
    "func.return"(%6) : (vector<1xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf32>, f32) -> f32, sym_name = "cl_reduction_maximumf"}> ({
  ^bb0(%arg10: vector<3xf32>, %arg11: f32):
    %5 = "vector.reduction"(%arg10, %arg11) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<maximumf>}> : (vector<3xf32>, f32) -> f32
    "func.return"(%5) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf32>, f32) -> f32, sym_name = "cl_reduction_minimumf"}> ({
  ^bb0(%arg8: vector<3xf32>, %arg9: f32):
    %4 = "vector.reduction"(%arg8, %arg9) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<minimumf>}> : (vector<3xf32>, f32) -> f32
    "func.return"(%4) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi32>, i32) -> i32, sym_name = "cl_reduction_maxsi"}> ({
  ^bb0(%arg6: vector<3xi32>, %arg7: i32):
    %3 = "vector.reduction"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<maxsi>}> : (vector<3xi32>, i32) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi32>, i32) -> i32, sym_name = "cl_reduction_minsi"}> ({
  ^bb0(%arg4: vector<3xi32>, %arg5: i32):
    %2 = "vector.reduction"(%arg4, %arg5) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<minsi>}> : (vector<3xi32>, i32) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi32>, i32) -> i32, sym_name = "cl_reduction_maxui"}> ({
  ^bb0(%arg2: vector<3xi32>, %arg3: i32):
    %1 = "vector.reduction"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<maxui>}> : (vector<3xi32>, i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi32>, i32) -> i32, sym_name = "cl_reduction_minui"}> ({
  ^bb0(%arg0: vector<3xi32>, %arg1: i32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<minui>}> : (vector<3xi32>, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (vector<4xf32>, vector<2xf32>), sym_name = "broadcast"}> ({
  ^bb0(%arg0: f32):
    %0 = "vector.broadcast"(%arg0) : (f32) -> vector<4xf32>
    %1 = "vector.broadcast"(%arg0) : (f32) -> vector<2xf32>
    "func.return"(%0, %1) : (vector<4xf32>, vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> vector<4xindex>, sym_name = "broadcast_index"}> ({
  ^bb0(%arg0: index):
    %0 = "vector.broadcast"(%arg0) : (index) -> vector<4xindex>
    "func.return"(%0) : (vector<4xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>) -> (vector<1xf32>, f32), sym_name = "extract"}> ({
  ^bb0(%arg0: vector<2xf32>):
    %0 = "vector.extract"(%arg0) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> vector<1xf32>
    %1 = "vector.extract"(%arg0) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
    "func.return"(%0, %1) : (vector<1xf32>, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> f32, sym_name = "extract_poison_idx"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "vector.extract"(%arg0) <{static_position = array<i64: -1>}> : (vector<4xf32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>) -> f32, sym_name = "extract_size1_vector"}> ({
  ^bb0(%arg0: vector<1xf32>):
    %0 = "vector.extract"(%arg0) <{static_position = array<i64: 0>}> : (vector<1xf32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>, index) -> f32, sym_name = "extract_size1_vector_dynamic"}> ({
  ^bb0(%arg0: vector<1xf32>, %arg1: index):
    %0 = "vector.extract"(%arg0, %arg1) <{static_position = array<i64: -9223372036854775808>}> : (vector<1xf32>, index) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>, index) -> f32, sym_name = "extract_dynamic"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: index):
    %0 = "vector.extract"(%arg0, %arg1) <{static_position = array<i64: -9223372036854775808>}> : (vector<4xf32>, index) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xf32>, index) -> f32, sym_name = "extract_dynamic_non_pow2"}> ({
  ^bb0(%arg0: vector<3xf32>, %arg1: index):
    %0 = "vector.extract"(%arg0, %arg1) <{static_position = array<i64: -9223372036854775808>}> : (vector<3xf32>, index) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> f32, sym_name = "extract_dynamic_cst"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "vector.extract"(%arg0, %0) <{static_position = array<i64: -9223372036854775808>}> : (vector<4xf32>, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>) -> f32, sym_name = "to_elements_one_element"}> ({
  ^bb0(%arg2: vector<1xf32>):
    %2 = "vector.to_elements"(%arg2) : (vector<1xf32>) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> (f32, f32, f32, f32), sym_name = "to_elements_no_dead_elements"}> ({
  ^bb0(%arg1: vector<4xf32>):
    %1:4 = "vector.to_elements"(%arg1) : (vector<4xf32>) -> (f32, f32, f32, f32)
    "func.return"(%1#0, %1#1, %1#2, %1#3) : (f32, f32, f32, f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> (f32, f32), sym_name = "to_elements_dead_elements"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0:4 = "vector.to_elements"(%arg0) : (vector<4xf32>) -> (f32, f32, f32, f32)
    "func.return"(%0#1, %0#3) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<f32>, sym_name = "from_elements_0d_f32"}> ({
  ^bb0(%arg7: f32):
    %3 = "vector.from_elements"(%arg7) : (f32) -> vector<f32>
    "func.return"(%3) : (vector<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> vector<1xf32>, sym_name = "from_elements_1xf32"}> ({
  ^bb0(%arg6: f32):
    %2 = "vector.from_elements"(%arg6) : (f32) -> vector<1xf32>
    "func.return"(%2) : (vector<1xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, f32) -> vector<3xf32>, sym_name = "from_elements_3xf32"}> ({
  ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
    %1 = "vector.from_elements"(%arg3, %arg4, %arg5) : (f32, f32, f32) -> vector<3xf32>
    "func.return"(%1) : (vector<3xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8, i8) -> vector<3xi8>, sym_name = "from_elements_3xi8"}> ({
  ^bb0(%arg0: i8, %arg1: i8, %arg2: i8):
    %0 = "vector.from_elements"(%arg0, %arg1, %arg2) : (i8, i8, i8) -> vector<3xi8>
    "func.return"(%0) : (vector<3xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>, f32) -> vector<4xf32>, sym_name = "insert"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: f32):
    %0 = "vector.insert"(%arg1, %arg0) <{static_position = array<i64: 2>}> : (f32, vector<4xf32>) -> vector<4xf32>
    "func.return"(%0) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>, f32) -> vector<4xf32>, sym_name = "insert_poison_idx"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: f32):
    %0 = "vector.insert"(%arg1, %arg0) <{static_position = array<i64: -1>}> : (f32, vector<4xf32>) -> vector<4xf32>
    "func.return"(%0) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xindex>, index) -> vector<4xindex>, sym_name = "insert_index_vector"}> ({
  ^bb0(%arg0: vector<4xindex>, %arg1: index):
    %0 = "vector.insert"(%arg1, %arg0) <{static_position = array<i64: 2>}> : (index, vector<4xindex>) -> vector<4xindex>
    "func.return"(%0) : (vector<4xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>, f32) -> vector<1xf32>, sym_name = "insert_size1_vector"}> ({
  ^bb0(%arg0: vector<1xf32>, %arg1: f32):
    %0 = "vector.insert"(%arg1, %arg0) <{static_position = array<i64: 0>}> : (f32, vector<1xf32>) -> vector<1xf32>
    "func.return"(%0) : (vector<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>, f32, index) -> vector<1xf32>, sym_name = "insert_size1_vector_dynamic"}> ({
  ^bb0(%arg0: vector<1xf32>, %arg1: f32, %arg2: index):
    %0 = "vector.insert"(%arg1, %arg0, %arg2) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<1xf32>, index) -> vector<1xf32>
    "func.return"(%0) : (vector<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, vector<4xf32>, index) -> vector<4xf32>, sym_name = "insert_dynamic"}> ({
  ^bb0(%arg0: f32, %arg1: vector<4xf32>, %arg2: index):
    %0 = "vector.insert"(%arg0, %arg1, %arg2) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<4xf32>, index) -> vector<4xf32>
    "func.return"(%0) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, vector<3xf32>, index) -> vector<3xf32>, sym_name = "insert_dynamic_non_pow2"}> ({
  ^bb0(%arg0: f32, %arg1: vector<3xf32>, %arg2: index):
    %0 = "vector.insert"(%arg0, %arg1, %arg2) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<3xf32>, index) -> vector<3xf32>
    "func.return"(%0) : (vector<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, vector<4xf32>) -> vector<4xf32>, sym_name = "insert_dynamic_cst"}> ({
  ^bb0(%arg0: f32, %arg1: vector<4xf32>):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "vector.insert"(%arg0, %arg1, %0) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<4xf32>, index) -> vector<4xf32>
    "func.return"(%1) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> (vector<2xf32>, vector<1xf32>), sym_name = "extract_strided_slice"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "vector.extract_strided_slice"(%arg0) <{offsets = [1], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %1 = "vector.extract_strided_slice"(%arg0) <{offsets = [1], sizes = [1], strides = [1]}> : (vector<4xf32>) -> vector<1xf32>
    "func.return"(%0, %1) : (vector<2xf32>, vector<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, vector<4xf32>) -> vector<4xf32>, sym_name = "insert_strided_slice"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<4xf32>):
    %0 = "vector.insert_strided_slice"(%arg0, %arg1) <{offsets = [1], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"(%0) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>, vector<3xf32>) -> vector<3xf32>, sym_name = "insert_size1_vector"}> ({
  ^bb0(%arg0: vector<1xf32>, %arg1: vector<3xf32>):
    %0 = "vector.insert_strided_slice"(%arg0, %arg1) <{offsets = [2], strides = [1]}> : (vector<1xf32>, vector<3xf32>) -> vector<3xf32>
    "func.return"(%0) : (vector<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>, sym_name = "fma"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xf32>):
    %0 = "vector.fma"(%arg0, %arg1, %arg2) : (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"(%0) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>, vector<1xf32>, vector<1xf32>) -> vector<1xf32>, sym_name = "fma_size1_vector"}> ({
  ^bb0(%arg0: vector<1xf32>, %arg1: vector<1xf32>, %arg2: vector<1xf32>):
    %0 = "vector.fma"(%arg0, %arg1, %arg2) : (vector<1xf32>, vector<1xf32>, vector<1xf32>) -> vector<1xf32>
    "func.return"(%0) : (vector<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<4xf32>, sym_name = "splat"}> ({
  ^bb0(%arg0: f32):
    %0 = "vector.broadcast"(%arg0) : (f32) -> vector<4xf32>
    "func.return"(%0) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<1xf32>, sym_name = "splat_size1_vector"}> ({
  ^bb0(%arg0: f32):
    %0 = "vector.broadcast"(%arg0) : (f32) -> vector<1xf32>
    "func.return"(%0) : (vector<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>, vector<1xf32>) -> vector<4xf32>, sym_name = "shuffle"}> ({
  ^bb0(%arg0: vector<1xf32>, %arg1: vector<1xf32>):
    %0 = "vector.shuffle"(%arg0, %arg1) <{mask = array<i64: 0, 1, 1, 0>}> : (vector<1xf32>, vector<1xf32>) -> vector<4xf32>
    "func.return"(%0) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xindex>, vector<1xindex>) -> vector<4xindex>, sym_name = "shuffle_index_vector"}> ({
  ^bb0(%arg0: vector<1xindex>, %arg1: vector<1xindex>):
    %0 = "vector.shuffle"(%arg0, %arg1) <{mask = array<i64: 0, 1, 1, 0>}> : (vector<1xindex>, vector<1xindex>) -> vector<4xindex>
    "func.return"(%0) : (vector<4xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xf32>, vector<3xf32>) -> vector<4xf32>, sym_name = "shuffle"}> ({
  ^bb0(%arg0: vector<3xf32>, %arg1: vector<3xf32>):
    %0 = "vector.shuffle"(%arg0, %arg1) <{mask = array<i64: 3, 2, 5, 1>}> : (vector<3xf32>, vector<3xf32>) -> vector<4xf32>
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
    %0 = "vector.shuffle"(%arg0, %arg1) <{mask = array<i64: 0, 2, 3>}> : (vector<1xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%0) : (vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xi32>, vector<1xi32>) -> vector<3xi32>, sym_name = "shuffle"}> ({
  ^bb0(%arg0: vector<3xi32>, %arg1: vector<1xi32>):
    %0 = "vector.shuffle"(%arg0, %arg1) <{mask = array<i64: 0, 2, 3>}> : (vector<3xi32>, vector<1xi32>) -> vector<3xi32>
    "func.return"(%0) : (vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xi32>, vector<1xi32>) -> vector<2xi32>, sym_name = "shuffle"}> ({
  ^bb0(%arg0: vector<1xi32>, %arg1: vector<1xi32>):
    %0 = "vector.shuffle"(%arg0, %arg1) <{mask = array<i64: 0, 1>}> : (vector<1xi32>, vector<1xi32>) -> vector<2xi32>
    "func.return"(%0) : (vector<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi32>, vector<4xi32>) -> vector<1xi32>, sym_name = "shuffle"}> ({
  ^bb0(%arg0: vector<4xi32>, %arg1: vector<4xi32>):
    %0 = "vector.shuffle"(%arg0, %arg1) <{mask = array<i64: 0>}> : (vector<4xi32>, vector<4xi32>) -> vector<1xi32>
    "func.return"(%0) : (vector<1xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi32>, vector<4xi32>) -> vector<1xi32>, sym_name = "shuffle"}> ({
  ^bb0(%arg0: vector<4xi32>, %arg1: vector<4xi32>):
    %0 = "vector.shuffle"(%arg0, %arg1) <{mask = array<i64: 5>}> : (vector<4xi32>, vector<4xi32>) -> vector<1xi32>
    "func.return"(%0) : (vector<1xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi32>, vector<4xi32>) -> vector<4xi32>, sym_name = "shuffle"}> ({
  ^bb0(%arg0: vector<4xi32>, %arg1: vector<4xi32>):
    %0 = "vector.shuffle"(%arg0, %arg1) <{mask = array<i64: 1, -1, 5, -1>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"(%0) : (vector<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf32>) -> vector<4xf32>, sym_name = "interleave"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<2xf32>):
    %0 = "vector.interleave"(%arg0, %arg1) : (vector<2xf32>, vector<2xf32>) -> vector<4xf32>
    "func.return"(%0) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>, vector<1xf32>) -> vector<2xf32>, sym_name = "interleave_size1"}> ({
  ^bb0(%arg0: vector<1xf32>, %arg1: vector<1xf32>):
    %0 = "vector.interleave"(%arg0, %arg1) : (vector<1xf32>, vector<1xf32>) -> vector<2xf32>
    "func.return"(%0) : (vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> (vector<2xf32>, vector<2xf32>), sym_name = "deinterleave"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0:2 = "vector.deinterleave"(%arg0) : (vector<4xf32>) -> (vector<2xf32>, vector<2xf32>)
    "func.return"(%0#0, %0#1) : (vector<2xf32>, vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>) -> (vector<1xf32>, vector<1xf32>), sym_name = "deinterleave_scalar"}> ({
  ^bb0(%arg0: vector<2xf32>):
    %0:2 = "vector.deinterleave"(%arg0) : (vector<2xf32>) -> (vector<1xf32>, vector<1xf32>)
    "func.return"(%0#0, %0#1) : (vector<1xf32>, vector<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi32>) -> i32, sym_name = "reduction_add"}> ({
  ^bb0(%arg0: vector<4xi32>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<4xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>) -> f32, sym_name = "reduction_addf_mulf"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: vector<4xf32>):
    %0 = "arith.mulf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %1 = "vector.reduction"(%0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<4xf32>) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>, f32) -> f32, sym_name = "reduction_addf_acc_mulf"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: f32):
    %0 = "arith.mulf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %1 = "vector.reduction"(%0, %arg2) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<4xf32>, f32) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> f32, sym_name = "reduction_addf_mulf"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<4xf32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>, f32) -> f32, sym_name = "reduction_addf_acc"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: f32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<4xf32>, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>) -> f32, sym_name = "reduction_addf_one_elem"}> ({
  ^bb0(%arg0: vector<1xf32>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<1xf32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>, f32) -> f32, sym_name = "reduction_addf_one_elem_acc"}> ({
  ^bb0(%arg0: vector<1xf32>, %arg1: f32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<1xf32>, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xf32>, f32) -> f32, sym_name = "reduction_mul"}> ({
  ^bb0(%arg0: vector<3xf32>, %arg1: f32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<mul>}> : (vector<3xf32>, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xf32>, f32) -> f32, sym_name = "reduction_maximumf"}> ({
  ^bb0(%arg0: vector<3xf32>, %arg1: f32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<maximumf>}> : (vector<3xf32>, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xf32>, f32) -> f32, sym_name = "reduction_minimumf"}> ({
  ^bb0(%arg0: vector<3xf32>, %arg1: f32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<minimumf>}> : (vector<3xf32>, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xi32>, i32) -> i32, sym_name = "reduction_maxsi"}> ({
  ^bb0(%arg0: vector<3xi32>, %arg1: i32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<maxsi>}> : (vector<3xi32>, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xi32>, i32) -> i32, sym_name = "reduction_minsi"}> ({
  ^bb0(%arg0: vector<3xi32>, %arg1: i32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<minsi>}> : (vector<3xi32>, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xi32>, i32) -> i32, sym_name = "reduction_maxui"}> ({
  ^bb0(%arg0: vector<3xi32>, %arg1: i32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<maxui>}> : (vector<3xi32>, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xi32>, i32) -> i32, sym_name = "reduction_minui"}> ({
  ^bb0(%arg0: vector<3xi32>, %arg1: i32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<minui>}> : (vector<3xi32>, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xbf16>, vector<4xbf16>) -> bf16, sym_name = "reduction_bf16_addf_mulf"}> ({
  ^bb0(%arg0: vector<4xbf16>, %arg1: vector<4xbf16>):
    %0 = "arith.mulf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (vector<4xbf16>, vector<4xbf16>) -> vector<4xbf16>
    %1 = "vector.reduction"(%0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<4xbf16>) -> bf16
    "func.return"(%1) : (bf16) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [BFloat16DotProductKHR], [SPV_KHR_bfloat16]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>) -> vector<2xf32>, sym_name = "shape_cast_same_type"}> ({
  ^bb0(%arg0: vector<2xf32>):
    %0 = "vector.shape_cast"(%arg0) : (vector<2xf32>) -> vector<2xf32>
    "func.return"(%arg0) : (vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>) -> vector<1xf32>, sym_name = "shape_cast_size1_vector"}> ({
  ^bb0(%arg0: vector<f32>):
    %0 = "vector.shape_cast"(%arg0) : (vector<f32>) -> vector<1xf32>
    "func.return"(%0) : (vector<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<4xindex>, sym_name = "step"}> ({
    %0 = "vector.step"() : () -> vector<4xindex>
    "func.return"(%0) : (vector<4xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<1xindex>, sym_name = "step_size1"}> ({
    %0 = "vector.step"() : () -> vector<1xindex>
    "func.return"(%0) : (vector<1xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4xf32, #spirv.storage_class<StorageBuffer>>) -> vector<4xf32>, sym_name = "vector_load"}> ({
  ^bb0(%arg11: memref<4xf32, #spirv.storage_class<StorageBuffer>>):
    %13 = "arith.constant"() <{value = 0 : index}> : () -> index
    %14 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %15 = "vector.load"(%arg11, %13) : (memref<4xf32, #spirv.storage_class<StorageBuffer>>, index) -> vector<4xf32>
    "func.return"(%15) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xf32, #spirv.storage_class<StorageBuffer>>) -> vector<1xf32>, sym_name = "vector_load_single_elem"}> ({
  ^bb0(%arg10: memref<4xf32, #spirv.storage_class<StorageBuffer>>):
    %10 = "arith.constant"() <{value = 0 : index}> : () -> index
    %11 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %12 = "vector.load"(%arg10, %10) : (memref<4xf32, #spirv.storage_class<StorageBuffer>>, index) -> vector<1xf32>
    "func.return"(%12) : (vector<1xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xf32, #spirv.storage_class<StorageBuffer>>) -> vector<4xf32>, sym_name = "vector_load_aligned"}> ({
  ^bb0(%arg9: memref<4xf32, #spirv.storage_class<StorageBuffer>>):
    %8 = "arith.constant"() <{value = 0 : index}> : () -> index
    %9 = "vector.load"(%arg9, %8) <{alignment = 8 : i64}> : (memref<4xf32, #spirv.storage_class<StorageBuffer>>, index) -> vector<4xf32>
    "func.return"(%9) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4x4xf32, #spirv.storage_class<StorageBuffer>>) -> vector<4xf32>, sym_name = "vector_load_2d"}> ({
  ^bb0(%arg8: memref<4x4xf32, #spirv.storage_class<StorageBuffer>>):
    %5 = "arith.constant"() <{value = 0 : index}> : () -> index
    %6 = "arith.constant"() <{value = 1 : index}> : () -> index
    %7 = "vector.load"(%arg8, %5, %6) : (memref<4x4xf32, #spirv.storage_class<StorageBuffer>>, index, index) -> vector<4xf32>
    "func.return"(%7) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xf32, #spirv.storage_class<StorageBuffer>>, vector<4xf32>) -> (), sym_name = "vector_store"}> ({
  ^bb0(%arg6: memref<4xf32, #spirv.storage_class<StorageBuffer>>, %arg7: vector<4xf32>):
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    "vector.store"(%arg7, %arg6, %4) : (vector<4xf32>, memref<4xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xf32, #spirv.storage_class<StorageBuffer>>, vector<4xf32>) -> (), sym_name = "vector_store_aligned"}> ({
  ^bb0(%arg4: memref<4xf32, #spirv.storage_class<StorageBuffer>>, %arg5: vector<4xf32>):
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    "vector.store"(%arg5, %arg4, %3) <{alignment = 8 : i64}> : (vector<4xf32>, memref<4xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xf32, #spirv.storage_class<StorageBuffer>>, vector<1xf32>) -> (), sym_name = "vector_store_single_elem"}> ({
  ^bb0(%arg2: memref<4xf32, #spirv.storage_class<StorageBuffer>>, %arg3: vector<1xf32>):
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    "vector.store"(%arg3, %arg2, %2) : (vector<1xf32>, memref<4xf32, #spirv.storage_class<StorageBuffer>>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4x4xf32, #spirv.storage_class<StorageBuffer>>, vector<4xf32>) -> (), sym_name = "vector_store_2d"}> ({
  ^bb0(%arg0: memref<4x4xf32, #spirv.storage_class<StorageBuffer>>, %arg1: vector<4xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    "vector.store"(%arg1, %arg0, %0, %1) : (vector<4xf32>, memref<4x4xf32, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
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

