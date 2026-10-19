"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "operand_result"}> ({
    %0 = "dialect.memref_producer"() : () -> memref<f32, #spirv.storage_class<CrossWorkgroup>>
    %1 = "dialect.memref_producer"() : () -> memref<4xi32, #spirv.storage_class<Generic>>
    %2 = "dialect.memref_producer"() : () -> memref<?x4xf16, #spirv.storage_class<Workgroup>>
    %3 = "dialect.memref_producer"() : () -> memref<*xf16, #spirv.storage_class<UniformConstant>>
    %4 = "dialect.memref_producer"() : () -> memref<*xf16, #spirv.storage_class<Private>>
    %5 = "dialect.memref_producer"() : () -> memref<*xf16, #spirv.storage_class<Function>>
    %6 = "dialect.memref_producer"() : () -> memref<*xf16, #spirv.storage_class<Image>>
    "dialect.memref_consumer"(%0) : (memref<f32, #spirv.storage_class<CrossWorkgroup>>) -> ()
    "dialect.memref_consumer"(%1) : (memref<4xi32, #spirv.storage_class<Generic>>) -> ()
    "dialect.memref_consumer"(%2) : (memref<?x4xf16, #spirv.storage_class<Workgroup>>) -> ()
    "dialect.memref_consumer"(%3) : (memref<*xf16, #spirv.storage_class<UniformConstant>>) -> ()
    "dialect.memref_consumer"(%4) : (memref<*xf16, #spirv.storage_class<Private>>) -> ()
    "dialect.memref_consumer"(%5) : (memref<*xf16, #spirv.storage_class<Function>>) -> ()
    "dialect.memref_consumer"(%6) : (memref<*xf16, #spirv.storage_class<Image>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "type_attribute"}> ({
    "dialect.memref_producer"() {attr = memref<i32, #spirv.storage_class<Generic>>} : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f64, #spirv.storage_class<Generic>>, memref<4xi32, #spirv.storage_class<Workgroup>>) -> (memref<f64, #spirv.storage_class<Generic>>, memref<4xi32, #spirv.storage_class<Workgroup>>), sym_name = "function_io"}> ({
  ^bb0(%arg0: memref<f64, #spirv.storage_class<Generic>>, %arg1: memref<4xi32, #spirv.storage_class<Workgroup>>):
    "func.return"(%arg0, %arg1) : (memref<f64, #spirv.storage_class<Generic>>, memref<4xi32, #spirv.storage_class<Workgroup>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "gpu.func"() <{function_type = (memref<8xi32, #spirv.storage_class<CrossWorkgroup>>) -> ()}> ({
    ^bb0(%arg0: memref<8xi32, #spirv.storage_class<CrossWorkgroup>>):
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "function_io", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, memref<f32, #spirv.storage_class<Generic>>) -> (), sym_name = "region"}> ({
  ^bb0(%arg0: i1, %arg1: memref<f32, #spirv.storage_class<Generic>>):
    "scf.if"(%arg0) ({
      %0 = "dialect.memref_consumer"(%arg1) {attr = memref<i64, #spirv.storage_class<Workgroup>>} : (memref<f32, #spirv.storage_class<Generic>>) -> memref<f32, #spirv.storage_class<Generic>>
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> f32, sym_name = "non_memref_types"}> ({
  ^bb0(%arg0: f32):
    %0 = "dialect.op"(%arg0) {attr = 16 : i64} : (f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "operand_result"}> ({
    %0 = "dialect.memref_producer"() : () -> memref<f32, #spirv.storage_class<CrossWorkgroup>>
    %1 = "dialect.memref_producer"() : () -> memref<4xi32, #spirv.storage_class<Generic>>
    %2 = "dialect.memref_producer"() : () -> memref<?x4xf16, #spirv.storage_class<Workgroup>>
    %3 = "dialect.memref_producer"() : () -> memref<*xf16, #spirv.storage_class<UniformConstant>>
    "dialect.memref_consumer"(%0) : (memref<f32, #spirv.storage_class<CrossWorkgroup>>) -> ()
    "dialect.memref_consumer"(%1) : (memref<4xi32, #spirv.storage_class<Generic>>) -> ()
    "dialect.memref_consumer"(%2) : (memref<?x4xf16, #spirv.storage_class<Workgroup>>) -> ()
    "dialect.memref_consumer"(%3) : (memref<*xf16, #spirv.storage_class<UniformConstant>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "operand_result"}> ({
    %0 = "dialect.memref_producer"() : () -> memref<f32, #spirv.storage_class<StorageBuffer>>
    %1 = "dialect.memref_producer"() : () -> memref<4xi32, #spirv.storage_class<Generic>>
    %2 = "dialect.memref_producer"() : () -> memref<?x4xf16, #spirv.storage_class<Workgroup>>
    %3 = "dialect.memref_producer"() : () -> memref<*xf16, #spirv.storage_class<Uniform>>
    "dialect.memref_consumer"(%0) : (memref<f32, #spirv.storage_class<StorageBuffer>>) -> ()
    "dialect.memref_consumer"(%1) : (memref<4xi32, #spirv.storage_class<Generic>>) -> ()
    "dialect.memref_consumer"(%2) : (memref<?x4xf16, #spirv.storage_class<Workgroup>>) -> ()
    "dialect.memref_consumer"(%3) : (memref<*xf16, #spirv.storage_class<Uniform>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], []>, #spirv.resource_limits<>>} : () -> ()

