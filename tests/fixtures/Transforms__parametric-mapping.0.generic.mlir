#map = affine_map<()[s0, s1] -> (s0 * s1)>
#map1 = affine_map<()[s0, s1] -> (s0 + s1)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "map1d"}> ({
  ^bb0(%arg4: index, %arg5: index, %arg6: index):
    %8:2 = "new_processor_id_and_range"() : () -> (index, index)
    %9 = "affine.apply"(%8#0, %arg6) <{map = #map}> : (index, index) -> index
    %10 = "affine.apply"(%9, %arg4) <{map = #map1}> : (index, index) -> index
    %11 = "affine.apply"(%8#1, %arg6) <{map = #map}> : (index, index) -> index
    "scf.for"(%10, %arg5, %11) ({
    ^bb0(%arg7: index):
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "map2d"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0:2 = "new_processor_id_and_range"() : () -> (index, index)
    %1:2 = "new_processor_id_and_range"() : () -> (index, index)
    %2 = "affine.apply"(%0#0, %1#1) <{map = #map}> : (index, index) -> index
    %3 = "affine.apply"(%2, %1#0) <{map = #map1}> : (index, index) -> index
    %4 = "affine.apply"(%3, %arg2) <{map = #map}> : (index, index) -> index
    %5 = "affine.apply"(%4, %arg0) <{map = #map1}> : (index, index) -> index
    %6 = "affine.apply"(%0#1, %arg2) <{map = #map}> : (index, index) -> index
    %7 = "affine.apply"(%1#1, %6) <{map = #map}> : (index, index) -> index
    "scf.for"(%5, %arg1, %7) ({
    ^bb0(%arg3: index):
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

