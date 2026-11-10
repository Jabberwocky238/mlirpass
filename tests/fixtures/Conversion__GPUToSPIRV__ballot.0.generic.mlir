"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.GlobalVariable"() <{built_in = "SubgroupLocalInvocationId", sym_name = "__builtin__SubgroupLocalInvocationId__", type = !spirv.ptr<i32, Input>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "ballot_i32"}> ({
      %4 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %5 = "spirv.mlir.addressof"() <{variable = @__builtin__SubgroupLocalInvocationId__}> : () -> !spirv.ptr<i32, Input>
      %6 = "spirv.Load"(%5) : (!spirv.ptr<i32, Input>) -> i32
      %7 = "spirv.ULessThan"(%6, %4) : (i32, i32) -> i1
      %8 = "spirv.GroupNonUniformBallot"(%7) <{execution_scope = #spirv.scope<Subgroup>}> : (i1) -> vector<4xi32>
      %9 = "spirv.CompositeExtract"(%8) <{indices = [0 : i32]}> : (vector<4xi32>) -> i32
      "spirv.Return"() : () -> ()
    }) {kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 1, 1]>} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> (), kernel}> ({
      %0 = "arith.constant"() <{value = 1 : index}> : () -> index
      %1 = "gpu.lane_id"() : () -> index
      %2 = "arith.cmpi"(%1, %0) <{predicate = 6 : i64}> : (index, index) -> i1
      %3 = "gpu.ballot"(%2) : (i1) -> i32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 1, 1]>, sym_name = "ballot_i32"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, GroupNonUniformBallot], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.GlobalVariable"() <{built_in = "SubgroupLocalInvocationId", sym_name = "__builtin__SubgroupLocalInvocationId__", type = !spirv.ptr<i32, Input>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "ballot_i64"}> ({
      %4 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %5 = "spirv.mlir.addressof"() <{variable = @__builtin__SubgroupLocalInvocationId__}> : () -> !spirv.ptr<i32, Input>
      %6 = "spirv.Load"(%5) : (!spirv.ptr<i32, Input>) -> i32
      %7 = "spirv.ULessThan"(%6, %4) : (i32, i32) -> i1
      %8 = "spirv.GroupNonUniformBallot"(%7) <{execution_scope = #spirv.scope<Subgroup>}> : (i1) -> vector<4xi32>
      %9 = "spirv.CompositeExtract"(%8) <{indices = [0 : i32]}> : (vector<4xi32>) -> i32
      %10 = "spirv.CompositeExtract"(%8) <{indices = [1 : i32]}> : (vector<4xi32>) -> i32
      %11 = "spirv.UConvert"(%9) : (i32) -> i64
      %12 = "spirv.UConvert"(%10) : (i32) -> i64
      %13 = "spirv.Constant"() <{value = 32 : i64}> : () -> i64
      %14 = "spirv.ShiftLeftLogical"(%12, %13) : (i64, i64) -> i64
      %15 = "spirv.BitwiseOr"(%11, %14) : (i64, i64) -> i64
      "spirv.Return"() : () -> ()
    }) {kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 1, 1]>} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> (), kernel}> ({
      %0 = "arith.constant"() <{value = 1 : index}> : () -> index
      %1 = "gpu.lane_id"() : () -> index
      %2 = "arith.cmpi"(%1, %0) <{predicate = 6 : i64}> : (index, index) -> i1
      %3 = "gpu.ballot"(%2) : (i1) -> i64
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 1, 1]>, sym_name = "ballot_i64"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, GroupNonUniformBallot, Int64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
// -----
// -----
