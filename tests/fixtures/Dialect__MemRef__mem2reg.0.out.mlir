module {
  func.func @basic() -> i32 {
    %c5_i32 = arith.constant 5 : i32
    return %c5_i32 : i32
  }
}

// -----
module {
  func.func @basic_default() -> i32 {
    %0 = ub.poison : i32
    %c5_i32 = arith.constant 5 : i32
    return %0 : i32
  }
}

// -----
module {
  func.func @basic_float() -> f32 {
    %cst = arith.constant 5.200000e+00 : f32
    return %cst : f32
  }
}

// -----
module {
  func.func @basic_ranked() -> i32 {
    %c0 = arith.constant 0 : index
    %c5_i32 = arith.constant 5 : i32
    return %c5_i32 : i32
  }
}

// -----
module {
  func.func @reject_multiple_elements() -> i32 {
    %c0 = arith.constant 0 : index
    %c5_i32 = arith.constant 5 : i32
    %alloca = memref.alloca() : memref<1x2xi32>
    memref.store %c5_i32, %alloca[%c0, %c0] : memref<1x2xi32>
    %0 = memref.load %alloca[%c0, %c0] : memref<1x2xi32>
    return %0 : i32
  }
}

// -----
module {
  func.func @cycle(%arg0: i64, %arg1: i1, %arg2: i64) {
    cf.cond_br %arg1, ^bb1(%arg2 : i64), ^bb2(%arg2 : i64)
  ^bb1(%0: i64):  // 2 preds: ^bb0, ^bb2
    call @use(%0) : (i64) -> ()
    cf.br ^bb2(%arg0 : i64)
  ^bb2(%1: i64):  // 2 preds: ^bb0, ^bb1
    cf.br ^bb1(%1 : i64)
  }
  func.func @use(%arg0: i64) {
    return
  }
}

// -----
module {
  func.func @recursive(%arg0: i64) -> i64 {
    return %arg0 : i64
  }
}

// -----
module {
  func.func @deny_store_of_alloca(%arg0: memref<memref<i32>>) -> i32 {
    %c5_i32 = arith.constant 5 : i32
    %alloca = memref.alloca() : memref<i32>
    memref.store %c5_i32, %alloca[] : memref<i32>
    memref.store %alloca, %arg0[] : memref<memref<i32>>
    %0 = memref.load %alloca[] : memref<i32>
    return %0 : i32
  }
}

// -----
module {
  func.func @promotable_nonpromotable_intertwined() -> i32 {
    %alloca = memref.alloca() : memref<i32>
    call @use(%alloca) : (memref<i32>) -> ()
    %0 = memref.load %alloca[] : memref<i32>
    return %0 : i32
  }
  func.func @use(%arg0: memref<i32>) {
    return
  }
}

