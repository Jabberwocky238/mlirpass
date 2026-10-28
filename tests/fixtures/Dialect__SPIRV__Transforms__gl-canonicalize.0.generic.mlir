"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, f32) -> f32, sym_name = "clamp_fordlessthan"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):
    %0 = "spirv.GL.FClamp"(%arg0, %arg1, %arg2) : (f32, f32, f32) -> f32
    "spirv.ReturnValue"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, f32) -> f32, sym_name = "clamp_fordlessthan"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):
    %0 = "spirv.GL.FClamp"(%arg0, %arg1, %arg2) : (f32, f32, f32) -> f32
    "spirv.ReturnValue"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, f32) -> f32, sym_name = "clamp_fordlessthanequal"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):
    %0 = "spirv.GL.FClamp"(%arg0, %arg1, %arg2) : (f32, f32, f32) -> f32
    "spirv.ReturnValue"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, f32) -> f32, sym_name = "clamp_fordlessthanequal"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):
    %0 = "spirv.GL.FClamp"(%arg0, %arg1, %arg2) : (f32, f32, f32) -> f32
    "spirv.ReturnValue"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (si32, si32, si32) -> si32, sym_name = "clamp_slessthan"}> ({
  ^bb0(%arg0: si32, %arg1: si32, %arg2: si32):
    %0 = "spirv.GL.SClamp"(%arg0, %arg1, %arg2) : (si32, si32, si32) -> si32
    "spirv.ReturnValue"(%0) : (si32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (si32, si32, si32) -> si32, sym_name = "clamp_slessthan"}> ({
  ^bb0(%arg0: si32, %arg1: si32, %arg2: si32):
    %0 = "spirv.GL.SClamp"(%arg0, %arg1, %arg2) : (si32, si32, si32) -> si32
    "spirv.ReturnValue"(%0) : (si32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (si32, si32, si32) -> si32, sym_name = "clamp_slessthanequal"}> ({
  ^bb0(%arg0: si32, %arg1: si32, %arg2: si32):
    %0 = "spirv.GL.SClamp"(%arg0, %arg1, %arg2) : (si32, si32, si32) -> si32
    "spirv.ReturnValue"(%0) : (si32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (si32, si32, si32) -> si32, sym_name = "clamp_slessthanequal"}> ({
  ^bb0(%arg0: si32, %arg1: si32, %arg2: si32):
    %0 = "spirv.GL.SClamp"(%arg0, %arg1, %arg2) : (si32, si32, si32) -> si32
    "spirv.ReturnValue"(%0) : (si32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, i32) -> i32, sym_name = "clamp_ulessthan"}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):
    %0 = "spirv.GL.UClamp"(%arg0, %arg1, %arg2) : (i32, i32, i32) -> i32
    "spirv.ReturnValue"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, i32) -> i32, sym_name = "clamp_ulessthan"}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):
    %0 = "spirv.GL.UClamp"(%arg0, %arg1, %arg2) : (i32, i32, i32) -> i32
    "spirv.ReturnValue"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, i32) -> i32, sym_name = "clamp_ulessthanequal"}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):
    %0 = "spirv.GL.UClamp"(%arg0, %arg1, %arg2) : (i32, i32, i32) -> i32
    "spirv.ReturnValue"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, i32) -> i32, sym_name = "clamp_ulessthanequal"}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):
    %0 = "spirv.GL.UClamp"(%arg0, %arg1, %arg2) : (i32, i32, i32) -> i32
    "spirv.ReturnValue"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

