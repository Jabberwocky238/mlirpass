module {
  func.func @bitcast_2d(%arg0: vector<2x4xi32>) -> vector<2x2xi64> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2x4xi32> to !llvm.array<2 x vector<4xi32>>
    %1 = ub.poison : vector<2x2xi64>
    %2 = builtin.unrealized_conversion_cast %1 : vector<2x2xi64> to !llvm.array<2 x vector<2xi64>>
    %3 = llvm.extractvalue %0[0] : !llvm.array<2 x vector<4xi32>> 
    %4 = llvm.bitcast %3 : vector<4xi32> to vector<2xi64>
    %5 = llvm.insertvalue %4, %2[0] : !llvm.array<2 x vector<2xi64>> 
    %6 = llvm.extractvalue %0[1] : !llvm.array<2 x vector<4xi32>> 
    %7 = llvm.bitcast %6 : vector<4xi32> to vector<2xi64>
    %8 = llvm.insertvalue %7, %5[1] : !llvm.array<2 x vector<2xi64>> 
    %9 = builtin.unrealized_conversion_cast %8 : !llvm.array<2 x vector<2xi64>> to vector<2x2xi64>
    return %9 : vector<2x2xi64>
  }
}

// -----
module {
  func.func @bitcast_2d_scalable(%arg0: vector<2x[4]xi32>) -> vector<2x[2]xi64> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2x[4]xi32> to !llvm.array<2 x vector<[4]xi32>>
    %1 = ub.poison : vector<2x[2]xi64>
    %2 = builtin.unrealized_conversion_cast %1 : vector<2x[2]xi64> to !llvm.array<2 x vector<[2]xi64>>
    %3 = llvm.extractvalue %0[0] : !llvm.array<2 x vector<[4]xi32>> 
    %4 = llvm.bitcast %3 : vector<[4]xi32> to vector<[2]xi64>
    %5 = llvm.insertvalue %4, %2[0] : !llvm.array<2 x vector<[2]xi64>> 
    %6 = llvm.extractvalue %0[1] : !llvm.array<2 x vector<[4]xi32>> 
    %7 = llvm.bitcast %6 : vector<[4]xi32> to vector<[2]xi64>
    %8 = llvm.insertvalue %7, %5[1] : !llvm.array<2 x vector<[2]xi64>> 
    %9 = builtin.unrealized_conversion_cast %8 : !llvm.array<2 x vector<[2]xi64>> to vector<2x[2]xi64>
    return %9 : vector<2x[2]xi64>
  }
}

// -----
module {
  func.func @broadcast_vec0d_from_f32(%arg0: f32) -> vector<f32> {
    %0 = llvm.mlir.poison : vector<1xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : vector<1xf32>
    %3 = builtin.unrealized_conversion_cast %2 : vector<1xf32> to vector<f32>
    return %3 : vector<f32>
  }
}

// -----
module {
  func.func @broadcast_vec1d_from_f32(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %3 = llvm.shufflevector %2, %0 [0, 0] : vector<2xf32> 
    return %3 : vector<2xf32>
  }
}

// -----
module {
  func.func @broadcast_single_elem_vec1d_from_f32(%arg0: f32) -> vector<1xf32> {
    %0 = llvm.mlir.poison : vector<1xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : vector<1xf32>
    return %2 : vector<1xf32>
  }
}

// -----
module {
  func.func @broadcast_vec1d_from_f32_scalable(%arg0: f32) -> vector<[2]xf32> {
    %0 = llvm.mlir.poison : vector<[2]xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : vector<[2]xf32>
    %3 = llvm.shufflevector %2, %0 [0, 0] : vector<[2]xf32> 
    return %3 : vector<[2]xf32>
  }
}

// -----
module {
  func.func @broadcast_vec1d_from_index(%arg0: index) -> vector<2xindex> {
    %0 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %1 = llvm.mlir.poison : vector<2xi64>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : vector<2xi64>
    %4 = llvm.shufflevector %3, %1 [0, 0] : vector<2xi64> 
    %5 = builtin.unrealized_conversion_cast %4 : vector<2xi64> to vector<2xindex>
    return %5 : vector<2xindex>
  }
}

// -----
module {
  func.func @broadcast_vec1d_from_index_scalable(%arg0: index) -> vector<[2]xindex> {
    %0 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %1 = llvm.mlir.poison : vector<[2]xi64>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : vector<[2]xi64>
    %4 = llvm.shufflevector %3, %1 [0, 0] : vector<[2]xi64> 
    %5 = builtin.unrealized_conversion_cast %4 : vector<[2]xi64> to vector<[2]xindex>
    return %5 : vector<[2]xindex>
  }
}

// -----
module {
  func.func @broadcast_vec2d_from_scalar(%arg0: f32) -> vector<2x3xf32> {
    %0 = llvm.mlir.poison : !llvm.array<2 x vector<3xf32>>
    %1 = llvm.mlir.poison : vector<3xf32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %arg0, %1[%2 : i32] : vector<3xf32>
    %4 = llvm.shufflevector %3, %3 [0, 0, 0] : vector<3xf32> 
    %5 = llvm.insertvalue %4, %0[0] : !llvm.array<2 x vector<3xf32>> 
    %6 = llvm.insertvalue %4, %5[1] : !llvm.array<2 x vector<3xf32>> 
    %7 = builtin.unrealized_conversion_cast %6 : !llvm.array<2 x vector<3xf32>> to vector<2x3xf32>
    return %7 : vector<2x3xf32>
  }
}

// -----
module {
  func.func @broadcast_vec2d_from_scalar_scalable(%arg0: f32) -> vector<2x[3]xf32> {
    %0 = llvm.mlir.poison : !llvm.array<2 x vector<[3]xf32>>
    %1 = llvm.mlir.poison : vector<[3]xf32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %arg0, %1[%2 : i32] : vector<[3]xf32>
    %4 = llvm.shufflevector %3, %3 [0, 0, 0] : vector<[3]xf32> 
    %5 = llvm.insertvalue %4, %0[0] : !llvm.array<2 x vector<[3]xf32>> 
    %6 = llvm.insertvalue %4, %5[1] : !llvm.array<2 x vector<[3]xf32>> 
    %7 = builtin.unrealized_conversion_cast %6 : !llvm.array<2 x vector<[3]xf32>> to vector<2x[3]xf32>
    return %7 : vector<2x[3]xf32>
  }
}

// -----
module {
  func.func @broadcast_vec3d_from_scalar(%arg0: f32) -> vector<2x3x4xf32> {
    %0 = llvm.mlir.poison : !llvm.array<2 x array<3 x vector<4xf32>>>
    %1 = llvm.mlir.poison : vector<4xf32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %arg0, %1[%2 : i32] : vector<4xf32>
    %4 = llvm.shufflevector %3, %3 [0, 0, 0, 0] : vector<4xf32> 
    %5 = llvm.insertvalue %4, %0[0, 0] : !llvm.array<2 x array<3 x vector<4xf32>>> 
    %6 = llvm.insertvalue %4, %5[0, 1] : !llvm.array<2 x array<3 x vector<4xf32>>> 
    %7 = llvm.insertvalue %4, %6[0, 2] : !llvm.array<2 x array<3 x vector<4xf32>>> 
    %8 = llvm.insertvalue %4, %7[1, 0] : !llvm.array<2 x array<3 x vector<4xf32>>> 
    %9 = llvm.insertvalue %4, %8[1, 1] : !llvm.array<2 x array<3 x vector<4xf32>>> 
    %10 = llvm.insertvalue %4, %9[1, 2] : !llvm.array<2 x array<3 x vector<4xf32>>> 
    %11 = builtin.unrealized_conversion_cast %10 : !llvm.array<2 x array<3 x vector<4xf32>>> to vector<2x3x4xf32>
    return %11 : vector<2x3x4xf32>
  }
}

// -----
module {
  func.func @broadcast_vec3d_from_scalar_scalable(%arg0: f32) -> vector<2x3x[4]xf32> {
    %0 = llvm.mlir.poison : !llvm.array<2 x array<3 x vector<[4]xf32>>>
    %1 = llvm.mlir.poison : vector<[4]xf32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %arg0, %1[%2 : i32] : vector<[4]xf32>
    %4 = llvm.shufflevector %3, %3 [0, 0, 0, 0] : vector<[4]xf32> 
    %5 = llvm.insertvalue %4, %0[0, 0] : !llvm.array<2 x array<3 x vector<[4]xf32>>> 
    %6 = llvm.insertvalue %4, %5[0, 1] : !llvm.array<2 x array<3 x vector<[4]xf32>>> 
    %7 = llvm.insertvalue %4, %6[0, 2] : !llvm.array<2 x array<3 x vector<[4]xf32>>> 
    %8 = llvm.insertvalue %4, %7[1, 0] : !llvm.array<2 x array<3 x vector<[4]xf32>>> 
    %9 = llvm.insertvalue %4, %8[1, 1] : !llvm.array<2 x array<3 x vector<[4]xf32>>> 
    %10 = llvm.insertvalue %4, %9[1, 2] : !llvm.array<2 x array<3 x vector<[4]xf32>>> 
    %11 = builtin.unrealized_conversion_cast %10 : !llvm.array<2 x array<3 x vector<[4]xf32>>> to vector<2x3x[4]xf32>
    return %11 : vector<2x3x[4]xf32>
  }
}

// -----
module {
  func.func @broadcast_vec2d_from_vec0d(%arg0: vector<f32>) -> vector<3x2xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<f32> to vector<1xf32>
    %1 = ub.poison : vector<3x2xf32>
    %2 = builtin.unrealized_conversion_cast %1 : vector<3x2xf32> to !llvm.array<3 x vector<2xf32>>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.extractelement %0[%3 : i64] : vector<1xf32>
    %5 = llvm.mlir.poison : vector<2xf32>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<2xf32>
    %8 = llvm.shufflevector %7, %5 [0, 0] : vector<2xf32> 
    %9 = llvm.insertvalue %8, %2[0] : !llvm.array<3 x vector<2xf32>> 
    %10 = llvm.insertvalue %8, %9[1] : !llvm.array<3 x vector<2xf32>> 
    %11 = llvm.insertvalue %8, %10[2] : !llvm.array<3 x vector<2xf32>> 
    %12 = builtin.unrealized_conversion_cast %11 : !llvm.array<3 x vector<2xf32>> to vector<3x2xf32>
    return %12 : vector<3x2xf32>
  }
}

// -----
module {
  func.func @broadcast_vec2d_from_vec1d(%arg0: vector<2xf32>) -> vector<3x2xf32> {
    %0 = ub.poison : vector<3x2xf32>
    %1 = builtin.unrealized_conversion_cast %0 : vector<3x2xf32> to !llvm.array<3 x vector<2xf32>>
    %2 = llvm.insertvalue %arg0, %1[0] : !llvm.array<3 x vector<2xf32>> 
    %3 = llvm.insertvalue %arg0, %2[1] : !llvm.array<3 x vector<2xf32>> 
    %4 = llvm.insertvalue %arg0, %3[2] : !llvm.array<3 x vector<2xf32>> 
    %5 = builtin.unrealized_conversion_cast %4 : !llvm.array<3 x vector<2xf32>> to vector<3x2xf32>
    return %5 : vector<3x2xf32>
  }
}

// -----
module {
  func.func @broadcast_vec2d_from_vec1d_scalable(%arg0: vector<[2]xf32>) -> vector<3x[2]xf32> {
    %0 = ub.poison : vector<3x[2]xf32>
    %1 = builtin.unrealized_conversion_cast %0 : vector<3x[2]xf32> to !llvm.array<3 x vector<[2]xf32>>
    %2 = llvm.insertvalue %arg0, %1[0] : !llvm.array<3 x vector<[2]xf32>> 
    %3 = llvm.insertvalue %arg0, %2[1] : !llvm.array<3 x vector<[2]xf32>> 
    %4 = llvm.insertvalue %arg0, %3[2] : !llvm.array<3 x vector<[2]xf32>> 
    %5 = builtin.unrealized_conversion_cast %4 : !llvm.array<3 x vector<[2]xf32>> to vector<3x[2]xf32>
    return %5 : vector<3x[2]xf32>
  }
}

// -----
module {
  func.func @broadcast_vec2d_from_index_vec1d(%arg0: vector<2xindex>) -> vector<3x2xindex> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2xindex> to vector<2xi64>
    %1 = ub.poison : vector<3x2xindex>
    %2 = builtin.unrealized_conversion_cast %1 : vector<3x2xindex> to !llvm.array<3 x vector<2xi64>>
    %3 = llvm.insertvalue %0, %2[0] : !llvm.array<3 x vector<2xi64>> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.array<3 x vector<2xi64>> 
    %5 = llvm.insertvalue %0, %4[2] : !llvm.array<3 x vector<2xi64>> 
    %6 = builtin.unrealized_conversion_cast %5 : !llvm.array<3 x vector<2xi64>> to vector<3x2xindex>
    return %6 : vector<3x2xindex>
  }
}

