"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<f32>, res_attrs = [{test.returnOne}], sym_name = "res_attrs_with_memref_return"}> ({
    %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    "func.return"(%13) : (memref<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, res_attrs = [{test.returnOne = 1 : i64}], sym_name = "res_attrs_with_value_return"}> ({
    %12 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    "func.return"(%12) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (memref<f32>, f32), res_attrs = [{test.returnOne = 1 : i64}, {test.returnThree = 3 : i64, test.returnTwo = 2 : i64}], sym_name = "multiple_return"}> ({
    %10 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    %11 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    "func.return"(%10, %11) : (memref<f32>, f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (memref<f32>, i64, f32), res_attrs = [{test.returnOne = 1 : i64}, {}, {test.returnThree = 3 : i64, test.returnTwo = 2 : i64}], sym_name = "multiple_return_missing_res_attr"}> ({
    %7 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    %8 = "arith.constant"() <{value = 2 : i64}> : () -> i64
    %9 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    "func.return"(%7, %8, %9) : (memref<f32>, i64, f32) -> ()
  }) : () -> ()
  "func.func"() <{arg_attrs = [{test.argOne = 1 : i64}], function_type = (memref<f32>) -> memref<f32>, sym_name = "one_arg_attr_no_res_attrs_with_memref_return"}> ({
  ^bb0(%arg5: memref<f32>):
    %6 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    "func.return"(%6) : (memref<f32>) -> ()
  }) : () -> ()
  "func.func"() <{arg_attrs = [{test.argOne = 1 : i64}], function_type = (memref<f32>) -> memref<f32>, res_attrs = [{test.returnOne = 1 : i64}], sym_name = "one_arg_attr_one_res_attr_with_memref_return"}> ({
  ^bb0(%arg4: memref<f32>):
    %5 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    "func.return"(%5) : (memref<f32>) -> ()
  }) : () -> ()
  "func.func"() <{arg_attrs = [{test.argOne = 1 : i64}], function_type = (memref<f32>) -> f32, res_attrs = [{test.returnOne = 1 : i64}], sym_name = "one_arg_attr_one_res_attr_with_value_return"}> ({
  ^bb0(%arg3: memref<f32>):
    %4 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    "func.return"(%4) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{arg_attrs = [{test.argZero = 0 : i64}, {}, {test.argTwo = 2 : i64}], function_type = (memref<f32>, f32, i32) -> (f32, memref<i32>, i32), res_attrs = [{}, {test.returnOne = 1 : i64}, {test.returnTwo = 2 : i64}], sym_name = "multiple_arg_attr_multiple_res_attr"}> ({
  ^bb0(%arg0: memref<f32>, %arg1: f32, %arg2: i32):
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    %3 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    "func.return"(%1, %2, %3) : (f32, memref<i32>, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<f32>, res_attrs = [{test.returnOne}], sym_name = "drop_linkage_attr"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    "func.return"(%0) : (memref<f32>) -> ()
  }) {llvm.linkage = #llvm.linkage<external>} : () -> ()
}) : () -> ()

