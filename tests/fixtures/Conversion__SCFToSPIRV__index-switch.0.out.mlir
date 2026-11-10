module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
  spirv.func @switch_no_result(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg1: i32) "None" {
    %cst_f32 = spirv.Constant 0.000000e+00 : f32
    %cst0_i32 = spirv.Constant 0 : i32
    spirv.mlir.selection {
      spirv.Switch %arg1 : i32, [
        default: ^bb2,
        2: ^bb1
      ]
    ^bb1:  // pred: ^bb0
      %cst0_i32_0 = spirv.Constant 0 : i32
      %cst0_i32_1 = spirv.Constant 0 : i32
      %cst1_i32 = spirv.Constant 1 : i32
      %0 = spirv.AccessChain %arg0[%cst0_i32_0, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      spirv.Store "StorageBuffer" %0, %cst_f32 : f32
      spirv.Branch ^bb3
    ^bb2:  // pred: ^bb0
      spirv.Branch ^bb3
    ^bb3:  // 2 preds: ^bb1, ^bb2
      spirv.mlir.merge
    }
    spirv.Return
  }
  spirv.func @switch_yield(%arg0: i32) -> i32 "None" {
    %0 = spirv.Variable : !spirv.ptr<i32, Function>
    spirv.mlir.selection {
      spirv.Switch %arg0 : i32, [
        default: ^bb3,
        2: ^bb1,
        5: ^bb2
      ]
    ^bb1:  // pred: ^bb0
      %cst10_i32 = spirv.Constant 10 : i32
      spirv.Store "Function" %0, %cst10_i32 : i32
      spirv.Branch ^bb4
    ^bb2:  // pred: ^bb0
      %cst20_i32 = spirv.Constant 20 : i32
      spirv.Store "Function" %0, %cst20_i32 : i32
      spirv.Branch ^bb4
    ^bb3:  // pred: ^bb0
      %cst30_i32 = spirv.Constant 30 : i32
      spirv.Store "Function" %0, %cst30_i32 : i32
      spirv.Branch ^bb4
    ^bb4:  // 3 preds: ^bb1, ^bb2, ^bb3
      spirv.mlir.merge
    }
    %1 = spirv.Load "Function" %0 : i32
    spirv.ReturnValue %1 : i32
  }
  spirv.func @switch_selection_control(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg1: i32) "None" {
    %cst_f32 = spirv.Constant 0.000000e+00 : f32
    %cst0_i32 = spirv.Constant 0 : i32
    spirv.mlir.selection control(Flatten) {
      spirv.Switch %arg1 : i32, [
        default: ^bb2,
        2: ^bb1
      ]
    ^bb1:  // pred: ^bb0
      %cst0_i32_0 = spirv.Constant 0 : i32
      %cst0_i32_1 = spirv.Constant 0 : i32
      %cst1_i32 = spirv.Constant 1 : i32
      %0 = spirv.AccessChain %arg0[%cst0_i32_0, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      spirv.Store "StorageBuffer" %0, %cst_f32 : f32
      spirv.Branch ^bb3
    ^bb2:  // pred: ^bb0
      spirv.Branch ^bb3
    ^bb3:  // 2 preds: ^bb1, ^bb2
      spirv.mlir.merge
    }
    spirv.Return
  }
}

