"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "test_default_index", sym_visibility = "private"}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "test_32bit_index", sym_visibility = "private"}> ({
  }) : () -> ()
}) {dlti.dl_spec = #dlti.dl_spec<index = 32 : i64>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "test_64bit_index", sym_visibility = "private"}> ({
  }) : () -> ()
}) {dlti.dl_spec = #dlti.dl_spec<index = 64 : i64>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "test_16bit_index", sym_visibility = "private"}> ({
  }) : () -> ()
}) {dlti.dl_spec = #dlti.dl_spec<index = 16 : i64>} : () -> ()

