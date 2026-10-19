module {
  llvm.func @check_noalias(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: i64, %arg8: i64, %arg9: i64) {
    llvm.return
  }
}

// -----
module {
  llvm.func @check_strided_memref_arguments(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: !llvm.ptr, %arg8: !llvm.ptr, %arg9: i64, %arg10: i64, %arg11: i64, %arg12: i64, %arg13: i64, %arg14: !llvm.ptr, %arg15: !llvm.ptr, %arg16: i64, %arg17: i64, %arg18: i64, %arg19: i64, %arg20: i64) {
    llvm.return
  }
}

// -----
module {
  llvm.func @memref_index(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.insertvalue %arg4, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.return %5 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  }
}

// -----
module {
  llvm.func @check_arguments(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: !llvm.ptr, %arg8: !llvm.ptr, %arg9: i64, %arg10: i64, %arg11: i64, %arg12: i64, %arg13: i64, %arg14: !llvm.ptr, %arg15: !llvm.ptr, %arg16: i64, %arg17: i64, %arg18: i64, %arg19: i64, %arg20: i64) {
    llvm.return
  }
}

// -----
module {
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.func @free(!llvm.ptr)
  llvm.func @hoo(i64, !llvm.ptr) -> !llvm.struct<(i64, ptr)> attributes {sym_visibility = "private"}
  llvm.func @check_unranked_memref_func_call(%arg0: i64, %arg1: !llvm.ptr) -> !llvm.struct<(i64, ptr)> {
    %0 = llvm.mlir.poison : !llvm.struct<(i64, ptr)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(i64, ptr)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(i64, ptr)> 
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i64, ptr)> 
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i64, ptr)> 
    %5 = llvm.call @hoo(%3, %4) : (i64, !llvm.ptr) -> !llvm.struct<(i64, ptr)>
    %6 = llvm.mlir.constant(1 : index) : i64
    %7 = llvm.mlir.constant(2 : index) : i64
    %8 = llvm.mlir.constant(8 : index) : i64
    %9 = llvm.mlir.constant(8 : index) : i64
    %10 = llvm.mul %7, %9 : i64
    %11 = llvm.extractvalue %5[0] : !llvm.struct<(i64, ptr)> 
    %12 = llvm.mul %7, %11 : i64
    %13 = llvm.add %12, %6 : i64
    %14 = llvm.mul %13, %8 : i64
    %15 = llvm.add %10, %14 : i64
    %16 = llvm.alloca %15 x i8 : (i64) -> !llvm.ptr
    %17 = llvm.extractvalue %5[1] : !llvm.struct<(i64, ptr)> 
    "llvm.intr.memcpy"(%16, %17, %15) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.call @free(%17) : (!llvm.ptr) -> ()
    %18 = llvm.mlir.poison : !llvm.struct<(i64, ptr)>
    %19 = llvm.extractvalue %5[0] : !llvm.struct<(i64, ptr)> 
    %20 = llvm.insertvalue %19, %18[0] : !llvm.struct<(i64, ptr)> 
    %21 = llvm.insertvalue %16, %20[1] : !llvm.struct<(i64, ptr)> 
    %22 = llvm.mlir.constant(1 : index) : i64
    %23 = llvm.mlir.constant(2 : index) : i64
    %24 = llvm.mlir.constant(8 : index) : i64
    %25 = llvm.mlir.constant(8 : index) : i64
    %26 = llvm.mul %23, %25 : i64
    %27 = llvm.extractvalue %21[0] : !llvm.struct<(i64, ptr)> 
    %28 = llvm.mul %23, %27 : i64
    %29 = llvm.add %28, %22 : i64
    %30 = llvm.mul %29, %24 : i64
    %31 = llvm.add %26, %30 : i64
    %32 = llvm.call @malloc(%31) : (i64) -> !llvm.ptr
    %33 = llvm.extractvalue %21[1] : !llvm.struct<(i64, ptr)> 
    "llvm.intr.memcpy"(%32, %33, %31) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %34 = llvm.mlir.poison : !llvm.struct<(i64, ptr)>
    %35 = llvm.extractvalue %21[0] : !llvm.struct<(i64, ptr)> 
    %36 = llvm.insertvalue %35, %34[0] : !llvm.struct<(i64, ptr)> 
    %37 = llvm.insertvalue %32, %36[1] : !llvm.struct<(i64, ptr)> 
    llvm.return %37 : !llvm.struct<(i64, ptr)>
  }
}

// -----
module {
  func.func private @unsupported_memref_element_type() -> memref<42x!test.memref_element>
  func.func private @unsupported_unranked_memref_element_type() -> memref<*x!test.memref_element>
}

// -----
module {
  llvm.func @goo(f32) -> f32 attributes {sym_visibility = "private"}
  llvm.func @check_scalar_func_call(%arg0: f32) {
    %0 = llvm.call @goo(%arg0) : (f32) -> f32
    llvm.return
  }
}

// -----
module {
  llvm.func @loop_carried(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: !llvm.ptr<201>, %arg4: !llvm.ptr<201>, %arg5: i64, %arg6: i64, %arg7: i64, %arg8: !llvm.ptr<201>, %arg9: !llvm.ptr<201>, %arg10: i64, %arg11: i64, %arg12: i64) -> !llvm.struct<(struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>, struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>)> {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg8, %0[0] : !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.insertvalue %arg9, %1[1] : !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.insertvalue %arg10, %2[2] : !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.insertvalue %arg11, %3[3, 0] : !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.insertvalue %arg12, %4[4, 0] : !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)> 
    %6 = llvm.mlir.poison : !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>
    %7 = llvm.insertvalue %arg3, %6[0] : !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)> 
    %8 = llvm.insertvalue %arg4, %7[1] : !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.insertvalue %arg5, %8[2] : !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.insertvalue %arg6, %9[3, 0] : !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.insertvalue %arg7, %10[4, 0] : !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.br ^bb1(%arg0, %11, %5 : i64, !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>)
  ^bb1(%12: i64, %13: !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>, %14: !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>):  // 2 preds: ^bb0, ^bb2
    %15 = llvm.icmp "slt" %12, %arg1 : i64
    llvm.cond_br %15, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %16 = llvm.add %12, %arg2 : i64
    llvm.br ^bb1(%16, %14, %13 : i64, !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>)
  ^bb3:  // pred: ^bb1
    %17 = llvm.mlir.poison : !llvm.struct<(struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>, struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>)>
    %18 = llvm.insertvalue %13, %17[0] : !llvm.struct<(struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>, struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>)> 
    %19 = llvm.insertvalue %14, %18[1] : !llvm.struct<(struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>, struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>)> 
    llvm.return %19 : !llvm.struct<(struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>, struct<(ptr<201>, ptr<201>, i64, array<1 x i64>, array<1 x i64>)>)>
  }
}