// -----
module {
  func.func @broadcast_vec2d_from_index_vec1d_scalable(%arg0: vector<[2]xindex>) -> vector<3x[2]xindex> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<[2]xindex> to vector<[2]xi64>
    %1 = ub.poison : vector<3x[2]xindex>
    %2 = builtin.unrealized_conversion_cast %1 : vector<3x[2]xindex> to !llvm.array<3 x vector<[2]xi64>>
    %3 = llvm.insertvalue %0, %2[0] : !llvm.array<3 x vector<[2]xi64>> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.array<3 x vector<[2]xi64>> 
    %5 = llvm.insertvalue %0, %4[2] : !llvm.array<3 x vector<[2]xi64>> 
    %6 = builtin.unrealized_conversion_cast %5 : !llvm.array<3 x vector<[2]xi64>> to vector<3x[2]xindex>
    return %6 : vector<3x[2]xindex>
  }
}

// -----
module {
  func.func @broadcast_vec3d_from_vec1d(%arg0: vector<2xf32>) -> vector<4x3x2xf32> {
    %0 = ub.poison : vector<4x3x2xf32>
    %1 = builtin.unrealized_conversion_cast %0 : vector<4x3x2xf32> to !llvm.array<4 x array<3 x vector<2xf32>>>
    %2 = ub.poison : vector<3x2xf32>
    %3 = builtin.unrealized_conversion_cast %2 : vector<3x2xf32> to !llvm.array<3 x vector<2xf32>>
    %4 = llvm.insertvalue %arg0, %3[0] : !llvm.array<3 x vector<2xf32>> 
    %5 = llvm.insertvalue %arg0, %4[1] : !llvm.array<3 x vector<2xf32>> 
    %6 = llvm.insertvalue %arg0, %5[2] : !llvm.array<3 x vector<2xf32>> 
    %7 = llvm.insertvalue %6, %1[0] : !llvm.array<4 x array<3 x vector<2xf32>>> 
    %8 = llvm.insertvalue %6, %7[1] : !llvm.array<4 x array<3 x vector<2xf32>>> 
    %9 = llvm.insertvalue %6, %8[2] : !llvm.array<4 x array<3 x vector<2xf32>>> 
    %10 = llvm.insertvalue %6, %9[3] : !llvm.array<4 x array<3 x vector<2xf32>>> 
    %11 = builtin.unrealized_conversion_cast %10 : !llvm.array<4 x array<3 x vector<2xf32>>> to vector<4x3x2xf32>
    return %11 : vector<4x3x2xf32>
  }
}

// -----
module {
  func.func @broadcast_vec3d_from_vec1d_scalable(%arg0: vector<[2]xf32>) -> vector<4x3x[2]xf32> {
    %0 = ub.poison : vector<4x3x[2]xf32>
    %1 = builtin.unrealized_conversion_cast %0 : vector<4x3x[2]xf32> to !llvm.array<4 x array<3 x vector<[2]xf32>>>
    %2 = ub.poison : vector<3x[2]xf32>
    %3 = builtin.unrealized_conversion_cast %2 : vector<3x[2]xf32> to !llvm.array<3 x vector<[2]xf32>>
    %4 = llvm.insertvalue %arg0, %3[0] : !llvm.array<3 x vector<[2]xf32>> 
    %5 = llvm.insertvalue %arg0, %4[1] : !llvm.array<3 x vector<[2]xf32>> 
    %6 = llvm.insertvalue %arg0, %5[2] : !llvm.array<3 x vector<[2]xf32>> 
    %7 = llvm.insertvalue %6, %1[0] : !llvm.array<4 x array<3 x vector<[2]xf32>>> 
    %8 = llvm.insertvalue %6, %7[1] : !llvm.array<4 x array<3 x vector<[2]xf32>>> 
    %9 = llvm.insertvalue %6, %8[2] : !llvm.array<4 x array<3 x vector<[2]xf32>>> 
    %10 = llvm.insertvalue %6, %9[3] : !llvm.array<4 x array<3 x vector<[2]xf32>>> 
    %11 = builtin.unrealized_conversion_cast %10 : !llvm.array<4 x array<3 x vector<[2]xf32>>> to vector<4x3x[2]xf32>
    return %11 : vector<4x3x[2]xf32>
  }
}

// -----
module {
  func.func @broadcast_vec3d_from_vec2d(%arg0: vector<3x2xf32>) -> vector<4x3x2xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<3x2xf32> to !llvm.array<3 x vector<2xf32>>
    %1 = ub.poison : vector<4x3x2xf32>
    %2 = builtin.unrealized_conversion_cast %1 : vector<4x3x2xf32> to !llvm.array<4 x array<3 x vector<2xf32>>>
    %3 = llvm.insertvalue %0, %2[0] : !llvm.array<4 x array<3 x vector<2xf32>>> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.array<4 x array<3 x vector<2xf32>>> 
    %5 = llvm.insertvalue %0, %4[2] : !llvm.array<4 x array<3 x vector<2xf32>>> 
    %6 = llvm.insertvalue %0, %5[3] : !llvm.array<4 x array<3 x vector<2xf32>>> 
    %7 = builtin.unrealized_conversion_cast %6 : !llvm.array<4 x array<3 x vector<2xf32>>> to vector<4x3x2xf32>
    return %7 : vector<4x3x2xf32>
  }
}

// -----
module {
  func.func @broadcast_vec3d_from_vec2d_scalable(%arg0: vector<3x[2]xf32>) -> vector<4x3x[2]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<3x[2]xf32> to !llvm.array<3 x vector<[2]xf32>>
    %1 = ub.poison : vector<4x3x[2]xf32>
    %2 = builtin.unrealized_conversion_cast %1 : vector<4x3x[2]xf32> to !llvm.array<4 x array<3 x vector<[2]xf32>>>
    %3 = llvm.insertvalue %0, %2[0] : !llvm.array<4 x array<3 x vector<[2]xf32>>> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.array<4 x array<3 x vector<[2]xf32>>> 
    %5 = llvm.insertvalue %0, %4[2] : !llvm.array<4 x array<3 x vector<[2]xf32>>> 
    %6 = llvm.insertvalue %0, %5[3] : !llvm.array<4 x array<3 x vector<[2]xf32>>> 
    %7 = builtin.unrealized_conversion_cast %6 : !llvm.array<4 x array<3 x vector<[2]xf32>>> to vector<4x3x[2]xf32>
    return %7 : vector<4x3x[2]xf32>
  }
}

// -----
module {
  func.func @broadcast_stretch(%arg0: vector<1xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : vector<1xf32>
    %2 = llvm.mlir.poison : vector<4xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<4xf32>
    %5 = llvm.shufflevector %4, %2 [0, 0, 0, 0] : vector<4xf32> 
    return %5 : vector<4xf32>
  }
}

// -----
module {
  func.func @broadcast_stretch_scalable(%arg0: vector<1xf32>) -> vector<[4]xf32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : vector<1xf32>
    %2 = llvm.mlir.poison : vector<[4]xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<[4]xf32>
    %5 = llvm.shufflevector %4, %2 [0, 0, 0, 0] : vector<[4]xf32> 
    return %5 : vector<[4]xf32>
  }
}

// -----
module {
  func.func @broadcast_stretch_at_start(%arg0: vector<1x4xf32>) -> vector<3x4xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1x4xf32> to !llvm.array<1 x vector<4xf32>>
    %1 = ub.poison : vector<3x4xf32>
    %2 = builtin.unrealized_conversion_cast %1 : vector<3x4xf32> to !llvm.array<3 x vector<4xf32>>
    %3 = llvm.extractvalue %0[0] : !llvm.array<1 x vector<4xf32>> 
    %4 = llvm.insertvalue %3, %2[0] : !llvm.array<3 x vector<4xf32>> 
    %5 = llvm.insertvalue %3, %4[1] : !llvm.array<3 x vector<4xf32>> 
    %6 = llvm.insertvalue %3, %5[2] : !llvm.array<3 x vector<4xf32>> 
    %7 = builtin.unrealized_conversion_cast %6 : !llvm.array<3 x vector<4xf32>> to vector<3x4xf32>
    return %7 : vector<3x4xf32>
  }
}

// -----
module {
  func.func @broadcast_stretch_at_start_scalable(%arg0: vector<1x[4]xf32>) -> vector<3x[4]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1x[4]xf32> to !llvm.array<1 x vector<[4]xf32>>
    %1 = ub.poison : vector<3x[4]xf32>
    %2 = builtin.unrealized_conversion_cast %1 : vector<3x[4]xf32> to !llvm.array<3 x vector<[4]xf32>>
    %3 = llvm.extractvalue %0[0] : !llvm.array<1 x vector<[4]xf32>> 
    %4 = llvm.insertvalue %3, %2[0] : !llvm.array<3 x vector<[4]xf32>> 
    %5 = llvm.insertvalue %3, %4[1] : !llvm.array<3 x vector<[4]xf32>> 
    %6 = llvm.insertvalue %3, %5[2] : !llvm.array<3 x vector<[4]xf32>> 
    %7 = builtin.unrealized_conversion_cast %6 : !llvm.array<3 x vector<[4]xf32>> to vector<3x[4]xf32>
    return %7 : vector<3x[4]xf32>
  }
}

// -----
module {
  func.func @broadcast_stretch_at_end(%arg0: vector<4x1xf32>) -> vector<4x3xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4x1xf32> to !llvm.array<4 x vector<1xf32>>
    %1 = ub.poison : vector<4x3xf32>
    %2 = builtin.unrealized_conversion_cast %1 : vector<4x3xf32> to !llvm.array<4 x vector<3xf32>>
    %3 = llvm.extractvalue %0[0] : !llvm.array<4 x vector<1xf32>> 
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.extractelement %3[%4 : i64] : vector<1xf32>
    %6 = llvm.mlir.poison : vector<3xf32>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.insertelement %5, %6[%7 : i32] : vector<3xf32>
    %9 = llvm.shufflevector %8, %6 [0, 0, 0] : vector<3xf32> 
    %10 = llvm.insertvalue %9, %2[0] : !llvm.array<4 x vector<3xf32>> 
    %11 = llvm.extractvalue %0[1] : !llvm.array<4 x vector<1xf32>> 
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.extractelement %11[%12 : i64] : vector<1xf32>
    %14 = llvm.mlir.poison : vector<3xf32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %13, %14[%15 : i32] : vector<3xf32>
    %17 = llvm.shufflevector %16, %14 [0, 0, 0] : vector<3xf32> 
    %18 = llvm.insertvalue %17, %10[1] : !llvm.array<4 x vector<3xf32>> 
    %19 = llvm.extractvalue %0[2] : !llvm.array<4 x vector<1xf32>> 
    %20 = llvm.mlir.constant(0 : i64) : i64
    %21 = llvm.extractelement %19[%20 : i64] : vector<1xf32>
    %22 = llvm.mlir.poison : vector<3xf32>
    %23 = llvm.mlir.constant(0 : i32) : i32
    %24 = llvm.insertelement %21, %22[%23 : i32] : vector<3xf32>
    %25 = llvm.shufflevector %24, %22 [0, 0, 0] : vector<3xf32> 
    %26 = llvm.insertvalue %25, %18[2] : !llvm.array<4 x vector<3xf32>> 
    %27 = llvm.extractvalue %0[3] : !llvm.array<4 x vector<1xf32>> 
    %28 = llvm.mlir.constant(0 : i64) : i64
    %29 = llvm.extractelement %27[%28 : i64] : vector<1xf32>
    %30 = llvm.mlir.poison : vector<3xf32>
    %31 = llvm.mlir.constant(0 : i32) : i32
    %32 = llvm.insertelement %29, %30[%31 : i32] : vector<3xf32>
    %33 = llvm.shufflevector %32, %30 [0, 0, 0] : vector<3xf32> 
    %34 = llvm.insertvalue %33, %26[3] : !llvm.array<4 x vector<3xf32>> 
    %35 = builtin.unrealized_conversion_cast %34 : !llvm.array<4 x vector<3xf32>> to vector<4x3xf32>
    return %35 : vector<4x3xf32>
  }
  func.func @broadcast_stretch_at_end_scalable(%arg0: vector<[4]x1xf32>) -> vector<[4]x3xf32> {
    %0 = vector.broadcast %arg0 : vector<[4]x1xf32> to vector<[4]x3xf32>
    return %0 : vector<[4]x3xf32>
  }
}

