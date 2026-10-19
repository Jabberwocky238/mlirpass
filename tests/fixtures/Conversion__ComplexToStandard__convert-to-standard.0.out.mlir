module {
  func.func @complex_abs(%arg0: complex<f32>) -> f32 {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %cst = arith.constant 1.000000e+00 : f32
    %2 = math.absf %0 : f32
    %3 = math.absf %1 : f32
    %4 = arith.maximumf %2, %3 : f32
    %5 = arith.minimumf %2, %3 : f32
    %6 = arith.divf %5, %4 : f32
    %7 = arith.mulf %6, %6 : f32
    %8 = arith.addf %7, %cst : f32
    %9 = math.sqrt %8 : f32
    %10 = arith.mulf %4, %9 : f32
    %11 = arith.cmpf uno, %10, %10 : f32
    %12 = arith.select %11, %5, %10 : f32
    return %12 : f32
  }
}

// -----
module {
  func.func @complex_atan2(%arg0: complex<f32>, %arg1: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg1 : complex<f32>
    %1 = complex.im %arg1 : complex<f32>
    %2 = complex.re %arg1 : complex<f32>
    %3 = complex.im %arg1 : complex<f32>
    %4 = arith.mulf %0, %2 : f32
    %5 = arith.mulf %1, %3 : f32
    %6 = arith.subf %4, %5 : f32
    %7 = arith.mulf %1, %2 : f32
    %8 = arith.mulf %0, %3 : f32
    %9 = arith.addf %7, %8 : f32
    %10 = complex.create %6, %9 : complex<f32>
    %11 = complex.re %arg0 : complex<f32>
    %12 = complex.im %arg0 : complex<f32>
    %13 = complex.re %arg0 : complex<f32>
    %14 = complex.im %arg0 : complex<f32>
    %15 = arith.mulf %11, %13 : f32
    %16 = arith.mulf %12, %14 : f32
    %17 = arith.subf %15, %16 : f32
    %18 = arith.mulf %12, %13 : f32
    %19 = arith.mulf %11, %14 : f32
    %20 = arith.addf %18, %19 : f32
    %21 = complex.create %17, %20 : complex<f32>
    %22 = complex.re %10 : complex<f32>
    %23 = complex.re %21 : complex<f32>
    %24 = arith.addf %22, %23 : f32
    %25 = complex.im %10 : complex<f32>
    %26 = complex.im %21 : complex<f32>
    %27 = arith.addf %25, %26 : f32
    %28 = complex.create %24, %27 : complex<f32>
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 5.000000e-01 : f32
    %29 = complex.re %28 : complex<f32>
    %30 = complex.im %28 : complex<f32>
    %cst_1 = arith.constant 1.000000e+00 : f32
    %31 = math.absf %29 : f32
    %32 = math.absf %30 : f32
    %33 = arith.maximumf %31, %32 : f32
    %34 = arith.minimumf %31, %32 : f32
    %35 = arith.divf %34, %33 : f32
    %36 = arith.mulf %35, %35 : f32
    %37 = arith.addf %36, %cst_1 : f32
    %cst_2 = arith.constant 2.500000e-01 : f32
    %38 = math.sqrt %33 : f32
    %39 = math.powf %37, %cst_2 : f32
    %40 = arith.mulf %38, %39 : f32
    %41 = arith.cmpf uno, %40, %40 : f32
    %42 = arith.select %41, %34, %40 : f32
    %43 = math.atan2 %30, %29 : f32
    %44 = arith.mulf %43, %cst_0 : f32
    %45 = math.cos %44 : f32
    %46 = math.sin %44 : f32
    %47 = arith.cmpf oeq, %46, %cst : f32
    %48 = arith.mulf %42, %45 : f32
    %49 = arith.mulf %42, %46 : f32
    %50 = arith.select %47, %cst, %49 : f32
    %cst_3 = arith.constant 0x7F800000 : f32
    %cst_4 = arith.constant 0xFF800000 : f32
    %cst_5 = arith.constant 0x7FC00000 : f32
    %51 = math.absf %30 : f32
    %52 = arith.cmpf oeq, %51, %cst_3 : f32
    %53 = arith.cmpf one, %51, %cst_3 : f32
    %54 = arith.cmpf oeq, %29, %cst_3 : f32
    %55 = arith.cmpf oeq, %29, %cst_4 : f32
    %56 = arith.andi %55, %53 : i1
    %57 = arith.select %56, %cst, %48 : f32
    %58 = arith.ori %52, %54 : i1
    %59 = arith.select %58, %cst_3, %57 : f32
    %60 = math.copysign %cst_3, %30 : f32
    %61 = arith.cmpf uno, %42, %42 : f32
    %62 = arith.select %61, %cst_5, %50 : f32
    %63 = arith.ori %52, %55 : i1
    %64 = arith.select %63, %60, %62 : f32
    %65 = arith.cmpf oeq, %42, %cst : f32
    %66 = arith.select %65, %cst, %59 : f32
    %67 = arith.select %65, %cst, %64 : f32
    %68 = complex.create %66, %67 : complex<f32>
    %cst_6 = arith.constant 0.000000e+00 : f32
    %cst_7 = arith.constant 1.000000e+00 : f32
    %69 = complex.create %cst_6, %cst_7 : complex<f32>
    %70 = complex.re %69 : complex<f32>
    %71 = complex.im %69 : complex<f32>
    %72 = complex.re %arg0 : complex<f32>
    %73 = complex.im %arg0 : complex<f32>
    %74 = arith.mulf %70, %72 : f32
    %75 = arith.mulf %71, %73 : f32
    %76 = arith.subf %74, %75 : f32
    %77 = arith.mulf %71, %72 : f32
    %78 = arith.mulf %70, %73 : f32
    %79 = arith.addf %77, %78 : f32
    %80 = complex.create %76, %79 : complex<f32>
    %81 = complex.re %arg1 : complex<f32>
    %82 = complex.re %80 : complex<f32>
    %83 = arith.addf %81, %82 : f32
    %84 = complex.im %arg1 : complex<f32>
    %85 = complex.im %80 : complex<f32>
    %86 = arith.addf %84, %85 : f32
    %87 = complex.create %83, %86 : complex<f32>
    %88 = complex.re %87 : complex<f32>
    %89 = complex.im %87 : complex<f32>
    %90 = complex.re %68 : complex<f32>
    %91 = complex.im %68 : complex<f32>
    %92 = arith.divf %90, %91 : f32
    %93 = arith.mulf %92, %90 : f32
    %94 = arith.addf %91, %93 : f32
    %95 = arith.mulf %88, %92 : f32
    %96 = arith.addf %95, %89 : f32
    %97 = arith.divf %96, %94 : f32
    %98 = arith.mulf %89, %92 : f32
    %99 = arith.subf %98, %88 : f32
    %100 = arith.divf %99, %94 : f32
    %101 = arith.divf %91, %90 : f32
    %102 = arith.mulf %101, %91 : f32
    %103 = arith.addf %90, %102 : f32
    %104 = arith.mulf %89, %101 : f32
    %105 = arith.addf %88, %104 : f32
    %106 = arith.divf %105, %103 : f32
    %107 = arith.mulf %88, %101 : f32
    %108 = arith.subf %89, %107 : f32
    %109 = arith.divf %108, %103 : f32
    %cst_8 = arith.constant 0.000000e+00 : f32
    %110 = math.absf %90 : f32
    %111 = arith.cmpf oeq, %110, %cst_8 : f32
    %112 = math.absf %91 : f32
    %113 = arith.cmpf oeq, %112, %cst_8 : f32
    %114 = arith.cmpf ord, %88, %cst_8 : f32
    %115 = arith.cmpf ord, %89, %cst_8 : f32
    %116 = arith.ori %114, %115 : i1
    %117 = arith.andi %111, %113 : i1
    %118 = arith.andi %116, %117 : i1
    %cst_9 = arith.constant 0x7F800000 : f32
    %119 = math.copysign %cst_9, %90 : f32
    %120 = arith.mulf %119, %88 : f32
    %121 = arith.mulf %119, %89 : f32
    %122 = arith.cmpf one, %110, %cst_9 : f32
    %123 = arith.cmpf one, %112, %cst_9 : f32
    %124 = arith.andi %122, %123 : i1
    %125 = math.absf %88 : f32
    %126 = arith.cmpf oeq, %125, %cst_9 : f32
    %127 = math.absf %89 : f32
    %128 = arith.cmpf oeq, %127, %cst_9 : f32
    %129 = arith.ori %126, %128 : i1
    %130 = arith.andi %129, %124 : i1
    %cst_10 = arith.constant 1.000000e+00 : f32
    %131 = arith.select %126, %cst_10, %cst_8 : f32
    %132 = math.copysign %131, %88 : f32
    %133 = arith.select %128, %cst_10, %cst_8 : f32
    %134 = math.copysign %133, %89 : f32
    %135 = arith.mulf %132, %90 : f32
    %136 = arith.mulf %134, %91 : f32
    %137 = arith.addf %135, %136 : f32
    %138 = arith.mulf %cst_9, %137 : f32
    %139 = arith.mulf %132, %91 : f32
    %140 = arith.mulf %134, %90 : f32
    %141 = arith.subf %140, %139 : f32
    %142 = arith.mulf %cst_9, %141 : f32
    %143 = arith.cmpf one, %125, %cst_9 : f32
    %144 = arith.cmpf one, %127, %cst_9 : f32
    %145 = arith.andi %143, %144 : i1
    %146 = arith.cmpf oeq, %110, %cst_9 : f32
    %147 = arith.cmpf oeq, %112, %cst_9 : f32
    %148 = arith.ori %146, %147 : i1
    %149 = arith.andi %145, %148 : i1
    %150 = arith.select %146, %cst_10, %cst_8 : f32
    %151 = math.copysign %150, %90 : f32
    %152 = arith.select %147, %cst_10, %cst_8 : f32
    %153 = math.copysign %152, %91 : f32
    %154 = arith.mulf %88, %151 : f32
    %155 = arith.mulf %89, %153 : f32
    %156 = arith.addf %154, %155 : f32
    %157 = arith.mulf %cst_8, %156 : f32
    %158 = arith.mulf %89, %151 : f32
    %159 = arith.mulf %88, %153 : f32
    %160 = arith.subf %158, %159 : f32
    %161 = arith.mulf %cst_8, %160 : f32
    %162 = arith.cmpf olt, %110, %112 : f32
    %163 = arith.select %162, %97, %106 : f32
    %164 = arith.select %162, %100, %109 : f32
    %165 = arith.select %149, %157, %163 : f32
    %166 = arith.select %149, %161, %164 : f32
    %167 = arith.select %130, %138, %165 : f32
    %168 = arith.select %130, %142, %166 : f32
    %169 = arith.select %118, %120, %167 : f32
    %170 = arith.select %118, %121, %168 : f32
    %171 = arith.cmpf uno, %163, %cst_8 : f32
    %172 = arith.cmpf uno, %164, %cst_8 : f32
    %173 = arith.andi %171, %172 : i1
    %174 = arith.select %173, %169, %163 : f32
    %175 = arith.select %173, %170, %164 : f32
    %176 = complex.create %174, %175 : complex<f32>
    %177 = complex.re %176 : complex<f32>
    %178 = complex.im %176 : complex<f32>
    %cst_11 = arith.constant 1.000000e+00 : f32
    %179 = math.absf %177 : f32
    %180 = math.absf %178 : f32
    %181 = arith.maximumf %179, %180 : f32
    %182 = arith.minimumf %179, %180 : f32
    %183 = arith.divf %182, %181 : f32
    %184 = arith.mulf %183, %183 : f32
    %185 = arith.addf %184, %cst_11 : f32
    %186 = math.sqrt %185 : f32
    %187 = arith.mulf %181, %186 : f32
    %188 = arith.cmpf uno, %187, %187 : f32
    %189 = arith.select %188, %182, %187 : f32
    %190 = math.log %189 : f32
    %191 = complex.re %176 : complex<f32>
    %192 = complex.im %176 : complex<f32>
    %193 = math.atan2 %192, %191 : f32
    %194 = complex.create %190, %193 : complex<f32>
    %cst_12 = arith.constant -1.000000e+00 : f32
    %195 = complex.create %cst_6, %cst_12 : complex<f32>
    %196 = complex.re %195 : complex<f32>
    %197 = complex.im %195 : complex<f32>
    %198 = complex.re %194 : complex<f32>
    %199 = complex.im %194 : complex<f32>
    %200 = arith.mulf %196, %198 : f32
    %201 = arith.mulf %197, %199 : f32
    %202 = arith.subf %200, %201 : f32
    %203 = arith.mulf %197, %198 : f32
    %204 = arith.mulf %196, %199 : f32
    %205 = arith.addf %203, %204 : f32
    %206 = complex.create %202, %205 : complex<f32>
    return %206 : complex<f32>
  }
}

