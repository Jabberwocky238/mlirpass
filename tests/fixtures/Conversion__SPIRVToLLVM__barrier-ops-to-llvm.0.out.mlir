module {
  llvm.func spir_funccc @_Z22__spirv_ControlBarrieriii(i32, i32, i32) attributes {convergent, no_unwind, will_return}
  llvm.func @control_barrier() {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(768 : i32) : i32
    llvm.call spir_funccc @_Z22__spirv_ControlBarrieriii(%0, %1, %2) {convergent, no_unwind, will_return} : (i32, i32, i32) -> ()
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(256 : i32) : i32
    llvm.call spir_funccc @_Z22__spirv_ControlBarrieriii(%3, %4, %5) {convergent, no_unwind, will_return} : (i32, i32, i32) -> ()
    llvm.return
  }
}

// -----
module {
  llvm.func spir_funccc @_Z31__spirv_ControlBarrierWaitINTELiii(i32, i32, i32) attributes {convergent, no_unwind, will_return}
  llvm.func spir_funccc @_Z33__spirv_ControlBarrierArriveINTELiii(i32, i32, i32) attributes {convergent, no_unwind, will_return}
  llvm.func @split_barrier() {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(768 : i32) : i32
    llvm.call spir_funccc @_Z33__spirv_ControlBarrierArriveINTELiii(%0, %1, %2) {convergent, no_unwind, will_return} : (i32, i32, i32) -> ()
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(256 : i32) : i32
    llvm.call spir_funccc @_Z31__spirv_ControlBarrierWaitINTELiii(%3, %4, %5) {convergent, no_unwind, will_return} : (i32, i32, i32) -> ()
    llvm.return
  }
}

