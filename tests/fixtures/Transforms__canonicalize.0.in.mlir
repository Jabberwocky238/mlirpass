#map = affine_map<(d0) -> (d0 - 1)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<() -> (10)>
#map3 = affine_map<()[s0] -> (s0)>
#map4 = affine_map<() -> (8)>
#map5 = affine_map<(d0) -> (d0 floordiv 8)>
#map6 = affine_map<(d0) -> (d0 floordiv 16)>
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "test_subi_zero"}> ({
  ^bb0(%arg65: i32):
    %185 = "arith.subi"(%arg65, %arg65) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%185) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> vector<4xi32>, sym_name = "test_subi_zero_vector"}> ({
  ^bb0(%arg64: vector<4xi32>):
    %184 = "arith.subi"(%arg64, %arg64) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"(%184) : (vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x5xi32>) -> tensor<4x5xi32>, sym_name = "test_subi_zero_tensor"}> ({
  ^bb0(%arg63: tensor<4x5xi32>):
    %183 = "arith.subi"(%arg63, %arg63) <{overflowFlags = #arith.overflow<none>}> : (tensor<4x5xi32>, tensor<4x5xi32>) -> tensor<4x5xi32>
    "func.return"(%183) : (tensor<4x5xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<8x4xf32>) -> index, sym_name = "dim"}> ({
  ^bb0(%arg62: tensor<8x4xf32>):
    %181 = "arith.constant"() <{value = 1 : index}> : () -> index
    %182 = "tensor.dim"(%arg62, %181) : (tensor<8x4xf32>, index) -> index
    "func.return"(%182) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "test_commutative"}> ({
  ^bb0(%arg61: i32):
    %178 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    %179 = "arith.addi"(%178, %arg61) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %180 = "arith.subi"(%178, %arg61) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%179, %180) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<8x4xf32>) -> (), sym_name = "trivial_dce"}> ({
  ^bb0(%arg60: tensor<8x4xf32>):
    %176 = "arith.constant"() <{value = 1 : index}> : () -> index
    %177 = "tensor.dim"(%arg60, %176) : (tensor<8x4xf32>, index) -> index
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "load_dce"}> ({
  ^bb0(%arg59: index):
    %173 = "arith.constant"() <{value = 4 : index}> : () -> index
    %174 = "memref.alloc"(%173) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    %175 = "memref.load"(%174, %arg59) : (memref<?xf32>, index) -> f32
    "memref.dealloc"(%174) : (memref<?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "addi_zero"}> ({
  ^bb0(%arg58: i32):
    %171 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %172 = "arith.addi"(%171, %arg58) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%172) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "addi_zero_index"}> ({
  ^bb0(%arg57: index):
    %169 = "arith.constant"() <{value = 0 : index}> : () -> index
    %170 = "arith.addi"(%169, %arg57) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%170) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> vector<4xi32>, sym_name = "addi_zero_vector"}> ({
  ^bb0(%arg56: vector<4xi32>):
    %167 = "arith.constant"() <{value = dense<0> : vector<4xi32>}> : () -> vector<4xi32>
    %168 = "arith.addi"(%167, %arg56) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"(%168) : (vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x5xi32>) -> tensor<4x5xi32>, sym_name = "addi_zero_tensor"}> ({
  ^bb0(%arg55: tensor<4x5xi32>):
    %165 = "arith.constant"() <{value = dense<0> : tensor<4x5xi32>}> : () -> tensor<4x5xi32>
    %166 = "arith.addi"(%arg55, %165) <{overflowFlags = #arith.overflow<none>}> : (tensor<4x5xi32>, tensor<4x5xi32>) -> tensor<4x5xi32>
    "func.return"(%166) : (tensor<4x5xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "muli_zero"}> ({
  ^bb0(%arg54: i32):
    %163 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %164 = "arith.muli"(%163, %arg54) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%164) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "muli_zero_index"}> ({
  ^bb0(%arg53: index):
    %161 = "arith.constant"() <{value = 0 : index}> : () -> index
    %162 = "arith.muli"(%161, %arg53) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%162) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> vector<4xi32>, sym_name = "muli_zero_vector"}> ({
  ^bb0(%arg52: vector<4xi32>):
    %159 = "arith.constant"() <{value = dense<0> : vector<4xi32>}> : () -> vector<4xi32>
    %160 = "arith.muli"(%159, %arg52) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"(%160) : (vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x5xi32>) -> tensor<4x5xi32>, sym_name = "muli_zero_tensor"}> ({
  ^bb0(%arg51: tensor<4x5xi32>):
    %157 = "arith.constant"() <{value = dense<0> : tensor<4x5xi32>}> : () -> tensor<4x5xi32>
    %158 = "arith.muli"(%arg51, %157) <{overflowFlags = #arith.overflow<none>}> : (tensor<4x5xi32>, tensor<4x5xi32>) -> tensor<4x5xi32>
    "func.return"(%158) : (tensor<4x5xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "muli_one"}> ({
  ^bb0(%arg50: i32):
    %155 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %156 = "arith.muli"(%155, %arg50) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%156) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "muli_one_index"}> ({
  ^bb0(%arg49: index):
    %153 = "arith.constant"() <{value = 1 : index}> : () -> index
    %154 = "arith.muli"(%153, %arg49) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%154) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> vector<4xi32>, sym_name = "muli_one_vector"}> ({
  ^bb0(%arg48: vector<4xi32>):
    %151 = "arith.constant"() <{value = dense<1> : vector<4xi32>}> : () -> vector<4xi32>
    %152 = "arith.muli"(%151, %arg48) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"(%152) : (vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x5xi32>) -> tensor<4x5xi32>, sym_name = "muli_one_tensor"}> ({
  ^bb0(%arg47: tensor<4x5xi32>):
    %149 = "arith.constant"() <{value = dense<1> : tensor<4x5xi32>}> : () -> tensor<4x5xi32>
    %150 = "arith.muli"(%arg47, %149) <{overflowFlags = #arith.overflow<none>}> : (tensor<4x5xi32>, tensor<4x5xi32>) -> tensor<4x5xi32>
    "func.return"(%150) : (tensor<4x5xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "and_self"}> ({
  ^bb0(%arg46: i32):
    %148 = "arith.andi"(%arg46, %arg46) : (i32, i32) -> i32
    "func.return"(%148) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> vector<4xi32>, sym_name = "and_self_vector"}> ({
  ^bb0(%arg45: vector<4xi32>):
    %147 = "arith.andi"(%arg45, %arg45) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"(%147) : (vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x5xi32>) -> tensor<4x5xi32>, sym_name = "and_self_tensor"}> ({
  ^bb0(%arg44: tensor<4x5xi32>):
    %146 = "arith.andi"(%arg44, %arg44) : (tensor<4x5xi32>, tensor<4x5xi32>) -> tensor<4x5xi32>
    "func.return"(%146) : (tensor<4x5xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "and_zero"}> ({
  ^bb0(%arg43: i32):
    %144 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %145 = "arith.andi"(%arg43, %144) : (i32, i32) -> i32
    "func.return"(%145) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "and_zero_index"}> ({
  ^bb0(%arg42: index):
    %142 = "arith.constant"() <{value = 0 : index}> : () -> index
    %143 = "arith.andi"(%arg42, %142) : (index, index) -> index
    "func.return"(%143) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> vector<4xi32>, sym_name = "and_zero_vector"}> ({
  ^bb0(%arg41: vector<4xi32>):
    %140 = "arith.constant"() <{value = dense<0> : vector<4xi32>}> : () -> vector<4xi32>
    %141 = "arith.andi"(%arg41, %140) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"(%141) : (vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x5xi32>) -> tensor<4x5xi32>, sym_name = "and_zero_tensor"}> ({
  ^bb0(%arg40: tensor<4x5xi32>):
    %138 = "arith.constant"() <{value = dense<0> : tensor<4x5xi32>}> : () -> tensor<4x5xi32>
    %139 = "arith.andi"(%arg40, %138) : (tensor<4x5xi32>, tensor<4x5xi32>) -> tensor<4x5xi32>
    "func.return"(%139) : (tensor<4x5xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "or_self"}> ({
  ^bb0(%arg39: i32):
    %137 = "arith.ori"(%arg39, %arg39) : (i32, i32) -> i32
    "func.return"(%137) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> vector<4xi32>, sym_name = "or_self_vector"}> ({
  ^bb0(%arg38: vector<4xi32>):
    %136 = "arith.ori"(%arg38, %arg38) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"(%136) : (vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x5xi32>) -> tensor<4x5xi32>, sym_name = "or_self_tensor"}> ({
  ^bb0(%arg37: tensor<4x5xi32>):
    %135 = "arith.ori"(%arg37, %arg37) : (tensor<4x5xi32>, tensor<4x5xi32>) -> tensor<4x5xi32>
    "func.return"(%135) : (tensor<4x5xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "or_zero"}> ({
  ^bb0(%arg36: i32):
    %133 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %134 = "arith.ori"(%arg36, %133) : (i32, i32) -> i32
    "func.return"(%134) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "or_zero_index"}> ({
  ^bb0(%arg35: index):
    %131 = "arith.constant"() <{value = 0 : index}> : () -> index
    %132 = "arith.ori"(%arg35, %131) : (index, index) -> index
    "func.return"(%132) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> vector<4xi32>, sym_name = "or_zero_vector"}> ({
  ^bb0(%arg34: vector<4xi32>):
    %129 = "arith.constant"() <{value = dense<0> : vector<4xi32>}> : () -> vector<4xi32>
    %130 = "arith.ori"(%arg34, %129) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"(%130) : (vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x5xi32>) -> tensor<4x5xi32>, sym_name = "or_zero_tensor"}> ({
  ^bb0(%arg33: tensor<4x5xi32>):
    %127 = "arith.constant"() <{value = dense<0> : tensor<4x5xi32>}> : () -> tensor<4x5xi32>
    %128 = "arith.ori"(%arg33, %127) : (tensor<4x5xi32>, tensor<4x5xi32>) -> tensor<4x5xi32>
    "func.return"(%128) : (tensor<4x5xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i4) -> (i1, i4), sym_name = "or_all_ones"}> ({
  ^bb0(%arg31: i1, %arg32: i4):
    %123 = "arith.constant"() <{value = true}> : () -> i1
    %124 = "arith.constant"() <{value = -1 : i4}> : () -> i4
    %125 = "arith.ori"(%arg31, %123) : (i1, i1) -> i1
    %126 = "arith.ori"(%arg32, %124) : (i4, i4) -> i4
    "func.return"(%125, %126) : (i1, i4) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "xor_self"}> ({
  ^bb0(%arg30: i32):
    %122 = "arith.xori"(%arg30, %arg30) : (i32, i32) -> i32
    "func.return"(%122) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> vector<4xi32>, sym_name = "xor_self_vector"}> ({
  ^bb0(%arg29: vector<4xi32>):
    %121 = "arith.xori"(%arg29, %arg29) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"(%121) : (vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x5xi32>) -> tensor<4x5xi32>, sym_name = "xor_self_tensor"}> ({
  ^bb0(%arg28: tensor<4x5xi32>):
    %120 = "arith.xori"(%arg28, %arg28) : (tensor<4x5xi32>, tensor<4x5xi32>) -> tensor<4x5xi32>
    "func.return"(%120) : (tensor<4x5xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xf32>, f32) -> (f32, f32), sym_name = "memref_cast_folding"}> ({
  ^bb0(%arg26: memref<4xf32>, %arg27: f32):
    %115 = "memref.cast"(%arg26) : (memref<4xf32>) -> memref<?xf32>
    %116 = "arith.constant"() <{value = 0 : index}> : () -> index
    %117 = "memref.dim"(%115, %116) : (memref<?xf32>, index) -> index
    %118 = "affine.load"(%115, %117) <{map = #map}> : (memref<?xf32>, index) -> f32
    "memref.store"(%arg27, %115, %116) : (f32, memref<?xf32>, index) -> ()
    %119 = "memref.load"(%115, %116) : (memref<?xf32>, index) -> f32
    "memref.dealloc"(%115) : (memref<?xf32>) -> ()
    "func.return"(%118, %119) : (f32, f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<42x42xf64>) -> (), sym_name = "fold_memref_cast_in_memref_cast"}> ({
  ^bb0(%arg25: memref<42x42xf64>):
    %113 = "memref.cast"(%arg25) : (memref<42x42xf64>) -> memref<?x42xf64>
    %114 = "memref.cast"(%113) : (memref<?x42xf64>) -> memref<?x?xf64>
    "test.user"(%114) : (memref<?x?xf64>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<42x42xf64>) -> (), sym_name = "fold_memref_cast_chain"}> ({
  ^bb0(%arg24: memref<42x42xf64>):
    %111 = "memref.cast"(%arg24) : (memref<42x42xf64>) -> memref<?x42xf64>
    %112 = "memref.cast"(%111) : (memref<?x42xf64>) -> memref<42x42xf64>
    "test.user"(%112) : (memref<42x42xf64>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "dead_alloc_fold"}> ({
    %109 = "arith.constant"() <{value = 4 : index}> : () -> index
    %110 = "memref.alloc"(%109) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "dead_dealloc_fold"}> ({
    %108 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xf32>
    "memref.dealloc"(%108) : (memref<4xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "dead_dealloc_fold_multi_use"}> ({
  ^bb0(%arg23: i1):
    %107 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xf32>
    "cf.cond_br"(%arg23)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "memref.dealloc"(%107) : (memref<4xf32>) -> ()
    "func.return"() : () -> ()
  ^bb2:  // pred: ^bb0
    "memref.dealloc"(%107) : (memref<4xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> (), sym_name = "write_only_alloc_fold"}> ({
  ^bb0(%arg22: f32):
    %104 = "arith.constant"() <{value = 0 : index}> : () -> index
    %105 = "arith.constant"() <{value = 4 : index}> : () -> index
    %106 = "memref.alloc"(%105) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.store"(%arg22, %106, %104) : (f32, memref<?xf32>, index) -> ()
    "memref.dealloc"(%106) : (memref<?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> (), sym_name = "write_only_alloca_fold"}> ({
  ^bb0(%arg21: f32):
    %101 = "arith.constant"() <{value = 0 : index}> : () -> index
    %102 = "arith.constant"() <{value = 4 : index}> : () -> index
    %103 = "memref.alloca"(%102) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.store"(%arg21, %103, %101) : (f32, memref<?xf32>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "dead_block_elim"}> ({
    "builtin.module"() ({
      "func.func"() <{function_type = () -> (), sym_name = "nested"}> ({
        "func.return"() : () -> ()
      ^bb1:  // no predecessors
        "func.return"() : () -> ()
      }) : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> (memref<4x?x8x?x?xf32>, memref<?x?xi32>, memref<?x?xf32>, memref<4x?x8x?x?xf32>), sym_name = "dyn_shape_fold"}> ({
  ^bb0(%arg17: index, %arg18: index):
    %91 = "arith.constant"() <{value = 0 : index}> : () -> index
    %92 = "arith.constant"() <{value = 9 : index}> : () -> index
    %93 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %94 = "arith.constant"() <{value = 512 : index}> : () -> index
    %95 = "memref.alloc"(%arg17, %93) <{operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
    %96 = "memref.alloc"(%93, %94, %arg18) <{operandSegmentSizes = array<i32: 3, 0>}> : (index, index, index) -> memref<4x?x8x?x?xf32>
    %97 = "memref.alloc"(%94, %93) <{operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xi32>
    %98 = "memref.alloc"(%92, %92) <{operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
    %99 = "memref.alloca"(%93, %94, %arg18) <{operandSegmentSizes = array<i32: 3, 0>}> : (index, index, index) -> memref<4x?x8x?x?xf32>
    "affine.for"(%arg17) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map3}> ({
    ^bb0(%arg19: index):
      "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map2}> ({
      ^bb0(%arg20: index):
        %100 = "memref.load"(%95, %arg19, %arg20) : (memref<?x?xf32>, index, index) -> f32
        "memref.store"(%100, %96, %91, %91, %arg19, %arg20, %91) : (f32, memref<4x?x8x?x?xf32>, index, index, index, index, index) -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "affine.yield"() : () -> ()
    }) : (index) -> ()
    "func.return"(%96, %97, %98, %99) : (memref<4x?x8x?x?xf32>, memref<?x?xi32>, memref<?x?xf32>, memref<4x?x8x?x?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index, memref<?xi8>, index, index, index) -> (), sym_name = "dim_op_fold"}> ({
  ^bb0(%arg3: index, %arg4: index, %arg5: index, %arg6: memref<?xi8>, %arg7: index, %arg8: index, %arg9: index):
    %69 = "arith.constant"() <{value = 0 : index}> : () -> index
    %70 = "arith.constant"() <{value = 1 : index}> : () -> index
    %71 = "arith.constant"() <{value = 2 : index}> : () -> index
    %72 = "memref.alloc"(%arg3, %arg4) <{operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
    %73 = "memref.alloc"(%arg4, %arg5) <{operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x8x?xf32>
    %74 = "memref.dim"(%73, %71) : (memref<?x8x?xf32>, index) -> index
    "affine.for"(%74) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map3}> ({
    ^bb0(%arg13: index):
      %81 = "memref.alloc"(%arg3) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xi8>
      %82 = "memref.dim"(%81, %69) : (memref<?xi8>, index) -> index
      "affine.for"(%82) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map3}> ({
      ^bb0(%arg14: index):
        %83 = "memref.dim"(%72, %69) : (memref<?x?xf32>, index) -> index
        %84 = "memref.view"(%81, %69, %arg14, %83) : (memref<?xi8>, index, index, index) -> memref<?x?xf32>
        %85 = "memref.subview"(%72, %69, %69, %83, %arg14, %70, %70) <{operandSegmentSizes = array<i32: 1, 2, 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (memref<?x?xf32>, index, index, index, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
        %86 = "memref.dim"(%84, %70) : (memref<?x?xf32>, index) -> index
        %87 = "memref.dim"(%85, %69) : (memref<?x?xf32, strided<[?, ?], offset: ?>>, index) -> index
        "affine.for"(%86, %87) <{lowerBoundMap = #map3, operandSegmentSizes = array<i32: 1, 1, 0>, step = 1 : index, upperBoundMap = #map3}> ({
        ^bb0(%arg16: index):
          "foo"() : () -> ()
          "affine.yield"() : () -> ()
        }) : (index, index) -> ()
        %88 = "memref.subview"(%72, %arg14) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 17, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<?x?xf32>, index) -> memref<17x?xf32, strided<[?, 1]>>
        %89 = "memref.dim"(%84, %70) : (memref<?x?xf32>, index) -> index
        %90 = "memref.dim"(%88, %70) : (memref<17x?xf32, strided<[?, 1]>>, index) -> index
        "scf.for"(%89, %90, %70) ({
        ^bb0(%arg15: index):
          "foo"() : () -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        "affine.yield"() : () -> ()
      }) : (index) -> ()
      "affine.yield"() : () -> ()
    }) : (index) -> ()
    %75 = "memref.view"(%arg6, %69, %arg7, %arg9) : (memref<?xi8>, index, index, index) -> memref<?x?xf32>
    %76 = "memref.view"(%arg6, %69, %arg9, %arg8) : (memref<?xi8>, index, index, index) -> memref<?x?xf32>
    %77 = "memref.view"(%arg6, %69, %arg7, %arg8) : (memref<?xi8>, index, index, index) -> memref<?x?xf32>
    %78 = "memref.dim"(%75, %69) : (memref<?x?xf32>, index) -> index
    %79 = "memref.dim"(%75, %70) : (memref<?x?xf32>, index) -> index
    %80 = "memref.dim"(%77, %70) : (memref<?x?xf32>, index) -> index
    "scf.for"(%69, %78, %70) ({
    ^bb0(%arg10: index):
      "scf.for"(%69, %80, %70) ({
      ^bb0(%arg11: index):
        "scf.for"(%69, %79, %70) ({
        ^bb0(%arg12: index):
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (index, index), sym_name = "merge_constants"}> ({
    %67 = "arith.constant"() <{value = 42 : index}> : () -> index
    %68 = "arith.constant"() <{value = 42 : index}> : () -> index
    "func.return"(%67, %68) : (index, index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<8xi32>) -> (), sym_name = "hoist_constant"}> ({
  ^bb0(%arg1: memref<8xi32>):
    "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map4}> ({
    ^bb0(%arg2: index):
      %66 = "arith.constant"() <{value = 42 : i32}> : () -> i32
      "memref.store"(%66, %arg1, %arg2) : (i32, memref<8xi32>, index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<?x?xf32>, sym_name = "const_fold_propagate"}> ({
    %62 = "arith.constant"() <{value = 512 : index}> : () -> index
    %63 = "affine.apply"(%62) <{map = #map5}> : (index) -> index
    %64 = "affine.apply"(%62) <{map = #map6}> : (index) -> index
    %65 = "memref.alloc"(%63, %64) <{operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
    "func.return"(%65) : (memref<?x?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "indirect_target"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "indirect_call_folding"}> ({
    %61 = "func.constant"() <{value = @indirect_target}> : () -> (() -> ())
    "func.call_indirect"(%61) : (() -> ()) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (index, index), sym_name = "lowered_affine_mod"}> ({
    %47 = "arith.constant"() <{value = -43 : index}> : () -> index
    %48 = "arith.constant"() <{value = 42 : index}> : () -> index
    %49 = "arith.remsi"(%47, %48) : (index, index) -> index
    %50 = "arith.constant"() <{value = 0 : index}> : () -> index
    %51 = "arith.cmpi"(%49, %50) <{predicate = 2 : i64}> : (index, index) -> i1
    %52 = "arith.addi"(%49, %48) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %53 = "arith.select"(%51, %52, %49) : (i1, index, index) -> index
    %54 = "arith.constant"() <{value = 43 : index}> : () -> index
    %55 = "arith.constant"() <{value = 42 : index}> : () -> index
    %56 = "arith.remsi"(%54, %55) : (index, index) -> index
    %57 = "arith.constant"() <{value = 0 : index}> : () -> index
    %58 = "arith.cmpi"(%56, %57) <{predicate = 2 : i64}> : (index, index) -> i1
    %59 = "arith.addi"(%56, %55) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %60 = "arith.select"(%58, %59, %56) : (i1, index, index) -> index
    "func.return"(%53, %60) : (index, index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (index, index), sym_name = "lowered_affine_floordiv"}> ({
    %27 = "arith.constant"() <{value = -43 : index}> : () -> index
    %28 = "arith.constant"() <{value = 42 : index}> : () -> index
    %29 = "arith.constant"() <{value = 0 : index}> : () -> index
    %30 = "arith.constant"() <{value = -1 : index}> : () -> index
    %31 = "arith.cmpi"(%27, %29) <{predicate = 2 : i64}> : (index, index) -> i1
    %32 = "arith.subi"(%30, %27) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %33 = "arith.select"(%31, %32, %27) : (i1, index, index) -> index
    %34 = "arith.divsi"(%33, %28) : (index, index) -> index
    %35 = "arith.subi"(%30, %34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %36 = "arith.select"(%31, %35, %34) : (i1, index, index) -> index
    %37 = "arith.constant"() <{value = 43 : index}> : () -> index
    %38 = "arith.constant"() <{value = 42 : index}> : () -> index
    %39 = "arith.constant"() <{value = 0 : index}> : () -> index
    %40 = "arith.constant"() <{value = -1 : index}> : () -> index
    %41 = "arith.cmpi"(%37, %39) <{predicate = 2 : i64}> : (index, index) -> i1
    %42 = "arith.subi"(%40, %37) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %43 = "arith.select"(%41, %42, %37) : (i1, index, index) -> index
    %44 = "arith.divsi"(%43, %38) : (index, index) -> index
    %45 = "arith.subi"(%40, %44) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %46 = "arith.select"(%41, %45, %44) : (i1, index, index) -> index
    "func.return"(%36, %46) : (index, index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (index, index), sym_name = "lowered_affine_ceildiv"}> ({
    %3 = "arith.constant"() <{value = -43 : index}> : () -> index
    %4 = "arith.constant"() <{value = 42 : index}> : () -> index
    %5 = "arith.constant"() <{value = 0 : index}> : () -> index
    %6 = "arith.constant"() <{value = 1 : index}> : () -> index
    %7 = "arith.cmpi"(%3, %5) <{predicate = 3 : i64}> : (index, index) -> i1
    %8 = "arith.subi"(%5, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %9 = "arith.subi"(%3, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %10 = "arith.select"(%7, %8, %9) : (i1, index, index) -> index
    %11 = "arith.divsi"(%10, %4) : (index, index) -> index
    %12 = "arith.subi"(%5, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %13 = "arith.addi"(%11, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %14 = "arith.select"(%7, %12, %13) : (i1, index, index) -> index
    %15 = "arith.constant"() <{value = 43 : index}> : () -> index
    %16 = "arith.constant"() <{value = 42 : index}> : () -> index
    %17 = "arith.constant"() <{value = 0 : index}> : () -> index
    %18 = "arith.constant"() <{value = 1 : index}> : () -> index
    %19 = "arith.cmpi"(%15, %17) <{predicate = 3 : i64}> : (index, index) -> i1
    %20 = "arith.subi"(%17, %15) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %21 = "arith.subi"(%15, %18) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %22 = "arith.select"(%19, %20, %21) : (i1, index, index) -> index
    %23 = "arith.divsi"(%22, %16) : (index, index) -> index
    %24 = "arith.subi"(%17, %23) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %25 = "arith.addi"(%23, %18) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %26 = "arith.select"(%19, %24, %25) : (i1, index, index) -> index
    "func.return"(%14, %26) : (index, index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi32>) -> memref<2xi32>, sym_name = "cast_values"}> ({
  ^bb0(%arg0: memref<?xi32>):
    %0 = "memref.cast"(%arg0) : (memref<?xi32>) -> memref<?xi32>
    %1 = "memref.cast"(%0) : (memref<?xi32>) -> memref<2xi32>
    %2 = "memref.cast"(%1) : (memref<2xi32>) -> memref<2xi32>
    "func.return"(%2) : (memref<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (f32, f32, f32, f32), sym_name = "view"}> ({
  ^bb0(%arg0: index):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2048xi8>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 7 : index}> : () -> index
    %3 = "arith.constant"() <{value = 11 : index}> : () -> index
    %4 = "arith.constant"() <{value = 15 : index}> : () -> index
    %5 = "memref.view"(%0, %4, %2, %3) : (memref<2048xi8>, index, index, index) -> memref<?x?xf32>
    %6 = "memref.load"(%5, %1, %1) : (memref<?x?xf32>, index, index) -> f32
    %7 = "memref.view"(%0, %4, %arg0, %arg0, %2) : (memref<2048xi8>, index, index, index, index) -> memref<?x?x?xf32>
    %8 = "memref.load"(%7, %1, %1, %1) : (memref<?x?x?xf32>, index, index, index) -> f32
    %9 = "memref.view"(%0, %4, %2) : (memref<2048xi8>, index, index) -> memref<?x4xf32>
    %10 = "memref.load"(%9, %1, %1) : (memref<?x4xf32>, index, index) -> f32
    %11 = "memref.cast"(%0) : (memref<2048xi8>) -> memref<?xi8>
    %12 = "memref.view"(%11, %4, %4, %2) : (memref<?xi8>, index, index, index) -> memref<?x?xf32>
    %13 = "memref.load"(%12, %1, %1) : (memref<?x?xf32>, index, index) -> f32
    "func.return"(%6, %8, %10, %13) : (f32, f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<() -> (100)>
#set = affine_set<(d0) : (d0 - 2 >= 0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (index, index), sym_name = "subview"}> ({
  ^bb0(%arg4: index, %arg5: index):
    %9 = "arith.constant"() <{value = 0 : index}> : () -> index
    %10 = "arith.constant"() <{value = 1 : index}> : () -> index
    %11 = "arith.constant"() <{value = 2 : index}> : () -> index
    %12 = "arith.constant"() <{value = 7 : index}> : () -> index
    %13 = "arith.constant"() <{value = 11 : index}> : () -> index
    %14 = "arith.constant"() <{value = 15 : index}> : () -> index
    %15 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128x96x64xf32, strided<[6144, 64, 1]>>
    %16 = "memref.subview"(%15, %9, %9, %9, %12, %13, %11, %10, %10, %10) <{operandSegmentSizes = array<i32: 1, 3, 3, 3>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (memref<128x96x64xf32, strided<[6144, 64, 1]>>, index, index, index, index, index, index, index, index, index) -> memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    %17 = "memref.load"(%16, %9, %9, %9) : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index, index, index) -> f32
    %18 = "memref.subview"(%15, %9, %arg4, %9, %12, %13, %14, %10, %10, %10) <{operandSegmentSizes = array<i32: 1, 3, 3, 3>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (memref<128x96x64xf32, strided<[6144, 64, 1]>>, index, index, index, index, index, index, index, index, index) -> memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    "memref.store"(%17, %18, %9, %9, %9) : (f32, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index, index, index) -> ()
    %19 = "memref.alloc"(%arg4) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?x16x4xf32, strided<[64, 4, 1]>>
    %20 = "memref.subview"(%19, %9, %9, %9, %12, %13, %11, %10, %10, %10) <{operandSegmentSizes = array<i32: 1, 3, 3, 3>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (memref<?x16x4xf32, strided<[64, 4, 1]>>, index, index, index, index, index, index, index, index, index) -> memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    "memref.store"(%17, %20, %9, %9, %9) : (f32, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index, index, index) -> ()
    %21 = "memref.subview"(%15, %10, %11, %12, %12, %13, %11, %10, %10, %10) <{operandSegmentSizes = array<i32: 1, 3, 3, 3>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (memref<128x96x64xf32, strided<[6144, 64, 1]>>, index, index, index, index, index, index, index, index, index) -> memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    "memref.store"(%17, %21, %9, %9, %9) : (f32, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index, index, index) -> ()
    %22 = "memref.subview"(%15, %9, %9, %9, %12, %13, %11, %11, %12, %13) <{operandSegmentSizes = array<i32: 1, 3, 3, 3>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (memref<128x96x64xf32, strided<[6144, 64, 1]>>, index, index, index, index, index, index, index, index, index) -> memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    "memref.store"(%17, %22, %9, %9, %9) : (f32, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index, index, index) -> ()
    %23 = "memref.subview"(%15, %arg4, %arg4, %arg4, %12, %13, %11, %arg5, %arg5, %arg5) <{operandSegmentSizes = array<i32: 1, 3, 3, 3>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (memref<128x96x64xf32, strided<[6144, 64, 1]>>, index, index, index, index, index, index, index, index, index) -> memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    "memref.store"(%17, %23, %arg5, %arg5, %arg5) : (f32, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index, index, index) -> ()
    %24 = "memref.subview"(%15, %arg4, %arg4, %arg4, %arg5, %arg5, %arg5, %11, %12, %13) <{operandSegmentSizes = array<i32: 1, 3, 3, 3>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (memref<128x96x64xf32, strided<[6144, 64, 1]>>, index, index, index, index, index, index, index, index, index) -> memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    "memref.store"(%17, %24, %arg4, %arg4, %arg4) : (f32, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index, index, index) -> ()
    %25 = "memref.subview"(%15, %10, %11, %12, %arg5, %arg5, %arg5, %arg4, %arg4, %arg4) <{operandSegmentSizes = array<i32: 1, 3, 3, 3>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (memref<128x96x64xf32, strided<[6144, 64, 1]>>, index, index, index, index, index, index, index, index, index) -> memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    "memref.store"(%17, %25, %arg5, %arg5, %arg5) : (f32, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index, index, index) -> ()
    %26 = "memref.alloc"(%arg4, %arg4, %arg5) <{operandSegmentSizes = array<i32: 3, 0>}> : (index, index, index) -> memref<?x?x?xf32>
    %27 = "memref.subview"(%26, %arg4, %arg4, %arg4, %12, %13, %11, %arg5, %arg5, %arg5) <{operandSegmentSizes = array<i32: 1, 3, 3, 3>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (memref<?x?x?xf32>, index, index, index, index, index, index, index, index, index) -> memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    "memref.store"(%17, %27, %arg5, %arg5, %arg5) : (f32, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index, index, index) -> ()
    %28 = "memref.subview"(%26, %arg4, %arg4, %arg4, %arg5, %arg5, %arg5, %11, %11, %11) <{operandSegmentSizes = array<i32: 1, 3, 3, 3>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (memref<?x?x?xf32>, index, index, index, index, index, index, index, index, index) -> memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    "memref.store"(%17, %28, %arg4, %arg4, %arg4) : (f32, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index, index, index) -> ()
    %29 = "memref.subview"(%26, %10, %10, %10, %arg4, %arg4, %arg4, %arg5, %arg5, %arg5) <{operandSegmentSizes = array<i32: 1, 3, 3, 3>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (memref<?x?x?xf32>, index, index, index, index, index, index, index, index, index) -> memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    "memref.store"(%17, %29, %arg4, %arg4, %arg4) : (f32, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index, index, index) -> ()
    %30 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128x64xf32>
    %31 = "arith.constant"() <{value = 4 : index}> : () -> index
    %32 = "memref.subview"(%30, %arg5, %arg5, %11, %31) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<128x64xf32>, index, index, index, index) -> memref<?x?xf32, strided<[64, 1], offset: ?>>
    "memref.store"(%17, %32, %arg5, %arg5) : (f32, memref<?x?xf32, strided<[64, 1], offset: ?>>, index, index) -> ()
    %33 = "memref.subview"(%30, %11, %31) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 12, 4>, static_strides = array<i64: 1, 1>}> : (memref<128x64xf32>, index, index) -> memref<12x4xf32, strided<[64, 1], offset: ?>>
    "memref.store"(%17, %33, %arg5, %arg5) : (f32, memref<12x4xf32, strided<[64, 1], offset: ?>>, index, index) -> ()
    %34 = "memref.dim"(%20, %9) : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index) -> index
    %35 = "memref.dim"(%20, %10) : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index) -> index
    "func.return"(%34, %35) : (index, index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i16) -> i16, sym_name = "index_cast"}> ({
  ^bb0(%arg3: i16):
    %7 = "arith.index_cast"(%arg3) : (i16) -> index
    %8 = "arith.index_cast"(%7) : (index) -> i16
    "func.return"(%8) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i16, index), sym_name = "index_cast_fold"}> ({
    %3 = "arith.constant"() <{value = 4 : index}> : () -> index
    %4 = "arith.index_cast"(%3) : (index) -> i16
    %5 = "arith.constant"() <{value = 4 : i16}> : () -> i16
    %6 = "arith.index_cast"(%5) : (i16) -> index
    "func.return"(%4, %6) : (i16, index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<100xi32>) -> (), sym_name = "remove_dead_else"}> ({
  ^bb0(%arg0: memref<100xi32>):
    "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg1: index):
      %0 = "affine.load"(%arg0, %arg1) <{map = #map}> : (memref<100xi32>, index) -> i32
      "affine.if"(%arg1) <{condition = #set}> ({
        "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map2}> ({
        ^bb0(%arg2: index):
          %2 = "affine.load"(%arg0, %arg2) <{map = #map}> : (memref<100xi32>, index) -> i32
          "prevent.dce"(%2) : (i32) -> ()
          "affine.yield"() : () -> ()
        }) : () -> ()
        "affine.yield"() : () -> ()
      }, {
        "affine.yield"() : () -> ()
      }) : (index) -> ()
      %1 = "affine.load"(%arg0, %arg1) <{map = #map}> : (memref<100xi32>, index) -> i32
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "divi_signed_by_one"}> ({
  ^bb0(%arg3: i32):
    %6 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %7 = "arith.divsi"(%arg3, %6) : (i32, i32) -> i32
    "func.return"(%7) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "divi_unsigned_by_one"}> ({
  ^bb0(%arg2: i32):
    %4 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %5 = "arith.divui"(%arg2, %4) : (i32, i32) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x5xi32>) -> tensor<4x5xi32>, sym_name = "tensor_divi_signed_by_one"}> ({
  ^bb0(%arg1: tensor<4x5xi32>):
    %2 = "arith.constant"() <{value = dense<1> : tensor<4x5xi32>}> : () -> tensor<4x5xi32>
    %3 = "arith.divsi"(%arg1, %2) : (tensor<4x5xi32>, tensor<4x5xi32>) -> tensor<4x5xi32>
    "func.return"(%3) : (tensor<4x5xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x5xi32>) -> tensor<4x5xi32>, sym_name = "tensor_divi_unsigned_by_one"}> ({
  ^bb0(%arg0: tensor<4x5xi32>):
    %0 = "arith.constant"() <{value = dense<1> : tensor<4x5xi32>}> : () -> tensor<4x5xi32>
    %1 = "arith.divui"(%arg0, %0) : (tensor<4x5xi32>, tensor<4x5xi32>) -> tensor<4x5xi32>
    "func.return"(%1) : (tensor<4x5xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "arith.floordivsi_by_one"}> ({
  ^bb0(%arg1: i32):
    %5 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %6 = "arith.floordivsi"(%arg1, %5) : (i32, i32) -> i32
    "func.return"(%6) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x5xi32>) -> tensor<4x5xi32>, sym_name = "tensor_arith.floordivsi_by_one"}> ({
  ^bb0(%arg0: tensor<4x5xi32>):
    %3 = "arith.constant"() <{value = dense<1> : tensor<4x5xi32>}> : () -> tensor<4x5xi32>
    %4 = "arith.floordivsi"(%arg0, %3) : (tensor<4x5xi32>, tensor<4x5xi32>) -> tensor<4x5xi32>
    "func.return"(%4) : (tensor<4x5xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "arith.floordivsi_by_one_overflow"}> ({
    %0 = "arith.constant"() <{value = -1 : i64}> : () -> i64
    %1 = "arith.constant"() <{value = -9223372036854775808 : i64}> : () -> i64
    %2 = "arith.floordivsi"(%1, %0) : (i64, i64) -> i64
    "func.return"(%2) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "arith.ceildivsi_by_one"}> ({
  ^bb0(%arg1: i32):
    %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %3 = "arith.ceildivsi"(%arg1, %2) : (i32, i32) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x5xi32>) -> tensor<4x5xi32>, sym_name = "tensor_arith.ceildivsi_by_one"}> ({
  ^bb0(%arg0: tensor<4x5xi32>):
    %0 = "arith.constant"() <{value = dense<1> : tensor<4x5xi32>}> : () -> tensor<4x5xi32>
    %1 = "arith.ceildivsi"(%arg0, %0) : (tensor<4x5xi32>, tensor<4x5xi32>) -> tensor<4x5xi32>
    "func.return"(%1) : (tensor<4x5xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "arith.ceildivui_by_one"}> ({
  ^bb0(%arg1: i32):
    %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %3 = "arith.ceildivui"(%arg1, %2) : (i32, i32) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x5xi32>) -> tensor<4x5xi32>, sym_name = "tensor_arith.ceildivui_by_one"}> ({
  ^bb0(%arg0: tensor<4x5xi32>):
    %0 = "arith.constant"() <{value = dense<1> : tensor<4x5xi32>}> : () -> tensor<4x5xi32>
    %1 = "arith.ceildivui"(%arg0, %0) : (tensor<4x5xi32>, tensor<4x5xi32>) -> tensor<4x5xi32>
    "func.return"(%1) : (tensor<4x5xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x5xf32>, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>, sym_name = "memref_cast_folding_subview"}> ({
  ^bb0(%arg0: memref<4x5xf32>, %arg1: index):
    %0 = "memref.cast"(%arg0) : (memref<4x5xf32>) -> memref<?x?xf32>
    %1 = "memref.subview"(%0, %arg1, %arg1, %arg1, %arg1, %arg1, %arg1) <{operandSegmentSizes = array<i32: 1, 2, 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (memref<?x?xf32>, index, index, index, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
    "func.return"(%1) : (memref<?x?xf32, strided<[?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x16xf32>, index, index) -> memref<3x4xf32, strided<[?, 1]>>, sym_name = "memref_cast_folding_subview_static"}> ({
  ^bb0(%arg0: memref<16x16xf32>, %arg1: index, %arg2: index):
    %0 = "memref.cast"(%arg0) : (memref<16x16xf32>) -> memref<?x?xf32>
    %1 = "memref.subview"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 3, 4>, static_strides = array<i64: 1, 1>}> : (memref<?x?xf32>) -> memref<3x4xf32, strided<[?, 1]>>
    "func.return"(%1) : (memref<3x4xf32, strided<[?, 1]>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<8x16x4xf32>, index, index) -> tensor<?x?x?xf32>, sym_name = "slice"}> ({
  ^bb0(%arg0: tensor<8x16x4xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "arith.constant"() <{value = 7 : index}> : () -> index
    %4 = "arith.constant"() <{value = 11 : index}> : () -> index
    %5 = "tensor.extract_slice"(%arg0, %0, %0, %0, %3, %4, %2, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 3, 3, 3>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (tensor<8x16x4xf32>, index, index, index, index, index, index, index, index, index) -> tensor<?x?x?xf32>
    %6 = "tensor.extract_slice"(%5, %0, %0, %0, %2, %arg1, %2, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 3, 3, 3>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (tensor<?x?x?xf32>, index, index, index, index, index, index, index, index, index) -> tensor<?x?x?xf32>
    "func.return"(%6) : (tensor<?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i1, sym_name = "fold_trunci"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.extui"(%arg0) : (i1) -> i8
    %1 = "arith.trunci"(%0) <{overflowFlags = #arith.overflow<none>}> : (i8) -> i1
    "func.return"(%1) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi1>) -> vector<4xi1>, sym_name = "fold_trunci_vector"}> ({
  ^bb0(%arg0: vector<4xi1>):
    %0 = "arith.extui"(%arg0) : (vector<4xi1>) -> vector<4xi8>
    %1 = "arith.trunci"(%0) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi8>) -> vector<4xi1>
    "func.return"(%1) : (vector<4xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i2, sym_name = "fold_trunci"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.extui"(%arg0) : (i1) -> i8
    %1 = "arith.trunci"(%0) <{overflowFlags = #arith.overflow<none>}> : (i8) -> i2
    "func.return"(%1) : (i2) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi1>) -> vector<4xi2>, sym_name = "fold_trunci_vector"}> ({
  ^bb0(%arg0: vector<4xi1>):
    %0 = "arith.extui"(%arg0) : (vector<4xi1>) -> vector<4xi8>
    %1 = "arith.trunci"(%0) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi8>) -> vector<4xi2>
    "func.return"(%1) : (vector<4xi2>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i1, sym_name = "fold_trunci_sexti"}> ({
  ^bb0(%arg0: i1):
    %2 = "arith.extsi"(%arg0) : (i1) -> i8
    %3 = "arith.trunci"(%2) <{overflowFlags = #arith.overflow<none>}> : (i8) -> i1
    "func.return"(%3) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<5xf32>, sym_name = "simple_clone_elimination"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32>
    %1 = "bufferization.clone"(%0) : (memref<5xf32>) -> memref<5xf32>
    "memref.dealloc"(%1) : (memref<5xf32>) -> ()
    "func.return"(%0) : (memref<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, memref<2xf32>, memref<2xf32>) -> (), sym_name = "clone_loop_alloc"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: memref<2xf32>, %arg4: memref<2xf32>):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf32>
    "memref.dealloc"(%0) : (memref<2xf32>) -> ()
    %1 = "bufferization.clone"(%arg3) : (memref<2xf32>) -> memref<2xf32>
    %2 = "scf.for"(%arg0, %arg1, %arg2, %1) ({
    ^bb0(%arg5: index, %arg6: memref<2xf32>):
      %3 = "arith.cmpi"(%arg5, %arg1) <{predicate = 0 : i64}> : (index, index) -> i1
      "memref.dealloc"(%arg6) : (memref<2xf32>) -> ()
      %4 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf32>
      %5 = "bufferization.clone"(%4) : (memref<2xf32>) -> memref<2xf32>
      "memref.dealloc"(%4) : (memref<2xf32>) -> ()
      %6 = "bufferization.clone"(%5) : (memref<2xf32>) -> memref<2xf32>
      "memref.dealloc"(%5) : (memref<2xf32>) -> ()
      "scf.yield"(%6) : (memref<2xf32>) -> ()
    }) : (index, index, index, memref<2xf32>) -> memref<2xf32>
    "memref.copy"(%2, %arg4) : (memref<2xf32>, memref<2xf32>) -> ()
    "memref.dealloc"(%2) : (memref<2xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> memref<?x?xf32>, sym_name = "clone_nested_region"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.cmpi"(%arg0, %arg1) <{predicate = 0 : i64}> : (index, index) -> i1
    %1 = "arith.cmpi"(%arg0, %arg1) <{predicate = 0 : i64}> : (index, index) -> i1
    %2 = "memref.alloc"(%arg0, %arg0) <{operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
    %3 = "scf.if"(%1) ({
      %6 = "scf.if"(%0) ({
        %10 = "bufferization.clone"(%2) : (memref<?x?xf32>) -> memref<?x?xf32>
        "scf.yield"(%10) : (memref<?x?xf32>) -> ()
      }, {
        %8 = "memref.alloc"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
        %9 = "bufferization.clone"(%8) : (memref<?x?xf32>) -> memref<?x?xf32>
        "memref.dealloc"(%8) : (memref<?x?xf32>) -> ()
        "scf.yield"(%9) : (memref<?x?xf32>) -> ()
      }) : (i1) -> memref<?x?xf32>
      %7 = "bufferization.clone"(%6) : (memref<?x?xf32>) -> memref<?x?xf32>
      "memref.dealloc"(%6) : (memref<?x?xf32>) -> ()
      "scf.yield"(%7) : (memref<?x?xf32>) -> ()
    }, {
      %4 = "memref.alloc"(%arg1, %arg1) <{operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
      %5 = "bufferization.clone"(%4) : (memref<?x?xf32>) -> memref<?x?xf32>
      "memref.dealloc"(%4) : (memref<?x?xf32>) -> ()
      "scf.yield"(%5) : (memref<?x?xf32>) -> ()
    }) : (i1) -> memref<?x?xf32>
    "memref.dealloc"(%2) : (memref<?x?xf32>) -> ()
    "func.return"(%3) : (memref<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i64, sym_name = "test_materialize_failure"}> ({
    %0 = "index.constant"() <{value = 1234 : index}> : () -> index
    %1 = "index.castu"(%0) : (index) -> i64
    "func.return"(%1) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

