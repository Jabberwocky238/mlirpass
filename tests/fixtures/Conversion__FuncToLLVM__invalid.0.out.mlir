module {
  func.func private @unsupported_signature() -> tensor<10xi32>
}

// -----
module {
  func.func private @partially_supported_signature() -> (vector<10xi32>, tensor<10xi32>)
}

