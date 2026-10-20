module {
  llvm.func @memset() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %2 = llvm.mlir.constant(42 : i8) : i8
    %3 = llvm.mlir.constant(16 : i32) : i32
    %4 = llvm.mlir.constant(4 : i32) : i32
    "llvm.intr.memset"(%1, %2, %4) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %5 = llvm.load %1 : !llvm.ptr -> i32
    llvm.return %5 : i32
  }
}

// -----
module {
  llvm.func @memset_inline() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %2 = llvm.mlir.constant(42 : i8) : i8
    "llvm.intr.memset.inline"(%1, %2) <{isVolatile = false, len = 4 : i64}> : (!llvm.ptr, i8) -> ()
    %3 = llvm.load %1 : !llvm.ptr -> i32
    llvm.return %3 : i32
  }
}

// -----
module {
  llvm.func @memset_partial() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %2 = llvm.mlir.constant(42 : i8) : i8
    %3 = llvm.mlir.constant(6 : i32) : i32
    %4 = llvm.mlir.constant(2 : i32) : i32
    "llvm.intr.memset"(%1, %2, %4) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %5 = llvm.load %1 : !llvm.ptr -> i32
    llvm.return %5 : i32
  }
}

// -----
module {
  llvm.func @memset_inline_partial() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %2 = llvm.mlir.constant(42 : i8) : i8
    "llvm.intr.memset.inline"(%1, %2) <{isVolatile = false, len = 2 : i64}> : (!llvm.ptr, i8) -> ()
    %3 = llvm.load %1 : !llvm.ptr -> i32
    llvm.return %3 : i32
  }
}

// -----
module {
  llvm.func @memset_full() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %2 = llvm.mlir.constant(42 : i8) : i8
    %3 = llvm.mlir.constant(40 : i32) : i32
    %4 = llvm.mlir.constant(4 : i32) : i32
    "llvm.intr.memset"(%1, %2, %4) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %5 = llvm.load %1 : !llvm.ptr -> i32
    llvm.return %5 : i32
  }
}

// -----
module {
  llvm.func @memset_inline_full() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %2 = llvm.mlir.constant(42 : i8) : i8
    "llvm.intr.memset.inline"(%1, %2) <{isVolatile = false, len = 4 : i64}> : (!llvm.ptr, i8) -> ()
    %3 = llvm.load %1 : !llvm.ptr -> i32
    llvm.return %3 : i32
  }
}

// -----
module {
  llvm.func @memset_too_much() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.array<10 x i32> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.mlir.constant(42 : i8) : i8
    %3 = llvm.mlir.constant(41 : i32) : i32
    "llvm.intr.memset"(%1, %2, %3) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %4 = llvm.getelementptr %1[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<10 x i32>
    %5 = llvm.load %4 : !llvm.ptr -> i32
    llvm.return %5 : i32
  }
}

// -----
module {
  llvm.func @memset_inline_too_much() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.array<10 x i32> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.mlir.constant(42 : i8) : i8
    "llvm.intr.memset.inline"(%1, %2) <{isVolatile = false, len = 41 : i64}> : (!llvm.ptr, i8) -> ()
    %3 = llvm.getelementptr %1[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<10 x i32>
    %4 = llvm.load %3 : !llvm.ptr -> i32
    llvm.return %4 : i32
  }
}

// -----
module {
  llvm.func @memset_no_volatile() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.array<10 x i32> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.mlir.constant(42 : i8) : i8
    %3 = llvm.mlir.constant(16 : i32) : i32
    "llvm.intr.memset"(%1, %2, %3) <{isVolatile = true}> : (!llvm.ptr, i8, i32) -> ()
    %4 = llvm.getelementptr %1[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<10 x i32>
    %5 = llvm.load %4 : !llvm.ptr -> i32
    llvm.return %5 : i32
  }
}

// -----
module {
  llvm.func @memset_inline_no_volatile() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.array<10 x i32> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.mlir.constant(42 : i8) : i8
    "llvm.intr.memset.inline"(%1, %2) <{isVolatile = true, len = 16 : i64}> : (!llvm.ptr, i8) -> ()
    %3 = llvm.getelementptr %1[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<10 x i32>
    %4 = llvm.load %3 : !llvm.ptr -> i32
    llvm.return %4 : i32
  }
}

