"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> (), sym_name = "dealloc_with_user_free"}> ({
  ^bb0(%arg0: memref<?xf32>):
    "memref.dealloc"(%arg0) : (memref<?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "free", sym_visibility = "private"}> ({
  }) : () -> ()
}) : () -> ()

