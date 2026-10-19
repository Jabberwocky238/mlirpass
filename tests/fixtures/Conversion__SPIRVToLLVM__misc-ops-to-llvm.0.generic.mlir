"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (array<4 x array<4 x f32>>)>, linkage = #llvm.linkage<external>, sym_name = "composite_extract_array", visibility_ = 0 : i64}> ({
  ^bb0(%arg17: !llvm.array<4 x array<4 x f32>>):
    %35 = "llvm.extractvalue"(%arg17) <{position = array<i64: 1, 3>}> : (!llvm.array<4 x array<4 x f32>>) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<3xf32>)>, linkage = #llvm.linkage<external>, sym_name = "composite_extract_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg16: vector<3xf32>):
    %33 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %34 = "llvm.extractelement"(%arg16, %33) : (vector<3xf32>, i32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, struct<packed (f32, array<4 x i32>)>)>, linkage = #llvm.linkage<external>, sym_name = "composite_insert_struct", visibility_ = 0 : i64}> ({
  ^bb0(%arg14: i32, %arg15: !llvm.struct<packed (f32, array<4 x i32>)>):
    %32 = "llvm.insertvalue"(%arg15, %arg14) <{position = array<i64: 1, 3>}> : (!llvm.struct<packed (f32, array<4 x i32>)>, i32) -> !llvm.struct<packed (f32, array<4 x i32>)>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<3xf32>, f32)>, linkage = #llvm.linkage<external>, sym_name = "composite_insert_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg12: vector<3xf32>, %arg13: f32):
    %30 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %31 = "llvm.insertelement"(%arg12, %arg13, %30) : (vector<3xf32>, f32, i32) -> vector<3xf32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i1, vector<3xi32>, vector<3xi32>, f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "select_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg7: i1, %arg8: vector<3xi32>, %arg9: vector<3xi32>, %arg10: f32, %arg11: f32):
    %28 = "llvm.select"(%arg7, %arg8, %arg9) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    %29 = "llvm.select"(%arg7, %arg10, %arg11) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, f32, f32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<2xi1>, vector<2xi32>, vector<2xi32>)>, linkage = #llvm.linkage<external>, sym_name = "select_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg4: vector<2xi1>, %arg5: vector<2xi32>, %arg6: vector<2xi32>):
    %27 = "llvm.select"(%arg4, %arg5, %arg6) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xi1>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<3xf32> (vector<2xf32>, vector<2xf32>)>, linkage = #llvm.linkage<external>, sym_name = "vector_shuffle_same_size", visibility_ = 0 : i64}> ({
  ^bb0(%arg2: vector<2xf32>, %arg3: vector<2xf32>):
    %26 = "llvm.shufflevector"(%arg2, %arg3) <{mask = array<i32: 0, 2, -1>}> : (vector<2xf32>, vector<2xf32>) -> vector<3xf32>
    "llvm.return"(%26) : (vector<3xf32>) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<3xf32> (vector<3xf32>, vector<2xf32>)>, linkage = #llvm.linkage<external>, sym_name = "vector_shuffle_different_size", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<3xf32>, %arg1: vector<2xf32>):
    %17 = "llvm.mlir.poison"() : () -> vector<3xf32>
    %18 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %19 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %20 = "llvm.extractelement"(%arg0, %19) : (vector<3xf32>, i32) -> f32
    %21 = "llvm.insertelement"(%17, %20, %18) : (vector<3xf32>, f32, i32) -> vector<3xf32>
    %22 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %23 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %24 = "llvm.extractelement"(%arg1, %23) : (vector<2xf32>, i32) -> f32
    %25 = "llvm.insertelement"(%21, %24, %22) : (vector<3xf32>, f32, i32) -> vector<3xf32>
    "llvm.return"(%25) : (vector<3xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "llvm.mlir.global"() <{addr_space = 0 : i32, constant, global_type = !llvm.struct<(i32)>, linkage = #llvm.linkage<external>, sym_name = "__spv__empty_execution_mode_info_31", visibility_ = 0 : i64}> ({
      %14 = "llvm.mlir.poison"() : () -> !llvm.struct<(i32)>
      %15 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
      %16 = "llvm.insertvalue"(%14, %15) <{position = array<i64: 0>}> : (!llvm.struct<(i32)>, i32) -> !llvm.struct<(i32)>
      "llvm.return"(%16) : (!llvm.struct<(i32)>) -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "empty", visibility_ = 0 : i64}> ({
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "llvm.mlir.global"() <{addr_space = 0 : i32, constant, global_type = !llvm.struct<(i32, array<3 x i32>)>, linkage = #llvm.linkage<external>, sym_name = "__spv__bar_execution_mode_info_18", visibility_ = 0 : i64}> ({
      %5 = "llvm.mlir.poison"() : () -> !llvm.struct<(i32, array<3 x i32>)>
      %6 = "llvm.mlir.constant"() <{value = 18 : i32}> : () -> i32
      %7 = "llvm.insertvalue"(%5, %6) <{position = array<i64: 0>}> : (!llvm.struct<(i32, array<3 x i32>)>, i32) -> !llvm.struct<(i32, array<3 x i32>)>
      %8 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
      %9 = "llvm.insertvalue"(%7, %8) <{position = array<i64: 1, 0>}> : (!llvm.struct<(i32, array<3 x i32>)>, i32) -> !llvm.struct<(i32, array<3 x i32>)>
      %10 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %11 = "llvm.insertvalue"(%9, %10) <{position = array<i64: 1, 1>}> : (!llvm.struct<(i32, array<3 x i32>)>, i32) -> !llvm.struct<(i32, array<3 x i32>)>
      %12 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %13 = "llvm.insertvalue"(%11, %12) <{position = array<i64: 1, 2>}> : (!llvm.struct<(i32, array<3 x i32>)>, i32) -> !llvm.struct<(i32, array<3 x i32>)>
      "llvm.return"(%13) : (!llvm.struct<(i32, array<3 x i32>)>) -> ()
    }) : () -> ()
    "llvm.mlir.global"() <{addr_space = 0 : i32, constant, global_type = !llvm.struct<(i32)>, linkage = #llvm.linkage<external>, sym_name = "__spv__bar_execution_mode_info_31", visibility_ = 0 : i64}> ({
      %2 = "llvm.mlir.poison"() : () -> !llvm.struct<(i32)>
      %3 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
      %4 = "llvm.insertvalue"(%2, %3) <{position = array<i64: 0>}> : (!llvm.struct<(i32)>, i32) -> !llvm.struct<(i32)>
      "llvm.return"(%4) : (!llvm.struct<(i32)>) -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "bar", visibility_ = 0 : i64}> ({
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "undef_scalar", visibility_ = 0 : i64}> ({
    %1 = "llvm.mlir.undef"() : () -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "undef_vector", visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.undef"() : () -> vector<2xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