// -----
module {
  llvm.func @indirect_memset() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %2 = llvm.mlir.constant(42 : i8) : i8
    %3 = llvm.mlir.constant(4 : i32) : i32
    "llvm.intr.memset"(%1, %2, %3) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %4 = llvm.load %1 : !llvm.ptr -> i32
    llvm.return %4 : i32
  }
}

// -----
module {
  llvm.func @indirect_memset_inline() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %2 = llvm.mlir.constant(42 : i8) : i8
    "llvm.intr.memset.inline"(%1, %2) <{isVolatile = false, len = 4 : i64}> : (!llvm.ptr, i8) -> ()
    %3 = llvm.load %1 : !llvm.ptr -> i32
    llvm.return %3 : i32
  }
}

// -----
module {
  llvm.func @invalid_indirect_memset() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.struct<"foo", (i32, i32)> : (i32) -> !llvm.ptr
    %2 = llvm.mlir.constant(42 : i8) : i8
    %3 = llvm.mlir.constant(6 : i32) : i32
    %4 = llvm.getelementptr %1[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.struct<"foo", (i32, i32)>
    "llvm.intr.memset"(%4, %2, %3) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %5 = llvm.load %4 : !llvm.ptr -> i32
    llvm.return %5 : i32
  }
}

// -----
module {
  llvm.func @invalid_indirect_memset_inline() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.struct<"foo", (i32, i32)> : (i32) -> !llvm.ptr
    %2 = llvm.mlir.constant(42 : i8) : i8
    %3 = llvm.getelementptr %1[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.struct<"foo", (i32, i32)>
    "llvm.intr.memset.inline"(%3, %2) <{isVolatile = false, len = 6 : i64}> : (!llvm.ptr, i8) -> ()
    %4 = llvm.load %3 : !llvm.ptr -> i32
    llvm.return %4 : i32
  }
}

// -----
module {
  llvm.func @memset_double_use() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x f32 : (i32) -> !llvm.ptr
    %2 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %3 = llvm.mlir.constant(42 : i8) : i8
    %4 = llvm.mlir.constant(8 : i32) : i32
    %5 = llvm.mlir.constant(4 : i32) : i32
    "llvm.intr.memset"(%2, %3, %5) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %6 = llvm.mlir.constant(4 : i32) : i32
    "llvm.intr.memset"(%1, %3, %6) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %7 = llvm.load %2 : !llvm.ptr -> i32
    %8 = llvm.load %1 : !llvm.ptr -> f32
    %9 = llvm.bitcast %8 : f32 to i32
    %10 = llvm.add %7, %9 : i32
    llvm.return %10 : i32
  }
}

// -----
module {
  llvm.func @memset_inline_double_use() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x f32 : (i32) -> !llvm.ptr
    %2 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %3 = llvm.mlir.constant(42 : i8) : i8
    "llvm.intr.memset.inline"(%2, %3) <{isVolatile = false, len = 4 : i64}> : (!llvm.ptr, i8) -> ()
    "llvm.intr.memset.inline"(%1, %3) <{isVolatile = false, len = 4 : i64}> : (!llvm.ptr, i8) -> ()
    %4 = llvm.load %2 : !llvm.ptr -> i32
    %5 = llvm.load %1 : !llvm.ptr -> f32
    %6 = llvm.bitcast %5 : f32 to i32
    %7 = llvm.add %4, %6 : i32
    llvm.return %7 : i32
  }
}

// -----
module {
  llvm.func @memset_considers_alignment() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x f32 : (i32) -> !llvm.ptr
    %2 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %3 = llvm.mlir.constant(42 : i8) : i8
    %4 = llvm.mlir.constant(8 : i32) : i32
    %5 = llvm.mlir.constant(4 : i32) : i32
    "llvm.intr.memset"(%2, %3, %5) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %6 = llvm.load %2 : !llvm.ptr -> i32
    %7 = llvm.load %1 : !llvm.ptr -> f32
    %8 = llvm.bitcast %7 : f32 to i32
    %9 = llvm.add %6, %8 : i32
    llvm.return %9 : i32
  }
}