// -----
module {
  func.func @broadcast_stretch_in_middle(%arg0: vector<4x1x2xf32>) -> vector<4x3x2xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4x1x2xf32> to !llvm.array<4 x array<1 x vector<2xf32>>>
    %1 = ub.poison : vector<4x3x2xf32>
    %2 = builtin.unrealized_conversion_cast %1 : vector<4x3x2xf32> to !llvm.array<4 x array<3 x vector<2xf32>>>
    %3 = ub.poison : vector<3x2xf32>
    %4 = builtin.unrealized_conversion_cast %3 : vector<3x2xf32> to !llvm.array<3 x vector<2xf32>>
    %5 = llvm.extractvalue %0[0, 0] : !llvm.array<4 x array<1 x vector<2xf32>>> 
    %6 = llvm.insertvalue %5, %4[0] : !llvm.array<3 x vector<2xf32>> 
    %7 = llvm.insertvalue %5, %6[1] : !llvm.array<3 x vector<2xf32>> 
    %8 = llvm.insertvalue %5, %7[2] : !llvm.array<3 x vector<2xf32>> 
    %9 = llvm.insertvalue %8, %2[0] : !llvm.array<4 x array<3 x vector<2xf32>>> 
    %10 = llvm.extractvalue %0[1, 0] : !llvm.array<4 x array<1 x vector<2xf32>>> 
    %11 = llvm.insertvalue %10, %4[0] : !llvm.array<3 x vector<2xf32>> 
    %12 = llvm.insertvalue %10, %11[1] : !llvm.array<3 x vector<2xf32>> 
    %13 = llvm.insertvalue %10, %12[2] : !llvm.array<3 x vector<2xf32>> 
    %14 = llvm.insertvalue %13, %9[1] : !llvm.array<4 x array<3 x vector<2xf32>>> 
    %15 = llvm.extractvalue %0[2, 0] : !llvm.array<4 x array<1 x vector<2xf32>>> 
    %16 = llvm.insertvalue %15, %4[0] : !llvm.array<3 x vector<2xf32>> 
    %17 = llvm.insertvalue %15, %16[1] : !llvm.array<3 x vector<2xf32>> 
    %18 = llvm.insertvalue %15, %17[2] : !llvm.array<3 x vector<2xf32>> 
    %19 = llvm.insertvalue %18, %14[2] : !llvm.array<4 x array<3 x vector<2xf32>>> 
    %20 = llvm.extractvalue %0[3, 0] : !llvm.array<4 x array<1 x vector<2xf32>>> 
    %21 = llvm.insertvalue %20, %4[0] : !llvm.array<3 x vector<2xf32>> 
    %22 = llvm.insertvalue %20, %21[1] : !llvm.array<3 x vector<2xf32>> 
    %23 = llvm.insertvalue %20, %22[2] : !llvm.array<3 x vector<2xf32>> 
    %24 = llvm.insertvalue %23, %19[3] : !llvm.array<4 x array<3 x vector<2xf32>>> 
    %25 = builtin.unrealized_conversion_cast %24 : !llvm.array<4 x array<3 x vector<2xf32>>> to vector<4x3x2xf32>
    return %25 : vector<4x3x2xf32>
  }
}

// -----
module {
  func.func @broadcast_stretch_in_middle_scalable_v1(%arg0: vector<4x1x[2]xf32>) -> vector<4x3x[2]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4x1x[2]xf32> to !llvm.array<4 x array<1 x vector<[2]xf32>>>
    %1 = ub.poison : vector<4x3x[2]xf32>
    %2 = builtin.unrealized_conversion_cast %1 : vector<4x3x[2]xf32> to !llvm.array<4 x array<3 x vector<[2]xf32>>>
    %3 = ub.poison : vector<3x[2]xf32>
    %4 = builtin.unrealized_conversion_cast %3 : vector<3x[2]xf32> to !llvm.array<3 x vector<[2]xf32>>
    %5 = llvm.extractvalue %0[0, 0] : !llvm.array<4 x array<1 x vector<[2]xf32>>> 
    %6 = llvm.insertvalue %5, %4[0] : !llvm.array<3 x vector<[2]xf32>> 
    %7 = llvm.insertvalue %5, %6[1] : !llvm.array<3 x vector<[2]xf32>> 
    %8 = llvm.insertvalue %5, %7[2] : !llvm.array<3 x vector<[2]xf32>> 
    %9 = llvm.insertvalue %8, %2[0] : !llvm.array<4 x array<3 x vector<[2]xf32>>> 
    %10 = llvm.extractvalue %0[1, 0] : !llvm.array<4 x array<1 x vector<[2]xf32>>> 
    %11 = llvm.insertvalue %10, %4[0] : !llvm.array<3 x vector<[2]xf32>> 
    %12 = llvm.insertvalue %10, %11[1] : !llvm.array<3 x vector<[2]xf32>> 
    %13 = llvm.insertvalue %10, %12[2] : !llvm.array<3 x vector<[2]xf32>> 
    %14 = llvm.insertvalue %13, %9[1] : !llvm.array<4 x array<3 x vector<[2]xf32>>> 
    %15 = llvm.extractvalue %0[2, 0] : !llvm.array<4 x array<1 x vector<[2]xf32>>> 
    %16 = llvm.insertvalue %15, %4[0] : !llvm.array<3 x vector<[2]xf32>> 
    %17 = llvm.insertvalue %15, %16[1] : !llvm.array<3 x vector<[2]xf32>> 
    %18 = llvm.insertvalue %15, %17[2] : !llvm.array<3 x vector<[2]xf32>> 
    %19 = llvm.insertvalue %18, %14[2] : !llvm.array<4 x array<3 x vector<[2]xf32>>> 
    %20 = llvm.extractvalue %0[3, 0] : !llvm.array<4 x array<1 x vector<[2]xf32>>> 
    %21 = llvm.insertvalue %20, %4[0] : !llvm.array<3 x vector<[2]xf32>> 
    %22 = llvm.insertvalue %20, %21[1] : !llvm.array<3 x vector<[2]xf32>> 
    %23 = llvm.insertvalue %20, %22[2] : !llvm.array<3 x vector<[2]xf32>> 
    %24 = llvm.insertvalue %23, %19[3] : !llvm.array<4 x array<3 x vector<[2]xf32>>> 
    %25 = builtin.unrealized_conversion_cast %24 : !llvm.array<4 x array<3 x vector<[2]xf32>>> to vector<4x3x[2]xf32>
    return %25 : vector<4x3x[2]xf32>
  }
}

// -----
module {
  func.func @broadcast_stretch_in_middle_scalable_v2(%arg0: vector<[4]x1x2xf32>) -> vector<[4]x3x2xf32> {
    %0 = vector.broadcast %arg0 : vector<[4]x1x2xf32> to vector<[4]x3x2xf32>
    return %0 : vector<[4]x3x2xf32>
  }
}

// -----
module {
  func.func @outerproduct(%arg0: vector<2xf32>, %arg1: vector<3xf32>) -> vector<2x3xf32> {
    %cst = arith.constant dense<0.000000e+00> : vector<2x3xf32>
    %0 = builtin.unrealized_conversion_cast %cst : vector<2x3xf32> to !llvm.array<2 x vector<3xf32>>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.extractelement %arg0[%1 : i64] : vector<2xf32>
    %3 = llvm.mlir.poison : vector<3xf32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xf32>
    %6 = llvm.shufflevector %5, %3 [0, 0, 0] : vector<3xf32> 
    %7 = arith.mulf %6, %arg1 : vector<3xf32>
    %8 = llvm.insertvalue %7, %0[0] : !llvm.array<2 x vector<3xf32>> 
    %9 = llvm.mlir.constant(1 : i64) : i64
    %10 = llvm.extractelement %arg0[%9 : i64] : vector<2xf32>
    %11 = llvm.mlir.poison : vector<3xf32>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.insertelement %10, %11[%12 : i32] : vector<3xf32>
    %14 = llvm.shufflevector %13, %11 [0, 0, 0] : vector<3xf32> 
    %15 = arith.mulf %14, %arg1 : vector<3xf32>
    %16 = llvm.insertvalue %15, %8[1] : !llvm.array<2 x vector<3xf32>> 
    %17 = builtin.unrealized_conversion_cast %16 : !llvm.array<2 x vector<3xf32>> to vector<2x3xf32>
    return %17 : vector<2x3xf32>
  }
}

// -----
module {
  func.func @outerproduct_scalable(%arg0: vector<2xf32>, %arg1: vector<[3]xf32>) -> vector<2x[3]xf32> {
    %cst = arith.constant dense<0.000000e+00> : vector<2x[3]xf32>
    %0 = builtin.unrealized_conversion_cast %cst : vector<2x[3]xf32> to !llvm.array<2 x vector<[3]xf32>>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.extractelement %arg0[%1 : i64] : vector<2xf32>
    %3 = llvm.mlir.poison : vector<[3]xf32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<[3]xf32>
    %6 = llvm.shufflevector %5, %3 [0, 0, 0] : vector<[3]xf32> 
    %7 = arith.mulf %6, %arg1 : vector<[3]xf32>
    %8 = llvm.insertvalue %7, %0[0] : !llvm.array<2 x vector<[3]xf32>> 
    %9 = llvm.mlir.constant(1 : i64) : i64
    %10 = llvm.extractelement %arg0[%9 : i64] : vector<2xf32>
    %11 = llvm.mlir.poison : vector<[3]xf32>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.insertelement %10, %11[%12 : i32] : vector<[3]xf32>
    %14 = llvm.shufflevector %13, %11 [0, 0, 0] : vector<[3]xf32> 
    %15 = arith.mulf %14, %arg1 : vector<[3]xf32>
    %16 = llvm.insertvalue %15, %8[1] : !llvm.array<2 x vector<[3]xf32>> 
    %17 = builtin.unrealized_conversion_cast %16 : !llvm.array<2 x vector<[3]xf32>> to vector<2x[3]xf32>
    return %17 : vector<2x[3]xf32>
  }
}

// -----
module {
  func.func @outerproduct_index(%arg0: vector<2xindex>, %arg1: vector<3xindex>) -> vector<2x3xindex> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2xindex> to vector<2xi64>
    %cst = arith.constant dense<0> : vector<2x3xindex>
    %1 = builtin.unrealized_conversion_cast %cst : vector<2x3xindex> to !llvm.array<2 x vector<3xi64>>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.extractelement %0[%2 : i64] : vector<2xi64>
    %4 = llvm.mlir.poison : vector<3xi64>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<3xi64>
    %7 = llvm.shufflevector %6, %4 [0, 0, 0] : vector<3xi64> 
    %8 = builtin.unrealized_conversion_cast %7 : vector<3xi64> to vector<3xindex>
    %9 = arith.muli %8, %arg1 : vector<3xindex>
    %10 = builtin.unrealized_conversion_cast %9 : vector<3xindex> to vector<3xi64>
    %11 = llvm.insertvalue %10, %1[0] : !llvm.array<2 x vector<3xi64>> 
    %12 = llvm.mlir.constant(1 : i64) : i64
    %13 = llvm.extractelement %0[%12 : i64] : vector<2xi64>
    %14 = llvm.mlir.poison : vector<3xi64>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %13, %14[%15 : i32] : vector<3xi64>
    %17 = llvm.shufflevector %16, %14 [0, 0, 0] : vector<3xi64> 
    %18 = builtin.unrealized_conversion_cast %17 : vector<3xi64> to vector<3xindex>
    %19 = arith.muli %18, %arg1 : vector<3xindex>
    %20 = builtin.unrealized_conversion_cast %19 : vector<3xindex> to vector<3xi64>
    %21 = llvm.insertvalue %20, %11[1] : !llvm.array<2 x vector<3xi64>> 
    %22 = builtin.unrealized_conversion_cast %21 : !llvm.array<2 x vector<3xi64>> to vector<2x3xindex>
    return %22 : vector<2x3xindex>
  }
}

// -----
module {
  func.func @outerproduct_index_scalable(%arg0: vector<2xindex>, %arg1: vector<[3]xindex>) -> vector<2x[3]xindex> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2xindex> to vector<2xi64>
    %cst = arith.constant dense<0> : vector<2x[3]xindex>
    %1 = builtin.unrealized_conversion_cast %cst : vector<2x[3]xindex> to !llvm.array<2 x vector<[3]xi64>>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.extractelement %0[%2 : i64] : vector<2xi64>
    %4 = llvm.mlir.poison : vector<[3]xi64>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<[3]xi64>
    %7 = llvm.shufflevector %6, %4 [0, 0, 0] : vector<[3]xi64> 
    %8 = builtin.unrealized_conversion_cast %7 : vector<[3]xi64> to vector<[3]xindex>
    %9 = arith.muli %8, %arg1 : vector<[3]xindex>
    %10 = builtin.unrealized_conversion_cast %9 : vector<[3]xindex> to vector<[3]xi64>
    %11 = llvm.insertvalue %10, %1[0] : !llvm.array<2 x vector<[3]xi64>> 
    %12 = llvm.mlir.constant(1 : i64) : i64
    %13 = llvm.extractelement %0[%12 : i64] : vector<2xi64>
    %14 = llvm.mlir.poison : vector<[3]xi64>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %13, %14[%15 : i32] : vector<[3]xi64>
    %17 = llvm.shufflevector %16, %14 [0, 0, 0] : vector<[3]xi64> 
    %18 = builtin.unrealized_conversion_cast %17 : vector<[3]xi64> to vector<[3]xindex>
    %19 = arith.muli %18, %arg1 : vector<[3]xindex>
    %20 = builtin.unrealized_conversion_cast %19 : vector<[3]xindex> to vector<[3]xi64>
    %21 = llvm.insertvalue %20, %11[1] : !llvm.array<2 x vector<[3]xi64>> 
    %22 = builtin.unrealized_conversion_cast %21 : !llvm.array<2 x vector<[3]xi64>> to vector<2x[3]xindex>
    return %22 : vector<2x[3]xindex>
  }
}

