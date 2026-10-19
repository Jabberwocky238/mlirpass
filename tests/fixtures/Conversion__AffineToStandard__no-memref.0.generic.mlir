"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>) -> (), sym_name = "no_memref_op"}> ({
  ^bb0(%arg0: memref<f32>):
    %0 = "memref.load"(%arg0) <{nontemporal = false}> : (memref<f32>) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

