"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64)>, linkage = #llvm.linkage<external>, sym_name = "malloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "matvec", visibility_ = 0 : i64}> ({
  ^bb0(%arg4: i64):
    %229 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuStreamCreate, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.ptr
    %230 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %231 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %232 = "llvm.getelementptr"(%231, %arg4) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %233 = "llvm.ptrtoint"(%232) : (!llvm.ptr) -> i64
    %234 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %235 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
    %236 = "llvm.call"(%233, %229, %235) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuMemAlloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (i64, !llvm.ptr, i8) -> !llvm.ptr
    %237 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %238 = "llvm.insertvalue"(%237, %236) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %239 = "llvm.insertvalue"(%238, %236) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %240 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %241 = "llvm.insertvalue"(%239, %240) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %242 = "llvm.insertvalue"(%241, %arg4) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %243 = "llvm.insertvalue"(%242, %230) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %244 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %245 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %246 = "llvm.getelementptr"(%245, %arg4) <{elem_type = f64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %247 = "llvm.ptrtoint"(%246) : (!llvm.ptr) -> i64
    %248 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %249 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
    %250 = "llvm.call"(%247, %229, %249) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuMemAlloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (i64, !llvm.ptr, i8) -> !llvm.ptr
    %251 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %252 = "llvm.insertvalue"(%251, %250) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %253 = "llvm.insertvalue"(%252, %250) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %254 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %255 = "llvm.insertvalue"(%253, %254) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %256 = "llvm.insertvalue"(%255, %arg4) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %257 = "llvm.insertvalue"(%256, %244) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %258 = "llvm.extractvalue"(%243) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %259 = "llvm.extractvalue"(%243) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %260 = "llvm.extractvalue"(%257) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %261 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
    %262 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %263 = "llvm.call"(%arg4, %arg4, %arg4, %258, %259, %260, %261, %262, %229) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuCreateCoo, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 9, 0>}> : (i64, i64, i64, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, !llvm.ptr) -> !llvm.ptr
    %264 = "llvm.extractvalue"(%257) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %265 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %266 = "llvm.call"(%arg4, %264, %265, %229) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuCreateDnVec, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>}> : (i64, !llvm.ptr, i32, !llvm.ptr) -> !llvm.ptr
    %267 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %268 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %269 = "llvm.call"(%267, %263, %266, %266, %268, %229) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuSpMVBufferSize, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 6, 0>}> : (i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, !llvm.ptr) -> i64
    %270 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %271 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %272 = "llvm.extractvalue"(%257) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    "llvm.call"(%270, %263, %266, %266, %271, %272, %229) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuSpMV, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 7, 0>}> : (i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, !llvm.ptr, !llvm.ptr) -> ()
    "llvm.call"(%263, %229) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuDestroySpMat, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> ()
    "llvm.call"(%266, %229) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuDestroyDnVec, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> ()
    "llvm.call"(%229) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuStreamSynchronize, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "llvm.call"(%229) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuStreamDestroy, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "matmul", visibility_ = 0 : i64}> ({
  ^bb0(%arg3: i64):
    %182 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuStreamCreate, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.ptr
    %183 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %184 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %185 = "llvm.getelementptr"(%184, %arg3) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %186 = "llvm.ptrtoint"(%185) : (!llvm.ptr) -> i64
    %187 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %188 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
    %189 = "llvm.call"(%186, %182, %188) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuMemAlloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (i64, !llvm.ptr, i8) -> !llvm.ptr
    %190 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %191 = "llvm.insertvalue"(%190, %189) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %192 = "llvm.insertvalue"(%191, %189) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %193 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %194 = "llvm.insertvalue"(%192, %193) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %195 = "llvm.insertvalue"(%194, %arg3) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %196 = "llvm.insertvalue"(%195, %183) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %197 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %198 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %199 = "llvm.getelementptr"(%198, %arg3) <{elem_type = f64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %200 = "llvm.ptrtoint"(%199) : (!llvm.ptr) -> i64
    %201 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %202 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
    %203 = "llvm.call"(%200, %182, %202) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuMemAlloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (i64, !llvm.ptr, i8) -> !llvm.ptr
    %204 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %205 = "llvm.insertvalue"(%204, %203) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %206 = "llvm.insertvalue"(%205, %203) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %207 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %208 = "llvm.insertvalue"(%206, %207) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %209 = "llvm.insertvalue"(%208, %arg3) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %210 = "llvm.insertvalue"(%209, %197) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %211 = "llvm.extractvalue"(%196) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %212 = "llvm.extractvalue"(%196) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %213 = "llvm.extractvalue"(%210) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %214 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
    %215 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
    %216 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %217 = "llvm.call"(%arg3, %arg3, %arg3, %211, %212, %213, %214, %215, %216, %182) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuCreateCsr, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 10, 0>}> : (i64, i64, i64, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, !llvm.ptr) -> !llvm.ptr
    %218 = "llvm.extractvalue"(%210) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %219 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %220 = "llvm.call"(%arg3, %arg3, %218, %219, %182) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuCreateDnMat, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 5, 0>}> : (i64, i64, !llvm.ptr, i32, !llvm.ptr) -> !llvm.ptr
    %221 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %222 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %223 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %224 = "llvm.call"(%221, %222, %217, %220, %220, %223, %182) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuSpMMBufferSize, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 7, 0>}> : (i32, i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, !llvm.ptr) -> i64
    %225 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %226 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %227 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %228 = "llvm.extractvalue"(%210) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    "llvm.call"(%225, %226, %217, %220, %220, %227, %228, %182) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuSpMM, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 8, 0>}> : (i32, i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, !llvm.ptr, !llvm.ptr) -> ()
    "llvm.call"(%217, %182) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuDestroySpMat, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> ()
    "llvm.call"(%220, %182) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuDestroyDnMat, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> ()
    "llvm.call"(%182) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuStreamSynchronize, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "llvm.call"(%182) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuStreamDestroy, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "spgemm", visibility_ = 0 : i64}> ({
  ^bb0(%arg2: i64):
    %90 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %91 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuStreamCreate, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.ptr
    %92 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %93 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %94 = "llvm.getelementptr"(%93, %arg2) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %95 = "llvm.ptrtoint"(%94) : (!llvm.ptr) -> i64
    %96 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %97 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
    %98 = "llvm.call"(%95, %91, %97) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuMemAlloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (i64, !llvm.ptr, i8) -> !llvm.ptr
    %99 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %100 = "llvm.insertvalue"(%99, %98) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %101 = "llvm.insertvalue"(%100, %98) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %102 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %103 = "llvm.insertvalue"(%101, %102) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %104 = "llvm.insertvalue"(%103, %arg2) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %105 = "llvm.insertvalue"(%104, %92) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %106 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %107 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %108 = "llvm.getelementptr"(%107, %arg2) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %109 = "llvm.ptrtoint"(%108) : (!llvm.ptr) -> i64
    %110 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %111 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
    %112 = "llvm.call"(%109, %91, %111) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuMemAlloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (i64, !llvm.ptr, i8) -> !llvm.ptr
    %113 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %114 = "llvm.insertvalue"(%113, %112) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %115 = "llvm.insertvalue"(%114, %112) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %116 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %117 = "llvm.insertvalue"(%115, %116) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %118 = "llvm.insertvalue"(%117, %arg2) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %119 = "llvm.insertvalue"(%118, %106) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %120 = "llvm.extractvalue"(%105) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %121 = "llvm.extractvalue"(%105) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %122 = "llvm.extractvalue"(%119) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %123 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
    %124 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
    %125 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %126 = "llvm.call"(%arg2, %arg2, %arg2, %120, %121, %122, %123, %124, %125, %91) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuCreateCsr, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 10, 0>}> : (i64, i64, i64, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, !llvm.ptr) -> !llvm.ptr
    %127 = "llvm.extractvalue"(%105) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %128 = "llvm.extractvalue"(%105) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %129 = "llvm.extractvalue"(%119) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %130 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
    %131 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
    %132 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %133 = "llvm.call"(%arg2, %arg2, %arg2, %127, %128, %129, %130, %131, %132, %91) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuCreateCsr, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 10, 0>}> : (i64, i64, i64, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, !llvm.ptr) -> !llvm.ptr
    %134 = "llvm.extractvalue"(%105) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %135 = "llvm.extractvalue"(%105) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %136 = "llvm.extractvalue"(%119) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %137 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
    %138 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
    %139 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %140 = "llvm.call"(%arg2, %arg2, %arg2, %134, %135, %136, %137, %138, %139, %91) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuCreateCsr, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 10, 0>}> : (i64, i64, i64, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, !llvm.ptr) -> !llvm.ptr
    %141 = "llvm.call"(%91) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuSpGEMMCreateDescr, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> !llvm.ptr
    %142 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %143 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %144 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %145 = "llvm.getelementptr"(%144, %142) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %146 = "llvm.ptrtoint"(%145) : (!llvm.ptr) -> i64
    %147 = "llvm.call"(%146) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %148 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %149 = "llvm.insertvalue"(%148, %147) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %150 = "llvm.insertvalue"(%149, %147) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %151 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %152 = "llvm.insertvalue"(%150, %151) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %153 = "llvm.insertvalue"(%152, %142) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %154 = "llvm.insertvalue"(%153, %143) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %155 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %156 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %157 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %158 = "llvm.extractvalue"(%154) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %159 = "llvm.call"(%141, %156, %157, %126, %133, %140, %155, %90, %158, %91) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuSpGEMMWorkEstimation, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 10, 0>}> : (!llvm.ptr, i32, i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i64, !llvm.ptr, !llvm.ptr) -> i64
    %160 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %161 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %162 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %163 = "llvm.extractvalue"(%154) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %164 = "llvm.call"(%141, %161, %162, %126, %133, %140, %160, %90, %163, %91) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuSpGEMMCompute, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 10, 0>}> : (!llvm.ptr, i32, i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i64, !llvm.ptr, !llvm.ptr) -> i64
    %165 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
    %166 = "llvm.alloca"(%165) <{alignment = 16 : i64, elem_type = i64}> : (i64) -> !llvm.ptr
    %167 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %168 = "llvm.getelementptr"(%166, %167) <{elem_type = !llvm.ptr, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %169 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %170 = "llvm.getelementptr"(%166, %169) <{elem_type = !llvm.ptr, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %171 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %172 = "llvm.getelementptr"(%166, %171) <{elem_type = !llvm.ptr, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.call"(%140, %168, %170, %172, %91) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuSpMatGetSize, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 5, 0>}> : (!llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr) -> ()
    %173 = "llvm.load"(%168) <{ordering = 0 : i64}> : (!llvm.ptr) -> i64
    %174 = "llvm.load"(%170) <{ordering = 0 : i64}> : (!llvm.ptr) -> i64
    %175 = "llvm.load"(%172) <{ordering = 0 : i64}> : (!llvm.ptr) -> i64
    %176 = "llvm.extractvalue"(%105) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %177 = "llvm.extractvalue"(%105) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %178 = "llvm.extractvalue"(%119) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    "llvm.call"(%140, %176, %177, %178, %91) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuSetCsrPointers, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 5, 0>}> : (!llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr) -> ()
    %179 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %180 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %181 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    "llvm.call"(%141, %180, %181, %126, %133, %140, %179, %91) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuSpGEMMCopy, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 8, 0>}> : (!llvm.ptr, i32, i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, !llvm.ptr) -> ()
    "llvm.call"(%141, %91) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuSpGEMMDestroyDescr, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> ()
    "llvm.call"(%126, %91) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuDestroySpMat, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> ()
    "llvm.call"(%133, %91) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuDestroySpMat, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> ()
    "llvm.call"(%140, %91) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuDestroySpMat, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> ()
    "llvm.call"(%91) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuStreamSynchronize, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "llvm.call"(%91) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuStreamDestroy, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "sddmm", visibility_ = 0 : i64}> ({
  ^bb0(%arg1: i64):
    %43 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuStreamCreate, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.ptr
    %44 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %45 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %46 = "llvm.getelementptr"(%45, %arg1) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %47 = "llvm.ptrtoint"(%46) : (!llvm.ptr) -> i64
    %48 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %49 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
    %50 = "llvm.call"(%47, %43, %49) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuMemAlloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (i64, !llvm.ptr, i8) -> !llvm.ptr
    %51 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %52 = "llvm.insertvalue"(%51, %50) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %53 = "llvm.insertvalue"(%52, %50) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %54 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %55 = "llvm.insertvalue"(%53, %54) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %56 = "llvm.insertvalue"(%55, %arg1) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %57 = "llvm.insertvalue"(%56, %44) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %58 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %59 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %60 = "llvm.getelementptr"(%59, %arg1) <{elem_type = f64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %61 = "llvm.ptrtoint"(%60) : (!llvm.ptr) -> i64
    %62 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %63 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
    %64 = "llvm.call"(%61, %43, %63) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuMemAlloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (i64, !llvm.ptr, i8) -> !llvm.ptr
    %65 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %66 = "llvm.insertvalue"(%65, %64) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %67 = "llvm.insertvalue"(%66, %64) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %68 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %69 = "llvm.insertvalue"(%67, %68) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %70 = "llvm.insertvalue"(%69, %arg1) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %71 = "llvm.insertvalue"(%70, %58) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %72 = "llvm.extractvalue"(%57) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %73 = "llvm.extractvalue"(%57) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %74 = "llvm.extractvalue"(%71) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %75 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
    %76 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
    %77 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %78 = "llvm.call"(%arg1, %arg1, %arg1, %72, %73, %74, %75, %76, %77, %43) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuCreateCsr, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 10, 0>}> : (i64, i64, i64, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, !llvm.ptr) -> !llvm.ptr
    %79 = "llvm.extractvalue"(%71) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %80 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %81 = "llvm.call"(%arg1, %arg1, %79, %80, %43) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuCreateDnMat, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 5, 0>}> : (i64, i64, !llvm.ptr, i32, !llvm.ptr) -> !llvm.ptr
    %82 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %83 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %84 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %85 = "llvm.call"(%82, %83, %81, %81, %78, %84, %43) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuSDDMMBufferSize, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 7, 0>}> : (i32, i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, !llvm.ptr) -> i64
    %86 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %87 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %88 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %89 = "llvm.extractvalue"(%71) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    "llvm.call"(%87, %88, %81, %81, %78, %86, %89, %43) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuSDDMM, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 8, 0>}> : (i32, i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, !llvm.ptr, !llvm.ptr) -> ()
    "llvm.call"(%78, %43) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuDestroySpMat, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> ()
    "llvm.call"(%81, %43) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuDestroyDnMat, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> ()
    "llvm.call"(%43) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuStreamSynchronize, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "llvm.call"(%43) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuStreamDestroy, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "csc_and_bsr", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64):
    %0 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuStreamCreate, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.ptr
    %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %3 = "llvm.getelementptr"(%2, %arg0) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
    %5 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %6 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
    %7 = "llvm.call"(%4, %0, %6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuMemAlloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (i64, !llvm.ptr, i8) -> !llvm.ptr
    %8 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %9 = "llvm.insertvalue"(%8, %7) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %10 = "llvm.insertvalue"(%9, %7) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %11 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %12 = "llvm.insertvalue"(%10, %11) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %13 = "llvm.insertvalue"(%12, %arg0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %14 = "llvm.insertvalue"(%13, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %15 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %16 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %17 = "llvm.getelementptr"(%16, %arg0) <{elem_type = f64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %18 = "llvm.ptrtoint"(%17) : (!llvm.ptr) -> i64
    %19 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %20 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
    %21 = "llvm.call"(%18, %0, %20) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuMemAlloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (i64, !llvm.ptr, i8) -> !llvm.ptr
    %22 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %23 = "llvm.insertvalue"(%22, %21) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %24 = "llvm.insertvalue"(%23, %21) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %25 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %26 = "llvm.insertvalue"(%24, %25) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %27 = "llvm.insertvalue"(%26, %arg0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %28 = "llvm.insertvalue"(%27, %15) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %29 = "llvm.extractvalue"(%14) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %30 = "llvm.extractvalue"(%14) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %31 = "llvm.extractvalue"(%28) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %32 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
    %33 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
    %34 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %35 = "llvm.call"(%arg0, %arg0, %arg0, %29, %30, %31, %32, %33, %34, %0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuCreateCsc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 10, 0>}> : (i64, i64, i64, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, !llvm.ptr) -> !llvm.ptr
    %36 = "llvm.extractvalue"(%14) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %37 = "llvm.extractvalue"(%14) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %38 = "llvm.extractvalue"(%28) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %39 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
    %40 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
    %41 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %42 = "llvm.call"(%arg0, %arg0, %arg0, %arg0, %arg0, %36, %37, %38, %39, %40, %41, %0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuCreateBsr, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 12, 0>}> : (i64, i64, i64, i64, i64, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, !llvm.ptr) -> !llvm.ptr
    "llvm.call"(%35, %0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuDestroySpMat, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> ()
    "llvm.call"(%42, %0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuDestroySpMat, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> ()
    "llvm.call"(%0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuStreamSynchronize, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "llvm.call"(%0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuStreamDestroy, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr ()>, linkage = #llvm.linkage<external>, sym_name = "mgpuStreamCreate", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64, ptr, i8)>, linkage = #llvm.linkage<external>, sym_name = "mgpuMemAlloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64, i64, i64, ptr, ptr, ptr, i32, i32, ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuCreateCoo", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64, ptr, i32, ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuCreateDnVec", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i32, ptr, ptr, ptr, i32, ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuSpMVBufferSize", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, ptr, ptr, ptr, i32, ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuSpMV", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuDestroySpMat", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuDestroyDnVec", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuStreamSynchronize", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuStreamDestroy", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64, i64, i64, ptr, ptr, ptr, i32, i32, i32, ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuCreateCsr", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64, i64, ptr, i32, ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuCreateDnMat", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i32, i32, ptr, ptr, ptr, i32, ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuSpMMBufferSize", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i32, ptr, ptr, ptr, i32, ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuSpMM", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuDestroyDnMat", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuSpGEMMCreateDescr", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (ptr, i32, i32, ptr, ptr, ptr, i32, i64, ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuSpGEMMWorkEstimation", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (ptr, i32, i32, ptr, ptr, ptr, i32, i64, ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuSpGEMMCompute", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, ptr, ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuSpMatGetSize", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, ptr, ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuSetCsrPointers", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, i32, i32, ptr, ptr, ptr, i32, ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuSpGEMMCopy", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuSpGEMMDestroyDescr", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i32, i32, ptr, ptr, ptr, i32, ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuSDDMMBufferSize", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i32, ptr, ptr, ptr, i32, ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuSDDMM", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64, i64, i64, ptr, ptr, ptr, i32, i32, i32, ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuCreateCsc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64, i64, i64, i64, i64, ptr, ptr, ptr, i32, i32, i32, ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuCreateBsr", visibility_ = 0 : i64}> ({
  }) : () -> ()
}) {gpu.container_module} : () -> ()

