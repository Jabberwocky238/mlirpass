module {
  llvm.func @second_order_arg(!llvm.ptr) attributes {sym_visibility = "private"}
  llvm.func @second_order_result() -> !llvm.ptr attributes {sym_visibility = "private"}
  llvm.func @second_order_multi_result() -> !llvm.struct<(ptr, ptr, ptr)> attributes {sym_visibility = "private"}
  llvm.func @memref_call_conv(!llvm.ptr, !llvm.ptr, i64, i64, i64) attributes {sym_visibility = "private"}
  llvm.func @memref_call_conv_nested(!llvm.ptr) attributes {sym_visibility = "private"}
  llvm.func @pass_through(%arg0: !llvm.ptr) -> !llvm.ptr {
    llvm.br ^bb1(%arg0 : !llvm.ptr)
  ^bb1(%0: !llvm.ptr):  // pred: ^bb0
    llvm.return %0 : !llvm.ptr
  }
  llvm.func extern_weak @llvmlinkage(i32) attributes {sym_visibility = "private"}
  llvm.func @llvmreadnone(i32) attributes {memory_effects = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>, sym_visibility = "private"}
  llvm.func @body(i32) attributes {sym_visibility = "private"}
  llvm.func @indirect_const_call(%arg0: i32) {
    %0 = llvm.mlir.addressof @body : !llvm.ptr
    llvm.call %0(%arg0) : !llvm.ptr, (i32) -> ()
    llvm.return
  }
  llvm.func @indirect_call(%arg0: !llvm.ptr, %arg1: f32) -> i32 {
    %0 = llvm.call %arg0(%arg1) : !llvm.ptr, (f32) -> i32
    llvm.return %0 : i32
  }
  llvm.func @variadic_func(%arg0: i32, ...) {
    llvm.return
  }
  llvm.func @target_cpu() attributes {sym_visibility = "private", target_cpu = "gfx90a"}
  llvm.func @target_features() attributes {sym_visibility = "private", target_features = #llvm.target_features<["+sme", "+sve"]>}
}

// -----
module {
  llvm.func @private_callee(%arg0: f32) -> i32 attributes {sym_visibility = "private"} {
    %c0_i32 = arith.constant 0 : i32
    llvm.return %c0_i32 : i32
  }
  llvm.func @caller_private_callee(%arg0: f32) -> i32 {
    %0 = llvm.call @private_callee(%arg0) : (f32) -> i32
    llvm.return %0 : i32
  }
}

// -----
module {
  func.func private @badllvmlinkage(i32) attributes {llvm.linkage = 3 : i64}
}

// -----
module {
  func.func @variadic_func(%arg0: i32) attributes {func.varargs = true, llvm.emit_c_interface} {
    llvm.return
  }
}

