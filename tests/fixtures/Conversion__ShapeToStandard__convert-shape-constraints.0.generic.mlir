"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>, tensor<?xindex>) -> !shape.witness, sym_name = "cstr_broadcastable"}> ({
  ^bb0(%arg3: tensor<?xindex>, %arg4: tensor<?xindex>):
    %3 = "shape.const_witness"() <{passing = true}> : () -> !shape.witness
    %4 = "shape.is_broadcastable"(%arg3, %arg4) : (tensor<?xindex>, tensor<?xindex>) -> i1
    "cf.assert"(%4) <{msg = "required broadcastable shapes"}> : (i1) -> ()
    "func.return"(%3) : (!shape.witness) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?xindex>, tensor<?xindex>) -> !shape.witness, sym_name = "cstr_eq"}> ({
  ^bb0(%arg1: tensor<?xindex>, %arg2: tensor<?xindex>):
    %1 = "shape.const_witness"() <{passing = true}> : () -> !shape.witness
    %2 = "shape.shape_eq"(%arg1, %arg2) : (tensor<?xindex>, tensor<?xindex>) -> i1
    "cf.assert"(%2) <{msg = "required equal shapes"}> : (i1) -> ()
    "func.return"(%1) : (!shape.witness) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> !shape.witness, sym_name = "cstr_require"}> ({
  ^bb0(%arg0: i1):
    %0 = "shape.const_witness"() <{passing = true}> : () -> !shape.witness
    "cf.assert"(%arg0) <{msg = "msg"}> : (i1) -> ()
    "func.return"(%0) : (!shape.witness) -> ()
  }) : () -> ()
}) : () -> ()

