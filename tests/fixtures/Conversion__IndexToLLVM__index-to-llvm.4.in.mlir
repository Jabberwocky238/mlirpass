"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (), sym_name = "trivial_ops"}> ({
  ^bb0(%arg9: index, %arg10: index):
    %16 = "index.add"(%arg9, %arg10) : (index, index) -> index
    %17 = "index.sub"(%arg9, %arg10) : (index, index) -> index
    %18 = "index.mul"(%arg9, %arg10) : (index, index) -> index
    %19 = "index.divs"(%arg9, %arg10) : (index, index) -> index
    %20 = "index.divu"(%arg9, %arg10) : (index, index) -> index
    %21 = "index.rems"(%arg9, %arg10) : (index, index) -> index
    %22 = "index.remu"(%arg9, %arg10) : (index, index) -> index
    %23 = "index.maxs"(%arg9, %arg10) : (index, index) -> index
    %24 = "index.maxu"(%arg9, %arg10) : (index, index) -> index
    %25 = "index.mins"(%arg9, %arg10) : (index, index) -> index
    %26 = "index.minu"(%arg9, %arg10) : (index, index) -> index
    %27 = "index.shl"(%arg9, %arg10) : (index, index) -> index
    %28 = "index.shrs"(%arg9, %arg10) : (index, index) -> index
    %29 = "index.shru"(%arg9, %arg10) : (index, index) -> index
    %30 = "index.add"(%arg9, %arg10) : (index, index) -> index
    %31 = "index.or"(%arg9, %arg10) : (index, index) -> index
    %32 = "index.xor"(%arg9, %arg10) : (index, index) -> index
    %33 = "index.bool.constant"() <{value = true}> : () -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "ceildivs"}> ({
  ^bb0(%arg7: index, %arg8: index):
    %15 = "index.ceildivs"(%arg7, %arg8) : (index, index) -> index
    "func.return"(%15) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "ceildivu"}> ({
  ^bb0(%arg5: index, %arg6: index):
    %14 = "index.ceildivu"(%arg5, %arg6) : (index, index) -> index
    "func.return"(%14) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "floordivs"}> ({
  ^bb0(%arg3: index, %arg4: index):
    %13 = "index.floordivs"(%arg3, %arg4) : (index, index) -> index
    "func.return"(%13) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (i64, i32, i64, i32), sym_name = "index_cast_from"}> ({
  ^bb0(%arg2: index):
    %9 = "index.casts"(%arg2) : (index) -> i64
    %10 = "index.casts"(%arg2) : (index) -> i32
    %11 = "index.castu"(%arg2) : (index) -> i64
    %12 = "index.castu"(%arg2) : (index) -> i32
    "func.return"(%9, %10, %11, %12) : (i64, i32, i64, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i64) -> (index, index, index, index), sym_name = "index_cast_to"}> ({
  ^bb0(%arg0: i32, %arg1: i64):
    %5 = "index.casts"(%arg0) : (i32) -> index
    %6 = "index.casts"(%arg1) : (i64) -> index
    %7 = "index.castu"(%arg0) : (i32) -> index
    %8 = "index.castu"(%arg1) : (i64) -> index
    "func.return"(%5, %6, %7, %8) : (index, index, index, index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "index_sizeof"}> ({
    %4 = "index.sizeof"() : () -> index
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "index_constant"}> ({
    %0 = "index.constant"() <{value = -2100000000 : index}> : () -> index
    %1 = "index.constant"() <{value = 2100000000 : index}> : () -> index
    %2 = "index.constant"() <{value = -3000000000 : index}> : () -> index
    %3 = "index.constant"() <{value = 3000000000 : index}> : () -> index
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

