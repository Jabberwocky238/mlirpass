#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (index, memref<?xf32>) -> f32}> ({
    ^bb0(%arg0: index, %arg1: memref<?xf32>):
      %0 = "affine.apply"(%arg0) <{map = #map}> : (index) -> index
      %1 = "memref.load"(%arg1, %0) : (memref<?xf32>, index) -> f32
      "gpu.return"(%1) : (f32) -> ()
    }) {sym_name = "foo", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

