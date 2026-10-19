module {
  emitc.func @int(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
  emitc.func @index(%arg0: !emitc.size_t) -> !emitc.size_t {
    return %arg0 : !emitc.size_t
  }
}

