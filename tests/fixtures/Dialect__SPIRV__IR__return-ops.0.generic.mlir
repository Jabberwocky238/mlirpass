"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xi32>, vector<2xi32>) -> vector<2xi32>, sym_name = "preserve_return_value"}> ({
  ^bb0(%arg0: vector<2xi32>, %arg1: vector<2xi32>):
    %0 = "spirv.Bitcast"(%arg1) : (vector<2xi32>) -> vector<2xf32>
    %1 = "spirv.Bitcast"(%0) : (vector<2xf32>) -> vector<2xi32>
    "spirv.ReturnValue"(%1) : (vector<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

