module {
  func.func @testenterdataop(%arg0: memref<f32>) {
    %0 = acc.create varPtr(%arg0 : memref<f32>) -> memref<f32>
    acc.enter_data dataOperands(%0 : memref<f32>)
    return
  }
}

// -----
module {
  func.func @testenterdataop(%arg0: memref<f32>) {
    %0 = acc.create varPtr(%arg0 : memref<f32>) -> memref<f32>
    return
  }
}

// -----
module {
  func.func @testexitdataop(%arg0: memref<f32>) {
    %0 = acc.getdeviceptr varPtr(%arg0 : memref<f32>) -> memref<f32>
    acc.exit_data dataOperands(%0 : memref<f32>)
    acc.delete accPtr(%0 : memref<f32>)
    return
  }
}

// -----
module {
  func.func @testexitdataop(%arg0: memref<f32>) {
    %0 = acc.getdeviceptr varPtr(%arg0 : memref<f32>) -> memref<f32>
    acc.delete accPtr(%0 : memref<f32>)
    return
  }
}

// -----
module {
  func.func @testupdateop(%arg0: memref<f32>) {
    %0 = acc.getdeviceptr varPtr(%arg0 : memref<f32>) -> memref<f32>
    acc.update_host accPtr(%0 : memref<f32>) to varPtr(%arg0 : memref<f32>)
    acc.update dataOperands(%0 : memref<f32>)
    return
  }
}

// -----
module {
  func.func @testupdateop(%arg0: memref<f32>) {
    %0 = acc.getdeviceptr varPtr(%arg0 : memref<f32>) -> memref<f32>
    acc.update_host accPtr(%0 : memref<f32>) to varPtr(%arg0 : memref<f32>)
    return
  }
}

// -----
module {
  func.func @testenterdataop(%arg0: memref<f32>, %arg1: i1) {
    %0 = acc.create varPtr(%arg0 : memref<f32>) -> memref<f32>
    acc.enter_data if(%arg1) dataOperands(%0 : memref<f32>)
    return
  }
}

// -----
module {
  func.func @testexitdataop(%arg0: memref<f32>, %arg1: i1) {
    %0 = acc.getdeviceptr varPtr(%arg0 : memref<f32>) -> memref<f32>
    acc.exit_data if(%arg1) dataOperands(%0 : memref<f32>)
    acc.delete accPtr(%0 : memref<f32>)
    return
  }
}

// -----
module {
  func.func @testupdateop(%arg0: memref<f32>, %arg1: i1) {
    %0 = acc.getdeviceptr varPtr(%arg0 : memref<f32>) -> memref<f32>
    acc.update_host accPtr(%0 : memref<f32>) to varPtr(%arg0 : memref<f32>)
    acc.update if(%arg1) dataOperands(%0 : memref<f32>)
    return
  }
}

// -----
module {
  func.func @testhostdataop(%arg0: memref<f32>, %arg1: i1) {
    %c10_i32 = arith.constant 10 : i32
    %c1_i32 = arith.constant 1 : i32
    acc.loop control(%arg2 : i32) = (%c1_i32 : i32) to (%c10_i32 : i32)  step (%c1_i32 : i32) {
      acc.yield
    } attributes {inclusiveUpperbound = array<i1: true>, independent = [#acc.device_type<none>]}
    acc.loop control(%arg2 : i32) = (%c1_i32 : i32) to (%c10_i32 : i32)  step (%c1_i32 : i32) {
      acc.yield
    } attributes {inclusiveUpperbound = array<i1: true>, independent = [#acc.device_type<none>]}
    return
  }
}

// -----
module {
  func.func @testhostdataop(%arg0: memref<f32>, %arg1: i1) {
    %0 = acc.use_device varPtr(%arg0 : memref<f32>) -> memref<f32>
    acc.host_data dataOperands(%0 : memref<f32>) {
    }
    return
  }
}

// -----
module {
  func.func @update_no_op(%arg0: memref<i32>) {
    return
  }
}

// -----
module {
  func.func @update_write_op(%arg0: memref<i32>, %arg1: i32) {
    acc.atomic.write %arg0 = %arg1 : memref<i32>, i32
    return
  }
}

// -----
module {
  func.func @update_normal(%arg0: memref<i32>, %arg1: i32) {
    acc.atomic.update %arg0 : memref<i32> {
    ^bb0(%arg2: i32):
      %0 = arith.addi %arg2, %arg1 : i32
      acc.yield %0 : i32
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
    acc.atomic.write %arg0 = %c0_i32 : memref<i32>, i32
    return
  }
}

// -----
module {
  func.func @kernel_environment_canonicalization(%arg0: i32, %arg1: i32, %arg2: i32) {
    acc.wait(%arg0, %arg1 : i32, i32)
    acc.wait
    acc.kernel_environment wait({%arg2 : i32} [#acc.device_type<nvidia>]) {
    }
    return
  }
}

