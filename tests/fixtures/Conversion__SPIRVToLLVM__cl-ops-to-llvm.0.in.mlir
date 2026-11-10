"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf32>) -> (), sym_name = "cl_unary_float"}> ({
  ^bb0(%arg13: f32, %arg14: vector<3xf32>):
    %13 = "spirv.CL.ceil"(%arg13) : (f32) -> f32
    %14 = "spirv.CL.cos"(%arg13) : (f32) -> f32
    %15 = "spirv.CL.exp"(%arg13) : (f32) -> f32
    %16 = "spirv.CL.exp2"(%arg13) : (f32) -> f32
    %17 = "spirv.CL.exp10"(%arg13) : (f32) -> f32
    %18 = "spirv.CL.fabs"(%arg13) : (f32) -> f32
    %19 = "spirv.CL.floor"(%arg13) : (f32) -> f32
    %20 = "spirv.CL.log"(%arg13) : (f32) -> f32
    %21 = "spirv.CL.log2"(%arg13) : (f32) -> f32
    %22 = "spirv.CL.log10"(%arg13) : (f32) -> f32
    %23 = "spirv.CL.rint"(%arg13) : (f32) -> f32
    %24 = "spirv.CL.round"(%arg13) : (f32) -> f32
    %25 = "spirv.CL.sin"(%arg13) : (f32) -> f32
    %26 = "spirv.CL.sinh"(%arg13) : (f32) -> f32
    %27 = "spirv.CL.cosh"(%arg13) : (f32) -> f32
    %28 = "spirv.CL.tan"(%arg13) : (f32) -> f32
    %29 = "spirv.CL.tanh"(%arg13) : (f32) -> f32
    %30 = "spirv.CL.asin"(%arg13) : (f32) -> f32
    %31 = "spirv.CL.acos"(%arg13) : (f32) -> f32
    %32 = "spirv.CL.atan"(%arg13) : (f32) -> f32
    %33 = "spirv.CL.sqrt"(%arg13) : (f32) -> f32
    %34 = "spirv.CL.trunc"(%arg13) : (f32) -> f32
    %35 = "spirv.CL.sin"(%arg14) : (vector<3xf32>) -> vector<3xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32) -> (), sym_name = "cl_binary_float"}> ({
  ^bb0(%arg11: f32, %arg12: f32):
    %7 = "spirv.CL.pow"(%arg11, %arg12) : (f32, f32) -> f32
    %8 = "spirv.CL.atan2"(%arg11, %arg12) : (f32, f32) -> f32
    %9 = "spirv.CL.fmax"(%arg11, %arg12) : (f32, f32) -> f32
    %10 = "spirv.CL.fmin"(%arg11, %arg12) : (f32, f32) -> f32
    %11 = "spirv.CL.copysign"(%arg11, %arg12) : (f32, f32) -> f32
    %12 = "spirv.CL.fmod"(%arg11, %arg12) : (f32, f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32, f32) -> (), sym_name = "cl_fma"}> ({
  ^bb0(%arg8: f32, %arg9: f32, %arg10: f32):
    %6 = "spirv.CL.fma"(%arg8, %arg9, %arg10) : (f32, f32, f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> (), sym_name = "cl_integer"}> ({
  ^bb0(%arg6: i32, %arg7: i32):
    %2 = "spirv.CL.s_max"(%arg6, %arg7) : (i32, i32) -> i32
    %3 = "spirv.CL.s_min"(%arg6, %arg7) : (i32, i32) -> i32
    %4 = "spirv.CL.u_max"(%arg6, %arg7) : (i32, i32) -> i32
    %5 = "spirv.CL.u_min"(%arg6, %arg7) : (i32, i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32, f32) -> (), sym_name = "mix_scalar"}> ({
  ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
    %1 = "spirv.CL.mix"(%arg3, %arg4, %arg5) : (f32, f32, f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> (), sym_name = "mix_vector"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xf32>):
    %0 = "spirv.CL.mix"(%arg0, %arg1, %arg2) : (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

