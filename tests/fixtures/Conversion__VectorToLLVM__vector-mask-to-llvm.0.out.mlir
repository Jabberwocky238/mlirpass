module {
  func.func @genbool_var_1d(%arg0: index) -> vector<11xi1> {
    %cst = arith.constant dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]> : vector<11xi32>
    %0 = arith.index_cast %arg0 : index to i32
    %1 = llvm.mlir.poison : vector<11xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : vector<11xi32>
    %4 = llvm.shufflevector %3, %1 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<11xi32> 
    %5 = arith.cmpi sgt, %4, %cst : vector<11xi32>
    return %5 : vector<11xi1>
  }
  func.func @genbool_var_1d_scalable(%arg0: index) -> vector<[11]xi1> {
    %0 = llvm.intr.stepvector : vector<[11]xi32>
    %1 = arith.index_cast %arg0 : index to i32
    %2 = llvm.mlir.poison : vector<[11]xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<[11]xi32>
    %5 = llvm.shufflevector %4, %2 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<[11]xi32> 
    %6 = arith.cmpi slt, %0, %5 : vector<[11]xi32>
    return %6 : vector<[11]xi1>
  }
}

