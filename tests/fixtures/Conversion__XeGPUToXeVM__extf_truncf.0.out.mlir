module {
  gpu.module @extf_e2m1_bf16 [#xevm.target<chip = "cri">] {
    gpu.func @extf_e2m1_bf16(%arg0: vector<16xf4E2M1FN>) kernel {
      %0 = vector.bitcast %arg0 : vector<16xf4E2M1FN> to vector<16xi4>
      %1 = vector.bitcast %0 : vector<16xi4> to vector<8xi8>
      %2 = xevm.extf %1 {src_etype = e2m1, dst_etype = bf16} : (vector<8xi8>) -> vector<16xbf16>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @extf_e2m1_f16 [#xevm.target<chip = "cri">] {
    gpu.func @extf_e2m1_f16(%arg0: vector<16xf4E2M1FN>) kernel {
      %0 = vector.bitcast %arg0 : vector<16xf4E2M1FN> to vector<16xi4>
      %1 = vector.bitcast %0 : vector<16xi4> to vector<8xi8>
      %2 = xevm.extf %1 {src_etype = e2m1, dst_etype = f16} : (vector<8xi8>) -> vector<16xf16>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @extf_bf8_f16 [#xevm.target<chip = "cri">] {
    gpu.func @extf_bf8_f16(%arg0: vector<16xf8E5M2>) kernel {
      %0 = vector.bitcast %arg0 : vector<16xf8E5M2> to vector<16xi8>
      %1 = xevm.extf %0 {src_etype = bf8, dst_etype = f16} : (vector<16xi8>) -> vector<16xf16>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @extf_f8_bf16 [#xevm.target<chip = "cri">] {
    gpu.func @extf_f8_bf16(%arg0: vector<16xf8E4M3FN>) kernel {
      %0 = vector.bitcast %arg0 : vector<16xf8E4M3FN> to vector<16xi8>
      %1 = xevm.extf %0 {src_etype = f8, dst_etype = bf16} : (vector<16xi8>) -> vector<16xbf16>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @truncf_f16_e2m1 [#xevm.target<chip = "cri">] {
    gpu.func @truncf_f16_e2m1(%arg0: vector<16xf16>) kernel {
      %0 = xevm.truncf %arg0 {src_etype = f16, dst_etype = e2m1} : (vector<16xf16>) -> vector<8xi8>
      %1 = vector.bitcast %0 : vector<8xi8> to vector<16xi4>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @truncf_bf16_f8 [#xevm.target<chip = "cri">] {
    gpu.func @truncf_bf16_f8(%arg0: vector<16xbf16>) kernel {
      %0 = xevm.truncf %arg0 {src_etype = bf16, dst_etype = f8} : (vector<16xbf16>) -> vector<16xi8>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @extf_passthrough [#xevm.target<chip = "cri">] {
    gpu.func @extf_passthrough(%arg0: vector<16xf16>) kernel {
      %0 = arith.extf %arg0 : vector<16xf16> to vector<16xf32>
      gpu.return
    }
  }
}