// -----
module {
  func.func @complex_add(%arg0: complex<f32>, %arg1: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.re %arg1 : complex<f32>
    %2 = arith.addf %0, %1 : f32
    %3 = complex.im %arg0 : complex<f32>
    %4 = complex.im %arg1 : complex<f32>
    %5 = arith.addf %3, %4 : f32
    %6 = complex.create %2, %5 : complex<f32>
    return %6 : complex<f32>
  }
}

// -----
module {
  func.func @complex_cos(%arg0: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %cst = arith.constant 5.000000e-01 : f32
    %2 = math.exp %1 : f32
    %3 = arith.mulf %cst, %2 : f32
    %4 = arith.divf %cst, %2 : f32
    %5 = math.sin %0 : f32
    %6 = math.cos %0 : f32
    %7 = arith.addf %4, %3 : f32
    %8 = arith.mulf %7, %6 : f32
    %9 = arith.subf %4, %3 : f32
    %10 = arith.mulf %9, %5 : f32
    %11 = complex.create %8, %10 : complex<f32>
    return %11 : complex<f32>
  }
}

// -----
module {
  func.func @complex_div(%arg0: complex<f32>, %arg1: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %2 = complex.re %arg1 : complex<f32>
    %3 = complex.im %arg1 : complex<f32>
    %4 = arith.divf %2, %3 : f32
    %5 = arith.mulf %4, %2 : f32
    %6 = arith.addf %3, %5 : f32
    %7 = arith.mulf %0, %4 : f32
    %8 = arith.addf %7, %1 : f32
    %9 = arith.divf %8, %6 : f32
    %10 = arith.mulf %1, %4 : f32
    %11 = arith.subf %10, %0 : f32
    %12 = arith.divf %11, %6 : f32
    %13 = arith.divf %3, %2 : f32
    %14 = arith.mulf %13, %3 : f32
    %15 = arith.addf %2, %14 : f32
    %16 = arith.mulf %1, %13 : f32
    %17 = arith.addf %0, %16 : f32
    %18 = arith.divf %17, %15 : f32
    %19 = arith.mulf %0, %13 : f32
    %20 = arith.subf %1, %19 : f32
    %21 = arith.divf %20, %15 : f32
    %cst = arith.constant 0.000000e+00 : f32
    %22 = math.absf %2 : f32
    %23 = arith.cmpf oeq, %22, %cst : f32
    %24 = math.absf %3 : f32
    %25 = arith.cmpf oeq, %24, %cst : f32
    %26 = arith.cmpf ord, %0, %cst : f32
    %27 = arith.cmpf ord, %1, %cst : f32
    %28 = arith.ori %26, %27 : i1
    %29 = arith.andi %23, %25 : i1
    %30 = arith.andi %28, %29 : i1
    %cst_0 = arith.constant 0x7F800000 : f32
    %31 = math.copysign %cst_0, %2 : f32
    %32 = arith.mulf %31, %0 : f32
    %33 = arith.mulf %31, %1 : f32
    %34 = arith.cmpf one, %22, %cst_0 : f32
    %35 = arith.cmpf one, %24, %cst_0 : f32
    %36 = arith.andi %34, %35 : i1
    %37 = math.absf %0 : f32
    %38 = arith.cmpf oeq, %37, %cst_0 : f32
    %39 = math.absf %1 : f32
    %40 = arith.cmpf oeq, %39, %cst_0 : f32
    %41 = arith.ori %38, %40 : i1
    %42 = arith.andi %41, %36 : i1
    %cst_1 = arith.constant 1.000000e+00 : f32
    %43 = arith.select %38, %cst_1, %cst : f32
    %44 = math.copysign %43, %0 : f32
    %45 = arith.select %40, %cst_1, %cst : f32
    %46 = math.copysign %45, %1 : f32
    %47 = arith.mulf %44, %2 : f32
    %48 = arith.mulf %46, %3 : f32
    %49 = arith.addf %47, %48 : f32
    %50 = arith.mulf %cst_0, %49 : f32
    %51 = arith.mulf %44, %3 : f32
    %52 = arith.mulf %46, %2 : f32
    %53 = arith.subf %52, %51 : f32
    %54 = arith.mulf %cst_0, %53 : f32
    %55 = arith.cmpf one, %37, %cst_0 : f32
    %56 = arith.cmpf one, %39, %cst_0 : f32
    %57 = arith.andi %55, %56 : i1
    %58 = arith.cmpf oeq, %22, %cst_0 : f32
    %59 = arith.cmpf oeq, %24, %cst_0 : f32
    %60 = arith.ori %58, %59 : i1
    %61 = arith.andi %57, %60 : i1
    %62 = arith.select %58, %cst_1, %cst : f32
    %63 = math.copysign %62, %2 : f32
    %64 = arith.select %59, %cst_1, %cst : f32
    %65 = math.copysign %64, %3 : f32
    %66 = arith.mulf %0, %63 : f32
    %67 = arith.mulf %1, %65 : f32
    %68 = arith.addf %66, %67 : f32
    %69 = arith.mulf %cst, %68 : f32
    %70 = arith.mulf %1, %63 : f32
    %71 = arith.mulf %0, %65 : f32
    %72 = arith.subf %70, %71 : f32
    %73 = arith.mulf %cst, %72 : f32
    %74 = arith.cmpf olt, %22, %24 : f32
    %75 = arith.select %74, %9, %18 : f32
    %76 = arith.select %74, %12, %21 : f32
    %77 = arith.select %61, %69, %75 : f32
    %78 = arith.select %61, %73, %76 : f32
    %79 = arith.select %42, %50, %77 : f32
    %80 = arith.select %42, %54, %78 : f32
    %81 = arith.select %30, %32, %79 : f32
    %82 = arith.select %30, %33, %80 : f32
    %83 = arith.cmpf uno, %75, %cst : f32
    %84 = arith.cmpf uno, %76, %cst : f32
    %85 = arith.andi %83, %84 : i1
    %86 = arith.select %85, %81, %75 : f32
    %87 = arith.select %85, %82, %76 : f32
    %88 = complex.create %86, %87 : complex<f32>
    return %88 : complex<f32>
  }
}

// -----
module {
  func.func @complex_eq(%arg0: complex<f32>, %arg1: complex<f32>) -> i1 {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %2 = complex.re %arg1 : complex<f32>
    %3 = complex.im %arg1 : complex<f32>
    %4 = arith.cmpf oeq, %0, %2 : f32
    %5 = arith.cmpf oeq, %1, %3 : f32
    %6 = arith.andi %4, %5 : i1
    return %6 : i1
  }
}

// -----
module {
  func.func @complex_exp(%arg0: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 5.000000e-01 : f32
    %cst_1 = arith.constant 0x7F800000 : f32
    %2 = math.exp %0 : f32
    %3 = arith.mulf %0, %cst_0 : f32
    %4 = math.exp %3 : f32
    %5 = math.cos %1 : f32
    %6 = math.sin %1 : f32
    %7 = arith.cmpf oeq, %2, %cst_1 : f32
    %8 = arith.cmpf oeq, %1, %cst : f32
    %9 = arith.mulf %2, %5 : f32
    %10 = arith.mulf %4, %5 : f32
    %11 = arith.mulf %10, %4 : f32
    %12 = arith.select %7, %11, %9 : f32
    %13 = arith.mulf %2, %6 : f32
    %14 = arith.mulf %4, %6 : f32
    %15 = arith.mulf %14, %4 : f32
    %16 = arith.select %7, %15, %13 : f32
    %17 = arith.select %8, %cst, %16 : f32
    %18 = complex.create %12, %17 : complex<f32>
    return %18 : complex<f32>
  }
}

// -----
module {
  func.func @complex_expm1(%arg0: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %2 = math.expm1 %0 fastmath<nnan,contract> : f32
    %3 = arith.addf %2, %cst_0 fastmath<nnan,contract> : f32
    %4 = math.sin %1 fastmath<nnan,contract> : f32
    %cst_1 = arith.constant -5.000000e-01 : f32
    %cst_2 = arith.constant -1.000000e+00 : f32
    %5 = math.cos %1 fastmath<nnan,contract> : f32
    %6 = arith.addf %5, %cst_2 fastmath<nnan,contract> : f32
    %7 = arith.mulf %1, %1 fastmath<nnan,contract> : f32
    %8 = arith.mulf %7, %7 fastmath<nnan,contract> : f32
    %cst_3 = arith.constant 4.73775072E-14 : f32
    %cst_4 = arith.constant -1.14702848E-11 : f32
    %9 = math.fma %cst_3, %7, %cst_4 fastmath<nnan,contract> : f32
    %cst_5 = arith.constant 2.08767537E-9 : f32
    %10 = math.fma %9, %7, %cst_5 fastmath<nnan,contract> : f32
    %cst_6 = arith.constant -2.755732E-7 : f32
    %11 = math.fma %10, %7, %cst_6 fastmath<nnan,contract> : f32
    %cst_7 = arith.constant 2.48015876E-5 : f32
    %12 = math.fma %11, %7, %cst_7 fastmath<nnan,contract> : f32
    %cst_8 = arith.constant -0.00138888892 : f32
    %13 = math.fma %12, %7, %cst_8 fastmath<nnan,contract> : f32
    %cst_9 = arith.constant 0.0416666679 : f32
    %14 = math.fma %13, %7, %cst_9 fastmath<nnan,contract> : f32
    %15 = arith.mulf %8, %14 fastmath<nnan,contract> : f32
    %16 = arith.mulf %cst_1, %7 fastmath<nnan,contract> : f32
    %17 = arith.addf %15, %16 : f32
    %cst_10 = arith.constant 6.168500e-01 : f32
    %18 = arith.cmpf oge, %7, %cst_10 fastmath<nnan,contract> : f32
    %19 = arith.select %18, %6, %17 : f32
    %20 = arith.addf %19, %cst_0 fastmath<nnan,contract> : f32
    %21 = arith.mulf %2, %20 fastmath<nnan,contract> : f32
    %22 = arith.addf %21, %19 fastmath<nnan,contract> : f32
    %23 = arith.cmpf oeq, %1, %cst fastmath<nnan,contract> : f32
    %24 = arith.mulf %3, %4 fastmath<nnan,contract> : f32
    %25 = arith.select %23, %cst, %24 : f32
    %26 = complex.create %22, %25 : complex<f32>
    return %26 : complex<f32>
  }
}

// -----
module {
  func.func @complex_log(%arg0: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %cst = arith.constant 1.000000e+00 : f32
    %2 = math.absf %0 : f32
    %3 = math.absf %1 : f32
    %4 = arith.maximumf %2, %3 : f32
    %5 = arith.minimumf %2, %3 : f32
    %6 = arith.divf %5, %4 : f32
    %7 = arith.mulf %6, %6 : f32
    %8 = arith.addf %7, %cst : f32
    %9 = math.sqrt %8 : f32
    %10 = arith.mulf %4, %9 : f32
    %11 = arith.cmpf uno, %10, %10 : f32
    %12 = arith.select %11, %5, %10 : f32
    %13 = math.log %12 : f32
    %14 = complex.re %arg0 : complex<f32>
    %15 = complex.im %arg0 : complex<f32>
    %16 = math.atan2 %15, %14 : f32
    %17 = complex.create %13, %16 : complex<f32>
    return %17 : complex<f32>
  }
}

// -----
module {
  func.func @complex_log1p(%arg0: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %cst = arith.constant 5.000000e-01 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %2 = arith.addf %0, %cst_0 : f32
    %3 = math.absf %2 : f32
    %4 = math.absf %1 : f32
    %5 = arith.maximumf %3, %4 : f32
    %6 = arith.minimumf %3, %4 : f32
    %7 = arith.cmpf ogt, %2, %4 : f32
    %8 = arith.subf %5, %cst_0 : f32
    %9 = arith.select %7, %0, %8 : f32
    %10 = arith.divf %6, %5 : f32
    %11 = math.log1p %9 : f32
    %12 = arith.mulf %10, %10 : f32
    %13 = math.log1p %12 : f32
    %14 = arith.mulf %cst, %13 : f32
    %15 = arith.addf %14, %11 : f32
    %16 = arith.cmpf uno, %15, %15 : f32
    %17 = arith.select %16, %6, %15 : f32
    %18 = math.atan2 %1, %2 : f32
    %19 = complex.create %17, %18 : complex<f32>
    return %19 : complex<f32>
  }
}

