"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, memref<f32>) -> (), sym_name = "external", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (memref<?x?xf32>, memref<f32>), sym_name = "returner", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "caller"}> ({
    %7:2 = "func.call"() <{callee = @returner}> : () -> (memref<?x?xf32>, memref<f32>)
    "func.call"(%7#0, %7#1) <{callee = @external}> : (memref<?x?xf32>, memref<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index) -> (), sym_name = "callee"}> ({
  ^bb0(%arg14: memref<?xf32>, %arg15: index):
    %6 = "memref.load"(%arg14, %arg15) : (memref<?xf32>, index) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index) -> (), sym_name = "other_callee"}> ({
  ^bb0(%arg12: memref<?xf32>, %arg13: index):
    %5 = "memref.load"(%arg12, %arg13) : (memref<?xf32>, index) -> f32
    "func.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "func.func"() <{function_type = (memref<4x3xf32>) -> (), sym_name = "return_var_memref_caller"}> ({
  ^bb0(%arg11: memref<4x3xf32>):
    %4 = "func.call"(%arg11) <{callee = @return_var_memref}> : (memref<4x3xf32>) -> memref<*xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4x3xf32>) -> memref<*xf32>, sym_name = "return_var_memref"}> ({
  ^bb0(%arg10: memref<4x3xf32>):
    %3 = "memref.cast"(%arg10) : (memref<4x3xf32>) -> memref<*xf32>
    "func.return"(%3) : (memref<*xf32>) -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "func.func"() <{function_type = (memref<4x3xf32>) -> (), sym_name = "return_two_var_memref_caller"}> ({
  ^bb0(%arg9: memref<4x3xf32>):
    %2:2 = "func.call"(%arg9) <{callee = @return_two_var_memref}> : (memref<4x3xf32>) -> (memref<*xf32>, memref<*xf32>)
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4x3xf32>) -> (memref<*xf32>, memref<*xf32>), sym_name = "return_two_var_memref"}> ({
  ^bb0(%arg8: memref<4x3xf32>):
    %1 = "memref.cast"(%arg8) : (memref<4x3xf32>) -> memref<*xf32>
    "func.return"(%1, %1) : (memref<*xf32>, memref<*xf32>) -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "func.func"() <{function_type = (memref<4x3xf32>, index, index, f32) -> memref<4x3xf32>, sym_name = "bare_ptr_calling_conv"}> ({
  ^bb0(%arg4: memref<4x3xf32>, %arg5: index, %arg6: index, %arg7: f32):
    "memref.store"(%arg7, %arg4, %arg5, %arg6) : (f32, memref<4x3xf32>, index, index) -> ()
    "func.return"(%arg4) : (memref<4x3xf32>) -> ()
  }) {llvm.bareptr} : () -> ()
  "func.func"() <{function_type = (memref<4x3xf32>, index, index, f32) -> (f32, memref<4x3xf32>), sym_name = "bare_ptr_calling_conv_multiresult"}> ({
  ^bb0(%arg0: memref<4x3xf32>, %arg1: index, %arg2: index, %arg3: f32):
    "memref.store"(%arg3, %arg0, %arg1, %arg2) : (f32, memref<4x3xf32>, index, index) -> ()
    %0 = "memref.load"(%arg0, %arg1, %arg2) : (memref<4x3xf32>, index, index) -> f32
    "func.return"(%0, %arg0) : (f32, memref<4x3xf32>) -> ()
  }) {llvm.bareptr} : () -> ()
}) : () -> ()

