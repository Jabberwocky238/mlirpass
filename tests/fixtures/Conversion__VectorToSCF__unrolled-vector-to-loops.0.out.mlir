module {
  func.func @transfer_read_inbounds(%arg0: memref<?x?x?xf32>) -> vector<2x3x4xf32> {
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %cst_0 = arith.constant dense<0.000000e+00> : vector<2x3x4xf32>
    %0 = vector.transfer_read %arg0[%c0, %c0, %c0], %cst {in_bounds = [true]} : memref<?x?x?xf32>, vector<4xf32>
    %1 = vector.insert %0, %cst_0 [0, 0] : vector<4xf32> into vector<2x3x4xf32>
    %2 = vector.transfer_read %arg0[%c0, %c1, %c0], %cst {in_bounds = [true]} : memref<?x?x?xf32>, vector<4xf32>
    %3 = vector.insert %2, %1 [0, 1] : vector<4xf32> into vector<2x3x4xf32>
    %4 = vector.transfer_read %arg0[%c0, %c2, %c0], %cst {in_bounds = [true]} : memref<?x?x?xf32>, vector<4xf32>
    %5 = vector.insert %4, %3 [0, 2] : vector<4xf32> into vector<2x3x4xf32>
    %6 = vector.transfer_read %arg0[%c1, %c0, %c0], %cst {in_bounds = [true]} : memref<?x?x?xf32>, vector<4xf32>
    %7 = vector.insert %6, %5 [1, 0] : vector<4xf32> into vector<2x3x4xf32>
    %8 = vector.transfer_read %arg0[%c1, %c1, %c0], %cst {in_bounds = [true]} : memref<?x?x?xf32>, vector<4xf32>
    %9 = vector.insert %8, %7 [1, 1] : vector<4xf32> into vector<2x3x4xf32>
    %10 = vector.transfer_read %arg0[%c1, %c2, %c0], %cst {in_bounds = [true]} : memref<?x?x?xf32>, vector<4xf32>
    %11 = vector.insert %10, %9 [1, 2] : vector<4xf32> into vector<2x3x4xf32>
    return %11 : vector<2x3x4xf32>
  }
}

// -----
module {
  func.func @transfer_read_out_of_bounds(%arg0: memref<?x?x?xf32>) -> vector<2x3x4xf32> {
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %cst_0 = arith.constant dense<0.000000e+00> : vector<2x3x4xf32>
    %dim = memref.dim %arg0, %c0 : memref<?x?x?xf32>
    %0 = arith.cmpi sgt, %dim, %c0 : index
    %1 = scf.if %0 -> (vector<2x3x4xf32>) {
      %dim_2 = memref.dim %arg0, %c1 : memref<?x?x?xf32>
      %4 = arith.cmpi sgt, %dim_2, %c0 : index
      %5 = scf.if %4 -> (vector<2x3x4xf32>) {
        %10 = vector.transfer_read %arg0[%c0, %c0, %c0], %cst : memref<?x?x?xf32>, vector<4xf32>
        %11 = vector.insert %10, %cst_0 [0, 0] : vector<4xf32> into vector<2x3x4xf32>
        scf.yield %11 : vector<2x3x4xf32>
      } else {
        scf.yield %cst_0 : vector<2x3x4xf32>
      }
      %dim_3 = memref.dim %arg0, %c1 : memref<?x?x?xf32>
      %6 = arith.cmpi sgt, %dim_3, %c1 : index
      %7 = scf.if %6 -> (vector<2x3x4xf32>) {
        %10 = vector.transfer_read %arg0[%c0, %c1, %c0], %cst : memref<?x?x?xf32>, vector<4xf32>
        %11 = vector.insert %10, %5 [0, 1] : vector<4xf32> into vector<2x3x4xf32>
        scf.yield %11 : vector<2x3x4xf32>
      } else {
        scf.yield %5 : vector<2x3x4xf32>
      }
      %dim_4 = memref.dim %arg0, %c1 : memref<?x?x?xf32>
      %8 = arith.cmpi sgt, %dim_4, %c2 : index
      %9 = scf.if %8 -> (vector<2x3x4xf32>) {
        %10 = vector.transfer_read %arg0[%c0, %c2, %c0], %cst : memref<?x?x?xf32>, vector<4xf32>
        %11 = vector.insert %10, %7 [0, 2] : vector<4xf32> into vector<2x3x4xf32>
        scf.yield %11 : vector<2x3x4xf32>
      } else {
        scf.yield %7 : vector<2x3x4xf32>
      }
      scf.yield %9 : vector<2x3x4xf32>
    } else {
      scf.yield %cst_0 : vector<2x3x4xf32>
    }
    %dim_1 = memref.dim %arg0, %c0 : memref<?x?x?xf32>
    %2 = arith.cmpi sgt, %dim_1, %c1 : index
    %3 = scf.if %2 -> (vector<2x3x4xf32>) {
      %dim_2 = memref.dim %arg0, %c1 : memref<?x?x?xf32>
      %4 = arith.cmpi sgt, %dim_2, %c0 : index
      %5 = scf.if %4 -> (vector<2x3x4xf32>) {
        %10 = vector.transfer_read %arg0[%c1, %c0, %c0], %cst : memref<?x?x?xf32>, vector<4xf32>
        %11 = vector.insert %10, %1 [1, 0] : vector<4xf32> into vector<2x3x4xf32>
        scf.yield %11 : vector<2x3x4xf32>
      } else {
        scf.yield %1 : vector<2x3x4xf32>
      }
      %dim_3 = memref.dim %arg0, %c1 : memref<?x?x?xf32>
      %6 = arith.cmpi sgt, %dim_3, %c1 : index
      %7 = scf.if %6 -> (vector<2x3x4xf32>) {
        %10 = vector.transfer_read %arg0[%c1, %c1, %c0], %cst : memref<?x?x?xf32>, vector<4xf32>
        %11 = vector.insert %10, %5 [1, 1] : vector<4xf32> into vector<2x3x4xf32>
        scf.yield %11 : vector<2x3x4xf32>
      } else {
        scf.yield %5 : vector<2x3x4xf32>
      }
      %dim_4 = memref.dim %arg0, %c1 : memref<?x?x?xf32>
      %8 = arith.cmpi sgt, %dim_4, %c2 : index
      %9 = scf.if %8 -> (vector<2x3x4xf32>) {
        %10 = vector.transfer_read %arg0[%c1, %c2, %c0], %cst : memref<?x?x?xf32>, vector<4xf32>
        %11 = vector.insert %10, %7 [1, 2] : vector<4xf32> into vector<2x3x4xf32>
        scf.yield %11 : vector<2x3x4xf32>
      } else {
        scf.yield %7 : vector<2x3x4xf32>
      }
      scf.yield %9 : vector<2x3x4xf32>
    } else {
      scf.yield %1 : vector<2x3x4xf32>
    }
    return %3 : vector<2x3x4xf32>
  }
}

