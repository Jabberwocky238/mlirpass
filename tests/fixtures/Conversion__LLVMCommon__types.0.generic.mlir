"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (struct<"_Converted.foo", (f32)>)>, linkage = #llvm.linkage<external>, sym_name = "clashing_struct_name", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.struct<"foo", (index)>) -> (), sym_name = "create_clashes_on_conversion", sym_visibility = "private"}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (struct<"_Converted.foo", (i64)>)>, linkage = #llvm.linkage<external>, sym_name = "clashing_struct_name", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (struct<"_Converted.foo", (i64)>)>, linkage = #llvm.linkage<external>, sym_name = "merge_on_conversion", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (struct<"_Converted.foo", (struct<"_Converted.foo">, f32)>)>, linkage = #llvm.linkage<external>, sym_name = "clashing_struct_name", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.struct<"foo", (!llvm.struct<"foo">, index)>) -> (), sym_name = "create_clashes_on_conversion_recursive", sym_visibility = "private"}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (struct<"_Converted.foo", (struct<"_Converted.foo">, i64)>)>, linkage = #llvm.linkage<external>, sym_name = "clashing_struct_name", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (struct<"_Converted.foo", (struct<"_Converted.foo">, i64)>)>, linkage = #llvm.linkage<external>, sym_name = "merge_on_conversion_recursive", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (struct<"_Converted.foo", (struct<"_Converted.foo">, i64)>)>, linkage = #llvm.linkage<external>, sym_name = "clashing_struct_name", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.struct<"foo", packed (!llvm.struct<"foo">, index)>) -> (), sym_name = "create_clashing_pack", sym_visibility = "private"}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (struct<"_Converted.foo", packed (struct<"_Converted.foo">, i64)>)>, linkage = #llvm.linkage<external>, sym_name = "clashing_struct_name", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (struct<"_Converted.foo", packed (struct<"_Converted.foo">, i64)>)>, linkage = #llvm.linkage<external>, sym_name = "merge_on_conversion_pack", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
}) : () -> ()

