module {
  memref.global "private" @global_i32 : memref<1xi32> = dense<66560>
  memref.global "private" @global_i64 : memref<1xi64> = dense<37017>
  memref.global "private" @global_f32 : memref<1xf32> = dense<1.250000e-01>
  memref.global "private" @global_f64 : memref<1xf64> = dense<3.140000e+00>
  memref.global "private" @global_user0 : memref<1xi32> = uninitialized
  func.func @"global_user0::initializer"() attributes {initializer} {
    %0 = memref.get_global @"module::extern_global_var" : memref<1xi32>
    %1 = memref.get_global @global_user0 : memref<1xi32>
    %c0 = arith.constant 0 : index
    %2 = memref.load %0[%c0] : memref<1xi32>
    memref.store %2, %1[%c0] : memref<1xi32>
    return
  }
  memref.global "nested" constant @"module::extern_global_var" : memref<1xi32>
}

