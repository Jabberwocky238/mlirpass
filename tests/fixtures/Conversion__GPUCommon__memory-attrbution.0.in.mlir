"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "gpu.func"() <{function_type = (f32) -> ()}> ({
    ^bb0(%arg0: f32, %arg1: memref<4xf32, #gpu.address_space<private>>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      "memref.store"(%arg0, %arg1, %0) : (f32, memref<4xf32, #gpu.address_space<private>>, index) -> ()
      "terminator"() : () -> ()
    }) {sym_name = "private", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "gpu.func"() <{function_type = (f32) -> ()}> ({
    ^bb0(%arg0: f32, %arg1: memref<4xf32, #gpu.address_space<workgroup>>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      "memref.store"(%arg0, %arg1, %0) : (f32, memref<4xf32, #gpu.address_space<workgroup>>, index) -> ()
      "terminator"() : () -> ()
    }) {sym_name = "workgroup", workgroup_attributions = 1 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "gpu.func"() <{function_type = (f32) -> ()}> ({
    ^bb0(%arg0: f32, %arg1: memref<4x2x6xf32, #gpu.address_space<workgroup>>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      "memref.store"(%arg0, %arg1, %0, %0, %0) : (f32, memref<4x2x6xf32, #gpu.address_space<workgroup>>, index, index, index) -> ()
      "terminator"() : () -> ()
    }) {sym_name = "workgroup3d", workgroup_attributions = 1 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "gpu.func"() <{function_type = (f32) -> ()}> ({
    ^bb0(%arg0: f32, %arg1: memref<1xf32, #gpu.address_space<workgroup>>, %arg2: memref<2xf32, #gpu.address_space<workgroup>>, %arg3: memref<3xf32, #gpu.address_space<private>>, %arg4: memref<4xf32, #gpu.address_space<private>>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      "memref.store"(%arg0, %arg1, %0) : (f32, memref<1xf32, #gpu.address_space<workgroup>>, index) -> ()
      "memref.store"(%arg0, %arg2, %0) : (f32, memref<2xf32, #gpu.address_space<workgroup>>, index) -> ()
      "memref.store"(%arg0, %arg3, %0) : (f32, memref<3xf32, #gpu.address_space<private>>, index) -> ()
      "memref.store"(%arg0, %arg4, %0) : (f32, memref<4xf32, #gpu.address_space<private>>, index) -> ()
      "terminator"() : () -> ()
    }) {sym_name = "multiple", workgroup_attributions = 2 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "gpu.func"() <{function_type = (index) -> (), private_attrib_attrs = [{llvm.align = 4 : i64}], workgroup_attrib_attrs = [{llvm.align = 8 : i64}]}> ({
    ^bb0(%arg0: index, %arg1: memref<48xf32, #gpu.address_space<workgroup>>, %arg2: memref<48xf32, #gpu.address_space<private>>):
      %0 = "memref.load"(%arg1, %arg0) : (memref<48xf32, #gpu.address_space<workgroup>>, index) -> f32
      "memref.store"(%0, %arg2, %arg0) : (f32, memref<48xf32, #gpu.address_space<private>>, index) -> ()
      "terminator"() : () -> ()
    }) {sym_name = "explicitAlign", workgroup_attributions = 1 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

