"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "bool_constant_scalar", visibility_ = 0 : i64}> ({
    %11 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    %12 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "bool_constant_vector", visibility_ = 0 : i64}> ({
    %9 = "llvm.mlir.constant"() <{value = dense<[true, false]> : vector<2xi1>}> : () -> vector<2xi1>
    %10 = "llvm.mlir.constant"() <{value = dense<false> : vector<3xi1>}> : () -> vector<3xi1>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "integer_constant_scalar", visibility_ = 0 : i64}> ({
    %6 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
    %7 = "llvm.mlir.constant"() <{value = -5 : i64}> : () -> i64
    %8 = "llvm.mlir.constant"() <{value = 10 : i16}> : () -> i16
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "integer_constant_vector", visibility_ = 0 : i64}> ({
    %3 = "llvm.mlir.constant"() <{value = dense<[2, 3]> : vector<2xi32>}> : () -> vector<2xi32>
    %4 = "llvm.mlir.constant"() <{value = dense<-4> : vector<2xi32>}> : () -> vector<2xi32>
    %5 = "llvm.mlir.constant"() <{value = dense<[2, 3, 4]> : vector<3xi32>}> : () -> vector<3xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "float_constant_scalar", visibility_ = 0 : i64}> ({
    %1 = "llvm.mlir.constant"() <{value = 5.000000e+00 : f16}> : () -> f16
    %2 = "llvm.mlir.constant"() <{value = 5.000000e+00 : f64}> : () -> f64
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "float_constant_vector", visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = dense<[2.000000e+00, 3.000000e+00]> : vector<2xf32>}> : () -> vector<2xf32>
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

