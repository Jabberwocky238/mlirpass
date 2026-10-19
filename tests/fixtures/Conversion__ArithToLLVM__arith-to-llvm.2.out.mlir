module {
  func.func @vector_ops(%arg0: vector<4xf32>, %arg1: vector<4xi1>, %arg2: vector<4xi64>, %arg3: vector<4xi64>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<4.200000e+01> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.fadd %arg0, %0 : vector<4xf32>
    %2 = llvm.sdiv %arg2, %arg2 : vector<4xi64>
    %3 = llvm.udiv %arg2, %arg2 : vector<4xi64>
    %4 = llvm.srem %arg2, %arg2 : vector<4xi64>
    %5 = llvm.urem %arg2, %arg2 : vector<4xi64>
    %6 = llvm.fdiv %arg0, %0 : vector<4xf32>
    %7 = llvm.frem %arg0, %0 : vector<4xf32>
    %8 = llvm.and %arg2, %arg3 : vector<4xi64>
    %9 = llvm.or %arg2, %arg3 : vector<4xi64>
    %10 = llvm.xor %arg2, %arg3 : vector<4xi64>
    %11 = llvm.shl %arg2, %arg2 : vector<4xi64>
    %12 = llvm.ashr %arg2, %arg2 : vector<4xi64>
    %13 = llvm.lshr %arg2, %arg2 : vector<4xi64>
    return %1 : vector<4xf32>
  }
}

// -----
module {
  func.func @ops(%arg0: f32, %arg1: f32, %arg2: i32, %arg3: i32, %arg4: f64) -> (f32, i32) {
    %0 = llvm.fsub %arg0, %arg1 : f32
    %1 = llvm.sub %arg2, %arg3 : i32
    %2 = llvm.icmp "slt" %arg2, %1 : i32
    %3 = llvm.icmp "sle" %arg2, %1 : i32
    %4 = llvm.icmp "sgt" %arg2, %1 : i32
    %5 = llvm.icmp "ult" %arg2, %1 : i32
    %6 = llvm.icmp "ule" %arg2, %1 : i32
    %7 = llvm.icmp "ugt" %arg2, %1 : i32
    %8 = llvm.icmp "eq" %arg2, %1 : i32
    %9 = llvm.sdiv %arg2, %arg3 : i32
    %10 = llvm.udiv %arg2, %arg3 : i32
    %11 = llvm.srem %arg2, %arg3 : i32
    %12 = llvm.urem %arg2, %arg3 : i32
    %13 = llvm.fdiv %arg0, %arg1 : f32
    %14 = llvm.frem %arg0, %arg1 : f32
    %15 = llvm.and %arg2, %arg3 : i32
    %16 = llvm.or %arg2, %arg3 : i32
    %17 = llvm.xor %arg2, %arg3 : i32
    %18 = llvm.mlir.constant(7.900000e-01 : f64) : f64
    %19 = llvm.shl %arg2, %arg3 : i32
    %20 = llvm.ashr %arg2, %arg3 : i32
    %21 = llvm.lshr %arg2, %arg3 : i32
    %cst = arith.constant 2.000000e+00 : tf32
    return %0, %10 : f32, i32
  }
}

// -----
module {
  func.func @index_cast(%arg0: index, %arg1: i1) {
    %0 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.sext %arg1 : i1 to i64
    return
  }
}

// -----
module {
  func.func @vector_index_cast(%arg0: vector<2xindex>, %arg1: vector<2xi1>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2xindex> to vector<2xi64>
    %1 = llvm.trunc %0 : vector<2xi64> to vector<2xi1>
    %2 = llvm.sext %arg1 : vector<2xi1> to vector<2xi64>
    return
  }
}

// -----
module {
  func.func @index_castui(%arg0: index, %arg1: i1) {
    %0 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.zext %arg1 : i1 to i64
    return
  }
}

// -----
module {
  func.func @vector_index_castui(%arg0: vector<2xindex>, %arg1: vector<2xi1>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2xindex> to vector<2xi64>
    %1 = llvm.trunc %0 : vector<2xi64> to vector<2xi1>
    %2 = llvm.zext %arg1 : vector<2xi1> to vector<2xi64>
    return
  }
}

