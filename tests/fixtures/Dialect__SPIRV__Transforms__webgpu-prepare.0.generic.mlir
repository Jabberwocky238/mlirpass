"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> !spirv.struct<(i32, i32)>, sym_name = "umul_extended_i32"}> ({
    ^bb0(%arg24: i32, %arg25: i32):
      %161 = "spirv.Constant"() <{value = 65535 : i32}> : () -> i32
      %162 = "spirv.Constant"() <{value = 16 : i32}> : () -> i32
      %163 = "spirv.BitwiseAnd"(%arg24, %161) : (i32, i32) -> i32
      %164 = "spirv.ShiftRightLogical"(%arg24, %162) : (i32, i32) -> i32
      %165 = "spirv.BitwiseAnd"(%arg25, %161) : (i32, i32) -> i32
      %166 = "spirv.ShiftRightLogical"(%arg25, %162) : (i32, i32) -> i32
      %167 = "spirv.IMul"(%163, %165) : (i32, i32) -> i32
      %168 = "spirv.BitwiseAnd"(%167, %161) : (i32, i32) -> i32
      %169 = "spirv.ShiftRightLogical"(%167, %162) : (i32, i32) -> i32
      %170 = "spirv.IMul"(%163, %166) : (i32, i32) -> i32
      %171 = "spirv.IAdd"(%169, %170) : (i32, i32) -> i32
      %172 = "spirv.BitwiseAnd"(%171, %161) : (i32, i32) -> i32
      %173 = "spirv.ShiftRightLogical"(%171, %162) : (i32, i32) -> i32
      %174 = "spirv.IMul"(%164, %165) : (i32, i32) -> i32
      %175 = "spirv.IAdd"(%172, %174) : (i32, i32) -> i32
      %176 = "spirv.BitwiseAnd"(%175, %161) : (i32, i32) -> i32
      %177 = "spirv.ShiftRightLogical"(%175, %162) : (i32, i32) -> i32
      %178 = "spirv.IAdd"(%173, %177) : (i32, i32) -> i32
      %179 = "spirv.IMul"(%164, %166) : (i32, i32) -> i32
      %180 = "spirv.IAdd"(%178, %179) : (i32, i32) -> i32
      %181 = "spirv.BitwiseAnd"(%180, %161) : (i32, i32) -> i32
      %182 = "spirv.ShiftRightLogical"(%180, %162) : (i32, i32) -> i32
      %183 = "spirv.ShiftLeftLogical"(%176, %162) : (i32, i32) -> i32
      %184 = "spirv.BitwiseOr"(%168, %183) : (i32, i32) -> i32
      %185 = "spirv.ShiftLeftLogical"(%182, %162) : (i32, i32) -> i32
      %186 = "spirv.BitwiseOr"(%181, %185) : (i32, i32) -> i32
      %187 = "spirv.CompositeConstruct"(%184, %186) : (i32, i32) -> !spirv.struct<(i32, i32)>
      "spirv.ReturnValue"(%187) : (!spirv.struct<(i32, i32)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>, sym_name = "umul_extended_vector_i32"}> ({
    ^bb0(%arg22: vector<3xi32>, %arg23: vector<3xi32>):
      %134 = "spirv.Constant"() <{value = dense<65535> : vector<3xi32>}> : () -> vector<3xi32>
      %135 = "spirv.Constant"() <{value = dense<16> : vector<3xi32>}> : () -> vector<3xi32>
      %136 = "spirv.BitwiseAnd"(%arg22, %134) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %137 = "spirv.ShiftRightLogical"(%arg22, %135) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %138 = "spirv.BitwiseAnd"(%arg23, %134) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %139 = "spirv.ShiftRightLogical"(%arg23, %135) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %140 = "spirv.IMul"(%136, %138) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %141 = "spirv.BitwiseAnd"(%140, %134) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %142 = "spirv.ShiftRightLogical"(%140, %135) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %143 = "spirv.IMul"(%136, %139) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %144 = "spirv.IAdd"(%142, %143) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %145 = "spirv.BitwiseAnd"(%144, %134) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %146 = "spirv.ShiftRightLogical"(%144, %135) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %147 = "spirv.IMul"(%137, %138) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %148 = "spirv.IAdd"(%145, %147) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %149 = "spirv.BitwiseAnd"(%148, %134) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %150 = "spirv.ShiftRightLogical"(%148, %135) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %151 = "spirv.IAdd"(%146, %150) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %152 = "spirv.IMul"(%137, %139) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %153 = "spirv.IAdd"(%151, %152) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %154 = "spirv.BitwiseAnd"(%153, %134) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %155 = "spirv.ShiftRightLogical"(%153, %135) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %156 = "spirv.ShiftLeftLogical"(%149, %135) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %157 = "spirv.BitwiseOr"(%141, %156) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %158 = "spirv.ShiftLeftLogical"(%155, %135) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %159 = "spirv.BitwiseOr"(%154, %158) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %160 = "spirv.CompositeConstruct"(%157, %159) : (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>
      "spirv.ReturnValue"(%160) : (!spirv.struct<(vector<3xi32>, vector<3xi32>)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i16) -> !spirv.struct<(i16, i16)>, sym_name = "umul_extended_i16"}> ({
    ^bb0(%arg21: i16):
      %133 = "spirv.UMulExtended"(%arg21, %arg21) : (i16, i16) -> !spirv.struct<(i16, i16)>
      "spirv.ReturnValue"(%133) : (!spirv.struct<(i16, i16)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> !spirv.struct<(i32, i32)>, sym_name = "smul_extended_i32"}> ({
    ^bb0(%arg19: i32, %arg20: i32):
      %82 = "spirv.Constant"() <{value = 65535 : i32}> : () -> i32
      %83 = "spirv.Constant"() <{value = 16 : i32}> : () -> i32
      %84 = "spirv.BitwiseAnd"(%arg19, %82) : (i32, i32) -> i32
      %85 = "spirv.ShiftRightLogical"(%arg19, %83) : (i32, i32) -> i32
      %86 = "spirv.ShiftRightArithmetic"(%arg19, %83) : (i32, i32) -> i32
      %87 = "spirv.ShiftRightLogical"(%86, %83) : (i32, i32) -> i32
      %88 = "spirv.BitwiseAnd"(%arg20, %82) : (i32, i32) -> i32
      %89 = "spirv.ShiftRightLogical"(%arg20, %83) : (i32, i32) -> i32
      %90 = "spirv.ShiftRightArithmetic"(%arg20, %83) : (i32, i32) -> i32
      %91 = "spirv.ShiftRightLogical"(%90, %83) : (i32, i32) -> i32
      %92 = "spirv.IMul"(%84, %88) : (i32, i32) -> i32
      %93 = "spirv.BitwiseAnd"(%92, %82) : (i32, i32) -> i32
      %94 = "spirv.ShiftRightLogical"(%92, %83) : (i32, i32) -> i32
      %95 = "spirv.IMul"(%84, %89) : (i32, i32) -> i32
      %96 = "spirv.IAdd"(%94, %95) : (i32, i32) -> i32
      %97 = "spirv.BitwiseAnd"(%96, %82) : (i32, i32) -> i32
      %98 = "spirv.ShiftRightLogical"(%96, %83) : (i32, i32) -> i32
      %99 = "spirv.IMul"(%84, %91) : (i32, i32) -> i32
      %100 = "spirv.IAdd"(%98, %99) : (i32, i32) -> i32
      %101 = "spirv.BitwiseAnd"(%100, %82) : (i32, i32) -> i32
      %102 = "spirv.ShiftRightLogical"(%100, %83) : (i32, i32) -> i32
      %103 = "spirv.IAdd"(%102, %99) : (i32, i32) -> i32
      %104 = "spirv.BitwiseAnd"(%103, %82) : (i32, i32) -> i32
      %105 = "spirv.IMul"(%85, %88) : (i32, i32) -> i32
      %106 = "spirv.IAdd"(%97, %105) : (i32, i32) -> i32
      %107 = "spirv.BitwiseAnd"(%106, %82) : (i32, i32) -> i32
      %108 = "spirv.ShiftRightLogical"(%106, %83) : (i32, i32) -> i32
      %109 = "spirv.IAdd"(%101, %108) : (i32, i32) -> i32
      %110 = "spirv.IMul"(%85, %89) : (i32, i32) -> i32
      %111 = "spirv.IAdd"(%109, %110) : (i32, i32) -> i32
      %112 = "spirv.BitwiseAnd"(%111, %82) : (i32, i32) -> i32
      %113 = "spirv.ShiftRightLogical"(%111, %83) : (i32, i32) -> i32
      %114 = "spirv.IAdd"(%104, %113) : (i32, i32) -> i32
      %115 = "spirv.IMul"(%85, %91) : (i32, i32) -> i32
      %116 = "spirv.IAdd"(%114, %115) : (i32, i32) -> i32
      %117 = "spirv.BitwiseAnd"(%116, %82) : (i32, i32) -> i32
      %118 = "spirv.IMul"(%87, %88) : (i32, i32) -> i32
      %119 = "spirv.IAdd"(%112, %118) : (i32, i32) -> i32
      %120 = "spirv.BitwiseAnd"(%119, %82) : (i32, i32) -> i32
      %121 = "spirv.ShiftRightLogical"(%119, %83) : (i32, i32) -> i32
      %122 = "spirv.IAdd"(%117, %121) : (i32, i32) -> i32
      %123 = "spirv.IMul"(%87, %89) : (i32, i32) -> i32
      %124 = "spirv.IAdd"(%122, %123) : (i32, i32) -> i32
      %125 = "spirv.BitwiseAnd"(%124, %82) : (i32, i32) -> i32
      %126 = "spirv.IAdd"(%125, %118) : (i32, i32) -> i32
      %127 = "spirv.BitwiseAnd"(%126, %82) : (i32, i32) -> i32
      %128 = "spirv.ShiftLeftLogical"(%107, %83) : (i32, i32) -> i32
      %129 = "spirv.BitwiseOr"(%93, %128) : (i32, i32) -> i32
      %130 = "spirv.ShiftLeftLogical"(%127, %83) : (i32, i32) -> i32
      %131 = "spirv.BitwiseOr"(%120, %130) : (i32, i32) -> i32
      %132 = "spirv.CompositeConstruct"(%129, %131) : (i32, i32) -> !spirv.struct<(i32, i32)>
      "spirv.ReturnValue"(%132) : (!spirv.struct<(i32, i32)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>, sym_name = "smul_extended_vector_i32"}> ({
    ^bb0(%arg17: vector<3xi32>, %arg18: vector<3xi32>):
      %31 = "spirv.Constant"() <{value = dense<65535> : vector<3xi32>}> : () -> vector<3xi32>
      %32 = "spirv.Constant"() <{value = dense<16> : vector<3xi32>}> : () -> vector<3xi32>
      %33 = "spirv.BitwiseAnd"(%arg17, %31) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %34 = "spirv.ShiftRightLogical"(%arg17, %32) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %35 = "spirv.ShiftRightArithmetic"(%arg17, %32) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %36 = "spirv.ShiftRightLogical"(%35, %32) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %37 = "spirv.BitwiseAnd"(%arg18, %31) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %38 = "spirv.ShiftRightLogical"(%arg18, %32) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %39 = "spirv.ShiftRightArithmetic"(%arg18, %32) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %40 = "spirv.ShiftRightLogical"(%39, %32) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %41 = "spirv.IMul"(%33, %37) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %42 = "spirv.BitwiseAnd"(%41, %31) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %43 = "spirv.ShiftRightLogical"(%41, %32) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %44 = "spirv.IMul"(%33, %38) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %45 = "spirv.IAdd"(%43, %44) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %46 = "spirv.BitwiseAnd"(%45, %31) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %47 = "spirv.ShiftRightLogical"(%45, %32) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %48 = "spirv.IMul"(%33, %40) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %49 = "spirv.IAdd"(%47, %48) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %50 = "spirv.BitwiseAnd"(%49, %31) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %51 = "spirv.ShiftRightLogical"(%49, %32) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %52 = "spirv.IAdd"(%51, %48) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %53 = "spirv.BitwiseAnd"(%52, %31) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %54 = "spirv.IMul"(%34, %37) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %55 = "spirv.IAdd"(%46, %54) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %56 = "spirv.BitwiseAnd"(%55, %31) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %57 = "spirv.ShiftRightLogical"(%55, %32) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %58 = "spirv.IAdd"(%50, %57) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %59 = "spirv.IMul"(%34, %38) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %60 = "spirv.IAdd"(%58, %59) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %61 = "spirv.BitwiseAnd"(%60, %31) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %62 = "spirv.ShiftRightLogical"(%60, %32) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %63 = "spirv.IAdd"(%53, %62) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %64 = "spirv.IMul"(%34, %40) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %65 = "spirv.IAdd"(%63, %64) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %66 = "spirv.BitwiseAnd"(%65, %31) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %67 = "spirv.IMul"(%36, %37) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %68 = "spirv.IAdd"(%61, %67) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %69 = "spirv.BitwiseAnd"(%68, %31) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %70 = "spirv.ShiftRightLogical"(%68, %32) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %71 = "spirv.IAdd"(%66, %70) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %72 = "spirv.IMul"(%36, %38) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %73 = "spirv.IAdd"(%71, %72) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %74 = "spirv.BitwiseAnd"(%73, %31) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %75 = "spirv.IAdd"(%74, %67) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %76 = "spirv.BitwiseAnd"(%75, %31) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %77 = "spirv.ShiftLeftLogical"(%56, %32) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %78 = "spirv.BitwiseOr"(%42, %77) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %79 = "spirv.ShiftLeftLogical"(%76, %32) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %80 = "spirv.BitwiseOr"(%69, %79) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %81 = "spirv.CompositeConstruct"(%78, %80) : (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>
      "spirv.ReturnValue"(%81) : (!spirv.struct<(vector<3xi32>, vector<3xi32>)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i16) -> !spirv.struct<(i16, i16)>, sym_name = "smul_extended_i16"}> ({
    ^bb0(%arg16: i16):
      %30 = "spirv.SMulExtended"(%arg16, %arg16) : (i16, i16) -> !spirv.struct<(i16, i16)>
      "spirv.ReturnValue"(%30) : (!spirv.struct<(i16, i16)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> !spirv.struct<(i32, i32)>, sym_name = "iaddcarry_i32"}> ({
    ^bb0(%arg14: i32, %arg15: i32):
      %24 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %25 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %26 = "spirv.IAdd"(%arg14, %arg15) : (i32, i32) -> i32
      %27 = "spirv.ULessThan"(%26, %arg14) : (i32, i32) -> i1
      %28 = "spirv.Select"(%27, %24, %25) : (i1, i32, i32) -> i32
      %29 = "spirv.CompositeConstruct"(%26, %28) : (i32, i32) -> !spirv.struct<(i32, i32)>
      "spirv.ReturnValue"(%29) : (!spirv.struct<(i32, i32)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>, sym_name = "iaddcarry_vector_i32"}> ({
    ^bb0(%arg12: vector<3xi32>, %arg13: vector<3xi32>):
      %18 = "spirv.Constant"() <{value = dense<1> : vector<3xi32>}> : () -> vector<3xi32>
      %19 = "spirv.Constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
      %20 = "spirv.IAdd"(%arg12, %arg13) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %21 = "spirv.ULessThan"(%20, %arg12) : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
      %22 = "spirv.Select"(%21, %18, %19) : (vector<3xi1>, vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %23 = "spirv.CompositeConstruct"(%20, %22) : (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>
      "spirv.ReturnValue"(%23) : (!spirv.struct<(vector<3xi32>, vector<3xi32>)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i16, i16) -> !spirv.struct<(i16, i16)>, sym_name = "iaddcarry_i16"}> ({
    ^bb0(%arg10: i16, %arg11: i16):
      %17 = "spirv.IAddCarry"(%arg10, %arg11) : (i16, i16) -> !spirv.struct<(i16, i16)>
      "spirv.ReturnValue"(%17) : (!spirv.struct<(i16, i16)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> !spirv.struct<(i32, i32)>, sym_name = "isubborrow_i32"}> ({
    ^bb0(%arg8: i32, %arg9: i32):
      %11 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %12 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %13 = "spirv.ISub"(%arg8, %arg9) : (i32, i32) -> i32
      %14 = "spirv.ULessThan"(%arg8, %arg9) : (i32, i32) -> i1
      %15 = "spirv.Select"(%14, %11, %12) : (i1, i32, i32) -> i32
      %16 = "spirv.CompositeConstruct"(%13, %15) : (i32, i32) -> !spirv.struct<(i32, i32)>
      "spirv.ReturnValue"(%16) : (!spirv.struct<(i32, i32)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>, sym_name = "isubborrow_vector_i32"}> ({
    ^bb0(%arg6: vector<3xi32>, %arg7: vector<3xi32>):
      %5 = "spirv.Constant"() <{value = dense<1> : vector<3xi32>}> : () -> vector<3xi32>
      %6 = "spirv.Constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
      %7 = "spirv.ISub"(%arg6, %arg7) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %8 = "spirv.ULessThan"(%arg6, %arg7) : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
      %9 = "spirv.Select"(%8, %5, %6) : (vector<3xi1>, vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %10 = "spirv.CompositeConstruct"(%7, %9) : (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>
      "spirv.ReturnValue"(%10) : (!spirv.struct<(vector<3xi32>, vector<3xi32>)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i16, i16) -> !spirv.struct<(i16, i16)>, sym_name = "isubborrow_i16"}> ({
    ^bb0(%arg4: i16, %arg5: i16):
      %4 = "spirv.ISubBorrow"(%arg4, %arg5) : (i16, i16) -> !spirv.struct<(i16, i16)>
      "spirv.ReturnValue"(%4) : (!spirv.struct<(i16, i16)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> i1, sym_name = "is_inf_f32"}> ({
    ^bb0(%arg3: f32):
      %3 = "spirv.Constant"() <{value = false}> : () -> i1
      "spirv.ReturnValue"(%3) : (i1) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xf32>) -> vector<4xi1>, sym_name = "is_inf_4xf32"}> ({
    ^bb0(%arg2: vector<4xf32>):
      %2 = "spirv.Constant"() <{value = dense<false> : vector<4xi1>}> : () -> vector<4xi1>
      "spirv.ReturnValue"(%2) : (vector<4xi1>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> i1, sym_name = "is_nan_f32"}> ({
    ^bb0(%arg1: f32):
      %1 = "spirv.Constant"() <{value = false}> : () -> i1
      "spirv.ReturnValue"(%1) : (i1) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xf32>) -> vector<4xi1>, sym_name = "is_nan_4xf32"}> ({
    ^bb0(%arg0: vector<4xf32>):
      %0 = "spirv.Constant"() <{value = dense<false> : vector<4xi1>}> : () -> vector<4xi1>
      "spirv.ReturnValue"(%0) : (vector<4xi1>) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

