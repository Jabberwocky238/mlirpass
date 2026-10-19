#map = affine_map<() -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>) -> (), sym_name = "no_memref_op"}> ({
  ^bb0(%arg0: memref<f32>):
    %0 = "affine.load"(%arg0) <{map = #map}> : (memref<f32>) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

