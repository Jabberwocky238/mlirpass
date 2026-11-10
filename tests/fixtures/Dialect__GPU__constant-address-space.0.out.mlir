module {
  gpu.module @test {
    gpu.func @constant_memref_basic(%arg0: memref<16xf32, #gpu.address_space<constant>>) kernel {
      %c0 = arith.constant 0 : index
      %0 = memref.load %arg0[%c0] : memref<16xf32, #gpu.address_space<constant>>
      gpu.return
    }
    gpu.func @constant_memref_multidim(%arg0: memref<4x8xf32, #gpu.address_space<constant>>) kernel {
      gpu.return
    }
    gpu.func @constant_memref_dynamic(%arg0: memref<?x?xf32, #gpu.address_space<constant>>) kernel {
      gpu.return
    }
  }
}

