module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Addresses, Int8, Kernel], []>, #spirv.resource_limits<>>} {
  func.func @main() {
    %c1 = arith.constant 1 : index
    gpu.launch_func  @kernels::@printf blocks in (%c1, %c1, %c1) threads in (%c1, %c1, %c1)  
    return
  }
  gpu.module @kernels {
    spirv.module @__spv__kernels Physical32 OpenCL {
      spirv.SpecConstant @printfMsg0_sc0 = 10 : i8
      spirv.SpecConstant @printfMsg0_sc1 = 72 : i8
      spirv.SpecConstant @printfMsg0_sc2 = 101 : i8
      spirv.SpecConstant @printfMsg0_sc3 = 108 : i8
      spirv.SpecConstant @printfMsg0_sc4 = 108 : i8
      spirv.SpecConstant @printfMsg0_sc5 = 111 : i8
      spirv.SpecConstant @printfMsg0_sc6 = 10 : i8
      spirv.SpecConstant @printfMsg0_sc7 = 0 : i8
      spirv.SpecConstantComposite @printfMsg0_scc (@printfMsg0_sc0, @printfMsg0_sc1, @printfMsg0_sc2, @printfMsg0_sc3, @printfMsg0_sc4, @printfMsg0_sc5, @printfMsg0_sc6, @printfMsg0_sc7) : !spirv.array<8 x i8>
      spirv.GlobalVariable @printfMsg0 initializer(@printfMsg0_scc) {Constant} : !spirv.ptr<!spirv.array<8 x i8>, UniformConstant>
      spirv.func @printf() "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<>, workgroup_attributions = 0 : i64} {
        %printfMsg0_addr = spirv.mlir.addressof @printfMsg0 : !spirv.ptr<!spirv.array<8 x i8>, UniformConstant>
        %0 = spirv.Bitcast %printfMsg0_addr : !spirv.ptr<!spirv.array<8 x i8>, UniformConstant> to !spirv.ptr<i8, UniformConstant>
        %1 = spirv.CL.printf %0 : !spirv.ptr<i8, UniformConstant> -> i32
        spirv.Return
      }
    }
    func.func @printf() attributes {gpu.kernel} {
      return
    }
  }
}

