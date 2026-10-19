#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, index) -> vector<17xf32>, sym_name = "transfer_read_write_1d"}> ({
  ^bb0(%arg27: memref<?xf32>, %arg28: index):
    %265 = "builtin.unrealized_conversion_cast"(%arg28) : (index) -> i64
    %266 = "builtin.unrealized_conversion_cast"(%arg27) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %267 = "arith.constant"() <{value = dense<7.000000e+00> : vector<17xf32>}> : () -> vector<17xf32>
    %268 = "arith.constant"() <{value = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : vector<17xi64>}> : () -> vector<17xi64>
    %269 = "arith.constant"() <{value = 0 : index}> : () -> index
    %270 = "memref.dim"(%arg27, %269) : (memref<?xf32>, index) -> index
    %271 = "arith.subi"(%270, %arg28) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %272 = "arith.index_cast"(%271) : (index) -> i64
    %273 = "llvm.mlir.poison"() : () -> vector<17xi64>
    %274 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %275 = "llvm.insertelement"(%273, %272, %274) : (vector<17xi64>, i64, i32) -> vector<17xi64>
    %276 = "llvm.shufflevector"(%275, %273) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<17xi64>, vector<17xi64>) -> vector<17xi64>
    %277 = "arith.cmpi"(%276, %268) <{predicate = 4 : i64}> : (vector<17xi64>, vector<17xi64>) -> vector<17xi1>
    %278 = "llvm.extractvalue"(%266) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %279 = "llvm.getelementptr"(%278, %265) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %280 = "llvm.intr.masked.load"(%279, %277, %267) <{alignment = 4 : i32}> : (!llvm.ptr, vector<17xi1>, vector<17xf32>) -> vector<17xf32>
    %281 = "memref.dim"(%arg27, %269) : (memref<?xf32>, index) -> index
    %282 = "arith.subi"(%281, %arg28) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %283 = "arith.index_cast"(%282) : (index) -> i64
    %284 = "llvm.mlir.poison"() : () -> vector<17xi64>
    %285 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %286 = "llvm.insertelement"(%284, %283, %285) : (vector<17xi64>, i64, i32) -> vector<17xi64>
    %287 = "llvm.shufflevector"(%286, %284) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<17xi64>, vector<17xi64>) -> vector<17xi64>
    %288 = "arith.cmpi"(%287, %268) <{predicate = 4 : i64}> : (vector<17xi64>, vector<17xi64>) -> vector<17xi1>
    %289 = "llvm.extractvalue"(%266) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %290 = "llvm.getelementptr"(%289, %265) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.masked.store"(%280, %290, %288) <{alignment = 4 : i32}> : (vector<17xf32>, !llvm.ptr, vector<17xi1>) -> ()
    "func.return"(%280) : (vector<17xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index) -> vector<[17]xf32>, sym_name = "transfer_read_write_1d_scalable"}> ({
  ^bb0(%arg25: memref<?xf32>, %arg26: index):
    %238 = "builtin.unrealized_conversion_cast"(%arg26) : (index) -> i64
    %239 = "builtin.unrealized_conversion_cast"(%arg25) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %240 = "arith.constant"() <{value = dense<7.000000e+00> : vector<[17]xf32>}> : () -> vector<[17]xf32>
    %241 = "arith.constant"() <{value = 0 : index}> : () -> index
    %242 = "memref.dim"(%arg25, %241) : (memref<?xf32>, index) -> index
    %243 = "arith.subi"(%242, %arg26) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %244 = "llvm.intr.stepvector"() : () -> vector<[17]xi64>
    %245 = "arith.index_cast"(%243) : (index) -> i64
    %246 = "llvm.mlir.poison"() : () -> vector<[17]xi64>
    %247 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %248 = "llvm.insertelement"(%246, %245, %247) : (vector<[17]xi64>, i64, i32) -> vector<[17]xi64>
    %249 = "llvm.shufflevector"(%248, %246) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[17]xi64>, vector<[17]xi64>) -> vector<[17]xi64>
    %250 = "arith.cmpi"(%244, %249) <{predicate = 2 : i64}> : (vector<[17]xi64>, vector<[17]xi64>) -> vector<[17]xi1>
    %251 = "llvm.extractvalue"(%239) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %252 = "llvm.getelementptr"(%251, %238) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %253 = "llvm.intr.masked.load"(%252, %250, %240) <{alignment = 4 : i32}> : (!llvm.ptr, vector<[17]xi1>, vector<[17]xf32>) -> vector<[17]xf32>
    %254 = "memref.dim"(%arg25, %241) : (memref<?xf32>, index) -> index
    %255 = "arith.subi"(%254, %arg26) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %256 = "llvm.intr.stepvector"() : () -> vector<[17]xi64>
    %257 = "arith.index_cast"(%255) : (index) -> i64
    %258 = "llvm.mlir.poison"() : () -> vector<[17]xi64>
    %259 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %260 = "llvm.insertelement"(%258, %257, %259) : (vector<[17]xi64>, i64, i32) -> vector<[17]xi64>
    %261 = "llvm.shufflevector"(%260, %258) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[17]xi64>, vector<[17]xi64>) -> vector<[17]xi64>
    %262 = "arith.cmpi"(%256, %261) <{predicate = 2 : i64}> : (vector<[17]xi64>, vector<[17]xi64>) -> vector<[17]xi1>
    %263 = "llvm.extractvalue"(%239) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %264 = "llvm.getelementptr"(%263, %238) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.masked.store"(%253, %264, %262) <{alignment = 4 : i32}> : (vector<[17]xf32>, !llvm.ptr, vector<[17]xi1>) -> ()
    "func.return"(%253) : (vector<[17]xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xindex>, index) -> vector<17xindex>, sym_name = "transfer_read_write_index_1d"}> ({
  ^bb0(%arg23: memref<?xindex>, %arg24: index):
    %210 = "builtin.unrealized_conversion_cast"(%arg24) : (index) -> i64
    %211 = "builtin.unrealized_conversion_cast"(%arg23) : (memref<?xindex>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %212 = "arith.constant"() <{value = dense<7> : vector<17xindex>}> : () -> vector<17xindex>
    %213 = "builtin.unrealized_conversion_cast"(%212) : (vector<17xindex>) -> vector<17xi64>
    %214 = "arith.constant"() <{value = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : vector<17xi64>}> : () -> vector<17xi64>
    %215 = "arith.constant"() <{value = 0 : index}> : () -> index
    %216 = "memref.dim"(%arg23, %215) : (memref<?xindex>, index) -> index
    %217 = "arith.subi"(%216, %arg24) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %218 = "arith.index_cast"(%217) : (index) -> i64
    %219 = "llvm.mlir.poison"() : () -> vector<17xi64>
    %220 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %221 = "llvm.insertelement"(%219, %218, %220) : (vector<17xi64>, i64, i32) -> vector<17xi64>
    %222 = "llvm.shufflevector"(%221, %219) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<17xi64>, vector<17xi64>) -> vector<17xi64>
    %223 = "arith.cmpi"(%222, %214) <{predicate = 4 : i64}> : (vector<17xi64>, vector<17xi64>) -> vector<17xi1>
    %224 = "llvm.extractvalue"(%211) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %225 = "llvm.getelementptr"(%224, %210) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %226 = "llvm.intr.masked.load"(%225, %223, %213) <{alignment = 8 : i32}> : (!llvm.ptr, vector<17xi1>, vector<17xi64>) -> vector<17xi64>
    %227 = "builtin.unrealized_conversion_cast"(%226) : (vector<17xi64>) -> vector<17xindex>
    %228 = "memref.dim"(%arg23, %215) : (memref<?xindex>, index) -> index
    %229 = "arith.subi"(%228, %arg24) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %230 = "arith.index_cast"(%229) : (index) -> i64
    %231 = "llvm.mlir.poison"() : () -> vector<17xi64>
    %232 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %233 = "llvm.insertelement"(%231, %230, %232) : (vector<17xi64>, i64, i32) -> vector<17xi64>
    %234 = "llvm.shufflevector"(%233, %231) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<17xi64>, vector<17xi64>) -> vector<17xi64>
    %235 = "arith.cmpi"(%234, %214) <{predicate = 4 : i64}> : (vector<17xi64>, vector<17xi64>) -> vector<17xi1>
    %236 = "llvm.extractvalue"(%211) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %237 = "llvm.getelementptr"(%236, %210) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.masked.store"(%226, %237, %235) <{alignment = 8 : i32}> : (vector<17xi64>, !llvm.ptr, vector<17xi1>) -> ()
    "func.return"(%227) : (vector<17xindex>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xindex>, index) -> vector<[17]xindex>, sym_name = "transfer_read_write_index_1d_scalable"}> ({
  ^bb0(%arg21: memref<?xindex>, %arg22: index):
    %181 = "builtin.unrealized_conversion_cast"(%arg22) : (index) -> i64
    %182 = "builtin.unrealized_conversion_cast"(%arg21) : (memref<?xindex>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %183 = "arith.constant"() <{value = dense<7> : vector<[17]xindex>}> : () -> vector<[17]xindex>
    %184 = "builtin.unrealized_conversion_cast"(%183) : (vector<[17]xindex>) -> vector<[17]xi64>
    %185 = "arith.constant"() <{value = 0 : index}> : () -> index
    %186 = "memref.dim"(%arg21, %185) : (memref<?xindex>, index) -> index
    %187 = "arith.subi"(%186, %arg22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %188 = "llvm.intr.stepvector"() : () -> vector<[17]xi64>
    %189 = "arith.index_cast"(%187) : (index) -> i64
    %190 = "llvm.mlir.poison"() : () -> vector<[17]xi64>
    %191 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %192 = "llvm.insertelement"(%190, %189, %191) : (vector<[17]xi64>, i64, i32) -> vector<[17]xi64>
    %193 = "llvm.shufflevector"(%192, %190) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[17]xi64>, vector<[17]xi64>) -> vector<[17]xi64>
    %194 = "arith.cmpi"(%188, %193) <{predicate = 2 : i64}> : (vector<[17]xi64>, vector<[17]xi64>) -> vector<[17]xi1>
    %195 = "llvm.extractvalue"(%182) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %196 = "llvm.getelementptr"(%195, %181) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %197 = "llvm.intr.masked.load"(%196, %194, %184) <{alignment = 8 : i32}> : (!llvm.ptr, vector<[17]xi1>, vector<[17]xi64>) -> vector<[17]xi64>
    %198 = "builtin.unrealized_conversion_cast"(%197) : (vector<[17]xi64>) -> vector<[17]xindex>
    %199 = "memref.dim"(%arg21, %185) : (memref<?xindex>, index) -> index
    %200 = "arith.subi"(%199, %arg22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %201 = "llvm.intr.stepvector"() : () -> vector<[17]xi64>
    %202 = "arith.index_cast"(%200) : (index) -> i64
    %203 = "llvm.mlir.poison"() : () -> vector<[17]xi64>
    %204 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %205 = "llvm.insertelement"(%203, %202, %204) : (vector<[17]xi64>, i64, i32) -> vector<[17]xi64>
    %206 = "llvm.shufflevector"(%205, %203) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[17]xi64>, vector<[17]xi64>) -> vector<[17]xi64>
    %207 = "arith.cmpi"(%201, %206) <{predicate = 2 : i64}> : (vector<[17]xi64>, vector<[17]xi64>) -> vector<[17]xi1>
    %208 = "llvm.extractvalue"(%182) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %209 = "llvm.getelementptr"(%208, %181) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.masked.store"(%197, %209, %207) <{alignment = 8 : i32}> : (vector<[17]xi64>, !llvm.ptr, vector<[17]xi1>) -> ()
    "func.return"(%198) : (vector<[17]xindex>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf32>, index, index) -> vector<17xf32>, sym_name = "transfer_read_2d_to_1d"}> ({
  ^bb0(%arg18: memref<?x?xf32>, %arg19: index, %arg20: index):
    %161 = "builtin.unrealized_conversion_cast"(%arg20) : (index) -> i64
    %162 = "builtin.unrealized_conversion_cast"(%arg19) : (index) -> i64
    %163 = "builtin.unrealized_conversion_cast"(%arg18) : (memref<?x?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %164 = "arith.constant"() <{value = dense<7.000000e+00> : vector<17xf32>}> : () -> vector<17xf32>
    %165 = "arith.constant"() <{value = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : vector<17xi64>}> : () -> vector<17xi64>
    %166 = "arith.constant"() <{value = 1 : index}> : () -> index
    %167 = "memref.dim"(%arg18, %166) : (memref<?x?xf32>, index) -> index
    %168 = "arith.subi"(%167, %arg20) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %169 = "arith.index_cast"(%168) : (index) -> i64
    %170 = "llvm.mlir.poison"() : () -> vector<17xi64>
    %171 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %172 = "llvm.insertelement"(%170, %169, %171) : (vector<17xi64>, i64, i32) -> vector<17xi64>
    %173 = "llvm.shufflevector"(%172, %170) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<17xi64>, vector<17xi64>) -> vector<17xi64>
    %174 = "arith.cmpi"(%173, %165) <{predicate = 4 : i64}> : (vector<17xi64>, vector<17xi64>) -> vector<17xi1>
    %175 = "llvm.extractvalue"(%163) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %176 = "llvm.extractvalue"(%163) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %177 = "llvm.mul"(%162, %176) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %178 = "llvm.add"(%177, %161) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %179 = "llvm.getelementptr"(%175, %178) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %180 = "llvm.intr.masked.load"(%179, %174, %164) <{alignment = 4 : i32}> : (!llvm.ptr, vector<17xi1>, vector<17xf32>) -> vector<17xf32>
    "func.return"(%180) : (vector<17xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf32>, index, index) -> vector<[17]xf32>, sym_name = "transfer_read_2d_to_1d_scalable"}> ({
  ^bb0(%arg15: memref<?x?xf32>, %arg16: index, %arg17: index):
    %141 = "builtin.unrealized_conversion_cast"(%arg17) : (index) -> i64
    %142 = "builtin.unrealized_conversion_cast"(%arg16) : (index) -> i64
    %143 = "builtin.unrealized_conversion_cast"(%arg15) : (memref<?x?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %144 = "arith.constant"() <{value = dense<7.000000e+00> : vector<[17]xf32>}> : () -> vector<[17]xf32>
    %145 = "arith.constant"() <{value = 1 : index}> : () -> index
    %146 = "memref.dim"(%arg15, %145) : (memref<?x?xf32>, index) -> index
    %147 = "arith.subi"(%146, %arg17) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %148 = "llvm.intr.stepvector"() : () -> vector<[17]xi64>
    %149 = "arith.index_cast"(%147) : (index) -> i64
    %150 = "llvm.mlir.poison"() : () -> vector<[17]xi64>
    %151 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %152 = "llvm.insertelement"(%150, %149, %151) : (vector<[17]xi64>, i64, i32) -> vector<[17]xi64>
    %153 = "llvm.shufflevector"(%152, %150) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[17]xi64>, vector<[17]xi64>) -> vector<[17]xi64>
    %154 = "arith.cmpi"(%148, %153) <{predicate = 2 : i64}> : (vector<[17]xi64>, vector<[17]xi64>) -> vector<[17]xi1>
    %155 = "llvm.extractvalue"(%143) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %156 = "llvm.extractvalue"(%143) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %157 = "llvm.mul"(%142, %156) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %158 = "llvm.add"(%157, %141) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %159 = "llvm.getelementptr"(%155, %158) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %160 = "llvm.intr.masked.load"(%159, %154, %144) <{alignment = 4 : i32}> : (!llvm.ptr, vector<[17]xi1>, vector<[17]xf32>) -> vector<[17]xf32>
    "func.return"(%160) : (vector<[17]xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, 3>, index) -> vector<17xf32>, sym_name = "transfer_read_write_1d_non_zero_addrspace"}> ({
  ^bb0(%arg13: memref<?xf32, 3>, %arg14: index):
    %115 = "builtin.unrealized_conversion_cast"(%arg14) : (index) -> i64
    %116 = "builtin.unrealized_conversion_cast"(%arg13) : (memref<?xf32, 3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
    %117 = "arith.constant"() <{value = dense<7.000000e+00> : vector<17xf32>}> : () -> vector<17xf32>
    %118 = "arith.constant"() <{value = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : vector<17xi64>}> : () -> vector<17xi64>
    %119 = "arith.constant"() <{value = 0 : index}> : () -> index
    %120 = "memref.dim"(%arg13, %119) : (memref<?xf32, 3>, index) -> index
    %121 = "arith.subi"(%120, %arg14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %122 = "arith.index_cast"(%121) : (index) -> i64
    %123 = "llvm.mlir.poison"() : () -> vector<17xi64>
    %124 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %125 = "llvm.insertelement"(%123, %122, %124) : (vector<17xi64>, i64, i32) -> vector<17xi64>
    %126 = "llvm.shufflevector"(%125, %123) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<17xi64>, vector<17xi64>) -> vector<17xi64>
    %127 = "arith.cmpi"(%126, %118) <{predicate = 4 : i64}> : (vector<17xi64>, vector<17xi64>) -> vector<17xi1>
    %128 = "llvm.extractvalue"(%116) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
    %129 = "llvm.getelementptr"(%128, %115) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
    %130 = "llvm.intr.masked.load"(%129, %127, %117) <{alignment = 4 : i32}> : (!llvm.ptr<3>, vector<17xi1>, vector<17xf32>) -> vector<17xf32>
    %131 = "memref.dim"(%arg13, %119) : (memref<?xf32, 3>, index) -> index
    %132 = "arith.subi"(%131, %arg14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %133 = "arith.index_cast"(%132) : (index) -> i64
    %134 = "llvm.mlir.poison"() : () -> vector<17xi64>
    %135 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %136 = "llvm.insertelement"(%134, %133, %135) : (vector<17xi64>, i64, i32) -> vector<17xi64>
    %137 = "llvm.shufflevector"(%136, %134) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<17xi64>, vector<17xi64>) -> vector<17xi64>
    %138 = "arith.cmpi"(%137, %118) <{predicate = 4 : i64}> : (vector<17xi64>, vector<17xi64>) -> vector<17xi1>
    %139 = "llvm.extractvalue"(%116) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
    %140 = "llvm.getelementptr"(%139, %115) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
    "llvm.intr.masked.store"(%130, %140, %138) <{alignment = 4 : i32}> : (vector<17xf32>, !llvm.ptr<3>, vector<17xi1>) -> ()
    "func.return"(%130) : (vector<17xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, 3>, index) -> vector<[17]xf32>, sym_name = "transfer_read_write_1d_non_zero_addrspace_scalable"}> ({
  ^bb0(%arg11: memref<?xf32, 3>, %arg12: index):
    %88 = "builtin.unrealized_conversion_cast"(%arg12) : (index) -> i64
    %89 = "builtin.unrealized_conversion_cast"(%arg11) : (memref<?xf32, 3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
    %90 = "arith.constant"() <{value = dense<7.000000e+00> : vector<[17]xf32>}> : () -> vector<[17]xf32>
    %91 = "arith.constant"() <{value = 0 : index}> : () -> index
    %92 = "memref.dim"(%arg11, %91) : (memref<?xf32, 3>, index) -> index
    %93 = "arith.subi"(%92, %arg12) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %94 = "llvm.intr.stepvector"() : () -> vector<[17]xi64>
    %95 = "arith.index_cast"(%93) : (index) -> i64
    %96 = "llvm.mlir.poison"() : () -> vector<[17]xi64>
    %97 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %98 = "llvm.insertelement"(%96, %95, %97) : (vector<[17]xi64>, i64, i32) -> vector<[17]xi64>
    %99 = "llvm.shufflevector"(%98, %96) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[17]xi64>, vector<[17]xi64>) -> vector<[17]xi64>
    %100 = "arith.cmpi"(%94, %99) <{predicate = 2 : i64}> : (vector<[17]xi64>, vector<[17]xi64>) -> vector<[17]xi1>
    %101 = "llvm.extractvalue"(%89) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
    %102 = "llvm.getelementptr"(%101, %88) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
    %103 = "llvm.intr.masked.load"(%102, %100, %90) <{alignment = 4 : i32}> : (!llvm.ptr<3>, vector<[17]xi1>, vector<[17]xf32>) -> vector<[17]xf32>
    %104 = "memref.dim"(%arg11, %91) : (memref<?xf32, 3>, index) -> index
    %105 = "arith.subi"(%104, %arg12) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %106 = "llvm.intr.stepvector"() : () -> vector<[17]xi64>
    %107 = "arith.index_cast"(%105) : (index) -> i64
    %108 = "llvm.mlir.poison"() : () -> vector<[17]xi64>
    %109 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %110 = "llvm.insertelement"(%108, %107, %109) : (vector<[17]xi64>, i64, i32) -> vector<[17]xi64>
    %111 = "llvm.shufflevector"(%110, %108) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[17]xi64>, vector<[17]xi64>) -> vector<[17]xi64>
    %112 = "arith.cmpi"(%106, %111) <{predicate = 2 : i64}> : (vector<[17]xi64>, vector<[17]xi64>) -> vector<[17]xi1>
    %113 = "llvm.extractvalue"(%89) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<3>
    %114 = "llvm.getelementptr"(%113, %88) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>
    "llvm.intr.masked.store"(%103, %114, %112) <{alignment = 4 : i32}> : (vector<[17]xf32>, !llvm.ptr<3>, vector<[17]xi1>) -> ()
    "func.return"(%103) : (vector<[17]xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index) -> vector<17xf32>, sym_name = "transfer_read_1d_inbounds"}> ({
  ^bb0(%arg9: memref<?xf32>, %arg10: index):
    %83 = "builtin.unrealized_conversion_cast"(%arg10) : (index) -> i64
    %84 = "builtin.unrealized_conversion_cast"(%arg9) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %85 = "llvm.extractvalue"(%84) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %86 = "llvm.getelementptr"(%85, %83) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %87 = "llvm.load"(%86) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> vector<17xf32>
    "func.return"(%87) : (vector<17xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index) -> vector<[17]xf32>, sym_name = "transfer_read_1d_inbounds_scalable"}> ({
  ^bb0(%arg7: memref<?xf32>, %arg8: index):
    %78 = "builtin.unrealized_conversion_cast"(%arg8) : (index) -> i64
    %79 = "builtin.unrealized_conversion_cast"(%arg7) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %80 = "llvm.extractvalue"(%79) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %81 = "llvm.getelementptr"(%80, %78) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %82 = "llvm.load"(%81) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> vector<[17]xf32>
    "func.return"(%82) : (vector<[17]xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index) -> vector<5xf32>, sym_name = "transfer_read_write_1d_mask"}> ({
  ^bb0(%arg5: memref<?xf32>, %arg6: index):
    %49 = "builtin.unrealized_conversion_cast"(%arg6) : (index) -> i64
    %50 = "builtin.unrealized_conversion_cast"(%arg5) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %51 = "arith.constant"() <{value = dense<7.000000e+00> : vector<5xf32>}> : () -> vector<5xf32>
    %52 = "arith.constant"() <{value = dense<[0, 1, 2, 3, 4]> : vector<5xi64>}> : () -> vector<5xi64>
    %53 = "arith.constant"() <{value = dense<[false, false, true, false, true]> : vector<5xi1>}> : () -> vector<5xi1>
    %54 = "arith.constant"() <{value = 0 : index}> : () -> index
    %55 = "memref.dim"(%arg5, %54) : (memref<?xf32>, index) -> index
    %56 = "arith.subi"(%55, %arg6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %57 = "arith.index_cast"(%56) : (index) -> i64
    %58 = "llvm.mlir.poison"() : () -> vector<5xi64>
    %59 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %60 = "llvm.insertelement"(%58, %57, %59) : (vector<5xi64>, i64, i32) -> vector<5xi64>
    %61 = "llvm.shufflevector"(%60, %58) <{mask = array<i32: 0, 0, 0, 0, 0>}> : (vector<5xi64>, vector<5xi64>) -> vector<5xi64>
    %62 = "arith.cmpi"(%61, %52) <{predicate = 4 : i64}> : (vector<5xi64>, vector<5xi64>) -> vector<5xi1>
    %63 = "arith.andi"(%62, %53) : (vector<5xi1>, vector<5xi1>) -> vector<5xi1>
    %64 = "llvm.extractvalue"(%50) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %65 = "llvm.getelementptr"(%64, %49) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %66 = "llvm.intr.masked.load"(%65, %63, %51) <{alignment = 4 : i32}> : (!llvm.ptr, vector<5xi1>, vector<5xf32>) -> vector<5xf32>
    %67 = "memref.dim"(%arg5, %54) : (memref<?xf32>, index) -> index
    %68 = "arith.subi"(%67, %arg6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %69 = "arith.index_cast"(%68) : (index) -> i64
    %70 = "llvm.mlir.poison"() : () -> vector<5xi64>
    %71 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %72 = "llvm.insertelement"(%70, %69, %71) : (vector<5xi64>, i64, i32) -> vector<5xi64>
    %73 = "llvm.shufflevector"(%72, %70) <{mask = array<i32: 0, 0, 0, 0, 0>}> : (vector<5xi64>, vector<5xi64>) -> vector<5xi64>
    %74 = "arith.cmpi"(%73, %52) <{predicate = 4 : i64}> : (vector<5xi64>, vector<5xi64>) -> vector<5xi1>
    %75 = "arith.andi"(%74, %53) : (vector<5xi1>, vector<5xi1>) -> vector<5xi1>
    %76 = "llvm.extractvalue"(%50) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %77 = "llvm.getelementptr"(%76, %49) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.masked.store"(%66, %77, %75) <{alignment = 4 : i32}> : (vector<5xf32>, !llvm.ptr, vector<5xi1>) -> ()
    "func.return"(%66) : (vector<5xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, index, vector<[5]xi1>) -> vector<[5]xf32>, sym_name = "transfer_read_write_1d_mask_scalable"}> ({
  ^bb0(%arg2: memref<?xf32>, %arg3: index, %arg4: vector<[5]xi1>):
    %20 = "builtin.unrealized_conversion_cast"(%arg3) : (index) -> i64
    %21 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %22 = "arith.constant"() <{value = dense<7.000000e+00> : vector<[5]xf32>}> : () -> vector<[5]xf32>
    %23 = "arith.constant"() <{value = 0 : index}> : () -> index
    %24 = "memref.dim"(%arg2, %23) : (memref<?xf32>, index) -> index
    %25 = "arith.subi"(%24, %arg3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %26 = "llvm.intr.stepvector"() : () -> vector<[5]xi64>
    %27 = "arith.index_cast"(%25) : (index) -> i64
    %28 = "llvm.mlir.poison"() : () -> vector<[5]xi64>
    %29 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %30 = "llvm.insertelement"(%28, %27, %29) : (vector<[5]xi64>, i64, i32) -> vector<[5]xi64>
    %31 = "llvm.shufflevector"(%30, %28) <{mask = array<i32: 0, 0, 0, 0, 0>}> : (vector<[5]xi64>, vector<[5]xi64>) -> vector<[5]xi64>
    %32 = "arith.cmpi"(%26, %31) <{predicate = 2 : i64}> : (vector<[5]xi64>, vector<[5]xi64>) -> vector<[5]xi1>
    %33 = "arith.andi"(%32, %arg4) : (vector<[5]xi1>, vector<[5]xi1>) -> vector<[5]xi1>
    %34 = "llvm.extractvalue"(%21) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %35 = "llvm.getelementptr"(%34, %20) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %36 = "llvm.intr.masked.load"(%35, %33, %22) <{alignment = 4 : i32}> : (!llvm.ptr, vector<[5]xi1>, vector<[5]xf32>) -> vector<[5]xf32>
    %37 = "memref.dim"(%arg2, %23) : (memref<?xf32>, index) -> index
    %38 = "arith.subi"(%37, %arg3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %39 = "llvm.intr.stepvector"() : () -> vector<[5]xi64>
    %40 = "arith.index_cast"(%38) : (index) -> i64
    %41 = "llvm.mlir.poison"() : () -> vector<[5]xi64>
    %42 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %43 = "llvm.insertelement"(%41, %40, %42) : (vector<[5]xi64>, i64, i32) -> vector<[5]xi64>
    %44 = "llvm.shufflevector"(%43, %41) <{mask = array<i32: 0, 0, 0, 0, 0>}> : (vector<[5]xi64>, vector<[5]xi64>) -> vector<[5]xi64>
    %45 = "arith.cmpi"(%39, %44) <{predicate = 2 : i64}> : (vector<[5]xi64>, vector<[5]xi64>) -> vector<[5]xi1>
    %46 = "arith.andi"(%45, %arg4) : (vector<[5]xi1>, vector<[5]xi1>) -> vector<[5]xi1>
    %47 = "llvm.extractvalue"(%21) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %48 = "llvm.getelementptr"(%47, %20) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.masked.store"(%36, %48, %46) <{alignment = 4 : i32}> : (vector<[5]xf32>, !llvm.ptr, vector<[5]xi1>) -> ()
    "func.return"(%36) : (vector<[5]xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?xf32>, index) -> vector<4xf32>, sym_name = "transfer_read_write_tensor"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = dense<[0, 1, 2, 3]> : vector<4xi64>}> : () -> vector<4xi64>
    %1 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "tensor.dim"(%arg0, %2) : (tensor<?xf32>, index) -> index
    %4 = "arith.subi"(%3, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %5 = "arith.index_cast"(%4) : (index) -> i64
    %6 = "llvm.mlir.poison"() : () -> vector<4xi64>
    %7 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %8 = "llvm.insertelement"(%6, %5, %7) : (vector<4xi64>, i64, i32) -> vector<4xi64>
    %9 = "llvm.shufflevector"(%8, %6) <{mask = array<i32: 0, 0, 0, 0>}> : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %10 = "arith.cmpi"(%9, %0) <{predicate = 4 : i64}> : (vector<4xi64>, vector<4xi64>) -> vector<4xi1>
    %11 = "vector.transfer_read"(%arg0, %arg1, %1, %10) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 1>, permutation_map = #map}> : (tensor<?xf32>, index, f32, vector<4xi1>) -> vector<4xf32>
    %12 = "tensor.dim"(%arg0, %2) : (tensor<?xf32>, index) -> index
    %13 = "arith.index_cast"(%12) : (index) -> i64
    %14 = "llvm.mlir.poison"() : () -> vector<4xi64>
    %15 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %16 = "llvm.insertelement"(%14, %13, %15) : (vector<4xi64>, i64, i32) -> vector<4xi64>
    %17 = "llvm.shufflevector"(%16, %14) <{mask = array<i32: 0, 0, 0, 0>}> : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %18 = "arith.cmpi"(%17, %0) <{predicate = 4 : i64}> : (vector<4xi64>, vector<4xi64>) -> vector<4xi1>
    %19 = "vector.transfer_write"(%11, %arg0, %2, %18) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 1>, permutation_map = #map}> : (vector<4xf32>, tensor<?xf32>, index, vector<4xi1>) -> tensor<?xf32>
    "test.some_use"(%19) : (tensor<?xf32>) -> ()
    "func.return"(%11) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

