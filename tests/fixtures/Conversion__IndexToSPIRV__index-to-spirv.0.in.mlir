"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (), sym_name = "trivial_ops"}> ({
  ^bb0(%arg13: index, %arg14: index):
    %28 = "index.add"(%arg13, %arg14) : (index, index) -> index
    %29 = "index.sub"(%arg13, %arg14) : (index, index) -> index
    %30 = "index.mul"(%arg13, %arg14) : (index, index) -> index
    %31 = "index.divs"(%arg13, %arg14) : (index, index) -> index
    %32 = "index.divu"(%arg13, %arg14) : (index, index) -> index
    %33 = "index.rems"(%arg13, %arg14) : (index, index) -> index
    %34 = "index.remu"(%arg13, %arg14) : (index, index) -> index
    %35 = "index.maxs"(%arg13, %arg14) : (index, index) -> index
    %36 = "index.maxu"(%arg13, %arg14) : (index, index) -> index
    %37 = "index.mins"(%arg13, %arg14) : (index, index) -> index
    %38 = "index.minu"(%arg13, %arg14) : (index, index) -> index
    %39 = "index.shl"(%arg13, %arg14) : (index, index) -> index
    %40 = "index.shrs"(%arg13, %arg14) : (index, index) -> index
    %41 = "index.shru"(%arg13, %arg14) : (index, index) -> index
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> (), sym_name = "bitwise_ops"}> ({
  ^bb0(%arg11: index, %arg12: index):
    %25 = "index.and"(%arg11, %arg12) : (index, index) -> index
    %26 = "index.or"(%arg11, %arg12) : (index, index) -> index
    %27 = "index.xor"(%arg11, %arg12) : (index, index) -> index
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "constant_ops"}> ({
    %22 = "index.constant"() <{value = 42 : index}> : () -> index
    %23 = "index.bool.constant"() <{value = true}> : () -> i1
    %24 = "index.bool.constant"() <{value = false}> : () -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "ceildivs"}> ({
  ^bb0(%arg9: index, %arg10: index):
    %21 = "index.ceildivs"(%arg9, %arg10) : (index, index) -> index
    "func.return"(%21) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "ceildivu"}> ({
  ^bb0(%arg7: index, %arg8: index):
    %20 = "index.ceildivu"(%arg7, %arg8) : (index, index) -> index
    "func.return"(%20) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "floordivs"}> ({
  ^bb0(%arg5: index, %arg6: index):
    %19 = "index.floordivs"(%arg5, %arg6) : (index, index) -> index
    "func.return"(%19) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> (), sym_name = "index_cmp"}> ({
  ^bb0(%arg3: index, %arg4: index):
    %9 = "index.cmp"(%arg3, %arg4) <{pred = #index<cmp_predicate eq>}> : (index, index) -> i1
    %10 = "index.cmp"(%arg3, %arg4) <{pred = #index<cmp_predicate ne>}> : (index, index) -> i1
    %11 = "index.cmp"(%arg3, %arg4) <{pred = #index<cmp_predicate slt>}> : (index, index) -> i1
    %12 = "index.cmp"(%arg3, %arg4) <{pred = #index<cmp_predicate sle>}> : (index, index) -> i1
    %13 = "index.cmp"(%arg3, %arg4) <{pred = #index<cmp_predicate sgt>}> : (index, index) -> i1
    %14 = "index.cmp"(%arg3, %arg4) <{pred = #index<cmp_predicate sge>}> : (index, index) -> i1
    %15 = "index.cmp"(%arg3, %arg4) <{pred = #index<cmp_predicate ult>}> : (index, index) -> i1
    %16 = "index.cmp"(%arg3, %arg4) <{pred = #index<cmp_predicate ule>}> : (index, index) -> i1
    %17 = "index.cmp"(%arg3, %arg4) <{pred = #index<cmp_predicate ugt>}> : (index, index) -> i1
    %18 = "index.cmp"(%arg3, %arg4) <{pred = #index<cmp_predicate uge>}> : (index, index) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "index_sizeof"}> ({
    %8 = "index.sizeof"() : () -> index
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (i64, i32, i64, i32), sym_name = "index_cast_from"}> ({
  ^bb0(%arg2: index):
    %4 = "index.casts"(%arg2) : (index) -> i64
    %5 = "index.casts"(%arg2) : (index) -> i32
    %6 = "index.castu"(%arg2) : (index) -> i64
    %7 = "index.castu"(%arg2) : (index) -> i32
    "func.return"(%4, %5, %6, %7) : (i64, i32, i64, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i64) -> (index, index, index, index), sym_name = "index_cast_to"}> ({
  ^bb0(%arg0: i32, %arg1: i64):
    %0 = "index.casts"(%arg0) : (i32) -> index
    %1 = "index.casts"(%arg1) : (i64) -> index
    %2 = "index.castu"(%arg0) : (i32) -> index
    %3 = "index.castu"(%arg1) : (i64) -> index
    "func.return"(%0, %1, %2, %3) : (index, index, index, index) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int64], []>, #spirv.resource_limits<>>} : () -> ()

