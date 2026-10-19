#map = affine_map<()[s0, s1] -> (s0, s1, 128)>
#map1 = affine_map<()[s0, s1, s2] -> (s0, s1 + s2)>
#map2 = affine_map<()[s0, s1] -> (s1)>
#map3 = affine_map<()[s0, s1] -> (s0 ceildiv s1)>
#map4 = affine_map<()[s0, s1] -> (s0, s1, -128)>
#map5 = affine_map<()[s0, s1] -> (s0 ceildiv 128 + s0 ceildiv s1)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> index, sym_name = "apply_simplification_1"}> ({
    %15 = "test.value_with_bounds"() <{max = 64 : index, min = 32 : index}> : () -> index
    %16 = "test.value_with_bounds"() <{max = 64 : index, min = 32 : index}> : () -> index
    %17 = "affine.min"(%15, %16) <{map = #map}> : (index, index) -> index
    %18 = "arith.constant"() <{value = 2 : index}> : () -> index
    "func.return"(%18) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> index, sym_name = "apply_simplification_2"}> ({
    %10 = "test.value_with_bounds"() <{max = 64 : index, min = 32 : index}> : () -> index
    %11 = "test.value_with_bounds"() <{max = 64 : index, min = 32 : index}> : () -> index
    %12 = "test.value_with_bounds"() <{max = 64 : index, min = 32 : index}> : () -> index
    %13 = "affine.min"(%10, %11, %12) <{map = #map1}> : (index, index, index) -> index
    %14 = "arith.constant"() <{value = 4 : index}> : () -> index
    "func.return"(%14) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> index, sym_name = "no_simplification_0"}> ({
    %6 = "test.value_with_bounds"() <{max = 64 : index, min = 32 : index}> : () -> index
    %7 = "test.value_with_bounds"() <{max = 64 : index, min = 16 : index}> : () -> index
    %8 = "affine.min"(%6, %7) <{map = #map2}> : (index, index) -> index
    %9 = "affine.apply"(%8, %6) <{map = #map3}> : (index, index) -> index
    "func.return"(%9) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> index, sym_name = "no_simplification_1"}> ({
    %2 = "test.value_with_bounds"() <{max = 64 : index, min = 32 : index}> : () -> index
    %3 = "test.value_with_bounds"() <{max = 64 : index, min = 16 : index}> : () -> index
    %4 = "affine.min"(%2, %3) <{map = #map4}> : (index, index) -> index
    %5 = "affine.apply"(%4, %3) <{map = #map5}> : (index, index) -> index
    "func.return"(%5) : (index) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["affine.apply"]}> : (!transform.any_op) -> !transform.any_op
      %1 = "transform.test.make_composed_folded_affine_apply"(%0) : (!transform.any_op) -> !transform.any_op
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

