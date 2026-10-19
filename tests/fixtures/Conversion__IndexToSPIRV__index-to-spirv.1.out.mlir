module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int64], []>, #spirv.resource_limits<>>} {
  func.func @trivial_ops(%arg0: index, %arg1: index) {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i32
    %2 = spirv.IAdd %1, %0 : i32
    %3 = spirv.ISub %1, %0 : i32
    %4 = spirv.IMul %1, %0 : i32
    %5 = spirv.SDiv %1, %0 : i32
    %6 = spirv.UDiv %1, %0 : i32
    %7 = spirv.SRem %1, %0 : i32
    %8 = spirv.UMod %1, %0 : i32
    %9 = spirv.GL.SMax %1, %0 : i32
    %10 = spirv.GL.UMax %1, %0 : i32
    %11 = spirv.GL.SMin %1, %0 : i32
    %12 = spirv.GL.UMin %1, %0 : i32
    %13 = spirv.ShiftLeftLogical %1, %0 : i32, i32
    %14 = spirv.ShiftRightArithmetic %1, %0 : i32, i32
    %15 = spirv.ShiftRightLogical %1, %0 : i32, i32
    return
  }
  func.func @bitwise_ops(%arg0: index, %arg1: index) {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i32
    %2 = spirv.BitwiseAnd %1, %0 : i32
    %3 = spirv.BitwiseOr %1, %0 : i32
    %4 = spirv.BitwiseXor %1, %0 : i32
    return
  }
  func.func @constant_ops() {
    %cst42_i32 = spirv.Constant 42 : i32
    %true = spirv.Constant true
    %false = spirv.Constant false
    return
  }
  func.func @ceildivs(%arg0: index, %arg1: index) -> index {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i32
    %cst0_i32 = spirv.Constant 0 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %cst-1_i32 = spirv.Constant -1 : i32
    %2 = spirv.SGreaterThan %0, %cst0_i32 : i32
    %3 = spirv.Select %2, %cst-1_i32, %cst1_i32 : i1, i32
    %4 = spirv.IAdd %1, %3 : i32
    %5 = spirv.SDiv %4, %0 : i32
    %6 = spirv.IAdd %5, %cst1_i32 : i32
    %7 = spirv.ISub %cst0_i32, %1 : i32
    %8 = spirv.SDiv %7, %0 : i32
    %9 = spirv.ISub %cst0_i32, %8 : i32
    %10 = spirv.SGreaterThan %1, %cst0_i32 : i32
    %11 = spirv.LogicalEqual %10, %2 : i1
    %12 = spirv.INotEqual %1, %cst0_i32 : i32
    %13 = spirv.LogicalAnd %11, %12 : i1
    %14 = spirv.Select %13, %6, %9 : i1, i32
    %15 = builtin.unrealized_conversion_cast %14 : i32 to index
    return %15 : index
  }
  func.func @ceildivu(%arg0: index, %arg1: index) -> index {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i32
    %cst0_i32 = spirv.Constant 0 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %2 = spirv.ISub %1, %cst1_i32 : i32
    %3 = spirv.UDiv %2, %0 : i32
    %4 = spirv.IAdd %3, %cst1_i32 : i32
    %5 = spirv.IEqual %1, %cst0_i32 : i32
    %6 = spirv.Select %5, %cst0_i32, %4 : i1, i32
    %7 = builtin.unrealized_conversion_cast %6 : i32 to index
    return %7 : index
  }
  func.func @floordivs(%arg0: index, %arg1: index) -> index {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i32
    %cst0_i32 = spirv.Constant 0 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %cst-1_i32 = spirv.Constant -1 : i32
    %2 = spirv.SLessThan %0, %cst0_i32 : i32
    %3 = spirv.Select %2, %cst1_i32, %cst-1_i32 : i1, i32
    %4 = spirv.ISub %3, %1 : i32
    %5 = spirv.SDiv %4, %0 : i32
    %6 = spirv.ISub %cst-1_i32, %5 : i32
    %7 = spirv.SDiv %1, %0 : i32
    %8 = spirv.SLessThan %1, %cst0_i32 : i32
    %9 = spirv.LogicalNotEqual %8, %2 : i1
    %10 = spirv.INotEqual %1, %cst0_i32 : i32
    %11 = spirv.LogicalAnd %9, %10 : i1
    %12 = spirv.Select %11, %7, %6 : i1, i32
    %13 = builtin.unrealized_conversion_cast %12 : i32 to index
    return %13 : index
  }
  func.func @index_cmp(%arg0: index, %arg1: index) {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i32
    %2 = spirv.IEqual %1, %0 : i32
    %3 = spirv.INotEqual %1, %0 : i32
    %4 = spirv.SLessThan %1, %0 : i32
    %5 = spirv.SLessThanEqual %1, %0 : i32
    %6 = spirv.SGreaterThan %1, %0 : i32
    %7 = spirv.SGreaterThanEqual %1, %0 : i32
    %8 = spirv.ULessThan %1, %0 : i32
    %9 = spirv.ULessThanEqual %1, %0 : i32
    %10 = spirv.UGreaterThan %1, %0 : i32
    %11 = spirv.UGreaterThanEqual %1, %0 : i32
    return
  }
  func.func @index_sizeof() {
    %cst32_i32 = spirv.Constant 32 : i32
    return
  }
  func.func @index_cast_from(%arg0: index) -> (i64, i32, i64, i32) {
    %0 = builtin.unrealized_conversion_cast %arg0 : index to i32
    %1 = spirv.SConvert %0 : i32 to i64
    %2 = spirv.UConvert %0 : i32 to i64
    return %1, %0, %2, %0 : i64, i32, i64, i32
  }
  func.func @index_cast_to(%arg0: i32, %arg1: i64) -> (index, index, index, index) {
    %0 = builtin.unrealized_conversion_cast %arg0 : i32 to index
    %1 = spirv.SConvert %arg1 : i64 to i32
    %2 = builtin.unrealized_conversion_cast %1 : i32 to index
    %3 = spirv.UConvert %arg1 : i64 to i32
    %4 = builtin.unrealized_conversion_cast %3 : i32 to index
    return %0, %2, %0, %4 : index, index, index, index
  }
}

