module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} {
  func.func @simple_loop(%arg0: i32, %arg1: i32, %arg2: i32) {
    spirv.Branch ^bb1
  ^bb1:  // pred: ^bb0
    spirv.Branch ^bb2(%arg0 : i32)
  ^bb2(%0: i32):  // 2 preds: ^bb1, ^bb3
    %1 = arith.cmpi slt, %0, %arg1 : i32
    spirv.BranchConditional %1, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    %2 = arith.addi %0, %arg2 : i32
    spirv.Branch ^bb2(%2 : i32)
  ^bb4:  // pred: ^bb2
    return
  }
}

// -----
module {
  func.func @main_graph(%arg0: index) {
    %0 = builtin.unrealized_conversion_cast %arg0 : index to i32
    %c1 = arith.constant 1 : index
    %1 = builtin.unrealized_conversion_cast %c1 : index to i32
    spirv.Branch ^bb1(%0 : i32)
  ^bb1(%2: i32):  // 2 preds: ^bb0, ^bb2
    %3 = builtin.unrealized_conversion_cast %2 : i32 to index
    %4 = arith.cmpi slt, %3, %c1 : index
    spirv.BranchConditional %4, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    spirv.Branch ^bb1(%1 : i32)
  ^bb3:  // pred: ^bb1
    return
  }
}

