"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi32>) -> (), sym_name = "ipowi32_fold"}> ({
  ^bb0(%arg3: memref<?xi32>):
    %136 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %137 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %138 = "math.ipowi"(%136, %137) : (i32, i32) -> i32
    %139 = "arith.constant"() <{value = 0 : index}> : () -> index
    "memref.store"(%138, %arg3, %139) : (i32, memref<?xi32>, index) -> ()
    %140 = "arith.constant"() <{value = 10 : i32}> : () -> i32
    %141 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %142 = "math.ipowi"(%140, %141) : (i32, i32) -> i32
    %143 = "arith.constant"() <{value = 1 : index}> : () -> index
    "memref.store"(%142, %arg3, %143) : (i32, memref<?xi32>, index) -> ()
    %144 = "arith.constant"() <{value = -10 : i32}> : () -> i32
    %145 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %146 = "math.ipowi"(%144, %145) : (i32, i32) -> i32
    %147 = "arith.constant"() <{value = 2 : index}> : () -> index
    "memref.store"(%146, %arg3, %147) : (i32, memref<?xi32>, index) -> ()
    %148 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %149 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %150 = "math.ipowi"(%148, %149) : (i32, i32) -> i32
    %151 = "arith.constant"() <{value = 3 : index}> : () -> index
    "memref.store"(%150, %arg3, %151) : (i32, memref<?xi32>, index) -> ()
    %152 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %153 = "arith.constant"() <{value = -10 : i32}> : () -> i32
    %154 = "math.ipowi"(%152, %153) : (i32, i32) -> i32
    %155 = "arith.constant"() <{value = 4 : index}> : () -> index
    "memref.store"(%154, %arg3, %155) : (i32, memref<?xi32>, index) -> ()
    %156 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %157 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %158 = "math.ipowi"(%156, %157) : (i32, i32) -> i32
    %159 = "arith.constant"() <{value = 5 : index}> : () -> index
    "memref.store"(%158, %arg3, %159) : (i32, memref<?xi32>, index) -> ()
    %160 = "arith.constant"() <{value = -2 : i32}> : () -> i32
    %161 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %162 = "math.ipowi"(%160, %161) : (i32, i32) -> i32
    %163 = "arith.constant"() <{value = 6 : index}> : () -> index
    "memref.store"(%162, %arg3, %163) : (i32, memref<?xi32>, index) -> ()
    %164 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %165 = "arith.constant"() <{value = -10 : i32}> : () -> i32
    %166 = "math.ipowi"(%164, %165) : (i32, i32) -> i32
    %167 = "arith.constant"() <{value = 7 : index}> : () -> index
    "memref.store"(%166, %arg3, %167) : (i32, memref<?xi32>, index) -> ()
    %168 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %169 = "arith.constant"() <{value = -11 : i32}> : () -> i32
    %170 = "math.ipowi"(%168, %169) : (i32, i32) -> i32
    %171 = "arith.constant"() <{value = 8 : index}> : () -> index
    "memref.store"(%170, %arg3, %171) : (i32, memref<?xi32>, index) -> ()
    %172 = "arith.constant"() <{value = -3 : i32}> : () -> i32
    %173 = "arith.constant"() <{value = 3 : i32}> : () -> i32
    %174 = "math.ipowi"(%172, %173) : (i32, i32) -> i32
    %175 = "arith.constant"() <{value = 9 : index}> : () -> index
    "memref.store"(%174, %arg3, %175) : (i32, memref<?xi32>, index) -> ()
    %176 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %177 = "arith.constant"() <{value = 30 : i32}> : () -> i32
    %178 = "math.ipowi"(%176, %177) : (i32, i32) -> i32
    %179 = "arith.constant"() <{value = 10 : index}> : () -> index
    "memref.store"(%178, %arg3, %179) : (i32, memref<?xi32>, index) -> ()
    %180 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %181 = "vector.broadcast"(%180) : (i32) -> vector<2x2xi32>
    %182 = "arith.constant"() <{value = 30 : i32}> : () -> i32
    %183 = "vector.broadcast"(%182) : (i32) -> vector<2x2xi32>
    %184 = "math.ipowi"(%181, %183) : (vector<2x2xi32>, vector<2x2xi32>) -> vector<2x2xi32>
    %185 = "arith.constant"() <{value = 11 : index}> : () -> index
    %186 = "vector.extract"(%184) <{static_position = array<i64: 1, 1>}> : (vector<2x2xi32>) -> i32
    "memref.store"(%186, %arg3, %185) : (i32, memref<?xi32>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi64>) -> (), sym_name = "ipowi64_fold"}> ({
  ^bb0(%arg2: memref<?xi64>):
    %88 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %89 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %90 = "math.ipowi"(%88, %89) : (i64, i64) -> i64
    %91 = "arith.constant"() <{value = 0 : index}> : () -> index
    "memref.store"(%90, %arg2, %91) : (i64, memref<?xi64>, index) -> ()
    %92 = "arith.constant"() <{value = 10 : i64}> : () -> i64
    %93 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %94 = "math.ipowi"(%92, %93) : (i64, i64) -> i64
    %95 = "arith.constant"() <{value = 1 : index}> : () -> index
    "memref.store"(%94, %arg2, %95) : (i64, memref<?xi64>, index) -> ()
    %96 = "arith.constant"() <{value = -10 : i64}> : () -> i64
    %97 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %98 = "math.ipowi"(%96, %97) : (i64, i64) -> i64
    %99 = "arith.constant"() <{value = 2 : index}> : () -> index
    "memref.store"(%98, %arg2, %99) : (i64, memref<?xi64>, index) -> ()
    %100 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %101 = "arith.constant"() <{value = -1 : i64}> : () -> i64
    %102 = "math.ipowi"(%100, %101) : (i64, i64) -> i64
    %103 = "arith.constant"() <{value = 3 : index}> : () -> index
    "memref.store"(%102, %arg2, %103) : (i64, memref<?xi64>, index) -> ()
    %104 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %105 = "arith.constant"() <{value = -10 : i64}> : () -> i64
    %106 = "math.ipowi"(%104, %105) : (i64, i64) -> i64
    %107 = "arith.constant"() <{value = 4 : index}> : () -> index
    "memref.store"(%106, %arg2, %107) : (i64, memref<?xi64>, index) -> ()
    %108 = "arith.constant"() <{value = 2 : i64}> : () -> i64
    %109 = "arith.constant"() <{value = -1 : i64}> : () -> i64
    %110 = "math.ipowi"(%108, %109) : (i64, i64) -> i64
    %111 = "arith.constant"() <{value = 5 : index}> : () -> index
    "memref.store"(%110, %arg2, %111) : (i64, memref<?xi64>, index) -> ()
    %112 = "arith.constant"() <{value = -2 : i64}> : () -> i64
    %113 = "arith.constant"() <{value = -1 : i64}> : () -> i64
    %114 = "math.ipowi"(%112, %113) : (i64, i64) -> i64
    %115 = "arith.constant"() <{value = 6 : index}> : () -> index
    "memref.store"(%114, %arg2, %115) : (i64, memref<?xi64>, index) -> ()
    %116 = "arith.constant"() <{value = -1 : i64}> : () -> i64
    %117 = "arith.constant"() <{value = -10 : i64}> : () -> i64
    %118 = "math.ipowi"(%116, %117) : (i64, i64) -> i64
    %119 = "arith.constant"() <{value = 7 : index}> : () -> index
    "memref.store"(%118, %arg2, %119) : (i64, memref<?xi64>, index) -> ()
    %120 = "arith.constant"() <{value = -1 : i64}> : () -> i64
    %121 = "arith.constant"() <{value = -11 : i64}> : () -> i64
    %122 = "math.ipowi"(%120, %121) : (i64, i64) -> i64
    %123 = "arith.constant"() <{value = 8 : index}> : () -> index
    "memref.store"(%122, %arg2, %123) : (i64, memref<?xi64>, index) -> ()
    %124 = "arith.constant"() <{value = -3 : i64}> : () -> i64
    %125 = "arith.constant"() <{value = 3 : i64}> : () -> i64
    %126 = "math.ipowi"(%124, %125) : (i64, i64) -> i64
    %127 = "arith.constant"() <{value = 9 : index}> : () -> index
    "memref.store"(%126, %arg2, %127) : (i64, memref<?xi64>, index) -> ()
    %128 = "arith.constant"() <{value = 2 : i64}> : () -> i64
    %129 = "arith.constant"() <{value = 30 : i64}> : () -> i64
    %130 = "math.ipowi"(%128, %129) : (i64, i64) -> i64
    %131 = "arith.constant"() <{value = 10 : index}> : () -> index
    "memref.store"(%130, %arg2, %131) : (i64, memref<?xi64>, index) -> ()
    %132 = "arith.constant"() <{value = 2 : i64}> : () -> i64
    %133 = "arith.constant"() <{value = 48 : i64}> : () -> i64
    %134 = "math.ipowi"(%132, %133) : (i64, i64) -> i64
    %135 = "arith.constant"() <{value = 11 : index}> : () -> index
    "memref.store"(%134, %arg2, %135) : (i64, memref<?xi64>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi16>) -> (), sym_name = "ipowi16_fold"}> ({
  ^bb0(%arg1: memref<?xi16>):
    %44 = "arith.constant"() <{value = 0 : i16}> : () -> i16
    %45 = "arith.constant"() <{value = 0 : i16}> : () -> i16
    %46 = "math.ipowi"(%44, %45) : (i16, i16) -> i16
    %47 = "arith.constant"() <{value = 0 : index}> : () -> index
    "memref.store"(%46, %arg1, %47) : (i16, memref<?xi16>, index) -> ()
    %48 = "arith.constant"() <{value = 10 : i16}> : () -> i16
    %49 = "arith.constant"() <{value = 0 : i16}> : () -> i16
    %50 = "math.ipowi"(%48, %49) : (i16, i16) -> i16
    %51 = "arith.constant"() <{value = 1 : index}> : () -> index
    "memref.store"(%50, %arg1, %51) : (i16, memref<?xi16>, index) -> ()
    %52 = "arith.constant"() <{value = -10 : i16}> : () -> i16
    %53 = "arith.constant"() <{value = 0 : i16}> : () -> i16
    %54 = "math.ipowi"(%52, %53) : (i16, i16) -> i16
    %55 = "arith.constant"() <{value = 2 : index}> : () -> index
    "memref.store"(%54, %arg1, %55) : (i16, memref<?xi16>, index) -> ()
    %56 = "arith.constant"() <{value = 0 : i16}> : () -> i16
    %57 = "arith.constant"() <{value = -1 : i16}> : () -> i16
    %58 = "math.ipowi"(%56, %57) : (i16, i16) -> i16
    %59 = "arith.constant"() <{value = 3 : index}> : () -> index
    "memref.store"(%58, %arg1, %59) : (i16, memref<?xi16>, index) -> ()
    %60 = "arith.constant"() <{value = 1 : i16}> : () -> i16
    %61 = "arith.constant"() <{value = -10 : i16}> : () -> i16
    %62 = "math.ipowi"(%60, %61) : (i16, i16) -> i16
    %63 = "arith.constant"() <{value = 4 : index}> : () -> index
    "memref.store"(%62, %arg1, %63) : (i16, memref<?xi16>, index) -> ()
    %64 = "arith.constant"() <{value = 2 : i16}> : () -> i16
    %65 = "arith.constant"() <{value = -1 : i16}> : () -> i16
    %66 = "math.ipowi"(%64, %65) : (i16, i16) -> i16
    %67 = "arith.constant"() <{value = 5 : index}> : () -> index
    "memref.store"(%66, %arg1, %67) : (i16, memref<?xi16>, index) -> ()
    %68 = "arith.constant"() <{value = -2 : i16}> : () -> i16
    %69 = "arith.constant"() <{value = -1 : i16}> : () -> i16
    %70 = "math.ipowi"(%68, %69) : (i16, i16) -> i16
    %71 = "arith.constant"() <{value = 6 : index}> : () -> index
    "memref.store"(%70, %arg1, %71) : (i16, memref<?xi16>, index) -> ()
    %72 = "arith.constant"() <{value = -1 : i16}> : () -> i16
    %73 = "arith.constant"() <{value = -10 : i16}> : () -> i16
    %74 = "math.ipowi"(%72, %73) : (i16, i16) -> i16
    %75 = "arith.constant"() <{value = 7 : index}> : () -> index
    "memref.store"(%74, %arg1, %75) : (i16, memref<?xi16>, index) -> ()
    %76 = "arith.constant"() <{value = -1 : i16}> : () -> i16
    %77 = "arith.constant"() <{value = -11 : i16}> : () -> i16
    %78 = "math.ipowi"(%76, %77) : (i16, i16) -> i16
    %79 = "arith.constant"() <{value = 8 : index}> : () -> index
    "memref.store"(%78, %arg1, %79) : (i16, memref<?xi16>, index) -> ()
    %80 = "arith.constant"() <{value = -3 : i16}> : () -> i16
    %81 = "arith.constant"() <{value = 3 : i16}> : () -> i16
    %82 = "math.ipowi"(%80, %81) : (i16, i16) -> i16
    %83 = "arith.constant"() <{value = 9 : index}> : () -> index
    "memref.store"(%82, %arg1, %83) : (i16, memref<?xi16>, index) -> ()
    %84 = "arith.constant"() <{value = 2 : i16}> : () -> i16
    %85 = "arith.constant"() <{value = 14 : i16}> : () -> i16
    %86 = "math.ipowi"(%84, %85) : (i16, i16) -> i16
    %87 = "arith.constant"() <{value = 10 : index}> : () -> index
    "memref.store"(%86, %arg1, %87) : (i16, memref<?xi16>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi8>) -> (), sym_name = "ipowi8_fold"}> ({
  ^bb0(%arg0: memref<?xi8>):
    %0 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %1 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %2 = "math.ipowi"(%0, %1) : (i8, i8) -> i8
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    "memref.store"(%2, %arg0, %3) : (i8, memref<?xi8>, index) -> ()
    %4 = "arith.constant"() <{value = 10 : i8}> : () -> i8
    %5 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %6 = "math.ipowi"(%4, %5) : (i8, i8) -> i8
    %7 = "arith.constant"() <{value = 1 : index}> : () -> index
    "memref.store"(%6, %arg0, %7) : (i8, memref<?xi8>, index) -> ()
    %8 = "arith.constant"() <{value = -10 : i8}> : () -> i8
    %9 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %10 = "math.ipowi"(%8, %9) : (i8, i8) -> i8
    %11 = "arith.constant"() <{value = 2 : index}> : () -> index
    "memref.store"(%10, %arg0, %11) : (i8, memref<?xi8>, index) -> ()
    %12 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %13 = "arith.constant"() <{value = -1 : i8}> : () -> i8
    %14 = "math.ipowi"(%12, %13) : (i8, i8) -> i8
    %15 = "arith.constant"() <{value = 3 : index}> : () -> index
    "memref.store"(%14, %arg0, %15) : (i8, memref<?xi8>, index) -> ()
    %16 = "arith.constant"() <{value = 1 : i8}> : () -> i8
    %17 = "arith.constant"() <{value = -10 : i8}> : () -> i8
    %18 = "math.ipowi"(%16, %17) : (i8, i8) -> i8
    %19 = "arith.constant"() <{value = 4 : index}> : () -> index
    "memref.store"(%18, %arg0, %19) : (i8, memref<?xi8>, index) -> ()
    %20 = "arith.constant"() <{value = 2 : i8}> : () -> i8
    %21 = "arith.constant"() <{value = -1 : i8}> : () -> i8
    %22 = "math.ipowi"(%20, %21) : (i8, i8) -> i8
    %23 = "arith.constant"() <{value = 5 : index}> : () -> index
    "memref.store"(%22, %arg0, %23) : (i8, memref<?xi8>, index) -> ()
    %24 = "arith.constant"() <{value = -2 : i8}> : () -> i8
    %25 = "arith.constant"() <{value = -1 : i8}> : () -> i8
    %26 = "math.ipowi"(%24, %25) : (i8, i8) -> i8
    %27 = "arith.constant"() <{value = 6 : index}> : () -> index
    "memref.store"(%26, %arg0, %27) : (i8, memref<?xi8>, index) -> ()
    %28 = "arith.constant"() <{value = -1 : i8}> : () -> i8
    %29 = "arith.constant"() <{value = -10 : i8}> : () -> i8
    %30 = "math.ipowi"(%28, %29) : (i8, i8) -> i8
    %31 = "arith.constant"() <{value = 7 : index}> : () -> index
    "memref.store"(%30, %arg0, %31) : (i8, memref<?xi8>, index) -> ()
    %32 = "arith.constant"() <{value = -1 : i8}> : () -> i8
    %33 = "arith.constant"() <{value = -11 : i8}> : () -> i8
    %34 = "math.ipowi"(%32, %33) : (i8, i8) -> i8
    %35 = "arith.constant"() <{value = 8 : index}> : () -> index
    "memref.store"(%34, %arg0, %35) : (i8, memref<?xi8>, index) -> ()
    %36 = "arith.constant"() <{value = -3 : i8}> : () -> i8
    %37 = "arith.constant"() <{value = 3 : i8}> : () -> i8
    %38 = "math.ipowi"(%36, %37) : (i8, i8) -> i8
    %39 = "arith.constant"() <{value = 9 : index}> : () -> index
    "memref.store"(%38, %arg0, %39) : (i8, memref<?xi8>, index) -> ()
    %40 = "arith.constant"() <{value = 2 : i8}> : () -> i8
    %41 = "arith.constant"() <{value = 6 : i8}> : () -> i8
    %42 = "math.ipowi"(%40, %41) : (i8, i8) -> i8
    %43 = "arith.constant"() <{value = 10 : index}> : () -> index
    "memref.store"(%42, %arg0, %43) : (i8, memref<?xi8>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

