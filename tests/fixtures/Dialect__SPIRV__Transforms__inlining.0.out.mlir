module {
  spirv.module Logical GLSL450 {
    spirv.func @callee() "None" {
      spirv.Return
    }
    spirv.func @calling_single_block_ret_func() "None" {
      spirv.Return
    }
  }
}

// -----
module {
  spirv.module Logical GLSL450 {
    spirv.func @callee() -> i32 "None" {
      %cst42_i32 = spirv.Constant 42 : i32
      spirv.ReturnValue %cst42_i32 : i32
    }
    spirv.func @calling_single_block_retval_func() -> i32 "None" {
      %cst42_i32 = spirv.Constant 42 : i32
      spirv.ReturnValue %cst42_i32 : i32
    }
  }
}

// -----
module {
  spirv.module Logical GLSL450 {
    spirv.GlobalVariable @data bind(0, 0) : !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32> [0])>, StorageBuffer>
    spirv.func @callee() "None" {
      %data_addr = spirv.mlir.addressof @data : !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32> [0])>, StorageBuffer>
      %cst0_i32 = spirv.Constant 0 : i32
      %0 = spirv.AccessChain %data_addr[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i32, StorageBuffer>
      spirv.Branch ^bb1
    ^bb1:  // pred: ^bb0
      %cst42_i32 = spirv.Constant 42 : i32
      spirv.Store "StorageBuffer" %0, %cst42_i32 : i32
      spirv.Return
    }
    spirv.func @calling_multi_block_ret_func() "None" {
      %data_addr = spirv.mlir.addressof @data : !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32> [0])>, StorageBuffer>
      %cst0_i32 = spirv.Constant 0 : i32
      %0 = spirv.AccessChain %data_addr[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i32, StorageBuffer>
      spirv.Branch ^bb1
    ^bb1:  // pred: ^bb0
      %cst42_i32 = spirv.Constant 42 : i32
      spirv.Store "StorageBuffer" %0, %cst42_i32 : i32
      spirv.Branch ^bb2
    ^bb2:  // pred: ^bb1
      spirv.Return
    }
  }
}

// -----
module {
  spirv.module Logical GLSL450 {
    spirv.func @callee(%arg0: i1) "None" {
      spirv.mlir.selection {
        spirv.BranchConditional %arg0, ^bb1, ^bb2
      ^bb1:  // pred: ^bb0
        spirv.Return
      ^bb2:  // pred: ^bb0
        spirv.mlir.merge
      }
      spirv.Return
    }
    spirv.func @calling_selection_ret_func() "None" {
      %true = spirv.Constant true
      spirv.FunctionCall @callee(%true) : (i1) -> ()
      spirv.Return
    }
  }
}

// -----
module {
  spirv.module Logical GLSL450 {
    spirv.func @callee(%arg0: i1) "None" {
      spirv.mlir.selection {
        spirv.BranchConditional %arg0, ^bb1, ^bb2
      ^bb1:  // pred: ^bb0
        spirv.Branch ^bb2
      ^bb2:  // 2 preds: ^bb0, ^bb1
        spirv.mlir.merge
      }
      spirv.Return
    }
    spirv.func @calling_selection_no_ret_func() "None" {
      %true = spirv.Constant true
      spirv.mlir.selection {
        spirv.BranchConditional %true, ^bb1, ^bb2
      ^bb1:  // pred: ^bb0
        spirv.Branch ^bb2
      ^bb2:  // 2 preds: ^bb0, ^bb1
        spirv.mlir.merge
      }
      spirv.Return
    }
  }
}

// -----
module {
  spirv.module Logical GLSL450 {
    spirv.func @callee(%arg0: i1) "None" {
      spirv.mlir.loop {
        spirv.Branch ^bb1
      ^bb1:  // 2 preds: ^bb0, ^bb3
        spirv.BranchConditional %arg0, ^bb2, ^bb4
      ^bb2:  // pred: ^bb1
        spirv.Return
      ^bb3:  // no predecessors
        spirv.Branch ^bb1
      ^bb4:  // pred: ^bb1
        spirv.mlir.merge
      }
      spirv.Return
    }
    spirv.func @calling_loop_ret_func() "None" {
      %true = spirv.Constant true
      spirv.FunctionCall @callee(%true) : (i1) -> ()
      spirv.Return
    }
  }
}

