module {
  func.func @genbool_var_1d(%arg0: index) -> vector<11xi1> {
    %cst = arith.constant dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]> : vector<11xi32>
    %c2147483647 = arith.constant 2147483647 : index
    %0 = arith.minsi %arg0, %c2147483647 : index
    %1 = arith.index_cast %0 : index to i32
    %2 = llvm.mlir.poison : vector<11xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<11xi32>
    %5 = llvm.shufflevector %4, %2 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<11xi32> 
    %6 = arith.cmpi sgt, %5, %cst : vector<11xi32>
    return %6 : vector<11xi1>
  }
  func.func @genbool_var_1d_scalable(%arg0: index) -> vector<[11]xi1> {
    %0 = llvm.intr.stepvector : vector<[11]xi32>
    %c2147483647 = arith.constant 2147483647 : index
    %1 = arith.minsi %arg0, %c2147483647 : index
    %2 = arith.index_cast %1 : index to i32
    %3 = llvm.mlir.poison : vector<[11]xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<[11]xi32>
    %6 = llvm.shufflevector %5, %3 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<[11]xi32> 
    %7 = arith.cmpi slt, %0, %6 : vector<[11]xi32>
    return %7 : vector<[11]xi1>
  }
}

