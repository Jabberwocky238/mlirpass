module {
  llvm.func spir_funccc @_Z33__spirv_GroupNonUniformLogicalXoriib(i32, i32, i1) -> i1 attributes {convergent, no_unwind, will_return}
  llvm.func spir_funccc @_Z32__spirv_GroupNonUniformLogicalOriib(i32, i32, i1) -> i1 attributes {convergent, no_unwind, will_return}
  llvm.func spir_funccc @_Z33__spirv_GroupNonUniformLogicalAndiib(i32, i32, i1) -> i1 attributes {convergent, no_unwind, will_return}
  llvm.func spir_funccc @_Z33__spirv_GroupNonUniformBitwiseXoriij(i32, i32, i32) -> i32 attributes {convergent, no_unwind, will_return}
  llvm.func spir_funccc @_Z32__spirv_GroupNonUniformBitwiseOriij(i32, i32, i32) -> i32 attributes {convergent, no_unwind, will_return}
  llvm.func spir_funccc @_Z33__spirv_GroupNonUniformBitwiseAndiij(i32, i32, i32) -> i32 attributes {convergent, no_unwind, will_return}
  llvm.func spir_funccc @_Z27__spirv_GroupNonUniformSMaxiijj(i32, i32, i32, i32) -> i32 attributes {convergent, no_unwind, will_return}
  llvm.func spir_funccc @_Z27__spirv_GroupNonUniformFMaxiif(i32, i32, f32) -> f32 attributes {convergent, no_unwind, will_return}
  llvm.func spir_funccc @_Z27__spirv_GroupNonUniformUMaxiij(i32, i32, i32) -> i32 attributes {convergent, no_unwind, will_return}
  llvm.func spir_funccc @_Z27__spirv_GroupNonUniformSMaxiij(i32, i32, i32) -> i32 attributes {convergent, no_unwind, will_return}
  llvm.func spir_funccc @_Z27__spirv_GroupNonUniformFMiniifj(i32, i32, f32, i32) -> f32 attributes {convergent, no_unwind, will_return}
  llvm.func spir_funccc @_Z27__spirv_GroupNonUniformFMiniif(i32, i32, f32) -> f32 attributes {convergent, no_unwind, will_return}
  llvm.func spir_funccc @_Z27__spirv_GroupNonUniformUMiniij(i32, i32, i32) -> i32 attributes {convergent, no_unwind, will_return}
  llvm.func spir_funccc @_Z27__spirv_GroupNonUniformSMiniij(i32, i32, i32) -> i32 attributes {convergent, no_unwind, will_return}
  llvm.func spir_funccc @_Z27__spirv_GroupNonUniformFMuliif(i32, i32, f32) -> f32 attributes {convergent, no_unwind, will_return}
  llvm.func spir_funccc @_Z27__spirv_GroupNonUniformIMuliijj(i32, i32, i32, i32) -> i32 attributes {convergent, no_unwind, will_return}
  llvm.func spir_funccc @_Z27__spirv_GroupNonUniformFAddiifj(i32, i32, f32, i32) -> f32 attributes {convergent, no_unwind, will_return}
  llvm.func spir_funccc @_Z27__spirv_GroupNonUniformIAddiij(i32, i32, i32) -> i32 attributes {convergent, no_unwind, will_return}
  llvm.func @non_uniform_iadd(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call spir_funccc @_Z27__spirv_GroupNonUniformIAddiij(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @non_uniform_fadd(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.call spir_funccc @_Z27__spirv_GroupNonUniformFAddiifj(%1, %2, %arg0, %0) {convergent, no_unwind, will_return} : (i32, i32, f32, i32) -> f32
    llvm.return %3 : f32
  }
  llvm.func @non_uniform_imul(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.call spir_funccc @_Z27__spirv_GroupNonUniformIMuliijj(%1, %2, %arg0, %0) {convergent, no_unwind, will_return} : (i32, i32, i32, i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @non_uniform_fmul(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call spir_funccc @_Z27__spirv_GroupNonUniformFMuliif(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @non_uniform_smin(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call spir_funccc @_Z27__spirv_GroupNonUniformSMiniij(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @non_uniform_umin(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call spir_funccc @_Z27__spirv_GroupNonUniformUMiniij(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @non_uniform_fmin(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call spir_funccc @_Z27__spirv_GroupNonUniformFMiniif(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @non_uniform_fmin_cluster(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.call spir_funccc @_Z27__spirv_GroupNonUniformFMiniifj(%1, %2, %arg0, %0) {convergent, no_unwind, will_return} : (i32, i32, f32, i32) -> f32
    llvm.return %3 : f32
  }
  llvm.func @non_uniform_smax(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call spir_funccc @_Z27__spirv_GroupNonUniformSMaxiij(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @non_uniform_umax(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call spir_funccc @_Z27__spirv_GroupNonUniformUMaxiij(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @non_uniform_fmax(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call spir_funccc @_Z27__spirv_GroupNonUniformFMaxiif(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @non_uniform_smax_cluster(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.call spir_funccc @_Z27__spirv_GroupNonUniformSMaxiijj(%1, %2, %arg0, %0) {convergent, no_unwind, will_return} : (i32, i32, i32, i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @non_uniform_bitwise_and(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call spir_funccc @_Z33__spirv_GroupNonUniformBitwiseAndiij(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @non_uniform_bitwise_or(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call spir_funccc @_Z32__spirv_GroupNonUniformBitwiseOriij(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @non_uniform_bitwise_xor(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call spir_funccc @_Z33__spirv_GroupNonUniformBitwiseXoriij(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @non_uniform_logical_and(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call spir_funccc @_Z33__spirv_GroupNonUniformLogicalAndiib(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, i1) -> i1
    llvm.return %2 : i1
  }
  llvm.func @non_uniform_logical_or(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call spir_funccc @_Z32__spirv_GroupNonUniformLogicalOriib(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, i1) -> i1
    llvm.return %2 : i1
  }
  llvm.func @non_uniform_logical_xor(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call spir_funccc @_Z33__spirv_GroupNonUniformLogicalXoriib(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, i1) -> i1
    llvm.return %2 : i1
  }
}

