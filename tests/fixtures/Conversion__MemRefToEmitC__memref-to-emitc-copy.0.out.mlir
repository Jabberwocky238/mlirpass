module {
  emitc.include <"cstring">
  func.func @copying(%arg0: memref<9x4x5x7xf32>, %arg1: memref<9x4x5x7xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<9x4x5x7xf32> to !emitc.array<9x4x5x7xf32>
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<9x4x5x7xf32> to !emitc.array<9x4x5x7xf32>
    %2 = "emitc.constant"() <{value = 0 : index}> : () -> index
    %3 = emitc.subscript %1[%2, %2, %2, %2] : (!emitc.array<9x4x5x7xf32>, index, index, index, index) -> !emitc.lvalue<f32>
    %4 = emitc.address_of %3 : !emitc.lvalue<f32>
    %5 = "emitc.constant"() <{value = 0 : index}> : () -> index
    %6 = emitc.subscript %0[%5, %5, %5, %5] : (!emitc.array<9x4x5x7xf32>, index, index, index, index) -> !emitc.lvalue<f32>
    %7 = emitc.address_of %6 : !emitc.lvalue<f32>
    %8 = emitc.call_opaque "sizeof"() {args = [f32]} : () -> !emitc.size_t
    %9 = "emitc.constant"() <{value = 1260 : index}> : () -> index
    %10 = emitc.mul %8, %9 : (!emitc.size_t, index) -> !emitc.size_t
    emitc.call_opaque "memcpy"(%7, %4, %10) : (!emitc.ptr<f32>, !emitc.ptr<f32>, !emitc.size_t) -> ()
    return
  }
}

