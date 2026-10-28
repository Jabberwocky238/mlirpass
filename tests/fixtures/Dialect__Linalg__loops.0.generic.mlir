#map = affine_map<(d0, d1) -> (d0 + d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi8>, index, index, index) -> (), sym_name = "matmul"}> ({
  ^bb0(%arg114: memref<?xi8>, %arg115: index, %arg116: index, %arg117: index):
    %195 = "arith.constant"() <{value = 1 : index}> : () -> index
    %196 = "arith.constant"() <{value = 0 : index}> : () -> index
    %197 = "memref.view"(%arg114, %196, %arg115, %arg117) : (memref<?xi8>, index, index, index) -> memref<?x?xf32>
    %198 = "memref.view"(%arg114, %196, %arg117, %arg116) : (memref<?xi8>, index, index, index) -> memref<?x?xf32>
    %199 = "memref.view"(%arg114, %196, %arg115, %arg116) : (memref<?xi8>, index, index, index) -> memref<?x?xf32>
    "scf.for"(%196, %arg115, %195) ({
    ^bb0(%arg118: index):
      "scf.for"(%196, %arg116, %195) ({
      ^bb0(%arg119: index):
        "scf.for"(%196, %arg117, %195) ({
        ^bb0(%arg120: index):
          %200 = "memref.load"(%197, %arg118, %arg120) <{nontemporal = false}> : (memref<?x?xf32>, index, index) -> f32
          %201 = "memref.load"(%198, %arg120, %arg119) <{nontemporal = false}> : (memref<?x?xf32>, index, index) -> f32
          %202 = "memref.load"(%199, %arg118, %arg119) <{nontemporal = false}> : (memref<?x?xf32>, index, index) -> f32
          %203 = "arith.mulf"(%200, %201) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          %204 = "arith.addf"(%202, %203) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "memref.store"(%204, %199, %arg118, %arg119) <{nontemporal = false}> : (f32, memref<?x?xf32>, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi8>, index, index) -> (), sym_name = "matvec"}> ({
  ^bb0(%arg109: memref<?xi8>, %arg110: index, %arg111: index):
    %185 = "arith.constant"() <{value = 1 : index}> : () -> index
    %186 = "arith.constant"() <{value = 0 : index}> : () -> index
    %187 = "memref.view"(%arg109, %186, %arg110, %arg111) : (memref<?xi8>, index, index, index) -> memref<?x?xf32>
    %188 = "memref.view"(%arg109, %186, %arg110) : (memref<?xi8>, index, index) -> memref<?xf32>
    %189 = "memref.view"(%arg109, %186, %arg111) : (memref<?xi8>, index, index) -> memref<?xf32>
    "scf.for"(%186, %arg110, %185) ({
    ^bb0(%arg112: index):
      "scf.for"(%186, %arg111, %185) ({
      ^bb0(%arg113: index):
        %190 = "memref.load"(%187, %arg112, %arg113) <{nontemporal = false}> : (memref<?x?xf32>, index, index) -> f32
        %191 = "memref.load"(%188, %arg113) <{nontemporal = false}> : (memref<?xf32>, index) -> f32
        %192 = "memref.load"(%189, %arg112) <{nontemporal = false}> : (memref<?xf32>, index) -> f32
        %193 = "arith.mulf"(%190, %191) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %194 = "arith.addf"(%192, %193) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "memref.store"(%194, %189, %arg112) <{nontemporal = false}> : (f32, memref<?xf32>, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi8>, index) -> (), sym_name = "dot"}> ({
  ^bb0(%arg106: memref<?xi8>, %arg107: index):
    %175 = "arith.constant"() <{value = 1 : index}> : () -> index
    %176 = "arith.constant"() <{value = 0 : index}> : () -> index
    %177 = "memref.view"(%arg106, %176, %arg107) : (memref<?xi8>, index, index) -> memref<?xf32>
    %178 = "memref.view"(%arg106, %176, %arg107) : (memref<?xi8>, index, index) -> memref<?xf32>
    %179 = "memref.view"(%arg106, %176) : (memref<?xi8>, index) -> memref<f32>
    "scf.for"(%176, %arg107, %175) ({
    ^bb0(%arg108: index):
      %180 = "memref.load"(%177, %arg108) <{nontemporal = false}> : (memref<?xf32>, index) -> f32
      %181 = "memref.load"(%178, %arg108) <{nontemporal = false}> : (memref<?xf32>, index) -> f32
      %182 = "memref.load"(%179) <{nontemporal = false}> : (memref<f32>) -> f32
      %183 = "arith.mulf"(%180, %181) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %184 = "arith.addf"(%182, %183) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "memref.store"(%184, %179) <{nontemporal = false}> : (f32, memref<f32>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi32>, memref<?xi32>, memref<i32>) -> (), sym_name = "dot_int"}> ({
  ^bb0(%arg102: memref<?xi32>, %arg103: memref<?xi32>, %arg104: memref<i32>):
    %167 = "arith.constant"() <{value = 1 : index}> : () -> index
    %168 = "arith.constant"() <{value = 0 : index}> : () -> index
    %169 = "memref.dim"(%arg102, %168) : (memref<?xi32>, index) -> index
    "scf.for"(%168, %169, %167) ({
    ^bb0(%arg105: index):
      %170 = "memref.load"(%arg102, %arg105) <{nontemporal = false}> : (memref<?xi32>, index) -> i32
      %171 = "memref.load"(%arg103, %arg105) <{nontemporal = false}> : (memref<?xi32>, index) -> i32
      %172 = "memref.load"(%arg104) <{nontemporal = false}> : (memref<i32>) -> i32
      %173 = "arith.muli"(%170, %171) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %174 = "arith.addi"(%172, %173) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "memref.store"(%174, %arg104) <{nontemporal = false}> : (i32, memref<i32>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi1>, memref<?xi1>, memref<i1>) -> (), sym_name = "dot_bool"}> ({
  ^bb0(%arg98: memref<?xi1>, %arg99: memref<?xi1>, %arg100: memref<i1>):
    %159 = "arith.constant"() <{value = 1 : index}> : () -> index
    %160 = "arith.constant"() <{value = 0 : index}> : () -> index
    %161 = "memref.dim"(%arg98, %160) : (memref<?xi1>, index) -> index
    "scf.for"(%160, %161, %159) ({
    ^bb0(%arg101: index):
      %162 = "memref.load"(%arg98, %arg101) <{nontemporal = false}> : (memref<?xi1>, index) -> i1
      %163 = "memref.load"(%arg99, %arg101) <{nontemporal = false}> : (memref<?xi1>, index) -> i1
      %164 = "memref.load"(%arg100) <{nontemporal = false}> : (memref<i1>) -> i1
      %165 = "arith.andi"(%162, %163) : (i1, i1) -> i1
      %166 = "arith.ori"(%164, %165) : (i1, i1) -> i1
      "memref.store"(%166, %arg100) <{nontemporal = false}> : (i1, memref<i1>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1], offset: ?>>, memref<f32>) -> (), sym_name = "dot_view"}> ({
  ^bb0(%arg94: memref<?xf32, strided<[1], offset: ?>>, %arg95: memref<?xf32, strided<[1], offset: ?>>, %arg96: memref<f32>):
    %151 = "arith.constant"() <{value = 1 : index}> : () -> index
    %152 = "arith.constant"() <{value = 0 : index}> : () -> index
    %153 = "memref.dim"(%arg94, %152) : (memref<?xf32, strided<[1], offset: ?>>, index) -> index
    "scf.for"(%152, %153, %151) ({
    ^bb0(%arg97: index):
      %154 = "memref.load"(%arg94, %arg97) <{nontemporal = false}> : (memref<?xf32, strided<[1], offset: ?>>, index) -> f32
      %155 = "memref.load"(%arg95, %arg97) <{nontemporal = false}> : (memref<?xf32, strided<[1], offset: ?>>, index) -> f32
      %156 = "memref.load"(%arg96) <{nontemporal = false}> : (memref<f32>) -> f32
      %157 = "arith.mulf"(%154, %155) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %158 = "arith.addf"(%156, %157) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "memref.store"(%158, %arg96) <{nontemporal = false}> : (f32, memref<f32>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, strided<[1], offset: ?>>, f32) -> (), sym_name = "fill_view"}> ({
  ^bb0(%arg91: memref<?xf32, strided<[1], offset: ?>>, %arg92: f32):
    %148 = "arith.constant"() <{value = 1 : index}> : () -> index
    %149 = "arith.constant"() <{value = 0 : index}> : () -> index
    %150 = "memref.dim"(%arg91, %149) : (memref<?xf32, strided<[1], offset: ?>>, index) -> index
    "scf.for"(%149, %150, %148) ({
    ^bb0(%arg93: index):
      "memref.store"(%arg92, %arg91, %arg93) <{nontemporal = false}> : (f32, memref<?xf32, strided<[1], offset: ?>>, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32>, f32) -> (), sym_name = "fill_view0"}> ({
  ^bb0(%arg89: memref<f32>, %arg90: f32):
    "memref.store"(%arg90, %arg89) <{nontemporal = false}> : (f32, memref<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, f32) -> (), sym_name = "fill_view3"}> ({
  ^bb0(%arg84: memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, %arg85: f32):
    %142 = "arith.constant"() <{value = 2 : index}> : () -> index
    %143 = "arith.constant"() <{value = 1 : index}> : () -> index
    %144 = "arith.constant"() <{value = 0 : index}> : () -> index
    %145 = "memref.dim"(%arg84, %144) : (memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, index) -> index
    %146 = "memref.dim"(%arg84, %143) : (memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, index) -> index
    %147 = "memref.dim"(%arg84, %142) : (memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, index) -> index
    "scf.for"(%144, %145, %143) ({
    ^bb0(%arg86: index):
      "scf.for"(%144, %146, %143) ({
      ^bb0(%arg87: index):
        "scf.for"(%144, %147, %143) ({
        ^bb0(%arg88: index):
          "memref.store"(%arg85, %arg84, %arg86, %arg87, %arg88) <{nontemporal = false}> : (f32, memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, index, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1], offset: ?>>) -> (), sym_name = "copy_view"}> ({
  ^bb0(%arg81: memref<?xf32, strided<[1], offset: ?>>, %arg82: memref<?xf32, strided<[1], offset: ?>>):
    %138 = "arith.constant"() <{value = 1 : index}> : () -> index
    %139 = "arith.constant"() <{value = 0 : index}> : () -> index
    %140 = "memref.dim"(%arg81, %139) : (memref<?xf32, strided<[1], offset: ?>>, index) -> index
    "scf.for"(%139, %140, %138) ({
    ^bb0(%arg83: index):
      %141 = "memref.load"(%arg81, %arg83) <{nontemporal = false}> : (memref<?xf32, strided<[1], offset: ?>>, index) -> f32
      "memref.store"(%141, %arg82, %arg83) <{nontemporal = false}> : (f32, memref<?xf32, strided<[1], offset: ?>>, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf32, strided<[?, 1], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) -> (), sym_name = "generic_region"}> ({
  ^bb0(%arg75: memref<?x?xf32, strided<[?, 1], offset: ?>>, %arg76: memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, %arg77: memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>):
    %127 = "arith.constant"() <{value = 2 : index}> : () -> index
    %128 = "arith.constant"() <{value = 1 : index}> : () -> index
    %129 = "arith.constant"() <{value = 0 : index}> : () -> index
    %130 = "memref.dim"(%arg75, %129) : (memref<?x?xf32, strided<[?, 1], offset: ?>>, index) -> index
    %131 = "memref.dim"(%arg75, %128) : (memref<?x?xf32, strided<[?, 1], offset: ?>>, index) -> index
    %132 = "memref.dim"(%arg76, %127) : (memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, index) -> index
    "scf.for"(%129, %130, %128) ({
    ^bb0(%arg78: index):
      "scf.for"(%129, %131, %128) ({
      ^bb0(%arg79: index):
        "scf.for"(%129, %132, %128) ({
        ^bb0(%arg80: index):
          %133 = "memref.load"(%arg75, %arg78, %arg79) <{nontemporal = false}> : (memref<?x?xf32, strided<[?, 1], offset: ?>>, index, index) -> f32
          %134 = "memref.load"(%arg76, %arg78, %arg79, %arg80) <{nontemporal = false}> : (memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, index, index, index) -> f32
          %135 = "memref.load"(%arg77, %arg78, %arg80, %arg79) <{nontemporal = false}> : (memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, index, index, index) -> f32
          %136 = "arith.mulf"(%133, %134) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          %137 = "arith.addf"(%135, %136) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "memref.store"(%136, %arg76, %arg78, %arg79, %arg80) <{nontemporal = false}> : (f32, memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, index, index, index) -> ()
          "memref.store"(%137, %arg77, %arg78, %arg80, %arg79) <{nontemporal = false}> : (f32, memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, index, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf32, strided<[?, 1], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) -> (), sym_name = "generic_index_region"}> ({
  ^bb0(%arg69: memref<?x?xf32, strided<[?, 1], offset: ?>>, %arg70: memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, %arg71: memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>):
    %112 = "arith.constant"() <{value = 2 : index}> : () -> index
    %113 = "arith.constant"() <{value = 1 : index}> : () -> index
    %114 = "arith.constant"() <{value = 0 : index}> : () -> index
    %115 = "memref.dim"(%arg69, %114) : (memref<?x?xf32, strided<[?, 1], offset: ?>>, index) -> index
    %116 = "memref.dim"(%arg69, %113) : (memref<?x?xf32, strided<[?, 1], offset: ?>>, index) -> index
    %117 = "memref.dim"(%arg70, %112) : (memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, index) -> index
    "scf.for"(%114, %115, %113) ({
    ^bb0(%arg72: index):
      "scf.for"(%114, %116, %113) ({
      ^bb0(%arg73: index):
        "scf.for"(%114, %117, %113) ({
        ^bb0(%arg74: index):
          %118 = "memref.load"(%arg69, %arg72, %arg73) <{nontemporal = false}> : (memref<?x?xf32, strided<[?, 1], offset: ?>>, index, index) -> f32
          %119 = "memref.load"(%arg70, %arg72, %arg73, %arg74) <{nontemporal = false}> : (memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, index, index, index) -> f32
          %120 = "memref.load"(%arg71, %arg72, %arg74, %arg73) <{nontemporal = false}> : (memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, index, index, index) -> f32
          %121 = "arith.mulf"(%118, %119) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          %122 = "arith.addi"(%arg72, %arg73) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %123 = "arith.addi"(%122, %arg74) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %124 = "arith.index_cast"(%123) : (index) -> i32
          %125 = "arith.sitofp"(%124) : (i32) -> f32
          %126 = "arith.addf"(%120, %125) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "memref.store"(%121, %arg70, %arg72, %arg73, %arg74) <{nontemporal = false}> : (f32, memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, index, index, index) -> ()
          "memref.store"(%126, %arg71, %arg72, %arg74, %arg73) <{nontemporal = false}> : (f32, memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, index, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32>, memref<3x4xf32>) -> (), sym_name = "generic_op_zero_rank"}> ({
  ^bb0(%arg65: memref<f32>, %arg66: memref<3x4xf32>):
    %107 = "arith.constant"() <{value = 0 : index}> : () -> index
    %108 = "arith.constant"() <{value = 3 : index}> : () -> index
    %109 = "arith.constant"() <{value = 1 : index}> : () -> index
    %110 = "arith.constant"() <{value = 4 : index}> : () -> index
    "scf.for"(%107, %108, %109) ({
    ^bb0(%arg67: index):
      "scf.for"(%107, %110, %109) ({
      ^bb0(%arg68: index):
        %111 = "memref.load"(%arg65) <{nontemporal = false}> : (memref<f32>) -> f32
        "memref.store"(%111, %arg66, %arg67, %arg68) <{nontemporal = false}> : (f32, memref<3x4xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, memref<3x4xf32>) -> (), sym_name = "generic_op_scalar"}> ({
  ^bb0(%arg61: f32, %arg62: memref<3x4xf32>):
    %103 = "arith.constant"() <{value = 0 : index}> : () -> index
    %104 = "arith.constant"() <{value = 3 : index}> : () -> index
    %105 = "arith.constant"() <{value = 1 : index}> : () -> index
    %106 = "arith.constant"() <{value = 4 : index}> : () -> index
    "scf.for"(%103, %104, %105) ({
    ^bb0(%arg63: index):
      "scf.for"(%103, %106, %105) ({
      ^bb0(%arg64: index):
        "memref.store"(%arg61, %arg62, %arg63, %arg64) <{nontemporal = false}> : (f32, memref<3x4xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i32>, memref<3x4xi32>) -> (), sym_name = "generic_index_op_zero_rank"}> ({
  ^bb0(%arg57: memref<i32>, %arg58: memref<3x4xi32>):
    %95 = "arith.constant"() <{value = 0 : index}> : () -> index
    %96 = "arith.constant"() <{value = 3 : index}> : () -> index
    %97 = "arith.constant"() <{value = 1 : index}> : () -> index
    %98 = "arith.constant"() <{value = 4 : index}> : () -> index
    "scf.for"(%95, %96, %97) ({
    ^bb0(%arg59: index):
      "scf.for"(%95, %98, %97) ({
      ^bb0(%arg60: index):
        %99 = "memref.load"(%arg57) <{nontemporal = false}> : (memref<i32>) -> i32
        %100 = "arith.addi"(%arg59, %arg60) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %101 = "arith.index_cast"(%100) : (index) -> i32
        %102 = "arith.addi"(%99, %101) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "memref.store"(%102, %arg58, %arg59, %arg60) <{nontemporal = false}> : (i32, memref<3x4xi32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, memref<f32>) -> (), sym_name = "generic_op_1D_reduce"}> ({
  ^bb0(%arg54: memref<?xf32>, %arg55: memref<f32>):
    %89 = "arith.constant"() <{value = 1 : index}> : () -> index
    %90 = "arith.constant"() <{value = 0 : index}> : () -> index
    %91 = "memref.dim"(%arg54, %90) : (memref<?xf32>, index) -> index
    "scf.for"(%90, %91, %89) ({
    ^bb0(%arg56: index):
      %92 = "memref.load"(%arg54, %arg56) <{nontemporal = false}> : (memref<?xf32>, index) -> f32
      %93 = "memref.load"(%arg55) <{nontemporal = false}> : (memref<f32>) -> f32
      %94 = "arith.addf"(%92, %93) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "memref.store"(%94, %arg55) <{nontemporal = false}> : (f32, memref<f32>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, memref<f32>, memref<f32>) -> (), sym_name = "generic_index_op_1D_reduce"}> ({
  ^bb0(%arg50: memref<?xf32>, %arg51: memref<f32>, %arg52: memref<f32>):
    %80 = "arith.constant"() <{value = 1 : index}> : () -> index
    %81 = "arith.constant"() <{value = 0 : index}> : () -> index
    %82 = "memref.dim"(%arg50, %81) : (memref<?xf32>, index) -> index
    "scf.for"(%81, %82, %80) ({
    ^bb0(%arg53: index):
      %83 = "memref.load"(%arg50, %arg53) <{nontemporal = false}> : (memref<?xf32>, index) -> f32
      %84 = "memref.load"(%arg51) <{nontemporal = false}> : (memref<f32>) -> f32
      %85 = "memref.load"(%arg52) <{nontemporal = false}> : (memref<f32>) -> f32
      %86 = "arith.cmpi"(%arg53, %81) <{predicate = 0 : i64}> : (index, index) -> i1
      %87 = "arith.select"(%86, %84, %85) : (i1, f32, f32) -> f32
      %88 = "arith.addf"(%83, %87) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "memref.store"(%88, %arg52) <{nontemporal = false}> : (f32, memref<f32>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>) -> (), sym_name = "generic_const_init"}> ({
  ^bb0(%arg48: memref<?xf32>):
    %76 = "arith.constant"() <{value = 1 : index}> : () -> index
    %77 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %78 = "arith.constant"() <{value = 0 : index}> : () -> index
    %79 = "memref.dim"(%arg48, %78) : (memref<?xf32>, index) -> index
    "scf.for"(%78, %79, %76) ({
    ^bb0(%arg49: index):
      "memref.store"(%77, %arg48, %arg49) <{nontemporal = false}> : (f32, memref<?xf32>, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32>, memref<f32>, memref<f32>, i1) -> (), sym_name = "scalar_code"}> ({
  ^bb0(%arg44: memref<f32>, %arg45: memref<f32>, %arg46: memref<f32>, %arg47: i1):
    %73 = "memref.load"(%arg44) <{nontemporal = false}> : (memref<f32>) -> f32
    %74 = "memref.load"(%arg45) <{nontemporal = false}> : (memref<f32>) -> f32
    %75 = "scf.if"(%arg47) ({
      "scf.yield"(%73) : (f32) -> ()
    }, {
      "scf.yield"(%74) : (f32) -> ()
    }) : (i1) -> f32
    "memref.store"(%75, %arg46) <{nontemporal = false}> : (f32, memref<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?x?xf32>, memref<?x?x?xf32>, memref<?x?xf32>) -> (), sym_name = "batch_reduce_matmul_as_contract"}> ({
  ^bb0(%arg37: memref<?x?x?xf32>, %arg38: memref<?x?x?xf32>, %arg39: memref<?x?xf32>):
    %61 = "arith.constant"() <{value = 2 : index}> : () -> index
    %62 = "arith.constant"() <{value = 1 : index}> : () -> index
    %63 = "arith.constant"() <{value = 0 : index}> : () -> index
    %64 = "memref.dim"(%arg37, %63) : (memref<?x?x?xf32>, index) -> index
    %65 = "memref.dim"(%arg37, %62) : (memref<?x?x?xf32>, index) -> index
    %66 = "memref.dim"(%arg37, %61) : (memref<?x?x?xf32>, index) -> index
    %67 = "memref.dim"(%arg38, %61) : (memref<?x?x?xf32>, index) -> index
    "scf.for"(%63, %64, %62) ({
    ^bb0(%arg40: index):
      "scf.for"(%63, %65, %62) ({
      ^bb0(%arg41: index):
        "scf.for"(%63, %67, %62) ({
        ^bb0(%arg42: index):
          "scf.for"(%63, %66, %62) ({
          ^bb0(%arg43: index):
            %68 = "memref.load"(%arg37, %arg40, %arg41, %arg43) <{nontemporal = false}> : (memref<?x?x?xf32>, index, index, index) -> f32
            %69 = "memref.load"(%arg38, %arg40, %arg43, %arg42) <{nontemporal = false}> : (memref<?x?x?xf32>, index, index, index) -> f32
            %70 = "memref.load"(%arg39, %arg41, %arg42) <{nontemporal = false}> : (memref<?x?xf32>, index, index) -> f32
            %71 = "arith.mulf"(%68, %69) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
            %72 = "arith.addf"(%70, %71) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
            "memref.store"(%72, %arg39, %arg41, %arg42) <{nontemporal = false}> : (f32, memref<?x?xf32>, index, index) -> ()
            "scf.yield"() : () -> ()
          }) : (index, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?x?xf32>, memref<?x?x?xf32>, memref<?x?x?xf32>) -> (), sym_name = "named_batch_matmul"}> ({
  ^bb0(%arg30: memref<?x?x?xf32>, %arg31: memref<?x?x?xf32>, %arg32: memref<?x?x?xf32>):
    %49 = "arith.constant"() <{value = 2 : index}> : () -> index
    %50 = "arith.constant"() <{value = 1 : index}> : () -> index
    %51 = "arith.constant"() <{value = 0 : index}> : () -> index
    %52 = "memref.dim"(%arg30, %51) : (memref<?x?x?xf32>, index) -> index
    %53 = "memref.dim"(%arg30, %50) : (memref<?x?x?xf32>, index) -> index
    %54 = "memref.dim"(%arg30, %49) : (memref<?x?x?xf32>, index) -> index
    %55 = "memref.dim"(%arg31, %49) : (memref<?x?x?xf32>, index) -> index
    "scf.for"(%51, %52, %50) ({
    ^bb0(%arg33: index):
      "scf.for"(%51, %53, %50) ({
      ^bb0(%arg34: index):
        "scf.for"(%51, %55, %50) ({
        ^bb0(%arg35: index):
          "scf.for"(%51, %54, %50) ({
          ^bb0(%arg36: index):
            %56 = "memref.load"(%arg30, %arg33, %arg34, %arg36) <{nontemporal = false}> : (memref<?x?x?xf32>, index, index, index) -> f32
            %57 = "memref.load"(%arg31, %arg33, %arg36, %arg35) <{nontemporal = false}> : (memref<?x?x?xf32>, index, index, index) -> f32
            %58 = "memref.load"(%arg32, %arg33, %arg34, %arg35) <{nontemporal = false}> : (memref<?x?x?xf32>, index, index, index) -> f32
            %59 = "arith.mulf"(%56, %57) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
            %60 = "arith.addf"(%58, %59) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
            "memref.store"(%60, %arg32, %arg33, %arg34, %arg35) <{nontemporal = false}> : (f32, memref<?x?x?xf32>, index, index, index) -> ()
            "scf.yield"() : () -> ()
          }) : (index, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>) -> (), sym_name = "conv1d_no_symbols"}> ({
  ^bb0(%arg25: memref<?xf32>, %arg26: memref<?xf32>, %arg27: memref<?xf32>):
    %39 = "arith.constant"() <{value = 1 : index}> : () -> index
    %40 = "arith.constant"() <{value = 0 : index}> : () -> index
    %41 = "memref.dim"(%arg26, %40) : (memref<?xf32>, index) -> index
    %42 = "memref.dim"(%arg27, %40) : (memref<?xf32>, index) -> index
    "scf.for"(%40, %42, %39) ({
    ^bb0(%arg28: index):
      "scf.for"(%40, %41, %39) ({
      ^bb0(%arg29: index):
        %43 = "affine.apply"(%arg28, %arg29) <{map = #map}> : (index, index) -> index
        %44 = "memref.load"(%arg25, %43) <{nontemporal = false}> : (memref<?xf32>, index) -> f32
        %45 = "memref.load"(%arg26, %arg29) <{nontemporal = false}> : (memref<?xf32>, index) -> f32
        %46 = "memref.load"(%arg27, %arg28) <{nontemporal = false}> : (memref<?xf32>, index) -> f32
        %47 = "arith.mulf"(%44, %45) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %48 = "arith.addf"(%46, %47) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "memref.store"(%48, %arg27, %arg28) <{nontemporal = false}> : (f32, memref<?xf32>, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf32>, memref<?x?xf32>, memref<?x?xf32>) -> (), sym_name = "conv2d_no_symbols"}> ({
  ^bb0(%arg18: memref<?x?xf32>, %arg19: memref<?x?xf32>, %arg20: memref<?x?xf32>):
    %26 = "arith.constant"() <{value = 1 : index}> : () -> index
    %27 = "arith.constant"() <{value = 0 : index}> : () -> index
    %28 = "memref.dim"(%arg19, %27) : (memref<?x?xf32>, index) -> index
    %29 = "memref.dim"(%arg19, %26) : (memref<?x?xf32>, index) -> index
    %30 = "memref.dim"(%arg20, %27) : (memref<?x?xf32>, index) -> index
    %31 = "memref.dim"(%arg20, %26) : (memref<?x?xf32>, index) -> index
    "scf.for"(%27, %30, %26) ({
    ^bb0(%arg21: index):
      "scf.for"(%27, %31, %26) ({
      ^bb0(%arg22: index):
        "scf.for"(%27, %28, %26) ({
        ^bb0(%arg23: index):
          "scf.for"(%27, %29, %26) ({
          ^bb0(%arg24: index):
            %32 = "affine.apply"(%arg21, %arg23) <{map = #map}> : (index, index) -> index
            %33 = "affine.apply"(%arg22, %arg24) <{map = #map}> : (index, index) -> index
            %34 = "memref.load"(%arg18, %32, %33) <{nontemporal = false}> : (memref<?x?xf32>, index, index) -> f32
            %35 = "memref.load"(%arg19, %arg23, %arg24) <{nontemporal = false}> : (memref<?x?xf32>, index, index) -> f32
            %36 = "memref.load"(%arg20, %arg21, %arg22) <{nontemporal = false}> : (memref<?x?xf32>, index, index) -> f32
            %37 = "arith.mulf"(%34, %35) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
            %38 = "arith.addf"(%36, %37) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
            "memref.store"(%38, %arg20, %arg21, %arg22) <{nontemporal = false}> : (f32, memref<?x?xf32>, index, index) -> ()
            "scf.yield"() : () -> ()
          }) : (index, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?x?xf32>, memref<?x?x?xf32>, memref<?x?x?xf32>) -> (), sym_name = "conv3d_no_symbols"}> ({
  ^bb0(%arg9: memref<?x?x?xf32>, %arg10: memref<?x?x?xf32>, %arg11: memref<?x?x?xf32>):
    %9 = "arith.constant"() <{value = 2 : index}> : () -> index
    %10 = "arith.constant"() <{value = 1 : index}> : () -> index
    %11 = "arith.constant"() <{value = 0 : index}> : () -> index
    %12 = "memref.dim"(%arg10, %11) : (memref<?x?x?xf32>, index) -> index
    %13 = "memref.dim"(%arg10, %10) : (memref<?x?x?xf32>, index) -> index
    %14 = "memref.dim"(%arg10, %9) : (memref<?x?x?xf32>, index) -> index
    %15 = "memref.dim"(%arg11, %11) : (memref<?x?x?xf32>, index) -> index
    %16 = "memref.dim"(%arg11, %10) : (memref<?x?x?xf32>, index) -> index
    %17 = "memref.dim"(%arg11, %9) : (memref<?x?x?xf32>, index) -> index
    "scf.for"(%11, %15, %10) ({
    ^bb0(%arg12: index):
      "scf.for"(%11, %16, %10) ({
      ^bb0(%arg13: index):
        "scf.for"(%11, %17, %10) ({
        ^bb0(%arg14: index):
          "scf.for"(%11, %12, %10) ({
          ^bb0(%arg15: index):
            "scf.for"(%11, %13, %10) ({
            ^bb0(%arg16: index):
              "scf.for"(%11, %14, %10) ({
              ^bb0(%arg17: index):
                %18 = "affine.apply"(%arg12, %arg15) <{map = #map}> : (index, index) -> index
                %19 = "affine.apply"(%arg13, %arg16) <{map = #map}> : (index, index) -> index
                %20 = "affine.apply"(%arg14, %arg17) <{map = #map}> : (index, index) -> index
                %21 = "memref.load"(%arg9, %18, %19, %20) <{nontemporal = false}> : (memref<?x?x?xf32>, index, index, index) -> f32
                %22 = "memref.load"(%arg10, %arg15, %arg16, %arg17) <{nontemporal = false}> : (memref<?x?x?xf32>, index, index, index) -> f32
                %23 = "memref.load"(%arg11, %arg12, %arg13, %arg14) <{nontemporal = false}> : (memref<?x?x?xf32>, index, index, index) -> f32
                %24 = "arith.mulf"(%21, %22) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
                %25 = "arith.addf"(%23, %24) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
                "memref.store"(%25, %arg11, %arg12, %arg13, %arg14) <{nontemporal = false}> : (f32, memref<?x?x?xf32>, index, index, index) -> ()
                "scf.yield"() : () -> ()
              }) : (index, index, index) -> ()
              "scf.yield"() : () -> ()
            }) : (index, index, index) -> ()
            "scf.yield"() : () -> ()
          }) : (index, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi32>, memref<?x?xi32>, index, index, index) -> (), sym_name = "lower_to_loops_with_rank_reducing_subviews"}> ({
  ^bb0(%arg3: memref<?xi32>, %arg4: memref<?x?xi32>, %arg5: index, %arg6: index, %arg7: index):
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "arith.constant"() <{value = 0 : index}> : () -> index
    %6 = "memref.subview"(%arg3, %arg5, %arg6) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xi32>, index, index) -> memref<?xi32, strided<[1], offset: ?>>
    %7 = "memref.subview"(%arg4, %arg7, %arg6) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: 1, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<?x?xi32>, index, index) -> memref<?xi32, strided<[1], offset: ?>>
    "scf.for"(%5, %arg6, %4) ({
    ^bb0(%arg8: index):
      %8 = "memref.load"(%6, %arg8) <{nontemporal = false}> : (memref<?xi32, strided<[1], offset: ?>>, index) -> i32
      "memref.store"(%8, %7, %arg8) <{nontemporal = false}> : (i32, memref<?xi32, strided<[1], offset: ?>>, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>) -> (), sym_name = "transpose"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "memref.dim"(%arg0, %1) : (memref<?xf32>, index) -> index
    "scf.for"(%1, %2, %0) ({
    ^bb0(%arg2: index):
      %3 = "memref.load"(%arg0, %arg2) <{nontemporal = false}> : (memref<?xf32>, index) -> f32
      "memref.store"(%3, %arg1, %arg2) <{nontemporal = false}> : (f32, memref<?xf32>, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