// -----
module {
  func.func @complex_mul(%arg0: complex<f32>, %arg1: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %2 = complex.re %arg1 : complex<f32>
    %3 = complex.im %arg1 : complex<f32>
    %4 = arith.mulf %0, %2 : f32
    %5 = arith.mulf %1, %3 : f32
    %6 = arith.subf %4, %5 : f32
    %7 = arith.mulf %1, %2 : f32
    %8 = arith.mulf %0, %3 : f32
    %9 = arith.addf %7, %8 : f32
    %10 = complex.create %6, %9 : complex<f32>
    return %10 : complex<f32>
  }
}

// -----
module {
  func.func @complex_neg(%arg0: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %2 = arith.negf %0 : f32
    %3 = arith.negf %1 : f32
    %4 = complex.create %2, %3 : complex<f32>
    return %4 : complex<f32>
  }
}

// -----
module {
  func.func @complex_neq(%arg0: complex<f32>, %arg1: complex<f32>) -> i1 {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %2 = complex.re %arg1 : complex<f32>
    %3 = complex.im %arg1 : complex<f32>
    %4 = arith.cmpf une, %0, %2 : f32
    %5 = arith.cmpf une, %1, %3 : f32
    %6 = arith.ori %4, %5 : i1
    return %6 : i1
  }
}

// -----
module {
  func.func @complex_sin(%arg0: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %cst = arith.constant 5.000000e-01 : f32
    %2 = math.exp %1 : f32
    %3 = arith.mulf %cst, %2 : f32
    %4 = arith.divf %cst, %2 : f32
    %5 = math.sin %0 : f32
    %6 = math.cos %0 : f32
    %7 = arith.addf %3, %4 : f32
    %8 = arith.mulf %7, %5 : f32
    %9 = arith.subf %3, %4 : f32
    %10 = arith.mulf %9, %6 : f32
    %11 = complex.create %8, %10 : complex<f32>
    return %11 : complex<f32>
  }
}

// -----
module {
  func.func @complex_sign(%arg0: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %cst = arith.constant 0.000000e+00 : f32
    %2 = arith.cmpf oeq, %0, %cst : f32
    %3 = arith.cmpf oeq, %1, %cst : f32
    %4 = arith.andi %2, %3 : i1
    %5 = complex.re %arg0 : complex<f32>
    %6 = complex.im %arg0 : complex<f32>
    %cst_0 = arith.constant 1.000000e+00 : f32
    %7 = math.absf %5 : f32
    %8 = math.absf %6 : f32
    %9 = arith.maximumf %7, %8 : f32
    %10 = arith.minimumf %7, %8 : f32
    %11 = arith.divf %10, %9 : f32
    %12 = arith.mulf %11, %11 : f32
    %13 = arith.addf %12, %cst_0 : f32
    %14 = math.sqrt %13 : f32
    %15 = arith.mulf %9, %14 : f32
    %16 = arith.cmpf uno, %15, %15 : f32
    %17 = arith.select %16, %10, %15 : f32
    %18 = arith.divf %0, %17 : f32
    %19 = arith.divf %1, %17 : f32
    %20 = complex.create %18, %19 : complex<f32>
    %21 = arith.select %4, %arg0, %20 : complex<f32>
    return %21 : complex<f32>
  }
}

// -----
module {
  func.func @complex_sub(%arg0: complex<f32>, %arg1: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.re %arg1 : complex<f32>
    %2 = arith.subf %0, %1 : f32
    %3 = complex.im %arg0 : complex<f32>
    %4 = complex.im %arg1 : complex<f32>
    %5 = arith.subf %3, %4 : f32
    %6 = complex.create %2, %5 : complex<f32>
    return %6 : complex<f32>
  }
}

// -----
module {
  func.func @complex_tan(%arg0: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %cst = arith.constant -1.000000e+00 : f32
    %2 = arith.mulf %1, %cst : f32
    %cst_0 = arith.constant 0x7F800000 : f32
    %cst_1 = arith.constant 4.000000e+00 : f32
    %3 = arith.addf %2, %2 : f32
    %4 = arith.mulf %cst, %3 : f32
    %5 = math.expm1 %3 : f32
    %6 = math.expm1 %4 : f32
    %7 = arith.subf %5, %6 : f32
    %8 = math.cos %0 : f32
    %9 = arith.mulf %8, %8 : f32
    %10 = arith.mulf %9, %cst_1 : f32
    %11 = math.sin %0 : f32
    %12 = arith.mulf %8, %11 : f32
    %13 = arith.mulf %cst_1, %12 : f32
    %14 = arith.addf %5, %6 : f32
    %15 = arith.addf %14, %10 : f32
    %16 = arith.cmpf oeq, %14, %cst_0 : f32
    %17 = math.copysign %cst, %2 : f32
    %18 = arith.divf %7, %15 : f32
    %19 = arith.select %16, %17, %18 : f32
    %20 = arith.divf %13, %15 : f32
    %21 = math.absf %2 : f32
    %cst_2 = arith.constant 0.000000e+00 : f32
    %cst_3 = arith.constant 0x7FC00000 : f32
    %22 = arith.cmpf oeq, %21, %cst_0 : f32
    %23 = arith.cmpf oeq, %0, %cst_2 : f32
    %true = arith.constant true
    %24 = arith.xori %22, %true : i1
    %25 = arith.cmpf uno, %13, %13 : f32
    %26 = arith.andi %25, %24 : i1
    %27 = arith.andi %22, %25 : i1
    %28 = arith.ori %23, %27 : i1
    %29 = arith.select %26, %cst_3, %19 : f32
    %30 = arith.select %28, %cst_2, %20 : f32
    %31 = arith.mulf %29, %cst : f32
    %32 = complex.create %30, %31 : complex<f32>
    return %32 : complex<f32>
  }
}

// -----
module {
  func.func @complex_tanh(%arg0: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %cst = arith.constant -1.000000e+00 : f32
    %cst_0 = arith.constant 0x7F800000 : f32
    %cst_1 = arith.constant 4.000000e+00 : f32
    %2 = arith.addf %0, %0 : f32
    %3 = arith.mulf %cst, %2 : f32
    %4 = math.expm1 %2 : f32
    %5 = math.expm1 %3 : f32
    %6 = arith.subf %4, %5 : f32
    %7 = math.cos %1 : f32
    %8 = arith.mulf %7, %7 : f32
    %9 = arith.mulf %8, %cst_1 : f32
    %10 = math.sin %1 : f32
    %11 = arith.mulf %7, %10 : f32
    %12 = arith.mulf %cst_1, %11 : f32
    %13 = arith.addf %4, %5 : f32
    %14 = arith.addf %13, %9 : f32
    %15 = arith.cmpf oeq, %13, %cst_0 : f32
    %16 = math.copysign %cst, %0 : f32
    %17 = arith.divf %6, %14 : f32
    %18 = arith.select %15, %16, %17 : f32
    %19 = arith.divf %12, %14 : f32
    %20 = math.absf %0 : f32
    %cst_2 = arith.constant 0.000000e+00 : f32
    %cst_3 = arith.constant 0x7FC00000 : f32
    %21 = arith.cmpf oeq, %20, %cst_0 : f32
    %22 = arith.cmpf oeq, %1, %cst_2 : f32
    %true = arith.constant true
    %23 = arith.xori %21, %true : i1
    %24 = arith.cmpf uno, %12, %12 : f32
    %25 = arith.andi %24, %23 : i1
    %26 = arith.andi %21, %24 : i1
    %27 = arith.ori %22, %26 : i1
    %28 = arith.select %25, %cst_3, %18 : f32
    %29 = arith.select %27, %cst_2, %19 : f32
    %30 = complex.create %28, %29 : complex<f32>
    return %30 : complex<f32>
  }
}

// -----
module {
  func.func @complex_sqrt(%arg0: complex<f32>) -> complex<f32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 5.000000e-01 : f32
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %cst_1 = arith.constant 1.000000e+00 : f32
    %2 = math.absf %0 : f32
    %3 = math.absf %1 : f32
    %4 = arith.maximumf %2, %3 : f32
    %5 = arith.minimumf %2, %3 : f32
    %6 = arith.divf %5, %4 : f32
    %7 = arith.mulf %6, %6 : f32
    %8 = arith.addf %7, %cst_1 : f32
    %cst_2 = arith.constant 2.500000e-01 : f32
    %9 = math.sqrt %4 : f32
    %10 = math.powf %8, %cst_2 : f32
    %11 = arith.mulf %9, %10 : f32
    %12 = arith.cmpf uno, %11, %11 : f32
    %13 = arith.select %12, %5, %11 : f32
    %14 = math.atan2 %1, %0 : f32
    %15 = arith.mulf %14, %cst_0 : f32
    %16 = math.cos %15 : f32
    %17 = math.sin %15 : f32
    %18 = arith.cmpf oeq, %17, %cst : f32
    %19 = arith.mulf %13, %16 : f32
    %20 = arith.mulf %13, %17 : f32
    %21 = arith.select %18, %cst, %20 : f32
    %cst_3 = arith.constant 0x7F800000 : f32
    %cst_4 = arith.constant 0xFF800000 : f32
    %cst_5 = arith.constant 0x7FC00000 : f32
    %22 = math.absf %1 : f32
    %23 = arith.cmpf oeq, %22, %cst_3 : f32
    %24 = arith.cmpf one, %22, %cst_3 : f32
    %25 = arith.cmpf oeq, %0, %cst_3 : f32
    %26 = arith.cmpf oeq, %0, %cst_4 : f32
    %27 = arith.andi %26, %24 : i1
    %28 = arith.select %27, %cst, %19 : f32
    %29 = arith.ori %23, %25 : i1
    %30 = arith.select %29, %cst_3, %28 : f32
    %31 = math.copysign %cst_3, %1 : f32
    %32 = arith.cmpf uno, %13, %13 : f32
    %33 = arith.select %32, %cst_5, %21 : f32
    %34 = arith.ori %23, %26 : i1
    %35 = arith.select %34, %31, %33 : f32
    %36 = arith.cmpf oeq, %13, %cst : f32
    %37 = arith.select %36, %cst, %30 : f32
    %38 = arith.select %36, %cst, %35 : f32
    %39 = complex.create %37, %38 : complex<f32>
    return %39 : complex<f32>
  }
}

// -----
module {
  func.func @complex_sqrt_nnan_ninf(%arg0: complex<f32>) -> complex<f32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 5.000000e-01 : f32
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %cst_1 = arith.constant 1.000000e+00 : f32
    %2 = math.absf %0 fastmath<nnan,ninf> : f32
    %3 = math.absf %1 fastmath<nnan,ninf> : f32
    %4 = arith.maximumf %2, %3 fastmath<nnan,ninf> : f32
    %5 = arith.minimumf %2, %3 fastmath<nnan,ninf> : f32
    %6 = arith.divf %5, %4 : f32
    %7 = arith.mulf %6, %6 : f32
    %8 = arith.addf %7, %cst_1 : f32
    %cst_2 = arith.constant 2.500000e-01 : f32
    %9 = math.sqrt %4 : f32
    %10 = math.powf %8, %cst_2 : f32
    %11 = arith.mulf %9, %10 : f32
    %12 = arith.cmpf uno, %11, %11 : f32
    %13 = arith.select %12, %5, %11 : f32
    %14 = math.atan2 %1, %0 fastmath<nnan,ninf> : f32
    %15 = arith.mulf %14, %cst_0 fastmath<nnan,ninf> : f32
    %16 = math.cos %15 fastmath<nnan,ninf> : f32
    %17 = math.sin %15 fastmath<nnan,ninf> : f32
    %18 = arith.cmpf oeq, %17, %cst fastmath<nnan,ninf> : f32
    %19 = arith.mulf %13, %16 fastmath<nnan,ninf> : f32
    %20 = arith.mulf %13, %17 fastmath<nnan,ninf> : f32
    %21 = arith.select %18, %cst, %20 : f32
    %22 = arith.cmpf oeq, %13, %cst fastmath<nnan,ninf> : f32
    %23 = arith.select %22, %cst, %19 : f32
    %24 = arith.select %22, %cst, %21 : f32
    %25 = complex.create %23, %24 : complex<f32>
    return %25 : complex<f32>
  }
}

// -----
module {
  func.func @complex_conj(%arg0: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %2 = arith.negf %1 : f32
    %3 = complex.create %0, %2 : complex<f32>
    return %3 : complex<f32>
  }
}

