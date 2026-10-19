module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
  spirv.func @while_loop1(%arg0: i32, %arg1: i32) -> i32 "None" {
    %cst2_i32 = spirv.Constant 2 : i32
    %0 = spirv.Variable : !spirv.ptr<i32, Function>
    spirv.mlir.loop {
      spirv.Branch ^bb1(%arg0 : i32)
    ^bb1(%2: i32):  // 2 preds: ^bb0, ^bb2
      %3 = spirv.SLessThan %2, %arg1 : i32
      spirv.Store "Function" %0, %2 : i32
      spirv.BranchConditional %3, ^bb2(%2 : i32), ^bb3
    ^bb2(%4: i32):  // pred: ^bb1
      %5 = spirv.IMul %4, %cst2_i32 : i32
      spirv.Branch ^bb1(%5 : i32)
    ^bb3:  // pred: ^bb1
      spirv.mlir.merge
    }
    %1 = spirv.Load "Function" %0 : i32
    spirv.ReturnValue %1 : i32
  }
  spirv.func @while_loop2(%arg0: f32) -> i64 "None" {
    %0 = spirv.Variable : !spirv.ptr<i64, Function>
    spirv.mlir.loop {
      spirv.Branch ^bb1(%arg0 : f32)
    ^bb1(%2: f32):  // 2 preds: ^bb0, ^bb2
      %3 = "foo.shared_compute"(%2) : (f32) -> i64
      %4 = "foo.evaluate_condition"(%2, %3) : (f32, i64) -> i1
      spirv.Store "Function" %0, %3 : i64
      spirv.BranchConditional %4, ^bb2(%3 : i64), ^bb3
    ^bb2(%5: i64):  // pred: ^bb1
      %6 = "foo.payload"(%5) : (i64) -> f32
      spirv.Branch ^bb1(%6 : f32)
    ^bb3:  // pred: ^bb1
      spirv.mlir.merge
    }
    %1 = spirv.Load "Function" %0 : i64
    spirv.ReturnValue %1 : i64
  }
  spirv.func @while_loop_before_typeconv(%arg0: i32) -> i64 "None" {
    %0 = spirv.Variable : !spirv.ptr<i64, Function>
    spirv.mlir.loop {
      spirv.Branch ^bb1(%arg0 : i32)
    ^bb1(%2: i32):  // 2 preds: ^bb0, ^bb2
      %3 = builtin.unrealized_conversion_cast %2 : i32 to index
      %4 = "foo.shared_compute"(%3) : (index) -> i64
      %5 = "foo.evaluate_condition"(%3, %4) : (index, i64) -> i1
      spirv.Store "Function" %0, %4 : i64
      spirv.BranchConditional %5, ^bb2(%4 : i64), ^bb3
    ^bb2(%6: i64):  // pred: ^bb1
      %7 = "foo.payload"(%6) : (i64) -> index
      %8 = builtin.unrealized_conversion_cast %7 : index to i32
      spirv.Branch ^bb1(%8 : i32)
    ^bb3:  // pred: ^bb1
      spirv.mlir.merge
    }
    %1 = spirv.Load "Function" %0 : i64
    spirv.ReturnValue %1 : i64
  }
  spirv.func @while_loop_after_typeconv(%arg0: f32) -> i32 "None" {
    %0 = spirv.Variable : !spirv.ptr<i32, Function>
    spirv.mlir.loop {
      spirv.Branch ^bb1(%arg0 : f32)
    ^bb1(%2: f32):  // 2 preds: ^bb0, ^bb2
      %3 = "foo.shared_compute"(%2) : (f32) -> index
      %4 = builtin.unrealized_conversion_cast %3 : index to i32
      %5 = "foo.evaluate_condition"(%2, %3) : (f32, index) -> i1
      spirv.Store "Function" %0, %4 : i32
      spirv.BranchConditional %5, ^bb2(%4 : i32), ^bb3
    ^bb2(%6: i32):  // pred: ^bb1
      %7 = builtin.unrealized_conversion_cast %6 : i32 to index
      %8 = "foo.payload"(%7) : (index) -> f32
      spirv.Branch ^bb1(%8 : f32)
    ^bb3:  // pred: ^bb1
      spirv.mlir.merge
    }
    %1 = spirv.Load "Function" %0 : i32
    spirv.ReturnValue %1 : i32
  }
}

