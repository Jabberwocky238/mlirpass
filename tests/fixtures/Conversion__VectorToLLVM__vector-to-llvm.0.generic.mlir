"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x4xi32>) -> vector<2x2xi64>, sym_name = "bitcast_2d"}> ({
  ^bb0(%arg0: vector<2x4xi32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<2x4xi32>) -> !llvm.array<2 x vector<4xi32>>
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> vector<2x2xi64>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (vector<2x2xi64>) -> !llvm.array<2 x vector<2xi64>>
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<4xi32>>) -> vector<4xi32>
    %4 = "llvm.bitcast"(%3) : (vector<4xi32>) -> vector<2xi64>
    %5 = "llvm.insertvalue"(%2, %4) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<2xi64>>, vector<2xi64>) -> !llvm.array<2 x vector<2xi64>>
    %6 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<4xi32>>) -> vector<4xi32>
    %7 = "llvm.bitcast"(%6) : (vector<4xi32>) -> vector<2xi64>
    %8 = "llvm.insertvalue"(%5, %7) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<2xi64>>, vector<2xi64>) -> !llvm.array<2 x vector<2xi64>>
    %9 = "builtin.unrealized_conversion_cast"(%8) : (!llvm.array<2 x vector<2xi64>>) -> vector<2x2xi64>
    "func.return"(%9) : (vector<2x2xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x[4]xi32>) -> vector<2x[2]xi64>, sym_name = "bitcast_2d_scalable"}> ({
  ^bb0(%arg0: vector<2x[4]xi32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<2x[4]xi32>) -> !llvm.array<2 x vector<[4]xi32>>
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> vector<2x[2]xi64>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (vector<2x[2]xi64>) -> !llvm.array<2 x vector<[2]xi64>>
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<[4]xi32>>) -> vector<[4]xi32>
    %4 = "llvm.bitcast"(%3) : (vector<[4]xi32>) -> vector<[2]xi64>
    %5 = "llvm.insertvalue"(%2, %4) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<[2]xi64>>, vector<[2]xi64>) -> !llvm.array<2 x vector<[2]xi64>>
    %6 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<[4]xi32>>) -> vector<[4]xi32>
    %7 = "llvm.bitcast"(%6) : (vector<[4]xi32>) -> vector<[2]xi64>
    %8 = "llvm.insertvalue"(%5, %7) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<[2]xi64>>, vector<[2]xi64>) -> !llvm.array<2 x vector<[2]xi64>>
    %9 = "builtin.unrealized_conversion_cast"(%8) : (!llvm.array<2 x vector<[2]xi64>>) -> vector<2x[2]xi64>
    "func.return"(%9) : (vector<2x[2]xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<f32>, sym_name = "broadcast_vec0d_from_f32"}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.mlir.poison"() : () -> vector<1xf32>
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.insertelement"(%0, %arg0, %1) : (vector<1xf32>, f32, i32) -> vector<1xf32>
    %3 = "builtin.unrealized_conversion_cast"(%2) : (vector<1xf32>) -> vector<f32>
    "func.return"(%3) : (vector<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<2xf32>, sym_name = "broadcast_vec1d_from_f32"}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.mlir.poison"() : () -> vector<2xf32>
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.insertelement"(%0, %arg0, %1) : (vector<2xf32>, f32, i32) -> vector<2xf32>
    %3 = "llvm.shufflevector"(%2, %0) <{mask = array<i32: 0, 0>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "func.return"(%3) : (vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<1xf32>, sym_name = "broadcast_single_elem_vec1d_from_f32"}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.mlir.poison"() : () -> vector<1xf32>
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.insertelement"(%0, %arg0, %1) : (vector<1xf32>, f32, i32) -> vector<1xf32>
    "func.return"(%2) : (vector<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<[2]xf32>, sym_name = "broadcast_vec1d_from_f32_scalable"}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.mlir.poison"() : () -> vector<[2]xf32>
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.insertelement"(%0, %arg0, %1) : (vector<[2]xf32>, f32, i32) -> vector<[2]xf32>
    %3 = "llvm.shufflevector"(%2, %0) <{mask = array<i32: 0, 0>}> : (vector<[2]xf32>, vector<[2]xf32>) -> vector<[2]xf32>
    "func.return"(%3) : (vector<[2]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> vector<2xindex>, sym_name = "broadcast_vec1d_from_index"}> ({
  ^bb0(%arg0: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> i64
    %1 = "llvm.mlir.poison"() : () -> vector<2xi64>
    %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "llvm.insertelement"(%1, %0, %2) : (vector<2xi64>, i64, i32) -> vector<2xi64>
    %4 = "llvm.shufflevector"(%3, %1) <{mask = array<i32: 0, 0>}> : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %5 = "builtin.unrealized_conversion_cast"(%4) : (vector<2xi64>) -> vector<2xindex>
    "func.return"(%5) : (vector<2xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> vector<[2]xindex>, sym_name = "broadcast_vec1d_from_index_scalable"}> ({
  ^bb0(%arg0: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> i64
    %1 = "llvm.mlir.poison"() : () -> vector<[2]xi64>
    %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "llvm.insertelement"(%1, %0, %2) : (vector<[2]xi64>, i64, i32) -> vector<[2]xi64>
    %4 = "llvm.shufflevector"(%3, %1) <{mask = array<i32: 0, 0>}> : (vector<[2]xi64>, vector<[2]xi64>) -> vector<[2]xi64>
    %5 = "builtin.unrealized_conversion_cast"(%4) : (vector<[2]xi64>) -> vector<[2]xindex>
    "func.return"(%5) : (vector<[2]xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<2x3xf32>, sym_name = "broadcast_vec2d_from_scalar"}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.mlir.poison"() : () -> !llvm.array<2 x vector<3xf32>>
    %1 = "llvm.mlir.poison"() : () -> vector<3xf32>
    %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "llvm.insertelement"(%1, %arg0, %2) : (vector<3xf32>, f32, i32) -> vector<3xf32>
    %4 = "llvm.shufflevector"(%3, %3) <{mask = array<i32: 0, 0, 0>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %5 = "llvm.insertvalue"(%0, %4) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<3xf32>>, vector<3xf32>) -> !llvm.array<2 x vector<3xf32>>
    %6 = "llvm.insertvalue"(%5, %4) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<3xf32>>, vector<3xf32>) -> !llvm.array<2 x vector<3xf32>>
    %7 = "builtin.unrealized_conversion_cast"(%6) : (!llvm.array<2 x vector<3xf32>>) -> vector<2x3xf32>
    "func.return"(%7) : (vector<2x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<2x[3]xf32>, sym_name = "broadcast_vec2d_from_scalar_scalable"}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.mlir.poison"() : () -> !llvm.array<2 x vector<[3]xf32>>
    %1 = "llvm.mlir.poison"() : () -> vector<[3]xf32>
    %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "llvm.insertelement"(%1, %arg0, %2) : (vector<[3]xf32>, f32, i32) -> vector<[3]xf32>
    %4 = "llvm.shufflevector"(%3, %3) <{mask = array<i32: 0, 0, 0>}> : (vector<[3]xf32>, vector<[3]xf32>) -> vector<[3]xf32>
    %5 = "llvm.insertvalue"(%0, %4) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<[3]xf32>>, vector<[3]xf32>) -> !llvm.array<2 x vector<[3]xf32>>
    %6 = "llvm.insertvalue"(%5, %4) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<[3]xf32>>, vector<[3]xf32>) -> !llvm.array<2 x vector<[3]xf32>>
    %7 = "builtin.unrealized_conversion_cast"(%6) : (!llvm.array<2 x vector<[3]xf32>>) -> vector<2x[3]xf32>
    "func.return"(%7) : (vector<2x[3]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<2x3x4xf32>, sym_name = "broadcast_vec3d_from_scalar"}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.mlir.poison"() : () -> !llvm.array<2 x array<3 x vector<4xf32>>>
    %1 = "llvm.mlir.poison"() : () -> vector<4xf32>
    %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "llvm.insertelement"(%1, %arg0, %2) : (vector<4xf32>, f32, i32) -> vector<4xf32>
    %4 = "llvm.shufflevector"(%3, %3) <{mask = array<i32: 0, 0, 0, 0>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %5 = "llvm.insertvalue"(%0, %4) <{position = array<i64: 0, 0>}> : (!llvm.array<2 x array<3 x vector<4xf32>>>, vector<4xf32>) -> !llvm.array<2 x array<3 x vector<4xf32>>>
    %6 = "llvm.insertvalue"(%5, %4) <{position = array<i64: 0, 1>}> : (!llvm.array<2 x array<3 x vector<4xf32>>>, vector<4xf32>) -> !llvm.array<2 x array<3 x vector<4xf32>>>
    %7 = "llvm.insertvalue"(%6, %4) <{position = array<i64: 0, 2>}> : (!llvm.array<2 x array<3 x vector<4xf32>>>, vector<4xf32>) -> !llvm.array<2 x array<3 x vector<4xf32>>>
    %8 = "llvm.insertvalue"(%7, %4) <{position = array<i64: 1, 0>}> : (!llvm.array<2 x array<3 x vector<4xf32>>>, vector<4xf32>) -> !llvm.array<2 x array<3 x vector<4xf32>>>
    %9 = "llvm.insertvalue"(%8, %4) <{position = array<i64: 1, 1>}> : (!llvm.array<2 x array<3 x vector<4xf32>>>, vector<4xf32>) -> !llvm.array<2 x array<3 x vector<4xf32>>>
    %10 = "llvm.insertvalue"(%9, %4) <{position = array<i64: 1, 2>}> : (!llvm.array<2 x array<3 x vector<4xf32>>>, vector<4xf32>) -> !llvm.array<2 x array<3 x vector<4xf32>>>
    %11 = "builtin.unrealized_conversion_cast"(%10) : (!llvm.array<2 x array<3 x vector<4xf32>>>) -> vector<2x3x4xf32>
    "func.return"(%11) : (vector<2x3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<2x3x[4]xf32>, sym_name = "broadcast_vec3d_from_scalar_scalable"}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.mlir.poison"() : () -> !llvm.array<2 x array<3 x vector<[4]xf32>>>
    %1 = "llvm.mlir.poison"() : () -> vector<[4]xf32>
    %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "llvm.insertelement"(%1, %arg0, %2) : (vector<[4]xf32>, f32, i32) -> vector<[4]xf32>
    %4 = "llvm.shufflevector"(%3, %3) <{mask = array<i32: 0, 0, 0, 0>}> : (vector<[4]xf32>, vector<[4]xf32>) -> vector<[4]xf32>
    %5 = "llvm.insertvalue"(%0, %4) <{position = array<i64: 0, 0>}> : (!llvm.array<2 x array<3 x vector<[4]xf32>>>, vector<[4]xf32>) -> !llvm.array<2 x array<3 x vector<[4]xf32>>>
    %6 = "llvm.insertvalue"(%5, %4) <{position = array<i64: 0, 1>}> : (!llvm.array<2 x array<3 x vector<[4]xf32>>>, vector<[4]xf32>) -> !llvm.array<2 x array<3 x vector<[4]xf32>>>
    %7 = "llvm.insertvalue"(%6, %4) <{position = array<i64: 0, 2>}> : (!llvm.array<2 x array<3 x vector<[4]xf32>>>, vector<[4]xf32>) -> !llvm.array<2 x array<3 x vector<[4]xf32>>>
    %8 = "llvm.insertvalue"(%7, %4) <{position = array<i64: 1, 0>}> : (!llvm.array<2 x array<3 x vector<[4]xf32>>>, vector<[4]xf32>) -> !llvm.array<2 x array<3 x vector<[4]xf32>>>
    %9 = "llvm.insertvalue"(%8, %4) <{position = array<i64: 1, 1>}> : (!llvm.array<2 x array<3 x vector<[4]xf32>>>, vector<[4]xf32>) -> !llvm.array<2 x array<3 x vector<[4]xf32>>>
    %10 = "llvm.insertvalue"(%9, %4) <{position = array<i64: 1, 2>}> : (!llvm.array<2 x array<3 x vector<[4]xf32>>>, vector<[4]xf32>) -> !llvm.array<2 x array<3 x vector<[4]xf32>>>
    %11 = "builtin.unrealized_conversion_cast"(%10) : (!llvm.array<2 x array<3 x vector<[4]xf32>>>) -> vector<2x3x[4]xf32>
    "func.return"(%11) : (vector<2x3x[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>) -> vector<3x2xf32>, sym_name = "broadcast_vec2d_from_vec0d"}> ({
  ^bb0(%arg0: vector<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<f32>) -> vector<1xf32>
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> vector<3x2xf32>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (vector<3x2xf32>) -> !llvm.array<3 x vector<2xf32>>
    %3 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %4 = "llvm.extractelement"(%0, %3) : (vector<1xf32>, i64) -> f32
    %5 = "llvm.mlir.poison"() : () -> vector<2xf32>
    %6 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %7 = "llvm.insertelement"(%5, %4, %6) : (vector<2xf32>, f32, i32) -> vector<2xf32>
    %8 = "llvm.shufflevector"(%7, %5) <{mask = array<i32: 0, 0>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %9 = "llvm.insertvalue"(%2, %8) <{position = array<i64: 0>}> : (!llvm.array<3 x vector<2xf32>>, vector<2xf32>) -> !llvm.array<3 x vector<2xf32>>
    %10 = "llvm.insertvalue"(%9, %8) <{position = array<i64: 1>}> : (!llvm.array<3 x vector<2xf32>>, vector<2xf32>) -> !llvm.array<3 x vector<2xf32>>
    %11 = "llvm.insertvalue"(%10, %8) <{position = array<i64: 2>}> : (!llvm.array<3 x vector<2xf32>>, vector<2xf32>) -> !llvm.array<3 x vector<2xf32>>
    %12 = "builtin.unrealized_conversion_cast"(%11) : (!llvm.array<3 x vector<2xf32>>) -> vector<3x2xf32>
    "func.return"(%12) : (vector<3x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>) -> vector<3x2xf32>, sym_name = "broadcast_vec2d_from_vec1d"}> ({
  ^bb0(%arg0: vector<2xf32>):
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> vector<3x2xf32>
    %1 = "builtin.unrealized_conversion_cast"(%0) : (vector<3x2xf32>) -> !llvm.array<3 x vector<2xf32>>
    %2 = "llvm.insertvalue"(%1, %arg0) <{position = array<i64: 0>}> : (!llvm.array<3 x vector<2xf32>>, vector<2xf32>) -> !llvm.array<3 x vector<2xf32>>
    %3 = "llvm.insertvalue"(%2, %arg0) <{position = array<i64: 1>}> : (!llvm.array<3 x vector<2xf32>>, vector<2xf32>) -> !llvm.array<3 x vector<2xf32>>
    %4 = "llvm.insertvalue"(%3, %arg0) <{position = array<i64: 2>}> : (!llvm.array<3 x vector<2xf32>>, vector<2xf32>) -> !llvm.array<3 x vector<2xf32>>
    %5 = "builtin.unrealized_conversion_cast"(%4) : (!llvm.array<3 x vector<2xf32>>) -> vector<3x2xf32>
    "func.return"(%5) : (vector<3x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[2]xf32>) -> vector<3x[2]xf32>, sym_name = "broadcast_vec2d_from_vec1d_scalable"}> ({
  ^bb0(%arg0: vector<[2]xf32>):
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> vector<3x[2]xf32>
    %1 = "builtin.unrealized_conversion_cast"(%0) : (vector<3x[2]xf32>) -> !llvm.array<3 x vector<[2]xf32>>
    %2 = "llvm.insertvalue"(%1, %arg0) <{position = array<i64: 0>}> : (!llvm.array<3 x vector<[2]xf32>>, vector<[2]xf32>) -> !llvm.array<3 x vector<[2]xf32>>
    %3 = "llvm.insertvalue"(%2, %arg0) <{position = array<i64: 1>}> : (!llvm.array<3 x vector<[2]xf32>>, vector<[2]xf32>) -> !llvm.array<3 x vector<[2]xf32>>
    %4 = "llvm.insertvalue"(%3, %arg0) <{position = array<i64: 2>}> : (!llvm.array<3 x vector<[2]xf32>>, vector<[2]xf32>) -> !llvm.array<3 x vector<[2]xf32>>
    %5 = "builtin.unrealized_conversion_cast"(%4) : (!llvm.array<3 x vector<[2]xf32>>) -> vector<3x[2]xf32>
    "func.return"(%5) : (vector<3x[2]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xindex>) -> vector<3x2xindex>, sym_name = "broadcast_vec2d_from_index_vec1d"}> ({
  ^bb0(%arg0: vector<2xindex>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<2xindex>) -> vector<2xi64>
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> vector<3x2xindex>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (vector<3x2xindex>) -> !llvm.array<3 x vector<2xi64>>
    %3 = "llvm.insertvalue"(%2, %0) <{position = array<i64: 0>}> : (!llvm.array<3 x vector<2xi64>>, vector<2xi64>) -> !llvm.array<3 x vector<2xi64>>
    %4 = "llvm.insertvalue"(%3, %0) <{position = array<i64: 1>}> : (!llvm.array<3 x vector<2xi64>>, vector<2xi64>) -> !llvm.array<3 x vector<2xi64>>
    %5 = "llvm.insertvalue"(%4, %0) <{position = array<i64: 2>}> : (!llvm.array<3 x vector<2xi64>>, vector<2xi64>) -> !llvm.array<3 x vector<2xi64>>
    %6 = "builtin.unrealized_conversion_cast"(%5) : (!llvm.array<3 x vector<2xi64>>) -> vector<3x2xindex>
    "func.return"(%6) : (vector<3x2xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[2]xindex>) -> vector<3x[2]xindex>, sym_name = "broadcast_vec2d_from_index_vec1d_scalable"}> ({
  ^bb0(%arg0: vector<[2]xindex>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<[2]xindex>) -> vector<[2]xi64>
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> vector<3x[2]xindex>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (vector<3x[2]xindex>) -> !llvm.array<3 x vector<[2]xi64>>
    %3 = "llvm.insertvalue"(%2, %0) <{position = array<i64: 0>}> : (!llvm.array<3 x vector<[2]xi64>>, vector<[2]xi64>) -> !llvm.array<3 x vector<[2]xi64>>
    %4 = "llvm.insertvalue"(%3, %0) <{position = array<i64: 1>}> : (!llvm.array<3 x vector<[2]xi64>>, vector<[2]xi64>) -> !llvm.array<3 x vector<[2]xi64>>
    %5 = "llvm.insertvalue"(%4, %0) <{position = array<i64: 2>}> : (!llvm.array<3 x vector<[2]xi64>>, vector<[2]xi64>) -> !llvm.array<3 x vector<[2]xi64>>
    %6 = "builtin.unrealized_conversion_cast"(%5) : (!llvm.array<3 x vector<[2]xi64>>) -> vector<3x[2]xindex>
    "func.return"(%6) : (vector<3x[2]xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>) -> vector<4x3x2xf32>, sym_name = "broadcast_vec3d_from_vec1d"}> ({
  ^bb0(%arg0: vector<2xf32>):
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> vector<4x3x2xf32>
    %1 = "builtin.unrealized_conversion_cast"(%0) : (vector<4x3x2xf32>) -> !llvm.array<4 x array<3 x vector<2xf32>>>
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> vector<3x2xf32>
    %3 = "builtin.unrealized_conversion_cast"(%2) : (vector<3x2xf32>) -> !llvm.array<3 x vector<2xf32>>
    %4 = "llvm.insertvalue"(%3, %arg0) <{position = array<i64: 0>}> : (!llvm.array<3 x vector<2xf32>>, vector<2xf32>) -> !llvm.array<3 x vector<2xf32>>
    %5 = "llvm.insertvalue"(%4, %arg0) <{position = array<i64: 1>}> : (!llvm.array<3 x vector<2xf32>>, vector<2xf32>) -> !llvm.array<3 x vector<2xf32>>
    %6 = "llvm.insertvalue"(%5, %arg0) <{position = array<i64: 2>}> : (!llvm.array<3 x vector<2xf32>>, vector<2xf32>) -> !llvm.array<3 x vector<2xf32>>
    %7 = "llvm.insertvalue"(%1, %6) <{position = array<i64: 0>}> : (!llvm.array<4 x array<3 x vector<2xf32>>>, !llvm.array<3 x vector<2xf32>>) -> !llvm.array<4 x array<3 x vector<2xf32>>>
    %8 = "llvm.insertvalue"(%7, %6) <{position = array<i64: 1>}> : (!llvm.array<4 x array<3 x vector<2xf32>>>, !llvm.array<3 x vector<2xf32>>) -> !llvm.array<4 x array<3 x vector<2xf32>>>
    %9 = "llvm.insertvalue"(%8, %6) <{position = array<i64: 2>}> : (!llvm.array<4 x array<3 x vector<2xf32>>>, !llvm.array<3 x vector<2xf32>>) -> !llvm.array<4 x array<3 x vector<2xf32>>>
    %10 = "llvm.insertvalue"(%9, %6) <{position = array<i64: 3>}> : (!llvm.array<4 x array<3 x vector<2xf32>>>, !llvm.array<3 x vector<2xf32>>) -> !llvm.array<4 x array<3 x vector<2xf32>>>
    %11 = "builtin.unrealized_conversion_cast"(%10) : (!llvm.array<4 x array<3 x vector<2xf32>>>) -> vector<4x3x2xf32>
    "func.return"(%11) : (vector<4x3x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[2]xf32>) -> vector<4x3x[2]xf32>, sym_name = "broadcast_vec3d_from_vec1d_scalable"}> ({
  ^bb0(%arg0: vector<[2]xf32>):
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> vector<4x3x[2]xf32>
    %1 = "builtin.unrealized_conversion_cast"(%0) : (vector<4x3x[2]xf32>) -> !llvm.array<4 x array<3 x vector<[2]xf32>>>
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> vector<3x[2]xf32>
    %3 = "builtin.unrealized_conversion_cast"(%2) : (vector<3x[2]xf32>) -> !llvm.array<3 x vector<[2]xf32>>
    %4 = "llvm.insertvalue"(%3, %arg0) <{position = array<i64: 0>}> : (!llvm.array<3 x vector<[2]xf32>>, vector<[2]xf32>) -> !llvm.array<3 x vector<[2]xf32>>
    %5 = "llvm.insertvalue"(%4, %arg0) <{position = array<i64: 1>}> : (!llvm.array<3 x vector<[2]xf32>>, vector<[2]xf32>) -> !llvm.array<3 x vector<[2]xf32>>
    %6 = "llvm.insertvalue"(%5, %arg0) <{position = array<i64: 2>}> : (!llvm.array<3 x vector<[2]xf32>>, vector<[2]xf32>) -> !llvm.array<3 x vector<[2]xf32>>
    %7 = "llvm.insertvalue"(%1, %6) <{position = array<i64: 0>}> : (!llvm.array<4 x array<3 x vector<[2]xf32>>>, !llvm.array<3 x vector<[2]xf32>>) -> !llvm.array<4 x array<3 x vector<[2]xf32>>>
    %8 = "llvm.insertvalue"(%7, %6) <{position = array<i64: 1>}> : (!llvm.array<4 x array<3 x vector<[2]xf32>>>, !llvm.array<3 x vector<[2]xf32>>) -> !llvm.array<4 x array<3 x vector<[2]xf32>>>
    %9 = "llvm.insertvalue"(%8, %6) <{position = array<i64: 2>}> : (!llvm.array<4 x array<3 x vector<[2]xf32>>>, !llvm.array<3 x vector<[2]xf32>>) -> !llvm.array<4 x array<3 x vector<[2]xf32>>>
    %10 = "llvm.insertvalue"(%9, %6) <{position = array<i64: 3>}> : (!llvm.array<4 x array<3 x vector<[2]xf32>>>, !llvm.array<3 x vector<[2]xf32>>) -> !llvm.array<4 x array<3 x vector<[2]xf32>>>
    %11 = "builtin.unrealized_conversion_cast"(%10) : (!llvm.array<4 x array<3 x vector<[2]xf32>>>) -> vector<4x3x[2]xf32>
    "func.return"(%11) : (vector<4x3x[2]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3x2xf32>) -> vector<4x3x2xf32>, sym_name = "broadcast_vec3d_from_vec2d"}> ({
  ^bb0(%arg0: vector<3x2xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<3x2xf32>) -> !llvm.array<3 x vector<2xf32>>
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> vector<4x3x2xf32>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (vector<4x3x2xf32>) -> !llvm.array<4 x array<3 x vector<2xf32>>>
    %3 = "llvm.insertvalue"(%2, %0) <{position = array<i64: 0>}> : (!llvm.array<4 x array<3 x vector<2xf32>>>, !llvm.array<3 x vector<2xf32>>) -> !llvm.array<4 x array<3 x vector<2xf32>>>
    %4 = "llvm.insertvalue"(%3, %0) <{position = array<i64: 1>}> : (!llvm.array<4 x array<3 x vector<2xf32>>>, !llvm.array<3 x vector<2xf32>>) -> !llvm.array<4 x array<3 x vector<2xf32>>>
    %5 = "llvm.insertvalue"(%4, %0) <{position = array<i64: 2>}> : (!llvm.array<4 x array<3 x vector<2xf32>>>, !llvm.array<3 x vector<2xf32>>) -> !llvm.array<4 x array<3 x vector<2xf32>>>
    %6 = "llvm.insertvalue"(%5, %0) <{position = array<i64: 3>}> : (!llvm.array<4 x array<3 x vector<2xf32>>>, !llvm.array<3 x vector<2xf32>>) -> !llvm.array<4 x array<3 x vector<2xf32>>>
    %7 = "builtin.unrealized_conversion_cast"(%6) : (!llvm.array<4 x array<3 x vector<2xf32>>>) -> vector<4x3x2xf32>
    "func.return"(%7) : (vector<4x3x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3x[2]xf32>) -> vector<4x3x[2]xf32>, sym_name = "broadcast_vec3d_from_vec2d_scalable"}> ({
  ^bb0(%arg0: vector<3x[2]xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<3x[2]xf32>) -> !llvm.array<3 x vector<[2]xf32>>
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> vector<4x3x[2]xf32>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (vector<4x3x[2]xf32>) -> !llvm.array<4 x array<3 x vector<[2]xf32>>>
    %3 = "llvm.insertvalue"(%2, %0) <{position = array<i64: 0>}> : (!llvm.array<4 x array<3 x vector<[2]xf32>>>, !llvm.array<3 x vector<[2]xf32>>) -> !llvm.array<4 x array<3 x vector<[2]xf32>>>
    %4 = "llvm.insertvalue"(%3, %0) <{position = array<i64: 1>}> : (!llvm.array<4 x array<3 x vector<[2]xf32>>>, !llvm.array<3 x vector<[2]xf32>>) -> !llvm.array<4 x array<3 x vector<[2]xf32>>>
    %5 = "llvm.insertvalue"(%4, %0) <{position = array<i64: 2>}> : (!llvm.array<4 x array<3 x vector<[2]xf32>>>, !llvm.array<3 x vector<[2]xf32>>) -> !llvm.array<4 x array<3 x vector<[2]xf32>>>
    %6 = "llvm.insertvalue"(%5, %0) <{position = array<i64: 3>}> : (!llvm.array<4 x array<3 x vector<[2]xf32>>>, !llvm.array<3 x vector<[2]xf32>>) -> !llvm.array<4 x array<3 x vector<[2]xf32>>>
    %7 = "builtin.unrealized_conversion_cast"(%6) : (!llvm.array<4 x array<3 x vector<[2]xf32>>>) -> vector<4x3x[2]xf32>
    "func.return"(%7) : (vector<4x3x[2]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>) -> vector<4xf32>, sym_name = "broadcast_stretch"}> ({
  ^bb0(%arg0: vector<1xf32>):
    %0 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %1 = "llvm.extractelement"(%arg0, %0) : (vector<1xf32>, i64) -> f32
    %2 = "llvm.mlir.poison"() : () -> vector<4xf32>
    %3 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "llvm.insertelement"(%2, %1, %3) : (vector<4xf32>, f32, i32) -> vector<4xf32>
    %5 = "llvm.shufflevector"(%4, %2) <{mask = array<i32: 0, 0, 0, 0>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"(%5) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>) -> vector<[4]xf32>, sym_name = "broadcast_stretch_scalable"}> ({
  ^bb0(%arg0: vector<1xf32>):
    %0 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %1 = "llvm.extractelement"(%arg0, %0) : (vector<1xf32>, i64) -> f32
    %2 = "llvm.mlir.poison"() : () -> vector<[4]xf32>
    %3 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "llvm.insertelement"(%2, %1, %3) : (vector<[4]xf32>, f32, i32) -> vector<[4]xf32>
    %5 = "llvm.shufflevector"(%4, %2) <{mask = array<i32: 0, 0, 0, 0>}> : (vector<[4]xf32>, vector<[4]xf32>) -> vector<[4]xf32>
    "func.return"(%5) : (vector<[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x4xf32>) -> vector<3x4xf32>, sym_name = "broadcast_stretch_at_start"}> ({
  ^bb0(%arg0: vector<1x4xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<1x4xf32>) -> !llvm.array<1 x vector<4xf32>>
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> vector<3x4xf32>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (vector<3x4xf32>) -> !llvm.array<3 x vector<4xf32>>
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.array<1 x vector<4xf32>>) -> vector<4xf32>
    %4 = "llvm.insertvalue"(%2, %3) <{position = array<i64: 0>}> : (!llvm.array<3 x vector<4xf32>>, vector<4xf32>) -> !llvm.array<3 x vector<4xf32>>
    %5 = "llvm.insertvalue"(%4, %3) <{position = array<i64: 1>}> : (!llvm.array<3 x vector<4xf32>>, vector<4xf32>) -> !llvm.array<3 x vector<4xf32>>
    %6 = "llvm.insertvalue"(%5, %3) <{position = array<i64: 2>}> : (!llvm.array<3 x vector<4xf32>>, vector<4xf32>) -> !llvm.array<3 x vector<4xf32>>
    %7 = "builtin.unrealized_conversion_cast"(%6) : (!llvm.array<3 x vector<4xf32>>) -> vector<3x4xf32>
    "func.return"(%7) : (vector<3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x[4]xf32>) -> vector<3x[4]xf32>, sym_name = "broadcast_stretch_at_start_scalable"}> ({
  ^bb0(%arg0: vector<1x[4]xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<1x[4]xf32>) -> !llvm.array<1 x vector<[4]xf32>>
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> vector<3x[4]xf32>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (vector<3x[4]xf32>) -> !llvm.array<3 x vector<[4]xf32>>
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.array<1 x vector<[4]xf32>>) -> vector<[4]xf32>
    %4 = "llvm.insertvalue"(%2, %3) <{position = array<i64: 0>}> : (!llvm.array<3 x vector<[4]xf32>>, vector<[4]xf32>) -> !llvm.array<3 x vector<[4]xf32>>
    %5 = "llvm.insertvalue"(%4, %3) <{position = array<i64: 1>}> : (!llvm.array<3 x vector<[4]xf32>>, vector<[4]xf32>) -> !llvm.array<3 x vector<[4]xf32>>
    %6 = "llvm.insertvalue"(%5, %3) <{position = array<i64: 2>}> : (!llvm.array<3 x vector<[4]xf32>>, vector<[4]xf32>) -> !llvm.array<3 x vector<[4]xf32>>
    %7 = "builtin.unrealized_conversion_cast"(%6) : (!llvm.array<3 x vector<[4]xf32>>) -> vector<3x[4]xf32>
    "func.return"(%7) : (vector<3x[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x1xf32>) -> vector<4x3xf32>, sym_name = "broadcast_stretch_at_end"}> ({
  ^bb0(%arg1: vector<4x1xf32>):
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<4x1xf32>) -> !llvm.array<4 x vector<1xf32>>
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> vector<4x3xf32>
    %3 = "builtin.unrealized_conversion_cast"(%2) : (vector<4x3xf32>) -> !llvm.array<4 x vector<3xf32>>
    %4 = "llvm.extractvalue"(%1) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<1xf32>>) -> vector<1xf32>
    %5 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %6 = "llvm.extractelement"(%4, %5) : (vector<1xf32>, i64) -> f32
    %7 = "llvm.mlir.poison"() : () -> vector<3xf32>
    %8 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %9 = "llvm.insertelement"(%7, %6, %8) : (vector<3xf32>, f32, i32) -> vector<3xf32>
    %10 = "llvm.shufflevector"(%9, %7) <{mask = array<i32: 0, 0, 0>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %11 = "llvm.insertvalue"(%3, %10) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<3xf32>>, vector<3xf32>) -> !llvm.array<4 x vector<3xf32>>
    %12 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<1xf32>>) -> vector<1xf32>
    %13 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %14 = "llvm.extractelement"(%12, %13) : (vector<1xf32>, i64) -> f32
    %15 = "llvm.mlir.poison"() : () -> vector<3xf32>
    %16 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %17 = "llvm.insertelement"(%15, %14, %16) : (vector<3xf32>, f32, i32) -> vector<3xf32>
    %18 = "llvm.shufflevector"(%17, %15) <{mask = array<i32: 0, 0, 0>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %19 = "llvm.insertvalue"(%11, %18) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<3xf32>>, vector<3xf32>) -> !llvm.array<4 x vector<3xf32>>
    %20 = "llvm.extractvalue"(%1) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<1xf32>>) -> vector<1xf32>
    %21 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %22 = "llvm.extractelement"(%20, %21) : (vector<1xf32>, i64) -> f32
    %23 = "llvm.mlir.poison"() : () -> vector<3xf32>
    %24 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %25 = "llvm.insertelement"(%23, %22, %24) : (vector<3xf32>, f32, i32) -> vector<3xf32>
    %26 = "llvm.shufflevector"(%25, %23) <{mask = array<i32: 0, 0, 0>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %27 = "llvm.insertvalue"(%19, %26) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<3xf32>>, vector<3xf32>) -> !llvm.array<4 x vector<3xf32>>
    %28 = "llvm.extractvalue"(%1) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<1xf32>>) -> vector<1xf32>
    %29 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %30 = "llvm.extractelement"(%28, %29) : (vector<1xf32>, i64) -> f32
    %31 = "llvm.mlir.poison"() : () -> vector<3xf32>
    %32 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %33 = "llvm.insertelement"(%31, %30, %32) : (vector<3xf32>, f32, i32) -> vector<3xf32>
    %34 = "llvm.shufflevector"(%33, %31) <{mask = array<i32: 0, 0, 0>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %35 = "llvm.insertvalue"(%27, %34) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<3xf32>>, vector<3xf32>) -> !llvm.array<4 x vector<3xf32>>
    %36 = "builtin.unrealized_conversion_cast"(%35) : (!llvm.array<4 x vector<3xf32>>) -> vector<4x3xf32>
    "func.return"(%36) : (vector<4x3xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<[4]x1xf32>) -> vector<[4]x3xf32>, sym_name = "broadcast_stretch_at_end_scalable"}> ({
  ^bb0(%arg0: vector<[4]x1xf32>):
    %0 = "vector.broadcast"(%arg0) : (vector<[4]x1xf32>) -> vector<[4]x3xf32>
    "func.return"(%0) : (vector<[4]x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x1x2xf32>) -> vector<4x3x2xf32>, sym_name = "broadcast_stretch_in_middle"}> ({
  ^bb0(%arg0: vector<4x1x2xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<4x1x2xf32>) -> !llvm.array<4 x array<1 x vector<2xf32>>>
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> vector<4x3x2xf32>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (vector<4x3x2xf32>) -> !llvm.array<4 x array<3 x vector<2xf32>>>
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> vector<3x2xf32>
    %4 = "builtin.unrealized_conversion_cast"(%3) : (vector<3x2xf32>) -> !llvm.array<3 x vector<2xf32>>
    %5 = "llvm.extractvalue"(%0) <{position = array<i64: 0, 0>}> : (!llvm.array<4 x array<1 x vector<2xf32>>>) -> vector<2xf32>
    %6 = "llvm.insertvalue"(%4, %5) <{position = array<i64: 0>}> : (!llvm.array<3 x vector<2xf32>>, vector<2xf32>) -> !llvm.array<3 x vector<2xf32>>
    %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 1>}> : (!llvm.array<3 x vector<2xf32>>, vector<2xf32>) -> !llvm.array<3 x vector<2xf32>>
    %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 2>}> : (!llvm.array<3 x vector<2xf32>>, vector<2xf32>) -> !llvm.array<3 x vector<2xf32>>
    %9 = "llvm.insertvalue"(%2, %8) <{position = array<i64: 0>}> : (!llvm.array<4 x array<3 x vector<2xf32>>>, !llvm.array<3 x vector<2xf32>>) -> !llvm.array<4 x array<3 x vector<2xf32>>>
    %10 = "llvm.extractvalue"(%0) <{position = array<i64: 1, 0>}> : (!llvm.array<4 x array<1 x vector<2xf32>>>) -> vector<2xf32>
    %11 = "llvm.insertvalue"(%4, %10) <{position = array<i64: 0>}> : (!llvm.array<3 x vector<2xf32>>, vector<2xf32>) -> !llvm.array<3 x vector<2xf32>>
    %12 = "llvm.insertvalue"(%11, %10) <{position = array<i64: 1>}> : (!llvm.array<3 x vector<2xf32>>, vector<2xf32>) -> !llvm.array<3 x vector<2xf32>>
    %13 = "llvm.insertvalue"(%12, %10) <{position = array<i64: 2>}> : (!llvm.array<3 x vector<2xf32>>, vector<2xf32>) -> !llvm.array<3 x vector<2xf32>>
    %14 = "llvm.insertvalue"(%9, %13) <{position = array<i64: 1>}> : (!llvm.array<4 x array<3 x vector<2xf32>>>, !llvm.array<3 x vector<2xf32>>) -> !llvm.array<4 x array<3 x vector<2xf32>>>
    %15 = "llvm.extractvalue"(%0) <{position = array<i64: 2, 0>}> : (!llvm.array<4 x array<1 x vector<2xf32>>>) -> vector<2xf32>
    %16 = "llvm.insertvalue"(%4, %15) <{position = array<i64: 0>}> : (!llvm.array<3 x vector<2xf32>>, vector<2xf32>) -> !llvm.array<3 x vector<2xf32>>
    %17 = "llvm.insertvalue"(%16, %15) <{position = array<i64: 1>}> : (!llvm.array<3 x vector<2xf32>>, vector<2xf32>) -> !llvm.array<3 x vector<2xf32>>
    %18 = "llvm.insertvalue"(%17, %15) <{position = array<i64: 2>}> : (!llvm.array<3 x vector<2xf32>>, vector<2xf32>) -> !llvm.array<3 x vector<2xf32>>
    %19 = "llvm.insertvalue"(%14, %18) <{position = array<i64: 2>}> : (!llvm.array<4 x array<3 x vector<2xf32>>>, !llvm.array<3 x vector<2xf32>>) -> !llvm.array<4 x array<3 x vector<2xf32>>>
    %20 = "llvm.extractvalue"(%0) <{position = array<i64: 3, 0>}> : (!llvm.array<4 x array<1 x vector<2xf32>>>) -> vector<2xf32>
    %21 = "llvm.insertvalue"(%4, %20) <{position = array<i64: 0>}> : (!llvm.array<3 x vector<2xf32>>, vector<2xf32>) -> !llvm.array<3 x vector<2xf32>>
    %22 = "llvm.insertvalue"(%21, %20) <{position = array<i64: 1>}> : (!llvm.array<3 x vector<2xf32>>, vector<2xf32>) -> !llvm.array<3 x vector<2xf32>>
    %23 = "llvm.insertvalue"(%22, %20) <{position = array<i64: 2>}> : (!llvm.array<3 x vector<2xf32>>, vector<2xf32>) -> !llvm.array<3 x vector<2xf32>>
    %24 = "llvm.insertvalue"(%19, %23) <{position = array<i64: 3>}> : (!llvm.array<4 x array<3 x vector<2xf32>>>, !llvm.array<3 x vector<2xf32>>) -> !llvm.array<4 x array<3 x vector<2xf32>>>
    %25 = "builtin.unrealized_conversion_cast"(%24) : (!llvm.array<4 x array<3 x vector<2xf32>>>) -> vector<4x3x2xf32>
    "func.return"(%25) : (vector<4x3x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x1x[2]xf32>) -> vector<4x3x[2]xf32>, sym_name = "broadcast_stretch_in_middle_scalable_v1"}> ({
  ^bb0(%arg0: vector<4x1x[2]xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<4x1x[2]xf32>) -> !llvm.array<4 x array<1 x vector<[2]xf32>>>
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> vector<4x3x[2]xf32>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (vector<4x3x[2]xf32>) -> !llvm.array<4 x array<3 x vector<[2]xf32>>>
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> vector<3x[2]xf32>
    %4 = "builtin.unrealized_conversion_cast"(%3) : (vector<3x[2]xf32>) -> !llvm.array<3 x vector<[2]xf32>>
    %5 = "llvm.extractvalue"(%0) <{position = array<i64: 0, 0>}> : (!llvm.array<4 x array<1 x vector<[2]xf32>>>) -> vector<[2]xf32>
    %6 = "llvm.insertvalue"(%4, %5) <{position = array<i64: 0>}> : (!llvm.array<3 x vector<[2]xf32>>, vector<[2]xf32>) -> !llvm.array<3 x vector<[2]xf32>>
    %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 1>}> : (!llvm.array<3 x vector<[2]xf32>>, vector<[2]xf32>) -> !llvm.array<3 x vector<[2]xf32>>
    %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 2>}> : (!llvm.array<3 x vector<[2]xf32>>, vector<[2]xf32>) -> !llvm.array<3 x vector<[2]xf32>>
    %9 = "llvm.insertvalue"(%2, %8) <{position = array<i64: 0>}> : (!llvm.array<4 x array<3 x vector<[2]xf32>>>, !llvm.array<3 x vector<[2]xf32>>) -> !llvm.array<4 x array<3 x vector<[2]xf32>>>
    %10 = "llvm.extractvalue"(%0) <{position = array<i64: 1, 0>}> : (!llvm.array<4 x array<1 x vector<[2]xf32>>>) -> vector<[2]xf32>
    %11 = "llvm.insertvalue"(%4, %10) <{position = array<i64: 0>}> : (!llvm.array<3 x vector<[2]xf32>>, vector<[2]xf32>) -> !llvm.array<3 x vector<[2]xf32>>
    %12 = "llvm.insertvalue"(%11, %10) <{position = array<i64: 1>}> : (!llvm.array<3 x vector<[2]xf32>>, vector<[2]xf32>) -> !llvm.array<3 x vector<[2]xf32>>
    %13 = "llvm.insertvalue"(%12, %10) <{position = array<i64: 2>}> : (!llvm.array<3 x vector<[2]xf32>>, vector<[2]xf32>) -> !llvm.array<3 x vector<[2]xf32>>
    %14 = "llvm.insertvalue"(%9, %13) <{position = array<i64: 1>}> : (!llvm.array<4 x array<3 x vector<[2]xf32>>>, !llvm.array<3 x vector<[2]xf32>>) -> !llvm.array<4 x array<3 x vector<[2]xf32>>>
    %15 = "llvm.extractvalue"(%0) <{position = array<i64: 2, 0>}> : (!llvm.array<4 x array<1 x vector<[2]xf32>>>) -> vector<[2]xf32>
    %16 = "llvm.insertvalue"(%4, %15) <{position = array<i64: 0>}> : (!llvm.array<3 x vector<[2]xf32>>, vector<[2]xf32>) -> !llvm.array<3 x vector<[2]xf32>>
    %17 = "llvm.insertvalue"(%16, %15) <{position = array<i64: 1>}> : (!llvm.array<3 x vector<[2]xf32>>, vector<[2]xf32>) -> !llvm.array<3 x vector<[2]xf32>>
    %18 = "llvm.insertvalue"(%17, %15) <{position = array<i64: 2>}> : (!llvm.array<3 x vector<[2]xf32>>, vector<[2]xf32>) -> !llvm.array<3 x vector<[2]xf32>>
    %19 = "llvm.insertvalue"(%14, %18) <{position = array<i64: 2>}> : (!llvm.array<4 x array<3 x vector<[2]xf32>>>, !llvm.array<3 x vector<[2]xf32>>) -> !llvm.array<4 x array<3 x vector<[2]xf32>>>
    %20 = "llvm.extractvalue"(%0) <{position = array<i64: 3, 0>}> : (!llvm.array<4 x array<1 x vector<[2]xf32>>>) -> vector<[2]xf32>
    %21 = "llvm.insertvalue"(%4, %20) <{position = array<i64: 0>}> : (!llvm.array<3 x vector<[2]xf32>>, vector<[2]xf32>) -> !llvm.array<3 x vector<[2]xf32>>
    %22 = "llvm.insertvalue"(%21, %20) <{position = array<i64: 1>}> : (!llvm.array<3 x vector<[2]xf32>>, vector<[2]xf32>) -> !llvm.array<3 x vector<[2]xf32>>
    %23 = "llvm.insertvalue"(%22, %20) <{position = array<i64: 2>}> : (!llvm.array<3 x vector<[2]xf32>>, vector<[2]xf32>) -> !llvm.array<3 x vector<[2]xf32>>
    %24 = "llvm.insertvalue"(%19, %23) <{position = array<i64: 3>}> : (!llvm.array<4 x array<3 x vector<[2]xf32>>>, !llvm.array<3 x vector<[2]xf32>>) -> !llvm.array<4 x array<3 x vector<[2]xf32>>>
    %25 = "builtin.unrealized_conversion_cast"(%24) : (!llvm.array<4 x array<3 x vector<[2]xf32>>>) -> vector<4x3x[2]xf32>
    "func.return"(%25) : (vector<4x3x[2]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]x1x2xf32>) -> vector<[4]x3x2xf32>, sym_name = "broadcast_stretch_in_middle_scalable_v2"}> ({
  ^bb0(%arg0: vector<[4]x1x2xf32>):
    %0 = "vector.broadcast"(%arg0) : (vector<[4]x1x2xf32>) -> vector<[4]x3x2xf32>
    "func.return"(%0) : (vector<[4]x3x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, vector<3xf32>) -> vector<2x3xf32>, sym_name = "outerproduct"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<3xf32>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2x3xf32>}> : () -> vector<2x3xf32>
    %1 = "builtin.unrealized_conversion_cast"(%0) : (vector<2x3xf32>) -> !llvm.array<2 x vector<3xf32>>
    %2 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %3 = "llvm.extractelement"(%arg0, %2) : (vector<2xf32>, i64) -> f32
    %4 = "llvm.mlir.poison"() : () -> vector<3xf32>
    %5 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %6 = "llvm.insertelement"(%4, %3, %5) : (vector<3xf32>, f32, i32) -> vector<3xf32>
    %7 = "llvm.shufflevector"(%6, %4) <{mask = array<i32: 0, 0, 0>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %8 = "arith.mulf"(%7, %arg1) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %9 = "llvm.insertvalue"(%1, %8) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<3xf32>>, vector<3xf32>) -> !llvm.array<2 x vector<3xf32>>
    %10 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %11 = "llvm.extractelement"(%arg0, %10) : (vector<2xf32>, i64) -> f32
    %12 = "llvm.mlir.poison"() : () -> vector<3xf32>
    %13 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %14 = "llvm.insertelement"(%12, %11, %13) : (vector<3xf32>, f32, i32) -> vector<3xf32>
    %15 = "llvm.shufflevector"(%14, %12) <{mask = array<i32: 0, 0, 0>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %16 = "arith.mulf"(%15, %arg1) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %17 = "llvm.insertvalue"(%9, %16) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<3xf32>>, vector<3xf32>) -> !llvm.array<2 x vector<3xf32>>
    %18 = "builtin.unrealized_conversion_cast"(%17) : (!llvm.array<2 x vector<3xf32>>) -> vector<2x3xf32>
    "func.return"(%18) : (vector<2x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, vector<[3]xf32>) -> vector<2x[3]xf32>, sym_name = "outerproduct_scalable"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<[3]xf32>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2x[3]xf32>}> : () -> vector<2x[3]xf32>
    %1 = "builtin.unrealized_conversion_cast"(%0) : (vector<2x[3]xf32>) -> !llvm.array<2 x vector<[3]xf32>>
    %2 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %3 = "llvm.extractelement"(%arg0, %2) : (vector<2xf32>, i64) -> f32
    %4 = "llvm.mlir.poison"() : () -> vector<[3]xf32>
    %5 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %6 = "llvm.insertelement"(%4, %3, %5) : (vector<[3]xf32>, f32, i32) -> vector<[3]xf32>
    %7 = "llvm.shufflevector"(%6, %4) <{mask = array<i32: 0, 0, 0>}> : (vector<[3]xf32>, vector<[3]xf32>) -> vector<[3]xf32>
    %8 = "arith.mulf"(%7, %arg1) <{fastmath = #arith.fastmath<none>}> : (vector<[3]xf32>, vector<[3]xf32>) -> vector<[3]xf32>
    %9 = "llvm.insertvalue"(%1, %8) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<[3]xf32>>, vector<[3]xf32>) -> !llvm.array<2 x vector<[3]xf32>>
    %10 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %11 = "llvm.extractelement"(%arg0, %10) : (vector<2xf32>, i64) -> f32
    %12 = "llvm.mlir.poison"() : () -> vector<[3]xf32>
    %13 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %14 = "llvm.insertelement"(%12, %11, %13) : (vector<[3]xf32>, f32, i32) -> vector<[3]xf32>
    %15 = "llvm.shufflevector"(%14, %12) <{mask = array<i32: 0, 0, 0>}> : (vector<[3]xf32>, vector<[3]xf32>) -> vector<[3]xf32>
    %16 = "arith.mulf"(%15, %arg1) <{fastmath = #arith.fastmath<none>}> : (vector<[3]xf32>, vector<[3]xf32>) -> vector<[3]xf32>
    %17 = "llvm.insertvalue"(%9, %16) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<[3]xf32>>, vector<[3]xf32>) -> !llvm.array<2 x vector<[3]xf32>>
    %18 = "builtin.unrealized_conversion_cast"(%17) : (!llvm.array<2 x vector<[3]xf32>>) -> vector<2x[3]xf32>
    "func.return"(%18) : (vector<2x[3]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xindex>, vector<3xindex>) -> vector<2x3xindex>, sym_name = "outerproduct_index"}> ({
  ^bb0(%arg0: vector<2xindex>, %arg1: vector<3xindex>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<2xindex>) -> vector<2xi64>
    %1 = "arith.constant"() <{value = dense<0> : vector<2x3xindex>}> : () -> vector<2x3xindex>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (vector<2x3xindex>) -> !llvm.array<2 x vector<3xi64>>
    %3 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %4 = "llvm.extractelement"(%0, %3) : (vector<2xi64>, i64) -> i64
    %5 = "llvm.mlir.poison"() : () -> vector<3xi64>
    %6 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %7 = "llvm.insertelement"(%5, %4, %6) : (vector<3xi64>, i64, i32) -> vector<3xi64>
    %8 = "llvm.shufflevector"(%7, %5) <{mask = array<i32: 0, 0, 0>}> : (vector<3xi64>, vector<3xi64>) -> vector<3xi64>
    %9 = "builtin.unrealized_conversion_cast"(%8) : (vector<3xi64>) -> vector<3xindex>
    %10 = "arith.muli"(%9, %arg1) <{overflowFlags = #arith.overflow<none>}> : (vector<3xindex>, vector<3xindex>) -> vector<3xindex>
    %11 = "builtin.unrealized_conversion_cast"(%10) : (vector<3xindex>) -> vector<3xi64>
    %12 = "llvm.insertvalue"(%2, %11) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<3xi64>>, vector<3xi64>) -> !llvm.array<2 x vector<3xi64>>
    %13 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %14 = "llvm.extractelement"(%0, %13) : (vector<2xi64>, i64) -> i64
    %15 = "llvm.mlir.poison"() : () -> vector<3xi64>
    %16 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %17 = "llvm.insertelement"(%15, %14, %16) : (vector<3xi64>, i64, i32) -> vector<3xi64>
    %18 = "llvm.shufflevector"(%17, %15) <{mask = array<i32: 0, 0, 0>}> : (vector<3xi64>, vector<3xi64>) -> vector<3xi64>
    %19 = "builtin.unrealized_conversion_cast"(%18) : (vector<3xi64>) -> vector<3xindex>
    %20 = "arith.muli"(%19, %arg1) <{overflowFlags = #arith.overflow<none>}> : (vector<3xindex>, vector<3xindex>) -> vector<3xindex>
    %21 = "builtin.unrealized_conversion_cast"(%20) : (vector<3xindex>) -> vector<3xi64>
    %22 = "llvm.insertvalue"(%12, %21) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<3xi64>>, vector<3xi64>) -> !llvm.array<2 x vector<3xi64>>
    %23 = "builtin.unrealized_conversion_cast"(%22) : (!llvm.array<2 x vector<3xi64>>) -> vector<2x3xindex>
    "func.return"(%23) : (vector<2x3xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xindex>, vector<[3]xindex>) -> vector<2x[3]xindex>, sym_name = "outerproduct_index_scalable"}> ({
  ^bb0(%arg0: vector<2xindex>, %arg1: vector<[3]xindex>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<2xindex>) -> vector<2xi64>
    %1 = "arith.constant"() <{value = dense<0> : vector<2x[3]xindex>}> : () -> vector<2x[3]xindex>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (vector<2x[3]xindex>) -> !llvm.array<2 x vector<[3]xi64>>
    %3 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %4 = "llvm.extractelement"(%0, %3) : (vector<2xi64>, i64) -> i64
    %5 = "llvm.mlir.poison"() : () -> vector<[3]xi64>
    %6 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %7 = "llvm.insertelement"(%5, %4, %6) : (vector<[3]xi64>, i64, i32) -> vector<[3]xi64>
    %8 = "llvm.shufflevector"(%7, %5) <{mask = array<i32: 0, 0, 0>}> : (vector<[3]xi64>, vector<[3]xi64>) -> vector<[3]xi64>
    %9 = "builtin.unrealized_conversion_cast"(%8) : (vector<[3]xi64>) -> vector<[3]xindex>
    %10 = "arith.muli"(%9, %arg1) <{overflowFlags = #arith.overflow<none>}> : (vector<[3]xindex>, vector<[3]xindex>) -> vector<[3]xindex>
    %11 = "builtin.unrealized_conversion_cast"(%10) : (vector<[3]xindex>) -> vector<[3]xi64>
    %12 = "llvm.insertvalue"(%2, %11) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<[3]xi64>>, vector<[3]xi64>) -> !llvm.array<2 x vector<[3]xi64>>
    %13 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %14 = "llvm.extractelement"(%0, %13) : (vector<2xi64>, i64) -> i64
    %15 = "llvm.mlir.poison"() : () -> vector<[3]xi64>
    %16 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %17 = "llvm.insertelement"(%15, %14, %16) : (vector<[3]xi64>, i64, i32) -> vector<[3]xi64>
    %18 = "llvm.shufflevector"(%17, %15) <{mask = array<i32: 0, 0, 0>}> : (vector<[3]xi64>, vector<[3]xi64>) -> vector<[3]xi64>
    %19 = "builtin.unrealized_conversion_cast"(%18) : (vector<[3]xi64>) -> vector<[3]xindex>
    %20 = "arith.muli"(%19, %arg1) <{overflowFlags = #arith.overflow<none>}> : (vector<[3]xindex>, vector<[3]xindex>) -> vector<[3]xindex>
    %21 = "builtin.unrealized_conversion_cast"(%20) : (vector<[3]xindex>) -> vector<[3]xi64>
    %22 = "llvm.insertvalue"(%12, %21) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<[3]xi64>>, vector<[3]xi64>) -> !llvm.array<2 x vector<[3]xi64>>
    %23 = "builtin.unrealized_conversion_cast"(%22) : (!llvm.array<2 x vector<[3]xi64>>) -> vector<2x[3]xindex>
    "func.return"(%23) : (vector<2x[3]xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, vector<3xf32>, vector<2x3xf32>) -> vector<2x3xf32>, sym_name = "outerproduct_add"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<3xf32>, %arg2: vector<2x3xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (vector<2x3xf32>) -> !llvm.array<2 x vector<3xf32>>
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2x3xf32>}> : () -> vector<2x3xf32>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (vector<2x3xf32>) -> !llvm.array<2 x vector<3xf32>>
    %3 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %4 = "llvm.extractelement"(%arg0, %3) : (vector<2xf32>, i64) -> f32
    %5 = "llvm.mlir.poison"() : () -> vector<3xf32>
    %6 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %7 = "llvm.insertelement"(%5, %4, %6) : (vector<3xf32>, f32, i32) -> vector<3xf32>
    %8 = "llvm.shufflevector"(%7, %5) <{mask = array<i32: 0, 0, 0>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %9 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<3xf32>>) -> vector<3xf32>
    %10 = "llvm.intr.fmuladd"(%8, %arg1, %9) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf32>, vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %11 = "llvm.insertvalue"(%2, %10) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<3xf32>>, vector<3xf32>) -> !llvm.array<2 x vector<3xf32>>
    %12 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %13 = "llvm.extractelement"(%arg0, %12) : (vector<2xf32>, i64) -> f32
    %14 = "llvm.mlir.poison"() : () -> vector<3xf32>
    %15 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %16 = "llvm.insertelement"(%14, %13, %15) : (vector<3xf32>, f32, i32) -> vector<3xf32>
    %17 = "llvm.shufflevector"(%16, %14) <{mask = array<i32: 0, 0, 0>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %18 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<3xf32>>) -> vector<3xf32>
    %19 = "llvm.intr.fmuladd"(%17, %arg1, %18) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf32>, vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %20 = "llvm.insertvalue"(%11, %19) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<3xf32>>, vector<3xf32>) -> !llvm.array<2 x vector<3xf32>>
    %21 = "builtin.unrealized_conversion_cast"(%20) : (!llvm.array<2 x vector<3xf32>>) -> vector<2x3xf32>
    "func.return"(%21) : (vector<2x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, vector<[3]xf32>, vector<2x[3]xf32>) -> vector<2x[3]xf32>, sym_name = "outerproduct_add_scalable"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<[3]xf32>, %arg2: vector<2x[3]xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (vector<2x[3]xf32>) -> !llvm.array<2 x vector<[3]xf32>>
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2x[3]xf32>}> : () -> vector<2x[3]xf32>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (vector<2x[3]xf32>) -> !llvm.array<2 x vector<[3]xf32>>
    %3 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %4 = "llvm.extractelement"(%arg0, %3) : (vector<2xf32>, i64) -> f32
    %5 = "llvm.mlir.poison"() : () -> vector<[3]xf32>
    %6 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %7 = "llvm.insertelement"(%5, %4, %6) : (vector<[3]xf32>, f32, i32) -> vector<[3]xf32>
    %8 = "llvm.shufflevector"(%7, %5) <{mask = array<i32: 0, 0, 0>}> : (vector<[3]xf32>, vector<[3]xf32>) -> vector<[3]xf32>
    %9 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<[3]xf32>>) -> vector<[3]xf32>
    %10 = "llvm.intr.fmuladd"(%8, %arg1, %9) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<[3]xf32>, vector<[3]xf32>, vector<[3]xf32>) -> vector<[3]xf32>
    %11 = "llvm.insertvalue"(%2, %10) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<[3]xf32>>, vector<[3]xf32>) -> !llvm.array<2 x vector<[3]xf32>>
    %12 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %13 = "llvm.extractelement"(%arg0, %12) : (vector<2xf32>, i64) -> f32
    %14 = "llvm.mlir.poison"() : () -> vector<[3]xf32>
    %15 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %16 = "llvm.insertelement"(%14, %13, %15) : (vector<[3]xf32>, f32, i32) -> vector<[3]xf32>
    %17 = "llvm.shufflevector"(%16, %14) <{mask = array<i32: 0, 0, 0>}> : (vector<[3]xf32>, vector<[3]xf32>) -> vector<[3]xf32>
    %18 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<[3]xf32>>) -> vector<[3]xf32>
    %19 = "llvm.intr.fmuladd"(%17, %arg1, %18) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<[3]xf32>, vector<[3]xf32>, vector<[3]xf32>) -> vector<[3]xf32>
    %20 = "llvm.insertvalue"(%11, %19) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<[3]xf32>>, vector<[3]xf32>) -> !llvm.array<2 x vector<[3]xf32>>
    %21 = "builtin.unrealized_conversion_cast"(%20) : (!llvm.array<2 x vector<[3]xf32>>) -> vector<2x[3]xf32>
    "func.return"(%21) : (vector<2x[3]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, f32, vector<2xf32>, vector<2xi1>) -> vector<2xf32>, sym_name = "masked_float_add_outerprod"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: f32, %arg2: vector<2xf32>, %arg3: vector<2xi1>):
    %0 = "llvm.mlir.poison"() : () -> vector<2xf32>
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.insertelement"(%0, %arg1, %1) : (vector<2xf32>, f32, i32) -> vector<2xf32>
    %3 = "llvm.shufflevector"(%2, %0) <{mask = array<i32: 0, 0>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %4 = "llvm.intr.fmuladd"(%arg0, %3, %arg2) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %5 = "arith.select"(%arg3, %4, %arg2) : (vector<2xi1>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "func.return"(%5) : (vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[2]xf32>, f32, vector<[2]xf32>, vector<[2]xi1>) -> vector<[2]xf32>, sym_name = "masked_float_add_outerprod_scalable"}> ({
  ^bb0(%arg0: vector<[2]xf32>, %arg1: f32, %arg2: vector<[2]xf32>, %arg3: vector<[2]xi1>):
    %0 = "llvm.mlir.poison"() : () -> vector<[2]xf32>
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.insertelement"(%0, %arg1, %1) : (vector<[2]xf32>, f32, i32) -> vector<[2]xf32>
    %3 = "llvm.shufflevector"(%2, %0) <{mask = array<i32: 0, 0>}> : (vector<[2]xf32>, vector<[2]xf32>) -> vector<[2]xf32>
    %4 = "llvm.intr.fmuladd"(%arg0, %3, %arg2) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<[2]xf32>, vector<[2]xf32>, vector<[2]xf32>) -> vector<[2]xf32>
    %5 = "arith.select"(%arg3, %4, %arg2) : (vector<[2]xi1>, vector<[2]xf32>, vector<[2]xf32>) -> vector<[2]xf32>
    "func.return"(%5) : (vector<[2]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, f32, vector<2xf32>, vector<2xi1>) -> vector<2xf32>, sym_name = "masked_float_mul_outerprod"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: f32, %arg2: vector<2xf32>, %arg3: vector<2xi1>):
    %0 = "llvm.mlir.poison"() : () -> vector<2xf32>
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.insertelement"(%0, %arg1, %1) : (vector<2xf32>, f32, i32) -> vector<2xf32>
    %3 = "llvm.shufflevector"(%2, %0) <{mask = array<i32: 0, 0>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %4 = "arith.mulf"(%arg0, %3) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %5 = "arith.mulf"(%4, %arg2) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %6 = "arith.select"(%arg3, %5, %arg2) : (vector<2xi1>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "func.return"(%6) : (vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[2]xf32>, f32, vector<[2]xf32>, vector<[2]xi1>) -> vector<[2]xf32>, sym_name = "masked_float_mul_outerprod_scalable"}> ({
  ^bb0(%arg0: vector<[2]xf32>, %arg1: f32, %arg2: vector<[2]xf32>, %arg3: vector<[2]xi1>):
    %0 = "llvm.mlir.poison"() : () -> vector<[2]xf32>
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.insertelement"(%0, %arg1, %1) : (vector<[2]xf32>, f32, i32) -> vector<[2]xf32>
    %3 = "llvm.shufflevector"(%2, %0) <{mask = array<i32: 0, 0>}> : (vector<[2]xf32>, vector<[2]xf32>) -> vector<[2]xf32>
    %4 = "arith.mulf"(%arg0, %3) <{fastmath = #arith.fastmath<none>}> : (vector<[2]xf32>, vector<[2]xf32>) -> vector<[2]xf32>
    %5 = "arith.mulf"(%4, %arg2) <{fastmath = #arith.fastmath<none>}> : (vector<[2]xf32>, vector<[2]xf32>) -> vector<[2]xf32>
    %6 = "arith.select"(%arg3, %5, %arg2) : (vector<[2]xi1>, vector<[2]xf32>, vector<[2]xf32>) -> vector<[2]xf32>
    "func.return"(%6) : (vector<[2]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, f32, vector<2xf32>, vector<2xi1>) -> vector<2xf32>, sym_name = "masked_float_max_outerprod"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: f32, %arg2: vector<2xf32>, %arg3: vector<2xi1>):
    %0 = "llvm.mlir.poison"() : () -> vector<2xf32>
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.insertelement"(%0, %arg1, %1) : (vector<2xf32>, f32, i32) -> vector<2xf32>
    %3 = "llvm.shufflevector"(%2, %0) <{mask = array<i32: 0, 0>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %4 = "arith.mulf"(%arg0, %3) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %5 = "arith.maxnumf"(%4, %arg2) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %6 = "arith.select"(%arg3, %5, %arg2) : (vector<2xi1>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "func.return"(%6) : (vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[2]xf32>, f32, vector<[2]xf32>, vector<[2]xi1>) -> vector<[2]xf32>, sym_name = "masked_float_max_outerprod_scalable"}> ({
  ^bb0(%arg0: vector<[2]xf32>, %arg1: f32, %arg2: vector<[2]xf32>, %arg3: vector<[2]xi1>):
    %0 = "llvm.mlir.poison"() : () -> vector<[2]xf32>
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.insertelement"(%0, %arg1, %1) : (vector<[2]xf32>, f32, i32) -> vector<[2]xf32>
    %3 = "llvm.shufflevector"(%2, %0) <{mask = array<i32: 0, 0>}> : (vector<[2]xf32>, vector<[2]xf32>) -> vector<[2]xf32>
    %4 = "arith.mulf"(%arg0, %3) <{fastmath = #arith.fastmath<none>}> : (vector<[2]xf32>, vector<[2]xf32>) -> vector<[2]xf32>
    %5 = "arith.maxnumf"(%4, %arg2) <{fastmath = #arith.fastmath<none>}> : (vector<[2]xf32>, vector<[2]xf32>) -> vector<[2]xf32>
    %6 = "arith.select"(%arg3, %5, %arg2) : (vector<[2]xi1>, vector<[2]xf32>, vector<[2]xf32>) -> vector<[2]xf32>
    "func.return"(%6) : (vector<[2]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, f32, vector<2xf32>, vector<2xi1>) -> vector<2xf32>, sym_name = "masked_float_min_outerprod"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: f32, %arg2: vector<2xf32>, %arg3: vector<2xi1>):
    %0 = "llvm.mlir.poison"() : () -> vector<2xf32>
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.insertelement"(%0, %arg1, %1) : (vector<2xf32>, f32, i32) -> vector<2xf32>
    %3 = "llvm.shufflevector"(%2, %0) <{mask = array<i32: 0, 0>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %4 = "arith.mulf"(%arg0, %3) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %5 = "arith.minnumf"(%4, %arg2) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %6 = "arith.select"(%arg3, %5, %arg2) : (vector<2xi1>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "func.return"(%6) : (vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[2]xf32>, f32, vector<[2]xf32>, vector<[2]xi1>) -> vector<[2]xf32>, sym_name = "masked_float_min_outerprod_scalable"}> ({
  ^bb0(%arg0: vector<[2]xf32>, %arg1: f32, %arg2: vector<[2]xf32>, %arg3: vector<[2]xi1>):
    %0 = "llvm.mlir.poison"() : () -> vector<[2]xf32>
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.insertelement"(%0, %arg1, %1) : (vector<[2]xf32>, f32, i32) -> vector<[2]xf32>
    %3 = "llvm.shufflevector"(%2, %0) <{mask = array<i32: 0, 0>}> : (vector<[2]xf32>, vector<[2]xf32>) -> vector<[2]xf32>
    %4 = "arith.mulf"(%arg0, %3) <{fastmath = #arith.fastmath<none>}> : (vector<[2]xf32>, vector<[2]xf32>) -> vector<[2]xf32>
    %5 = "arith.minnumf"(%4, %arg2) <{fastmath = #arith.fastmath<none>}> : (vector<[2]xf32>, vector<[2]xf32>) -> vector<[2]xf32>
    %6 = "arith.select"(%arg3, %5, %arg2) : (vector<[2]xi1>, vector<[2]xf32>, vector<[2]xf32>) -> vector<[2]xf32>
    "func.return"(%6) : (vector<[2]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xi32>, i32, vector<2xi32>, vector<2xi1>) -> vector<2xi32>, sym_name = "masked_int_add_outerprod"}> ({
  ^bb0(%arg0: vector<2xi32>, %arg1: i32, %arg2: vector<2xi32>, %arg3: vector<2xi1>):
    %0 = "llvm.mlir.poison"() : () -> vector<2xi32>
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.insertelement"(%0, %arg1, %1) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %3 = "llvm.shufflevector"(%2, %0) <{mask = array<i32: 0, 0>}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %4 = "arith.muli"(%arg0, %3) <{overflowFlags = #arith.overflow<none>}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %5 = "arith.addi"(%4, %arg2) <{overflowFlags = #arith.overflow<none>}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %6 = "arith.select"(%arg3, %5, %arg2) : (vector<2xi1>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "func.return"(%6) : (vector<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[2]xi32>, i32, vector<[2]xi32>, vector<[2]xi1>) -> vector<[2]xi32>, sym_name = "masked_int_add_outerprod_scalable"}> ({
  ^bb0(%arg0: vector<[2]xi32>, %arg1: i32, %arg2: vector<[2]xi32>, %arg3: vector<[2]xi1>):
    %0 = "llvm.mlir.poison"() : () -> vector<[2]xi32>
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.insertelement"(%0, %arg1, %1) : (vector<[2]xi32>, i32, i32) -> vector<[2]xi32>
    %3 = "llvm.shufflevector"(%2, %0) <{mask = array<i32: 0, 0>}> : (vector<[2]xi32>, vector<[2]xi32>) -> vector<[2]xi32>
    %4 = "arith.muli"(%arg0, %3) <{overflowFlags = #arith.overflow<none>}> : (vector<[2]xi32>, vector<[2]xi32>) -> vector<[2]xi32>
    %5 = "arith.addi"(%4, %arg2) <{overflowFlags = #arith.overflow<none>}> : (vector<[2]xi32>, vector<[2]xi32>) -> vector<[2]xi32>
    %6 = "arith.select"(%arg3, %5, %arg2) : (vector<[2]xi1>, vector<[2]xi32>, vector<[2]xi32>) -> vector<[2]xi32>
    "func.return"(%6) : (vector<[2]xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xi32>, i32, vector<2xi32>, vector<2xi1>) -> vector<2xi32>, sym_name = "masked_int_mul_outerprod"}> ({
  ^bb0(%arg0: vector<2xi32>, %arg1: i32, %arg2: vector<2xi32>, %arg3: vector<2xi1>):
    %0 = "llvm.mlir.poison"() : () -> vector<2xi32>
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.insertelement"(%0, %arg1, %1) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %3 = "llvm.shufflevector"(%2, %0) <{mask = array<i32: 0, 0>}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %4 = "arith.muli"(%arg0, %3) <{overflowFlags = #arith.overflow<none>}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %5 = "arith.muli"(%4, %arg2) <{overflowFlags = #arith.overflow<none>}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %6 = "arith.select"(%arg3, %5, %arg2) : (vector<2xi1>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "func.return"(%6) : (vector<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[2]xi32>, i32, vector<[2]xi32>, vector<[2]xi1>) -> vector<[2]xi32>, sym_name = "masked_int_mul_outerprod_scalable"}> ({
  ^bb0(%arg0: vector<[2]xi32>, %arg1: i32, %arg2: vector<[2]xi32>, %arg3: vector<[2]xi1>):
    %0 = "llvm.mlir.poison"() : () -> vector<[2]xi32>
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.insertelement"(%0, %arg1, %1) : (vector<[2]xi32>, i32, i32) -> vector<[2]xi32>
    %3 = "llvm.shufflevector"(%2, %0) <{mask = array<i32: 0, 0>}> : (vector<[2]xi32>, vector<[2]xi32>) -> vector<[2]xi32>
    %4 = "arith.muli"(%arg0, %3) <{overflowFlags = #arith.overflow<none>}> : (vector<[2]xi32>, vector<[2]xi32>) -> vector<[2]xi32>
    %5 = "arith.muli"(%4, %arg2) <{overflowFlags = #arith.overflow<none>}> : (vector<[2]xi32>, vector<[2]xi32>) -> vector<[2]xi32>
    %6 = "arith.select"(%arg3, %5, %arg2) : (vector<[2]xi1>, vector<[2]xi32>, vector<[2]xi32>) -> vector<[2]xi32>
    "func.return"(%6) : (vector<[2]xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xi32>, i32, vector<2xi32>, vector<2xi1>) -> vector<2xi32>, sym_name = "masked_int_max_outerprod"}> ({
  ^bb0(%arg0: vector<2xi32>, %arg1: i32, %arg2: vector<2xi32>, %arg3: vector<2xi1>):
    %0 = "llvm.mlir.poison"() : () -> vector<2xi32>
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.insertelement"(%0, %arg1, %1) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %3 = "llvm.shufflevector"(%2, %0) <{mask = array<i32: 0, 0>}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %4 = "arith.muli"(%arg0, %3) <{overflowFlags = #arith.overflow<none>}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %5 = "arith.maxsi"(%4, %arg2) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %6 = "arith.select"(%arg3, %5, %arg2) : (vector<2xi1>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "func.return"(%6) : (vector<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[2]xi32>, i32, vector<[2]xi32>, vector<[2]xi1>) -> vector<[2]xi32>, sym_name = "masked_int_max_outerprod_scalable"}> ({
  ^bb0(%arg0: vector<[2]xi32>, %arg1: i32, %arg2: vector<[2]xi32>, %arg3: vector<[2]xi1>):
    %0 = "llvm.mlir.poison"() : () -> vector<[2]xi32>
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.insertelement"(%0, %arg1, %1) : (vector<[2]xi32>, i32, i32) -> vector<[2]xi32>
    %3 = "llvm.shufflevector"(%2, %0) <{mask = array<i32: 0, 0>}> : (vector<[2]xi32>, vector<[2]xi32>) -> vector<[2]xi32>
    %4 = "arith.muli"(%arg0, %3) <{overflowFlags = #arith.overflow<none>}> : (vector<[2]xi32>, vector<[2]xi32>) -> vector<[2]xi32>
    %5 = "arith.maxsi"(%4, %arg2) : (vector<[2]xi32>, vector<[2]xi32>) -> vector<[2]xi32>
    %6 = "arith.select"(%arg3, %5, %arg2) : (vector<[2]xi1>, vector<[2]xi32>, vector<[2]xi32>) -> vector<[2]xi32>
    "func.return"(%6) : (vector<[2]xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xi32>, i32, vector<2xi32>, vector<2xi1>) -> vector<2xi32>, sym_name = "masked_int_min_outerprod"}> ({
  ^bb0(%arg0: vector<2xi32>, %arg1: i32, %arg2: vector<2xi32>, %arg3: vector<2xi1>):
    %0 = "llvm.mlir.poison"() : () -> vector<2xi32>
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.insertelement"(%0, %arg1, %1) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %3 = "llvm.shufflevector"(%2, %0) <{mask = array<i32: 0, 0>}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %4 = "arith.muli"(%arg0, %3) <{overflowFlags = #arith.overflow<none>}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %5 = "arith.minui"(%4, %arg2) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %6 = "arith.select"(%arg3, %5, %arg2) : (vector<2xi1>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "func.return"(%6) : (vector<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[2]xi32>, i32, vector<[2]xi32>, vector<[2]xi1>) -> vector<[2]xi32>, sym_name = "masked_int_min_outerprod_scalable"}> ({
  ^bb0(%arg0: vector<[2]xi32>, %arg1: i32, %arg2: vector<[2]xi32>, %arg3: vector<[2]xi1>):
    %0 = "llvm.mlir.poison"() : () -> vector<[2]xi32>
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.insertelement"(%0, %arg1, %1) : (vector<[2]xi32>, i32, i32) -> vector<[2]xi32>
    %3 = "llvm.shufflevector"(%2, %0) <{mask = array<i32: 0, 0>}> : (vector<[2]xi32>, vector<[2]xi32>) -> vector<[2]xi32>
    %4 = "arith.muli"(%arg0, %3) <{overflowFlags = #arith.overflow<none>}> : (vector<[2]xi32>, vector<[2]xi32>) -> vector<[2]xi32>
    %5 = "arith.minui"(%4, %arg2) : (vector<[2]xi32>, vector<[2]xi32>) -> vector<[2]xi32>
    %6 = "arith.select"(%arg3, %5, %arg2) : (vector<[2]xi1>, vector<[2]xi32>, vector<[2]xi32>) -> vector<[2]xi32>
    "func.return"(%6) : (vector<[2]xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xi32>, i32, vector<2xi32>, vector<2xi1>) -> vector<2xi32>, sym_name = "masked_int_and_outerprod"}> ({
  ^bb0(%arg0: vector<2xi32>, %arg1: i32, %arg2: vector<2xi32>, %arg3: vector<2xi1>):
    %0 = "llvm.mlir.poison"() : () -> vector<2xi32>
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.insertelement"(%0, %arg1, %1) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %3 = "llvm.shufflevector"(%2, %0) <{mask = array<i32: 0, 0>}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %4 = "arith.muli"(%arg0, %3) <{overflowFlags = #arith.overflow<none>}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %5 = "arith.andi"(%4, %arg2) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %6 = "arith.select"(%arg3, %5, %arg2) : (vector<2xi1>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "func.return"(%6) : (vector<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[2]xi32>, i32, vector<[2]xi32>, vector<[2]xi1>) -> vector<[2]xi32>, sym_name = "masked_int_and_outerprod_scalable"}> ({
  ^bb0(%arg0: vector<[2]xi32>, %arg1: i32, %arg2: vector<[2]xi32>, %arg3: vector<[2]xi1>):
    %0 = "llvm.mlir.poison"() : () -> vector<[2]xi32>
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.insertelement"(%0, %arg1, %1) : (vector<[2]xi32>, i32, i32) -> vector<[2]xi32>
    %3 = "llvm.shufflevector"(%2, %0) <{mask = array<i32: 0, 0>}> : (vector<[2]xi32>, vector<[2]xi32>) -> vector<[2]xi32>
    %4 = "arith.muli"(%arg0, %3) <{overflowFlags = #arith.overflow<none>}> : (vector<[2]xi32>, vector<[2]xi32>) -> vector<[2]xi32>
    %5 = "arith.andi"(%4, %arg2) : (vector<[2]xi32>, vector<[2]xi32>) -> vector<[2]xi32>
    %6 = "arith.select"(%arg3, %5, %arg2) : (vector<[2]xi1>, vector<[2]xi32>, vector<[2]xi32>) -> vector<[2]xi32>
    "func.return"(%6) : (vector<[2]xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xi32>, i32, vector<2xi32>, vector<2xi1>) -> vector<2xi32>, sym_name = "masked_int_or_outerprod"}> ({
  ^bb0(%arg0: vector<2xi32>, %arg1: i32, %arg2: vector<2xi32>, %arg3: vector<2xi1>):
    %0 = "llvm.mlir.poison"() : () -> vector<2xi32>
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.insertelement"(%0, %arg1, %1) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %3 = "llvm.shufflevector"(%2, %0) <{mask = array<i32: 0, 0>}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %4 = "arith.muli"(%arg0, %3) <{overflowFlags = #arith.overflow<none>}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %5 = "arith.ori"(%4, %arg2) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %6 = "arith.select"(%arg3, %5, %arg2) : (vector<2xi1>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "func.return"(%6) : (vector<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[2]xi32>, i32, vector<[2]xi32>, vector<[2]xi1>) -> vector<[2]xi32>, sym_name = "masked_int_or_outerprod_scalable"}> ({
  ^bb0(%arg0: vector<[2]xi32>, %arg1: i32, %arg2: vector<[2]xi32>, %arg3: vector<[2]xi1>):
    %0 = "llvm.mlir.poison"() : () -> vector<[2]xi32>
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.insertelement"(%0, %arg1, %1) : (vector<[2]xi32>, i32, i32) -> vector<[2]xi32>
    %3 = "llvm.shufflevector"(%2, %0) <{mask = array<i32: 0, 0>}> : (vector<[2]xi32>, vector<[2]xi32>) -> vector<[2]xi32>
    %4 = "arith.muli"(%arg0, %3) <{overflowFlags = #arith.overflow<none>}> : (vector<[2]xi32>, vector<[2]xi32>) -> vector<[2]xi32>
    %5 = "arith.ori"(%4, %arg2) : (vector<[2]xi32>, vector<[2]xi32>) -> vector<[2]xi32>
    %6 = "arith.select"(%arg3, %5, %arg2) : (vector<[2]xi1>, vector<[2]xi32>, vector<[2]xi32>) -> vector<[2]xi32>
    "func.return"(%6) : (vector<[2]xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>) -> f32, sym_name = "extract_scalar_from_vec_1d_f32_poison_idx"}> ({
  ^bb0(%arg0: vector<16xf32>):
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x3x16xf32>) -> vector<3x16xf32>, sym_name = "extract_vec_2d_from_vec_3d_f32_poison_idx"}> ({
  ^bb0(%arg0: vector<4x3x16xf32>):
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> vector<3x16xf32>
    "func.return"(%0) : (vector<3x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "printNewline", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "printI64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "print_scalar_i1"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.extui"(%arg0) : (i1) -> i64
    "llvm.call"(%0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printI64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printNewline, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "printNewline", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "printI64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i4) -> (), sym_name = "print_scalar_i4"}> ({
  ^bb0(%arg0: i4):
    %0 = "arith.extsi"(%arg0) : (i4) -> i64
    "llvm.call"(%0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printI64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printNewline, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "printNewline", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "printI64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (si4) -> (), sym_name = "print_scalar_si4"}> ({
  ^bb0(%arg0: si4):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (si4) -> i4
    %1 = "arith.extsi"(%0) : (i4) -> i64
    "llvm.call"(%1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printI64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printNewline, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "printNewline", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "printU64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (ui4) -> (), sym_name = "print_scalar_ui4"}> ({
  ^bb0(%arg0: ui4):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (ui4) -> i4
    %1 = "arith.extui"(%0) : (i4) -> i64
    "llvm.call"(%1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printU64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printNewline, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "printNewline", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "printI64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "print_scalar_i32"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.extsi"(%arg0) : (i32) -> i64
    "llvm.call"(%0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printI64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printNewline, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "printNewline", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "printU64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (ui32) -> (), sym_name = "print_scalar_ui32"}> ({
  ^bb0(%arg0: ui32):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (ui32) -> i32
    %1 = "arith.extui"(%0) : (i32) -> i64
    "llvm.call"(%1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printU64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printNewline, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "printNewline", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "printI64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i40) -> (), sym_name = "print_scalar_i40"}> ({
  ^bb0(%arg0: i40):
    %0 = "arith.extsi"(%arg0) : (i40) -> i64
    "llvm.call"(%0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printI64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printNewline, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "printNewline", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "printI64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (si40) -> (), sym_name = "print_scalar_si40"}> ({
  ^bb0(%arg0: si40):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (si40) -> i40
    %1 = "arith.extsi"(%0) : (i40) -> i64
    "llvm.call"(%1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printI64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printNewline, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "printNewline", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "printU64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (ui40) -> (), sym_name = "print_scalar_ui40"}> ({
  ^bb0(%arg0: ui40):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (ui40) -> i40
    %1 = "arith.extui"(%0) : (i40) -> i64
    "llvm.call"(%1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printU64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printNewline, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> vector<2xf32>, sym_name = "extract_strided_slice_f32_1d_from_1d"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "llvm.shufflevector"(%arg0, %arg0) <{mask = array<i32: 2, 3>}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
    "func.return"(%0) : (vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xindex>) -> vector<2xindex>, sym_name = "extract_strided_slice_index_1d_from_1d"}> ({
  ^bb0(%arg0: vector<4xindex>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<4xindex>) -> vector<4xi64>
    %1 = "llvm.shufflevector"(%0, %0) <{mask = array<i32: 2, 3>}> : (vector<4xi64>, vector<4xi64>) -> vector<2xi64>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (vector<2xi64>) -> vector<2xindex>
    "func.return"(%2) : (vector<2xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x8xf32>) -> vector<2x8xf32>, sym_name = "extract_strided_slice_f32_1d_from_2d"}> ({
  ^bb0(%arg0: vector<4x8xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<4x8xf32>) -> !llvm.array<4 x vector<8xf32>>
    %1 = "llvm.mlir.poison"() : () -> !llvm.array<2 x vector<8xf32>>
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<8xf32>>) -> vector<8xf32>
    %3 = "llvm.insertvalue"(%1, %2) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<8xf32>>, vector<8xf32>) -> !llvm.array<2 x vector<8xf32>>
    %4 = "llvm.extractvalue"(%0) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<8xf32>>) -> vector<8xf32>
    %5 = "llvm.insertvalue"(%3, %4) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<8xf32>>, vector<8xf32>) -> !llvm.array<2 x vector<8xf32>>
    %6 = "builtin.unrealized_conversion_cast"(%5) : (!llvm.array<2 x vector<8xf32>>) -> vector<2x8xf32>
    "func.return"(%6) : (vector<2x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x[8]xf32>) -> vector<2x[8]xf32>, sym_name = "extract_strided_slice_f32_1d_from_2d_scalable"}> ({
  ^bb0(%arg0: vector<4x[8]xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<4x[8]xf32>) -> !llvm.array<4 x vector<[8]xf32>>
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2x[8]xf32>}> : () -> vector<2x[8]xf32>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (vector<2x[8]xf32>) -> !llvm.array<2 x vector<[8]xf32>>
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<[8]xf32>>) -> vector<[8]xf32>
    %4 = "llvm.extractvalue"(%0) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<[8]xf32>>) -> vector<[8]xf32>
    %5 = "llvm.insertvalue"(%2, %3) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<[8]xf32>>, vector<[8]xf32>) -> !llvm.array<2 x vector<[8]xf32>>
    %6 = "llvm.insertvalue"(%5, %4) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<[8]xf32>>, vector<[8]xf32>) -> !llvm.array<2 x vector<[8]xf32>>
    %7 = "builtin.unrealized_conversion_cast"(%6) : (!llvm.array<2 x vector<[8]xf32>>) -> vector<2x[8]xf32>
    "func.return"(%7) : (vector<2x[8]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x8xf32>) -> vector<2x2xf32>, sym_name = "extract_strided_slice_f32_2d_from_2d"}> ({
  ^bb0(%arg0: vector<4x8xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<4x8xf32>) -> !llvm.array<4 x vector<8xf32>>
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2x2xf32>}> : () -> vector<2x2xf32>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (vector<2x2xf32>) -> !llvm.array<2 x vector<2xf32>>
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<8xf32>>) -> vector<8xf32>
    %4 = "llvm.shufflevector"(%3, %3) <{mask = array<i32: 2, 3>}> : (vector<8xf32>, vector<8xf32>) -> vector<2xf32>
    %5 = "llvm.insertvalue"(%2, %4) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<2xf32>>, vector<2xf32>) -> !llvm.array<2 x vector<2xf32>>
    %6 = "llvm.extractvalue"(%0) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<8xf32>>) -> vector<8xf32>
    %7 = "llvm.shufflevector"(%6, %6) <{mask = array<i32: 2, 3>}> : (vector<8xf32>, vector<8xf32>) -> vector<2xf32>
    %8 = "llvm.insertvalue"(%5, %7) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<2xf32>>, vector<2xf32>) -> !llvm.array<2 x vector<2xf32>>
    %9 = "builtin.unrealized_conversion_cast"(%8) : (!llvm.array<2 x vector<2xf32>>) -> vector<2x2xf32>
    "func.return"(%9) : (vector<2x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x[8]xf32>) -> vector<2x[8]xf32>, sym_name = "extract_strided_slice_f32_2d_from_2d_scalable"}> ({
  ^bb0(%arg0: vector<4x[8]xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<4x[8]xf32>) -> !llvm.array<4 x vector<[8]xf32>>
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2x[8]xf32>}> : () -> vector<2x[8]xf32>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (vector<2x[8]xf32>) -> !llvm.array<2 x vector<[8]xf32>>
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<[8]xf32>>) -> vector<[8]xf32>
    %4 = "llvm.insertvalue"(%2, %3) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<[8]xf32>>, vector<[8]xf32>) -> !llvm.array<2 x vector<[8]xf32>>
    %5 = "llvm.extractvalue"(%0) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<[8]xf32>>) -> vector<[8]xf32>
    %6 = "llvm.insertvalue"(%4, %5) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<[8]xf32>>, vector<[8]xf32>) -> !llvm.array<2 x vector<[8]xf32>>
    %7 = "builtin.unrealized_conversion_cast"(%6) : (!llvm.array<2 x vector<[8]xf32>>) -> vector<2x[8]xf32>
    "func.return"(%7) : (vector<2x[8]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x4xf32>, vector<4x4x4xf32>) -> vector<4x4x4xf32>, sym_name = "insert_strided_slice_f32_2d_into_3d"}> ({
  ^bb0(%arg0: vector<4x4xf32>, %arg1: vector<4x4x4xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<4x4x4xf32>) -> !llvm.array<4 x array<4 x vector<4xf32>>>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<4x4xf32>) -> !llvm.array<4 x vector<4xf32>>
    %2 = "llvm.insertvalue"(%0, %1) <{position = array<i64: 2>}> : (!llvm.array<4 x array<4 x vector<4xf32>>>, !llvm.array<4 x vector<4xf32>>) -> !llvm.array<4 x array<4 x vector<4xf32>>>
    %3 = "builtin.unrealized_conversion_cast"(%2) : (!llvm.array<4 x array<4 x vector<4xf32>>>) -> vector<4x4x4xf32>
    "func.return"(%3) : (vector<4x4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x[4]xf32>, vector<4x4x[4]xf32>) -> vector<4x4x[4]xf32>, sym_name = "insert_strided_slice_f32_2d_into_3d_scalable"}> ({
  ^bb0(%arg0: vector<4x[4]xf32>, %arg1: vector<4x4x[4]xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<4x4x[4]xf32>) -> !llvm.array<4 x array<4 x vector<[4]xf32>>>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<4x[4]xf32>) -> !llvm.array<4 x vector<[4]xf32>>
    %2 = "llvm.insertvalue"(%0, %1) <{position = array<i64: 2>}> : (!llvm.array<4 x array<4 x vector<[4]xf32>>>, !llvm.array<4 x vector<[4]xf32>>) -> !llvm.array<4 x array<4 x vector<[4]xf32>>>
    %3 = "builtin.unrealized_conversion_cast"(%2) : (!llvm.array<4 x array<4 x vector<[4]xf32>>>) -> vector<4x4x[4]xf32>
    "func.return"(%3) : (vector<4x4x[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x4xindex>, vector<4x4x4xindex>) -> vector<4x4x4xindex>, sym_name = "insert_strided_index_slice_index_2d_into_3d"}> ({
  ^bb0(%arg0: vector<4x4xindex>, %arg1: vector<4x4x4xindex>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<4x4x4xindex>) -> !llvm.array<4 x array<4 x vector<4xi64>>>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<4x4xindex>) -> !llvm.array<4 x vector<4xi64>>
    %2 = "llvm.insertvalue"(%0, %1) <{position = array<i64: 2>}> : (!llvm.array<4 x array<4 x vector<4xi64>>>, !llvm.array<4 x vector<4xi64>>) -> !llvm.array<4 x array<4 x vector<4xi64>>>
    %3 = "builtin.unrealized_conversion_cast"(%2) : (!llvm.array<4 x array<4 x vector<4xi64>>>) -> vector<4x4x4xindex>
    "func.return"(%3) : (vector<4x4x4xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x[4]xindex>, vector<4x4x[4]xindex>) -> vector<4x4x[4]xindex>, sym_name = "insert_strided_index_slice_index_2d_into_3d_scalable"}> ({
  ^bb0(%arg0: vector<4x[4]xindex>, %arg1: vector<4x4x[4]xindex>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<4x4x[4]xindex>) -> !llvm.array<4 x array<4 x vector<[4]xi64>>>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<4x[4]xindex>) -> !llvm.array<4 x vector<[4]xi64>>
    %2 = "llvm.insertvalue"(%0, %1) <{position = array<i64: 2>}> : (!llvm.array<4 x array<4 x vector<[4]xi64>>>, !llvm.array<4 x vector<[4]xi64>>) -> !llvm.array<4 x array<4 x vector<[4]xi64>>>
    %3 = "builtin.unrealized_conversion_cast"(%2) : (!llvm.array<4 x array<4 x vector<[4]xi64>>>) -> vector<4x4x[4]xindex>
    "func.return"(%3) : (vector<4x4x[4]xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xf32>, vector<4x4xf32>) -> vector<4x4xf32>, sym_name = "insert_strided_slice_f32_2d_into_2d"}> ({
  ^bb0(%arg0: vector<2x2xf32>, %arg1: vector<4x4xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<4x4xf32>) -> !llvm.array<4 x vector<4xf32>>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<2x2xf32>) -> !llvm.array<2 x vector<2xf32>>
    %2 = "llvm.extractvalue"(%1) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<2xf32>>) -> vector<2xf32>
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<4xf32>>) -> vector<4xf32>
    %4 = "llvm.shufflevector"(%2, %2) <{mask = array<i32: 0, 1, 0, 0>}> : (vector<2xf32>, vector<2xf32>) -> vector<4xf32>
    %5 = "llvm.shufflevector"(%4, %3) <{mask = array<i32: 4, 5, 0, 1>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %6 = "llvm.insertvalue"(%0, %5) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<4xf32>>, vector<4xf32>) -> !llvm.array<4 x vector<4xf32>>
    %7 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<2xf32>>) -> vector<2xf32>
    %8 = "llvm.extractvalue"(%0) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<4xf32>>) -> vector<4xf32>
    %9 = "llvm.shufflevector"(%7, %7) <{mask = array<i32: 0, 1, 0, 0>}> : (vector<2xf32>, vector<2xf32>) -> vector<4xf32>
    %10 = "llvm.shufflevector"(%9, %8) <{mask = array<i32: 4, 5, 0, 1>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %11 = "llvm.insertvalue"(%6, %10) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<4xf32>>, vector<4xf32>) -> !llvm.array<4 x vector<4xf32>>
    %12 = "builtin.unrealized_conversion_cast"(%11) : (!llvm.array<4 x vector<4xf32>>) -> vector<4x4xf32>
    "func.return"(%12) : (vector<4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x[2]xf32>, vector<4x[2]xf32>) -> vector<4x[2]xf32>, sym_name = "insert_strided_slice_f32_2d_into_2d_scalable"}> ({
  ^bb0(%arg0: vector<2x[2]xf32>, %arg1: vector<4x[2]xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<4x[2]xf32>) -> !llvm.array<4 x vector<[2]xf32>>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<2x[2]xf32>) -> !llvm.array<2 x vector<[2]xf32>>
    %2 = "llvm.extractvalue"(%1) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<[2]xf32>>) -> vector<[2]xf32>
    %3 = "llvm.insertvalue"(%0, %2) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<[2]xf32>>, vector<[2]xf32>) -> !llvm.array<4 x vector<[2]xf32>>
    %4 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<[2]xf32>>) -> vector<[2]xf32>
    %5 = "llvm.insertvalue"(%3, %4) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<[2]xf32>>, vector<[2]xf32>) -> !llvm.array<4 x vector<[2]xf32>>
    %6 = "builtin.unrealized_conversion_cast"(%5) : (!llvm.array<4 x vector<[2]xf32>>) -> vector<4x[2]xf32>
    "func.return"(%6) : (vector<4x[2]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x4xf32>, vector<16x4x8xf32>) -> vector<16x4x8xf32>, sym_name = "insert_strided_slice_f32_2d_into_3d"}> ({
  ^bb0(%arg0: vector<2x4xf32>, %arg1: vector<16x4x8xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<2x4xf32>) -> !llvm.array<2 x vector<4xf32>>
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<16x4x8xf32>) -> !llvm.array<16 x array<4 x vector<8xf32>>>
    %2 = "llvm.extractvalue"(%1) <{position = array<i64: 0>}> : (!llvm.array<16 x array<4 x vector<8xf32>>>) -> !llvm.array<4 x vector<8xf32>>
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<4xf32>>) -> vector<4xf32>
    %4 = "llvm.extractvalue"(%1) <{position = array<i64: 0, 0>}> : (!llvm.array<16 x array<4 x vector<8xf32>>>) -> vector<8xf32>
    %5 = "llvm.shufflevector"(%3, %3) <{mask = array<i32: 0, 1, 2, 3, 0, 0, 0, 0>}> : (vector<4xf32>, vector<4xf32>) -> vector<8xf32>
    %6 = "llvm.shufflevector"(%5, %4) <{mask = array<i32: 8, 9, 0, 1, 2, 3, 14, 15>}> : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %7 = "llvm.insertvalue"(%2, %6) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<8xf32>>, vector<8xf32>) -> !llvm.array<4 x vector<8xf32>>
    %8 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<4xf32>>) -> vector<4xf32>
    %9 = "llvm.extractvalue"(%1) <{position = array<i64: 0, 1>}> : (!llvm.array<16 x array<4 x vector<8xf32>>>) -> vector<8xf32>
    %10 = "llvm.shufflevector"(%8, %8) <{mask = array<i32: 0, 1, 2, 3, 0, 0, 0, 0>}> : (vector<4xf32>, vector<4xf32>) -> vector<8xf32>
    %11 = "llvm.shufflevector"(%10, %9) <{mask = array<i32: 8, 9, 0, 1, 2, 3, 14, 15>}> : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %12 = "llvm.insertvalue"(%7, %11) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<8xf32>>, vector<8xf32>) -> !llvm.array<4 x vector<8xf32>>
    %13 = "llvm.insertvalue"(%1, %12) <{position = array<i64: 0>}> : (!llvm.array<16 x array<4 x vector<8xf32>>>, !llvm.array<4 x vector<8xf32>>) -> !llvm.array<16 x array<4 x vector<8xf32>>>
    %14 = "builtin.unrealized_conversion_cast"(%13) : (!llvm.array<16 x array<4 x vector<8xf32>>>) -> vector<16x4x8xf32>
    "func.return"(%14) : (vector<16x4x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x[4]xf32>, vector<16x4x[4]xf32>) -> vector<16x4x[4]xf32>, sym_name = "insert_strided_slice_f32_2d_into_3d_scalable"}> ({
  ^bb0(%arg0: vector<2x[4]xf32>, %arg1: vector<16x4x[4]xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<2x[4]xf32>) -> !llvm.array<2 x vector<[4]xf32>>
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<16x4x[4]xf32>) -> !llvm.array<16 x array<4 x vector<[4]xf32>>>
    %2 = "llvm.extractvalue"(%1) <{position = array<i64: 3>}> : (!llvm.array<16 x array<4 x vector<[4]xf32>>>) -> !llvm.array<4 x vector<[4]xf32>>
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<[4]xf32>>) -> vector<[4]xf32>
    %4 = "llvm.insertvalue"(%2, %3) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<[4]xf32>>, vector<[4]xf32>) -> !llvm.array<4 x vector<[4]xf32>>
    %5 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<[4]xf32>>) -> vector<[4]xf32>
    %6 = "llvm.insertvalue"(%4, %5) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<[4]xf32>>, vector<[4]xf32>) -> !llvm.array<4 x vector<[4]xf32>>
    %7 = "llvm.insertvalue"(%1, %6) <{position = array<i64: 3>}> : (!llvm.array<16 x array<4 x vector<[4]xf32>>>, !llvm.array<4 x vector<[4]xf32>>) -> !llvm.array<16 x array<4 x vector<[4]xf32>>>
    %8 = "builtin.unrealized_conversion_cast"(%7) : (!llvm.array<16 x array<4 x vector<[4]xf32>>>) -> vector<16x4x[4]xf32>
    "func.return"(%8) : (vector<16x4x[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8xf32>, vector<2x4xf32>, vector<1x1x1xf32>, vector<f32>) -> (vector<8xf32>, vector<2x4xf32>, vector<1x1x1xf32>, vector<f32>), sym_name = "fma"}> ({
  ^bb0(%arg0: vector<8xf32>, %arg1: vector<2x4xf32>, %arg2: vector<1x1x1xf32>, %arg3: vector<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg3) : (vector<f32>) -> vector<1xf32>
    %1 = "builtin.unrealized_conversion_cast"(%arg2) : (vector<1x1x1xf32>) -> !llvm.array<1 x array<1 x vector<1xf32>>>
    %2 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<2x4xf32>) -> !llvm.array<2 x vector<4xf32>>
    %3 = "arith.constant"() <{value = dense<0.000000e+00> : vector<1x1xf32>}> : () -> vector<1x1xf32>
    %4 = "builtin.unrealized_conversion_cast"(%3) : (vector<1x1xf32>) -> !llvm.array<1 x vector<1xf32>>
    %5 = "arith.constant"() <{value = dense<0.000000e+00> : vector<1x1x1xf32>}> : () -> vector<1x1x1xf32>
    %6 = "builtin.unrealized_conversion_cast"(%5) : (vector<1x1x1xf32>) -> !llvm.array<1 x array<1 x vector<1xf32>>>
    %7 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2x4xf32>}> : () -> vector<2x4xf32>
    %8 = "builtin.unrealized_conversion_cast"(%7) : (vector<2x4xf32>) -> !llvm.array<2 x vector<4xf32>>
    %9 = "llvm.intr.fmuladd"(%arg0, %arg0, %arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %10 = "llvm.extractvalue"(%2) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<4xf32>>) -> vector<4xf32>
    %11 = "llvm.extractvalue"(%2) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<4xf32>>) -> vector<4xf32>
    %12 = "llvm.extractvalue"(%2) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<4xf32>>) -> vector<4xf32>
    %13 = "llvm.intr.fmuladd"(%10, %11, %12) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %14 = "llvm.insertvalue"(%8, %13) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<4xf32>>, vector<4xf32>) -> !llvm.array<2 x vector<4xf32>>
    %15 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<4xf32>>) -> vector<4xf32>
    %16 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<4xf32>>) -> vector<4xf32>
    %17 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<4xf32>>) -> vector<4xf32>
    %18 = "llvm.intr.fmuladd"(%15, %16, %17) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %19 = "llvm.insertvalue"(%14, %18) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<4xf32>>, vector<4xf32>) -> !llvm.array<2 x vector<4xf32>>
    %20 = "builtin.unrealized_conversion_cast"(%19) : (!llvm.array<2 x vector<4xf32>>) -> vector<2x4xf32>
    %21 = "llvm.extractvalue"(%1) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<1 x vector<1xf32>>>) -> vector<1xf32>
    %22 = "llvm.extractvalue"(%1) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<1 x vector<1xf32>>>) -> vector<1xf32>
    %23 = "llvm.extractvalue"(%1) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<1 x vector<1xf32>>>) -> vector<1xf32>
    %24 = "llvm.intr.fmuladd"(%21, %22, %23) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<1xf32>, vector<1xf32>, vector<1xf32>) -> vector<1xf32>
    %25 = "llvm.insertvalue"(%4, %24) <{position = array<i64: 0>}> : (!llvm.array<1 x vector<1xf32>>, vector<1xf32>) -> !llvm.array<1 x vector<1xf32>>
    %26 = "llvm.insertvalue"(%6, %25) <{position = array<i64: 0>}> : (!llvm.array<1 x array<1 x vector<1xf32>>>, !llvm.array<1 x vector<1xf32>>) -> !llvm.array<1 x array<1 x vector<1xf32>>>
    %27 = "builtin.unrealized_conversion_cast"(%26) : (!llvm.array<1 x array<1 x vector<1xf32>>>) -> vector<1x1x1xf32>
    %28 = "llvm.intr.fmuladd"(%0, %0, %0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<1xf32>, vector<1xf32>, vector<1xf32>) -> vector<1xf32>
    %29 = "builtin.unrealized_conversion_cast"(%28) : (vector<1xf32>) -> vector<f32>
    "func.return"(%9, %20, %27, %29) : (vector<8xf32>, vector<2x4xf32>, vector<1x1x1xf32>, vector<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[8]xf32>, vector<2x[4]xf32>, vector<1x1x[1]xf32>, vector<f32>) -> (vector<[8]xf32>, vector<2x[4]xf32>, vector<1x1x[1]xf32>), sym_name = "fma_scalable"}> ({
  ^bb0(%arg0: vector<[8]xf32>, %arg1: vector<2x[4]xf32>, %arg2: vector<1x1x[1]xf32>, %arg3: vector<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (vector<1x1x[1]xf32>) -> !llvm.array<1 x array<1 x vector<[1]xf32>>>
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<2x[4]xf32>) -> !llvm.array<2 x vector<[4]xf32>>
    %2 = "arith.constant"() <{value = dense<0.000000e+00> : vector<1x[1]xf32>}> : () -> vector<1x[1]xf32>
    %3 = "builtin.unrealized_conversion_cast"(%2) : (vector<1x[1]xf32>) -> !llvm.array<1 x vector<[1]xf32>>
    %4 = "arith.constant"() <{value = dense<0.000000e+00> : vector<1x1x[1]xf32>}> : () -> vector<1x1x[1]xf32>
    %5 = "builtin.unrealized_conversion_cast"(%4) : (vector<1x1x[1]xf32>) -> !llvm.array<1 x array<1 x vector<[1]xf32>>>
    %6 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2x[4]xf32>}> : () -> vector<2x[4]xf32>
    %7 = "builtin.unrealized_conversion_cast"(%6) : (vector<2x[4]xf32>) -> !llvm.array<2 x vector<[4]xf32>>
    %8 = "llvm.intr.fmuladd"(%arg0, %arg0, %arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<[8]xf32>, vector<[8]xf32>, vector<[8]xf32>) -> vector<[8]xf32>
    %9 = "llvm.extractvalue"(%1) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<[4]xf32>>) -> vector<[4]xf32>
    %10 = "llvm.extractvalue"(%1) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<[4]xf32>>) -> vector<[4]xf32>
    %11 = "llvm.extractvalue"(%1) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<[4]xf32>>) -> vector<[4]xf32>
    %12 = "llvm.intr.fmuladd"(%9, %10, %11) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<[4]xf32>, vector<[4]xf32>, vector<[4]xf32>) -> vector<[4]xf32>
    %13 = "llvm.insertvalue"(%7, %12) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<[4]xf32>>, vector<[4]xf32>) -> !llvm.array<2 x vector<[4]xf32>>
    %14 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<[4]xf32>>) -> vector<[4]xf32>
    %15 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<[4]xf32>>) -> vector<[4]xf32>
    %16 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<[4]xf32>>) -> vector<[4]xf32>
    %17 = "llvm.intr.fmuladd"(%14, %15, %16) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<[4]xf32>, vector<[4]xf32>, vector<[4]xf32>) -> vector<[4]xf32>
    %18 = "llvm.insertvalue"(%13, %17) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<[4]xf32>>, vector<[4]xf32>) -> !llvm.array<2 x vector<[4]xf32>>
    %19 = "builtin.unrealized_conversion_cast"(%18) : (!llvm.array<2 x vector<[4]xf32>>) -> vector<2x[4]xf32>
    %20 = "llvm.extractvalue"(%0) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<1 x vector<[1]xf32>>>) -> vector<[1]xf32>
    %21 = "llvm.extractvalue"(%0) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<1 x vector<[1]xf32>>>) -> vector<[1]xf32>
    %22 = "llvm.extractvalue"(%0) <{position = array<i64: 0, 0>}> : (!llvm.array<1 x array<1 x vector<[1]xf32>>>) -> vector<[1]xf32>
    %23 = "llvm.intr.fmuladd"(%20, %21, %22) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<[1]xf32>, vector<[1]xf32>, vector<[1]xf32>) -> vector<[1]xf32>
    %24 = "llvm.insertvalue"(%3, %23) <{position = array<i64: 0>}> : (!llvm.array<1 x vector<[1]xf32>>, vector<[1]xf32>) -> !llvm.array<1 x vector<[1]xf32>>
    %25 = "llvm.insertvalue"(%5, %24) <{position = array<i64: 0>}> : (!llvm.array<1 x array<1 x vector<[1]xf32>>>, !llvm.array<1 x vector<[1]xf32>>) -> !llvm.array<1 x array<1 x vector<[1]xf32>>>
    %26 = "builtin.unrealized_conversion_cast"(%25) : (!llvm.array<1 x array<1 x vector<[1]xf32>>>) -> vector<1x1x[1]xf32>
    "func.return"(%8, %19, %26) : (vector<[8]xf32>, vector<2x[4]xf32>, vector<1x1x[1]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<i1>, sym_name = "constant_mask_0d_f"}> ({
    %0 = "arith.constant"() <{value = dense<false> : vector<i1>}> : () -> vector<i1>
    "func.return"(%0) : (vector<i1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<i1>, sym_name = "constant_mask_0d_t"}> ({
    %0 = "arith.constant"() <{value = dense<true> : vector<i1>}> : () -> vector<i1>
    "func.return"(%0) : (vector<i1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<8xi1>, sym_name = "constant_mask_1d"}> ({
    %0 = "arith.constant"() <{value = dense<[true, true, true, true, false, false, false, false]> : vector<8xi1>}> : () -> vector<8xi1>
    "func.return"(%0) : (vector<8xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<[8]xi1>, sym_name = "constant_mask_1d_scalable_all_false"}> ({
    %0 = "arith.constant"() <{value = dense<false> : vector<[8]xi1>}> : () -> vector<[8]xi1>
    "func.return"(%0) : (vector<[8]xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<[8]xi1>, sym_name = "constant_mask_1d_scalable_all_true"}> ({
    %0 = "arith.constant"() <{value = dense<true> : vector<[8]xi1>}> : () -> vector<[8]xi1>
    "func.return"(%0) : (vector<[8]xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<4x4xi1>, sym_name = "constant_mask_2d"}> ({
    %0 = "arith.constant"() <{value = dense<[[true, true, false, false], [true, true, false, false], [false, false, false, false], [false, false, false, false]]> : vector<4x4xi1>}> : () -> vector<4x4xi1>
    "func.return"(%0) : (vector<4x4xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<4x[4]xi1>, sym_name = "constant_mask_2d_trailing_scalable"}> ({
    %0 = "arith.constant"() <{value = dense<true> : vector<[4]xi1>}> : () -> vector<[4]xi1>
    %1 = "arith.constant"() <{value = dense<false> : vector<4x[4]xi1>}> : () -> vector<4x[4]xi1>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (vector<4x[4]xi1>) -> !llvm.array<4 x vector<[4]xi1>>
    %3 = "llvm.insertvalue"(%2, %0) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<[4]xi1>>, vector<[4]xi1>) -> !llvm.array<4 x vector<[4]xi1>>
    %4 = "llvm.insertvalue"(%3, %0) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<[4]xi1>>, vector<[4]xi1>) -> !llvm.array<4 x vector<[4]xi1>>
    %5 = "builtin.unrealized_conversion_cast"(%4) : (!llvm.array<4 x vector<[4]xi1>>) -> vector<4x[4]xi1>
    "func.return"(%5) : (vector<4x[4]xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<[4]x4xi1>, sym_name = "negative_constant_mask_2d_leading_scalable"}> ({
    %0 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 4, 2>}> : () -> vector<[4]x4xi1>
    "func.return"(%0) : (vector<[4]x4xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> vector<i1>, sym_name = "create_mask_0d"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = dense<0> : vector<i32>}> : () -> vector<i32>
    %1 = "arith.index_cast"(%arg0) : (index) -> i32
    %2 = "llvm.mlir.poison"() : () -> vector<1xi32>
    %3 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "llvm.insertelement"(%2, %1, %3) : (vector<1xi32>, i32, i32) -> vector<1xi32>
    %5 = "builtin.unrealized_conversion_cast"(%4) : (vector<1xi32>) -> vector<i32>
    %6 = "arith.cmpi"(%5, %0) <{predicate = 4 : i64}> : (vector<i32>, vector<i32>) -> vector<i1>
    "func.return"(%6) : (vector<i1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> vector<4xi1>, sym_name = "create_mask_1d"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = dense<[0, 1, 2, 3]> : vector<4xi32>}> : () -> vector<4xi32>
    %1 = "arith.index_cast"(%arg0) : (index) -> i32
    %2 = "llvm.mlir.poison"() : () -> vector<4xi32>
    %3 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "llvm.insertelement"(%2, %1, %3) : (vector<4xi32>, i32, i32) -> vector<4xi32>
    %5 = "llvm.shufflevector"(%4, %2) <{mask = array<i32: 0, 0, 0, 0>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %6 = "arith.cmpi"(%5, %0) <{predicate = 4 : i64}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
    "func.return"(%6) : (vector<4xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> vector<[4]xi1>, sym_name = "create_mask_1d_scalable"}> ({
  ^bb0(%arg0: index):
    %0 = "llvm.intr.stepvector"() : () -> vector<[4]xi32>
    %1 = "arith.index_cast"(%arg0) : (index) -> i32
    %2 = "llvm.mlir.poison"() : () -> vector<[4]xi32>
    %3 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "llvm.insertelement"(%2, %1, %3) : (vector<[4]xi32>, i32, i32) -> vector<[4]xi32>
    %5 = "llvm.shufflevector"(%4, %2) <{mask = array<i32: 0, 0, 0, 0>}> : (vector<[4]xi32>, vector<[4]xi32>) -> vector<[4]xi32>
    %6 = "arith.cmpi"(%0, %5) <{predicate = 2 : i64}> : (vector<[4]xi32>, vector<[4]xi32>) -> vector<[4]xi1>
    "func.return"(%6) : (vector<[4]xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<2x3xi32>, vector<2x3xf32>) -> vector<2x3xf32>, sym_name = "gather_with_mask"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<2x3xi32>, %arg2: vector<2x3xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "builtin.unrealized_conversion_cast"(%arg2) : (vector<2x3xf32>) -> !llvm.array<2 x vector<3xf32>>
    %2 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<2x3xi32>) -> !llvm.array<2 x vector<3xi32>>
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "builtin.unrealized_conversion_cast"(%3) : (index) -> i64
    %5 = "arith.constant"() <{value = dense<[true, true, false]> : vector<3xi1>}> : () -> vector<3xi1>
    %6 = "ub.poison"() <{value = #ub.poison}> : () -> vector<2x3xf32>
    %7 = "builtin.unrealized_conversion_cast"(%6) : (vector<2x3xf32>) -> !llvm.array<2 x vector<3xf32>>
    %8 = "llvm.extractvalue"(%2) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<3xi32>>) -> vector<3xi32>
    %9 = "llvm.extractvalue"(%1) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<3xf32>>) -> vector<3xf32>
    %10 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %11 = "llvm.getelementptr"(%10, %4) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %12 = "llvm.getelementptr"(%11, %8) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, vector<3xi32>) -> vector<3x!llvm.ptr>
    %13 = "llvm.intr.masked.gather"(%12, %5, %9) <{alignment = 4 : i32}> : (vector<3x!llvm.ptr>, vector<3xi1>, vector<3xf32>) -> vector<3xf32>
    %14 = "llvm.insertvalue"(%7, %13) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<3xf32>>, vector<3xf32>) -> !llvm.array<2 x vector<3xf32>>
    %15 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<3xi32>>) -> vector<3xi32>
    %16 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<3xf32>>) -> vector<3xf32>
    %17 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %18 = "llvm.getelementptr"(%17, %4) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %19 = "llvm.getelementptr"(%18, %15) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, vector<3xi32>) -> vector<3x!llvm.ptr>
    %20 = "llvm.intr.masked.gather"(%19, %5, %16) <{alignment = 4 : i32}> : (vector<3x!llvm.ptr>, vector<3xi1>, vector<3xf32>) -> vector<3xf32>
    %21 = "llvm.insertvalue"(%14, %20) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<3xf32>>, vector<3xf32>) -> !llvm.array<2 x vector<3xf32>>
    %22 = "builtin.unrealized_conversion_cast"(%21) : (!llvm.array<2 x vector<3xf32>>) -> vector<2x3xf32>
    "func.return"(%22) : (vector<2x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<2x[3]xi32>, vector<2x[3]xf32>) -> vector<2x[3]xf32>, sym_name = "gather_with_mask_scalable"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<2x[3]xi32>, %arg2: vector<2x[3]xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "builtin.unrealized_conversion_cast"(%arg2) : (vector<2x[3]xf32>) -> !llvm.array<2 x vector<[3]xf32>>
    %2 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<2x[3]xi32>) -> !llvm.array<2 x vector<[3]xi32>>
    %3 = "arith.constant"() <{value = dense<true> : vector<[3]xi1>}> : () -> vector<[3]xi1>
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "builtin.unrealized_conversion_cast"(%4) : (index) -> i64
    %6 = "ub.poison"() <{value = #ub.poison}> : () -> vector<2x[3]xf32>
    %7 = "builtin.unrealized_conversion_cast"(%6) : (vector<2x[3]xf32>) -> !llvm.array<2 x vector<[3]xf32>>
    %8 = "llvm.extractvalue"(%2) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<[3]xi32>>) -> vector<[3]xi32>
    %9 = "llvm.extractvalue"(%1) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<[3]xf32>>) -> vector<[3]xf32>
    %10 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %11 = "llvm.getelementptr"(%10, %5) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %12 = "llvm.getelementptr"(%11, %8) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, vector<[3]xi32>) -> vector<[3]x!llvm.ptr>
    %13 = "llvm.intr.masked.gather"(%12, %3, %9) <{alignment = 4 : i32}> : (vector<[3]x!llvm.ptr>, vector<[3]xi1>, vector<[3]xf32>) -> vector<[3]xf32>
    %14 = "llvm.insertvalue"(%7, %13) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<[3]xf32>>, vector<[3]xf32>) -> !llvm.array<2 x vector<[3]xf32>>
    %15 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<[3]xi32>>) -> vector<[3]xi32>
    %16 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<[3]xf32>>) -> vector<[3]xf32>
    %17 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %18 = "llvm.getelementptr"(%17, %5) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %19 = "llvm.getelementptr"(%18, %15) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, vector<[3]xi32>) -> vector<[3]x!llvm.ptr>
    %20 = "llvm.intr.masked.gather"(%19, %3, %16) <{alignment = 4 : i32}> : (vector<[3]x!llvm.ptr>, vector<[3]xi1>, vector<[3]xf32>) -> vector<[3]xf32>
    %21 = "llvm.insertvalue"(%14, %20) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<[3]xf32>>, vector<[3]xf32>) -> !llvm.array<2 x vector<[3]xf32>>
    %22 = "builtin.unrealized_conversion_cast"(%21) : (!llvm.array<2 x vector<[3]xf32>>) -> vector<2x[3]xf32>
    "func.return"(%22) : (vector<2x[3]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<2x3xi32>, vector<2x3xf32>) -> vector<2x3xf32>, sym_name = "gather_with_zero_mask"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<2x3xi32>, %arg2: vector<2x3xf32>):
    "func.return"(%arg2) : (vector<2x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<2x[3]xi32>, vector<2x[3]xf32>) -> vector<2x[3]xf32>, sym_name = "gather_with_zero_mask_scalable"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<2x[3]xi32>, %arg2: vector<2x[3]xf32>):
    "func.return"(%arg2) : (vector<2x[3]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<2x3xi32>, vector<2x3xf32>) -> (), sym_name = "scatter_with_mask"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<2x3xi32>, %arg2: vector<2x3xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = dense<[[true, true, false], [true, true, false]]> : vector<2x3xi1>}> : () -> vector<2x3xi1>
    "vector.scatter"(%arg0, %0, %arg1, %1, %arg2) : (memref<?xf32>, index, vector<2x3xi32>, vector<2x3xi1>, vector<2x3xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<2x[3]xi32>, vector<2x[3]xf32>) -> (), sym_name = "scatter_with_mask_scalable"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<2x[3]xi32>, %arg2: vector<2x[3]xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = dense<true> : vector<2x[3]xi1>}> : () -> vector<2x[3]xi1>
    "vector.scatter"(%arg0, %0, %arg1, %1, %arg2) : (memref<?xf32>, index, vector<2x[3]xi32>, vector<2x[3]xi1>, vector<2x[3]xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x3xi8>, vector<2x3xi8>) -> vector<2x6xi8>, sym_name = "interleave_2d"}> ({
  ^bb0(%arg0: vector<2x3xi8>, %arg1: vector<2x3xi8>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<2x3xi8>) -> !llvm.array<2 x vector<3xi8>>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<2x3xi8>) -> !llvm.array<2 x vector<3xi8>>
    %2 = "arith.constant"() <{value = dense<0> : vector<2x6xi8>}> : () -> vector<2x6xi8>
    %3 = "builtin.unrealized_conversion_cast"(%2) : (vector<2x6xi8>) -> !llvm.array<2 x vector<6xi8>>
    %4 = "llvm.extractvalue"(%1) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<3xi8>>) -> vector<3xi8>
    %5 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<3xi8>>) -> vector<3xi8>
    %6 = "llvm.shufflevector"(%4, %5) <{mask = array<i32: 0, 3, 1, 4, 2, 5>}> : (vector<3xi8>, vector<3xi8>) -> vector<6xi8>
    %7 = "llvm.insertvalue"(%3, %6) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<6xi8>>, vector<6xi8>) -> !llvm.array<2 x vector<6xi8>>
    %8 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<3xi8>>) -> vector<3xi8>
    %9 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<3xi8>>) -> vector<3xi8>
    %10 = "llvm.shufflevector"(%8, %9) <{mask = array<i32: 0, 3, 1, 4, 2, 5>}> : (vector<3xi8>, vector<3xi8>) -> vector<6xi8>
    %11 = "llvm.insertvalue"(%7, %10) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<6xi8>>, vector<6xi8>) -> !llvm.array<2 x vector<6xi8>>
    %12 = "builtin.unrealized_conversion_cast"(%11) : (!llvm.array<2 x vector<6xi8>>) -> vector<2x6xi8>
    "func.return"(%12) : (vector<2x6xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x[8]xi16>, vector<2x[8]xi16>) -> vector<2x[16]xi16>, sym_name = "interleave_2d_scalable"}> ({
  ^bb0(%arg0: vector<2x[8]xi16>, %arg1: vector<2x[8]xi16>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<2x[8]xi16>) -> !llvm.array<2 x vector<[8]xi16>>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<2x[8]xi16>) -> !llvm.array<2 x vector<[8]xi16>>
    %2 = "arith.constant"() <{value = dense<0> : vector<2x[16]xi16>}> : () -> vector<2x[16]xi16>
    %3 = "builtin.unrealized_conversion_cast"(%2) : (vector<2x[16]xi16>) -> !llvm.array<2 x vector<[16]xi16>>
    %4 = "llvm.extractvalue"(%1) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<[8]xi16>>) -> vector<[8]xi16>
    %5 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<[8]xi16>>) -> vector<[8]xi16>
    %6 = "llvm.intr.vector.interleave2"(%4, %5) : (vector<[8]xi16>, vector<[8]xi16>) -> vector<[16]xi16>
    %7 = "llvm.insertvalue"(%3, %6) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<[16]xi16>>, vector<[16]xi16>) -> !llvm.array<2 x vector<[16]xi16>>
    %8 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<[8]xi16>>) -> vector<[8]xi16>
    %9 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<[8]xi16>>) -> vector<[8]xi16>
    %10 = "llvm.intr.vector.interleave2"(%8, %9) : (vector<[8]xi16>, vector<[8]xi16>) -> vector<[16]xi16>
    %11 = "llvm.insertvalue"(%7, %10) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<[16]xi16>>, vector<[16]xi16>) -> !llvm.array<2 x vector<[16]xi16>>
    %12 = "builtin.unrealized_conversion_cast"(%11) : (!llvm.array<2 x vector<[16]xi16>>) -> vector<2x[16]xi16>
    "func.return"(%12) : (vector<2x[16]xi16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x8xf32>) -> (vector<2x4xf32>, vector<2x4xf32>), sym_name = "deinterleave_2d"}> ({
  ^bb0(%arg0: vector<2x8xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<2x8xf32>) -> !llvm.array<2 x vector<8xf32>>
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2x4xf32>}> : () -> vector<2x4xf32>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (vector<2x4xf32>) -> !llvm.array<2 x vector<4xf32>>
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<8xf32>>) -> vector<8xf32>
    %4 = "llvm.mlir.poison"() : () -> vector<8xf32>
    %5 = "llvm.shufflevector"(%3, %4) <{mask = array<i32: 0, 2, 4, 6>}> : (vector<8xf32>, vector<8xf32>) -> vector<4xf32>
    %6 = "llvm.shufflevector"(%3, %4) <{mask = array<i32: 1, 3, 5, 7>}> : (vector<8xf32>, vector<8xf32>) -> vector<4xf32>
    %7 = "llvm.insertvalue"(%2, %5) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<4xf32>>, vector<4xf32>) -> !llvm.array<2 x vector<4xf32>>
    %8 = "llvm.insertvalue"(%2, %6) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<4xf32>>, vector<4xf32>) -> !llvm.array<2 x vector<4xf32>>
    %9 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<8xf32>>) -> vector<8xf32>
    %10 = "llvm.mlir.poison"() : () -> vector<8xf32>
    %11 = "llvm.shufflevector"(%9, %10) <{mask = array<i32: 0, 2, 4, 6>}> : (vector<8xf32>, vector<8xf32>) -> vector<4xf32>
    %12 = "llvm.shufflevector"(%9, %10) <{mask = array<i32: 1, 3, 5, 7>}> : (vector<8xf32>, vector<8xf32>) -> vector<4xf32>
    %13 = "llvm.insertvalue"(%7, %11) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<4xf32>>, vector<4xf32>) -> !llvm.array<2 x vector<4xf32>>
    %14 = "builtin.unrealized_conversion_cast"(%13) : (!llvm.array<2 x vector<4xf32>>) -> vector<2x4xf32>
    %15 = "llvm.insertvalue"(%8, %12) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<4xf32>>, vector<4xf32>) -> !llvm.array<2 x vector<4xf32>>
    %16 = "builtin.unrealized_conversion_cast"(%15) : (!llvm.array<2 x vector<4xf32>>) -> vector<2x4xf32>
    "func.return"(%14, %16) : (vector<2x4xf32>, vector<2x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x[8]xf32>) -> (vector<2x[4]xf32>, vector<2x[4]xf32>), sym_name = "deinterleave_2d_scalable"}> ({
  ^bb0(%arg0: vector<2x[8]xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<2x[8]xf32>) -> !llvm.array<2 x vector<[8]xf32>>
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2x[4]xf32>}> : () -> vector<2x[4]xf32>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (vector<2x[4]xf32>) -> !llvm.array<2 x vector<[4]xf32>>
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<[8]xf32>>) -> vector<[8]xf32>
    %4 = "llvm.intr.vector.deinterleave2"(%3) : (vector<[8]xf32>) -> !llvm.struct<(vector<[4]xf32>, vector<[4]xf32>)>
    %5 = "llvm.extractvalue"(%4) <{position = array<i64: 0>}> : (!llvm.struct<(vector<[4]xf32>, vector<[4]xf32>)>) -> vector<[4]xf32>
    %6 = "llvm.extractvalue"(%4) <{position = array<i64: 1>}> : (!llvm.struct<(vector<[4]xf32>, vector<[4]xf32>)>) -> vector<[4]xf32>
    %7 = "llvm.insertvalue"(%2, %5) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<[4]xf32>>, vector<[4]xf32>) -> !llvm.array<2 x vector<[4]xf32>>
    %8 = "llvm.insertvalue"(%2, %6) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<[4]xf32>>, vector<[4]xf32>) -> !llvm.array<2 x vector<[4]xf32>>
    %9 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<[8]xf32>>) -> vector<[8]xf32>
    %10 = "llvm.intr.vector.deinterleave2"(%9) : (vector<[8]xf32>) -> !llvm.struct<(vector<[4]xf32>, vector<[4]xf32>)>
    %11 = "llvm.extractvalue"(%10) <{position = array<i64: 0>}> : (!llvm.struct<(vector<[4]xf32>, vector<[4]xf32>)>) -> vector<[4]xf32>
    %12 = "llvm.extractvalue"(%10) <{position = array<i64: 1>}> : (!llvm.struct<(vector<[4]xf32>, vector<[4]xf32>)>) -> vector<[4]xf32>
    %13 = "llvm.insertvalue"(%7, %11) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<[4]xf32>>, vector<[4]xf32>) -> !llvm.array<2 x vector<[4]xf32>>
    %14 = "builtin.unrealized_conversion_cast"(%13) : (!llvm.array<2 x vector<[4]xf32>>) -> vector<2x[4]xf32>
    %15 = "llvm.insertvalue"(%8, %12) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<[4]xf32>>, vector<[4]xf32>) -> !llvm.array<2 x vector<[4]xf32>>
    %16 = "builtin.unrealized_conversion_cast"(%15) : (!llvm.array<2 x vector<[4]xf32>>) -> vector<2x[4]xf32>
    "func.return"(%14, %16) : (vector<2x[4]xf32>, vector<2x[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<4xindex>, sym_name = "step"}> ({
    %0 = "arith.constant"() <{value = dense<[0, 1, 2, 3]> : vector<4xindex>}> : () -> vector<4xindex>
    "func.return"(%0) : (vector<4xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, f32, f32) -> vector<2x1x2xf32>, sym_name = "from_elements_3d"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: f32):
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> vector<2x1x2xf32>
    %1 = "builtin.unrealized_conversion_cast"(%0) : (vector<2x1x2xf32>) -> !llvm.array<2 x array<1 x vector<2xf32>>>
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> vector<1x2xf32>
    %3 = "builtin.unrealized_conversion_cast"(%2) : (vector<1x2xf32>) -> !llvm.array<1 x vector<2xf32>>
    %4 = "llvm.mlir.poison"() : () -> vector<2xf32>
    %5 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %6 = "llvm.insertelement"(%4, %arg0, %5) : (vector<2xf32>, f32, i64) -> vector<2xf32>
    %7 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %8 = "llvm.insertelement"(%6, %arg1, %7) : (vector<2xf32>, f32, i64) -> vector<2xf32>
    %9 = "llvm.insertvalue"(%3, %8) <{position = array<i64: 0>}> : (!llvm.array<1 x vector<2xf32>>, vector<2xf32>) -> !llvm.array<1 x vector<2xf32>>
    %10 = "llvm.insertvalue"(%1, %9) <{position = array<i64: 0>}> : (!llvm.array<2 x array<1 x vector<2xf32>>>, !llvm.array<1 x vector<2xf32>>) -> !llvm.array<2 x array<1 x vector<2xf32>>>
    %11 = "llvm.mlir.poison"() : () -> vector<2xf32>
    %12 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %13 = "llvm.insertelement"(%11, %arg2, %12) : (vector<2xf32>, f32, i64) -> vector<2xf32>
    %14 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %15 = "llvm.insertelement"(%13, %arg3, %14) : (vector<2xf32>, f32, i64) -> vector<2xf32>
    %16 = "llvm.insertvalue"(%3, %15) <{position = array<i64: 0>}> : (!llvm.array<1 x vector<2xf32>>, vector<2xf32>) -> !llvm.array<1 x vector<2xf32>>
    %17 = "llvm.insertvalue"(%10, %16) <{position = array<i64: 1>}> : (!llvm.array<2 x array<1 x vector<2xf32>>>, !llvm.array<1 x vector<2xf32>>) -> !llvm.array<2 x array<1 x vector<2xf32>>>
    %18 = "builtin.unrealized_conversion_cast"(%17) : (!llvm.array<2 x array<1 x vector<2xf32>>>) -> vector<2x1x2xf32>
    "func.return"(%18) : (vector<2x1x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>) -> (f32, f32), sym_name = "to_elements_1d"}> ({
  ^bb0(%arg0: vector<2xf32>):
    %0 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %1 = "llvm.extractelement"(%arg0, %0) : (vector<2xf32>, i64) -> f32
    %2 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %3 = "llvm.extractelement"(%arg0, %2) : (vector<2xf32>, i64) -> f32
    "func.return"(%1, %3) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xf32>) -> (f32, f32, f32, f32), sym_name = "to_elements_2d"}> ({
  ^bb0(%arg0: vector<2x2xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<2x2xf32>) -> !llvm.array<2 x vector<2xf32>>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<2xf32>>) -> vector<2xf32>
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<2xf32>>) -> vector<2xf32>
    %3 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %4 = "llvm.extractelement"(%1, %3) : (vector<2xf32>, i64) -> f32
    %5 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %6 = "llvm.extractelement"(%1, %5) : (vector<2xf32>, i64) -> f32
    %7 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %8 = "llvm.extractelement"(%2, %7) : (vector<2xf32>, i64) -> f32
    %9 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %10 = "llvm.extractelement"(%2, %9) : (vector<2xf32>, i64) -> f32
    "func.return"(%4, %6, %8, %10) : (f32, f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

