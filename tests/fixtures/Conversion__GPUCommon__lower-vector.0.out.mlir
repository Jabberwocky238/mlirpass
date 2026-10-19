module {
  llvm.func @func(%arg0: vector<11xf32>) -> vector<11xf32> {
    llvm.return %arg0 : vector<11xf32>
  }
}

