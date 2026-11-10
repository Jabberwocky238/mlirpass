module {
  func.func @no_fold_cast_to_f32(%arg0: i32) {
    %0 = emitc.cast %arg0 : i32 to f32
    return
  }
  func.func @fold_cast_to_i64(%arg0: i32) {
    return
  }
}

