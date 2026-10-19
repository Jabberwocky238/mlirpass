"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_div"}> ({
  ^bb0(%arg2: complex<f32>, %arg3: complex<f32>):
    %97 = "builtin.unrealized_conversion_cast"(%arg3) : (complex<f32>) -> !llvm.struct<(f32, f32)>
    %98 = "builtin.unrealized_conversion_cast"(%arg2) : (complex<f32>) -> !llvm.struct<(f32, f32)>
    %99 = "llvm.extractvalue"(%98) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %100 = "llvm.extractvalue"(%98) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %101 = "llvm.extractvalue"(%97) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %102 = "llvm.extractvalue"(%97) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %103 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f32)>
    %104 = "llvm.fdiv"(%101, %102) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %105 = "llvm.fmul"(%104, %101) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %106 = "llvm.fadd"(%102, %105) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %107 = "llvm.fmul"(%99, %104) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %108 = "llvm.fadd"(%107, %100) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %109 = "llvm.fdiv"(%108, %106) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %110 = "llvm.fmul"(%100, %104) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %111 = "llvm.fsub"(%110, %99) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %112 = "llvm.fdiv"(%111, %106) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %113 = "llvm.fdiv"(%102, %101) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %114 = "llvm.fmul"(%113, %102) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %115 = "llvm.fadd"(%101, %114) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %116 = "llvm.fmul"(%100, %113) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %117 = "llvm.fadd"(%99, %116) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %118 = "llvm.fdiv"(%117, %115) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %119 = "llvm.fmul"(%99, %113) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %120 = "llvm.fsub"(%100, %119) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %121 = "llvm.fdiv"(%120, %115) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %122 = "llvm.mlir.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %123 = "llvm.intr.fabs"(%101) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %124 = "llvm.fcmp"(%123, %122) <{fastmathFlags = #llvm.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %125 = "llvm.intr.fabs"(%102) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %126 = "llvm.fcmp"(%125, %122) <{fastmathFlags = #llvm.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %127 = "llvm.fcmp"(%99, %122) <{fastmathFlags = #llvm.fastmath<none>, predicate = 7 : i64}> : (f32, f32) -> i1
    %128 = "llvm.fcmp"(%100, %122) <{fastmathFlags = #llvm.fastmath<none>, predicate = 7 : i64}> : (f32, f32) -> i1
    %129 = "llvm.or"(%127, %128) : (i1, i1) -> i1
    %130 = "llvm.and"(%124, %126) : (i1, i1) -> i1
    %131 = "llvm.and"(%129, %130) : (i1, i1) -> i1
    %132 = "llvm.mlir.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %133 = "llvm.intr.copysign"(%132, %101) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %134 = "llvm.fmul"(%133, %99) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %135 = "llvm.fmul"(%133, %100) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %136 = "llvm.fcmp"(%123, %132) <{fastmathFlags = #llvm.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %137 = "llvm.fcmp"(%125, %132) <{fastmathFlags = #llvm.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %138 = "llvm.and"(%136, %137) : (i1, i1) -> i1
    %139 = "llvm.intr.fabs"(%99) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %140 = "llvm.fcmp"(%139, %132) <{fastmathFlags = #llvm.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %141 = "llvm.intr.fabs"(%100) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %142 = "llvm.fcmp"(%141, %132) <{fastmathFlags = #llvm.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %143 = "llvm.or"(%140, %142) : (i1, i1) -> i1
    %144 = "llvm.and"(%143, %138) : (i1, i1) -> i1
    %145 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %146 = "llvm.select"(%140, %145, %122) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, f32, f32) -> f32
    %147 = "llvm.intr.copysign"(%146, %99) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %148 = "llvm.select"(%142, %145, %122) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, f32, f32) -> f32
    %149 = "llvm.intr.copysign"(%148, %100) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %150 = "llvm.fmul"(%147, %101) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %151 = "llvm.fmul"(%149, %102) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %152 = "llvm.fadd"(%150, %151) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %153 = "llvm.fmul"(%132, %152) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %154 = "llvm.fmul"(%147, %102) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %155 = "llvm.fmul"(%149, %101) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %156 = "llvm.fsub"(%155, %154) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %157 = "llvm.fmul"(%132, %156) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %158 = "llvm.fcmp"(%139, %132) <{fastmathFlags = #llvm.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %159 = "llvm.fcmp"(%141, %132) <{fastmathFlags = #llvm.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %160 = "llvm.and"(%158, %159) : (i1, i1) -> i1
    %161 = "llvm.fcmp"(%123, %132) <{fastmathFlags = #llvm.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %162 = "llvm.fcmp"(%125, %132) <{fastmathFlags = #llvm.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %163 = "llvm.or"(%161, %162) : (i1, i1) -> i1
    %164 = "llvm.and"(%160, %163) : (i1, i1) -> i1
    %165 = "llvm.select"(%161, %145, %122) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, f32, f32) -> f32
    %166 = "llvm.intr.copysign"(%165, %101) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %167 = "llvm.select"(%162, %145, %122) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, f32, f32) -> f32
    %168 = "llvm.intr.copysign"(%167, %102) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %169 = "llvm.fmul"(%99, %166) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %170 = "llvm.fmul"(%100, %168) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %171 = "llvm.fadd"(%169, %170) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %172 = "llvm.fmul"(%122, %171) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %173 = "llvm.fmul"(%100, %166) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %174 = "llvm.fmul"(%99, %168) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %175 = "llvm.fsub"(%173, %174) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %176 = "llvm.fmul"(%122, %175) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %177 = "llvm.fcmp"(%123, %125) <{fastmathFlags = #llvm.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
    %178 = "llvm.select"(%177, %109, %118) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, f32, f32) -> f32
    %179 = "llvm.select"(%177, %112, %121) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, f32, f32) -> f32
    %180 = "llvm.select"(%164, %172, %178) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, f32, f32) -> f32
    %181 = "llvm.select"(%164, %176, %179) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, f32, f32) -> f32
    %182 = "llvm.select"(%144, %153, %180) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, f32, f32) -> f32
    %183 = "llvm.select"(%144, %157, %181) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, f32, f32) -> f32
    %184 = "llvm.select"(%131, %134, %182) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, f32, f32) -> f32
    %185 = "llvm.select"(%131, %135, %183) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, f32, f32) -> f32
    %186 = "llvm.fcmp"(%178, %122) <{fastmathFlags = #llvm.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %187 = "llvm.fcmp"(%179, %122) <{fastmathFlags = #llvm.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %188 = "llvm.and"(%186, %187) : (i1, i1) -> i1
    %189 = "llvm.select"(%188, %184, %178) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, f32, f32) -> f32
    %190 = "llvm.select"(%188, %185, %179) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, f32, f32) -> f32
    %191 = "llvm.insertvalue"(%103, %189) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    %192 = "llvm.insertvalue"(%191, %190) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    %193 = "builtin.unrealized_conversion_cast"(%192) : (!llvm.struct<(f32, f32)>) -> complex<f32>
    "func.return"(%193) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_div_with_fmf"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (complex<f32>) -> !llvm.struct<(f32, f32)>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (complex<f32>) -> !llvm.struct<(f32, f32)>
    %2 = "llvm.extractvalue"(%1) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %3 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %4 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %5 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %6 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f32)>
    %7 = "llvm.fdiv"(%4, %5) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %8 = "llvm.fmul"(%7, %4) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %9 = "llvm.fadd"(%5, %8) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %10 = "llvm.fmul"(%2, %7) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %11 = "llvm.fadd"(%10, %3) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %12 = "llvm.fdiv"(%11, %9) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %13 = "llvm.fmul"(%3, %7) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %14 = "llvm.fsub"(%13, %2) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %15 = "llvm.fdiv"(%14, %9) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %16 = "llvm.fdiv"(%5, %4) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %17 = "llvm.fmul"(%16, %5) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %18 = "llvm.fadd"(%4, %17) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %19 = "llvm.fmul"(%3, %16) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %20 = "llvm.fadd"(%2, %19) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %21 = "llvm.fdiv"(%20, %18) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %22 = "llvm.fmul"(%2, %16) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %23 = "llvm.fsub"(%3, %22) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %24 = "llvm.fdiv"(%23, %18) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %25 = "llvm.mlir.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %26 = "llvm.intr.fabs"(%4) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32) -> f32
    %27 = "llvm.fcmp"(%26, %25) <{fastmathFlags = #llvm.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %28 = "llvm.intr.fabs"(%5) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32) -> f32
    %29 = "llvm.fcmp"(%28, %25) <{fastmathFlags = #llvm.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %30 = "llvm.fcmp"(%2, %25) <{fastmathFlags = #llvm.fastmath<none>, predicate = 7 : i64}> : (f32, f32) -> i1
    %31 = "llvm.fcmp"(%3, %25) <{fastmathFlags = #llvm.fastmath<none>, predicate = 7 : i64}> : (f32, f32) -> i1
    %32 = "llvm.or"(%30, %31) : (i1, i1) -> i1
    %33 = "llvm.and"(%27, %29) : (i1, i1) -> i1
    %34 = "llvm.and"(%32, %33) : (i1, i1) -> i1
    %35 = "llvm.mlir.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %36 = "llvm.intr.copysign"(%35, %4) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %37 = "llvm.fmul"(%36, %2) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %38 = "llvm.fmul"(%36, %3) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %39 = "llvm.fcmp"(%26, %35) <{fastmathFlags = #llvm.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %40 = "llvm.fcmp"(%28, %35) <{fastmathFlags = #llvm.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %41 = "llvm.and"(%39, %40) : (i1, i1) -> i1
    %42 = "llvm.intr.fabs"(%2) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32) -> f32
    %43 = "llvm.fcmp"(%42, %35) <{fastmathFlags = #llvm.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %44 = "llvm.intr.fabs"(%3) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32) -> f32
    %45 = "llvm.fcmp"(%44, %35) <{fastmathFlags = #llvm.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %46 = "llvm.or"(%43, %45) : (i1, i1) -> i1
    %47 = "llvm.and"(%46, %41) : (i1, i1) -> i1
    %48 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %49 = "llvm.select"(%43, %48, %25) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, f32, f32) -> f32
    %50 = "llvm.intr.copysign"(%49, %2) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %51 = "llvm.select"(%45, %48, %25) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, f32, f32) -> f32
    %52 = "llvm.intr.copysign"(%51, %3) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %53 = "llvm.fmul"(%50, %4) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %54 = "llvm.fmul"(%52, %5) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %55 = "llvm.fadd"(%53, %54) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %56 = "llvm.fmul"(%35, %55) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %57 = "llvm.fmul"(%50, %5) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %58 = "llvm.fmul"(%52, %4) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %59 = "llvm.fsub"(%58, %57) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %60 = "llvm.fmul"(%35, %59) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %61 = "llvm.fcmp"(%42, %35) <{fastmathFlags = #llvm.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %62 = "llvm.fcmp"(%44, %35) <{fastmathFlags = #llvm.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %63 = "llvm.and"(%61, %62) : (i1, i1) -> i1
    %64 = "llvm.fcmp"(%26, %35) <{fastmathFlags = #llvm.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %65 = "llvm.fcmp"(%28, %35) <{fastmathFlags = #llvm.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %66 = "llvm.or"(%64, %65) : (i1, i1) -> i1
    %67 = "llvm.and"(%63, %66) : (i1, i1) -> i1
    %68 = "llvm.select"(%64, %48, %25) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, f32, f32) -> f32
    %69 = "llvm.intr.copysign"(%68, %4) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %70 = "llvm.select"(%65, %48, %25) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, f32, f32) -> f32
    %71 = "llvm.intr.copysign"(%70, %5) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %72 = "llvm.fmul"(%2, %69) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %73 = "llvm.fmul"(%3, %71) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %74 = "llvm.fadd"(%72, %73) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %75 = "llvm.fmul"(%25, %74) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %76 = "llvm.fmul"(%3, %69) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %77 = "llvm.fmul"(%2, %71) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %78 = "llvm.fsub"(%76, %77) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %79 = "llvm.fmul"(%25, %78) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %80 = "llvm.fcmp"(%26, %28) <{fastmathFlags = #llvm.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
    %81 = "llvm.select"(%80, %12, %21) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, f32, f32) -> f32
    %82 = "llvm.select"(%80, %15, %24) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, f32, f32) -> f32
    %83 = "llvm.select"(%67, %75, %81) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, f32, f32) -> f32
    %84 = "llvm.select"(%67, %79, %82) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, f32, f32) -> f32
    %85 = "llvm.select"(%47, %56, %83) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, f32, f32) -> f32
    %86 = "llvm.select"(%47, %60, %84) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, f32, f32) -> f32
    %87 = "llvm.select"(%34, %37, %85) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, f32, f32) -> f32
    %88 = "llvm.select"(%34, %38, %86) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, f32, f32) -> f32
    %89 = "llvm.fcmp"(%81, %25) <{fastmathFlags = #llvm.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %90 = "llvm.fcmp"(%82, %25) <{fastmathFlags = #llvm.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %91 = "llvm.and"(%89, %90) : (i1, i1) -> i1
    %92 = "llvm.select"(%91, %87, %81) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, f32, f32) -> f32
    %93 = "llvm.select"(%91, %88, %82) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, f32, f32) -> f32
    %94 = "llvm.insertvalue"(%6, %92) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    %95 = "llvm.insertvalue"(%94, %93) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    %96 = "builtin.unrealized_conversion_cast"(%95) : (!llvm.struct<(f32, f32)>) -> complex<f32>
    "func.return"(%96) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

