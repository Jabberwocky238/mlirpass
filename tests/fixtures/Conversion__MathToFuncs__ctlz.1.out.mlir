module {
  func.func @main(%arg0: i32) {
    %0 = math.ctlz %arg0 : i32
    return
  }
}

// -----
module {
  func.func @main(%arg0: i8) {
    %0 = math.ctlz %arg0 : i8
    return
  }
}

// -----
module {
  func.func @ctlz_index(%arg0: index) {
    %0 = math.ctlz %arg0 : index
    return
  }
}

