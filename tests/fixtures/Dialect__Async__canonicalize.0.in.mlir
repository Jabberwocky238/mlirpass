"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "empty_execute"}> ({
    %0 = "async.execute"() <{operandSegmentSizes = array<i32: 0, 0>}> ({
      "async.yield"() : () -> ()
    }) : () -> !async.token
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

