"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (struct<(f32, f32)>)>, linkage = #llvm.linkage<external>, sym_name = "complex_abs", visibility_ = 0 : i64}> ({
  ^bb0(%arg4: !llvm.struct<(f32, f32)>):
    %14 = "llvm.extractvalue"(%arg4) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %15 = "llvm.extractvalue"(%arg4) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %16 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %17 = "llvm.intr.fabs"(%14) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %18 = "llvm.intr.fabs"(%15) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %19 = "llvm.intr.maximum"(%17, %18) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %20 = "llvm.intr.minimum"(%17, %18) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %21 = "llvm.fdiv"(%20, %19) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %22 = "llvm.fmul"(%21, %21) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %23 = "llvm.fadd"(%22, %16) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %24 = "llvm.intr.sqrt"(%23) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %25 = "llvm.fmul"(%19, %24) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %26 = "llvm.fcmp"(%25, %25) <{fastmathFlags = #llvm.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %27 = "llvm.select"(%26, %20, %25) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, f32, f32) -> f32
    "llvm.return"(%27) : (f32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 (struct<(f32, f32)>, struct<(f32, f32)>)>, linkage = #llvm.linkage<external>, sym_name = "complex_eq", visibility_ = 0 : i64}> ({
  ^bb0(%arg2: !llvm.struct<(f32, f32)>, %arg3: !llvm.struct<(f32, f32)>):
    %7 = "llvm.extractvalue"(%arg2) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %8 = "llvm.extractvalue"(%arg2) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %9 = "llvm.extractvalue"(%arg3) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %10 = "llvm.extractvalue"(%arg3) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %11 = "llvm.fcmp"(%7, %9) <{fastmathFlags = #llvm.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %12 = "llvm.fcmp"(%8, %10) <{fastmathFlags = #llvm.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %13 = "llvm.and"(%11, %12) : (i1, i1) -> i1
    "llvm.return"(%13) : (i1) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 (struct<(f32, f32)>, struct<(f32, f32)>)>, linkage = #llvm.linkage<external>, sym_name = "complex_neq", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.struct<(f32, f32)>, %arg1: !llvm.struct<(f32, f32)>):
    %0 = "llvm.extractvalue"(%arg0) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %1 = "llvm.extractvalue"(%arg0) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %2 = "llvm.extractvalue"(%arg1) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %3 = "llvm.extractvalue"(%arg1) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %4 = "llvm.fcmp"(%0, %2) <{fastmathFlags = #llvm.fastmath<none>, predicate = 13 : i64}> : (f32, f32) -> i1
    %5 = "llvm.fcmp"(%1, %3) <{fastmathFlags = #llvm.fastmath<none>, predicate = 13 : i64}> : (f32, f32) -> i1
    %6 = "llvm.or"(%4, %5) : (i1, i1) -> i1
    "llvm.return"(%6) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

