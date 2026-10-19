#map = affine_map<() -> (0)>
#map1 = affine_map<() -> (1)>
#map2 = affine_map<()[s0] -> (s0)>
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "simple"}> ({
  ^bb0(%arg35: i32):
    %45 = "arith.constant"() <{value = true}> : () -> i1
    %46 = "scf.if"(%45) ({
      %47 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      "scf.yield"(%47) : (i32) -> ()
    }, {
      "scf.yield"(%arg35) : (i32) -> ()
    }) : (i1) -> i32
    "func.return"(%46) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i32, sym_name = "simple_both_same"}> ({
  ^bb0(%arg34: i1):
    %42 = "scf.if"(%arg34) ({
      %44 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      "scf.yield"(%44) : (i32) -> ()
    }, {
      %43 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      "scf.yield"(%43) : (i32) -> ()
    }) : (i1) -> i32
    "func.return"(%42) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i32) -> i32, sym_name = "overdefined_unknown_condition"}> ({
  ^bb0(%arg32: i1, %arg33: i32):
    %40 = "scf.if"(%arg32) ({
      %41 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      "scf.yield"(%41) : (i32) -> ()
    }, {
      "scf.yield"(%arg33) : (i32) -> ()
    }) : (i1) -> i32
    "func.return"(%40) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i32, sym_name = "overdefined_different_constants"}> ({
  ^bb0(%arg31: i1):
    %37 = "scf.if"(%arg31) ({
      %39 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      "scf.yield"(%39) : (i32) -> ()
    }, {
      %38 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      "scf.yield"(%38) : (i32) -> ()
    }) : (i1) -> i32
    "func.return"(%37) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> i32, sym_name = "simple_loop"}> ({
  ^bb0(%arg26: index, %arg27: index, %arg28: index):
    %34 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %35 = "scf.for"(%arg26, %arg27, %arg28, %34) ({
    ^bb0(%arg29: index, %arg30: i32):
      %36 = "arith.addi"(%arg30, %arg30) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "scf.yield"(%36) : (i32) -> ()
    }) : (index, index, index, i32) -> i32
    "func.return"(%35) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> i32, sym_name = "loop_overdefined"}> ({
  ^bb0(%arg21: index, %arg22: index, %arg23: index):
    %31 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %32 = "scf.for"(%arg21, %arg22, %arg23, %31) ({
    ^bb0(%arg24: index, %arg25: i32):
      %33 = "arith.addi"(%arg25, %arg25) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "scf.yield"(%33) : (i32) -> ()
    }) : (index, index, index, i32) -> i32
    "func.return"(%32) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> i32, sym_name = "loop_inner_control_flow"}> ({
  ^bb0(%arg16: index, %arg17: index, %arg18: index):
    %24 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %25 = "scf.for"(%arg16, %arg17, %arg18, %24) ({
    ^bb0(%arg19: index, %arg20: i32):
      %26 = "arith.constant"() <{value = 20 : i32}> : () -> i32
      %27 = "arith.cmpi"(%arg20, %26) <{predicate = 6 : i64}> : (i32, i32) -> i1
      %28 = "scf.if"(%27) ({
        %30 = "arith.constant"() <{value = 1 : i32}> : () -> i32
        "scf.yield"(%30) : (i32) -> ()
      }, {
        %29 = "arith.addi"(%arg20, %24) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "scf.yield"(%29) : (i32) -> ()
      }) : (i1) -> i32
      "scf.yield"(%28) : (i32) -> ()
    }) : (index, index, index, i32) -> i32
    "func.return"(%25) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "loop_region_branch_terminator_op"}> ({
  ^bb0(%arg13: i32):
    %21 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %22 = "scf.while"(%21) ({
    ^bb0(%arg15: i32):
      %23 = "arith.cmpi"(%arg13, %arg15) <{predicate = 4 : i64}> : (i32, i32) -> i1
      "scf.condition"(%23, %arg15) : (i1, i32) -> ()
    }, {
    ^bb0(%arg14: i32):
      "scf.yield"(%arg14) : (i32) -> ()
    }) : (i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "affine_loop_one_iter"}> ({
    %17 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %18 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %19 = "affine.for"(%17) <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 1>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg11: index, %arg12: i32):
      %20 = "arith.addi"(%arg12, %18) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "affine.yield"(%20) : (i32) -> ()
    }) : (i32) -> i32
    "func.return"(%19) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "affine_loop_zero_iter"}> ({
    %14 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %15 = "affine.for"(%14) <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 1>, step = 1 : index, upperBoundMap = #map}> ({
    ^bb0(%arg9: index, %arg10: i32):
      %16 = "arith.addi"(%arg10, %arg10) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "affine.yield"(%16) : (i32) -> ()
    }) : (i32) -> i32
    "func.return"(%15) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> i32, sym_name = "affine_loop_unknown_trip_count"}> ({
  ^bb0(%arg6: index):
    %11 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %12 = "affine.for"(%arg6, %11) <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 1, 1>, step = 1 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg7: index, %arg8: i32):
      %13 = "arith.addi"(%arg8, %arg8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "affine.yield"(%13) : (i32) -> ()
    }) : (index, i32) -> i32
    "func.return"(%12) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> index, sym_name = "while_loop_different_arg_count"}> ({
    %6 = "arith.constant"() <{value = 0 : index}> : () -> index
    %7 = "arith.constant"() <{value = 1 : index}> : () -> index
    %8 = "scf.while"(%6, %7) ({
    ^bb0(%arg4: index, %arg5: index):
      %10 = "arith.cmpi"(%arg4, %7) <{predicate = 2 : i64}> : (index, index) -> i1
      "scf.condition"(%10, %arg5) : (i1, index) -> ()
    }, {
    ^bb0(%arg3: index):
      %9 = "arith.muli"(%arg3, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%6, %9) : (index, index) -> ()
    }) : (index, index) -> index
    "func.return"(%8) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "while_loop_false_condition"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.muli"(%arg0, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %3 = "scf.while"(%2) ({
    ^bb0(%arg2: index):
      %5 = "arith.cmpi"(%arg2, %0) <{predicate = 2 : i64}> : (index, index) -> i1
      "scf.condition"(%5, %arg2) : (i1, index) -> ()
    }, {
    ^bb0(%arg1: index):
      %4 = "arith.addi"(%arg1, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%4) : (index) -> ()
    }) : (index) -> index
    "func.return"(%3) : (index) -> ()
  }) : () -> ()
}) : () -> ()

