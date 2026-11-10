"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Linkage], []>}> ({
  "spirv.func"() <{arg_attrs = [{spirv.decoration = #spirv.decoration<RelaxedPrecision>}], function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<f32, Function>) -> (), sym_name = "relaxed_precision_arg"}> ({
  ^bb0(%arg0: !spirv.ptr<f32, Function>):
    "spirv.Return"() : () -> ()
  }) {relaxed_precision} : () -> ()
}) : () -> ()

