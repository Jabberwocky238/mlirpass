"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "combine_full_access_chain"}> ({
    %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.struct<(!spirv.array<4 x !spirv.array<4 x f32>>, !spirv.array<4 x i32>)>, Function>
    %2 = "spirv.AccessChain"(%1, %0, %0, %0) : (!spirv.ptr<!spirv.struct<(!spirv.array<4 x !spirv.array<4 x f32>>, !spirv.array<4 x i32>)>, Function>, i32, i32, i32) -> !spirv.ptr<f32, Function>
    %3 = "spirv.Load"(%2) : (!spirv.ptr<f32, Function>) -> f32
    "spirv.ReturnValue"(%3) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> !spirv.array<4 x f32>, sym_name = "combine_access_chain_multi_use"}> ({
    %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.struct<(!spirv.array<4 x !spirv.array<4 x f32>>, !spirv.array<4 x i32>)>, Function>
    %2 = "spirv.AccessChain"(%1, %0, %0) : (!spirv.ptr<!spirv.struct<(!spirv.array<4 x !spirv.array<4 x f32>>, !spirv.array<4 x i32>)>, Function>, i32, i32) -> !spirv.ptr<!spirv.array<4 x f32>, Function>
    %3 = "spirv.AccessChain"(%1, %0, %0, %0) : (!spirv.ptr<!spirv.struct<(!spirv.array<4 x !spirv.array<4 x f32>>, !spirv.array<4 x i32>)>, Function>, i32, i32, i32) -> !spirv.ptr<f32, Function>
    %4 = "spirv.Load"(%2) : (!spirv.ptr<!spirv.array<4 x f32>, Function>) -> !spirv.array<4 x f32>
    %5 = "spirv.Load"(%3) : (!spirv.ptr<f32, Function>) -> f32
    "spirv.ReturnValue"(%4) : (!spirv.array<4 x f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> !spirv.array<4 x i32>, sym_name = "dont_combine_access_chain_without_common_base"}> ({
    %0 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.struct<(!spirv.array<4 x !spirv.array<4 x f32>>, !spirv.array<4 x i32>)>, Function>
    %2 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.struct<(!spirv.array<4 x !spirv.array<4 x f32>>, !spirv.array<4 x i32>)>, Function>
    %3 = "spirv.AccessChain"(%1, %0) : (!spirv.ptr<!spirv.struct<(!spirv.array<4 x !spirv.array<4 x f32>>, !spirv.array<4 x i32>)>, Function>, i32) -> !spirv.ptr<!spirv.array<4 x i32>, Function>
    %4 = "spirv.AccessChain"(%2, %0) : (!spirv.ptr<!spirv.struct<(!spirv.array<4 x !spirv.array<4 x f32>>, !spirv.array<4 x i32>)>, Function>, i32) -> !spirv.ptr<!spirv.array<4 x i32>, Function>
    %5 = "spirv.Load"(%3) : (!spirv.ptr<!spirv.array<4 x i32>, Function>) -> !spirv.array<4 x i32>
    %6 = "spirv.Load"(%4) : (!spirv.ptr<!spirv.array<4 x i32>, Function>) -> !spirv.array<4 x i32>
    "spirv.ReturnValue"(%5) : (!spirv.array<4 x i32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>) -> f64, sym_name = "convert_bitcast_full"}> ({
  ^bb0(%arg0: vector<2xf32>):
    %0 = "spirv.Bitcast"(%arg0) : (vector<2xf32>) -> f64
    "spirv.ReturnValue"(%0) : (f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, !spirv.ptr<i64, Uniform>) -> f64, sym_name = "convert_bitcast_multi_use"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: !spirv.ptr<i64, Uniform>):
    %0 = "spirv.Bitcast"(%arg0) : (vector<2xf32>) -> i64
    %1 = "spirv.Bitcast"(%arg0) : (vector<2xf32>) -> f64
    "spirv.Store"(%arg1, %0) : (!spirv.ptr<i64, Uniform>, i64) -> ()
    "spirv.ReturnValue"(%1) : (f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64) -> i64, sym_name = "convert_bitcast_roundtip"}> ({
  ^bb0(%arg0: i64):
    "spirv.ReturnValue"(%arg0) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64) -> i64, sym_name = "convert_bitcast_chained_roundtip"}> ({
  ^bb0(%arg0: i64):
    "spirv.ReturnValue"(%arg0) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (i32, i32, i32), sym_name = "extract_vector"}> ({
    %0 = "spirv.Constant"() <{value = 42 : i32}> : () -> i32
    %1 = "spirv.Constant"() <{value = -33 : i32}> : () -> i32
    %2 = "spirv.Constant"() <{value = 6 : i32}> : () -> i32
    "func.return"(%0, %1, %2) : (i32, i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "extract_array_final"}> ({
    %0 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %1 = "spirv.Constant"() <{value = -5 : i32}> : () -> i32
    "func.return"(%0, %1) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<2xi32>, sym_name = "extract_array_interm"}> ({
    %0 = "spirv.Constant"() <{value = dense<[4, -5]> : vector<2xi32>}> : () -> vector<2xi32>
    "func.return"(%0) : (vector<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "extract_from_not_constant"}> ({
    %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xi32>, Function>
    %1 = "spirv.Load"(%0) : (!spirv.ptr<vector<3xi32>, Function>) -> vector<3xi32>
    %2 = "spirv.CompositeExtract"(%1) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
    "spirv.ReturnValue"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!spirv.array<1 x vector<2xf32>>, f32) -> (f32, f32), sym_name = "extract_insert"}> ({
  ^bb0(%arg0: !spirv.array<1 x vector<2xf32>>, %arg1: f32):
    %0 = "spirv.CompositeInsert"(%arg1, %arg0) <{indices = [0 : i32, 1 : i32]}> : (f32, !spirv.array<1 x vector<2xf32>>) -> !spirv.array<1 x vector<2xf32>>
    %1 = "spirv.CompositeExtract"(%0) <{indices = [0 : i32, 0 : i32]}> : (!spirv.array<1 x vector<2xf32>>) -> f32
    "func.return"(%1, %arg1) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf32>) -> (vector<2xf32>, vector<2xf32>), sym_name = "extract_construct"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<2xf32>):
    "func.return"(%arg0, %arg1) : (vector<2xf32>, vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!spirv.struct<(f32, f32)>, f32, f32) -> f32, sym_name = "fold_composite_op"}> ({
  ^bb0(%arg0: !spirv.struct<(f32, f32)>, %arg1: f32, %arg2: f32):
    "func.return"(%arg1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, f32) -> f32, sym_name = "fold_composite_op"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):
    "func.return"(%arg0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xf32>, f32) -> (f32, f32), sym_name = "extract_construct"}> ({
  ^bb0(%arg0: vector<3xf32>, %arg1: f32):
    %0 = "spirv.CompositeConstruct"(%arg0, %arg1) : (vector<3xf32>, f32) -> vector<4xf32>
    %1 = "spirv.CompositeExtract"(%0) <{indices = [0 : i32]}> : (vector<4xf32>) -> f32
    %2 = "spirv.CompositeExtract"(%0) <{indices = [1 : i32]}> : (vector<4xf32>) -> f32
    "func.return"(%1, %2) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "deduplicate_scalar_constant"}> ({
    %0 = "spirv.Constant"() <{value = 42 : i32}> : () -> i32
    "func.return"(%0, %0) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (vector<3xi32>, vector<3xi32>), sym_name = "deduplicate_vector_constant"}> ({
    %0 = "spirv.Constant"() <{value = dense<[1, 2, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%0, %0) : (vector<3xi32>, vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (!spirv.array<1 x vector<2xi32>>, !spirv.array<1 x vector<2xi32>>), sym_name = "deduplicate_composite_constant"}> ({
    %0 = "spirv.Constant"() <{value = [dense<5> : vector<2xi32>]}> : () -> !spirv.array<1 x vector<2xi32>>
    "func.return"(%0, %0) : (!spirv.array<1 x vector<2xi32>>, !spirv.array<1 x vector<2xi32>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "iadd_zero"}> ({
  ^bb0(%arg1: i32):
    "func.return"(%arg1, %arg1) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32, i32), sym_name = "const_fold_scalar_iadd_normal"}> ({
    %6 = "spirv.Constant"() <{value = 10 : i32}> : () -> i32
    %7 = "spirv.Constant"() <{value = -16 : i32}> : () -> i32
    %8 = "spirv.Constant"() <{value = -3 : i32}> : () -> i32
    "func.return"(%6, %7, %8) : (i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32, i32, i32), sym_name = "const_fold_scalar_iadd_flow"}> ({
    %2 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %3 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = 2147483647 : i32}> : () -> i32
    %5 = "spirv.Constant"() <{value = 2147483646 : i32}> : () -> i32
    "func.return"(%2, %3, %4, %5) : (i32, i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "const_fold_vector_iadd"}> ({
    %1 = "spirv.Constant"() <{value = dense<[39, -70, 155]> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%1) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "iadd_poison"}> ({
  ^bb0(%arg0: i32):
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> !spirv.struct<(i32, i32)>, sym_name = "iaddcarry_x_0"}> ({
  ^bb0(%arg0: i32):
    %15 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %16 = "spirv.CompositeConstruct"(%15, %arg0) : (i32, i32) -> !spirv.struct<(i32, i32)>
    "func.return"(%16) : (!spirv.struct<(i32, i32)>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (!spirv.struct<(i32, i32)>, !spirv.struct<(i32, i32)>), sym_name = "const_fold_scalar_iaddcarry"}> ({
    %5 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %6 = "spirv.Constant"() <{value = -13 : i32}> : () -> i32
    %7 = "spirv.Constant"() <{value = -3 : i32}> : () -> i32
    %8 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %9 = "spirv.Undef"() : () -> !spirv.struct<(i32, i32)>
    %10 = "spirv.CompositeInsert"(%7, %9) <{indices = [0 : i32]}> : (i32, !spirv.struct<(i32, i32)>) -> !spirv.struct<(i32, i32)>
    %11 = "spirv.CompositeInsert"(%8, %10) <{indices = [1 : i32]}> : (i32, !spirv.struct<(i32, i32)>) -> !spirv.struct<(i32, i32)>
    %12 = "spirv.Undef"() : () -> !spirv.struct<(i32, i32)>
    %13 = "spirv.CompositeInsert"(%6, %12) <{indices = [0 : i32]}> : (i32, !spirv.struct<(i32, i32)>) -> !spirv.struct<(i32, i32)>
    %14 = "spirv.CompositeInsert"(%5, %13) <{indices = [1 : i32]}> : (i32, !spirv.struct<(i32, i32)>) -> !spirv.struct<(i32, i32)>
    "func.return"(%11, %14) : (!spirv.struct<(i32, i32)>, !spirv.struct<(i32, i32)>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>, sym_name = "const_fold_vector_iaddcarry"}> ({
    %0 = "spirv.Constant"() <{value = dense<[-3, -11, 0]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[0, 1, 1]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.Undef"() : () -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>
    %3 = "spirv.CompositeInsert"(%0, %2) <{indices = [0 : i32]}> : (vector<3xi32>, !spirv.struct<(vector<3xi32>, vector<3xi32>)>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>
    %4 = "spirv.CompositeInsert"(%1, %3) <{indices = [1 : i32]}> : (vector<3xi32>, !spirv.struct<(vector<3xi32>, vector<3xi32>)>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>
    "func.return"(%4) : (!spirv.struct<(vector<3xi32>, vector<3xi32>)>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "imul_zero_one"}> ({
  ^bb0(%arg0: i32):
    %6 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%6, %arg0) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32, i32), sym_name = "const_fold_scalar_imul_normal"}> ({
    %3 = "spirv.Constant"() <{value = 35 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = -40 : i32}> : () -> i32
    %5 = "spirv.Constant"() <{value = -56 : i32}> : () -> i32
    "func.return"(%3, %4, %5) : (i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32, i32), sym_name = "const_fold_scalar_imul_flow"}> ({
    %1 = "spirv.Constant"() <{value = -2 : i32}> : () -> i32
    %2 = "spirv.Constant"() <{value = -4 : i32}> : () -> i32
    "func.return"(%1, %1, %2) : (i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "const_fold_vector_imul"}> ({
    %0 = "spirv.Constant"() <{value = dense<[-126, 825, 3556]> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%0) : (vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> !spirv.struct<(i32, i32)>, sym_name = "smulextended_x_0"}> ({
  ^bb0(%arg0: i32):
    %15 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %16 = "spirv.CompositeConstruct"(%15, %15) : (i32, i32) -> !spirv.struct<(i32, i32)>
    "func.return"(%16) : (!spirv.struct<(i32, i32)>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (!spirv.struct<(i32, i32)>, !spirv.struct<(i32, i32)>), sym_name = "const_fold_scalar_smulextended"}> ({
    %5 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %6 = "spirv.Constant"() <{value = 40 : i32}> : () -> i32
    %7 = "spirv.Constant"() <{value = -40 : i32}> : () -> i32
    %8 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    %9 = "spirv.Undef"() : () -> !spirv.struct<(i32, i32)>
    %10 = "spirv.CompositeInsert"(%7, %9) <{indices = [0 : i32]}> : (i32, !spirv.struct<(i32, i32)>) -> !spirv.struct<(i32, i32)>
    %11 = "spirv.CompositeInsert"(%8, %10) <{indices = [1 : i32]}> : (i32, !spirv.struct<(i32, i32)>) -> !spirv.struct<(i32, i32)>
    %12 = "spirv.Undef"() : () -> !spirv.struct<(i32, i32)>
    %13 = "spirv.CompositeInsert"(%6, %12) <{indices = [0 : i32]}> : (i32, !spirv.struct<(i32, i32)>) -> !spirv.struct<(i32, i32)>
    %14 = "spirv.CompositeInsert"(%5, %13) <{indices = [1 : i32]}> : (i32, !spirv.struct<(i32, i32)>) -> !spirv.struct<(i32, i32)>
    "func.return"(%11, %14) : (!spirv.struct<(i32, i32)>, !spirv.struct<(i32, i32)>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>, sym_name = "const_fold_vector_smulextended"}> ({
    %0 = "spirv.Constant"() <{value = dense<[2147483643, 40, -1]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[2, 0, -1]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.Undef"() : () -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>
    %3 = "spirv.CompositeInsert"(%0, %2) <{indices = [0 : i32]}> : (vector<3xi32>, !spirv.struct<(vector<3xi32>, vector<3xi32>)>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>
    %4 = "spirv.CompositeInsert"(%1, %3) <{indices = [1 : i32]}> : (vector<3xi32>, !spirv.struct<(vector<3xi32>, vector<3xi32>)>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>
    "func.return"(%4) : (!spirv.struct<(vector<3xi32>, vector<3xi32>)>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> !spirv.struct<(i32, i32)>, sym_name = "umulextended_x_0"}> ({
  ^bb0(%arg1: i32):
    %17 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %18 = "spirv.CompositeConstruct"(%17, %17) : (i32, i32) -> !spirv.struct<(i32, i32)>
    "func.return"(%18) : (!spirv.struct<(i32, i32)>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> !spirv.struct<(i32, i32)>, sym_name = "umulextended_x_1"}> ({
  ^bb0(%arg0: i32):
    %15 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %16 = "spirv.CompositeConstruct"(%arg0, %15) : (i32, i32) -> !spirv.struct<(i32, i32)>
    "func.return"(%16) : (!spirv.struct<(i32, i32)>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (!spirv.struct<(i32, i32)>, !spirv.struct<(i32, i32)>), sym_name = "const_fold_scalar_umulextended"}> ({
    %5 = "spirv.Constant"() <{value = -13 : i32}> : () -> i32
    %6 = "spirv.Constant"() <{value = 40 : i32}> : () -> i32
    %7 = "spirv.Constant"() <{value = -40 : i32}> : () -> i32
    %8 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %9 = "spirv.Undef"() : () -> !spirv.struct<(i32, i32)>
    %10 = "spirv.CompositeInsert"(%7, %9) <{indices = [0 : i32]}> : (i32, !spirv.struct<(i32, i32)>) -> !spirv.struct<(i32, i32)>
    %11 = "spirv.CompositeInsert"(%8, %10) <{indices = [1 : i32]}> : (i32, !spirv.struct<(i32, i32)>) -> !spirv.struct<(i32, i32)>
    %12 = "spirv.Undef"() : () -> !spirv.struct<(i32, i32)>
    %13 = "spirv.CompositeInsert"(%6, %12) <{indices = [0 : i32]}> : (i32, !spirv.struct<(i32, i32)>) -> !spirv.struct<(i32, i32)>
    %14 = "spirv.CompositeInsert"(%5, %13) <{indices = [1 : i32]}> : (i32, !spirv.struct<(i32, i32)>) -> !spirv.struct<(i32, i32)>
    "func.return"(%11, %14) : (!spirv.struct<(i32, i32)>, !spirv.struct<(i32, i32)>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>, sym_name = "const_fold_vector_umulextended"}> ({
    %0 = "spirv.Constant"() <{value = dense<[2147483643, 40, -1]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[2, -13, 0]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.Undef"() : () -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>
    %3 = "spirv.CompositeInsert"(%0, %2) <{indices = [0 : i32]}> : (vector<3xi32>, !spirv.struct<(vector<3xi32>, vector<3xi32>)>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>
    %4 = "spirv.CompositeInsert"(%1, %3) <{indices = [1 : i32]}> : (vector<3xi32>, !spirv.struct<(vector<3xi32>, vector<3xi32>)>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>
    "func.return"(%4) : (!spirv.struct<(vector<3xi32>, vector<3xi32>)>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "isub_x_x"}> ({
  ^bb0(%arg1: i32):
    %9 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%9) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi32>) -> vector<3xi32>, sym_name = "isub_vector_x_x"}> ({
  ^bb0(%arg0: vector<3xi32>):
    %8 = "spirv.Constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%8) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32, i32), sym_name = "const_fold_scalar_isub_normal"}> ({
    %5 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    %6 = "spirv.Constant"() <{value = 13 : i32}> : () -> i32
    %7 = "spirv.Constant"() <{value = -15 : i32}> : () -> i32
    "func.return"(%5, %6, %7) : (i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32, i32, i32), sym_name = "const_fold_scalar_isub_flow"}> ({
    %1 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %2 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    %3 = "spirv.Constant"() <{value = -2147483648 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = 2147483647 : i32}> : () -> i32
    "func.return"(%1, %2, %3, %4) : (i32, i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "const_fold_vector_isub"}> ({
    %0 = "spirv.Constant"() <{value = dense<[45, -40, 99]> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%0) : (vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "sdiv_x_1"}> ({
  ^bb0(%arg0: i32):
    "func.return"(%arg0) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "sdiv_div_0_or_overflow"}> ({
    %5 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %6 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    %7 = "spirv.Constant"() <{value = -2147483648 : i32}> : () -> i32
    %8 = "spirv.SDiv"(%6, %5) : (i32, i32) -> i32
    %9 = "spirv.SDiv"(%7, %6) : (i32, i32) -> i32
    "func.return"(%8, %9) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32, i32, i32), sym_name = "const_fold_scalar_sdiv"}> ({
    %1 = "spirv.Constant"() <{value = 8 : i32}> : () -> i32
    %2 = "spirv.Constant"() <{value = -7 : i32}> : () -> i32
    %3 = "spirv.Constant"() <{value = -2 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = -18 : i32}> : () -> i32
    "func.return"(%1, %2, %3, %4) : (i32, i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "const_fold_vector_sdiv"}> ({
    %0 = "spirv.Constant"() <{value = dense<[0, -1, -3]> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%0) : (vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "smod_x_1"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %12 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %13 = "spirv.Constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%12, %13) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "smod_div_0_or_overflow"}> ({
    %7 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %8 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    %9 = "spirv.Constant"() <{value = -2147483648 : i32}> : () -> i32
    %10 = "spirv.SMod"(%8, %7) : (i32, i32) -> i32
    %11 = "spirv.SMod"(%9, %8) : (i32, i32) -> i32
    "func.return"(%10, %11) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32, i32, i32, i32, i32, i32, i32), sym_name = "const_fold_scalar_smod"}> ({
    %1 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %2 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    %3 = "spirv.Constant"() <{value = 53 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = -3 : i32}> : () -> i32
    %5 = "spirv.Constant"() <{value = 3 : i32}> : () -> i32
    %6 = "spirv.Constant"() <{value = -53 : i32}> : () -> i32
    "func.return"(%1, %1, %2, %3, %4, %5, %6, %4) : (i32, i32, i32, i32, i32, i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "const_fold_vector_smod"}> ({
    %0 = "spirv.Constant"() <{value = dense<[42, -4, 4]> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%0) : (vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "srem_x_1"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %9 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %10 = "spirv.Constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%9, %10) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "srem_div_0_or_overflow"}> ({
    %4 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %5 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    %6 = "spirv.Constant"() <{value = -2147483648 : i32}> : () -> i32
    %7 = "spirv.SRem"(%5, %4) : (i32, i32) -> i32
    %8 = "spirv.SRem"(%6, %5) : (i32, i32) -> i32
    "func.return"(%7, %8) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32, i32, i32, i32), sym_name = "const_fold_scalar_srem"}> ({
    %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %1 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    %2 = "spirv.Constant"() <{value = -3 : i32}> : () -> i32
    %3 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    "func.return"(%0, %0, %1, %2, %3) : (i32, i32, i32, i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "udiv_x_1"}> ({
  ^bb0(%arg0: i32):
    "func.return"(%arg0) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "udiv_div_0"}> ({
    %3 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    %5 = "spirv.UDiv"(%4, %3) : (i32, i32) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32, i32), sym_name = "const_fold_scalar_udiv"}> ({
    %0 = "spirv.Constant"() <{value = 8 : i32}> : () -> i32
    %1 = "spirv.Constant"() <{value = 1431655762 : i32}> : () -> i32
    %2 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%0, %1, %2) : (i32, i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "umod_x_1"}> ({
  ^bb0(%arg7: i32, %arg8: vector<3xi32>):
    %34 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %35 = "spirv.Constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%34, %35) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "umod_div_0"}> ({
    %31 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %32 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    %33 = "spirv.UMod"(%32, %31) : (i32, i32) -> i32
    "func.return"(%33) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32, i32), sym_name = "const_fold_scalar_umod"}> ({
    %28 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %29 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    %30 = "spirv.Constant"() <{value = 56 : i32}> : () -> i32
    "func.return"(%28, %29, %30) : (i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "const_fold_vector_umod"}> ({
    %27 = "spirv.Constant"() <{value = dense<[42, 24, 0]> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%27) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "umod_fold"}> ({
  ^bb0(%arg6: i32):
    %23 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %24 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
    %25 = "spirv.UMod"(%arg6, %24) : (i32, i32) -> i32
    %26 = "spirv.UMod"(%arg6, %23) : (i32, i32) -> i32
    "func.return"(%25, %26) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> (vector<4xi32>, vector<4xi32>), sym_name = "umod_vector_fold"}> ({
  ^bb0(%arg5: vector<4xi32>):
    %19 = "spirv.Constant"() <{value = dense<4> : vector<4xi32>}> : () -> vector<4xi32>
    %20 = "spirv.Constant"() <{value = dense<32> : vector<4xi32>}> : () -> vector<4xi32>
    %21 = "spirv.UMod"(%arg5, %20) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %22 = "spirv.UMod"(%arg5, %19) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"(%21, %22) : (vector<4xi32>, vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "umod_fold_same_divisor"}> ({
  ^bb0(%arg4: i32):
    %16 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
    %17 = "spirv.UMod"(%arg4, %16) : (i32, i32) -> i32
    %18 = "spirv.UMod"(%arg4, %16) : (i32, i32) -> i32
    "func.return"(%17, %18) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "umod_fail_1_fold"}> ({
  ^bb0(%arg3: i32):
    %12 = "spirv.Constant"() <{value = 5 : i32}> : () -> i32
    %13 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
    %14 = "spirv.UMod"(%arg3, %13) : (i32, i32) -> i32
    %15 = "spirv.UMod"(%14, %12) : (i32, i32) -> i32
    "func.return"(%14, %15) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "umod_fail_2_fold"}> ({
  ^bb0(%arg2: i32):
    %8 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
    %9 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %10 = "spirv.UMod"(%arg2, %9) : (i32, i32) -> i32
    %11 = "spirv.UMod"(%10, %8) : (i32, i32) -> i32
    "func.return"(%10, %11) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> (vector<4xi32>, vector<4xi32>), sym_name = "umod_vector_fail_1_fold"}> ({
  ^bb0(%arg1: vector<4xi32>):
    %4 = "spirv.Constant"() <{value = dense<9> : vector<4xi32>}> : () -> vector<4xi32>
    %5 = "spirv.Constant"() <{value = dense<64> : vector<4xi32>}> : () -> vector<4xi32>
    %6 = "spirv.UMod"(%arg1, %5) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %7 = "spirv.UMod"(%6, %4) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"(%6, %7) : (vector<4xi32>, vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> (vector<4xi32>, vector<4xi32>), sym_name = "umod_vector_fail_2_fold"}> ({
  ^bb0(%arg0: vector<4xi32>):
    %0 = "spirv.Constant"() <{value = dense<32> : vector<4xi32>}> : () -> vector<4xi32>
    %1 = "spirv.Constant"() <{value = dense<4> : vector<4xi32>}> : () -> vector<4xi32>
    %2 = "spirv.UMod"(%arg0, %1) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %3 = "spirv.UMod"(%2, %0) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"(%2, %3) : (vector<4xi32>, vector<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "snegate_twice"}> ({
  ^bb0(%arg0: i32):
    "func.return"(%arg0) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i8, i8), sym_name = "snegate_min"}> ({
    %4 = "spirv.Constant"() <{value = -128 : i8}> : () -> i8
    "func.return"(%4, %4) : (i8, i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32, i32), sym_name = "const_fold_scalar_snegate"}> ({
    %1 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %2 = "spirv.Constant"() <{value = -3 : i32}> : () -> i32
    %3 = "spirv.Constant"() <{value = 3 : i32}> : () -> i32
    "func.return"(%1, %2, %3) : (i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "const_fold_vector_snegate"}> ({
    %0 = "spirv.Constant"() <{value = dense<[0, 3, -3]> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%0) : (vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "not_twice"}> ({
  ^bb0(%arg0: i32):
    "func.return"(%arg0) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32, i32), sym_name = "const_fold_scalar_not"}> ({
    %1 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    %2 = "spirv.Constant"() <{value = -4 : i32}> : () -> i32
    %3 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    "func.return"(%1, %2, %3) : (i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "const_fold_vector_not"}> ({
    %0 = "spirv.Constant"() <{value = dense<[0, 3, -3]> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%0) : (vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (i1, i1), sym_name = "convert_logical_and_true_false_scalar"}> ({
  ^bb0(%arg1: i1):
    %1 = "spirv.Constant"() <{value = false}> : () -> i1
    "func.return"(%arg1, %1) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi1>) -> (vector<3xi1>, vector<3xi1>), sym_name = "convert_logical_and_true_false_vector"}> ({
  ^bb0(%arg0: vector<3xi1>):
    %0 = "spirv.Constant"() <{value = dense<false> : vector<3xi1>}> : () -> vector<3xi1>
    "func.return"(%arg0, %0) : (vector<3xi1>, vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i1, sym_name = "logical_not_twice"}> ({
  ^bb0(%arg0: i1):
    "func.return"(%arg0) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i1, sym_name = "const_fold_scalar_logical_not"}> ({
    %1 = "spirv.Constant"() <{value = false}> : () -> i1
    "func.return"(%1) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<2xi1>, sym_name = "const_fold_vector_logical_not"}> ({
    %0 = "spirv.Constant"() <{value = dense<[false, true]> : vector<2xi1>}> : () -> vector<2xi1>
    "func.return"(%0) : (vector<2xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xi64>, vector<3xi64>) -> vector<3xi1>, sym_name = "convert_logical_not_to_not_equal"}> ({
  ^bb0(%arg0: vector<3xi64>, %arg1: vector<3xi64>):
    %0 = "spirv.INotEqual"(%arg0, %arg1) : (vector<3xi64>, vector<3xi64>) -> vector<3xi1>
    "spirv.ReturnValue"(%0) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, vector<3xi1>) -> (i1, vector<3xi1>), sym_name = "logical_equal_same"}> ({
  ^bb0(%arg0: i1, %arg1: vector<3xi1>):
    %3 = "spirv.Constant"() <{value = true}> : () -> i1
    %4 = "spirv.Constant"() <{value = dense<true> : vector<3xi1>}> : () -> vector<3xi1>
    "func.return"(%3, %4) : (i1, vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i1, i1), sym_name = "const_fold_scalar_logical_equal"}> ({
    %1 = "spirv.Constant"() <{value = false}> : () -> i1
    %2 = "spirv.Constant"() <{value = true}> : () -> i1
    "func.return"(%1, %2) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "const_fold_vector_logical_equal"}> ({
    %0 = "spirv.Constant"() <{value = dense<[true, true, false]> : vector<3xi1>}> : () -> vector<3xi1>
    "func.return"(%0) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi1>) -> vector<4xi1>, sym_name = "convert_logical_not_equal_false"}> ({
  ^bb0(%arg2: vector<4xi1>):
    "spirv.ReturnValue"(%arg2) : (vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, vector<3xi1>) -> (i1, vector<3xi1>), sym_name = "logical_not_equal_same"}> ({
  ^bb0(%arg0: i1, %arg1: vector<3xi1>):
    %3 = "spirv.Constant"() <{value = false}> : () -> i1
    %4 = "spirv.Constant"() <{value = dense<false> : vector<3xi1>}> : () -> vector<3xi1>
    "func.return"(%3, %4) : (i1, vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i1, i1), sym_name = "const_fold_scalar_logical_not_equal"}> ({
    %1 = "spirv.Constant"() <{value = true}> : () -> i1
    %2 = "spirv.Constant"() <{value = false}> : () -> i1
    "func.return"(%1, %2) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "const_fold_vector_logical_not_equal"}> ({
    %0 = "spirv.Constant"() <{value = dense<[false, false, true]> : vector<3xi1>}> : () -> vector<3xi1>
    "func.return"(%0) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xi64>, vector<3xi64>) -> vector<3xi1>, sym_name = "convert_logical_not_to_equal"}> ({
  ^bb0(%arg0: vector<3xi64>, %arg1: vector<3xi64>):
    %0 = "spirv.IEqual"(%arg0, %arg1) : (vector<3xi64>, vector<3xi64>) -> vector<3xi1>
    "spirv.ReturnValue"(%0) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xi64>, vector<3xi64>, !spirv.ptr<vector<3xi1>, Uniform>) -> vector<3xi1>, sym_name = "convert_logical_not_parent_multi_use"}> ({
  ^bb0(%arg0: vector<3xi64>, %arg1: vector<3xi64>, %arg2: !spirv.ptr<vector<3xi1>, Uniform>):
    %0 = "spirv.INotEqual"(%arg0, %arg1) : (vector<3xi64>, vector<3xi64>) -> vector<3xi1>
    %1 = "spirv.IEqual"(%arg0, %arg1) : (vector<3xi64>, vector<3xi64>) -> vector<3xi1>
    "spirv.Store"(%arg2, %0) : (!spirv.ptr<vector<3xi1>, Uniform>, vector<3xi1>) -> ()
    "spirv.ReturnValue"(%1) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xi1>, vector<3xi1>) -> vector<3xi1>, sym_name = "convert_logical_not_to_logical_not_equal"}> ({
  ^bb0(%arg0: vector<3xi1>, %arg1: vector<3xi1>):
    %0 = "spirv.LogicalNotEqual"(%arg0, %arg1) : (vector<3xi1>, vector<3xi1>) -> vector<3xi1>
    "spirv.ReturnValue"(%0) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xi1>, vector<3xi1>) -> vector<3xi1>, sym_name = "convert_logical_not_to_logical_equal"}> ({
  ^bb0(%arg0: vector<3xi1>, %arg1: vector<3xi1>):
    %0 = "spirv.LogicalEqual"(%arg0, %arg1) : (vector<3xi1>, vector<3xi1>) -> vector<3xi1>
    "spirv.ReturnValue"(%0) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (i1, i1), sym_name = "convert_logical_or_true_false_scalar"}> ({
  ^bb0(%arg1: i1):
    %1 = "spirv.Constant"() <{value = true}> : () -> i1
    "func.return"(%1, %arg1) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi1>) -> (vector<3xi1>, vector<3xi1>), sym_name = "convert_logical_or_true_false_vector"}> ({
  ^bb0(%arg0: vector<3xi1>):
    %0 = "spirv.Constant"() <{value = dense<true> : vector<3xi1>}> : () -> vector<3xi1>
    "func.return"(%0, %arg0) : (vector<3xi1>, vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (i32, i32), sym_name = "convert_select_scalar"}> ({
  ^bb0(%arg4: i32, %arg5: i32):
    "func.return"(%arg4, %arg5) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi32>, vector<3xi32>) -> (vector<3xi32>, vector<3xi32>), sym_name = "convert_select_vector"}> ({
  ^bb0(%arg2: vector<3xi32>, %arg3: vector<3xi32>):
    "func.return"(%arg2, %arg3) : (vector<3xi32>, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi1>, vector<2xi32>) -> (vector<2xi32>, vector<2xi32>), sym_name = "convert_select_vector_extra"}> ({
  ^bb0(%arg0: vector<2xi1>, %arg1: vector<2xi32>):
    %0 = "spirv.Constant"() <{value = dense<42> : vector<2xi32>}> : () -> vector<2xi32>
    "func.return"(%0, %arg1) : (vector<2xi32>, vector<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i1, vector<3xi1>), sym_name = "iequal_same"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %3 = "spirv.Constant"() <{value = true}> : () -> i1
    %4 = "spirv.Constant"() <{value = dense<true> : vector<3xi1>}> : () -> vector<3xi1>
    "func.return"(%3, %4) : (i1, vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i1, i1), sym_name = "const_fold_scalar_iequal"}> ({
    %1 = "spirv.Constant"() <{value = false}> : () -> i1
    %2 = "spirv.Constant"() <{value = true}> : () -> i1
    "func.return"(%1, %2) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "const_fold_vector_iequal"}> ({
    %0 = "spirv.Constant"() <{value = dense<[true, false, true]> : vector<3xi1>}> : () -> vector<3xi1>
    "func.return"(%0) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i1, vector<3xi1>), sym_name = "inotequal_same"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %3 = "spirv.Constant"() <{value = false}> : () -> i1
    %4 = "spirv.Constant"() <{value = dense<false> : vector<3xi1>}> : () -> vector<3xi1>
    "func.return"(%3, %4) : (i1, vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i1, i1), sym_name = "const_fold_scalar_inotequal"}> ({
    %1 = "spirv.Constant"() <{value = true}> : () -> i1
    %2 = "spirv.Constant"() <{value = false}> : () -> i1
    "func.return"(%1, %2) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "const_fold_vector_inotequal"}> ({
    %0 = "spirv.Constant"() <{value = dense<[false, true, false]> : vector<3xi1>}> : () -> vector<3xi1>
    "func.return"(%0) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i1, vector<3xi1>), sym_name = "sgt_same"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %3 = "spirv.Constant"() <{value = false}> : () -> i1
    %4 = "spirv.Constant"() <{value = dense<false> : vector<3xi1>}> : () -> vector<3xi1>
    "func.return"(%3, %4) : (i1, vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i1, i1), sym_name = "const_fold_scalar_sgt"}> ({
    %1 = "spirv.Constant"() <{value = false}> : () -> i1
    %2 = "spirv.Constant"() <{value = true}> : () -> i1
    "func.return"(%1, %2) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "const_fold_vector_sgt"}> ({
    %0 = "spirv.Constant"() <{value = dense<[false, false, true]> : vector<3xi1>}> : () -> vector<3xi1>
    "func.return"(%0) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i1, vector<3xi1>), sym_name = "sge_same"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %3 = "spirv.Constant"() <{value = true}> : () -> i1
    %4 = "spirv.Constant"() <{value = dense<true> : vector<3xi1>}> : () -> vector<3xi1>
    "func.return"(%3, %4) : (i1, vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i1, i1), sym_name = "const_fold_scalar_sge"}> ({
    %1 = "spirv.Constant"() <{value = false}> : () -> i1
    %2 = "spirv.Constant"() <{value = true}> : () -> i1
    "func.return"(%1, %2) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "const_fold_vector_sge"}> ({
    %0 = "spirv.Constant"() <{value = dense<[true, false, true]> : vector<3xi1>}> : () -> vector<3xi1>
    "func.return"(%0) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i1, vector<3xi1>), sym_name = "ugt_same"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %3 = "spirv.Constant"() <{value = false}> : () -> i1
    %4 = "spirv.Constant"() <{value = dense<false> : vector<3xi1>}> : () -> vector<3xi1>
    "func.return"(%3, %4) : (i1, vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i1, i1), sym_name = "const_fold_scalar_ugt"}> ({
    %1 = "spirv.Constant"() <{value = false}> : () -> i1
    %2 = "spirv.Constant"() <{value = true}> : () -> i1
    "func.return"(%1, %2) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "const_fold_vector_ugt"}> ({
    %0 = "spirv.Constant"() <{value = dense<[false, false, true]> : vector<3xi1>}> : () -> vector<3xi1>
    "func.return"(%0) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i1, vector<3xi1>), sym_name = "uge_same"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %3 = "spirv.Constant"() <{value = true}> : () -> i1
    %4 = "spirv.Constant"() <{value = dense<true> : vector<3xi1>}> : () -> vector<3xi1>
    "func.return"(%3, %4) : (i1, vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i1, i1), sym_name = "const_fold_scalar_uge"}> ({
    %1 = "spirv.Constant"() <{value = false}> : () -> i1
    %2 = "spirv.Constant"() <{value = true}> : () -> i1
    "func.return"(%1, %2) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "const_fold_vector_uge"}> ({
    %0 = "spirv.Constant"() <{value = dense<[true, false, true]> : vector<3xi1>}> : () -> vector<3xi1>
    "func.return"(%0) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i1, vector<3xi1>), sym_name = "slt_same"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %3 = "spirv.Constant"() <{value = false}> : () -> i1
    %4 = "spirv.Constant"() <{value = dense<false> : vector<3xi1>}> : () -> vector<3xi1>
    "func.return"(%3, %4) : (i1, vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i1, i1), sym_name = "const_fold_scalar_slt"}> ({
    %1 = "spirv.Constant"() <{value = true}> : () -> i1
    %2 = "spirv.Constant"() <{value = false}> : () -> i1
    "func.return"(%1, %2) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "const_fold_vector_slt"}> ({
    %0 = "spirv.Constant"() <{value = dense<[false, true, false]> : vector<3xi1>}> : () -> vector<3xi1>
    "func.return"(%0) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i1, vector<3xi1>), sym_name = "sle_same"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %3 = "spirv.Constant"() <{value = true}> : () -> i1
    %4 = "spirv.Constant"() <{value = dense<true> : vector<3xi1>}> : () -> vector<3xi1>
    "func.return"(%3, %4) : (i1, vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i1, i1), sym_name = "const_fold_scalar_sle"}> ({
    %1 = "spirv.Constant"() <{value = true}> : () -> i1
    %2 = "spirv.Constant"() <{value = false}> : () -> i1
    "func.return"(%1, %2) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "const_fold_vector_sle"}> ({
    %0 = "spirv.Constant"() <{value = dense<[true, true, false]> : vector<3xi1>}> : () -> vector<3xi1>
    "func.return"(%0) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i1, vector<3xi1>), sym_name = "ult_same"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %3 = "spirv.Constant"() <{value = false}> : () -> i1
    %4 = "spirv.Constant"() <{value = dense<false> : vector<3xi1>}> : () -> vector<3xi1>
    "func.return"(%3, %4) : (i1, vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i1, i1), sym_name = "const_fold_scalar_ult"}> ({
    %1 = "spirv.Constant"() <{value = true}> : () -> i1
    %2 = "spirv.Constant"() <{value = false}> : () -> i1
    "func.return"(%1, %2) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "const_fold_vector_ult"}> ({
    %0 = "spirv.Constant"() <{value = dense<[false, true, false]> : vector<3xi1>}> : () -> vector<3xi1>
    "func.return"(%0) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i1, vector<3xi1>), sym_name = "ule_same"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %3 = "spirv.Constant"() <{value = true}> : () -> i1
    %4 = "spirv.Constant"() <{value = dense<true> : vector<3xi1>}> : () -> vector<3xi1>
    "func.return"(%3, %4) : (i1, vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i1, i1), sym_name = "const_fold_scalar_ule"}> ({
    %1 = "spirv.Constant"() <{value = true}> : () -> i1
    %2 = "spirv.Constant"() <{value = false}> : () -> i1
    "func.return"(%1, %2) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "const_fold_vector_ule"}> ({
    %0 = "spirv.Constant"() <{value = dense<[true, true, false]> : vector<3xi1>}> : () -> vector<3xi1>
    "func.return"(%0) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "lsl_x_0"}> ({
  ^bb0(%arg2: i32, %arg3: vector<3xi32>):
    "func.return"(%arg2, %arg3) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "lsl_shift_overflow"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %2 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
    %3 = "spirv.Constant"() <{value = dense<[6, 18, 128]> : vector<3xi32>}> : () -> vector<3xi32>
    %4 = "spirv.ShiftLeftLogical"(%arg0, %2) : (i32, i32) -> i32
    %5 = "spirv.ShiftLeftLogical"(%arg1, %3) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%4, %5) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "const_fold_scalar_lsl"}> ({
    %1 = "spirv.Constant"() <{value = -131072 : i32}> : () -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "const_fold_vector_lsl"}> ({
    %0 = "spirv.Constant"() <{value = dense<[-2147483648, -65536, 1040384]> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%0) : (vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "asr_x_0"}> ({
  ^bb0(%arg2: i32, %arg3: vector<3xi32>):
    "func.return"(%arg2, %arg3) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "asr_shift_overflow"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %2 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
    %3 = "spirv.Constant"() <{value = dense<[6, 18, 128]> : vector<3xi32>}> : () -> vector<3xi32>
    %4 = "spirv.ShiftRightArithmetic"(%arg0, %2) : (i32, i32) -> i32
    %5 = "spirv.ShiftRightArithmetic"(%arg1, %3) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%4, %5) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "const_fold_scalar_asr"}> ({
    %1 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "const_fold_vector_asr"}> ({
    %0 = "spirv.Constant"() <{value = dense<[-1, 3, 0]> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%0) : (vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "lsr_x_0"}> ({
  ^bb0(%arg2: i32, %arg3: vector<3xi32>):
    "func.return"(%arg2, %arg3) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "lsr_shift_overflow"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %2 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
    %3 = "spirv.Constant"() <{value = dense<[6, 18, 128]> : vector<3xi32>}> : () -> vector<3xi32>
    %4 = "spirv.ShiftRightLogical"(%arg0, %2) : (i32, i32) -> i32
    %5 = "spirv.ShiftRightLogical"(%arg1, %3) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%4, %5) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "const_fold_scalar_lsr"}> ({
    %1 = "spirv.Constant"() <{value = 32767 : i32}> : () -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "const_fold_vector_lsr"}> ({
    %0 = "spirv.Constant"() <{value = dense<[1, 65535, 524287]> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%0) : (vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "bitwise_and_x_x"}> ({
  ^bb0(%arg4: i32, %arg5: vector<3xi32>):
    "func.return"(%arg4, %arg5) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "bitwise_and_x_0"}> ({
  ^bb0(%arg2: i32, %arg3: vector<3xi32>):
    %2 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %3 = "spirv.Constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%2, %3) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "bitwise_and_x_n1"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    "func.return"(%arg0, %arg1) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "const_fold_scalar_band"}> ({
    %1 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "const_fold_vector_band"}> ({
    %0 = "spirv.Constant"() <{value = dense<[40, -63, 28]> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%0) : (vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "bitwise_or_x_x"}> ({
  ^bb0(%arg4: i32, %arg5: vector<3xi32>):
    "func.return"(%arg4, %arg5) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "bitwise_or_x_0"}> ({
  ^bb0(%arg2: i32, %arg3: vector<3xi32>):
    "func.return"(%arg2, %arg3) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "bitwise_or_x_n1"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %2 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    %3 = "spirv.Constant"() <{value = dense<-1> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%2, %3) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "const_fold_scalar_bor"}> ({
    %1 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "const_fold_vector_bor"}> ({
    %0 = "spirv.Constant"() <{value = dense<[-1, -7, 127]> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%0) : (vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "bitwise_xor_x_0"}> ({
  ^bb0(%arg2: i32, %arg3: vector<3xi32>):
    "func.return"(%arg2, %arg3) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "bitwise_xor_x_x"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %2 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %3 = "spirv.Constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%2, %3) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "const_fold_scalar_bxor"}> ({
    %1 = "spirv.Constant"() <{value = 2147483647 : i32}> : () -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "const_fold_vector_bxor"}> ({
    %0 = "spirv.Constant"() <{value = dense<[-41, 56, 99]> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%0) : (vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (), sym_name = "canonicalize_selection_op_scalar_type"}> ({
  ^bb0(%arg0: i1):
    %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %1 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %2 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    %3 = "spirv.Variable"(%0) <{storage_class = #spirv.storage_class<Function>}> : (i32) -> !spirv.ptr<i32, Function>
    %4 = "spirv.Select"(%arg0, %1, %2) : (i1, i32, i32) -> i32
    "spirv.Store"(%3, %4) <{alignment = 4 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<i32, Function>, i32) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (), sym_name = "canonicalize_selection_op_vector_type"}> ({
  ^bb0(%arg0: i1):
    %0 = "spirv.Constant"() <{value = dense<[0, 1, 2]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[1, 2, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.Constant"() <{value = dense<[2, 3, 4]> : vector<3xi32>}> : () -> vector<3xi32>
    %3 = "spirv.Variable"(%0) <{storage_class = #spirv.storage_class<Function>}> : (vector<3xi32>) -> !spirv.ptr<vector<3xi32>, Function>
    %4 = "spirv.Select"(%arg0, %1, %2) : (i1, vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "spirv.Store"(%3, %4) <{alignment = 8 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<vector<3xi32>, Function>, vector<3xi32>) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (), sym_name = "cannot_canonicalize_selection_op_0"}> ({
  ^bb0(%arg0: i1):
    %0 = "spirv.Constant"() <{value = dense<[0, 1, 2]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[1, 2, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.Constant"() <{value = dense<[2, 3, 4]> : vector<3xi32>}> : () -> vector<3xi32>
    %3 = "spirv.Variable"(%0) <{storage_class = #spirv.storage_class<Function>}> : (vector<3xi32>) -> !spirv.ptr<vector<3xi32>, Function>
    %4 = "spirv.Variable"(%0) <{storage_class = #spirv.storage_class<Function>}> : (vector<3xi32>) -> !spirv.ptr<vector<3xi32>, Function>
    "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
      "spirv.BranchConditional"(%arg0, %3, %1, %4, %2)[^bb1, ^bb1] <{operandSegmentSizes = array<i32: 1, 2, 2>}> : (i1, !spirv.ptr<vector<3xi32>, Function>, vector<3xi32>, !spirv.ptr<vector<3xi32>, Function>, vector<3xi32>) -> ()
    ^bb1(%5: !spirv.ptr<vector<3xi32>, Function>, %6: vector<3xi32>):  // 2 preds: ^bb0, ^bb0
      "spirv.Store"(%5, %6) <{alignment = 8 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<vector<3xi32>, Function>, vector<3xi32>) -> ()
      "spirv.Branch"()[^bb2] : () -> ()
    ^bb2:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (), sym_name = "cannot_canonicalize_selection_op_1"}> ({
  ^bb0(%arg0: i1):
    %0 = "spirv.Constant"() <{value = dense<[0, 1, 2]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[1, 2, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.Constant"() <{value = dense<[2, 3, 4]> : vector<3xi32>}> : () -> vector<3xi32>
    %3 = "spirv.Variable"(%0) <{storage_class = #spirv.storage_class<Function>}> : (vector<3xi32>) -> !spirv.ptr<vector<3xi32>, Function>
    %4 = "spirv.Variable"(%0) <{storage_class = #spirv.storage_class<Function>}> : (vector<3xi32>) -> !spirv.ptr<vector<3xi32>, Function>
    "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
      "spirv.BranchConditional"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "spirv.Store"(%3, %1) <{alignment = 8 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<vector<3xi32>, Function>, vector<3xi32>) -> ()
      "spirv.Store"(%4, %1) <{alignment = 8 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<vector<3xi32>, Function>, vector<3xi32>) -> ()
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb2:  // pred: ^bb0
      "spirv.Store"(%4, %2) <{alignment = 8 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<vector<3xi32>, Function>, vector<3xi32>) -> ()
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb3:  // 2 preds: ^bb1, ^bb2
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (), sym_name = "cannot_canonicalize_selection_op_2"}> ({
  ^bb0(%arg0: i1):
    %0 = "spirv.Constant"() <{value = dense<[0, 1, 2]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[1, 2, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.Constant"() <{value = dense<[2, 3, 4]> : vector<3xi32>}> : () -> vector<3xi32>
    %3 = "spirv.Variable"(%0) <{storage_class = #spirv.storage_class<Function>}> : (vector<3xi32>) -> !spirv.ptr<vector<3xi32>, Function>
    "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
      "spirv.BranchConditional"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // 2 preds: ^bb0, ^bb2
      "spirv.Store"(%3, %1) <{alignment = 8 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<vector<3xi32>, Function>, vector<3xi32>) -> ()
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb2:  // pred: ^bb0
      "spirv.Store"(%3, %2) <{alignment = 8 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<vector<3xi32>, Function>, vector<3xi32>) -> ()
      "spirv.Branch"()[^bb1] : () -> ()
    ^bb3:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (), sym_name = "cannot_canonicalize_selection_op_3"}> ({
  ^bb0(%arg0: i1):
    %0 = "spirv.Constant"() <{value = dense<[0, 1, 2]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[1, 2, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.Constant"() <{value = dense<[2, 3, 4]> : vector<3xi32>}> : () -> vector<3xi32>
    %3 = "spirv.Variable"(%0) <{storage_class = #spirv.storage_class<Function>}> : (vector<3xi32>) -> !spirv.ptr<vector<3xi32>, Function>
    "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
      "spirv.BranchConditional"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "spirv.Store"(%3, %1) <{alignment = 8 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<vector<3xi32>, Function>, vector<3xi32>) -> ()
      "spirv.Return"() : () -> ()
    ^bb2:  // pred: ^bb0
      "spirv.Store"(%3, %2) <{alignment = 8 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<vector<3xi32>, Function>, vector<3xi32>) -> ()
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb3:  // pred: ^bb2
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (), sym_name = "cannot_canonicalize_selection_op_4"}> ({
  ^bb0(%arg0: i1):
    %0 = "spirv.Constant"() <{value = dense<[0, 1, 2]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[1, 2, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.Constant"() <{value = dense<[2, 3, 4]> : vector<3xi32>}> : () -> vector<3xi32>
    %3 = "spirv.Variable"(%0) <{storage_class = #spirv.storage_class<Function>}> : (vector<3xi32>) -> !spirv.ptr<vector<3xi32>, Function>
    "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
      "spirv.BranchConditional"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "spirv.Store"(%3, %1) <{alignment = 4 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<vector<3xi32>, Function>, vector<3xi32>) -> ()
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb2:  // pred: ^bb0
      "spirv.Store"(%3, %2) <{alignment = 8 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<vector<3xi32>, Function>, vector<3xi32>) -> ()
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb3:  // 2 preds: ^bb1, ^bb2
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

