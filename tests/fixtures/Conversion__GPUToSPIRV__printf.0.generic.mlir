"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch_func"(%3, %3, %3, %3, %3, %3) <{kernel = @kernels::@printf, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.SpecConstant"() <{default_value = 10 : i8, sym_name = "printfMsg0_sc0"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 72 : i8, sym_name = "printfMsg0_sc1"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 101 : i8, sym_name = "printfMsg0_sc2"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 108 : i8, sym_name = "printfMsg0_sc3"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 108 : i8, sym_name = "printfMsg0_sc4"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 111 : i8, sym_name = "printfMsg0_sc5"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 10 : i8, sym_name = "printfMsg0_sc6"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 0 : i8, sym_name = "printfMsg0_sc7"}> : () -> ()
      "spirv.SpecConstantComposite"() <{constituents = [@printfMsg0_sc0, @printfMsg0_sc1, @printfMsg0_sc2, @printfMsg0_sc3, @printfMsg0_sc4, @printfMsg0_sc5, @printfMsg0_sc6, @printfMsg0_sc7], sym_name = "printfMsg0_scc", type = !spirv.array<8 x i8>}> : () -> ()
      "spirv.GlobalVariable"() <{initializer = @printfMsg0_scc, sym_name = "printfMsg0", type = !spirv.ptr<!spirv.array<8 x i8>, UniformConstant>}> {Constant} : () -> ()
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "printf"}> ({
        %0 = "spirv.mlir.addressof"() <{variable = @printfMsg0}> : () -> !spirv.ptr<!spirv.array<8 x i8>, UniformConstant>
        %1 = "spirv.Bitcast"(%0) : (!spirv.ptr<!spirv.array<8 x i8>, UniformConstant>) -> !spirv.ptr<i8, UniformConstant>
        %2 = "spirv.CL.printf"(%1) : (!spirv.ptr<i8, UniformConstant>) -> i32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "printf"}> ({
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Addresses, Int8, Kernel], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
    %12 = "arith.constant"() <{value = 1 : index}> : () -> index
    %13 = "arith.constant"() <{value = 100 : i32}> : () -> i32
    %14 = "arith.constant"() <{value = 3.144000e+02 : f32}> : () -> f32
    "gpu.launch_func"(%12, %12, %12, %12, %12, %12, %13, %14) <{kernel = @kernels1::@printf_args, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 2, 0>}> : (index, index, index, index, index, index, i32, f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels1"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels1"}> ({
      "spirv.SpecConstant"() <{default_value = 10 : i8, sym_name = "printfMsg0_sc0"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 72 : i8, sym_name = "printfMsg0_sc1"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 101 : i8, sym_name = "printfMsg0_sc2"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 108 : i8, sym_name = "printfMsg0_sc3"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 108 : i8, sym_name = "printfMsg0_sc4"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 111 : i8, sym_name = "printfMsg0_sc5"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 44 : i8, sym_name = "printfMsg0_sc6"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 32 : i8, sym_name = "printfMsg0_sc7"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 119 : i8, sym_name = "printfMsg0_sc8"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 111 : i8, sym_name = "printfMsg0_sc9"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 114 : i8, sym_name = "printfMsg0_sc10"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 108 : i8, sym_name = "printfMsg0_sc11"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 100 : i8, sym_name = "printfMsg0_sc12"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 32 : i8, sym_name = "printfMsg0_sc13"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 58 : i8, sym_name = "printfMsg0_sc14"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 32 : i8, sym_name = "printfMsg0_sc15"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 37 : i8, sym_name = "printfMsg0_sc16"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 100 : i8, sym_name = "printfMsg0_sc17"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 32 : i8, sym_name = "printfMsg0_sc18"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 37 : i8, sym_name = "printfMsg0_sc19"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 102 : i8, sym_name = "printfMsg0_sc20"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 32 : i8, sym_name = "printfMsg0_sc21"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 10 : i8, sym_name = "printfMsg0_sc22"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 32 : i8, sym_name = "printfMsg0_sc23"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 84 : i8, sym_name = "printfMsg0_sc24"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 104 : i8, sym_name = "printfMsg0_sc25"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 114 : i8, sym_name = "printfMsg0_sc26"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 101 : i8, sym_name = "printfMsg0_sc27"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 97 : i8, sym_name = "printfMsg0_sc28"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 100 : i8, sym_name = "printfMsg0_sc29"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 32 : i8, sym_name = "printfMsg0_sc30"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 105 : i8, sym_name = "printfMsg0_sc31"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 100 : i8, sym_name = "printfMsg0_sc32"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 58 : i8, sym_name = "printfMsg0_sc33"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 32 : i8, sym_name = "printfMsg0_sc34"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 37 : i8, sym_name = "printfMsg0_sc35"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 100 : i8, sym_name = "printfMsg0_sc36"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 10 : i8, sym_name = "printfMsg0_sc37"}> : () -> ()
      "spirv.SpecConstant"() <{default_value = 0 : i8, sym_name = "printfMsg0_sc38"}> : () -> ()
      "spirv.SpecConstantComposite"() <{constituents = [@printfMsg0_sc0, @printfMsg0_sc1, @printfMsg0_sc2, @printfMsg0_sc3, @printfMsg0_sc4, @printfMsg0_sc5, @printfMsg0_sc6, @printfMsg0_sc7, @printfMsg0_sc8, @printfMsg0_sc9, @printfMsg0_sc10, @printfMsg0_sc11, @printfMsg0_sc12, @printfMsg0_sc13, @printfMsg0_sc14, @printfMsg0_sc15, @printfMsg0_sc16, @printfMsg0_sc17, @printfMsg0_sc18, @printfMsg0_sc19, @printfMsg0_sc20, @printfMsg0_sc21, @printfMsg0_sc22, @printfMsg0_sc23, @printfMsg0_sc24, @printfMsg0_sc25, @printfMsg0_sc26, @printfMsg0_sc27, @printfMsg0_sc28, @printfMsg0_sc29, @printfMsg0_sc30, @printfMsg0_sc31, @printfMsg0_sc32, @printfMsg0_sc33, @printfMsg0_sc34, @printfMsg0_sc35, @printfMsg0_sc36, @printfMsg0_sc37, @printfMsg0_sc38], sym_name = "printfMsg0_scc", type = !spirv.array<39 x i8>}> : () -> ()
      "spirv.GlobalVariable"() <{initializer = @printfMsg0_scc, sym_name = "printfMsg0", type = !spirv.ptr<!spirv.array<39 x i8>, UniformConstant>}> {Constant} : () -> ()
      "spirv.GlobalVariable"() <{built_in = "LocalInvocationId", sym_name = "__builtin__LocalInvocationId__", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
      "spirv.GlobalVariable"() <{built_in = "WorkgroupId", sym_name = "__builtin__WorkgroupId__", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, f32) -> (), sym_name = "printf_args"}> ({
      ^bb0(%arg2: i32, %arg3: f32):
        %0 = "spirv.mlir.addressof"() <{variable = @__builtin__WorkgroupId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
        %1 = "spirv.Load"(%0) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
        %2 = "spirv.CompositeExtract"(%1) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
        %3 = "spirv.mlir.addressof"() <{variable = @__builtin__WorkgroupId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
        %4 = "spirv.Load"(%3) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
        %5 = "spirv.CompositeExtract"(%4) <{indices = [1 : i32]}> : (vector<3xi32>) -> i32
        %6 = "spirv.mlir.addressof"() <{variable = @__builtin__LocalInvocationId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
        %7 = "spirv.Load"(%6) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
        %8 = "spirv.CompositeExtract"(%7) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
        %9 = "spirv.mlir.addressof"() <{variable = @printfMsg0}> : () -> !spirv.ptr<!spirv.array<39 x i8>, UniformConstant>
        %10 = "spirv.Bitcast"(%9) : (!spirv.ptr<!spirv.array<39 x i8>, UniformConstant>) -> !spirv.ptr<i8, UniformConstant>
        %11 = "spirv.CL.printf"(%10, %arg2, %arg3, %8) : (!spirv.ptr<i8, UniformConstant>, i32, f32, i32) -> i32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (i32, f32) -> (), sym_name = "printf_args"}> ({
    ^bb0(%arg0: i32, %arg1: f32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Addresses, Int8, Kernel], []>, #spirv.resource_limits<>>} : () -> ()