// -----
module {
  func.func @outerproduct_add(%arg0: vector<2xf32>, %arg1: vector<3xf32>, %arg2: vector<2x3xf32>) -> vector<2x3xf32> {
    %0 = builtin.unrealized_conversion_cast %arg2 : vector<2x3xf32> to !llvm.array<2 x vector<3xf32>>
    %cst = arith.constant dense<0.000000e+00> : vector<2x3xf32>
    %1 = builtin.unrealized_conversion_cast %cst : vector<2x3xf32> to !llvm.array<2 x vector<3xf32>>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.extractelement %arg0[%2 : i64] : vector<2xf32>
    %4 = llvm.mlir.poison : vector<3xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<3xf32>
    %7 = llvm.shufflevector %6, %4 [0, 0, 0] : vector<3xf32> 
    %8 = llvm.extractvalue %0[0] : !llvm.array<2 x vector<3xf32>> 
    %9 = llvm.intr.fmuladd(%7, %arg1, %8) : (vector<3xf32>, vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %10 = llvm.insertvalue %9, %1[0] : !llvm.array<2 x vector<3xf32>> 
    %11 = llvm.mlir.constant(1 : i64) : i64
    %12 = llvm.extractelement %arg0[%11 : i64] : vector<2xf32>
    %13 = llvm.mlir.poison : vector<3xf32>
    %14 = llvm.mlir.constant(0 : i32) : i32
    %15 = llvm.insertelement %12, %13[%14 : i32] : vector<3xf32>
    %16 = llvm.shufflevector %15, %13 [0, 0, 0] : vector<3xf32> 
    %17 = llvm.extractvalue %0[1] : !llvm.array<2 x vector<3xf32>> 
    %18 = llvm.intr.fmuladd(%16, %arg1, %17) : (vector<3xf32>, vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %19 = llvm.insertvalue %18, %10[1] : !llvm.array<2 x vector<3xf32>> 
    %20 = builtin.unrealized_conversion_cast %19 : !llvm.array<2 x vector<3xf32>> to vector<2x3xf32>
    return %20 : vector<2x3xf32>
  }
}

// -----
module {
  func.func @outerproduct_add_scalable(%arg0: vector<2xf32>, %arg1: vector<[3]xf32>, %arg2: vector<2x[3]xf32>) -> vector<2x[3]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg2 : vector<2x[3]xf32> to !llvm.array<2 x vector<[3]xf32>>
    %cst = arith.constant dense<0.000000e+00> : vector<2x[3]xf32>
    %1 = builtin.unrealized_conversion_cast %cst : vector<2x[3]xf32> to !llvm.array<2 x vector<[3]xf32>>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.extractelement %arg0[%2 : i64] : vector<2xf32>
    %4 = llvm.mlir.poison : vector<[3]xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<[3]xf32>
    %7 = llvm.shufflevector %6, %4 [0, 0, 0] : vector<[3]xf32> 
    %8 = llvm.extractvalue %0[0] : !llvm.array<2 x vector<[3]xf32>> 
    %9 = llvm.intr.fmuladd(%7, %arg1, %8) : (vector<[3]xf32>, vector<[3]xf32>, vector<[3]xf32>) -> vector<[3]xf32>
    %10 = llvm.insertvalue %9, %1[0] : !llvm.array<2 x vector<[3]xf32>> 
    %11 = llvm.mlir.constant(1 : i64) : i64
    %12 = llvm.extractelement %arg0[%11 : i64] : vector<2xf32>
    %13 = llvm.mlir.poison : vector<[3]xf32>
    %14 = llvm.mlir.constant(0 : i32) : i32
    %15 = llvm.insertelement %12, %13[%14 : i32] : vector<[3]xf32>
    %16 = llvm.shufflevector %15, %13 [0, 0, 0] : vector<[3]xf32> 
    %17 = llvm.extractvalue %0[1] : !llvm.array<2 x vector<[3]xf32>> 
    %18 = llvm.intr.fmuladd(%16, %arg1, %17) : (vector<[3]xf32>, vector<[3]xf32>, vector<[3]xf32>) -> vector<[3]xf32>
    %19 = llvm.insertvalue %18, %10[1] : !llvm.array<2 x vector<[3]xf32>> 
    %20 = builtin.unrealized_conversion_cast %19 : !llvm.array<2 x vector<[3]xf32>> to vector<2x[3]xf32>
    return %20 : vector<2x[3]xf32>
  }
}

// -----
module {
  func.func @masked_float_add_outerprod(%arg0: vector<2xf32>, %arg1: f32, %arg2: vector<2xf32>, %arg3: vector<2xi1>) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg1, %0[%1 : i32] : vector<2xf32>
    %3 = llvm.shufflevector %2, %0 [0, 0] : vector<2xf32> 
    %4 = llvm.intr.fmuladd(%arg0, %3, %arg2) : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %5 = arith.select %arg3, %4, %arg2 : vector<2xi1>, vector<2xf32>
    return %5 : vector<2xf32>
  }
}

// -----
module {
  func.func @masked_float_add_outerprod_scalable(%arg0: vector<[2]xf32>, %arg1: f32, %arg2: vector<[2]xf32>, %arg3: vector<[2]xi1>) -> vector<[2]xf32> {
    %0 = llvm.mlir.poison : vector<[2]xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg1, %0[%1 : i32] : vector<[2]xf32>
    %3 = llvm.shufflevector %2, %0 [0, 0] : vector<[2]xf32> 
    %4 = llvm.intr.fmuladd(%arg0, %3, %arg2) : (vector<[2]xf32>, vector<[2]xf32>, vector<[2]xf32>) -> vector<[2]xf32>
    %5 = arith.select %arg3, %4, %arg2 : vector<[2]xi1>, vector<[2]xf32>
    return %5 : vector<[2]xf32>
  }
}

// -----
module {
  func.func @masked_float_mul_outerprod(%arg0: vector<2xf32>, %arg1: f32, %arg2: vector<2xf32>, %arg3: vector<2xi1>) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg1, %0[%1 : i32] : vector<2xf32>
    %3 = llvm.shufflevector %2, %0 [0, 0] : vector<2xf32> 
    %4 = arith.mulf %arg0, %3 : vector<2xf32>
    %5 = arith.mulf %4, %arg2 : vector<2xf32>
    %6 = arith.select %arg3, %5, %arg2 : vector<2xi1>, vector<2xf32>
    return %6 : vector<2xf32>
  }
}

// -----
module {
  func.func @masked_float_mul_outerprod_scalable(%arg0: vector<[2]xf32>, %arg1: f32, %arg2: vector<[2]xf32>, %arg3: vector<[2]xi1>) -> vector<[2]xf32> {
    %0 = llvm.mlir.poison : vector<[2]xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg1, %0[%1 : i32] : vector<[2]xf32>
    %3 = llvm.shufflevector %2, %0 [0, 0] : vector<[2]xf32> 
    %4 = arith.mulf %arg0, %3 : vector<[2]xf32>
    %5 = arith.mulf %4, %arg2 : vector<[2]xf32>
    %6 = arith.select %arg3, %5, %arg2 : vector<[2]xi1>, vector<[2]xf32>
    return %6 : vector<[2]xf32>
  }
}

// -----
module {
  func.func @masked_float_max_outerprod(%arg0: vector<2xf32>, %arg1: f32, %arg2: vector<2xf32>, %arg3: vector<2xi1>) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg1, %0[%1 : i32] : vector<2xf32>
    %3 = llvm.shufflevector %2, %0 [0, 0] : vector<2xf32> 
    %4 = arith.mulf %arg0, %3 : vector<2xf32>
    %5 = arith.maxnumf %4, %arg2 : vector<2xf32>
    %6 = arith.select %arg3, %5, %arg2 : vector<2xi1>, vector<2xf32>
    return %6 : vector<2xf32>
  }
}

// -----
module {
  func.func @masked_float_max_outerprod_scalable(%arg0: vector<[2]xf32>, %arg1: f32, %arg2: vector<[2]xf32>, %arg3: vector<[2]xi1>) -> vector<[2]xf32> {
    %0 = llvm.mlir.poison : vector<[2]xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg1, %0[%1 : i32] : vector<[2]xf32>
    %3 = llvm.shufflevector %2, %0 [0, 0] : vector<[2]xf32> 
    %4 = arith.mulf %arg0, %3 : vector<[2]xf32>
    %5 = arith.maxnumf %4, %arg2 : vector<[2]xf32>
    %6 = arith.select %arg3, %5, %arg2 : vector<[2]xi1>, vector<[2]xf32>
    return %6 : vector<[2]xf32>
  }
}

// -----
module {
  func.func @masked_float_min_outerprod(%arg0: vector<2xf32>, %arg1: f32, %arg2: vector<2xf32>, %arg3: vector<2xi1>) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg1, %0[%1 : i32] : vector<2xf32>
    %3 = llvm.shufflevector %2, %0 [0, 0] : vector<2xf32> 
    %4 = arith.mulf %arg0, %3 : vector<2xf32>
    %5 = arith.minnumf %4, %arg2 : vector<2xf32>
    %6 = arith.select %arg3, %5, %arg2 : vector<2xi1>, vector<2xf32>
    return %6 : vector<2xf32>
  }
}

// -----
module {
  func.func @masked_float_min_outerprod_scalable(%arg0: vector<[2]xf32>, %arg1: f32, %arg2: vector<[2]xf32>, %arg3: vector<[2]xi1>) -> vector<[2]xf32> {
    %0 = llvm.mlir.poison : vector<[2]xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg1, %0[%1 : i32] : vector<[2]xf32>
    %3 = llvm.shufflevector %2, %0 [0, 0] : vector<[2]xf32> 
    %4 = arith.mulf %arg0, %3 : vector<[2]xf32>
    %5 = arith.minnumf %4, %arg2 : vector<[2]xf32>
    %6 = arith.select %arg3, %5, %arg2 : vector<[2]xi1>, vector<[2]xf32>
    return %6 : vector<[2]xf32>
  }
}

// -----
module {
  func.func @masked_int_add_outerprod(%arg0: vector<2xi32>, %arg1: i32, %arg2: vector<2xi32>, %arg3: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg1, %0[%1 : i32] : vector<2xi32>
    %3 = llvm.shufflevector %2, %0 [0, 0] : vector<2xi32> 
    %4 = arith.muli %arg0, %3 : vector<2xi32>
    %5 = arith.addi %4, %arg2 : vector<2xi32>
    %6 = arith.select %arg3, %5, %arg2 : vector<2xi1>, vector<2xi32>
    return %6 : vector<2xi32>
  }
}

// -----
module {
  func.func @masked_int_add_outerprod_scalable(%arg0: vector<[2]xi32>, %arg1: i32, %arg2: vector<[2]xi32>, %arg3: vector<[2]xi1>) -> vector<[2]xi32> {
    %0 = llvm.mlir.poison : vector<[2]xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg1, %0[%1 : i32] : vector<[2]xi32>
    %3 = llvm.shufflevector %2, %0 [0, 0] : vector<[2]xi32> 
    %4 = arith.muli %arg0, %3 : vector<[2]xi32>
    %5 = arith.addi %4, %arg2 : vector<[2]xi32>
    %6 = arith.select %arg3, %5, %arg2 : vector<[2]xi1>, vector<[2]xi32>
    return %6 : vector<[2]xi32>
  }
}

// -----
module {
  func.func @masked_int_mul_outerprod(%arg0: vector<2xi32>, %arg1: i32, %arg2: vector<2xi32>, %arg3: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg1, %0[%1 : i32] : vector<2xi32>
    %3 = llvm.shufflevector %2, %0 [0, 0] : vector<2xi32> 
    %4 = arith.muli %arg0, %3 : vector<2xi32>
    %5 = arith.muli %4, %arg2 : vector<2xi32>
    %6 = arith.select %arg3, %5, %arg2 : vector<2xi1>, vector<2xi32>
    return %6 : vector<2xi32>
  }
}

// -----
module {
  func.func @masked_int_mul_outerprod_scalable(%arg0: vector<[2]xi32>, %arg1: i32, %arg2: vector<[2]xi32>, %arg3: vector<[2]xi1>) -> vector<[2]xi32> {
    %0 = llvm.mlir.poison : vector<[2]xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg1, %0[%1 : i32] : vector<[2]xi32>
    %3 = llvm.shufflevector %2, %0 [0, 0] : vector<[2]xi32> 
    %4 = arith.muli %arg0, %3 : vector<[2]xi32>
    %5 = arith.muli %4, %arg2 : vector<[2]xi32>
    %6 = arith.select %arg3, %5, %arg2 : vector<[2]xi1>, vector<[2]xi32>
    return %6 : vector<[2]xi32>
  }
}

