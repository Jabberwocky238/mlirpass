module @test_illegal_vector {
  llvm.func @test_illegal_vector(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: !llvm.ptr, %arg4: !llvm.ptr) {
    %0 = llvm.load %arg0 : !llvm.ptr -> vector<8xi16>
    %1 = llvm.bitcast %0 : vector<8xi16> to vector<8xf16>
    %2 = llvm.fpext %1 : vector<8xf16> to vector<8xf32>
    %3 = llvm.getelementptr %arg0[8] : (!llvm.ptr) -> !llvm.ptr, i16
    %4 = llvm.load %3 : !llvm.ptr -> vector<8xi16>
    %5 = llvm.bitcast %4 : vector<8xi16> to vector<8xf16>
    %6 = llvm.fpext %5 : vector<8xf16> to vector<8xf32>
    %7 = llvm.bitcast %2 : vector<8xf32> to vector<8xi32>
    llvm.store %7, %arg1 : vector<8xi32>, !llvm.ptr
    %8 = llvm.bitcast %6 : vector<8xf32> to vector<8xi32>
    llvm.store %8, %arg2 : vector<8xi32>, !llvm.ptr
    %9 = llvm.getelementptr %arg0[16] : (!llvm.ptr) -> !llvm.ptr, i16
    %10 = llvm.load %9 : !llvm.ptr -> vector<8xi16>
    %11 = llvm.bitcast %10 : vector<8xi16> to vector<8xf16>
    %12 = llvm.fpext %11 : vector<8xf16> to vector<8xf32>
    %13 = llvm.getelementptr %arg0[24] : (!llvm.ptr) -> !llvm.ptr, i16
    %14 = llvm.load %13 : !llvm.ptr -> vector<8xi16>
    %15 = llvm.bitcast %14 : vector<8xi16> to vector<8xf16>
    %16 = llvm.fpext %15 : vector<8xf16> to vector<8xf32>
    %17 = llvm.bitcast %12 : vector<8xf32> to vector<8xi32>
    llvm.store %17, %arg3 : vector<8xi32>, !llvm.ptr
    %18 = llvm.bitcast %16 : vector<8xf32> to vector<8xi32>
    llvm.store %18, %arg4 : vector<8xi32>, !llvm.ptr
    llvm.return
  }
}

// -----
module @test_match_fail {
  llvm.func @test_match_fail(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: !llvm.ptr) {
    %0 = llvm.load %arg0 : !llvm.ptr -> vector<4xi16>
    %1 = llvm.load %arg1 : !llvm.ptr -> vector<4xi16>
    %2 = llvm.shufflevector %0, %1 [0, 1, 2, 3, 4, 5, 6, 7] : vector<4xi16> 
    %3 = llvm.shufflevector %0, %0 [0, 1, 2, 3, 4, 5, 6, 7] : vector<4xi16> 
    %4 = llvm.shufflevector %2, %2 [0, 1, 2, 3, 4, 5] : vector<8xi16> 
    %5 = llvm.shufflevector %3, %3 [0, 1, 2, 3, 4, 5] : vector<8xi16> 
    llvm.store %4, %arg2 : vector<6xi16>, !llvm.ptr
    llvm.store %5, %arg3 : vector<6xi16>, !llvm.ptr
    llvm.return
  }
}

// -----
module @test_non_private_addrspace {
  llvm.func @test_non_private_addrspace(%arg0: !llvm.ptr<1>, %arg1: !llvm.ptr<1>, %arg2: !llvm.ptr<1>) {
    %0 = llvm.load %arg0 : !llvm.ptr<1> -> vector<8xi16>
    %1 = llvm.shufflevector %0, %0 [0, 1, 2, 3] : vector<8xi16> 
    %2 = llvm.shufflevector %0, %0 [4, 5, 6, 7] : vector<8xi16> 
    llvm.store %1, %arg1 : vector<4xi16>, !llvm.ptr<1>
    llvm.store %2, %arg2 : vector<4xi16>, !llvm.ptr<1>
    llvm.return
  }
}

