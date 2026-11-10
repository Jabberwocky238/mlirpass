module {
  llvm.func @logical_equal_scalar(%arg0: i1, %arg1: i1) {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i1
    llvm.return
  }
  llvm.func @logical_equal_vector(%arg0: vector<4xi1>, %arg1: vector<4xi1>) {
    %0 = llvm.icmp "eq" %arg0, %arg1 : vector<4xi1>
    llvm.return
  }
  llvm.func @logical_not_equal_scalar(%arg0: i1, %arg1: i1) {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i1
    llvm.return
  }
  llvm.func @logical_not_equal_vector(%arg0: vector<4xi1>, %arg1: vector<4xi1>) {
    %0 = llvm.icmp "ne" %arg0, %arg1 : vector<4xi1>
    llvm.return
  }
  llvm.func @logical_not_scalar(%arg0: i1) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0 : i1
    llvm.return
  }
  llvm.func @logical_not_vector(%arg0: vector<4xi1>) {
    %0 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %1 = llvm.xor %arg0, %0 : vector<4xi1>
    llvm.return
  }
  llvm.func @logical_and_scalar(%arg0: i1, %arg1: i1) {
    %0 = llvm.and %arg0, %arg1 : i1
    llvm.return
  }
  llvm.func @logical_and_vector(%arg0: vector<4xi1>, %arg1: vector<4xi1>) {
    %0 = llvm.and %arg0, %arg1 : vector<4xi1>
    llvm.return
  }
  llvm.func @logical_or_scalar(%arg0: i1, %arg1: i1) {
    %0 = llvm.or %arg0, %arg1 : i1
    llvm.return
  }
  llvm.func @logical_or_vector(%arg0: vector<4xi1>, %arg1: vector<4xi1>) {
    %0 = llvm.or %arg0, %arg1 : vector<4xi1>
    llvm.return
  }
  llvm.func @ordered_scalar(%arg0: f32, %arg1: f32) {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f32
    llvm.return
  }
  llvm.func @ordered_vector(%arg0: vector<4xf32>, %arg1: vector<4xf32>) {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : vector<4xf32>
    llvm.return
  }
  llvm.func @unordered_scalar(%arg0: f32, %arg1: f32) {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f32
    llvm.return
  }
  llvm.func @unordered_vector(%arg0: vector<4xf32>, %arg1: vector<4xf32>) {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : vector<4xf32>
    llvm.return
  }
}

