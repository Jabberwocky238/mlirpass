"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf16>, vector<8xf32>, vector<4xf32>, vector<16xbf16>, vector<8xf16>, vector<8xbf16>, vector<16xi8>, vector<8xi32>, vector<4xi32>, vector<16xui8>, vector<16xi4>, vector<8xi4>) -> (), sym_name = "wmma_to_rocdl"}> ({
  ^bb0(%arg0: vector<16xf16>, %arg1: vector<8xf32>, %arg2: vector<4xf32>, %arg3: vector<16xbf16>, %arg4: vector<8xf16>, %arg5: vector<8xbf16>, %arg6: vector<16xi8>, %arg7: vector<8xi32>, %arg8: vector<4xi32>, %arg9: vector<16xui8>, %arg10: vector<16xi4>, %arg11: vector<8xi4>):
    %0 = "amdgpu.wmma"(%arg0, %arg0, %arg1) <{k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<16xf16>, vector<16xf16>, vector<8xf32>) -> vector<8xf32>
    %1 = "amdgpu.wmma"(%arg0, %arg0, %arg2) <{k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<16xf16>, vector<16xf16>, vector<4xf32>) -> vector<4xf32>
    %2 = "amdgpu.wmma"(%arg3, %arg3, %arg1) <{k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<16xbf16>, vector<16xbf16>, vector<8xf32>) -> vector<8xf32>
    %3 = "amdgpu.wmma"(%arg3, %arg3, %arg2) <{k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<16xbf16>, vector<16xbf16>, vector<4xf32>) -> vector<4xf32>
    %4 = "amdgpu.wmma"(%arg0, %arg0, %arg0) <{k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 1 : i32}> : (vector<16xf16>, vector<16xf16>, vector<16xf16>) -> vector<16xf16>
    %5 = "amdgpu.wmma"(%arg0, %arg0, %arg4) <{k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<16xf16>, vector<16xf16>, vector<8xf16>) -> vector<8xf16>
    %6 = "amdgpu.wmma"(%arg3, %arg3, %arg3) <{k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 1 : i32}> : (vector<16xbf16>, vector<16xbf16>, vector<16xbf16>) -> vector<16xbf16>
    %7 = "amdgpu.wmma"(%arg3, %arg3, %arg5) <{k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<16xbf16>, vector<16xbf16>, vector<8xbf16>) -> vector<8xbf16>
    %8 = "amdgpu.wmma"(%arg6, %arg6, %arg7) <{clamp, k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<16xi8>, vector<16xi8>, vector<8xi32>) -> vector<8xi32>
    %9 = "amdgpu.wmma"(%arg9, %arg9, %arg8) <{clamp, k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32, unsignedA, unsignedB}> : (vector<16xui8>, vector<16xui8>, vector<4xi32>) -> vector<4xi32>
    %10 = "amdgpu.wmma"(%arg10, %arg10, %arg7) <{clamp, k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<16xi4>, vector<16xi4>, vector<8xi32>) -> vector<8xi32>
    %11 = "amdgpu.wmma"(%arg11, %arg11, %arg8) <{clamp, k = 16 : i32, m = 16 : i32, n = 16 : i32, subwordOffset = 0 : i32}> : (vector<8xi4>, vector<8xi4>, vector<4xi32>) -> vector<4xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

