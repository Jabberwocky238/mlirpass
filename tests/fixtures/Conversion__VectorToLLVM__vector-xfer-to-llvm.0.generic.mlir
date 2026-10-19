"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, index) -> vector<17xf32>, sym_name = "transfer_read_write_1d"}> ({
  ^bb0(%arg2: memref<?xf32>, %arg3: index):
    %27 = "builtin.unrealized_conversion_cast"(%arg3) : (index) -> i64
    %28 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %29 = "arith.constant"() <{value = dense<7.000000e+00> : vector<17xf32>}> : () -> vector<17xf32>
    %30 = "arith.constant"() <{value = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : vector<17xi32>}> : () -> vector<17xi32>
    %31 = "arith.constant"() <{value = 0 : index}> : () -> index
    %32 = "memref.dim"(%arg2, %31) : (memref<?xf32>, index) -> index
    %33 = "arith.subi"(%32, %arg3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %34 = "arith.index_cast"(%33) : (index) -> i32
    %35 = "llvm.mlir.poison"() : () -> vector<17xi32>
    %36 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %37 = "llvm.insertelement"(%35, %34, %36) : (vector<17xi32>, i32, i32) -> vector<17xi32>
    %38 = "llvm.shufflevector"(%37, %35) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<17xi32>, vector<17xi32>) -> vector<17xi32>
    %39 = "arith.cmpi"(%38, %30) <{predicate = 4 : i64}> : (vector<17xi32>, vector<17xi32>) -> vector<17xi1>
    %40 = "llvm.extractvalue"(%28) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %41 = "llvm.getelementptr"(%40, %27) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %42 = "llvm.intr.masked.load"(%41, %39, %29) <{alignment = 4 : i32}> : (!llvm.ptr, vector<17xi1>, vector<17xf32>) -> vector<17xf32>
    %43 = "memref.dim"(%arg2, %31) : (memref<?xf32>, index) -> index
    %44 = "arith.subi"(%43, %arg3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %45 = "arith.index_cast"(%44) : (index) -> i32
    %46 = "llvm.mlir.poison"() : () -> vector<17xi32>
    %47 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %48 = "llvm.insertelement"(%46, %45, %47) : (vector<17xi32>, i32, i32) -> vector<17xi32>
    %49 = "llvm.shufflevector"(%48, %46) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<17xi32>, vector<17xi32>) -> vector<17xi32>
    %50 = "arith.cmpi"(%49, %30) <{predicate = 4 : i64}> : (vector<17xi32>, vector<17xi32>) -> vector<17xi1>
    %51 = "llvm.extractvalue"(%28) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %52 = "llvm.getelementptr"(%51, %27) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.masked.store"(%42, %52, %50) <{alignment = 4 : i32}> : (vector<17xf32>, !llvm.ptr, vector<17xi1>) -> ()
    "func.return"(%42) : (vector<17xf32>) -> ()
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
    %7 = "arith.index_cast"(%5) : (index) -> i32
    %8 = "llvm.mlir.poison"() : () -> vector<[17]xi32>
    %9 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %10 = "llvm.insertelement"(%8, %7, %9) : (vector<[17]xi32>, i32, i32) -> vector<[17]xi32>
    %11 = "llvm.shufflevector"(%10, %8) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[17]xi32>, vector<[17]xi32>) -> vector<[17]xi32>
    %12 = "arith.cmpi"(%6, %11) <{predicate = 2 : i64}> : (vector<[17]xi32>, vector<[17]xi32>) -> vector<[17]xi1>
    %13 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %14 = "llvm.getelementptr"(%13, %0) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %15 = "llvm.intr.masked.load"(%14, %12, %2) <{alignment = 4 : i32}> : (!llvm.ptr, vector<[17]xi1>, vector<[17]xf32>) -> vector<[17]xf32>
    %16 = "memref.dim"(%arg0, %3) : (memref<?xf32>, index) -> index
    %17 = "arith.subi"(%16, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %18 = "llvm.intr.stepvector"() : () -> vector<[17]xi32>
    %19 = "arith.index_cast"(%17) : (index) -> i32
    %20 = "llvm.mlir.poison"() : () -> vector<[17]xi32>
    %21 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %22 = "llvm.insertelement"(%20, %19, %21) : (vector<[17]xi32>, i32, i32) -> vector<[17]xi32>
    %23 = "llvm.shufflevector"(%22, %20) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[17]xi32>, vector<[17]xi32>) -> vector<[17]xi32>
    %24 = "arith.cmpi"(%18, %23) <{predicate = 2 : i64}> : (vector<[17]xi32>, vector<[17]xi32>) -> vector<[17]xi1>
    %25 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %26 = "llvm.getelementptr"(%25, %0) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.masked.store"(%15, %26, %24) <{alignment = 4 : i32}> : (vector<[17]xf32>, !llvm.ptr, vector<[17]xi1>) -> ()
    "func.return"(%15) : (vector<[17]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xindex>, index) -> vector<17xindex>, sym_name = "transfer_read_write_index_1d"}> ({
  ^bb0(%arg2: memref<?xindex>, %arg3: index):
    %29 = "builtin.unrealized_conversion_cast"(%arg3) : (index) -> i64
    %30 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<?xindex>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %31 = "arith.constant"() <{value = dense<7> : vector<17xindex>}> : () -> vector<17xindex>
    %32 = "builtin.unrealized_conversion_cast"(%31) : (vector<17xindex>) -> vector<17xi64>
    %33 = "arith.constant"() <{value = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : vector<17xi32>}> : () -> vector<17xi32>
    %34 = "arith.constant"() <{value = 0 : index}> : () -> index
    %35 = "memref.dim"(%arg2, %34) : (memref<?xindex>, index) -> index
    %36 = "arith.subi"(%35, %arg3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %37 = "arith.index_cast"(%36) : (index) -> i32
    %38 = "llvm.mlir.poison"() : () -> vector<17xi32>
    %39 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %40 = "llvm.insertelement"(%38, %37, %39) : (vector<17xi32>, i32, i32) -> vector<17xi32>
    %41 = "llvm.shufflevector"(%40, %38) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<17xi32>, vector<17xi32>) -> vector<17xi32>
    %42 = "arith.cmpi"(%41, %33) <{predicate = 4 : i64}> : (vector<17xi32>, vector<17xi32>) -> vector<17xi1>
    %43 = "llvm.extractvalue"(%30) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %44 = "llvm.getelementptr"(%43, %29) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %45 = "llvm.intr.masked.load"(%44, %42, %32) <{alignment = 8 : i32}> : (!llvm.ptr, vector<17xi1>, vector<17xi64>) -> vector<17xi64>
    %46 = "builtin.unrealized_conversion_cast"(%45) : (vector<17xi64>) -> vector<17xindex>
    %47 = "memref.dim"(%arg2, %34) : (memref<?xindex>, index) -> index
    %48 = "arith.subi"(%47, %arg3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %49 = "arith.index_cast"(%48) : (index) -> i32
    %50 = "llvm.mlir.poison"() : () -> vector<17xi32>
    %51 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %52 = "llvm.insertelement"(%50, %49, %51) : (vector<17xi32>, i32, i32) -> vector<17xi32>
    %53 = "llvm.shufflevector"(%52, %50) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<17xi32>, vector<17xi32>) -> vector<17xi32>
    %54 = "arith.cmpi"(%53, %33) <{predicate = 4 : i64}> : (vector<17xi32>, vector<17xi32>) -> vector<17xi1>
    %55 = "llvm.extractvalue"(%30) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %56 = "llvm.getelementptr"(%55, %29) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.masked.store"(%45, %56, %54) <{alignment = 8 : i32}> : (vector<17xi64>, !llvm.ptr, vector<17xi1>) -> ()
    "func.return"(%46) : (vector<17xindex>) -> ()
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
    %8 = "arith.index_cast"(%6) : (index) -> i32
    %9 = "llvm.mlir.poison"() : () -> vector<[17]xi32>
    %10 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %11 = "llvm.insertelement"(%9, %8, %10) : (vector<[17]xi32>, i32, i32) -> vector<[17]xi32>
    %12 = "llvm.shufflevector"(%11, %9) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[17]xi32>, vector<[17]xi32>) -> vector<[17]xi32>
    %13 = "arith.cmpi"(%7, %12) <{predicate = 2 : i64}> : (vector<[17]xi32>, vector<[17]xi32>) -> vector<[17]xi1>
    %14 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %15 = "llvm.getelementptr"(%14, %0) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %16 = "llvm.intr.masked.load"(%15, %13, %3) <{alignment = 8 : i32}> : (!llvm.ptr, vector<[17]xi1>, vector<[17]xi64>) -> vector<[17]xi64>
    %17 = "builtin.unrealized_conversion_cast"(%16) : (vector<[17]xi64>) -> vector<[17]xindex>
    %18 = "memref.dim"(%arg0, %4) : (memref<?xindex>, index) -> index
    %19 = "arith.subi"(%18, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %20 = "llvm.intr.stepvector"() : () -> vector<[17]xi32>
    %21 = "arith.index_cast"(%19) : (index) -> i32
    %22 = "llvm.mlir.poison"() : () -> vector<[17]xi32>
    %23 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %24 = "llvm.insertelement"(%22, %21, %23) : (vector<[17]xi32>, i32, i32) -> vector<[17]xi32>
    %25 = "llvm.shufflevector"(%24, %22) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[17]xi32>, vector<[17]xi32>) -> vector<[17]xi32>
    %26 = "arith.cmpi"(%20, %25) <{predicate = 2 : i64}> : (vector<[17]xi32>, vector<[17]xi32>) -> vector<[17]xi1>
    %27 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %28 = "llvm.getelementptr"(%27, %0) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.masked.store"(%16, %28, %26) <{alignment = 8 : i32}> : (vector<[17]xi64>, !llvm.ptr, vector<[17]xi1>) -> ()
    "func.return"(%17) : (vector<[17]xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, index, index) -> vector<17xf32>, sym_name = "transfer_read_2d_to_1d"}> ({
  ^bb0(%arg3: memref<?x?xf32>, %arg4: index, %arg5: index):
    %20 = "builtin.unrealized_conversion_cast"(%arg5) : (index) -> i64
    %21 = "builtin.unrealized_conversion_cast"(%arg4) : (index) -> i64
    %22 = "builtin.unrealized_conversion_cast"(%arg3) : (memref<?x?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %23 = "arith.constant"() <{value = dense<7.000000e+00> : vector<17xf32>}> : () -> vector<17xf32>
    %24 = "arith.constant"() <{value = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : vector<17xi32>}> : () -> vector<17xi32>
    %25 = "arith.constant"() <{value = 1 : index}> : () -> index
    %26 = "memref.dim"(%arg3, %25) : (memref<?x?xf32>, index) -> index
    %27 = "arith.subi"(%26, %arg5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %28 = "arith.index_cast"(%27) : (index) -> i32
    %29 = "llvm.mlir.poison"() : () -> vector<17xi32>
    %30 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %31 = "llvm.insertelement"(%29, %28, %30) : (vector<17xi32>, i32, i32) -> vector<17xi32>
    %32 = "llvm.shufflevector"(%31, %29) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<17xi32>, vector<17xi32>) -> vector<17xi32>
    %33 = "arith.cmpi"(%32, %24) <{predicate = 4 : i64}> : (vector<17xi32>, vector<17xi32>) -> vector<17xi1>
    %34 = "llvm.extractvalue"(%22) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %35 = "llvm.extractvalue"(%22) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %36 = "llvm.mul"(%21, %35) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %37 = "llvm.add"(%36, %20) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %38 = "llvm.getelementptr"(%34, %37) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %39 = "llvm.intr.masked.load"(%38, %33, %23) <{alignment = 4 : i32}> : (!llvm.ptr, vector<17xi1>, vector<17xf32>) -> vector<17xf32>
    "func.return"(%39) : (vector<17xf32>) -> ()
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
    %8 = "arith.index_cast"(%6) : (index) -> i32
    %9 = "llvm.mlir.poison"() : () -> vector<[17]xi32>
    %10 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %11 = "llvm.insertelement"(%9, %8, %10) : (vector<[17]xi32>, i32, i32) -> vector<[17]xi32>
    %12 = "llvm.shufflevector"(%11, %9) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[17]xi32>, vector<[17]xi32>) -> vector<[17]xi32>
    %13 = "arith.cmpi"(%7, %12) <{predicate = 2 : i64}> : (vector<[17]xi32>, vector<[17]xi32>) -> vector<[17]xi1>
    %14 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %15 = "llvm.extractvalue"(%2) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %16 = "llvm.mul"(%1, %15) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %17 = "llvm.add"(%16, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %18 = "llvm.getelementptr"(%14, %17) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %19 = "llvm.intr.masked.load"(%18, %13, %3) <{alignment = 4 : i32}> : (!llvm.ptr, vector<[17]xi1>, vector<[17]xf32>) -> vector<[17]xf32>
    "func.return"(%19) : (vector<[17]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, 3>, index) -> vector<17xf32>, sym_name = "transfer_read_write_1d_non_zero_addrspace"}> ({
  ^bb0(%arg2: memref<?xf32, 3>, %arg3: index):
    %27 = "builtin.unrealized_conversion_cast"(%arg3) : (index) -> i64
    %28 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<?xf32, 3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
    %29 = "arith.constant"() <{value = dense<7.000000e+00> : vector<17xf32>}> : () -> vector<17xf32>
    %30 = "arith.constant"() <{value = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : vector<17xi32>}> : () -> vector<17xi32>
    %31 = "arith.constant"() <{value = 0 : index}> : () -> index
    %32 = "memref.dim"(%arg2, %31) : (memref<?xf32, 3>, index) -> index
    %33 = "arith.subi"(%32, %arg3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %34 = "arith.index_cast"(%33) : (index) -> i32
    %35 = "llvm.mlir.poison"() : () -> vector<17xi32>
    %36 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %37 = "llvm.insertelement"(%35, %34, %36) : (vector<17xi32>, i32, i32) -> vector<17xi32>
    %38 = "llvm.shufflevector"(%37, %35) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<17xi32>, vector<17xi32>) -> vector<17xi32>
    %39 = "arith.cmpi"(%38, %30) <{predicate = 4 : i64}> : (vector<17xi32>, vector<17xi32>) -> vector<17xi1>
    %40 = "llvm.extractvalue"(%28) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
    %41 = "llvm.getelementptr"(%40, %27) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
    %42 = "llvm.intr.masked.load"(%41, %39, %29) <{alignment = 4 : i32}> : (!llvm.ptr<3>, vector<17xi1>, vector<17xf32>) -> vector<17xf32>
    %43 = "memref.dim"(%arg2, %31) : (memref<?xf32, 3>, index) -> index
    %44 = "arith.subi"(%43, %arg3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %45 = "arith.index_cast"(%44) : (index) -> i32
    %46 = "llvm.mlir.poison"() : () -> vector<17xi32>
    %47 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %48 = "llvm.insertelement"(%46, %45, %47) : (vector<17xi32>, i32, i32) -> vector<17xi32>
    %49 = "llvm.shufflevector"(%48, %46) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<17xi32>, vector<17xi32>) -> vector<17xi32>
    %50 = "arith.cmpi"(%49, %30) <{predicate = 4 : i64}> : (vector<17xi32>, vector<17xi32>) -> vector<17xi1>
    %51 = "llvm.extractvalue"(%28) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
    %52 = "llvm.getelementptr"(%51, %27) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
    "llvm.intr.masked.store"(%42, %52, %50) <{alignment = 4 : i32}> : (vector<17xf32>, !llvm.ptr<3>, vector<17xi1>) -> ()
    "func.return"(%42) : (vector<17xf32>) -> ()
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
    %7 = "arith.index_cast"(%5) : (index) -> i32
    %8 = "llvm.mlir.poison"() : () -> vector<[17]xi32>
    %9 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %10 = "llvm.insertelement"(%8, %7, %9) : (vector<[17]xi32>, i32, i32) -> vector<[17]xi32>
    %11 = "llvm.shufflevector"(%10, %8) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[17]xi32>, vector<[17]xi32>) -> vector<[17]xi32>
    %12 = "arith.cmpi"(%6, %11) <{predicate = 2 : i64}> : (vector<[17]xi32>, vector<[17]xi32>) -> vector<[17]xi1>
    %13 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
    %14 = "llvm.getelementptr"(%13, %0) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
    %15 = "llvm.intr.masked.load"(%14, %12, %2) <{alignment = 4 : i32}> : (!llvm.ptr<3>, vector<[17]xi1>, vector<[17]xf32>) -> vector<[17]xf32>
    %16 = "memref.dim"(%arg0, %3) : (memref<?xf32, 3>, index) -> index
    %17 = "arith.subi"(%16, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %18 = "llvm.intr.stepvector"() : () -> vector<[17]xi32>
    %19 = "arith.index_cast"(%17) : (index) -> i32
    %20 = "llvm.mlir.poison"() : () -> vector<[17]xi32>
    %21 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %22 = "llvm.insertelement"(%20, %19, %21) : (vector<[17]xi32>, i32, i32) -> vector<[17]xi32>
    %23 = "llvm.shufflevector"(%22, %20) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[17]xi32>, vector<[17]xi32>) -> vector<[17]xi32>
    %24 = "arith.cmpi"(%18, %23) <{predicate = 2 : i64}> : (vector<[17]xi32>, vector<[17]xi32>) -> vector<[17]xi1>
    %25 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
    %26 = "llvm.getelementptr"(%25, %0) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
    "llvm.intr.masked.store"(%15, %26, %24) <{alignment = 4 : i32}> : (vector<[17]xf32>, !llvm.ptr<3>, vector<[17]xi1>) -> ()
    "func.return"(%15) : (vector<[17]xf32>) -> ()
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
    %29 = "builtin.unrealized_conversion_cast"(%arg4) : (index) -> i64
    %30 = "builtin.unrealized_conversion_cast"(%arg3) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %31 = "arith.constant"() <{value = dense<7.000000e+00> : vector<5xf32>}> : () -> vector<5xf32>
    %32 = "arith.constant"() <{value = dense<[0, 1, 2, 3, 4]> : vector<5xi32>}> : () -> vector<5xi32>
    %33 = "arith.constant"() <{value = dense<[false, false, true, false, true]> : vector<5xi1>}> : () -> vector<5xi1>
    %34 = "arith.constant"() <{value = 0 : index}> : () -> index
    %35 = "memref.dim"(%arg3, %34) : (memref<?xf32>, index) -> index
    %36 = "arith.subi"(%35, %arg4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %37 = "arith.index_cast"(%36) : (index) -> i32
    %38 = "llvm.mlir.poison"() : () -> vector<5xi32>
    %39 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %40 = "llvm.insertelement"(%38, %37, %39) : (vector<5xi32>, i32, i32) -> vector<5xi32>
    %41 = "llvm.shufflevector"(%40, %38) <{mask = array<i32: 0, 0, 0, 0, 0>}> : (vector<5xi32>, vector<5xi32>) -> vector<5xi32>
    %42 = "arith.cmpi"(%41, %32) <{predicate = 4 : i64}> : (vector<5xi32>, vector<5xi32>) -> vector<5xi1>
    %43 = "arith.andi"(%42, %33) : (vector<5xi1>, vector<5xi1>) -> vector<5xi1>
    %44 = "llvm.extractvalue"(%30) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %45 = "llvm.getelementptr"(%44, %29) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %46 = "llvm.intr.masked.load"(%45, %43, %31) <{alignment = 4 : i32}> : (!llvm.ptr, vector<5xi1>, vector<5xf32>) -> vector<5xf32>
    %47 = "memref.dim"(%arg3, %34) : (memref<?xf32>, index) -> index
    %48 = "arith.subi"(%47, %arg4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %49 = "arith.index_cast"(%48) : (index) -> i32
    %50 = "llvm.mlir.poison"() : () -> vector<5xi32>
    %51 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %52 = "llvm.insertelement"(%50, %49, %51) : (vector<5xi32>, i32, i32) -> vector<5xi32>
    %53 = "llvm.shufflevector"(%52, %50) <{mask = array<i32: 0, 0, 0, 0, 0>}> : (vector<5xi32>, vector<5xi32>) -> vector<5xi32>
    %54 = "arith.cmpi"(%53, %32) <{predicate = 4 : i64}> : (vector<5xi32>, vector<5xi32>) -> vector<5xi1>
    %55 = "arith.andi"(%54, %33) : (vector<5xi1>, vector<5xi1>) -> vector<5xi1>
    %56 = "llvm.extractvalue"(%30) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %57 = "llvm.getelementptr"(%56, %29) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.masked.store"(%46, %57, %55) <{alignment = 4 : i32}> : (vector<5xf32>, !llvm.ptr, vector<5xi1>) -> ()
    "func.return"(%46) : (vector<5xf32>) -> ()
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
    %7 = "arith.index_cast"(%5) : (index) -> i32
    %8 = "llvm.mlir.poison"() : () -> vector<[5]xi32>
    %9 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %10 = "llvm.insertelement"(%8, %7, %9) : (vector<[5]xi32>, i32, i32) -> vector<[5]xi32>
    %11 = "llvm.shufflevector"(%10, %8) <{mask = array<i32: 0, 0, 0, 0, 0>}> : (vector<[5]xi32>, vector<[5]xi32>) -> vector<[5]xi32>
    %12 = "arith.cmpi"(%6, %11) <{predicate = 2 : i64}> : (vector<[5]xi32>, vector<[5]xi32>) -> vector<[5]xi1>
    %13 = "arith.andi"(%12, %arg2) : (vector<[5]xi1>, vector<[5]xi1>) -> vector<[5]xi1>
    %14 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %15 = "llvm.getelementptr"(%14, %0) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %16 = "llvm.intr.masked.load"(%15, %13, %2) <{alignment = 4 : i32}> : (!llvm.ptr, vector<[5]xi1>, vector<[5]xf32>) -> vector<[5]xf32>
    %17 = "memref.dim"(%arg0, %3) : (memref<?xf32>, index) -> index
    %18 = "arith.subi"(%17, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %19 = "llvm.intr.stepvector"() : () -> vector<[5]xi32>
    %20 = "arith.index_cast"(%18) : (index) -> i32
    %21 = "llvm.mlir.poison"() : () -> vector<[5]xi32>
    %22 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %23 = "llvm.insertelement"(%21, %20, %22) : (vector<[5]xi32>, i32, i32) -> vector<[5]xi32>
    %24 = "llvm.shufflevector"(%23, %21) <{mask = array<i32: 0, 0, 0, 0, 0>}> : (vector<[5]xi32>, vector<[5]xi32>) -> vector<[5]xi32>
    %25 = "arith.cmpi"(%19, %24) <{predicate = 2 : i64}> : (vector<[5]xi32>, vector<[5]xi32>) -> vector<[5]xi1>
    %26 = "arith.andi"(%25, %arg2) : (vector<[5]xi1>, vector<[5]xi1>) -> vector<[5]xi1>
    %27 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %28 = "llvm.getelementptr"(%27, %0) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.masked.store"(%16, %28, %26) <{alignment = 4 : i32}> : (vector<[5]xf32>, !llvm.ptr, vector<[5]xi1>) -> ()
    "func.return"(%16) : (vector<[5]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, index) -> vector<4xf32>, sym_name = "transfer_read_write_tensor"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = dense<[0, 1, 2, 3]> : vector<4xi32>}> : () -> vector<4xi32>
    %1 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "tensor.dim"(%arg0, %2) : (tensor<?xf32>, index) -> index
    %4 = "arith.subi"(%3, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %5 = "arith.index_cast"(%4) : (index) -> i32
    %6 = "llvm.mlir.poison"() : () -> vector<4xi32>
    %7 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %8 = "llvm.insertelement"(%6, %5, %7) : (vector<4xi32>, i32, i32) -> vector<4xi32>
    %9 = "llvm.shufflevector"(%8, %6) <{mask = array<i32: 0, 0, 0, 0>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %10 = "arith.cmpi"(%9, %0) <{predicate = 4 : i64}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
    %11 = "vector.transfer_read"(%arg0, %arg1, %1, %10) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 1>, permutation_map = #map}> : (tensor<?xf32>, index, f32, vector<4xi1>) -> vector<4xf32>
    %12 = "tensor.dim"(%arg0, %2) : (tensor<?xf32>, index) -> index
    %13 = "arith.index_cast"(%12) : (index) -> i32
    %14 = "llvm.mlir.poison"() : () -> vector<4xi32>
    %15 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %16 = "llvm.insertelement"(%14, %13, %15) : (vector<4xi32>, i32, i32) -> vector<4xi32>
    %17 = "llvm.shufflevector"(%16, %14) <{mask = array<i32: 0, 0, 0, 0>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %18 = "arith.cmpi"(%17, %0) <{predicate = 4 : i64}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
    %19 = "vector.transfer_write"(%11, %arg0, %2, %18) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 1>, permutation_map = #map}> : (vector<4xf32>, tensor<?xf32>, index, vector<4xi1>) -> tensor<?xf32>
    "test.some_use"(%19) : (tensor<?xf32>) -> ()
    "func.return"(%11) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

