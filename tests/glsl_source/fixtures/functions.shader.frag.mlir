"builtin.module"() ({
  "glsl.shader"() <{es, stage = 1 : i64, version = 310 : i32}> ({
    "glsl.global"() <{location = 0 : i32, storage = 0x0, sym_name = "v_uv", ty = vector<2xf32>}> : () -> ()
    "glsl.global"() <{location = 0 : i32, storage = 0x1, sym_name = "o_color", ty = vector<4xf32>}> : () -> ()
    "glsl.global"() <{builtin = 0x4, storage = 0x0, sym_name = "gl_FragCoord", ty = vector<4xf32>}> : () -> ()
    "func.func"() <{function_type = (f32) -> f32, sym_name = "scale"}> ({
    ^bb0(%arg11: f32):
      %187 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      "spirv.Store"(%187, %arg11) : (!spirv.ptr<f32, Function>, f32) -> ()
      %188 = "spirv.Load"(%187) : (!spirv.ptr<f32, Function>) -> f32
      %189 = "arith.constant"() <{value = 1.500000e+00 : f32}> : () -> f32
      %190 = "arith.mulf"(%188, %189) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %191 = "arith.constant"() <{value = 2.500000e-01 : f32}> : () -> f32
      %192 = "arith.addf"(%190, %191) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "spirv.ReturnValue"(%192) : (f32) -> ()
    }) : () -> ()
    "func.func"() <{function_type = (vector<2xf32>) -> vector<2xf32>, sym_name = "scale.1"}> ({
    ^bb0(%arg10: vector<2xf32>):
      %179 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      "spirv.Store"(%179, %arg10) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %180 = "spirv.Load"(%179) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %181 = "arith.constant"() <{value = 7.500000e-01 : f32}> : () -> f32
      %182 = "glsl.construct"(%181) : (f32) -> vector<2xf32>
      %183 = "arith.mulf"(%180, %182) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      %184 = "arith.constant"() <{value = 1.250000e-01 : f32}> : () -> f32
      %185 = "glsl.construct"(%184) : (f32) -> vector<2xf32>
      %186 = "arith.subf"(%183, %185) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      "spirv.ReturnValue"(%186) : (vector<2xf32>) -> ()
    }) : () -> ()
    "func.func"() <{function_type = (i32) -> i32, sym_name = "scale.2"}> ({
    ^bb0(%arg9: i32):
      %173 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i32, Function>
      "spirv.Store"(%173, %arg9) : (!spirv.ptr<i32, Function>, i32) -> ()
      %174 = "spirv.Load"(%173) : (!spirv.ptr<i32, Function>) -> i32
      %175 = "arith.constant"() <{value = 3 : i32}> : () -> i32
      %176 = "arith.muli"(%174, %175) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %177 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %178 = "arith.addi"(%176, %177) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "spirv.ReturnValue"(%178) : (i32) -> ()
    }) : () -> ()
    "func.func"() <{function_type = (f32, !spirv.ptr<f32, Function>, !spirv.ptr<f32, Function>) -> (), sym_name = "split"}> ({
    ^bb0(%arg6: f32, %arg7: !spirv.ptr<f32, Function>, %arg8: !spirv.ptr<f32, Function>):
      %167 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      "spirv.Store"(%167, %arg6) : (!spirv.ptr<f32, Function>, f32) -> ()
      %168 = "spirv.Load"(%167) : (!spirv.ptr<f32, Function>) -> f32
      %169 = "glsl.builtin"(%168) <{func = 0x16}> : (f32) -> f32
      "spirv.Store"(%arg7, %169) : (!spirv.ptr<f32, Function>, f32) -> ()
      %170 = "spirv.Load"(%167) : (!spirv.ptr<f32, Function>) -> f32
      %171 = "spirv.Load"(%arg7) : (!spirv.ptr<f32, Function>) -> f32
      %172 = "arith.subf"(%170, %171) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "spirv.Store"(%arg8, %172) : (!spirv.ptr<f32, Function>, f32) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>, f32) -> (), sym_name = "accumulate"}> ({
    ^bb0(%arg3: !spirv.ptr<vector<3xf32>, Function>, %arg4: vector<3xf32>, %arg5: f32):
      %159 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %160 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      "spirv.Store"(%160, %arg4) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      "spirv.Store"(%159, %arg5) : (!spirv.ptr<f32, Function>, f32) -> ()
      %161 = "spirv.Load"(%arg3) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %162 = "spirv.Load"(%160) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %163 = "spirv.Load"(%159) : (!spirv.ptr<f32, Function>) -> f32
      %164 = "glsl.construct"(%163) : (f32) -> vector<3xf32>
      %165 = "arith.mulf"(%162, %164) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
      %166 = "arith.addf"(%161, %165) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
      "spirv.Store"(%arg3, %166) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (!spirv.ptr<f32, Function>, f32, f32) -> i1, sym_name = "clampTo"}> ({
    ^bb0(%arg0: !spirv.ptr<f32, Function>, %arg1: f32, %arg2: f32):
      %146 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %147 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      "spirv.Store"(%147, %arg1) : (!spirv.ptr<f32, Function>, f32) -> ()
      "spirv.Store"(%146, %arg2) : (!spirv.ptr<f32, Function>, f32) -> ()
      %148 = "spirv.Load"(%arg0) : (!spirv.ptr<f32, Function>) -> f32
      %149 = "spirv.Load"(%147) : (!spirv.ptr<f32, Function>) -> f32
      %150 = "arith.cmpf"(%148, %149) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
      "spirv.BranchConditional"(%150)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> {selection_merge = 2 : i64} : (i1) -> ()
    ^bb1:
      %151 = "spirv.Load"(%147) : (!spirv.ptr<f32, Function>) -> f32
      "spirv.Store"(%arg0, %151) : (!spirv.ptr<f32, Function>, f32) -> ()
      %152 = "arith.constant"() <{value = 1 : i1}> : () -> i1
      "spirv.ReturnValue"(%152) : (i1) -> ()
    ^bb2:
      %153 = "spirv.Load"(%arg0) : (!spirv.ptr<f32, Function>) -> f32
      %154 = "spirv.Load"(%146) : (!spirv.ptr<f32, Function>) -> f32
      %155 = "arith.cmpf"(%153, %154) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
      "spirv.BranchConditional"(%155)[^bb3, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> {selection_merge = 4 : i64} : (i1) -> ()
    ^bb3:
      %156 = "spirv.Load"(%146) : (!spirv.ptr<f32, Function>) -> f32
      "spirv.Store"(%arg0, %156) : (!spirv.ptr<f32, Function>, f32) -> ()
      %157 = "arith.constant"() <{value = 1 : i1}> : () -> i1
      "spirv.ReturnValue"(%157) : (i1) -> ()
    ^bb4:
      %158 = "arith.constant"() <{value = 0 : i1}> : () -> i1
      "spirv.ReturnValue"(%158) : (i1) -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
      %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %2 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.array<3 x f32>, Function>
      %3 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %4 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i1, Function>
      %5 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %6 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %7 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %8 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<4xf32>, Function>
      %9 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      %10 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i32, Function>
      %11 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<3xf32>, Function>
      %12 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %13 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %14 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %15 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
      %16 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<vector<2xf32>, Function>
      %17 = "glsl.load"() <{var = @gl_FragCoord}> : () -> vector<4xf32>
      %18 = "vector.shuffle"(%17, %17) <{mask = array<i64: 0, 1>}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
      "spirv.Store"(%16, %18) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
      %19 = "spirv.Load"(%16) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %20 = "vector.extract"(%19) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %21 = "arith.constant"() <{value = 3.700000e-01 : f32}> : () -> f32
      %22 = "arith.mulf"(%20, %21) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "func.call"(%22, %13, %12) <{callee = @split}> : (f32, !spirv.ptr<f32, Function>, !spirv.ptr<f32, Function>) -> ()
      %23 = "spirv.Load"(%13) : (!spirv.ptr<f32, Function>) -> f32
      "spirv.Store"(%15, %23) : (!spirv.ptr<f32, Function>, f32) -> ()
      %24 = "spirv.Load"(%12) : (!spirv.ptr<f32, Function>) -> f32
      "spirv.Store"(%14, %24) : (!spirv.ptr<f32, Function>, f32) -> ()
      %25 = "arith.constant"() <{value = 0 : i1}> : () -> i1
      %26 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %27 = "glsl.construct"(%26) : (f32) -> vector<3xf32>
      "spirv.Store"(%11, %27) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
      %28 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      "spirv.Store"(%10, %28) : (!spirv.ptr<i32, Function>, i32) -> ()
      "scf.while"() ({
        %143 = "spirv.Load"(%10) : (!spirv.ptr<i32, Function>) -> i32
        %144 = "arith.constant"() <{value = 3 : i32}> : () -> i32
        %145 = "arith.cmpi"(%143, %144) <{predicate = 2 : i64}> : (i32, i32) -> i1
        "scf.condition"(%145) : (i1) -> ()
      }, {
        %128 = "spirv.Load"(%16) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
        %129 = "spirv.Load"(%10) : (!spirv.ptr<i32, Function>) -> i32
        %130 = "arith.sitofp"(%129) : (i32) -> f32
        %131 = "glsl.construct"(%128, %130) : (vector<2xf32>, f32) -> vector<3xf32>
        %132 = "arith.constant"() <{value = 1.000000e-01 : f32}> : () -> f32
        %133 = "spirv.Load"(%10) : (!spirv.ptr<i32, Function>) -> i32
        %134 = "func.call"(%133) <{callee = @scale.2}> : (i32) -> i32
        %135 = "arith.sitofp"(%134) : (i32) -> f32
        %136 = "arith.mulf"(%132, %135) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %137 = "spirv.Load"(%11) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
        "spirv.Store"(%9, %137) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
        "func.call"(%9, %131, %136) <{callee = @accumulate}> : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>, f32) -> ()
        %138 = "spirv.Load"(%9) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
        "spirv.Store"(%11, %138) : (!spirv.ptr<vector<3xf32>, Function>, vector<3xf32>) -> ()
        %139 = "arith.constant"() <{value = 0 : i1}> : () -> i1
        %140 = "spirv.Load"(%10) : (!spirv.ptr<i32, Function>) -> i32
        %141 = "arith.constant"() <{value = 1 : i32}> : () -> i32
        %142 = "arith.addi"(%140, %141) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "spirv.Store"(%10, %142) : (!spirv.ptr<i32, Function>, i32) -> ()
        "scf.yield"() : () -> ()
      }) : () -> ()
      %29 = "spirv.Load"(%16) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %30 = "vector.extract"(%29) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %31 = "arith.constant"() <{value = 0.00999999977 : f32}> : () -> f32
      %32 = "arith.mulf"(%30, %31) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %33 = "func.call"(%32) <{callee = @scale}> : (f32) -> f32
      %34 = "glsl.load"() <{var = @v_uv}> : () -> vector<2xf32>
      %35 = "func.call"(%34) <{callee = @scale.1}> : (vector<2xf32>) -> vector<2xf32>
      %36 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %37 = "glsl.construct"(%33, %35, %36) : (f32, vector<2xf32>, f32) -> vector<4xf32>
      "spirv.Store"(%8, %37) : (!spirv.ptr<vector<4xf32>, Function>, vector<4xf32>) -> ()
      %38 = "spirv.Load"(%16) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %39 = "vector.extract"(%38) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %40 = "arith.constant"() <{value = 2.100000e-01 : f32}> : () -> f32
      %41 = "arith.mulf"(%39, %40) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "func.call"(%41, %7, %6) <{callee = @split}> : (f32, !spirv.ptr<f32, Function>, !spirv.ptr<f32, Function>) -> ()
      %42 = "spirv.Load"(%7) : (!spirv.ptr<f32, Function>) -> f32
      %43 = "spirv.Load"(%8) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %44 = "vector.insert"(%42, %43) <{static_position = array<i64: 2>}> : (f32, vector<4xf32>) -> vector<4xf32>
      "spirv.Store"(%8, %44) : (!spirv.ptr<vector<4xf32>, Function>, vector<4xf32>) -> ()
      %45 = "spirv.Load"(%6) : (!spirv.ptr<f32, Function>) -> f32
      %46 = "spirv.Load"(%8) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %47 = "vector.insert"(%45, %46) <{static_position = array<i64: 3>}> : (f32, vector<4xf32>) -> vector<4xf32>
      "spirv.Store"(%8, %47) : (!spirv.ptr<vector<4xf32>, Function>, vector<4xf32>) -> ()
      %48 = "arith.constant"() <{value = 0 : i1}> : () -> i1
      %49 = "spirv.Load"(%16) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %50 = "vector.extract"(%49) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %51 = "arith.constant"() <{value = 5.000000e-02 : f32}> : () -> f32
      %52 = "arith.mulf"(%50, %51) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %53 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %54 = "arith.subf"(%52, %53) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "spirv.Store"(%5, %54) : (!spirv.ptr<f32, Function>, f32) -> ()
      %55 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %56 = "arith.negf"(%55) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %57 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %58 = "spirv.Load"(%5) : (!spirv.ptr<f32, Function>) -> f32
      "spirv.Store"(%3, %58) : (!spirv.ptr<f32, Function>, f32) -> ()
      %59 = "func.call"(%3, %56, %57) <{callee = @clampTo}> : (!spirv.ptr<f32, Function>, f32, f32) -> i1
      %60 = "spirv.Load"(%3) : (!spirv.ptr<f32, Function>) -> f32
      "spirv.Store"(%5, %60) : (!spirv.ptr<f32, Function>, f32) -> ()
      "spirv.Store"(%4, %59) : (!spirv.ptr<i1, Function>, i1) -> ()
      %61 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %62 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %63 = "spirv.AccessChain"(%2, %61) : (!spirv.ptr<!spirv.array<3 x f32>, Function>, i32) -> !spirv.ptr<f32, Function>
      "spirv.Store"(%63, %62) : (!spirv.ptr<f32, Function>, f32) -> ()
      %64 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %65 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %66 = "spirv.AccessChain"(%2, %64) : (!spirv.ptr<!spirv.array<3 x f32>, Function>, i32) -> !spirv.ptr<f32, Function>
      "spirv.Store"(%66, %65) : (!spirv.ptr<f32, Function>, f32) -> ()
      %67 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %68 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %69 = "spirv.AccessChain"(%2, %67) : (!spirv.ptr<!spirv.array<3 x f32>, Function>, i32) -> !spirv.ptr<f32, Function>
      "spirv.Store"(%69, %68) : (!spirv.ptr<f32, Function>, f32) -> ()
      %70 = "spirv.Load"(%16) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %71 = "vector.extract"(%70) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
      %72 = "arith.constant"() <{value = 1.100000e-01 : f32}> : () -> f32
      %73 = "arith.mulf"(%71, %72) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %74 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %75 = "spirv.Load"(%16) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
      %76 = "vector.extract"(%75) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
      %77 = "arith.fptosi"(%76) : (f32) -> i32
      %78 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %79 = "arith.remsi"(%77, %78) : (i32, i32) -> i32
      %80 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %81 = "arith.muli"(%79, %80) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "func.call"(%73, %1, %0) <{callee = @split}> : (f32, !spirv.ptr<f32, Function>, !spirv.ptr<f32, Function>) -> ()
      %82 = "spirv.Load"(%1) : (!spirv.ptr<f32, Function>) -> f32
      %83 = "spirv.AccessChain"(%2, %74) : (!spirv.ptr<!spirv.array<3 x f32>, Function>, i32) -> !spirv.ptr<f32, Function>
      "spirv.Store"(%83, %82) : (!spirv.ptr<f32, Function>, f32) -> ()
      %84 = "spirv.Load"(%0) : (!spirv.ptr<f32, Function>) -> f32
      %85 = "spirv.AccessChain"(%2, %81) : (!spirv.ptr<!spirv.array<3 x f32>, Function>, i32) -> !spirv.ptr<f32, Function>
      "spirv.Store"(%85, %84) : (!spirv.ptr<f32, Function>, f32) -> ()
      %86 = "arith.constant"() <{value = 0 : i1}> : () -> i1
      %87 = "spirv.Load"(%15) : (!spirv.ptr<f32, Function>) -> f32
      %88 = "spirv.Load"(%14) : (!spirv.ptr<f32, Function>) -> f32
      %89 = "arith.addf"(%87, %88) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %90 = "spirv.Load"(%11) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %91 = "vector.extract"(%90) <{static_position = array<i64: 0>}> : (vector<3xf32>) -> f32
      %92 = "arith.addf"(%89, %91) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %93 = "spirv.Load"(%11) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %94 = "vector.extract"(%93) <{static_position = array<i64: 1>}> : (vector<3xf32>) -> f32
      %95 = "spirv.Load"(%8) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %96 = "vector.extract"(%95) <{static_position = array<i64: 0>}> : (vector<4xf32>) -> f32
      %97 = "arith.addf"(%94, %96) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %98 = "spirv.Load"(%8) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %99 = "vector.extract"(%98) <{static_position = array<i64: 1>}> : (vector<4xf32>) -> f32
      %100 = "arith.addf"(%97, %99) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %101 = "spirv.Load"(%11) : (!spirv.ptr<vector<3xf32>, Function>) -> vector<3xf32>
      %102 = "vector.extract"(%101) <{static_position = array<i64: 2>}> : (vector<3xf32>) -> f32
      %103 = "spirv.Load"(%8) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %104 = "vector.extract"(%103) <{static_position = array<i64: 2>}> : (vector<4xf32>) -> f32
      %105 = "arith.addf"(%102, %104) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %106 = "spirv.Load"(%8) : (!spirv.ptr<vector<4xf32>, Function>) -> vector<4xf32>
      %107 = "vector.extract"(%106) <{static_position = array<i64: 3>}> : (vector<4xf32>) -> f32
      %108 = "arith.addf"(%105, %107) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %109 = "spirv.Load"(%5) : (!spirv.ptr<f32, Function>) -> f32
      %110 = "arith.addf"(%108, %109) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %111 = "spirv.Load"(%4) : (!spirv.ptr<i1, Function>) -> i1
      %112 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %113 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %114 = "arith.select"(%111, %112, %113) : (i1, f32, f32) -> f32
      %115 = "arith.addf"(%110, %114) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %116 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %117 = "spirv.AccessChain"(%2, %116) : (!spirv.ptr<!spirv.array<3 x f32>, Function>, i32) -> !spirv.ptr<f32, Function>
      %118 = "spirv.Load"(%117) : (!spirv.ptr<f32, Function>) -> f32
      %119 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %120 = "spirv.AccessChain"(%2, %119) : (!spirv.ptr<!spirv.array<3 x f32>, Function>, i32) -> !spirv.ptr<f32, Function>
      %121 = "spirv.Load"(%120) : (!spirv.ptr<f32, Function>) -> f32
      %122 = "arith.addf"(%118, %121) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %123 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %124 = "spirv.AccessChain"(%2, %123) : (!spirv.ptr<!spirv.array<3 x f32>, Function>, i32) -> !spirv.ptr<f32, Function>
      %125 = "spirv.Load"(%124) : (!spirv.ptr<f32, Function>) -> f32
      %126 = "arith.addf"(%122, %125) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %127 = "glsl.construct"(%92, %100, %115, %126) : (f32, f32, f32, f32) -> vector<4xf32>
      "glsl.store"(%127) <{var = @o_color}> : (vector<4xf32>) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
