"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (), sym_name = "default_insertion_position"}> ({
  ^bb0(%arg0: i1):
    "scf.if"(%arg0) ({
      %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %3 = "arith.addi"(%2, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "foo.yield"(%3) : (i32) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "custom_insertion_position"}> ({
    "test.one_region_op"() ({
      %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %1 = "arith.addi"(%0, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "foo.yield"(%1) : (i32) -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

