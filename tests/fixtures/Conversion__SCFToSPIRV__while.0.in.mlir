"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "while_loop1"}> ({
  ^bb0(%arg13: i32, %arg14: i32):
    %16 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %17 = "scf.while"(%arg13) ({
    ^bb0(%arg16: i32):
      %19 = "arith.cmpi"(%arg16, %arg14) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "scf.condition"(%19, %arg16) : (i1, i32) -> ()
    }, {
    ^bb0(%arg15: i32):
      %18 = "arith.muli"(%arg15, %16) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "scf.yield"(%18) : (i32) -> ()
    }) : (i32) -> i32
    "func.return"(%17) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> i64, sym_name = "while_loop2"}> ({
  ^bb0(%arg10: f32):
    %12 = "scf.while"(%arg10) ({
    ^bb0(%arg12: f32):
      %14 = "foo.shared_compute"(%arg12) : (f32) -> i64
      %15 = "foo.evaluate_condition"(%arg12, %14) : (f32, i64) -> i1
      "scf.condition"(%15, %14) : (i1, i64) -> ()
    }, {
    ^bb0(%arg11: i64):
      %13 = "foo.payload"(%arg11) : (i64) -> f32
      "scf.yield"(%13) : (f32) -> ()
    }) : (f32) -> i64
    "func.return"(%12) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> i64, sym_name = "while_loop_before_typeconv"}> ({
  ^bb0(%arg7: index):
    %8 = "scf.while"(%arg7) ({
    ^bb0(%arg9: index):
      %10 = "foo.shared_compute"(%arg9) : (index) -> i64
      %11 = "foo.evaluate_condition"(%arg9, %10) : (index, i64) -> i1
      "scf.condition"(%11, %10) : (i1, i64) -> ()
    }, {
    ^bb0(%arg8: i64):
      %9 = "foo.payload"(%arg8) : (i64) -> index
      "scf.yield"(%9) : (index) -> ()
    }) : (index) -> i64
    "func.return"(%8) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> index, sym_name = "while_loop_after_typeconv"}> ({
  ^bb0(%arg4: f32):
    %4 = "scf.while"(%arg4) ({
    ^bb0(%arg6: f32):
      %6 = "foo.shared_compute"(%arg6) : (f32) -> index
      %7 = "foo.evaluate_condition"(%arg6, %6) : (f32, index) -> i1
      "scf.condition"(%7, %6) : (i1, index) -> ()
    }, {
    ^bb0(%arg5: index):
      %5 = "foo.payload"(%arg5) : (index) -> f32
      "scf.yield"(%5) : (f32) -> ()
    }) : (f32) -> index
    "func.return"(%4) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "while_loop_unroll"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %1 = "scf.while"(%arg0) ({
    ^bb0(%arg3: i32):
      %3 = "arith.cmpi"(%arg3, %arg1) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "scf.condition"(%3, %arg3) : (i1, i32) -> ()
    }, {
    ^bb0(%arg2: i32):
      %2 = "arith.muli"(%arg2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "scf.yield"(%2) : (i32) -> ()
    }) {spirv.loop_control = #spirv.loop_control<Unroll>} : (i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

