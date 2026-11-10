"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module_0"}> ({
    "func.func"() <{function_type = () -> (index, index, index, index, index, index, index, index, index, index, index, index, index), sym_name = "gpu_index_ops"}> ({
      %2 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %3 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %4 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %5 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %6 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %7 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %8 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %9 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %10 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %11 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %12 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %13 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %14 = "gpu.lane_id"() : () -> index
      "func.return"(%2, %3, %4, %5, %6, %7, %8, %9, %10, %11, %12, %13, %14) : (index, index, index, index, index, index, index, index, index, index, index, index, index) -> ()
    }) : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_1"}> ({
    "func.func"() <{function_type = (index) -> index, sym_name = "gpu_index_comp"}> ({
    ^bb0(%arg1: index):
      %1 = "arith.addi"(%arg1, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "func.return"(%1) : (index) -> ()
    }) : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["gpu.module"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_conversion_patterns"(%0) <{illegal_dialects = ["gpu"], illegal_ops = ["llvm.cos", "llvm.exp", "llvm.exp2", "llvm.fabs", "llvm.fceil", "llvm.ffloor", "llvm.log", "llvm.log10", "llvm.log2", "llvm.pow", "llvm.sin", "llvm.sqrt"], legal_dialects = ["llvm", "memref", "nvvm"], legal_ops = ["gpu.module", "gpu.yield"], partial_conversion}> ({
        "transform.apply_conversion_patterns.dialect_to_llvm"() <{dialect_name = "arith"}> : () -> ()
        "transform.apply_conversion_patterns.dialect_to_llvm"() <{dialect_name = "cf"}> : () -> ()
        "transform.apply_conversion_patterns.vector.vector_to_llvm"() <{force_32bit_vector_indices = true, reassociate_fp_reductions = false, use_vector_alignment = false}> : () -> ()
        "transform.apply_conversion_patterns.func.func_to_llvm"() : () -> ()
        "transform.apply_conversion_patterns.dialect_to_llvm"() <{dialect_name = "memref"}> : () -> ()
        "transform.apply_conversion_patterns.gpu.gpu_to_nvvm"() <{benefit = 10 : i16}> : () -> ()
        "transform.apply_conversion_patterns.gpu.gpu_wmma_to_nvvm"() : () -> ()
        "transform.apply_conversion_patterns.gpu.gpu_subgroup_reduce_to_nvvm"() {has_redux = true} : () -> ()
        "transform.apply_conversion_patterns.nvgpu.nvgpu_to_nvvm"() : () -> ()
      }, {
        "transform.apply_conversion_patterns.memref.memref_to_llvm_type_converter"() <{index_bitwidth = 32 : i64}> {use_opaque_pointers = true} : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

