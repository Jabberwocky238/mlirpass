"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (array<16 x f32>, array<32 x vector<4xf32>>)>, linkage = #llvm.linkage<external>, sym_name = "array", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (array<16 x f32>)>, linkage = #llvm.linkage<external>, sym_name = "array_with_natural_stride", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "pointer_scalar", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "pointer_vector", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (array<0 x vector<4xf32>>)>, linkage = #llvm.linkage<external>, sym_name = "runtime_array_vector", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (array<0 x f32>)>, linkage = #llvm.linkage<external>, sym_name = "runtime_array_scalar", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (struct<packed (f64)>)>, linkage = #llvm.linkage<external>, sym_name = "struct", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (struct<packed (i32, struct<packed (i64, i32)>)>)>, linkage = #llvm.linkage<external>, sym_name = "struct_nested", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (struct<(i8, i32)>)>, linkage = #llvm.linkage<external>, sym_name = "struct_with_natural_offset", visibility_ = 0 : i64}> ({
  }) : () -> ()
}) : () -> ()

