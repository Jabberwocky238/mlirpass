"builtin.module"() ({
  "memref.global"() <{initial_value = dense<66560> : tensor<1xi32>, sym_name = "global_i32", sym_visibility = "private", type = memref<1xi32>}> : () -> ()
  "memref.global"() <{initial_value = dense<37017> : tensor<1xi64>, sym_name = "global_i64", sym_visibility = "private", type = memref<1xi64>}> : () -> ()
  "memref.global"() <{initial_value = dense<1.250000e-01> : tensor<1xf32>, sym_name = "global_f32", sym_visibility = "private", type = memref<1xf32>}> : () -> ()
  "memref.global"() <{initial_value = dense<3.140000e+00> : tensor<1xf64>, sym_name = "global_f64", sym_visibility = "private", type = memref<1xf64>}> : () -> ()
  "memref.global"() <{initial_value, sym_name = "global_user0", sym_visibility = "private", type = memref<1xi32>}> : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "global_user0::initializer"}> ({
    %0 = "memref.get_global"() <{name = @"module::extern_global_var"}> : () -> memref<1xi32>
    %1 = "memref.get_global"() <{name = @global_user0}> : () -> memref<1xi32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.load"(%0, %2) <{invariant = false, nontemporal = false}> : (memref<1xi32>, index) -> i32
    "memref.store"(%3, %1, %2) <{nontemporal = false}> : (i32, memref<1xi32>, index) -> ()
    "func.return"() : () -> ()
  }) {initializer} : () -> ()
  "memref.global"() <{constant, sym_name = "module::extern_global_var", sym_visibility = "nested", type = memref<1xi32>}> : () -> ()
}) : () -> ()

