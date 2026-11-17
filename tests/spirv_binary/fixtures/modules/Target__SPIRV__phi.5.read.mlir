"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader], []>}> ({
  "spirv.GlobalVariable"() <{built_in = "NumWorkgroups", sym_name = "__builtin_var_NumWorkgroups__", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
  "spirv.GlobalVariable"() <{built_in = "WorkgroupId", sym_name = "__builtin_var_WorkgroupId__", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "fmul_kernel"}> ({
    %0 = "spirv.mlir.addressof"() <{variable = @__builtin_var_WorkgroupId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
    %1 = "spirv.Load"(%0) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
    %2 = "spirv.CompositeExtract"(%1) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
    %3 = "spirv.mlir.addressof"() <{variable = @__builtin_var_WorkgroupId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
    %4 = "spirv.Load"(%3) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
    %5 = "spirv.CompositeExtract"(%4) <{indices = [1 : i32]}> : (vector<3xi32>) -> i32
    %6 = "spirv.mlir.addressof"() <{variable = @__builtin_var_NumWorkgroups__}> : () -> !spirv.ptr<vector<3xi32>, Input>
    %7 = "spirv.Load"(%6) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
    %8 = "spirv.CompositeExtract"(%7) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
    %9 = "spirv.mlir.addressof"() <{variable = @__builtin_var_NumWorkgroups__}> : () -> !spirv.ptr<vector<3xi32>, Input>
    %10 = "spirv.Load"(%9) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
    %11 = "spirv.CompositeExtract"(%10) <{indices = [1 : i32]}> : (vector<3xi32>) -> i32
    %12 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
    %13 = "spirv.IMul"(%5, %12) : (i32, i32) -> i32
    %14 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
    %15 = "spirv.IMul"(%11, %14) : (i32, i32) -> i32
    "spirv.Branch"(%13)[^bb1] : (i32) -> ()
  ^bb1(%16: i32):  // pred: ^bb0
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      "spirv.Branch"(%16)[^bb1] : (i32) -> ()
    ^bb1(%17: i32):  // 2 preds: ^bb0, ^bb3
      %18 = "spirv.Constant"() <{value = 12 : i32}> : () -> i32
      %19 = "spirv.SLessThan"(%17, %18) : (i32, i32) -> i1
      "spirv.BranchConditional"(%19)[^bb2, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      %20 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
      %21 = "spirv.IMul"(%2, %20) : (i32, i32) -> i32
      %22 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
      %23 = "spirv.IMul"(%8, %22) : (i32, i32) -> i32
      "spirv.Branch"(%21)[^bb3] : (i32) -> ()
    ^bb3(%24: i32):  // pred: ^bb2
      "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
        "spirv.Branch"(%24)[^bb1] : (i32) -> ()
      ^bb1(%26: i32):  // 2 preds: ^bb0, ^bb2
        %27 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
        %28 = "spirv.SLessThan"(%26, %27) : (i32, i32) -> i1
        "spirv.BranchConditional"(%28)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
      ^bb2:  // pred: ^bb1
        %29 = "spirv.IAdd"(%26, %23) : (i32, i32) -> i32
        "spirv.Branch"(%29)[^bb1] : (i32) -> ()
      ^bb3:  // pred: ^bb1
        "spirv.mlir.merge"() : () -> ()
      }) : () -> ()
      %25 = "spirv.IAdd"(%17, %15) : (i32, i32) -> i32
      "spirv.Branch"(%25)[^bb1] : (i32) -> ()
    ^bb4:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<GLCompute>, fn = @fmul_kernel, interface = [@__builtin_var_WorkgroupId__, @__builtin_var_NumWorkgroups__]}> : () -> ()
  "spirv.ExecutionMode"() <{execution_mode = #spirv.execution_mode<LocalSize>, fn = @fmul_kernel, values = [32 : i32, 1 : i32, 1 : i32]}> : () -> ()
}) : () -> ()