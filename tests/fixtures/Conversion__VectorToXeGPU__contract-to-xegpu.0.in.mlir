#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8x16xf16>, vector<16x16xf16>, vector<8x16xf32>) -> vector<8x16xf32>, sym_name = "dpas_gemm_f16"}> ({
  ^bb0(%arg0: vector<8x16xf16>, %arg1: vector<16x16xf16>, %arg2: vector<8x16xf32>):
    %0 = "vector.contract"(%arg0, %arg1, %arg2) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<8x16xf16>, vector<16x16xf16>, vector<8x16xf32>) -> vector<8x16xf32>
    "func.return"(%0) : (vector<8x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8x32xi8>, vector<32x16xi8>, vector<8x16xi32>) -> vector<8x16xi32>, sym_name = "dpas_gemm_i8"}> ({
  ^bb0(%arg0: vector<8x32xi8>, %arg1: vector<32x16xi8>, %arg2: vector<8x16xi32>):
    %0 = "vector.contract"(%arg0, %arg1, %arg2) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<8x32xi8>, vector<32x16xi8>, vector<8x16xi32>) -> vector<8x16xi32>
    "func.return"(%0) : (vector<8x16xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<128x512xf16>, vector<512x256xf16>, vector<128x256xf32>) -> vector<128x256xf32>, sym_name = "dpas_large_dims"}> ({
  ^bb0(%arg0: vector<128x512xf16>, %arg1: vector<512x256xf16>, %arg2: vector<128x256xf32>):
    %0 = "vector.contract"(%arg0, %arg1, %arg2) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<128x512xf16>, vector<512x256xf16>, vector<128x256xf32>) -> vector<128x256xf32>
    "func.return"(%0) : (vector<128x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d2, d0)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16x8xf16>, vector<16x16xf16>, vector<8x16xf32>) -> vector<8x16xf32>, sym_name = "gemm_transpose_a"}> ({
  ^bb0(%arg0: vector<16x8xf16>, %arg1: vector<16x16xf16>, %arg2: vector<8x16xf32>):
    %0 = "vector.contract"(%arg0, %arg1, %arg2) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x8xf16>, vector<16x16xf16>, vector<8x16xf32>) -> vector<8x16xf32>
    "func.return"(%0) : (vector<8x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8x16xf16>, vector<16x16xf16>, vector<8x16xf32>) -> vector<8x16xf32>, sym_name = "gemm_transpose_b"}> ({
  ^bb0(%arg0: vector<8x16xf16>, %arg1: vector<16x16xf16>, %arg2: vector<8x16xf32>):
    %0 = "vector.contract"(%arg0, %arg1, %arg2) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<8x16xf16>, vector<16x16xf16>, vector<8x16xf32>) -> vector<8x16xf32>
    "func.return"(%0) : (vector<8x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d2, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d2, d1, d3)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8x8x2xf16>, vector<8x16x2xf16>, vector<8x16xf32>) -> vector<8x16xf32>, sym_name = "negative_vnni_packed"}> ({
  ^bb0(%arg0: vector<8x8x2xf16>, %arg1: vector<8x16x2xf16>, %arg2: vector<8x16xf32>):
    %0 = "vector.contract"(%arg0, %arg1, %arg2) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<8x8x2xf16>, vector<8x16x2xf16>, vector<8x16xf32>) -> vector<8x16xf32>
    "func.return"(%0) : (vector<8x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8x16xf16>, vector<16x16xf16>, vector<8x16xf32>) -> vector<8x16xf32>, sym_name = "negative_combining_kind"}> ({
  ^bb0(%arg0: vector<8x16xf16>, %arg1: vector<16x16xf16>, %arg2: vector<8x16xf32>):
    %0 = "vector.contract"(%arg0, %arg1, %arg2) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<mul>}> : (vector<8x16xf16>, vector<16x16xf16>, vector<8x16xf32>) -> vector<8x16xf32>
    "func.return"(%0) : (vector<8x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8x16xf16>, vector<16x16xf16>, vector<f32>) -> vector<f32>, sym_name = "negative_accumulator_shape"}> ({
  ^bb0(%arg0: vector<8x16xf16>, %arg1: vector<16x16xf16>, %arg2: vector<f32>):
    %0 = "vector.contract"(%arg0, %arg1, %arg2) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<8x16xf16>, vector<16x16xf16>, vector<f32>) -> vector<f32>
    "func.return"(%0) : (vector<f32>) -> ()
  }) : () -> ()
}) : () -> ()

