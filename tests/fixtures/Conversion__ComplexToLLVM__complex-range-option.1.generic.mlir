"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_div"}> ({
  ^bb0(%arg2: complex<f32>, %arg3: complex<f32>):
    %21 = "builtin.unrealized_conversion_cast"(%arg3) : (complex<f32>) -> !llvm.struct<(f32, f32)>
    %22 = "builtin.unrealized_conversion_cast"(%arg2) : (complex<f32>) -> !llvm.struct<(f32, f32)>
    %23 = "llvm.extractvalue"(%22) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %24 = "llvm.extractvalue"(%22) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %25 = "llvm.extractvalue"(%21) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %26 = "llvm.extractvalue"(%21) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %27 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f32)>
    %28 = "llvm.fmul"(%25, %25) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %29 = "llvm.fmul"(%26, %26) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %30 = "llvm.fadd"(%28, %29) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %31 = "llvm.fmul"(%23, %25) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %32 = "llvm.fmul"(%24, %26) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %33 = "llvm.fadd"(%31, %32) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %34 = "llvm.fmul"(%24, %25) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %35 = "llvm.fmul"(%23, %26) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %36 = "llvm.fsub"(%34, %35) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %37 = "llvm.fdiv"(%33, %30) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %38 = "llvm.fdiv"(%36, %30) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %39 = "llvm.insertvalue"(%27, %37) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    %40 = "llvm.insertvalue"(%39, %38) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    %41 = "builtin.unrealized_conversion_cast"(%40) : (!llvm.struct<(f32, f32)>) -> complex<f32>
    "func.return"(%41) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_div_with_fmf"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (complex<f32>) -> !llvm.struct<(f32, f32)>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (complex<f32>) -> !llvm.struct<(f32, f32)>
    %2 = "llvm.extractvalue"(%1) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %3 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %4 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %5 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    %6 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, f32)>
    %7 = "llvm.fmul"(%4, %4) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %8 = "llvm.fmul"(%5, %5) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %9 = "llvm.fadd"(%7, %8) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %10 = "llvm.fmul"(%2, %4) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %11 = "llvm.fmul"(%3, %5) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %12 = "llvm.fadd"(%10, %11) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %13 = "llvm.fmul"(%3, %4) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %14 = "llvm.fmul"(%2, %5) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %15 = "llvm.fsub"(%13, %14) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %16 = "llvm.fdiv"(%12, %9) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %17 = "llvm.fdiv"(%15, %9) <{fastmathFlags = #llvm.fastmath<nsz, arcp>}> : (f32, f32) -> f32
    %18 = "llvm.insertvalue"(%6, %16) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    %19 = "llvm.insertvalue"(%18, %17) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>, f32) -> !llvm.struct<(f32, f32)>
    %20 = "builtin.unrealized_conversion_cast"(%19) : (!llvm.struct<(f32, f32)>) -> complex<f32>
    "func.return"(%20) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

