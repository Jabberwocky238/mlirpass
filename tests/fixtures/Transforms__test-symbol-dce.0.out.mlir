module attributes {test.simple} {
  func.func private @live_private_function()
  func.func nested @live_nested_function()
  func.func @public_function() {
    "foo.return"() {uses = [@live_private_function, @live_nested_function]} : () -> ()
  }
}

// -----
module attributes {test.nested} {
  module @public_module {
    func.func private @private_function()
    func.func nested @nested_function() {
      "foo.return"() {uses = [@private_function]} : () -> ()
    }
  }
  "live.user"() {uses = [@public_module::@nested_function]} : () -> ()
}

// -----
module attributes {test.no_dce_non_hidden_parent} {
  module @public_module {
  }
  module @nested_module attributes {sym_visibility = "nested"} {
  }
  module @private_module attributes {sym_visibility = "private"} {
  }
  "live.user"() {uses = [@nested_module, @private_module]} : () -> ()
}

// -----
// -----
module {
  func.func private @live_private_function()
  "live.user"() {uses = [@live_private_function]} : () -> ()
  "live.user"() {uses = [@unknown_symbol]} : () -> ()
}

// -----
module attributes {test.nested_nosymboltable_region} {
  "test.one_region_op"() ({
    "test.symbol_scope"() ({
      func.func nested @nfunction() {
        return
      }
      func.call @nfunction() : () -> ()
      "test.finish"() : () -> ()
    }) : () -> ()
    "test.finish"() : () -> ()
  }) : () -> ()
}

// -----
module attributes {test.nested_nosymboltable_region_notcalled} {
  "test.one_region_op"() ({
    builtin.module {
      func.func @main() {
        return
      }
    }
    "test.finish"() : () -> ()
  }) : () -> ()
}