// -----
module {
  func.func @masked_int_max_outerprod(%arg0: vector<2xi32>, %arg1: i32, %arg2: vector<2xi32>, %arg3: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg1, %0[%1 : i32] : vector<2xi32>
    %3 = llvm.shufflevector %2, %0 [0, 0] : vector<2xi32> 
    %4 = arith.muli %arg0, %3 : vector<2xi32>
    %5 = arith.maxsi %4, %arg2 : vector<2xi32>
    %6 = arith.select %arg3, %5, %arg2 : vector<2xi1>, vector<2xi32>
    return %6 : vector<2xi32>
  }
}

// -----
module {
  func.func @masked_int_max_outerprod_scalable(%arg0: vector<[2]xi32>, %arg1: i32, %arg2: vector<[2]xi32>, %arg3: vector<[2]xi1>) -> vector<[2]xi32> {
    %0 = llvm.mlir.poison : vector<[2]xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg1, %0[%1 : i32] : vector<[2]xi32>
    %3 = llvm.shufflevector %2, %0 [0, 0] : vector<[2]xi32> 
    %4 = arith.muli %arg0, %3 : vector<[2]xi32>
    %5 = arith.maxsi %4, %arg2 : vector<[2]xi32>
    %6 = arith.select %arg3, %5, %arg2 : vector<[2]xi1>, vector<[2]xi32>
    return %6 : vector<[2]xi32>
  }
}

// -----
module {
  func.func @masked_int_min_outerprod(%arg0: vector<2xi32>, %arg1: i32, %arg2: vector<2xi32>, %arg3: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg1, %0[%1 : i32] : vector<2xi32>
    %3 = llvm.shufflevector %2, %0 [0, 0] : vector<2xi32> 
    %4 = arith.muli %arg0, %3 : vector<2xi32>
    %5 = arith.minui %4, %arg2 : vector<2xi32>
    %6 = arith.select %arg3, %5, %arg2 : vector<2xi1>, vector<2xi32>
    return %6 : vector<2xi32>
  }
}

// -----
module {
  func.func @masked_int_min_outerprod_scalable(%arg0: vector<[2]xi32>, %arg1: i32, %arg2: vector<[2]xi32>, %arg3: vector<[2]xi1>) -> vector<[2]xi32> {
    %0 = llvm.mlir.poison : vector<[2]xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg1, %0[%1 : i32] : vector<[2]xi32>
    %3 = llvm.shufflevector %2, %0 [0, 0] : vector<[2]xi32> 
    %4 = arith.muli %arg0, %3 : vector<[2]xi32>
    %5 = arith.minui %4, %arg2 : vector<[2]xi32>
    %6 = arith.select %arg3, %5, %arg2 : vector<[2]xi1>, vector<[2]xi32>
    return %6 : vector<[2]xi32>
  }
}

// -----
module {
  func.func @masked_int_and_outerprod(%arg0: vector<2xi32>, %arg1: i32, %arg2: vector<2xi32>, %arg3: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg1, %0[%1 : i32] : vector<2xi32>
    %3 = llvm.shufflevector %2, %0 [0, 0] : vector<2xi32> 
    %4 = arith.muli %arg0, %3 : vector<2xi32>
    %5 = arith.andi %4, %arg2 : vector<2xi32>
    %6 = arith.select %arg3, %5, %arg2 : vector<2xi1>, vector<2xi32>
    return %6 : vector<2xi32>
  }
}

// -----
module {
  func.func @masked_int_and_outerprod_scalable(%arg0: vector<[2]xi32>, %arg1: i32, %arg2: vector<[2]xi32>, %arg3: vector<[2]xi1>) -> vector<[2]xi32> {
    %0 = llvm.mlir.poison : vector<[2]xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg1, %0[%1 : i32] : vector<[2]xi32>
    %3 = llvm.shufflevector %2, %0 [0, 0] : vector<[2]xi32> 
    %4 = arith.muli %arg0, %3 : vector<[2]xi32>
    %5 = arith.andi %4, %arg2 : vector<[2]xi32>
    %6 = arith.select %arg3, %5, %arg2 : vector<[2]xi1>, vector<[2]xi32>
    return %6 : vector<[2]xi32>
  }
}

// -----
module {
  func.func @masked_int_or_outerprod(%arg0: vector<2xi32>, %arg1: i32, %arg2: vector<2xi32>, %arg3: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg1, %0[%1 : i32] : vector<2xi32>
    %3 = llvm.shufflevector %2, %0 [0, 0] : vector<2xi32> 
    %4 = arith.muli %arg0, %3 : vector<2xi32>
    %5 = arith.ori %4, %arg2 : vector<2xi32>
    %6 = arith.select %arg3, %5, %arg2 : vector<2xi1>, vector<2xi32>
    return %6 : vector<2xi32>
  }
}

// -----
module {
  func.func @masked_int_or_outerprod_scalable(%arg0: vector<[2]xi32>, %arg1: i32, %arg2: vector<[2]xi32>, %arg3: vector<[2]xi1>) -> vector<[2]xi32> {
    %0 = llvm.mlir.poison : vector<[2]xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg1, %0[%1 : i32] : vector<[2]xi32>
    %3 = llvm.shufflevector %2, %0 [0, 0] : vector<[2]xi32> 
    %4 = arith.muli %arg0, %3 : vector<[2]xi32>
    %5 = arith.ori %4, %arg2 : vector<[2]xi32>
    %6 = arith.select %arg3, %5, %arg2 : vector<[2]xi1>, vector<[2]xi32>
    return %6 : vector<[2]xi32>
  }
}

// -----
module {
  func.func @extract_scalar_from_vec_1d_f32_poison_idx(%arg0: vector<16xf32>) -> f32 {
    %0 = ub.poison : f32
    return %0 : f32
  }
}

// -----
module {
  func.func @extract_vec_2d_from_vec_3d_f32_poison_idx(%arg0: vector<4x3x16xf32>) -> vector<3x16xf32> {
    %0 = ub.poison : vector<3x16xf32>
    return %0 : vector<3x16xf32>
  }
}

// -----
module {
  llvm.func @printNewline()
  llvm.func @printI64(i64)
  func.func @print_scalar_i1(%arg0: i1) {
    %0 = arith.extui %arg0 : i1 to i64
    llvm.call @printI64(%0) : (i64) -> ()
    llvm.call @printNewline() : () -> ()
    return
  }
}

// -----
module {
  llvm.func @printNewline()
  llvm.func @printI64(i64)
  func.func @print_scalar_i4(%arg0: i4) {
    %0 = arith.extsi %arg0 : i4 to i64
    llvm.call @printI64(%0) : (i64) -> ()
    llvm.call @printNewline() : () -> ()
    return
  }
}

// -----
module {
  llvm.func @printNewline()
  llvm.func @printI64(i64)
  func.func @print_scalar_si4(%arg0: si4) {
    %0 = builtin.unrealized_conversion_cast %arg0 : si4 to i4
    %1 = arith.extsi %0 : i4 to i64
    llvm.call @printI64(%1) : (i64) -> ()
    llvm.call @printNewline() : () -> ()
    return
  }
}

// -----
module {
  llvm.func @printNewline()
  llvm.func @printU64(i64)
  func.func @print_scalar_ui4(%arg0: ui4) {
    %0 = builtin.unrealized_conversion_cast %arg0 : ui4 to i4
    %1 = arith.extui %0 : i4 to i64
    llvm.call @printU64(%1) : (i64) -> ()
    llvm.call @printNewline() : () -> ()
    return
  }
}

// -----
module {
  llvm.func @printNewline()
  llvm.func @printI64(i64)
  func.func @print_scalar_i32(%arg0: i32) {
    %0 = arith.extsi %arg0 : i32 to i64
    llvm.call @printI64(%0) : (i64) -> ()
    llvm.call @printNewline() : () -> ()
    return
  }
}

// -----
module {
  llvm.func @printNewline()
  llvm.func @printU64(i64)
  func.func @print_scalar_ui32(%arg0: ui32) {
    %0 = builtin.unrealized_conversion_cast %arg0 : ui32 to i32
    %1 = arith.extui %0 : i32 to i64
    llvm.call @printU64(%1) : (i64) -> ()
    llvm.call @printNewline() : () -> ()
    return
  }
}

// -----
module {
  llvm.func @printNewline()
  llvm.func @printI64(i64)
  func.func @print_scalar_i40(%arg0: i40) {
    %0 = arith.extsi %arg0 : i40 to i64
    llvm.call @printI64(%0) : (i64) -> ()
    llvm.call @printNewline() : () -> ()
    return
  }
}

// -----
module {
  llvm.func @printNewline()
  llvm.func @printI64(i64)
  func.func @print_scalar_si40(%arg0: si40) {
    %0 = builtin.unrealized_conversion_cast %arg0 : si40 to i40
    %1 = arith.extsi %0 : i40 to i64
    llvm.call @printI64(%1) : (i64) -> ()
    llvm.call @printNewline() : () -> ()
    return
  }
}

// -----
module {
  llvm.func @printNewline()
  llvm.func @printU64(i64)
  func.func @print_scalar_ui40(%arg0: ui40) {
    %0 = builtin.unrealized_conversion_cast %arg0 : ui40 to i40
    %1 = arith.extui %0 : i40 to i64
    llvm.call @printU64(%1) : (i64) -> ()
    llvm.call @printNewline() : () -> ()
    return
  }
}

// -----
module {
  func.func @extract_strided_slice_f32_1d_from_1d(%arg0: vector<4xf32>) -> vector<2xf32> {
    %0 = llvm.shufflevector %arg0, %arg0 [2, 3] : vector<4xf32> 
    return %0 : vector<2xf32>
  }
}

// -----
module {
  func.func @extract_strided_slice_index_1d_from_1d(%arg0: vector<4xindex>) -> vector<2xindex> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4xindex> to vector<4xi64>
    %1 = llvm.shufflevector %0, %0 [2, 3] : vector<4xi64> 
    %2 = builtin.unrealized_conversion_cast %1 : vector<2xi64> to vector<2xindex>
    return %2 : vector<2xindex>
  }
}

// -----
module {
  func.func @extract_strided_slice_f32_1d_from_2d(%arg0: vector<4x8xf32>) -> vector<2x8xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4x8xf32> to !llvm.array<4 x vector<8xf32>>
    %1 = llvm.mlir.poison : !llvm.array<2 x vector<8xf32>>
    %2 = llvm.extractvalue %0[2] : !llvm.array<4 x vector<8xf32>> 
    %3 = llvm.insertvalue %2, %1[0] : !llvm.array<2 x vector<8xf32>> 
    %4 = llvm.extractvalue %0[3] : !llvm.array<4 x vector<8xf32>> 
    %5 = llvm.insertvalue %4, %3[1] : !llvm.array<2 x vector<8xf32>> 
    %6 = builtin.unrealized_conversion_cast %5 : !llvm.array<2 x vector<8xf32>> to vector<2x8xf32>
    return %6 : vector<2x8xf32>
  }
}

// -----
module {
  func.func @extract_strided_slice_f32_1d_from_2d_scalable(%arg0: vector<4x[8]xf32>) -> vector<2x[8]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4x[8]xf32> to !llvm.array<4 x vector<[8]xf32>>
    %cst = arith.constant dense<0.000000e+00> : vector<2x[8]xf32>
    %1 = builtin.unrealized_conversion_cast %cst : vector<2x[8]xf32> to !llvm.array<2 x vector<[8]xf32>>
    %2 = llvm.extractvalue %0[2] : !llvm.array<4 x vector<[8]xf32>> 
    %3 = llvm.extractvalue %0[3] : !llvm.array<4 x vector<[8]xf32>> 
    %4 = llvm.insertvalue %2, %1[0] : !llvm.array<2 x vector<[8]xf32>> 
    %5 = llvm.insertvalue %3, %4[1] : !llvm.array<2 x vector<[8]xf32>> 
    %6 = builtin.unrealized_conversion_cast %5 : !llvm.array<2 x vector<[8]xf32>> to vector<2x[8]xf32>
    return %6 : vector<2x[8]xf32>
  }
}

// -----
module {
  func.func @extract_strided_slice_f32_2d_from_2d(%arg0: vector<4x8xf32>) -> vector<2x2xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4x8xf32> to !llvm.array<4 x vector<8xf32>>
    %cst = arith.constant dense<0.000000e+00> : vector<2x2xf32>
    %1 = builtin.unrealized_conversion_cast %cst : vector<2x2xf32> to !llvm.array<2 x vector<2xf32>>
    %2 = llvm.extractvalue %0[2] : !llvm.array<4 x vector<8xf32>> 
    %3 = llvm.shufflevector %2, %2 [2, 3] : vector<8xf32> 
    %4 = llvm.insertvalue %3, %1[0] : !llvm.array<2 x vector<2xf32>> 
    %5 = llvm.extractvalue %0[3] : !llvm.array<4 x vector<8xf32>> 
    %6 = llvm.shufflevector %5, %5 [2, 3] : vector<8xf32> 
    %7 = llvm.insertvalue %6, %4[1] : !llvm.array<2 x vector<2xf32>> 
    %8 = builtin.unrealized_conversion_cast %7 : !llvm.array<2 x vector<2xf32>> to vector<2x2xf32>
    return %8 : vector<2x2xf32>
  }
}

