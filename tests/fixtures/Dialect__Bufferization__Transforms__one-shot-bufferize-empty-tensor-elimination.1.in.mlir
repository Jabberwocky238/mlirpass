#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map, bufferization.writable = true}, {}], function_type = (tensor<?xf32>, index) -> (tensor<?xf32>, tensor<?xf32>), sym_name = "buffer_forwarding_conflict"}> ({
  ^bb0(%arg103: tensor<?xf32>, %arg104: index):
    %124 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %125 = "tensor.empty"(%arg104) : (index) -> tensor<?xf32>
    %126 = "linalg.fill"(%124, %125) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg105: f32, %arg106: f32):
      "linalg.yield"(%arg105) : (f32) -> ()
    }) : (f32, tensor<?xf32>) -> tensor<?xf32>
    %127 = "tensor.insert_slice"(%126, %arg103, %arg104) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    %128 = "tensor.insert_slice"(%126, %arg103, %arg104) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 42>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%127, %128) : (tensor<?xf32>, tensor<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map, bufferization.writable = true}, {}], function_type = (tensor<?xf32>, index) -> tensor<?xf32>, sym_name = "buffer_forwarding_no_conflict"}> ({
  ^bb0(%arg99: tensor<?xf32>, %arg100: index):
    %120 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %121 = "tensor.empty"(%arg100) : (index) -> tensor<?xf32>
    %122 = "linalg.fill"(%120, %121) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg101: f32, %arg102: f32):
      "linalg.yield"(%arg101) : (f32) -> ()
    }) : (f32, tensor<?xf32>) -> tensor<?xf32>
    %123 = "tensor.insert_slice"(%122, %arg99, %arg100) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 42>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%123) : (tensor<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?xf32>, index) -> tensor<?xf32>, sym_name = "insertion_point_inside_loop"}> ({
  ^bb0(%arg93: tensor<?xf32>, %arg94: index):
    %111 = "arith.constant"() <{value = 0 : index}> : () -> index
    %112 = "arith.constant"() <{value = 1 : index}> : () -> index
    %113 = "arith.constant"() <{value = 5 : index}> : () -> index
    %114 = "tensor.empty"() : () -> tensor<5xf32>
    %115 = "scf.for"(%111, %arg94, %113, %arg93) ({
    ^bb0(%arg95: index, %arg96: tensor<?xf32>):
      %116 = "arith.index_cast"(%arg95) : (index) -> i32
      %117 = "arith.sitofp"(%116) : (i32) -> f32
      %118 = "linalg.fill"(%117, %114) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg97: f32, %arg98: f32):
        "linalg.yield"(%arg97) : (f32) -> ()
      }) : (f32, tensor<5xf32>) -> tensor<5xf32>
      %119 = "tensor.insert_slice"(%118, %arg96, %arg95) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<?xf32>, index) -> tensor<?xf32>
      "scf.yield"(%119) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%115) : (tensor<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?xf32>, index, index) -> tensor<?xf32>, sym_name = "insertion_point_outside_loop"}> ({
  ^bb0(%arg86: tensor<?xf32>, %arg87: index, %arg88: index):
    %102 = "arith.constant"() <{value = 0 : index}> : () -> index
    %103 = "arith.constant"() <{value = 1 : index}> : () -> index
    %104 = "arith.constant"() <{value = 5 : index}> : () -> index
    %105 = "tensor.empty"() : () -> tensor<5xf32>
    %106 = "scf.for"(%102, %arg87, %104, %arg86) ({
    ^bb0(%arg89: index, %arg90: tensor<?xf32>):
      %107 = "arith.index_cast"(%arg89) : (index) -> i32
      %108 = "arith.sitofp"(%107) : (i32) -> f32
      %109 = "linalg.fill"(%108, %105) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg91: f32, %arg92: f32):
        "linalg.yield"(%arg91) : (f32) -> ()
      }) : (f32, tensor<5xf32>) -> tensor<5xf32>
      %110 = "tensor.insert_slice"(%109, %arg90, %arg88) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<?xf32>, index) -> tensor<?xf32>
      "scf.yield"(%110) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%106) : (tensor<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<5x6x128xf32>) -> tensor<5x6x128xf32>, sym_name = "shape_mismatch"}> ({
  ^bb0(%arg83: tensor<5x6x128xf32>):
    %97 = "arith.constant"() <{value = 8.000000e+00 : f32}> : () -> f32
    %98 = "tensor.empty"() : () -> tensor<128xf32>
    %99 = "linalg.fill"(%97, %98) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg84: f32, %arg85: f32):
      "linalg.yield"(%arg84) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    %100 = "tensor.expand_shape"(%99) <{reassociation = [[0, 1, 2]], static_output_shape = array<i64: 1, 1, 128>}> : (tensor<128xf32>) -> tensor<1x1x128xf32>
    %101 = "tensor.insert_slice"(%100, %arg83) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 2, 3, 0>, static_sizes = array<i64: 1, 1, 128>, static_strides = array<i64: 1, 1, 1>}> : (tensor<1x1x128xf32>, tensor<5x6x128xf32>) -> tensor<5x6x128xf32>
    "func.return"(%101) : (tensor<5x6x128xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<256xf32>) -> tensor<256xf32>, sym_name = "cast"}> ({
  ^bb0(%arg80: tensor<256xf32>):
    %91 = "arith.constant"() <{value = 8.000000e+00 : f32}> : () -> f32
    %92 = "arith.constant"() <{value = 128 : index}> : () -> index
    %93 = "tensor.empty"(%92) : (index) -> tensor<?xf32>
    %94 = "linalg.fill"(%91, %93) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg81: f32, %arg82: f32):
      "linalg.yield"(%arg81) : (f32) -> ()
    }) : (f32, tensor<?xf32>) -> tensor<?xf32>
    %95 = "tensor.cast"(%94) : (tensor<?xf32>) -> tensor<128xf32>
    %96 = "tensor.insert_slice"(%95, %arg80) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 2>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (tensor<128xf32>, tensor<256xf32>) -> tensor<256xf32>
    "func.return"(%96) : (tensor<256xf32>) -> ()
  }) : () -> ()
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map, bufferization.writable = true}, {}], function_type = (tensor<?xf32>, index) -> tensor<?xf32>, sym_name = "parallel_insert_slice"}> ({
  ^bb0(%arg74: tensor<?xf32>, %arg75: index):
    %86 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %87 = "arith.constant"() <{value = 512 : index}> : () -> index
    %88 = "scf.forall"(%87, %arg74) <{operandSegmentSizes = array<i32: 0, 1, 0, 1>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg76: index, %arg77: tensor<?xf32>):
      %89 = "tensor.empty"(%arg75) : (index) -> tensor<?xf32>
      %90 = "linalg.fill"(%86, %89) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg78: f32, %arg79: f32):
        "linalg.yield"(%arg78) : (f32) -> ()
      }) : (f32, tensor<?xf32>) -> tensor<?xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%90, %arg77, %arg75) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 42>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index) -> ()
      }) : () -> ()
    }) : (index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%88) : (tensor<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map}, {}, {}], function_type = (tensor<?xf32>, index, i1) -> tensor<?xf32>, sym_name = "eleminate_multiple_ops"}> ({
  ^bb0(%arg67: tensor<?xf32>, %arg68: index, %arg69: i1):
    %78 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %79 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %80 = "scf.if"(%arg69) ({
      %84 = "tensor.empty"(%arg68) : (index) -> tensor<?xf32>
      %85 = "linalg.fill"(%78, %84) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg72: f32, %arg73: f32):
        "linalg.yield"(%arg72) : (f32) -> ()
      }) : (f32, tensor<?xf32>) -> tensor<?xf32>
      "scf.yield"(%85) : (tensor<?xf32>) -> ()
    }, {
      %82 = "tensor.empty"(%arg68) : (index) -> tensor<?xf32>
      %83 = "linalg.fill"(%79, %82) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg70: f32, %arg71: f32):
        "linalg.yield"(%arg70) : (f32) -> ()
      }) : (f32, tensor<?xf32>) -> tensor<?xf32>
      "scf.yield"(%83) : (tensor<?xf32>) -> ()
    }) : (i1) -> tensor<?xf32>
    %81 = "tensor.insert_slice"(%80, %arg67, %arg68) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 42>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%81) : (tensor<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<10xf32>, tensor<10xf32>) -> tensor<10xf32>, sym_name = "regression_do_not_eliminate_non_empty"}> ({
  ^bb0(%arg65: tensor<10xf32>, %arg66: tensor<10xf32>):
    %76 = "tensor.extract_slice"(%arg65) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<10xf32>) -> tensor<5xf32>
    %77 = "tensor.insert_slice"(%76, %arg66) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 1>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<10xf32>) -> tensor<10xf32>
    "func.return"(%77) : (tensor<10xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<5xf32>, tensor<10xf32>) -> tensor<10xf32>, sym_name = "regression_insert_of_bbarg"}> ({
  ^bb0(%arg63: tensor<5xf32>, %arg64: tensor<10xf32>):
    %75 = "tensor.insert_slice"(%arg63, %arg64) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 2>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<10xf32>) -> tensor<10xf32>
    "func.return"(%75) : (tensor<10xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, tensor<?x16xi8>) -> tensor<?x16xi8>, sym_name = "regression_eliminate_equivalent_only"}> ({
  ^bb0(%arg56: index, %arg57: index, %arg58: tensor<?x16xi8>):
    %64 = "arith.constant"() <{value = 0 : index}> : () -> index
    %65 = "arith.constant"() <{value = 8 : index}> : () -> index
    %66 = "arith.constant"() <{value = 16 : index}> : () -> index
    %67 = "tensor.empty"(%arg56) : (index) -> tensor<?x8xi32>
    %68 = "tensor.extract_slice"(%67, %arg57) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 8>, static_strides = array<i64: 1, 1>}> : (tensor<?x8xi32>, index) -> tensor<?x8xi32>
    %69 = "scf.for"(%64, %66, %65, %arg58) ({
    ^bb0(%arg59: index, %arg60: tensor<?x16xi8>):
      %70 = "tensor.insert_slice"(%68, %67, %arg56) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 8>, static_strides = array<i64: 1, 1>}> : (tensor<?x8xi32>, tensor<?x8xi32>, index) -> tensor<?x8xi32>
      %71 = "tensor.extract_slice"(%arg60, %arg57, %arg57, %arg56) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 8>, static_strides = array<i64: 1, 1>}> : (tensor<?x16xi8>, index, index, index) -> tensor<?x8xi8>
      %72 = "linalg.generic"(%70, %71) <{indexing_maps = [#map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg61: i32, %arg62: i8):
        %74 = "arith.trunci"(%arg61) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i8
        "linalg.yield"(%74) : (i8) -> ()
      }) : (tensor<?x8xi32>, tensor<?x8xi8>) -> tensor<?x8xi8>
      %73 = "tensor.insert_slice"(%72, %arg60, %arg57, %arg59, %arg56) <{operandSegmentSizes = array<i32: 1, 1, 2, 1, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 8>, static_strides = array<i64: 1, 1>}> : (tensor<?x8xi8>, tensor<?x16xi8>, index, index, index) -> tensor<?x16xi8>
      "scf.yield"(%73) : (tensor<?x16xi8>) -> ()
    }) : (index, index, index, tensor<?x16xi8>) -> tensor<?x16xi8>
    "func.return"(%69) : (tensor<?x16xi8>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?x?xf32>) -> tensor<?x?xf32>, sym_name = "regression_multiple_insertion_points"}> ({
  ^bb0(%arg53: tensor<?x?xf32>):
    %58 = "tensor.empty"() : () -> tensor<2x5xf32>
    %59 = "arith.constant"() <{value = 5.500000e+00 : f32}> : () -> f32
    %60 = "test.foo"() : () -> index
    %61 = "test.bar"() : () -> index
    %62 = "linalg.fill"(%59, %58) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg54: f32, %arg55: f32):
      "linalg.yield"(%arg54) : (f32) -> ()
    }) : (f32, tensor<2x5xf32>) -> tensor<2x5xf32>
    %63 = "tensor.insert_slice"(%62, %arg53, %60, %61) <{operandSegmentSizes = array<i32: 1, 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 2, 5>, static_strides = array<i64: 1, 1>}> : (tensor<2x5xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    "func.return"(%63) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<5xf32>, f32) -> tensor<5xf32>, sym_name = "materialize_in_destination"}> ({
  ^bb0(%arg49: tensor<5xf32>, %arg50: f32):
    %55 = "tensor.empty"() : () -> tensor<5xf32>
    %56 = "linalg.fill"(%arg50, %55) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg51: f32, %arg52: f32):
      "linalg.yield"(%arg51) : (f32) -> ()
    }) : (f32, tensor<5xf32>) -> tensor<5xf32>
    %57 = "bufferization.materialize_in_destination"(%56, %arg49) : (tensor<5xf32>, tensor<5xf32>) -> tensor<5xf32>
    "func.return"(%57) : (tensor<5xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<5xf32>, f32) -> (), sym_name = "materialize_in_destination_buffer"}> ({
  ^bb0(%arg45: memref<5xf32>, %arg46: f32):
    %53 = "tensor.empty"() : () -> tensor<5xf32>
    %54 = "linalg.fill"(%arg46, %53) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg47: f32, %arg48: f32):
      "linalg.yield"(%arg47) : (f32) -> ()
    }) : (f32, tensor<5xf32>) -> tensor<5xf32>
    "bufferization.materialize_in_destination"(%54, %arg45) <{restrict, writable}> : (tensor<5xf32>, memref<5xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<5xf32>, f32) -> tensor<5xf32>, sym_name = "linalg_copy"}> ({
  ^bb0(%arg39: tensor<5xf32>, %arg40: f32):
    %50 = "tensor.empty"() : () -> tensor<5xf32>
    %51 = "linalg.fill"(%arg40, %50) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg43: f32, %arg44: f32):
      "linalg.yield"(%arg43) : (f32) -> ()
    }) : (f32, tensor<5xf32>) -> tensor<5xf32>
    %52 = "linalg.copy"(%51, %arg39) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg41: f32, %arg42: f32):
      "linalg.yield"(%arg41) : (f32) -> ()
    }) : (tensor<5xf32>, tensor<5xf32>) -> tensor<5xf32>
    "func.return"(%52) : (tensor<5xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<26xi32>, sym_name = "linalg_copy_empty"}> ({
    %48 = "tensor.empty"() : () -> tensor<26xi32>
    %49 = "linalg.copy"(%48, %48) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg37: i32, %arg38: i32):
      "linalg.yield"(%arg37) : (i32) -> ()
    }) : (tensor<26xi32>, tensor<26xi32>) -> tensor<26xi32>
    "func.return"(%49) : (tensor<26xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<5xf32>, f32, f32, i1) -> (), sym_name = "multiple_materialize_in_destination_buffer"}> ({
  ^bb0(%arg29: memref<5xf32>, %arg30: f32, %arg31: f32, %arg32: i1):
    %43 = "tensor.empty"() : () -> tensor<5xf32>
    %44 = "linalg.fill"(%arg30, %43) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg35: f32, %arg36: f32):
      "linalg.yield"(%arg35) : (f32) -> ()
    }) : (f32, tensor<5xf32>) -> tensor<5xf32>
    %45 = "tensor.empty"() : () -> tensor<5xf32>
    %46 = "linalg.fill"(%arg31, %45) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg33: f32, %arg34: f32):
      "linalg.yield"(%arg33) : (f32) -> ()
    }) : (f32, tensor<5xf32>) -> tensor<5xf32>
    %47 = "scf.if"(%arg32) ({
      "scf.yield"(%44) : (tensor<5xf32>) -> ()
    }, {
      "scf.yield"(%46) : (tensor<5xf32>) -> ()
    }) : (i1) -> tensor<5xf32>
    "bufferization.materialize_in_destination"(%47, %arg29) <{restrict, writable}> : (tensor<5xf32>, memref<5xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<5x6x128xf32>, sym_name = "eliminate_all_empty_tensors"}> ({
    %34 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %35 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %36 = "tensor.empty"() : () -> tensor<5x6x64xf32>
    %37 = "linalg.fill"(%34, %36) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg27: f32, %arg28: f32):
      "linalg.yield"(%arg27) : (f32) -> ()
    }) : (f32, tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %38 = "tensor.empty"() : () -> tensor<5x6x64xf32>
    %39 = "linalg.fill"(%35, %38) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg25: f32, %arg26: f32):
      "linalg.yield"(%arg25) : (f32) -> ()
    }) : (f32, tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %40 = "tensor.empty"() : () -> tensor<5x6x128xf32>
    %41 = "tensor.insert_slice"(%37, %40) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x64xf32>, tensor<5x6x128xf32>) -> tensor<5x6x128xf32>
    %42 = "tensor.insert_slice"(%39, %41) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 64>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x64xf32>, tensor<5x6x128xf32>) -> tensor<5x6x128xf32>
    "func.return"(%42) : (tensor<5x6x128xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<5x6x128xf32>, sym_name = "eliminate_concatenated_empty_tensors"}> ({
    %25 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %26 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %27 = "tensor.empty"() : () -> tensor<5x6x128xf32>
    %28 = "tensor.empty"() : () -> tensor<5x6x64xf32>
    %29 = "linalg.fill"(%25, %28) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: f32, %arg24: f32):
      "linalg.yield"(%arg23) : (f32) -> ()
    }) : (f32, tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %30 = "tensor.empty"() : () -> tensor<5x6x64xf32>
    %31 = "linalg.fill"(%26, %30) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg21: f32, %arg22: f32):
      "linalg.yield"(%arg21) : (f32) -> ()
    }) : (f32, tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %32 = "tensor.insert_slice"(%29, %27) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x64xf32>, tensor<5x6x128xf32>) -> tensor<5x6x128xf32>
    %33 = "tensor.insert_slice"(%31, %32) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 64>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x64xf32>, tensor<5x6x128xf32>) -> tensor<5x6x128xf32>
    "func.return"(%33) : (tensor<5x6x128xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<5x6x128xf32>, sym_name = "multi_use_of_the_same_tensor_empty"}> ({
    %17 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %18 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %19 = "tensor.empty"() : () -> tensor<5x6x128xf32>
    %20 = "tensor.empty"() : () -> tensor<5x6x64xf32>
    %21 = "linalg.fill"(%17, %20) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: f32, %arg20: f32):
      "linalg.yield"(%arg19) : (f32) -> ()
    }) : (f32, tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %22 = "linalg.fill"(%18, %20) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: f32, %arg18: f32):
      "linalg.yield"(%arg17) : (f32) -> ()
    }) : (f32, tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %23 = "tensor.insert_slice"(%21, %19) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x64xf32>, tensor<5x6x128xf32>) -> tensor<5x6x128xf32>
    %24 = "tensor.insert_slice"(%22, %23) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 64>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x64xf32>, tensor<5x6x128xf32>) -> tensor<5x6x128xf32>
    "func.return"(%24) : (tensor<5x6x128xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<5x6x128xf32>, tensor<5x6x64xf32>) -> (tensor<5x6x128xf32>, tensor<5x6x64xf32>), sym_name = "multi_use_of_the_same_tensor_empty_creates_non_existent_read"}> ({
  ^bb0(%arg11: tensor<5x6x128xf32>, %arg12: tensor<5x6x64xf32>):
    %11 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %12 = "tensor.empty"() : () -> tensor<5x6x64xf32>
    %13 = "linalg.fill"(%11, %12) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: f32, %arg16: f32):
      "linalg.yield"(%arg15) : (f32) -> ()
    }) : (f32, tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %14 = "linalg.generic"(%12, %arg12) <{indexing_maps = [#map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: f32, %arg14: f32):
      %16 = "arith.addf"(%arg13, %arg13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%16) : (f32) -> ()
    }) : (tensor<5x6x64xf32>, tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %15 = "tensor.insert_slice"(%13, %arg11) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x64xf32>, tensor<5x6x128xf32>) -> tensor<5x6x128xf32>
    "func.return"(%15, %14) : (tensor<5x6x128xf32>, tensor<5x6x64xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<5x6x128xf32>) -> tensor<5x6x128xf32>, sym_name = "direct_use_of_tensor_empty"}> ({
  ^bb0(%arg10: tensor<5x6x128xf32>):
    %9 = "tensor.empty"() : () -> tensor<5x6x64xf32>
    %10 = "tensor.insert_slice"(%9, %arg10) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x64xf32>, tensor<5x6x128xf32>) -> tensor<5x6x128xf32>
    "func.return"(%10) : (tensor<5x6x128xf32>) -> ()
  }) : () -> ()
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map, bufferization.writable = true}, {}, {}], function_type = (tensor<10xf32>, index, f32) -> tensor<10xf32>, sym_name = "move_dependent_arith_op"}> ({
  ^bb0(%arg5: tensor<10xf32>, %arg6: index, %arg7: f32):
    %4 = "tensor.empty"() : () -> tensor<5xf32>
    %5 = "linalg.fill"(%arg7, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<5xf32>) -> tensor<5xf32>
    %6 = "arith.constant"() <{value = 5 : index}> : () -> index
    %7 = "arith.addi"(%arg6, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %8 = "tensor.insert_slice"(%5, %arg5, %7) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<10xf32>, index) -> tensor<10xf32>
    "func.return"(%8) : (tensor<10xf32>) -> ()
  }) : () -> ()
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map, bufferization.writable = true}, {}, {}], function_type = (tensor<10xf32>, memref<index>, f32) -> tensor<10xf32>, sym_name = "side_effecting_op_blocks_movement"}> ({
  ^bb0(%arg0: tensor<10xf32>, %arg1: memref<index>, %arg2: f32):
    %0 = "tensor.empty"() : () -> tensor<5xf32>
    %1 = "linalg.fill"(%arg2, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, tensor<5xf32>) -> tensor<5xf32>
    %2 = "memref.load"(%arg1) : (memref<index>) -> index
    %3 = "tensor.insert_slice"(%1, %arg0, %2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<10xf32>, index) -> tensor<10xf32>
    "func.return"(%3) : (tensor<10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

