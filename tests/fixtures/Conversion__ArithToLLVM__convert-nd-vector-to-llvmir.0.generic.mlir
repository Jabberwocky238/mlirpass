"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2x2xf32>) -> vector<2x2x2xf32>, sym_name = "vec_bin"}> ({
  ^bb0(%arg15: vector<2x2x2xf32>):
    %126 = "builtin.unrealized_conversion_cast"(%arg15) : (vector<2x2x2xf32>) -> !llvm.array<2 x array<2 x vector<2xf32>>>
    %127 = "llvm.mlir.poison"() : () -> !llvm.array<2 x array<2 x vector<2xf32>>>
    %128 = "llvm.extractvalue"(%126) <{position = array<i64: 0, 0>}> : (!llvm.array<2 x array<2 x vector<2xf32>>>) -> vector<2xf32>
    %129 = "llvm.extractvalue"(%126) <{position = array<i64: 0, 0>}> : (!llvm.array<2 x array<2 x vector<2xf32>>>) -> vector<2xf32>
    %130 = "llvm.fadd"(%128, %129) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %131 = "llvm.insertvalue"(%127, %130) <{position = array<i64: 0, 0>}> : (!llvm.array<2 x array<2 x vector<2xf32>>>, vector<2xf32>) -> !llvm.array<2 x array<2 x vector<2xf32>>>
    %132 = "llvm.extractvalue"(%126) <{position = array<i64: 0, 1>}> : (!llvm.array<2 x array<2 x vector<2xf32>>>) -> vector<2xf32>
    %133 = "llvm.extractvalue"(%126) <{position = array<i64: 0, 1>}> : (!llvm.array<2 x array<2 x vector<2xf32>>>) -> vector<2xf32>
    %134 = "llvm.fadd"(%132, %133) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %135 = "llvm.insertvalue"(%131, %134) <{position = array<i64: 0, 1>}> : (!llvm.array<2 x array<2 x vector<2xf32>>>, vector<2xf32>) -> !llvm.array<2 x array<2 x vector<2xf32>>>
    %136 = "llvm.extractvalue"(%126) <{position = array<i64: 1, 0>}> : (!llvm.array<2 x array<2 x vector<2xf32>>>) -> vector<2xf32>
    %137 = "llvm.extractvalue"(%126) <{position = array<i64: 1, 0>}> : (!llvm.array<2 x array<2 x vector<2xf32>>>) -> vector<2xf32>
    %138 = "llvm.fadd"(%136, %137) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %139 = "llvm.insertvalue"(%135, %138) <{position = array<i64: 1, 0>}> : (!llvm.array<2 x array<2 x vector<2xf32>>>, vector<2xf32>) -> !llvm.array<2 x array<2 x vector<2xf32>>>
    %140 = "llvm.extractvalue"(%126) <{position = array<i64: 1, 1>}> : (!llvm.array<2 x array<2 x vector<2xf32>>>) -> vector<2xf32>
    %141 = "llvm.extractvalue"(%126) <{position = array<i64: 1, 1>}> : (!llvm.array<2 x array<2 x vector<2xf32>>>) -> vector<2xf32>
    %142 = "llvm.fadd"(%140, %141) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %143 = "llvm.insertvalue"(%139, %142) <{position = array<i64: 1, 1>}> : (!llvm.array<2 x array<2 x vector<2xf32>>>, vector<2xf32>) -> !llvm.array<2 x array<2 x vector<2xf32>>>
    %144 = "builtin.unrealized_conversion_cast"(%143) : (!llvm.array<2 x array<2 x vector<2xf32>>>) -> vector<2x2x2xf32>
    "func.return"(%144) : (vector<2x2x2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xi32>, vector<1x2x3xi64>) -> (), sym_name = "sexti_vector"}> ({
  ^bb0(%arg13: vector<1x2x3xi32>, %arg14: vector<1x2x3xi64>):
    %118 = "builtin.unrealized_conversion_cast"(%arg13) : (vector<1x2x3xi32>) -> !llvm.array<1 x array<2 x vector<3xi32>>>
    %119 = "llvm.mlir.poison"() : () -> !llvm.array<1 x array<2 x vector<3xi64>>>
    %120 = "llvm.extractvalue"(%118) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi32>>>) -> vector<3xi32>
    %121 = "llvm.sext"(%120) : (vector<3xi32>) -> vector<3xi64>
    %122 = "llvm.insertvalue"(%119, %121) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>, vector<3xi64>) -> !llvm.array<1 x array<2 x vector<3xi64>>>
    %123 = "llvm.extractvalue"(%118) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi32>>>) -> vector<3xi32>
    %124 = "llvm.sext"(%123) : (vector<3xi32>) -> vector<3xi64>
    %125 = "llvm.insertvalue"(%122, %124) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>, vector<3xi64>) -> !llvm.array<1 x array<2 x vector<3xi64>>>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xi32>, vector<1x2x3xi64>) -> (), sym_name = "zexti_vector"}> ({
  ^bb0(%arg11: vector<1x2x3xi32>, %arg12: vector<1x2x3xi64>):
    %110 = "builtin.unrealized_conversion_cast"(%arg11) : (vector<1x2x3xi32>) -> !llvm.array<1 x array<2 x vector<3xi32>>>
    %111 = "llvm.mlir.poison"() : () -> !llvm.array<1 x array<2 x vector<3xi64>>>
    %112 = "llvm.extractvalue"(%110) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi32>>>) -> vector<3xi32>
    %113 = "llvm.zext"(%112) : (vector<3xi32>) -> vector<3xi64>
    %114 = "llvm.insertvalue"(%111, %113) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>, vector<3xi64>) -> !llvm.array<1 x array<2 x vector<3xi64>>>
    %115 = "llvm.extractvalue"(%110) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi32>>>) -> vector<3xi32>
    %116 = "llvm.zext"(%115) : (vector<3xi32>) -> vector<3xi64>
    %117 = "llvm.insertvalue"(%114, %116) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi64>>>, vector<3xi64>) -> !llvm.array<1 x array<2 x vector<3xi64>>>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xi32>) -> vector<1x2x3xf32>, sym_name = "sitofp_vector"}> ({
  ^bb0(%arg10: vector<1x2x3xi32>):
    %101 = "builtin.unrealized_conversion_cast"(%arg10) : (vector<1x2x3xi32>) -> !llvm.array<1 x array<2 x vector<3xi32>>>
    %102 = "llvm.mlir.poison"() : () -> !llvm.array<1 x array<2 x vector<3xf32>>>
    %103 = "llvm.extractvalue"(%101) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi32>>>) -> vector<3xi32>
    %104 = "llvm.sitofp"(%103) : (vector<3xi32>) -> vector<3xf32>
    %105 = "llvm.insertvalue"(%102, %104) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xf32>>>, vector<3xf32>) -> !llvm.array<1 x array<2 x vector<3xf32>>>
    %106 = "llvm.extractvalue"(%101) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi32>>>) -> vector<3xi32>
    %107 = "llvm.sitofp"(%106) : (vector<3xi32>) -> vector<3xf32>
    %108 = "llvm.insertvalue"(%105, %107) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xf32>>>, vector<3xf32>) -> !llvm.array<1 x array<2 x vector<3xf32>>>
    %109 = "builtin.unrealized_conversion_cast"(%108) : (!llvm.array<1 x array<2 x vector<3xf32>>>) -> vector<1x2x3xf32>
    "func.return"(%109) : (vector<1x2x3xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xi32>) -> vector<1x2x3xf32>, sym_name = "uitofp_vector"}> ({
  ^bb0(%arg9: vector<1x2x3xi32>):
    %92 = "builtin.unrealized_conversion_cast"(%arg9) : (vector<1x2x3xi32>) -> !llvm.array<1 x array<2 x vector<3xi32>>>
    %93 = "llvm.mlir.poison"() : () -> !llvm.array<1 x array<2 x vector<3xf32>>>
    %94 = "llvm.extractvalue"(%92) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi32>>>) -> vector<3xi32>
    %95 = "llvm.uitofp"(%94) : (vector<3xi32>) -> vector<3xf32>
    %96 = "llvm.insertvalue"(%93, %95) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xf32>>>, vector<3xf32>) -> !llvm.array<1 x array<2 x vector<3xf32>>>
    %97 = "llvm.extractvalue"(%92) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi32>>>) -> vector<3xi32>
    %98 = "llvm.uitofp"(%97) : (vector<3xi32>) -> vector<3xf32>
    %99 = "llvm.insertvalue"(%96, %98) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xf32>>>, vector<3xf32>) -> !llvm.array<1 x array<2 x vector<3xf32>>>
    %100 = "builtin.unrealized_conversion_cast"(%99) : (!llvm.array<1 x array<2 x vector<3xf32>>>) -> vector<1x2x3xf32>
    "func.return"(%100) : (vector<1x2x3xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xf32>) -> vector<1x2x3xi32>, sym_name = "fptosi_vector"}> ({
  ^bb0(%arg8: vector<1x2x3xf32>):
    %83 = "builtin.unrealized_conversion_cast"(%arg8) : (vector<1x2x3xf32>) -> !llvm.array<1 x array<2 x vector<3xf32>>>
    %84 = "llvm.mlir.poison"() : () -> !llvm.array<1 x array<2 x vector<3xi32>>>
    %85 = "llvm.extractvalue"(%83) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xf32>>>) -> vector<3xf32>
    %86 = "llvm.fptosi"(%85) : (vector<3xf32>) -> vector<3xi32>
    %87 = "llvm.insertvalue"(%84, %86) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi32>>>, vector<3xi32>) -> !llvm.array<1 x array<2 x vector<3xi32>>>
    %88 = "llvm.extractvalue"(%83) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xf32>>>) -> vector<3xf32>
    %89 = "llvm.fptosi"(%88) : (vector<3xf32>) -> vector<3xi32>
    %90 = "llvm.insertvalue"(%87, %89) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi32>>>, vector<3xi32>) -> !llvm.array<1 x array<2 x vector<3xi32>>>
    %91 = "builtin.unrealized_conversion_cast"(%90) : (!llvm.array<1 x array<2 x vector<3xi32>>>) -> vector<1x2x3xi32>
    "func.return"(%91) : (vector<1x2x3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xf32>) -> vector<1x2x3xi32>, sym_name = "fptoui_vector"}> ({
  ^bb0(%arg7: vector<1x2x3xf32>):
    %74 = "builtin.unrealized_conversion_cast"(%arg7) : (vector<1x2x3xf32>) -> !llvm.array<1 x array<2 x vector<3xf32>>>
    %75 = "llvm.mlir.poison"() : () -> !llvm.array<1 x array<2 x vector<3xi32>>>
    %76 = "llvm.extractvalue"(%74) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xf32>>>) -> vector<3xf32>
    %77 = "llvm.fptoui"(%76) : (vector<3xf32>) -> vector<3xi32>
    %78 = "llvm.insertvalue"(%75, %77) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xi32>>>, vector<3xi32>) -> !llvm.array<1 x array<2 x vector<3xi32>>>
    %79 = "llvm.extractvalue"(%74) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xf32>>>) -> vector<3xf32>
    %80 = "llvm.fptoui"(%79) : (vector<3xf32>) -> vector<3xi32>
    %81 = "llvm.insertvalue"(%78, %80) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xi32>>>, vector<3xi32>) -> !llvm.array<1 x array<2 x vector<3xi32>>>
    %82 = "builtin.unrealized_conversion_cast"(%81) : (!llvm.array<1 x array<2 x vector<3xi32>>>) -> vector<1x2x3xi32>
    "func.return"(%82) : (vector<1x2x3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xf16>) -> vector<1x2x3xf64>, sym_name = "fpext_vector"}> ({
  ^bb0(%arg6: vector<1x2x3xf16>):
    %65 = "builtin.unrealized_conversion_cast"(%arg6) : (vector<1x2x3xf16>) -> !llvm.array<1 x array<2 x vector<3xf16>>>
    %66 = "llvm.mlir.poison"() : () -> !llvm.array<1 x array<2 x vector<3xf64>>>
    %67 = "llvm.extractvalue"(%65) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xf16>>>) -> vector<3xf16>
    %68 = "llvm.fpext"(%67) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>) -> vector<3xf64>
    %69 = "llvm.insertvalue"(%66, %68) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xf64>>>, vector<3xf64>) -> !llvm.array<1 x array<2 x vector<3xf64>>>
    %70 = "llvm.extractvalue"(%65) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xf16>>>) -> vector<3xf16>
    %71 = "llvm.fpext"(%70) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>) -> vector<3xf64>
    %72 = "llvm.insertvalue"(%69, %71) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xf64>>>, vector<3xf64>) -> !llvm.array<1 x array<2 x vector<3xf64>>>
    %73 = "builtin.unrealized_conversion_cast"(%72) : (!llvm.array<1 x array<2 x vector<3xf64>>>) -> vector<1x2x3xf64>
    "func.return"(%73) : (vector<1x2x3xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xf64>) -> vector<1x2x3xf16>, sym_name = "fptrunc_vector"}> ({
  ^bb0(%arg5: vector<1x2x3xf64>):
    %56 = "builtin.unrealized_conversion_cast"(%arg5) : (vector<1x2x3xf64>) -> !llvm.array<1 x array<2 x vector<3xf64>>>
    %57 = "llvm.mlir.poison"() : () -> !llvm.array<1 x array<2 x vector<3xf16>>>
    %58 = "llvm.extractvalue"(%56) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xf64>>>) -> vector<3xf64>
    %59 = "llvm.fptrunc"(%58) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf64>) -> vector<3xf16>
    %60 = "llvm.insertvalue"(%57, %59) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xf16>>>, vector<3xf16>) -> !llvm.array<1 x array<2 x vector<3xf16>>>
    %61 = "llvm.extractvalue"(%56) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xf64>>>) -> vector<3xf64>
    %62 = "llvm.fptrunc"(%61) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf64>) -> vector<3xf16>
    %63 = "llvm.insertvalue"(%60, %62) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xf16>>>, vector<3xf16>) -> !llvm.array<1 x array<2 x vector<3xf16>>>
    %64 = "builtin.unrealized_conversion_cast"(%63) : (!llvm.array<1 x array<2 x vector<3xf16>>>) -> vector<1x2x3xf16>
    "func.return"(%64) : (vector<1x2x3xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xf16>) -> vector<1x2x3xbf16>, sym_name = "convertf_vector"}> ({
  ^bb0(%arg4: vector<1x2x3xf16>):
    %45 = "builtin.unrealized_conversion_cast"(%arg4) : (vector<1x2x3xf16>) -> !llvm.array<1 x array<2 x vector<3xf16>>>
    %46 = "llvm.mlir.poison"() : () -> !llvm.array<1 x array<2 x vector<3xbf16>>>
    %47 = "llvm.extractvalue"(%45) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xf16>>>) -> vector<3xf16>
    %48 = "llvm.fpext"(%47) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>) -> vector<3xf32>
    %49 = "llvm.fptrunc"(%48) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf32>) -> vector<3xbf16>
    %50 = "llvm.insertvalue"(%46, %49) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<2 x vector<3xbf16>>>, vector<3xbf16>) -> !llvm.array<1 x array<2 x vector<3xbf16>>>
    %51 = "llvm.extractvalue"(%45) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xf16>>>) -> vector<3xf16>
    %52 = "llvm.fpext"(%51) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>) -> vector<3xf32>
    %53 = "llvm.fptrunc"(%52) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf32>) -> vector<3xbf16>
    %54 = "llvm.insertvalue"(%50, %53) <{position = array<i64: 0, 1>}> : (!llvm.array<1 x array<2 x vector<3xbf16>>>, vector<3xbf16>) -> !llvm.array<1 x array<2 x vector<3xbf16>>>
    %55 = "builtin.unrealized_conversion_cast"(%54) : (!llvm.array<1 x array<2 x vector<3xbf16>>>) -> vector<1x2x3xbf16>
    "func.return"(%55) : (vector<1x2x3xbf16>) -> ()
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
    %8 = "builtin.unrealized_conversion_cast"(%arg3) : (vector<4x3xi32>) -> !llvm.array<4 x vector<3xi32>>
    %9 = "builtin.unrealized_conversion_cast"(%arg2) : (vector<4x3xi32>) -> !llvm.array<4 x vector<3xi32>>
    %10 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<4x3xi1>) -> !llvm.array<4 x vector<3xi1>>
    %11 = "llvm.mlir.poison"() : () -> !llvm.array<4 x vector<3xi32>>
    %12 = "llvm.extractvalue"(%10) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<3xi1>>) -> vector<3xi1>
    %13 = "llvm.extractvalue"(%9) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<3xi32>>) -> vector<3xi32>
    %14 = "llvm.extractvalue"(%8) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<3xi32>>) -> vector<3xi32>
    %15 = "llvm.select"(%12, %13, %14) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xi1>, vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    %16 = "llvm.insertvalue"(%11, %15) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<3xi32>>, vector<3xi32>) -> !llvm.array<4 x vector<3xi32>>
    %17 = "llvm.extractvalue"(%10) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<3xi1>>) -> vector<3xi1>
    %18 = "llvm.extractvalue"(%9) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<3xi32>>) -> vector<3xi32>
    %19 = "llvm.extractvalue"(%8) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<3xi32>>) -> vector<3xi32>
    %20 = "llvm.select"(%17, %18, %19) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xi1>, vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    %21 = "llvm.insertvalue"(%16, %20) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<3xi32>>, vector<3xi32>) -> !llvm.array<4 x vector<3xi32>>
    %22 = "llvm.extractvalue"(%10) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<3xi1>>) -> vector<3xi1>
    %23 = "llvm.extractvalue"(%9) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<3xi32>>) -> vector<3xi32>
    %24 = "llvm.extractvalue"(%8) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<3xi32>>) -> vector<3xi32>
    %25 = "llvm.select"(%22, %23, %24) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xi1>, vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    %26 = "llvm.insertvalue"(%21, %25) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<3xi32>>, vector<3xi32>) -> !llvm.array<4 x vector<3xi32>>
    %27 = "llvm.extractvalue"(%10) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<3xi1>>) -> vector<3xi1>
    %28 = "llvm.extractvalue"(%9) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<3xi32>>) -> vector<3xi32>
    %29 = "llvm.extractvalue"(%8) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<3xi32>>) -> vector<3xi32>
    %30 = "llvm.select"(%27, %28, %29) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xi1>, vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    %31 = "llvm.insertvalue"(%26, %30) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<3xi32>>, vector<3xi32>) -> !llvm.array<4 x vector<3xi32>>
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
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

