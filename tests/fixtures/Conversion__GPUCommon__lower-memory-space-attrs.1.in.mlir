"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "gpu.func"() <{function_type = (f32) -> ()}> ({
    ^bb0(%arg0: f32, %arg1: memref<4xf32, #gpu.address_space<private>>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      "memref.store"(%arg0, %arg1, %0) : (f32, memref<4xf32, #gpu.address_space<private>>, index) -> ()
      "gpu.return"() : () -> ()
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
      "gpu.return"() : () -> ()
    }) {sym_name = "workgroup", workgroup_attributions = 1 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "gpu.func"() <{function_type = (memref<4xmemref<4xf32, #gpu.address_space<global>>, #gpu.address_space<global>>) -> f32}> ({
    ^bb0(%arg0: memref<4xmemref<4xf32, #gpu.address_space<global>>, #gpu.address_space<global>>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "memref.load"(%arg0, %0) : (memref<4xmemref<4xf32, #gpu.address_space<global>>, #gpu.address_space<global>>, index) -> memref<4xf32, #gpu.address_space<global>>
      %2 = "memref.load"(%1, %0) : (memref<4xf32, #gpu.address_space<global>>, index) -> f32
      "gpu.return"(%2) : (f32) -> ()
    }) {sym_name = "nested_memref", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "gpu.func"() <{function_type = (memref<1xf32>) -> ()}> ({
    ^bb0(%arg0: memref<1xf32>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "gpu.dynamic_shared_memory"() : () -> memref<?xi8, #gpu.address_space<workgroup>>
      %2 = "memref.view"(%1, %0) : (memref<?xi8, #gpu.address_space<workgroup>>, index) -> memref<1xf32, #gpu.address_space<workgroup>>
      %3 = "vector.load"(%2, %0) : (memref<1xf32, #gpu.address_space<workgroup>>, index) -> vector<1xf32>
      "vector.store"(%3, %arg0, %0) : (vector<1xf32>, memref<1xf32>, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "dynamic_shmem_with_vector", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "gpu.func"() <{function_type = (f32) -> ()}> ({
    ^bb0(%arg0: f32):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "gpu.dynamic_shared_memory"() : () -> memref<?xi8, #gpu.address_space<workgroup>>
      %2 = "memref.view"(%1, %0) : (memref<?xi8, #gpu.address_space<workgroup>>, index) -> memref<4xf32, #gpu.address_space<workgroup>>
      "memref.store"(%arg0, %2, %0) : (f32, memref<4xf32, #gpu.address_space<workgroup>>, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "dynamic_shmem", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

