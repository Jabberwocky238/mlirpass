module @test_module {
  llvm.func @_Z25__spirv_ocl_native_divideff(f32, f32) -> f32
  llvm.func @_Z22__spirv_ocl_native_tand(f64) -> f64
  llvm.func @_Z23__spirv_ocl_native_sqrtf(f32) -> f32
  llvm.func @_Z22__spirv_ocl_native_sinDh(f16) -> f16
  llvm.func @_Z24__spirv_ocl_native_rsqrtd(f64) -> f64
  llvm.func @_Z23__spirv_ocl_native_powrDhDh(f16, f16) -> f16
  llvm.func @_Z24__spirv_ocl_native_log10d(f64) -> f64
  llvm.func @_Z23__spirv_ocl_native_log2f(f32) -> f32
  llvm.func @_Z22__spirv_ocl_native_logDh(f16) -> f16
  llvm.func @_Z23__spirv_ocl_native_exp2f(f32) -> f32
  llvm.func @_Z22__spirv_ocl_native_cosDh(f16) -> f16
  llvm.func @_Z22__spirv_ocl_native_expDv4_Dh(vector<4xf16>) -> vector<4xf16>
  llvm.func @_Z22__spirv_ocl_native_expDv16_f(vector<16xf32>) -> vector<16xf32>
  llvm.func @_Z22__spirv_ocl_native_expDv16_d(vector<16xf64>) -> vector<16xf64>
  llvm.func @_Z22__spirv_ocl_native_expDv8_d(vector<8xf64>) -> vector<8xf64>
  llvm.func @_Z22__spirv_ocl_native_expDv4_d(vector<4xf64>) -> vector<4xf64>
  llvm.func @_Z22__spirv_ocl_native_expDv3_d(vector<3xf64>) -> vector<3xf64>
  llvm.func @_Z22__spirv_ocl_native_expDv2_d(vector<2xf64>) -> vector<2xf64>
  llvm.func @_Z22__spirv_ocl_native_expd(f64) -> f64
  llvm.func @_Z22__spirv_ocl_native_expf(f32) -> f32
  llvm.func @_Z22__spirv_ocl_native_expDh(f16) -> f16
  func.func @math_ops() {
    %cst = arith.constant 1.000000e+00 : f16
    %cst_0 = arith.constant 1.000000e+00 : f32
    %cst_1 = arith.constant 1.000000e+00 : f64
    %0 = math.exp %cst : f16
    %1 = math.exp %cst_0 : f32
    %2 = math.exp %cst_1 : f64
    %3 = llvm.call @_Z22__spirv_ocl_native_expDh(%cst) {fastmathFlags = #llvm.fastmath<fast>} : (f16) -> f16
    %4 = llvm.call @_Z22__spirv_ocl_native_expf(%cst_0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    %5 = llvm.call @_Z22__spirv_ocl_native_expd(%cst_1) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %6 = llvm.call @_Z22__spirv_ocl_native_expDh(%cst) {fastmathFlags = #llvm.fastmath<afn>} : (f16) -> f16
    %7 = llvm.call @_Z22__spirv_ocl_native_expf(%cst_0) {fastmathFlags = #llvm.fastmath<afn>} : (f32) -> f32
    %8 = llvm.call @_Z22__spirv_ocl_native_expd(%cst_1) {fastmathFlags = #llvm.fastmath<afn>} : (f64) -> f64
    %9 = math.exp %cst : f16
    %10 = math.exp %cst_0 : f32
    %11 = math.exp %cst_1 : f64
    %cst_2 = arith.constant dense<1.000000e+00> : vector<2xf64>
    %cst_3 = arith.constant dense<1.000000e+00> : vector<3xf64>
    %cst_4 = arith.constant dense<1.000000e+00> : vector<4xf64>
    %cst_5 = arith.constant dense<1.000000e+00> : vector<8xf64>
    %cst_6 = arith.constant dense<1.000000e+00> : vector<16xf64>
    %12 = llvm.call @_Z22__spirv_ocl_native_expDv2_d(%cst_2) {fastmathFlags = #llvm.fastmath<afn>} : (vector<2xf64>) -> vector<2xf64>
    %13 = llvm.call @_Z22__spirv_ocl_native_expDv3_d(%cst_3) {fastmathFlags = #llvm.fastmath<afn>} : (vector<3xf64>) -> vector<3xf64>
    %14 = llvm.call @_Z22__spirv_ocl_native_expDv4_d(%cst_4) {fastmathFlags = #llvm.fastmath<afn>} : (vector<4xf64>) -> vector<4xf64>
    %15 = llvm.call @_Z22__spirv_ocl_native_expDv8_d(%cst_5) {fastmathFlags = #llvm.fastmath<afn>} : (vector<8xf64>) -> vector<8xf64>
    %16 = llvm.call @_Z22__spirv_ocl_native_expDv16_d(%cst_6) {fastmathFlags = #llvm.fastmath<afn>} : (vector<16xf64>) -> vector<16xf64>
    %cst_7 = arith.constant dense<1.000000e+00> : vector<16xf32>
    %cst_8 = arith.constant dense<1.000000e+00> : vector<4xf16>
    %17 = llvm.call @_Z22__spirv_ocl_native_expDv16_f(%cst_7) {fastmathFlags = #llvm.fastmath<fast>} : (vector<16xf32>) -> vector<16xf32>
    %18 = llvm.call @_Z22__spirv_ocl_native_expDv4_Dh(%cst_8) {fastmathFlags = #llvm.fastmath<fast>} : (vector<4xf16>) -> vector<4xf16>
    %cst_9 = arith.constant dense<1.000000e+00> : vector<5xf64>
    %cst_10 = arith.constant dense<1.000000e+00> : vector<32xf64>
    %19 = math.exp %cst_9 fastmath<afn> : vector<5xf64>
    %20 = math.exp %cst_10 fastmath<afn> : vector<32xf64>
    %21 = llvm.call @_Z22__spirv_ocl_native_expDh(%cst) {fastmathFlags = #llvm.fastmath<fast>} : (f16) -> f16
    %22 = llvm.call @_Z22__spirv_ocl_native_expf(%cst_0) {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz, arcp, contract, afn>} : (f32) -> f32
    %23 = llvm.call @_Z22__spirv_ocl_native_expf(%cst_0) {fastmathFlags = #llvm.fastmath<nnan, afn, reassoc>} : (f32) -> f32
    %24 = llvm.call @_Z22__spirv_ocl_native_cosDh(%cst) {fastmathFlags = #llvm.fastmath<afn>} : (f16) -> f16
    %25 = llvm.call @_Z23__spirv_ocl_native_exp2f(%cst_0) {fastmathFlags = #llvm.fastmath<afn>} : (f32) -> f32
    %26 = llvm.call @_Z22__spirv_ocl_native_logDh(%cst) {fastmathFlags = #llvm.fastmath<afn>} : (f16) -> f16
    %27 = llvm.call @_Z23__spirv_ocl_native_log2f(%cst_0) {fastmathFlags = #llvm.fastmath<afn>} : (f32) -> f32
    %28 = llvm.call @_Z24__spirv_ocl_native_log10d(%cst_1) {fastmathFlags = #llvm.fastmath<afn>} : (f64) -> f64
    %29 = llvm.call @_Z23__spirv_ocl_native_powrDhDh(%cst, %cst) {fastmathFlags = #llvm.fastmath<afn>} : (f16, f16) -> f16
    %30 = llvm.call @_Z24__spirv_ocl_native_rsqrtd(%cst_1) {fastmathFlags = #llvm.fastmath<afn>} : (f64) -> f64
    %31 = llvm.call @_Z22__spirv_ocl_native_sinDh(%cst) {fastmathFlags = #llvm.fastmath<afn>} : (f16) -> f16
    %32 = llvm.call @_Z23__spirv_ocl_native_sqrtf(%cst_0) {fastmathFlags = #llvm.fastmath<afn>} : (f32) -> f32
    %33 = llvm.call @_Z22__spirv_ocl_native_tand(%cst_1) {fastmathFlags = #llvm.fastmath<afn>} : (f64) -> f64
    %cst_11 = arith.constant 6.900000e+00 : f32
    %cst_12 = arith.constant 7.000000e+00 : f32
    %34 = llvm.call @_Z25__spirv_ocl_native_divideff(%cst_11, %cst_12) {fastmathFlags = #llvm.fastmath<afn>} : (f32, f32) -> f32
    return
  }
  gpu.module @test_gpu {
    llvm.func @_Z22__spirv_ocl_native_expf(f32) -> f32
    gpu.func @exp_gpu() {
      %cst = arith.constant 1.000000e+00 : f32
      %0 = math.exp %cst : f32
      %1 = llvm.call @_Z22__spirv_ocl_native_expf(%cst) {fastmathFlags = #llvm.fastmath<afn>} : (f32) -> f32
      gpu.return
    }
  }
  func.func @exp_func() {
    %cst = arith.constant 1.000000e+00 : f32
    %0 = math.exp %cst : f32
    %1 = llvm.call @_Z22__spirv_ocl_native_expf(%cst) {fastmathFlags = #llvm.fastmath<afn>} : (f32) -> f32
    return
  }
}

