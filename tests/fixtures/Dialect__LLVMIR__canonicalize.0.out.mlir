module {
  llvm.func @fold_icmp_eq(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }
}

// -----
module {
  llvm.func @fold_icmp_ne(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }
}

// -----
module {
  llvm.func @fold_icmp_alloca() -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }
}

// -----
module {
  llvm.func @fold_extractvalue() -> i32 {
    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    %0 = llvm.add %c0_i32, %c1_i32 : i32
    llvm.return %0 : i32
  }
}

// -----
module {
  llvm.func @fold_extractvalue(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    llvm.return %arg0 : i32
  }
}

// -----
module {
  llvm.func @no_fold_extractvalue(%arg0: !llvm.array<4 x f32>) -> f32 {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = llvm.mlir.undef : !llvm.array<4 x array<4 x f32>>
    %1 = llvm.insertvalue %cst, %0[0, 0] : !llvm.array<4 x array<4 x f32>> 
    %2 = llvm.insertvalue %arg0, %1[0] : !llvm.array<4 x array<4 x f32>> 
    %3 = llvm.extractvalue %2[0, 0] : !llvm.array<4 x array<4 x f32>> 
    llvm.return %3 : f32
  }
}

// -----
module {
  llvm.func @fold_unrelated_extractvalue(%arg0: !llvm.array<4 x f32>) -> f32 {
    %0 = llvm.extractvalue %arg0[1] : !llvm.array<4 x f32> 
    llvm.return %0 : f32
  }
}

// -----
module {
  llvm.func @fold_extract_extractvalue(%arg0: !llvm.struct<(i64, array<1 x ptr<1>>)>) -> !llvm.ptr<1> {
    %0 = llvm.extractvalue %arg0[1, 0] : !llvm.struct<(i64, array<1 x ptr<1>>)> 
    llvm.return %0 : !llvm.ptr<1>
  }
}

// -----
module {
  llvm.func @fold_extract_const_array() -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    llvm.return %0 : f64
  }
}

// -----
module {
  llvm.func @fold_extract_const_struct() -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    llvm.return %0 : i32
  }
}

// -----
module {
  llvm.func @fold_extract_splat() -> f64 {
    %0 = llvm.mlir.constant(-8.900000e+01 : f64) : f64
    llvm.return %0 : f64
  }
}

// -----
module {
  llvm.func @fold_extract_splat_nested() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.return %0 : i32
  }
}

// -----
module {
  llvm.func @fold_extract_sparse() -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fadd %0, %1 : f32
    llvm.return %2 : f32
  }
}

// -----
module {
  llvm.func @fold_zero() -> i32 {
    %0 = llvm.mlir.zero : i32
    llvm.return %0 : i32
  }
}

// -----
module {
  llvm.func @use_struct(!llvm.struct<(i16, i32)>)
  llvm.func @fold_undef() -> i32 {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.undef : !llvm.struct<(i16, i32)>
    llvm.call @use_struct(%1) : (!llvm.struct<(i16, i32)>) -> ()
    llvm.return %0 : i32
  }
}

// -----
module {
  llvm.func @use_array(!llvm.array<8 x f32>)
  llvm.func @fold_poison() -> f32 {
    %0 = llvm.mlir.poison : f32
    %1 = llvm.mlir.poison : !llvm.array<8 x f32>
    llvm.call @use_array(%1) : (!llvm.array<8 x f32>) -> ()
    llvm.return %0 : f32
  }
}

// -----
module {
  llvm.func @fold_bitcast(%arg0: !llvm.ptr) -> !llvm.ptr {
    llvm.return %arg0 : !llvm.ptr
  }
}

// -----
module {
  llvm.func @fold_bitcast2(%arg0: i32) -> i32 {
    llvm.return %arg0 : i32
  }
}

// -----
module {
  llvm.func @fold_bitcast_chain(%arg0: i32) -> vector<2xi16> {
    %0 = llvm.bitcast %arg0 : i32 to vector<2xi16>
    llvm.return %0 : vector<2xi16>
  }
}

// -----
module {
  llvm.func @fold_addrcast(%arg0: !llvm.ptr) -> !llvm.ptr {
    llvm.return %arg0 : !llvm.ptr
  }
}

// -----
module {
  llvm.func @fold_addrcast2(%arg0: !llvm.ptr) -> !llvm.ptr {
    llvm.return %arg0 : !llvm.ptr
  }
}

// -----
module {
  llvm.func @fold_addrcast_chain(%arg0: !llvm.ptr) -> !llvm.ptr<2> {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<2>
    llvm.return %0 : !llvm.ptr<2>
  }
}

// -----
module {
  llvm.func @fold_gep(%arg0: !llvm.ptr) -> !llvm.ptr {
    llvm.return %arg0 : !llvm.ptr
  }
}

// -----
module {
  llvm.func @fold_gep_neg(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.getelementptr inbounds %arg0[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.struct<(i32, i32)>
    llvm.return %0 : !llvm.ptr
  }
}

// -----
module {
  llvm.func @fold_gep_canon(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.getelementptr %arg0[2] : (!llvm.ptr) -> !llvm.ptr, i8
    llvm.return %0 : !llvm.ptr
  }
}

// -----
module {
  llvm.func @fold_shufflevector(%arg0: vector<1xf32>, %arg1: vector<1xf32>) -> vector<1xf32> {
    llvm.return %arg0 : vector<1xf32>
  }
}

// -----
module {
  llvm.func @llvm_constant() -> i32 {
    %c82_i32 = arith.constant 82 : i32
    llvm.return %c82_i32 : i32
  }
}

// -----
module {
  llvm.func @load_dce(%arg0: !llvm.ptr) {
    llvm.return
  }
}

// -----
module {
  llvm.mlir.global external @fp() {addr_space = 0 : i32} : !llvm.ptr
  llvm.func @addr_dce(%arg0: !llvm.ptr) {
    llvm.return
  }
}

// -----
module {
  llvm.func @alloca_dce() {
    llvm.return
  }
}

// -----
module {
  llvm.func @volatile_load(%arg0: !llvm.ptr) {
    %0 = llvm.load volatile %arg0 : !llvm.ptr -> i8
    %1 = llvm.load %arg0 atomic monotonic {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.return
  }
}

// -----
module {
  llvm.func @inline_asm_side_effects(%arg0: i32) {
    llvm.inline_asm has_side_effects "inline asm with side effects", "r" %arg0 : (i32) -> ()
    llvm.return
  }
}

