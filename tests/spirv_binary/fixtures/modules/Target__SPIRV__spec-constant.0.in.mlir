"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Linkage], []>}> ({
  "spirv.SpecConstant"() <{default_value = true, sym_name = "sc_true"}> : () -> ()
  "spirv.SpecConstant"() <{default_value = false, sym_name = "sc_false"}> {spec_id = 1 : i64} : () -> ()
  "spirv.SpecConstant"() <{default_value = -5 : i32, sym_name = "sc_int"}> : () -> ()
  "spirv.SpecConstant"() <{default_value = 1.000000e+00 : f32, sym_name = "sc_float"}> {spec_id = 5 : i64} : () -> ()
  "spirv.SpecConstantComposite"() <{constituents = [@sc_int, @sc_int], sym_name = "scc", type = !spirv.array<2 x i32>}> : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> i32, sym_name = "use"}> ({
    %4 = "spirv.mlir.referenceof"() <{spec_const = @sc_int}> : () -> i32
    %5 = "spirv.IAdd"(%4, %4) : (i32, i32) -> i32
    "spirv.ReturnValue"(%5) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> i32, sym_name = "use_composite"}> ({
    %0 = "spirv.mlir.referenceof"() <{spec_const = @scc}> : () -> !spirv.array<2 x i32>
    %1 = "spirv.CompositeExtract"(%0) <{indices = [0 : i32]}> : (!spirv.array<2 x i32>) -> i32
    %2 = "spirv.CompositeExtract"(%0) <{indices = [1 : i32]}> : (!spirv.array<2 x i32>) -> i32
    %3 = "spirv.IAdd"(%1, %2) : (i32, i32) -> i32
    "spirv.ReturnValue"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