// -----
module {
  func.func @extract_strided_slice_f32_2d_from_2d_scalable(%arg0: vector<4x[8]xf32>) -> vector<2x[8]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4x[8]xf32> to !llvm.array<4 x vector<[8]xf32>>
    %cst = arith.constant dense<0.000000e+00> : vector<2x[8]xf32>
    %1 = builtin.unrealized_conversion_cast %cst : vector<2x[8]xf32> to !llvm.array<2 x vector<[8]xf32>>
    %2 = llvm.extractvalue %0[2] : !llvm.array<4 x vector<[8]xf32>> 
    %3 = llvm.insertvalue %2, %1[0] : !llvm.array<2 x vector<[8]xf32>> 
    %4 = llvm.extractvalue %0[3] : !llvm.array<4 x vector<[8]xf32>> 
    %5 = llvm.insertvalue %4, %3[1] : !llvm.array<2 x vector<[8]xf32>> 
    %6 = builtin.unrealized_conversion_cast %5 : !llvm.array<2 x vector<[8]xf32>> to vector<2x[8]xf32>
    return %6 : vector<2x[8]xf32>
  }
}

// -----
module {
  func.func @insert_strided_slice_f32_2d_into_3d(%arg0: vector<4x4xf32>, %arg1: vector<4x4x4xf32>) -> vector<4x4x4xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4x4x4xf32> to !llvm.array<4 x array<4 x vector<4xf32>>>
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<4x4xf32> to !llvm.array<4 x vector<4xf32>>
    %2 = llvm.insertvalue %1, %0[2] : !llvm.array<4 x array<4 x vector<4xf32>>> 
    %3 = builtin.unrealized_conversion_cast %2 : !llvm.array<4 x array<4 x vector<4xf32>>> to vector<4x4x4xf32>
    return %3 : vector<4x4x4xf32>
  }
}

// -----
module {
  func.func @insert_strided_slice_f32_2d_into_3d_scalable(%arg0: vector<4x[4]xf32>, %arg1: vector<4x4x[4]xf32>) -> vector<4x4x[4]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4x4x[4]xf32> to !llvm.array<4 x array<4 x vector<[4]xf32>>>
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<4x[4]xf32> to !llvm.array<4 x vector<[4]xf32>>
    %2 = llvm.insertvalue %1, %0[2] : !llvm.array<4 x array<4 x vector<[4]xf32>>> 
    %3 = builtin.unrealized_conversion_cast %2 : !llvm.array<4 x array<4 x vector<[4]xf32>>> to vector<4x4x[4]xf32>
    return %3 : vector<4x4x[4]xf32>
  }
}

// -----
module {
  func.func @insert_strided_index_slice_index_2d_into_3d(%arg0: vector<4x4xindex>, %arg1: vector<4x4x4xindex>) -> vector<4x4x4xindex> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4x4x4xindex> to !llvm.array<4 x array<4 x vector<4xi64>>>
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<4x4xindex> to !llvm.array<4 x vector<4xi64>>
    %2 = llvm.insertvalue %1, %0[2] : !llvm.array<4 x array<4 x vector<4xi64>>> 
    %3 = builtin.unrealized_conversion_cast %2 : !llvm.array<4 x array<4 x vector<4xi64>>> to vector<4x4x4xindex>
    return %3 : vector<4x4x4xindex>
  }
}

// -----
module {
  func.func @insert_strided_index_slice_index_2d_into_3d_scalable(%arg0: vector<4x[4]xindex>, %arg1: vector<4x4x[4]xindex>) -> vector<4x4x[4]xindex> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4x4x[4]xindex> to !llvm.array<4 x array<4 x vector<[4]xi64>>>
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<4x[4]xindex> to !llvm.array<4 x vector<[4]xi64>>
    %2 = llvm.insertvalue %1, %0[2] : !llvm.array<4 x array<4 x vector<[4]xi64>>> 
    %3 = builtin.unrealized_conversion_cast %2 : !llvm.array<4 x array<4 x vector<[4]xi64>>> to vector<4x4x[4]xindex>
    return %3 : vector<4x4x[4]xindex>
  }
}

// -----
module {
  func.func @insert_strided_slice_f32_2d_into_2d(%arg0: vector<2x2xf32>, %arg1: vector<4x4xf32>) -> vector<4x4xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4x4xf32> to !llvm.array<4 x vector<4xf32>>
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<2x2xf32> to !llvm.array<2 x vector<2xf32>>
    %2 = llvm.extractvalue %1[0] : !llvm.array<2 x vector<2xf32>> 
    %3 = llvm.extractvalue %0[2] : !llvm.array<4 x vector<4xf32>> 
    %4 = llvm.shufflevector %2, %2 [0, 1, 0, 0] : vector<2xf32> 
    %5 = llvm.shufflevector %4, %3 [4, 5, 0, 1] : vector<4xf32> 
    %6 = llvm.insertvalue %5, %0[2] : !llvm.array<4 x vector<4xf32>> 
    %7 = llvm.extractvalue %1[1] : !llvm.array<2 x vector<2xf32>> 
    %8 = llvm.extractvalue %0[3] : !llvm.array<4 x vector<4xf32>> 
    %9 = llvm.shufflevector %7, %7 [0, 1, 0, 0] : vector<2xf32> 
    %10 = llvm.shufflevector %9, %8 [4, 5, 0, 1] : vector<4xf32> 
    %11 = llvm.insertvalue %10, %6[3] : !llvm.array<4 x vector<4xf32>> 
    %12 = builtin.unrealized_conversion_cast %11 : !llvm.array<4 x vector<4xf32>> to vector<4x4xf32>
    return %12 : vector<4x4xf32>
  }
}

// -----
module {
  func.func @insert_strided_slice_f32_2d_into_2d_scalable(%arg0: vector<2x[2]xf32>, %arg1: vector<4x[2]xf32>) -> vector<4x[2]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4x[2]xf32> to !llvm.array<4 x vector<[2]xf32>>
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<2x[2]xf32> to !llvm.array<2 x vector<[2]xf32>>
    %2 = llvm.extractvalue %1[0] : !llvm.array<2 x vector<[2]xf32>> 
    %3 = llvm.insertvalue %2, %0[2] : !llvm.array<4 x vector<[2]xf32>> 
    %4 = llvm.extractvalue %1[1] : !llvm.array<2 x vector<[2]xf32>> 
    %5 = llvm.insertvalue %4, %3[3] : !llvm.array<4 x vector<[2]xf32>> 
    %6 = builtin.unrealized_conversion_cast %5 : !llvm.array<4 x vector<[2]xf32>> to vector<4x[2]xf32>
    return %6 : vector<4x[2]xf32>
  }
}

// -----
module {
  func.func @insert_strided_slice_f32_2d_into_3d(%arg0: vector<2x4xf32>, %arg1: vector<16x4x8xf32>) -> vector<16x4x8xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2x4xf32> to !llvm.array<2 x vector<4xf32>>
    %1 = builtin.unrealized_conversion_cast %arg1 : vector<16x4x8xf32> to !llvm.array<16 x array<4 x vector<8xf32>>>
    %2 = llvm.extractvalue %1[0] : !llvm.array<16 x array<4 x vector<8xf32>>> 
    %3 = llvm.extractvalue %0[0] : !llvm.array<2 x vector<4xf32>> 
    %4 = llvm.extractvalue %1[0, 0] : !llvm.array<16 x array<4 x vector<8xf32>>> 
    %5 = llvm.shufflevector %3, %3 [0, 1, 2, 3, 0, 0, 0, 0] : vector<4xf32> 
    %6 = llvm.shufflevector %5, %4 [8, 9, 0, 1, 2, 3, 14, 15] : vector<8xf32> 
    %7 = llvm.insertvalue %6, %2[0] : !llvm.array<4 x vector<8xf32>> 
    %8 = llvm.extractvalue %0[1] : !llvm.array<2 x vector<4xf32>> 
    %9 = llvm.extractvalue %1[0, 1] : !llvm.array<16 x array<4 x vector<8xf32>>> 
    %10 = llvm.shufflevector %8, %8 [0, 1, 2, 3, 0, 0, 0, 0] : vector<4xf32> 
    %11 = llvm.shufflevector %10, %9 [8, 9, 0, 1, 2, 3, 14, 15] : vector<8xf32> 
    %12 = llvm.insertvalue %11, %7[1] : !llvm.array<4 x vector<8xf32>> 
    %13 = llvm.insertvalue %12, %1[0] : !llvm.array<16 x array<4 x vector<8xf32>>> 
    %14 = builtin.unrealized_conversion_cast %13 : !llvm.array<16 x array<4 x vector<8xf32>>> to vector<16x4x8xf32>
    return %14 : vector<16x4x8xf32>
  }
}

// -----
module {
  func.func @insert_strided_slice_f32_2d_into_3d_scalable(%arg0: vector<2x[4]xf32>, %arg1: vector<16x4x[4]xf32>) -> vector<16x4x[4]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2x[4]xf32> to !llvm.array<2 x vector<[4]xf32>>
    %1 = builtin.unrealized_conversion_cast %arg1 : vector<16x4x[4]xf32> to !llvm.array<16 x array<4 x vector<[4]xf32>>>
    %2 = llvm.extractvalue %1[3] : !llvm.array<16 x array<4 x vector<[4]xf32>>> 
    %3 = llvm.extractvalue %0[0] : !llvm.array<2 x vector<[4]xf32>> 
    %4 = llvm.insertvalue %3, %2[2] : !llvm.array<4 x vector<[4]xf32>> 
    %5 = llvm.extractvalue %0[1] : !llvm.array<2 x vector<[4]xf32>> 
    %6 = llvm.insertvalue %5, %4[3] : !llvm.array<4 x vector<[4]xf32>> 
    %7 = llvm.insertvalue %6, %1[3] : !llvm.array<16 x array<4 x vector<[4]xf32>>> 
    %8 = builtin.unrealized_conversion_cast %7 : !llvm.array<16 x array<4 x vector<[4]xf32>>> to vector<16x4x[4]xf32>
    return %8 : vector<16x4x[4]xf32>
  }
}

