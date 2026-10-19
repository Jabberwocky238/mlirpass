module {
  func.func private @pow(f64, f64) -> f64 attributes {llvm.readnone}
  func.func private @powf(f32, f32) -> f32 attributes {llvm.readnone}
  func.func private @rsqrt(f64) -> f64 attributes {llvm.readnone}
  func.func private @rsqrtf(f32) -> f32 attributes {llvm.readnone}
  func.func private @sqrt(f64) -> f64 attributes {llvm.readnone}
  func.func private @sqrtf(f32) -> f32 attributes {llvm.readnone}
  func.func private @ceil(f64) -> f64 attributes {llvm.readnone}
  func.func private @ceilf(f32) -> f32 attributes {llvm.readnone}
  func.func private @floor(f64) -> f64 attributes {llvm.readnone}
  func.func private @floorf(f32) -> f32 attributes {llvm.readnone}
  func.func private @log1p(f64) -> f64 attributes {llvm.readnone}
  func.func private @log1pf(f32) -> f32 attributes {llvm.readnone}
  func.func private @tan(f64) -> f64 attributes {llvm.readnone}
  func.func private @tanf(f32) -> f32 attributes {llvm.readnone}
  func.func private @sin(f64) -> f64 attributes {llvm.readnone}
  func.func private @sinf(f32) -> f32 attributes {llvm.readnone}
  func.func private @cos(f64) -> f64 attributes {llvm.readnone}
  func.func private @cosf(f32) -> f32 attributes {llvm.readnone}
  func.func private @cbrt(f64) -> f64 attributes {llvm.readnone}
  func.func private @cbrtf(f32) -> f32 attributes {llvm.readnone}
  func.func private @trunc(f64) -> f64 attributes {llvm.readnone}
  func.func private @truncf(f32) -> f32 attributes {llvm.readnone}
  func.func private @roundeven(f64) -> f64 attributes {llvm.readnone}
  func.func private @roundevenf(f32) -> f32 attributes {llvm.readnone}
  func.func private @round(f64) -> f64 attributes {llvm.readnone}
  func.func private @roundf(f32) -> f32 attributes {llvm.readnone}
  func.func private @fma(f64, f64, f64) -> f64 attributes {llvm.readnone}
  func.func private @fmaf(f32, f32, f32) -> f32 attributes {llvm.readnone}
  func.func private @expm1(f64) -> f64 attributes {llvm.readnone}
  func.func private @expm1f(f32) -> f32 attributes {llvm.readnone}
  func.func private @log10(f64) -> f64 attributes {llvm.readnone}
  func.func private @log10f(f32) -> f32 attributes {llvm.readnone}
  func.func private @log2(f64) -> f64 attributes {llvm.readnone}
  func.func private @log2f(f32) -> f32 attributes {llvm.readnone}
  func.func private @log(f64) -> f64 attributes {llvm.readnone}
  func.func private @logf(f32) -> f32 attributes {llvm.readnone}
  func.func private @exp2(f64) -> f64 attributes {llvm.readnone}
  func.func private @exp2f(f32) -> f32 attributes {llvm.readnone}
  func.func private @exp(f64) -> f64 attributes {llvm.readnone}
  func.func private @expf(f32) -> f32 attributes {llvm.readnone}
  func.func private @erf(f64) -> f64 attributes {llvm.readnone}
  func.func private @erff(f32) -> f32 attributes {llvm.readnone}
  func.func private @atan2(f64, f64) -> f64 attributes {llvm.readnone}
  func.func private @atan2f(f32, f32) -> f32 attributes {llvm.readnone}
  func.func private @sinh(f64) -> f64 attributes {llvm.readnone}
  func.func private @sinhf(f32) -> f32 attributes {llvm.readnone}
  func.func private @cosh(f64) -> f64 attributes {llvm.readnone}
  func.func private @coshf(f32) -> f32 attributes {llvm.readnone}
  func.func private @tanh(f64) -> f64 attributes {llvm.readnone}
  func.func private @tanhf(f32) -> f32 attributes {llvm.readnone}
  func.func private @atanh(f64) -> f64 attributes {llvm.readnone}
  func.func private @atanhf(f32) -> f32 attributes {llvm.readnone}
  func.func private @atan(f64) -> f64 attributes {llvm.readnone}
  func.func private @atanf(f32) -> f32 attributes {llvm.readnone}
  func.func private @asinh(f64) -> f64 attributes {llvm.readnone}
  func.func private @asinhf(f32) -> f32 attributes {llvm.readnone}
  func.func private @asin(f64) -> f64 attributes {llvm.readnone}
  func.func private @asinf(f32) -> f32 attributes {llvm.readnone}
  func.func private @acosh(f64) -> f64 attributes {llvm.readnone}
  func.func private @acoshf(f32) -> f32 attributes {llvm.readnone}
  func.func private @acos(f64) -> f64 attributes {llvm.readnone}
  func.func private @acosf(f32) -> f32 attributes {llvm.readnone}
  func.func private @fabs(f64) -> f64 attributes {llvm.readnone}
  func.func private @fabsf(f32) -> f32 attributes {llvm.readnone}
  func.func @absf_caller(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = call @fabsf(%arg0) : (f32) -> f32
    %1 = call @fabs(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
  func.func @absf_vec_caller(%arg0: vector<2xf32>, %arg1: vector<2xf64>) -> (vector<2xf32>, vector<2xf64>) {
    %0 = vector.extract %arg0[0] : f32 from vector<2xf32>
    %1 = call @fabsf(%0) : (f32) -> f32
    %2 = vector.extract %arg0[1] : f32 from vector<2xf32>
    %3 = call @fabsf(%2) : (f32) -> f32
    %4 = vector.from_elements %1, %3 : vector<2xf32>
    %5 = vector.extract %arg1[0] : f64 from vector<2xf64>
    %6 = call @fabs(%5) : (f64) -> f64
    %7 = vector.extract %arg1[1] : f64 from vector<2xf64>
    %8 = call @fabs(%7) : (f64) -> f64
    %9 = vector.from_elements %6, %8 : vector<2xf64>
    return %4, %9 : vector<2xf32>, vector<2xf64>
  }
  func.func @acos_caller(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = call @acosf(%arg0) : (f32) -> f32
    %1 = call @acos(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
  func.func @acos_vec_caller(%arg0: vector<2xf32>, %arg1: vector<2xf64>) -> (vector<2xf32>, vector<2xf64>) {
    %0 = vector.extract %arg0[0] : f32 from vector<2xf32>
    %1 = call @acosf(%0) : (f32) -> f32
    %2 = vector.extract %arg0[1] : f32 from vector<2xf32>
    %3 = call @acosf(%2) : (f32) -> f32
    %4 = vector.from_elements %1, %3 : vector<2xf32>
    %5 = vector.extract %arg1[0] : f64 from vector<2xf64>
    %6 = call @acos(%5) : (f64) -> f64
    %7 = vector.extract %arg1[1] : f64 from vector<2xf64>
    %8 = call @acos(%7) : (f64) -> f64
    %9 = vector.from_elements %6, %8 : vector<2xf64>
    return %4, %9 : vector<2xf32>, vector<2xf64>
  }
  func.func @acosh_caller(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = call @acoshf(%arg0) : (f32) -> f32
    %1 = call @acosh(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
  func.func @acosh_vec_caller(%arg0: vector<2xf32>, %arg1: vector<2xf64>) -> (vector<2xf32>, vector<2xf64>) {
    %0 = vector.extract %arg0[0] : f32 from vector<2xf32>
    %1 = call @acoshf(%0) : (f32) -> f32
    %2 = vector.extract %arg0[1] : f32 from vector<2xf32>
    %3 = call @acoshf(%2) : (f32) -> f32
    %4 = vector.from_elements %1, %3 : vector<2xf32>
    %5 = vector.extract %arg1[0] : f64 from vector<2xf64>
    %6 = call @acosh(%5) : (f64) -> f64
    %7 = vector.extract %arg1[1] : f64 from vector<2xf64>
    %8 = call @acosh(%7) : (f64) -> f64
    %9 = vector.from_elements %6, %8 : vector<2xf64>
    return %4, %9 : vector<2xf32>, vector<2xf64>
  }
  func.func @asin_caller(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = call @asinf(%arg0) : (f32) -> f32
    %1 = call @asin(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
  func.func @asin_vec_caller(%arg0: vector<2xf32>, %arg1: vector<2xf64>) -> (vector<2xf32>, vector<2xf64>) {
    %0 = vector.extract %arg0[0] : f32 from vector<2xf32>
    %1 = call @asinf(%0) : (f32) -> f32
    %2 = vector.extract %arg0[1] : f32 from vector<2xf32>
    %3 = call @asinf(%2) : (f32) -> f32
    %4 = vector.from_elements %1, %3 : vector<2xf32>
    %5 = vector.extract %arg1[0] : f64 from vector<2xf64>
    %6 = call @asin(%5) : (f64) -> f64
    %7 = vector.extract %arg1[1] : f64 from vector<2xf64>
    %8 = call @asin(%7) : (f64) -> f64
    %9 = vector.from_elements %6, %8 : vector<2xf64>
    return %4, %9 : vector<2xf32>, vector<2xf64>
  }
  func.func @asinh_caller(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = call @asinhf(%arg0) : (f32) -> f32
    %1 = call @asinh(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
  func.func @asinh_vec_caller(%arg0: vector<2xf32>, %arg1: vector<2xf64>) -> (vector<2xf32>, vector<2xf64>) {
    %0 = vector.extract %arg0[0] : f32 from vector<2xf32>
    %1 = call @asinhf(%0) : (f32) -> f32
    %2 = vector.extract %arg0[1] : f32 from vector<2xf32>
    %3 = call @asinhf(%2) : (f32) -> f32
    %4 = vector.from_elements %1, %3 : vector<2xf32>
    %5 = vector.extract %arg1[0] : f64 from vector<2xf64>
    %6 = call @asinh(%5) : (f64) -> f64
    %7 = vector.extract %arg1[1] : f64 from vector<2xf64>
    %8 = call @asinh(%7) : (f64) -> f64
    %9 = vector.from_elements %6, %8 : vector<2xf64>
    return %4, %9 : vector<2xf32>, vector<2xf64>
  }
  func.func @atan_caller(%arg0: f32, %arg1: f64, %arg2: f16, %arg3: bf16) -> (f32, f64, f16, bf16) {
    %0 = call @atanf(%arg0) : (f32) -> f32
    %1 = call @atan(%arg1) : (f64) -> f64
    %2 = arith.extf %arg2 : f16 to f32
    %3 = call @atanf(%2) : (f32) -> f32
    %4 = arith.truncf %3 : f32 to f16
    %5 = arith.extf %arg3 : bf16 to f32
    %6 = call @atanf(%5) : (f32) -> f32
    %7 = arith.truncf %6 : f32 to bf16
    return %0, %1, %4, %7 : f32, f64, f16, bf16
  }
  func.func @atan_vec_caller(%arg0: vector<2xf32>, %arg1: vector<2xf64>) -> (vector<2xf32>, vector<2xf64>) {
    %0 = vector.extract %arg0[0] : f32 from vector<2xf32>
    %1 = call @atanf(%0) : (f32) -> f32
    %2 = vector.extract %arg0[1] : f32 from vector<2xf32>
    %3 = call @atanf(%2) : (f32) -> f32
    %4 = vector.from_elements %1, %3 : vector<2xf32>
    %5 = vector.extract %arg1[0] : f64 from vector<2xf64>
    %6 = call @atan(%5) : (f64) -> f64
    %7 = vector.extract %arg1[1] : f64 from vector<2xf64>
    %8 = call @atan(%7) : (f64) -> f64
    %9 = vector.from_elements %6, %8 : vector<2xf64>
    return %4, %9 : vector<2xf32>, vector<2xf64>
  }
  func.func @atanh_caller(%arg0: f32, %arg1: f64, %arg2: f16, %arg3: bf16) -> (f32, f64, f16, bf16) {
    %0 = call @atanhf(%arg0) : (f32) -> f32
    %1 = call @atanh(%arg1) : (f64) -> f64
    %2 = arith.extf %arg2 : f16 to f32
    %3 = call @atanhf(%2) : (f32) -> f32
    %4 = arith.truncf %3 : f32 to f16
    %5 = arith.extf %arg3 : bf16 to f32
    %6 = call @atanhf(%5) : (f32) -> f32
    %7 = arith.truncf %6 : f32 to bf16
    return %0, %1, %4, %7 : f32, f64, f16, bf16
  }
  func.func @atanh_vec_caller(%arg0: vector<2xf32>, %arg1: vector<2xf64>) -> (vector<2xf32>, vector<2xf64>) {
    %0 = vector.extract %arg0[0] : f32 from vector<2xf32>
    %1 = call @atanhf(%0) : (f32) -> f32
    %2 = vector.extract %arg0[1] : f32 from vector<2xf32>
    %3 = call @atanhf(%2) : (f32) -> f32
    %4 = vector.from_elements %1, %3 : vector<2xf32>
    %5 = vector.extract %arg1[0] : f64 from vector<2xf64>
    %6 = call @atanh(%5) : (f64) -> f64
    %7 = vector.extract %arg1[1] : f64 from vector<2xf64>
    %8 = call @atanh(%7) : (f64) -> f64
    %9 = vector.from_elements %6, %8 : vector<2xf64>
    return %4, %9 : vector<2xf32>, vector<2xf64>
  }
  func.func @tanh_caller(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = call @tanhf(%arg0) : (f32) -> f32
    %1 = call @tanh(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
  func.func @cosh_caller(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = call @coshf(%arg0) : (f32) -> f32
    %1 = call @cosh(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
  func.func @sinh_caller(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = call @sinhf(%arg0) : (f32) -> f32
    %1 = call @sinh(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
  func.func @atan2_caller(%arg0: f32, %arg1: f64, %arg2: f16, %arg3: bf16) -> (f32, f64, f16, bf16) {
    %0 = call @atan2f(%arg0, %arg0) : (f32, f32) -> f32
    %1 = call @atan2(%arg1, %arg1) : (f64, f64) -> f64
    %2 = arith.extf %arg2 : f16 to f32
    %3 = arith.extf %arg2 : f16 to f32
    %4 = call @atan2f(%2, %3) : (f32, f32) -> f32
    %5 = arith.truncf %4 : f32 to f16
    %6 = arith.extf %arg3 : bf16 to f32
    %7 = arith.extf %arg3 : bf16 to f32
    %8 = call @atan2f(%6, %7) : (f32, f32) -> f32
    %9 = arith.truncf %8 : f32 to bf16
    return %0, %1, %5, %9 : f32, f64, f16, bf16
  }
  func.func @erf_caller(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = call @erff(%arg0) : (f32) -> f32
    %1 = call @erf(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
  func.func @erf_vec_caller(%arg0: vector<2xf32>, %arg1: vector<2xf64>) -> (vector<2xf32>, vector<2xf64>) {
    %0 = vector.extract %arg0[0] : f32 from vector<2xf32>
    %1 = call @erff(%0) : (f32) -> f32
    %2 = vector.extract %arg0[1] : f32 from vector<2xf32>
    %3 = call @erff(%2) : (f32) -> f32
    %4 = vector.from_elements %1, %3 : vector<2xf32>
    %5 = vector.extract %arg1[0] : f64 from vector<2xf64>
    %6 = call @erf(%5) : (f64) -> f64
    %7 = vector.extract %arg1[1] : f64 from vector<2xf64>
    %8 = call @erf(%7) : (f64) -> f64
    %9 = vector.from_elements %6, %8 : vector<2xf64>
    return %4, %9 : vector<2xf32>, vector<2xf64>
  }
  func.func @exp_caller(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = call @expf(%arg0) : (f32) -> f32
    %1 = call @exp(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
  func.func @exp_vec_caller(%arg0: vector<2xf32>, %arg1: vector<2xf64>) -> (vector<2xf32>, vector<2xf64>) {
    %0 = vector.extract %arg0[0] : f32 from vector<2xf32>
    %1 = call @expf(%0) : (f32) -> f32
    %2 = vector.extract %arg0[1] : f32 from vector<2xf32>
    %3 = call @expf(%2) : (f32) -> f32
    %4 = vector.from_elements %1, %3 : vector<2xf32>
    %5 = vector.extract %arg1[0] : f64 from vector<2xf64>
    %6 = call @exp(%5) : (f64) -> f64
    %7 = vector.extract %arg1[1] : f64 from vector<2xf64>
    %8 = call @exp(%7) : (f64) -> f64
    %9 = vector.from_elements %6, %8 : vector<2xf64>
    return %4, %9 : vector<2xf32>, vector<2xf64>
  }
  func.func @exp2_caller(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = call @exp2f(%arg0) : (f32) -> f32
    %1 = call @exp2(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
  func.func @exp2_vec_caller(%arg0: vector<2xf32>, %arg1: vector<2xf64>) -> (vector<2xf32>, vector<2xf64>) {
    %0 = vector.extract %arg0[0] : f32 from vector<2xf32>
    %1 = call @exp2f(%0) : (f32) -> f32
    %2 = vector.extract %arg0[1] : f32 from vector<2xf32>
    %3 = call @exp2f(%2) : (f32) -> f32
    %4 = vector.from_elements %1, %3 : vector<2xf32>
    %5 = vector.extract %arg1[0] : f64 from vector<2xf64>
    %6 = call @exp2(%5) : (f64) -> f64
    %7 = vector.extract %arg1[1] : f64 from vector<2xf64>
    %8 = call @exp2(%7) : (f64) -> f64
    %9 = vector.from_elements %6, %8 : vector<2xf64>
    return %4, %9 : vector<2xf32>, vector<2xf64>
  }
  func.func @log_caller(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = call @logf(%arg0) : (f32) -> f32
    %1 = call @log(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
  func.func @log_vec_caller(%arg0: vector<2xf32>, %arg1: vector<2xf64>) -> (vector<2xf32>, vector<2xf64>) {
    %0 = vector.extract %arg0[0] : f32 from vector<2xf32>
    %1 = call @logf(%0) : (f32) -> f32
    %2 = vector.extract %arg0[1] : f32 from vector<2xf32>
    %3 = call @logf(%2) : (f32) -> f32
    %4 = vector.from_elements %1, %3 : vector<2xf32>
    %5 = vector.extract %arg1[0] : f64 from vector<2xf64>
    %6 = call @log(%5) : (f64) -> f64
    %7 = vector.extract %arg1[1] : f64 from vector<2xf64>
    %8 = call @log(%7) : (f64) -> f64
    %9 = vector.from_elements %6, %8 : vector<2xf64>
    return %4, %9 : vector<2xf32>, vector<2xf64>
  }
  func.func @log2_caller(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = call @log2f(%arg0) : (f32) -> f32
    %1 = call @log2(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
  func.func @log2_vec_caller(%arg0: vector<2xf32>, %arg1: vector<2xf64>) -> (vector<2xf32>, vector<2xf64>) {
    %0 = vector.extract %arg0[0] : f32 from vector<2xf32>
    %1 = call @log2f(%0) : (f32) -> f32
    %2 = vector.extract %arg0[1] : f32 from vector<2xf32>
    %3 = call @log2f(%2) : (f32) -> f32
    %4 = vector.from_elements %1, %3 : vector<2xf32>
    %5 = vector.extract %arg1[0] : f64 from vector<2xf64>
    %6 = call @log2(%5) : (f64) -> f64
    %7 = vector.extract %arg1[1] : f64 from vector<2xf64>
    %8 = call @log2(%7) : (f64) -> f64
    %9 = vector.from_elements %6, %8 : vector<2xf64>
    return %4, %9 : vector<2xf32>, vector<2xf64>
  }
  func.func @log10_caller(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = call @log10f(%arg0) : (f32) -> f32
    %1 = call @log10(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
  func.func @log10_vec_caller(%arg0: vector<2xf32>, %arg1: vector<2xf64>) -> (vector<2xf32>, vector<2xf64>) {
    %0 = vector.extract %arg0[0] : f32 from vector<2xf32>
    %1 = call @log10f(%0) : (f32) -> f32
    %2 = vector.extract %arg0[1] : f32 from vector<2xf32>
    %3 = call @log10f(%2) : (f32) -> f32
    %4 = vector.from_elements %1, %3 : vector<2xf32>
    %5 = vector.extract %arg1[0] : f64 from vector<2xf64>
    %6 = call @log10(%5) : (f64) -> f64
    %7 = vector.extract %arg1[1] : f64 from vector<2xf64>
    %8 = call @log10(%7) : (f64) -> f64
    %9 = vector.from_elements %6, %8 : vector<2xf64>
    return %4, %9 : vector<2xf32>, vector<2xf64>
  }
  func.func @expm1_caller(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = call @expm1f(%arg0) : (f32) -> f32
    %1 = call @expm1(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
  func.func @expm1_vec_caller(%arg0: vector<2xf32>, %arg1: vector<2xf64>) -> (vector<2xf32>, vector<2xf64>) {
    %0 = vector.extract %arg0[0] : f32 from vector<2xf32>
    %1 = call @expm1f(%0) : (f32) -> f32
    %2 = vector.extract %arg0[1] : f32 from vector<2xf32>
    %3 = call @expm1f(%2) : (f32) -> f32
    %4 = vector.from_elements %1, %3 : vector<2xf32>
    %5 = vector.extract %arg1[0] : f64 from vector<2xf64>
    %6 = call @expm1(%5) : (f64) -> f64
    %7 = vector.extract %arg1[1] : f64 from vector<2xf64>
    %8 = call @expm1(%7) : (f64) -> f64
    %9 = vector.from_elements %6, %8 : vector<2xf64>
    return %4, %9 : vector<2xf32>, vector<2xf64>
  }
  func.func @expm1_multidim_vec_caller(%arg0: vector<2x2xf32>) -> vector<2x2xf32> {
    %0 = vector.extract %arg0[0, 0] : f32 from vector<2x2xf32>
    %1 = call @expm1f(%0) : (f32) -> f32
    %2 = vector.extract %arg0[0, 1] : f32 from vector<2x2xf32>
    %3 = call @expm1f(%2) : (f32) -> f32
    %4 = vector.extract %arg0[1, 0] : f32 from vector<2x2xf32>
    %5 = call @expm1f(%4) : (f32) -> f32
    %6 = vector.extract %arg0[1, 1] : f32 from vector<2x2xf32>
    %7 = call @expm1f(%6) : (f32) -> f32
    %8 = vector.from_elements %1, %3, %5, %7 : vector<2x2xf32>
    return %8 : vector<2x2xf32>
  }
  func.func @fma_caller(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: f64, %arg4: f64, %arg5: f64) -> (f32, f64) {
    %0 = call @fmaf(%arg0, %arg1, %arg2) : (f32, f32, f32) -> f32
    %1 = call @fma(%arg3, %arg4, %arg5) : (f64, f64, f64) -> f64
    return %0, %1 : f32, f64
  }
  func.func @fma_vec_caller(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>, %arg3: vector<2xf64>, %arg4: vector<2xf64>, %arg5: vector<2xf64>) -> (vector<2xf32>, vector<2xf64>) {
    %0 = vector.extract %arg0[0] : f32 from vector<2xf32>
    %1 = vector.extract %arg1[0] : f32 from vector<2xf32>
    %2 = vector.extract %arg2[0] : f32 from vector<2xf32>
    %3 = call @fmaf(%0, %1, %2) : (f32, f32, f32) -> f32
    %4 = vector.extract %arg0[1] : f32 from vector<2xf32>
    %5 = vector.extract %arg1[1] : f32 from vector<2xf32>
    %6 = vector.extract %arg2[1] : f32 from vector<2xf32>
    %7 = call @fmaf(%4, %5, %6) : (f32, f32, f32) -> f32
    %8 = vector.from_elements %3, %7 : vector<2xf32>
    %9 = vector.extract %arg3[0] : f64 from vector<2xf64>
    %10 = vector.extract %arg4[0] : f64 from vector<2xf64>
    %11 = vector.extract %arg5[0] : f64 from vector<2xf64>
    %12 = call @fma(%9, %10, %11) : (f64, f64, f64) -> f64
    %13 = vector.extract %arg3[1] : f64 from vector<2xf64>
    %14 = vector.extract %arg4[1] : f64 from vector<2xf64>
    %15 = vector.extract %arg5[1] : f64 from vector<2xf64>
    %16 = call @fma(%13, %14, %15) : (f64, f64, f64) -> f64
    %17 = vector.from_elements %12, %16 : vector<2xf64>
    return %8, %17 : vector<2xf32>, vector<2xf64>
  }
  func.func @round_caller(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = call @roundf(%arg0) : (f32) -> f32
    %1 = call @round(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
  func.func @roundeven_caller(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = call @roundevenf(%arg0) : (f32) -> f32
    %1 = call @roundeven(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
  func.func @trunc_caller(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = call @truncf(%arg0) : (f32) -> f32
    %1 = call @trunc(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
  func.func @cbrt_caller(%arg0: f32, %arg1: f64, %arg2: f16, %arg3: bf16, %arg4: vector<2xf32>) -> (f32, f64, f16, bf16, vector<2xf32>) {
    %0 = call @cbrtf(%arg0) : (f32) -> f32
    %1 = call @cbrt(%arg1) : (f64) -> f64
    %2 = arith.extf %arg2 : f16 to f32
    %3 = call @cbrtf(%2) : (f32) -> f32
    %4 = arith.truncf %3 : f32 to f16
    %5 = arith.extf %arg3 : bf16 to f32
    %6 = call @cbrtf(%5) : (f32) -> f32
    %7 = arith.truncf %6 : f32 to bf16
    %8 = vector.extract %arg4[0] : f32 from vector<2xf32>
    %9 = call @cbrtf(%8) : (f32) -> f32
    %10 = vector.extract %arg4[1] : f32 from vector<2xf32>
    %11 = call @cbrtf(%10) : (f32) -> f32
    %12 = vector.from_elements %9, %11 : vector<2xf32>
    return %0, %1, %4, %7, %12 : f32, f64, f16, bf16, vector<2xf32>
  }
  func.func @cos_caller(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = call @cosf(%arg0) : (f32) -> f32
    %1 = call @cos(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
  func.func @sin_caller(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = call @sinf(%arg0) : (f32) -> f32
    %1 = call @sin(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
  func.func @round_vec_caller(%arg0: vector<2xf32>, %arg1: vector<2xf64>) -> (vector<2xf32>, vector<2xf64>) {
    %0 = vector.extract %arg0[0] : f32 from vector<2xf32>
    %1 = call @roundf(%0) : (f32) -> f32
    %2 = vector.extract %arg0[1] : f32 from vector<2xf32>
    %3 = call @roundf(%2) : (f32) -> f32
    %4 = vector.from_elements %1, %3 : vector<2xf32>
    %5 = vector.extract %arg1[0] : f64 from vector<2xf64>
    %6 = call @round(%5) : (f64) -> f64
    %7 = vector.extract %arg1[1] : f64 from vector<2xf64>
    %8 = call @round(%7) : (f64) -> f64
    %9 = vector.from_elements %6, %8 : vector<2xf64>
    return %4, %9 : vector<2xf32>, vector<2xf64>
  }
  func.func @roundeven_vec_caller(%arg0: vector<2xf32>, %arg1: vector<2xf64>) -> (vector<2xf32>, vector<2xf64>) {
    %0 = vector.extract %arg0[0] : f32 from vector<2xf32>
    %1 = call @roundevenf(%0) : (f32) -> f32
    %2 = vector.extract %arg0[1] : f32 from vector<2xf32>
    %3 = call @roundevenf(%2) : (f32) -> f32
    %4 = vector.from_elements %1, %3 : vector<2xf32>
    %5 = vector.extract %arg1[0] : f64 from vector<2xf64>
    %6 = call @roundeven(%5) : (f64) -> f64
    %7 = vector.extract %arg1[1] : f64 from vector<2xf64>
    %8 = call @roundeven(%7) : (f64) -> f64
    %9 = vector.from_elements %6, %8 : vector<2xf64>
    return %4, %9 : vector<2xf32>, vector<2xf64>
  }
  func.func @trunc_vec_caller(%arg0: vector<2xf32>, %arg1: vector<2xf64>) -> (vector<2xf32>, vector<2xf64>) {
    %0 = vector.extract %arg0[0] : f32 from vector<2xf32>
    %1 = call @truncf(%0) : (f32) -> f32
    %2 = vector.extract %arg0[1] : f32 from vector<2xf32>
    %3 = call @truncf(%2) : (f32) -> f32
    %4 = vector.from_elements %1, %3 : vector<2xf32>
    %5 = vector.extract %arg1[0] : f64 from vector<2xf64>
    %6 = call @trunc(%5) : (f64) -> f64
    %7 = vector.extract %arg1[1] : f64 from vector<2xf64>
    %8 = call @trunc(%7) : (f64) -> f64
    %9 = vector.from_elements %6, %8 : vector<2xf64>
    return %4, %9 : vector<2xf32>, vector<2xf64>
  }
  func.func @tan_caller(%arg0: f32, %arg1: f64, %arg2: f16, %arg3: bf16) -> (f32, f64, f16, bf16) {
    %0 = call @tanf(%arg0) : (f32) -> f32
    %1 = call @tan(%arg1) : (f64) -> f64
    %2 = arith.extf %arg2 : f16 to f32
    %3 = call @tanf(%2) : (f32) -> f32
    %4 = arith.truncf %3 : f32 to f16
    %5 = arith.extf %arg3 : bf16 to f32
    %6 = call @tanf(%5) : (f32) -> f32
    %7 = arith.truncf %6 : f32 to bf16
    return %0, %1, %4, %7 : f32, f64, f16, bf16
  }
  func.func @tan_vec_caller(%arg0: vector<2xf32>, %arg1: vector<2xf64>) -> (vector<2xf32>, vector<2xf64>) {
    %0 = vector.extract %arg0[0] : f32 from vector<2xf32>
    %1 = call @tanf(%0) : (f32) -> f32
    %2 = vector.extract %arg0[1] : f32 from vector<2xf32>
    %3 = call @tanf(%2) : (f32) -> f32
    %4 = vector.from_elements %1, %3 : vector<2xf32>
    %5 = vector.extract %arg1[0] : f64 from vector<2xf64>
    %6 = call @tan(%5) : (f64) -> f64
    %7 = vector.extract %arg1[1] : f64 from vector<2xf64>
    %8 = call @tan(%7) : (f64) -> f64
    %9 = vector.from_elements %6, %8 : vector<2xf64>
    return %4, %9 : vector<2xf32>, vector<2xf64>
  }
  func.func @log1p_caller(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = call @log1pf(%arg0) : (f32) -> f32
    %1 = call @log1p(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
  func.func @floor_caller(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = call @floorf(%arg0) : (f32) -> f32
    %1 = call @floor(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
  func.func @ceil_caller(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = call @ceilf(%arg0) : (f32) -> f32
    %1 = call @ceil(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
  func.func @sqrt_caller(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = call @sqrtf(%arg0) : (f32) -> f32
    %1 = call @sqrt(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
  func.func @sqrt_vec_caller(%arg0: vector<2xf32>, %arg1: vector<2xf64>) -> (vector<2xf32>, vector<2xf64>) {
    %0 = vector.extract %arg0[0] : f32 from vector<2xf32>
    %1 = call @sqrtf(%0) : (f32) -> f32
    %2 = vector.extract %arg0[1] : f32 from vector<2xf32>
    %3 = call @sqrtf(%2) : (f32) -> f32
    %4 = vector.from_elements %1, %3 : vector<2xf32>
    %5 = vector.extract %arg1[0] : f64 from vector<2xf64>
    %6 = call @sqrt(%5) : (f64) -> f64
    %7 = vector.extract %arg1[1] : f64 from vector<2xf64>
    %8 = call @sqrt(%7) : (f64) -> f64
    %9 = vector.from_elements %6, %8 : vector<2xf64>
    return %4, %9 : vector<2xf32>, vector<2xf64>
  }
  func.func @rsqrt_caller(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = call @rsqrtf(%arg0) : (f32) -> f32
    %1 = call @rsqrt(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
  func.func @rsqrt_vec_caller(%arg0: vector<2xf32>, %arg1: vector<2xf64>) -> (vector<2xf32>, vector<2xf64>) {
    %0 = vector.extract %arg0[0] : f32 from vector<2xf32>
    %1 = call @rsqrtf(%0) : (f32) -> f32
    %2 = vector.extract %arg0[1] : f32 from vector<2xf32>
    %3 = call @rsqrtf(%2) : (f32) -> f32
    %4 = vector.from_elements %1, %3 : vector<2xf32>
    %5 = vector.extract %arg1[0] : f64 from vector<2xf64>
    %6 = call @rsqrt(%5) : (f64) -> f64
    %7 = vector.extract %arg1[1] : f64 from vector<2xf64>
    %8 = call @rsqrt(%7) : (f64) -> f64
    %9 = vector.from_elements %6, %8 : vector<2xf64>
    return %4, %9 : vector<2xf32>, vector<2xf64>
  }
  func.func @powf_caller(%arg0: f32, %arg1: f32, %arg2: f64, %arg3: f64) -> (f32, f64) {
    %0 = call @powf(%arg0, %arg1) : (f32, f32) -> f32
    %1 = call @pow(%arg2, %arg3) : (f64, f64) -> f64
    return %0, %1 : f32, f64
  }
  func.func @powf_vec_caller(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf64>, %arg3: vector<2xf64>) -> (vector<2xf32>, vector<2xf64>) {
    %0 = vector.extract %arg0[0] : f32 from vector<2xf32>
    %1 = vector.extract %arg1[0] : f32 from vector<2xf32>
    %2 = call @powf(%0, %1) : (f32, f32) -> f32
    %3 = vector.extract %arg0[1] : f32 from vector<2xf32>
    %4 = vector.extract %arg1[1] : f32 from vector<2xf32>
    %5 = call @powf(%3, %4) : (f32, f32) -> f32
    %6 = vector.from_elements %2, %5 : vector<2xf32>
    %7 = vector.extract %arg2[0] : f64 from vector<2xf64>
    %8 = vector.extract %arg3[0] : f64 from vector<2xf64>
    %9 = call @pow(%7, %8) : (f64, f64) -> f64
    %10 = vector.extract %arg2[1] : f64 from vector<2xf64>
    %11 = vector.extract %arg3[1] : f64 from vector<2xf64>
    %12 = call @pow(%10, %11) : (f64, f64) -> f64
    %13 = vector.from_elements %9, %12 : vector<2xf64>
    return %6, %13 : vector<2xf32>, vector<2xf64>
  }
}

