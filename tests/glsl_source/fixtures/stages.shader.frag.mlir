"builtin.module"() ({
  "glsl.shader"() <{es, stage = 1 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x0, sym_name = "v_color", ty = vector<3xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "o_color", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{location = 2 : i32, storage = 0x2, sym_name = "u_tint", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{location = 3 : i32, storage = 0x2, sym_name = "u_flip", ty = i1}> : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "glsl.load"() <{var = @u_tint}> : () -> vector<4xf32>
      "glsl.store"(%0) <{var = @o_color}> : (vector<4xf32>) -> ()
      %1 = "glsl.load"() <{var = @u_flip}> : () -> i1
      "scf.if"(%1) ({
        %2 = "glsl.load"() <{var = @v_color}> : () -> vector<3xf32>
        %3 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
        %4 = "glsl.construct"(%2, %3) : (vector<3xf32>, f32) -> vector<4xf32>
        %5 = "glsl.load"() <{var = @u_tint}> : () -> vector<4xf32>
        %6 = "arith.mulf"(%4, %5) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
        "glsl.store"(%6) <{var = @o_color}> : (vector<4xf32>) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