// -----
module {
  func.func @complex_pow(%arg0: complex<f32>, %arg1: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg1 : complex<f32>
    %1 = complex.im %arg1 : complex<f32>
    %2 = complex.re %arg0 : complex<f32>
    %3 = complex.im %arg0 : complex<f32>
    %4 = complex.re %arg0 : complex<f32>
    %5 = complex.im %arg0 : complex<f32>
    %cst = arith.constant 1.000000e+00 : f32
    %6 = math.absf %4 : f32
    %7 = math.absf %5 : f32
    %8 = arith.maximumf %6, %7 : f32
    %9 = arith.minimumf %6, %7 : f32
    %10 = arith.divf %9, %8 : f32
    %11 = arith.mulf %10, %10 : f32
    %12 = arith.addf %11, %cst : f32
    %13 = math.sqrt %12 : f32
    %14 = arith.mulf %8, %13 : f32
    %15 = arith.cmpf uno, %14, %14 : f32
    %16 = arith.select %15, %9, %14 : f32
    %17 = math.powf %16, %0 : f32
    %18 = arith.negf %1 : f32
    %19 = math.atan2 %3, %2 : f32
    %20 = arith.mulf %18, %19 : f32
    %21 = math.exp %20 : f32
    %22 = arith.mulf %17, %21 : f32
    %23 = math.log %16 : f32
    %24 = arith.mulf %0, %19 : f32
    %25 = arith.mulf %1, %23 : f32
    %26 = arith.addf %24, %25 : f32
    %27 = math.cos %26 : f32
    %28 = math.sin %26 : f32
    %cst_0 = arith.constant 0x7F800000 : f32
    %cst_1 = arith.constant 0.000000e+00 : f32
    %cst_2 = arith.constant 1.000000e+00 : f32
    %29 = complex.create %cst_2, %cst_1 : complex<f32>
    %30 = complex.create %cst_1, %cst_1 : complex<f32>
    %31 = complex.create %cst_0, %cst_1 : complex<f32>
    %32 = arith.cmpf oeq, %16, %cst_1 : f32
    %33 = arith.cmpf oeq, %1, %cst_1 : f32
    %34 = arith.cmpf oeq, %0, %cst_1 : f32
    %35 = arith.cmpf oeq, %3, %cst_1 : f32
    %36 = arith.cmpf ole, %cst_1, %0 : f32
    %37 = arith.mulf %22, %27 : f32
    %38 = arith.mulf %22, %28 : f32
    %39 = arith.select %34, %29, %30 : complex<f32>
    %40 = complex.create %37, %38 : complex<f32>
    %41 = arith.andi %32, %33 : i1
    %42 = arith.andi %41, %36 : i1
    %43 = arith.select %42, %39, %40 : complex<f32>
    %44 = arith.andi %34, %33 : i1
    %45 = arith.select %44, %29, %43 : complex<f32>
    %46 = arith.cmpf oeq, %2, %cst_2 : f32
    %47 = arith.andi %46, %35 : i1
    %48 = arith.select %47, %29, %45 : complex<f32>
    %49 = arith.cmpf oeq, %2, %cst_0 : f32
    %50 = arith.andi %49, %35 : i1
    %51 = arith.cmpf ogt, %0, %cst_1 : f32
    %52 = arith.andi %33, %51 : i1
    %53 = arith.andi %50, %52 : i1
    %54 = arith.select %53, %31, %48 : complex<f32>
    %55 = arith.cmpf olt, %0, %cst_1 : f32
    %56 = arith.andi %33, %55 : i1
    %57 = arith.andi %50, %56 : i1
    %58 = arith.select %57, %30, %54 : complex<f32>
    return %58 : complex<f32>
  }
}

// -----
module {
  func.func @complex_pow_with_fmf(%arg0: complex<f32>, %arg1: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg1 : complex<f32>
    %1 = complex.im %arg1 : complex<f32>
    %2 = complex.re %arg0 : complex<f32>
    %3 = complex.im %arg0 : complex<f32>
    %4 = complex.re %arg0 : complex<f32>
    %5 = complex.im %arg0 : complex<f32>
    %cst = arith.constant 1.000000e+00 : f32
    %6 = math.absf %4 fastmath<nnan,contract> : f32
    %7 = math.absf %5 fastmath<nnan,contract> : f32
    %8 = arith.maximumf %6, %7 fastmath<nnan,contract> : f32
    %9 = arith.minimumf %6, %7 fastmath<nnan,contract> : f32
    %10 = arith.divf %9, %8 fastmath<contract> : f32
    %11 = arith.mulf %10, %10 fastmath<contract> : f32
    %12 = arith.addf %11, %cst fastmath<contract> : f32
    %13 = math.sqrt %12 fastmath<contract> : f32
    %14 = arith.mulf %8, %13 fastmath<contract> : f32
    %15 = arith.cmpf uno, %14, %14 fastmath<contract> : f32
    %16 = arith.select %15, %9, %14 : f32
    %17 = math.powf %16, %0 fastmath<nnan,contract> : f32
    %18 = arith.negf %1 fastmath<nnan,contract> : f32
    %19 = math.atan2 %3, %2 fastmath<nnan,contract> : f32
    %20 = arith.mulf %18, %19 fastmath<nnan,contract> : f32
    %21 = math.exp %20 fastmath<nnan,contract> : f32
    %22 = arith.mulf %17, %21 fastmath<nnan,contract> : f32
    %23 = math.log %16 fastmath<nnan,contract> : f32
    %24 = arith.mulf %0, %19 fastmath<nnan,contract> : f32
    %25 = arith.mulf %1, %23 fastmath<nnan,contract> : f32
    %26 = arith.addf %24, %25 fastmath<nnan,contract> : f32
    %27 = math.cos %26 fastmath<nnan,contract> : f32
    %28 = math.sin %26 fastmath<nnan,contract> : f32
    %cst_0 = arith.constant 0x7F800000 : f32
    %cst_1 = arith.constant 0.000000e+00 : f32
    %cst_2 = arith.constant 1.000000e+00 : f32
    %29 = complex.create %cst_2, %cst_1 : complex<f32>
    %30 = complex.create %cst_1, %cst_1 : complex<f32>
    %31 = complex.create %cst_0, %cst_1 : complex<f32>
    %32 = arith.cmpf oeq, %16, %cst_1 fastmath<nnan,contract> : f32
    %33 = arith.cmpf oeq, %1, %cst_1 fastmath<nnan,contract> : f32
    %34 = arith.cmpf oeq, %0, %cst_1 fastmath<nnan,contract> : f32
    %35 = arith.cmpf oeq, %3, %cst_1 fastmath<nnan,contract> : f32
    %36 = arith.cmpf ole, %cst_1, %0 fastmath<nnan,contract> : f32
    %37 = arith.mulf %22, %27 fastmath<nnan,contract> : f32
    %38 = arith.mulf %22, %28 fastmath<nnan,contract> : f32
    %39 = arith.select %34, %29, %30 : complex<f32>
    %40 = complex.create %37, %38 : complex<f32>
    %41 = arith.andi %32, %33 : i1
    %42 = arith.andi %41, %36 : i1
    %43 = arith.select %42, %39, %40 : complex<f32>
    %44 = arith.andi %34, %33 : i1
    %45 = arith.select %44, %29, %43 : complex<f32>
    %46 = arith.cmpf oeq, %2, %cst_2 fastmath<nnan,contract> : f32
    %47 = arith.andi %46, %35 : i1
    %48 = arith.select %47, %29, %45 : complex<f32>
    %49 = arith.cmpf oeq, %2, %cst_0 fastmath<nnan,contract> : f32
    %50 = arith.andi %49, %35 : i1
    %51 = arith.cmpf ogt, %0, %cst_1 fastmath<nnan,contract> : f32
    %52 = arith.andi %33, %51 : i1
    %53 = arith.andi %50, %52 : i1
    %54 = arith.select %53, %31, %48 : complex<f32>
    %55 = arith.cmpf olt, %0, %cst_1 fastmath<nnan,contract> : f32
    %56 = arith.andi %33, %55 : i1
    %57 = arith.andi %50, %56 : i1
    %58 = arith.select %57, %30, %54 : complex<f32>
    return %58 : complex<f32>
  }
}

// -----
module {
  func.func @complex_powi(%arg0: complex<f32>, %arg1: i32) -> complex<f32> {
    %0 = arith.sitofp %arg1 : i32 to f32
    %cst = arith.constant 0.000000e+00 : f32
    %1 = complex.create %0, %cst : complex<f32>
    %2 = complex.re %1 : complex<f32>
    %3 = complex.im %1 : complex<f32>
    %4 = complex.re %arg0 : complex<f32>
    %5 = complex.im %arg0 : complex<f32>
    %6 = complex.re %arg0 : complex<f32>
    %7 = complex.im %arg0 : complex<f32>
    %cst_0 = arith.constant 1.000000e+00 : f32
    %8 = math.absf %6 : f32
    %9 = math.absf %7 : f32
    %10 = arith.maximumf %8, %9 : f32
    %11 = arith.minimumf %8, %9 : f32
    %12 = arith.divf %11, %10 : f32
    %13 = arith.mulf %12, %12 : f32
    %14 = arith.addf %13, %cst_0 : f32
    %15 = math.sqrt %14 : f32
    %16 = arith.mulf %10, %15 : f32
    %17 = arith.cmpf uno, %16, %16 : f32
    %18 = arith.select %17, %11, %16 : f32
    %19 = math.powf %18, %2 : f32
    %20 = arith.negf %3 : f32
    %21 = math.atan2 %5, %4 : f32
    %22 = arith.mulf %20, %21 : f32
    %23 = math.exp %22 : f32
    %24 = arith.mulf %19, %23 : f32
    %25 = math.log %18 : f32
    %26 = arith.mulf %2, %21 : f32
    %27 = arith.mulf %3, %25 : f32
    %28 = arith.addf %26, %27 : f32
    %29 = math.cos %28 : f32
    %30 = math.sin %28 : f32
    %cst_1 = arith.constant 0x7F800000 : f32
    %cst_2 = arith.constant 0.000000e+00 : f32
    %cst_3 = arith.constant 1.000000e+00 : f32
    %31 = complex.create %cst_3, %cst_2 : complex<f32>
    %32 = complex.create %cst_2, %cst_2 : complex<f32>
    %33 = complex.create %cst_1, %cst_2 : complex<f32>
    %34 = arith.cmpf oeq, %18, %cst_2 : f32
    %35 = arith.cmpf oeq, %3, %cst_2 : f32
    %36 = arith.cmpf oeq, %2, %cst_2 : f32
    %37 = arith.cmpf oeq, %5, %cst_2 : f32
    %38 = arith.cmpf ole, %cst_2, %2 : f32
    %39 = arith.mulf %24, %29 : f32
    %40 = arith.mulf %24, %30 : f32
    %41 = arith.select %36, %31, %32 : complex<f32>
    %42 = complex.create %39, %40 : complex<f32>
    %43 = arith.andi %34, %35 : i1
    %44 = arith.andi %43, %38 : i1
    %45 = arith.select %44, %41, %42 : complex<f32>
    %46 = arith.andi %36, %35 : i1
    %47 = arith.select %46, %31, %45 : complex<f32>
    %48 = arith.cmpf oeq, %4, %cst_3 : f32
    %49 = arith.andi %48, %37 : i1
    %50 = arith.select %49, %31, %47 : complex<f32>
    %51 = arith.cmpf oeq, %4, %cst_1 : f32
    %52 = arith.andi %51, %37 : i1
    %53 = arith.cmpf ogt, %2, %cst_2 : f32
    %54 = arith.andi %35, %53 : i1
    %55 = arith.andi %52, %54 : i1
    %56 = arith.select %55, %33, %50 : complex<f32>
    %57 = arith.cmpf olt, %2, %cst_2 : f32
    %58 = arith.andi %35, %57 : i1
    %59 = arith.andi %52, %58 : i1
    %60 = arith.select %59, %32, %56 : complex<f32>
    return %60 : complex<f32>
  }
}

