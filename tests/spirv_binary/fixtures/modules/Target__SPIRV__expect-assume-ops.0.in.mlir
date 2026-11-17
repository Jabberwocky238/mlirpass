"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Linkage, ExpectAssumeKHR], [SPV_KHR_expect_assume]>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1) -> (), sym_name = "assume_true"}> ({
  ^bb0(%arg8: i1):
    "spirv.KHR.AssumeTrue"(%arg8) : (i1) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> i32, sym_name = "expect_scalar_int"}> ({
  ^bb0(%arg6: i32, %arg7: i32):
    %3 = "spirv.KHR.Expect"(%arg6, %arg7) : (i32, i32) -> i32
    "spirv.ReturnValue"(%3) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1, i1) -> i1, sym_name = "expect_scalar_bool"}> ({
  ^bb0(%arg4: i1, %arg5: i1):
    %2 = "spirv.KHR.Expect"(%arg4, %arg5) : (i1, i1) -> i1
    "spirv.ReturnValue"(%2) : (i1) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi32>, vector<4xi32>) -> vector<4xi32>, sym_name = "expect_vector_int"}> ({
  ^bb0(%arg2: vector<4xi32>, %arg3: vector<4xi32>):
    %1 = "spirv.KHR.Expect"(%arg2, %arg3) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "spirv.ReturnValue"(%1) : (vector<4xi32>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi1>, vector<4xi1>) -> vector<4xi1>, sym_name = "expect_vector_bool"}> ({
  ^bb0(%arg0: vector<4xi1>, %arg1: vector<4xi1>):
    %0 = "spirv.KHR.Expect"(%arg0, %arg1) : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    "spirv.ReturnValue"(%0) : (vector<4xi1>) -> ()
  }) : () -> ()
}) : () -> ()

