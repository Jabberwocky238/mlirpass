module {
  llvm.func @shift_right_arithmetic_scalar(%arg0: i32, %arg1: i32, %arg2: i16, %arg3: i16) {
    %0 = llvm.ashr %arg0, %arg0 : i32
    %1 = llvm.ashr %arg0, %arg1 : i32
    %2 = llvm.sext %arg2 : i16 to i32
    %3 = llvm.ashr %arg0, %2 : i32
    %4 = llvm.zext %arg3 : i16 to i32
    %5 = llvm.ashr %arg0, %4 : i32
    llvm.return
  }
  llvm.func @shift_right_arithmetic_vector(%arg0: vector<4xi64>, %arg1: vector<4xi64>, %arg2: vector<4xi32>, %arg3: vector<4xi32>) {
    %0 = llvm.ashr %arg0, %arg0 : vector<4xi64>
    %1 = llvm.ashr %arg0, %arg1 : vector<4xi64>
    %2 = llvm.sext %arg2 : vector<4xi32> to vector<4xi64>
    %3 = llvm.ashr %arg0, %2 : vector<4xi64>
    %4 = llvm.zext %arg3 : vector<4xi32> to vector<4xi64>
    %5 = llvm.ashr %arg0, %4 : vector<4xi64>
    llvm.return
  }
  llvm.func @shift_right_logical_scalar(%arg0: i32, %arg1: i32, %arg2: i16, %arg3: i16) {
    %0 = llvm.lshr %arg0, %arg0 : i32
    %1 = llvm.lshr %arg0, %arg1 : i32
    %2 = llvm.sext %arg2 : i16 to i32
    %3 = llvm.lshr %arg0, %2 : i32
    %4 = llvm.zext %arg3 : i16 to i32
    %5 = llvm.lshr %arg0, %4 : i32
    llvm.return
  }
  llvm.func @shift_right_logical_vector(%arg0: vector<4xi64>, %arg1: vector<4xi64>, %arg2: vector<4xi32>, %arg3: vector<4xi32>) {
    %0 = llvm.lshr %arg0, %arg0 : vector<4xi64>
    %1 = llvm.lshr %arg0, %arg1 : vector<4xi64>
    %2 = llvm.sext %arg2 : vector<4xi32> to vector<4xi64>
    %3 = llvm.lshr %arg0, %2 : vector<4xi64>
    %4 = llvm.zext %arg3 : vector<4xi32> to vector<4xi64>
    %5 = llvm.lshr %arg0, %4 : vector<4xi64>
    llvm.return
  }
  llvm.func @shift_left_logical_scalar(%arg0: i32, %arg1: i32, %arg2: i16, %arg3: i16) {
    %0 = llvm.shl %arg0, %arg0 : i32
    %1 = llvm.shl %arg0, %arg1 : i32
    %2 = llvm.sext %arg2 : i16 to i32
    %3 = llvm.shl %arg0, %2 : i32
    %4 = llvm.zext %arg3 : i16 to i32
    %5 = llvm.shl %arg0, %4 : i32
    llvm.return
  }
  llvm.func @shift_left_logical_vector(%arg0: vector<4xi64>, %arg1: vector<4xi64>, %arg2: vector<4xi32>, %arg3: vector<4xi32>) {
    %0 = llvm.shl %arg0, %arg0 : vector<4xi64>
    %1 = llvm.shl %arg0, %arg1 : vector<4xi64>
    %2 = llvm.sext %arg2 : vector<4xi32> to vector<4xi64>
    %3 = llvm.shl %arg0, %2 : vector<4xi64>
    %4 = llvm.zext %arg3 : vector<4xi32> to vector<4xi64>
    %5 = llvm.shl %arg0, %4 : vector<4xi64>
    llvm.return
  }
}