// -----
module {
  func.func @complex_powi_with_fmf(%arg0: complex<f32>, %arg1: i32) -> complex<f32> {
    %0 = arith.sitofp %arg1 : i32 to f32
    %cst = arith.constant 0.000000e+00 : f32
    %1 = complex.create %0, %cst : complex<f32>
    %2 = complex.re %1 : complex<f32>
    %3 = complex.im %1 : complex<f32>
    %4 = complex.re %arg0 : complex<f32>
    %5 = complex.im %arg0 : complex<f32>
    %6 = complex.re %arg0 : complex<f32>
    %7 = complex.im %arg0 : complex<f32>
    %cst_0 = arith.constant 1.000000e+00 : f32
    %8 = math.absf %6 fastmath<nnan,contract> : f32
    %9 = math.absf %7 fastmath<nnan,contract> : f32
    %10 = arith.maximumf %8, %9 fastmath<nnan,contract> : f32
    %11 = arith.minimumf %8, %9 fastmath<nnan,contract> : f32
    %12 = arith.divf %11, %10 fastmath<contract> : f32
    %13 = arith.mulf %12, %12 fastmath<contract> : f32
    %14 = arith.addf %13, %cst_0 fastmath<contract> : f32
    %15 = math.sqrt %14 fastmath<contract> : f32
    %16 = arith.mulf %10, %15 fastmath<contract> : f32
    %17 = arith.cmpf uno, %16, %16 fastmath<contract> : f32
    %18 = arith.select %17, %11, %16 : f32
    %19 = math.powf %18, %2 fastmath<nnan,contract> : f32
    %20 = arith.negf %3 fastmath<nnan,contract> : f32
    %21 = math.atan2 %5, %4 fastmath<nnan,contract> : f32
    %22 = arith.mulf %20, %21 fastmath<nnan,contract> : f32
    %23 = math.exp %22 fastmath<nnan,contract> : f32
    %24 = arith.mulf %19, %23 fastmath<nnan,contract> : f32
    %25 = math.log %18 fastmath<nnan,contract> : f32
    %26 = arith.mulf %2, %21 fastmath<nnan,contract> : f32
    %27 = arith.mulf %3, %25 fastmath<nnan,contract> : f32
    %28 = arith.addf %26, %27 fastmath<nnan,contract> : f32
    %29 = math.cos %28 fastmath<nnan,contract> : f32
    %30 = math.sin %28 fastmath<nnan,contract> : f32
    %cst_1 = arith.constant 0x7F800000 : f32
    %cst_2 = arith.constant 0.000000e+00 : f32
    %cst_3 = arith.constant 1.000000e+00 : f32
    %31 = complex.create %cst_3, %cst_2 : complex<f32>
    %32 = complex.create %cst_2, %cst_2 : complex<f32>
    %33 = complex.create %cst_1, %cst_2 : complex<f32>
    %34 = arith.cmpf oeq, %18, %cst_2 fastmath<nnan,contract> : f32
    %35 = arith.cmpf oeq, %3, %cst_2 fastmath<nnan,contract> : f32
    %36 = arith.cmpf oeq, %2, %cst_2 fastmath<nnan,contract> : f32
    %37 = arith.cmpf oeq, %5, %cst_2 fastmath<nnan,contract> : f32
    %38 = arith.cmpf ole, %cst_2, %2 fastmath<nnan,contract> : f32
    %39 = arith.mulf %24, %29 fastmath<nnan,contract> : f32
    %40 = arith.mulf %24, %30 fastmath<nnan,contract> : f32
    %41 = arith.select %36, %31, %32 : complex<f32>
    %42 = complex.create %39, %40 : complex<f32>
    %43 = arith.andi %34, %35 : i1
    %44 = arith.andi %43, %38 : i1
    %45 = arith.select %44, %41, %42 : complex<f32>
    %46 = arith.andi %36, %35 : i1
    %47 = arith.select %46, %31, %45 : complex<f32>
    %48 = arith.cmpf oeq, %4, %cst_3 fastmath<nnan,contract> : f32
    %49 = arith.andi %48, %37 : i1
    %50 = arith.select %49, %31, %47 : complex<f32>
    %51 = arith.cmpf oeq, %4, %cst_1 fastmath<nnan,contract> : f32
    %52 = arith.andi %51, %37 : i1
    %53 = arith.cmpf ogt, %2, %cst_2 fastmath<nnan,contract> : f32
    %54 = arith.andi %35, %53 : i1
    %55 = arith.andi %52, %54 : i1
    %56 = arith.select %55, %33, %50 : complex<f32>
    %57 = arith.cmpf olt, %2, %cst_2 fastmath<nnan,contract> : f32
    %58 = arith.andi %35, %57 : i1
    %59 = arith.andi %52, %58 : i1
    %60 = arith.select %59, %32, %56 : complex<f32>
    return %60 : complex<f32>
  }
}

// -----
module {
  func.func @complex_rsqrt(%arg0: complex<f32>) -> complex<f32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 0x7F800000 : f32
    %cst_1 = arith.constant -5.000000e-01 : f32
    %cst_2 = arith.constant 0x7FC00000 : f32
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %cst_3 = arith.constant 1.000000e+00 : f32
    %2 = math.absf %0 : f32
    %3 = math.absf %1 : f32
    %4 = arith.maximumf %2, %3 : f32
    %5 = arith.minimumf %2, %3 : f32
    %6 = arith.divf %5, %4 : f32
    %7 = arith.mulf %6, %6 : f32
    %8 = arith.addf %7, %cst_3 : f32
    %9 = math.rsqrt %8 : f32
    %10 = math.rsqrt %5 : f32
    %11 = math.rsqrt %4 : f32
    %12 = math.sqrt %9 : f32
    %13 = arith.mulf %11, %12 : f32
    %14 = arith.cmpf uno, %13, %13 : f32
    %15 = arith.select %14, %10, %13 : f32
    %16 = math.atan2 %1, %0 : f32
    %17 = arith.mulf %16, %cst_1 : f32
    %18 = math.cos %17 : f32
    %19 = math.sin %17 : f32
    %20 = arith.mulf %15, %18 : f32
    %21 = arith.mulf %15, %19 : f32
    %cst_4 = arith.constant -1.000000e+00 : f32
    %22 = math.copysign %cst, %0 : f32
    %23 = math.copysign %cst, %1 : f32
    %24 = arith.mulf %cst_4, %23 : f32
    %25 = math.absf %0 : f32
    %26 = math.absf %1 : f32
    %27 = arith.cmpf oeq, %26, %cst_0 : f32
    %28 = arith.cmpf uno, %0, %0 : f32
    %29 = arith.cmpf oeq, %25, %cst_0 : f32
    %30 = arith.andi %27, %28 : i1
    %31 = arith.ori %30, %29 : i1
    %32 = arith.select %31, %22, %20 : f32
    %33 = arith.select %31, %24, %21 : f32
    %34 = arith.cmpf oeq, %0, %cst : f32
    %35 = arith.cmpf oeq, %1, %cst : f32
    %36 = arith.andi %34, %35 : i1
    %37 = arith.select %36, %cst_0, %32 : f32
    %38 = arith.select %36, %cst_2, %33 : f32
    %39 = complex.create %37, %38 : complex<f32>
    return %39 : complex<f32>
  }
}

// -----
module {
  func.func @complex_rsqrt_nnan_ninf(%arg0: complex<f32>) -> complex<f32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 0x7F800000 : f32
    %cst_1 = arith.constant -5.000000e-01 : f32
    %cst_2 = arith.constant 0x7FC00000 : f32
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %cst_3 = arith.constant 1.000000e+00 : f32
    %2 = math.absf %0 fastmath<nnan,ninf> : f32
    %3 = math.absf %1 fastmath<nnan,ninf> : f32
    %4 = arith.maximumf %2, %3 fastmath<nnan,ninf> : f32
    %5 = arith.minimumf %2, %3 fastmath<nnan,ninf> : f32
    %6 = arith.divf %5, %4 : f32
    %7 = arith.mulf %6, %6 : f32
    %8 = arith.addf %7, %cst_3 : f32
    %9 = math.rsqrt %8 : f32
    %10 = math.rsqrt %5 : f32
    %11 = math.rsqrt %4 : f32
    %12 = math.sqrt %9 : f32
    %13 = arith.mulf %11, %12 : f32
    %14 = arith.cmpf uno, %13, %13 : f32
    %15 = arith.select %14, %10, %13 : f32
    %16 = math.atan2 %1, %0 fastmath<nnan,ninf> : f32
    %17 = arith.mulf %16, %cst_1 fastmath<nnan,ninf> : f32
    %18 = math.cos %17 fastmath<nnan,ninf> : f32
    %19 = math.sin %17 fastmath<nnan,ninf> : f32
    %20 = arith.mulf %15, %18 fastmath<nnan,ninf> : f32
    %21 = arith.mulf %15, %19 fastmath<nnan,ninf> : f32
    %22 = arith.cmpf oeq, %0, %cst fastmath<nnan,ninf> : f32
    %23 = arith.cmpf oeq, %1, %cst fastmath<nnan,ninf> : f32
    %24 = arith.andi %22, %23 : i1
    %25 = arith.select %24, %cst_0, %20 : f32
    %26 = arith.select %24, %cst_2, %21 : f32
    %27 = complex.create %25, %26 : complex<f32>
    return %27 : complex<f32>
  }
}

// -----
module {
  func.func @complex_angle(%arg0: complex<f32>) -> f32 {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %2 = math.atan2 %1, %0 : f32
    return %2 : f32
  }
}

// -----
module {
  func.func @complex_abs_with_fmf(%arg0: complex<f32>) -> f32 {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %cst = arith.constant 1.000000e+00 : f32
    %2 = math.absf %0 fastmath<nnan,contract> : f32
    %3 = math.absf %1 fastmath<nnan,contract> : f32
    %4 = arith.maximumf %2, %3 fastmath<nnan,contract> : f32
    %5 = arith.minimumf %2, %3 fastmath<nnan,contract> : f32
    %6 = arith.divf %5, %4 fastmath<contract> : f32
    %7 = arith.mulf %6, %6 fastmath<contract> : f32
    %8 = arith.addf %7, %cst fastmath<contract> : f32
    %9 = math.sqrt %8 fastmath<contract> : f32
    %10 = arith.mulf %4, %9 fastmath<contract> : f32
    %11 = arith.cmpf uno, %10, %10 fastmath<contract> : f32
    %12 = arith.select %11, %5, %10 : f32
    return %12 : f32
  }
}

// -----
module {
  func.func @complex_add_with_fmf(%arg0: complex<f32>, %arg1: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.re %arg1 : complex<f32>
    %2 = arith.addf %0, %1 fastmath<nnan,contract> : f32
    %3 = complex.im %arg0 : complex<f32>
    %4 = complex.im %arg1 : complex<f32>
    %5 = arith.addf %3, %4 fastmath<nnan,contract> : f32
    %6 = complex.create %2, %5 : complex<f32>
    return %6 : complex<f32>
  }
}

// -----
module {
  func.func @complex_sub_with_fmf(%arg0: complex<f32>, %arg1: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.re %arg1 : complex<f32>
    %2 = arith.subf %0, %1 fastmath<nnan,contract> : f32
    %3 = complex.im %arg0 : complex<f32>
    %4 = complex.im %arg1 : complex<f32>
    %5 = arith.subf %3, %4 fastmath<nnan,contract> : f32
    %6 = complex.create %2, %5 : complex<f32>
    return %6 : complex<f32>
  }
}

// -----
module {
  func.func @complex_exp_with_fmf(%arg0: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 5.000000e-01 : f32
    %cst_1 = arith.constant 0x7F800000 : f32
    %2 = math.exp %0 fastmath<nnan,contract> : f32
    %3 = arith.mulf %0, %cst_0 fastmath<nnan,contract> : f32
    %4 = math.exp %3 fastmath<nnan,contract> : f32
    %5 = math.cos %1 fastmath<nnan,contract> : f32
    %6 = math.sin %1 fastmath<nnan,contract> : f32
    %7 = arith.cmpf oeq, %2, %cst_1 fastmath<nnan,contract> : f32
    %8 = arith.cmpf oeq, %1, %cst : f32
    %9 = arith.mulf %2, %5 fastmath<nnan,contract> : f32
    %10 = arith.mulf %4, %5 fastmath<nnan,contract> : f32
    %11 = arith.mulf %10, %4 fastmath<nnan,contract> : f32
    %12 = arith.select %7, %11, %9 : f32
    %13 = arith.mulf %2, %6 fastmath<nnan,contract> : f32
    %14 = arith.mulf %4, %6 fastmath<nnan,contract> : f32
    %15 = arith.mulf %14, %4 fastmath<nnan,contract> : f32
    %16 = arith.select %7, %15, %13 : f32
    %17 = arith.select %8, %cst, %16 : f32
    %18 = complex.create %12, %17 : complex<f32>
    return %18 : complex<f32>
  }
}

// -----
module {
  func.func @complex_log_with_fmf(%arg0: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %cst = arith.constant 1.000000e+00 : f32
    %2 = math.absf %0 fastmath<nnan,contract> : f32
    %3 = math.absf %1 fastmath<nnan,contract> : f32
    %4 = arith.maximumf %2, %3 fastmath<nnan,contract> : f32
    %5 = arith.minimumf %2, %3 fastmath<nnan,contract> : f32
    %6 = arith.divf %5, %4 fastmath<contract> : f32
    %7 = arith.mulf %6, %6 fastmath<contract> : f32
    %8 = arith.addf %7, %cst fastmath<contract> : f32
    %9 = math.sqrt %8 fastmath<contract> : f32
    %10 = arith.mulf %4, %9 fastmath<contract> : f32
    %11 = arith.cmpf uno, %10, %10 fastmath<contract> : f32
    %12 = arith.select %11, %5, %10 : f32
    %13 = math.log %12 fastmath<nnan,contract> : f32
    %14 = complex.re %arg0 : complex<f32>
    %15 = complex.im %arg0 : complex<f32>
    %16 = math.atan2 %15, %14 fastmath<nnan,contract> : f32
    %17 = complex.create %13, %16 : complex<f32>
    return %17 : complex<f32>
  }
}

