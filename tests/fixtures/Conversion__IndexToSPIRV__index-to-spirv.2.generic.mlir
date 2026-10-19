"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (), sym_name = "trivial_ops"}> ({
  ^bb0(%arg13: index, %arg14: index):
    %75 = "builtin.unrealized_conversion_cast"(%arg14) : (index) -> i64
    %76 = "builtin.unrealized_conversion_cast"(%arg13) : (index) -> i64
    %77 = "spirv.IAdd"(%76, %75) : (i64, i64) -> i64
    %78 = "spirv.ISub"(%76, %75) : (i64, i64) -> i64
    %79 = "spirv.IMul"(%76, %75) : (i64, i64) -> i64
    %80 = "spirv.SDiv"(%76, %75) : (i64, i64) -> i64
    %81 = "spirv.UDiv"(%76, %75) : (i64, i64) -> i64
    %82 = "spirv.SRem"(%76, %75) : (i64, i64) -> i64
    %83 = "spirv.UMod"(%76, %75) : (i64, i64) -> i64
    %84 = "spirv.GL.SMax"(%76, %75) : (i64, i64) -> i64
    %85 = "spirv.GL.UMax"(%76, %75) : (i64, i64) -> i64
    %86 = "spirv.GL.SMin"(%76, %75) : (i64, i64) -> i64
    %87 = "spirv.GL.UMin"(%76, %75) : (i64, i64) -> i64
    %88 = "spirv.ShiftLeftLogical"(%76, %75) : (i64, i64) -> i64
    %89 = "spirv.ShiftRightArithmetic"(%76, %75) : (i64, i64) -> i64
    %90 = "spirv.ShiftRightLogical"(%76, %75) : (i64, i64) -> i64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> (), sym_name = "bitwise_ops"}> ({
  ^bb0(%arg11: index, %arg12: index):
    %70 = "builtin.unrealized_conversion_cast"(%arg12) : (index) -> i64
    %71 = "builtin.unrealized_conversion_cast"(%arg11) : (index) -> i64
    %72 = "spirv.BitwiseAnd"(%71, %70) : (i64, i64) -> i64
    %73 = "spirv.BitwiseOr"(%71, %70) : (i64, i64) -> i64
    %74 = "spirv.BitwiseXor"(%71, %70) : (i64, i64) -> i64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "constant_ops"}> ({
    %67 = "spirv.Constant"() <{value = 42 : i64}> : () -> i64
    %68 = "spirv.Constant"() <{value = true}> : () -> i1
    %69 = "spirv.Constant"() <{value = false}> : () -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "ceildivs"}> ({
  ^bb0(%arg9: index, %arg10: index):
    %48 = "builtin.unrealized_conversion_cast"(%arg10) : (index) -> i64
    %49 = "builtin.unrealized_conversion_cast"(%arg9) : (index) -> i64
    %50 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %51 = "spirv.Constant"() <{value = 1 : i64}> : () -> i64
    %52 = "spirv.Constant"() <{value = -1 : i64}> : () -> i64
    %53 = "spirv.SGreaterThan"(%48, %50) : (i64, i64) -> i1
    %54 = "spirv.Select"(%53, %52, %51) : (i1, i64, i64) -> i64
    %55 = "spirv.IAdd"(%49, %54) : (i64, i64) -> i64
    %56 = "spirv.SDiv"(%55, %48) : (i64, i64) -> i64
    %57 = "spirv.IAdd"(%56, %51) : (i64, i64) -> i64
    %58 = "spirv.ISub"(%50, %49) : (i64, i64) -> i64
    %59 = "spirv.SDiv"(%58, %48) : (i64, i64) -> i64
    %60 = "spirv.ISub"(%50, %59) : (i64, i64) -> i64
    %61 = "spirv.SGreaterThan"(%49, %50) : (i64, i64) -> i1
    %62 = "spirv.LogicalEqual"(%61, %53) : (i1, i1) -> i1
    %63 = "spirv.INotEqual"(%49, %50) : (i64, i64) -> i1
    %64 = "spirv.LogicalAnd"(%62, %63) : (i1, i1) -> i1
    %65 = "spirv.Select"(%64, %57, %60) : (i1, i64, i64) -> i64
    %66 = "builtin.unrealized_conversion_cast"(%65) : (i64) -> index
    "func.return"(%66) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "ceildivu"}> ({
  ^bb0(%arg7: index, %arg8: index):
    %38 = "builtin.unrealized_conversion_cast"(%arg8) : (index) -> i64
    %39 = "builtin.unrealized_conversion_cast"(%arg7) : (index) -> i64
    %40 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %41 = "spirv.Constant"() <{value = 1 : i64}> : () -> i64
    %42 = "spirv.ISub"(%39, %41) : (i64, i64) -> i64
    %43 = "spirv.UDiv"(%42, %38) : (i64, i64) -> i64
    %44 = "spirv.IAdd"(%43, %41) : (i64, i64) -> i64
    %45 = "spirv.IEqual"(%39, %40) : (i64, i64) -> i1
    %46 = "spirv.Select"(%45, %40, %44) : (i1, i64, i64) -> i64
    %47 = "builtin.unrealized_conversion_cast"(%46) : (i64) -> index
    "func.return"(%47) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "floordivs"}> ({
  ^bb0(%arg5: index, %arg6: index):
    %21 = "builtin.unrealized_conversion_cast"(%arg6) : (index) -> i64
    %22 = "builtin.unrealized_conversion_cast"(%arg5) : (index) -> i64
    %23 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %24 = "spirv.Constant"() <{value = 1 : i64}> : () -> i64
    %25 = "spirv.Constant"() <{value = -1 : i64}> : () -> i64
    %26 = "spirv.SLessThan"(%21, %23) : (i64, i64) -> i1
    %27 = "spirv.Select"(%26, %24, %25) : (i1, i64, i64) -> i64
    %28 = "spirv.ISub"(%27, %22) : (i64, i64) -> i64
    %29 = "spirv.SDiv"(%28, %21) : (i64, i64) -> i64
    %30 = "spirv.ISub"(%25, %29) : (i64, i64) -> i64
    %31 = "spirv.SDiv"(%22, %21) : (i64, i64) -> i64
    %32 = "spirv.SLessThan"(%22, %23) : (i64, i64) -> i1
    %33 = "spirv.LogicalNotEqual"(%32, %26) : (i1, i1) -> i1
    %34 = "spirv.INotEqual"(%22, %23) : (i64, i64) -> i1
    %35 = "spirv.LogicalAnd"(%33, %34) : (i1, i1) -> i1
    %36 = "spirv.Select"(%35, %31, %30) : (i1, i64, i64) -> i64
    %37 = "builtin.unrealized_conversion_cast"(%36) : (i64) -> index
    "func.return"(%37) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> (), sym_name = "index_cmp"}> ({
  ^bb0(%arg3: index, %arg4: index):
    %9 = "builtin.unrealized_conversion_cast"(%arg4) : (index) -> i64
    %10 = "builtin.unrealized_conversion_cast"(%arg3) : (index) -> i64
    %11 = "spirv.IEqual"(%10, %9) : (i64, i64) -> i1
    %12 = "spirv.INotEqual"(%10, %9) : (i64, i64) -> i1
    %13 = "spirv.SLessThan"(%10, %9) : (i64, i64) -> i1
    %14 = "spirv.SLessThanEqual"(%10, %9) : (i64, i64) -> i1
    %15 = "spirv.SGreaterThan"(%10, %9) : (i64, i64) -> i1
    %16 = "spirv.SGreaterThanEqual"(%10, %9) : (i64, i64) -> i1
    %17 = "spirv.ULessThan"(%10, %9) : (i64, i64) -> i1
    %18 = "spirv.ULessThanEqual"(%10, %9) : (i64, i64) -> i1
    %19 = "spirv.UGreaterThan"(%10, %9) : (i64, i64) -> i1
    %20 = "spirv.UGreaterThanEqual"(%10, %9) : (i64, i64) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "index_sizeof"}> ({
    %8 = "spirv.Constant"() <{value = 64 : i64}> : () -> i64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (i64, i32, i64, i32), sym_name = "index_cast_from"}> ({
  ^bb0(%arg2: index):
    %5 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %6 = "spirv.SConvert"(%5) : (i64) -> i32
    %7 = "spirv.UConvert"(%5) : (i64) -> i32
    "func.return"(%5, %6, %5, %7) : (i64, i32, i64, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i64) -> (index, index, index, index), sym_name = "index_cast_to"}> ({
  ^bb0(%arg0: i32, %arg1: i64):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (i64) -> index
    %1 = "spirv.SConvert"(%arg0) : (i32) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> index
    %3 = "spirv.UConvert"(%arg0) : (i32) -> i64
    %4 = "builtin.unrealized_conversion_cast"(%3) : (i64) -> index
    "func.return"(%2, %0, %4, %0) : (index, index, index, index) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int64], []>, #spirv.resource_limits<>>} : () -> ()

