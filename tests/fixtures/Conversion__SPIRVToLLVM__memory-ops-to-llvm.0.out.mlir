module {
  llvm.func @access_chain() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.alloca %1 x !llvm.struct<packed (f32, array<4 x f32>)> : (i32) -> !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.getelementptr %2[%3, 1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.struct<packed (f32, array<4 x f32>)>
    llvm.return
  }
  llvm.func @access_chain_array(%arg0: i32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.array<4 x array<4 x f32>> : (i32) -> !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.getelementptr %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<4 x array<4 x f32>>
    %4 = llvm.load volatile %3 : !llvm.ptr -> !llvm.array<4 x f32>
    llvm.return
  }
  module {
    llvm.mlir.global external constant @var() {addr_space = 0 : i32} : f32
  }
  module {
    llvm.mlir.global private @struct() {addr_space = 0 : i32} : !llvm.struct<packed (f32, array<10 x f32>)>
    llvm.func @func() {
      %0 = llvm.mlir.addressof @struct : !llvm.ptr
      llvm.return
    }
  }
  module {
    llvm.mlir.global external @bar_descriptor_set0_binding0() {addr_space = 0 : i32} : i32
    llvm.func @foo() {
      %0 = llvm.mlir.addressof @bar_descriptor_set0_binding0 : !llvm.ptr
      llvm.return
    }
  }
  module @name {
    llvm.mlir.global external @name_bar_descriptor_set0_binding0() {addr_space = 0 : i32} : i32
    llvm.func @foo() {
      %0 = llvm.mlir.addressof @name_bar_descriptor_set0_binding0 : !llvm.ptr
      llvm.return
    }
  }
  module {
    llvm.mlir.global external @bar() {addr_space = 0 : i32, location = 1 : i32} : i32
    llvm.func @foo() {
      %0 = llvm.mlir.addressof @bar : !llvm.ptr
      llvm.return
    }
  }
  module {
    llvm.mlir.global external constant @bar() {addr_space = 0 : i32, location = 3 : i32} : f32
    llvm.func @foo() {
      %0 = llvm.mlir.addressof @bar : !llvm.ptr
      llvm.return
    }
  }
  llvm.func @load() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x f32 : (i32) -> !llvm.ptr
    %2 = llvm.load %1 : !llvm.ptr -> f32
    llvm.return
  }
  llvm.func @load_none() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x f32 : (i32) -> !llvm.ptr
    %2 = llvm.load %1 : !llvm.ptr -> f32
    llvm.return
  }
  llvm.func @load_with_alignment() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x f32 : (i32) -> !llvm.ptr
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> f32
    llvm.return
  }
  llvm.func @load_volatile() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x f32 : (i32) -> !llvm.ptr
    %2 = llvm.load volatile %1 : !llvm.ptr -> f32
    llvm.return
  }
  llvm.func @load_nontemporal() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x f32 : (i32) -> !llvm.ptr
    %2 = llvm.load %1 {nontemporal} : !llvm.ptr -> f32
    llvm.return
  }
  llvm.func @store(%arg0: f32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x f32 : (i32) -> !llvm.ptr
    llvm.store %arg0, %1 : f32, !llvm.ptr
    llvm.return
  }
  llvm.func @store_composite(%arg0: !llvm.struct<packed (f64)>) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.struct<packed (f64)> : (i32) -> !llvm.ptr
    llvm.store %arg0, %1 : !llvm.struct<packed (f64)>, !llvm.ptr
    llvm.return
  }
  llvm.func @store_with_alignment(%arg0: f32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x f32 : (i32) -> !llvm.ptr
    llvm.store %arg0, %1 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.return
  }
  llvm.func @store_volatile(%arg0: f32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x f32 : (i32) -> !llvm.ptr
    llvm.store volatile %arg0, %1 : f32, !llvm.ptr
    llvm.return
  }
  llvm.func @store_nontemporal(%arg0: f32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x f32 : (i32) -> !llvm.ptr
    llvm.store %arg0, %1 {nontemporal} : f32, !llvm.ptr
    llvm.return
  }
  llvm.func @variable_scalar() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x f32 : (i32) -> !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.alloca %2 x i8 : (i32) -> !llvm.ptr
    llvm.return
  }
  llvm.func @variable_scalar_with_initialization() {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.alloca %1 x i64 : (i32) -> !llvm.ptr
    llvm.store %0, %2 : i64, !llvm.ptr
    llvm.return
  }
  llvm.func @variable_vector() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x vector<3xf32> : (i32) -> !llvm.ptr
    llvm.return
  }
  llvm.func @variable_vector_with_initialization() {
    %0 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.alloca %1 x vector<3xi1> : (i32) -> !llvm.ptr
    llvm.store %0, %2 : vector<3xi1>, !llvm.ptr
    llvm.return
  }
  llvm.func @variable_array() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.array<10 x i32> : (i32) -> !llvm.ptr
    llvm.return
  }
}