// -----
module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Addresses, Int8, Kernel], []>, #spirv.resource_limits<>>} {
  func.func @main() {
    %c1 = arith.constant 1 : index
    %c100_i32 = arith.constant 100 : i32
    %cst = arith.constant 3.144000e+02 : f32
    gpu.launch_func  @kernels1::@printf_args blocks in (%c1, %c1, %c1) threads in (%c1, %c1, %c1)  args(%c100_i32 : i32, %cst : f32)
    return
  }
  gpu.module @kernels1 {
    spirv.module @__spv__kernels1 Physical32 OpenCL {
      spirv.SpecConstant @printfMsg0_sc0 = 10 : i8
      spirv.SpecConstant @printfMsg0_sc1 = 72 : i8
      spirv.SpecConstant @printfMsg0_sc2 = 101 : i8
      spirv.SpecConstant @printfMsg0_sc3 = 108 : i8
      spirv.SpecConstant @printfMsg0_sc4 = 108 : i8
      spirv.SpecConstant @printfMsg0_sc5 = 111 : i8
      spirv.SpecConstant @printfMsg0_sc6 = 44 : i8
      spirv.SpecConstant @printfMsg0_sc7 = 32 : i8
      spirv.SpecConstant @printfMsg0_sc8 = 119 : i8
      spirv.SpecConstant @printfMsg0_sc9 = 111 : i8
      spirv.SpecConstant @printfMsg0_sc10 = 114 : i8
      spirv.SpecConstant @printfMsg0_sc11 = 108 : i8
      spirv.SpecConstant @printfMsg0_sc12 = 100 : i8
      spirv.SpecConstant @printfMsg0_sc13 = 32 : i8
      spirv.SpecConstant @printfMsg0_sc14 = 58 : i8
      spirv.SpecConstant @printfMsg0_sc15 = 32 : i8
      spirv.SpecConstant @printfMsg0_sc16 = 37 : i8
      spirv.SpecConstant @printfMsg0_sc17 = 100 : i8
      spirv.SpecConstant @printfMsg0_sc18 = 32 : i8
      spirv.SpecConstant @printfMsg0_sc19 = 37 : i8
      spirv.SpecConstant @printfMsg0_sc20 = 102 : i8
      spirv.SpecConstant @printfMsg0_sc21 = 32 : i8
      spirv.SpecConstant @printfMsg0_sc22 = 10 : i8
      spirv.SpecConstant @printfMsg0_sc23 = 32 : i8
      spirv.SpecConstant @printfMsg0_sc24 = 84 : i8
      spirv.SpecConstant @printfMsg0_sc25 = 104 : i8
      spirv.SpecConstant @printfMsg0_sc26 = 114 : i8
      spirv.SpecConstant @printfMsg0_sc27 = 101 : i8
      spirv.SpecConstant @printfMsg0_sc28 = 97 : i8
      spirv.SpecConstant @printfMsg0_sc29 = 100 : i8
      spirv.SpecConstant @printfMsg0_sc30 = 32 : i8
      spirv.SpecConstant @printfMsg0_sc31 = 105 : i8
      spirv.SpecConstant @printfMsg0_sc32 = 100 : i8
      spirv.SpecConstant @printfMsg0_sc33 = 58 : i8
      spirv.SpecConstant @printfMsg0_sc34 = 32 : i8
      spirv.SpecConstant @printfMsg0_sc35 = 37 : i8
      spirv.SpecConstant @printfMsg0_sc36 = 100 : i8
      spirv.SpecConstant @printfMsg0_sc37 = 10 : i8
      spirv.SpecConstant @printfMsg0_sc38 = 0 : i8
      spirv.SpecConstantComposite @printfMsg0_scc (@printfMsg0_sc0, @printfMsg0_sc1, @printfMsg0_sc2, @printfMsg0_sc3, @printfMsg0_sc4, @printfMsg0_sc5, @printfMsg0_sc6, @printfMsg0_sc7, @printfMsg0_sc8, @printfMsg0_sc9, @printfMsg0_sc10, @printfMsg0_sc11, @printfMsg0_sc12, @printfMsg0_sc13, @printfMsg0_sc14, @printfMsg0_sc15, @printfMsg0_sc16, @printfMsg0_sc17, @printfMsg0_sc18, @printfMsg0_sc19, @printfMsg0_sc20, @printfMsg0_sc21, @printfMsg0_sc22, @printfMsg0_sc23, @printfMsg0_sc24, @printfMsg0_sc25, @printfMsg0_sc26, @printfMsg0_sc27, @printfMsg0_sc28, @printfMsg0_sc29, @printfMsg0_sc30, @printfMsg0_sc31, @printfMsg0_sc32, @printfMsg0_sc33, @printfMsg0_sc34, @printfMsg0_sc35, @printfMsg0_sc36, @printfMsg0_sc37, @printfMsg0_sc38) : !spirv.array<39 x i8>
      spirv.GlobalVariable @printfMsg0 initializer(@printfMsg0_scc) {Constant} : !spirv.ptr<!spirv.array<39 x i8>, UniformConstant>
      spirv.GlobalVariable @__builtin__LocalInvocationId__ built_in("LocalInvocationId") : !spirv.ptr<vector<3xi32>, Input>
      spirv.GlobalVariable @__builtin__WorkgroupId__ built_in("WorkgroupId") : !spirv.ptr<vector<3xi32>, Input>
      spirv.func @printf_args(%arg0: i32, %arg1: f32) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<>, workgroup_attributions = 0 : i64} {
        %__builtin__WorkgroupId___addr = spirv.mlir.addressof @__builtin__WorkgroupId__ : !spirv.ptr<vector<3xi32>, Input>
        %0 = spirv.Load "Input" %__builtin__WorkgroupId___addr : vector<3xi32>
        %1 = spirv.CompositeExtract %0[0 : i32] : vector<3xi32>
        %__builtin__WorkgroupId___addr_0 = spirv.mlir.addressof @__builtin__WorkgroupId__ : !spirv.ptr<vector<3xi32>, Input>
        %2 = spirv.Load "Input" %__builtin__WorkgroupId___addr_0 : vector<3xi32>
        %3 = spirv.CompositeExtract %2[1 : i32] : vector<3xi32>
        %__builtin__LocalInvocationId___addr = spirv.mlir.addressof @__builtin__LocalInvocationId__ : !spirv.ptr<vector<3xi32>, Input>
        %4 = spirv.Load "Input" %__builtin__LocalInvocationId___addr : vector<3xi32>
        %5 = spirv.CompositeExtract %4[0 : i32] : vector<3xi32>
        %printfMsg0_addr = spirv.mlir.addressof @printfMsg0 : !spirv.ptr<!spirv.array<39 x i8>, UniformConstant>
        %6 = spirv.Bitcast %printfMsg0_addr : !spirv.ptr<!spirv.array<39 x i8>, UniformConstant> to !spirv.ptr<i8, UniformConstant>
        %7 = spirv.CL.printf %6 %arg0, %arg1, %5 : !spirv.ptr<i8, UniformConstant>, i32, f32, i32 -> i32
        spirv.Return
      }
    }
    func.func @printf_args(%arg0: i32, %arg1: f32) attributes {gpu.kernel} {
      return
    }
  }
}

