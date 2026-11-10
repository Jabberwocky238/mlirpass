"spirv.module"() <{addressing_model = #spirv.addressing_model<Physical64>, memory_model = #spirv.memory_model<OpenCL>, vce_triple = #spirv.vce<v1.0, [Kernel, Addresses, Linkage, MaskedGatherScatterINTEL], [SPV_INTEL_masked_gather_scatter]>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4x!spirv.ptr<f32, CrossWorkgroup>>, i32, vector<4xi1>, vector<4xf32>) -> (), sym_name = "masked_gather_f32"}> ({
  ^bb0(%arg12: vector<4x!spirv.ptr<f32, CrossWorkgroup>>, %arg13: i32, %arg14: vector<4xi1>, %arg15: vector<4xf32>):
    %1 = "spirv.INTEL.MaskedGather"(%arg12, %arg13, %arg14, %arg15) : (vector<4x!spirv.ptr<f32, CrossWorkgroup>>, i32, vector<4xi1>, vector<4xf32>) -> vector<4xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4x!spirv.ptr<i32, CrossWorkgroup>>, i32, vector<4xi1>, vector<4xi32>) -> (), sym_name = "masked_gather_i32"}> ({
  ^bb0(%arg8: vector<4x!spirv.ptr<i32, CrossWorkgroup>>, %arg9: i32, %arg10: vector<4xi1>, %arg11: vector<4xi32>):
    %0 = "spirv.INTEL.MaskedGather"(%arg8, %arg9, %arg10, %arg11) : (vector<4x!spirv.ptr<i32, CrossWorkgroup>>, i32, vector<4xi1>, vector<4xi32>) -> vector<4xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4x!spirv.ptr<f32, CrossWorkgroup>>, i32, vector<4xi1>, vector<4xf32>) -> (), sym_name = "masked_scatter_f32"}> ({
  ^bb0(%arg4: vector<4x!spirv.ptr<f32, CrossWorkgroup>>, %arg5: i32, %arg6: vector<4xi1>, %arg7: vector<4xf32>):
    "spirv.INTEL.MaskedScatter"(%arg4, %arg5, %arg6, %arg7) : (vector<4x!spirv.ptr<f32, CrossWorkgroup>>, i32, vector<4xi1>, vector<4xf32>) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4x!spirv.ptr<i32, CrossWorkgroup>>, i32, vector<4xi1>, vector<4xi32>) -> (), sym_name = "masked_scatter_i32"}> ({
  ^bb0(%arg0: vector<4x!spirv.ptr<i32, CrossWorkgroup>>, %arg1: i32, %arg2: vector<4xi1>, %arg3: vector<4xi32>):
    "spirv.INTEL.MaskedScatter"(%arg0, %arg1, %arg2, %arg3) : (vector<4x!spirv.ptr<i32, CrossWorkgroup>>, i32, vector<4xi1>, vector<4xi32>) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