// -----
module {
  func.func @fma(%arg0: vector<8xf32>, %arg1: vector<2x4xf32>, %arg2: vector<1x1x1xf32>, %arg3: vector<f32>) -> (vector<8xf32>, vector<2x4xf32>, vector<1x1x1xf32>, vector<f32>) {
    %0 = builtin.unrealized_conversion_cast %arg3 : vector<f32> to vector<1xf32>
    %1 = builtin.unrealized_conversion_cast %arg2 : vector<1x1x1xf32> to !llvm.array<1 x array<1 x vector<1xf32>>>
    %2 = builtin.unrealized_conversion_cast %arg1 : vector<2x4xf32> to !llvm.array<2 x vector<4xf32>>
    %cst = arith.constant dense<0.000000e+00> : vector<1x1xf32>
    %3 = builtin.unrealized_conversion_cast %cst : vector<1x1xf32> to !llvm.array<1 x vector<1xf32>>
    %cst_0 = arith.constant dense<0.000000e+00> : vector<1x1x1xf32>
    %4 = builtin.unrealized_conversion_cast %cst_0 : vector<1x1x1xf32> to !llvm.array<1 x array<1 x vector<1xf32>>>
    %cst_1 = arith.constant dense<0.000000e+00> : vector<2x4xf32>
    %5 = builtin.unrealized_conversion_cast %cst_1 : vector<2x4xf32> to !llvm.array<2 x vector<4xf32>>
    %6 = llvm.intr.fmuladd(%arg0, %arg0, %arg0) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %7 = llvm.extractvalue %2[0] : !llvm.array<2 x vector<4xf32>> 
    %8 = llvm.extractvalue %2[0] : !llvm.array<2 x vector<4xf32>> 
    %9 = llvm.extractvalue %2[0] : !llvm.array<2 x vector<4xf32>> 
    %10 = llvm.intr.fmuladd(%7, %8, %9) : (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %11 = llvm.insertvalue %10, %5[0] : !llvm.array<2 x vector<4xf32>> 
    %12 = llvm.extractvalue %2[1] : !llvm.array<2 x vector<4xf32>> 
    %13 = llvm.extractvalue %2[1] : !llvm.array<2 x vector<4xf32>> 
    %14 = llvm.extractvalue %2[1] : !llvm.array<2 x vector<4xf32>> 
    %15 = llvm.intr.fmuladd(%12, %13, %14) : (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %16 = llvm.insertvalue %15, %11[1] : !llvm.array<2 x vector<4xf32>> 
    %17 = builtin.unrealized_conversion_cast %16 : !llvm.array<2 x vector<4xf32>> to vector<2x4xf32>
    %18 = llvm.extractvalue %1[0, 0] : !llvm.array<1 x array<1 x vector<1xf32>>> 
    %19 = llvm.extractvalue %1[0, 0] : !llvm.array<1 x array<1 x vector<1xf32>>> 
    %20 = llvm.extractvalue %1[0, 0] : !llvm.array<1 x array<1 x vector<1xf32>>> 
    %21 = llvm.intr.fmuladd(%18, %19, %20) : (vector<1xf32>, vector<1xf32>, vector<1xf32>) -> vector<1xf32>
    %22 = llvm.insertvalue %21, %3[0] : !llvm.array<1 x vector<1xf32>> 
    %23 = llvm.insertvalue %22, %4[0] : !llvm.array<1 x array<1 x vector<1xf32>>> 
    %24 = builtin.unrealized_conversion_cast %23 : !llvm.array<1 x array<1 x vector<1xf32>>> to vector<1x1x1xf32>
    %25 = llvm.intr.fmuladd(%0, %0, %0) : (vector<1xf32>, vector<1xf32>, vector<1xf32>) -> vector<1xf32>
    %26 = builtin.unrealized_conversion_cast %25 : vector<1xf32> to vector<f32>
    return %6, %17, %24, %26 : vector<8xf32>, vector<2x4xf32>, vector<1x1x1xf32>, vector<f32>
  }
}

// -----
module {
  func.func @fma_scalable(%arg0: vector<[8]xf32>, %arg1: vector<2x[4]xf32>, %arg2: vector<1x1x[1]xf32>, %arg3: vector<f32>) -> (vector<[8]xf32>, vector<2x[4]xf32>, vector<1x1x[1]xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg2 : vector<1x1x[1]xf32> to !llvm.array<1 x array<1 x vector<[1]xf32>>>
    %1 = builtin.unrealized_conversion_cast %arg1 : vector<2x[4]xf32> to !llvm.array<2 x vector<[4]xf32>>
    %cst = arith.constant dense<0.000000e+00> : vector<1x[1]xf32>
    %2 = builtin.unrealized_conversion_cast %cst : vector<1x[1]xf32> to !llvm.array<1 x vector<[1]xf32>>
    %cst_0 = arith.constant dense<0.000000e+00> : vector<1x1x[1]xf32>
    %3 = builtin.unrealized_conversion_cast %cst_0 : vector<1x1x[1]xf32> to !llvm.array<1 x array<1 x vector<[1]xf32>>>
    %cst_1 = arith.constant dense<0.000000e+00> : vector<2x[4]xf32>
    %4 = builtin.unrealized_conversion_cast %cst_1 : vector<2x[4]xf32> to !llvm.array<2 x vector<[4]xf32>>
    %5 = llvm.intr.fmuladd(%arg0, %arg0, %arg0) : (vector<[8]xf32>, vector<[8]xf32>, vector<[8]xf32>) -> vector<[8]xf32>
    %6 = llvm.extractvalue %1[0] : !llvm.array<2 x vector<[4]xf32>> 
    %7 = llvm.extractvalue %1[0] : !llvm.array<2 x vector<[4]xf32>> 
    %8 = llvm.extractvalue %1[0] : !llvm.array<2 x vector<[4]xf32>> 
    %9 = llvm.intr.fmuladd(%6, %7, %8) : (vector<[4]xf32>, vector<[4]xf32>, vector<[4]xf32>) -> vector<[4]xf32>
    %10 = llvm.insertvalue %9, %4[0] : !llvm.array<2 x vector<[4]xf32>> 
    %11 = llvm.extractvalue %1[1] : !llvm.array<2 x vector<[4]xf32>> 
    %12 = llvm.extractvalue %1[1] : !llvm.array<2 x vector<[4]xf32>> 
    %13 = llvm.extractvalue %1[1] : !llvm.array<2 x vector<[4]xf32>> 
    %14 = llvm.intr.fmuladd(%11, %12, %13) : (vector<[4]xf32>, vector<[4]xf32>, vector<[4]xf32>) -> vector<[4]xf32>
    %15 = llvm.insertvalue %14, %10[1] : !llvm.array<2 x vector<[4]xf32>> 
    %16 = builtin.unrealized_conversion_cast %15 : !llvm.array<2 x vector<[4]xf32>> to vector<2x[4]xf32>
    %17 = llvm.extractvalue %0[0, 0] : !llvm.array<1 x array<1 x vector<[1]xf32>>> 
    %18 = llvm.extractvalue %0[0, 0] : !llvm.array<1 x array<1 x vector<[1]xf32>>> 
    %19 = llvm.extractvalue %0[0, 0] : !llvm.array<1 x array<1 x vector<[1]xf32>>> 
    %20 = llvm.intr.fmuladd(%17, %18, %19) : (vector<[1]xf32>, vector<[1]xf32>, vector<[1]xf32>) -> vector<[1]xf32>
    %21 = llvm.insertvalue %20, %2[0] : !llvm.array<1 x vector<[1]xf32>> 
    %22 = llvm.insertvalue %21, %3[0] : !llvm.array<1 x array<1 x vector<[1]xf32>>> 
    %23 = builtin.unrealized_conversion_cast %22 : !llvm.array<1 x array<1 x vector<[1]xf32>>> to vector<1x1x[1]xf32>
    return %5, %16, %23 : vector<[8]xf32>, vector<2x[4]xf32>, vector<1x1x[1]xf32>
  }
}

// -----
module {
  func.func @constant_mask_0d_f() -> vector<i1> {
    %cst = arith.constant dense<false> : vector<i1>
    return %cst : vector<i1>
  }
}

// -----
module {
  func.func @constant_mask_0d_t() -> vector<i1> {
    %cst = arith.constant dense<true> : vector<i1>
    return %cst : vector<i1>
  }
}

// -----
module {
  func.func @constant_mask_1d() -> vector<8xi1> {
    %cst = arith.constant dense<[true, true, true, true, false, false, false, false]> : vector<8xi1>
    return %cst : vector<8xi1>
  }
}

// -----
module {
  func.func @constant_mask_1d_scalable_all_false() -> vector<[8]xi1> {
    %cst = arith.constant dense<false> : vector<[8]xi1>
    return %cst : vector<[8]xi1>
  }
}

// -----
module {
  func.func @constant_mask_1d_scalable_all_true() -> vector<[8]xi1> {
    %cst = arith.constant dense<true> : vector<[8]xi1>
    return %cst : vector<[8]xi1>
  }
}

// -----
module {
  func.func @constant_mask_2d() -> vector<4x4xi1> {
    %cst = arith.constant dense<[[true, true, false, false], [true, true, false, false], [false, false, false, false], [false, false, false, false]]> : vector<4x4xi1>
    return %cst : vector<4x4xi1>
  }
}

// -----
module {
  func.func @constant_mask_2d_trailing_scalable() -> vector<4x[4]xi1> {
    %cst = arith.constant dense<true> : vector<[4]xi1>
    %cst_0 = arith.constant dense<false> : vector<4x[4]xi1>
    %0 = builtin.unrealized_conversion_cast %cst_0 : vector<4x[4]xi1> to !llvm.array<4 x vector<[4]xi1>>
    %1 = llvm.insertvalue %cst, %0[0] : !llvm.array<4 x vector<[4]xi1>> 
    %2 = llvm.insertvalue %cst, %1[1] : !llvm.array<4 x vector<[4]xi1>> 
    %3 = builtin.unrealized_conversion_cast %2 : !llvm.array<4 x vector<[4]xi1>> to vector<4x[4]xi1>
    return %3 : vector<4x[4]xi1>
  }
}

// -----
module {
  func.func @negative_constant_mask_2d_leading_scalable() -> vector<[4]x4xi1> {
    %0 = vector.constant_mask [4, 2] : vector<[4]x4xi1>
    return %0 : vector<[4]x4xi1>
  }
}

// -----
module {
  func.func @create_mask_0d(%arg0: index) -> vector<i1> {
    %cst = arith.constant dense<0> : vector<i32>
    %0 = arith.index_cast %arg0 : index to i32
    %1 = llvm.mlir.poison : vector<1xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : vector<1xi32>
    %4 = builtin.unrealized_conversion_cast %3 : vector<1xi32> to vector<i32>
    %5 = arith.cmpi sgt, %4, %cst : vector<i32>
    return %5 : vector<i1>
  }
}

// -----
module {
  func.func @create_mask_1d(%arg0: index) -> vector<4xi1> {
    %cst = arith.constant dense<[0, 1, 2, 3]> : vector<4xi32>
    %0 = arith.index_cast %arg0 : index to i32
    %1 = llvm.mlir.poison : vector<4xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : vector<4xi32>
    %4 = llvm.shufflevector %3, %1 [0, 0, 0, 0] : vector<4xi32> 
    %5 = arith.cmpi sgt, %4, %cst : vector<4xi32>
    return %5 : vector<4xi1>
  }
}

// -----
module {
  func.func @create_mask_1d_scalable(%arg0: index) -> vector<[4]xi1> {
    %0 = llvm.intr.stepvector : vector<[4]xi32>
    %1 = arith.index_cast %arg0 : index to i32
    %2 = llvm.mlir.poison : vector<[4]xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<[4]xi32>
    %5 = llvm.shufflevector %4, %2 [0, 0, 0, 0] : vector<[4]xi32> 
    %6 = arith.cmpi slt, %0, %5 : vector<[4]xi32>
    return %6 : vector<[4]xi1>
  }
}

// -----
module {
  func.func @gather_with_mask(%arg0: memref<?xf32>, %arg1: vector<2x3xi32>, %arg2: vector<2x3xf32>) -> vector<2x3xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = builtin.unrealized_conversion_cast %arg2 : vector<2x3xf32> to !llvm.array<2 x vector<3xf32>>
    %2 = builtin.unrealized_conversion_cast %arg1 : vector<2x3xi32> to !llvm.array<2 x vector<3xi32>>
    %c0 = arith.constant 0 : index
    %3 = builtin.unrealized_conversion_cast %c0 : index to i64
    %cst = arith.constant dense<[true, true, false]> : vector<3xi1>
    %4 = ub.poison : vector<2x3xf32>
    %5 = builtin.unrealized_conversion_cast %4 : vector<2x3xf32> to !llvm.array<2 x vector<3xf32>>
    %6 = llvm.extractvalue %2[0] : !llvm.array<2 x vector<3xi32>> 
    %7 = llvm.extractvalue %1[0] : !llvm.array<2 x vector<3xf32>> 
    %8 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.getelementptr %8[%3] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %10 = llvm.getelementptr %9[%6] : (!llvm.ptr, vector<3xi32>) -> vector<3x!llvm.ptr>, f32
    %11 = llvm.intr.masked.gather %10, %cst, %7 {alignment = 4 : i32} : (vector<3x!llvm.ptr>, vector<3xi1>, vector<3xf32>) -> vector<3xf32>
    %12 = llvm.insertvalue %11, %5[0] : !llvm.array<2 x vector<3xf32>> 
    %13 = llvm.extractvalue %2[1] : !llvm.array<2 x vector<3xi32>> 
    %14 = llvm.extractvalue %1[1] : !llvm.array<2 x vector<3xf32>> 
    %15 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.getelementptr %15[%3] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %17 = llvm.getelementptr %16[%13] : (!llvm.ptr, vector<3xi32>) -> vector<3x!llvm.ptr>, f32
    %18 = llvm.intr.masked.gather %17, %cst, %14 {alignment = 4 : i32} : (vector<3x!llvm.ptr>, vector<3xi1>, vector<3xf32>) -> vector<3xf32>
    %19 = llvm.insertvalue %18, %12[1] : !llvm.array<2 x vector<3xf32>> 
    %20 = builtin.unrealized_conversion_cast %19 : !llvm.array<2 x vector<3xf32>> to vector<2x3xf32>
    return %20 : vector<2x3xf32>
  }
}

// -----
module {
  func.func @gather_with_mask_scalable(%arg0: memref<?xf32>, %arg1: vector<2x[3]xi32>, %arg2: vector<2x[3]xf32>) -> vector<2x[3]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = builtin.unrealized_conversion_cast %arg2 : vector<2x[3]xf32> to !llvm.array<2 x vector<[3]xf32>>
    %2 = builtin.unrealized_conversion_cast %arg1 : vector<2x[3]xi32> to !llvm.array<2 x vector<[3]xi32>>
    %cst = arith.constant dense<true> : vector<[3]xi1>
    %c0 = arith.constant 0 : index
    %3 = builtin.unrealized_conversion_cast %c0 : index to i64
    %4 = ub.poison : vector<2x[3]xf32>
    %5 = builtin.unrealized_conversion_cast %4 : vector<2x[3]xf32> to !llvm.array<2 x vector<[3]xf32>>
    %6 = llvm.extractvalue %2[0] : !llvm.array<2 x vector<[3]xi32>> 
    %7 = llvm.extractvalue %1[0] : !llvm.array<2 x vector<[3]xf32>> 
    %8 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.getelementptr %8[%3] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %10 = llvm.getelementptr %9[%6] : (!llvm.ptr, vector<[3]xi32>) -> vector<[3]x!llvm.ptr>, f32
    %11 = llvm.intr.masked.gather %10, %cst, %7 {alignment = 4 : i32} : (vector<[3]x!llvm.ptr>, vector<[3]xi1>, vector<[3]xf32>) -> vector<[3]xf32>
    %12 = llvm.insertvalue %11, %5[0] : !llvm.array<2 x vector<[3]xf32>> 
    %13 = llvm.extractvalue %2[1] : !llvm.array<2 x vector<[3]xi32>> 
    %14 = llvm.extractvalue %1[1] : !llvm.array<2 x vector<[3]xf32>> 
    %15 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.getelementptr %15[%3] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %17 = llvm.getelementptr %16[%13] : (!llvm.ptr, vector<[3]xi32>) -> vector<[3]x!llvm.ptr>, f32
    %18 = llvm.intr.masked.gather %17, %cst, %14 {alignment = 4 : i32} : (vector<[3]x!llvm.ptr>, vector<[3]xi1>, vector<[3]xf32>) -> vector<[3]xf32>
    %19 = llvm.insertvalue %18, %12[1] : !llvm.array<2 x vector<[3]xf32>> 
    %20 = builtin.unrealized_conversion_cast %19 : !llvm.array<2 x vector<[3]xf32>> to vector<2x[3]xf32>
    return %20 : vector<2x[3]xf32>
  }
}

