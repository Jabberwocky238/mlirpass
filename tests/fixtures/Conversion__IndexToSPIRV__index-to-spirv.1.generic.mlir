"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (), sym_name = "trivial_ops"}> ({
  ^bb0(%arg13: index, %arg14: index):
    %75 = "builtin.unrealized_conversion_cast"(%arg14) : (index) -> i32
    %76 = "builtin.unrealized_conversion_cast"(%arg13) : (index) -> i32
    %77 = "spirv.IAdd"(%76, %75) : (i32, i32) -> i32
    %78 = "spirv.ISub"(%76, %75) : (i32, i32) -> i32
    %79 = "spirv.IMul"(%76, %75) : (i32, i32) -> i32
    %80 = "spirv.SDiv"(%76, %75) : (i32, i32) -> i32
    %81 = "spirv.UDiv"(%76, %75) : (i32, i32) -> i32
    %82 = "spirv.SRem"(%76, %75) : (i32, i32) -> i32
    %83 = "spirv.UMod"(%76, %75) : (i32, i32) -> i32
    %84 = "spirv.GL.SMax"(%76, %75) : (i32, i32) -> i32
    %85 = "spirv.GL.UMax"(%76, %75) : (i32, i32) -> i32
    %86 = "spirv.GL.SMin"(%76, %75) : (i32, i32) -> i32
    %87 = "spirv.GL.UMin"(%76, %75) : (i32, i32) -> i32
    %88 = "spirv.ShiftLeftLogical"(%76, %75) : (i32, i32) -> i32
    %89 = "spirv.ShiftRightArithmetic"(%76, %75) : (i32, i32) -> i32
    %90 = "spirv.ShiftRightLogical"(%76, %75) : (i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> (), sym_name = "bitwise_ops"}> ({
  ^bb0(%arg11: index, %arg12: index):
    %70 = "builtin.unrealized_conversion_cast"(%arg12) : (index) -> i32
    %71 = "builtin.unrealized_conversion_cast"(%arg11) : (index) -> i32
    %72 = "spirv.BitwiseAnd"(%71, %70) : (i32, i32) -> i32
    %73 = "spirv.BitwiseOr"(%71, %70) : (i32, i32) -> i32
    %74 = "spirv.BitwiseXor"(%71, %70) : (i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "constant_ops"}> ({
    %67 = "spirv.Constant"() <{value = 42 : i32}> : () -> i32
    %68 = "spirv.Constant"() <{value = true}> : () -> i1
    %69 = "spirv.Constant"() <{value = false}> : () -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "ceildivs"}> ({
  ^bb0(%arg9: index, %arg10: index):
    %48 = "builtin.unrealized_conversion_cast"(%arg10) : (index) -> i32
    %49 = "builtin.unrealized_conversion_cast"(%arg9) : (index) -> i32
    %50 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %51 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %52 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    %53 = "spirv.SGreaterThan"(%48, %50) : (i32, i32) -> i1
    %54 = "spirv.Select"(%53, %52, %51) : (i1, i32, i32) -> i32
    %55 = "spirv.IAdd"(%49, %54) : (i32, i32) -> i32
    %56 = "spirv.SDiv"(%55, %48) : (i32, i32) -> i32
    %57 = "spirv.IAdd"(%56, %51) : (i32, i32) -> i32
    %58 = "spirv.ISub"(%50, %49) : (i32, i32) -> i32
    %59 = "spirv.SDiv"(%58, %48) : (i32, i32) -> i32
    %60 = "spirv.ISub"(%50, %59) : (i32, i32) -> i32
    %61 = "spirv.SGreaterThan"(%49, %50) : (i32, i32) -> i1
    %62 = "spirv.LogicalEqual"(%61, %53) : (i1, i1) -> i1
    %63 = "spirv.INotEqual"(%49, %50) : (i32, i32) -> i1
    %64 = "spirv.LogicalAnd"(%62, %63) : (i1, i1) -> i1
    %65 = "spirv.Select"(%64, %57, %60) : (i1, i32, i32) -> i32
    %66 = "builtin.unrealized_conversion_cast"(%65) : (i32) -> index
    "func.return"(%66) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "ceildivu"}> ({
  ^bb0(%arg7: index, %arg8: index):
    %38 = "builtin.unrealized_conversion_cast"(%arg8) : (index) -> i32
    %39 = "builtin.unrealized_conversion_cast"(%arg7) : (index) -> i32
    %40 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %41 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %42 = "spirv.ISub"(%39, %41) : (i32, i32) -> i32
    %43 = "spirv.UDiv"(%42, %38) : (i32, i32) -> i32
    %44 = "spirv.IAdd"(%43, %41) : (i32, i32) -> i32
    %45 = "spirv.IEqual"(%39, %40) : (i32, i32) -> i1
    %46 = "spirv.Select"(%45, %40, %44) : (i1, i32, i32) -> i32
    %47 = "builtin.unrealized_conversion_cast"(%46) : (i32) -> index
    "func.return"(%47) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "floordivs"}> ({
  ^bb0(%arg5: index, %arg6: index):
    %21 = "builtin.unrealized_conversion_cast"(%arg6) : (index) -> i32
    %22 = "builtin.unrealized_conversion_cast"(%arg5) : (index) -> i32
    %23 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %24 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %25 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    %26 = "spirv.SLessThan"(%21, %23) : (i32, i32) -> i1
    %27 = "spirv.Select"(%26, %24, %25) : (i1, i32, i32) -> i32
    %28 = "spirv.ISub"(%27, %22) : (i32, i32) -> i32
    %29 = "spirv.SDiv"(%28, %21) : (i32, i32) -> i32
    %30 = "spirv.ISub"(%25, %29) : (i32, i32) -> i32
    %31 = "spirv.SDiv"(%22, %21) : (i32, i32) -> i32
    %32 = "spirv.SLessThan"(%22, %23) : (i32, i32) -> i1
    %33 = "spirv.LogicalNotEqual"(%32, %26) : (i1, i1) -> i1
    %34 = "spirv.INotEqual"(%22, %23) : (i32, i32) -> i1
    %35 = "spirv.LogicalAnd"(%33, %34) : (i1, i1) -> i1
    %36 = "spirv.Select"(%35, %31, %30) : (i1, i32, i32) -> i32
    %37 = "builtin.unrealized_conversion_cast"(%36) : (i32) -> index
    "func.return"(%37) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> (), sym_name = "index_cmp"}> ({
  ^bb0(%arg3: index, %arg4: index):
    %9 = "builtin.unrealized_conversion_cast"(%arg4) : (index) -> i32
    %10 = "builtin.unrealized_conversion_cast"(%arg3) : (index) -> i32
    %11 = "spirv.IEqual"(%10, %9) : (i32, i32) -> i1
    %12 = "spirv.INotEqual"(%10, %9) : (i32, i32) -> i1
    %13 = "spirv.SLessThan"(%10, %9) : (i32, i32) -> i1
    %14 = "spirv.SLessThanEqual"(%10, %9) : (i32, i32) -> i1
    %15 = "spirv.SGreaterThan"(%10, %9) : (i32, i32) -> i1
    %16 = "spirv.SGreaterThanEqual"(%10, %9) : (i32, i32) -> i1
    %17 = "spirv.ULessThan"(%10, %9) : (i32, i32) -> i1
    %18 = "spirv.ULessThanEqual"(%10, %9) : (i32, i32) -> i1
    %19 = "spirv.UGreaterThan"(%10, %9) : (i32, i32) -> i1
    %20 = "spirv.UGreaterThanEqual"(%10, %9) : (i32, i32) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "index_sizeof"}> ({
    %8 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (i64, i32, i64, i32), sym_name = "index_cast_from"}> ({
  ^bb0(%arg2: index):
    %5 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i32
    %6 = "spirv.SConvert"(%5) : (i32) -> i64
    %7 = "spirv.UConvert"(%5) : (i32) -> i64
    "func.return"(%6, %5, %7, %5) : (i64, i32, i64, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i64) -> (index, index, index, index), sym_name = "index_cast_to"}> ({
  ^bb0(%arg0: i32, %arg1: i64):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (i32) -> index
    %1 = "spirv.SConvert"(%arg1) : (i64) -> i32
    %2 = "builtin.unrealized_conversion_cast"(%1) : (i32) -> index
    %3 = "spirv.UConvert"(%arg1) : (i64) -> i32
    %4 = "builtin.unrealized_conversion_cast"(%3) : (i32) -> index
    "func.return"(%0, %2, %0, %4) : (index, index, index, index) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int64], []>, #spirv.resource_limits<>>} : () -> ()

