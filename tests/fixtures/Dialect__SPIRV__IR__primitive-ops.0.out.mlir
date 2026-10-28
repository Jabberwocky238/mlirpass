module {
  func.func @emit_vertex() {
    spirv.EmitVertex
    spirv.Return
  }
  func.func @end_primitive() {
    spirv.EndPrimitive
    spirv.Return
  }
}

