"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64)>, linkage = #llvm.linkage<external>, sym_name = "malloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "free", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, i64, i64, i64, i64, i64, ptr, ptr, i64)>, linkage = #llvm.linkage<private>, sym_name = "external", sym_visibility = "private", visibility_ = 0 : i64}> ({
  ^bb0(%arg58: !llvm.ptr, %arg59: !llvm.ptr, %arg60: i64, %arg61: i64, %arg62: i64, %arg63: i64, %arg64: i64, %arg65: !llvm.ptr, %arg66: !llvm.ptr, %arg67: i64):
    %288 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %289 = "llvm.insertvalue"(%288, %arg58) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %290 = "llvm.insertvalue"(%289, %arg59) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %291 = "llvm.insertvalue"(%290, %arg60) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %292 = "llvm.insertvalue"(%291, %arg61) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %293 = "llvm.insertvalue"(%292, %arg63) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %294 = "llvm.insertvalue"(%293, %arg62) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %295 = "llvm.insertvalue"(%294, %arg64) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %296 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %297 = "llvm.alloca"(%296) <{elem_type = !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>}> : (i64) -> !llvm.ptr
    "llvm.store"(%295, %297) <{ordering = 0 : i64}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> ()
    %298 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %299 = "llvm.insertvalue"(%298, %arg65) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %300 = "llvm.insertvalue"(%299, %arg66) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %301 = "llvm.insertvalue"(%300, %arg67) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
    %302 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %303 = "llvm.alloca"(%302) <{elem_type = !llvm.struct<(ptr, ptr, i64)>}> : (i64) -> !llvm.ptr
    "llvm.store"(%301, %303) <{ordering = 0 : i64}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> ()
    "llvm.call"(%297, %303) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_mlir_ciface_external, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_external", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, struct<(ptr, ptr, i64)>)> ()>, linkage = #llvm.linkage<private>, sym_name = "returner", sym_visibility = "private", visibility_ = 0 : i64}> ({
    %285 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %286 = "llvm.alloca"(%285) <{elem_type = !llvm.struct<(struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, struct<(ptr, ptr, i64)>)>}> : (i64) -> !llvm.ptr
    "llvm.call"(%286) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_mlir_ciface_returner, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    %287 = "llvm.load"(%286) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.struct<(struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, struct<(ptr, ptr, i64)>)>
    "llvm.return"(%287) : (!llvm.struct<(struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, struct<(ptr, ptr, i64)>)>) -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_returner", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "caller", visibility_ = 0 : i64}> ({
    %272 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @returner, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.struct<(struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, struct<(ptr, ptr, i64)>)>
    %273 = "llvm.extractvalue"(%272) <{position = array<i64: 0>}> : (!llvm.struct<(struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, struct<(ptr, ptr, i64)>)>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %274 = "llvm.extractvalue"(%272) <{position = array<i64: 1>}> : (!llvm.struct<(struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, struct<(ptr, ptr, i64)>)>) -> !llvm.struct<(ptr, ptr, i64)>
    %275 = "llvm.extractvalue"(%273) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %276 = "llvm.extractvalue"(%273) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %277 = "llvm.extractvalue"(%273) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %278 = "llvm.extractvalue"(%273) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %279 = "llvm.extractvalue"(%273) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %280 = "llvm.extractvalue"(%273) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %281 = "llvm.extractvalue"(%273) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %282 = "llvm.extractvalue"(%274) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
    %283 = "llvm.extractvalue"(%274) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
    %284 = "llvm.extractvalue"(%274) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>) -> i64
    "llvm.call"(%275, %276, %277, %278, %279, %280, %281, %282, %283, %284) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @external, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 10, 0>}> : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64, !llvm.ptr, !llvm.ptr, i64) -> ()
    "llvm.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_caller", visibility_ = 0 : i64}> ({
    "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @caller, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
    "llvm.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, i64, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "callee", visibility_ = 0 : i64}> ({
  ^bb0(%arg52: !llvm.ptr, %arg53: !llvm.ptr, %arg54: i64, %arg55: i64, %arg56: i64, %arg57: i64):
    %263 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %264 = "llvm.insertvalue"(%263, %arg52) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %265 = "llvm.insertvalue"(%264, %arg53) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %266 = "llvm.insertvalue"(%265, %arg54) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %267 = "llvm.insertvalue"(%266, %arg55) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %268 = "llvm.insertvalue"(%267, %arg56) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %269 = "llvm.extractvalue"(%268) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %270 = "llvm.getelementptr"(%269, %arg57) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %271 = "llvm.load"(%270) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
    "llvm.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, i64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_callee", visibility_ = 0 : i64}> ({
  ^bb0(%arg50: !llvm.ptr, %arg51: i64):
    %257 = "llvm.load"(%arg50) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %258 = "llvm.extractvalue"(%257) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %259 = "llvm.extractvalue"(%257) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %260 = "llvm.extractvalue"(%257) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %261 = "llvm.extractvalue"(%257) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %262 = "llvm.extractvalue"(%257) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    "llvm.call"(%258, %259, %260, %261, %262, %arg51) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @callee, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 6, 0>}> : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64) -> ()
    "llvm.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, i64, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "other_callee", visibility_ = 0 : i64}> ({
  ^bb0(%arg44: !llvm.ptr, %arg45: !llvm.ptr, %arg46: i64, %arg47: i64, %arg48: i64, %arg49: i64):
    %248 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %249 = "llvm.insertvalue"(%248, %arg44) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %250 = "llvm.insertvalue"(%249, %arg45) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %251 = "llvm.insertvalue"(%250, %arg46) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %252 = "llvm.insertvalue"(%251, %arg47) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %253 = "llvm.insertvalue"(%252, %arg48) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %254 = "llvm.extractvalue"(%253) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %255 = "llvm.getelementptr"(%254, %arg49) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %256 = "llvm.load"(%255) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
    "llvm.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, i64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_other_callee", visibility_ = 0 : i64}> ({
  ^bb0(%arg42: !llvm.ptr, %arg43: i64):
    %242 = "llvm.load"(%arg42) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %243 = "llvm.extractvalue"(%242) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %244 = "llvm.extractvalue"(%242) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %245 = "llvm.extractvalue"(%242) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %246 = "llvm.extractvalue"(%242) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %247 = "llvm.extractvalue"(%242) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    "llvm.call"(%243, %244, %245, %246, %247, %arg43) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @other_callee, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 6, 0>}> : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64) -> ()
    "llvm.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, i64, i64, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "return_var_memref_caller", visibility_ = 0 : i64}> ({
  ^bb0(%arg35: !llvm.ptr, %arg36: !llvm.ptr, %arg37: i64, %arg38: i64, %arg39: i64, %arg40: i64, %arg41: i64):
    %210 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %211 = "llvm.insertvalue"(%210, %arg35) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %212 = "llvm.insertvalue"(%211, %arg36) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %213 = "llvm.insertvalue"(%212, %arg37) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %214 = "llvm.insertvalue"(%213, %arg38) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %215 = "llvm.insertvalue"(%214, %arg40) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %216 = "llvm.insertvalue"(%215, %arg39) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %217 = "llvm.insertvalue"(%216, %arg41) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %218 = "llvm.extractvalue"(%217) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %219 = "llvm.extractvalue"(%217) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %220 = "llvm.extractvalue"(%217) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %221 = "llvm.extractvalue"(%217) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %222 = "llvm.extractvalue"(%217) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %223 = "llvm.extractvalue"(%217) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %224 = "llvm.extractvalue"(%217) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %225 = "llvm.call"(%218, %219, %220, %221, %222, %223, %224) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @return_var_memref, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 7, 0>}> : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> !llvm.struct<(i64, ptr)>
    %226 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %227 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %228 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i64
    %229 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i64
    %230 = "llvm.mul"(%227, %229) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %231 = "llvm.extractvalue"(%225) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>) -> i64
    %232 = "llvm.mul"(%227, %231) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %233 = "llvm.add"(%232, %226) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %234 = "llvm.mul"(%233, %228) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %235 = "llvm.add"(%230, %234) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %236 = "llvm.alloca"(%235) <{elem_type = i8}> : (i64) -> !llvm.ptr
    %237 = "llvm.extractvalue"(%225) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>) -> !llvm.ptr
    "llvm.intr.memcpy"(%236, %237, %235) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    "llvm.call"(%237) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    %238 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, ptr)>
    %239 = "llvm.extractvalue"(%225) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>) -> i64
    %240 = "llvm.insertvalue"(%238, %239) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>, i64) -> !llvm.struct<(i64, ptr)>
    %241 = "llvm.insertvalue"(%240, %236) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>, !llvm.ptr) -> !llvm.struct<(i64, ptr)>
    "llvm.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_return_var_memref_caller", visibility_ = 0 : i64}> ({
  ^bb0(%arg34: !llvm.ptr):
    %202 = "llvm.load"(%arg34) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %203 = "llvm.extractvalue"(%202) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %204 = "llvm.extractvalue"(%202) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %205 = "llvm.extractvalue"(%202) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %206 = "llvm.extractvalue"(%202) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %207 = "llvm.extractvalue"(%202) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %208 = "llvm.extractvalue"(%202) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %209 = "llvm.extractvalue"(%202) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    "llvm.call"(%203, %204, %205, %206, %207, %208, %209) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @return_var_memref_caller, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 7, 0>}> : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> ()
    "llvm.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(i64, ptr)> (ptr, ptr, i64, i64, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "return_var_memref", visibility_ = 0 : i64}> ({
  ^bb0(%arg27: !llvm.ptr, %arg28: !llvm.ptr, %arg29: i64, %arg30: i64, %arg31: i64, %arg32: i64, %arg33: i64):
    %172 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %173 = "llvm.insertvalue"(%172, %arg27) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %174 = "llvm.insertvalue"(%173, %arg28) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %175 = "llvm.insertvalue"(%174, %arg29) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %176 = "llvm.insertvalue"(%175, %arg30) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %177 = "llvm.insertvalue"(%176, %arg32) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %178 = "llvm.insertvalue"(%177, %arg31) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %179 = "llvm.insertvalue"(%178, %arg33) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %180 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %181 = "llvm.alloca"(%180) <{elem_type = !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>}> : (i64) -> !llvm.ptr
    "llvm.store"(%179, %181) <{ordering = 0 : i64}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> ()
    %182 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %183 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, ptr)>
    %184 = "llvm.insertvalue"(%183, %182) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>, i64) -> !llvm.struct<(i64, ptr)>
    %185 = "llvm.insertvalue"(%184, %181) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>, !llvm.ptr) -> !llvm.struct<(i64, ptr)>
    %186 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %187 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %188 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i64
    %189 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i64
    %190 = "llvm.mul"(%187, %189) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %191 = "llvm.extractvalue"(%185) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>) -> i64
    %192 = "llvm.mul"(%187, %191) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %193 = "llvm.add"(%192, %186) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %194 = "llvm.mul"(%193, %188) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %195 = "llvm.add"(%190, %194) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %196 = "llvm.call"(%195) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %197 = "llvm.extractvalue"(%185) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>) -> !llvm.ptr
    "llvm.intr.memcpy"(%196, %197, %195) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %198 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, ptr)>
    %199 = "llvm.extractvalue"(%185) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>) -> i64
    %200 = "llvm.insertvalue"(%198, %199) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>, i64) -> !llvm.struct<(i64, ptr)>
    %201 = "llvm.insertvalue"(%200, %196) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>, !llvm.ptr) -> !llvm.struct<(i64, ptr)>
    "llvm.return"(%201) : (!llvm.struct<(i64, ptr)>) -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_return_var_memref", visibility_ = 0 : i64}> ({
  ^bb0(%arg25: !llvm.ptr, %arg26: !llvm.ptr):
    %163 = "llvm.load"(%arg26) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %164 = "llvm.extractvalue"(%163) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %165 = "llvm.extractvalue"(%163) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %166 = "llvm.extractvalue"(%163) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %167 = "llvm.extractvalue"(%163) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %168 = "llvm.extractvalue"(%163) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %169 = "llvm.extractvalue"(%163) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %170 = "llvm.extractvalue"(%163) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %171 = "llvm.call"(%164, %165, %166, %167, %168, %169, %170) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @return_var_memref, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 7, 0>}> : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> !llvm.struct<(i64, ptr)>
    "llvm.store"(%171, %arg25) <{ordering = 0 : i64}> : (!llvm.struct<(i64, ptr)>, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, i64, i64, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "return_two_var_memref_caller", visibility_ = 0 : i64}> ({
  ^bb0(%arg18: !llvm.ptr, %arg19: !llvm.ptr, %arg20: i64, %arg21: i64, %arg22: i64, %arg23: i64, %arg24: i64):
    %113 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %114 = "llvm.insertvalue"(%113, %arg18) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %115 = "llvm.insertvalue"(%114, %arg19) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %116 = "llvm.insertvalue"(%115, %arg20) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %117 = "llvm.insertvalue"(%116, %arg21) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %118 = "llvm.insertvalue"(%117, %arg23) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %119 = "llvm.insertvalue"(%118, %arg22) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %120 = "llvm.insertvalue"(%119, %arg24) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %121 = "llvm.extractvalue"(%120) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %122 = "llvm.extractvalue"(%120) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %123 = "llvm.extractvalue"(%120) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %124 = "llvm.extractvalue"(%120) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %125 = "llvm.extractvalue"(%120) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %126 = "llvm.extractvalue"(%120) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %127 = "llvm.extractvalue"(%120) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %128 = "llvm.call"(%121, %122, %123, %124, %125, %126, %127) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @return_two_var_memref, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 7, 0>}> : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> !llvm.struct<(struct<(i64, ptr)>, struct<(i64, ptr)>)>
    %129 = "llvm.extractvalue"(%128) <{position = array<i64: 0>}> : (!llvm.struct<(struct<(i64, ptr)>, struct<(i64, ptr)>)>) -> !llvm.struct<(i64, ptr)>
    %130 = "llvm.extractvalue"(%128) <{position = array<i64: 1>}> : (!llvm.struct<(struct<(i64, ptr)>, struct<(i64, ptr)>)>) -> !llvm.struct<(i64, ptr)>
    %131 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %132 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %133 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i64
    %134 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i64
    %135 = "llvm.mul"(%132, %134) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %136 = "llvm.extractvalue"(%129) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>) -> i64
    %137 = "llvm.mul"(%132, %136) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %138 = "llvm.add"(%137, %131) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %139 = "llvm.mul"(%138, %133) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %140 = "llvm.add"(%135, %139) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %141 = "llvm.alloca"(%140) <{elem_type = i8}> : (i64) -> !llvm.ptr
    %142 = "llvm.extractvalue"(%129) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>) -> !llvm.ptr
    "llvm.intr.memcpy"(%141, %142, %140) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    "llvm.call"(%142) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    %143 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, ptr)>
    %144 = "llvm.extractvalue"(%129) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>) -> i64
    %145 = "llvm.insertvalue"(%143, %144) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>, i64) -> !llvm.struct<(i64, ptr)>
    %146 = "llvm.insertvalue"(%145, %141) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>, !llvm.ptr) -> !llvm.struct<(i64, ptr)>
    %147 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %148 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %149 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i64
    %150 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i64
    %151 = "llvm.mul"(%148, %150) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %152 = "llvm.extractvalue"(%130) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>) -> i64
    %153 = "llvm.mul"(%148, %152) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %154 = "llvm.add"(%153, %147) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %155 = "llvm.mul"(%154, %149) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %156 = "llvm.add"(%151, %155) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %157 = "llvm.alloca"(%156) <{elem_type = i8}> : (i64) -> !llvm.ptr
    %158 = "llvm.extractvalue"(%130) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>) -> !llvm.ptr
    "llvm.intr.memcpy"(%157, %158, %156) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    "llvm.call"(%158) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    %159 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, ptr)>
    %160 = "llvm.extractvalue"(%130) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>) -> i64
    %161 = "llvm.insertvalue"(%159, %160) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>, i64) -> !llvm.struct<(i64, ptr)>
    %162 = "llvm.insertvalue"(%161, %157) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>, !llvm.ptr) -> !llvm.struct<(i64, ptr)>
    "llvm.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_return_two_var_memref_caller", visibility_ = 0 : i64}> ({
  ^bb0(%arg17: !llvm.ptr):
    %105 = "llvm.load"(%arg17) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %106 = "llvm.extractvalue"(%105) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %107 = "llvm.extractvalue"(%105) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %108 = "llvm.extractvalue"(%105) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %109 = "llvm.extractvalue"(%105) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %110 = "llvm.extractvalue"(%105) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %111 = "llvm.extractvalue"(%105) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %112 = "llvm.extractvalue"(%105) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    "llvm.call"(%106, %107, %108, %109, %110, %111, %112) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @return_two_var_memref_caller, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 7, 0>}> : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> ()
    "llvm.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(struct<(i64, ptr)>, struct<(i64, ptr)>)> (ptr, ptr, i64, i64, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "return_two_var_memref", visibility_ = 0 : i64}> ({
  ^bb0(%arg10: !llvm.ptr, %arg11: !llvm.ptr, %arg12: i64, %arg13: i64, %arg14: i64, %arg15: i64, %arg16: i64):
    %56 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %57 = "llvm.insertvalue"(%56, %arg10) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %58 = "llvm.insertvalue"(%57, %arg11) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %59 = "llvm.insertvalue"(%58, %arg12) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %60 = "llvm.insertvalue"(%59, %arg13) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %61 = "llvm.insertvalue"(%60, %arg15) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %62 = "llvm.insertvalue"(%61, %arg14) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %63 = "llvm.insertvalue"(%62, %arg16) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %64 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %65 = "llvm.alloca"(%64) <{elem_type = !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>}> : (i64) -> !llvm.ptr
    "llvm.store"(%63, %65) <{ordering = 0 : i64}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> ()
    %66 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %67 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, ptr)>
    %68 = "llvm.insertvalue"(%67, %66) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>, i64) -> !llvm.struct<(i64, ptr)>
    %69 = "llvm.insertvalue"(%68, %65) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>, !llvm.ptr) -> !llvm.struct<(i64, ptr)>
    %70 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %71 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %72 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i64
    %73 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i64
    %74 = "llvm.mul"(%71, %73) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %75 = "llvm.extractvalue"(%69) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>) -> i64
    %76 = "llvm.mul"(%71, %75) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %77 = "llvm.add"(%76, %70) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %78 = "llvm.mul"(%77, %72) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %79 = "llvm.add"(%74, %78) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %80 = "llvm.call"(%79) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %81 = "llvm.extractvalue"(%69) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>) -> !llvm.ptr
    "llvm.intr.memcpy"(%80, %81, %79) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %82 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, ptr)>
    %83 = "llvm.extractvalue"(%69) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>) -> i64
    %84 = "llvm.insertvalue"(%82, %83) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>, i64) -> !llvm.struct<(i64, ptr)>
    %85 = "llvm.insertvalue"(%84, %80) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>, !llvm.ptr) -> !llvm.struct<(i64, ptr)>
    %86 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %87 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %88 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i64
    %89 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i64
    %90 = "llvm.mul"(%87, %89) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %91 = "llvm.extractvalue"(%69) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>) -> i64
    %92 = "llvm.mul"(%87, %91) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %93 = "llvm.add"(%92, %86) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %94 = "llvm.mul"(%93, %88) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %95 = "llvm.add"(%90, %94) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %96 = "llvm.call"(%95) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %97 = "llvm.extractvalue"(%69) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>) -> !llvm.ptr
    "llvm.intr.memcpy"(%96, %97, %95) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %98 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, ptr)>
    %99 = "llvm.extractvalue"(%69) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>) -> i64
    %100 = "llvm.insertvalue"(%98, %99) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>, i64) -> !llvm.struct<(i64, ptr)>
    %101 = "llvm.insertvalue"(%100, %96) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>, !llvm.ptr) -> !llvm.struct<(i64, ptr)>
    %102 = "llvm.mlir.poison"() : () -> !llvm.struct<(struct<(i64, ptr)>, struct<(i64, ptr)>)>
    %103 = "llvm.insertvalue"(%102, %85) <{position = array<i64: 0>}> : (!llvm.struct<(struct<(i64, ptr)>, struct<(i64, ptr)>)>, !llvm.struct<(i64, ptr)>) -> !llvm.struct<(struct<(i64, ptr)>, struct<(i64, ptr)>)>
    %104 = "llvm.insertvalue"(%103, %101) <{position = array<i64: 1>}> : (!llvm.struct<(struct<(i64, ptr)>, struct<(i64, ptr)>)>, !llvm.struct<(i64, ptr)>) -> !llvm.struct<(struct<(i64, ptr)>, struct<(i64, ptr)>)>
    "llvm.return"(%104) : (!llvm.struct<(struct<(i64, ptr)>, struct<(i64, ptr)>)>) -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_return_two_var_memref", visibility_ = 0 : i64}> ({
  ^bb0(%arg8: !llvm.ptr, %arg9: !llvm.ptr):
    %47 = "llvm.load"(%arg9) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %48 = "llvm.extractvalue"(%47) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %49 = "llvm.extractvalue"(%47) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %50 = "llvm.extractvalue"(%47) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %51 = "llvm.extractvalue"(%47) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %52 = "llvm.extractvalue"(%47) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %53 = "llvm.extractvalue"(%47) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %54 = "llvm.extractvalue"(%47) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %55 = "llvm.call"(%48, %49, %50, %51, %52, %53, %54) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @return_two_var_memref, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 7, 0>}> : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> !llvm.struct<(struct<(i64, ptr)>, struct<(i64, ptr)>)>
    "llvm.store"(%55, %arg8) <{ordering = 0 : i64}> : (!llvm.struct<(struct<(i64, ptr)>, struct<(i64, ptr)>)>, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (ptr, i64, i64, f32)>, linkage = #llvm.linkage<external>, sym_name = "bare_ptr_calling_conv", visibility_ = 0 : i64}> ({
  ^bb0(%arg4: !llvm.ptr, %arg5: i64, %arg6: i64, %arg7: f32):
    %28 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %29 = "llvm.insertvalue"(%28, %arg4) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %30 = "llvm.insertvalue"(%29, %arg4) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %31 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %32 = "llvm.insertvalue"(%30, %31) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %33 = "llvm.mlir.constant"() <{value = 4 : index}> : () -> i64
    %34 = "llvm.insertvalue"(%32, %33) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %35 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
    %36 = "llvm.insertvalue"(%34, %35) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %37 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
    %38 = "llvm.insertvalue"(%36, %37) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %39 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %40 = "llvm.insertvalue"(%38, %39) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %41 = "llvm.extractvalue"(%40) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %42 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
    %43 = "llvm.mul"(%arg5, %42) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %44 = "llvm.add"(%43, %arg6) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %45 = "llvm.getelementptr"(%41, %44) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.store"(%arg7, %45) <{ordering = 0 : i64}> : (f32, !llvm.ptr) -> ()
    %46 = "llvm.extractvalue"(%40) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    "llvm.return"(%46) : (!llvm.ptr) -> ()
  }) {llvm.bareptr, llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(f32, ptr)> (ptr, i64, i64, f32)>, linkage = #llvm.linkage<external>, sym_name = "bare_ptr_calling_conv_multiresult", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64, %arg3: f32):
    %0 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = "llvm.insertvalue"(%0, %arg0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %2 = "llvm.insertvalue"(%1, %arg0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %4 = "llvm.insertvalue"(%2, %3) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %5 = "llvm.mlir.constant"() <{value = 4 : index}> : () -> i64
    %6 = "llvm.insertvalue"(%4, %5) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %7 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
    %8 = "llvm.insertvalue"(%6, %7) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %9 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
    %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %11 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %12 = "llvm.insertvalue"(%10, %11) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %13 = "llvm.extractvalue"(%12) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %14 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
    %15 = "llvm.mul"(%arg1, %14) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %16 = "llvm.add"(%15, %arg2) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %17 = "llvm.getelementptr"(%13, %16) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.store"(%arg3, %17) <{ordering = 0 : i64}> : (f32, !llvm.ptr) -> ()
    %18 = "llvm.extractvalue"(%12) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %19 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
    %20 = "llvm.mul"(%arg1, %19) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %21 = "llvm.add"(%20, %arg2) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %22 = "llvm.getelementptr"(%18, %21) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %23 = "llvm.load"(%22) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
    %24 = "llvm.extractvalue"(%12) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %25 = "llvm.mlir.poison"() : () -> !llvm.struct<(f32, ptr)>
    %26 = "llvm.insertvalue"(%25, %23) <{position = array<i64: 0>}> : (!llvm.struct<(f32, ptr)>, f32) -> !llvm.struct<(f32, ptr)>
    %27 = "llvm.insertvalue"(%26, %24) <{position = array<i64: 1>}> : (!llvm.struct<(f32, ptr)>, !llvm.ptr) -> !llvm.struct<(f32, ptr)>
    "llvm.return"(%27) : (!llvm.struct<(f32, ptr)>) -> ()
  }) {llvm.bareptr, llvm.emit_c_interface} : () -> ()
}) : () -> ()

