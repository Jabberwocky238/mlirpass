"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (), sym_name = "trivial_ops"}> ({
  ^bb0(%arg9: index, %arg10: index):
    %59 = "builtin.unrealized_conversion_cast"(%arg10) : (index) -> i32
    %60 = "builtin.unrealized_conversion_cast"(%arg9) : (index) -> i32
    %61 = "llvm.add"(%60, %59) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %62 = "llvm.sub"(%60, %59) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %63 = "llvm.mul"(%60, %59) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %64 = "llvm.sdiv"(%60, %59) : (i32, i32) -> i32
    %65 = "llvm.udiv"(%60, %59) : (i32, i32) -> i32
    %66 = "llvm.srem"(%60, %59) : (i32, i32) -> i32
    %67 = "llvm.urem"(%60, %59) : (i32, i32) -> i32
    %68 = "llvm.intr.smax"(%60, %59) : (i32, i32) -> i32
    %69 = "llvm.intr.umax"(%60, %59) : (i32, i32) -> i32
    %70 = "llvm.intr.smin"(%60, %59) : (i32, i32) -> i32
    %71 = "llvm.intr.umin"(%60, %59) : (i32, i32) -> i32
    %72 = "llvm.shl"(%60, %59) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %73 = "llvm.ashr"(%60, %59) : (i32, i32) -> i32
    %74 = "llvm.lshr"(%60, %59) : (i32, i32) -> i32
    %75 = "llvm.add"(%60, %59) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %76 = "llvm.or"(%60, %59) : (i32, i32) -> i32
    %77 = "llvm.xor"(%60, %59) : (i32, i32) -> i32
    %78 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "ceildivs"}> ({
  ^bb0(%arg7: index, %arg8: index):
    %40 = "builtin.unrealized_conversion_cast"(%arg8) : (index) -> i32
    %41 = "builtin.unrealized_conversion_cast"(%arg7) : (index) -> i32
    %42 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %43 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %44 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
    %45 = "llvm.icmp"(%40, %42) <{predicate = 4 : i64}> : (i32, i32) -> i1
    %46 = "llvm.select"(%45, %44, %43) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    %47 = "llvm.add"(%41, %46) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %48 = "llvm.sdiv"(%47, %40) : (i32, i32) -> i32
    %49 = "llvm.add"(%48, %43) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %50 = "llvm.sub"(%42, %41) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %51 = "llvm.sdiv"(%50, %40) : (i32, i32) -> i32
    %52 = "llvm.sub"(%42, %51) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %53 = "llvm.icmp"(%41, %42) <{predicate = 4 : i64}> : (i32, i32) -> i1
    %54 = "llvm.icmp"(%53, %45) <{predicate = 0 : i64}> : (i1, i1) -> i1
    %55 = "llvm.icmp"(%41, %42) <{predicate = 1 : i64}> : (i32, i32) -> i1
    %56 = "llvm.and"(%54, %55) : (i1, i1) -> i1
    %57 = "llvm.select"(%56, %49, %52) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    %58 = "builtin.unrealized_conversion_cast"(%57) : (i32) -> index
    "func.return"(%58) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "ceildivu"}> ({
  ^bb0(%arg5: index, %arg6: index):
    %30 = "builtin.unrealized_conversion_cast"(%arg6) : (index) -> i32
    %31 = "builtin.unrealized_conversion_cast"(%arg5) : (index) -> i32
    %32 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %33 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %34 = "llvm.sub"(%31, %33) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %35 = "llvm.udiv"(%34, %30) : (i32, i32) -> i32
    %36 = "llvm.add"(%35, %33) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %37 = "llvm.icmp"(%31, %32) <{predicate = 0 : i64}> : (i32, i32) -> i1
    %38 = "llvm.select"(%37, %32, %36) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    %39 = "builtin.unrealized_conversion_cast"(%38) : (i32) -> index
    "func.return"(%39) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "floordivs"}> ({
  ^bb0(%arg3: index, %arg4: index):
    %13 = "builtin.unrealized_conversion_cast"(%arg4) : (index) -> i32
    %14 = "builtin.unrealized_conversion_cast"(%arg3) : (index) -> i32
    %15 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %16 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %17 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
    %18 = "llvm.icmp"(%13, %15) <{predicate = 2 : i64}> : (i32, i32) -> i1
    %19 = "llvm.select"(%18, %16, %17) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    %20 = "llvm.sub"(%19, %14) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %21 = "llvm.sdiv"(%20, %13) : (i32, i32) -> i32
    %22 = "llvm.sub"(%17, %21) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %23 = "llvm.sdiv"(%14, %13) : (i32, i32) -> i32
    %24 = "llvm.icmp"(%14, %15) <{predicate = 2 : i64}> : (i32, i32) -> i1
    %25 = "llvm.icmp"(%24, %18) <{predicate = 1 : i64}> : (i1, i1) -> i1
    %26 = "llvm.icmp"(%14, %15) <{predicate = 1 : i64}> : (i32, i32) -> i1
    %27 = "llvm.and"(%25, %26) : (i1, i1) -> i1
    %28 = "llvm.select"(%27, %22, %23) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    %29 = "builtin.unrealized_conversion_cast"(%28) : (i32) -> index
    "func.return"(%29) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (i64, i32, i64, i32), sym_name = "index_cast_from"}> ({
  ^bb0(%arg2: index):
    %10 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i32
    %11 = "llvm.sext"(%10) : (i32) -> i64
    %12 = "llvm.zext"(%10) : (i32) -> i64
    "func.return"(%11, %10, %12, %10) : (i64, i32, i64, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i64) -> (index, index, index, index), sym_name = "index_cast_to"}> ({
  ^bb0(%arg0: i32, %arg1: i64):
    %5 = "builtin.unrealized_conversion_cast"(%arg0) : (i32) -> index
    %6 = "llvm.trunc"(%arg1) <{overflowFlags = 0 : i32}> : (i64) -> i32
    %7 = "builtin.unrealized_conversion_cast"(%6) : (i32) -> index
    %8 = "llvm.trunc"(%arg1) <{overflowFlags = 0 : i32}> : (i64) -> i32
    %9 = "builtin.unrealized_conversion_cast"(%8) : (i32) -> index
    "func.return"(%5, %7, %5, %9) : (index, index, index, index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "index_sizeof"}> ({
    %4 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "index_constant"}> ({
    %0 = "llvm.mlir.constant"() <{value = -2100000000 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 2100000000 : i32}> : () -> i32
    %2 = "llvm.mlir.constant"() <{value = 1294967296 : i32}> : () -> i32
    %3 = "llvm.mlir.constant"() <{value = -1294967296 : i32}> : () -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

