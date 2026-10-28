"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader], []>}> ({
  "spirv.GlobalVariable"() <{built_in = "NumWorkgroups", sym_name = "__builtin_var_NumWorkgroups__", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
  "spirv.GlobalVariable"() <{built_in = "WorkgroupId", sym_name = "__builtin_var_WorkgroupId__", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "fmul_kernel"}> ({
    %0 = "spirv.Constant"() <{value = 12 : i32}> : () -> i32
    %1 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
    %2 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %3 = "spirv.mlir.addressof"() <{variable = @__builtin_var_WorkgroupId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
    %4 = "spirv.Load"(%3) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
    %5 = "spirv.CompositeExtract"(%4) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
    %6 = "spirv.mlir.addressof"() <{variable = @__builtin_var_WorkgroupId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
    %7 = "spirv.Load"(%6) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
    %8 = "spirv.CompositeExtract"(%7) <{indices = [1 : i32]}> : (vector<3xi32>) -> i32
    %9 = "spirv.mlir.addressof"() <{variable = @__builtin_var_NumWorkgroups__}> : () -> !spirv.ptr<vector<3xi32>, Input>
    %10 = "spirv.Load"(%9) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
    %11 = "spirv.CompositeExtract"(%10) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
    %12 = "spirv.mlir.addressof"() <{variable = @__builtin_var_NumWorkgroups__}> : () -> !spirv.ptr<vector<3xi32>, Input>
    %13 = "spirv.Load"(%12) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
    %14 = "spirv.CompositeExtract"(%13) <{indices = [1 : i32]}> : (vector<3xi32>) -> i32
    %15 = "spirv.IMul"(%8, %1) : (i32, i32) -> i32
    %16 = "spirv.IMul"(%14, %1) : (i32, i32) -> i32
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      "spirv.Branch"(%15)[^bb1] : (i32) -> ()
    ^bb1(%17: i32):  // 2 preds: ^bb0, ^bb2
      %18 = "spirv.SLessThan"(%17, %0) : (i32, i32) -> i1
      "spirv.BranchConditional"(%18)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      %19 = "spirv.IMul"(%5, %2) : (i32, i32) -> i32
      %20 = "spirv.IMul"(%11, %2) : (i32, i32) -> i32
      "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
        "spirv.Branch"(%19)[^bb1] : (i32) -> ()
      ^bb1(%22: i32):  // 2 preds: ^bb0, ^bb2
        %23 = "spirv.SLessThan"(%22, %2) : (i32, i32) -> i1
        "spirv.BranchConditional"(%23)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
      ^bb2:  // pred: ^bb1
        %24 = "spirv.IAdd"(%22, %20) : (i32, i32) -> i32
        "spirv.Branch"(%24)[^bb1] : (i32) -> ()
      ^bb3:  // pred: ^bb1
        "spirv.mlir.merge"() : () -> ()
      }) : () -> ()
      %21 = "spirv.IAdd"(%17, %16) : (i32, i32) -> i32
      "spirv.Branch"(%21)[^bb1] : (i32) -> ()
    ^bb3:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<GLCompute>, fn = @fmul_kernel, interface = [@__builtin_var_WorkgroupId__, @__builtin_var_NumWorkgroups__]}> : () -> ()
  "spirv.ExecutionMode"() <{execution_mode = #spirv.execution_mode<LocalSize>, fn = @fmul_kernel, values = [32 : i32, 1 : i32, 1 : i32]}> : () -> ()
}) : () -> ()

