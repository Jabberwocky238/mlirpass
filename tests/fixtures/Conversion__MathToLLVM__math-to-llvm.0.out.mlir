module {
  func.func @ops(%arg0: f32, %arg1: f32, %arg2: i32, %arg3: i32, %arg4: f64) {
    %0 = llvm.intr.exp(%arg0) : (f32) -> f32
    %1 = llvm.intr.exp2(%arg0) : (f32) -> f32
    %2 = llvm.intr.sqrt(%arg0) : (f32) -> f32
    %3 = llvm.intr.sqrt(%arg4) : (f64) -> f64
    return
  }
}

// -----
module {
  func.func @absi(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32
    return %0 : i32
  }
}

// -----
module {
  func.func @absi_0dvector(%arg0: vector<i32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<i32> to vector<1xi32>
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = false}> : (vector<1xi32>) -> vector<1xi32>
    return
  }
}

// -----
module {
  func.func @log1p(%arg0: f32) {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fadd %0, %arg0 : f32
    %2 = llvm.intr.log(%1) : (f32) -> f32
    return
  }
}

// -----
module {
  func.func @log1p_fmf(%arg0: f32) {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fadd %0, %arg0 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %2 = llvm.intr.log(%1) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    return
  }
}

// -----
module {
  func.func @log1p_2dvector(%arg0: vector<4x3xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4x3xf32> to !llvm.array<4 x vector<3xf32>>
    %1 = llvm.mlir.poison : !llvm.array<4 x vector<3xf32>>
    %2 = llvm.extractvalue %0[0] : !llvm.array<4 x vector<3xf32>> 
    %3 = llvm.mlir.constant(dense<1.000000e+00> : vector<3xf32>) : vector<3xf32>
    %4 = llvm.fadd %3, %2 : vector<3xf32>
    %5 = llvm.intr.log(%4) : (vector<3xf32>) -> vector<3xf32>
    %6 = llvm.insertvalue %5, %1[0] : !llvm.array<4 x vector<3xf32>> 
    %7 = llvm.extractvalue %0[1] : !llvm.array<4 x vector<3xf32>> 
    %8 = llvm.mlir.constant(dense<1.000000e+00> : vector<3xf32>) : vector<3xf32>
    %9 = llvm.fadd %8, %7 : vector<3xf32>
    %10 = llvm.intr.log(%9) : (vector<3xf32>) -> vector<3xf32>
    %11 = llvm.insertvalue %10, %6[1] : !llvm.array<4 x vector<3xf32>> 
    %12 = llvm.extractvalue %0[2] : !llvm.array<4 x vector<3xf32>> 
    %13 = llvm.mlir.constant(dense<1.000000e+00> : vector<3xf32>) : vector<3xf32>
    %14 = llvm.fadd %13, %12 : vector<3xf32>
    %15 = llvm.intr.log(%14) : (vector<3xf32>) -> vector<3xf32>
    %16 = llvm.insertvalue %15, %11[2] : !llvm.array<4 x vector<3xf32>> 
    %17 = llvm.extractvalue %0[3] : !llvm.array<4 x vector<3xf32>> 
    %18 = llvm.mlir.constant(dense<1.000000e+00> : vector<3xf32>) : vector<3xf32>
    %19 = llvm.fadd %18, %17 : vector<3xf32>
    %20 = llvm.intr.log(%19) : (vector<3xf32>) -> vector<3xf32>
    %21 = llvm.insertvalue %20, %16[3] : !llvm.array<4 x vector<3xf32>> 
    return
  }
}

