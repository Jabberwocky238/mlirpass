"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(ptr, ptr, ptr, ptr)> (ptr, i64)>, linkage = #llvm.linkage<external>, sym_name = "test_ptr_add", visibility_ = 0 : i64}> ({
  ^bb0(%arg59: !llvm.ptr, %arg60: i64):
    %176 = "llvm.getelementptr"(%arg59, %arg60) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %177 = "llvm.getelementptr"(%arg59, %arg60) <{elem_type = i8, noWrapFlags = 2 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %178 = "llvm.getelementptr"(%arg59, %arg60) <{elem_type = i8, noWrapFlags = 4 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %179 = "llvm.getelementptr"(%arg59, %arg60) <{elem_type = i8, noWrapFlags = 3 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %180 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, ptr, ptr)>
    %181 = "llvm.insertvalue"(%180, %176) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, ptr, ptr)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, ptr, ptr)>
    %182 = "llvm.insertvalue"(%181, %177) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, ptr, ptr)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, ptr, ptr)>
    %183 = "llvm.insertvalue"(%182, %178) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, ptr, ptr)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, ptr, ptr)>
    %184 = "llvm.insertvalue"(%183, %179) <{position = array<i64: 3>}> : (!llvm.struct<(ptr, ptr, ptr, ptr)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, ptr, ptr)>
    "llvm.return"(%184) : (!llvm.struct<(ptr, ptr, ptr, ptr)>) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(i64, i64, i64)> ()>, linkage = #llvm.linkage<external>, sym_name = "test_type_offset", visibility_ = 0 : i64}> ({
    %163 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %164 = "llvm.getelementptr"(%163) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %165 = "llvm.ptrtoint"(%164) : (!llvm.ptr) -> i64
    %166 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %167 = "llvm.getelementptr"(%166) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %168 = "llvm.ptrtoint"(%167) : (!llvm.ptr) -> i64
    %169 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %170 = "llvm.getelementptr"(%169) <{elem_type = !llvm.struct<(i32, f64)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %171 = "llvm.ptrtoint"(%170) : (!llvm.ptr) -> i64
    %172 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, i64, i64)>
    %173 = "llvm.insertvalue"(%172, %165) <{position = array<i64: 0>}> : (!llvm.struct<(i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64)>
    %174 = "llvm.insertvalue"(%173, %168) <{position = array<i64: 1>}> : (!llvm.struct<(i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64)>
    %175 = "llvm.insertvalue"(%174, %171) <{position = array<i64: 2>}> : (!llvm.struct<(i64, i64, i64)>, i64) -> !llvm.struct<(i64, i64, i64)>
    "llvm.return"(%175) : (!llvm.struct<(i64, i64, i64)>) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (ptr, ptr, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "test_to_ptr", visibility_ = 0 : i64}> ({
  ^bb0(%arg54: !llvm.ptr, %arg55: !llvm.ptr, %arg56: i64, %arg57: i64, %arg58: i64):
    %156 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %157 = "llvm.insertvalue"(%156, %arg54) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %158 = "llvm.insertvalue"(%157, %arg55) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %159 = "llvm.insertvalue"(%158, %arg56) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %160 = "llvm.insertvalue"(%159, %arg57) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %161 = "llvm.insertvalue"(%160, %arg58) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %162 = "llvm.extractvalue"(%161) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    "llvm.return"(%162) : (!llvm.ptr) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(ptr)> (ptr, ptr, i64, i64, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "test_get_metadata_static", visibility_ = 0 : i64}> ({
  ^bb0(%arg47: !llvm.ptr, %arg48: !llvm.ptr, %arg49: i64, %arg50: i64, %arg51: i64, %arg52: i64, %arg53: i64):
    %145 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %146 = "llvm.insertvalue"(%145, %arg47) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %147 = "llvm.insertvalue"(%146, %arg48) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %148 = "llvm.insertvalue"(%147, %arg49) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %149 = "llvm.insertvalue"(%148, %arg50) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %150 = "llvm.insertvalue"(%149, %arg52) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %151 = "llvm.insertvalue"(%150, %arg51) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %152 = "llvm.insertvalue"(%151, %arg53) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %153 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr)>
    %154 = "llvm.extractvalue"(%152) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %155 = "llvm.insertvalue"(%153, %154) <{position = array<i64: 0>}> : (!llvm.struct<(ptr)>, !llvm.ptr) -> !llvm.struct<(ptr)>
    "llvm.return"(%155) : (!llvm.struct<(ptr)>) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(ptr, i64, i64, i64)> (ptr, ptr, i64, i64, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "test_get_metadata_dynamic", visibility_ = 0 : i64}> ({
  ^bb0(%arg40: !llvm.ptr, %arg41: !llvm.ptr, %arg42: i64, %arg43: i64, %arg44: i64, %arg45: i64, %arg46: i64):
    %128 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %129 = "llvm.insertvalue"(%128, %arg40) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %130 = "llvm.insertvalue"(%129, %arg41) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %131 = "llvm.insertvalue"(%130, %arg42) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %132 = "llvm.insertvalue"(%131, %arg43) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %133 = "llvm.insertvalue"(%132, %arg45) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %134 = "llvm.insertvalue"(%133, %arg44) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %135 = "llvm.insertvalue"(%134, %arg46) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %136 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, i64, i64, i64)>
    %137 = "llvm.extractvalue"(%135) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %138 = "llvm.insertvalue"(%136, %137) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, i64, i64, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, i64, i64, i64)>
    %139 = "llvm.extractvalue"(%135) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %140 = "llvm.insertvalue"(%138, %139) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, i64, i64, i64)>, i64) -> !llvm.struct<(ptr, i64, i64, i64)>
    %141 = "llvm.extractvalue"(%135) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %142 = "llvm.insertvalue"(%140, %141) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, i64, i64, i64)>, i64) -> !llvm.struct<(ptr, i64, i64, i64)>
    %143 = "llvm.extractvalue"(%135) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %144 = "llvm.insertvalue"(%142, %143) <{position = array<i64: 3>}> : (!llvm.struct<(ptr, i64, i64, i64)>, i64) -> !llvm.struct<(ptr, i64, i64, i64)>
    "llvm.return"(%144) : (!llvm.struct<(ptr, i64, i64, i64)>) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> (ptr, struct<(ptr)>)>, linkage = #llvm.linkage<external>, sym_name = "test_from_ptr_static", visibility_ = 0 : i64}> ({
  ^bb0(%arg38: !llvm.ptr, %arg39: !llvm.struct<(ptr)>):
    %114 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %115 = "llvm.extractvalue"(%arg39) <{position = array<i64: 0>}> : (!llvm.struct<(ptr)>) -> !llvm.ptr
    %116 = "llvm.insertvalue"(%114, %115) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %117 = "llvm.insertvalue"(%116, %arg38) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %118 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %119 = "llvm.insertvalue"(%117, %118) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %120 = "llvm.mlir.constant"() <{value = 10 : index}> : () -> i64
    %121 = "llvm.insertvalue"(%119, %120) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %122 = "llvm.mlir.constant"() <{value = 20 : index}> : () -> i64
    %123 = "llvm.insertvalue"(%121, %122) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %124 = "llvm.mlir.constant"() <{value = 20 : index}> : () -> i64
    %125 = "llvm.insertvalue"(%123, %124) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %126 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %127 = "llvm.insertvalue"(%125, %126) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    "llvm.return"(%127) : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> (ptr, struct<(ptr, i64, i64, i64)>)>, linkage = #llvm.linkage<external>, sym_name = "test_from_ptr_dynamic", visibility_ = 0 : i64}> ({
  ^bb0(%arg36: !llvm.ptr, %arg37: !llvm.struct<(ptr, i64, i64, i64)>):
    %100 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %101 = "llvm.extractvalue"(%arg37) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, i64, i64, i64)>) -> !llvm.ptr
    %102 = "llvm.insertvalue"(%100, %101) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %103 = "llvm.insertvalue"(%102, %arg36) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %104 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %105 = "llvm.insertvalue"(%103, %104) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %106 = "llvm.extractvalue"(%arg37) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, i64, i64, i64)>) -> i64
    %107 = "llvm.insertvalue"(%105, %106) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %108 = "llvm.extractvalue"(%arg37) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, i64, i64, i64)>) -> i64
    %109 = "llvm.insertvalue"(%107, %108) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %110 = "llvm.extractvalue"(%arg37) <{position = array<i64: 3>}> : (!llvm.struct<(ptr, i64, i64, i64)>) -> i64
    %111 = "llvm.insertvalue"(%109, %110) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %112 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %113 = "llvm.insertvalue"(%111, %112) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    "llvm.return"(%113) : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> (ptr, ptr, i64, i64, i64, i64, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "test_memref_mixed", visibility_ = 0 : i64}> ({
  ^bb0(%arg27: !llvm.ptr, %arg28: !llvm.ptr, %arg29: i64, %arg30: i64, %arg31: i64, %arg32: i64, %arg33: i64, %arg34: i64, %arg35: i64):
    %82 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %83 = "llvm.insertvalue"(%82, %arg27) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %84 = "llvm.insertvalue"(%83, %arg28) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %85 = "llvm.insertvalue"(%84, %arg29) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %86 = "llvm.insertvalue"(%85, %arg30) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %87 = "llvm.insertvalue"(%86, %arg33) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %88 = "llvm.insertvalue"(%87, %arg31) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %89 = "llvm.insertvalue"(%88, %arg34) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %90 = "llvm.insertvalue"(%89, %arg32) <{position = array<i64: 3, 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %91 = "llvm.insertvalue"(%90, %arg35) <{position = array<i64: 4, 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %92 = "llvm.extractvalue"(%91) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> !llvm.ptr
    %93 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, i64, i64)>
    %94 = "llvm.extractvalue"(%91) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> !llvm.ptr
    %95 = "llvm.insertvalue"(%93, %94) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, i64, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, i64, i64)>
    %96 = "llvm.extractvalue"(%91) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> i64
    %97 = "llvm.insertvalue"(%95, %96) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, i64, i64)>, i64) -> !llvm.struct<(ptr, i64, i64)>
    %98 = "llvm.extractvalue"(%91) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> i64
    %99 = "llvm.insertvalue"(%97, %98) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, i64, i64)>, i64) -> !llvm.struct<(ptr, i64, i64)>
    "llvm.return"(%91) : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> (ptr, ptr, i64, i64, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "test_memref_strided", visibility_ = 0 : i64}> ({
  ^bb0(%arg20: !llvm.ptr, %arg21: !llvm.ptr, %arg22: i64, %arg23: i64, %arg24: i64, %arg25: i64, %arg26: i64):
    %70 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %71 = "llvm.insertvalue"(%70, %arg20) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %72 = "llvm.insertvalue"(%71, %arg21) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %73 = "llvm.insertvalue"(%72, %arg22) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %74 = "llvm.insertvalue"(%73, %arg23) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %75 = "llvm.insertvalue"(%74, %arg25) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %76 = "llvm.insertvalue"(%75, %arg24) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %77 = "llvm.insertvalue"(%76, %arg26) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %78 = "llvm.extractvalue"(%77) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %79 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr)>
    %80 = "llvm.extractvalue"(%77) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %81 = "llvm.insertvalue"(%79, %80) <{position = array<i64: 0>}> : (!llvm.struct<(ptr)>, !llvm.ptr) -> !llvm.struct<(ptr)>
    "llvm.return"(%77) : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> (ptr, ptr, i64, i64, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "test_comprehensive_dynamic", visibility_ = 0 : i64}> ({
  ^bb0(%arg13: !llvm.ptr, %arg14: !llvm.ptr, %arg15: i64, %arg16: i64, %arg17: i64, %arg18: i64, %arg19: i64):
    %30 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %31 = "llvm.insertvalue"(%30, %arg13) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %32 = "llvm.insertvalue"(%31, %arg14) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %33 = "llvm.insertvalue"(%32, %arg15) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %34 = "llvm.insertvalue"(%33, %arg16) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %35 = "llvm.insertvalue"(%34, %arg18) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %36 = "llvm.insertvalue"(%35, %arg17) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %37 = "llvm.insertvalue"(%36, %arg19) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %38 = "llvm.extractvalue"(%37) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %39 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr, i64, i64, i64, i64, i64)>
    %40 = "llvm.extractvalue"(%37) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %41 = "llvm.insertvalue"(%39, %40) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, i64, i64, i64, i64, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, i64, i64, i64, i64, i64)>
    %42 = "llvm.extractvalue"(%37) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %43 = "llvm.insertvalue"(%41, %42) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(ptr, i64, i64, i64, i64, i64)>
    %44 = "llvm.extractvalue"(%37) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %45 = "llvm.insertvalue"(%43, %44) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(ptr, i64, i64, i64, i64, i64)>
    %46 = "llvm.extractvalue"(%37) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %47 = "llvm.insertvalue"(%45, %46) <{position = array<i64: 3>}> : (!llvm.struct<(ptr, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(ptr, i64, i64, i64, i64, i64)>
    %48 = "llvm.extractvalue"(%37) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %49 = "llvm.insertvalue"(%47, %48) <{position = array<i64: 4>}> : (!llvm.struct<(ptr, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(ptr, i64, i64, i64, i64, i64)>
    %50 = "llvm.extractvalue"(%37) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %51 = "llvm.insertvalue"(%49, %50) <{position = array<i64: 5>}> : (!llvm.struct<(ptr, i64, i64, i64, i64, i64)>, i64) -> !llvm.struct<(ptr, i64, i64, i64, i64, i64)>
    %52 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %53 = "llvm.getelementptr"(%52) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %54 = "llvm.ptrtoint"(%53) : (!llvm.ptr) -> i64
    %55 = "llvm.getelementptr"(%38, %54) <{elem_type = i8, noWrapFlags = 3 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %56 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %57 = "llvm.extractvalue"(%51) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, i64, i64, i64, i64, i64)>) -> !llvm.ptr
    %58 = "llvm.insertvalue"(%56, %57) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %59 = "llvm.insertvalue"(%58, %55) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %60 = "llvm.extractvalue"(%51) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, i64, i64, i64, i64, i64)>) -> i64
    %61 = "llvm.insertvalue"(%59, %60) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %62 = "llvm.extractvalue"(%51) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, i64, i64, i64, i64, i64)>) -> i64
    %63 = "llvm.insertvalue"(%61, %62) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %64 = "llvm.extractvalue"(%51) <{position = array<i64: 3>}> : (!llvm.struct<(ptr, i64, i64, i64, i64, i64)>) -> i64
    %65 = "llvm.insertvalue"(%63, %64) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %66 = "llvm.extractvalue"(%51) <{position = array<i64: 4>}> : (!llvm.struct<(ptr, i64, i64, i64, i64, i64)>) -> i64
    %67 = "llvm.insertvalue"(%65, %66) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %68 = "llvm.extractvalue"(%51) <{position = array<i64: 5>}> : (!llvm.struct<(ptr, i64, i64, i64, i64, i64)>) -> i64
    %69 = "llvm.insertvalue"(%67, %68) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    "llvm.return"(%69) : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(ptr, ptr, i64)> (ptr, ptr, i64)>, linkage = #llvm.linkage<external>, sym_name = "test_memref_0d", visibility_ = 0 : i64}> ({
  ^bb0(%arg10: !llvm.ptr, %arg11: !llvm.ptr, %arg12: i64):
    %22 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %23 = "llvm.insertvalue"(%22, %arg10) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %24 = "llvm.insertvalue"(%23, %arg11) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %25 = "llvm.insertvalue"(%24, %arg12) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
    %26 = "llvm.extractvalue"(%25) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
    %27 = "llvm.mlir.undef"() : () -> !llvm.struct<(ptr)>
    %28 = "llvm.extractvalue"(%25) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
    %29 = "llvm.insertvalue"(%27, %28) <{position = array<i64: 0>}> : (!llvm.struct<(ptr)>, !llvm.ptr) -> !llvm.struct<(ptr)>
    "llvm.return"(%25) : (!llvm.struct<(ptr, ptr, i64)>) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (ptr, ptr, i64, i64, i64, i64, i64, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "test_memref_ptradd_indexing", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: i64, %arg8: i64, %arg9: i64):
    %6 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %7 = "llvm.insertvalue"(%6, %arg0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %8 = "llvm.insertvalue"(%7, %arg1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %9 = "llvm.insertvalue"(%8, %arg2) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %10 = "llvm.insertvalue"(%9, %arg3) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %11 = "llvm.insertvalue"(%10, %arg6) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %12 = "llvm.insertvalue"(%11, %arg4) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %13 = "llvm.insertvalue"(%12, %arg7) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %14 = "llvm.insertvalue"(%13, %arg5) <{position = array<i64: 3, 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %15 = "llvm.insertvalue"(%14, %arg8) <{position = array<i64: 4, 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %16 = "llvm.extractvalue"(%15) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> !llvm.ptr
    %17 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %18 = "llvm.getelementptr"(%17) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %19 = "llvm.ptrtoint"(%18) : (!llvm.ptr) -> i64
    %20 = "llvm.mul"(%19, %arg9) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %21 = "llvm.getelementptr"(%16, %20) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.return"(%21) : (!llvm.ptr) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(ptr, ptr)> ()>, linkage = #llvm.linkage<external>, sym_name = "test_constant_address_ops", visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %1 = "llvm.inttoptr"(%0) : (i64) -> !llvm.ptr
    %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %3 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr)>
    %4 = "llvm.insertvalue"(%3, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr)>
    %5 = "llvm.insertvalue"(%4, %2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr)>
    "llvm.return"(%5) : (!llvm.struct<(ptr, ptr)>) -> ()
  }) : () -> ()
}) : () -> ()

