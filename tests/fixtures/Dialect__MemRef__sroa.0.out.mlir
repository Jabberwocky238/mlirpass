module {
  func.func @basic(%arg0: i32, %arg1: i32) -> i32 {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %alloca = memref.alloca() : memref<i32>
    %alloca_0 = memref.alloca() : memref<i32>
    memref.store %arg0, %alloca[] : memref<i32>
    memref.store %arg1, %alloca_0[] : memref<i32>
    %0 = memref.load %alloca[] : memref<i32>
    return %0 : i32
  }
}

// -----
module {
  func.func @basic_high_dimensions(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %alloca = memref.alloca() : memref<i32>
    %alloca_0 = memref.alloca() : memref<i32>
    %alloca_1 = memref.alloca() : memref<i32>
    memref.store %arg0, %alloca_1[] : memref<i32>
    memref.store %arg1, %alloca[] : memref<i32>
    memref.store %arg2, %alloca_0[] : memref<i32>
    %0 = memref.load %alloca[] : memref<i32>
    return %0 : i32
  }
}

// -----
module {
  func.func @resolve_alias(%arg0: i32, %arg1: i32) -> i32 {
    %c0 = arith.constant 0 : index
    %alloca = memref.alloca() : memref<i32>
    memref.store %arg0, %alloca[] : memref<i32>
    memref.store %arg1, %alloca[] : memref<i32>
    %0 = memref.load %alloca[] : memref<i32>
    return %0 : i32
  }
}

// -----
module {
  func.func @no_direct_use(%arg0: i32, %arg1: i32) -> i32 {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %alloca = memref.alloca() : memref<2xi32>
    memref.store %arg0, %alloca[%c0] : memref<2xi32>
    memref.store %arg1, %alloca[%c1] : memref<2xi32>
    %0 = memref.load %alloca[%c0] : memref<2xi32>
    call @use(%alloca) : (memref<2xi32>) -> ()
    return %0 : i32
  }
  func.func @use(%arg0: memref<2xi32>) {
    return
  }
}

// -----
module {
  func.func @no_dynamic_indexing(%arg0: i32, %arg1: i32, %arg2: index) -> i32 {
    %c0 = arith.constant 0 : index
    %alloca = memref.alloca() : memref<2xi32>
    memref.store %arg0, %alloca[%c0] : memref<2xi32>
    memref.store %arg1, %alloca[%arg2] : memref<2xi32>
    %0 = memref.load %alloca[%c0] : memref<2xi32>
    return %0 : i32
  }
}

// -----
module {
  func.func @no_dynamic_shape(%arg0: i32, %arg1: i32) -> i32 {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %alloca = memref.alloca(%c1) : memref<?x2xi32>
    memref.store %arg0, %alloca[%c0, %c0] : memref<?x2xi32>
    %0 = memref.load %alloca[%c0, %c0] : memref<?x2xi32>
    return %0 : i32
  }
}

// -----
module {
  func.func @no_out_of_bound_write(%arg0: i32, %arg1: i32) -> i32 {
    %c0 = arith.constant 0 : index
    %c100 = arith.constant 100 : index
    %alloca = memref.alloca() : memref<2xi32>
    memref.store %arg0, %alloca[%c0] : memref<2xi32>
    memref.store %arg1, %alloca[%c100] : memref<2xi32>
    %0 = memref.load %alloca[%c0] : memref<2xi32>
    return %0 : i32
  }
}

// -----
module {
  func.func @no_out_of_bound_load(%arg0: i32, %arg1: i32) -> i32 {
    %c0 = arith.constant 0 : index
    %c100 = arith.constant 100 : index
    %alloca = memref.alloca() : memref<2xi32>
    memref.store %arg0, %alloca[%c0] : memref<2xi32>
    %0 = memref.load %alloca[%c100] : memref<2xi32>
    return %0 : i32
  }
}