// -----
module {
  func.func @complex_log1p_with_fmf(%arg0: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %cst = arith.constant 5.000000e-01 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %2 = arith.addf %0, %cst_0 fastmath<nnan,contract> : f32
    %3 = math.absf %2 fastmath<nnan,contract> : f32
    %4 = math.absf %1 fastmath<nnan,contract> : f32
    %5 = arith.maximumf %3, %4 fastmath<nnan,contract> : f32
    %6 = arith.minimumf %3, %4 fastmath<nnan,contract> : f32
    %7 = arith.cmpf ogt, %2, %4 fastmath<nnan,contract> : f32
    %8 = arith.subf %5, %cst_0 fastmath<nnan,contract> : f32
    %9 = arith.select %7, %0, %8 : f32
    %10 = arith.divf %6, %5 fastmath<contract> : f32
    %11 = math.log1p %9 fastmath<nnan,contract> : f32
    %12 = arith.mulf %10, %10 fastmath<contract> : f32
    %13 = math.log1p %12 fastmath<contract> : f32
    %14 = arith.mulf %cst, %13 fastmath<contract> : f32
    %15 = arith.addf %14, %11 fastmath<contract> : f32
    %16 = arith.cmpf uno, %15, %15 fastmath<contract> : f32
    %17 = arith.select %16, %6, %15 : f32
    %18 = math.atan2 %1, %2 fastmath<nnan,contract> : f32
    %19 = complex.create %17, %18 : complex<f32>
    return %19 : complex<f32>
  }
}

// -----
module {
  func.func @complex_mul_with_fmf(%arg0: complex<f32>, %arg1: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %2 = complex.re %arg1 : complex<f32>
    %3 = complex.im %arg1 : complex<f32>
    %4 = arith.mulf %0, %2 fastmath<nnan,contract> : f32
    %5 = arith.mulf %1, %3 fastmath<nnan,contract> : f32
    %6 = arith.subf %4, %5 fastmath<nnan,contract> : f32
    %7 = arith.mulf %1, %2 fastmath<nnan,contract> : f32
    %8 = arith.mulf %0, %3 fastmath<nnan,contract> : f32
    %9 = arith.addf %7, %8 fastmath<nnan,contract> : f32
    %10 = complex.create %6, %9 : complex<f32>
    return %10 : complex<f32>
  }
}

// -----
module {
  func.func @complex_atan2_with_fmf(%arg0: complex<f32>, %arg1: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg1 : complex<f32>
    %1 = complex.im %arg1 : complex<f32>
    %2 = complex.re %arg1 : complex<f32>
    %3 = complex.im %arg1 : complex<f32>
    %4 = arith.mulf %0, %2 fastmath<nnan,contract> : f32
    %5 = arith.mulf %1, %3 fastmath<nnan,contract> : f32
    %6 = arith.subf %4, %5 fastmath<nnan,contract> : f32
    %7 = arith.mulf %1, %2 fastmath<nnan,contract> : f32
    %8 = arith.mulf %0, %3 fastmath<nnan,contract> : f32
    %9 = arith.addf %7, %8 fastmath<nnan,contract> : f32
    %10 = complex.create %6, %9 : complex<f32>
    %11 = complex.re %arg0 : complex<f32>
    %12 = complex.im %arg0 : complex<f32>
    %13 = complex.re %arg0 : complex<f32>
    %14 = complex.im %arg0 : complex<f32>
    %15 = arith.mulf %11, %13 fastmath<nnan,contract> : f32
    %16 = arith.mulf %12, %14 fastmath<nnan,contract> : f32
    %17 = arith.subf %15, %16 fastmath<nnan,contract> : f32
    %18 = arith.mulf %12, %13 fastmath<nnan,contract> : f32
    %19 = arith.mulf %11, %14 fastmath<nnan,contract> : f32
    %20 = arith.addf %18, %19 fastmath<nnan,contract> : f32
    %21 = complex.create %17, %20 : complex<f32>
    %22 = complex.re %10 : complex<f32>
    %23 = complex.re %21 : complex<f32>
    %24 = arith.addf %22, %23 fastmath<nnan,contract> : f32
    %25 = complex.im %10 : complex<f32>
    %26 = complex.im %21 : complex<f32>
    %27 = arith.addf %25, %26 fastmath<nnan,contract> : f32
    %28 = complex.create %24, %27 : complex<f32>
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 5.000000e-01 : f32
    %29 = complex.re %28 : complex<f32>
    %30 = complex.im %28 : complex<f32>
    %cst_1 = arith.constant 1.000000e+00 : f32
    %31 = math.absf %29 fastmath<nnan,contract> : f32
    %32 = math.absf %30 fastmath<nnan,contract> : f32
    %33 = arith.maximumf %31, %32 fastmath<nnan,contract> : f32
    %34 = arith.minimumf %31, %32 fastmath<nnan,contract> : f32
    %35 = arith.divf %34, %33 fastmath<contract> : f32
    %36 = arith.mulf %35, %35 fastmath<contract> : f32
    %37 = arith.addf %36, %cst_1 fastmath<contract> : f32
    %cst_2 = arith.constant 2.500000e-01 : f32
    %38 = math.sqrt %33 fastmath<contract> : f32
    %39 = math.powf %37, %cst_2 fastmath<contract> : f32
    %40 = arith.mulf %38, %39 fastmath<contract> : f32
    %41 = arith.cmpf uno, %40, %40 fastmath<contract> : f32
    %42 = arith.select %41, %34, %40 : f32
    %43 = math.atan2 %30, %29 fastmath<nnan,contract> : f32
    %44 = arith.mulf %43, %cst_0 fastmath<nnan,contract> : f32
    %45 = math.cos %44 fastmath<nnan,contract> : f32
    %46 = math.sin %44 fastmath<nnan,contract> : f32
    %47 = arith.cmpf oeq, %46, %cst fastmath<nnan,contract> : f32
    %48 = arith.mulf %42, %45 fastmath<nnan,contract> : f32
    %49 = arith.mulf %42, %46 fastmath<nnan,contract> : f32
    %50 = arith.select %47, %cst, %49 : f32
    %cst_3 = arith.constant 0x7F800000 : f32
    %cst_4 = arith.constant 0xFF800000 : f32
    %cst_5 = arith.constant 0x7FC00000 : f32
    %51 = math.absf %30 fastmath<nnan,contract> : f32
    %52 = arith.cmpf oeq, %51, %cst_3 fastmath<nnan,contract> : f32
    %53 = arith.cmpf one, %51, %cst_3 fastmath<nnan,contract> : f32
    %54 = arith.cmpf oeq, %29, %cst_3 fastmath<nnan,contract> : f32
    %55 = arith.cmpf oeq, %29, %cst_4 fastmath<nnan,contract> : f32
    %56 = arith.andi %55, %53 : i1
    %57 = arith.select %56, %cst, %48 : f32
    %58 = arith.ori %52, %54 : i1
    %59 = arith.select %58, %cst_3, %57 : f32
    %60 = math.copysign %cst_3, %30 fastmath<nnan,contract> : f32
    %61 = arith.cmpf uno, %42, %42 : f32
    %62 = arith.select %61, %cst_5, %50 : f32
    %63 = arith.ori %52, %55 : i1
    %64 = arith.select %63, %60, %62 : f32
    %65 = arith.cmpf oeq, %42, %cst fastmath<nnan,contract> : f32
    %66 = arith.select %65, %cst, %59 : f32
    %67 = arith.select %65, %cst, %64 : f32
    %68 = complex.create %66, %67 : complex<f32>
    %cst_6 = arith.constant 0.000000e+00 : f32
    %cst_7 = arith.constant 1.000000e+00 : f32
    %69 = complex.create %cst_6, %cst_7 : complex<f32>
    %70 = complex.re %69 : complex<f32>
    %71 = complex.im %69 : complex<f32>
    %72 = complex.re %arg0 : complex<f32>
    %73 = complex.im %arg0 : complex<f32>
    %74 = arith.mulf %70, %72 fastmath<nnan,contract> : f32
    %75 = arith.mulf %71, %73 fastmath<nnan,contract> : f32
    %76 = arith.subf %74, %75 fastmath<nnan,contract> : f32
    %77 = arith.mulf %71, %72 fastmath<nnan,contract> : f32
    %78 = arith.mulf %70, %73 fastmath<nnan,contract> : f32
    %79 = arith.addf %77, %78 fastmath<nnan,contract> : f32
    %80 = complex.create %76, %79 : complex<f32>
    %81 = complex.re %arg1 : complex<f32>
    %82 = complex.re %80 : complex<f32>
    %83 = arith.addf %81, %82 fastmath<nnan,contract> : f32
    %84 = complex.im %arg1 : complex<f32>
    %85 = complex.im %80 : complex<f32>
    %86 = arith.addf %84, %85 fastmath<nnan,contract> : f32
    %87 = complex.create %83, %86 : complex<f32>
    %88 = complex.re %87 : complex<f32>
    %89 = complex.im %87 : complex<f32>
    %90 = complex.re %68 : complex<f32>
    %91 = complex.im %68 : complex<f32>
    %92 = arith.divf %90, %91 fastmath<nnan,contract> : f32
    %93 = arith.mulf %92, %90 fastmath<nnan,contract> : f32
    %94 = arith.addf %91, %93 fastmath<nnan,contract> : f32
    %95 = arith.mulf %88, %92 fastmath<nnan,contract> : f32
    %96 = arith.addf %95, %89 fastmath<nnan,contract> : f32
    %97 = arith.divf %96, %94 fastmath<nnan,contract> : f32
    %98 = arith.mulf %89, %92 fastmath<nnan,contract> : f32
    %99 = arith.subf %98, %88 fastmath<nnan,contract> : f32
    %100 = arith.divf %99, %94 fastmath<nnan,contract> : f32
    %101 = arith.divf %91, %90 fastmath<nnan,contract> : f32
    %102 = arith.mulf %101, %91 fastmath<nnan,contract> : f32
    %103 = arith.addf %90, %102 fastmath<nnan,contract> : f32
    %104 = arith.mulf %89, %101 fastmath<nnan,contract> : f32
    %105 = arith.addf %88, %104 fastmath<nnan,contract> : f32
    %106 = arith.divf %105, %103 fastmath<nnan,contract> : f32
    %107 = arith.mulf %88, %101 fastmath<nnan,contract> : f32
    %108 = arith.subf %89, %107 fastmath<nnan,contract> : f32
    %109 = arith.divf %108, %103 fastmath<nnan,contract> : f32
    %cst_8 = arith.constant 0.000000e+00 : f32
    %110 = math.absf %90 fastmath<nnan,contract> : f32
    %111 = arith.cmpf oeq, %110, %cst_8 : f32
    %112 = math.absf %91 fastmath<nnan,contract> : f32
    %113 = arith.cmpf oeq, %112, %cst_8 : f32
    %114 = arith.cmpf ord, %88, %cst_8 : f32
    %115 = arith.cmpf ord, %89, %cst_8 : f32
    %116 = arith.ori %114, %115 : i1
    %117 = arith.andi %111, %113 : i1
    %118 = arith.andi %116, %117 : i1
    %cst_9 = arith.constant 0x7F800000 : f32
    %119 = math.copysign %cst_9, %90 : f32
    %120 = arith.mulf %119, %88 fastmath<nnan,contract> : f32
    %121 = arith.mulf %119, %89 fastmath<nnan,contract> : f32
    %122 = arith.cmpf one, %110, %cst_9 : f32
    %123 = arith.cmpf one, %112, %cst_9 : f32
    %124 = arith.andi %122, %123 : i1
    %125 = math.absf %88 fastmath<nnan,contract> : f32
    %126 = arith.cmpf oeq, %125, %cst_9 : f32
    %127 = math.absf %89 fastmath<nnan,contract> : f32
    %128 = arith.cmpf oeq, %127, %cst_9 : f32
    %129 = arith.ori %126, %128 : i1
    %130 = arith.andi %129, %124 : i1
    %cst_10 = arith.constant 1.000000e+00 : f32
    %131 = arith.select %126, %cst_10, %cst_8 : f32
    %132 = math.copysign %131, %88 : f32
    %133 = arith.select %128, %cst_10, %cst_8 : f32
    %134 = math.copysign %133, %89 : f32
    %135 = arith.mulf %132, %90 fastmath<nnan,contract> : f32
    %136 = arith.mulf %134, %91 fastmath<nnan,contract> : f32
    %137 = arith.addf %135, %136 fastmath<nnan,contract> : f32
    %138 = arith.mulf %cst_9, %137 fastmath<nnan,contract> : f32
    %139 = arith.mulf %132, %91 fastmath<nnan,contract> : f32
    %140 = arith.mulf %134, %90 fastmath<nnan,contract> : f32
    %141 = arith.subf %140, %139 fastmath<nnan,contract> : f32
    %142 = arith.mulf %cst_9, %141 fastmath<nnan,contract> : f32
    %143 = arith.cmpf one, %125, %cst_9 : f32
    %144 = arith.cmpf one, %127, %cst_9 : f32
    %145 = arith.andi %143, %144 : i1
    %146 = arith.cmpf oeq, %110, %cst_9 : f32
    %147 = arith.cmpf oeq, %112, %cst_9 : f32
    %148 = arith.ori %146, %147 : i1
    %149 = arith.andi %145, %148 : i1
    %150 = arith.select %146, %cst_10, %cst_8 : f32
    %151 = math.copysign %150, %90 : f32
    %152 = arith.select %147, %cst_10, %cst_8 : f32
    %153 = math.copysign %152, %91 : f32
    %154 = arith.mulf %88, %151 fastmath<nnan,contract> : f32
    %155 = arith.mulf %89, %153 fastmath<nnan,contract> : f32
    %156 = arith.addf %154, %155 fastmath<nnan,contract> : f32
    %157 = arith.mulf %cst_8, %156 fastmath<nnan,contract> : f32
    %158 = arith.mulf %89, %151 fastmath<nnan,contract> : f32
    %159 = arith.mulf %88, %153 fastmath<nnan,contract> : f32
    %160 = arith.subf %158, %159 fastmath<nnan,contract> : f32
    %161 = arith.mulf %cst_8, %160 fastmath<nnan,contract> : f32
    %162 = arith.cmpf olt, %110, %112 : f32
    %163 = arith.select %162, %97, %106 : f32
    %164 = arith.select %162, %100, %109 : f32
    %165 = arith.select %149, %157, %163 : f32
    %166 = arith.select %149, %161, %164 : f32
    %167 = arith.select %130, %138, %165 : f32
    %168 = arith.select %130, %142, %166 : f32
    %169 = arith.select %118, %120, %167 : f32
    %170 = arith.select %118, %121, %168 : f32
    %171 = arith.cmpf uno, %163, %cst_8 : f32
    %172 = arith.cmpf uno, %164, %cst_8 : f32
    %173 = arith.andi %171, %172 : i1
    %174 = arith.select %173, %169, %163 : f32
    %175 = arith.select %173, %170, %164 : f32
    %176 = complex.create %174, %175 : complex<f32>
    %177 = complex.re %176 : complex<f32>
    %178 = complex.im %176 : complex<f32>
    %cst_11 = arith.constant 1.000000e+00 : f32
    %179 = math.absf %177 fastmath<nnan,contract> : f32
    %180 = math.absf %178 fastmath<nnan,contract> : f32
    %181 = arith.maximumf %179, %180 fastmath<nnan,contract> : f32
    %182 = arith.minimumf %179, %180 fastmath<nnan,contract> : f32
    %183 = arith.divf %182, %181 fastmath<contract> : f32
    %184 = arith.mulf %183, %183 fastmath<contract> : f32
    %185 = arith.addf %184, %cst_11 fastmath<contract> : f32
    %186 = math.sqrt %185 fastmath<contract> : f32
    %187 = arith.mulf %181, %186 fastmath<contract> : f32
    %188 = arith.cmpf uno, %187, %187 fastmath<contract> : f32
    %189 = arith.select %188, %182, %187 : f32
    %190 = math.log %189 fastmath<nnan,contract> : f32
    %191 = complex.re %176 : complex<f32>
    %192 = complex.im %176 : complex<f32>
    %193 = math.atan2 %192, %191 fastmath<nnan,contract> : f32
    %194 = complex.create %190, %193 : complex<f32>
    %cst_12 = arith.constant -1.000000e+00 : f32
    %195 = complex.create %cst_6, %cst_12 : complex<f32>
    %196 = complex.re %195 : complex<f32>
    %197 = complex.im %195 : complex<f32>
    %198 = complex.re %194 : complex<f32>
    %199 = complex.im %194 : complex<f32>
    %200 = arith.mulf %196, %198 fastmath<nnan,contract> : f32
    %201 = arith.mulf %197, %199 fastmath<nnan,contract> : f32
    %202 = arith.subf %200, %201 fastmath<nnan,contract> : f32
    %203 = arith.mulf %197, %198 fastmath<nnan,contract> : f32
    %204 = arith.mulf %196, %199 fastmath<nnan,contract> : f32
    %205 = arith.addf %203, %204 fastmath<nnan,contract> : f32
    %206 = complex.create %202, %205 : complex<f32>
    return %206 : complex<f32>
  }
}

