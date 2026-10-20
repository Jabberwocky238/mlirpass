module {
  llvm.func @basic_memset(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.shl %2, %3 : i32
    %5 = llvm.or %2, %4 : i32
    %6 = llvm.mlir.constant(16 : i32) : i32
    %7 = llvm.shl %5, %6 : i32
    %8 = llvm.or %5, %7 : i32
    llvm.return %8 : i32
  }
}

// -----
module {
  llvm.func @memset_float(%arg0: i8) -> f32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.shl %2, %3 : i32
    %5 = llvm.or %2, %4 : i32
    %6 = llvm.mlir.constant(16 : i32) : i32
    %7 = llvm.shl %5, %6 : i32
    %8 = llvm.or %5, %7 : i32
    %9 = llvm.bitcast %8 : i32 to f32
    llvm.return %9 : f32
  }
}

// -----
module {
  llvm.func @basic_memset_inline(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.shl %1, %2 : i32
    %4 = llvm.or %1, %3 : i32
    %5 = llvm.mlir.constant(16 : i32) : i32
    %6 = llvm.shl %4, %5 : i32
    %7 = llvm.or %4, %6 : i32
    llvm.return %7 : i32
  }
}

// -----
module {
  llvm.func @basic_memset_constant() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(707406378 : i32) : i32
    llvm.return %3 : i32
  }
}

// -----
module {
  llvm.func @memset_one_byte_constant() -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.mlir.constant(42 : i8) : i8
    llvm.return %2 : i8
  }
}

// -----
module {
  llvm.func @basic_memset_inline_constant() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.mlir.constant(707406378 : i32) : i32
    llvm.return %2 : i32
  }
}

// -----
module {
  llvm.func @exotic_target_memset(%arg0: i8) -> i40 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.zext %arg0 : i8 to i40
    %3 = llvm.mlir.constant(8 : i40) : i40
    %4 = llvm.shl %2, %3 : i40
    %5 = llvm.or %2, %4 : i40
    %6 = llvm.mlir.constant(16 : i40) : i40
    %7 = llvm.shl %5, %6 : i40
    %8 = llvm.or %5, %7 : i40
    %9 = llvm.mlir.constant(32 : i40) : i40
    %10 = llvm.shl %8, %9 : i40
    %11 = llvm.or %8, %10 : i40
    llvm.return %11 : i40
  }
}

// -----
module {
  llvm.func @exotic_target_memset_inline(%arg0: i8) -> i40 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i40
    %2 = llvm.mlir.constant(8 : i40) : i40
    %3 = llvm.shl %1, %2 : i40
    %4 = llvm.or %1, %3 : i40
    %5 = llvm.mlir.constant(16 : i40) : i40
    %6 = llvm.shl %4, %5 : i40
    %7 = llvm.or %4, %6 : i40
    %8 = llvm.mlir.constant(32 : i40) : i40
    %9 = llvm.shl %7, %8 : i40
    %10 = llvm.or %7, %9 : i40
    llvm.return %10 : i40
  }
}

// -----
module {
  llvm.func @no_volatile_memset() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.mlir.constant(42 : i8) : i8
    %3 = llvm.mlir.constant(4 : i32) : i32
    "llvm.intr.memset"(%1, %2, %3) <{isVolatile = true}> : (!llvm.ptr, i8, i32) -> ()
    %4 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %4 : i32
  }
}

// -----
module {
  llvm.func @no_volatile_memset_inline() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.mlir.constant(42 : i8) : i8
    "llvm.intr.memset.inline"(%1, %2) <{isVolatile = true, len = 4 : i64}> : (!llvm.ptr, i8) -> ()
    %3 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %3 : i32
  }
}

// -----
module {
  llvm.func @no_partial_memset() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.mlir.constant(42 : i8) : i8
    %3 = llvm.mlir.constant(2 : i32) : i32
    "llvm.intr.memset"(%1, %2, %3) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %4 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %4 : i32
  }
}

// -----
module {
  llvm.func @no_partial_memset_inline() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.mlir.constant(42 : i8) : i8
    "llvm.intr.memset.inline"(%1, %2) <{isVolatile = false, len = 2 : i64}> : (!llvm.ptr, i8) -> ()
    %3 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %3 : i32
  }
}

// -----
module {
  llvm.func @no_overflowing_memset() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.mlir.constant(42 : i8) : i8
    %3 = llvm.mlir.constant(6 : i32) : i32
    "llvm.intr.memset"(%1, %2, %3) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %4 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %4 : i32
  }
}

// -----
module {
  llvm.func @no_overflowing_memset_inline() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.mlir.constant(42 : i8) : i8
    "llvm.intr.memset.inline"(%1, %2) <{isVolatile = false, len = 6 : i64}> : (!llvm.ptr, i8) -> ()
    %3 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %3 : i32
  }
}

// -----
module {
  llvm.func @only_byte_aligned_integers_memset() -> i10 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i10 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.mlir.constant(42 : i8) : i8
    %3 = llvm.mlir.constant(2 : i32) : i32
    "llvm.intr.memset"(%1, %2, %3) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %4 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i10
    llvm.return %4 : i10
  }
}

// -----
module {
  llvm.func @only_byte_aligned_integers_memset_inline() -> i10 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i10 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.mlir.constant(42 : i8) : i8
    "llvm.intr.memset.inline"(%1, %2) <{isVolatile = false, len = 2 : i64}> : (!llvm.ptr, i8) -> ()
    %3 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i10
    llvm.return %3 : i10
  }
}

// -----
module {
  llvm.func @basic_memcpy(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.load %arg0 : !llvm.ptr -> i32
    llvm.return %3 : i32
  }
}

// -----
module {
  llvm.func @basic_memcpy_dest(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(4 : i32) : i32
    llvm.store %1, %arg0 : i32, !llvm.ptr
    llvm.return %1 : i32
  }
}

// -----
module {
  llvm.func @double_memcpy() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(4 : i32) : i32
    llvm.return %1 : i32
  }
}

// -----
module {
  llvm.func @ignore_self_memcpy() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%3, %3, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %4 = llvm.load %3 : !llvm.ptr -> i32
    llvm.return %4 : i32
  }
}

// -----
module {
  llvm.func @ignore_partial_memcpy(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%3, %arg0, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %4 = llvm.load %3 : !llvm.ptr -> i32
    llvm.return %4 : i32
  }
}

// -----
module {
  llvm.func @ignore_volatile_memcpy(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%3, %arg0, %2) <{isVolatile = true}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %4 = llvm.load %3 : !llvm.ptr -> i32
    llvm.return %4 : i32
  }
}

// -----
module {
  llvm.func @basic_memmove(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.load %arg0 : !llvm.ptr -> i32
    llvm.return %3 : i32
  }
}

// -----
module {
  llvm.func @basic_memcpy_inline(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.load %arg0 : !llvm.ptr -> i32
    llvm.return %2 : i32
  }
}

