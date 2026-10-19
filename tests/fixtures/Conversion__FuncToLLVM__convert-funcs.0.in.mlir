"builtin.module"() ({
  "func.func"() <{function_type = (() -> ()) -> (), sym_name = "second_order_arg", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (() -> ()), sym_name = "second_order_result", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (() -> i32, () -> i64, () -> f32), sym_name = "second_order_multi_result", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>) -> (), sym_name = "memref_call_conv", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = ((memref<?xf32>) -> ()) -> (), sym_name = "memref_call_conv_nested", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (() -> ()) -> (() -> ()), sym_name = "pass_through"}> ({
  ^bb0(%arg4: () -> ()):
    "cf.br"(%arg4)[^bb1] : (() -> ()) -> ()
  ^bb1(%2: () -> ()):  // pred: ^bb0
    "func.return"(%2) : (() -> ()) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "llvmlinkage", sym_visibility = "private"}> ({
  }) {llvm.linkage = #llvm.linkage<extern_weak>} : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "llvmreadnone", sym_visibility = "private"}> ({
  }) {llvm.readnone} : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "body", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "indirect_const_call"}> ({
  ^bb0(%arg3: i32):
    %1 = "func.constant"() <{value = @body}> : () -> ((i32) -> ())
    "func.call_indirect"(%1, %arg3) : ((i32) -> (), i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = ((f32) -> i32, f32) -> i32, sym_name = "indirect_call"}> ({
  ^bb0(%arg1: (f32) -> i32, %arg2: f32):
    %0 = "func.call_indirect"(%arg1, %arg2) : ((f32) -> i32, f32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "variadic_func"}> ({
  ^bb0(%arg0: i32):
    "func.return"() : () -> ()
  }) {func.varargs = true} : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "target_cpu", sym_visibility = "private"}> ({
  }) {target_cpu = "gfx90a"} : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "target_features", sym_visibility = "private"}> ({
  }) {target_features = #llvm.target_features<["+sme", "+sve"]>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> i32, sym_name = "private_callee", sym_visibility = "private"}> ({
  ^bb0(%arg1: f32):
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> i32, sym_name = "caller_private_callee"}> ({
  ^bb0(%arg0: f32):
    %0 = "func.call"(%arg0) <{callee = @private_callee}> : (f32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "badllvmlinkage", sym_visibility = "private"}> ({
  }) {llvm.linkage = 3 : i64} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "variadic_func"}> ({
  ^bb0(%arg0: i32):
    "func.return"() : () -> ()
  }) {func.varargs = true, llvm.emit_c_interface} : () -> ()
}) : () -> ()

