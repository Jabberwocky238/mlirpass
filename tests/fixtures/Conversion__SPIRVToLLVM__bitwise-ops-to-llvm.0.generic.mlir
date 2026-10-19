"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i16)>, linkage = #llvm.linkage<external>, sym_name = "bitcount_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg57: i16):
    %130 = "llvm.intr.ctpop"(%arg57) : (i16) -> i16
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<3xi32>)>, linkage = #llvm.linkage<external>, sym_name = "bitcount_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg56: vector<3xi32>):
    %129 = "llvm.intr.ctpop"(%arg56) : (vector<3xi32>) -> vector<3xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "bitreverse_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg55: i64):
    %128 = "llvm.intr.bitreverse"(%arg55) : (i64) -> i64
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xi32>)>, linkage = #llvm.linkage<external>, sym_name = "bitreverse_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg54: vector<4xi32>):
    %127 = "llvm.intr.bitreverse"(%arg54) : (vector<4xi32>) -> vector<4xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "bitfield_insert_scalar_same_bit_width", visibility_ = 0 : i64}> ({
  ^bb0(%arg50: i32, %arg51: i32, %arg52: i32, %arg53: i32):
    %119 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
    %120 = "llvm.shl"(%119, %arg53) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %121 = "llvm.xor"(%120, %119) : (i32, i32) -> i32
    %122 = "llvm.shl"(%121, %arg52) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %123 = "llvm.xor"(%122, %119) : (i32, i32) -> i32
    %124 = "llvm.and"(%arg50, %123) : (i32, i32) -> i32
    %125 = "llvm.shl"(%arg51, %arg52) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %126 = "llvm.or"(%124, %125) : (i32, i32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64, i64, i8, i8)>, linkage = #llvm.linkage<external>, sym_name = "bitfield_insert_scalar_smaller_bit_width", visibility_ = 0 : i64}> ({
  ^bb0(%arg46: i64, %arg47: i64, %arg48: i8, %arg49: i8):
    %109 = "llvm.zext"(%arg48) : (i8) -> i64
    %110 = "llvm.zext"(%arg49) : (i8) -> i64
    %111 = "llvm.mlir.constant"() <{value = -1 : i64}> : () -> i64
    %112 = "llvm.shl"(%111, %110) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %113 = "llvm.xor"(%112, %111) : (i64, i64) -> i64
    %114 = "llvm.shl"(%113, %109) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %115 = "llvm.xor"(%114, %111) : (i64, i64) -> i64
    %116 = "llvm.and"(%arg46, %115) : (i64, i64) -> i64
    %117 = "llvm.shl"(%arg47, %109) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %118 = "llvm.or"(%116, %117) : (i64, i64) -> i64
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i16, i16, i32, i64)>, linkage = #llvm.linkage<external>, sym_name = "bitfield_insert_scalar_greater_bit_width", visibility_ = 0 : i64}> ({
  ^bb0(%arg42: i16, %arg43: i16, %arg44: i32, %arg45: i64):
    %99 = "llvm.trunc"(%arg44) <{overflowFlags = 0 : i32}> : (i32) -> i16
    %100 = "llvm.trunc"(%arg45) <{overflowFlags = 0 : i32}> : (i64) -> i16
    %101 = "llvm.mlir.constant"() <{value = -1 : i16}> : () -> i16
    %102 = "llvm.shl"(%101, %100) <{overflowFlags = 0 : i32}> : (i16, i16) -> i16
    %103 = "llvm.xor"(%102, %101) : (i16, i16) -> i16
    %104 = "llvm.shl"(%103, %99) <{overflowFlags = 0 : i32}> : (i16, i16) -> i16
    %105 = "llvm.xor"(%104, %101) : (i16, i16) -> i16
    %106 = "llvm.and"(%arg42, %105) : (i16, i16) -> i16
    %107 = "llvm.shl"(%arg43, %99) <{overflowFlags = 0 : i32}> : (i16, i16) -> i16
    %108 = "llvm.or"(%106, %107) : (i16, i16) -> i16
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<2xi32>, vector<2xi32>, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "bitfield_insert_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg38: vector<2xi32>, %arg39: vector<2xi32>, %arg40: i32, %arg41: i32):
    %81 = "llvm.mlir.poison"() : () -> vector<2xi32>
    %82 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %83 = "llvm.insertelement"(%81, %arg40, %82) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %84 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %85 = "llvm.insertelement"(%83, %arg40, %84) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %86 = "llvm.mlir.poison"() : () -> vector<2xi32>
    %87 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %88 = "llvm.insertelement"(%86, %arg41, %87) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %89 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %90 = "llvm.insertelement"(%88, %arg41, %89) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %91 = "llvm.mlir.constant"() <{value = dense<-1> : vector<2xi32>}> : () -> vector<2xi32>
    %92 = "llvm.shl"(%91, %90) <{overflowFlags = 0 : i32}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %93 = "llvm.xor"(%92, %91) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %94 = "llvm.shl"(%93, %85) <{overflowFlags = 0 : i32}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %95 = "llvm.xor"(%94, %91) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %96 = "llvm.and"(%arg38, %95) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %97 = "llvm.shl"(%arg39, %85) <{overflowFlags = 0 : i32}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %98 = "llvm.or"(%96, %97) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "bitfield_sextract_scalar_same_bit_width", visibility_ = 0 : i64}> ({
  ^bb0(%arg35: i64, %arg36: i64, %arg37: i64):
    %75 = "llvm.mlir.constant"() <{value = 64 : i64}> : () -> i64
    %76 = "llvm.add"(%arg37, %arg36) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %77 = "llvm.sub"(%75, %76) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %78 = "llvm.shl"(%arg35, %77) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %79 = "llvm.add"(%arg36, %77) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %80 = "llvm.ashr"(%78, %79) : (i64, i64) -> i64
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i8, i8)>, linkage = #llvm.linkage<external>, sym_name = "bitfield_sextract_scalar_smaller_bit_width", visibility_ = 0 : i64}> ({
  ^bb0(%arg32: i32, %arg33: i8, %arg34: i8):
    %67 = "llvm.zext"(%arg33) : (i8) -> i32
    %68 = "llvm.zext"(%arg34) : (i8) -> i32
    %69 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
    %70 = "llvm.add"(%68, %67) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %71 = "llvm.sub"(%69, %70) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %72 = "llvm.shl"(%arg32, %71) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %73 = "llvm.add"(%67, %71) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %74 = "llvm.ashr"(%72, %73) : (i32, i32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "bitfield_sextract_scalar_greater_bit_width", visibility_ = 0 : i64}> ({
  ^bb0(%arg29: i32, %arg30: i64, %arg31: i64):
    %59 = "llvm.trunc"(%arg30) <{overflowFlags = 0 : i32}> : (i64) -> i32
    %60 = "llvm.trunc"(%arg31) <{overflowFlags = 0 : i32}> : (i64) -> i32
    %61 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
    %62 = "llvm.add"(%60, %59) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %63 = "llvm.sub"(%61, %62) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %64 = "llvm.shl"(%arg29, %63) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %65 = "llvm.add"(%59, %63) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %66 = "llvm.ashr"(%64, %65) : (i32, i32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<2xi32>, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "bitfield_sextract_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg26: vector<2xi32>, %arg27: i32, %arg28: i32):
    %43 = "llvm.mlir.poison"() : () -> vector<2xi32>
    %44 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %45 = "llvm.insertelement"(%43, %arg27, %44) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %46 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %47 = "llvm.insertelement"(%45, %arg27, %46) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %48 = "llvm.mlir.poison"() : () -> vector<2xi32>
    %49 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %50 = "llvm.insertelement"(%48, %arg28, %49) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %51 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %52 = "llvm.insertelement"(%50, %arg28, %51) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %53 = "llvm.mlir.constant"() <{value = dense<32> : vector<2xi32>}> : () -> vector<2xi32>
    %54 = "llvm.add"(%52, %47) <{overflowFlags = 0 : i32}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %55 = "llvm.sub"(%53, %54) <{overflowFlags = 0 : i32}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %56 = "llvm.shl"(%arg26, %55) <{overflowFlags = 0 : i32}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %57 = "llvm.add"(%47, %55) <{overflowFlags = 0 : i32}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %58 = "llvm.ashr"(%56, %57) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "bitfield_uextract_scalar_same_bit_width", visibility_ = 0 : i64}> ({
  ^bb0(%arg23: i32, %arg24: i32, %arg25: i32):
    %38 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
    %39 = "llvm.shl"(%38, %arg25) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %40 = "llvm.xor"(%39, %38) : (i32, i32) -> i32
    %41 = "llvm.lshr"(%arg23, %arg24) : (i32, i32) -> i32
    %42 = "llvm.and"(%41, %40) : (i32, i32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i16, i8)>, linkage = #llvm.linkage<external>, sym_name = "bitfield_uextract_scalar_smaller_bit_width", visibility_ = 0 : i64}> ({
  ^bb0(%arg20: i32, %arg21: i16, %arg22: i8):
    %31 = "llvm.zext"(%arg21) : (i16) -> i32
    %32 = "llvm.zext"(%arg22) : (i8) -> i32
    %33 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
    %34 = "llvm.shl"(%33, %32) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %35 = "llvm.xor"(%34, %33) : (i32, i32) -> i32
    %36 = "llvm.lshr"(%arg20, %31) : (i32, i32) -> i32
    %37 = "llvm.and"(%36, %35) : (i32, i32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i8, i16, i8)>, linkage = #llvm.linkage<external>, sym_name = "bitfield_uextract_scalar_greater_bit_width", visibility_ = 0 : i64}> ({
  ^bb0(%arg17: i8, %arg18: i16, %arg19: i8):
    %25 = "llvm.trunc"(%arg18) <{overflowFlags = 0 : i32}> : (i16) -> i8
    %26 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
    %27 = "llvm.shl"(%26, %arg19) <{overflowFlags = 0 : i32}> : (i8, i8) -> i8
    %28 = "llvm.xor"(%27, %26) : (i8, i8) -> i8
    %29 = "llvm.lshr"(%arg17, %25) : (i8, i8) -> i8
    %30 = "llvm.and"(%29, %28) : (i8, i8) -> i8
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<2xi32>, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "bitfield_uextract_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg14: vector<2xi32>, %arg15: i32, %arg16: i32):
    %10 = "llvm.mlir.poison"() : () -> vector<2xi32>
    %11 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %12 = "llvm.insertelement"(%10, %arg15, %11) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %13 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %14 = "llvm.insertelement"(%12, %arg15, %13) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %15 = "llvm.mlir.poison"() : () -> vector<2xi32>
    %16 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %17 = "llvm.insertelement"(%15, %arg16, %16) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %18 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %19 = "llvm.insertelement"(%17, %arg16, %18) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %20 = "llvm.mlir.constant"() <{value = dense<-1> : vector<2xi32>}> : () -> vector<2xi32>
    %21 = "llvm.shl"(%20, %19) <{overflowFlags = 0 : i32}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %22 = "llvm.xor"(%21, %20) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %23 = "llvm.lshr"(%arg14, %14) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %24 = "llvm.and"(%23, %22) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "bitwise_and_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg12: i32, %arg13: i32):
    %9 = "llvm.and"(%arg12, %arg13) : (i32, i32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xi64>, vector<4xi64>)>, linkage = #llvm.linkage<external>, sym_name = "bitwise_and_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg10: vector<4xi64>, %arg11: vector<4xi64>):
    %8 = "llvm.and"(%arg10, %arg11) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "bitwise_or_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg8: i64, %arg9: i64):
    %7 = "llvm.or"(%arg8, %arg9) : (i64, i64) -> i64
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<3xi8>, vector<3xi8>)>, linkage = #llvm.linkage<external>, sym_name = "bitwise_or_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg6: vector<3xi8>, %arg7: vector<3xi8>):
    %6 = "llvm.or"(%arg6, %arg7) : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "bitwise_xor_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg4: i32, %arg5: i32):
    %5 = "llvm.xor"(%arg4, %arg5) : (i32, i32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<2xi16>, vector<2xi16>)>, linkage = #llvm.linkage<external>, sym_name = "bitwise_xor_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg2: vector<2xi16>, %arg3: vector<2xi16>):
    %4 = "llvm.xor"(%arg2, %arg3) : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "not_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg1: i32):
    %2 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
    %3 = "llvm.xor"(%arg1, %2) : (i32, i32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<2xi16>)>, linkage = #llvm.linkage<external>, sym_name = "not_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<2xi16>):
    %0 = "llvm.mlir.constant"() <{value = dense<-1> : vector<2xi16>}> : () -> vector<2xi16>
    %1 = "llvm.xor"(%arg0, %0) : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

