"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Matrix], []>}> ({
  "spirv.GlobalVariable"() <{location = 0 : i32, sym_name = "v_uv", type = !spirv.ptr<vector<2xf32>, Input>}> : () -> ()
  "spirv.GlobalVariable"() <{location = 0 : i32, sym_name = "o_color", type = !spirv.ptr<vector<4xf32>, Output>}> : () -> ()
  "spirv.GlobalVariable"() <{built_in = "FragCoord", sym_name = "gl_FragCoord", type = !spirv.ptr<vector<4xf32>, Input>}> : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32) -> f32, sym_name = "firstOver"}> ({
  ^bb0(%arg1: f32, %arg2: f32):
    %189 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
    %190 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i32, Function>
    %191 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
    %192 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
    "spirv.Store"(%192, %arg1) : (!spirv.ptr<f32, Function>, f32) -> ()
    "spirv.Store"(%191, %arg2) : (!spirv.ptr<f32, Function>, f32) -> ()
    %193 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    "spirv.Store"(%190, %193) : (!spirv.ptr<i32, Function>, i32) -> ()
    "spirv.Branch"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb3
    %194 = "spirv.Load"(%190) : (!spirv.ptr<i32, Function>) -> i32
    %195 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
    %196 = "spirv.SLessThan"(%194, %195) : (i32, i32) -> i1
    "spirv.BranchConditional"(%196)[^bb4, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %197 = "spirv.Constant"() <{value = -1.000000e+00 : f32}> : () -> f32
    "spirv.ReturnValue"(%197) : (f32) -> ()
  ^bb3:  // pred: ^bb5
    %198 = "spirv.Load"(%190) : (!spirv.ptr<i32, Function>) -> i32
    %199 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %200 = "spirv.IAdd"(%198, %199) : (i32, i32) -> i32
    "spirv.Store"(%190, %200) : (!spirv.ptr<i32, Function>, i32) -> ()
    "spirv.Branch"()[^bb1] : () -> ()
  ^bb4:  // pred: ^bb1
    %201 = "spirv.Load"(%192) : (!spirv.ptr<f32, Function>) -> f32
    %202 = "spirv.Load"(%190) : (!spirv.ptr<i32, Function>) -> i32
    %203 = "spirv.ConvertSToF"(%202) : (i32) -> f32
    %204 = "spirv.FMul"(%201, %203) : (f32, f32) -> f32
    %205 = "spirv.Constant"() <{value = 3.700000e-01 : f32}> : () -> f32
    %206 = "spirv.FMul"(%204, %205) : (f32, f32) -> f32
    "spirv.Store"(%189, %206) : (!spirv.ptr<f32, Function>, f32) -> ()
    %207 = "spirv.Load"(%189) : (!spirv.ptr<f32, Function>) -> f32
    %208 = "spirv.Load"(%191) : (!spirv.ptr<f32, Function>) -> f32
    %209 = "spirv.FOrdGreaterThan"(%207, %208) : (f32, f32) -> i1
    "spirv.BranchConditional"(%209)[^bb6, ^bb5] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb5:  // pred: ^bb4
    "spirv.Branch"()[^bb3] : () -> ()
  ^bb6:  // pred: ^bb4
    %210 = "spirv.Load"(%189) : (!spirv.ptr<f32, Function>) -> f32
    "spirv.ReturnValue"(%210) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> f32, sym_name = "classify"}> ({
  ^bb0(%arg0: f32):
    %177 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<f32, Function>
    "spirv.Store"(%177, %arg0) : (!spirv.ptr<f32, Function>, f32) -> ()
    %178 = "spirv.Load"(%177) : (!spirv.ptr<f32, Function>) -> f32
    %179 = "spirv.Constant"() <{value = 1.000000e+01 : f32}> : () -> f32
    %180 = "spirv.FOrdLessThan"(%178, %179) : (f32, f32) -> i1
    "spirv.BranchConditional"(%180)[^bb2, ^bb1] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %181 = "spirv.Load"(%177) : (!spirv.ptr<f32, Function>) -> f32
    %182 = "spirv.Constant"() <{value = 3.000000e+01 : f32}> : () -> f32
    %183 = "spirv.FOrdLessThan"(%181, %182) : (f32, f32) -> i1
    "spirv.BranchConditional"(%183)[^bb4, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb0
    %184 = "spirv.Constant"() <{value = 2.500000e-01 : f32}> : () -> f32
    "spirv.ReturnValue"(%184) : (f32) -> ()
  ^bb3:  // pred: ^bb1
    %185 = "spirv.Load"(%177) : (!spirv.ptr<f32, Function>) -> f32
    %186 = "spirv.Constant"() <{value = 6.400000e+01 : f32}> : () -> f32
    %187 = "spirv.FDiv"(%185, %186) : (f32, f32) -> f32
    "spirv.ReturnValue"(%187) : (f32) -> ()
  ^bb4:  // pred: ^bb1
    %188 = "spirv.Constant"() <{value = 5.000000e-01 : f32}> : () -> f32
    "spirv.ReturnValue"(%188) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "main"}> ({
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
    %12 = "spirv.mlir.addressof"() <{variable = @gl_FragCoord}> : () -> !spirv.ptr<vector<4xf32>, Input>
    %13 = "spirv.Load"(%12) : (!spirv.ptr<vector<4xf32>, Input>) -> vector<4xf32>
    %14 = "spirv.VectorShuffle"(%13, %13) <{components = [0 : i32, 1 : i32]}> : (vector<4xf32>, vector<4xf32>) -> vector<2xf32>
    "spirv.Store"(%11, %14) : (!spirv.ptr<vector<2xf32>, Function>, vector<2xf32>) -> ()
    %15 = "spirv.Constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "spirv.Store"(%10, %15) : (!spirv.ptr<f32, Function>, f32) -> ()
    %16 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    "spirv.Store"(%9, %16) : (!spirv.ptr<i32, Function>, i32) -> ()
    "spirv.Branch"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb3
    %17 = "spirv.Load"(%9) : (!spirv.ptr<i32, Function>) -> i32
    %18 = "spirv.Constant"() <{value = 20 : i32}> : () -> i32
    %19 = "spirv.SLessThan"(%17, %18) : (i32, i32) -> i1
    "spirv.BranchConditional"(%19)[^bb4, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // 2 preds: ^bb1, ^bb6
    %20 = "spirv.Constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "spirv.Store"(%8, %20) : (!spirv.ptr<f32, Function>, f32) -> ()
    %21 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    "spirv.Store"(%7, %21) : (!spirv.ptr<i32, Function>, i32) -> ()
    "spirv.Branch"()[^bb7] : () -> ()
  ^bb3:  // pred: ^bb5
    %22 = "spirv.Load"(%9) : (!spirv.ptr<i32, Function>) -> i32
    %23 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %24 = "spirv.IAdd"(%22, %23) : (i32, i32) -> i32
    "spirv.Store"(%9, %24) : (!spirv.ptr<i32, Function>, i32) -> ()
    "spirv.Branch"()[^bb1] : () -> ()
  ^bb4:  // pred: ^bb1
    %25 = "spirv.Load"(%9) : (!spirv.ptr<i32, Function>) -> i32
    %26 = "spirv.ConvertSToF"(%25) : (i32) -> f32
    %27 = "spirv.Constant"() <{value = 3.000000e+00 : f32}> : () -> f32
    %28 = "spirv.FMul"(%26, %27) : (f32, f32) -> f32
    %29 = "spirv.Load"(%11) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
    %30 = "spirv.CompositeExtract"(%29) <{indices = [0 : i32]}> : (vector<2xf32>) -> f32
    %31 = "spirv.FOrdGreaterThan"(%28, %30) : (f32, f32) -> i1
    "spirv.BranchConditional"(%31)[^bb6, ^bb5] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb5:  // pred: ^bb4
    %32 = "spirv.Load"(%10) : (!spirv.ptr<f32, Function>) -> f32
    %33 = "spirv.Load"(%9) : (!spirv.ptr<i32, Function>) -> i32
    %34 = "spirv.ConvertSToF"(%33) : (i32) -> f32
    %35 = "spirv.Load"(%11) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
    %36 = "spirv.CompositeExtract"(%35) <{indices = [1 : i32]}> : (vector<2xf32>) -> f32
    %37 = "spirv.Constant"() <{value = 1.000000e-01 : f32}> : () -> f32
    %38 = "spirv.FMul"(%36, %37) : (f32, f32) -> f32
    %39 = "spirv.FAdd"(%34, %38) : (f32, f32) -> f32
    %40 = "spirv.GL.Sin"(%39) : (f32) -> f32
    %41 = "spirv.FAdd"(%32, %40) : (f32, f32) -> f32
    "spirv.Store"(%10, %41) : (!spirv.ptr<f32, Function>, f32) -> ()
    "spirv.Branch"()[^bb3] : () -> ()
  ^bb6:  // pred: ^bb4
    "spirv.Branch"()[^bb2] : () -> ()
  ^bb7:  // 2 preds: ^bb2, ^bb9
    %42 = "spirv.Load"(%7) : (!spirv.ptr<i32, Function>) -> i32
    %43 = "spirv.Constant"() <{value = 16 : i32}> : () -> i32
    %44 = "spirv.SLessThan"(%42, %43) : (i32, i32) -> i1
    "spirv.BranchConditional"(%44)[^bb10, ^bb8] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb8:  // pred: ^bb7
    %45 = "spirv.Constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "spirv.Store"(%6, %45) : (!spirv.ptr<f32, Function>, f32) -> ()
    %46 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    "spirv.Store"(%5, %46) : (!spirv.ptr<i32, Function>, i32) -> ()
    "spirv.Branch"()[^bb13] : () -> ()
  ^bb9:  // 2 preds: ^bb11, ^bb12
    "spirv.Branch"()[^bb7] : () -> ()
  ^bb10:  // pred: ^bb7
    %47 = "spirv.Load"(%7) : (!spirv.ptr<i32, Function>) -> i32
    %48 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %49 = "spirv.IAdd"(%47, %48) : (i32, i32) -> i32
    "spirv.Store"(%7, %49) : (!spirv.ptr<i32, Function>, i32) -> ()
    %50 = "spirv.Load"(%7) : (!spirv.ptr<i32, Function>) -> i32
    %51 = "spirv.GL.SAbs"(%50) : (i32) -> i32
    %52 = "spirv.Constant"() <{value = 3 : i32}> : () -> i32
    %53 = "spirv.GL.SAbs"(%52) : (i32) -> i32
    %54 = "spirv.UMod"(%51, %53) : (i32, i32) -> i32
    %55 = "spirv.IEqual"(%50, %51) : (i32, i32) -> i1
    %56 = "spirv.SNegate"(%54) : (i32) -> i32
    %57 = "spirv.Select"(%55, %54, %56) : (i1, i32, i32) -> i32
    %58 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %59 = "spirv.IEqual"(%57, %58) : (i32, i32) -> i1
    "spirv.BranchConditional"(%59)[^bb12, ^bb11] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb11:  // pred: ^bb10
    %60 = "spirv.Load"(%8) : (!spirv.ptr<f32, Function>) -> f32
    %61 = "spirv.Load"(%7) : (!spirv.ptr<i32, Function>) -> i32
    %62 = "spirv.ConvertSToF"(%61) : (i32) -> f32
    %63 = "spirv.Constant"() <{value = 1.250000e-01 : f32}> : () -> f32
    %64 = "spirv.FMul"(%62, %63) : (f32, f32) -> f32
    %65 = "spirv.FAdd"(%60, %64) : (f32, f32) -> f32
    "spirv.Store"(%8, %65) : (!spirv.ptr<f32, Function>, f32) -> ()
    "spirv.Branch"()[^bb9] : () -> ()
  ^bb12:  // pred: ^bb10
    "spirv.Branch"()[^bb9] : () -> ()
  ^bb13:  // 2 preds: ^bb8, ^bb17
    %66 = "spirv.Load"(%5) : (!spirv.ptr<i32, Function>) -> i32
    %67 = "spirv.Constant"() <{value = 8 : i32}> : () -> i32
    %68 = "spirv.SLessThan"(%66, %67) : (i32, i32) -> i1
    "spirv.BranchConditional"(%68)[^bb15, ^bb14] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb14:  // pred: ^bb13
    %69 = "spirv.Constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "spirv.Store"(%3, %69) : (!spirv.ptr<f32, Function>, f32) -> ()
    %70 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    "spirv.Store"(%2, %70) : (!spirv.ptr<i32, Function>, i32) -> ()
    "spirv.Branch"()[^bb24] : () -> ()
  ^bb15:  // pred: ^bb13
    %71 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    "spirv.Store"(%4, %71) : (!spirv.ptr<i32, Function>, i32) -> ()
    "spirv.Branch"()[^bb16] : () -> ()
  ^bb16:  // 2 preds: ^bb15, ^bb18
    %72 = "spirv.Load"(%4) : (!spirv.ptr<i32, Function>) -> i32
    %73 = "spirv.Constant"() <{value = 8 : i32}> : () -> i32
    %74 = "spirv.SLessThan"(%72, %73) : (i32, i32) -> i1
    "spirv.BranchConditional"(%74)[^bb19, ^bb17] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb17:  // 2 preds: ^bb16, ^bb21
    %75 = "spirv.Load"(%5) : (!spirv.ptr<i32, Function>) -> i32
    %76 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %77 = "spirv.IAdd"(%75, %76) : (i32, i32) -> i32
    "spirv.Store"(%5, %77) : (!spirv.ptr<i32, Function>, i32) -> ()
    "spirv.Branch"()[^bb13] : () -> ()
  ^bb18:  // 2 preds: ^bb22, ^bb23
    %78 = "spirv.Load"(%4) : (!spirv.ptr<i32, Function>) -> i32
    %79 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %80 = "spirv.IAdd"(%78, %79) : (i32, i32) -> i32
    "spirv.Store"(%4, %80) : (!spirv.ptr<i32, Function>, i32) -> ()
    "spirv.Branch"()[^bb16] : () -> ()
  ^bb19:  // pred: ^bb16
    %81 = "spirv.Load"(%4) : (!spirv.ptr<i32, Function>) -> i32
    %82 = "spirv.Load"(%5) : (!spirv.ptr<i32, Function>) -> i32
    %83 = "spirv.SGreaterThan"(%81, %82) : (i32, i32) -> i1
    "spirv.BranchConditional"(%83)[^bb21, ^bb20] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb20:  // pred: ^bb19
    %84 = "spirv.Load"(%5) : (!spirv.ptr<i32, Function>) -> i32
    %85 = "spirv.Load"(%4) : (!spirv.ptr<i32, Function>) -> i32
    %86 = "spirv.IAdd"(%84, %85) : (i32, i32) -> i32
    %87 = "spirv.GL.SAbs"(%86) : (i32) -> i32
    %88 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    %89 = "spirv.GL.SAbs"(%88) : (i32) -> i32
    %90 = "spirv.UMod"(%87, %89) : (i32, i32) -> i32
    %91 = "spirv.IEqual"(%86, %87) : (i32, i32) -> i1
    %92 = "spirv.SNegate"(%90) : (i32) -> i32
    %93 = "spirv.Select"(%91, %90, %92) : (i1, i32, i32) -> i32
    %94 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %95 = "spirv.IEqual"(%93, %94) : (i32, i32) -> i1
    "spirv.BranchConditional"(%95)[^bb23, ^bb22] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb21:  // pred: ^bb19
    "spirv.Branch"()[^bb17] : () -> ()
  ^bb22:  // pred: ^bb20
    %96 = "spirv.Load"(%6) : (!spirv.ptr<f32, Function>) -> f32
    %97 = "spirv.Constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %98 = "spirv.FAdd"(%96, %97) : (f32, f32) -> f32
    "spirv.Store"(%6, %98) : (!spirv.ptr<f32, Function>, f32) -> ()
    "spirv.Branch"()[^bb18] : () -> ()
  ^bb23:  // pred: ^bb20
    "spirv.Branch"()[^bb18] : () -> ()
  ^bb24:  // 2 preds: ^bb14, ^bb26
    "spirv.Branch"()[^bb27] : () -> ()
  ^bb25:  // 2 preds: ^bb28, ^bb29
    %99 = "spirv.Constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "spirv.Store"(%1, %99) : (!spirv.ptr<f32, Function>, f32) -> ()
    %100 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    "spirv.Store"(%0, %100) : (!spirv.ptr<i32, Function>, i32) -> ()
    "spirv.Branch"()[^bb30] : () -> ()
  ^bb26:  // 2 preds: ^bb28, ^bb29
    "spirv.Branch"()[^bb24] : () -> ()
  ^bb27:  // pred: ^bb24
    %101 = "spirv.Load"(%2) : (!spirv.ptr<i32, Function>) -> i32
    %102 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %103 = "spirv.IAdd"(%101, %102) : (i32, i32) -> i32
    "spirv.Store"(%2, %103) : (!spirv.ptr<i32, Function>, i32) -> ()
    %104 = "spirv.Load"(%2) : (!spirv.ptr<i32, Function>) -> i32
    %105 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    %106 = "spirv.IEqual"(%104, %105) : (i32, i32) -> i1
    "spirv.BranchConditional"(%106)[^bb29, ^bb28] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb28:  // pred: ^bb27
    %107 = "spirv.Load"(%3) : (!spirv.ptr<f32, Function>) -> f32
    %108 = "spirv.Load"(%11) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
    %109 = "spirv.CompositeExtract"(%108) <{indices = [0 : i32]}> : (vector<2xf32>) -> f32
    %110 = "spirv.Constant"() <{value = 0.00999999977 : f32}> : () -> f32
    %111 = "spirv.FMul"(%109, %110) : (f32, f32) -> f32
    %112 = "spirv.FAdd"(%107, %111) : (f32, f32) -> f32
    "spirv.Store"(%3, %112) : (!spirv.ptr<f32, Function>, f32) -> ()
    %113 = "spirv.Load"(%2) : (!spirv.ptr<i32, Function>) -> i32
    %114 = "spirv.Constant"() <{value = 5 : i32}> : () -> i32
    %115 = "spirv.SLessThan"(%113, %114) : (i32, i32) -> i1
    "spirv.BranchConditional"(%115)[^bb26, ^bb25] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb29:  // pred: ^bb27
    %116 = "spirv.Load"(%2) : (!spirv.ptr<i32, Function>) -> i32
    %117 = "spirv.Constant"() <{value = 5 : i32}> : () -> i32
    %118 = "spirv.SLessThan"(%116, %117) : (i32, i32) -> i1
    "spirv.BranchConditional"(%118)[^bb26, ^bb25] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb30:  // 2 preds: ^bb25, ^bb32
    %119 = "spirv.Load"(%0) : (!spirv.ptr<i32, Function>) -> i32
    %120 = "spirv.Constant"() <{value = 16 : i32}> : () -> i32
    %121 = "spirv.SLessThan"(%119, %120) : (i32, i32) -> i1
    "spirv.BranchConditional"(%121)[^bb33, ^bb31] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb31:  // 2 preds: ^bb30, ^bb35
    %122 = "spirv.Load"(%11) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
    %123 = "spirv.CompositeExtract"(%122) <{indices = [1 : i32]}> : (vector<2xf32>) -> f32
    %124 = "spirv.Constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    %125 = "spirv.FOrdLessThan"(%123, %124) : (f32, f32) -> i1
    "spirv.BranchConditional"(%125)[^bb37, ^bb36] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb32:  // pred: ^bb34
    %126 = "spirv.Load"(%0) : (!spirv.ptr<i32, Function>) -> i32
    %127 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %128 = "spirv.IAdd"(%126, %127) : (i32, i32) -> i32
    "spirv.Store"(%0, %128) : (!spirv.ptr<i32, Function>, i32) -> ()
    "spirv.Branch"()[^bb30] : () -> ()
  ^bb33:  // pred: ^bb30
    %129 = "spirv.Load"(%0) : (!spirv.ptr<i32, Function>) -> i32
    %130 = "spirv.Load"(%11) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
    %131 = "spirv.CompositeExtract"(%130) <{indices = [0 : i32]}> : (vector<2xf32>) -> f32
    %132 = "spirv.ConvertFToS"(%131) : (f32) -> i32
    %133 = "spirv.GL.SAbs"(%132) : (i32) -> i32
    %134 = "spirv.Constant"() <{value = 7 : i32}> : () -> i32
    %135 = "spirv.GL.SAbs"(%134) : (i32) -> i32
    %136 = "spirv.UMod"(%133, %135) : (i32, i32) -> i32
    %137 = "spirv.IEqual"(%132, %133) : (i32, i32) -> i1
    %138 = "spirv.SNegate"(%136) : (i32) -> i32
    %139 = "spirv.Select"(%137, %136, %138) : (i1, i32, i32) -> i32
    %140 = "spirv.Constant"() <{value = 3 : i32}> : () -> i32
    %141 = "spirv.IAdd"(%139, %140) : (i32, i32) -> i32
    %142 = "spirv.IEqual"(%129, %141) : (i32, i32) -> i1
    "spirv.BranchConditional"(%142)[^bb35, ^bb34] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb34:  // pred: ^bb33
    %143 = "spirv.Load"(%1) : (!spirv.ptr<f32, Function>) -> f32
    %144 = "spirv.Load"(%0) : (!spirv.ptr<i32, Function>) -> i32
    %145 = "spirv.ConvertSToF"(%144) : (i32) -> f32
    %146 = "spirv.Constant"() <{value = 5.000000e-01 : f32}> : () -> f32
    %147 = "spirv.FMul"(%145, %146) : (f32, f32) -> f32
    %148 = "spirv.FAdd"(%143, %147) : (f32, f32) -> f32
    "spirv.Store"(%1, %148) : (!spirv.ptr<f32, Function>, f32) -> ()
    "spirv.Branch"()[^bb32] : () -> ()
  ^bb35:  // pred: ^bb33
    "spirv.Branch"()[^bb31] : () -> ()
  ^bb36:  // pred: ^bb31
    %149 = "spirv.Load"(%10) : (!spirv.ptr<f32, Function>) -> f32
    %150 = "spirv.Load"(%11) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
    %151 = "spirv.CompositeExtract"(%150) <{indices = [0 : i32]}> : (vector<2xf32>) -> f32
    %152 = "spirv.Constant"() <{value = 2.000000e+01 : f32}> : () -> f32
    %153 = "spirv.FunctionCall"(%151, %152) <{callee = @firstOver}> : (f32, f32) -> f32
    %154 = "spirv.FAdd"(%149, %153) : (f32, f32) -> f32
    %155 = "spirv.Load"(%8) : (!spirv.ptr<f32, Function>) -> f32
    %156 = "spirv.Load"(%6) : (!spirv.ptr<f32, Function>) -> f32
    %157 = "spirv.FAdd"(%155, %156) : (f32, f32) -> f32
    %158 = "spirv.Load"(%3) : (!spirv.ptr<f32, Function>) -> f32
    %159 = "spirv.Load"(%11) : (!spirv.ptr<vector<2xf32>, Function>) -> vector<2xf32>
    %160 = "spirv.CompositeExtract"(%159) <{indices = [1 : i32]}> : (vector<2xf32>) -> f32
    %161 = "spirv.FunctionCall"(%160) <{callee = @classify}> : (f32) -> f32
    %162 = "spirv.FAdd"(%158, %161) : (f32, f32) -> f32
    %163 = "spirv.Load"(%10) : (!spirv.ptr<f32, Function>) -> f32
    %164 = "spirv.Load"(%8) : (!spirv.ptr<f32, Function>) -> f32
    %165 = "spirv.FMul"(%163, %164) : (f32, f32) -> f32
    %166 = "spirv.GL.Fract"(%165) : (f32) -> f32
    %167 = "spirv.Load"(%1) : (!spirv.ptr<f32, Function>) -> f32
    %168 = "spirv.FAdd"(%166, %167) : (f32, f32) -> f32
    %169 = "spirv.CompositeConstruct"(%154, %157, %162, %168) : (f32, f32, f32, f32) -> vector<4xf32>
    %170 = "spirv.mlir.addressof"() <{variable = @o_color}> : () -> !spirv.ptr<vector<4xf32>, Output>
    "spirv.Store"(%170, %169) : (!spirv.ptr<vector<4xf32>, Output>, vector<4xf32>) -> ()
    "spirv.Return"() : () -> ()
  ^bb37:  // pred: ^bb31
    %171 = "spirv.Constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %172 = "spirv.Constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %173 = "spirv.Constant"() <{value = 5.000000e-01 : f32}> : () -> f32
    %174 = "spirv.Constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %175 = "spirv.CompositeConstruct"(%171, %172, %173, %174) : (f32, f32, f32, f32) -> vector<4xf32>
    %176 = "spirv.mlir.addressof"() <{variable = @o_color}> : () -> !spirv.ptr<vector<4xf32>, Output>
    "spirv.Store"(%176, %175) : (!spirv.ptr<vector<4xf32>, Output>, vector<4xf32>) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<Fragment>, fn = @main, interface = [@v_uv, @o_color, @gl_FragCoord]}> : () -> ()
  "spirv.ExecutionMode"() <{execution_mode = #spirv.execution_mode<OriginLowerLeft>, fn = @main, values = []}> : () -> ()
}) : () -> ()