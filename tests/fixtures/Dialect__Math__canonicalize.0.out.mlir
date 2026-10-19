module {
  func.func @ceil_fold() -> f32 {
    %cst = arith.constant 1.000000e+00 : f32
    return %cst : f32
  }
  func.func @ceil_fold2() -> f32 {
    %cst = arith.constant 2.000000e+00 : f32
    return %cst : f32
  }
  func.func @log2_fold() -> f32 {
    %cst = arith.constant 2.000000e+00 : f32
    return %cst : f32
  }
  func.func @log2_fold2() -> f32 {
    %cst = arith.constant 0xFF800000 : f32
    return %cst : f32
  }
  func.func @log2_nofold2() -> f32 {
    %cst = arith.constant -1.000000e+00 : f32
    %0 = math.log2 %cst : f32
    return %0 : f32
  }
  func.func @log2_fold_64() -> f64 {
    %cst = arith.constant 2.000000e+00 : f64
    return %cst : f64
  }
  func.func @log2_fold2_64() -> f64 {
    %cst = arith.constant 0xFFF0000000000000 : f64
    return %cst : f64
  }
  func.func @log2_nofold2_64() -> f64 {
    %cst = arith.constant -1.000000e+00 : f64
    %0 = math.log2 %cst : f64
    return %0 : f64
  }
  func.func @log2_fold_vec() -> vector<4xf32> {
    %cst = arith.constant dense<[0.000000e+00, 1.000000e+00, 1.58496249, 2.000000e+00]> : vector<4xf32>
    return %cst : vector<4xf32>
  }
  func.func @powf_fold() -> f32 {
    %cst = arith.constant 4.000000e+00 : f32
    return %cst : f32
  }
  func.func @powf_fold_vec() -> vector<4xf32> {
    %cst = arith.constant dense<[1.000000e+00, 4.000000e+00, 9.000000e+00, 1.600000e+01]> : vector<4xf32>
    return %cst : vector<4xf32>
  }
  func.func @sqrt_fold() -> f32 {
    %cst = arith.constant 2.000000e+00 : f32
    return %cst : f32
  }
  func.func @sqrt_fold_vec() -> vector<4xf32> {
    %cst = arith.constant dense<[1.000000e+00, 1.41421354, 1.73205078, 2.000000e+00]> : vector<4xf32>
    return %cst : vector<4xf32>
  }
  func.func @abs_fold() -> f32 {
    %cst = arith.constant 4.000000e+00 : f32
    return %cst : f32
  }
  func.func @copysign_fold() -> f32 {
    %cst = arith.constant -4.000000e+00 : f32
    return %cst : f32
  }
  func.func @ctlz_fold1() -> i32 {
    %c31_i32 = arith.constant 31 : i32
    return %c31_i32 : i32
  }
  func.func @ctlz_fold2() -> i8 {
    %c7_i8 = arith.constant 7 : i8
    return %c7_i8 : i8
  }
  func.func @cttz_fold() -> i32 {
    %c8_i32 = arith.constant 8 : i32
    return %c8_i32 : i32
  }
  func.func @ctpop_fold() -> i32 {
    %c16_i32 = arith.constant 16 : i32
    return %c16_i32 : i32
  }
  func.func @log10_fold() -> f32 {
    %cst = arith.constant 2.000000e+00 : f32
    return %cst : f32
  }
  func.func @log10_fold_vec() -> vector<4xf32> {
    %cst = arith.constant dense<[0.000000e+00, 1.000000e+00, 2.000000e+00, 2.301030e+00]> : vector<4xf32>
    return %cst : vector<4xf32>
  }
  func.func @log1p_fold() -> f32 {
    %cst = arith.constant 2.8903718 : f32
    return %cst : f32
  }
  func.func @log1p_fold_vec() -> vector<4xf32> {
    %cst = arith.constant dense<[1.38629436, 1.79175949, 2.07944155, 2.48490667]> : vector<4xf32>
    return %cst : vector<4xf32>
  }
  func.func @log_fold() -> f32 {
    %cst = arith.constant 0.693147182 : f32
    return %cst : f32
  }
  func.func @log_fold_vec() -> vector<4xf32> {
    %cst = arith.constant dense<[0.000000e+00, 0.693147182, 1.09861231, 1.38629436]> : vector<4xf32>
    return %cst : vector<4xf32>
  }
  func.func @exp_fold() -> f32 {
    %cst = arith.constant 7.3890562 : f32
    return %cst : f32
  }
  func.func @exp_fold_vec() -> vector<4xf32> {
    %cst = arith.constant dense<[2.71828175, 7.3890562, 20.085537, 54.5981483]> : vector<4xf32>
    return %cst : vector<4xf32>
  }
  func.func @exp2_fold() -> f32 {
    %cst = arith.constant 4.000000e+00 : f32
    return %cst : f32
  }
  func.func @exp2_fold_vec() -> vector<4xf32> {
    %cst = arith.constant dense<[2.000000e+00, 4.000000e+00, 8.000000e+00, 1.600000e+01]> : vector<4xf32>
    return %cst : vector<4xf32>
  }
  func.func @expm1_fold() -> f32 {
    %cst = arith.constant 6.3890562 : f32
    return %cst : f32
  }
  func.func @expm1_fold_vec() -> vector<4xf32> {
    %cst = arith.constant dense<[0.000000e+00, 1.71828175, 0.000000e+00, 1.71828175]> : vector<4xf32>
    return %cst : vector<4xf32>
  }
  func.func @tan_fold() -> f32 {
    %cst = arith.constant 1.55740774 : f32
    return %cst : f32
  }
  func.func @tan_fold_vec() -> vector<4xf32> {
    %cst = arith.constant dense<[0.000000e+00, 1.55740774, 0.000000e+00, 1.55740774]> : vector<4xf32>
    return %cst : vector<4xf32>
  }
  func.func @tanh_fold() -> f32 {
    %cst = arith.constant 0.761594176 : f32
    return %cst : f32
  }
  func.func @tanh_fold_vec() -> vector<4xf32> {
    %cst = arith.constant dense<[0.000000e+00, 0.761594176, 0.000000e+00, 0.761594176]> : vector<4xf32>
    return %cst : vector<4xf32>
  }
  func.func @atan_fold() -> f32 {
    %cst = arith.constant 0.785398185 : f32
    return %cst : f32
  }
  func.func @atan_fold_vec() -> vector<4xf32> {
    %cst = arith.constant dense<[0.000000e+00, 0.785398185, 0.000000e+00, 0.785398185]> : vector<4xf32>
    return %cst : vector<4xf32>
  }
  func.func @atan2_fold() -> f32 {
    %cst = arith.constant 0.000000e+00 : f32
    return %cst : f32
  }
  func.func @atan2_fold_vec() -> vector<4xf32> {
    %cst = arith.constant dense<[0.000000e+00, 0.000000e+00, 0.463647604, 0.463647604]> : vector<4xf32>
    return %cst : vector<4xf32>
  }
  func.func @cos_fold() -> f32 {
    %cst = arith.constant 0.540302277 : f32
    return %cst : f32
  }
  func.func @cos_fold_vec() -> vector<4xf32> {
    %cst = arith.constant dense<[1.000000e+00, 0.540302277, 1.000000e+00, 0.540302277]> : vector<4xf32>
    return %cst : vector<4xf32>
  }
  func.func @roundeven_fold() -> f32 {
    %cst = arith.constant 2.000000e+00 : f32
    return %cst : f32
  }
  func.func @roundeven_fold_vec() -> vector<4xf32> {
    %cst = arith.constant dense<[0.000000e+00, -0.000000e+00, 2.000000e+00, -2.000000e+00]> : vector<4xf32>
    return %cst : vector<4xf32>
  }
  func.func @round_fold() -> f32 {
    %cst = arith.constant 2.000000e+00 : f32
    return %cst : f32
  }
  func.func @round_fold_vec() -> vector<4xf32> {
    %cst = arith.constant dense<[1.000000e+00, -1.000000e+00, 2.000000e+00, -2.000000e+00]> : vector<4xf32>
    return %cst : vector<4xf32>
  }
  func.func @floor_fold() -> f32 {
    %cst = arith.constant 0.000000e+00 : f32
    return %cst : f32
  }
  func.func @floor_fold2() -> f32 {
    %cst = arith.constant 2.000000e+00 : f32
    return %cst : f32
  }
  func.func @trunc_fold() -> f32 {
    %cst = arith.constant 1.000000e+00 : f32
    return %cst : f32
  }
  func.func @trunc_fold_vec() -> vector<4xf32> {
    %cst = arith.constant dense<[0.000000e+00, -0.000000e+00, 1.000000e+00, -1.000000e+00]> : vector<4xf32>
    return %cst : vector<4xf32>
  }
  func.func @sin_fold() -> f32 {
    %cst = arith.constant 0.841470957 : f32
    return %cst : f32
  }
  func.func @sin_fold_vec() -> vector<4xf32> {
    %cst = arith.constant dense<[0.000000e+00, 0.841470957, 0.000000e+00, 0.841470957]> : vector<4xf32>
    return %cst : vector<4xf32>
  }
  func.func @erf_fold() -> f32 {
    %cst = arith.constant 0.842700779 : f32
    return %cst : f32
  }
  func.func @erf_fold_vec() -> vector<4xf32> {
    %cst = arith.constant dense<[0.000000e+00, 0.842700779, 0.000000e+00, 0.842700779]> : vector<4xf32>
    return %cst : vector<4xf32>
  }
  func.func @abs_poison() -> f32 {
    %0 = ub.poison : f32
    return %0 : f32
  }
  func.func @isfinite_fold() -> i1 {
    %true = arith.constant true
    return %true : i1
  }
  func.func @isfinite_fold_vec() -> vector<4xi1> {
    %cst = arith.constant dense<true> : vector<4xi1>
    return %cst : vector<4xi1>
  }
  func.func @isinf_fold() -> i1 {
    %false = arith.constant false
    return %false : i1
  }
  func.func @isinf_fold_vec() -> vector<4xi1> {
    %cst = arith.constant dense<false> : vector<4xi1>
    return %cst : vector<4xi1>
  }
  func.func @isnan_fold() -> i1 {
    %false = arith.constant false
    return %false : i1
  }
  func.func @isnan_fold_vec() -> vector<4xi1> {
    %cst = arith.constant dense<false> : vector<4xi1>
    return %cst : vector<4xi1>
  }
  func.func @isnormal_fold() -> i1 {
    %true = arith.constant true
    return %true : i1
  }
  func.func @isnormal_fold_vec() -> vector<4xi1> {
    %cst = arith.constant dense<true> : vector<4xi1>
    return %cst : vector<4xi1>
  }
}

