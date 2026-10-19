module {
  llvm.func @pointerUniformConstant(!llvm.ptr)
  llvm.mlir.global external constant @varUniformConstant() {addr_space = 0 : i32} : i1
  llvm.func @pointerInput(!llvm.ptr)
  llvm.mlir.global external constant @varInput() {addr_space = 0 : i32} : i1
  llvm.func @pointerUniform(!llvm.ptr)
  llvm.func @pointerOutput(!llvm.ptr)
  llvm.mlir.global external @varOutput() {addr_space = 0 : i32} : i1
  llvm.func @pointerWorkgroup(!llvm.ptr)
  llvm.func @pointerCrossWorkgroup(!llvm.ptr)
  llvm.func @pointerPrivate(!llvm.ptr)
  llvm.mlir.global private @varPrivate() {addr_space = 0 : i32} : i1
  llvm.func @pointerFunction(!llvm.ptr)
  llvm.func @pointerGeneric(!llvm.ptr)
  llvm.func @pointerPushConstant(!llvm.ptr)
  llvm.func @pointerAtomicCounter(!llvm.ptr)
  llvm.func @pointerImage(!llvm.ptr)
  llvm.func @pointerStorageBuffer(!llvm.ptr)
  llvm.mlir.global external @varStorageBuffer() {addr_space = 0 : i32} : i1
  llvm.func @pointerCallableDataKHR(!llvm.ptr)
  llvm.func @pointerIncomingCallableDataKHR(!llvm.ptr)
  llvm.func @pointerRayPayloadKHR(!llvm.ptr)
  llvm.func @pointerHitAttributeKHR(!llvm.ptr)
  llvm.func @pointerIncomingRayPayloadKHR(!llvm.ptr)
  llvm.func @pointerShaderRecordBufferKHR(!llvm.ptr)
  llvm.func @pointerPhysicalStorageBuffer(!llvm.ptr)
  llvm.func @pointerCodeSectionINTEL(!llvm.ptr)
  llvm.func @pointerDeviceOnlyINTEL(!llvm.ptr)
  llvm.func @pointerHostOnlyINTEL(!llvm.ptr)
}

