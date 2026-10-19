module {
  func.func @absf(%arg0: f32, %arg1: f64) {
    %0 = emitc.call_opaque "std::fabs"(%arg0) : (f32) -> f32
    %1 = emitc.call_opaque "std::fabs"(%arg1) : (f64) -> f64
    return
  }
  func.func @floor(%arg0: f32, %arg1: f64) {
    %0 = emitc.call_opaque "std::floor"(%arg0) : (f32) -> f32
    %1 = emitc.call_opaque "std::floor"(%arg1) : (f64) -> f64
    return
  }
  func.func @sin(%arg0: f32, %arg1: f64) {
    %0 = emitc.call_opaque "std::sin"(%arg0) : (f32) -> f32
    %1 = emitc.call_opaque "std::sin"(%arg1) : (f64) -> f64
    return
  }
  func.func @cos(%arg0: f32, %arg1: f64) {
    %0 = emitc.call_opaque "std::cos"(%arg0) : (f32) -> f32
    %1 = emitc.call_opaque "std::cos"(%arg1) : (f64) -> f64
    return
  }
  func.func @asin(%arg0: f32, %arg1: f64) {
    %0 = emitc.call_opaque "std::asin"(%arg0) : (f32) -> f32
    %1 = emitc.call_opaque "std::asin"(%arg1) : (f64) -> f64
    return
  }
  func.func @acos(%arg0: f32, %arg1: f64) {
    %0 = emitc.call_opaque "std::acos"(%arg0) : (f32) -> f32
    %1 = emitc.call_opaque "std::acos"(%arg1) : (f64) -> f64
    return
  }
  func.func @atan2(%arg0: f32, %arg1: f32, %arg2: f64, %arg3: f64) {
    %0 = emitc.call_opaque "std::atan2"(%arg0, %arg1) : (f32, f32) -> f32
    %1 = emitc.call_opaque "std::atan2"(%arg2, %arg3) : (f64, f64) -> f64
    return
  }
  func.func @ceil(%arg0: f32, %arg1: f64) {
    %0 = emitc.call_opaque "std::ceil"(%arg0) : (f32) -> f32
    %1 = emitc.call_opaque "std::ceil"(%arg1) : (f64) -> f64
    return
  }
  func.func @exp(%arg0: f32, %arg1: f64) {
    %0 = emitc.call_opaque "std::exp"(%arg0) : (f32) -> f32
    %1 = emitc.call_opaque "std::exp"(%arg1) : (f64) -> f64
    return
  }
  func.func @powf(%arg0: f32, %arg1: f32, %arg2: f64, %arg3: f64) {
    %0 = emitc.call_opaque "std::pow"(%arg0, %arg1) : (f32, f32) -> f32
    %1 = emitc.call_opaque "std::pow"(%arg2, %arg3) : (f64, f64) -> f64
    return
  }
  func.func @round(%arg0: f32, %arg1: f64) {
    %0 = emitc.call_opaque "std::round"(%arg0) : (f32) -> f32
    %1 = emitc.call_opaque "std::round"(%arg1) : (f64) -> f64
    return
  }
}

