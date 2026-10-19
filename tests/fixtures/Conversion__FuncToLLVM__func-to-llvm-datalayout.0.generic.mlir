"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64)>, linkage = #llvm.linkage<external>, sym_name = "test_default_index", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "test_32bit_index", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
}) {dlti.dl_spec = #dlti.dl_spec<index = 32 : i64>} : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64)>, linkage = #llvm.linkage<external>, sym_name = "test_64bit_index", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
}) {dlti.dl_spec = #dlti.dl_spec<index = 64 : i64>} : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i16 (i16)>, linkage = #llvm.linkage<external>, sym_name = "test_16bit_index", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
}) {dlti.dl_spec = #dlti.dl_spec<index = 16 : i64>} : () -> ()