// -----
module {
  func.func @sitofp(%arg0: i32, %arg1: i64) {
    %0 = llvm.sitofp %arg0 : i32 to f32
    %1 = llvm.sitofp %arg0 : i32 to f64
    %2 = llvm.sitofp %arg1 : i64 to f32
    %3 = llvm.sitofp %arg1 : i64 to f64
    return
  }
}

// -----
module {
  func.func @sitofp_vector(%arg0: vector<2xi16>, %arg1: vector<2xi32>, %arg2: vector<2xi64>) {
    %0 = llvm.sitofp %arg0 : vector<2xi16> to vector<2xf32>
    %1 = llvm.sitofp %arg0 : vector<2xi16> to vector<2xf64>
    %2 = llvm.sitofp %arg1 : vector<2xi32> to vector<2xf32>
    %3 = llvm.sitofp %arg1 : vector<2xi32> to vector<2xf64>
    %4 = llvm.sitofp %arg2 : vector<2xi64> to vector<2xf32>
    %5 = llvm.sitofp %arg2 : vector<2xi64> to vector<2xf64>
    return
  }
}

// -----
module {
  func.func @uitofp(%arg0: i32, %arg1: i64) {
    %0 = llvm.uitofp %arg0 : i32 to f32
    %1 = llvm.uitofp %arg0 : i32 to f64
    %2 = llvm.uitofp %arg1 : i64 to f32
    %3 = llvm.uitofp %arg1 : i64 to f64
    return
  }
}

// -----
module {
  func.func @fpext(%arg0: f16, %arg1: f32) {
    %0 = llvm.fpext %arg0 : f16 to f32
    %1 = llvm.fpext %arg0 : f16 to f64
    %2 = llvm.fpext %arg1 : f32 to f64
    return
  }
}

// -----
module {
  func.func @fpext_vector(%arg0: vector<2xf16>, %arg1: vector<2xf32>) {
    %0 = llvm.fpext %arg0 : vector<2xf16> to vector<2xf32>
    %1 = llvm.fpext %arg0 : vector<2xf16> to vector<2xf64>
    %2 = llvm.fpext %arg1 : vector<2xf32> to vector<2xf64>
    return
  }
}

// -----
module {
  func.func @fptosi(%arg0: f32, %arg1: f64) {
    %0 = llvm.fptosi %arg0 : f32 to i32
    %1 = llvm.fptosi %arg0 : f32 to i64
    %2 = llvm.fptosi %arg1 : f64 to i32
    %3 = llvm.fptosi %arg1 : f64 to i64
    return
  }
}

// -----
module {
  func.func @fptosi_vector(%arg0: vector<2xf16>, %arg1: vector<2xf32>, %arg2: vector<2xf64>) {
    %0 = llvm.fptosi %arg0 : vector<2xf16> to vector<2xi32>
    %1 = llvm.fptosi %arg0 : vector<2xf16> to vector<2xi64>
    %2 = llvm.fptosi %arg1 : vector<2xf32> to vector<2xi32>
    %3 = llvm.fptosi %arg1 : vector<2xf32> to vector<2xi64>
    %4 = llvm.fptosi %arg2 : vector<2xf64> to vector<2xi32>
    %5 = llvm.fptosi %arg2 : vector<2xf64> to vector<2xi64>
    return
  }
}

// -----
module {
  func.func @fptoui(%arg0: f32, %arg1: f64) {
    %0 = llvm.fptoui %arg0 : f32 to i32
    %1 = llvm.fptoui %arg0 : f32 to i64
    %2 = llvm.fptoui %arg1 : f64 to i32
    %3 = llvm.fptoui %arg1 : f64 to i64
    return
  }
}

// -----
module {
  func.func @fptoui_vector(%arg0: vector<2xf16>, %arg1: vector<2xf32>, %arg2: vector<2xf64>) {
    %0 = llvm.fptoui %arg0 : vector<2xf16> to vector<2xi32>
    %1 = llvm.fptoui %arg0 : vector<2xf16> to vector<2xi64>
    %2 = llvm.fptoui %arg1 : vector<2xf32> to vector<2xi32>
    %3 = llvm.fptoui %arg1 : vector<2xf32> to vector<2xi64>
    %4 = llvm.fptoui %arg2 : vector<2xf64> to vector<2xi32>
    %5 = llvm.fptoui %arg2 : vector<2xf64> to vector<2xi64>
    return
  }
}

