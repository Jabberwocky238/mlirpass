"builtin.module"() ({
  "func.func"() <{function_type = (vector<8xf16>, vector<4xf16>, vector<8xf32>, vector<4xf32>, vector<8xbf16>, vector<4xbf16>, vector<8xf8E4M3FN>, vector<4xf8E4M3FN>, vector<8xf8E5M2>, vector<4xf8E5M2>, vector<8xi8>, vector<4xi8>, vector<8xi32>, vector<4xi32>, vector<16xi4>, vector<8xi4>, vector<4xi4>) -> (), sym_name = "wmma_to_rocdl"}> ({
  ^bb0(%arg0: vector<8xf16>, %arg1: vector<4xf16>, %arg2: vector<8xf32>, %arg3: vector<4xf32>, %arg4: vector<8xbf16>, %arg5: vector<4xbf16>, %arg6: vector<8xf8E4M3FN>, %arg7: vector<4xf8E4M3FN>, %arg8: vector<8xf8E5M2>, %arg9: vector<4xf8E5M2>, %arg10: vector<8xi8>, %arg11: vector<4xi8>, %arg12: vector<8xi32>, %arg13: vector<4xi32>, %arg14: vector<16xi4>, %arg15: vector<8xi4>, %arg16: vector<4xi4>):
    %0 = "amdgpu.wmma"(%arg0, %arg0, %arg2) <{k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<8xf16>, vector<8xf16>, vector<8xf32>) -> vector<8xf32>
    %1 = "amdgpu.wmma"(%arg1, %arg1, %arg3) <{k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<4xf16>, vector<4xf16>, vector<4xf32>) -> vector<4xf32>
    %2 = "amdgpu.wmma"(%arg4, %arg4, %arg2) <{k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<8xbf16>, vector<8xbf16>, vector<8xf32>) -> vector<8xf32>
    %3 = "amdgpu.wmma"(%arg5, %arg5, %arg3) <{k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<4xbf16>, vector<4xbf16>, vector<4xf32>) -> vector<4xf32>
    %4 = "amdgpu.wmma"(%arg0, %arg0, %arg0) <{k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<8xf16>, vector<8xf16>, vector<8xf16>) -> vector<8xf16>
    %5 = "amdgpu.wmma"(%arg1, %arg1, %arg1) <{k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<4xf16>, vector<4xf16>, vector<4xf16>) -> vector<4xf16>
    %6 = "amdgpu.wmma"(%arg4, %arg4, %arg4) <{k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<8xbf16>, vector<8xbf16>, vector<8xbf16>) -> vector<8xbf16>
    %7 = "amdgpu.wmma"(%arg5, %arg5, %arg5) <{k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<4xbf16>, vector<4xbf16>, vector<4xbf16>) -> vector<4xbf16>
    %8 = "amdgpu.wmma"(%arg6, %arg6, %arg2) <{k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<8xf8E4M3FN>, vector<8xf8E4M3FN>, vector<8xf32>) -> vector<8xf32>
    %9 = "amdgpu.wmma"(%arg7, %arg7, %arg3) <{k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<4xf8E4M3FN>, vector<4xf8E4M3FN>, vector<4xf32>) -> vector<4xf32>
    %10 = "amdgpu.wmma"(%arg6, %arg8, %arg2) <{k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<8xf8E4M3FN>, vector<8xf8E5M2>, vector<8xf32>) -> vector<8xf32>
    %11 = "amdgpu.wmma"(%arg7, %arg9, %arg3) <{k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<4xf8E4M3FN>, vector<4xf8E5M2>, vector<4xf32>) -> vector<4xf32>
    %12 = "amdgpu.wmma"(%arg8, %arg8, %arg2) <{k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<8xf8E5M2>, vector<8xf8E5M2>, vector<8xf32>) -> vector<8xf32>
    %13 = "amdgpu.wmma"(%arg9, %arg9, %arg3) <{k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<4xf8E5M2>, vector<4xf8E5M2>, vector<4xf32>) -> vector<4xf32>
    %14 = "amdgpu.wmma"(%arg8, %arg6, %arg2) <{k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<8xf8E5M2>, vector<8xf8E4M3FN>, vector<8xf32>) -> vector<8xf32>
    %15 = "amdgpu.wmma"(%arg9, %arg7, %arg3) <{k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<4xf8E5M2>, vector<4xf8E4M3FN>, vector<4xf32>) -> vector<4xf32>
    %16 = "amdgpu.wmma"(%arg10, %arg10, %arg12) <{clamp, k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<8xi8>, vector<8xi8>, vector<8xi32>) -> vector<8xi32>
    %17 = "amdgpu.wmma"(%arg11, %arg11, %arg13) <{clamp, k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32, unsignedA, unsignedB}> : (vector<4xi8>, vector<4xi8>, vector<4xi32>) -> vector<4xi32>
    %18 = "amdgpu.wmma"(%arg14, %arg14, %arg12) <{clamp, k = 32 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<16xi4>, vector<16xi4>, vector<8xi32>) -> vector<8xi32>
    %19 = "amdgpu.wmma"(%arg15, %arg15, %arg13) <{clamp, k = 32 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<8xi4>, vector<8xi4>, vector<4xi32>) -> vector<4xi32>
    %20 = "amdgpu.wmma"(%arg15, %arg15, %arg12) <{clamp, k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<8xi4>, vector<8xi4>, vector<8xi32>) -> vector<8xi32>
    %21 = "amdgpu.wmma"(%arg16, %arg16, %arg13) <{clamp, k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<4xi4>, vector<4xi4>, vector<4xi32>) -> vector<4xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<64xf8E4M3FN>, vector<8xf16>) -> (), sym_name = "wmma_unsupported_k"}> ({
  ^bb0(%arg0: vector<64xf8E4M3FN>, %arg1: vector<8xf16>):
    %0 = "amdgpu.wmma"(%arg0, %arg0, %arg1) <{k = 128 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<64xf8E4M3FN>, vector<64xf8E4M3FN>, vector<8xf16>) -> vector<8xf16>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

