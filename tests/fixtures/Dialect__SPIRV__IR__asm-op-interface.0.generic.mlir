"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "const"}> ({
    %0 = "spirv.Constant"() <{value = true}> : () -> i1
    %1 = "spirv.Constant"() <{value = false}> : () -> i1
    %2 = "spirv.Constant"() <{value = 42 : i32}> : () -> i32
    %3 = "spirv.Constant"() <{value = -42 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = 43 : i64}> : () -> i64
    %5 = "spirv.Constant"() <{value = 6 : ui8}> : () -> ui8
    %6 = "spirv.Constant"() <{value = 5.000000e-01 : f32}> : () -> f32
    %7 = "spirv.Constant"() <{value = 5.000000e-01 : f64}> : () -> f64
    %8 = "spirv.Constant"() <{value = dense<[1, 2, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    %9 = "spirv.Constant"() <{value = [dense<3.000000e+00> : vector<2xf32>]}> : () -> !spirv.array<1 x vector<2xf32>>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.GlobalVariable"() <{sym_name = "global_var", type = !spirv.ptr<f32, Input>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "addressof"}> ({
      %0 = "spirv.mlir.addressof"() <{variable = @global_var}> : () -> !spirv.ptr<f32, Input>
      "spirv.Return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