// -----
module {
  func.func @transfer_read_mask(%arg0: memref<?x?x?xf32>, %arg1: vector<2x3x4xi1>) -> vector<2x3x4xf32> {
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %cst_0 = arith.constant dense<0.000000e+00> : vector<2x3x4xf32>
    %0 = vector.extract %arg1[0, 0] : vector<4xi1> from vector<2x3x4xi1>
    %1 = vector.transfer_read %arg0[%c0, %c0, %c0], %cst, %0 {in_bounds = [true]} : memref<?x?x?xf32>, vector<4xf32>
    %2 = vector.insert %1, %cst_0 [0, 0] : vector<4xf32> into vector<2x3x4xf32>
    %3 = vector.extract %arg1[0, 1] : vector<4xi1> from vector<2x3x4xi1>
    %4 = vector.transfer_read %arg0[%c0, %c1, %c0], %cst, %3 {in_bounds = [true]} : memref<?x?x?xf32>, vector<4xf32>
    %5 = vector.insert %4, %2 [0, 1] : vector<4xf32> into vector<2x3x4xf32>
    %6 = vector.extract %arg1[0, 2] : vector<4xi1> from vector<2x3x4xi1>
    %7 = vector.transfer_read %arg0[%c0, %c2, %c0], %cst, %6 {in_bounds = [true]} : memref<?x?x?xf32>, vector<4xf32>
    %8 = vector.insert %7, %5 [0, 2] : vector<4xf32> into vector<2x3x4xf32>
    %9 = vector.extract %arg1[1, 0] : vector<4xi1> from vector<2x3x4xi1>
    %10 = vector.transfer_read %arg0[%c1, %c0, %c0], %cst, %9 {in_bounds = [true]} : memref<?x?x?xf32>, vector<4xf32>
    %11 = vector.insert %10, %8 [1, 0] : vector<4xf32> into vector<2x3x4xf32>
    %12 = vector.extract %arg1[1, 1] : vector<4xi1> from vector<2x3x4xi1>
    %13 = vector.transfer_read %arg0[%c1, %c1, %c0], %cst, %12 {in_bounds = [true]} : memref<?x?x?xf32>, vector<4xf32>
    %14 = vector.insert %13, %11 [1, 1] : vector<4xf32> into vector<2x3x4xf32>
    %15 = vector.extract %arg1[1, 2] : vector<4xi1> from vector<2x3x4xi1>
    %16 = vector.transfer_read %arg0[%c1, %c2, %c0], %cst, %15 {in_bounds = [true]} : memref<?x?x?xf32>, vector<4xf32>
    %17 = vector.insert %16, %14 [1, 2] : vector<4xf32> into vector<2x3x4xf32>
    return %17 : vector<2x3x4xf32>
  }
}

