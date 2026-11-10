module {
  func.func @memory_space_cast_non_integer_addrspace(%arg0: memref<128xi32, 3>) {
    %memspacecast = memref.memory_space_cast %arg0 : memref<128xi32, 3> to memref<128xi32, #gpu.address_space<workgroup>>
    return
  }
}

