"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64)>, linkage = #llvm.linkage<external>, sym_name = "malloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "free", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, i64, i64, i64, i64, i64, ptr, ptr, i64)>, linkage = #llvm.linkage<external>, sym_name = "external", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, struct<(ptr, ptr, i64)>)> ()>, linkage = #llvm.linkage<external>, sym_name = "returner", sym_visibility = "private", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "caller", visibility_ = 0 : i64}> ({
    %250 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @returner, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.struct<(struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, struct<(ptr, ptr, i64)>)>
    %251 = "llvm.extractvalue"(%250) <{position = array<i64: 0>}> : (!llvm.struct<(struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, struct<(ptr, ptr, i64)>)>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %252 = "llvm.extractvalue"(%250) <{position = array<i64: 1>}> : (!llvm.struct<(struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, struct<(ptr, ptr, i64)>)>) -> !llvm.struct<(ptr, ptr, i64)>
    %253 = "llvm.extractvalue"(%251) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %254 = "llvm.extractvalue"(%251) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %255 = "llvm.extractvalue"(%251) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %256 = "llvm.extractvalue"(%251) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %257 = "llvm.extractvalue"(%251) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %258 = "llvm.extractvalue"(%251) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %259 = "llvm.extractvalue"(%251) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %260 = "llvm.extractvalue"(%252) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
    %261 = "llvm.extractvalue"(%252) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
    %262 = "llvm.extractvalue"(%252) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>) -> i64
    "llvm.call"(%253, %254, %255, %256, %257, %258, %259, %260, %261, %262) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @external, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 10, 0>}> : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64, !llvm.ptr, !llvm.ptr, i64) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, i64, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "callee", visibility_ = 0 : i64}> ({
  ^bb0(%arg48: !llvm.ptr, %arg49: !llvm.ptr, %arg50: i64, %arg51: i64, %arg52: i64, %arg53: i64):
    %241 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %242 = "llvm.insertvalue"(%241, %arg48) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %243 = "llvm.insertvalue"(%242, %arg49) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %244 = "llvm.insertvalue"(%243, %arg50) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %245 = "llvm.insertvalue"(%244, %arg51) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %246 = "llvm.insertvalue"(%245, %arg52) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %247 = "llvm.extractvalue"(%246) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %248 = "llvm.getelementptr"(%247, %arg53) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %249 = "llvm.load"(%248) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, i64, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "other_callee", visibility_ = 0 : i64}> ({
  ^bb0(%arg42: !llvm.ptr, %arg43: !llvm.ptr, %arg44: i64, %arg45: i64, %arg46: i64, %arg47: i64):
    %232 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %233 = "llvm.insertvalue"(%232, %arg42) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %234 = "llvm.insertvalue"(%233, %arg43) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %235 = "llvm.insertvalue"(%234, %arg44) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %236 = "llvm.insertvalue"(%235, %arg45) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %237 = "llvm.insertvalue"(%236, %arg46) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %238 = "llvm.extractvalue"(%237) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %239 = "llvm.getelementptr"(%238, %arg47) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %240 = "llvm.load"(%239) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
    "llvm.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, i64)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_other_callee", visibility_ = 0 : i64}> ({
  ^bb0(%arg40: !llvm.ptr, %arg41: i64):
    %226 = "llvm.load"(%arg40) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %227 = "llvm.extractvalue"(%226) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %228 = "llvm.extractvalue"(%226) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %229 = "llvm.extractvalue"(%226) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %230 = "llvm.extractvalue"(%226) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %231 = "llvm.extractvalue"(%226) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    "llvm.call"(%227, %228, %229, %230, %231, %arg41) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @other_callee, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 6, 0>}> : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64) -> ()
    "llvm.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, i64, i64, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "return_var_memref_caller", visibility_ = 0 : i64}> ({
  ^bb0(%arg33: !llvm.ptr, %arg34: !llvm.ptr, %arg35: i64, %arg36: i64, %arg37: i64, %arg38: i64, %arg39: i64):
    %194 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %195 = "llvm.insertvalue"(%194, %arg33) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %196 = "llvm.insertvalue"(%195, %arg34) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %197 = "llvm.insertvalue"(%196, %arg35) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %198 = "llvm.insertvalue"(%197, %arg36) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %199 = "llvm.insertvalue"(%198, %arg38) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %200 = "llvm.insertvalue"(%199, %arg37) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %201 = "llvm.insertvalue"(%200, %arg39) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %202 = "llvm.extractvalue"(%201) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %203 = "llvm.extractvalue"(%201) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %204 = "llvm.extractvalue"(%201) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %205 = "llvm.extractvalue"(%201) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %206 = "llvm.extractvalue"(%201) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %207 = "llvm.extractvalue"(%201) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %208 = "llvm.extractvalue"(%201) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %209 = "llvm.call"(%202, %203, %204, %205, %206, %207, %208) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @return_var_memref, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 7, 0>}> : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> !llvm.struct<(i64, ptr)>
    %210 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %211 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %212 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i64
    %213 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i64
    %214 = "llvm.mul"(%211, %213) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %215 = "llvm.extractvalue"(%209) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>) -> i64
    %216 = "llvm.mul"(%211, %215) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %217 = "llvm.add"(%216, %210) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %218 = "llvm.mul"(%217, %212) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %219 = "llvm.add"(%214, %218) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %220 = "llvm.alloca"(%219) <{elem_type = i8}> : (i64) -> !llvm.ptr
    %221 = "llvm.extractvalue"(%209) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>) -> !llvm.ptr
    "llvm.intr.memcpy"(%220, %221, %219) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    "llvm.call"(%221) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    %222 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, ptr)>
    %223 = "llvm.extractvalue"(%209) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>) -> i64
    %224 = "llvm.insertvalue"(%222, %223) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>, i64) -> !llvm.struct<(i64, ptr)>
    %225 = "llvm.insertvalue"(%224, %220) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>, !llvm.ptr) -> !llvm.struct<(i64, ptr)>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(i64, ptr)> (ptr, ptr, i64, i64, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "return_var_memref", visibility_ = 0 : i64}> ({
  ^bb0(%arg26: !llvm.ptr, %arg27: !llvm.ptr, %arg28: i64, %arg29: i64, %arg30: i64, %arg31: i64, %arg32: i64):
    %164 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %165 = "llvm.insertvalue"(%164, %arg26) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %166 = "llvm.insertvalue"(%165, %arg27) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %167 = "llvm.insertvalue"(%166, %arg28) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %168 = "llvm.insertvalue"(%167, %arg29) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %169 = "llvm.insertvalue"(%168, %arg31) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %170 = "llvm.insertvalue"(%169, %arg30) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %171 = "llvm.insertvalue"(%170, %arg32) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %172 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %173 = "llvm.alloca"(%172) <{elem_type = !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>}> : (i64) -> !llvm.ptr
    "llvm.store"(%171, %173) <{ordering = 0 : i64}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> ()
    %174 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %175 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, ptr)>
    %176 = "llvm.insertvalue"(%175, %174) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>, i64) -> !llvm.struct<(i64, ptr)>
    %177 = "llvm.insertvalue"(%176, %173) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>, !llvm.ptr) -> !llvm.struct<(i64, ptr)>
    %178 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %179 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %180 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i64
    %181 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i64
    %182 = "llvm.mul"(%179, %181) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %183 = "llvm.extractvalue"(%177) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>) -> i64
    %184 = "llvm.mul"(%179, %183) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %185 = "llvm.add"(%184, %178) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %186 = "llvm.mul"(%185, %180) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %187 = "llvm.add"(%182, %186) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %188 = "llvm.call"(%187) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %189 = "llvm.extractvalue"(%177) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>) -> !llvm.ptr
    "llvm.intr.memcpy"(%188, %189, %187) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %190 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, ptr)>
    %191 = "llvm.extractvalue"(%177) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>) -> i64
    %192 = "llvm.insertvalue"(%190, %191) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>, i64) -> !llvm.struct<(i64, ptr)>
    %193 = "llvm.insertvalue"(%192, %188) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>, !llvm.ptr) -> !llvm.struct<(i64, ptr)>
    "llvm.return"(%193) : (!llvm.struct<(i64, ptr)>) -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_return_var_memref", visibility_ = 0 : i64}> ({
  ^bb0(%arg24: !llvm.ptr, %arg25: !llvm.ptr):
    %155 = "llvm.load"(%arg25) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %156 = "llvm.extractvalue"(%155) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %157 = "llvm.extractvalue"(%155) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %158 = "llvm.extractvalue"(%155) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %159 = "llvm.extractvalue"(%155) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %160 = "llvm.extractvalue"(%155) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %161 = "llvm.extractvalue"(%155) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %162 = "llvm.extractvalue"(%155) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %163 = "llvm.call"(%156, %157, %158, %159, %160, %161, %162) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @return_var_memref, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 7, 0>}> : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> !llvm.struct<(i64, ptr)>
    "llvm.store"(%163, %arg24) <{ordering = 0 : i64}> : (!llvm.struct<(i64, ptr)>, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, i64, i64, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "return_two_var_memref_caller", visibility_ = 0 : i64}> ({
  ^bb0(%arg17: !llvm.ptr, %arg18: !llvm.ptr, %arg19: i64, %arg20: i64, %arg21: i64, %arg22: i64, %arg23: i64):
    %105 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %106 = "llvm.insertvalue"(%105, %arg17) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %107 = "llvm.insertvalue"(%106, %arg18) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %108 = "llvm.insertvalue"(%107, %arg19) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %109 = "llvm.insertvalue"(%108, %arg20) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %110 = "llvm.insertvalue"(%109, %arg22) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %111 = "llvm.insertvalue"(%110, %arg21) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %112 = "llvm.insertvalue"(%111, %arg23) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %113 = "llvm.extractvalue"(%112) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %114 = "llvm.extractvalue"(%112) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %115 = "llvm.extractvalue"(%112) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %116 = "llvm.extractvalue"(%112) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %117 = "llvm.extractvalue"(%112) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %118 = "llvm.extractvalue"(%112) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %119 = "llvm.extractvalue"(%112) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %120 = "llvm.call"(%113, %114, %115, %116, %117, %118, %119) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @return_two_var_memref, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 7, 0>}> : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> !llvm.struct<(struct<(i64, ptr)>, struct<(i64, ptr)>)>
    %121 = "llvm.extractvalue"(%120) <{position = array<i64: 0>}> : (!llvm.struct<(struct<(i64, ptr)>, struct<(i64, ptr)>)>) -> !llvm.struct<(i64, ptr)>
    %122 = "llvm.extractvalue"(%120) <{position = array<i64: 1>}> : (!llvm.struct<(struct<(i64, ptr)>, struct<(i64, ptr)>)>) -> !llvm.struct<(i64, ptr)>
    %123 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %124 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %125 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i64
    %126 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i64
    %127 = "llvm.mul"(%124, %126) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %128 = "llvm.extractvalue"(%121) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>) -> i64
    %129 = "llvm.mul"(%124, %128) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %130 = "llvm.add"(%129, %123) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %131 = "llvm.mul"(%130, %125) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %132 = "llvm.add"(%127, %131) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %133 = "llvm.alloca"(%132) <{elem_type = i8}> : (i64) -> !llvm.ptr
    %134 = "llvm.extractvalue"(%121) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>) -> !llvm.ptr
    "llvm.intr.memcpy"(%133, %134, %132) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    "llvm.call"(%134) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    %135 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, ptr)>
    %136 = "llvm.extractvalue"(%121) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>) -> i64
    %137 = "llvm.insertvalue"(%135, %136) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>, i64) -> !llvm.struct<(i64, ptr)>
    %138 = "llvm.insertvalue"(%137, %133) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>, !llvm.ptr) -> !llvm.struct<(i64, ptr)>
    %139 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %140 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %141 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i64
    %142 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i64
    %143 = "llvm.mul"(%140, %142) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %144 = "llvm.extractvalue"(%122) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>) -> i64
    %145 = "llvm.mul"(%140, %144) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %146 = "llvm.add"(%145, %139) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %147 = "llvm.mul"(%146, %141) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %148 = "llvm.add"(%143, %147) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %149 = "llvm.alloca"(%148) <{elem_type = i8}> : (i64) -> !llvm.ptr
    %150 = "llvm.extractvalue"(%122) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>) -> !llvm.ptr
    "llvm.intr.memcpy"(%149, %150, %148) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    "llvm.call"(%150) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    %151 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, ptr)>
    %152 = "llvm.extractvalue"(%122) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>) -> i64
    %153 = "llvm.insertvalue"(%151, %152) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>, i64) -> !llvm.struct<(i64, ptr)>
    %154 = "llvm.insertvalue"(%153, %149) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>, !llvm.ptr) -> !llvm.struct<(i64, ptr)>
    "llvm.return"() : () -> ()
  }) : () -> ()
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
  }) {llvm.bareptr} : () -> ()
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
  }) {llvm.bareptr} : () -> ()
}) : () -> ()

