"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "main"}> ({
  ^bb0(%arg4: i32):
    %13 = "func.call"(%arg4) <{callee = @__mlir_math_ctlz_i32}> : (i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "__mlir_math_ctlz_i32", sym_visibility = "private"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "arith.cmpi"(%arg0, %1) <{predicate = 0 : i64}> : (i32, i32) -> i1
    %3 = "scf.if"(%2) ({
      "scf.yield"(%0) : (i32) -> ()
    }, {
      %4 = "arith.constant"() <{value = 1 : index}> : () -> index
      %5 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %6 = "arith.constant"() <{value = 32 : index}> : () -> index
      %7 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %8:2 = "scf.for"(%4, %6, %4, %arg0, %7) ({
      ^bb0(%arg1: index, %arg2: i32, %arg3: i32):
        %9 = "arith.cmpi"(%arg2, %1) <{predicate = 2 : i64}> : (i32, i32) -> i1
        %10:2 = "scf.if"(%9) ({
          "scf.yield"(%arg2, %arg3) : (i32, i32) -> ()
        }, {
          %11 = "arith.addi"(%arg3, %5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          %12 = "arith.shli"(%arg2, %5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          "scf.yield"(%12, %11) : (i32, i32) -> ()
        }) : (i1) -> (i32, i32)
        "scf.yield"(%10#0, %10#1) : (i32, i32) -> ()
      }) : (index, index, index, i32, i32) -> (i32, i32)
      "scf.yield"(%8#1) : (i32) -> ()
    }) : (i1) -> i32
    "func.return"(%3) : (i32) -> ()
  }) {llvm.linkage = #llvm.linkage<linkonce_odr>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i8) -> (), sym_name = "main"}> ({
  ^bb0(%arg4: i8):
    %13 = "func.call"(%arg4) <{callee = @__mlir_math_ctlz_i8}> : (i8) -> i8
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> i8, sym_name = "__mlir_math_ctlz_i8", sym_visibility = "private"}> ({
  ^bb0(%arg0: i8):
    %0 = "arith.constant"() <{value = 8 : i8}> : () -> i8
    %1 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %2 = "arith.cmpi"(%arg0, %1) <{predicate = 0 : i64}> : (i8, i8) -> i1
    %3 = "scf.if"(%2) ({
      "scf.yield"(%0) : (i8) -> ()
    }, {
      %4 = "arith.constant"() <{value = 1 : index}> : () -> index
      %5 = "arith.constant"() <{value = 1 : i8}> : () -> i8
      %6 = "arith.constant"() <{value = 8 : index}> : () -> index
      %7 = "arith.constant"() <{value = 0 : i8}> : () -> i8
      %8:2 = "scf.for"(%4, %6, %4, %arg0, %7) ({
      ^bb0(%arg1: index, %arg2: i8, %arg3: i8):
        %9 = "arith.cmpi"(%arg2, %1) <{predicate = 2 : i64}> : (i8, i8) -> i1
        %10:2 = "scf.if"(%9) ({
          "scf.yield"(%arg2, %arg3) : (i8, i8) -> ()
        }, {
          %11 = "arith.addi"(%arg3, %5) <{overflowFlags = #arith.overflow<none>}> : (i8, i8) -> i8
          %12 = "arith.shli"(%arg2, %5) <{overflowFlags = #arith.overflow<none>}> : (i8, i8) -> i8
          "scf.yield"(%12, %11) : (i8, i8) -> ()
        }) : (i1) -> (i8, i8)
        "scf.yield"(%10#0, %10#1) : (i8, i8) -> ()
      }) : (index, index, index, i8, i8) -> (i8, i8)
      "scf.yield"(%8#1) : (i8) -> ()
    }) : (i1) -> i8
    "func.return"(%3) : (i8) -> ()
  }) {llvm.linkage = #llvm.linkage<linkonce_odr>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "ctlz_index"}> ({
  ^bb0(%arg0: index):
    %0 = "math.ctlz"(%arg0) : (index) -> index
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

