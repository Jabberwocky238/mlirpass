module {
  func.func @update_no_op(%arg0: memref<i32>) {
    return
  }
}

// -----
module {
  func.func @update_write_op(%arg0: memref<i32>, %arg1: i32) {
    omp.atomic.write %arg0 = %arg1 : memref<i32>, i32
    return
  }
}

// -----
module {
  func.func @update_normal(%arg0: memref<i32>, %arg1: i32) {
    omp.atomic.update %arg0 : memref<i32> {
    ^bb0(%arg2: i32):
      %0 = arith.addi %arg2, %arg1 : i32
      omp.yield(%0 : i32)
    }
    return
  }
}

// -----
module {
  func.func @update_unnecessary_computations(%arg0: memref<i32>) {
    return
  }
}

// -----
module {
  func.func @update_unnecessary_computations(%arg0: memref<i32>) {
    %c0_i32 = arith.constant 0 : i32
    omp.atomic.write %arg0 = %c0_i32 : memref<i32>, i32
    return
  }
}

// -----
module {
  func.func @parallel_empty() {
    return
  }
}

// -----
module {
  func.func @parallel_only_terminator() {
    return
  }
}

// -----
module {
  func.func @parallel_no_side_effects(%arg0: i32, %arg1: i32) {
    return
  }
}

// -----
module {
  func.func @parallel_maybe_side_effects(%arg0: i32, %arg1: i32) {
    omp.parallel {
      func.call @foo() : () -> ()
      omp.terminator
    }
    return
  }
  func.func private @foo()
}

// -----
module {
  func.func @constant_hoisting_target(%arg0: !llvm.ptr) {
    omp.target {
      %c10_i32 = arith.constant 10 : i32
      llvm.store %c10_i32, %arg1 : i32, !llvm.ptr
      omp.terminator
    }
    return
  }
}