// -----
module {
  func.func @gather_with_zero_mask(%arg0: memref<?xf32>, %arg1: vector<2x3xi32>, %arg2: vector<2x3xf32>) -> vector<2x3xf32> {
    return %arg2 : vector<2x3xf32>
  }
}

// -----
module {
  func.func @gather_with_zero_mask_scalable(%arg0: memref<?xf32>, %arg1: vector<2x[3]xi32>, %arg2: vector<2x[3]xf32>) -> vector<2x[3]xf32> {
    return %arg2 : vector<2x[3]xf32>
  }
}

// -----
module {
  func.func @scatter_with_mask(%arg0: memref<?xf32>, %arg1: vector<2x3xi32>, %arg2: vector<2x3xf32>) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant dense<[[true, true, false], [true, true, false]]> : vector<2x3xi1>
    vector.scatter %arg0[%c0] [%arg1], %cst, %arg2 : memref<?xf32>, vector<2x3xi32>, vector<2x3xi1>, vector<2x3xf32>
    return
  }
}

// -----
module {
  func.func @scatter_with_mask_scalable(%arg0: memref<?xf32>, %arg1: vector<2x[3]xi32>, %arg2: vector<2x[3]xf32>) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant dense<true> : vector<2x[3]xi1>
    vector.scatter %arg0[%c0] [%arg1], %cst, %arg2 : memref<?xf32>, vector<2x[3]xi32>, vector<2x[3]xi1>, vector<2x[3]xf32>
    return
  }
}

// -----
module {
  func.func @interleave_2d(%arg0: vector<2x3xi8>, %arg1: vector<2x3xi8>) -> vector<2x6xi8> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<2x3xi8> to !llvm.array<2 x vector<3xi8>>
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<2x3xi8> to !llvm.array<2 x vector<3xi8>>
    %cst = arith.constant dense<0> : vector<2x6xi8>
    %2 = builtin.unrealized_conversion_cast %cst : vector<2x6xi8> to !llvm.array<2 x vector<6xi8>>
    %3 = llvm.extractvalue %1[0] : !llvm.array<2 x vector<3xi8>> 
    %4 = llvm.extractvalue %0[0] : !llvm.array<2 x vector<3xi8>> 
    %5 = llvm.shufflevector %3, %4 [0, 3, 1, 4, 2, 5] : vector<3xi8> 
    %6 = llvm.insertvalue %5, %2[0] : !llvm.array<2 x vector<6xi8>> 
    %7 = llvm.extractvalue %1[1] : !llvm.array<2 x vector<3xi8>> 
    %8 = llvm.extractvalue %0[1] : !llvm.array<2 x vector<3xi8>> 
    %9 = llvm.shufflevector %7, %8 [0, 3, 1, 4, 2, 5] : vector<3xi8> 
    %10 = llvm.insertvalue %9, %6[1] : !llvm.array<2 x vector<6xi8>> 
    %11 = builtin.unrealized_conversion_cast %10 : !llvm.array<2 x vector<6xi8>> to vector<2x6xi8>
    return %11 : vector<2x6xi8>
  }
}

// -----
module {
  func.func @interleave_2d_scalable(%arg0: vector<2x[8]xi16>, %arg1: vector<2x[8]xi16>) -> vector<2x[16]xi16> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<2x[8]xi16> to !llvm.array<2 x vector<[8]xi16>>
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<2x[8]xi16> to !llvm.array<2 x vector<[8]xi16>>
    %cst = arith.constant dense<0> : vector<2x[16]xi16>
    %2 = builtin.unrealized_conversion_cast %cst : vector<2x[16]xi16> to !llvm.array<2 x vector<[16]xi16>>
    %3 = llvm.extractvalue %1[0] : !llvm.array<2 x vector<[8]xi16>> 
    %4 = llvm.extractvalue %0[0] : !llvm.array<2 x vector<[8]xi16>> 
    %5 = "llvm.intr.vector.interleave2"(%3, %4) : (vector<[8]xi16>, vector<[8]xi16>) -> vector<[16]xi16>
    %6 = llvm.insertvalue %5, %2[0] : !llvm.array<2 x vector<[16]xi16>> 
    %7 = llvm.extractvalue %1[1] : !llvm.array<2 x vector<[8]xi16>> 
    %8 = llvm.extractvalue %0[1] : !llvm.array<2 x vector<[8]xi16>> 
    %9 = "llvm.intr.vector.interleave2"(%7, %8) : (vector<[8]xi16>, vector<[8]xi16>) -> vector<[16]xi16>
    %10 = llvm.insertvalue %9, %6[1] : !llvm.array<2 x vector<[16]xi16>> 
    %11 = builtin.unrealized_conversion_cast %10 : !llvm.array<2 x vector<[16]xi16>> to vector<2x[16]xi16>
    return %11 : vector<2x[16]xi16>
  }
}

// -----
module {
  func.func @deinterleave_2d(%arg0: vector<2x8xf32>) -> (vector<2x4xf32>, vector<2x4xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2x8xf32> to !llvm.array<2 x vector<8xf32>>
    %cst = arith.constant dense<0.000000e+00> : vector<2x4xf32>
    %1 = builtin.unrealized_conversion_cast %cst : vector<2x4xf32> to !llvm.array<2 x vector<4xf32>>
    %2 = llvm.extractvalue %0[0] : !llvm.array<2 x vector<8xf32>> 
    %3 = llvm.mlir.poison : vector<8xf32>
    %4 = llvm.shufflevector %2, %3 [0, 2, 4, 6] : vector<8xf32> 
    %5 = llvm.shufflevector %2, %3 [1, 3, 5, 7] : vector<8xf32> 
    %6 = llvm.insertvalue %4, %1[0] : !llvm.array<2 x vector<4xf32>> 
    %7 = llvm.insertvalue %5, %1[0] : !llvm.array<2 x vector<4xf32>> 
    %8 = llvm.extractvalue %0[1] : !llvm.array<2 x vector<8xf32>> 
    %9 = llvm.mlir.poison : vector<8xf32>
    %10 = llvm.shufflevector %8, %9 [0, 2, 4, 6] : vector<8xf32> 
    %11 = llvm.shufflevector %8, %9 [1, 3, 5, 7] : vector<8xf32> 
    %12 = llvm.insertvalue %10, %6[1] : !llvm.array<2 x vector<4xf32>> 
    %13 = builtin.unrealized_conversion_cast %12 : !llvm.array<2 x vector<4xf32>> to vector<2x4xf32>
    %14 = llvm.insertvalue %11, %7[1] : !llvm.array<2 x vector<4xf32>> 
    %15 = builtin.unrealized_conversion_cast %14 : !llvm.array<2 x vector<4xf32>> to vector<2x4xf32>
    return %13, %15 : vector<2x4xf32>, vector<2x4xf32>
  }
}

// -----
module {
  func.func @deinterleave_2d_scalable(%arg0: vector<2x[8]xf32>) -> (vector<2x[4]xf32>, vector<2x[4]xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2x[8]xf32> to !llvm.array<2 x vector<[8]xf32>>
    %cst = arith.constant dense<0.000000e+00> : vector<2x[4]xf32>
    %1 = builtin.unrealized_conversion_cast %cst : vector<2x[4]xf32> to !llvm.array<2 x vector<[4]xf32>>
    %2 = llvm.extractvalue %0[0] : !llvm.array<2 x vector<[8]xf32>> 
    %3 = "llvm.intr.vector.deinterleave2"(%2) : (vector<[8]xf32>) -> !llvm.struct<(vector<[4]xf32>, vector<[4]xf32>)>
    %4 = llvm.extractvalue %3[0] : !llvm.struct<(vector<[4]xf32>, vector<[4]xf32>)> 
    %5 = llvm.extractvalue %3[1] : !llvm.struct<(vector<[4]xf32>, vector<[4]xf32>)> 
    %6 = llvm.insertvalue %4, %1[0] : !llvm.array<2 x vector<[4]xf32>> 
    %7 = llvm.insertvalue %5, %1[0] : !llvm.array<2 x vector<[4]xf32>> 
    %8 = llvm.extractvalue %0[1] : !llvm.array<2 x vector<[8]xf32>> 
    %9 = "llvm.intr.vector.deinterleave2"(%8) : (vector<[8]xf32>) -> !llvm.struct<(vector<[4]xf32>, vector<[4]xf32>)>
    %10 = llvm.extractvalue %9[0] : !llvm.struct<(vector<[4]xf32>, vector<[4]xf32>)> 
    %11 = llvm.extractvalue %9[1] : !llvm.struct<(vector<[4]xf32>, vector<[4]xf32>)> 
    %12 = llvm.insertvalue %10, %6[1] : !llvm.array<2 x vector<[4]xf32>> 
    %13 = builtin.unrealized_conversion_cast %12 : !llvm.array<2 x vector<[4]xf32>> to vector<2x[4]xf32>
    %14 = llvm.insertvalue %11, %7[1] : !llvm.array<2 x vector<[4]xf32>> 
    %15 = builtin.unrealized_conversion_cast %14 : !llvm.array<2 x vector<[4]xf32>> to vector<2x[4]xf32>
    return %13, %15 : vector<2x[4]xf32>, vector<2x[4]xf32>
  }
}

// -----
module {
  func.func @step() -> vector<4xindex> {
    %cst = arith.constant dense<[0, 1, 2, 3]> : vector<4xindex>
    return %cst : vector<4xindex>
  }
}

// -----
module {
  func.func @from_elements_3d(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: f32) -> vector<2x1x2xf32> {
    %0 = ub.poison : vector<2x1x2xf32>
    %1 = builtin.unrealized_conversion_cast %0 : vector<2x1x2xf32> to !llvm.array<2 x array<1 x vector<2xf32>>>
    %2 = ub.poison : vector<1x2xf32>
    %3 = builtin.unrealized_conversion_cast %2 : vector<1x2xf32> to !llvm.array<1 x vector<2xf32>>
    %4 = llvm.mlir.poison : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.insertelement %arg0, %4[%5 : i64] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i64) : i64
    %8 = llvm.insertelement %arg1, %6[%7 : i64] : vector<2xf32>
    %9 = llvm.insertvalue %8, %3[0] : !llvm.array<1 x vector<2xf32>> 
    %10 = llvm.insertvalue %9, %1[0] : !llvm.array<2 x array<1 x vector<2xf32>>> 
    %11 = llvm.mlir.poison : vector<2xf32>
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.insertelement %arg2, %11[%12 : i64] : vector<2xf32>
    %14 = llvm.mlir.constant(1 : i64) : i64
    %15 = llvm.insertelement %arg3, %13[%14 : i64] : vector<2xf32>
    %16 = llvm.insertvalue %15, %3[0] : !llvm.array<1 x vector<2xf32>> 
    %17 = llvm.insertvalue %16, %10[1] : !llvm.array<2 x array<1 x vector<2xf32>>> 
    %18 = builtin.unrealized_conversion_cast %17 : !llvm.array<2 x array<1 x vector<2xf32>>> to vector<2x1x2xf32>
    return %18 : vector<2x1x2xf32>
  }
}

// -----
module {
  func.func @to_elements_1d(%arg0: vector<2xf32>) -> (f32, f32) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : vector<2xf32>
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.extractelement %arg0[%2 : i64] : vector<2xf32>
    return %1, %3 : f32, f32
  }
}

// -----
module {
  func.func @to_elements_2d(%arg0: vector<2x2xf32>) -> (f32, f32, f32, f32) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2x2xf32> to !llvm.array<2 x vector<2xf32>>
    %1 = llvm.extractvalue %0[0] : !llvm.array<2 x vector<2xf32>> 
    %2 = llvm.extractvalue %0[1] : !llvm.array<2 x vector<2xf32>> 
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.extractelement %1[%3 : i64] : vector<2xf32>
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.extractelement %1[%5 : i64] : vector<2xf32>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.extractelement %2[%7 : i64] : vector<2xf32>
    %9 = llvm.mlir.constant(1 : i64) : i64
    %10 = llvm.extractelement %2[%9 : i64] : vector<2xf32>
    return %4, %6, %8, %10 : f32, f32, f32, f32
  }
}

