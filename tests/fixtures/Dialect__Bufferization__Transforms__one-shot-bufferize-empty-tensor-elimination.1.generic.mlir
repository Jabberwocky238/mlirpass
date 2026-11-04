#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map, bufferization.writable = true}, {}], function_type = (tensor<?xf32>, index) -> (tensor<?xf32>, tensor<?xf32>), sym_name = "buffer_forwarding_conflict"}> ({
  ^bb0(%arg103: tensor<?xf32>, %arg104: index):
    %144 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %145 = "tensor.extract_slice"(%arg103, %arg104) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index) -> tensor<?xf32>
    %146 = "tensor.empty"(%arg104) : (index) -> tensor<?xf32>
    %147 = "linalg.fill"(%144, %145) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg105: f32, %arg106: f32):
      "linalg.yield"(%arg105) : (f32) -> ()
    }) : (f32, tensor<?xf32>) -> tensor<?xf32>
    %148 = "tensor.insert_slice"(%147, %arg103, %arg104) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    %149 = "tensor.insert_slice"(%147, %arg103, %arg104) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 42>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%148, %149) : (tensor<?xf32>, tensor<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map, bufferization.writable = true}, {}], function_type = (tensor<?xf32>, index) -> tensor<?xf32>, sym_name = "buffer_forwarding_no_conflict"}> ({
  ^bb0(%arg99: tensor<?xf32>, %arg100: index):
    %139 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %140 = "tensor.extract_slice"(%arg99, %arg100) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 42>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index) -> tensor<?xf32>
    %141 = "tensor.empty"(%arg100) : (index) -> tensor<?xf32>
    %142 = "linalg.fill"(%139, %140) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg101: f32, %arg102: f32):
      "linalg.yield"(%arg101) : (f32) -> ()
    }) : (f32, tensor<?xf32>) -> tensor<?xf32>
    %143 = "tensor.insert_slice"(%142, %arg99, %arg100) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 42>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%143) : (tensor<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?xf32>, index) -> tensor<?xf32>, sym_name = "insertion_point_inside_loop"}> ({
  ^bb0(%arg93: tensor<?xf32>, %arg94: index):
    %129 = "arith.constant"() <{value = 0 : index}> : () -> index
    %130 = "arith.constant"() <{value = 1 : index}> : () -> index
    %131 = "arith.constant"() <{value = 5 : index}> : () -> index
    %132 = "tensor.empty"() : () -> tensor<5xf32>
    %133 = "scf.for"(%129, %arg94, %131, %arg93) ({
    ^bb0(%arg95: index, %arg96: tensor<?xf32>):
      %134 = "tensor.extract_slice"(%arg96, %arg95) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index) -> tensor<5xf32>
      %135 = "arith.index_cast"(%arg95) : (index) -> i32
      %136 = "arith.sitofp"(%135) : (i32) -> f32
      %137 = "linalg.fill"(%136, %134) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg97: f32, %arg98: f32):
        "linalg.yield"(%arg97) : (f32) -> ()
      }) : (f32, tensor<5xf32>) -> tensor<5xf32>
      %138 = "tensor.insert_slice"(%137, %arg96, %arg95) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<?xf32>, index) -> tensor<?xf32>
      "scf.yield"(%138) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%133) : (tensor<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?xf32>, index, index) -> tensor<?xf32>, sym_name = "insertion_point_outside_loop"}> ({
  ^bb0(%arg86: tensor<?xf32>, %arg87: index, %arg88: index):
    %119 = "arith.constant"() <{value = 0 : index}> : () -> index
    %120 = "arith.constant"() <{value = 1 : index}> : () -> index
    %121 = "arith.constant"() <{value = 5 : index}> : () -> index
    %122 = "tensor.empty"() : () -> tensor<5xf32>
    %123 = "scf.for"(%119, %arg87, %121, %arg86) ({
    ^bb0(%arg89: index, %arg90: tensor<?xf32>):
      %124 = "tensor.extract_slice"(%arg90, %arg88) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index) -> tensor<5xf32>
      %125 = "arith.index_cast"(%arg89) : (index) -> i32
      %126 = "arith.sitofp"(%125) : (i32) -> f32
      %127 = "linalg.fill"(%126, %124) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg91: f32, %arg92: f32):
        "linalg.yield"(%arg91) : (f32) -> ()
      }) : (f32, tensor<5xf32>) -> tensor<5xf32>
      %128 = "tensor.insert_slice"(%127, %arg90, %arg88) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<?xf32>, index) -> tensor<?xf32>
      "scf.yield"(%128) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%123) : (tensor<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<5x6x128xf32>) -> tensor<5x6x128xf32>, sym_name = "shape_mismatch"}> ({
  ^bb0(%arg83: tensor<5x6x128xf32>):
    %114 = "arith.constant"() <{value = 8.000000e+00 : f32}> : () -> f32
    %115 = "tensor.empty"() : () -> tensor<128xf32>
    %116 = "linalg.fill"(%114, %115) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg84: f32, %arg85: f32):
      "linalg.yield"(%arg84) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    %117 = "tensor.expand_shape"(%116) <{reassociation = [[0, 1, 2]], static_output_shape = array<i64: 1, 1, 128>}> : (tensor<128xf32>) -> tensor<1x1x128xf32>
    %118 = "tensor.insert_slice"(%117, %arg83) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 2, 3, 0>, static_sizes = array<i64: 1, 1, 128>, static_strides = array<i64: 1, 1, 1>}> : (tensor<1x1x128xf32>, tensor<5x6x128xf32>) -> tensor<5x6x128xf32>
    "func.return"(%118) : (tensor<5x6x128xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<256xf32>) -> tensor<256xf32>, sym_name = "cast"}> ({
  ^bb0(%arg80: tensor<256xf32>):
    %106 = "arith.constant"() <{value = 8.000000e+00 : f32}> : () -> f32
    %107 = "arith.constant"() <{value = 128 : index}> : () -> index
    %108 = "tensor.extract_slice"(%arg80) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 2>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (tensor<256xf32>) -> tensor<128xf32>
    %109 = "tensor.cast"(%108) : (tensor<128xf32>) -> tensor<?xf32>
    %110 = "tensor.empty"(%107) : (index) -> tensor<?xf32>
    %111 = "linalg.fill"(%106, %109) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg81: f32, %arg82: f32):
      "linalg.yield"(%arg81) : (f32) -> ()
    }) : (f32, tensor<?xf32>) -> tensor<?xf32>
    %112 = "tensor.cast"(%111) : (tensor<?xf32>) -> tensor<128xf32>
    %113 = "tensor.insert_slice"(%112, %arg80) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 2>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (tensor<128xf32>, tensor<256xf32>) -> tensor<256xf32>
    "func.return"(%113) : (tensor<256xf32>) -> ()
  }) : () -> ()
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map, bufferization.writable = true}, {}], function_type = (tensor<?xf32>, index) -> tensor<?xf32>, sym_name = "parallel_insert_slice"}> ({
  ^bb0(%arg74: tensor<?xf32>, %arg75: index):
    %100 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %101 = "arith.constant"() <{value = 512 : index}> : () -> index
    %102 = "scf.forall"(%101, %arg74) <{operandSegmentSizes = array<i32: 0, 1, 0, 1>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg76: index, %arg77: tensor<?xf32>):
      %103 = "tensor.extract_slice"(%arg77, %arg75) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 42>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index) -> tensor<?xf32>
      %104 = "tensor.empty"(%arg75) : (index) -> tensor<?xf32>
      %105 = "linalg.fill"(%100, %103) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg78: f32, %arg79: f32):
        "linalg.yield"(%arg78) : (f32) -> ()
      }) : (f32, tensor<?xf32>) -> tensor<?xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%105, %arg77, %arg75) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 42>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index) -> ()
      }) : () -> ()
    }) : (index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%102) : (tensor<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map}, {}, {}], function_type = (tensor<?xf32>, index, i1) -> tensor<?xf32>, sym_name = "eleminate_multiple_ops"}> ({
  ^bb0(%arg67: tensor<?xf32>, %arg68: index, %arg69: i1):
    %90 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %91 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %92 = "scf.if"(%arg69) ({
      %97 = "tensor.extract_slice"(%arg67, %arg68) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 42>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index) -> tensor<?xf32>
      %98 = "tensor.empty"(%arg68) : (index) -> tensor<?xf32>
      %99 = "linalg.fill"(%90, %97) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg72: f32, %arg73: f32):
        "linalg.yield"(%arg72) : (f32) -> ()
      }) : (f32, tensor<?xf32>) -> tensor<?xf32>
      "scf.yield"(%99) : (tensor<?xf32>) -> ()
    }, {
      %94 = "tensor.extract_slice"(%arg67, %arg68) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 42>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index) -> tensor<?xf32>
      %95 = "tensor.empty"(%arg68) : (index) -> tensor<?xf32>
      %96 = "linalg.fill"(%91, %94) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg70: f32, %arg71: f32):
        "linalg.yield"(%arg70) : (f32) -> ()
      }) : (f32, tensor<?xf32>) -> tensor<?xf32>
      "scf.yield"(%96) : (tensor<?xf32>) -> ()
    }) : (i1) -> tensor<?xf32>
    %93 = "tensor.insert_slice"(%92, %arg67, %arg68) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 42>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%93) : (tensor<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<10xf32>, tensor<10xf32>) -> tensor<10xf32>, sym_name = "regression_do_not_eliminate_non_empty"}> ({
  ^bb0(%arg65: tensor<10xf32>, %arg66: tensor<10xf32>):
    %88 = "tensor.extract_slice"(%arg65) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<10xf32>) -> tensor<5xf32>
    %89 = "tensor.insert_slice"(%88, %arg66) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 1>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<10xf32>) -> tensor<10xf32>
    "func.return"(%89) : (tensor<10xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<5xf32>, tensor<10xf32>) -> tensor<10xf32>, sym_name = "regression_insert_of_bbarg"}> ({
  ^bb0(%arg63: tensor<5xf32>, %arg64: tensor<10xf32>):
    %87 = "tensor.insert_slice"(%arg63, %arg64) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 2>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<10xf32>) -> tensor<10xf32>
    "func.return"(%87) : (tensor<10xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, tensor<?x16xi8>) -> tensor<?x16xi8>, sym_name = "regression_eliminate_equivalent_only"}> ({
  ^bb0(%arg56: index, %arg57: index, %arg58: tensor<?x16xi8>):
    %76 = "arith.constant"() <{value = 0 : index}> : () -> index
    %77 = "arith.constant"() <{value = 8 : index}> : () -> index
    %78 = "arith.constant"() <{value = 16 : index}> : () -> index
    %79 = "tensor.empty"(%arg56) : (index) -> tensor<?x8xi32>
    %80 = "tensor.extract_slice"(%79, %arg57) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 8>, static_strides = array<i64: 1, 1>}> : (tensor<?x8xi32>, index) -> tensor<?x8xi32>
    %81 = "scf.for"(%76, %78, %77, %arg58) ({
    ^bb0(%arg59: index, %arg60: tensor<?x16xi8>):
      %82 = "tensor.insert_slice"(%80, %79, %arg56) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 8>, static_strides = array<i64: 1, 1>}> : (tensor<?x8xi32>, tensor<?x8xi32>, index) -> tensor<?x8xi32>
      %83 = "tensor.extract_slice"(%arg60, %arg57, %arg57, %arg56) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 8>, static_strides = array<i64: 1, 1>}> : (tensor<?x16xi8>, index, index, index) -> tensor<?x8xi8>
      %84 = "linalg.generic"(%82, %83) <{indexing_maps = [#map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg61: i32, %arg62: i8):
        %86 = "arith.trunci"(%arg61) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i8
        "linalg.yield"(%86) : (i8) -> ()
      }) : (tensor<?x8xi32>, tensor<?x8xi8>) -> tensor<?x8xi8>
      %85 = "tensor.insert_slice"(%84, %arg60, %arg57, %arg59, %arg56) <{operandSegmentSizes = array<i32: 1, 1, 2, 1, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 8>, static_strides = array<i64: 1, 1>}> : (tensor<?x8xi8>, tensor<?x16xi8>, index, index, index) -> tensor<?x16xi8>
      "scf.yield"(%85) : (tensor<?x16xi8>) -> ()
    }) : (index, index, index, tensor<?x16xi8>) -> tensor<?x16xi8>
    "func.return"(%81) : (tensor<?x16xi8>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?x?xf32>) -> tensor<?x?xf32>, sym_name = "regression_multiple_insertion_points"}> ({
  ^bb0(%arg53: tensor<?x?xf32>):
    %69 = "tensor.empty"() : () -> tensor<2x5xf32>
    %70 = "arith.constant"() <{value = 5.500000e+00 : f32}> : () -> f32
    %71 = "test.foo"() : () -> index
    %72 = "test.bar"() : () -> index
    %73 = "tensor.extract_slice"(%arg53, %71, %72) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 2, 5>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, index, index) -> tensor<2x5xf32>
    %74 = "linalg.fill"(%70, %73) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg54: f32, %arg55: f32):
      "linalg.yield"(%arg54) : (f32) -> ()
    }) : (f32, tensor<2x5xf32>) -> tensor<2x5xf32>
    %75 = "tensor.insert_slice"(%74, %arg53, %71, %72) <{operandSegmentSizes = array<i32: 1, 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 2, 5>, static_strides = array<i64: 1, 1>}> : (tensor<2x5xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    "func.return"(%75) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<5xf32>, f32) -> tensor<5xf32>, sym_name = "materialize_in_destination"}> ({
  ^bb0(%arg49: tensor<5xf32>, %arg50: f32):
    %66 = "tensor.empty"() : () -> tensor<5xf32>
    %67 = "linalg.fill"(%arg50, %arg49) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg51: f32, %arg52: f32):
      "linalg.yield"(%arg51) : (f32) -> ()
    }) : (f32, tensor<5xf32>) -> tensor<5xf32>
    %68 = "bufferization.materialize_in_destination"(%67, %arg49) : (tensor<5xf32>, tensor<5xf32>) -> tensor<5xf32>
    "func.return"(%68) : (tensor<5xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<5xf32>, f32) -> (), sym_name = "materialize_in_destination_buffer"}> ({
  ^bb0(%arg45: memref<5xf32>, %arg46: f32):
    %63 = "bufferization.to_tensor"(%arg45) <{restrict, writable}> : (memref<5xf32>) -> tensor<5xf32>
    %64 = "tensor.empty"() : () -> tensor<5xf32>
    %65 = "linalg.fill"(%arg46, %63) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg47: f32, %arg48: f32):
      "linalg.yield"(%arg47) : (f32) -> ()
    }) : (f32, tensor<5xf32>) -> tensor<5xf32>
    "bufferization.materialize_in_destination"(%65, %arg45) <{writable}> : (tensor<5xf32>, memref<5xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<5xf32>, f32) -> tensor<5xf32>, sym_name = "linalg_copy"}> ({
  ^bb0(%arg39: tensor<5xf32>, %arg40: f32):
    %60 = "tensor.empty"() : () -> tensor<5xf32>
    %61 = "linalg.fill"(%arg40, %arg39) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg43: f32, %arg44: f32):
      "linalg.yield"(%arg43) : (f32) -> ()
    }) : (f32, tensor<5xf32>) -> tensor<5xf32>
    %62 = "linalg.copy"(%61, %arg39) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg41: f32, %arg42: f32):
      "linalg.yield"(%arg41) : (f32) -> ()
    }) : (tensor<5xf32>, tensor<5xf32>) -> tensor<5xf32>
    "func.return"(%62) : (tensor<5xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<26xi32>, sym_name = "linalg_copy_empty"}> ({
    %58 = "tensor.empty"() : () -> tensor<26xi32>
    %59 = "linalg.copy"(%58, %58) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg37: i32, %arg38: i32):
      "linalg.yield"(%arg37) : (i32) -> ()
    }) : (tensor<26xi32>, tensor<26xi32>) -> tensor<26xi32>
    "func.return"(%59) : (tensor<26xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<5xf32>, f32, f32, i1) -> (), sym_name = "multiple_materialize_in_destination_buffer"}> ({
  ^bb0(%arg29: memref<5xf32>, %arg30: f32, %arg31: f32, %arg32: i1):
    %52 = "tensor.empty"() : () -> tensor<5xf32>
    %53 = "linalg.fill"(%arg30, %52) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg35: f32, %arg36: f32):
      "linalg.yield"(%arg35) : (f32) -> ()
    }) : (f32, tensor<5xf32>) -> tensor<5xf32>
    %54 = "bufferization.to_tensor"(%arg29) <{restrict, writable}> : (memref<5xf32>) -> tensor<5xf32>
    %55 = "tensor.empty"() : () -> tensor<5xf32>
    %56 = "linalg.fill"(%arg31, %54) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg33: f32, %arg34: f32):
      "linalg.yield"(%arg33) : (f32) -> ()
    }) : (f32, tensor<5xf32>) -> tensor<5xf32>
    %57 = "scf.if"(%arg32) ({
      "scf.yield"(%53) : (tensor<5xf32>) -> ()
    }, {
      "scf.yield"(%56) : (tensor<5xf32>) -> ()
    }) : (i1) -> tensor<5xf32>
    "bufferization.materialize_in_destination"(%57, %arg29) <{writable}> : (tensor<5xf32>, memref<5xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<5x6x128xf32>, sym_name = "eliminate_all_empty_tensors"}> ({
    %41 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %42 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %43 = "tensor.empty"() : () -> tensor<5x6x64xf32>
    %44 = "tensor.empty"() : () -> tensor<5x6x128xf32>
    %45 = "tensor.extract_slice"(%44) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x128xf32>) -> tensor<5x6x64xf32>
    %46 = "linalg.fill"(%41, %45) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg27: f32, %arg28: f32):
      "linalg.yield"(%arg27) : (f32) -> ()
    }) : (f32, tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %47 = "tensor.empty"() : () -> tensor<5x6x64xf32>
    %48 = "tensor.insert_slice"(%46, %44) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x64xf32>, tensor<5x6x128xf32>) -> tensor<5x6x128xf32>
    %49 = "tensor.extract_slice"(%48) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 64>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x128xf32>) -> tensor<5x6x64xf32>
    %50 = "linalg.fill"(%42, %49) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg25: f32, %arg26: f32):
      "linalg.yield"(%arg25) : (f32) -> ()
    }) : (f32, tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %51 = "tensor.insert_slice"(%50, %48) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 64>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x64xf32>, tensor<5x6x128xf32>) -> tensor<5x6x128xf32>
    "func.return"(%51) : (tensor<5x6x128xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<5x6x128xf32>, sym_name = "eliminate_concatenated_empty_tensors"}> ({
    %30 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %31 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %32 = "tensor.empty"() : () -> tensor<5x6x128xf32>
    %33 = "tensor.extract_slice"(%32) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x128xf32>) -> tensor<5x6x64xf32>
    %34 = "tensor.empty"() : () -> tensor<5x6x64xf32>
    %35 = "linalg.fill"(%30, %33) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: f32, %arg24: f32):
      "linalg.yield"(%arg23) : (f32) -> ()
    }) : (f32, tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %36 = "tensor.empty"() : () -> tensor<5x6x64xf32>
    %37 = "tensor.insert_slice"(%35, %32) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x64xf32>, tensor<5x6x128xf32>) -> tensor<5x6x128xf32>
    %38 = "tensor.extract_slice"(%37) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 64>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x128xf32>) -> tensor<5x6x64xf32>
    %39 = "linalg.fill"(%31, %38) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg21: f32, %arg22: f32):
      "linalg.yield"(%arg21) : (f32) -> ()
    }) : (f32, tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %40 = "tensor.insert_slice"(%39, %37) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 64>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x64xf32>, tensor<5x6x128xf32>) -> tensor<5x6x128xf32>
    "func.return"(%40) : (tensor<5x6x128xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<5x6x128xf32>, sym_name = "multi_use_of_the_same_tensor_empty"}> ({
    %20 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %21 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %22 = "tensor.empty"() : () -> tensor<5x6x128xf32>
    %23 = "tensor.extract_slice"(%22) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x128xf32>) -> tensor<5x6x64xf32>
    %24 = "tensor.empty"() : () -> tensor<5x6x64xf32>
    %25 = "linalg.fill"(%20, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: f32, %arg20: f32):
      "linalg.yield"(%arg19) : (f32) -> ()
    }) : (f32, tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %26 = "tensor.insert_slice"(%25, %22) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x64xf32>, tensor<5x6x128xf32>) -> tensor<5x6x128xf32>
    %27 = "tensor.extract_slice"(%26) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 64>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x128xf32>) -> tensor<5x6x64xf32>
    %28 = "linalg.fill"(%21, %27) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: f32, %arg18: f32):
      "linalg.yield"(%arg17) : (f32) -> ()
    }) : (f32, tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %29 = "tensor.insert_slice"(%28, %26) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 64>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x64xf32>, tensor<5x6x128xf32>) -> tensor<5x6x128xf32>
    "func.return"(%29) : (tensor<5x6x128xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<5x6x128xf32>, tensor<5x6x64xf32>) -> (tensor<5x6x128xf32>, tensor<5x6x64xf32>), sym_name = "multi_use_of_the_same_tensor_empty_creates_non_existent_read"}> ({
  ^bb0(%arg11: tensor<5x6x128xf32>, %arg12: tensor<5x6x64xf32>):
    %13 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %14 = "tensor.extract_slice"(%arg11) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x128xf32>) -> tensor<5x6x64xf32>
    %15 = "tensor.empty"() : () -> tensor<5x6x64xf32>
    %16 = "linalg.fill"(%13, %14) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: f32, %arg16: f32):
      "linalg.yield"(%arg15) : (f32) -> ()
    }) : (f32, tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %17 = "linalg.generic"(%15, %arg12) <{indexing_maps = [#map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: f32, %arg14: f32):
      %19 = "arith.addf"(%arg13, %arg13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%19) : (f32) -> ()
    }) : (tensor<5x6x64xf32>, tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %18 = "tensor.insert_slice"(%16, %arg11) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x64xf32>, tensor<5x6x128xf32>) -> tensor<5x6x128xf32>
    "func.return"(%18, %17) : (tensor<5x6x128xf32>, tensor<5x6x64xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<5x6x128xf32>) -> tensor<5x6x128xf32>, sym_name = "direct_use_of_tensor_empty"}> ({
  ^bb0(%arg10: tensor<5x6x128xf32>):
    %10 = "tensor.extract_slice"(%arg10) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x128xf32>) -> tensor<5x6x64xf32>
    %11 = "tensor.empty"() : () -> tensor<5x6x64xf32>
    %12 = "tensor.insert_slice"(%10, %arg10) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x64xf32>, tensor<5x6x128xf32>) -> tensor<5x6x128xf32>
    "func.return"(%12) : (tensor<5x6x128xf32>) -> ()
  }) : () -> ()
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map, bufferization.writable = true}, {}, {}], function_type = (tensor<10xf32>, index, f32) -> tensor<10xf32>, sym_name = "move_dependent_arith_op"}> ({
  ^bb0(%arg5: tensor<10xf32>, %arg6: index, %arg7: f32):
    %4 = "tensor.empty"() : () -> tensor<5xf32>
    %5 = "arith.constant"() <{value = 5 : index}> : () -> index
    %6 = "arith.addi"(%arg6, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %7 = "tensor.extract_slice"(%arg5, %6) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<10xf32>, index) -> tensor<5xf32>
    %8 = "linalg.fill"(%arg7, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<5xf32>) -> tensor<5xf32>
    %9 = "tensor.insert_slice"(%8, %arg5, %6) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<10xf32>, index) -> tensor<10xf32>
    "func.return"(%9) : (tensor<10xf32>) -> ()
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

