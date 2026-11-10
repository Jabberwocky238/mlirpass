module {
  func.func @forall_store(%arg0: index) -> i32 {
    %c5_i32 = arith.constant 5 : i32
    %c7_i32 = arith.constant 7 : i32
    %alloca = memref.alloca() : memref<i32>
    memref.store %c5_i32, %alloca[] : memref<i32>
    scf.forall (%arg1) in (%arg0) {
      memref.store %c7_i32, %alloca[] : memref<i32>
    }
    %0 = memref.load %alloca[] : memref<i32>
    return %0 : i32
  }
}

// -----
module {
  func.func @forall_if_store(%arg0: index, %arg1: i1) -> i32 {
    %c5_i32 = arith.constant 5 : i32
    %c7_i32 = arith.constant 7 : i32
    %alloca = memref.alloca() : memref<i32>
    memref.store %c5_i32, %alloca[] : memref<i32>
    scf.forall (%arg2) in (%arg0) {
      scf.if %arg1 {
        memref.store %c7_i32, %alloca[] : memref<i32>
      }
    }
    %0 = memref.load %alloca[] : memref<i32>
    return %0 : i32
  }
}

// -----
module {
  func.func @parallel_store(%arg0: index, %arg1: index, %arg2: index) -> i32 {
    %c5_i32 = arith.constant 5 : i32
    %c7_i32 = arith.constant 7 : i32
    %alloca = memref.alloca() : memref<i32>
    memref.store %c5_i32, %alloca[] : memref<i32>
    scf.parallel (%arg3) = (%arg0) to (%arg1) step (%arg2) {
      memref.store %c7_i32, %alloca[] : memref<i32>
      scf.reduce 
    }
    %0 = memref.load %alloca[] : memref<i32>
    return %0 : i32
  }
}

// -----
module {
  func.func @parallel_if_store(%arg0: index, %arg1: index, %arg2: index, %arg3: i1) -> i32 {
    %c5_i32 = arith.constant 5 : i32
    %c7_i32 = arith.constant 7 : i32
    %alloca = memref.alloca() : memref<i32>
    memref.store %c5_i32, %alloca[] : memref<i32>
    scf.parallel (%arg4) = (%arg0) to (%arg1) step (%arg2) {
      scf.if %arg3 {
        memref.store %c7_i32, %alloca[] : memref<i32>
      }
      scf.reduce 
    }
    %0 = memref.load %alloca[] : memref<i32>
    return %0 : i32
  }
}

// -----
module {
  func.func @parallel_reduce_store(%arg0: index, %arg1: index, %arg2: index) -> i32 {
    %c5_i32 = arith.constant 5 : i32
    %c0_i32 = arith.constant 0 : i32
    %alloca = memref.alloca() : memref<i32>
    memref.store %c5_i32, %alloca[] : memref<i32>
    %0 = scf.parallel (%arg3) = (%arg0) to (%arg1) step (%arg2) init (%c0_i32) -> i32 {
      %c1_i32 = arith.constant 1 : i32
      scf.reduce(%c1_i32 : i32) {
      ^bb0(%arg4: i32, %arg5: i32):
        %2 = arith.addi %arg4, %arg5 : i32
        memref.store %2, %alloca[] : memref<i32>
        scf.reduce.return %2 : i32
      }
    }
    %1 = memref.load %alloca[] : memref<i32>
    return %1 : i32
  }
}

