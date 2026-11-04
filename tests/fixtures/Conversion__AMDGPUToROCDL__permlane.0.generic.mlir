"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "test_permlane16_i32"}> ({
  ^bb0(%arg10: i32):
    %114 = "rocdl.permlane16.swap"(%arg10, %arg10) <{boundControl = false, fi = false}> : (i32, i32) -> !llvm.struct<(i32, i32)>
    %115 = "llvm.extractvalue"(%114) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>) -> i32
    %116 = "llvm.extractvalue"(%114) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>) -> i32
    %117 = "llvm.icmp"(%115, %arg10) <{predicate = 0 : i64}> : (i32, i32) -> i1
    %118 = "llvm.select"(%117, %116, %115) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    "func.return"(%118) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "test_permlane16_i32_optional_attr"}> ({
  ^bb0(%arg9: i32):
    %109 = "rocdl.permlane16.swap"(%arg9, %arg9) <{boundControl = true, fi = true}> : (i32, i32) -> !llvm.struct<(i32, i32)>
    %110 = "llvm.extractvalue"(%109) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>) -> i32
    %111 = "llvm.extractvalue"(%109) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>) -> i32
    %112 = "llvm.icmp"(%110, %arg9) <{predicate = 0 : i64}> : (i32, i32) -> i1
    %113 = "llvm.select"(%112, %111, %110) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    "func.return"(%113) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "test_permlane32_i32"}> ({
  ^bb0(%arg8: i32):
    %104 = "rocdl.permlane32.swap"(%arg8, %arg8) <{boundControl = false, fi = false}> : (i32, i32) -> !llvm.struct<(i32, i32)>
    %105 = "llvm.extractvalue"(%104) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>) -> i32
    %106 = "llvm.extractvalue"(%104) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>) -> i32
    %107 = "llvm.icmp"(%105, %arg8) <{predicate = 0 : i64}> : (i32, i32) -> i1
    %108 = "llvm.select"(%107, %106, %105) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    "func.return"(%108) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "test_permlane16_f32"}> ({
  ^bb0(%arg7: f32):
    %97 = "llvm.bitcast"(%arg7) : (f32) -> i32
    %98 = "rocdl.permlane16.swap"(%97, %97) <{boundControl = false, fi = false}> : (i32, i32) -> !llvm.struct<(i32, i32)>
    %99 = "llvm.extractvalue"(%98) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>) -> i32
    %100 = "llvm.extractvalue"(%98) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>) -> i32
    %101 = "llvm.icmp"(%99, %97) <{predicate = 0 : i64}> : (i32, i32) -> i1
    %102 = "llvm.select"(%101, %100, %99) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    %103 = "llvm.bitcast"(%102) : (i32) -> f32
    "func.return"(%103) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "test_permlane32_f32"}> ({
  ^bb0(%arg6: f32):
    %90 = "llvm.bitcast"(%arg6) : (f32) -> i32
    %91 = "rocdl.permlane32.swap"(%90, %90) <{boundControl = false, fi = false}> : (i32, i32) -> !llvm.struct<(i32, i32)>
    %92 = "llvm.extractvalue"(%91) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>) -> i32
    %93 = "llvm.extractvalue"(%91) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>) -> i32
    %94 = "llvm.icmp"(%92, %90) <{predicate = 0 : i64}> : (i32, i32) -> i1
    %95 = "llvm.select"(%94, %93, %92) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    %96 = "llvm.bitcast"(%95) : (i32) -> f32
    "func.return"(%96) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16) -> f16, sym_name = "test_permlane16_f16"}> ({
  ^bb0(%arg5: f16):
    %81 = "llvm.bitcast"(%arg5) : (f16) -> i16
    %82 = "llvm.zext"(%81) : (i16) -> i32
    %83 = "rocdl.permlane16.swap"(%82, %82) <{boundControl = false, fi = false}> : (i32, i32) -> !llvm.struct<(i32, i32)>
    %84 = "llvm.extractvalue"(%83) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>) -> i32
    %85 = "llvm.extractvalue"(%83) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>) -> i32
    %86 = "llvm.icmp"(%84, %82) <{predicate = 0 : i64}> : (i32, i32) -> i1
    %87 = "llvm.select"(%86, %85, %84) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    %88 = "llvm.trunc"(%87) <{overflowFlags = 0 : i32}> : (i32) -> i16
    %89 = "llvm.bitcast"(%88) : (i16) -> f16
    "func.return"(%89) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16) -> f16, sym_name = "test_permlane32_f16"}> ({
  ^bb0(%arg4: f16):
    %72 = "llvm.bitcast"(%arg4) : (f16) -> i16
    %73 = "llvm.zext"(%72) : (i16) -> i32
    %74 = "rocdl.permlane32.swap"(%73, %73) <{boundControl = false, fi = false}> : (i32, i32) -> !llvm.struct<(i32, i32)>
    %75 = "llvm.extractvalue"(%74) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>) -> i32
    %76 = "llvm.extractvalue"(%74) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>) -> i32
    %77 = "llvm.icmp"(%75, %73) <{predicate = 0 : i64}> : (i32, i32) -> i1
    %78 = "llvm.select"(%77, %76, %75) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    %79 = "llvm.trunc"(%78) <{overflowFlags = 0 : i32}> : (i32) -> i16
    %80 = "llvm.bitcast"(%79) : (i16) -> f16
    "func.return"(%80) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi32>) -> vector<2xi32>, sym_name = "test_permlane16_2xi32"}> ({
  ^bb0(%arg3: vector<2xi32>):
    %55 = "llvm.mlir.poison"() : () -> vector<2xi32>
    %56 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %57 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %58 = "llvm.extractelement"(%arg3, %57) : (vector<2xi32>, i32) -> i32
    %59 = "llvm.extractelement"(%arg3, %56) : (vector<2xi32>, i32) -> i32
    %60 = "rocdl.permlane16.swap"(%58, %58) <{boundControl = false, fi = false}> : (i32, i32) -> !llvm.struct<(i32, i32)>
    %61 = "llvm.extractvalue"(%60) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>) -> i32
    %62 = "llvm.extractvalue"(%60) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>) -> i32
    %63 = "llvm.icmp"(%61, %58) <{predicate = 0 : i64}> : (i32, i32) -> i1
    %64 = "llvm.select"(%63, %62, %61) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    %65 = "rocdl.permlane16.swap"(%59, %59) <{boundControl = false, fi = false}> : (i32, i32) -> !llvm.struct<(i32, i32)>
    %66 = "llvm.extractvalue"(%65) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>) -> i32
    %67 = "llvm.extractvalue"(%65) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>) -> i32
    %68 = "llvm.icmp"(%66, %59) <{predicate = 0 : i64}> : (i32, i32) -> i1
    %69 = "llvm.select"(%68, %67, %66) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    %70 = "llvm.insertelement"(%55, %64, %57) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %71 = "llvm.insertelement"(%70, %69, %56) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    "func.return"(%71) : (vector<2xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi32>) -> vector<2xi32>, sym_name = "test_permlane32_2xi32"}> ({
  ^bb0(%arg2: vector<2xi32>):
    %38 = "llvm.mlir.poison"() : () -> vector<2xi32>
    %39 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %40 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %41 = "llvm.extractelement"(%arg2, %40) : (vector<2xi32>, i32) -> i32
    %42 = "llvm.extractelement"(%arg2, %39) : (vector<2xi32>, i32) -> i32
    %43 = "rocdl.permlane32.swap"(%41, %41) <{boundControl = false, fi = false}> : (i32, i32) -> !llvm.struct<(i32, i32)>
    %44 = "llvm.extractvalue"(%43) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>) -> i32
    %45 = "llvm.extractvalue"(%43) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>) -> i32
    %46 = "llvm.icmp"(%44, %41) <{predicate = 0 : i64}> : (i32, i32) -> i1
    %47 = "llvm.select"(%46, %45, %44) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    %48 = "rocdl.permlane32.swap"(%42, %42) <{boundControl = false, fi = false}> : (i32, i32) -> !llvm.struct<(i32, i32)>
    %49 = "llvm.extractvalue"(%48) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>) -> i32
    %50 = "llvm.extractvalue"(%48) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>) -> i32
    %51 = "llvm.icmp"(%49, %42) <{predicate = 0 : i64}> : (i32, i32) -> i1
    %52 = "llvm.select"(%51, %50, %49) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    %53 = "llvm.insertelement"(%38, %47, %40) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %54 = "llvm.insertelement"(%53, %52, %39) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    "func.return"(%54) : (vector<2xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf16>) -> vector<4xf16>, sym_name = "test_permlane16_4xf16"}> ({
  ^bb0(%arg1: vector<4xf16>):
    %19 = "llvm.mlir.poison"() : () -> vector<2xi32>
    %20 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %21 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %22 = "llvm.bitcast"(%arg1) : (vector<4xf16>) -> vector<2xi32>
    %23 = "llvm.extractelement"(%22, %21) : (vector<2xi32>, i32) -> i32
    %24 = "llvm.extractelement"(%22, %20) : (vector<2xi32>, i32) -> i32
    %25 = "rocdl.permlane16.swap"(%23, %23) <{boundControl = false, fi = false}> : (i32, i32) -> !llvm.struct<(i32, i32)>
    %26 = "llvm.extractvalue"(%25) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>) -> i32
    %27 = "llvm.extractvalue"(%25) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>) -> i32
    %28 = "llvm.icmp"(%26, %23) <{predicate = 0 : i64}> : (i32, i32) -> i1
    %29 = "llvm.select"(%28, %27, %26) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    %30 = "rocdl.permlane16.swap"(%24, %24) <{boundControl = false, fi = false}> : (i32, i32) -> !llvm.struct<(i32, i32)>
    %31 = "llvm.extractvalue"(%30) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>) -> i32
    %32 = "llvm.extractvalue"(%30) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>) -> i32
    %33 = "llvm.icmp"(%31, %24) <{predicate = 0 : i64}> : (i32, i32) -> i1
    %34 = "llvm.select"(%33, %32, %31) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    %35 = "llvm.insertelement"(%19, %29, %21) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %36 = "llvm.insertelement"(%35, %34, %20) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %37 = "llvm.bitcast"(%36) : (vector<2xi32>) -> vector<4xf16>
    "func.return"(%37) : (vector<4xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf16>) -> vector<4xf16>, sym_name = "test_permlane32_4xf16"}> ({
  ^bb0(%arg0: vector<4xf16>):
    %0 = "llvm.mlir.poison"() : () -> vector<2xi32>
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "llvm.bitcast"(%arg0) : (vector<4xf16>) -> vector<2xi32>
    %4 = "llvm.extractelement"(%3, %2) : (vector<2xi32>, i32) -> i32
    %5 = "llvm.extractelement"(%3, %1) : (vector<2xi32>, i32) -> i32
    %6 = "rocdl.permlane32.swap"(%4, %4) <{boundControl = false, fi = false}> : (i32, i32) -> !llvm.struct<(i32, i32)>
    %7 = "llvm.extractvalue"(%6) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>) -> i32
    %8 = "llvm.extractvalue"(%6) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>) -> i32
    %9 = "llvm.icmp"(%7, %4) <{predicate = 0 : i64}> : (i32, i32) -> i1
    %10 = "llvm.select"(%9, %8, %7) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    %11 = "rocdl.permlane32.swap"(%5, %5) <{boundControl = false, fi = false}> : (i32, i32) -> !llvm.struct<(i32, i32)>
    %12 = "llvm.extractvalue"(%11) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32)>) -> i32
    %13 = "llvm.extractvalue"(%11) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32)>) -> i32
    %14 = "llvm.icmp"(%12, %5) <{predicate = 0 : i64}> : (i32, i32) -> i1
    %15 = "llvm.select"(%14, %13, %12) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    %16 = "llvm.insertelement"(%0, %10, %2) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %17 = "llvm.insertelement"(%16, %15, %1) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %18 = "llvm.bitcast"(%17) : (vector<2xi32>) -> vector<4xf16>
    "func.return"(%18) : (vector<4xf16>) -> ()
  }) : () -> ()
}) : () -> ()

