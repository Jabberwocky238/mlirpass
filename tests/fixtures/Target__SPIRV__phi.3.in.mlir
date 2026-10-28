"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "foo"}> ({
    "spirv.Branch"()[^bb2] : () -> ()
  ^bb1(%0: i32, %1: f32):  // pred: ^bb2
    "spirv.Return"() : () -> ()
  ^bb2:  // pred: ^bb0
    %2 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %3 = "spirv.Constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    "spirv.Branch"(%2, %3)[^bb1] : (i32, f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "main"}> ({
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<GLCompute>, fn = @main, interface = []}> : () -> ()
}) : () -> ()

