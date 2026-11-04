"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>, tensor<?xindex>) -> !shape.witness, sym_name = "cstr_broadcastable"}> ({
  ^bb0(%arg3: tensor<?xindex>, %arg4: tensor<?xindex>):
    %2 = "shape.cstr_broadcastable"(%arg3, %arg4) : (tensor<?xindex>, tensor<?xindex>) -> !shape.witness
    "func.return"(%2) : (!shape.witness) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?xindex>, tensor<?xindex>) -> !shape.witness, sym_name = "cstr_eq"}> ({
  ^bb0(%arg1: tensor<?xindex>, %arg2: tensor<?xindex>):
    %1 = "shape.cstr_eq"(%arg1, %arg2) : (tensor<?xindex>, tensor<?xindex>) -> !shape.witness
    "func.return"(%1) : (!shape.witness) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> !shape.witness, sym_name = "cstr_require"}> ({
  ^bb0(%arg0: i1):
    %0 = "shape.cstr_require"(%arg0) <{msg = "msg"}> : (i1) -> !shape.witness
    "func.return"(%0) : (!shape.witness) -> ()
  }) : () -> ()
}) : () -> ()

