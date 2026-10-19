"builtin.module"() ({
  "func.func"() <{function_type = (!llvm.struct<"_Converted.foo", (f32)>) -> (), sym_name = "clashing_struct_name", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.struct<"foo", (index)>) -> (), sym_name = "create_clashes_on_conversion", sym_visibility = "private"}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!llvm.struct<"_Converted.foo", (i64)>) -> (), sym_name = "clashing_struct_name", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.struct<"foo", (index)>) -> (), sym_name = "merge_on_conversion", sym_visibility = "private"}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!llvm.struct<"_Converted.foo", (struct<"_Converted.foo">, f32)>) -> (), sym_name = "clashing_struct_name", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.struct<"foo", (!llvm.struct<"foo">, index)>) -> (), sym_name = "create_clashes_on_conversion_recursive", sym_visibility = "private"}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!llvm.struct<"_Converted.foo", (struct<"_Converted.foo">, i64)>) -> (), sym_name = "clashing_struct_name", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.struct<"foo", (!llvm.struct<"foo">, index)>) -> (), sym_name = "merge_on_conversion_recursive", sym_visibility = "private"}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!llvm.struct<"_Converted.foo", (struct<"_Converted.foo">, i64)>) -> (), sym_name = "clashing_struct_name", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.struct<"foo", packed (!llvm.struct<"foo">, index)>) -> (), sym_name = "create_clashing_pack", sym_visibility = "private"}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!llvm.struct<"_Converted.foo", packed (struct<"_Converted.foo">, i64)>) -> (), sym_name = "clashing_struct_name", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.struct<"foo", packed (!llvm.struct<"foo">, index)>) -> (), sym_name = "merge_on_conversion_pack", sym_visibility = "private"}> ({
  }) : () -> ()
}) : () -> ()

