"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<OpenCL>, vce_triple = #spirv.vce<v1.0, [Kernel, Linkage], [SPV_KHR_no_integer_wrap_decoration]>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "iadd_decorations"}> ({
  ^bb0(%arg0: i32):
    %0 = "spirv.IAdd"(%arg0, %arg0) {no_signed_wrap, no_unsigned_wrap} : (i32, i32) -> i32
    "spirv.ReturnValue"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

