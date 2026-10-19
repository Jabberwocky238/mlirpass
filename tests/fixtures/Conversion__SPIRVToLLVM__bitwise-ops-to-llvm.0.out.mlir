module {
  llvm.func @bitcount_scalar(%arg0: i16) {
    %0 = llvm.intr.ctpop(%arg0) : (i16) -> i16
    llvm.return
  }
  llvm.func @bitcount_vector(%arg0: vector<3xi32>) {
    %0 = llvm.intr.ctpop(%arg0) : (vector<3xi32>) -> vector<3xi32>
    llvm.return
  }
  llvm.func @bitreverse_scalar(%arg0: i64) {
    %0 = llvm.intr.bitreverse(%arg0) : (i64) -> i64
    llvm.return
  }
  llvm.func @bitreverse_vector(%arg0: vector<4xi32>) {
    %0 = llvm.intr.bitreverse(%arg0) : (vector<4xi32>) -> vector<4xi32>
    llvm.return
  }
  llvm.func @bitfield_insert_scalar_same_bit_width(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg3 : i32
    %2 = llvm.xor %1, %0 : i32
    %3 = llvm.shl %2, %arg2 : i32
    %4 = llvm.xor %3, %0 : i32
    %5 = llvm.and %arg0, %4 : i32
    %6 = llvm.shl %arg1, %arg2 : i32
    %7 = llvm.or %5, %6 : i32
    llvm.return
  }
  llvm.func @bitfield_insert_scalar_smaller_bit_width(%arg0: i64, %arg1: i64, %arg2: i8, %arg3: i8) {
    %0 = llvm.zext %arg2 : i8 to i64
    %1 = llvm.zext %arg3 : i8 to i64
    %2 = llvm.mlir.constant(-1 : i64) : i64
    %3 = llvm.shl %2, %1 : i64
    %4 = llvm.xor %3, %2 : i64
    %5 = llvm.shl %4, %0 : i64
    %6 = llvm.xor %5, %2 : i64
    %7 = llvm.and %arg0, %6 : i64
    %8 = llvm.shl %arg1, %0 : i64
    %9 = llvm.or %7, %8 : i64
    llvm.return
  }
  llvm.func @bitfield_insert_scalar_greater_bit_width(%arg0: i16, %arg1: i16, %arg2: i32, %arg3: i64) {
    %0 = llvm.trunc %arg2 : i32 to i16
    %1 = llvm.trunc %arg3 : i64 to i16
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.shl %2, %1 : i16
    %4 = llvm.xor %3, %2 : i16
    %5 = llvm.shl %4, %0 : i16
    %6 = llvm.xor %5, %2 : i16
    %7 = llvm.and %arg0, %6 : i16
    %8 = llvm.shl %arg1, %0 : i16
    %9 = llvm.or %7, %8 : i16
    llvm.return
  }
  llvm.func @bitfield_insert_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: i32, %arg3: i32) {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg2, %0[%1 : i32] : vector<2xi32>
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.insertelement %arg2, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.poison : vector<2xi32>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %arg3, %5[%6 : i32] : vector<2xi32>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %arg3, %7[%8 : i32] : vector<2xi32>
    %10 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %11 = llvm.shl %10, %9 : vector<2xi32>
    %12 = llvm.xor %11, %10 : vector<2xi32>
    %13 = llvm.shl %12, %4 : vector<2xi32>
    %14 = llvm.xor %13, %10 : vector<2xi32>
    %15 = llvm.and %arg0, %14 : vector<2xi32>
    %16 = llvm.shl %arg1, %4 : vector<2xi32>
    %17 = llvm.or %15, %16 : vector<2xi32>
    llvm.return
  }
  llvm.func @bitfield_sextract_scalar_same_bit_width(%arg0: i64, %arg1: i64, %arg2: i64) {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.add %arg2, %arg1 : i64
    %2 = llvm.sub %0, %1 : i64
    %3 = llvm.shl %arg0, %2 : i64
    %4 = llvm.add %arg1, %2 : i64
    %5 = llvm.ashr %3, %4 : i64
    llvm.return
  }
  llvm.func @bitfield_sextract_scalar_smaller_bit_width(%arg0: i32, %arg1: i8, %arg2: i8) {
    %0 = llvm.zext %arg1 : i8 to i32
    %1 = llvm.zext %arg2 : i8 to i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.add %1, %0 : i32
    %4 = llvm.sub %2, %3 : i32
    %5 = llvm.shl %arg0, %4 : i32
    %6 = llvm.add %0, %4 : i32
    %7 = llvm.ashr %5, %6 : i32
    llvm.return
  }
  llvm.func @bitfield_sextract_scalar_greater_bit_width(%arg0: i32, %arg1: i64, %arg2: i64) {
    %0 = llvm.trunc %arg1 : i64 to i32
    %1 = llvm.trunc %arg2 : i64 to i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.add %1, %0 : i32
    %4 = llvm.sub %2, %3 : i32
    %5 = llvm.shl %arg0, %4 : i32
    %6 = llvm.add %0, %4 : i32
    %7 = llvm.ashr %5, %6 : i32
    llvm.return
  }
  llvm.func @bitfield_sextract_vector(%arg0: vector<2xi32>, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg1, %0[%1 : i32] : vector<2xi32>
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.insertelement %arg1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.poison : vector<2xi32>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %arg2, %5[%6 : i32] : vector<2xi32>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %arg2, %7[%8 : i32] : vector<2xi32>
    %10 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %11 = llvm.add %9, %4 : vector<2xi32>
    %12 = llvm.sub %10, %11 : vector<2xi32>
    %13 = llvm.shl %arg0, %12 : vector<2xi32>
    %14 = llvm.add %4, %12 : vector<2xi32>
    %15 = llvm.ashr %13, %14 : vector<2xi32>
    llvm.return
  }
  llvm.func @bitfield_uextract_scalar_same_bit_width(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg2 : i32
    %2 = llvm.xor %1, %0 : i32
    %3 = llvm.lshr %arg0, %arg1 : i32
    %4 = llvm.and %3, %2 : i32
    llvm.return
  }
  llvm.func @bitfield_uextract_scalar_smaller_bit_width(%arg0: i32, %arg1: i16, %arg2: i8) {
    %0 = llvm.zext %arg1 : i16 to i32
    %1 = llvm.zext %arg2 : i8 to i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.shl %2, %1 : i32
    %4 = llvm.xor %3, %2 : i32
    %5 = llvm.lshr %arg0, %0 : i32
    %6 = llvm.and %5, %4 : i32
    llvm.return
  }
  llvm.func @bitfield_uextract_scalar_greater_bit_width(%arg0: i8, %arg1: i16, %arg2: i8) {
    %0 = llvm.trunc %arg1 : i16 to i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %1, %arg2 : i8
    %3 = llvm.xor %2, %1 : i8
    %4 = llvm.lshr %arg0, %0 : i8
    %5 = llvm.and %4, %3 : i8
    llvm.return
  }
  llvm.func @bitfield_uextract_vector(%arg0: vector<2xi32>, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg1, %0[%1 : i32] : vector<2xi32>
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.insertelement %arg1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.poison : vector<2xi32>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %arg2, %5[%6 : i32] : vector<2xi32>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %arg2, %7[%8 : i32] : vector<2xi32>
    %10 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %11 = llvm.shl %10, %9 : vector<2xi32>
    %12 = llvm.xor %11, %10 : vector<2xi32>
    %13 = llvm.lshr %arg0, %4 : vector<2xi32>
    %14 = llvm.and %13, %12 : vector<2xi32>
    llvm.return
  }
  llvm.func @bitwise_and_scalar(%arg0: i32, %arg1: i32) {
    %0 = llvm.and %arg0, %arg1 : i32
    llvm.return
  }
  llvm.func @bitwise_and_vector(%arg0: vector<4xi64>, %arg1: vector<4xi64>) {
    %0 = llvm.and %arg0, %arg1 : vector<4xi64>
    llvm.return
  }
  llvm.func @bitwise_or_scalar(%arg0: i64, %arg1: i64) {
    %0 = llvm.or %arg0, %arg1 : i64
    llvm.return
  }
  llvm.func @bitwise_or_vector(%arg0: vector<3xi8>, %arg1: vector<3xi8>) {
    %0 = llvm.or %arg0, %arg1 : vector<3xi8>
    llvm.return
  }
  llvm.func @bitwise_xor_scalar(%arg0: i32, %arg1: i32) {
    %0 = llvm.xor %arg0, %arg1 : i32
    llvm.return
  }
  llvm.func @bitwise_xor_vector(%arg0: vector<2xi16>, %arg1: vector<2xi16>) {
    %0 = llvm.xor %arg0, %arg1 : vector<2xi16>
    llvm.return
  }
  llvm.func @not_scalar(%arg0: i32) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0 : i32
    llvm.return
  }
  llvm.func @not_vector(%arg0: vector<2xi16>) {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.xor %arg0, %0 : vector<2xi16>
    llvm.return
  }
}

