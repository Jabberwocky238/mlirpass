"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "empty"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "body", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "simple_loop"}> ({
    %354 = "arith.constant"() <{value = 1 : index}> : () -> index
    %355 = "arith.constant"() <{value = 42 : index}> : () -> index
    %356 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%354, %355, %356) ({
    ^bb0(%arg103: index):
      "func.call"(%arg103) <{callee = @body}> : (index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1024xf32>) -> f32, sym_name = "for_with_yield"}> ({
  ^bb0(%arg100: memref<1024xf32>):
    %347 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %348 = "arith.constant"() <{value = 0 : index}> : () -> index
    %349 = "arith.constant"() <{value = 10 : index}> : () -> index
    %350 = "arith.constant"() <{value = 2 : index}> : () -> index
    %351 = "scf.for"(%348, %349, %350, %347) ({
    ^bb0(%arg101: index, %arg102: f32):
      %352 = "memref.load"(%arg100, %arg101) <{nontemporal = false}> : (memref<1024xf32>, index) -> f32
      %353 = "arith.addf"(%arg102, %352) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "scf.yield"(%353) : (f32) -> ()
    }) : (index, index, index, f32) -> f32
    "func.return"(%351) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "pre", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> (), sym_name = "body2", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "post", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "imperfectly_nested_loops"}> ({
    %341 = "arith.constant"() <{value = 0 : index}> : () -> index
    %342 = "arith.constant"() <{value = 42 : index}> : () -> index
    %343 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%341, %342, %343) ({
    ^bb0(%arg98: index):
      "func.call"(%arg98) <{callee = @pre}> : (index) -> ()
      %344 = "arith.constant"() <{value = 7 : index}> : () -> index
      %345 = "arith.constant"() <{value = 56 : index}> : () -> index
      %346 = "arith.constant"() <{value = 2 : index}> : () -> index
      "scf.for"(%344, %345, %346) ({
      ^bb0(%arg99: index):
        "func.call"(%arg98, %arg99) <{callee = @body2}> : (index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "func.call"(%arg98) <{callee = @post}> : (index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "mid", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> (), sym_name = "body3", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "more_imperfectly_nested_loops"}> ({
    %332 = "arith.constant"() <{value = 0 : index}> : () -> index
    %333 = "arith.constant"() <{value = 42 : index}> : () -> index
    %334 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%332, %333, %334) ({
    ^bb0(%arg95: index):
      "func.call"(%arg95) <{callee = @pre}> : (index) -> ()
      %335 = "arith.constant"() <{value = 7 : index}> : () -> index
      %336 = "arith.constant"() <{value = 56 : index}> : () -> index
      %337 = "arith.constant"() <{value = 2 : index}> : () -> index
      "scf.for"(%335, %336, %337) ({
      ^bb0(%arg97: index):
        "func.call"(%arg95, %arg97) <{callee = @body2}> : (index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "func.call"(%arg95) <{callee = @mid}> : (index) -> ()
      %338 = "arith.constant"() <{value = 18 : index}> : () -> index
      %339 = "arith.constant"() <{value = 37 : index}> : () -> index
      %340 = "arith.constant"() <{value = 3 : index}> : () -> index
      "scf.for"(%338, %339, %340) ({
      ^bb0(%arg96: index):
        "func.call"(%arg95, %arg96) <{callee = @body3}> : (index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "func.call"(%arg95) <{callee = @post}> : (index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "affine_apply_loops_shorthand"}> ({
  ^bb0(%arg92: index):
    %328 = "arith.constant"() <{value = 0 : index}> : () -> index
    %329 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%328, %arg92, %329) ({
    ^bb0(%arg93: index):
      %330 = "arith.constant"() <{value = 42 : index}> : () -> index
      %331 = "arith.constant"() <{value = 1 : index}> : () -> index
      "scf.for"(%arg93, %330, %331) ({
      ^bb0(%arg94: index):
        "func.call"(%arg93, %arg94) <{callee = @body2}> : (index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> index, sym_name = "get_idx", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "if_only"}> ({
    %321 = "func.call"() <{callee = @get_idx}> : () -> index
    %322 = "arith.constant"() <{value = 0 : index}> : () -> index
    %323 = "arith.constant"() <{value = -1 : index}> : () -> index
    %324 = "arith.muli"(%321, %323) <{overflowFlags = #arith.overflow<nsw>}> : (index, index) -> index
    %325 = "arith.constant"() <{value = 20 : index}> : () -> index
    %326 = "arith.addi"(%324, %325) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %327 = "arith.cmpi"(%326, %322) <{predicate = 5 : i64}> : (index, index) -> i1
    "scf.if"(%327) ({
      "func.call"(%321) <{callee = @body}> : (index) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "if_else"}> ({
    %314 = "func.call"() <{callee = @get_idx}> : () -> index
    %315 = "arith.constant"() <{value = 0 : index}> : () -> index
    %316 = "arith.constant"() <{value = -1 : index}> : () -> index
    %317 = "arith.muli"(%314, %316) <{overflowFlags = #arith.overflow<nsw>}> : (index, index) -> index
    %318 = "arith.constant"() <{value = 20 : index}> : () -> index
    %319 = "arith.addi"(%317, %318) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %320 = "arith.cmpi"(%319, %315) <{predicate = 5 : i64}> : (index, index) -> i1
    "scf.if"(%320) ({
      "func.call"(%314) <{callee = @body}> : (index) -> ()
      "scf.yield"() : () -> ()
    }, {
      "func.call"(%314) <{callee = @mid}> : (index) -> ()
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "nested_ifs"}> ({
    %299 = "func.call"() <{callee = @get_idx}> : () -> index
    %300 = "arith.constant"() <{value = 0 : index}> : () -> index
    %301 = "arith.constant"() <{value = -1 : index}> : () -> index
    %302 = "arith.muli"(%299, %301) <{overflowFlags = #arith.overflow<nsw>}> : (index, index) -> index
    %303 = "arith.constant"() <{value = 20 : index}> : () -> index
    %304 = "arith.addi"(%302, %303) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %305 = "arith.cmpi"(%304, %300) <{predicate = 5 : i64}> : (index, index) -> i1
    "scf.if"(%305) ({
      %310 = "arith.constant"() <{value = 0 : index}> : () -> index
      %311 = "arith.constant"() <{value = -10 : index}> : () -> index
      %312 = "arith.addi"(%299, %311) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %313 = "arith.cmpi"(%312, %310) <{predicate = 5 : i64}> : (index, index) -> i1
      "scf.if"(%313) ({
        "func.call"(%299) <{callee = @body}> : (index) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }, {
      %306 = "arith.constant"() <{value = 0 : index}> : () -> index
      %307 = "arith.constant"() <{value = -10 : index}> : () -> index
      %308 = "arith.addi"(%299, %307) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %309 = "arith.cmpi"(%308, %306) <{predicate = 5 : i64}> : (index, index) -> i1
      "scf.if"(%309) ({
        "func.call"(%299) <{callee = @mid}> : (index) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "if_with_yield"}> ({
    %291 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %292 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %293 = "func.call"() <{callee = @get_idx}> : () -> index
    %294 = "arith.constant"() <{value = 0 : index}> : () -> index
    %295 = "arith.constant"() <{value = -10 : index}> : () -> index
    %296 = "arith.addi"(%293, %295) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %297 = "arith.cmpi"(%296, %294) <{predicate = 5 : i64}> : (index, index) -> i1
    %298 = "scf.if"(%297) ({
      "scf.yield"(%291) : (i64) -> ()
    }, {
      "scf.yield"(%292) : (i64) -> ()
    }) : (i1) -> i64
    "func.return"(%298) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index, index) -> (), sym_name = "multi_cond"}> ({
  ^bb0(%arg88: index, %arg89: index, %arg90: index, %arg91: index):
    %267 = "func.call"() <{callee = @get_idx}> : () -> index
    %268 = "arith.constant"() <{value = 0 : index}> : () -> index
    %269 = "arith.constant"() <{value = -1 : index}> : () -> index
    %270 = "arith.muli"(%267, %269) <{overflowFlags = #arith.overflow<nsw>}> : (index, index) -> index
    %271 = "arith.addi"(%270, %arg88) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %272 = "arith.constant"() <{value = 1 : index}> : () -> index
    %273 = "arith.addi"(%271, %272) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %274 = "arith.cmpi"(%273, %268) <{predicate = 5 : i64}> : (index, index) -> i1
    %275 = "arith.constant"() <{value = -1 : index}> : () -> index
    %276 = "arith.addi"(%arg88, %275) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %277 = "arith.cmpi"(%276, %268) <{predicate = 5 : i64}> : (index, index) -> i1
    %278 = "arith.andi"(%274, %277) : (i1, i1) -> i1
    %279 = "arith.constant"() <{value = -1 : index}> : () -> index
    %280 = "arith.addi"(%arg89, %279) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %281 = "arith.cmpi"(%280, %268) <{predicate = 5 : i64}> : (index, index) -> i1
    %282 = "arith.andi"(%278, %281) : (i1, i1) -> i1
    %283 = "arith.constant"() <{value = -1 : index}> : () -> index
    %284 = "arith.addi"(%arg90, %283) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %285 = "arith.cmpi"(%284, %268) <{predicate = 5 : i64}> : (index, index) -> i1
    %286 = "arith.andi"(%282, %285) : (i1, i1) -> i1
    %287 = "arith.constant"() <{value = -42 : index}> : () -> index
    %288 = "arith.addi"(%arg91, %287) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %289 = "arith.cmpi"(%288, %268) <{predicate = 0 : i64}> : (index, index) -> i1
    %290 = "arith.andi"(%286, %289) : (i1, i1) -> i1
    "scf.if"(%290) ({
      "func.call"(%267) <{callee = @body}> : (index) -> ()
      "scf.yield"() : () -> ()
    }, {
      "func.call"(%267) <{callee = @mid}> : (index) -> ()
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "if_for"}> ({
    %243 = "func.call"() <{callee = @get_idx}> : () -> index
    %244 = "arith.constant"() <{value = 0 : index}> : () -> index
    %245 = "arith.constant"() <{value = -1 : index}> : () -> index
    %246 = "arith.muli"(%243, %245) <{overflowFlags = #arith.overflow<nsw>}> : (index, index) -> index
    %247 = "arith.constant"() <{value = 20 : index}> : () -> index
    %248 = "arith.addi"(%246, %247) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %249 = "arith.cmpi"(%248, %244) <{predicate = 5 : i64}> : (index, index) -> i1
    "scf.if"(%249) ({
      %260 = "arith.constant"() <{value = 0 : index}> : () -> index
      %261 = "arith.constant"() <{value = 42 : index}> : () -> index
      %262 = "arith.constant"() <{value = 1 : index}> : () -> index
      "scf.for"(%260, %261, %262) ({
      ^bb0(%arg87: index):
        %263 = "arith.constant"() <{value = 0 : index}> : () -> index
        %264 = "arith.constant"() <{value = -10 : index}> : () -> index
        %265 = "arith.addi"(%arg87, %264) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %266 = "arith.cmpi"(%265, %263) <{predicate = 5 : i64}> : (index, index) -> i1
        "scf.if"(%266) ({
          "func.call"(%243, %arg87) <{callee = @body2}> : (index, index) -> ()
          "scf.yield"() : () -> ()
        }, {
        }) : (i1) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    %250 = "arith.constant"() <{value = 0 : index}> : () -> index
    %251 = "arith.constant"() <{value = 42 : index}> : () -> index
    %252 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%250, %251, %252) ({
    ^bb0(%arg85: index):
      %253 = "arith.constant"() <{value = 0 : index}> : () -> index
      %254 = "arith.constant"() <{value = -10 : index}> : () -> index
      %255 = "arith.addi"(%arg85, %254) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %256 = "arith.cmpi"(%255, %253) <{predicate = 5 : i64}> : (index, index) -> i1
      "scf.if"(%256) ({
        %257 = "arith.constant"() <{value = 0 : index}> : () -> index
        %258 = "arith.constant"() <{value = 42 : index}> : () -> index
        %259 = "arith.constant"() <{value = 1 : index}> : () -> index
        "scf.for"(%257, %258, %259) ({
        ^bb0(%arg86: index):
          "func.call"(%arg85, %arg86) <{callee = @body3}> : (index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "loop_min_max"}> ({
  ^bb0(%arg82: index):
    %232 = "arith.constant"() <{value = 0 : index}> : () -> index
    %233 = "arith.constant"() <{value = 42 : index}> : () -> index
    %234 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%232, %233, %234) ({
    ^bb0(%arg83: index):
      %235 = "arith.constant"() <{value = -1 : index}> : () -> index
      %236 = "arith.muli"(%arg83, %235) <{overflowFlags = #arith.overflow<nsw>}> : (index, index) -> index
      %237 = "arith.addi"(%236, %arg82) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %238 = "arith.maxsi"(%arg83, %237) : (index, index) -> index
      %239 = "arith.constant"() <{value = 10 : index}> : () -> index
      %240 = "arith.addi"(%arg83, %239) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %241 = "arith.minsi"(%arg82, %240) : (index, index) -> index
      %242 = "arith.constant"() <{value = 1 : index}> : () -> index
      "scf.for"(%238, %241, %242) ({
      ^bb0(%arg84: index):
        "func.call"(%arg83, %arg84) <{callee = @body2}> : (index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index, index, index, index, index) -> (), sym_name = "min_reduction_tree"}> ({
  ^bb0(%arg74: index, %arg75: index, %arg76: index, %arg77: index, %arg78: index, %arg79: index, %arg80: index):
    %224 = "arith.constant"() <{value = 0 : index}> : () -> index
    %225 = "arith.minsi"(%arg74, %arg75) : (index, index) -> index
    %226 = "arith.minsi"(%225, %arg76) : (index, index) -> index
    %227 = "arith.minsi"(%226, %arg77) : (index, index) -> index
    %228 = "arith.minsi"(%227, %arg78) : (index, index) -> index
    %229 = "arith.minsi"(%228, %arg79) : (index, index) -> index
    %230 = "arith.minsi"(%229, %arg80) : (index, index) -> index
    %231 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%224, %230, %231) ({
    ^bb0(%arg81: index):
      "func.call"(%arg81) <{callee = @body}> : (index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "affine_applies"}> ({
  ^bb0(%arg73: index):
    %200 = "arith.constant"() <{value = 0 : index}> : () -> index
    %201 = "arith.constant"() <{value = 101 : index}> : () -> index
    %202 = "arith.constant"() <{value = 102 : index}> : () -> index
    %203 = "arith.addi"(%200, %200) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %204 = "arith.constant"() <{value = 1 : index}> : () -> index
    %205 = "arith.addi"(%203, %204) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %206 = "arith.constant"() <{value = 2 : index}> : () -> index
    %207 = "arith.muli"(%arg73, %206) <{overflowFlags = #arith.overflow<nsw>}> : (index, index) -> index
    %208 = "arith.addi"(%arg73, %207) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %209 = "arith.constant"() <{value = 3 : index}> : () -> index
    %210 = "arith.muli"(%arg73, %209) <{overflowFlags = #arith.overflow<nsw>}> : (index, index) -> index
    %211 = "arith.addi"(%208, %210) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %212 = "arith.constant"() <{value = 4 : index}> : () -> index
    %213 = "arith.muli"(%arg73, %212) <{overflowFlags = #arith.overflow<nsw>}> : (index, index) -> index
    %214 = "arith.addi"(%211, %213) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %215 = "arith.constant"() <{value = 5 : index}> : () -> index
    %216 = "arith.muli"(%arg73, %215) <{overflowFlags = #arith.overflow<nsw>}> : (index, index) -> index
    %217 = "arith.addi"(%214, %216) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %218 = "arith.constant"() <{value = 6 : index}> : () -> index
    %219 = "arith.muli"(%arg73, %218) <{overflowFlags = #arith.overflow<nsw>}> : (index, index) -> index
    %220 = "arith.addi"(%217, %219) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %221 = "arith.constant"() <{value = 7 : index}> : () -> index
    %222 = "arith.muli"(%arg73, %221) <{overflowFlags = #arith.overflow<nsw>}> : (index, index) -> index
    %223 = "arith.addi"(%220, %222) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> (index, index), sym_name = "args_ret_affine_apply"}> ({
  ^bb0(%arg71: index, %arg72: index):
    "func.return"(%arg71, %arg72) : (index, index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "affine_apply_mod"}> ({
  ^bb0(%arg70: index):
    %194 = "arith.constant"() <{value = 42 : index}> : () -> index
    %195 = "arith.remsi"(%arg70, %194) : (index, index) -> index
    %196 = "arith.constant"() <{value = 0 : index}> : () -> index
    %197 = "arith.cmpi"(%195, %196) <{predicate = 2 : i64}> : (index, index) -> i1
    %198 = "arith.addi"(%195, %194) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %199 = "arith.select"(%197, %198, %195) : (i1, index, index) -> index
    "func.return"(%199) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "affine_apply_mod_dynamic_divisor"}> ({
  ^bb0(%arg68: index, %arg69: index):
    %189 = "arith.remsi"(%arg68, %arg69) : (index, index) -> index
    %190 = "arith.constant"() <{value = 0 : index}> : () -> index
    %191 = "arith.cmpi"(%189, %190) <{predicate = 2 : i64}> : (index, index) -> i1
    %192 = "arith.addi"(%189, %arg69) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %193 = "arith.select"(%191, %192, %189) : (i1, index, index) -> index
    "func.return"(%193) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "affine_apply_floordiv"}> ({
  ^bb0(%arg67: index):
    %180 = "arith.constant"() <{value = 42 : index}> : () -> index
    %181 = "arith.constant"() <{value = 0 : index}> : () -> index
    %182 = "arith.constant"() <{value = -1 : index}> : () -> index
    %183 = "arith.cmpi"(%arg67, %181) <{predicate = 2 : i64}> : (index, index) -> i1
    %184 = "arith.subi"(%182, %arg67) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %185 = "arith.select"(%183, %184, %arg67) : (i1, index, index) -> index
    %186 = "arith.divsi"(%185, %180) : (index, index) -> index
    %187 = "arith.subi"(%182, %186) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %188 = "arith.select"(%183, %187, %186) : (i1, index, index) -> index
    "func.return"(%188) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "affine_apply_floordiv_dynamic_divisor"}> ({
  ^bb0(%arg65: index, %arg66: index):
    %172 = "arith.constant"() <{value = 0 : index}> : () -> index
    %173 = "arith.constant"() <{value = -1 : index}> : () -> index
    %174 = "arith.cmpi"(%arg65, %172) <{predicate = 2 : i64}> : (index, index) -> i1
    %175 = "arith.subi"(%173, %arg65) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %176 = "arith.select"(%174, %175, %arg65) : (i1, index, index) -> index
    %177 = "arith.divsi"(%176, %arg66) : (index, index) -> index
    %178 = "arith.subi"(%173, %177) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %179 = "arith.select"(%174, %178, %177) : (i1, index, index) -> index
    "func.return"(%179) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "affine_apply_ceildiv"}> ({
  ^bb0(%arg64: index):
    %161 = "arith.constant"() <{value = 42 : index}> : () -> index
    %162 = "arith.constant"() <{value = 0 : index}> : () -> index
    %163 = "arith.constant"() <{value = 1 : index}> : () -> index
    %164 = "arith.cmpi"(%arg64, %162) <{predicate = 3 : i64}> : (index, index) -> i1
    %165 = "arith.subi"(%162, %arg64) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %166 = "arith.subi"(%arg64, %163) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %167 = "arith.select"(%164, %165, %166) : (i1, index, index) -> index
    %168 = "arith.divsi"(%167, %161) : (index, index) -> index
    %169 = "arith.subi"(%162, %168) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %170 = "arith.addi"(%168, %163) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %171 = "arith.select"(%164, %169, %170) : (i1, index, index) -> index
    "func.return"(%171) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "affine_apply_ceildiv_dynamic_divisor"}> ({
  ^bb0(%arg62: index, %arg63: index):
    %151 = "arith.constant"() <{value = 0 : index}> : () -> index
    %152 = "arith.constant"() <{value = 1 : index}> : () -> index
    %153 = "arith.cmpi"(%arg62, %151) <{predicate = 3 : i64}> : (index, index) -> i1
    %154 = "arith.subi"(%151, %arg62) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %155 = "arith.subi"(%arg62, %152) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %156 = "arith.select"(%153, %154, %155) : (i1, index, index) -> index
    %157 = "arith.divsi"(%156, %arg63) : (index, index) -> index
    %158 = "arith.subi"(%151, %157) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %159 = "arith.addi"(%157, %152) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %160 = "arith.select"(%153, %158, %159) : (i1, index, index) -> index
    "func.return"(%160) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "affine_load"}> ({
  ^bb0(%arg60: index):
    %143 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    %144 = "arith.constant"() <{value = 0 : index}> : () -> index
    %145 = "arith.constant"() <{value = 10 : index}> : () -> index
    %146 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%144, %145, %146) ({
    ^bb0(%arg61: index):
      %147 = "arith.addi"(%arg61, %arg60) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %148 = "arith.constant"() <{value = 7 : index}> : () -> index
      %149 = "arith.addi"(%147, %148) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %150 = "memref.load"(%143, %149) <{nontemporal = false}> : (memref<10xf32>, index) -> f32
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "affine_store"}> ({
  ^bb0(%arg58: index):
    %133 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    %134 = "arith.constant"() <{value = 1.100000e+01 : f32}> : () -> f32
    %135 = "arith.constant"() <{value = 0 : index}> : () -> index
    %136 = "arith.constant"() <{value = 10 : index}> : () -> index
    %137 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%135, %136, %137) ({
    ^bb0(%arg59: index):
      %138 = "arith.constant"() <{value = -1 : index}> : () -> index
      %139 = "arith.muli"(%arg58, %138) <{overflowFlags = #arith.overflow<nsw>}> : (index, index) -> index
      %140 = "arith.addi"(%arg59, %139) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %141 = "arith.constant"() <{value = 7 : index}> : () -> index
      %142 = "arith.addi"(%140, %141) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "memref.store"(%134, %133, %142) <{nontemporal = false}> : (f32, memref<10xf32>, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i32>, memref<i32>) -> (), sym_name = "affine_load_store_zero_dim"}> ({
  ^bb0(%arg56: memref<i32>, %arg57: memref<i32>):
    %132 = "memref.load"(%arg56) <{nontemporal = false}> : (memref<i32>) -> i32
    "memref.store"(%132, %arg57) <{nontemporal = false}> : (i32, memref<i32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "affine_prefetch"}> ({
  ^bb0(%arg54: index):
    %125 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    %126 = "arith.constant"() <{value = 0 : index}> : () -> index
    %127 = "arith.constant"() <{value = 10 : index}> : () -> index
    %128 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%126, %127, %128) ({
    ^bb0(%arg55: index):
      %129 = "arith.addi"(%arg55, %arg54) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %130 = "arith.constant"() <{value = 7 : index}> : () -> index
      %131 = "arith.addi"(%129, %130) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "memref.prefetch"(%125, %131) <{isDataCache = true, isWrite = false, localityHint = 3 : i32}> : (memref<10xf32>, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "affine_dma_start"}> ({
  ^bb0(%arg52: index):
    %113 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<100xf32>
    %114 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<100xf32, 2>
    %115 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1xi32>
    %116 = "arith.constant"() <{value = 0 : index}> : () -> index
    %117 = "arith.constant"() <{value = 64 : index}> : () -> index
    %118 = "arith.constant"() <{value = 0 : index}> : () -> index
    %119 = "arith.constant"() <{value = 10 : index}> : () -> index
    %120 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%118, %119, %120) ({
    ^bb0(%arg53: index):
      %121 = "arith.constant"() <{value = 7 : index}> : () -> index
      %122 = "arith.addi"(%arg53, %121) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %123 = "arith.constant"() <{value = 11 : index}> : () -> index
      %124 = "arith.addi"(%arg52, %123) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "memref.dma_start"(%113, %122, %114, %124, %117, %115, %116) : (memref<100xf32>, index, memref<100xf32, 2>, index, index, memref<1xi32>, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "affine_dma_wait"}> ({
  ^bb0(%arg50: index):
    %105 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1xi32>
    %106 = "arith.constant"() <{value = 64 : index}> : () -> index
    %107 = "arith.constant"() <{value = 0 : index}> : () -> index
    %108 = "arith.constant"() <{value = 10 : index}> : () -> index
    %109 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%107, %108, %109) ({
    ^bb0(%arg51: index):
      %110 = "arith.addi"(%arg51, %arg50) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %111 = "arith.constant"() <{value = 17 : index}> : () -> index
      %112 = "arith.addi"(%110, %111) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "memref.dma_wait"(%105, %112, %106) : (memref<1xi32>, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "affine_min"}> ({
  ^bb0(%arg48: index, %arg49: index):
    %98 = "arith.constant"() <{value = -1 : index}> : () -> index
    %99 = "arith.muli"(%arg49, %98) <{overflowFlags = #arith.overflow<nsw>}> : (index, index) -> index
    %100 = "arith.addi"(%arg48, %99) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %101 = "arith.constant"() <{value = -1 : index}> : () -> index
    %102 = "arith.muli"(%arg48, %101) <{overflowFlags = #arith.overflow<nsw>}> : (index, index) -> index
    %103 = "arith.addi"(%arg49, %102) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %104 = "arith.minsi"(%100, %103) : (index, index) -> index
    "func.return"(%104) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "affine_max"}> ({
  ^bb0(%arg46: index, %arg47: index):
    %91 = "arith.constant"() <{value = -1 : index}> : () -> index
    %92 = "arith.muli"(%arg47, %91) <{overflowFlags = #arith.overflow<nsw>}> : (index, index) -> index
    %93 = "arith.addi"(%arg46, %92) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %94 = "arith.constant"() <{value = -1 : index}> : () -> index
    %95 = "arith.muli"(%arg46, %94) <{overflowFlags = #arith.overflow<nsw>}> : (index, index) -> index
    %96 = "arith.addi"(%arg47, %95) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %97 = "arith.maxsi"(%93, %96) : (index, index) -> index
    "func.return"(%97) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<100x100xf32>, memref<100x100xf32>) -> (), sym_name = "affine_parallel"}> ({
  ^bb0(%arg42: memref<100x100xf32>, %arg43: memref<100x100xf32>):
    %85 = "arith.constant"() <{value = 0 : index}> : () -> index
    %86 = "arith.constant"() <{value = 100 : index}> : () -> index
    %87 = "arith.constant"() <{value = 0 : index}> : () -> index
    %88 = "arith.constant"() <{value = 100 : index}> : () -> index
    %89 = "arith.constant"() <{value = 1 : index}> : () -> index
    %90 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.parallel"(%85, %87, %86, %88, %89, %90) <{operandSegmentSizes = array<i32: 2, 2, 2, 0>}> ({
    ^bb0(%arg44: index, %arg45: index):
      "scf.reduce"() : () -> ()
    }) : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<100x100xf32>, memref<100x100xf32>, memref<100x100xf32>) -> (), sym_name = "affine_parallel_tiled"}> ({
  ^bb0(%arg33: memref<100x100xf32>, %arg34: memref<100x100xf32>, %arg35: memref<100x100xf32>):
    %64 = "arith.constant"() <{value = 0 : index}> : () -> index
    %65 = "arith.constant"() <{value = 100 : index}> : () -> index
    %66 = "arith.constant"() <{value = 0 : index}> : () -> index
    %67 = "arith.constant"() <{value = 100 : index}> : () -> index
    %68 = "arith.constant"() <{value = 0 : index}> : () -> index
    %69 = "arith.constant"() <{value = 100 : index}> : () -> index
    %70 = "arith.constant"() <{value = 10 : index}> : () -> index
    %71 = "arith.constant"() <{value = 10 : index}> : () -> index
    %72 = "arith.constant"() <{value = 10 : index}> : () -> index
    "scf.parallel"(%64, %66, %68, %65, %67, %69, %70, %71, %72) <{operandSegmentSizes = array<i32: 3, 3, 3, 0>}> ({
    ^bb0(%arg36: index, %arg37: index, %arg38: index):
      %73 = "arith.constant"() <{value = 10 : index}> : () -> index
      %74 = "arith.addi"(%arg36, %73) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %75 = "arith.constant"() <{value = 10 : index}> : () -> index
      %76 = "arith.addi"(%arg37, %75) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %77 = "arith.constant"() <{value = 10 : index}> : () -> index
      %78 = "arith.addi"(%arg38, %77) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %79 = "arith.constant"() <{value = 1 : index}> : () -> index
      %80 = "arith.constant"() <{value = 1 : index}> : () -> index
      %81 = "arith.constant"() <{value = 1 : index}> : () -> index
      "scf.parallel"(%arg36, %arg37, %arg38, %74, %76, %78, %79, %80, %81) <{operandSegmentSizes = array<i32: 3, 3, 3, 0>}> ({
      ^bb0(%arg39: index, %arg40: index, %arg41: index):
        %82 = "memref.load"(%arg34, %arg39, %arg41) <{nontemporal = false}> : (memref<100x100xf32>, index, index) -> f32
        %83 = "memref.load"(%arg35, %arg41, %arg40) <{nontemporal = false}> : (memref<100x100xf32>, index, index) -> f32
        %84 = "arith.mulf"(%82, %83) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "scf.reduce"() : () -> ()
      }) : (index, index, index, index, index, index, index, index, index) -> ()
      "scf.reduce"() : () -> ()
    }) : (index, index, index, index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<3x3xf32>, memref<3x3xf32>) -> memref<3x3xf32>, sym_name = "affine_parallel_simple"}> ({
  ^bb0(%arg29: memref<3x3xf32>, %arg30: memref<3x3xf32>):
    %54 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3x3xf32>
    %55 = "arith.constant"() <{value = 0 : index}> : () -> index
    %56 = "arith.constant"() <{value = 2 : index}> : () -> index
    %57 = "arith.constant"() <{value = 0 : index}> : () -> index
    %58 = "arith.constant"() <{value = 2 : index}> : () -> index
    %59 = "arith.constant"() <{value = 1 : index}> : () -> index
    %60 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.parallel"(%55, %57, %56, %58, %59, %60) <{operandSegmentSizes = array<i32: 2, 2, 2, 0>}> ({
    ^bb0(%arg31: index, %arg32: index):
      %61 = "memref.load"(%arg29, %arg31, %arg32) <{nontemporal = false}> : (memref<3x3xf32>, index, index) -> f32
      %62 = "memref.load"(%arg30, %arg31, %arg32) <{nontemporal = false}> : (memref<3x3xf32>, index, index) -> f32
      %63 = "arith.mulf"(%61, %62) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "memref.store"(%63, %54, %arg31, %arg32) <{nontemporal = false}> : (f32, memref<3x3xf32>, index, index) -> ()
      "scf.reduce"() : () -> ()
    }) : (index, index, index, index, index, index) -> ()
    "func.return"(%54) : (memref<3x3xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf32>, memref<?x?xf32>, memref<?x?xf32>) -> (), sym_name = "affine_parallel_simple_dynamic_bounds"}> ({
  ^bb0(%arg24: memref<?x?xf32>, %arg25: memref<?x?xf32>, %arg26: memref<?x?xf32>):
    %45 = "arith.constant"() <{value = 0 : index}> : () -> index
    %46 = "memref.dim"(%arg24, %45) : (memref<?x?xf32>, index) -> index
    %47 = "arith.constant"() <{value = 0 : index}> : () -> index
    %48 = "arith.constant"() <{value = 0 : index}> : () -> index
    %49 = "arith.constant"() <{value = 1 : index}> : () -> index
    %50 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.parallel"(%47, %48, %46, %46, %49, %50) <{operandSegmentSizes = array<i32: 2, 2, 2, 0>}> ({
    ^bb0(%arg27: index, %arg28: index):
      %51 = "memref.load"(%arg24, %arg27, %arg28) <{nontemporal = false}> : (memref<?x?xf32>, index, index) -> f32
      %52 = "memref.load"(%arg25, %arg27, %arg28) <{nontemporal = false}> : (memref<?x?xf32>, index, index) -> f32
      %53 = "arith.mulf"(%51, %52) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "memref.store"(%53, %arg26, %arg27, %arg28) <{nontemporal = false}> : (f32, memref<?x?xf32>, index, index) -> ()
      "scf.reduce"() : () -> ()
    }) : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<3x3xf32>, memref<3x3xf32>) -> (f32, f32), sym_name = "affine_parallel_with_reductions"}> ({
  ^bb0(%arg16: memref<3x3xf32>, %arg17: memref<3x3xf32>):
    %30 = "arith.constant"() <{value = 0 : index}> : () -> index
    %31 = "arith.constant"() <{value = 2 : index}> : () -> index
    %32 = "arith.constant"() <{value = 0 : index}> : () -> index
    %33 = "arith.constant"() <{value = 2 : index}> : () -> index
    %34 = "arith.constant"() <{value = 1 : index}> : () -> index
    %35 = "arith.constant"() <{value = 1 : index}> : () -> index
    %36 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %37 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %38:2 = "scf.parallel"(%30, %32, %31, %33, %34, %35, %36, %37) <{operandSegmentSizes = array<i32: 2, 2, 2, 2>}> ({
    ^bb0(%arg18: index, %arg19: index):
      %39 = "memref.load"(%arg16, %arg18, %arg19) <{nontemporal = false}> : (memref<3x3xf32>, index, index) -> f32
      %40 = "memref.load"(%arg17, %arg18, %arg19) <{nontemporal = false}> : (memref<3x3xf32>, index, index) -> f32
      %41 = "arith.mulf"(%39, %40) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %42 = "arith.addf"(%39, %40) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "scf.reduce"(%41, %42) ({
      ^bb0(%arg22: f32, %arg23: f32):
        %44 = "arith.addf"(%arg22, %arg23) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "scf.reduce.return"(%44) : (f32) -> ()
      }, {
      ^bb0(%arg20: f32, %arg21: f32):
        %43 = "arith.mulf"(%arg20, %arg21) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "scf.reduce.return"(%43) : (f32) -> ()
      }) : (f32, f32) -> ()
    }) : (index, index, index, index, index, index, f32, f32) -> (f32, f32)
    "func.return"(%38#0, %38#1) : (f32, f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<3x3xf64>, memref<3x3xf64>) -> (f64, f64), sym_name = "affine_parallel_with_reductions_f64"}> ({
  ^bb0(%arg8: memref<3x3xf64>, %arg9: memref<3x3xf64>):
    %15 = "arith.constant"() <{value = 0 : index}> : () -> index
    %16 = "arith.constant"() <{value = 2 : index}> : () -> index
    %17 = "arith.constant"() <{value = 0 : index}> : () -> index
    %18 = "arith.constant"() <{value = 2 : index}> : () -> index
    %19 = "arith.constant"() <{value = 1 : index}> : () -> index
    %20 = "arith.constant"() <{value = 1 : index}> : () -> index
    %21 = "arith.constant"() <{value = 0.000000e+00 : f64}> : () -> f64
    %22 = "arith.constant"() <{value = 1.000000e+00 : f64}> : () -> f64
    %23:2 = "scf.parallel"(%15, %17, %16, %18, %19, %20, %21, %22) <{operandSegmentSizes = array<i32: 2, 2, 2, 2>}> ({
    ^bb0(%arg10: index, %arg11: index):
      %24 = "memref.load"(%arg8, %arg10, %arg11) <{nontemporal = false}> : (memref<3x3xf64>, index, index) -> f64
      %25 = "memref.load"(%arg9, %arg10, %arg11) <{nontemporal = false}> : (memref<3x3xf64>, index, index) -> f64
      %26 = "arith.mulf"(%24, %25) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
      %27 = "arith.addf"(%24, %25) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
      "scf.reduce"(%26, %27) ({
      ^bb0(%arg14: f64, %arg15: f64):
        %29 = "arith.addf"(%arg14, %arg15) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
        "scf.reduce.return"(%29) : (f64) -> ()
      }, {
      ^bb0(%arg12: f64, %arg13: f64):
        %28 = "arith.mulf"(%arg12, %arg13) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
        "scf.reduce.return"(%28) : (f64) -> ()
      }) : (f64, f64) -> ()
    }) : (index, index, index, index, index, index, f64, f64) -> (f64, f64)
    "func.return"(%23#0, %23#1) : (f64, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<3x3xi64>, memref<3x3xi64>) -> (i64, i64), sym_name = "affine_parallel_with_reductions_i64"}> ({
  ^bb0(%arg0: memref<3x3xi64>, %arg1: memref<3x3xi64>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 2 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "arith.constant"() <{value = 1 : index}> : () -> index
    %6 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %7 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %8:2 = "scf.parallel"(%0, %2, %1, %3, %4, %5, %6, %7) <{operandSegmentSizes = array<i32: 2, 2, 2, 2>}> ({
    ^bb0(%arg2: index, %arg3: index):
      %9 = "memref.load"(%arg0, %arg2, %arg3) <{nontemporal = false}> : (memref<3x3xi64>, index, index) -> i64
      %10 = "memref.load"(%arg1, %arg2, %arg3) <{nontemporal = false}> : (memref<3x3xi64>, index, index) -> i64
      %11 = "arith.muli"(%9, %10) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %12 = "arith.addi"(%9, %10) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      "scf.reduce"(%11, %12) ({
      ^bb0(%arg6: i64, %arg7: i64):
        %14 = "arith.addi"(%arg6, %arg7) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
        "scf.reduce.return"(%14) : (i64) -> ()
      }, {
      ^bb0(%arg4: i64, %arg5: i64):
        %13 = "arith.muli"(%arg4, %arg5) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
        "scf.reduce.return"(%13) : (i64) -> ()
      }) : (i64, i64) -> ()
    }) : (index, index, index, index, index, index, i64, i64) -> (i64, i64)
    "func.return"(%8#0, %8#1) : (i64, i64) -> ()
  }) : () -> ()
}) : () -> ()

