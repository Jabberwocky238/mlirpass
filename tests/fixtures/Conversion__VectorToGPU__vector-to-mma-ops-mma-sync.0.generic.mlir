#map = affine_map<()[s0] -> (s0 mod 16)>
#map1 = affine_map<()[s0] -> ((s0 floordiv 16) * 16)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
#map3 = affine_map<()[s0] -> (s0 floordiv 4 + 40)>
#map4 = affine_map<()[s0] -> (s0 * 4 - (s0 floordiv 4) * 16 + 39)>
#map5 = affine_map<()[s0] -> (s0 * 4 - (s0 floordiv 4) * 16 + 40)>
#map6 = affine_map<()[s0] -> (s0 * 4 - (s0 floordiv 4) * 16 + 41)>
#map7 = affine_map<()[s0] -> (s0 * 4 - (s0 floordiv 4) * 16 + 42)>
#map8 = affine_map<()[s0] -> (s0 * 4 - (s0 floordiv 4) * 16 + 55)>
#map9 = affine_map<()[s0] -> (s0 * 4 - (s0 floordiv 4) * 16 + 56)>
#map10 = affine_map<()[s0] -> (s0 * 4 - (s0 floordiv 4) * 16 + 57)>
#map11 = affine_map<()[s0] -> (s0 * 4 - (s0 floordiv 4) * 16 + 58)>
#map12 = affine_map<(d0, d1) -> (d1, d0)>
#map13 = affine_map<()[s0] -> (s0 floordiv 4 + 49)>
#map14 = affine_map<()[s0] -> (s0 * 2 - (s0 floordiv 4) * 8 + 40)>
#map15 = affine_map<()[s0] -> (s0 floordiv 4 + 57)>
#map16 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map17 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map18 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x128xi8, #gpu.address_space<workgroup>>, memref<128x128xi8, #gpu.address_space<workgroup>>, memref<128x128xi32>) -> (), sym_name = "m16n8k32_int8_row_row_row"}> ({
  ^bb0(%arg0: memref<128x128xi8, #gpu.address_space<workgroup>>, %arg1: memref<128x128xi8, #gpu.address_space<workgroup>>, %arg2: memref<128x128xi32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 39 : index}> : () -> index
    %2 = "arith.constant"() <{value = 40 : index}> : () -> index
    %3 = "arith.constant"() <{value = 49 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %5 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %6 = "gpu.lane_id"() : () -> index
    %7 = "affine.apply"(%6) <{map = #map}> : (index) -> index
    %8 = "affine.apply"(%6) <{map = #map1}> : (index) -> index
    %9 = "nvgpu.ldmatrix"(%arg0, %7, %8) <{numTiles = 4 : i32, transpose = false}> : (memref<128x128xi8, #gpu.address_space<workgroup>>, index, index) -> vector<4x4xi8>
    %10 = "vector.transfer_read"(%arg0, %0, %0, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<128x128xi8, #gpu.address_space<workgroup>>, index, index, i8) -> vector<16x32xi8>
    %11 = "gpu.lane_id"() : () -> index
    %12 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %13 = "vector.broadcast"(%12) : (i8) -> vector<2x4xi8>
    %14 = "arith.constant"() <{value = 0 : index}> : () -> index
    %15 = "affine.apply"(%11) <{map = #map3}> : (index) -> index
    %16 = "affine.apply"(%11) <{map = #map4}> : (index) -> index
    %17 = "memref.load"(%arg1, %16, %15) <{nontemporal = false}> : (memref<128x128xi8, #gpu.address_space<workgroup>>, index, index) -> i8
    %18 = "vector.insert"(%17, %13) <{static_position = array<i64: 0, 0>}> : (i8, vector<2x4xi8>) -> vector<2x4xi8>
    %19 = "arith.constant"() <{value = 1 : index}> : () -> index
    %20 = "affine.apply"(%11) <{map = #map3}> : (index) -> index
    %21 = "affine.apply"(%11) <{map = #map5}> : (index) -> index
    %22 = "memref.load"(%arg1, %21, %20) <{nontemporal = false}> : (memref<128x128xi8, #gpu.address_space<workgroup>>, index, index) -> i8
    %23 = "vector.insert"(%22, %18) <{static_position = array<i64: 0, 1>}> : (i8, vector<2x4xi8>) -> vector<2x4xi8>
    %24 = "arith.constant"() <{value = 2 : index}> : () -> index
    %25 = "affine.apply"(%11) <{map = #map3}> : (index) -> index
    %26 = "affine.apply"(%11) <{map = #map6}> : (index) -> index
    %27 = "memref.load"(%arg1, %26, %25) <{nontemporal = false}> : (memref<128x128xi8, #gpu.address_space<workgroup>>, index, index) -> i8
    %28 = "vector.insert"(%27, %23) <{static_position = array<i64: 0, 2>}> : (i8, vector<2x4xi8>) -> vector<2x4xi8>
    %29 = "arith.constant"() <{value = 3 : index}> : () -> index
    %30 = "affine.apply"(%11) <{map = #map3}> : (index) -> index
    %31 = "affine.apply"(%11) <{map = #map7}> : (index) -> index
    %32 = "memref.load"(%arg1, %31, %30) <{nontemporal = false}> : (memref<128x128xi8, #gpu.address_space<workgroup>>, index, index) -> i8
    %33 = "vector.insert"(%32, %28) <{static_position = array<i64: 0, 3>}> : (i8, vector<2x4xi8>) -> vector<2x4xi8>
    %34 = "arith.constant"() <{value = 4 : index}> : () -> index
    %35 = "affine.apply"(%11) <{map = #map3}> : (index) -> index
    %36 = "affine.apply"(%11) <{map = #map8}> : (index) -> index
    %37 = "memref.load"(%arg1, %36, %35) <{nontemporal = false}> : (memref<128x128xi8, #gpu.address_space<workgroup>>, index, index) -> i8
    %38 = "vector.insert"(%37, %33) <{static_position = array<i64: 1, 0>}> : (i8, vector<2x4xi8>) -> vector<2x4xi8>
    %39 = "arith.constant"() <{value = 5 : index}> : () -> index
    %40 = "affine.apply"(%11) <{map = #map3}> : (index) -> index
    %41 = "affine.apply"(%11) <{map = #map9}> : (index) -> index
    %42 = "memref.load"(%arg1, %41, %40) <{nontemporal = false}> : (memref<128x128xi8, #gpu.address_space<workgroup>>, index, index) -> i8
    %43 = "vector.insert"(%42, %38) <{static_position = array<i64: 1, 1>}> : (i8, vector<2x4xi8>) -> vector<2x4xi8>
    %44 = "arith.constant"() <{value = 6 : index}> : () -> index
    %45 = "affine.apply"(%11) <{map = #map3}> : (index) -> index
    %46 = "affine.apply"(%11) <{map = #map10}> : (index) -> index
    %47 = "memref.load"(%arg1, %46, %45) <{nontemporal = false}> : (memref<128x128xi8, #gpu.address_space<workgroup>>, index, index) -> i8
    %48 = "vector.insert"(%47, %43) <{static_position = array<i64: 1, 2>}> : (i8, vector<2x4xi8>) -> vector<2x4xi8>
    %49 = "arith.constant"() <{value = 7 : index}> : () -> index
    %50 = "affine.apply"(%11) <{map = #map3}> : (index) -> index
    %51 = "affine.apply"(%11) <{map = #map11}> : (index) -> index
    %52 = "memref.load"(%arg1, %51, %50) <{nontemporal = false}> : (memref<128x128xi8, #gpu.address_space<workgroup>>, index, index) -> i8
    %53 = "vector.insert"(%52, %48) <{static_position = array<i64: 1, 3>}> : (i8, vector<2x4xi8>) -> vector<2x4xi8>
    %54 = "vector.transfer_read"(%arg1, %1, %2, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map12}> : (memref<128x128xi8, #gpu.address_space<workgroup>>, index, index, i8) -> vector<8x32xi8>
    %55 = "gpu.lane_id"() : () -> index
    %56 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %57 = "vector.broadcast"(%56) : (i32) -> vector<2x2xi32>
    %58 = "arith.constant"() <{value = 0 : index}> : () -> index
    %59 = "affine.apply"(%55) <{map = #map13}> : (index) -> index
    %60 = "affine.apply"(%55) <{map = #map14}> : (index) -> index
    %61 = "vector.load"(%arg2, %59, %60) <{nontemporal = false}> : (memref<128x128xi32>, index, index) -> vector<2xi32>
    %62 = "vector.insert"(%61, %57) <{static_position = array<i64: 0>}> : (vector<2xi32>, vector<2x2xi32>) -> vector<2x2xi32>
    %63 = "arith.constant"() <{value = 2 : index}> : () -> index
    %64 = "affine.apply"(%55) <{map = #map15}> : (index) -> index
    %65 = "affine.apply"(%55) <{map = #map14}> : (index) -> index
    %66 = "vector.load"(%arg2, %64, %65) <{nontemporal = false}> : (memref<128x128xi32>, index, index) -> vector<2xi32>
    %67 = "vector.insert"(%66, %62) <{static_position = array<i64: 1>}> : (vector<2xi32>, vector<2x2xi32>) -> vector<2x2xi32>
    %68 = "vector.transfer_read"(%arg2, %3, %2, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<128x128xi32>, index, index, i32) -> vector<16x8xi32>
    %69 = "nvgpu.mma.sync"(%9, %53, %67) <{mmaShape = [16, 8, 32]}> : (vector<4x4xi8>, vector<2x4xi8>, vector<2x2xi32>) -> vector<2x2xi32>
    %70 = "vector.contract"(%10, %54, %68) <{indexing_maps = [#map16, #map17, #map18], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x32xi8>, vector<8x32xi8>, vector<16x8xi32>) -> vector<16x8xi32>
    %71 = "gpu.lane_id"() : () -> index
    %72 = "arith.constant"() <{value = 0 : index}> : () -> index
    %73 = "vector.extract"(%69) <{static_position = array<i64: 0>}> : (vector<2x2xi32>) -> vector<2xi32>
    %74 = "affine.apply"(%71) <{map = #map13}> : (index) -> index
    %75 = "affine.apply"(%71) <{map = #map14}> : (index) -> index
    "vector.store"(%73, %arg2, %74, %75) <{nontemporal = false}> : (vector<2xi32>, memref<128x128xi32>, index, index) -> ()
    %76 = "arith.constant"() <{value = 2 : index}> : () -> index
    %77 = "vector.extract"(%69) <{static_position = array<i64: 1>}> : (vector<2x2xi32>) -> vector<2xi32>
    %78 = "affine.apply"(%71) <{map = #map15}> : (index) -> index
    %79 = "affine.apply"(%71) <{map = #map14}> : (index) -> index
    "vector.store"(%77, %arg2, %78, %79) <{nontemporal = false}> : (vector<2xi32>, memref<128x128xi32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 floordiv 4 + 1)>
#map1 = affine_map<()[s0] -> (s0 mod 4 + 1)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
#map3 = affine_map<()[s0] -> (s0 floordiv 4 + 40)>
#map4 = affine_map<()[s0] -> (s0 mod 4 + 39)>
#map5 = affine_map<(d0, d1) -> (d1, d0)>
#map6 = affine_map<()[s0] -> (s0 floordiv 4 + 49)>
#map7 = affine_map<()[s0] -> (s0 * 2 - (s0 floordiv 4) * 8 + 40)>
#map8 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map9 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map10 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x128xf64>, memref<128x128xf64>, memref<128x128xf64>) -> (), sym_name = "m8n8k4_f64_row_row_row"}> ({
  ^bb0(%arg0: memref<128x128xf64>, %arg1: memref<128x128xf64>, %arg2: memref<128x128xf64>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 39 : index}> : () -> index
    %2 = "arith.constant"() <{value = 40 : index}> : () -> index
    %3 = "arith.constant"() <{value = 49 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0.000000e+00 : f64}> : () -> f64
    %5 = "gpu.lane_id"() : () -> index
    %6 = "arith.constant"() <{value = 0.000000e+00 : f64}> : () -> f64
    %7 = "vector.broadcast"(%6) : (f64) -> vector<1x1xf64>
    %8 = "arith.constant"() <{value = 0 : index}> : () -> index
    %9 = "affine.apply"(%5) <{map = #map}> : (index) -> index
    %10 = "affine.apply"(%5) <{map = #map1}> : (index) -> index
    %11 = "vector.load"(%arg0, %9, %10) <{nontemporal = false}> : (memref<128x128xf64>, index, index) -> vector<1xf64>
    %12 = "vector.insert"(%11, %7) <{static_position = array<i64: 0>}> : (vector<1xf64>, vector<1x1xf64>) -> vector<1x1xf64>
    %13 = "vector.transfer_read"(%arg0, %0, %0, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<128x128xf64>, index, index, f64) -> vector<8x4xf64>
    %14 = "gpu.lane_id"() : () -> index
    %15 = "arith.constant"() <{value = 0.000000e+00 : f64}> : () -> f64
    %16 = "vector.broadcast"(%15) : (f64) -> vector<1x1xf64>
    %17 = "arith.constant"() <{value = 0 : index}> : () -> index
    %18 = "affine.apply"(%14) <{map = #map3}> : (index) -> index
    %19 = "affine.apply"(%14) <{map = #map4}> : (index) -> index
    %20 = "memref.load"(%arg1, %19, %18) <{nontemporal = false}> : (memref<128x128xf64>, index, index) -> f64
    %21 = "vector.insert"(%20, %16) <{static_position = array<i64: 0, 0>}> : (f64, vector<1x1xf64>) -> vector<1x1xf64>
    %22 = "vector.transfer_read"(%arg1, %1, %2, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map5}> : (memref<128x128xf64>, index, index, f64) -> vector<8x4xf64>
    %23 = "gpu.lane_id"() : () -> index
    %24 = "arith.constant"() <{value = 0.000000e+00 : f64}> : () -> f64
    %25 = "vector.broadcast"(%24) : (f64) -> vector<1x2xf64>
    %26 = "arith.constant"() <{value = 0 : index}> : () -> index
    %27 = "affine.apply"(%23) <{map = #map6}> : (index) -> index
    %28 = "affine.apply"(%23) <{map = #map7}> : (index) -> index
    %29 = "vector.load"(%arg2, %27, %28) <{nontemporal = false}> : (memref<128x128xf64>, index, index) -> vector<2xf64>
    %30 = "vector.insert"(%29, %25) <{static_position = array<i64: 0>}> : (vector<2xf64>, vector<1x2xf64>) -> vector<1x2xf64>
    %31 = "vector.transfer_read"(%arg2, %3, %2, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<128x128xf64>, index, index, f64) -> vector<8x8xf64>
    %32 = "nvgpu.mma.sync"(%12, %21, %30) <{mmaShape = [8, 8, 4]}> : (vector<1x1xf64>, vector<1x1xf64>, vector<1x2xf64>) -> vector<1x2xf64>
    %33 = "vector.contract"(%13, %22, %31) <{indexing_maps = [#map8, #map9, #map10], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<8x4xf64>, vector<8x4xf64>, vector<8x8xf64>) -> vector<8x8xf64>
    %34 = "gpu.lane_id"() : () -> index
    %35 = "arith.constant"() <{value = 0 : index}> : () -> index
    %36 = "vector.extract"(%32) <{static_position = array<i64: 0>}> : (vector<1x2xf64>) -> vector<2xf64>
    %37 = "affine.apply"(%34) <{map = #map6}> : (index) -> index
    %38 = "affine.apply"(%34) <{map = #map7}> : (index) -> index
    "vector.store"(%36, %arg2, %37, %38) <{nontemporal = false}> : (vector<2xf64>, memref<128x128xf64>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 mod 16)>
#map1 = affine_map<()[s0] -> ((s0 floordiv 16) * 8)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d1, d0)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map5 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map6 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map7 = affine_map<()[s0] -> (s0 floordiv 4)>
#map8 = affine_map<()[s0] -> (s0 * 2 - (s0 floordiv 4) * 8)>
#map9 = affine_map<()[s0] -> (s0 floordiv 4 + 8)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<20x20xf16, #gpu.address_space<workgroup>>, memref<20x20xf16, #gpu.address_space<workgroup>>, memref<20x20xf16, #gpu.address_space<workgroup>>) -> (), sym_name = "m16n8k16_fp16_row_row_row"}> ({
  ^bb0(%arg0: memref<20x20xf16, #gpu.address_space<workgroup>>, %arg1: memref<20x20xf16, #gpu.address_space<workgroup>>, %arg2: memref<20x20xf16, #gpu.address_space<workgroup>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %2 = "gpu.lane_id"() : () -> index
    %3 = "affine.apply"(%2) <{map = #map}> : (index) -> index
    %4 = "affine.apply"(%2) <{map = #map1}> : (index) -> index
    %5 = "nvgpu.ldmatrix"(%arg0, %3, %4) <{numTiles = 4 : i32, transpose = false}> : (memref<20x20xf16, #gpu.address_space<workgroup>>, index, index) -> vector<4x2xf16>
    %6 = "vector.transfer_read"(%arg0, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<20x20xf16, #gpu.address_space<workgroup>>, index, index, f16) -> vector<16x16xf16>
    %7 = "gpu.lane_id"() : () -> index
    %8 = "affine.apply"(%7) <{map = #map1}> : (index) -> index
    %9 = "affine.apply"(%7) <{map = #map}> : (index) -> index
    %10 = "nvgpu.ldmatrix"(%arg1, %9, %8) <{numTiles = 2 : i32, transpose = true}> : (memref<20x20xf16, #gpu.address_space<workgroup>>, index, index) -> vector<2x2xf16>
    %11 = "vector.transfer_read"(%arg1, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map3}> : (memref<20x20xf16, #gpu.address_space<workgroup>>, index, index, f16) -> vector<8x16xf16>
    %12 = "gpu.lane_id"() : () -> index
    %13 = "affine.apply"(%12) <{map = #map}> : (index) -> index
    %14 = "affine.apply"(%12) <{map = #map1}> : (index) -> index
    %15 = "nvgpu.ldmatrix"(%arg2, %13, %14) <{numTiles = 2 : i32, transpose = false}> : (memref<20x20xf16, #gpu.address_space<workgroup>>, index, index) -> vector<2x2xf16>
    %16 = "vector.transfer_read"(%arg2, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<20x20xf16, #gpu.address_space<workgroup>>, index, index, f16) -> vector<16x8xf16>
    %17 = "nvgpu.mma.sync"(%5, %10, %15) <{mmaShape = [16, 8, 16]}> : (vector<4x2xf16>, vector<2x2xf16>, vector<2x2xf16>) -> vector<2x2xf16>
    %18 = "vector.contract"(%6, %11, %16) <{indexing_maps = [#map4, #map5, #map6], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf16>, vector<8x16xf16>, vector<16x8xf16>) -> vector<16x8xf16>
    %19 = "gpu.lane_id"() : () -> index
    %20 = "arith.constant"() <{value = 0 : index}> : () -> index
    %21 = "vector.extract"(%17) <{static_position = array<i64: 0>}> : (vector<2x2xf16>) -> vector<2xf16>
    %22 = "affine.apply"(%19) <{map = #map7}> : (index) -> index
    %23 = "affine.apply"(%19) <{map = #map8}> : (index) -> index
    "vector.store"(%21, %arg2, %22, %23) <{nontemporal = false}> : (vector<2xf16>, memref<20x20xf16, #gpu.address_space<workgroup>>, index, index) -> ()
    %24 = "arith.constant"() <{value = 2 : index}> : () -> index
    %25 = "vector.extract"(%17) <{static_position = array<i64: 1>}> : (vector<2x2xf16>) -> vector<2xf16>
    %26 = "affine.apply"(%19) <{map = #map9}> : (index) -> index
    %27 = "affine.apply"(%19) <{map = #map8}> : (index) -> index
    "vector.store"(%25, %arg2, %26, %27) <{nontemporal = false}> : (vector<2xf16>, memref<20x20xf16, #gpu.address_space<workgroup>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 mod 16)>
#map1 = affine_map<()[s0] -> ((s0 floordiv 16) * 8)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d1, d0)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map5 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map6 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map7 = affine_map<()[s0] -> (s0 floordiv 4)>
#map8 = affine_map<()[s0] -> (s0 * 2 - (s0 floordiv 4) * 8)>
#map9 = affine_map<()[s0] -> (s0 floordiv 4 + 8)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<42x32xf16, #gpu.address_space<workgroup>>, memref<32x64xf16, #gpu.address_space<workgroup>>, memref<42x64xf16, #gpu.address_space<workgroup>>) -> (), sym_name = "m16n16k16_mmasync16816_fp16_f16_row_row_row"}> ({
  ^bb0(%arg0: memref<42x32xf16, #gpu.address_space<workgroup>>, %arg1: memref<32x64xf16, #gpu.address_space<workgroup>>, %arg2: memref<42x64xf16, #gpu.address_space<workgroup>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %2 = "gpu.lane_id"() : () -> index
    %3 = "affine.apply"(%2) <{map = #map}> : (index) -> index
    %4 = "affine.apply"(%2) <{map = #map1}> : (index) -> index
    %5 = "nvgpu.ldmatrix"(%arg0, %3, %4) <{numTiles = 4 : i32, transpose = false}> : (memref<42x32xf16, #gpu.address_space<workgroup>>, index, index) -> vector<4x2xf16>
    %6 = "vector.transfer_read"(%arg0, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<42x32xf16, #gpu.address_space<workgroup>>, index, index, f16) -> vector<16x16xf16>
    %7 = "gpu.lane_id"() : () -> index
    %8 = "affine.apply"(%7) <{map = #map1}> : (index) -> index
    %9 = "affine.apply"(%7) <{map = #map}> : (index) -> index
    %10 = "nvgpu.ldmatrix"(%arg1, %9, %8) <{numTiles = 4 : i32, transpose = true}> : (memref<32x64xf16, #gpu.address_space<workgroup>>, index, index) -> vector<4x2xf16>
    %11 = "vector.transfer_read"(%arg1, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map3}> : (memref<32x64xf16, #gpu.address_space<workgroup>>, index, index, f16) -> vector<16x16xf16>
    %12 = "gpu.lane_id"() : () -> index
    %13 = "affine.apply"(%12) <{map = #map}> : (index) -> index
    %14 = "affine.apply"(%12) <{map = #map1}> : (index) -> index
    %15 = "nvgpu.ldmatrix"(%arg2, %13, %14) <{numTiles = 4 : i32, transpose = false}> : (memref<42x64xf16, #gpu.address_space<workgroup>>, index, index) -> vector<4x2xf16>
    %16 = "vector.transfer_read"(%arg2, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<42x64xf16, #gpu.address_space<workgroup>>, index, index, f16) -> vector<16x16xf16>
    %17 = "vector.extract_strided_slice"(%10) <{offsets = [0, 0], sizes = [2, 2], strides = [1, 1]}> : (vector<4x2xf16>) -> vector<2x2xf16>
    %18 = "vector.extract_strided_slice"(%11) <{offsets = [0, 0], sizes = [8, 16], strides = [1, 1]}> : (vector<16x16xf16>) -> vector<8x16xf16>
    %19 = "vector.extract_strided_slice"(%15) <{offsets = [0, 0], sizes = [2, 2], strides = [1, 1]}> : (vector<4x2xf16>) -> vector<2x2xf16>
    %20 = "vector.extract_strided_slice"(%16) <{offsets = [0, 0], sizes = [16, 8], strides = [1, 1]}> : (vector<16x16xf16>) -> vector<16x8xf16>
    %21 = "nvgpu.mma.sync"(%5, %17, %19) <{mmaShape = [16, 8, 16]}> : (vector<4x2xf16>, vector<2x2xf16>, vector<2x2xf16>) -> vector<2x2xf16>
    %22 = "vector.contract"(%6, %18, %20) <{indexing_maps = [#map4, #map5, #map6], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf16>, vector<8x16xf16>, vector<16x8xf16>) -> vector<16x8xf16>
    %23 = "gpu.lane_id"() : () -> index
    %24 = "arith.constant"() <{value = 0 : index}> : () -> index
    %25 = "vector.extract"(%21) <{static_position = array<i64: 0>}> : (vector<2x2xf16>) -> vector<2xf16>
    %26 = "affine.apply"(%23) <{map = #map7}> : (index) -> index
    %27 = "affine.apply"(%23) <{map = #map8}> : (index) -> index
    "vector.store"(%25, %arg2, %26, %27) <{nontemporal = false}> : (vector<2xf16>, memref<42x64xf16, #gpu.address_space<workgroup>>, index, index) -> ()
    %28 = "arith.constant"() <{value = 2 : index}> : () -> index
    %29 = "vector.extract"(%21) <{static_position = array<i64: 1>}> : (vector<2x2xf16>) -> vector<2xf16>
    %30 = "affine.apply"(%23) <{map = #map9}> : (index) -> index
    %31 = "affine.apply"(%23) <{map = #map8}> : (index) -> index
    "vector.store"(%29, %arg2, %30, %31) <{nontemporal = false}> : (vector<2xf16>, memref<42x64xf16, #gpu.address_space<workgroup>>, index, index) -> ()
    %32 = "vector.extract_strided_slice"(%10) <{offsets = [2, 0], sizes = [2, 2], strides = [1, 1]}> : (vector<4x2xf16>) -> vector<2x2xf16>
    %33 = "vector.extract_strided_slice"(%11) <{offsets = [8, 0], sizes = [8, 16], strides = [1, 1]}> : (vector<16x16xf16>) -> vector<8x16xf16>
    %34 = "vector.extract_strided_slice"(%15) <{offsets = [2, 0], sizes = [2, 2], strides = [1, 1]}> : (vector<4x2xf16>) -> vector<2x2xf16>
    %35 = "vector.extract_strided_slice"(%16) <{offsets = [0, 8], sizes = [16, 8], strides = [1, 1]}> : (vector<16x16xf16>) -> vector<16x8xf16>
    %36 = "nvgpu.mma.sync"(%5, %32, %34) <{mmaShape = [16, 8, 16]}> : (vector<4x2xf16>, vector<2x2xf16>, vector<2x2xf16>) -> vector<2x2xf16>
    %37 = "vector.contract"(%6, %33, %35) <{indexing_maps = [#map4, #map5, #map6], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf16>, vector<8x16xf16>, vector<16x8xf16>) -> vector<16x8xf16>
    %38 = "gpu.lane_id"() : () -> index
    %39 = "arith.constant"() <{value = 0 : index}> : () -> index
    %40 = "vector.extract"(%36) <{static_position = array<i64: 0>}> : (vector<2x2xf16>) -> vector<2xf16>
    %41 = "affine.apply"(%38) <{map = #map7}> : (index) -> index
    %42 = "affine.apply"(%38) <{map = #map8}> : (index) -> index
    "vector.store"(%40, %arg2, %41, %42) <{nontemporal = false}> : (vector<2xf16>, memref<42x64xf16, #gpu.address_space<workgroup>>, index, index) -> ()
    %43 = "arith.constant"() <{value = 2 : index}> : () -> index
    %44 = "vector.extract"(%36) <{static_position = array<i64: 1>}> : (vector<2x2xf16>) -> vector<2xf16>
    %45 = "affine.apply"(%38) <{map = #map9}> : (index) -> index
    %46 = "affine.apply"(%38) <{map = #map8}> : (index) -> index
    "vector.store"(%44, %arg2, %45, %46) <{nontemporal = false}> : (vector<2xf16>, memref<42x64xf16, #gpu.address_space<workgroup>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 mod 16)>
#map1 = affine_map<()[s0] -> ((s0 floordiv 16) * 8)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d1, d3)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d3, d2)>
#map4 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map5 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map6 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map7 = affine_map<()[s0] -> (s0 floordiv 4)>
#map8 = affine_map<()[s0] -> (s0 * 2 - (s0 floordiv 4) * 8)>
#map9 = affine_map<()[s0] -> (s0 floordiv 4 + 8)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x32x1x32xf16, #gpu.address_space<workgroup>>, memref<4x1x32x32xf16, #gpu.address_space<workgroup>>, memref<1x32x40xf16, #gpu.address_space<workgroup>>) -> (), sym_name = "multi_dim_m16n8k16_fp16_row_row_row"}> ({
  ^bb0(%arg0: memref<4x32x1x32xf16, #gpu.address_space<workgroup>>, %arg1: memref<4x1x32x32xf16, #gpu.address_space<workgroup>>, %arg2: memref<1x32x40xf16, #gpu.address_space<workgroup>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %2 = "gpu.lane_id"() : () -> index
    %3 = "affine.apply"(%2) <{map = #map}> : (index) -> index
    %4 = "affine.apply"(%2) <{map = #map1}> : (index) -> index
    %5 = "nvgpu.ldmatrix"(%arg0, %0, %3, %0, %4) <{numTiles = 4 : i32, transpose = false}> : (memref<4x32x1x32xf16, #gpu.address_space<workgroup>>, index, index, index, index) -> vector<4x2xf16>
    %6 = "vector.transfer_read"(%arg0, %0, %0, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map2}> : (memref<4x32x1x32xf16, #gpu.address_space<workgroup>>, index, index, index, index, f16) -> vector<16x16xf16>
    %7 = "gpu.lane_id"() : () -> index
    %8 = "affine.apply"(%7) <{map = #map1}> : (index) -> index
    %9 = "affine.apply"(%7) <{map = #map}> : (index) -> index
    %10 = "nvgpu.ldmatrix"(%arg1, %0, %0, %9, %8) <{numTiles = 4 : i32, transpose = true}> : (memref<4x1x32x32xf16, #gpu.address_space<workgroup>>, index, index, index, index) -> vector<4x2xf16>
    %11 = "vector.transfer_read"(%arg1, %0, %0, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map3}> : (memref<4x1x32x32xf16, #gpu.address_space<workgroup>>, index, index, index, index, f16) -> vector<16x16xf16>
    %12 = "gpu.lane_id"() : () -> index
    %13 = "affine.apply"(%12) <{map = #map}> : (index) -> index
    %14 = "affine.apply"(%12) <{map = #map1}> : (index) -> index
    %15 = "nvgpu.ldmatrix"(%arg2, %0, %13, %14) <{numTiles = 4 : i32, transpose = false}> : (memref<1x32x40xf16, #gpu.address_space<workgroup>>, index, index, index) -> vector<4x2xf16>
    %16 = "vector.transfer_read"(%arg2, %0, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map4}> : (memref<1x32x40xf16, #gpu.address_space<workgroup>>, index, index, index, f16) -> vector<16x16xf16>
    %17 = "vector.extract_strided_slice"(%10) <{offsets = [0, 0], sizes = [2, 2], strides = [1, 1]}> : (vector<4x2xf16>) -> vector<2x2xf16>
    %18 = "vector.extract_strided_slice"(%11) <{offsets = [0, 0], sizes = [8, 16], strides = [1, 1]}> : (vector<16x16xf16>) -> vector<8x16xf16>
    %19 = "vector.extract_strided_slice"(%15) <{offsets = [0, 0], sizes = [2, 2], strides = [1, 1]}> : (vector<4x2xf16>) -> vector<2x2xf16>
    %20 = "vector.extract_strided_slice"(%16) <{offsets = [0, 0], sizes = [16, 8], strides = [1, 1]}> : (vector<16x16xf16>) -> vector<16x8xf16>
    %21 = "nvgpu.mma.sync"(%5, %17, %19) <{mmaShape = [16, 8, 16]}> : (vector<4x2xf16>, vector<2x2xf16>, vector<2x2xf16>) -> vector<2x2xf16>
    %22 = "vector.contract"(%6, %18, %20) <{indexing_maps = [#map5, #map4, #map6], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf16>, vector<8x16xf16>, vector<16x8xf16>) -> vector<16x8xf16>
    %23 = "gpu.lane_id"() : () -> index
    %24 = "arith.constant"() <{value = 0 : index}> : () -> index
    %25 = "vector.extract"(%21) <{static_position = array<i64: 0>}> : (vector<2x2xf16>) -> vector<2xf16>
    %26 = "affine.apply"(%23) <{map = #map7}> : (index) -> index
    %27 = "affine.apply"(%23) <{map = #map8}> : (index) -> index
    "vector.store"(%25, %arg2, %0, %26, %27) <{nontemporal = false}> : (vector<2xf16>, memref<1x32x40xf16, #gpu.address_space<workgroup>>, index, index, index) -> ()
    %28 = "arith.constant"() <{value = 2 : index}> : () -> index
    %29 = "vector.extract"(%21) <{static_position = array<i64: 1>}> : (vector<2x2xf16>) -> vector<2xf16>
    %30 = "affine.apply"(%23) <{map = #map9}> : (index) -> index
    %31 = "affine.apply"(%23) <{map = #map8}> : (index) -> index
    "vector.store"(%29, %arg2, %0, %30, %31) <{nontemporal = false}> : (vector<2xf16>, memref<1x32x40xf16, #gpu.address_space<workgroup>>, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 mod 16)>
#map1 = affine_map<()[s0] -> ((s0 floordiv 16) * 8)>
#map2 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map5 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map6 = affine_map<()[s0] -> (s0 floordiv 4)>
#map7 = affine_map<()[s0] -> (s0 * 2 - (s0 floordiv 4) * 8)>
#map8 = affine_map<()[s0] -> (s0 floordiv 4 + 8)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x20x20xf16, #gpu.address_space<workgroup>>, memref<2x20x20xf16, #gpu.address_space<workgroup>>, memref<2x20x20xf16, #gpu.address_space<workgroup>>) -> (), sym_name = "batch_m16n8k16_fp16_row_row_row"}> ({
  ^bb0(%arg0: memref<2x20x20xf16, #gpu.address_space<workgroup>>, %arg1: memref<2x20x20xf16, #gpu.address_space<workgroup>>, %arg2: memref<2x20x20xf16, #gpu.address_space<workgroup>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %2 = "gpu.lane_id"() : () -> index
    %3 = "affine.apply"(%2) <{map = #map}> : (index) -> index
    %4 = "affine.apply"(%2) <{map = #map1}> : (index) -> index
    %5 = "nvgpu.ldmatrix"(%arg0, %0, %3, %4) <{numTiles = 4 : i32, transpose = false}> : (memref<2x20x20xf16, #gpu.address_space<workgroup>>, index, index, index) -> vector<4x2xf16>
    %6 = "vector.transfer_read"(%arg0, %0, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map2}> : (memref<2x20x20xf16, #gpu.address_space<workgroup>>, index, index, index, f16) -> vector<16x16xf16>
    %7 = "gpu.lane_id"() : () -> index
    %8 = "affine.apply"(%7) <{map = #map1}> : (index) -> index
    %9 = "affine.apply"(%7) <{map = #map}> : (index) -> index
    %10 = "nvgpu.ldmatrix"(%arg1, %0, %9, %8) <{numTiles = 2 : i32, transpose = true}> : (memref<2x20x20xf16, #gpu.address_space<workgroup>>, index, index, index) -> vector<2x2xf16>
    %11 = "vector.transfer_read"(%arg1, %0, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map3}> : (memref<2x20x20xf16, #gpu.address_space<workgroup>>, index, index, index, f16) -> vector<8x16xf16>
    %12 = "gpu.lane_id"() : () -> index
    %13 = "affine.apply"(%12) <{map = #map}> : (index) -> index
    %14 = "affine.apply"(%12) <{map = #map1}> : (index) -> index
    %15 = "nvgpu.ldmatrix"(%arg2, %0, %13, %14) <{numTiles = 2 : i32, transpose = false}> : (memref<2x20x20xf16, #gpu.address_space<workgroup>>, index, index, index) -> vector<2x2xf16>
    %16 = "vector.transfer_read"(%arg2, %0, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map2}> : (memref<2x20x20xf16, #gpu.address_space<workgroup>>, index, index, index, f16) -> vector<16x8xf16>
    %17 = "nvgpu.mma.sync"(%5, %10, %15) <{mmaShape = [16, 8, 16]}> : (vector<4x2xf16>, vector<2x2xf16>, vector<2x2xf16>) -> vector<2x2xf16>
    %18 = "vector.contract"(%6, %11, %16) <{indexing_maps = [#map4, #map2, #map5], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf16>, vector<8x16xf16>, vector<16x8xf16>) -> vector<16x8xf16>
    %19 = "gpu.lane_id"() : () -> index
    %20 = "arith.constant"() <{value = 0 : index}> : () -> index
    %21 = "vector.extract"(%17) <{static_position = array<i64: 0>}> : (vector<2x2xf16>) -> vector<2xf16>
    %22 = "affine.apply"(%19) <{map = #map6}> : (index) -> index
    %23 = "affine.apply"(%19) <{map = #map7}> : (index) -> index
    "vector.store"(%21, %arg2, %0, %22, %23) <{nontemporal = false}> : (vector<2xf16>, memref<2x20x20xf16, #gpu.address_space<workgroup>>, index, index, index) -> ()
    %24 = "arith.constant"() <{value = 2 : index}> : () -> index
    %25 = "vector.extract"(%17) <{static_position = array<i64: 1>}> : (vector<2x2xf16>) -> vector<2xf16>
    %26 = "affine.apply"(%19) <{map = #map8}> : (index) -> index
    %27 = "affine.apply"(%19) <{map = #map7}> : (index) -> index
    "vector.store"(%25, %arg2, %0, %26, %27) <{nontemporal = false}> : (vector<2xf16>, memref<2x20x20xf16, #gpu.address_space<workgroup>>, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 mod 16)>
#map1 = affine_map<()[s0] -> ((s0 floordiv 16) * 8)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
#map3 = affine_map<()[s0] -> (s0 mod 8)>
#map4 = affine_map<()[s0] -> ((s0 floordiv 8) * 8)>
#map5 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map6 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map7 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map8 = affine_map<()[s0] -> (s0 floordiv 4)>
#map9 = affine_map<()[s0] -> (s0 * 2 - (s0 floordiv 4) * 8)>
#map10 = affine_map<()[s0] -> (s0 floordiv 4 + 8)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<20x20xf16, #gpu.address_space<workgroup>>, memref<20x20xf16, #gpu.address_space<workgroup>>, memref<20x20xf16, #gpu.address_space<workgroup>>) -> (), sym_name = "m16n8k16_fp16_row_col_row"}> ({
  ^bb0(%arg0: memref<20x20xf16, #gpu.address_space<workgroup>>, %arg1: memref<20x20xf16, #gpu.address_space<workgroup>>, %arg2: memref<20x20xf16, #gpu.address_space<workgroup>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %2 = "gpu.lane_id"() : () -> index
    %3 = "affine.apply"(%2) <{map = #map}> : (index) -> index
    %4 = "affine.apply"(%2) <{map = #map1}> : (index) -> index
    %5 = "nvgpu.ldmatrix"(%arg0, %3, %4) <{numTiles = 4 : i32, transpose = false}> : (memref<20x20xf16, #gpu.address_space<workgroup>>, index, index) -> vector<4x2xf16>
    %6 = "vector.transfer_read"(%arg0, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<20x20xf16, #gpu.address_space<workgroup>>, index, index, f16) -> vector<16x16xf16>
    %7 = "gpu.lane_id"() : () -> index
    %8 = "affine.apply"(%7) <{map = #map3}> : (index) -> index
    %9 = "affine.apply"(%7) <{map = #map4}> : (index) -> index
    %10 = "nvgpu.ldmatrix"(%arg1, %8, %9) <{numTiles = 2 : i32, transpose = false}> : (memref<20x20xf16, #gpu.address_space<workgroup>>, index, index) -> vector<2x2xf16>
    %11 = "vector.transfer_read"(%arg1, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<20x20xf16, #gpu.address_space<workgroup>>, index, index, f16) -> vector<8x16xf16>
    %12 = "gpu.lane_id"() : () -> index
    %13 = "affine.apply"(%12) <{map = #map}> : (index) -> index
    %14 = "affine.apply"(%12) <{map = #map1}> : (index) -> index
    %15 = "nvgpu.ldmatrix"(%arg2, %13, %14) <{numTiles = 2 : i32, transpose = false}> : (memref<20x20xf16, #gpu.address_space<workgroup>>, index, index) -> vector<2x2xf16>
    %16 = "vector.transfer_read"(%arg2, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<20x20xf16, #gpu.address_space<workgroup>>, index, index, f16) -> vector<16x8xf16>
    %17 = "nvgpu.mma.sync"(%5, %10, %15) <{mmaShape = [16, 8, 16]}> : (vector<4x2xf16>, vector<2x2xf16>, vector<2x2xf16>) -> vector<2x2xf16>
    %18 = "vector.contract"(%6, %11, %16) <{indexing_maps = [#map5, #map6, #map7], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf16>, vector<8x16xf16>, vector<16x8xf16>) -> vector<16x8xf16>
    %19 = "gpu.lane_id"() : () -> index
    %20 = "arith.constant"() <{value = 0 : index}> : () -> index
    %21 = "vector.extract"(%17) <{static_position = array<i64: 0>}> : (vector<2x2xf16>) -> vector<2xf16>
    %22 = "affine.apply"(%19) <{map = #map8}> : (index) -> index
    %23 = "affine.apply"(%19) <{map = #map9}> : (index) -> index
    "vector.store"(%21, %arg2, %22, %23) <{nontemporal = false}> : (vector<2xf16>, memref<20x20xf16, #gpu.address_space<workgroup>>, index, index) -> ()
    %24 = "arith.constant"() <{value = 2 : index}> : () -> index
    %25 = "vector.extract"(%17) <{static_position = array<i64: 1>}> : (vector<2x2xf16>) -> vector<2xf16>
    %26 = "affine.apply"(%19) <{map = #map10}> : (index) -> index
    %27 = "affine.apply"(%19) <{map = #map9}> : (index) -> index
    "vector.store"(%25, %arg2, %26, %27) <{nontemporal = false}> : (vector<2xf16>, memref<20x20xf16, #gpu.address_space<workgroup>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 mod 16 + 1)>
#map1 = affine_map<()[s0] -> ((s0 floordiv 16) * 4 + 3)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
#map3 = affine_map<()[s0] -> (s0 floordiv 4 + 3)>
#map4 = affine_map<()[s0] -> (s0 mod 4 + 3)>
#map5 = affine_map<(d0, d1) -> (d1, d0)>
#map6 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map7 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map8 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map9 = affine_map<()[s0] -> (s0 floordiv 4)>
#map10 = affine_map<()[s0] -> (s0 * 2 - (s0 floordiv 4) * 8)>
#map11 = affine_map<()[s0] -> (s0 floordiv 4 + 8)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<20x20xf32, #gpu.address_space<workgroup>>, memref<20x20xf32, #gpu.address_space<workgroup>>, memref<20x20xf32>) -> (), sym_name = "m16n8k4_tf32_f32_row_row_row"}> ({
  ^bb0(%arg0: memref<20x20xf32, #gpu.address_space<workgroup>>, %arg1: memref<20x20xf32, #gpu.address_space<workgroup>>, %arg2: memref<20x20xf32>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2x2xf32>}> : () -> vector<2x2xf32>
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : vector<16x8xf32>}> : () -> vector<16x8xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 3 : index}> : () -> index
    %5 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %6 = "gpu.lane_id"() : () -> index
    %7 = "affine.apply"(%6) <{map = #map}> : (index) -> index
    %8 = "affine.apply"(%6) <{map = #map1}> : (index) -> index
    %9 = "nvgpu.ldmatrix"(%arg0, %7, %8) <{numTiles = 2 : i32, transpose = false}> : (memref<20x20xf32, #gpu.address_space<workgroup>>, index, index) -> vector<2x1xf32>
    %10 = "vector.transfer_read"(%arg0, %3, %4, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<20x20xf32, #gpu.address_space<workgroup>>, index, index, f32) -> vector<16x4xf32>
    %11 = "gpu.lane_id"() : () -> index
    %12 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %13 = "vector.broadcast"(%12) : (f32) -> vector<1x1xf32>
    %14 = "arith.constant"() <{value = 0 : index}> : () -> index
    %15 = "affine.apply"(%11) <{map = #map3}> : (index) -> index
    %16 = "affine.apply"(%11) <{map = #map4}> : (index) -> index
    %17 = "memref.load"(%arg1, %16, %15) <{nontemporal = false}> : (memref<20x20xf32, #gpu.address_space<workgroup>>, index, index) -> f32
    %18 = "vector.insert"(%17, %13) <{static_position = array<i64: 0, 0>}> : (f32, vector<1x1xf32>) -> vector<1x1xf32>
    %19 = "vector.transfer_read"(%arg1, %4, %4, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map5}> : (memref<20x20xf32, #gpu.address_space<workgroup>>, index, index, f32) -> vector<8x4xf32>
    %20 = "nvgpu.mma.sync"(%9, %18, %0) <{mmaShape = [16, 8, 4]}> : (vector<2x1xf32>, vector<1x1xf32>, vector<2x2xf32>) -> vector<2x2xf32>
    %21 = "vector.contract"(%10, %19, %1) <{indexing_maps = [#map6, #map7, #map8], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x4xf32>, vector<8x4xf32>, vector<16x8xf32>) -> vector<16x8xf32>
    %22 = "gpu.lane_id"() : () -> index
    %23 = "arith.constant"() <{value = 0 : index}> : () -> index
    %24 = "vector.extract"(%20) <{static_position = array<i64: 0>}> : (vector<2x2xf32>) -> vector<2xf32>
    %25 = "affine.apply"(%22) <{map = #map9}> : (index) -> index
    %26 = "affine.apply"(%22) <{map = #map10}> : (index) -> index
    "vector.store"(%24, %arg2, %25, %26) <{nontemporal = false}> : (vector<2xf32>, memref<20x20xf32>, index, index) -> ()
    %27 = "arith.constant"() <{value = 2 : index}> : () -> index
    %28 = "vector.extract"(%20) <{static_position = array<i64: 1>}> : (vector<2x2xf32>) -> vector<2xf32>
    %29 = "affine.apply"(%22) <{map = #map11}> : (index) -> index
    %30 = "affine.apply"(%22) <{map = #map10}> : (index) -> index
    "vector.store"(%28, %arg2, %29, %30) <{nontemporal = false}> : (vector<2xf32>, memref<20x20xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 mod 16 + 1)>
#map1 = affine_map<()[s0] -> ((s0 floordiv 16) * 4 + 3)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
#map3 = affine_map<()[s0] -> (s0 floordiv 4 + 3)>
#map4 = affine_map<()[s0] -> (s0 mod 4 + 3)>
#map5 = affine_map<()[s0] -> (s0 mod 4 + 7)>
#map6 = affine_map<(d0, d1) -> (d1, d0)>
#map7 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map8 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map9 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map10 = affine_map<()[s0] -> (s0 floordiv 4)>
#map11 = affine_map<()[s0] -> (s0 * 2 - (s0 floordiv 4) * 8)>
#map12 = affine_map<()[s0] -> (s0 floordiv 4 + 8)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<20x20xf32, #gpu.address_space<workgroup>>, memref<20x20xf32, #gpu.address_space<workgroup>>, memref<20x20xf32>) -> (), sym_name = "m16n8k8_tf32_f32_row_row_row"}> ({
  ^bb0(%arg0: memref<20x20xf32, #gpu.address_space<workgroup>>, %arg1: memref<20x20xf32, #gpu.address_space<workgroup>>, %arg2: memref<20x20xf32>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2x2xf32>}> : () -> vector<2x2xf32>
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : vector<16x8xf32>}> : () -> vector<16x8xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 3 : index}> : () -> index
    %5 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %6 = "gpu.lane_id"() : () -> index
    %7 = "affine.apply"(%6) <{map = #map}> : (index) -> index
    %8 = "affine.apply"(%6) <{map = #map1}> : (index) -> index
    %9 = "nvgpu.ldmatrix"(%arg0, %7, %8) <{numTiles = 4 : i32, transpose = false}> : (memref<20x20xf32, #gpu.address_space<workgroup>>, index, index) -> vector<4x1xf32>
    %10 = "vector.transfer_read"(%arg0, %3, %4, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<20x20xf32, #gpu.address_space<workgroup>>, index, index, f32) -> vector<16x8xf32>
    %11 = "gpu.lane_id"() : () -> index
    %12 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %13 = "vector.broadcast"(%12) : (f32) -> vector<2x1xf32>
    %14 = "arith.constant"() <{value = 0 : index}> : () -> index
    %15 = "affine.apply"(%11) <{map = #map3}> : (index) -> index
    %16 = "affine.apply"(%11) <{map = #map4}> : (index) -> index
    %17 = "memref.load"(%arg1, %16, %15) <{nontemporal = false}> : (memref<20x20xf32, #gpu.address_space<workgroup>>, index, index) -> f32
    %18 = "vector.insert"(%17, %13) <{static_position = array<i64: 0, 0>}> : (f32, vector<2x1xf32>) -> vector<2x1xf32>
    %19 = "arith.constant"() <{value = 1 : index}> : () -> index
    %20 = "affine.apply"(%11) <{map = #map3}> : (index) -> index
    %21 = "affine.apply"(%11) <{map = #map5}> : (index) -> index
    %22 = "memref.load"(%arg1, %21, %20) <{nontemporal = false}> : (memref<20x20xf32, #gpu.address_space<workgroup>>, index, index) -> f32
    %23 = "vector.insert"(%22, %18) <{static_position = array<i64: 1, 0>}> : (f32, vector<2x1xf32>) -> vector<2x1xf32>
    %24 = "vector.transfer_read"(%arg1, %4, %4, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map6}> : (memref<20x20xf32, #gpu.address_space<workgroup>>, index, index, f32) -> vector<8x8xf32>
    %25 = "nvgpu.mma.sync"(%9, %23, %0) <{mmaShape = [16, 8, 8]}> : (vector<4x1xf32>, vector<2x1xf32>, vector<2x2xf32>) -> vector<2x2xf32>
    %26 = "vector.contract"(%10, %24, %1) <{indexing_maps = [#map7, #map8, #map9], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x8xf32>, vector<8x8xf32>, vector<16x8xf32>) -> vector<16x8xf32>
    %27 = "gpu.lane_id"() : () -> index
    %28 = "arith.constant"() <{value = 0 : index}> : () -> index
    %29 = "vector.extract"(%25) <{static_position = array<i64: 0>}> : (vector<2x2xf32>) -> vector<2xf32>
    %30 = "affine.apply"(%27) <{map = #map10}> : (index) -> index
    %31 = "affine.apply"(%27) <{map = #map11}> : (index) -> index
    "vector.store"(%29, %arg2, %30, %31) <{nontemporal = false}> : (vector<2xf32>, memref<20x20xf32>, index, index) -> ()
    %32 = "arith.constant"() <{value = 2 : index}> : () -> index
    %33 = "vector.extract"(%25) <{static_position = array<i64: 1>}> : (vector<2x2xf32>) -> vector<2xf32>
    %34 = "affine.apply"(%27) <{map = #map12}> : (index) -> index
    %35 = "affine.apply"(%27) <{map = #map11}> : (index) -> index
    "vector.store"(%33, %arg2, %34, %35) <{nontemporal = false}> : (vector<2xf32>, memref<20x20xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 floordiv 4)>
#map1 = affine_map<()[s0] -> (s0 mod 4)>
#map2 = affine_map<()[s0] -> (s0 floordiv 4 + 8)>
#map3 = affine_map<()[s0] -> (s0 mod 4 + 4)>
#map4 = affine_map<(d0, d1) -> (d1, d0)>
#map5 = affine_map<()[s0] -> (s0 mod 8)>
#map6 = affine_map<()[s0] -> ((s0 floordiv 8) * 4)>
#map7 = affine_map<(d0, d1) -> (d0, d1)>
#map8 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map9 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map10 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map11 = affine_map<()[s0] -> (s0 floordiv 4 + 16)>
#map12 = affine_map<()[s0] -> (s0 * 2 - (s0 floordiv 4) * 8 + 8)>
#map13 = affine_map<()[s0] -> (s0 floordiv 4 + 24)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<20x20xf32, #gpu.address_space<workgroup>>, memref<20x20xf32, #gpu.address_space<workgroup>>, memref<20x20xf32>) -> (), sym_name = "m16n8k8_tf32_f32_col_col_row"}> ({
  ^bb0(%arg0: memref<20x20xf32, #gpu.address_space<workgroup>>, %arg1: memref<20x20xf32, #gpu.address_space<workgroup>>, %arg2: memref<20x20xf32>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2x2xf32>}> : () -> vector<2x2xf32>
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : vector<16x8xf32>}> : () -> vector<16x8xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 16 : index}> : () -> index
    %4 = "arith.constant"() <{value = 8 : index}> : () -> index
    %5 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %6 = "gpu.lane_id"() : () -> index
    %7 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %8 = "vector.broadcast"(%7) : (f32) -> vector<4x1xf32>
    %9 = "arith.constant"() <{value = 0 : index}> : () -> index
    %10 = "affine.apply"(%6) <{map = #map}> : (index) -> index
    %11 = "affine.apply"(%6) <{map = #map1}> : (index) -> index
    %12 = "memref.load"(%arg0, %11, %10) <{nontemporal = false}> : (memref<20x20xf32, #gpu.address_space<workgroup>>, index, index) -> f32
    %13 = "vector.insert"(%12, %8) <{static_position = array<i64: 0, 0>}> : (f32, vector<4x1xf32>) -> vector<4x1xf32>
    %14 = "arith.constant"() <{value = 1 : index}> : () -> index
    %15 = "affine.apply"(%6) <{map = #map2}> : (index) -> index
    %16 = "affine.apply"(%6) <{map = #map1}> : (index) -> index
    %17 = "memref.load"(%arg0, %16, %15) <{nontemporal = false}> : (memref<20x20xf32, #gpu.address_space<workgroup>>, index, index) -> f32
    %18 = "vector.insert"(%17, %13) <{static_position = array<i64: 1, 0>}> : (f32, vector<4x1xf32>) -> vector<4x1xf32>
    %19 = "arith.constant"() <{value = 2 : index}> : () -> index
    %20 = "affine.apply"(%6) <{map = #map}> : (index) -> index
    %21 = "affine.apply"(%6) <{map = #map3}> : (index) -> index
    %22 = "memref.load"(%arg0, %21, %20) <{nontemporal = false}> : (memref<20x20xf32, #gpu.address_space<workgroup>>, index, index) -> f32
    %23 = "vector.insert"(%22, %18) <{static_position = array<i64: 2, 0>}> : (f32, vector<4x1xf32>) -> vector<4x1xf32>
    %24 = "arith.constant"() <{value = 3 : index}> : () -> index
    %25 = "affine.apply"(%6) <{map = #map2}> : (index) -> index
    %26 = "affine.apply"(%6) <{map = #map3}> : (index) -> index
    %27 = "memref.load"(%arg0, %26, %25) <{nontemporal = false}> : (memref<20x20xf32, #gpu.address_space<workgroup>>, index, index) -> f32
    %28 = "vector.insert"(%27, %23) <{static_position = array<i64: 3, 0>}> : (f32, vector<4x1xf32>) -> vector<4x1xf32>
    %29 = "vector.transfer_read"(%arg0, %2, %2, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map4}> : (memref<20x20xf32, #gpu.address_space<workgroup>>, index, index, f32) -> vector<16x8xf32>
    %30 = "gpu.lane_id"() : () -> index
    %31 = "affine.apply"(%30) <{map = #map5}> : (index) -> index
    %32 = "affine.apply"(%30) <{map = #map6}> : (index) -> index
    %33 = "nvgpu.ldmatrix"(%arg1, %31, %32) <{numTiles = 2 : i32, transpose = false}> : (memref<20x20xf32, #gpu.address_space<workgroup>>, index, index) -> vector<2x1xf32>
    %34 = "vector.transfer_read"(%arg1, %2, %2, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map7}> : (memref<20x20xf32, #gpu.address_space<workgroup>>, index, index, f32) -> vector<8x8xf32>
    %35 = "nvgpu.mma.sync"(%28, %33, %0) <{mmaShape = [16, 8, 8]}> : (vector<4x1xf32>, vector<2x1xf32>, vector<2x2xf32>) -> vector<2x2xf32>
    %36 = "vector.contract"(%29, %34, %1) <{indexing_maps = [#map8, #map9, #map10], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x8xf32>, vector<8x8xf32>, vector<16x8xf32>) -> vector<16x8xf32>
    %37 = "gpu.lane_id"() : () -> index
    %38 = "arith.constant"() <{value = 0 : index}> : () -> index
    %39 = "vector.extract"(%35) <{static_position = array<i64: 0>}> : (vector<2x2xf32>) -> vector<2xf32>
    %40 = "affine.apply"(%37) <{map = #map11}> : (index) -> index
    %41 = "affine.apply"(%37) <{map = #map12}> : (index) -> index
    "vector.store"(%39, %arg2, %40, %41) <{nontemporal = false}> : (vector<2xf32>, memref<20x20xf32>, index, index) -> ()
    %42 = "arith.constant"() <{value = 2 : index}> : () -> index
    %43 = "vector.extract"(%35) <{static_position = array<i64: 1>}> : (vector<2x2xf32>) -> vector<2xf32>
    %44 = "affine.apply"(%37) <{map = #map13}> : (index) -> index
    %45 = "affine.apply"(%37) <{map = #map12}> : (index) -> index
    "vector.store"(%43, %arg2, %44, %45) <{nontemporal = false}> : (vector<2xf32>, memref<20x20xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 mod 16)>
#map1 = affine_map<()[s0] -> ((s0 floordiv 16) * 32)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
#map3 = affine_map<()[s0] -> (s0 mod 8)>
#map4 = affine_map<()[s0] -> ((s0 floordiv 8) * 32)>
#map5 = affine_map<()[s0] -> (s0 floordiv 4)>
#map6 = affine_map<()[s0] -> (s0 * 2 - (s0 floordiv 4) * 8)>
#map7 = affine_map<()[s0] -> (s0 floordiv 4 + 8)>
#map8 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map9 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map10 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x128xi4, #gpu.address_space<workgroup>>, memref<128x128xi4, #gpu.address_space<workgroup>>, memref<128x128xi32>) -> (), sym_name = "m16n8k64_int4_row_col_row"}> ({
  ^bb0(%arg0: memref<128x128xi4, #gpu.address_space<workgroup>>, %arg1: memref<128x128xi4, #gpu.address_space<workgroup>>, %arg2: memref<128x128xi32>):
    %0 = "arith.constant"() <{value = 0 : i4}> : () -> i4
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "gpu.lane_id"() : () -> index
    %4 = "affine.apply"(%3) <{map = #map}> : (index) -> index
    %5 = "affine.apply"(%3) <{map = #map1}> : (index) -> index
    %6 = "nvgpu.ldmatrix"(%arg0, %4, %5) <{numTiles = 4 : i32, transpose = false}> : (memref<128x128xi4, #gpu.address_space<workgroup>>, index, index) -> vector<4x8xi4>
    %7 = "vector.transfer_read"(%arg0, %2, %2, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<128x128xi4, #gpu.address_space<workgroup>>, index, index, i4) -> vector<16x64xi4>
    %8 = "gpu.lane_id"() : () -> index
    %9 = "affine.apply"(%8) <{map = #map3}> : (index) -> index
    %10 = "affine.apply"(%8) <{map = #map4}> : (index) -> index
    %11 = "nvgpu.ldmatrix"(%arg1, %9, %10) <{numTiles = 2 : i32, transpose = false}> : (memref<128x128xi4, #gpu.address_space<workgroup>>, index, index) -> vector<2x8xi4>
    %12 = "vector.transfer_read"(%arg1, %2, %2, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<128x128xi4, #gpu.address_space<workgroup>>, index, index, i4) -> vector<8x64xi4>
    %13 = "gpu.lane_id"() : () -> index
    %14 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %15 = "vector.broadcast"(%14) : (i32) -> vector<2x2xi32>
    %16 = "arith.constant"() <{value = 0 : index}> : () -> index
    %17 = "affine.apply"(%13) <{map = #map5}> : (index) -> index
    %18 = "affine.apply"(%13) <{map = #map6}> : (index) -> index
    %19 = "vector.load"(%arg2, %17, %18) <{nontemporal = false}> : (memref<128x128xi32>, index, index) -> vector<2xi32>
    %20 = "vector.insert"(%19, %15) <{static_position = array<i64: 0>}> : (vector<2xi32>, vector<2x2xi32>) -> vector<2x2xi32>
    %21 = "arith.constant"() <{value = 2 : index}> : () -> index
    %22 = "affine.apply"(%13) <{map = #map7}> : (index) -> index
    %23 = "affine.apply"(%13) <{map = #map6}> : (index) -> index
    %24 = "vector.load"(%arg2, %22, %23) <{nontemporal = false}> : (memref<128x128xi32>, index, index) -> vector<2xi32>
    %25 = "vector.insert"(%24, %20) <{static_position = array<i64: 1>}> : (vector<2xi32>, vector<2x2xi32>) -> vector<2x2xi32>
    %26 = "vector.transfer_read"(%arg2, %2, %2, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<128x128xi32>, index, index, i32) -> vector<16x8xi32>
    %27 = "nvgpu.mma.sync"(%6, %11, %25) <{mmaShape = [16, 8, 64]}> : (vector<4x8xi4>, vector<2x8xi4>, vector<2x2xi32>) -> vector<2x2xi32>
    %28 = "vector.contract"(%7, %12, %26) <{indexing_maps = [#map8, #map9, #map10], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x64xi4>, vector<8x64xi4>, vector<16x8xi32>) -> vector<16x8xi32>
    %29 = "gpu.lane_id"() : () -> index
    %30 = "arith.constant"() <{value = 0 : index}> : () -> index
    %31 = "vector.extract"(%27) <{static_position = array<i64: 0>}> : (vector<2x2xi32>) -> vector<2xi32>
    %32 = "affine.apply"(%29) <{map = #map5}> : (index) -> index
    %33 = "affine.apply"(%29) <{map = #map6}> : (index) -> index
    "vector.store"(%31, %arg2, %32, %33) <{nontemporal = false}> : (vector<2xi32>, memref<128x128xi32>, index, index) -> ()
    %34 = "arith.constant"() <{value = 2 : index}> : () -> index
    %35 = "vector.extract"(%27) <{static_position = array<i64: 1>}> : (vector<2x2xi32>) -> vector<2xi32>
    %36 = "affine.apply"(%29) <{map = #map7}> : (index) -> index
    %37 = "affine.apply"(%29) <{map = #map6}> : (index) -> index
    "vector.store"(%35, %arg2, %36, %37) <{nontemporal = false}> : (vector<2xi32>, memref<128x128xi32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 mod 16)>
#map1 = affine_map<()[s0] -> ((s0 floordiv 16) * 16)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
#map3 = affine_map<()[s0] -> (s0 mod 8)>
#map4 = affine_map<()[s0] -> ((s0 floordiv 8) * 16)>
#map5 = affine_map<()[s0] -> (s0 floordiv 4)>
#map6 = affine_map<()[s0] -> (s0 * 2 - (s0 floordiv 4) * 8)>
#map7 = affine_map<()[s0] -> (s0 floordiv 4 + 8)>
#map8 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map9 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map10 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x128xi8, #gpu.address_space<workgroup>>, memref<128x128xi8, #gpu.address_space<workgroup>>, memref<128x128xi32>) -> (), sym_name = "m16n8k32_int8_row_col_row"}> ({
  ^bb0(%arg0: memref<128x128xi8, #gpu.address_space<workgroup>>, %arg1: memref<128x128xi8, #gpu.address_space<workgroup>>, %arg2: memref<128x128xi32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %2 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "gpu.lane_id"() : () -> index
    %4 = "affine.apply"(%3) <{map = #map}> : (index) -> index
    %5 = "affine.apply"(%3) <{map = #map1}> : (index) -> index
    %6 = "nvgpu.ldmatrix"(%arg0, %4, %5) <{numTiles = 4 : i32, transpose = false}> : (memref<128x128xi8, #gpu.address_space<workgroup>>, index, index) -> vector<4x4xi8>
    %7 = "vector.transfer_read"(%arg0, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<128x128xi8, #gpu.address_space<workgroup>>, index, index, i8) -> vector<16x32xi8>
    %8 = "gpu.lane_id"() : () -> index
    %9 = "affine.apply"(%8) <{map = #map3}> : (index) -> index
    %10 = "affine.apply"(%8) <{map = #map4}> : (index) -> index
    %11 = "nvgpu.ldmatrix"(%arg1, %9, %10) <{numTiles = 2 : i32, transpose = false}> : (memref<128x128xi8, #gpu.address_space<workgroup>>, index, index) -> vector<2x4xi8>
    %12 = "vector.transfer_read"(%arg1, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<128x128xi8, #gpu.address_space<workgroup>>, index, index, i8) -> vector<8x32xi8>
    %13 = "gpu.lane_id"() : () -> index
    %14 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %15 = "vector.broadcast"(%14) : (i32) -> vector<2x2xi32>
    %16 = "arith.constant"() <{value = 0 : index}> : () -> index
    %17 = "affine.apply"(%13) <{map = #map5}> : (index) -> index
    %18 = "affine.apply"(%13) <{map = #map6}> : (index) -> index
    %19 = "vector.load"(%arg2, %17, %18) <{nontemporal = false}> : (memref<128x128xi32>, index, index) -> vector<2xi32>
    %20 = "vector.insert"(%19, %15) <{static_position = array<i64: 0>}> : (vector<2xi32>, vector<2x2xi32>) -> vector<2x2xi32>
    %21 = "arith.constant"() <{value = 2 : index}> : () -> index
    %22 = "affine.apply"(%13) <{map = #map7}> : (index) -> index
    %23 = "affine.apply"(%13) <{map = #map6}> : (index) -> index
    %24 = "vector.load"(%arg2, %22, %23) <{nontemporal = false}> : (memref<128x128xi32>, index, index) -> vector<2xi32>
    %25 = "vector.insert"(%24, %20) <{static_position = array<i64: 1>}> : (vector<2xi32>, vector<2x2xi32>) -> vector<2x2xi32>
    %26 = "vector.transfer_read"(%arg2, %0, %0, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<128x128xi32>, index, index, i32) -> vector<16x8xi32>
    %27 = "nvgpu.mma.sync"(%6, %11, %25) <{mmaShape = [16, 8, 32]}> : (vector<4x4xi8>, vector<2x4xi8>, vector<2x2xi32>) -> vector<2x2xi32>
    %28 = "vector.contract"(%7, %12, %26) <{indexing_maps = [#map8, #map9, #map10], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x32xi8>, vector<8x32xi8>, vector<16x8xi32>) -> vector<16x8xi32>
    %29 = "gpu.lane_id"() : () -> index
    %30 = "arith.constant"() <{value = 0 : index}> : () -> index
    %31 = "vector.extract"(%27) <{static_position = array<i64: 0>}> : (vector<2x2xi32>) -> vector<2xi32>
    %32 = "affine.apply"(%29) <{map = #map5}> : (index) -> index
    %33 = "affine.apply"(%29) <{map = #map6}> : (index) -> index
    "vector.store"(%31, %arg2, %32, %33) <{nontemporal = false}> : (vector<2xi32>, memref<128x128xi32>, index, index) -> ()
    %34 = "arith.constant"() <{value = 2 : index}> : () -> index
    %35 = "vector.extract"(%27) <{static_position = array<i64: 1>}> : (vector<2x2xi32>) -> vector<2xi32>
    %36 = "affine.apply"(%29) <{map = #map7}> : (index) -> index
    %37 = "affine.apply"(%29) <{map = #map6}> : (index) -> index
    "vector.store"(%35, %arg2, %36, %37) <{nontemporal = false}> : (vector<2xi32>, memref<128x128xi32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 mod 16)>
#map1 = affine_map<()[s0] -> ((s0 floordiv 16) * 8)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d1, d0)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map5 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map6 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map7 = affine_map<()[s0] -> (s0 floordiv 4)>
#map8 = affine_map<()[s0] -> (s0 * 2 - (s0 floordiv 4) * 8)>
#map9 = affine_map<()[s0] -> (s0 floordiv 4 + 8)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>) -> (), sym_name = "strided_memref_read_write"}> ({
  ^bb0(%arg0: memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, %arg1: memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, %arg2: memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %2 = "gpu.lane_id"() : () -> index
    %3 = "affine.apply"(%2) <{map = #map}> : (index) -> index
    %4 = "affine.apply"(%2) <{map = #map1}> : (index) -> index
    %5 = "nvgpu.ldmatrix"(%arg0, %3, %4) <{numTiles = 4 : i32, transpose = false}> : (memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, index, index) -> vector<4x2xf16>
    %6 = "vector.transfer_read"(%arg0, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, index, index, f16) -> vector<16x16xf16>
    %7 = "gpu.lane_id"() : () -> index
    %8 = "affine.apply"(%7) <{map = #map1}> : (index) -> index
    %9 = "affine.apply"(%7) <{map = #map}> : (index) -> index
    %10 = "nvgpu.ldmatrix"(%arg1, %9, %8) <{numTiles = 2 : i32, transpose = true}> : (memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, index, index) -> vector<2x2xf16>
    %11 = "vector.transfer_read"(%arg1, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map3}> : (memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, index, index, f16) -> vector<8x16xf16>
    %12 = "gpu.lane_id"() : () -> index
    %13 = "affine.apply"(%12) <{map = #map}> : (index) -> index
    %14 = "affine.apply"(%12) <{map = #map1}> : (index) -> index
    %15 = "nvgpu.ldmatrix"(%arg2, %13, %14) <{numTiles = 2 : i32, transpose = false}> : (memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, index, index) -> vector<2x2xf16>
    %16 = "vector.transfer_read"(%arg2, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, index, index, f16) -> vector<16x8xf16>
    %17 = "nvgpu.mma.sync"(%5, %10, %15) <{mmaShape = [16, 8, 16]}> : (vector<4x2xf16>, vector<2x2xf16>, vector<2x2xf16>) -> vector<2x2xf16>
    %18 = "vector.contract"(%6, %11, %16) <{indexing_maps = [#map4, #map5, #map6], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf16>, vector<8x16xf16>, vector<16x8xf16>) -> vector<16x8xf16>
    %19 = "gpu.lane_id"() : () -> index
    %20 = "arith.constant"() <{value = 0 : index}> : () -> index
    %21 = "vector.extract"(%17) <{static_position = array<i64: 0>}> : (vector<2x2xf16>) -> vector<2xf16>
    %22 = "affine.apply"(%19) <{map = #map7}> : (index) -> index
    %23 = "affine.apply"(%19) <{map = #map8}> : (index) -> index
    "vector.store"(%21, %arg2, %22, %23) <{nontemporal = false}> : (vector<2xf16>, memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, index, index) -> ()
    %24 = "arith.constant"() <{value = 2 : index}> : () -> index
    %25 = "vector.extract"(%17) <{static_position = array<i64: 1>}> : (vector<2x2xf16>) -> vector<2xf16>
    %26 = "affine.apply"(%19) <{map = #map9}> : (index) -> index
    %27 = "affine.apply"(%19) <{map = #map8}> : (index) -> index
    "vector.store"(%25, %arg2, %26, %27) <{nontemporal = false}> : (vector<2xf16>, memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d2, d0, d3)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<20x20x20xf16, strided<[?, ?, 1], offset: ?>, #gpu.address_space<workgroup>>, memref<20x20x20xf16, strided<[?, ?, 1], offset: ?>, #gpu.address_space<workgroup>>, memref<20x20x20xf16, strided<[?, ?, 1], offset: ?>, #gpu.address_space<workgroup>>) -> (), sym_name = "unsupported_non_2d_load_store"}> ({
  ^bb0(%arg0: memref<20x20x20xf16, strided<[?, ?, 1], offset: ?>, #gpu.address_space<workgroup>>, %arg1: memref<20x20x20xf16, strided<[?, ?, 1], offset: ?>, #gpu.address_space<workgroup>>, %arg2: memref<20x20x20xf16, strided<[?, ?, 1], offset: ?>, #gpu.address_space<workgroup>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %2 = "vector.transfer_read"(%arg0, %0, %0, %0, %1) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<20x20x20xf16, strided<[?, ?, 1], offset: ?>, #gpu.address_space<workgroup>>, index, index, index, f16) -> vector<1x16x16xf16>
    %3 = "vector.transfer_read"(%arg1, %0, %0, %0, %1) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<20x20x20xf16, strided<[?, ?, 1], offset: ?>, #gpu.address_space<workgroup>>, index, index, index, f16) -> vector<8x1x16xf16>
    %4 = "vector.transfer_read"(%arg2, %0, %0, %0, %1) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<20x20x20xf16, strided<[?, ?, 1], offset: ?>, #gpu.address_space<workgroup>>, index, index, index, f16) -> vector<1x16x8xf16>
    %5 = "vector.contract"(%2, %3, %4) <{indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x16x16xf16>, vector<8x1x16xf16>, vector<1x16x8xf16>) -> vector<1x16x8xf16>
    "vector.transfer_write"(%5, %arg2, %0, %0, %0) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 1, 3, 0>, permutation_map = #map}> : (vector<1x16x8xf16>, memref<20x20x20xf16, strided<[?, ?, 1], offset: ?>, #gpu.address_space<workgroup>>, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1, d0)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<20x20xf16, strided<[?, ?], offset: ?>, #gpu.address_space<workgroup>>, memref<20x20xf16, strided<[?, ?], offset: ?>, #gpu.address_space<workgroup>>, memref<20x20xf16, strided<[?, ?], offset: ?>, #gpu.address_space<workgroup>>) -> (), sym_name = "unsupported_fully_dynamic_strides"}> ({
  ^bb0(%arg0: memref<20x20xf16, strided<[?, ?], offset: ?>, #gpu.address_space<workgroup>>, %arg1: memref<20x20xf16, strided<[?, ?], offset: ?>, #gpu.address_space<workgroup>>, %arg2: memref<20x20xf16, strided<[?, ?], offset: ?>, #gpu.address_space<workgroup>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %2 = "vector.transfer_read"(%arg0, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<20x20xf16, strided<[?, ?], offset: ?>, #gpu.address_space<workgroup>>, index, index, f16) -> vector<16x16xf16>
    %3 = "vector.transfer_read"(%arg1, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<20x20xf16, strided<[?, ?], offset: ?>, #gpu.address_space<workgroup>>, index, index, f16) -> vector<8x16xf16>
    %4 = "vector.transfer_read"(%arg2, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<20x20xf16, strided<[?, ?], offset: ?>, #gpu.address_space<workgroup>>, index, index, f16) -> vector<16x8xf16>
    %5 = "vector.contract"(%2, %3, %4) <{indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf16>, vector<8x16xf16>, vector<16x8xf16>) -> vector<16x8xf16>
    "vector.transfer_write"(%5, %arg2, %0, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x8xf16>, memref<20x20xf16, strided<[?, ?], offset: ?>, #gpu.address_space<workgroup>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1, d0)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>) -> (), sym_name = "unsupported_transposed_store"}> ({
  ^bb0(%arg0: memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, %arg1: memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, %arg2: memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %2 = "vector.transfer_read"(%arg0, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, index, index, f16) -> vector<16x16xf16>
    %3 = "vector.transfer_read"(%arg1, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, index, index, f16) -> vector<8x16xf16>
    %4 = "vector.transfer_read"(%arg2, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, index, index, f16) -> vector<16x8xf16>
    %5 = "vector.contract"(%2, %3, %4) <{indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf16>, vector<8x16xf16>, vector<16x8xf16>) -> vector<16x8xf16>
    "vector.transfer_write"(%5, %arg2, %0, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<16x8xf16>, memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

