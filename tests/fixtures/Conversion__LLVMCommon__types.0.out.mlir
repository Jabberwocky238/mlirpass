module {
  llvm.func @clashing_struct_name(!llvm.struct<"_Converted.foo", (f32)>) attributes {sym_visibility = "private"}
  func.func private @create_clashes_on_conversion(!llvm.struct<"foo", (index)>)
}

// -----
module {
  llvm.func @clashing_struct_name(!llvm.struct<"_Converted.foo", (i64)>) attributes {sym_visibility = "private"}
  llvm.func @merge_on_conversion(!llvm.struct<"_Converted.foo", (i64)>) attributes {sym_visibility = "private"}
}

// -----
module {
  llvm.func @clashing_struct_name(!llvm.struct<"_Converted.foo", (struct<"_Converted.foo">, f32)>) attributes {sym_visibility = "private"}
  func.func private @create_clashes_on_conversion_recursive(!llvm.struct<"foo", (!llvm.struct<"foo">, index)>)
}

// -----
module {
  llvm.func @clashing_struct_name(!llvm.struct<"_Converted.foo", (struct<"_Converted.foo">, i64)>) attributes {sym_visibility = "private"}
  llvm.func @merge_on_conversion_recursive(!llvm.struct<"_Converted.foo", (struct<"_Converted.foo">, i64)>) attributes {sym_visibility = "private"}
}

// -----
module {
  llvm.func @clashing_struct_name(!llvm.struct<"_Converted.foo", (struct<"_Converted.foo">, i64)>) attributes {sym_visibility = "private"}
  func.func private @create_clashing_pack(!llvm.struct<"foo", packed (!llvm.struct<"foo">, index)>)
}

// -----
module {
  llvm.func @clashing_struct_name(!llvm.struct<"_Converted.foo", packed (struct<"_Converted.foo">, i64)>) attributes {sym_visibility = "private"}
  llvm.func @merge_on_conversion_pack(!llvm.struct<"_Converted.foo", packed (struct<"_Converted.foo">, i64)>) attributes {sym_visibility = "private"}
}

