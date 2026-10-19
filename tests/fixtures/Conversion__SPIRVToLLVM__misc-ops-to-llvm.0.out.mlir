module {
  llvm.func @composite_extract_array(%arg0: !llvm.array<4 x array<4 x f32>>) {
    %0 = llvm.extractvalue %arg0[1, 3] : !llvm.array<4 x array<4 x f32>> 
    llvm.return
  }
  llvm.func @composite_extract_vector(%arg0: vector<3xf32>) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.extractelement %arg0[%0 : i32] : vector<3xf32>
    llvm.return
  }
  llvm.func @composite_insert_struct(%arg0: i32, %arg1: !llvm.struct<packed (f32, array<4 x i32>)>) {
    %0 = llvm.insertvalue %arg0, %arg1[1, 3] : !llvm.struct<packed (f32, array<4 x i32>)> 
    llvm.return
  }
  llvm.func @composite_insert_vector(%arg0: vector<3xf32>, %arg1: f32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.insertelement %arg1, %arg0[%0 : i32] : vector<3xf32>
    llvm.return
  }
  llvm.func @select_scalar(%arg0: i1, %arg1: vector<3xi32>, %arg2: vector<3xi32>, %arg3: f32, %arg4: f32) {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, vector<3xi32>
    %1 = llvm.select %arg0, %arg3, %arg4 : i1, f32
    llvm.return
  }
  llvm.func @select_vector(%arg0: vector<2xi1>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) {
    %0 = llvm.select %arg0, %arg1, %arg2 : vector<2xi1>, vector<2xi32>
    llvm.return
  }
  llvm.func @vector_shuffle_same_size(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<3xf32> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 2, -1] : vector<2xf32> 
    llvm.return %0 : vector<3xf32>
  }
  llvm.func @vector_shuffle_different_size(%arg0: vector<3xf32>, %arg1: vector<2xf32>) -> vector<3xf32> {
    %0 = llvm.mlir.poison : vector<3xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %arg0[%2 : i32] : vector<3xf32>
    %4 = llvm.insertelement %3, %0[%1 : i32] : vector<3xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.extractelement %arg1[%6 : i32] : vector<2xf32>
    %8 = llvm.insertelement %7, %4[%5 : i32] : vector<3xf32>
    llvm.return %8 : vector<3xf32>
  }
  module {
    llvm.mlir.global external constant @__spv__empty_execution_mode_info_31() {addr_space = 0 : i32} : !llvm.struct<(i32)> {
      %0 = llvm.mlir.poison : !llvm.struct<(i32)>
      %1 = llvm.mlir.constant(31 : i32) : i32
      %2 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32)> 
      llvm.return %2 : !llvm.struct<(i32)>
    }
    llvm.func @empty() {
      llvm.return
    }
  }
  module {
    llvm.mlir.global external constant @__spv__bar_execution_mode_info_18() {addr_space = 0 : i32} : !llvm.struct<(i32, array<3 x i32>)> {
      %0 = llvm.mlir.poison : !llvm.struct<(i32, array<3 x i32>)>
      %1 = llvm.mlir.constant(18 : i32) : i32
      %2 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, array<3 x i32>)> 
      %3 = llvm.mlir.constant(32 : i32) : i32
      %4 = llvm.insertvalue %3, %2[1, 0] : !llvm.struct<(i32, array<3 x i32>)> 
      %5 = llvm.mlir.constant(1 : i32) : i32
      %6 = llvm.insertvalue %5, %4[1, 1] : !llvm.struct<(i32, array<3 x i32>)> 
      %7 = llvm.mlir.constant(1 : i32) : i32
      %8 = llvm.insertvalue %7, %6[1, 2] : !llvm.struct<(i32, array<3 x i32>)> 
      llvm.return %8 : !llvm.struct<(i32, array<3 x i32>)>
    }
    llvm.mlir.global external constant @__spv__bar_execution_mode_info_31() {addr_space = 0 : i32} : !llvm.struct<(i32)> {
      %0 = llvm.mlir.poison : !llvm.struct<(i32)>
      %1 = llvm.mlir.constant(31 : i32) : i32
      %2 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32)> 
      llvm.return %2 : !llvm.struct<(i32)>
    }
    llvm.func @bar() {
      llvm.return
    }
  }
  llvm.func @undef_scalar() {
    %0 = llvm.mlir.undef : f32
    llvm.return
  }
  llvm.func @undef_vector() {
    %0 = llvm.mlir.undef : vector<2xi32>
    llvm.return
  }
}

