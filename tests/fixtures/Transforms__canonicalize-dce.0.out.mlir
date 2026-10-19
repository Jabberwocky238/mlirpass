module {
  func.func @f(%arg0: f32) {
    return
  }
}

// -----
module {
  func.func @f(%arg0: f32) {
    "test.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    return
  }
}

// -----
module {
  func.func @f(%arg0: f32) {
    cf.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    cf.br ^bb1
  }
}

// -----
module {
  func.func @f(%arg0: f32) {
    cf.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    cf.br ^bb1
  }
}

// -----
module {
  func.func @f(%arg0: f32, %arg1: i1) {
    return
  }
}

// -----
module {
  func.func @f(%arg0: f32) {
    "test.region"() ({
    ^bb0:
    }) : () -> ()
    return
  }
}

// -----
module {
  func.func @f(%arg0: f32) -> f32 {
    %0 = arith.addf %arg0, %arg0 : f32
    return %0 : f32
  }
}

// -----
module {
  func.func @f(%arg0: f32) {
    "foo.print"(%arg0) : (f32) -> ()
    return
  }
}

// -----
module {
  func.func @f(%arg0: f32) {
    "foo.has_region"() ({
      "foo.return"() : () -> ()
    }) : () -> ()
    return
  }
}

// -----
module {
  func.func @f(%arg0: tensor<1xf32>, %arg1: tensor<2xf32>, %arg2: tensor<3xf32>, %arg3: tensor<4xf32>, %arg4: tensor<5xf32>) {
    "test.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    "foo.print"(%arg1) : (tensor<2xf32>) -> ()
    "foo.print"(%arg3) : (tensor<4xf32>) -> ()
    return
  }
}

// -----
module {
  func.func @f() {
    test.graph_region {
      "test.terminator"() : () -> ()
    }
    return
  }
}

// -----
module {
  func.func @f() {
    return
  }
}

