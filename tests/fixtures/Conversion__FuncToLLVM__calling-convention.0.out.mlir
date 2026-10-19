module {
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.func @free(!llvm.ptr)
  llvm.func private @external(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: !llvm.ptr, %arg8: !llvm.ptr, %arg9: i64) attributes {llvm.emit_c_interface, sym_visibility = "private"} {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.insertvalue %arg4, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.insertvalue %arg6, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.mlir.constant(1 : index) : i64
    %9 = llvm.alloca %8 x !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> : (i64) -> !llvm.ptr
    llvm.store %7, %9 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr
    %10 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64)>
    %11 = llvm.insertvalue %arg7, %10[0] : !llvm.struct<(ptr, ptr, i64)> 
    %12 = llvm.insertvalue %arg8, %11[1] : !llvm.struct<(ptr, ptr, i64)> 
    %13 = llvm.insertvalue %arg9, %12[2] : !llvm.struct<(ptr, ptr, i64)> 
    %14 = llvm.mlir.constant(1 : index) : i64
    %15 = llvm.alloca %14 x !llvm.struct<(ptr, ptr, i64)> : (i64) -> !llvm.ptr
    llvm.store %13, %15 : !llvm.struct<(ptr, ptr, i64)>, !llvm.ptr
    llvm.call @_mlir_ciface_external(%9, %15) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @_mlir_ciface_external(!llvm.ptr, !llvm.ptr) attributes {llvm.emit_c_interface, sym_visibility = "private"}
  llvm.func private @returner() -> !llvm.struct<(struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, struct<(ptr, ptr, i64)>)> attributes {llvm.emit_c_interface, sym_visibility = "private"} {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.alloca %0 x !llvm.struct<(struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, struct<(ptr, ptr, i64)>)> : (i64) -> !llvm.ptr
    llvm.call @_mlir_ciface_returner(%1) : (!llvm.ptr) -> ()
    %2 = llvm.load %1 : !llvm.ptr -> !llvm.struct<(struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, struct<(ptr, ptr, i64)>)>
    llvm.return %2 : !llvm.struct<(struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, struct<(ptr, ptr, i64)>)>
  }
  llvm.func @_mlir_ciface_returner(!llvm.ptr) attributes {llvm.emit_c_interface, sym_visibility = "private"}
  llvm.func @caller() attributes {llvm.emit_c_interface} {
    %0 = llvm.call @returner() : () -> !llvm.struct<(struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, struct<(ptr, ptr, i64)>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, struct<(ptr, ptr, i64)>)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, struct<(ptr, ptr, i64)>)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.extractvalue %1[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.extractvalue %1[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.extractvalue %1[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.extractvalue %1[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %9 = llvm.extractvalue %1[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %10 = llvm.extractvalue %2[0] : !llvm.struct<(ptr, ptr, i64)> 
    %11 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64)> 
    %12 = llvm.extractvalue %2[2] : !llvm.struct<(ptr, ptr, i64)> 
    llvm.call @external(%3, %4, %5, %6, %7, %8, %9, %10, %11, %12) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64, !llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return
  }
  llvm.func @_mlir_ciface_caller() attributes {llvm.emit_c_interface} {
    llvm.call @caller() : () -> ()
    llvm.return
  }
  llvm.func @callee(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) attributes {llvm.emit_c_interface} {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.insertvalue %arg4, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %6 = llvm.extractvalue %5[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %7 = llvm.getelementptr inbounds|nuw %6[%arg5] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %8 = llvm.load %7 : !llvm.ptr -> f32
    llvm.return
  }
  llvm.func @_mlir_ciface_callee(%arg0: !llvm.ptr, %arg1: i64) attributes {llvm.emit_c_interface} {
    %0 = llvm.load %arg0 : !llvm.ptr -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.extractvalue %0[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.call @callee(%1, %2, %3, %4, %5, %arg1) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64) -> ()
    llvm.return
  }
  llvm.func @other_callee(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) attributes {llvm.emit_c_interface} {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.insertvalue %arg4, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %6 = llvm.extractvalue %5[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %7 = llvm.getelementptr inbounds|nuw %6[%arg5] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %8 = llvm.load %7 : !llvm.ptr -> f32
    llvm.return
  }
  llvm.func @_mlir_ciface_other_callee(%arg0: !llvm.ptr, %arg1: i64) attributes {llvm.emit_c_interface} {
    %0 = llvm.load %arg0 : !llvm.ptr -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.extractvalue %0[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.call @other_callee(%1, %2, %3, %4, %5, %arg1) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64) -> ()
    llvm.return
  }
  llvm.func @return_var_memref_caller(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64) attributes {llvm.emit_c_interface} {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.insertvalue %arg4, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.insertvalue %arg6, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.extractvalue %7[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %9 = llvm.extractvalue %7[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %10 = llvm.extractvalue %7[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.extractvalue %7[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %12 = llvm.extractvalue %7[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.extractvalue %7[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = llvm.extractvalue %7[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %15 = llvm.call @return_var_memref(%8, %9, %10, %11, %12, %13, %14) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> !llvm.struct<(i64, ptr)>
    %16 = llvm.mlir.constant(1 : index) : i64
    %17 = llvm.mlir.constant(2 : index) : i64
    %18 = llvm.mlir.constant(8 : index) : i64
    %19 = llvm.mlir.constant(8 : index) : i64
    %20 = llvm.mul %17, %19 : i64
    %21 = llvm.extractvalue %15[0] : !llvm.struct<(i64, ptr)> 
    %22 = llvm.mul %17, %21 : i64
    %23 = llvm.add %22, %16 : i64
    %24 = llvm.mul %23, %18 : i64
    %25 = llvm.add %20, %24 : i64
    %26 = llvm.alloca %25 x i8 : (i64) -> !llvm.ptr
    %27 = llvm.extractvalue %15[1] : !llvm.struct<(i64, ptr)> 
    "llvm.intr.memcpy"(%26, %27, %25) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.call @free(%27) : (!llvm.ptr) -> ()
    %28 = llvm.mlir.poison : !llvm.struct<(i64, ptr)>
    %29 = llvm.extractvalue %15[0] : !llvm.struct<(i64, ptr)> 
    %30 = llvm.insertvalue %29, %28[0] : !llvm.struct<(i64, ptr)> 
    %31 = llvm.insertvalue %26, %30[1] : !llvm.struct<(i64, ptr)> 
    llvm.return
  }
  llvm.func @_mlir_ciface_return_var_memref_caller(%arg0: !llvm.ptr) attributes {llvm.emit_c_interface} {
    %0 = llvm.load %arg0 : !llvm.ptr -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.extractvalue %0[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.extractvalue %0[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.extractvalue %0[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @return_var_memref_caller(%1, %2, %3, %4, %5, %6, %7) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> ()
    llvm.return
  }
  llvm.func @return_var_memref(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64) -> !llvm.struct<(i64, ptr)> attributes {llvm.emit_c_interface} {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.insertvalue %arg4, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.insertvalue %arg6, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.mlir.constant(1 : index) : i64
    %9 = llvm.alloca %8 x !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> : (i64) -> !llvm.ptr
    llvm.store %7, %9 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr
    %10 = llvm.mlir.constant(2 : index) : i64
    %11 = llvm.mlir.poison : !llvm.struct<(i64, ptr)>
    %12 = llvm.insertvalue %10, %11[0] : !llvm.struct<(i64, ptr)> 
    %13 = llvm.insertvalue %9, %12[1] : !llvm.struct<(i64, ptr)> 
    %14 = llvm.mlir.constant(1 : index) : i64
    %15 = llvm.mlir.constant(2 : index) : i64
    %16 = llvm.mlir.constant(8 : index) : i64
    %17 = llvm.mlir.constant(8 : index) : i64
    %18 = llvm.mul %15, %17 : i64
    %19 = llvm.extractvalue %13[0] : !llvm.struct<(i64, ptr)> 
    %20 = llvm.mul %15, %19 : i64
    %21 = llvm.add %20, %14 : i64
    %22 = llvm.mul %21, %16 : i64
    %23 = llvm.add %18, %22 : i64
    %24 = llvm.call @malloc(%23) : (i64) -> !llvm.ptr
    %25 = llvm.extractvalue %13[1] : !llvm.struct<(i64, ptr)> 
    "llvm.intr.memcpy"(%24, %25, %23) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %26 = llvm.mlir.poison : !llvm.struct<(i64, ptr)>
    %27 = llvm.extractvalue %13[0] : !llvm.struct<(i64, ptr)> 
    %28 = llvm.insertvalue %27, %26[0] : !llvm.struct<(i64, ptr)> 
    %29 = llvm.insertvalue %24, %28[1] : !llvm.struct<(i64, ptr)> 
    llvm.return %29 : !llvm.struct<(i64, ptr)>
  }
  llvm.func @_mlir_ciface_return_var_memref(%arg0: !llvm.ptr, %arg1: !llvm.ptr) attributes {llvm.emit_c_interface} {
    %0 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.extractvalue %0[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.extractvalue %0[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.extractvalue %0[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.call @return_var_memref(%1, %2, %3, %4, %5, %6, %7) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> !llvm.struct<(i64, ptr)>
    llvm.store %8, %arg0 : !llvm.struct<(i64, ptr)>, !llvm.ptr
    llvm.return
  }
  llvm.func @return_two_var_memref_caller(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64) attributes {llvm.emit_c_interface} {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.insertvalue %arg4, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.insertvalue %arg6, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.extractvalue %7[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %9 = llvm.extractvalue %7[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %10 = llvm.extractvalue %7[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.extractvalue %7[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %12 = llvm.extractvalue %7[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.extractvalue %7[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = llvm.extractvalue %7[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %15 = llvm.call @return_two_var_memref(%8, %9, %10, %11, %12, %13, %14) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> !llvm.struct<(struct<(i64, ptr)>, struct<(i64, ptr)>)>
    %16 = llvm.extractvalue %15[0] : !llvm.struct<(struct<(i64, ptr)>, struct<(i64, ptr)>)> 
    %17 = llvm.extractvalue %15[1] : !llvm.struct<(struct<(i64, ptr)>, struct<(i64, ptr)>)> 
    %18 = llvm.mlir.constant(1 : index) : i64
    %19 = llvm.mlir.constant(2 : index) : i64
    %20 = llvm.mlir.constant(8 : index) : i64
    %21 = llvm.mlir.constant(8 : index) : i64
    %22 = llvm.mul %19, %21 : i64
    %23 = llvm.extractvalue %16[0] : !llvm.struct<(i64, ptr)> 
    %24 = llvm.mul %19, %23 : i64
    %25 = llvm.add %24, %18 : i64
    %26 = llvm.mul %25, %20 : i64
    %27 = llvm.add %22, %26 : i64
    %28 = llvm.alloca %27 x i8 : (i64) -> !llvm.ptr
    %29 = llvm.extractvalue %16[1] : !llvm.struct<(i64, ptr)> 
    "llvm.intr.memcpy"(%28, %29, %27) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.call @free(%29) : (!llvm.ptr) -> ()
    %30 = llvm.mlir.poison : !llvm.struct<(i64, ptr)>
    %31 = llvm.extractvalue %16[0] : !llvm.struct<(i64, ptr)> 
    %32 = llvm.insertvalue %31, %30[0] : !llvm.struct<(i64, ptr)> 
    %33 = llvm.insertvalue %28, %32[1] : !llvm.struct<(i64, ptr)> 
    %34 = llvm.mlir.constant(1 : index) : i64
    %35 = llvm.mlir.constant(2 : index) : i64
    %36 = llvm.mlir.constant(8 : index) : i64
    %37 = llvm.mlir.constant(8 : index) : i64
    %38 = llvm.mul %35, %37 : i64
    %39 = llvm.extractvalue %17[0] : !llvm.struct<(i64, ptr)> 
    %40 = llvm.mul %35, %39 : i64
    %41 = llvm.add %40, %34 : i64
    %42 = llvm.mul %41, %36 : i64
    %43 = llvm.add %38, %42 : i64
    %44 = llvm.alloca %43 x i8 : (i64) -> !llvm.ptr
    %45 = llvm.extractvalue %17[1] : !llvm.struct<(i64, ptr)> 
    "llvm.intr.memcpy"(%44, %45, %43) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.call @free(%45) : (!llvm.ptr) -> ()
    %46 = llvm.mlir.poison : !llvm.struct<(i64, ptr)>
    %47 = llvm.extractvalue %17[0] : !llvm.struct<(i64, ptr)> 
    %48 = llvm.insertvalue %47, %46[0] : !llvm.struct<(i64, ptr)> 
    %49 = llvm.insertvalue %44, %48[1] : !llvm.struct<(i64, ptr)> 
    llvm.return
  }
  llvm.func @_mlir_ciface_return_two_var_memref_caller(%arg0: !llvm.ptr) attributes {llvm.emit_c_interface} {
    %0 = llvm.load %arg0 : !llvm.ptr -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.extractvalue %0[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.extractvalue %0[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.extractvalue %0[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @return_two_var_memref_caller(%1, %2, %3, %4, %5, %6, %7) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> ()
    llvm.return
  }
  llvm.func @return_two_var_memref(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64) -> !llvm.struct<(struct<(i64, ptr)>, struct<(i64, ptr)>)> attributes {llvm.emit_c_interface} {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.insertvalue %arg4, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.insertvalue %arg6, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.mlir.constant(1 : index) : i64
    %9 = llvm.alloca %8 x !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> : (i64) -> !llvm.ptr
    llvm.store %7, %9 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr
    %10 = llvm.mlir.constant(2 : index) : i64
    %11 = llvm.mlir.poison : !llvm.struct<(i64, ptr)>
    %12 = llvm.insertvalue %10, %11[0] : !llvm.struct<(i64, ptr)> 
    %13 = llvm.insertvalue %9, %12[1] : !llvm.struct<(i64, ptr)> 
    %14 = llvm.mlir.constant(1 : index) : i64
    %15 = llvm.mlir.constant(2 : index) : i64
    %16 = llvm.mlir.constant(8 : index) : i64
    %17 = llvm.mlir.constant(8 : index) : i64
    %18 = llvm.mul %15, %17 : i64
    %19 = llvm.extractvalue %13[0] : !llvm.struct<(i64, ptr)> 
    %20 = llvm.mul %15, %19 : i64
    %21 = llvm.add %20, %14 : i64
    %22 = llvm.mul %21, %16 : i64
    %23 = llvm.add %18, %22 : i64
    %24 = llvm.call @malloc(%23) : (i64) -> !llvm.ptr
    %25 = llvm.extractvalue %13[1] : !llvm.struct<(i64, ptr)> 
    "llvm.intr.memcpy"(%24, %25, %23) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %26 = llvm.mlir.poison : !llvm.struct<(i64, ptr)>
    %27 = llvm.extractvalue %13[0] : !llvm.struct<(i64, ptr)> 
    %28 = llvm.insertvalue %27, %26[0] : !llvm.struct<(i64, ptr)> 
    %29 = llvm.insertvalue %24, %28[1] : !llvm.struct<(i64, ptr)> 
    %30 = llvm.mlir.constant(1 : index) : i64
    %31 = llvm.mlir.constant(2 : index) : i64
    %32 = llvm.mlir.constant(8 : index) : i64
    %33 = llvm.mlir.constant(8 : index) : i64
    %34 = llvm.mul %31, %33 : i64
    %35 = llvm.extractvalue %13[0] : !llvm.struct<(i64, ptr)> 
    %36 = llvm.mul %31, %35 : i64
    %37 = llvm.add %36, %30 : i64
    %38 = llvm.mul %37, %32 : i64
    %39 = llvm.add %34, %38 : i64
    %40 = llvm.call @malloc(%39) : (i64) -> !llvm.ptr
    %41 = llvm.extractvalue %13[1] : !llvm.struct<(i64, ptr)> 
    "llvm.intr.memcpy"(%40, %41, %39) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %42 = llvm.mlir.poison : !llvm.struct<(i64, ptr)>
    %43 = llvm.extractvalue %13[0] : !llvm.struct<(i64, ptr)> 
    %44 = llvm.insertvalue %43, %42[0] : !llvm.struct<(i64, ptr)> 
    %45 = llvm.insertvalue %40, %44[1] : !llvm.struct<(i64, ptr)> 
    %46 = llvm.mlir.poison : !llvm.struct<(struct<(i64, ptr)>, struct<(i64, ptr)>)>
    %47 = llvm.insertvalue %29, %46[0] : !llvm.struct<(struct<(i64, ptr)>, struct<(i64, ptr)>)> 
    %48 = llvm.insertvalue %45, %47[1] : !llvm.struct<(struct<(i64, ptr)>, struct<(i64, ptr)>)> 
    llvm.return %48 : !llvm.struct<(struct<(i64, ptr)>, struct<(i64, ptr)>)>
  }
  llvm.func @_mlir_ciface_return_two_var_memref(%arg0: !llvm.ptr, %arg1: !llvm.ptr) attributes {llvm.emit_c_interface} {
    %0 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.extractvalue %0[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.extractvalue %0[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.extractvalue %0[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.call @return_two_var_memref(%1, %2, %3, %4, %5, %6, %7) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> !llvm.struct<(struct<(i64, ptr)>, struct<(i64, ptr)>)>
    llvm.store %8, %arg0 : !llvm.struct<(struct<(i64, ptr)>, struct<(i64, ptr)>)>, !llvm.ptr
    llvm.return
  }
  llvm.func @bare_ptr_calling_conv(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64, %arg3: f32) -> !llvm.ptr attributes {llvm.bareptr, llvm.emit_c_interface} {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.insertvalue %arg0, %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.mlir.constant(0 : index) : i64
    %4 = llvm.insertvalue %3, %2[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.mlir.constant(4 : index) : i64
    %6 = llvm.insertvalue %5, %4[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.mlir.constant(3 : index) : i64
    %8 = llvm.insertvalue %7, %6[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %9 = llvm.mlir.constant(3 : index) : i64
    %10 = llvm.insertvalue %9, %8[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.mlir.constant(1 : index) : i64
    %12 = llvm.insertvalue %11, %10[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.extractvalue %12[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = llvm.mlir.constant(3 : index) : i64
    %15 = llvm.mul %arg1, %14 overflow<nsw, nuw> : i64
    %16 = llvm.add %15, %arg2 overflow<nsw, nuw> : i64
    %17 = llvm.getelementptr inbounds|nuw %13[%16] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %arg3, %17 : f32, !llvm.ptr
    %18 = llvm.extractvalue %12[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.return %18 : !llvm.ptr
  }
  llvm.func @bare_ptr_calling_conv_multiresult(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64, %arg3: f32) -> !llvm.struct<(f32, ptr)> attributes {llvm.bareptr, llvm.emit_c_interface} {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.insertvalue %arg0, %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.mlir.constant(0 : index) : i64
    %4 = llvm.insertvalue %3, %2[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.mlir.constant(4 : index) : i64
    %6 = llvm.insertvalue %5, %4[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.mlir.constant(3 : index) : i64
    %8 = llvm.insertvalue %7, %6[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %9 = llvm.mlir.constant(3 : index) : i64
    %10 = llvm.insertvalue %9, %8[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.mlir.constant(1 : index) : i64
    %12 = llvm.insertvalue %11, %10[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.extractvalue %12[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = llvm.mlir.constant(3 : index) : i64
    %15 = llvm.mul %arg1, %14 overflow<nsw, nuw> : i64
    %16 = llvm.add %15, %arg2 overflow<nsw, nuw> : i64
    %17 = llvm.getelementptr inbounds|nuw %13[%16] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %arg3, %17 : f32, !llvm.ptr
    %18 = llvm.extractvalue %12[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %19 = llvm.mlir.constant(3 : index) : i64
    %20 = llvm.mul %arg1, %19 overflow<nsw, nuw> : i64
    %21 = llvm.add %20, %arg2 overflow<nsw, nuw> : i64
    %22 = llvm.getelementptr inbounds|nuw %18[%21] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %23 = llvm.load %22 : !llvm.ptr -> f32
    %24 = llvm.extractvalue %12[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %25 = llvm.mlir.poison : !llvm.struct<(f32, ptr)>
    %26 = llvm.insertvalue %23, %25[0] : !llvm.struct<(f32, ptr)> 
    %27 = llvm.insertvalue %24, %26[1] : !llvm.struct<(f32, ptr)> 
    llvm.return %27 : !llvm.struct<(f32, ptr)>
  }
}

