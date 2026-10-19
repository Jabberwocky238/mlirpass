#map = affine_map<() -> (1)>
#map1 = affine_map<() -> (42)>
#map2 = affine_map<(d0) -> (d0)>
#map3 = affine_map<() -> (0)>
#map4 = affine_map<() -> (10)>
#map5 = affine_map<() -> (7)>
#map6 = affine_map<() -> (56)>
#map7 = affine_map<() -> (18)>
#map8 = affine_map<() -> (37)>
#map9 = affine_map<()[s0] -> (s0)>
#map10 = affine_map<(d0)[s0] -> (d0, -d0 + s0)>
#map11 = affine_map<(d0)[s0] -> (s0, d0 + 10)>
#map12 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3, d4, d5, d6)>
#map13 = affine_map<(d0)[s0] -> (d0 + s0 + 1)>
#map14 = affine_map<(d0, d1, d2, d3)[s0, s1, s2] -> (d0 + d1 * 2 + d2 * 3 + d3 * 4 + s0 * 5 + s1 * 6 + s2 * 7)>
#map15 = affine_map<(d0) -> (d0 mod 42)>
#map16 = affine_map<(d0)[s0] -> (d0 mod s0)>
#map17 = affine_map<(d0) -> (d0 floordiv 42)>
#map18 = affine_map<(d0)[s0] -> (d0 floordiv s0)>
#map19 = affine_map<(d0) -> (d0 ceildiv 42)>
#map20 = affine_map<(d0)[s0] -> (d0 ceildiv s0)>
#map21 = affine_map<(d0)[s0] -> (d0 + s0 + 7)>
#map22 = affine_map<(d0)[s0] -> (d0 - s0 + 7)>
#map23 = affine_map<() -> ()>
#map24 = affine_map<(d0) -> (d0 + 11)>
#map25 = affine_map<(d0) -> (d0 + 7)>
#map26 = affine_map<(d0, d1) -> (d0 + d1 + 17)>
#map27 = affine_map<(d0, d1) -> (d0 - d1, d1 - d0)>
#map28 = affine_map<() -> (0, 0)>
#map29 = affine_map<() -> (100, 100)>
#map30 = affine_map<(d0, d1) -> (d0, d1)>
#map31 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map32 = affine_map<(d0, d1, d2) -> (d0 + 10, d1 + 10, d2 + 10)>
#map33 = affine_map<() -> (0, 0, 0)>
#map34 = affine_map<() -> (100, 100, 100)>
#map35 = affine_map<() -> (2, 2)>
#map36 = affine_map<(d0) -> (d0, d0)>
#set = affine_set<(d0) : (-d0 + 20 >= 0)>
#set1 = affine_set<(d0) : (d0 - 10 >= 0)>
#set2 = affine_set<(d0)[s0, s1, s2, s3] : (-d0 + s0 + 1 >= 0, s0 - 1 >= 0, s1 - 1 >= 0, s2 - 1 >= 0, s3 - 42 == 0)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "empty"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "body", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "simple_loop"}> ({
    "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg91: index):
      "func.call"(%arg91) <{callee = @body}> : (index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1024xf32>) -> f32, sym_name = "for_with_yield"}> ({
  ^bb0(%arg88: memref<1024xf32>):
    %66 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %67 = "affine.for"(%66) <{lowerBoundMap = #map3, operandSegmentSizes = array<i32: 0, 0, 1>, step = 2 : index, upperBoundMap = #map4}> ({
    ^bb0(%arg89: index, %arg90: f32):
      %68 = "affine.load"(%arg88, %arg89) <{map = #map2}> : (memref<1024xf32>, index) -> f32
      %69 = "arith.addf"(%arg90, %68) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "affine.yield"(%69) : (f32) -> ()
    }) : (f32) -> f32
    "func.return"(%67) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "pre", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> (), sym_name = "body2", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "post", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "imperfectly_nested_loops"}> ({
    "affine.for"() <{lowerBoundMap = #map3, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg86: index):
      "func.call"(%arg86) <{callee = @pre}> : (index) -> ()
      "affine.for"() <{lowerBoundMap = #map5, operandSegmentSizes = array<i32: 0, 0, 0>, step = 2 : index, upperBoundMap = #map6}> ({
      ^bb0(%arg87: index):
        "func.call"(%arg86, %arg87) <{callee = @body2}> : (index, index) -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "func.call"(%arg86) <{callee = @post}> : (index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "mid", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> (), sym_name = "body3", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "more_imperfectly_nested_loops"}> ({
    "affine.for"() <{lowerBoundMap = #map3, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg83: index):
      "func.call"(%arg83) <{callee = @pre}> : (index) -> ()
      "affine.for"() <{lowerBoundMap = #map5, operandSegmentSizes = array<i32: 0, 0, 0>, step = 2 : index, upperBoundMap = #map6}> ({
      ^bb0(%arg85: index):
        "func.call"(%arg83, %arg85) <{callee = @body2}> : (index, index) -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "func.call"(%arg83) <{callee = @mid}> : (index) -> ()
      "affine.for"() <{lowerBoundMap = #map7, operandSegmentSizes = array<i32: 0, 0, 0>, step = 3 : index, upperBoundMap = #map8}> ({
      ^bb0(%arg84: index):
        "func.call"(%arg83, %arg84) <{callee = @body3}> : (index, index) -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "func.call"(%arg83) <{callee = @post}> : (index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "affine_apply_loops_shorthand"}> ({
  ^bb0(%arg80: index):
    "affine.for"(%arg80) <{lowerBoundMap = #map3, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map9}> ({
    ^bb0(%arg81: index):
      "affine.for"(%arg81) <{lowerBoundMap = #map2, operandSegmentSizes = array<i32: 1, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
      ^bb0(%arg82: index):
        "func.call"(%arg81, %arg82) <{callee = @body2}> : (index, index) -> ()
        "affine.yield"() : () -> ()
      }) : (index) -> ()
      "affine.yield"() : () -> ()
    }) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> index, sym_name = "get_idx", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "if_only"}> ({
    %65 = "func.call"() <{callee = @get_idx}> : () -> index
    "affine.if"(%65) <{condition = #set}> ({
      "func.call"(%65) <{callee = @body}> : (index) -> ()
      "affine.yield"() : () -> ()
    }, {
    }) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "if_else"}> ({
    %64 = "func.call"() <{callee = @get_idx}> : () -> index
    "affine.if"(%64) <{condition = #set}> ({
      "func.call"(%64) <{callee = @body}> : (index) -> ()
      "affine.yield"() : () -> ()
    }, {
      "func.call"(%64) <{callee = @mid}> : (index) -> ()
      "affine.yield"() : () -> ()
    }) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "nested_ifs"}> ({
    %63 = "func.call"() <{callee = @get_idx}> : () -> index
    "affine.if"(%63) <{condition = #set}> ({
      "affine.if"(%63) <{condition = #set1}> ({
        "func.call"(%63) <{callee = @body}> : (index) -> ()
        "affine.yield"() : () -> ()
      }, {
      }) : (index) -> ()
      "affine.yield"() : () -> ()
    }, {
      "affine.if"(%63) <{condition = #set1}> ({
        "func.call"(%63) <{callee = @mid}> : (index) -> ()
        "affine.yield"() : () -> ()
      }, {
      }) : (index) -> ()
      "affine.yield"() : () -> ()
    }) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "if_with_yield"}> ({
    %59 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %60 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %61 = "func.call"() <{callee = @get_idx}> : () -> index
    %62 = "affine.if"(%61) <{condition = #set1}> ({
      "affine.yield"(%59) : (i64) -> ()
    }, {
      "affine.yield"(%60) : (i64) -> ()
    }) : (index) -> i64
    "func.return"(%62) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index, index) -> (), sym_name = "multi_cond"}> ({
  ^bb0(%arg76: index, %arg77: index, %arg78: index, %arg79: index):
    %58 = "func.call"() <{callee = @get_idx}> : () -> index
    "affine.if"(%58, %arg76, %arg77, %arg78, %arg79) <{condition = #set2}> ({
      "func.call"(%58) <{callee = @body}> : (index) -> ()
      "affine.yield"() : () -> ()
    }, {
      "func.call"(%58) <{callee = @mid}> : (index) -> ()
      "affine.yield"() : () -> ()
    }) : (index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "if_for"}> ({
    %57 = "func.call"() <{callee = @get_idx}> : () -> index
    "affine.if"(%57) <{condition = #set}> ({
      "affine.for"() <{lowerBoundMap = #map3, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
      ^bb0(%arg75: index):
        "affine.if"(%arg75) <{condition = #set1}> ({
          "func.call"(%57, %arg75) <{callee = @body2}> : (index, index) -> ()
          "affine.yield"() : () -> ()
        }, {
        }) : (index) -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "affine.yield"() : () -> ()
    }, {
    }) : (index) -> ()
    "affine.for"() <{lowerBoundMap = #map3, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg73: index):
      "affine.if"(%arg73) <{condition = #set1}> ({
        "affine.for"() <{lowerBoundMap = #map3, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
        ^bb0(%arg74: index):
          "func.call"(%arg73, %arg74) <{callee = @body3}> : (index, index) -> ()
          "affine.yield"() : () -> ()
        }) : () -> ()
        "affine.yield"() : () -> ()
      }, {
      }) : (index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "loop_min_max"}> ({
  ^bb0(%arg70: index):
    "affine.for"() <{lowerBoundMap = #map3, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg71: index):
      "affine.for"(%arg71, %arg70, %arg71, %arg70) <{lowerBoundMap = #map10, operandSegmentSizes = array<i32: 2, 2, 0>, step = 1 : index, upperBoundMap = #map11}> ({
      ^bb0(%arg72: index):
        "func.call"(%arg71, %arg72) <{callee = @body2}> : (index, index) -> ()
        "affine.yield"() : () -> ()
      }) : (index, index, index, index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index, index, index, index, index) -> (), sym_name = "min_reduction_tree"}> ({
  ^bb0(%arg62: index, %arg63: index, %arg64: index, %arg65: index, %arg66: index, %arg67: index, %arg68: index):
    "affine.for"(%arg62, %arg63, %arg64, %arg65, %arg66, %arg67, %arg68) <{lowerBoundMap = #map3, operandSegmentSizes = array<i32: 0, 7, 0>, step = 1 : index, upperBoundMap = #map12}> ({
    ^bb0(%arg69: index):
      "func.call"(%arg69) <{callee = @body}> : (index) -> ()
      "affine.yield"() : () -> ()
    }) : (index, index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "affine_applies"}> ({
  ^bb0(%arg61: index):
    %50 = "affine.apply"() <{map = #map3}> : () -> index
    %51 = "arith.constant"() <{value = 101 : index}> : () -> index
    %52 = "affine.apply"(%50) <{map = #map9}> : (index) -> index
    %53 = "arith.constant"() <{value = 102 : index}> : () -> index
    %54 = "affine.apply"(%50) <{map = #map2}> : (index) -> index
    %55 = "affine.apply"(%52, %50) <{map = #map13}> : (index, index) -> index
    %56 = "affine.apply"(%arg61, %arg61, %arg61, %arg61, %arg61, %arg61, %arg61) <{map = #map14}> : (index, index, index, index, index, index, index) -> index
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> (index, index), sym_name = "args_ret_affine_apply"}> ({
  ^bb0(%arg59: index, %arg60: index):
    %48 = "affine.apply"(%arg59) <{map = #map2}> : (index) -> index
    %49 = "affine.apply"(%arg60) <{map = #map9}> : (index) -> index
    "func.return"(%48, %49) : (index, index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "affine_apply_mod"}> ({
  ^bb0(%arg58: index):
    %47 = "affine.apply"(%arg58) <{map = #map15}> : (index) -> index
    "func.return"(%47) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "affine_apply_mod_dynamic_divisor"}> ({
  ^bb0(%arg56: index, %arg57: index):
    %46 = "affine.apply"(%arg56, %arg57) <{map = #map16}> : (index, index) -> index
    "func.return"(%46) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "affine_apply_floordiv"}> ({
  ^bb0(%arg55: index):
    %45 = "affine.apply"(%arg55) <{map = #map17}> : (index) -> index
    "func.return"(%45) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "affine_apply_floordiv_dynamic_divisor"}> ({
  ^bb0(%arg53: index, %arg54: index):
    %44 = "affine.apply"(%arg53, %arg54) <{map = #map18}> : (index, index) -> index
    "func.return"(%44) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "affine_apply_ceildiv"}> ({
  ^bb0(%arg52: index):
    %43 = "affine.apply"(%arg52) <{map = #map19}> : (index) -> index
    "func.return"(%43) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "affine_apply_ceildiv_dynamic_divisor"}> ({
  ^bb0(%arg50: index, %arg51: index):
    %42 = "affine.apply"(%arg50, %arg51) <{map = #map20}> : (index, index) -> index
    "func.return"(%42) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "affine_load"}> ({
  ^bb0(%arg48: index):
    %40 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    "affine.for"() <{lowerBoundMap = #map3, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map4}> ({
    ^bb0(%arg49: index):
      %41 = "affine.load"(%40, %arg49, %arg48) <{map = #map21}> : (memref<10xf32>, index, index) -> f32
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "affine_store"}> ({
  ^bb0(%arg46: index):
    %38 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    %39 = "arith.constant"() <{value = 1.100000e+01 : f32}> : () -> f32
    "affine.for"() <{lowerBoundMap = #map3, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map4}> ({
    ^bb0(%arg47: index):
      "affine.store"(%39, %38, %arg47, %arg46) <{map = #map22}> : (f32, memref<10xf32>, index, index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i32>, memref<i32>) -> (), sym_name = "affine_load_store_zero_dim"}> ({
  ^bb0(%arg44: memref<i32>, %arg45: memref<i32>):
    %37 = "affine.load"(%arg44) <{map = #map23}> : (memref<i32>) -> i32
    "affine.store"(%37, %arg45) <{map = #map23}> : (i32, memref<i32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "affine_prefetch"}> ({
  ^bb0(%arg42: index):
    %36 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    "affine.for"() <{lowerBoundMap = #map3, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map4}> ({
    ^bb0(%arg43: index):
      "affine.prefetch"(%36, %arg43, %arg42) <{isDataCache = true, isWrite = false, localityHint = 3 : i32, map = #map21}> : (memref<10xf32>, index, index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "affine_dma_start"}> ({
  ^bb0(%arg40: index):
    %31 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<100xf32>
    %32 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<100xf32, 2>
    %33 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1xi32>
    %34 = "arith.constant"() <{value = 0 : index}> : () -> index
    %35 = "arith.constant"() <{value = 64 : index}> : () -> index
    "affine.for"() <{lowerBoundMap = #map3, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map4}> ({
    ^bb0(%arg41: index):
      "affine.dma_start"(%31, %arg41, %32, %arg40, %33, %34, %35) {dst_map = #map24, src_map = #map25, tag_map = #map2} : (memref<100xf32>, index, memref<100xf32, 2>, index, memref<1xi32>, index, index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "affine_dma_wait"}> ({
  ^bb0(%arg38: index):
    %29 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1xi32>
    %30 = "arith.constant"() <{value = 64 : index}> : () -> index
    "affine.for"() <{lowerBoundMap = #map3, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map4}> ({
    ^bb0(%arg39: index):
      "affine.dma_wait"(%29, %arg39, %arg38, %30) {tag_map = #map26} : (memref<1xi32>, index, index, index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "affine_min"}> ({
  ^bb0(%arg36: index, %arg37: index):
    %28 = "affine.min"(%arg36, %arg37) <{map = #map27}> : (index, index) -> index
    "func.return"(%28) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "affine_max"}> ({
  ^bb0(%arg34: index, %arg35: index):
    %27 = "affine.max"(%arg34, %arg35) <{map = #map27}> : (index, index) -> index
    "func.return"(%27) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<100x100xf32>, memref<100x100xf32>) -> (), sym_name = "affine_parallel"}> ({
  ^bb0(%arg30: memref<100x100xf32>, %arg31: memref<100x100xf32>):
    "affine.parallel"() <{lowerBoundsGroups = dense<1> : tensor<2xi32>, lowerBoundsMap = #map28, reductions = [], steps = [1, 1], upperBoundsGroups = dense<1> : tensor<2xi32>, upperBoundsMap = #map29}> ({
    ^bb0(%arg32: index, %arg33: index):
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<100x100xf32>, memref<100x100xf32>, memref<100x100xf32>) -> (), sym_name = "affine_parallel_tiled"}> ({
  ^bb0(%arg21: memref<100x100xf32>, %arg22: memref<100x100xf32>, %arg23: memref<100x100xf32>):
    "affine.parallel"() <{lowerBoundsGroups = dense<1> : tensor<3xi32>, lowerBoundsMap = #map33, reductions = [], steps = [10, 10, 10], upperBoundsGroups = dense<1> : tensor<3xi32>, upperBoundsMap = #map34}> ({
    ^bb0(%arg24: index, %arg25: index, %arg26: index):
      "affine.parallel"(%arg24, %arg25, %arg26, %arg24, %arg25, %arg26) <{lowerBoundsGroups = dense<1> : tensor<3xi32>, lowerBoundsMap = #map31, reductions = [], steps = [1, 1, 1], upperBoundsGroups = dense<1> : tensor<3xi32>, upperBoundsMap = #map32}> ({
      ^bb0(%arg27: index, %arg28: index, %arg29: index):
        %24 = "affine.load"(%arg22, %arg27, %arg29) <{map = #map30}> : (memref<100x100xf32>, index, index) -> f32
        %25 = "affine.load"(%arg23, %arg29, %arg28) <{map = #map30}> : (memref<100x100xf32>, index, index) -> f32
        %26 = "arith.mulf"(%24, %25) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "affine.yield"() : () -> ()
      }) : (index, index, index, index, index, index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<3x3xf32>, memref<3x3xf32>) -> memref<3x3xf32>, sym_name = "affine_parallel_simple"}> ({
  ^bb0(%arg17: memref<3x3xf32>, %arg18: memref<3x3xf32>):
    %20 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3x3xf32>
    "affine.parallel"() <{lowerBoundsGroups = dense<1> : tensor<2xi32>, lowerBoundsMap = #map28, reductions = [], steps = [1, 1], upperBoundsGroups = dense<1> : tensor<2xi32>, upperBoundsMap = #map35}> ({
    ^bb0(%arg19: index, %arg20: index):
      %21 = "affine.load"(%arg17, %arg19, %arg20) <{map = #map30}> : (memref<3x3xf32>, index, index) -> f32
      %22 = "affine.load"(%arg18, %arg19, %arg20) <{map = #map30}> : (memref<3x3xf32>, index, index) -> f32
      %23 = "arith.mulf"(%21, %22) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "affine.store"(%23, %20, %arg19, %arg20) <{map = #map30}> : (f32, memref<3x3xf32>, index, index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"(%20) : (memref<3x3xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf32>, memref<?x?xf32>, memref<?x?xf32>) -> (), sym_name = "affine_parallel_simple_dynamic_bounds"}> ({
  ^bb0(%arg12: memref<?x?xf32>, %arg13: memref<?x?xf32>, %arg14: memref<?x?xf32>):
    %15 = "arith.constant"() <{value = 0 : index}> : () -> index
    %16 = "memref.dim"(%arg12, %15) : (memref<?x?xf32>, index) -> index
    "affine.parallel"(%15, %16) <{lowerBoundsGroups = dense<1> : tensor<2xi32>, lowerBoundsMap = #map36, reductions = [], steps = [1, 1], upperBoundsGroups = dense<1> : tensor<2xi32>, upperBoundsMap = #map36}> ({
    ^bb0(%arg15: index, %arg16: index):
      %17 = "affine.load"(%arg12, %arg15, %arg16) <{map = #map30}> : (memref<?x?xf32>, index, index) -> f32
      %18 = "affine.load"(%arg13, %arg15, %arg16) <{map = #map30}> : (memref<?x?xf32>, index, index) -> f32
      %19 = "arith.mulf"(%17, %18) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "affine.store"(%19, %arg14, %arg15, %arg16) <{map = #map30}> : (f32, memref<?x?xf32>, index, index) -> ()
      "affine.yield"() : () -> ()
    }) : (index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<3x3xf32>, memref<3x3xf32>) -> (f32, f32), sym_name = "affine_parallel_with_reductions"}> ({
  ^bb0(%arg8: memref<3x3xf32>, %arg9: memref<3x3xf32>):
    %10:2 = "affine.parallel"() <{lowerBoundsGroups = dense<1> : tensor<2xi32>, lowerBoundsMap = #map28, reductions = [0, 12], steps = [1, 1], upperBoundsGroups = dense<1> : tensor<2xi32>, upperBoundsMap = #map35}> ({
    ^bb0(%arg10: index, %arg11: index):
      %11 = "affine.load"(%arg8, %arg10, %arg11) <{map = #map30}> : (memref<3x3xf32>, index, index) -> f32
      %12 = "affine.load"(%arg9, %arg10, %arg11) <{map = #map30}> : (memref<3x3xf32>, index, index) -> f32
      %13 = "arith.mulf"(%11, %12) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %14 = "arith.addf"(%11, %12) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "affine.yield"(%13, %14) : (f32, f32) -> ()
    }) : () -> (f32, f32)
    "func.return"(%10#0, %10#1) : (f32, f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<3x3xf64>, memref<3x3xf64>) -> (f64, f64), sym_name = "affine_parallel_with_reductions_f64"}> ({
  ^bb0(%arg4: memref<3x3xf64>, %arg5: memref<3x3xf64>):
    %5:2 = "affine.parallel"() <{lowerBoundsGroups = dense<1> : tensor<2xi32>, lowerBoundsMap = #map28, reductions = [0, 12], steps = [1, 1], upperBoundsGroups = dense<1> : tensor<2xi32>, upperBoundsMap = #map35}> ({
    ^bb0(%arg6: index, %arg7: index):
      %6 = "affine.load"(%arg4, %arg6, %arg7) <{map = #map30}> : (memref<3x3xf64>, index, index) -> f64
      %7 = "affine.load"(%arg5, %arg6, %arg7) <{map = #map30}> : (memref<3x3xf64>, index, index) -> f64
      %8 = "arith.mulf"(%6, %7) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
      %9 = "arith.addf"(%6, %7) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
      "affine.yield"(%8, %9) : (f64, f64) -> ()
    }) : () -> (f64, f64)
    "func.return"(%5#0, %5#1) : (f64, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<3x3xi64>, memref<3x3xi64>) -> (i64, i64), sym_name = "affine_parallel_with_reductions_i64"}> ({
  ^bb0(%arg0: memref<3x3xi64>, %arg1: memref<3x3xi64>):
    %0:2 = "affine.parallel"() <{lowerBoundsGroups = dense<1> : tensor<2xi32>, lowerBoundsMap = #map28, reductions = [1, 13], steps = [1, 1], upperBoundsGroups = dense<1> : tensor<2xi32>, upperBoundsMap = #map35}> ({
    ^bb0(%arg2: index, %arg3: index):
      %1 = "affine.load"(%arg0, %arg2, %arg3) <{map = #map30}> : (memref<3x3xi64>, index, index) -> i64
      %2 = "affine.load"(%arg1, %arg2, %arg3) <{map = #map30}> : (memref<3x3xi64>, index, index) -> i64
      %3 = "arith.muli"(%1, %2) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %4 = "arith.addi"(%1, %2) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      "affine.yield"(%3, %4) : (i64, i64) -> ()
    }) : () -> (i64, i64)
    "func.return"(%0#0, %0#1) : (i64, i64) -> ()
  }) : () -> ()
}) : () -> ()

