"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "check_poison"}> ({
    %0 = "llvm.mlir.poison"() : () -> i64
    %1 = "llvm.mlir.poison"() : () -> i16
    %2 = "llvm.mlir.poison"() : () -> f64
    %3 = "llvm.mlir.poison"() : () -> !llvm.ptr
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "check_unrechable"}> ({
    "llvm.unreachable"() : () -> ()
  }) : () -> ()
}) : () -> ()

