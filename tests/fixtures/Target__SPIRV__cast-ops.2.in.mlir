"spirv.module"() <{addressing_model = #spirv.addressing_model<Physical64>, memory_model = #spirv.memory_model<OpenCL>, vce_triple = #spirv.vce<v1.0, [Kernel, Linkage, GenericPointer], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<f32, CrossWorkgroup>) -> (), sym_name = "ptr_cast_to_generic"}> ({
  ^bb0(%arg2: !spirv.ptr<f32, CrossWorkgroup>):
    %2 = "spirv.PtrCastToGeneric"(%arg2) : (!spirv.ptr<f32, CrossWorkgroup>) -> !spirv.ptr<f32, Generic>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<vector<2xi32>, Generic>) -> (), sym_name = "generic_cast_to_ptr"}> ({
  ^bb0(%arg1: !spirv.ptr<vector<2xi32>, Generic>):
    %1 = "spirv.GenericCastToPtr"(%arg1) : (!spirv.ptr<vector<2xi32>, Generic>) -> !spirv.ptr<vector<2xi32>, CrossWorkgroup>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<vector<2xi32>, Generic>) -> (), sym_name = "generic_cast_to_ptr_explicit"}> ({
  ^bb0(%arg0: !spirv.ptr<vector<2xi32>, Generic>):
    %0 = "spirv.GenericCastToPtrExplicit"(%arg0) : (!spirv.ptr<vector<2xi32>, Generic>) -> !spirv.ptr<vector<2xi32>, CrossWorkgroup>
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

