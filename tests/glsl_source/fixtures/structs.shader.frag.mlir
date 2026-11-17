"builtin.module"() ({
  "glsl.shader"() <{es, stage = 1 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x0, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "o_color", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{builtin = 0x4, storage = 0x0, sym_name = "gl_FragCoord", ty = vector<4xf32>}> : () -> ()
    "func.func"() <{function_type = (vector<3xf32>, f32) -> !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, sym_name = "make"}> ({
    ^bb0(%arg4: vector<3xf32>, %arg5: f32):
      %256 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %257 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      "spirv.Store"(%257, %arg4) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      "spirv.Store"(%256, %arg5) : (!spirv.ptr<f32, Function>, f32) -> ()
      %258 = "spirv.Load"(%257) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %259 = "spirv.Load"(%256) : (!spirv.ptr<f32, Function>) -> f32
      %260 = "spirv.Load"(%256) : (!spirv.ptr<f32, Function>) -> f32
      %261 = "glsl.construct"(%260) : (f32) -> vector<2xf32>
      %262 = "spirv.Load"(%257) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %263 = "vector.shuffle"(%262, %262) <{mask = array<i64: 0, 1>}> : (vector<3xf32>, vector<3xf32>) -> vector<2xf32>
      %264 = "spirv.CompositeConstruct"(%261, %263) : (vector<2xf32>, vector<2xf32>) -> !spirv.array<2 x vector<2xf32>>
      %265 = "spirv.CompositeConstruct"(%258, %259, %264) : (vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>) -> !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>
      "spirv.ReturnValue"(%265) : (!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>) -> ()
    }) : () -> ()
    "func.func"() <{function_type = (!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, vector<3xf32>) -> f32, sym_name = "shade"}> ({
    ^bb0(%arg2: !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, %arg3: vector<3xf32>):
      %237 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      %238 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>
      "spirv.Store"(%238, %arg2) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>, !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>) -> ()
      "spirv.Store"(%237, %arg3) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %239 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %240 = "spirv.AccessChain"(%238, %239) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>, i32) -> !spirv.ptr<vector<3xf32>, Function>
      %241 = "spirv.Load"(%240) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %242 = "spirv.Load"(%237) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %243 = "glsl.builtin"(%241, %242) <{func = 0x2c}> : (vector<3xf32>, vector<3xf32>) -> f32
      %244 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %245 = "glsl.builtin"(%243, %244) <{func = 0x1c}> : (f32, f32) -> f32
      %246 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %247 = "spirv.AccessChain"(%238, %246) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>, i32) -> !spirv.ptr<f32, Function>
      %248 = "spirv.Load"(%247) : (!spirv.ptr<f32, Function>) -> f32
      %249 = "arith.mulf"(%245, %248) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %250 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %251 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %252 = "spirv.AccessChain"(%238, %250, %251) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>, i32, i32) -> !spirv.ptr<vector<2xf32>, Function>
      %253 = "spirv.Load"(%252) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %254 = "vector.extract"(%253) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %255 = "arith.addf"(%249, %254) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "spirv.ReturnValue"(%255) : (f32) -> ()
    }) : () -> ()
    "func.func"() <{function_type = (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>, f32) -> (), sym_name = "dim"}> ({
    ^bb0(%arg0: !spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>, %arg1: f32):
      %219 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      "spirv.Store"(%219, %arg1) : (!spirv.ptr<f32, Function>, f32) -> ()
      %220 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %221 = "spirv.AccessChain"(%arg0, %220) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>, i32) -> !spirv.ptr<f32, Function>
      %222 = "spirv.Load"(%221) : (!spirv.ptr<f32, Function>) -> f32
      %223 = "spirv.Load"(%219) : (!spirv.ptr<f32, Function>) -> f32
      %224 = "arith.mulf"(%222, %223) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %225 = "spirv.AccessChain"(%arg0, %220) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>, i32) -> !spirv.ptr<f32, Function>
      "spirv.Store"(%225, %224) : (!spirv.ptr<f32, Function>, f32) -> ()
      %226 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %227 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %228 = "spirv.AccessChain"(%arg0, %226, %227) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>, i32, i32) -> !spirv.ptr<vector<2xf32>, Function>
      %229 = "spirv.Load"(%228) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %230 = "vector.extract"(%229) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %231 = "spirv.Load"(%219) : (!spirv.ptr<f32, Function>) -> f32
      %232 = "arith.subf"(%230, %231) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %233 = "spirv.AccessChain"(%arg0, %226, %227) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>, i32, i32) -> !spirv.ptr<vector<2xf32>, Function>
      %234 = "spirv.Load"(%233) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %235 = "vector.insert"(%232, %234) <{static_position = array<i64: 0>}> : (f32, vector<2xf32>) -> vector<2xf32>
      %236 = "spirv.AccessChain"(%arg0, %226, %227) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>, i32, i32) -> !spirv.ptr<vector<2xf32>, Function>
      "spirv.Store"(%236, %235) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i1, Function>
      %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %2 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i32, Function>
      %3 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.array<3 x !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>>, Function>
      %4 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.struct<(!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, i32)>, Function>
      %5 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>
      %6 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>
      %7 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>
      %8 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      %9 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %10 = "glsl.load"() <{var = @gl_FragCoord}> : () -> vector<4xf32>
      %11 = "vector.shuffle"(%10, %10) <{mask = array<i64: 0, 1>}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
      "spirv.Store"(%9, %11) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %12 = "glsl.load"() <{var = @v_uv}> : () -> vector<2xf32>
      %13 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %14 = "glsl.construct"(%13) : (f32) -> vector<2xf32>
      %15 = "arith.subf"(%12, %14) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %16 = "arith.constant"() <{value = 0.699999988 : f32}> : () -> f32
      %17 = "glsl.construct"(%15, %16) : (vector<2xf32>, f32) -> vector<3xf32>
      %18 = "glsl.builtin"(%17) <{func = 0x2e}> : (vector<3xf32>) -> vector<3xf32>
      "spirv.Store"(%8, %18) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %19 = "arith.constant"() <{value = 3.000000e-01 : f32}> : () -> f32
      %20 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %21 = "arith.constant"() <{value = 8.000000e-01 : f32}> : () -> f32
      %22 = "glsl.construct"(%19, %20, %21) : (f32, f32, f32) -> vector<3xf32>
      %23 = "glsl.builtin"(%22) <{func = 0x2e}> : (vector<3xf32>) -> vector<3xf32>
      %24 = "arith.constant"() <{value = 1.250000e+00 : f32}> : () -> f32
      %25 = "func.call"(%23, %24) <{callee = @make}> : (vector<3xf32>, f32) -> !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>
      "spirv.Store"(%7, %25) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>, !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>) -> ()
      %26 = "spirv.Load"(%7) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>) -> !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>
      "spirv.Store"(%6, %26) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>, !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>) -> ()
      %27 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %28 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %29 = "spirv.AccessChain"(%6, %28) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>, i32) -> !spirv.ptr<vector<3xf32>, Function>
      %30 = "spirv.Load"(%29) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %31 = "vector.extract"(%30) <{static_position = array<i64: 2>}> : (vector<3xf32>) -> f32
      %32 = "arith.negf"(%31) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %33 = "spirv.AccessChain"(%6, %27) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>, i32) -> !spirv.ptr<vector<3xf32>, Function>
      %34 = "spirv.Load"(%33) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %35 = "vector.insert"(%32, %34) <{static_position = array<i64: 2>}> : (f32, vector<3xf32>) -> vector<3xf32>
      %36 = "spirv.AccessChain"(%6, %27) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>, i32) -> !spirv.ptr<vector<3xf32>, Function>
      "spirv.Store"(%36, %35) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %37 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %38 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %39 = "spirv.Load"(%9) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %40 = "vector.extract"(%39) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %41 = "arith.constant"() <{value = 0.00999999977 : f32}> : () -> f32
      %42 = "arith.mulf"(%40, %41) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %43 = "spirv.AccessChain"(%6, %37, %38) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>, i32, i32) -> !spirv.ptr<vector<2xf32>, Function>
      %44 = "spirv.Load"(%43) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %45 = "vector.insert"(%42, %44) <{static_position = array<i64: 1>}> : (f32, vector<2xf32>) -> vector<2xf32>
      %46 = "spirv.AccessChain"(%6, %37, %38) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>, i32, i32) -> !spirv.ptr<vector<2xf32>, Function>
      "spirv.Store"(%46, %45) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %47 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %48 = "spirv.Load"(%6) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>) -> !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>
      "spirv.Store"(%5, %48) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>, !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>) -> ()
      "func.call"(%5, %47) <{callee = @dim}> : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>, f32) -> ()
      %49 = "spirv.Load"(%5) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>) -> !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>
      "spirv.Store"(%6, %49) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>, !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>) -> ()
      %50 = "arith.constant"() <{value = 0 : i1}> : () -> i1
      %51 = "spirv.Load"(%7) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>) -> !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>
      %52 = "spirv.Load"(%6) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>) -> !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>
      %53 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %54 = "spirv.CompositeConstruct"(%51, %52, %53) : (!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, i32) -> !spirv.struct<(!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, i32)>
      "spirv.Store"(%4, %54) : (!spirv.ptr<!spirv.struct<(!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, i32)>, Function>, !spirv.struct<(!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, i32)>) -> ()
      %55 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %56 = "spirv.Load"(%7) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>) -> !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>
      %57 = "spirv.AccessChain"(%3, %55) : (!spirv.ptr<!spirv.array<3 x !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>>, Function>, i32) -> !spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>
      "spirv.Store"(%57, %56) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>, !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>) -> ()
      %58 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %59 = "spirv.Load"(%6) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>) -> !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>
      %60 = "spirv.AccessChain"(%3, %58) : (!spirv.ptr<!spirv.array<3 x !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>>, Function>, i32) -> !spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>
      "spirv.Store"(%60, %59) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>, !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>) -> ()
      %61 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %62 = "spirv.Load"(%8) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %63 = "vector.shuffle"(%62, %62) <{mask = array<i64: 2, 1, 0>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
      %64 = "arith.constant"() <{value = 3.000000e-01 : f32}> : () -> f32
      %65 = "func.call"(%63, %64) <{callee = @make}> : (vector<3xf32>, f32) -> !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>
      %66 = "spirv.AccessChain"(%3, %61) : (!spirv.ptr<!spirv.array<3 x !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>>, Function>, i32) -> !spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>
      "spirv.Store"(%66, %65) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>, !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>) -> ()
      %67 = "spirv.Load"(%9) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %68 = "vector.extract"(%67) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %69 = "arith.fptosi"(%68) : (f32) -> i32
      %70 = "arith.constant"() <{value = 3 : i32}> : () -> i32
      %71 = "arith.remsi"(%69, %70) : (i32, i32) -> i32
      "spirv.Store"(%2, %71) : (!spirv.ptr<i32, Function>, i32) -> ()
      %72 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %73 = "spirv.AccessChain"(%4, %72) : (!spirv.ptr<!spirv.struct<(!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, i32)>, Function>, i32) -> !spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>
      %74 = "spirv.Load"(%73) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>) -> !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>
      %75 = "spirv.Load"(%8) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %76 = "func.call"(%74, %75) <{callee = @shade}> : (!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, vector<3xf32>) -> f32
      %77 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %78 = "spirv.AccessChain"(%4, %77) : (!spirv.ptr<!spirv.struct<(!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, i32)>, Function>, i32) -> !spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>
      %79 = "spirv.Load"(%78) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>) -> !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>
      %80 = "spirv.Load"(%8) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %81 = "func.call"(%79, %80) <{callee = @shade}> : (!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, vector<3xf32>) -> f32
      %82 = "arith.addf"(%76, %81) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %83 = "spirv.Load"(%2) : (!spirv.ptr<i32, Function>) -> i32
      %84 = "spirv.AccessChain"(%3, %83) : (!spirv.ptr<!spirv.array<3 x !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>>, Function>, i32) -> !spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>
      %85 = "spirv.Load"(%84) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>) -> !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>
      %86 = "spirv.Load"(%8) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %87 = "func.call"(%85, %86) <{callee = @shade}> : (!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, vector<3xf32>) -> f32
      %88 = "arith.addf"(%82, %87) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "spirv.Store"(%1, %88) : (!spirv.ptr<f32, Function>, f32) -> ()
      %89 = "spirv.Load"(%7) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>) -> !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>
      %90 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %91 = "spirv.AccessChain"(%4, %90) : (!spirv.ptr<!spirv.struct<(!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, i32)>, Function>, i32) -> !spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>
      %92 = "spirv.Load"(%91) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>) -> !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>
      %93 = "spirv.CompositeExtract"(%89) <{indices = [0 : i32]}> : (!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>) -> vector<3xf32>
      %94 = "spirv.CompositeExtract"(%92) <{indices = [0 : i32]}> : (!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>) -> vector<3xf32>
      %95 = "arith.cmpf"(%93, %94) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (vector<3xf32>, vector<3xf32>) -> vector<3xi1>
      %96 = "vector.extract"(%95) <{static_position = array<i64: 0>}> : (vector<3xi1>) -> i1
      %97 = "vector.extract"(%95) <{static_position = array<i64: 1>}> : (vector<3xi1>) -> i1
      %98 = "arith.andi"(%96, %97) : (i1, i1) -> i1
      %99 = "vector.extract"(%95) <{static_position = array<i64: 2>}> : (vector<3xi1>) -> i1
      %100 = "arith.andi"(%98, %99) : (i1, i1) -> i1
      %101 = "spirv.CompositeExtract"(%89) <{indices = [1 : i32]}> : (!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>) -> f32
      %102 = "spirv.CompositeExtract"(%92) <{indices = [1 : i32]}> : (!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>) -> f32
      %103 = "arith.cmpf"(%101, %102) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      %104 = "arith.andi"(%100, %103) : (i1, i1) -> i1
      %105 = "spirv.CompositeExtract"(%89) <{indices = [2 : i32]}> : (!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>) -> !spirv.array<2 x vector<2xf32>>
      %106 = "spirv.CompositeExtract"(%92) <{indices = [2 : i32]}> : (!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>) -> !spirv.array<2 x vector<2xf32>>
      %107 = "spirv.CompositeExtract"(%105) <{indices = [0 : i32]}> : (!spirv.array<2 x vector<2xf32>>) -> vector<2xf32>
      %108 = "spirv.CompositeExtract"(%106) <{indices = [0 : i32]}> : (!spirv.array<2 x vector<2xf32>>) -> vector<2xf32>
      %109 = "arith.cmpf"(%107, %108) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (vector<2xf32>, vector<2xf32>) -> vector<2xi1>
      %110 = "vector.extract"(%109) <{static_position = array<i64: 0>}> : (vector<2xi1>) -> i1
      %111 = "vector.extract"(%109) <{static_position = array<i64: 1>}> : (vector<2xi1>) -> i1
      %112 = "arith.andi"(%110, %111) : (i1, i1) -> i1
      %113 = "spirv.CompositeExtract"(%105) <{indices = [1 : i32]}> : (!spirv.array<2 x vector<2xf32>>) -> vector<2xf32>
      %114 = "spirv.CompositeExtract"(%106) <{indices = [1 : i32]}> : (!spirv.array<2 x vector<2xf32>>) -> vector<2xf32>
      %115 = "arith.cmpf"(%113, %114) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (vector<2xf32>, vector<2xf32>) -> vector<2xi1>
      %116 = "vector.extract"(%115) <{static_position = array<i64: 0>}> : (vector<2xi1>) -> i1
      %117 = "vector.extract"(%115) <{static_position = array<i64: 1>}> : (vector<2xi1>) -> i1
      %118 = "arith.andi"(%116, %117) : (i1, i1) -> i1
      %119 = "arith.andi"(%112, %118) : (i1, i1) -> i1
      %120 = "arith.andi"(%104, %119) : (i1, i1) -> i1
      %121 = "spirv.Load"(%7) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>) -> !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>
      %122 = "spirv.Load"(%6) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>) -> !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>
      %123 = "spirv.CompositeExtract"(%121) <{indices = [0 : i32]}> : (!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>) -> vector<3xf32>
      %124 = "spirv.CompositeExtract"(%122) <{indices = [0 : i32]}> : (!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>) -> vector<3xf32>
      %125 = "arith.cmpf"(%123, %124) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (vector<3xf32>, vector<3xf32>) -> vector<3xi1>
      %126 = "vector.extract"(%125) <{static_position = array<i64: 0>}> : (vector<3xi1>) -> i1
      %127 = "vector.extract"(%125) <{static_position = array<i64: 1>}> : (vector<3xi1>) -> i1
      %128 = "arith.andi"(%126, %127) : (i1, i1) -> i1
      %129 = "vector.extract"(%125) <{static_position = array<i64: 2>}> : (vector<3xi1>) -> i1
      %130 = "arith.andi"(%128, %129) : (i1, i1) -> i1
      %131 = "spirv.CompositeExtract"(%121) <{indices = [1 : i32]}> : (!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>) -> f32
      %132 = "spirv.CompositeExtract"(%122) <{indices = [1 : i32]}> : (!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>) -> f32
      %133 = "arith.cmpf"(%131, %132) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      %134 = "arith.andi"(%130, %133) : (i1, i1) -> i1
      %135 = "spirv.CompositeExtract"(%121) <{indices = [2 : i32]}> : (!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>) -> !spirv.array<2 x vector<2xf32>>
      %136 = "spirv.CompositeExtract"(%122) <{indices = [2 : i32]}> : (!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>) -> !spirv.array<2 x vector<2xf32>>
      %137 = "spirv.CompositeExtract"(%135) <{indices = [0 : i32]}> : (!spirv.array<2 x vector<2xf32>>) -> vector<2xf32>
      %138 = "spirv.CompositeExtract"(%136) <{indices = [0 : i32]}> : (!spirv.array<2 x vector<2xf32>>) -> vector<2xf32>
      %139 = "arith.cmpf"(%137, %138) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (vector<2xf32>, vector<2xf32>) -> vector<2xi1>
      %140 = "vector.extract"(%139) <{static_position = array<i64: 0>}> : (vector<2xi1>) -> i1
      %141 = "vector.extract"(%139) <{static_position = array<i64: 1>}> : (vector<2xi1>) -> i1
      %142 = "arith.andi"(%140, %141) : (i1, i1) -> i1
      %143 = "spirv.CompositeExtract"(%135) <{indices = [1 : i32]}> : (!spirv.array<2 x vector<2xf32>>) -> vector<2xf32>
      %144 = "spirv.CompositeExtract"(%136) <{indices = [1 : i32]}> : (!spirv.array<2 x vector<2xf32>>) -> vector<2xf32>
      %145 = "arith.cmpf"(%143, %144) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (vector<2xf32>, vector<2xf32>) -> vector<2xi1>
      %146 = "vector.extract"(%145) <{static_position = array<i64: 0>}> : (vector<2xi1>) -> i1
      %147 = "vector.extract"(%145) <{static_position = array<i64: 1>}> : (vector<2xi1>) -> i1
      %148 = "arith.andi"(%146, %147) : (i1, i1) -> i1
      %149 = "arith.andi"(%142, %148) : (i1, i1) -> i1
      %150 = "arith.andi"(%134, %149) : (i1, i1) -> i1
      %151 = "arith.constant"() <{value = 1 : i1}> : () -> i1
      %152 = "arith.xori"(%150, %151) : (i1, i1) -> i1
      %153 = "arith.andi"(%120, %152) : (i1, i1) -> i1
      %154 = "spirv.Load"(%6) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>) -> !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>
      %155 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %156 = "spirv.AccessChain"(%3, %155) : (!spirv.ptr<!spirv.array<3 x !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>>, Function>, i32) -> !spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>
      %157 = "spirv.Load"(%156) : (!spirv.ptr<!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, Function>) -> !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>
      %158 = "spirv.CompositeExtract"(%154) <{indices = [0 : i32]}> : (!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>) -> vector<3xf32>
      %159 = "spirv.CompositeExtract"(%157) <{indices = [0 : i32]}> : (!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>) -> vector<3xf32>
      %160 = "arith.cmpf"(%158, %159) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (vector<3xf32>, vector<3xf32>) -> vector<3xi1>
      %161 = "vector.extract"(%160) <{static_position = array<i64: 0>}> : (vector<3xi1>) -> i1
      %162 = "vector.extract"(%160) <{static_position = array<i64: 1>}> : (vector<3xi1>) -> i1
      %163 = "arith.andi"(%161, %162) : (i1, i1) -> i1
      %164 = "vector.extract"(%160) <{static_position = array<i64: 2>}> : (vector<3xi1>) -> i1
      %165 = "arith.andi"(%163, %164) : (i1, i1) -> i1
      %166 = "spirv.CompositeExtract"(%154) <{indices = [1 : i32]}> : (!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>) -> f32
      %167 = "spirv.CompositeExtract"(%157) <{indices = [1 : i32]}> : (!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>) -> f32
      %168 = "arith.cmpf"(%166, %167) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      %169 = "arith.andi"(%165, %168) : (i1, i1) -> i1
      %170 = "spirv.CompositeExtract"(%154) <{indices = [2 : i32]}> : (!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>) -> !spirv.array<2 x vector<2xf32>>
      %171 = "spirv.CompositeExtract"(%157) <{indices = [2 : i32]}> : (!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>) -> !spirv.array<2 x vector<2xf32>>
      %172 = "spirv.CompositeExtract"(%170) <{indices = [0 : i32]}> : (!spirv.array<2 x vector<2xf32>>) -> vector<2xf32>
      %173 = "spirv.CompositeExtract"(%171) <{indices = [0 : i32]}> : (!spirv.array<2 x vector<2xf32>>) -> vector<2xf32>
      %174 = "arith.cmpf"(%172, %173) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (vector<2xf32>, vector<2xf32>) -> vector<2xi1>
      %175 = "vector.extract"(%174) <{static_position = array<i64: 0>}> : (vector<2xi1>) -> i1
      %176 = "vector.extract"(%174) <{static_position = array<i64: 1>}> : (vector<2xi1>) -> i1
      %177 = "arith.andi"(%175, %176) : (i1, i1) -> i1
      %178 = "spirv.CompositeExtract"(%170) <{indices = [1 : i32]}> : (!spirv.array<2 x vector<2xf32>>) -> vector<2xf32>
      %179 = "spirv.CompositeExtract"(%171) <{indices = [1 : i32]}> : (!spirv.array<2 x vector<2xf32>>) -> vector<2xf32>
      %180 = "arith.cmpf"(%178, %179) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (vector<2xf32>, vector<2xf32>) -> vector<2xi1>
      %181 = "vector.extract"(%180) <{static_position = array<i64: 0>}> : (vector<2xi1>) -> i1
      %182 = "vector.extract"(%180) <{static_position = array<i64: 1>}> : (vector<2xi1>) -> i1
      %183 = "arith.andi"(%181, %182) : (i1, i1) -> i1
      %184 = "arith.andi"(%177, %183) : (i1, i1) -> i1
      %185 = "arith.andi"(%169, %184) : (i1, i1) -> i1
      %186 = "arith.constant"() <{value = 1 : i1}> : () -> i1
      %187 = "arith.xori"(%185, %186) : (i1, i1) -> i1
      %188 = "arith.andi"(%153, %187) : (i1, i1) -> i1
      "spirv.Store"(%0, %188) : (!spirv.ptr<i1, Function>, i1) -> ()
      %189 = "spirv.Load"(%1) : (!spirv.ptr<f32, Function>) -> f32
      %190 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %191 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %192 = "spirv.AccessChain"(%4, %190, %191) : (!spirv.ptr<!spirv.struct<(!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, i32)>, Function>, i32, i32) -> !spirv.ptr<f32, Function>
      %193 = "spirv.Load"(%192) : (!spirv.ptr<f32, Function>) -> f32
      %194 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %195 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %196 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %197 = "spirv.AccessChain"(%4, %194, %195, %196) : (!spirv.ptr<!spirv.struct<(!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, i32)>, Function>, i32, i32, i32) -> !spirv.ptr<vector<2xf32>, Function>
      %198 = "spirv.Load"(%197) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %199 = "vector.extract"(%198) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %200 = "arith.addf"(%193, %199) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %201 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %202 = "spirv.AccessChain"(%4, %201) : (!spirv.ptr<!spirv.struct<(!spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>, i32)>, Function>, i32) -> !spirv.ptr<i32, Function>
      %203 = "spirv.Load"(%202) : (!spirv.ptr<i32, Function>) -> i32
      %204 = "arith.sitofp"(%203) : (i32) -> f32
      %205 = "arith.constant"() <{value = 1.000000e-01 : f32}> : () -> f32
      %206 = "arith.mulf"(%204, %205) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %207 = "spirv.Load"(%0) : (!spirv.ptr<i1, Function>) -> i1
      %208 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %209 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %210 = "arith.select"(%207, %208, %209) : (i1, f32, f32) -> f32
      %211 = "arith.addf"(%206, %210) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %212 = "spirv.Load"(%2) : (!spirv.ptr<i32, Function>) -> i32
      %213 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %214 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %215 = "spirv.AccessChain"(%3, %212, %213, %214) : (!spirv.ptr<!spirv.array<3 x !spirv.struct<(vector<3xf32>, f32, !spirv.array<2 x vector<2xf32>>)>>, Function>, i32, i32, i32) -> !spirv.ptr<vector<2xf32>, Function>
      %216 = "spirv.Load"(%215) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %217 = "vector.extract"(%216) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %218 = "glsl.construct"(%189, %200, %211, %217) : (f32, f32, f32, f32) -> vector<4xf32>
      "glsl.store"(%218) <{var = @o_color}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
