module {
  func.func @complex_div(%arg0: complex<f32>, %arg1: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %2 = complex.re %arg1 : complex<f32>
    %3 = complex.im %arg1 : complex<f32>
    %4 = arith.mulf %2, %2 : f32
    %5 = arith.mulf %3, %3 : f32
    %6 = arith.addf %4, %5 : f32
    %7 = arith.mulf %0, %2 : f32
    %8 = arith.mulf %1, %3 : f32
    %9 = arith.addf %7, %8 : f32
    %10 = arith.mulf %1, %2 : f32
    %11 = arith.mulf %0, %3 : f32
    %12 = arith.subf %10, %11 : f32
    %13 = arith.divf %9, %6 : f32
    %14 = arith.divf %12, %6 : f32
    %15 = complex.create %13, %14 : complex<f32>
    return %15 : complex<f32>
  }
  func.func @complex_div_with_fmf(%arg0: complex<f32>, %arg1: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg0 : complex<f32>
    %2 = complex.re %arg1 : complex<f32>
    %3 = complex.im %arg1 : complex<f32>
    %4 = arith.mulf %2, %2 fastmath<nsz,arcp> : f32
    %5 = arith.mulf %3, %3 fastmath<nsz,arcp> : f32
    %6 = arith.addf %4, %5 fastmath<nsz,arcp> : f32
    %7 = arith.mulf %0, %2 fastmath<nsz,arcp> : f32
    %8 = arith.mulf %1, %3 fastmath<nsz,arcp> : f32
    %9 = arith.addf %7, %8 fastmath<nsz,arcp> : f32
    %10 = arith.mulf %1, %2 fastmath<nsz,arcp> : f32
    %11 = arith.mulf %0, %3 fastmath<nsz,arcp> : f32
    %12 = arith.subf %10, %11 fastmath<nsz,arcp> : f32
    %13 = arith.divf %9, %6 fastmath<nsz,arcp> : f32
    %14 = arith.divf %12, %6 fastmath<nsz,arcp> : f32
    %15 = complex.create %13, %14 : complex<f32>
    return %15 : complex<f32>
  }
}

