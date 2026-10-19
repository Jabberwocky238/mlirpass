"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "gpu.func"() <{arg_attrs = [{llvm.readonly}], function_type = (memref<f32>) -> ()}> ({
    ^bb0(%arg0: memref<f32>):
      "gpu.return"() : () -> ()
    }) {sym_name = "test_func_readonly", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "gpu.func"() <{arg_attrs = [{llvm.writeonly}], function_type = (memref<f32>) -> ()}> ({
    ^bb0(%arg0: memref<f32>):
      "gpu.return"() : () -> ()
    }) {sym_name = "test_func_writeonly", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "gpu.func"() <{arg_attrs = [{llvm.readonly}], function_type = (!llvm.ptr) -> ()}> ({
    ^bb0(%arg0: !llvm.ptr):
      "gpu.return"() : () -> ()
    }) {sym_name = "test_func_readonly_ptr", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "gpu.func"() <{arg_attrs = [{llvm.nonnull}], function_type = (memref<f32>) -> ()}> ({
    ^bb0(%arg0: memref<f32>):
      "gpu.return"() : () -> ()
    }) {sym_name = "test_func_nonnull", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "gpu.func"() <{arg_attrs = [{llvm.dereferenceable = 4 : i64}], function_type = (memref<f32>) -> ()}> ({
    ^bb0(%arg0: memref<f32>):
      "gpu.return"() : () -> ()
    }) {sym_name = "test_func_dereferenceable", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "gpu.func"() <{arg_attrs = [{llvm.dereferenceable_or_null = 4 : i64}], function_type = (memref<f32>) -> ()}> ({
    ^bb0(%arg0: memref<f32>):
      "gpu.return"() : () -> ()
    }) {sym_name = "test_func_dereferenceable_or_null", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "gpu.func"() <{arg_attrs = [{llvm.noundef}], function_type = (memref<f32>) -> ()}> ({
    ^bb0(%arg0: memref<f32>):
      "gpu.return"() : () -> ()
    }) {sym_name = "test_func_noundef", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

