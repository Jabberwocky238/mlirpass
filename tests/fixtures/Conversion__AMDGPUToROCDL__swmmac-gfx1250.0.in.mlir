"builtin.module"() ({
  "func.func"() <{function_type = (vector<64xi8>, vector<64xf8E4M3FN>, vector<64xf8E5M2>, vector<32xf16>, vector<32xbf16>, vector<32xi8>, vector<32xi4>, vector<32xf8E4M3FN>, vector<32xf8E5M2>, vector<16xf16>, vector<16xbf16>, vector<16xf8E4M3FN>, vector<16xf8E5M2>, vector<8xf32>, vector<8xi32>, vector<8xf16>, vector<8xbf16>, vector<8xi8>, vector<8xi4>, vector<4xi8>) -> (), sym_name = "rocdl.swmmac"}> ({
  ^bb0(%arg0: vector<64xi8>, %arg1: vector<64xf8E4M3FN>, %arg2: vector<64xf8E5M2>, %arg3: vector<32xf16>, %arg4: vector<32xbf16>, %arg5: vector<32xi8>, %arg6: vector<32xi4>, %arg7: vector<32xf8E4M3FN>, %arg8: vector<32xf8E5M2>, %arg9: vector<16xf16>, %arg10: vector<16xbf16>, %arg11: vector<16xf8E4M3FN>, %arg12: vector<16xf8E5M2>, %arg13: vector<8xf32>, %arg14: vector<8xi32>, %arg15: vector<8xf16>, %arg16: vector<8xbf16>, %arg17: vector<8xi8>, %arg18: vector<8xi4>, %arg19: vector<4xi8>):
    %0 = "amdgpu.sparse_wmma"(%arg9, %arg3, %arg13, %arg19) <{k = 64 : i32, m = 16 : i32, n = 16 : i32, reuseA, reuseB, unsignedA, unsignedB}> : (vector<16xf16>, vector<32xf16>, vector<8xf32>, vector<4xi8>) -> vector<8xf32>
    %1 = "amdgpu.sparse_wmma"(%arg10, %arg4, %arg13, %arg19) <{k = 64 : i32, m = 16 : i32, n = 16 : i32, reuseA, reuseB, unsignedA, unsignedB}> : (vector<16xbf16>, vector<32xbf16>, vector<8xf32>, vector<4xi8>) -> vector<8xf32>
    %2 = "amdgpu.sparse_wmma"(%arg9, %arg3, %arg15, %arg19) <{k = 64 : i32, m = 16 : i32, n = 16 : i32, reuseA, reuseB, unsignedA, unsignedB}> : (vector<16xf16>, vector<32xf16>, vector<8xf16>, vector<4xi8>) -> vector<8xf16>
    %3 = "amdgpu.sparse_wmma"(%arg10, %arg4, %arg16, %arg19) <{k = 64 : i32, m = 16 : i32, n = 16 : i32, reuseA, reuseB, unsignedA, unsignedB}> : (vector<16xbf16>, vector<32xbf16>, vector<8xbf16>, vector<4xi8>) -> vector<8xbf16>
    %4 = "amdgpu.sparse_wmma"(%arg7, %arg1, %arg13, %arg19) <{k = 128 : i32, m = 16 : i32, n = 16 : i32, reuseA, reuseB}> : (vector<32xf8E4M3FN>, vector<64xf8E4M3FN>, vector<8xf32>, vector<4xi8>) -> vector<8xf32>
    %5 = "amdgpu.sparse_wmma"(%arg7, %arg2, %arg13, %arg19) <{k = 128 : i32, m = 16 : i32, n = 16 : i32, reuseA, reuseB}> : (vector<32xf8E4M3FN>, vector<64xf8E5M2>, vector<8xf32>, vector<4xi8>) -> vector<8xf32>
    %6 = "amdgpu.sparse_wmma"(%arg8, %arg1, %arg13, %arg19) <{k = 128 : i32, m = 16 : i32, n = 16 : i32, reuseA, reuseB}> : (vector<32xf8E5M2>, vector<64xf8E4M3FN>, vector<8xf32>, vector<4xi8>) -> vector<8xf32>
    %7 = "amdgpu.sparse_wmma"(%arg8, %arg2, %arg13, %arg19) <{k = 128 : i32, m = 16 : i32, n = 16 : i32, reuseA, reuseB}> : (vector<32xf8E5M2>, vector<64xf8E5M2>, vector<8xf32>, vector<4xi8>) -> vector<8xf32>
    %8 = "amdgpu.sparse_wmma"(%arg7, %arg1, %arg15, %arg19) <{k = 128 : i32, m = 16 : i32, n = 16 : i32, reuseA, reuseB}> : (vector<32xf8E4M3FN>, vector<64xf8E4M3FN>, vector<8xf16>, vector<4xi8>) -> vector<8xf16>
    %9 = "amdgpu.sparse_wmma"(%arg7, %arg2, %arg15, %arg19) <{k = 128 : i32, m = 16 : i32, n = 16 : i32, reuseA, reuseB}> : (vector<32xf8E4M3FN>, vector<64xf8E5M2>, vector<8xf16>, vector<4xi8>) -> vector<8xf16>
    %10 = "amdgpu.sparse_wmma"(%arg8, %arg1, %arg15, %arg19) <{k = 128 : i32, m = 16 : i32, n = 16 : i32, reuseA, reuseB}> : (vector<32xf8E5M2>, vector<64xf8E4M3FN>, vector<8xf16>, vector<4xi8>) -> vector<8xf16>
    %11 = "amdgpu.sparse_wmma"(%arg8, %arg2, %arg15, %arg19) <{k = 128 : i32, m = 16 : i32, n = 16 : i32, reuseA, reuseB}> : (vector<32xf8E5M2>, vector<64xf8E5M2>, vector<8xf16>, vector<4xi8>) -> vector<8xf16>
    %12 = "amdgpu.sparse_wmma"(%arg5, %arg0, %arg14, %arg19) <{clamp, k = 128 : i32, m = 16 : i32, n = 16 : i32, reuseA, reuseB, unsignedA, unsignedB}> : (vector<32xi8>, vector<64xi8>, vector<8xi32>, vector<4xi8>) -> vector<8xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

