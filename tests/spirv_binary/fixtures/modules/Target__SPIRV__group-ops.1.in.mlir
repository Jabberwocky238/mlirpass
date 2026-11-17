"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.3, [Shader, GroupNonUniformBallot, Linkage], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi32>) -> i32, sym_name = "group_non_uniform_ballot_bit_count"}> ({
  ^bb0(%arg0: vector<4xi32>):
    %0 = "spirv.GroupNonUniformBallotBitCount"(%arg0) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (vector<4xi32>) -> i32
    "spirv.ReturnValue"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

