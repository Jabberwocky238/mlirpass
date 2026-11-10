"builtin.module"() ({
  "func.func"() <{function_type = (vector<8xf16>, vector<16xf16>, vector<4xf32>, vector<16xf32>, vector<8xbf16>, vector<16xbf16>, vector<16xi8>, vector<32xi8>, vector<4xi32>, vector<16xi32>, vector<16xf8E4M3FN>, vector<16xf8E5M2>, vector<32xf8E4M3FN>, vector<32xf8E5M2>, vector<2xi16>, i32, vector<4xbf16>, vector<4xi8>) -> (), sym_name = "sparse_mfma_to_rocdl"}> ({
  ^bb0(%arg0: vector<8xf16>, %arg1: vector<16xf16>, %arg2: vector<4xf32>, %arg3: vector<16xf32>, %arg4: vector<8xbf16>, %arg5: vector<16xbf16>, %arg6: vector<16xi8>, %arg7: vector<32xi8>, %arg8: vector<4xi32>, %arg9: vector<16xi32>, %arg10: vector<16xf8E4M3FN>, %arg11: vector<16xf8E5M2>, %arg12: vector<32xf8E4M3FN>, %arg13: vector<32xf8E5M2>, %arg14: vector<2xi16>, %arg15: i32, %arg16: vector<4xbf16>, %arg17: vector<4xi8>):
    %0 = "amdgpu.sparse_mfma"(%arg0, %arg1, %arg2, %arg14) <{abid = 0 : i32, cbsz = 0 : i32, k = 64 : i32, m = 16 : i32, n = 16 : i32}> : (vector<8xf16>, vector<16xf16>, vector<4xf32>, vector<2xi16>) -> vector<4xf32>
    %1 = "amdgpu.sparse_mfma"(%arg4, %arg5, %arg2, %arg14) <{abid = 0 : i32, cbsz = 0 : i32, k = 64 : i32, m = 16 : i32, n = 16 : i32}> : (vector<8xbf16>, vector<16xbf16>, vector<4xf32>, vector<2xi16>) -> vector<4xf32>
    %2 = "amdgpu.sparse_mfma"(%arg16, %arg4, %arg2, %arg17) <{abid = 0 : i32, cbsz = 0 : i32, k = 32 : i32, m = 16 : i32, n = 16 : i32}> : (vector<4xbf16>, vector<8xbf16>, vector<4xf32>, vector<4xi8>) -> vector<4xf32>
    %3 = "amdgpu.sparse_mfma"(%arg6, %arg7, %arg8, %arg15) <{abid = 0 : i32, cbsz = 0 : i32, k = 128 : i32, m = 16 : i32, n = 16 : i32}> : (vector<16xi8>, vector<32xi8>, vector<4xi32>, i32) -> vector<4xi32>
    %4 = "amdgpu.sparse_mfma"(%arg10, %arg12, %arg2, %arg15) <{abid = 0 : i32, cbsz = 0 : i32, k = 128 : i32, m = 16 : i32, n = 16 : i32}> : (vector<16xf8E4M3FN>, vector<32xf8E4M3FN>, vector<4xf32>, i32) -> vector<4xf32>
    %5 = "amdgpu.sparse_mfma"(%arg11, %arg13, %arg2, %arg15) <{abid = 0 : i32, cbsz = 0 : i32, k = 128 : i32, m = 16 : i32, n = 16 : i32}> : (vector<16xf8E5M2>, vector<32xf8E5M2>, vector<4xf32>, i32) -> vector<4xf32>
    %6 = "amdgpu.sparse_mfma"(%arg10, %arg13, %arg2, %arg15) <{abid = 0 : i32, cbsz = 0 : i32, k = 128 : i32, m = 16 : i32, n = 16 : i32}> : (vector<16xf8E4M3FN>, vector<32xf8E5M2>, vector<4xf32>, i32) -> vector<4xf32>
    %7 = "amdgpu.sparse_mfma"(%arg11, %arg12, %arg2, %arg15) <{abid = 0 : i32, cbsz = 0 : i32, k = 128 : i32, m = 16 : i32, n = 16 : i32}> : (vector<16xf8E5M2>, vector<32xf8E4M3FN>, vector<4xf32>, i32) -> vector<4xf32>
    %8 = "amdgpu.sparse_mfma"(%arg0, %arg1, %arg3, %arg14) <{abid = 0 : i32, cbsz = 0 : i32, k = 32 : i32, m = 32 : i32, n = 32 : i32}> : (vector<8xf16>, vector<16xf16>, vector<16xf32>, vector<2xi16>) -> vector<16xf32>
    %9 = "amdgpu.sparse_mfma"(%arg4, %arg5, %arg3, %arg14) <{abid = 0 : i32, cbsz = 0 : i32, k = 32 : i32, m = 32 : i32, n = 32 : i32}> : (vector<8xbf16>, vector<16xbf16>, vector<16xf32>, vector<2xi16>) -> vector<16xf32>
    %10 = "amdgpu.sparse_mfma"(%arg16, %arg4, %arg3, %arg17) <{abid = 0 : i32, cbsz = 0 : i32, k = 16 : i32, m = 32 : i32, n = 32 : i32}> : (vector<4xbf16>, vector<8xbf16>, vector<16xf32>, vector<4xi8>) -> vector<16xf32>
    %11 = "amdgpu.sparse_mfma"(%arg6, %arg7, %arg9, %arg15) <{abid = 0 : i32, cbsz = 0 : i32, k = 64 : i32, m = 32 : i32, n = 32 : i32}> : (vector<16xi8>, vector<32xi8>, vector<16xi32>, i32) -> vector<16xi32>
    %12 = "amdgpu.sparse_mfma"(%arg10, %arg12, %arg3, %arg15) <{abid = 0 : i32, cbsz = 0 : i32, k = 64 : i32, m = 32 : i32, n = 32 : i32}> : (vector<16xf8E4M3FN>, vector<32xf8E4M3FN>, vector<16xf32>, i32) -> vector<16xf32>
    %13 = "amdgpu.sparse_mfma"(%arg11, %arg13, %arg3, %arg15) <{abid = 0 : i32, cbsz = 0 : i32, k = 64 : i32, m = 32 : i32, n = 32 : i32}> : (vector<16xf8E5M2>, vector<32xf8E5M2>, vector<16xf32>, i32) -> vector<16xf32>
    %14 = "amdgpu.sparse_mfma"(%arg10, %arg13, %arg3, %arg15) <{abid = 0 : i32, cbsz = 0 : i32, k = 64 : i32, m = 32 : i32, n = 32 : i32}> : (vector<16xf8E4M3FN>, vector<32xf8E5M2>, vector<16xf32>, i32) -> vector<16xf32>
    %15 = "amdgpu.sparse_mfma"(%arg11, %arg12, %arg3, %arg15) <{abid = 0 : i32, cbsz = 0 : i32, k = 64 : i32, m = 32 : i32, n = 32 : i32}> : (vector<16xf8E5M2>, vector<32xf8E4M3FN>, vector<16xf32>, i32) -> vector<16xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

