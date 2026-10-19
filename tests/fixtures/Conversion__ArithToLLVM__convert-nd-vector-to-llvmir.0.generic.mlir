"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2x2xf32>) -> vector<2x2x2xf32>, sym_name = "vec_bin"}> ({
  ^bb0(%arg14: vector<2x2x2xf32>):
    %115 = "builtin.unrealized_conversion_cast"(%arg14) : (vector<2x2x2xf32>) -> !llvm.array<2 x array<2 x vector<2xf32>>>
    %116 = "llvm.mlir.poison"() : () -> !llvm.array<2 x array<2 x vector<2xf32>>>
    %117 = "llvm.extractvalue"(%115) <{position = array<i64: 0, 0>}> : (!llvm.array<2 x array<2 x vector<2xf32>>>) -> vector<2xf32>
    %118 = "llvm.extractvalue"(%115) <{position = array<i64: 0, 0>}> : (!llvm.array<2 x array<2 x vector<2xf32>>>) -> vector<2xf32>
    %119 = "llvm.fadd"(%117, %118) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %120 = "llvm.insertvalue"(%116, %119) <{position = array<i64: 0, 0>}> : (!llvm.array<2 x array<2 x vector<2xf32>>>, vector<2xf32>) -> !llvm.array<2 x array<2 x vector<2xf32>>>
    %121 = "llvm.extractvalue"(%115) <{position = array<i64: 0, 1>}> : (!llvm.array<2 x array<2 x vector<2xf32>>>) -> vector<2xf32>
    %122 = "llvm.extractvalue"(%115) <{position = array<i64: 0, 1>}> : (!llvm.array<2 x array<2 x vector<2xf32>>>) -> vector<2xf32>
    %123 = "llvm.fadd"(%121, %122) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %124 = "llvm.insertvalue"(%120, %123) <{position = array<i64: 0, 1>}> : (!llvm.array<2 x array<2 x vector<2xf32>>>, vector<2xf32>) -> !llvm.array<2 x array<2 x vector<2xf32>>>
    %125 = "llvm.extractvalue"(%115) <{position = array<i64: 1, 0>}> : (!llvm.array<2 x array<2 x vector<2xf32>>>) -> vector<2xf32>
    %126 = "llvm.extractvalue"(%115) <{position = array<i64: 1, 0>}> : (!llvm.array<2 x array<2 x vector<2xf32>>>) -> vector<2xf32>
    %127 = "llvm.fadd"(%125, %126) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %128 = "llvm.insertvalue"(%124, %127) <{position = array<i64: 1, 0>}> : (!llvm.array<2 x array<2 x vector<2xf32>>>, vector<2xf32>) -> !llvm.array<2 x array<2 x vector<2xf32>>>
    %129 = "llvm.extractvalue"(%115) <{position = array<i64: 1, 1>}> : (!llvm.array<2 x array<2 x vector<2xf32>>>) -> vector<2xf32>
    %130 = "llvm.extractvalue"(%115) <{position = array<i64: 1, 1>}> : (!llvm.array<2 x array<2 x vector<2xf32>>>) -> vector<2xf32>
    %131 = "llvm.fadd"(%129, %130) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %132 = "llvm.insertvalue"(%128, %131) <{position = array<i64: 1, 1>}> : (!llvm.array<2 x array<2 x vector<2xf32>>>, vector<2xf32>) -> !llvm.array<2 x array<2 x vector<2xf32>>>
    %133 = "builtin.unrealized_conversion_cast"(%132) : (!llvm.array<2 x array<2 x vector<2xf32>>>) -> vector<2x2x2xf32>
    "func.return"(%133) : (vector<2x2x2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xi32>, vector<1x2x3xi64>) -> (), sym_name = "sexti_vector"}> ({
  ^bb0(%arg12: vector<1x2x3xi32>, %arg13: vector<1x2x3xi64>):
    %107 = "builtin.unrealized_conversion_cast"(%arg12) : (vector<1x2x3xi32>) -> !llvm.array<1 x array<2 x vector<3xi32>>>
    %108 = "llvm.mlir.poison"() : () -> !llvm.array<1 x array<2 x vector<3xi64>>>
    %109 = "llvm.extractvalue"(%107) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi32>>>) -> vector<3xi32>
    %110 = "llvm.sext"(%109) : (vector<3xi32>) -> vector<3xi64>
    %111 = "llvm.insertvalue"(%108, %110) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>, vector<3xi64>) -> !llvm.array<1 x array<2 x vector<3xi64>>>
    %112 = "llvm.extractvalue"(%107) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi32>>>) -> vector<3xi32>
    %113 = "llvm.sext"(%112) : (vector<3xi32>) -> vector<3xi64>
    %114 = "llvm.insertvalue"(%111, %113) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>, vector<3xi64>) -> !llvm.array<1 x array<2 x vector<3xi64>>>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xi32>, vector<1x2x3xi64>) -> (), sym_name = "zexti_vector"}> ({
  ^bb0(%arg10: vector<1x2x3xi32>, %arg11: vector<1x2x3xi64>):
    %99 = "builtin.unrealized_conversion_cast"(%arg10) : (vector<1x2x3xi32>) -> !llvm.array<1 x array<2 x vector<3xi32>>>
    %100 = "llvm.mlir.poison"() : () -> !llvm.array<1 x array<2 x vector<3xi64>>>
    %101 = "llvm.extractvalue"(%99) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi32>>>) -> vector<3xi32>
    %102 = "llvm.zext"(%101) : (vector<3xi32>) -> vector<3xi64>
    %103 = "llvm.insertvalue"(%100, %102) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>, vector<3xi64>) -> !llvm.array<1 x array<2 x vector<3xi64>>>
    %104 = "llvm.extractvalue"(%99) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi32>>>) -> vector<3xi32>
    %105 = "llvm.zext"(%104) : (vector<3xi32>) -> vector<3xi64>
    %106 = "llvm.insertvalue"(%103, %105) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>, vector<3xi64>) -> !llvm.array<1 x array<2 x vector<3xi64>>>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xi32>) -> vector<1x2x3xf32>, sym_name = "sitofp_vector"}> ({
  ^bb0(%arg9: vector<1x2x3xi32>):
    %90 = "builtin.unrealized_conversion_cast"(%arg9) : (vector<1x2x3xi32>) -> !llvm.array<1 x array<2 x vector<3xi32>>>
    %91 = "llvm.mlir.poison"() : () -> !llvm.array<1 x array<2 x vector<3xf32>>>
    %92 = "llvm.extractvalue"(%90) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi32>>>) -> vector<3xi32>
    %93 = "llvm.sitofp"(%92) : (vector<3xi32>) -> vector<3xf32>
    %94 = "llvm.insertvalue"(%91, %93) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xf32>>>, vector<3xf32>) -> !llvm.array<1 x array<2 x vector<3xf32>>>
    %95 = "llvm.extractvalue"(%90) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi32>>>) -> vector<3xi32>
    %96 = "llvm.sitofp"(%95) : (vector<3xi32>) -> vector<3xf32>
    %97 = "llvm.insertvalue"(%94, %96) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xf32>>>, vector<3xf32>) -> !llvm.array<1 x array<2 x vector<3xf32>>>
    %98 = "builtin.unrealized_conversion_cast"(%97) : (!llvm.array<1 x array<2 x vector<3xf32>>>) -> vector<1x2x3xf32>
    "func.return"(%98) : (vector<1x2x3xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xi32>) -> vector<1x2x3xf32>, sym_name = "uitofp_vector"}> ({
  ^bb0(%arg8: vector<1x2x3xi32>):
    %81 = "builtin.unrealized_conversion_cast"(%arg8) : (vector<1x2x3xi32>) -> !llvm.array<1 x array<2 x vector<3xi32>>>
    %82 = "llvm.mlir.poison"() : () -> !llvm.array<1 x array<2 x vector<3xf32>>>
    %83 = "llvm.extractvalue"(%81) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi32>>>) -> vector<3xi32>
    %84 = "llvm.uitofp"(%83) : (vector<3xi32>) -> vector<3xf32>
    %85 = "llvm.insertvalue"(%82, %84) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xf32>>>, vector<3xf32>) -> !llvm.array<1 x array<2 x vector<3xf32>>>
    %86 = "llvm.extractvalue"(%81) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi32>>>) -> vector<3xi32>
    %87 = "llvm.uitofp"(%86) : (vector<3xi32>) -> vector<3xf32>
    %88 = "llvm.insertvalue"(%85, %87) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xf32>>>, vector<3xf32>) -> !llvm.array<1 x array<2 x vector<3xf32>>>
    %89 = "builtin.unrealized_conversion_cast"(%88) : (!llvm.array<1 x array<2 x vector<3xf32>>>) -> vector<1x2x3xf32>
    "func.return"(%89) : (vector<1x2x3xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xf32>) -> vector<1x2x3xi32>, sym_name = "fptosi_vector"}> ({
  ^bb0(%arg7: vector<1x2x3xf32>):
    %72 = "builtin.unrealized_conversion_cast"(%arg7) : (vector<1x2x3xf32>) -> !llvm.array<1 x array<2 x vector<3xf32>>>
    %73 = "llvm.mlir.poison"() : () -> !llvm.array<1 x array<2 x vector<3xi32>>>
    %74 = "llvm.extractvalue"(%72) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xf32>>>) -> vector<3xf32>
    %75 = "llvm.fptosi"(%74) : (vector<3xf32>) -> vector<3xi32>
    %76 = "llvm.insertvalue"(%73, %75) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi32>>>, vector<3xi32>) -> !llvm.array<1 x array<2 x vector<3xi32>>>
    %77 = "llvm.extractvalue"(%72) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xf32>>>) -> vector<3xf32>
    %78 = "llvm.fptosi"(%77) : (vector<3xf32>) -> vector<3xi32>
    %79 = "llvm.insertvalue"(%76, %78) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi32>>>, vector<3xi32>) -> !llvm.array<1 x array<2 x vector<3xi32>>>
    %80 = "builtin.unrealized_conversion_cast"(%79) : (!llvm.array<1 x array<2 x vector<3xi32>>>) -> vector<1x2x3xi32>
    "func.return"(%80) : (vector<1x2x3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xf32>) -> vector<1x2x3xi32>, sym_name = "fptoui_vector"}> ({
  ^bb0(%arg6: vector<1x2x3xf32>):
    %63 = "builtin.unrealized_conversion_cast"(%arg6) : (vector<1x2x3xf32>) -> !llvm.array<1 x array<2 x vector<3xf32>>>
    %64 = "llvm.mlir.poison"() : () -> !llvm.array<1 x array<2 x vector<3xi32>>>
    %65 = "llvm.extractvalue"(%63) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xf32>>>) -> vector<3xf32>
    %66 = "llvm.fptoui"(%65) : (vector<3xf32>) -> vector<3xi32>
    %67 = "llvm.insertvalue"(%64, %66) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi32>>>, vector<3xi32>) -> !llvm.array<1 x array<2 x vector<3xi32>>>
    %68 = "llvm.extractvalue"(%63) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xf32>>>) -> vector<3xf32>
    %69 = "llvm.fptoui"(%68) : (vector<3xf32>) -> vector<3xi32>
    %70 = "llvm.insertvalue"(%67, %69) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi32>>>, vector<3xi32>) -> !llvm.array<1 x array<2 x vector<3xi32>>>
    %71 = "builtin.unrealized_conversion_cast"(%70) : (!llvm.array<1 x array<2 x vector<3xi32>>>) -> vector<1x2x3xi32>
    "func.return"(%71) : (vector<1x2x3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xf16>) -> vector<1x2x3xf64>, sym_name = "fpext_vector"}> ({
  ^bb0(%arg5: vector<1x2x3xf16>):
    %54 = "builtin.unrealized_conversion_cast"(%arg5) : (vector<1x2x3xf16>) -> !llvm.array<1 x array<2 x vector<3xf16>>>
    %55 = "llvm.mlir.poison"() : () -> !llvm.array<1 x array<2 x vector<3xf64>>>
    %56 = "llvm.extractvalue"(%54) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xf16>>>) -> vector<3xf16>
    %57 = "llvm.fpext"(%56) : (vector<3xf16>) -> vector<3xf64>
    %58 = "llvm.insertvalue"(%55, %57) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xf64>>>, vector<3xf64>) -> !llvm.array<1 x array<2 x vector<3xf64>>>
    %59 = "llvm.extractvalue"(%54) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xf16>>>) -> vector<3xf16>
    %60 = "llvm.fpext"(%59) : (vector<3xf16>) -> vector<3xf64>
    %61 = "llvm.insertvalue"(%58, %60) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xf64>>>, vector<3xf64>) -> !llvm.array<1 x array<2 x vector<3xf64>>>
    %62 = "builtin.unrealized_conversion_cast"(%61) : (!llvm.array<1 x array<2 x vector<3xf64>>>) -> vector<1x2x3xf64>
    "func.return"(%62) : (vector<1x2x3xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xf64>) -> vector<1x2x3xf16>, sym_name = "fptrunc_vector"}> ({
  ^bb0(%arg4: vector<1x2x3xf64>):
    %45 = "builtin.unrealized_conversion_cast"(%arg4) : (vector<1x2x3xf64>) -> !llvm.array<1 x array<2 x vector<3xf64>>>
    %46 = "llvm.mlir.poison"() : () -> !llvm.array<1 x array<2 x vector<3xf16>>>
    %47 = "llvm.extractvalue"(%45) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xf64>>>) -> vector<3xf64>
    %48 = "llvm.fptrunc"(%47) : (vector<3xf64>) -> vector<3xf16>
    %49 = "llvm.insertvalue"(%46, %48) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xf16>>>, vector<3xf16>) -> !llvm.array<1 x array<2 x vector<3xf16>>>
    %50 = "llvm.extractvalue"(%45) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xf64>>>) -> vector<3xf64>
    %51 = "llvm.fptrunc"(%50) : (vector<3xf64>) -> vector<3xf16>
    %52 = "llvm.insertvalue"(%49, %51) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xf16>>>, vector<3xf16>) -> !llvm.array<1 x array<2 x vector<3xf16>>>
    %53 = "builtin.unrealized_conversion_cast"(%52) : (!llvm.array<1 x array<2 x vector<3xf16>>>) -> vector<1x2x3xf16>
    "func.return"(%53) : (vector<1x2x3xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xi64>) -> vector<1x2x3xi16>, sym_name = "trunci_vector"}> ({
  ^bb0(%arg3: vector<1x2x3xi64>):
    %36 = "builtin.unrealized_conversion_cast"(%arg3) : (vector<1x2x3xi64>) -> !llvm.array<1 x array<2 x vector<3xi64>>>
    %37 = "llvm.mlir.poison"() : () -> !llvm.array<1 x array<2 x vector<3xi16>>>
    %38 = "llvm.extractvalue"(%36) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>) -> vector<3xi64>
    %39 = "llvm.trunc"(%38) <{overflowFlags = 0 : i32}> : (vector<3xi64>) -> vector<3xi16>
    %40 = "llvm.insertvalue"(%37, %39) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi16>>>, vector<3xi16>) -> !llvm.array<1 x array<2 x vector<3xi16>>>
    %41 = "llvm.extractvalue"(%36) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>) -> vector<3xi64>
    %42 = "llvm.trunc"(%41) <{overflowFlags = 0 : i32}> : (vector<3xi64>) -> vector<3xi16>
    %43 = "llvm.insertvalue"(%40, %42) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi16>>>, vector<3xi16>) -> !llvm.array<1 x array<2 x vector<3xi16>>>
    %44 = "builtin.unrealized_conversion_cast"(%43) : (!llvm.array<1 x array<2 x vector<3xi16>>>) -> vector<1x2x3xi16>
    "func.return"(%44) : (vector<1x2x3xi16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xi64>) -> vector<1x2x3xi64>, sym_name = "shl_vector"}> ({
  ^bb0(%arg2: vector<1x2x3xi64>):
    %24 = "builtin.unrealized_conversion_cast"(%arg2) : (vector<1x2x3xi64>) -> !llvm.array<1 x array<2 x vector<3xi64>>>
    %25 = "llvm.mlir.constant"() <{value = dense<1> : vector<1x2x3xi64>}> : () -> !llvm.array<1 x array<2 x vector<3xi64>>>
    %26 = "llvm.mlir.poison"() : () -> !llvm.array<1 x array<2 x vector<3xi64>>>
    %27 = "llvm.extractvalue"(%24) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>) -> vector<3xi64>
    %28 = "llvm.extractvalue"(%25) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>) -> vector<3xi64>
    %29 = "llvm.shl"(%27, %28) <{overflowFlags = 0 : i32}> : (vector<3xi64>, vector<3xi64>) -> vector<3xi64>
    %30 = "llvm.insertvalue"(%26, %29) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>, vector<3xi64>) -> !llvm.array<1 x array<2 x vector<3xi64>>>
    %31 = "llvm.extractvalue"(%24) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>) -> vector<3xi64>
    %32 = "llvm.extractvalue"(%25) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>) -> vector<3xi64>
    %33 = "llvm.shl"(%31, %32) <{overflowFlags = 0 : i32}> : (vector<3xi64>, vector<3xi64>) -> vector<3xi64>
    %34 = "llvm.insertvalue"(%30, %33) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>, vector<3xi64>) -> !llvm.array<1 x array<2 x vector<3xi64>>>
    %35 = "builtin.unrealized_conversion_cast"(%34) : (!llvm.array<1 x array<2 x vector<3xi64>>>) -> vector<1x2x3xi64>
    "func.return"(%35) : (vector<1x2x3xi64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xi64>) -> vector<1x2x3xi64>, sym_name = "shrs_vector"}> ({
  ^bb0(%arg1: vector<1x2x3xi64>):
    %12 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<1x2x3xi64>) -> !llvm.array<1 x array<2 x vector<3xi64>>>
    %13 = "llvm.mlir.constant"() <{value = dense<1> : vector<1x2x3xi64>}> : () -> !llvm.array<1 x array<2 x vector<3xi64>>>
    %14 = "llvm.mlir.poison"() : () -> !llvm.array<1 x array<2 x vector<3xi64>>>
    %15 = "llvm.extractvalue"(%12) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>) -> vector<3xi64>
    %16 = "llvm.extractvalue"(%13) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>) -> vector<3xi64>
    %17 = "llvm.ashr"(%15, %16) : (vector<3xi64>, vector<3xi64>) -> vector<3xi64>
    %18 = "llvm.insertvalue"(%14, %17) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>, vector<3xi64>) -> !llvm.array<1 x array<2 x vector<3xi64>>>
    %19 = "llvm.extractvalue"(%12) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>) -> vector<3xi64>
    %20 = "llvm.extractvalue"(%13) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>) -> vector<3xi64>
    %21 = "llvm.ashr"(%19, %20) : (vector<3xi64>, vector<3xi64>) -> vector<3xi64>
    %22 = "llvm.insertvalue"(%18, %21) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>, vector<3xi64>) -> !llvm.array<1 x array<2 x vector<3xi64>>>
    %23 = "builtin.unrealized_conversion_cast"(%22) : (!llvm.array<1 x array<2 x vector<3xi64>>>) -> vector<1x2x3xi64>
    "func.return"(%23) : (vector<1x2x3xi64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xi64>) -> vector<1x2x3xi64>, sym_name = "shru_vector"}> ({
  ^bb0(%arg0: vector<1x2x3xi64>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<1x2x3xi64>) -> !llvm.array<1 x array<2 x vector<3xi64>>>
    %1 = "llvm.mlir.constant"() <{value = dense<1> : vector<1x2x3xi64>}> : () -> !llvm.array<1 x array<2 x vector<3xi64>>>
    %2 = "llvm.mlir.poison"() : () -> !llvm.array<1 x array<2 x vector<3xi64>>>
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>) -> vector<3xi64>
    %4 = "llvm.extractvalue"(%1) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>) -> vector<3xi64>
    %5 = "llvm.lshr"(%3, %4) : (vector<3xi64>, vector<3xi64>) -> vector<3xi64>
    %6 = "llvm.insertvalue"(%2, %5) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>, vector<3xi64>) -> !llvm.array<1 x array<2 x vector<3xi64>>>
    %7 = "llvm.extractvalue"(%0) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>) -> vector<3xi64>
    %8 = "llvm.extractvalue"(%1) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>) -> vector<3xi64>
    %9 = "llvm.lshr"(%7, %8) : (vector<3xi64>, vector<3xi64>) -> vector<3xi64>
    %10 = "llvm.insertvalue"(%6, %9) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>, vector<3xi64>) -> !llvm.array<1 x array<2 x vector<3xi64>>>
    %11 = "builtin.unrealized_conversion_cast"(%10) : (!llvm.array<1 x array<2 x vector<3xi64>>>) -> vector<1x2x3xi64>
    "func.return"(%11) : (vector<1x2x3xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x4xf32>) -> (), sym_name = "bitcast_2d"}> ({
  ^bb0(%arg0: vector<2x4xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<2x4xf32>) -> !llvm.array<2 x vector<4xf32>>
    %1 = "llvm.mlir.poison"() : () -> !llvm.array<2 x vector<4xi32>>
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<4xf32>>) -> vector<4xf32>
    %3 = "llvm.bitcast"(%2) : (vector<4xf32>) -> vector<4xi32>
    %4 = "llvm.insertvalue"(%1, %3) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<4xi32>>, vector<4xi32>) -> !llvm.array<2 x vector<4xi32>>
    %5 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<4xf32>>) -> vector<4xf32>
    %6 = "llvm.bitcast"(%5) : (vector<4xf32>) -> vector<4xi32>
    %7 = "llvm.insertvalue"(%4, %6) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<4xi32>>, vector<4xi32>) -> !llvm.array<2 x vector<4xi32>>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x3xi1>, vector<4x3xi32>, vector<4x3xi32>) -> (), sym_name = "select_2d"}> ({
  ^bb0(%arg1: vector<4x3xi1>, %arg2: vector<4x3xi32>, %arg3: vector<4x3xi32>):
    %15 = "builtin.unrealized_conversion_cast"(%arg3) : (vector<4x3xi32>) -> !llvm.array<4 x vector<3xi32>>
    %16 = "builtin.unrealized_conversion_cast"(%arg2) : (vector<4x3xi32>) -> !llvm.array<4 x vector<3xi32>>
    %17 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<4x3xi1>) -> !llvm.array<4 x vector<3xi1>>
    %18 = "llvm.mlir.poison"() : () -> !llvm.array<4 x vector<3xi32>>
    %19 = "llvm.extractvalue"(%17) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<3xi1>>) -> vector<3xi1>
    %20 = "llvm.extractvalue"(%16) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<3xi32>>) -> vector<3xi32>
    %21 = "llvm.extractvalue"(%15) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<3xi32>>) -> vector<3xi32>
    %22 = "llvm.select"(%19, %20, %21) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xi1>, vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    %23 = "llvm.insertvalue"(%18, %22) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<3xi32>>, vector<3xi32>) -> !llvm.array<4 x vector<3xi32>>
    %24 = "llvm.extractvalue"(%17) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<3xi1>>) -> vector<3xi1>
    %25 = "llvm.extractvalue"(%16) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<3xi32>>) -> vector<3xi32>
    %26 = "llvm.extractvalue"(%15) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<3xi32>>) -> vector<3xi32>
    %27 = "llvm.select"(%24, %25, %26) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xi1>, vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    %28 = "llvm.insertvalue"(%23, %27) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<3xi32>>, vector<3xi32>) -> !llvm.array<4 x vector<3xi32>>
    %29 = "llvm.extractvalue"(%17) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<3xi1>>) -> vector<3xi1>
    %30 = "llvm.extractvalue"(%16) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<3xi32>>) -> vector<3xi32>
    %31 = "llvm.extractvalue"(%15) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<3xi32>>) -> vector<3xi32>
    %32 = "llvm.select"(%29, %30, %31) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xi1>, vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    %33 = "llvm.insertvalue"(%28, %32) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<3xi32>>, vector<3xi32>) -> !llvm.array<4 x vector<3xi32>>
    %34 = "llvm.extractvalue"(%17) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<3xi1>>) -> vector<3xi1>
    %35 = "llvm.extractvalue"(%16) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<3xi32>>) -> vector<3xi32>
    %36 = "llvm.extractvalue"(%15) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<3xi32>>) -> vector<3xi32>
    %37 = "llvm.select"(%34, %35, %36) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xi1>, vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    %38 = "llvm.insertvalue"(%33, %37) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<3xi32>>, vector<3xi32>) -> !llvm.array<4 x vector<3xi32>>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xi1>) -> (), sym_name = "index_cast_2d"}> ({
  ^bb0(%arg0: vector<1x2x3xi1>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<1x2x3xi1>) -> !llvm.array<1 x array<2 x vector<3xi1>>>
    %1 = "llvm.mlir.poison"() : () -> !llvm.array<1 x array<2 x vector<3xi64>>>
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi1>>>) -> vector<3xi1>
    %3 = "llvm.sext"(%2) : (vector<3xi1>) -> vector<3xi64>
    %4 = "llvm.insertvalue"(%1, %3) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>, vector<3xi64>) -> !llvm.array<1 x array<2 x vector<3xi64>>>
    %5 = "llvm.extractvalue"(%0) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi1>>>) -> vector<3xi1>
    %6 = "llvm.sext"(%5) : (vector<3xi1>) -> vector<3xi64>
    %7 = "llvm.insertvalue"(%4, %6) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>, vector<3xi64>) -> !llvm.array<1 x array<2 x vector<3xi64>>>
    %8 = "llvm.mlir.poison"() : () -> !llvm.array<1 x array<2 x vector<3xi1>>>
    %9 = "llvm.extractvalue"(%7) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>) -> vector<3xi64>
    %10 = "llvm.trunc"(%9) <{overflowFlags = 0 : i32}> : (vector<3xi64>) -> vector<3xi1>
    %11 = "llvm.insertvalue"(%8, %10) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi1>>>, vector<3xi1>) -> !llvm.array<1 x array<2 x vector<3xi1>>>
    %12 = "llvm.extractvalue"(%7) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>) -> vector<3xi64>
    %13 = "llvm.trunc"(%12) <{overflowFlags = 0 : i32}> : (vector<3xi64>) -> vector<3xi1>
    %14 = "llvm.insertvalue"(%11, %13) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi1>>>, vector<3xi1>) -> !llvm.array<1 x array<2 x vector<3xi1>>>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

