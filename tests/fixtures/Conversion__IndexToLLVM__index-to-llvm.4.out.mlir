module {
  func.func @trivial_ops(%arg0: index, %arg1: index) {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %3 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %4 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %5 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %6 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %7 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %8 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %9 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %10 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %11 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %12 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %13 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %14 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %15 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %16 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %17 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %18 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %19 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %20 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %21 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %22 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %23 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %24 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %25 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %26 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %27 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %28 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %29 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %30 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %31 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %32 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %33 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %34 = llvm.add %33, %32 : i64
    %35 = llvm.sub %31, %30 : i64
    %36 = llvm.mul %29, %28 : i64
    %37 = llvm.sdiv %27, %26 : i64
    %38 = llvm.udiv %25, %24 : i64
    %39 = llvm.srem %23, %22 : i64
    %40 = llvm.urem %21, %20 : i64
    %41 = llvm.intr.smax(%19, %18) : (i64, i64) -> i64
    %42 = llvm.intr.umax(%17, %16) : (i64, i64) -> i64
    %43 = llvm.intr.smin(%15, %14) : (i64, i64) -> i64
    %44 = llvm.intr.umin(%13, %12) : (i64, i64) -> i64
    %45 = llvm.shl %11, %10 : i64
    %46 = llvm.ashr %9, %8 : i64
    %47 = llvm.lshr %7, %6 : i64
    %48 = llvm.add %5, %4 : i64
    %49 = llvm.or %3, %2 : i64
    %50 = llvm.xor %1, %0 : i64
    %51 = llvm.mlir.constant(true) : i1
    return
  }
  func.func @ceildivs(%arg0: index, %arg1: index) -> index {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(-1 : i64) : i64
    %5 = llvm.icmp "sgt" %0, %2 : i64
    %6 = llvm.select %5, %4, %3 : i1, i64
    %7 = llvm.add %1, %6 : i64
    %8 = llvm.sdiv %7, %0 : i64
    %9 = llvm.add %8, %3 : i64
    %10 = llvm.sub %2, %1 : i64
    %11 = llvm.sdiv %10, %0 : i64
    %12 = llvm.sub %2, %11 : i64
    %13 = llvm.icmp "sgt" %1, %2 : i64
    %14 = llvm.icmp "eq" %13, %5 : i1
    %15 = llvm.icmp "ne" %1, %2 : i64
    %16 = llvm.and %14, %15 : i1
    %17 = llvm.select %16, %9, %12 : i1, i64
    %18 = builtin.unrealized_conversion_cast %17 : i64 to index
    return %18 : index
  }
  func.func @ceildivu(%arg0: index, %arg1: index) -> index {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.sub %1, %3 : i64
    %5 = llvm.udiv %4, %0 : i64
    %6 = llvm.add %5, %3 : i64
    %7 = llvm.icmp "eq" %1, %2 : i64
    %8 = llvm.select %7, %2, %6 : i1, i64
    %9 = builtin.unrealized_conversion_cast %8 : i64 to index
    return %9 : index
  }
  func.func @floordivs(%arg0: index, %arg1: index) -> index {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(-1 : i64) : i64
    %5 = llvm.icmp "slt" %0, %2 : i64
    %6 = llvm.select %5, %3, %4 : i1, i64
    %7 = llvm.sub %6, %1 : i64
    %8 = llvm.sdiv %7, %0 : i64
    %9 = llvm.sub %4, %8 : i64
    %10 = llvm.sdiv %1, %0 : i64
    %11 = llvm.icmp "slt" %1, %2 : i64
    %12 = llvm.icmp "ne" %11, %5 : i1
    %13 = llvm.icmp "ne" %1, %2 : i64
    %14 = llvm.and %12, %13 : i1
    %15 = llvm.select %14, %9, %10 : i1, i64
    %16 = builtin.unrealized_conversion_cast %15 : i64 to index
    return %16 : index
  }
  func.func @index_cast_from(%arg0: index) -> (i64, i32, i64, i32) {
    %0 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %3 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %4 = llvm.trunc %2 : i64 to i32
    %5 = llvm.trunc %0 : i64 to i32
    return %3, %4, %1, %5 : i64, i32, i64, i32
  }
  func.func @index_cast_to(%arg0: i32, %arg1: i64) -> (index, index, index, index) {
    %0 = builtin.unrealized_conversion_cast %arg1 : i64 to index
    %1 = builtin.unrealized_conversion_cast %arg1 : i64 to index
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = builtin.unrealized_conversion_cast %2 : i64 to index
    %4 = llvm.zext %arg0 : i32 to i64
    %5 = builtin.unrealized_conversion_cast %4 : i64 to index
    return %3, %1, %5, %0 : index, index, index, index
  }
  func.func @index_sizeof() {
    %0 = llvm.mlir.constant(64 : i64) : i64
    return
  }
  func.func @index_constant() {
    %0 = llvm.mlir.constant(-2100000000 : i64) : i64
    %1 = llvm.mlir.constant(2100000000 : i64) : i64
    %2 = llvm.mlir.constant(-3000000000 : i64) : i64
    %3 = llvm.mlir.constant(3000000000 : i64) : i64
    return
  }
}

