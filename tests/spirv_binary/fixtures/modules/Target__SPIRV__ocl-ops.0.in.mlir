"spirv.module"() <{addressing_model = #spirv.addressing_model<Physical64>, memory_model = #spirv.memory_model<OpenCL>, vce_triple = #spirv.vce<v1.0, [Kernel, Addresses, Vector16, Linkage], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "float_insts"}> ({
  ^bb0(%arg13: f32):
    %16 = "spirv.CL.exp"(%arg13) : (f32) -> f32
    %17 = "spirv.CL.fabs"(%arg13) : (f32) -> f32
    %18 = "spirv.CL.sin"(%arg13) : (f32) -> f32
    %19 = "spirv.CL.cos"(%arg13) : (f32) -> f32
    %20 = "spirv.CL.log"(%arg13) : (f32) -> f32
    %21 = "spirv.CL.exp2"(%arg13) : (f32) -> f32
    %22 = "spirv.CL.exp10"(%arg13) : (f32) -> f32
    %23 = "spirv.CL.log2"(%arg13) : (f32) -> f32
    %24 = "spirv.CL.log10"(%arg13) : (f32) -> f32
    %25 = "spirv.CL.sqrt"(%arg13) : (f32) -> f32
    %26 = "spirv.CL.ceil"(%arg13) : (f32) -> f32
    %27 = "spirv.CL.floor"(%arg13) : (f32) -> f32
    %28 = "spirv.CL.pow"(%arg13, %arg13) : (f32, f32) -> f32
    %29 = "spirv.CL.rsqrt"(%arg13) : (f32) -> f32
    %30 = "spirv.CL.erf"(%arg13) : (f32) -> f32
    %31 = "spirv.CL.erfc"(%arg13) : (f32) -> f32
    %32 = "spirv.CL.trunc"(%arg13) : (f32) -> f32
    %33 = "spirv.CL.cbrt"(%arg13) : (f32) -> f32
    %34 = "spirv.CL.copysign"(%arg13, %arg13) : (f32, f32) -> f32
    %35 = "spirv.CL.expm1"(%arg13) : (f32) -> f32
    %36 = "spirv.CL.fdim"(%arg13, %arg13) : (f32, f32) -> f32
    %37 = "spirv.CL.fmod"(%arg13, %arg13) : (f32, f32) -> f32
    %38 = "spirv.CL.hypot"(%arg13, %arg13) : (f32, f32) -> f32
    %39 = "spirv.CL.log1p"(%arg13) : (f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "integer_insts"}> ({
  ^bb0(%arg12: i32):
    %14 = "spirv.CL.s_abs"(%arg12) : (i32) -> i32
    %15 = "spirv.CL.clz"(%arg12) : (i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<16xf32>) -> (), sym_name = "vector_size16"}> ({
  ^bb0(%arg11: vector<16xf32>):
    %13 = "spirv.CL.fabs"(%arg11) : (vector<16xf32>) -> vector<16xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32, f32) -> (), sym_name = "fma"}> ({
  ^bb0(%arg8: f32, %arg9: f32, %arg10: f32):
    %12 = "spirv.CL.fma"(%arg8, %arg9, %arg10) : (f32, f32, f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, i32) -> (), sym_name = "float_int_insts"}> ({
  ^bb0(%arg6: f32, %arg7: i32):
    %9 = "spirv.CL.ldexp"(%arg6, %arg7) : (f32, i32) -> f32
    %10 = "spirv.CL.pown"(%arg6, %arg7) : (f32, i32) -> f32
    %11 = "spirv.CL.rootn"(%arg6, %arg7) : (f32, i32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xf32>, vector<3xi32>) -> (), sym_name = "float_int_vec_insts"}> ({
  ^bb0(%arg4: vector<3xf32>, %arg5: vector<3xi32>):
    %6 = "spirv.CL.ldexp"(%arg4, %arg5) : (vector<3xf32>, vector<3xi32>) -> vector<3xf32>
    %7 = "spirv.CL.pown"(%arg4, %arg5) : (vector<3xf32>, vector<3xi32>) -> vector<3xf32>
    %8 = "spirv.CL.rootn"(%arg4, %arg5) : (vector<3xf32>, vector<3xi32>) -> vector<3xf32>
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

