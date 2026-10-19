"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> f32, sym_name = "complex_abs"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "math.absf"(%0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %4 = "math.absf"(%1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %5 = "arith.maximumf"(%3, %4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %6 = "arith.minimumf"(%3, %4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %7 = "arith.divf"(%6, %5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %8 = "arith.mulf"(%7, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %9 = "arith.addf"(%8, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %10 = "math.sqrt"(%9) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %11 = "arith.mulf"(%5, %10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %12 = "arith.cmpf"(%11, %11) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %13 = "arith.select"(%12, %6, %11) : (i1, f32, f32) -> f32
    "func.return"(%13) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_atan2"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "complex.re"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "complex.re"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %3 = "complex.im"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %4 = "arith.mulf"(%0, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %5 = "arith.mulf"(%1, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %6 = "arith.subf"(%4, %5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %7 = "arith.mulf"(%1, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %8 = "arith.mulf"(%0, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %9 = "arith.addf"(%7, %8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %10 = "complex.create"(%6, %9) : (f32, f32) -> complex<f32>
    %11 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %12 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %13 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %14 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %15 = "arith.mulf"(%11, %13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %16 = "arith.mulf"(%12, %14) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %17 = "arith.subf"(%15, %16) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %18 = "arith.mulf"(%12, %13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %19 = "arith.mulf"(%11, %14) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %20 = "arith.addf"(%18, %19) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %21 = "complex.create"(%17, %20) : (f32, f32) -> complex<f32>
    %22 = "complex.re"(%10) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %23 = "complex.re"(%21) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %24 = "arith.addf"(%22, %23) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %25 = "complex.im"(%10) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %26 = "complex.im"(%21) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %27 = "arith.addf"(%25, %26) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %28 = "complex.create"(%24, %27) : (f32, f32) -> complex<f32>
    %29 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %30 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
    %31 = "complex.re"(%28) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %32 = "complex.im"(%28) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %33 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %34 = "math.absf"(%31) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %35 = "math.absf"(%32) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %36 = "arith.maximumf"(%34, %35) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %37 = "arith.minimumf"(%34, %35) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %38 = "arith.divf"(%37, %36) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %39 = "arith.mulf"(%38, %38) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %40 = "arith.addf"(%39, %33) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %41 = "arith.constant"() <{value = 2.500000e-01 : f32}> : () -> f32
    %42 = "math.sqrt"(%36) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %43 = "math.powf"(%40, %41) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %44 = "arith.mulf"(%42, %43) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %45 = "arith.cmpf"(%44, %44) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %46 = "arith.select"(%45, %37, %44) : (i1, f32, f32) -> f32
    %47 = "math.atan2"(%32, %31) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %48 = "arith.mulf"(%47, %30) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %49 = "math.cos"(%48) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %50 = "math.sin"(%48) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %51 = "arith.cmpf"(%50, %29) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %52 = "arith.mulf"(%46, %49) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %53 = "arith.mulf"(%46, %50) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %54 = "arith.select"(%51, %29, %53) : (i1, f32, f32) -> f32
    %55 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %56 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %57 = "arith.constant"() <{value = 0x7FC00000 : f32}> : () -> f32
    %58 = "math.absf"(%32) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %59 = "arith.cmpf"(%58, %55) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %60 = "arith.cmpf"(%58, %55) <{fastmath = #arith.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %61 = "arith.cmpf"(%31, %55) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %62 = "arith.cmpf"(%31, %56) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %63 = "arith.andi"(%62, %60) : (i1, i1) -> i1
    %64 = "arith.select"(%63, %29, %52) : (i1, f32, f32) -> f32
    %65 = "arith.ori"(%59, %61) : (i1, i1) -> i1
    %66 = "arith.select"(%65, %55, %64) : (i1, f32, f32) -> f32
    %67 = "math.copysign"(%55, %32) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %68 = "arith.cmpf"(%46, %46) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %69 = "arith.select"(%68, %57, %54) : (i1, f32, f32) -> f32
    %70 = "arith.ori"(%59, %62) : (i1, i1) -> i1
    %71 = "arith.select"(%70, %67, %69) : (i1, f32, f32) -> f32
    %72 = "arith.cmpf"(%46, %29) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %73 = "arith.select"(%72, %29, %66) : (i1, f32, f32) -> f32
    %74 = "arith.select"(%72, %29, %71) : (i1, f32, f32) -> f32
    %75 = "complex.create"(%73, %74) : (f32, f32) -> complex<f32>
    %76 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %77 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %78 = "complex.create"(%76, %77) : (f32, f32) -> complex<f32>
    %79 = "complex.re"(%78) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %80 = "complex.im"(%78) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %81 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %82 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %83 = "arith.mulf"(%79, %81) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %84 = "arith.mulf"(%80, %82) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %85 = "arith.subf"(%83, %84) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %86 = "arith.mulf"(%80, %81) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %87 = "arith.mulf"(%79, %82) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %88 = "arith.addf"(%86, %87) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %89 = "complex.create"(%85, %88) : (f32, f32) -> complex<f32>
    %90 = "complex.re"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %91 = "complex.re"(%89) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %92 = "arith.addf"(%90, %91) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %93 = "complex.im"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %94 = "complex.im"(%89) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %95 = "arith.addf"(%93, %94) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %96 = "complex.create"(%92, %95) : (f32, f32) -> complex<f32>
    %97 = "complex.re"(%96) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %98 = "complex.im"(%96) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %99 = "complex.re"(%75) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %100 = "complex.im"(%75) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %101 = "arith.divf"(%99, %100) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %102 = "arith.mulf"(%101, %99) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %103 = "arith.addf"(%100, %102) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %104 = "arith.mulf"(%97, %101) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %105 = "arith.addf"(%104, %98) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %106 = "arith.divf"(%105, %103) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %107 = "arith.mulf"(%98, %101) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %108 = "arith.subf"(%107, %97) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %109 = "arith.divf"(%108, %103) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %110 = "arith.divf"(%100, %99) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %111 = "arith.mulf"(%110, %100) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %112 = "arith.addf"(%99, %111) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %113 = "arith.mulf"(%98, %110) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %114 = "arith.addf"(%97, %113) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %115 = "arith.divf"(%114, %112) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %116 = "arith.mulf"(%97, %110) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %117 = "arith.subf"(%98, %116) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %118 = "arith.divf"(%117, %112) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %119 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %120 = "math.absf"(%99) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %121 = "arith.cmpf"(%120, %119) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %122 = "math.absf"(%100) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %123 = "arith.cmpf"(%122, %119) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %124 = "arith.cmpf"(%97, %119) <{fastmath = #arith.fastmath<none>, predicate = 7 : i64}> : (f32, f32) -> i1
    %125 = "arith.cmpf"(%98, %119) <{fastmath = #arith.fastmath<none>, predicate = 7 : i64}> : (f32, f32) -> i1
    %126 = "arith.ori"(%124, %125) : (i1, i1) -> i1
    %127 = "arith.andi"(%121, %123) : (i1, i1) -> i1
    %128 = "arith.andi"(%126, %127) : (i1, i1) -> i1
    %129 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %130 = "math.copysign"(%129, %99) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %131 = "arith.mulf"(%130, %97) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %132 = "arith.mulf"(%130, %98) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %133 = "arith.cmpf"(%120, %129) <{fastmath = #arith.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %134 = "arith.cmpf"(%122, %129) <{fastmath = #arith.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %135 = "arith.andi"(%133, %134) : (i1, i1) -> i1
    %136 = "math.absf"(%97) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %137 = "arith.cmpf"(%136, %129) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %138 = "math.absf"(%98) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %139 = "arith.cmpf"(%138, %129) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %140 = "arith.ori"(%137, %139) : (i1, i1) -> i1
    %141 = "arith.andi"(%140, %135) : (i1, i1) -> i1
    %142 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %143 = "arith.select"(%137, %142, %119) : (i1, f32, f32) -> f32
    %144 = "math.copysign"(%143, %97) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %145 = "arith.select"(%139, %142, %119) : (i1, f32, f32) -> f32
    %146 = "math.copysign"(%145, %98) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %147 = "arith.mulf"(%144, %99) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %148 = "arith.mulf"(%146, %100) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %149 = "arith.addf"(%147, %148) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %150 = "arith.mulf"(%129, %149) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %151 = "arith.mulf"(%144, %100) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %152 = "arith.mulf"(%146, %99) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %153 = "arith.subf"(%152, %151) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %154 = "arith.mulf"(%129, %153) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %155 = "arith.cmpf"(%136, %129) <{fastmath = #arith.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %156 = "arith.cmpf"(%138, %129) <{fastmath = #arith.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %157 = "arith.andi"(%155, %156) : (i1, i1) -> i1
    %158 = "arith.cmpf"(%120, %129) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %159 = "arith.cmpf"(%122, %129) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %160 = "arith.ori"(%158, %159) : (i1, i1) -> i1
    %161 = "arith.andi"(%157, %160) : (i1, i1) -> i1
    %162 = "arith.select"(%158, %142, %119) : (i1, f32, f32) -> f32
    %163 = "math.copysign"(%162, %99) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %164 = "arith.select"(%159, %142, %119) : (i1, f32, f32) -> f32
    %165 = "math.copysign"(%164, %100) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %166 = "arith.mulf"(%97, %163) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %167 = "arith.mulf"(%98, %165) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %168 = "arith.addf"(%166, %167) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %169 = "arith.mulf"(%119, %168) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %170 = "arith.mulf"(%98, %163) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %171 = "arith.mulf"(%97, %165) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %172 = "arith.subf"(%170, %171) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %173 = "arith.mulf"(%119, %172) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %174 = "arith.cmpf"(%120, %122) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
    %175 = "arith.select"(%174, %106, %115) : (i1, f32, f32) -> f32
    %176 = "arith.select"(%174, %109, %118) : (i1, f32, f32) -> f32
    %177 = "arith.select"(%161, %169, %175) : (i1, f32, f32) -> f32
    %178 = "arith.select"(%161, %173, %176) : (i1, f32, f32) -> f32
    %179 = "arith.select"(%141, %150, %177) : (i1, f32, f32) -> f32
    %180 = "arith.select"(%141, %154, %178) : (i1, f32, f32) -> f32
    %181 = "arith.select"(%128, %131, %179) : (i1, f32, f32) -> f32
    %182 = "arith.select"(%128, %132, %180) : (i1, f32, f32) -> f32
    %183 = "arith.cmpf"(%175, %119) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %184 = "arith.cmpf"(%176, %119) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %185 = "arith.andi"(%183, %184) : (i1, i1) -> i1
    %186 = "arith.select"(%185, %181, %175) : (i1, f32, f32) -> f32
    %187 = "arith.select"(%185, %182, %176) : (i1, f32, f32) -> f32
    %188 = "complex.create"(%186, %187) : (f32, f32) -> complex<f32>
    %189 = "complex.re"(%188) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %190 = "complex.im"(%188) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %191 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %192 = "math.absf"(%189) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %193 = "math.absf"(%190) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %194 = "arith.maximumf"(%192, %193) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %195 = "arith.minimumf"(%192, %193) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %196 = "arith.divf"(%195, %194) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %197 = "arith.mulf"(%196, %196) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %198 = "arith.addf"(%197, %191) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %199 = "math.sqrt"(%198) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %200 = "arith.mulf"(%194, %199) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %201 = "arith.cmpf"(%200, %200) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %202 = "arith.select"(%201, %195, %200) : (i1, f32, f32) -> f32
    %203 = "math.log"(%202) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %204 = "complex.re"(%188) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %205 = "complex.im"(%188) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %206 = "math.atan2"(%205, %204) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %207 = "complex.create"(%203, %206) : (f32, f32) -> complex<f32>
    %208 = "arith.constant"() <{value = -1.000000e+00 : f32}> : () -> f32
    %209 = "complex.create"(%76, %208) : (f32, f32) -> complex<f32>
    %210 = "complex.re"(%209) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %211 = "complex.im"(%209) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %212 = "complex.re"(%207) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %213 = "complex.im"(%207) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %214 = "arith.mulf"(%210, %212) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %215 = "arith.mulf"(%211, %213) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %216 = "arith.subf"(%214, %215) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %217 = "arith.mulf"(%211, %212) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %218 = "arith.mulf"(%210, %213) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %219 = "arith.addf"(%217, %218) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %220 = "complex.create"(%216, %219) : (f32, f32) -> complex<f32>
    "func.return"(%220) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_add"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.re"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "arith.addf"(%0, %1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %3 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %4 = "complex.im"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %5 = "arith.addf"(%3, %4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %6 = "complex.create"(%2, %5) : (f32, f32) -> complex<f32>
    "func.return"(%6) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "complex_cos"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
    %3 = "math.exp"(%1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %4 = "arith.mulf"(%2, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %5 = "arith.divf"(%2, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %6 = "math.sin"(%0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %7 = "math.cos"(%0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %8 = "arith.addf"(%5, %4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %9 = "arith.mulf"(%8, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %10 = "arith.subf"(%5, %4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %11 = "arith.mulf"(%10, %6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %12 = "complex.create"(%9, %11) : (f32, f32) -> complex<f32>
    "func.return"(%12) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_div"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "complex.re"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %3 = "complex.im"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %4 = "arith.divf"(%2, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %5 = "arith.mulf"(%4, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %6 = "arith.addf"(%3, %5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %7 = "arith.mulf"(%0, %4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %8 = "arith.addf"(%7, %1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %9 = "arith.divf"(%8, %6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %10 = "arith.mulf"(%1, %4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %11 = "arith.subf"(%10, %0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %12 = "arith.divf"(%11, %6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %13 = "arith.divf"(%3, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %14 = "arith.mulf"(%13, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %15 = "arith.addf"(%2, %14) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %16 = "arith.mulf"(%1, %13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %17 = "arith.addf"(%0, %16) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %18 = "arith.divf"(%17, %15) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %19 = "arith.mulf"(%0, %13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %20 = "arith.subf"(%1, %19) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %21 = "arith.divf"(%20, %15) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %22 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %23 = "math.absf"(%2) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %24 = "arith.cmpf"(%23, %22) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %25 = "math.absf"(%3) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %26 = "arith.cmpf"(%25, %22) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %27 = "arith.cmpf"(%0, %22) <{fastmath = #arith.fastmath<none>, predicate = 7 : i64}> : (f32, f32) -> i1
    %28 = "arith.cmpf"(%1, %22) <{fastmath = #arith.fastmath<none>, predicate = 7 : i64}> : (f32, f32) -> i1
    %29 = "arith.ori"(%27, %28) : (i1, i1) -> i1
    %30 = "arith.andi"(%24, %26) : (i1, i1) -> i1
    %31 = "arith.andi"(%29, %30) : (i1, i1) -> i1
    %32 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %33 = "math.copysign"(%32, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %34 = "arith.mulf"(%33, %0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %35 = "arith.mulf"(%33, %1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %36 = "arith.cmpf"(%23, %32) <{fastmath = #arith.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %37 = "arith.cmpf"(%25, %32) <{fastmath = #arith.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %38 = "arith.andi"(%36, %37) : (i1, i1) -> i1
    %39 = "math.absf"(%0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %40 = "arith.cmpf"(%39, %32) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %41 = "math.absf"(%1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %42 = "arith.cmpf"(%41, %32) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %43 = "arith.ori"(%40, %42) : (i1, i1) -> i1
    %44 = "arith.andi"(%43, %38) : (i1, i1) -> i1
    %45 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %46 = "arith.select"(%40, %45, %22) : (i1, f32, f32) -> f32
    %47 = "math.copysign"(%46, %0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %48 = "arith.select"(%42, %45, %22) : (i1, f32, f32) -> f32
    %49 = "math.copysign"(%48, %1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %50 = "arith.mulf"(%47, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %51 = "arith.mulf"(%49, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %52 = "arith.addf"(%50, %51) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %53 = "arith.mulf"(%32, %52) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %54 = "arith.mulf"(%47, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %55 = "arith.mulf"(%49, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %56 = "arith.subf"(%55, %54) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %57 = "arith.mulf"(%32, %56) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %58 = "arith.cmpf"(%39, %32) <{fastmath = #arith.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %59 = "arith.cmpf"(%41, %32) <{fastmath = #arith.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %60 = "arith.andi"(%58, %59) : (i1, i1) -> i1
    %61 = "arith.cmpf"(%23, %32) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %62 = "arith.cmpf"(%25, %32) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %63 = "arith.ori"(%61, %62) : (i1, i1) -> i1
    %64 = "arith.andi"(%60, %63) : (i1, i1) -> i1
    %65 = "arith.select"(%61, %45, %22) : (i1, f32, f32) -> f32
    %66 = "math.copysign"(%65, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %67 = "arith.select"(%62, %45, %22) : (i1, f32, f32) -> f32
    %68 = "math.copysign"(%67, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %69 = "arith.mulf"(%0, %66) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %70 = "arith.mulf"(%1, %68) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %71 = "arith.addf"(%69, %70) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %72 = "arith.mulf"(%22, %71) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %73 = "arith.mulf"(%1, %66) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %74 = "arith.mulf"(%0, %68) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %75 = "arith.subf"(%73, %74) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %76 = "arith.mulf"(%22, %75) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %77 = "arith.cmpf"(%23, %25) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
    %78 = "arith.select"(%77, %9, %18) : (i1, f32, f32) -> f32
    %79 = "arith.select"(%77, %12, %21) : (i1, f32, f32) -> f32
    %80 = "arith.select"(%64, %72, %78) : (i1, f32, f32) -> f32
    %81 = "arith.select"(%64, %76, %79) : (i1, f32, f32) -> f32
    %82 = "arith.select"(%44, %53, %80) : (i1, f32, f32) -> f32
    %83 = "arith.select"(%44, %57, %81) : (i1, f32, f32) -> f32
    %84 = "arith.select"(%31, %34, %82) : (i1, f32, f32) -> f32
    %85 = "arith.select"(%31, %35, %83) : (i1, f32, f32) -> f32
    %86 = "arith.cmpf"(%78, %22) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %87 = "arith.cmpf"(%79, %22) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %88 = "arith.andi"(%86, %87) : (i1, i1) -> i1
    %89 = "arith.select"(%88, %84, %78) : (i1, f32, f32) -> f32
    %90 = "arith.select"(%88, %85, %79) : (i1, f32, f32) -> f32
    %91 = "complex.create"(%89, %90) : (f32, f32) -> complex<f32>
    "func.return"(%91) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> i1, sym_name = "complex_eq"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "complex.re"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %3 = "complex.im"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %4 = "arith.cmpf"(%0, %2) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %5 = "arith.cmpf"(%1, %3) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %6 = "arith.andi"(%4, %5) : (i1, i1) -> i1
    "func.return"(%6) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "complex_exp"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
    %4 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %5 = "math.exp"(%0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %6 = "arith.mulf"(%0, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %7 = "math.exp"(%6) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %8 = "math.cos"(%1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %9 = "math.sin"(%1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %10 = "arith.cmpf"(%5, %4) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %11 = "arith.cmpf"(%1, %2) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %12 = "arith.mulf"(%5, %8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %13 = "arith.mulf"(%7, %8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %14 = "arith.mulf"(%13, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %15 = "arith.select"(%10, %14, %12) : (i1, f32, f32) -> f32
    %16 = "arith.mulf"(%5, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %17 = "arith.mulf"(%7, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %18 = "arith.mulf"(%17, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %19 = "arith.select"(%10, %18, %16) : (i1, f32, f32) -> f32
    %20 = "arith.select"(%11, %2, %19) : (i1, f32, f32) -> f32
    %21 = "complex.create"(%15, %20) : (f32, f32) -> complex<f32>
    "func.return"(%21) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "complex_expm1"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %4 = "math.expm1"(%0) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %5 = "arith.addf"(%4, %3) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %6 = "math.sin"(%1) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %7 = "arith.constant"() <{value = -5.000000e-01 : f32}> : () -> f32
    %8 = "arith.constant"() <{value = -1.000000e+00 : f32}> : () -> f32
    %9 = "math.cos"(%1) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %10 = "arith.addf"(%9, %8) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %11 = "arith.mulf"(%1, %1) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %12 = "arith.mulf"(%11, %11) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %13 = "arith.constant"() <{value = 4.73775072E-14 : f32}> : () -> f32
    %14 = "arith.constant"() <{value = -1.14702848E-11 : f32}> : () -> f32
    %15 = "math.fma"(%13, %11, %14) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32, f32) -> f32
    %16 = "arith.constant"() <{value = 2.08767537E-9 : f32}> : () -> f32
    %17 = "math.fma"(%15, %11, %16) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32, f32) -> f32
    %18 = "arith.constant"() <{value = -2.755732E-7 : f32}> : () -> f32
    %19 = "math.fma"(%17, %11, %18) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32, f32) -> f32
    %20 = "arith.constant"() <{value = 2.48015876E-5 : f32}> : () -> f32
    %21 = "math.fma"(%19, %11, %20) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32, f32) -> f32
    %22 = "arith.constant"() <{value = -0.00138888892 : f32}> : () -> f32
    %23 = "math.fma"(%21, %11, %22) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32, f32) -> f32
    %24 = "arith.constant"() <{value = 0.0416666679 : f32}> : () -> f32
    %25 = "math.fma"(%23, %11, %24) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32, f32) -> f32
    %26 = "arith.mulf"(%12, %25) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %27 = "arith.mulf"(%7, %11) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %28 = "arith.addf"(%26, %27) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %29 = "arith.constant"() <{value = 6.168500e-01 : f32}> : () -> f32
    %30 = "arith.cmpf"(%11, %29) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 3 : i64}> : (f32, f32) -> i1
    %31 = "arith.select"(%30, %10, %28) : (i1, f32, f32) -> f32
    %32 = "arith.addf"(%31, %3) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %33 = "arith.mulf"(%4, %32) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %34 = "arith.addf"(%33, %31) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %35 = "arith.cmpf"(%1, %2) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 1 : i64}> : (f32, f32) -> i1
    %36 = "arith.mulf"(%5, %6) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %37 = "arith.select"(%35, %2, %36) : (i1, f32, f32) -> f32
    %38 = "complex.create"(%34, %37) : (f32, f32) -> complex<f32>
    "func.return"(%38) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "complex_log"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "math.absf"(%0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %4 = "math.absf"(%1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %5 = "arith.maximumf"(%3, %4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %6 = "arith.minimumf"(%3, %4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %7 = "arith.divf"(%6, %5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %8 = "arith.mulf"(%7, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %9 = "arith.addf"(%8, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %10 = "math.sqrt"(%9) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %11 = "arith.mulf"(%5, %10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %12 = "arith.cmpf"(%11, %11) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %13 = "arith.select"(%12, %6, %11) : (i1, f32, f32) -> f32
    %14 = "math.log"(%13) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %15 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %16 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %17 = "math.atan2"(%16, %15) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %18 = "complex.create"(%14, %17) : (f32, f32) -> complex<f32>
    "func.return"(%18) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "complex_log1p"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %4 = "arith.addf"(%0, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %5 = "math.absf"(%4) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %6 = "math.absf"(%1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %7 = "arith.maximumf"(%5, %6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %8 = "arith.minimumf"(%5, %6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %9 = "arith.cmpf"(%4, %6) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
    %10 = "arith.subf"(%7, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %11 = "arith.select"(%9, %0, %10) : (i1, f32, f32) -> f32
    %12 = "arith.divf"(%8, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %13 = "math.log1p"(%11) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %14 = "arith.mulf"(%12, %12) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %15 = "math.log1p"(%14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %16 = "arith.mulf"(%2, %15) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %17 = "arith.addf"(%16, %13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %18 = "arith.cmpf"(%17, %17) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %19 = "arith.select"(%18, %8, %17) : (i1, f32, f32) -> f32
    %20 = "math.atan2"(%1, %4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %21 = "complex.create"(%19, %20) : (f32, f32) -> complex<f32>
    "func.return"(%21) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_mul"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "complex.re"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %3 = "complex.im"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %4 = "arith.mulf"(%0, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %5 = "arith.mulf"(%1, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %6 = "arith.subf"(%4, %5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %7 = "arith.mulf"(%1, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %8 = "arith.mulf"(%0, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %9 = "arith.addf"(%7, %8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %10 = "complex.create"(%6, %9) : (f32, f32) -> complex<f32>
    "func.return"(%10) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "complex_neg"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "arith.negf"(%0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %3 = "arith.negf"(%1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %4 = "complex.create"(%2, %3) : (f32, f32) -> complex<f32>
    "func.return"(%4) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> i1, sym_name = "complex_neq"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "complex.re"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %3 = "complex.im"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %4 = "arith.cmpf"(%0, %2) <{fastmath = #arith.fastmath<none>, predicate = 13 : i64}> : (f32, f32) -> i1
    %5 = "arith.cmpf"(%1, %3) <{fastmath = #arith.fastmath<none>, predicate = 13 : i64}> : (f32, f32) -> i1
    %6 = "arith.ori"(%4, %5) : (i1, i1) -> i1
    "func.return"(%6) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "complex_sin"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
    %3 = "math.exp"(%1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %4 = "arith.mulf"(%2, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %5 = "arith.divf"(%2, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %6 = "math.sin"(%0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %7 = "math.cos"(%0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %8 = "arith.addf"(%4, %5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %9 = "arith.mulf"(%8, %6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %10 = "arith.subf"(%4, %5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %11 = "arith.mulf"(%10, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %12 = "complex.create"(%9, %11) : (f32, f32) -> complex<f32>
    "func.return"(%12) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "complex_sign"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "arith.cmpf"(%0, %2) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %4 = "arith.cmpf"(%1, %2) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %5 = "arith.andi"(%3, %4) : (i1, i1) -> i1
    %6 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %7 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %8 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %9 = "math.absf"(%6) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %10 = "math.absf"(%7) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %11 = "arith.maximumf"(%9, %10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %12 = "arith.minimumf"(%9, %10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %13 = "arith.divf"(%12, %11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %14 = "arith.mulf"(%13, %13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %15 = "arith.addf"(%14, %8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %16 = "math.sqrt"(%15) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %17 = "arith.mulf"(%11, %16) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %18 = "arith.cmpf"(%17, %17) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %19 = "arith.select"(%18, %12, %17) : (i1, f32, f32) -> f32
    %20 = "arith.divf"(%0, %19) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %21 = "arith.divf"(%1, %19) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %22 = "complex.create"(%20, %21) : (f32, f32) -> complex<f32>
    %23 = "arith.select"(%5, %arg0, %22) : (i1, complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%23) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_sub"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.re"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "arith.subf"(%0, %1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %3 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %4 = "complex.im"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %5 = "arith.subf"(%3, %4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %6 = "complex.create"(%2, %5) : (f32, f32) -> complex<f32>
    "func.return"(%6) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "complex_tan"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "arith.constant"() <{value = -1.000000e+00 : f32}> : () -> f32
    %3 = "arith.mulf"(%1, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %4 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %5 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    %6 = "arith.addf"(%3, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %7 = "arith.mulf"(%2, %6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %8 = "math.expm1"(%6) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %9 = "math.expm1"(%7) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %10 = "arith.subf"(%8, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %11 = "math.cos"(%0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %12 = "arith.mulf"(%11, %11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %13 = "arith.mulf"(%12, %5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %14 = "math.sin"(%0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %15 = "arith.mulf"(%11, %14) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %16 = "arith.mulf"(%5, %15) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %17 = "arith.addf"(%8, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %18 = "arith.addf"(%17, %13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %19 = "arith.cmpf"(%17, %4) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %20 = "math.copysign"(%2, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %21 = "arith.divf"(%10, %18) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %22 = "arith.select"(%19, %20, %21) : (i1, f32, f32) -> f32
    %23 = "arith.divf"(%16, %18) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %24 = "math.absf"(%3) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %25 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %26 = "arith.constant"() <{value = 0x7FC00000 : f32}> : () -> f32
    %27 = "arith.cmpf"(%24, %4) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %28 = "arith.cmpf"(%0, %25) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %29 = "arith.constant"() <{value = true}> : () -> i1
    %30 = "arith.xori"(%27, %29) : (i1, i1) -> i1
    %31 = "arith.cmpf"(%16, %16) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %32 = "arith.andi"(%31, %30) : (i1, i1) -> i1
    %33 = "arith.andi"(%27, %31) : (i1, i1) -> i1
    %34 = "arith.ori"(%28, %33) : (i1, i1) -> i1
    %35 = "arith.select"(%32, %26, %22) : (i1, f32, f32) -> f32
    %36 = "arith.select"(%34, %25, %23) : (i1, f32, f32) -> f32
    %37 = "arith.mulf"(%35, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %38 = "complex.create"(%36, %37) : (f32, f32) -> complex<f32>
    "func.return"(%38) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "complex_tanh"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "arith.constant"() <{value = -1.000000e+00 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %4 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    %5 = "arith.addf"(%0, %0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %6 = "arith.mulf"(%2, %5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %7 = "math.expm1"(%5) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %8 = "math.expm1"(%6) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %9 = "arith.subf"(%7, %8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %10 = "math.cos"(%1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %11 = "arith.mulf"(%10, %10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %12 = "arith.mulf"(%11, %4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %13 = "math.sin"(%1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %14 = "arith.mulf"(%10, %13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %15 = "arith.mulf"(%4, %14) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %16 = "arith.addf"(%7, %8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %17 = "arith.addf"(%16, %12) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %18 = "arith.cmpf"(%16, %3) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %19 = "math.copysign"(%2, %0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %20 = "arith.divf"(%9, %17) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %21 = "arith.select"(%18, %19, %20) : (i1, f32, f32) -> f32
    %22 = "arith.divf"(%15, %17) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %23 = "math.absf"(%0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %24 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %25 = "arith.constant"() <{value = 0x7FC00000 : f32}> : () -> f32
    %26 = "arith.cmpf"(%23, %3) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %27 = "arith.cmpf"(%1, %24) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %28 = "arith.constant"() <{value = true}> : () -> i1
    %29 = "arith.xori"(%26, %28) : (i1, i1) -> i1
    %30 = "arith.cmpf"(%15, %15) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %31 = "arith.andi"(%30, %29) : (i1, i1) -> i1
    %32 = "arith.andi"(%26, %30) : (i1, i1) -> i1
    %33 = "arith.ori"(%27, %32) : (i1, i1) -> i1
    %34 = "arith.select"(%31, %25, %21) : (i1, f32, f32) -> f32
    %35 = "arith.select"(%33, %24, %22) : (i1, f32, f32) -> f32
    %36 = "complex.create"(%34, %35) : (f32, f32) -> complex<f32>
    "func.return"(%36) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "complex_sqrt"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
    %2 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %3 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %4 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %5 = "math.absf"(%2) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %6 = "math.absf"(%3) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %7 = "arith.maximumf"(%5, %6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %8 = "arith.minimumf"(%5, %6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %9 = "arith.divf"(%8, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %10 = "arith.mulf"(%9, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %11 = "arith.addf"(%10, %4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %12 = "arith.constant"() <{value = 2.500000e-01 : f32}> : () -> f32
    %13 = "math.sqrt"(%7) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %14 = "math.powf"(%11, %12) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %15 = "arith.mulf"(%13, %14) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %16 = "arith.cmpf"(%15, %15) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %17 = "arith.select"(%16, %8, %15) : (i1, f32, f32) -> f32
    %18 = "math.atan2"(%3, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %19 = "arith.mulf"(%18, %1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %20 = "math.cos"(%19) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %21 = "math.sin"(%19) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %22 = "arith.cmpf"(%21, %0) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %23 = "arith.mulf"(%17, %20) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %24 = "arith.mulf"(%17, %21) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %25 = "arith.select"(%22, %0, %24) : (i1, f32, f32) -> f32
    %26 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %27 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %28 = "arith.constant"() <{value = 0x7FC00000 : f32}> : () -> f32
    %29 = "math.absf"(%3) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %30 = "arith.cmpf"(%29, %26) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %31 = "arith.cmpf"(%29, %26) <{fastmath = #arith.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %32 = "arith.cmpf"(%2, %26) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %33 = "arith.cmpf"(%2, %27) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %34 = "arith.andi"(%33, %31) : (i1, i1) -> i1
    %35 = "arith.select"(%34, %0, %23) : (i1, f32, f32) -> f32
    %36 = "arith.ori"(%30, %32) : (i1, i1) -> i1
    %37 = "arith.select"(%36, %26, %35) : (i1, f32, f32) -> f32
    %38 = "math.copysign"(%26, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %39 = "arith.cmpf"(%17, %17) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %40 = "arith.select"(%39, %28, %25) : (i1, f32, f32) -> f32
    %41 = "arith.ori"(%30, %33) : (i1, i1) -> i1
    %42 = "arith.select"(%41, %38, %40) : (i1, f32, f32) -> f32
    %43 = "arith.cmpf"(%17, %0) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %44 = "arith.select"(%43, %0, %37) : (i1, f32, f32) -> f32
    %45 = "arith.select"(%43, %0, %42) : (i1, f32, f32) -> f32
    %46 = "complex.create"(%44, %45) : (f32, f32) -> complex<f32>
    "func.return"(%46) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "complex_sqrt_nnan_ninf"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
    %2 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %3 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %4 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %5 = "math.absf"(%2) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32) -> f32
    %6 = "math.absf"(%3) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32) -> f32
    %7 = "arith.maximumf"(%5, %6) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32, f32) -> f32
    %8 = "arith.minimumf"(%5, %6) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32, f32) -> f32
    %9 = "arith.divf"(%8, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %10 = "arith.mulf"(%9, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %11 = "arith.addf"(%10, %4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %12 = "arith.constant"() <{value = 2.500000e-01 : f32}> : () -> f32
    %13 = "math.sqrt"(%7) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %14 = "math.powf"(%11, %12) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %15 = "arith.mulf"(%13, %14) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %16 = "arith.cmpf"(%15, %15) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %17 = "arith.select"(%16, %8, %15) : (i1, f32, f32) -> f32
    %18 = "math.atan2"(%3, %2) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32, f32) -> f32
    %19 = "arith.mulf"(%18, %1) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32, f32) -> f32
    %20 = "math.cos"(%19) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32) -> f32
    %21 = "math.sin"(%19) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32) -> f32
    %22 = "arith.cmpf"(%21, %0) <{fastmath = #arith.fastmath<nnan,ninf>, predicate = 1 : i64}> : (f32, f32) -> i1
    %23 = "arith.mulf"(%17, %20) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32, f32) -> f32
    %24 = "arith.mulf"(%17, %21) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32, f32) -> f32
    %25 = "arith.select"(%22, %0, %24) : (i1, f32, f32) -> f32
    %26 = "arith.cmpf"(%17, %0) <{fastmath = #arith.fastmath<nnan,ninf>, predicate = 1 : i64}> : (f32, f32) -> i1
    %27 = "arith.select"(%26, %0, %23) : (i1, f32, f32) -> f32
    %28 = "arith.select"(%26, %0, %25) : (i1, f32, f32) -> f32
    %29 = "complex.create"(%27, %28) : (f32, f32) -> complex<f32>
    "func.return"(%29) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "complex_conj"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "arith.negf"(%1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %3 = "complex.create"(%0, %2) : (f32, f32) -> complex<f32>
    "func.return"(%3) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_pow"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "complex.re"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %3 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %4 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %5 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %6 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %7 = "math.absf"(%4) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %8 = "math.absf"(%5) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %9 = "arith.maximumf"(%7, %8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %10 = "arith.minimumf"(%7, %8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %11 = "arith.divf"(%10, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %12 = "arith.mulf"(%11, %11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %13 = "arith.addf"(%12, %6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %14 = "math.sqrt"(%13) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %15 = "arith.mulf"(%9, %14) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %16 = "arith.cmpf"(%15, %15) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %17 = "arith.select"(%16, %10, %15) : (i1, f32, f32) -> f32
    %18 = "math.powf"(%17, %0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %19 = "arith.negf"(%1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %20 = "math.atan2"(%3, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %21 = "arith.mulf"(%19, %20) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %22 = "math.exp"(%21) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %23 = "arith.mulf"(%18, %22) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %24 = "math.log"(%17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %25 = "arith.mulf"(%0, %20) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %26 = "arith.mulf"(%1, %24) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %27 = "arith.addf"(%25, %26) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %28 = "math.cos"(%27) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %29 = "math.sin"(%27) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %30 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %31 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %32 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %33 = "complex.create"(%32, %31) : (f32, f32) -> complex<f32>
    %34 = "complex.create"(%31, %31) : (f32, f32) -> complex<f32>
    %35 = "complex.create"(%30, %31) : (f32, f32) -> complex<f32>
    %36 = "arith.cmpf"(%17, %31) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %37 = "arith.cmpf"(%1, %31) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %38 = "arith.cmpf"(%0, %31) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %39 = "arith.cmpf"(%3, %31) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %40 = "arith.cmpf"(%31, %0) <{fastmath = #arith.fastmath<none>, predicate = 5 : i64}> : (f32, f32) -> i1
    %41 = "arith.mulf"(%23, %28) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %42 = "arith.mulf"(%23, %29) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %43 = "arith.select"(%38, %33, %34) : (i1, complex<f32>, complex<f32>) -> complex<f32>
    %44 = "complex.create"(%41, %42) : (f32, f32) -> complex<f32>
    %45 = "arith.andi"(%36, %37) : (i1, i1) -> i1
    %46 = "arith.andi"(%45, %40) : (i1, i1) -> i1
    %47 = "arith.select"(%46, %43, %44) : (i1, complex<f32>, complex<f32>) -> complex<f32>
    %48 = "arith.andi"(%38, %37) : (i1, i1) -> i1
    %49 = "arith.select"(%48, %33, %47) : (i1, complex<f32>, complex<f32>) -> complex<f32>
    %50 = "arith.cmpf"(%2, %32) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %51 = "arith.andi"(%50, %39) : (i1, i1) -> i1
    %52 = "arith.select"(%51, %33, %49) : (i1, complex<f32>, complex<f32>) -> complex<f32>
    %53 = "arith.cmpf"(%2, %30) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %54 = "arith.andi"(%53, %39) : (i1, i1) -> i1
    %55 = "arith.cmpf"(%0, %31) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
    %56 = "arith.andi"(%37, %55) : (i1, i1) -> i1
    %57 = "arith.andi"(%54, %56) : (i1, i1) -> i1
    %58 = "arith.select"(%57, %35, %52) : (i1, complex<f32>, complex<f32>) -> complex<f32>
    %59 = "arith.cmpf"(%0, %31) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
    %60 = "arith.andi"(%37, %59) : (i1, i1) -> i1
    %61 = "arith.andi"(%54, %60) : (i1, i1) -> i1
    %62 = "arith.select"(%61, %34, %58) : (i1, complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%62) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_pow_with_fmf"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "complex.re"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %3 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %4 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %5 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %6 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %7 = "math.absf"(%4) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %8 = "math.absf"(%5) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %9 = "arith.maximumf"(%7, %8) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %10 = "arith.minimumf"(%7, %8) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %11 = "arith.divf"(%10, %9) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %12 = "arith.mulf"(%11, %11) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %13 = "arith.addf"(%12, %6) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %14 = "math.sqrt"(%13) <{fastmath = #arith.fastmath<contract>}> : (f32) -> f32
    %15 = "arith.mulf"(%9, %14) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %16 = "arith.cmpf"(%15, %15) <{fastmath = #arith.fastmath<contract>, predicate = 14 : i64}> : (f32, f32) -> i1
    %17 = "arith.select"(%16, %10, %15) : (i1, f32, f32) -> f32
    %18 = "math.powf"(%17, %0) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %19 = "arith.negf"(%1) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %20 = "math.atan2"(%3, %2) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %21 = "arith.mulf"(%19, %20) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %22 = "math.exp"(%21) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %23 = "arith.mulf"(%18, %22) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %24 = "math.log"(%17) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %25 = "arith.mulf"(%0, %20) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %26 = "arith.mulf"(%1, %24) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %27 = "arith.addf"(%25, %26) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %28 = "math.cos"(%27) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %29 = "math.sin"(%27) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %30 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %31 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %32 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %33 = "complex.create"(%32, %31) : (f32, f32) -> complex<f32>
    %34 = "complex.create"(%31, %31) : (f32, f32) -> complex<f32>
    %35 = "complex.create"(%30, %31) : (f32, f32) -> complex<f32>
    %36 = "arith.cmpf"(%17, %31) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 1 : i64}> : (f32, f32) -> i1
    %37 = "arith.cmpf"(%1, %31) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 1 : i64}> : (f32, f32) -> i1
    %38 = "arith.cmpf"(%0, %31) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 1 : i64}> : (f32, f32) -> i1
    %39 = "arith.cmpf"(%3, %31) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 1 : i64}> : (f32, f32) -> i1
    %40 = "arith.cmpf"(%31, %0) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 5 : i64}> : (f32, f32) -> i1
    %41 = "arith.mulf"(%23, %28) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %42 = "arith.mulf"(%23, %29) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %43 = "arith.select"(%38, %33, %34) : (i1, complex<f32>, complex<f32>) -> complex<f32>
    %44 = "complex.create"(%41, %42) : (f32, f32) -> complex<f32>
    %45 = "arith.andi"(%36, %37) : (i1, i1) -> i1
    %46 = "arith.andi"(%45, %40) : (i1, i1) -> i1
    %47 = "arith.select"(%46, %43, %44) : (i1, complex<f32>, complex<f32>) -> complex<f32>
    %48 = "arith.andi"(%38, %37) : (i1, i1) -> i1
    %49 = "arith.select"(%48, %33, %47) : (i1, complex<f32>, complex<f32>) -> complex<f32>
    %50 = "arith.cmpf"(%2, %32) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 1 : i64}> : (f32, f32) -> i1
    %51 = "arith.andi"(%50, %39) : (i1, i1) -> i1
    %52 = "arith.select"(%51, %33, %49) : (i1, complex<f32>, complex<f32>) -> complex<f32>
    %53 = "arith.cmpf"(%2, %30) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 1 : i64}> : (f32, f32) -> i1
    %54 = "arith.andi"(%53, %39) : (i1, i1) -> i1
    %55 = "arith.cmpf"(%0, %31) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 2 : i64}> : (f32, f32) -> i1
    %56 = "arith.andi"(%37, %55) : (i1, i1) -> i1
    %57 = "arith.andi"(%54, %56) : (i1, i1) -> i1
    %58 = "arith.select"(%57, %35, %52) : (i1, complex<f32>, complex<f32>) -> complex<f32>
    %59 = "arith.cmpf"(%0, %31) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 4 : i64}> : (f32, f32) -> i1
    %60 = "arith.andi"(%37, %59) : (i1, i1) -> i1
    %61 = "arith.andi"(%54, %60) : (i1, i1) -> i1
    %62 = "arith.select"(%61, %34, %58) : (i1, complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%62) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, i32) -> complex<f32>, sym_name = "complex_powi"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: i32):
    %0 = "arith.sitofp"(%arg1) : (i32) -> f32
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "complex.create"(%0, %1) : (f32, f32) -> complex<f32>
    %3 = "complex.re"(%2) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %4 = "complex.im"(%2) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %5 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %6 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %7 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %8 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %9 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %10 = "math.absf"(%7) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %11 = "math.absf"(%8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %12 = "arith.maximumf"(%10, %11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %13 = "arith.minimumf"(%10, %11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %14 = "arith.divf"(%13, %12) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %15 = "arith.mulf"(%14, %14) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %16 = "arith.addf"(%15, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %17 = "math.sqrt"(%16) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %18 = "arith.mulf"(%12, %17) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %19 = "arith.cmpf"(%18, %18) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %20 = "arith.select"(%19, %13, %18) : (i1, f32, f32) -> f32
    %21 = "math.powf"(%20, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %22 = "arith.negf"(%4) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %23 = "math.atan2"(%6, %5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %24 = "arith.mulf"(%22, %23) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %25 = "math.exp"(%24) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %26 = "arith.mulf"(%21, %25) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %27 = "math.log"(%20) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %28 = "arith.mulf"(%3, %23) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %29 = "arith.mulf"(%4, %27) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %30 = "arith.addf"(%28, %29) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %31 = "math.cos"(%30) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %32 = "math.sin"(%30) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %33 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %34 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %35 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %36 = "complex.create"(%35, %34) : (f32, f32) -> complex<f32>
    %37 = "complex.create"(%34, %34) : (f32, f32) -> complex<f32>
    %38 = "complex.create"(%33, %34) : (f32, f32) -> complex<f32>
    %39 = "arith.cmpf"(%20, %34) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %40 = "arith.cmpf"(%4, %34) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %41 = "arith.cmpf"(%3, %34) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %42 = "arith.cmpf"(%6, %34) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %43 = "arith.cmpf"(%34, %3) <{fastmath = #arith.fastmath<none>, predicate = 5 : i64}> : (f32, f32) -> i1
    %44 = "arith.mulf"(%26, %31) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %45 = "arith.mulf"(%26, %32) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %46 = "arith.select"(%41, %36, %37) : (i1, complex<f32>, complex<f32>) -> complex<f32>
    %47 = "complex.create"(%44, %45) : (f32, f32) -> complex<f32>
    %48 = "arith.andi"(%39, %40) : (i1, i1) -> i1
    %49 = "arith.andi"(%48, %43) : (i1, i1) -> i1
    %50 = "arith.select"(%49, %46, %47) : (i1, complex<f32>, complex<f32>) -> complex<f32>
    %51 = "arith.andi"(%41, %40) : (i1, i1) -> i1
    %52 = "arith.select"(%51, %36, %50) : (i1, complex<f32>, complex<f32>) -> complex<f32>
    %53 = "arith.cmpf"(%5, %35) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %54 = "arith.andi"(%53, %42) : (i1, i1) -> i1
    %55 = "arith.select"(%54, %36, %52) : (i1, complex<f32>, complex<f32>) -> complex<f32>
    %56 = "arith.cmpf"(%5, %33) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %57 = "arith.andi"(%56, %42) : (i1, i1) -> i1
    %58 = "arith.cmpf"(%3, %34) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
    %59 = "arith.andi"(%40, %58) : (i1, i1) -> i1
    %60 = "arith.andi"(%57, %59) : (i1, i1) -> i1
    %61 = "arith.select"(%60, %38, %55) : (i1, complex<f32>, complex<f32>) -> complex<f32>
    %62 = "arith.cmpf"(%3, %34) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
    %63 = "arith.andi"(%40, %62) : (i1, i1) -> i1
    %64 = "arith.andi"(%57, %63) : (i1, i1) -> i1
    %65 = "arith.select"(%64, %37, %61) : (i1, complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%65) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, i32) -> complex<f32>, sym_name = "complex_powi_with_fmf"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: i32):
    %0 = "arith.sitofp"(%arg1) : (i32) -> f32
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "complex.create"(%0, %1) : (f32, f32) -> complex<f32>
    %3 = "complex.re"(%2) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %4 = "complex.im"(%2) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %5 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %6 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %7 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %8 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %9 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %10 = "math.absf"(%7) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %11 = "math.absf"(%8) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %12 = "arith.maximumf"(%10, %11) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %13 = "arith.minimumf"(%10, %11) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %14 = "arith.divf"(%13, %12) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %15 = "arith.mulf"(%14, %14) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %16 = "arith.addf"(%15, %9) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %17 = "math.sqrt"(%16) <{fastmath = #arith.fastmath<contract>}> : (f32) -> f32
    %18 = "arith.mulf"(%12, %17) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %19 = "arith.cmpf"(%18, %18) <{fastmath = #arith.fastmath<contract>, predicate = 14 : i64}> : (f32, f32) -> i1
    %20 = "arith.select"(%19, %13, %18) : (i1, f32, f32) -> f32
    %21 = "math.powf"(%20, %3) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %22 = "arith.negf"(%4) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %23 = "math.atan2"(%6, %5) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %24 = "arith.mulf"(%22, %23) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %25 = "math.exp"(%24) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %26 = "arith.mulf"(%21, %25) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %27 = "math.log"(%20) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %28 = "arith.mulf"(%3, %23) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %29 = "arith.mulf"(%4, %27) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %30 = "arith.addf"(%28, %29) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %31 = "math.cos"(%30) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %32 = "math.sin"(%30) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %33 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %34 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %35 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %36 = "complex.create"(%35, %34) : (f32, f32) -> complex<f32>
    %37 = "complex.create"(%34, %34) : (f32, f32) -> complex<f32>
    %38 = "complex.create"(%33, %34) : (f32, f32) -> complex<f32>
    %39 = "arith.cmpf"(%20, %34) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 1 : i64}> : (f32, f32) -> i1
    %40 = "arith.cmpf"(%4, %34) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 1 : i64}> : (f32, f32) -> i1
    %41 = "arith.cmpf"(%3, %34) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 1 : i64}> : (f32, f32) -> i1
    %42 = "arith.cmpf"(%6, %34) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 1 : i64}> : (f32, f32) -> i1
    %43 = "arith.cmpf"(%34, %3) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 5 : i64}> : (f32, f32) -> i1
    %44 = "arith.mulf"(%26, %31) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %45 = "arith.mulf"(%26, %32) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %46 = "arith.select"(%41, %36, %37) : (i1, complex<f32>, complex<f32>) -> complex<f32>
    %47 = "complex.create"(%44, %45) : (f32, f32) -> complex<f32>
    %48 = "arith.andi"(%39, %40) : (i1, i1) -> i1
    %49 = "arith.andi"(%48, %43) : (i1, i1) -> i1
    %50 = "arith.select"(%49, %46, %47) : (i1, complex<f32>, complex<f32>) -> complex<f32>
    %51 = "arith.andi"(%41, %40) : (i1, i1) -> i1
    %52 = "arith.select"(%51, %36, %50) : (i1, complex<f32>, complex<f32>) -> complex<f32>
    %53 = "arith.cmpf"(%5, %35) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 1 : i64}> : (f32, f32) -> i1
    %54 = "arith.andi"(%53, %42) : (i1, i1) -> i1
    %55 = "arith.select"(%54, %36, %52) : (i1, complex<f32>, complex<f32>) -> complex<f32>
    %56 = "arith.cmpf"(%5, %33) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 1 : i64}> : (f32, f32) -> i1
    %57 = "arith.andi"(%56, %42) : (i1, i1) -> i1
    %58 = "arith.cmpf"(%3, %34) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 2 : i64}> : (f32, f32) -> i1
    %59 = "arith.andi"(%40, %58) : (i1, i1) -> i1
    %60 = "arith.andi"(%57, %59) : (i1, i1) -> i1
    %61 = "arith.select"(%60, %38, %55) : (i1, complex<f32>, complex<f32>) -> complex<f32>
    %62 = "arith.cmpf"(%3, %34) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 4 : i64}> : (f32, f32) -> i1
    %63 = "arith.andi"(%40, %62) : (i1, i1) -> i1
    %64 = "arith.andi"(%57, %63) : (i1, i1) -> i1
    %65 = "arith.select"(%64, %37, %61) : (i1, complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%65) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "complex_rsqrt"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = -5.000000e-01 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 0x7FC00000 : f32}> : () -> f32
    %4 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %5 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %6 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %7 = "math.absf"(%4) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %8 = "math.absf"(%5) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %9 = "arith.maximumf"(%7, %8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %10 = "arith.minimumf"(%7, %8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %11 = "arith.divf"(%10, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %12 = "arith.mulf"(%11, %11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %13 = "arith.addf"(%12, %6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %14 = "math.rsqrt"(%13) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %15 = "math.rsqrt"(%10) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %16 = "math.rsqrt"(%9) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %17 = "math.sqrt"(%14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %18 = "arith.mulf"(%16, %17) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %19 = "arith.cmpf"(%18, %18) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %20 = "arith.select"(%19, %15, %18) : (i1, f32, f32) -> f32
    %21 = "math.atan2"(%5, %4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %22 = "arith.mulf"(%21, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %23 = "math.cos"(%22) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %24 = "math.sin"(%22) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %25 = "arith.mulf"(%20, %23) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %26 = "arith.mulf"(%20, %24) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %27 = "arith.constant"() <{value = -1.000000e+00 : f32}> : () -> f32
    %28 = "math.copysign"(%0, %4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %29 = "math.copysign"(%0, %5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %30 = "arith.mulf"(%27, %29) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %31 = "math.absf"(%4) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %32 = "math.absf"(%5) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %33 = "arith.cmpf"(%32, %1) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %34 = "arith.cmpf"(%4, %4) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %35 = "arith.cmpf"(%31, %1) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %36 = "arith.andi"(%33, %34) : (i1, i1) -> i1
    %37 = "arith.ori"(%36, %35) : (i1, i1) -> i1
    %38 = "arith.select"(%37, %28, %25) : (i1, f32, f32) -> f32
    %39 = "arith.select"(%37, %30, %26) : (i1, f32, f32) -> f32
    %40 = "arith.cmpf"(%4, %0) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %41 = "arith.cmpf"(%5, %0) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %42 = "arith.andi"(%40, %41) : (i1, i1) -> i1
    %43 = "arith.select"(%42, %1, %38) : (i1, f32, f32) -> f32
    %44 = "arith.select"(%42, %3, %39) : (i1, f32, f32) -> f32
    %45 = "complex.create"(%43, %44) : (f32, f32) -> complex<f32>
    "func.return"(%45) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "complex_rsqrt_nnan_ninf"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = -5.000000e-01 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 0x7FC00000 : f32}> : () -> f32
    %4 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %5 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %6 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %7 = "math.absf"(%4) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32) -> f32
    %8 = "math.absf"(%5) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32) -> f32
    %9 = "arith.maximumf"(%7, %8) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32, f32) -> f32
    %10 = "arith.minimumf"(%7, %8) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32, f32) -> f32
    %11 = "arith.divf"(%10, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %12 = "arith.mulf"(%11, %11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %13 = "arith.addf"(%12, %6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %14 = "math.rsqrt"(%13) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %15 = "math.rsqrt"(%10) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %16 = "math.rsqrt"(%9) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %17 = "math.sqrt"(%14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %18 = "arith.mulf"(%16, %17) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %19 = "arith.cmpf"(%18, %18) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %20 = "arith.select"(%19, %15, %18) : (i1, f32, f32) -> f32
    %21 = "math.atan2"(%5, %4) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32, f32) -> f32
    %22 = "arith.mulf"(%21, %2) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32, f32) -> f32
    %23 = "math.cos"(%22) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32) -> f32
    %24 = "math.sin"(%22) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32) -> f32
    %25 = "arith.mulf"(%20, %23) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32, f32) -> f32
    %26 = "arith.mulf"(%20, %24) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32, f32) -> f32
    %27 = "arith.cmpf"(%4, %0) <{fastmath = #arith.fastmath<nnan,ninf>, predicate = 1 : i64}> : (f32, f32) -> i1
    %28 = "arith.cmpf"(%5, %0) <{fastmath = #arith.fastmath<nnan,ninf>, predicate = 1 : i64}> : (f32, f32) -> i1
    %29 = "arith.andi"(%27, %28) : (i1, i1) -> i1
    %30 = "arith.select"(%29, %1, %25) : (i1, f32, f32) -> f32
    %31 = "arith.select"(%29, %3, %26) : (i1, f32, f32) -> f32
    %32 = "complex.create"(%30, %31) : (f32, f32) -> complex<f32>
    "func.return"(%32) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> f32, sym_name = "complex_angle"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "math.atan2"(%1, %0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> f32, sym_name = "complex_abs_with_fmf"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "math.absf"(%0) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %4 = "math.absf"(%1) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %5 = "arith.maximumf"(%3, %4) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %6 = "arith.minimumf"(%3, %4) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %7 = "arith.divf"(%6, %5) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %8 = "arith.mulf"(%7, %7) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %9 = "arith.addf"(%8, %2) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %10 = "math.sqrt"(%9) <{fastmath = #arith.fastmath<contract>}> : (f32) -> f32
    %11 = "arith.mulf"(%5, %10) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %12 = "arith.cmpf"(%11, %11) <{fastmath = #arith.fastmath<contract>, predicate = 14 : i64}> : (f32, f32) -> i1
    %13 = "arith.select"(%12, %6, %11) : (i1, f32, f32) -> f32
    "func.return"(%13) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_add_with_fmf"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.re"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "arith.addf"(%0, %1) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %3 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %4 = "complex.im"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %5 = "arith.addf"(%3, %4) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %6 = "complex.create"(%2, %5) : (f32, f32) -> complex<f32>
    "func.return"(%6) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_sub_with_fmf"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.re"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "arith.subf"(%0, %1) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %3 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %4 = "complex.im"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %5 = "arith.subf"(%3, %4) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %6 = "complex.create"(%2, %5) : (f32, f32) -> complex<f32>
    "func.return"(%6) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "complex_exp_with_fmf"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
    %4 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %5 = "math.exp"(%0) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %6 = "arith.mulf"(%0, %3) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %7 = "math.exp"(%6) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %8 = "math.cos"(%1) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %9 = "math.sin"(%1) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %10 = "arith.cmpf"(%5, %4) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 1 : i64}> : (f32, f32) -> i1
    %11 = "arith.cmpf"(%1, %2) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %12 = "arith.mulf"(%5, %8) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %13 = "arith.mulf"(%7, %8) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %14 = "arith.mulf"(%13, %7) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %15 = "arith.select"(%10, %14, %12) : (i1, f32, f32) -> f32
    %16 = "arith.mulf"(%5, %9) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %17 = "arith.mulf"(%7, %9) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %18 = "arith.mulf"(%17, %7) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %19 = "arith.select"(%10, %18, %16) : (i1, f32, f32) -> f32
    %20 = "arith.select"(%11, %2, %19) : (i1, f32, f32) -> f32
    %21 = "complex.create"(%15, %20) : (f32, f32) -> complex<f32>
    "func.return"(%21) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "complex_log_with_fmf"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "math.absf"(%0) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %4 = "math.absf"(%1) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %5 = "arith.maximumf"(%3, %4) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %6 = "arith.minimumf"(%3, %4) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %7 = "arith.divf"(%6, %5) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %8 = "arith.mulf"(%7, %7) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %9 = "arith.addf"(%8, %2) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %10 = "math.sqrt"(%9) <{fastmath = #arith.fastmath<contract>}> : (f32) -> f32
    %11 = "arith.mulf"(%5, %10) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %12 = "arith.cmpf"(%11, %11) <{fastmath = #arith.fastmath<contract>, predicate = 14 : i64}> : (f32, f32) -> i1
    %13 = "arith.select"(%12, %6, %11) : (i1, f32, f32) -> f32
    %14 = "math.log"(%13) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %15 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %16 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %17 = "math.atan2"(%16, %15) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %18 = "complex.create"(%14, %17) : (f32, f32) -> complex<f32>
    "func.return"(%18) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "complex_log1p_with_fmf"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %4 = "arith.addf"(%0, %3) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %5 = "math.absf"(%4) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %6 = "math.absf"(%1) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %7 = "arith.maximumf"(%5, %6) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %8 = "arith.minimumf"(%5, %6) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %9 = "arith.cmpf"(%4, %6) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 2 : i64}> : (f32, f32) -> i1
    %10 = "arith.subf"(%7, %3) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %11 = "arith.select"(%9, %0, %10) : (i1, f32, f32) -> f32
    %12 = "arith.divf"(%8, %7) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %13 = "math.log1p"(%11) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %14 = "arith.mulf"(%12, %12) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %15 = "math.log1p"(%14) <{fastmath = #arith.fastmath<contract>}> : (f32) -> f32
    %16 = "arith.mulf"(%2, %15) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %17 = "arith.addf"(%16, %13) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %18 = "arith.cmpf"(%17, %17) <{fastmath = #arith.fastmath<contract>, predicate = 14 : i64}> : (f32, f32) -> i1
    %19 = "arith.select"(%18, %8, %17) : (i1, f32, f32) -> f32
    %20 = "math.atan2"(%1, %4) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %21 = "complex.create"(%19, %20) : (f32, f32) -> complex<f32>
    "func.return"(%21) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_mul_with_fmf"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "complex.re"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %3 = "complex.im"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %4 = "arith.mulf"(%0, %2) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %5 = "arith.mulf"(%1, %3) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %6 = "arith.subf"(%4, %5) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %7 = "arith.mulf"(%1, %2) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %8 = "arith.mulf"(%0, %3) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %9 = "arith.addf"(%7, %8) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %10 = "complex.create"(%6, %9) : (f32, f32) -> complex<f32>
    "func.return"(%10) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_atan2_with_fmf"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "complex.re"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "complex.re"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %3 = "complex.im"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %4 = "arith.mulf"(%0, %2) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %5 = "arith.mulf"(%1, %3) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %6 = "arith.subf"(%4, %5) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %7 = "arith.mulf"(%1, %2) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %8 = "arith.mulf"(%0, %3) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %9 = "arith.addf"(%7, %8) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %10 = "complex.create"(%6, %9) : (f32, f32) -> complex<f32>
    %11 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %12 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %13 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %14 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %15 = "arith.mulf"(%11, %13) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %16 = "arith.mulf"(%12, %14) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %17 = "arith.subf"(%15, %16) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %18 = "arith.mulf"(%12, %13) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %19 = "arith.mulf"(%11, %14) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %20 = "arith.addf"(%18, %19) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %21 = "complex.create"(%17, %20) : (f32, f32) -> complex<f32>
    %22 = "complex.re"(%10) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %23 = "complex.re"(%21) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %24 = "arith.addf"(%22, %23) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %25 = "complex.im"(%10) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %26 = "complex.im"(%21) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %27 = "arith.addf"(%25, %26) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %28 = "complex.create"(%24, %27) : (f32, f32) -> complex<f32>
    %29 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %30 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
    %31 = "complex.re"(%28) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %32 = "complex.im"(%28) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %33 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %34 = "math.absf"(%31) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %35 = "math.absf"(%32) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %36 = "arith.maximumf"(%34, %35) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %37 = "arith.minimumf"(%34, %35) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %38 = "arith.divf"(%37, %36) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %39 = "arith.mulf"(%38, %38) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %40 = "arith.addf"(%39, %33) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %41 = "arith.constant"() <{value = 2.500000e-01 : f32}> : () -> f32
    %42 = "math.sqrt"(%36) <{fastmath = #arith.fastmath<contract>}> : (f32) -> f32
    %43 = "math.powf"(%40, %41) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %44 = "arith.mulf"(%42, %43) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %45 = "arith.cmpf"(%44, %44) <{fastmath = #arith.fastmath<contract>, predicate = 14 : i64}> : (f32, f32) -> i1
    %46 = "arith.select"(%45, %37, %44) : (i1, f32, f32) -> f32
    %47 = "math.atan2"(%32, %31) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %48 = "arith.mulf"(%47, %30) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %49 = "math.cos"(%48) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %50 = "math.sin"(%48) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %51 = "arith.cmpf"(%50, %29) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 1 : i64}> : (f32, f32) -> i1
    %52 = "arith.mulf"(%46, %49) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %53 = "arith.mulf"(%46, %50) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %54 = "arith.select"(%51, %29, %53) : (i1, f32, f32) -> f32
    %55 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %56 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %57 = "arith.constant"() <{value = 0x7FC00000 : f32}> : () -> f32
    %58 = "math.absf"(%32) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %59 = "arith.cmpf"(%58, %55) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 1 : i64}> : (f32, f32) -> i1
    %60 = "arith.cmpf"(%58, %55) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 6 : i64}> : (f32, f32) -> i1
    %61 = "arith.cmpf"(%31, %55) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 1 : i64}> : (f32, f32) -> i1
    %62 = "arith.cmpf"(%31, %56) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 1 : i64}> : (f32, f32) -> i1
    %63 = "arith.andi"(%62, %60) : (i1, i1) -> i1
    %64 = "arith.select"(%63, %29, %52) : (i1, f32, f32) -> f32
    %65 = "arith.ori"(%59, %61) : (i1, i1) -> i1
    %66 = "arith.select"(%65, %55, %64) : (i1, f32, f32) -> f32
    %67 = "math.copysign"(%55, %32) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %68 = "arith.cmpf"(%46, %46) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %69 = "arith.select"(%68, %57, %54) : (i1, f32, f32) -> f32
    %70 = "arith.ori"(%59, %62) : (i1, i1) -> i1
    %71 = "arith.select"(%70, %67, %69) : (i1, f32, f32) -> f32
    %72 = "arith.cmpf"(%46, %29) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 1 : i64}> : (f32, f32) -> i1
    %73 = "arith.select"(%72, %29, %66) : (i1, f32, f32) -> f32
    %74 = "arith.select"(%72, %29, %71) : (i1, f32, f32) -> f32
    %75 = "complex.create"(%73, %74) : (f32, f32) -> complex<f32>
    %76 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %77 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %78 = "complex.create"(%76, %77) : (f32, f32) -> complex<f32>
    %79 = "complex.re"(%78) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %80 = "complex.im"(%78) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %81 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %82 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %83 = "arith.mulf"(%79, %81) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %84 = "arith.mulf"(%80, %82) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %85 = "arith.subf"(%83, %84) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %86 = "arith.mulf"(%80, %81) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %87 = "arith.mulf"(%79, %82) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %88 = "arith.addf"(%86, %87) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %89 = "complex.create"(%85, %88) : (f32, f32) -> complex<f32>
    %90 = "complex.re"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %91 = "complex.re"(%89) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %92 = "arith.addf"(%90, %91) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %93 = "complex.im"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %94 = "complex.im"(%89) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %95 = "arith.addf"(%93, %94) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %96 = "complex.create"(%92, %95) : (f32, f32) -> complex<f32>
    %97 = "complex.re"(%96) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %98 = "complex.im"(%96) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %99 = "complex.re"(%75) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %100 = "complex.im"(%75) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %101 = "arith.divf"(%99, %100) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %102 = "arith.mulf"(%101, %99) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %103 = "arith.addf"(%100, %102) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %104 = "arith.mulf"(%97, %101) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %105 = "arith.addf"(%104, %98) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %106 = "arith.divf"(%105, %103) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %107 = "arith.mulf"(%98, %101) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %108 = "arith.subf"(%107, %97) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %109 = "arith.divf"(%108, %103) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %110 = "arith.divf"(%100, %99) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %111 = "arith.mulf"(%110, %100) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %112 = "arith.addf"(%99, %111) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %113 = "arith.mulf"(%98, %110) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %114 = "arith.addf"(%97, %113) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %115 = "arith.divf"(%114, %112) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %116 = "arith.mulf"(%97, %110) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %117 = "arith.subf"(%98, %116) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %118 = "arith.divf"(%117, %112) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %119 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %120 = "math.absf"(%99) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %121 = "arith.cmpf"(%120, %119) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %122 = "math.absf"(%100) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %123 = "arith.cmpf"(%122, %119) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %124 = "arith.cmpf"(%97, %119) <{fastmath = #arith.fastmath<none>, predicate = 7 : i64}> : (f32, f32) -> i1
    %125 = "arith.cmpf"(%98, %119) <{fastmath = #arith.fastmath<none>, predicate = 7 : i64}> : (f32, f32) -> i1
    %126 = "arith.ori"(%124, %125) : (i1, i1) -> i1
    %127 = "arith.andi"(%121, %123) : (i1, i1) -> i1
    %128 = "arith.andi"(%126, %127) : (i1, i1) -> i1
    %129 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %130 = "math.copysign"(%129, %99) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %131 = "arith.mulf"(%130, %97) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %132 = "arith.mulf"(%130, %98) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %133 = "arith.cmpf"(%120, %129) <{fastmath = #arith.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %134 = "arith.cmpf"(%122, %129) <{fastmath = #arith.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %135 = "arith.andi"(%133, %134) : (i1, i1) -> i1
    %136 = "math.absf"(%97) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %137 = "arith.cmpf"(%136, %129) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %138 = "math.absf"(%98) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %139 = "arith.cmpf"(%138, %129) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %140 = "arith.ori"(%137, %139) : (i1, i1) -> i1
    %141 = "arith.andi"(%140, %135) : (i1, i1) -> i1
    %142 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %143 = "arith.select"(%137, %142, %119) : (i1, f32, f32) -> f32
    %144 = "math.copysign"(%143, %97) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %145 = "arith.select"(%139, %142, %119) : (i1, f32, f32) -> f32
    %146 = "math.copysign"(%145, %98) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %147 = "arith.mulf"(%144, %99) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %148 = "arith.mulf"(%146, %100) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %149 = "arith.addf"(%147, %148) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %150 = "arith.mulf"(%129, %149) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %151 = "arith.mulf"(%144, %100) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %152 = "arith.mulf"(%146, %99) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %153 = "arith.subf"(%152, %151) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %154 = "arith.mulf"(%129, %153) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %155 = "arith.cmpf"(%136, %129) <{fastmath = #arith.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %156 = "arith.cmpf"(%138, %129) <{fastmath = #arith.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %157 = "arith.andi"(%155, %156) : (i1, i1) -> i1
    %158 = "arith.cmpf"(%120, %129) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %159 = "arith.cmpf"(%122, %129) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %160 = "arith.ori"(%158, %159) : (i1, i1) -> i1
    %161 = "arith.andi"(%157, %160) : (i1, i1) -> i1
    %162 = "arith.select"(%158, %142, %119) : (i1, f32, f32) -> f32
    %163 = "math.copysign"(%162, %99) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %164 = "arith.select"(%159, %142, %119) : (i1, f32, f32) -> f32
    %165 = "math.copysign"(%164, %100) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %166 = "arith.mulf"(%97, %163) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %167 = "arith.mulf"(%98, %165) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %168 = "arith.addf"(%166, %167) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %169 = "arith.mulf"(%119, %168) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %170 = "arith.mulf"(%98, %163) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %171 = "arith.mulf"(%97, %165) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %172 = "arith.subf"(%170, %171) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %173 = "arith.mulf"(%119, %172) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %174 = "arith.cmpf"(%120, %122) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
    %175 = "arith.select"(%174, %106, %115) : (i1, f32, f32) -> f32
    %176 = "arith.select"(%174, %109, %118) : (i1, f32, f32) -> f32
    %177 = "arith.select"(%161, %169, %175) : (i1, f32, f32) -> f32
    %178 = "arith.select"(%161, %173, %176) : (i1, f32, f32) -> f32
    %179 = "arith.select"(%141, %150, %177) : (i1, f32, f32) -> f32
    %180 = "arith.select"(%141, %154, %178) : (i1, f32, f32) -> f32
    %181 = "arith.select"(%128, %131, %179) : (i1, f32, f32) -> f32
    %182 = "arith.select"(%128, %132, %180) : (i1, f32, f32) -> f32
    %183 = "arith.cmpf"(%175, %119) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %184 = "arith.cmpf"(%176, %119) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %185 = "arith.andi"(%183, %184) : (i1, i1) -> i1
    %186 = "arith.select"(%185, %181, %175) : (i1, f32, f32) -> f32
    %187 = "arith.select"(%185, %182, %176) : (i1, f32, f32) -> f32
    %188 = "complex.create"(%186, %187) : (f32, f32) -> complex<f32>
    %189 = "complex.re"(%188) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %190 = "complex.im"(%188) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %191 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %192 = "math.absf"(%189) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %193 = "math.absf"(%190) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %194 = "arith.maximumf"(%192, %193) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %195 = "arith.minimumf"(%192, %193) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %196 = "arith.divf"(%195, %194) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %197 = "arith.mulf"(%196, %196) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %198 = "arith.addf"(%197, %191) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %199 = "math.sqrt"(%198) <{fastmath = #arith.fastmath<contract>}> : (f32) -> f32
    %200 = "arith.mulf"(%194, %199) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %201 = "arith.cmpf"(%200, %200) <{fastmath = #arith.fastmath<contract>, predicate = 14 : i64}> : (f32, f32) -> i1
    %202 = "arith.select"(%201, %195, %200) : (i1, f32, f32) -> f32
    %203 = "math.log"(%202) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %204 = "complex.re"(%188) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %205 = "complex.im"(%188) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %206 = "math.atan2"(%205, %204) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %207 = "complex.create"(%203, %206) : (f32, f32) -> complex<f32>
    %208 = "arith.constant"() <{value = -1.000000e+00 : f32}> : () -> f32
    %209 = "complex.create"(%76, %208) : (f32, f32) -> complex<f32>
    %210 = "complex.re"(%209) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %211 = "complex.im"(%209) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %212 = "complex.re"(%207) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %213 = "complex.im"(%207) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %214 = "arith.mulf"(%210, %212) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %215 = "arith.mulf"(%211, %213) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %216 = "arith.subf"(%214, %215) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %217 = "arith.mulf"(%211, %212) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %218 = "arith.mulf"(%210, %213) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %219 = "arith.addf"(%217, %218) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %220 = "complex.create"(%216, %219) : (f32, f32) -> complex<f32>
    "func.return"(%220) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_div_with_fmf"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "complex.re"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %3 = "complex.im"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %4 = "arith.divf"(%2, %3) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %5 = "arith.mulf"(%4, %2) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %6 = "arith.addf"(%3, %5) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %7 = "arith.mulf"(%0, %4) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %8 = "arith.addf"(%7, %1) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %9 = "arith.divf"(%8, %6) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %10 = "arith.mulf"(%1, %4) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %11 = "arith.subf"(%10, %0) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %12 = "arith.divf"(%11, %6) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %13 = "arith.divf"(%3, %2) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %14 = "arith.mulf"(%13, %3) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %15 = "arith.addf"(%2, %14) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %16 = "arith.mulf"(%1, %13) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %17 = "arith.addf"(%0, %16) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %18 = "arith.divf"(%17, %15) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %19 = "arith.mulf"(%0, %13) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %20 = "arith.subf"(%1, %19) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %21 = "arith.divf"(%20, %15) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %22 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %23 = "math.absf"(%2) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %24 = "arith.cmpf"(%23, %22) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %25 = "math.absf"(%3) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %26 = "arith.cmpf"(%25, %22) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %27 = "arith.cmpf"(%0, %22) <{fastmath = #arith.fastmath<none>, predicate = 7 : i64}> : (f32, f32) -> i1
    %28 = "arith.cmpf"(%1, %22) <{fastmath = #arith.fastmath<none>, predicate = 7 : i64}> : (f32, f32) -> i1
    %29 = "arith.ori"(%27, %28) : (i1, i1) -> i1
    %30 = "arith.andi"(%24, %26) : (i1, i1) -> i1
    %31 = "arith.andi"(%29, %30) : (i1, i1) -> i1
    %32 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %33 = "math.copysign"(%32, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %34 = "arith.mulf"(%33, %0) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %35 = "arith.mulf"(%33, %1) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %36 = "arith.cmpf"(%23, %32) <{fastmath = #arith.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %37 = "arith.cmpf"(%25, %32) <{fastmath = #arith.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %38 = "arith.andi"(%36, %37) : (i1, i1) -> i1
    %39 = "math.absf"(%0) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %40 = "arith.cmpf"(%39, %32) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %41 = "math.absf"(%1) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %42 = "arith.cmpf"(%41, %32) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %43 = "arith.ori"(%40, %42) : (i1, i1) -> i1
    %44 = "arith.andi"(%43, %38) : (i1, i1) -> i1
    %45 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %46 = "arith.select"(%40, %45, %22) : (i1, f32, f32) -> f32
    %47 = "math.copysign"(%46, %0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %48 = "arith.select"(%42, %45, %22) : (i1, f32, f32) -> f32
    %49 = "math.copysign"(%48, %1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %50 = "arith.mulf"(%47, %2) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %51 = "arith.mulf"(%49, %3) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %52 = "arith.addf"(%50, %51) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %53 = "arith.mulf"(%32, %52) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %54 = "arith.mulf"(%47, %3) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %55 = "arith.mulf"(%49, %2) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %56 = "arith.subf"(%55, %54) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %57 = "arith.mulf"(%32, %56) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %58 = "arith.cmpf"(%39, %32) <{fastmath = #arith.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %59 = "arith.cmpf"(%41, %32) <{fastmath = #arith.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %60 = "arith.andi"(%58, %59) : (i1, i1) -> i1
    %61 = "arith.cmpf"(%23, %32) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %62 = "arith.cmpf"(%25, %32) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %63 = "arith.ori"(%61, %62) : (i1, i1) -> i1
    %64 = "arith.andi"(%60, %63) : (i1, i1) -> i1
    %65 = "arith.select"(%61, %45, %22) : (i1, f32, f32) -> f32
    %66 = "math.copysign"(%65, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %67 = "arith.select"(%62, %45, %22) : (i1, f32, f32) -> f32
    %68 = "math.copysign"(%67, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %69 = "arith.mulf"(%0, %66) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %70 = "arith.mulf"(%1, %68) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %71 = "arith.addf"(%69, %70) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %72 = "arith.mulf"(%22, %71) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %73 = "arith.mulf"(%1, %66) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %74 = "arith.mulf"(%0, %68) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %75 = "arith.subf"(%73, %74) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %76 = "arith.mulf"(%22, %75) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %77 = "arith.cmpf"(%23, %25) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
    %78 = "arith.select"(%77, %9, %18) : (i1, f32, f32) -> f32
    %79 = "arith.select"(%77, %12, %21) : (i1, f32, f32) -> f32
    %80 = "arith.select"(%64, %72, %78) : (i1, f32, f32) -> f32
    %81 = "arith.select"(%64, %76, %79) : (i1, f32, f32) -> f32
    %82 = "arith.select"(%44, %53, %80) : (i1, f32, f32) -> f32
    %83 = "arith.select"(%44, %57, %81) : (i1, f32, f32) -> f32
    %84 = "arith.select"(%31, %34, %82) : (i1, f32, f32) -> f32
    %85 = "arith.select"(%31, %35, %83) : (i1, f32, f32) -> f32
    %86 = "arith.cmpf"(%78, %22) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %87 = "arith.cmpf"(%79, %22) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %88 = "arith.andi"(%86, %87) : (i1, i1) -> i1
    %89 = "arith.select"(%88, %84, %78) : (i1, f32, f32) -> f32
    %90 = "arith.select"(%88, %85, %79) : (i1, f32, f32) -> f32
    %91 = "complex.create"(%89, %90) : (f32, f32) -> complex<f32>
    "func.return"(%91) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "complex_sqrt_with_fmf"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
    %2 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %3 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %4 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %5 = "math.absf"(%2) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %6 = "math.absf"(%3) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %7 = "arith.maximumf"(%5, %6) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %8 = "arith.minimumf"(%5, %6) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %9 = "arith.divf"(%8, %7) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %10 = "arith.mulf"(%9, %9) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %11 = "arith.addf"(%10, %4) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %12 = "arith.constant"() <{value = 2.500000e-01 : f32}> : () -> f32
    %13 = "math.sqrt"(%7) <{fastmath = #arith.fastmath<contract>}> : (f32) -> f32
    %14 = "math.powf"(%11, %12) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %15 = "arith.mulf"(%13, %14) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %16 = "arith.cmpf"(%15, %15) <{fastmath = #arith.fastmath<contract>, predicate = 14 : i64}> : (f32, f32) -> i1
    %17 = "arith.select"(%16, %8, %15) : (i1, f32, f32) -> f32
    %18 = "math.atan2"(%3, %2) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %19 = "arith.mulf"(%18, %1) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %20 = "math.cos"(%19) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %21 = "math.sin"(%19) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %22 = "arith.cmpf"(%21, %0) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 1 : i64}> : (f32, f32) -> i1
    %23 = "arith.mulf"(%17, %20) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %24 = "arith.mulf"(%17, %21) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %25 = "arith.select"(%22, %0, %24) : (i1, f32, f32) -> f32
    %26 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %27 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %28 = "arith.constant"() <{value = 0x7FC00000 : f32}> : () -> f32
    %29 = "math.absf"(%3) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %30 = "arith.cmpf"(%29, %26) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 1 : i64}> : (f32, f32) -> i1
    %31 = "arith.cmpf"(%29, %26) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 6 : i64}> : (f32, f32) -> i1
    %32 = "arith.cmpf"(%2, %26) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 1 : i64}> : (f32, f32) -> i1
    %33 = "arith.cmpf"(%2, %27) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 1 : i64}> : (f32, f32) -> i1
    %34 = "arith.andi"(%33, %31) : (i1, i1) -> i1
    %35 = "arith.select"(%34, %0, %23) : (i1, f32, f32) -> f32
    %36 = "arith.ori"(%30, %32) : (i1, i1) -> i1
    %37 = "arith.select"(%36, %26, %35) : (i1, f32, f32) -> f32
    %38 = "math.copysign"(%26, %3) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %39 = "arith.cmpf"(%17, %17) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %40 = "arith.select"(%39, %28, %25) : (i1, f32, f32) -> f32
    %41 = "arith.ori"(%30, %33) : (i1, i1) -> i1
    %42 = "arith.select"(%41, %38, %40) : (i1, f32, f32) -> f32
    %43 = "arith.cmpf"(%17, %0) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 1 : i64}> : (f32, f32) -> i1
    %44 = "arith.select"(%43, %0, %37) : (i1, f32, f32) -> f32
    %45 = "arith.select"(%43, %0, %42) : (i1, f32, f32) -> f32
    %46 = "complex.create"(%44, %45) : (f32, f32) -> complex<f32>
    "func.return"(%46) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "complex_cos_with_fmf"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
    %3 = "math.exp"(%1) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %4 = "arith.mulf"(%2, %3) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %5 = "arith.divf"(%2, %3) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %6 = "math.sin"(%0) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %7 = "math.cos"(%0) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %8 = "arith.addf"(%5, %4) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %9 = "arith.mulf"(%8, %7) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %10 = "arith.subf"(%5, %4) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %11 = "arith.mulf"(%10, %6) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %12 = "complex.create"(%9, %11) : (f32, f32) -> complex<f32>
    "func.return"(%12) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "complex_sin_with_fmf"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
    %3 = "math.exp"(%1) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %4 = "arith.mulf"(%2, %3) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %5 = "arith.divf"(%2, %3) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %6 = "math.sin"(%0) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %7 = "math.cos"(%0) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %8 = "arith.addf"(%4, %5) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %9 = "arith.mulf"(%8, %6) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %10 = "arith.subf"(%4, %5) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %11 = "arith.mulf"(%10, %7) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %12 = "complex.create"(%9, %11) : (f32, f32) -> complex<f32>
    "func.return"(%12) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "complex_sign_with_fmf"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "arith.cmpf"(%0, %2) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %4 = "arith.cmpf"(%1, %2) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %5 = "arith.andi"(%3, %4) : (i1, i1) -> i1
    %6 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %7 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %8 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %9 = "math.absf"(%6) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %10 = "math.absf"(%7) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %11 = "arith.maximumf"(%9, %10) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %12 = "arith.minimumf"(%9, %10) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %13 = "arith.divf"(%12, %11) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %14 = "arith.mulf"(%13, %13) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %15 = "arith.addf"(%14, %8) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %16 = "math.sqrt"(%15) <{fastmath = #arith.fastmath<contract>}> : (f32) -> f32
    %17 = "arith.mulf"(%11, %16) <{fastmath = #arith.fastmath<contract>}> : (f32, f32) -> f32
    %18 = "arith.cmpf"(%17, %17) <{fastmath = #arith.fastmath<contract>, predicate = 14 : i64}> : (f32, f32) -> i1
    %19 = "arith.select"(%18, %12, %17) : (i1, f32, f32) -> f32
    %20 = "arith.divf"(%0, %19) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %21 = "arith.divf"(%1, %19) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %22 = "complex.create"(%20, %21) : (f32, f32) -> complex<f32>
    %23 = "arith.select"(%5, %arg0, %22) : (i1, complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%23) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "complex_tan_with_fmf"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "arith.constant"() <{value = -1.000000e+00 : f32}> : () -> f32
    %3 = "arith.mulf"(%1, %2) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %4 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %5 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    %6 = "arith.addf"(%3, %3) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %7 = "arith.mulf"(%2, %6) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %8 = "math.expm1"(%6) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %9 = "math.expm1"(%7) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %10 = "arith.subf"(%8, %9) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %11 = "math.cos"(%0) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %12 = "arith.mulf"(%11, %11) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %13 = "arith.mulf"(%12, %5) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %14 = "math.sin"(%0) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %15 = "arith.mulf"(%11, %14) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %16 = "arith.mulf"(%5, %15) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %17 = "arith.addf"(%8, %9) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %18 = "arith.addf"(%17, %13) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %19 = "arith.cmpf"(%17, %4) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 1 : i64}> : (f32, f32) -> i1
    %20 = "math.copysign"(%2, %3) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %21 = "arith.divf"(%10, %18) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %22 = "arith.select"(%19, %20, %21) : (i1, f32, f32) -> f32
    %23 = "arith.divf"(%16, %18) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %24 = "math.absf"(%3) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %25 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %26 = "arith.constant"() <{value = 0x7FC00000 : f32}> : () -> f32
    %27 = "arith.cmpf"(%24, %4) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 1 : i64}> : (f32, f32) -> i1
    %28 = "arith.cmpf"(%0, %25) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 1 : i64}> : (f32, f32) -> i1
    %29 = "arith.constant"() <{value = true}> : () -> i1
    %30 = "arith.xori"(%27, %29) : (i1, i1) -> i1
    %31 = "arith.cmpf"(%16, %16) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 14 : i64}> : (f32, f32) -> i1
    %32 = "arith.andi"(%31, %30) : (i1, i1) -> i1
    %33 = "arith.andi"(%27, %31) : (i1, i1) -> i1
    %34 = "arith.ori"(%28, %33) : (i1, i1) -> i1
    %35 = "arith.select"(%32, %26, %22) : (i1, f32, f32) -> f32
    %36 = "arith.select"(%34, %25, %23) : (i1, f32, f32) -> f32
    %37 = "arith.mulf"(%35, %2) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %38 = "complex.create"(%36, %37) : (f32, f32) -> complex<f32>
    "func.return"(%38) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "complex_tanh_with_fmf"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "arith.constant"() <{value = -1.000000e+00 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %4 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    %5 = "arith.addf"(%0, %0) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %6 = "arith.mulf"(%2, %5) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %7 = "math.expm1"(%5) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %8 = "math.expm1"(%6) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %9 = "arith.subf"(%7, %8) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %10 = "math.cos"(%1) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %11 = "arith.mulf"(%10, %10) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %12 = "arith.mulf"(%11, %4) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %13 = "math.sin"(%1) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %14 = "arith.mulf"(%10, %13) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %15 = "arith.mulf"(%4, %14) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %16 = "arith.addf"(%7, %8) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %17 = "arith.addf"(%16, %12) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %18 = "arith.cmpf"(%16, %3) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 1 : i64}> : (f32, f32) -> i1
    %19 = "math.copysign"(%2, %0) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %20 = "arith.divf"(%9, %17) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %21 = "arith.select"(%18, %19, %20) : (i1, f32, f32) -> f32
    %22 = "arith.divf"(%15, %17) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    %23 = "math.absf"(%0) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32) -> f32
    %24 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %25 = "arith.constant"() <{value = 0x7FC00000 : f32}> : () -> f32
    %26 = "arith.cmpf"(%23, %3) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 1 : i64}> : (f32, f32) -> i1
    %27 = "arith.cmpf"(%1, %24) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 1 : i64}> : (f32, f32) -> i1
    %28 = "arith.constant"() <{value = true}> : () -> i1
    %29 = "arith.xori"(%26, %28) : (i1, i1) -> i1
    %30 = "arith.cmpf"(%15, %15) <{fastmath = #arith.fastmath<nnan,contract>, predicate = 14 : i64}> : (f32, f32) -> i1
    %31 = "arith.andi"(%30, %29) : (i1, i1) -> i1
    %32 = "arith.andi"(%26, %30) : (i1, i1) -> i1
    %33 = "arith.ori"(%27, %32) : (i1, i1) -> i1
    %34 = "arith.select"(%31, %25, %21) : (i1, f32, f32) -> f32
    %35 = "arith.select"(%33, %24, %22) : (i1, f32, f32) -> f32
    %36 = "complex.create"(%34, %35) : (f32, f32) -> complex<f32>
    "func.return"(%36) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "complex_tanh_nnan_ninf"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "arith.constant"() <{value = -1.000000e+00 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %4 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    %5 = "arith.addf"(%0, %0) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32, f32) -> f32
    %6 = "arith.mulf"(%2, %5) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32, f32) -> f32
    %7 = "math.expm1"(%5) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32) -> f32
    %8 = "math.expm1"(%6) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32) -> f32
    %9 = "arith.subf"(%7, %8) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32, f32) -> f32
    %10 = "math.cos"(%1) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32) -> f32
    %11 = "arith.mulf"(%10, %10) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32, f32) -> f32
    %12 = "arith.mulf"(%11, %4) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32, f32) -> f32
    %13 = "math.sin"(%1) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32) -> f32
    %14 = "arith.mulf"(%10, %13) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32, f32) -> f32
    %15 = "arith.mulf"(%4, %14) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32, f32) -> f32
    %16 = "arith.addf"(%7, %8) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32, f32) -> f32
    %17 = "arith.addf"(%16, %12) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32, f32) -> f32
    %18 = "arith.cmpf"(%16, %3) <{fastmath = #arith.fastmath<nnan,ninf>, predicate = 1 : i64}> : (f32, f32) -> i1
    %19 = "math.copysign"(%2, %0) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32, f32) -> f32
    %20 = "arith.divf"(%9, %17) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32, f32) -> f32
    %21 = "arith.select"(%18, %19, %20) : (i1, f32, f32) -> f32
    %22 = "arith.divf"(%15, %17) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32, f32) -> f32
    %23 = "complex.create"(%21, %22) : (f32, f32) -> complex<f32>
    "func.return"(%23) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> f32, sym_name = "complex_angle_with_fmf"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "math.atan2"(%1, %0) <{fastmath = #arith.fastmath<nnan,contract>}> : (f32, f32) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