// -----
module {
  func.func @log1p_2dvector_fmf(%arg0: vector<4x3xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4x3xf32> to !llvm.array<4 x vector<3xf32>>
    %1 = llvm.mlir.poison : !llvm.array<4 x vector<3xf32>>
    %2 = llvm.extractvalue %0[0] : !llvm.array<4 x vector<3xf32>> 
    %3 = llvm.mlir.constant(dense<1.000000e+00> : vector<3xf32>) : vector<3xf32>
    %4 = llvm.fadd %3, %2 {fastmathFlags = #llvm.fastmath<fast>} : vector<3xf32>
    %5 = llvm.intr.log(%4) {fastmathFlags = #llvm.fastmath<fast>} : (vector<3xf32>) -> vector<3xf32>
    %6 = llvm.insertvalue %5, %1[0] : !llvm.array<4 x vector<3xf32>> 
    %7 = llvm.extractvalue %0[1] : !llvm.array<4 x vector<3xf32>> 
    %8 = llvm.mlir.constant(dense<1.000000e+00> : vector<3xf32>) : vector<3xf32>
    %9 = llvm.fadd %8, %7 {fastmathFlags = #llvm.fastmath<fast>} : vector<3xf32>
    %10 = llvm.intr.log(%9) {fastmathFlags = #llvm.fastmath<fast>} : (vector<3xf32>) -> vector<3xf32>
    %11 = llvm.insertvalue %10, %6[1] : !llvm.array<4 x vector<3xf32>> 
    %12 = llvm.extractvalue %0[2] : !llvm.array<4 x vector<3xf32>> 
    %13 = llvm.mlir.constant(dense<1.000000e+00> : vector<3xf32>) : vector<3xf32>
    %14 = llvm.fadd %13, %12 {fastmathFlags = #llvm.fastmath<fast>} : vector<3xf32>
    %15 = llvm.intr.log(%14) {fastmathFlags = #llvm.fastmath<fast>} : (vector<3xf32>) -> vector<3xf32>
    %16 = llvm.insertvalue %15, %11[2] : !llvm.array<4 x vector<3xf32>> 
    %17 = llvm.extractvalue %0[3] : !llvm.array<4 x vector<3xf32>> 
    %18 = llvm.mlir.constant(dense<1.000000e+00> : vector<3xf32>) : vector<3xf32>
    %19 = llvm.fadd %18, %17 {fastmathFlags = #llvm.fastmath<fast>} : vector<3xf32>
    %20 = llvm.intr.log(%19) {fastmathFlags = #llvm.fastmath<fast>} : (vector<3xf32>) -> vector<3xf32>
    %21 = llvm.insertvalue %20, %16[3] : !llvm.array<4 x vector<3xf32>> 
    return
  }
}

// -----
module {
  func.func @log1p_scalable_vector(%arg0: vector<[4]xf32>) -> vector<[4]xf32> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<[4]xf32>) : vector<[4]xf32>
    %1 = llvm.fadd %0, %arg0 : vector<[4]xf32>
    %2 = llvm.intr.log(%1) : (vector<[4]xf32>) -> vector<[4]xf32>
    return %2 : vector<[4]xf32>
  }
}

// -----
module {
  func.func @log1p_0dvector(%arg0: vector<f32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<f32> to vector<1xf32>
    %1 = llvm.mlir.constant(dense<1.000000e+00> : vector<1xf32>) : vector<1xf32>
    %2 = llvm.fadd %1, %0 : vector<1xf32>
    %3 = llvm.intr.log(%2) : (vector<1xf32>) -> vector<1xf32>
    return
  }
}

// -----
module {
  func.func @expm1(%arg0: f32) {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.exp(%arg0) : (f32) -> f32
    %2 = llvm.fsub %1, %0 : f32
    return
  }
}

// -----
module {
  func.func @expm1_fmf(%arg0: f32) {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.exp(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    %2 = llvm.fsub %1, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32
    return
  }
}

// -----
module {
  func.func @expm1_vector(%arg0: vector<4xf32>) {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.intr.exp(%arg0) : (vector<4xf32>) -> vector<4xf32>
    %2 = llvm.fsub %1, %0 : vector<4xf32>
    return
  }
}

// -----
module {
  func.func @expm1_scalable_vector(%arg0: vector<[4]xf32>) -> vector<[4]xf32> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<[4]xf32>) : vector<[4]xf32>
    %1 = llvm.intr.exp(%arg0) : (vector<[4]xf32>) -> vector<[4]xf32>
    %2 = llvm.fsub %1, %0 : vector<[4]xf32>
    return %2 : vector<[4]xf32>
  }
}

// -----
module {
  func.func @expm1_vector_fmf(%arg0: vector<4xf32>) {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.intr.exp(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (vector<4xf32>) -> vector<4xf32>
    %2 = llvm.fsub %1, %0 {fastmathFlags = #llvm.fastmath<fast>} : vector<4xf32>
    return
  }
}

// -----
module {
  func.func @expm1_0dvector(%arg0: vector<f32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<f32> to vector<1xf32>
    %1 = llvm.mlir.constant(dense<1.000000e+00> : vector<1xf32>) : vector<1xf32>
    %2 = llvm.intr.exp(%0) : (vector<1xf32>) -> vector<1xf32>
    %3 = llvm.fsub %2, %1 : vector<1xf32>
    return
  }
}

// -----
module {
  func.func @rsqrt(%arg0: f32) {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.sqrt(%arg0) : (f32) -> f32
    %2 = llvm.fdiv %0, %1 : f32
    return
  }
}

// -----
module {
  func.func @rsqrt_0dvector(%arg0: vector<f32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<f32> to vector<1xf32>
    %1 = llvm.mlir.constant(dense<1.000000e+00> : vector<1xf32>) : vector<1xf32>
    %2 = llvm.intr.sqrt(%0) : (vector<1xf32>) -> vector<1xf32>
    %3 = llvm.fdiv %1, %2 : vector<1xf32>
    return
  }
}

// -----
module {
  func.func @trigonometrics(%arg0: f32) {
    %0 = llvm.intr.sin(%arg0) : (f32) -> f32
    %1 = llvm.intr.cos(%arg0) : (f32) -> f32
    %2 = llvm.intr.tan(%arg0) : (f32) -> f32
    return
  }
}

// -----
module {
  func.func @sincos(%arg0: f32) {
    %0 = llvm.intr.sincos(%arg0) : (f32) -> !llvm.struct<(f32, f32)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(f32, f32)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(f32, f32)> 
    return
  }
}

// -----
module {
  func.func @inverse_trigonometrics(%arg0: f32) {
    %0 = llvm.intr.asin(%arg0) : (f32) -> f32
    %1 = llvm.intr.acos(%arg0) : (f32) -> f32
    %2 = llvm.intr.atan(%arg0) : (f32) -> f32
    return
  }
}

// -----
module {
  func.func @atan2(%arg0: f32, %arg1: f32) {
    %0 = llvm.intr.atan2(%arg0, %arg1) : (f32, f32) -> f32
    return
  }
}

// -----
module {
  func.func @inverse_trigonometrics_vector(%arg0: vector<4xf32>) {
    %0 = llvm.intr.asin(%arg0) : (vector<4xf32>) -> vector<4xf32>
    %1 = llvm.intr.acos(%arg0) : (vector<4xf32>) -> vector<4xf32>
    %2 = llvm.intr.atan(%arg0) : (vector<4xf32>) -> vector<4xf32>
    return
  }
}

// -----
module {
  func.func @atan2_vector(%arg0: vector<4xf32>, %arg1: vector<4xf32>) {
    %0 = llvm.intr.atan2(%arg0, %arg1) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    return
  }
}

// -----
module {
  func.func @inverse_trigonometrics_fmf(%arg0: f32) {
    %0 = llvm.intr.asin(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    %1 = llvm.intr.acos(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    %2 = llvm.intr.atan(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    return
  }
}

// -----
module {
  func.func @atan2_fmf(%arg0: f32, %arg1: f32) {
    %0 = llvm.intr.atan2(%arg0, %arg1) {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32
    return
  }
}

// -----
module {
  func.func @hyperbolics(%arg0: f32) {
    %0 = llvm.intr.sinh(%arg0) : (f32) -> f32
    %1 = llvm.intr.cosh(%arg0) : (f32) -> f32
    %2 = llvm.intr.tanh(%arg0) : (f32) -> f32
    return
  }
}

// -----
module {
  func.func @ctlz(%arg0: i32) {
    %0 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    return
  }
  func.func @ctlz_0dvector(%arg0: vector<i32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<i32> to vector<1xi32>
    %1 = "llvm.intr.ctlz"(%0) <{is_zero_poison = false}> : (vector<1xi32>) -> vector<1xi32>
    return
  }
}

// -----
module {
  func.func @cttz(%arg0: i32) {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    return
  }
}

// -----
module {
  func.func @cttz_0dvector(%arg0: vector<i32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<i32> to vector<1xi32>
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = false}> : (vector<1xi32>) -> vector<1xi32>
    return
  }
}

// -----
module {
  func.func @cttz_vec(%arg0: vector<4xi32>) {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<4xi32>) -> vector<4xi32>
    return
  }
}

// -----
module {
  func.func @cttz_scalable_vec(%arg0: vector<[4]xi32>) -> vector<[4]xi32> {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<[4]xi32>) -> vector<[4]xi32>
    return %0 : vector<[4]xi32>
  }
}

// -----
module {
  func.func @ctpop(%arg0: i32) {
    %0 = llvm.intr.ctpop(%arg0) : (i32) -> i32
    return
  }
}

// -----
module {
  func.func @ctpop_vector(%arg0: vector<3xi32>) {
    %0 = llvm.intr.ctpop(%arg0) : (vector<3xi32>) -> vector<3xi32>
    return
  }
}

// -----
module {
  func.func @ctpop_scalable_vector(%arg0: vector<[4]xi32>) -> vector<[4]xi32> {
    %0 = llvm.intr.ctpop(%arg0) : (vector<[4]xi32>) -> vector<[4]xi32>
    return %0 : vector<[4]xi32>
  }
}

// -----
module {
  func.func @isnan_double(%arg0: f64) {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 3 : i32}> : (f64) -> i1
    return
  }
}

// -----
module {
  func.func @isnan_0dvector(%arg0: vector<f32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<f32> to vector<1xf32>
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 3 : i32}> : (vector<1xf32>) -> vector<1xi1>
    return
  }
}

// -----
module {
  func.func @isfinite_double(%arg0: f64) {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 504 : i32}> : (f64) -> i1
    return
  }
}

// -----
module {
  func.func @isfinite_0dvector(%arg0: vector<f32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<f32> to vector<1xf32>
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 504 : i32}> : (vector<1xf32>) -> vector<1xi1>
    return
  }
}

// -----
module {
  func.func @rsqrt_double(%arg0: f64) {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.intr.sqrt(%arg0) : (f64) -> f64
    %2 = llvm.fdiv %0, %1 : f64
    return
  }
}

// -----
module {
  func.func @rsqrt_double_fmf(%arg0: f64) {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.intr.sqrt(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %2 = llvm.fdiv %0, %1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    return
  }
}

// -----
module {
  func.func @rsqrt_vector(%arg0: vector<4xf32>) {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.intr.sqrt(%arg0) : (vector<4xf32>) -> vector<4xf32>
    %2 = llvm.fdiv %0, %1 : vector<4xf32>
    return
  }
}

// -----
module {
  func.func @rsqrt_scalable_vector(%arg0: vector<[4]xf32>) -> vector<[4]xf32> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<[4]xf32>) : vector<[4]xf32>
    %1 = llvm.intr.sqrt(%arg0) : (vector<[4]xf32>) -> vector<[4]xf32>
    %2 = llvm.fdiv %0, %1 : vector<[4]xf32>
    return %2 : vector<[4]xf32>
  }
}

// -----
module {
  func.func @rsqrt_vector_fmf(%arg0: vector<4xf32>) {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.intr.sqrt(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (vector<4xf32>) -> vector<4xf32>
    %2 = llvm.fdiv %0, %1 {fastmathFlags = #llvm.fastmath<fast>} : vector<4xf32>
    return
  }
}

// -----
module {
  func.func @rsqrt_scalable_vector_fmf(%arg0: vector<[4]xf32>) -> vector<[4]xf32> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<[4]xf32>) : vector<[4]xf32>
    %1 = llvm.intr.sqrt(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (vector<[4]xf32>) -> vector<[4]xf32>
    %2 = llvm.fdiv %0, %1 {fastmathFlags = #llvm.fastmath<fast>} : vector<[4]xf32>
    return %2 : vector<[4]xf32>
  }
}

// -----
module {
  func.func @rsqrt_multidim_vector(%arg0: vector<4x3xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4x3xf32> to !llvm.array<4 x vector<3xf32>>
    %1 = llvm.mlir.poison : !llvm.array<4 x vector<3xf32>>
    %2 = llvm.extractvalue %0[0] : !llvm.array<4 x vector<3xf32>> 
    %3 = llvm.mlir.constant(dense<1.000000e+00> : vector<3xf32>) : vector<3xf32>
    %4 = llvm.intr.sqrt(%2) : (vector<3xf32>) -> vector<3xf32>
    %5 = llvm.fdiv %3, %4 : vector<3xf32>
    %6 = llvm.insertvalue %5, %1[0] : !llvm.array<4 x vector<3xf32>> 
    %7 = llvm.extractvalue %0[1] : !llvm.array<4 x vector<3xf32>> 
    %8 = llvm.mlir.constant(dense<1.000000e+00> : vector<3xf32>) : vector<3xf32>
    %9 = llvm.intr.sqrt(%7) : (vector<3xf32>) -> vector<3xf32>
    %10 = llvm.fdiv %8, %9 : vector<3xf32>
    %11 = llvm.insertvalue %10, %6[1] : !llvm.array<4 x vector<3xf32>> 
    %12 = llvm.extractvalue %0[2] : !llvm.array<4 x vector<3xf32>> 
    %13 = llvm.mlir.constant(dense<1.000000e+00> : vector<3xf32>) : vector<3xf32>
    %14 = llvm.intr.sqrt(%12) : (vector<3xf32>) -> vector<3xf32>
    %15 = llvm.fdiv %13, %14 : vector<3xf32>
    %16 = llvm.insertvalue %15, %11[2] : !llvm.array<4 x vector<3xf32>> 
    %17 = llvm.extractvalue %0[3] : !llvm.array<4 x vector<3xf32>> 
    %18 = llvm.mlir.constant(dense<1.000000e+00> : vector<3xf32>) : vector<3xf32>
    %19 = llvm.intr.sqrt(%17) : (vector<3xf32>) -> vector<3xf32>
    %20 = llvm.fdiv %18, %19 : vector<3xf32>
    %21 = llvm.insertvalue %20, %16[3] : !llvm.array<4 x vector<3xf32>> 
    return
  }
}

// -----
module {
  func.func @rsqrt_multidim_scalable_vector(%arg0: vector<4x[4]xf32>) -> vector<4x[4]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4x[4]xf32> to !llvm.array<4 x vector<[4]xf32>>
    %1 = llvm.mlir.poison : !llvm.array<4 x vector<[4]xf32>>
    %2 = llvm.extractvalue %0[0] : !llvm.array<4 x vector<[4]xf32>> 
    %3 = llvm.mlir.constant(dense<1.000000e+00> : vector<[4]xf32>) : vector<[4]xf32>
    %4 = llvm.intr.sqrt(%2) : (vector<[4]xf32>) -> vector<[4]xf32>
    %5 = llvm.fdiv %3, %4 : vector<[4]xf32>
    %6 = llvm.insertvalue %5, %1[0] : !llvm.array<4 x vector<[4]xf32>> 
    %7 = llvm.extractvalue %0[1] : !llvm.array<4 x vector<[4]xf32>> 
    %8 = llvm.mlir.constant(dense<1.000000e+00> : vector<[4]xf32>) : vector<[4]xf32>
    %9 = llvm.intr.sqrt(%7) : (vector<[4]xf32>) -> vector<[4]xf32>
    %10 = llvm.fdiv %8, %9 : vector<[4]xf32>
    %11 = llvm.insertvalue %10, %6[1] : !llvm.array<4 x vector<[4]xf32>> 
    %12 = llvm.extractvalue %0[2] : !llvm.array<4 x vector<[4]xf32>> 
    %13 = llvm.mlir.constant(dense<1.000000e+00> : vector<[4]xf32>) : vector<[4]xf32>
    %14 = llvm.intr.sqrt(%12) : (vector<[4]xf32>) -> vector<[4]xf32>
    %15 = llvm.fdiv %13, %14 : vector<[4]xf32>
    %16 = llvm.insertvalue %15, %11[2] : !llvm.array<4 x vector<[4]xf32>> 
    %17 = llvm.extractvalue %0[3] : !llvm.array<4 x vector<[4]xf32>> 
    %18 = llvm.mlir.constant(dense<1.000000e+00> : vector<[4]xf32>) : vector<[4]xf32>
    %19 = llvm.intr.sqrt(%17) : (vector<[4]xf32>) -> vector<[4]xf32>
    %20 = llvm.fdiv %18, %19 : vector<[4]xf32>
    %21 = llvm.insertvalue %20, %16[3] : !llvm.array<4 x vector<[4]xf32>> 
    %22 = builtin.unrealized_conversion_cast %21 : !llvm.array<4 x vector<[4]xf32>> to vector<4x[4]xf32>
    return %22 : vector<4x[4]xf32>
  }
}

// -----
module {
  func.func @fpowi(%arg0: f64, %arg1: i32) {
    %0 = llvm.intr.powi(%arg0, %arg1) : (f64, i32) -> f64
    return
  }
}

// -----
module {
  func.func @powf(%arg0: f64) {
    %0 = llvm.intr.pow(%arg0, %arg0) : (f64, f64) -> f64
    return
  }
}

// -----
module {
  func.func @round(%arg0: f32) {
    %0 = llvm.intr.round(%arg0) : (f32) -> f32
    return
  }
}

// -----
module {
  func.func @roundeven(%arg0: f32) {
    %0 = llvm.intr.roundeven(%arg0) : (f32) -> f32
    return
  }
}

// -----
module {
  func.func @trunc(%arg0: f32) {
    %0 = llvm.intr.trunc(%arg0) : (f32) -> f32
    return
  }
}

// -----
module {
  func.func @fastmath(%arg0: f32, %arg1: vector<4xf32>) {
    %0 = llvm.intr.trunc(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    %1 = llvm.intr.pow(%arg0, %arg0) {fastmathFlags = #llvm.fastmath<afn>} : (f32, f32) -> f32
    %2 = llvm.intr.sqrt(%arg0) : (f32) -> f32
    %3 = llvm.intr.fma(%arg0, %arg0, %arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32, f32) -> f32
    return
  }
}

// -----
module {
  func.func @unsupported_fp_type(%arg0: f4E2M1FN, %arg1: f4E2M1FN, %arg2: f4E2M1FN) {
    %0 = math.absf %arg0 : f4E2M1FN
    %1 = math.cos %arg0 : f4E2M1FN
    %2 = math.fma %arg1, %arg1, %arg2 : f4E2M1FN
    return
  }
}

