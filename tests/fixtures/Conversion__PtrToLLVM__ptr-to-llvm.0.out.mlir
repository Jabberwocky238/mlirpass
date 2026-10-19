module {
  llvm.func @test_ptr_add(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<(ptr, ptr, ptr, ptr)> {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %1 = llvm.getelementptr nusw %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.getelementptr nuw %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, ptr, ptr)>
    %5 = llvm.insertvalue %0, %4[0] : !llvm.struct<(ptr, ptr, ptr, ptr)> 
    %6 = llvm.insertvalue %1, %5[1] : !llvm.struct<(ptr, ptr, ptr, ptr)> 
    %7 = llvm.insertvalue %2, %6[2] : !llvm.struct<(ptr, ptr, ptr, ptr)> 
    %8 = llvm.insertvalue %3, %7[3] : !llvm.struct<(ptr, ptr, ptr, ptr)> 
    llvm.return %8 : !llvm.struct<(ptr, ptr, ptr, ptr)>
  }
  llvm.func @test_type_offset() -> !llvm.struct<(i64, i64, i64)> {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.getelementptr %0[1] : (!llvm.ptr) -> !llvm.ptr, f32
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.getelementptr %3[1] : (!llvm.ptr) -> !llvm.ptr, i64
    %5 = llvm.ptrtoint %4 : !llvm.ptr to i64
    %6 = llvm.mlir.zero : !llvm.ptr
    %7 = llvm.getelementptr %6[1] : (!llvm.ptr) -> !llvm.ptr, !llvm.struct<(i32, f64)>
    %8 = llvm.ptrtoint %7 : !llvm.ptr to i64
    %9 = llvm.mlir.poison : !llvm.struct<(i64, i64, i64)>
    %10 = llvm.insertvalue %2, %9[0] : !llvm.struct<(i64, i64, i64)> 
    %11 = llvm.insertvalue %5, %10[1] : !llvm.struct<(i64, i64, i64)> 
    %12 = llvm.insertvalue %8, %11[2] : !llvm.struct<(i64, i64, i64)> 
    llvm.return %12 : !llvm.struct<(i64, i64, i64)>
  }
  llvm.func @test_to_ptr(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64) -> !llvm.ptr {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.insertvalue %arg4, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %6 = llvm.extractvalue %5[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.return %6 : !llvm.ptr
  }
  llvm.func @test_get_metadata_static(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64) -> !llvm.struct<(ptr)> {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.insertvalue %arg4, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.insertvalue %arg6, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.mlir.undef : !llvm.struct<(ptr)>
    %9 = llvm.extractvalue %7[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %10 = llvm.insertvalue %9, %8[0] : !llvm.struct<(ptr)> 
    llvm.return %10 : !llvm.struct<(ptr)>
  }
  llvm.func @test_get_metadata_dynamic(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64) -> !llvm.struct<(ptr, i64, i64, i64)> {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.insertvalue %arg4, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.insertvalue %arg6, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.mlir.undef : !llvm.struct<(ptr, i64, i64, i64)>
    %9 = llvm.extractvalue %7[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %10 = llvm.insertvalue %9, %8[0] : !llvm.struct<(ptr, i64, i64, i64)> 
    %11 = llvm.extractvalue %7[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %12 = llvm.insertvalue %11, %10[1] : !llvm.struct<(ptr, i64, i64, i64)> 
    %13 = llvm.extractvalue %7[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = llvm.insertvalue %13, %12[2] : !llvm.struct<(ptr, i64, i64, i64)> 
    %15 = llvm.extractvalue %7[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %16 = llvm.insertvalue %15, %14[3] : !llvm.struct<(ptr, i64, i64, i64)> 
    llvm.return %16 : !llvm.struct<(ptr, i64, i64, i64)>
  }
  llvm.func @test_from_ptr_static(%arg0: !llvm.ptr, %arg1: !llvm.struct<(ptr)>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.extractvalue %arg1[0] : !llvm.struct<(ptr)> 
    %2 = llvm.insertvalue %1, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.insertvalue %arg0, %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(0 : index) : i64
    %5 = llvm.insertvalue %4, %3[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.mlir.constant(10 : index) : i64
    %7 = llvm.insertvalue %6, %5[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.mlir.constant(20 : index) : i64
    %9 = llvm.insertvalue %8, %7[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %10 = llvm.mlir.constant(20 : index) : i64
    %11 = llvm.insertvalue %10, %9[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %12 = llvm.mlir.constant(1 : index) : i64
    %13 = llvm.insertvalue %12, %11[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.return %13 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
  }
  llvm.func @test_from_ptr_dynamic(%arg0: !llvm.ptr, %arg1: !llvm.struct<(ptr, i64, i64, i64)>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.extractvalue %arg1[0] : !llvm.struct<(ptr, i64, i64, i64)> 
    %2 = llvm.insertvalue %1, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.insertvalue %arg0, %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(0 : index) : i64
    %5 = llvm.insertvalue %4, %3[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.extractvalue %arg1[1] : !llvm.struct<(ptr, i64, i64, i64)> 
    %7 = llvm.insertvalue %6, %5[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.extractvalue %arg1[2] : !llvm.struct<(ptr, i64, i64, i64)> 
    %9 = llvm.insertvalue %8, %7[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %10 = llvm.extractvalue %arg1[3] : !llvm.struct<(ptr, i64, i64, i64)> 
    %11 = llvm.insertvalue %10, %9[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %12 = llvm.mlir.constant(1 : index) : i64
    %13 = llvm.insertvalue %12, %11[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.return %13 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
  }
  llvm.func @test_memref_mixed(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: i64, %arg8: i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %5 = llvm.insertvalue %arg6, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %6 = llvm.insertvalue %arg4, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %7 = llvm.insertvalue %arg7, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %8 = llvm.insertvalue %arg5, %7[3, 2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %9 = llvm.insertvalue %arg8, %8[4, 2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %10 = llvm.extractvalue %9[1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %11 = llvm.mlir.undef : !llvm.struct<(ptr, i64, i64)>
    %12 = llvm.extractvalue %9[0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %13 = llvm.insertvalue %12, %11[0] : !llvm.struct<(ptr, i64, i64)> 
    %14 = llvm.extractvalue %9[3, 1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %15 = llvm.insertvalue %14, %13[1] : !llvm.struct<(ptr, i64, i64)> 
    %16 = llvm.extractvalue %9[4, 0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %17 = llvm.insertvalue %16, %15[2] : !llvm.struct<(ptr, i64, i64)> 
    llvm.return %9 : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
  }
  llvm.func @test_memref_strided(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.insertvalue %arg4, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.insertvalue %arg6, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.extractvalue %7[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %9 = llvm.mlir.undef : !llvm.struct<(ptr)>
    %10 = llvm.extractvalue %7[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.insertvalue %10, %9[0] : !llvm.struct<(ptr)> 
    llvm.return %7 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
  }
  llvm.func @test_comprehensive_dynamic(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.insertvalue %arg4, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.insertvalue %arg6, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.extractvalue %7[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %9 = llvm.mlir.undef : !llvm.struct<(ptr, i64, i64, i64, i64, i64)>
    %10 = llvm.extractvalue %7[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.insertvalue %10, %9[0] : !llvm.struct<(ptr, i64, i64, i64, i64, i64)> 
    %12 = llvm.extractvalue %7[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.insertvalue %12, %11[1] : !llvm.struct<(ptr, i64, i64, i64, i64, i64)> 
    %14 = llvm.extractvalue %7[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %15 = llvm.insertvalue %14, %13[2] : !llvm.struct<(ptr, i64, i64, i64, i64, i64)> 
    %16 = llvm.extractvalue %7[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %17 = llvm.insertvalue %16, %15[3] : !llvm.struct<(ptr, i64, i64, i64, i64, i64)> 
    %18 = llvm.extractvalue %7[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %19 = llvm.insertvalue %18, %17[4] : !llvm.struct<(ptr, i64, i64, i64, i64, i64)> 
    %20 = llvm.extractvalue %7[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %21 = llvm.insertvalue %20, %19[5] : !llvm.struct<(ptr, i64, i64, i64, i64, i64)> 
    %22 = llvm.mlir.zero : !llvm.ptr
    %23 = llvm.getelementptr %22[1] : (!llvm.ptr) -> !llvm.ptr, f32
    %24 = llvm.ptrtoint %23 : !llvm.ptr to i64
    %25 = llvm.getelementptr inbounds %8[%24] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %26 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %27 = llvm.extractvalue %21[0] : !llvm.struct<(ptr, i64, i64, i64, i64, i64)> 
    %28 = llvm.insertvalue %27, %26[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %29 = llvm.insertvalue %25, %28[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %30 = llvm.extractvalue %21[1] : !llvm.struct<(ptr, i64, i64, i64, i64, i64)> 
    %31 = llvm.insertvalue %30, %29[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %32 = llvm.extractvalue %21[2] : !llvm.struct<(ptr, i64, i64, i64, i64, i64)> 
    %33 = llvm.insertvalue %32, %31[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %34 = llvm.extractvalue %21[3] : !llvm.struct<(ptr, i64, i64, i64, i64, i64)> 
    %35 = llvm.insertvalue %34, %33[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %36 = llvm.extractvalue %21[4] : !llvm.struct<(ptr, i64, i64, i64, i64, i64)> 
    %37 = llvm.insertvalue %36, %35[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %38 = llvm.extractvalue %21[5] : !llvm.struct<(ptr, i64, i64, i64, i64, i64)> 
    %39 = llvm.insertvalue %38, %37[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.return %39 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
  }
  llvm.func @test_memref_0d(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64) -> !llvm.struct<(ptr, ptr, i64)> {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64)> 
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(ptr, ptr, i64)> 
    %5 = llvm.mlir.undef : !llvm.struct<(ptr)>
    %6 = llvm.extractvalue %3[0] : !llvm.struct<(ptr, ptr, i64)> 
    %7 = llvm.insertvalue %6, %5[0] : !llvm.struct<(ptr)> 
    llvm.return %3 : !llvm.struct<(ptr, ptr, i64)>
  }
  llvm.func @test_memref_ptradd_indexing(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: i64, %arg8: i64, %arg9: i64) -> !llvm.ptr {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %5 = llvm.insertvalue %arg6, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %6 = llvm.insertvalue %arg4, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %7 = llvm.insertvalue %arg7, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %8 = llvm.insertvalue %arg5, %7[3, 2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %9 = llvm.insertvalue %arg8, %8[4, 2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %10 = llvm.extractvalue %9[1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %11 = llvm.mlir.zero : !llvm.ptr
    %12 = llvm.getelementptr %11[1] : (!llvm.ptr) -> !llvm.ptr, f32
    %13 = llvm.ptrtoint %12 : !llvm.ptr to i64
    %14 = llvm.mul %13, %arg9 : i64
    %15 = llvm.getelementptr %10[%14] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %15 : !llvm.ptr
  }
}

