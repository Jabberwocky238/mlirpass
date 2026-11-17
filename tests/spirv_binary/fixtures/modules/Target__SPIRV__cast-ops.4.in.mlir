"spirv.module"() <{addressing_model = #spirv.addressing_model<Physical64>, memory_model = #spirv.memory_model<OpenCL>, vce_triple = #spirv.vce<v1.0, [Kernel, Addresses, Linkage, GenericPointer, Int64], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<i32, Generic>) -> (), sym_name = "covert_ptr_to_u"}> ({
  ^bb0(%arg2: !spirv.ptr<i32, Generic>):
    %2 = "spirv.ConvertPtrToU"(%arg2) : (!spirv.ptr<i32, Generic>) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<i64, Generic>) -> (), sym_name = "covert_ptr_to_u_truncate"}> ({
  ^bb0(%arg1: !spirv.ptr<i64, Generic>):
    %1 = "spirv.ConvertPtrToU"(%arg1) : (!spirv.ptr<i64, Generic>) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<i32, Generic>) -> (), sym_name = "covert_ptr_to_u_extend"}> ({
  ^bb0(%arg0: !spirv.ptr<i32, Generic>):
    %0 = "spirv.ConvertPtrToU"(%arg0) : (!spirv.ptr<i32, Generic>) -> i64
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