// -----
module {
  func.func @complex_div_with_fmf(%arg0: complex<f32>, %arg1: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %2 = complex.re %arg1 : complex<f32>
    %3 = complex.im %arg1 : complex<f32>
    %4 = arith.divf %2, %3 fastmath<nnan,contract> : f32
    %5 = arith.mulf %4, %2 fastmath<nnan,contract> : f32
    %6 = arith.addf %3, %5 fastmath<nnan,contract> : f32
    %7 = arith.mulf %0, %4 fastmath<nnan,contract> : f32
    %8 = arith.addf %7, %1 fastmath<nnan,contract> : f32
    %9 = arith.divf %8, %6 fastmath<nnan,contract> : f32
    %10 = arith.mulf %1, %4 fastmath<nnan,contract> : f32
    %11 = arith.subf %10, %0 fastmath<nnan,contract> : f32
    %12 = arith.divf %11, %6 fastmath<nnan,contract> : f32
    %13 = arith.divf %3, %2 fastmath<nnan,contract> : f32
    %14 = arith.mulf %13, %3 fastmath<nnan,contract> : f32
    %15 = arith.addf %2, %14 fastmath<nnan,contract> : f32
    %16 = arith.mulf %1, %13 fastmath<nnan,contract> : f32
    %17 = arith.addf %0, %16 fastmath<nnan,contract> : f32
    %18 = arith.divf %17, %15 fastmath<nnan,contract> : f32
    %19 = arith.mulf %0, %13 fastmath<nnan,contract> : f32
    %20 = arith.subf %1, %19 fastmath<nnan,contract> : f32
    %21 = arith.divf %20, %15 fastmath<nnan,contract> : f32
    %cst = arith.constant 0.000000e+00 : f32
    %22 = math.absf %2 fastmath<nnan,contract> : f32
    %23 = arith.cmpf oeq, %22, %cst : f32
    %24 = math.absf %3 fastmath<nnan,contract> : f32
    %25 = arith.cmpf oeq, %24, %cst : f32
    %26 = arith.cmpf ord, %0, %cst : f32
    %27 = arith.cmpf ord, %1, %cst : f32
    %28 = arith.ori %26, %27 : i1
    %29 = arith.andi %23, %25 : i1
    %30 = arith.andi %28, %29 : i1
    %cst_0 = arith.constant 0x7F800000 : f32
    %31 = math.copysign %cst_0, %2 : f32
    %32 = arith.mulf %31, %0 fastmath<nnan,contract> : f32
    %33 = arith.mulf %31, %1 fastmath<nnan,contract> : f32
    %34 = arith.cmpf one, %22, %cst_0 : f32
    %35 = arith.cmpf one, %24, %cst_0 : f32
    %36 = arith.andi %34, %35 : i1
    %37 = math.absf %0 fastmath<nnan,contract> : f32
    %38 = arith.cmpf oeq, %37, %cst_0 : f32
    %39 = math.absf %1 fastmath<nnan,contract> : f32
    %40 = arith.cmpf oeq, %39, %cst_0 : f32
    %41 = arith.ori %38, %40 : i1
    %42 = arith.andi %41, %36 : i1
    %cst_1 = arith.constant 1.000000e+00 : f32
    %43 = arith.select %38, %cst_1, %cst : f32
    %44 = math.copysign %43, %0 : f32
    %45 = arith.select %40, %cst_1, %cst : f32
    %46 = math.copysign %45, %1 : f32
    %47 = arith.mulf %44, %2 fastmath<nnan,contract> : f32
    %48 = arith.mulf %46, %3 fastmath<nnan,contract> : f32
    %49 = arith.addf %47, %48 fastmath<nnan,contract> : f32
    %50 = arith.mulf %cst_0, %49 fastmath<nnan,contract> : f32
    %51 = arith.mulf %44, %3 fastmath<nnan,contract> : f32
    %52 = arith.mulf %46, %2 fastmath<nnan,contract> : f32
    %53 = arith.subf %52, %51 fastmath<nnan,contract> : f32
    %54 = arith.mulf %cst_0, %53 fastmath<nnan,contract> : f32
    %55 = arith.cmpf one, %37, %cst_0 : f32
    %56 = arith.cmpf one, %39, %cst_0 : f32
    %57 = arith.andi %55, %56 : i1
    %58 = arith.cmpf oeq, %22, %cst_0 : f32
    %59 = arith.cmpf oeq, %24, %cst_0 : f32
    %60 = arith.ori %58, %59 : i1
    %61 = arith.andi %57, %60 : i1
    %62 = arith.select %58, %cst_1, %cst : f32
    %63 = math.copysign %62, %2 : f32
    %64 = arith.select %59, %cst_1, %cst : f32
    %65 = math.copysign %64, %3 : f32
    %66 = arith.mulf %0, %63 fastmath<nnan,contract> : f32
    %67 = arith.mulf %1, %65 fastmath<nnan,contract> : f32
    %68 = arith.addf %66, %67 fastmath<nnan,contract> : f32
    %69 = arith.mulf %cst, %68 fastmath<nnan,contract> : f32
    %70 = arith.mulf %1, %63 fastmath<nnan,contract> : f32
    %71 = arith.mulf %0, %65 fastmath<nnan,contract> : f32
    %72 = arith.subf %70, %71 fastmath<nnan,contract> : f32
    %73 = arith.mulf %cst, %72 fastmath<nnan,contract> : f32
    %74 = arith.cmpf olt, %22, %24 : f32
    %75 = arith.select %74, %9, %18 : f32
    %76 = arith.select %74, %12, %21 : f32
    %77 = arith.select %61, %69, %75 : f32
    %78 = arith.select %61, %73, %76 : f32
    %79 = arith.select %42, %50, %77 : f32
    %80 = arith.select %42, %54, %78 : f32
    %81 = arith.select %30, %32, %79 : f32
    %82 = arith.select %30, %33, %80 : f32
    %83 = arith.cmpf uno, %75, %cst : f32
    %84 = arith.cmpf uno, %76, %cst : f32
    %85 = arith.andi %83, %84 : i1
    %86 = arith.select %85, %81, %75 : f32
    %87 = arith.select %85, %82, %76 : f32
    %88 = complex.create %86, %87 : complex<f32>
    return %88 : complex<f32>
  }
}