// -----
module {
  llvm.func @memset_inline_considers_alignment() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x f32 : (i32) -> !llvm.ptr
    %2 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %3 = llvm.mlir.constant(42 : i8) : i8
    "llvm.intr.memset.inline"(%2, %3) <{isVolatile = false, len = 4 : i64}> : (!llvm.ptr, i8) -> ()
    %4 = llvm.load %2 : !llvm.ptr -> i32
    %5 = llvm.load %1 : !llvm.ptr -> f32
    %6 = llvm.bitcast %5 : f32 to i32
    %7 = llvm.add %4, %6 : i32
    llvm.return %7 : i32
  }
}

// -----
module {
  llvm.func @memset_considers_packing() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x f32 : (i32) -> !llvm.ptr
    %2 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %3 = llvm.mlir.constant(42 : i8) : i8
    %4 = llvm.mlir.constant(8 : i32) : i32
    %5 = llvm.mlir.constant(4 : i32) : i32
    "llvm.intr.memset"(%2, %3, %5) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %6 = llvm.mlir.constant(3 : i32) : i32
    "llvm.intr.memset"(%1, %3, %6) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %7 = llvm.load %2 : !llvm.ptr -> i32
    %8 = llvm.load %1 : !llvm.ptr -> f32
    %9 = llvm.bitcast %8 : f32 to i32
    %10 = llvm.add %7, %9 : i32
    llvm.return %10 : i32
  }
}

// -----
module {
  llvm.func @memset_inline_considers_packing() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x f32 : (i32) -> !llvm.ptr
    %2 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %3 = llvm.mlir.constant(42 : i8) : i8
    "llvm.intr.memset.inline"(%2, %3) <{isVolatile = false, len = 4 : i64}> : (!llvm.ptr, i8) -> ()
    "llvm.intr.memset.inline"(%1, %3) <{isVolatile = false, len = 3 : i64}> : (!llvm.ptr, i8) -> ()
    %4 = llvm.load %2 : !llvm.ptr -> i32
    %5 = llvm.load %1 : !llvm.ptr -> f32
    %6 = llvm.bitcast %5 : f32 to i32
    %7 = llvm.add %4, %6 : i32
    llvm.return %7 : i32
  }
}

