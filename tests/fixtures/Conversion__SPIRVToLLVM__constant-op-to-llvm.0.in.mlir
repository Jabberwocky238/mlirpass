"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "bool_constant_scalar"}> ({
    %11 = "spirv.Constant"() <{value = true}> : () -> i1
    %12 = "spirv.Constant"() <{value = false}> : () -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "bool_constant_vector"}> ({
    %9 = "spirv.Constant"() <{value = dense<[true, false]> : vector<2xi1>}> : () -> vector<2xi1>
    %10 = "spirv.Constant"() <{value = dense<false> : vector<3xi1>}> : () -> vector<3xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "integer_constant_scalar"}> ({
    %6 = "spirv.Constant"() <{value = 0 : i8}> : () -> i8
    %7 = "spirv.Constant"() <{value = -5 : si64}> : () -> si64
    %8 = "spirv.Constant"() <{value = 10 : ui16}> : () -> ui16
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "integer_constant_vector"}> ({
    %3 = "spirv.Constant"() <{value = dense<[2, 3]> : vector<2xi32>}> : () -> vector<2xi32>
    %4 = "spirv.Constant"() <{value = dense<-4> : vector<2xsi32>}> : () -> vector<2xsi32>
    %5 = "spirv.Constant"() <{value = dense<[2, 3, 4]> : vector<3xui32>}> : () -> vector<3xui32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "float_constant_scalar"}> ({
    %1 = "spirv.Constant"() <{value = 5.000000e+00 : f16}> : () -> f16
    %2 = "spirv.Constant"() <{value = 5.000000e+00 : f64}> : () -> f64
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "float_constant_vector"}> ({
    %0 = "spirv.Constant"() <{value = dense<[2.000000e+00, 3.000000e+00]> : vector<2xf32>}> : () -> vector<2xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

