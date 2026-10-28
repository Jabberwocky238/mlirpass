"spirv.module"() <{addressing_model = #spirv.addressing_model<Physical64>, memory_model = #spirv.memory_model<OpenCL>, vce_triple = #spirv.vce<v1.0, [Kernel, Addresses, Vector16, Linkage], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "float_insts"}> ({
  ^bb0(%arg9: f32):
    %9 = "spirv.CL.exp"(%arg9) : (f32) -> f32
    %10 = "spirv.CL.fabs"(%arg9) : (f32) -> f32
    %11 = "spirv.CL.sin"(%arg9) : (f32) -> f32
    %12 = "spirv.CL.cos"(%arg9) : (f32) -> f32
    %13 = "spirv.CL.log"(%arg9) : (f32) -> f32
    %14 = "spirv.CL.sqrt"(%arg9) : (f32) -> f32
    %15 = "spirv.CL.ceil"(%arg9) : (f32) -> f32
    %16 = "spirv.CL.floor"(%arg9) : (f32) -> f32
    %17 = "spirv.CL.pow"(%arg9, %arg9) : (f32, f32) -> f32
    %18 = "spirv.CL.rsqrt"(%arg9) : (f32) -> f32
    %19 = "spirv.CL.erf"(%arg9) : (f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "integer_insts"}> ({
  ^bb0(%arg8: i32):
    %8 = "spirv.CL.s_abs"(%arg8) : (i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<16xf32>) -> (), sym_name = "vector_size16"}> ({
  ^bb0(%arg7: vector<16xf32>):
    %7 = "spirv.CL.fabs"(%arg7) : (vector<16xf32>) -> vector<16xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32, f32) -> (), sym_name = "fma"}> ({
  ^bb0(%arg4: f32, %arg5: f32, %arg6: f32):
    %6 = "spirv.CL.fma"(%arg4, %arg5, %arg6) : (f32, f32, f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32, i32, i32) -> (), sym_name = "maxmin"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: i32, %arg3: i32):
    %0 = "spirv.CL.fmax"(%arg0, %arg1) : (f32, f32) -> f32
    %1 = "spirv.CL.s_max"(%arg2, %arg3) : (i32, i32) -> i32
    %2 = "spirv.CL.u_max"(%arg2, %arg3) : (i32, i32) -> i32
    %3 = "spirv.CL.fmin"(%arg0, %arg1) : (f32, f32) -> f32
    %4 = "spirv.CL.s_min"(%arg2, %arg3) : (i32, i32) -> i32
    %5 = "spirv.CL.u_min"(%arg2, %arg3) : (i32, i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

