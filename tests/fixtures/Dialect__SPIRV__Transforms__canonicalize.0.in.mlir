"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "combine_full_access_chain"}> ({
    %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.struct<(!spirv.array<4 x !spirv.array<4 x f32>>, !spirv.array<4 x i32>)>, Function>
    %2 = "spirv.AccessChain"(%1, %0) : (!spirv.ptr<!spirv.struct<(!spirv.array<4 x !spirv.array<4 x f32>>, !spirv.array<4 x i32>)>, Function>, i32) -> !spirv.ptr<!spirv.array<4 x !spirv.array<4 x f32>>, Function>
    %3 = "spirv.AccessChain"(%2, %0, %0) : (!spirv.ptr<!spirv.array<4 x !spirv.array<4 x f32>>, Function>, i32, i32) -> !spirv.ptr<f32, Function>
    %4 = "spirv.Load"(%3) : (!spirv.ptr<f32, Function>) -> f32
    "spirv.ReturnValue"(%4) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> !spirv.array<4 x f32>, sym_name = "combine_access_chain_multi_use"}> ({
    %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.struct<(!spirv.array<4 x !spirv.array<4 x f32>>, !spirv.array<4 x i32>)>, Function>
    %2 = "spirv.AccessChain"(%1, %0) : (!spirv.ptr<!spirv.struct<(!spirv.array<4 x !spirv.array<4 x f32>>, !spirv.array<4 x i32>)>, Function>, i32) -> !spirv.ptr<!spirv.array<4 x !spirv.array<4 x f32>>, Function>
    %3 = "spirv.AccessChain"(%2, %0) : (!spirv.ptr<!spirv.array<4 x !spirv.array<4 x f32>>, Function>, i32) -> !spirv.ptr<!spirv.array<4 x f32>, Function>
    %4 = "spirv.AccessChain"(%3, %0) : (!spirv.ptr<!spirv.array<4 x f32>, Function>, i32) -> !spirv.ptr<f32, Function>
    %5 = "spirv.Load"(%3) : (!spirv.ptr<!spirv.array<4 x f32>, Function>) -> !spirv.array<4 x f32>
    %6 = "spirv.Load"(%4) : (!spirv.ptr<f32, Function>) -> f32
    "spirv.ReturnValue"(%5) : (!spirv.array<4 x f32>) -> ()
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
    %0 = "spirv.Bitcast"(%arg0) : (vector<2xf32>) -> vector<2xi32>
    %1 = "spirv.Bitcast"(%0) : (vector<2xi32>) -> i64
    %2 = "spirv.Bitcast"(%1) : (i64) -> f64
    "spirv.ReturnValue"(%2) : (f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, !spirv.ptr<i64, Uniform>) -> f64, sym_name = "convert_bitcast_multi_use"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: !spirv.ptr<i64, Uniform>):
    %0 = "spirv.Bitcast"(%arg0) : (vector<2xf32>) -> i64
    %1 = "spirv.Bitcast"(%0) : (i64) -> f64
    "spirv.Store"(%arg1, %0) : (!spirv.ptr<i64, Uniform>, i64) -> ()
    "spirv.ReturnValue"(%1) : (f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64) -> i64, sym_name = "convert_bitcast_roundtip"}> ({
  ^bb0(%arg0: i64):
    %0 = "spirv.Bitcast"(%arg0) : (i64) -> f64
    %1 = "spirv.Bitcast"(%0) : (f64) -> i64
    "spirv.ReturnValue"(%1) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64) -> i64, sym_name = "convert_bitcast_chained_roundtip"}> ({
  ^bb0(%arg0: i64):
    %0 = "spirv.Bitcast"(%arg0) : (i64) -> f64
    %1 = "spirv.Bitcast"(%0) : (f64) -> vector<2xi32>
    %2 = "spirv.Bitcast"(%1) : (vector<2xi32>) -> vector<2xf32>
    %3 = "spirv.Bitcast"(%2) : (vector<2xf32>) -> i64
    "spirv.ReturnValue"(%3) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (i32, i32, i32), sym_name = "extract_vector"}> ({
    %0 = "spirv.Constant"() <{value = dense<[42, -33, 6]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.CompositeExtract"(%0) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
    %2 = "spirv.CompositeExtract"(%0) <{indices = [1 : i32]}> : (vector<3xi32>) -> i32
    %3 = "spirv.CompositeExtract"(%0) <{indices = [2 : i32]}> : (vector<3xi32>) -> i32
    "func.return"(%1, %2, %3) : (i32, i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "extract_array_final"}> ({
    %0 = "spirv.Constant"() <{value = [dense<[4, -5]> : vector<2xi32>]}> : () -> !spirv.array<1 x vector<2xi32>>
    %1 = "spirv.CompositeExtract"(%0) <{indices = [0 : i32, 0 : i32]}> : (!spirv.array<1 x vector<2xi32>>) -> i32
    %2 = "spirv.CompositeExtract"(%0) <{indices = [0 : i32, 1 : i32]}> : (!spirv.array<1 x vector<2xi32>>) -> i32
    "func.return"(%1, %2) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<2xi32>, sym_name = "extract_array_interm"}> ({
    %0 = "spirv.Constant"() <{value = [dense<[4, -5]> : vector<2xi32>]}> : () -> !spirv.array<1 x vector<2xi32>>
    %1 = "spirv.CompositeExtract"(%0) <{indices = [0 : i32]}> : (!spirv.array<1 x vector<2xi32>>) -> vector<2xi32>
    "func.return"(%1) : (vector<2xi32>) -> ()
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
    %2 = "spirv.CompositeExtract"(%0) <{indices = [0 : i32, 1 : i32]}> : (!spirv.array<1 x vector<2xf32>>) -> f32
    "func.return"(%1, %2) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf32>) -> (vector<2xf32>, vector<2xf32>), sym_name = "extract_construct"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<2xf32>):
    %0 = "spirv.CompositeConstruct"(%arg0, %arg1) : (vector<2xf32>, vector<2xf32>) -> !spirv.array<2 x vector<2xf32>>
    %1 = "spirv.CompositeExtract"(%0) <{indices = [0 : i32]}> : (!spirv.array<2 x vector<2xf32>>) -> vector<2xf32>
    %2 = "spirv.CompositeExtract"(%0) <{indices = [1 : i32]}> : (!spirv.array<2 x vector<2xf32>>) -> vector<2xf32>
    "func.return"(%1, %2) : (vector<2xf32>, vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!spirv.struct<(f32, f32)>, f32, f32) -> f32, sym_name = "fold_composite_op"}> ({
  ^bb0(%arg0: !spirv.struct<(f32, f32)>, %arg1: f32, %arg2: f32):
    %0 = "spirv.CompositeInsert"(%arg1, %arg0) <{indices = [0 : i32]}> : (f32, !spirv.struct<(f32, f32)>) -> !spirv.struct<(f32, f32)>
    %1 = "spirv.CompositeInsert"(%arg2, %0) <{indices = [1 : i32]}> : (f32, !spirv.struct<(f32, f32)>) -> !spirv.struct<(f32, f32)>
    %2 = "spirv.CompositeExtract"(%1) <{indices = [0 : i32]}> : (!spirv.struct<(f32, f32)>) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, f32) -> f32, sym_name = "fold_composite_op"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):
    %0 = "spirv.CompositeConstruct"(%arg0, %arg0, %arg0) : (f32, f32, f32) -> !spirv.struct<(f32, f32, f32)>
    %1 = "spirv.CompositeInsert"(%arg1, %0) <{indices = [1 : i32]}> : (f32, !spirv.struct<(f32, f32, f32)>) -> !spirv.struct<(f32, f32, f32)>
    %2 = "spirv.CompositeInsert"(%arg2, %1) <{indices = [2 : i32]}> : (f32, !spirv.struct<(f32, f32, f32)>) -> !spirv.struct<(f32, f32, f32)>
    %3 = "spirv.CompositeExtract"(%2) <{indices = [0 : i32]}> : (!spirv.struct<(f32, f32, f32)>) -> f32
    "func.return"(%3) : (f32) -> ()
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
    %1 = "spirv.Constant"() <{value = 42 : i32}> : () -> i32
    "func.return"(%0, %1) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (vector<3xi32>, vector<3xi32>), sym_name = "deduplicate_vector_constant"}> ({
    %0 = "spirv.Constant"() <{value = dense<[1, 2, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[1, 2, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%0, %1) : (vector<3xi32>, vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (!spirv.array<1 x vector<2xi32>>, !spirv.array<1 x vector<2xi32>>), sym_name = "deduplicate_composite_constant"}> ({
    %0 = "spirv.Constant"() <{value = [dense<5> : vector<2xi32>]}> : () -> !spirv.array<1 x vector<2xi32>>
    %1 = "spirv.Constant"() <{value = [dense<5> : vector<2xi32>]}> : () -> !spirv.array<1 x vector<2xi32>>
    "func.return"(%0, %1) : (!spirv.array<1 x vector<2xi32>>, !spirv.array<1 x vector<2xi32>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "iadd_zero"}> ({
  ^bb0(%arg1: i32):
    %20 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %21 = "spirv.IAdd"(%arg1, %20) : (i32, i32) -> i32
    %22 = "spirv.IAdd"(%20, %arg1) : (i32, i32) -> i32
    "func.return"(%21, %22) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32, i32), sym_name = "const_fold_scalar_iadd_normal"}> ({
    %15 = "spirv.Constant"() <{value = 5 : i32}> : () -> i32
    %16 = "spirv.Constant"() <{value = -8 : i32}> : () -> i32
    %17 = "spirv.IAdd"(%15, %15) : (i32, i32) -> i32
    %18 = "spirv.IAdd"(%16, %16) : (i32, i32) -> i32
    %19 = "spirv.IAdd"(%15, %16) : (i32, i32) -> i32
    "func.return"(%17, %18, %19) : (i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32, i32, i32), sym_name = "const_fold_scalar_iadd_flow"}> ({
    %5 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %6 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    %7 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    %8 = "spirv.Constant"() <{value = -2147483648 : i32}> : () -> i32
    %9 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    %10 = "spirv.Constant"() <{value = -2 : i32}> : () -> i32
    %11 = "spirv.IAdd"(%5, %7) : (i32, i32) -> i32
    %12 = "spirv.IAdd"(%6, %7) : (i32, i32) -> i32
    %13 = "spirv.IAdd"(%8, %9) : (i32, i32) -> i32
    %14 = "spirv.IAdd"(%8, %10) : (i32, i32) -> i32
    "func.return"(%11, %12, %13, %14) : (i32, i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "const_fold_vector_iadd"}> ({
    %2 = "spirv.Constant"() <{value = dense<[42, -55, 127]> : vector<3xi32>}> : () -> vector<3xi32>
    %3 = "spirv.Constant"() <{value = dense<[-3, -15, 28]> : vector<3xi32>}> : () -> vector<3xi32>
    %4 = "spirv.IAdd"(%2, %3) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%4) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "iadd_poison"}> ({
  ^bb0(%arg0: i32):
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %1 = "spirv.IAdd"(%arg0, %0) : (i32, i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> !spirv.struct<(i32, i32)>, sym_name = "iaddcarry_x_0"}> ({
  ^bb0(%arg0: i32):
    %8 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %9 = "spirv.IAddCarry"(%arg0, %8) : (i32, i32) -> !spirv.struct<(i32, i32)>
    "func.return"(%9) : (!spirv.struct<(i32, i32)>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (!spirv.struct<(i32, i32)>, !spirv.struct<(i32, i32)>), sym_name = "const_fold_scalar_iaddcarry"}> ({
    %3 = "spirv.Constant"() <{value = 5 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = -5 : i32}> : () -> i32
    %5 = "spirv.Constant"() <{value = -8 : i32}> : () -> i32
    %6 = "spirv.IAddCarry"(%3, %5) : (i32, i32) -> !spirv.struct<(i32, i32)>
    %7 = "spirv.IAddCarry"(%4, %5) : (i32, i32) -> !spirv.struct<(i32, i32)>
    "func.return"(%6, %7) : (!spirv.struct<(i32, i32)>, !spirv.struct<(i32, i32)>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>, sym_name = "const_fold_vector_iaddcarry"}> ({
    %0 = "spirv.Constant"() <{value = dense<[5, -3, -1]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[-8, -8, 1]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.IAddCarry"(%0, %1) : (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>
    "func.return"(%2) : (!spirv.struct<(vector<3xi32>, vector<3xi32>)>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "imul_zero_one"}> ({
  ^bb0(%arg0: i32):
    %16 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %17 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %18 = "spirv.IMul"(%arg0, %16) : (i32, i32) -> i32
    %19 = "spirv.IMul"(%17, %arg0) : (i32, i32) -> i32
    "func.return"(%18, %19) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32, i32), sym_name = "const_fold_scalar_imul_normal"}> ({
    %10 = "spirv.Constant"() <{value = 5 : i32}> : () -> i32
    %11 = "spirv.Constant"() <{value = -8 : i32}> : () -> i32
    %12 = "spirv.Constant"() <{value = 7 : i32}> : () -> i32
    %13 = "spirv.IMul"(%12, %10) : (i32, i32) -> i32
    %14 = "spirv.IMul"(%10, %11) : (i32, i32) -> i32
    %15 = "spirv.IMul"(%11, %12) : (i32, i32) -> i32
    "func.return"(%13, %14, %15) : (i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32, i32), sym_name = "const_fold_scalar_imul_flow"}> ({
    %3 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %5 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    %6 = "spirv.Constant"() <{value = 2147483647 : i32}> : () -> i32
    %7 = "spirv.IMul"(%3, %5) : (i32, i32) -> i32
    %8 = "spirv.IMul"(%3, %6) : (i32, i32) -> i32
    %9 = "spirv.IMul"(%6, %4) : (i32, i32) -> i32
    "func.return"(%7, %8, %9) : (i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "const_fold_vector_imul"}> ({
    %0 = "spirv.Constant"() <{value = dense<[42, -55, 127]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[-3, -15, 28]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.IMul"(%0, %1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%2) : (vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> !spirv.struct<(i32, i32)>, sym_name = "smulextended_x_0"}> ({
  ^bb0(%arg0: i32):
    %8 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %9 = "spirv.SMulExtended"(%arg0, %8) : (i32, i32) -> !spirv.struct<(i32, i32)>
    "func.return"(%9) : (!spirv.struct<(i32, i32)>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (!spirv.struct<(i32, i32)>, !spirv.struct<(i32, i32)>), sym_name = "const_fold_scalar_smulextended"}> ({
    %3 = "spirv.Constant"() <{value = 5 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = -5 : i32}> : () -> i32
    %5 = "spirv.Constant"() <{value = -8 : i32}> : () -> i32
    %6 = "spirv.SMulExtended"(%3, %5) : (i32, i32) -> !spirv.struct<(i32, i32)>
    %7 = "spirv.SMulExtended"(%4, %5) : (i32, i32) -> !spirv.struct<(i32, i32)>
    "func.return"(%6, %7) : (!spirv.struct<(i32, i32)>, !spirv.struct<(i32, i32)>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>, sym_name = "const_fold_vector_smulextended"}> ({
    %0 = "spirv.Constant"() <{value = dense<[2147483647, -5, -1]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[5, -8, 1]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.SMulExtended"(%0, %1) : (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>
    "func.return"(%2) : (!spirv.struct<(vector<3xi32>, vector<3xi32>)>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> !spirv.struct<(i32, i32)>, sym_name = "umulextended_x_0"}> ({
  ^bb0(%arg1: i32):
    %10 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %11 = "spirv.UMulExtended"(%arg1, %10) : (i32, i32) -> !spirv.struct<(i32, i32)>
    "func.return"(%11) : (!spirv.struct<(i32, i32)>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> !spirv.struct<(i32, i32)>, sym_name = "umulextended_x_1"}> ({
  ^bb0(%arg0: i32):
    %8 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %9 = "spirv.UMulExtended"(%arg0, %8) : (i32, i32) -> !spirv.struct<(i32, i32)>
    "func.return"(%9) : (!spirv.struct<(i32, i32)>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (!spirv.struct<(i32, i32)>, !spirv.struct<(i32, i32)>), sym_name = "const_fold_scalar_umulextended"}> ({
    %3 = "spirv.Constant"() <{value = 5 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = -5 : i32}> : () -> i32
    %5 = "spirv.Constant"() <{value = -8 : i32}> : () -> i32
    %6 = "spirv.UMulExtended"(%3, %5) : (i32, i32) -> !spirv.struct<(i32, i32)>
    %7 = "spirv.UMulExtended"(%4, %5) : (i32, i32) -> !spirv.struct<(i32, i32)>
    "func.return"(%6, %7) : (!spirv.struct<(i32, i32)>, !spirv.struct<(i32, i32)>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>, sym_name = "const_fold_vector_umulextended"}> ({
    %0 = "spirv.Constant"() <{value = dense<[2147483647, -5, -1]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[5, -8, 1]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.UMulExtended"(%0, %1) : (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>
    "func.return"(%2) : (!spirv.struct<(vector<3xi32>, vector<3xi32>)>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "isub_x_x"}> ({
  ^bb0(%arg1: i32):
    %20 = "spirv.ISub"(%arg1, %arg1) : (i32, i32) -> i32
    "func.return"(%20) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi32>) -> vector<3xi32>, sym_name = "isub_vector_x_x"}> ({
  ^bb0(%arg0: vector<3xi32>):
    %19 = "spirv.ISub"(%arg0, %arg0) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%19) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32, i32), sym_name = "const_fold_scalar_isub_normal"}> ({
    %13 = "spirv.Constant"() <{value = 5 : i32}> : () -> i32
    %14 = "spirv.Constant"() <{value = -8 : i32}> : () -> i32
    %15 = "spirv.Constant"() <{value = 7 : i32}> : () -> i32
    %16 = "spirv.ISub"(%15, %13) : (i32, i32) -> i32
    %17 = "spirv.ISub"(%13, %14) : (i32, i32) -> i32
    %18 = "spirv.ISub"(%14, %15) : (i32, i32) -> i32
    "func.return"(%16, %17, %18) : (i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32, i32, i32), sym_name = "const_fold_scalar_isub_flow"}> ({
    %3 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %5 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    %6 = "spirv.Constant"() <{value = 2147483647 : i32}> : () -> i32
    %7 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    %8 = "spirv.Constant"() <{value = -2 : i32}> : () -> i32
    %9 = "spirv.ISub"(%3, %5) : (i32, i32) -> i32
    %10 = "spirv.ISub"(%4, %5) : (i32, i32) -> i32
    %11 = "spirv.ISub"(%7, %6) : (i32, i32) -> i32
    %12 = "spirv.ISub"(%8, %6) : (i32, i32) -> i32
    "func.return"(%9, %10, %11, %12) : (i32, i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "const_fold_vector_isub"}> ({
    %0 = "spirv.Constant"() <{value = dense<[42, -55, 127]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[-3, -15, 28]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.ISub"(%0, %1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%2) : (vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "sdiv_x_1"}> ({
  ^bb0(%arg0: i32):
    %17 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %18 = "spirv.SDiv"(%arg0, %17) : (i32, i32) -> i32
    "func.return"(%18) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "sdiv_div_0_or_overflow"}> ({
    %12 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %13 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    %14 = "spirv.Constant"() <{value = -2147483648 : i32}> : () -> i32
    %15 = "spirv.SDiv"(%13, %12) : (i32, i32) -> i32
    %16 = "spirv.SDiv"(%14, %13) : (i32, i32) -> i32
    "func.return"(%15, %16) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32, i32, i32), sym_name = "const_fold_scalar_sdiv"}> ({
    %3 = "spirv.Constant"() <{value = 56 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = 7 : i32}> : () -> i32
    %5 = "spirv.Constant"() <{value = -8 : i32}> : () -> i32
    %6 = "spirv.Constant"() <{value = 3 : i32}> : () -> i32
    %7 = "spirv.Constant"() <{value = -3 : i32}> : () -> i32
    %8 = "spirv.SDiv"(%3, %4) : (i32, i32) -> i32
    %9 = "spirv.SDiv"(%3, %5) : (i32, i32) -> i32
    %10 = "spirv.SDiv"(%5, %6) : (i32, i32) -> i32
    %11 = "spirv.SDiv"(%3, %7) : (i32, i32) -> i32
    "func.return"(%8, %9, %10, %11) : (i32, i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "const_fold_vector_sdiv"}> ({
    %0 = "spirv.Constant"() <{value = dense<[42, 24, -16]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[76, -24, 5]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.SDiv"(%0, %1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%2) : (vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "smod_x_1"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %24 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %25 = "spirv.Constant"() <{value = dense<1> : vector<3xi32>}> : () -> vector<3xi32>
    %26 = "spirv.SMod"(%arg0, %24) : (i32, i32) -> i32
    %27 = "spirv.SMod"(%arg1, %25) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%26, %27) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "smod_div_0_or_overflow"}> ({
    %19 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %20 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    %21 = "spirv.Constant"() <{value = -2147483648 : i32}> : () -> i32
    %22 = "spirv.SMod"(%20, %19) : (i32, i32) -> i32
    %23 = "spirv.SMod"(%21, %20) : (i32, i32) -> i32
    "func.return"(%22, %23) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32, i32, i32, i32, i32, i32, i32), sym_name = "const_fold_scalar_smod"}> ({
    %3 = "spirv.Constant"() <{value = 56 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = -56 : i32}> : () -> i32
    %5 = "spirv.Constant"() <{value = 59 : i32}> : () -> i32
    %6 = "spirv.Constant"() <{value = -59 : i32}> : () -> i32
    %7 = "spirv.Constant"() <{value = 7 : i32}> : () -> i32
    %8 = "spirv.Constant"() <{value = -8 : i32}> : () -> i32
    %9 = "spirv.Constant"() <{value = 3 : i32}> : () -> i32
    %10 = "spirv.Constant"() <{value = -3 : i32}> : () -> i32
    %11 = "spirv.SMod"(%3, %7) : (i32, i32) -> i32
    %12 = "spirv.SMod"(%3, %8) : (i32, i32) -> i32
    %13 = "spirv.SMod"(%3, %9) : (i32, i32) -> i32
    %14 = "spirv.SMod"(%10, %3) : (i32, i32) -> i32
    %15 = "spirv.SMod"(%10, %4) : (i32, i32) -> i32
    %16 = "spirv.SMod"(%5, %3) : (i32, i32) -> i32
    %17 = "spirv.SMod"(%5, %4) : (i32, i32) -> i32
    %18 = "spirv.SMod"(%6, %4) : (i32, i32) -> i32
    "func.return"(%11, %12, %13, %14, %15, %16, %17, %18) : (i32, i32, i32, i32, i32, i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "const_fold_vector_smod"}> ({
    %0 = "spirv.Constant"() <{value = dense<[42, 24, -16]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[76, -7, 5]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.SMod"(%0, %1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%2) : (vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "srem_x_1"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %15 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %16 = "spirv.Constant"() <{value = dense<1> : vector<3xi32>}> : () -> vector<3xi32>
    %17 = "spirv.SRem"(%arg0, %15) : (i32, i32) -> i32
    %18 = "spirv.SRem"(%arg1, %16) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%17, %18) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "srem_div_0_or_overflow"}> ({
    %10 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %11 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    %12 = "spirv.Constant"() <{value = -2147483648 : i32}> : () -> i32
    %13 = "spirv.SRem"(%11, %10) : (i32, i32) -> i32
    %14 = "spirv.SRem"(%12, %11) : (i32, i32) -> i32
    "func.return"(%13, %14) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32, i32, i32, i32), sym_name = "const_fold_scalar_srem"}> ({
    %0 = "spirv.Constant"() <{value = 56 : i32}> : () -> i32
    %1 = "spirv.Constant"() <{value = 7 : i32}> : () -> i32
    %2 = "spirv.Constant"() <{value = -8 : i32}> : () -> i32
    %3 = "spirv.Constant"() <{value = 3 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = -3 : i32}> : () -> i32
    %5 = "spirv.SRem"(%0, %1) : (i32, i32) -> i32
    %6 = "spirv.SRem"(%0, %2) : (i32, i32) -> i32
    %7 = "spirv.SRem"(%0, %3) : (i32, i32) -> i32
    %8 = "spirv.SRem"(%4, %0) : (i32, i32) -> i32
    %9 = "spirv.SRem"(%1, %4) : (i32, i32) -> i32
    "func.return"(%5, %6, %7, %8, %9) : (i32, i32, i32, i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "udiv_x_1"}> ({
  ^bb0(%arg0: i32):
    %10 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %11 = "spirv.UDiv"(%arg0, %10) : (i32, i32) -> i32
    "func.return"(%11) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "udiv_div_0"}> ({
    %7 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %8 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    %9 = "spirv.UDiv"(%8, %7) : (i32, i32) -> i32
    "func.return"(%9) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32, i32), sym_name = "const_fold_scalar_udiv"}> ({
    %0 = "spirv.Constant"() <{value = 56 : i32}> : () -> i32
    %1 = "spirv.Constant"() <{value = 7 : i32}> : () -> i32
    %2 = "spirv.Constant"() <{value = -8 : i32}> : () -> i32
    %3 = "spirv.Constant"() <{value = 3 : i32}> : () -> i32
    %4 = "spirv.UDiv"(%0, %1) : (i32, i32) -> i32
    %5 = "spirv.UDiv"(%2, %3) : (i32, i32) -> i32
    %6 = "spirv.UDiv"(%0, %2) : (i32, i32) -> i32
    "func.return"(%4, %5, %6) : (i32, i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "umod_x_1"}> ({
  ^bb0(%arg7: i32, %arg8: vector<3xi32>):
    %41 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %42 = "spirv.Constant"() <{value = dense<1> : vector<3xi32>}> : () -> vector<3xi32>
    %43 = "spirv.UMod"(%arg7, %41) : (i32, i32) -> i32
    %44 = "spirv.UMod"(%arg8, %42) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%43, %44) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "umod_div_0"}> ({
    %38 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %39 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    %40 = "spirv.UMod"(%39, %38) : (i32, i32) -> i32
    "func.return"(%40) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32, i32), sym_name = "const_fold_scalar_umod"}> ({
    %31 = "spirv.Constant"() <{value = 56 : i32}> : () -> i32
    %32 = "spirv.Constant"() <{value = 7 : i32}> : () -> i32
    %33 = "spirv.Constant"() <{value = -8 : i32}> : () -> i32
    %34 = "spirv.Constant"() <{value = 3 : i32}> : () -> i32
    %35 = "spirv.UMod"(%31, %32) : (i32, i32) -> i32
    %36 = "spirv.UMod"(%33, %34) : (i32, i32) -> i32
    %37 = "spirv.UMod"(%31, %33) : (i32, i32) -> i32
    "func.return"(%35, %36, %37) : (i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "const_fold_vector_umod"}> ({
    %28 = "spirv.Constant"() <{value = dense<[42, 24, -16]> : vector<3xi32>}> : () -> vector<3xi32>
    %29 = "spirv.Constant"() <{value = dense<[76, -7, 5]> : vector<3xi32>}> : () -> vector<3xi32>
    %30 = "spirv.UMod"(%28, %29) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%30) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "umod_fold"}> ({
  ^bb0(%arg6: i32):
    %24 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
    %25 = "spirv.UMod"(%arg6, %24) : (i32, i32) -> i32
    %26 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %27 = "spirv.UMod"(%25, %26) : (i32, i32) -> i32
    "func.return"(%25, %27) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> (vector<4xi32>, vector<4xi32>), sym_name = "umod_vector_fold"}> ({
  ^bb0(%arg5: vector<4xi32>):
    %20 = "spirv.Constant"() <{value = dense<32> : vector<4xi32>}> : () -> vector<4xi32>
    %21 = "spirv.UMod"(%arg5, %20) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %22 = "spirv.Constant"() <{value = dense<4> : vector<4xi32>}> : () -> vector<4xi32>
    %23 = "spirv.UMod"(%21, %22) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"(%21, %23) : (vector<4xi32>, vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "umod_fold_same_divisor"}> ({
  ^bb0(%arg4: i32):
    %16 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
    %17 = "spirv.UMod"(%arg4, %16) : (i32, i32) -> i32
    %18 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
    %19 = "spirv.UMod"(%17, %18) : (i32, i32) -> i32
    "func.return"(%17, %19) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "umod_fail_1_fold"}> ({
  ^bb0(%arg3: i32):
    %12 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
    %13 = "spirv.UMod"(%arg3, %12) : (i32, i32) -> i32
    %14 = "spirv.Constant"() <{value = 5 : i32}> : () -> i32
    %15 = "spirv.UMod"(%13, %14) : (i32, i32) -> i32
    "func.return"(%13, %15) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "umod_fail_2_fold"}> ({
  ^bb0(%arg2: i32):
    %8 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %9 = "spirv.UMod"(%arg2, %8) : (i32, i32) -> i32
    %10 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
    %11 = "spirv.UMod"(%9, %10) : (i32, i32) -> i32
    "func.return"(%9, %11) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> (vector<4xi32>, vector<4xi32>), sym_name = "umod_vector_fail_1_fold"}> ({
  ^bb0(%arg1: vector<4xi32>):
    %4 = "spirv.Constant"() <{value = dense<64> : vector<4xi32>}> : () -> vector<4xi32>
    %5 = "spirv.UMod"(%arg1, %4) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %6 = "spirv.Constant"() <{value = dense<9> : vector<4xi32>}> : () -> vector<4xi32>
    %7 = "spirv.UMod"(%5, %6) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"(%5, %7) : (vector<4xi32>, vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> (vector<4xi32>, vector<4xi32>), sym_name = "umod_vector_fail_2_fold"}> ({
  ^bb0(%arg0: vector<4xi32>):
    %0 = "spirv.Constant"() <{value = dense<4> : vector<4xi32>}> : () -> vector<4xi32>
    %1 = "spirv.UMod"(%arg0, %0) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %2 = "spirv.Constant"() <{value = dense<32> : vector<4xi32>}> : () -> vector<4xi32>
    %3 = "spirv.UMod"(%1, %2) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"(%1, %3) : (vector<4xi32>, vector<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "snegate_twice"}> ({
  ^bb0(%arg0: i32):
    %11 = "spirv.SNegate"(%arg0) : (i32) -> i32
    %12 = "spirv.SNegate"(%11) : (i32) -> i32
    "func.return"(%12) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i8, i8), sym_name = "snegate_min"}> ({
    %8 = "spirv.Constant"() <{value = -128 : i8}> : () -> i8
    %9 = "spirv.SNegate"(%8) : (i8) -> i8
    %10 = "spirv.SNegate"(%9) : (i8) -> i8
    "func.return"(%9, %10) : (i8, i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32, i32), sym_name = "const_fold_scalar_snegate"}> ({
    %2 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %3 = "spirv.Constant"() <{value = 3 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = -3 : i32}> : () -> i32
    %5 = "spirv.SNegate"(%2) : (i32) -> i32
    %6 = "spirv.SNegate"(%3) : (i32) -> i32
    %7 = "spirv.SNegate"(%4) : (i32) -> i32
    "func.return"(%5, %6, %7) : (i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "const_fold_vector_snegate"}> ({
    %0 = "spirv.Constant"() <{value = dense<[0, -3, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.SNegate"(%0) : (vector<3xi32>) -> vector<3xi32>
    "func.return"(%1) : (vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "not_twice"}> ({
  ^bb0(%arg0: i32):
    %8 = "spirv.Not"(%arg0) : (i32) -> i32
    %9 = "spirv.Not"(%8) : (i32) -> i32
    "func.return"(%9) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32, i32), sym_name = "const_fold_scalar_not"}> ({
    %2 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %3 = "spirv.Constant"() <{value = 3 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = -3 : i32}> : () -> i32
    %5 = "spirv.Not"(%2) : (i32) -> i32
    %6 = "spirv.Not"(%3) : (i32) -> i32
    %7 = "spirv.Not"(%4) : (i32) -> i32
    "func.return"(%5, %6, %7) : (i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "const_fold_vector_not"}> ({
    %0 = "spirv.Constant"() <{value = dense<[-1, -4, 2]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Not"(%0) : (vector<3xi32>) -> vector<3xi32>
    "func.return"(%1) : (vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (i1, i1), sym_name = "convert_logical_and_true_false_scalar"}> ({
  ^bb0(%arg1: i1):
    %4 = "spirv.Constant"() <{value = true}> : () -> i1
    %5 = "spirv.Constant"() <{value = false}> : () -> i1
    %6 = "spirv.LogicalAnd"(%4, %arg1) : (i1, i1) -> i1
    %7 = "spirv.LogicalAnd"(%arg1, %5) : (i1, i1) -> i1
    "func.return"(%6, %7) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi1>) -> (vector<3xi1>, vector<3xi1>), sym_name = "convert_logical_and_true_false_vector"}> ({
  ^bb0(%arg0: vector<3xi1>):
    %0 = "spirv.Constant"() <{value = dense<true> : vector<3xi1>}> : () -> vector<3xi1>
    %1 = "spirv.Constant"() <{value = dense<false> : vector<3xi1>}> : () -> vector<3xi1>
    %2 = "spirv.LogicalAnd"(%0, %arg0) : (vector<3xi1>, vector<3xi1>) -> vector<3xi1>
    %3 = "spirv.LogicalAnd"(%arg0, %1) : (vector<3xi1>, vector<3xi1>) -> vector<3xi1>
    "func.return"(%2, %3) : (vector<3xi1>, vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i1, sym_name = "logical_not_twice"}> ({
  ^bb0(%arg0: i1):
    %4 = "spirv.LogicalNot"(%arg0) : (i1) -> i1
    %5 = "spirv.LogicalNot"(%4) : (i1) -> i1
    "func.return"(%5) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i1, sym_name = "const_fold_scalar_logical_not"}> ({
    %2 = "spirv.Constant"() <{value = true}> : () -> i1
    %3 = "spirv.LogicalNot"(%2) : (i1) -> i1
    "func.return"(%3) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<2xi1>, sym_name = "const_fold_vector_logical_not"}> ({
    %0 = "spirv.Constant"() <{value = dense<[true, false]> : vector<2xi1>}> : () -> vector<2xi1>
    %1 = "spirv.LogicalNot"(%0) : (vector<2xi1>) -> vector<2xi1>
    "func.return"(%1) : (vector<2xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xi64>, vector<3xi64>) -> vector<3xi1>, sym_name = "convert_logical_not_to_not_equal"}> ({
  ^bb0(%arg0: vector<3xi64>, %arg1: vector<3xi64>):
    %0 = "spirv.IEqual"(%arg0, %arg1) : (vector<3xi64>, vector<3xi64>) -> vector<3xi1>
    %1 = "spirv.LogicalNot"(%0) : (vector<3xi1>) -> vector<3xi1>
    "spirv.ReturnValue"(%1) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, vector<3xi1>) -> (i1, vector<3xi1>), sym_name = "logical_equal_same"}> ({
  ^bb0(%arg0: i1, %arg1: vector<3xi1>):
    %7 = "spirv.LogicalEqual"(%arg0, %arg0) : (i1, i1) -> i1
    %8 = "spirv.LogicalEqual"(%arg1, %arg1) : (vector<3xi1>, vector<3xi1>) -> vector<3xi1>
    "func.return"(%7, %8) : (i1, vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i1, i1), sym_name = "const_fold_scalar_logical_equal"}> ({
    %3 = "spirv.Constant"() <{value = true}> : () -> i1
    %4 = "spirv.Constant"() <{value = false}> : () -> i1
    %5 = "spirv.LogicalEqual"(%3, %4) : (i1, i1) -> i1
    %6 = "spirv.LogicalEqual"(%4, %4) : (i1, i1) -> i1
    "func.return"(%5, %6) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "const_fold_vector_logical_equal"}> ({
    %0 = "spirv.Constant"() <{value = dense<[true, false, true]> : vector<3xi1>}> : () -> vector<3xi1>
    %1 = "spirv.Constant"() <{value = dense<[true, false, false]> : vector<3xi1>}> : () -> vector<3xi1>
    %2 = "spirv.LogicalEqual"(%0, %1) : (vector<3xi1>, vector<3xi1>) -> vector<3xi1>
    "func.return"(%2) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi1>) -> vector<4xi1>, sym_name = "convert_logical_not_equal_false"}> ({
  ^bb0(%arg2: vector<4xi1>):
    %9 = "spirv.Constant"() <{value = dense<false> : vector<4xi1>}> : () -> vector<4xi1>
    %10 = "spirv.LogicalNotEqual"(%arg2, %9) : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    "spirv.ReturnValue"(%10) : (vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, vector<3xi1>) -> (i1, vector<3xi1>), sym_name = "logical_not_equal_same"}> ({
  ^bb0(%arg0: i1, %arg1: vector<3xi1>):
    %7 = "spirv.LogicalNotEqual"(%arg0, %arg0) : (i1, i1) -> i1
    %8 = "spirv.LogicalNotEqual"(%arg1, %arg1) : (vector<3xi1>, vector<3xi1>) -> vector<3xi1>
    "func.return"(%7, %8) : (i1, vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i1, i1), sym_name = "const_fold_scalar_logical_not_equal"}> ({
    %3 = "spirv.Constant"() <{value = true}> : () -> i1
    %4 = "spirv.Constant"() <{value = false}> : () -> i1
    %5 = "spirv.LogicalNotEqual"(%3, %4) : (i1, i1) -> i1
    %6 = "spirv.LogicalNotEqual"(%4, %4) : (i1, i1) -> i1
    "func.return"(%5, %6) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "const_fold_vector_logical_not_equal"}> ({
    %0 = "spirv.Constant"() <{value = dense<[true, false, true]> : vector<3xi1>}> : () -> vector<3xi1>
    %1 = "spirv.Constant"() <{value = dense<[true, false, false]> : vector<3xi1>}> : () -> vector<3xi1>
    %2 = "spirv.LogicalNotEqual"(%0, %1) : (vector<3xi1>, vector<3xi1>) -> vector<3xi1>
    "func.return"(%2) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xi64>, vector<3xi64>) -> vector<3xi1>, sym_name = "convert_logical_not_to_equal"}> ({
  ^bb0(%arg0: vector<3xi64>, %arg1: vector<3xi64>):
    %0 = "spirv.INotEqual"(%arg0, %arg1) : (vector<3xi64>, vector<3xi64>) -> vector<3xi1>
    %1 = "spirv.LogicalNot"(%0) : (vector<3xi1>) -> vector<3xi1>
    "spirv.ReturnValue"(%1) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xi64>, vector<3xi64>, !spirv.ptr<vector<3xi1>, Uniform>) -> vector<3xi1>, sym_name = "convert_logical_not_parent_multi_use"}> ({
  ^bb0(%arg0: vector<3xi64>, %arg1: vector<3xi64>, %arg2: !spirv.ptr<vector<3xi1>, Uniform>):
    %0 = "spirv.INotEqual"(%arg0, %arg1) : (vector<3xi64>, vector<3xi64>) -> vector<3xi1>
    %1 = "spirv.LogicalNot"(%0) : (vector<3xi1>) -> vector<3xi1>
    "spirv.Store"(%arg2, %0) : (!spirv.ptr<vector<3xi1>, Uniform>, vector<3xi1>) -> ()
    "spirv.ReturnValue"(%1) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xi1>, vector<3xi1>) -> vector<3xi1>, sym_name = "convert_logical_not_to_logical_not_equal"}> ({
  ^bb0(%arg0: vector<3xi1>, %arg1: vector<3xi1>):
    %0 = "spirv.LogicalEqual"(%arg0, %arg1) : (vector<3xi1>, vector<3xi1>) -> vector<3xi1>
    %1 = "spirv.LogicalNot"(%0) : (vector<3xi1>) -> vector<3xi1>
    "spirv.ReturnValue"(%1) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xi1>, vector<3xi1>) -> vector<3xi1>, sym_name = "convert_logical_not_to_logical_equal"}> ({
  ^bb0(%arg0: vector<3xi1>, %arg1: vector<3xi1>):
    %0 = "spirv.LogicalNotEqual"(%arg0, %arg1) : (vector<3xi1>, vector<3xi1>) -> vector<3xi1>
    %1 = "spirv.LogicalNot"(%0) : (vector<3xi1>) -> vector<3xi1>
    "spirv.ReturnValue"(%1) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (i1, i1), sym_name = "convert_logical_or_true_false_scalar"}> ({
  ^bb0(%arg1: i1):
    %4 = "spirv.Constant"() <{value = true}> : () -> i1
    %5 = "spirv.Constant"() <{value = false}> : () -> i1
    %6 = "spirv.LogicalOr"(%4, %arg1) : (i1, i1) -> i1
    %7 = "spirv.LogicalOr"(%arg1, %5) : (i1, i1) -> i1
    "func.return"(%6, %7) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi1>) -> (vector<3xi1>, vector<3xi1>), sym_name = "convert_logical_or_true_false_vector"}> ({
  ^bb0(%arg0: vector<3xi1>):
    %0 = "spirv.Constant"() <{value = dense<true> : vector<3xi1>}> : () -> vector<3xi1>
    %1 = "spirv.Constant"() <{value = dense<false> : vector<3xi1>}> : () -> vector<3xi1>
    %2 = "spirv.LogicalOr"(%0, %arg0) : (vector<3xi1>, vector<3xi1>) -> vector<3xi1>
    %3 = "spirv.LogicalOr"(%arg0, %1) : (vector<3xi1>, vector<3xi1>) -> vector<3xi1>
    "func.return"(%2, %3) : (vector<3xi1>, vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (i32, i32), sym_name = "convert_select_scalar"}> ({
  ^bb0(%arg4: i32, %arg5: i32):
    %9 = "spirv.Constant"() <{value = true}> : () -> i1
    %10 = "spirv.Constant"() <{value = false}> : () -> i1
    %11 = "spirv.Select"(%9, %arg4, %arg5) : (i1, i32, i32) -> i32
    %12 = "spirv.Select"(%10, %arg4, %arg5) : (i1, i32, i32) -> i32
    "func.return"(%11, %12) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi32>, vector<3xi32>) -> (vector<3xi32>, vector<3xi32>), sym_name = "convert_select_vector"}> ({
  ^bb0(%arg2: vector<3xi32>, %arg3: vector<3xi32>):
    %5 = "spirv.Constant"() <{value = dense<true> : vector<3xi1>}> : () -> vector<3xi1>
    %6 = "spirv.Constant"() <{value = dense<false> : vector<3xi1>}> : () -> vector<3xi1>
    %7 = "spirv.Select"(%5, %arg2, %arg3) : (vector<3xi1>, vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    %8 = "spirv.Select"(%6, %arg2, %arg3) : (vector<3xi1>, vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%7, %8) : (vector<3xi32>, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi1>, vector<2xi32>) -> (vector<2xi32>, vector<2xi32>), sym_name = "convert_select_vector_extra"}> ({
  ^bb0(%arg0: vector<2xi1>, %arg1: vector<2xi32>):
    %0 = "spirv.Constant"() <{value = dense<[true, false]> : vector<2xi1>}> : () -> vector<2xi1>
    %1 = "spirv.Constant"() <{value = dense<[42, -132]> : vector<2xi32>}> : () -> vector<2xi32>
    %2 = "spirv.Constant"() <{value = dense<[0, 42]> : vector<2xi32>}> : () -> vector<2xi32>
    %3 = "spirv.Select"(%0, %1, %2) : (vector<2xi1>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %4 = "spirv.Select"(%arg0, %arg1, %arg1) : (vector<2xi1>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "func.return"(%3, %4) : (vector<2xi32>, vector<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i1, vector<3xi1>), sym_name = "iequal_same"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %7 = "spirv.IEqual"(%arg0, %arg0) : (i32, i32) -> i1
    %8 = "spirv.IEqual"(%arg1, %arg1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    "func.return"(%7, %8) : (i1, vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i1, i1), sym_name = "const_fold_scalar_iequal"}> ({
    %3 = "spirv.Constant"() <{value = 5 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = 6 : i32}> : () -> i32
    %5 = "spirv.IEqual"(%3, %4) : (i32, i32) -> i1
    %6 = "spirv.IEqual"(%3, %3) : (i32, i32) -> i1
    "func.return"(%5, %6) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "const_fold_vector_iequal"}> ({
    %0 = "spirv.Constant"() <{value = dense<[-1, -4, 2]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[-1, -3, 2]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.IEqual"(%0, %1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    "func.return"(%2) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i1, vector<3xi1>), sym_name = "inotequal_same"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %7 = "spirv.INotEqual"(%arg0, %arg0) : (i32, i32) -> i1
    %8 = "spirv.INotEqual"(%arg1, %arg1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    "func.return"(%7, %8) : (i1, vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i1, i1), sym_name = "const_fold_scalar_inotequal"}> ({
    %3 = "spirv.Constant"() <{value = 5 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = 6 : i32}> : () -> i32
    %5 = "spirv.INotEqual"(%3, %4) : (i32, i32) -> i1
    %6 = "spirv.INotEqual"(%3, %3) : (i32, i32) -> i1
    "func.return"(%5, %6) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "const_fold_vector_inotequal"}> ({
    %0 = "spirv.Constant"() <{value = dense<[-1, -4, 2]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[-1, -3, 2]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.INotEqual"(%0, %1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    "func.return"(%2) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i1, vector<3xi1>), sym_name = "sgt_same"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %8 = "spirv.SGreaterThan"(%arg0, %arg0) : (i32, i32) -> i1
    %9 = "spirv.SGreaterThan"(%arg1, %arg1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    "func.return"(%8, %9) : (i1, vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i1, i1), sym_name = "const_fold_scalar_sgt"}> ({
    %3 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = 5 : i32}> : () -> i32
    %5 = "spirv.Constant"() <{value = 6 : i32}> : () -> i32
    %6 = "spirv.SGreaterThan"(%4, %5) : (i32, i32) -> i1
    %7 = "spirv.SGreaterThan"(%4, %3) : (i32, i32) -> i1
    "func.return"(%6, %7) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "const_fold_vector_sgt"}> ({
    %0 = "spirv.Constant"() <{value = dense<[-1, -4, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[-1, -3, 2]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.SGreaterThan"(%0, %1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    "func.return"(%2) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i1, vector<3xi1>), sym_name = "sge_same"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %8 = "spirv.SGreaterThanEqual"(%arg0, %arg0) : (i32, i32) -> i1
    %9 = "spirv.SGreaterThanEqual"(%arg1, %arg1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    "func.return"(%8, %9) : (i1, vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i1, i1), sym_name = "const_fold_scalar_sge"}> ({
    %3 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = 5 : i32}> : () -> i32
    %5 = "spirv.Constant"() <{value = 6 : i32}> : () -> i32
    %6 = "spirv.SGreaterThanEqual"(%4, %5) : (i32, i32) -> i1
    %7 = "spirv.SGreaterThanEqual"(%4, %3) : (i32, i32) -> i1
    "func.return"(%6, %7) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "const_fold_vector_sge"}> ({
    %0 = "spirv.Constant"() <{value = dense<[-1, -4, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[-1, -3, 2]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.SGreaterThanEqual"(%0, %1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    "func.return"(%2) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i1, vector<3xi1>), sym_name = "ugt_same"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %8 = "spirv.UGreaterThan"(%arg0, %arg0) : (i32, i32) -> i1
    %9 = "spirv.UGreaterThan"(%arg1, %arg1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    "func.return"(%8, %9) : (i1, vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i1, i1), sym_name = "const_fold_scalar_ugt"}> ({
    %3 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = 5 : i32}> : () -> i32
    %5 = "spirv.Constant"() <{value = -6 : i32}> : () -> i32
    %6 = "spirv.UGreaterThan"(%4, %5) : (i32, i32) -> i1
    %7 = "spirv.UGreaterThan"(%4, %3) : (i32, i32) -> i1
    "func.return"(%6, %7) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "const_fold_vector_ugt"}> ({
    %0 = "spirv.Constant"() <{value = dense<[-1, -4, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[-1, -3, 2]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.UGreaterThan"(%0, %1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    "func.return"(%2) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i1, vector<3xi1>), sym_name = "uge_same"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %8 = "spirv.UGreaterThanEqual"(%arg0, %arg0) : (i32, i32) -> i1
    %9 = "spirv.UGreaterThanEqual"(%arg1, %arg1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    "func.return"(%8, %9) : (i1, vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i1, i1), sym_name = "const_fold_scalar_uge"}> ({
    %3 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = 5 : i32}> : () -> i32
    %5 = "spirv.Constant"() <{value = -6 : i32}> : () -> i32
    %6 = "spirv.UGreaterThanEqual"(%4, %5) : (i32, i32) -> i1
    %7 = "spirv.UGreaterThanEqual"(%4, %3) : (i32, i32) -> i1
    "func.return"(%6, %7) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "const_fold_vector_uge"}> ({
    %0 = "spirv.Constant"() <{value = dense<[-1, -4, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[-1, -3, 2]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.UGreaterThanEqual"(%0, %1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    "func.return"(%2) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i1, vector<3xi1>), sym_name = "slt_same"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %8 = "spirv.SLessThan"(%arg0, %arg0) : (i32, i32) -> i1
    %9 = "spirv.SLessThan"(%arg1, %arg1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    "func.return"(%8, %9) : (i1, vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i1, i1), sym_name = "const_fold_scalar_slt"}> ({
    %3 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = 5 : i32}> : () -> i32
    %5 = "spirv.Constant"() <{value = 6 : i32}> : () -> i32
    %6 = "spirv.SLessThan"(%4, %5) : (i32, i32) -> i1
    %7 = "spirv.SLessThan"(%4, %3) : (i32, i32) -> i1
    "func.return"(%6, %7) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "const_fold_vector_slt"}> ({
    %0 = "spirv.Constant"() <{value = dense<[-1, -4, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[-1, -3, 2]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.SLessThan"(%0, %1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    "func.return"(%2) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i1, vector<3xi1>), sym_name = "sle_same"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %8 = "spirv.SLessThanEqual"(%arg0, %arg0) : (i32, i32) -> i1
    %9 = "spirv.SLessThanEqual"(%arg1, %arg1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    "func.return"(%8, %9) : (i1, vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i1, i1), sym_name = "const_fold_scalar_sle"}> ({
    %3 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = 5 : i32}> : () -> i32
    %5 = "spirv.Constant"() <{value = 6 : i32}> : () -> i32
    %6 = "spirv.SLessThanEqual"(%4, %5) : (i32, i32) -> i1
    %7 = "spirv.SLessThanEqual"(%4, %3) : (i32, i32) -> i1
    "func.return"(%6, %7) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "const_fold_vector_sle"}> ({
    %0 = "spirv.Constant"() <{value = dense<[-1, -4, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[-1, -3, 2]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.SLessThanEqual"(%0, %1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    "func.return"(%2) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i1, vector<3xi1>), sym_name = "ult_same"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %8 = "spirv.ULessThan"(%arg0, %arg0) : (i32, i32) -> i1
    %9 = "spirv.ULessThan"(%arg1, %arg1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    "func.return"(%8, %9) : (i1, vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i1, i1), sym_name = "const_fold_scalar_ult"}> ({
    %3 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = 5 : i32}> : () -> i32
    %5 = "spirv.Constant"() <{value = -6 : i32}> : () -> i32
    %6 = "spirv.ULessThan"(%4, %5) : (i32, i32) -> i1
    %7 = "spirv.ULessThan"(%4, %3) : (i32, i32) -> i1
    "func.return"(%6, %7) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "const_fold_vector_ult"}> ({
    %0 = "spirv.Constant"() <{value = dense<[-1, -4, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[-1, -3, 2]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.ULessThan"(%0, %1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    "func.return"(%2) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i1, vector<3xi1>), sym_name = "ule_same"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %8 = "spirv.ULessThanEqual"(%arg0, %arg0) : (i32, i32) -> i1
    %9 = "spirv.ULessThanEqual"(%arg1, %arg1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    "func.return"(%8, %9) : (i1, vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i1, i1), sym_name = "const_fold_scalar_ule"}> ({
    %3 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = 5 : i32}> : () -> i32
    %5 = "spirv.Constant"() <{value = -6 : i32}> : () -> i32
    %6 = "spirv.ULessThanEqual"(%4, %5) : (i32, i32) -> i1
    %7 = "spirv.ULessThanEqual"(%4, %3) : (i32, i32) -> i1
    "func.return"(%6, %7) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "const_fold_vector_ule"}> ({
    %0 = "spirv.Constant"() <{value = dense<[-1, -4, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[-1, -3, 2]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.ULessThanEqual"(%0, %1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    "func.return"(%2) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "lsl_x_0"}> ({
  ^bb0(%arg2: i32, %arg3: vector<3xi32>):
    %10 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %11 = "spirv.Constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
    %12 = "spirv.ShiftLeftLogical"(%arg2, %10) : (i32, i32) -> i32
    %13 = "spirv.ShiftLeftLogical"(%arg3, %11) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%12, %13) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "lsl_shift_overflow"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %6 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
    %7 = "spirv.Constant"() <{value = dense<[6, 18, 128]> : vector<3xi32>}> : () -> vector<3xi32>
    %8 = "spirv.ShiftLeftLogical"(%arg0, %6) : (i32, i32) -> i32
    %9 = "spirv.ShiftLeftLogical"(%arg1, %7) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%8, %9) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "const_fold_scalar_lsl"}> ({
    %3 = "spirv.Constant"() <{value = 65535 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = 17 : i32}> : () -> i32
    %5 = "spirv.ShiftLeftLogical"(%3, %4) : (i32, i32) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "const_fold_vector_lsl"}> ({
    %0 = "spirv.Constant"() <{value = dense<[1, -1, 127]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[31, 16, 13]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.ShiftLeftLogical"(%0, %1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%2) : (vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "asr_x_0"}> ({
  ^bb0(%arg2: i32, %arg3: vector<3xi32>):
    %10 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %11 = "spirv.Constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
    %12 = "spirv.ShiftRightArithmetic"(%arg2, %10) : (i32, i32) -> i32
    %13 = "spirv.ShiftRightArithmetic"(%arg3, %11) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%12, %13) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "asr_shift_overflow"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %6 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
    %7 = "spirv.Constant"() <{value = dense<[6, 18, 128]> : vector<3xi32>}> : () -> vector<3xi32>
    %8 = "spirv.ShiftRightArithmetic"(%arg0, %6) : (i32, i32) -> i32
    %9 = "spirv.ShiftRightArithmetic"(%arg1, %7) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%8, %9) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "const_fold_scalar_asr"}> ({
    %3 = "spirv.Constant"() <{value = -131072 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = 17 : i32}> : () -> i32
    %5 = "spirv.ShiftRightArithmetic"(%3, %4) : (i32, i32) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "const_fold_vector_asr"}> ({
    %0 = "spirv.Constant"() <{value = dense<[-2147483648, 239847, 127]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[31, 16, 13]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.ShiftRightArithmetic"(%0, %1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%2) : (vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "lsr_x_0"}> ({
  ^bb0(%arg2: i32, %arg3: vector<3xi32>):
    %10 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %11 = "spirv.Constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
    %12 = "spirv.ShiftRightLogical"(%arg2, %10) : (i32, i32) -> i32
    %13 = "spirv.ShiftRightLogical"(%arg3, %11) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%12, %13) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "lsr_shift_overflow"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %6 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
    %7 = "spirv.Constant"() <{value = dense<[6, 18, 128]> : vector<3xi32>}> : () -> vector<3xi32>
    %8 = "spirv.ShiftRightLogical"(%arg0, %6) : (i32, i32) -> i32
    %9 = "spirv.ShiftRightLogical"(%arg1, %7) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%8, %9) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "const_fold_scalar_lsr"}> ({
    %3 = "spirv.Constant"() <{value = -131072 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = 17 : i32}> : () -> i32
    %5 = "spirv.ShiftRightLogical"(%3, %4) : (i32, i32) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "const_fold_vector_lsr"}> ({
    %0 = "spirv.Constant"() <{value = dense<[-2147483648, -1, -127]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[31, 16, 13]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.ShiftRightLogical"(%0, %1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%2) : (vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "bitwise_and_x_x"}> ({
  ^bb0(%arg4: i32, %arg5: vector<3xi32>):
    %14 = "spirv.BitwiseAnd"(%arg4, %arg4) : (i32, i32) -> i32
    %15 = "spirv.BitwiseAnd"(%arg5, %arg5) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%14, %15) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "bitwise_and_x_0"}> ({
  ^bb0(%arg2: i32, %arg3: vector<3xi32>):
    %10 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %11 = "spirv.Constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
    %12 = "spirv.BitwiseAnd"(%arg2, %10) : (i32, i32) -> i32
    %13 = "spirv.BitwiseAnd"(%arg3, %11) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%12, %13) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "bitwise_and_x_n1"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %6 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    %7 = "spirv.Constant"() <{value = dense<-1> : vector<3xi32>}> : () -> vector<3xi32>
    %8 = "spirv.BitwiseAnd"(%arg0, %6) : (i32, i32) -> i32
    %9 = "spirv.BitwiseAnd"(%arg1, %7) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%8, %9) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "const_fold_scalar_band"}> ({
    %3 = "spirv.Constant"() <{value = -268464129 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = 268464128 : i32}> : () -> i32
    %5 = "spirv.BitwiseAnd"(%3, %4) : (i32, i32) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "const_fold_vector_band"}> ({
    %0 = "spirv.Constant"() <{value = dense<[42, -55, 127]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[-3, -15, 28]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.BitwiseAnd"(%0, %1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%2) : (vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "bitwise_or_x_x"}> ({
  ^bb0(%arg4: i32, %arg5: vector<3xi32>):
    %14 = "spirv.BitwiseOr"(%arg4, %arg4) : (i32, i32) -> i32
    %15 = "spirv.BitwiseOr"(%arg5, %arg5) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%14, %15) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "bitwise_or_x_0"}> ({
  ^bb0(%arg2: i32, %arg3: vector<3xi32>):
    %10 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %11 = "spirv.Constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
    %12 = "spirv.BitwiseOr"(%arg2, %10) : (i32, i32) -> i32
    %13 = "spirv.BitwiseOr"(%arg3, %11) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%12, %13) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "bitwise_or_x_n1"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %6 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    %7 = "spirv.Constant"() <{value = dense<-1> : vector<3xi32>}> : () -> vector<3xi32>
    %8 = "spirv.BitwiseOr"(%arg0, %6) : (i32, i32) -> i32
    %9 = "spirv.BitwiseOr"(%arg1, %7) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%8, %9) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "const_fold_scalar_bor"}> ({
    %3 = "spirv.Constant"() <{value = -268464129 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = 268464128 : i32}> : () -> i32
    %5 = "spirv.BitwiseOr"(%3, %4) : (i32, i32) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "const_fold_vector_bor"}> ({
    %0 = "spirv.Constant"() <{value = dense<[42, -55, 127]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[-3, -15, 28]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.BitwiseOr"(%0, %1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%2) : (vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "bitwise_xor_x_0"}> ({
  ^bb0(%arg2: i32, %arg3: vector<3xi32>):
    %8 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %9 = "spirv.Constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
    %10 = "spirv.BitwiseXor"(%arg2, %8) : (i32, i32) -> i32
    %11 = "spirv.BitwiseXor"(%arg3, %9) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%10, %11) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, vector<3xi32>) -> (i32, vector<3xi32>), sym_name = "bitwise_xor_x_x"}> ({
  ^bb0(%arg0: i32, %arg1: vector<3xi32>):
    %6 = "spirv.BitwiseXor"(%arg0, %arg0) : (i32, i32) -> i32
    %7 = "spirv.BitwiseXor"(%arg1, %arg1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%6, %7) : (i32, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "const_fold_scalar_bxor"}> ({
    %3 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = -2147483648 : i32}> : () -> i32
    %5 = "spirv.BitwiseXor"(%3, %4) : (i32, i32) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "const_fold_vector_bxor"}> ({
    %0 = "spirv.Constant"() <{value = dense<[42, -55, 127]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[-3, -15, 28]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.BitwiseXor"(%0, %1) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%2) : (vector<3xi32>) -> ()
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
    "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
      "spirv.BranchConditional"(%arg0)[^bb2, ^bb1] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "spirv.Store"(%3, %2) <{alignment = 4 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<i32, Function>, i32) -> ()
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb2:  // pred: ^bb0
      "spirv.Store"(%3, %1) <{alignment = 4 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<i32, Function>, i32) -> ()
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb3:  // 2 preds: ^bb1, ^bb2
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
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
    "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
      "spirv.BranchConditional"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "spirv.Store"(%3, %1) <{alignment = 8 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<vector<3xi32>, Function>, vector<3xi32>) -> ()
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
      "spirv.BranchConditional"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "spirv.Store"(%3, %1) <{alignment = 8 : i32, memory_access = #spirv.memory_access<Aligned>}> : (!spirv.ptr<vector<3xi32>, Function>, vector<3xi32>) -> ()
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

