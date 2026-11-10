"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, index) -> vector<17xf32>, sym_name = "transfer_read_write_1d"}> ({
  ^bb0(%arg2: memref<?xf32>, %arg3: index):
    %31 = "builtin.unrealized_conversion_cast"(%arg3) : (index) -> i64
    %32 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %33 = "arith.constant"() <{value = dense<7.000000e+00> : vector<17xf32>}> : () -> vector<17xf32>
    %34 = "arith.constant"() <{value = 2147483647 : index}> : () -> index
    %35 = "arith.constant"() <{value = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : vector<17xi32>}> : () -> vector<17xi32>
    %36 = "arith.constant"() <{value = 0 : index}> : () -> index
    %37 = "memref.dim"(%arg2, %36) : (memref<?xf32>, index) -> index
    %38 = "arith.subi"(%37, %arg3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %39 = "arith.minsi"(%38, %34) : (index, index) -> index
    %40 = "arith.index_cast"(%39) : (index) -> i32
    %41 = "llvm.mlir.poison"() : () -> vector<17xi32>
    %42 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %43 = "llvm.insertelement"(%41, %40, %42) : (vector<17xi32>, i32, i32) -> vector<17xi32>
    %44 = "llvm.shufflevector"(%43, %41) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<17xi32>, vector<17xi32>) -> vector<17xi32>
    %45 = "arith.cmpi"(%44, %35) <{predicate = 4 : i64}> : (vector<17xi32>, vector<17xi32>) -> vector<17xi1>
    %46 = "llvm.extractvalue"(%32) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %47 = "llvm.getelementptr"(%46, %31) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %48 = "llvm.intr.masked.load"(%47, %45, %33) <{alignment = 4 : i32}> : (!llvm.ptr, vector<17xi1>, vector<17xf32>) -> vector<17xf32>
    %49 = "memref.dim"(%arg2, %36) : (memref<?xf32>, index) -> index
    %50 = "arith.subi"(%49, %arg3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %51 = "arith.minsi"(%50, %34) : (index, index) -> index
    %52 = "arith.index_cast"(%51) : (index) -> i32
    %53 = "llvm.mlir.poison"() : () -> vector<17xi32>
    %54 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %55 = "llvm.insertelement"(%53, %52, %54) : (vector<17xi32>, i32, i32) -> vector<17xi32>
    %56 = "llvm.shufflevector"(%55, %53) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<17xi32>, vector<17xi32>) -> vector<17xi32>
    %57 = "arith.cmpi"(%56, %35) <{predicate = 4 : i64}> : (vector<17xi32>, vector<17xi32>) -> vector<17xi1>
    %58 = "llvm.extractvalue"(%32) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %59 = "llvm.getelementptr"(%58, %31) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.masked.store"(%48, %59, %57) <{alignment = 4 : i32}> : (vector<17xf32>, !llvm.ptr, vector<17xi1>) -> ()
    "func.return"(%48) : (vector<17xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index) -> vector<[17]xf32>, sym_name = "transfer_read_write_1d_scalable"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = "arith.constant"() <{value = dense<7.000000e+00> : vector<[17]xf32>}> : () -> vector<[17]xf32>
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "memref.dim"(%arg0, %3) : (memref<?xf32>, index) -> index
    %5 = "arith.subi"(%4, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %6 = "llvm.intr.stepvector"() : () -> vector<[17]xi32>
    %7 = "arith.constant"() <{value = 2147483647 : index}> : () -> index
    %8 = "arith.minsi"(%5, %7) : (index, index) -> index
    %9 = "arith.index_cast"(%8) : (index) -> i32
    %10 = "llvm.mlir.poison"() : () -> vector<[17]xi32>
    %11 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %12 = "llvm.insertelement"(%10, %9, %11) : (vector<[17]xi32>, i32, i32) -> vector<[17]xi32>
    %13 = "llvm.shufflevector"(%12, %10) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[17]xi32>, vector<[17]xi32>) -> vector<[17]xi32>
    %14 = "arith.cmpi"(%6, %13) <{predicate = 2 : i64}> : (vector<[17]xi32>, vector<[17]xi32>) -> vector<[17]xi1>
    %15 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %16 = "llvm.getelementptr"(%15, %0) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %17 = "llvm.intr.masked.load"(%16, %14, %2) <{alignment = 4 : i32}> : (!llvm.ptr, vector<[17]xi1>, vector<[17]xf32>) -> vector<[17]xf32>
    %18 = "memref.dim"(%arg0, %3) : (memref<?xf32>, index) -> index
    %19 = "arith.subi"(%18, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %20 = "llvm.intr.stepvector"() : () -> vector<[17]xi32>
    %21 = "arith.constant"() <{value = 2147483647 : index}> : () -> index
    %22 = "arith.minsi"(%19, %21) : (index, index) -> index
    %23 = "arith.index_cast"(%22) : (index) -> i32
    %24 = "llvm.mlir.poison"() : () -> vector<[17]xi32>
    %25 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %26 = "llvm.insertelement"(%24, %23, %25) : (vector<[17]xi32>, i32, i32) -> vector<[17]xi32>
    %27 = "llvm.shufflevector"(%26, %24) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[17]xi32>, vector<[17]xi32>) -> vector<[17]xi32>
    %28 = "arith.cmpi"(%20, %27) <{predicate = 2 : i64}> : (vector<[17]xi32>, vector<[17]xi32>) -> vector<[17]xi1>
    %29 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %30 = "llvm.getelementptr"(%29, %0) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.masked.store"(%17, %30, %28) <{alignment = 4 : i32}> : (vector<[17]xf32>, !llvm.ptr, vector<[17]xi1>) -> ()
    "func.return"(%17) : (vector<[17]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xindex>, index) -> vector<17xindex>, sym_name = "transfer_read_write_index_1d"}> ({
  ^bb0(%arg2: memref<?xindex>, %arg3: index):
    %33 = "builtin.unrealized_conversion_cast"(%arg3) : (index) -> i64
    %34 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<?xindex>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %35 = "arith.constant"() <{value = dense<7> : vector<17xindex>}> : () -> vector<17xindex>
    %36 = "builtin.unrealized_conversion_cast"(%35) : (vector<17xindex>) -> vector<17xi64>
    %37 = "arith.constant"() <{value = 2147483647 : index}> : () -> index
    %38 = "arith.constant"() <{value = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : vector<17xi32>}> : () -> vector<17xi32>
    %39 = "arith.constant"() <{value = 0 : index}> : () -> index
    %40 = "memref.dim"(%arg2, %39) : (memref<?xindex>, index) -> index
    %41 = "arith.subi"(%40, %arg3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %42 = "arith.minsi"(%41, %37) : (index, index) -> index
    %43 = "arith.index_cast"(%42) : (index) -> i32
    %44 = "llvm.mlir.poison"() : () -> vector<17xi32>
    %45 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %46 = "llvm.insertelement"(%44, %43, %45) : (vector<17xi32>, i32, i32) -> vector<17xi32>
    %47 = "llvm.shufflevector"(%46, %44) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<17xi32>, vector<17xi32>) -> vector<17xi32>
    %48 = "arith.cmpi"(%47, %38) <{predicate = 4 : i64}> : (vector<17xi32>, vector<17xi32>) -> vector<17xi1>
    %49 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %50 = "llvm.getelementptr"(%49, %33) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %51 = "llvm.intr.masked.load"(%50, %48, %36) <{alignment = 8 : i32}> : (!llvm.ptr, vector<17xi1>, vector<17xi64>) -> vector<17xi64>
    %52 = "builtin.unrealized_conversion_cast"(%51) : (vector<17xi64>) -> vector<17xindex>
    %53 = "memref.dim"(%arg2, %39) : (memref<?xindex>, index) -> index
    %54 = "arith.subi"(%53, %arg3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %55 = "arith.minsi"(%54, %37) : (index, index) -> index
    %56 = "arith.index_cast"(%55) : (index) -> i32
    %57 = "llvm.mlir.poison"() : () -> vector<17xi32>
    %58 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %59 = "llvm.insertelement"(%57, %56, %58) : (vector<17xi32>, i32, i32) -> vector<17xi32>
    %60 = "llvm.shufflevector"(%59, %57) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<17xi32>, vector<17xi32>) -> vector<17xi32>
    %61 = "arith.cmpi"(%60, %38) <{predicate = 4 : i64}> : (vector<17xi32>, vector<17xi32>) -> vector<17xi1>
    %62 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %63 = "llvm.getelementptr"(%62, %33) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.masked.store"(%51, %63, %61) <{alignment = 8 : i32}> : (vector<17xi64>, !llvm.ptr, vector<17xi1>) -> ()
    "func.return"(%52) : (vector<17xindex>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xindex>, index) -> vector<[17]xindex>, sym_name = "transfer_read_write_index_1d_scalable"}> ({
  ^bb0(%arg0: memref<?xindex>, %arg1: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xindex>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = "arith.constant"() <{value = dense<7> : vector<[17]xindex>}> : () -> vector<[17]xindex>
    %3 = "builtin.unrealized_conversion_cast"(%2) : (vector<[17]xindex>) -> vector<[17]xi64>
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "memref.dim"(%arg0, %4) : (memref<?xindex>, index) -> index
    %6 = "arith.subi"(%5, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %7 = "llvm.intr.stepvector"() : () -> vector<[17]xi32>
    %8 = "arith.constant"() <{value = 2147483647 : index}> : () -> index
    %9 = "arith.minsi"(%6, %8) : (index, index) -> index
    %10 = "arith.index_cast"(%9) : (index) -> i32
    %11 = "llvm.mlir.poison"() : () -> vector<[17]xi32>
    %12 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %13 = "llvm.insertelement"(%11, %10, %12) : (vector<[17]xi32>, i32, i32) -> vector<[17]xi32>
    %14 = "llvm.shufflevector"(%13, %11) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[17]xi32>, vector<[17]xi32>) -> vector<[17]xi32>
    %15 = "arith.cmpi"(%7, %14) <{predicate = 2 : i64}> : (vector<[17]xi32>, vector<[17]xi32>) -> vector<[17]xi1>
    %16 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %17 = "llvm.getelementptr"(%16, %0) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %18 = "llvm.intr.masked.load"(%17, %15, %3) <{alignment = 8 : i32}> : (!llvm.ptr, vector<[17]xi1>, vector<[17]xi64>) -> vector<[17]xi64>
    %19 = "builtin.unrealized_conversion_cast"(%18) : (vector<[17]xi64>) -> vector<[17]xindex>
    %20 = "memref.dim"(%arg0, %4) : (memref<?xindex>, index) -> index
    %21 = "arith.subi"(%20, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %22 = "llvm.intr.stepvector"() : () -> vector<[17]xi32>
    %23 = "arith.constant"() <{value = 2147483647 : index}> : () -> index
    %24 = "arith.minsi"(%21, %23) : (index, index) -> index
    %25 = "arith.index_cast"(%24) : (index) -> i32
    %26 = "llvm.mlir.poison"() : () -> vector<[17]xi32>
    %27 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %28 = "llvm.insertelement"(%26, %25, %27) : (vector<[17]xi32>, i32, i32) -> vector<[17]xi32>
    %29 = "llvm.shufflevector"(%28, %26) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[17]xi32>, vector<[17]xi32>) -> vector<[17]xi32>
    %30 = "arith.cmpi"(%22, %29) <{predicate = 2 : i64}> : (vector<[17]xi32>, vector<[17]xi32>) -> vector<[17]xi1>
    %31 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %32 = "llvm.getelementptr"(%31, %0) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.masked.store"(%18, %32, %30) <{alignment = 8 : i32}> : (vector<[17]xi64>, !llvm.ptr, vector<[17]xi1>) -> ()
    "func.return"(%19) : (vector<[17]xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, index, index) -> vector<17xf32>, sym_name = "transfer_read_2d_to_1d"}> ({
  ^bb0(%arg3: memref<?x?xf32>, %arg4: index, %arg5: index):
    %22 = "builtin.unrealized_conversion_cast"(%arg5) : (index) -> i64
    %23 = "builtin.unrealized_conversion_cast"(%arg4) : (index) -> i64
    %24 = "builtin.unrealized_conversion_cast"(%arg3) : (memref<?x?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %25 = "arith.constant"() <{value = dense<7.000000e+00> : vector<17xf32>}> : () -> vector<17xf32>
    %26 = "arith.constant"() <{value = 2147483647 : index}> : () -> index
    %27 = "arith.constant"() <{value = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : vector<17xi32>}> : () -> vector<17xi32>
    %28 = "arith.constant"() <{value = 1 : index}> : () -> index
    %29 = "memref.dim"(%arg3, %28) : (memref<?x?xf32>, index) -> index
    %30 = "arith.subi"(%29, %arg5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %31 = "arith.minsi"(%30, %26) : (index, index) -> index
    %32 = "arith.index_cast"(%31) : (index) -> i32
    %33 = "llvm.mlir.poison"() : () -> vector<17xi32>
    %34 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %35 = "llvm.insertelement"(%33, %32, %34) : (vector<17xi32>, i32, i32) -> vector<17xi32>
    %36 = "llvm.shufflevector"(%35, %33) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<17xi32>, vector<17xi32>) -> vector<17xi32>
    %37 = "arith.cmpi"(%36, %27) <{predicate = 4 : i64}> : (vector<17xi32>, vector<17xi32>) -> vector<17xi1>
    %38 = "llvm.extractvalue"(%24) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %39 = "llvm.extractvalue"(%24) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %40 = "llvm.mul"(%23, %39) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %41 = "llvm.add"(%40, %22) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %42 = "llvm.getelementptr"(%38, %41) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %43 = "llvm.intr.masked.load"(%42, %37, %25) <{alignment = 4 : i32}> : (!llvm.ptr, vector<17xi1>, vector<17xf32>) -> vector<17xf32>
    "func.return"(%43) : (vector<17xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf32>, index, index) -> vector<[17]xf32>, sym_name = "transfer_read_2d_to_1d_scalable"}> ({
  ^bb0(%arg0: memref<?x?xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?x?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "arith.constant"() <{value = dense<7.000000e+00> : vector<[17]xf32>}> : () -> vector<[17]xf32>
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "memref.dim"(%arg0, %4) : (memref<?x?xf32>, index) -> index
    %6 = "arith.subi"(%5, %arg2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %7 = "llvm.intr.stepvector"() : () -> vector<[17]xi32>
    %8 = "arith.constant"() <{value = 2147483647 : index}> : () -> index
    %9 = "arith.minsi"(%6, %8) : (index, index) -> index
    %10 = "arith.index_cast"(%9) : (index) -> i32
    %11 = "llvm.mlir.poison"() : () -> vector<[17]xi32>
    %12 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %13 = "llvm.insertelement"(%11, %10, %12) : (vector<[17]xi32>, i32, i32) -> vector<[17]xi32>
    %14 = "llvm.shufflevector"(%13, %11) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[17]xi32>, vector<[17]xi32>) -> vector<[17]xi32>
    %15 = "arith.cmpi"(%7, %14) <{predicate = 2 : i64}> : (vector<[17]xi32>, vector<[17]xi32>) -> vector<[17]xi1>
    %16 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %17 = "llvm.extractvalue"(%2) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %18 = "llvm.mul"(%1, %17) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %19 = "llvm.add"(%18, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %20 = "llvm.getelementptr"(%16, %19) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %21 = "llvm.intr.masked.load"(%20, %15, %3) <{alignment = 4 : i32}> : (!llvm.ptr, vector<[17]xi1>, vector<[17]xf32>) -> vector<[17]xf32>
    "func.return"(%21) : (vector<[17]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, 3>, index) -> vector<17xf32>, sym_name = "transfer_read_write_1d_non_zero_addrspace"}> ({
  ^bb0(%arg2: memref<?xf32, 3>, %arg3: index):
    %31 = "builtin.unrealized_conversion_cast"(%arg3) : (index) -> i64
    %32 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<?xf32, 3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
    %33 = "arith.constant"() <{value = dense<7.000000e+00> : vector<17xf32>}> : () -> vector<17xf32>
    %34 = "arith.constant"() <{value = 2147483647 : index}> : () -> index
    %35 = "arith.constant"() <{value = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : vector<17xi32>}> : () -> vector<17xi32>
    %36 = "arith.constant"() <{value = 0 : index}> : () -> index
    %37 = "memref.dim"(%arg2, %36) : (memref<?xf32, 3>, index) -> index
    %38 = "arith.subi"(%37, %arg3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %39 = "arith.minsi"(%38, %34) : (index, index) -> index
    %40 = "arith.index_cast"(%39) : (index) -> i32
    %41 = "llvm.mlir.poison"() : () -> vector<17xi32>
    %42 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %43 = "llvm.insertelement"(%41, %40, %42) : (vector<17xi32>, i32, i32) -> vector<17xi32>
    %44 = "llvm.shufflevector"(%43, %41) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<17xi32>, vector<17xi32>) -> vector<17xi32>
    %45 = "arith.cmpi"(%44, %35) <{predicate = 4 : i64}> : (vector<17xi32>, vector<17xi32>) -> vector<17xi1>
    %46 = "llvm.extractvalue"(%32) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
    %47 = "llvm.getelementptr"(%46, %31) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
    %48 = "llvm.intr.masked.load"(%47, %45, %33) <{alignment = 4 : i32}> : (!llvm.ptr<3>, vector<17xi1>, vector<17xf32>) -> vector<17xf32>
    %49 = "memref.dim"(%arg2, %36) : (memref<?xf32, 3>, index) -> index
    %50 = "arith.subi"(%49, %arg3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %51 = "arith.minsi"(%50, %34) : (index, index) -> index
    %52 = "arith.index_cast"(%51) : (index) -> i32
    %53 = "llvm.mlir.poison"() : () -> vector<17xi32>
    %54 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %55 = "llvm.insertelement"(%53, %52, %54) : (vector<17xi32>, i32, i32) -> vector<17xi32>
    %56 = "llvm.shufflevector"(%55, %53) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<17xi32>, vector<17xi32>) -> vector<17xi32>
    %57 = "arith.cmpi"(%56, %35) <{predicate = 4 : i64}> : (vector<17xi32>, vector<17xi32>) -> vector<17xi1>
    %58 = "llvm.extractvalue"(%32) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
    %59 = "llvm.getelementptr"(%58, %31) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
    "llvm.intr.masked.store"(%48, %59, %57) <{alignment = 4 : i32}> : (vector<17xf32>, !llvm.ptr<3>, vector<17xi1>) -> ()
    "func.return"(%48) : (vector<17xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, 3>, index) -> vector<[17]xf32>, sym_name = "transfer_read_write_1d_non_zero_addrspace_scalable"}> ({
  ^bb0(%arg0: memref<?xf32, 3>, %arg1: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32, 3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
    %2 = "arith.constant"() <{value = dense<7.000000e+00> : vector<[17]xf32>}> : () -> vector<[17]xf32>
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "memref.dim"(%arg0, %3) : (memref<?xf32, 3>, index) -> index
    %5 = "arith.subi"(%4, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %6 = "llvm.intr.stepvector"() : () -> vector<[17]xi32>
    %7 = "arith.constant"() <{value = 2147483647 : index}> : () -> index
    %8 = "arith.minsi"(%5, %7) : (index, index) -> index
    %9 = "arith.index_cast"(%8) : (index) -> i32
    %10 = "llvm.mlir.poison"() : () -> vector<[17]xi32>
    %11 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %12 = "llvm.insertelement"(%10, %9, %11) : (vector<[17]xi32>, i32, i32) -> vector<[17]xi32>
    %13 = "llvm.shufflevector"(%12, %10) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[17]xi32>, vector<[17]xi32>) -> vector<[17]xi32>
    %14 = "arith.cmpi"(%6, %13) <{predicate = 2 : i64}> : (vector<[17]xi32>, vector<[17]xi32>) -> vector<[17]xi1>
    %15 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
    %16 = "llvm.getelementptr"(%15, %0) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
    %17 = "llvm.intr.masked.load"(%16, %14, %2) <{alignment = 4 : i32}> : (!llvm.ptr<3>, vector<[17]xi1>, vector<[17]xf32>) -> vector<[17]xf32>
    %18 = "memref.dim"(%arg0, %3) : (memref<?xf32, 3>, index) -> index
    %19 = "arith.subi"(%18, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %20 = "llvm.intr.stepvector"() : () -> vector<[17]xi32>
    %21 = "arith.constant"() <{value = 2147483647 : index}> : () -> index
    %22 = "arith.minsi"(%19, %21) : (index, index) -> index
    %23 = "arith.index_cast"(%22) : (index) -> i32
    %24 = "llvm.mlir.poison"() : () -> vector<[17]xi32>
    %25 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %26 = "llvm.insertelement"(%24, %23, %25) : (vector<[17]xi32>, i32, i32) -> vector<[17]xi32>
    %27 = "llvm.shufflevector"(%26, %24) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[17]xi32>, vector<[17]xi32>) -> vector<[17]xi32>
    %28 = "arith.cmpi"(%20, %27) <{predicate = 2 : i64}> : (vector<[17]xi32>, vector<[17]xi32>) -> vector<[17]xi1>
    %29 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
    %30 = "llvm.getelementptr"(%29, %0) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
    "llvm.intr.masked.store"(%17, %30, %28) <{alignment = 4 : i32}> : (vector<[17]xf32>, !llvm.ptr<3>, vector<[17]xi1>) -> ()
    "func.return"(%17) : (vector<[17]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, index) -> vector<17xf32>, sym_name = "transfer_read_1d_inbounds"}> ({
  ^bb0(%arg2: memref<?xf32>, %arg3: index):
    %5 = "builtin.unrealized_conversion_cast"(%arg3) : (index) -> i64
    %6 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %7 = "llvm.extractvalue"(%6) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %8 = "llvm.getelementptr"(%7, %5) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %9 = "llvm.load"(%8) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> vector<17xf32>
    "func.return"(%9) : (vector<17xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index) -> vector<[17]xf32>, sym_name = "transfer_read_1d_inbounds_scalable"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %4 = "llvm.load"(%3) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> vector<[17]xf32>
    "func.return"(%4) : (vector<[17]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, index) -> vector<5xf32>, sym_name = "transfer_read_write_1d_mask"}> ({
  ^bb0(%arg3: memref<?xf32>, %arg4: index):
    %33 = "builtin.unrealized_conversion_cast"(%arg4) : (index) -> i64
    %34 = "builtin.unrealized_conversion_cast"(%arg3) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %35 = "arith.constant"() <{value = dense<7.000000e+00> : vector<5xf32>}> : () -> vector<5xf32>
    %36 = "arith.constant"() <{value = 2147483647 : index}> : () -> index
    %37 = "arith.constant"() <{value = dense<[0, 1, 2, 3, 4]> : vector<5xi32>}> : () -> vector<5xi32>
    %38 = "arith.constant"() <{value = dense<[false, false, true, false, true]> : vector<5xi1>}> : () -> vector<5xi1>
    %39 = "arith.constant"() <{value = 0 : index}> : () -> index
    %40 = "memref.dim"(%arg3, %39) : (memref<?xf32>, index) -> index
    %41 = "arith.subi"(%40, %arg4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %42 = "arith.minsi"(%41, %36) : (index, index) -> index
    %43 = "arith.index_cast"(%42) : (index) -> i32
    %44 = "llvm.mlir.poison"() : () -> vector<5xi32>
    %45 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %46 = "llvm.insertelement"(%44, %43, %45) : (vector<5xi32>, i32, i32) -> vector<5xi32>
    %47 = "llvm.shufflevector"(%46, %44) <{mask = array<i32: 0, 0, 0, 0, 0>}> : (vector<5xi32>, vector<5xi32>) -> vector<5xi32>
    %48 = "arith.cmpi"(%47, %37) <{predicate = 4 : i64}> : (vector<5xi32>, vector<5xi32>) -> vector<5xi1>
    %49 = "arith.andi"(%48, %38) : (vector<5xi1>, vector<5xi1>) -> vector<5xi1>
    %50 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %51 = "llvm.getelementptr"(%50, %33) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %52 = "llvm.intr.masked.load"(%51, %49, %35) <{alignment = 4 : i32}> : (!llvm.ptr, vector<5xi1>, vector<5xf32>) -> vector<5xf32>
    %53 = "memref.dim"(%arg3, %39) : (memref<?xf32>, index) -> index
    %54 = "arith.subi"(%53, %arg4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %55 = "arith.minsi"(%54, %36) : (index, index) -> index
    %56 = "arith.index_cast"(%55) : (index) -> i32
    %57 = "llvm.mlir.poison"() : () -> vector<5xi32>
    %58 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %59 = "llvm.insertelement"(%57, %56, %58) : (vector<5xi32>, i32, i32) -> vector<5xi32>
    %60 = "llvm.shufflevector"(%59, %57) <{mask = array<i32: 0, 0, 0, 0, 0>}> : (vector<5xi32>, vector<5xi32>) -> vector<5xi32>
    %61 = "arith.cmpi"(%60, %37) <{predicate = 4 : i64}> : (vector<5xi32>, vector<5xi32>) -> vector<5xi1>
    %62 = "arith.andi"(%61, %38) : (vector<5xi1>, vector<5xi1>) -> vector<5xi1>
    %63 = "llvm.extractvalue"(%34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %64 = "llvm.getelementptr"(%63, %33) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.masked.store"(%52, %64, %62) <{alignment = 4 : i32}> : (vector<5xf32>, !llvm.ptr, vector<5xi1>) -> ()
    "func.return"(%52) : (vector<5xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index, vector<[5]xi1>) -> vector<[5]xf32>, sym_name = "transfer_read_write_1d_mask_scalable"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: index, %arg2: vector<[5]xi1>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = "arith.constant"() <{value = dense<7.000000e+00> : vector<[5]xf32>}> : () -> vector<[5]xf32>
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "memref.dim"(%arg0, %3) : (memref<?xf32>, index) -> index
    %5 = "arith.subi"(%4, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %6 = "llvm.intr.stepvector"() : () -> vector<[5]xi32>
    %7 = "arith.constant"() <{value = 2147483647 : index}> : () -> index
    %8 = "arith.minsi"(%5, %7) : (index, index) -> index
    %9 = "arith.index_cast"(%8) : (index) -> i32
    %10 = "llvm.mlir.poison"() : () -> vector<[5]xi32>
    %11 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %12 = "llvm.insertelement"(%10, %9, %11) : (vector<[5]xi32>, i32, i32) -> vector<[5]xi32>
    %13 = "llvm.shufflevector"(%12, %10) <{mask = array<i32: 0, 0, 0, 0, 0>}> : (vector<[5]xi32>, vector<[5]xi32>) -> vector<[5]xi32>
    %14 = "arith.cmpi"(%6, %13) <{predicate = 2 : i64}> : (vector<[5]xi32>, vector<[5]xi32>) -> vector<[5]xi1>
    %15 = "arith.andi"(%14, %arg2) : (vector<[5]xi1>, vector<[5]xi1>) -> vector<[5]xi1>
    %16 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %17 = "llvm.getelementptr"(%16, %0) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %18 = "llvm.intr.masked.load"(%17, %15, %2) <{alignment = 4 : i32}> : (!llvm.ptr, vector<[5]xi1>, vector<[5]xf32>) -> vector<[5]xf32>
    %19 = "memref.dim"(%arg0, %3) : (memref<?xf32>, index) -> index
    %20 = "arith.subi"(%19, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %21 = "llvm.intr.stepvector"() : () -> vector<[5]xi32>
    %22 = "arith.constant"() <{value = 2147483647 : index}> : () -> index
    %23 = "arith.minsi"(%20, %22) : (index, index) -> index
    %24 = "arith.index_cast"(%23) : (index) -> i32
    %25 = "llvm.mlir.poison"() : () -> vector<[5]xi32>
    %26 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %27 = "llvm.insertelement"(%25, %24, %26) : (vector<[5]xi32>, i32, i32) -> vector<[5]xi32>
    %28 = "llvm.shufflevector"(%27, %25) <{mask = array<i32: 0, 0, 0, 0, 0>}> : (vector<[5]xi32>, vector<[5]xi32>) -> vector<[5]xi32>
    %29 = "arith.cmpi"(%21, %28) <{predicate = 2 : i64}> : (vector<[5]xi32>, vector<[5]xi32>) -> vector<[5]xi1>
    %30 = "arith.andi"(%29, %arg2) : (vector<[5]xi1>, vector<[5]xi1>) -> vector<[5]xi1>
    %31 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %32 = "llvm.getelementptr"(%31, %0) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.masked.store"(%18, %32, %30) <{alignment = 4 : i32}> : (vector<[5]xf32>, !llvm.ptr, vector<[5]xi1>) -> ()
    "func.return"(%18) : (vector<[5]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, index) -> vector<4xf32>, sym_name = "transfer_read_write_tensor"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 2147483647 : index}> : () -> index
    %1 = "arith.constant"() <{value = dense<[0, 1, 2, 3]> : vector<4xi32>}> : () -> vector<4xi32>
    %2 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "tensor.dim"(%arg0, %3) : (tensor<?xf32>, index) -> index
    %5 = "arith.subi"(%4, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %6 = "arith.minsi"(%5, %0) : (index, index) -> index
    %7 = "arith.index_cast"(%6) : (index) -> i32
    %8 = "llvm.mlir.poison"() : () -> vector<4xi32>
    %9 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %10 = "llvm.insertelement"(%8, %7, %9) : (vector<4xi32>, i32, i32) -> vector<4xi32>
    %11 = "llvm.shufflevector"(%10, %8) <{mask = array<i32: 0, 0, 0, 0>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %12 = "arith.cmpi"(%11, %1) <{predicate = 4 : i64}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
    %13 = "vector.transfer_read"(%arg0, %arg1, %2, %12) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 1>, permutation_map = #map}> : (tensor<?xf32>, index, f32, vector<4xi1>) -> vector<4xf32>
    %14 = "tensor.dim"(%arg0, %3) : (tensor<?xf32>, index) -> index
    %15 = "arith.minsi"(%14, %0) : (index, index) -> index
    %16 = "arith.index_cast"(%15) : (index) -> i32
    %17 = "llvm.mlir.poison"() : () -> vector<4xi32>
    %18 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %19 = "llvm.insertelement"(%17, %16, %18) : (vector<4xi32>, i32, i32) -> vector<4xi32>
    %20 = "llvm.shufflevector"(%19, %17) <{mask = array<i32: 0, 0, 0, 0>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %21 = "arith.cmpi"(%20, %1) <{predicate = 4 : i64}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
    %22 = "vector.transfer_write"(%13, %arg0, %3, %21) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 1>, permutation_map = #map}> : (vector<4xf32>, tensor<?xf32>, index, vector<4xi1>) -> tensor<?xf32>
    "test.some_use"(%22) : (tensor<?xf32>) -> ()
    "func.return"(%13) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

