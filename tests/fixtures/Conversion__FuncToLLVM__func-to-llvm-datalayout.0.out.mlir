module {
  llvm.func @test_default_index(i64) -> i64 attributes {sym_visibility = "private"}
}

// -----
module attributes {dlti.dl_spec = #dlti.dl_spec<index = 32 : i64>} {
  llvm.func @test_32bit_index(i32) -> i32 attributes {sym_visibility = "private"}
}

// -----
module attributes {dlti.dl_spec = #dlti.dl_spec<index = 64 : i64>} {
  llvm.func @test_64bit_index(i64) -> i64 attributes {sym_visibility = "private"}
}

// -----
module attributes {dlti.dl_spec = #dlti.dl_spec<index = 16 : i64>} {
  llvm.func @test_16bit_index(i16) -> i16 attributes {sym_visibility = "private"}
}

