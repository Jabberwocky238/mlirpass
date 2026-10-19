#map = affine_map<(d0)[s0] -> (d0 + s0)>
module {
  func.func @transfer_read_2d(%arg0: tensor<?x?xf32>, %arg1: index, %arg2: index) -> vector<4x9xf32> {
    %c1 = arith.constant 1 : index
    %c4 = arith.constant 4 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant -4.200000e+01 : f32
    %alloca = memref.alloca() : memref<vector<4x9xf32>>
    %0 = vector.type_cast %alloca : memref<vector<4x9xf32>> to memref<4xvector<9xf32>>
    scf.for %arg3 = %c0 to %c4 step %c1 {
      %2 = affine.apply #map(%arg3)[%arg1]
      %3 = vector.transfer_read %arg0[%2, %arg2], %cst {in_bounds = [true]} : tensor<?x?xf32>, vector<9xf32>
      memref.store %3, %0[%arg3] : memref<4xvector<9xf32>>
    }
    %1 = memref.load %alloca[] : memref<vector<4x9xf32>>
    return %1 : vector<4x9xf32>
  }
}

// -----
#map = affine_map<(d0)[s0] -> (d0 + s0)>
module {
  func.func @transfer_write_2d(%arg0: tensor<?x?xf32>, %arg1: vector<2x3xf32>, %arg2: index, %arg3: index) -> tensor<?x?xf32> {
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %alloca = memref.alloca() : memref<vector<2x3xf32>>
    memref.store %arg1, %alloca[] : memref<vector<2x3xf32>>
    %0 = vector.type_cast %alloca : memref<vector<2x3xf32>> to memref<2xvector<3xf32>>
    %1 = scf.for %arg4 = %c0 to %c2 step %c1 iter_args(%arg5 = %arg0) -> (tensor<?x?xf32>) {
      %2 = affine.apply #map(%arg4)[%arg2]
      %3 = memref.load %0[%arg4] : memref<2xvector<3xf32>>
      %4 = vector.transfer_write %3, %arg5[%2, %arg3] {in_bounds = [true]} : vector<3xf32>, tensor<?x?xf32>
      scf.yield %4 : tensor<?x?xf32>
    }
    return %1 : tensor<?x?xf32>
  }
}

// -----
#map = affine_map<(d0)[s0] -> (d0 + s0)>
module {
  func.func @scalable_transpose_store(%arg0: vector<4x[4]xf32>, %arg1: tensor<?x?xf32>, %arg2: index, %arg3: index) -> tensor<?x?xf32> {
    %c1 = arith.constant 1 : index
    %c4 = arith.constant 4 : index
    %c0 = arith.constant 0 : index
    %0 = vector.extract %arg0[0] : vector<[4]xf32> from vector<4x[4]xf32>
    %1 = vector.extract %arg0[1] : vector<[4]xf32> from vector<4x[4]xf32>
    %2 = vector.extract %arg0[2] : vector<[4]xf32> from vector<4x[4]xf32>
    %3 = vector.extract %arg0[3] : vector<[4]xf32> from vector<4x[4]xf32>
    %vscale = vector.vscale
    %c4_vscale = arith.muli %vscale, %c4 : index
    %4 = scf.for %arg4 = %c0 to %c4_vscale step %c1 iter_args(%arg5 = %arg1) -> (tensor<?x?xf32>) {
      %5 = affine.apply #map(%arg4)[%arg2]
      %6 = vector.extract %0[%arg4] : f32 from vector<[4]xf32>
      %7 = vector.extract %1[%arg4] : f32 from vector<[4]xf32>
      %8 = vector.extract %2[%arg4] : f32 from vector<[4]xf32>
      %9 = vector.extract %3[%arg4] : f32 from vector<[4]xf32>
      %10 = vector.from_elements %6, %7, %8, %9 : vector<4xf32>
      %11 = vector.transfer_write %10, %arg5[%5, %arg3] {in_bounds = [true]} : vector<4xf32>, tensor<?x?xf32>
      scf.yield %11 : tensor<?x?xf32>
    }
    return %4 : tensor<?x?xf32>
  }
}

