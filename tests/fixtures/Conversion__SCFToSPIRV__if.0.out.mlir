module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
  spirv.func @kernel_simple_selection(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg1: i1) "None" {
    %cst_f32 = spirv.Constant 0.000000e+00 : f32
    %cst0_i32 = spirv.Constant 0 : i32
    spirv.mlir.selection {
      spirv.BranchConditional %arg1, ^bb1, ^bb2
    ^bb1:  // pred: ^bb0
      %cst0_i32_0 = spirv.Constant 0 : i32
      %cst0_i32_1 = spirv.Constant 0 : i32
      %cst1_i32 = spirv.Constant 1 : i32
      %0 = spirv.AccessChain %arg0[%cst0_i32_0, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      spirv.Store "StorageBuffer" %0, %cst_f32 : f32
      spirv.Branch ^bb2
    ^bb2:  // 2 preds: ^bb0, ^bb1
      spirv.mlir.merge
    }
    spirv.Return
  }
  spirv.func @kernel_nested_selection(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg2: i1, %arg3: i1) "None" {
    %cst0_i32 = spirv.Constant 0 : i32
    %cst9_i32 = spirv.Constant 9 : i32
    spirv.mlir.selection {
      spirv.BranchConditional %arg2, ^bb1, ^bb2
    ^bb1:  // pred: ^bb0
      spirv.mlir.selection {
        spirv.BranchConditional %arg3, ^bb1, ^bb2
      ^bb1:  // pred: ^bb0
        %cst0_i32_0 = spirv.Constant 0 : i32
        %cst0_i32_1 = spirv.Constant 0 : i32
        %cst1_i32 = spirv.Constant 1 : i32
        %0 = spirv.AccessChain %arg0[%cst0_i32_0, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
        %1 = spirv.Load "StorageBuffer" %0 : f32
        %cst0_i32_2 = spirv.Constant 0 : i32
        %cst0_i32_3 = spirv.Constant 0 : i32
        %cst1_i32_4 = spirv.Constant 1 : i32
        %2 = spirv.AccessChain %arg1[%cst0_i32_2, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
        spirv.Store "StorageBuffer" %2, %1 : f32
        spirv.Branch ^bb3
      ^bb2:  // pred: ^bb0
        %cst0_i32_5 = spirv.Constant 0 : i32
        %cst0_i32_6 = spirv.Constant 0 : i32
        %cst1_i32_7 = spirv.Constant 1 : i32
        %3 = spirv.AccessChain %arg1[%cst0_i32_5, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
        %4 = spirv.Load "StorageBuffer" %3 : f32
        %cst0_i32_8 = spirv.Constant 0 : i32
        %cst0_i32_9 = spirv.Constant 0 : i32
        %cst1_i32_10 = spirv.Constant 1 : i32
        %5 = spirv.AccessChain %arg0[%cst0_i32_8, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
        spirv.Store "StorageBuffer" %5, %4 : f32
        spirv.Branch ^bb3
      ^bb3:  // 2 preds: ^bb1, ^bb2
        spirv.mlir.merge
      }
      spirv.Branch ^bb3
    ^bb2:  // pred: ^bb0
      spirv.mlir.selection {
        spirv.BranchConditional %arg3, ^bb1, ^bb2
      ^bb1:  // pred: ^bb0
        %cst0_i32_0 = spirv.Constant 0 : i32
        %cst0_i32_1 = spirv.Constant 0 : i32
        %cst1_i32 = spirv.Constant 1 : i32
        %0 = spirv.AccessChain %arg0[%cst0_i32_0, %cst9_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
        %1 = spirv.Load "StorageBuffer" %0 : f32
        %cst0_i32_2 = spirv.Constant 0 : i32
        %cst0_i32_3 = spirv.Constant 0 : i32
        %cst1_i32_4 = spirv.Constant 1 : i32
        %2 = spirv.AccessChain %arg1[%cst0_i32_2, %cst9_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
        spirv.Store "StorageBuffer" %2, %1 : f32
        spirv.Branch ^bb3
      ^bb2:  // pred: ^bb0
        %cst0_i32_5 = spirv.Constant 0 : i32
        %cst0_i32_6 = spirv.Constant 0 : i32
        %cst1_i32_7 = spirv.Constant 1 : i32
        %3 = spirv.AccessChain %arg1[%cst0_i32_5, %cst9_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
        %4 = spirv.Load "StorageBuffer" %3 : f32
        %cst0_i32_8 = spirv.Constant 0 : i32
        %cst0_i32_9 = spirv.Constant 0 : i32
        %cst1_i32_10 = spirv.Constant 1 : i32
        %5 = spirv.AccessChain %arg0[%cst0_i32_8, %cst9_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
        spirv.Store "StorageBuffer" %5, %4 : f32
        spirv.Branch ^bb3
      ^bb3:  // 2 preds: ^bb1, ^bb2
        spirv.mlir.merge
      }
      spirv.Branch ^bb3
    ^bb3:  // 2 preds: ^bb1, ^bb2
      spirv.mlir.merge
    }
    spirv.Return
  }
  spirv.func @simple_if_yield(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg1: i1) "None" {
    %0 = spirv.Variable : !spirv.ptr<f32, Function>
    %1 = spirv.Variable : !spirv.ptr<f32, Function>
    spirv.mlir.selection {
      spirv.BranchConditional %arg1, ^bb1, ^bb2
    ^bb1:  // pred: ^bb0
      %cst_f32 = spirv.Constant 0.000000e+00 : f32
      %cst_f32_6 = spirv.Constant 1.000000e+00 : f32
      spirv.Store "Function" %0, %cst_f32 : f32
      spirv.Store "Function" %1, %cst_f32_6 : f32
      spirv.Branch ^bb3
    ^bb2:  // pred: ^bb0
      %cst_f32_7 = spirv.Constant 2.000000e+00 : f32
      %cst_f32_8 = spirv.Constant 3.000000e+00 : f32
      spirv.Store "Function" %0, %cst_f32_8 : f32
      spirv.Store "Function" %1, %cst_f32_7 : f32
      spirv.Branch ^bb3
    ^bb3:  // 2 preds: ^bb1, ^bb2
      spirv.mlir.merge
    }
    %2 = spirv.Load "Function" %1 : f32
    %3 = spirv.Load "Function" %0 : f32
    %cst0_i32 = spirv.Constant 0 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %cst0_i32_0 = spirv.Constant 0 : i32
    %cst0_i32_1 = spirv.Constant 0 : i32
    %cst1_i32_2 = spirv.Constant 1 : i32
    %4 = spirv.AccessChain %arg0[%cst0_i32_0, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
    spirv.Store "StorageBuffer" %4, %3 : f32
    %cst0_i32_3 = spirv.Constant 0 : i32
    %cst0_i32_4 = spirv.Constant 0 : i32
    %cst1_i32_5 = spirv.Constant 1 : i32
    %5 = spirv.AccessChain %arg0[%cst0_i32_3, %cst1_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
    spirv.Store "StorageBuffer" %5, %2 : f32
    spirv.Return
  }
  spirv.func @simple_if_yield_type_change(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg2: i1) "None" {
    %cst0_i32 = spirv.Constant 0 : i32
    %cst_f32 = spirv.Constant 0.000000e+00 : f32
    %0 = spirv.Variable : !spirv.ptr<!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, Function>
    spirv.mlir.selection {
      spirv.BranchConditional %arg2, ^bb1, ^bb2
    ^bb1:  // pred: ^bb0
      spirv.Store "Function" %0, %arg0 : !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>
      spirv.Branch ^bb3
    ^bb2:  // pred: ^bb0
      spirv.Store "Function" %0, %arg1 : !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>
      spirv.Branch ^bb3
    ^bb3:  // 2 preds: ^bb1, ^bb2
      spirv.mlir.merge
    }
    %1 = spirv.Load "Function" %0 : !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>
    %cst0_i32_0 = spirv.Constant 0 : i32
    %cst0_i32_1 = spirv.Constant 0 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %2 = spirv.AccessChain %1[%cst0_i32_0, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
    spirv.Store "StorageBuffer" %2, %cst_f32 : f32
    spirv.Return
  }
  func.func @unsupported_yield_type(%arg0: memref<8xi32>, %arg1: memref<8xi32>, %arg2: i1) {
    %0 = scf.if %arg2 -> (memref<8xi32>) {
      scf.yield %arg0 : memref<8xi32>
    } else {
      scf.yield %arg1 : memref<8xi32>
    }
    spirv.Return
  }
}

