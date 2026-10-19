"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "int32_scalar"}> ({
  ^bb0(%arg29: i32, %arg30: i32):
    %64 = "spirv.IAdd"(%arg29, %arg30) : (i32, i32) -> i32
    %65 = "spirv.ISub"(%arg29, %arg30) : (i32, i32) -> i32
    %66 = "spirv.IMul"(%arg29, %arg30) : (i32, i32) -> i32
    %67 = "spirv.SDiv"(%arg29, %arg30) : (i32, i32) -> i32
    %68 = "spirv.UDiv"(%arg29, %arg30) : (i32, i32) -> i32
    %69 = "spirv.UMod"(%arg29, %arg30) : (i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "int32_scalar_srem"}> ({
  ^bb0(%arg27: i32, %arg28: i32):
    %58 = "spirv.GL.SAbs"(%arg27) : (i32) -> i32
    %59 = "spirv.GL.SAbs"(%arg28) : (i32) -> i32
    %60 = "spirv.UMod"(%58, %59) : (i32, i32) -> i32
    %61 = "spirv.IEqual"(%arg27, %58) : (i32, i32) -> i1
    %62 = "spirv.SNegate"(%60) : (i32) -> i32
    %63 = "spirv.Select"(%61, %60, %62) : (i1, i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> (), sym_name = "index_scalar"}> ({
  ^bb0(%arg25: index, %arg26: index):
    %50 = "builtin.unrealized_conversion_cast"(%arg26) : (index) -> i32
    %51 = "builtin.unrealized_conversion_cast"(%arg25) : (index) -> i32
    %52 = "spirv.IAdd"(%51, %50) : (i32, i32) -> i32
    %53 = "spirv.ISub"(%51, %50) : (i32, i32) -> i32
    %54 = "spirv.IMul"(%51, %50) : (i32, i32) -> i32
    %55 = "spirv.SDiv"(%51, %50) : (i32, i32) -> i32
    %56 = "spirv.UDiv"(%51, %50) : (i32, i32) -> i32
    %57 = "spirv.UMod"(%51, %50) : (i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> (), sym_name = "index_scalar_srem"}> ({
  ^bb0(%arg23: index, %arg24: index):
    %42 = "builtin.unrealized_conversion_cast"(%arg24) : (index) -> i32
    %43 = "builtin.unrealized_conversion_cast"(%arg23) : (index) -> i32
    %44 = "spirv.GL.SAbs"(%43) : (i32) -> i32
    %45 = "spirv.GL.SAbs"(%42) : (i32) -> i32
    %46 = "spirv.UMod"(%44, %45) : (i32, i32) -> i32
    %47 = "spirv.IEqual"(%43, %44) : (i32, i32) -> i1
    %48 = "spirv.SNegate"(%46) : (i32) -> i32
    %49 = "spirv.Select"(%47, %46, %48) : (i1, i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (i32, i1), sym_name = "int32_scalar_addui_extended"}> ({
  ^bb0(%arg21: i32, %arg22: i32):
    %37 = "spirv.IAddCarry"(%arg21, %arg22) : (i32, i32) -> !spirv.struct<(i32, i32)>
    %38 = "spirv.CompositeExtract"(%37) <{indices = [0 : i32]}> : (!spirv.struct<(i32, i32)>) -> i32
    %39 = "spirv.CompositeExtract"(%37) <{indices = [1 : i32]}> : (!spirv.struct<(i32, i32)>) -> i32
    %40 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %41 = "spirv.IEqual"(%39, %40) : (i32, i32) -> i1
    "func.return"(%38, %41) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>, vector<4xi32>) -> (vector<4xi32>, vector<4xi1>), sym_name = "int32_vector_addui_extended"}> ({
  ^bb0(%arg19: vector<4xi32>, %arg20: vector<4xi32>):
    %32 = "spirv.IAddCarry"(%arg19, %arg20) : (vector<4xi32>, vector<4xi32>) -> !spirv.struct<(vector<4xi32>, vector<4xi32>)>
    %33 = "spirv.CompositeExtract"(%32) <{indices = [0 : i32]}> : (!spirv.struct<(vector<4xi32>, vector<4xi32>)>) -> vector<4xi32>
    %34 = "spirv.CompositeExtract"(%32) <{indices = [1 : i32]}> : (!spirv.struct<(vector<4xi32>, vector<4xi32>)>) -> vector<4xi32>
    %35 = "spirv.Constant"() <{value = dense<1> : vector<4xi32>}> : () -> vector<4xi32>
    %36 = "spirv.IEqual"(%34, %35) : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
    "func.return"(%33, %36) : (vector<4xi32>, vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (i32, i32), sym_name = "int32_scalar_mulsi_extended"}> ({
  ^bb0(%arg17: i32, %arg18: i32):
    %29 = "spirv.SMulExtended"(%arg17, %arg18) : (i32, i32) -> !spirv.struct<(i32, i32)>
    %30 = "spirv.CompositeExtract"(%29) <{indices = [0 : i32]}> : (!spirv.struct<(i32, i32)>) -> i32
    %31 = "spirv.CompositeExtract"(%29) <{indices = [1 : i32]}> : (!spirv.struct<(i32, i32)>) -> i32
    "func.return"(%30, %31) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>, vector<4xi32>) -> (vector<4xi32>, vector<4xi32>), sym_name = "int32_vector_mulsi_extended"}> ({
  ^bb0(%arg15: vector<4xi32>, %arg16: vector<4xi32>):
    %26 = "spirv.SMulExtended"(%arg15, %arg16) : (vector<4xi32>, vector<4xi32>) -> !spirv.struct<(vector<4xi32>, vector<4xi32>)>
    %27 = "spirv.CompositeExtract"(%26) <{indices = [0 : i32]}> : (!spirv.struct<(vector<4xi32>, vector<4xi32>)>) -> vector<4xi32>
    %28 = "spirv.CompositeExtract"(%26) <{indices = [1 : i32]}> : (!spirv.struct<(vector<4xi32>, vector<4xi32>)>) -> vector<4xi32>
    "func.return"(%27, %28) : (vector<4xi32>, vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (i32, i32), sym_name = "int32_scalar_mului_extended"}> ({
  ^bb0(%arg13: i32, %arg14: i32):
    %23 = "spirv.UMulExtended"(%arg13, %arg14) : (i32, i32) -> !spirv.struct<(i32, i32)>
    %24 = "spirv.CompositeExtract"(%23) <{indices = [0 : i32]}> : (!spirv.struct<(i32, i32)>) -> i32
    %25 = "spirv.CompositeExtract"(%23) <{indices = [1 : i32]}> : (!spirv.struct<(i32, i32)>) -> i32
    "func.return"(%24, %25) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>, vector<4xi32>) -> (vector<4xi32>, vector<4xi32>), sym_name = "int32_vector_mului_extended"}> ({
  ^bb0(%arg11: vector<4xi32>, %arg12: vector<4xi32>):
    %20 = "spirv.UMulExtended"(%arg11, %arg12) : (vector<4xi32>, vector<4xi32>) -> !spirv.struct<(vector<4xi32>, vector<4xi32>)>
    %21 = "spirv.CompositeExtract"(%20) <{indices = [0 : i32]}> : (!spirv.struct<(vector<4xi32>, vector<4xi32>)>) -> vector<4xi32>
    %22 = "spirv.CompositeExtract"(%20) <{indices = [1 : i32]}> : (!spirv.struct<(vector<4xi32>, vector<4xi32>)>) -> vector<4xi32>
    "func.return"(%21, %22) : (vector<4xi32>, vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> (), sym_name = "float32_unary_scalar"}> ({
  ^bb0(%arg10: f32):
    %19 = "spirv.FNegate"(%arg10) : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "float32_binary_scalar"}> ({
  ^bb0(%arg8: f32, %arg9: f32):
    %14 = "spirv.FAdd"(%arg8, %arg9) : (f32, f32) -> f32
    %15 = "spirv.FSub"(%arg8, %arg9) : (f32, f32) -> f32
    %16 = "spirv.FMul"(%arg8, %arg9) : (f32, f32) -> f32
    %17 = "spirv.FDiv"(%arg8, %arg9) : (f32, f32) -> f32
    %18 = "spirv.FRem"(%arg8, %arg9) : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi8>, vector<4xi64>) -> (), sym_name = "int_vector234"}> ({
  ^bb0(%arg6: vector<2xi8>, %arg7: vector<4xi64>):
    %12 = "spirv.SDiv"(%arg6, %arg6) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %13 = "spirv.UDiv"(%arg7, %arg7) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xindex>) -> (), sym_name = "index_vector"}> ({
  ^bb0(%arg5: vector<4xindex>):
    %10 = "builtin.unrealized_conversion_cast"(%arg5) : (vector<4xindex>) -> vector<4xi32>
    %11 = "spirv.UMod"(%10, %10) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi16>, vector<3xi16>) -> (), sym_name = "vector_srem"}> ({
  ^bb0(%arg3: vector<3xi16>, %arg4: vector<3xi16>):
    %4 = "spirv.GL.SAbs"(%arg3) : (vector<3xi16>) -> vector<3xi16>
    %5 = "spirv.GL.SAbs"(%arg4) : (vector<3xi16>) -> vector<3xi16>
    %6 = "spirv.UMod"(%4, %5) : (vector<3xi16>, vector<3xi16>) -> vector<3xi16>
    %7 = "spirv.IEqual"(%arg3, %4) : (vector<3xi16>, vector<3xi16>) -> vector<3xi1>
    %8 = "spirv.SNegate"(%6) : (vector<3xi16>) -> vector<3xi16>
    %9 = "spirv.Select"(%7, %6, %8) : (vector<3xi1>, vector<3xi16>, vector<3xi16>) -> vector<3xi16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf16>, vector<3xf64>) -> (), sym_name = "float_vector234"}> ({
  ^bb0(%arg1: vector<2xf16>, %arg2: vector<3xf64>):
    %2 = "spirv.FAdd"(%arg1, %arg1) : (vector<2xf16>, vector<2xf16>) -> vector<2xf16>
    %3 = "spirv.FMul"(%arg2, %arg2) : (vector<3xf64>, vector<3xf64>) -> vector<3xf64>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xi32>) -> (), sym_name = "one_elem_vector"}> ({
  ^bb0(%arg0: vector<1xi32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<1xi32>) -> i32
    %1 = "spirv.IAdd"(%0, %0) : (i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64, Shader], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "bitwise_scalar"}> ({
  ^bb0(%arg10: i32, %arg11: i32):
    %15 = "spirv.BitwiseAnd"(%arg10, %arg11) : (i32, i32) -> i32
    %16 = "spirv.BitwiseOr"(%arg10, %arg11) : (i32, i32) -> i32
    %17 = "spirv.BitwiseXor"(%arg10, %arg11) : (i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>, vector<4xi32>) -> (), sym_name = "bitwise_vector"}> ({
  ^bb0(%arg8: vector<4xi32>, %arg9: vector<4xi32>):
    %12 = "spirv.BitwiseAnd"(%arg8, %arg9) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %13 = "spirv.BitwiseOr"(%arg8, %arg9) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %14 = "spirv.BitwiseXor"(%arg8, %arg9) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i1) -> (), sym_name = "logical_scalar"}> ({
  ^bb0(%arg6: i1, %arg7: i1):
    %9 = "spirv.LogicalAnd"(%arg6, %arg7) : (i1, i1) -> i1
    %10 = "spirv.LogicalOr"(%arg6, %arg7) : (i1, i1) -> i1
    %11 = "spirv.LogicalNotEqual"(%arg6, %arg7) : (i1, i1) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi1>, vector<4xi1>) -> (), sym_name = "logical_vector"}> ({
  ^bb0(%arg4: vector<4xi1>, %arg5: vector<4xi1>):
    %6 = "spirv.LogicalAnd"(%arg4, %arg5) : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    %7 = "spirv.LogicalOr"(%arg4, %arg5) : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    %8 = "spirv.LogicalNotEqual"(%arg4, %arg5) : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "shift_scalar"}> ({
  ^bb0(%arg2: i32, %arg3: i32):
    %3 = "spirv.ShiftLeftLogical"(%arg2, %arg3) : (i32, i32) -> i32
    %4 = "spirv.ShiftRightArithmetic"(%arg2, %arg3) : (i32, i32) -> i32
    %5 = "spirv.ShiftRightLogical"(%arg2, %arg3) : (i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>, vector<4xi32>) -> (), sym_name = "shift_vector"}> ({
  ^bb0(%arg0: vector<4xi32>, %arg1: vector<4xi32>):
    %0 = "spirv.ShiftLeftLogical"(%arg0, %arg1) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %1 = "spirv.ShiftRightArithmetic"(%arg0, %arg1) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %2 = "spirv.ShiftRightLogical"(%arg0, %arg1) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "cmpf"}> ({
  ^bb0(%arg2: f32, %arg3: f32):
    %4 = "spirv.FOrdEqual"(%arg2, %arg3) : (f32, f32) -> i1
    %5 = "spirv.FOrdGreaterThan"(%arg2, %arg3) : (f32, f32) -> i1
    %6 = "spirv.FOrdGreaterThanEqual"(%arg2, %arg3) : (f32, f32) -> i1
    %7 = "spirv.FOrdLessThan"(%arg2, %arg3) : (f32, f32) -> i1
    %8 = "spirv.FOrdLessThanEqual"(%arg2, %arg3) : (f32, f32) -> i1
    %9 = "spirv.FOrdNotEqual"(%arg2, %arg3) : (f32, f32) -> i1
    %10 = "spirv.FUnordEqual"(%arg2, %arg3) : (f32, f32) -> i1
    %11 = "spirv.FUnordGreaterThan"(%arg2, %arg3) : (f32, f32) -> i1
    %12 = "spirv.FUnordGreaterThanEqual"(%arg2, %arg3) : (f32, f32) -> i1
    %13 = "spirv.FUnordLessThan"(%arg2, %arg3) : (f32, f32) -> i1
    %14 = "spirv.FUnordLessThanEqual"(%arg2, %arg3) : (f32, f32) -> i1
    %15 = "spirv.FUnordNotEqual"(%arg2, %arg3) : (f32, f32) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf32>, vector<1xf32>) -> (), sym_name = "vec1cmpf"}> ({
  ^bb0(%arg0: vector<1xf32>, %arg1: vector<1xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<1xf32>) -> f32
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<1xf32>) -> f32
    %2 = "spirv.FOrdGreaterThan"(%1, %0) : (f32, f32) -> i1
    %3 = "spirv.FUnordLessThan"(%1, %0) : (f32, f32) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "cmpf"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "spirv.Ordered"(%arg0, %arg1) : (f32, f32) -> i1
    %1 = "spirv.Unordered"(%arg0, %arg1) : (f32, f32) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "cmpf"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "spirv.IsNan"(%arg0) : (f32) -> i1
    %1 = "spirv.IsNan"(%arg1) : (f32) -> i1
    %2 = "spirv.LogicalOr"(%0, %1) : (i1, i1) -> i1
    %3 = "spirv.LogicalNot"(%2) : (i1) -> i1
    %4 = "spirv.IsNan"(%arg0) : (f32) -> i1
    %5 = "spirv.IsNan"(%arg1) : (f32) -> i1
    %6 = "spirv.LogicalOr"(%4, %5) : (i1, i1) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "cmpi"}> ({
  ^bb0(%arg16: i32, %arg17: i32):
    %68 = "spirv.IEqual"(%arg16, %arg17) : (i32, i32) -> i1
    %69 = "spirv.INotEqual"(%arg16, %arg17) : (i32, i32) -> i1
    %70 = "spirv.SLessThan"(%arg16, %arg17) : (i32, i32) -> i1
    %71 = "spirv.SLessThanEqual"(%arg16, %arg17) : (i32, i32) -> i1
    %72 = "spirv.SGreaterThan"(%arg16, %arg17) : (i32, i32) -> i1
    %73 = "spirv.SGreaterThanEqual"(%arg16, %arg17) : (i32, i32) -> i1
    %74 = "spirv.ULessThan"(%arg16, %arg17) : (i32, i32) -> i1
    %75 = "spirv.ULessThanEqual"(%arg16, %arg17) : (i32, i32) -> i1
    %76 = "spirv.UGreaterThan"(%arg16, %arg17) : (i32, i32) -> i1
    %77 = "spirv.UGreaterThanEqual"(%arg16, %arg17) : (i32, i32) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> (), sym_name = "indexcmpi"}> ({
  ^bb0(%arg14: index, %arg15: index):
    %56 = "builtin.unrealized_conversion_cast"(%arg15) : (index) -> i32
    %57 = "builtin.unrealized_conversion_cast"(%arg14) : (index) -> i32
    %58 = "spirv.IEqual"(%57, %56) : (i32, i32) -> i1
    %59 = "spirv.INotEqual"(%57, %56) : (i32, i32) -> i1
    %60 = "spirv.SLessThan"(%57, %56) : (i32, i32) -> i1
    %61 = "spirv.SLessThanEqual"(%57, %56) : (i32, i32) -> i1
    %62 = "spirv.SGreaterThan"(%57, %56) : (i32, i32) -> i1
    %63 = "spirv.SGreaterThanEqual"(%57, %56) : (i32, i32) -> i1
    %64 = "spirv.ULessThan"(%57, %56) : (i32, i32) -> i1
    %65 = "spirv.ULessThanEqual"(%57, %56) : (i32, i32) -> i1
    %66 = "spirv.UGreaterThan"(%57, %56) : (i32, i32) -> i1
    %67 = "spirv.UGreaterThanEqual"(%57, %56) : (i32, i32) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xi32>, vector<1xi32>) -> (), sym_name = "vec1cmpi"}> ({
  ^bb0(%arg12: vector<1xi32>, %arg13: vector<1xi32>):
    %52 = "builtin.unrealized_conversion_cast"(%arg13) : (vector<1xi32>) -> i32
    %53 = "builtin.unrealized_conversion_cast"(%arg12) : (vector<1xi32>) -> i32
    %54 = "spirv.ULessThan"(%53, %52) : (i32, i32) -> i1
    %55 = "spirv.SGreaterThan"(%53, %52) : (i32, i32) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i1) -> (), sym_name = "boolcmpi_equality"}> ({
  ^bb0(%arg10: i1, %arg11: i1):
    %50 = "spirv.LogicalEqual"(%arg10, %arg11) : (i1, i1) -> i1
    %51 = "spirv.LogicalNotEqual"(%arg10, %arg11) : (i1, i1) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i1) -> (), sym_name = "boolcmpi_unsigned"}> ({
  ^bb0(%arg8: i1, %arg9: i1):
    %36 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %37 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %38 = "spirv.Select"(%arg8, %37, %36) : (i1, i32, i32) -> i32
    %39 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %40 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %41 = "spirv.Select"(%arg9, %40, %39) : (i1, i32, i32) -> i32
    %42 = "spirv.UGreaterThanEqual"(%38, %41) : (i32, i32) -> i1
    %43 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %44 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %45 = "spirv.Select"(%arg8, %44, %43) : (i1, i32, i32) -> i32
    %46 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %47 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %48 = "spirv.Select"(%arg9, %47, %46) : (i1, i32, i32) -> i32
    %49 = "spirv.ULessThan"(%45, %48) : (i32, i32) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xi1>, vector<1xi1>) -> (), sym_name = "vec1boolcmpi_equality"}> ({
  ^bb0(%arg6: vector<1xi1>, %arg7: vector<1xi1>):
    %32 = "builtin.unrealized_conversion_cast"(%arg7) : (vector<1xi1>) -> i1
    %33 = "builtin.unrealized_conversion_cast"(%arg6) : (vector<1xi1>) -> i1
    %34 = "spirv.LogicalEqual"(%33, %32) : (i1, i1) -> i1
    %35 = "spirv.LogicalNotEqual"(%33, %32) : (i1, i1) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xi1>, vector<1xi1>) -> (), sym_name = "vec1boolcmpi_unsigned"}> ({
  ^bb0(%arg4: vector<1xi1>, %arg5: vector<1xi1>):
    %16 = "builtin.unrealized_conversion_cast"(%arg5) : (vector<1xi1>) -> i1
    %17 = "builtin.unrealized_conversion_cast"(%arg4) : (vector<1xi1>) -> i1
    %18 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %19 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %20 = "spirv.Select"(%17, %19, %18) : (i1, i32, i32) -> i32
    %21 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %22 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %23 = "spirv.Select"(%16, %22, %21) : (i1, i32, i32) -> i32
    %24 = "spirv.UGreaterThanEqual"(%20, %23) : (i32, i32) -> i1
    %25 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %26 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %27 = "spirv.Select"(%17, %26, %25) : (i1, i32, i32) -> i32
    %28 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %29 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %30 = "spirv.Select"(%16, %29, %28) : (i1, i32, i32) -> i32
    %31 = "spirv.ULessThan"(%27, %30) : (i32, i32) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi1>, vector<4xi1>) -> (), sym_name = "vecboolcmpi_equality"}> ({
  ^bb0(%arg2: vector<4xi1>, %arg3: vector<4xi1>):
    %14 = "spirv.LogicalEqual"(%arg2, %arg3) : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    %15 = "spirv.LogicalNotEqual"(%arg2, %arg3) : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi1>, vector<3xi1>) -> (), sym_name = "vecboolcmpi_unsigned"}> ({
  ^bb0(%arg0: vector<3xi1>, %arg1: vector<3xi1>):
    %0 = "spirv.Constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "spirv.Constant"() <{value = dense<1> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "spirv.Select"(%arg0, %1, %0) : (vector<3xi1>, vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    %3 = "spirv.Constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
    %4 = "spirv.Constant"() <{value = dense<1> : vector<3xi32>}> : () -> vector<3xi32>
    %5 = "spirv.Select"(%arg1, %4, %3) : (vector<3xi1>, vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    %6 = "spirv.UGreaterThanEqual"(%2, %5) : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    %7 = "spirv.Constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
    %8 = "spirv.Constant"() <{value = dense<1> : vector<3xi32>}> : () -> vector<3xi32>
    %9 = "spirv.Select"(%arg0, %8, %7) : (vector<3xi1>, vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    %10 = "spirv.Constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
    %11 = "spirv.Constant"() <{value = dense<1> : vector<3xi32>}> : () -> vector<3xi32>
    %12 = "spirv.Select"(%arg1, %11, %10) : (vector<3xi1>, vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    %13 = "spirv.ULessThan"(%9, %12) : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "constant"}> ({
    %17 = "spirv.Constant"() <{value = true}> : () -> i1
    %18 = "spirv.Constant"() <{value = 42 : i32}> : () -> i32
    %19 = "spirv.Constant"() <{value = 5.000000e-01 : f32}> : () -> f32
    %20 = "spirv.Constant"() <{value = dense<[2, 3]> : vector<2xi32>}> : () -> vector<2xi32>
    %21 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %22 = "spirv.Constant"() <{value = dense<1> : tensor<6xi32>}> : () -> !spirv.array<6 x i32>
    %23 = "spirv.Constant"() <{value = dense<1.000000e+00> : tensor<6xf32>}> : () -> !spirv.array<6 x f32>
    %24 = "spirv.Constant"() <{value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00, 5.000000e+00, 6.000000e+00]> : tensor<6xf32>}> : () -> !spirv.array<6 x f32>
    %25 = "spirv.Constant"() <{value = dense<[1, 2, 3, 4, 5, 6]> : tensor<6xi32>}> : () -> !spirv.array<6 x i32>
    %26 = "spirv.Constant"() <{value = dense<[1, 2, 3, 4, 5, 6]> : tensor<6xi32>}> : () -> !spirv.array<6 x i32>
    %27 = "spirv.Constant"() <{value = dense<[1, 2, 3, 4, 5, 6]> : tensor<6xi32>}> : () -> !spirv.array<6 x i32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "constant_8bit_float"}> ({
    %11 = "spirv.Constant"() <{value = 56 : i8}> : () -> i8
    %12 = "spirv.Constant"() <{value = 56 : i8}> : () -> i8
    %13 = "spirv.Constant"() <{value = dense<56> : vector<4xi8>}> : () -> vector<4xi8>
    %14 = "spirv.Constant"() <{value = dense<56> : vector<4xi8>}> : () -> vector<4xi8>
    %15 = "spirv.Constant"() <{value = dense<60> : tensor<4xi8>}> : () -> !spirv.array<4 x i8>
    %16 = "spirv.Constant"() <{value = dense<60> : tensor<4xi8>}> : () -> !spirv.array<4 x i8>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "constant_16bit"}> ({
    %7 = "spirv.Constant"() <{value = 4 : i16}> : () -> i16
    %8 = "spirv.Constant"() <{value = 5.000000e+00 : f16}> : () -> f16
    %9 = "spirv.Constant"() <{value = dense<[2, 3]> : vector<2xi16>}> : () -> vector<2xi16>
    %10 = "spirv.Constant"() <{value = dense<4.000000e+00> : tensor<5xf16>}> : () -> !spirv.array<5 x f16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "constant_64bit"}> ({
    %3 = "spirv.Constant"() <{value = 4 : i64}> : () -> i64
    %4 = "spirv.Constant"() <{value = 5.000000e+00 : f64}> : () -> f64
    %5 = "spirv.Constant"() <{value = dense<[2, 3]> : vector<2xi64>}> : () -> vector<2xi64>
    %6 = "spirv.Constant"() <{value = dense<4.000000e+00> : tensor<5xf64>}> : () -> !spirv.array<5 x f64>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "constant_size1"}> ({
    %0 = "spirv.Constant"() <{value = true}> : () -> i1
    %1 = "spirv.Constant"() <{value = 4 : i64}> : () -> i64
    %2 = "spirv.Constant"() <{value = 5.000000e+00 : f64}> : () -> f64
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "constant_16bit"}> ({
    %8 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %9 = "spirv.Constant"() <{value = 5.000000e+00 : f32}> : () -> f32
    %10 = "spirv.Constant"() <{value = dense<[2, 3]> : vector<2xi32>}> : () -> vector<2xi32>
    %11 = "spirv.Constant"() <{value = dense<4.000000e+00> : tensor<5xf32>}> : () -> !spirv.array<5 x f32>
    %12 = "spirv.Constant"() <{value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : tensor<4xf32>}> : () -> !spirv.array<4 x f32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "constant_size1"}> ({
    %6 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %7 = "spirv.Constant"() <{value = 5.000000e+00 : f32}> : () -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "corner_cases"}> ({
    %0 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    %1 = "spirv.Constant"() <{value = -2 : i32}> : () -> i32
    %2 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    %3 = "spirv.Constant"() <{value = -2 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = false}> : () -> i1
    %5 = "spirv.Constant"() <{value = true}> : () -> i1
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i16) -> (), sym_name = "index_cast1"}> ({
  ^bb0(%arg45: i16):
    %89 = "spirv.SConvert"(%arg45) : (i16) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "index_cast2"}> ({
  ^bb0(%arg44: index):
    %87 = "builtin.unrealized_conversion_cast"(%arg44) : (index) -> i32
    %88 = "spirv.SConvert"(%87) : (i32) -> i16
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "index_cast3"}> ({
  ^bb0(%arg43: i32):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "index_cast4"}> ({
  ^bb0(%arg42: index):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i16) -> (), sym_name = "index_castui1"}> ({
  ^bb0(%arg41: i16):
    %86 = "spirv.UConvert"(%arg41) : (i16) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "index_castui2"}> ({
  ^bb0(%arg40: index):
    %84 = "builtin.unrealized_conversion_cast"(%arg40) : (index) -> i32
    %85 = "spirv.UConvert"(%84) : (i32) -> i16
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "index_castui3"}> ({
  ^bb0(%arg39: i32):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "index_castui4"}> ({
  ^bb0(%arg38: index):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "index_castindexi1_1"}> ({
  ^bb0(%arg37: index):
    %81 = "builtin.unrealized_conversion_cast"(%arg37) : (index) -> i32
    %82 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %83 = "spirv.INotEqual"(%82, %81) : (i32, i32) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xindex>) -> vector<1xi1>, sym_name = "index_castindexi1_2"}> ({
  ^bb0(%arg36: vector<1xindex>):
    %77 = "builtin.unrealized_conversion_cast"(%arg36) : (vector<1xindex>) -> i32
    %78 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %79 = "spirv.INotEqual"(%78, %77) : (i32, i32) -> i1
    %80 = "builtin.unrealized_conversion_cast"(%79) : (i1) -> vector<1xi1>
    "func.return"(%80) : (vector<1xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xindex>) -> (), sym_name = "index_castindexi1_3"}> ({
  ^bb0(%arg35: vector<3xindex>):
    %74 = "builtin.unrealized_conversion_cast"(%arg35) : (vector<3xindex>) -> vector<3xi32>
    %75 = "spirv.Constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
    %76 = "spirv.INotEqual"(%75, %74) : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "index_casti1index_1"}> ({
  ^bb0(%arg34: i1):
    %71 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %72 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %73 = "spirv.Select"(%arg34, %72, %71) : (i1, i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xi1>) -> vector<1xindex>, sym_name = "index_casti1index_2"}> ({
  ^bb0(%arg33: vector<1xi1>):
    %66 = "builtin.unrealized_conversion_cast"(%arg33) : (vector<1xi1>) -> i1
    %67 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %68 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %69 = "spirv.Select"(%66, %68, %67) : (i1, i32, i32) -> i32
    %70 = "builtin.unrealized_conversion_cast"(%69) : (i32) -> vector<1xindex>
    "func.return"(%70) : (vector<1xindex>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi1>) -> (), sym_name = "index_casti1index_3"}> ({
  ^bb0(%arg32: vector<3xi1>):
    %63 = "spirv.Constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
    %64 = "spirv.Constant"() <{value = dense<1> : vector<3xi32>}> : () -> vector<3xi32>
    %65 = "spirv.Select"(%arg32, %64, %63) : (vector<3xi1>, vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, i64) -> (), sym_name = "bit_cast"}> ({
  ^bb0(%arg30: vector<2xf32>, %arg31: i64):
    %61 = "spirv.Bitcast"(%arg30) : (vector<2xf32>) -> vector<2xi32>
    %62 = "spirv.Bitcast"(%arg31) : (i64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16) -> f64, sym_name = "fpext1"}> ({
  ^bb0(%arg29: f16):
    %60 = "spirv.FConvert"(%arg29) : (f16) -> f64
    "func.return"(%60) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f64, sym_name = "fpext2"}> ({
  ^bb0(%arg28: f32):
    %59 = "spirv.FConvert"(%arg28) : (f32) -> f64
    "func.return"(%59) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f64) -> f16, sym_name = "fptrunc1"}> ({
  ^bb0(%arg27: f64):
    %58 = "spirv.FConvert"(%arg27) : (f64) -> f16
    "func.return"(%58) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f16, sym_name = "fptrunc2"}> ({
  ^bb0(%arg26: f32):
    %57 = "spirv.FConvert"(%arg26) : (f32) -> f16
    "func.return"(%57) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f64) -> (), sym_name = "experimental_constrained_fptrunc"}> ({
  ^bb0(%arg25: f64):
    %53 = "spirv.FConvert"(%arg25) {fp_rounding_mode = #spirv.fp_rounding_mode<RTE>} : (f64) -> f32
    %54 = "spirv.FConvert"(%arg25) {fp_rounding_mode = #spirv.fp_rounding_mode<RTN>} : (f64) -> f32
    %55 = "spirv.FConvert"(%arg25) {fp_rounding_mode = #spirv.fp_rounding_mode<RTP>} : (f64) -> f32
    %56 = "spirv.FConvert"(%arg25) {fp_rounding_mode = #spirv.fp_rounding_mode<RTZ>} : (f64) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> f32, sym_name = "sitofp1"}> ({
  ^bb0(%arg24: i32):
    %52 = "spirv.ConvertSToF"(%arg24) : (i32) -> f32
    "func.return"(%52) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> f64, sym_name = "sitofp2"}> ({
  ^bb0(%arg23: i64):
    %51 = "spirv.ConvertSToF"(%arg23) : (i64) -> f64
    "func.return"(%51) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i16) -> f32, sym_name = "uitofp_i16_f32"}> ({
  ^bb0(%arg22: i16):
    %50 = "spirv.ConvertUToF"(%arg22) : (i16) -> f32
    "func.return"(%50) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> f32, sym_name = "uitofp_i32_f32"}> ({
  ^bb0(%arg21: i32):
    %49 = "spirv.ConvertUToF"(%arg21) : (i32) -> f32
    "func.return"(%49) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> f32, sym_name = "uitofp_i1_f32"}> ({
  ^bb0(%arg20: i1):
    %46 = "spirv.Constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %47 = "spirv.Constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %48 = "spirv.Select"(%arg20, %47, %46) : (i1, f32, f32) -> f32
    "func.return"(%48) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> f64, sym_name = "uitofp_i1_f64"}> ({
  ^bb0(%arg19: i1):
    %43 = "spirv.Constant"() <{value = 0.000000e+00 : f64}> : () -> f64
    %44 = "spirv.Constant"() <{value = 1.000000e+00 : f64}> : () -> f64
    %45 = "spirv.Select"(%arg19, %44, %43) : (i1, f64, f64) -> f64
    "func.return"(%45) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi1>) -> vector<4xf32>, sym_name = "uitofp_vec_i1_f32"}> ({
  ^bb0(%arg18: vector<4xi1>):
    %40 = "spirv.Constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %41 = "spirv.Constant"() <{value = dense<1.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %42 = "spirv.Select"(%arg18, %41, %40) : (vector<4xi1>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"(%42) : (vector<4xf32>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi1>) -> vector<4xf64>, sym_name = "uitofp_vec_i1_f64"}> ({
  ^bb0(%arg17: vector<4xi1>):
    %37 = "spirv.Constant"() <{value = dense<0.000000e+00> : vector<4xf64>}> : () -> vector<4xf64>
    %38 = "spirv.Constant"() <{value = dense<1.000000e+00> : vector<4xf64>}> : () -> vector<4xf64>
    %39 = "spirv.Select"(%arg17, %38, %37) : (vector<4xi1>, vector<4xf64>, vector<4xf64>) -> vector<4xf64>
    "spirv.ReturnValue"(%39) : (vector<4xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i16) -> i64, sym_name = "sexti1"}> ({
  ^bb0(%arg16: i16):
    %36 = "spirv.SConvert"(%arg16) : (i16) -> i64
    "func.return"(%36) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i64, sym_name = "sexti2"}> ({
  ^bb0(%arg15: i32):
    %35 = "spirv.SConvert"(%arg15) : (i32) -> i64
    "func.return"(%35) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i32, sym_name = "sext_bool_scalar"}> ({
  ^bb0(%arg14: i1):
    %32 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    %33 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %34 = "spirv.Select"(%arg14, %32, %33) : (i1, i32, i32) -> i32
    "func.return"(%34) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi1>) -> vector<3xi32>, sym_name = "sext_bool_vector"}> ({
  ^bb0(%arg13: vector<3xi1>):
    %29 = "spirv.Constant"() <{value = dense<-1> : vector<3xi32>}> : () -> vector<3xi32>
    %30 = "spirv.Constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
    %31 = "spirv.Select"(%arg13, %29, %30) : (vector<3xi1>, vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%31) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i16) -> i64, sym_name = "zexti1"}> ({
  ^bb0(%arg12: i16):
    %28 = "spirv.UConvert"(%arg12) : (i16) -> i64
    "func.return"(%28) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i64, sym_name = "zexti2"}> ({
  ^bb0(%arg11: i32):
    %27 = "spirv.UConvert"(%arg11) : (i32) -> i64
    "func.return"(%27) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i32, sym_name = "zexti3"}> ({
  ^bb0(%arg10: i1):
    %24 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %25 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %26 = "spirv.Select"(%arg10, %25, %24) : (i1, i32, i32) -> i32
    "func.return"(%26) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi1>) -> vector<4xi32>, sym_name = "zexti4"}> ({
  ^bb0(%arg9: vector<4xi1>):
    %21 = "spirv.Constant"() <{value = dense<0> : vector<4xi32>}> : () -> vector<4xi32>
    %22 = "spirv.Constant"() <{value = dense<1> : vector<4xi32>}> : () -> vector<4xi32>
    %23 = "spirv.Select"(%arg9, %22, %21) : (vector<4xi1>, vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"(%23) : (vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi1>) -> vector<4xi64>, sym_name = "zexti5"}> ({
  ^bb0(%arg8: vector<4xi1>):
    %18 = "spirv.Constant"() <{value = dense<0> : vector<4xi64>}> : () -> vector<4xi64>
    %19 = "spirv.Constant"() <{value = dense<1> : vector<4xi64>}> : () -> vector<4xi64>
    %20 = "spirv.Select"(%arg8, %19, %18) : (vector<4xi1>, vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    "func.return"(%20) : (vector<4xi64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i16, sym_name = "trunci1"}> ({
  ^bb0(%arg7: i64):
    %17 = "spirv.SConvert"(%arg7) : (i64) -> i16
    "func.return"(%17) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i16, sym_name = "trunci2"}> ({
  ^bb0(%arg6: i32):
    %16 = "spirv.SConvert"(%arg6) : (i32) -> i16
    "func.return"(%16) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i1, sym_name = "trunc_to_i1"}> ({
  ^bb0(%arg5: i32):
    %10 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %11 = "spirv.BitwiseAnd"(%arg5, %10) : (i32, i32) -> i32
    %12 = "spirv.IEqual"(%11, %10) : (i32, i32) -> i1
    %13 = "spirv.Constant"() <{value = false}> : () -> i1
    %14 = "spirv.Constant"() <{value = true}> : () -> i1
    %15 = "spirv.Select"(%12, %14, %13) : (i1, i1, i1) -> i1
    "func.return"(%15) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> vector<4xi1>, sym_name = "trunc_to_veci1"}> ({
  ^bb0(%arg4: vector<4xi32>):
    %4 = "spirv.Constant"() <{value = dense<1> : vector<4xi32>}> : () -> vector<4xi32>
    %5 = "spirv.BitwiseAnd"(%arg4, %4) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %6 = "spirv.IEqual"(%5, %4) : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
    %7 = "spirv.Constant"() <{value = dense<false> : vector<4xi1>}> : () -> vector<4xi1>
    %8 = "spirv.Constant"() <{value = dense<true> : vector<4xi1>}> : () -> vector<4xi1>
    %9 = "spirv.Select"(%6, %8, %7) : (vector<4xi1>, vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    "func.return"(%9) : (vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> i32, sym_name = "fptoui1"}> ({
  ^bb0(%arg3: f32):
    %3 = "spirv.ConvertFToU"(%arg3) : (f32) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16) -> i16, sym_name = "fptoui2"}> ({
  ^bb0(%arg2: f16):
    %2 = "spirv.ConvertFToU"(%arg2) : (f16) -> i16
    "func.return"(%2) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> i32, sym_name = "fptosi1"}> ({
  ^bb0(%arg1: f32):
    %1 = "spirv.ConvertFToS"(%arg1) : (f32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16) -> i16, sym_name = "fptosi2"}> ({
  ^bb0(%arg0: f16):
    %0 = "spirv.ConvertFToS"(%arg0) : (f16) -> i16
    "func.return"(%0) : (i16) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f16) -> f64, sym_name = "fpext1"}> ({
  ^bb0(%arg7: f16):
    %21 = "builtin.unrealized_conversion_cast"(%arg7) : (f16) -> f32
    %22 = "spirv.FConvert"(%21) : (f32) -> f64
    "func.return"(%22) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f64, sym_name = "fpext2"}> ({
  ^bb0(%arg6: f32):
    %20 = "spirv.FConvert"(%arg6) : (f32) -> f64
    "func.return"(%20) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i4, sym_name = "trunci4_scalar"}> ({
  ^bb0(%arg5: i32):
    %17 = "spirv.Constant"() <{value = 15 : i32}> : () -> i32
    %18 = "spirv.BitwiseAnd"(%arg5, %17) : (i32, i32) -> i32
    %19 = "builtin.unrealized_conversion_cast"(%18) : (i32) -> i4
    "func.return"(%19) : (i4) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi32>) -> vector<2xi4>, sym_name = "trunci4_vector"}> ({
  ^bb0(%arg4: vector<2xi32>):
    %14 = "spirv.Constant"() <{value = dense<15> : vector<2xi32>}> : () -> vector<2xi32>
    %15 = "spirv.BitwiseAnd"(%arg4, %14) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %16 = "builtin.unrealized_conversion_cast"(%15) : (vector<2xi32>) -> vector<2xi4>
    "func.return"(%16) : (vector<2xi4>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i4) -> i32, sym_name = "zexti4_scalar"}> ({
  ^bb0(%arg3: i4):
    %11 = "builtin.unrealized_conversion_cast"(%arg3) : (i4) -> i32
    %12 = "spirv.Constant"() <{value = 15 : i32}> : () -> i32
    %13 = "spirv.BitwiseAnd"(%11, %12) : (i32, i32) -> i32
    "func.return"(%13) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi4>) -> vector<3xi32>, sym_name = "zexti4_vector"}> ({
  ^bb0(%arg2: vector<3xi4>):
    %8 = "builtin.unrealized_conversion_cast"(%arg2) : (vector<3xi4>) -> vector<3xi32>
    %9 = "spirv.Constant"() <{value = dense<15> : vector<3xi32>}> : () -> vector<3xi32>
    %10 = "spirv.BitwiseAnd"(%8, %9) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%10) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i4) -> i32, sym_name = "sexti4_scalar"}> ({
  ^bb0(%arg1: i4):
    %4 = "builtin.unrealized_conversion_cast"(%arg1) : (i4) -> i32
    %5 = "spirv.Constant"() <{value = 28 : i32}> : () -> i32
    %6 = "spirv.ShiftLeftLogical"(%4, %5) : (i32, i32) -> i32
    %7 = "spirv.ShiftRightArithmetic"(%6, %5) : (i32, i32) -> i32
    "func.return"(%7) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi4>) -> vector<4xi32>, sym_name = "sexti4_vector"}> ({
  ^bb0(%arg0: vector<4xi4>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<4xi4>) -> vector<4xi32>
    %1 = "spirv.Constant"() <{value = dense<28> : vector<4xi32>}> : () -> vector<4xi32>
    %2 = "spirv.ShiftLeftLogical"(%0, %1) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %3 = "spirv.ShiftRightArithmetic"(%2, %1) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"(%3) : (vector<4xi32>) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Float64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> f16, sym_name = "fptrunc1"}> ({
  ^bb0(%arg0: f32):
    %0 = "spirv.FConvert"(%arg0) : (f32) -> f16
    "func.return"(%0) : (f16) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Float16], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "int32_scalar"}> ({
  ^bb0(%arg14: i32, %arg15: i32):
    %29 = "spirv.IAdd"(%arg14, %arg15) : (i32, i32) -> i32
    %30 = "spirv.ISub"(%arg14, %arg15) : (i32, i32) -> i32
    %31 = "spirv.IMul"(%arg14, %arg15) : (i32, i32) -> i32
    %32 = "spirv.SDiv"(%arg14, %arg15) : (i32, i32) -> i32
    %33 = "spirv.UDiv"(%arg14, %arg15) : (i32, i32) -> i32
    %34 = "spirv.UMod"(%arg14, %arg15) : (i32, i32) -> i32
    %35 = "spirv.CL.s_max"(%arg14, %arg15) : (i32, i32) -> i32
    %36 = "spirv.CL.u_max"(%arg14, %arg15) : (i32, i32) -> i32
    %37 = "spirv.CL.s_min"(%arg14, %arg15) : (i32, i32) -> i32
    %38 = "spirv.CL.u_min"(%arg14, %arg15) : (i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "float32_binary_scalar"}> ({
  ^bb0(%arg12: f32, %arg13: f32):
    %24 = "spirv.FAdd"(%arg12, %arg13) : (f32, f32) -> f32
    %25 = "spirv.FSub"(%arg12, %arg13) : (f32, f32) -> f32
    %26 = "spirv.FMul"(%arg12, %arg13) : (f32, f32) -> f32
    %27 = "spirv.FDiv"(%arg12, %arg13) : (f32, f32) -> f32
    %28 = "spirv.FRem"(%arg12, %arg13) : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "float32_minimumf_scalar"}> ({
  ^bb0(%arg10: f32, %arg11: f32):
    %19 = "spirv.CL.fmin"(%arg10, %arg11) : (f32, f32) -> f32
    %20 = "spirv.IsNan"(%arg10) : (f32) -> i1
    %21 = "spirv.IsNan"(%arg11) : (f32) -> i1
    %22 = "spirv.Select"(%20, %arg10, %19) : (i1, f32, f32) -> f32
    %23 = "spirv.Select"(%21, %arg11, %22) : (i1, f32, f32) -> f32
    "func.return"(%23) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "float32_minnumf_scalar"}> ({
  ^bb0(%arg8: f32, %arg9: f32):
    %18 = "spirv.CL.fmin"(%arg8, %arg9) : (f32, f32) -> f32
    "func.return"(%18) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf32>) -> vector<2xf32>, sym_name = "float32_maximumf_scalar"}> ({
  ^bb0(%arg6: vector<2xf32>, %arg7: vector<2xf32>):
    %13 = "spirv.CL.fmax"(%arg6, %arg7) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %14 = "spirv.IsNan"(%arg6) : (vector<2xf32>) -> vector<2xi1>
    %15 = "spirv.IsNan"(%arg7) : (vector<2xf32>) -> vector<2xi1>
    %16 = "spirv.Select"(%14, %arg6, %13) : (vector<2xi1>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %17 = "spirv.Select"(%15, %arg7, %16) : (vector<2xi1>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "func.return"(%17) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf32>) -> vector<2xf32>, sym_name = "float32_maxnumf_scalar"}> ({
  ^bb0(%arg4: vector<2xf32>, %arg5: vector<2xf32>):
    %12 = "spirv.CL.fmax"(%arg4, %arg5) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "func.return"(%12) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "scalar_srem"}> ({
  ^bb0(%arg2: i32, %arg3: i32):
    %6 = "spirv.CL.s_abs"(%arg2) : (i32) -> i32
    %7 = "spirv.CL.s_abs"(%arg3) : (i32) -> i32
    %8 = "spirv.UMod"(%6, %7) : (i32, i32) -> i32
    %9 = "spirv.IEqual"(%arg2, %6) : (i32, i32) -> i1
    %10 = "spirv.SNegate"(%8) : (i32) -> i32
    %11 = "spirv.Select"(%9, %8, %10) : (i1, i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi16>, vector<3xi16>) -> (), sym_name = "vector_srem"}> ({
  ^bb0(%arg0: vector<3xi16>, %arg1: vector<3xi16>):
    %0 = "spirv.CL.s_abs"(%arg0) : (vector<3xi16>) -> vector<3xi16>
    %1 = "spirv.CL.s_abs"(%arg1) : (vector<3xi16>) -> vector<3xi16>
    %2 = "spirv.UMod"(%0, %1) : (vector<3xi16>, vector<3xi16>) -> vector<3xi16>
    %3 = "spirv.IEqual"(%arg0, %0) : (vector<3xi16>, vector<3xi16>) -> vector<3xi1>
    %4 = "spirv.SNegate"(%2) : (vector<3xi16>) -> vector<3xi16>
    %5 = "spirv.Select"(%3, %2, %4) : (vector<3xi1>, vector<3xi16>, vector<3xi16>) -> vector<3xi16>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int16, Kernel], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "select"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "spirv.SLessThanEqual"(%arg0, %arg1) : (i32, i32) -> i1
    %1 = "spirv.Select"(%0, %arg0, %arg1) : (i1, i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int8, Int16, Int64, Float16, Float64], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "int32_scalar"}> ({
  ^bb0(%arg20: i32, %arg21: i32):
    %44 = "spirv.IAdd"(%arg20, %arg21) : (i32, i32) -> i32
    %45 = "spirv.ISub"(%arg20, %arg21) : (i32, i32) -> i32
    %46 = "spirv.IMul"(%arg20, %arg21) : (i32, i32) -> i32
    %47 = "spirv.SDiv"(%arg20, %arg21) : (i32, i32) -> i32
    %48 = "spirv.UDiv"(%arg20, %arg21) : (i32, i32) -> i32
    %49 = "spirv.UMod"(%arg20, %arg21) : (i32, i32) -> i32
    %50 = "spirv.GL.SMax"(%arg20, %arg21) : (i32, i32) -> i32
    %51 = "spirv.GL.UMax"(%arg20, %arg21) : (i32, i32) -> i32
    %52 = "spirv.GL.SMin"(%arg20, %arg21) : (i32, i32) -> i32
    %53 = "spirv.GL.UMin"(%arg20, %arg21) : (i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "scalar_srem"}> ({
  ^bb0(%arg18: i32, %arg19: i32):
    %38 = "spirv.GL.SAbs"(%arg18) : (i32) -> i32
    %39 = "spirv.GL.SAbs"(%arg19) : (i32) -> i32
    %40 = "spirv.UMod"(%38, %39) : (i32, i32) -> i32
    %41 = "spirv.IEqual"(%arg18, %38) : (i32, i32) -> i1
    %42 = "spirv.SNegate"(%40) : (i32) -> i32
    %43 = "spirv.Select"(%41, %40, %42) : (i1, i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> (), sym_name = "float32_unary_scalar"}> ({
  ^bb0(%arg17: f32):
    %37 = "spirv.FNegate"(%arg17) : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "float32_binary_scalar"}> ({
  ^bb0(%arg15: f32, %arg16: f32):
    %32 = "spirv.FAdd"(%arg15, %arg16) : (f32, f32) -> f32
    %33 = "spirv.FSub"(%arg15, %arg16) : (f32, f32) -> f32
    %34 = "spirv.FMul"(%arg15, %arg16) : (f32, f32) -> f32
    %35 = "spirv.FDiv"(%arg15, %arg16) : (f32, f32) -> f32
    %36 = "spirv.FRem"(%arg15, %arg16) : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "float32_minimumf_scalar"}> ({
  ^bb0(%arg13: f32, %arg14: f32):
    %27 = "spirv.GL.FMin"(%arg13, %arg14) : (f32, f32) -> f32
    %28 = "spirv.IsNan"(%arg13) : (f32) -> i1
    %29 = "spirv.IsNan"(%arg14) : (f32) -> i1
    %30 = "spirv.Select"(%28, %arg13, %27) : (i1, f32, f32) -> f32
    %31 = "spirv.Select"(%29, %arg14, %30) : (i1, f32, f32) -> f32
    "func.return"(%31) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "float32_minnumf_scalar"}> ({
  ^bb0(%arg11: f32, %arg12: f32):
    %22 = "spirv.GL.FMin"(%arg11, %arg12) : (f32, f32) -> f32
    %23 = "spirv.IsNan"(%arg11) : (f32) -> i1
    %24 = "spirv.IsNan"(%arg12) : (f32) -> i1
    %25 = "spirv.Select"(%23, %arg12, %22) : (i1, f32, f32) -> f32
    %26 = "spirv.Select"(%24, %arg11, %25) : (i1, f32, f32) -> f32
    "func.return"(%26) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf32>) -> vector<2xf32>, sym_name = "float32_maximumf_scalar"}> ({
  ^bb0(%arg9: vector<2xf32>, %arg10: vector<2xf32>):
    %17 = "spirv.GL.FMax"(%arg9, %arg10) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %18 = "spirv.IsNan"(%arg9) : (vector<2xf32>) -> vector<2xi1>
    %19 = "spirv.IsNan"(%arg10) : (vector<2xf32>) -> vector<2xi1>
    %20 = "spirv.Select"(%18, %arg9, %17) : (vector<2xi1>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %21 = "spirv.Select"(%19, %arg10, %20) : (vector<2xi1>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "func.return"(%21) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf32>) -> vector<2xf32>, sym_name = "float32_maxnumf_scalar"}> ({
  ^bb0(%arg7: vector<2xf32>, %arg8: vector<2xf32>):
    %12 = "spirv.GL.FMax"(%arg7, %arg8) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %13 = "spirv.IsNan"(%arg7) : (vector<2xf32>) -> vector<2xi1>
    %14 = "spirv.IsNan"(%arg8) : (vector<2xf32>) -> vector<2xi1>
    %15 = "spirv.Select"(%13, %arg8, %12) : (vector<2xi1>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %16 = "spirv.Select"(%14, %arg7, %15) : (vector<2xi1>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "func.return"(%16) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi8>, vector<4xi64>) -> (), sym_name = "int_vector234"}> ({
  ^bb0(%arg5: vector<2xi8>, %arg6: vector<4xi64>):
    %10 = "spirv.SDiv"(%arg5, %arg5) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %11 = "spirv.UDiv"(%arg6, %arg6) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi16>, vector<3xi16>) -> (), sym_name = "vector_srem"}> ({
  ^bb0(%arg3: vector<3xi16>, %arg4: vector<3xi16>):
    %4 = "spirv.GL.SAbs"(%arg3) : (vector<3xi16>) -> vector<3xi16>
    %5 = "spirv.GL.SAbs"(%arg4) : (vector<3xi16>) -> vector<3xi16>
    %6 = "spirv.UMod"(%4, %5) : (vector<3xi16>, vector<3xi16>) -> vector<3xi16>
    %7 = "spirv.IEqual"(%arg3, %4) : (vector<3xi16>, vector<3xi16>) -> vector<3xi1>
    %8 = "spirv.SNegate"(%6) : (vector<3xi16>) -> vector<3xi16>
    %9 = "spirv.Select"(%7, %6, %8) : (vector<3xi1>, vector<3xi16>, vector<3xi16>) -> vector<3xi16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf16>, vector<3xf64>) -> (), sym_name = "float_vector234"}> ({
  ^bb0(%arg1: vector<2xf16>, %arg2: vector<3xf64>):
    %2 = "spirv.FAdd"(%arg1, %arg1) : (vector<2xf16>, vector<2xf16>) -> vector<2xf16>
    %3 = "spirv.FMul"(%arg2, %arg2) : (vector<3xf64>, vector<3xf64>) -> vector<3xf64>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xi32>) -> (), sym_name = "one_elem_vector"}> ({
  ^bb0(%arg0: vector<1xi32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<1xi32>) -> i32
    %1 = "spirv.IAdd"(%0, %0) : (i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64, Shader], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xi8>, vector<3xi16>) -> (), sym_name = "int_vector23"}> ({
  ^bb0(%arg1: vector<2xi8>, %arg2: vector<3xi16>):
    %2 = "builtin.unrealized_conversion_cast"(%arg2) : (vector<3xi16>) -> vector<3xi32>
    %3 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<2xi8>) -> vector<2xi32>
    %4 = "spirv.SDiv"(%3, %3) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %5 = "spirv.SDiv"(%2, %2) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16) -> (), sym_name = "float_scalar"}> ({
  ^bb0(%arg0: f16):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (f16) -> f32
    %1 = "spirv.FAdd"(%0, %0) : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64, i64) -> (), sym_name = "ops_flags"}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "spirv.IAdd"(%arg0, %arg1) {no_signed_wrap} : (i64, i64) -> i64
    %1 = "spirv.ISub"(%arg0, %arg1) {no_unsigned_wrap} : (i64, i64) -> i64
    %2 = "spirv.IMul"(%arg0, %arg1) {no_signed_wrap, no_unsigned_wrap} : (i64, i64) -> i64
    %3 = "spirv.ShiftLeftLogical"(%arg0, %arg1) {no_signed_wrap, no_unsigned_wrap} : (i64, i64) -> i64
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64, Kernel], [SPV_KHR_no_integer_wrap_decoration]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64, i64) -> (), sym_name = "ops_flags"}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "spirv.IAdd"(%arg0, %arg1) : (i64, i64) -> i64
    %1 = "spirv.ISub"(%arg0, %arg1) : (i64, i64) -> i64
    %2 = "spirv.IMul"(%arg0, %arg1) : (i64, i64) -> i64
    %3 = "spirv.IMul"(%arg0, %arg1) : (i64, i64) -> i64
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64], []>, #spirv.resource_limits<>>} : () -> ()