// -----
module {
  func.func @uitofp_vector(%arg0: vector<2xi16>, %arg1: vector<2xi32>, %arg2: vector<2xi64>) {
    %0 = llvm.uitofp %arg0 : vector<2xi16> to vector<2xf32>
    %1 = llvm.uitofp %arg0 : vector<2xi16> to vector<2xf64>
    %2 = llvm.uitofp %arg1 : vector<2xi32> to vector<2xf32>
    %3 = llvm.uitofp %arg1 : vector<2xi32> to vector<2xf64>
    %4 = llvm.uitofp %arg2 : vector<2xi64> to vector<2xf32>
    %5 = llvm.uitofp %arg2 : vector<2xi64> to vector<2xf64>
    return
  }
}

// -----
module {
  func.func @fptrunc(%arg0: f32, %arg1: f64) {
    %0 = llvm.fptrunc %arg0 : f32 to f16
    %1 = llvm.fptrunc %arg1 : f64 to f16
    %2 = llvm.fptrunc %arg1 : f64 to f32
    return
  }
}

// -----
module {
  func.func @fptrunc_vector(%arg0: vector<2xf32>, %arg1: vector<2xf64>) {
    %0 = llvm.fptrunc %arg0 : vector<2xf32> to vector<2xf16>
    %1 = llvm.fptrunc %arg1 : vector<2xf64> to vector<2xf16>
    %2 = llvm.fptrunc %arg1 : vector<2xf64> to vector<2xf32>
    return
  }
}

// -----
module {
  func.func @experimental_constrained_fptrunc(%arg0: f64) {
    %0 = llvm.intr.experimental.constrained.fptrunc %arg0 tonearest ignore : f64 to f32
    %1 = llvm.intr.experimental.constrained.fptrunc %arg0 downward ignore : f64 to f32
    %2 = llvm.intr.experimental.constrained.fptrunc %arg0 upward ignore : f64 to f32
    %3 = llvm.intr.experimental.constrained.fptrunc %arg0 towardzero ignore : f64 to f32
    %4 = llvm.intr.experimental.constrained.fptrunc %arg0 tonearestaway ignore : f64 to f32
    return
  }
}

// -----
module {
  func.func @integer_extension_and_truncation(%arg0: i3) {
    %0 = llvm.sext %arg0 : i3 to i6
    %1 = llvm.zext %arg0 : i3 to i6
    %2 = llvm.trunc %arg0 : i3 to i2
    return
  }
}

// -----
module {
  func.func @integer_cast_0d_vector(%arg0: vector<i3>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<i3> to vector<1xi3>
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<i3> to vector<1xi3>
    %2 = builtin.unrealized_conversion_cast %arg0 : vector<i3> to vector<1xi3>
    %3 = llvm.sext %2 : vector<1xi3> to vector<1xi6>
    %4 = llvm.zext %1 : vector<1xi3> to vector<1xi6>
    %5 = llvm.trunc %0 : vector<1xi3> to vector<1xi2>
    return
  }
}

// -----
module {
  func.func @fcmp(%arg0: f32, %arg1: f32) {
    %0 = llvm.fcmp "oeq" %arg0, %arg1 : f32
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f32
    %2 = llvm.fcmp "oge" %arg0, %arg1 : f32
    %3 = llvm.fcmp "olt" %arg0, %arg1 : f32
    %4 = llvm.fcmp "ole" %arg0, %arg1 : f32
    %5 = llvm.fcmp "one" %arg0, %arg1 : f32
    %6 = llvm.fcmp "ord" %arg0, %arg1 : f32
    %7 = llvm.fcmp "ueq" %arg0, %arg1 : f32
    %8 = llvm.fcmp "ugt" %arg0, %arg1 : f32
    %9 = llvm.fcmp "uge" %arg0, %arg1 : f32
    %10 = llvm.fcmp "ult" %arg0, %arg1 : f32
    %11 = llvm.fcmp "ule" %arg0, %arg1 : f32
    %12 = llvm.fcmp "une" %arg0, %arg1 : f32
    %13 = llvm.fcmp "uno" %arg0, %arg1 : f32
    %14 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f32
    return
  }
}