// -----
module {
  spirv.module Logical GLSL450 {
    spirv.func @callee(%arg0: i1) "None" {
      spirv.mlir.loop {
        spirv.Branch ^bb1
      ^bb1:  // 2 preds: ^bb0, ^bb3
        spirv.BranchConditional %arg0, ^bb2, ^bb4
      ^bb2:  // pred: ^bb1
        spirv.Branch ^bb3
      ^bb3:  // pred: ^bb2
        spirv.Branch ^bb1
      ^bb4:  // pred: ^bb1
        spirv.mlir.merge
      }
      spirv.Return
    }
    spirv.func @calling_loop_no_ret_func() "None" {
      %true = spirv.Constant true
      spirv.mlir.loop {
        spirv.Branch ^bb1
      ^bb1:  // 2 preds: ^bb0, ^bb3
        spirv.BranchConditional %true, ^bb2, ^bb4
      ^bb2:  // pred: ^bb1
        spirv.Branch ^bb3
      ^bb3:  // pred: ^bb2
        spirv.Branch ^bb1
      ^bb4:  // pred: ^bb1
        spirv.mlir.merge
      }
      spirv.Return
    }
  }
}

// -----
module {
  spirv.module Logical GLSL450 {
    spirv.GlobalVariable @arg_0 bind(0, 0) : !spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>
    spirv.GlobalVariable @arg_1 bind(0, 1) : !spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>
    spirv.func @inline_into_selection_region() "None" {
      %cst0_i32 = spirv.Constant 0 : i32
      %arg_0_addr = spirv.mlir.addressof @arg_0 : !spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>
      %arg_1_addr = spirv.mlir.addressof @arg_1 : !spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>
      %0 = spirv.AccessChain %arg_0_addr[%cst0_i32] : !spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>, i32 -> !spirv.ptr<i32, StorageBuffer>
      %1 = spirv.Load "StorageBuffer" %0 : i32
      %2 = spirv.SGreaterThan %1, %cst0_i32 : i32
      spirv.mlir.selection {
        spirv.BranchConditional %2, ^bb1, ^bb2
      ^bb1:  // pred: ^bb0
        %3 = spirv.AccessChain %arg_1_addr[%cst0_i32] : !spirv.ptr<!spirv.struct<(i32 [0])>, StorageBuffer>, i32 -> !spirv.ptr<i32, StorageBuffer>
        %4 = spirv.AtomicIAdd <Device> <AcquireRelease> %3, %1 : !spirv.ptr<i32, StorageBuffer>
        spirv.Branch ^bb2
      ^bb2:  // 2 preds: ^bb0, ^bb1
        spirv.mlir.merge
      }
      spirv.Return
    }
    spirv.func @atomic_add(%arg0: i32, %arg1: !spirv.ptr<i32, StorageBuffer>) "None" {
      %0 = spirv.AtomicIAdd <Device> <AcquireRelease> %arg1, %arg0 : !spirv.ptr<i32, StorageBuffer>
      spirv.Return
    }
    spirv.EntryPoint "GLCompute" @inline_into_selection_region
    spirv.ExecutionMode @inline_into_selection_region "LocalSize", 32, 1, 1
  }
}

// -----
module {
  spirv.module Logical GLSL450 {
    spirv.func @foo(%arg0: i32) -> i32 "None" {
      %cst1_i32 = spirv.Constant 1 : i32
      %0 = spirv.IEqual %arg0, %cst1_i32 : i32
      spirv.BranchConditional %0, ^bb1(%cst1_i32 : i32), ^bb2
    ^bb1(%1: i32):  // pred: ^bb0
      spirv.Branch ^bb3(%1 : i32)
    ^bb2:  // pred: ^bb0
      spirv.Branch ^bb3(%cst1_i32 : i32)
    ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
      spirv.ReturnValue %2 : i32
    }
  }
}

// -----
module {
  spirv.module Logical GLSL450 {
    spirv.func @callee() "None" {
      spirv.Kill
    }
    spirv.func @do_not_inline_kill() "None" {
      spirv.FunctionCall @callee() : () -> ()
      spirv.Return
    }
  }
}

