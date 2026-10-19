"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<f32>, res_attrs = [{test.returnOne}], sym_name = "res_attrs_with_memref_return", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, res_attrs = [{test.returnOne = 1 : i64}], sym_name = "res_attrs_with_value_return", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (memref<f32>, f32), res_attrs = [{test.returnOne = 1 : i64}, {test.returnThree = 3 : i64, test.returnTwo = 2 : i64}], sym_name = "multiple_return", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (memref<f32>, i64, f32), res_attrs = [{test.returnOne = 1 : i64}, {}, {test.returnThree = 3 : i64, test.returnTwo = 2 : i64}], sym_name = "multiple_return_missing_res_attr", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{arg_attrs = [{test.argOne = 1 : i64}], function_type = (memref<f32>) -> memref<f32>, sym_name = "one_arg_attr_no_res_attrs_with_memref_return", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{arg_attrs = [{test.argOne = 1 : i64}], function_type = (memref<f32>) -> memref<f32>, res_attrs = [{test.returnOne = 1 : i64}], sym_name = "one_arg_attr_one_res_attr_with_memref_return", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{arg_attrs = [{test.argOne = 1 : i64}], function_type = (memref<f32>) -> f32, res_attrs = [{test.returnOne = 1 : i64}], sym_name = "one_arg_attr_one_res_attr_with_value_return", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{arg_attrs = [{test.argZero = 0 : i64}, {}, {test.argTwo = 2 : i64}], function_type = (memref<f32>, f32, i32) -> (f32, memref<i32>, i32), res_attrs = [{}, {test.returnOne = 1 : i64}, {test.returnTwo = 2 : i64}], sym_name = "multiple_arg_attr_multiple_res_attr", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<f32>, res_attrs = [{test.returnOne}], sym_name = "drop_linkage_attr", sym_visibility = "private"}> ({
  }) {llvm.linkage = #llvm.linkage<weak>} : () -> ()
}) : () -> ()

