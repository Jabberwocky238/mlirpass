module {
  llvm.func spir_funccc @_Z17__spirv_GroupSMaxiij(i32, i32, i32) -> i32 attributes {convergent, no_unwind, will_return}
  llvm.func spir_funccc @_Z17__spirv_GroupUMaxiij(i32, i32, i32) -> i32 attributes {convergent, no_unwind, will_return}
  llvm.func spir_funccc @_Z17__spirv_GroupFMaxiif(i32, i32, f32) -> f32 attributes {convergent, no_unwind, will_return}
  llvm.func spir_funccc @_Z17__spirv_GroupSMiniij(i32, i32, i32) -> i32 attributes {convergent, no_unwind, will_return}
  llvm.func spir_funccc @_Z17__spirv_GroupUMiniij(i32, i32, i32) -> i32 attributes {convergent, no_unwind, will_return}
  llvm.func spir_funccc @_Z17__spirv_GroupFMiniif(i32, i32, f32) -> f32 attributes {convergent, no_unwind, will_return}
  llvm.func spir_funccc @_Z17__spirv_GroupFAddiif(i32, i32, f32) -> f32 attributes {convergent, no_unwind, will_return}
  llvm.func spir_funccc @_Z17__spirv_GroupIAddiij(i32, i32, i32) -> i32 attributes {convergent, no_unwind, will_return}
  llvm.func @group_reduce_iadd(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call spir_funccc @_Z17__spirv_GroupIAddiij(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @group_reduce_fadd(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call spir_funccc @_Z17__spirv_GroupFAddiif(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @group_reduce_fmin(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call spir_funccc @_Z17__spirv_GroupFMiniif(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @group_reduce_umin(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call spir_funccc @_Z17__spirv_GroupUMiniij(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @group_reduce_smin(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call spir_funccc @_Z17__spirv_GroupSMiniij(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @group_reduce_fmax(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call spir_funccc @_Z17__spirv_GroupFMaxiif(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @group_reduce_umax(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call spir_funccc @_Z17__spirv_GroupUMaxiij(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @group_reduce_smax(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call spir_funccc @_Z17__spirv_GroupSMaxiij(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @group_inclusive_scan_iadd(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.call spir_funccc @_Z17__spirv_GroupIAddiij(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @group_inclusive_scan_fadd(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.call spir_funccc @_Z17__spirv_GroupFAddiif(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @group_inclusive_scan_fmin(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.call spir_funccc @_Z17__spirv_GroupFMiniif(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @group_inclusive_scan_umin(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.call spir_funccc @_Z17__spirv_GroupUMiniij(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @group_inclusive_scan_smin(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.call spir_funccc @_Z17__spirv_GroupSMiniij(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @group_inclusive_scan_fmax(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.call spir_funccc @_Z17__spirv_GroupFMaxiif(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @group_inclusive_scan_umax(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.call spir_funccc @_Z17__spirv_GroupUMaxiij(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @group_inclusive_scan_smax(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.call spir_funccc @_Z17__spirv_GroupSMaxiij(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @group_exclusive_scan_iadd(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.call spir_funccc @_Z17__spirv_GroupIAddiij(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @group_exclusive_scan_fadd(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.call spir_funccc @_Z17__spirv_GroupFAddiif(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @group_exclusive_scan_fmin(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.call spir_funccc @_Z17__spirv_GroupFMiniif(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @group_exclusive_scan_umin(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.call spir_funccc @_Z17__spirv_GroupUMiniij(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @group_exclusive_scan_smin(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.call spir_funccc @_Z17__spirv_GroupSMiniij(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @group_exclusive_scan_fmax(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.call spir_funccc @_Z17__spirv_GroupFMaxiif(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @group_exclusive_scan_umax(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.call spir_funccc @_Z17__spirv_GroupUMaxiij(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @group_exclusive_scan_smax(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.call spir_funccc @_Z17__spirv_GroupSMaxiij(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @subgroup_exclusive_scan_smax(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.call spir_funccc @_Z17__spirv_GroupSMaxiij(%0, %1, %arg0) {convergent, no_unwind, will_return} : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }
}

