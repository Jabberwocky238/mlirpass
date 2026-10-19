#map = affine_map<()[s0] -> (s0 + 1)>
#map1 = affine_map<()[s0] -> (s0 + 2)>
#map2 = affine_map<()[s0] -> (s0 + 3)>
module {
  func.func @transfer_read_2d(%arg0: tensor<?x?xf32>, %arg1: index, %arg2: index) -> vector<4x9xf32> {
    %cst = arith.constant -4.200000e+01 : f32
    %cst_0 = arith.constant dense<-4.200000e+01> : vector<4x9xf32>
    %0 = vector.transfer_read %arg0[%arg1, %arg2], %cst {in_bounds = [true]} : tensor<?x?xf32>, vector<9xf32>
    %1 = vector.insert %0, %cst_0 [0] : vector<9xf32> into vector<4x9xf32>
    %2 = affine.apply #map()[%arg1]
    %3 = vector.transfer_read %arg0[%2, %arg2], %cst {in_bounds = [true]} : tensor<?x?xf32>, vector<9xf32>
    %4 = vector.insert %3, %1 [1] : vector<9xf32> into vector<4x9xf32>
    %5 = affine.apply #map1()[%arg1]
    %6 = vector.transfer_read %arg0[%5, %arg2], %cst {in_bounds = [true]} : tensor<?x?xf32>, vector<9xf32>
    %7 = vector.insert %6, %4 [2] : vector<9xf32> into vector<4x9xf32>
    %8 = affine.apply #map2()[%arg1]
    %9 = vector.transfer_read %arg0[%8, %arg2], %cst {in_bounds = [true]} : tensor<?x?xf32>, vector<9xf32>
    %10 = vector.insert %9, %7 [3] : vector<9xf32> into vector<4x9xf32>
    return %10 : vector<4x9xf32>
  }
}

// -----
#map = affine_map<()[s0] -> (s0 + 1)>
module {
  func.func @transfer_write_2d(%arg0: tensor<?x?xf32>, %arg1: vector<2x3xf32>, %arg2: index, %arg3: index) -> tensor<?x?xf32> {
    %0 = vector.extract %arg1[0] : vector<3xf32> from vector<2x3xf32>
    %1 = vector.transfer_write %0, %arg0[%arg2, %arg3] {in_bounds = [true]} : vector<3xf32>, tensor<?x?xf32>
    %2 = affine.apply #map()[%arg2]
    %3 = vector.extract %arg1[1] : vector<3xf32> from vector<2x3xf32>
    %4 = vector.transfer_write %3, %1[%2, %arg3] {in_bounds = [true]} : vector<3xf32>, tensor<?x?xf32>
    return %4 : tensor<?x?xf32>
  }
}

