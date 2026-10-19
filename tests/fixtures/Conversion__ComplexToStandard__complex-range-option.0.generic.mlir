"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_div"}> ({
  ^bb0(%arg2: complex<f32>, %arg3: complex<f32>):
    %92 = "complex.re"(%arg2) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %93 = "complex.im"(%arg2) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %94 = "complex.re"(%arg3) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %95 = "complex.im"(%arg3) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %96 = "arith.divf"(%94, %95) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %97 = "arith.mulf"(%96, %94) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %98 = "arith.addf"(%95, %97) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %99 = "arith.mulf"(%92, %96) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %100 = "arith.addf"(%99, %93) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %101 = "arith.divf"(%100, %98) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %102 = "arith.mulf"(%93, %96) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %103 = "arith.subf"(%102, %92) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %104 = "arith.divf"(%103, %98) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %105 = "arith.divf"(%95, %94) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %106 = "arith.mulf"(%105, %95) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %107 = "arith.addf"(%94, %106) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %108 = "arith.mulf"(%93, %105) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %109 = "arith.addf"(%92, %108) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %110 = "arith.divf"(%109, %107) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %111 = "arith.mulf"(%92, %105) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %112 = "arith.subf"(%93, %111) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %113 = "arith.divf"(%112, %107) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %114 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %115 = "math.absf"(%94) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %116 = "arith.cmpf"(%115, %114) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %117 = "math.absf"(%95) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %118 = "arith.cmpf"(%117, %114) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %119 = "arith.cmpf"(%92, %114) <{fastmath = #arith.fastmath<none>, predicate = 7 : i64}> : (f32, f32) -> i1
    %120 = "arith.cmpf"(%93, %114) <{fastmath = #arith.fastmath<none>, predicate = 7 : i64}> : (f32, f32) -> i1
    %121 = "arith.ori"(%119, %120) : (i1, i1) -> i1
    %122 = "arith.andi"(%116, %118) : (i1, i1) -> i1
    %123 = "arith.andi"(%121, %122) : (i1, i1) -> i1
    %124 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %125 = "math.copysign"(%124, %94) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %126 = "arith.mulf"(%125, %92) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %127 = "arith.mulf"(%125, %93) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %128 = "arith.cmpf"(%115, %124) <{fastmath = #arith.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %129 = "arith.cmpf"(%117, %124) <{fastmath = #arith.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %130 = "arith.andi"(%128, %129) : (i1, i1) -> i1
    %131 = "math.absf"(%92) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %132 = "arith.cmpf"(%131, %124) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %133 = "math.absf"(%93) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %134 = "arith.cmpf"(%133, %124) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %135 = "arith.ori"(%132, %134) : (i1, i1) -> i1
    %136 = "arith.andi"(%135, %130) : (i1, i1) -> i1
    %137 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %138 = "arith.select"(%132, %137, %114) : (i1, f32, f32) -> f32
    %139 = "math.copysign"(%138, %92) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %140 = "arith.select"(%134, %137, %114) : (i1, f32, f32) -> f32
    %141 = "math.copysign"(%140, %93) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %142 = "arith.mulf"(%139, %94) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %143 = "arith.mulf"(%141, %95) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %144 = "arith.addf"(%142, %143) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %145 = "arith.mulf"(%124, %144) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %146 = "arith.mulf"(%139, %95) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %147 = "arith.mulf"(%141, %94) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %148 = "arith.subf"(%147, %146) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %149 = "arith.mulf"(%124, %148) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %150 = "arith.cmpf"(%131, %124) <{fastmath = #arith.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %151 = "arith.cmpf"(%133, %124) <{fastmath = #arith.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %152 = "arith.andi"(%150, %151) : (i1, i1) -> i1
    %153 = "arith.cmpf"(%115, %124) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %154 = "arith.cmpf"(%117, %124) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %155 = "arith.ori"(%153, %154) : (i1, i1) -> i1
    %156 = "arith.andi"(%152, %155) : (i1, i1) -> i1
    %157 = "arith.select"(%153, %137, %114) : (i1, f32, f32) -> f32
    %158 = "math.copysign"(%157, %94) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %159 = "arith.select"(%154, %137, %114) : (i1, f32, f32) -> f32
    %160 = "math.copysign"(%159, %95) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %161 = "arith.mulf"(%92, %158) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %162 = "arith.mulf"(%93, %160) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %163 = "arith.addf"(%161, %162) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %164 = "arith.mulf"(%114, %163) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %165 = "arith.mulf"(%93, %158) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %166 = "arith.mulf"(%92, %160) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %167 = "arith.subf"(%165, %166) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %168 = "arith.mulf"(%114, %167) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %169 = "arith.cmpf"(%115, %117) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
    %170 = "arith.select"(%169, %101, %110) : (i1, f32, f32) -> f32
    %171 = "arith.select"(%169, %104, %113) : (i1, f32, f32) -> f32
    %172 = "arith.select"(%156, %164, %170) : (i1, f32, f32) -> f32
    %173 = "arith.select"(%156, %168, %171) : (i1, f32, f32) -> f32
    %174 = "arith.select"(%136, %145, %172) : (i1, f32, f32) -> f32
    %175 = "arith.select"(%136, %149, %173) : (i1, f32, f32) -> f32
    %176 = "arith.select"(%123, %126, %174) : (i1, f32, f32) -> f32
    %177 = "arith.select"(%123, %127, %175) : (i1, f32, f32) -> f32
    %178 = "arith.cmpf"(%170, %114) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %179 = "arith.cmpf"(%171, %114) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %180 = "arith.andi"(%178, %179) : (i1, i1) -> i1
    %181 = "arith.select"(%180, %176, %170) : (i1, f32, f32) -> f32
    %182 = "arith.select"(%180, %177, %171) : (i1, f32, f32) -> f32
    %183 = "complex.create"(%181, %182) : (f32, f32) -> complex<f32>
    "func.return"(%183) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_div_with_fmf"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %1 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %2 = "complex.re"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %3 = "complex.im"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %4 = "arith.divf"(%2, %3) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %5 = "arith.mulf"(%4, %2) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %6 = "arith.addf"(%3, %5) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %7 = "arith.mulf"(%0, %4) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %8 = "arith.addf"(%7, %1) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %9 = "arith.divf"(%8, %6) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %10 = "arith.mulf"(%1, %4) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %11 = "arith.subf"(%10, %0) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %12 = "arith.divf"(%11, %6) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %13 = "arith.divf"(%3, %2) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %14 = "arith.mulf"(%13, %3) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %15 = "arith.addf"(%2, %14) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %16 = "arith.mulf"(%1, %13) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %17 = "arith.addf"(%0, %16) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %18 = "arith.divf"(%17, %15) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %19 = "arith.mulf"(%0, %13) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %20 = "arith.subf"(%1, %19) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %21 = "arith.divf"(%20, %15) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %22 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %23 = "math.absf"(%2) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32) -> f32
    %24 = "arith.cmpf"(%23, %22) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %25 = "math.absf"(%3) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32) -> f32
    %26 = "arith.cmpf"(%25, %22) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %27 = "arith.cmpf"(%0, %22) <{fastmath = #arith.fastmath<none>, predicate = 7 : i64}> : (f32, f32) -> i1
    %28 = "arith.cmpf"(%1, %22) <{fastmath = #arith.fastmath<none>, predicate = 7 : i64}> : (f32, f32) -> i1
    %29 = "arith.ori"(%27, %28) : (i1, i1) -> i1
    %30 = "arith.andi"(%24, %26) : (i1, i1) -> i1
    %31 = "arith.andi"(%29, %30) : (i1, i1) -> i1
    %32 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %33 = "math.copysign"(%32, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %34 = "arith.mulf"(%33, %0) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %35 = "arith.mulf"(%33, %1) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %36 = "arith.cmpf"(%23, %32) <{fastmath = #arith.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %37 = "arith.cmpf"(%25, %32) <{fastmath = #arith.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %38 = "arith.andi"(%36, %37) : (i1, i1) -> i1
    %39 = "math.absf"(%0) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32) -> f32
    %40 = "arith.cmpf"(%39, %32) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %41 = "math.absf"(%1) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32) -> f32
    %42 = "arith.cmpf"(%41, %32) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %43 = "arith.ori"(%40, %42) : (i1, i1) -> i1
    %44 = "arith.andi"(%43, %38) : (i1, i1) -> i1
    %45 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %46 = "arith.select"(%40, %45, %22) : (i1, f32, f32) -> f32
    %47 = "math.copysign"(%46, %0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %48 = "arith.select"(%42, %45, %22) : (i1, f32, f32) -> f32
    %49 = "math.copysign"(%48, %1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %50 = "arith.mulf"(%47, %2) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %51 = "arith.mulf"(%49, %3) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %52 = "arith.addf"(%50, %51) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %53 = "arith.mulf"(%32, %52) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %54 = "arith.mulf"(%47, %3) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %55 = "arith.mulf"(%49, %2) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %56 = "arith.subf"(%55, %54) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %57 = "arith.mulf"(%32, %56) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
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
    %69 = "arith.mulf"(%0, %66) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %70 = "arith.mulf"(%1, %68) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %71 = "arith.addf"(%69, %70) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %72 = "arith.mulf"(%22, %71) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %73 = "arith.mulf"(%1, %66) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %74 = "arith.mulf"(%0, %68) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %75 = "arith.subf"(%73, %74) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
    %76 = "arith.mulf"(%22, %75) <{fastmath = #arith.fastmath<nsz,arcp>}> : (f32, f32) -> f32
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

