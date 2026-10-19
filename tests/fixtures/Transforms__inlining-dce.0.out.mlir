module {
  func.func @dead_function_b() {
    return
  }
  func.func @live_function() {
    return
  }
  func.func @live_function_b() {
    return
  }
  func.func @live_function_c() {
    return
  }
  func.func private @live_function_d() {
    return
  }
  "live.user"() {use = @live_function_d} : () -> ()
}

// -----
module {
  func.func @live_function_e() {
    return
  }
}