// -----
module {
  func.func @index_vector(%arg0: vector<4xindex>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4xindex> to vector<4xi64>
    %1 = llvm.mlir.constant(dense<[0, 1, 2, 3]> : vector<4xindex>) : vector<4xi64>
    %2 = llvm.add %0, %1 : vector<4xi64>
    return
  }
}

// -----
module {
  func.func @bitcast_1d(%arg0: vector<2xf32>) {
    %0 = llvm.bitcast %arg0 : vector<2xf32> to vector<2xi32>
    return
  }
}

// -----
module {
  func.func @addui_extended_scalar(%arg0: i32, %arg1: i32) -> (i32, i1) {
    %0 = "llvm.intr.uadd.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(i32, i1)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i1)> 
    return %1, %2 : i32, i1
  }
  func.func @addui_extended_vector1d(%arg0: vector<3xi16>, %arg1: vector<3xi16>) -> (vector<3xi16>, vector<3xi1>) {
    %0 = "llvm.intr.uadd.with.overflow"(%arg0, %arg1) : (vector<3xi16>, vector<3xi16>) -> !llvm.struct<(vector<3xi16>, vector<3xi1>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(vector<3xi16>, vector<3xi1>)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(vector<3xi16>, vector<3xi1>)> 
    return %1, %2 : vector<3xi16>, vector<3xi1>
  }
}

// -----
module {
  func.func @mulsi_extended_scalar(%arg0: i32, %arg1: i32) -> (i32, i32) {
    %0 = llvm.sext %arg0 : i32 to i64
    %1 = llvm.sext %arg1 : i32 to i64
    %2 = llvm.mul %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.lshr %2, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %3, %6 : i32, i32
  }
  func.func @mulsi_extended_vector1d(%arg0: vector<3xi64>, %arg1: vector<3xi64>) -> (vector<3xi64>, vector<3xi64>) {
    %0 = llvm.sext %arg0 : vector<3xi64> to vector<3xi128>
    %1 = llvm.sext %arg1 : vector<3xi64> to vector<3xi128>
    %2 = llvm.mul %0, %1 : vector<3xi128>
    %3 = llvm.trunc %2 : vector<3xi128> to vector<3xi64>
    %4 = llvm.mlir.constant(dense<64> : vector<3xi128>) : vector<3xi128>
    %5 = llvm.lshr %2, %4 : vector<3xi128>
    %6 = llvm.trunc %5 : vector<3xi128> to vector<3xi64>
    return %3, %6 : vector<3xi64>, vector<3xi64>
  }
}

// -----
module {
  func.func @mului_extended_scalar(%arg0: i32, %arg1: i32) -> (i32, i32) {
    %0 = llvm.zext %arg0 : i32 to i64
    %1 = llvm.zext %arg1 : i32 to i64
    %2 = llvm.mul %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.lshr %2, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %3, %6 : i32, i32
  }
  func.func @mului_extended_vector1d(%arg0: vector<3xi64>, %arg1: vector<3xi64>) -> (vector<3xi64>, vector<3xi64>) {
    %0 = llvm.zext %arg0 : vector<3xi64> to vector<3xi128>
    %1 = llvm.zext %arg1 : vector<3xi64> to vector<3xi128>
    %2 = llvm.mul %0, %1 : vector<3xi128>
    %3 = llvm.trunc %2 : vector<3xi128> to vector<3xi64>
    %4 = llvm.mlir.constant(dense<64> : vector<3xi128>) : vector<3xi128>
    %5 = llvm.lshr %2, %4 : vector<3xi128>
    %6 = llvm.trunc %5 : vector<3xi128> to vector<3xi64>
    return %3, %6 : vector<3xi64>, vector<3xi64>
  }
}

// -----
module {
  func.func @cmpf_2dvector(%arg0: vector<4x3xf32>, %arg1: vector<4x3xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4x3xf32> to !llvm.array<4 x vector<3xf32>>
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<4x3xf32> to !llvm.array<4 x vector<3xf32>>
    %2 = llvm.mlir.poison : !llvm.array<4 x vector<3xi1>>
    %3 = llvm.extractvalue %1[0] : !llvm.array<4 x vector<3xf32>> 
    %4 = llvm.extractvalue %0[0] : !llvm.array<4 x vector<3xf32>> 
    %5 = llvm.fcmp "olt" %3, %4 : vector<3xf32>
    %6 = llvm.insertvalue %5, %2[0] : !llvm.array<4 x vector<3xi1>> 
    %7 = llvm.extractvalue %1[1] : !llvm.array<4 x vector<3xf32>> 
    %8 = llvm.extractvalue %0[1] : !llvm.array<4 x vector<3xf32>> 
    %9 = llvm.fcmp "olt" %7, %8 : vector<3xf32>
    %10 = llvm.insertvalue %9, %6[1] : !llvm.array<4 x vector<3xi1>> 
    %11 = llvm.extractvalue %1[2] : !llvm.array<4 x vector<3xf32>> 
    %12 = llvm.extractvalue %0[2] : !llvm.array<4 x vector<3xf32>> 
    %13 = llvm.fcmp "olt" %11, %12 : vector<3xf32>
    %14 = llvm.insertvalue %13, %10[2] : !llvm.array<4 x vector<3xi1>> 
    %15 = llvm.extractvalue %1[3] : !llvm.array<4 x vector<3xf32>> 
    %16 = llvm.extractvalue %0[3] : !llvm.array<4 x vector<3xf32>> 
    %17 = llvm.fcmp "olt" %15, %16 : vector<3xf32>
    %18 = llvm.insertvalue %17, %14[3] : !llvm.array<4 x vector<3xi1>> 
    return
  }
}

// -----
module {
  func.func @cmpi_0dvector(%arg0: vector<i32>, %arg1: vector<i32>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<i32> to vector<1xi32>
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<i32> to vector<1xi32>
    %2 = llvm.icmp "ult" %1, %0 : vector<1xi32>
    return
  }
}

// -----
module {
  func.func @cmpi_2dvector(%arg0: vector<4x3xi32>, %arg1: vector<4x3xi32>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4x3xi32> to !llvm.array<4 x vector<3xi32>>
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<4x3xi32> to !llvm.array<4 x vector<3xi32>>
    %2 = llvm.mlir.poison : !llvm.array<4 x vector<3xi1>>
    %3 = llvm.extractvalue %1[0] : !llvm.array<4 x vector<3xi32>> 
    %4 = llvm.extractvalue %0[0] : !llvm.array<4 x vector<3xi32>> 
    %5 = llvm.icmp "ult" %3, %4 : vector<3xi32>
    %6 = llvm.insertvalue %5, %2[0] : !llvm.array<4 x vector<3xi1>> 
    %7 = llvm.extractvalue %1[1] : !llvm.array<4 x vector<3xi32>> 
    %8 = llvm.extractvalue %0[1] : !llvm.array<4 x vector<3xi32>> 
    %9 = llvm.icmp "ult" %7, %8 : vector<3xi32>
    %10 = llvm.insertvalue %9, %6[1] : !llvm.array<4 x vector<3xi1>> 
    %11 = llvm.extractvalue %1[2] : !llvm.array<4 x vector<3xi32>> 
    %12 = llvm.extractvalue %0[2] : !llvm.array<4 x vector<3xi32>> 
    %13 = llvm.icmp "ult" %11, %12 : vector<3xi32>
    %14 = llvm.insertvalue %13, %10[2] : !llvm.array<4 x vector<3xi1>> 
    %15 = llvm.extractvalue %1[3] : !llvm.array<4 x vector<3xi32>> 
    %16 = llvm.extractvalue %0[3] : !llvm.array<4 x vector<3xi32>> 
    %17 = llvm.icmp "ult" %15, %16 : vector<3xi32>
    %18 = llvm.insertvalue %17, %14[3] : !llvm.array<4 x vector<3xi1>> 
    return
  }
}

// -----
module {
  func.func @select(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i32
    return %0 : i32
  }
  func.func @select_complex(%arg0: i1, %arg1: complex<f32>, %arg2: complex<f32>) -> complex<f32> {
    %0 = builtin.unrealized_conversion_cast %arg2 : complex<f32> to !llvm.struct<(f32, f32)>
    %1 = builtin.unrealized_conversion_cast %arg1 : complex<f32> to !llvm.struct<(f32, f32)>
    %2 = llvm.select %arg0, %1, %0 : i1, !llvm.struct<(f32, f32)>
    %3 = builtin.unrealized_conversion_cast %2 : !llvm.struct<(f32, f32)> to complex<f32>
    return %3 : complex<f32>
  }
}

// -----
module {
  func.func @ceildivsi(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.sdiv %arg0, %arg1 : i64
    %3 = llvm.mul %2, %arg1 : i64
    %4 = llvm.icmp "ne" %arg0, %3 : i64
    %5 = llvm.icmp "slt" %arg0, %0 : i64
    %6 = llvm.icmp "slt" %arg1, %0 : i64
    %7 = llvm.icmp "eq" %5, %6 : i1
    %8 = llvm.and %4, %7 : i1
    %9 = llvm.add %2, %1 : i64
    %10 = llvm.select %8, %9, %2 : i1, i64
    return %10 : i64
  }
  func.func @ceildivui(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.sub %arg0, %2 : i32
    %4 = llvm.udiv %3, %arg0 : i32
    %5 = llvm.add %4, %2 : i32
    %6 = llvm.select %1, %0, %5 : i1, i32
    return %6 : i32
  }
}

// -----
module {
  func.func @floordivsi(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.sdiv %arg0, %arg1 : i32
    %1 = llvm.mul %0, %arg1 : i32
    %2 = llvm.icmp "ne" %arg0, %1 : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.icmp "slt" %arg0, %3 : i32
    %5 = llvm.icmp "slt" %arg1, %3 : i32
    %6 = llvm.icmp "ne" %4, %5 : i1
    %7 = llvm.and %2, %6 : i1
    %8 = llvm.mlir.constant(-1 : i32) : i32
    %9 = llvm.add %0, %8 : i32
    %10 = llvm.select %7, %9, %0 : i1, i32
    return %10 : i32
  }
}

// -----
module {
  func.func @minmaxi(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.smin(%arg0, %arg1) : (i32, i32) -> i32
    %1 = llvm.intr.smax(%arg0, %arg1) : (i32, i32) -> i32
    %2 = llvm.intr.umin(%arg0, %arg1) : (i32, i32) -> i32
    %3 = llvm.intr.umax(%arg0, %arg1) : (i32, i32) -> i32
    return %0 : i32
  }
  func.func @minmaxf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.minimum(%arg0, %arg1) : (f32, f32) -> f32
    %1 = llvm.intr.maximum(%arg0, %arg1) : (f32, f32) -> f32
    %2 = llvm.intr.minnum(%arg0, %arg1) : (f32, f32) -> f32
    %3 = llvm.intr.maxnum(%arg0, %arg1) : (f32, f32) -> f32
    return %0 : f32
  }
}

