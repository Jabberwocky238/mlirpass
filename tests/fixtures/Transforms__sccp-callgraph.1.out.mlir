module {
  func.func private @private(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
  func.func @simple_private() -> i32 {
    %c1_i32 = arith.constant 1 : i32
    %0 = call @private(%c1_i32) : (i32) -> i32
    return %0 : i32
  }
}

// -----
module {
  func.func nested @nested(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
  func.func @simple_nested() -> i32 {
    %c1_i32 = arith.constant 1 : i32
    %0 = call @nested(%c1_i32) : (i32) -> i32
    return %0 : i32
  }
}

// -----
module {
  module @nested_module attributes {sym_visibility = "public"} {
    func.func nested @nested(%arg0: i32) -> (i32, i32) {
      %c1_i32 = arith.constant 1 : i32
      return %c1_i32, %arg0 : i32, i32
    }
    func.func @nested_not_all_uses_visible() -> (i32, i32) {
      %c1_i32 = arith.constant 1 : i32
      %0:2 = call @nested(%c1_i32) : (i32) -> (i32, i32)
      return %c1_i32, %0#1 : i32, i32
    }
  }
}

// -----
module {
  func.func @public(%arg0: i32) -> (i32, i32) {
    %c1_i32 = arith.constant 1 : i32
    return %c1_i32, %arg0 : i32, i32
  }
  func.func @simple_public() -> (i32, i32) {
    %c1_i32 = arith.constant 1 : i32
    %0:2 = call @public(%c1_i32) : (i32) -> (i32, i32)
    return %0#0, %0#1 : i32, i32
  }
}

// -----
module {
  func.func private @callable(%arg0: i32) -> (i32, i32) {
    %c1_i32 = arith.constant 1 : i32
    return %c1_i32, %arg0 : i32, i32
  }
  func.func @non_call_users() -> (i32, i32) {
    %c1_i32 = arith.constant 1 : i32
    %0:2 = call @callable(%c1_i32) : (i32) -> (i32, i32)
    return %0#0, %0#1 : i32, i32
  }
  "live.user"() {uses = [@callable]} : () -> ()
}

// -----
module {
  func.func private @callable(%arg0: i32) -> i32 {
    "unknown.return"(%arg0) : (i32) -> ()
  }
  func.func @unknown_terminator() -> i32 {
    %c1_i32 = arith.constant 1 : i32
    %0 = call @callable(%c1_i32) : (i32) -> i32
    return %0 : i32
  }
}

// -----
module {
  func.func private @callable(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
  func.func @conflicting_constant() -> (i32, i32) {
    %c1_i32 = arith.constant 1 : i32
    %c2_i32 = arith.constant 2 : i32
    %0 = call @callable(%c1_i32) : (i32) -> i32
    %1 = call @callable(%c2_i32) : (i32) -> i32
    return %0, %1 : i32, i32
  }
}

// -----
module {
  func.func private @callable(%arg0: i32) -> i32 {
    "unknown.return"(%arg0) : (i32) -> ()
  }
  func.func @conflicting_constant(%arg0: i32) -> (i32, i32) {
    %c1_i32 = arith.constant 1 : i32
    %0 = call @callable(%c1_i32) : (i32) -> i32
    %1 = call @callable(%arg0) : (i32) -> i32
    return %0, %1 : i32, i32
  }
}

// -----
module {
  func.func private @complex_inner_if(%arg0: i32) -> i32 {
    %c20_i32 = arith.constant 20 : i32
    %0 = arith.cmpi ult, %arg0, %c20_i32 : i32
    cf.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %c1_i32 = arith.constant 1 : i32
    return %c1_i32 : i32
  ^bb2:  // pred: ^bb0
    %c1_i32_0 = arith.constant 1 : i32
    %1 = arith.addi %arg0, %c1_i32_0 : i32
    return %1 : i32
  }
  func.func private @complex_cond() -> i1
  func.func private @complex_callee(%arg0: i32) -> i32 {
    %0 = call @complex_cond() : () -> i1
    cf.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    return %arg0 : i32
  ^bb2:  // pred: ^bb0
    %1 = call @complex_inner_if(%arg0) : (i32) -> i32
    %2 = call @complex_callee(%1) : (i32) -> i32
    return %2 : i32
  }
  func.func @complex_caller(%arg0: i32) -> i32 {
    %c1_i32 = arith.constant 1 : i32
    %0 = call @complex_callee(%c1_i32) : (i32) -> i32
    return %0 : i32
  }
}

// -----
module {
  func.func @non_symbol_defining_callable() -> i32 {
    %0 = "test.functional_region_op"() ({
      %c1_i32 = arith.constant 1 : i32
      "test.return"(%c1_i32) : (i32) -> ()
    }) : () -> (() -> i32)
    %1 = call_indirect %0() : () -> i32
    return %1 : i32
  }
}

// -----
module {
  func.func private @unreferenced_private_function() -> i32 {
    %true = arith.constant true
    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    %0 = arith.select %true, %c0_i32, %c1_i32 : i32
    return %0 : i32
  }
}

// -----
module {
  func.func private @foo() -> index {
    %c10 = arith.constant 10 : index
    return %c10 : index
  }
  func.func @bar(%arg0: index) -> index {
    %c0 = arith.constant 0 : index
    %c420 = arith.constant 420 : index
    %0 = arith.cmpi eq, %arg0, %c0 : index
    cf.cond_br %0, ^bb1(%c420 : index), ^bb2
  ^bb1(%1: index):  // 2 preds: ^bb0, ^bb2
    return %1 : index
  ^bb2:  // pred: ^bb0
    %2 = call @foo() : () -> index
    cf.br ^bb1(%2 : index)
  }
}

