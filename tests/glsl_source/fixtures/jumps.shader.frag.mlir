"builtin.module"() ({
  "glsl.shader"() <{es, stage = 1 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x0, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "o_color", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{builtin = 0x4, storage = 0x0, sym_name = "gl_FragCoord", ty = vector<4xf32>}> : () -> ()
    "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "firstOver"}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %171 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %172 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i32, Function>
      %173 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %174 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      "spirv.Store"(%174, %arg1) : (!spirv.ptr<f32, Function>, f32) -> ()
      "spirv.Store"(%173, %arg2) : (!spirv.ptr<f32, Function>, f32) -> ()
      %175 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      "spirv.Store"(%172, %175) : (!spirv.ptr<i32, Function>, i32) -> ()
      "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
        "spirv.Branch"()[^bb1] : () -> ()
      ^bb1:
        %178 = "spirv.Load"(%172) : (!spirv.ptr<i32, Function>) -> i32
        %179 = "arith.constant"() <{value = 32 : i32}> : () -> i32
        %180 = "arith.cmpi"(%178, %179) <{predicate = 2 : i64}> : (i32, i32) -> i1
        "spirv.BranchConditional"(%180)[^bb2, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
      ^bb2:
        %181 = "spirv.Load"(%174) : (!spirv.ptr<f32, Function>) -> f32
        %182 = "spirv.Load"(%172) : (!spirv.ptr<i32, Function>) -> i32
        %183 = "arith.sitofp"(%182) : (i32) -> f32
        %184 = "arith.mulf"(%181, %183) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %185 = "arith.constant"() <{value = 3.700000e-01 : f32}> : () -> f32
        %186 = "arith.mulf"(%184, %185) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "spirv.Store"(%171, %186) : (!spirv.ptr<f32, Function>, f32) -> ()
        %187 = "spirv.Load"(%171) : (!spirv.ptr<f32, Function>) -> f32
        %188 = "spirv.Load"(%173) : (!spirv.ptr<f32, Function>) -> f32
        %189 = "arith.cmpf"(%187, %188) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
        "spirv.BranchConditional"(%189)[^bb3, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> {selection_merge = 4 : i64} : (i1) -> ()
      ^bb3:
        %190 = "spirv.Load"(%171) : (!spirv.ptr<f32, Function>) -> f32
        "spirv.ReturnValue"(%190) : (f32) -> ()
      ^bb4:
        "spirv.Branch"()[^bb5] : () -> ()
      ^bb5:
        %191 = "spirv.Load"(%172) : (!spirv.ptr<i32, Function>) -> i32
        %192 = "arith.constant"() <{value = 1 : i32}> : () -> i32
        %193 = "arith.addi"(%191, %192) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "spirv.Store"(%172, %193) : (!spirv.ptr<i32, Function>, i32) -> ()
        "spirv.Branch"()[^bb1] : () -> ()
      ^bb6:
        "spirv.mlir.merge"() : () -> ()
      }) : () -> ()
      %176 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %177 = "arith.negf"(%176) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "spirv.ReturnValue"(%177) : (f32) -> ()
    }) : () -> ()
    "func.func"() <{function_type = (f32) -> f32, sym_name = "classify"}> ({
    ^bb0(%arg0: f32):
      %159 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      "spirv.Store"(%159, %arg0) : (!spirv.ptr<f32, Function>, f32) -> ()
      %160 = "spirv.Load"(%159) : (!spirv.ptr<f32, Function>) -> f32
      %161 = "arith.constant"() <{value = 1.000000e+01 : f32}> : () -> f32
      %162 = "arith.cmpf"(%160, %161) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
      "spirv.BranchConditional"(%162)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> {selection_merge = 2 : i64} : (i1) -> ()
    ^bb1:
      %163 = "arith.constant"() <{value = 2.500000e-01 : f32}> : () -> f32
      "spirv.ReturnValue"(%163) : (f32) -> ()
    ^bb2:
      %164 = "spirv.Load"(%159) : (!spirv.ptr<f32, Function>) -> f32
      %165 = "arith.constant"() <{value = 3.000000e+01 : f32}> : () -> f32
      %166 = "arith.cmpf"(%164, %165) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
      "spirv.BranchConditional"(%166)[^bb3, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> {selection_merge = 4 : i64} : (i1) -> ()
    ^bb3:
      %167 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      "spirv.ReturnValue"(%167) : (f32) -> ()
    ^bb4:
      %168 = "spirv.Load"(%159) : (!spirv.ptr<f32, Function>) -> f32
      %169 = "arith.constant"() <{value = 6.400000e+01 : f32}> : () -> f32
      %170 = "arith.divf"(%168, %169) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "spirv.ReturnValue"(%170) : (f32) -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i32, Function>
      %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %2 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i32, Function>
      %3 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %4 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i32, Function>
      %5 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i32, Function>
      %6 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %7 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i32, Function>
      %8 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %9 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i32, Function>
      %10 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %11 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %12 = "glsl.load"() <{var = @gl_FragCoord}> : () -> vector<4xf32>
      %13 = "vector.shuffle"(%12, %12) <{mask = array<i64: 0, 1>}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
      "spirv.Store"(%11, %13) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %14 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      "spirv.Store"(%10, %14) : (!spirv.ptr<f32, Function>, f32) -> ()
      %15 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      "spirv.Store"(%9, %15) : (!spirv.ptr<i32, Function>, i32) -> ()
      "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
        "spirv.Branch"()[^bb1] : () -> ()
      ^bb1:
        %136 = "spirv.Load"(%9) : (!spirv.ptr<i32, Function>) -> i32
        %137 = "arith.constant"() <{value = 20 : i32}> : () -> i32
        %138 = "arith.cmpi"(%136, %137) <{predicate = 2 : i64}> : (i32, i32) -> i1
        "spirv.BranchConditional"(%138)[^bb2, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
      ^bb2:
        %139 = "spirv.Load"(%9) : (!spirv.ptr<i32, Function>) -> i32
        %140 = "arith.sitofp"(%139) : (i32) -> f32
        %141 = "arith.constant"() <{value = 3.000000e+00 : f32}> : () -> f32
        %142 = "arith.mulf"(%140, %141) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %143 = "spirv.Load"(%11) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
        %144 = "vector.extract"(%143) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
        %145 = "arith.cmpf"(%142, %144) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
        "spirv.BranchConditional"(%145)[^bb3, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> {selection_merge = 4 : i64} : (i1) -> ()
      ^bb3:
        "spirv.Branch"()[^bb6] : () -> ()
      ^bb4:
        %146 = "spirv.Load"(%10) : (!spirv.ptr<f32, Function>) -> f32
        %147 = "spirv.Load"(%9) : (!spirv.ptr<i32, Function>) -> i32
        %148 = "arith.sitofp"(%147) : (i32) -> f32
        %149 = "spirv.Load"(%11) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
        %150 = "vector.extract"(%149) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
        %151 = "arith.constant"() <{value = 1.000000e-01 : f32}> : () -> f32
        %152 = "arith.mulf"(%150, %151) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %153 = "arith.addf"(%148, %152) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %154 = "glsl.builtin"(%153) <{func = 0x2}> : (f32) -> f32
        %155 = "arith.addf"(%146, %154) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "spirv.Store"(%10, %155) : (!spirv.ptr<f32, Function>, f32) -> ()
        "spirv.Branch"()[^bb5] : () -> ()
      ^bb5:
        %156 = "spirv.Load"(%9) : (!spirv.ptr<i32, Function>) -> i32
        %157 = "arith.constant"() <{value = 1 : i32}> : () -> i32
        %158 = "arith.addi"(%156, %157) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "spirv.Store"(%9, %158) : (!spirv.ptr<i32, Function>, i32) -> ()
        "spirv.Branch"()[^bb1] : () -> ()
      ^bb6:
        "spirv.mlir.merge"() : () -> ()
      }) : () -> ()
      %16 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      "spirv.Store"(%8, %16) : (!spirv.ptr<f32, Function>, f32) -> ()
      %17 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      "spirv.Store"(%7, %17) : (!spirv.ptr<i32, Function>, i32) -> ()
      "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
        "spirv.Branch"()[^bb1] : () -> ()
      ^bb1:
        %119 = "spirv.Load"(%7) : (!spirv.ptr<i32, Function>) -> i32
        %120 = "arith.constant"() <{value = 16 : i32}> : () -> i32
        %121 = "arith.cmpi"(%119, %120) <{predicate = 2 : i64}> : (i32, i32) -> i1
        "spirv.BranchConditional"(%121)[^bb2, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
      ^bb2:
        %122 = "spirv.Load"(%7) : (!spirv.ptr<i32, Function>) -> i32
        %123 = "arith.constant"() <{value = 1 : i32}> : () -> i32
        %124 = "arith.addi"(%122, %123) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "spirv.Store"(%7, %124) : (!spirv.ptr<i32, Function>, i32) -> ()
        %125 = "spirv.Load"(%7) : (!spirv.ptr<i32, Function>) -> i32
        %126 = "arith.constant"() <{value = 3 : i32}> : () -> i32
        %127 = "arith.remsi"(%125, %126) : (i32, i32) -> i32
        %128 = "arith.constant"() <{value = 0 : i32}> : () -> i32
        %129 = "arith.cmpi"(%127, %128) <{predicate = 0 : i64}> : (i32, i32) -> i1
        "spirv.BranchConditional"(%129)[^bb3, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> {selection_merge = 4 : i64} : (i1) -> ()
      ^bb3:
        "spirv.Branch"()[^bb5] : () -> ()
      ^bb4:
        %130 = "spirv.Load"(%8) : (!spirv.ptr<f32, Function>) -> f32
        %131 = "spirv.Load"(%7) : (!spirv.ptr<i32, Function>) -> i32
        %132 = "arith.sitofp"(%131) : (i32) -> f32
        %133 = "arith.constant"() <{value = 1.250000e-01 : f32}> : () -> f32
        %134 = "arith.mulf"(%132, %133) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %135 = "arith.addf"(%130, %134) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "spirv.Store"(%8, %135) : (!spirv.ptr<f32, Function>, f32) -> ()
        "spirv.Branch"()[^bb5] : () -> ()
      ^bb5:
        "spirv.Branch"()[^bb1] : () -> ()
      ^bb6:
        "spirv.mlir.merge"() : () -> ()
      }) : () -> ()
      %18 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      "spirv.Store"(%6, %18) : (!spirv.ptr<f32, Function>, f32) -> ()
      %19 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      "spirv.Store"(%5, %19) : (!spirv.ptr<i32, Function>, i32) -> ()
      "scf.while"() ({
        %116 = "spirv.Load"(%5) : (!spirv.ptr<i32, Function>) -> i32
        %117 = "arith.constant"() <{value = 8 : i32}> : () -> i32
        %118 = "arith.cmpi"(%116, %117) <{predicate = 2 : i64}> : (i32, i32) -> i1
        "scf.condition"(%118) : (i1) -> ()
      }, {
        %93 = "arith.constant"() <{value = 0 : i32}> : () -> i32
        "spirv.Store"(%4, %93) : (!spirv.ptr<i32, Function>, i32) -> ()
        "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
          "spirv.Branch"()[^bb1] : () -> ()
        ^bb1:
          %97 = "spirv.Load"(%4) : (!spirv.ptr<i32, Function>) -> i32
          %98 = "arith.constant"() <{value = 8 : i32}> : () -> i32
          %99 = "arith.cmpi"(%97, %98) <{predicate = 2 : i64}> : (i32, i32) -> i1
          "spirv.BranchConditional"(%99)[^bb2, ^bb8] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
        ^bb2:
          %100 = "spirv.Load"(%4) : (!spirv.ptr<i32, Function>) -> i32
          %101 = "spirv.Load"(%5) : (!spirv.ptr<i32, Function>) -> i32
          %102 = "arith.cmpi"(%100, %101) <{predicate = 4 : i64}> : (i32, i32) -> i1
          "spirv.BranchConditional"(%102)[^bb3, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> {selection_merge = 4 : i64} : (i1) -> ()
        ^bb3:
          "spirv.Branch"()[^bb8] : () -> ()
        ^bb4:
          %103 = "spirv.Load"(%5) : (!spirv.ptr<i32, Function>) -> i32
          %104 = "spirv.Load"(%4) : (!spirv.ptr<i32, Function>) -> i32
          %105 = "arith.addi"(%103, %104) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          %106 = "arith.constant"() <{value = 2 : i32}> : () -> i32
          %107 = "arith.remsi"(%105, %106) : (i32, i32) -> i32
          %108 = "arith.constant"() <{value = 1 : i32}> : () -> i32
          %109 = "arith.cmpi"(%107, %108) <{predicate = 0 : i64}> : (i32, i32) -> i1
          "spirv.BranchConditional"(%109)[^bb5, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> {selection_merge = 6 : i64} : (i1) -> ()
        ^bb5:
          "spirv.Branch"()[^bb7] : () -> ()
        ^bb6:
          %110 = "spirv.Load"(%6) : (!spirv.ptr<f32, Function>) -> f32
          %111 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
          %112 = "arith.addf"(%110, %111) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "spirv.Store"(%6, %112) : (!spirv.ptr<f32, Function>, f32) -> ()
          "spirv.Branch"()[^bb7] : () -> ()
        ^bb7:
          %113 = "spirv.Load"(%4) : (!spirv.ptr<i32, Function>) -> i32
          %114 = "arith.constant"() <{value = 1 : i32}> : () -> i32
          %115 = "arith.addi"(%113, %114) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          "spirv.Store"(%4, %115) : (!spirv.ptr<i32, Function>, i32) -> ()
          "spirv.Branch"()[^bb1] : () -> ()
        ^bb8:
          "spirv.mlir.merge"() : () -> ()
        }) : () -> ()
        %94 = "spirv.Load"(%5) : (!spirv.ptr<i32, Function>) -> i32
        %95 = "arith.constant"() <{value = 1 : i32}> : () -> i32
        %96 = "arith.addi"(%94, %95) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "spirv.Store"(%5, %96) : (!spirv.ptr<i32, Function>, i32) -> ()
        "scf.yield"() : () -> ()
      }) : () -> ()
      %20 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      "spirv.Store"(%3, %20) : (!spirv.ptr<f32, Function>, f32) -> ()
      %21 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      "spirv.Store"(%2, %21) : (!spirv.ptr<i32, Function>, i32) -> ()
      "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
        "spirv.Branch"()[^bb1] : () -> ()
      ^bb1:
        "spirv.Branch"()[^bb2] : () -> ()
      ^bb2:
        %75 = "spirv.Load"(%2) : (!spirv.ptr<i32, Function>) -> i32
        %76 = "arith.constant"() <{value = 1 : i32}> : () -> i32
        %77 = "arith.addi"(%75, %76) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "spirv.Store"(%2, %77) : (!spirv.ptr<i32, Function>, i32) -> ()
        %78 = "spirv.Load"(%2) : (!spirv.ptr<i32, Function>) -> i32
        %79 = "arith.constant"() <{value = 2 : i32}> : () -> i32
        %80 = "arith.cmpi"(%78, %79) <{predicate = 0 : i64}> : (i32, i32) -> i1
        "spirv.BranchConditional"(%80)[^bb3, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> {selection_merge = 4 : i64} : (i1) -> ()
      ^bb3:
        %81 = "spirv.Load"(%2) : (!spirv.ptr<i32, Function>) -> i32
        %82 = "arith.constant"() <{value = 5 : i32}> : () -> i32
        %83 = "arith.cmpi"(%81, %82) <{predicate = 2 : i64}> : (i32, i32) -> i1
        "spirv.BranchConditional"(%83)[^bb5, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
      ^bb4:
        %84 = "spirv.Load"(%3) : (!spirv.ptr<f32, Function>) -> f32
        %85 = "spirv.Load"(%11) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
        %86 = "vector.extract"(%85) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
        %87 = "arith.constant"() <{value = 0.00999999977 : f32}> : () -> f32
        %88 = "arith.mulf"(%86, %87) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %89 = "arith.addf"(%84, %88) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "spirv.Store"(%3, %89) : (!spirv.ptr<f32, Function>, f32) -> ()
        %90 = "spirv.Load"(%2) : (!spirv.ptr<i32, Function>) -> i32
        %91 = "arith.constant"() <{value = 5 : i32}> : () -> i32
        %92 = "arith.cmpi"(%90, %91) <{predicate = 2 : i64}> : (i32, i32) -> i1
        "spirv.BranchConditional"(%92)[^bb5, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
      ^bb5:
        "spirv.Branch"()[^bb1] : () -> ()
      ^bb6:
        "spirv.mlir.merge"() : () -> ()
      }) : () -> ()
      %22 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      "spirv.Store"(%1, %22) : (!spirv.ptr<f32, Function>, f32) -> ()
      %23 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      "spirv.Store"(%0, %23) : (!spirv.ptr<i32, Function>, i32) -> ()
      "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
        "spirv.Branch"()[^bb1] : () -> ()
      ^bb1:
        %54 = "spirv.Load"(%0) : (!spirv.ptr<i32, Function>) -> i32
        %55 = "arith.constant"() <{value = 16 : i32}> : () -> i32
        %56 = "arith.cmpi"(%54, %55) <{predicate = 2 : i64}> : (i32, i32) -> i1
        "spirv.BranchConditional"(%56)[^bb2, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
      ^bb2:
        %57 = "spirv.Load"(%0) : (!spirv.ptr<i32, Function>) -> i32
        %58 = "spirv.Load"(%11) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
        %59 = "vector.extract"(%58) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
        %60 = "arith.fptosi"(%59) : (f32) -> i32
        %61 = "arith.constant"() <{value = 7 : i32}> : () -> i32
        %62 = "arith.remsi"(%60, %61) : (i32, i32) -> i32
        %63 = "arith.constant"() <{value = 3 : i32}> : () -> i32
        %64 = "arith.addi"(%62, %63) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %65 = "arith.cmpi"(%57, %64) <{predicate = 0 : i64}> : (i32, i32) -> i1
        "spirv.BranchConditional"(%65)[^bb3, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> {selection_merge = 4 : i64} : (i1) -> ()
      ^bb3:
        "spirv.Branch"()[^bb6] : () -> ()
      ^bb4:
        %66 = "spirv.Load"(%1) : (!spirv.ptr<f32, Function>) -> f32
        %67 = "spirv.Load"(%0) : (!spirv.ptr<i32, Function>) -> i32
        %68 = "arith.sitofp"(%67) : (i32) -> f32
        %69 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
        %70 = "arith.mulf"(%68, %69) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %71 = "arith.addf"(%66, %70) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "spirv.Store"(%1, %71) : (!spirv.ptr<f32, Function>, f32) -> ()
        "spirv.Branch"()[^bb5] : () -> ()
      ^bb5:
        %72 = "spirv.Load"(%0) : (!spirv.ptr<i32, Function>) -> i32
        %73 = "arith.constant"() <{value = 1 : i32}> : () -> i32
        %74 = "arith.addi"(%72, %73) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "spirv.Store"(%0, %74) : (!spirv.ptr<i32, Function>, i32) -> ()
        "spirv.Branch"()[^bb1] : () -> ()
      ^bb6:
        "spirv.mlir.merge"() : () -> ()
      }) : () -> ()
      %24 = "spirv.Load"(%11) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %25 = "vector.extract"(%24) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %26 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
      %27 = "arith.cmpf"(%25, %26) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
      "spirv.BranchConditional"(%27)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> {selection_merge = 2 : i64} : (i1) -> ()
    ^bb1:
      %28 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %29 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %30 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %31 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %32 = "glsl.construct"(%28, %29, %30, %31) : (f32, f32, f32, f32) -> vector<4xf32>
      "glsl.store"(%32) <{var = @o_color}> : (vector<4xf32>) -> ()
      "spirv.Return"() : () -> ()
    ^bb2:
      %33 = "spirv.Load"(%10) : (!spirv.ptr<f32, Function>) -> f32
      %34 = "spirv.Load"(%11) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %35 = "vector.extract"(%34) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %36 = "arith.constant"() <{value = 2.000000e+01 : f32}> : () -> f32
      %37 = "func.call"(%35, %36) <{callee = @firstOver}> : (f32, f32) -> f32
      %38 = "arith.addf"(%33, %37) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %39 = "spirv.Load"(%8) : (!spirv.ptr<f32, Function>) -> f32
      %40 = "spirv.Load"(%6) : (!spirv.ptr<f32, Function>) -> f32
      %41 = "arith.addf"(%39, %40) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %42 = "spirv.Load"(%3) : (!spirv.ptr<f32, Function>) -> f32
      %43 = "spirv.Load"(%11) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %44 = "vector.extract"(%43) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %45 = "func.call"(%44) <{callee = @classify}> : (f32) -> f32
      %46 = "arith.addf"(%42, %45) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %47 = "spirv.Load"(%10) : (!spirv.ptr<f32, Function>) -> f32
      %48 = "spirv.Load"(%8) : (!spirv.ptr<f32, Function>) -> f32
      %49 = "arith.mulf"(%47, %48) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %50 = "glsl.builtin"(%49) <{func = 0x22}> : (f32) -> f32
      %51 = "spirv.Load"(%1) : (!spirv.ptr<f32, Function>) -> f32
      %52 = "arith.addf"(%50, %51) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %53 = "glsl.construct"(%38, %41, %46, %52) : (f32, f32, f32, f32) -> vector<4xf32>
      "glsl.store"(%53) <{var = @o_color}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
