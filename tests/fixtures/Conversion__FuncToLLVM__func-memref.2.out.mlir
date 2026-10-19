module {
  llvm.func @check_noalias(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: i32, %arg8: i32, %arg9: i32) {
    llvm.return
  }
}

// -----
module {
  llvm.func @check_strided_memref_arguments(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: !llvm.ptr, %arg8: !llvm.ptr, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: !llvm.ptr, %arg15: !llvm.ptr, %arg16: i32, %arg17: i32, %arg18: i32, %arg19: i32, %arg20: i32) {
    llvm.return
  }
}

// -----
module {
  llvm.func @memref_index(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32, %arg3: i32, %arg4: i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    %5 = llvm.insertvalue %arg4, %4[4, 0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    llvm.return %5 : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
  }
}

// -----
module {
  llvm.func @check_arguments(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: !llvm.ptr, %arg8: !llvm.ptr, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: !llvm.ptr, %arg15: !llvm.ptr, %arg16: i32, %arg17: i32, %arg18: i32, %arg19: i32, %arg20: i32) {
    llvm.return
  }
}

// -----
module {
  llvm.func @malloc(i32) -> !llvm.ptr
  llvm.func @free(!llvm.ptr)
  llvm.func @hoo(i32, !llvm.ptr) -> !llvm.struct<(i32, ptr)> attributes {sym_visibility = "private"}
  llvm.func @check_unranked_memref_func_call(%arg0: i32, %arg1: !llvm.ptr) -> !llvm.struct<(i32, ptr)> {
    %0 = llvm.mlir.poison : !llvm.struct<(i32, ptr)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(i32, ptr)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(i32, ptr)> 
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i32, ptr)> 
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i32, ptr)> 
    %5 = llvm.call @hoo(%3, %4) : (i32, !llvm.ptr) -> !llvm.struct<(i32, ptr)>
    %6 = llvm.mlir.constant(1 : index) : i32
    %7 = llvm.mlir.constant(2 : index) : i32
    %8 = llvm.mlir.constant(4 : index) : i32
    %9 = llvm.mlir.constant(8 : index) : i32
    %10 = llvm.mul %7, %9 : i32
    %11 = llvm.extractvalue %5[0] : !llvm.struct<(i32, ptr)> 
    %12 = llvm.mul %7, %11 : i32
    %13 = llvm.add %12, %6 : i32
    %14 = llvm.mul %13, %8 : i32
    %15 = llvm.add %10, %14 : i32
    %16 = llvm.alloca %15 x i8 : (i32) -> !llvm.ptr
    %17 = llvm.extractvalue %5[1] : !llvm.struct<(i32, ptr)> 
    "llvm.intr.memcpy"(%16, %17, %15) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    llvm.call @free(%17) : (!llvm.ptr) -> ()
    %18 = llvm.mlir.poison : !llvm.struct<(i32, ptr)>
    %19 = llvm.extractvalue %5[0] : !llvm.struct<(i32, ptr)> 
    %20 = llvm.insertvalue %19, %18[0] : !llvm.struct<(i32, ptr)> 
    %21 = llvm.insertvalue %16, %20[1] : !llvm.struct<(i32, ptr)> 
    %22 = llvm.mlir.constant(1 : index) : i32
    %23 = llvm.mlir.constant(2 : index) : i32
    %24 = llvm.mlir.constant(4 : index) : i32
    %25 = llvm.mlir.constant(8 : index) : i32
    %26 = llvm.mul %23, %25 : i32
    %27 = llvm.extractvalue %21[0] : !llvm.struct<(i32, ptr)> 
    %28 = llvm.mul %23, %27 : i32
    %29 = llvm.add %28, %22 : i32
    %30 = llvm.mul %29, %24 : i32
    %31 = llvm.add %26, %30 : i32
    %32 = llvm.call @malloc(%31) : (i32) -> !llvm.ptr
    %33 = llvm.extractvalue %21[1] : !llvm.struct<(i32, ptr)> 
    "llvm.intr.memcpy"(%32, %33, %31) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %34 = llvm.mlir.poison : !llvm.struct<(i32, ptr)>
    %35 = llvm.extractvalue %21[0] : !llvm.struct<(i32, ptr)> 
    %36 = llvm.insertvalue %35, %34[0] : !llvm.struct<(i32, ptr)> 
    %37 = llvm.insertvalue %32, %36[1] : !llvm.struct<(i32, ptr)> 
    llvm.return %37 : !llvm.struct<(i32, ptr)>
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
  llvm.func @loop_carried(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr<201>, %arg4: !llvm.ptr<201>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: !llvm.ptr<201>, %arg9: !llvm.ptr<201>, %arg10: i32, %arg11: i32, %arg12: i32) -> !llvm.struct<(struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>, struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>)> {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>
    %1 = llvm.insertvalue %arg8, %0[0] : !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)> 
    %2 = llvm.insertvalue %arg9, %1[1] : !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)> 
    %3 = llvm.insertvalue %arg10, %2[2] : !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)> 
    %4 = llvm.insertvalue %arg11, %3[3, 0] : !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)> 
    %5 = llvm.insertvalue %arg12, %4[4, 0] : !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)> 
    %6 = llvm.mlir.poison : !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>
    %7 = llvm.insertvalue %arg3, %6[0] : !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)> 
    %8 = llvm.insertvalue %arg4, %7[1] : !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)> 
    %9 = llvm.insertvalue %arg5, %8[2] : !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)> 
    %10 = llvm.insertvalue %arg6, %9[3, 0] : !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)> 
    %11 = llvm.insertvalue %arg7, %10[4, 0] : !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)> 
    llvm.br ^bb1(%arg0, %11, %5 : i32, !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>, !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>)
  ^bb1(%12: i32, %13: !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>, %14: !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>):  // 2 preds: ^bb0, ^bb2
    %15 = llvm.icmp "slt" %12, %arg1 : i32
    llvm.cond_br %15, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %16 = llvm.add %12, %arg2 : i32
    llvm.br ^bb1(%16, %14, %13 : i32, !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>, !llvm.struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>)
  ^bb3:  // pred: ^bb1
    %17 = llvm.mlir.poison : !llvm.struct<(struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>, struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>)>
    %18 = llvm.insertvalue %13, %17[0] : !llvm.struct<(struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>, struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>)> 
    %19 = llvm.insertvalue %14, %18[1] : !llvm.struct<(struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>, struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>)> 
    llvm.return %19 : !llvm.struct<(struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>, struct<(ptr<201>, ptr<201>, i32, array<1 x i32>, array<1 x i32>)>)>
  }
}

