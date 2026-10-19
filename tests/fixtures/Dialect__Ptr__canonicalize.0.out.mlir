module {
  func.func @zero_offset(%arg0: !ptr.ptr<#ptr.generic_space>) -> !ptr.ptr<#ptr.generic_space> {
    return %arg0 : !ptr.ptr<#ptr.generic_space>
  }
  func.func @test_from_ptr_0(%arg0: memref<f32, #ptr.generic_space>) -> memref<f32, #ptr.generic_space> {
    return %arg0 : memref<f32, #ptr.generic_space>
  }
  func.func @test_from_ptr_1(%arg0: memref<f32, #ptr.generic_space>) -> memref<f32, #ptr.generic_space> {
    %0 = ptr.to_ptr %arg0 : memref<f32, #ptr.generic_space> -> <#ptr.generic_space>
    %1 = ptr.from_ptr %0 : <#ptr.generic_space> -> memref<f32, #ptr.generic_space>
    return %1 : memref<f32, #ptr.generic_space>
  }
  func.func @test_from_ptr_2(%arg0: memref<f32, #ptr.generic_space>, %arg1: !ptr.ptr_metadata<memref<f32, #ptr.generic_space>>) -> memref<f32, #ptr.generic_space> {
    %0 = ptr.to_ptr %arg0 : memref<f32, #ptr.generic_space> -> <#ptr.generic_space>
    %1 = ptr.from_ptr %0 metadata %arg1 : <#ptr.generic_space> -> memref<f32, #ptr.generic_space>
    return %1 : memref<f32, #ptr.generic_space>
  }
  func.func @test_from_ptr_3(%arg0: memref<f32, #ptr.generic_space>) -> memref<f32, #ptr.generic_space> {
    return %arg0 : memref<f32, #ptr.generic_space>
  }
  func.func @test_to_ptr_0(%arg0: !ptr.ptr<#ptr.generic_space>, %arg1: !ptr.ptr_metadata<memref<f32, #ptr.generic_space>>) -> !ptr.ptr<#ptr.generic_space> {
    return %arg0 : !ptr.ptr<#ptr.generic_space>
  }
  func.func @test_to_ptr_1(%arg0: !ptr.ptr<#ptr.generic_space>) -> !ptr.ptr<#ptr.generic_space> {
    return %arg0 : !ptr.ptr<#ptr.generic_space>
  }
  func.func @test_to_ptr_2(%arg0: !ptr.ptr<#ptr.generic_space>) -> !ptr.ptr<#ptr.generic_space> {
    return %arg0 : !ptr.ptr<#ptr.generic_space>
  }
  func.func @test_cast_chain_folding(%arg0: memref<f32, #ptr.generic_space>, %arg1: !ptr.ptr_metadata<memref<f32, #ptr.generic_space>>) -> memref<f32, #ptr.generic_space> {
    return %arg0 : memref<f32, #ptr.generic_space>
  }
}

