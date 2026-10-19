#map = affine_map<() -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>) -> (), sym_name = "vector_transfer_ops_0d"}> ({
  ^bb0(%arg0: memref<f32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "vector.transfer_read"(%arg0, %0) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 0, 1, 0>, permutation_map = #map}> : (memref<f32>, f32) -> vector<f32>
    "vector.transfer_write"(%1, %arg0) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 0, 0>, permutation_map = #map}> : (vector<f32>, memref<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0 + d1)>
#map1 = affine_map<(d0) -> (d0 + 1)>
#map2 = affine_map<(d0) -> (d0 + 2)>
#map3 = affine_map<(d0) -> (d0 + 3)>
#map4 = affine_map<() -> (0)>
#map5 = affine_map<() -> (42)>
#map6 = affine_map<() -> (7)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "materialize_read_1d"}> ({
    %0 = "arith.constant"() <{value = 7 : index}> : () -> index
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 4 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<7x42xf32>
    "affine.for"() <{lowerBoundMap = #map4, operandSegmentSizes = array<i32: 0, 0, 0>, step = 4 : index, upperBoundMap = #map6}> ({
    ^bb0(%arg0: index):
      "affine.for"() <{lowerBoundMap = #map4, operandSegmentSizes = array<i32: 0, 0, 0>, step = 4 : index, upperBoundMap = #map5}> ({
      ^bb0(%arg1: index):
        %6 = "scf.for"(%4, %3, %2, %1) ({
        ^bb0(%arg8: index, %arg9: vector<4xf32>):
          %31 = "affine.apply"(%arg0, %arg8) <{map = #map}> : (index, index) -> index
          %32 = "affine.apply"(%arg0, %arg8) <{map = #map}> : (index, index) -> index
          %33 = "arith.cmpi"(%32, %0) <{predicate = 2 : i64}> : (index, index) -> i1
          %34 = "scf.if"(%33) ({
            %35 = "memref.load"(%5, %31, %arg1) <{nontemporal = false}> : (memref<7x42xf32>, index, index) -> f32
            %36 = "vector.insert"(%35, %arg9, %arg8) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<4xf32>, index) -> vector<4xf32>
            "scf.yield"(%36) : (vector<4xf32>) -> ()
          }, {
            "scf.yield"(%arg9) : (vector<4xf32>) -> ()
          }) : (i1) -> vector<4xf32>
          "scf.yield"(%34) : (vector<4xf32>) -> ()
        }) : (index, index, index, vector<4xf32>) -> vector<4xf32>
        %7 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
        %8 = "scf.for"(%4, %3, %2, %1) ({
        ^bb0(%arg6: index, %arg7: vector<4xf32>):
          %25 = "affine.apply"(%arg0, %arg6) <{map = #map}> : (index, index) -> index
          %26 = "affine.apply"(%arg0, %arg6) <{map = #map}> : (index, index) -> index
          %27 = "arith.cmpi"(%26, %0) <{predicate = 2 : i64}> : (index, index) -> i1
          %28 = "scf.if"(%27) ({
            %29 = "memref.load"(%5, %25, %7) <{nontemporal = false}> : (memref<7x42xf32>, index, index) -> f32
            %30 = "vector.insert"(%29, %arg7, %arg6) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<4xf32>, index) -> vector<4xf32>
            "scf.yield"(%30) : (vector<4xf32>) -> ()
          }, {
            "scf.yield"(%arg7) : (vector<4xf32>) -> ()
          }) : (i1) -> vector<4xf32>
          "scf.yield"(%28) : (vector<4xf32>) -> ()
        }) : (index, index, index, vector<4xf32>) -> vector<4xf32>
        %9 = "affine.apply"(%arg1) <{map = #map2}> : (index) -> index
        %10 = "scf.for"(%4, %3, %2, %1) ({
        ^bb0(%arg4: index, %arg5: vector<4xf32>):
          %19 = "affine.apply"(%arg0, %arg4) <{map = #map}> : (index, index) -> index
          %20 = "affine.apply"(%arg0, %arg4) <{map = #map}> : (index, index) -> index
          %21 = "arith.cmpi"(%20, %0) <{predicate = 2 : i64}> : (index, index) -> i1
          %22 = "scf.if"(%21) ({
            %23 = "memref.load"(%5, %19, %9) <{nontemporal = false}> : (memref<7x42xf32>, index, index) -> f32
            %24 = "vector.insert"(%23, %arg5, %arg4) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<4xf32>, index) -> vector<4xf32>
            "scf.yield"(%24) : (vector<4xf32>) -> ()
          }, {
            "scf.yield"(%arg5) : (vector<4xf32>) -> ()
          }) : (i1) -> vector<4xf32>
          "scf.yield"(%22) : (vector<4xf32>) -> ()
        }) : (index, index, index, vector<4xf32>) -> vector<4xf32>
        %11 = "affine.apply"(%arg1) <{map = #map3}> : (index) -> index
        %12 = "scf.for"(%4, %3, %2, %1) ({
        ^bb0(%arg2: index, %arg3: vector<4xf32>):
          %13 = "affine.apply"(%arg0, %arg2) <{map = #map}> : (index, index) -> index
          %14 = "affine.apply"(%arg0, %arg2) <{map = #map}> : (index, index) -> index
          %15 = "arith.cmpi"(%14, %0) <{predicate = 2 : i64}> : (index, index) -> i1
          %16 = "scf.if"(%15) ({
            %17 = "memref.load"(%5, %13, %11) <{nontemporal = false}> : (memref<7x42xf32>, index, index) -> f32
            %18 = "vector.insert"(%17, %arg3, %arg2) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<4xf32>, index) -> vector<4xf32>
            "scf.yield"(%18) : (vector<4xf32>) -> ()
          }, {
            "scf.yield"(%arg3) : (vector<4xf32>) -> ()
          }) : (i1) -> vector<4xf32>
          "scf.yield"(%16) : (vector<4xf32>) -> ()
        }) : (index, index, index, vector<4xf32>) -> vector<4xf32>
        "dummy_use"(%6, %8, %10, %12) : (vector<4xf32>, vector<4xf32>, vector<4xf32>, vector<4xf32>) -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0 + d1)>
#map1 = affine_map<(d0, d1) -> (d0 + d1 + 1)>
#map2 = affine_map<() -> (0)>
#map3 = affine_map<()[s0] -> (s0)>
#map4 = affine_map<() -> (42)>
#map5 = affine_map<() -> (7)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "materialize_read_1d_partially_specialized"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 42 : index}> : () -> index
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 4 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "memref.alloc"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 3, 0>}> : (index, index, index) -> memref<7x?x?x42x?xf32>
    "affine.for"() <{lowerBoundMap = #map2, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map5}> ({
    ^bb0(%arg3: index):
      "affine.for"(%arg0) <{lowerBoundMap = #map2, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map3}> ({
      ^bb0(%arg4: index):
        "affine.for"(%arg1) <{lowerBoundMap = #map2, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map3}> ({
        ^bb0(%arg5: index):
          "affine.for"() <{lowerBoundMap = #map2, operandSegmentSizes = array<i32: 0, 0, 0>, step = 2 : index, upperBoundMap = #map4}> ({
          ^bb0(%arg6: index):
            "affine.for"(%arg2) <{lowerBoundMap = #map2, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map3}> ({
            ^bb0(%arg7: index):
              %6 = "scf.for"(%4, %3, %2, %1) ({
              ^bb0(%arg10: index, %arg11: vector<4xf32>):
                %14 = "affine.apply"(%arg6, %arg10) <{map = #map}> : (index, index) -> index
                %15 = "affine.apply"(%arg6, %arg10) <{map = #map}> : (index, index) -> index
                %16 = "arith.cmpi"(%15, %0) <{predicate = 2 : i64}> : (index, index) -> i1
                %17 = "scf.if"(%16) ({
                  %18 = "memref.load"(%5, %arg3, %arg4, %arg5, %14, %arg7) <{nontemporal = false}> : (memref<7x?x?x42x?xf32>, index, index, index, index, index) -> f32
                  %19 = "vector.insert"(%18, %arg11, %arg10) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<4xf32>, index) -> vector<4xf32>
                  "scf.yield"(%19) : (vector<4xf32>) -> ()
                }, {
                  "scf.yield"(%arg11) : (vector<4xf32>) -> ()
                }) : (i1) -> vector<4xf32>
                "scf.yield"(%17) : (vector<4xf32>) -> ()
              }) : (index, index, index, vector<4xf32>) -> vector<4xf32>
              %7 = "scf.for"(%4, %3, %2, %1) ({
              ^bb0(%arg8: index, %arg9: vector<4xf32>):
                %8 = "affine.apply"(%arg8, %arg6) <{map = #map1}> : (index, index) -> index
                %9 = "affine.apply"(%arg8, %arg6) <{map = #map1}> : (index, index) -> index
                %10 = "arith.cmpi"(%9, %0) <{predicate = 2 : i64}> : (index, index) -> i1
                %11 = "scf.if"(%10) ({
                  %12 = "memref.load"(%5, %arg3, %arg4, %arg5, %8, %arg7) <{nontemporal = false}> : (memref<7x?x?x42x?xf32>, index, index, index, index, index) -> f32
                  %13 = "vector.insert"(%12, %arg9, %arg8) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<4xf32>, index) -> vector<4xf32>
                  "scf.yield"(%13) : (vector<4xf32>) -> ()
                }, {
                  "scf.yield"(%arg9) : (vector<4xf32>) -> ()
                }) : (i1) -> vector<4xf32>
                "scf.yield"(%11) : (vector<4xf32>) -> ()
              }) : (index, index, index, vector<4xf32>) -> vector<4xf32>
              "dummy_use"(%6, %7) : (vector<4xf32>, vector<4xf32>) -> ()
              "affine.yield"() : () -> ()
            }) : (index) -> ()
            "affine.yield"() : () -> ()
          }) : () -> ()
          "affine.yield"() : () -> ()
        }) : (index) -> ()
        "affine.yield"() : () -> ()
      }) : (index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0 + d1)>
#map1 = affine_map<(d0) -> (d0 + 1)>
#map2 = affine_map<(d0) -> (d0 + 2)>
#map3 = affine_map<(d0) -> (d0 + 3)>
#map4 = affine_map<(d0) -> (d0 + 4)>
#map5 = affine_map<() -> (0)>
#map6 = affine_map<()[s0] -> (s0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index) -> (), sym_name = "materialize_read"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<3xf32>}> : () -> vector<3xf32>
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 3 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = dense<0.000000e+00> : vector<5x4x3xf32>}> : () -> vector<5x4x3xf32>
    %5 = "memref.alloc"(%arg0, %arg1, %arg2, %arg3) <{operandSegmentSizes = array<i32: 4, 0>}> : (index, index, index, index) -> memref<?x?x?x?xf32>
    "affine.for"(%arg0) <{lowerBoundMap = #map5, operandSegmentSizes = array<i32: 0, 1, 0>, step = 3 : index, upperBoundMap = #map6}> ({
    ^bb0(%arg4: index):
      "affine.for"(%arg1) <{lowerBoundMap = #map5, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map6}> ({
      ^bb0(%arg5: index):
        "affine.for"(%arg2) <{lowerBoundMap = #map5, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map6}> ({
        ^bb0(%arg6: index):
          "affine.for"(%arg3) <{lowerBoundMap = #map5, operandSegmentSizes = array<i32: 0, 1, 0>, step = 5 : index, upperBoundMap = #map6}> ({
          ^bb0(%arg7: index):
            %6 = "arith.cmpi"(%arg3, %arg7) <{predicate = 4 : i64}> : (index, index) -> i1
            %7 = "scf.if"(%6) ({
              %152 = "scf.for"(%3, %2, %1, %0) ({
              ^bb0(%arg46: index, %arg47: vector<3xf32>):
                %178 = "affine.apply"(%arg4, %arg46) <{map = #map}> : (index, index) -> index
                %179 = "affine.apply"(%arg4, %arg46) <{map = #map}> : (index, index) -> index
                %180 = "arith.cmpi"(%arg0, %179) <{predicate = 4 : i64}> : (index, index) -> i1
                %181 = "scf.if"(%180) ({
                  %182 = "memref.load"(%5, %178, %arg5, %arg6, %arg7) <{nontemporal = false}> : (memref<?x?x?x?xf32>, index, index, index, index) -> f32
                  %183 = "vector.insert"(%182, %arg47, %arg46) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<3xf32>, index) -> vector<3xf32>
                  "scf.yield"(%183) : (vector<3xf32>) -> ()
                }, {
                  "scf.yield"(%arg47) : (vector<3xf32>) -> ()
                }) : (i1) -> vector<3xf32>
                "scf.yield"(%181) : (vector<3xf32>) -> ()
              }) : (index, index, index, vector<3xf32>) -> vector<3xf32>
              %153 = "vector.insert"(%152, %4) <{static_position = array<i64: 0, 0>}> : (vector<3xf32>, vector<5x4x3xf32>) -> vector<5x4x3xf32>
              %154 = "scf.for"(%3, %2, %1, %0) ({
              ^bb0(%arg44: index, %arg45: vector<3xf32>):
                %172 = "affine.apply"(%arg4, %arg44) <{map = #map}> : (index, index) -> index
                %173 = "affine.apply"(%arg4, %arg44) <{map = #map}> : (index, index) -> index
                %174 = "arith.cmpi"(%arg0, %173) <{predicate = 4 : i64}> : (index, index) -> i1
                %175 = "scf.if"(%174) ({
                  %176 = "memref.load"(%5, %172, %arg5, %arg6, %arg7) <{nontemporal = false}> : (memref<?x?x?x?xf32>, index, index, index, index) -> f32
                  %177 = "vector.insert"(%176, %arg45, %arg44) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<3xf32>, index) -> vector<3xf32>
                  "scf.yield"(%177) : (vector<3xf32>) -> ()
                }, {
                  "scf.yield"(%arg45) : (vector<3xf32>) -> ()
                }) : (i1) -> vector<3xf32>
                "scf.yield"(%175) : (vector<3xf32>) -> ()
              }) : (index, index, index, vector<3xf32>) -> vector<3xf32>
              %155 = "vector.insert"(%154, %153) <{static_position = array<i64: 0, 1>}> : (vector<3xf32>, vector<5x4x3xf32>) -> vector<5x4x3xf32>
              %156 = "scf.for"(%3, %2, %1, %0) ({
              ^bb0(%arg42: index, %arg43: vector<3xf32>):
                %166 = "affine.apply"(%arg4, %arg42) <{map = #map}> : (index, index) -> index
                %167 = "affine.apply"(%arg4, %arg42) <{map = #map}> : (index, index) -> index
                %168 = "arith.cmpi"(%arg0, %167) <{predicate = 4 : i64}> : (index, index) -> i1
                %169 = "scf.if"(%168) ({
                  %170 = "memref.load"(%5, %166, %arg5, %arg6, %arg7) <{nontemporal = false}> : (memref<?x?x?x?xf32>, index, index, index, index) -> f32
                  %171 = "vector.insert"(%170, %arg43, %arg42) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<3xf32>, index) -> vector<3xf32>
                  "scf.yield"(%171) : (vector<3xf32>) -> ()
                }, {
                  "scf.yield"(%arg43) : (vector<3xf32>) -> ()
                }) : (i1) -> vector<3xf32>
                "scf.yield"(%169) : (vector<3xf32>) -> ()
              }) : (index, index, index, vector<3xf32>) -> vector<3xf32>
              %157 = "vector.insert"(%156, %155) <{static_position = array<i64: 0, 2>}> : (vector<3xf32>, vector<5x4x3xf32>) -> vector<5x4x3xf32>
              %158 = "scf.for"(%3, %2, %1, %0) ({
              ^bb0(%arg40: index, %arg41: vector<3xf32>):
                %160 = "affine.apply"(%arg4, %arg40) <{map = #map}> : (index, index) -> index
                %161 = "affine.apply"(%arg4, %arg40) <{map = #map}> : (index, index) -> index
                %162 = "arith.cmpi"(%arg0, %161) <{predicate = 4 : i64}> : (index, index) -> i1
                %163 = "scf.if"(%162) ({
                  %164 = "memref.load"(%5, %160, %arg5, %arg6, %arg7) <{nontemporal = false}> : (memref<?x?x?x?xf32>, index, index, index, index) -> f32
                  %165 = "vector.insert"(%164, %arg41, %arg40) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<3xf32>, index) -> vector<3xf32>
                  "scf.yield"(%165) : (vector<3xf32>) -> ()
                }, {
                  "scf.yield"(%arg41) : (vector<3xf32>) -> ()
                }) : (i1) -> vector<3xf32>
                "scf.yield"(%163) : (vector<3xf32>) -> ()
              }) : (index, index, index, vector<3xf32>) -> vector<3xf32>
              %159 = "vector.insert"(%158, %157) <{static_position = array<i64: 0, 3>}> : (vector<3xf32>, vector<5x4x3xf32>) -> vector<5x4x3xf32>
              "scf.yield"(%159) : (vector<5x4x3xf32>) -> ()
            }, {
              "scf.yield"(%4) : (vector<5x4x3xf32>) -> ()
            }) : (i1) -> vector<5x4x3xf32>
            %8 = "affine.apply"(%arg7) <{map = #map1}> : (index) -> index
            %9 = "arith.cmpi"(%arg3, %8) <{predicate = 4 : i64}> : (index, index) -> i1
            %10 = "scf.if"(%9) ({
              %119 = "affine.apply"(%arg7) <{map = #map1}> : (index) -> index
              %120 = "scf.for"(%3, %2, %1, %0) ({
              ^bb0(%arg38: index, %arg39: vector<3xf32>):
                %146 = "affine.apply"(%arg4, %arg38) <{map = #map}> : (index, index) -> index
                %147 = "affine.apply"(%arg4, %arg38) <{map = #map}> : (index, index) -> index
                %148 = "arith.cmpi"(%arg0, %147) <{predicate = 4 : i64}> : (index, index) -> i1
                %149 = "scf.if"(%148) ({
                  %150 = "memref.load"(%5, %146, %arg5, %arg6, %119) <{nontemporal = false}> : (memref<?x?x?x?xf32>, index, index, index, index) -> f32
                  %151 = "vector.insert"(%150, %arg39, %arg38) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<3xf32>, index) -> vector<3xf32>
                  "scf.yield"(%151) : (vector<3xf32>) -> ()
                }, {
                  "scf.yield"(%arg39) : (vector<3xf32>) -> ()
                }) : (i1) -> vector<3xf32>
                "scf.yield"(%149) : (vector<3xf32>) -> ()
              }) : (index, index, index, vector<3xf32>) -> vector<3xf32>
              %121 = "vector.insert"(%120, %7) <{static_position = array<i64: 1, 0>}> : (vector<3xf32>, vector<5x4x3xf32>) -> vector<5x4x3xf32>
              %122 = "scf.for"(%3, %2, %1, %0) ({
              ^bb0(%arg36: index, %arg37: vector<3xf32>):
                %140 = "affine.apply"(%arg4, %arg36) <{map = #map}> : (index, index) -> index
                %141 = "affine.apply"(%arg4, %arg36) <{map = #map}> : (index, index) -> index
                %142 = "arith.cmpi"(%arg0, %141) <{predicate = 4 : i64}> : (index, index) -> i1
                %143 = "scf.if"(%142) ({
                  %144 = "memref.load"(%5, %140, %arg5, %arg6, %119) <{nontemporal = false}> : (memref<?x?x?x?xf32>, index, index, index, index) -> f32
                  %145 = "vector.insert"(%144, %arg37, %arg36) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<3xf32>, index) -> vector<3xf32>
                  "scf.yield"(%145) : (vector<3xf32>) -> ()
                }, {
                  "scf.yield"(%arg37) : (vector<3xf32>) -> ()
                }) : (i1) -> vector<3xf32>
                "scf.yield"(%143) : (vector<3xf32>) -> ()
              }) : (index, index, index, vector<3xf32>) -> vector<3xf32>
              %123 = "vector.insert"(%122, %121) <{static_position = array<i64: 1, 1>}> : (vector<3xf32>, vector<5x4x3xf32>) -> vector<5x4x3xf32>
              %124 = "scf.for"(%3, %2, %1, %0) ({
              ^bb0(%arg34: index, %arg35: vector<3xf32>):
                %134 = "affine.apply"(%arg4, %arg34) <{map = #map}> : (index, index) -> index
                %135 = "affine.apply"(%arg4, %arg34) <{map = #map}> : (index, index) -> index
                %136 = "arith.cmpi"(%arg0, %135) <{predicate = 4 : i64}> : (index, index) -> i1
                %137 = "scf.if"(%136) ({
                  %138 = "memref.load"(%5, %134, %arg5, %arg6, %119) <{nontemporal = false}> : (memref<?x?x?x?xf32>, index, index, index, index) -> f32
                  %139 = "vector.insert"(%138, %arg35, %arg34) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<3xf32>, index) -> vector<3xf32>
                  "scf.yield"(%139) : (vector<3xf32>) -> ()
                }, {
                  "scf.yield"(%arg35) : (vector<3xf32>) -> ()
                }) : (i1) -> vector<3xf32>
                "scf.yield"(%137) : (vector<3xf32>) -> ()
              }) : (index, index, index, vector<3xf32>) -> vector<3xf32>
              %125 = "vector.insert"(%124, %123) <{static_position = array<i64: 1, 2>}> : (vector<3xf32>, vector<5x4x3xf32>) -> vector<5x4x3xf32>
              %126 = "scf.for"(%3, %2, %1, %0) ({
              ^bb0(%arg32: index, %arg33: vector<3xf32>):
                %128 = "affine.apply"(%arg4, %arg32) <{map = #map}> : (index, index) -> index
                %129 = "affine.apply"(%arg4, %arg32) <{map = #map}> : (index, index) -> index
                %130 = "arith.cmpi"(%arg0, %129) <{predicate = 4 : i64}> : (index, index) -> i1
                %131 = "scf.if"(%130) ({
                  %132 = "memref.load"(%5, %128, %arg5, %arg6, %119) <{nontemporal = false}> : (memref<?x?x?x?xf32>, index, index, index, index) -> f32
                  %133 = "vector.insert"(%132, %arg33, %arg32) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<3xf32>, index) -> vector<3xf32>
                  "scf.yield"(%133) : (vector<3xf32>) -> ()
                }, {
                  "scf.yield"(%arg33) : (vector<3xf32>) -> ()
                }) : (i1) -> vector<3xf32>
                "scf.yield"(%131) : (vector<3xf32>) -> ()
              }) : (index, index, index, vector<3xf32>) -> vector<3xf32>
              %127 = "vector.insert"(%126, %125) <{static_position = array<i64: 1, 3>}> : (vector<3xf32>, vector<5x4x3xf32>) -> vector<5x4x3xf32>
              "scf.yield"(%127) : (vector<5x4x3xf32>) -> ()
            }, {
              "scf.yield"(%7) : (vector<5x4x3xf32>) -> ()
            }) : (i1) -> vector<5x4x3xf32>
            %11 = "affine.apply"(%arg7) <{map = #map2}> : (index) -> index
            %12 = "arith.cmpi"(%arg3, %11) <{predicate = 4 : i64}> : (index, index) -> i1
            %13 = "scf.if"(%12) ({
              %86 = "affine.apply"(%arg7) <{map = #map2}> : (index) -> index
              %87 = "scf.for"(%3, %2, %1, %0) ({
              ^bb0(%arg30: index, %arg31: vector<3xf32>):
                %113 = "affine.apply"(%arg4, %arg30) <{map = #map}> : (index, index) -> index
                %114 = "affine.apply"(%arg4, %arg30) <{map = #map}> : (index, index) -> index
                %115 = "arith.cmpi"(%arg0, %114) <{predicate = 4 : i64}> : (index, index) -> i1
                %116 = "scf.if"(%115) ({
                  %117 = "memref.load"(%5, %113, %arg5, %arg6, %86) <{nontemporal = false}> : (memref<?x?x?x?xf32>, index, index, index, index) -> f32
                  %118 = "vector.insert"(%117, %arg31, %arg30) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<3xf32>, index) -> vector<3xf32>
                  "scf.yield"(%118) : (vector<3xf32>) -> ()
                }, {
                  "scf.yield"(%arg31) : (vector<3xf32>) -> ()
                }) : (i1) -> vector<3xf32>
                "scf.yield"(%116) : (vector<3xf32>) -> ()
              }) : (index, index, index, vector<3xf32>) -> vector<3xf32>
              %88 = "vector.insert"(%87, %10) <{static_position = array<i64: 2, 0>}> : (vector<3xf32>, vector<5x4x3xf32>) -> vector<5x4x3xf32>
              %89 = "scf.for"(%3, %2, %1, %0) ({
              ^bb0(%arg28: index, %arg29: vector<3xf32>):
                %107 = "affine.apply"(%arg4, %arg28) <{map = #map}> : (index, index) -> index
                %108 = "affine.apply"(%arg4, %arg28) <{map = #map}> : (index, index) -> index
                %109 = "arith.cmpi"(%arg0, %108) <{predicate = 4 : i64}> : (index, index) -> i1
                %110 = "scf.if"(%109) ({
                  %111 = "memref.load"(%5, %107, %arg5, %arg6, %86) <{nontemporal = false}> : (memref<?x?x?x?xf32>, index, index, index, index) -> f32
                  %112 = "vector.insert"(%111, %arg29, %arg28) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<3xf32>, index) -> vector<3xf32>
                  "scf.yield"(%112) : (vector<3xf32>) -> ()
                }, {
                  "scf.yield"(%arg29) : (vector<3xf32>) -> ()
                }) : (i1) -> vector<3xf32>
                "scf.yield"(%110) : (vector<3xf32>) -> ()
              }) : (index, index, index, vector<3xf32>) -> vector<3xf32>
              %90 = "vector.insert"(%89, %88) <{static_position = array<i64: 2, 1>}> : (vector<3xf32>, vector<5x4x3xf32>) -> vector<5x4x3xf32>
              %91 = "scf.for"(%3, %2, %1, %0) ({
              ^bb0(%arg26: index, %arg27: vector<3xf32>):
                %101 = "affine.apply"(%arg4, %arg26) <{map = #map}> : (index, index) -> index
                %102 = "affine.apply"(%arg4, %arg26) <{map = #map}> : (index, index) -> index
                %103 = "arith.cmpi"(%arg0, %102) <{predicate = 4 : i64}> : (index, index) -> i1
                %104 = "scf.if"(%103) ({
                  %105 = "memref.load"(%5, %101, %arg5, %arg6, %86) <{nontemporal = false}> : (memref<?x?x?x?xf32>, index, index, index, index) -> f32
                  %106 = "vector.insert"(%105, %arg27, %arg26) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<3xf32>, index) -> vector<3xf32>
                  "scf.yield"(%106) : (vector<3xf32>) -> ()
                }, {
                  "scf.yield"(%arg27) : (vector<3xf32>) -> ()
                }) : (i1) -> vector<3xf32>
                "scf.yield"(%104) : (vector<3xf32>) -> ()
              }) : (index, index, index, vector<3xf32>) -> vector<3xf32>
              %92 = "vector.insert"(%91, %90) <{static_position = array<i64: 2, 2>}> : (vector<3xf32>, vector<5x4x3xf32>) -> vector<5x4x3xf32>
              %93 = "scf.for"(%3, %2, %1, %0) ({
              ^bb0(%arg24: index, %arg25: vector<3xf32>):
                %95 = "affine.apply"(%arg4, %arg24) <{map = #map}> : (index, index) -> index
                %96 = "affine.apply"(%arg4, %arg24) <{map = #map}> : (index, index) -> index
                %97 = "arith.cmpi"(%arg0, %96) <{predicate = 4 : i64}> : (index, index) -> i1
                %98 = "scf.if"(%97) ({
                  %99 = "memref.load"(%5, %95, %arg5, %arg6, %86) <{nontemporal = false}> : (memref<?x?x?x?xf32>, index, index, index, index) -> f32
                  %100 = "vector.insert"(%99, %arg25, %arg24) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<3xf32>, index) -> vector<3xf32>
                  "scf.yield"(%100) : (vector<3xf32>) -> ()
                }, {
                  "scf.yield"(%arg25) : (vector<3xf32>) -> ()
                }) : (i1) -> vector<3xf32>
                "scf.yield"(%98) : (vector<3xf32>) -> ()
              }) : (index, index, index, vector<3xf32>) -> vector<3xf32>
              %94 = "vector.insert"(%93, %92) <{static_position = array<i64: 2, 3>}> : (vector<3xf32>, vector<5x4x3xf32>) -> vector<5x4x3xf32>
              "scf.yield"(%94) : (vector<5x4x3xf32>) -> ()
            }, {
              "scf.yield"(%10) : (vector<5x4x3xf32>) -> ()
            }) : (i1) -> vector<5x4x3xf32>
            %14 = "affine.apply"(%arg7) <{map = #map3}> : (index) -> index
            %15 = "arith.cmpi"(%arg3, %14) <{predicate = 4 : i64}> : (index, index) -> i1
            %16 = "scf.if"(%15) ({
              %53 = "affine.apply"(%arg7) <{map = #map3}> : (index) -> index
              %54 = "scf.for"(%3, %2, %1, %0) ({
              ^bb0(%arg22: index, %arg23: vector<3xf32>):
                %80 = "affine.apply"(%arg4, %arg22) <{map = #map}> : (index, index) -> index
                %81 = "affine.apply"(%arg4, %arg22) <{map = #map}> : (index, index) -> index
                %82 = "arith.cmpi"(%arg0, %81) <{predicate = 4 : i64}> : (index, index) -> i1
                %83 = "scf.if"(%82) ({
                  %84 = "memref.load"(%5, %80, %arg5, %arg6, %53) <{nontemporal = false}> : (memref<?x?x?x?xf32>, index, index, index, index) -> f32
                  %85 = "vector.insert"(%84, %arg23, %arg22) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<3xf32>, index) -> vector<3xf32>
                  "scf.yield"(%85) : (vector<3xf32>) -> ()
                }, {
                  "scf.yield"(%arg23) : (vector<3xf32>) -> ()
                }) : (i1) -> vector<3xf32>
                "scf.yield"(%83) : (vector<3xf32>) -> ()
              }) : (index, index, index, vector<3xf32>) -> vector<3xf32>
              %55 = "vector.insert"(%54, %13) <{static_position = array<i64: 3, 0>}> : (vector<3xf32>, vector<5x4x3xf32>) -> vector<5x4x3xf32>
              %56 = "scf.for"(%3, %2, %1, %0) ({
              ^bb0(%arg20: index, %arg21: vector<3xf32>):
                %74 = "affine.apply"(%arg4, %arg20) <{map = #map}> : (index, index) -> index
                %75 = "affine.apply"(%arg4, %arg20) <{map = #map}> : (index, index) -> index
                %76 = "arith.cmpi"(%arg0, %75) <{predicate = 4 : i64}> : (index, index) -> i1
                %77 = "scf.if"(%76) ({
                  %78 = "memref.load"(%5, %74, %arg5, %arg6, %53) <{nontemporal = false}> : (memref<?x?x?x?xf32>, index, index, index, index) -> f32
                  %79 = "vector.insert"(%78, %arg21, %arg20) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<3xf32>, index) -> vector<3xf32>
                  "scf.yield"(%79) : (vector<3xf32>) -> ()
                }, {
                  "scf.yield"(%arg21) : (vector<3xf32>) -> ()
                }) : (i1) -> vector<3xf32>
                "scf.yield"(%77) : (vector<3xf32>) -> ()
              }) : (index, index, index, vector<3xf32>) -> vector<3xf32>
              %57 = "vector.insert"(%56, %55) <{static_position = array<i64: 3, 1>}> : (vector<3xf32>, vector<5x4x3xf32>) -> vector<5x4x3xf32>
              %58 = "scf.for"(%3, %2, %1, %0) ({
              ^bb0(%arg18: index, %arg19: vector<3xf32>):
                %68 = "affine.apply"(%arg4, %arg18) <{map = #map}> : (index, index) -> index
                %69 = "affine.apply"(%arg4, %arg18) <{map = #map}> : (index, index) -> index
                %70 = "arith.cmpi"(%arg0, %69) <{predicate = 4 : i64}> : (index, index) -> i1
                %71 = "scf.if"(%70) ({
                  %72 = "memref.load"(%5, %68, %arg5, %arg6, %53) <{nontemporal = false}> : (memref<?x?x?x?xf32>, index, index, index, index) -> f32
                  %73 = "vector.insert"(%72, %arg19, %arg18) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<3xf32>, index) -> vector<3xf32>
                  "scf.yield"(%73) : (vector<3xf32>) -> ()
                }, {
                  "scf.yield"(%arg19) : (vector<3xf32>) -> ()
                }) : (i1) -> vector<3xf32>
                "scf.yield"(%71) : (vector<3xf32>) -> ()
              }) : (index, index, index, vector<3xf32>) -> vector<3xf32>
              %59 = "vector.insert"(%58, %57) <{static_position = array<i64: 3, 2>}> : (vector<3xf32>, vector<5x4x3xf32>) -> vector<5x4x3xf32>
              %60 = "scf.for"(%3, %2, %1, %0) ({
              ^bb0(%arg16: index, %arg17: vector<3xf32>):
                %62 = "affine.apply"(%arg4, %arg16) <{map = #map}> : (index, index) -> index
                %63 = "affine.apply"(%arg4, %arg16) <{map = #map}> : (index, index) -> index
                %64 = "arith.cmpi"(%arg0, %63) <{predicate = 4 : i64}> : (index, index) -> i1
                %65 = "scf.if"(%64) ({
                  %66 = "memref.load"(%5, %62, %arg5, %arg6, %53) <{nontemporal = false}> : (memref<?x?x?x?xf32>, index, index, index, index) -> f32
                  %67 = "vector.insert"(%66, %arg17, %arg16) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<3xf32>, index) -> vector<3xf32>
                  "scf.yield"(%67) : (vector<3xf32>) -> ()
                }, {
                  "scf.yield"(%arg17) : (vector<3xf32>) -> ()
                }) : (i1) -> vector<3xf32>
                "scf.yield"(%65) : (vector<3xf32>) -> ()
              }) : (index, index, index, vector<3xf32>) -> vector<3xf32>
              %61 = "vector.insert"(%60, %59) <{static_position = array<i64: 3, 3>}> : (vector<3xf32>, vector<5x4x3xf32>) -> vector<5x4x3xf32>
              "scf.yield"(%61) : (vector<5x4x3xf32>) -> ()
            }, {
              "scf.yield"(%13) : (vector<5x4x3xf32>) -> ()
            }) : (i1) -> vector<5x4x3xf32>
            %17 = "affine.apply"(%arg7) <{map = #map4}> : (index) -> index
            %18 = "arith.cmpi"(%arg3, %17) <{predicate = 4 : i64}> : (index, index) -> i1
            %19 = "scf.if"(%18) ({
              %20 = "affine.apply"(%arg7) <{map = #map4}> : (index) -> index
              %21 = "scf.for"(%3, %2, %1, %0) ({
              ^bb0(%arg14: index, %arg15: vector<3xf32>):
                %47 = "affine.apply"(%arg4, %arg14) <{map = #map}> : (index, index) -> index
                %48 = "affine.apply"(%arg4, %arg14) <{map = #map}> : (index, index) -> index
                %49 = "arith.cmpi"(%arg0, %48) <{predicate = 4 : i64}> : (index, index) -> i1
                %50 = "scf.if"(%49) ({
                  %51 = "memref.load"(%5, %47, %arg5, %arg6, %20) <{nontemporal = false}> : (memref<?x?x?x?xf32>, index, index, index, index) -> f32
                  %52 = "vector.insert"(%51, %arg15, %arg14) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<3xf32>, index) -> vector<3xf32>
                  "scf.yield"(%52) : (vector<3xf32>) -> ()
                }, {
                  "scf.yield"(%arg15) : (vector<3xf32>) -> ()
                }) : (i1) -> vector<3xf32>
                "scf.yield"(%50) : (vector<3xf32>) -> ()
              }) : (index, index, index, vector<3xf32>) -> vector<3xf32>
              %22 = "vector.insert"(%21, %16) <{static_position = array<i64: 4, 0>}> : (vector<3xf32>, vector<5x4x3xf32>) -> vector<5x4x3xf32>
              %23 = "scf.for"(%3, %2, %1, %0) ({
              ^bb0(%arg12: index, %arg13: vector<3xf32>):
                %41 = "affine.apply"(%arg4, %arg12) <{map = #map}> : (index, index) -> index
                %42 = "affine.apply"(%arg4, %arg12) <{map = #map}> : (index, index) -> index
                %43 = "arith.cmpi"(%arg0, %42) <{predicate = 4 : i64}> : (index, index) -> i1
                %44 = "scf.if"(%43) ({
                  %45 = "memref.load"(%5, %41, %arg5, %arg6, %20) <{nontemporal = false}> : (memref<?x?x?x?xf32>, index, index, index, index) -> f32
                  %46 = "vector.insert"(%45, %arg13, %arg12) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<3xf32>, index) -> vector<3xf32>
                  "scf.yield"(%46) : (vector<3xf32>) -> ()
                }, {
                  "scf.yield"(%arg13) : (vector<3xf32>) -> ()
                }) : (i1) -> vector<3xf32>
                "scf.yield"(%44) : (vector<3xf32>) -> ()
              }) : (index, index, index, vector<3xf32>) -> vector<3xf32>
              %24 = "vector.insert"(%23, %22) <{static_position = array<i64: 4, 1>}> : (vector<3xf32>, vector<5x4x3xf32>) -> vector<5x4x3xf32>
              %25 = "scf.for"(%3, %2, %1, %0) ({
              ^bb0(%arg10: index, %arg11: vector<3xf32>):
                %35 = "affine.apply"(%arg4, %arg10) <{map = #map}> : (index, index) -> index
                %36 = "affine.apply"(%arg4, %arg10) <{map = #map}> : (index, index) -> index
                %37 = "arith.cmpi"(%arg0, %36) <{predicate = 4 : i64}> : (index, index) -> i1
                %38 = "scf.if"(%37) ({
                  %39 = "memref.load"(%5, %35, %arg5, %arg6, %20) <{nontemporal = false}> : (memref<?x?x?x?xf32>, index, index, index, index) -> f32
                  %40 = "vector.insert"(%39, %arg11, %arg10) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<3xf32>, index) -> vector<3xf32>
                  "scf.yield"(%40) : (vector<3xf32>) -> ()
                }, {
                  "scf.yield"(%arg11) : (vector<3xf32>) -> ()
                }) : (i1) -> vector<3xf32>
                "scf.yield"(%38) : (vector<3xf32>) -> ()
              }) : (index, index, index, vector<3xf32>) -> vector<3xf32>
              %26 = "vector.insert"(%25, %24) <{static_position = array<i64: 4, 2>}> : (vector<3xf32>, vector<5x4x3xf32>) -> vector<5x4x3xf32>
              %27 = "scf.for"(%3, %2, %1, %0) ({
              ^bb0(%arg8: index, %arg9: vector<3xf32>):
                %29 = "affine.apply"(%arg4, %arg8) <{map = #map}> : (index, index) -> index
                %30 = "affine.apply"(%arg4, %arg8) <{map = #map}> : (index, index) -> index
                %31 = "arith.cmpi"(%arg0, %30) <{predicate = 4 : i64}> : (index, index) -> i1
                %32 = "scf.if"(%31) ({
                  %33 = "memref.load"(%5, %29, %arg5, %arg6, %20) <{nontemporal = false}> : (memref<?x?x?x?xf32>, index, index, index, index) -> f32
                  %34 = "vector.insert"(%33, %arg9, %arg8) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<3xf32>, index) -> vector<3xf32>
                  "scf.yield"(%34) : (vector<3xf32>) -> ()
                }, {
                  "scf.yield"(%arg9) : (vector<3xf32>) -> ()
                }) : (i1) -> vector<3xf32>
                "scf.yield"(%32) : (vector<3xf32>) -> ()
              }) : (index, index, index, vector<3xf32>) -> vector<3xf32>
              %28 = "vector.insert"(%27, %26) <{static_position = array<i64: 4, 3>}> : (vector<3xf32>, vector<5x4x3xf32>) -> vector<5x4x3xf32>
              "scf.yield"(%28) : (vector<5x4x3xf32>) -> ()
            }, {
              "scf.yield"(%16) : (vector<5x4x3xf32>) -> ()
            }) : (i1) -> vector<5x4x3xf32>
            "dummy_use"(%19) : (vector<5x4x3xf32>) -> ()
            "affine.yield"() : () -> ()
          }) : (index) -> ()
          "affine.yield"() : () -> ()
        }) : (index) -> ()
        "affine.yield"() : () -> ()
      }) : (index) -> ()
      "affine.yield"() : () -> ()
    }) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d3)>
#map1 = affine_map<(d0) -> (d0 + 1)>
#map2 = affine_map<(d0) -> (d0 + 2)>
#map3 = affine_map<(d0) -> (d0 + 3)>
#map4 = affine_map<() -> (0)>
#map5 = affine_map<()[s0] -> (s0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index) -> (), sym_name = "materialize_write"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = dense<1.000000e+00> : vector<5xf32>}> : () -> vector<5xf32>
    %1 = "memref.alloc"(%arg0, %arg1, %arg2, %arg3) <{operandSegmentSizes = array<i32: 4, 0>}> : (index, index, index, index) -> memref<?x?x?x?xf32>
    "affine.for"(%arg0) <{lowerBoundMap = #map4, operandSegmentSizes = array<i32: 0, 1, 0>, step = 3 : index, upperBoundMap = #map5}> ({
    ^bb0(%arg4: index):
      "affine.for"(%arg1) <{lowerBoundMap = #map4, operandSegmentSizes = array<i32: 0, 1, 0>, step = 4 : index, upperBoundMap = #map5}> ({
      ^bb0(%arg5: index):
        "affine.for"(%arg2) <{lowerBoundMap = #map4, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map5}> ({
        ^bb0(%arg6: index):
          "affine.for"(%arg3) <{lowerBoundMap = #map4, operandSegmentSizes = array<i32: 0, 1, 0>, step = 5 : index, upperBoundMap = #map5}> ({
          ^bb0(%arg7: index):
            %2 = "arith.cmpi"(%arg0, %arg4) <{predicate = 4 : i64}> : (index, index) -> i1
            "scf.if"(%2) ({
              %29 = "arith.cmpi"(%arg1, %arg5) <{predicate = 4 : i64}> : (index, index) -> i1
              "scf.if"(%29) ({
                "vector.transfer_write"(%0, %1, %arg4, %arg5, %arg6, %arg7) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<5xf32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                "scf.yield"() : () -> ()
              }, {
                "scf.yield"() : () -> ()
              }) : (i1) -> ()
              %30 = "affine.apply"(%arg5) <{map = #map1}> : (index) -> index
              %31 = "arith.cmpi"(%arg1, %30) <{predicate = 4 : i64}> : (index, index) -> i1
              "scf.if"(%31) ({
                %38 = "affine.apply"(%arg5) <{map = #map1}> : (index) -> index
                "vector.transfer_write"(%0, %1, %arg4, %38, %arg6, %arg7) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<5xf32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                "scf.yield"() : () -> ()
              }, {
                "scf.yield"() : () -> ()
              }) : (i1) -> ()
              %32 = "affine.apply"(%arg5) <{map = #map2}> : (index) -> index
              %33 = "arith.cmpi"(%arg1, %32) <{predicate = 4 : i64}> : (index, index) -> i1
              "scf.if"(%33) ({
                %37 = "affine.apply"(%arg5) <{map = #map2}> : (index) -> index
                "vector.transfer_write"(%0, %1, %arg4, %37, %arg6, %arg7) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<5xf32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                "scf.yield"() : () -> ()
              }, {
                "scf.yield"() : () -> ()
              }) : (i1) -> ()
              %34 = "affine.apply"(%arg5) <{map = #map3}> : (index) -> index
              %35 = "arith.cmpi"(%arg1, %34) <{predicate = 4 : i64}> : (index, index) -> i1
              "scf.if"(%35) ({
                %36 = "affine.apply"(%arg5) <{map = #map3}> : (index) -> index
                "vector.transfer_write"(%0, %1, %arg4, %36, %arg6, %arg7) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<5xf32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                "scf.yield"() : () -> ()
              }, {
                "scf.yield"() : () -> ()
              }) : (i1) -> ()
              "scf.yield"() : () -> ()
            }, {
              "scf.yield"() : () -> ()
            }) : (i1) -> ()
            %3 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
            %4 = "arith.cmpi"(%arg0, %3) <{predicate = 4 : i64}> : (index, index) -> i1
            "scf.if"(%4) ({
              %18 = "affine.apply"(%arg4) <{map = #map1}> : (index) -> index
              %19 = "arith.cmpi"(%arg1, %arg5) <{predicate = 4 : i64}> : (index, index) -> i1
              "scf.if"(%19) ({
                "vector.transfer_write"(%0, %1, %18, %arg5, %arg6, %arg7) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<5xf32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                "scf.yield"() : () -> ()
              }, {
                "scf.yield"() : () -> ()
              }) : (i1) -> ()
              %20 = "affine.apply"(%arg5) <{map = #map1}> : (index) -> index
              %21 = "arith.cmpi"(%arg1, %20) <{predicate = 4 : i64}> : (index, index) -> i1
              "scf.if"(%21) ({
                %28 = "affine.apply"(%arg5) <{map = #map1}> : (index) -> index
                "vector.transfer_write"(%0, %1, %18, %28, %arg6, %arg7) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<5xf32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                "scf.yield"() : () -> ()
              }, {
                "scf.yield"() : () -> ()
              }) : (i1) -> ()
              %22 = "affine.apply"(%arg5) <{map = #map2}> : (index) -> index
              %23 = "arith.cmpi"(%arg1, %22) <{predicate = 4 : i64}> : (index, index) -> i1
              "scf.if"(%23) ({
                %27 = "affine.apply"(%arg5) <{map = #map2}> : (index) -> index
                "vector.transfer_write"(%0, %1, %18, %27, %arg6, %arg7) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<5xf32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                "scf.yield"() : () -> ()
              }, {
                "scf.yield"() : () -> ()
              }) : (i1) -> ()
              %24 = "affine.apply"(%arg5) <{map = #map3}> : (index) -> index
              %25 = "arith.cmpi"(%arg1, %24) <{predicate = 4 : i64}> : (index, index) -> i1
              "scf.if"(%25) ({
                %26 = "affine.apply"(%arg5) <{map = #map3}> : (index) -> index
                "vector.transfer_write"(%0, %1, %18, %26, %arg6, %arg7) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<5xf32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                "scf.yield"() : () -> ()
              }, {
                "scf.yield"() : () -> ()
              }) : (i1) -> ()
              "scf.yield"() : () -> ()
            }, {
              "scf.yield"() : () -> ()
            }) : (i1) -> ()
            %5 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
            %6 = "arith.cmpi"(%arg0, %5) <{predicate = 4 : i64}> : (index, index) -> i1
            "scf.if"(%6) ({
              %7 = "affine.apply"(%arg4) <{map = #map2}> : (index) -> index
              %8 = "arith.cmpi"(%arg1, %arg5) <{predicate = 4 : i64}> : (index, index) -> i1
              "scf.if"(%8) ({
                "vector.transfer_write"(%0, %1, %7, %arg5, %arg6, %arg7) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<5xf32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                "scf.yield"() : () -> ()
              }, {
                "scf.yield"() : () -> ()
              }) : (i1) -> ()
              %9 = "affine.apply"(%arg5) <{map = #map1}> : (index) -> index
              %10 = "arith.cmpi"(%arg1, %9) <{predicate = 4 : i64}> : (index, index) -> i1
              "scf.if"(%10) ({
                %17 = "affine.apply"(%arg5) <{map = #map1}> : (index) -> index
                "vector.transfer_write"(%0, %1, %7, %17, %arg6, %arg7) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<5xf32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                "scf.yield"() : () -> ()
              }, {
                "scf.yield"() : () -> ()
              }) : (i1) -> ()
              %11 = "affine.apply"(%arg5) <{map = #map2}> : (index) -> index
              %12 = "arith.cmpi"(%arg1, %11) <{predicate = 4 : i64}> : (index, index) -> i1
              "scf.if"(%12) ({
                %16 = "affine.apply"(%arg5) <{map = #map2}> : (index) -> index
                "vector.transfer_write"(%0, %1, %7, %16, %arg6, %arg7) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<5xf32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                "scf.yield"() : () -> ()
              }, {
                "scf.yield"() : () -> ()
              }) : (i1) -> ()
              %13 = "affine.apply"(%arg5) <{map = #map3}> : (index) -> index
              %14 = "arith.cmpi"(%arg1, %13) <{predicate = 4 : i64}> : (index, index) -> i1
              "scf.if"(%14) ({
                %15 = "affine.apply"(%arg5) <{map = #map3}> : (index) -> index
                "vector.transfer_write"(%0, %1, %7, %15, %arg6, %arg7) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<5xf32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
                "scf.yield"() : () -> ()
              }, {
                "scf.yield"() : () -> ()
              }) : (i1) -> ()
              "scf.yield"() : () -> ()
            }, {
              "scf.yield"() : () -> ()
            }) : (i1) -> ()
            "affine.yield"() : () -> ()
          }) : (index) -> ()
          "affine.yield"() : () -> ()
        }) : (index) -> ()
        "affine.yield"() : () -> ()
      }) : (index) -> ()
      "affine.yield"() : () -> ()
    }) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
#map1 = affine_map<()[s0] -> (s0 + 1)>
#map2 = affine_map<()[s0] -> (s0 + 2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, index) -> vector<3x15xf32>, sym_name = "transfer_read_progressive"}> ({
  ^bb0(%arg0: memref<?x?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = dense<7.000000e+00> : vector<3x15xf32>}> : () -> vector<3x15xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.dim"(%arg0, %2) : (memref<?x?xf32>, index) -> index
    %4 = "arith.cmpi"(%3, %arg1) <{predicate = 4 : i64}> : (index, index) -> i1
    %5 = "scf.if"(%4) ({
      %20 = "vector.transfer_read"(%arg0, %arg1, %arg1, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<15xf32>
      %21 = "vector.insert"(%20, %1) <{static_position = array<i64: 0>}> : (vector<15xf32>, vector<3x15xf32>) -> vector<3x15xf32>
      "scf.yield"(%21) : (vector<3x15xf32>) -> ()
    }, {
      "scf.yield"(%1) : (vector<3x15xf32>) -> ()
    }) : (i1) -> vector<3x15xf32>
    %6 = "memref.dim"(%arg0, %2) : (memref<?x?xf32>, index) -> index
    %7 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
    %8 = "arith.cmpi"(%6, %7) <{predicate = 4 : i64}> : (index, index) -> i1
    %9 = "scf.if"(%8) ({
      %17 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
      %18 = "vector.transfer_read"(%arg0, %17, %arg1, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<15xf32>
      %19 = "vector.insert"(%18, %5) <{static_position = array<i64: 1>}> : (vector<15xf32>, vector<3x15xf32>) -> vector<3x15xf32>
      "scf.yield"(%19) : (vector<3x15xf32>) -> ()
    }, {
      "scf.yield"(%5) : (vector<3x15xf32>) -> ()
    }) : (i1) -> vector<3x15xf32>
    %10 = "memref.dim"(%arg0, %2) : (memref<?x?xf32>, index) -> index
    %11 = "affine.apply"(%arg1) <{map = #map2}> : (index) -> index
    %12 = "arith.cmpi"(%10, %11) <{predicate = 4 : i64}> : (index, index) -> i1
    %13 = "scf.if"(%12) ({
      %14 = "affine.apply"(%arg1) <{map = #map2}> : (index) -> index
      %15 = "vector.transfer_read"(%arg0, %14, %arg1, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<15xf32>
      %16 = "vector.insert"(%15, %9) <{static_position = array<i64: 2>}> : (vector<15xf32>, vector<3x15xf32>) -> vector<3x15xf32>
      "scf.yield"(%16) : (vector<3x15xf32>) -> ()
    }, {
      "scf.yield"(%9) : (vector<3x15xf32>) -> ()
    }) : (i1) -> vector<3x15xf32>
    "func.return"(%13) : (vector<3x15xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
#map1 = affine_map<()[s0] -> (s0 + 1)>
#map2 = affine_map<()[s0] -> (s0 + 2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, index, vector<3x15xf32>) -> (), sym_name = "transfer_write_progressive"}> ({
  ^bb0(%arg0: memref<?x?xf32>, %arg1: index, %arg2: vector<3x15xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
    %2 = "arith.cmpi"(%1, %arg1) <{predicate = 4 : i64}> : (index, index) -> i1
    "scf.if"(%2) ({
      %13 = "vector.extract"(%arg2) <{static_position = array<i64: 0>}> : (vector<3x15xf32>) -> vector<15xf32>
      "vector.transfer_write"(%13, %arg0, %arg1, %arg1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<15xf32>, memref<?x?xf32>, index, index) -> ()
      "scf.yield"() : () -> ()
    }, {
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    %3 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
    %4 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
    %5 = "arith.cmpi"(%3, %4) <{predicate = 4 : i64}> : (index, index) -> i1
    "scf.if"(%5) ({
      %11 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
      %12 = "vector.extract"(%arg2) <{static_position = array<i64: 1>}> : (vector<3x15xf32>) -> vector<15xf32>
      "vector.transfer_write"(%12, %arg0, %11, %arg1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<15xf32>, memref<?x?xf32>, index, index) -> ()
      "scf.yield"() : () -> ()
    }, {
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    %6 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
    %7 = "affine.apply"(%arg1) <{map = #map2}> : (index) -> index
    %8 = "arith.cmpi"(%6, %7) <{predicate = 4 : i64}> : (index, index) -> i1
    "scf.if"(%8) ({
      %9 = "affine.apply"(%arg1) <{map = #map2}> : (index) -> index
      %10 = "vector.extract"(%arg2) <{static_position = array<i64: 2>}> : (vector<3x15xf32>) -> vector<15xf32>
      "vector.transfer_write"(%10, %arg0, %9, %arg1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<15xf32>, memref<?x?xf32>, index, index) -> ()
      "scf.yield"() : () -> ()
    }, {
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
#map1 = affine_map<()[s0] -> (s0 + 1)>
#map2 = affine_map<()[s0] -> (s0 + 2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, index, vector<3x15xf32>) -> (), sym_name = "transfer_write_progressive_inbounds"}> ({
  ^bb0(%arg0: memref<?x?xf32>, %arg1: index, %arg2: vector<3x15xf32>):
    %0 = "vector.extract"(%arg2) <{static_position = array<i64: 0>}> : (vector<3x15xf32>) -> vector<15xf32>
    "vector.transfer_write"(%0, %arg0, %arg1, %arg1) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<15xf32>, memref<?x?xf32>, index, index) -> ()
    %1 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
    %2 = "vector.extract"(%arg2) <{static_position = array<i64: 1>}> : (vector<3x15xf32>) -> vector<15xf32>
    "vector.transfer_write"(%2, %arg0, %1, %arg1) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<15xf32>, memref<?x?xf32>, index, index) -> ()
    %3 = "affine.apply"(%arg1) <{map = #map2}> : (index) -> index
    %4 = "vector.extract"(%arg2) <{static_position = array<i64: 2>}> : (vector<3x15xf32>) -> vector<15xf32>
    "vector.transfer_write"(%4, %arg0, %3, %arg1) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<15xf32>, memref<?x?xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x2xf32>) -> vector<2x2xf32>, sym_name = "transfer_read_simple"}> ({
  ^bb0(%arg3: memref<2x2xf32>):
    %32 = "arith.constant"() <{value = 1 : index}> : () -> index
    %33 = "arith.constant"() <{value = 0 : index}> : () -> index
    %34 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %35 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2x2xf32>}> : () -> vector<2x2xf32>
    %36 = "vector.transfer_read"(%arg3, %33, %33, %34) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x2xf32>, index, index, f32) -> vector<2xf32>
    %37 = "vector.insert"(%36, %35) <{static_position = array<i64: 0>}> : (vector<2xf32>, vector<2x2xf32>) -> vector<2x2xf32>
    %38 = "vector.transfer_read"(%arg3, %32, %33, %34) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x2xf32>, index, index, f32) -> vector<2xf32>
    %39 = "vector.insert"(%38, %37) <{static_position = array<i64: 1>}> : (vector<2xf32>, vector<2x2xf32>) -> vector<2x2xf32>
    "func.return"(%39) : (vector<2x2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?x?x?xf32>) -> vector<3x3xf32>, sym_name = "transfer_read_minor_identity"}> ({
  ^bb0(%arg2: memref<?x?x?x?xf32>):
    %12 = "arith.constant"() <{value = 1 : index}> : () -> index
    %13 = "arith.constant"() <{value = 0 : index}> : () -> index
    %14 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %15 = "arith.constant"() <{value = dense<0.000000e+00> : vector<3x3xf32>}> : () -> vector<3x3xf32>
    %16 = "arith.constant"() <{value = 2 : index}> : () -> index
    %17 = "memref.dim"(%arg2, %16) : (memref<?x?x?x?xf32>, index) -> index
    %18 = "arith.cmpi"(%17, %13) <{predicate = 4 : i64}> : (index, index) -> i1
    %19 = "scf.if"(%18) ({
      %30 = "vector.transfer_read"(%arg2, %13, %13, %13, %13, %14) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map1}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<3xf32>
      %31 = "vector.insert"(%30, %15) <{static_position = array<i64: 0>}> : (vector<3xf32>, vector<3x3xf32>) -> vector<3x3xf32>
      "scf.yield"(%31) : (vector<3x3xf32>) -> ()
    }, {
      "scf.yield"(%15) : (vector<3x3xf32>) -> ()
    }) : (i1) -> vector<3x3xf32>
    %20 = "memref.dim"(%arg2, %16) : (memref<?x?x?x?xf32>, index) -> index
    %21 = "arith.cmpi"(%20, %12) <{predicate = 4 : i64}> : (index, index) -> i1
    %22 = "scf.if"(%21) ({
      %28 = "vector.transfer_read"(%arg2, %13, %13, %12, %13, %14) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map1}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<3xf32>
      %29 = "vector.insert"(%28, %19) <{static_position = array<i64: 1>}> : (vector<3xf32>, vector<3x3xf32>) -> vector<3x3xf32>
      "scf.yield"(%29) : (vector<3x3xf32>) -> ()
    }, {
      "scf.yield"(%19) : (vector<3x3xf32>) -> ()
    }) : (i1) -> vector<3x3xf32>
    %23 = "memref.dim"(%arg2, %16) : (memref<?x?x?x?xf32>, index) -> index
    %24 = "arith.cmpi"(%23, %16) <{predicate = 4 : i64}> : (index, index) -> i1
    %25 = "scf.if"(%24) ({
      %26 = "vector.transfer_read"(%arg2, %13, %13, %16, %13, %14) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map1}> : (memref<?x?x?x?xf32>, index, index, index, index, f32) -> vector<3xf32>
      %27 = "vector.insert"(%26, %22) <{static_position = array<i64: 2>}> : (vector<3xf32>, vector<3x3xf32>) -> vector<3x3xf32>
      "scf.yield"(%27) : (vector<3x3xf32>) -> ()
    }, {
      "scf.yield"(%22) : (vector<3x3xf32>) -> ()
    }) : (i1) -> vector<3x3xf32>
    "func.return"(%25) : (vector<3x3xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3x3xf32>, memref<?x?x?x?xf32>) -> (), sym_name = "transfer_write_minor_identity"}> ({
  ^bb0(%arg0: vector<3x3xf32>, %arg1: memref<?x?x?x?xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "memref.dim"(%arg1, %2) : (memref<?x?x?x?xf32>, index) -> index
    %4 = "arith.cmpi"(%3, %1) <{predicate = 4 : i64}> : (index, index) -> i1
    "scf.if"(%4) ({
      %11 = "vector.extract"(%arg0) <{static_position = array<i64: 0>}> : (vector<3x3xf32>) -> vector<3xf32>
      "vector.transfer_write"(%11, %arg1, %1, %1, %1, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map1}> : (vector<3xf32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
      "scf.yield"() : () -> ()
    }, {
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    %5 = "memref.dim"(%arg1, %2) : (memref<?x?x?x?xf32>, index) -> index
    %6 = "arith.cmpi"(%5, %0) <{predicate = 4 : i64}> : (index, index) -> i1
    "scf.if"(%6) ({
      %10 = "vector.extract"(%arg0) <{static_position = array<i64: 1>}> : (vector<3x3xf32>) -> vector<3xf32>
      "vector.transfer_write"(%10, %arg1, %1, %1, %0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map1}> : (vector<3xf32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
      "scf.yield"() : () -> ()
    }, {
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    %7 = "memref.dim"(%arg1, %2) : (memref<?x?x?x?xf32>, index) -> index
    %8 = "arith.cmpi"(%7, %2) <{predicate = 4 : i64}> : (index, index) -> i1
    "scf.if"(%8) ({
      %9 = "vector.extract"(%arg0) <{static_position = array<i64: 2>}> : (vector<3x3xf32>) -> vector<3xf32>
      "vector.transfer_write"(%9, %arg1, %1, %1, %2, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map1}> : (vector<3xf32>, memref<?x?x?x?xf32>, index, index, index, index) -> ()
      "scf.yield"() : () -> ()
    }, {
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0 + d1 * 8)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x4xf32, #map>) -> vector<4xf32>, sym_name = "transfer_read_strided"}> ({
  ^bb0(%arg3: memref<8x4xf32, #map>):
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "arith.constant"() <{value = 4 : index}> : () -> index
    %6 = "arith.constant"() <{value = 1 : index}> : () -> index
    %7 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %8 = "scf.for"(%4, %5, %6, %7) ({
    ^bb0(%arg4: index, %arg5: vector<4xf32>):
      %9 = "memref.load"(%arg3, %4, %arg4) <{nontemporal = false}> : (memref<8x4xf32, #map>, index, index) -> f32
      %10 = "vector.insert"(%9, %arg5, %arg4) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<4xf32>, index) -> vector<4xf32>
      "scf.yield"(%10) : (vector<4xf32>) -> ()
    }) : (index, index, index, vector<4xf32>) -> vector<4xf32>
    "func.return"(%8) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, memref<8x4xf32, #map>) -> (), sym_name = "transfer_write_strided"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: memref<8x4xf32, #map>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 4 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%0, %1, %2) ({
    ^bb0(%arg2: index):
      %3 = "vector.extract"(%arg0, %arg2) <{static_position = array<i64: -9223372036854775808>}> : (vector<4xf32>, index) -> f32
      "memref.store"(%3, %arg1, %0, %arg2) <{nontemporal = false}> : (f32, memref<8x4xf32, #map>, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xf32>) -> (), sym_name = "fake_side_effecting_fun", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<2x2xf32>) -> !async.token, sym_name = "transfer_read_within_async_execute"}> ({
  ^bb0(%arg0: memref<2x2xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2x2xf32>}> : () -> vector<2x2xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "async.execute"() <{operandSegmentSizes = array<i32: 0, 0>}> ({
      %5 = "vector.transfer_read"(%arg0, %2, %2, %3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x2xf32>, index, index, f32) -> vector<2xf32>
      %6 = "vector.insert"(%5, %1) <{static_position = array<i64: 0>}> : (vector<2xf32>, vector<2x2xf32>) -> vector<2x2xf32>
      %7 = "vector.transfer_read"(%arg0, %0, %2, %3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x2xf32>, index, index, f32) -> vector<2xf32>
      %8 = "vector.insert"(%7, %6) <{static_position = array<i64: 1>}> : (vector<2xf32>, vector<2x2xf32>) -> vector<2x2xf32>
      "func.call"(%8) <{callee = @fake_side_effecting_fun}> : (vector<2x2xf32>) -> ()
      "async.yield"() : () -> ()
    }) : () -> !async.token
    "func.return"(%4) : (!async.token) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>) -> vector<1xf32>, sym_name = "transfer_read_with_tensor"}> ({
  ^bb0(%arg0: tensor<f32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "vector.transfer_read"(%arg0, %0) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 0, 1, 0>, permutation_map = #map}> : (tensor<f32>, f32) -> vector<f32>
    %2 = "vector.broadcast"(%1) : (vector<f32>) -> vector<1xf32>
    "func.return"(%2) : (vector<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, f32) -> (), sym_name = "transfer_write_scalable"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: f32):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 16 : index}> : () -> index
    %2 = "llvm.mlir.undef"() : () -> vector<[16]xf32>
    %3 = "llvm.mlir.undef"() : () -> vector<[16]xi32>
    %4 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 0 : index}> : () -> index
    %6 = "memref.dim"(%arg0, %5) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %7 = "llvm.intr.stepvector"() : () -> vector<[16]xi32>
    %8 = "arith.index_cast"(%6) : (index) -> i32
    %9 = "llvm.insertelement"(%3, %8, %4) : (vector<[16]xi32>, i32, i32) -> vector<[16]xi32>
    %10 = "llvm.shufflevector"(%9, %3) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[16]xi32>, vector<[16]xi32>) -> vector<[16]xi32>
    %11 = "arith.cmpi"(%7, %10) <{predicate = 2 : i64}> : (vector<[16]xi32>, vector<[16]xi32>) -> vector<[16]xi1>
    %12 = "llvm.insertelement"(%2, %arg1, %4) : (vector<[16]xf32>, f32, i32) -> vector<[16]xf32>
    %13 = "llvm.shufflevector"(%12, %2) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[16]xf32>, vector<[16]xf32>) -> vector<[16]xf32>
    %14 = "vector.vscale"() : () -> index
    %15 = "arith.muli"(%14, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "scf.for"(%5, %15, %0) ({
    ^bb0(%arg2: index):
      %16 = "vector.extract"(%11, %arg2) <{static_position = array<i64: -9223372036854775808>}> : (vector<[16]xi1>, index) -> i1
      "scf.if"(%16) ({
        %17 = "vector.extract"(%13, %arg2) <{static_position = array<i64: -9223372036854775808>}> : (vector<[16]xf32>, index) -> f32
        "memref.store"(%17, %arg0, %arg2) <{nontemporal = false}> : (f32, memref<?xf32, strided<[?], offset: ?>>, index) -> ()
        "scf.yield"() : () -> ()
      }, {
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>) -> (), sym_name = "vector_print_vector_0d"}> ({
  ^bb0(%arg0: vector<f32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    "vector.print"() <{punctuation = #vector.punctuation<open>}> : () -> ()
    "scf.for"(%0, %1, %1) ({
    ^bb0(%arg1: index):
      %2 = "vector.extract"(%arg0) <{static_position = array<i64>}> : (vector<f32>) -> f32
      "vector.print"(%2) <{punctuation = #vector.punctuation<no_punctuation>}> : (f32) -> ()
      %3 = "arith.cmpi"(%arg1, %0) <{predicate = 6 : i64}> : (index, index) -> i1
      "scf.if"(%3) ({
        "vector.print"() <{punctuation = #vector.punctuation<comma>}> : () -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "vector.print"() <{punctuation = #vector.punctuation<close>}> : () -> ()
    "vector.print"() <{punctuation = #vector.punctuation<newline>}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xf32>) -> (), sym_name = "vector_print_vector"}> ({
  ^bb0(%arg0: vector<2x2xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "vector.shape_cast"(%arg0) : (vector<2x2xf32>) -> vector<4xf32>
    "vector.print"() <{punctuation = #vector.punctuation<open>}> : () -> ()
    "scf.for"(%2, %1, %0) ({
    ^bb0(%arg1: index):
      "vector.print"() <{punctuation = #vector.punctuation<open>}> : () -> ()
      "scf.for"(%2, %1, %0) ({
      ^bb0(%arg2: index):
        %5 = "arith.muli"(%arg1, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %6 = "arith.addi"(%arg2, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %7 = "vector.extract"(%3, %6) <{static_position = array<i64: -9223372036854775808>}> : (vector<4xf32>, index) -> f32
        "vector.print"(%7) <{punctuation = #vector.punctuation<no_punctuation>}> : (f32) -> ()
        %8 = "arith.cmpi"(%arg2, %0) <{predicate = 6 : i64}> : (index, index) -> i1
        "scf.if"(%8) ({
          "vector.print"() <{punctuation = #vector.punctuation<comma>}> : () -> ()
          "scf.yield"() : () -> ()
        }, {
        }) : (i1) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "vector.print"() <{punctuation = #vector.punctuation<close>}> : () -> ()
      %4 = "arith.cmpi"(%arg1, %0) <{predicate = 6 : i64}> : (index, index) -> i1
      "scf.if"(%4) ({
        "vector.print"() <{punctuation = #vector.punctuation<comma>}> : () -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "vector.print"() <{punctuation = #vector.punctuation<close>}> : () -> ()
    "vector.print"() <{punctuation = #vector.punctuation<newline>}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]xi32>) -> (), sym_name = "vector_print_scalable_vector"}> ({
  ^bb0(%arg0: vector<[4]xi32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 4 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "vector.vscale"() : () -> index
    %4 = "arith.muli"(%3, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %5 = "arith.subi"(%4, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "vector.print"() <{punctuation = #vector.punctuation<open>}> : () -> ()
    "scf.for"(%0, %4, %2) ({
    ^bb0(%arg1: index):
      %6 = "vector.extract"(%arg0, %arg1) <{static_position = array<i64: -9223372036854775808>}> : (vector<[4]xi32>, index) -> i32
      "vector.print"(%6) <{punctuation = #vector.punctuation<no_punctuation>}> : (i32) -> ()
      %7 = "arith.cmpi"(%arg1, %5) <{predicate = 6 : i64}> : (index, index) -> i1
      "scf.if"(%7) ({
        "vector.print"() <{punctuation = #vector.punctuation<comma>}> : () -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "vector.print"() <{punctuation = #vector.punctuation<close>}> : () -> ()
    "vector.print"() <{punctuation = #vector.punctuation<newline>}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<3x?xf32>) -> vector<3x[4]xf32>, sym_name = "transfer_read_array_of_scalable"}> ({
  ^bb0(%arg0: memref<3x?xf32>):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : vector<3x[4]xf32>}> : () -> vector<3x[4]xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %5 = "memref.dim"(%arg0, %3) : (memref<3x?xf32>, index) -> index
    %6 = "vector.create_mask"(%3, %5) : (index, index) -> vector<3x[4]xi1>
    %7 = "vector.extract"(%6) <{static_position = array<i64: 0>}> : (vector<3x[4]xi1>) -> vector<[4]xi1>
    %8 = "vector.transfer_read"(%arg0, %2, %2, %4, %7) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 1>, permutation_map = #map}> : (memref<3x?xf32>, index, index, f32, vector<[4]xi1>) -> vector<[4]xf32>
    %9 = "vector.insert"(%8, %1) <{static_position = array<i64: 0>}> : (vector<[4]xf32>, vector<3x[4]xf32>) -> vector<3x[4]xf32>
    %10 = "vector.extract"(%6) <{static_position = array<i64: 1>}> : (vector<3x[4]xi1>) -> vector<[4]xi1>
    %11 = "vector.transfer_read"(%arg0, %3, %2, %4, %10) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 1>, permutation_map = #map}> : (memref<3x?xf32>, index, index, f32, vector<[4]xi1>) -> vector<[4]xf32>
    %12 = "vector.insert"(%11, %9) <{static_position = array<i64: 1>}> : (vector<[4]xf32>, vector<3x[4]xf32>) -> vector<3x[4]xf32>
    %13 = "vector.extract"(%6) <{static_position = array<i64: 2>}> : (vector<3x[4]xi1>) -> vector<[4]xi1>
    %14 = "vector.transfer_read"(%arg0, %0, %2, %4, %13) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 1>, permutation_map = #map}> : (memref<3x?xf32>, index, index, f32, vector<[4]xi1>) -> vector<[4]xf32>
    %15 = "vector.insert"(%14, %12) <{static_position = array<i64: 2>}> : (vector<[4]xf32>, vector<3x[4]xf32>) -> vector<3x[4]xf32>
    "func.return"(%15) : (vector<3x[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3x[4]xf32>, memref<3x?xf32>) -> (), sym_name = "transfer_write_array_of_scalable"}> ({
  ^bb0(%arg0: vector<3x[4]xf32>, %arg1: memref<3x?xf32>):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "memref.dim"(%arg1, %2) : (memref<3x?xf32>, index) -> index
    %4 = "vector.create_mask"(%2, %3) : (index, index) -> vector<3x[4]xi1>
    %5 = "vector.extract"(%arg0) <{static_position = array<i64: 0>}> : (vector<3x[4]xf32>) -> vector<[4]xf32>
    %6 = "vector.extract"(%4) <{static_position = array<i64: 0>}> : (vector<3x[4]xi1>) -> vector<[4]xi1>
    "vector.transfer_write"(%5, %arg1, %1, %1, %6) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 1>, permutation_map = #map}> : (vector<[4]xf32>, memref<3x?xf32>, index, index, vector<[4]xi1>) -> ()
    %7 = "vector.extract"(%arg0) <{static_position = array<i64: 1>}> : (vector<3x[4]xf32>) -> vector<[4]xf32>
    %8 = "vector.extract"(%4) <{static_position = array<i64: 1>}> : (vector<3x[4]xi1>) -> vector<[4]xi1>
    "vector.transfer_write"(%7, %arg1, %2, %1, %8) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 1>, permutation_map = #map}> : (vector<[4]xf32>, memref<3x?xf32>, index, index, vector<[4]xi1>) -> ()
    %9 = "vector.extract"(%arg0) <{static_position = array<i64: 2>}> : (vector<3x[4]xf32>) -> vector<[4]xf32>
    %10 = "vector.extract"(%4) <{static_position = array<i64: 2>}> : (vector<3x[4]xi1>) -> vector<[4]xi1>
    "vector.transfer_write"(%9, %arg1, %0, %1, %10) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 1>, permutation_map = #map}> : (vector<[4]xf32>, memref<3x?xf32>, index, index, vector<[4]xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]x4xf32>, memref<?x4xf32>) -> (), sym_name = "cannot_lower_transfer_write_with_leading_scalable"}> ({
  ^bb0(%arg0: vector<[4]x4xf32>, %arg1: memref<?x4xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 4 : index}> : () -> index
    %2 = "memref.dim"(%arg1, %0) : (memref<?x4xf32>, index) -> index
    %3 = "vector.create_mask"(%2, %1) : (index, index) -> vector<[4]x4xi1>
    "vector.transfer_write"(%arg0, %arg1, %0, %0, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 1>, permutation_map = #map}> : (vector<[4]x4xf32>, memref<?x4xf32>, index, index, vector<[4]x4xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d3)>
#map2 = affine_map<(d0, d1, d2) -> (d2)>
#map3 = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x4xf32>) -> vector<[4]x4xf32>, sym_name = "cannot_lower_transfer_read_with_leading_scalable"}> ({
  ^bb0(%arg7: memref<?x4xf32>):
    %22 = "arith.constant"() <{value = 0 : index}> : () -> index
    %23 = "arith.constant"() <{value = 4 : index}> : () -> index
    %24 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %25 = "memref.dim"(%arg7, %22) : (memref<?x4xf32>, index) -> index
    %26 = "vector.create_mask"(%25, %23) : (index, index) -> vector<[4]x4xi1>
    %27 = "vector.transfer_read"(%arg7, %22, %22, %24, %26) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 1>, permutation_map = #map}> : (memref<?x4xf32>, index, index, f32, vector<[4]x4xi1>) -> vector<[4]x4xf32>
    "func.return"(%27) : (vector<[4]x4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1x1x1x1xi32>, vector<1x1xi1>) -> vector<1x1x1x1xi32>, sym_name = "does_not_crash_on_unpack_one_dim"}> ({
  ^bb0(%arg5: memref<1x1x1x1xi32>, %arg6: vector<1x1xi1>):
    %16 = "arith.constant"() <{value = 0 : index}> : () -> index
    %17 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %18 = "arith.constant"() <{value = dense<0> : vector<1x1x1x1xi32>}> : () -> vector<1x1x1x1xi32>
    %19 = "vector.extract"(%arg6) <{static_position = array<i64: 0>}> : (vector<1x1xi1>) -> vector<1xi1>
    %20 = "vector.transfer_read"(%arg5, %16, %16, %16, %16, %17, %19) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 4, 1, 1>, permutation_map = #map1}> : (memref<1x1x1x1xi32>, index, index, index, index, i32, vector<1xi1>) -> vector<1xi32>
    %21 = "vector.insert"(%20, %18) <{static_position = array<i64: 0, 0, 0>}> : (vector<1xi32>, vector<1x1x1x1xi32>) -> vector<1x1x1x1xi32>
    "func.return"(%21) : (vector<1x1x1x1xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1x2x?xf32>, memref<1x2x?xf32>) -> vector<1x2x[4]xf32>, sym_name = "add_arrays_of_scalable_vectors"}> ({
  ^bb0(%arg3: memref<1x2x?xf32>, %arg4: memref<1x2x?xf32>):
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = dense<0.000000e+00> : vector<1x2x[4]xf32>}> : () -> vector<1x2x[4]xf32>
    %5 = "arith.constant"() <{value = 0 : index}> : () -> index
    %6 = "arith.constant"() <{value = 2 : index}> : () -> index
    %7 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %8 = "memref.dim"(%arg3, %6) : (memref<1x2x?xf32>, index) -> index
    %9 = "vector.create_mask"(%6, %6, %8) : (index, index, index) -> vector<1x2x[4]xi1>
    %10 = "vector.extract"(%9) <{static_position = array<i64: 0, 0>}> : (vector<1x2x[4]xi1>) -> vector<[4]xi1>
    %11 = "vector.transfer_read"(%arg3, %5, %5, %5, %7, %10) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 1>, permutation_map = #map2}> : (memref<1x2x?xf32>, index, index, index, f32, vector<[4]xi1>) -> vector<[4]xf32>
    %12 = "vector.insert"(%11, %4) <{static_position = array<i64: 0, 0>}> : (vector<[4]xf32>, vector<1x2x[4]xf32>) -> vector<1x2x[4]xf32>
    %13 = "vector.extract"(%9) <{static_position = array<i64: 0, 1>}> : (vector<1x2x[4]xi1>) -> vector<[4]xi1>
    %14 = "vector.transfer_read"(%arg3, %5, %3, %5, %7, %13) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 1>, permutation_map = #map2}> : (memref<1x2x?xf32>, index, index, index, f32, vector<[4]xi1>) -> vector<[4]xf32>
    %15 = "vector.insert"(%14, %12) <{static_position = array<i64: 0, 1>}> : (vector<[4]xf32>, vector<1x2x[4]xf32>) -> vector<1x2x[4]xf32>
    "func.return"(%15) : (vector<1x2x[4]xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<[4]x[4]xf32>, memref<?x?xf32>) -> (), sym_name = "cannot_fully_unroll_transfer_write_of_nd_scalable_vector"}> ({
  ^bb0(%arg1: vector<[4]x[4]xf32>, %arg2: memref<?x?xf32>):
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    "vector.transfer_write"(%arg1, %arg2, %2, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<[4]x[4]xf32>, memref<?x?xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi32>) -> (), sym_name = "unroll_transfer_write_target_rank_zero"}> ({
  ^bb0(%arg0: vector<2xi32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xi32>
    "vector.transfer_write"(%arg0, %1, %0) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map3}> : (vector<2xi32>, memref<4xi32>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0] -> (d0 + s0)>
#map1 = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x[4]xf32>, memref<?x?xf32>, index, index) -> (), sym_name = "scalable_transpose_store_unmasked"}> ({
  ^bb0(%arg0: vector<4x[4]xf32>, %arg1: memref<?x?xf32>, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 4 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "vector.extract"(%arg0) <{static_position = array<i64: 0>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    %4 = "vector.extract"(%arg0) <{static_position = array<i64: 1>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    %5 = "vector.extract"(%arg0) <{static_position = array<i64: 2>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    %6 = "vector.extract"(%arg0) <{static_position = array<i64: 3>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    %7 = "vector.vscale"() : () -> index
    %8 = "arith.muli"(%7, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "scf.for"(%2, %8, %0) ({
    ^bb0(%arg4: index):
      %9 = "affine.apply"(%arg4, %arg2) <{map = #map}> : (index, index) -> index
      %10 = "vector.extract"(%3, %arg4) <{static_position = array<i64: -9223372036854775808>}> : (vector<[4]xf32>, index) -> f32
      %11 = "vector.extract"(%4, %arg4) <{static_position = array<i64: -9223372036854775808>}> : (vector<[4]xf32>, index) -> f32
      %12 = "vector.extract"(%5, %arg4) <{static_position = array<i64: -9223372036854775808>}> : (vector<[4]xf32>, index) -> f32
      %13 = "vector.extract"(%6, %arg4) <{static_position = array<i64: -9223372036854775808>}> : (vector<[4]xf32>, index) -> f32
      %14 = "vector.from_elements"(%10, %11, %12, %13) : (f32, f32, f32, f32) -> vector<4xf32>
      "vector.transfer_write"(%14, %arg1, %9, %arg3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<4xf32>, memref<?x?xf32>, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0] -> (d0 + s0)>
#map1 = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x[4]xf32>, memref<?x?xf32>, index, index, index, index) -> (), sym_name = "scalable_transpose_store_dynamic_mask"}> ({
  ^bb0(%arg0: vector<4x[4]xf32>, %arg1: memref<?x?xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "vector.extract"(%arg0) <{static_position = array<i64: 0>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    %3 = "vector.extract"(%arg0) <{static_position = array<i64: 1>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    %4 = "vector.extract"(%arg0) <{static_position = array<i64: 2>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    %5 = "vector.extract"(%arg0) <{static_position = array<i64: 3>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    %6 = "vector.create_mask"(%arg5) : (index) -> vector<4xi1>
    "scf.for"(%1, %arg4, %0) ({
    ^bb0(%arg6: index):
      %7 = "affine.apply"(%arg6, %arg2) <{map = #map}> : (index, index) -> index
      %8 = "vector.extract"(%2, %arg6) <{static_position = array<i64: -9223372036854775808>}> : (vector<[4]xf32>, index) -> f32
      %9 = "vector.extract"(%3, %arg6) <{static_position = array<i64: -9223372036854775808>}> : (vector<[4]xf32>, index) -> f32
      %10 = "vector.extract"(%4, %arg6) <{static_position = array<i64: -9223372036854775808>}> : (vector<[4]xf32>, index) -> f32
      %11 = "vector.extract"(%5, %arg6) <{static_position = array<i64: -9223372036854775808>}> : (vector<[4]xf32>, index) -> f32
      %12 = "vector.from_elements"(%8, %9, %10, %11) : (f32, f32, f32, f32) -> vector<4xf32>
      "vector.transfer_write"(%12, %arg1, %7, %arg3, %6) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 1>, permutation_map = #map1}> : (vector<4xf32>, memref<?x?xf32>, index, index, vector<4xi1>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0] -> (d0 + s0)>
#map1 = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x[4]xf32>, memref<?x?xf32>, index, index) -> (), sym_name = "scalable_transpose_store_constant_mask"}> ({
  ^bb0(%arg0: vector<4x[4]xf32>, %arg1: memref<?x?xf32>, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 3 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 4 : index}> : () -> index
    %4 = "vector.vscale"() : () -> index
    %5 = "arith.muli"(%4, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %6 = "vector.extract"(%arg0) <{static_position = array<i64: 0>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    %7 = "vector.extract"(%arg0) <{static_position = array<i64: 1>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    %8 = "vector.extract"(%arg0) <{static_position = array<i64: 2>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    %9 = "vector.extract"(%arg0) <{static_position = array<i64: 3>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    %10 = "vector.create_mask"(%0) : (index) -> vector<4xi1>
    "scf.for"(%2, %5, %1) ({
    ^bb0(%arg4: index):
      %11 = "affine.apply"(%arg4, %arg2) <{map = #map}> : (index, index) -> index
      %12 = "vector.extract"(%6, %arg4) <{static_position = array<i64: -9223372036854775808>}> : (vector<[4]xf32>, index) -> f32
      %13 = "vector.extract"(%7, %arg4) <{static_position = array<i64: -9223372036854775808>}> : (vector<[4]xf32>, index) -> f32
      %14 = "vector.extract"(%8, %arg4) <{static_position = array<i64: -9223372036854775808>}> : (vector<[4]xf32>, index) -> f32
      %15 = "vector.extract"(%9, %arg4) <{static_position = array<i64: -9223372036854775808>}> : (vector<[4]xf32>, index) -> f32
      %16 = "vector.from_elements"(%12, %13, %14, %15) : (f32, f32, f32, f32) -> vector<4xf32>
      "vector.transfer_write"(%16, %arg1, %11, %arg3, %10) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 1>, permutation_map = #map1}> : (vector<4xf32>, memref<?x?xf32>, index, index, vector<4xi1>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
#map1 = affine_map<()[s0] -> (s0 + 1)>
#map2 = affine_map<()[s0] -> (s0 + 2)>
#map3 = affine_map<()[s0] -> (s0 + 3)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]x4xf32>, memref<?x?xf32>, index, index) -> (), sym_name = "negative_scalable_transpose_store_0"}> ({
  ^bb0(%arg0: vector<[4]x4xf32>, %arg1: memref<?x?xf32>, %arg2: index, %arg3: index):
    %0 = "vector.transpose"(%arg0) <{permutation = array<i64: 1, 0>}> : (vector<[4]x4xf32>) -> vector<4x[4]xf32>
    %1 = "vector.extract"(%0) <{static_position = array<i64: 0>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    "vector.transfer_write"(%1, %arg1, %arg2, %arg3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<[4]xf32>, memref<?x?xf32>, index, index) -> ()
    %2 = "affine.apply"(%arg2) <{map = #map1}> : (index) -> index
    %3 = "vector.extract"(%0) <{static_position = array<i64: 1>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    "vector.transfer_write"(%3, %arg1, %2, %arg3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<[4]xf32>, memref<?x?xf32>, index, index) -> ()
    %4 = "affine.apply"(%arg2) <{map = #map2}> : (index) -> index
    %5 = "vector.extract"(%0) <{static_position = array<i64: 2>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    "vector.transfer_write"(%5, %arg1, %4, %arg3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<[4]xf32>, memref<?x?xf32>, index, index) -> ()
    %6 = "affine.apply"(%arg2) <{map = #map3}> : (index) -> index
    %7 = "vector.extract"(%0) <{static_position = array<i64: 3>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    "vector.transfer_write"(%7, %arg1, %6, %arg3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<[4]xf32>, memref<?x?xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
#map1 = affine_map<()[s0] -> (s0 + 1)>
#map2 = affine_map<()[s0] -> (s0 + 2)>
#map3 = affine_map<()[s0] -> (s0 + 3)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x[4]xf32>, memref<?x?xf32>, index, index) -> (), sym_name = "negative_scalable_transpose_store_1"}> ({
  ^bb0(%arg0: vector<4x[4]xf32>, %arg1: memref<?x?xf32>, %arg2: index, %arg3: index):
    %0 = "vector.extract"(%arg0) <{static_position = array<i64: 0>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    "vector.transfer_write"(%0, %arg1, %arg2, %arg3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<[4]xf32>, memref<?x?xf32>, index, index) -> ()
    %1 = "affine.apply"(%arg2) <{map = #map1}> : (index) -> index
    %2 = "vector.extract"(%arg0) <{static_position = array<i64: 1>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    "vector.transfer_write"(%2, %arg1, %1, %arg3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<[4]xf32>, memref<?x?xf32>, index, index) -> ()
    %3 = "affine.apply"(%arg2) <{map = #map2}> : (index) -> index
    %4 = "vector.extract"(%arg0) <{static_position = array<i64: 2>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    "vector.transfer_write"(%4, %arg1, %3, %arg3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<[4]xf32>, memref<?x?xf32>, index, index) -> ()
    %5 = "affine.apply"(%arg2) <{map = #map3}> : (index) -> index
    %6 = "vector.extract"(%arg0) <{static_position = array<i64: 3>}> : (vector<4x[4]xf32>) -> vector<[4]xf32>
    "vector.transfer_write"(%6, %arg1, %5, %arg3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<[4]xf32>, memref<?x?xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x[4]xf32>, memref<?x?xf32>, index, index) -> (), sym_name = "negative_scalable_transpose_store_2"}> ({
  ^bb0(%arg0: vector<4x[4]xf32>, %arg1: memref<?x?xf32>, %arg2: index, %arg3: index):
    %0 = "vector.transpose"(%arg0) <{permutation = array<i64: 1, 0>}> : (vector<4x[4]xf32>) -> vector<[4]x4xf32>
    "vector.transfer_write"(%0, %arg1, %arg2, %arg3) <{in_bounds = [false, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<[4]x4xf32>, memref<?x?xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]x4xf32>, memref<?x?xf32>, index, index) -> (), sym_name = "negative_scalable_transpose_store_3"}> ({
  ^bb0(%arg0: vector<[4]x4xf32>, %arg1: memref<?x?xf32>, %arg2: index, %arg3: index):
    "vector.transfer_write"(%arg0, %arg1, %arg2, %arg3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<[4]x4xf32>, memref<?x?xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

