module {
  func.func @if(%arg0: i1, %arg1: tensor<?xf32>, %arg2: tensor<?xf32>) -> tensor<?xf32> {
    %0 = bufferization.to_buffer %arg2 : tensor<?xf32> to memref<?xf32>
    %1 = bufferization.to_buffer %arg1 : tensor<?xf32> to memref<?xf32>
    %2 = scf.if %arg0 -> (memref<?xf32>) {
      scf.yield %1 : memref<?xf32>
    } else {
      scf.yield %0 : memref<?xf32>
    }
    %3 = bufferization.to_tensor %2 : memref<?xf32> to tensor<?xf32>
    return %3 : tensor<?xf32>
  }
}

// -----
module {
  func.func @for(%arg0: tensor<f32>, %arg1: index, %arg2: index, %arg3: index) -> tensor<f32> {
    %0 = bufferization.to_buffer %arg0 : tensor<f32> to memref<f32>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<f32>
    memref.copy %0, %alloc : memref<f32> to memref<f32>
    %1 = scf.for %arg4 = %arg1 to %arg2 step %arg3 iter_args(%arg5 = %alloc) -> (memref<f32>) {
      scf.yield %arg5 : memref<f32>
    } {some_attr}
    %2 = bufferization.to_tensor %1 : memref<f32> to tensor<f32>
    return %2 : tensor<f32>
  }
}

// -----
module {
  func.func @if_correct_recursive_legalization_behavior(%arg0: i1, %arg1: tensor<f32>) -> tensor<f32> {
    %0 = scf.if %arg0 -> (memref<f32>) {
      %2 = "test.munge_tensor"(%arg1) : (tensor<f32>) -> tensor<f32>
      %3 = bufferization.to_buffer %2 : tensor<f32> to memref<f32>
      scf.yield %3 : memref<f32>
    } else {
      %2 = "test.munge_tensor"(%arg1) : (tensor<f32>) -> tensor<f32>
      %3 = bufferization.to_buffer %2 : tensor<f32> to memref<f32>
      scf.yield %3 : memref<f32>
    }
    %1 = bufferization.to_tensor %0 : memref<f32> to tensor<f32>
    return %1 : tensor<f32>
  }
}

// -----
module {
  func.func @for_correct_recursive_legalization_behavior(%arg0: tensor<f32>, %arg1: index) -> tensor<f32> {
    %0 = bufferization.to_buffer %arg0 : tensor<f32> to memref<f32>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<f32>
    memref.copy %0, %alloc : memref<f32> to memref<f32>
    %1 = scf.for %arg2 = %arg1 to %arg1 step %arg1 iter_args(%arg3 = %alloc) -> (memref<f32>) {
      %3 = bufferization.to_tensor %arg3 : memref<f32> to tensor<f32>
      %4 = "test.munge_tensor"(%3) : (tensor<f32>) -> tensor<f32>
      %5 = bufferization.to_buffer %4 : tensor<f32> to memref<f32>
      scf.yield %5 : memref<f32>
    }
    %2 = bufferization.to_tensor %1 : memref<f32> to tensor<f32>
    return %2 : tensor<f32>
  }
}

// -----
module {
  func.func @bufferize_while(%arg0: i64, %arg1: i64, %arg2: tensor<f32>) -> (i64, tensor<f32>) {
    %0 = bufferization.to_buffer %arg2 : tensor<f32> to memref<f32>
    %c2_i64 = arith.constant 2 : i64
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<f32>
    memref.copy %0, %alloc : memref<f32> to memref<f32>
    %1:3 = scf.while (%arg3 = %arg0, %arg4 = %alloc) : (i64, memref<f32>) -> (i64, i64, memref<f32>) {
      %3 = arith.cmpi slt, %arg3, %arg1 : i64
      scf.condition(%3) %arg3, %arg3, %arg4 : i64, i64, memref<f32>
    } do {
    ^bb0(%arg3: i64, %arg4: i64, %arg5: memref<f32>):
      %3 = arith.muli %arg4, %c2_i64 : i64
      scf.yield %3, %arg5 : i64, memref<f32>
    }
    %2 = bufferization.to_tensor %1#2 : memref<f32> to tensor<f32>
    return %1#1, %2 : i64, tensor<f32>
  }
}

