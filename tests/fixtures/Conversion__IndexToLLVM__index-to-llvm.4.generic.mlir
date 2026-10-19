"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (), sym_name = "trivial_ops"}> ({
  ^bb0(%arg9: index, %arg10: index):
    %63 = "builtin.unrealized_conversion_cast"(%arg10) : (index) -> i64
    %64 = "builtin.unrealized_conversion_cast"(%arg9) : (index) -> i64
    %65 = "builtin.unrealized_conversion_cast"(%arg10) : (index) -> i64
    %66 = "builtin.unrealized_conversion_cast"(%arg9) : (index) -> i64
    %67 = "builtin.unrealized_conversion_cast"(%arg10) : (index) -> i64
    %68 = "builtin.unrealized_conversion_cast"(%arg9) : (index) -> i64
    %69 = "builtin.unrealized_conversion_cast"(%arg10) : (index) -> i64
    %70 = "builtin.unrealized_conversion_cast"(%arg9) : (index) -> i64
    %71 = "builtin.unrealized_conversion_cast"(%arg10) : (index) -> i64
    %72 = "builtin.unrealized_conversion_cast"(%arg9) : (index) -> i64
    %73 = "builtin.unrealized_conversion_cast"(%arg10) : (index) -> i64
    %74 = "builtin.unrealized_conversion_cast"(%arg9) : (index) -> i64
    %75 = "builtin.unrealized_conversion_cast"(%arg10) : (index) -> i64
    %76 = "builtin.unrealized_conversion_cast"(%arg9) : (index) -> i64
    %77 = "builtin.unrealized_conversion_cast"(%arg10) : (index) -> i64
    %78 = "builtin.unrealized_conversion_cast"(%arg9) : (index) -> i64
    %79 = "builtin.unrealized_conversion_cast"(%arg10) : (index) -> i64
    %80 = "builtin.unrealized_conversion_cast"(%arg9) : (index) -> i64
    %81 = "builtin.unrealized_conversion_cast"(%arg10) : (index) -> i64
    %82 = "builtin.unrealized_conversion_cast"(%arg9) : (index) -> i64
    %83 = "builtin.unrealized_conversion_cast"(%arg10) : (index) -> i64
    %84 = "builtin.unrealized_conversion_cast"(%arg9) : (index) -> i64
    %85 = "builtin.unrealized_conversion_cast"(%arg10) : (index) -> i64
    %86 = "builtin.unrealized_conversion_cast"(%arg9) : (index) -> i64
    %87 = "builtin.unrealized_conversion_cast"(%arg10) : (index) -> i64
    %88 = "builtin.unrealized_conversion_cast"(%arg9) : (index) -> i64
    %89 = "builtin.unrealized_conversion_cast"(%arg10) : (index) -> i64
    %90 = "builtin.unrealized_conversion_cast"(%arg9) : (index) -> i64
    %91 = "builtin.unrealized_conversion_cast"(%arg10) : (index) -> i64
    %92 = "builtin.unrealized_conversion_cast"(%arg9) : (index) -> i64
    %93 = "builtin.unrealized_conversion_cast"(%arg10) : (index) -> i64
    %94 = "builtin.unrealized_conversion_cast"(%arg9) : (index) -> i64
    %95 = "builtin.unrealized_conversion_cast"(%arg10) : (index) -> i64
    %96 = "builtin.unrealized_conversion_cast"(%arg9) : (index) -> i64
    %97 = "llvm.add"(%96, %95) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %98 = "llvm.sub"(%94, %93) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %99 = "llvm.mul"(%92, %91) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %100 = "llvm.sdiv"(%90, %89) : (i64, i64) -> i64
    %101 = "llvm.udiv"(%88, %87) : (i64, i64) -> i64
    %102 = "llvm.srem"(%86, %85) : (i64, i64) -> i64
    %103 = "llvm.urem"(%84, %83) : (i64, i64) -> i64
    %104 = "llvm.intr.smax"(%82, %81) : (i64, i64) -> i64
    %105 = "llvm.intr.umax"(%80, %79) : (i64, i64) -> i64
    %106 = "llvm.intr.smin"(%78, %77) : (i64, i64) -> i64
    %107 = "llvm.intr.umin"(%76, %75) : (i64, i64) -> i64
    %108 = "llvm.shl"(%74, %73) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %109 = "llvm.ashr"(%72, %71) : (i64, i64) -> i64
    %110 = "llvm.lshr"(%70, %69) : (i64, i64) -> i64
    %111 = "llvm.add"(%68, %67) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %112 = "llvm.or"(%66, %65) : (i64, i64) -> i64
    %113 = "llvm.xor"(%64, %63) : (i64, i64) -> i64
    %114 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "ceildivs"}> ({
  ^bb0(%arg7: index, %arg8: index):
    %44 = "builtin.unrealized_conversion_cast"(%arg8) : (index) -> i64
    %45 = "builtin.unrealized_conversion_cast"(%arg7) : (index) -> i64
    %46 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %47 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %48 = "llvm.mlir.constant"() <{value = -1 : i64}> : () -> i64
    %49 = "llvm.icmp"(%44, %46) <{predicate = 4 : i64}> : (i64, i64) -> i1
    %50 = "llvm.select"(%49, %48, %47) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    %51 = "llvm.add"(%45, %50) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %52 = "llvm.sdiv"(%51, %44) : (i64, i64) -> i64
    %53 = "llvm.add"(%52, %47) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %54 = "llvm.sub"(%46, %45) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %55 = "llvm.sdiv"(%54, %44) : (i64, i64) -> i64
    %56 = "llvm.sub"(%46, %55) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %57 = "llvm.icmp"(%45, %46) <{predicate = 4 : i64}> : (i64, i64) -> i1
    %58 = "llvm.icmp"(%57, %49) <{predicate = 0 : i64}> : (i1, i1) -> i1
    %59 = "llvm.icmp"(%45, %46) <{predicate = 1 : i64}> : (i64, i64) -> i1
    %60 = "llvm.and"(%58, %59) : (i1, i1) -> i1
    %61 = "llvm.select"(%60, %53, %56) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    %62 = "builtin.unrealized_conversion_cast"(%61) : (i64) -> index
    "func.return"(%62) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "ceildivu"}> ({
  ^bb0(%arg5: index, %arg6: index):
    %34 = "builtin.unrealized_conversion_cast"(%arg6) : (index) -> i64
    %35 = "builtin.unrealized_conversion_cast"(%arg5) : (index) -> i64
    %36 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %37 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %38 = "llvm.sub"(%35, %37) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %39 = "llvm.udiv"(%38, %34) : (i64, i64) -> i64
    %40 = "llvm.add"(%39, %37) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %41 = "llvm.icmp"(%35, %36) <{predicate = 0 : i64}> : (i64, i64) -> i1
    %42 = "llvm.select"(%41, %36, %40) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    %43 = "builtin.unrealized_conversion_cast"(%42) : (i64) -> index
    "func.return"(%43) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "floordivs"}> ({
  ^bb0(%arg3: index, %arg4: index):
    %17 = "builtin.unrealized_conversion_cast"(%arg4) : (index) -> i64
    %18 = "builtin.unrealized_conversion_cast"(%arg3) : (index) -> i64
    %19 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %20 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %21 = "llvm.mlir.constant"() <{value = -1 : i64}> : () -> i64
    %22 = "llvm.icmp"(%17, %19) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %23 = "llvm.select"(%22, %20, %21) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    %24 = "llvm.sub"(%23, %18) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %25 = "llvm.sdiv"(%24, %17) : (i64, i64) -> i64
    %26 = "llvm.sub"(%21, %25) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %27 = "llvm.sdiv"(%18, %17) : (i64, i64) -> i64
    %28 = "llvm.icmp"(%18, %19) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %29 = "llvm.icmp"(%28, %22) <{predicate = 1 : i64}> : (i1, i1) -> i1
    %30 = "llvm.icmp"(%18, %19) <{predicate = 1 : i64}> : (i64, i64) -> i1
    %31 = "llvm.and"(%29, %30) : (i1, i1) -> i1
    %32 = "llvm.select"(%31, %26, %27) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    %33 = "builtin.unrealized_conversion_cast"(%32) : (i64) -> index
    "func.return"(%33) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (i64, i32, i64, i32), sym_name = "index_cast_from"}> ({
  ^bb0(%arg2: index):
    %11 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %12 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %13 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %14 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %15 = "llvm.trunc"(%13) <{overflowFlags = 0 : i32}> : (i64) -> i32
    %16 = "llvm.trunc"(%11) <{overflowFlags = 0 : i32}> : (i64) -> i32
    "func.return"(%14, %15, %12, %16) : (i64, i32, i64, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i64) -> (index, index, index, index), sym_name = "index_cast_to"}> ({
  ^bb0(%arg0: i32, %arg1: i64):
    %5 = "builtin.unrealized_conversion_cast"(%arg1) : (i64) -> index
    %6 = "builtin.unrealized_conversion_cast"(%arg1) : (i64) -> index
    %7 = "llvm.sext"(%arg0) : (i32) -> i64
    %8 = "builtin.unrealized_conversion_cast"(%7) : (i64) -> index
    %9 = "llvm.zext"(%arg0) : (i32) -> i64
    %10 = "builtin.unrealized_conversion_cast"(%9) : (i64) -> index
    "func.return"(%8, %6, %10, %5) : (index, index, index, index) -> ()
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

