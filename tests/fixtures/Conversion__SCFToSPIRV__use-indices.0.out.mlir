module {
  spirv.func @forward() "None" {
    %cst0_i32 = spirv.Constant 0 : i32
    %cst32_i32 = spirv.Constant 32 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    spirv.mlir.loop {
      spirv.Branch ^bb1(%cst0_i32 : i32)
    ^bb1(%0: i32):  // 2 preds: ^bb0, ^bb2
      %1 = spirv.SLessThan %0, %cst32_i32 : i32
      spirv.BranchConditional %1, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %2 = spirv.IAdd %0, %0 : i32
      %3 = spirv.IAdd %0, %cst1_i32 : i32
      spirv.Branch ^bb1(%3 : i32)
    ^bb3:  // pred: ^bb1
      spirv.mlir.merge
    }
    spirv.Return
  }
}

