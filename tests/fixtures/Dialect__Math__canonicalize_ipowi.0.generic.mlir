"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi32>) -> (), sym_name = "ipowi32_fold"}> ({
  ^bb0(%arg3: memref<?xi32>):
    %53 = "arith.constant"() <{value = 1073741824 : i32}> : () -> i32
    %54 = "arith.constant"() <{value = -27 : i32}> : () -> i32
    %55 = "arith.constant"() <{value = 11 : index}> : () -> index
    %56 = "arith.constant"() <{value = 10 : index}> : () -> index
    %57 = "arith.constant"() <{value = 9 : index}> : () -> index
    %58 = "arith.constant"() <{value = 8 : index}> : () -> index
    %59 = "arith.constant"() <{value = 7 : index}> : () -> index
    %60 = "arith.constant"() <{value = 6 : index}> : () -> index
    %61 = "arith.constant"() <{value = 5 : index}> : () -> index
    %62 = "arith.constant"() <{value = 4 : index}> : () -> index
    %63 = "arith.constant"() <{value = 3 : index}> : () -> index
    %64 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %65 = "arith.constant"() <{value = 2 : index}> : () -> index
    %66 = "arith.constant"() <{value = 1 : index}> : () -> index
    %67 = "arith.constant"() <{value = 0 : index}> : () -> index
    %68 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %69 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "memref.store"(%69, %arg3, %67) : (i32, memref<?xi32>, index) -> ()
    "memref.store"(%69, %arg3, %66) : (i32, memref<?xi32>, index) -> ()
    "memref.store"(%69, %arg3, %65) : (i32, memref<?xi32>, index) -> ()
    %70 = "math.ipowi"(%68, %64) : (i32, i32) -> i32
    "memref.store"(%70, %arg3, %63) : (i32, memref<?xi32>, index) -> ()
    "memref.store"(%69, %arg3, %62) : (i32, memref<?xi32>, index) -> ()
    "memref.store"(%68, %arg3, %61) : (i32, memref<?xi32>, index) -> ()
    "memref.store"(%68, %arg3, %60) : (i32, memref<?xi32>, index) -> ()
    "memref.store"(%69, %arg3, %59) : (i32, memref<?xi32>, index) -> ()
    "memref.store"(%64, %arg3, %58) : (i32, memref<?xi32>, index) -> ()
    "memref.store"(%54, %arg3, %57) : (i32, memref<?xi32>, index) -> ()
    "memref.store"(%53, %arg3, %56) : (i32, memref<?xi32>, index) -> ()
    "memref.store"(%53, %arg3, %55) : (i32, memref<?xi32>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi64>) -> (), sym_name = "ipowi64_fold"}> ({
  ^bb0(%arg2: memref<?xi64>):
    %34 = "arith.constant"() <{value = 281474976710656 : i64}> : () -> i64
    %35 = "arith.constant"() <{value = 1073741824 : i64}> : () -> i64
    %36 = "arith.constant"() <{value = -27 : i64}> : () -> i64
    %37 = "arith.constant"() <{value = 11 : index}> : () -> index
    %38 = "arith.constant"() <{value = 10 : index}> : () -> index
    %39 = "arith.constant"() <{value = 9 : index}> : () -> index
    %40 = "arith.constant"() <{value = 8 : index}> : () -> index
    %41 = "arith.constant"() <{value = 7 : index}> : () -> index
    %42 = "arith.constant"() <{value = 6 : index}> : () -> index
    %43 = "arith.constant"() <{value = 5 : index}> : () -> index
    %44 = "arith.constant"() <{value = 4 : index}> : () -> index
    %45 = "arith.constant"() <{value = 3 : index}> : () -> index
    %46 = "arith.constant"() <{value = -1 : i64}> : () -> i64
    %47 = "arith.constant"() <{value = 2 : index}> : () -> index
    %48 = "arith.constant"() <{value = 1 : index}> : () -> index
    %49 = "arith.constant"() <{value = 0 : index}> : () -> index
    %50 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %51 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    "memref.store"(%51, %arg2, %49) : (i64, memref<?xi64>, index) -> ()
    "memref.store"(%51, %arg2, %48) : (i64, memref<?xi64>, index) -> ()
    "memref.store"(%51, %arg2, %47) : (i64, memref<?xi64>, index) -> ()
    %52 = "math.ipowi"(%50, %46) : (i64, i64) -> i64
    "memref.store"(%52, %arg2, %45) : (i64, memref<?xi64>, index) -> ()
    "memref.store"(%51, %arg2, %44) : (i64, memref<?xi64>, index) -> ()
    "memref.store"(%50, %arg2, %43) : (i64, memref<?xi64>, index) -> ()
    "memref.store"(%50, %arg2, %42) : (i64, memref<?xi64>, index) -> ()
    "memref.store"(%51, %arg2, %41) : (i64, memref<?xi64>, index) -> ()
    "memref.store"(%46, %arg2, %40) : (i64, memref<?xi64>, index) -> ()
    "memref.store"(%36, %arg2, %39) : (i64, memref<?xi64>, index) -> ()
    "memref.store"(%35, %arg2, %38) : (i64, memref<?xi64>, index) -> ()
    "memref.store"(%34, %arg2, %37) : (i64, memref<?xi64>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi16>) -> (), sym_name = "ipowi16_fold"}> ({
  ^bb0(%arg1: memref<?xi16>):
    %17 = "arith.constant"() <{value = 16384 : i16}> : () -> i16
    %18 = "arith.constant"() <{value = -27 : i16}> : () -> i16
    %19 = "arith.constant"() <{value = 10 : index}> : () -> index
    %20 = "arith.constant"() <{value = 9 : index}> : () -> index
    %21 = "arith.constant"() <{value = 8 : index}> : () -> index
    %22 = "arith.constant"() <{value = 7 : index}> : () -> index
    %23 = "arith.constant"() <{value = 6 : index}> : () -> index
    %24 = "arith.constant"() <{value = 5 : index}> : () -> index
    %25 = "arith.constant"() <{value = 4 : index}> : () -> index
    %26 = "arith.constant"() <{value = 3 : index}> : () -> index
    %27 = "arith.constant"() <{value = -1 : i16}> : () -> i16
    %28 = "arith.constant"() <{value = 2 : index}> : () -> index
    %29 = "arith.constant"() <{value = 1 : index}> : () -> index
    %30 = "arith.constant"() <{value = 0 : index}> : () -> index
    %31 = "arith.constant"() <{value = 0 : i16}> : () -> i16
    %32 = "arith.constant"() <{value = 1 : i16}> : () -> i16
    "memref.store"(%32, %arg1, %30) : (i16, memref<?xi16>, index) -> ()
    "memref.store"(%32, %arg1, %29) : (i16, memref<?xi16>, index) -> ()
    "memref.store"(%32, %arg1, %28) : (i16, memref<?xi16>, index) -> ()
    %33 = "math.ipowi"(%31, %27) : (i16, i16) -> i16
    "memref.store"(%33, %arg1, %26) : (i16, memref<?xi16>, index) -> ()
    "memref.store"(%32, %arg1, %25) : (i16, memref<?xi16>, index) -> ()
    "memref.store"(%31, %arg1, %24) : (i16, memref<?xi16>, index) -> ()
    "memref.store"(%31, %arg1, %23) : (i16, memref<?xi16>, index) -> ()
    "memref.store"(%32, %arg1, %22) : (i16, memref<?xi16>, index) -> ()
    "memref.store"(%27, %arg1, %21) : (i16, memref<?xi16>, index) -> ()
    "memref.store"(%18, %arg1, %20) : (i16, memref<?xi16>, index) -> ()
    "memref.store"(%17, %arg1, %19) : (i16, memref<?xi16>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi8>) -> (), sym_name = "ipowi8_fold"}> ({
  ^bb0(%arg0: memref<?xi8>):
    %0 = "arith.constant"() <{value = 64 : i8}> : () -> i8
    %1 = "arith.constant"() <{value = -27 : i8}> : () -> i8
    %2 = "arith.constant"() <{value = 10 : index}> : () -> index
    %3 = "arith.constant"() <{value = 9 : index}> : () -> index
    %4 = "arith.constant"() <{value = 8 : index}> : () -> index
    %5 = "arith.constant"() <{value = 7 : index}> : () -> index
    %6 = "arith.constant"() <{value = 6 : index}> : () -> index
    %7 = "arith.constant"() <{value = 5 : index}> : () -> index
    %8 = "arith.constant"() <{value = 4 : index}> : () -> index
    %9 = "arith.constant"() <{value = 3 : index}> : () -> index
    %10 = "arith.constant"() <{value = -1 : i8}> : () -> i8
    %11 = "arith.constant"() <{value = 2 : index}> : () -> index
    %12 = "arith.constant"() <{value = 1 : index}> : () -> index
    %13 = "arith.constant"() <{value = 0 : index}> : () -> index
    %14 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %15 = "arith.constant"() <{value = 1 : i8}> : () -> i8
    "memref.store"(%15, %arg0, %13) : (i8, memref<?xi8>, index) -> ()
    "memref.store"(%15, %arg0, %12) : (i8, memref<?xi8>, index) -> ()
    "memref.store"(%15, %arg0, %11) : (i8, memref<?xi8>, index) -> ()
    %16 = "math.ipowi"(%14, %10) : (i8, i8) -> i8
    "memref.store"(%16, %arg0, %9) : (i8, memref<?xi8>, index) -> ()
    "memref.store"(%15, %arg0, %8) : (i8, memref<?xi8>, index) -> ()
    "memref.store"(%14, %arg0, %7) : (i8, memref<?xi8>, index) -> ()
    "memref.store"(%14, %arg0, %6) : (i8, memref<?xi8>, index) -> ()
    "memref.store"(%15, %arg0, %5) : (i8, memref<?xi8>, index) -> ()
    "memref.store"(%10, %arg0, %4) : (i8, memref<?xi8>, index) -> ()
    "memref.store"(%1, %arg0, %3) : (i8, memref<?xi8>, index) -> ()
    "memref.store"(%0, %arg0, %2) : (i8, memref<?xi8>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

