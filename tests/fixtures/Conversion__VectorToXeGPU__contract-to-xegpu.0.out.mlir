module {
  func.func @dpas_gemm_f16(%arg0: vector<8x16xf16>, %arg1: vector<16x16xf16>, %arg2: vector<8x16xf32>) -> vector<8x16xf32> {
    %0 = xegpu.dpas %arg0, %arg1, %arg2 : vector<8x16xf16>, vector<16x16xf16>, vector<8x16xf32> -> vector<8x16xf32>
    return %0 : vector<8x16xf32>
  }
}

// -----
module {
  func.func @dpas_gemm_i8(%arg0: vector<8x32xi8>, %arg1: vector<32x16xi8>, %arg2: vector<8x16xi32>) -> vector<8x16xi32> {
    %0 = xegpu.dpas %arg0, %arg1, %arg2 : vector<8x32xi8>, vector<32x16xi8>, vector<8x16xi32> -> vector<8x16xi32>
    return %0 : vector<8x16xi32>
  }
}

// -----
module {
  func.func @dpas_large_dims(%arg0: vector<128x512xf16>, %arg1: vector<512x256xf16>, %arg2: vector<128x256xf32>) -> vector<128x256xf32> {
    %0 = xegpu.dpas %arg0, %arg1, %arg2 : vector<128x512xf16>, vector<512x256xf16>, vector<128x256xf32> -> vector<128x256xf32>
    return %0 : vector<128x256xf32>
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d2, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d2, d1, d3)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1)>
module {
  func.func @negative_vnni_packed(%arg0: vector<8x8x2xf16>, %arg1: vector<8x16x2xf16>, %arg2: vector<8x16xf32>) -> vector<8x16xf32> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction", "reduction"], kind = #vector.kind<add>} %arg0, %arg1, %arg2 : vector<8x8x2xf16>, vector<8x16x2xf16> into vector<8x16xf32>
    return %0 : vector<8x16xf32>
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func @negative_combining_kind(%arg0: vector<8x16xf16>, %arg1: vector<16x16xf16>, %arg2: vector<8x16xf32>) -> vector<8x16xf32> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<mul>} %arg0, %arg1, %arg2 : vector<8x16xf16>, vector<16x16xf16> into vector<8x16xf32>
    return %0 : vector<8x16xf32>
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> ()>
module {
  func.func @negative_accumulator_shape(%arg0: vector<8x16xf16>, %arg1: vector<16x16xf16>, %arg2: vector<f32>) -> vector<f32> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "reduction", "reduction"], kind = #vector.kind<add>} %arg0, %arg1, %arg2 : vector<8x16xf16>, vector<16x16xf16> into vector<f32>
    return %0 : vector<f32>
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d2, d0)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func @negative_gemm_transpose_a(%arg0: vector<16x8xf16>, %arg1: vector<16x16xf16>, %arg2: vector<8x16xf32>) -> vector<8x16xf32> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %arg0, %arg1, %arg2 : vector<16x8xf16>, vector<16x16xf16> into vector<8x16xf32>
    return %0 : vector<8x16xf32>
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func @negative_gemm_transpose_b(%arg0: vector<8x16xf16>, %arg1: vector<16x16xf16>, %arg2: vector<8x16xf32>) -> vector<8x16xf32> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %arg0, %arg1, %arg2 : vector<8x16xf16>, vector<16x16xf16> into vector<8x16xf32>
    return %0 : vector<8x16xf32>
  }
}

