"builtin.module"() ({
  "func.func"() <{function_type = (memref<64xf32, strided<[?], offset: ?>>) -> (), sym_name = "callee", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<64xf32, strided<[?], offset: ?>>) -> (), sym_name = "caller"}> ({
  ^bb0(%arg0: memref<64xf32, strided<[?], offset: ?>>):
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64xf32>
    "memref.copy"(%arg0, %0) : (memref<64xf32, strided<[?], offset: ?>>, memref<64xf32>) -> ()
    %1 = "memref.cast"(%0) : (memref<64xf32>) -> memref<64xf32, strided<[?], offset: ?>>
    "func.call"(%1) <{callee = @callee}> : (memref<64xf32, strided<[?], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