// -----
module {
  llvm.func @memcpy_dest(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %2 = llvm.mlir.constant(40 : i32) : i32
    %3 = llvm.getelementptr %arg0[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<10 x i32>
    %4 = llvm.mlir.constant(4 : i32) : i32
    "llvm.intr.memcpy"(%1, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %5 = llvm.load %1 : !llvm.ptr -> i32
    llvm.return %5 : i32
  }
}

// -----
module {
  llvm.func @memcpy_src(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %2 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %3 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %4 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %5 = llvm.mlir.constant(16 : i32) : i32
    %6 = llvm.getelementptr %arg0[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    %7 = llvm.mlir.constant(4 : i32) : i32
    "llvm.intr.memcpy"(%6, %4, %7) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %8 = llvm.getelementptr %arg0[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    %9 = llvm.mlir.constant(4 : i32) : i32
    "llvm.intr.memcpy"(%8, %1, %9) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %10 = llvm.getelementptr %arg0[0, 2] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    %11 = llvm.mlir.constant(4 : i32) : i32
    "llvm.intr.memcpy"(%10, %3, %11) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %12 = llvm.getelementptr %arg0[0, 3] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    %13 = llvm.mlir.constant(4 : i32) : i32
    "llvm.intr.memcpy"(%12, %2, %13) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %14 = llvm.load %1 : !llvm.ptr -> i32
    llvm.return %14 : i32
  }
}

// -----
module {
  llvm.func @memcpy_double() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %2 = llvm.alloca %0 x !llvm.array<1 x i32> : (i32) -> !llvm.ptr
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.getelementptr %2[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<1 x i32>
    %5 = llvm.mlir.constant(4 : i32) : i32
    "llvm.intr.memcpy"(%1, %4, %5) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %6 = llvm.load %1 : !llvm.ptr -> i32
    llvm.return %6 : i32
  }
}

// -----
module {
  llvm.func @memcpy_no_partial(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.array<10 x i32> : (i32) -> !llvm.ptr
    %2 = llvm.mlir.constant(21 : i32) : i32
    "llvm.intr.memcpy"(%1, %arg0, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %3 = llvm.getelementptr %1[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<10 x i32>
    %4 = llvm.load %3 : !llvm.ptr -> i32
    llvm.return %4 : i32
  }
}

// -----
module {
  llvm.func @memcpy_no_volatile(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.array<10 x i32> : (i32) -> !llvm.ptr
    %2 = llvm.mlir.constant(40 : i32) : i32
    "llvm.intr.memcpy"(%1, %arg0, %2) <{isVolatile = true}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %3 = llvm.getelementptr %1[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<10 x i32>
    %4 = llvm.load %3 : !llvm.ptr -> i32
    llvm.return %4 : i32
  }
}

// -----
module {
  llvm.func @memmove_dest(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %2 = llvm.mlir.constant(40 : i32) : i32
    %3 = llvm.getelementptr %arg0[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<10 x i32>
    %4 = llvm.mlir.constant(4 : i32) : i32
    "llvm.intr.memmove"(%1, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %5 = llvm.load %1 : !llvm.ptr -> i32
    llvm.return %5 : i32
  }
}

// -----
module {
  llvm.func @memmove_src(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %2 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %3 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %4 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %5 = llvm.mlir.constant(16 : i32) : i32
    %6 = llvm.getelementptr %arg0[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    %7 = llvm.mlir.constant(4 : i32) : i32
    "llvm.intr.memmove"(%6, %4, %7) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %8 = llvm.getelementptr %arg0[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    %9 = llvm.mlir.constant(4 : i32) : i32
    "llvm.intr.memmove"(%8, %1, %9) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %10 = llvm.getelementptr %arg0[0, 2] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    %11 = llvm.mlir.constant(4 : i32) : i32
    "llvm.intr.memmove"(%10, %2, %11) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %12 = llvm.getelementptr %arg0[0, 3] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    %13 = llvm.mlir.constant(4 : i32) : i32
    "llvm.intr.memmove"(%12, %3, %13) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %14 = llvm.load %1 : !llvm.ptr -> i32
    llvm.return %14 : i32
  }
}

// -----
module {
  llvm.func @memcpy_inline_dest(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %2 = llvm.getelementptr %arg0[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<10 x i32>
    "llvm.intr.memcpy.inline"(%1, %2) <{isVolatile = false, len = 4 : i32}> : (!llvm.ptr, !llvm.ptr) -> ()
    %3 = llvm.load %1 : !llvm.ptr -> i32
    llvm.return %3 : i32
  }
}

// -----
module {
  llvm.func @memcpy_inline_src(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %2 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %3 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %4 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    %5 = llvm.getelementptr %arg0[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    "llvm.intr.memcpy.inline"(%5, %4) <{isVolatile = false, len = 4 : i32}> : (!llvm.ptr, !llvm.ptr) -> ()
    %6 = llvm.getelementptr %arg0[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    "llvm.intr.memcpy.inline"(%6, %1) <{isVolatile = false, len = 4 : i32}> : (!llvm.ptr, !llvm.ptr) -> ()
    %7 = llvm.getelementptr %arg0[0, 2] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    "llvm.intr.memcpy.inline"(%7, %2) <{isVolatile = false, len = 4 : i32}> : (!llvm.ptr, !llvm.ptr) -> ()
    %8 = llvm.getelementptr %arg0[0, 3] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    "llvm.intr.memcpy.inline"(%8, %3) <{isVolatile = false, len = 4 : i32}> : (!llvm.ptr, !llvm.ptr) -> ()
    %9 = llvm.load %1 : !llvm.ptr -> i32
    llvm.return %9 : i32
  }
}

