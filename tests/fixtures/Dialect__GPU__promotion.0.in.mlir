"builtin.module"() ({
  "gpu.module"() <{sym_name = "foo"}> ({
    "gpu.func"() <{arg_attrs = [{gpu.test_promote_workgroup}], function_type = (memref<5x4xf32>) -> (), kernel}> ({
    ^bb0(%arg0: memref<5x4xf32>):
      "use"(%arg0) : (memref<5x4xf32>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "memref3d"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "foo"}> ({
    "gpu.func"() <{arg_attrs = [{gpu.test_promote_workgroup}], function_type = (memref<8x7x6x5x4xf32>) -> (), kernel}> ({
    ^bb0(%arg0: memref<8x7x6x5x4xf32>):
      "use"(%arg0) : (memref<8x7x6x5x4xf32>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "memref5d"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "foo"}> ({
    "gpu.func"() <{arg_attrs = [{gpu.test_promote_workgroup}], function_type = (memref<4xf32>) -> (), kernel, workgroup_attributions = 1 : i64}> ({
    ^bb0(%arg0: memref<4xf32>, %arg1: memref<1x1xf64, #gpu.address_space<workgroup>>, %arg2: memref<1x1xi64, 5>):
      "use"(%arg0) : (memref<4xf32>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "insert"} : () -> ()
  }) : () -> ()
}) : () -> ()

