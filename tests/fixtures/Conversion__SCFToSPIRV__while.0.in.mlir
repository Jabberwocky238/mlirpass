"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "while_loop1"}> ({
  ^bb0(%arg9: i32, %arg10: i32):
    %12 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %13 = "scf.while"(%arg9) ({
    ^bb0(%arg12: i32):
      %15 = "arith.cmpi"(%arg12, %arg10) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "scf.condition"(%15, %arg12) : (i1, i32) -> ()
    }, {
    ^bb0(%arg11: i32):
      %14 = "arith.muli"(%arg11, %12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "scf.yield"(%14) : (i32) -> ()
    }) : (i32) -> i32
    "func.return"(%13) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> i64, sym_name = "while_loop2"}> ({
  ^bb0(%arg6: f32):
    %8 = "scf.while"(%arg6) ({
    ^bb0(%arg8: f32):
      %10 = "foo.shared_compute"(%arg8) : (f32) -> i64
      %11 = "foo.evaluate_condition"(%arg8, %10) : (f32, i64) -> i1
      "scf.condition"(%11, %10) : (i1, i64) -> ()
    }, {
    ^bb0(%arg7: i64):
      %9 = "foo.payload"(%arg7) : (i64) -> f32
      "scf.yield"(%9) : (f32) -> ()
    }) : (f32) -> i64
    "func.return"(%8) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> i64, sym_name = "while_loop_before_typeconv"}> ({
  ^bb0(%arg3: index):
    %4 = "scf.while"(%arg3) ({
    ^bb0(%arg5: index):
      %6 = "foo.shared_compute"(%arg5) : (index) -> i64
      %7 = "foo.evaluate_condition"(%arg5, %6) : (index, i64) -> i1
      "scf.condition"(%7, %6) : (i1, i64) -> ()
    }, {
    ^bb0(%arg4: i64):
      %5 = "foo.payload"(%arg4) : (i64) -> index
      "scf.yield"(%5) : (index) -> ()
    }) : (index) -> i64
    "func.return"(%4) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> index, sym_name = "while_loop_after_typeconv"}> ({
  ^bb0(%arg0: f32):
    %0 = "scf.while"(%arg0) ({
    ^bb0(%arg2: f32):
      %2 = "foo.shared_compute"(%arg2) : (f32) -> index
      %3 = "foo.evaluate_condition"(%arg2, %2) : (f32, index) -> i1
      "scf.condition"(%3, %2) : (i1, index) -> ()
    }, {
    ^bb0(%arg1: index):
      %1 = "foo.payload"(%arg1) : (index) -> f32
      "scf.yield"(%1) : (f32) -> ()
    }) : (f32) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

