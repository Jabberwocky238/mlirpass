module {
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.gpu.gpu_shuffle_to_amdgpu chipset = "gfx950"
      } : !transform.any_op
      transform.yield 
    }
  }
  func.func @gpu_shuffle_swizzle(%arg0: i32) -> (i32, i1) {
    %true = arith.constant true
    %0 = amdgpu.swizzle_bitmode %arg0 31 0 23 : i32
    return %0, %true : i32, i1
  }
  func.func @gpu_shuffle_permlane_swap(%arg0: i32) -> (i32, i1) {
    %true = arith.constant true
    %0 = amdgpu.permlane_swap %arg0 32 : i32
    return %0, %true : i32, i1
  }
}

