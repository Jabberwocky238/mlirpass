"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "int32_scalar"}> ({
  ^bb0(%arg29: i32, %arg30: i32):
    %27 = "arith.addi"(%arg29, %arg30) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %28 = "arith.subi"(%arg29, %arg30) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %29 = "arith.muli"(%arg29, %arg30) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %30 = "arith.divsi"(%arg29, %arg30) : (i32, i32) -> i32
    %31 = "arith.divui"(%arg29, %arg30) : (i32, i32) -> i32
    %32 = "arith.remui"(%arg29, %arg30) : (i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "int32_scalar_srem"}> ({
  ^bb0(%arg27: i32, %arg28: i32):
    %26 = "arith.remsi"(%arg27, %arg28) : (i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> (), sym_name = "index_scalar"}> ({
  ^bb0(%arg25: index, %arg26: index):
    %20 = "arith.addi"(%arg25, %arg26) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %21 = "arith.subi"(%arg25, %arg26) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %22 = "arith.muli"(%arg25, %arg26) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %23 = "arith.divsi"(%arg25, %arg26) : (index, index) -> index
    %24 = "arith.divui"(%arg25, %arg26) : (index, index) -> index
    %25 = "arith.remui"(%arg25, %arg26) : (index, index) -> index
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> (), sym_name = "index_scalar_srem"}> ({
  ^bb0(%arg23: index, %arg24: index):
    %19 = "arith.remsi"(%arg23, %arg24) : (index, index) -> index
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (i32, i1), sym_name = "int32_scalar_addui_extended"}> ({
  ^bb0(%arg21: i32, %arg22: i32):
    %18:2 = "arith.addui_extended"(%arg21, %arg22) : (i32, i32) -> (i32, i1)
    "func.return"(%18#0, %18#1) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>, vector<4xi32>) -> (vector<4xi32>, vector<4xi1>), sym_name = "int32_vector_addui_extended"}> ({
  ^bb0(%arg19: vector<4xi32>, %arg20: vector<4xi32>):
    %17:2 = "arith.addui_extended"(%arg19, %arg20) : (vector<4xi32>, vector<4xi32>) -> (vector<4xi32>, vector<4xi1>)
    "func.return"(%17#0, %17#1) : (vector<4xi32>, vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (i32, i32), sym_name = "int32_scalar_mulsi_extended"}> ({
  ^bb0(%arg17: i32, %arg18: i32):
    %16:2 = "arith.mulsi_extended"(%arg17, %arg18) : (i32, i32) -> (i32, i32)
    "func.return"(%16#0, %16#1) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>, vector<4xi32>) -> (vector<4xi32>, vector<4xi32>), sym_name = "int32_vector_mulsi_extended"}> ({
  ^bb0(%arg15: vector<4xi32>, %arg16: vector<4xi32>):
    %15:2 = "arith.mulsi_extended"(%arg15, %arg16) : (vector<4xi32>, vector<4xi32>) -> (vector<4xi32>, vector<4xi32>)
    "func.return"(%15#0, %15#1) : (vector<4xi32>, vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (i32, i32), sym_name = "int32_scalar_mului_extended"}> ({
  ^bb0(%arg13: i32, %arg14: i32):
    %14:2 = "arith.mului_extended"(%arg13, %arg14) : (i32, i32) -> (i32, i32)
    "func.return"(%14#0, %14#1) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>, vector<4xi32>) -> (vector<4xi32>, vector<4xi32>), sym_name = "int32_vector_mului_extended"}> ({
  ^bb0(%arg11: vector<4xi32>, %arg12: vector<4xi32>):
    %13:2 = "arith.mului_extended"(%arg11, %arg12) : (vector<4xi32>, vector<4xi32>) -> (vector<4xi32>, vector<4xi32>)
    "func.return"(%13#0, %13#1) : (vector<4xi32>, vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> (), sym_name = "float32_unary_scalar"}> ({
  ^bb0(%arg10: f32):
    %12 = "arith.negf"(%arg10) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "float32_binary_scalar"}> ({
  ^bb0(%arg8: f32, %arg9: f32):
    %7 = "arith.addf"(%arg8, %arg9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %8 = "arith.subf"(%arg8, %arg9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %9 = "arith.mulf"(%arg8, %arg9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %10 = "arith.divf"(%arg8, %arg9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %11 = "arith.remf"(%arg8, %arg9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi8>, vector<4xi64>) -> (), sym_name = "int_vector234"}> ({
  ^bb0(%arg6: vector<2xi8>, %arg7: vector<4xi64>):
    %5 = "arith.divsi"(%arg6, %arg6) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %6 = "arith.divui"(%arg7, %arg7) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xindex>) -> (), sym_name = "index_vector"}> ({
  ^bb0(%arg5: vector<4xindex>):
    %4 = "arith.remui"(%arg5, %arg5) : (vector<4xindex>, vector<4xindex>) -> vector<4xindex>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi16>, vector<3xi16>) -> (), sym_name = "vector_srem"}> ({
  ^bb0(%arg3: vector<3xi16>, %arg4: vector<3xi16>):
    %3 = "arith.remsi"(%arg3, %arg4) : (vector<3xi16>, vector<3xi16>) -> vector<3xi16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf16>, vector<3xf64>) -> (), sym_name = "float_vector234"}> ({
  ^bb0(%arg1: vector<2xf16>, %arg2: vector<3xf64>):
    %1 = "arith.addf"(%arg1, %arg1) <{fastmath = #arith.fastmath<none>}> : (vector<2xf16>, vector<2xf16>) -> vector<2xf16>
    %2 = "arith.mulf"(%arg2, %arg2) <{fastmath = #arith.fastmath<none>}> : (vector<3xf64>, vector<3xf64>) -> vector<3xf64>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xi32>) -> (), sym_name = "one_elem_vector"}> ({
  ^bb0(%arg0: vector<1xi32>):
    %0 = "arith.addi"(%arg0, %arg0) <{overflowFlags = #arith.overflow<none>}> : (vector<1xi32>, vector<1xi32>) -> vector<1xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64, Shader], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "bitwise_scalar"}> ({
  ^bb0(%arg10: i32, %arg11: i32):
    %15 = "arith.andi"(%arg10, %arg11) : (i32, i32) -> i32
    %16 = "arith.ori"(%arg10, %arg11) : (i32, i32) -> i32
    %17 = "arith.xori"(%arg10, %arg11) : (i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>, vector<4xi32>) -> (), sym_name = "bitwise_vector"}> ({
  ^bb0(%arg8: vector<4xi32>, %arg9: vector<4xi32>):
    %12 = "arith.andi"(%arg8, %arg9) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %13 = "arith.ori"(%arg8, %arg9) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %14 = "arith.xori"(%arg8, %arg9) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i1) -> (), sym_name = "logical_scalar"}> ({
  ^bb0(%arg6: i1, %arg7: i1):
    %9 = "arith.andi"(%arg6, %arg7) : (i1, i1) -> i1
    %10 = "arith.ori"(%arg6, %arg7) : (i1, i1) -> i1
    %11 = "arith.xori"(%arg6, %arg7) : (i1, i1) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi1>, vector<4xi1>) -> (), sym_name = "logical_vector"}> ({
  ^bb0(%arg4: vector<4xi1>, %arg5: vector<4xi1>):
    %6 = "arith.andi"(%arg4, %arg5) : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    %7 = "arith.ori"(%arg4, %arg5) : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    %8 = "arith.xori"(%arg4, %arg5) : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "shift_scalar"}> ({
  ^bb0(%arg2: i32, %arg3: i32):
    %3 = "arith.shli"(%arg2, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "arith.shrsi"(%arg2, %arg3) : (i32, i32) -> i32
    %5 = "arith.shrui"(%arg2, %arg3) : (i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>, vector<4xi32>) -> (), sym_name = "shift_vector"}> ({
  ^bb0(%arg0: vector<4xi32>, %arg1: vector<4xi32>):
    %0 = "arith.shli"(%arg0, %arg1) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %1 = "arith.shrsi"(%arg0, %arg1) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %2 = "arith.shrui"(%arg0, %arg1) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "cmpf"}> ({
  ^bb0(%arg2: f32, %arg3: f32):
    %2 = "arith.cmpf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %3 = "arith.cmpf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
    %4 = "arith.cmpf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>, predicate = 3 : i64}> : (f32, f32) -> i1
    %5 = "arith.cmpf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
    %6 = "arith.cmpf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>, predicate = 5 : i64}> : (f32, f32) -> i1
    %7 = "arith.cmpf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %8 = "arith.cmpf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>, predicate = 8 : i64}> : (f32, f32) -> i1
    %9 = "arith.cmpf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>, predicate = 9 : i64}> : (f32, f32) -> i1
    %10 = "arith.cmpf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>, predicate = 10 : i64}> : (f32, f32) -> i1
    %11 = "arith.cmpf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>, predicate = 11 : i64}> : (f32, f32) -> i1
    %12 = "arith.cmpf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>, predicate = 12 : i64}> : (f32, f32) -> i1
    %13 = "arith.cmpf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>, predicate = 13 : i64}> : (f32, f32) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf32>, vector<1xf32>) -> (), sym_name = "vec1cmpf"}> ({
  ^bb0(%arg0: vector<1xf32>, %arg1: vector<1xf32>):
    %0 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (vector<1xf32>, vector<1xf32>) -> vector<1xi1>
    %1 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 11 : i64}> : (vector<1xf32>, vector<1xf32>) -> vector<1xi1>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "cmpf"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 7 : i64}> : (f32, f32) -> i1
    %1 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "cmpf"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 7 : i64}> : (f32, f32) -> i1
    %1 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "cmpi"}> ({
  ^bb0(%arg16: i32, %arg17: i32):
    %24 = "arith.cmpi"(%arg16, %arg17) <{predicate = 0 : i64}> : (i32, i32) -> i1
    %25 = "arith.cmpi"(%arg16, %arg17) <{predicate = 1 : i64}> : (i32, i32) -> i1
    %26 = "arith.cmpi"(%arg16, %arg17) <{predicate = 2 : i64}> : (i32, i32) -> i1
    %27 = "arith.cmpi"(%arg16, %arg17) <{predicate = 3 : i64}> : (i32, i32) -> i1
    %28 = "arith.cmpi"(%arg16, %arg17) <{predicate = 4 : i64}> : (i32, i32) -> i1
    %29 = "arith.cmpi"(%arg16, %arg17) <{predicate = 5 : i64}> : (i32, i32) -> i1
    %30 = "arith.cmpi"(%arg16, %arg17) <{predicate = 6 : i64}> : (i32, i32) -> i1
    %31 = "arith.cmpi"(%arg16, %arg17) <{predicate = 7 : i64}> : (i32, i32) -> i1
    %32 = "arith.cmpi"(%arg16, %arg17) <{predicate = 8 : i64}> : (i32, i32) -> i1
    %33 = "arith.cmpi"(%arg16, %arg17) <{predicate = 9 : i64}> : (i32, i32) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> (), sym_name = "indexcmpi"}> ({
  ^bb0(%arg14: index, %arg15: index):
    %14 = "arith.cmpi"(%arg14, %arg15) <{predicate = 0 : i64}> : (index, index) -> i1
    %15 = "arith.cmpi"(%arg14, %arg15) <{predicate = 1 : i64}> : (index, index) -> i1
    %16 = "arith.cmpi"(%arg14, %arg15) <{predicate = 2 : i64}> : (index, index) -> i1
    %17 = "arith.cmpi"(%arg14, %arg15) <{predicate = 3 : i64}> : (index, index) -> i1
    %18 = "arith.cmpi"(%arg14, %arg15) <{predicate = 4 : i64}> : (index, index) -> i1
    %19 = "arith.cmpi"(%arg14, %arg15) <{predicate = 5 : i64}> : (index, index) -> i1
    %20 = "arith.cmpi"(%arg14, %arg15) <{predicate = 6 : i64}> : (index, index) -> i1
    %21 = "arith.cmpi"(%arg14, %arg15) <{predicate = 7 : i64}> : (index, index) -> i1
    %22 = "arith.cmpi"(%arg14, %arg15) <{predicate = 8 : i64}> : (index, index) -> i1
    %23 = "arith.cmpi"(%arg14, %arg15) <{predicate = 9 : i64}> : (index, index) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xi32>, vector<1xi32>) -> (), sym_name = "vec1cmpi"}> ({
  ^bb0(%arg12: vector<1xi32>, %arg13: vector<1xi32>):
    %12 = "arith.cmpi"(%arg12, %arg13) <{predicate = 6 : i64}> : (vector<1xi32>, vector<1xi32>) -> vector<1xi1>
    %13 = "arith.cmpi"(%arg12, %arg13) <{predicate = 4 : i64}> : (vector<1xi32>, vector<1xi32>) -> vector<1xi1>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i1) -> (), sym_name = "boolcmpi_equality"}> ({
  ^bb0(%arg10: i1, %arg11: i1):
    %10 = "arith.cmpi"(%arg10, %arg11) <{predicate = 0 : i64}> : (i1, i1) -> i1
    %11 = "arith.cmpi"(%arg10, %arg11) <{predicate = 1 : i64}> : (i1, i1) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i1) -> (), sym_name = "boolcmpi_unsigned"}> ({
  ^bb0(%arg8: i1, %arg9: i1):
    %8 = "arith.cmpi"(%arg8, %arg9) <{predicate = 9 : i64}> : (i1, i1) -> i1
    %9 = "arith.cmpi"(%arg8, %arg9) <{predicate = 6 : i64}> : (i1, i1) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xi1>, vector<1xi1>) -> (), sym_name = "vec1boolcmpi_equality"}> ({
  ^bb0(%arg6: vector<1xi1>, %arg7: vector<1xi1>):
    %6 = "arith.cmpi"(%arg6, %arg7) <{predicate = 0 : i64}> : (vector<1xi1>, vector<1xi1>) -> vector<1xi1>
    %7 = "arith.cmpi"(%arg6, %arg7) <{predicate = 1 : i64}> : (vector<1xi1>, vector<1xi1>) -> vector<1xi1>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xi1>, vector<1xi1>) -> (), sym_name = "vec1boolcmpi_unsigned"}> ({
  ^bb0(%arg4: vector<1xi1>, %arg5: vector<1xi1>):
    %4 = "arith.cmpi"(%arg4, %arg5) <{predicate = 9 : i64}> : (vector<1xi1>, vector<1xi1>) -> vector<1xi1>
    %5 = "arith.cmpi"(%arg4, %arg5) <{predicate = 6 : i64}> : (vector<1xi1>, vector<1xi1>) -> vector<1xi1>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi1>, vector<4xi1>) -> (), sym_name = "vecboolcmpi_equality"}> ({
  ^bb0(%arg2: vector<4xi1>, %arg3: vector<4xi1>):
    %2 = "arith.cmpi"(%arg2, %arg3) <{predicate = 0 : i64}> : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    %3 = "arith.cmpi"(%arg2, %arg3) <{predicate = 1 : i64}> : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi1>, vector<3xi1>) -> (), sym_name = "vecboolcmpi_unsigned"}> ({
  ^bb0(%arg0: vector<3xi1>, %arg1: vector<3xi1>):
    %0 = "arith.cmpi"(%arg0, %arg1) <{predicate = 9 : i64}> : (vector<3xi1>, vector<3xi1>) -> vector<3xi1>
    %1 = "arith.cmpi"(%arg0, %arg1) <{predicate = 6 : i64}> : (vector<3xi1>, vector<3xi1>) -> vector<3xi1>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "constant"}> ({
    %17 = "arith.constant"() <{value = true}> : () -> i1
    %18 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    %19 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
    %20 = "arith.constant"() <{value = dense<[2, 3]> : vector<2xi32>}> : () -> vector<2xi32>
    %21 = "arith.constant"() <{value = 1 : index}> : () -> index
    %22 = "arith.constant"() <{value = dense<1> : tensor<2x3xi32>}> : () -> tensor<2x3xi32>
    %23 = "arith.constant"() <{value = dense<1.000000e+00> : tensor<2x3xf32>}> : () -> tensor<2x3xf32>
    %24 = "arith.constant"() <{value = dense<[[1.000000e+00, 2.000000e+00, 3.000000e+00], [4.000000e+00, 5.000000e+00, 6.000000e+00]]> : tensor<2x3xf32>}> : () -> tensor<2x3xf32>
    %25 = "arith.constant"() <{value = dense<[[1, 2, 3], [4, 5, 6]]> : tensor<2x3xi32>}> : () -> tensor<2x3xi32>
    %26 = "arith.constant"() <{value = dense<[[1, 2], [3, 4], [5, 6]]> : tensor<3x2xi32>}> : () -> tensor<3x2xi32>
    %27 = "arith.constant"() <{value = dense<[1, 2, 3, 4, 5, 6]> : tensor<6xi32>}> : () -> tensor<6xi32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "constant_8bit_float"}> ({
    %11 = "arith.constant"() <{value = 1.000000e+00 : f8E4M3}> : () -> f8E4M3
    %12 = "arith.bitcast"(%11) : (f8E4M3) -> i8
    %13 = "arith.constant"() <{value = dense<1.000000e+00> : vector<4xf8E4M3>}> : () -> vector<4xf8E4M3>
    %14 = "arith.bitcast"(%13) : (vector<4xf8E4M3>) -> vector<4xi8>
    %15 = "arith.constant"() <{value = dense<1.000000e+00> : tensor<4xf8E5M2>}> : () -> tensor<4xf8E5M2>
    %16 = "arith.bitcast"(%15) : (tensor<4xf8E5M2>) -> tensor<4xi8>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "constant_16bit"}> ({
    %7 = "arith.constant"() <{value = 4 : i16}> : () -> i16
    %8 = "arith.constant"() <{value = 5.000000e+00 : f16}> : () -> f16
    %9 = "arith.constant"() <{value = dense<[2, 3]> : vector<2xi16>}> : () -> vector<2xi16>
    %10 = "arith.constant"() <{value = dense<4.000000e+00> : tensor<5xf16>}> : () -> tensor<5xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "constant_64bit"}> ({
    %3 = "arith.constant"() <{value = 4 : i64}> : () -> i64
    %4 = "arith.constant"() <{value = 5.000000e+00 : f64}> : () -> f64
    %5 = "arith.constant"() <{value = dense<[2, 3]> : vector<2xi64>}> : () -> vector<2xi64>
    %6 = "arith.constant"() <{value = dense<4.000000e+00> : tensor<5xf64>}> : () -> tensor<5xf64>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "constant_size1"}> ({
    %0 = "arith.constant"() <{value = dense<true> : tensor<1xi1>}> : () -> tensor<1xi1>
    %1 = "arith.constant"() <{value = dense<4> : vector<1xi64>}> : () -> vector<1xi64>
    %2 = "arith.constant"() <{value = dense<5.000000e+00> : tensor<1xf64>}> : () -> tensor<1xf64>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "constant_16bit"}> ({
    %8 = "arith.constant"() <{value = 4 : i16}> : () -> i16
    %9 = "arith.constant"() <{value = 5.000000e+00 : f16}> : () -> f16
    %10 = "arith.constant"() <{value = dense<[2, 3]> : vector<2xi16>}> : () -> vector<2xi16>
    %11 = "arith.constant"() <{value = dense<4.000000e+00> : tensor<5xf16>}> : () -> tensor<5xf16>
    %12 = "arith.constant"() <{value = dense<[[1.000000e+00, 2.000000e+00], [3.000000e+00, 4.000000e+00]]> : tensor<2x2xf16>}> : () -> tensor<2x2xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "constant_size1"}> ({
    %6 = "arith.constant"() <{value = dense<4> : vector<1xi16>}> : () -> vector<1xi16>
    %7 = "arith.constant"() <{value = dense<5.000000e+00> : tensor<1xf16>}> : () -> tensor<1xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "corner_cases"}> ({
    %0 = "arith.constant"() <{value = -1 : i16}> : () -> i16
    %1 = "arith.constant"() <{value = -2 : i16}> : () -> i16
    %2 = "arith.constant"() <{value = -1 : index}> : () -> index
    %3 = "arith.constant"() <{value = -2 : index}> : () -> index
    %4 = "arith.constant"() <{value = false}> : () -> i1
    %5 = "arith.constant"() <{value = true}> : () -> i1
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i16) -> (), sym_name = "index_cast1"}> ({
  ^bb0(%arg45: i16):
    %50 = "arith.index_cast"(%arg45) : (i16) -> index
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "index_cast2"}> ({
  ^bb0(%arg44: index):
    %49 = "arith.index_cast"(%arg44) : (index) -> i16
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "index_cast3"}> ({
  ^bb0(%arg43: i32):
    %48 = "arith.index_cast"(%arg43) : (i32) -> index
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "index_cast4"}> ({
  ^bb0(%arg42: index):
    %47 = "arith.index_cast"(%arg42) : (index) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i16) -> (), sym_name = "index_castui1"}> ({
  ^bb0(%arg41: i16):
    %46 = "arith.index_castui"(%arg41) : (i16) -> index
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "index_castui2"}> ({
  ^bb0(%arg40: index):
    %45 = "arith.index_castui"(%arg40) : (index) -> i16
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "index_castui3"}> ({
  ^bb0(%arg39: i32):
    %44 = "arith.index_castui"(%arg39) : (i32) -> index
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "index_castui4"}> ({
  ^bb0(%arg38: index):
    %43 = "arith.index_cast"(%arg38) : (index) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "index_castindexi1_1"}> ({
  ^bb0(%arg37: index):
    %42 = "arith.index_cast"(%arg37) : (index) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xindex>) -> vector<1xi1>, sym_name = "index_castindexi1_2"}> ({
  ^bb0(%arg36: vector<1xindex>):
    %41 = "arith.index_cast"(%arg36) : (vector<1xindex>) -> vector<1xi1>
    "func.return"(%41) : (vector<1xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xindex>) -> (), sym_name = "index_castindexi1_3"}> ({
  ^bb0(%arg35: vector<3xindex>):
    %40 = "arith.index_cast"(%arg35) : (vector<3xindex>) -> vector<3xi1>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "index_casti1index_1"}> ({
  ^bb0(%arg34: i1):
    %39 = "arith.index_cast"(%arg34) : (i1) -> index
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xi1>) -> vector<1xindex>, sym_name = "index_casti1index_2"}> ({
  ^bb0(%arg33: vector<1xi1>):
    %38 = "arith.index_cast"(%arg33) : (vector<1xi1>) -> vector<1xindex>
    "func.return"(%38) : (vector<1xindex>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi1>) -> (), sym_name = "index_casti1index_3"}> ({
  ^bb0(%arg32: vector<3xi1>):
    %37 = "arith.index_cast"(%arg32) : (vector<3xi1>) -> vector<3xindex>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, i64) -> (), sym_name = "bit_cast"}> ({
  ^bb0(%arg30: vector<2xf32>, %arg31: i64):
    %35 = "arith.bitcast"(%arg30) : (vector<2xf32>) -> vector<2xi32>
    %36 = "arith.bitcast"(%arg31) : (i64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16) -> f64, sym_name = "fpext1"}> ({
  ^bb0(%arg29: f16):
    %34 = "arith.extf"(%arg29) : (f16) -> f64
    "func.return"(%34) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f64, sym_name = "fpext2"}> ({
  ^bb0(%arg28: f32):
    %33 = "arith.extf"(%arg28) : (f32) -> f64
    "func.return"(%33) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f64) -> f16, sym_name = "fptrunc1"}> ({
  ^bb0(%arg27: f64):
    %32 = "arith.truncf"(%arg27) : (f64) -> f16
    "func.return"(%32) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f16, sym_name = "fptrunc2"}> ({
  ^bb0(%arg26: f32):
    %31 = "arith.truncf"(%arg26) : (f32) -> f16
    "func.return"(%31) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f64) -> (), sym_name = "experimental_constrained_fptrunc"}> ({
  ^bb0(%arg25: f64):
    %27 = "arith.truncf"(%arg25) <{roundingmode = 0 : i32}> : (f64) -> f32
    %28 = "arith.truncf"(%arg25) <{roundingmode = 1 : i32}> : (f64) -> f32
    %29 = "arith.truncf"(%arg25) <{roundingmode = 2 : i32}> : (f64) -> f32
    %30 = "arith.truncf"(%arg25) <{roundingmode = 3 : i32}> : (f64) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> f32, sym_name = "sitofp1"}> ({
  ^bb0(%arg24: i32):
    %26 = "arith.sitofp"(%arg24) : (i32) -> f32
    "func.return"(%26) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> f64, sym_name = "sitofp2"}> ({
  ^bb0(%arg23: i64):
    %25 = "arith.sitofp"(%arg23) : (i64) -> f64
    "func.return"(%25) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i16) -> f32, sym_name = "uitofp_i16_f32"}> ({
  ^bb0(%arg22: i16):
    %24 = "arith.uitofp"(%arg22) : (i16) -> f32
    "func.return"(%24) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> f32, sym_name = "uitofp_i32_f32"}> ({
  ^bb0(%arg21: i32):
    %23 = "arith.uitofp"(%arg21) : (i32) -> f32
    "func.return"(%23) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> f32, sym_name = "uitofp_i1_f32"}> ({
  ^bb0(%arg20: i1):
    %22 = "arith.uitofp"(%arg20) : (i1) -> f32
    "func.return"(%22) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> f64, sym_name = "uitofp_i1_f64"}> ({
  ^bb0(%arg19: i1):
    %21 = "arith.uitofp"(%arg19) : (i1) -> f64
    "func.return"(%21) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi1>) -> vector<4xf32>, sym_name = "uitofp_vec_i1_f32"}> ({
  ^bb0(%arg18: vector<4xi1>):
    %20 = "arith.uitofp"(%arg18) : (vector<4xi1>) -> vector<4xf32>
    "func.return"(%20) : (vector<4xf32>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi1>) -> vector<4xf64>, sym_name = "uitofp_vec_i1_f64"}> ({
  ^bb0(%arg17: vector<4xi1>):
    %17 = "spirv.Constant"() <{value = dense<0.000000e+00> : vector<4xf64>}> : () -> vector<4xf64>
    %18 = "spirv.Constant"() <{value = dense<1.000000e+00> : vector<4xf64>}> : () -> vector<4xf64>
    %19 = "spirv.Select"(%arg17, %18, %17) : (vector<4xi1>, vector<4xf64>, vector<4xf64>) -> vector<4xf64>
    "spirv.ReturnValue"(%19) : (vector<4xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i16) -> i64, sym_name = "sexti1"}> ({
  ^bb0(%arg16: i16):
    %16 = "arith.extsi"(%arg16) : (i16) -> i64
    "func.return"(%16) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i64, sym_name = "sexti2"}> ({
  ^bb0(%arg15: i32):
    %15 = "arith.extsi"(%arg15) : (i32) -> i64
    "func.return"(%15) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i32, sym_name = "sext_bool_scalar"}> ({
  ^bb0(%arg14: i1):
    %14 = "arith.extsi"(%arg14) : (i1) -> i32
    "func.return"(%14) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi1>) -> vector<3xi32>, sym_name = "sext_bool_vector"}> ({
  ^bb0(%arg13: vector<3xi1>):
    %13 = "arith.extsi"(%arg13) : (vector<3xi1>) -> vector<3xi32>
    "func.return"(%13) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i16) -> i64, sym_name = "zexti1"}> ({
  ^bb0(%arg12: i16):
    %12 = "arith.extui"(%arg12) : (i16) -> i64
    "func.return"(%12) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i64, sym_name = "zexti2"}> ({
  ^bb0(%arg11: i32):
    %11 = "arith.extui"(%arg11) : (i32) -> i64
    "func.return"(%11) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i32, sym_name = "zexti3"}> ({
  ^bb0(%arg10: i1):
    %10 = "arith.extui"(%arg10) : (i1) -> i32
    "func.return"(%10) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi1>) -> vector<4xi32>, sym_name = "zexti4"}> ({
  ^bb0(%arg9: vector<4xi1>):
    %9 = "arith.extui"(%arg9) : (vector<4xi1>) -> vector<4xi32>
    "func.return"(%9) : (vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi1>) -> vector<4xi64>, sym_name = "zexti5"}> ({
  ^bb0(%arg8: vector<4xi1>):
    %8 = "arith.extui"(%arg8) : (vector<4xi1>) -> vector<4xi64>
    "func.return"(%8) : (vector<4xi64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i16, sym_name = "trunci1"}> ({
  ^bb0(%arg7: i64):
    %7 = "arith.trunci"(%arg7) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i16
    "func.return"(%7) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i16, sym_name = "trunci2"}> ({
  ^bb0(%arg6: i32):
    %6 = "arith.trunci"(%arg6) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i16
    "func.return"(%6) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i1, sym_name = "trunc_to_i1"}> ({
  ^bb0(%arg5: i32):
    %5 = "arith.trunci"(%arg5) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i1
    "func.return"(%5) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> vector<4xi1>, sym_name = "trunc_to_veci1"}> ({
  ^bb0(%arg4: vector<4xi32>):
    %4 = "arith.trunci"(%arg4) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi32>) -> vector<4xi1>
    "func.return"(%4) : (vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> i32, sym_name = "fptoui1"}> ({
  ^bb0(%arg3: f32):
    %3 = "arith.fptoui"(%arg3) : (f32) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16) -> i16, sym_name = "fptoui2"}> ({
  ^bb0(%arg2: f16):
    %2 = "arith.fptoui"(%arg2) : (f16) -> i16
    "func.return"(%2) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> i32, sym_name = "fptosi1"}> ({
  ^bb0(%arg1: f32):
    %1 = "arith.fptosi"(%arg1) : (f32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16) -> i16, sym_name = "fptosi2"}> ({
  ^bb0(%arg0: f16):
    %0 = "arith.fptosi"(%arg0) : (f16) -> i16
    "func.return"(%0) : (i16) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f16) -> f64, sym_name = "fpext1"}> ({
  ^bb0(%arg7: f16):
    %7 = "arith.extf"(%arg7) : (f16) -> f64
    "func.return"(%7) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f64, sym_name = "fpext2"}> ({
  ^bb0(%arg6: f32):
    %6 = "arith.extf"(%arg6) : (f32) -> f64
    "func.return"(%6) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i4, sym_name = "trunci4_scalar"}> ({
  ^bb0(%arg5: i32):
    %5 = "arith.trunci"(%arg5) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i4
    "func.return"(%5) : (i4) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi32>) -> vector<2xi4>, sym_name = "trunci4_vector"}> ({
  ^bb0(%arg4: vector<2xi32>):
    %4 = "arith.trunci"(%arg4) <{overflowFlags = #arith.overflow<none>}> : (vector<2xi32>) -> vector<2xi4>
    "func.return"(%4) : (vector<2xi4>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i4) -> i32, sym_name = "zexti4_scalar"}> ({
  ^bb0(%arg3: i4):
    %3 = "arith.extui"(%arg3) : (i4) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi4>) -> vector<3xi32>, sym_name = "zexti4_vector"}> ({
  ^bb0(%arg2: vector<3xi4>):
    %2 = "arith.extui"(%arg2) : (vector<3xi4>) -> vector<3xi32>
    "func.return"(%2) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i4) -> i32, sym_name = "sexti4_scalar"}> ({
  ^bb0(%arg1: i4):
    %1 = "arith.extsi"(%arg1) : (i4) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi4>) -> vector<4xi32>, sym_name = "sexti4_vector"}> ({
  ^bb0(%arg0: vector<4xi4>):
    %0 = "arith.extsi"(%arg0) : (vector<4xi4>) -> vector<4xi32>
    "func.return"(%0) : (vector<4xi32>) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Float64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> f16, sym_name = "fptrunc1"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.truncf"(%arg0) : (f32) -> f16
    "func.return"(%0) : (f16) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Float16], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "int32_scalar"}> ({
  ^bb0(%arg14: i32, %arg15: i32):
    %11 = "arith.addi"(%arg14, %arg15) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %12 = "arith.subi"(%arg14, %arg15) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %13 = "arith.muli"(%arg14, %arg15) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %14 = "arith.divsi"(%arg14, %arg15) : (i32, i32) -> i32
    %15 = "arith.divui"(%arg14, %arg15) : (i32, i32) -> i32
    %16 = "arith.remui"(%arg14, %arg15) : (i32, i32) -> i32
    %17 = "arith.maxsi"(%arg14, %arg15) : (i32, i32) -> i32
    %18 = "arith.maxui"(%arg14, %arg15) : (i32, i32) -> i32
    %19 = "arith.minsi"(%arg14, %arg15) : (i32, i32) -> i32
    %20 = "arith.minui"(%arg14, %arg15) : (i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "float32_binary_scalar"}> ({
  ^bb0(%arg12: f32, %arg13: f32):
    %6 = "arith.addf"(%arg12, %arg13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %7 = "arith.subf"(%arg12, %arg13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %8 = "arith.mulf"(%arg12, %arg13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %9 = "arith.divf"(%arg12, %arg13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %10 = "arith.remf"(%arg12, %arg13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "float32_minimumf_scalar"}> ({
  ^bb0(%arg10: f32, %arg11: f32):
    %5 = "arith.minimumf"(%arg10, %arg11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%5) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "float32_minnumf_scalar"}> ({
  ^bb0(%arg8: f32, %arg9: f32):
    %4 = "arith.minnumf"(%arg8, %arg9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%4) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf32>) -> vector<2xf32>, sym_name = "float32_maximumf_scalar"}> ({
  ^bb0(%arg6: vector<2xf32>, %arg7: vector<2xf32>):
    %3 = "arith.maximumf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "func.return"(%3) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf32>) -> vector<2xf32>, sym_name = "float32_maxnumf_scalar"}> ({
  ^bb0(%arg4: vector<2xf32>, %arg5: vector<2xf32>):
    %2 = "arith.maxnumf"(%arg4, %arg5) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "func.return"(%2) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "scalar_srem"}> ({
  ^bb0(%arg2: i32, %arg3: i32):
    %1 = "arith.remsi"(%arg2, %arg3) : (i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi16>, vector<3xi16>) -> (), sym_name = "vector_srem"}> ({
  ^bb0(%arg0: vector<3xi16>, %arg1: vector<3xi16>):
    %0 = "arith.remsi"(%arg0, %arg1) : (vector<3xi16>, vector<3xi16>) -> vector<3xi16>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int16, Kernel], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "select"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.cmpi"(%arg0, %arg1) <{predicate = 3 : i64}> : (i32, i32) -> i1
    %1 = "arith.select"(%0, %arg0, %arg1) : (i1, i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int8, Int16, Int64, Float16, Float64], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "int32_scalar"}> ({
  ^bb0(%arg20: i32, %arg21: i32):
    %17 = "arith.addi"(%arg20, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %18 = "arith.subi"(%arg20, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %19 = "arith.muli"(%arg20, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %20 = "arith.divsi"(%arg20, %arg21) : (i32, i32) -> i32
    %21 = "arith.divui"(%arg20, %arg21) : (i32, i32) -> i32
    %22 = "arith.remui"(%arg20, %arg21) : (i32, i32) -> i32
    %23 = "arith.maxsi"(%arg20, %arg21) : (i32, i32) -> i32
    %24 = "arith.maxui"(%arg20, %arg21) : (i32, i32) -> i32
    %25 = "arith.minsi"(%arg20, %arg21) : (i32, i32) -> i32
    %26 = "arith.minui"(%arg20, %arg21) : (i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "scalar_srem"}> ({
  ^bb0(%arg18: i32, %arg19: i32):
    %16 = "arith.remsi"(%arg18, %arg19) : (i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> (), sym_name = "float32_unary_scalar"}> ({
  ^bb0(%arg17: f32):
    %15 = "arith.negf"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "float32_binary_scalar"}> ({
  ^bb0(%arg15: f32, %arg16: f32):
    %10 = "arith.addf"(%arg15, %arg16) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %11 = "arith.subf"(%arg15, %arg16) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %12 = "arith.mulf"(%arg15, %arg16) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %13 = "arith.divf"(%arg15, %arg16) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %14 = "arith.remf"(%arg15, %arg16) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "float32_minimumf_scalar"}> ({
  ^bb0(%arg13: f32, %arg14: f32):
    %9 = "arith.minimumf"(%arg13, %arg14) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%9) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "float32_minnumf_scalar"}> ({
  ^bb0(%arg11: f32, %arg12: f32):
    %8 = "arith.minnumf"(%arg11, %arg12) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%8) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf32>) -> vector<2xf32>, sym_name = "float32_maximumf_scalar"}> ({
  ^bb0(%arg9: vector<2xf32>, %arg10: vector<2xf32>):
    %7 = "arith.maximumf"(%arg9, %arg10) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "func.return"(%7) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf32>) -> vector<2xf32>, sym_name = "float32_maxnumf_scalar"}> ({
  ^bb0(%arg7: vector<2xf32>, %arg8: vector<2xf32>):
    %6 = "arith.maxnumf"(%arg7, %arg8) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "func.return"(%6) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi8>, vector<4xi64>) -> (), sym_name = "int_vector234"}> ({
  ^bb0(%arg5: vector<2xi8>, %arg6: vector<4xi64>):
    %4 = "arith.divsi"(%arg5, %arg5) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %5 = "arith.divui"(%arg6, %arg6) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi16>, vector<3xi16>) -> (), sym_name = "vector_srem"}> ({
  ^bb0(%arg3: vector<3xi16>, %arg4: vector<3xi16>):
    %3 = "arith.remsi"(%arg3, %arg4) : (vector<3xi16>, vector<3xi16>) -> vector<3xi16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf16>, vector<3xf64>) -> (), sym_name = "float_vector234"}> ({
  ^bb0(%arg1: vector<2xf16>, %arg2: vector<3xf64>):
    %1 = "arith.addf"(%arg1, %arg1) <{fastmath = #arith.fastmath<none>}> : (vector<2xf16>, vector<2xf16>) -> vector<2xf16>
    %2 = "arith.mulf"(%arg2, %arg2) <{fastmath = #arith.fastmath<none>}> : (vector<3xf64>, vector<3xf64>) -> vector<3xf64>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xi32>) -> (), sym_name = "one_elem_vector"}> ({
  ^bb0(%arg0: vector<1xi32>):
    %0 = "arith.addi"(%arg0, %arg0) <{overflowFlags = #arith.overflow<none>}> : (vector<1xi32>, vector<1xi32>) -> vector<1xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64, Shader], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xi8>, vector<3xi16>) -> (), sym_name = "int_vector23"}> ({
  ^bb0(%arg1: vector<2xi8>, %arg2: vector<3xi16>):
    %1 = "arith.divsi"(%arg1, %arg1) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %2 = "arith.divsi"(%arg2, %arg2) : (vector<3xi16>, vector<3xi16>) -> vector<3xi16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16) -> (), sym_name = "float_scalar"}> ({
  ^bb0(%arg0: f16):
    %0 = "arith.addf"(%arg0, %arg0) <{fastmath = #arith.fastmath<none>}> : (f16, f16) -> f16
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64, i64) -> (), sym_name = "ops_flags"}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "arith.addi"(%arg0, %arg1) <{overflowFlags = #arith.overflow<nsw>}> : (i64, i64) -> i64
    %1 = "arith.subi"(%arg0, %arg1) <{overflowFlags = #arith.overflow<nuw>}> : (i64, i64) -> i64
    %2 = "arith.muli"(%arg0, %arg1) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (i64, i64) -> i64
    %3 = "arith.shli"(%arg0, %arg1) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (i64, i64) -> i64
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64, Kernel], [SPV_KHR_no_integer_wrap_decoration]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64, i64) -> (), sym_name = "ops_flags"}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "arith.addi"(%arg0, %arg1) <{overflowFlags = #arith.overflow<nsw>}> : (i64, i64) -> i64
    %1 = "arith.subi"(%arg0, %arg1) <{overflowFlags = #arith.overflow<nuw>}> : (i64, i64) -> i64
    %2 = "arith.muli"(%arg0, %arg1) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (i64, i64) -> i64
    %3 = "arith.muli"(%arg0, %arg1) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (i64, i64) -> i64
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64], []>, #spirv.resource_limits<>>} : () -> ()

