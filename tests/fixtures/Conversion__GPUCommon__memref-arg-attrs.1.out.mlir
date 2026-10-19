module {
  gpu.module @kernel {
    llvm.func @test_func_readonly(%arg0: !llvm.ptr {llvm.readonly}, %arg1: !llvm.ptr {llvm.readonly}, %arg2: i64) {
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @kernel {
    llvm.func @test_func_writeonly(%arg0: !llvm.ptr {llvm.writeonly}, %arg1: !llvm.ptr {llvm.writeonly}, %arg2: i64) {
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @kernel {
    llvm.func @test_func_readonly_ptr(%arg0: !llvm.ptr {llvm.readonly}) {
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @kernel {
    llvm.func @test_func_nonnull(%arg0: !llvm.ptr {llvm.nonnull}, %arg1: !llvm.ptr {llvm.nonnull}, %arg2: i64) {
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @kernel {
    llvm.func @test_func_dereferenceable(%arg0: !llvm.ptr {llvm.dereferenceable = 4 : i64}, %arg1: !llvm.ptr {llvm.dereferenceable = 4 : i64}, %arg2: i64) {
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @kernel {
    llvm.func @test_func_dereferenceable_or_null(%arg0: !llvm.ptr {llvm.dereferenceable_or_null = 4 : i64}, %arg1: !llvm.ptr {llvm.dereferenceable_or_null = 4 : i64}, %arg2: i64) {
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @kernel {
    llvm.func @test_func_noundef(%arg0: !llvm.ptr {llvm.noundef}, %arg1: !llvm.ptr {llvm.noundef}, %arg2: i64 {llvm.noundef}) {
      llvm.return
    }
  }
}

