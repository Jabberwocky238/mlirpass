"builtin.module"() ({
  "func.func"() <{function_type = (f16) -> f8E5M2FNUZ, sym_name = "scalar_trunc"}> ({
  ^bb0(%arg0: f16):
    %0 = "arith.constant"() <{value = -5.734400e+04 : f16}> : () -> f16
    %1 = "arith.constant"() <{value = 5.734400e+04 : f16}> : () -> f16
    %2 = "arith.constant"() <{value = 0x7C00 : f16}> : () -> f16
    %3 = "arith.constant"() <{value = 0xFC00 : f16}> : () -> f16
    %4 = "arith.cmpf"(%arg0, %2) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f16, f16) -> i1
    %5 = "arith.cmpf"(%arg0, %3) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f16, f16) -> i1
    %6 = "arith.cmpf"(%arg0, %arg0) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f16, f16) -> i1
    %7 = "arith.ori"(%4, %5) : (i1, i1) -> i1
    %8 = "arith.ori"(%7, %6) : (i1, i1) -> i1
    %9 = "arith.maximumf"(%arg0, %0) <{fastmath = #arith.fastmath<none>}> : (f16, f16) -> f16
    %10 = "arith.minimumf"(%9, %1) <{fastmath = #arith.fastmath<none>}> : (f16, f16) -> f16
    %11 = "arith.select"(%8, %arg0, %10) : (i1, f16, f16) -> f16
    %12 = "arith.extf"(%11) : (f16) -> f32
    %13 = "amdgpu.packed_trunc_2xfp8"(%12) <{operandSegmentSizes = array<i32: 1, 0, 0>, wordIndex = 0 : i32}> : (f32) -> vector<4xf8E5M2FNUZ>
    %14 = "vector.extract"(%13) <{static_position = array<i64: 0>}> : (vector<4xf8E5M2FNUZ>) -> f8E5M2FNUZ
    "func.return"(%14) : (f8E5M2FNUZ) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>) -> vector<2xf8E4M3FNUZ>, sym_name = "vector_trunc_short"}> ({
  ^bb0(%arg0: vector<2xf32>):
    %0 = "arith.constant"() <{value = dense<-2.400000e+02> : vector<2xf32>}> : () -> vector<2xf32>
    %1 = "arith.constant"() <{value = dense<2.400000e+02> : vector<2xf32>}> : () -> vector<2xf32>
    %2 = "arith.constant"() <{value = dense<0x7F800000> : vector<2xf32>}> : () -> vector<2xf32>
    %3 = "arith.constant"() <{value = dense<0xFF800000> : vector<2xf32>}> : () -> vector<2xf32>
    %4 = "arith.cmpf"(%arg0, %2) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (vector<2xf32>, vector<2xf32>) -> vector<2xi1>
    %5 = "arith.cmpf"(%arg0, %3) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (vector<2xf32>, vector<2xf32>) -> vector<2xi1>
    %6 = "arith.cmpf"(%arg0, %arg0) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (vector<2xf32>, vector<2xf32>) -> vector<2xi1>
    %7 = "arith.ori"(%4, %5) : (vector<2xi1>, vector<2xi1>) -> vector<2xi1>
    %8 = "arith.ori"(%7, %6) : (vector<2xi1>, vector<2xi1>) -> vector<2xi1>
    %9 = "arith.maximumf"(%arg0, %0) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %10 = "arith.minimumf"(%9, %1) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %11 = "arith.select"(%8, %arg0, %10) : (vector<2xi1>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %12 = "vector.extract"(%11) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
    %13 = "vector.extract"(%11) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
    %14 = "amdgpu.packed_trunc_2xfp8"(%12, %13) <{operandSegmentSizes = array<i32: 1, 1, 0>, wordIndex = 0 : i32}> : (f32, f32) -> vector<4xf8E4M3FNUZ>
    %15 = "vector.extract_strided_slice"(%14) <{offsets = [0], sizes = [2], strides = [1]}> : (vector<4xf8E4M3FNUZ>) -> vector<2xf8E4M3FNUZ>
    "func.return"(%15) : (vector<2xf8E4M3FNUZ>) -> ()
  }) : () -> ()
}) : () -> ()

