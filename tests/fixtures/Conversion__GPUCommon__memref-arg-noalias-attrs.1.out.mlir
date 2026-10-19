module {
  gpu.module @kernel {
    llvm.func @func_with_noalias_attr(%arg0: !llvm.ptr {llvm.noalias}) {
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @kernel {
    llvm.func @func_without_any_attr(%arg0: !llvm.ptr) {
      llvm.return
    }
  }
}

