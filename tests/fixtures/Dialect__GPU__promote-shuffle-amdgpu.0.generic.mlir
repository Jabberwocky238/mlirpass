"builtin.module"() ({
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg2: !transform.any_op):
      %4 = "transform.structured.match"(%arg2) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%4) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.gpu.gpu_shuffle_to_amdgpu"() <{chipset = "gfx950"}> : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i1), sym_name = "gpu_shuffle_swizzle"}> ({
  ^bb0(%arg1: i32):
    %2 = "arith.constant"() <{value = true}> : () -> i1
    %3 = "amdgpu.swizzle_bitmode"(%arg1) <{and_mask = 31 : i32, or_mask = 0 : i32, xor_mask = 23 : i32}> : (i32) -> i32
    "func.return"(%3, %2) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i1), sym_name = "gpu_shuffle_permlane_swap"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.constant"() <{value = true}> : () -> i1
    %1 = "amdgpu.permlane_swap"(%arg0) <{bound_ctrl = false, fetch_inactive = false, row_length = 32 : i32}> : (i32) -> i32
    "func.return"(%1, %0) : (i32, i1) -> ()
  }) : () -> ()
}) : () -> ()