// -----
module {
  func.func @fastmath(%arg0: f32, %arg1: f32, %arg2: i32) {
    %0 = llvm.fadd %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.fmul %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %2 = llvm.fneg %arg0 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.fadd %arg0, %arg1 : f32
    %4 = llvm.fadd %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, ninf>} : f32
    return
  }
}

// -----
module {
  func.func @ops_supporting_fastmath(%arg0: f32, %arg1: f32, %arg2: i32) {
    %0 = llvm.fadd %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.fdiv %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %2 = llvm.intr.maximum(%arg0, %arg1) {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32
    %3 = llvm.intr.minimum(%arg0, %arg1) {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32
    %4 = llvm.fmul %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %5 = llvm.fneg %arg0 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %6 = llvm.frem %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %7 = llvm.fsub %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f32
    return
  }
}

// -----
module {
  func.func @ops_supporting_overflow(%arg0: i64, %arg1: i64) {
    %0 = llvm.add %arg0, %arg1 overflow<nsw> : i64
    %1 = llvm.sub %arg0, %arg1 overflow<nuw> : i64
    %2 = llvm.mul %arg0, %arg1 overflow<nsw, nuw> : i64
    %3 = llvm.shl %arg0, %arg1 overflow<nsw, nuw> : i64
    %4 = llvm.trunc %arg0 overflow<nsw, nuw> : i64 to i32
    return
  }
}

// -----
module {
  func.func @ops_supporting_exact(%arg0: i32, %arg1: i32) {
    %0 = llvm.ashr exact %arg0, %arg1 : i32
    %1 = llvm.lshr exact %arg0, %arg1 : i32
    %2 = llvm.sdiv exact %arg0, %arg1 : i32
    %3 = llvm.udiv exact %arg0, %arg1 : i32
    return
  }
}

// -----
module {
  func.func @memref_bitcast(%arg0: memref<?xi16>) -> memref<?xbf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xi16> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = builtin.unrealized_conversion_cast %0 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<?xbf16>
    return %1 : memref<?xbf16>
  }
}

// -----
module {
  func.func @unsupported_fp_type(%arg0: f4E2M1FN, %arg1: vector<4xf4E2M1FN>, %arg2: vector<8x4xf4E2M1FN>, %arg3: f4E2M1FN, %arg4: i1) {
    %0 = builtin.unrealized_conversion_cast %arg3 : f4E2M1FN to i4
    %1 = builtin.unrealized_conversion_cast %arg0 : f4E2M1FN to i4
    %2 = arith.addf %arg0, %arg0 : f4E2M1FN
    %3 = arith.addf %arg1, %arg1 : vector<4xf4E2M1FN>
    %4 = arith.addf %arg2, %arg2 : vector<8x4xf4E2M1FN>
    %5 = arith.cmpf oeq, %arg0, %arg3 : f4E2M1FN
    %6 = llvm.select %arg4, %1, %0 : i1, i4
    return
  }
}

// -----
module {
  func.func @supported_fp_type(%arg0: f32, %arg1: vector<4xf32>, %arg2: vector<4x8xf32>, %arg3: f32) {
    %0 = builtin.unrealized_conversion_cast %arg2 : vector<4x8xf32> to !llvm.array<4 x vector<8xf32>>
    %1 = builtin.unrealized_conversion_cast %arg2 : vector<4x8xf32> to !llvm.array<4 x vector<8xf32>>
    %2 = llvm.fadd %arg0, %arg0 : f32
    %3 = llvm.fadd %arg1, %arg1 : vector<4xf32>
    %4 = llvm.mlir.poison : !llvm.array<4 x vector<8xf32>>
    %5 = llvm.extractvalue %1[0] : !llvm.array<4 x vector<8xf32>> 
    %6 = llvm.extractvalue %0[0] : !llvm.array<4 x vector<8xf32>> 
    %7 = llvm.fadd %5, %6 : vector<8xf32>
    %8 = llvm.insertvalue %7, %4[0] : !llvm.array<4 x vector<8xf32>> 
    %9 = llvm.extractvalue %1[1] : !llvm.array<4 x vector<8xf32>> 
    %10 = llvm.extractvalue %0[1] : !llvm.array<4 x vector<8xf32>> 
    %11 = llvm.fadd %9, %10 : vector<8xf32>
    %12 = llvm.insertvalue %11, %8[1] : !llvm.array<4 x vector<8xf32>> 
    %13 = llvm.extractvalue %1[2] : !llvm.array<4 x vector<8xf32>> 
    %14 = llvm.extractvalue %0[2] : !llvm.array<4 x vector<8xf32>> 
    %15 = llvm.fadd %13, %14 : vector<8xf32>
    %16 = llvm.insertvalue %15, %12[2] : !llvm.array<4 x vector<8xf32>> 
    %17 = llvm.extractvalue %1[3] : !llvm.array<4 x vector<8xf32>> 
    %18 = llvm.extractvalue %0[3] : !llvm.array<4 x vector<8xf32>> 
    %19 = llvm.fadd %17, %18 : vector<8xf32>
    %20 = llvm.insertvalue %19, %16[3] : !llvm.array<4 x vector<8xf32>> 
    %21 = llvm.fcmp "oeq" %arg0, %arg3 : f32
    return
  }
}

