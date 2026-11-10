"builtin.module"() ({
  "func.func"() <{function_type = (vector<32xi4>, vector<16xf16>, vector<16xbf16>, vector<16xi8>, vector<16xi4>, vector<16xf8E4M3FN>, vector<16xf8E5M2>, vector<8xf32>, vector<8xi32>, vector<8xf16>, vector<8xbf16>, vector<8xi8>, vector<8xi4>, vector<8xf8E4M3FN>, vector<8xf8E5M2>, vector<4xf32>, vector<4xf16>, vector<4xbf16>, vector<4xi8>, vector<4xi32>, vector<4xf8E4M3FN>, vector<4xf8E5M2>, vector<4xi8>) -> (), sym_name = "rocdl.swmmac"}> ({
  ^bb0(%arg0: vector<32xi4>, %arg1: vector<16xf16>, %arg2: vector<16xbf16>, %arg3: vector<16xi8>, %arg4: vector<16xi4>, %arg5: vector<16xf8E4M3FN>, %arg6: vector<16xf8E5M2>, %arg7: vector<8xf32>, %arg8: vector<8xi32>, %arg9: vector<8xf16>, %arg10: vector<8xbf16>, %arg11: vector<8xi8>, %arg12: vector<8xi4>, %arg13: vector<8xf8E4M3FN>, %arg14: vector<8xf8E5M2>, %arg15: vector<4xf32>, %arg16: vector<4xf16>, %arg17: vector<4xbf16>, %arg18: vector<4xi8>, %arg19: vector<4xi32>, %arg20: vector<4xf8E4M3FN>, %arg21: vector<4xf8E5M2>, %arg22: vector<4xi8>):
    %0 = "amdgpu.sparse_wmma"(%arg9, %arg1, %arg7, %arg22) <{k = 32 : i32, m = 16 : i32, n = 16 : i32}> : (vector<8xf16>, vector<16xf16>, vector<8xf32>, vector<4xi8>) -> vector<8xf32>
    %1 = "amdgpu.sparse_wmma"(%arg10, %arg2, %arg7, %arg22) <{k = 32 : i32, m = 16 : i32, n = 16 : i32}> : (vector<8xbf16>, vector<16xbf16>, vector<8xf32>, vector<4xi8>) -> vector<8xf32>
    %2 = "amdgpu.sparse_wmma"(%arg9, %arg1, %arg9, %arg22) <{k = 32 : i32, m = 16 : i32, n = 16 : i32}> : (vector<8xf16>, vector<16xf16>, vector<8xf16>, vector<4xi8>) -> vector<8xf16>
    %3 = "amdgpu.sparse_wmma"(%arg10, %arg2, %arg10, %arg22) <{k = 32 : i32, m = 16 : i32, n = 16 : i32}> : (vector<8xbf16>, vector<16xbf16>, vector<8xbf16>, vector<4xi8>) -> vector<8xbf16>
    %4 = "amdgpu.sparse_wmma"(%arg11, %arg3, %arg8, %arg22) <{clamp, k = 32 : i32, m = 16 : i32, n = 16 : i32, unsignedA, unsignedB}> : (vector<8xi8>, vector<16xi8>, vector<8xi32>, vector<4xi8>) -> vector<8xi32>
    %5 = "amdgpu.sparse_wmma"(%arg12, %arg4, %arg8, %arg22) <{clamp, k = 32 : i32, m = 16 : i32, n = 16 : i32, unsignedA, unsignedB}> : (vector<8xi4>, vector<16xi4>, vector<8xi32>, vector<4xi8>) -> vector<8xi32>
    %6 = "amdgpu.sparse_wmma"(%arg4, %arg0, %arg8, %arg22) <{clamp, k = 64 : i32, m = 16 : i32, n = 16 : i32, unsignedA, unsignedB}> : (vector<16xi4>, vector<32xi4>, vector<8xi32>, vector<4xi8>) -> vector<8xi32>
    %7 = "amdgpu.sparse_wmma"(%arg13, %arg5, %arg7, %arg22) <{k = 32 : i32, m = 16 : i32, n = 16 : i32}> : (vector<8xf8E4M3FN>, vector<16xf8E4M3FN>, vector<8xf32>, vector<4xi8>) -> vector<8xf32>
    %8 = "amdgpu.sparse_wmma"(%arg13, %arg6, %arg7, %arg22) <{k = 32 : i32, m = 16 : i32, n = 16 : i32}> : (vector<8xf8E4M3FN>, vector<16xf8E5M2>, vector<8xf32>, vector<4xi8>) -> vector<8xf32>
    %9 = "amdgpu.sparse_wmma"(%arg14, %arg5, %arg7, %arg22) <{k = 32 : i32, m = 16 : i32, n = 16 : i32}> : (vector<8xf8E5M2>, vector<16xf8E4M3FN>, vector<8xf32>, vector<4xi8>) -> vector<8xf32>
    %10 = "amdgpu.sparse_wmma"(%arg14, %arg6, %arg7, %arg22) <{k = 32 : i32, m = 16 : i32, n = 16 : i32}> : (vector<8xf8E5M2>, vector<16xf8E5M2>, vector<8xf32>, vector<4xi8>) -> vector<8xf32>
    %11 = "amdgpu.sparse_wmma"(%arg16, %arg9, %arg15, %arg22) <{k = 32 : i32, m = 16 : i32, n = 16 : i32, wave64}> : (vector<4xf16>, vector<8xf16>, vector<4xf32>, vector<4xi8>) -> vector<4xf32>
    %12 = "amdgpu.sparse_wmma"(%arg17, %arg10, %arg15, %arg22) <{k = 32 : i32, m = 16 : i32, n = 16 : i32, wave64}> : (vector<4xbf16>, vector<8xbf16>, vector<4xf32>, vector<4xi8>) -> vector<4xf32>
    %13 = "amdgpu.sparse_wmma"(%arg16, %arg9, %arg16, %arg22) <{k = 32 : i32, m = 16 : i32, n = 16 : i32, wave64}> : (vector<4xf16>, vector<8xf16>, vector<4xf16>, vector<4xi8>) -> vector<4xf16>
    %14 = "amdgpu.sparse_wmma"(%arg17, %arg10, %arg17, %arg22) <{k = 32 : i32, m = 16 : i32, n = 16 : i32, wave64}> : (vector<4xbf16>, vector<8xbf16>, vector<4xbf16>, vector<4xi8>) -> vector<4xbf16>
    %15 = "amdgpu.sparse_wmma"(%arg18, %arg11, %arg19, %arg22) <{k = 32 : i32, m = 16 : i32, n = 16 : i32, wave64}> : (vector<4xi8>, vector<8xi8>, vector<4xi32>, vector<4xi8>) -> vector<4xi32>
    %16 = "amdgpu.sparse_wmma"(%arg12, %arg12, %arg19, %arg22) <{k = 32 : i32, m = 16 : i32, n = 16 : i32, wave64}> : (vector<8xi4>, vector<8xi4>, vector<4xi32>, vector<4xi8>) -> vector<4xi32>
    %17 = "amdgpu.sparse_wmma"(%arg12, %arg4, %arg19, %arg22) <{k = 64 : i32, m = 16 : i32, n = 16 : i32, wave64}> : (vector<8xi4>, vector<16xi4>, vector<4xi32>, vector<4xi8>) -> vector<4xi32>
    %18 = "amdgpu.sparse_wmma"(%arg20, %arg13, %arg15, %arg22) <{k = 32 : i32, m = 16 : i32, n = 16 : i32, wave64}> : (vector<4xf8E4M3FN>, vector<8xf8E4M3FN>, vector<4xf32>, vector<4xi8>) -> vector<4xf32>
    %19 = "amdgpu.sparse_wmma"(%arg20, %arg14, %arg15, %arg22) <{k = 32 : i32, m = 16 : i32, n = 16 : i32, wave64}> : (vector<4xf8E4M3FN>, vector<8xf8E5M2>, vector<4xf32>, vector<4xi8>) -> vector<4xf32>
    %20 = "amdgpu.sparse_wmma"(%arg21, %arg13, %arg15, %arg22) <{k = 32 : i32, m = 16 : i32, n = 16 : i32, wave64}> : (vector<4xf8E5M2>, vector<8xf8E4M3FN>, vector<4xf32>, vector<4xi8>) -> vector<4xf32>
    %21 = "amdgpu.sparse_wmma"(%arg21, %arg14, %arg15, %arg22) <{k = 32 : i32, m = 16 : i32, n = 16 : i32, wave64}> : (vector<4xf8E5M2>, vector<8xf8E5M2>, vector<4xf32>, vector<4xi8>) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

