"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f32)> (struct<(f32, f32)>, struct<(f32, f32)>)>, linkage = #llvm.linkage<external>, sym_name = "complex_div", visibility_ = 0 : i64}> ({
  ^bb0(%arg3: !llvm.struct<(f32, f32)>, %arg4: !llvm.struct<(f32, f32)>):
    %19 = "llvm.extractvalue"(%arg3) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %20 = "llvm.extractvalue"(%arg3) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %21 = "llvm.extractvalue"(%arg4) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %22 = "llvm.extractvalue"(%arg4) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %23 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f32)>
    %24 = "llvm.fmul"(%21, %21) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %25 = "llvm.fmul"(%22, %22) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %26 = "llvm.fadd"(%24, %25) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %27 = "llvm.fmul"(%19, %21) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %28 = "llvm.fmul"(%20, %22) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %29 = "llvm.fadd"(%27, %28) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %30 = "llvm.fmul"(%20, %21) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %31 = "llvm.fmul"(%19, %22) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %32 = "llvm.fsub"(%30, %31) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %33 = "llvm.fdiv"(%29, %26) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %34 = "llvm.fdiv"(%32, %26) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %35 = "llvm.insertvalue"(%23, %33) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    %36 = "llvm.insertvalue"(%35, %34) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    "llvm.return"(%36) : (!llvm.struct<(f32, f32)>) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, f32)> (struct<(f32, f32)>, struct<(f32, f32)>)>, linkage = #llvm.linkage<external>, sym_name = "complex_mul", visibility_ = 0 : i64}> ({
  ^bb0(%arg1: !llvm.struct<(f32, f32)>, %arg2: !llvm.struct<(f32, f32)>):
    %6 = "llvm.extractvalue"(%arg1) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %7 = "llvm.extractvalue"(%arg1) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %8 = "llvm.extractvalue"(%arg2) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %9 = "llvm.extractvalue"(%arg2) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %10 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f32)>
    %11 = "llvm.fmul"(%8, %6) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %12 = "llvm.fmul"(%9, %7) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %13 = "llvm.fsub"(%11, %12) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %14 = "llvm.fmul"(%7, %8) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %15 = "llvm.fmul"(%6, %9) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %16 = "llvm.fadd"(%14, %15) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %17 = "llvm.insertvalue"(%10, %13) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    %18 = "llvm.insertvalue"(%17, %16) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    "llvm.return"(%18) : (!llvm.struct<(f32, f32)>) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (struct<(f32, f32)>)>, linkage = #llvm.linkage<external>, sym_name = "complex_abs", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.struct<(f32, f32)>):
    %0 = "llvm.extractvalue"(%arg0) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %1 = "llvm.extractvalue"(%arg0) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %2 = "llvm.fmul"(%0, %0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %3 = "llvm.fmul"(%1, %1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %4 = "llvm.fadd"(%2, %3) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %5 = "llvm.intr.sqrt"(%4) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    "llvm.return"(%5) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

