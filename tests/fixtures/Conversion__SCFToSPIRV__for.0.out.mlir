module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
  spirv.func @loop_kernel(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>) "None" {
    %cst4_i32 = spirv.Constant 4 : i32
    %cst42_i32 = spirv.Constant 42 : i32
    %cst2_i32 = spirv.Constant 2 : i32
    spirv.mlir.loop {
      spirv.Branch ^bb1(%cst4_i32 : i32)
    ^bb1(%0: i32):  // 2 preds: ^bb0, ^bb2
      %1 = spirv.SLessThan %0, %cst42_i32 : i32
      spirv.BranchConditional %1, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %cst0_i32 = spirv.Constant 0 : i32
      %cst0_i32_0 = spirv.Constant 0 : i32
      %cst1_i32 = spirv.Constant 1 : i32
      %2 = spirv.AccessChain %arg0[%cst0_i32, %0] : !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %3 = spirv.Load "StorageBuffer" %2 : f32
      %cst0_i32_1 = spirv.Constant 0 : i32
      %cst0_i32_2 = spirv.Constant 0 : i32
      %cst1_i32_3 = spirv.Constant 1 : i32
      %4 = spirv.AccessChain %arg1[%cst0_i32_1, %0] : !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      spirv.Store "StorageBuffer" %4, %3 : f32
      %5 = spirv.IAdd %0, %cst2_i32 : i32
      spirv.Branch ^bb1(%5 : i32)
    ^bb3:  // pred: ^bb1
      spirv.mlir.merge
    }
    spirv.Return
  }
  spirv.func @unsigned_loop(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>) "None" {
    %cst4_i32 = spirv.Constant 4 : i32
    %cst42_i32 = spirv.Constant 42 : i32
    %cst2_i32 = spirv.Constant 2 : i32
    spirv.mlir.loop {
      spirv.Branch ^bb1(%cst4_i32 : i32)
    ^bb1(%0: i32):  // 2 preds: ^bb0, ^bb2
      %1 = spirv.ULessThan %0, %cst42_i32 : i32
      spirv.BranchConditional %1, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %cst0_i32 = spirv.Constant 0 : i32
      %cst0_i32_0 = spirv.Constant 0 : i32
      %cst1_i32 = spirv.Constant 1 : i32
      %2 = spirv.AccessChain %arg0[%cst0_i32, %0] : !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %3 = spirv.Load "StorageBuffer" %2 : f32
      %cst0_i32_1 = spirv.Constant 0 : i32
      %cst0_i32_2 = spirv.Constant 0 : i32
      %cst1_i32_3 = spirv.Constant 1 : i32
      %4 = spirv.AccessChain %arg1[%cst0_i32_1, %0] : !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      spirv.Store "StorageBuffer" %4, %3 : f32
      %5 = spirv.IAdd %0, %cst2_i32 : i32
      spirv.Branch ^bb1(%5 : i32)
    ^bb3:  // pred: ^bb1
      spirv.mlir.merge
    }
    spirv.Return
  }
  spirv.func @loop_yield(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>) "None" {
    %cst4_i32 = spirv.Constant 4 : i32
    %cst42_i32 = spirv.Constant 42 : i32
    %cst2_i32 = spirv.Constant 2 : i32
    %cst_f32 = spirv.Constant 0.000000e+00 : f32
    %cst_f32_0 = spirv.Constant 1.000000e+00 : f32
    %0 = spirv.Variable : !spirv.ptr<f32, Function>
    %1 = spirv.Variable : !spirv.ptr<f32, Function>
    spirv.mlir.loop {
      spirv.Branch ^bb1(%cst4_i32, %cst_f32, %cst_f32_0 : i32, f32, f32)
    ^bb1(%6: i32, %7: f32, %8: f32):  // 2 preds: ^bb0, ^bb2
      %9 = spirv.SLessThan %6, %cst42_i32 : i32
      spirv.BranchConditional %9, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %10 = spirv.FAdd %7, %7 : f32
      spirv.Store "Function" %0, %10 : f32
      spirv.Store "Function" %1, %10 : f32
      %11 = spirv.IAdd %6, %cst2_i32 : i32
      spirv.Branch ^bb1(%11, %10, %10 : i32, f32, f32)
    ^bb3:  // pred: ^bb1
      spirv.mlir.merge
    }
    %2 = spirv.Load "Function" %1 : f32
    %3 = spirv.Load "Function" %0 : f32
    %cst0_i32 = spirv.Constant 0 : i32
    %cst0_i32_1 = spirv.Constant 0 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %4 = spirv.AccessChain %arg1[%cst0_i32, %cst4_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
    spirv.Store "StorageBuffer" %4, %3 : f32
    %cst0_i32_2 = spirv.Constant 0 : i32
    %cst0_i32_3 = spirv.Constant 0 : i32
    %cst1_i32_4 = spirv.Constant 1 : i32
    %5 = spirv.AccessChain %arg1[%cst0_i32_2, %cst42_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
    spirv.Store "StorageBuffer" %5, %2 : f32
    spirv.Return
  }
}

