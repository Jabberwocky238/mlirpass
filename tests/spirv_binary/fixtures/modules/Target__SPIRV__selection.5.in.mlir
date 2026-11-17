"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.5, [Shader], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (si32) -> (), sym_name = "selection_switch_operands"}> ({
  ^bb0(%arg0: si32):
    %0 = "spirv.Constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "spirv.Undef"() : () -> vector<3xf32>
    %2 = "spirv.CompositeInsert"(%0, %1) <{indices = [0 : i32]}> : (f32, vector<3xf32>) -> vector<3xf32>
    "spirv.Branch"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %3 = "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
      "spirv.Switch"(%arg0, %2, %2, %2)[^bb3, ^bb1, ^bb2] <{case_operand_segments = array<i32: 1, 1>, literals = dense<[0, 1]> : vector<2xsi32>, operandSegmentSizes = array<i32: 1, 1, 2>}> : (si32, vector<3xf32>, vector<3xf32>, vector<3xf32>) -> ()
    ^bb1(%6: vector<3xf32>):  // pred: ^bb0
      %7 = "spirv.Constant"() <{value = 3.000000e+00 : f32}> : () -> f32
      %8 = "spirv.CompositeInsert"(%7, %6) <{indices = [1 : i32]}> : (f32, vector<3xf32>) -> vector<3xf32>
      "spirv.Branch"(%8)[^bb3] : (vector<3xf32>) -> ()
    ^bb2(%9: vector<3xf32>):  // pred: ^bb0
      %10 = "spirv.Constant"() <{value = 4.000000e+00 : f32}> : () -> f32
      %11 = "spirv.CompositeInsert"(%10, %9) <{indices = [1 : i32]}> : (f32, vector<3xf32>) -> vector<3xf32>
      "spirv.Branch"(%11)[^bb3] : (vector<3xf32>) -> ()
    ^bb3(%12: vector<3xf32>):  // 3 preds: ^bb0, ^bb1, ^bb2
      "spirv.mlir.merge"(%12) : (vector<3xf32>) -> ()
    }) : () -> vector<3xf32>
    %4 = "spirv.Constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %5 = "spirv.CompositeInsert"(%4, %3) <{indices = [2 : i32]}> : (f32, vector<3xf32>) -> vector<3xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "main"}> ({
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<GLCompute>, fn = @main, interface = []}> : () -> ()
  "spirv.ExecutionMode"() <{execution_mode = #spirv.execution_mode<LocalSize>, fn = @main, values = [1 : i32, 1 : i32, 1 : i32]}> : () -> ()
}) : () -> ()

