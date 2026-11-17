"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Linkage], []>}> ({
  "spirv.SpecConstant"() <{default_value = 1 : i32, sym_name = "sc_i32_1"}> : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> i32, sym_name = "use_composite"}> ({
    %0 = "spirv.mlir.referenceof"() <{spec_const = @sc_i32_1}> : () -> i32
    %1 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %2 = "spirv.SpecConstantOperation"() ({
      %9 = "spirv.ISub"(%0, %1) : (i32, i32) -> i32
      "spirv.mlir.yield"(%9) : (i32) -> ()
    }) : () -> i32
    %3 = "spirv.mlir.referenceof"() <{spec_const = @sc_i32_1}> : () -> i32
    %4 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %5 = "spirv.SpecConstantOperation"() ({
      %8 = "spirv.ISub"(%3, %4) : (i32, i32) -> i32
      "spirv.mlir.yield"(%8) : (i32) -> ()
    }) : () -> i32
    %6 = "spirv.SpecConstantOperation"() ({
      %7 = "spirv.IMul"(%2, %5) : (i32, i32) -> i32
      "spirv.mlir.yield"(%7) : (i32) -> ()
    }) : () -> i32
    "spirv.ReturnValue"(%6) : (i32) -> ()
  }) : () -> ()
}) : () -> ()