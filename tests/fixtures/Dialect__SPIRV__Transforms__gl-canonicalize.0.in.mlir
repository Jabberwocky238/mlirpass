"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, f32) -> f32, sym_name = "clamp_fordlessthan"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):
    %0 = "spirv.FOrdLessThan"(%arg1, %arg0) : (f32, f32) -> i1
    %1 = "spirv.Select"(%0, %arg0, %arg1) : (i1, f32, f32) -> f32
    %2 = "spirv.FOrdLessThan"(%1, %arg2) : (f32, f32) -> i1
    %3 = "spirv.Select"(%2, %1, %arg2) : (i1, f32, f32) -> f32
    "spirv.ReturnValue"(%3) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, f32) -> f32, sym_name = "clamp_fordlessthan"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):
    %0 = "spirv.FOrdLessThan"(%arg0, %arg1) : (f32, f32) -> i1
    %1 = "spirv.Select"(%0, %arg1, %arg0) : (i1, f32, f32) -> f32
    %2 = "spirv.FOrdLessThan"(%arg2, %arg0) : (f32, f32) -> i1
    %3 = "spirv.Select"(%2, %arg2, %1) : (i1, f32, f32) -> f32
    "spirv.ReturnValue"(%3) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, f32) -> f32, sym_name = "clamp_fordlessthanequal"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):
    %0 = "spirv.FOrdLessThanEqual"(%arg1, %arg0) : (f32, f32) -> i1
    %1 = "spirv.Select"(%0, %arg0, %arg1) : (i1, f32, f32) -> f32
    %2 = "spirv.FOrdLessThanEqual"(%1, %arg2) : (f32, f32) -> i1
    %3 = "spirv.Select"(%2, %1, %arg2) : (i1, f32, f32) -> f32
    "spirv.ReturnValue"(%3) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, f32) -> f32, sym_name = "clamp_fordlessthanequal"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):
    %0 = "spirv.FOrdLessThanEqual"(%arg0, %arg1) : (f32, f32) -> i1
    %1 = "spirv.Select"(%0, %arg1, %arg0) : (i1, f32, f32) -> f32
    %2 = "spirv.FOrdLessThanEqual"(%arg2, %arg0) : (f32, f32) -> i1
    %3 = "spirv.Select"(%2, %arg2, %1) : (i1, f32, f32) -> f32
    "spirv.ReturnValue"(%3) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (si32, si32, si32) -> si32, sym_name = "clamp_slessthan"}> ({
  ^bb0(%arg0: si32, %arg1: si32, %arg2: si32):
    %0 = "spirv.SLessThan"(%arg1, %arg0) : (si32, si32) -> i1
    %1 = "spirv.Select"(%0, %arg0, %arg1) : (i1, si32, si32) -> si32
    %2 = "spirv.SLessThan"(%1, %arg2) : (si32, si32) -> i1
    %3 = "spirv.Select"(%2, %1, %arg2) : (i1, si32, si32) -> si32
    "spirv.ReturnValue"(%3) : (si32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (si32, si32, si32) -> si32, sym_name = "clamp_slessthan"}> ({
  ^bb0(%arg0: si32, %arg1: si32, %arg2: si32):
    %0 = "spirv.SLessThan"(%arg0, %arg1) : (si32, si32) -> i1
    %1 = "spirv.Select"(%0, %arg1, %arg0) : (i1, si32, si32) -> si32
    %2 = "spirv.SLessThan"(%arg2, %arg0) : (si32, si32) -> i1
    %3 = "spirv.Select"(%2, %arg2, %1) : (i1, si32, si32) -> si32
    "spirv.ReturnValue"(%3) : (si32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (si32, si32, si32) -> si32, sym_name = "clamp_slessthanequal"}> ({
  ^bb0(%arg0: si32, %arg1: si32, %arg2: si32):
    %0 = "spirv.SLessThanEqual"(%arg1, %arg0) : (si32, si32) -> i1
    %1 = "spirv.Select"(%0, %arg0, %arg1) : (i1, si32, si32) -> si32
    %2 = "spirv.SLessThanEqual"(%1, %arg2) : (si32, si32) -> i1
    %3 = "spirv.Select"(%2, %1, %arg2) : (i1, si32, si32) -> si32
    "spirv.ReturnValue"(%3) : (si32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (si32, si32, si32) -> si32, sym_name = "clamp_slessthanequal"}> ({
  ^bb0(%arg0: si32, %arg1: si32, %arg2: si32):
    %0 = "spirv.SLessThanEqual"(%arg0, %arg1) : (si32, si32) -> i1
    %1 = "spirv.Select"(%0, %arg1, %arg0) : (i1, si32, si32) -> si32
    %2 = "spirv.SLessThanEqual"(%arg2, %arg0) : (si32, si32) -> i1
    %3 = "spirv.Select"(%2, %arg2, %1) : (i1, si32, si32) -> si32
    "spirv.ReturnValue"(%3) : (si32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, i32) -> i32, sym_name = "clamp_ulessthan"}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):
    %0 = "spirv.ULessThan"(%arg1, %arg0) : (i32, i32) -> i1
    %1 = "spirv.Select"(%0, %arg0, %arg1) : (i1, i32, i32) -> i32
    %2 = "spirv.ULessThan"(%1, %arg2) : (i32, i32) -> i1
    %3 = "spirv.Select"(%2, %1, %arg2) : (i1, i32, i32) -> i32
    "spirv.ReturnValue"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, i32) -> i32, sym_name = "clamp_ulessthan"}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):
    %0 = "spirv.ULessThan"(%arg0, %arg1) : (i32, i32) -> i1
    %1 = "spirv.Select"(%0, %arg1, %arg0) : (i1, i32, i32) -> i32
    %2 = "spirv.ULessThan"(%arg2, %arg0) : (i32, i32) -> i1
    %3 = "spirv.Select"(%2, %arg2, %1) : (i1, i32, i32) -> i32
    "spirv.ReturnValue"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, i32) -> i32, sym_name = "clamp_ulessthanequal"}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):
    %0 = "spirv.ULessThanEqual"(%arg1, %arg0) : (i32, i32) -> i1
    %1 = "spirv.Select"(%0, %arg0, %arg1) : (i1, i32, i32) -> i32
    %2 = "spirv.ULessThanEqual"(%1, %arg2) : (i32, i32) -> i1
    %3 = "spirv.Select"(%2, %1, %arg2) : (i1, i32, i32) -> i32
    "spirv.ReturnValue"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, i32) -> i32, sym_name = "clamp_ulessthanequal"}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):
    %0 = "spirv.ULessThanEqual"(%arg0, %arg1) : (i32, i32) -> i1
    %1 = "spirv.Select"(%0, %arg1, %arg0) : (i1, i32, i32) -> i32
    %2 = "spirv.ULessThanEqual"(%arg2, %arg0) : (i32, i32) -> i1
    %3 = "spirv.Select"(%2, %arg2, %1) : (i1, i32, i32) -> i32
    "spirv.ReturnValue"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

