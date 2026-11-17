"builtin.module"() ({
  "glsl.shader"() <{es, stage = 1 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x0, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "o_color", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{binding = 9 : i32, precision = 0x2, storage = 0x2, sym_name = "u_tex", ty = !spirv.sampled_image<!spirv.image<si32, Dim2D, NoDepth, Arrayed, SingleSampled, NeedSampler, Unknown>>}> : () -> ()
    "glsl.global"() <{builtin = 0x4, storage = 0x0, sym_name = "gl_FragCoord", ty = vector<4xf32>}> : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<4xi32>, Function>
      %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<4xi32>, Function>
      %2 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      %3 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %4 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %5 = "glsl.load"() <{var = @gl_FragCoord}> : () -> vector<4xf32>
      %6 = "vector.shuffle"(%5, %5) <{mask = array<i64: 0, 1>}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
      "spirv.Store"(%4, %6) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %7 = "glsl.load"() <{var = @v_uv}> : () -> vector<2xf32>
      %8 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
      %9 = "glsl.construct"(%8) : (f32) -> vector<2xf32>
      %10 = "arith.mulf"(%7, %9) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %11 = "arith.constant"() <{value = 3.000000e-01 : f32}> : () -> f32
      %12 = "glsl.construct"(%11) : (f32) -> vector<2xf32>
      %13 = "arith.subf"(%10, %12) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      "spirv.Store"(%3, %13) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %14 = "spirv.Load"(%3) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %15 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
      %16 = "glsl.construct"(%15) : (f32) -> vector<2xf32>
      %17 = "arith.mulf"(%14, %16) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %18 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %19 = "glsl.construct"(%18) : (f32) -> vector<2xf32>
      %20 = "arith.subf"(%17, %19) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %21 = "arith.constant"() <{value = 6.000000e-01 : f32}> : () -> f32
      %22 = "spirv.Load"(%3) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %23 = "vector.extract"(%22) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %24 = "arith.subf"(%21, %23) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %25 = "glsl.construct"(%20, %24) : (vector<2xf32>, f32) -> vector<3xf32>
      %26 = "glsl.builtin"(%25) <{func = 0x2e}> : (vector<3xf32>) -> vector<3xf32>
      "spirv.Store"(%2, %26) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %27 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<si32, Dim2D, NoDepth, Arrayed, SingleSampled, NeedSampler, Unknown>>
      %28 = "spirv.Load"(%3) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %29 = "arith.constant"() <{value = 1.600000e+00 : f32}> : () -> f32
      %30 = "glsl.construct"(%28, %29) : (vector<2xf32>, f32) -> vector<3xf32>
      %31 = "glsl.texture"(%27, %30) <{lod = 0x0}> : (!spirv.sampled_image<!spirv.image<si32, Dim2D, NoDepth, Arrayed, SingleSampled, NeedSampler, Unknown>>, vector<3xf32>) -> vector<4xi32>
      "spirv.Store"(%1, %31) : (!spirv.ptr<vector<4xi32>, Function>, vector<4xi32>) -> ()
      %32 = "glsl.load"() <{var = @u_tex}> : () -> !spirv.sampled_image<!spirv.image<si32, Dim2D, NoDepth, Arrayed, SingleSampled, NeedSampler, Unknown>>
      %33 = "spirv.Load"(%4) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %34 = "arith.fptosi"(%33) : (vector<2xf32>) -> vector<2xi32>
      %35 = "arith.constant"() <{value = 8 : i32}> : () -> i32
      %36 = "glsl.construct"(%35) : (i32) -> vector<2xi32>
      %37 = "arith.divsi"(%34, %36) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
      %38 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %39 = "glsl.construct"(%37, %38) : (vector<2xi32>, i32) -> vector<3xi32>
      %40 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %41 = "glsl.texel_fetch"(%32, %39, %40) : (!spirv.sampled_image<!spirv.image<si32, Dim2D, NoDepth, Arrayed, SingleSampled, NeedSampler, Unknown>>, vector<3xi32>, i32) -> vector<4xi32>
      "spirv.Store"(%0, %41) : (!spirv.ptr<vector<4xi32>, Function>, vector<4xi32>) -> ()
      %42 = "spirv.Load"(%1) : (!spirv.ptr<vector<4xi32>, Function>) -> vector<4xi32>
      %43 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %44 = "glsl.construct"(%43) : (i32) -> vector<4xi32>
      %45 = "arith.muli"(%42, %44) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
      %46 = "spirv.Load"(%0) : (!spirv.ptr<vector<4xi32>, Function>) -> vector<4xi32>
      %47 = "arith.subi"(%45, %46) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
      %48 = "arith.sitofp"(%47) : (vector<4xi32>) -> vector<4xf32>
      %49 = "arith.constant"() <{value = 2.560000e+02 : f32}> : () -> f32
      %50 = "glsl.construct"(%49) : (f32) -> vector<4xf32>
      %51 = "arith.divf"(%48, %50) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
      "glsl.store"(%51) <{var = @o_color}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
