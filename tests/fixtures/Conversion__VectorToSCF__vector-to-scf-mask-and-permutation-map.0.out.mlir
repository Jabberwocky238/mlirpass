#map = affine_map<(d0)[s0] -> (d0 + s0)>
module {
  func.func @transfer_read_2d_mask_transposed(%arg0: memref<?x?xf32>, %arg1: index, %arg2: index) -> vector<9x4xf32> {
    %cst = arith.constant dense<-4.200000e+01> : vector<9xf32>
    %c1 = arith.constant 1 : index
    %c4 = arith.constant 4 : index
    %c0 = arith.constant 0 : index
    %cst_0 = arith.constant dense<[[true, false, true, false, true, true, true, false, true], [false, false, true, true, true, true, true, false, true], [true, true, true, true, true, true, true, false, true], [false, false, true, false, true, true, true, false, true]]> : vector<4x9xi1>
    %cst_1 = arith.constant -4.200000e+01 : f32
    %alloca = memref.alloca() : memref<vector<4x9xf32>>
    %alloca_2 = memref.alloca() : memref<vector<4x9xi1>>
    memref.store %cst_0, %alloca_2[] : memref<vector<4x9xi1>>
    %0 = vector.type_cast %alloca : memref<vector<4x9xf32>> to memref<4xvector<9xf32>>
    %1 = vector.type_cast %alloca_2 : memref<vector<4x9xi1>> to memref<4xvector<9xi1>>
    scf.for %arg3 = %c0 to %c4 step %c1 {
      %dim = memref.dim %arg0, %c0 : memref<?x?xf32>
      %4 = affine.apply #map(%arg3)[%arg1]
      %5 = arith.cmpi sgt, %dim, %4 : index
      scf.if %5 {
        %6 = affine.apply #map(%arg3)[%arg1]
        %7 = memref.load %1[%arg3] : memref<4xvector<9xi1>>
        %8 = vector.transfer_read %arg0[%6, %arg2], %cst_1, %7 : memref<?x?xf32>, vector<9xf32>
        memref.store %8, %0[%arg3] : memref<4xvector<9xf32>>
      } else {
        memref.store %cst, %0[%arg3] : memref<4xvector<9xf32>>
      }
    }
    %2 = memref.load %alloca[] : memref<vector<4x9xf32>>
    %3 = vector.transpose %2, [1, 0] : vector<4x9xf32> to vector<9x4xf32>
    return %3 : vector<9x4xf32>
  }
}

