"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (), sym_name = "trivial_ops"}> ({
  ^bb0(%arg9: index, %arg10: index):
    %59 = "builtin.unrealized_conversion_cast"(%arg10) : (index) -> i64
    %60 = "builtin.unrealized_conversion_cast"(%arg9) : (index) -> i64
    %61 = "llvm.add"(%60, %59) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %62 = "llvm.sub"(%60, %59) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %63 = "llvm.mul"(%60, %59) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %64 = "llvm.sdiv"(%60, %59) : (i64, i64) -> i64
    %65 = "llvm.udiv"(%60, %59) : (i64, i64) -> i64
    %66 = "llvm.srem"(%60, %59) : (i64, i64) -> i64
    %67 = "llvm.urem"(%60, %59) : (i64, i64) -> i64
    %68 = "llvm.intr.smax"(%60, %59) : (i64, i64) -> i64
    %69 = "llvm.intr.umax"(%60, %59) : (i64, i64) -> i64
    %70 = "llvm.intr.smin"(%60, %59) : (i64, i64) -> i64
    %71 = "llvm.intr.umin"(%60, %59) : (i64, i64) -> i64
    %72 = "llvm.shl"(%60, %59) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %73 = "llvm.ashr"(%60, %59) : (i64, i64) -> i64
    %74 = "llvm.lshr"(%60, %59) : (i64, i64) -> i64
    %75 = "llvm.add"(%60, %59) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %76 = "llvm.or"(%60, %59) : (i64, i64) -> i64
    %77 = "llvm.xor"(%60, %59) : (i64, i64) -> i64
    %78 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "ceildivs"}> ({
  ^bb0(%arg7: index, %arg8: index):
    %40 = "builtin.unrealized_conversion_cast"(%arg8) : (index) -> i64
    %41 = "builtin.unrealized_conversion_cast"(%arg7) : (index) -> i64
    %42 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %43 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %44 = "llvm.mlir.constant"() <{value = -1 : i64}> : () -> i64
    %45 = "llvm.icmp"(%40, %42) <{predicate = 4 : i64}> : (i64, i64) -> i1
    %46 = "llvm.select"(%45, %44, %43) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    %47 = "llvm.add"(%41, %46) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %48 = "llvm.sdiv"(%47, %40) : (i64, i64) -> i64
    %49 = "llvm.add"(%48, %43) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %50 = "llvm.sub"(%42, %41) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %51 = "llvm.sdiv"(%50, %40) : (i64, i64) -> i64
    %52 = "llvm.sub"(%42, %51) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %53 = "llvm.icmp"(%41, %42) <{predicate = 4 : i64}> : (i64, i64) -> i1
    %54 = "llvm.icmp"(%53, %45) <{predicate = 0 : i64}> : (i1, i1) -> i1
    %55 = "llvm.icmp"(%41, %42) <{predicate = 1 : i64}> : (i64, i64) -> i1
    %56 = "llvm.and"(%54, %55) : (i1, i1) -> i1
    %57 = "llvm.select"(%56, %49, %52) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    %58 = "builtin.unrealized_conversion_cast"(%57) : (i64) -> index
    "func.return"(%58) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "ceildivu"}> ({
  ^bb0(%arg5: index, %arg6: index):
    %30 = "builtin.unrealized_conversion_cast"(%arg6) : (index) -> i64
    %31 = "builtin.unrealized_conversion_cast"(%arg5) : (index) -> i64
    %32 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %33 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %34 = "llvm.sub"(%31, %33) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %35 = "llvm.udiv"(%34, %30) : (i64, i64) -> i64
    %36 = "llvm.add"(%35, %33) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %37 = "llvm.icmp"(%31, %32) <{predicate = 0 : i64}> : (i64, i64) -> i1
    %38 = "llvm.select"(%37, %32, %36) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    %39 = "builtin.unrealized_conversion_cast"(%38) : (i64) -> index
    "func.return"(%39) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "floordivs"}> ({
  ^bb0(%arg3: index, %arg4: index):
    %13 = "builtin.unrealized_conversion_cast"(%arg4) : (index) -> i64
    %14 = "builtin.unrealized_conversion_cast"(%arg3) : (index) -> i64
    %15 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %16 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %17 = "llvm.mlir.constant"() <{value = -1 : i64}> : () -> i64
    %18 = "llvm.icmp"(%13, %15) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %19 = "llvm.select"(%18, %16, %17) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    %20 = "llvm.sub"(%19, %14) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %21 = "llvm.sdiv"(%20, %13) : (i64, i64) -> i64
    %22 = "llvm.sub"(%17, %21) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %23 = "llvm.sdiv"(%14, %13) : (i64, i64) -> i64
    %24 = "llvm.icmp"(%14, %15) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %25 = "llvm.icmp"(%24, %18) <{predicate = 1 : i64}> : (i1, i1) -> i1
    %26 = "llvm.icmp"(%14, %15) <{predicate = 1 : i64}> : (i64, i64) -> i1
    %27 = "llvm.and"(%25, %26) : (i1, i1) -> i1
    %28 = "llvm.select"(%27, %22, %23) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    %29 = "builtin.unrealized_conversion_cast"(%28) : (i64) -> index
    "func.return"(%29) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (i64, i32, i64, i32), sym_name = "index_cast_from"}> ({
  ^bb0(%arg2: index):
    %10 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %11 = "llvm.trunc"(%10) <{overflowFlags = 0 : i32}> : (i64) -> i32
    %12 = "llvm.trunc"(%10) <{overflowFlags = 0 : i32}> : (i64) -> i32
    "func.return"(%10, %11, %10, %12) : (i64, i32, i64, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i64) -> (index, index, index, index), sym_name = "index_cast_to"}> ({
  ^bb0(%arg0: i32, %arg1: i64):
    %5 = "builtin.unrealized_conversion_cast"(%arg1) : (i64) -> index
    %6 = "llvm.sext"(%arg0) : (i32) -> i64
    %7 = "builtin.unrealized_conversion_cast"(%6) : (i64) -> index
    %8 = "llvm.zext"(%arg0) : (i32) -> i64
    %9 = "builtin.unrealized_conversion_cast"(%8) : (i64) -> index
    "func.return"(%7, %5, %9, %5) : (index, index, index, index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "index_sizeof"}> ({
    %4 = "llvm.mlir.constant"() <{value = 64 : i64}> : () -> i64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "index_constant"}> ({
    %0 = "llvm.mlir.constant"() <{value = -2100000000 : i64}> : () -> i64
    %1 = "llvm.mlir.constant"() <{value = 2100000000 : i64}> : () -> i64
    %2 = "llvm.mlir.constant"() <{value = -3000000000 : i64}> : () -> i64
    %3 = "llvm.mlir.constant"() <{value = 3000000000 : i64}> : () -> i64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

