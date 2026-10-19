"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (), sym_name = "default_insertion_position"}> ({
  ^bb0(%arg0: i1):
    %1 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    "scf.if"(%arg0) ({
      "foo.yield"(%1) : (i32) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "custom_insertion_position"}> ({
    "test.one_region_op"() ({
      %0 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      "foo.yield"(%0) : (i32) -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

