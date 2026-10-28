#map = affine_map<(d0, d1) -> (d0 + d1)>
module {
  func.func @matmul(%arg0: memref<?xi8>, %arg1: index, %arg2: index, %arg3: index) {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %view = memref.view %arg0[%c0][%arg1, %arg3] : memref<?xi8> to memref<?x?xf32>
    %view_0 = memref.view %arg0[%c0][%arg3, %arg2] : memref<?xi8> to memref<?x?xf32>
    %view_1 = memref.view %arg0[%c0][%arg1, %arg2] : memref<?xi8> to memref<?x?xf32>
    scf.parallel (%arg4, %arg5) = (%c0, %c0) to (%arg1, %arg2) step (%c1, %c1) {
      scf.for %arg6 = %c0 to %arg3 step %c1 {
        %0 = memref.load %view[%arg4, %arg6] : memref<?x?xf32>
        %1 = memref.load %view_0[%arg6, %arg5] : memref<?x?xf32>
        %2 = memref.load %view_1[%arg4, %arg5] : memref<?x?xf32>
        %3 = arith.mulf %0, %1 : f32
        %4 = arith.addf %2, %3 : f32
        memref.store %4, %view_1[%arg4, %arg5] : memref<?x?xf32>
      }
      scf.reduce 
    }
    return
  }
  func.func @matvec(%arg0: memref<?xi8>, %arg1: index, %arg2: index) {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %view = memref.view %arg0[%c0][%arg1, %arg2] : memref<?xi8> to memref<?x?xf32>
    %view_0 = memref.view %arg0[%c0][%arg1] : memref<?xi8> to memref<?xf32>
    %view_1 = memref.view %arg0[%c0][%arg2] : memref<?xi8> to memref<?xf32>
    scf.parallel (%arg3) = (%c0) to (%arg1) step (%c1) {
      scf.for %arg4 = %c0 to %arg2 step %c1 {
        %0 = memref.load %view[%arg3, %arg4] : memref<?x?xf32>
        %1 = memref.load %view_0[%arg4] : memref<?xf32>
        %2 = memref.load %view_1[%arg3] : memref<?xf32>
        %3 = arith.mulf %0, %1 : f32
        %4 = arith.addf %2, %3 : f32
        memref.store %4, %view_1[%arg3] : memref<?xf32>
      }
      scf.reduce 
    }
    return
  }
  func.func @dot(%arg0: memref<?xi8>, %arg1: index) {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %view = memref.view %arg0[%c0][%arg1] : memref<?xi8> to memref<?xf32>
    %view_0 = memref.view %arg0[%c0][%arg1] : memref<?xi8> to memref<?xf32>
    %view_1 = memref.view %arg0[%c0][] : memref<?xi8> to memref<f32>
    scf.for %arg2 = %c0 to %arg1 step %c1 {
      %0 = memref.load %view[%arg2] : memref<?xf32>
      %1 = memref.load %view_0[%arg2] : memref<?xf32>
      %2 = memref.load %view_1[] : memref<f32>
      %3 = arith.mulf %0, %1 : f32
      %4 = arith.addf %2, %3 : f32
      memref.store %4, %view_1[] : memref<f32>
    }
    return
  }
  func.func @dot_int(%arg0: memref<?xi32>, %arg1: memref<?xi32>, %arg2: memref<i32>) {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xi32>
    scf.for %arg3 = %c0 to %dim step %c1 {
      %0 = memref.load %arg0[%arg3] : memref<?xi32>
      %1 = memref.load %arg1[%arg3] : memref<?xi32>
      %2 = memref.load %arg2[] : memref<i32>
      %3 = arith.muli %0, %1 : i32
      %4 = arith.addi %2, %3 : i32
      memref.store %4, %arg2[] : memref<i32>
    }
    return
  }
  func.func @dot_bool(%arg0: memref<?xi1>, %arg1: memref<?xi1>, %arg2: memref<i1>) {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xi1>
    scf.for %arg3 = %c0 to %dim step %c1 {
      %0 = memref.load %arg0[%arg3] : memref<?xi1>
      %1 = memref.load %arg1[%arg3] : memref<?xi1>
      %2 = memref.load %arg2[] : memref<i1>
      %3 = arith.andi %0, %1 : i1
      %4 = arith.ori %2, %3 : i1
      memref.store %4, %arg2[] : memref<i1>
    }
    return
  }
  func.func @dot_view(%arg0: memref<?xf32, strided<[1], offset: ?>>, %arg1: memref<?xf32, strided<[1], offset: ?>>, %arg2: memref<f32>) {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32, strided<[1], offset: ?>>
    scf.for %arg3 = %c0 to %dim step %c1 {
      %0 = memref.load %arg0[%arg3] : memref<?xf32, strided<[1], offset: ?>>
      %1 = memref.load %arg1[%arg3] : memref<?xf32, strided<[1], offset: ?>>
      %2 = memref.load %arg2[] : memref<f32>
      %3 = arith.mulf %0, %1 : f32
      %4 = arith.addf %2, %3 : f32
      memref.store %4, %arg2[] : memref<f32>
    }
    return
  }
  func.func @fill_view(%arg0: memref<?xf32, strided<[1], offset: ?>>, %arg1: f32) {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32, strided<[1], offset: ?>>
    scf.parallel (%arg2) = (%c0) to (%dim) step (%c1) {
      memref.store %arg1, %arg0[%arg2] : memref<?xf32, strided<[1], offset: ?>>
      scf.reduce 
    }
    return
  }
  func.func @fill_view0(%arg0: memref<f32>, %arg1: f32) {
    memref.store %arg1, %arg0[] : memref<f32>
    return
  }
  func.func @fill_view3(%arg0: memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, %arg1: f32) {
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
    %dim_0 = memref.dim %arg0, %c1 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
    %dim_1 = memref.dim %arg0, %c2 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
    scf.parallel (%arg2, %arg3, %arg4) = (%c0, %c0, %c0) to (%dim, %dim_0, %dim_1) step (%c1, %c1, %c1) {
      memref.store %arg1, %arg0[%arg2, %arg3, %arg4] : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      scf.reduce 
    }
    return
  }
  func.func @copy_view(%arg0: memref<?xf32, strided<[1], offset: ?>>, %arg1: memref<?xf32, strided<[1], offset: ?>>) {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32, strided<[1], offset: ?>>
    scf.parallel (%arg2) = (%c0) to (%dim) step (%c1) {
      %0 = memref.load %arg0[%arg2] : memref<?xf32, strided<[1], offset: ?>>
      memref.store %0, %arg1[%arg2] : memref<?xf32, strided<[1], offset: ?>>
      scf.reduce 
    }
    return
  }
  func.func @generic_region(%arg0: memref<?x?xf32, strided<[?, 1], offset: ?>>, %arg1: memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, %arg2: memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) {
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?x?xf32, strided<[?, 1], offset: ?>>
    %dim_0 = memref.dim %arg0, %c1 : memref<?x?xf32, strided<[?, 1], offset: ?>>
    %dim_1 = memref.dim %arg1, %c2 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
    scf.parallel (%arg3, %arg4, %arg5) = (%c0, %c0, %c0) to (%dim, %dim_0, %dim_1) step (%c1, %c1, %c1) {
      %0 = memref.load %arg0[%arg3, %arg4] : memref<?x?xf32, strided<[?, 1], offset: ?>>
      %1 = memref.load %arg1[%arg3, %arg4, %arg5] : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %2 = memref.load %arg2[%arg3, %arg5, %arg4] : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %3 = arith.mulf %0, %1 : f32
      %4 = arith.addf %2, %3 : f32
      memref.store %3, %arg1[%arg3, %arg4, %arg5] : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      memref.store %4, %arg2[%arg3, %arg5, %arg4] : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      scf.reduce 
    }
    return
  }
  func.func @generic_index_region(%arg0: memref<?x?xf32, strided<[?, 1], offset: ?>>, %arg1: memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, %arg2: memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) {
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?x?xf32, strided<[?, 1], offset: ?>>
    %dim_0 = memref.dim %arg0, %c1 : memref<?x?xf32, strided<[?, 1], offset: ?>>
    %dim_1 = memref.dim %arg1, %c2 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
    scf.parallel (%arg3, %arg4, %arg5) = (%c0, %c0, %c0) to (%dim, %dim_0, %dim_1) step (%c1, %c1, %c1) {
      %0 = memref.load %arg0[%arg3, %arg4] : memref<?x?xf32, strided<[?, 1], offset: ?>>
      %1 = memref.load %arg1[%arg3, %arg4, %arg5] : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %2 = memref.load %arg2[%arg3, %arg5, %arg4] : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %3 = arith.mulf %0, %1 : f32
      %4 = arith.addi %arg3, %arg4 : index
      %5 = arith.addi %4, %arg5 : index
      %6 = arith.index_cast %5 : index to i32
      %7 = arith.sitofp %6 : i32 to f32
      %8 = arith.addf %2, %7 : f32
      memref.store %3, %arg1[%arg3, %arg4, %arg5] : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      memref.store %8, %arg2[%arg3, %arg5, %arg4] : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      scf.reduce 
    }
    return
  }
  func.func @generic_op_zero_rank(%arg0: memref<f32>, %arg1: memref<3x4xf32>) {
    %c0 = arith.constant 0 : index
    %c3 = arith.constant 3 : index
    %c1 = arith.constant 1 : index
    %c4 = arith.constant 4 : index
    scf.parallel (%arg2, %arg3) = (%c0, %c0) to (%c3, %c4) step (%c1, %c1) {
      %0 = memref.load %arg0[] : memref<f32>
      memref.store %0, %arg1[%arg2, %arg3] : memref<3x4xf32>
      scf.reduce 
    }
    return
  }
  func.func @generic_op_scalar(%arg0: f32, %arg1: memref<3x4xf32>) {
    %c0 = arith.constant 0 : index
    %c3 = arith.constant 3 : index
    %c1 = arith.constant 1 : index
    %c4 = arith.constant 4 : index
    scf.parallel (%arg2, %arg3) = (%c0, %c0) to (%c3, %c4) step (%c1, %c1) {
      memref.store %arg0, %arg1[%arg2, %arg3] : memref<3x4xf32>
      scf.reduce 
    }
    return
  }
  func.func @generic_index_op_zero_rank(%arg0: memref<i32>, %arg1: memref<3x4xi32>) {
    %c0 = arith.constant 0 : index
    %c3 = arith.constant 3 : index
    %c1 = arith.constant 1 : index
    %c4 = arith.constant 4 : index
    scf.parallel (%arg2, %arg3) = (%c0, %c0) to (%c3, %c4) step (%c1, %c1) {
      %0 = memref.load %arg0[] : memref<i32>
      %1 = arith.addi %arg2, %arg3 : index
      %2 = arith.index_cast %1 : index to i32
      %3 = arith.addi %0, %2 : i32
      memref.store %3, %arg1[%arg2, %arg3] : memref<3x4xi32>
      scf.reduce 
    }
    return
  }
  func.func @generic_op_1D_reduce(%arg0: memref<?xf32>, %arg1: memref<f32>) {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32>
    scf.for %arg2 = %c0 to %dim step %c1 {
      %0 = memref.load %arg0[%arg2] : memref<?xf32>
      %1 = memref.load %arg1[] : memref<f32>
      %2 = arith.addf %0, %1 : f32
      memref.store %2, %arg1[] : memref<f32>
    }
    return
  }
  func.func @generic_index_op_1D_reduce(%arg0: memref<?xf32>, %arg1: memref<f32>, %arg2: memref<f32>) {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32>
    scf.for %arg3 = %c0 to %dim step %c1 {
      %0 = memref.load %arg0[%arg3] : memref<?xf32>
      %1 = memref.load %arg1[] : memref<f32>
      %2 = memref.load %arg2[] : memref<f32>
      %3 = arith.cmpi eq, %arg3, %c0 : index
      %4 = arith.select %3, %1, %2 : f32
      %5 = arith.addf %0, %4 : f32
      memref.store %5, %arg2[] : memref<f32>
    }
    return
  }
  func.func @generic_const_init(%arg0: memref<?xf32>) {
    %c1 = arith.constant 1 : index
    %cst = arith.constant 1.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32>
    scf.parallel (%arg1) = (%c0) to (%dim) step (%c1) {
      memref.store %cst, %arg0[%arg1] : memref<?xf32>
      scf.reduce 
    }
    return
  }
  func.func @scalar_code(%arg0: memref<f32>, %arg1: memref<f32>, %arg2: memref<f32>, %arg3: i1) {
    %0 = memref.load %arg0[] : memref<f32>
    %1 = memref.load %arg1[] : memref<f32>
    %2 = scf.if %arg3 -> (f32) {
      scf.yield %0 : f32
    } else {
      scf.yield %1 : f32
    }
    memref.store %2, %arg2[] : memref<f32>
    return
  }
  func.func @batch_reduce_matmul_as_contract(%arg0: memref<?x?x?xf32>, %arg1: memref<?x?x?xf32>, %arg2: memref<?x?xf32>) {
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?x?x?xf32>
    %dim_0 = memref.dim %arg0, %c1 : memref<?x?x?xf32>
    %dim_1 = memref.dim %arg0, %c2 : memref<?x?x?xf32>
    %dim_2 = memref.dim %arg1, %c2 : memref<?x?x?xf32>
    scf.for %arg3 = %c0 to %dim step %c1 {
      scf.parallel (%arg4, %arg5) = (%c0, %c0) to (%dim_0, %dim_2) step (%c1, %c1) {
        scf.for %arg6 = %c0 to %dim_1 step %c1 {
          %0 = memref.load %arg0[%arg3, %arg4, %arg6] : memref<?x?x?xf32>
          %1 = memref.load %arg1[%arg3, %arg6, %arg5] : memref<?x?x?xf32>
          %2 = memref.load %arg2[%arg4, %arg5] : memref<?x?xf32>
          %3 = arith.mulf %0, %1 : f32
          %4 = arith.addf %2, %3 : f32
          memref.store %4, %arg2[%arg4, %arg5] : memref<?x?xf32>
        }
        scf.reduce 
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
    scf.parallel (%arg3, %arg4, %arg5) = (%c0, %c0, %c0) to (%dim, %dim_0, %dim_2) step (%c1, %c1, %c1) {
      scf.for %arg6 = %c0 to %dim_1 step %c1 {
        %0 = memref.load %arg0[%arg3, %arg4, %arg6] : memref<?x?x?xf32>
        %1 = memref.load %arg1[%arg3, %arg6, %arg5] : memref<?x?x?xf32>
        %2 = memref.load %arg2[%arg3, %arg4, %arg5] : memref<?x?x?xf32>
        %3 = arith.mulf %0, %1 : f32
        %4 = arith.addf %2, %3 : f32
        memref.store %4, %arg2[%arg3, %arg4, %arg5] : memref<?x?x?xf32>
      }
      scf.reduce 
    }
    return
  }
  func.func @conv1d_no_symbols(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: memref<?xf32>) {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg1, %c0 : memref<?xf32>
    %dim_0 = memref.dim %arg2, %c0 : memref<?xf32>
    scf.parallel (%arg3) = (%c0) to (%dim_0) step (%c1) {
      scf.for %arg4 = %c0 to %dim step %c1 {
        %0 = affine.apply #map(%arg3, %arg4)
        %1 = memref.load %arg0[%0] : memref<?xf32>
        %2 = memref.load %arg1[%arg4] : memref<?xf32>
        %3 = memref.load %arg2[%arg3] : memref<?xf32>
        %4 = arith.mulf %1, %2 : f32
        %5 = arith.addf %3, %4 : f32
        memref.store %5, %arg2[%arg3] : memref<?xf32>
      }
      scf.reduce 
    }
    return
  }
  func.func @conv2d_no_symbols(%arg0: memref<?x?xf32>, %arg1: memref<?x?xf32>, %arg2: memref<?x?xf32>) {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg1, %c0 : memref<?x?xf32>
    %dim_0 = memref.dim %arg1, %c1 : memref<?x?xf32>
    %dim_1 = memref.dim %arg2, %c0 : memref<?x?xf32>
    %dim_2 = memref.dim %arg2, %c1 : memref<?x?xf32>
    scf.parallel (%arg3, %arg4) = (%c0, %c0) to (%dim_1, %dim_2) step (%c1, %c1) {
      scf.for %arg5 = %c0 to %dim step %c1 {
        scf.for %arg6 = %c0 to %dim_0 step %c1 {
          %0 = affine.apply #map(%arg3, %arg5)
          %1 = affine.apply #map(%arg4, %arg6)
          %2 = memref.load %arg0[%0, %1] : memref<?x?xf32>
          %3 = memref.load %arg1[%arg5, %arg6] : memref<?x?xf32>
          %4 = memref.load %arg2[%arg3, %arg4] : memref<?x?xf32>
          %5 = arith.mulf %2, %3 : f32
          %6 = arith.addf %4, %5 : f32
          memref.store %6, %arg2[%arg3, %arg4] : memref<?x?xf32>
        }
      }
      scf.reduce 
    }
    return
  }
  func.func @conv3d_no_symbols(%arg0: memref<?x?x?xf32>, %arg1: memref<?x?x?xf32>, %arg2: memref<?x?x?xf32>) {
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg1, %c0 : memref<?x?x?xf32>
    %dim_0 = memref.dim %arg1, %c1 : memref<?x?x?xf32>
    %dim_1 = memref.dim %arg1, %c2 : memref<?x?x?xf32>
    %dim_2 = memref.dim %arg2, %c0 : memref<?x?x?xf32>
    %dim_3 = memref.dim %arg2, %c1 : memref<?x?x?xf32>
    %dim_4 = memref.dim %arg2, %c2 : memref<?x?x?xf32>
    scf.parallel (%arg3, %arg4, %arg5) = (%c0, %c0, %c0) to (%dim_2, %dim_3, %dim_4) step (%c1, %c1, %c1) {
      scf.for %arg6 = %c0 to %dim step %c1 {
        scf.for %arg7 = %c0 to %dim_0 step %c1 {
          scf.for %arg8 = %c0 to %dim_1 step %c1 {
            %0 = affine.apply #map(%arg3, %arg6)
            %1 = affine.apply #map(%arg4, %arg7)
            %2 = affine.apply #map(%arg5, %arg8)
            %3 = memref.load %arg0[%0, %1, %2] : memref<?x?x?xf32>
            %4 = memref.load %arg1[%arg6, %arg7, %arg8] : memref<?x?x?xf32>
            %5 = memref.load %arg2[%arg3, %arg4, %arg5] : memref<?x?x?xf32>
            %6 = arith.mulf %3, %4 : f32
            %7 = arith.addf %5, %6 : f32
            memref.store %7, %arg2[%arg3, %arg4, %arg5] : memref<?x?x?xf32>
          }
        }
      }
      scf.reduce 
    }
    return
  }
  func.func @lower_to_loops_with_rank_reducing_subviews(%arg0: memref<?xi32>, %arg1: memref<?x?xi32>, %arg2: index, %arg3: index, %arg4: index) {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %subview = memref.subview %arg0[%arg2] [%arg3] [1] : memref<?xi32> to memref<?xi32, strided<[1], offset: ?>>
    %subview_0 = memref.subview %arg1[0, %arg4] [1, %arg3] [1, 1] : memref<?x?xi32> to memref<?xi32, strided<[1], offset: ?>>
    scf.parallel (%arg5) = (%c0) to (%arg3) step (%c1) {
      %0 = memref.load %subview[%arg5] : memref<?xi32, strided<[1], offset: ?>>
      memref.store %0, %subview_0[%arg5] : memref<?xi32, strided<[1], offset: ?>>
      scf.reduce 
    }
    return
  }
  func.func @transpose(%arg0: memref<?xf32>, %arg1: memref<?xf32>) {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32>
    scf.parallel (%arg2) = (%c0) to (%dim) step (%c1) {
      %0 = memref.load %arg0[%arg2] : memref<?xf32>
      memref.store %0, %arg1[%arg2] : memref<?xf32>
      scf.reduce 
    }
    return
  }
}

