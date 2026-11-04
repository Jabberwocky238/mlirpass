module {
  func.func @cstr_broadcastable(%arg0: tensor<?xindex>, %arg1: tensor<?xindex>) -> !shape.witness {
    %0 = shape.const_witness true
    %1 = shape.is_broadcastable %arg0, %arg1 : tensor<?xindex>, tensor<?xindex>
    cf.assert %1, "required broadcastable shapes"
    return %0 : !shape.witness
  }
  func.func @cstr_eq(%arg0: tensor<?xindex>, %arg1: tensor<?xindex>) -> !shape.witness {
    %0 = shape.const_witness true
    %1 = shape.shape_eq %arg0, %arg1 : tensor<?xindex>, tensor<?xindex>
    cf.assert %1, "required equal shapes"
    return %0 : !shape.witness
  }
  func.func @cstr_require(%arg0: i1) -> !shape.witness {
    %0 = shape.const_witness true
    cf.assert %arg0, "msg"
    return %0 : !shape.witness
  }
}

