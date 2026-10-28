"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> !spirv.struct<(i32, i32)>, sym_name = "umul_extended_i32"}> ({
    ^bb0(%arg18: i32, %arg19: i32):
      %148 = "spirv.Constant"() <{value = 65535 : i32}> : () -> i32
      %149 = "spirv.Constant"() <{value = 16 : i32}> : () -> i32
      %150 = "spirv.BitwiseAnd"(%arg18, %148) : (i32, i32) -> i32
      %151 = "spirv.ShiftRightLogical"(%arg18, %149) : (i32, i32) -> i32
      %152 = "spirv.BitwiseAnd"(%arg19, %148) : (i32, i32) -> i32
      %153 = "spirv.ShiftRightLogical"(%arg19, %149) : (i32, i32) -> i32
      %154 = "spirv.IMul"(%150, %152) : (i32, i32) -> i32
      %155 = "spirv.BitwiseAnd"(%154, %148) : (i32, i32) -> i32
      %156 = "spirv.ShiftRightLogical"(%154, %149) : (i32, i32) -> i32
      %157 = "spirv.IMul"(%150, %153) : (i32, i32) -> i32
      %158 = "spirv.IAdd"(%156, %157) : (i32, i32) -> i32
      %159 = "spirv.BitwiseAnd"(%158, %148) : (i32, i32) -> i32
      %160 = "spirv.ShiftRightLogical"(%158, %149) : (i32, i32) -> i32
      %161 = "spirv.IMul"(%151, %152) : (i32, i32) -> i32
      %162 = "spirv.IAdd"(%159, %161) : (i32, i32) -> i32
      %163 = "spirv.BitwiseAnd"(%162, %148) : (i32, i32) -> i32
      %164 = "spirv.ShiftRightLogical"(%162, %149) : (i32, i32) -> i32
      %165 = "spirv.IAdd"(%160, %164) : (i32, i32) -> i32
      %166 = "spirv.IMul"(%151, %153) : (i32, i32) -> i32
      %167 = "spirv.IAdd"(%165, %166) : (i32, i32) -> i32
      %168 = "spirv.BitwiseAnd"(%167, %148) : (i32, i32) -> i32
      %169 = "spirv.ShiftRightLogical"(%167, %149) : (i32, i32) -> i32
      %170 = "spirv.ShiftLeftLogical"(%163, %149) : (i32, i32) -> i32
      %171 = "spirv.BitwiseOr"(%155, %170) : (i32, i32) -> i32
      %172 = "spirv.ShiftLeftLogical"(%169, %149) : (i32, i32) -> i32
      %173 = "spirv.BitwiseOr"(%168, %172) : (i32, i32) -> i32
      %174 = "spirv.CompositeConstruct"(%171, %173) : (i32, i32) -> !spirv.struct<(i32, i32)>
      "spirv.ReturnValue"(%174) : (!spirv.struct<(i32, i32)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>, sym_name = "umul_extended_vector_i32"}> ({
    ^bb0(%arg16: vector<3xi32>, %arg17: vector<3xi32>):
      %121 = "spirv.Constant"() <{value = dense<65535> : vector<3xi32>}> : () -> vector<3xi32>
      %122 = "spirv.Constant"() <{value = dense<16> : vector<3xi32>}> : () -> vector<3xi32>
      %123 = "spirv.BitwiseAnd"(%arg16, %121) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %124 = "spirv.ShiftRightLogical"(%arg16, %122) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %125 = "spirv.BitwiseAnd"(%arg17, %121) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %126 = "spirv.ShiftRightLogical"(%arg17, %122) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %127 = "spirv.IMul"(%123, %125) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %128 = "spirv.BitwiseAnd"(%127, %121) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %129 = "spirv.ShiftRightLogical"(%127, %122) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %130 = "spirv.IMul"(%123, %126) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %131 = "spirv.IAdd"(%129, %130) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %132 = "spirv.BitwiseAnd"(%131, %121) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %133 = "spirv.ShiftRightLogical"(%131, %122) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %134 = "spirv.IMul"(%124, %125) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %135 = "spirv.IAdd"(%132, %134) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %136 = "spirv.BitwiseAnd"(%135, %121) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %137 = "spirv.ShiftRightLogical"(%135, %122) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %138 = "spirv.IAdd"(%133, %137) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %139 = "spirv.IMul"(%124, %126) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %140 = "spirv.IAdd"(%138, %139) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %141 = "spirv.BitwiseAnd"(%140, %121) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %142 = "spirv.ShiftRightLogical"(%140, %122) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %143 = "spirv.ShiftLeftLogical"(%136, %122) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %144 = "spirv.BitwiseOr"(%128, %143) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %145 = "spirv.ShiftLeftLogical"(%142, %122) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %146 = "spirv.BitwiseOr"(%141, %145) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %147 = "spirv.CompositeConstruct"(%144, %146) : (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>
      "spirv.ReturnValue"(%147) : (!spirv.struct<(vector<3xi32>, vector<3xi32>)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i16) -> !spirv.struct<(i16, i16)>, sym_name = "umul_extended_i16"}> ({
    ^bb0(%arg15: i16):
      %120 = "spirv.UMulExtended"(%arg15, %arg15) : (i16, i16) -> !spirv.struct<(i16, i16)>
      "spirv.ReturnValue"(%120) : (!spirv.struct<(i16, i16)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> !spirv.struct<(i32, i32)>, sym_name = "smul_extended_i32"}> ({
    ^bb0(%arg13: i32, %arg14: i32):
      %69 = "spirv.Constant"() <{value = 65535 : i32}> : () -> i32
      %70 = "spirv.Constant"() <{value = 16 : i32}> : () -> i32
      %71 = "spirv.BitwiseAnd"(%arg13, %69) : (i32, i32) -> i32
      %72 = "spirv.ShiftRightLogical"(%arg13, %70) : (i32, i32) -> i32
      %73 = "spirv.ShiftRightArithmetic"(%arg13, %70) : (i32, i32) -> i32
      %74 = "spirv.ShiftRightLogical"(%73, %70) : (i32, i32) -> i32
      %75 = "spirv.BitwiseAnd"(%arg14, %69) : (i32, i32) -> i32
      %76 = "spirv.ShiftRightLogical"(%arg14, %70) : (i32, i32) -> i32
      %77 = "spirv.ShiftRightArithmetic"(%arg14, %70) : (i32, i32) -> i32
      %78 = "spirv.ShiftRightLogical"(%77, %70) : (i32, i32) -> i32
      %79 = "spirv.IMul"(%71, %75) : (i32, i32) -> i32
      %80 = "spirv.BitwiseAnd"(%79, %69) : (i32, i32) -> i32
      %81 = "spirv.ShiftRightLogical"(%79, %70) : (i32, i32) -> i32
      %82 = "spirv.IMul"(%71, %76) : (i32, i32) -> i32
      %83 = "spirv.IAdd"(%81, %82) : (i32, i32) -> i32
      %84 = "spirv.BitwiseAnd"(%83, %69) : (i32, i32) -> i32
      %85 = "spirv.ShiftRightLogical"(%83, %70) : (i32, i32) -> i32
      %86 = "spirv.IMul"(%71, %78) : (i32, i32) -> i32
      %87 = "spirv.IAdd"(%85, %86) : (i32, i32) -> i32
      %88 = "spirv.BitwiseAnd"(%87, %69) : (i32, i32) -> i32
      %89 = "spirv.ShiftRightLogical"(%87, %70) : (i32, i32) -> i32
      %90 = "spirv.IAdd"(%89, %86) : (i32, i32) -> i32
      %91 = "spirv.BitwiseAnd"(%90, %69) : (i32, i32) -> i32
      %92 = "spirv.IMul"(%72, %75) : (i32, i32) -> i32
      %93 = "spirv.IAdd"(%84, %92) : (i32, i32) -> i32
      %94 = "spirv.BitwiseAnd"(%93, %69) : (i32, i32) -> i32
      %95 = "spirv.ShiftRightLogical"(%93, %70) : (i32, i32) -> i32
      %96 = "spirv.IAdd"(%88, %95) : (i32, i32) -> i32
      %97 = "spirv.IMul"(%72, %76) : (i32, i32) -> i32
      %98 = "spirv.IAdd"(%96, %97) : (i32, i32) -> i32
      %99 = "spirv.BitwiseAnd"(%98, %69) : (i32, i32) -> i32
      %100 = "spirv.ShiftRightLogical"(%98, %70) : (i32, i32) -> i32
      %101 = "spirv.IAdd"(%91, %100) : (i32, i32) -> i32
      %102 = "spirv.IMul"(%72, %78) : (i32, i32) -> i32
      %103 = "spirv.IAdd"(%101, %102) : (i32, i32) -> i32
      %104 = "spirv.BitwiseAnd"(%103, %69) : (i32, i32) -> i32
      %105 = "spirv.IMul"(%74, %75) : (i32, i32) -> i32
      %106 = "spirv.IAdd"(%99, %105) : (i32, i32) -> i32
      %107 = "spirv.BitwiseAnd"(%106, %69) : (i32, i32) -> i32
      %108 = "spirv.ShiftRightLogical"(%106, %70) : (i32, i32) -> i32
      %109 = "spirv.IAdd"(%104, %108) : (i32, i32) -> i32
      %110 = "spirv.IMul"(%74, %76) : (i32, i32) -> i32
      %111 = "spirv.IAdd"(%109, %110) : (i32, i32) -> i32
      %112 = "spirv.BitwiseAnd"(%111, %69) : (i32, i32) -> i32
      %113 = "spirv.IAdd"(%112, %105) : (i32, i32) -> i32
      %114 = "spirv.BitwiseAnd"(%113, %69) : (i32, i32) -> i32
      %115 = "spirv.ShiftLeftLogical"(%94, %70) : (i32, i32) -> i32
      %116 = "spirv.BitwiseOr"(%80, %115) : (i32, i32) -> i32
      %117 = "spirv.ShiftLeftLogical"(%114, %70) : (i32, i32) -> i32
      %118 = "spirv.BitwiseOr"(%107, %117) : (i32, i32) -> i32
      %119 = "spirv.CompositeConstruct"(%116, %118) : (i32, i32) -> !spirv.struct<(i32, i32)>
      "spirv.ReturnValue"(%119) : (!spirv.struct<(i32, i32)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>, sym_name = "smul_extended_vector_i32"}> ({
    ^bb0(%arg11: vector<3xi32>, %arg12: vector<3xi32>):
      %18 = "spirv.Constant"() <{value = dense<65535> : vector<3xi32>}> : () -> vector<3xi32>
      %19 = "spirv.Constant"() <{value = dense<16> : vector<3xi32>}> : () -> vector<3xi32>
      %20 = "spirv.BitwiseAnd"(%arg11, %18) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %21 = "spirv.ShiftRightLogical"(%arg11, %19) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %22 = "spirv.ShiftRightArithmetic"(%arg11, %19) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %23 = "spirv.ShiftRightLogical"(%22, %19) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %24 = "spirv.BitwiseAnd"(%arg12, %18) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %25 = "spirv.ShiftRightLogical"(%arg12, %19) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %26 = "spirv.ShiftRightArithmetic"(%arg12, %19) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %27 = "spirv.ShiftRightLogical"(%26, %19) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %28 = "spirv.IMul"(%20, %24) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %29 = "spirv.BitwiseAnd"(%28, %18) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %30 = "spirv.ShiftRightLogical"(%28, %19) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %31 = "spirv.IMul"(%20, %25) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %32 = "spirv.IAdd"(%30, %31) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %33 = "spirv.BitwiseAnd"(%32, %18) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %34 = "spirv.ShiftRightLogical"(%32, %19) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %35 = "spirv.IMul"(%20, %27) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %36 = "spirv.IAdd"(%34, %35) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %37 = "spirv.BitwiseAnd"(%36, %18) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %38 = "spirv.ShiftRightLogical"(%36, %19) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %39 = "spirv.IAdd"(%38, %35) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %40 = "spirv.BitwiseAnd"(%39, %18) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %41 = "spirv.IMul"(%21, %24) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %42 = "spirv.IAdd"(%33, %41) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %43 = "spirv.BitwiseAnd"(%42, %18) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %44 = "spirv.ShiftRightLogical"(%42, %19) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %45 = "spirv.IAdd"(%37, %44) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %46 = "spirv.IMul"(%21, %25) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %47 = "spirv.IAdd"(%45, %46) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %48 = "spirv.BitwiseAnd"(%47, %18) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %49 = "spirv.ShiftRightLogical"(%47, %19) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %50 = "spirv.IAdd"(%40, %49) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %51 = "spirv.IMul"(%21, %27) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %52 = "spirv.IAdd"(%50, %51) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %53 = "spirv.BitwiseAnd"(%52, %18) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %54 = "spirv.IMul"(%23, %24) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %55 = "spirv.IAdd"(%48, %54) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %56 = "spirv.BitwiseAnd"(%55, %18) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %57 = "spirv.ShiftRightLogical"(%55, %19) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %58 = "spirv.IAdd"(%53, %57) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %59 = "spirv.IMul"(%23, %25) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %60 = "spirv.IAdd"(%58, %59) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %61 = "spirv.BitwiseAnd"(%60, %18) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %62 = "spirv.IAdd"(%61, %54) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %63 = "spirv.BitwiseAnd"(%62, %18) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %64 = "spirv.ShiftLeftLogical"(%43, %19) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %65 = "spirv.BitwiseOr"(%29, %64) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %66 = "spirv.ShiftLeftLogical"(%63, %19) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %67 = "spirv.BitwiseOr"(%56, %66) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %68 = "spirv.CompositeConstruct"(%65, %67) : (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>
      "spirv.ReturnValue"(%68) : (!spirv.struct<(vector<3xi32>, vector<3xi32>)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i16) -> !spirv.struct<(i16, i16)>, sym_name = "smul_extended_i16"}> ({
    ^bb0(%arg10: i16):
      %17 = "spirv.SMulExtended"(%arg10, %arg10) : (i16, i16) -> !spirv.struct<(i16, i16)>
      "spirv.ReturnValue"(%17) : (!spirv.struct<(i16, i16)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> !spirv.struct<(i32, i32)>, sym_name = "iaddcarry_i32"}> ({
    ^bb0(%arg8: i32, %arg9: i32):
      %11 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %12 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %13 = "spirv.IAdd"(%arg8, %arg9) : (i32, i32) -> i32
      %14 = "spirv.ULessThan"(%13, %arg8) : (i32, i32) -> i1
      %15 = "spirv.Select"(%14, %11, %12) : (i1, i32, i32) -> i32
      %16 = "spirv.CompositeConstruct"(%13, %15) : (i32, i32) -> !spirv.struct<(i32, i32)>
      "spirv.ReturnValue"(%16) : (!spirv.struct<(i32, i32)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>, sym_name = "iaddcarry_vector_i32"}> ({
    ^bb0(%arg6: vector<3xi32>, %arg7: vector<3xi32>):
      %5 = "spirv.Constant"() <{value = dense<1> : vector<3xi32>}> : () -> vector<3xi32>
      %6 = "spirv.Constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
      %7 = "spirv.IAdd"(%arg6, %arg7) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %8 = "spirv.ULessThan"(%7, %arg6) : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
      %9 = "spirv.Select"(%8, %5, %6) : (vector<3xi1>, vector<3xi32>, vector<3xi32>) -> vector<3xi32>
      %10 = "spirv.CompositeConstruct"(%7, %9) : (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>
      "spirv.ReturnValue"(%10) : (!spirv.struct<(vector<3xi32>, vector<3xi32>)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i16, i16) -> !spirv.struct<(i16, i16)>, sym_name = "iaddcarry_i16"}> ({
    ^bb0(%arg4: i16, %arg5: i16):
      %4 = "spirv.IAddCarry"(%arg4, %arg5) : (i16, i16) -> !spirv.struct<(i16, i16)>
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

