"spirv.module"() <{addressing_model = #spirv.addressing_model<Physical64>, memory_model = #spirv.memory_model<OpenCL>, vce_triple = #spirv.vce<v1.0, [Kernel, Addresses, Linkage, GenericPointer, Int64], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "covert_u_to_ptr"}> ({
  ^bb0(%arg2: i32):
    %2 = "spirv.ConvertUToPtr"(%arg2) : (i32) -> !spirv.ptr<i32, Generic>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i64) -> (), sym_name = "covert_u_to_ptr_truncate"}> ({
  ^bb0(%arg1: i64):
    %1 = "spirv.ConvertUToPtr"(%arg1) : (i64) -> !spirv.ptr<i32, Generic>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "covert_u_to_ptr_extend"}> ({
  ^bb0(%arg0: i32):
    %0 = "spirv.ConvertUToPtr"(%arg0) : (i32) -> !spirv.ptr<i64, Generic>
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