// -----
module {
  func.func @complex_sqrt_with_fmf(%arg0: complex<f32>) -> complex<f32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 5.000000e-01 : f32
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %cst_1 = arith.constant 1.000000e+00 : f32
    %2 = math.absf %0 fastmath<nnan,contract> : f32
    %3 = math.absf %1 fastmath<nnan,contract> : f32
    %4 = arith.maximumf %2, %3 fastmath<nnan,contract> : f32
    %5 = arith.minimumf %2, %3 fastmath<nnan,contract> : f32
    %6 = arith.divf %5, %4 fastmath<contract> : f32
    %7 = arith.mulf %6, %6 fastmath<contract> : f32
    %8 = arith.addf %7, %cst_1 fastmath<contract> : f32
    %cst_2 = arith.constant 2.500000e-01 : f32
    %9 = math.sqrt %4 fastmath<contract> : f32
    %10 = math.powf %8, %cst_2 fastmath<contract> : f32
    %11 = arith.mulf %9, %10 fastmath<contract> : f32
    %12 = arith.cmpf uno, %11, %11 fastmath<contract> : f32
    %13 = arith.select %12, %5, %11 : f32
    %14 = math.atan2 %1, %0 fastmath<nnan,contract> : f32
    %15 = arith.mulf %14, %cst_0 fastmath<nnan,contract> : f32
    %16 = math.cos %15 fastmath<nnan,contract> : f32
    %17 = math.sin %15 fastmath<nnan,contract> : f32
    %18 = arith.cmpf oeq, %17, %cst fastmath<nnan,contract> : f32
    %19 = arith.mulf %13, %16 fastmath<nnan,contract> : f32
    %20 = arith.mulf %13, %17 fastmath<nnan,contract> : f32
    %21 = arith.select %18, %cst, %20 : f32
    %cst_3 = arith.constant 0x7F800000 : f32
    %cst_4 = arith.constant 0xFF800000 : f32
    %cst_5 = arith.constant 0x7FC00000 : f32
    %22 = math.absf %1 fastmath<nnan,contract> : f32
    %23 = arith.cmpf oeq, %22, %cst_3 fastmath<nnan,contract> : f32
    %24 = arith.cmpf one, %22, %cst_3 fastmath<nnan,contract> : f32
    %25 = arith.cmpf oeq, %0, %cst_3 fastmath<nnan,contract> : f32
    %26 = arith.cmpf oeq, %0, %cst_4 fastmath<nnan,contract> : f32
    %27 = arith.andi %26, %24 : i1
    %28 = arith.select %27, %cst, %19 : f32
    %29 = arith.ori %23, %25 : i1
    %30 = arith.select %29, %cst_3, %28 : f32
    %31 = math.copysign %cst_3, %1 fastmath<nnan,contract> : f32
    %32 = arith.cmpf uno, %13, %13 : f32
    %33 = arith.select %32, %cst_5, %21 : f32
    %34 = arith.ori %23, %26 : i1
    %35 = arith.select %34, %31, %33 : f32
    %36 = arith.cmpf oeq, %13, %cst fastmath<nnan,contract> : f32
    %37 = arith.select %36, %cst, %30 : f32
    %38 = arith.select %36, %cst, %35 : f32
    %39 = complex.create %37, %38 : complex<f32>
    return %39 : complex<f32>
  }
}

// -----
module {
  func.func @complex_cos_with_fmf(%arg0: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %cst = arith.constant 5.000000e-01 : f32
    %2 = math.exp %1 fastmath<nnan,contract> : f32
    %3 = arith.mulf %cst, %2 fastmath<nnan,contract> : f32
    %4 = arith.divf %cst, %2 fastmath<nnan,contract> : f32
    %5 = math.sin %0 fastmath<nnan,contract> : f32
    %6 = math.cos %0 fastmath<nnan,contract> : f32
    %7 = arith.addf %4, %3 fastmath<nnan,contract> : f32
    %8 = arith.mulf %7, %6 fastmath<nnan,contract> : f32
    %9 = arith.subf %4, %3 fastmath<nnan,contract> : f32
    %10 = arith.mulf %9, %5 fastmath<nnan,contract> : f32
    %11 = complex.create %8, %10 : complex<f32>
    return %11 : complex<f32>
  }
}

// -----
module {
  func.func @complex_sin_with_fmf(%arg0: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %cst = arith.constant 5.000000e-01 : f32
    %2 = math.exp %1 fastmath<nnan,contract> : f32
    %3 = arith.mulf %cst, %2 fastmath<nnan,contract> : f32
    %4 = arith.divf %cst, %2 fastmath<nnan,contract> : f32
    %5 = math.sin %0 fastmath<nnan,contract> : f32
    %6 = math.cos %0 fastmath<nnan,contract> : f32
    %7 = arith.addf %3, %4 fastmath<nnan,contract> : f32
    %8 = arith.mulf %7, %5 fastmath<nnan,contract> : f32
    %9 = arith.subf %3, %4 fastmath<nnan,contract> : f32
    %10 = arith.mulf %9, %6 fastmath<nnan,contract> : f32
    %11 = complex.create %8, %10 : complex<f32>
    return %11 : complex<f32>
  }
}

// -----
module {
  func.func @complex_sign_with_fmf(%arg0: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %cst = arith.constant 0.000000e+00 : f32
    %2 = arith.cmpf oeq, %0, %cst : f32
    %3 = arith.cmpf oeq, %1, %cst : f32
    %4 = arith.andi %2, %3 : i1
    %5 = complex.re %arg0 : complex<f32>
    %6 = complex.im %arg0 : complex<f32>
    %cst_0 = arith.constant 1.000000e+00 : f32
    %7 = math.absf %5 fastmath<nnan,contract> : f32
    %8 = math.absf %6 fastmath<nnan,contract> : f32
    %9 = arith.maximumf %7, %8 fastmath<nnan,contract> : f32
    %10 = arith.minimumf %7, %8 fastmath<nnan,contract> : f32
    %11 = arith.divf %10, %9 fastmath<contract> : f32
    %12 = arith.mulf %11, %11 fastmath<contract> : f32
    %13 = arith.addf %12, %cst_0 fastmath<contract> : f32
    %14 = math.sqrt %13 fastmath<contract> : f32
    %15 = arith.mulf %9, %14 fastmath<contract> : f32
    %16 = arith.cmpf uno, %15, %15 fastmath<contract> : f32
    %17 = arith.select %16, %10, %15 : f32
    %18 = arith.divf %0, %17 fastmath<nnan,contract> : f32
    %19 = arith.divf %1, %17 fastmath<nnan,contract> : f32
    %20 = complex.create %18, %19 : complex<f32>
    %21 = arith.select %4, %arg0, %20 : complex<f32>
    return %21 : complex<f32>
  }
}

// -----
module {
  func.func @complex_tan_with_fmf(%arg0: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %cst = arith.constant -1.000000e+00 : f32
    %2 = arith.mulf %1, %cst fastmath<nnan,contract> : f32
    %cst_0 = arith.constant 0x7F800000 : f32
    %cst_1 = arith.constant 4.000000e+00 : f32
    %3 = arith.addf %2, %2 fastmath<nnan,contract> : f32
    %4 = arith.mulf %cst, %3 fastmath<nnan,contract> : f32
    %5 = math.expm1 %3 fastmath<nnan,contract> : f32
    %6 = math.expm1 %4 fastmath<nnan,contract> : f32
    %7 = arith.subf %5, %6 fastmath<nnan,contract> : f32
    %8 = math.cos %0 fastmath<nnan,contract> : f32
    %9 = arith.mulf %8, %8 fastmath<nnan,contract> : f32
    %10 = arith.mulf %9, %cst_1 fastmath<nnan,contract> : f32
    %11 = math.sin %0 fastmath<nnan,contract> : f32
    %12 = arith.mulf %8, %11 fastmath<nnan,contract> : f32
    %13 = arith.mulf %cst_1, %12 fastmath<nnan,contract> : f32
    %14 = arith.addf %5, %6 fastmath<nnan,contract> : f32
    %15 = arith.addf %14, %10 fastmath<nnan,contract> : f32
    %16 = arith.cmpf oeq, %14, %cst_0 fastmath<nnan,contract> : f32
    %17 = math.copysign %cst, %2 fastmath<nnan,contract> : f32
    %18 = arith.divf %7, %15 fastmath<nnan,contract> : f32
    %19 = arith.select %16, %17, %18 : f32
    %20 = arith.divf %13, %15 fastmath<nnan,contract> : f32
    %21 = math.absf %2 fastmath<nnan,contract> : f32
    %cst_2 = arith.constant 0.000000e+00 : f32
    %cst_3 = arith.constant 0x7FC00000 : f32
    %22 = arith.cmpf oeq, %21, %cst_0 fastmath<nnan,contract> : f32
    %23 = arith.cmpf oeq, %0, %cst_2 fastmath<nnan,contract> : f32
    %true = arith.constant true
    %24 = arith.xori %22, %true : i1
    %25 = arith.cmpf uno, %13, %13 fastmath<nnan,contract> : f32
    %26 = arith.andi %25, %24 : i1
    %27 = arith.andi %22, %25 : i1
    %28 = arith.ori %23, %27 : i1
    %29 = arith.select %26, %cst_3, %19 : f32
    %30 = arith.select %28, %cst_2, %20 : f32
    %31 = arith.mulf %29, %cst fastmath<nnan,contract> : f32
    %32 = complex.create %30, %31 : complex<f32>
    return %32 : complex<f32>
  }
}

// -----
module {
  func.func @complex_tanh_with_fmf(%arg0: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %cst = arith.constant -1.000000e+00 : f32
    %cst_0 = arith.constant 0x7F800000 : f32
    %cst_1 = arith.constant 4.000000e+00 : f32
    %2 = arith.addf %0, %0 fastmath<nnan,contract> : f32
    %3 = arith.mulf %cst, %2 fastmath<nnan,contract> : f32
    %4 = math.expm1 %2 fastmath<nnan,contract> : f32
    %5 = math.expm1 %3 fastmath<nnan,contract> : f32
    %6 = arith.subf %4, %5 fastmath<nnan,contract> : f32
    %7 = math.cos %1 fastmath<nnan,contract> : f32
    %8 = arith.mulf %7, %7 fastmath<nnan,contract> : f32
    %9 = arith.mulf %8, %cst_1 fastmath<nnan,contract> : f32
    %10 = math.sin %1 fastmath<nnan,contract> : f32
    %11 = arith.mulf %7, %10 fastmath<nnan,contract> : f32
    %12 = arith.mulf %cst_1, %11 fastmath<nnan,contract> : f32
    %13 = arith.addf %4, %5 fastmath<nnan,contract> : f32
    %14 = arith.addf %13, %9 fastmath<nnan,contract> : f32
    %15 = arith.cmpf oeq, %13, %cst_0 fastmath<nnan,contract> : f32
    %16 = math.copysign %cst, %0 fastmath<nnan,contract> : f32
    %17 = arith.divf %6, %14 fastmath<nnan,contract> : f32
    %18 = arith.select %15, %16, %17 : f32
    %19 = arith.divf %12, %14 fastmath<nnan,contract> : f32
    %20 = math.absf %0 fastmath<nnan,contract> : f32
    %cst_2 = arith.constant 0.000000e+00 : f32
    %cst_3 = arith.constant 0x7FC00000 : f32
    %21 = arith.cmpf oeq, %20, %cst_0 fastmath<nnan,contract> : f32
    %22 = arith.cmpf oeq, %1, %cst_2 fastmath<nnan,contract> : f32
    %true = arith.constant true
    %23 = arith.xori %21, %true : i1
    %24 = arith.cmpf uno, %12, %12 fastmath<nnan,contract> : f32
    %25 = arith.andi %24, %23 : i1
    %26 = arith.andi %21, %24 : i1
    %27 = arith.ori %22, %26 : i1
    %28 = arith.select %25, %cst_3, %18 : f32
    %29 = arith.select %27, %cst_2, %19 : f32
    %30 = complex.create %28, %29 : complex<f32>
    return %30 : complex<f32>
  }
}

// -----
module {
  func.func @complex_tanh_nnan_ninf(%arg0: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %cst = arith.constant -1.000000e+00 : f32
    %cst_0 = arith.constant 0x7F800000 : f32
    %cst_1 = arith.constant 4.000000e+00 : f32
    %2 = arith.addf %0, %0 fastmath<nnan,ninf> : f32
    %3 = arith.mulf %cst, %2 fastmath<nnan,ninf> : f32
    %4 = math.expm1 %2 fastmath<nnan,ninf> : f32
    %5 = math.expm1 %3 fastmath<nnan,ninf> : f32
    %6 = arith.subf %4, %5 fastmath<nnan,ninf> : f32
    %7 = math.cos %1 fastmath<nnan,ninf> : f32
    %8 = arith.mulf %7, %7 fastmath<nnan,ninf> : f32
    %9 = arith.mulf %8, %cst_1 fastmath<nnan,ninf> : f32
    %10 = math.sin %1 fastmath<nnan,ninf> : f32
    %11 = arith.mulf %7, %10 fastmath<nnan,ninf> : f32
    %12 = arith.mulf %cst_1, %11 fastmath<nnan,ninf> : f32
    %13 = arith.addf %4, %5 fastmath<nnan,ninf> : f32
    %14 = arith.addf %13, %9 fastmath<nnan,ninf> : f32
    %15 = arith.cmpf oeq, %13, %cst_0 fastmath<nnan,ninf> : f32
    %16 = math.copysign %cst, %0 fastmath<nnan,ninf> : f32
    %17 = arith.divf %6, %14 fastmath<nnan,ninf> : f32
    %18 = arith.select %15, %16, %17 : f32
    %19 = arith.divf %12, %14 fastmath<nnan,ninf> : f32
    %20 = complex.create %18, %19 : complex<f32>
    return %20 : complex<f32>
  }
}

// -----
module {
  func.func @complex_angle_with_fmf(%arg0: complex<f32>) -> f32 {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %2 = math.atan2 %1, %0 fastmath<nnan,contract> : f32
    return %2 : f32
  }
}

