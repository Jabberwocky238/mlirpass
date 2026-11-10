"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module_0"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_index_ops", visibility_ = 0 : i64}> ({
      %4 = "nvvm.read.ptx.sreg.tid.x"() : () -> i32
      %5 = "nvvm.read.ptx.sreg.tid.y"() : () -> i32
      %6 = "nvvm.read.ptx.sreg.tid.z"() : () -> i32
      %7 = "nvvm.read.ptx.sreg.ntid.x"() : () -> i32
      %8 = "nvvm.read.ptx.sreg.ntid.y"() : () -> i32
      %9 = "nvvm.read.ptx.sreg.ntid.z"() : () -> i32
      %10 = "nvvm.read.ptx.sreg.ctaid.x"() : () -> i32
      %11 = "nvvm.read.ptx.sreg.ctaid.y"() : () -> i32
      %12 = "nvvm.read.ptx.sreg.ctaid.z"() : () -> i32
      %13 = "nvvm.read.ptx.sreg.nctaid.x"() : () -> i32
      %14 = "nvvm.read.ptx.sreg.nctaid.y"() : () -> i32
      %15 = "nvvm.read.ptx.sreg.nctaid.z"() : () -> i32
      %16 = "nvvm.read.ptx.sreg.laneid"() <{range = #llvm.constant_range<i32, 0, 32>}> : () -> i32
      %17 = "llvm.mlir.poison"() : () -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %18 = "llvm.insertvalue"(%17, %4) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %19 = "llvm.insertvalue"(%18, %5) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %20 = "llvm.insertvalue"(%19, %6) <{position = array<i64: 2>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %21 = "llvm.insertvalue"(%20, %7) <{position = array<i64: 3>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %22 = "llvm.insertvalue"(%21, %8) <{position = array<i64: 4>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %23 = "llvm.insertvalue"(%22, %9) <{position = array<i64: 5>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %24 = "llvm.insertvalue"(%23, %10) <{position = array<i64: 6>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %25 = "llvm.insertvalue"(%24, %11) <{position = array<i64: 7>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %26 = "llvm.insertvalue"(%25, %12) <{position = array<i64: 8>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %27 = "llvm.insertvalue"(%26, %13) <{position = array<i64: 9>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %28 = "llvm.insertvalue"(%27, %14) <{position = array<i64: 10>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %29 = "llvm.insertvalue"(%28, %15) <{position = array<i64: 11>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %30 = "llvm.insertvalue"(%29, %16) <{position = array<i64: 12>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      "llvm.return"(%30) : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_index_ops", visibility_ = 0 : i64}> ({
    ^bb0(%arg3: !llvm.ptr):
      %3 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_index_ops, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      "llvm.store"(%3, %arg3) <{ordering = 0 : i64}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module_1"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "gpu_index_comp", visibility_ = 0 : i64}> ({
    ^bb0(%arg2: i32):
      %2 = "llvm.add"(%arg2, %arg2) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      "llvm.return"(%2) : (i32) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_index_comp", visibility_ = 0 : i64}> ({
    ^bb0(%arg1: i32):
      %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_index_comp, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i32) -> i32
      "llvm.return"(%1) : (i32) -> ()
    }) {llvm.emit_c_interface} : () -> ()
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

