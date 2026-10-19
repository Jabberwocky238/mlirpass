module {
  gpu.module @kernel attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @test_func_readonly(%arg0: !llvm.ptr {llvm.readonly}, %arg1: !llvm.ptr {llvm.readonly}, %arg2: i64) {
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @kernel attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @test_func_writeonly(%arg0: !llvm.ptr {llvm.writeonly}, %arg1: !llvm.ptr {llvm.writeonly}, %arg2: i64) {
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @kernel attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @test_func_readonly_ptr(%arg0: !llvm.ptr {llvm.readonly}) {
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @kernel attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @test_func_nonnull(%arg0: !llvm.ptr {llvm.nonnull}, %arg1: !llvm.ptr {llvm.nonnull}, %arg2: i64) {
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @kernel attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @test_func_dereferenceable(%arg0: !llvm.ptr {llvm.dereferenceable = 4 : i64}, %arg1: !llvm.ptr {llvm.dereferenceable = 4 : i64}, %arg2: i64) {
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @kernel attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @test_func_dereferenceable_or_null(%arg0: !llvm.ptr {llvm.dereferenceable_or_null = 4 : i64}, %arg1: !llvm.ptr {llvm.dereferenceable_or_null = 4 : i64}, %arg2: i64) {
      llvm.return
    }
  }
}

// -----
module {
  gpu.module @kernel attributes {llvm.data_layout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"} {
    llvm.func @test_func_noundef(%arg0: !llvm.ptr {llvm.noundef}, %arg1: !llvm.ptr {llvm.noundef}, %arg2: i64 {llvm.noundef}) {
      llvm.return
    }
  }
}

