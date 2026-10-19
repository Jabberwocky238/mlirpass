"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "switch_no_result"}> ({
  ^bb0(%arg2: index):
    "scf.index_switch"(%arg2) <{cases = array<i64: 2, 5>}> ({
      %13 = "arith.constant"() <{value = 30 : i32}> : () -> i32
      "scf.yield"() : () -> ()
    }, {
      %12 = "arith.constant"() <{value = 10 : i32}> : () -> i32
      "scf.yield"() : () -> ()
    }, {
      %11 = "arith.constant"() <{value = 20 : i32}> : () -> i32
      "scf.yield"() : () -> ()
    }) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "switch_one_result"}> ({
  ^bb0(%arg1: index):
    %7 = "scf.index_switch"(%arg1) <{cases = array<i64: 2, 5>}> ({
      %10 = "arith.constant"() <{value = 30 : i32}> : () -> i32
      "scf.yield"(%10) : (i32) -> ()
    }, {
      %9 = "arith.constant"() <{value = 10 : i32}> : () -> i32
      "scf.yield"(%9) : (i32) -> ()
    }, {
      %8 = "arith.constant"() <{value = 20 : i32}> : () -> i32
      "scf.yield"(%8) : (i32) -> ()
    }) : (index) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (i32, f32), sym_name = "switch_two_results"}> ({
  ^bb0(%arg0: index):
    %0:2 = "scf.index_switch"(%arg0) <{cases = array<i64: 2, 5>}> ({
      %5 = "arith.constant"() <{value = 30 : i32}> : () -> i32
      %6 = "arith.constant"() <{value = 3.600000e+00 : f32}> : () -> f32
      "scf.yield"(%5, %6) : (i32, f32) -> ()
    }, {
      %3 = "arith.constant"() <{value = 10 : i32}> : () -> i32
      %4 = "arith.constant"() <{value = 1.200000e+00 : f32}> : () -> f32
      "scf.yield"(%3, %4) : (i32, f32) -> ()
    }, {
      %1 = "arith.constant"() <{value = 20 : i32}> : () -> i32
      %2 = "arith.constant"() <{value = 2.400000e+00 : f32}> : () -> f32
      "scf.yield"(%1, %2) : (i32, f32) -> ()
    }) : (index) -> (i32, f32)
    "func.return"(%0#0, %0#1) : (i32, f32) -> ()
  }) : () -> ()
}) : () -> ()

