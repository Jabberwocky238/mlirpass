module {
  func.func @clamp_fordlessthan(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = spirv.GL.FClamp %arg0, %arg1, %arg2 : f32
    spirv.ReturnValue %0 : f32
  }
}

// -----
module {
  func.func @clamp_fordlessthan(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = spirv.GL.FClamp %arg0, %arg1, %arg2 : f32
    spirv.ReturnValue %0 : f32
  }
}

// -----
module {
  func.func @clamp_fordlessthanequal(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = spirv.GL.FClamp %arg0, %arg1, %arg2 : f32
    spirv.ReturnValue %0 : f32
  }
}

// -----
module {
  func.func @clamp_fordlessthanequal(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = spirv.GL.FClamp %arg0, %arg1, %arg2 : f32
    spirv.ReturnValue %0 : f32
  }
}

// -----
module {
  func.func @clamp_slessthan(%arg0: si32, %arg1: si32, %arg2: si32) -> si32 {
    %0 = spirv.GL.SClamp %arg0, %arg1, %arg2 : si32
    spirv.ReturnValue %0 : si32
  }
}

// -----
module {
  func.func @clamp_slessthan(%arg0: si32, %arg1: si32, %arg2: si32) -> si32 {
    %0 = spirv.GL.SClamp %arg0, %arg1, %arg2 : si32
    spirv.ReturnValue %0 : si32
  }
}

// -----
module {
  func.func @clamp_slessthanequal(%arg0: si32, %arg1: si32, %arg2: si32) -> si32 {
    %0 = spirv.GL.SClamp %arg0, %arg1, %arg2 : si32
    spirv.ReturnValue %0 : si32
  }
}

// -----
module {
  func.func @clamp_slessthanequal(%arg0: si32, %arg1: si32, %arg2: si32) -> si32 {
    %0 = spirv.GL.SClamp %arg0, %arg1, %arg2 : si32
    spirv.ReturnValue %0 : si32
  }
}

// -----
module {
  func.func @clamp_ulessthan(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = spirv.GL.UClamp %arg0, %arg1, %arg2 : i32
    spirv.ReturnValue %0 : i32
  }
}

// -----
module {
  func.func @clamp_ulessthan(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = spirv.GL.UClamp %arg0, %arg1, %arg2 : i32
    spirv.ReturnValue %0 : i32
  }
}

// -----
module {
  func.func @clamp_ulessthanequal(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = spirv.GL.UClamp %arg0, %arg1, %arg2 : i32
    spirv.ReturnValue %0 : i32
  }
}

// -----
module {
  func.func @clamp_ulessthanequal(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = spirv.GL.UClamp %arg0, %arg1, %arg2 : i32
    spirv.ReturnValue %0 : i32
  }
}

