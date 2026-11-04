module @test_module {
  func.func @math_ops() {
    %cst = arith.constant 1.000000e+00 : f16
    %cst_0 = arith.constant 1.000000e+00 : f32
    %cst_1 = arith.constant 1.000000e+00 : f64
    %0 = math.exp %cst : f16
    %1 = math.exp %cst_0 : f32
    %2 = math.exp %cst_1 : f64
    %3 = math.exp %cst fastmath<fast> : f16
    %4 = math.exp %cst_0 fastmath<fast> : f32
    %5 = math.exp %cst_1 fastmath<fast> : f64
    %6 = math.exp %cst fastmath<afn> : f16
    %7 = math.exp %cst_0 fastmath<afn> : f32
    %8 = math.exp %cst_1 fastmath<afn> : f64
    %9 = math.exp %cst : f16
    %10 = math.exp %cst_0 : f32
    %11 = math.exp %cst_1 : f64
    %cst_2 = arith.constant dense<1.000000e+00> : vector<2xf64>
    %cst_3 = arith.constant dense<1.000000e+00> : vector<3xf64>
    %cst_4 = arith.constant dense<1.000000e+00> : vector<4xf64>
    %cst_5 = arith.constant dense<1.000000e+00> : vector<8xf64>
    %cst_6 = arith.constant dense<1.000000e+00> : vector<16xf64>
    %12 = math.exp %cst_2 fastmath<afn> : vector<2xf64>
    %13 = math.exp %cst_3 fastmath<afn> : vector<3xf64>
    %14 = math.exp %cst_4 fastmath<afn> : vector<4xf64>
    %15 = math.exp %cst_5 fastmath<afn> : vector<8xf64>
    %16 = math.exp %cst_6 fastmath<afn> : vector<16xf64>
    %cst_7 = arith.constant dense<1.000000e+00> : vector<16xf32>
    %cst_8 = arith.constant dense<1.000000e+00> : vector<4xf16>
    %17 = math.exp %cst_7 fastmath<fast> : vector<16xf32>
    %18 = math.exp %cst_8 fastmath<fast> : vector<4xf16>
    %cst_9 = arith.constant dense<1.000000e+00> : vector<5xf64>
    %cst_10 = arith.constant dense<1.000000e+00> : vector<32xf64>
    %19 = math.exp %cst_9 fastmath<afn> : vector<5xf64>
    %20 = math.exp %cst_10 fastmath<afn> : vector<32xf64>
    %21 = math.exp %cst fastmath<fast> : f16
    %22 = math.exp %cst_0 fastmath<nnan,ninf,nsz,arcp,contract,afn> : f32
    %23 = math.exp %cst_0 fastmath<reassoc,nnan,afn> : f32
    %24 = math.cos %cst fastmath<afn> : f16
    %25 = math.exp2 %cst_0 fastmath<afn> : f32
    %26 = math.log %cst fastmath<afn> : f16
    %27 = math.log2 %cst_0 fastmath<afn> : f32
    %28 = math.log10 %cst_1 fastmath<afn> : f64
    %29 = math.powf %cst, %cst fastmath<afn> : f16
    %30 = math.rsqrt %cst_1 fastmath<afn> : f64
    %31 = math.sin %cst fastmath<afn> : f16
    %32 = math.sqrt %cst_0 fastmath<afn> : f32
    %33 = math.tan %cst_1 fastmath<afn> : f64
    %cst_11 = arith.constant 6.900000e+00 : f32
    %cst_12 = arith.constant 7.000000e+00 : f32
    %34 = arith.divf %cst_11, %cst_12 fastmath<afn> : f32
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
    %1 = math.exp %cst fastmath<afn> : f32
    return
  }
}

