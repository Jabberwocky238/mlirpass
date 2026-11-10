module {
  gpu.module @dpas_mx_bf8 [#xevm.target<chip = "cri">] {
    gpu.func @dpas_mx_bf8(%arg0: vector<16xf8E5M2>, %arg1: vector<32xf8E5M2>, %arg2: vector<8xf32>, %arg3: vector<1xf8E8M0FNU>, %arg4: vector<1xf8E8M0FNU>) kernel {
      %0 = vector.extract %arg4[0] : f8E8M0FNU from vector<1xf8E8M0FNU>
      %1 = arith.bitcast %0 : f8E8M0FNU to i8
      %2 = vector.extract %arg3[0] : f8E8M0FNU from vector<1xf8E8M0FNU>
      %3 = arith.bitcast %2 : f8E8M0FNU to i8
      %4 = vector.bitcast %arg1 : vector<32xf8E5M2> to vector<32xi8>
      %5 = vector.bitcast %arg0 : vector<16xf8E5M2> to vector<16xi8>
      %6 = xevm.mma_mx %5, %4, %3, %1, %arg2 {shape = <m = 8, n = 16, k = 32>, types = <d = f32, a = bf8, b = bf8, c = f32>} : (vector<16xi8>, vector<32xi8>, i8, i8, vector<8xf32>) -> vector<8xf32>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @dpas_mx_f8 [#xevm.target<chip = "cri">] {
    gpu.func @dpas_mx_f8(%arg0: vector<16xf8E4M3FN>, %arg1: vector<32xf8E4M3FN>, %arg2: vector<8xf32>, %arg3: vector<1xf8E8M0FNU>, %arg4: vector<1xf8E8M0FNU>) kernel {
      %0 = vector.extract %arg4[0] : f8E8M0FNU from vector<1xf8E8M0FNU>
      %1 = arith.bitcast %0 : f8E8M0FNU to i8
      %2 = vector.extract %arg3[0] : f8E8M0FNU from vector<1xf8E8M0FNU>
      %3 = arith.bitcast %2 : f8E8M0FNU to i8
      %4 = vector.bitcast %arg1 : vector<32xf8E4M3FN> to vector<32xi8>
      %5 = vector.bitcast %arg0 : vector<16xf8E4M3FN> to vector<16xi8>
      %6 = xevm.mma_mx %5, %4, %3, %1, %arg2 {shape = <m = 8, n = 16, k = 32>, types = <d = f32, a = f8, b = f8, c = f32>} : (vector<16xi8>, vector<32xi8>, i8, i8, vector<8xf32>) -> vector<8xf32>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @dpas_mx_e2m1 [#xevm.target<chip = "cri">] {
    gpu.func @dpas_mx_e2m1(%arg0: vector<32xf4E2M1FN>, %arg1: vector<64xf4E2M1FN>, %arg2: vector<8xf32>, %arg3: vector<2xf8E8M0FNU>, %arg4: vector<2xf8E8M0FNU>) kernel {
      %0 = vector.bitcast %arg4 : vector<2xf8E8M0FNU> to vector<2xi8>
      %1 = vector.bitcast %arg3 : vector<2xf8E8M0FNU> to vector<2xi8>
      %2 = vector.bitcast %arg1 : vector<64xf4E2M1FN> to vector<64xi4>
      %3 = vector.bitcast %arg0 : vector<32xf4E2M1FN> to vector<32xi4>
      %4 = vector.bitcast %3 : vector<32xi4> to vector<16xi8>
      %5 = vector.bitcast %2 : vector<64xi4> to vector<32xi8>
      %6 = xevm.mma_mx %4, %5, %1, %0, %arg2 {shape = <m = 8, n = 16, k = 64>, types = <d = f32, a = e2m1, b = e2m1, c = f32>} : (vector<16xi8>, vector<32xi8>, vector<2xi8>, vector<2xi8>, vector<8xf32>) -> vector<8xf32>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @dpas_mx_no_acc [#xevm.target<chip = "cri">] {
    gpu.func @dpas_mx_no_acc(%arg0: vector<32xf4E2M1FN>, %arg1: vector<64xf4E2M1FN>, %arg2: vector<2xf8E8M0FNU>, %arg3: vector<2xf8E8M0FNU>) kernel {
      %0 = vector.bitcast %arg3 : vector<2xf8E8M0FNU> to vector<2xi8>
      %1 = vector.bitcast %arg2 : vector<2xf8E8M0FNU> to vector<2xi8>
      %2 = vector.bitcast %arg1 : vector<64xf4E2M1FN> to vector<64xi4>
      %3 = vector.bitcast %arg0 : vector<32xf4E2M1FN> to vector<32xi4>
      %cst = arith.constant dense<0.000000e+00> : vector<8xf32>
      %4 = vector.bitcast %3 : vector<32xi4> to vector<16xi8>
      %5 = vector.bitcast %2 : vector<64xi4> to vector<32xi8>
      %6 = xevm.mma_mx %4, %5, %1, %0, %cst {shape = <m = 8, n = 16, k = 64>, types = <d = f32, a = e2m1, b = e2m1, c = f32>} : (vector<16xi8>, vector<32xi8>, vector<2xi8>, vector<2xi8>, vector<8xf32>) -> vector<8xf32>
      gpu.return
    }
  }
}

