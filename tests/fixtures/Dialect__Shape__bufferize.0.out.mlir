module {
}

// -----
module {
  func.func @shape_assuming() {
    %0 = shape.const_witness true
    %1 = shape.assuming %0 -> (memref<2xf16>) {
      %3 = "test.source"() : () -> tensor<2xf16>
      %4 = bufferization.to_buffer %3 : tensor<2xf16> to memref<2xf16>
      shape.assuming_yield %4 : memref<2xf16>
    }
    %2 = bufferization.to_tensor %1 : memref<2xf16> to tensor<2xf16>
    "test.sink"(%2) : (tensor<2xf16>) -> ()
    return
  }
}

