module {
  func.func @matmul(%arg0: memref<?xi8>, %arg1: index, %arg2: index, %arg3: index) {
    %c0 = arith.constant 0 : index
    %view = memref.view %arg0[%c0][%arg1, %arg3] : memref<?xi8> to memref<?x?xf32>
    %view_0 = memref.view %arg0[%c0][%arg3, %arg2] : memref<?xi8> to memref<?x?xf32>
    %view_1 = memref.view %arg0[%c0][%arg1, %arg2] : memref<?xi8> to memref<?x?xf32>
    affine.for %arg4 = 0 to %arg1 {
      affine.for %arg5 = 0 to %arg2 {
        affine.for %arg6 = 0 to %arg3 {
          %0 = affine.load %view[%arg4, %arg6] : memref<?x?xf32>
          %1 = affine.load %view_0[%arg6, %arg5] : memref<?x?xf32>
          %2 = affine.load %view_1[%arg4, %arg5] : memref<?x?xf32>
          %3 = arith.mulf %0, %1 : f32
          %4 = arith.addf %2, %3 : f32
          affine.store %4, %view_1[%arg4, %arg5] : memref<?x?xf32>
        }
      }
    }
    return
  }
  func.func @named_batch_matmul(%arg0: memref<?x?x?xf32>, %arg1: memref<?x?x?xf32>, %arg2: memref<?x?x?xf32>) {
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?x?x?xf32>
    %dim_0 = memref.dim %arg0, %c1 : memref<?x?x?xf32>
    %dim_1 = memref.dim %arg0, %c2 : memref<?x?x?xf32>
    %dim_2 = memref.dim %arg1, %c2 : memref<?x?x?xf32>
    affine.for %arg3 = 0 to %dim {
      affine.for %arg4 = 0 to %dim_0 {
        affine.for %arg5 = 0 to %dim_2 {
          affine.for %arg6 = 0 to %dim_1 {
            %0 = affine.load %arg0[%arg3, %arg4, %arg6] : memref<?x?x?xf32>
            %1 = affine.load %arg1[%arg3, %arg6, %arg5] : memref<?x?x?xf32>
            %2 = affine.load %arg2[%arg3, %arg4, %arg5] : memref<?x?x?xf32>
            %3 = arith.mulf %0, %1 : f32
            %4 = arith.addf %2, %3 : f32
            affine.store %4, %arg2[%arg3, %arg4, %arg5] : memref<?x?x?xf32>
          }
        }
      }
    }
    return
  }
}

