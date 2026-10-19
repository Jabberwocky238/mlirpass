module {
  func.func @absf(%arg0: f32, %arg1: f64) {
    %0 = emitc.call_opaque "fabsf"(%arg0) : (f32) -> f32
    %1 = emitc.call_opaque "fabs"(%arg1) : (f64) -> f64
    return
  }
  func.func @floor(%arg0: f32, %arg1: f64) {
    %0 = emitc.call_opaque "floorf"(%arg0) : (f32) -> f32
    %1 = emitc.call_opaque "floor"(%arg1) : (f64) -> f64
    return
  }
  func.func @sin(%arg0: f32, %arg1: f64) {
    %0 = emitc.call_opaque "sinf"(%arg0) : (f32) -> f32
    %1 = emitc.call_opaque "sin"(%arg1) : (f64) -> f64
    return
  }
  func.func @cos(%arg0: f32, %arg1: f64) {
    %0 = emitc.call_opaque "cosf"(%arg0) : (f32) -> f32
    %1 = emitc.call_opaque "cos"(%arg1) : (f64) -> f64
    return
  }
  func.func @asin(%arg0: f32, %arg1: f64) {
    %0 = emitc.call_opaque "asinf"(%arg0) : (f32) -> f32
    %1 = emitc.call_opaque "asin"(%arg1) : (f64) -> f64
    return
  }
  func.func @acos(%arg0: f32, %arg1: f64) {
    %0 = emitc.call_opaque "acosf"(%arg0) : (f32) -> f32
    %1 = emitc.call_opaque "acos"(%arg1) : (f64) -> f64
    return
  }
  func.func @atan2(%arg0: f32, %arg1: f32, %arg2: f64, %arg3: f64) {
    %0 = emitc.call_opaque "atan2f"(%arg0, %arg1) : (f32, f32) -> f32
    %1 = emitc.call_opaque "atan2"(%arg2, %arg3) : (f64, f64) -> f64
    return
  }
  func.func @ceil(%arg0: f32, %arg1: f64) {
    %0 = emitc.call_opaque "ceilf"(%arg0) : (f32) -> f32
    %1 = emitc.call_opaque "ceil"(%arg1) : (f64) -> f64
    return
  }
  func.func @exp(%arg0: f32, %arg1: f64) {
    %0 = emitc.call_opaque "expf"(%arg0) : (f32) -> f32
    %1 = emitc.call_opaque "exp"(%arg1) : (f64) -> f64
    return
  }
  func.func @powf(%arg0: f32, %arg1: f32, %arg2: f64, %arg3: f64) {
    %0 = emitc.call_opaque "powf"(%arg0, %arg1) : (f32, f32) -> f32
    %1 = emitc.call_opaque "pow"(%arg2, %arg3) : (f64, f64) -> f64
    return
  }
  func.func @round(%arg0: f32, %arg1: f64) {
    %0 = emitc.call_opaque "roundf"(%arg0) : (f32) -> f32
    %1 = emitc.call_opaque "round"(%arg1) : (f64) -> f64
    return
  }
}

