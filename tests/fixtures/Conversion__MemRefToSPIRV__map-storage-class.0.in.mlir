"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "operand_result"}> ({
    %0 = "dialect.memref_producer"() : () -> memref<f32>
    %1 = "dialect.memref_producer"() : () -> memref<4xi32, 1>
    %2 = "dialect.memref_producer"() : () -> memref<?x4xf16, 3>
    %3 = "dialect.memref_producer"() : () -> memref<*xf16, 4>
    %4 = "dialect.memref_producer"() : () -> memref<*xf16, 5>
    %5 = "dialect.memref_producer"() : () -> memref<*xf16, 6>
    %6 = "dialect.memref_producer"() : () -> memref<*xf16, 7>
    "dialect.memref_consumer"(%0) : (memref<f32>) -> ()
    "dialect.memref_consumer"(%1) : (memref<4xi32, 1>) -> ()
    "dialect.memref_consumer"(%2) : (memref<?x4xf16, 3>) -> ()
    "dialect.memref_consumer"(%3) : (memref<*xf16, 4>) -> ()
    "dialect.memref_consumer"(%4) : (memref<*xf16, 5>) -> ()
    "dialect.memref_consumer"(%5) : (memref<*xf16, 6>) -> ()
    "dialect.memref_consumer"(%6) : (memref<*xf16, 7>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "type_attribute"}> ({
    "dialect.memref_producer"() {attr = memref<i32, 1>} : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f64, 1>, memref<4xi32, 3>) -> (memref<f64, 1>, memref<4xi32, 3>), sym_name = "function_io"}> ({
  ^bb0(%arg0: memref<f64, 1>, %arg1: memref<4xi32, 3>):
    "func.return"(%arg0, %arg1) : (memref<f64, 1>, memref<4xi32, 3>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "gpu.func"() <{function_type = (memref<8xi32>) -> ()}> ({
    ^bb0(%arg0: memref<8xi32>):
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "function_io", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, memref<f32, 1>) -> (), sym_name = "region"}> ({
  ^bb0(%arg0: i1, %arg1: memref<f32, 1>):
    "scf.if"(%arg0) ({
      %0 = "dialect.memref_consumer"(%arg1) {attr = memref<i64, 3>} : (memref<f32, 1>) -> memref<f32, 1>
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
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "missing_mapping"}> ({
    %0 = "dialect.memref_producer"() : () -> memref<f32, 2>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "operand_result"}> ({
    %0 = "dialect.memref_producer"() : () -> memref<f32>
    %1 = "dialect.memref_producer"() : () -> memref<4xi32, 1>
    %2 = "dialect.memref_producer"() : () -> memref<?x4xf16, 3>
    %3 = "dialect.memref_producer"() : () -> memref<*xf16, 4>
    "dialect.memref_consumer"(%0) : (memref<f32>) -> ()
    "dialect.memref_consumer"(%1) : (memref<4xi32, 1>) -> ()
    "dialect.memref_consumer"(%2) : (memref<?x4xf16, 3>) -> ()
    "dialect.memref_consumer"(%3) : (memref<*xf16, 4>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "operand_result"}> ({
    %0 = "dialect.memref_producer"() : () -> memref<f32>
    %1 = "dialect.memref_producer"() : () -> memref<4xi32, 1>
    %2 = "dialect.memref_producer"() : () -> memref<?x4xf16, 3>
    %3 = "dialect.memref_producer"() : () -> memref<*xf16, 4>
    "dialect.memref_consumer"(%0) : (memref<f32>) -> ()
    "dialect.memref_consumer"(%1) : (memref<4xi32, 1>) -> ()
    "dialect.memref_consumer"(%2) : (memref<?x4xf16, 3>) -> ()
    "dialect.memref_consumer"(%3) : (memref<*xf16, 4>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], []>, #spirv.resource_limits<>>} : () -> ()

